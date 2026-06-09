-- Schema for Domain: product | Business: Pharmaceuticals | Version: v1_ecm
-- Generated on: 2026-05-05 17:50:36

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `pharmaceuticals_ecm`.`product` COMMENT 'Authoritative catalog and lifecycle management for all pharmaceutical products including branded drugs, generics, biosimilars, vaccines, and consumer health products. Manages product hierarchies, drug substance/drug product definitions, finished dosage forms (FDF), SKUs, NDC codes, ATC classifications, international nonproprietary names (INN), USAN, formulations, strengths, dosage forms, packaging configurations, and regulatory identifiers. Serves as the master product catalog referenced by manufacturing, commercial, regulatory, and supply chain domains.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`product`.`medicinal_product` (
    `medicinal_product_id` BIGINT COMMENT 'Unique identifier for the medicinal product. Primary key for this entity.',
    `atc_classification_id` BIGINT COMMENT 'Foreign key linking to masterdata.atc_classification. Business justification: Products classified by ATC for therapeutic categorization, formulary management, pharmacoepidemiology, reimbursement. Replaces denormalized atc_code string with FK to ATC master for hierarchical analy',
    `drug_product_id` BIGINT COMMENT 'Foreign key linking to product.drug_product. Business justification: medicinal_product is the high-level commercial/regulatory entity (the authorized product with brand name, regulatory approvals, market authorizations), while drug_product is the physical finished dosa',
    `inn_registry_id` BIGINT COMMENT 'Foreign key linking to masterdata.inn_registry. Business justification: Products linked to INN for international nomenclature, regulatory harmonization (IDMP), scientific communication. Replaces denormalized inn string with FK to INN registry for standardized substance id',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to masterdata.legal_entity. Business justification: Marketing Authorization Holder (MAH) is regulatory requirement for all marketed medicines. Tracks legal entity responsible for product registration, pharmacovigilance, regulatory compliance per jurisd',
    `masterdata_ndc_code_id` BIGINT COMMENT 'Foreign key linking to masterdata.ndc_code. Business justification: Medicinal products in US market reference NDC for regulatory compliance (FDA product listing), reimbursement (billing codes), distribution (supply chain tracking). Enables NDC-level regulatory intelli',
    `patent_family_id` BIGINT COMMENT 'Foreign key linking to intellectual.patent_family. Business justification: Product-level patent family tracking enables portfolio-wide IP strategy, multi-jurisdiction LOE forecasting, competitive intelligence, and integrated patent estate management across global markets.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Product manager accountability for lifecycle management, regulatory submissions, launch planning, and strategic decisions. Essential for portfolio management reporting and regulatory inspection readin',
    `reference_product_id` BIGINT COMMENT 'For biosimilar products only: the medicinal_product_id of the reference biologic (originator product) to which this biosimilar has demonstrated similarity. Null for non-biosimilar products.',
    `country_id` BIGINT COMMENT 'Foreign key linking to masterdata.country. Business justification: Products registered in specific countries/markets for regulatory compliance (market authorization tracking), commercial operations (launch planning), pharmacovigilance (country-specific safety reporti',
    `therapeutic_area_id` BIGINT COMMENT 'Foreign key linking to product.therapeutic_area. Business justification: medicinal_product has therapeutic_area as a STRING attribute that should reference the therapeutic_area master table for standardized classification.',
    `trademark_id` BIGINT COMMENT 'Foreign key linking to intellectual.trademark. Business justification: Every marketed product requires trademark protection linkage for brand management, regulatory submissions (proprietary name approval), commercial operations, and trademark enforcement/watch services.',
    `unit_of_measure_id` BIGINT COMMENT 'Foreign key linking to masterdata.unit_of_measure. Business justification: Products have base UOM for inventory management (stock keeping unit), dosing calculations (DDD), regulatory filings (strength specifications). Enables UOM standardization across systems, inventory val',
    `analytical_similarity_outcome` STRING COMMENT 'For biosimilar products only: the outcome of the analytical similarity assessment comparing the biosimilar to the reference product across structural, functional, and physicochemical characteristics. Not Applicable for non-biosimilar products.. Valid values are `Highly Similar|Similar with Minor Differences|Not Similar|Not Applicable`',
    `controlled_substance_schedule` STRING COMMENT 'The DEA controlled substance schedule classification if the medicinal product contains a controlled substance (Schedule I through V). Not Controlled if the product does not contain controlled substances.. Valid values are `Schedule I|Schedule II|Schedule III|Schedule IV|Schedule V|Not Controlled`',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this medicinal product record was first created in the master product catalog system.',
    `development_stage` STRING COMMENT 'The current stage of the medicinal product in the drug development lifecycle, from Discovery through Preclinical, Clinical Phases (I, II, III), Regulatory Submission (NDA/BLA/MAA), Approval, Launch, or Discontinuation. [ENUM-REF-CANDIDATE: Discovery|Preclinical|Phase I|Phase II|Phase III|NDA Submitted|BLA Submitted|MAA Submitted|Approved|Launched|Discontinued — promote to reference product]',
    `discontinuation_date` DATE COMMENT 'The date on which the medicinal product was discontinued or withdrawn from the market. Null if the product is still active.',
    `discontinuation_reason` STRING COMMENT 'The primary reason for discontinuation or withdrawal of the medicinal product from the market. Not Applicable if the product is still active.. Valid values are `Safety Concerns|Commercial Decision|Manufacturing Issues|Regulatory Action|Patent Expiry|Not Applicable`',
    `exclusivity_expiry_date` DATE COMMENT 'The date on which regulatory exclusivity periods (e.g., NCE exclusivity, orphan exclusivity, pediatric exclusivity, biologics exclusivity) expire, preventing approval of competing products.',
    `extrapolation_status` STRING COMMENT 'For biosimilar products only: indicates the extent to which clinical data from one indication of the reference product has been extrapolated to support approval for other indications of the biosimilar. Not Applicable for non-biosimilar products.. Valid values are `Full Extrapolation|Partial Extrapolation|No Extrapolation|Not Applicable`',
    `first_approval_date` DATE COMMENT 'The date on which the medicinal product received its first regulatory approval from any major regulatory authority (FDA, EMA, PMDA, etc.).',
    `interchangeability_designation` STRING COMMENT 'For biosimilar products only: indicates whether the FDA has designated this biosimilar as interchangeable with the reference product, allowing automatic substitution at the pharmacy level. Not Applicable for non-biosimilar products.. Valid values are `Interchangeable|Not Interchangeable|Not Applicable`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this medicinal product record was most recently updated in the master product catalog system.',
    `launch_date` DATE COMMENT 'The date on which the medicinal product was first made commercially available in any market.',
    `lifecycle_status` STRING COMMENT 'The current operational lifecycle status of the medicinal product in the master product catalog: Active (available for manufacturing/commercial operations), Inactive (not currently marketed), Withdrawn (removed from market), Suspended (temporarily halted), or Under Review (regulatory or quality hold).. Valid values are `Active|Inactive|Withdrawn|Suspended|Under Review`',
    `moa` STRING COMMENT 'The biochemical or physiological mechanism by which the medicinal product produces its therapeutic effect (e.g., TNF-alpha inhibitor, PD-1 inhibitor, HMG-CoA reductase inhibitor).',
    `originator_bla_number` STRING COMMENT 'For biosimilar products only: the FDA BLA number of the reference biologic product (e.g., BLA125057 for Humira). Null for non-biosimilar products.. Valid values are `^BLA[0-9]{6}$`',
    `originator_maa_number` STRING COMMENT 'For biosimilar products only: the EMA Marketing Authorization Application number of the reference biologic product. Null for non-biosimilar products.',
    `orphan_drug_designation` BOOLEAN COMMENT 'Indicates whether the medicinal product has received Orphan Drug designation from the FDA or EMA for treatment of a rare disease affecting fewer than 200,000 patients (US) or fewer than 5 in 10,000 (EU).',
    `patent_expiry_date` DATE COMMENT 'The date on which the primary patent protection for the medicinal product expires, after which generic or biosimilar competition may enter the market.',
    `pediatric_indication` BOOLEAN COMMENT 'Indicates whether the medicinal product has an approved indication for use in pediatric populations (patients under 18 years of age).',
    `prescription_required` BOOLEAN COMMENT 'Indicates whether the medicinal product requires a prescription from a licensed healthcare professional for dispensing (true for Rx products, false for OTC products).',
    `product_name` STRING COMMENT 'The commercial brand name or proprietary name under which the medicinal product is marketed (e.g., Humira, Keytruda, Lipitor).',
    `product_type` STRING COMMENT 'Classification of the medicinal product by regulatory and development category: New Chemical Entity (NCE), New Biological Entity (NBE), Biosimilar, Vaccine, Generic, Over-The-Counter (OTC), or Medical Device Combination product. [ENUM-REF-CANDIDATE: NCE|NBE|Biosimilar|Vaccine|Generic|OTC|Medical Device Combination — 7 candidates stripped; promote to reference product]',
    `qbd_approach` BOOLEAN COMMENT 'Indicates whether the medicinal product was developed using Quality by Design (QbD) principles with defined design space, critical quality attributes (CQAs), and critical process parameters (CPPs).',
    `regulatory_designation` STRING COMMENT 'Special regulatory designations granted to the medicinal product (e.g., Orphan Drug, Breakthrough Therapy, Fast Track, Priority Review, Accelerated Approval, PRIME designation). Multiple designations may be concatenated.',
    `rems_required` BOOLEAN COMMENT 'Indicates whether the FDA has mandated a Risk Evaluation and Mitigation Strategy (REMS) program for this medicinal product to ensure that benefits outweigh risks.',
    `shelf_life_months` STRING COMMENT 'The approved shelf life of the medicinal product under specified storage conditions, expressed in months from date of manufacture.',
    `storage_conditions` STRING COMMENT 'The required storage conditions for the medicinal product to maintain stability and quality (e.g., Store at 2-8°C, Store below 25°C, Protect from light, Do not freeze).',
    `usan` STRING COMMENT 'The United States Adopted Name for the active substance, assigned by the USAN Council.',
    CONSTRAINT pk_medicinal_product PRIMARY KEY(`medicinal_product_id`)
) COMMENT 'Core master entity representing an authorized or investigational medicinal product (branded drug, generic, biosimilar, vaccine, or consumer health product). Captures INN/USAN, brand name, ATC classification code, mechanism of action (MOA), therapeutic area, product type (NCE, NBE, biosimilar, vaccine, OTC), development stage, lifecycle status, and for biosimilar products: reference biologic product linkage (reference_product_id, originator BLA/MAA number, interchangeability designation, extrapolation status, analytical similarity assessment outcome). Aligned with ISO IDMP Medicinal Product concept. Serves as the top-level node in the pharmaceutical product hierarchy (medicinal product → drug product → SKU) referenced by manufacturing, commercial, regulatory, and supply chain domains.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`product`.`drug_substance` (
    `drug_substance_id` BIGINT COMMENT 'Unique identifier for the drug substance (active pharmaceutical ingredient). Primary key for the drug substance master record.',
    `atc_classification_id` BIGINT COMMENT 'Foreign key linking to masterdata.atc_classification. Business justification: APIs classified by ATC for regulatory submissions (CTD Module 2.3), therapeutic class analysis, competitive intelligence. Replaces denormalized atc_code with FK to ATC master for API portfolio analysi',
    `drug_master_file_id` BIGINT COMMENT 'Foreign key linking to intellectual.drug_master_file. Business justification: Drug substances are primary subjects of Type II DMFs. Critical for regulatory submissions, supplier audits, and API manufacturing documentation. Removes denormalized dmf_number and dmf_type.',
    `inn_registry_id` BIGINT COMMENT 'Foreign key linking to masterdata.inn_registry. Business justification: APIs must reference INN registry for standardized nomenclature, regulatory filings (CTD Module 3), pharmacovigilance (substance identification). Replaces denormalized inn_name with FK to INN master fo',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to masterdata.legal_entity. Business justification: API manufacturer legal entity required for Drug Master File (DMF) holder identification, supplier qualification, regulatory filings (CTD Module 3), GMP compliance tracking. Replaces denormalized manuf',
    `patent_id` BIGINT COMMENT 'Foreign key linking to intellectual.patent. Business justification: API-level patent protection distinct from formulation patents. Critical for FTO analysis, CMC regulatory strategy, supplier qualification, and manufacturing site IP clearance.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Subject matter expert accountability for CMC documentation, DMF maintenance, regulatory filings, and manufacturing support. Required for regulatory inspections and technical transfer activities. Stand',
    `unit_of_measure_id` BIGINT COMMENT 'Foreign key linking to masterdata.unit_of_measure. Business justification: APIs measured in specific UOM for manufacturing (batch records), specifications (release testing), regulatory filings (CTD Module 3). Enables UOM standardization for API inventory, yield calculations,',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to procurement.vendor. Business justification: Drug substances (APIs) are procured from external manufacturers. Vendor FK enables supplier quality agreements, procurement tracking, audit scheduling, and regulatory DMF linkage. manufacturer_name is',
    `adme_profile_summary` STRING COMMENT 'Summary of the drug substances ADME characteristics including absorption rate, distribution volume, metabolic pathways, and excretion routes.',
    `bcs_classification` STRING COMMENT 'BCS classification of the drug substance based on solubility and permeability characteristics (Class I: high solubility/high permeability, Class II: low solubility/high permeability, Class III: high solubility/low permeability, Class IV: low solubility/low permeability).. Valid values are `Class I|Class II|Class III|Class IV`',
    `cas_registry_number` STRING COMMENT 'Unique numerical identifier assigned by the Chemical Abstracts Service to the drug substance for unambiguous chemical identification.. Valid values are `^[1-9][0-9]{1,6}-[0-9]{2}-[0-9]$`',
    `chemical_name` STRING COMMENT 'Systematic IUPAC chemical name describing the molecular structure of the drug substance according to international nomenclature standards.',
    `controlled_substance_schedule` STRING COMMENT 'DEA controlled substance schedule classification if the drug substance is subject to controlled substance regulations, or Not Controlled if not applicable.. Valid values are `Schedule I|Schedule II|Schedule III|Schedule IV|Schedule V|Not Controlled`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the drug substance master record was first created in the system.',
    `effective_date` DATE COMMENT 'Date when the current drug substance specification or master record version became effective for use in manufacturing and regulatory submissions.',
    `expiry_date` DATE COMMENT 'Date when the current drug substance specification or master record version is superseded or retired, if applicable.',
    `is_active` BOOLEAN COMMENT 'Indicates whether the drug substance master record is currently active and available for use in formulation, manufacturing, and regulatory activities.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the drug substance master record was last updated or modified.',
    `lifecycle_status` STRING COMMENT 'Current stage in the drug substance development and commercial lifecycle, from discovery through discontinuation.. Valid values are `discovery|preclinical|clinical|approved|marketed|discontinued`',
    `moa_summary` STRING COMMENT 'High-level summary of the drug substances mechanism of action, describing how it produces its pharmacological effect at the molecular or cellular level.',
    `molecular_formula` STRING COMMENT 'Chemical formula representing the number and type of atoms in one molecule of the drug substance (e.g., C8H9NO2).',
    `molecular_weight` DECIMAL(18,2) COMMENT 'Molecular weight of the drug substance expressed in grams per mole (g/mol), calculated from the molecular formula.',
    `nce_designation` BOOLEAN COMMENT 'Indicates whether the drug substance has been designated as a New Chemical Entity by regulatory authorities, qualifying for extended data exclusivity periods.',
    `orphan_drug_designation` BOOLEAN COMMENT 'Indicates whether the drug substance has received orphan drug designation for treatment of rare diseases affecting fewer than 200,000 patients.',
    `particle_size_specification` STRING COMMENT 'Defined particle size distribution range or specification for the drug substance, critical for dissolution and bioavailability (e.g., D50 < 10 microns).',
    `pharmacopoeial_monograph` STRING COMMENT 'Reference to the official pharmacopoeial monograph (USP, EP, JP, or other) that defines quality standards for the drug substance.',
    `physical_form` STRING COMMENT 'Physical state or form of the drug substance at standard conditions (e.g., crystalline solid, liquid, lyophilized powder).. Valid values are `solid|liquid|gas|semi-solid|lyophilized|amorphous`',
    `polymorphic_form` STRING COMMENT 'Specific crystalline or amorphous form of the drug substance, identifying the polymorph used in manufacturing (e.g., Form I, Form II, anhydrous, hydrate).',
    `regulatory_status` STRING COMMENT 'Summary of regulatory approval status across major markets (FDA, EMA, PMDA, etc.), indicating where the drug substance has received marketing authorization.',
    `retest_period_months` STRING COMMENT 'Time period in months after which the drug substance should be re-examined to ensure it still meets specifications before use in manufacturing.',
    `salt_form` STRING COMMENT 'Chemical salt form of the drug substance if applicable (e.g., hydrochloride, sodium, sulfate), or free base or free acid if not a salt.',
    `solubility_profile` STRING COMMENT 'Aqueous solubility characteristics of the drug substance across physiologically relevant pH ranges, critical for formulation development and bioavailability.',
    `specification_version` STRING COMMENT 'Version identifier for the current quality specification document defining acceptance criteria for the drug substance.',
    `stability_profile` STRING COMMENT 'Summary of the drug substances stability characteristics under various storage conditions, including temperature and humidity sensitivity.',
    `stereochemistry` STRING COMMENT 'Three-dimensional spatial arrangement of atoms in the drug substance molecule, including chirality and isomeric configuration (e.g., R/S designation, E/Z configuration).',
    `storage_conditions` STRING COMMENT 'Recommended storage conditions for the drug substance to maintain quality and stability (e.g., store at 2-8°C, protect from light, store under inert atmosphere).',
    `synthesis_route_version` STRING COMMENT 'Version identifier for the chemical synthesis route or manufacturing process used to produce the drug substance, enabling change control and traceability.',
    `therapeutic_class` STRING COMMENT 'Primary therapeutic classification of the drug substance based on its clinical use and pharmacological properties.',
    `usan_name` STRING COMMENT 'United States Adopted Name assigned by the USAN Council, representing the official generic name used in the United States for the drug substance.',
    CONSTRAINT pk_drug_substance PRIMARY KEY(`drug_substance_id`)
) COMMENT 'Master record for the active pharmaceutical ingredient (API) or drug substance (DS) as defined in ICH Q7. Captures chemical name, molecular formula, molecular weight, CAS registry number, INN/USAN designation, pharmacopoeial monograph reference (USP/EP/JP), physical form, stereochemistry, polymorphic form, salt form, particle size specification, ADME profile summary, BCS classification, and regulatory Drug Master File (DMF) reference number. Represents the DS layer in the DS/DP hierarchy and is the single source of truth for API chemical identity referenced by manufacturing, quality, regulatory, and formulation records.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`product`.`drug_product` (
    `drug_product_id` BIGINT COMMENT 'Unique identifier for the finished drug product record. Primary key for the drug product entity.',
    `country_id` BIGINT COMMENT 'Foreign key linking to masterdata.country. Business justification: Drug products approved in specific jurisdictions for market authorization tracking, regulatory submissions (country-specific dossiers), supply planning (market-specific manufacturing), labeling (count',
    `atc_classification_id` BIGINT COMMENT 'Foreign key linking to masterdata.atc_classification. Business justification: Drug products require ATC classification for reimbursement (HTA submissions, pricing negotiations), formulary inclusion, utilization analysis. Replaces denormalized atc_code with FK to ATC master for ',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to masterdata.cost_center. Business justification: Drug products assigned to cost centers for R&D capitalization (IAS 38), portfolio accounting, project costing. Enables financial tracking of development costs by product, capitalization decisions (tec',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Product development lead for formulation design, process development, scale-up, and tech transfer. Core R&D accountability for CMC sections of regulatory submissions and manufacturing readiness. Essen',
    `drug_master_file_id` BIGINT COMMENT 'Foreign key linking to intellectual.drug_master_file. Business justification: Drug products reference DMFs in NDA/ANDA submissions for API/excipient manufacturing details. Essential for regulatory completeness, supplier qualification, and CMC documentation cross-referencing.',
    `drug_substance_id` BIGINT COMMENT 'Reference to the primary active pharmaceutical ingredient (API) or drug substance used in this drug product formulation.',
    `inn_registry_id` BIGINT COMMENT 'Foreign key linking to masterdata.inn_registry. Business justification: Drug products linked to INN for labeling (generic name), prescribing information, international trade (import/export documentation). Replaces denormalized inn with FK to INN registry for standardized ',
    `masterdata_ndc_code_id` BIGINT COMMENT 'Foreign key linking to masterdata.ndc_code. Business justification: Drug products assigned NDC codes for US regulatory compliance (FDA establishment registration), supply chain tracking (serialization), reimbursement (billing). Replaces denormalized ndc_code string wi',
    `patent_id` BIGINT COMMENT 'Foreign key linking to intellectual.patent. Business justification: Drug products require patent coverage tracking for lifecycle management, LOE planning, Orange Book listings, and generic defense strategy. Essential for regulatory submissions and commercial planning.',
    `plant_id` BIGINT COMMENT 'Foreign key linking to masterdata.plant. Business justification: Drug product manufacturing plant assignment for production planning, batch genealogy, GMP site compliance, regulatory site registration. Complements existing manufacturing_site_id (manufacturing domai',
    `rld_product_id` BIGINT COMMENT 'Reference to the RLD drug product if this product is a generic or biosimilar requiring bioequivalence demonstration.',
    `therapeutic_area_id` BIGINT COMMENT 'Foreign key linking to product.therapeutic_area. Business justification: drug_product has therapeutic_area as a STRING attribute that should reference the therapeutic_area master table for standardized classification.',
    `unit_of_measure_id` BIGINT COMMENT 'Foreign key linking to masterdata.unit_of_measure. Business justification: Drug product strength UOM for labeling (strength declaration), dosing (prescribing information), quality control (specification limits). Replaces denormalized strength_unit with FK to UOM master for s',
    `approval_date` DATE COMMENT 'The date on which the drug product received initial regulatory approval from the primary health authority (e.g., FDA, EMA).',
    `black_box_warning_flag` BOOLEAN COMMENT 'Indicates whether the drug product labeling includes a black box warning (boxed warning) for serious or life-threatening risks.',
    `cmc_summary` STRING COMMENT 'High-level summary of the chemistry, manufacturing, and controls information for the drug product, including formulation composition and manufacturing process overview.',
    `controlled_substance_schedule` STRING COMMENT 'The DEA controlled substance schedule classification if the drug product contains a controlled substance (Schedule I through V), or non-controlled if not applicable.. Valid values are `schedule_I|schedule_II|schedule_III|schedule_IV|schedule_V|non_controlled`',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this drug product record was first created in the system.',
    `discontinuation_date` DATE COMMENT 'The date on which the drug product was discontinued or withdrawn from the market, if applicable.',
    `dosage_form` STRING COMMENT 'The physical form in which the drug product is manufactured and administered (e.g., tablet, capsule, injection, solution, suspension, cream, ointment, transdermal patch). [ENUM-REF-CANDIDATE: tablet|capsule|injection|solution|suspension|cream|ointment|patch — 8 candidates stripped; promote to reference product]',
    `excipients` STRING COMMENT 'List of inactive ingredients (excipients) used in the drug product formulation, such as binders, fillers, preservatives, and colorants.',
    `formulation_type` STRING COMMENT 'Classification of the drug product formulation based on release characteristics (e.g., immediate release, extended release, delayed release, modified release, controlled release).. Valid values are `immediate_release|extended_release|delayed_release|modified_release|controlled_release`',
    `launch_date` DATE COMMENT 'The date on which the drug product was first made commercially available in the market.',
    `lifecycle_status` STRING COMMENT 'Current lifecycle stage of the drug product (e.g., development, approved, marketed, discontinued, withdrawn from market).. Valid values are `development|approved|marketed|discontinued|withdrawn`',
    `moa` STRING COMMENT 'Description of the biochemical or physiological mechanism by which the drug product exerts its therapeutic effect.',
    `modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this drug product record was last modified or updated.',
    `package_size` STRING COMMENT 'The quantity of dosage units per package (e.g., 30 tablets, 100 mL, 10 vials).',
    `packaging_type` STRING COMMENT 'The primary packaging configuration for the drug product (e.g., bottle, blister pack, vial, ampule, prefilled syringe, tube).. Valid values are `bottle|blister|vial|ampule|prefilled_syringe|tube`',
    `patent_expiry_date` DATE COMMENT 'The date on which the primary patent protection for the drug product expires, opening the market to generic competition.',
    `prescription_status` STRING COMMENT 'Indicates whether the drug product requires a prescription (Rx), is available over-the-counter (OTC), or is behind-the-counter.. Valid values are `rx|otc|behind_the_counter`',
    `product_code` STRING COMMENT 'Internal product code assigned to the drug product for identification across manufacturing, regulatory, and commercial systems. Typically alphanumeric and unique within the organization.. Valid values are `^[A-Z0-9]{6,12}$`',
    `product_name` STRING COMMENT 'The commercial or proprietary name of the drug product as it appears on labeling and marketing materials.',
    `product_type` STRING COMMENT 'Classification of the drug product by regulatory and commercial category (e.g., branded, generic, biosimilar, vaccine, over-the-counter, medical device combination product).. Valid values are `branded|generic|biosimilar|vaccine|otc|medical_device_combination`',
    `qbd_flag` BOOLEAN COMMENT 'Indicates whether the drug product was developed using Quality by Design principles as defined by ICH Q8.',
    `rems_flag` BOOLEAN COMMENT 'Indicates whether the drug product is subject to a Risk Evaluation and Mitigation Strategy program required by the FDA to ensure safe use.',
    `rld_flag` BOOLEAN COMMENT 'Indicates whether this drug product is designated as a Reference Listed Drug by the FDA for bioequivalence studies.',
    `route_of_administration` STRING COMMENT 'The path by which the drug product is administered to the patient (e.g., oral, intravenous, intramuscular, subcutaneous, topical, transdermal).. Valid values are `oral|intravenous|intramuscular|subcutaneous|topical|transdermal`',
    `shelf_life_months` STRING COMMENT 'The approved shelf life of the drug product from date of manufacture, expressed in months, under specified storage conditions.',
    `storage_conditions` STRING COMMENT 'The required storage conditions for the drug product to maintain stability and quality (e.g., store at 2-8°C, protect from light, store below 25°C).',
    `strength` STRING COMMENT 'The amount of active pharmaceutical ingredient (API) per unit of dosage form, expressed with unit of measure (e.g., 500 mg, 10 mg/mL, 5%).',
    `strength_value` DECIMAL(18,2) COMMENT 'Numeric value of the active pharmaceutical ingredient strength for computational and analytical purposes.',
    `usan` STRING COMMENT 'The United States Adopted Name for the active pharmaceutical ingredient, assigned by the USAN Council.',
    CONSTRAINT pk_drug_product PRIMARY KEY(`drug_product_id`)
) COMMENT 'Master record for the finished drug product (DP) or finished dosage form (FDF) derived from one or more drug substances. Captures dosage form (tablet, capsule, injection, etc.), route of administration, strength, formulation type, reference listed drug (RLD) linkage, shelf life, storage conditions, and CMC summary. Bridges the DS/DP hierarchy and is referenced by manufacturing batch records, regulatory submissions, and commercial SKUs.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`product`.`formulation` (
    `formulation_id` BIGINT COMMENT 'Unique identifier for the formulation record. Primary key for the formulation entity.',
    `plant_id` BIGINT COMMENT 'Foreign key linking to masterdata.plant. Business justification: Formulation development site tracking for technology transfer documentation, scale-up studies, process validation, site-specific design space. Critical for CMC regulatory submissions (CTD Module 3), m',
    `drug_product_id` BIGINT COMMENT 'Reference to the parent drug product that this formulation defines. Links to the finished dosage form (FDF) in the product master catalog.',
    `internal_order_id` BIGINT COMMENT 'Foreign key linking to finance.internal_order. Business justification: Formulation development projects are tracked via internal orders for cost accumulation, budget control, and capitalization eligibility determination. This link enables pharmaceutical companies to trac',
    `patent_id` BIGINT COMMENT 'Foreign key linking to intellectual.patent. Business justification: Formulations have distinct patent protection (composition, process). Essential for lifecycle management, line extension strategy, and generic defense through formulation patents.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Formulation scientist responsible for QbD design space, CPP/CQA definition, stability strategy, and regulatory documentation. Direct accountability for formulation performance and regulatory defense. ',
    `unit_of_measure_id` BIGINT COMMENT 'Foreign key linking to masterdata.unit_of_measure. Business justification: Formulation unit dose strength UOM for manufacturing instructions (batch records), specifications (release criteria), regulatory filings. Replaces denormalized unit_dose_strength_uom with FK to UOM ma',
    `api_count` STRING COMMENT 'Number of distinct active pharmaceutical ingredients (APIs) in the formulation. Most formulations have 1 API; combination products have 2 or more.',
    `approved_by` STRING COMMENT 'User identifier or name of the person who approved this formulation. Typically a quality assurance manager or regulatory affairs lead.',
    `approved_date` DATE COMMENT 'Date when this formulation was formally approved for use in manufacturing or clinical trials. Represents a key lifecycle milestone.',
    `batch_size_target` DECIMAL(18,2) COMMENT 'Planned or standard batch size for manufacturing this formulation, expressed in the unit specified by batch_size_uom. Used for scale-up calculations and manufacturing planning.',
    `batch_size_uom` STRING COMMENT 'Unit of measure for the batch size (e.g., kg for bulk powder, L for liquid, units for finished dosage forms). [ENUM-REF-CANDIDATE: kg|L|units|tablets|capsules|vials|syringes — 7 candidates stripped; promote to reference product]',
    `bioequivalence_reference` STRING COMMENT 'Reference to bioequivalence or bioavailability studies conducted for this formulation, particularly relevant for generic formulations or formulation changes requiring bridging studies.',
    `composition_description` STRING COMMENT 'Detailed textual description of the formulation composition, including all active and inactive ingredients, their roles, and quantities. Supports CMC Module 3 documentation and regulatory submissions.',
    `cpp_summary` STRING COMMENT 'Summary of critical process parameters (CPPs) identified for this formulation. CPPs are process parameters whose variability has an impact on a critical quality attribute (CQA) and therefore should be monitored or controlled.',
    `cqa_summary` STRING COMMENT 'Summary of critical quality attributes (CQAs) for this formulation. CQAs are physical, chemical, biological, or microbiological properties that should be within an appropriate limit, range, or distribution to ensure the desired product quality.',
    `created_date` DATE COMMENT 'Date when this formulation record was first created in the system. Part of audit trail for formulation lifecycle management.',
    `design_space_description` STRING COMMENT 'Textual summary of the QbD design space, including key input variables, process parameters, and their acceptable ranges. References supporting studies and risk assessments.',
    `dosage_form` STRING COMMENT 'Physical form in which the drug product is manufactured and administered (e.g., tablet, capsule, injectable solution). Aligns with FDA and EMA dosage form terminologies. [ENUM-REF-CANDIDATE: tablet|capsule|solution|suspension|emulsion|cream|ointment|gel|patch|injection|lyophilized_powder|suppository — 12 candidates stripped; promote to reference product]',
    `ectd_module_reference` STRING COMMENT 'Specific eCTD module and section reference where this formulation is documented (e.g., 3.2.P.1, 3.2.P.3.3). Facilitates traceability to regulatory documentation.',
    `excipient_count` STRING COMMENT 'Number of distinct inactive ingredients (excipients) in the formulation. Includes fillers, binders, disintegrants, lubricants, coatings, preservatives, and other functional excipients.',
    `formulation_code` STRING COMMENT 'Business identifier for the formulation, used across manufacturing, regulatory, and quality systems. Typically follows internal coding conventions for Chemistry Manufacturing and Controls (CMC) documentation.. Valid values are `^[A-Z0-9]{6,20}$`',
    `formulation_name` STRING COMMENT 'Human-readable name or title of the formulation, often including the drug product name, strength, and dosage form (e.g., Compound XYZ 50mg Tablet Formulation).',
    `formulation_status` STRING COMMENT 'Current lifecycle status of the formulation. Tracks progression from early development through commercial manufacturing and potential discontinuation.. Valid values are `development|optimization|validation|approved|commercial|discontinued`',
    `formulation_type` STRING COMMENT 'Classification of the formulation based on its release mechanism and pharmacokinetic profile. Critical for regulatory submissions and manufacturing process design.. Valid values are `immediate_release|modified_release|extended_release|delayed_release|controlled_release|sustained_release`',
    `gmp_grade_required` STRING COMMENT 'Indicates the GMP grade required for manufacturing this formulation: clinical (for investigational products), commercial (for marketed products), or both (for formulations used in both contexts).. Valid values are `clinical|commercial|both`',
    `last_modified_by` STRING COMMENT 'User identifier or name of the person who last modified this formulation record. Part of audit trail for compliance and quality management.',
    `last_modified_date` DATE COMMENT 'Date when this formulation record was last modified. Tracks changes to formulation specifications, status, or metadata.',
    `manufacturing_process_type` STRING COMMENT 'Primary manufacturing process or technology used to produce this formulation (e.g., wet granulation for tablets, aseptic filling for injectables). Influences equipment selection and process validation strategy. [ENUM-REF-CANDIDATE: wet_granulation|dry_granulation|direct_compression|coating|lyophilization|aseptic_filling|emulsification|spray_drying — 8 candidates stripped; promote to reference product]',
    `patent_protected` BOOLEAN COMMENT 'Indicates whether this formulation is covered by one or more patents, providing intellectual property protection. Links to patent records in the intellectual property domain.',
    `pharmacopoeial_standard` STRING COMMENT 'Primary pharmacopoeial standard to which this formulation conforms (USP = United States Pharmacopeia, EP = European Pharmacopoeia, JP = Japanese Pharmacopoeia, BP = British Pharmacopoeia, IP = Indian Pharmacopoeia, ChP = Chinese Pharmacopoeia).. Valid values are `USP|EP|JP|BP|IP|ChP`',
    `qbd_design_space_defined` BOOLEAN COMMENT 'Indicates whether a Quality by Design (QbD) design space has been established for this formulation, defining the multidimensional combination of input variables and process parameters that ensure quality.',
    `regulatory_submission_reference` STRING COMMENT 'Reference to the regulatory submission (IND, NDA, BLA, MAA) in which this formulation was described or approved. Links formulation records to regulatory dossiers in RIMS.',
    `route_of_administration` STRING COMMENT 'Intended pathway by which the drug product is administered to the patient. Critical for formulation design and regulatory classification. [ENUM-REF-CANDIDATE: oral|intravenous|intramuscular|subcutaneous|topical|transdermal|inhalation|ophthalmic|otic|rectal|vaginal — 11 candidates stripped; promote to reference product]',
    `scale_up_factor` DECIMAL(18,2) COMMENT 'Ratio of commercial batch size to development batch size, indicating the degree of scale-up achieved. Used to assess scale-up risk and process robustness.',
    `shelf_life_months` STRING COMMENT 'Approved or proposed shelf life for the formulation in months, based on stability data. Defines the period during which the product remains within specifications under defined storage conditions.',
    `stability_profile_summary` STRING COMMENT 'Summary of stability characteristics for this formulation, including storage conditions, shelf life, and key degradation pathways. References formal stability studies conducted per ICH Q1A guidelines.',
    `storage_conditions` STRING COMMENT 'Recommended storage conditions for the formulation (e.g., Store at 2-8°C, Store below 25°C, Protect from light). Critical for maintaining product quality and stability.',
    `technology_transfer_status` STRING COMMENT 'Status of technology transfer activities for this formulation, tracking the transfer of manufacturing knowledge and processes from development to commercial manufacturing sites or to CMOs/CDMOs.. Valid values are `not_started|in_progress|tech_transfer_complete|validation_complete|commercial_ready`',
    `unit_dose_strength` DECIMAL(18,2) COMMENT 'Quantity of active pharmaceutical ingredient (API) per unit dose (e.g., 50 mg per tablet, 100 mg/mL for solution). Expressed in the unit specified by unit_dose_strength_uom.',
    `version_number` STRING COMMENT 'Version identifier for the formulation, tracking iterative changes during development, scale-up, and optimization. Follows semantic versioning (e.g., 1.0, 1.1, 2.0).. Valid values are `^[0-9]{1,3}.[0-9]{1,3}$`',
    `created_by` STRING COMMENT 'User identifier or name of the person who created this formulation record. Part of audit trail for compliance and quality management.',
    CONSTRAINT pk_formulation PRIMARY KEY(`formulation_id`)
) COMMENT 'Detailed formulation record specifying the qualitative and quantitative composition (Q1/Q2) of a drug product, including all active and inactive ingredients, their pharmacopoeial grades, functional roles, and quantities per unit dose and per batch. Tracks formulation version history, Quality by Design (QbD) design space parameters, critical process parameters (CPP), and critical quality attributes (CQA). Supports CMC Module 3 documentation, scale-up, and technology transfer.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`product`.`formulation_ingredient` (
    `formulation_ingredient_id` BIGINT COMMENT 'Unique identifier for each ingredient record within a formulation. Primary key for the formulation ingredient entity.',
    `business_partner_id` BIGINT COMMENT 'Foreign key linking to masterdata.business_partner. Business justification: Ingredient suppliers require business partner master integration for quality agreements, supplier qualification (AVL), supplier audits, procurement. Complements existing vendor_id (procurement domain)',
    `drug_master_file_id` BIGINT COMMENT 'Foreign key linking to intellectual.drug_master_file. Business justification: Formulation ingredients (APIs, excipients) often have DMF support required for regulatory submissions. Essential for supplier qualification and CMC documentation completeness. Removes denormalized dmf',
    `drug_substance_id` BIGINT COMMENT 'Foreign key linking to product.drug_substance. Business justification: formulation_ingredient can contain APIs (when ingredient_type = API). When the ingredient is an API, it should reference the drug_substance master table. The inn_name, usan_name, and cas_number can ',
    `excipient_id` BIGINT COMMENT 'Foreign key linking to product.excipient. Business justification: formulation_ingredient contains excipient-related attributes that should be normalized to the excipient master table. When an ingredient is an excipient (not an API), this FK allows retrieval of autho',
    `formulation_id` BIGINT COMMENT 'Reference to the parent formulation to which this ingredient belongs. Links ingredient to the complete formulation bill of materials.',
    `material_id` BIGINT COMMENT 'Foreign key linking to masterdata.material. Business justification: Ingredient material master integration for procurement (PO creation), inventory management (stock levels, reservations), batch traceability (genealogy), MRP planning. Replaces denormalized material_ma',
    `unit_of_measure_id` BIGINT COMMENT 'Foreign key linking to masterdata.unit_of_measure. Business justification: Ingredient unit dose quantity UOM for formulation composition (per-unit ingredient amounts), batch calculations (ingredient quantities per batch). Replaces denormalized unit_dose_uom with FK to UOM ma',
    `vendor_id` BIGINT COMMENT 'Reference to the approved supplier or Contract Manufacturing Organization (CMO) providing this ingredient. Links to supplier qualification and audit records.',
    `batch_quantity_uom` STRING COMMENT 'Unit of measure for the batch quantity: kilograms (kg), grams (g), liters (L), milliliters (mL), or units.. Valid values are `kg|g|L|mL|units`',
    `change_control_number` STRING COMMENT 'Reference to the change control or deviation record that authorized the addition or modification of this ingredient in the formulation. Required for audit trail and regulatory inspection readiness.',
    `coa_required_flag` BOOLEAN COMMENT 'Indicates whether a Certificate of Analysis must be obtained and reviewed for each lot of this ingredient before use in manufacturing. Critical for Good Manufacturing Practice (GMP) compliance.',
    `controlled_substance_schedule` STRING COMMENT 'Drug Enforcement Administration (DEA) controlled substance classification for the ingredient, if applicable. Determines security, handling, and reporting requirements.. Valid values are `Schedule I|Schedule II|Schedule III|Schedule IV|Schedule V|non-controlled`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this formulation ingredient record was first created in the system. Part of audit trail for regulatory compliance.',
    `critical_quality_attribute_flag` BOOLEAN COMMENT 'Indicates whether this ingredient is designated as a Critical Quality Attribute under Quality by Design (QbD) principles, requiring enhanced control and monitoring.',
    `effective_end_date` DATE COMMENT 'Date on which this ingredient specification is superseded or discontinued. Null for currently active specifications.',
    `effective_start_date` DATE COMMENT 'Date from which this ingredient specification becomes effective in the formulation. Used for change control and version management.',
    `ingredient_function` STRING COMMENT 'Specific functional role of the ingredient in the formulation such as binder, filler, disintegrant, lubricant, coating agent, or flavoring agent. Critical for Quality by Design (QbD) and regulatory submissions.',
    `ingredient_name` STRING COMMENT 'Common or trade name of the ingredient as used in manufacturing documentation and internal systems.',
    `ingredient_sequence_number` STRING COMMENT 'Sequential ordering of ingredients within the formulation, used for manufacturing instructions and regulatory documentation.',
    `ingredient_type` STRING COMMENT 'Classification of the ingredient role in the formulation: Active Pharmaceutical Ingredient (API), excipient, solvent, preservative, stabilizer, or colorant.. Valid values are `API|excipient|solvent|preservative|stabilizer|colorant`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this formulation ingredient record was last updated. Part of audit trail for regulatory compliance and change control.',
    `overage_justification` STRING COMMENT 'Business and scientific rationale for the overage percentage, including stability data, manufacturing loss studies, or regulatory requirements. Required for regulatory submissions and quality documentation.',
    `overage_percentage` DECIMAL(18,2) COMMENT 'Percentage of additional ingredient added beyond the theoretical quantity to compensate for manufacturing losses, degradation, or potency variations. Critical for API stability and shelf-life management.',
    `quantity_per_batch` DECIMAL(18,2) COMMENT 'Total amount of the ingredient required for a standard manufacturing batch. Used for batch record generation, material planning, and manufacturing execution.',
    `quantity_per_unit_dose` DECIMAL(18,2) COMMENT 'Amount of the ingredient present in a single unit dose (e.g., one tablet, one capsule, one vial). Used for labeling, regulatory submissions, and quality control.',
    `regulatory_status` STRING COMMENT 'Current regulatory approval status of the ingredient for use in pharmaceutical manufacturing: approved for use, pending review, restricted use, or obsolete.. Valid values are `approved|pending|restricted|obsolete`',
    `retest_period_days` STRING COMMENT 'Number of days after which the ingredient must be retested to confirm it still meets specifications before use in manufacturing. Part of stability and quality management programs.',
    `specification_reference` STRING COMMENT 'Reference to the detailed quality specification document or standard operating procedure (SOP) governing acceptance criteria for this ingredient.',
    `storage_condition` STRING COMMENT 'Required storage conditions for the ingredient such as temperature range, humidity control, light protection, or inert atmosphere. Critical for maintaining ingredient quality and stability.',
    CONSTRAINT pk_formulation_ingredient PRIMARY KEY(`formulation_ingredient_id`)
) COMMENT 'Line-level record within a formulation capturing each individual ingredient (API or excipient), its INN or INCI name, pharmacopoeial grade, function (binder, filler, preservative, etc.), quantity per unit dose, quantity per batch, and overages. Enables full bill-of-materials traceability for regulatory submissions and manufacturing execution.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`product`.`packaging_configuration` (
    `packaging_configuration_id` BIGINT COMMENT 'Unique identifier for the packaging configuration record. Primary key.',
    `drug_product_id` BIGINT COMMENT 'Reference to the drug product (finished dosage form) that this packaging configuration applies to.',
    `plant_id` BIGINT COMMENT 'Foreign key linking to masterdata.plant. Business justification: Packaging operations site assignment for capacity planning, serialization compliance (plant-level aggregation), secondary packaging operations, distribution planning. Required for Track & Trace regula',
    `patent_id` BIGINT COMMENT 'Foreign key linking to intellectual.patent. Business justification: Packaging and device components (especially combination products) have distinct patent protection. Critical for product differentiation, IP strategy, and device-related regulatory submissions.',
    `unit_of_measure_id` BIGINT COMMENT 'Foreign key linking to masterdata.unit_of_measure. Business justification: Packaging fill volume UOM for fill specifications (target fill volume), stability (headspace calculations), regulatory filings (container-closure system). Normalizes implicit ml unit in fill_volume_ml',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to procurement.vendor. Business justification: Packaging materials (containers, closures, labels) are procured from specialized vendors. Critical for supplier qualification, quality agreements, change control notifications, and regulatory complian',
    `aggregation_hierarchy` STRING COMMENT 'Description of the parent-child aggregation structure for serialized units (e.g., unit > case > pallet) used in track-and-trace systems.',
    `child_resistant_packaging` BOOLEAN COMMENT 'Indicates whether the packaging meets child-resistant standards to prevent accidental ingestion by children.',
    `closure_type` STRING COMMENT 'Type of closure used to seal the primary container, ensuring product integrity and preventing contamination. [ENUM-REF-CANDIDATE: rubber_stopper|screw_cap|flip_off_cap|child_resistant_cap|tamper_evident_seal|heat_seal|crimp_seal — 7 candidates stripped; promote to reference product]',
    `cold_chain_required` BOOLEAN COMMENT 'Indicates whether this packaging configuration requires temperature-controlled cold chain storage and distribution.',
    `configuration_code` STRING COMMENT 'Unique business identifier for the packaging configuration used across manufacturing, supply chain, and commercial systems.. Valid values are `^[A-Z0-9]{6,20}$`',
    `configuration_name` STRING COMMENT 'Human-readable name describing the packaging configuration, typically including container type, pack size, and market designation.',
    `configuration_type` STRING COMMENT 'Classification of the packaging configuration based on its intended use and distribution channel.. Valid values are `commercial|clinical|sample|investigational|compassionate_use|reference_standard`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this packaging configuration record was first created in the master data system.',
    `discontinuation_date` DATE COMMENT 'Date on which this packaging configuration was discontinued and is no longer manufactured or distributed.',
    `effective_date` DATE COMMENT 'Date from which this packaging configuration becomes active and available for manufacturing and distribution.',
    `fill_volume_ml` DECIMAL(18,2) COMMENT 'Volume of drug product filled into the primary container, measured in milliliters. Critical for dosing accuracy and overfill calculations.',
    `gtin` STRING COMMENT 'GS1 Global Trade Item Number (GTIN-14) used for supply chain identification and track-and-trace serialization.. Valid values are `^[0-9]{14}$`',
    `headspace_volume_ml` DECIMAL(18,2) COMMENT 'Volume of air or inert gas in the primary container above the drug product, important for stability and oxidation control.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to this packaging configuration record.',
    `lifecycle_status` STRING COMMENT 'Current lifecycle state of the packaging configuration indicating its availability for manufacturing and distribution.. Valid values are `draft|pending_approval|active|discontinued|obsolete|withdrawn`',
    `light_protection_required` BOOLEAN COMMENT 'Indicates whether the packaging must protect the drug product from light exposure to prevent photodegradation.',
    `market_authorization_country` STRING COMMENT 'Three-letter ISO country code indicating the primary market or regulatory jurisdiction for which this packaging configuration is authorized.. Valid values are `^[A-Z]{3}$`',
    `moisture_protection_required` BOOLEAN COMMENT 'Indicates whether the packaging must provide moisture barrier protection to prevent hygroscopic degradation.',
    `ndc_code` STRING COMMENT 'FDA-assigned National Drug Code uniquely identifying this specific packaging configuration in the US market. Format: labeler-product-package.. Valid values are `^[0-9]{5}-[0-9]{4}-[0-9]{2}$|^[0-9]{5}-[0-9]{3}-[0-9]{2}$|^[0-9]{4}-[0-9]{4}-[0-9]{2}$`',
    `nominal_fill_volume_ml` DECIMAL(18,2) COMMENT 'Labeled or declared fill volume on the packaging, which may differ from actual fill volume due to overfill requirements.',
    `package_insert_version` STRING COMMENT 'Version identifier of the package insert or patient information leaflet included with this packaging configuration.',
    `primary_container_material` STRING COMMENT 'Material composition of the primary container, critical for stability and compatibility with the drug substance. [ENUM-REF-CANDIDATE: glass_type_i|glass_type_ii|glass_type_iii|plastic_hdpe|plastic_ldpe|plastic_pet|plastic_pp|aluminum|laminate — 9 candidates stripped; promote to reference product]',
    `primary_container_type` STRING COMMENT 'Type of primary container that is in direct contact with the drug product, part of the container closure system (CCS). [ENUM-REF-CANDIDATE: vial|ampoule|blister|bottle|syringe|cartridge|pen|inhaler|sachet|tube|pouch — 11 candidates stripped; promote to reference product]',
    `regulatory_approval_date` DATE COMMENT 'Date on which the packaging configuration received regulatory approval for commercial distribution.',
    `retest_period_months` STRING COMMENT 'Period in months after which the drug product must be retested to confirm continued compliance with specifications.',
    `secondary_packaging_material` STRING COMMENT 'Material composition of the secondary packaging, selected for protection, sustainability, and regulatory compliance.. Valid values are `paperboard|corrugated_cardboard|plastic|aluminum_foil|laminate`',
    `secondary_packaging_type` STRING COMMENT 'Type of secondary packaging that contains one or more primary containers, providing additional protection and labeling space. [ENUM-REF-CANDIDATE: carton|wallet|box|tray|shrink_wrap|bundle|none — 7 candidates stripped; promote to reference product]',
    `serialization_level` STRING COMMENT 'Level at which unique serialization is applied for track-and-trace compliance (unit, pack, case, or pallet level).. Valid values are `unit|pack|case|pallet|none`',
    `shelf_life_months` STRING COMMENT 'Approved shelf life duration in months from date of manufacture, based on stability study data.',
    `storage_condition_description` STRING COMMENT 'Detailed textual description of storage conditions including temperature range, humidity, light protection, and orientation requirements.',
    `storage_temperature_max_c` DECIMAL(18,2) COMMENT 'Maximum storage temperature in degrees Celsius required to maintain product stability and efficacy.',
    `storage_temperature_min_c` DECIMAL(18,2) COMMENT 'Minimum storage temperature in degrees Celsius required to maintain product stability and efficacy.',
    `tamper_evident_feature` STRING COMMENT 'Type of tamper-evident feature incorporated into the packaging to ensure product integrity and patient safety.. Valid values are `shrink_band|breakable_cap|seal|blister_integrity|none`',
    `tertiary_packaging_type` STRING COMMENT 'Type of tertiary or shipper packaging used for bulk distribution and logistics, containing multiple secondary packs.. Valid values are `shipper|pallet|case|crate|none`',
    `units_per_primary_pack` STRING COMMENT 'Number of individual dosage units (tablets, capsules, vials) contained in the primary packaging.',
    `units_per_secondary_pack` STRING COMMENT 'Number of primary containers included in one secondary package unit.',
    `units_per_tertiary_pack` STRING COMMENT 'Number of secondary packages contained in one tertiary shipper or case for distribution.',
    CONSTRAINT pk_packaging_configuration PRIMARY KEY(`packaging_configuration_id`)
) COMMENT 'Master record for the packaging configuration of a drug product, defining primary container (vial, blister, bottle), secondary packaging (carton, wallet), and tertiary/shipper packaging. Captures container closure system (CCS) specifications, pack size, fill volume, headspace, cold-chain requirements (2-8°C, -20°C, -80°C), and serialization/aggregation hierarchy for track-and-trace compliance (DSCSA, EU FMD). Referenced by supply chain, manufacturing, and commercial domains for SKU definition.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`product`.`sku` (
    `sku_id` BIGINT COMMENT 'Unique identifier for the SKU record. Primary key for the SKU master data product.',
    `country_id` BIGINT COMMENT 'Foreign key linking to masterdata.country. Business justification: SKUs are market-specific (country-level) for pricing, reimbursement, distribution, regulatory compliance. Replaces denormalized market_country_code with FK to country master for market access analytic',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to masterdata.legal_entity. Business justification: SKU-level Marketing Authorization Holder tracking for market-specific regulatory compliance, product liability, pharmacovigilance case processing. Each market/SKU may have different MAH (local affilia',
    `masterdata_ndc_code_id` BIGINT COMMENT 'Foreign key linking to masterdata.ndc_code. Business justification: SKUs in US market must link to NDC for billing (pharmacy claims, 340B), reimbursement (Medicare Part D), serialization (DSCSA compliance). Replaces denormalized ndc_code with FK to NDC master for pric',
    `medicinal_product_id` BIGINT COMMENT 'Reference to the parent drug product (DP) or finished dosage form (FDF) that this SKU represents at a specific packaging and market configuration.',
    `packaging_configuration_id` BIGINT COMMENT 'Foreign key linking to product.packaging_configuration. Business justification: SKU is the commercially sellable unit with specific packaging. The packaging details (package_size, package_type, storage_condition, cold_chain_required, shelf_life_months) on sku should reference the',
    `site_id` BIGINT COMMENT 'Reference to the primary manufacturing site or CMO/CDMO facility responsible for producing this SKU. Used for supply chain planning, quality investigations, and regulatory inspections.',
    `therapeutic_area_id` BIGINT COMMENT 'Foreign key linking to product.therapeutic_area. Business justification: sku has therapeutic_area as a STRING attribute that should reference the therapeutic_area master table for standardized classification.',
    `trademark_id` BIGINT COMMENT 'Foreign key linking to intellectual.trademark. Business justification: Each market SKU is sold under trademark protection. Essential for commercial operations, brand enforcement, market-specific trademark registration tracking, and anti-counterfeiting programs.',
    `atc_code` STRING COMMENT 'WHO Anatomical Therapeutic Chemical (ATC) classification code for the active ingredient. Used for therapeutic classification and pharmacoepidemiological research.. Valid values are `^[A-Z][0-9]{2}[A-Z]{2}[0-9]{2}$`',
    `commercial_status` STRING COMMENT 'Current lifecycle status of the SKU in the market. Active indicates commercially available; discontinued indicates no longer manufactured but may have remaining inventory; withdrawn indicates removed from market for safety or regulatory reasons.. Valid values are `active|discontinued|withdrawn|suspended|pending_launch|obsolete`',
    `controlled_substance_schedule` STRING COMMENT 'DEA controlled substance schedule classification (I-V) for SKUs containing controlled substances. Non-controlled if not a controlled substance. Determines regulatory handling and reporting requirements.. Valid values are `schedule_I|schedule_II|schedule_III|schedule_IV|schedule_V|non_controlled`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the SKU master record was first created in the system. Used for audit trail and data lineage.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the list price (e.g., USD, EUR, GBP, JPY). Aligns with the market country.. Valid values are `^[A-Z]{3}$`',
    `discontinuation_date` DATE COMMENT 'Date on which the SKU was discontinued or withdrawn from the market. Null if the SKU is still active. Used for supply chain planning and pharmacovigilance reporting.',
    `distribution_channel` STRING COMMENT 'Primary distribution channel or customer segment for this SKU (e.g., retail pharmacy, hospital, specialty pharmacy). Impacts pricing, contracting, and supply chain routing. [ENUM-REF-CANDIDATE: retail|hospital|specialty_pharmacy|mail_order|clinic|government|veterinary — 7 candidates stripped; promote to reference product]',
    `dosage_form` STRING COMMENT 'Physical form in which the drug product is presented (e.g., tablet, capsule, injection, cream). Aligns with FDA dosage form terminology. [ENUM-REF-CANDIDATE: tablet|capsule|solution|suspension|injection|cream|ointment|patch|inhaler|suppository|powder|gel|emulsion|aerosol|implant|film|lozenge|spray — 18 candidates stripped; promote to reference product]',
    `generic_name` STRING COMMENT 'International Nonproprietary Name (INN) or United States Adopted Name (USAN) for the active pharmaceutical ingredient (API) in this SKU.',
    `gtin` STRING COMMENT 'GS1 Global Trade Item Number (GTIN-8, GTIN-12, GTIN-13, or GTIN-14) barcode identifier for the SKU. Used for supply chain tracking, point-of-sale scanning, and serialization compliance.. Valid values are `^[0-9]{8}|[0-9]{12}|[0-9]{13}|[0-9]{14}$`',
    `is_active` BOOLEAN COMMENT 'Indicates whether the SKU record is currently active in the system. False if the record has been logically deleted or archived. Used for data filtering and reporting.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the SKU master record. Used for change tracking and data governance.',
    `launch_date` DATE COMMENT 'Date on which the SKU was first made commercially available in the specified market. Used for lifecycle tracking and patent exclusivity calculations.',
    `list_price` DECIMAL(18,2) COMMENT 'Manufacturers suggested retail price or wholesale acquisition cost (WAC) for the SKU in the local currency. Used for pricing strategy, contracting, and financial planning.',
    `material_number` STRING COMMENT 'SAP S/4HANA material master number uniquely identifying this SKU in the ERP system. Serves as the primary business identifier for procurement, manufacturing, and sales operations.. Valid values are `^[A-Z0-9]{8,18}$`',
    `modified_by_user` STRING COMMENT 'User ID or name of the person who last modified the SKU master record. Required for audit trail and compliance with 21 CFR Part 11.',
    `prescription_status` STRING COMMENT 'Regulatory classification indicating whether the SKU requires a prescription (Rx), is available over-the-counter (OTC), or has restricted access. Varies by market jurisdiction.. Valid values are `prescription_only|over_the_counter|behind_the_counter|hospital_only`',
    `product_type` STRING COMMENT 'Classification of the SKU by regulatory and commercial category (e.g., branded innovator drug, generic, biosimilar, vaccine, OTC). Impacts regulatory pathway, pricing, and market access strategy. [ENUM-REF-CANDIDATE: branded|generic|biosimilar|vaccine|otc|medical_device_combination|orphan_drug — 7 candidates stripped; promote to reference product]',
    `regulatory_approval_number` STRING COMMENT 'Market-specific regulatory approval or authorization number (e.g., NDA number in US, MA number in EU, approval number in Japan). Links the SKU to its regulatory dossier.',
    `reimbursement_code` STRING COMMENT 'Market-specific reimbursement or pricing code used by payers and health authorities (e.g., HCPCS code in US, PZN in Germany). Enables claims processing and market access.',
    `rems_program` STRING COMMENT 'Name or identifier of the FDA-mandated REMS program if applicable. Null if no REMS required. REMS programs impose additional safety requirements for high-risk products.',
    `route_of_administration` STRING COMMENT 'Method by which the drug product is administered to the patient (e.g., oral, intravenous, topical). Critical for prescribing and dispensing. [ENUM-REF-CANDIDATE: oral|intravenous|intramuscular|subcutaneous|topical|transdermal|inhalation|rectal|ophthalmic|otic|nasal|sublingual|buccal — 13 candidates stripped; promote to reference product]',
    `serialization_required` BOOLEAN COMMENT 'Indicates whether the SKU is subject to serialization and track-and-trace requirements under DSCSA (US), FMD (EU), or other regional regulations. True if unique serial numbers must be applied at unit level.',
    `strength` STRING COMMENT 'Potency or concentration of the active pharmaceutical ingredient (API) in the finished dosage form, including unit of measure (e.g., 500mg, 10mg/mL, 0.5%).',
    `trade_name` STRING COMMENT 'Commercial brand name or trade name under which the SKU is marketed and sold. May differ by market or therapeutic indication.',
    CONSTRAINT pk_sku PRIMARY KEY(`sku_id`)
) COMMENT 'Stock Keeping Unit (SKU) master record representing the commercially sellable unit of a drug product at a specific strength, dosage form, and packaging configuration. Captures GTIN/EAN barcode, SAP material number, trade name, market (country/region), launch date, discontinuation date, commercial status (active, discontinued, withdrawn), and channel designation (retail, hospital, specialty pharmacy). Serves as the SSOT for commercial product identity referenced by supply chain, commercial, and finance domains. NDC codes for US-market SKUs are managed via regulatory_identifier.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`product`.`product_ndc_code` (
    `product_ndc_code_id` BIGINT COMMENT 'Unique identifier for the NDC registry record. Primary key for the product NDC code entity.',
    `inn_registry_id` BIGINT COMMENT 'Foreign key linking to masterdata.inn_registry. Business justification: NDC codes map to INN for drug classification, interoperability (HL7, FHIR), data exchange (FDA SPL). Replaces denormalized inn_name with FK to INN registry for standardized substance identification, t',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to masterdata.legal_entity. Business justification: NDC labeler code must map to legal entity for FDA establishment registration, labeling compliance, product listing. Replaces denormalized labeler_name with FK for regulatory reporting (FDA SPL submiss',
    `medicinal_product_id` BIGINT COMMENT 'Foreign key reference to the master product entity in the product domain. Links the NDC record to the internal product catalog.',
    `packaging_configuration_id` BIGINT COMMENT 'Foreign key linking to product.packaging_configuration. Business justification: NDC codes are assigned to specific packaging configurations in the FDA listing system. The package_description, package_quantity, and package_unit on product_ndc_code should reference the packaging_co',
    `active_ingredient` STRING COMMENT 'The substance or substances in the drug product responsible for the therapeutic effect. May list multiple active ingredients for combination products.',
    `application_number` STRING COMMENT 'The FDA-assigned application number for the drug product. Prefix indicates application type: NDA (New Drug Application), ANDA (Abbreviated New Drug Application for generics), or BLA (Biologics License Application).. Valid values are `^(NDA|ANDA|BLA)[0-9]{6}$`',
    `application_type` STRING COMMENT 'The type of FDA regulatory application under which the drug product is approved: NDA (New Drug Application for new molecular entities), ANDA (Abbreviated New Drug Application for generics), BLA (Biologics License Application), or OTC (Over-The-Counter, no application required).. Valid values are `NDA|ANDA|BLA|OTC`',
    `atc_code` STRING COMMENT 'The WHO Anatomical Therapeutic Chemical classification code that categorizes the drug according to the organ or system on which it acts and its therapeutic, pharmacological, and chemical properties.. Valid values are `^[A-Z][0-9]{2}[A-Z]{2}[0-9]{2}$`',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this NDC registry record was first created in the system. Used for audit trail and data lineage.',
    `dea_schedule` STRING COMMENT 'The DEA controlled substance schedule classification if the drug product contains a controlled substance. CI (Schedule I) through CV (Schedule V) indicate increasing levels of accepted medical use and decreasing abuse potential. Unscheduled indicates no controlled substance.. Valid values are `CI|CII|CIII|CIV|CV|unscheduled`',
    `dosage_form` STRING COMMENT 'The physical form of the drug product (e.g., tablet, capsule, injection, solution, cream, patch). Describes how the drug is administered.',
    `labeler_code` STRING COMMENT 'The first segment of the NDC identifying the labeler (manufacturer, repackager, or distributor). Assigned by FDA to the firm that manufactures, repacks, or distributes the drug product.. Valid values are `^[0-9]{4,5}$`',
    `last_updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this NDC registry record was last modified. Used for audit trail and change tracking.',
    `listing_date` DATE COMMENT 'The date the drug product was first listed with the FDA National Drug Code Directory. Required for all marketed drug products.',
    `listing_expiration_date` DATE COMMENT 'The date the FDA listing expires or was terminated. Null for active listings. Populated when a product is discontinued or delisted.',
    `listing_status` STRING COMMENT 'Current status of the NDC listing with FDA. Active indicates the product is currently marketed; inactive indicates listing is no longer active; discontinued indicates the product has been permanently removed from the market.. Valid values are `active|inactive|discontinued`',
    `marketing_end_date` DATE COMMENT 'The date the drug product was withdrawn from the market or discontinued. Null for products still being marketed.',
    `marketing_start_date` DATE COMMENT 'The date the drug product was first commercially marketed in the United States. This is the date the product became available for sale.',
    `ndc_number` STRING COMMENT 'The 10-digit or 11-digit FDA National Drug Code in standard format with hyphens separating labeler code, product code, and package code segments. This is the authoritative FDA-assigned identifier for the drug product.. Valid values are `^[0-9]{5}-[0-9]{4}-[0-9]{2}$|^[0-9]{5}-[0-9]{3}-[0-9]{2}$|^[0-9]{4}-[0-9]{4}-[0-9]{2}$`',
    `non_proprietary_name` STRING COMMENT 'The established or generic name of the drug product, typically the active pharmaceutical ingredient (API) name. May be the INN (International Nonproprietary Name) or USAN (United States Adopted Name).',
    `package_code` STRING COMMENT 'The third segment of the NDC identifying the package size and type for the drug product.. Valid values are `^[0-9]{2}$`',
    `product_code` STRING COMMENT 'The second segment of the NDC identifying the specific strength, dosage form, and formulation of the drug product for a particular firm.. Valid values are `^[0-9]{3,4}$`',
    `product_type` STRING COMMENT 'The regulatory classification of the drug product indicating whether it is a prescription drug, over-the-counter (OTC) drug, biologic, vaccine, or plasma derivative.. Valid values are `human prescription drug|human otc drug|human prescription drug|biologics|vaccine|plasma derivative`',
    `proprietary_name` STRING COMMENT 'The trademarked brand name under which the drug product is marketed. Also known as the trade name or brand name.',
    `reimbursement_code` STRING COMMENT 'The code used for insurance reimbursement and billing purposes, often the 11-digit NDC format required by CMS and payers.',
    `route_of_administration` STRING COMMENT 'The path by which the drug is administered to the patient (e.g., oral, intravenous, topical, subcutaneous, intramuscular).',
    `rx_otc_indicator` STRING COMMENT 'Indicates whether the drug product requires a prescription (Rx) or is available over-the-counter (OTC) without a prescription.. Valid values are `Rx|OTC`',
    `strength` STRING COMMENT 'The concentration or potency of the active pharmaceutical ingredient (API) in the drug product, including unit of measure (e.g., 500mg, 10mg/mL, 0.5%).',
    `therapeutic_equivalence_code` STRING COMMENT 'The FDA Orange Book therapeutic equivalence code indicating whether the drug product is therapeutically equivalent to other pharmaceutically equivalent products. Codes starting with A are considered therapeutically equivalent; codes starting with B are not.. Valid values are `^[A-B][A-Z]{1,2}$`',
    `usan_name` STRING COMMENT 'The United States Adopted Name for the active pharmaceutical ingredient. This is the official generic name used in the United States, often aligned with the INN.',
    CONSTRAINT pk_product_ndc_code PRIMARY KEY(`product_ndc_code_id`)
) COMMENT 'National Drug Code (NDC) registry record for each FDA-listed drug product. Captures the 10-digit NDC number (labeler, product, package segments), FDA listing status, listing date, application number linkage (NDA/ANDA/BLA), proprietary name, non-proprietary name, and DEA schedule. Serves as the authoritative NDC-to-product mapping for regulatory compliance, dispensing, and reimbursement.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`product`.`lifecycle` (
    `lifecycle_id` BIGINT COMMENT 'Unique identifier for the product lifecycle record. Primary key for tracking lifecycle stage transitions of a medicinal product from discovery through post-market discontinuation.',
    `budget_id` BIGINT COMMENT 'Foreign key linking to finance.budget. Business justification: Product lifecycle stage transitions (discovery→development→launch→maturity) drive budget allocation and reforecasting in pharmaceutical portfolio management. This link enables tracking budget consumpt',
    `medicinal_product_id` BIGINT COMMENT 'Foreign key reference to the medicinal product (Drug Product, Drug Substance, Finished Dosage Form, or SKU) whose lifecycle is being tracked. Links to the authoritative product master catalog.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Program manager accountability for milestone tracking, gate reviews, resource allocation, and cross-functional coordination. Currently stored as plain text; FK enables portfolio reporting, workload an',
    `risk_register_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_risk_register. Business justification: Lifecycle stages (development, launch, post-market surveillance, discontinuation) have distinct compliance risk profiles (trial fraud in development, promotional compliance at launch, pharmacovigilanc',
    `therapeutic_area_id` BIGINT COMMENT 'Foreign key linking to product.therapeutic_area. Business justification: product_lifecycle has therapeutic_area as a STRING attribute that should reference the therapeutic_area master table for standardized classification.',
    `actual_launch_date` DATE COMMENT 'Actual date when the product was commercially launched in the primary market. Null for products not yet launched. Used to calculate time-to-market and compare against target launch date.',
    `comments` STRING COMMENT 'Free-text field for additional context, notes, or commentary regarding the lifecycle stage transition, gate review outcomes, or strategic considerations. Supports audit trail and knowledge management.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this lifecycle record was first created in the system. Part of audit trail for data lineage and compliance with 21 CFR Part 11 electronic records requirements.',
    `discontinuation_date` DATE COMMENT 'Date when the product was formally discontinued from development or withdrawn from the market. Null for active products. Used for portfolio attrition analysis and lessons learned.',
    `discontinuation_reason` STRING COMMENT 'Primary reason for product discontinuation or development termination. Critical for portfolio risk analysis and strategic decision-making on future investments. [ENUM-REF-CANDIDATE: safety_concerns|efficacy_failure|commercial_viability|strategic_portfolio_decision|manufacturing_issues|regulatory_rejection|competitive_landscape — 7 candidates stripped; promote to reference product]',
    `exclusivity_expiry_date` DATE COMMENT 'Date when regulatory exclusivity periods (e.g., data exclusivity, market exclusivity, orphan exclusivity) expire. May differ from patent expiry and provides additional market protection.',
    `gate_criteria_met` BOOLEAN COMMENT 'Boolean flag indicating whether all predefined gate criteria for the current lifecycle stage have been successfully met. Used in stage-gate governance processes to authorize progression to next stage.',
    `gate_decision` STRING COMMENT 'Formal decision outcome from the gate review committee. Go authorizes progression, conditional_go requires specific actions, hold pauses development, kill terminates the program, recycle returns to previous stage for additional work.. Valid values are `go|conditional_go|hold|kill|recycle`',
    `gate_review_date` DATE COMMENT 'Date when the formal gate review was conducted to assess readiness for stage transition. Part of the governance process ensuring disciplined portfolio management.',
    `indication` STRING COMMENT 'Specific disease, condition, or medical indication that the product is being developed or marketed to treat. May evolve as new indications are pursued through lifecycle management strategies.',
    `investment_to_date` DECIMAL(18,2) COMMENT 'Cumulative investment amount (in USD) spent on the product from inception through the current lifecycle stage. Includes R&D costs, clinical trial expenses, regulatory submission costs, and manufacturing setup. Used for ROI analysis and portfolio valuation.',
    `is_active` BOOLEAN COMMENT 'Boolean flag indicating whether this lifecycle record is the current active record for the product. Supports temporal tracking and historical analysis of lifecycle transitions.',
    `lifecycle_status` STRING COMMENT 'Current operational status within the lifecycle stage. Distinguishes between active progression, temporary holds, suspensions due to safety or regulatory issues, terminations, and completion of stage milestones.. Valid values are `active|on_hold|suspended|terminated|completed|pending_approval`',
    `milestone_date` DATE COMMENT 'Date when the milestone event occurred. May differ from stage_entry_date if there is administrative lag between milestone achievement and formal stage transition recording.',
    `milestone_event` STRING COMMENT 'Description of the key milestone event that triggered the current lifecycle stage transition (e.g., IND Submission Accepted, Phase III Primary Endpoint Met, FDA Approval Granted, Commercial Launch Completed). Provides business context for stage changes.',
    `modified_by` STRING COMMENT 'User identifier or system account that last modified this lifecycle record. Required for audit trail and accountability per 21 CFR Part 11 and SOX compliance.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this lifecycle record was last modified. Tracks data currency and supports change control processes required for GxP compliance.',
    `next_planned_stage` STRING COMMENT 'The anticipated next lifecycle stage based on current development plans. Used for forward-looking portfolio planning and resource forecasting. May be null for discontinued or terminated products. [ENUM-REF-CANDIDATE: discovery|preclinical|phase_i|phase_ii|phase_iii|nda_bla_submission|maa_submission|approved|launched|loe|discontinued — 11 candidates stripped; promote to reference product]',
    `patent_expiry_date` DATE COMMENT 'Date when the primary patent protection expires, marking the beginning of loss of exclusivity (LOE) period. Critical for lifecycle management planning and generic competition forecasting.',
    `previous_stage` STRING COMMENT 'The immediately preceding lifecycle stage before the current stage. Enables tracking of stage transitions and identification of products that have been moved backward (e.g., from Phase III back to Phase II due to protocol amendments). [ENUM-REF-CANDIDATE: discovery|preclinical|phase_i|phase_ii|phase_iii|nda_bla_submission|maa_submission|approved|launched|loe|discontinued — 11 candidates stripped; promote to reference product]',
    `probability_of_success` DECIMAL(18,2) COMMENT 'Estimated probability (as percentage, 0.00 to 100.00) that the product will successfully progress through all remaining lifecycle stages to commercial launch. Based on historical success rates, clinical data, and competitive landscape. Used in risk-adjusted portfolio valuation (rNPV).',
    `projected_peak_sales` DECIMAL(18,2) COMMENT 'Forecasted annual peak sales revenue (in USD) for the product at market maturity. Used for portfolio prioritization, resource allocation, and commercial planning. Updated as market intelligence and clinical data evolve.',
    `regulatory_pathway` STRING COMMENT 'Regulatory approval pathway or designation assigned by health authorities (FDA, EMA, PMDA). Influences development timelines, data requirements, and commercial strategy. [ENUM-REF-CANDIDATE: standard|fast_track|breakthrough|priority_review|accelerated_approval|orphan_drug|biosimilar|generic_505b2 — 8 candidates stripped; promote to reference product]',
    `responsible_team` STRING COMMENT 'Name or identifier of the functional team or business unit responsible for managing the product during the current lifecycle stage (e.g., Discovery Biology, Clinical Development Oncology, Regulatory Affairs, Commercial Launch Team).',
    `stage` STRING COMMENT 'Current stage of the medicinal product in its development and commercial lifecycle. Tracks progression from early research through regulatory approval, market launch, loss of exclusivity (LOE), and eventual discontinuation. Critical for portfolio planning and resource allocation. [ENUM-REF-CANDIDATE: discovery|preclinical|phase_i|phase_ii|phase_iii|nda_bla_submission|maa_submission|approved|launched|loe|discontinued — 11 candidates stripped; promote to reference product]',
    `stage_entry_date` DATE COMMENT 'Date when the product entered the current lifecycle stage. Used to calculate time-in-stage metrics and track development velocity against portfolio benchmarks.',
    `stage_exit_date` DATE COMMENT 'Date when the product exited or is expected to exit the current lifecycle stage. Nullable for products still in active stage. Critical for forecasting and resource planning.',
    `strategic_priority` STRING COMMENT 'Strategic importance ranking assigned by portfolio management based on alignment with corporate strategy, unmet medical need, commercial potential, and competitive positioning.. Valid values are `high|medium|low`',
    `target_launch_date` DATE COMMENT 'Planned or forecasted commercial launch date for the product. Updated as development progresses and regulatory timelines become clearer. Critical for commercial planning and supply chain readiness.',
    CONSTRAINT pk_lifecycle PRIMARY KEY(`lifecycle_id`)
) COMMENT 'Tracks the lifecycle stage and status transitions of a medicinal product from discovery through post-market, including pipeline stage (discovery, preclinical, Phase I/II/III, NDA/BLA submission, approved, launched, LOE, discontinued). Captures stage entry date, exit date, milestone events, responsible team, and lifecycle gate criteria. Provides the authoritative product lifecycle timeline referenced by portfolio planning and regulatory domains.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`product`.`regulatory_identifier` (
    `regulatory_identifier_id` BIGINT COMMENT 'Unique identifier for the regulatory identifier record. Primary key.',
    `country_id` BIGINT COMMENT 'Foreign key linking to masterdata.country. Business justification: Regulatory identifiers jurisdiction-specific (FDA=US, EMA=EU, PMDA=Japan). Replaces denormalized jurisdiction string with FK to country master for regulatory intelligence (approval tracking by country',
    `inn_registry_id` BIGINT COMMENT 'Foreign key linking to masterdata.inn_registry. Business justification: Regulatory identifiers reference INN for substance identification, global harmonization (IDMP), regulatory data exchange. Replaces denormalized inn with FK to INN registry for standardized nomenclatur',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to masterdata.legal_entity. Business justification: Regulatory approvals (NDA, BLA, MAA) granted to specific legal entities (Marketing Authorization Holder). Critical for regulatory compliance, pharmacovigilance (ICSR case processing), regulatory intel',
    `medicinal_product_id` BIGINT COMMENT 'Reference to the pharmaceutical product (Drug Product or Drug Substance) to which this regulatory identifier is assigned.',
    `packaging_configuration_id` BIGINT COMMENT 'Foreign key linking to product.packaging_configuration. Business justification: Regulatory identifiers are often specific to packaging configurations, especially in jurisdictions where different pack sizes require separate approval numbers or listing codes. This links the regulat',
    `therapeutic_area_id` BIGINT COMMENT 'Foreign key linking to product.therapeutic_area. Business justification: regulatory_identifier has therapeutic_area as a STRING attribute that should reference the therapeutic_area master table for standardized classification.',
    `application_number` STRING COMMENT 'The regulatory application number associated with this identifier (e.g., IND number, NDA number, BLA number). Links the identifier to the original regulatory submission.',
    `approval_date` DATE COMMENT 'The date on which the regulatory authority approved the product and assigned this identifier.',
    `approval_status` STRING COMMENT 'The current regulatory approval status of the product under this identifier (e.g., Approved, Pending, Withdrawn, Suspended, Expired, Rejected).. Valid values are `Approved|Pending|Withdrawn|Suspended|Expired|Rejected`',
    `atc_code` STRING COMMENT 'The Anatomical Therapeutic Chemical classification code assigned to the product for therapeutic categorization.. Valid values are `^[A-Z][0-9]{2}[A-Z]{2}[0-9]{2}$`',
    `breakthrough_therapy_designation` BOOLEAN COMMENT 'Indicates whether the product has been granted breakthrough therapy designation by the regulatory authority for serious or life-threatening conditions.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this regulatory identifier record was first created in the system.',
    `dea_schedule` STRING COMMENT 'The DEA controlled substance schedule classification for the product, if applicable (e.g., Schedule II, Schedule III, Schedule IV, Schedule V, or Non-Controlled).. Valid values are `Schedule I|Schedule II|Schedule III|Schedule IV|Schedule V|Non-Controlled`',
    `dosage_form` STRING COMMENT 'The finished dosage form of the product as registered with the regulatory authority (e.g., tablet, capsule, injection, solution, suspension).',
    `exclusivity_expiration_date` DATE COMMENT 'The date on which the regulatory exclusivity period expires, after which generic or biosimilar versions may be approved.',
    `expiration_date` DATE COMMENT 'The date on which the regulatory identifier or approval expires, if applicable. Null if the approval has no expiration.',
    `fast_track_designation` BOOLEAN COMMENT 'Indicates whether the product has been granted fast track designation by the regulatory authority to expedite development and review.',
    `identifier_number` STRING COMMENT 'The actual regulatory identifier or listing code assigned by the health authority (e.g., NDA number, BLA number, MAA number, NDC code, JNDA number, PMDA approval number, NMPA registration number).',
    `identifier_type` STRING COMMENT 'The type or category of regulatory identifier (e.g., NDA for New Drug Application, ANDA for Abbreviated New Drug Application, BLA for Biologics License Application, MAA for Marketing Authorization Application, NDC for National Drug Code). [ENUM-REF-CANDIDATE: NDA|ANDA|BLA|MAA|JNDA|PMDA Approval Number|NMPA Registration Number|NDC|EMA Product Number|Other — 10 candidates stripped; promote to reference product]',
    `issuing_authority` STRING COMMENT 'The regulatory health authority or governing body that issued this identifier (e.g., FDA, EMA, MHRA, PMDA, NMPA, WHO). [ENUM-REF-CANDIDATE: FDA|EMA|MHRA|PMDA|NMPA|WHO|Other — 7 candidates stripped; promote to reference product]',
    `last_updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this regulatory identifier record was last modified in the system.',
    `listing_date` DATE COMMENT 'The date on which the product was officially listed with the regulatory authority under this identifier. Particularly relevant for NDC listings with FDA.',
    `listing_status` STRING COMMENT 'The current listing status of the product with the regulatory authority (e.g., Active, Inactive, Discontinued). Indicates whether the product is currently marketed.. Valid values are `Active|Inactive|Discontinued`',
    `marketing_category` STRING COMMENT 'The marketing category or classification of the product as defined by the regulatory authority (e.g., NDA, ANDA, BLA, OTC Monograph).',
    `ndc_labeler_code` STRING COMMENT 'The labeler segment of the 10-digit NDC code, identifying the manufacturer or distributor. Applicable for US FDA NDC identifiers.. Valid values are `^[0-9]{4,5}$`',
    `ndc_package_code` STRING COMMENT 'The package segment of the 10-digit NDC code, identifying the package size and type. Applicable for US FDA NDC identifiers.. Valid values are `^[0-9]{1,2}$`',
    `ndc_product_code` STRING COMMENT 'The product segment of the 10-digit NDC code, identifying the specific strength, dosage form, and formulation. Applicable for US FDA NDC identifiers.. Valid values are `^[0-9]{3,4}$`',
    `non_proprietary_name` STRING COMMENT 'The generic or non-proprietary name of the product (e.g., INN - International Nonproprietary Name, USAN - United States Adopted Name) as registered with the regulatory authority.',
    `orphan_drug_designation` BOOLEAN COMMENT 'Indicates whether the product has been granted orphan drug designation by the regulatory authority for treatment of rare diseases.',
    `priority_review_designation` BOOLEAN COMMENT 'Indicates whether the product has been granted priority review designation by the regulatory authority to shorten the review timeline.',
    `proprietary_name` STRING COMMENT 'The brand or trade name of the product as registered with the regulatory authority under this identifier.',
    `rems_required` BOOLEAN COMMENT 'Indicates whether a Risk Evaluation and Mitigation Strategy is required by the regulatory authority to ensure the benefits of the product outweigh its risks.',
    `renewal_date` DATE COMMENT 'The date on which the regulatory approval or listing was last renewed with the health authority.',
    `route_of_administration` STRING COMMENT 'The route by which the product is administered as registered with the regulatory authority (e.g., oral, intravenous, subcutaneous, topical).',
    `strength` STRING COMMENT 'The strength or potency of the active pharmaceutical ingredient in the product as registered with the regulatory authority (e.g., 500mg, 10mg/mL).',
    `usan` STRING COMMENT 'The United States Adopted Name for the active pharmaceutical ingredient, assigned by the USAN Council.',
    `withdrawal_date` DATE COMMENT 'The date on which the product was withdrawn from the market or the regulatory identifier was revoked by the health authority.',
    `withdrawal_reason` STRING COMMENT 'The reason for withdrawal of the product or revocation of the regulatory identifier (e.g., safety concerns, commercial decision, regulatory non-compliance).',
    CONSTRAINT pk_regulatory_identifier PRIMARY KEY(`regulatory_identifier_id`)
) COMMENT 'Unified catalog of regulatory product identifiers and listing codes assigned by health authorities across all jurisdictions. Captures NDA, ANDA, BLA, MAA, JNDA, EMA product numbers, PMDA approval numbers, NMPA registration numbers, and National Drug Codes (NDC — 10-digit labeler-product-package segments with FDA listing status, listing date, application number linkage, proprietary/non-proprietary names, and DEA schedule). Records identifier type, issuing authority, application number, approval date, approval status, jurisdiction, and listing metadata. Serves as the single source of truth for cross-jurisdiction regulatory identity, product listing, and dispensing/reimbursement code mapping for each drug product.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`product`.`indication` (
    `indication_id` BIGINT COMMENT 'Unique identifier for the product-indication association record. Primary key for this entity.',
    `country_id` BIGINT COMMENT 'Foreign key linking to masterdata.country. Business justification: Indications approved per country/jurisdiction for labeling (country-specific claims), reimbursement (HTA submissions), medical affairs (country-specific medical information). Replaces denormalized app',
    `atc_classification_id` BIGINT COMMENT 'Foreign key linking to masterdata.atc_classification. Business justification: Indication-level ATC classification for therapeutic categorization, reimbursement coding (HTA submissions), pharmacoepidemiology studies, formulary management. Replaces denormalized atc_code string wi',
    `medicinal_product_id` BIGINT COMMENT 'Reference to the medicinal product (Drug Product (DP), Drug Substance (DS), or Finished Dosage Form (FDF)) associated with this indication.',
    `therapeutic_area_id` BIGINT COMMENT 'Foreign key linking to product.therapeutic_area. Business justification: product_indication has therapeutic_area as a STRING attribute that should reference the therapeutic_area master table for standardized classification.',
    `approval_date` DATE COMMENT 'Date on which the regulatory authority granted marketing authorization for this product-indication combination. Null for investigational or non-approved indications.',
    `approval_status` STRING COMMENT 'Current regulatory approval status of the product for this specific indication. Approved indicates marketing authorization granted; investigational indicates clinical trial phase; withdrawn indicates voluntary or regulatory removal; pending indicates under review; rejected indicates application denied; suspended indicates temporary hold.. Valid values are `approved|investigational|withdrawn|pending|rejected|suspended`',
    `biomarker_requirement` STRING COMMENT 'Description of any required biomarker, genetic marker, or diagnostic test result that must be present for the patient to be eligible for this indication. Examples include specific gene mutations, protein expression levels, or companion diagnostic test results. Null if no biomarker requirement exists.',
    `black_box_warning_flag` BOOLEAN COMMENT 'Boolean indicator of whether the product label contains a boxed warning (black box warning) for this indication, highlighting serious or life-threatening risks. True indicates boxed warning present; False indicates no boxed warning.',
    `breakthrough_designation_flag` BOOLEAN COMMENT 'Boolean indicator of whether this product-indication combination has received breakthrough therapy designation from FDA, indicating preliminary clinical evidence of substantial improvement over existing therapies for serious conditions. True indicates breakthrough designation granted; False indicates not designated.',
    `clinical_trial_identifier` STRING COMMENT 'Primary clinical trial registry identifier for the pivotal study that supported approval of this product-indication combination. Format examples: NCT########, EUCTR####-######-##, ISRCTN########. Null for indications not yet in clinical trials or approved without trial data.. Valid values are `^NCT[0-9]{8}$|^EUCTR[0-9]{4}-[0-9]{6}-[0-9]{2}$|^ISRCTN[0-9]{8}$`',
    `combination_partners` STRING COMMENT 'List or description of other drugs, biologics, or therapeutic modalities that are approved or recommended for use in combination with this product for this indication. Null if monotherapy or combination_therapy_flag is False.',
    `combination_therapy_flag` BOOLEAN COMMENT 'Boolean indicator of whether this indication requires or recommends the product be used in combination with other therapeutic agents. True indicates combination therapy; False indicates monotherapy or therapy-agnostic indication.',
    `contraindication_summary` STRING COMMENT 'Summary of absolute contraindications or patient populations for whom this product-indication is not recommended or is prohibited due to safety concerns. Includes conditions, co-medications, or patient characteristics that preclude use.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this product-indication association record was first created in the master data system. Immutable audit field for data lineage and compliance tracking.',
    `disease_severity` STRING COMMENT 'The severity classification of the disease or condition for which this indication applies. Mild indicates minor symptoms; moderate indicates significant symptoms; severe indicates major impact on function; critical indicates immediate life risk; life_threatening indicates high mortality risk; not_applicable for preventive indications.. Valid values are `mild|moderate|severe|critical|life_threatening|not_applicable`',
    `effective_date` DATE COMMENT 'Date from which this product-indication association record became active and valid for operational use. Represents the start of the records validity period in the master data system.',
    `exclusivity_expiry_date` DATE COMMENT 'Date on which regulatory market exclusivity protections expire for this product-indication combination. Exclusivity types include new chemical entity exclusivity, orphan drug exclusivity, pediatric exclusivity, or biologics exclusivity. Null if no exclusivity applies or has already expired.',
    `expiry_date` DATE COMMENT 'Date on which this product-indication association record is no longer valid or active. Null indicates the record is currently active with no planned expiration. Used for temporal tracking and historical analysis.',
    `icd_10_code` STRING COMMENT 'ICD-10 diagnosis code representing the disease or condition for which the product is indicated.. Valid values are `^[A-Z][0-9]{2}(.[0-9]{1,2})?$`',
    `icd_10_description` STRING COMMENT 'Full text description of the ICD-10 code representing the disease or condition.',
    `indication_name` STRING COMMENT 'The common or clinical name of the therapeutic indication or disease state that the product is approved or being investigated to treat.',
    `indication_type` STRING COMMENT 'The therapeutic purpose or clinical use category of the product for this indication. Treatment is active disease management; prevention is disease avoidance; diagnosis is disease detection; prophylaxis is pre-exposure prevention; palliation is symptom relief; risk_reduction is lowering disease probability.. Valid values are `treatment|prevention|diagnosis|prophylaxis|palliation|risk_reduction`',
    `label_claim_text` STRING COMMENT 'The exact verbatim text from the approved product label or package insert describing the indication, including any limitations, patient population specifics, or conditional use statements. This is the regulatory-approved language for marketing and prescribing.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this product-indication association record was most recently updated or modified. Updated with each change for audit trail and data quality monitoring.',
    `line_of_therapy` STRING COMMENT 'The treatment sequence position in the therapeutic regimen for which this product is indicated. First-line is initial treatment; second/third/fourth-line are subsequent treatments after prior therapy failure; adjuvant is post-surgery; neoadjuvant is pre-surgery; maintenance is long-term disease control; salvage is rescue therapy; palliative is symptom management. [ENUM-REF-CANDIDATE: first_line|second_line|third_line|fourth_line_plus|adjuvant|neoadjuvant|maintenance|salvage|palliative — 9 candidates stripped; promote to reference product]',
    `meddra_pt_code` STRING COMMENT 'Eight-digit MedDRA Preferred Term code representing the standardized medical terminology for the indication.. Valid values are `^[0-9]{8}$`',
    `meddra_pt_name` STRING COMMENT 'The MedDRA Preferred Term name corresponding to the MedDRA PT code for standardized indication classification.',
    `orphan_designation_flag` BOOLEAN COMMENT 'Boolean indicator of whether this product-indication combination has received orphan drug designation for a rare disease (typically affecting fewer than 200,000 patients in the US or fewer than 5 in 10,000 in the EU). True indicates orphan designation granted; False indicates not designated.',
    `patent_expiry_date` DATE COMMENT 'Date on which the primary patent protection expires for this product-indication combination, after which generic or biosimilar competition may enter the market. Represents the latest expiring patent covering the indication. Null if no patent protection or already expired.',
    `patient_population` STRING COMMENT 'The age-based patient population segment for which this indication is approved or being studied. Adult typically 18-64 years; pediatric under 18 years; geriatric 65+ years; neonatal under 1 month; adolescent 12-17 years; all_ages indicates no age restriction.. Valid values are `adult|pediatric|geriatric|neonatal|adolescent|all_ages`',
    `record_status` STRING COMMENT 'Current lifecycle status of this product-indication association record in the master data system. Active indicates currently valid; inactive indicates no longer in use; pending indicates awaiting approval; superseded indicates replaced by newer record; withdrawn indicates removed from use.. Valid values are `active|inactive|pending|superseded|withdrawn`',
    `rems_required_flag` BOOLEAN COMMENT 'Boolean indicator of whether FDA requires a Risk Evaluation and Mitigation Strategy program for this product-indication to ensure benefits outweigh risks. REMS may include medication guides, communication plans, or restricted distribution. True indicates REMS required; False indicates no REMS.',
    CONSTRAINT pk_indication PRIMARY KEY(`indication_id`)
) COMMENT 'Association record linking a medicinal product to its approved or investigational therapeutic indications, capturing indication name, MedDRA preferred term, ICD-10 code, approval status by jurisdiction, approval date, patient population (adult, pediatric, geriatric), line of therapy, and label claim text. Tracks both approved and pipeline indications to support regulatory, medical affairs, and commercial strategies.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`product`.`labeling` (
    `labeling_id` BIGINT COMMENT 'Unique identifier for the product labeling record. Primary key for the product labeling entity.',
    `compliance_capa_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_capa. Business justification: Labeling deficiencies identified in FDA inspections (missing warnings, outdated safety information) trigger compliance CAPAs requiring label updates. Business links CAPA to specific label version to d',
    `country_id` BIGINT COMMENT 'Foreign key linking to masterdata.country. Business justification: Product labels country-specific for regulatory compliance (country-specific labeling requirements), language requirements, safety updates (country-specific label changes). Replaces denormalized jurisd',
    `drug_product_id` BIGINT COMMENT 'Reference to the drug product for which this label applies. Links to the master product catalog.',
    `inspection_observation_id` BIGINT COMMENT 'Foreign key linking to compliance.inspection_observation. Business justification: Inspection observations frequently cite specific labeling deficiencies (Form 483: Product labeling lacks required pregnancy warning per 21 CFR 201.57). Business links observation to exact label vers',
    `label_id` BIGINT COMMENT 'Unique document identifier or reference number for the label file stored in the document management system (e.g., Veeva Vault document ID).',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to masterdata.legal_entity. Business justification: Product labels approved for specific legal entities (MAH) per jurisdiction. Required for regulatory compliance (label changes, safety updates), pharmacovigilance (labeling assessment for ICSRs), regul',
    `orange_book_listing_id` BIGINT COMMENT 'Foreign key linking to intellectual.orange_book_listing. Business justification: FDA-approved labeling must align with Orange Book patent listings for Paragraph IV defense, generic competition monitoring, and regulatory compliance. Critical for patent-label consistency.',
    `packaging_configuration_id` BIGINT COMMENT 'Foreign key linking to product.packaging_configuration. Business justification: Product labeling is specific to a packaging configuration (different pack sizes may have different labels, especially for dosing instructions and NDC codes). The ndc_code on product_labeling should re',
    `policy_document_id` BIGINT COMMENT 'Foreign key linking to compliance.policy_document. Business justification: Labeling review/approval workflows reference governing SOPs and policies. Pharmaceutical operations track which policy version (e.g., Labeling Review SOP v3.2) governed each label approval to demons',
    `adverse_reactions_text` STRING COMMENT 'Full text of the Adverse Reactions section from the label, summarizing the most common and serious adverse events observed in clinical trials and post-marketing surveillance.',
    `approval_date` DATE COMMENT 'Date when the regulatory authority officially approved this label version.',
    `atc_code` STRING COMMENT 'WHO Anatomical Therapeutic Chemical classification code for the drug product, used for international drug utilization research and statistics.. Valid values are `^[A-Z][0-9]{2}[A-Z]{2}[0-9]{2}$`',
    `black_box_warning_flag` BOOLEAN COMMENT 'Indicates whether the label contains a black box warning (boxed warning) highlighting serious or life-threatening risks. True if present, False otherwise.',
    `clinical_pharmacology_text` STRING COMMENT 'Full text of the Clinical Pharmacology section from the label, describing the mechanism of action (MOA), pharmacokinetics (PK), and pharmacodynamics (PD) of the drug product.',
    `contraindications_text` STRING COMMENT 'Full text of the Contraindications section from the label, listing situations where the drug product should not be used due to risk of harm.',
    `controlled_substance_schedule` STRING COMMENT 'DEA controlled substance classification schedule if the drug product is a controlled substance. Schedule I through V indicate increasing levels of medical use and decreasing abuse potential. Not Controlled if the product is not a controlled substance.. Valid values are `Schedule I|Schedule II|Schedule III|Schedule IV|Schedule V|Not Controlled`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this product labeling record was first created in the system.',
    `dosage_administration_text` STRING COMMENT 'Full text of the Dosage and Administration section from the label, providing instructions on how to prescribe, prepare, and administer the drug product.',
    `dosage_form` STRING COMMENT 'The physical form of the finished drug product as it is administered (e.g., tablet, capsule, injection, solution, cream). Follows FDA or EMA standard terms for dosage forms.',
    `drug_interactions_text` STRING COMMENT 'Full text of the Drug Interactions section from the label, describing known interactions with other drugs, foods, or substances that may affect efficacy or safety.',
    `ectd_sequence_number` STRING COMMENT 'The eCTD sequence number associated with the regulatory submission that included this label version. Used for tracking regulatory submission history.. Valid values are `^[0-9]{4}$`',
    `effective_date` DATE COMMENT 'Date when this label version becomes effective and must be used for all product distribution and prescribing information.',
    `established_name` STRING COMMENT 'The non-proprietary or generic name of the drug product, typically the International Nonproprietary Name (INN) or United States Adopted Name (USAN).',
    `expiration_date` DATE COMMENT 'Date when this label version is superseded or no longer valid. Null if the label is currently active with no planned replacement.',
    `indications_text` STRING COMMENT 'Full text of the Indications and Usage section from the label, describing the approved therapeutic uses and patient populations for the drug product.',
    `label_language_code` STRING COMMENT 'Two-letter ISO 639-1 language code indicating the language in which the label is written (e.g., en for English, es for Spanish, ja for Japanese).. Valid values are `^[a-z]{2}$`',
    `label_status` STRING COMMENT 'Current lifecycle status of the label. Draft = under development, Submitted = filed with regulatory authority, Approved = authorized but not yet effective, Active = currently in use, Superseded = replaced by newer version, Withdrawn = removed from use.. Valid values are `draft|submitted|approved|active|superseded|withdrawn`',
    `label_type` STRING COMMENT 'Type of product label document. USPI = US Prescribing Information, SmPC = Summary of Product Characteristics (EU), PIL = Patient Information Leaflet, IFU = Instructions for Use.. Valid values are `USPI|SmPC|PIL|Carton|Container|IFU`',
    `label_version` STRING COMMENT 'Version number of the product label following semantic versioning (e.g., 1.0, 2.1). Incremented with each regulatory update or revision.. Valid values are `^[0-9]+.[0-9]+$`',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this product labeling record was last modified or updated.',
    `pregnancy_category` STRING COMMENT 'Legacy FDA pregnancy category (A, B, C, D, X) for products approved before the Pregnancy and Lactation Labeling Rule (PLLR). Not Applicable for products approved after PLLR implementation.. Valid values are `A|B|C|D|X|Not Applicable`',
    `proprietary_name` STRING COMMENT 'The brand or trade name under which the drug product is marketed. This is the commercial name used in labeling and promotion.',
    `regulatory_approval_number` STRING COMMENT 'Official approval or authorization number issued by the regulatory authority for this label. Examples: NDA number (FDA), MAA number (EMA), PMDA approval number.',
    `rems_required_flag` BOOLEAN COMMENT 'Indicates whether a Risk Evaluation and Mitigation Strategy (REMS) program is required for this product as mandated by FDA. True if REMS is required, False otherwise.',
    `route_of_administration` STRING COMMENT 'The path by which the drug product is administered to the patient (e.g., oral, intravenous, subcutaneous, topical, inhalation). Follows FDA or EMA standard terms.',
    `rx_otc_status` STRING COMMENT 'Indicates whether the product requires a prescription (Rx), is available over-the-counter (OTC), or is behind-the-counter (BTC) requiring pharmacist consultation.. Valid values are `Rx|OTC|BTC`',
    `strength` STRING COMMENT 'The amount of active pharmaceutical ingredient (API) per dosage unit, expressed with unit of measure (e.g., 500 mg, 10 mg/mL, 5%).',
    `use_in_specific_populations_text` STRING COMMENT 'Full text of the Use in Specific Populations section from the label, providing information on use in pregnancy, lactation, pediatric, geriatric, and patients with renal or hepatic impairment.',
    `warnings_precautions_text` STRING COMMENT 'Full text of the Warnings and Precautions section from the label, describing serious adverse reactions, potential safety hazards, and steps to prevent or manage them.',
    CONSTRAINT pk_labeling PRIMARY KEY(`labeling_id`)
) COMMENT 'Master record for the approved product label (prescribing information / SmPC / package insert) for each drug product by jurisdiction. Captures label version, effective date, label type (USPI, SmPC, PIL), regulatory approval reference, black box warning flag, REMS requirement flag, controlled substance schedule, and key label sections (indications, dosing, contraindications, warnings). Supports pharmacovigilance, medical affairs, and regulatory compliance.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`product`.`product_change_control` (
    `product_change_control_id` BIGINT COMMENT 'Unique identifier for the product change control record. Primary key.',
    `protocol_id` BIGINT COMMENT 'Reference to the comparability protocol used to assess whether the change maintains product comparability and does not adversely affect quality, safety, or efficacy.',
    `compliance_capa_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_capa. Business justification: Product changes frequently implement regulatory commitments from inspection responses or warning letters. Business tracks which compliance CAPA (e.g., WL-2023-001 CAPA: Update manufacturing process)',
    `inspection_response_id` BIGINT COMMENT 'Foreign key linking to compliance.inspection_response. Business justification: Inspection responses commit to specific product changes (process improvements, specification tightening, equipment upgrades). Business tracks which change control implements which inspection commitmen',
    `medicinal_product_id` BIGINT COMMENT 'Reference to the pharmaceutical product affected by this change control. Links to the master product catalog.',
    `site_id` BIGINT COMMENT 'Reference to the manufacturing site affected by or implementing this change. Relevant for manufacturing site changes, process modifications, or equipment updates.',
    `affected_markets` STRING COMMENT 'Comma-separated list of geographic markets or regulatory jurisdictions affected by this change (e.g., USA, EU, JPN, CHN). Supports multi-market change coordination and regulatory strategy.',
    `approval_date` DATE COMMENT 'Date when the health authority officially approved the change. Null if pending approval or if approval is not required for the change type.',
    `approved_by` STRING COMMENT 'Name or identifier of the quality assurance or regulatory affairs authority who approved the change control for implementation. Required for GMP compliance and audit trail.',
    `change_category` STRING COMMENT 'Business category of the change indicating the affected area. CMC (Chemistry, Manufacturing, and Controls), manufacturing site, labeling, safety update, specification change, packaging, stability protocol, process parameter, analytical method, or excipient modification. [ENUM-REF-CANDIDATE: CMC|Manufacturing Site|Labeling|Safety|Specification|Packaging|Stability|Process|Analytical Method|Excipient — 10 candidates stripped; promote to reference product]',
    `change_control_number` STRING COMMENT 'Unique business identifier for the change control record, typically assigned by the Quality Management System (QMS) or Regulatory Information Management System (RIMS). Format: CC-NNNNNN.. Valid values are `^CC-[0-9]{6,10}$`',
    `change_description` STRING COMMENT 'Detailed narrative description of the proposed or implemented change, including rationale, scope, and technical details. Captures the business justification and scientific basis for the modification.',
    `change_status` STRING COMMENT 'Current lifecycle status of the change control record within the regulatory and quality management workflow. [ENUM-REF-CANDIDATE: Draft|Submitted|Under Review|Approved|Rejected|Implemented|Withdrawn|Closed — 8 candidates stripped; promote to reference product]',
    `change_type` STRING COMMENT 'Classification of the regulatory change according to the applicable regulatory framework. Type IA/IB/II for EMA variations, PAS (Prior Approval Supplement), CBE (Changes Being Effected) for FDA, or Partial Change Application for PMDA. [ENUM-REF-CANDIDATE: Type IA|Type IB|Type II|PAS|CBE-30|CBE-0|Annual Report|Partial Change Application|Major Variation|Minor Variation — 10 candidates stripped; promote to reference product]',
    `closure_date` DATE COMMENT 'Date when the change control record was formally closed after successful implementation and verification. Marks the completion of the change lifecycle.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the change control record was first created in the system. Audit trail field for regulatory compliance and data lineage.',
    `document_reference` STRING COMMENT 'Reference to supporting documentation stored in the document management system (e.g., Veeva Vault), including change control forms, technical reports, validation protocols, and regulatory correspondence.',
    `ectd_sequence_number` STRING COMMENT 'eCTD sequence number assigned to the regulatory submission package for this change. Four-digit sequence number used for electronic submission tracking.. Valid values are `^[0-9]{4}$`',
    `effective_date` DATE COMMENT 'Date from which the change becomes legally effective and binding for regulatory compliance purposes. May differ from implementation date based on regulatory requirements.',
    `efficacy_impact_level` STRING COMMENT 'Assessed level of impact on product efficacy and therapeutic performance. High or Critical levels may require additional clinical data or bioequivalence studies.. Valid values are `None|Low|Medium|High|Critical`',
    `health_authority` STRING COMMENT 'Primary regulatory health authority to which this change was submitted. FDA (US), EMA (EU), MHRA (UK), PMDA (Japan), NMPA (China), Health Canada, TGA (Australia), Swissmedic (Switzerland), ANVISA (Brazil), COFEPRIS (Mexico). [ENUM-REF-CANDIDATE: FDA|EMA|MHRA|PMDA|NMPA|Health Canada|TGA|Swissmedic|ANVISA|COFEPRIS — 10 candidates stripped; promote to reference product]',
    `impact_assessment` STRING COMMENT 'Comprehensive assessment of the changes impact on product quality, safety, efficacy, manufacturing process, supply chain, and regulatory compliance. Documents risk analysis and mitigation strategies.',
    `implementation_date` DATE COMMENT 'Date when the approved change was or will be implemented in commercial manufacturing, distribution, or labeling. Critical for supply chain and manufacturing execution planning.',
    `initiated_by` STRING COMMENT 'Name or identifier of the person or department who initiated the change control request. Supports accountability and audit trail requirements.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the change control record was last modified. Supports audit trail, version control, and regulatory inspection readiness.',
    `notification_required_flag` BOOLEAN COMMENT 'Indicates whether regulatory notification to the health authority is required for this change type. True if notification is mandatory, False if the change can be implemented without prior notification.',
    `prior_approval_required_flag` BOOLEAN COMMENT 'Indicates whether prior approval from the health authority is required before implementing the change. True for PAS (Prior Approval Supplement) or Type II variations, False for CBE or Type IA/IB.',
    `quality_impact_level` STRING COMMENT 'Assessed level of impact on product quality attributes (CQA - Critical Quality Attributes). Drives the rigor of validation and testing requirements.. Valid values are `None|Low|Medium|High|Critical`',
    `regulatory_commitment` STRING COMMENT 'Description of any commitments made to the health authority as part of the change approval, such as post-approval studies, annual reports, or specific monitoring activities.',
    `safety_impact_level` STRING COMMENT 'Assessed level of impact on patient safety and product safety profile. High or Critical levels trigger additional pharmacovigilance and risk management activities.. Valid values are `None|Low|Medium|High|Critical`',
    `stability_study_required_flag` BOOLEAN COMMENT 'Indicates whether additional stability studies are required to support the change. True if new stability data must be generated to demonstrate product shelf-life is maintained.',
    `submission_date` DATE COMMENT 'Date when the change control was officially submitted to the health authority for review and approval.',
    `submission_number` STRING COMMENT 'Official regulatory submission identifier assigned by the health authority (e.g., FDA supplement number, EMA variation number, PMDA application number). May be null if not yet submitted.',
    `validation_required_flag` BOOLEAN COMMENT 'Indicates whether process validation, analytical method validation, or computer system validation (CSV) is required to support this change. True if validation activities are mandatory.',
    CONSTRAINT pk_product_change_control PRIMARY KEY(`product_change_control_id`)
) COMMENT 'Transactional record capturing post-approval changes and variations to drug product registrations, including Type IA/IB/II variations (EMA), Prior Approval Supplements (PAS), Changes Being Effected (CBE-30/CBE-0), Annual Reports (FDA), and PMDA partial change applications. Captures change description, change category (CMC, labeling, safety, manufacturing site), affected markets, submission numbers, implementation date, health authority notification/approval status, and impact assessment on product quality, safety, and efficacy. Bridges regulatory affairs and quality change management workflows.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`product`.`combination_product` (
    `combination_product_id` BIGINT COMMENT 'Unique identifier for the combination product record. Primary key.',
    `atc_classification_id` BIGINT COMMENT 'Foreign key linking to masterdata.atc_classification. Business justification: Combination products classified by primary ATC (drug constituent) for regulatory categorization, market analysis, reimbursement. Replaces denormalized atc_code with FK to ATC master for combination pr',
    `drug_product_id` BIGINT COMMENT 'Foreign key linking to product.drug_product. Business justification: combination_product has drug_constituent_name, drug_constituent_classification, drug_constituent_strength, dosage_form, and route_of_administration that describe the drug component. This FK links the ',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to masterdata.legal_entity. Business justification: Combination products require MAH tracking for regulatory submissions (lead center determination, cross-labeling), post-market surveillance (device/drug adverse events), GMP compliance (drug/device man',
    `masterdata_ndc_code_id` BIGINT COMMENT 'Foreign key linking to masterdata.ndc_code. Business justification: Combination products assigned NDC for US market authorization (FDA product listing), distribution (supply chain), reimbursement (billing codes). Replaces denormalized ndc_code with FK to NDC master fo',
    `patent_family_id` BIGINT COMMENT 'Foreign key linking to intellectual.patent_family. Business justification: Drug-device combinations require integrated IP strategy across multiple patent families (drug, device, method). Essential for regulatory planning, commercial strategy, and lifecycle management.',
    `site_id` BIGINT COMMENT 'Identifier of the primary manufacturing facility responsible for final assembly and release of the combination product.',
    `therapeutic_area_id` BIGINT COMMENT 'Foreign key linking to product.therapeutic_area. Business justification: combination_product has therapeutic_area as a STRING attribute that should reference the therapeutic_area master table for standardized classification.',
    `agreement_number` STRING COMMENT 'Unique agreement number issued by FDA Office of Combination Products documenting the regulatory pathway and lead center assignment.. Valid values are `^CPA-[0-9]{6,10}$`',
    `approval_date` DATE COMMENT 'Date when the FDA approved the combination product for marketing in the United States.',
    `biologic_constituent_classification` STRING COMMENT 'Regulatory status of the biologic constituent under BLA (Biologics License Application) or biosimilar pathway.. Valid values are `BLA|IND|investigational|approved|biosimilar`',
    `biologic_constituent_name` STRING COMMENT 'Name of the biological product component if the combination product includes a biologic (e.g., monoclonal antibody, vaccine antigen, cell therapy).',
    `cmc_documentation_reference` STRING COMMENT 'Reference identifier to the CMC section of regulatory submissions documenting manufacturing processes, specifications, and controls for both drug and device constituents.. Valid values are `^CMC-[A-Z0-9]{6,12}$`',
    `combination_product_code` STRING COMMENT 'Business identifier code assigned to the combination product for internal tracking and regulatory submissions.. Valid values are `^CP-[A-Z0-9]{8,12}$`',
    `combination_type` STRING COMMENT 'Classification of the combination product based on constituent components (e.g., drug-device for auto-injectors, drug-biologic for antibody-drug conjugates).. Valid values are `drug-device|drug-biologic|biologic-device|drug-drug-device|drug-biologic-device`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the combination product record was first created in the master data system.',
    `cross_labeling_requirement_flag` BOOLEAN COMMENT 'Indicates whether the combination product requires coordinated labeling across drug and device constituents to ensure consistent safety and efficacy information.',
    `device_constituent_classification` STRING COMMENT 'FDA device classification and regulatory pathway for the device constituent (510k=premarket notification, PMA=premarket approval, De Novo=novel device classification).. Valid values are `Class I|Class II|Class III|510k|PMA|De Novo`',
    `device_constituent_name` STRING COMMENT 'Name or description of the device component of the combination product (e.g., auto-injector, prefilled syringe, transdermal patch delivery system, drug-eluting stent).',
    `device_design_history_file_reference` STRING COMMENT 'Reference identifier to the Design History File documenting the device constituent design, development, and verification activities per Quality System Regulation (QSR).. Valid values are `^DHF-[A-Z0-9]{6,12}$`',
    `drug_constituent_classification` STRING COMMENT 'Regulatory status of the drug constituent (NDA=New Drug Application, ANDA=Abbreviated New Drug Application, BLA=Biologics License Application, IND=Investigational New Drug).. Valid values are `NDA|ANDA|BLA|IND|investigational|approved`',
    `drug_constituent_name` STRING COMMENT 'Name of the drug substance or drug product component of the combination product, including Active Pharmaceutical Ingredient (API) identification.',
    `drug_constituent_strength` STRING COMMENT 'Quantitative composition of the drug constituent expressed with unit of measure (e.g., 50 mg, 0.3 mL of 1 mg/mL solution).',
    `gmp_compliance_status` STRING COMMENT 'Current GMP compliance status for the combination product manufacturing operations based on FDA inspection outcomes.. Valid values are `compliant|non_compliant|pending_inspection|warning_letter|consent_decree`',
    `human_factors_study_status` STRING COMMENT 'Status of human factors engineering and usability validation studies required for the device constituent to demonstrate safe and effective use by intended users.. Valid values are `not_started|in_progress|completed|validated|submitted`',
    `indication` STRING COMMENT 'FDA-approved indication statement describing the disease or condition the combination product is intended to treat, prevent, or diagnose.',
    `inn_name` STRING COMMENT 'WHO International Nonproprietary Name for the active pharmaceutical ingredient in the drug constituent.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the combination product record was most recently updated.',
    `lead_center` STRING COMMENT 'FDA center assigned primary jurisdiction for premarket review and regulation (CDER=Center for Drug Evaluation and Research, CDRH=Center for Devices and Radiological Health, CBER=Center for Biologics Evaluation and Research).. Valid values are `CDER|CDRH|CBER`',
    `lifecycle_status` STRING COMMENT 'Current stage in the combination product lifecycle from development through post-market surveillance.. Valid values are `development|investigational|approved|marketed|discontinued|withdrawn`',
    `primary_mode_of_action` STRING COMMENT 'The single mode of action that provides the most important therapeutic action of the combination product, used to determine lead center assignment.. Valid values are `drug|device|biologic`',
    `product_name` STRING COMMENT 'Commercial or proprietary name of the combination product as it appears on labeling and regulatory submissions.',
    `qbd_approach_flag` BOOLEAN COMMENT 'Indicates whether the combination product was developed using Quality by Design principles with defined design space and control strategy.',
    `regulatory_submission_number` STRING COMMENT 'FDA-assigned submission number for the combination product application (NDA, BLA, PMA, or 510k number).. Valid values are `^(NDA|BLA|PMA|510K)-[0-9]{6,9}$`',
    `rems_requirement_flag` BOOLEAN COMMENT 'Indicates whether the combination product is subject to a Risk Evaluation and Mitigation Strategy to ensure benefits outweigh risks.',
    `rld_assignment_date` DATE COMMENT 'Date when the FDA assigned the lead center designation for this combination product following RLD submission.',
    `shelf_life_months` STRING COMMENT 'Approved shelf life of the combination product in months from date of manufacture, based on stability studies.',
    `storage_conditions` STRING COMMENT 'Required storage conditions for the combination product to maintain stability and efficacy (e.g., refrigerated 2-8°C, room temperature, protect from light).',
    `usan_name` STRING COMMENT 'United States Adopted Name for the active pharmaceutical ingredient in the drug constituent.',
    CONSTRAINT pk_combination_product PRIMARY KEY(`combination_product_id`)
) COMMENT 'Master record for combination products that combine a drug with a device, biologic, or another drug (e.g., auto-injectors, prefilled syringes, inhalers, transdermal patches, drug-eluting stents). Captures combination type (drug-device, drug-biologic, drug-drug-device), constituent parts with their respective regulatory classifications, primary mode of action (PMOA), lead center designation (CDER/CDRH/CBER), combination product agreement number, device constituent specifications (design history file reference, human factors study status), and cross-labeling requirements. Supports 21 CFR Part 4 compliance, regulatory strategy, and CMC documentation.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`product`.`therapeutic_area` (
    `therapeutic_area_id` BIGINT COMMENT 'Unique identifier for the therapeutic area. Primary key.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to masterdata.cost_center. Business justification: Therapeutic areas map to cost centers for budget management (TA-level budgets), financial planning, cost allocation. Enables TA-level financial reporting, headcount planning, R&D spend analysis, portf',
    `gxp_obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.gxp_obligation. Business justification: Certain GxP obligations are therapeutic-area-specific (pediatric investigation plan requirements for pediatric TAs, REMS programs for oncology, orphan drug annual reporting for rare diseases). Busines',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Therapeutic area head accountability for franchise strategy, portfolio prioritization, investment decisions, and commercial planning. Currently plain text; FK enables organizational reporting, span-of',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to masterdata.profit_center. Business justification: Therapeutic areas are profit centers for P&L reporting (franchise-level financials), commercial performance tracking, segment reporting. Enables TA-level revenue/margin analysis, portfolio profitabili',
    `org_unit_id` BIGINT COMMENT 'Foreign key linking to masterdata.org_unit. Business justification: Therapeutic areas managed by specific organizational units (business units, franchises, therapeutic area heads) for portfolio management, resource allocation, budget planning, strategic decision-makin',
    `parent_therapeutic_area_id` BIGINT COMMENT 'Self-referencing FK on therapeutic_area (parent_therapeutic_area_id)',
    `accelerated_approval_pathway` BOOLEAN COMMENT 'Indicates whether products in this therapeutic area are typically eligible for accelerated approval based on surrogate or intermediate clinical endpoints.',
    `area_code` STRING COMMENT 'Short alphanumeric code uniquely identifying the therapeutic area (e.g., ONCO, IMMUNO, RARE). Used as business identifier across systems.. Valid values are `^[A-Z0-9]{3,10}$`',
    `area_description` STRING COMMENT 'Detailed description of the therapeutic area, including scope, disease categories, and clinical focus.',
    `area_name` STRING COMMENT 'Full name of the therapeutic area (e.g., Oncology, Immunology, Rare Diseases, Neuroscience, Cardiovascular).',
    `atc_level_1_code` STRING COMMENT 'WHO ATC classification level 1 anatomical main group code (single letter: A-V). Maps therapeutic area to international classification standard.. Valid values are `^[A-Z]$`',
    `atc_level_1_name` STRING COMMENT 'WHO ATC classification level 1 anatomical main group name (e.g., Alimentary Tract and Metabolism, Blood and Blood Forming Organs, Cardiovascular System).',
    `breakthrough_therapy_eligible` BOOLEAN COMMENT 'Indicates whether products in this therapeutic area are typically eligible for breakthrough therapy designation due to serious or life-threatening conditions with unmet medical need.',
    `business_unit_owner` STRING COMMENT 'Name of the business unit or division responsible for strategy, portfolio management, and commercial execution for this therapeutic area.',
    `clinical_trial_complexity_level` STRING COMMENT 'Assessment of clinical trial design and execution complexity for this therapeutic area based on endpoint selection, patient recruitment challenges, and trial duration.. Valid values are `very_high|high|moderate|low`',
    `commercial_priority_level` STRING COMMENT 'Strategic priority level for commercial investment and market development in this therapeutic area.. Valid values are `critical|high|medium|low`',
    `controlled_substance_potential` BOOLEAN COMMENT 'Indicates whether products in this therapeutic area have potential for abuse or dependence requiring Drug Enforcement Administration (DEA) scheduling consideration.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this therapeutic area record was first created in the system.',
    `disease_category` STRING COMMENT 'Primary disease category or pathology focus within the therapeutic area (e.g., Solid Tumors, Hematologic Malignancies, Autoimmune Disorders, Genetic Disorders).',
    `effective_date` DATE COMMENT 'Date when this therapeutic area classification became effective in the master data system.',
    `expiry_date` DATE COMMENT 'Date when this therapeutic area classification expires or is superseded. Null for currently active classifications.',
    `fast_track_eligible` BOOLEAN COMMENT 'Indicates whether products in this therapeutic area are typically eligible for fast track designation to facilitate development and expedite review of drugs for serious conditions with unmet medical need.',
    `global_market_size_usd_millions` DECIMAL(18,2) COMMENT 'Estimated global market size for this therapeutic area in millions of USD. Used for strategic planning and investment prioritization.',
    `icd_10_chapter_code` STRING COMMENT 'ICD-10 chapter code representing the primary disease classification for this therapeutic area (e.g., C00-D49 for Neoplasms).. Valid values are `^[A-Z][0-9]{2}$`',
    `icd_10_chapter_name` STRING COMMENT 'ICD-10 chapter name describing the disease classification (e.g., Neoplasms, Diseases of the Circulatory System, Diseases of the Nervous System).',
    `is_active` BOOLEAN COMMENT 'Indicates whether this therapeutic area record is currently active and available for use in product classification, trial planning, and reporting.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this therapeutic area record was last modified in the system.',
    `lifecycle_status` STRING COMMENT 'Current lifecycle status of the therapeutic area within the company portfolio. Active areas have ongoing research or marketed products; emerging areas are new strategic focus; mature areas have established products; declining areas are being de-prioritized; discontinued areas are no longer pursued.. Valid values are `active|emerging|mature|declining|discontinued`',
    `mechanism_of_action_category` STRING COMMENT 'High-level mechanism of action category for products in this therapeutic area (e.g., Targeted Therapy, Immunotherapy, Enzyme Replacement, Receptor Agonist).',
    `meddra_soc_code` STRING COMMENT 'MedDRA System Organ Class code representing the primary organ system or etiology for this therapeutic area. Used for adverse event classification and regulatory reporting.. Valid values are `^[0-9]{8}$`',
    `meddra_soc_name` STRING COMMENT 'MedDRA System Organ Class name (e.g., Neoplasms Benign Malignant and Unspecified, Cardiac Disorders, Nervous System Disorders).',
    `orphan_designation_eligible` BOOLEAN COMMENT 'Indicates whether products in this therapeutic area are typically eligible for orphan drug designation due to rare disease prevalence (affecting fewer than 200,000 patients in the US or fewer than 5 in 10,000 in the EU).',
    `patient_population_estimate` BIGINT COMMENT 'Estimated global patient population affected by diseases within this therapeutic area. Used for epidemiological analysis and market sizing.',
    `pediatric_focus` BOOLEAN COMMENT 'Indicates whether this therapeutic area has a specific focus on pediatric populations, requiring pediatric investigation plans (PIP) or pediatric study plans (PSP).',
    `projected_cagr_percent` DECIMAL(18,2) COMMENT 'Projected compound annual growth rate (CAGR) for this therapeutic area market over the next 5 years, expressed as a percentage.',
    `regulatory_complexity_level` STRING COMMENT 'Assessment of regulatory complexity for products in this therapeutic area based on approval pathway requirements, clinical endpoint challenges, and post-market obligations.. Valid values are `very_high|high|moderate|low`',
    `rems_typically_required` BOOLEAN COMMENT 'Indicates whether products in this therapeutic area typically require Risk Evaluation and Mitigation Strategies (REMS) due to serious safety concerns.',
    `research_priority_level` STRING COMMENT 'Strategic priority level for research and development investment in this therapeutic area.. Valid values are `critical|high|medium|low`',
    `strategic_franchise` BOOLEAN COMMENT 'Indicates whether this therapeutic area is designated as a strategic franchise with dedicated resources, leadership, and long-term investment commitment.',
    `therapeutic_class` STRING COMMENT 'Pharmacological or therapeutic class of drugs within this area (e.g., Kinase Inhibitors, Monoclonal Antibodies, Immunomodulators, Gene Therapies).',
    `unmet_medical_need_level` STRING COMMENT 'Assessment of unmet medical need in this therapeutic area based on availability of effective treatments, disease burden, and patient outcomes.. Valid values are `critical|high|moderate|low`',
    CONSTRAINT pk_therapeutic_area PRIMARY KEY(`therapeutic_area_id`)
) COMMENT 'Reference master for therapeutic areas (oncology, immunology, rare diseases, neuroscience, etc.) used to classify products, trials, and research programs';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`product`.`device_component` (
    `device_component_id` BIGINT COMMENT 'Unique identifier for the device component record in drug-device combination products. Primary key.',
    `combination_product_id` BIGINT COMMENT 'Reference to the parent combination product that this device component is part of.',
    `part11_system_id` BIGINT COMMENT 'Foreign key linking to compliance.part11_system. Business justification: Device components in combination products (auto-injectors, inhalers, infusion pumps) generate electronic records (dose delivery logs, human factors test data) in validated Part 11 systems. Business tr',
    `site_id` BIGINT COMMENT 'Reference to the manufacturing site where the device component is produced.',
    `business_partner_id` BIGINT COMMENT 'Foreign key linking to masterdata.business_partner. Business justification: Device component suppliers require business partner master integration for quality agreements, supplier qualification (AVL management), supplier audits, procurement (PO processing), supplier performan',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to procurement.vendor. Business justification: Device components for combination products are procured from specialized manufacturers. Vendor FK enables supplier qualification tracking, quality agreements, design history file coordination, and reg',
    `parent_device_component_id` BIGINT COMMENT 'Self-referencing FK on device_component (parent_device_component_id)',
    `approval_date` DATE COMMENT 'Date when the device component received regulatory approval or clearance from the health authority.',
    `biocompatibility_status` STRING COMMENT 'Status of biocompatibility testing per ISO 10993 standards to ensure materials are safe for patient contact.. Valid values are `not tested|testing in progress|compliant|non-compliant`',
    `change_control_number` STRING COMMENT 'Most recent change control number tracking design or manufacturing changes to the device component.. Valid values are `^CC-[A-Z0-9]{8,20}$`',
    `component_code` STRING COMMENT 'Unique business identifier code for the device component used across regulatory submissions and manufacturing systems.. Valid values are `^[A-Z0-9]{6,20}$`',
    `component_name` STRING COMMENT 'Official name of the device component as registered with regulatory authorities.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the device component record was first created in the system.',
    `design_history_file_reference` STRING COMMENT 'Reference identifier to the Design History File containing all design and development documentation per FDA QSR requirements.. Valid values are `^DHF-[A-Z0-9]{8,20}$`',
    `device_class` STRING COMMENT 'FDA device classification (Class I, II, or III) based on risk level and regulatory controls required.. Valid values are `Class I|Class II|Class III`',
    `device_master_file_number` STRING COMMENT 'FDA Device Master File number containing confidential detailed information about the device component manufacturing and specifications.. Valid values are `^DMF-[0-9]{6,10}$`',
    `device_type` STRING COMMENT 'Classification of the device component type used in the combination product.. Valid values are `auto-injector|prefilled syringe|inhaler|transdermal patch|implantable device|infusion pump`',
    `discontinuation_date` DATE COMMENT 'Date when the device component was discontinued from manufacturing and commercial use.',
    `dose_accuracy_specification` STRING COMMENT 'Specification for dose delivery accuracy expressed as percentage or absolute value tolerance range.',
    `dose_delivery_mechanism` STRING COMMENT 'Technical description of how the device component delivers the drug substance to the patient including mechanism of action and delivery rate control.',
    `drawing_number` STRING COMMENT 'Engineering drawing number for the device component design and dimensional specifications.. Valid values are `^DWG-[A-Z0-9]{8,20}$`',
    `effective_date` DATE COMMENT 'Date when the current version of the device component specification became effective for manufacturing and regulatory purposes.',
    `gmp_compliance_status` STRING COMMENT 'Current compliance status with Good Manufacturing Practice requirements for device component production.. Valid values are `compliant|non-compliant|under review`',
    `human_factors_study_reference` STRING COMMENT 'Reference identifier to the human factors validation study documentation and results.',
    `human_factors_validation_status` STRING COMMENT 'Status of human factors engineering validation studies to ensure safe and effective use by intended users.. Valid values are `not started|in progress|completed|failed`',
    `is_active` BOOLEAN COMMENT 'Boolean flag indicating whether the device component record is currently active and in use.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the device component record was most recently modified in the system.',
    `lifecycle_status` STRING COMMENT 'Current lifecycle status of the device component in the product development and commercialization process.. Valid values are `development|design verification|design validation|approved|commercial|discontinued`',
    `material_composition` STRING COMMENT 'Detailed description of materials used in the device component construction including polymers, metals, elastomers, and coatings.',
    `needle_gauge` STRING COMMENT 'Gauge size of the needle component if applicable to the device type (e.g., 27G for auto-injectors).. Valid values are `^[0-9]{1,2}G$|not applicable`',
    `needle_length_mm` DECIMAL(18,2) COMMENT 'Length of the needle component in millimeters if applicable to the device type.',
    `nominal_dose_volume_ml` DECIMAL(18,2) COMMENT 'The intended volume of drug product that the device component is designed to deliver in milliliters.',
    `regulatory_approval_number` STRING COMMENT 'Regulatory approval or clearance number from health authorities (e.g., FDA 510(k), PMA number) for the device component.',
    `shelf_life_months` STRING COMMENT 'Approved shelf life of the device component in months based on stability and integrity testing.',
    `specification_document_reference` STRING COMMENT 'Reference identifier to the detailed technical specification document defining all design requirements and acceptance criteria.',
    `sterility_requirement` STRING COMMENT 'Indicates whether the device component must be manufactured and maintained in sterile condition.. Valid values are `sterile|non-sterile`',
    `sterilization_method` STRING COMMENT 'Method used to achieve and maintain sterility of the device component if sterility is required.. Valid values are `ethylene oxide|gamma irradiation|steam autoclave|not applicable`',
    `storage_conditions` STRING COMMENT 'Required storage conditions for the device component including temperature range, humidity, and light protection requirements.',
    `supplier_qualification_status` STRING COMMENT 'Current qualification status of the device component supplier based on quality system audits and performance.. Valid values are `not qualified|qualification in progress|qualified|disqualified`',
    `use_error_risk_level` STRING COMMENT 'Risk level assessment for potential use errors based on human factors analysis and failure mode effects analysis.. Valid values are `low|medium|high`',
    CONSTRAINT pk_device_component PRIMARY KEY(`device_component_id`)
) COMMENT 'Master record for drug-device combination product device components (auto-injectors, inhalers, prefilled syringes) with design history and specifications';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`product`.`excipient` (
    `excipient_id` BIGINT COMMENT 'Unique identifier for the pharmaceutical excipient master record. Primary key for the excipient entity.',
    `business_partner_id` BIGINT COMMENT 'Foreign key linking to masterdata.business_partner. Business justification: Excipient suppliers require business partner master integration for supplier qualification (AVL management), supplier audits (GMP compliance), quality agreements, procurement. Complements existing ven',
    `material_id` BIGINT COMMENT 'Foreign key linking to masterdata.material. Business justification: Excipient material master integration for procurement (PO creation, vendor management), inventory management (stock levels, retest dates), batch traceability (genealogy), MRP planning. Enables ERP int',
    `parent_excipient_id` BIGINT COMMENT 'Self-referencing FK on excipient (parent_excipient_id)',
    `allergen_flag` BOOLEAN COMMENT 'Indicates whether the excipient contains or is derived from known allergens. Critical for patient safety labeling and formulation risk assessment.',
    `allergen_type` STRING COMMENT 'Specific allergen classification if allergen_flag is true. Examples include lactose (milk-derived), gelatin (animal-derived), or gluten.',
    `animal_derived_flag` BOOLEAN COMMENT 'Indicates whether the excipient is derived from animal sources. Important for TSE/BSE risk assessment and religious/dietary considerations.',
    `cas_number` STRING COMMENT 'Unique CAS registry number assigned to the excipient for chemical substance identification. Critical for regulatory submissions and safety data sheets.. Valid values are `^[1-9][0-9]{1,6}-[0-9]{2}-[0-9]$`',
    `change_control_number` STRING COMMENT 'Reference to the change control or deviation record authorizing the creation or modification of this excipient master record. Ensures traceability and GMP compliance.',
    `chemical_name` STRING COMMENT 'IUPAC or systematic chemical name of the excipient. Provides precise chemical identity for regulatory and scientific documentation.',
    `coa_required_flag` BOOLEAN COMMENT 'Indicates whether a Certificate of Analysis must accompany each lot of excipient received from the supplier. Standard requirement for GMP compliance.',
    `compendial_grade` STRING COMMENT 'Pharmacopoeial grade or quality standard to which the excipient conforms. Indicates the regulatory monograph governing quality specifications.. Valid values are `usp|ep|jp|bp|usp_nf|in_house`',
    `compendial_monograph` STRING COMMENT 'Specific pharmacopoeial monograph reference number or title that defines quality standards, test methods, and acceptance criteria for the excipient.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this excipient master record was first created in the system. Audit trail field for data governance.',
    `dmf_number` STRING COMMENT 'FDA Drug Master File number or equivalent regulatory filing reference for the excipient. Provides confidential manufacturing and quality information to regulatory authorities.',
    `dmf_type` STRING COMMENT 'Classification of the DMF submission type. Type II is most common for excipients, covering manufacturing site, process, and controls.. Valid values are `type_i|type_ii|type_iii|type_iv|type_v|not_applicable`',
    `effective_date` DATE COMMENT 'Date from which this excipient master record becomes effective and available for use in formulation and manufacturing activities.',
    `excipient_code` STRING COMMENT 'Unique business identifier or material master code for the excipient used across manufacturing, procurement, and formulation systems. Typically aligned with ERP material master.',
    `excipient_name` STRING COMMENT 'Common or trade name of the excipient as used in formulation documentation and manufacturing records.',
    `expiry_date` DATE COMMENT 'Date after which this excipient master record is no longer valid for use. Null if the record remains active indefinitely.',
    `functional_category` STRING COMMENT 'Primary functional role of the excipient in drug product formulation. Defines the excipients purpose in the dosage form.. Valid values are `binder|disintegrant|lubricant|glidant|diluent|coating_agent`',
    `gmo_status` STRING COMMENT 'Indicates whether the excipient is derived from genetically modified organisms. Required for labeling in certain jurisdictions.. Valid values are `gmo_free|contains_gmo|not_tested|unknown`',
    `gmp_compliance_status` STRING COMMENT 'Current GMP compliance status of the excipient manufacturing site based on regulatory inspections and audit findings.. Valid values are `compliant|non_compliant|under_review|not_assessed`',
    `halal_certified_flag` BOOLEAN COMMENT 'Indicates whether the excipient has been certified as Halal-compliant for use in markets requiring Islamic dietary compliance.',
    `inn_name` STRING COMMENT 'WHO-assigned International Nonproprietary Name for the excipient, if applicable. Used for global regulatory harmonization.',
    `is_active` BOOLEAN COMMENT 'Indicates whether this excipient master record is currently active and available for use in formulation development and manufacturing operations.',
    `kosher_certified_flag` BOOLEAN COMMENT 'Indicates whether the excipient has been certified as Kosher-compliant for use in markets requiring Jewish dietary compliance.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this excipient master record was last updated. Audit trail field for data governance and change tracking.',
    `lifecycle_status` STRING COMMENT 'Current lifecycle stage of the excipient in the organizations master data system. Determines availability for new formulation development and manufacturing use.. Valid values are `active|under_qualification|obsolete|discontinued|restricted_use`',
    `molecular_formula` STRING COMMENT 'Chemical molecular formula representing the elemental composition of the excipient.',
    `molecular_weight` DECIMAL(18,2) COMMENT 'Molecular weight of the excipient in Daltons or grams per mole. Critical for formulation calculations and quality control.',
    `particle_size_specification` STRING COMMENT 'Defined particle size range or distribution specification for the excipient. Critical quality attribute affecting flowability, dissolution, and content uniformity.',
    `physical_form` STRING COMMENT 'Physical state or form of the excipient as received and used in manufacturing. Impacts handling, storage, and processing requirements. [ENUM-REF-CANDIDATE: powder|granule|liquid|gel|paste|solid|semi_solid — 7 candidates stripped; promote to reference product]',
    `regulatory_status` STRING COMMENT 'Current regulatory approval status of the excipient for use in pharmaceutical products. Varies by jurisdiction and intended use.. Valid values are `approved|under_review|restricted|banned|not_submitted`',
    `retest_period_months` STRING COMMENT 'Time period in months after which the excipient must be retested to confirm continued compliance with specifications before use in manufacturing.',
    `solubility_profile` STRING COMMENT 'Description of the excipients solubility characteristics in various solvents (water, ethanol, etc.). Critical for formulation development and process design.',
    `specification_reference` STRING COMMENT 'Document reference or identifier for the approved quality specification defining acceptance criteria, test methods, and release requirements for the excipient.',
    `stability_profile` STRING COMMENT 'Summary of the excipients stability characteristics under various environmental conditions (temperature, humidity, light). Informs storage and handling requirements.',
    `storage_conditions` STRING COMMENT 'Recommended storage conditions for the excipient to maintain quality and stability. Includes temperature range, humidity control, and light protection requirements.',
    CONSTRAINT pk_excipient PRIMARY KEY(`excipient_id`)
) COMMENT 'Master record for pharmaceutical excipients used in drug product formulations, capturing functional category, grade, compendial status, and supplier qualification';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`product`.`bioequivalence_study` (
    `bioequivalence_study_id` BIGINT COMMENT 'Unique identifier for the bioequivalence study record. Primary key.',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to procurement.vendor. Business justification: Bioequivalence studies are conducted by Contract Research Organizations (CROs). Vendor FK enables procurement contract management, invoice reconciliation, audit tracking, and GCP compliance verificati',
    `dossier_document_id` BIGINT COMMENT 'The document management system identifier for the final clinical study report.',
    `internal_order_id` BIGINT COMMENT 'Foreign key linking to finance.internal_order. Business justification: Bioequivalence studies are significant cost centers for generic drug development, tracked via internal orders for budget management and cost capitalization decisions. Enables finance to accumulate BE ',
    `patent_id` BIGINT COMMENT 'Foreign key linking to intellectual.patent. Business justification: BE studies for generics/biosimilars must consider reference product patent landscape for ANDA strategy, Paragraph IV certification, and at-risk launch decisions. Essential for IP risk assessment.',
    `drug_product_id` BIGINT COMMENT 'Foreign key reference to the test drug product being evaluated for bioequivalence. This is typically the generic or new formulation.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Principal investigator accountability for GCP compliance, protocol execution, data integrity, and regulatory submissions. Currently plain text; FK enables GCP training verification, workload tracking,',
    `program_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_program. Business justification: Bioequivalence studies are governed by GCP compliance programs that define monitoring, data integrity, and inspection readiness protocols. Business links each BE study to its governing program (e.g., ',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to masterdata.legal_entity. Business justification: Bioequivalence studies sponsored by specific legal entities for regulatory submissions (ANDA, generic MAA), IP management (patent challenges), financial accounting (R&D capitalization). Required for r',
    `country_id` BIGINT COMMENT 'Foreign key linking to masterdata.country. Business justification: BE studies conducted in specific countries for regulatory acceptance (country-specific BE guidelines), site management (CRO selection), regulatory strategy (bridging studies). Replaces denormalized st',
    `therapeutic_area_id` BIGINT COMMENT 'Foreign key linking to product.therapeutic_area. Business justification: bioequivalence_study has therapeutic_area as a STRING attribute that should reference the therapeutic_area master table. This normalizes the therapeutic area classification and allows retrieval of sta',
    `unit_of_measure_id` BIGINT COMMENT 'Foreign key linking to masterdata.unit_of_measure. Business justification: PK parameters (Cmax, AUC) measured in UOM for bioanalytical reporting (study reports), regulatory submissions (bioequivalence assessment). Enables standardized PK parameter representation, cross-study',
    `reference_bioequivalence_study_id` BIGINT COMMENT 'Self-referencing FK on bioequivalence_study (reference_bioequivalence_study_id)',
    `acceptance_criteria` STRING COMMENT 'The predefined statistical acceptance criteria for bioequivalence, typically 80.00-125.00% for the 90% confidence interval of AUC and Cmax ratios.',
    `api_name` STRING COMMENT 'The name of the active pharmaceutical ingredient being studied, typically the INN or USAN name.',
    `atc_code` STRING COMMENT 'The WHO Anatomical Therapeutic Chemical classification code for the active pharmaceutical ingredient.',
    `auc_90_ci_lower` DECIMAL(18,2) COMMENT 'The lower bound of the 90% confidence interval for the AUC ratio. Must typically be ≥80% for bioequivalence.',
    `auc_90_ci_upper` DECIMAL(18,2) COMMENT 'The upper bound of the 90% confidence interval for the AUC ratio. Must typically be ≤125% for bioequivalence.',
    `bioanalytical_matrix` STRING COMMENT 'The biological matrix in which drug concentrations were measured (e.g., plasma, serum, whole blood).. Valid values are `plasma|serum|whole_blood|urine|saliva`',
    `bioanalytical_method` STRING COMMENT 'The analytical method used to measure drug concentrations in biological samples (e.g., LC-MS/MS, HPLC).',
    `bioequivalence_conclusion` STRING COMMENT 'The final statistical conclusion of whether the test product is bioequivalent to the reference product based on the 90% confidence interval criteria.. Valid values are `bioequivalent|not_bioequivalent|inconclusive`',
    `cmax_90_ci_lower` DECIMAL(18,2) COMMENT 'The lower bound of the 90% confidence interval for the Cmax ratio. Must typically be ≥80% for bioequivalence.',
    `cmax_90_ci_upper` DECIMAL(18,2) COMMENT 'The upper bound of the 90% confidence interval for the Cmax ratio. Must typically be ≤125% for bioequivalence.',
    `comments` STRING COMMENT 'Free-text field for additional notes, observations, or context regarding the bioequivalence study.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this bioequivalence study record was first created in the system.',
    `dosage_form` STRING COMMENT 'The pharmaceutical dosage form of the products being compared (e.g., tablet, capsule, oral solution).',
    `ectd_module_reference` STRING COMMENT 'The eCTD module and section reference where this bioequivalence study is included in the regulatory submission (typically Module 5).',
    `fasting_fed_condition` STRING COMMENT 'Indicates whether the study was conducted under fasting conditions, fed conditions, or both to assess food effect.. Valid values are `fasting|fed|both`',
    `gcp_compliance_flag` BOOLEAN COMMENT 'Indicates whether the bioequivalence study was conducted in compliance with ICH Good Clinical Practice guidelines.',
    `glp_compliance_flag` BOOLEAN COMMENT 'Indicates whether the bioanalytical portion of the study was conducted in compliance with Good Laboratory Practice standards.',
    `irb_approval_date` DATE COMMENT 'The date when the IRB or Ethics Committee approved the bioequivalence study protocol.',
    `irb_approval_number` STRING COMMENT 'The approval number issued by the Institutional Review Board or Ethics Committee that reviewed and approved the study protocol.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this bioequivalence study record was last updated or modified.',
    `pk_parameter_auc_ratio` DECIMAL(18,2) COMMENT 'The geometric mean ratio of area under the plasma concentration-time curve (AUC) for test versus reference product, expressed as a percentage.',
    `pk_parameter_cmax_ratio` DECIMAL(18,2) COMMENT 'The geometric mean ratio of maximum plasma concentration (Cmax) for test versus reference product, expressed as a percentage.',
    `reference_product_formulation_code` STRING COMMENT 'The specific formulation code or batch identifier of the reference product used in the bioequivalence study.',
    `reference_product_strength` STRING COMMENT 'The dosage strength of the reference product administered in the study, including value and unit (e.g., 500 mg).',
    `regulatory_submission_number` STRING COMMENT 'The regulatory application number (ANDA, NDA, MAA) to which this bioequivalence study is submitted or referenced.',
    `report_date` DATE COMMENT 'The date when the final clinical study report was issued.',
    `route_of_administration` STRING COMMENT 'The route by which the drug products are administered to study subjects. [ENUM-REF-CANDIDATE: oral|intravenous|subcutaneous|intramuscular|topical|transdermal|inhalation|ophthalmic|otic|rectal|vaginal — 11 candidates stripped; promote to reference product]',
    `study_completion_date` DATE COMMENT 'The date when the last subject completed the last study visit or assessment.',
    `study_design` STRING COMMENT 'The experimental design methodology used for the bioequivalence study, such as crossover or parallel group design.. Valid values are `crossover|parallel|replicate|partial_replicate|single_dose|multiple_dose`',
    `study_phase` STRING COMMENT 'The clinical development phase during which the bioequivalence study is conducted. Most BE studies are Phase 1.. Valid values are `phase_1|phase_2|phase_3|phase_4|post_approval`',
    `study_population` STRING COMMENT 'The type of population enrolled in the study. Most bioequivalence studies use healthy volunteers.. Valid values are `healthy_volunteers|patients|special_population`',
    `study_protocol_number` STRING COMMENT 'The unique protocol identifier assigned to this bioequivalence study by the sponsor or regulatory authority.',
    `study_site_name` STRING COMMENT 'The name of the clinical site or facility where the bioequivalence study was conducted.',
    `study_start_date` DATE COMMENT 'The date when the first subject was enrolled and dosed in the bioequivalence study.',
    `study_status` STRING COMMENT 'The current lifecycle status of the bioequivalence study indicating its progress through execution. [ENUM-REF-CANDIDATE: planned|initiated|enrolling|completed|terminated|suspended|cancelled — 7 candidates stripped; promote to reference product]',
    `study_title` STRING COMMENT 'The full descriptive title of the bioequivalence study as documented in the protocol.',
    `study_type` STRING COMMENT 'The classification of the study design. Bioequivalence studies compare test and reference products; bioavailability studies measure absorption characteristics.. Valid values are `bioequivalence|bioavailability|food_effect|drug_drug_interaction|comparative_bioavailability|relative_bioavailability`',
    `subject_count_completed` STRING COMMENT 'The number of subjects who completed all study periods and assessments per protocol.',
    `subject_count_enrolled` STRING COMMENT 'The actual number of subjects enrolled and dosed in the bioequivalence study.',
    `subject_count_planned` STRING COMMENT 'The planned number of subjects to be enrolled in the bioequivalence study as specified in the protocol.',
    `submission_type` STRING COMMENT 'The type of regulatory submission for which this bioequivalence study is conducted (e.g., ANDA for generic drugs, NDA for new formulations).. Valid values are `anda|nda|bla|maa|ind|other`',
    `test_product_formulation_code` STRING COMMENT 'The specific formulation code or batch identifier of the test product used in the bioequivalence study.',
    `test_product_strength` STRING COMMENT 'The dosage strength of the test product administered in the study, including value and unit (e.g., 500 mg).',
    CONSTRAINT pk_bioequivalence_study PRIMARY KEY(`bioequivalence_study_id`)
) COMMENT 'Master record for bioequivalence and bioavailability studies required for generic drug approvals and formulation changes, tracking study design and results';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`product`.`pharmaceutical_product` (
    `pharmaceutical_product_id` BIGINT COMMENT 'Unique identifier for the pharmaceutical product record. Primary key for the administrable pharmaceutical product entity per IDMP ISO 11616 standard.',
    `drug_product_id` BIGINT COMMENT 'Reference to the manufactured drug product from which this administrable pharmaceutical product is derived. Links to the manufactured form before administration preparation.',
    `inn_registry_id` BIGINT COMMENT 'Foreign key linking to masterdata.inn_registry. Business justification: Pharmaceutical products use INN for ingredient identification, prescribing systems (e-prescribing), clinical decision support. Replaces denormalized inn_name with FK to INN registry for standardized n',
    `plant_id` BIGINT COMMENT 'Foreign key linking to masterdata.plant. Business justification: Pharmaceutical product (administrable dose form) manufactured at specific plants for batch release, distribution planning, regulatory site registration. Complements manufacturing_site_id with masterda',
    `medicinal_product_id` BIGINT COMMENT 'For biosimilar products, reference to the originator biological product that this pharmaceutical product is biosimilar to. Used for regulatory and interchangeability assessment.',
    `site_id` BIGINT COMMENT 'Reference to the primary manufacturing site responsible for producing this pharmaceutical product. Critical for supply chain traceability and quality investigations.',
    `specified_substance_id` BIGINT COMMENT 'Reference to the primary active pharmaceutical ingredient (API) or drug substance contained in this administrable pharmaceutical product. Links to the molecular entity responsible for therapeutic effect.',
    `unit_of_measure_id` BIGINT COMMENT 'Foreign key linking to masterdata.unit_of_measure. Business justification: Pharmaceutical product concentration UOM for dosing (dose calculations), administration (infusion rates), labeling (concentration declaration). Replaces denormalized concentration_unit with FK to UOM ',
    `parent_pharmaceutical_product_id` BIGINT COMMENT 'Self-referencing FK on pharmaceutical_product (parent_pharmaceutical_product_id)',
    `administrable_dose_form` STRING COMMENT 'The pharmaceutical dose form of the product after any necessary preparation steps and as administered to the patient (e.g., solution for injection, powder for oral suspension, inhalation aerosol). Distinct from manufactured dose form.',
    `administration_device` STRING COMMENT 'The medical device or delivery system used to administer the pharmaceutical product (e.g., pre-filled syringe, auto-injector, nebulizer, infusion pump, metered-dose inhaler). Relevant for combination products.',
    `approval_date` DATE COMMENT 'The date on which the pharmaceutical product received regulatory approval from the health authority. Marks the beginning of the products commercial lifecycle.',
    `atc_code` STRING COMMENT 'The WHO Anatomical Therapeutic Chemical classification code indicating the therapeutic and pharmacological properties of the pharmaceutical product. Used for drug utilization studies and formulary management.. Valid values are `^[A-Z][0-9]{2}[A-Z]{2}[0-9]{2}$`',
    `black_box_warning_flag` BOOLEAN COMMENT 'Indicates whether the pharmaceutical product labeling includes a boxed warning (black box warning) for serious or life-threatening risks. The most serious FDA warning for prescription drugs.',
    `cold_chain_required_flag` BOOLEAN COMMENT 'Indicates whether the pharmaceutical product requires cold chain (refrigerated or frozen) storage and distribution. Critical for logistics planning and temperature monitoring.',
    `concentration_value` DECIMAL(18,2) COMMENT 'The numeric concentration of the active pharmaceutical ingredient (API) in the administrable product. Used in conjunction with concentration unit for precise dosing.',
    `controlled_substance_schedule` STRING COMMENT 'The DEA controlled substance schedule classification if the pharmaceutical product contains a controlled substance. Determines regulatory requirements for prescribing, dispensing, and record-keeping.. Valid values are `Schedule I|Schedule II|Schedule III|Schedule IV|Schedule V|Not Controlled`',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this pharmaceutical product record was first created in the system. Used for audit trail and data lineage tracking.',
    `dosing_instructions` STRING COMMENT 'Standard dosing instructions for the administrable pharmaceutical product, including recommended dose, frequency, and duration. Derived from approved prescribing information.',
    `gmp_compliance_status` STRING COMMENT 'The current GMP compliance status of the pharmaceutical product and its manufacturing operations. Indicates whether the product meets current Good Manufacturing Practice requirements.. Valid values are `compliant|non_compliant|under_inspection|pending_certification`',
    `indication_summary` STRING COMMENT 'A concise summary of the approved therapeutic indications for which this pharmaceutical product may be administered. Derived from approved product labeling.',
    `interchangeability_status` STRING COMMENT 'For biological products, indicates whether the product has been designated as interchangeable with the reference product, allowing automatic substitution at the pharmacy level without prescriber intervention.. Valid values are `interchangeable|biosimilar|reference|not_applicable`',
    `is_active` BOOLEAN COMMENT 'Indicates whether this pharmaceutical product record is currently active in the system. Used for soft deletion and historical record management.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this pharmaceutical product record was last modified. Used for change tracking and audit compliance.',
    `lifecycle_status` STRING COMMENT 'The current lifecycle status of the pharmaceutical product in the regulatory and commercial context. Indicates whether the product is actively marketed or has been withdrawn.. Valid values are `approved|marketed|withdrawn|suspended|under_review`',
    `marketing_authorization_holder` STRING COMMENT 'The legal entity that holds the marketing authorization for the pharmaceutical product and is responsible for its quality, safety, and efficacy. Also known as the license holder or applicant.',
    `pharmacopoeial_standard` STRING COMMENT 'The pharmacopoeial monograph or standard that the pharmaceutical product complies with (e.g., USP, EP, JP, BP). Defines quality specifications and test methods.',
    `phpid_code` STRING COMMENT 'ISO 11616 compliant PhPID code uniquely identifying the administrable pharmaceutical product at the international level. Used for regulatory submissions and global product identification.. Valid values are `^PHPID-[A-Z0-9]{8,12}$`',
    `preparation_instructions` STRING COMMENT 'Instructions for preparing the pharmaceutical product for administration, including reconstitution, dilution, or mixing requirements. Critical for products requiring preparation before administration.',
    `preservative_free_flag` BOOLEAN COMMENT 'Indicates whether the administrable pharmaceutical product is formulated without preservatives. Critical for products intended for intrathecal, intraocular, or neonatal use.',
    `product_name` STRING COMMENT 'The full name of the administrable pharmaceutical product as it would be described in clinical and regulatory contexts. Includes strength and administrable dose form.',
    `regulatory_approval_number` STRING COMMENT 'The regulatory approval number assigned by the health authority for this pharmaceutical product (e.g., NDA number, BLA number, MAA number). Links to the regulatory submission and approval documentation.',
    `rems_required_flag` BOOLEAN COMMENT 'Indicates whether a Risk Evaluation and Mitigation Strategy is required by FDA for this pharmaceutical product due to serious safety concerns. Impacts distribution and prescribing requirements.',
    `route_of_administration` STRING COMMENT 'The path by which the pharmaceutical product is administered to the patient (e.g., intravenous, oral, subcutaneous, intramuscular, topical, inhalation). Critical for clinical usage and safety.',
    `shelf_life_after_preparation_hours` STRING COMMENT 'The maximum time in hours that the pharmaceutical product remains stable and safe for administration after preparation (reconstitution, dilution, or opening). Critical for hospital pharmacy and clinical administration.',
    `sterility_requirement` STRING COMMENT 'Indicates the sterility requirement for the administrable pharmaceutical product. Sterile products are required for parenteral, ophthalmic, and certain other routes of administration.. Valid values are `sterile|non-sterile|aseptic`',
    `storage_conditions` STRING COMMENT 'The required storage conditions for the administrable pharmaceutical product to maintain stability and efficacy (e.g., store at 2-8°C, protect from light, store at controlled room temperature). Critical for supply chain and pharmacy operations.',
    `target_patient_population` STRING COMMENT 'Description of the intended patient population for this administrable pharmaceutical product, including age groups, disease stage, and any specific patient characteristics (e.g., adult patients with metastatic disease, pediatric patients 2 years and older).',
    `therapeutic_area` STRING COMMENT 'The primary therapeutic area or disease category that this pharmaceutical product is indicated for (e.g., Oncology, Immunology, Cardiovascular, Neurology, Rare Diseases).',
    `total_volume_ml` DECIMAL(18,2) COMMENT 'The total volume of the administrable pharmaceutical product in milliliters, applicable to liquid dose forms. Used for dose calculation and administration instructions.',
    `unit_of_presentation` STRING COMMENT 'The discrete unit in which the pharmaceutical product is presented for administration (e.g., vial, syringe, tablet, capsule, ampoule, inhaler). Represents the smallest administrable unit.',
    CONSTRAINT pk_pharmaceutical_product PRIMARY KEY(`pharmaceutical_product_id`)
) COMMENT 'IDMP ISO 11616 entity representing the administrable pharmaceutical product form — the product as administered to the patient, distinct from the manufactured drug product. Captures administrable dose form, route of administration, unit of presentation, and reference to constituent active ingredients. Bridges drug_product (manufactured form) to clinical usage.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`product`.`specified_substance` (
    `specified_substance_id` BIGINT COMMENT 'Unique identifier for the specified substance record. Primary key for this entity representing an IDMP ISO 11238 substance with specified detail level.',
    `formulation_ingredient_id` BIGINT COMMENT 'Reference to the formulation ingredient that this specified substance represents. Links to the ingredient within a specific formulation context.',
    `drug_substance_id` BIGINT COMMENT 'Reference to the global substance master record. Links this specified substance to the authoritative substance definition in the substance registry.',
    `unit_of_measure_id` BIGINT COMMENT 'Foreign key linking to masterdata.unit_of_measure. Business justification: Specified substance strength UOM for substance specifications (IDMP), regulatory data exchange (substance strength representation). Replaces denormalized strength_unit with FK to UOM master for standa',
    `parent_specified_substance_id` BIGINT COMMENT 'Self-referencing FK on specified_substance (parent_specified_substance_id)',
    `change_control_number` STRING COMMENT 'The change control or deviation number associated with the creation or modification of this specified substance record. Links to the formal change management process.',
    `concentration_unit` STRING COMMENT 'The unit of measure for concentration. Common units include mg/mL, g/L, % w/v, % w/w, molarity (M), or other pharmacopoeial concentration units.',
    `concentration_value` DECIMAL(18,2) COMMENT 'The concentration of the substance in solution or suspension formulations. Represents the amount of substance per unit volume or weight of formulation.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this specified substance record was first created in the system. Audit trail field for record creation tracking.',
    `effective_date` DATE COMMENT 'The date from which this specified substance definition becomes effective and valid for use in formulations and regulatory submissions.',
    `expiry_date` DATE COMMENT 'The date after which this specified substance definition is no longer valid or has been superseded by a newer version. Null if currently active.',
    `grade` STRING COMMENT 'The quality grade or compendial standard of the substance. Examples include USP, EP, JP, BP, or in-house specification grade. Indicates the purity and quality standard applied.',
    `idmp_substance_code` STRING COMMENT 'The globally unique IDMP substance identifier assigned per ISO 11238 standards. Used for international regulatory submissions and substance harmonization across health authorities.',
    `is_active` BOOLEAN COMMENT 'Boolean flag indicating whether this specified substance record is currently active and available for use in formulations. True indicates active, False indicates inactive or archived.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this specified substance record was last modified. Audit trail field for change tracking and data lineage.',
    `lifecycle_status` STRING COMMENT 'The current lifecycle status of the specified substance record. Indicates whether the record is actively used, inactive, obsolete, or under review for changes.. Valid values are `active|inactive|obsolete|under_review`',
    `manufacturer_substance_code` STRING COMMENT 'The manufacturer-specific internal code or catalog number for this specified substance. Used for procurement, quality control, and supply chain traceability.',
    `molecular_formula` STRING COMMENT 'The chemical molecular formula of the specified substance. Represents the elemental composition including any salt, solvate, or hydrate components.',
    `molecular_weight` DECIMAL(18,2) COMMENT 'The molecular weight of the specified substance in Daltons or g/mol. Includes the weight of any salt, solvate, or hydrate components.',
    `optical_activity` STRING COMMENT 'The stereochemical configuration or optical activity of the substance. Indicates whether the substance is a specific enantiomer, racemate, or other stereoisomeric form (e.g., R, S, (+), (-), racemic).',
    `polymorphic_form` STRING COMMENT 'The specific polymorphic or crystalline form of the substance. Polymorphism can significantly impact solubility, stability, and bioavailability. Examples include Form I, Form II, amorphous.',
    `purity_percentage` DECIMAL(18,2) COMMENT 'The minimum purity percentage of the specified substance as defined in the specification. Expressed as a percentage (e.g., 98.5 for 98.5% purity).',
    `reference_strength_unit` STRING COMMENT 'The unit of measure for the reference strength value. Typically represents the base or active moiety unit when different from the administered substance unit.',
    `reference_strength_value` DECIMAL(18,2) COMMENT 'The numeric quantity expressed as reference strength. Used when the active moiety differs from the administered form (e.g., salt vs base). Enables standardized strength comparison across different salt forms.',
    `regulatory_status` STRING COMMENT 'The current regulatory status of the specified substance in the context of its use in medicinal products. Indicates whether the substance is approved for commercial use, under investigation, or withdrawn.. Valid values are `approved|investigational|withdrawn|pending`',
    `salt_form` STRING COMMENT 'The specific salt form of the substance if applicable. Examples include hydrochloride, sodium, sulfate, mesylate. Critical for bioavailability and stability considerations.',
    `solvate_type` STRING COMMENT 'The type of solvate if the substance exists as a solvate. Common examples include hydrate, ethanolate, or other solvent inclusion compounds.',
    `specification_level` STRING COMMENT 'The level of detail at which the substance is specified. Indicates whether the substance is defined at molecular, salt, solvate, hydrate, polymorphic form, or mixture level per IDMP hierarchy.. Valid values are `molecular|salt|solvate|hydrate|polymorph|mixture`',
    `specification_reference` STRING COMMENT 'Reference to the quality specification document that defines the acceptance criteria for this specified substance. Links to internal specification documents or compendial monographs.',
    `stoichiometry` STRING COMMENT 'The stoichiometric ratio of components in the specified substance. Relevant for salts, solvates, hydrates, and co-crystals (e.g., 1:1, 2:1, monohydrate, hemihydrate).',
    `strength_value` DECIMAL(18,2) COMMENT 'The numeric quantity of the substance expressed as strength. Represents the amount of active moiety or substance per unit dose or per unit of measure.',
    `substance_code` STRING COMMENT 'The standardized code identifying the substance. May be an UNII code, CAS number, or other globally recognized substance identifier used for regulatory submissions.',
    `substance_name` STRING COMMENT 'The official name of the substance at the specified level. May be INN, USAN, chemical name, or other standardized nomenclature depending on regulatory context.',
    `substance_role` STRING COMMENT 'The functional role of the substance within the formulation. Indicates whether the substance is an active pharmaceutical ingredient (API), excipient, or other functional component per IDMP requirements.. Valid values are `active|excipient|adjuvant|preservative|solvent|stabilizer`',
    `version_number` STRING COMMENT 'The version number of this specified substance definition. Incremented when specification details change, enabling change control and traceability.',
    CONSTRAINT pk_specified_substance PRIMARY KEY(`specified_substance_id`)
) COMMENT 'IDMP ISO 11238 entity representing a substance with a specified level of detail including strength, reference strength, and substance role (active, excipient). Links formulation_ingredient to the global substance reference and enables precise regulatory substance identification per IDMP requirements.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`product`.`prescription` (
    `prescription_id` BIGINT COMMENT 'Unique identifier for this prescription record. Primary key for the prescription association.',
    `master_id` BIGINT COMMENT 'Reference to the healthcare provider who wrote this prescription. Used for prescriber network analysis and pharmacovigilance follow-up.',
    `medicinal_product_id` BIGINT COMMENT 'Foreign key linking to the medicinal product that was prescribed',
    `patient_id` BIGINT COMMENT 'Foreign key linking to the patient who received the prescription',
    `adherence_score` DECIMAL(18,2) COMMENT 'Calculated adherence metric for this prescription (e.g., proportion of days covered, medication possession ratio). Used for patient support program interventions and real-world evidence studies.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this prescription record was created in the system. Used for audit trail and data lineage tracking.',
    `discontinuation_reason` STRING COMMENT 'Reason why this prescription was discontinued or stopped. Critical for pharmacovigilance signal detection and real-world effectiveness analysis.',
    `dosage_instructions` STRING COMMENT 'Free-text or structured dosage instructions specific to this prescription (e.g., 10mg twice daily with food). Varies by patient based on indication, weight, comorbidities.',
    `prescription_date` DATE COMMENT 'The date when the prescription was written by the prescribing physician. Critical for therapy timeline tracking and regulatory reporting.',
    `prescription_status` STRING COMMENT 'Current lifecycle status of this prescription. Used for patient support program workflow management and adherence intervention triggering.',
    `prior_authorization_required` BOOLEAN COMMENT 'Indicates whether payer prior authorization was required for this prescription. Used for market access analytics and patient support program design.',
    `refill_count` STRING COMMENT 'Number of refills dispensed for this prescription. Used for adherence monitoring and patient support program engagement tracking.',
    `specialty_pharmacy_flag` BOOLEAN COMMENT 'Indicates whether this prescription was dispensed through a specialty pharmacy channel. Relevant for high-cost biologics, oncology products, and products requiring special handling.',
    `therapy_end_date` DATE COMMENT 'The date when the patient stopped taking the medicinal product. Used to calculate treatment duration and time-to-discontinuation for real-world evidence studies.',
    `therapy_start_date` DATE COMMENT 'The date when the patient actually started taking the medicinal product. May differ from prescription_date due to prior authorization delays or patient decision timing.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this prescription record was last updated. Used for change data capture and incremental data pipeline processing.',
    CONSTRAINT pk_prescription PRIMARY KEY(`prescription_id`)
) COMMENT 'This association product represents the prescription event between a medicinal product and a patient. It captures the commercial/post-market relationship where a specific medicinal product is prescribed to a specific patient, including prescriber information, dosage instructions, therapy timeline, adherence tracking, and discontinuation details. Each record represents one prescription instance linking one medicinal product to one patient with attributes that exist only in the context of this prescribing relationship. Distinct from clinical trial exposure (protocol-driven) and represents real-world evidence for patient support programs, adherence monitoring, and pharmacovigilance.. Existence Justification: In pharmaceutical commercial operations, patients routinely receive multiple medicinal products simultaneously (polypharmacy for chronic conditions, combination therapies) or sequentially (treatment switches, dose escalations), and each medicinal product is prescribed to thousands of patients across diverse indications and patient populations. Patient support programs, specialty pharmacies, and real-world evidence teams actively manage prescription-level records as operational entities, tracking adherence metrics, refill patterns, discontinuation reasons, and therapy outcomes for each patient-product combination. This is distinct from clinical trial exposure (which is protocol-mandated) and represents the post-market commercial relationship where prescription records are created, monitored, and analyzed as core business data.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`product`.`formulary_listing` (
    `formulary_listing_id` BIGINT COMMENT 'Unique identifier for this formulary listing record. Primary key for the association.',
    `drug_product_id` BIGINT COMMENT 'Foreign key linking to the drug product that is listed on the payers formulary',
    `payer_account_id` BIGINT COMMENT 'Foreign key linking to the payer account whose formulary includes this drug product',
    `effective_date` DATE COMMENT 'The date on which this formulary listing became or will become effective. Explicitly identified in detection reasoning.',
    `end_date` DATE COMMENT 'The date on which this formulary listing expires or was removed, if applicable. Supports tracking of historical formulary positions.',
    `formulary_status` STRING COMMENT 'Current status of the drug product on the payers formulary. Explicitly identified in detection reasoning.',
    `formulary_tier` STRING COMMENT 'The tier placement assigned by the payer for this drug product on their formulary, determining patient cost-sharing and access restrictions. Explicitly identified in detection reasoning.',
    `last_review_date` DATE COMMENT 'The date of the most recent Pharmacy and Therapeutics (P&T) committee review of this drug products formulary status.',
    `listing_source` STRING COMMENT 'The source or mechanism through which this drug product was added to the payers formulary.',
    `medical_policy_reference` STRING COMMENT 'Reference to the payers medical policy or coverage criteria document that governs this drug products coverage.',
    `next_review_date` DATE COMMENT 'The scheduled date for the next P&T committee review of this drug products formulary status.',
    `prior_authorization_required` BOOLEAN COMMENT 'Indicates whether the payer requires prior authorization for coverage of this drug product. Explicitly identified in detection reasoning.',
    `quantity_limit` STRING COMMENT 'Any quantity limits or dispensing restrictions imposed by the payer for this drug product (e.g., 30 tablets per 30 days).',
    `rebate_percentage` DECIMAL(18,2) COMMENT 'The negotiated rebate percentage that the manufacturer provides to the payer for this drug product. Explicitly identified in detection reasoning.',
    `step_therapy_required` BOOLEAN COMMENT 'Indicates whether the payer mandates step therapy (fail-first) protocols before covering this drug product.',
    CONSTRAINT pk_formulary_listing PRIMARY KEY(`formulary_listing_id`)
) COMMENT 'This association product represents the formulary listing relationship between drug_product and payer_account. It captures the specific terms under which a payer covers a drug product on their formulary, including tier placement, authorization requirements, rebate agreements, and coverage dates. Each record links one drug_product to one payer_account with attributes that exist only in the context of this payer-product coverage relationship.. Existence Justification: In pharmaceutical market access operations, each drug product is listed on multiple payer formularies (commercial plans, Medicare Part D, Medicaid, regional health plans), and each payer account maintains formularies covering hundreds to thousands of drug products. Market access teams actively manage these formulary listings as operational business entities, negotiating tier placement, rebate terms, and access restrictions for each drug-payer combination. The formulary listing is a recognized business concept with its own lifecycle, managed through P&T committee reviews, contract negotiations, and ongoing monitoring.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`product`.`approved_vendor` (
    `approved_vendor_id` BIGINT COMMENT 'Primary key for the approved_vendor association',
    `excipient_id` BIGINT COMMENT 'Foreign key linking to the excipient master record being sourced',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to the qualified vendor authorized to supply this excipient',
    `active_flag` BOOLEAN COMMENT 'Indicates whether this vendor approval is currently active and available for procurement. Inactive approvals represent historical qualifications that are no longer valid.',
    `approval_date` DATE COMMENT 'Date when this vendor was approved to supply this specific excipient following successful qualification activities including site audit, sample testing, and quality agreement execution.',
    `gmp_compliance_status` STRING COMMENT 'GMP compliance status specific to this vendors manufacturing site for this excipient. A vendor may have different compliance statuses for different materials manufactured at different sites.',
    `inactivation_date` DATE COMMENT 'Date when this vendor approval was inactivated, if applicable. Inactivation may occur due to vendor disqualification, quality issues, business decisions, or vendor exit.',
    `inactivation_reason` STRING COMMENT 'Business reason for inactivating this vendor approval (e.g., Quality Issues, Vendor Exit, Cost, Strategic Sourcing Decision, Regulatory Non-Compliance).',
    `last_audit_date` DATE COMMENT 'Date of the most recent on-site or remote audit conducted specifically for this vendors capability to supply this excipient. Audit scope is material-specific and site-specific.',
    `lead_time_days` STRING COMMENT 'Standard procurement lead time in days from purchase order issuance to material receipt for this excipient from this vendor. Lead time varies by vendor and material.',
    `minimum_order_quantity` DECIMAL(18,2) COMMENT 'Minimum order quantity required by this vendor for this excipient, typically expressed in kilograms or the standard unit of measure for the material.',
    `next_audit_due_date` DATE COMMENT 'Scheduled date for the next audit of this vendor for this excipient. Audit frequency is risk-based and may vary by material criticality and vendor performance history.',
    `preferred_vendor_flag` BOOLEAN COMMENT 'Indicates whether this vendor is the preferred source for this excipient based on quality, cost, reliability, and strategic relationship. Multiple vendors may be qualified but only one is typically preferred.',
    `price_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the unit price (e.g., USD, EUR, GBP).',
    `qualification_status` STRING COMMENT 'Current qualification status of this specific vendor for this specific excipient. Status is excipient-vendor specific and may differ from the vendors overall qualification status.',
    `quality_agreement_reference` STRING COMMENT 'Document control number or reference identifier for the Quality Agreement governing the supply of this excipient from this vendor. Each excipient-vendor combination typically has a specific quality agreement.',
    `risk_classification` STRING COMMENT 'Risk classification for this specific excipient-vendor combination based on material criticality, vendor performance, supply continuity, regulatory compliance, and alternative source availability.',
    `standard_unit_price` DECIMAL(18,2) COMMENT 'Current standard unit price for this excipient from this vendor in the agreed currency. Price is vendor-specific and material-specific.',
    `supplier_qualification_status` STRING COMMENT 'Current qualification status of the excipient supplier based on quality audits, performance history, and GMP compliance. Determines procurement eligibility. [Moved from excipient: Qualification status is vendor-specific and excipient-specific, not a property of the excipient itself. The same excipient may have different qualification statuses with different vendors. This attribute belongs in the approved_vendor association as qualification_status.]. Valid values are `qualified|conditionally_qualified|under_qualification|disqualified|suspended`',
    `unit_of_measure` STRING COMMENT 'Standard unit of measure for ordering and pricing this excipient from this vendor (e.g., KG, MT, LB).',
    CONSTRAINT pk_approved_vendor PRIMARY KEY(`approved_vendor_id`)
) COMMENT 'This association product represents the qualification and approval relationship between an excipient and a vendor authorized to supply it. It captures vendor-specific qualification status, audit history, compliance verification, and supply agreement terms that exist only in the context of this specific excipient-vendor pairing. Each record represents one approved source for one excipient.. Existence Justification: In pharmaceutical manufacturing, excipients are routinely multi-sourced from multiple qualified vendors to ensure supply continuity, manage risk, and meet regulatory requirements for alternative sources. Each excipient-vendor pairing requires independent qualification activities including site audits, sample testing, quality agreement execution, and ongoing compliance monitoring. The approved vendor list is an operational business entity actively managed by procurement and quality teams, with vendor-specific and material-specific attributes including qualification status, audit dates, pricing terms, lead times, and risk classifications.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`product`.`product_payer_contract` (
    `product_payer_contract_id` BIGINT COMMENT 'Primary key for product_payer_contract',
    `employee_id` BIGINT COMMENT 'Identifier of the internal market access manager or account director responsible for managing this payer contract relationship.',
    `medicinal_product_id` BIGINT COMMENT 'Foreign key linking to the medicinal product covered under this payer contract',
    `payer_account_id` BIGINT COMMENT 'Foreign key linking to the payer organization that is party to this contract',
    `contract_id` BIGINT COMMENT 'Unique surrogate identifier for this payer contract record. Primary key.',
    `base_rebate_pct` DECIMAL(18,2) COMMENT 'The baseline rebate percentage negotiated with this payer for this medicinal product, expressed as a percentage of WAC (Wholesale Acquisition Cost). Identified in detection phase as relationship data. Subject to confidentiality restrictions.',
    `contract_number` STRING COMMENT 'External contract reference number or identifier used in legal documents and commercial systems. Identified in detection phase as relationship data.',
    `contract_status` STRING COMMENT 'Current lifecycle status of this payer contract. Identified in detection phase as relationship data. Drives eligibility for claims adjudication and rebate processing.',
    `contract_type` STRING COMMENT 'Classification of the commercial arrangement governing this payer relationship. Identified in detection phase as relationship data. Determines rebate structure, performance metrics, and reporting requirements.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this payer contract record was first created in the market access system.',
    `effective_end_date` DATE COMMENT 'The date on which this payer contract expires or is terminated. Null indicates an open-ended or evergreen contract.',
    `effective_start_date` DATE COMMENT 'The date on which this payer contract becomes effective and pricing/formulary terms take effect. Identified in detection phase as relationship data.',
    `formulary_tier` STRING COMMENT 'The formulary tier placement negotiated for this medicinal product on this payers formulary. Identified in detection phase as relationship data. Drives patient out-of-pocket cost and utilization.',
    `last_review_date` DATE COMMENT 'The date on which this payer contract was last reviewed or renegotiated by the market access team.',
    `next_review_date` DATE COMMENT 'The scheduled date for the next contract review or renegotiation cycle with this payer for this medicinal product.',
    `outcomes_metric` STRING COMMENT 'The clinical or economic outcome metric used to measure performance for outcomes-based or value-based contracts (e.g., HbA1c reduction, hospitalization rate, adherence rate). Null for non-outcomes-based contracts.',
    `performance_rebate_pct` DECIMAL(18,2) COMMENT 'Additional rebate percentage contingent on achievement of formulary placement, utilization targets, or outcomes metrics. Null if contract does not include performance-based terms.',
    `prior_authorization_required` BOOLEAN COMMENT 'Indicates whether this payer requires prior authorization for coverage of this medicinal product under this contract. Impacts patient access and time-to-therapy.',
    `quantity_limit` STRING COMMENT 'Maximum quantity of this medicinal product that the payer will cover per prescription fill or per time period under this contract. Null if no quantity limit applies.',
    `step_therapy_required` BOOLEAN COMMENT 'Indicates whether this payer mandates step therapy (fail-first) protocols before covering this medicinal product under this contract.',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this payer contract record was last modified.',
    `utilization_target` BIGINT COMMENT 'Target number of prescriptions, patients, or units for this medicinal product under this contract, used for performance-based rebate calculations. Null if not applicable.',
    CONSTRAINT pk_product_payer_contract PRIMARY KEY(`product_payer_contract_id`)
) COMMENT 'This association product represents the commercial contract between a medicinal product and a payer account. It captures the negotiated terms, rebate agreements, formulary placement, and performance metrics that govern market access and reimbursement. Each record links one medicinal product to one payer account with contract-specific attributes including pricing terms, formulary tier, effective dates, and contract status. This is the operational SSOT for pharmaceutical market access contracting.. Existence Justification: In pharmaceutical commercial operations, each medicinal product is contracted with multiple payers (commercial insurers, Medicare Part D plans, Medicaid programs, PBMs, GPOs) simultaneously, and each payer maintains active contracts for hundreds to thousands of products in their formulary. The payer contract is a recognized operational entity managed by market access teams, with contract-specific attributes including rebate terms, formulary tier placement, utilization targets, and outcomes metrics that belong to neither the product nor the payer alone.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`product`.`kol_product_engagement` (
    `kol_product_engagement_id` BIGINT COMMENT 'Unique surrogate identifier for this KOL-product engagement record. Primary key for the association.',
    `medical_kol_profile_id` BIGINT COMMENT 'Foreign key linking to the Key Opinion Leader profile engaged with this product',
    `medicinal_product_id` BIGINT COMMENT 'Foreign key linking to the medicinal product that is the subject of this KOL engagement',
    `advisory_role` STRING COMMENT 'The specific advisory role held by the KOL for this product engagement (e.g., Advisory Board Chair, Steering Committee Member, DSMB Member). Sourced from detection phase.',
    `clinical_trial_role` STRING COMMENT 'The specific role held by the KOL in clinical trials for this medicinal product, if applicable.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this KOL-product engagement record was first created in the medical affairs system.',
    `engagement_end_date` DATE COMMENT 'The date on which this KOL-product engagement relationship was concluded or terminated. Null if engagement is ongoing.',
    `engagement_start_date` DATE COMMENT 'The date on which this KOL-product engagement relationship was initiated. Critical for tracking engagement history and transparency reporting timelines. Sourced from detection phase.',
    `engagement_status` STRING COMMENT 'Current lifecycle status of this KOL-product engagement relationship from a medical affairs management perspective.',
    `last_engagement_date` DATE COMMENT 'The most recent date on which an engagement activity occurred between this KOL and this product.',
    `primary_indication_focus` STRING COMMENT 'The specific disease indication or therapeutic sub-area within the medicinal products therapeutic area that is the focus of this KOL engagement (e.g., metastatic breast cancer, relapsing-remitting MS). Sourced from detection phase.',
    `relationship_type` STRING COMMENT 'The specific type of engagement relationship between the KOL and the medicinal product (e.g., Advisory Board Member, Speaker Bureau, Clinical Trial PI, IIT Sponsor). Sourced from detection phase relationship_type attribute.',
    `speaker_bureau_status` STRING COMMENT 'Current status of the KOLs participation in the speaker bureau for this specific medicinal product. Sourced from detection phase.',
    `total_engagement_count` STRING COMMENT 'Cumulative count of discrete engagement activities (advisory board meetings, speaking engagements, publication planning sessions) between this KOL and this product. Sourced from detection phase.',
    `total_tov_amount` DECIMAL(18,2) COMMENT 'Cumulative total of all transfers of value (honoraria, consulting fees, travel reimbursements) associated with this specific KOL-product engagement, for Sunshine Act and EFPIA transparency reporting.',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this KOL-product engagement record was most recently updated.',
    CONSTRAINT pk_kol_product_engagement PRIMARY KEY(`kol_product_engagement_id`)
) COMMENT 'This association product represents the operational engagement relationship between a Key Opinion Leader and a medicinal product. It captures the specific role, engagement history, indication focus, and compliance-relevant data for each KOL-product pairing. Each record links one medical_kol_profile to one medicinal_product with attributes that exist only in the context of this therapeutic area engagement, advisory relationship, or clinical trial leadership role.. Existence Justification: In pharmaceutical medical affairs operations, Key Opinion Leaders engage with multiple medicinal products across their therapeutic expertise areas (e.g., an oncology KOL may serve on advisory boards for multiple cancer drugs), and each medicinal product has relationships with multiple KOLs for advisory boards, speaker bureaus, clinical trial leadership, and publication planning. The business actively manages these engagements as distinct operational entities with specific roles, engagement histories, indication focuses, and compliance-tracked transfer-of-value data.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`product`.`contract_pricing` (
    `contract_pricing_id` BIGINT COMMENT 'Unique identifier for this contract pricing agreement record. Primary key.',
    `contract_account_id` BIGINT COMMENT 'Foreign key linking to the institutional contract account that negotiated this pricing agreement',
    `medicinal_product_id` BIGINT COMMENT 'Foreign key linking to the medicinal product covered under this contract pricing agreement',
    `annual_volume_commitment` STRING COMMENT 'The total annual volume (in units) that the contract account has committed to purchase for this medicinal product. Used for rebate tier calculation and contract performance tracking.',
    `contract_price` DECIMAL(18,2) COMMENT 'The negotiated unit price for this medicinal product under this contract account. This price is specific to the product-account combination and represents the contracted rate that overrides standard list pricing.',
    `contract_reference_number` STRING COMMENT 'External contract reference number or agreement identifier used by the contract account or GPO. Used for contract reconciliation and customer communications.',
    `contract_status` STRING COMMENT 'The current lifecycle status of this contract pricing agreement. Only Active contracts are used for pricing calculations in order processing and rebate accrual.',
    `contract_type` STRING COMMENT 'The type of commercial contract under which this pricing agreement was established. Different contract types have different negotiation processes, approval workflows, and rebate structures.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this contract pricing agreement record was first created in the system.',
    `effective_date` DATE COMMENT 'The date on which this contract pricing agreement becomes effective. Pricing and rebate terms apply to purchases on or after this date.',
    `expiry_date` DATE COMMENT 'The date on which this contract pricing agreement expires. After this date, standard pricing applies unless the contract is renewed. Supports contract renewal workflow and pricing administration.',
    `formulary_status` STRING COMMENT 'The formulary placement status of this medicinal product within the contract accounts formulary. Preferred status typically corresponds to more favorable pricing and higher utilization.',
    `minimum_order_quantity` STRING COMMENT 'The minimum order quantity required for this medicinal product under this contract to qualify for the contracted pricing. Used in order validation and contract compliance monitoring.',
    `rebate_percentage` DECIMAL(18,2) COMMENT 'The percentage rebate applicable to purchases of this medicinal product by this contract account. Rebates are typically paid quarterly or annually based on volume achievement.',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this contract pricing agreement record was last modified. Used for audit trail and change tracking.',
    `volume_tier` STRING COMMENT 'The volume commitment tier that this contract account has committed to for this medicinal product. Higher tiers typically correspond to larger volume commitments and more favorable pricing or rebate terms.',
    CONSTRAINT pk_contract_pricing PRIMARY KEY(`contract_pricing_id`)
) COMMENT 'This association product represents the commercial pricing contract between a medicinal product and an institutional contract account (GPO, IDN, hospital system, specialty pharmacy). It captures negotiated pricing terms, rebate structures, volume commitments, and contract periods that exist only in the context of this specific product-account relationship. Each record links one medicinal product to one contract account with pricing and terms that are unique to that combination. Supports contract pricing administration, rebate management, and institutional account management business processes.. Existence Justification: In pharmaceutical commercial operations, institutional contract accounts (GPOs, IDNs, hospital systems, specialty pharmacies) negotiate pricing agreements for multiple medicinal products, and each medicinal product has separate pricing contracts with multiple institutional accounts. The relationship represents a real operational business process: contract pricing administration and rebate management. Commercial teams actively create, negotiate, approve, and manage these contract pricing agreements as distinct business entities with product-account-specific terms.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`product`.`supply_allocation` (
    `supply_allocation_id` BIGINT COMMENT 'Unique identifier for the supply allocation record. Primary key for the association product.',
    `plant_id` BIGINT COMMENT 'Foreign key linking to the manufacturing or packaging plant providing supply. Part of the composite business key (sku_id, plant_id, effective_start_date).',
    `sku_id` BIGINT COMMENT 'Foreign key linking to the Stock Keeping Unit being supplied. Part of the composite business key (sku_id, plant_id, effective_start_date).',
    `allocation_percentage` DECIMAL(18,2) COMMENT 'Percentage of total SKU demand allocated to this plant in the supply network. Used for demand planning and ATP calculations. Sum of allocation percentages across all plants for a given SKU should equal 100% for active allocations. Null if allocation is based on absolute capacity rather than percentage.',
    `capacity_unit_of_measure` STRING COMMENT 'Unit of measure for the maximum capacity metric (e.g., bottles, cartons, pallets, dosage units). Should align with SKU packaging configuration.',
    `cost_per_unit` DECIMAL(18,2) COMMENT 'Standard manufacturing cost per unit for producing this SKU at this plant. Varies by plant due to labor costs, efficiency, scale, and local regulations. Used for supply network optimization and make-vs-buy decisions. Null if cost is managed at aggregate level.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the supply allocation record was first created in the system. Used for audit trail and change tracking.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the cost per unit (e.g., USD, EUR, GBP, JPY, CHF). Required when cost_per_unit is populated.',
    `effective_end_date` DATE COMMENT 'Date when this supply allocation ceases to be effective. Null for currently active allocations. Used to track supply network changes due to plant shutdowns, capacity reallocation, regulatory events, or strategic manufacturing network optimization.',
    `effective_start_date` DATE COMMENT 'Date when this supply allocation becomes effective. Part of the composite business key enabling temporal tracking of supply network changes. Used for supply continuity planning and historical analysis of manufacturing network evolution.',
    `is_active` BOOLEAN COMMENT 'Indicates whether the supply allocation record is currently active in the system. False if the record has been logically deleted or superseded. Used for filtering current supply network configuration.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the supply allocation record. Used for change tracking and data synchronization.',
    `lead_time_days` BIGINT COMMENT 'Standard lead time in days from order placement to product availability for this SKU from this specific plant. Varies by plant due to manufacturing batch cycles, packaging capacity, and logistics. Used for ATP calculations, order promising, and supply planning. Different from SKU-level lead time as it captures plant-specific manufacturing and logistics characteristics.',
    `maximum_capacity_units` DECIMAL(18,2) COMMENT 'Maximum production or packaging capacity for this SKU at this plant, expressed in SKU units (e.g., bottles, cartons). Used for capacity planning, demand allocation, and ATP calculations. Null if capacity is managed at aggregate plant level rather than SKU level.',
    `minimum_order_quantity` DECIMAL(18,2) COMMENT 'Minimum order quantity for this SKU from this plant, driven by batch size constraints, packaging line minimums, or economic order quantities. Null if no minimum applies. Used in supply planning and order consolidation logic.',
    `modified_by_user` STRING COMMENT 'User ID or name of the person who last modified the supply allocation record. Required for audit compliance and change management.',
    `primary_supply_flag` BOOLEAN COMMENT 'Indicates whether this plant is designated as the primary supply source for this SKU. True for primary plant, false for secondary/backup plants. Only one plant should be marked as primary for a given SKU at any point in time. Used for supply chain routing and prioritization decisions.',
    `regulatory_approval_status` STRING COMMENT 'Regulatory approval status for manufacturing this SKU at this plant for the target market. Approved indicates regulatory authority has approved this plant-SKU combination. Pending indicates approval in process. Critical for ensuring only approved plants supply to regulated markets.',
    `supply_priority` BIGINT COMMENT 'Numeric priority ranking for this plant in the supply network for this SKU. Lower numbers indicate higher priority (1 = highest priority). Used during supply allocation decisions when demand exceeds capacity or when plants experience disruptions. Enables cascading supply logic in ATP and order promising systems.',
    `supply_status` STRING COMMENT 'Current operational status of this supply allocation. Active indicates currently supplying, Planned indicates future supply source, Suspended indicates temporary disruption (e.g., plant maintenance, regulatory hold), Discontinued indicates permanently ended. Used for supply availability checks and network planning.',
    CONSTRAINT pk_supply_allocation PRIMARY KEY(`supply_allocation_id`)
) COMMENT 'This association product represents the supply relationship between a Stock Keeping Unit (SKU) and a manufacturing/packaging plant. It captures the multi-sourcing strategy for each SKU across the pharmaceutical manufacturing network, including primary and secondary supply designations, allocation percentages, lead times, and supply priority. Each record links one SKU to one plant with attributes that exist only in the context of this supply relationship. Critical for supply chain planning, available-to-promise (ATP) calculations, demand allocation during capacity constraints, and supply continuity management during plant shutdowns or regulatory events.. Existence Justification: In pharmaceutical supply chain operations, SKUs are routinely sourced from multiple manufacturing and packaging plants to ensure supply continuity, balance capacity utilization, and comply with regulatory requirements for multi-site approval. Each plant can produce multiple SKUs across different therapeutic areas and dosage forms. The business actively manages these supply allocations with plant-specific data including allocation percentages, primary/secondary designations, lead times, supply priority rankings, and regulatory approval status for each plant-SKU combination.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`product`.`drug_product_assay_specification` (
    `drug_product_assay_specification_id` BIGINT COMMENT 'Primary key for the drug_product_assay_specification association',
    `assay_id` BIGINT COMMENT 'Foreign key linking to the assay master record that defines the test method, technology platform, and validation status',
    `drug_product_id` BIGINT COMMENT 'Foreign key linking to the drug product being tested under this specification',
    `site_id` BIGINT COMMENT 'Reference to the QC laboratory or contract testing organization authorized to perform this assay for this product. May differ by product even for the same assay.',
    `assay_purpose` STRING COMMENT 'The regulatory and operational purpose for which this assay is applied to this drug product. Determines when and how the assay is executed in the product lifecycle.',
    `compendial_method_flag` BOOLEAN COMMENT 'Indicates whether this assay is a pharmacopeial method (USP, EP, JP) applied to this product, which may have different validation and change control requirements than proprietary methods.',
    `created_date` TIMESTAMP COMMENT 'Timestamp when this specification record was created in the system.',
    `last_modified_by` STRING COMMENT 'User or system identifier that last modified this specification record.',
    `last_modified_date` TIMESTAMP COMMENT 'Timestamp of the most recent modification to this specification record.',
    `lower_specification_limit` DECIMAL(18,2) COMMENT 'Numeric lower bound of the acceptance range for computational validation and trending. Null if specification is qualitative or one-sided.',
    `out_of_specification_procedure` STRING COMMENT 'Reference to the OOS investigation procedure or escalation path specific to this product-assay combination, which may vary by product criticality or regulatory risk.',
    `regulatory_commitment` STRING COMMENT 'Reference to the regulatory submission, approval letter, or commitment document that mandates this assay for this product (e.g., NDA 123456 Section 3.2.P.5.1, BLA approval letter dated 2022-03-15).',
    `reportable_to_regulatory_authority` BOOLEAN COMMENT 'Indicates whether results from this assay for this product must be included in annual reports, stability reports, or other regulatory submissions.',
    `sample_size` STRING COMMENT 'The number of units or replicates required for this assay when testing this product, as defined in the validation protocol or regulatory commitment.',
    `specification_effective_date` DATE COMMENT 'The date from which this specification became effective for batch release or stability testing. Critical for traceability when specifications change over product lifecycle.',
    `specification_expiry_date` DATE COMMENT 'The date on which this specification was superseded or retired. Null if currently active.',
    `specification_limit` STRING COMMENT 'The acceptance criteria or specification range for this assay when applied to this drug product (e.g., 95.0-105.0% of label claim, NMT 2.0% RSD). Product-specific and may differ from assay platform defaults.',
    `specification_version` STRING COMMENT 'Version identifier for this specification record, enabling change control and audit trail when acceptance criteria or testing frequency are revised.',
    `test_frequency` STRING COMMENT 'The cadence at which this assay must be performed on this drug product, driven by regulatory commitments, stability protocols, or risk-based testing strategies.',
    `upper_specification_limit` DECIMAL(18,2) COMMENT 'Numeric upper bound of the acceptance range for computational validation and trending. Null if specification is qualitative or one-sided.',
    `validation_protocol_reference` STRING COMMENT 'Document identifier for the validation protocol or report that qualifies this assay for use with this specific drug product.',
    `validation_status` STRING COMMENT 'The current validation state of this assay specifically for this drug product. An assay may be validated for one product but require transfer or revalidation for another.',
    `created_by` STRING COMMENT 'User or system identifier that created this specification record.',
    CONSTRAINT pk_drug_product_assay_specification PRIMARY KEY(`drug_product_assay_specification_id`)
) COMMENT 'This association product represents the quality control testing specification between a drug product and an assay. It captures the regulatory and operational requirements for testing each drug product using specific assays. Each record links one drug product to one assay with attributes that define the testing protocol, acceptance criteria, and regulatory commitments that exist only in the context of this specific product-assay combination.. Existence Justification: In pharmaceutical quality control operations, a single drug product requires multiple assays for comprehensive testing (potency, purity, dissolution, stability, impurities, content uniformity), and a single validated assay is reused across multiple drug products (platform assays, compendial methods like USP dissolution). The business actively manages these specifications as regulatory commitments with product-specific acceptance criteria, testing frequencies, and validation protocols that cannot reside on either the assay or drug product alone.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `pharmaceuticals_ecm`.`product`.`medicinal_product` ADD CONSTRAINT `fk_product_medicinal_product_drug_product_id` FOREIGN KEY (`drug_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`drug_product`(`drug_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`product`.`medicinal_product` ADD CONSTRAINT `fk_product_medicinal_product_reference_product_id` FOREIGN KEY (`reference_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`medicinal_product`(`medicinal_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`product`.`medicinal_product` ADD CONSTRAINT `fk_product_medicinal_product_therapeutic_area_id` FOREIGN KEY (`therapeutic_area_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`therapeutic_area`(`therapeutic_area_id`);
ALTER TABLE `pharmaceuticals_ecm`.`product`.`drug_product` ADD CONSTRAINT `fk_product_drug_product_drug_substance_id` FOREIGN KEY (`drug_substance_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`drug_substance`(`drug_substance_id`);
ALTER TABLE `pharmaceuticals_ecm`.`product`.`drug_product` ADD CONSTRAINT `fk_product_drug_product_rld_product_id` FOREIGN KEY (`rld_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`drug_product`(`drug_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`product`.`drug_product` ADD CONSTRAINT `fk_product_drug_product_therapeutic_area_id` FOREIGN KEY (`therapeutic_area_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`therapeutic_area`(`therapeutic_area_id`);
ALTER TABLE `pharmaceuticals_ecm`.`product`.`formulation` ADD CONSTRAINT `fk_product_formulation_drug_product_id` FOREIGN KEY (`drug_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`drug_product`(`drug_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`product`.`formulation_ingredient` ADD CONSTRAINT `fk_product_formulation_ingredient_drug_substance_id` FOREIGN KEY (`drug_substance_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`drug_substance`(`drug_substance_id`);
ALTER TABLE `pharmaceuticals_ecm`.`product`.`formulation_ingredient` ADD CONSTRAINT `fk_product_formulation_ingredient_excipient_id` FOREIGN KEY (`excipient_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`excipient`(`excipient_id`);
ALTER TABLE `pharmaceuticals_ecm`.`product`.`formulation_ingredient` ADD CONSTRAINT `fk_product_formulation_ingredient_formulation_id` FOREIGN KEY (`formulation_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`formulation`(`formulation_id`);
ALTER TABLE `pharmaceuticals_ecm`.`product`.`packaging_configuration` ADD CONSTRAINT `fk_product_packaging_configuration_drug_product_id` FOREIGN KEY (`drug_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`drug_product`(`drug_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`product`.`sku` ADD CONSTRAINT `fk_product_sku_medicinal_product_id` FOREIGN KEY (`medicinal_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`medicinal_product`(`medicinal_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`product`.`sku` ADD CONSTRAINT `fk_product_sku_packaging_configuration_id` FOREIGN KEY (`packaging_configuration_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`packaging_configuration`(`packaging_configuration_id`);
ALTER TABLE `pharmaceuticals_ecm`.`product`.`sku` ADD CONSTRAINT `fk_product_sku_therapeutic_area_id` FOREIGN KEY (`therapeutic_area_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`therapeutic_area`(`therapeutic_area_id`);
ALTER TABLE `pharmaceuticals_ecm`.`product`.`product_ndc_code` ADD CONSTRAINT `fk_product_product_ndc_code_medicinal_product_id` FOREIGN KEY (`medicinal_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`medicinal_product`(`medicinal_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`product`.`product_ndc_code` ADD CONSTRAINT `fk_product_product_ndc_code_packaging_configuration_id` FOREIGN KEY (`packaging_configuration_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`packaging_configuration`(`packaging_configuration_id`);
ALTER TABLE `pharmaceuticals_ecm`.`product`.`lifecycle` ADD CONSTRAINT `fk_product_lifecycle_medicinal_product_id` FOREIGN KEY (`medicinal_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`medicinal_product`(`medicinal_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`product`.`lifecycle` ADD CONSTRAINT `fk_product_lifecycle_therapeutic_area_id` FOREIGN KEY (`therapeutic_area_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`therapeutic_area`(`therapeutic_area_id`);
ALTER TABLE `pharmaceuticals_ecm`.`product`.`regulatory_identifier` ADD CONSTRAINT `fk_product_regulatory_identifier_medicinal_product_id` FOREIGN KEY (`medicinal_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`medicinal_product`(`medicinal_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`product`.`regulatory_identifier` ADD CONSTRAINT `fk_product_regulatory_identifier_packaging_configuration_id` FOREIGN KEY (`packaging_configuration_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`packaging_configuration`(`packaging_configuration_id`);
ALTER TABLE `pharmaceuticals_ecm`.`product`.`regulatory_identifier` ADD CONSTRAINT `fk_product_regulatory_identifier_therapeutic_area_id` FOREIGN KEY (`therapeutic_area_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`therapeutic_area`(`therapeutic_area_id`);
ALTER TABLE `pharmaceuticals_ecm`.`product`.`indication` ADD CONSTRAINT `fk_product_indication_medicinal_product_id` FOREIGN KEY (`medicinal_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`medicinal_product`(`medicinal_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`product`.`indication` ADD CONSTRAINT `fk_product_indication_therapeutic_area_id` FOREIGN KEY (`therapeutic_area_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`therapeutic_area`(`therapeutic_area_id`);
ALTER TABLE `pharmaceuticals_ecm`.`product`.`labeling` ADD CONSTRAINT `fk_product_labeling_drug_product_id` FOREIGN KEY (`drug_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`drug_product`(`drug_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`product`.`labeling` ADD CONSTRAINT `fk_product_labeling_packaging_configuration_id` FOREIGN KEY (`packaging_configuration_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`packaging_configuration`(`packaging_configuration_id`);
ALTER TABLE `pharmaceuticals_ecm`.`product`.`product_change_control` ADD CONSTRAINT `fk_product_product_change_control_medicinal_product_id` FOREIGN KEY (`medicinal_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`medicinal_product`(`medicinal_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`product`.`combination_product` ADD CONSTRAINT `fk_product_combination_product_drug_product_id` FOREIGN KEY (`drug_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`drug_product`(`drug_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`product`.`combination_product` ADD CONSTRAINT `fk_product_combination_product_therapeutic_area_id` FOREIGN KEY (`therapeutic_area_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`therapeutic_area`(`therapeutic_area_id`);
ALTER TABLE `pharmaceuticals_ecm`.`product`.`therapeutic_area` ADD CONSTRAINT `fk_product_therapeutic_area_parent_therapeutic_area_id` FOREIGN KEY (`parent_therapeutic_area_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`therapeutic_area`(`therapeutic_area_id`);
ALTER TABLE `pharmaceuticals_ecm`.`product`.`device_component` ADD CONSTRAINT `fk_product_device_component_combination_product_id` FOREIGN KEY (`combination_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`combination_product`(`combination_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`product`.`device_component` ADD CONSTRAINT `fk_product_device_component_parent_device_component_id` FOREIGN KEY (`parent_device_component_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`device_component`(`device_component_id`);
ALTER TABLE `pharmaceuticals_ecm`.`product`.`excipient` ADD CONSTRAINT `fk_product_excipient_parent_excipient_id` FOREIGN KEY (`parent_excipient_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`excipient`(`excipient_id`);
ALTER TABLE `pharmaceuticals_ecm`.`product`.`bioequivalence_study` ADD CONSTRAINT `fk_product_bioequivalence_study_drug_product_id` FOREIGN KEY (`drug_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`drug_product`(`drug_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`product`.`bioequivalence_study` ADD CONSTRAINT `fk_product_bioequivalence_study_therapeutic_area_id` FOREIGN KEY (`therapeutic_area_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`therapeutic_area`(`therapeutic_area_id`);
ALTER TABLE `pharmaceuticals_ecm`.`product`.`bioequivalence_study` ADD CONSTRAINT `fk_product_bioequivalence_study_reference_bioequivalence_study_id` FOREIGN KEY (`reference_bioequivalence_study_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`bioequivalence_study`(`bioequivalence_study_id`);
ALTER TABLE `pharmaceuticals_ecm`.`product`.`pharmaceutical_product` ADD CONSTRAINT `fk_product_pharmaceutical_product_drug_product_id` FOREIGN KEY (`drug_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`drug_product`(`drug_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`product`.`pharmaceutical_product` ADD CONSTRAINT `fk_product_pharmaceutical_product_medicinal_product_id` FOREIGN KEY (`medicinal_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`medicinal_product`(`medicinal_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`product`.`pharmaceutical_product` ADD CONSTRAINT `fk_product_pharmaceutical_product_specified_substance_id` FOREIGN KEY (`specified_substance_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`specified_substance`(`specified_substance_id`);
ALTER TABLE `pharmaceuticals_ecm`.`product`.`pharmaceutical_product` ADD CONSTRAINT `fk_product_pharmaceutical_product_parent_pharmaceutical_product_id` FOREIGN KEY (`parent_pharmaceutical_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`pharmaceutical_product`(`pharmaceutical_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`product`.`specified_substance` ADD CONSTRAINT `fk_product_specified_substance_formulation_ingredient_id` FOREIGN KEY (`formulation_ingredient_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`formulation_ingredient`(`formulation_ingredient_id`);
ALTER TABLE `pharmaceuticals_ecm`.`product`.`specified_substance` ADD CONSTRAINT `fk_product_specified_substance_drug_substance_id` FOREIGN KEY (`drug_substance_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`drug_substance`(`drug_substance_id`);
ALTER TABLE `pharmaceuticals_ecm`.`product`.`specified_substance` ADD CONSTRAINT `fk_product_specified_substance_parent_specified_substance_id` FOREIGN KEY (`parent_specified_substance_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`specified_substance`(`specified_substance_id`);
ALTER TABLE `pharmaceuticals_ecm`.`product`.`prescription` ADD CONSTRAINT `fk_product_prescription_medicinal_product_id` FOREIGN KEY (`medicinal_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`medicinal_product`(`medicinal_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`product`.`formulary_listing` ADD CONSTRAINT `fk_product_formulary_listing_drug_product_id` FOREIGN KEY (`drug_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`drug_product`(`drug_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`product`.`approved_vendor` ADD CONSTRAINT `fk_product_approved_vendor_excipient_id` FOREIGN KEY (`excipient_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`excipient`(`excipient_id`);
ALTER TABLE `pharmaceuticals_ecm`.`product`.`product_payer_contract` ADD CONSTRAINT `fk_product_product_payer_contract_medicinal_product_id` FOREIGN KEY (`medicinal_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`medicinal_product`(`medicinal_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`product`.`kol_product_engagement` ADD CONSTRAINT `fk_product_kol_product_engagement_medicinal_product_id` FOREIGN KEY (`medicinal_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`medicinal_product`(`medicinal_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`product`.`contract_pricing` ADD CONSTRAINT `fk_product_contract_pricing_medicinal_product_id` FOREIGN KEY (`medicinal_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`medicinal_product`(`medicinal_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`product`.`supply_allocation` ADD CONSTRAINT `fk_product_supply_allocation_sku_id` FOREIGN KEY (`sku_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`sku`(`sku_id`);
ALTER TABLE `pharmaceuticals_ecm`.`product`.`drug_product_assay_specification` ADD CONSTRAINT `fk_product_drug_product_assay_specification_drug_product_id` FOREIGN KEY (`drug_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`drug_product`(`drug_product_id`);

-- ========= TAGS =========
ALTER SCHEMA `pharmaceuticals_ecm`.`product` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `pharmaceuticals_ecm`.`product` SET TAGS ('dbx_domain' = 'product');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`medicinal_product` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`medicinal_product` SET TAGS ('dbx_subdomain' = 'product_definition');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`medicinal_product` ALTER COLUMN `medicinal_product_id` SET TAGS ('dbx_business_glossary_term' = 'Medicinal Product Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`medicinal_product` ALTER COLUMN `atc_classification_id` SET TAGS ('dbx_business_glossary_term' = 'Atc Classification Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`medicinal_product` ALTER COLUMN `drug_product_id` SET TAGS ('dbx_business_glossary_term' = 'Drug Product Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`medicinal_product` ALTER COLUMN `inn_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Inn Registry Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`medicinal_product` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Mah Legal Entity Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`medicinal_product` ALTER COLUMN `masterdata_ndc_code_id` SET TAGS ('dbx_business_glossary_term' = 'Ndc Code Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`medicinal_product` ALTER COLUMN `patent_family_id` SET TAGS ('dbx_business_glossary_term' = 'Patent Family Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`medicinal_product` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Product Manager Employee Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`medicinal_product` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`medicinal_product` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`medicinal_product` ALTER COLUMN `reference_product_id` SET TAGS ('dbx_business_glossary_term' = 'Reference Product Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`medicinal_product` ALTER COLUMN `country_id` SET TAGS ('dbx_business_glossary_term' = 'Registration Country Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`medicinal_product` ALTER COLUMN `therapeutic_area_id` SET TAGS ('dbx_business_glossary_term' = 'Therapeutic Area Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`medicinal_product` ALTER COLUMN `trademark_id` SET TAGS ('dbx_business_glossary_term' = 'Trademark Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`medicinal_product` ALTER COLUMN `unit_of_measure_id` SET TAGS ('dbx_business_glossary_term' = 'Base Uom Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`medicinal_product` ALTER COLUMN `analytical_similarity_outcome` SET TAGS ('dbx_business_glossary_term' = 'Analytical Similarity Assessment Outcome');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`medicinal_product` ALTER COLUMN `analytical_similarity_outcome` SET TAGS ('dbx_value_regex' = 'Highly Similar|Similar with Minor Differences|Not Similar|Not Applicable');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`medicinal_product` ALTER COLUMN `controlled_substance_schedule` SET TAGS ('dbx_business_glossary_term' = 'Controlled Substance Schedule');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`medicinal_product` ALTER COLUMN `controlled_substance_schedule` SET TAGS ('dbx_value_regex' = 'Schedule I|Schedule II|Schedule III|Schedule IV|Schedule V|Not Controlled');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`medicinal_product` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`medicinal_product` ALTER COLUMN `development_stage` SET TAGS ('dbx_business_glossary_term' = 'Development Stage');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`medicinal_product` ALTER COLUMN `discontinuation_date` SET TAGS ('dbx_business_glossary_term' = 'Discontinuation Date');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`medicinal_product` ALTER COLUMN `discontinuation_reason` SET TAGS ('dbx_business_glossary_term' = 'Discontinuation Reason');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`medicinal_product` ALTER COLUMN `discontinuation_reason` SET TAGS ('dbx_value_regex' = 'Safety Concerns|Commercial Decision|Manufacturing Issues|Regulatory Action|Patent Expiry|Not Applicable');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`medicinal_product` ALTER COLUMN `exclusivity_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Exclusivity Expiry Date');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`medicinal_product` ALTER COLUMN `extrapolation_status` SET TAGS ('dbx_business_glossary_term' = 'Extrapolation Status');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`medicinal_product` ALTER COLUMN `extrapolation_status` SET TAGS ('dbx_value_regex' = 'Full Extrapolation|Partial Extrapolation|No Extrapolation|Not Applicable');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`medicinal_product` ALTER COLUMN `first_approval_date` SET TAGS ('dbx_business_glossary_term' = 'First Approval Date');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`medicinal_product` ALTER COLUMN `interchangeability_designation` SET TAGS ('dbx_business_glossary_term' = 'Interchangeability Designation');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`medicinal_product` ALTER COLUMN `interchangeability_designation` SET TAGS ('dbx_value_regex' = 'Interchangeable|Not Interchangeable|Not Applicable');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`medicinal_product` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`medicinal_product` ALTER COLUMN `launch_date` SET TAGS ('dbx_business_glossary_term' = 'Commercial Launch Date');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`medicinal_product` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_business_glossary_term' = 'Lifecycle Status');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`medicinal_product` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_value_regex' = 'Active|Inactive|Withdrawn|Suspended|Under Review');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`medicinal_product` ALTER COLUMN `moa` SET TAGS ('dbx_business_glossary_term' = 'Mechanism of Action (MOA)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`medicinal_product` ALTER COLUMN `originator_bla_number` SET TAGS ('dbx_business_glossary_term' = 'Originator Biologics License Application (BLA) Number');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`medicinal_product` ALTER COLUMN `originator_bla_number` SET TAGS ('dbx_value_regex' = '^BLA[0-9]{6}$');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`medicinal_product` ALTER COLUMN `originator_maa_number` SET TAGS ('dbx_business_glossary_term' = 'Originator Marketing Authorization Application (MAA) Number');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`medicinal_product` ALTER COLUMN `orphan_drug_designation` SET TAGS ('dbx_business_glossary_term' = 'Orphan Drug Designation');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`medicinal_product` ALTER COLUMN `patent_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Patent Expiry Date');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`medicinal_product` ALTER COLUMN `pediatric_indication` SET TAGS ('dbx_business_glossary_term' = 'Pediatric Indication');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`medicinal_product` ALTER COLUMN `prescription_required` SET TAGS ('dbx_business_glossary_term' = 'Prescription Required');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`medicinal_product` ALTER COLUMN `prescription_required` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`medicinal_product` ALTER COLUMN `prescription_required` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`medicinal_product` ALTER COLUMN `product_name` SET TAGS ('dbx_business_glossary_term' = 'Brand Name');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`medicinal_product` ALTER COLUMN `product_type` SET TAGS ('dbx_business_glossary_term' = 'Product Type');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`medicinal_product` ALTER COLUMN `qbd_approach` SET TAGS ('dbx_business_glossary_term' = 'Quality by Design (QbD) Approach');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`medicinal_product` ALTER COLUMN `regulatory_designation` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Designation');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`medicinal_product` ALTER COLUMN `rems_required` SET TAGS ('dbx_business_glossary_term' = 'Risk Evaluation and Mitigation Strategy (REMS) Required');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`medicinal_product` ALTER COLUMN `shelf_life_months` SET TAGS ('dbx_business_glossary_term' = 'Shelf Life (Months)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`medicinal_product` ALTER COLUMN `storage_conditions` SET TAGS ('dbx_business_glossary_term' = 'Storage Conditions');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`medicinal_product` ALTER COLUMN `usan` SET TAGS ('dbx_business_glossary_term' = 'United States Adopted Name (USAN)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`drug_substance` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`drug_substance` SET TAGS ('dbx_subdomain' = 'product_definition');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`drug_substance` ALTER COLUMN `drug_substance_id` SET TAGS ('dbx_business_glossary_term' = 'Drug Substance (DS) Identifier');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`drug_substance` ALTER COLUMN `atc_classification_id` SET TAGS ('dbx_business_glossary_term' = 'Atc Classification Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`drug_substance` ALTER COLUMN `drug_master_file_id` SET TAGS ('dbx_business_glossary_term' = 'Dmf Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`drug_substance` ALTER COLUMN `inn_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Inn Registry Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`drug_substance` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Legal Entity Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`drug_substance` ALTER COLUMN `patent_id` SET TAGS ('dbx_business_glossary_term' = 'Patent Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`drug_substance` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Technical Owner Employee Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`drug_substance` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`drug_substance` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`drug_substance` ALTER COLUMN `unit_of_measure_id` SET TAGS ('dbx_business_glossary_term' = 'Base Uom Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`drug_substance` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`drug_substance` ALTER COLUMN `adme_profile_summary` SET TAGS ('dbx_business_glossary_term' = 'Absorption Distribution Metabolism Excretion (ADME) Profile Summary');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`drug_substance` ALTER COLUMN `bcs_classification` SET TAGS ('dbx_business_glossary_term' = 'Biopharmaceutics Classification System (BCS) Class');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`drug_substance` ALTER COLUMN `bcs_classification` SET TAGS ('dbx_value_regex' = 'Class I|Class II|Class III|Class IV');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`drug_substance` ALTER COLUMN `cas_registry_number` SET TAGS ('dbx_business_glossary_term' = 'Chemical Abstracts Service (CAS) Registry Number');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`drug_substance` ALTER COLUMN `cas_registry_number` SET TAGS ('dbx_value_regex' = '^[1-9][0-9]{1,6}-[0-9]{2}-[0-9]$');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`drug_substance` ALTER COLUMN `chemical_name` SET TAGS ('dbx_business_glossary_term' = 'Chemical Name');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`drug_substance` ALTER COLUMN `chemical_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`drug_substance` ALTER COLUMN `controlled_substance_schedule` SET TAGS ('dbx_business_glossary_term' = 'Controlled Substance Schedule');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`drug_substance` ALTER COLUMN `controlled_substance_schedule` SET TAGS ('dbx_value_regex' = 'Schedule I|Schedule II|Schedule III|Schedule IV|Schedule V|Not Controlled');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`drug_substance` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`drug_substance` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`drug_substance` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`drug_substance` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Active Status Flag');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`drug_substance` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`drug_substance` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_business_glossary_term' = 'Lifecycle Status');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`drug_substance` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_value_regex' = 'discovery|preclinical|clinical|approved|marketed|discontinued');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`drug_substance` ALTER COLUMN `moa_summary` SET TAGS ('dbx_business_glossary_term' = 'Mechanism of Action (MOA) Summary');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`drug_substance` ALTER COLUMN `molecular_formula` SET TAGS ('dbx_business_glossary_term' = 'Molecular Formula');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`drug_substance` ALTER COLUMN `molecular_formula` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`drug_substance` ALTER COLUMN `molecular_weight` SET TAGS ('dbx_business_glossary_term' = 'Molecular Weight');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`drug_substance` ALTER COLUMN `nce_designation` SET TAGS ('dbx_business_glossary_term' = 'New Chemical Entity (NCE) Designation');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`drug_substance` ALTER COLUMN `orphan_drug_designation` SET TAGS ('dbx_business_glossary_term' = 'Orphan Drug Designation');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`drug_substance` ALTER COLUMN `particle_size_specification` SET TAGS ('dbx_business_glossary_term' = 'Particle Size Specification');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`drug_substance` ALTER COLUMN `pharmacopoeial_monograph` SET TAGS ('dbx_business_glossary_term' = 'Pharmacopoeial Monograph Reference');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`drug_substance` ALTER COLUMN `physical_form` SET TAGS ('dbx_business_glossary_term' = 'Physical Form');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`drug_substance` ALTER COLUMN `physical_form` SET TAGS ('dbx_value_regex' = 'solid|liquid|gas|semi-solid|lyophilized|amorphous');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`drug_substance` ALTER COLUMN `polymorphic_form` SET TAGS ('dbx_business_glossary_term' = 'Polymorphic Form');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`drug_substance` ALTER COLUMN `polymorphic_form` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`drug_substance` ALTER COLUMN `regulatory_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Status');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`drug_substance` ALTER COLUMN `retest_period_months` SET TAGS ('dbx_business_glossary_term' = 'Retest Period (Months)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`drug_substance` ALTER COLUMN `salt_form` SET TAGS ('dbx_business_glossary_term' = 'Salt Form');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`drug_substance` ALTER COLUMN `salt_form` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`drug_substance` ALTER COLUMN `solubility_profile` SET TAGS ('dbx_business_glossary_term' = 'Solubility Profile');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`drug_substance` ALTER COLUMN `specification_version` SET TAGS ('dbx_business_glossary_term' = 'Specification Version');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`drug_substance` ALTER COLUMN `stability_profile` SET TAGS ('dbx_business_glossary_term' = 'Stability Profile');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`drug_substance` ALTER COLUMN `stereochemistry` SET TAGS ('dbx_business_glossary_term' = 'Stereochemistry');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`drug_substance` ALTER COLUMN `stereochemistry` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`drug_substance` ALTER COLUMN `storage_conditions` SET TAGS ('dbx_business_glossary_term' = 'Storage Conditions');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`drug_substance` ALTER COLUMN `synthesis_route_version` SET TAGS ('dbx_business_glossary_term' = 'Synthesis Route Version');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`drug_substance` ALTER COLUMN `synthesis_route_version` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`drug_substance` ALTER COLUMN `therapeutic_class` SET TAGS ('dbx_business_glossary_term' = 'Therapeutic Class');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`drug_substance` ALTER COLUMN `usan_name` SET TAGS ('dbx_business_glossary_term' = 'United States Adopted Name (USAN)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`drug_product` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`drug_product` SET TAGS ('dbx_subdomain' = 'product_definition');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`drug_product` ALTER COLUMN `drug_product_id` SET TAGS ('dbx_business_glossary_term' = 'Drug Product (DP) Identifier');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`drug_product` ALTER COLUMN `country_id` SET TAGS ('dbx_business_glossary_term' = 'Approval Country Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`drug_product` ALTER COLUMN `atc_classification_id` SET TAGS ('dbx_business_glossary_term' = 'Atc Classification Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`drug_product` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Development Cost Center Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`drug_product` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Development Lead Employee Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`drug_product` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`drug_product` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`drug_product` ALTER COLUMN `drug_master_file_id` SET TAGS ('dbx_business_glossary_term' = 'Dmf Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`drug_product` ALTER COLUMN `drug_substance_id` SET TAGS ('dbx_business_glossary_term' = 'Drug Substance (DS) Identifier');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`drug_product` ALTER COLUMN `inn_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Inn Registry Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`drug_product` ALTER COLUMN `masterdata_ndc_code_id` SET TAGS ('dbx_business_glossary_term' = 'Ndc Code Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`drug_product` ALTER COLUMN `patent_id` SET TAGS ('dbx_business_glossary_term' = 'Patent Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`drug_product` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`drug_product` ALTER COLUMN `rld_product_id` SET TAGS ('dbx_business_glossary_term' = 'Reference Listed Drug (RLD) Product Identifier');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`drug_product` ALTER COLUMN `therapeutic_area_id` SET TAGS ('dbx_business_glossary_term' = 'Therapeutic Area Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`drug_product` ALTER COLUMN `unit_of_measure_id` SET TAGS ('dbx_business_glossary_term' = 'Strength Uom Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`drug_product` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Date');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`drug_product` ALTER COLUMN `black_box_warning_flag` SET TAGS ('dbx_business_glossary_term' = 'Black Box Warning Flag');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`drug_product` ALTER COLUMN `cmc_summary` SET TAGS ('dbx_business_glossary_term' = 'Chemistry Manufacturing and Controls (CMC) Summary');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`drug_product` ALTER COLUMN `cmc_summary` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`drug_product` ALTER COLUMN `controlled_substance_schedule` SET TAGS ('dbx_business_glossary_term' = 'Controlled Substance Schedule');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`drug_product` ALTER COLUMN `controlled_substance_schedule` SET TAGS ('dbx_value_regex' = 'schedule_I|schedule_II|schedule_III|schedule_IV|schedule_V|non_controlled');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`drug_product` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`drug_product` ALTER COLUMN `discontinuation_date` SET TAGS ('dbx_business_glossary_term' = 'Discontinuation Date');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`drug_product` ALTER COLUMN `dosage_form` SET TAGS ('dbx_business_glossary_term' = 'Dosage Form');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`drug_product` ALTER COLUMN `excipients` SET TAGS ('dbx_business_glossary_term' = 'Excipients');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`drug_product` ALTER COLUMN `formulation_type` SET TAGS ('dbx_business_glossary_term' = 'Formulation Type');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`drug_product` ALTER COLUMN `formulation_type` SET TAGS ('dbx_value_regex' = 'immediate_release|extended_release|delayed_release|modified_release|controlled_release');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`drug_product` ALTER COLUMN `launch_date` SET TAGS ('dbx_business_glossary_term' = 'Commercial Launch Date');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`drug_product` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_business_glossary_term' = 'Lifecycle Status');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`drug_product` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_value_regex' = 'development|approved|marketed|discontinued|withdrawn');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`drug_product` ALTER COLUMN `moa` SET TAGS ('dbx_business_glossary_term' = 'Mechanism of Action (MOA)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`drug_product` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`drug_product` ALTER COLUMN `package_size` SET TAGS ('dbx_business_glossary_term' = 'Package Size');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`drug_product` ALTER COLUMN `packaging_type` SET TAGS ('dbx_business_glossary_term' = 'Packaging Type');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`drug_product` ALTER COLUMN `packaging_type` SET TAGS ('dbx_value_regex' = 'bottle|blister|vial|ampule|prefilled_syringe|tube');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`drug_product` ALTER COLUMN `patent_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Patent Expiry Date');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`drug_product` ALTER COLUMN `patent_expiry_date` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`drug_product` ALTER COLUMN `prescription_status` SET TAGS ('dbx_business_glossary_term' = 'Prescription Status');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`drug_product` ALTER COLUMN `prescription_status` SET TAGS ('dbx_value_regex' = 'rx|otc|behind_the_counter');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`drug_product` ALTER COLUMN `prescription_status` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`drug_product` ALTER COLUMN `prescription_status` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`drug_product` ALTER COLUMN `product_code` SET TAGS ('dbx_business_glossary_term' = 'Product Code');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`drug_product` ALTER COLUMN `product_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,12}$');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`drug_product` ALTER COLUMN `product_name` SET TAGS ('dbx_business_glossary_term' = 'Product Name');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`drug_product` ALTER COLUMN `product_type` SET TAGS ('dbx_business_glossary_term' = 'Product Type');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`drug_product` ALTER COLUMN `product_type` SET TAGS ('dbx_value_regex' = 'branded|generic|biosimilar|vaccine|otc|medical_device_combination');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`drug_product` ALTER COLUMN `qbd_flag` SET TAGS ('dbx_business_glossary_term' = 'Quality by Design (QbD) Flag');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`drug_product` ALTER COLUMN `rems_flag` SET TAGS ('dbx_business_glossary_term' = 'Risk Evaluation and Mitigation Strategy (REMS) Flag');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`drug_product` ALTER COLUMN `rld_flag` SET TAGS ('dbx_business_glossary_term' = 'Reference Listed Drug (RLD) Flag');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`drug_product` ALTER COLUMN `route_of_administration` SET TAGS ('dbx_business_glossary_term' = 'Route of Administration');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`drug_product` ALTER COLUMN `route_of_administration` SET TAGS ('dbx_value_regex' = 'oral|intravenous|intramuscular|subcutaneous|topical|transdermal');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`drug_product` ALTER COLUMN `shelf_life_months` SET TAGS ('dbx_business_glossary_term' = 'Shelf Life in Months');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`drug_product` ALTER COLUMN `storage_conditions` SET TAGS ('dbx_business_glossary_term' = 'Storage Conditions');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`drug_product` ALTER COLUMN `strength` SET TAGS ('dbx_business_glossary_term' = 'Strength');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`drug_product` ALTER COLUMN `strength_value` SET TAGS ('dbx_business_glossary_term' = 'Strength Value');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`drug_product` ALTER COLUMN `usan` SET TAGS ('dbx_business_glossary_term' = 'United States Adopted Name (USAN)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`formulation` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`formulation` SET TAGS ('dbx_subdomain' = 'product_definition');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`formulation` ALTER COLUMN `formulation_id` SET TAGS ('dbx_business_glossary_term' = 'Formulation Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`formulation` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Development Plant Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`formulation` ALTER COLUMN `drug_product_id` SET TAGS ('dbx_business_glossary_term' = 'Drug Product (DP) Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`formulation` ALTER COLUMN `internal_order_id` SET TAGS ('dbx_business_glossary_term' = 'Internal Order Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`formulation` ALTER COLUMN `patent_id` SET TAGS ('dbx_business_glossary_term' = 'Patent Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`formulation` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Formulation Scientist Employee Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`formulation` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`formulation` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`formulation` ALTER COLUMN `unit_of_measure_id` SET TAGS ('dbx_business_glossary_term' = 'Unit Dose Strength Uom Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`formulation` ALTER COLUMN `api_count` SET TAGS ('dbx_business_glossary_term' = 'Active Pharmaceutical Ingredient (API) Count');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`formulation` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Formulation Approved By');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`formulation` ALTER COLUMN `approved_date` SET TAGS ('dbx_business_glossary_term' = 'Formulation Approved Date');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`formulation` ALTER COLUMN `batch_size_target` SET TAGS ('dbx_business_glossary_term' = 'Target Batch Size');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`formulation` ALTER COLUMN `batch_size_uom` SET TAGS ('dbx_business_glossary_term' = 'Batch Size Unit of Measure (UOM)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`formulation` ALTER COLUMN `bioequivalence_reference` SET TAGS ('dbx_business_glossary_term' = 'Bioequivalence Study Reference');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`formulation` ALTER COLUMN `composition_description` SET TAGS ('dbx_business_glossary_term' = 'Qualitative and Quantitative Composition (Q1/Q2) Description');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`formulation` ALTER COLUMN `cpp_summary` SET TAGS ('dbx_business_glossary_term' = 'Critical Process Parameters (CPP) Summary');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`formulation` ALTER COLUMN `cqa_summary` SET TAGS ('dbx_business_glossary_term' = 'Critical Quality Attributes (CQA) Summary');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`formulation` ALTER COLUMN `created_date` SET TAGS ('dbx_business_glossary_term' = 'Formulation Record Created Date');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`formulation` ALTER COLUMN `design_space_description` SET TAGS ('dbx_business_glossary_term' = 'Design Space Description');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`formulation` ALTER COLUMN `dosage_form` SET TAGS ('dbx_business_glossary_term' = 'Dosage Form');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`formulation` ALTER COLUMN `ectd_module_reference` SET TAGS ('dbx_business_glossary_term' = 'Electronic Common Technical Document (eCTD) Module Reference');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`formulation` ALTER COLUMN `excipient_count` SET TAGS ('dbx_business_glossary_term' = 'Excipient Count');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`formulation` ALTER COLUMN `formulation_code` SET TAGS ('dbx_business_glossary_term' = 'Formulation Code');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`formulation` ALTER COLUMN `formulation_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`formulation` ALTER COLUMN `formulation_name` SET TAGS ('dbx_business_glossary_term' = 'Formulation Name');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`formulation` ALTER COLUMN `formulation_status` SET TAGS ('dbx_business_glossary_term' = 'Formulation Status');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`formulation` ALTER COLUMN `formulation_status` SET TAGS ('dbx_value_regex' = 'development|optimization|validation|approved|commercial|discontinued');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`formulation` ALTER COLUMN `formulation_type` SET TAGS ('dbx_business_glossary_term' = 'Formulation Type');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`formulation` ALTER COLUMN `formulation_type` SET TAGS ('dbx_value_regex' = 'immediate_release|modified_release|extended_release|delayed_release|controlled_release|sustained_release');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`formulation` ALTER COLUMN `gmp_grade_required` SET TAGS ('dbx_business_glossary_term' = 'Good Manufacturing Practice (GMP) Grade Required');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`formulation` ALTER COLUMN `gmp_grade_required` SET TAGS ('dbx_value_regex' = 'clinical|commercial|both');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`formulation` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Formulation Record Last Modified By');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`formulation` ALTER COLUMN `last_modified_date` SET TAGS ('dbx_business_glossary_term' = 'Formulation Record Last Modified Date');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`formulation` ALTER COLUMN `manufacturing_process_type` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Process Type');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`formulation` ALTER COLUMN `patent_protected` SET TAGS ('dbx_business_glossary_term' = 'Patent Protected Flag');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`formulation` ALTER COLUMN `pharmacopoeial_standard` SET TAGS ('dbx_business_glossary_term' = 'Pharmacopoeial Standard');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`formulation` ALTER COLUMN `pharmacopoeial_standard` SET TAGS ('dbx_value_regex' = 'USP|EP|JP|BP|IP|ChP');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`formulation` ALTER COLUMN `qbd_design_space_defined` SET TAGS ('dbx_business_glossary_term' = 'Quality by Design (QbD) Design Space Defined Flag');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`formulation` ALTER COLUMN `regulatory_submission_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Submission Reference');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`formulation` ALTER COLUMN `route_of_administration` SET TAGS ('dbx_business_glossary_term' = 'Route of Administration');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`formulation` ALTER COLUMN `scale_up_factor` SET TAGS ('dbx_business_glossary_term' = 'Scale-Up Factor');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`formulation` ALTER COLUMN `shelf_life_months` SET TAGS ('dbx_business_glossary_term' = 'Shelf Life (Months)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`formulation` ALTER COLUMN `stability_profile_summary` SET TAGS ('dbx_business_glossary_term' = 'Stability Profile Summary');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`formulation` ALTER COLUMN `storage_conditions` SET TAGS ('dbx_business_glossary_term' = 'Storage Conditions');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`formulation` ALTER COLUMN `technology_transfer_status` SET TAGS ('dbx_business_glossary_term' = 'Technology Transfer Status');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`formulation` ALTER COLUMN `technology_transfer_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|tech_transfer_complete|validation_complete|commercial_ready');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`formulation` ALTER COLUMN `unit_dose_strength` SET TAGS ('dbx_business_glossary_term' = 'Unit Dose Strength');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`formulation` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Formulation Version Number');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`formulation` ALTER COLUMN `version_number` SET TAGS ('dbx_value_regex' = '^[0-9]{1,3}.[0-9]{1,3}$');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`formulation` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Formulation Record Created By');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`formulation_ingredient` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`formulation_ingredient` SET TAGS ('dbx_subdomain' = 'product_definition');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`formulation_ingredient` ALTER COLUMN `formulation_ingredient_id` SET TAGS ('dbx_business_glossary_term' = 'Formulation Ingredient Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`formulation_ingredient` ALTER COLUMN `business_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Business Partner Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`formulation_ingredient` ALTER COLUMN `drug_master_file_id` SET TAGS ('dbx_business_glossary_term' = 'Dmf Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`formulation_ingredient` ALTER COLUMN `drug_substance_id` SET TAGS ('dbx_business_glossary_term' = 'Drug Substance Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`formulation_ingredient` ALTER COLUMN `excipient_id` SET TAGS ('dbx_business_glossary_term' = 'Excipient Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`formulation_ingredient` ALTER COLUMN `formulation_id` SET TAGS ('dbx_business_glossary_term' = 'Formulation Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`formulation_ingredient` ALTER COLUMN `material_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`formulation_ingredient` ALTER COLUMN `unit_of_measure_id` SET TAGS ('dbx_business_glossary_term' = 'Unit Dose Uom Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`formulation_ingredient` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`formulation_ingredient` ALTER COLUMN `batch_quantity_uom` SET TAGS ('dbx_business_glossary_term' = 'Batch Quantity Unit of Measure (UOM)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`formulation_ingredient` ALTER COLUMN `batch_quantity_uom` SET TAGS ('dbx_value_regex' = 'kg|g|L|mL|units');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`formulation_ingredient` ALTER COLUMN `change_control_number` SET TAGS ('dbx_business_glossary_term' = 'Change Control Number');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`formulation_ingredient` ALTER COLUMN `coa_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Certificate of Analysis (CoA) Required Flag');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`formulation_ingredient` ALTER COLUMN `controlled_substance_schedule` SET TAGS ('dbx_business_glossary_term' = 'Controlled Substance Schedule');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`formulation_ingredient` ALTER COLUMN `controlled_substance_schedule` SET TAGS ('dbx_value_regex' = 'Schedule I|Schedule II|Schedule III|Schedule IV|Schedule V|non-controlled');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`formulation_ingredient` ALTER COLUMN `controlled_substance_schedule` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`formulation_ingredient` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`formulation_ingredient` ALTER COLUMN `critical_quality_attribute_flag` SET TAGS ('dbx_business_glossary_term' = 'Critical Quality Attribute (CQA) Flag');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`formulation_ingredient` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`formulation_ingredient` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`formulation_ingredient` ALTER COLUMN `ingredient_function` SET TAGS ('dbx_business_glossary_term' = 'Ingredient Function');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`formulation_ingredient` ALTER COLUMN `ingredient_name` SET TAGS ('dbx_business_glossary_term' = 'Ingredient Name');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`formulation_ingredient` ALTER COLUMN `ingredient_sequence_number` SET TAGS ('dbx_business_glossary_term' = 'Ingredient Sequence Number');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`formulation_ingredient` ALTER COLUMN `ingredient_type` SET TAGS ('dbx_business_glossary_term' = 'Ingredient Type');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`formulation_ingredient` ALTER COLUMN `ingredient_type` SET TAGS ('dbx_value_regex' = 'API|excipient|solvent|preservative|stabilizer|colorant');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`formulation_ingredient` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`formulation_ingredient` ALTER COLUMN `overage_justification` SET TAGS ('dbx_business_glossary_term' = 'Overage Justification');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`formulation_ingredient` ALTER COLUMN `overage_percentage` SET TAGS ('dbx_business_glossary_term' = 'Overage Percentage');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`formulation_ingredient` ALTER COLUMN `quantity_per_batch` SET TAGS ('dbx_business_glossary_term' = 'Quantity Per Batch');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`formulation_ingredient` ALTER COLUMN `quantity_per_unit_dose` SET TAGS ('dbx_business_glossary_term' = 'Quantity Per Unit Dose');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`formulation_ingredient` ALTER COLUMN `regulatory_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Status');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`formulation_ingredient` ALTER COLUMN `regulatory_status` SET TAGS ('dbx_value_regex' = 'approved|pending|restricted|obsolete');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`formulation_ingredient` ALTER COLUMN `retest_period_days` SET TAGS ('dbx_business_glossary_term' = 'Retest Period (Days)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`formulation_ingredient` ALTER COLUMN `specification_reference` SET TAGS ('dbx_business_glossary_term' = 'Specification Reference');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`formulation_ingredient` ALTER COLUMN `storage_condition` SET TAGS ('dbx_business_glossary_term' = 'Storage Condition');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`packaging_configuration` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`packaging_configuration` SET TAGS ('dbx_subdomain' = 'product_definition');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`packaging_configuration` ALTER COLUMN `packaging_configuration_id` SET TAGS ('dbx_business_glossary_term' = 'Packaging Configuration ID');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`packaging_configuration` ALTER COLUMN `drug_product_id` SET TAGS ('dbx_business_glossary_term' = 'Drug Product (DP) ID');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`packaging_configuration` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Packaging Plant Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`packaging_configuration` ALTER COLUMN `patent_id` SET TAGS ('dbx_business_glossary_term' = 'Patent Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`packaging_configuration` ALTER COLUMN `unit_of_measure_id` SET TAGS ('dbx_business_glossary_term' = 'Fill Volume Uom Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`packaging_configuration` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`packaging_configuration` ALTER COLUMN `aggregation_hierarchy` SET TAGS ('dbx_business_glossary_term' = 'Aggregation Hierarchy');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`packaging_configuration` ALTER COLUMN `child_resistant_packaging` SET TAGS ('dbx_business_glossary_term' = 'Child-Resistant Packaging');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`packaging_configuration` ALTER COLUMN `closure_type` SET TAGS ('dbx_business_glossary_term' = 'Closure Type');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`packaging_configuration` ALTER COLUMN `cold_chain_required` SET TAGS ('dbx_business_glossary_term' = 'Cold Chain Required');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`packaging_configuration` ALTER COLUMN `configuration_code` SET TAGS ('dbx_business_glossary_term' = 'Packaging Configuration Code');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`packaging_configuration` ALTER COLUMN `configuration_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`packaging_configuration` ALTER COLUMN `configuration_name` SET TAGS ('dbx_business_glossary_term' = 'Packaging Configuration Name');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`packaging_configuration` ALTER COLUMN `configuration_type` SET TAGS ('dbx_business_glossary_term' = 'Packaging Configuration Type');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`packaging_configuration` ALTER COLUMN `configuration_type` SET TAGS ('dbx_value_regex' = 'commercial|clinical|sample|investigational|compassionate_use|reference_standard');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`packaging_configuration` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`packaging_configuration` ALTER COLUMN `discontinuation_date` SET TAGS ('dbx_business_glossary_term' = 'Discontinuation Date');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`packaging_configuration` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`packaging_configuration` ALTER COLUMN `fill_volume_ml` SET TAGS ('dbx_business_glossary_term' = 'Fill Volume (mL)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`packaging_configuration` ALTER COLUMN `gtin` SET TAGS ('dbx_business_glossary_term' = 'Global Trade Item Number (GTIN)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`packaging_configuration` ALTER COLUMN `gtin` SET TAGS ('dbx_value_regex' = '^[0-9]{14}$');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`packaging_configuration` ALTER COLUMN `headspace_volume_ml` SET TAGS ('dbx_business_glossary_term' = 'Headspace Volume (mL)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`packaging_configuration` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`packaging_configuration` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_business_glossary_term' = 'Lifecycle Status');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`packaging_configuration` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_value_regex' = 'draft|pending_approval|active|discontinued|obsolete|withdrawn');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`packaging_configuration` ALTER COLUMN `light_protection_required` SET TAGS ('dbx_business_glossary_term' = 'Light Protection Required');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`packaging_configuration` ALTER COLUMN `market_authorization_country` SET TAGS ('dbx_business_glossary_term' = 'Market Authorization Country');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`packaging_configuration` ALTER COLUMN `market_authorization_country` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`packaging_configuration` ALTER COLUMN `moisture_protection_required` SET TAGS ('dbx_business_glossary_term' = 'Moisture Protection Required');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`packaging_configuration` ALTER COLUMN `ndc_code` SET TAGS ('dbx_business_glossary_term' = 'National Drug Code (NDC)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`packaging_configuration` ALTER COLUMN `ndc_code` SET TAGS ('dbx_value_regex' = '^[0-9]{5}-[0-9]{4}-[0-9]{2}$|^[0-9]{5}-[0-9]{3}-[0-9]{2}$|^[0-9]{4}-[0-9]{4}-[0-9]{2}$');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`packaging_configuration` ALTER COLUMN `nominal_fill_volume_ml` SET TAGS ('dbx_business_glossary_term' = 'Nominal Fill Volume (mL)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`packaging_configuration` ALTER COLUMN `package_insert_version` SET TAGS ('dbx_business_glossary_term' = 'Package Insert Version');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`packaging_configuration` ALTER COLUMN `primary_container_material` SET TAGS ('dbx_business_glossary_term' = 'Primary Container Material');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`packaging_configuration` ALTER COLUMN `primary_container_type` SET TAGS ('dbx_business_glossary_term' = 'Primary Container Type');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`packaging_configuration` ALTER COLUMN `regulatory_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Date');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`packaging_configuration` ALTER COLUMN `retest_period_months` SET TAGS ('dbx_business_glossary_term' = 'Retest Period (Months)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`packaging_configuration` ALTER COLUMN `secondary_packaging_material` SET TAGS ('dbx_business_glossary_term' = 'Secondary Packaging Material');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`packaging_configuration` ALTER COLUMN `secondary_packaging_material` SET TAGS ('dbx_value_regex' = 'paperboard|corrugated_cardboard|plastic|aluminum_foil|laminate');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`packaging_configuration` ALTER COLUMN `secondary_packaging_type` SET TAGS ('dbx_business_glossary_term' = 'Secondary Packaging Type');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`packaging_configuration` ALTER COLUMN `serialization_level` SET TAGS ('dbx_business_glossary_term' = 'Serialization Level');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`packaging_configuration` ALTER COLUMN `serialization_level` SET TAGS ('dbx_value_regex' = 'unit|pack|case|pallet|none');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`packaging_configuration` ALTER COLUMN `shelf_life_months` SET TAGS ('dbx_business_glossary_term' = 'Shelf Life (Months)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`packaging_configuration` ALTER COLUMN `storage_condition_description` SET TAGS ('dbx_business_glossary_term' = 'Storage Condition Description');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`packaging_configuration` ALTER COLUMN `storage_temperature_max_c` SET TAGS ('dbx_business_glossary_term' = 'Storage Temperature Maximum (°C)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`packaging_configuration` ALTER COLUMN `storage_temperature_min_c` SET TAGS ('dbx_business_glossary_term' = 'Storage Temperature Minimum (°C)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`packaging_configuration` ALTER COLUMN `tamper_evident_feature` SET TAGS ('dbx_business_glossary_term' = 'Tamper-Evident Feature');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`packaging_configuration` ALTER COLUMN `tamper_evident_feature` SET TAGS ('dbx_value_regex' = 'shrink_band|breakable_cap|seal|blister_integrity|none');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`packaging_configuration` ALTER COLUMN `tertiary_packaging_type` SET TAGS ('dbx_business_glossary_term' = 'Tertiary Packaging Type');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`packaging_configuration` ALTER COLUMN `tertiary_packaging_type` SET TAGS ('dbx_value_regex' = 'shipper|pallet|case|crate|none');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`packaging_configuration` ALTER COLUMN `units_per_primary_pack` SET TAGS ('dbx_business_glossary_term' = 'Units Per Primary Pack');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`packaging_configuration` ALTER COLUMN `units_per_secondary_pack` SET TAGS ('dbx_business_glossary_term' = 'Units Per Secondary Pack');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`packaging_configuration` ALTER COLUMN `units_per_tertiary_pack` SET TAGS ('dbx_business_glossary_term' = 'Units Per Tertiary Pack');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`sku` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`sku` SET TAGS ('dbx_subdomain' = 'product_definition');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`sku` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) Identifier');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`sku` ALTER COLUMN `country_id` SET TAGS ('dbx_business_glossary_term' = 'Country Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`sku` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Mah Legal Entity Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`sku` ALTER COLUMN `masterdata_ndc_code_id` SET TAGS ('dbx_business_glossary_term' = 'Ndc Code Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`sku` ALTER COLUMN `medicinal_product_id` SET TAGS ('dbx_business_glossary_term' = 'Product Identifier');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`sku` ALTER COLUMN `packaging_configuration_id` SET TAGS ('dbx_business_glossary_term' = 'Packaging Configuration Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`sku` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Site Identifier');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`sku` ALTER COLUMN `therapeutic_area_id` SET TAGS ('dbx_business_glossary_term' = 'Therapeutic Area Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`sku` ALTER COLUMN `trademark_id` SET TAGS ('dbx_business_glossary_term' = 'Trademark Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`sku` ALTER COLUMN `atc_code` SET TAGS ('dbx_business_glossary_term' = 'Anatomical Therapeutic Chemical (ATC) Classification Code');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`sku` ALTER COLUMN `atc_code` SET TAGS ('dbx_value_regex' = '^[A-Z][0-9]{2}[A-Z]{2}[0-9]{2}$');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`sku` ALTER COLUMN `commercial_status` SET TAGS ('dbx_business_glossary_term' = 'Commercial Status');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`sku` ALTER COLUMN `commercial_status` SET TAGS ('dbx_value_regex' = 'active|discontinued|withdrawn|suspended|pending_launch|obsolete');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`sku` ALTER COLUMN `controlled_substance_schedule` SET TAGS ('dbx_business_glossary_term' = 'Controlled Substance Schedule');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`sku` ALTER COLUMN `controlled_substance_schedule` SET TAGS ('dbx_value_regex' = 'schedule_I|schedule_II|schedule_III|schedule_IV|schedule_V|non_controlled');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`sku` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`sku` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`sku` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`sku` ALTER COLUMN `discontinuation_date` SET TAGS ('dbx_business_glossary_term' = 'Discontinuation Date');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`sku` ALTER COLUMN `distribution_channel` SET TAGS ('dbx_business_glossary_term' = 'Distribution Channel');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`sku` ALTER COLUMN `dosage_form` SET TAGS ('dbx_business_glossary_term' = 'Dosage Form');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`sku` ALTER COLUMN `generic_name` SET TAGS ('dbx_business_glossary_term' = 'Generic Name');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`sku` ALTER COLUMN `gtin` SET TAGS ('dbx_business_glossary_term' = 'Global Trade Item Number (GTIN)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`sku` ALTER COLUMN `gtin` SET TAGS ('dbx_value_regex' = '^[0-9]{8}|[0-9]{12}|[0-9]{13}|[0-9]{14}$');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`sku` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`sku` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`sku` ALTER COLUMN `launch_date` SET TAGS ('dbx_business_glossary_term' = 'Launch Date');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`sku` ALTER COLUMN `list_price` SET TAGS ('dbx_business_glossary_term' = 'List Price');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`sku` ALTER COLUMN `list_price` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`sku` ALTER COLUMN `material_number` SET TAGS ('dbx_business_glossary_term' = 'SAP Material Number');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`sku` ALTER COLUMN `material_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,18}$');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`sku` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`sku` ALTER COLUMN `prescription_status` SET TAGS ('dbx_business_glossary_term' = 'Prescription Status');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`sku` ALTER COLUMN `prescription_status` SET TAGS ('dbx_value_regex' = 'prescription_only|over_the_counter|behind_the_counter|hospital_only');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`sku` ALTER COLUMN `prescription_status` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`sku` ALTER COLUMN `prescription_status` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`sku` ALTER COLUMN `product_type` SET TAGS ('dbx_business_glossary_term' = 'Product Type');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`sku` ALTER COLUMN `regulatory_approval_number` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Number');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`sku` ALTER COLUMN `reimbursement_code` SET TAGS ('dbx_business_glossary_term' = 'Reimbursement Code');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`sku` ALTER COLUMN `rems_program` SET TAGS ('dbx_business_glossary_term' = 'Risk Evaluation and Mitigation Strategy (REMS) Program');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`sku` ALTER COLUMN `route_of_administration` SET TAGS ('dbx_business_glossary_term' = 'Route of Administration');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`sku` ALTER COLUMN `serialization_required` SET TAGS ('dbx_business_glossary_term' = 'Serialization Required');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`sku` ALTER COLUMN `strength` SET TAGS ('dbx_business_glossary_term' = 'Strength');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`sku` ALTER COLUMN `trade_name` SET TAGS ('dbx_business_glossary_term' = 'Trade Name');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`product_ndc_code` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`product_ndc_code` SET TAGS ('dbx_subdomain' = 'regulatory_compliance');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`product_ndc_code` ALTER COLUMN `product_ndc_code_id` SET TAGS ('dbx_business_glossary_term' = 'Product National Drug Code (NDC) ID');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`product_ndc_code` ALTER COLUMN `inn_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Inn Registry Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`product_ndc_code` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Labeler Legal Entity Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`product_ndc_code` ALTER COLUMN `medicinal_product_id` SET TAGS ('dbx_business_glossary_term' = 'Product ID');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`product_ndc_code` ALTER COLUMN `packaging_configuration_id` SET TAGS ('dbx_business_glossary_term' = 'Packaging Configuration Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`product_ndc_code` ALTER COLUMN `active_ingredient` SET TAGS ('dbx_business_glossary_term' = 'Active Pharmaceutical Ingredient (API)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`product_ndc_code` ALTER COLUMN `application_number` SET TAGS ('dbx_business_glossary_term' = 'FDA Application Number');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`product_ndc_code` ALTER COLUMN `application_number` SET TAGS ('dbx_value_regex' = '^(NDA|ANDA|BLA)[0-9]{6}$');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`product_ndc_code` ALTER COLUMN `application_type` SET TAGS ('dbx_business_glossary_term' = 'FDA Application Type');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`product_ndc_code` ALTER COLUMN `application_type` SET TAGS ('dbx_value_regex' = 'NDA|ANDA|BLA|OTC');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`product_ndc_code` ALTER COLUMN `atc_code` SET TAGS ('dbx_business_glossary_term' = 'Anatomical Therapeutic Chemical (ATC) Classification Code');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`product_ndc_code` ALTER COLUMN `atc_code` SET TAGS ('dbx_value_regex' = '^[A-Z][0-9]{2}[A-Z]{2}[0-9]{2}$');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`product_ndc_code` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`product_ndc_code` ALTER COLUMN `dea_schedule` SET TAGS ('dbx_business_glossary_term' = 'Drug Enforcement Administration (DEA) Schedule');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`product_ndc_code` ALTER COLUMN `dea_schedule` SET TAGS ('dbx_value_regex' = 'CI|CII|CIII|CIV|CV|unscheduled');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`product_ndc_code` ALTER COLUMN `dea_schedule` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`product_ndc_code` ALTER COLUMN `dosage_form` SET TAGS ('dbx_business_glossary_term' = 'Dosage Form');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`product_ndc_code` ALTER COLUMN `labeler_code` SET TAGS ('dbx_business_glossary_term' = 'National Drug Code (NDC) Labeler Code');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`product_ndc_code` ALTER COLUMN `labeler_code` SET TAGS ('dbx_value_regex' = '^[0-9]{4,5}$');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`product_ndc_code` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`product_ndc_code` ALTER COLUMN `listing_date` SET TAGS ('dbx_business_glossary_term' = 'FDA Listing Date');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`product_ndc_code` ALTER COLUMN `listing_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'FDA Listing Expiration Date');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`product_ndc_code` ALTER COLUMN `listing_status` SET TAGS ('dbx_business_glossary_term' = 'FDA Listing Status');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`product_ndc_code` ALTER COLUMN `listing_status` SET TAGS ('dbx_value_regex' = 'active|inactive|discontinued');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`product_ndc_code` ALTER COLUMN `marketing_end_date` SET TAGS ('dbx_business_glossary_term' = 'Marketing End Date');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`product_ndc_code` ALTER COLUMN `marketing_start_date` SET TAGS ('dbx_business_glossary_term' = 'Marketing Start Date');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`product_ndc_code` ALTER COLUMN `ndc_number` SET TAGS ('dbx_business_glossary_term' = 'National Drug Code (NDC) Number');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`product_ndc_code` ALTER COLUMN `ndc_number` SET TAGS ('dbx_value_regex' = '^[0-9]{5}-[0-9]{4}-[0-9]{2}$|^[0-9]{5}-[0-9]{3}-[0-9]{2}$|^[0-9]{4}-[0-9]{4}-[0-9]{2}$');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`product_ndc_code` ALTER COLUMN `non_proprietary_name` SET TAGS ('dbx_business_glossary_term' = 'Non-Proprietary (Generic) Name');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`product_ndc_code` ALTER COLUMN `package_code` SET TAGS ('dbx_business_glossary_term' = 'National Drug Code (NDC) Package Code');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`product_ndc_code` ALTER COLUMN `package_code` SET TAGS ('dbx_value_regex' = '^[0-9]{2}$');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`product_ndc_code` ALTER COLUMN `product_code` SET TAGS ('dbx_business_glossary_term' = 'National Drug Code (NDC) Product Code');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`product_ndc_code` ALTER COLUMN `product_code` SET TAGS ('dbx_value_regex' = '^[0-9]{3,4}$');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`product_ndc_code` ALTER COLUMN `product_type` SET TAGS ('dbx_business_glossary_term' = 'Product Type');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`product_ndc_code` ALTER COLUMN `product_type` SET TAGS ('dbx_value_regex' = 'human prescription drug|human otc drug|human prescription drug|biologics|vaccine|plasma derivative');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`product_ndc_code` ALTER COLUMN `proprietary_name` SET TAGS ('dbx_business_glossary_term' = 'Proprietary (Brand) Name');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`product_ndc_code` ALTER COLUMN `reimbursement_code` SET TAGS ('dbx_business_glossary_term' = 'Reimbursement Code');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`product_ndc_code` ALTER COLUMN `route_of_administration` SET TAGS ('dbx_business_glossary_term' = 'Route of Administration');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`product_ndc_code` ALTER COLUMN `rx_otc_indicator` SET TAGS ('dbx_business_glossary_term' = 'Prescription (Rx) or Over-The-Counter (OTC) Indicator');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`product_ndc_code` ALTER COLUMN `rx_otc_indicator` SET TAGS ('dbx_value_regex' = 'Rx|OTC');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`product_ndc_code` ALTER COLUMN `strength` SET TAGS ('dbx_business_glossary_term' = 'Drug Strength');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`product_ndc_code` ALTER COLUMN `therapeutic_equivalence_code` SET TAGS ('dbx_business_glossary_term' = 'FDA Therapeutic Equivalence Code');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`product_ndc_code` ALTER COLUMN `therapeutic_equivalence_code` SET TAGS ('dbx_value_regex' = '^[A-B][A-Z]{1,2}$');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`product_ndc_code` ALTER COLUMN `usan_name` SET TAGS ('dbx_business_glossary_term' = 'United States Adopted Name (USAN)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`lifecycle` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`lifecycle` SET TAGS ('dbx_subdomain' = 'regulatory_compliance');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`lifecycle` ALTER COLUMN `lifecycle_id` SET TAGS ('dbx_business_glossary_term' = 'Product Lifecycle ID');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`lifecycle` ALTER COLUMN `budget_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`lifecycle` ALTER COLUMN `medicinal_product_id` SET TAGS ('dbx_business_glossary_term' = 'Product ID');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`lifecycle` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Program Manager Employee Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`lifecycle` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`lifecycle` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`lifecycle` ALTER COLUMN `risk_register_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Risk Register Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`lifecycle` ALTER COLUMN `therapeutic_area_id` SET TAGS ('dbx_business_glossary_term' = 'Therapeutic Area Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`lifecycle` ALTER COLUMN `actual_launch_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Launch Date');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`lifecycle` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`lifecycle` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`lifecycle` ALTER COLUMN `discontinuation_date` SET TAGS ('dbx_business_glossary_term' = 'Discontinuation Date');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`lifecycle` ALTER COLUMN `discontinuation_reason` SET TAGS ('dbx_business_glossary_term' = 'Discontinuation Reason');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`lifecycle` ALTER COLUMN `exclusivity_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Exclusivity Expiry Date');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`lifecycle` ALTER COLUMN `exclusivity_expiry_date` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`lifecycle` ALTER COLUMN `gate_criteria_met` SET TAGS ('dbx_business_glossary_term' = 'Gate Criteria Met');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`lifecycle` ALTER COLUMN `gate_decision` SET TAGS ('dbx_business_glossary_term' = 'Gate Decision');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`lifecycle` ALTER COLUMN `gate_decision` SET TAGS ('dbx_value_regex' = 'go|conditional_go|hold|kill|recycle');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`lifecycle` ALTER COLUMN `gate_review_date` SET TAGS ('dbx_business_glossary_term' = 'Gate Review Date');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`lifecycle` ALTER COLUMN `indication` SET TAGS ('dbx_business_glossary_term' = 'Indication');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`lifecycle` ALTER COLUMN `investment_to_date` SET TAGS ('dbx_business_glossary_term' = 'Investment to Date');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`lifecycle` ALTER COLUMN `investment_to_date` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`lifecycle` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`lifecycle` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_business_glossary_term' = 'Lifecycle Status');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`lifecycle` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_value_regex' = 'active|on_hold|suspended|terminated|completed|pending_approval');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`lifecycle` ALTER COLUMN `milestone_date` SET TAGS ('dbx_business_glossary_term' = 'Milestone Date');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`lifecycle` ALTER COLUMN `milestone_event` SET TAGS ('dbx_business_glossary_term' = 'Milestone Event');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`lifecycle` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`lifecycle` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`lifecycle` ALTER COLUMN `next_planned_stage` SET TAGS ('dbx_business_glossary_term' = 'Next Planned Lifecycle Stage');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`lifecycle` ALTER COLUMN `patent_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Patent Expiry Date');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`lifecycle` ALTER COLUMN `patent_expiry_date` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`lifecycle` ALTER COLUMN `previous_stage` SET TAGS ('dbx_business_glossary_term' = 'Previous Lifecycle Stage');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`lifecycle` ALTER COLUMN `probability_of_success` SET TAGS ('dbx_business_glossary_term' = 'Probability of Success (PoS)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`lifecycle` ALTER COLUMN `probability_of_success` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`lifecycle` ALTER COLUMN `projected_peak_sales` SET TAGS ('dbx_business_glossary_term' = 'Projected Peak Sales');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`lifecycle` ALTER COLUMN `projected_peak_sales` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`lifecycle` ALTER COLUMN `regulatory_pathway` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Pathway');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`lifecycle` ALTER COLUMN `responsible_team` SET TAGS ('dbx_business_glossary_term' = 'Responsible Team');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`lifecycle` ALTER COLUMN `stage` SET TAGS ('dbx_business_glossary_term' = 'Lifecycle Stage');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`lifecycle` ALTER COLUMN `stage_entry_date` SET TAGS ('dbx_business_glossary_term' = 'Stage Entry Date');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`lifecycle` ALTER COLUMN `stage_exit_date` SET TAGS ('dbx_business_glossary_term' = 'Stage Exit Date');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`lifecycle` ALTER COLUMN `strategic_priority` SET TAGS ('dbx_business_glossary_term' = 'Strategic Priority');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`lifecycle` ALTER COLUMN `strategic_priority` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`lifecycle` ALTER COLUMN `target_launch_date` SET TAGS ('dbx_business_glossary_term' = 'Target Launch Date');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`regulatory_identifier` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`regulatory_identifier` SET TAGS ('dbx_subdomain' = 'regulatory_compliance');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`regulatory_identifier` ALTER COLUMN `regulatory_identifier_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Identifier ID');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`regulatory_identifier` ALTER COLUMN `country_id` SET TAGS ('dbx_business_glossary_term' = 'Country Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`regulatory_identifier` ALTER COLUMN `inn_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Inn Registry Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`regulatory_identifier` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Mah Legal Entity Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`regulatory_identifier` ALTER COLUMN `medicinal_product_id` SET TAGS ('dbx_business_glossary_term' = 'Product ID');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`regulatory_identifier` ALTER COLUMN `packaging_configuration_id` SET TAGS ('dbx_business_glossary_term' = 'Packaging Configuration Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`regulatory_identifier` ALTER COLUMN `therapeutic_area_id` SET TAGS ('dbx_business_glossary_term' = 'Therapeutic Area Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`regulatory_identifier` ALTER COLUMN `application_number` SET TAGS ('dbx_business_glossary_term' = 'Application Number');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`regulatory_identifier` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`regulatory_identifier` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`regulatory_identifier` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'Approved|Pending|Withdrawn|Suspended|Expired|Rejected');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`regulatory_identifier` ALTER COLUMN `atc_code` SET TAGS ('dbx_business_glossary_term' = 'Anatomical Therapeutic Chemical (ATC) Classification Code');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`regulatory_identifier` ALTER COLUMN `atc_code` SET TAGS ('dbx_value_regex' = '^[A-Z][0-9]{2}[A-Z]{2}[0-9]{2}$');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`regulatory_identifier` ALTER COLUMN `breakthrough_therapy_designation` SET TAGS ('dbx_business_glossary_term' = 'Breakthrough Therapy Designation');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`regulatory_identifier` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`regulatory_identifier` ALTER COLUMN `dea_schedule` SET TAGS ('dbx_business_glossary_term' = 'Drug Enforcement Administration (DEA) Schedule');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`regulatory_identifier` ALTER COLUMN `dea_schedule` SET TAGS ('dbx_value_regex' = 'Schedule I|Schedule II|Schedule III|Schedule IV|Schedule V|Non-Controlled');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`regulatory_identifier` ALTER COLUMN `dosage_form` SET TAGS ('dbx_business_glossary_term' = 'Dosage Form');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`regulatory_identifier` ALTER COLUMN `exclusivity_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Exclusivity Expiration Date');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`regulatory_identifier` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`regulatory_identifier` ALTER COLUMN `fast_track_designation` SET TAGS ('dbx_business_glossary_term' = 'Fast Track Designation');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`regulatory_identifier` ALTER COLUMN `identifier_number` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Identifier Number');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`regulatory_identifier` ALTER COLUMN `identifier_type` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Identifier Type');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`regulatory_identifier` ALTER COLUMN `issuing_authority` SET TAGS ('dbx_business_glossary_term' = 'Issuing Authority');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`regulatory_identifier` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`regulatory_identifier` ALTER COLUMN `listing_date` SET TAGS ('dbx_business_glossary_term' = 'Listing Date');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`regulatory_identifier` ALTER COLUMN `listing_status` SET TAGS ('dbx_business_glossary_term' = 'Listing Status');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`regulatory_identifier` ALTER COLUMN `listing_status` SET TAGS ('dbx_value_regex' = 'Active|Inactive|Discontinued');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`regulatory_identifier` ALTER COLUMN `marketing_category` SET TAGS ('dbx_business_glossary_term' = 'Marketing Category');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`regulatory_identifier` ALTER COLUMN `ndc_labeler_code` SET TAGS ('dbx_business_glossary_term' = 'National Drug Code (NDC) Labeler Code');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`regulatory_identifier` ALTER COLUMN `ndc_labeler_code` SET TAGS ('dbx_value_regex' = '^[0-9]{4,5}$');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`regulatory_identifier` ALTER COLUMN `ndc_package_code` SET TAGS ('dbx_business_glossary_term' = 'National Drug Code (NDC) Package Code');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`regulatory_identifier` ALTER COLUMN `ndc_package_code` SET TAGS ('dbx_value_regex' = '^[0-9]{1,2}$');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`regulatory_identifier` ALTER COLUMN `ndc_product_code` SET TAGS ('dbx_business_glossary_term' = 'National Drug Code (NDC) Product Code');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`regulatory_identifier` ALTER COLUMN `ndc_product_code` SET TAGS ('dbx_value_regex' = '^[0-9]{3,4}$');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`regulatory_identifier` ALTER COLUMN `non_proprietary_name` SET TAGS ('dbx_business_glossary_term' = 'Non-Proprietary Name');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`regulatory_identifier` ALTER COLUMN `orphan_drug_designation` SET TAGS ('dbx_business_glossary_term' = 'Orphan Drug Designation');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`regulatory_identifier` ALTER COLUMN `priority_review_designation` SET TAGS ('dbx_business_glossary_term' = 'Priority Review Designation');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`regulatory_identifier` ALTER COLUMN `proprietary_name` SET TAGS ('dbx_business_glossary_term' = 'Proprietary Name');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`regulatory_identifier` ALTER COLUMN `rems_required` SET TAGS ('dbx_business_glossary_term' = 'Risk Evaluation and Mitigation Strategy (REMS) Required');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`regulatory_identifier` ALTER COLUMN `renewal_date` SET TAGS ('dbx_business_glossary_term' = 'Renewal Date');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`regulatory_identifier` ALTER COLUMN `route_of_administration` SET TAGS ('dbx_business_glossary_term' = 'Route of Administration');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`regulatory_identifier` ALTER COLUMN `strength` SET TAGS ('dbx_business_glossary_term' = 'Strength');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`regulatory_identifier` ALTER COLUMN `usan` SET TAGS ('dbx_business_glossary_term' = 'United States Adopted Name (USAN)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`regulatory_identifier` ALTER COLUMN `withdrawal_date` SET TAGS ('dbx_business_glossary_term' = 'Withdrawal Date');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`regulatory_identifier` ALTER COLUMN `withdrawal_reason` SET TAGS ('dbx_business_glossary_term' = 'Withdrawal Reason');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`indication` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`indication` SET TAGS ('dbx_subdomain' = 'regulatory_compliance');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`indication` ALTER COLUMN `indication_id` SET TAGS ('dbx_business_glossary_term' = 'Product Indication Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`indication` ALTER COLUMN `country_id` SET TAGS ('dbx_business_glossary_term' = 'Approval Country Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`indication` ALTER COLUMN `atc_classification_id` SET TAGS ('dbx_business_glossary_term' = 'Atc Classification Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`indication` ALTER COLUMN `medicinal_product_id` SET TAGS ('dbx_business_glossary_term' = 'Product Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`indication` ALTER COLUMN `therapeutic_area_id` SET TAGS ('dbx_business_glossary_term' = 'Therapeutic Area Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`indication` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`indication` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`indication` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'approved|investigational|withdrawn|pending|rejected|suspended');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`indication` ALTER COLUMN `biomarker_requirement` SET TAGS ('dbx_business_glossary_term' = 'Biomarker Requirement');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`indication` ALTER COLUMN `black_box_warning_flag` SET TAGS ('dbx_business_glossary_term' = 'Black Box Warning Flag');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`indication` ALTER COLUMN `breakthrough_designation_flag` SET TAGS ('dbx_business_glossary_term' = 'Breakthrough Therapy Designation Flag');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`indication` ALTER COLUMN `clinical_trial_identifier` SET TAGS ('dbx_business_glossary_term' = 'Clinical Trial Identifier');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`indication` ALTER COLUMN `clinical_trial_identifier` SET TAGS ('dbx_value_regex' = '^NCT[0-9]{8}$|^EUCTR[0-9]{4}-[0-9]{6}-[0-9]{2}$|^ISRCTN[0-9]{8}$');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`indication` ALTER COLUMN `combination_partners` SET TAGS ('dbx_business_glossary_term' = 'Combination Therapy Partners');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`indication` ALTER COLUMN `combination_therapy_flag` SET TAGS ('dbx_business_glossary_term' = 'Combination Therapy Flag');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`indication` ALTER COLUMN `contraindication_summary` SET TAGS ('dbx_business_glossary_term' = 'Contraindication Summary');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`indication` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`indication` ALTER COLUMN `disease_severity` SET TAGS ('dbx_business_glossary_term' = 'Disease Severity');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`indication` ALTER COLUMN `disease_severity` SET TAGS ('dbx_value_regex' = 'mild|moderate|severe|critical|life_threatening|not_applicable');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`indication` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`indication` ALTER COLUMN `exclusivity_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Market Exclusivity Expiry Date');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`indication` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`indication` ALTER COLUMN `icd_10_code` SET TAGS ('dbx_business_glossary_term' = 'International Classification of Diseases 10th Revision (ICD-10) Code');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`indication` ALTER COLUMN `icd_10_code` SET TAGS ('dbx_value_regex' = '^[A-Z][0-9]{2}(.[0-9]{1,2})?$');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`indication` ALTER COLUMN `icd_10_description` SET TAGS ('dbx_business_glossary_term' = 'International Classification of Diseases 10th Revision (ICD-10) Description');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`indication` ALTER COLUMN `indication_name` SET TAGS ('dbx_business_glossary_term' = 'Indication Name');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`indication` ALTER COLUMN `indication_type` SET TAGS ('dbx_business_glossary_term' = 'Indication Type');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`indication` ALTER COLUMN `indication_type` SET TAGS ('dbx_value_regex' = 'treatment|prevention|diagnosis|prophylaxis|palliation|risk_reduction');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`indication` ALTER COLUMN `label_claim_text` SET TAGS ('dbx_business_glossary_term' = 'Label Claim Text');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`indication` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`indication` ALTER COLUMN `line_of_therapy` SET TAGS ('dbx_business_glossary_term' = 'Line of Therapy');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`indication` ALTER COLUMN `meddra_pt_code` SET TAGS ('dbx_business_glossary_term' = 'Medical Dictionary for Regulatory Activities (MedDRA) Preferred Term (PT) Code');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`indication` ALTER COLUMN `meddra_pt_code` SET TAGS ('dbx_value_regex' = '^[0-9]{8}$');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`indication` ALTER COLUMN `meddra_pt_name` SET TAGS ('dbx_business_glossary_term' = 'Medical Dictionary for Regulatory Activities (MedDRA) Preferred Term (PT) Name');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`indication` ALTER COLUMN `orphan_designation_flag` SET TAGS ('dbx_business_glossary_term' = 'Orphan Designation Flag');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`indication` ALTER COLUMN `patent_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Patent Expiry Date');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`indication` ALTER COLUMN `patient_population` SET TAGS ('dbx_business_glossary_term' = 'Patient Population');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`indication` ALTER COLUMN `patient_population` SET TAGS ('dbx_value_regex' = 'adult|pediatric|geriatric|neonatal|adolescent|all_ages');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`indication` ALTER COLUMN `record_status` SET TAGS ('dbx_business_glossary_term' = 'Record Status');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`indication` ALTER COLUMN `record_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|superseded|withdrawn');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`indication` ALTER COLUMN `rems_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Risk Evaluation and Mitigation Strategy (REMS) Required Flag');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`labeling` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`labeling` SET TAGS ('dbx_subdomain' = 'regulatory_compliance');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`labeling` ALTER COLUMN `labeling_id` SET TAGS ('dbx_business_glossary_term' = 'Product Labeling ID');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`labeling` ALTER COLUMN `compliance_capa_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Capa Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`labeling` ALTER COLUMN `country_id` SET TAGS ('dbx_business_glossary_term' = 'Country Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`labeling` ALTER COLUMN `drug_product_id` SET TAGS ('dbx_business_glossary_term' = 'Drug Product (DP) ID');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`labeling` ALTER COLUMN `inspection_observation_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Observation Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`labeling` ALTER COLUMN `label_id` SET TAGS ('dbx_business_glossary_term' = 'Label Document ID');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`labeling` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Mah Legal Entity Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`labeling` ALTER COLUMN `orange_book_listing_id` SET TAGS ('dbx_business_glossary_term' = 'Orange Book Listing Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`labeling` ALTER COLUMN `packaging_configuration_id` SET TAGS ('dbx_business_glossary_term' = 'Packaging Configuration Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`labeling` ALTER COLUMN `policy_document_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Document Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`labeling` ALTER COLUMN `adverse_reactions_text` SET TAGS ('dbx_business_glossary_term' = 'Adverse Reactions Text');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`labeling` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Date');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`labeling` ALTER COLUMN `atc_code` SET TAGS ('dbx_business_glossary_term' = 'Anatomical Therapeutic Chemical (ATC) Classification Code');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`labeling` ALTER COLUMN `atc_code` SET TAGS ('dbx_value_regex' = '^[A-Z][0-9]{2}[A-Z]{2}[0-9]{2}$');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`labeling` ALTER COLUMN `black_box_warning_flag` SET TAGS ('dbx_business_glossary_term' = 'Black Box Warning Flag');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`labeling` ALTER COLUMN `clinical_pharmacology_text` SET TAGS ('dbx_business_glossary_term' = 'Clinical Pharmacology Text');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`labeling` ALTER COLUMN `contraindications_text` SET TAGS ('dbx_business_glossary_term' = 'Contraindications Text');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`labeling` ALTER COLUMN `controlled_substance_schedule` SET TAGS ('dbx_business_glossary_term' = 'Controlled Substance Schedule');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`labeling` ALTER COLUMN `controlled_substance_schedule` SET TAGS ('dbx_value_regex' = 'Schedule I|Schedule II|Schedule III|Schedule IV|Schedule V|Not Controlled');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`labeling` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`labeling` ALTER COLUMN `dosage_administration_text` SET TAGS ('dbx_business_glossary_term' = 'Dosage and Administration Text');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`labeling` ALTER COLUMN `dosage_form` SET TAGS ('dbx_business_glossary_term' = 'Dosage Form');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`labeling` ALTER COLUMN `drug_interactions_text` SET TAGS ('dbx_business_glossary_term' = 'Drug Interactions Text');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`labeling` ALTER COLUMN `ectd_sequence_number` SET TAGS ('dbx_business_glossary_term' = 'Electronic Common Technical Document (eCTD) Sequence Number');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`labeling` ALTER COLUMN `ectd_sequence_number` SET TAGS ('dbx_value_regex' = '^[0-9]{4}$');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`labeling` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Label Effective Date');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`labeling` ALTER COLUMN `established_name` SET TAGS ('dbx_business_glossary_term' = 'Established (Generic) Name');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`labeling` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Label Expiration Date');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`labeling` ALTER COLUMN `indications_text` SET TAGS ('dbx_business_glossary_term' = 'Indications and Usage Text');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`labeling` ALTER COLUMN `label_language_code` SET TAGS ('dbx_business_glossary_term' = 'Label Language Code');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`labeling` ALTER COLUMN `label_language_code` SET TAGS ('dbx_value_regex' = '^[a-z]{2}$');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`labeling` ALTER COLUMN `label_status` SET TAGS ('dbx_business_glossary_term' = 'Label Lifecycle Status');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`labeling` ALTER COLUMN `label_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|approved|active|superseded|withdrawn');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`labeling` ALTER COLUMN `label_type` SET TAGS ('dbx_business_glossary_term' = 'Label Type');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`labeling` ALTER COLUMN `label_type` SET TAGS ('dbx_value_regex' = 'USPI|SmPC|PIL|Carton|Container|IFU');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`labeling` ALTER COLUMN `label_version` SET TAGS ('dbx_business_glossary_term' = 'Label Version Number');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`labeling` ALTER COLUMN `label_version` SET TAGS ('dbx_value_regex' = '^[0-9]+.[0-9]+$');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`labeling` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`labeling` ALTER COLUMN `pregnancy_category` SET TAGS ('dbx_business_glossary_term' = 'Pregnancy Category (Legacy)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`labeling` ALTER COLUMN `pregnancy_category` SET TAGS ('dbx_value_regex' = 'A|B|C|D|X|Not Applicable');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`labeling` ALTER COLUMN `proprietary_name` SET TAGS ('dbx_business_glossary_term' = 'Proprietary (Brand) Name');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`labeling` ALTER COLUMN `regulatory_approval_number` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Number');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`labeling` ALTER COLUMN `rems_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Risk Evaluation and Mitigation Strategy (REMS) Required Flag');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`labeling` ALTER COLUMN `route_of_administration` SET TAGS ('dbx_business_glossary_term' = 'Route of Administration');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`labeling` ALTER COLUMN `rx_otc_status` SET TAGS ('dbx_business_glossary_term' = 'Prescription (Rx) or Over-The-Counter (OTC) Status');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`labeling` ALTER COLUMN `rx_otc_status` SET TAGS ('dbx_value_regex' = 'Rx|OTC|BTC');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`labeling` ALTER COLUMN `strength` SET TAGS ('dbx_business_glossary_term' = 'Drug Strength');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`labeling` ALTER COLUMN `use_in_specific_populations_text` SET TAGS ('dbx_business_glossary_term' = 'Use in Specific Populations Text');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`labeling` ALTER COLUMN `warnings_precautions_text` SET TAGS ('dbx_business_glossary_term' = 'Warnings and Precautions Text');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`product_change_control` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`product_change_control` SET TAGS ('dbx_subdomain' = 'regulatory_compliance');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`product_change_control` ALTER COLUMN `product_change_control_id` SET TAGS ('dbx_business_glossary_term' = 'Product Change Control ID');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`product_change_control` ALTER COLUMN `protocol_id` SET TAGS ('dbx_business_glossary_term' = 'Comparability Protocol ID');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`product_change_control` ALTER COLUMN `compliance_capa_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Capa Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`product_change_control` ALTER COLUMN `inspection_response_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Response Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`product_change_control` ALTER COLUMN `medicinal_product_id` SET TAGS ('dbx_business_glossary_term' = 'Product ID');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`product_change_control` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Site ID');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`product_change_control` ALTER COLUMN `affected_markets` SET TAGS ('dbx_business_glossary_term' = 'Affected Markets');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`product_change_control` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`product_change_control` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`product_change_control` ALTER COLUMN `change_category` SET TAGS ('dbx_business_glossary_term' = 'Change Category');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`product_change_control` ALTER COLUMN `change_control_number` SET TAGS ('dbx_business_glossary_term' = 'Change Control Number');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`product_change_control` ALTER COLUMN `change_control_number` SET TAGS ('dbx_value_regex' = '^CC-[0-9]{6,10}$');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`product_change_control` ALTER COLUMN `change_description` SET TAGS ('dbx_business_glossary_term' = 'Change Description');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`product_change_control` ALTER COLUMN `change_status` SET TAGS ('dbx_business_glossary_term' = 'Change Status');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`product_change_control` ALTER COLUMN `change_type` SET TAGS ('dbx_business_glossary_term' = 'Change Type');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`product_change_control` ALTER COLUMN `closure_date` SET TAGS ('dbx_business_glossary_term' = 'Closure Date');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`product_change_control` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`product_change_control` ALTER COLUMN `document_reference` SET TAGS ('dbx_business_glossary_term' = 'Document Reference');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`product_change_control` ALTER COLUMN `ectd_sequence_number` SET TAGS ('dbx_business_glossary_term' = 'Electronic Common Technical Document (eCTD) Sequence Number');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`product_change_control` ALTER COLUMN `ectd_sequence_number` SET TAGS ('dbx_value_regex' = '^[0-9]{4}$');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`product_change_control` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`product_change_control` ALTER COLUMN `efficacy_impact_level` SET TAGS ('dbx_business_glossary_term' = 'Efficacy Impact Level');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`product_change_control` ALTER COLUMN `efficacy_impact_level` SET TAGS ('dbx_value_regex' = 'None|Low|Medium|High|Critical');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`product_change_control` ALTER COLUMN `health_authority` SET TAGS ('dbx_business_glossary_term' = 'Health Authority');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`product_change_control` ALTER COLUMN `health_authority` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`product_change_control` ALTER COLUMN `health_authority` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`product_change_control` ALTER COLUMN `impact_assessment` SET TAGS ('dbx_business_glossary_term' = 'Impact Assessment');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`product_change_control` ALTER COLUMN `implementation_date` SET TAGS ('dbx_business_glossary_term' = 'Implementation Date');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`product_change_control` ALTER COLUMN `initiated_by` SET TAGS ('dbx_business_glossary_term' = 'Initiated By');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`product_change_control` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`product_change_control` ALTER COLUMN `notification_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Notification Required Flag');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`product_change_control` ALTER COLUMN `prior_approval_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Prior Approval Required Flag');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`product_change_control` ALTER COLUMN `quality_impact_level` SET TAGS ('dbx_business_glossary_term' = 'Quality Impact Level');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`product_change_control` ALTER COLUMN `quality_impact_level` SET TAGS ('dbx_value_regex' = 'None|Low|Medium|High|Critical');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`product_change_control` ALTER COLUMN `regulatory_commitment` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Commitment');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`product_change_control` ALTER COLUMN `safety_impact_level` SET TAGS ('dbx_business_glossary_term' = 'Safety Impact Level');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`product_change_control` ALTER COLUMN `safety_impact_level` SET TAGS ('dbx_value_regex' = 'None|Low|Medium|High|Critical');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`product_change_control` ALTER COLUMN `stability_study_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Stability Study Required Flag');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`product_change_control` ALTER COLUMN `submission_date` SET TAGS ('dbx_business_glossary_term' = 'Submission Date');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`product_change_control` ALTER COLUMN `submission_number` SET TAGS ('dbx_business_glossary_term' = 'Submission Number');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`product_change_control` ALTER COLUMN `validation_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Validation Required Flag');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`combination_product` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`combination_product` SET TAGS ('dbx_subdomain' = 'product_definition');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`combination_product` ALTER COLUMN `combination_product_id` SET TAGS ('dbx_business_glossary_term' = 'Combination Product Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`combination_product` ALTER COLUMN `atc_classification_id` SET TAGS ('dbx_business_glossary_term' = 'Atc Classification Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`combination_product` ALTER COLUMN `drug_product_id` SET TAGS ('dbx_business_glossary_term' = 'Drug Product Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`combination_product` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Mah Legal Entity Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`combination_product` ALTER COLUMN `masterdata_ndc_code_id` SET TAGS ('dbx_business_glossary_term' = 'Ndc Code Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`combination_product` ALTER COLUMN `patent_family_id` SET TAGS ('dbx_business_glossary_term' = 'Patent Family Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`combination_product` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Site Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`combination_product` ALTER COLUMN `therapeutic_area_id` SET TAGS ('dbx_business_glossary_term' = 'Therapeutic Area Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`combination_product` ALTER COLUMN `agreement_number` SET TAGS ('dbx_business_glossary_term' = 'Combination Product Agreement Number');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`combination_product` ALTER COLUMN `agreement_number` SET TAGS ('dbx_value_regex' = '^CPA-[0-9]{6,10}$');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`combination_product` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Date');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`combination_product` ALTER COLUMN `biologic_constituent_classification` SET TAGS ('dbx_business_glossary_term' = 'Biologic Constituent Regulatory Classification');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`combination_product` ALTER COLUMN `biologic_constituent_classification` SET TAGS ('dbx_value_regex' = 'BLA|IND|investigational|approved|biosimilar');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`combination_product` ALTER COLUMN `biologic_constituent_name` SET TAGS ('dbx_business_glossary_term' = 'Biologic Constituent Name');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`combination_product` ALTER COLUMN `cmc_documentation_reference` SET TAGS ('dbx_business_glossary_term' = 'Chemistry Manufacturing and Controls (CMC) Documentation Reference');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`combination_product` ALTER COLUMN `cmc_documentation_reference` SET TAGS ('dbx_value_regex' = '^CMC-[A-Z0-9]{6,12}$');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`combination_product` ALTER COLUMN `cmc_documentation_reference` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`combination_product` ALTER COLUMN `combination_product_code` SET TAGS ('dbx_business_glossary_term' = 'Combination Product Code');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`combination_product` ALTER COLUMN `combination_product_code` SET TAGS ('dbx_value_regex' = '^CP-[A-Z0-9]{8,12}$');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`combination_product` ALTER COLUMN `combination_type` SET TAGS ('dbx_business_glossary_term' = 'Combination Product Type');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`combination_product` ALTER COLUMN `combination_type` SET TAGS ('dbx_value_regex' = 'drug-device|drug-biologic|biologic-device|drug-drug-device|drug-biologic-device');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`combination_product` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`combination_product` ALTER COLUMN `cross_labeling_requirement_flag` SET TAGS ('dbx_business_glossary_term' = 'Cross-Labeling Requirement Flag');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`combination_product` ALTER COLUMN `device_constituent_classification` SET TAGS ('dbx_business_glossary_term' = 'Device Constituent Regulatory Classification');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`combination_product` ALTER COLUMN `device_constituent_classification` SET TAGS ('dbx_value_regex' = 'Class I|Class II|Class III|510k|PMA|De Novo');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`combination_product` ALTER COLUMN `device_constituent_name` SET TAGS ('dbx_business_glossary_term' = 'Device Constituent Name');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`combination_product` ALTER COLUMN `device_design_history_file_reference` SET TAGS ('dbx_business_glossary_term' = 'Device Design History File (DHF) Reference');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`combination_product` ALTER COLUMN `device_design_history_file_reference` SET TAGS ('dbx_value_regex' = '^DHF-[A-Z0-9]{6,12}$');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`combination_product` ALTER COLUMN `device_design_history_file_reference` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`combination_product` ALTER COLUMN `drug_constituent_classification` SET TAGS ('dbx_business_glossary_term' = 'Drug Constituent Regulatory Classification');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`combination_product` ALTER COLUMN `drug_constituent_classification` SET TAGS ('dbx_value_regex' = 'NDA|ANDA|BLA|IND|investigational|approved');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`combination_product` ALTER COLUMN `drug_constituent_name` SET TAGS ('dbx_business_glossary_term' = 'Drug Constituent Name');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`combination_product` ALTER COLUMN `drug_constituent_strength` SET TAGS ('dbx_business_glossary_term' = 'Drug Constituent Strength');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`combination_product` ALTER COLUMN `gmp_compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Good Manufacturing Practice (GMP) Compliance Status');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`combination_product` ALTER COLUMN `gmp_compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending_inspection|warning_letter|consent_decree');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`combination_product` ALTER COLUMN `human_factors_study_status` SET TAGS ('dbx_business_glossary_term' = 'Human Factors Study Status');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`combination_product` ALTER COLUMN `human_factors_study_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|completed|validated|submitted');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`combination_product` ALTER COLUMN `indication` SET TAGS ('dbx_business_glossary_term' = 'Approved Indication');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`combination_product` ALTER COLUMN `inn_name` SET TAGS ('dbx_business_glossary_term' = 'International Nonproprietary Name (INN)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`combination_product` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`combination_product` ALTER COLUMN `lead_center` SET TAGS ('dbx_business_glossary_term' = 'Lead Center Designation');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`combination_product` ALTER COLUMN `lead_center` SET TAGS ('dbx_value_regex' = 'CDER|CDRH|CBER');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`combination_product` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_business_glossary_term' = 'Product Lifecycle Status');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`combination_product` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_value_regex' = 'development|investigational|approved|marketed|discontinued|withdrawn');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`combination_product` ALTER COLUMN `primary_mode_of_action` SET TAGS ('dbx_business_glossary_term' = 'Primary Mode of Action (PMOA)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`combination_product` ALTER COLUMN `primary_mode_of_action` SET TAGS ('dbx_value_regex' = 'drug|device|biologic');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`combination_product` ALTER COLUMN `product_name` SET TAGS ('dbx_business_glossary_term' = 'Combination Product Name');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`combination_product` ALTER COLUMN `qbd_approach_flag` SET TAGS ('dbx_business_glossary_term' = 'Quality by Design (QbD) Approach Flag');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`combination_product` ALTER COLUMN `regulatory_submission_number` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Submission Number');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`combination_product` ALTER COLUMN `regulatory_submission_number` SET TAGS ('dbx_value_regex' = '^(NDA|BLA|PMA|510K)-[0-9]{6,9}$');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`combination_product` ALTER COLUMN `rems_requirement_flag` SET TAGS ('dbx_business_glossary_term' = 'Risk Evaluation and Mitigation Strategy (REMS) Requirement Flag');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`combination_product` ALTER COLUMN `rld_assignment_date` SET TAGS ('dbx_business_glossary_term' = 'Request for Lead Center Designation (RLD) Assignment Date');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`combination_product` ALTER COLUMN `shelf_life_months` SET TAGS ('dbx_business_glossary_term' = 'Shelf Life in Months');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`combination_product` ALTER COLUMN `storage_conditions` SET TAGS ('dbx_business_glossary_term' = 'Storage Conditions');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`combination_product` ALTER COLUMN `usan_name` SET TAGS ('dbx_business_glossary_term' = 'United States Adopted Name (USAN)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`therapeutic_area` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`therapeutic_area` SET TAGS ('dbx_subdomain' = 'regulatory_compliance');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`therapeutic_area` ALTER COLUMN `therapeutic_area_id` SET TAGS ('dbx_business_glossary_term' = 'Therapeutic Area Identifier');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`therapeutic_area` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`therapeutic_area` ALTER COLUMN `gxp_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Gxp Obligation Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`therapeutic_area` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Therapeutic Area Head Employee Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`therapeutic_area` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`therapeutic_area` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`therapeutic_area` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`therapeutic_area` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Org Unit Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`therapeutic_area` ALTER COLUMN `parent_therapeutic_area_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`therapeutic_area` ALTER COLUMN `accelerated_approval_pathway` SET TAGS ('dbx_business_glossary_term' = 'Accelerated Approval Pathway Eligible Flag');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`therapeutic_area` ALTER COLUMN `area_code` SET TAGS ('dbx_business_glossary_term' = 'Therapeutic Area Code');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`therapeutic_area` ALTER COLUMN `area_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,10}$');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`therapeutic_area` ALTER COLUMN `area_description` SET TAGS ('dbx_business_glossary_term' = 'Therapeutic Area Description');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`therapeutic_area` ALTER COLUMN `area_name` SET TAGS ('dbx_business_glossary_term' = 'Therapeutic Area Name');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`therapeutic_area` ALTER COLUMN `atc_level_1_code` SET TAGS ('dbx_business_glossary_term' = 'Anatomical Therapeutic Chemical (ATC) Level 1 Code');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`therapeutic_area` ALTER COLUMN `atc_level_1_code` SET TAGS ('dbx_value_regex' = '^[A-Z]$');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`therapeutic_area` ALTER COLUMN `atc_level_1_name` SET TAGS ('dbx_business_glossary_term' = 'Anatomical Therapeutic Chemical (ATC) Level 1 Name');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`therapeutic_area` ALTER COLUMN `breakthrough_therapy_eligible` SET TAGS ('dbx_business_glossary_term' = 'Breakthrough Therapy Designation Eligible Flag');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`therapeutic_area` ALTER COLUMN `business_unit_owner` SET TAGS ('dbx_business_glossary_term' = 'Business Unit Owner');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`therapeutic_area` ALTER COLUMN `clinical_trial_complexity_level` SET TAGS ('dbx_business_glossary_term' = 'Clinical Trial Complexity Level');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`therapeutic_area` ALTER COLUMN `clinical_trial_complexity_level` SET TAGS ('dbx_value_regex' = 'very_high|high|moderate|low');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`therapeutic_area` ALTER COLUMN `commercial_priority_level` SET TAGS ('dbx_business_glossary_term' = 'Commercial Priority Level');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`therapeutic_area` ALTER COLUMN `commercial_priority_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`therapeutic_area` ALTER COLUMN `controlled_substance_potential` SET TAGS ('dbx_business_glossary_term' = 'Controlled Substance Potential Flag');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`therapeutic_area` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`therapeutic_area` ALTER COLUMN `disease_category` SET TAGS ('dbx_business_glossary_term' = 'Disease Category');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`therapeutic_area` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`therapeutic_area` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`therapeutic_area` ALTER COLUMN `fast_track_eligible` SET TAGS ('dbx_business_glossary_term' = 'Fast Track Designation Eligible Flag');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`therapeutic_area` ALTER COLUMN `global_market_size_usd_millions` SET TAGS ('dbx_business_glossary_term' = 'Global Market Size in United States Dollars (USD) Millions');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`therapeutic_area` ALTER COLUMN `global_market_size_usd_millions` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`therapeutic_area` ALTER COLUMN `icd_10_chapter_code` SET TAGS ('dbx_business_glossary_term' = 'International Classification of Diseases 10th Revision (ICD-10) Chapter Code');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`therapeutic_area` ALTER COLUMN `icd_10_chapter_code` SET TAGS ('dbx_value_regex' = '^[A-Z][0-9]{2}$');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`therapeutic_area` ALTER COLUMN `icd_10_chapter_name` SET TAGS ('dbx_business_glossary_term' = 'International Classification of Diseases 10th Revision (ICD-10) Chapter Name');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`therapeutic_area` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Active Record Flag');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`therapeutic_area` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`therapeutic_area` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_business_glossary_term' = 'Lifecycle Status');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`therapeutic_area` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_value_regex' = 'active|emerging|mature|declining|discontinued');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`therapeutic_area` ALTER COLUMN `mechanism_of_action_category` SET TAGS ('dbx_business_glossary_term' = 'Mechanism of Action (MOA) Category');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`therapeutic_area` ALTER COLUMN `meddra_soc_code` SET TAGS ('dbx_business_glossary_term' = 'Medical Dictionary for Regulatory Activities (MedDRA) System Organ Class (SOC) Code');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`therapeutic_area` ALTER COLUMN `meddra_soc_code` SET TAGS ('dbx_value_regex' = '^[0-9]{8}$');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`therapeutic_area` ALTER COLUMN `meddra_soc_name` SET TAGS ('dbx_business_glossary_term' = 'Medical Dictionary for Regulatory Activities (MedDRA) System Organ Class (SOC) Name');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`therapeutic_area` ALTER COLUMN `orphan_designation_eligible` SET TAGS ('dbx_business_glossary_term' = 'Orphan Drug Designation Eligible Flag');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`therapeutic_area` ALTER COLUMN `patient_population_estimate` SET TAGS ('dbx_business_glossary_term' = 'Patient Population Estimate');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`therapeutic_area` ALTER COLUMN `pediatric_focus` SET TAGS ('dbx_business_glossary_term' = 'Pediatric Focus Flag');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`therapeutic_area` ALTER COLUMN `projected_cagr_percent` SET TAGS ('dbx_business_glossary_term' = 'Projected Compound Annual Growth Rate (CAGR) Percentage');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`therapeutic_area` ALTER COLUMN `projected_cagr_percent` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`therapeutic_area` ALTER COLUMN `regulatory_complexity_level` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Complexity Level');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`therapeutic_area` ALTER COLUMN `regulatory_complexity_level` SET TAGS ('dbx_value_regex' = 'very_high|high|moderate|low');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`therapeutic_area` ALTER COLUMN `rems_typically_required` SET TAGS ('dbx_business_glossary_term' = 'Risk Evaluation and Mitigation Strategy (REMS) Typically Required Flag');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`therapeutic_area` ALTER COLUMN `research_priority_level` SET TAGS ('dbx_business_glossary_term' = 'Research and Development (R&D) Priority Level');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`therapeutic_area` ALTER COLUMN `research_priority_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`therapeutic_area` ALTER COLUMN `strategic_franchise` SET TAGS ('dbx_business_glossary_term' = 'Strategic Franchise Flag');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`therapeutic_area` ALTER COLUMN `therapeutic_class` SET TAGS ('dbx_business_glossary_term' = 'Therapeutic Class');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`therapeutic_area` ALTER COLUMN `unmet_medical_need_level` SET TAGS ('dbx_business_glossary_term' = 'Unmet Medical Need Level');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`therapeutic_area` ALTER COLUMN `unmet_medical_need_level` SET TAGS ('dbx_value_regex' = 'critical|high|moderate|low');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`therapeutic_area` ALTER COLUMN `unmet_medical_need_level` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`therapeutic_area` ALTER COLUMN `unmet_medical_need_level` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`device_component` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`device_component` SET TAGS ('dbx_subdomain' = 'product_definition');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`device_component` ALTER COLUMN `device_component_id` SET TAGS ('dbx_business_glossary_term' = 'Device Component Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`device_component` ALTER COLUMN `combination_product_id` SET TAGS ('dbx_business_glossary_term' = 'Combination Product Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`device_component` ALTER COLUMN `part11_system_id` SET TAGS ('dbx_business_glossary_term' = 'Part11 System Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`device_component` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Site Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`device_component` ALTER COLUMN `business_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Business Partner Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`device_component` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`device_component` ALTER COLUMN `parent_device_component_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`device_component` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Date');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`device_component` ALTER COLUMN `biocompatibility_status` SET TAGS ('dbx_business_glossary_term' = 'Biocompatibility Testing Status');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`device_component` ALTER COLUMN `biocompatibility_status` SET TAGS ('dbx_value_regex' = 'not tested|testing in progress|compliant|non-compliant');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`device_component` ALTER COLUMN `change_control_number` SET TAGS ('dbx_business_glossary_term' = 'Change Control Number');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`device_component` ALTER COLUMN `change_control_number` SET TAGS ('dbx_value_regex' = '^CC-[A-Z0-9]{8,20}$');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`device_component` ALTER COLUMN `component_code` SET TAGS ('dbx_business_glossary_term' = 'Device Component Code');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`device_component` ALTER COLUMN `component_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`device_component` ALTER COLUMN `component_name` SET TAGS ('dbx_business_glossary_term' = 'Device Component Name');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`device_component` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`device_component` ALTER COLUMN `design_history_file_reference` SET TAGS ('dbx_business_glossary_term' = 'Design History File (DHF) Reference');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`device_component` ALTER COLUMN `design_history_file_reference` SET TAGS ('dbx_value_regex' = '^DHF-[A-Z0-9]{8,20}$');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`device_component` ALTER COLUMN `design_history_file_reference` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`device_component` ALTER COLUMN `device_class` SET TAGS ('dbx_business_glossary_term' = 'FDA Device Class');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`device_component` ALTER COLUMN `device_class` SET TAGS ('dbx_value_regex' = 'Class I|Class II|Class III');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`device_component` ALTER COLUMN `device_master_file_number` SET TAGS ('dbx_business_glossary_term' = 'Device Master File (DMF) Number');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`device_component` ALTER COLUMN `device_master_file_number` SET TAGS ('dbx_value_regex' = '^DMF-[0-9]{6,10}$');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`device_component` ALTER COLUMN `device_master_file_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`device_component` ALTER COLUMN `device_type` SET TAGS ('dbx_business_glossary_term' = 'Device Type Classification');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`device_component` ALTER COLUMN `device_type` SET TAGS ('dbx_value_regex' = 'auto-injector|prefilled syringe|inhaler|transdermal patch|implantable device|infusion pump');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`device_component` ALTER COLUMN `discontinuation_date` SET TAGS ('dbx_business_glossary_term' = 'Discontinuation Date');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`device_component` ALTER COLUMN `dose_accuracy_specification` SET TAGS ('dbx_business_glossary_term' = 'Dose Accuracy Specification');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`device_component` ALTER COLUMN `dose_delivery_mechanism` SET TAGS ('dbx_business_glossary_term' = 'Dose Delivery Mechanism Description');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`device_component` ALTER COLUMN `drawing_number` SET TAGS ('dbx_business_glossary_term' = 'Engineering Drawing Number');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`device_component` ALTER COLUMN `drawing_number` SET TAGS ('dbx_value_regex' = '^DWG-[A-Z0-9]{8,20}$');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`device_component` ALTER COLUMN `drawing_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`device_component` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`device_component` ALTER COLUMN `gmp_compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Good Manufacturing Practice (GMP) Compliance Status');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`device_component` ALTER COLUMN `gmp_compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non-compliant|under review');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`device_component` ALTER COLUMN `human_factors_study_reference` SET TAGS ('dbx_business_glossary_term' = 'Human Factors Study Reference');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`device_component` ALTER COLUMN `human_factors_study_reference` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`device_component` ALTER COLUMN `human_factors_validation_status` SET TAGS ('dbx_business_glossary_term' = 'Human Factors Validation Status');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`device_component` ALTER COLUMN `human_factors_validation_status` SET TAGS ('dbx_value_regex' = 'not started|in progress|completed|failed');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`device_component` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Active Record Indicator');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`device_component` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`device_component` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_business_glossary_term' = 'Device Component Lifecycle Status');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`device_component` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_value_regex' = 'development|design verification|design validation|approved|commercial|discontinued');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`device_component` ALTER COLUMN `material_composition` SET TAGS ('dbx_business_glossary_term' = 'Material Composition Description');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`device_component` ALTER COLUMN `needle_gauge` SET TAGS ('dbx_business_glossary_term' = 'Needle Gauge Size');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`device_component` ALTER COLUMN `needle_gauge` SET TAGS ('dbx_value_regex' = '^[0-9]{1,2}G$|not applicable');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`device_component` ALTER COLUMN `needle_length_mm` SET TAGS ('dbx_business_glossary_term' = 'Needle Length (Millimeters)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`device_component` ALTER COLUMN `nominal_dose_volume_ml` SET TAGS ('dbx_business_glossary_term' = 'Nominal Dose Volume (Milliliters)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`device_component` ALTER COLUMN `regulatory_approval_number` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Number');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`device_component` ALTER COLUMN `shelf_life_months` SET TAGS ('dbx_business_glossary_term' = 'Device Component Shelf Life (Months)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`device_component` ALTER COLUMN `specification_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Specification Document Reference');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`device_component` ALTER COLUMN `specification_document_reference` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`device_component` ALTER COLUMN `sterility_requirement` SET TAGS ('dbx_business_glossary_term' = 'Sterility Requirement');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`device_component` ALTER COLUMN `sterility_requirement` SET TAGS ('dbx_value_regex' = 'sterile|non-sterile');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`device_component` ALTER COLUMN `sterilization_method` SET TAGS ('dbx_business_glossary_term' = 'Sterilization Method');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`device_component` ALTER COLUMN `sterilization_method` SET TAGS ('dbx_value_regex' = 'ethylene oxide|gamma irradiation|steam autoclave|not applicable');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`device_component` ALTER COLUMN `storage_conditions` SET TAGS ('dbx_business_glossary_term' = 'Storage Conditions Specification');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`device_component` ALTER COLUMN `supplier_qualification_status` SET TAGS ('dbx_business_glossary_term' = 'Supplier Qualification Status');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`device_component` ALTER COLUMN `supplier_qualification_status` SET TAGS ('dbx_value_regex' = 'not qualified|qualification in progress|qualified|disqualified');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`device_component` ALTER COLUMN `use_error_risk_level` SET TAGS ('dbx_business_glossary_term' = 'Use Error Risk Level');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`device_component` ALTER COLUMN `use_error_risk_level` SET TAGS ('dbx_value_regex' = 'low|medium|high');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`excipient` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`excipient` SET TAGS ('dbx_subdomain' = 'product_definition');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`excipient` ALTER COLUMN `excipient_id` SET TAGS ('dbx_business_glossary_term' = 'Excipient Identifier');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`excipient` ALTER COLUMN `business_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Business Partner Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`excipient` ALTER COLUMN `material_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`excipient` ALTER COLUMN `parent_excipient_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`excipient` ALTER COLUMN `allergen_flag` SET TAGS ('dbx_business_glossary_term' = 'Allergen Flag');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`excipient` ALTER COLUMN `allergen_type` SET TAGS ('dbx_business_glossary_term' = 'Allergen Type');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`excipient` ALTER COLUMN `animal_derived_flag` SET TAGS ('dbx_business_glossary_term' = 'Animal-Derived Flag');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`excipient` ALTER COLUMN `cas_number` SET TAGS ('dbx_business_glossary_term' = 'Chemical Abstracts Service (CAS) Registry Number');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`excipient` ALTER COLUMN `cas_number` SET TAGS ('dbx_value_regex' = '^[1-9][0-9]{1,6}-[0-9]{2}-[0-9]$');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`excipient` ALTER COLUMN `change_control_number` SET TAGS ('dbx_business_glossary_term' = 'Change Control Number');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`excipient` ALTER COLUMN `chemical_name` SET TAGS ('dbx_business_glossary_term' = 'Chemical Name');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`excipient` ALTER COLUMN `coa_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Certificate of Analysis (CoA) Required Flag');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`excipient` ALTER COLUMN `compendial_grade` SET TAGS ('dbx_business_glossary_term' = 'Compendial Grade');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`excipient` ALTER COLUMN `compendial_grade` SET TAGS ('dbx_value_regex' = 'usp|ep|jp|bp|usp_nf|in_house');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`excipient` ALTER COLUMN `compendial_monograph` SET TAGS ('dbx_business_glossary_term' = 'Compendial Monograph Reference');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`excipient` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`excipient` ALTER COLUMN `dmf_number` SET TAGS ('dbx_business_glossary_term' = 'Drug Master File (DMF) Number');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`excipient` ALTER COLUMN `dmf_type` SET TAGS ('dbx_business_glossary_term' = 'Drug Master File (DMF) Type');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`excipient` ALTER COLUMN `dmf_type` SET TAGS ('dbx_value_regex' = 'type_i|type_ii|type_iii|type_iv|type_v|not_applicable');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`excipient` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`excipient` ALTER COLUMN `excipient_code` SET TAGS ('dbx_business_glossary_term' = 'Excipient Code');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`excipient` ALTER COLUMN `excipient_name` SET TAGS ('dbx_business_glossary_term' = 'Excipient Name');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`excipient` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`excipient` ALTER COLUMN `functional_category` SET TAGS ('dbx_business_glossary_term' = 'Functional Category');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`excipient` ALTER COLUMN `functional_category` SET TAGS ('dbx_value_regex' = 'binder|disintegrant|lubricant|glidant|diluent|coating_agent');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`excipient` ALTER COLUMN `gmo_status` SET TAGS ('dbx_business_glossary_term' = 'Genetically Modified Organism (GMO) Status');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`excipient` ALTER COLUMN `gmo_status` SET TAGS ('dbx_value_regex' = 'gmo_free|contains_gmo|not_tested|unknown');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`excipient` ALTER COLUMN `gmp_compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Good Manufacturing Practice (GMP) Compliance Status');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`excipient` ALTER COLUMN `gmp_compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|under_review|not_assessed');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`excipient` ALTER COLUMN `halal_certified_flag` SET TAGS ('dbx_business_glossary_term' = 'Halal Certified Flag');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`excipient` ALTER COLUMN `inn_name` SET TAGS ('dbx_business_glossary_term' = 'International Nonproprietary Name (INN)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`excipient` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active Flag');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`excipient` ALTER COLUMN `kosher_certified_flag` SET TAGS ('dbx_business_glossary_term' = 'Kosher Certified Flag');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`excipient` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`excipient` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_business_glossary_term' = 'Lifecycle Status');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`excipient` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_value_regex' = 'active|under_qualification|obsolete|discontinued|restricted_use');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`excipient` ALTER COLUMN `molecular_formula` SET TAGS ('dbx_business_glossary_term' = 'Molecular Formula');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`excipient` ALTER COLUMN `molecular_weight` SET TAGS ('dbx_business_glossary_term' = 'Molecular Weight');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`excipient` ALTER COLUMN `particle_size_specification` SET TAGS ('dbx_business_glossary_term' = 'Particle Size Specification');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`excipient` ALTER COLUMN `physical_form` SET TAGS ('dbx_business_glossary_term' = 'Physical Form');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`excipient` ALTER COLUMN `regulatory_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Status');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`excipient` ALTER COLUMN `regulatory_status` SET TAGS ('dbx_value_regex' = 'approved|under_review|restricted|banned|not_submitted');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`excipient` ALTER COLUMN `retest_period_months` SET TAGS ('dbx_business_glossary_term' = 'Retest Period in Months');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`excipient` ALTER COLUMN `solubility_profile` SET TAGS ('dbx_business_glossary_term' = 'Solubility Profile');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`excipient` ALTER COLUMN `specification_reference` SET TAGS ('dbx_business_glossary_term' = 'Specification Reference');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`excipient` ALTER COLUMN `stability_profile` SET TAGS ('dbx_business_glossary_term' = 'Stability Profile');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`excipient` ALTER COLUMN `storage_conditions` SET TAGS ('dbx_business_glossary_term' = 'Storage Conditions');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`bioequivalence_study` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`bioequivalence_study` SET TAGS ('dbx_subdomain' = 'regulatory_compliance');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`bioequivalence_study` ALTER COLUMN `bioequivalence_study_id` SET TAGS ('dbx_business_glossary_term' = 'Bioequivalence Study Identifier');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`bioequivalence_study` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Cro Vendor Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`bioequivalence_study` ALTER COLUMN `dossier_document_id` SET TAGS ('dbx_business_glossary_term' = 'Study Report Document Identifier');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`bioequivalence_study` ALTER COLUMN `internal_order_id` SET TAGS ('dbx_business_glossary_term' = 'Internal Order Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`bioequivalence_study` ALTER COLUMN `patent_id` SET TAGS ('dbx_business_glossary_term' = 'Patent Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`bioequivalence_study` ALTER COLUMN `drug_product_id` SET TAGS ('dbx_business_glossary_term' = 'Test Product Identifier');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`bioequivalence_study` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Principal Investigator Employee Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`bioequivalence_study` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`bioequivalence_study` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`bioequivalence_study` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Program Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`bioequivalence_study` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Sponsor Legal Entity Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`bioequivalence_study` ALTER COLUMN `country_id` SET TAGS ('dbx_business_glossary_term' = 'Study Country Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`bioequivalence_study` ALTER COLUMN `therapeutic_area_id` SET TAGS ('dbx_business_glossary_term' = 'Therapeutic Area Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`bioequivalence_study` ALTER COLUMN `unit_of_measure_id` SET TAGS ('dbx_business_glossary_term' = 'Pk Parameter Uom Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`bioequivalence_study` ALTER COLUMN `reference_bioequivalence_study_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`bioequivalence_study` ALTER COLUMN `acceptance_criteria` SET TAGS ('dbx_business_glossary_term' = 'Acceptance Criteria');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`bioequivalence_study` ALTER COLUMN `api_name` SET TAGS ('dbx_business_glossary_term' = 'Active Pharmaceutical Ingredient (API) Name');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`bioequivalence_study` ALTER COLUMN `atc_code` SET TAGS ('dbx_business_glossary_term' = 'Anatomical Therapeutic Chemical (ATC) Code');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`bioequivalence_study` ALTER COLUMN `auc_90_ci_lower` SET TAGS ('dbx_business_glossary_term' = 'Area Under the Curve (AUC) 90% Confidence Interval Lower Bound');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`bioequivalence_study` ALTER COLUMN `auc_90_ci_upper` SET TAGS ('dbx_business_glossary_term' = 'Area Under the Curve (AUC) 90% Confidence Interval Upper Bound');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`bioequivalence_study` ALTER COLUMN `bioanalytical_matrix` SET TAGS ('dbx_business_glossary_term' = 'Bioanalytical Matrix');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`bioequivalence_study` ALTER COLUMN `bioanalytical_matrix` SET TAGS ('dbx_value_regex' = 'plasma|serum|whole_blood|urine|saliva');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`bioequivalence_study` ALTER COLUMN `bioanalytical_method` SET TAGS ('dbx_business_glossary_term' = 'Bioanalytical Method');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`bioequivalence_study` ALTER COLUMN `bioequivalence_conclusion` SET TAGS ('dbx_business_glossary_term' = 'Bioequivalence Conclusion');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`bioequivalence_study` ALTER COLUMN `bioequivalence_conclusion` SET TAGS ('dbx_value_regex' = 'bioequivalent|not_bioequivalent|inconclusive');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`bioequivalence_study` ALTER COLUMN `cmax_90_ci_lower` SET TAGS ('dbx_business_glossary_term' = 'Cmax 90% Confidence Interval Lower Bound');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`bioequivalence_study` ALTER COLUMN `cmax_90_ci_upper` SET TAGS ('dbx_business_glossary_term' = 'Cmax 90% Confidence Interval Upper Bound');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`bioequivalence_study` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`bioequivalence_study` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`bioequivalence_study` ALTER COLUMN `dosage_form` SET TAGS ('dbx_business_glossary_term' = 'Dosage Form');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`bioequivalence_study` ALTER COLUMN `ectd_module_reference` SET TAGS ('dbx_business_glossary_term' = 'Electronic Common Technical Document (eCTD) Module Reference');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`bioequivalence_study` ALTER COLUMN `fasting_fed_condition` SET TAGS ('dbx_business_glossary_term' = 'Fasting or Fed Condition');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`bioequivalence_study` ALTER COLUMN `fasting_fed_condition` SET TAGS ('dbx_value_regex' = 'fasting|fed|both');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`bioequivalence_study` ALTER COLUMN `gcp_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Good Clinical Practice (GCP) Compliance Flag');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`bioequivalence_study` ALTER COLUMN `glp_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Good Laboratory Practice (GLP) Compliance Flag');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`bioequivalence_study` ALTER COLUMN `irb_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Institutional Review Board (IRB) Approval Date');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`bioequivalence_study` ALTER COLUMN `irb_approval_number` SET TAGS ('dbx_business_glossary_term' = 'Institutional Review Board (IRB) Approval Number');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`bioequivalence_study` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`bioequivalence_study` ALTER COLUMN `pk_parameter_auc_ratio` SET TAGS ('dbx_business_glossary_term' = 'Pharmacokinetic (PK) Parameter Area Under the Curve (AUC) Ratio');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`bioequivalence_study` ALTER COLUMN `pk_parameter_cmax_ratio` SET TAGS ('dbx_business_glossary_term' = 'Pharmacokinetic (PK) Parameter Cmax Ratio');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`bioequivalence_study` ALTER COLUMN `reference_product_formulation_code` SET TAGS ('dbx_business_glossary_term' = 'Reference Product Formulation Code');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`bioequivalence_study` ALTER COLUMN `reference_product_strength` SET TAGS ('dbx_business_glossary_term' = 'Reference Product Strength');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`bioequivalence_study` ALTER COLUMN `regulatory_submission_number` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Submission Number');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`bioequivalence_study` ALTER COLUMN `report_date` SET TAGS ('dbx_business_glossary_term' = 'Study Report Date');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`bioequivalence_study` ALTER COLUMN `route_of_administration` SET TAGS ('dbx_business_glossary_term' = 'Route of Administration');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`bioequivalence_study` ALTER COLUMN `study_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Study Completion Date');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`bioequivalence_study` ALTER COLUMN `study_design` SET TAGS ('dbx_business_glossary_term' = 'Study Design');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`bioequivalence_study` ALTER COLUMN `study_design` SET TAGS ('dbx_value_regex' = 'crossover|parallel|replicate|partial_replicate|single_dose|multiple_dose');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`bioequivalence_study` ALTER COLUMN `study_phase` SET TAGS ('dbx_business_glossary_term' = 'Study Phase');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`bioequivalence_study` ALTER COLUMN `study_phase` SET TAGS ('dbx_value_regex' = 'phase_1|phase_2|phase_3|phase_4|post_approval');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`bioequivalence_study` ALTER COLUMN `study_population` SET TAGS ('dbx_business_glossary_term' = 'Study Population');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`bioequivalence_study` ALTER COLUMN `study_population` SET TAGS ('dbx_value_regex' = 'healthy_volunteers|patients|special_population');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`bioequivalence_study` ALTER COLUMN `study_protocol_number` SET TAGS ('dbx_business_glossary_term' = 'Study Protocol Number');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`bioequivalence_study` ALTER COLUMN `study_site_name` SET TAGS ('dbx_business_glossary_term' = 'Study Site Name');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`bioequivalence_study` ALTER COLUMN `study_site_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`bioequivalence_study` ALTER COLUMN `study_start_date` SET TAGS ('dbx_business_glossary_term' = 'Study Start Date');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`bioequivalence_study` ALTER COLUMN `study_status` SET TAGS ('dbx_business_glossary_term' = 'Study Status');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`bioequivalence_study` ALTER COLUMN `study_title` SET TAGS ('dbx_business_glossary_term' = 'Study Title');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`bioequivalence_study` ALTER COLUMN `study_type` SET TAGS ('dbx_business_glossary_term' = 'Study Type');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`bioequivalence_study` ALTER COLUMN `study_type` SET TAGS ('dbx_value_regex' = 'bioequivalence|bioavailability|food_effect|drug_drug_interaction|comparative_bioavailability|relative_bioavailability');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`bioequivalence_study` ALTER COLUMN `subject_count_completed` SET TAGS ('dbx_business_glossary_term' = 'Completed Subject Count');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`bioequivalence_study` ALTER COLUMN `subject_count_enrolled` SET TAGS ('dbx_business_glossary_term' = 'Enrolled Subject Count');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`bioequivalence_study` ALTER COLUMN `subject_count_planned` SET TAGS ('dbx_business_glossary_term' = 'Planned Subject Count');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`bioequivalence_study` ALTER COLUMN `submission_type` SET TAGS ('dbx_business_glossary_term' = 'Submission Type');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`bioequivalence_study` ALTER COLUMN `submission_type` SET TAGS ('dbx_value_regex' = 'anda|nda|bla|maa|ind|other');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`bioequivalence_study` ALTER COLUMN `test_product_formulation_code` SET TAGS ('dbx_business_glossary_term' = 'Test Product Formulation Code');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`bioequivalence_study` ALTER COLUMN `test_product_strength` SET TAGS ('dbx_business_glossary_term' = 'Test Product Strength');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`pharmaceutical_product` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`pharmaceutical_product` SET TAGS ('dbx_subdomain' = 'product_definition');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`pharmaceutical_product` ALTER COLUMN `pharmaceutical_product_id` SET TAGS ('dbx_business_glossary_term' = 'Pharmaceutical Product Identifier');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`pharmaceutical_product` ALTER COLUMN `drug_product_id` SET TAGS ('dbx_business_glossary_term' = 'Drug Product (DP) Identifier');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`pharmaceutical_product` ALTER COLUMN `inn_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Inn Registry Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`pharmaceutical_product` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Plant Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`pharmaceutical_product` ALTER COLUMN `medicinal_product_id` SET TAGS ('dbx_business_glossary_term' = 'Biosimilar Reference Product Identifier');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`pharmaceutical_product` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Site Identifier');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`pharmaceutical_product` ALTER COLUMN `specified_substance_id` SET TAGS ('dbx_business_glossary_term' = 'Ingredient Substance Identifier');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`pharmaceutical_product` ALTER COLUMN `unit_of_measure_id` SET TAGS ('dbx_business_glossary_term' = 'Concentration Uom Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`pharmaceutical_product` ALTER COLUMN `parent_pharmaceutical_product_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`pharmaceutical_product` ALTER COLUMN `administrable_dose_form` SET TAGS ('dbx_business_glossary_term' = 'Administrable Dose Form');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`pharmaceutical_product` ALTER COLUMN `administration_device` SET TAGS ('dbx_business_glossary_term' = 'Administration Device');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`pharmaceutical_product` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Date');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`pharmaceutical_product` ALTER COLUMN `atc_code` SET TAGS ('dbx_business_glossary_term' = 'Anatomical Therapeutic Chemical (ATC) Classification Code');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`pharmaceutical_product` ALTER COLUMN `atc_code` SET TAGS ('dbx_value_regex' = '^[A-Z][0-9]{2}[A-Z]{2}[0-9]{2}$');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`pharmaceutical_product` ALTER COLUMN `black_box_warning_flag` SET TAGS ('dbx_business_glossary_term' = 'Black Box Warning Flag');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`pharmaceutical_product` ALTER COLUMN `cold_chain_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Cold Chain Required Flag');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`pharmaceutical_product` ALTER COLUMN `concentration_value` SET TAGS ('dbx_business_glossary_term' = 'Concentration Value');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`pharmaceutical_product` ALTER COLUMN `controlled_substance_schedule` SET TAGS ('dbx_business_glossary_term' = 'Controlled Substance Schedule');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`pharmaceutical_product` ALTER COLUMN `controlled_substance_schedule` SET TAGS ('dbx_value_regex' = 'Schedule I|Schedule II|Schedule III|Schedule IV|Schedule V|Not Controlled');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`pharmaceutical_product` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`pharmaceutical_product` ALTER COLUMN `dosing_instructions` SET TAGS ('dbx_business_glossary_term' = 'Dosing Instructions');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`pharmaceutical_product` ALTER COLUMN `gmp_compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Good Manufacturing Practice (GMP) Compliance Status');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`pharmaceutical_product` ALTER COLUMN `gmp_compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|under_inspection|pending_certification');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`pharmaceutical_product` ALTER COLUMN `indication_summary` SET TAGS ('dbx_business_glossary_term' = 'Indication Summary');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`pharmaceutical_product` ALTER COLUMN `interchangeability_status` SET TAGS ('dbx_business_glossary_term' = 'Interchangeability Status');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`pharmaceutical_product` ALTER COLUMN `interchangeability_status` SET TAGS ('dbx_value_regex' = 'interchangeable|biosimilar|reference|not_applicable');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`pharmaceutical_product` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Active Record Flag');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`pharmaceutical_product` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`pharmaceutical_product` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_business_glossary_term' = 'Product Lifecycle Status');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`pharmaceutical_product` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_value_regex' = 'approved|marketed|withdrawn|suspended|under_review');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`pharmaceutical_product` ALTER COLUMN `marketing_authorization_holder` SET TAGS ('dbx_business_glossary_term' = 'Marketing Authorization Holder (MAH)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`pharmaceutical_product` ALTER COLUMN `pharmacopoeial_standard` SET TAGS ('dbx_business_glossary_term' = 'Pharmacopoeial Standard');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`pharmaceutical_product` ALTER COLUMN `phpid_code` SET TAGS ('dbx_business_glossary_term' = 'Pharmaceutical Product Identifier (PhPID) Code');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`pharmaceutical_product` ALTER COLUMN `phpid_code` SET TAGS ('dbx_value_regex' = '^PHPID-[A-Z0-9]{8,12}$');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`pharmaceutical_product` ALTER COLUMN `preparation_instructions` SET TAGS ('dbx_business_glossary_term' = 'Preparation Instructions');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`pharmaceutical_product` ALTER COLUMN `preservative_free_flag` SET TAGS ('dbx_business_glossary_term' = 'Preservative-Free Flag');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`pharmaceutical_product` ALTER COLUMN `product_name` SET TAGS ('dbx_business_glossary_term' = 'Pharmaceutical Product Name');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`pharmaceutical_product` ALTER COLUMN `regulatory_approval_number` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Number');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`pharmaceutical_product` ALTER COLUMN `rems_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Risk Evaluation and Mitigation Strategy (REMS) Required Flag');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`pharmaceutical_product` ALTER COLUMN `route_of_administration` SET TAGS ('dbx_business_glossary_term' = 'Route of Administration (ROA)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`pharmaceutical_product` ALTER COLUMN `shelf_life_after_preparation_hours` SET TAGS ('dbx_business_glossary_term' = 'Shelf Life After Preparation in Hours');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`pharmaceutical_product` ALTER COLUMN `sterility_requirement` SET TAGS ('dbx_business_glossary_term' = 'Sterility Requirement');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`pharmaceutical_product` ALTER COLUMN `sterility_requirement` SET TAGS ('dbx_value_regex' = 'sterile|non-sterile|aseptic');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`pharmaceutical_product` ALTER COLUMN `storage_conditions` SET TAGS ('dbx_business_glossary_term' = 'Storage Conditions');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`pharmaceutical_product` ALTER COLUMN `target_patient_population` SET TAGS ('dbx_business_glossary_term' = 'Target Patient Population');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`pharmaceutical_product` ALTER COLUMN `therapeutic_area` SET TAGS ('dbx_business_glossary_term' = 'Therapeutic Area');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`pharmaceutical_product` ALTER COLUMN `total_volume_ml` SET TAGS ('dbx_business_glossary_term' = 'Total Volume in Milliliters (mL)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`pharmaceutical_product` ALTER COLUMN `unit_of_presentation` SET TAGS ('dbx_business_glossary_term' = 'Unit of Presentation');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`specified_substance` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`specified_substance` SET TAGS ('dbx_subdomain' = 'product_definition');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`specified_substance` ALTER COLUMN `specified_substance_id` SET TAGS ('dbx_business_glossary_term' = 'Specified Substance Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`specified_substance` ALTER COLUMN `formulation_ingredient_id` SET TAGS ('dbx_business_glossary_term' = 'Formulation Ingredient Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`specified_substance` ALTER COLUMN `drug_substance_id` SET TAGS ('dbx_business_glossary_term' = 'Global Substance Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`specified_substance` ALTER COLUMN `unit_of_measure_id` SET TAGS ('dbx_business_glossary_term' = 'Strength Uom Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`specified_substance` ALTER COLUMN `parent_specified_substance_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`specified_substance` ALTER COLUMN `change_control_number` SET TAGS ('dbx_business_glossary_term' = 'Change Control Number');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`specified_substance` ALTER COLUMN `concentration_unit` SET TAGS ('dbx_business_glossary_term' = 'Concentration Unit of Measure (UOM)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`specified_substance` ALTER COLUMN `concentration_value` SET TAGS ('dbx_business_glossary_term' = 'Concentration Value');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`specified_substance` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`specified_substance` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`specified_substance` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`specified_substance` ALTER COLUMN `grade` SET TAGS ('dbx_business_glossary_term' = 'Substance Grade');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`specified_substance` ALTER COLUMN `idmp_substance_code` SET TAGS ('dbx_business_glossary_term' = 'IDMP Substance Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`specified_substance` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active Flag');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`specified_substance` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`specified_substance` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_business_glossary_term' = 'Lifecycle Status');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`specified_substance` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_value_regex' = 'active|inactive|obsolete|under_review');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`specified_substance` ALTER COLUMN `manufacturer_substance_code` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Substance Code');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`specified_substance` ALTER COLUMN `manufacturer_substance_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`specified_substance` ALTER COLUMN `molecular_formula` SET TAGS ('dbx_business_glossary_term' = 'Molecular Formula');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`specified_substance` ALTER COLUMN `molecular_weight` SET TAGS ('dbx_business_glossary_term' = 'Molecular Weight');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`specified_substance` ALTER COLUMN `optical_activity` SET TAGS ('dbx_business_glossary_term' = 'Optical Activity');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`specified_substance` ALTER COLUMN `polymorphic_form` SET TAGS ('dbx_business_glossary_term' = 'Polymorphic Form');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`specified_substance` ALTER COLUMN `purity_percentage` SET TAGS ('dbx_business_glossary_term' = 'Purity Percentage');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`specified_substance` ALTER COLUMN `reference_strength_unit` SET TAGS ('dbx_business_glossary_term' = 'Reference Strength Unit of Measure (UOM)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`specified_substance` ALTER COLUMN `reference_strength_value` SET TAGS ('dbx_business_glossary_term' = 'Reference Strength Value');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`specified_substance` ALTER COLUMN `regulatory_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Status');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`specified_substance` ALTER COLUMN `regulatory_status` SET TAGS ('dbx_value_regex' = 'approved|investigational|withdrawn|pending');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`specified_substance` ALTER COLUMN `salt_form` SET TAGS ('dbx_business_glossary_term' = 'Salt Form');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`specified_substance` ALTER COLUMN `solvate_type` SET TAGS ('dbx_business_glossary_term' = 'Solvate Type');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`specified_substance` ALTER COLUMN `specification_level` SET TAGS ('dbx_business_glossary_term' = 'Specification Level');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`specified_substance` ALTER COLUMN `specification_level` SET TAGS ('dbx_value_regex' = 'molecular|salt|solvate|hydrate|polymorph|mixture');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`specified_substance` ALTER COLUMN `specification_reference` SET TAGS ('dbx_business_glossary_term' = 'Specification Reference');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`specified_substance` ALTER COLUMN `stoichiometry` SET TAGS ('dbx_business_glossary_term' = 'Stoichiometry');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`specified_substance` ALTER COLUMN `strength_value` SET TAGS ('dbx_business_glossary_term' = 'Strength Value');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`specified_substance` ALTER COLUMN `substance_code` SET TAGS ('dbx_business_glossary_term' = 'Substance Code');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`specified_substance` ALTER COLUMN `substance_name` SET TAGS ('dbx_business_glossary_term' = 'Substance Name');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`specified_substance` ALTER COLUMN `substance_role` SET TAGS ('dbx_business_glossary_term' = 'Substance Role');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`specified_substance` ALTER COLUMN `substance_role` SET TAGS ('dbx_value_regex' = 'active|excipient|adjuvant|preservative|solvent|stabilizer');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`specified_substance` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`prescription` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`prescription` SET TAGS ('dbx_subdomain' = 'commercial_operations');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`prescription` SET TAGS ('dbx_association_edges' = 'product.medicinal_product,patient.patient');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`prescription` ALTER COLUMN `prescription_id` SET TAGS ('dbx_business_glossary_term' = 'Prescription Identifier');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`prescription` ALTER COLUMN `prescription_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`prescription` ALTER COLUMN `prescription_id` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`prescription` ALTER COLUMN `master_id` SET TAGS ('dbx_business_glossary_term' = 'Prescribing Physician Identifier');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`prescription` ALTER COLUMN `medicinal_product_id` SET TAGS ('dbx_business_glossary_term' = 'Prescription - Medicinal Product Id');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`prescription` ALTER COLUMN `patient_id` SET TAGS ('dbx_business_glossary_term' = 'Prescription - Participant Id');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`prescription` ALTER COLUMN `adherence_score` SET TAGS ('dbx_business_glossary_term' = 'Medication Adherence Score');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`prescription` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`prescription` ALTER COLUMN `discontinuation_reason` SET TAGS ('dbx_business_glossary_term' = 'Prescription Discontinuation Reason');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`prescription` ALTER COLUMN `dosage_instructions` SET TAGS ('dbx_business_glossary_term' = 'Dosage Instructions');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`prescription` ALTER COLUMN `dosage_instructions` SET TAGS ('dbx_phi' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`prescription` ALTER COLUMN `prescription_date` SET TAGS ('dbx_business_glossary_term' = 'Prescription Date');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`prescription` ALTER COLUMN `prescription_date` SET TAGS ('dbx_phi' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`prescription` ALTER COLUMN `prescription_date` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`prescription` ALTER COLUMN `prescription_date` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`prescription` ALTER COLUMN `prescription_status` SET TAGS ('dbx_business_glossary_term' = 'Prescription Status');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`prescription` ALTER COLUMN `prescription_status` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`prescription` ALTER COLUMN `prescription_status` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`prescription` ALTER COLUMN `prior_authorization_required` SET TAGS ('dbx_business_glossary_term' = 'Prior Authorization Required');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`prescription` ALTER COLUMN `refill_count` SET TAGS ('dbx_business_glossary_term' = 'Refill Count');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`prescription` ALTER COLUMN `specialty_pharmacy_flag` SET TAGS ('dbx_business_glossary_term' = 'Specialty Pharmacy Indicator');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`prescription` ALTER COLUMN `therapy_end_date` SET TAGS ('dbx_business_glossary_term' = 'Therapy End Date');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`prescription` ALTER COLUMN `therapy_end_date` SET TAGS ('dbx_phi' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`prescription` ALTER COLUMN `therapy_start_date` SET TAGS ('dbx_business_glossary_term' = 'Therapy Start Date');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`prescription` ALTER COLUMN `therapy_start_date` SET TAGS ('dbx_phi' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`prescription` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`formulary_listing` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`formulary_listing` SET TAGS ('dbx_subdomain' = 'commercial_operations');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`formulary_listing` SET TAGS ('dbx_association_edges' = 'product.drug_product,market.payer_account');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`formulary_listing` ALTER COLUMN `formulary_listing_id` SET TAGS ('dbx_business_glossary_term' = 'Formulary Listing Identifier');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`formulary_listing` ALTER COLUMN `drug_product_id` SET TAGS ('dbx_business_glossary_term' = 'Formulary Listing - Drug Product Id');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`formulary_listing` ALTER COLUMN `payer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Formulary Listing - Payer Account Id');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`formulary_listing` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Coverage Effective Date');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`formulary_listing` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Coverage End Date');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`formulary_listing` ALTER COLUMN `formulary_status` SET TAGS ('dbx_business_glossary_term' = 'Formulary Status');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`formulary_listing` ALTER COLUMN `formulary_tier` SET TAGS ('dbx_business_glossary_term' = 'Formulary Tier');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`formulary_listing` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last P&T Review Date');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`formulary_listing` ALTER COLUMN `listing_source` SET TAGS ('dbx_business_glossary_term' = 'Listing Source');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`formulary_listing` ALTER COLUMN `medical_policy_reference` SET TAGS ('dbx_business_glossary_term' = 'Medical Policy Reference');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`formulary_listing` ALTER COLUMN `medical_policy_reference` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`formulary_listing` ALTER COLUMN `medical_policy_reference` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`formulary_listing` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next P&T Review Date');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`formulary_listing` ALTER COLUMN `prior_authorization_required` SET TAGS ('dbx_business_glossary_term' = 'Prior Authorization Required');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`formulary_listing` ALTER COLUMN `quantity_limit` SET TAGS ('dbx_business_glossary_term' = 'Quantity Limit');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`formulary_listing` ALTER COLUMN `rebate_percentage` SET TAGS ('dbx_business_glossary_term' = 'Rebate Percentage');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`formulary_listing` ALTER COLUMN `rebate_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`formulary_listing` ALTER COLUMN `step_therapy_required` SET TAGS ('dbx_business_glossary_term' = 'Step Therapy Required');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`approved_vendor` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`approved_vendor` SET TAGS ('dbx_subdomain' = 'commercial_operations');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`approved_vendor` SET TAGS ('dbx_association_edges' = 'product.excipient,procurement.vendor');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`approved_vendor` ALTER COLUMN `approved_vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Approved Vendor - Approved Vendor Id');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`approved_vendor` ALTER COLUMN `excipient_id` SET TAGS ('dbx_business_glossary_term' = 'Approved Vendor - Excipient Id');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`approved_vendor` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Approved Vendor - Vendor Id');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`approved_vendor` ALTER COLUMN `active_flag` SET TAGS ('dbx_business_glossary_term' = 'Active Approval Flag');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`approved_vendor` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Vendor Approval Date');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`approved_vendor` ALTER COLUMN `gmp_compliance_status` SET TAGS ('dbx_business_glossary_term' = 'GMP Compliance Status');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`approved_vendor` ALTER COLUMN `gmp_compliance_status` SET TAGS ('dbx_regulatory_critical' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`approved_vendor` ALTER COLUMN `inactivation_date` SET TAGS ('dbx_business_glossary_term' = 'Inactivation Date');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`approved_vendor` ALTER COLUMN `inactivation_reason` SET TAGS ('dbx_business_glossary_term' = 'Inactivation Reason');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`approved_vendor` ALTER COLUMN `last_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Last Audit Date');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`approved_vendor` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time in Days');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`approved_vendor` ALTER COLUMN `minimum_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`approved_vendor` ALTER COLUMN `next_audit_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Audit Due Date');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`approved_vendor` ALTER COLUMN `preferred_vendor_flag` SET TAGS ('dbx_business_glossary_term' = 'Preferred Vendor Flag');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`approved_vendor` ALTER COLUMN `price_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Price Currency Code');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`approved_vendor` ALTER COLUMN `qualification_status` SET TAGS ('dbx_business_glossary_term' = 'Vendor Qualification Status');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`approved_vendor` ALTER COLUMN `qualification_status` SET TAGS ('dbx_quality_critical' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`approved_vendor` ALTER COLUMN `quality_agreement_reference` SET TAGS ('dbx_business_glossary_term' = 'Quality Agreement Reference Number');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`approved_vendor` ALTER COLUMN `risk_classification` SET TAGS ('dbx_business_glossary_term' = 'Supply Risk Classification');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`approved_vendor` ALTER COLUMN `standard_unit_price` SET TAGS ('dbx_business_glossary_term' = 'Standard Unit Price');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`approved_vendor` ALTER COLUMN `standard_unit_price` SET TAGS ('dbx_commercially_sensitive' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`approved_vendor` ALTER COLUMN `supplier_qualification_status` SET TAGS ('dbx_business_glossary_term' = 'Supplier Qualification Status');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`approved_vendor` ALTER COLUMN `supplier_qualification_status` SET TAGS ('dbx_value_regex' = 'qualified|conditionally_qualified|under_qualification|disqualified|suspended');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`approved_vendor` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`product_payer_contract` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`product_payer_contract` SET TAGS ('dbx_subdomain' = 'commercial_operations');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`product_payer_contract` SET TAGS ('dbx_association_edges' = 'product.medicinal_product,market.payer_account');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`product_payer_contract` ALTER COLUMN `product_payer_contract_id` SET TAGS ('dbx_business_glossary_term' = 'product_payer_contract Identifier');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`product_payer_contract` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Owner Employee ID');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`product_payer_contract` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`product_payer_contract` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`product_payer_contract` ALTER COLUMN `medicinal_product_id` SET TAGS ('dbx_business_glossary_term' = 'Payer Contract - Medicinal Product Id');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`product_payer_contract` ALTER COLUMN `payer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Payer Contract - Payer Account Id');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`product_payer_contract` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Payer Contract ID');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`product_payer_contract` ALTER COLUMN `base_rebate_pct` SET TAGS ('dbx_business_glossary_term' = 'Base Rebate Percentage');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`product_payer_contract` ALTER COLUMN `base_rebate_pct` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`product_payer_contract` ALTER COLUMN `contract_number` SET TAGS ('dbx_business_glossary_term' = 'Contract Number');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`product_payer_contract` ALTER COLUMN `contract_status` SET TAGS ('dbx_business_glossary_term' = 'Contract Status');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`product_payer_contract` ALTER COLUMN `contract_type` SET TAGS ('dbx_business_glossary_term' = 'Contract Type');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`product_payer_contract` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`product_payer_contract` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`product_payer_contract` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`product_payer_contract` ALTER COLUMN `formulary_tier` SET TAGS ('dbx_business_glossary_term' = 'Formulary Tier');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`product_payer_contract` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`product_payer_contract` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`product_payer_contract` ALTER COLUMN `outcomes_metric` SET TAGS ('dbx_business_glossary_term' = 'Outcomes Metric');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`product_payer_contract` ALTER COLUMN `performance_rebate_pct` SET TAGS ('dbx_business_glossary_term' = 'Performance Rebate Percentage');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`product_payer_contract` ALTER COLUMN `performance_rebate_pct` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`product_payer_contract` ALTER COLUMN `prior_authorization_required` SET TAGS ('dbx_business_glossary_term' = 'Prior Authorization Required');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`product_payer_contract` ALTER COLUMN `quantity_limit` SET TAGS ('dbx_business_glossary_term' = 'Quantity Limit');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`product_payer_contract` ALTER COLUMN `step_therapy_required` SET TAGS ('dbx_business_glossary_term' = 'Step Therapy Required');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`product_payer_contract` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`product_payer_contract` ALTER COLUMN `utilization_target` SET TAGS ('dbx_business_glossary_term' = 'Utilization Target');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`kol_product_engagement` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`kol_product_engagement` SET TAGS ('dbx_subdomain' = 'commercial_operations');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`kol_product_engagement` SET TAGS ('dbx_association_edges' = 'product.medicinal_product,medical.medical_kol_profile');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`kol_product_engagement` ALTER COLUMN `kol_product_engagement_id` SET TAGS ('dbx_business_glossary_term' = 'KOL Product Engagement Identifier');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`kol_product_engagement` ALTER COLUMN `medical_kol_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Kol Product Engagement - Medical Kol Profile Id');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`kol_product_engagement` ALTER COLUMN `medical_kol_profile_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`kol_product_engagement` ALTER COLUMN `medical_kol_profile_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`kol_product_engagement` ALTER COLUMN `medicinal_product_id` SET TAGS ('dbx_business_glossary_term' = 'Kol Product Engagement - Medicinal Product Id');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`kol_product_engagement` ALTER COLUMN `advisory_role` SET TAGS ('dbx_business_glossary_term' = 'Advisory Role');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`kol_product_engagement` ALTER COLUMN `clinical_trial_role` SET TAGS ('dbx_business_glossary_term' = 'Clinical Trial Role');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`kol_product_engagement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`kol_product_engagement` ALTER COLUMN `engagement_end_date` SET TAGS ('dbx_business_glossary_term' = 'Engagement End Date');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`kol_product_engagement` ALTER COLUMN `engagement_start_date` SET TAGS ('dbx_business_glossary_term' = 'Engagement Start Date');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`kol_product_engagement` ALTER COLUMN `engagement_status` SET TAGS ('dbx_business_glossary_term' = 'Engagement Status');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`kol_product_engagement` ALTER COLUMN `last_engagement_date` SET TAGS ('dbx_business_glossary_term' = 'Last Engagement Date');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`kol_product_engagement` ALTER COLUMN `primary_indication_focus` SET TAGS ('dbx_business_glossary_term' = 'Primary Indication Focus');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`kol_product_engagement` ALTER COLUMN `relationship_type` SET TAGS ('dbx_business_glossary_term' = 'Engagement Relationship Type');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`kol_product_engagement` ALTER COLUMN `speaker_bureau_status` SET TAGS ('dbx_business_glossary_term' = 'Speaker Bureau Status');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`kol_product_engagement` ALTER COLUMN `total_engagement_count` SET TAGS ('dbx_business_glossary_term' = 'Total Engagement Count');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`kol_product_engagement` ALTER COLUMN `total_tov_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Transfer of Value Amount');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`kol_product_engagement` ALTER COLUMN `total_tov_amount` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`kol_product_engagement` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`contract_pricing` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`contract_pricing` SET TAGS ('dbx_subdomain' = 'commercial_operations');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`contract_pricing` SET TAGS ('dbx_association_edges' = 'product.medicinal_product,commercial.contract_account');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`contract_pricing` ALTER COLUMN `contract_pricing_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Pricing Agreement Identifier');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`contract_pricing` ALTER COLUMN `contract_account_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Pricing - Contract Account Id');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`contract_pricing` ALTER COLUMN `medicinal_product_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Pricing - Medicinal Product Id');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`contract_pricing` ALTER COLUMN `annual_volume_commitment` SET TAGS ('dbx_business_glossary_term' = 'Annual Volume Commitment');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`contract_pricing` ALTER COLUMN `annual_volume_commitment` SET TAGS ('dbx_pii_business_sensitive' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`contract_pricing` ALTER COLUMN `contract_price` SET TAGS ('dbx_business_glossary_term' = 'Contracted Unit Price');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`contract_pricing` ALTER COLUMN `contract_price` SET TAGS ('dbx_pii_business_sensitive' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`contract_pricing` ALTER COLUMN `contract_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Contract Reference Number');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`contract_pricing` ALTER COLUMN `contract_status` SET TAGS ('dbx_business_glossary_term' = 'Contract Status');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`contract_pricing` ALTER COLUMN `contract_type` SET TAGS ('dbx_business_glossary_term' = 'Contract Type');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`contract_pricing` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`contract_pricing` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Effective Date');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`contract_pricing` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Expiration Date');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`contract_pricing` ALTER COLUMN `formulary_status` SET TAGS ('dbx_business_glossary_term' = 'Formulary Status');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`contract_pricing` ALTER COLUMN `minimum_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`contract_pricing` ALTER COLUMN `rebate_percentage` SET TAGS ('dbx_business_glossary_term' = 'Rebate Percentage');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`contract_pricing` ALTER COLUMN `rebate_percentage` SET TAGS ('dbx_pii_business_sensitive' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`contract_pricing` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`contract_pricing` ALTER COLUMN `volume_tier` SET TAGS ('dbx_business_glossary_term' = 'Volume Commitment Tier');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`supply_allocation` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`supply_allocation` SET TAGS ('dbx_subdomain' = 'commercial_operations');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`supply_allocation` SET TAGS ('dbx_association_edges' = 'product.sku,masterdata.plant');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`supply_allocation` ALTER COLUMN `supply_allocation_id` SET TAGS ('dbx_business_glossary_term' = 'Supply Allocation Identifier');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`supply_allocation` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Supply Allocation - Plant Id');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`supply_allocation` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Supply Allocation - Sku Id');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`supply_allocation` ALTER COLUMN `allocation_percentage` SET TAGS ('dbx_business_glossary_term' = 'Supply Allocation Percentage');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`supply_allocation` ALTER COLUMN `capacity_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Capacity Unit of Measure');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`supply_allocation` ALTER COLUMN `cost_per_unit` SET TAGS ('dbx_business_glossary_term' = 'Plant-Specific Manufacturing Cost');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`supply_allocation` ALTER COLUMN `cost_per_unit` SET TAGS ('dbx_financial' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`supply_allocation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`supply_allocation` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Currency Code');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`supply_allocation` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Supply Allocation Effective End Date');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`supply_allocation` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Supply Allocation Effective Start Date');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`supply_allocation` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Active Record Indicator');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`supply_allocation` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`supply_allocation` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Plant-Specific Lead Time');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`supply_allocation` ALTER COLUMN `maximum_capacity_units` SET TAGS ('dbx_business_glossary_term' = 'Maximum Plant Capacity for SKU');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`supply_allocation` ALTER COLUMN `minimum_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`supply_allocation` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Modifying User Identifier');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`supply_allocation` ALTER COLUMN `primary_supply_flag` SET TAGS ('dbx_business_glossary_term' = 'Primary Supply Designation');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`supply_allocation` ALTER COLUMN `regulatory_approval_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Status for Supply');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`supply_allocation` ALTER COLUMN `supply_priority` SET TAGS ('dbx_business_glossary_term' = 'Supply Priority Rank');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`supply_allocation` ALTER COLUMN `supply_status` SET TAGS ('dbx_business_glossary_term' = 'Supply Allocation Status');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`drug_product_assay_specification` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`drug_product_assay_specification` SET TAGS ('dbx_subdomain' = 'commercial_operations');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`drug_product_assay_specification` SET TAGS ('dbx_association_edges' = 'discovery.assay,product.drug_product');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`drug_product_assay_specification` ALTER COLUMN `drug_product_assay_specification_id` SET TAGS ('dbx_business_glossary_term' = 'Drug Product Assay Specification - Drug Product Assay Specification Id');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`drug_product_assay_specification` ALTER COLUMN `assay_id` SET TAGS ('dbx_business_glossary_term' = 'Drug Product Assay Specification - Assay Id');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`drug_product_assay_specification` ALTER COLUMN `drug_product_id` SET TAGS ('dbx_business_glossary_term' = 'Drug Product Assay Specification - Drug Product Id');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`drug_product_assay_specification` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Testing Site');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`drug_product_assay_specification` ALTER COLUMN `assay_purpose` SET TAGS ('dbx_business_glossary_term' = 'Assay Purpose');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`drug_product_assay_specification` ALTER COLUMN `compendial_method_flag` SET TAGS ('dbx_business_glossary_term' = 'Compendial Method Flag');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`drug_product_assay_specification` ALTER COLUMN `created_date` SET TAGS ('dbx_business_glossary_term' = 'Created Date');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`drug_product_assay_specification` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`drug_product_assay_specification` ALTER COLUMN `last_modified_date` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Date');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`drug_product_assay_specification` ALTER COLUMN `lower_specification_limit` SET TAGS ('dbx_business_glossary_term' = 'Lower Specification Limit');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`drug_product_assay_specification` ALTER COLUMN `out_of_specification_procedure` SET TAGS ('dbx_business_glossary_term' = 'Out of Specification Procedure');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`drug_product_assay_specification` ALTER COLUMN `regulatory_commitment` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Commitment');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`drug_product_assay_specification` ALTER COLUMN `reportable_to_regulatory_authority` SET TAGS ('dbx_business_glossary_term' = 'Reportable to Regulatory Authority');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`drug_product_assay_specification` ALTER COLUMN `sample_size` SET TAGS ('dbx_business_glossary_term' = 'Sample Size');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`drug_product_assay_specification` ALTER COLUMN `specification_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Specification Effective Date');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`drug_product_assay_specification` ALTER COLUMN `specification_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Specification Expiry Date');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`drug_product_assay_specification` ALTER COLUMN `specification_limit` SET TAGS ('dbx_business_glossary_term' = 'Specification Limit');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`drug_product_assay_specification` ALTER COLUMN `specification_version` SET TAGS ('dbx_business_glossary_term' = 'Specification Version');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`drug_product_assay_specification` ALTER COLUMN `test_frequency` SET TAGS ('dbx_business_glossary_term' = 'Test Frequency');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`drug_product_assay_specification` ALTER COLUMN `upper_specification_limit` SET TAGS ('dbx_business_glossary_term' = 'Upper Specification Limit');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`drug_product_assay_specification` ALTER COLUMN `validation_protocol_reference` SET TAGS ('dbx_business_glossary_term' = 'Validation Protocol Reference');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`drug_product_assay_specification` ALTER COLUMN `validation_status` SET TAGS ('dbx_business_glossary_term' = 'Validation Status');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`drug_product_assay_specification` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
