-- Schema for Domain: regulatory | Business: Food Beverage | Version: v1_mvm
-- Generated on: 2026-05-05 23:22:31

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `food_beverage_ecm`.`regulatory` COMMENT 'Manages all regulatory compliance and government reporting obligations — FDA/USDA registration and inspection records, EFSA dossiers, nutrition and allergen labeling compliance (21 CFR Part 101), FSMA recordkeeping, EPA packaging compliance, country-of-origin declarations, import/export permits, tariff classifications, and regulatory change management.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `food_beverage_ecm`.`regulatory`.`establishment_registration` (
    `establishment_registration_id` BIGINT COMMENT 'Surrogate primary key uniquely identifying each facility registration record.',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: Regulatory facility registration must be tied to the legal entity’s finance company code for compliance cost allocation and reporting.',
    `address_line1` STRING COMMENT 'First line of the facilitys street address.',
    `address_line2` STRING COMMENT 'Second line of the facilitys street address (optional).',
    `city` STRING COMMENT 'City where the facility is located.',
    `compliance_programs` STRING COMMENT 'Comma‑separated list of all compliance programs the facility participates in (e.g., FSMA, HACCP, SQF).',
    `country` STRING COMMENT 'Three‑letter ISO country code where the facility resides.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the registration record was first created in the lakehouse.',
    `effective_date` DATE COMMENT 'Date the registration became effective.',
    `email_address` STRING COMMENT 'Primary email address for regulatory communications.',
    `expiration_date` DATE COMMENT 'Date the registration expires or is scheduled to be renewed; null if open‑ended.',
    `facility_name` STRING COMMENT 'Legal name of the manufacturing, co‑packing, or storage facility.',
    `facility_type` STRING COMMENT 'Category of the establishment (e.g., manufacturing plant, co‑packer, distribution warehouse).',
    `last_inspection_date` DATE COMMENT 'Date of the most recent FDA/USDA inspection for the facility.',
    `next_inspection_due` DATE COMMENT 'Scheduled date for the next required inspection.',
    `notes` STRING COMMENT 'Free‑form comments or remarks about the registration.',
    `phone_number` STRING COMMENT 'Primary telephone number for the facility.',
    `postal_code` STRING COMMENT 'Postal or ZIP code for the facility address.',
    `registration_number` STRING COMMENT 'Official registration identifier assigned by FDA or USDA to the facility.',
    `registration_program` STRING COMMENT 'Primary food‑safety or quality program under which the facility is registered.. Valid values are `FSMA|HACCP|SQF|GMP|FSSC|ISO22000`',
    `registration_source_system` STRING COMMENT 'Originating system that supplied the registration record (e.g., SAP, TraceGains).',
    `registration_status` STRING COMMENT 'Current lifecycle status of the registration.. Valid values are `active|inactive|suspended|pending|revoked`',
    `registration_status_date` DATE COMMENT 'Date when the current registration status was set.',
    `renewal_due_date` DATE COMMENT 'Date by which the registration must be renewed to remain active.',
    `state` STRING COMMENT 'Two‑letter state or province code for the facility location.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the registration record.',
    CONSTRAINT pk_establishment_registration PRIMARY KEY(`establishment_registration_id`)
) COMMENT 'Master record of all FDA/USDA facility registrations for Food Beverage manufacturing plants, co-packers, and storage facilities. Captures FDA registration numbers, USDA establishment numbers, facility type, registration status, renewal dates, and applicable regulatory programs (FSMA, HACCP, SQF). Serves as the authoritative SSOT for all government-registered facilities.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`regulatory`.`facility_inspection` (
    `facility_inspection_id` BIGINT COMMENT 'System-generated unique identifier for each facility inspection record.',
    `establishment_registration_id` BIGINT COMMENT 'Foreign key linking to regulatory.establishment_registration. Business justification: Inspections are performed at a registered establishment; linking facility_inspection to establishment_registration provides parent‑child relationship.',
    `food_safety_plan_id` BIGINT COMMENT 'Foreign key linking to regulatory.food_safety_plan. Business justification: During a regulatory inspection (FDA, USDA), inspectors review and evaluate the facilitys food safety plan as a core component of the inspection. Linking facility_inspection to food_safety_plan establ',
    `plant_id` BIGINT COMMENT 'Unique identifier of the facility where the inspection took place.',
    `supplier_site_id` BIGINT COMMENT 'Foreign key linking to procurement.supplier_site. Business justification: FDA/USDA facility inspections of supplier sites must link to specific supplier_site for FSMA compliance verification, approved vendor list (AVL) status updates, and supplier risk tier adjustments. Ess',
    `audit_trail_notes` STRING COMMENT 'Additional audit trail comments added by system or users.',
    `corrective_action_deadline` DATE COMMENT 'Date by which required corrective actions must be completed.',
    `corrective_action_status` STRING COMMENT 'Current status of the corrective action plan.. Valid values are `not_started|in_progress|completed`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the inspection record was first created in the system.',
    `disposition` STRING COMMENT 'Final outcome of the inspection after any follow‑up.. Valid values are `no_action|rework|reinspect|closed`',
    `documentation_attached` BOOLEAN COMMENT 'True if supporting documents (photos, reports) are attached to the record.',
    `facility_inspection_status` STRING COMMENT 'Current lifecycle status of the inspection record.. Valid values are `pending|in_progress|completed|closed|cancelled`',
    `facility_name` STRING COMMENT 'Name of the facility inspected.',
    `findings_summary` STRING COMMENT 'High‑level summary of inspection findings and observations.',
    `follow_up_required` BOOLEAN COMMENT 'Indicates whether a follow‑up inspection is mandated.',
    `inspection_location` STRING COMMENT 'Physical address or site identifier where the inspection occurred.',
    `inspection_number` STRING COMMENT 'External reference number assigned to the inspection by the regulatory body or internal tracking system.',
    `inspection_report_url` STRING COMMENT 'Link to the digital inspection report stored in the document management system.',
    `inspection_scope` STRING COMMENT 'Areas or processes examined during the inspection.. Valid values are `sanitation|process|labeling|equipment|storage|distribution`',
    `inspection_timestamp` TIMESTAMP COMMENT 'Date and time when the inspection was performed.',
    `inspection_type` STRING COMMENT 'Classification of the inspection purpose.. Valid values are `routine|for_cause|pre_approval|follow_up`',
    `inspector_name` STRING COMMENT 'Legal name of the inspector performing the inspection.',
    `observations` STRING COMMENT 'Full text of observations, notes, and 483 citations recorded during the inspection.',
    `regulatory_body` STRING COMMENT 'Government or third‑party organization that conducted or oversaw the inspection.. Valid values are `FDA|USDA|EFSA|GFSI|State_Agency`',
    `severity_level` STRING COMMENT 'Risk severity assigned to the inspection findings.. Valid values are `critical|major|minor|informational`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the inspection record.',
    CONSTRAINT pk_facility_inspection PRIMARY KEY(`facility_inspection_id`)
) COMMENT 'Transactional records of all regulatory inspections conducted at Food Beverage facilities by FDA, USDA, EFSA, state agencies, and third-party GFSI auditors. Captures inspection date, inspector identity, inspection type (routine, for-cause, pre-approval), findings, observations (483s), corrective action deadlines, and final disposition. Links to establishment_registration.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`regulatory`.`nutrition_label` (
    `nutrition_label_id` BIGINT COMMENT 'Unique surrogate identifier for the nutrition label record.',
    `product_registration_id` BIGINT COMMENT 'Foreign key linking to regulatory.product_registration. Business justification: Nutrition labels are defined per product registration; linking provides authoritative source for label data.',
    `added_sugars_g` DECIMAL(18,2) COMMENT 'Added sugars per serving in grams.',
    `allergen_declaration` STRING COMMENT 'List of allergens present in the product as required by labeling regulations.',
    `calcium_mg` DECIMAL(18,2) COMMENT 'Calcium content per serving in milligrams.',
    `calories` STRING COMMENT 'Total energy content per serving expressed in kilocalories.',
    `cholesterol_mg` DECIMAL(18,2) COMMENT 'Cholesterol content per serving in milligrams.',
    `country` STRING COMMENT 'Three‑letter ISO country code indicating the market for which the label applies.',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the nutrition label record was first created in the system.',
    `dietary_fiber_g` DECIMAL(18,2) COMMENT 'Dietary fiber content per serving in grams.',
    `effective_date` DATE COMMENT 'Date when the nutrition label became effective for the product.',
    `expiration_date` DATE COMMENT 'Date after which the nutrition label is no longer valid (e.g., due to reformulation).',
    `gtin` STRING COMMENT 'Global identifier for the trade item, used internationally for product identification.',
    `iron_mg` DECIMAL(18,2) COMMENT 'Iron content per serving in milligrams.',
    `is_gluten_free` BOOLEAN COMMENT 'Indicates whether the product is certified gluten‑free.',
    `is_halal` BOOLEAN COMMENT 'Indicates whether the product meets halal certification standards.',
    `is_kosher` BOOLEAN COMMENT 'Indicates whether the product meets kosher certification standards.',
    `is_non_gmo` BOOLEAN COMMENT 'Indicates whether the product is certified non‑genetically modified.',
    `is_organic` BOOLEAN COMMENT 'Indicates whether the product is certified organic.',
    `is_vegan` BOOLEAN COMMENT 'Indicates whether the product contains no animal‑derived ingredients.',
    `label_format` STRING COMMENT 'Regulatory format version of the nutrition label (e.g., US, EU, Canada).. Valid values are `US|EU|CA`',
    `label_name` STRING COMMENT 'Human‑readable name of the nutrition label, typically the product name displayed on the package.',
    `label_source` STRING COMMENT 'Origin system that supplied the nutrition label data (e.g., Veeva Vault, TraceGains, Manual Entry).',
    `label_status` STRING COMMENT 'Current lifecycle status of the nutrition label record.. Valid values are `active|inactive|archived`',
    `last_reviewed_timestamp` TIMESTAMP COMMENT 'Date‑time when the label was last reviewed for regulatory compliance.',
    `nutrition_facts_version` STRING COMMENT 'Version identifier for the nutrition facts panel, incremented on each regulatory update.',
    `protein_g` DECIMAL(18,2) COMMENT 'Protein content per serving in grams.',
    `regulatory_compliance_status` STRING COMMENT 'Current compliance state of the nutrition label with applicable regulations.. Valid values are `compliant|non_compliant|pending`',
    `saturated_fat_g` DECIMAL(18,2) COMMENT 'Saturated fat content per serving in grams.',
    `serving_size` STRING COMMENT 'Textual description of the serving size (e.g., "30g" or "1 cup").',
    `serving_size_grams` DECIMAL(18,2) COMMENT 'Numeric serving size expressed in grams for precise calculations.',
    `servings_per_container` DECIMAL(18,2) COMMENT 'Number of servings contained in the product package.',
    `sku` STRING COMMENT 'Internal product identifier used for inventory and sales tracking.',
    `sodium_mg` DECIMAL(18,2) COMMENT 'Sodium content per serving in milligrams.',
    `total_carbohydrate_g` DECIMAL(18,2) COMMENT 'Total carbohydrate content per serving in grams.',
    `total_fat_g` DECIMAL(18,2) COMMENT 'Total fat content per serving in grams.',
    `total_sugars_g` DECIMAL(18,2) COMMENT 'Total sugars (including added) per serving in grams.',
    `trans_fat_g` DECIMAL(18,2) COMMENT 'Trans fat content per serving in grams.',
    `upc` STRING COMMENT '12‑digit barcode number assigned to the product for retail scanning.. Valid values are `^[0-9]{12}$`',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent modification to the nutrition label record.',
    `vitamin_a_iu` STRING COMMENT 'Vitamin A content per serving in International Units.',
    `vitamin_c_mg` DECIMAL(18,2) COMMENT 'Vitamin C content per serving in milligrams.',
    CONSTRAINT pk_nutrition_label PRIMARY KEY(`nutrition_label_id`)
) COMMENT 'Master record of approved Nutrition Facts Panel data for each SKU, compliant with 21 CFR Part 101. Stores serving size, calories, macro and micronutrient values, daily value percentages, allergen declarations, and label format version. Tracks FDA-mandated label updates and country-specific nutritional labeling variants (US, EU, Canada). SSOT for all nutrition label content.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`regulatory`.`fsma_record` (
    `fsma_record_id` BIGINT COMMENT 'Unique surrogate key for each FSMA compliance record.',
    `establishment_registration_id` BIGINT COMMENT 'Foreign key linking to regulatory.establishment_registration. Business justification: FSMA records are facility‑level compliance records; linking to establishment_registration ties them to the registered facility.',
    `food_safety_plan_id` BIGINT COMMENT 'Foreign key linking to regulatory.food_safety_plan. Business justification: FSMA-mandated recordkeeping entries (Preventive Controls, FSVP, Produce Safety) are generated as part of executing a food safety plan. Each fsma_record documents a specific activity (monitoring, verif',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to procurement.supplier. Business justification: FSMA Foreign Supplier Verification Program (FSVP) records are supplier-specific verification activities mandated by FDA. Links verification activities (audits, sampling, certifications) to suppliers f',
    `audit_created_timestamp` TIMESTAMP COMMENT 'Timestamp when the record was first captured in the lakehouse.',
    `audit_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the record.',
    `effective_end_date` DATE COMMENT 'Date the record ceases to be effective (null if open‑ended).',
    `effective_start_date` DATE COMMENT 'Date the record becomes effective for compliance purposes.',
    `facility_identifier` STRING COMMENT 'Identifier of the manufacturing or storage facility associated with the record.',
    `fsma_record_status` STRING COMMENT 'Current lifecycle status of the record.. Valid values are `active|inactive|archived|pending`',
    `importer_of_record` STRING COMMENT 'Name or identifier of the party responsible for import compliance.',
    `notes` STRING COMMENT 'Free‑form comments or observations related to the record.',
    `qualified_individual_name` STRING COMMENT 'Full name of the qualified individual who performed or signed off the verification.',
    `record_date` DATE COMMENT 'Date the compliance activity was performed or documented.',
    `record_name` STRING COMMENT 'Human‑readable name or title for the FSMA record, e.g., "Preventive Control Verification – 2024 Q1".',
    `record_number` STRING COMMENT 'Business identifier assigned to the compliance record, often a sequential or formatted number.',
    `record_type` STRING COMMENT 'Classification of the FSMA program the record belongs to.. Valid values are `preventive_control|produce_safety|fsvp|intentional_adulteration|traceability`',
    `retention_period_days` STRING COMMENT 'Number of days the record must be retained to satisfy regulatory requirements.',
    `source_system` STRING COMMENT 'Name of the source system that originated the record (e.g., TraceGains, SAP QM).',
    `verification_activity` STRING COMMENT 'Description of the verification activity performed (e.g., HACCP audit, hazard analysis).',
    `verification_frequency` STRING COMMENT 'Scheduled frequency of the verification activity.. Valid values are `daily|weekly|monthly|quarterly|annually`',
    CONSTRAINT pk_fsma_record PRIMARY KEY(`fsma_record_id`)
) COMMENT 'FSMA-mandated recordkeeping entries covering all Food Safety Modernization Act programs: Preventive Controls for Human Food (21 CFR Part 117), Produce Safety Rule (21 CFR Part 112), Foreign Supplier Verification Program (FSVP, 21 CFR Part 1 Subpart L), Intentional Adulteration (21 CFR Part 121), and FDA Food Traceability Rule (21 CFR Part 204). Captures record type (preventive control verification, supplier verification, produce safety inspection, FSVP hazard analysis, IA vulnerability assessment), associated facility or supplier, importer of record (for FSVP), record date, responsible qualified individual, verification activity performed, verification frequency, and retention period. Consolidates all FSMA program recordkeeping into a single product with record_type discriminator.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`regulatory`.`product_registration` (
    `product_registration_id` BIGINT COMMENT 'Unique surrogate key for each product registration record.',
    `allergen_declaration` STRING COMMENT 'Allergen status of the product as declared for the market.. Valid values are `none|contains|may_contain`',
    `approval_date` DATE COMMENT 'Date the registration was approved by the authority.',
    `batch_number_format` STRING COMMENT 'Pattern or format used for batch numbers associated with this registration.',
    `compliance_document_url` STRING COMMENT 'Link to the electronic compliance document stored in the DMS.',
    `country_code` STRING COMMENT 'Three‑letter ISO code of the market where the product is registered.. Valid values are `^[A-Z]{3}$`',
    `dossier_reference` STRING COMMENT 'Identifier of the regulatory dossier or file set supporting the registration.',
    `expiry_date` DATE COMMENT 'Date the registration expires or must be renewed.',
    `is_compliant` BOOLEAN COMMENT 'Indicates whether the product currently meets all applicable regulatory requirements.',
    `is_export_allowed` BOOLEAN COMMENT 'Indicates whether the product may be exported to other jurisdictions under this registration.',
    `is_renewal_required` BOOLEAN COMMENT 'True if the registration is approaching expiry and a renewal is required.',
    `issuing_authority` STRING COMMENT 'Regulatory body that issued the registration.. Valid values are `FDA|EFSA|Health Canada|ANVISA|Other`',
    `market_name` STRING COMMENT 'Descriptive name of the market (e.g., United States, Canada).',
    `notes` STRING COMMENT 'Free‑form comments or remarks about the registration.',
    `nutrition_facts_available` BOOLEAN COMMENT 'True if nutrition facts are provided on the product label for this market.',
    `packaging_material` STRING COMMENT 'Primary material used for the products packaging.. Valid values are `glass|plastic|metal|paper|composite`',
    `product_category` STRING COMMENT 'Broad category describing the product type.. Valid values are `beverage|snack|dairy|prepared_food|other`',
    `product_name` STRING COMMENT 'Human‑readable name of the product.',
    `product_sku` STRING COMMENT 'Stock Keeping Unit of the product linked to this registration.',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when the registration record was first created in the system.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the registration record.',
    `registration_number` STRING COMMENT 'Official registration identifier assigned by the issuing authority.',
    `registration_status` STRING COMMENT 'Current lifecycle status of the registration.. Valid values are `active|pending|withdrawn|expired|suspended`',
    `registration_status_date` DATE COMMENT 'Date when the current registration status was set.',
    `registration_type` STRING COMMENT 'Nature of the registration action (new, renewal, amendment).. Valid values are `initial|renewal|amendment`',
    `regulatory_change_indicator` BOOLEAN COMMENT 'True if a regulatory change affecting this product has been recorded.',
    `regulatory_section` STRING COMMENT 'Specific regulatory code or section (e.g., 21 CFR Part 101) governing the registration.',
    `shelf_life_days` STRING COMMENT 'Maximum number of days the product can be stored before it must be sold or discarded.',
    `storage_condition` STRING COMMENT 'Required storage condition for the product in the market.. Valid values are `ambient|refrigerated|frozen`',
    `version_number` STRING COMMENT 'Version of the registration record for change tracking.',
    CONSTRAINT pk_product_registration PRIMARY KEY(`product_registration_id`)
) COMMENT 'Country-level product registration and market authorization records for Food Beverage SKUs sold in regulated markets. Captures registration number, issuing authority (FDA, EFSA, Health Canada, ANVISA), registration status, approval date, expiry date, product category, and applicable regulatory dossier reference. Manages multi-country registration lifecycle for new product launches and reformulations.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`regulatory`.`label_approval` (
    `label_approval_id` BIGINT COMMENT 'Unique identifier for the label approval record.',
    `nutrition_label_id` BIGINT COMMENT 'Foreign key linking to regulatory.nutrition_label. Business justification: A label approval workflow approves the complete label artwork and packaging copy, which includes the Nutrition Facts Panel. The label_approval table has a nutrition_facts_verified boolean flag, confir',
    `product_registration_id` BIGINT COMMENT 'Foreign key linking to regulatory.product_registration. Business justification: Label approvals are tied to a specific product registration; linking captures which product the approval belongs to.',
    `allergen_declaration_verified` BOOLEAN COMMENT 'Indicates whether allergen statements have been verified.',
    `approval_status_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent status change (e.g., approved, rejected).',
    `approval_type` STRING COMMENT 'Type of approval request (e.g., new label, revision, reprint).. Valid values are `new|revision|reprint|update|withdrawal`',
    `certification_status` STRING COMMENT 'Current certification status of the packaging material.. Valid values are `certified|pending|failed`',
    `change_requested` BOOLEAN COMMENT 'Flag indicating whether the reviewer requested changes.',
    `claim_basis` STRING COMMENT 'Regulatory basis for the claim (e.g., FTC Green Guides, EU Regulation).',
    `claim_substantiation` STRING COMMENT 'Evidence or documentation supporting the sustainability claim.',
    `country_code` STRING COMMENT 'Three‑letter ISO country code of the primary market.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the label approval record was created.',
    `document_url` STRING COMMENT 'Link to the stored label artwork or PDF document.',
    `effective_date` DATE COMMENT 'Date when the approved label becomes effective for production.',
    `epr_registration_number` STRING COMMENT 'Registration number for EPR compliance in applicable jurisdictions.',
    `expiration_date` DATE COMMENT 'Date after which the label is no longer valid.',
    `final_approval_timestamp` TIMESTAMP COMMENT 'Timestamp when the label received final approval.',
    `label_approval_status` STRING COMMENT 'Current lifecycle status of the label approval.. Valid values are `draft|submitted|under_review|approved|rejected|withdrawn`',
    `label_code` STRING COMMENT 'Internal code used to uniquely identify the label within the organization.',
    `label_name` STRING COMMENT 'Human‑readable name of the product label.',
    `market` STRING COMMENT 'Geographic market or channel for which the label is intended (e.g., US, EU, Retail).',
    `marketing_claim_verified` BOOLEAN COMMENT 'Indicates whether marketing claims (e.g., low sugar) have been verified.',
    `nutrition_facts_verified` BOOLEAN COMMENT 'Indicates whether nutrition facts have been verified for compliance.',
    `packaging_material` STRING COMMENT 'Primary material of the packaging (e.g., PET, glass, aluminum).',
    `packaging_test_result` STRING COMMENT 'Result of EPA or EU packaging compliance testing (e.g., pass, fail, notes).',
    `recycled_content_pct` DECIMAL(18,2) COMMENT 'Percentage of recycled material in the packaging, expressed to two decimal places.',
    `regulatory_body` STRING COMMENT 'Regulatory authority governing the label requirements.. Valid values are `FDA|USDA|EFSA|EU|Other`',
    `rejection_reason` STRING COMMENT 'Reason provided by the reviewer for rejecting the label.',
    `required_changes` STRING COMMENT 'Detailed description of changes required for approval.',
    `reviewer_name` STRING COMMENT 'Full name of the reviewer responsible for the approval.',
    `submission_source` STRING COMMENT 'Origin of the label submission (internal team or external partner).. Valid values are `internal|external`',
    `submission_timestamp` TIMESTAMP COMMENT 'Date and time when the label was submitted for approval.',
    `sustainability_claim` STRING COMMENT 'Text of any sustainability or environmental claim on the label.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the record.',
    `version_number` STRING COMMENT 'Sequential version number of the label document.',
    CONSTRAINT pk_label_approval PRIMARY KEY(`label_approval_id`)
) COMMENT 'Workflow and approval records for all product label artwork, packaging copy, and packaging material compliance across all Food Beverage SKUs and markets. Tracks label version, submission date, regulatory reviewer, approval status, rejection reasons, required changes, final approval date, and effective date. Manages USDA pre-approval for meat/poultry labels, FDA label compliance sign-off, and nutrition facts panel verification. Covers allergen declaration accuracy, marketing claim regulatory basis, and ingredient statement compliance. Includes full packaging material regulatory compliance: EPA packaging requirements, EU Directive 94/62/EC heavy metal limits, recycled content percentage tracking, recyclability classification, extended producer responsibility (EPR) registration and state-level compliance, FTC Green Guides compliance for environmental marketing claims, and sustainability claims substantiation. Captures packaging component material type, compliance test results, and certification status. Links to nutrition_label and allergen_declaration. SSOT for all label and packaging regulatory approvals.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`regulatory`.`import_export_permit` (
    `import_export_permit_id` BIGINT COMMENT 'System-generated unique identifier for the import/export permit record.',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: Import/export permits are issued to legal entities; linking to company_code enables duty accounting, customs bond tracking, trade compliance financial reporting, and reconciliation of import duties pa',
    `establishment_registration_id` BIGINT COMMENT 'Foreign key linking to regulatory.establishment_registration. Business justification: Import/Export permits are issued to a specific establishment; linking to establishment_registration captures the relationship.',
    `product_registration_id` BIGINT COMMENT 'Foreign key linking to regulatory.product_registration. Business justification: An import/export permit authorizes the cross-border movement of a specific product. The product_registration record is the country-level market authorization that must exist before a product can be le',
    `audit_trail_created` TIMESTAMP COMMENT 'Timestamp when the permit record was first created in the data lake.',
    `audit_trail_updated` TIMESTAMP COMMENT 'Timestamp of the most recent update to the permit record.',
    `cbp_entry_compliance_flag` BOOLEAN COMMENT 'True if the shipment complies with U.S. Customs and Border Protection entry requirements.',
    `commodity_description` STRING COMMENT 'Free‑text description of the goods covered by the permit.',
    `compliance_checklist_status` STRING COMMENT 'Progress status of the internal compliance verification checklist.. Valid values are `not_started|in_progress|completed|failed`',
    `customs_document_number` STRING COMMENT 'Reference number of the associated customs filing (e.g., entry summary).',
    `destination_country` STRING COMMENT 'Three‑letter ISO country code of the intended destination.',
    `duty_rate` DECIMAL(18,2) COMMENT 'Applicable duty rate expressed as a percentage of customs value.',
    `effective_end_date` DATE COMMENT 'Date when the permit ceases to be effective (nullable for open‑ended permits).',
    `effective_start_date` DATE COMMENT 'Date when the permit becomes legally effective.',
    `eligibility_criteria` STRING COMMENT 'Business rules that qualify the shipment for the permit or preferential treatment.',
    `expiration_date` DATE COMMENT 'Date the permit expires according to regulatory rules.',
    `fda_prior_notice_flag` BOOLEAN COMMENT 'Indicates whether an FDA prior notice was submitted for the shipment.',
    `hs_code` STRING COMMENT 'International tariff classification code for the commodity.. Valid values are `^d{6,10}$`',
    `import_export_permit_status` STRING COMMENT 'Current lifecycle status of the permit.. Valid values are `draft|pending|active|suspended|revoked|expired`',
    `issuance_date` DATE COMMENT 'Date the permit was formally issued by the authority.',
    `issuing_authority` STRING COMMENT 'Regulatory body or agency that issued the permit.. Valid values are `FDA|USCBP|USDA|EPA|Customs|Other`',
    `issuing_office` STRING COMMENT 'Specific office or location of the authority that issued the permit.',
    `last_amended_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent amendment to the permit record.',
    `notes` STRING COMMENT 'Free‑form comments or observations related to the permit.',
    `origin_country` STRING COMMENT 'Three‑letter ISO country code of the products country of origin.',
    `origin_determination_method` STRING COMMENT 'Method used to establish country of origin (e.g., substantial transformation, COOL rules).. Valid values are `substantial_transformation|cool|manufacturer|supplier`',
    `permit_category` STRING COMMENT 'High‑level classification of the permit for reporting and analytics.. Valid values are `regulatory|customs|trade|safety`',
    `permit_issue_timestamp` TIMESTAMP COMMENT 'Exact timestamp when the permit was recorded in the source system.',
    `permit_number` STRING COMMENT 'Official permit number assigned by the issuing authority.',
    `permit_type` STRING COMMENT 'Indicates whether the permit is for import, export, re-export, transit, or temporary movement.. Valid values are `import|export|re-export|transit|temporary`',
    `preferential_agreement` STRING COMMENT 'Trade agreement that may reduce or eliminate duty.. Valid values are `NAFTA|USMCA|CAFTA|None`',
    `tariff_classification` STRING COMMENT 'Reference to the customs ruling that determines tariff treatment.',
    `transformation_details` STRING COMMENT 'Narrative of the processing steps that satisfy the origin determination method.',
    CONSTRAINT pk_import_export_permit PRIMARY KEY(`import_export_permit_id`)
) COMMENT 'Trade compliance master for cross-border movement of Food Beverage products and raw materials. Consolidates import/export permits, phytosanitary certificates, country-of-origin declarations (COOL/USDA 7 CFR Part 60), Harmonized System tariff classifications (HS/HTS/CN codes), preferential trade agreement eligibility, customs documentation, and duty rate management. Captures permit type, issuing authority, origin/destination countries, commodity description, tariff codes with classification ruling references, applicable duty rates, country-of-origin determination method (substantial transformation, COOL rules), permit validity, and shipment references. Supports FDA Prior Notice, CBP entry compliance, Free Trade Agreement qualification, and origin substantiation for labeling. SSOT for all trade compliance and customs data.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`regulatory`.`packaging_compliance` (
    `packaging_compliance_id` BIGINT COMMENT 'Unique identifier for the packaging compliance record.',
    `product_registration_id` BIGINT COMMENT 'Foreign key linking to regulatory.product_registration. Business justification: Packaging compliance records apply to a specific product registration; linking ties compliance to the product.',
    `claim_substantiation` STRING COMMENT 'Evidence or documentation supporting the sustainability claim.',
    `compliance_audit_date` DATE COMMENT 'Date of the most recent compliance audit.',
    `compliance_audit_result` STRING COMMENT 'Result of the latest compliance audit.. Valid values are `pass|fail|conditional`',
    `compliance_document_url` STRING COMMENT 'Link to the electronic compliance documentation.',
    `compliance_effective_date` DATE COMMENT 'Date when the packaging compliance became effective.',
    `compliance_expiration_date` DATE COMMENT 'Date when the packaging compliance expires or is due for renewal.',
    `compliance_record_number` STRING COMMENT 'External reference number assigned to the compliance record by regulatory authorities or internal tracking.',
    `dimensions_cm` STRING COMMENT 'Dimensions of the packaging expressed as LxWxH in centimeters.',
    `epa_compliance_status` STRING COMMENT 'Current EPA compliance status of the packaging.. Valid values are `compliant|non-compliant|pending`',
    `epr_registration_number` STRING COMMENT 'Registration number for the packaging under the Extended Producer Responsibility program.',
    `eu_directive_94_62_ec_compliant` BOOLEAN COMMENT 'Indicates compliance with the EU Packaging and Packaging Waste Directive.',
    `ftc_green_guides_claim` BOOLEAN COMMENT 'True if the packaging supports a marketing claim that complies with FTC Green Guides.',
    `gtin_code` STRING COMMENT '14‑digit Global Trade Item Number for the packaging.. Valid values are `^d{14}$`',
    `hazardous_substance_present` BOOLEAN COMMENT 'True if the packaging contains any regulated hazardous substances.',
    `heavy_metal_compliance` BOOLEAN COMMENT 'Indicates whether the packaging meets heavy‑metal limits defined in EU Directive 94/62/EC.',
    `heavy_metal_ppm` DECIMAL(18,2) COMMENT 'Measured concentration of heavy metals in the packaging material (parts per million).',
    `material_certification` STRING COMMENT 'Certification status of the packaging material.. Valid values are `FSC|PEFC|recycled|none`',
    `material_certification_number` STRING COMMENT 'Identifier of the material certification.',
    `material_supplier` STRING COMMENT 'Name of the supplier providing the packaging material.',
    `material_supplier_certified` BOOLEAN COMMENT 'Indicates whether the supplier holds required certifications.',
    `material_type` STRING COMMENT 'Primary material of the packaging (e.g., plastic, glass).. Valid values are `plastic|glass|metal|paper|composite|bioplastic`',
    `packaging_audit_trail` STRING COMMENT 'JSON‑encoded log of changes and audit events for the packaging compliance record.',
    `packaging_barcode` STRING COMMENT 'Barcode string printed on the packaging for scanning.',
    `packaging_color` STRING COMMENT 'Color description of the packaging (e.g., clear, amber, white).',
    `packaging_compliance_status` STRING COMMENT 'Current lifecycle status of the compliance record.. Valid values are `active|inactive|pending|retired`',
    `packaging_created_timestamp` TIMESTAMP COMMENT 'Timestamp when the packaging compliance record was created.',
    `packaging_disposal_method` STRING COMMENT 'Recommended disposal method for the packaging.. Valid values are `recycle|landfill|incinerate|compost`',
    `packaging_end_of_life_instructions` STRING COMMENT 'Guidance on how the packaging should be disposed or recycled at end of life.',
    `packaging_environmental_impact_score` DECIMAL(18,2) COMMENT 'Numeric score representing the overall environmental impact of the packaging.',
    `packaging_last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the packaging compliance record.',
    `packaging_name` STRING COMMENT 'Human‑readable name of the packaging component or design.',
    `packaging_origin_country` STRING COMMENT 'Three‑letter ISO country code of the packagings country of origin.. Valid values are `^[A-Z]{3}$`',
    `packaging_reuse_cycles` STRING COMMENT 'Number of times the packaging can be safely reused.',
    `packaging_type` STRING COMMENT 'Category of packaging (e.g., bottle, can, pouch, box, tray).. Valid values are `bottle|can|pouch|box|tray`',
    `packaging_weight_kg` DECIMAL(18,2) COMMENT 'Net weight of the packaging component in kilograms.',
    `recyclability_classification` STRING COMMENT 'Classification of the packagings recyclability according to EPA/EU standards.. Valid values are `recyclable|non-recyclable|compostable|reusable`',
    `recycled_content_percent` DECIMAL(18,2) COMMENT 'Percentage of the packaging that is made from recycled material.',
    `state_compliance_status` STRING COMMENT 'Compliance status of the packaging for the specific US state where it is sold.. Valid values are `^[A-Z]{2}$`',
    `sustainability_claim` STRING COMMENT 'Marketing claim describing the packagings sustainability attributes.',
    `upc_code` STRING COMMENT '12‑digit Universal Product Code assigned to the packaging.. Valid values are `^d{12}$`',
    CONSTRAINT pk_packaging_compliance PRIMARY KEY(`packaging_compliance_id`)
) COMMENT 'EPA and EU packaging compliance records for Food Beverage product packaging materials. Captures packaging component, material type, recyclability classification, recycled content percentage, heavy metal compliance (EU Directive 94/62/EC), extended producer responsibility (EPR) registration, state-level compliance status, and sustainability claims substantiation. Supports FTC Green Guides compliance for environmental marketing claims.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`regulatory`.`recall_event` (
    `recall_event_id` BIGINT COMMENT 'Unique surrogate key for each recall event record.',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: Recall financial liability, reserve accounting, P&L impact, and insurance claims require linking recall events to the responsible legal entity for financial statement reporting, SEC disclosure, and in',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Recall costs (product disposal, rework, reverse logistics, customer refunds) are charged to specific cost centers for management accounting, budget variance analysis, and operational performance measu',
    `establishment_registration_id` BIGINT COMMENT 'Foreign key linking to regulatory.establishment_registration. Business justification: A recall event is directly tied to the manufacturing establishment where the affected product was produced. While recall_event already references product_registration (the product-level record), it la',
    `product_registration_id` BIGINT COMMENT 'Foreign key linking to regulatory.product_registration. Business justification: Recall events are initiated for a specific product registration; linking provides direct reference to the affected product.',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: Recall events must be formally linked to the affected SKU for traceability, scope determination, and disposition reporting. The existing `affected_sku` is a denormalized plain-text field; replacing it',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to procurement.supplier. Business justification: Recalls often trace to supplier as root cause (contaminated ingredient, process failure). Required for supplier scorecard impact calculation, AVL suspension decisions, and CAPA tracking. Critical for ',
    `affected_lot_number` STRING COMMENT 'Batch or lot identifier(s) of the product subject to recall.',
    `agency_notification_date` DATE COMMENT 'Date the regulatory agency was formally notified of the recall.',
    `compliance_status` STRING COMMENT 'Current compliance standing of the product with relevant regulations.. Valid values are `compliant|non_compliant|under_review`',
    `consumer_notification_date` DATE COMMENT 'Date the first consumer notification was sent.',
    `consumer_notification_method` STRING COMMENT 'Channel(s) used to inform consumers about the recall.. Valid values are `email|phone|mail|website|media`',
    `corrective_action_plan` STRING COMMENT 'Planned or executed actions to prevent recurrence of the issue.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the recall record was first created in the system.',
    `distribution_scope` STRING COMMENT 'Geographic extent of the recall distribution.. Valid values are `national|regional|global|state|local`',
    `notes` STRING COMMENT 'Free‑form field for any additional remarks or observations.',
    `press_release_url` STRING COMMENT 'Web address of the public press release announcing the recall.',
    `product_category` STRING COMMENT 'High‑level category or segment the product belongs to (e.g., beverage, snack).',
    `product_name` STRING COMMENT 'Descriptive name of the recalled product.',
    `product_upc` STRING COMMENT 'Universal Product Code identifying the recalled product.',
    `recall_class` STRING COMMENT 'Regulatory classification indicating severity and health risk.. Valid values are `Class I|Class II|Class III`',
    `recall_date` TIMESTAMP COMMENT 'Date and time the recall was officially initiated.',
    `recall_effectiveness_status` STRING COMMENT 'Current status of the effectiveness check for the recall.. Valid values are `pending|completed|failed`',
    `recall_event_status` STRING COMMENT 'Current lifecycle status of the recall event.. Valid values are `open|closed|in_progress|cancelled`',
    `recall_initiated_by` STRING COMMENT 'Whether the recall was initiated voluntarily by the company or mandated by a regulator.. Valid values are `voluntary|mandated`',
    `recall_number` STRING COMMENT 'Official recall identifier assigned by the regulatory agency (e.g., R-2023-001).',
    `recall_priority` STRING COMMENT 'Priority level assigned to the recall based on risk assessment.. Valid values are `high|medium|low`',
    `recall_reason` STRING COMMENT 'Root cause for the recall (e.g., contamination, allergen, mislabeling). [ENUM-REF-CANDIDATE: contamination|allergen|mislabeling|foreign_object|microbial|chemical|labeling_error — promote to reference product]',
    `recall_type` STRING COMMENT 'Indicates whether the recall covers the entire product line (full) or a subset (partial).. Valid values are `full|partial`',
    `regulatory_agency` STRING COMMENT 'Agency overseeing the recall (e.g., FDA, USDA).. Valid values are `FDA|USDA|EFSA|GFSI`',
    `root_cause_analysis` STRING COMMENT 'Narrative description of the investigation findings that identified the cause of the issue.',
    `total_units_affected` BIGINT COMMENT 'Total number of product units identified as affected.',
    `total_units_disposed` BIGINT COMMENT 'Number of recovered units that have been destroyed or otherwise disposed.',
    `total_units_recovered` BIGINT COMMENT 'Number of affected units that have been retrieved from the market.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the recall record.',
    CONSTRAINT pk_recall_event PRIMARY KEY(`recall_event_id`)
) COMMENT 'Master record of product recall and market withdrawal events initiated voluntarily or mandated by FDA/USDA. Captures recall classification (Class I/II/III), recall reason (allergen, contamination, mislabeling), affected SKUs and lot numbers, distribution scope, recall strategy, press release reference, agency notification date, and recall effectiveness check status. SSOT for all recall lifecycle management.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`regulatory`.`gfsi_certification` (
    `gfsi_certification_id` BIGINT COMMENT 'Unique surrogate key for each GFSI certification record.',
    `establishment_registration_id` BIGINT COMMENT 'Foreign key linking to regulatory.establishment_registration. Business justification: GFSI certifications are granted to a manufacturing establishment; linking to establishment_registration records the certified site.',
    `food_safety_plan_id` BIGINT COMMENT 'Foreign key linking to regulatory.food_safety_plan. Business justification: GFSI scheme certifications (SQF, BRC, FSSC 22000, IFS) are awarded to facilities that demonstrate a robust, documented food safety management system. The food_safety_plan is the FSMA-aligned master do',
    `supplier_site_id` BIGINT COMMENT 'Identifier of the facility/site the certification applies to.',
    `audit_findings_summary` STRING COMMENT 'Brief summary of major findings from the latest audit.',
    `audit_methodology` STRING COMMENT 'Methodology used for the audit (e.g., on-site, remote, hybrid).',
    `audit_report_reference` STRING COMMENT 'Reference number or identifier for the audit report document.',
    `auditor_name` STRING COMMENT 'Name of the lead auditor who performed the most recent audit.',
    `certificate_document_url` STRING COMMENT 'Link to the digital copy of the certification document.',
    `certification_body` STRING COMMENT 'Name of the external certification organization (e.g., SQF Institute, BRCGS).',
    `certification_cost` DECIMAL(18,2) COMMENT 'Total cost incurred for obtaining the certification.',
    `certification_number` STRING COMMENT 'Official certification number assigned by the certification body.',
    `certification_scope_code` STRING COMMENT 'Standardized code representing the certification scope (e.g., FS for Food Safety).',
    `certification_status` STRING COMMENT 'Current status of the certification.. Valid values are `active|suspended|revoked|expired|pending`',
    `certification_type` STRING COMMENT 'Indicates whether the record is for an initial certification, renewal, extension, or reassessment.. Valid values are `initial|renewal|extension|reassessment`',
    `compliance_notes` STRING COMMENT 'Free-text notes on compliance observations or corrective actions.',
    `corrective_action_due_date` DATE COMMENT 'Deadline for completing required corrective actions.',
    `corrective_action_required` BOOLEAN COMMENT 'Indicates whether corrective actions were required after the audit.',
    `country_code` STRING COMMENT 'Three-letter ISO country code where the certified facility is located.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the certification record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO currency code for certification cost.. Valid values are `^[A-Z]{3}$`',
    `effective_from` DATE COMMENT 'Date from which the certification is considered effective (may be same as issue_date).',
    `effective_until` DATE COMMENT 'Date until which the certification remains valid (may be same as expiry_date).',
    `expiry_date` DATE COMMENT 'Date when the certification expires.',
    `external_audit_provider` STRING COMMENT 'Name of the third-party audit provider, if different from certification body.',
    `grade_level` STRING COMMENT 'Grade or level assigned by the certification body, if applicable.. Valid values are `A|B|C|D|E|F`',
    `is_active` BOOLEAN COMMENT 'Indicates if the certification record is currently active in the system.',
    `is_multi_site` BOOLEAN COMMENT 'Indicates if the certification covers multiple sites under a single certificate.',
    `issue_date` DATE COMMENT 'Date when the certification was officially issued.',
    `last_modified_by` STRING COMMENT 'User identifier who performed the last update.',
    `next_audit_date` DATE COMMENT 'Planned date for the next surveillance audit.',
    `notes` STRING COMMENT 'Additional free-text notes.',
    `number_of_sites` STRING COMMENT 'Count of sites covered by this certification record.',
    `regulatory_body` STRING COMMENT 'Governing body associated with the certification (e.g., FDA, USDA, EFSA).',
    `renewal_notice_date` DATE COMMENT 'Date when renewal notice was sent to the facility.',
    `renewal_required` BOOLEAN COMMENT 'Indicates if a renewal is required before expiry.',
    `scheme_name` STRING COMMENT 'Name of the GFSI scheme (e.g., SQF, BRC, FSSC 22000, IFS, GlobalG.A.P.).',
    `scheme_version` STRING COMMENT 'Version identifier of the certification scheme.',
    `scope_description` STRING COMMENT 'Textual description of the scope (e.g., facilities, product lines, processes) covered by the certification.',
    `site_name` STRING COMMENT 'Human readable name of the facility.',
    `surveillance_audit_frequency` STRING COMMENT 'Frequency of scheduled surveillance audits.. Valid values are `annual|biennial|triennial`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the certification record.',
    CONSTRAINT pk_gfsi_certification PRIMARY KEY(`gfsi_certification_id`)
) COMMENT 'GFSI scheme certification records for Food Beverage facilities, including SQF, BRC, FSSC 22000, IFS, and GlobalG.A.P. certifications. Captures certification body, scheme version, scope, certification grade/level, issue date, expiry date, surveillance audit schedule, and certificate document reference. Tracks multi-site certification status and customer-required certification compliance.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`regulatory`.`food_safety_plan` (
    `food_safety_plan_id` BIGINT COMMENT 'System‑generated unique identifier for the food safety plan record.',
    `establishment_registration_id` BIGINT COMMENT 'Foreign key linking to regulatory.establishment_registration. Business justification: Food safety plans are created for a specific establishment; linking to establishment_registration captures ownership.',
    `plant_id` BIGINT COMMENT 'Identifier of the manufacturing or processing facility to which the plan applies.',
    `supplier_site_id` BIGINT COMMENT 'Foreign key linking to procurement.supplier_site. Business justification: Co-manufacturers and contract packer sites must maintain site-specific food safety plans (HACCP, HARPC). Links supplier site plans to procurement for audit verification, AVL approval, and GFSI certifi',
    `approval_date` DATE COMMENT 'Date the plan received formal approval.',
    `approval_status` STRING COMMENT 'Current status of the approval process.. Valid values are `approved|rejected|pending`',
    `approved_by_name` STRING COMMENT 'Full legal name of the qualified individual who signed off the plan.',
    `approved_by_title` STRING COMMENT 'Job title or role of the individual who approved the plan.',
    `ccp_count` STRING COMMENT 'Number of critical control points identified in the plan.',
    `compliance_status` STRING COMMENT 'Current compliance status of the plan against applicable regulations.. Valid values are `compliant|non-compliant|under review`',
    `corrective_action_procedure_description` STRING COMMENT 'Procedures to be followed when a critical limit is breached.',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the food safety plan record was first created in the system.',
    `critical_limits_description` STRING COMMENT 'Narrative description of the critical limits for each CCP.',
    `document_storage_path` STRING COMMENT 'File system or repository path where the plan document is stored.',
    `document_version` STRING COMMENT 'Version identifier of the stored plan document.',
    `effective_end_date` DATE COMMENT 'Date when the plan expires or is superseded (nullable for open‑ended plans).',
    `effective_start_date` DATE COMMENT 'Date when the plan becomes effective.',
    `food_safety_plan_status` STRING COMMENT 'Current lifecycle status of the food safety plan.. Valid values are `draft|active|inactive|revoked|pending|archived`',
    `last_review_date` DATE COMMENT 'Date of the most recent formal review of the plan.',
    `monitoring_procedure_description` STRING COMMENT 'Details of how each CCP is monitored (frequency, method, responsible party).',
    `next_reanalysis_date` DATE COMMENT 'Planned date for the next hazard analysis re‑evaluation.',
    `notes` STRING COMMENT 'Free‑form field for additional comments or observations.',
    `plan_name` STRING COMMENT 'Descriptive name of the food safety plan used by personnel.',
    `plan_type` STRING COMMENT 'Indicates whether the plan follows HACCP, FSMA Preventive Controls, or a combined approach.. Valid values are `HACCP|Preventive Controls|Combined`',
    `product_category_code` STRING COMMENT 'Code representing the product category (e.g., snack, beverage, dairy) covered by the plan.',
    `regulatory_body` STRING COMMENT 'Primary regulatory agency governing the plan (e.g., FDA, USDA).. Valid values are `FDA|USDA|EFSA|GFSI`',
    `risk_level` STRING COMMENT 'Overall risk rating assigned to the plan based on hazard severity and control robustness.. Valid values are `low|medium|high|critical`',
    `training_completion_date` DATE COMMENT 'Date when required training was completed.',
    `training_required` BOOLEAN COMMENT 'Indicates whether personnel training is required to implement the plan.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent modification to the plan record.',
    `verification_activity_description` STRING COMMENT 'Periodic verification steps to ensure the plan remains effective.',
    `version_number` STRING COMMENT 'Version label of the plan (e.g., v1.0, v2.1).',
    CONSTRAINT pk_food_safety_plan PRIMARY KEY(`food_safety_plan_id`)
) COMMENT 'Unified food safety plan master records covering both FSMA Preventive Controls (21 CFR Part 117) and USDA HACCP (9 CFR Part 417) requirements for each facility and product category. Documents hazard analysis, critical control points, preventive controls (process, allergen, sanitation, supply chain), critical limits, monitoring procedures, corrective action procedures, verification activities, and recall plan reference. Captures plan type (HACCP, Preventive Controls, combined), plan version, qualified individual sign-off, approval status, last review date, and reanalysis schedule. SSOT for all facility-level food safety documentation.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `food_beverage_ecm`.`regulatory`.`facility_inspection` ADD CONSTRAINT `fk_regulatory_facility_inspection_establishment_registration_id` FOREIGN KEY (`establishment_registration_id`) REFERENCES `food_beverage_ecm`.`regulatory`.`establishment_registration`(`establishment_registration_id`);
ALTER TABLE `food_beverage_ecm`.`regulatory`.`facility_inspection` ADD CONSTRAINT `fk_regulatory_facility_inspection_food_safety_plan_id` FOREIGN KEY (`food_safety_plan_id`) REFERENCES `food_beverage_ecm`.`regulatory`.`food_safety_plan`(`food_safety_plan_id`);
ALTER TABLE `food_beverage_ecm`.`regulatory`.`nutrition_label` ADD CONSTRAINT `fk_regulatory_nutrition_label_product_registration_id` FOREIGN KEY (`product_registration_id`) REFERENCES `food_beverage_ecm`.`regulatory`.`product_registration`(`product_registration_id`);
ALTER TABLE `food_beverage_ecm`.`regulatory`.`fsma_record` ADD CONSTRAINT `fk_regulatory_fsma_record_establishment_registration_id` FOREIGN KEY (`establishment_registration_id`) REFERENCES `food_beverage_ecm`.`regulatory`.`establishment_registration`(`establishment_registration_id`);
ALTER TABLE `food_beverage_ecm`.`regulatory`.`fsma_record` ADD CONSTRAINT `fk_regulatory_fsma_record_food_safety_plan_id` FOREIGN KEY (`food_safety_plan_id`) REFERENCES `food_beverage_ecm`.`regulatory`.`food_safety_plan`(`food_safety_plan_id`);
ALTER TABLE `food_beverage_ecm`.`regulatory`.`label_approval` ADD CONSTRAINT `fk_regulatory_label_approval_nutrition_label_id` FOREIGN KEY (`nutrition_label_id`) REFERENCES `food_beverage_ecm`.`regulatory`.`nutrition_label`(`nutrition_label_id`);
ALTER TABLE `food_beverage_ecm`.`regulatory`.`label_approval` ADD CONSTRAINT `fk_regulatory_label_approval_product_registration_id` FOREIGN KEY (`product_registration_id`) REFERENCES `food_beverage_ecm`.`regulatory`.`product_registration`(`product_registration_id`);
ALTER TABLE `food_beverage_ecm`.`regulatory`.`import_export_permit` ADD CONSTRAINT `fk_regulatory_import_export_permit_establishment_registration_id` FOREIGN KEY (`establishment_registration_id`) REFERENCES `food_beverage_ecm`.`regulatory`.`establishment_registration`(`establishment_registration_id`);
ALTER TABLE `food_beverage_ecm`.`regulatory`.`import_export_permit` ADD CONSTRAINT `fk_regulatory_import_export_permit_product_registration_id` FOREIGN KEY (`product_registration_id`) REFERENCES `food_beverage_ecm`.`regulatory`.`product_registration`(`product_registration_id`);
ALTER TABLE `food_beverage_ecm`.`regulatory`.`packaging_compliance` ADD CONSTRAINT `fk_regulatory_packaging_compliance_product_registration_id` FOREIGN KEY (`product_registration_id`) REFERENCES `food_beverage_ecm`.`regulatory`.`product_registration`(`product_registration_id`);
ALTER TABLE `food_beverage_ecm`.`regulatory`.`recall_event` ADD CONSTRAINT `fk_regulatory_recall_event_establishment_registration_id` FOREIGN KEY (`establishment_registration_id`) REFERENCES `food_beverage_ecm`.`regulatory`.`establishment_registration`(`establishment_registration_id`);
ALTER TABLE `food_beverage_ecm`.`regulatory`.`recall_event` ADD CONSTRAINT `fk_regulatory_recall_event_product_registration_id` FOREIGN KEY (`product_registration_id`) REFERENCES `food_beverage_ecm`.`regulatory`.`product_registration`(`product_registration_id`);
ALTER TABLE `food_beverage_ecm`.`regulatory`.`gfsi_certification` ADD CONSTRAINT `fk_regulatory_gfsi_certification_establishment_registration_id` FOREIGN KEY (`establishment_registration_id`) REFERENCES `food_beverage_ecm`.`regulatory`.`establishment_registration`(`establishment_registration_id`);
ALTER TABLE `food_beverage_ecm`.`regulatory`.`gfsi_certification` ADD CONSTRAINT `fk_regulatory_gfsi_certification_food_safety_plan_id` FOREIGN KEY (`food_safety_plan_id`) REFERENCES `food_beverage_ecm`.`regulatory`.`food_safety_plan`(`food_safety_plan_id`);
ALTER TABLE `food_beverage_ecm`.`regulatory`.`food_safety_plan` ADD CONSTRAINT `fk_regulatory_food_safety_plan_establishment_registration_id` FOREIGN KEY (`establishment_registration_id`) REFERENCES `food_beverage_ecm`.`regulatory`.`establishment_registration`(`establishment_registration_id`);

