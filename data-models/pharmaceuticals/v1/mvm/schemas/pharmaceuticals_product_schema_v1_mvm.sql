-- Schema for Domain: product | Business: Pharmaceuticals | Version: v1_mvm
-- Generated on: 2026-05-05 21:11:00

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `pharmaceuticals_ecm`.`product` COMMENT 'Authoritative catalog and lifecycle management for all pharmaceutical products including branded drugs, generics, biosimilars, vaccines, and consumer health products. Manages product hierarchies, drug substance/drug product definitions, finished dosage forms (FDF), SKUs, NDC codes, ATC classifications, international nonproprietary names (INN), USAN, formulations, strengths, dosage forms, packaging configurations, and regulatory identifiers. Serves as the master product catalog referenced by manufacturing, commercial, regulatory, and supply chain domains.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`product`.`medicinal_product` (
    `medicinal_product_id` BIGINT COMMENT 'Unique identifier for the medicinal product. Primary key for this entity.',
    `atc_classification_id` BIGINT COMMENT 'Foreign key linking to masterdata.atc_classification. Business justification: Products classified by ATC for therapeutic categorization, formulary management, pharmacoepidemiology, reimbursement. Replaces denormalized atc_code string with FK to ATC master for hierarchical analy',
    `drug_product_id` BIGINT COMMENT 'Foreign key linking to product.drug_product. Business justification: medicinal_product is the high-level commercial/regulatory entity (the authorized product with brand name, regulatory approvals, market authorizations), while drug_product is the physical finished dosa',
    `inn_registry_id` BIGINT COMMENT 'Foreign key linking to masterdata.inn_registry. Business justification: Products linked to INN for international nomenclature, regulatory harmonization (IDMP), scientific communication. Replaces denormalized inn string with FK to INN registry for standardized substance id',
    `licensing_agreement_id` BIGINT COMMENT 'Foreign key linking to intellectual.licensing_agreement. Business justification: Medicinal products commercialized under in-licensing agreements require this link for royalty reporting, territory rights management, and regulatory submission compliance. BD and legal teams track whi',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to masterdata.legal_entity. Business justification: Marketing Authorization Holder (MAH) is regulatory requirement for all marketed medicines. Tracks legal entity responsible for product registration, pharmacovigilance, regulatory compliance per jurisd',
    `masterdata_ndc_code_id` BIGINT COMMENT 'Foreign key linking to masterdata.ndc_code. Business justification: Medicinal products in US market reference NDC for regulatory compliance (FDA product listing), reimbursement (billing codes), distribution (supply chain tracking). Enables NDC-level regulatory intelli',
    `patent_family_id` BIGINT COMMENT 'Foreign key linking to intellectual.patent_family. Business justification: Product-level patent family tracking enables portfolio-wide IP strategy, multi-jurisdiction LOE forecasting, competitive intelligence, and integrated patent estate management across global markets.',
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
    `plant_id` BIGINT COMMENT 'Foreign key linking to masterdata.plant. Business justification: API manufacturing site assignment is a core supply chain and GMP compliance process. Regulatory filings (DMF, IMPD) require identification of the manufacturing plant for each drug substance. A pharma ',
    `material_id` BIGINT COMMENT 'Foreign key linking to masterdata.material. Business justification: Drug substances are represented as materials in ERP/SAP for procurement, inventory management, and batch tracking. Linking the scientific drug_substance record to its ERP material master is essential ',
    `country_id` BIGINT COMMENT 'Foreign key linking to masterdata.country. Business justification: Country of origin for drug substances is a regulatory requirement under ICH Q11 and import/export regulations. FDA and EMA require declaration of the country where the API is manufactured. Pharma doma',
    `patent_family_id` BIGINT COMMENT 'Foreign key linking to intellectual.patent_family. Business justification: Drug substances are protected by patent families (composition-of-matter, polymorph, synthesis patents). Portfolio management and LOE planning operate at the patent family level. IP teams track which p',
    `patent_id` BIGINT COMMENT 'Foreign key linking to intellectual.patent. Business justification: API-level patent protection distinct from formulation patents. Critical for FTO analysis, CMC regulatory strategy, supplier qualification, and manufacturing site IP clearance.',
    `therapeutic_area_id` BIGINT COMMENT 'Foreign key linking to product.therapeutic_area. Business justification: A drug substance (API) is developed and classified within a specific therapeutic area (e.g., oncology, immunology). The drug_substance table currently stores therapeutic_class as a free-text string, w',
    `unit_of_measure_id` BIGINT COMMENT 'Foreign key linking to masterdata.unit_of_measure. Business justification: APIs measured in specific UOM for manufacturing (batch records), specifications (release testing), regulatory filings (CTD Module 3). Enables UOM standardization for API inventory, yield calculations,',
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
    `usan_name` STRING COMMENT 'United States Adopted Name assigned by the USAN Council, representing the official generic name used in the United States for the drug substance.',
    CONSTRAINT pk_drug_substance PRIMARY KEY(`drug_substance_id`)
) COMMENT 'Master record for the active pharmaceutical ingredient (API) or drug substance (DS) as defined in ICH Q7. Captures chemical name, molecular formula, molecular weight, CAS registry number, INN/USAN designation, pharmacopoeial monograph reference (USP/EP/JP), physical form, stereochemistry, polymorphic form, salt form, particle size specification, ADME profile summary, BCS classification, and regulatory Drug Master File (DMF) reference number. Represents the DS layer in the DS/DP hierarchy and is the single source of truth for API chemical identity referenced by manufacturing, quality, regulatory, and formulation records.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`product`.`drug_product` (
    `drug_product_id` BIGINT COMMENT 'Unique identifier for the finished drug product record. Primary key for the drug product entity.',
    `country_id` BIGINT COMMENT 'Foreign key linking to masterdata.country. Business justification: Drug products approved in specific jurisdictions for market authorization tracking, regulatory submissions (country-specific dossiers), supply planning (market-specific manufacturing), labeling (count',
    `atc_classification_id` BIGINT COMMENT 'Foreign key linking to masterdata.atc_classification. Business justification: Drug products require ATC classification for reimbursement (HTA submissions, pricing negotiations), formulary inclusion, utilization analysis. Replaces denormalized atc_code with FK to ATC master for ',
    `business_partner_id` BIGINT COMMENT 'Foreign key linking to masterdata.business_partner. Business justification: Contract manufacturing organizations (CMOs) are a core business partner type in pharma. Drug products manufactured by CMOs require quality agreements, batch release authorization, and regulatory site ',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to masterdata.cost_center. Business justification: Drug products assigned to cost centers for R&D capitalization (IAS 38), portfolio accounting, project costing. Enables financial tracking of development costs by product, capitalization decisions (tec',
    `drug_master_file_id` BIGINT COMMENT 'Foreign key linking to intellectual.drug_master_file. Business justification: Drug products reference DMFs in NDA/ANDA submissions for API/excipient manufacturing details. Essential for regulatory completeness, supplier qualification, and CMC documentation cross-referencing.',
    `drug_substance_id` BIGINT COMMENT 'Reference to the primary active pharmaceutical ingredient (API) or drug substance used in this drug product formulation.',
    `inn_registry_id` BIGINT COMMENT 'Foreign key linking to masterdata.inn_registry. Business justification: Drug products linked to INN for labeling (generic name), prescribing information, international trade (import/export documentation). Replaces denormalized inn with FK to INN registry for standardized ',
    `licensing_agreement_id` BIGINT COMMENT 'Foreign key linking to intellectual.licensing_agreement. Business justification: Drug products commercialized under licensing agreements require this link for royalty calculation on net sales, territory rights enforcement, and financial reporting. BD and finance teams use this to ',
    `masterdata_ndc_code_id` BIGINT COMMENT 'Foreign key linking to masterdata.ndc_code. Business justification: Drug products assigned NDC codes for US regulatory compliance (FDA establishment registration), supply chain tracking (serialization), reimbursement (billing). Replaces denormalized ndc_code string wi',
    `patent_family_id` BIGINT COMMENT 'Foreign key linking to intellectual.patent_family. Business justification: Drug products are protected by patent families (formulation, method-of-use patents). LOE planning, generic entry risk assessment, and lifecycle management require patent family linkage at the drug pro',
    `patent_id` BIGINT COMMENT 'Foreign key linking to intellectual.patent. Business justification: Drug products require patent coverage tracking for lifecycle management, LOE planning, Orange Book listings, and generic defense strategy. Essential for regulatory submissions and commercial planning.',
    `plant_id` BIGINT COMMENT 'Foreign key linking to masterdata.plant. Business justification: Drug product manufacturing plant assignment for production planning, batch genealogy, GMP site compliance, regulatory site registration. Complements existing manufacturing_site_id (manufacturing domai',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to masterdata.profit_center. Business justification: Drug products are assigned to profit centers for P&L reporting, revenue recognition, and financial planning. This is a standard SAP/ERP financial reporting requirement in pharma. Pharma finance teams ',
    `rld_product_id` BIGINT COMMENT 'Reference to the RLD drug product if this product is a generic or biosimilar requiring bioequivalence demonstration.',
    `therapeutic_area_id` BIGINT COMMENT 'Foreign key linking to product.therapeutic_area. Business justification: drug_product has therapeutic_area as a STRING attribute that should reference the therapeutic_area master table for standardized classification.',
    `trademark_id` BIGINT COMMENT 'Foreign key linking to intellectual.trademark. Business justification: Drug products have brand names protected by trademarks. Brand management, regulatory submissions, and trademark enforcement require linking each drug product to its trademark registration. Existing li',
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
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to masterdata.cost_center. Business justification: Formulation development activities are tracked against cost centers for R&D capitalization, project accounting, and budget control. Pharma companies must allocate formulation development costs to spec',
    `plant_id` BIGINT COMMENT 'Foreign key linking to masterdata.plant. Business justification: Formulation development site tracking for technology transfer documentation, scale-up studies, process validation, site-specific design space. Critical for CMC regulatory submissions (CTD Module 3), m',
    `drug_product_id` BIGINT COMMENT 'Reference to the parent drug product that this formulation defines. Links to the finished dosage form (FDF) in the product master catalog.',
    `internal_order_id` BIGINT COMMENT 'Foreign key linking to finance.internal_order. Business justification: Formulation development projects are tracked via internal orders for cost accumulation, budget control, and capitalization eligibility determination. This link enables pharmaceutical companies to trac',
    `licensing_agreement_id` BIGINT COMMENT 'Foreign key linking to intellectual.licensing_agreement. Business justification: Formulations developed using licensed technology platforms (e.g., drug delivery systems, nanoparticle formulations) are governed by licensing agreements. Royalty calculations and IP ownership determin',
    `patent_id` BIGINT COMMENT 'Foreign key linking to intellectual.patent. Business justification: Formulations have distinct patent protection (composition, process). Essential for lifecycle management, line extension strategy, and generic defense through formulation patents.',
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
    `patent_id` BIGINT COMMENT 'Foreign key linking to intellectual.patent. Business justification: Active ingredients in formulations may be covered by composition-of-matter or salt-form patents distinct from the drug product patent. FTO analysis for formulation ingredients requires linking each in',
    `unit_of_measure_id` BIGINT COMMENT 'Foreign key linking to masterdata.unit_of_measure. Business justification: Ingredient unit dose quantity UOM for formulation composition (per-unit ingredient amounts), batch calculations (ingredient quantities per batch). Replaces denormalized unit_dose_uom with FK to UOM ma',
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
    `country_id` BIGINT COMMENT 'Foreign key linking to masterdata.country. Business justification: Packaging configurations are approved per country by regulatory authorities. The market_authorization_country plain-text column is a denormalized reference to the country master. Normalizing to a FK s',
    `orange_book_listing_id` BIGINT COMMENT 'Foreign key linking to intellectual.orange_book_listing. Business justification: FDA Orange Book lists products at the package level with specific package codes. Packaging configurations must reference their Orange Book listing for regulatory compliance, generic substitution eligi',
    `plant_id` BIGINT COMMENT 'Foreign key linking to masterdata.plant. Business justification: Packaging operations site assignment for capacity planning, serialization compliance (plant-level aggregation), secondary packaging operations, distribution planning. Required for Track & Trace regula',
    `patent_id` BIGINT COMMENT 'Foreign key linking to intellectual.patent. Business justification: Packaging and device components (especially combination products) have distinct patent protection. Critical for product differentiation, IP strategy, and device-related regulatory submissions.',
    `unit_of_measure_id` BIGINT COMMENT 'Foreign key linking to masterdata.unit_of_measure. Business justification: Packaging fill volume UOM for fill specifications (target fill volume), stability (headspace calculations), regulatory filings (container-closure system). Normalizes implicit ml unit in fill_volume_ml',
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
    `moisture_protection_required` BOOLEAN COMMENT 'Indicates whether the packaging must provide moisture barrier protection to prevent hygroscopic degradation.',
    `ndc_code` STRING COMMENT 'FDA-assigned National Drug Code uniquely identifying this specific packaging configuration in the US market. Format: labeler-product-package.. Valid values are `^[0-9]{5}-[0-9]{4}-[0-9]{2}$|^[0-9]{5}-[0-9]{3}-[0-9]{2}$|^[0-9]{4}-[0-9]{4}-[0-9]{2}$`',
    `nominal_fill_volume_ml` DECIMAL(18,2) COMMENT 'Labeled or declared fill volume on the packaging, which may differ from actual fill volume due to overfill requirements.',
    `package_insert_version` STRING COMMENT 'Version identifier of the package insert or patient information leaflet included with this packaging configuration.',
    `primary_container_material` STRING COMMENT 'Material composition of the primary container, critical for stability and compatibility with the drug substance. [ENUM-REF-CANDIDATE: glass_type_i|glass_type_ii|glass_type_iii|plastic_hdpe|plastic_ldpe|plastic_pet|plastic_pp|aluminum|laminate — 9 candidates stripped; promote to reference product]',
    `primary_container_type` STRING COMMENT 'Type of primary container that is in direct contact with the drug product, part of the container closure system (CCS). [ENUM-REF-CANDIDATE: vial|ampoule|blister|bottle|syringe|cartridge|pen|inhaler|sachet|tube|pouch — 11 candidates stripped; promote to reference product]',
    `regulatory_approval_date` DATE COMMENT 'Date on which the packaging configuration received regulatory approval for commercial distribution.',
    `retest_period_months` STRING COMMENT 'Period in months after which the drug product must be retested to confirm continued compliance with specifications.',
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
    `drug_product_id` BIGINT COMMENT 'Foreign key linking to product.drug_product. Business justification: A SKU is the commercially sellable unit of a drug product. While sku already references medicinal_product and packaging_configuration, a direct FK to drug_product is essential for supply chain, manufa',
    `licensing_agreement_id` BIGINT COMMENT 'Foreign key linking to intellectual.licensing_agreement. Business justification: SKUs sold under co-promotion or distribution licensing agreements require this link for royalty calculation on net sales by SKU, territory rights enforcement, and financial reporting to licensors per ',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to masterdata.legal_entity. Business justification: SKU-level Marketing Authorization Holder tracking for market-specific regulatory compliance, product liability, pharmacovigilance case processing. Each market/SKU may have different MAH (local affilia',
    `masterdata_ndc_code_id` BIGINT COMMENT 'Foreign key linking to masterdata.ndc_code. Business justification: SKUs in US market must link to NDC for billing (pharmacy claims, 340B), reimbursement (Medicare Part D), serialization (DSCSA compliance). Replaces denormalized ndc_code with FK to NDC master for pric',
    `medicinal_product_id` BIGINT COMMENT 'Reference to the parent drug product (DP) or finished dosage form (FDF) that this SKU represents at a specific packaging and market configuration.',
    `orange_book_listing_id` BIGINT COMMENT 'Foreign key linking to intellectual.orange_book_listing. Business justification: Commercial SKUs must reference their Orange Book listing for pharmacy substitution decisions, therapeutic equivalence codes, and generic entry monitoring. Commercial and regulatory teams use this link',
    `packaging_configuration_id` BIGINT COMMENT 'Foreign key linking to product.packaging_configuration. Business justification: SKU is the commercially sellable unit with specific packaging. The packaging details (package_size, package_type, storage_condition, cold_chain_required, shelf_life_months) on sku should reference the',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to masterdata.profit_center. Business justification: SKUs are the commercial unit of sale and must be assigned to profit centers for revenue reporting, gross-to-net calculations, and commercial P&L. This is a standard requirement in pharma commercial fi',
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
    `atc_classification_id` BIGINT COMMENT 'Foreign key linking to masterdata.atc_classification. Business justification: NDC-to-ATC mapping is used in pharmacovigilance signal detection, market research, and payer formulary management. The atc_code plain-text column is a denormalized reference to the ATC classification ',
    `drug_product_id` BIGINT COMMENT 'Foreign key linking to product.drug_product. Business justification: An NDC code is assigned to a specific drug product (finished dosage form with defined strength, route, and dosage form). The product_ndc_code already links to medicinal_product and packaging_configura',
    `inn_registry_id` BIGINT COMMENT 'Foreign key linking to masterdata.inn_registry. Business justification: NDC codes map to INN for drug classification, interoperability (HL7, FHIR), data exchange (FDA SPL). Replaces denormalized inn_name with FK to INN registry for standardized substance identification, t',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to masterdata.legal_entity. Business justification: NDC labeler code must map to legal entity for FDA establishment registration, labeling compliance, product listing. Replaces denormalized labeler_name with FK for regulatory reporting (FDA SPL submiss',
    `medicinal_product_id` BIGINT COMMENT 'Foreign key reference to the master product entity in the product domain. Links the NDC record to the internal product catalog.',
    `orange_book_listing_id` BIGINT COMMENT 'Foreign key linking to intellectual.orange_book_listing. Business justification: NDC codes appear directly in Orange Book listings as the product identifier. Regulatory teams managing Orange Book listings need to link NDC records to their Orange Book entry for listing status updat',
    `packaging_configuration_id` BIGINT COMMENT 'Foreign key linking to product.packaging_configuration. Business justification: NDC codes are assigned to specific packaging configurations in the FDA listing system. The package_description, package_quantity, and package_unit on product_ndc_code should reference the packaging_co',
    `patent_id` BIGINT COMMENT 'Foreign key linking to intellectual.patent. Business justification: NDC codes are associated with patents via Orange Book listings. Patent term extension calculations and SPC applications reference the specific NDC/product code. Regulatory and IP teams need this link ',
    `active_ingredient` STRING COMMENT 'The substance or substances in the drug product responsible for the therapeutic effect. May list multiple active ingredients for combination products.',
    `application_number` STRING COMMENT 'The FDA-assigned application number for the drug product. Prefix indicates application type: NDA (New Drug Application), ANDA (Abbreviated New Drug Application for generics), or BLA (Biologics License Application).. Valid values are `^(NDA|ANDA|BLA)[0-9]{6}$`',
    `application_type` STRING COMMENT 'The type of FDA regulatory application under which the drug product is approved: NDA (New Drug Application for new molecular entities), ANDA (Abbreviated New Drug Application for generics), BLA (Biologics License Application), or OTC (Over-The-Counter, no application required).. Valid values are `NDA|ANDA|BLA|OTC`',
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
    `country_id` BIGINT COMMENT 'Foreign key linking to masterdata.country. Business justification: Lifecycle stages are country-specific — a product may be in Phase III in the US while in Phase II in the EU. Country-specific lifecycle tracking is essential for global regulatory strategy, launch seq',
    `licensing_agreement_id` BIGINT COMMENT 'Foreign key linking to intellectual.licensing_agreement. Business justification: In-licensed or out-licensed assets have lifecycle stages governed by licensing agreement milestones and diligence obligations. BD and portfolio teams must link lifecycle records to the governing licen',
    `medicinal_product_id` BIGINT COMMENT 'Foreign key reference to the medicinal product (Drug Product, Drug Substance, Finished Dosage Form, or SKU) whose lifecycle is being tracked. Links to the authoritative product master catalog.',
    `patent_family_id` BIGINT COMMENT 'Foreign key linking to intellectual.patent_family. Business justification: Lifecycle stage-gate reviews require knowing the patent family protecting the asset to assess LOE risk and exclusivity runway. Portfolio strategy and go/no-go decisions at each lifecycle stage depend ',
    `org_unit_id` BIGINT COMMENT 'Foreign key linking to masterdata.org_unit. Business justification: Stage gate reviews and lifecycle milestone decisions are owned by specific organizational units (e.g., Global Development, Regulatory Affairs). The responsible_team plain-text column is a denormalized',
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
    `stage` STRING COMMENT 'Current stage of the medicinal product in its development and commercial lifecycle. Tracks progression from early research through regulatory approval, market launch, loss of exclusivity (LOE), and eventual discontinuation. Critical for portfolio planning and resource allocation. [ENUM-REF-CANDIDATE: discovery|preclinical|phase_i|phase_ii|phase_iii|nda_bla_submission|maa_submission|approved|launched|loe|discontinued — 11 candidates stripped; promote to reference product]',
    `stage_entry_date` DATE COMMENT 'Date when the product entered the current lifecycle stage. Used to calculate time-in-stage metrics and track development velocity against portfolio benchmarks.',
    `stage_exit_date` DATE COMMENT 'Date when the product exited or is expected to exit the current lifecycle stage. Nullable for products still in active stage. Critical for forecasting and resource planning.',
    `strategic_priority` STRING COMMENT 'Strategic importance ranking assigned by portfolio management based on alignment with corporate strategy, unmet medical need, commercial potential, and competitive positioning.. Valid values are `high|medium|low`',
    `target_launch_date` DATE COMMENT 'Planned or forecasted commercial launch date for the product. Updated as development progresses and regulatory timelines become clearer. Critical for commercial planning and supply chain readiness.',
    CONSTRAINT pk_lifecycle PRIMARY KEY(`lifecycle_id`)
) COMMENT 'Tracks the lifecycle stage and status transitions of a medicinal product from discovery through post-market, including pipeline stage (discovery, preclinical, Phase I/II/III, NDA/BLA submission, approved, launched, LOE, discontinued). Captures stage entry date, exit date, milestone events, responsible team, and lifecycle gate criteria. Provides the authoritative product lifecycle timeline referenced by portfolio planning and regulatory domains.';

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`product`.`regulatory_identifier` (
    `regulatory_identifier_id` BIGINT COMMENT 'Unique identifier for the regulatory identifier record. Primary key.',
    `atc_classification_id` BIGINT COMMENT 'Foreign key linking to masterdata.atc_classification. Business justification: Regulatory identifiers (marketing authorizations, BLAs, MAAs) reference ATC classifications in regulatory submissions and health authority databases. The atc_code plain-text column is denormalized. No',
    `country_id` BIGINT COMMENT 'Foreign key linking to masterdata.country. Business justification: Regulatory identifiers jurisdiction-specific (FDA=US, EMA=EU, PMDA=Japan). Replaces denormalized jurisdiction string with FK to country master for regulatory intelligence (approval tracking by country',
    `drug_product_id` BIGINT COMMENT 'Foreign key linking to product.drug_product. Business justification: Regulatory identifiers (NDA, BLA, MAA numbers) are issued for specific drug product formulations, not just at the medicinal product level. Adding drug_product_id to regulatory_identifier enables direc',
    `exclusivity_period_id` BIGINT COMMENT 'Foreign key linking to intellectual.exclusivity_period. Business justification: Regulatory identifiers carry exclusivity codes (NCE-1, ODE, PED) assigned at approval. The exclusivity_period record is the authoritative source for expiry dates. Regulatory teams link approval record',
    `inn_registry_id` BIGINT COMMENT 'Foreign key linking to masterdata.inn_registry. Business justification: Regulatory identifiers reference INN for substance identification, global harmonization (IDMP), regulatory data exchange. Replaces denormalized inn with FK to INN registry for standardized nomenclatur',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to masterdata.legal_entity. Business justification: Regulatory approvals (NDA, BLA, MAA) granted to specific legal entities (Marketing Authorization Holder). Critical for regulatory compliance, pharmacovigilance (ICSR case processing), regulatory intel',
    `medicinal_product_id` BIGINT COMMENT 'Reference to the pharmaceutical product (Drug Product or Drug Substance) to which this regulatory identifier is assigned.',
    `orange_book_listing_id` BIGINT COMMENT 'Foreign key linking to intellectual.orange_book_listing. Business justification: Orange Book listings are organized by NDA/BLA number. Regulatory identifiers (NDA/BLA) are the primary key for Orange Book entries. Regulatory affairs teams need this link to manage listing status, pa',
    `packaging_configuration_id` BIGINT COMMENT 'Foreign key linking to product.packaging_configuration. Business justification: Regulatory identifiers are often specific to packaging configurations, especially in jurisdictions where different pack sizes require separate approval numbers or listing codes. This links the regulat',
    `patent_id` BIGINT COMMENT 'Foreign key linking to intellectual.patent. Business justification: Patent term extension applications reference the specific regulatory approval (NDA/BLA number). Regulatory identifiers must link to the patent whose term is being extended. FDA PTE and SPC filings req',
    `therapeutic_area_id` BIGINT COMMENT 'Foreign key linking to product.therapeutic_area. Business justification: regulatory_identifier has therapeutic_area as a STRING attribute that should reference the therapeutic_area master table for standardized classification.',
    `application_number` STRING COMMENT 'The regulatory application number associated with this identifier (e.g., IND number, NDA number, BLA number). Links the identifier to the original regulatory submission.',
    `approval_date` DATE COMMENT 'The date on which the regulatory authority approved the product and assigned this identifier.',
    `approval_status` STRING COMMENT 'The current regulatory approval status of the product under this identifier (e.g., Approved, Pending, Withdrawn, Suspended, Expired, Rejected).. Valid values are `Approved|Pending|Withdrawn|Suspended|Expired|Rejected`',
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
    `exclusivity_period_id` BIGINT COMMENT 'Foreign key linking to intellectual.exclusivity_period. Business justification: Orphan drug and pediatric exclusivity are granted per indication, not per product. Regulatory teams must track which exclusivity_period record governs each indication to manage LOE risk and first-gene',
    `inn_registry_id` BIGINT COMMENT 'Foreign key linking to masterdata.inn_registry. Business justification: Indication approvals are granted for specific active substances identified by INN. Regulatory submissions (SmPC, USPI) require INN-indication linkage. Pharmacovigilance and benefit-risk assessments ar',
    `medicinal_product_id` BIGINT COMMENT 'Reference to the medicinal product (Drug Product (DP), Drug Substance (DS), or Finished Dosage Form (FDF)) associated with this indication.',
    `orange_book_listing_id` BIGINT COMMENT 'Foreign key linking to intellectual.orange_book_listing. Business justification: FDA Orange Book use codes map directly to approved indications. Paragraph IV ANDA challenges are indication-specific. Regulatory and IP teams require this link to manage use-code listings and defend a',
    `patent_id` BIGINT COMMENT 'Foreign key linking to intellectual.patent. Business justification: Method-of-use patents are filed per indication. Orange Book use-code listings and paragraph IV certifications require knowing which patent covers each indication. IP counsel and regulatory teams track',
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
    `atc_classification_id` BIGINT COMMENT 'Foreign key linking to masterdata.atc_classification. Business justification: Labels reference ATC codes for pharmacovigilance, formulary management, and health authority submissions. The atc_code plain-text column is denormalized. Normalizing to ATC master supports consistent ',
    `country_id` BIGINT COMMENT 'Foreign key linking to masterdata.country. Business justification: Product labels country-specific for regulatory compliance (country-specific labeling requirements), language requirements, safety updates (country-specific label changes). Replaces denormalized jurisd',
    `drug_product_id` BIGINT COMMENT 'Reference to the drug product for which this label applies. Links to the master product catalog.',
    `inn_registry_id` BIGINT COMMENT 'Foreign key linking to masterdata.inn_registry. Business justification: Regulatory labeling must display the INN (non-proprietary name) of the active substance as required by FDA 21 CFR and EMA guidelines. Linking labeling to inn_registry ensures INN consistency across la',
    `label_id` BIGINT COMMENT 'Unique document identifier or reference number for the label file stored in the document management system (e.g., Veeva Vault document ID).',
    `licensing_agreement_id` BIGINT COMMENT 'Foreign key linking to intellectual.licensing_agreement. Business justification: Labels for licensed products must comply with field-of-use and territory restrictions in the licensing agreement. Regulatory teams need this link to ensure label claims align with licensed indications',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to masterdata.legal_entity. Business justification: Product labels approved for specific legal entities (MAH) per jurisdiction. Required for regulatory compliance (label changes, safety updates), pharmacovigilance (labeling assessment for ICSRs), regul',
    `orange_book_listing_id` BIGINT COMMENT 'Foreign key linking to intellectual.orange_book_listing. Business justification: FDA-approved labeling must align with Orange Book patent listings for Paragraph IV defense, generic competition monitoring, and regulatory compliance. Critical for patent-label consistency.',
    `packaging_configuration_id` BIGINT COMMENT 'Foreign key linking to product.packaging_configuration. Business justification: Product labeling is specific to a packaging configuration (different pack sizes may have different labels, especially for dosing instructions and NDC codes). The ndc_code on product_labeling should re',
    `patent_id` BIGINT COMMENT 'Foreign key linking to intellectual.patent. Business justification: Drug labels include patent expiry information and patent numbers for Orange Book-listed products. Regulatory teams must link labeling versions to specific patents to ensure label accuracy during paten',
    `adverse_reactions_text` STRING COMMENT 'Full text of the Adverse Reactions section from the label, summarizing the most common and serious adverse events observed in clinical trials and post-marketing surveillance.',
    `approval_date` DATE COMMENT 'Date when the regulatory authority officially approved this label version.',
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

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`product`.`combination_product` (
    `combination_product_id` BIGINT COMMENT 'Unique identifier for the combination product record. Primary key.',
    `country_id` BIGINT COMMENT 'Foreign key linking to masterdata.country. Business justification: Combination products receive country-specific regulatory approvals (FDA, EMA, PMDA). Tracking the approval country is essential for market authorization management, post-market surveillance obligation',
    `atc_classification_id` BIGINT COMMENT 'Foreign key linking to masterdata.atc_classification. Business justification: Combination products classified by primary ATC (drug constituent) for regulatory categorization, market analysis, reimbursement. Replaces denormalized atc_code with FK to ATC master for combination pr',
    `business_partner_id` BIGINT COMMENT 'Foreign key linking to masterdata.business_partner. Business justification: Combination products involve a device constituent typically manufactured by a device company partner. Managing the device manufacturer as a business partner is required for quality agreements, design ',
    `drug_product_id` BIGINT COMMENT 'Foreign key linking to product.drug_product. Business justification: combination_product has drug_constituent_name, drug_constituent_classification, drug_constituent_strength, dosage_form, and route_of_administration that describe the drug component. This FK links the ',
    `drug_substance_id` BIGINT COMMENT 'Foreign key linking to product.drug_substance. Business justification: A combination product contains a drug constituent (active pharmaceutical ingredient). The combination_product table currently stores drug_constituent_name as a free-text string, which is denormalized ',
    `inn_registry_id` BIGINT COMMENT 'Foreign key linking to masterdata.inn_registry. Business justification: Combination products contain drug constituents identified by INN. Regulatory submissions for combination products (FDA 21 CFR Part 3) require INN identification of the drug constituent. The inn_name p',
    `licensing_agreement_id` BIGINT COMMENT 'Foreign key linking to intellectual.licensing_agreement. Business justification: Combination products involving licensed device or biologic constituents are governed by licensing agreements. The existing `agreement_number` plain attribute is a denormalized reference. BD and legal ',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to masterdata.legal_entity. Business justification: Combination products require MAH tracking for regulatory submissions (lead center determination, cross-labeling), post-market surveillance (device/drug adverse events), GMP compliance (drug/device man',
    `masterdata_ndc_code_id` BIGINT COMMENT 'Foreign key linking to masterdata.ndc_code. Business justification: Combination products assigned NDC for US market authorization (FDA product listing), distribution (supply chain), reimbursement (billing codes). Replaces denormalized ndc_code with FK to NDC master fo',
    `medicinal_product_id` BIGINT COMMENT 'Foreign key linking to product.medicinal_product. Business justification: A combination product (drug+device or drug+biologic) is associated with a specific medicinal product record in the master catalog. This FK directly links the combination_product entity to its parent m',
    `patent_family_id` BIGINT COMMENT 'Foreign key linking to intellectual.patent_family. Business justification: Drug-device combinations require integrated IP strategy across multiple patent families (drug, device, method). Essential for regulatory planning, commercial strategy, and lifecycle management.',
    `site_id` BIGINT COMMENT 'Identifier of the primary manufacturing facility responsible for final assembly and release of the combination product.',
    `therapeutic_area_id` BIGINT COMMENT 'Foreign key linking to product.therapeutic_area. Business justification: combination_product has therapeutic_area as a STRING attribute that should reference the therapeutic_area master table for standardized classification.',
    `trademark_id` BIGINT COMMENT 'Foreign key linking to intellectual.trademark. Business justification: Combination products have distinct brand names protected by trademarks separate from the drug constituents trademark. Brand management and regulatory submissions require tracking the specific tradema',
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
    `drug_constituent_strength` STRING COMMENT 'Quantitative composition of the drug constituent expressed with unit of measure (e.g., 50 mg, 0.3 mL of 1 mg/mL solution).',
    `gmp_compliance_status` STRING COMMENT 'Current GMP compliance status for the combination product manufacturing operations based on FDA inspection outcomes.. Valid values are `compliant|non_compliant|pending_inspection|warning_letter|consent_decree`',
    `human_factors_study_status` STRING COMMENT 'Status of human factors engineering and usability validation studies required for the device constituent to demonstrate safe and effective use by intended users.. Valid values are `not_started|in_progress|completed|validated|submitted`',
    `indication` STRING COMMENT 'FDA-approved indication statement describing the disease or condition the combination product is intended to treat, prevent, or diagnose.',
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
    `atc_classification_id` BIGINT COMMENT 'Foreign key linking to masterdata.atc_classification. Business justification: Therapeutic areas map to ATC Level 1 classifications for regulatory reporting, market research, and portfolio analysis. The atc_level_1_code and atc_level_1_name plain-text columns are denormalized re',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to masterdata.cost_center. Business justification: Therapeutic areas map to cost centers for budget management (TA-level budgets), financial planning, cost allocation. Enables TA-level financial reporting, headcount planning, R&D spend analysis, portf',
    `parent_therapeutic_area_id` BIGINT COMMENT 'Self-referencing FK on therapeutic_area (parent_therapeutic_area_id)',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to masterdata.profit_center. Business justification: Therapeutic areas are profit centers for P&L reporting (franchise-level financials), commercial performance tracking, segment reporting. Enables TA-level revenue/margin analysis, portfolio profitabili',
    `org_unit_id` BIGINT COMMENT 'Foreign key linking to masterdata.org_unit. Business justification: Therapeutic areas managed by specific organizational units (business units, franchises, therapeutic area heads) for portfolio management, resource allocation, budget planning, strategic decision-makin',
    `accelerated_approval_pathway` BOOLEAN COMMENT 'Indicates whether products in this therapeutic area are typically eligible for accelerated approval based on surrogate or intermediate clinical endpoints.',
    `area_code` STRING COMMENT 'Short alphanumeric code uniquely identifying the therapeutic area (e.g., ONCO, IMMUNO, RARE). Used as business identifier across systems.. Valid values are `^[A-Z0-9]{3,10}$`',
    `area_description` STRING COMMENT 'Detailed description of the therapeutic area, including scope, disease categories, and clinical focus.',
    `area_name` STRING COMMENT 'Full name of the therapeutic area (e.g., Oncology, Immunology, Rare Diseases, Neuroscience, Cardiovascular).',
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

CREATE OR REPLACE TABLE `pharmaceuticals_ecm`.`product`.`excipient` (
    `excipient_id` BIGINT COMMENT 'Unique identifier for the pharmaceutical excipient master record. Primary key for the excipient entity.',
    `business_partner_id` BIGINT COMMENT 'Foreign key linking to masterdata.business_partner. Business justification: Excipient suppliers require business partner master integration for supplier qualification (AVL management), supplier audits (GMP compliance), quality agreements, procurement. Complements existing ven',
    `drug_master_file_id` BIGINT COMMENT 'Foreign key linking to intellectual.drug_master_file. Business justification: Excipients have Type IV DMFs filed with FDA. Regulatory submissions require referencing the excipient DMF for LOA (letter of authorization). The existing `dmf_number` plain attribute is a denormalized',
    `material_id` BIGINT COMMENT 'Foreign key linking to masterdata.material. Business justification: Excipient material master integration for procurement (PO creation, vendor management), inventory management (stock levels, retest dates), batch traceability (genealogy), MRP planning. Enables ERP int',
    `country_id` BIGINT COMMENT 'Foreign key linking to masterdata.country. Business justification: Country of origin for excipients is a regulatory requirement, especially for animal-derived excipients (TSE/BSE risk assessment per EMA guidelines) and for import compliance. Pharma domain experts exp',
    `parent_excipient_id` BIGINT COMMENT 'Self-referencing FK on excipient (parent_excipient_id)',
    `unit_of_measure_id` BIGINT COMMENT 'Foreign key linking to masterdata.unit_of_measure. Business justification: Excipient specifications (particle size, quantity per unit dose) require a unit of measure reference for formulation accuracy and pharmacopoeial compliance. Pharma domain experts expect excipient mast',
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

-- ========= FOREIGN KEYS =========
ALTER TABLE `pharmaceuticals_ecm`.`product`.`medicinal_product` ADD CONSTRAINT `fk_product_medicinal_product_drug_product_id` FOREIGN KEY (`drug_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`drug_product`(`drug_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`product`.`medicinal_product` ADD CONSTRAINT `fk_product_medicinal_product_reference_product_id` FOREIGN KEY (`reference_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`medicinal_product`(`medicinal_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`product`.`medicinal_product` ADD CONSTRAINT `fk_product_medicinal_product_therapeutic_area_id` FOREIGN KEY (`therapeutic_area_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`therapeutic_area`(`therapeutic_area_id`);
ALTER TABLE `pharmaceuticals_ecm`.`product`.`drug_substance` ADD CONSTRAINT `fk_product_drug_substance_therapeutic_area_id` FOREIGN KEY (`therapeutic_area_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`therapeutic_area`(`therapeutic_area_id`);
ALTER TABLE `pharmaceuticals_ecm`.`product`.`drug_product` ADD CONSTRAINT `fk_product_drug_product_drug_substance_id` FOREIGN KEY (`drug_substance_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`drug_substance`(`drug_substance_id`);
ALTER TABLE `pharmaceuticals_ecm`.`product`.`drug_product` ADD CONSTRAINT `fk_product_drug_product_rld_product_id` FOREIGN KEY (`rld_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`drug_product`(`drug_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`product`.`drug_product` ADD CONSTRAINT `fk_product_drug_product_therapeutic_area_id` FOREIGN KEY (`therapeutic_area_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`therapeutic_area`(`therapeutic_area_id`);
ALTER TABLE `pharmaceuticals_ecm`.`product`.`formulation` ADD CONSTRAINT `fk_product_formulation_drug_product_id` FOREIGN KEY (`drug_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`drug_product`(`drug_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`product`.`formulation_ingredient` ADD CONSTRAINT `fk_product_formulation_ingredient_drug_substance_id` FOREIGN KEY (`drug_substance_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`drug_substance`(`drug_substance_id`);
ALTER TABLE `pharmaceuticals_ecm`.`product`.`formulation_ingredient` ADD CONSTRAINT `fk_product_formulation_ingredient_excipient_id` FOREIGN KEY (`excipient_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`excipient`(`excipient_id`);
ALTER TABLE `pharmaceuticals_ecm`.`product`.`formulation_ingredient` ADD CONSTRAINT `fk_product_formulation_ingredient_formulation_id` FOREIGN KEY (`formulation_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`formulation`(`formulation_id`);
ALTER TABLE `pharmaceuticals_ecm`.`product`.`packaging_configuration` ADD CONSTRAINT `fk_product_packaging_configuration_drug_product_id` FOREIGN KEY (`drug_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`drug_product`(`drug_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`product`.`sku` ADD CONSTRAINT `fk_product_sku_drug_product_id` FOREIGN KEY (`drug_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`drug_product`(`drug_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`product`.`sku` ADD CONSTRAINT `fk_product_sku_medicinal_product_id` FOREIGN KEY (`medicinal_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`medicinal_product`(`medicinal_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`product`.`sku` ADD CONSTRAINT `fk_product_sku_packaging_configuration_id` FOREIGN KEY (`packaging_configuration_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`packaging_configuration`(`packaging_configuration_id`);
ALTER TABLE `pharmaceuticals_ecm`.`product`.`sku` ADD CONSTRAINT `fk_product_sku_therapeutic_area_id` FOREIGN KEY (`therapeutic_area_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`therapeutic_area`(`therapeutic_area_id`);
ALTER TABLE `pharmaceuticals_ecm`.`product`.`product_ndc_code` ADD CONSTRAINT `fk_product_product_ndc_code_drug_product_id` FOREIGN KEY (`drug_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`drug_product`(`drug_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`product`.`product_ndc_code` ADD CONSTRAINT `fk_product_product_ndc_code_medicinal_product_id` FOREIGN KEY (`medicinal_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`medicinal_product`(`medicinal_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`product`.`product_ndc_code` ADD CONSTRAINT `fk_product_product_ndc_code_packaging_configuration_id` FOREIGN KEY (`packaging_configuration_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`packaging_configuration`(`packaging_configuration_id`);
ALTER TABLE `pharmaceuticals_ecm`.`product`.`lifecycle` ADD CONSTRAINT `fk_product_lifecycle_medicinal_product_id` FOREIGN KEY (`medicinal_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`medicinal_product`(`medicinal_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`product`.`lifecycle` ADD CONSTRAINT `fk_product_lifecycle_therapeutic_area_id` FOREIGN KEY (`therapeutic_area_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`therapeutic_area`(`therapeutic_area_id`);
ALTER TABLE `pharmaceuticals_ecm`.`product`.`regulatory_identifier` ADD CONSTRAINT `fk_product_regulatory_identifier_drug_product_id` FOREIGN KEY (`drug_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`drug_product`(`drug_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`product`.`regulatory_identifier` ADD CONSTRAINT `fk_product_regulatory_identifier_medicinal_product_id` FOREIGN KEY (`medicinal_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`medicinal_product`(`medicinal_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`product`.`regulatory_identifier` ADD CONSTRAINT `fk_product_regulatory_identifier_packaging_configuration_id` FOREIGN KEY (`packaging_configuration_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`packaging_configuration`(`packaging_configuration_id`);
ALTER TABLE `pharmaceuticals_ecm`.`product`.`regulatory_identifier` ADD CONSTRAINT `fk_product_regulatory_identifier_therapeutic_area_id` FOREIGN KEY (`therapeutic_area_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`therapeutic_area`(`therapeutic_area_id`);
ALTER TABLE `pharmaceuticals_ecm`.`product`.`indication` ADD CONSTRAINT `fk_product_indication_medicinal_product_id` FOREIGN KEY (`medicinal_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`medicinal_product`(`medicinal_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`product`.`indication` ADD CONSTRAINT `fk_product_indication_therapeutic_area_id` FOREIGN KEY (`therapeutic_area_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`therapeutic_area`(`therapeutic_area_id`);
ALTER TABLE `pharmaceuticals_ecm`.`product`.`labeling` ADD CONSTRAINT `fk_product_labeling_drug_product_id` FOREIGN KEY (`drug_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`drug_product`(`drug_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`product`.`labeling` ADD CONSTRAINT `fk_product_labeling_packaging_configuration_id` FOREIGN KEY (`packaging_configuration_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`packaging_configuration`(`packaging_configuration_id`);
ALTER TABLE `pharmaceuticals_ecm`.`product`.`combination_product` ADD CONSTRAINT `fk_product_combination_product_drug_product_id` FOREIGN KEY (`drug_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`drug_product`(`drug_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`product`.`combination_product` ADD CONSTRAINT `fk_product_combination_product_drug_substance_id` FOREIGN KEY (`drug_substance_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`drug_substance`(`drug_substance_id`);
ALTER TABLE `pharmaceuticals_ecm`.`product`.`combination_product` ADD CONSTRAINT `fk_product_combination_product_medicinal_product_id` FOREIGN KEY (`medicinal_product_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`medicinal_product`(`medicinal_product_id`);
ALTER TABLE `pharmaceuticals_ecm`.`product`.`combination_product` ADD CONSTRAINT `fk_product_combination_product_therapeutic_area_id` FOREIGN KEY (`therapeutic_area_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`therapeutic_area`(`therapeutic_area_id`);
ALTER TABLE `pharmaceuticals_ecm`.`product`.`therapeutic_area` ADD CONSTRAINT `fk_product_therapeutic_area_parent_therapeutic_area_id` FOREIGN KEY (`parent_therapeutic_area_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`therapeutic_area`(`therapeutic_area_id`);
ALTER TABLE `pharmaceuticals_ecm`.`product`.`excipient` ADD CONSTRAINT `fk_product_excipient_parent_excipient_id` FOREIGN KEY (`parent_excipient_id`) REFERENCES `pharmaceuticals_ecm`.`product`.`excipient`(`excipient_id`);

-- ========= TAGS =========
ALTER SCHEMA `pharmaceuticals_ecm`.`product` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `pharmaceuticals_ecm`.`product` SET TAGS ('dbx_domain' = 'product');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`medicinal_product` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`medicinal_product` SET TAGS ('dbx_subdomain' = 'product_identity');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`medicinal_product` ALTER COLUMN `medicinal_product_id` SET TAGS ('dbx_business_glossary_term' = 'Medicinal Product Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`medicinal_product` ALTER COLUMN `atc_classification_id` SET TAGS ('dbx_business_glossary_term' = 'Atc Classification Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`medicinal_product` ALTER COLUMN `drug_product_id` SET TAGS ('dbx_business_glossary_term' = 'Drug Product Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`medicinal_product` ALTER COLUMN `inn_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Inn Registry Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`medicinal_product` ALTER COLUMN `licensing_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Licensing Agreement Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`medicinal_product` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Mah Legal Entity Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`medicinal_product` ALTER COLUMN `masterdata_ndc_code_id` SET TAGS ('dbx_business_glossary_term' = 'Ndc Code Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`medicinal_product` ALTER COLUMN `patent_family_id` SET TAGS ('dbx_business_glossary_term' = 'Patent Family Id (Foreign Key)');
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
ALTER TABLE `pharmaceuticals_ecm`.`product`.`drug_substance` SET TAGS ('dbx_subdomain' = 'product_identity');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`drug_substance` ALTER COLUMN `drug_substance_id` SET TAGS ('dbx_business_glossary_term' = 'Drug Substance (DS) Identifier');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`drug_substance` ALTER COLUMN `atc_classification_id` SET TAGS ('dbx_business_glossary_term' = 'Atc Classification Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`drug_substance` ALTER COLUMN `drug_master_file_id` SET TAGS ('dbx_business_glossary_term' = 'Dmf Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`drug_substance` ALTER COLUMN `inn_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Inn Registry Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`drug_substance` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Legal Entity Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`drug_substance` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Plant Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`drug_substance` ALTER COLUMN `material_id` SET TAGS ('dbx_business_glossary_term' = 'Material Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`drug_substance` ALTER COLUMN `country_id` SET TAGS ('dbx_business_glossary_term' = 'Origin Country Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`drug_substance` ALTER COLUMN `patent_family_id` SET TAGS ('dbx_business_glossary_term' = 'Patent Family Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`drug_substance` ALTER COLUMN `patent_id` SET TAGS ('dbx_business_glossary_term' = 'Patent Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`drug_substance` ALTER COLUMN `therapeutic_area_id` SET TAGS ('dbx_business_glossary_term' = 'Therapeutic Area Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`drug_substance` ALTER COLUMN `unit_of_measure_id` SET TAGS ('dbx_business_glossary_term' = 'Base Uom Id (Foreign Key)');
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
ALTER TABLE `pharmaceuticals_ecm`.`product`.`drug_substance` ALTER COLUMN `usan_name` SET TAGS ('dbx_business_glossary_term' = 'United States Adopted Name (USAN)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`drug_product` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`drug_product` SET TAGS ('dbx_subdomain' = 'product_identity');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`drug_product` ALTER COLUMN `drug_product_id` SET TAGS ('dbx_business_glossary_term' = 'Drug Product (DP) Identifier');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`drug_product` ALTER COLUMN `country_id` SET TAGS ('dbx_business_glossary_term' = 'Approval Country Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`drug_product` ALTER COLUMN `atc_classification_id` SET TAGS ('dbx_business_glossary_term' = 'Atc Classification Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`drug_product` ALTER COLUMN `business_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Manufacturer Business Partner Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`drug_product` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Development Cost Center Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`drug_product` ALTER COLUMN `drug_master_file_id` SET TAGS ('dbx_business_glossary_term' = 'Dmf Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`drug_product` ALTER COLUMN `drug_substance_id` SET TAGS ('dbx_business_glossary_term' = 'Drug Substance (DS) Identifier');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`drug_product` ALTER COLUMN `inn_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Inn Registry Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`drug_product` ALTER COLUMN `licensing_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Licensing Agreement Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`drug_product` ALTER COLUMN `masterdata_ndc_code_id` SET TAGS ('dbx_business_glossary_term' = 'Ndc Code Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`drug_product` ALTER COLUMN `patent_family_id` SET TAGS ('dbx_business_glossary_term' = 'Patent Family Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`drug_product` ALTER COLUMN `patent_id` SET TAGS ('dbx_business_glossary_term' = 'Patent Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`drug_product` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`drug_product` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`drug_product` ALTER COLUMN `rld_product_id` SET TAGS ('dbx_business_glossary_term' = 'Reference Listed Drug (RLD) Product Identifier');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`drug_product` ALTER COLUMN `therapeutic_area_id` SET TAGS ('dbx_business_glossary_term' = 'Therapeutic Area Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`drug_product` ALTER COLUMN `trademark_id` SET TAGS ('dbx_business_glossary_term' = 'Trademark Id (Foreign Key)');
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
ALTER TABLE `pharmaceuticals_ecm`.`product`.`formulation` SET TAGS ('dbx_subdomain' = 'product_identity');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`formulation` ALTER COLUMN `formulation_id` SET TAGS ('dbx_business_glossary_term' = 'Formulation Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`formulation` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`formulation` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Development Plant Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`formulation` ALTER COLUMN `drug_product_id` SET TAGS ('dbx_business_glossary_term' = 'Drug Product (DP) Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`formulation` ALTER COLUMN `internal_order_id` SET TAGS ('dbx_business_glossary_term' = 'Internal Order Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`formulation` ALTER COLUMN `licensing_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Licensing Agreement Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`formulation` ALTER COLUMN `patent_id` SET TAGS ('dbx_business_glossary_term' = 'Patent Id (Foreign Key)');
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
ALTER TABLE `pharmaceuticals_ecm`.`product`.`formulation_ingredient` SET TAGS ('dbx_subdomain' = 'product_identity');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`formulation_ingredient` ALTER COLUMN `formulation_ingredient_id` SET TAGS ('dbx_business_glossary_term' = 'Formulation Ingredient Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`formulation_ingredient` ALTER COLUMN `business_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Business Partner Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`formulation_ingredient` ALTER COLUMN `drug_master_file_id` SET TAGS ('dbx_business_glossary_term' = 'Dmf Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`formulation_ingredient` ALTER COLUMN `drug_substance_id` SET TAGS ('dbx_business_glossary_term' = 'Drug Substance Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`formulation_ingredient` ALTER COLUMN `excipient_id` SET TAGS ('dbx_business_glossary_term' = 'Excipient Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`formulation_ingredient` ALTER COLUMN `formulation_id` SET TAGS ('dbx_business_glossary_term' = 'Formulation Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`formulation_ingredient` ALTER COLUMN `material_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`formulation_ingredient` ALTER COLUMN `patent_id` SET TAGS ('dbx_business_glossary_term' = 'Patent Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`formulation_ingredient` ALTER COLUMN `unit_of_measure_id` SET TAGS ('dbx_business_glossary_term' = 'Unit Dose Uom Id (Foreign Key)');
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
ALTER TABLE `pharmaceuticals_ecm`.`product`.`packaging_configuration` SET TAGS ('dbx_subdomain' = 'market_authorization');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`packaging_configuration` ALTER COLUMN `packaging_configuration_id` SET TAGS ('dbx_business_glossary_term' = 'Packaging Configuration ID');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`packaging_configuration` ALTER COLUMN `drug_product_id` SET TAGS ('dbx_business_glossary_term' = 'Drug Product (DP) ID');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`packaging_configuration` ALTER COLUMN `country_id` SET TAGS ('dbx_business_glossary_term' = 'Market Authorization Country Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`packaging_configuration` ALTER COLUMN `orange_book_listing_id` SET TAGS ('dbx_business_glossary_term' = 'Orange Book Listing Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`packaging_configuration` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Packaging Plant Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`packaging_configuration` ALTER COLUMN `patent_id` SET TAGS ('dbx_business_glossary_term' = 'Patent Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`packaging_configuration` ALTER COLUMN `unit_of_measure_id` SET TAGS ('dbx_business_glossary_term' = 'Fill Volume Uom Id (Foreign Key)');
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
ALTER TABLE `pharmaceuticals_ecm`.`product`.`packaging_configuration` ALTER COLUMN `moisture_protection_required` SET TAGS ('dbx_business_glossary_term' = 'Moisture Protection Required');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`packaging_configuration` ALTER COLUMN `ndc_code` SET TAGS ('dbx_business_glossary_term' = 'National Drug Code (NDC)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`packaging_configuration` ALTER COLUMN `ndc_code` SET TAGS ('dbx_value_regex' = '^[0-9]{5}-[0-9]{4}-[0-9]{2}$|^[0-9]{5}-[0-9]{3}-[0-9]{2}$|^[0-9]{4}-[0-9]{4}-[0-9]{2}$');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`packaging_configuration` ALTER COLUMN `nominal_fill_volume_ml` SET TAGS ('dbx_business_glossary_term' = 'Nominal Fill Volume (mL)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`packaging_configuration` ALTER COLUMN `package_insert_version` SET TAGS ('dbx_business_glossary_term' = 'Package Insert Version');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`packaging_configuration` ALTER COLUMN `primary_container_material` SET TAGS ('dbx_business_glossary_term' = 'Primary Container Material');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`packaging_configuration` ALTER COLUMN `primary_container_type` SET TAGS ('dbx_business_glossary_term' = 'Primary Container Type');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`packaging_configuration` ALTER COLUMN `regulatory_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Date');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`packaging_configuration` ALTER COLUMN `retest_period_months` SET TAGS ('dbx_business_glossary_term' = 'Retest Period (Months)');
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
ALTER TABLE `pharmaceuticals_ecm`.`product`.`sku` SET TAGS ('dbx_subdomain' = 'market_authorization');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`sku` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) Identifier');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`sku` ALTER COLUMN `country_id` SET TAGS ('dbx_business_glossary_term' = 'Country Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`sku` ALTER COLUMN `drug_product_id` SET TAGS ('dbx_business_glossary_term' = 'Drug Product Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`sku` ALTER COLUMN `licensing_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Licensing Agreement Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`sku` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Mah Legal Entity Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`sku` ALTER COLUMN `masterdata_ndc_code_id` SET TAGS ('dbx_business_glossary_term' = 'Ndc Code Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`sku` ALTER COLUMN `medicinal_product_id` SET TAGS ('dbx_business_glossary_term' = 'Product Identifier');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`sku` ALTER COLUMN `orange_book_listing_id` SET TAGS ('dbx_business_glossary_term' = 'Orange Book Listing Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`sku` ALTER COLUMN `packaging_configuration_id` SET TAGS ('dbx_business_glossary_term' = 'Packaging Configuration Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`sku` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
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
ALTER TABLE `pharmaceuticals_ecm`.`product`.`product_ndc_code` SET TAGS ('dbx_subdomain' = 'market_authorization');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`product_ndc_code` ALTER COLUMN `product_ndc_code_id` SET TAGS ('dbx_business_glossary_term' = 'Product National Drug Code (NDC) ID');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`product_ndc_code` ALTER COLUMN `atc_classification_id` SET TAGS ('dbx_business_glossary_term' = 'Atc Classification Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`product_ndc_code` ALTER COLUMN `drug_product_id` SET TAGS ('dbx_business_glossary_term' = 'Drug Product Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`product_ndc_code` ALTER COLUMN `inn_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Inn Registry Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`product_ndc_code` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Labeler Legal Entity Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`product_ndc_code` ALTER COLUMN `medicinal_product_id` SET TAGS ('dbx_business_glossary_term' = 'Product ID');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`product_ndc_code` ALTER COLUMN `orange_book_listing_id` SET TAGS ('dbx_business_glossary_term' = 'Orange Book Listing Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`product_ndc_code` ALTER COLUMN `packaging_configuration_id` SET TAGS ('dbx_business_glossary_term' = 'Packaging Configuration Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`product_ndc_code` ALTER COLUMN `patent_id` SET TAGS ('dbx_business_glossary_term' = 'Patent Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`product_ndc_code` ALTER COLUMN `active_ingredient` SET TAGS ('dbx_business_glossary_term' = 'Active Pharmaceutical Ingredient (API)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`product_ndc_code` ALTER COLUMN `application_number` SET TAGS ('dbx_business_glossary_term' = 'FDA Application Number');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`product_ndc_code` ALTER COLUMN `application_number` SET TAGS ('dbx_value_regex' = '^(NDA|ANDA|BLA)[0-9]{6}$');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`product_ndc_code` ALTER COLUMN `application_type` SET TAGS ('dbx_business_glossary_term' = 'FDA Application Type');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`product_ndc_code` ALTER COLUMN `application_type` SET TAGS ('dbx_value_regex' = 'NDA|ANDA|BLA|OTC');
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
ALTER TABLE `pharmaceuticals_ecm`.`product`.`lifecycle` SET TAGS ('dbx_subdomain' = 'market_authorization');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`lifecycle` ALTER COLUMN `lifecycle_id` SET TAGS ('dbx_business_glossary_term' = 'Product Lifecycle ID');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`lifecycle` ALTER COLUMN `country_id` SET TAGS ('dbx_business_glossary_term' = 'Country Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`lifecycle` ALTER COLUMN `licensing_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Licensing Agreement Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`lifecycle` ALTER COLUMN `medicinal_product_id` SET TAGS ('dbx_business_glossary_term' = 'Product ID');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`lifecycle` ALTER COLUMN `patent_family_id` SET TAGS ('dbx_business_glossary_term' = 'Patent Family Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`lifecycle` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Org Unit Id (Foreign Key)');
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
ALTER TABLE `pharmaceuticals_ecm`.`product`.`lifecycle` ALTER COLUMN `stage` SET TAGS ('dbx_business_glossary_term' = 'Lifecycle Stage');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`lifecycle` ALTER COLUMN `stage_entry_date` SET TAGS ('dbx_business_glossary_term' = 'Stage Entry Date');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`lifecycle` ALTER COLUMN `stage_exit_date` SET TAGS ('dbx_business_glossary_term' = 'Stage Exit Date');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`lifecycle` ALTER COLUMN `strategic_priority` SET TAGS ('dbx_business_glossary_term' = 'Strategic Priority');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`lifecycle` ALTER COLUMN `strategic_priority` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`lifecycle` ALTER COLUMN `target_launch_date` SET TAGS ('dbx_business_glossary_term' = 'Target Launch Date');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`regulatory_identifier` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`regulatory_identifier` SET TAGS ('dbx_subdomain' = 'market_authorization');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`regulatory_identifier` ALTER COLUMN `regulatory_identifier_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Identifier ID');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`regulatory_identifier` ALTER COLUMN `atc_classification_id` SET TAGS ('dbx_business_glossary_term' = 'Atc Classification Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`regulatory_identifier` ALTER COLUMN `country_id` SET TAGS ('dbx_business_glossary_term' = 'Country Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`regulatory_identifier` ALTER COLUMN `drug_product_id` SET TAGS ('dbx_business_glossary_term' = 'Drug Product Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`regulatory_identifier` ALTER COLUMN `exclusivity_period_id` SET TAGS ('dbx_business_glossary_term' = 'Exclusivity Period Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`regulatory_identifier` ALTER COLUMN `inn_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Inn Registry Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`regulatory_identifier` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Mah Legal Entity Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`regulatory_identifier` ALTER COLUMN `medicinal_product_id` SET TAGS ('dbx_business_glossary_term' = 'Product ID');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`regulatory_identifier` ALTER COLUMN `orange_book_listing_id` SET TAGS ('dbx_business_glossary_term' = 'Orange Book Listing Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`regulatory_identifier` ALTER COLUMN `packaging_configuration_id` SET TAGS ('dbx_business_glossary_term' = 'Packaging Configuration Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`regulatory_identifier` ALTER COLUMN `patent_id` SET TAGS ('dbx_business_glossary_term' = 'Patent Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`regulatory_identifier` ALTER COLUMN `therapeutic_area_id` SET TAGS ('dbx_business_glossary_term' = 'Therapeutic Area Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`regulatory_identifier` ALTER COLUMN `application_number` SET TAGS ('dbx_business_glossary_term' = 'Application Number');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`regulatory_identifier` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`regulatory_identifier` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`regulatory_identifier` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'Approved|Pending|Withdrawn|Suspended|Expired|Rejected');
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
ALTER TABLE `pharmaceuticals_ecm`.`product`.`indication` SET TAGS ('dbx_subdomain' = 'market_authorization');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`indication` ALTER COLUMN `indication_id` SET TAGS ('dbx_business_glossary_term' = 'Product Indication Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`indication` ALTER COLUMN `country_id` SET TAGS ('dbx_business_glossary_term' = 'Approval Country Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`indication` ALTER COLUMN `atc_classification_id` SET TAGS ('dbx_business_glossary_term' = 'Atc Classification Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`indication` ALTER COLUMN `exclusivity_period_id` SET TAGS ('dbx_business_glossary_term' = 'Exclusivity Period Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`indication` ALTER COLUMN `inn_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Inn Registry Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`indication` ALTER COLUMN `medicinal_product_id` SET TAGS ('dbx_business_glossary_term' = 'Product Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`indication` ALTER COLUMN `orange_book_listing_id` SET TAGS ('dbx_business_glossary_term' = 'Orange Book Listing Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`indication` ALTER COLUMN `patent_id` SET TAGS ('dbx_business_glossary_term' = 'Patent Id (Foreign Key)');
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
ALTER TABLE `pharmaceuticals_ecm`.`product`.`labeling` SET TAGS ('dbx_subdomain' = 'market_authorization');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`labeling` ALTER COLUMN `labeling_id` SET TAGS ('dbx_business_glossary_term' = 'Product Labeling ID');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`labeling` ALTER COLUMN `atc_classification_id` SET TAGS ('dbx_business_glossary_term' = 'Atc Classification Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`labeling` ALTER COLUMN `country_id` SET TAGS ('dbx_business_glossary_term' = 'Country Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`labeling` ALTER COLUMN `drug_product_id` SET TAGS ('dbx_business_glossary_term' = 'Drug Product (DP) ID');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`labeling` ALTER COLUMN `inn_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Inn Registry Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`labeling` ALTER COLUMN `label_id` SET TAGS ('dbx_business_glossary_term' = 'Label Document ID');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`labeling` ALTER COLUMN `licensing_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Licensing Agreement Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`labeling` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Mah Legal Entity Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`labeling` ALTER COLUMN `orange_book_listing_id` SET TAGS ('dbx_business_glossary_term' = 'Orange Book Listing Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`labeling` ALTER COLUMN `packaging_configuration_id` SET TAGS ('dbx_business_glossary_term' = 'Packaging Configuration Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`labeling` ALTER COLUMN `patent_id` SET TAGS ('dbx_business_glossary_term' = 'Patent Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`labeling` ALTER COLUMN `adverse_reactions_text` SET TAGS ('dbx_business_glossary_term' = 'Adverse Reactions Text');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`labeling` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Date');
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
ALTER TABLE `pharmaceuticals_ecm`.`product`.`combination_product` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`combination_product` SET TAGS ('dbx_subdomain' = 'product_identity');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`combination_product` ALTER COLUMN `combination_product_id` SET TAGS ('dbx_business_glossary_term' = 'Combination Product Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`combination_product` ALTER COLUMN `country_id` SET TAGS ('dbx_business_glossary_term' = 'Approval Country Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`combination_product` ALTER COLUMN `atc_classification_id` SET TAGS ('dbx_business_glossary_term' = 'Atc Classification Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`combination_product` ALTER COLUMN `business_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Device Manufacturer Business Partner Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`combination_product` ALTER COLUMN `drug_product_id` SET TAGS ('dbx_business_glossary_term' = 'Drug Product Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`combination_product` ALTER COLUMN `drug_substance_id` SET TAGS ('dbx_business_glossary_term' = 'Drug Substance Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`combination_product` ALTER COLUMN `inn_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Inn Registry Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`combination_product` ALTER COLUMN `licensing_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Licensing Agreement Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`combination_product` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Mah Legal Entity Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`combination_product` ALTER COLUMN `masterdata_ndc_code_id` SET TAGS ('dbx_business_glossary_term' = 'Ndc Code Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`combination_product` ALTER COLUMN `medicinal_product_id` SET TAGS ('dbx_business_glossary_term' = 'Medicinal Product Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`combination_product` ALTER COLUMN `patent_family_id` SET TAGS ('dbx_business_glossary_term' = 'Patent Family Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`combination_product` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Site Identifier (ID)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`combination_product` ALTER COLUMN `therapeutic_area_id` SET TAGS ('dbx_business_glossary_term' = 'Therapeutic Area Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`combination_product` ALTER COLUMN `trademark_id` SET TAGS ('dbx_business_glossary_term' = 'Trademark Id (Foreign Key)');
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
ALTER TABLE `pharmaceuticals_ecm`.`product`.`combination_product` ALTER COLUMN `drug_constituent_strength` SET TAGS ('dbx_business_glossary_term' = 'Drug Constituent Strength');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`combination_product` ALTER COLUMN `gmp_compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Good Manufacturing Practice (GMP) Compliance Status');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`combination_product` ALTER COLUMN `gmp_compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending_inspection|warning_letter|consent_decree');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`combination_product` ALTER COLUMN `human_factors_study_status` SET TAGS ('dbx_business_glossary_term' = 'Human Factors Study Status');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`combination_product` ALTER COLUMN `human_factors_study_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|completed|validated|submitted');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`combination_product` ALTER COLUMN `indication` SET TAGS ('dbx_business_glossary_term' = 'Approved Indication');
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
ALTER TABLE `pharmaceuticals_ecm`.`product`.`therapeutic_area` SET TAGS ('dbx_subdomain' = 'product_identity');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`therapeutic_area` ALTER COLUMN `therapeutic_area_id` SET TAGS ('dbx_business_glossary_term' = 'Therapeutic Area Identifier');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`therapeutic_area` ALTER COLUMN `atc_classification_id` SET TAGS ('dbx_business_glossary_term' = 'Atc Classification Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`therapeutic_area` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`therapeutic_area` ALTER COLUMN `parent_therapeutic_area_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`therapeutic_area` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`therapeutic_area` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Org Unit Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`therapeutic_area` ALTER COLUMN `accelerated_approval_pathway` SET TAGS ('dbx_business_glossary_term' = 'Accelerated Approval Pathway Eligible Flag');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`therapeutic_area` ALTER COLUMN `area_code` SET TAGS ('dbx_business_glossary_term' = 'Therapeutic Area Code');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`therapeutic_area` ALTER COLUMN `area_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,10}$');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`therapeutic_area` ALTER COLUMN `area_description` SET TAGS ('dbx_business_glossary_term' = 'Therapeutic Area Description');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`therapeutic_area` ALTER COLUMN `area_name` SET TAGS ('dbx_business_glossary_term' = 'Therapeutic Area Name');
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
ALTER TABLE `pharmaceuticals_ecm`.`product`.`excipient` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`excipient` SET TAGS ('dbx_subdomain' = 'product_identity');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`excipient` ALTER COLUMN `excipient_id` SET TAGS ('dbx_business_glossary_term' = 'Excipient Identifier');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`excipient` ALTER COLUMN `business_partner_id` SET TAGS ('dbx_business_glossary_term' = 'Business Partner Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`excipient` ALTER COLUMN `drug_master_file_id` SET TAGS ('dbx_business_glossary_term' = 'Drug Master File Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`excipient` ALTER COLUMN `material_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`excipient` ALTER COLUMN `country_id` SET TAGS ('dbx_business_glossary_term' = 'Origin Country Id (Foreign Key)');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`excipient` ALTER COLUMN `parent_excipient_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `pharmaceuticals_ecm`.`product`.`excipient` ALTER COLUMN `unit_of_measure_id` SET TAGS ('dbx_business_glossary_term' = 'Unit Of Measure Id (Foreign Key)');
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
