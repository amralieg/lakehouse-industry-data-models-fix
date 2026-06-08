-- Schema for Domain: regulatory | Business: Consumer Goods | Version: v1_mvm
-- Generated on: 2026-05-05 11:04:14

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `consumer_goods_ecm`.`regulatory` COMMENT 'Owns product registration, regulatory submissions, labeling compliance, and safety documentation management. Manages regulatory dossiers, SDS/MSDS sheets, ingredient declarations, country-specific registrations (FDA, EPA, EU), CPSC filings, IFRA compliance records, post-market surveillance, and CFR compliance. Ensures multi-jurisdictional regulatory adherence.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `consumer_goods_ecm`.`regulatory`.`registration` (
    `registration_id` BIGINT COMMENT 'Unique identifier for the product registration record. Primary key for the registration entity.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Financial posting of registration fees requires a GL account; finance uses GL accounts for all fee postings.',
    `jurisdiction_id` BIGINT COMMENT 'Foreign key linking to regulatory.jurisdiction. Business justification: A regulatory registration is always filed under a specific jurisdiction. The jurisdiction table is the authoritative reference master for all regulatory jurisdictions. Currently, regulatory_registrati',
    `manufacturing_facility_id` BIGINT COMMENT 'Reference to the manufacturing facility or establishment where the registered product is manufactured. Links to facility master data.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Registration costs and market-entry investments are allocated to the responsible profit center for brand/market P&L reporting. Consumer goods companies track regulatory registration spend by profit ce',
    `sku_id` BIGINT COMMENT 'Reference to the product being registered with regulatory authorities. Links to the product master record.',
    `active_ingredients` STRING COMMENT 'List of active ingredients or substances covered by this registration, using INCI (International Nomenclature of Cosmetic Ingredients) or CAS (Chemical Abstracts Service) numbers where applicable. Critical for EPA pesticide and antimicrobial registrations.',
    `annual_report_due_date` DATE COMMENT 'Date by which annual registration reports or updates must be submitted to the regulatory authority. Used for compliance tracking and reporting calendar management.',
    `approval_date` DATE COMMENT 'Date when the regulatory authority officially approved the registration application.',
    `cfr_citation` STRING COMMENT 'Specific CFR (Code of Federal Regulations) citation or section under which the product is registered (e.g., 21 CFR 314 for NDAs, 40 CFR 152 for pesticides). Applicable primarily to US registrations.',
    `cpsc_tracking_label_required` BOOLEAN COMMENT 'Indicates whether CPSC tracking label requirements apply to this registered product. True if tracking labels are required, False otherwise. Applicable to childrens products and certain consumer goods.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this registration record was first created in the system. Audit trail field for data lineage and compliance.',
    `effective_date` DATE COMMENT 'Date when the registration becomes legally effective and the product may be marketed or distributed under this registration.',
    `expiry_date` DATE COMMENT 'Date when the registration expires and is no longer valid unless renewed. Null for registrations with indefinite validity.',
    `fee_amount` DECIMAL(18,2) COMMENT 'Total fee amount paid or payable for this registration in the registration holders reporting currency. Includes initial registration fees and any applicable renewal fees.',
    `fee_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the registration fee amount (e.g., USD, EUR, GBP, CAD).. Valid values are `^[A-Z]{3}$`',
    `gmp_compliance_flag` BOOLEAN COMMENT 'Indicates whether the product and manufacturing facility meet Good Manufacturing Practice requirements as verified during registration. True if GMP-compliant, False otherwise.',
    `holder_address` STRING COMMENT 'Full business address of the registration holder as registered with the regulatory authority. Organizational contact data classified as confidential.',
    `holder_name` STRING COMMENT 'Legal name of the company or entity that holds the registration. This is the registrant of record with the regulatory authority.',
    `ifra_compliance_flag` BOOLEAN COMMENT 'Indicates whether the product formulation complies with IFRA standards for fragrance ingredients. True if IFRA-compliant, False otherwise. Relevant for cosmetic and personal care products.',
    `label_approval_number` STRING COMMENT 'Approval number for the product label as reviewed and accepted by the regulatory authority. Critical for EPA pesticide registrations where label claims are strictly regulated.',
    `modified_by_user` STRING COMMENT 'Username or identifier of the user who last modified this registration record. Audit trail field for accountability and compliance.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this registration record was last modified or updated. Audit trail field for change tracking and compliance.',
    `notes` STRING COMMENT 'Free-text field for additional notes, comments, or special conditions related to the registration. May include restrictions, special handling requirements, or regulatory caveats.',
    `post_market_surveillance_required` BOOLEAN COMMENT 'Indicates whether post-market surveillance or pharmacovigilance reporting is required for this registration. True if surveillance is required, False otherwise.',
    `product_scope` STRING COMMENT 'Description of the product scope covered by this registration, including specific formulations, SKUs (Stock Keeping Units), or product variants included under this registration.',
    `reach_registration_number` STRING COMMENT 'EU REACH registration number for chemical substances. Applicable for products containing substances subject to REACH regulation in the European Union.',
    `registering_authority` STRING COMMENT 'Name of the regulatory authority or governing body with which the product is registered (e.g., FDA, EPA, EU Commission, Health Canada, ANVISA). [ENUM-REF-CANDIDATE: FDA|EPA|CPSC|EU_REACH|Health_Canada|ANVISA|PMDA|TGA|SFDA|MHRA|BfR — promote to reference product]',
    `registration_category` STRING COMMENT 'Regulatory category or class of the registration as defined by the authority (e.g., OTC drug, prescription drug, general use pesticide, restricted use pesticide, cosmetic product, biocidal product).',
    `registration_number` STRING COMMENT 'Official registration number or identifier issued by the regulatory authority. This is the externally-known unique identifier for the registration (e.g., FDA registration number, EPA registration number, EU REACH registration number).',
    `registration_status` STRING COMMENT 'Current lifecycle status of the registration. Tracks the registration through submission, review, approval, active use, and potential suspension or expiration. [ENUM-REF-CANDIDATE: draft|submitted|under_review|approved|active|suspended|expired|cancelled|rejected — 9 candidates stripped; promote to reference product]',
    `registration_type` STRING COMMENT 'Type of registration action being recorded. Indicates whether this is a new registration, renewal of existing registration, amendment to existing registration, cancellation, variation, or transfer to another entity.. Valid values are `new|renewal|amendment|cancellation|variation|transfer`',
    `regulatory_contact_email` STRING COMMENT 'Email address of the primary regulatory affairs contact person for this registration. Organizational contact data classified as confidential.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `regulatory_contact_name` STRING COMMENT 'Name of the primary regulatory affairs contact person responsible for this registration. Used for correspondence and regulatory inquiries.',
    `regulatory_contact_phone` STRING COMMENT 'Phone number of the primary regulatory affairs contact person for this registration. Organizational contact data classified as confidential.',
    `renewal_due_date` DATE COMMENT 'Date by which the registration renewal application must be submitted to maintain continuous registration status. Used for proactive renewal management.',
    `sds_document_reference` STRING COMMENT 'Reference identifier or document number for the Safety Data Sheet (SDS) or Material Safety Data Sheet (MSDS) associated with this registered product. Links to safety documentation repository.',
    `source_system` STRING COMMENT 'Name of the source system from which this registration record originated (e.g., Veeva Vault, SAP ERP, Oracle ERP). Used for data lineage and integration tracking.',
    `submission_date` DATE COMMENT 'Date when the registration application or dossier was submitted to the regulatory authority.',
    `submission_reference_number` STRING COMMENT 'Internal or external reference number for the regulatory submission dossier associated with this registration. Links to detailed submission documentation.',
    `use_classification` STRING COMMENT 'Classification of the intended use or application of the product as defined by the regulatory authority (e.g., cosmetic, drug, pesticide, antimicrobial, food contact substance, medical device). [ENUM-REF-CANDIDATE: cosmetic|drug|pesticide|antimicrobial|food_contact|medical_device|biocide|industrial_chemical — promote to reference product]',
    CONSTRAINT pk_registration PRIMARY KEY(`registration_id`)
) COMMENT 'Master record for product registrations with regulatory authorities across all jurisdictions. Tracks registration number, status, effective/expiry dates, registering authority, product scope, registration type (new, renewal, amendment, cancellation), active ingredients, use classification, submission reference, and renewal due date. Covers FDA, EPA (FIFRA pesticide/antimicrobial), CPSC, EU REACH, and country-specific registrations. SSOT for all regulatory registration identities regardless of authority or jurisdiction.';

CREATE OR REPLACE TABLE `consumer_goods_ecm`.`regulatory`.`submission` (
    `submission_id` BIGINT COMMENT 'Unique identifier for the regulatory submission record. Primary key.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Submission costs (filing fees, consultant fees, dossier preparation) are charged to regulatory affairs cost centers. Consumer goods companies track submission spend by cost center for departmental bud',
    `jurisdiction_id` BIGINT COMMENT 'Foreign key linking to regulatory.jurisdiction. Business justification: Every regulatory submission is filed with a governing body in a specific jurisdiction. The submission table currently stores authority_jurisdiction as a free-text STRING, which is denormalized and inc',
    `previous_submission_id` BIGINT COMMENT 'Foreign key reference to the prior submission record that this submission amends, supersedes, or follows up on.',
    `registration_id` BIGINT COMMENT 'Foreign key reference to the product registration record that this submission supports or updates.',
    `sku_id` BIGINT COMMENT 'Foreign key reference to the product or SKU (Stock Keeping Unit) that is the subject of this regulatory submission.',
    `actual_decision_date` DATE COMMENT 'Actual date on which the regulatory authority issued a final decision (approval, rejection, or other outcome) on the submission.',
    `channel` STRING COMMENT 'Channel or method through which the submission was filed (electronic, paper, regulatory portal, EDI electronic data interchange).. Valid values are `electronic|paper|portal|edi`',
    `contact_person_email` STRING COMMENT 'Email address of the internal regulatory affairs contact person for correspondence related to this submission.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `contact_person_name` STRING COMMENT 'Name of the internal regulatory affairs contact person or responsible party for this submission.',
    `contact_person_phone` STRING COMMENT 'Phone number of the internal regulatory affairs contact person for inquiries related to this submission.',
    `corrective_action_description` STRING COMMENT 'Description of the corrective action required or implemented in response to the submission (e.g., voluntary recall, labeling update, product reformulation).',
    `corrective_action_required` BOOLEAN COMMENT 'Boolean flag indicating whether the regulatory authority has mandated corrective action (recall, labeling change, product modification) as a result of this submission.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the submission record was first created in the regulatory management system.',
    `decision_outcome` STRING COMMENT 'Final outcome or decision rendered by the regulatory authority (approved, approved with conditions, rejected, withdrawn, pending).. Valid values are `approved|approved_with_conditions|rejected|withdrawn|pending`',
    `dossier_reference` STRING COMMENT 'Reference identifier linking this submission to the master regulatory dossier or product registration file maintained in the regulatory document management system.',
    `fee_amount` DECIMAL(18,2) COMMENT 'Regulatory filing fee amount charged by the authority for processing the submission.',
    `fee_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the regulatory filing fee (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `fee_payment_status` STRING COMMENT 'Payment status of the regulatory filing fee (paid, pending, waived, refunded).. Valid values are `paid|pending|waived|refunded`',
    `hazard_description` STRING COMMENT 'Detailed description of the hazard, incident, or safety concern that prompted the submission (applicable for CPSC Section 15(b) reports, SaferProducts.gov filings, and post-market surveillance submissions).',
    `incident_date` DATE COMMENT 'Date on which the reported incident, adverse event, or safety issue occurred (applicable for safety-related submissions).',
    `language` STRING COMMENT 'Two-letter ISO 639-1 language code representing the primary language in which the submission was prepared and filed (e.g., en for English, de for German, fr for French).. Valid values are `^[a-z]{2}$`',
    `last_modified_by` STRING COMMENT 'Username or identifier of the user who last modified the submission record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the submission record was last updated or modified.',
    `notes` STRING COMMENT 'Free-text notes or comments regarding the submission, including internal observations, authority feedback, or follow-up actions required.',
    `population_at_risk` STRING COMMENT 'Estimated number of consumers or units in the market that may be affected by the reported hazard or safety issue (applicable for safety-related submissions).',
    `priority` STRING COMMENT 'Priority level assigned to the submission by the regulatory authority or internal regulatory affairs team (expedited, standard, routine).. Valid values are `expedited|standard|routine`',
    `regulatory_authority` STRING COMMENT 'Name of the governing body or regulatory authority to which the submission was filed (e.g., FDA, EPA, CPSC, European Chemicals Agency, Health Canada).',
    `severity_level` STRING COMMENT 'Assessed severity level of the hazard or incident reported in the submission (critical, high, medium, low).. Valid values are `critical|high|medium|low`',
    `submission_date` DATE COMMENT 'Date the submission was officially filed with the regulatory authority.',
    `submission_number` STRING COMMENT 'Externally-known unique submission number or dossier reference assigned by the regulatory authority or internal tracking system (e.g., 510(k) number, PMA number, REACH registration number).',
    `submission_status` STRING COMMENT 'Current lifecycle status of the regulatory submission (draft, submitted, under review, additional information requested, approved, rejected, withdrawn). [ENUM-REF-CANDIDATE: draft|submitted|under_review|additional_info_requested|approved|rejected|withdrawn — 7 candidates stripped; promote to reference product]',
    `submission_type` STRING COMMENT 'Type of regulatory submission filed (510(k) premarket notification, PMA premarket approval, GRAS generally recognized as safe, TSCA toxic substances control act, cosmetic notification, CPSC Section 15(b) report, SaferProducts.gov incident report, REACH registration). [ENUM-REF-CANDIDATE: 510k|pma|gras|tsca|cosmetic_notification|cpsc_section_15b|saferproducts_gov|reach_registration — 8 candidates stripped; promote to reference product]',
    `supporting_document_count` STRING COMMENT 'Number of supporting documents, attachments, or exhibits included with the submission (e.g., safety data sheets, clinical studies, ingredient declarations).',
    `target_decision_date` DATE COMMENT 'Expected or target date by which the regulatory authority is anticipated to issue a decision on the submission.',
    `version` STRING COMMENT 'Version number of the submission, incremented when amendments or resubmissions are filed.',
    `created_by` STRING COMMENT 'Username or identifier of the user who created the submission record in the regulatory management system.',
    CONSTRAINT pk_submission PRIMARY KEY(`submission_id`)
) COMMENT 'Regulatory submission records filed with any governing body worldwide. Captures submission type (510k, PMA, GRAS, TSCA, cosmetic notification, CPSC Section 15(b) report, SaferProducts.gov, REACH registration), submission date, dossier reference, submission channel, assigned reviewer, status, target decision date, hazard/incident details (for safety filings), population at risk, and linked registration. SSOT for all regulatory filings regardless of authority. Sourced from Veeva Vault regulatory submissions module.';

CREATE OR REPLACE TABLE `consumer_goods_ecm`.`regulatory`.`dossier` (
    `dossier_id` BIGINT COMMENT 'Unique identifier for the regulatory dossier record. Primary key.',
    `jurisdiction_id` BIGINT COMMENT 'Foreign key linking to regulatory.jurisdiction. Business justification: A regulatory dossier is compiled for a specific jurisdiction (e.g., EU, FDA, EPA). The dossier table currently stores jurisdiction_code as a denormalized STRING. Adding jurisdiction_id FK normalizes t',
    `registration_id` BIGINT COMMENT 'Foreign key linking to regulatory.regulatory_registration. Business justification: A regulatory dossier is the compiled technical and scientific documentation package assembled to support a specific product registration. While dossier already links to submission (which links to regu',
    `sku_id` BIGINT COMMENT 'Reference to the product for which this regulatory dossier was compiled. Links to the product master record.',
    `submission_id` BIGINT COMMENT 'Reference to the regulatory submission that this dossier supports. One dossier may support multiple submissions across jurisdictions.',
    `approval_date` DATE COMMENT 'Date when the dossier was formally approved by the regulatory affairs leadership or quality assurance team for submission or archival.',
    `approved_by` STRING COMMENT 'Name or identifier of the regulatory affairs manager or quality assurance officer who approved the dossier for submission.',
    `cfr_reference` STRING COMMENT 'Specific CFR title and part number(s) that govern the regulatory requirements addressed by this dossier, applicable for U.S. FDA and EPA submissions.',
    `comments` STRING COMMENT 'Free-text field for additional notes, special instructions, or contextual information related to the dossier compilation, review, or submission.',
    `compilation_date` DATE COMMENT 'Date when the dossier compilation was completed and finalized for submission or review.',
    `completeness_percentage` DECIMAL(18,2) COMMENT 'Numeric representation of dossier completeness, calculated as the percentage of required sections and documents that have been compiled and approved.',
    `completeness_status` STRING COMMENT 'Assessment of whether all required documentation sections and supporting materials have been compiled and verified for regulatory submission readiness.. Valid values are `incomplete|substantially_complete|complete|verified`',
    `confidentiality_level` STRING COMMENT 'Data classification level indicating the sensitivity and access restrictions for the dossier content.. Valid values are `public|internal|confidential|restricted`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the dossier record was first created in the regulatory data management system.',
    `document_count` STRING COMMENT 'Total number of individual documents included in this regulatory dossier package.',
    `dossier_number` STRING COMMENT 'Business identifier for the regulatory dossier, used for external reference and tracking across regulatory affairs teams and submissions.. Valid values are `^[A-Z0-9]{6,20}$`',
    `dossier_status` STRING COMMENT 'Current lifecycle status of the regulatory dossier indicating its stage in the compilation and submission process.. Valid values are `draft|in_compilation|under_review|complete|submitted|archived`',
    `dossier_type` STRING COMMENT 'Classification of the regulatory dossier format and submission standard. CTD (Common Technical Document), eCTD (Electronic Common Technical Document), IECIC (International Cooperation on Cosmetics Regulation), CPNP (Cosmetic Products Notification Portal), FDA 510K (Medical Device Premarket Notification), EPA FIFRA (Federal Insecticide Fungicide and Rodenticide Act).. Valid values are `CTD|eCTD|IECIC|CPNP|FDA_510K|EPA_FIFRA`',
    `effective_date` DATE COMMENT 'Date from which the dossier becomes the active regulatory documentation package for the associated product or submission.',
    `expiration_date` DATE COMMENT 'Date when the dossier is no longer valid or requires renewal, typically driven by regulatory authority requirements or internal policy.',
    `gmp_compliance_flag` BOOLEAN COMMENT 'Indicator of whether the dossier includes documentation demonstrating compliance with Good Manufacturing Practice standards as required by regulatory authorities.',
    `ifra_compliance_flag` BOOLEAN COMMENT 'Indicator of whether the dossier includes documentation demonstrating compliance with IFRA standards for fragrance ingredients.',
    `ingredient_declaration_included` BOOLEAN COMMENT 'Indicator of whether a complete ingredient declaration (INCI list or equivalent) is included in the dossier.',
    `language_code` STRING COMMENT 'ISO 639-1 language code (with optional ISO 3166-1 country code) indicating the primary language in which the dossier documentation is compiled.. Valid values are `^[a-z]{2}(-[A-Z]{2})?$`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update or modification to the dossier record, supporting audit trail and version control.',
    `last_review_date` DATE COMMENT 'Date of the most recent periodic review or audit of the dossier content for accuracy, completeness, and regulatory compliance.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next periodic review or update of the dossier, ensuring ongoing compliance with evolving regulatory requirements.',
    `owning_team` STRING COMMENT 'Name or identifier of the regulatory affairs team responsible for compiling, maintaining, and submitting this dossier.',
    `post_market_surveillance_included` BOOLEAN COMMENT 'Indicator of whether post-market surveillance data, adverse event reports, or vigilance documentation is included in the dossier.',
    `reach_registration_number` STRING COMMENT 'REACH registration number for chemical substances included in the dossier, required for EU market compliance.. Valid values are `^[0-9]{2}-[0-9]{10}-[0-9]{2}-[0-9]{4}$`',
    `regulatory_authority` STRING COMMENT 'Primary regulatory body or agency for which this dossier is intended. FDA (U.S. Food and Drug Administration), EPA (Environmental Protection Agency), CPSC (Consumer Product Safety Commission), EMA (European Medicines Agency), MHRA (Medicines and Healthcare products Regulatory Agency), ANVISA (Brazilian Health Regulatory Agency), PMDA (Pharmaceuticals and Medical Devices Agency Japan). [ENUM-REF-CANDIDATE: FDA|EPA|CPSC|EMA|MHRA|ANVISA|PMDA — 7 candidates stripped; promote to reference product]',
    `regulatory_category` STRING COMMENT 'Broad regulatory classification of the dossier content, such as cosmetics, personal care, household products, food contact materials, or pesticides, aligning with applicable regulatory frameworks. [ENUM-REF-CANDIDATE: cosmetics|personal_care|household_cleaning|food_contact|pesticides|biocides|medical_devices — promote to reference product]',
    `safety_assessment_included` BOOLEAN COMMENT 'Indicator of whether a formal safety assessment report is included in the dossier, as required for cosmetic and personal care product registrations.',
    `sds_included` BOOLEAN COMMENT 'Indicator of whether Safety Data Sheets (SDS) or Material Safety Data Sheets (MSDS) are included in the dossier for hazardous substances or mixtures.',
    `vault_folder_path` STRING COMMENT 'Hierarchical folder path within Veeva Vault where the dossier documents are stored, enabling navigation and retrieval.',
    `vault_reference_code` STRING COMMENT 'External reference identifier linking this dossier record to the corresponding document repository location in Veeva Vault for full document access and version control.. Valid values are `^VV[A-Z0-9]{10,30}$`',
    `version_number` STRING COMMENT 'Version identifier for the dossier, tracking revisions and updates to the compiled documentation package.. Valid values are `^[0-9]{1,3}.[0-9]{1,3}(.[0-9]{1,3})?$`',
    CONSTRAINT pk_dossier PRIMARY KEY(`dossier_id`)
) COMMENT 'Regulatory dossier master record representing the compiled technical and scientific documentation package supporting a product registration or submission. Tracks dossier type (CTD, eCTD, IECIC, CPNP), version, compilation date, owning regulatory affairs team, completeness status, linked submission, and document repository reference in Veeva Vault. One dossier may support multiple submissions across jurisdictions.';