-- ========= TAGS =========
ALTER SCHEMA `food_beverage_ecm`.`regulatory` SET TAGS ('dbx_division' = 'corporate');
ALTER SCHEMA `food_beverage_ecm`.`regulatory` SET TAGS ('dbx_domain' = 'regulatory');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`establishment_registration` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`establishment_registration` SET TAGS ('dbx_subdomain' = 'facility_compliance');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`establishment_registration` ALTER COLUMN `establishment_registration_id` SET TAGS ('dbx_business_glossary_term' = 'Establishment Registration ID');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`establishment_registration` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`establishment_registration` ALTER COLUMN `address_line1` SET TAGS ('dbx_business_glossary_term' = 'Address Line 1 (ADDR1)');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`establishment_registration` ALTER COLUMN `address_line1` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`establishment_registration` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`establishment_registration` ALTER COLUMN `address_line2` SET TAGS ('dbx_business_glossary_term' = 'Address Line 2 (ADDR2)');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`establishment_registration` ALTER COLUMN `address_line2` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`establishment_registration` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`establishment_registration` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City (CITY)');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`establishment_registration` ALTER COLUMN `compliance_programs` SET TAGS ('dbx_business_glossary_term' = 'Compliance Programs (COMPLIANCE_PROGS)');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`establishment_registration` ALTER COLUMN `country` SET TAGS ('dbx_business_glossary_term' = 'Country Code (COUNTRY)');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`establishment_registration` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (CREATED_TS)');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`establishment_registration` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date (EFF_DATE)');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`establishment_registration` ALTER COLUMN `email_address` SET TAGS ('dbx_business_glossary_term' = 'Facility Email Address (EMAIL)');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`establishment_registration` ALTER COLUMN `email_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`establishment_registration` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`establishment_registration` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date (EXP_DATE)');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`establishment_registration` ALTER COLUMN `facility_name` SET TAGS ('dbx_business_glossary_term' = 'Facility Name (FAC_NAME)');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`establishment_registration` ALTER COLUMN `facility_type` SET TAGS ('dbx_business_glossary_term' = 'Facility Type (FAC_TYPE)');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`establishment_registration` ALTER COLUMN `last_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Last Inspection Date (LAST_INSP)');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`establishment_registration` ALTER COLUMN `next_inspection_due` SET TAGS ('dbx_business_glossary_term' = 'Next Inspection Due Date (NEXT_INSP)');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`establishment_registration` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes (NOTES)');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`establishment_registration` ALTER COLUMN `phone_number` SET TAGS ('dbx_business_glossary_term' = 'Facility Phone Number (PHONE)');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`establishment_registration` ALTER COLUMN `phone_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`establishment_registration` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`establishment_registration` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code (ZIP)');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`establishment_registration` ALTER COLUMN `postal_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`establishment_registration` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`establishment_registration` ALTER COLUMN `registration_number` SET TAGS ('dbx_business_glossary_term' = 'FDA/USDA Registration Number (REG_NUM)');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`establishment_registration` ALTER COLUMN `registration_program` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Program (REG_PROG)');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`establishment_registration` ALTER COLUMN `registration_program` SET TAGS ('dbx_value_regex' = 'FSMA|HACCP|SQF|GMP|FSSC|ISO22000');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`establishment_registration` ALTER COLUMN `registration_source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System (SRC_SYS)');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`establishment_registration` ALTER COLUMN `registration_status` SET TAGS ('dbx_business_glossary_term' = 'Registration Status (REG_STATUS)');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`establishment_registration` ALTER COLUMN `registration_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|pending|revoked');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`establishment_registration` ALTER COLUMN `registration_status_date` SET TAGS ('dbx_business_glossary_term' = 'Registration Status Date (STATUS_DATE)');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`establishment_registration` ALTER COLUMN `renewal_due_date` SET TAGS ('dbx_business_glossary_term' = 'Renewal Due Date (RENEW_DUE)');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`establishment_registration` ALTER COLUMN `state` SET TAGS ('dbx_business_glossary_term' = 'State/Province (STATE)');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`establishment_registration` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (UPDATED_TS)');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`facility_inspection` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`facility_inspection` SET TAGS ('dbx_subdomain' = 'facility_compliance');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`facility_inspection` ALTER COLUMN `facility_inspection_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Inspection ID');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`facility_inspection` ALTER COLUMN `establishment_registration_id` SET TAGS ('dbx_business_glossary_term' = 'Establishment Registration Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`facility_inspection` ALTER COLUMN `food_safety_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Food Safety Plan Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`facility_inspection` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Identifier (FACILITY_ID)');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`facility_inspection` ALTER COLUMN `supplier_site_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Site Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`facility_inspection` ALTER COLUMN `audit_trail_notes` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail Notes (AUDIT_NOTES)');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`facility_inspection` ALTER COLUMN `corrective_action_deadline` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Deadline (CA_DEADLINE)');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`facility_inspection` ALTER COLUMN `corrective_action_status` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Status (CA_STATUS)');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`facility_inspection` ALTER COLUMN `corrective_action_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|completed');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`facility_inspection` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (CREATED_TS)');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`facility_inspection` ALTER COLUMN `disposition` SET TAGS ('dbx_business_glossary_term' = 'Inspection Disposition (DISPOSITION)');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`facility_inspection` ALTER COLUMN `disposition` SET TAGS ('dbx_value_regex' = 'no_action|rework|reinspect|closed');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`facility_inspection` ALTER COLUMN `documentation_attached` SET TAGS ('dbx_business_glossary_term' = 'Documentation Attached Flag (DOC_ATTACHED)');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`facility_inspection` ALTER COLUMN `facility_inspection_status` SET TAGS ('dbx_business_glossary_term' = 'Inspection Status (STATUS)');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`facility_inspection` ALTER COLUMN `facility_inspection_status` SET TAGS ('dbx_value_regex' = 'pending|in_progress|completed|closed|cancelled');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`facility_inspection` ALTER COLUMN `facility_name` SET TAGS ('dbx_business_glossary_term' = 'Facility Name (FACILITY_NAME)');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`facility_inspection` ALTER COLUMN `facility_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`facility_inspection` ALTER COLUMN `findings_summary` SET TAGS ('dbx_business_glossary_term' = 'Findings Summary (FINDINGS)');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`facility_inspection` ALTER COLUMN `follow_up_required` SET TAGS ('dbx_business_glossary_term' = 'Follow‑Up Required Flag (FOLLOW_UP)');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`facility_inspection` ALTER COLUMN `inspection_location` SET TAGS ('dbx_business_glossary_term' = 'Inspection Location (LOCATION)');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`facility_inspection` ALTER COLUMN `inspection_location` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`facility_inspection` ALTER COLUMN `inspection_location` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`facility_inspection` ALTER COLUMN `inspection_number` SET TAGS ('dbx_business_glossary_term' = 'Inspection Number (INSPECT_NO)');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`facility_inspection` ALTER COLUMN `inspection_report_url` SET TAGS ('dbx_business_glossary_term' = 'Inspection Report URL (REPORT_URL)');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`facility_inspection` ALTER COLUMN `inspection_scope` SET TAGS ('dbx_business_glossary_term' = 'Inspection Scope (SCOPE)');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`facility_inspection` ALTER COLUMN `inspection_scope` SET TAGS ('dbx_value_regex' = 'sanitation|process|labeling|equipment|storage|distribution');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`facility_inspection` ALTER COLUMN `inspection_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Inspection Date/Time (INSPECTION_TS)');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`facility_inspection` ALTER COLUMN `inspection_type` SET TAGS ('dbx_business_glossary_term' = 'Inspection Type (TYPE)');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`facility_inspection` ALTER COLUMN `inspection_type` SET TAGS ('dbx_value_regex' = 'routine|for_cause|pre_approval|follow_up');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`facility_inspection` ALTER COLUMN `inspector_name` SET TAGS ('dbx_business_glossary_term' = 'Inspector Full Name (INSPECTOR_NAME)');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`facility_inspection` ALTER COLUMN `inspector_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`facility_inspection` ALTER COLUMN `inspector_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`facility_inspection` ALTER COLUMN `observations` SET TAGS ('dbx_business_glossary_term' = 'Detailed Observations (OBSERVATIONS)');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`facility_inspection` ALTER COLUMN `regulatory_body` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Body (REG_BODY)');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`facility_inspection` ALTER COLUMN `regulatory_body` SET TAGS ('dbx_value_regex' = 'FDA|USDA|EFSA|GFSI|State_Agency');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`facility_inspection` ALTER COLUMN `severity_level` SET TAGS ('dbx_business_glossary_term' = 'Severity Level (SEVERITY)');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`facility_inspection` ALTER COLUMN `severity_level` SET TAGS ('dbx_value_regex' = 'critical|major|minor|informational');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`facility_inspection` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (UPDATED_TS)');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`nutrition_label` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`nutrition_label` SET TAGS ('dbx_subdomain' = 'product_authorization');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`nutrition_label` ALTER COLUMN `nutrition_label_id` SET TAGS ('dbx_business_glossary_term' = 'Nutrition Label ID');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`nutrition_label` ALTER COLUMN `product_registration_id` SET TAGS ('dbx_business_glossary_term' = 'Product Registration Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`nutrition_label` ALTER COLUMN `added_sugars_g` SET TAGS ('dbx_business_glossary_term' = 'Added Sugars (g)');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`nutrition_label` ALTER COLUMN `allergen_declaration` SET TAGS ('dbx_business_glossary_term' = 'Allergen Declaration');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`nutrition_label` ALTER COLUMN `calcium_mg` SET TAGS ('dbx_business_glossary_term' = 'Calcium (mg)');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`nutrition_label` ALTER COLUMN `calories` SET TAGS ('dbx_business_glossary_term' = 'Calories (kcal)');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`nutrition_label` ALTER COLUMN `cholesterol_mg` SET TAGS ('dbx_business_glossary_term' = 'Cholesterol (mg)');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`nutrition_label` ALTER COLUMN `country` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`nutrition_label` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`nutrition_label` ALTER COLUMN `dietary_fiber_g` SET TAGS ('dbx_business_glossary_term' = 'Dietary Fiber (g)');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`nutrition_label` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`nutrition_label` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`nutrition_label` ALTER COLUMN `gtin` SET TAGS ('dbx_business_glossary_term' = 'Global Trade Item Number (GTIN)');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`nutrition_label` ALTER COLUMN `iron_mg` SET TAGS ('dbx_business_glossary_term' = 'Iron (mg)');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`nutrition_label` ALTER COLUMN `is_gluten_free` SET TAGS ('dbx_business_glossary_term' = 'Gluten‑Free Claim Flag');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`nutrition_label` ALTER COLUMN `is_halal` SET TAGS ('dbx_business_glossary_term' = 'Halal Claim Flag');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`nutrition_label` ALTER COLUMN `is_kosher` SET TAGS ('dbx_business_glossary_term' = 'Kosher Claim Flag');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`nutrition_label` ALTER COLUMN `is_non_gmo` SET TAGS ('dbx_business_glossary_term' = 'Non‑GMO Claim Flag');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`nutrition_label` ALTER COLUMN `is_organic` SET TAGS ('dbx_business_glossary_term' = 'Organic Claim Flag');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`nutrition_label` ALTER COLUMN `is_vegan` SET TAGS ('dbx_business_glossary_term' = 'Vegan Claim Flag');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`nutrition_label` ALTER COLUMN `label_format` SET TAGS ('dbx_business_glossary_term' = 'Label Format');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`nutrition_label` ALTER COLUMN `label_format` SET TAGS ('dbx_value_regex' = 'US|EU|CA');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`nutrition_label` ALTER COLUMN `label_name` SET TAGS ('dbx_business_glossary_term' = 'Nutrition Label Name');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`nutrition_label` ALTER COLUMN `label_source` SET TAGS ('dbx_business_glossary_term' = 'Label Source System');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`nutrition_label` ALTER COLUMN `label_status` SET TAGS ('dbx_business_glossary_term' = 'Nutrition Label Status');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`nutrition_label` ALTER COLUMN `label_status` SET TAGS ('dbx_value_regex' = 'active|inactive|archived');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`nutrition_label` ALTER COLUMN `last_reviewed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Reviewed Timestamp');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`nutrition_label` ALTER COLUMN `nutrition_facts_version` SET TAGS ('dbx_business_glossary_term' = 'Nutrition Facts Version');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`nutrition_label` ALTER COLUMN `protein_g` SET TAGS ('dbx_business_glossary_term' = 'Protein (g)');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`nutrition_label` ALTER COLUMN `regulatory_compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Status');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`nutrition_label` ALTER COLUMN `regulatory_compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`nutrition_label` ALTER COLUMN `saturated_fat_g` SET TAGS ('dbx_business_glossary_term' = 'Saturated Fat (g)');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`nutrition_label` ALTER COLUMN `serving_size` SET TAGS ('dbx_business_glossary_term' = 'Serving Size (Text)');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`nutrition_label` ALTER COLUMN `serving_size_grams` SET TAGS ('dbx_business_glossary_term' = 'Serving Size (Grams)');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`nutrition_label` ALTER COLUMN `servings_per_container` SET TAGS ('dbx_business_glossary_term' = 'Servings Per Container');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`nutrition_label` ALTER COLUMN `sku` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU)');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`nutrition_label` ALTER COLUMN `sodium_mg` SET TAGS ('dbx_business_glossary_term' = 'Sodium (mg)');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`nutrition_label` ALTER COLUMN `total_carbohydrate_g` SET TAGS ('dbx_business_glossary_term' = 'Total Carbohydrate (g)');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`nutrition_label` ALTER COLUMN `total_fat_g` SET TAGS ('dbx_business_glossary_term' = 'Total Fat (g)');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`nutrition_label` ALTER COLUMN `total_sugars_g` SET TAGS ('dbx_business_glossary_term' = 'Total Sugars (g)');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`nutrition_label` ALTER COLUMN `trans_fat_g` SET TAGS ('dbx_business_glossary_term' = 'Trans Fat (g)');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`nutrition_label` ALTER COLUMN `upc` SET TAGS ('dbx_business_glossary_term' = 'Universal Product Code (UPC)');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`nutrition_label` ALTER COLUMN `upc` SET TAGS ('dbx_value_regex' = '^[0-9]{12}$');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`nutrition_label` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`nutrition_label` ALTER COLUMN `vitamin_a_iu` SET TAGS ('dbx_business_glossary_term' = 'Vitamin A (IU)');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`nutrition_label` ALTER COLUMN `vitamin_c_mg` SET TAGS ('dbx_business_glossary_term' = 'Vitamin C (mg)');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`fsma_record` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`fsma_record` SET TAGS ('dbx_subdomain' = 'safety_monitoring');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`fsma_record` ALTER COLUMN `fsma_record_id` SET TAGS ('dbx_business_glossary_term' = 'FSMA Record Identifier');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`fsma_record` ALTER COLUMN `establishment_registration_id` SET TAGS ('dbx_business_glossary_term' = 'Establishment Registration Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`fsma_record` ALTER COLUMN `food_safety_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Food Safety Plan Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`fsma_record` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`fsma_record` ALTER COLUMN `audit_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Created Timestamp (AUDIT_CREATED_TS)');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`fsma_record` ALTER COLUMN `audit_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Updated Timestamp (AUDIT_UPDATED_TS)');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`fsma_record` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date (EFFECTIVE_UNTIL)');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`fsma_record` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date (EFFECTIVE_FROM)');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`fsma_record` ALTER COLUMN `facility_identifier` SET TAGS ('dbx_business_glossary_term' = 'Facility Identifier (FAC_ID)');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`fsma_record` ALTER COLUMN `fsma_record_status` SET TAGS ('dbx_business_glossary_term' = 'Record Status (REC_STATUS)');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`fsma_record` ALTER COLUMN `fsma_record_status` SET TAGS ('dbx_value_regex' = 'active|inactive|archived|pending');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`fsma_record` ALTER COLUMN `importer_of_record` SET TAGS ('dbx_business_glossary_term' = 'Importer of Record (IMP_OF_REC)');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`fsma_record` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Record Notes (REC_NOTES)');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`fsma_record` ALTER COLUMN `qualified_individual_name` SET TAGS ('dbx_business_glossary_term' = 'Qualified Individual Name (QUAL_INDIV_NAME)');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`fsma_record` ALTER COLUMN `qualified_individual_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`fsma_record` ALTER COLUMN `qualified_individual_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`fsma_record` ALTER COLUMN `record_date` SET TAGS ('dbx_business_glossary_term' = 'Record Date (REC_DATE)');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`fsma_record` ALTER COLUMN `record_name` SET TAGS ('dbx_business_glossary_term' = 'Record Name (REC_NAME)');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`fsma_record` ALTER COLUMN `record_number` SET TAGS ('dbx_business_glossary_term' = 'Record Number (REC_NUM)');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`fsma_record` ALTER COLUMN `record_type` SET TAGS ('dbx_business_glossary_term' = 'Record Type (REC_TYPE)');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`fsma_record` ALTER COLUMN `record_type` SET TAGS ('dbx_value_regex' = 'preventive_control|produce_safety|fsvp|intentional_adulteration|traceability');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`fsma_record` ALTER COLUMN `retention_period_days` SET TAGS ('dbx_business_glossary_term' = 'Retention Period (RETENTION_DAYS)');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`fsma_record` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System (SRC_SYS)');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`fsma_record` ALTER COLUMN `verification_activity` SET TAGS ('dbx_business_glossary_term' = 'Verification Activity (VERIF_ACT)');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`fsma_record` ALTER COLUMN `verification_frequency` SET TAGS ('dbx_business_glossary_term' = 'Verification Frequency (VERIF_FREQ)');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`fsma_record` ALTER COLUMN `verification_frequency` SET TAGS ('dbx_value_regex' = 'daily|weekly|monthly|quarterly|annually');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`product_registration` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`product_registration` SET TAGS ('dbx_subdomain' = 'product_authorization');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`product_registration` ALTER COLUMN `product_registration_id` SET TAGS ('dbx_business_glossary_term' = 'Product Registration ID');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`product_registration` ALTER COLUMN `allergen_declaration` SET TAGS ('dbx_business_glossary_term' = 'Allergen Declaration');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`product_registration` ALTER COLUMN `allergen_declaration` SET TAGS ('dbx_value_regex' = 'none|contains|may_contain');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`product_registration` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`product_registration` ALTER COLUMN `batch_number_format` SET TAGS ('dbx_business_glossary_term' = 'Batch Number Format');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`product_registration` ALTER COLUMN `compliance_document_url` SET TAGS ('dbx_business_glossary_term' = 'Compliance Document URL');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`product_registration` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`product_registration` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`product_registration` ALTER COLUMN `dossier_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Dossier Reference');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`product_registration` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`product_registration` ALTER COLUMN `is_compliant` SET TAGS ('dbx_business_glossary_term' = 'Is Compliant');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`product_registration` ALTER COLUMN `is_export_allowed` SET TAGS ('dbx_business_glossary_term' = 'Export Allowed Flag');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`product_registration` ALTER COLUMN `is_renewal_required` SET TAGS ('dbx_business_glossary_term' = 'Renewal Required Flag');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`product_registration` ALTER COLUMN `issuing_authority` SET TAGS ('dbx_business_glossary_term' = 'Issuing Authority');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`product_registration` ALTER COLUMN `issuing_authority` SET TAGS ('dbx_value_regex' = 'FDA|EFSA|Health Canada|ANVISA|Other');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`product_registration` ALTER COLUMN `market_name` SET TAGS ('dbx_business_glossary_term' = 'Market Name');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`product_registration` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Registration Notes');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`product_registration` ALTER COLUMN `nutrition_facts_available` SET TAGS ('dbx_business_glossary_term' = 'Nutrition Facts Available');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`product_registration` ALTER COLUMN `packaging_material` SET TAGS ('dbx_business_glossary_term' = 'Packaging Material');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`product_registration` ALTER COLUMN `packaging_material` SET TAGS ('dbx_value_regex' = 'glass|plastic|metal|paper|composite');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`product_registration` ALTER COLUMN `product_category` SET TAGS ('dbx_business_glossary_term' = 'Product Category');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`product_registration` ALTER COLUMN `product_category` SET TAGS ('dbx_value_regex' = 'beverage|snack|dairy|prepared_food|other');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`product_registration` ALTER COLUMN `product_name` SET TAGS ('dbx_business_glossary_term' = 'Product Name');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`product_registration` ALTER COLUMN `product_sku` SET TAGS ('dbx_business_glossary_term' = 'Product SKU');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`product_registration` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`product_registration` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`product_registration` ALTER COLUMN `registration_number` SET TAGS ('dbx_business_glossary_term' = 'Registration Number');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`product_registration` ALTER COLUMN `registration_status` SET TAGS ('dbx_business_glossary_term' = 'Registration Status');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`product_registration` ALTER COLUMN `registration_status` SET TAGS ('dbx_value_regex' = 'active|pending|withdrawn|expired|suspended');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`product_registration` ALTER COLUMN `registration_status_date` SET TAGS ('dbx_business_glossary_term' = 'Registration Status Date');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`product_registration` ALTER COLUMN `registration_type` SET TAGS ('dbx_business_glossary_term' = 'Registration Type');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`product_registration` ALTER COLUMN `registration_type` SET TAGS ('dbx_value_regex' = 'initial|renewal|amendment');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`product_registration` ALTER COLUMN `regulatory_change_indicator` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Change Indicator');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`product_registration` ALTER COLUMN `regulatory_section` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Section');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`product_registration` ALTER COLUMN `shelf_life_days` SET TAGS ('dbx_business_glossary_term' = 'Shelf Life (Days)');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`product_registration` ALTER COLUMN `storage_condition` SET TAGS ('dbx_business_glossary_term' = 'Storage Condition');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`product_registration` ALTER COLUMN `storage_condition` SET TAGS ('dbx_value_regex' = 'ambient|refrigerated|frozen');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`product_registration` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`label_approval` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`label_approval` SET TAGS ('dbx_subdomain' = 'product_authorization');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`label_approval` ALTER COLUMN `label_approval_id` SET TAGS ('dbx_business_glossary_term' = 'Label Approval Identifier (LBL_APP_ID)');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`label_approval` ALTER COLUMN `nutrition_label_id` SET TAGS ('dbx_business_glossary_term' = 'Nutrition Label Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`label_approval` ALTER COLUMN `product_registration_id` SET TAGS ('dbx_business_glossary_term' = 'Product Registration Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`label_approval` ALTER COLUMN `allergen_declaration_verified` SET TAGS ('dbx_business_glossary_term' = 'Allergen Declaration Verification Flag (ALLER_DECL_VERIFIED)');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`label_approval` ALTER COLUMN `approval_status_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Status Timestamp (APP_STATUS_TS)');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`label_approval` ALTER COLUMN `approval_type` SET TAGS ('dbx_business_glossary_term' = 'Approval Type (APP_TYPE)');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`label_approval` ALTER COLUMN `approval_type` SET TAGS ('dbx_value_regex' = 'new|revision|reprint|update|withdrawal');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`label_approval` ALTER COLUMN `certification_status` SET TAGS ('dbx_business_glossary_term' = 'Certification Status (CERT_STATUS)');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`label_approval` ALTER COLUMN `certification_status` SET TAGS ('dbx_value_regex' = 'certified|pending|failed');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`label_approval` ALTER COLUMN `change_requested` SET TAGS ('dbx_business_glossary_term' = 'Change Requested Flag (CHANGE_REQ)');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`label_approval` ALTER COLUMN `claim_basis` SET TAGS ('dbx_business_glossary_term' = 'Claim Basis (CLAIM_BASIS)');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`label_approval` ALTER COLUMN `claim_substantiation` SET TAGS ('dbx_business_glossary_term' = 'Claim Substantiation Details (CLAIM_SUBST)');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`label_approval` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code (ISO3)');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`label_approval` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`label_approval` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (CREATED_TS)');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`label_approval` ALTER COLUMN `document_url` SET TAGS ('dbx_business_glossary_term' = 'Document URL (DOC_URL)');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`label_approval` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date (EFF_DATE)');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`label_approval` ALTER COLUMN `epr_registration_number` SET TAGS ('dbx_business_glossary_term' = 'Extended Producer Responsibility Registration Number (EPR_REG_NO)');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`label_approval` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date (EXP_DATE)');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`label_approval` ALTER COLUMN `final_approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Final Approval Timestamp (FINAL_APP_TS)');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`label_approval` ALTER COLUMN `label_approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status (APP_STATUS)');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`label_approval` ALTER COLUMN `label_approval_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|under_review|approved|rejected|withdrawn');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`label_approval` ALTER COLUMN `label_code` SET TAGS ('dbx_business_glossary_term' = 'Label Code (LBL_CD)');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`label_approval` ALTER COLUMN `label_name` SET TAGS ('dbx_business_glossary_term' = 'Label Name (LBL)');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`label_approval` ALTER COLUMN `market` SET TAGS ('dbx_business_glossary_term' = 'Target Market (MARKET)');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`label_approval` ALTER COLUMN `marketing_claim_verified` SET TAGS ('dbx_business_glossary_term' = 'Marketing Claim Verification Flag (MKT_CLAIM_VERIFIED)');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`label_approval` ALTER COLUMN `nutrition_facts_verified` SET TAGS ('dbx_business_glossary_term' = 'Nutrition Facts Verification Flag (NUTR_FACT_VERIFIED)');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`label_approval` ALTER COLUMN `packaging_material` SET TAGS ('dbx_business_glossary_term' = 'Packaging Material (PKG_MAT)');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`label_approval` ALTER COLUMN `packaging_test_result` SET TAGS ('dbx_business_glossary_term' = 'Packaging Test Result (PKG_TEST_RES)');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`label_approval` ALTER COLUMN `recycled_content_pct` SET TAGS ('dbx_business_glossary_term' = 'Recycled Content Percentage (REC_CONTENT_PCT)');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`label_approval` ALTER COLUMN `regulatory_body` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Body (REG_BODY)');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`label_approval` ALTER COLUMN `regulatory_body` SET TAGS ('dbx_value_regex' = 'FDA|USDA|EFSA|EU|Other');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`label_approval` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason (REJ_REASON)');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`label_approval` ALTER COLUMN `required_changes` SET TAGS ('dbx_business_glossary_term' = 'Required Changes Description (REQ_CHANGES)');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`label_approval` ALTER COLUMN `reviewer_name` SET TAGS ('dbx_business_glossary_term' = 'Reviewer Full Name (REV_NAME)');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`label_approval` ALTER COLUMN `submission_source` SET TAGS ('dbx_business_glossary_term' = 'Submission Source (SUBMIT_SRC)');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`label_approval` ALTER COLUMN `submission_source` SET TAGS ('dbx_value_regex' = 'internal|external');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`label_approval` ALTER COLUMN `submission_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Label Submission Timestamp (SUBMIT_TS)');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`label_approval` ALTER COLUMN `sustainability_claim` SET TAGS ('dbx_business_glossary_term' = 'Sustainability Claim (SUST_CLAIM)');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`label_approval` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (UPDATED_TS)');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`label_approval` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Label Version Number (VER_NUM)');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`import_export_permit` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`import_export_permit` SET TAGS ('dbx_subdomain' = 'facility_compliance');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`import_export_permit` ALTER COLUMN `import_export_permit_id` SET TAGS ('dbx_business_glossary_term' = 'Import/Export Permit ID');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`import_export_permit` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`import_export_permit` ALTER COLUMN `establishment_registration_id` SET TAGS ('dbx_business_glossary_term' = 'Establishment Registration Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`import_export_permit` ALTER COLUMN `product_registration_id` SET TAGS ('dbx_business_glossary_term' = 'Product Registration Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`import_export_permit` ALTER COLUMN `audit_trail_created` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`import_export_permit` ALTER COLUMN `audit_trail_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`import_export_permit` ALTER COLUMN `cbp_entry_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'CBP Entry Compliance Flag');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`import_export_permit` ALTER COLUMN `commodity_description` SET TAGS ('dbx_business_glossary_term' = 'Commodity Description');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`import_export_permit` ALTER COLUMN `compliance_checklist_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Checklist Status');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`import_export_permit` ALTER COLUMN `compliance_checklist_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|completed|failed');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`import_export_permit` ALTER COLUMN `customs_document_number` SET TAGS ('dbx_business_glossary_term' = 'Customs Document Number');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`import_export_permit` ALTER COLUMN `destination_country` SET TAGS ('dbx_business_glossary_term' = 'Destination Country Code');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`import_export_permit` ALTER COLUMN `duty_rate` SET TAGS ('dbx_business_glossary_term' = 'Duty Rate (PERCENT)');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`import_export_permit` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`import_export_permit` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`import_export_permit` ALTER COLUMN `eligibility_criteria` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Criteria');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`import_export_permit` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`import_export_permit` ALTER COLUMN `fda_prior_notice_flag` SET TAGS ('dbx_business_glossary_term' = 'FDA Prior Notice Flag');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`import_export_permit` ALTER COLUMN `hs_code` SET TAGS ('dbx_business_glossary_term' = 'Harmonized System (HS) Code');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`import_export_permit` ALTER COLUMN `hs_code` SET TAGS ('dbx_value_regex' = '^d{6,10}$');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`import_export_permit` ALTER COLUMN `import_export_permit_status` SET TAGS ('dbx_business_glossary_term' = 'Permit Status');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`import_export_permit` ALTER COLUMN `import_export_permit_status` SET TAGS ('dbx_value_regex' = 'draft|pending|active|suspended|revoked|expired');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`import_export_permit` ALTER COLUMN `issuance_date` SET TAGS ('dbx_business_glossary_term' = 'Issuance Date');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`import_export_permit` ALTER COLUMN `issuing_authority` SET TAGS ('dbx_business_glossary_term' = 'Issuing Authority');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`import_export_permit` ALTER COLUMN `issuing_authority` SET TAGS ('dbx_value_regex' = 'FDA|USCBP|USDA|EPA|Customs|Other');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`import_export_permit` ALTER COLUMN `issuing_office` SET TAGS ('dbx_business_glossary_term' = 'Issuing Office');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`import_export_permit` ALTER COLUMN `last_amended_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Amended Timestamp');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`import_export_permit` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`import_export_permit` ALTER COLUMN `origin_country` SET TAGS ('dbx_business_glossary_term' = 'Origin Country Code');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`import_export_permit` ALTER COLUMN `origin_determination_method` SET TAGS ('dbx_business_glossary_term' = 'Origin Determination Method');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`import_export_permit` ALTER COLUMN `origin_determination_method` SET TAGS ('dbx_value_regex' = 'substantial_transformation|cool|manufacturer|supplier');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`import_export_permit` ALTER COLUMN `permit_category` SET TAGS ('dbx_business_glossary_term' = 'Permit Category');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`import_export_permit` ALTER COLUMN `permit_category` SET TAGS ('dbx_value_regex' = 'regulatory|customs|trade|safety');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`import_export_permit` ALTER COLUMN `permit_issue_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Permit Issue Timestamp');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`import_export_permit` ALTER COLUMN `permit_number` SET TAGS ('dbx_business_glossary_term' = 'Permit Number (PERMIT_NO)');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`import_export_permit` ALTER COLUMN `permit_type` SET TAGS ('dbx_business_glossary_term' = 'Permit Type');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`import_export_permit` ALTER COLUMN `permit_type` SET TAGS ('dbx_value_regex' = 'import|export|re-export|transit|temporary');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`import_export_permit` ALTER COLUMN `preferential_agreement` SET TAGS ('dbx_business_glossary_term' = 'Preferential Trade Agreement');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`import_export_permit` ALTER COLUMN `preferential_agreement` SET TAGS ('dbx_value_regex' = 'NAFTA|USMCA|CAFTA|None');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`import_export_permit` ALTER COLUMN `tariff_classification` SET TAGS ('dbx_business_glossary_term' = 'Tariff Classification Ruling');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`import_export_permit` ALTER COLUMN `transformation_details` SET TAGS ('dbx_business_glossary_term' = 'Transformation Details');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`packaging_compliance` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`packaging_compliance` SET TAGS ('dbx_subdomain' = 'product_authorization');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`packaging_compliance` ALTER COLUMN `packaging_compliance_id` SET TAGS ('dbx_business_glossary_term' = 'Packaging Compliance ID');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`packaging_compliance` ALTER COLUMN `product_registration_id` SET TAGS ('dbx_business_glossary_term' = 'Product Registration Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`packaging_compliance` ALTER COLUMN `claim_substantiation` SET TAGS ('dbx_business_glossary_term' = 'Claim Substantiation');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`packaging_compliance` ALTER COLUMN `compliance_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Compliance Audit Date');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`packaging_compliance` ALTER COLUMN `compliance_audit_result` SET TAGS ('dbx_business_glossary_term' = 'Compliance Audit Result');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`packaging_compliance` ALTER COLUMN `compliance_audit_result` SET TAGS ('dbx_value_regex' = 'pass|fail|conditional');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`packaging_compliance` ALTER COLUMN `compliance_document_url` SET TAGS ('dbx_business_glossary_term' = 'Compliance Document URL');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`packaging_compliance` ALTER COLUMN `compliance_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Compliance Effective Date');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`packaging_compliance` ALTER COLUMN `compliance_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Compliance Expiration Date');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`packaging_compliance` ALTER COLUMN `compliance_record_number` SET TAGS ('dbx_business_glossary_term' = 'Compliance Record Number');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`packaging_compliance` ALTER COLUMN `dimensions_cm` SET TAGS ('dbx_business_glossary_term' = 'Packaging Dimensions (cm)');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`packaging_compliance` ALTER COLUMN `epa_compliance_status` SET TAGS ('dbx_business_glossary_term' = 'EPA Compliance Status');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`packaging_compliance` ALTER COLUMN `epa_compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non-compliant|pending');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`packaging_compliance` ALTER COLUMN `epr_registration_number` SET TAGS ('dbx_business_glossary_term' = 'EPR Registration Number');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`packaging_compliance` ALTER COLUMN `eu_directive_94_62_ec_compliant` SET TAGS ('dbx_business_glossary_term' = 'EU Directive 94/62/EC Compliance');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`packaging_compliance` ALTER COLUMN `ftc_green_guides_claim` SET TAGS ('dbx_business_glossary_term' = 'FTC Green Guides Claim');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`packaging_compliance` ALTER COLUMN `gtin_code` SET TAGS ('dbx_business_glossary_term' = 'GTIN Code');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`packaging_compliance` ALTER COLUMN `gtin_code` SET TAGS ('dbx_value_regex' = '^d{14}$');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`packaging_compliance` ALTER COLUMN `hazardous_substance_present` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Substance Present');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`packaging_compliance` ALTER COLUMN `heavy_metal_compliance` SET TAGS ('dbx_business_glossary_term' = 'Heavy Metal Compliance');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`packaging_compliance` ALTER COLUMN `heavy_metal_ppm` SET TAGS ('dbx_business_glossary_term' = 'Heavy Metal Concentration (ppm)');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`packaging_compliance` ALTER COLUMN `material_certification` SET TAGS ('dbx_business_glossary_term' = 'Material Certification');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`packaging_compliance` ALTER COLUMN `material_certification` SET TAGS ('dbx_value_regex' = 'FSC|PEFC|recycled|none');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`packaging_compliance` ALTER COLUMN `material_certification_number` SET TAGS ('dbx_business_glossary_term' = 'Material Certification Number');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`packaging_compliance` ALTER COLUMN `material_supplier` SET TAGS ('dbx_business_glossary_term' = 'Material Supplier');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`packaging_compliance` ALTER COLUMN `material_supplier_certified` SET TAGS ('dbx_business_glossary_term' = 'Material Supplier Certified');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`packaging_compliance` ALTER COLUMN `material_type` SET TAGS ('dbx_business_glossary_term' = 'Material Type');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`packaging_compliance` ALTER COLUMN `material_type` SET TAGS ('dbx_value_regex' = 'plastic|glass|metal|paper|composite|bioplastic');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`packaging_compliance` ALTER COLUMN `packaging_audit_trail` SET TAGS ('dbx_business_glossary_term' = 'Packaging Audit Trail');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`packaging_compliance` ALTER COLUMN `packaging_barcode` SET TAGS ('dbx_business_glossary_term' = 'Packaging Barcode');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`packaging_compliance` ALTER COLUMN `packaging_color` SET TAGS ('dbx_business_glossary_term' = 'Packaging Color');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`packaging_compliance` ALTER COLUMN `packaging_compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Packaging Compliance Status');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`packaging_compliance` ALTER COLUMN `packaging_compliance_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|retired');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`packaging_compliance` ALTER COLUMN `packaging_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Packaging Record Created Timestamp');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`packaging_compliance` ALTER COLUMN `packaging_disposal_method` SET TAGS ('dbx_business_glossary_term' = 'Packaging Disposal Method');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`packaging_compliance` ALTER COLUMN `packaging_disposal_method` SET TAGS ('dbx_value_regex' = 'recycle|landfill|incinerate|compost');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`packaging_compliance` ALTER COLUMN `packaging_end_of_life_instructions` SET TAGS ('dbx_business_glossary_term' = 'End‑of‑Life Instructions');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`packaging_compliance` ALTER COLUMN `packaging_environmental_impact_score` SET TAGS ('dbx_business_glossary_term' = 'Environmental Impact Score');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`packaging_compliance` ALTER COLUMN `packaging_last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Packaging Record Last Updated Timestamp');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`packaging_compliance` ALTER COLUMN `packaging_name` SET TAGS ('dbx_business_glossary_term' = 'Packaging Name');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`packaging_compliance` ALTER COLUMN `packaging_origin_country` SET TAGS ('dbx_business_glossary_term' = 'Packaging Origin Country');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`packaging_compliance` ALTER COLUMN `packaging_origin_country` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`packaging_compliance` ALTER COLUMN `packaging_reuse_cycles` SET TAGS ('dbx_business_glossary_term' = 'Packaging Reuse Cycles');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`packaging_compliance` ALTER COLUMN `packaging_type` SET TAGS ('dbx_business_glossary_term' = 'Packaging Type');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`packaging_compliance` ALTER COLUMN `packaging_type` SET TAGS ('dbx_value_regex' = 'bottle|can|pouch|box|tray');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`packaging_compliance` ALTER COLUMN `packaging_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Packaging Weight (kg)');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`packaging_compliance` ALTER COLUMN `recyclability_classification` SET TAGS ('dbx_business_glossary_term' = 'Recyclability Classification');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`packaging_compliance` ALTER COLUMN `recyclability_classification` SET TAGS ('dbx_value_regex' = 'recyclable|non-recyclable|compostable|reusable');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`packaging_compliance` ALTER COLUMN `recycled_content_percent` SET TAGS ('dbx_business_glossary_term' = 'Recycled Content Percentage');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`packaging_compliance` ALTER COLUMN `state_compliance_status` SET TAGS ('dbx_business_glossary_term' = 'State Compliance Status');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`packaging_compliance` ALTER COLUMN `state_compliance_status` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`packaging_compliance` ALTER COLUMN `sustainability_claim` SET TAGS ('dbx_business_glossary_term' = 'Sustainability Claim');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`packaging_compliance` ALTER COLUMN `upc_code` SET TAGS ('dbx_business_glossary_term' = 'UPC Code');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`packaging_compliance` ALTER COLUMN `upc_code` SET TAGS ('dbx_value_regex' = '^d{12}$');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`recall_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`recall_event` SET TAGS ('dbx_subdomain' = 'safety_monitoring');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`recall_event` ALTER COLUMN `recall_event_id` SET TAGS ('dbx_business_glossary_term' = 'Recall Event Identifier');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`recall_event` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`recall_event` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`recall_event` ALTER COLUMN `establishment_registration_id` SET TAGS ('dbx_business_glossary_term' = 'Establishment Registration Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`recall_event` ALTER COLUMN `product_registration_id` SET TAGS ('dbx_business_glossary_term' = 'Product Registration Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`recall_event` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`recall_event` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`recall_event` ALTER COLUMN `affected_lot_number` SET TAGS ('dbx_business_glossary_term' = 'Affected Lot Number');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`recall_event` ALTER COLUMN `agency_notification_date` SET TAGS ('dbx_business_glossary_term' = 'Agency Notification Date');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`recall_event` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`recall_event` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|under_review');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`recall_event` ALTER COLUMN `consumer_notification_date` SET TAGS ('dbx_business_glossary_term' = 'Consumer Notification Date');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`recall_event` ALTER COLUMN `consumer_notification_method` SET TAGS ('dbx_business_glossary_term' = 'Consumer Notification Method');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`recall_event` ALTER COLUMN `consumer_notification_method` SET TAGS ('dbx_value_regex' = 'email|phone|mail|website|media');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`recall_event` ALTER COLUMN `corrective_action_plan` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Plan');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`recall_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Created Timestamp');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`recall_event` ALTER COLUMN `distribution_scope` SET TAGS ('dbx_business_glossary_term' = 'Distribution Scope');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`recall_event` ALTER COLUMN `distribution_scope` SET TAGS ('dbx_value_regex' = 'national|regional|global|state|local');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`recall_event` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Recall Notes');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`recall_event` ALTER COLUMN `press_release_url` SET TAGS ('dbx_business_glossary_term' = 'Press Release URL');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`recall_event` ALTER COLUMN `product_category` SET TAGS ('dbx_business_glossary_term' = 'Product Category');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`recall_event` ALTER COLUMN `product_name` SET TAGS ('dbx_business_glossary_term' = 'Product Name');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`recall_event` ALTER COLUMN `product_upc` SET TAGS ('dbx_business_glossary_term' = 'Product UPC');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`recall_event` ALTER COLUMN `recall_class` SET TAGS ('dbx_business_glossary_term' = 'Recall Classification');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`recall_event` ALTER COLUMN `recall_class` SET TAGS ('dbx_value_regex' = 'Class I|Class II|Class III');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`recall_event` ALTER COLUMN `recall_date` SET TAGS ('dbx_business_glossary_term' = 'Recall Event Timestamp');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`recall_event` ALTER COLUMN `recall_effectiveness_status` SET TAGS ('dbx_business_glossary_term' = 'Recall Effectiveness Status');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`recall_event` ALTER COLUMN `recall_effectiveness_status` SET TAGS ('dbx_value_regex' = 'pending|completed|failed');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`recall_event` ALTER COLUMN `recall_event_status` SET TAGS ('dbx_business_glossary_term' = 'Recall Status');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`recall_event` ALTER COLUMN `recall_event_status` SET TAGS ('dbx_value_regex' = 'open|closed|in_progress|cancelled');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`recall_event` ALTER COLUMN `recall_initiated_by` SET TAGS ('dbx_business_glossary_term' = 'Recall Initiation Type');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`recall_event` ALTER COLUMN `recall_initiated_by` SET TAGS ('dbx_value_regex' = 'voluntary|mandated');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`recall_event` ALTER COLUMN `recall_number` SET TAGS ('dbx_business_glossary_term' = 'Recall Number');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`recall_event` ALTER COLUMN `recall_priority` SET TAGS ('dbx_business_glossary_term' = 'Recall Priority');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`recall_event` ALTER COLUMN `recall_priority` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`recall_event` ALTER COLUMN `recall_reason` SET TAGS ('dbx_business_glossary_term' = 'Recall Reason');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`recall_event` ALTER COLUMN `recall_type` SET TAGS ('dbx_business_glossary_term' = 'Recall Type');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`recall_event` ALTER COLUMN `recall_type` SET TAGS ('dbx_value_regex' = 'full|partial');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`recall_event` ALTER COLUMN `regulatory_agency` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Agency');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`recall_event` ALTER COLUMN `regulatory_agency` SET TAGS ('dbx_value_regex' = 'FDA|USDA|EFSA|GFSI');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`recall_event` ALTER COLUMN `root_cause_analysis` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Analysis');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`recall_event` ALTER COLUMN `total_units_affected` SET TAGS ('dbx_business_glossary_term' = 'Total Units Affected');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`recall_event` ALTER COLUMN `total_units_disposed` SET TAGS ('dbx_business_glossary_term' = 'Total Units Disposed');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`recall_event` ALTER COLUMN `total_units_recovered` SET TAGS ('dbx_business_glossary_term' = 'Total Units Recovered');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`recall_event` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Updated Timestamp');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`gfsi_certification` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`gfsi_certification` SET TAGS ('dbx_subdomain' = 'facility_compliance');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`gfsi_certification` ALTER COLUMN `gfsi_certification_id` SET TAGS ('dbx_business_glossary_term' = 'GFSI Certification ID');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`gfsi_certification` ALTER COLUMN `establishment_registration_id` SET TAGS ('dbx_business_glossary_term' = 'Establishment Registration Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`gfsi_certification` ALTER COLUMN `food_safety_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Food Safety Plan Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`gfsi_certification` ALTER COLUMN `supplier_site_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`gfsi_certification` ALTER COLUMN `audit_findings_summary` SET TAGS ('dbx_business_glossary_term' = 'Audit Findings Summary');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`gfsi_certification` ALTER COLUMN `audit_methodology` SET TAGS ('dbx_business_glossary_term' = 'Audit Methodology');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`gfsi_certification` ALTER COLUMN `audit_report_reference` SET TAGS ('dbx_business_glossary_term' = 'Audit Report Reference');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`gfsi_certification` ALTER COLUMN `auditor_name` SET TAGS ('dbx_business_glossary_term' = 'Auditor Name');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`gfsi_certification` ALTER COLUMN `certificate_document_url` SET TAGS ('dbx_business_glossary_term' = 'Certificate Document URL');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`gfsi_certification` ALTER COLUMN `certification_body` SET TAGS ('dbx_business_glossary_term' = 'Certification Body');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`gfsi_certification` ALTER COLUMN `certification_cost` SET TAGS ('dbx_business_glossary_term' = 'Certification Cost');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`gfsi_certification` ALTER COLUMN `certification_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`gfsi_certification` ALTER COLUMN `certification_cost` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`gfsi_certification` ALTER COLUMN `certification_number` SET TAGS ('dbx_business_glossary_term' = 'Certification Number');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`gfsi_certification` ALTER COLUMN `certification_scope_code` SET TAGS ('dbx_business_glossary_term' = 'Certification Scope Code');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`gfsi_certification` ALTER COLUMN `certification_status` SET TAGS ('dbx_business_glossary_term' = 'Certification Status');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`gfsi_certification` ALTER COLUMN `certification_status` SET TAGS ('dbx_value_regex' = 'active|suspended|revoked|expired|pending');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`gfsi_certification` ALTER COLUMN `certification_type` SET TAGS ('dbx_business_glossary_term' = 'Certification Type');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`gfsi_certification` ALTER COLUMN `certification_type` SET TAGS ('dbx_value_regex' = 'initial|renewal|extension|reassessment');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`gfsi_certification` ALTER COLUMN `compliance_notes` SET TAGS ('dbx_business_glossary_term' = 'Compliance Notes');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`gfsi_certification` ALTER COLUMN `corrective_action_due_date` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Due Date');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`gfsi_certification` ALTER COLUMN `corrective_action_required` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Required Flag');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`gfsi_certification` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`gfsi_certification` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`gfsi_certification` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`gfsi_certification` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`gfsi_certification` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`gfsi_certification` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`gfsi_certification` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`gfsi_certification` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Certification Expiry Date');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`gfsi_certification` ALTER COLUMN `external_audit_provider` SET TAGS ('dbx_business_glossary_term' = 'External Audit Provider');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`gfsi_certification` ALTER COLUMN `grade_level` SET TAGS ('dbx_business_glossary_term' = 'Certification Grade Level');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`gfsi_certification` ALTER COLUMN `grade_level` SET TAGS ('dbx_value_regex' = 'A|B|C|D|E|F');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`gfsi_certification` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Active Flag');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`gfsi_certification` ALTER COLUMN `is_multi_site` SET TAGS ('dbx_business_glossary_term' = 'Multi-Site Certification Flag');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`gfsi_certification` ALTER COLUMN `issue_date` SET TAGS ('dbx_business_glossary_term' = 'Certification Issue Date');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`gfsi_certification` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`gfsi_certification` ALTER COLUMN `next_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Next Audit Date');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`gfsi_certification` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'General Notes');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`gfsi_certification` ALTER COLUMN `number_of_sites` SET TAGS ('dbx_business_glossary_term' = 'Number of Certified Sites');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`gfsi_certification` ALTER COLUMN `regulatory_body` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Body');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`gfsi_certification` ALTER COLUMN `renewal_notice_date` SET TAGS ('dbx_business_glossary_term' = 'Renewal Notice Date');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`gfsi_certification` ALTER COLUMN `renewal_required` SET TAGS ('dbx_business_glossary_term' = 'Renewal Required Flag');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`gfsi_certification` ALTER COLUMN `scheme_name` SET TAGS ('dbx_business_glossary_term' = 'Certification Scheme Name');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`gfsi_certification` ALTER COLUMN `scheme_version` SET TAGS ('dbx_business_glossary_term' = 'Certification Scheme Version');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`gfsi_certification` ALTER COLUMN `scope_description` SET TAGS ('dbx_business_glossary_term' = 'Certification Scope Description');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`gfsi_certification` ALTER COLUMN `site_name` SET TAGS ('dbx_business_glossary_term' = 'Facility Name');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`gfsi_certification` ALTER COLUMN `surveillance_audit_frequency` SET TAGS ('dbx_business_glossary_term' = 'Surveillance Audit Frequency');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`gfsi_certification` ALTER COLUMN `surveillance_audit_frequency` SET TAGS ('dbx_value_regex' = 'annual|biennial|triennial');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`gfsi_certification` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`food_safety_plan` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`food_safety_plan` SET TAGS ('dbx_subdomain' = 'facility_compliance');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`food_safety_plan` ALTER COLUMN `food_safety_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Food Safety Plan Identifier');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`food_safety_plan` ALTER COLUMN `establishment_registration_id` SET TAGS ('dbx_business_glossary_term' = 'Establishment Registration Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`food_safety_plan` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Identifier');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`food_safety_plan` ALTER COLUMN `supplier_site_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Site Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`food_safety_plan` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Plan Approval Date');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`food_safety_plan` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Plan Approval Status');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`food_safety_plan` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'approved|rejected|pending');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`food_safety_plan` ALTER COLUMN `approved_by_name` SET TAGS ('dbx_business_glossary_term' = 'Approved By Name');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`food_safety_plan` ALTER COLUMN `approved_by_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`food_safety_plan` ALTER COLUMN `approved_by_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`food_safety_plan` ALTER COLUMN `approved_by_title` SET TAGS ('dbx_business_glossary_term' = 'Approved By Title');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`food_safety_plan` ALTER COLUMN `ccp_count` SET TAGS ('dbx_business_glossary_term' = 'Critical Control Point Count');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`food_safety_plan` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`food_safety_plan` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non-compliant|under review');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`food_safety_plan` ALTER COLUMN `corrective_action_procedure_description` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Procedure Description');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`food_safety_plan` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`food_safety_plan` ALTER COLUMN `critical_limits_description` SET TAGS ('dbx_business_glossary_term' = 'Critical Limits Description');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`food_safety_plan` ALTER COLUMN `document_storage_path` SET TAGS ('dbx_business_glossary_term' = 'Document Storage Path');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`food_safety_plan` ALTER COLUMN `document_version` SET TAGS ('dbx_business_glossary_term' = 'Document Version');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`food_safety_plan` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Plan Effective End Date');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`food_safety_plan` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Plan Effective Start Date');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`food_safety_plan` ALTER COLUMN `food_safety_plan_status` SET TAGS ('dbx_business_glossary_term' = 'Plan Status');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`food_safety_plan` ALTER COLUMN `food_safety_plan_status` SET TAGS ('dbx_value_regex' = 'draft|active|inactive|revoked|pending|archived');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`food_safety_plan` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`food_safety_plan` ALTER COLUMN `monitoring_procedure_description` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Procedure Description');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`food_safety_plan` ALTER COLUMN `next_reanalysis_date` SET TAGS ('dbx_business_glossary_term' = 'Next Reanalysis Date');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`food_safety_plan` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Plan Notes');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`food_safety_plan` ALTER COLUMN `plan_name` SET TAGS ('dbx_business_glossary_term' = 'Food Safety Plan Name');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`food_safety_plan` ALTER COLUMN `plan_type` SET TAGS ('dbx_business_glossary_term' = 'Food Safety Plan Type');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`food_safety_plan` ALTER COLUMN `plan_type` SET TAGS ('dbx_value_regex' = 'HACCP|Preventive Controls|Combined');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`food_safety_plan` ALTER COLUMN `product_category_code` SET TAGS ('dbx_business_glossary_term' = 'Product Category Code');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`food_safety_plan` ALTER COLUMN `regulatory_body` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Body');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`food_safety_plan` ALTER COLUMN `regulatory_body` SET TAGS ('dbx_value_regex' = 'FDA|USDA|EFSA|GFSI');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`food_safety_plan` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Level');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`food_safety_plan` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`food_safety_plan` ALTER COLUMN `training_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Training Completion Date');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`food_safety_plan` ALTER COLUMN `training_required` SET TAGS ('dbx_business_glossary_term' = 'Training Required');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`food_safety_plan` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`food_safety_plan` ALTER COLUMN `verification_activity_description` SET TAGS ('dbx_business_glossary_term' = 'Verification Activity Description');
ALTER TABLE `food_beverage_ecm`.`regulatory`.`food_safety_plan` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Plan Version Number');