CREATE OR REPLACE TABLE `consumer_goods_ecm`.`regulatory`.`sds` (
    `sds_id` BIGINT COMMENT 'Unique identifier for the Safety Data Sheet record. Primary key.',
    `jurisdiction_id` BIGINT COMMENT 'Foreign key linking to regulatory.jurisdiction. Business justification: Safety Data Sheets (SDS/MSDS) are jurisdiction-specific documents — GHS classifications, regulatory information, and required statements vary by country and regulatory framework. The sds table current',
    `sku_id` BIGINT COMMENT 'Reference to the raw material, finished good, or intermediate product that this SDS describes.',
    `accidental_release_measures` STRING COMMENT 'Personal precautions, protective equipment, emergency procedures, and methods for containment and cleanup of spills or releases.',
    `appearance` STRING COMMENT 'Visual description of the substance including color and form.',
    `authoring_chemist` STRING COMMENT 'Name of the qualified chemist or toxicologist who authored or reviewed this SDS for technical accuracy.',
    `autoignition_temperature` STRING COMMENT 'Temperature at which the substance will spontaneously ignite without an external ignition source.',
    `cas_number` STRING COMMENT 'CAS Registry Number uniquely identifying the chemical substance or mixture, if applicable.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this SDS record was first created in the system.',
    `disposal_considerations` STRING COMMENT 'Guidance on proper disposal methods, waste treatment, and applicable regulations for the substance and contaminated packaging.',
    `document_type` STRING COMMENT 'Classification of the safety document type: SDS (Safety Data Sheet per GHS), MSDS (Material Safety Data Sheet legacy format), or Extended SDS (with additional exposure scenarios).. Valid values are `sds|msds|extended_sds`',
    `document_url` STRING COMMENT 'Uniform Resource Locator (URL) or file path to the published SDS document in the document management system.',
    `ecological_information` STRING COMMENT 'Environmental impact data including aquatic toxicity, persistence and degradability, bioaccumulative potential, and mobility in soil.',
    `effective_date` DATE COMMENT 'Date from which this SDS version becomes the official document for regulatory and operational use.',
    `emergency_phone_number` STRING COMMENT '24-hour emergency contact telephone number for chemical emergency response (e.g., CHEMTREC, poison control).',
    `expiration_date` DATE COMMENT 'Date when this SDS version is superseded or no longer valid, requiring update or renewal.',
    `exposure_limits` STRING COMMENT 'Occupational exposure limits (OELs), permissible exposure limits (PELs), threshold limit values (TLVs), and biological exposure indices.',
    `firefighting_measures` STRING COMMENT 'Suitable extinguishing media, unsuitable extinguishing media, and special hazards arising from the substance or mixture during fire.',
    `first_aid_measures` STRING COMMENT 'Detailed first aid instructions for different exposure routes (inhalation, skin contact, eye contact, ingestion) as required by GHS Section 4.',
    `flash_point` STRING COMMENT 'Lowest temperature at which vapors of the substance will ignite when given an ignition source, typically in degrees Celsius.',
    `ghs_classification` STRING COMMENT 'GHS hazard classification codes assigned to this substance or mixture (e.g., Flam. Liq. 2, Acute Tox. 3, Skin Corr. 1B).',
    `handling_precautions` STRING COMMENT 'Safe handling practices and precautions for use to prevent exposure and ensure worker safety.',
    `hazard_statements` STRING COMMENT 'Standardized GHS hazard statements (H-codes) describing the nature and degree of hazards (e.g., H225: Highly flammable liquid and vapor).',
    `hazardous_decomposition_products` STRING COMMENT 'Hazardous substances that may be formed under fire conditions or other decomposition scenarios.',
    `incompatible_materials` STRING COMMENT 'Materials or substances that should not be stored or used with this product due to potential hazardous reactions.',
    `issue_date` DATE COMMENT 'Date when this SDS was originally issued or first published.',
    `language_code` STRING COMMENT 'ISO 639-1 two-letter language code indicating the language in which this SDS is written (e.g., EN for English, ES for Spanish).',
    `manufacturer_address` STRING COMMENT 'Complete physical address of the manufacturer or supplier for regulatory contact purposes.',
    `manufacturer_name` STRING COMMENT 'Legal name of the company that manufactures or supplies the product covered by this SDS.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this SDS record was last modified or updated in the system.',
    `odor` STRING COMMENT 'Characteristic odor of the substance or mixture, if detectable.',
    `packing_group` STRING COMMENT 'UN packing group indicating degree of danger for transport: I (high danger), II (medium danger), III (low danger).. Valid values are `I|II|III`',
    `personal_protective_equipment` STRING COMMENT 'Required personal protective equipment for safe handling: respiratory protection, hand protection, eye protection, skin protection.',
    `ph_value` DECIMAL(18,2) COMMENT 'pH measurement of the substance or mixture, indicating acidity or alkalinity.',
    `physical_state` STRING COMMENT 'Physical form of the substance or mixture at ambient conditions.. Valid values are `solid|liquid|gas|aerosol|paste|gel`',
    `pictograms` STRING COMMENT 'List of GHS pictogram codes required on the label (e.g., GHS02 Flame, GHS07 Exclamation Mark, GHS08 Health Hazard).',
    `precautionary_statements` STRING COMMENT 'Standardized GHS precautionary statements (P-codes) describing recommended measures to minimize or prevent adverse effects (e.g., P210: Keep away from heat/sparks/open flames).',
    `product_code` STRING COMMENT 'Internal product code or SKU (Stock Keeping Unit) for the material covered by this SDS.',
    `product_name` STRING COMMENT 'The commercial or chemical name of the product or substance covered by this SDS.',
    `proper_shipping_name` STRING COMMENT 'Official shipping name for transport documentation as specified by UN/DOT regulations.',
    `regulatory_information` STRING COMMENT 'Applicable regulatory requirements including TSCA status, REACH registration, California Prop 65, SARA Title III, and other jurisdiction-specific regulations.',
    `revision_date` DATE COMMENT 'Date when this version of the SDS was last revised or updated.',
    `sds_number` STRING COMMENT 'The externally-known unique document number assigned to this SDS, used for regulatory submissions and cross-referencing.',
    `sds_status` STRING COMMENT 'Current lifecycle status of the SDS document within the regulatory document management system.. Valid values are `draft|under_review|approved|active|superseded|archived`',
    `signal_word` STRING COMMENT 'GHS signal word indicating the severity level of the hazard: Danger (more severe) or Warning (less severe).. Valid values are `danger|warning|none`',
    `stability` STRING COMMENT 'Chemical stability information and conditions to avoid that may cause instability or hazardous reactions.',
    `storage_conditions` STRING COMMENT 'Conditions for safe storage including temperature, humidity, ventilation requirements, and incompatible materials.',
    `toxicological_information` STRING COMMENT 'Comprehensive toxicology data including acute toxicity, skin corrosion/irritation, eye damage/irritation, sensitization, mutagenicity, carcinogenicity, reproductive toxicity, and target organ effects.',
    `transport_hazard_class` STRING COMMENT 'UN/DOT hazard class for transportation (e.g., Class 3 Flammable Liquids, Class 8 Corrosives).',
    `un_number` STRING COMMENT 'Four-digit UN identification number for hazardous materials transport classification.',
    `version_number` STRING COMMENT 'Version identifier for this SDS revision, tracking document evolution over time.',
    CONSTRAINT pk_sds PRIMARY KEY(`sds_id`)
) COMMENT 'Safety Data Sheet (SDS/MSDS) master records for raw materials, finished goods, and intermediates as required by OSHA HazCom, EU CLP, and GHS standards. Captures SDS version, revision date, GHS hazard classifications, signal word, precautionary statements, first aid measures, handling/storage requirements, disposal guidance, transport classification (UN number, packing group), and authoring chemist. Managed in Veeva Vault.';

CREATE OR REPLACE TABLE `consumer_goods_ecm`.`regulatory`.`ingredient_list` (
    `ingredient_list_id` BIGINT COMMENT 'Primary key for ingredient_list',
    `formulation_id` BIGINT COMMENT 'Reference to the formulation record that defines the recipe and composition for this product. Links to formulation master data.',
    `jurisdiction_id` BIGINT COMMENT 'Foreign key linking to regulatory.jurisdiction. Business justification: Ingredient declarations are jurisdiction-specific — the required INCI names, declaration formats, and allergen disclosure requirements vary by regulatory jurisdiction (EU Cosmetics Regulation, FDA OTC',
    `restricted_substance_id` BIGINT COMMENT 'Foreign key linking to regulatory.restricted_substance. Business justification: Each ingredient in an ingredient declaration may be a restricted substance subject to prohibition, restriction, or authorization requirements. The ingredient_list table currently stores restricted_sub',
    `sku_id` BIGINT COMMENT 'Reference to the finished product SKU (Stock Keeping Unit) for which this ingredient declaration applies. Links to product master data.',
    `allergen_flag` BOOLEAN COMMENT 'Indicates whether this ingredient is a known allergen requiring special labeling or disclosure per regulatory requirements (e.g., EU Cosmetics Regulation Annex III).',
    `allergen_type` STRING COMMENT 'Classification of the allergen type if allergen_flag is true. Used for consumer safety labeling and regulatory compliance.. Valid values are `fragrance_allergen|preservative_allergen|colorant_allergen|botanical_allergen|protein_allergen|other`',
    `approved_by` STRING COMMENT 'Name or identifier of the regulatory affairs professional who approved this ingredient declaration for use.',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when this ingredient declaration was approved by regulatory affairs.',
    `cas_number` STRING COMMENT 'Unique CAS (Chemical Abstracts Service) registry number identifying the chemical substance. Used for regulatory submissions and safety documentation.. Valid values are `^[1-9][0-9]{1,6}-[0-9]{2}-[0-9]$`',
    `common_name` STRING COMMENT 'Common or trade name of the ingredient used for internal reference and non-regulated communications.',
    `concentration_max_percent` DECIMAL(18,2) COMMENT 'Maximum concentration of the ingredient in the finished product, expressed as a percentage by weight. Used for regulatory submissions and formulation specifications.',
    `concentration_min_percent` DECIMAL(18,2) COMMENT 'Minimum concentration of the ingredient in the finished product, expressed as a percentage by weight. Used for regulatory submissions and formulation specifications.',
    `concentration_typical_percent` DECIMAL(18,2) COMMENT 'Typical or target concentration of the ingredient in the finished product, expressed as a percentage by weight. Used for quality control and manufacturing guidance.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this ingredient declaration record was first created in the data platform.',
    `declaration_name_override` STRING COMMENT 'Alternative name to be used on the product label if different from INCI name, as permitted by jurisdiction-specific regulations (e.g., trade name, common name).',
    `declaration_required_flag` BOOLEAN COMMENT 'Indicates whether this ingredient must be declared on the product label per regulatory requirements. Some processing aids or trace contaminants may be exempt.',
    `declaration_status` STRING COMMENT 'Current lifecycle status of the ingredient declaration record in the regulatory documentation workflow.. Valid values are `draft|pending_review|approved|active|superseded|retired`',
    `effective_date` DATE COMMENT 'Date from which this ingredient declaration becomes effective for regulatory compliance and labeling purposes.',
    `einecs_number` STRING COMMENT 'EINECS (European Inventory of Existing Commercial Chemical Substances) number for substances marketed in the EU before September 1981. Required for EU REACH compliance.. Valid values are `^[0-9]{3}-[0-9]{3}-[0-9]$`',
    `expiration_date` DATE COMMENT 'Date after which this ingredient declaration is no longer valid, typically due to formulation changes or regulatory updates. Null indicates no expiration.',
    `fda_status` STRING COMMENT 'FDA (Food and Drug Administration) regulatory status of the ingredient for use in consumer goods (e.g., GRAS - Generally Recognized As Safe, approved food additive, approved color additive).. Valid values are `gras|food_additive|color_additive|otc_monograph|new_dietary_ingredient|not_approved`',
    `ifra_amendment_number` STRING COMMENT 'IFRA (International Fragrance Association) amendment number that governs the use restrictions for this ingredient if IFRA restricted.',
    `ifra_restricted_flag` BOOLEAN COMMENT 'Indicates whether this ingredient is subject to IFRA (International Fragrance Association) restrictions or standards for use in fragrance compounds.',
    `inci_name` STRING COMMENT 'Standardized INCI (International Nomenclature of Cosmetic Ingredients) name for the ingredient as required for cosmetic product labeling. Mandatory for cosmetics and personal care products.',
    `ingredient_function` STRING COMMENT 'Primary functional role of the ingredient in the formulation (e.g., preservative, surfactant, fragrance, colorant, active ingredient). Used for regulatory classification and formulation analysis. [ENUM-REF-CANDIDATE: preservative|surfactant|emollient|humectant|emulsifier|thickener|fragrance|colorant|active_ingredient|solvent|ph_adjuster|antioxidant|chelating_agent|opacifier|film_former — 15 candidates stripped; promote to reference product]',
    `ingredient_sequence` STRING COMMENT 'Order in which this ingredient appears on the product label declaration. Typically sorted by descending concentration per regulatory requirements (FDA 21 CFR, EU Cosmetics Regulation).',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this ingredient declaration record was last modified in the data platform.',
    `nanomaterial_flag` BOOLEAN COMMENT 'Indicates whether the ingredient is in nanomaterial form, requiring special labeling per EU Cosmetics Regulation (nano) designation.',
    `natural_origin_flag` BOOLEAN COMMENT 'Indicates whether the ingredient is derived from natural sources (plant, mineral, animal) as opposed to synthetic or petrochemical sources. Used for natural product claims and marketing.',
    `organic_certified_flag` BOOLEAN COMMENT 'Indicates whether the ingredient is certified organic by a recognized certification body (e.g., USDA Organic, COSMOS, ECOCERT). Used for organic product claims.',
    `palm_oil_derivative_flag` BOOLEAN COMMENT 'Indicates whether the ingredient is derived from palm oil. Used for sustainable sourcing tracking and RSPO (Roundtable on Sustainable Palm Oil) compliance.',
    `reach_registration_number` STRING COMMENT 'REACH (Registration Evaluation Authorization and Restriction of Chemicals) registration number for substances manufactured or imported in the EU in quantities of 1 tonne or more per year.',
    `rspo_certified_flag` BOOLEAN COMMENT 'Indicates whether palm-derived ingredients are RSPO (Roundtable on Sustainable Palm Oil) certified for sustainable sourcing.',
    `sds_reference_number` STRING COMMENT 'Reference number linking this ingredient to its Safety Data Sheet (SDS) or Material Safety Data Sheet (MSDS) document for hazard communication and workplace safety.',
    `source_record_reference` STRING COMMENT 'Unique identifier of this record in the source system, used for data lineage and reconciliation.',
    `source_system` STRING COMMENT 'Identifier of the source system from which this ingredient declaration record originated (e.g., Veeva Vault, SAP PLM, internal formulation system).',
    `vegan_flag` BOOLEAN COMMENT 'Indicates whether the ingredient is free from animal-derived substances and suitable for vegan product claims.',
    CONSTRAINT pk_ingredient_list PRIMARY KEY(`ingredient_list_id`)
) COMMENT 'Ingredient declaration records capturing the full ingredient list for a finished product SKU as required for labeling compliance. Tracks INCI names, CAS numbers, concentration ranges, function (preservative, surfactant, fragrance, colorant), declaration order, jurisdiction-specific requirements (FDA 21 CFR, EU Cosmetics Regulation, REACH), allergen flags, and restricted substance flags. Links to product master and formulation records.';

CREATE OR REPLACE TABLE `consumer_goods_ecm`.`regulatory`.`label_version` (
    `label_version_id` BIGINT COMMENT 'Unique identifier for the label version record. Primary key.',
    `jurisdiction_id` BIGINT COMMENT 'Foreign key linking to regulatory.jurisdiction. Business justification: Label versions are market- and jurisdiction-specific — labeling language, required warnings, ingredient declaration format, and net content units vary by jurisdiction. The label_version table currentl',
    `previous_version_label_version_id` BIGINT COMMENT 'Reference to the immediately preceding label version that this version supersedes, enabling version lineage tracking.',
    `registration_id` BIGINT COMMENT 'Foreign key linking to regulatory.regulatory_registration. Business justification: A product label version is approved under a specific regulatory registration — the label artwork, claims, and warnings must conform to the registration approval. This FK links each label version to th',
    `regulatory_claim_id` BIGINT COMMENT 'Foreign key linking to the approved regulatory claim being assigned to this label version.',
    `sku_id` BIGINT COMMENT 'Reference to the product SKU this label version applies to.',
    `allergen_declarations` STRING COMMENT 'Allergen declarations required on the label (e.g., Contains: milk, soy, tree nuts). Applicable for food and cosmetic products.',
    `approval_date` DATE COMMENT 'Date when the label version received regulatory approval from the governing authority.',
    `approval_expiry_date` DATE COMMENT 'Date when the regulatory approval expires and the label version can no longer be used, if applicable.',
    `approval_reference_number` STRING COMMENT 'Official reference or registration number assigned by the regulatory authority for this label approval.',
    `approval_status` STRING COMMENT 'Approval status of this specific claim-on-label-version assignment. Distinct from the regulatory_claims own approval_status — a globally approved claim may still be pending approval for a specific label version in a specific market.',
    `approving_authority` STRING COMMENT 'Name of the regulatory body or authority that approved this label version (e.g., FDA, EPA, EU Commission, Health Canada).',
    `artwork_checksum` STRING COMMENT 'SHA-256 checksum hash of the artwork file to ensure file integrity and detect unauthorized modifications.. Valid values are `^[a-fA-F0-9]{64}$`',
    `artwork_file_name` STRING COMMENT 'File name of the approved label artwork file (e.g., PDF, AI, or other format) stored in the document management system.',
    `barcode_type` STRING COMMENT 'Type of barcode symbology printed on the label (e.g., UPC, EAN-13, GTIN-14, QR Code, DataMatrix).. Valid values are `UPC|EAN|GTIN|QR|DataMatrix|Code128`',
    `barcode_value` DECIMAL(18,2) COMMENT 'The encoded value of the barcode printed on this label version (e.g., UPC number, GTIN, serialized data).',
    `brand_name` STRING COMMENT 'Brand name displayed on the label.',
    `certification_marks` STRING COMMENT 'Third-party certification marks and compliance logos displayed on the label (e.g., USDA Organic, Leaping Bunny, Non-GMO Project, Kosher, Halal).',
    `change_reason` STRING COMMENT 'Business reason for creating this new label version (e.g., Regulatory requirement change, Ingredient reformulation, Packaging redesign, Correction of error).',
    `contact_information` STRING COMMENT 'Consumer contact information displayed on the label (phone number, website, email) for inquiries and customer service.',
    `country_of_origin` STRING COMMENT 'Three-letter ISO country code indicating where the product was manufactured or produced, as declared on the label.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this label version record was first created in the system.',
    `distributor_name` STRING COMMENT 'Name of the distributor or importer as declared on the label, if different from manufacturer.',
    `effective_date` DATE COMMENT 'Date when this specific claim becomes effective on this label version. May differ from the claims own effective_date when market-specific or label-version-specific activation timing applies.',
    `effective_end_date` DATE COMMENT 'Date when this label version is no longer valid for new production. Nullable for currently active versions.',
    `effective_start_date` DATE COMMENT 'Date from which this label version becomes effective and can be used in production and distribution.',
    `expiry_date_format` STRING COMMENT 'Format specification for how the expiry or best-before date will be printed on the label (e.g., MM/YYYY, DD-MMM-YYYY, EXP: YYYY-MM-DD).',
    `ingredient_list` STRING COMMENT 'Full ingredient list as declared on the label in descending order of predominance, following regulatory naming conventions (INCI for cosmetics, common names for food).',
    `is_current_version` BOOLEAN COMMENT 'Boolean flag indicating whether this is the currently active label version for the SKU in the specified market. True if current, False if historical.',
    `label_claims` STRING COMMENT 'Marketing claims and statements appearing on the label (e.g., organic, hypoallergenic, dermatologist tested, cruelty-free). Pipe-separated list if multiple.',
    `label_type` STRING COMMENT 'Classification of the label type: primary (consumer-facing package), secondary (outer carton), shipper (distribution box), pallet (logistics unit), promotional (limited edition), or sample (trial size).. Valid values are `primary|secondary|shipper|pallet|promotional|sample`',
    `language_code` STRING COMMENT 'ISO 639-1 two-letter language code, optionally with ISO 3166-1 country code (e.g., en, en-US, fr-CA) indicating the label language.. Valid values are `^[a-z]{2}(-[A-Z]{2})?$`',
    `last_modified_by` STRING COMMENT 'User identifier or name of the person who last modified this label version record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this label version record was last modified.',
    `lot_code_format` STRING COMMENT 'Format specification for the lot or batch code that will be printed on labels during production (e.g., YYMMDD-LLLL where LLLL is line code).',
    `manufacturer_address` STRING COMMENT 'Full address of the manufacturer as declared on the label for regulatory compliance and consumer contact.',
    `manufacturer_name` STRING COMMENT 'Name of the manufacturer as declared on the label for regulatory compliance.',
    `market_country_code` STRING COMMENT 'ISO 3166-1 alpha-2 or alpha-3 country/market code indicating the specific market for which this claim is authorized on this label version. Supports multi-jurisdictional labeling compliance.',
    `net_content_declaration` STRING COMMENT 'Full net content declaration statement as it appears on the label, including quantity and unit (e.g., 500 ml, 16 fl oz (473 ml)).',
    `net_content_quantity` DECIMAL(18,2) COMMENT 'Numeric value of the net content quantity declared on the label.',
    `net_content_unit` STRING COMMENT 'Unit of measure for the net content quantity (e.g., ml, g, oz, fl_oz, count). [ENUM-REF-CANDIDATE: ml|l|g|kg|oz|lb|fl_oz|gal|count|each — 10 candidates stripped; promote to reference product]',
    `product_name_on_label` STRING COMMENT 'The exact product name as it appears on the label artwork, which may differ from internal product names due to marketing or regulatory requirements.',
    `recycling_symbols` STRING COMMENT 'Recycling symbols and sustainability marks displayed on the label (e.g., Recyclable, FSC Certified, Green Dot, resin identification codes).',
    `regulatory_approval_status` STRING COMMENT 'Current regulatory approval status of the label version in the target market jurisdiction. [ENUM-REF-CANDIDATE: draft|submitted|under_review|approved|rejected|withdrawn|expired — 7 candidates stripped; promote to reference product]',
    `veeva_vault_document_code` STRING COMMENT 'Reference identifier to the label artwork document stored in Veeva Vault regulatory document management system.',
    `version_number` STRING COMMENT 'Semantic version number of the label artwork (e.g., 1.0, 2.1, 3.0.1). Follows semantic versioning convention.. Valid values are `^[0-9]+.[0-9]+(.[0-9]+)?$`',
    `warning_statements` STRING COMMENT 'Mandatory warning and precautionary statements required by regulatory authorities (e.g., Keep out of reach of children, For external use only).',
    `created_by` STRING COMMENT 'User identifier or name of the person who created this label version record.',
    CONSTRAINT pk_label_version PRIMARY KEY(`label_version_id`)
) COMMENT 'Product label version master tracking all approved and historical label artwork versions for each SKU across markets. Captures label version number, market/country, language, label type (primary, secondary, shipper), regulatory approval status, approval date, approving authority, label claims, warning statements, net content declaration, country-of-origin, and Veeva Vault document reference. Supports multi-jurisdictional labeling compliance.';

CREATE OR REPLACE TABLE `consumer_goods_ecm`.`regulatory`.`compliance_obligation` (
    `compliance_obligation_id` BIGINT COMMENT 'Unique identifier for the compliance obligation record. Primary key.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Compliance budgeting assigns each obligation to a cost center for internal charge‑back and reporting.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Expense for a compliance obligation is posted to a specific GL account for financial statements.',
    `jurisdiction_id` BIGINT COMMENT 'Foreign key linking to regulatory.jurisdiction. Business justification: Compliance obligations are defined per regulatory jurisdiction; linking provides a normalized reference and removes duplicated jurisdiction fields.',
    `registration_id` BIGINT COMMENT 'Foreign key linking to the regulatory registration to which the obligation applies.',
    `advance_notice_period_days` STRING COMMENT 'The number of days in advance that the business must be notified or begin preparation to meet this compliance obligation.',
    `applicability_date` DATE COMMENT 'The date on which this compliance obligation became applicable to this specific regulatory registration. Belongs to the pairing, not to either parent entity, as the same obligation may become applicable to different registrations at different times.',
    `applicable_product_category` STRING COMMENT 'The product category or categories to which this compliance obligation applies (e.g., cosmetics, household cleaners, personal care, food contact materials).',
    `compliance_deadline` DATE COMMENT 'The date by which the compliance obligation must be fulfilled to avoid regulatory penalties or non-compliance.',
    `compliance_notes` STRING COMMENT 'Free-text field for additional notes, comments, or context regarding this compliance obligation, including special instructions, historical context, or exceptions.',
    `compliance_status` STRING COMMENT 'Current status of compliance with this obligation.. Valid values are `compliant|pending|overdue|not_applicable|in_progress|expired`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this compliance obligation record was first created in the system.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the estimated compliance cost (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `effective_date` DATE COMMENT 'The date when this compliance obligation becomes effective and enforceable.',
    `estimated_compliance_cost` DECIMAL(18,2) COMMENT 'The estimated financial cost to fulfill this compliance obligation, including registration fees, testing costs, documentation, and labor.',
    `expiration_date` DATE COMMENT 'The date when this compliance obligation expires or is no longer applicable, if applicable.',
    `governing_body` STRING COMMENT 'The regulatory authority or governing body that enforces this obligation (e.g., FDA, EPA, CPSC, EU Commission).',
    `governing_regulation` STRING COMMENT 'The specific regulation, directive, or legal framework that mandates this obligation (e.g., CFR 21 Part 701, EU Directive 2009/48/EC, REACH Article 33).',
    `is_active` BOOLEAN COMMENT 'Indicates whether this compliance obligation is currently active and applicable to the business.',
    `last_compliance_verification_date` DATE COMMENT 'The date when compliance with this obligation was last verified or audited.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this compliance obligation record was last updated or modified.',
    `next_audit_date` DATE COMMENT 'The scheduled date for the next internal or external audit of compliance with this obligation.',
    `next_due_date_override` DATE COMMENT 'A registration-specific override of the standard compliance deadline defined on the parent compliance_obligation. Used when a regulatory authority grants an extension or imposes an earlier deadline for a specific registered product.',
    `next_renewal_date` DATE COMMENT 'The date when the next renewal or re-certification of this obligation is due.',
    `notification_sent_date` DATE COMMENT 'The date when the compliance deadline notification was sent to the responsible owner.',
    `notification_sent_flag` BOOLEAN COMMENT 'Indicates whether advance notification has been sent to the responsible owner regarding the upcoming compliance deadline.',
    `obligation_code` STRING COMMENT 'Business identifier code for the compliance obligation, used for external reference and reporting.. Valid values are `^[A-Z0-9]{6,20}$`',
    `obligation_name` STRING COMMENT 'Full descriptive name of the compliance obligation.',
    `obligation_type` STRING COMMENT 'Classification of the compliance obligation by regulatory action required.. Valid values are `registration|labeling|reporting|testing|notification|renewal`',
    `penalty_for_non_compliance` STRING COMMENT 'Description of the penalties, fines, or consequences for failing to meet this compliance obligation (e.g., product recall, market withdrawal, monetary fines, legal action).',
    `priority` STRING COMMENT 'The business priority assigned to fulfilling this compliance obligation, used for resource allocation and scheduling.. Valid values are `urgent|high|medium|low`',
    `renewal_frequency` STRING COMMENT 'The frequency at which this compliance obligation must be renewed or re-certified.. Valid values are `annual|biennial|triennial|quinquennial|one_time|as_needed`',
    `required_documentation` STRING COMMENT 'List or description of the documentation required to fulfill this compliance obligation (e.g., Safety Data Sheet (SDS), ingredient declaration, test reports, certificates of analysis).',
    `responsible_department` STRING COMMENT 'The department or business unit responsible for managing this compliance obligation (e.g., Regulatory Affairs, Quality Assurance, Legal).',
    `risk_level` STRING COMMENT 'The assessed risk level associated with non-compliance with this obligation, based on potential business impact, regulatory scrutiny, and penalty severity.. Valid values are `critical|high|medium|low`',
    `source_system` STRING COMMENT 'The operational system of record from which this compliance obligation data originates (e.g., Veeva Vault, SAP ERP, internal regulatory database).',
    `source_system_code` STRING COMMENT 'The unique identifier for this compliance obligation in the source system of record.',
    `submission_method` STRING COMMENT 'The method by which compliance documentation or filings must be submitted to the governing body.. Valid values are `electronic|paper|portal|email|in_person`',
    `submission_portal_url` STRING COMMENT 'The web address of the electronic portal or system where compliance submissions must be filed, if applicable.',
    `testing_requirement` STRING COMMENT 'Description of any laboratory testing or analytical work required to demonstrate compliance (e.g., stability testing, microbial testing, heavy metals analysis, allergen testing).',
    `waiver_status` STRING COMMENT 'Indicates whether a waiver has been granted, is pending, or has expired for this specific obligation-registration pairing. A waiver is granted at the intersection level — the same obligation may be waived for one registration but enforced for another.',
    CONSTRAINT pk_compliance_obligation PRIMARY KEY(`compliance_obligation_id`)
) COMMENT 'Master record of regulatory compliance obligations applicable to the business by jurisdiction, product category, and governing body. Tracks obligation type (registration, labeling, reporting, testing, notification, renewal), governing regulation (CFR part, EU directive, REACH article, state law), applicable product categories, compliance deadline, renewal frequency, advance notice period, responsible regulatory affairs owner, estimated compliance cost, and current compliance status. Drives the regulatory compliance calendar and proactive renewal management.';

CREATE OR REPLACE TABLE `consumer_goods_ecm`.`regulatory`.`compliance_assessment` (
    `compliance_assessment_id` BIGINT COMMENT 'Primary key for compliance_assessment',
    `approved_supplier_list_id` BIGINT COMMENT 'Foreign key linking to procurement.approved_supplier_list. Business justification: Approved supplier list entries in consumer goods are established and periodically re-evaluated based on compliance assessments. The ASL has compliance_status and re_evaluation_due_date fields whose va',
    `compliance_obligation_id` BIGINT COMMENT 'Foreign key linking to regulatory.compliance_obligation. Business justification: A compliance assessment is a transactional record documenting the evaluation of compliance against a specific regulatory obligation. The compliance_obligation is the master record defining what must b',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Compliance assessment costs (third-party auditors, lab testing, certification fees) are charged to regulatory affairs cost centers. Consumer goods companies track assessment spend by cost center for d',
    `formulation_id` BIGINT COMMENT 'Reference to the specific product formulation undergoing compliance assessment.',
    `goods_receipt_id` BIGINT COMMENT 'Foreign key linking to procurement.goods_receipt. Business justification: Incoming goods receipts for regulated materials (cosmetic ingredients, household chemicals) trigger compliance assessments — certificate of analysis review, GMP batch release, restricted substance che',
    `jurisdiction_id` BIGINT COMMENT 'Foreign key linking to regulatory.jurisdiction. Business justification: Compliance assessments are performed within a specific regulatory jurisdiction context. The compliance_assessment table currently stores jurisdiction as a denormalized STRING column. Adding jurisdicti',
    `manufacturing_facility_id` BIGINT COMMENT 'Reference to the manufacturing or distribution facility being assessed for regulatory compliance.',
    `registration_id` BIGINT COMMENT 'Foreign key linking to regulatory.regulatory_registration. Business justification: Compliance assessments are frequently performed in the context of a specific product registration — verifying that a registered product continues to meet the conditions of its registration approval. A',
    `sku_id` BIGINT COMMENT 'Reference to the product being assessed for regulatory compliance.',
    `supplier_contract_id` BIGINT COMMENT 'Foreign key linking to procurement.supplier_contract. Business justification: Supplier contracts in consumer goods mandate periodic compliance audits (GMP, REACH, sustainability). Linking compliance_assessment to supplier_contract identifies which contractual obligation trigger',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to procurement.supplier. Business justification: Supplier compliance assessments (GMP audits, REACH checks, cosmetic regulation audits) are a core procurement-regulatory process in consumer goods. Linking compliance_assessment to supplier enables su',
    `supplier_site_id` BIGINT COMMENT 'Foreign key linking to procurement.supplier_site. Business justification: Site-level compliance assessments (GMP facility audits, ISO audits) are conducted at supplier sites in consumer goods. Linking compliance_assessment to supplier_site enables site qualification trackin',
    `assessment_date` DATE COMMENT 'The date on which the compliance assessment was performed.',
    `assessment_method` STRING COMMENT 'Method or approach used to conduct the compliance assessment (e.g., document review, laboratory test, site inspection, supplier audit, self-assessment, third-party certification).. Valid values are `document_review|laboratory_test|site_inspection|supplier_audit|self_assessment|third_party_certification`',
    `assessment_number` STRING COMMENT 'Externally-known unique identifier for the compliance assessment record, typically formatted as CA-YYYYNNNN.. Valid values are `^CA-[0-9]{8}$`',
    `assessment_type` STRING COMMENT 'Classification of the compliance assessment type (e.g., initial, periodic, pre-market, post-market, audit-triggered, change control).. Valid values are `initial|periodic|pre_market|post_market|audit_triggered|change_control`',
    `assessor_name` STRING COMMENT 'Full name of the individual or team who conducted the compliance assessment.',
    `audit_trail_reference` STRING COMMENT 'Reference identifier linking this compliance assessment to the audit trail or change history log for traceability and regulatory audit readiness.',
    `certification_number` STRING COMMENT 'Unique identifier for the third-party certification or approval certificate obtained as evidence of compliance, if applicable.',
    `closure_date` DATE COMMENT 'Date on which the compliance assessment was formally closed after verification of corrective actions or confirmation of compliance.',
    `comments` STRING COMMENT 'Additional comments, notes, or observations related to the compliance assessment that provide context or clarification.',
    `compliance_finding` STRING COMMENT 'Detailed narrative of the compliance assessment finding, including observations, test results, and rationale for the compliance determination.',
    `compliance_status` STRING COMMENT 'Current compliance finding status indicating whether the product, formulation, or facility meets the regulatory requirement (compliant, non-compliant, conditional, pending review, not applicable).. Valid values are `compliant|non_compliant|conditional|pending_review|not_applicable`',
    `corrective_action_description` STRING COMMENT 'Detailed description of the corrective action plan required to remediate the non-compliance or conditional finding.',
    `corrective_action_due_date` DATE COMMENT 'Target date by which the corrective action must be completed to achieve compliance.',
    `corrective_action_owner` STRING COMMENT 'Name of the individual or department responsible for implementing the corrective action.',
    `corrective_action_required` BOOLEAN COMMENT 'Boolean flag indicating whether corrective action is required to address the compliance finding (True if corrective action is required, False otherwise).',
    `corrective_action_status` STRING COMMENT 'Current status of the corrective action implementation (not started, in progress, completed, verified, overdue).. Valid values are `not_started|in_progress|completed|verified|overdue`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp indicating when the compliance assessment record was first created in the system.',
    `evidence_document_reference` STRING COMMENT 'Reference identifier or URI to the supporting documentation, test reports, certificates, or dossiers that substantiate the compliance assessment finding.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp indicating when the compliance assessment record was last modified or updated.',
    `next_assessment_due_date` DATE COMMENT 'Scheduled date for the next periodic compliance assessment or re-assessment.',
    `regulatory_authority` STRING COMMENT 'Name of the regulatory authority or governing body responsible for the regulatory framework (e.g., FDA, EPA, ECHA, CPSC).',
    `regulatory_framework` STRING COMMENT 'The governing regulatory framework under which the compliance assessment is conducted (e.g., CFR, IFRA, EU CLP, REACH, EPA, FDA, CPSC). [ENUM-REF-CANDIDATE: CFR|IFRA|EU_CLP|REACH|EPA|FDA|CPSC — 7 candidates stripped; promote to reference product]',
    `requirement_description` STRING COMMENT 'Detailed description of the specific regulatory requirement being assessed for compliance.',
    `requirement_reference` STRING COMMENT 'Specific citation or reference to the regulatory requirement being assessed (e.g., 21 CFR 701.3, IFRA Standard 49, REACH Annex XVII Entry 23).',
    `review_date` DATE COMMENT 'Date on which the compliance assessment was formally reviewed and approved.',
    `reviewer_name` STRING COMMENT 'Full name of the individual who reviewed and approved the compliance assessment findings.',
    `risk_level` STRING COMMENT 'Risk severity level associated with the compliance finding (critical, high, medium, low, negligible).. Valid values are `critical|high|medium|low|negligible`',
    `test_report_number` STRING COMMENT 'Unique identifier for the laboratory test report or analytical certificate supporting the compliance assessment, if applicable.',
    CONSTRAINT pk_compliance_assessment PRIMARY KEY(`compliance_assessment_id`)
) COMMENT 'Transactional records documenting compliance assessments against specific regulatory requirements (CFR, IFRA, EU CLP, REACH, state regulations) for each product, formulation, or facility. Captures regulatory framework, specific requirement reference, compliance assessment date, assessor, compliance finding (compliant, non-compliant, conditional), corrective action required, corrective action due date, closure date, and evidence document reference. Supports multi-framework compliance verification including FDA/EPA audit readiness and IFRA fragrance safety substantiation. SSOT for all regulatory compliance assessments regardless of governing body.';

CREATE OR REPLACE TABLE `consumer_goods_ecm`.`regulatory`.`product_recall` (
    `product_recall_id` BIGINT COMMENT 'Unique identifier for the product recall event. Primary key for the product recall record.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Recall expenses (logistics, disposal) are allocated to a cost center for budgeting and reporting.',
    `jurisdiction_id` BIGINT COMMENT 'Foreign key linking to regulatory.jurisdiction. Business justification: Product recalls are managed per jurisdiction; linking provides a normalized jurisdiction reference.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Recall financial impact (estimated_financial_impact_amount) must be allocated to the responsible profit center for P&L reporting. Consumer goods companies attribute recall costs to the brand/product p',
    `registration_id` BIGINT COMMENT 'Foreign key linking to regulatory.regulatory_registration. Business justification: A product recall is initiated for a product that was approved under a specific regulatory registration. Linking product_recall to regulatory_registration enables traceability from recall events back t',
    `submission_id` BIGINT COMMENT 'Foreign key linking to regulatory.submission. Business justification: A product recall typically requires a regulatory submission — the recall notification filed with the governing authority (e.g., FDA recall notification, CPSC report). Linking product_recall to the cor',
    `affected_channels` STRING COMMENT 'Comma-separated list of distribution channels impacted by recall (e.g., Retail, E-commerce, Wholesale, DSD, DTC). Defines which go-to-market channels received affected product.',
    `affected_countries` STRING COMMENT 'Comma-separated list of ISO 3166-1 alpha-3 country codes where recalled products were distributed (e.g., USA, CAN, MEX, GBR, DEU).',
    `affected_gtin_list` STRING COMMENT 'Comma-separated list of GTIN/UPC/EAN codes for recalled products. Enables point-of-sale and supply chain identification of affected items.',
    `affected_lot_batch_numbers` STRING COMMENT 'Comma-separated list of manufacturing lot or batch numbers included in the recall. Enables traceability to specific production runs.',
    `affected_production_date_range_end` DATE COMMENT 'End date of the production date range for affected products. Used when recall spans multiple production dates.',
    `affected_production_date_range_start` DATE COMMENT 'Start date of the production date range for affected products. Used when recall spans multiple production dates.',
    `affected_sku_list` STRING COMMENT 'Comma-separated list of SKU codes for all product variants included in the recall. Links recall to specific product master records.',
    `affected_states_provinces` STRING COMMENT 'Comma-separated list of state or province codes where recalled products were distributed within countries. Used for regional recalls.',
    `authority_notification_date` DATE COMMENT 'Date when the company notified the relevant regulatory authority of the recall. FDA requires notification within 24 hours of recall initiation.',
    `consumer_hotline_number` STRING COMMENT 'Toll-free or dedicated phone number for consumers to call with questions about the recall or to request remedies.',
    `consumer_remedy_instructions` STRING COMMENT 'Detailed instructions for consumers on how to return, dispose of, or obtain remedy for recalled products. Includes contact information and process steps.',
    `consumer_remedy_type` STRING COMMENT 'Type of corrective action or compensation offered to consumers who purchased recalled products. Defines how consumers are made whole.. Valid values are `Full Refund|Replacement|Repair|Credit|Disposal Instructions|No Remedy`',
    `corrective_action_plan_reference` STRING COMMENT 'Reference to the Corrective and Preventive Action (CAPA) plan implemented to prevent recurrence of the issue that caused the recall.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for financial amounts (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `effectiveness_check_date` DATE COMMENT 'Date when the recall effectiveness check was conducted to verify that all consignees were notified and appropriate action taken. FDA requires effectiveness checks at specified intervals.',
    `effectiveness_check_result` STRING COMMENT 'Result of the recall effectiveness check. Effective: recall objectives met. Partially Effective: some objectives met. Ineffective: recall objectives not met. Pending: check in progress.. Valid values are `Effective|Partially Effective|Ineffective|Pending`',
    `estimated_financial_impact_amount` DECIMAL(18,2) COMMENT 'Estimated total financial cost of the recall including product value, logistics, disposal, consumer remedies, and administrative costs. Reported in company reporting currency.',
    `health_hazard_evaluation` STRING COMMENT 'Assessment of the health risk posed by the recalled product. Describes potential adverse health consequences and likelihood of occurrence. Used to determine recall classification.',
    `press_release_reference` STRING COMMENT 'Reference number, URL, or document identifier for the official press release or public announcement of the recall.',
    `public_notification_date` DATE COMMENT 'Date when the recall was publicly announced through press release, media, or regulatory agency posting.',
    `quantity_recalled_units` DECIMAL(18,2) COMMENT 'Total number of product units subject to recall. Represents the volume of affected inventory across all distribution levels.',
    `quantity_recovered_units` DECIMAL(18,2) COMMENT 'Number of recalled product units successfully recovered and removed from distribution. Used to calculate recall effectiveness.',
    `recall_classification` STRING COMMENT 'FDA/CPSC classification of recall severity. Class I: dangerous or defective products that could cause serious health problems or death. Class II: products that might cause temporary health problem or slight threat of serious nature. Class III: products unlikely to cause adverse health reaction but violate FDA labeling or manufacturing regulations. Voluntary: company-initiated without regulatory mandate. Market Withdrawal: minor violation not subject to FDA legal action.. Valid values are `Class I|Class II|Class III|Voluntary|Market Withdrawal`',
    `recall_completion_date` DATE COMMENT 'Date when the recall was officially closed after all corrective actions were completed and effectiveness verified. Nullable for ongoing recalls.',
    `recall_coordinator_email` STRING COMMENT 'Email address of the recall coordinator for internal and external communications regarding the recall event.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `recall_coordinator_phone` STRING COMMENT 'Phone number of the recall coordinator for urgent communications regarding the recall event.',
    `recall_effectiveness_percentage` DECIMAL(18,2) COMMENT 'Percentage of recalled units successfully recovered (quantity_recovered_units / quantity_recalled_units * 100). FDA requires effectiveness checks to verify recall completion.',
    `recall_initiation_date` DATE COMMENT 'Date when the company officially initiated the recall action. Marks the beginning of the recall event lifecycle.',
    `recall_number` STRING COMMENT 'Official recall identification number assigned by the company or regulatory authority. External business identifier for the recall event.',
    `recall_reason_code` STRING COMMENT 'Standardized code categorizing the root cause of the recall (e.g., contamination, mislabeling, undeclared allergen, packaging defect, microbial contamination, foreign material).',
    `recall_reason_description` STRING COMMENT 'Detailed narrative explanation of the defect, hazard, or violation that triggered the recall. Includes specific product issue, potential health risk, and circumstances of discovery.',
    `recall_scope` STRING COMMENT 'Geographic scope of the recall action. Defines the market territories affected by the recall.. Valid values are `National|Regional|State|International|Global`',
    `recall_status` STRING COMMENT 'Current lifecycle status of the recall event. Tracks progression from initiation through completion or termination.. Valid values are `Initiated|Ongoing|Completed|Terminated|Pending`',
    `recall_type` STRING COMMENT 'Distribution level at which the recall is executed. Consumer Level: product reached end consumers. Retail Level: product at retail stores. Wholesale Level: product at distribution centers. Manufacturing Level: product not yet distributed.. Valid values are `Consumer Level|Retail Level|Wholesale Level|Manufacturing Level`',
    `recall_website_url` STRING COMMENT 'URL of the dedicated webpage providing detailed recall information, consumer instructions, and remedy request forms.',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when this recall record was first created in the system. Audit trail for data governance.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this recall record was last modified. Audit trail for data governance and change tracking.',
    `regulatory_authority` STRING COMMENT 'Name of the government agency or regulatory body overseeing the recall (e.g., FDA, CPSC, EPA, Health Canada, EU Commission). May be multiple authorities for international recalls.',
    `regulatory_mandate_flag` BOOLEAN COMMENT 'Indicates whether the recall was mandated by a regulatory authority (True) or initiated voluntarily by the company (False).',
    `root_cause_analysis_reference` STRING COMMENT 'Reference to the formal root cause analysis document or investigation report that identified the underlying cause of the product defect or contamination.',
    CONSTRAINT pk_product_recall PRIMARY KEY(`product_recall_id`)
) COMMENT 'Product recall and market withdrawal master records initiated voluntarily or mandated by regulatory authorities. Captures recall class (Class I/II/III per FDA/CPSC), recall reason, affected SKUs, affected lot/batch numbers, recall scope (geographic, channel), initiation date, authority notification date, press release reference, quantity recalled, completion date, effectiveness check results, and consumer remedy type. SSOT for recall event management across all jurisdictions and authorities.';

CREATE OR REPLACE TABLE `consumer_goods_ecm`.`regulatory`.`jurisdiction` (
    `jurisdiction_id` BIGINT COMMENT 'Unique identifier for the regulatory jurisdiction. Primary key.',
    `parent_jurisdiction_id` BIGINT COMMENT 'Foreign key reference to a parent jurisdiction if this jurisdiction is a sub-jurisdiction (e.g., a state within a country, or a country within a regional bloc). Null for top-level jurisdictions.',
    `animal_testing_ban_flag` BOOLEAN COMMENT 'Indicates whether the jurisdiction prohibits the sale of products tested on animals (True) or allows it (False).',
    `cfr_reference` STRING COMMENT 'The specific CFR title and part number applicable to this jurisdiction (e.g., 21 CFR Part 700 for cosmetics). Primarily used for US FDA jurisdictions.',
    `comments` STRING COMMENT 'Free-text field for additional notes, clarifications, or special instructions related to this jurisdiction.',
    `contact_email` STRING COMMENT 'Official email address for contacting the regulatory authority for this jurisdiction.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `contact_phone` STRING COMMENT 'Official phone number for contacting the regulatory authority for this jurisdiction.',
    `country_code` STRING COMMENT 'Three-letter ISO country code for the primary country of the jurisdiction (e.g., USA, DEU, CHN). For regional jurisdictions, this may represent the lead country or be null.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this jurisdiction record was first created in the system.',
    `effective_date` DATE COMMENT 'The date from which this jurisdiction definition and its requirements became effective.',
    `expiration_date` DATE COMMENT 'The date on which this jurisdiction definition expires or is superseded. Null if currently active with no planned expiration.',
    `gmp_compliance_required_flag` BOOLEAN COMMENT 'Indicates whether Good Manufacturing Practice (GMP) certification or compliance is mandatory for products sold in this jurisdiction (True) or not (False).',
    `ifra_compliance_required_flag` BOOLEAN COMMENT 'Indicates whether compliance with IFRA standards for fragrance ingredients is required (True) or not (False).',
    `ingredient_declaration_format` STRING COMMENT 'The required format for ingredient listing on labels: INCI (International Nomenclature of Cosmetic Ingredients), CAS (Chemical Abstracts Service number), common name, or proprietary (brand-specific naming).. Valid values are `inci|cas|common_name|proprietary`',
    `jurisdiction_code` STRING COMMENT 'Short alphanumeric code uniquely identifying the jurisdiction (e.g., US-FDA, EU-REACH, ASEAN-CCD).. Valid values are `^[A-Z0-9]{2,10}$`',
    `jurisdiction_name` STRING COMMENT 'Full official name of the regulatory jurisdiction (e.g., United States Food and Drug Administration, European Union REACH).',
    `jurisdiction_status` STRING COMMENT 'Current lifecycle status of the jurisdiction record: active (in use), inactive (no longer applicable), pending (awaiting activation), superseded (replaced by newer version).. Valid values are `active|inactive|pending|superseded`',
    `jurisdiction_type` STRING COMMENT 'Classification of the jurisdiction scope: national (country-level), regional (multi-country bloc), supranational (international treaty), state/provincial (sub-national), or municipal (city-level).. Valid values are `national|regional|supranational|state|provincial|municipal`',
    `labeling_language_primary` STRING COMMENT 'ISO 639 two- or three-letter code for the primary language required on product labels in this jurisdiction (e.g., en, fr, de, zh).. Valid values are `^[a-z]{2,3}$`',
    `labeling_language_secondary` STRING COMMENT 'Comma-separated list of ISO 639 language codes for additional languages required or recommended on labels (e.g., fr,nl for Belgium).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this jurisdiction record was last updated or modified.',
    `market_entry_requirement_type` STRING COMMENT 'The type of regulatory requirement for market entry: notification (simple filing), registration (formal registration), pre-market approval (full dossier review before sale), post-market surveillance (monitoring after launch), or voluntary (no mandatory requirement).. Valid values are `notification|registration|pre-market_approval|post-market_surveillance|voluntary`',
    `notification_required_flag` BOOLEAN COMMENT 'Indicates whether a formal notification to the regulatory authority is required before product launch (True) or not (False).',
    `post_market_surveillance_required_flag` BOOLEAN COMMENT 'Indicates whether ongoing post-market surveillance (adverse event reporting, product monitoring) is mandatory (True) or not (False).',
    `pre_market_approval_required_flag` BOOLEAN COMMENT 'Indicates whether pre-market approval (full dossier review and authorization before sale) is required (True) or not (False).',
    `product_information_file_required_flag` BOOLEAN COMMENT 'Indicates whether a Product Information File (PIF) or dossier must be maintained and made available to authorities (True) or not (False).',
    `reach_registration_required_flag` BOOLEAN COMMENT 'Indicates whether REACH registration for chemical substances is required for this jurisdiction (True) or not (False). Primarily applicable to EU and EEA jurisdictions.',
    `region_code` STRING COMMENT 'Code representing the geographic region or economic bloc (e.g., EU, ASEAN, GCC, MERCOSUR). Used for multi-country jurisdictions.',
    `registration_required_flag` BOOLEAN COMMENT 'Indicates whether formal product registration with the regulatory authority is mandatory (True) or not (False).',
    `regulatory_authority` STRING COMMENT 'Name of the governing regulatory body or agency responsible for enforcement within this jurisdiction (e.g., FDA, EPA, CPSC, European Commission).',
    `regulatory_framework` STRING COMMENT 'The primary legal or regulatory framework governing this jurisdiction (e.g., FDA 21 CFR, EU Cosmetics Regulation 1223/2009, ASEAN Cosmetic Directive, GCC Standardization Organization).',
    `responsible_person_required_flag` BOOLEAN COMMENT 'Indicates whether a designated Responsible Person (RP) within the jurisdiction is required for regulatory compliance (True) or not (False). Common in EU jurisdictions.',
    `sds_required_flag` BOOLEAN COMMENT 'Indicates whether a Safety Data Sheet (SDS) or Material Safety Data Sheet (MSDS) must be provided for products in this jurisdiction (True) or not (False).',
    `submission_portal_url` STRING COMMENT 'URL of the online portal or system used for submitting regulatory notifications, registrations, or dossiers to this jurisdiction.',
    `website_url` STRING COMMENT 'Official website URL of the regulatory authority for this jurisdiction, providing access to regulations, guidance documents, and submission portals.',
    CONSTRAINT pk_jurisdiction PRIMARY KEY(`jurisdiction_id`)
) COMMENT 'Reference master for regulatory jurisdictions defining the geographic and legal scope of regulatory requirements. Captures jurisdiction code, jurisdiction name, country/region, applicable regulatory framework (FDA, EU, ASEAN, GCC), market entry requirement type, language requirements for labeling, and notification vs. registration requirement flag. Used to drive multi-jurisdictional compliance workflows across registrations, labels, and submissions.';

CREATE OR REPLACE TABLE `consumer_goods_ecm`.`regulatory`.`restricted_substance` (
    `restricted_substance_id` BIGINT COMMENT 'Unique identifier for the restricted substance record. Primary key.',
    `jurisdiction_id` BIGINT COMMENT 'Foreign key linking to regulatory.jurisdiction. Business justification: Restricted substances are subject to jurisdiction‑specific regulations; linking provides a proper reference and removes the duplicated code.',
    `affected_product_categories` STRING COMMENT 'Comma-separated list of product categories or SKU families in which this substance is restricted or prohibited (e.g., cosmetics, household cleaners, food contact materials, childrens products).',
    `alternative_substance_recommendations` STRING COMMENT 'Comma-separated list of CAS numbers or substance names recommended as safer alternatives for formulation substitution.',
    `applicable_regulations` STRING COMMENT 'Comma-separated list of all regulations, directives, or legal frameworks under which this substance is restricted (e.g., EU REACH, California Prop 65, FDA 21 CFR 700, EPA FIFRA, CPSC regulations).',
    `authorization_status` STRING COMMENT 'Current status of regulatory authorization for use of the substance in specific applications or markets.. Valid values are `not_required|pending|granted|denied|expired|withdrawn`',
    `cas_number` STRING COMMENT 'Unique numerical identifier assigned by the Chemical Abstracts Service to every chemical substance described in the open scientific literature.. Valid values are `^[1-9][0-9]{1,6}-[0-9]{2}-[0-9]$`',
    `cfr_reference` STRING COMMENT 'Specific CFR title, part, and section citation(s) that govern the use, labeling, or prohibition of this substance in the United States.',
    `comments` STRING COMMENT 'Free-text field for additional context, special handling instructions, or notes regarding the restricted substance and its regulatory status.',
    `concentration_unit` STRING COMMENT 'Unit of measure for the maximum permitted concentration: percent by weight, percent by volume, parts per million (ppm), parts per billion (ppb), or milligrams per kilogram.. Valid values are `percent_weight|percent_volume|ppm|ppb|mg_per_kg`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this restricted substance record was first created in the system.',
    `downstream_notification_required` BOOLEAN COMMENT 'Indicates whether manufacturers and importers must notify downstream users (formulators, distributors, retailers) of the presence of this substance in articles or mixtures.',
    `ec_number` STRING COMMENT 'Seven-digit identifier assigned to chemical substances for regulatory purposes within the European Union.. Valid values are `^[0-9]{3}-[0-9]{3}-[0-9]$`',
    `effective_date` DATE COMMENT 'Date on which the restriction or regulatory requirement becomes legally enforceable.',
    `epa_restricted_flag` BOOLEAN COMMENT 'Indicates whether the substance is subject to EPA restrictions under TSCA, FIFRA, or other environmental regulations.',
    `fda_prohibited_flag` BOOLEAN COMMENT 'Indicates whether the substance is explicitly prohibited by the FDA for use in cosmetics, drugs, or food contact materials under CFR Title 21.',
    `hazard_classification` STRING COMMENT 'GHS hazard class and category codes assigned to the substance (e.g., Acute Tox. 3, Skin Corr. 1B, Carc. 1A) for safety data sheet and labeling purposes.',
    `ifra_prohibition_category` STRING COMMENT 'IFRA product category (1-11) in which the substance is prohibited or restricted, ranging from Category 1 (lip products) to Category 11 (non-skin contact products).',
    `ifra_standard_reference` STRING COMMENT 'Reference to the applicable IFRA Standard number and amendment that governs the use of this substance in fragrance compounds.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this restricted substance record was last updated or modified.',
    `last_review_date` DATE COMMENT 'Date on which the restricted substance record was last reviewed for regulatory updates, new restrictions, or changes in applicable law.',
    `maximum_permitted_concentration` DECIMAL(18,2) COMMENT 'Maximum allowable concentration of the substance in finished products, expressed as a percentage by weight or volume, as defined by applicable regulations.',
    `next_review_date` DATE COMMENT 'Date on which the next periodic review of this restricted substance record is scheduled to ensure ongoing compliance with evolving regulations.',
    `owning_team` STRING COMMENT 'Name of the internal team or department responsible for maintaining this restricted substance record (e.g., Regulatory Affairs, Product Safety, Quality Assurance).',
    `post_market_surveillance_required` BOOLEAN COMMENT 'Indicates whether ongoing post-market surveillance, adverse event reporting, or periodic safety updates are required for products containing this substance.',
    `primary_contact_email` STRING COMMENT 'Email address of the primary contact for regulatory inquiries and substance compliance questions.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `primary_contact_name` STRING COMMENT 'Full name of the individual responsible for regulatory compliance and updates related to this restricted substance.',
    `prop_65_listing` BOOLEAN COMMENT 'Indicates whether the substance is listed under California Proposition 65 as known to cause cancer, birth defects, or reproductive harm, requiring warning labels for California sales.',
    `reach_registration_number` STRING COMMENT 'Unique registration number assigned under EU REACH for substances manufactured or imported in quantities of one tonne or more per year.',
    `regulatory_authority` STRING COMMENT 'Name of the primary regulatory body or agency that issued the restriction (e.g., ECHA, FDA, EPA, CPSC, Health Canada).',
    `restriction_type` STRING COMMENT 'Classification of the regulatory restriction imposed on the substance: banned (prohibited entirely), concentration_limit (allowed below threshold), disclosure_required (must be declared on label), authorization_required (needs pre-approval), restricted_use (limited applications), conditional_approval (allowed under specific conditions).. Valid values are `banned|concentration_limit|disclosure_required|authorization_required|restricted_use|conditional_approval`',
    `rspo_compliance_flag` BOOLEAN COMMENT 'Indicates whether the substance (if palm-derived) meets RSPO certification requirements for sustainable sourcing.',
    `sds_required` BOOLEAN COMMENT 'Indicates whether a Safety Data Sheet (formerly MSDS) must be maintained and provided to downstream users for this substance.',
    `substance_name` STRING COMMENT 'Common or chemical name of the restricted substance as recognized in regulatory filings and industry practice.',
    `sunset_date` DATE COMMENT 'Date after which the use of the substance is prohibited unless a specific authorization has been granted, applicable primarily under REACH authorization provisions.',
    `svhc_status` BOOLEAN COMMENT 'Indicates whether the substance is identified as a Substance of Very High Concern under REACH, triggering additional authorization and notification obligations.',
    `tonnage_band` STRING COMMENT 'Annual production or import volume range in metric tonnes per year, used for REACH registration tier determination.. Valid values are `1_to_10|10_to_100|100_to_1000|above_1000|not_applicable`',
    CONSTRAINT pk_restricted_substance PRIMARY KEY(`restricted_substance_id`)
) COMMENT 'Master record for all chemicals, ingredients, and materials subject to prohibition, restriction, authorization, or disclosure under any applicable regulation worldwide. Captures substance name, CAS number, EC number, restriction type (banned, concentration limit, disclosure required, authorization required), applicable regulation(s), REACH registration number, tonnage band, SVHC status, authorization status, maximum permitted concentration, effective date, downstream user notification obligations, and affected product categories. SSOT for all regulated substance data including EU REACH, California Prop 65, FDA prohibited ingredients, EPA restricted chemicals, and FIFRA substances.';

CREATE OR REPLACE TABLE `consumer_goods_ecm`.`regulatory`.`regulatory_claim` (
    `regulatory_claim_id` BIGINT COMMENT 'Unique identifier for the regulatory claim record. Primary key.',
    `jurisdiction_id` BIGINT COMMENT 'Foreign key linking to regulatory.jurisdiction. Business justification: Regulatory claims are jurisdiction-specific — a claim approved in the EU may not be permitted in the US, and vice versa. The regulatory_claim table currently stores jurisdiction_code as a denormalized',
    `market_research_study_id` BIGINT COMMENT 'Foreign key linking to marketing.market_research_study. Business justification: Regulatory claims in consumer goods require substantiation studies (e.g., clinical trials, consumer perception studies supporting preferred by consumers claims). The existing plain-text supporting_',
    `product_brand_id` BIGINT COMMENT 'FK to product.product_brand',
    `registration_id` BIGINT COMMENT 'Foreign key linking to regulatory.regulatory_registration. Business justification: A regulatory claim (structure/function claim, health claim, efficacy claim) is approved under a specific regulatory registration or as part of the registration dossier. Linking regulatory_claim to reg',
    `sku_id` BIGINT COMMENT 'Identifier of the product to which this claim applies. Links to the product master record.',
    `adverse_event_reporting_required` BOOLEAN COMMENT 'Indicates whether adverse events related to the claim must be reported to regulatory authorities. True if reporting is required, False otherwise.',
    `approval_date` DATE COMMENT 'Date when the regulatory authority approved the claim for use. Null if not yet approved. Format: yyyy-MM-dd.',
    `approval_status` STRING COMMENT 'Regulatory authority approval status: not submitted (claim not yet filed), submitted (application filed), under review (being evaluated), approved (authorized for use), conditionally approved (approved with restrictions), denied (rejected), or appeal pending (denial being contested). [ENUM-REF-CANDIDATE: not_submitted|submitted|under_review|approved|conditionally_approved|denied|appeal_pending — 7 candidates stripped; promote to reference product]',
    `approved_markets` STRING COMMENT 'Comma-separated list of market codes or regions where the claim is approved for use (e.g., USA, EU, LATAM, APAC). Enables market-specific claim deployment.',
    `certification_number` STRING COMMENT 'Unique certification or registration number issued by the third-party certifying body. Null if no certification applies.',
    `cfr_reference` STRING COMMENT 'Specific CFR citation that governs the claim (e.g., 21 CFR 101.54 for health claims, 16 CFR Part 260 for environmental claims). Provides regulatory traceability.',
    `claim_number` STRING COMMENT 'Business identifier for the regulatory claim, formatted as RC- followed by 8 digits. Used for external reference and tracking.. Valid values are `^RC-[0-9]{8}$`',
    `claim_scope` STRING COMMENT 'Scope of the claim application: product-specific (applies to one SKU), brand-level (applies to all products under a brand), category-level (applies to a product category), or ingredient-specific (applies to products containing a specific ingredient).. Valid values are `product_specific|brand_level|category_level|ingredient_specific`',
    `claim_status` STRING COMMENT 'Current lifecycle status of the regulatory claim: draft (being prepared), pending review (submitted for approval), approved (authorized for use), rejected (denied by authority), expired (approval period ended), or withdrawn (voluntarily removed).. Valid values are `draft|pending_review|approved|rejected|expired|withdrawn`',
    `claim_text` STRING COMMENT 'Full text of the regulatory claim as it appears or will appear on product labels, packaging, or marketing materials. Must match approved wording exactly.',
    `claim_type` STRING COMMENT 'Category of regulatory claim: structure/function claims (e.g., strengthens hair), environmental claims (biodegradable, recyclable), organic/natural certifications, efficacy claims (clinically proven), safety claims, nutritional claims, or hypoallergenic claims. [ENUM-REF-CANDIDATE: structure_function|environmental|organic_natural|efficacy|safety|nutritional|hypoallergenic — 7 candidates stripped; promote to reference product]',
    `comments` STRING COMMENT 'Free-text field for additional notes, context, or special instructions related to the claim. May include reviewer comments, historical context, or implementation guidance.',
    `compliance_review_date` DATE COMMENT 'Date when the internal compliance review was completed. Format: yyyy-MM-dd.',
    `compliance_review_outcome` STRING COMMENT 'Result of internal FTC/FDA compliance review: compliant (meets all requirements), non-compliant (violates regulations), requires modification (needs changes before use), pending review (under evaluation), or not reviewed (not yet assessed).. Valid values are `compliant|non_compliant|requires_modification|pending_review|not_reviewed`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the regulatory claim record was first created in the system. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX. Supports audit trail and data lineage.',
    `disclaimer_required_flag` BOOLEAN COMMENT 'Indicates whether a disclaimer statement must accompany the claim on labels or marketing materials. True if disclaimer is required, False otherwise.',
    `disclaimer_text` STRING COMMENT 'Full text of the required disclaimer that must accompany the claim. Null if no disclaimer is required. Must be displayed in accordance with regulatory guidelines.',
    `effective_date` DATE COMMENT 'Date when the approved claim becomes valid for use on products and marketing materials. May differ from approval date due to implementation lead time. Format: yyyy-MM-dd.',
    `eu_regulation_reference` STRING COMMENT 'Specific EU regulation or directive that governs the claim (e.g., Regulation 1223/2009 for cosmetics, Regulation 1924/2006 for nutrition and health claims). Null if not applicable to EU markets.',
    `expiry_date` DATE COMMENT 'Date when the claim approval expires and can no longer be used unless renewed. Null for claims with indefinite approval. Format: yyyy-MM-dd.',
    `ifra_compliance_flag` BOOLEAN COMMENT 'Indicates whether the claim complies with IFRA standards for fragrance ingredients. True if compliant, False if not applicable or non-compliant. Relevant for cosmetics and personal care products.',
    `language_code` STRING COMMENT 'ISO 639-1 two-letter language code for the claim text (e.g., en for English, es for Spanish, fr for French). Supports multi-language claim management.. Valid values are `^[a-z]{2}$`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the regulatory claim record was last updated. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX. Supports change tracking and audit compliance.',
    `owning_team` STRING COMMENT 'Name of the internal team or department responsible for managing the claim (e.g., Regulatory Affairs, Product Development, Marketing). Supports accountability and workflow routing.',
    `post_market_surveillance_required` BOOLEAN COMMENT 'Indicates whether post-market surveillance or ongoing monitoring is required for the claim. True if surveillance is mandated, False otherwise.',
    `primary_contact_email` STRING COMMENT 'Email address of the primary contact person for the claim. Used for notifications and inquiries.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `primary_contact_name` STRING COMMENT 'Name of the primary contact person responsible for the claim. Typically a regulatory affairs specialist or product manager.',
    `product_category` STRING COMMENT 'High-level category of the product associated with the claim: cosmetics, personal care, household products, food, dietary supplements, over-the-counter (OTC) drugs, or medical devices. Determines applicable regulatory framework. [ENUM-REF-CANDIDATE: cosmetics|personal_care|household|food|dietary_supplement|otc_drug|medical_device — 7 candidates stripped; promote to reference product]',
    `regulatory_authority` STRING COMMENT 'Primary regulatory authority that reviewed or approved the claim: FDA (U.S. Food and Drug Administration), EPA (Environmental Protection Agency), CPSC (Consumer Product Safety Commission), EU Commission, EFSA (European Food Safety Authority), USDA (U.S. Department of Agriculture), FTC (Federal Trade Commission), Health Canada, TGA (Therapeutic Goods Administration - Australia), ANVISA (Brazil), or CFDA (China Food and Drug Administration). [ENUM-REF-CANDIDATE: FDA|EPA|CPSC|EU_COMMISSION|EFSA|USDA|FTC|HEALTH_CANADA|TGA|ANVISA|CFDA — 11 candidates stripped; promote to reference product]',
    `renewal_frequency_months` STRING COMMENT 'Number of months between required renewals for the claim. Null if no renewal is required. Common values: 12, 24, 36, 60.',
    `renewal_required_flag` BOOLEAN COMMENT 'Indicates whether the claim requires periodic renewal with the regulatory authority. True if renewal is required, False if approval is indefinite.',
    `sku` STRING COMMENT 'Stock Keeping Unit identifier for the specific product variant to which the claim applies. Enables SKU-level claim tracking.',
    `submission_date` DATE COMMENT 'Date when the claim was submitted to the regulatory authority for review. Format: yyyy-MM-dd.',
    `substantiation_method` STRING COMMENT 'Method used to substantiate the claim: clinical study (human trials), laboratory test (in vitro), consumer perception study, literature review, expert opinion, historical use documentation, or third-party certification. [ENUM-REF-CANDIDATE: clinical_study|laboratory_test|consumer_perception|literature_review|expert_opinion|historical_use|third_party_certification — 7 candidates stripped; promote to reference product]',
    `third_party_certification` STRING COMMENT 'Name of third-party certification body or seal that validates the claim (e.g., USDA Organic, Leaping Bunny, EcoCert, NSF, Rainforest Alliance). Null if no third-party certification applies.',
    `usage_restriction` STRING COMMENT 'Any restrictions or conditions on the use of the claim, such as required disclaimers, context limitations, or co-claim requirements. Free text field for detailed restriction documentation.',
    CONSTRAINT pk_regulatory_claim PRIMARY KEY(`regulatory_claim_id`)
) COMMENT 'Master record of approved and pending regulatory claims for products including structure/function claims, environmental claims (biodegradable, recyclable), organic/natural certifications, and efficacy claims. Captures claim text, claim type, substantiation method, supporting study references, regulatory authority approval status, approved markets, claim expiry date, and FTC/FDA compliance review outcome. Prevents unapproved claims from appearing on labels or marketing materials.';

CREATE OR REPLACE TABLE `consumer_goods_ecm`.`regulatory`.`sds_substance_composition` (
    `sds_substance_composition_id` BIGINT COMMENT 'Primary key for the sds_substance_composition association',
    `restricted_substance_id` BIGINT COMMENT 'Foreign key linking to the restricted substance master record that is disclosed as a hazardous component in this SDS.',
    `sds_id` BIGINT COMMENT 'Foreign key linking to the Safety Data Sheet in which this restricted substance is disclosed.',
    `concentration_in_product` DECIMAL(18,2) COMMENT 'The actual concentration (percentage by weight or volume) of this restricted substance in the specific product formulation covered by the linked SDS. This value is specific to the substance-SDS pairing and cannot reside on either master record alone.',
    `concentration_unit` STRING COMMENT 'Unit of measure for the concentration_in_product value (e.g., % w/w, ppm). Specific to this substance-SDS pairing as different SDS documents may express concentrations in different units.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this substance-SDS composition record was first created, supporting audit trail and revision history requirements under GHS and OSHA HazCom.',
    `disclosure_basis` STRING COMMENT 'The specific regulatory framework or requirement that mandates the disclosure of this substance in this SDS (e.g., REACH SVHC listing, Prop 65, OSHA HazCom threshold). A substance may be disclosed in one SDS under REACH and in another under Prop 65.',
    `exposure_limit_override` STRING COMMENT 'Any product-specific or jurisdiction-specific occupational exposure limit (OEL) that overrides the standard limit for this substance in the context of this specific SDS/formulation. Belongs to the relationship because the override is formulation-context-dependent.',
    `hazard_contribution_flag` BOOLEAN COMMENT 'Indicates whether this restricted substance is the primary contributor to the GHS hazard classification of the product covered by the linked SDS. This determination is specific to each substance-SDS pairing and cannot reside on either master record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this substance-SDS composition record was last updated, supporting SDS revision history and regulatory audit requirements.',
    `section_reference` STRING COMMENT 'The specific GHS SDS section number(s) where this restricted substance is disclosed or referenced (e.g., Section 3 for composition, Section 8 for exposure limits). Belongs to the relationship as the same substance may be referenced in different sections across different SDS documents.',
    CONSTRAINT pk_sds_substance_composition PRIMARY KEY(`sds_substance_composition_id`)
) COMMENT 'This association product represents the Hazardous Component Listing between a restricted_substance and an sds record. It captures the formal disclosure of a regulated substance within a specific Safety Data Sheet, as required by GHS Section 3 (Composition/Information on Ingredients), OSHA HazCom, and EU CLP. Each record links one restricted substance to one SDS and carries attributes that exist only in the context of that specific substance-SDS pairing: the concentration of the substance in that product formulation, any exposure limit overrides applicable to that combination, the SDS section where the substance is disclosed, and whether the substance is the primary hazard contributor for that SDS.. Existence Justification: In chemical safety management for consumer goods, a single restricted substance (e.g., formaldehyde, a phthalate) appears as a listed hazardous component in MULTIPLE Safety Data Sheets — one SDS per raw material, intermediate, or finished good that contains it. Conversely, a single SDS for a complex mixture (e.g., a fragrance blend or cleaning formulation) will list MULTIPLE restricted substances in its composition section (Section 3 of GHS SDS). Regulatory chemists actively manage this substance-SDS composition mapping as a formal business process — it is the Hazardous Component Listing or SDS Substance Composition record, with its own attributes (concentration in product, exposure limit overrides, section reference, hazard contribution flag) that belong to neither the substance master nor the SDS master alone.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`registration` ADD CONSTRAINT `fk_regulatory_registration_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `consumer_goods_ecm`.`regulatory`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`submission` ADD CONSTRAINT `fk_regulatory_submission_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `consumer_goods_ecm`.`regulatory`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`submission` ADD CONSTRAINT `fk_regulatory_submission_previous_submission_id` FOREIGN KEY (`previous_submission_id`) REFERENCES `consumer_goods_ecm`.`regulatory`.`submission`(`submission_id`);
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`submission` ADD CONSTRAINT `fk_regulatory_submission_registration_id` FOREIGN KEY (`registration_id`) REFERENCES `consumer_goods_ecm`.`regulatory`.`registration`(`registration_id`);
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`dossier` ADD CONSTRAINT `fk_regulatory_dossier_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `consumer_goods_ecm`.`regulatory`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`dossier` ADD CONSTRAINT `fk_regulatory_dossier_registration_id` FOREIGN KEY (`registration_id`) REFERENCES `consumer_goods_ecm`.`regulatory`.`registration`(`registration_id`);
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`dossier` ADD CONSTRAINT `fk_regulatory_dossier_submission_id` FOREIGN KEY (`submission_id`) REFERENCES `consumer_goods_ecm`.`regulatory`.`submission`(`submission_id`);
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`sds` ADD CONSTRAINT `fk_regulatory_sds_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `consumer_goods_ecm`.`regulatory`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`ingredient_list` ADD CONSTRAINT `fk_regulatory_ingredient_list_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `consumer_goods_ecm`.`regulatory`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`ingredient_list` ADD CONSTRAINT `fk_regulatory_ingredient_list_restricted_substance_id` FOREIGN KEY (`restricted_substance_id`) REFERENCES `consumer_goods_ecm`.`regulatory`.`restricted_substance`(`restricted_substance_id`);
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`label_version` ADD CONSTRAINT `fk_regulatory_label_version_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `consumer_goods_ecm`.`regulatory`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`label_version` ADD CONSTRAINT `fk_regulatory_label_version_previous_version_label_version_id` FOREIGN KEY (`previous_version_label_version_id`) REFERENCES `consumer_goods_ecm`.`regulatory`.`label_version`(`label_version_id`);
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`label_version` ADD CONSTRAINT `fk_regulatory_label_version_registration_id` FOREIGN KEY (`registration_id`) REFERENCES `consumer_goods_ecm`.`regulatory`.`registration`(`registration_id`);
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`label_version` ADD CONSTRAINT `fk_regulatory_label_version_regulatory_claim_id` FOREIGN KEY (`regulatory_claim_id`) REFERENCES `consumer_goods_ecm`.`regulatory`.`regulatory_claim`(`regulatory_claim_id`);
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`compliance_obligation` ADD CONSTRAINT `fk_regulatory_compliance_obligation_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `consumer_goods_ecm`.`regulatory`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`compliance_obligation` ADD CONSTRAINT `fk_regulatory_compliance_obligation_registration_id` FOREIGN KEY (`registration_id`) REFERENCES `consumer_goods_ecm`.`regulatory`.`registration`(`registration_id`);
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`compliance_assessment` ADD CONSTRAINT `fk_regulatory_compliance_assessment_compliance_obligation_id` FOREIGN KEY (`compliance_obligation_id`) REFERENCES `consumer_goods_ecm`.`regulatory`.`compliance_obligation`(`compliance_obligation_id`);
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`compliance_assessment` ADD CONSTRAINT `fk_regulatory_compliance_assessment_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `consumer_goods_ecm`.`regulatory`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`compliance_assessment` ADD CONSTRAINT `fk_regulatory_compliance_assessment_registration_id` FOREIGN KEY (`registration_id`) REFERENCES `consumer_goods_ecm`.`regulatory`.`registration`(`registration_id`);
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`product_recall` ADD CONSTRAINT `fk_regulatory_product_recall_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `consumer_goods_ecm`.`regulatory`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`product_recall` ADD CONSTRAINT `fk_regulatory_product_recall_registration_id` FOREIGN KEY (`registration_id`) REFERENCES `consumer_goods_ecm`.`regulatory`.`registration`(`registration_id`);
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`product_recall` ADD CONSTRAINT `fk_regulatory_product_recall_submission_id` FOREIGN KEY (`submission_id`) REFERENCES `consumer_goods_ecm`.`regulatory`.`submission`(`submission_id`);
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`jurisdiction` ADD CONSTRAINT `fk_regulatory_jurisdiction_parent_jurisdiction_id` FOREIGN KEY (`parent_jurisdiction_id`) REFERENCES `consumer_goods_ecm`.`regulatory`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`restricted_substance` ADD CONSTRAINT `fk_regulatory_restricted_substance_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `consumer_goods_ecm`.`regulatory`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`regulatory_claim` ADD CONSTRAINT `fk_regulatory_regulatory_claim_jurisdiction_id` FOREIGN KEY (`jurisdiction_id`) REFERENCES `consumer_goods_ecm`.`regulatory`.`jurisdiction`(`jurisdiction_id`);
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`regulatory_claim` ADD CONSTRAINT `fk_regulatory_regulatory_claim_registration_id` FOREIGN KEY (`registration_id`) REFERENCES `consumer_goods_ecm`.`regulatory`.`registration`(`registration_id`);
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`sds_substance_composition` ADD CONSTRAINT `fk_regulatory_sds_substance_composition_restricted_substance_id` FOREIGN KEY (`restricted_substance_id`) REFERENCES `consumer_goods_ecm`.`regulatory`.`restricted_substance`(`restricted_substance_id`);
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`sds_substance_composition` ADD CONSTRAINT `fk_regulatory_sds_substance_composition_sds_id` FOREIGN KEY (`sds_id`) REFERENCES `consumer_goods_ecm`.`regulatory`.`sds`(`sds_id`);

-- ========= TAGS =========
ALTER SCHEMA `consumer_goods_ecm`.`regulatory` SET TAGS ('dbx_division' = 'corporate');
ALTER SCHEMA `consumer_goods_ecm`.`regulatory` SET TAGS ('dbx_domain' = 'regulatory');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`registration` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`registration` SET TAGS ('dbx_subdomain' = 'submission_registration');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`registration` ALTER COLUMN `registration_id` SET TAGS ('dbx_business_glossary_term' = 'Registration Identifier');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`registration` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`registration` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`registration` ALTER COLUMN `manufacturing_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Facility Identifier');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`registration` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`registration` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Product Identifier');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`registration` ALTER COLUMN `active_ingredients` SET TAGS ('dbx_business_glossary_term' = 'Active Ingredients');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`registration` ALTER COLUMN `annual_report_due_date` SET TAGS ('dbx_business_glossary_term' = 'Annual Report Due Date');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`registration` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`registration` ALTER COLUMN `cfr_citation` SET TAGS ('dbx_business_glossary_term' = 'Code of Federal Regulations (CFR) Citation');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`registration` ALTER COLUMN `cpsc_tracking_label_required` SET TAGS ('dbx_business_glossary_term' = 'Consumer Product Safety Commission (CPSC) Tracking Label Required');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`registration` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`registration` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`registration` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`registration` ALTER COLUMN `fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Registration Fee Amount');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`registration` ALTER COLUMN `fee_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`registration` ALTER COLUMN `fee_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Registration Fee Currency Code');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`registration` ALTER COLUMN `fee_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`registration` ALTER COLUMN `gmp_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Good Manufacturing Practice (GMP) Compliance Flag');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`registration` ALTER COLUMN `holder_address` SET TAGS ('dbx_business_glossary_term' = 'Registration Holder Address');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`registration` ALTER COLUMN `holder_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`registration` ALTER COLUMN `holder_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`registration` ALTER COLUMN `holder_name` SET TAGS ('dbx_business_glossary_term' = 'Registration Holder Name');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`registration` ALTER COLUMN `holder_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`registration` ALTER COLUMN `ifra_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'International Fragrance Association (IFRA) Compliance Flag');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`registration` ALTER COLUMN `label_approval_number` SET TAGS ('dbx_business_glossary_term' = 'Label Approval Number');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`registration` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`registration` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`registration` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Registration Notes');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`registration` ALTER COLUMN `post_market_surveillance_required` SET TAGS ('dbx_business_glossary_term' = 'Post-Market Surveillance Required');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`registration` ALTER COLUMN `product_scope` SET TAGS ('dbx_business_glossary_term' = 'Product Scope');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`registration` ALTER COLUMN `reach_registration_number` SET TAGS ('dbx_business_glossary_term' = 'Registration Evaluation Authorization and Restriction of Chemicals (REACH) Registration Number');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`registration` ALTER COLUMN `registering_authority` SET TAGS ('dbx_business_glossary_term' = 'Registering Authority');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`registration` ALTER COLUMN `registration_category` SET TAGS ('dbx_business_glossary_term' = 'Registration Category');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`registration` ALTER COLUMN `registration_number` SET TAGS ('dbx_business_glossary_term' = 'Registration Number');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`registration` ALTER COLUMN `registration_status` SET TAGS ('dbx_business_glossary_term' = 'Registration Status');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`registration` ALTER COLUMN `registration_type` SET TAGS ('dbx_business_glossary_term' = 'Registration Type');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`registration` ALTER COLUMN `registration_type` SET TAGS ('dbx_value_regex' = 'new|renewal|amendment|cancellation|variation|transfer');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`registration` ALTER COLUMN `regulatory_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Contact Email Address');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`registration` ALTER COLUMN `regulatory_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`registration` ALTER COLUMN `regulatory_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`registration` ALTER COLUMN `regulatory_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`registration` ALTER COLUMN `regulatory_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Contact Name');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`registration` ALTER COLUMN `regulatory_contact_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`registration` ALTER COLUMN `regulatory_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Contact Phone Number');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`registration` ALTER COLUMN `regulatory_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`registration` ALTER COLUMN `regulatory_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`registration` ALTER COLUMN `renewal_due_date` SET TAGS ('dbx_business_glossary_term' = 'Renewal Due Date');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`registration` ALTER COLUMN `sds_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Safety Data Sheet (SDS) Document Reference');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`registration` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`registration` ALTER COLUMN `submission_date` SET TAGS ('dbx_business_glossary_term' = 'Submission Date');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`registration` ALTER COLUMN `submission_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Submission Reference Number');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`registration` ALTER COLUMN `use_classification` SET TAGS ('dbx_business_glossary_term' = 'Use Classification');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`submission` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`submission` SET TAGS ('dbx_subdomain' = 'submission_registration');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`submission` ALTER COLUMN `submission_id` SET TAGS ('dbx_business_glossary_term' = 'Submission Identifier (ID)');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`submission` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`submission` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`submission` ALTER COLUMN `previous_submission_id` SET TAGS ('dbx_business_glossary_term' = 'Previous Submission Identifier (ID)');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`submission` ALTER COLUMN `registration_id` SET TAGS ('dbx_business_glossary_term' = 'Registration Identifier (ID)');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`submission` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Product Identifier (ID)');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`submission` ALTER COLUMN `actual_decision_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Decision Date');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`submission` ALTER COLUMN `channel` SET TAGS ('dbx_business_glossary_term' = 'Submission Channel');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`submission` ALTER COLUMN `channel` SET TAGS ('dbx_value_regex' = 'electronic|paper|portal|edi');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`submission` ALTER COLUMN `contact_person_email` SET TAGS ('dbx_business_glossary_term' = 'Contact Person Email Address');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`submission` ALTER COLUMN `contact_person_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`submission` ALTER COLUMN `contact_person_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`submission` ALTER COLUMN `contact_person_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`submission` ALTER COLUMN `contact_person_name` SET TAGS ('dbx_business_glossary_term' = 'Contact Person Name');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`submission` ALTER COLUMN `contact_person_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`submission` ALTER COLUMN `contact_person_phone` SET TAGS ('dbx_business_glossary_term' = 'Contact Person Phone Number');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`submission` ALTER COLUMN `contact_person_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`submission` ALTER COLUMN `contact_person_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`submission` ALTER COLUMN `corrective_action_description` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Description');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`submission` ALTER COLUMN `corrective_action_required` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Required Flag');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`submission` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`submission` ALTER COLUMN `decision_outcome` SET TAGS ('dbx_business_glossary_term' = 'Decision Outcome');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`submission` ALTER COLUMN `decision_outcome` SET TAGS ('dbx_value_regex' = 'approved|approved_with_conditions|rejected|withdrawn|pending');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`submission` ALTER COLUMN `dossier_reference` SET TAGS ('dbx_business_glossary_term' = 'Dossier Reference');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`submission` ALTER COLUMN `fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Fee Amount');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`submission` ALTER COLUMN `fee_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Fee Currency Code');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`submission` ALTER COLUMN `fee_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`submission` ALTER COLUMN `fee_payment_status` SET TAGS ('dbx_business_glossary_term' = 'Fee Payment Status');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`submission` ALTER COLUMN `fee_payment_status` SET TAGS ('dbx_value_regex' = 'paid|pending|waived|refunded');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`submission` ALTER COLUMN `hazard_description` SET TAGS ('dbx_business_glossary_term' = 'Hazard Description');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`submission` ALTER COLUMN `hazard_description` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`submission` ALTER COLUMN `incident_date` SET TAGS ('dbx_business_glossary_term' = 'Incident Date');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`submission` ALTER COLUMN `language` SET TAGS ('dbx_business_glossary_term' = 'Submission Language');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`submission` ALTER COLUMN `language` SET TAGS ('dbx_value_regex' = '^[a-z]{2}$');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`submission` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`submission` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`submission` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Submission Notes');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`submission` ALTER COLUMN `population_at_risk` SET TAGS ('dbx_business_glossary_term' = 'Population at Risk');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`submission` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Submission Priority');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`submission` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'expedited|standard|routine');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`submission` ALTER COLUMN `regulatory_authority` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Authority');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`submission` ALTER COLUMN `severity_level` SET TAGS ('dbx_business_glossary_term' = 'Severity Level');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`submission` ALTER COLUMN `severity_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`submission` ALTER COLUMN `submission_date` SET TAGS ('dbx_business_glossary_term' = 'Submission Date');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`submission` ALTER COLUMN `submission_number` SET TAGS ('dbx_business_glossary_term' = 'Submission Number');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`submission` ALTER COLUMN `submission_status` SET TAGS ('dbx_business_glossary_term' = 'Submission Status');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`submission` ALTER COLUMN `submission_type` SET TAGS ('dbx_business_glossary_term' = 'Submission Type');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`submission` ALTER COLUMN `supporting_document_count` SET TAGS ('dbx_business_glossary_term' = 'Supporting Document Count');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`submission` ALTER COLUMN `target_decision_date` SET TAGS ('dbx_business_glossary_term' = 'Target Decision Date');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`submission` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Submission Version');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`submission` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`dossier` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`dossier` SET TAGS ('dbx_subdomain' = 'submission_registration');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`dossier` ALTER COLUMN `dossier_id` SET TAGS ('dbx_business_glossary_term' = 'Dossier Identifier (ID)');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`dossier` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`dossier` ALTER COLUMN `registration_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Registration Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`dossier` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Product Identifier (ID)');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`dossier` ALTER COLUMN `submission_id` SET TAGS ('dbx_business_glossary_term' = 'Submission Identifier (ID)');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`dossier` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`dossier` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`dossier` ALTER COLUMN `approved_by` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`dossier` ALTER COLUMN `cfr_reference` SET TAGS ('dbx_business_glossary_term' = 'Code of Federal Regulations (CFR) Reference');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`dossier` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`dossier` ALTER COLUMN `compilation_date` SET TAGS ('dbx_business_glossary_term' = 'Compilation Date');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`dossier` ALTER COLUMN `completeness_percentage` SET TAGS ('dbx_business_glossary_term' = 'Completeness Percentage');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`dossier` ALTER COLUMN `completeness_status` SET TAGS ('dbx_business_glossary_term' = 'Completeness Status');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`dossier` ALTER COLUMN `completeness_status` SET TAGS ('dbx_value_regex' = 'incomplete|substantially_complete|complete|verified');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`dossier` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Level');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`dossier` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_value_regex' = 'public|internal|confidential|restricted');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`dossier` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`dossier` ALTER COLUMN `document_count` SET TAGS ('dbx_business_glossary_term' = 'Document Count');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`dossier` ALTER COLUMN `dossier_number` SET TAGS ('dbx_business_glossary_term' = 'Dossier Number');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`dossier` ALTER COLUMN `dossier_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`dossier` ALTER COLUMN `dossier_status` SET TAGS ('dbx_business_glossary_term' = 'Dossier Status');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`dossier` ALTER COLUMN `dossier_status` SET TAGS ('dbx_value_regex' = 'draft|in_compilation|under_review|complete|submitted|archived');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`dossier` ALTER COLUMN `dossier_type` SET TAGS ('dbx_business_glossary_term' = 'Dossier Type');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`dossier` ALTER COLUMN `dossier_type` SET TAGS ('dbx_value_regex' = 'CTD|eCTD|IECIC|CPNP|FDA_510K|EPA_FIFRA');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`dossier` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`dossier` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`dossier` ALTER COLUMN `gmp_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Good Manufacturing Practice (GMP) Compliance Flag');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`dossier` ALTER COLUMN `ifra_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'International Fragrance Association (IFRA) Compliance Flag');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`dossier` ALTER COLUMN `ingredient_declaration_included` SET TAGS ('dbx_business_glossary_term' = 'Ingredient Declaration Included Flag');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`dossier` ALTER COLUMN `language_code` SET TAGS ('dbx_business_glossary_term' = 'Language Code');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`dossier` ALTER COLUMN `language_code` SET TAGS ('dbx_value_regex' = '^[a-z]{2}(-[A-Z]{2})?$');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`dossier` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`dossier` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`dossier` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`dossier` ALTER COLUMN `owning_team` SET TAGS ('dbx_business_glossary_term' = 'Owning Regulatory Affairs Team');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`dossier` ALTER COLUMN `post_market_surveillance_included` SET TAGS ('dbx_business_glossary_term' = 'Post-Market Surveillance Included Flag');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`dossier` ALTER COLUMN `reach_registration_number` SET TAGS ('dbx_business_glossary_term' = 'Registration Evaluation Authorization and Restriction of Chemicals (REACH) Registration Number');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`dossier` ALTER COLUMN `reach_registration_number` SET TAGS ('dbx_value_regex' = '^[0-9]{2}-[0-9]{10}-[0-9]{2}-[0-9]{4}$');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`dossier` ALTER COLUMN `regulatory_authority` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Authority');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`dossier` ALTER COLUMN `regulatory_category` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Category');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`dossier` ALTER COLUMN `safety_assessment_included` SET TAGS ('dbx_business_glossary_term' = 'Safety Assessment Included Flag');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`dossier` ALTER COLUMN `sds_included` SET TAGS ('dbx_business_glossary_term' = 'Safety Data Sheet (SDS) Included Flag');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`dossier` ALTER COLUMN `vault_folder_path` SET TAGS ('dbx_business_glossary_term' = 'Veeva Vault Folder Path');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`dossier` ALTER COLUMN `vault_reference_code` SET TAGS ('dbx_business_glossary_term' = 'Veeva Vault Reference Identifier (ID)');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`dossier` ALTER COLUMN `vault_reference_code` SET TAGS ('dbx_value_regex' = '^VV[A-Z0-9]{10,30}$');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`dossier` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`dossier` ALTER COLUMN `version_number` SET TAGS ('dbx_value_regex' = '^[0-9]{1,3}.[0-9]{1,3}(.[0-9]{1,3})?$');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`sds` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`sds` SET TAGS ('dbx_subdomain' = 'product_labeling');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`sds` ALTER COLUMN `sds_id` SET TAGS ('dbx_business_glossary_term' = 'Safety Data Sheet (SDS) ID');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`sds` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`sds` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Material ID');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`sds` ALTER COLUMN `accidental_release_measures` SET TAGS ('dbx_business_glossary_term' = 'Accidental Release Measures');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`sds` ALTER COLUMN `appearance` SET TAGS ('dbx_business_glossary_term' = 'Appearance');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`sds` ALTER COLUMN `authoring_chemist` SET TAGS ('dbx_business_glossary_term' = 'Authoring Chemist');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`sds` ALTER COLUMN `authoring_chemist` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`sds` ALTER COLUMN `autoignition_temperature` SET TAGS ('dbx_business_glossary_term' = 'Autoignition Temperature');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`sds` ALTER COLUMN `cas_number` SET TAGS ('dbx_business_glossary_term' = 'Chemical Abstracts Service (CAS) Number');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`sds` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`sds` ALTER COLUMN `disposal_considerations` SET TAGS ('dbx_business_glossary_term' = 'Disposal Considerations');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`sds` ALTER COLUMN `document_type` SET TAGS ('dbx_business_glossary_term' = 'Document Type');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`sds` ALTER COLUMN `document_type` SET TAGS ('dbx_value_regex' = 'sds|msds|extended_sds');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`sds` ALTER COLUMN `document_url` SET TAGS ('dbx_business_glossary_term' = 'Document URL');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`sds` ALTER COLUMN `ecological_information` SET TAGS ('dbx_business_glossary_term' = 'Ecological Information');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`sds` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`sds` ALTER COLUMN `emergency_phone_number` SET TAGS ('dbx_business_glossary_term' = 'Emergency Phone Number');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`sds` ALTER COLUMN `emergency_phone_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`sds` ALTER COLUMN `emergency_phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`sds` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`sds` ALTER COLUMN `exposure_limits` SET TAGS ('dbx_business_glossary_term' = 'Exposure Limits');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`sds` ALTER COLUMN `firefighting_measures` SET TAGS ('dbx_business_glossary_term' = 'Firefighting Measures');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`sds` ALTER COLUMN `first_aid_measures` SET TAGS ('dbx_business_glossary_term' = 'First Aid Measures');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`sds` ALTER COLUMN `flash_point` SET TAGS ('dbx_business_glossary_term' = 'Flash Point');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`sds` ALTER COLUMN `ghs_classification` SET TAGS ('dbx_business_glossary_term' = 'Globally Harmonized System (GHS) Classification');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`sds` ALTER COLUMN `handling_precautions` SET TAGS ('dbx_business_glossary_term' = 'Handling Precautions');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`sds` ALTER COLUMN `hazard_statements` SET TAGS ('dbx_business_glossary_term' = 'Hazard Statements');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`sds` ALTER COLUMN `hazardous_decomposition_products` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Decomposition Products');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`sds` ALTER COLUMN `incompatible_materials` SET TAGS ('dbx_business_glossary_term' = 'Incompatible Materials');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`sds` ALTER COLUMN `issue_date` SET TAGS ('dbx_business_glossary_term' = 'Issue Date');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`sds` ALTER COLUMN `language_code` SET TAGS ('dbx_business_glossary_term' = 'Language Code');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`sds` ALTER COLUMN `manufacturer_address` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Address');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`sds` ALTER COLUMN `manufacturer_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`sds` ALTER COLUMN `manufacturer_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`sds` ALTER COLUMN `manufacturer_name` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Name');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`sds` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`sds` ALTER COLUMN `odor` SET TAGS ('dbx_business_glossary_term' = 'Odor');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`sds` ALTER COLUMN `packing_group` SET TAGS ('dbx_business_glossary_term' = 'Packing Group');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`sds` ALTER COLUMN `packing_group` SET TAGS ('dbx_value_regex' = 'I|II|III');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`sds` ALTER COLUMN `personal_protective_equipment` SET TAGS ('dbx_business_glossary_term' = 'Personal Protective Equipment (PPE)');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`sds` ALTER COLUMN `ph_value` SET TAGS ('dbx_business_glossary_term' = 'pH Value');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`sds` ALTER COLUMN `physical_state` SET TAGS ('dbx_business_glossary_term' = 'Physical State');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`sds` ALTER COLUMN `physical_state` SET TAGS ('dbx_value_regex' = 'solid|liquid|gas|aerosol|paste|gel');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`sds` ALTER COLUMN `pictograms` SET TAGS ('dbx_business_glossary_term' = 'GHS Pictograms');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`sds` ALTER COLUMN `precautionary_statements` SET TAGS ('dbx_business_glossary_term' = 'Precautionary Statements');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`sds` ALTER COLUMN `product_code` SET TAGS ('dbx_business_glossary_term' = 'Product Code');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`sds` ALTER COLUMN `product_name` SET TAGS ('dbx_business_glossary_term' = 'Product Name');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`sds` ALTER COLUMN `proper_shipping_name` SET TAGS ('dbx_business_glossary_term' = 'Proper Shipping Name');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`sds` ALTER COLUMN `regulatory_information` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Information');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`sds` ALTER COLUMN `revision_date` SET TAGS ('dbx_business_glossary_term' = 'Revision Date');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`sds` ALTER COLUMN `sds_number` SET TAGS ('dbx_business_glossary_term' = 'Safety Data Sheet (SDS) Number');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`sds` ALTER COLUMN `sds_status` SET TAGS ('dbx_business_glossary_term' = 'Safety Data Sheet (SDS) Status');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`sds` ALTER COLUMN `sds_status` SET TAGS ('dbx_value_regex' = 'draft|under_review|approved|active|superseded|archived');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`sds` ALTER COLUMN `signal_word` SET TAGS ('dbx_business_glossary_term' = 'GHS Signal Word');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`sds` ALTER COLUMN `signal_word` SET TAGS ('dbx_value_regex' = 'danger|warning|none');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`sds` ALTER COLUMN `stability` SET TAGS ('dbx_business_glossary_term' = 'Stability');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`sds` ALTER COLUMN `storage_conditions` SET TAGS ('dbx_business_glossary_term' = 'Storage Conditions');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`sds` ALTER COLUMN `toxicological_information` SET TAGS ('dbx_business_glossary_term' = 'Toxicological Information');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`sds` ALTER COLUMN `transport_hazard_class` SET TAGS ('dbx_business_glossary_term' = 'Transport Hazard Class');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`sds` ALTER COLUMN `un_number` SET TAGS ('dbx_business_glossary_term' = 'United Nations (UN) Number');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`sds` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`ingredient_list` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`ingredient_list` SET TAGS ('dbx_subdomain' = 'product_labeling');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`ingredient_list` ALTER COLUMN `ingredient_list_id` SET TAGS ('dbx_business_glossary_term' = 'Ingredient List Identifier');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`ingredient_list` ALTER COLUMN `formulation_id` SET TAGS ('dbx_business_glossary_term' = 'Formulation ID');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`ingredient_list` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`ingredient_list` ALTER COLUMN `restricted_substance_id` SET TAGS ('dbx_business_glossary_term' = 'Restricted Substance Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`ingredient_list` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Product ID');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`ingredient_list` ALTER COLUMN `allergen_flag` SET TAGS ('dbx_business_glossary_term' = 'Allergen Flag');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`ingredient_list` ALTER COLUMN `allergen_type` SET TAGS ('dbx_business_glossary_term' = 'Allergen Type Classification');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`ingredient_list` ALTER COLUMN `allergen_type` SET TAGS ('dbx_value_regex' = 'fragrance_allergen|preservative_allergen|colorant_allergen|botanical_allergen|protein_allergen|other');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`ingredient_list` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By User');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`ingredient_list` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`ingredient_list` ALTER COLUMN `cas_number` SET TAGS ('dbx_business_glossary_term' = 'Chemical Abstracts Service (CAS) Registry Number');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`ingredient_list` ALTER COLUMN `cas_number` SET TAGS ('dbx_value_regex' = '^[1-9][0-9]{1,6}-[0-9]{2}-[0-9]$');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`ingredient_list` ALTER COLUMN `common_name` SET TAGS ('dbx_business_glossary_term' = 'Ingredient Common Name');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`ingredient_list` ALTER COLUMN `concentration_max_percent` SET TAGS ('dbx_business_glossary_term' = 'Maximum Concentration Percentage');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`ingredient_list` ALTER COLUMN `concentration_max_percent` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`ingredient_list` ALTER COLUMN `concentration_min_percent` SET TAGS ('dbx_business_glossary_term' = 'Minimum Concentration Percentage');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`ingredient_list` ALTER COLUMN `concentration_min_percent` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`ingredient_list` ALTER COLUMN `concentration_typical_percent` SET TAGS ('dbx_business_glossary_term' = 'Typical Concentration Percentage');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`ingredient_list` ALTER COLUMN `concentration_typical_percent` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`ingredient_list` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`ingredient_list` ALTER COLUMN `declaration_name_override` SET TAGS ('dbx_business_glossary_term' = 'Declaration Name Override');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`ingredient_list` ALTER COLUMN `declaration_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Label Declaration Required Flag');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`ingredient_list` ALTER COLUMN `declaration_status` SET TAGS ('dbx_business_glossary_term' = 'Declaration Record Status');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`ingredient_list` ALTER COLUMN `declaration_status` SET TAGS ('dbx_value_regex' = 'draft|pending_review|approved|active|superseded|retired');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`ingredient_list` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Declaration Effective Date');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`ingredient_list` ALTER COLUMN `einecs_number` SET TAGS ('dbx_business_glossary_term' = 'European Inventory of Existing Commercial Chemical Substances (EINECS) Number');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`ingredient_list` ALTER COLUMN `einecs_number` SET TAGS ('dbx_value_regex' = '^[0-9]{3}-[0-9]{3}-[0-9]$');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`ingredient_list` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Declaration Expiration Date');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`ingredient_list` ALTER COLUMN `fda_status` SET TAGS ('dbx_business_glossary_term' = 'Food and Drug Administration (FDA) Regulatory Status');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`ingredient_list` ALTER COLUMN `fda_status` SET TAGS ('dbx_value_regex' = 'gras|food_additive|color_additive|otc_monograph|new_dietary_ingredient|not_approved');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`ingredient_list` ALTER COLUMN `ifra_amendment_number` SET TAGS ('dbx_business_glossary_term' = 'International Fragrance Association (IFRA) Amendment Number');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`ingredient_list` ALTER COLUMN `ifra_restricted_flag` SET TAGS ('dbx_business_glossary_term' = 'International Fragrance Association (IFRA) Restricted Flag');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`ingredient_list` ALTER COLUMN `inci_name` SET TAGS ('dbx_business_glossary_term' = 'International Nomenclature of Cosmetic Ingredients (INCI) Name');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`ingredient_list` ALTER COLUMN `ingredient_function` SET TAGS ('dbx_business_glossary_term' = 'Ingredient Functional Category');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`ingredient_list` ALTER COLUMN `ingredient_sequence` SET TAGS ('dbx_business_glossary_term' = 'Ingredient Declaration Sequence');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`ingredient_list` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`ingredient_list` ALTER COLUMN `nanomaterial_flag` SET TAGS ('dbx_business_glossary_term' = 'Nanomaterial Flag');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`ingredient_list` ALTER COLUMN `natural_origin_flag` SET TAGS ('dbx_business_glossary_term' = 'Natural Origin Flag');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`ingredient_list` ALTER COLUMN `organic_certified_flag` SET TAGS ('dbx_business_glossary_term' = 'Organic Certified Flag');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`ingredient_list` ALTER COLUMN `palm_oil_derivative_flag` SET TAGS ('dbx_business_glossary_term' = 'Palm Oil Derivative Flag');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`ingredient_list` ALTER COLUMN `reach_registration_number` SET TAGS ('dbx_business_glossary_term' = 'Registration Evaluation Authorization and Restriction of Chemicals (REACH) Registration Number');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`ingredient_list` ALTER COLUMN `rspo_certified_flag` SET TAGS ('dbx_business_glossary_term' = 'Roundtable on Sustainable Palm Oil (RSPO) Certified Flag');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`ingredient_list` ALTER COLUMN `sds_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Safety Data Sheet (SDS) Reference Number');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`ingredient_list` ALTER COLUMN `source_record_reference` SET TAGS ('dbx_business_glossary_term' = 'Source System Record ID');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`ingredient_list` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System Identifier');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`ingredient_list` ALTER COLUMN `vegan_flag` SET TAGS ('dbx_business_glossary_term' = 'Vegan Flag');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`label_version` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`label_version` SET TAGS ('dbx_subdomain' = 'product_labeling');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`label_version` ALTER COLUMN `label_version_id` SET TAGS ('dbx_business_glossary_term' = 'Label Version Identifier (ID)');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`label_version` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`label_version` ALTER COLUMN `previous_version_label_version_id` SET TAGS ('dbx_business_glossary_term' = 'Previous Label Version Identifier (ID)');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`label_version` ALTER COLUMN `registration_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Registration Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`label_version` ALTER COLUMN `regulatory_claim_id` SET TAGS ('dbx_business_glossary_term' = 'Label Claim Assignment - Regulatory Claim Id');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`label_version` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) Identifier (ID)');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`label_version` ALTER COLUMN `allergen_declarations` SET TAGS ('dbx_business_glossary_term' = 'Allergen Declaration Statements');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`label_version` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Date');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`label_version` ALTER COLUMN `approval_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Expiry Date');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`label_version` ALTER COLUMN `approval_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Approval Reference Number');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`label_version` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Assignment Approval Status');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`label_version` ALTER COLUMN `approving_authority` SET TAGS ('dbx_business_glossary_term' = 'Approving Regulatory Authority');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`label_version` ALTER COLUMN `artwork_checksum` SET TAGS ('dbx_business_glossary_term' = 'Artwork File Checksum');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`label_version` ALTER COLUMN `artwork_checksum` SET TAGS ('dbx_value_regex' = '^[a-fA-F0-9]{64}$');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`label_version` ALTER COLUMN `artwork_file_name` SET TAGS ('dbx_business_glossary_term' = 'Label Artwork File Name');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`label_version` ALTER COLUMN `barcode_type` SET TAGS ('dbx_business_glossary_term' = 'Barcode Type');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`label_version` ALTER COLUMN `barcode_type` SET TAGS ('dbx_value_regex' = 'UPC|EAN|GTIN|QR|DataMatrix|Code128');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`label_version` ALTER COLUMN `barcode_value` SET TAGS ('dbx_business_glossary_term' = 'Barcode Value');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`label_version` ALTER COLUMN `brand_name` SET TAGS ('dbx_business_glossary_term' = 'Brand Name');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`label_version` ALTER COLUMN `certification_marks` SET TAGS ('dbx_business_glossary_term' = 'Certification and Compliance Marks');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`label_version` ALTER COLUMN `change_reason` SET TAGS ('dbx_business_glossary_term' = 'Version Change Reason');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`label_version` ALTER COLUMN `contact_information` SET TAGS ('dbx_business_glossary_term' = 'Consumer Contact Information');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`label_version` ALTER COLUMN `contact_information` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`label_version` ALTER COLUMN `contact_information` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`label_version` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_business_glossary_term' = 'Country of Origin');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`label_version` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`label_version` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`label_version` ALTER COLUMN `distributor_name` SET TAGS ('dbx_business_glossary_term' = 'Distributor Name on Label');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`label_version` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Claim Assignment Effective Date');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`label_version` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Label Effective End Date');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`label_version` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Label Effective Start Date');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`label_version` ALTER COLUMN `expiry_date_format` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date Format Specification');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`label_version` ALTER COLUMN `ingredient_list` SET TAGS ('dbx_business_glossary_term' = 'Ingredient List Declaration');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`label_version` ALTER COLUMN `is_current_version` SET TAGS ('dbx_business_glossary_term' = 'Is Current Version Flag');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`label_version` ALTER COLUMN `label_claims` SET TAGS ('dbx_business_glossary_term' = 'Label Claims and Marketing Statements');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`label_version` ALTER COLUMN `label_type` SET TAGS ('dbx_business_glossary_term' = 'Label Type Classification');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`label_version` ALTER COLUMN `label_type` SET TAGS ('dbx_value_regex' = 'primary|secondary|shipper|pallet|promotional|sample');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`label_version` ALTER COLUMN `language_code` SET TAGS ('dbx_business_glossary_term' = 'Label Language Code');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`label_version` ALTER COLUMN `language_code` SET TAGS ('dbx_value_regex' = '^[a-z]{2}(-[A-Z]{2})?$');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`label_version` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified By User');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`label_version` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`label_version` ALTER COLUMN `lot_code_format` SET TAGS ('dbx_business_glossary_term' = 'Lot Code Format Specification');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`label_version` ALTER COLUMN `manufacturer_address` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Address on Label');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`label_version` ALTER COLUMN `manufacturer_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`label_version` ALTER COLUMN `manufacturer_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`label_version` ALTER COLUMN `manufacturer_name` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Name on Label');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`label_version` ALTER COLUMN `market_country_code` SET TAGS ('dbx_business_glossary_term' = 'Market Country Code');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`label_version` ALTER COLUMN `net_content_declaration` SET TAGS ('dbx_business_glossary_term' = 'Net Content Declaration Statement');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`label_version` ALTER COLUMN `net_content_quantity` SET TAGS ('dbx_business_glossary_term' = 'Net Content Quantity');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`label_version` ALTER COLUMN `net_content_unit` SET TAGS ('dbx_business_glossary_term' = 'Net Content Unit of Measure');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`label_version` ALTER COLUMN `product_name_on_label` SET TAGS ('dbx_business_glossary_term' = 'Product Name on Label');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`label_version` ALTER COLUMN `recycling_symbols` SET TAGS ('dbx_business_glossary_term' = 'Recycling and Sustainability Symbols');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`label_version` ALTER COLUMN `regulatory_approval_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Status');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`label_version` ALTER COLUMN `veeva_vault_document_code` SET TAGS ('dbx_business_glossary_term' = 'Veeva Vault Document Identifier (ID)');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`label_version` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Label Version Number');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`label_version` ALTER COLUMN `version_number` SET TAGS ('dbx_value_regex' = '^[0-9]+.[0-9]+(.[0-9]+)?$');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`label_version` ALTER COLUMN `warning_statements` SET TAGS ('dbx_business_glossary_term' = 'Warning and Precautionary Statements');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`label_version` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Created By User');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`compliance_obligation` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`compliance_obligation` SET TAGS ('dbx_subdomain' = 'compliance_assessment');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`compliance_obligation` ALTER COLUMN `compliance_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Obligation Identifier (ID)');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`compliance_obligation` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`compliance_obligation` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`compliance_obligation` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`compliance_obligation` ALTER COLUMN `registration_id` SET TAGS ('dbx_business_glossary_term' = 'Obligation Applicability - Regulatory Registration Id');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`compliance_obligation` ALTER COLUMN `advance_notice_period_days` SET TAGS ('dbx_business_glossary_term' = 'Advance Notice Period (Days)');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`compliance_obligation` ALTER COLUMN `applicability_date` SET TAGS ('dbx_business_glossary_term' = 'Applicability Date');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`compliance_obligation` ALTER COLUMN `applicable_product_category` SET TAGS ('dbx_business_glossary_term' = 'Applicable Product Category');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`compliance_obligation` ALTER COLUMN `compliance_deadline` SET TAGS ('dbx_business_glossary_term' = 'Compliance Deadline');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`compliance_obligation` ALTER COLUMN `compliance_notes` SET TAGS ('dbx_business_glossary_term' = 'Compliance Notes');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`compliance_obligation` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`compliance_obligation` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|pending|overdue|not_applicable|in_progress|expired');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`compliance_obligation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`compliance_obligation` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`compliance_obligation` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`compliance_obligation` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`compliance_obligation` ALTER COLUMN `estimated_compliance_cost` SET TAGS ('dbx_business_glossary_term' = 'Estimated Compliance Cost');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`compliance_obligation` ALTER COLUMN `estimated_compliance_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`compliance_obligation` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`compliance_obligation` ALTER COLUMN `governing_body` SET TAGS ('dbx_business_glossary_term' = 'Governing Body');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`compliance_obligation` ALTER COLUMN `governing_regulation` SET TAGS ('dbx_business_glossary_term' = 'Governing Regulation');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`compliance_obligation` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active Flag');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`compliance_obligation` ALTER COLUMN `last_compliance_verification_date` SET TAGS ('dbx_business_glossary_term' = 'Last Compliance Verification Date');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`compliance_obligation` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`compliance_obligation` ALTER COLUMN `next_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Next Audit Date');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`compliance_obligation` ALTER COLUMN `next_due_date_override` SET TAGS ('dbx_business_glossary_term' = 'Next Due Date Override');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`compliance_obligation` ALTER COLUMN `next_renewal_date` SET TAGS ('dbx_business_glossary_term' = 'Next Renewal Date');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`compliance_obligation` ALTER COLUMN `notification_sent_date` SET TAGS ('dbx_business_glossary_term' = 'Notification Sent Date');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`compliance_obligation` ALTER COLUMN `notification_sent_flag` SET TAGS ('dbx_business_glossary_term' = 'Notification Sent Flag');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`compliance_obligation` ALTER COLUMN `obligation_code` SET TAGS ('dbx_business_glossary_term' = 'Obligation Code');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`compliance_obligation` ALTER COLUMN `obligation_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`compliance_obligation` ALTER COLUMN `obligation_name` SET TAGS ('dbx_business_glossary_term' = 'Obligation Name');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`compliance_obligation` ALTER COLUMN `obligation_type` SET TAGS ('dbx_business_glossary_term' = 'Obligation Type');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`compliance_obligation` ALTER COLUMN `obligation_type` SET TAGS ('dbx_value_regex' = 'registration|labeling|reporting|testing|notification|renewal');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`compliance_obligation` ALTER COLUMN `penalty_for_non_compliance` SET TAGS ('dbx_business_glossary_term' = 'Penalty for Non-Compliance');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`compliance_obligation` ALTER COLUMN `penalty_for_non_compliance` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`compliance_obligation` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Priority');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`compliance_obligation` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'urgent|high|medium|low');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`compliance_obligation` ALTER COLUMN `renewal_frequency` SET TAGS ('dbx_business_glossary_term' = 'Renewal Frequency');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`compliance_obligation` ALTER COLUMN `renewal_frequency` SET TAGS ('dbx_value_regex' = 'annual|biennial|triennial|quinquennial|one_time|as_needed');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`compliance_obligation` ALTER COLUMN `required_documentation` SET TAGS ('dbx_business_glossary_term' = 'Required Documentation');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`compliance_obligation` ALTER COLUMN `responsible_department` SET TAGS ('dbx_business_glossary_term' = 'Responsible Department');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`compliance_obligation` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Level');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`compliance_obligation` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`compliance_obligation` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`compliance_obligation` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Identifier (ID)');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`compliance_obligation` ALTER COLUMN `submission_method` SET TAGS ('dbx_business_glossary_term' = 'Submission Method');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`compliance_obligation` ALTER COLUMN `submission_method` SET TAGS ('dbx_value_regex' = 'electronic|paper|portal|email|in_person');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`compliance_obligation` ALTER COLUMN `submission_portal_url` SET TAGS ('dbx_business_glossary_term' = 'Submission Portal Uniform Resource Locator (URL)');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`compliance_obligation` ALTER COLUMN `testing_requirement` SET TAGS ('dbx_business_glossary_term' = 'Testing Requirement');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`compliance_obligation` ALTER COLUMN `waiver_status` SET TAGS ('dbx_business_glossary_term' = 'Waiver Status');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`compliance_assessment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`compliance_assessment` SET TAGS ('dbx_subdomain' = 'compliance_assessment');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`compliance_assessment` ALTER COLUMN `compliance_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Assessment Identifier');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`compliance_assessment` ALTER COLUMN `approved_supplier_list_id` SET TAGS ('dbx_business_glossary_term' = 'Approved Supplier List Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`compliance_assessment` ALTER COLUMN `compliance_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Obligation Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`compliance_assessment` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`compliance_assessment` ALTER COLUMN `formulation_id` SET TAGS ('dbx_business_glossary_term' = 'Formulation ID');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`compliance_assessment` ALTER COLUMN `goods_receipt_id` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`compliance_assessment` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`compliance_assessment` ALTER COLUMN `manufacturing_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`compliance_assessment` ALTER COLUMN `registration_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Registration Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`compliance_assessment` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Product ID');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`compliance_assessment` ALTER COLUMN `supplier_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Contract Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`compliance_assessment` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`compliance_assessment` ALTER COLUMN `supplier_site_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Site Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`compliance_assessment` ALTER COLUMN `assessment_date` SET TAGS ('dbx_business_glossary_term' = 'Compliance Assessment Date');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`compliance_assessment` ALTER COLUMN `assessment_method` SET TAGS ('dbx_business_glossary_term' = 'Assessment Method');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`compliance_assessment` ALTER COLUMN `assessment_method` SET TAGS ('dbx_value_regex' = 'document_review|laboratory_test|site_inspection|supplier_audit|self_assessment|third_party_certification');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`compliance_assessment` ALTER COLUMN `assessment_number` SET TAGS ('dbx_business_glossary_term' = 'Compliance Assessment Number');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`compliance_assessment` ALTER COLUMN `assessment_number` SET TAGS ('dbx_value_regex' = '^CA-[0-9]{8}$');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`compliance_assessment` ALTER COLUMN `assessment_type` SET TAGS ('dbx_business_glossary_term' = 'Assessment Type');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`compliance_assessment` ALTER COLUMN `assessment_type` SET TAGS ('dbx_value_regex' = 'initial|periodic|pre_market|post_market|audit_triggered|change_control');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`compliance_assessment` ALTER COLUMN `assessor_name` SET TAGS ('dbx_business_glossary_term' = 'Assessor Name');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`compliance_assessment` ALTER COLUMN `audit_trail_reference` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail Reference');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`compliance_assessment` ALTER COLUMN `certification_number` SET TAGS ('dbx_business_glossary_term' = 'Certification Number');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`compliance_assessment` ALTER COLUMN `closure_date` SET TAGS ('dbx_business_glossary_term' = 'Compliance Assessment Closure Date');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`compliance_assessment` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Assessment Comments');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`compliance_assessment` ALTER COLUMN `compliance_finding` SET TAGS ('dbx_business_glossary_term' = 'Compliance Finding');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`compliance_assessment` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`compliance_assessment` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|conditional|pending_review|not_applicable');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`compliance_assessment` ALTER COLUMN `corrective_action_description` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Description');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`compliance_assessment` ALTER COLUMN `corrective_action_due_date` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Due Date');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`compliance_assessment` ALTER COLUMN `corrective_action_owner` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Owner');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`compliance_assessment` ALTER COLUMN `corrective_action_required` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Required Flag');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`compliance_assessment` ALTER COLUMN `corrective_action_status` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Status');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`compliance_assessment` ALTER COLUMN `corrective_action_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|completed|verified|overdue');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`compliance_assessment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`compliance_assessment` ALTER COLUMN `evidence_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Evidence Document Reference');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`compliance_assessment` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`compliance_assessment` ALTER COLUMN `next_assessment_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Assessment Due Date');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`compliance_assessment` ALTER COLUMN `regulatory_authority` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Authority');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`compliance_assessment` ALTER COLUMN `regulatory_framework` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Framework');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`compliance_assessment` ALTER COLUMN `requirement_description` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Description');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`compliance_assessment` ALTER COLUMN `requirement_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Reference');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`compliance_assessment` ALTER COLUMN `review_date` SET TAGS ('dbx_business_glossary_term' = 'Review Date');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`compliance_assessment` ALTER COLUMN `reviewer_name` SET TAGS ('dbx_business_glossary_term' = 'Reviewer Name');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`compliance_assessment` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Level');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`compliance_assessment` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low|negligible');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`compliance_assessment` ALTER COLUMN `test_report_number` SET TAGS ('dbx_business_glossary_term' = 'Test Report Number');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`product_recall` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`product_recall` SET TAGS ('dbx_subdomain' = 'compliance_assessment');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`product_recall` ALTER COLUMN `product_recall_id` SET TAGS ('dbx_business_glossary_term' = 'Product Recall Identifier (ID)');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`product_recall` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`product_recall` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`product_recall` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`product_recall` ALTER COLUMN `registration_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Registration Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`product_recall` ALTER COLUMN `submission_id` SET TAGS ('dbx_business_glossary_term' = 'Submission Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`product_recall` ALTER COLUMN `affected_channels` SET TAGS ('dbx_business_glossary_term' = 'Affected Distribution Channels');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`product_recall` ALTER COLUMN `affected_countries` SET TAGS ('dbx_business_glossary_term' = 'Affected Countries');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`product_recall` ALTER COLUMN `affected_gtin_list` SET TAGS ('dbx_business_glossary_term' = 'Affected Global Trade Item Number (GTIN) List');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`product_recall` ALTER COLUMN `affected_lot_batch_numbers` SET TAGS ('dbx_business_glossary_term' = 'Affected Lot or Batch Numbers');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`product_recall` ALTER COLUMN `affected_production_date_range_end` SET TAGS ('dbx_business_glossary_term' = 'Affected Production Date Range End');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`product_recall` ALTER COLUMN `affected_production_date_range_start` SET TAGS ('dbx_business_glossary_term' = 'Affected Production Date Range Start');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`product_recall` ALTER COLUMN `affected_sku_list` SET TAGS ('dbx_business_glossary_term' = 'Affected Stock Keeping Unit (SKU) List');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`product_recall` ALTER COLUMN `affected_states_provinces` SET TAGS ('dbx_business_glossary_term' = 'Affected States or Provinces');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`product_recall` ALTER COLUMN `authority_notification_date` SET TAGS ('dbx_business_glossary_term' = 'Authority Notification Date');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`product_recall` ALTER COLUMN `consumer_hotline_number` SET TAGS ('dbx_business_glossary_term' = 'Consumer Hotline Number');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`product_recall` ALTER COLUMN `consumer_remedy_instructions` SET TAGS ('dbx_business_glossary_term' = 'Consumer Remedy Instructions');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`product_recall` ALTER COLUMN `consumer_remedy_type` SET TAGS ('dbx_business_glossary_term' = 'Consumer Remedy Type');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`product_recall` ALTER COLUMN `consumer_remedy_type` SET TAGS ('dbx_value_regex' = 'Full Refund|Replacement|Repair|Credit|Disposal Instructions|No Remedy');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`product_recall` ALTER COLUMN `corrective_action_plan_reference` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Plan Reference');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`product_recall` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`product_recall` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`product_recall` ALTER COLUMN `effectiveness_check_date` SET TAGS ('dbx_business_glossary_term' = 'Effectiveness Check Date');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`product_recall` ALTER COLUMN `effectiveness_check_result` SET TAGS ('dbx_business_glossary_term' = 'Effectiveness Check Result');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`product_recall` ALTER COLUMN `effectiveness_check_result` SET TAGS ('dbx_value_regex' = 'Effective|Partially Effective|Ineffective|Pending');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`product_recall` ALTER COLUMN `estimated_financial_impact_amount` SET TAGS ('dbx_business_glossary_term' = 'Estimated Financial Impact Amount');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`product_recall` ALTER COLUMN `estimated_financial_impact_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`product_recall` ALTER COLUMN `health_hazard_evaluation` SET TAGS ('dbx_business_glossary_term' = 'Health Hazard Evaluation');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`product_recall` ALTER COLUMN `health_hazard_evaluation` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`product_recall` ALTER COLUMN `health_hazard_evaluation` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`product_recall` ALTER COLUMN `press_release_reference` SET TAGS ('dbx_business_glossary_term' = 'Press Release Reference');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`product_recall` ALTER COLUMN `public_notification_date` SET TAGS ('dbx_business_glossary_term' = 'Public Notification Date');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`product_recall` ALTER COLUMN `quantity_recalled_units` SET TAGS ('dbx_business_glossary_term' = 'Quantity Recalled Units');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`product_recall` ALTER COLUMN `quantity_recovered_units` SET TAGS ('dbx_business_glossary_term' = 'Quantity Recovered Units');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`product_recall` ALTER COLUMN `recall_classification` SET TAGS ('dbx_business_glossary_term' = 'Recall Classification');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`product_recall` ALTER COLUMN `recall_classification` SET TAGS ('dbx_value_regex' = 'Class I|Class II|Class III|Voluntary|Market Withdrawal');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`product_recall` ALTER COLUMN `recall_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Recall Completion Date');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`product_recall` ALTER COLUMN `recall_coordinator_email` SET TAGS ('dbx_business_glossary_term' = 'Recall Coordinator Email');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`product_recall` ALTER COLUMN `recall_coordinator_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`product_recall` ALTER COLUMN `recall_coordinator_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`product_recall` ALTER COLUMN `recall_coordinator_phone` SET TAGS ('dbx_business_glossary_term' = 'Recall Coordinator Phone');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`product_recall` ALTER COLUMN `recall_coordinator_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`product_recall` ALTER COLUMN `recall_effectiveness_percentage` SET TAGS ('dbx_business_glossary_term' = 'Recall Effectiveness Percentage');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`product_recall` ALTER COLUMN `recall_initiation_date` SET TAGS ('dbx_business_glossary_term' = 'Recall Initiation Date');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`product_recall` ALTER COLUMN `recall_number` SET TAGS ('dbx_business_glossary_term' = 'Recall Number');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`product_recall` ALTER COLUMN `recall_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Recall Reason Code');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`product_recall` ALTER COLUMN `recall_reason_description` SET TAGS ('dbx_business_glossary_term' = 'Recall Reason Description');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`product_recall` ALTER COLUMN `recall_scope` SET TAGS ('dbx_business_glossary_term' = 'Recall Scope');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`product_recall` ALTER COLUMN `recall_scope` SET TAGS ('dbx_value_regex' = 'National|Regional|State|International|Global');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`product_recall` ALTER COLUMN `recall_status` SET TAGS ('dbx_business_glossary_term' = 'Recall Status');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`product_recall` ALTER COLUMN `recall_status` SET TAGS ('dbx_value_regex' = 'Initiated|Ongoing|Completed|Terminated|Pending');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`product_recall` ALTER COLUMN `recall_type` SET TAGS ('dbx_business_glossary_term' = 'Recall Type');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`product_recall` ALTER COLUMN `recall_type` SET TAGS ('dbx_value_regex' = 'Consumer Level|Retail Level|Wholesale Level|Manufacturing Level');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`product_recall` ALTER COLUMN `recall_website_url` SET TAGS ('dbx_business_glossary_term' = 'Recall Website Uniform Resource Locator (URL)');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`product_recall` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`product_recall` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`product_recall` ALTER COLUMN `regulatory_authority` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Authority');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`product_recall` ALTER COLUMN `regulatory_mandate_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Mandate Flag');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`product_recall` ALTER COLUMN `root_cause_analysis_reference` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Analysis Reference');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`jurisdiction` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`jurisdiction` SET TAGS ('dbx_subdomain' = 'compliance_assessment');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`jurisdiction` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Identifier (ID)');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`jurisdiction` ALTER COLUMN `parent_jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Jurisdiction Identifier (ID)');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`jurisdiction` ALTER COLUMN `animal_testing_ban_flag` SET TAGS ('dbx_business_glossary_term' = 'Animal Testing Ban Flag');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`jurisdiction` ALTER COLUMN `cfr_reference` SET TAGS ('dbx_business_glossary_term' = 'Code of Federal Regulations (CFR) Reference');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`jurisdiction` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`jurisdiction` ALTER COLUMN `contact_email` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Authority Contact Email');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`jurisdiction` ALTER COLUMN `contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`jurisdiction` ALTER COLUMN `contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`jurisdiction` ALTER COLUMN `contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Authority Contact Phone');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`jurisdiction` ALTER COLUMN `contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`jurisdiction` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`jurisdiction` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`jurisdiction` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`jurisdiction` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`jurisdiction` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`jurisdiction` ALTER COLUMN `gmp_compliance_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Good Manufacturing Practice (GMP) Compliance Required Flag');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`jurisdiction` ALTER COLUMN `ifra_compliance_required_flag` SET TAGS ('dbx_business_glossary_term' = 'International Fragrance Association (IFRA) Compliance Required Flag');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`jurisdiction` ALTER COLUMN `ingredient_declaration_format` SET TAGS ('dbx_business_glossary_term' = 'Ingredient Declaration Format');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`jurisdiction` ALTER COLUMN `ingredient_declaration_format` SET TAGS ('dbx_value_regex' = 'inci|cas|common_name|proprietary');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`jurisdiction` ALTER COLUMN `jurisdiction_code` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Code');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`jurisdiction` ALTER COLUMN `jurisdiction_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`jurisdiction` ALTER COLUMN `jurisdiction_name` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Name');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`jurisdiction` ALTER COLUMN `jurisdiction_status` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Status');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`jurisdiction` ALTER COLUMN `jurisdiction_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|superseded');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`jurisdiction` ALTER COLUMN `jurisdiction_type` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Type');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`jurisdiction` ALTER COLUMN `jurisdiction_type` SET TAGS ('dbx_value_regex' = 'national|regional|supranational|state|provincial|municipal');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`jurisdiction` ALTER COLUMN `labeling_language_primary` SET TAGS ('dbx_business_glossary_term' = 'Primary Labeling Language');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`jurisdiction` ALTER COLUMN `labeling_language_primary` SET TAGS ('dbx_value_regex' = '^[a-z]{2,3}$');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`jurisdiction` ALTER COLUMN `labeling_language_secondary` SET TAGS ('dbx_business_glossary_term' = 'Secondary Labeling Language(s)');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`jurisdiction` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`jurisdiction` ALTER COLUMN `market_entry_requirement_type` SET TAGS ('dbx_business_glossary_term' = 'Market Entry Requirement Type');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`jurisdiction` ALTER COLUMN `market_entry_requirement_type` SET TAGS ('dbx_value_regex' = 'notification|registration|pre-market_approval|post-market_surveillance|voluntary');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`jurisdiction` ALTER COLUMN `notification_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Notification Required Flag');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`jurisdiction` ALTER COLUMN `post_market_surveillance_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Post-Market Surveillance Required Flag');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`jurisdiction` ALTER COLUMN `pre_market_approval_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Pre-Market Approval Required Flag');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`jurisdiction` ALTER COLUMN `product_information_file_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Product Information File (PIF) Required Flag');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`jurisdiction` ALTER COLUMN `reach_registration_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Registration Evaluation Authorization and Restriction of Chemicals (REACH) Registration Required Flag');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`jurisdiction` ALTER COLUMN `region_code` SET TAGS ('dbx_business_glossary_term' = 'Region Code');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`jurisdiction` ALTER COLUMN `registration_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Registration Required Flag');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`jurisdiction` ALTER COLUMN `regulatory_authority` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Authority');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`jurisdiction` ALTER COLUMN `regulatory_framework` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Framework');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`jurisdiction` ALTER COLUMN `responsible_person_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Responsible Person Required Flag');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`jurisdiction` ALTER COLUMN `sds_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Safety Data Sheet (SDS) Required Flag');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`jurisdiction` ALTER COLUMN `submission_portal_url` SET TAGS ('dbx_business_glossary_term' = 'Submission Portal Uniform Resource Locator (URL)');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`jurisdiction` ALTER COLUMN `website_url` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Authority Website Uniform Resource Locator (URL)');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`restricted_substance` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`restricted_substance` SET TAGS ('dbx_subdomain' = 'product_labeling');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`restricted_substance` ALTER COLUMN `restricted_substance_id` SET TAGS ('dbx_business_glossary_term' = 'Restricted Substance ID');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`restricted_substance` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`restricted_substance` ALTER COLUMN `affected_product_categories` SET TAGS ('dbx_business_glossary_term' = 'Affected Product Categories');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`restricted_substance` ALTER COLUMN `alternative_substance_recommendations` SET TAGS ('dbx_business_glossary_term' = 'Alternative Substance Recommendations');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`restricted_substance` ALTER COLUMN `applicable_regulations` SET TAGS ('dbx_business_glossary_term' = 'Applicable Regulations');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`restricted_substance` ALTER COLUMN `authorization_status` SET TAGS ('dbx_business_glossary_term' = 'Authorization Status');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`restricted_substance` ALTER COLUMN `authorization_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|granted|denied|expired|withdrawn');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`restricted_substance` ALTER COLUMN `cas_number` SET TAGS ('dbx_business_glossary_term' = 'Chemical Abstracts Service (CAS) Number');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`restricted_substance` ALTER COLUMN `cas_number` SET TAGS ('dbx_value_regex' = '^[1-9][0-9]{1,6}-[0-9]{2}-[0-9]$');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`restricted_substance` ALTER COLUMN `cfr_reference` SET TAGS ('dbx_business_glossary_term' = 'Code of Federal Regulations (CFR) Reference');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`restricted_substance` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments or Notes');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`restricted_substance` ALTER COLUMN `concentration_unit` SET TAGS ('dbx_business_glossary_term' = 'Concentration Unit of Measure');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`restricted_substance` ALTER COLUMN `concentration_unit` SET TAGS ('dbx_value_regex' = 'percent_weight|percent_volume|ppm|ppb|mg_per_kg');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`restricted_substance` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`restricted_substance` ALTER COLUMN `downstream_notification_required` SET TAGS ('dbx_business_glossary_term' = 'Downstream User Notification Required');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`restricted_substance` ALTER COLUMN `ec_number` SET TAGS ('dbx_business_glossary_term' = 'European Community (EC) Number');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`restricted_substance` ALTER COLUMN `ec_number` SET TAGS ('dbx_value_regex' = '^[0-9]{3}-[0-9]{3}-[0-9]$');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`restricted_substance` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Restriction Effective Date');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`restricted_substance` ALTER COLUMN `epa_restricted_flag` SET TAGS ('dbx_business_glossary_term' = 'Environmental Protection Agency (EPA) Restricted Chemical Flag');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`restricted_substance` ALTER COLUMN `fda_prohibited_flag` SET TAGS ('dbx_business_glossary_term' = 'Food and Drug Administration (FDA) Prohibited Ingredient Flag');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`restricted_substance` ALTER COLUMN `hazard_classification` SET TAGS ('dbx_business_glossary_term' = 'Globally Harmonized System (GHS) Hazard Classification');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`restricted_substance` ALTER COLUMN `ifra_prohibition_category` SET TAGS ('dbx_business_glossary_term' = 'IFRA Prohibition or Restriction Category');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`restricted_substance` ALTER COLUMN `ifra_standard_reference` SET TAGS ('dbx_business_glossary_term' = 'International Fragrance Association (IFRA) Standard Reference');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`restricted_substance` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`restricted_substance` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Regulatory Review Date');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`restricted_substance` ALTER COLUMN `maximum_permitted_concentration` SET TAGS ('dbx_business_glossary_term' = 'Maximum Permitted Concentration');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`restricted_substance` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Scheduled Review Date');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`restricted_substance` ALTER COLUMN `owning_team` SET TAGS ('dbx_business_glossary_term' = 'Owning Team or Department');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`restricted_substance` ALTER COLUMN `post_market_surveillance_required` SET TAGS ('dbx_business_glossary_term' = 'Post-Market Surveillance Required');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`restricted_substance` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Email Address');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`restricted_substance` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`restricted_substance` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`restricted_substance` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`restricted_substance` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Name');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`restricted_substance` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`restricted_substance` ALTER COLUMN `prop_65_listing` SET TAGS ('dbx_business_glossary_term' = 'California Proposition 65 Listing');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`restricted_substance` ALTER COLUMN `reach_registration_number` SET TAGS ('dbx_business_glossary_term' = 'Registration Evaluation Authorization and Restriction of Chemicals (REACH) Registration Number');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`restricted_substance` ALTER COLUMN `regulatory_authority` SET TAGS ('dbx_business_glossary_term' = 'Primary Regulatory Authority');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`restricted_substance` ALTER COLUMN `restriction_type` SET TAGS ('dbx_business_glossary_term' = 'Restriction Type');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`restricted_substance` ALTER COLUMN `restriction_type` SET TAGS ('dbx_value_regex' = 'banned|concentration_limit|disclosure_required|authorization_required|restricted_use|conditional_approval');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`restricted_substance` ALTER COLUMN `rspo_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Roundtable on Sustainable Palm Oil (RSPO) Compliance Flag');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`restricted_substance` ALTER COLUMN `sds_required` SET TAGS ('dbx_business_glossary_term' = 'Safety Data Sheet (SDS) Required');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`restricted_substance` ALTER COLUMN `substance_name` SET TAGS ('dbx_business_glossary_term' = 'Substance Name');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`restricted_substance` ALTER COLUMN `sunset_date` SET TAGS ('dbx_business_glossary_term' = 'Authorization Sunset Date');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`restricted_substance` ALTER COLUMN `svhc_status` SET TAGS ('dbx_business_glossary_term' = 'Substance of Very High Concern (SVHC) Status');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`restricted_substance` ALTER COLUMN `tonnage_band` SET TAGS ('dbx_business_glossary_term' = 'Tonnage Band');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`restricted_substance` ALTER COLUMN `tonnage_band` SET TAGS ('dbx_value_regex' = '1_to_10|10_to_100|100_to_1000|above_1000|not_applicable');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`regulatory_claim` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`regulatory_claim` SET TAGS ('dbx_subdomain' = 'product_labeling');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`regulatory_claim` ALTER COLUMN `regulatory_claim_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Claim ID');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`regulatory_claim` ALTER COLUMN `jurisdiction_id` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`regulatory_claim` ALTER COLUMN `market_research_study_id` SET TAGS ('dbx_business_glossary_term' = 'Market Research Study Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`regulatory_claim` ALTER COLUMN `product_brand_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`regulatory_claim` ALTER COLUMN `registration_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Registration Id (Foreign Key)');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`regulatory_claim` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Product ID');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`regulatory_claim` ALTER COLUMN `adverse_event_reporting_required` SET TAGS ('dbx_business_glossary_term' = 'Adverse Event Reporting Required');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`regulatory_claim` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`regulatory_claim` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`regulatory_claim` ALTER COLUMN `approved_markets` SET TAGS ('dbx_business_glossary_term' = 'Approved Markets');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`regulatory_claim` ALTER COLUMN `certification_number` SET TAGS ('dbx_business_glossary_term' = 'Certification Number');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`regulatory_claim` ALTER COLUMN `cfr_reference` SET TAGS ('dbx_business_glossary_term' = 'Code of Federal Regulations (CFR) Reference');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`regulatory_claim` ALTER COLUMN `claim_number` SET TAGS ('dbx_business_glossary_term' = 'Claim Number');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`regulatory_claim` ALTER COLUMN `claim_number` SET TAGS ('dbx_value_regex' = '^RC-[0-9]{8}$');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`regulatory_claim` ALTER COLUMN `claim_scope` SET TAGS ('dbx_business_glossary_term' = 'Claim Scope');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`regulatory_claim` ALTER COLUMN `claim_scope` SET TAGS ('dbx_value_regex' = 'product_specific|brand_level|category_level|ingredient_specific');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`regulatory_claim` ALTER COLUMN `claim_status` SET TAGS ('dbx_business_glossary_term' = 'Claim Status');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`regulatory_claim` ALTER COLUMN `claim_status` SET TAGS ('dbx_value_regex' = 'draft|pending_review|approved|rejected|expired|withdrawn');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`regulatory_claim` ALTER COLUMN `claim_text` SET TAGS ('dbx_business_glossary_term' = 'Claim Text');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`regulatory_claim` ALTER COLUMN `claim_type` SET TAGS ('dbx_business_glossary_term' = 'Claim Type');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`regulatory_claim` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`regulatory_claim` ALTER COLUMN `compliance_review_date` SET TAGS ('dbx_business_glossary_term' = 'Compliance Review Date');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`regulatory_claim` ALTER COLUMN `compliance_review_outcome` SET TAGS ('dbx_business_glossary_term' = 'Compliance Review Outcome');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`regulatory_claim` ALTER COLUMN `compliance_review_outcome` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|requires_modification|pending_review|not_reviewed');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`regulatory_claim` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`regulatory_claim` ALTER COLUMN `disclaimer_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Disclaimer Required Flag');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`regulatory_claim` ALTER COLUMN `disclaimer_text` SET TAGS ('dbx_business_glossary_term' = 'Disclaimer Text');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`regulatory_claim` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`regulatory_claim` ALTER COLUMN `eu_regulation_reference` SET TAGS ('dbx_business_glossary_term' = 'European Union (EU) Regulation Reference');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`regulatory_claim` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`regulatory_claim` ALTER COLUMN `ifra_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'International Fragrance Association (IFRA) Compliance Flag');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`regulatory_claim` ALTER COLUMN `language_code` SET TAGS ('dbx_business_glossary_term' = 'Claim Language Code');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`regulatory_claim` ALTER COLUMN `language_code` SET TAGS ('dbx_value_regex' = '^[a-z]{2}$');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`regulatory_claim` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`regulatory_claim` ALTER COLUMN `owning_team` SET TAGS ('dbx_business_glossary_term' = 'Owning Team');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`regulatory_claim` ALTER COLUMN `post_market_surveillance_required` SET TAGS ('dbx_business_glossary_term' = 'Post-Market Surveillance Required');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`regulatory_claim` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Email');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`regulatory_claim` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`regulatory_claim` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`regulatory_claim` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`regulatory_claim` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Name');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`regulatory_claim` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`regulatory_claim` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`regulatory_claim` ALTER COLUMN `product_category` SET TAGS ('dbx_business_glossary_term' = 'Product Category');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`regulatory_claim` ALTER COLUMN `regulatory_authority` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Authority');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`regulatory_claim` ALTER COLUMN `renewal_frequency_months` SET TAGS ('dbx_business_glossary_term' = 'Renewal Frequency Months');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`regulatory_claim` ALTER COLUMN `renewal_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Renewal Required Flag');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`regulatory_claim` ALTER COLUMN `sku` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU)');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`regulatory_claim` ALTER COLUMN `submission_date` SET TAGS ('dbx_business_glossary_term' = 'Submission Date');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`regulatory_claim` ALTER COLUMN `substantiation_method` SET TAGS ('dbx_business_glossary_term' = 'Substantiation Method');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`regulatory_claim` ALTER COLUMN `third_party_certification` SET TAGS ('dbx_business_glossary_term' = 'Third-Party Certification');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`regulatory_claim` ALTER COLUMN `usage_restriction` SET TAGS ('dbx_business_glossary_term' = 'Usage Restriction');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`sds_substance_composition` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`sds_substance_composition` SET TAGS ('dbx_subdomain' = 'product_labeling');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`sds_substance_composition` SET TAGS ('dbx_association_edges' = 'regulatory.restricted_substance,regulatory.sds');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`sds_substance_composition` ALTER COLUMN `sds_substance_composition_id` SET TAGS ('dbx_business_glossary_term' = 'Sds Substance Composition - Sds Substance Composition Id');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`sds_substance_composition` ALTER COLUMN `restricted_substance_id` SET TAGS ('dbx_business_glossary_term' = 'Sds Substance Composition - Restricted Substance Id');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`sds_substance_composition` ALTER COLUMN `sds_id` SET TAGS ('dbx_business_glossary_term' = 'Sds Substance Composition - Sds Id');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`sds_substance_composition` ALTER COLUMN `concentration_in_product` SET TAGS ('dbx_business_glossary_term' = 'Substance Concentration in Product');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`sds_substance_composition` ALTER COLUMN `concentration_unit` SET TAGS ('dbx_business_glossary_term' = 'Concentration Unit of Measure');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`sds_substance_composition` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`sds_substance_composition` ALTER COLUMN `disclosure_basis` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Disclosure Basis');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`sds_substance_composition` ALTER COLUMN `exposure_limit_override` SET TAGS ('dbx_business_glossary_term' = 'Exposure Limit Override');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`sds_substance_composition` ALTER COLUMN `hazard_contribution_flag` SET TAGS ('dbx_business_glossary_term' = 'Primary Hazard Contributor Flag');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`sds_substance_composition` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `consumer_goods_ecm`.`regulatory`.`sds_substance_composition` ALTER COLUMN `section_reference` SET TAGS ('dbx_business_glossary_term' = 'SDS Section Reference');
