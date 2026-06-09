-- Schema for Domain: procurement | Business: Food Beverage | Version: v1_mvm
-- Generated on: 2026-05-05 23:22:31

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `food_beverage_ecm`.`procurement` COMMENT 'Sourcing and procurement of raw materials, ingredients, packaging, indirect materials, and services. Includes supplier master data, purchase orders, MOQs, contracts, supplier performance scorecards, supplier audits, TraceGains compliance documents, approved vendor lists, raw material pricing contracts, and spend analytics.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `food_beverage_ecm`.`procurement`.`supplier` (
    `supplier_id` BIGINT COMMENT 'Unique system-generated identifier for the supplier record. Primary key for the supplier master data product in the procurement domain. Sourced from SAP S/4HANA MM vendor master (LFA1-LIFNR mapped to BIGINT).',
    `establishment_registration_id` BIGINT COMMENT 'Foreign key linking to regulatory.establishment_registration. Business justification: Compliance team needs to link each supplier to its FDA/USDA establishment registration for audit reporting and traceability.',
    `account_group_code` STRING COMMENT 'SAP S/4HANA vendor account group code (LFA1-KTOKK) that controls the field selection, number range, and partner functions applicable to this supplier. Distinguishes between one-time vendors, regular vendors, and intercompany suppliers.',
    `allergen_control_program_flag` BOOLEAN COMMENT 'Indicates whether the supplier has a documented and audited allergen control program in place at their manufacturing facility. Critical for managing allergen cross-contact risk in the Food Beverage supply chain per FSMA Preventive Controls requirements.',
    `approved_vendor_list_flag` BOOLEAN COMMENT 'Indicates whether the supplier is currently on the Approved Vendor List (AVL), meaning they have passed all required quality, food safety, and compliance assessments and are authorized to supply materials or services to Food Beverage.',
    `audit_result` STRING COMMENT 'Categorical outcome of the most recent supplier audit. A conditional_pass requires corrective action within a defined timeframe. A fail triggers supplier suspension pending remediation.. Valid values are `pass|conditional_pass|fail|pending`',
    `audit_score` DECIMAL(18,2) COMMENT 'Numeric score (0–100) from the most recent supplier quality or food safety audit. Drives supplier risk tier assignment and determines re-audit frequency. Sourced from TraceGains or Veeva Vault quality management records.',
    `city` STRING COMMENT 'City of the suppliers primary registered business address. Used for logistics routing, lead time estimation, and geographic risk analysis.',
    `country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code of the suppliers primary registered business address. Used for regulatory compliance, import/export controls, country-of-origin labeling, and trade compliance screening.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the supplier record was first created in the system of record (SAP S/4HANA MM vendor master). Supports data lineage, audit trail, and FSMA traceability requirements.',
    `deactivation_date` DATE COMMENT 'Date on which the supplier was deactivated or blocked in the vendor master, preventing new purchase orders from being issued. Null for currently active suppliers.',
    `diversity_classification` STRING COMMENT 'Supplier diversity category indicating ownership classification for ESG reporting and supplier diversity program tracking. Used to measure spend with diverse suppliers as required by corporate sustainability commitments and certain customer contracts.. Valid values are `minority_owned|women_owned|veteran_owned|small_business|none|not_disclosed`',
    `duns_number` STRING COMMENT 'Dun & Bradstreet Data Universal Numbering System (DUNS) nine-digit identifier for the supplier legal entity. Used for supplier financial risk screening, credit assessment, and global supplier deduplication.. Valid values are `^[0-9]{9}$`',
    `edi_capable_flag` BOOLEAN COMMENT 'Indicates whether the supplier is capable of exchanging Electronic Data Interchange (EDI) transactions (e.g., EDI 850 Purchase Order, EDI 856 ASN, EDI 810 Invoice) with Food Beverages procurement systems.',
    `food_safety_cert_expiry_date` DATE COMMENT 'Expiration date of the suppliers primary food safety certification. Triggers automated re-certification alerts in TraceGains and may result in supplier suspension if not renewed before expiry.',
    `food_safety_certification` STRING COMMENT 'Primary GFSI-recognized food safety certification held by the supplier (e.g., SQF, BRC, FSSC 22000, IFS, ISO 22000, HACCP). Mandatory for direct material suppliers under Food Beverages supplier qualification program. Sourced from TraceGains document management. [ENUM-REF-CANDIDATE: SQF|BRC|FSSC_22000|IFS|ISO_22000|HACCP|none — 7 candidates stripped; promote to reference product]',
    `gln` STRING COMMENT 'GS1 Global Location Number (GLN) — 13-digit identifier uniquely identifying the suppliers physical or legal location in the global supply chain. Used in EDI transactions (ASN, invoices) and GS1 traceability programs.. Valid values are `^[0-9]{13}$`',
    `incoterms_code` STRING COMMENT 'International Commercial Terms (Incoterms 2020) code defining the transfer of risk, cost, and responsibility between Food Beverage and the supplier for goods in transit. Critical for logistics cost allocation and insurance coverage. [ENUM-REF-CANDIDATE: EXW|FCA|CPT|CIP|DAP|DPU|DDP|FAS|FOB|CFR|CIF — 11 candidates stripped; promote to reference product]',
    `last_audit_date` DATE COMMENT 'Date of the most recent quality or food safety audit conducted at the suppliers facility by Food Beverages quality assurance team or a third-party auditor. Used to track audit frequency compliance and supplier qualification status.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the supplier master record in the source system. Used for incremental data pipeline processing, change detection, and audit trail maintenance.',
    `lead_time_days` STRING COMMENT 'Standard procurement lead time in calendar days from purchase order placement to expected goods receipt at the Food Beverage distribution center or plant. Used in demand planning, safety stock calculations, and SAP IBP replenishment logic.',
    `legal_name` STRING COMMENT 'Full registered legal name of the supplier entity as recorded in official business registration documents. Used for contract execution, regulatory filings, and accounts payable processing.',
    `moq` DECIMAL(18,2) COMMENT 'Minimum Order Quantity (MOQ) — the smallest quantity of a material or service that the supplier will accept per purchase order. Expressed in the suppliers base unit of measure. Enforced during purchase order creation in SAP S/4HANA MM.',
    `moq_unit` STRING COMMENT 'Unit of measure applicable to the MOQ field (e.g., KG, LB, CS, EA, L). Aligns with SAP S/4HANA base unit of measure for the purchasing info record.',
    `onboarding_date` DATE COMMENT 'Date on which the supplier was formally approved and activated in the Food Beverage vendor master, completing the onboarding process including quality qualification, legal review, and financial setup.',
    `onboarding_status` STRING COMMENT 'Current lifecycle state of the supplier in the onboarding and vendor management workflow. Controls whether purchase orders can be issued. Sourced from SAP S/4HANA MM vendor master blocking indicators and TraceGains onboarding workflow status.. Valid values are `pending|under_review|approved|active|suspended|deactivated`',
    `organic_certification_flag` BOOLEAN COMMENT 'Indicates whether the supplier holds a valid USDA National Organic Program (NOP) or equivalent organic certification. Required for sourcing certified organic ingredients for Food Beverages clean label and organic product lines.',
    `payment_currency_code` STRING COMMENT 'ISO 4217 three-letter currency code in which invoices from this supplier are settled. Drives foreign exchange exposure tracking and multi-currency accounts payable processing.. Valid values are `^[A-Z]{3}$`',
    `payment_terms_code` STRING COMMENT 'SAP payment terms key defining the agreed payment schedule with the supplier (e.g., NET30, 2/10NET30). Governs accounts payable processing, cash discount eligibility, and working capital management.',
    `portal_registration_flag` BOOLEAN COMMENT 'Indicates whether the supplier has completed self-registration in Food Beverages supplier portal (SAP Ariba or equivalent), enabling self-service document submission, invoice tracking, and compliance certificate uploads.',
    `postal_code` STRING COMMENT 'Postal or ZIP code of the suppliers primary registered business address. Used for logistics zone mapping and geographic risk segmentation.',
    `primary_contact_email` STRING COMMENT 'Business email address of the primary contact at the supplier. Used for purchase order transmission, compliance document requests, and supplier communication workflows.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `primary_contact_name` STRING COMMENT 'Full name of the primary business contact at the supplier organization responsible for managing the commercial relationship with Food Beverage. Used for purchase order communications and escalations.',
    `primary_contact_phone` STRING COMMENT 'Business phone number of the primary contact at the supplier. Used for urgent procurement communications, quality escalations, and supply disruption notifications.',
    `purchasing_org_code` STRING COMMENT 'SAP S/4HANA purchasing organization code (EKORG) to which this supplier is assigned. Determines which procurement team manages the supplier relationship and which contracts and pricing conditions apply.',
    `region` STRING COMMENT 'Geographic region or state/province of the suppliers primary business location. Used for supply chain risk mapping, logistics planning, and regional compliance reporting.',
    `risk_rating` STRING COMMENT 'Overall supply chain risk rating assigned to the supplier based on food safety audit results, financial stability, geographic risk, single-source dependency, and regulatory compliance history. Used to prioritize supplier monitoring and contingency planning.. Valid values are `critical|high|medium|low`',
    `single_source_flag` BOOLEAN COMMENT 'Indicates whether this supplier is the sole approved source for one or more critical raw materials or ingredients. Single-source suppliers require enhanced risk monitoring, safety stock buffers, and business continuity planning.',
    `strategic_supplier_flag` BOOLEAN COMMENT 'Indicates whether the supplier is classified as a strategic partner under Food Beverages supplier relationship management (SRM) program, warranting executive-level engagement, joint business planning, and preferred sourcing status.',
    `supplier_tier` STRING COMMENT 'Strategic tier classification indicating the suppliers position in the supply chain hierarchy. Tier 1 suppliers have a direct commercial relationship with Food Beverage; Tier 2 and Tier 3 are sub-suppliers providing materials or services to Tier 1 suppliers.. Valid values are `tier_1|tier_2|tier_3`',
    `supplier_type` STRING COMMENT 'Classification of the supplier by the nature of goods or services provided. Direct material suppliers provide ingredients and packaging; co-packers and toll manufacturers produce finished goods; 3PL/logistics providers handle distribution; service providers cover indirect spend. [ENUM-REF-CANDIDATE: direct_material|indirect_material|co_packer|toll_manufacturer|3pl_logistics|service_provider — promote to reference product]. Valid values are `direct_material|indirect_material|co_packer|toll_manufacturer|3pl_logistics|service_provider`',
    `sustainability_score` DECIMAL(18,2) COMMENT 'Numeric sustainability performance score (0–100) based on environmental, social, and governance (ESG) criteria including carbon footprint, water usage, labor practices, and packaging recyclability. Sourced from third-party ESG assessments or TraceGains sustainability questionnaires.',
    `tax_identifier` STRING COMMENT 'Government-issued tax identification number (e.g., EIN, VAT registration number, GST number) for the supplier legal entity. Required for tax compliance, 1099/W-9 reporting, and accounts payable regulatory filings.',
    `tracegains_supplier_code` STRING COMMENT 'Unique supplier identifier assigned within the TraceGains supplier compliance and document management platform. Used to cross-reference food safety certifications, specification documents, and audit records between SAP and TraceGains.',
    `trade_name` STRING COMMENT 'Doing-business-as (DBA) or commercial trade name of the supplier, which may differ from the legal entity name. Used in commercial communications, purchase orders, and supplier-facing documents.',
    `vendor_code` STRING COMMENT 'Externally-known alphanumeric vendor account number assigned in SAP S/4HANA MM (LFA1-LIFNR). Used as the cross-system business identifier for the supplier across ERP, EDI, and procurement workflows.',
    CONSTRAINT pk_supplier PRIMARY KEY(`supplier_id`)
) COMMENT 'Master record for all suppliers, vendors, co-packers, toll manufacturers, and service providers in the F&B procurement network. SSOT for supplier identity, classification, tier, payment terms, lead times, MOQ thresholds, onboarding status, and key contact information. Sourced from SAP S/4HANA MM vendor master and TraceGains supplier compliance records. Covers direct material suppliers (ingredients, packaging), indirect suppliers, 3PL/logistics service providers, and co-manufacturers.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`procurement`.`supplier_site` (
    `supplier_site_id` BIGINT COMMENT 'Unique system-generated identifier for each supplier site record. Primary key for the supplier_site data product in the procurement domain.',
    `establishment_registration_id` BIGINT COMMENT 'Foreign key linking to regulatory.establishment_registration. Business justification: Site‑level compliance requires associating each supplier site with its official establishment registration record for regulatory inspections.',
    `supplier_id` BIGINT COMMENT 'Reference to the parent supplier (vendor) record to which this site belongs. A single supplier may operate multiple sites with distinct compliance profiles and capabilities.',
    `address_line1` STRING COMMENT 'Primary street address line of the supplier site. Used for logistics routing, ASN validation, and regulatory country-of-origin documentation.',
    `address_line2` STRING COMMENT 'Secondary address line for the supplier site (suite, building, floor, or unit number). Supplements address_line1 for precise logistics and compliance documentation.',
    `annual_production_capacity` DECIMAL(18,2) COMMENT 'Declared annual production or throughput capacity of the supplier site in the sites primary unit of measure. Used for supply assurance assessments, dual-sourcing decisions, and demand planning stress tests.',
    `approved_date` DATE COMMENT 'Date on which this supplier site was formally approved and added to the Approved Vendor List (AVL). Marks the start of the sites eligibility for purchase order creation.',
    `approved_vendor_list_status` STRING COMMENT 'Indicates the sites standing on the Approved Vendor List (AVL). Only sites with approved status are eligible for standard purchase order creation. conditional or probationary may require additional quality oversight.. Valid values are `approved|conditional|probationary|suspended|not_approved`',
    `audit_result` STRING COMMENT 'Categorical outcome of the most recent supplier site audit. Drives AVL status updates and corrective action plan (CAP) initiation. conditional_pass requires documented corrective actions within a defined timeframe.. Valid values are `pass|conditional_pass|fail|pending`',
    `capacity_unit_of_measure` STRING COMMENT 'Unit of measure for the annual_production_capacity field (e.g., MT for metric tonnes, KG, L, CS). Ensures correct interpretation of capacity data across procurement and supply planning systems.',
    `city` STRING COMMENT 'City in which the supplier site is physically located. Used for geographic sourcing analysis, logistics zone assignment, and regulatory jurisdiction determination.',
    `country_code` STRING COMMENT 'ISO 3166-1 alpha-3 three-letter country code for the supplier site location (e.g., USA, DEU, CHN). Drives country-of-origin labeling, import/export compliance, and tariff classification.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the supplier site record was first created in the source system. Supports data lineage, audit trail, and record lifecycle tracking per enterprise data governance standards.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the default transaction currency used with this supplier site (e.g., USD, EUR, GBP). Used in purchase order creation and spend analytics.. Valid values are `^[A-Z]{3}$`',
    `fda_registration_number` STRING COMMENT 'FDA-assigned facility registration number for the supplier site, required under FSMA for domestic and foreign food facilities. Used to verify regulatory standing and support FSVP compliance.. Valid values are `^[0-9]{7,12}$`',
    `food_safety_cert_expiry_date` DATE COMMENT 'Expiration date of the sites primary food safety certification (SQF, FSSC 22000, BRC, etc.). Triggers automated renewal alerts in TraceGains and may suspend sourcing eligibility if expired.',
    `food_safety_certification` STRING COMMENT 'Primary food safety certification held by this supplier site (e.g., SQF, FSSC 22000, BRC, IFS). Determines eligibility for sourcing food-contact materials and ingredients. [ENUM-REF-CANDIDATE: SQF|FSSC_22000|BRC|IFS|SQF_2000|HACCP|GMP|none — promote to reference product]',
    `gfsi_scheme` STRING COMMENT 'Specific GFSI-benchmarked certification scheme held by this site. Distinct from the broader food_safety_certification field — captures the exact scheme name for regulatory and customer audit reporting. [ENUM-REF-CANDIDATE: SQF|FSSC_22000|BRC_GSFS|IFS_Food|GLOBALG.A.P.|PRIMUS_GFS|none — promote to reference product]. Valid values are `SQF|FSSC_22000|BRC_GSFS|IFS_Food|GLOBALG.A.P.|PRIMUS_GFS|none`',
    `haccp_certified` BOOLEAN COMMENT 'Indicates whether the supplier site holds a current Hazard Analysis Critical Control Points (HACCP) certification. Required for sites supplying direct food ingredients or food-contact packaging.',
    `halal_certified` BOOLEAN COMMENT 'Indicates whether the supplier site holds a current Halal certification from a recognized certifying body. Required for ingredient sourcing for Halal-labeled product lines in applicable markets.',
    `incoterms_code` STRING COMMENT 'International Commercial Terms (Incoterms) code governing the transfer of risk and freight responsibility for shipments from this supplier site (e.g., FOB, DDP, CIF). Drives logistics cost allocation and customs documentation. [ENUM-REF-CANDIDATE: EXW|FCA|CPT|CIP|DAP|DPU|DDP|FAS|FOB|CFR|CIF — 11 candidates stripped; promote to reference product]',
    `kosher_certified` BOOLEAN COMMENT 'Indicates whether the supplier site holds a current Kosher certification from a recognized certifying agency. Relevant for ingredient sourcing for Kosher-labeled product lines.',
    `last_audit_date` DATE COMMENT 'Date of the most recent quality or food safety audit conducted at this supplier site. Used to determine audit frequency compliance and trigger re-audit scheduling per GFSI and internal procurement policy.',
    `last_audit_score` DECIMAL(18,2) COMMENT 'Numeric score achieved by the supplier site in the most recent quality or food safety audit, expressed as a percentage (0.00–100.00). Used in supplier performance scorecards and AVL status decisions.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the supplier site record in the source system. Used for incremental data pipeline processing and change detection in the Databricks Silver layer.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the supplier site in decimal degrees (WGS 84). Enables geospatial supply chain risk analysis, logistics optimization, and distance-to-DC calculations.',
    `lead_time_days` STRING COMMENT 'Standard procurement lead time in calendar days from purchase order placement to goods receipt at the destination DC for this specific supplier site. Site-level lead times override supplier-level defaults in MRP/IBP planning.',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the supplier site in decimal degrees (WGS 84). Used alongside latitude for geospatial supply chain risk analysis and logistics routing.',
    `moq` DECIMAL(18,2) COMMENT 'Minimum Order Quantity (MOQ) required by this supplier site per purchase order line. Used in procurement planning, MRP order proposals, and trade negotiation. Expressed in the sites standard ordering unit of measure.',
    `moq_unit_of_measure` STRING COMMENT 'Unit of measure applicable to the MOQ field (e.g., KG, LB, CS, PAL, EA). Ensures correct interpretation of the MOQ value in procurement planning and ERP order creation.',
    `next_audit_due_date` DATE COMMENT 'Scheduled due date for the next quality or food safety audit at this supplier site. Calculated based on audit frequency policy, risk tier, and last audit date. Managed in TraceGains.',
    `organic_certified` BOOLEAN COMMENT 'Indicates whether the supplier site holds a current organic certification (e.g., USDA NOP, EU Organic). Required for sites supplying organic-labeled ingredients or finished goods.',
    `payment_terms_code` STRING COMMENT 'Code identifying the negotiated payment terms for this supplier site (e.g., NET30, NET60, 2/10NET30). Drives accounts payable scheduling and cash flow planning in SAP FI.. Valid values are `^[A-Z0-9]{2,10}$`',
    `postal_code` STRING COMMENT 'Postal or ZIP code of the supplier site. Used for logistics carrier zone rating, geographic clustering, and regulatory reporting.',
    `primary_contact_email` STRING COMMENT 'Email address of the primary business contact at the supplier site. Used for purchase order notifications, compliance document requests, and audit scheduling.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `primary_contact_name` STRING COMMENT 'Full name of the primary business contact at the supplier site (e.g., account manager, quality manager). Used for procurement communications, audit coordination, and escalation management.',
    `quality_contact_name` STRING COMMENT 'Full name of the quality or food safety contact at the supplier site. Used for HACCP documentation requests, corrective action plan (CAP) communications, and audit coordination.',
    `risk_tier` STRING COMMENT 'Procurement risk classification for the supplier site based on factors including food safety criticality, single-source dependency, geographic risk, and spend concentration. Drives audit frequency, safety stock levels, and contingency sourcing plans.. Valid values are `critical|high|medium|low`',
    `site_code` STRING COMMENT 'Externally-known alphanumeric code uniquely identifying this supplier site, used in purchase orders, EDI transactions, and ASN communications. Corresponds to the vendor sub-range or delivery address code in SAP MM.. Valid values are `^[A-Z0-9_-]{2,20}$`',
    `site_email` STRING COMMENT 'Primary email address for the supplier site, used for purchase order transmission, ASN notifications, and compliance document requests via TraceGains.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `site_name` STRING COMMENT 'Human-readable name of the supplier site (e.g., Acme Ingredients — Chicago Plant, Global Packaging — Rotterdam DC). Used in procurement documents, scorecards, and audit reports.',
    `site_phone` STRING COMMENT 'Primary telephone number for the supplier site, used for procurement communications, quality escalations, and logistics coordination.',
    `site_status` STRING COMMENT 'Current lifecycle status of the supplier site record. Controls whether the site is eligible for purchase order creation and sourcing. suspended indicates a temporary hold pending audit or corrective action.. Valid values are `active|inactive|suspended|pending_approval|deactivated`',
    `site_type` STRING COMMENT 'Classification of the supplier site by its primary operational function. Drives sourcing decisions, compliance requirements, and audit frequency. [ENUM-REF-CANDIDATE: manufacturing_plant|warehouse|distribution_hub|co_packer|toll_manufacturer|service_delivery|laboratory|office — promote to reference product]',
    `state_province` STRING COMMENT 'State, province, or region of the supplier site address. Used for regulatory jurisdiction mapping (e.g., FDA district, USDA region) and tax compliance.',
    `usda_establishment_number` STRING COMMENT 'USDA-assigned establishment number for supplier sites involved in meat, poultry, or egg product processing. Required for USDA FSIS-regulated facilities and used in regulatory traceability.',
    CONSTRAINT pk_supplier_site PRIMARY KEY(`supplier_site_id`)
) COMMENT 'Physical or logical site/location record for each supplier — manufacturing plants, warehouses, distribution hubs, and service delivery locations. Captures site address, country of origin, site-level certifications (SQF, GFSI, FSSC 22000), site capacity, and site-specific lead times. A single supplier may have multiple sites with different compliance profiles and capabilities relevant to F&B sourcing decisions.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`procurement`.`approved_vendor_list` (
    `approved_vendor_list_id` BIGINT COMMENT 'Unique surrogate identifier for each supplier-material combination record in the Approved Vendor List. Primary key for the AVL entity in the Silver Layer lakehouse.',
    `supplier_id` BIGINT COMMENT 'Reference to the supplier/vendor master record. Identifies the approved supplier entity in this AVL entry.',
    `raw_material_id` BIGINT COMMENT 'Reference to the raw material, ingredient, or packaging material record that this supplier is approved to supply.',
    `specification_id` BIGINT COMMENT 'Foreign key linking to quality.specification. Business justification: AVL records in F&B govern which suppliers are approved to supply a specific raw material against a quality specification. Linking AVL to the governing specification enforces that only spec-compliant s',
    `supplier_quality_assessment_id` BIGINT COMMENT 'Foreign key linking to quality.supplier_quality_assessment. Business justification: AVL approval in F&B is directly driven by supplier quality assessment outcomes (SQF/BRC/FSSC scores). The AVL record must reference the qualifying SQA for audit trail, requalification scheduling, and ',
    `allergen_approved_flag` BOOLEAN COMMENT 'Indicates whether the supplier has been specifically assessed and approved for allergen management controls relevant to this material. Supports allergen matrix compliance and FSMA preventive controls.',
    `approval_date` DATE COMMENT 'Date on which the supplier-material combination was formally approved and added to the AVL. Represents the effective start of the approval period.',
    `approval_notes` STRING COMMENT 'Free-text field capturing conditions, restrictions, or rationale associated with the approval decision. For example, conditional approvals may specify required corrective actions or usage limitations.',
    `approval_status` STRING COMMENT 'Current lifecycle status of the supplier-material approval. approved = fully qualified; conditionally_approved = approved with restrictions; suspended = temporarily halted pending investigation; revoked = permanently removed; pending_review = under qualification assessment; expired = approval period lapsed without renewal.. Valid values are `approved|conditionally_approved|suspended|revoked|pending_review|expired`',
    `approval_tier` STRING COMMENT 'Sourcing tier designation for this supplier-material combination. primary = preferred first-source supplier; secondary = qualified backup supplier; contingency = emergency-use only supplier activated during supply disruptions.. Valid values are `primary|secondary|contingency`',
    `approved_by` STRING COMMENT 'Name or employee ID of the quality or procurement professional who formally approved this supplier-material combination for the AVL. Supports audit trail and regulatory accountability.',
    `audit_type` STRING COMMENT 'Classification of the most recent audit conducted for this supplier-material combination. first_party = self-assessment; second_party = customer-conducted; third_party = independent certification body; remote = virtual audit; desk_audit = document review only.. Valid values are `first_party|second_party|third_party|remote|desk_audit`',
    `avl_record_number` STRING COMMENT 'Business-facing unique identifier for the AVL record, formatted as AVL-XXXXXXXX. Used for cross-system referencing between SAP MM and TraceGains.. Valid values are `^AVL-[0-9]{8}$`',
    `certification_expiry_date` DATE COMMENT 'Expiry date of the suppliers primary food safety certification (e.g., SQF, FSSC 22000, BRC). Triggers re-certification alerts and may affect approval status if lapsed.',
    `country_of_origin` STRING COMMENT 'ISO 3166-1 alpha-3 country code representing the country where the material is sourced or manufactured by this supplier. Required for FSMA Foreign Supplier Verification Program (FSVP) compliance.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this AVL record was first created in the system. Supports audit trail and data lineage requirements.',
    `expiry_date` DATE COMMENT 'Date on which the current approval expires and must be renewed through re-qualification. Null indicates an open-ended approval with no scheduled expiry. Drives automated renewal workflow triggers.',
    `food_safety_certification` STRING COMMENT 'Primary food safety or quality certification held by the supplier for this material. SQF (Safe Quality Food), BRC (British Retail Consortium), FSSC 22000 (Food Safety System Certification), IFS (International Featured Standards). [ENUM-REF-CANDIDATE: SQF|BRC|FSSC_22000|IFS|GlobalGAP|Halal|Kosher|Organic|none — promote to reference product]',
    `fsvp_required_flag` BOOLEAN COMMENT 'Indicates whether this supplier-material combination is subject to FSMA Foreign Supplier Verification Program requirements due to the material being imported from outside the United States.',
    `haccp_verified_flag` BOOLEAN COMMENT 'Indicates whether the supplier has been verified as having an implemented and validated HACCP plan for this material, as required under FSMA preventive controls and GFSI standards.',
    `last_audit_date` DATE COMMENT 'Date of the most recent quality or food safety audit conducted at this suppliers facility for this material. Supports HACCP supplier verification and GFSI compliance tracking.',
    `last_audit_score` DECIMAL(18,2) COMMENT 'Numeric score (0.00–100.00) from the most recent supplier quality/food safety audit. Used in supplier performance scorecards and AVL renewal decisions.',
    `last_requalification_date` DATE COMMENT 'Date of the most recent supplier requalification assessment for this material. Used to track compliance with periodic requalification requirements under FSMA and GFSI.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to this AVL record. Used for change tracking, data synchronization between TraceGains and SAP MM, and compliance audit trails.',
    `lead_time_days` STRING COMMENT 'Standard procurement lead time in calendar days from purchase order placement to material receipt for this supplier-material combination. Used in demand planning and inventory optimization.',
    `moq` DECIMAL(18,2) COMMENT 'Minimum Order Quantity (MOQ) required by this supplier for this material. Sourced from SAP MM Purchasing Info Record. Used in purchase order creation and demand planning.',
    `moq_unit_of_measure` STRING COMMENT 'Unit of measure for the Minimum Order Quantity (MOQ), aligned with SAP MM base unit of measure. Examples: KG (kilogram), LB (pound), L (liter), EA (each), CS (case), PAL (pallet), MT (metric ton). [ENUM-REF-CANDIDATE: KG|LB|L|GAL|EA|CS|PAL|MT — 8 candidates stripped; promote to reference product]',
    `next_requalification_date` DATE COMMENT 'Scheduled date for the next supplier requalification review. Calculated based on requalification frequency policy and last requalification date. Drives procurement compliance calendar.',
    `non_gmo_verified_flag` BOOLEAN COMMENT 'Indicates whether the suppliers material has been verified as non-GMO (Genetically Modified Organism), supporting clean label and non-GMO product claims.',
    `organic_certified_flag` BOOLEAN COMMENT 'Indicates whether the supplier holds USDA National Organic Program (NOP) certification for this material. Required for organic product formulations and clean label claims.',
    `plant_code` STRING COMMENT 'SAP plant code (WERKS) indicating the manufacturing or distribution facility for which this supplier-material approval is valid. Null indicates approval is valid across all plants in the purchasing organization.',
    `preferred_supplier_flag` BOOLEAN COMMENT 'Indicates whether this supplier is designated as the preferred (first-choice) source for this material within its approval tier. Used in automated purchase order source determination.',
    `purchasing_org_code` STRING COMMENT 'SAP MM Purchasing Organization code (EKORG) responsible for managing this supplier-material approval. Determines the organizational scope of the AVL entry.',
    `qualification_basis` STRING COMMENT 'The primary quality and regulatory basis on which the supplier approval was granted. Indicates the type of evidence used to qualify the supplier for this material. [ENUM-REF-CANDIDATE: audit|certificate|questionnaire|third_party_cert|historical_performance|regulatory_approval — promote to reference product]. Valid values are `audit|certificate|questionnaire|third_party_cert|historical_performance|regulatory_approval`',
    `sap_info_record_number` STRING COMMENT 'SAP MM Purchasing Info Record number (EINE-INFNR) linking this AVL entry to the corresponding purchasing conditions and pricing data in SAP S/4HANA.',
    `sole_source_flag` BOOLEAN COMMENT 'Indicates whether this supplier is the only approved source for this material, representing a single-source supply risk. Triggers supply risk alerts and dual-sourcing initiatives.',
    `source_list_indicator` BOOLEAN COMMENT 'Indicates whether this supplier-material combination is included in the SAP MM Source List (EORD), making it eligible for automatic source determination in purchase requisitions and orders.',
    `supplier_risk_tier` STRING COMMENT 'Risk classification assigned to this supplier-material combination based on food safety hazard severity, supply criticality, and supplier performance history. Drives frequency of verification activities under FSMA.. Valid values are `critical|high|medium|low`',
    `suspension_reason` STRING COMMENT 'Reason code or description explaining why the supplier-material approval was suspended or revoked. Populated when approval_status is suspended or revoked. Supports CAPA (Corrective and Preventive Action) tracking.',
    `tracegains_document_code` STRING COMMENT 'Reference to the primary compliance document (e.g., supplier specification, audit report, certificate of analysis) stored in TraceGains Document Management that supports this AVL approval.',
    CONSTRAINT pk_approved_vendor_list PRIMARY KEY(`approved_vendor_list_id`)
) COMMENT 'Approved Vendor List (AVL) — the authoritative register of supplier-material combinations that are approved for use in F&B production. Tracks approval status, approval date, expiry date, approved material categories (ingredients, packaging, indirect), approval tier (primary, secondary, contingency), and the quality/regulatory basis for approval. Directly supports FSMA, HACCP, and GFSI compliance requirements. Managed in TraceGains and synchronized with SAP MM.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`procurement`.`purchase_order` (
    `purchase_order_id` BIGINT COMMENT 'Unique surrogate identifier for the purchase order record in the Silver Layer lakehouse. Primary key. TRANSACTION_HEADER role — canonical minimum categories enforced.',
    `account_id` BIGINT COMMENT 'Foreign key linking to customer.account. Business justification: Direct customer‑specific purchase orders tie spend to the originating account for order‑to‑cash reconciliation and account‑level reporting.',
    `center_id` BIGINT COMMENT 'Foreign key linking to distribution.center. Business justification: Purchase orders for DC replenishment (supplier delivering to a distribution center) must reference the specific DC for inbound dock scheduling, capacity planning, and receiving coordination. delivery_',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Required for allocating PO expenses to the appropriate cost center in financial reporting and budgeting, as the PO expense is posted to a cost center per standard F&B accounting practice.',
    `storage_location_id` BIGINT COMMENT 'Foreign key linking to inventory.storage_location. Business justification: Purchase orders must specify delivery destination for receiving operations, warehouse capacity planning, and dock scheduling. Critical for coordinating inbound logistics with warehouse operations. No ',
    `fsma_record_id` BIGINT COMMENT 'Foreign key linking to regulatory.fsma_record. Business justification: Order processing records the associated FSMA compliance record for the supplier’s facility to support food safety audits.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Needed to map each purchase order to the GL account for expense posting, enabling accurate GL trial balance and compliance with financial statements.',
    `plant_id` BIGINT COMMENT 'Reference to the receiving plant or distribution center (DC) where the ordered goods or services are to be delivered. Maps to SAP EKPO-WERKS plant code.',
    `purchase_contract_id` BIGINT COMMENT 'Reference to the underlying procurement contract or blanket purchase agreement (outline agreement) against which this PO is released. Nullable for spot/one-time purchases. Maps to SAP EKKO-KONNR contract number.',
    `supplier_id` BIGINT COMMENT 'Reference to the supplier (vendor) master record from whom goods or services are being procured. Serves as the PARTY_REFERENCE for this transaction header. Maps to SAP EKKO-LIFNR vendor number.',
    `actual_delivery_date` DATE COMMENT 'The date on which goods were physically received at the destination plant or DC, as recorded in the goods receipt (GR) posting. Used for OTIF calculation and supplier performance scorecarding.',
    `approval_date` DATE COMMENT 'The date on which the purchase order received final approval and was authorized for transmission to the supplier. Used for cycle time analysis and procurement governance reporting.',
    `approval_status` STRING COMMENT 'Current status of the purchase order within the approval workflow. pending = awaiting approver action; approved = all required approvals obtained; rejected = denied by an approver; escalated = routed to higher authority due to value threshold or timeout. Supports SOX compliance and procurement governance.. Valid values are `pending|approved|rejected|escalated`',
    `approved_by` STRING COMMENT 'User ID or name of the final approver who authorized the purchase order. Used for audit trail, SOX compliance, and procurement governance. Maps to SAP workflow approval history.',
    `blanket_po_value_limit` DECIMAL(18,2) COMMENT 'Maximum cumulative value authorized for release against a blanket purchase order or framework agreement. Applicable only when po_type = blanket_release. Used for spend control and contract compliance monitoring. Maps to SAP EKKO-KTWRT.',
    `company_code` STRING COMMENT 'SAP or Oracle company code representing the legal entity issuing the purchase order. Determines the accounting ledger, currency, and fiscal year variant for financial postings. Maps to SAP EKKO-BUKRS.. Valid values are `^[A-Z0-9]{1,6}$`',
    `confirmed_delivery_date` DATE COMMENT 'The delivery date confirmed by the supplier in their order acknowledgment. May differ from the requested delivery date. Used to calculate delivery variance and OTIF performance. Maps to SAP EKPO-EINDT after supplier confirmation.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the purchase order record was first created in the source ERP system. RECORD_AUDIT_CREATED canonical category. Maps to SAP EKKO-AEDAT / creation time.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code in which the purchase order is denominated (e.g., USD, EUR, GBP, CAD). Part of the MONETARY_TRIPLET canonical category. Maps to SAP EKKO-WAERS.. Valid values are `^[A-Z]{3}$`',
    `exchange_rate` DECIMAL(18,2) COMMENT 'Foreign currency exchange rate applied at the time of PO creation to convert the PO currency to the company code local currency. Used for financial reporting and spend analytics in local currency. Maps to SAP EKKO-WKURS.',
    `food_safety_hold_indicator` BOOLEAN COMMENT 'Flag indicating whether this purchase order or its associated materials are currently under a food safety hold pending quality inspection, allergen verification, or HACCP review. When True, goods receipt and production use are blocked until cleared by QA. Supports FSMA and HACCP compliance.',
    `goods_receipt_indicator` BOOLEAN COMMENT 'Flag indicating whether a goods receipt (GR) is required before invoice verification for this purchase order. When True, the three-way match (PO-GR-Invoice) is enforced. When False, two-way match (PO-Invoice) applies. Maps to SAP EKPO-WEPOS.',
    `hazmat_indicator` BOOLEAN COMMENT 'Flag indicating whether any item on this purchase order is classified as a hazardous material requiring special handling, labeling, or transport documentation under DOT, IATA, or IMDG regulations. Relevant for chemical ingredients, cleaning agents, and certain food additives.',
    `incoterms_code` STRING COMMENT 'International Commercial Terms (Incoterms 2020) code defining the transfer of risk, cost responsibility, and delivery obligations between buyer and supplier. Critical for import/export compliance, freight cost allocation, and insurance. Maps to SAP EKKO-INCO1. [ENUM-REF-CANDIDATE: EXW|FCA|CPT|CIP|DAP|DPU|DDP|FAS|FOB|CFR|CIF — 11 candidates stripped; promote to reference product]',
    `incoterms_location` STRING COMMENT 'The named place or port associated with the Incoterms code (e.g., Port of Los Angeles for FOB, Buyer Warehouse Chicago for DDP). Required to fully define the delivery obligation under Incoterms 2020. Maps to SAP EKKO-INCO2.',
    `invoice_verification_indicator` BOOLEAN COMMENT 'Flag indicating whether invoice-based verification (LIV - Logistics Invoice Verification) is required for this PO. When False, evaluated receipt settlement (ERS) may apply. Maps to SAP EKPO-REPOS.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the purchase order record was last modified in the source ERP system. RECORD_AUDIT_UPDATED canonical category. Used for incremental data pipeline processing and change tracking.',
    `material_group_code` STRING COMMENT 'Commodity or material group classification code for the primary category of goods or services on this PO (e.g., raw ingredients, packaging materials, indirect MRO, co-packing services). Used for spend analytics by category and supplier segmentation. Maps to SAP EKPO-MATKL.. Valid values are `^[A-Z0-9]{1,10}$`',
    `moq` DECIMAL(18,2) COMMENT 'Minimum Order Quantity (MOQ) stipulated by the supplier for this purchase order, expressed in the base unit of measure. Used in procurement planning, order optimization, and supplier negotiation. Maps to SAP EKPO-MINBM.',
    `net_amount` DECIMAL(18,2) COMMENT 'Total net value of the purchase order after discounts but before tax, in the PO currency. This is the principal financial commitment amount used in spend analytics, budget tracking, and COGS reporting. Part of the MONETARY_TRIPLET net total component. Maps to SAP EKKO-NETWR.',
    `order_date` DATE COMMENT 'The calendar date on which the purchase order was formally issued and transmitted to the supplier. This is the principal BUSINESS_EVENT_TIMESTAMP (date precision) for the procurement transaction. Maps to SAP EKKO-BEDAT.',
    `payment_terms_code` STRING COMMENT 'Code identifying the agreed payment terms between the buying organization and the supplier (e.g., NET30, NET60, 2/10NET30 for 2% discount if paid within 10 days). Drives accounts payable scheduling and cash flow planning. Maps to SAP EKKO-ZTERM.. Valid values are `^[A-Z0-9]{1,10}$`',
    `po_gross_amount` DECIMAL(18,2) COMMENT 'Total gross value of the purchase order before discounts, taxes, and freight charges, expressed in the PO currency. Represents the sum of all line-level extended prices. Part of the MONETARY_TRIPLET canonical category.',
    `po_number` STRING COMMENT 'Externally-known alphanumeric purchase order number assigned by the ERP system (SAP S/4HANA or Oracle Cloud Procurement) and communicated to the supplier on the PO document. This is the BUSINESS_IDENTIFIER used in supplier correspondence, EDI transactions, and ASN matching. Maps to SAP EKKO-EBELN.. Valid values are `^[A-Z0-9-]{1,20}$`',
    `po_status` STRING COMMENT 'Current lifecycle status of the purchase order. draft = created but not submitted; pending_approval = in approval workflow; approved = approved and transmitted to supplier; open = active with outstanding delivery; partially_received = goods receipt posted for some lines; closed = fully received and invoiced; cancelled = voided before fulfillment. LIFECYCLE_STATUS canonical category. Maps to SAP EKKO processing status. [ENUM-REF-CANDIDATE: draft|pending_approval|approved|open|partially_received|closed|cancelled — 7 candidates stripped; promote to reference product]',
    `po_type` STRING COMMENT 'Classification of the purchase order by procurement strategy. standard = one-time discrete PO; blanket_release = release against a blanket/framework agreement; subcontracting = toll manufacturing or co-packing arrangement where components are supplied to the vendor; service = service entry sheet-based PO for indirect services; consignment = vendor-managed inventory replenishment. Maps to SAP EKKO-BSART document type.. Valid values are `standard|blanket_release|subcontracting|service|consignment`',
    `purchasing_group_code` STRING COMMENT 'Code identifying the buyer or purchasing group (commodity team) within the purchasing organization responsible for this PO. Used for spend analytics by buyer, workload management, and supplier relationship ownership. Maps to SAP EKKO-EKGRP.. Valid values are `^[A-Z0-9]{1,6}$`',
    `purchasing_org_code` STRING COMMENT 'Code identifying the SAP purchasing organization responsible for negotiating and issuing this purchase order. Determines the procurement authority, pricing conditions, and vendor master assignments. Maps to SAP EKKO-EKORG.. Valid values are `^[A-Z0-9]{1,10}$`',
    `requested_delivery_date` DATE COMMENT 'The date by which the buying organization requests delivery of the ordered goods or services at the destination plant or DC. Used for supply planning, OTIF measurement, and SLA tracking. Maps to SAP EKPO-EINDT.',
    `source_system` STRING COMMENT 'Identifies the operational system of record from which this purchase order was sourced. SAP_S4HANA = SAP S/4HANA MM purchasing module; ORACLE_CLOUD = Oracle Cloud Procurement; MANUAL = manually entered in the lakehouse. Supports data lineage and multi-system reconciliation.. Valid values are `SAP_S4HANA|ORACLE_CLOUD|MANUAL`',
    `source_system_po_key` STRING COMMENT 'The native primary key or document number of the purchase order in the originating source system (e.g., SAP EKKO-EBELN or Oracle PO header ID). Used for cross-system reconciliation, data lineage tracing, and support ticket resolution.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Total tax amount applicable to the purchase order (e.g., VAT, GST, sales tax) in the PO currency. Part of the MONETARY_TRIPLET adjustment component. Maps to SAP EKKO tax conditions.',
    `total_quantity_ordered` DECIMAL(18,2) COMMENT 'Total quantity of goods or services ordered across all lines of this purchase order, expressed in the base unit of measure (uom_code). Used for inventory planning, receiving, and OTIF measurement.',
    `total_quantity_received` DECIMAL(18,2) COMMENT 'Cumulative quantity of goods received against this purchase order as of the latest goods receipt posting, expressed in the base unit of measure. Used to calculate open PO quantity, OTIF fill rate, and goods receipt variance.',
    `tracegains_compliance_status` STRING COMMENT 'Compliance status of the supplier for this purchase order as tracked in TraceGains, the supplier compliance and document management platform. Reflects whether required supplier documents (COA, SQF certificate, allergen declaration, FSMA compliance) are current and approved. compliant = all documents valid; non_compliant = missing or expired documents; pending_review = documents submitted but under review; not_required = compliance check not applicable.. Valid values are `compliant|non_compliant|pending_review|not_required`',
    `uom_code` STRING COMMENT 'Base unit of measure code for the purchase order quantity (e.g., KG, LB, L, EA, CS, PAL). Aligns with SAP base UOM and is used for inventory valuation, recipe/BOM costing, and nutritional compliance calculations. Maps to SAP EKPO-MEINS.. Valid values are `^[A-Z]{1,6}$`',
    CONSTRAINT pk_purchase_order PRIMARY KEY(`purchase_order_id`)
) COMMENT 'Core procurement transaction record representing a formal purchase order (PO) issued to a supplier for raw materials, ingredients, packaging, indirect materials, or services. Captures PO number, PO type (standard, blanket release, subcontracting, service), order date, requested delivery date, plant/DC destination, total PO value, currency, payment terms, Incoterms, and approval workflow status. Sourced from SAP S/4HANA MM purchasing module and Oracle Cloud Procurement.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`procurement`.`po_line` (
    `po_line_id` BIGINT COMMENT 'Unique surrogate identifier for each purchase order line item in the Silver layer lakehouse. Primary key for the po_line data product. Entity role: TRANSACTION_LINE.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Each PO line may be charged to a specific cost center, supporting detailed cost allocation and variance analysis per line item in F&B cost management.',
    `storage_location_id` BIGINT COMMENT 'Foreign key linking to inventory.storage_location. Business justification: Line-level delivery locations enable mixed-destination orders (e.g., raw materials to plant A, packaging to plant B). Supports warehouse slotting, receiving prep, and cross-dock operations. Essential ',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Links PO line items to GL accounts for precise posting of material costs, essential for financial reporting and audit trails.',
    `purchase_contract_id` BIGINT COMMENT 'Reference to the raw material pricing contract or framework agreement governing the terms of this purchase order line. Supports contract compliance and price variance analysis.',
    `purchase_order_id` BIGINT COMMENT 'Foreign key reference to the parent purchase order header. Establishes the header/detail relationship for BOM-driven procurement and spend analytics. Satisfies TRANSACTION_LINE category: HEADER_REFERENCE.',
    `raw_material_id` BIGINT COMMENT 'Reference to the material or ingredient master record being procured on this line. Links to the material master for BOM-driven procurement, allergen matrix, and raw material cost tracking (COGS). Satisfies TRANSACTION_LINE category: RESOURCE_REFERENCE.',
    `specification_id` BIGINT COMMENT 'Identifier linking this purchase order line to the approved raw material or ingredient specification document in TraceGains. Ensures that the procured material conforms to the approved specification for food safety and regulatory compliance.',
    `supplier_id` BIGINT COMMENT 'Reference to the supplier (vendor) fulfilling this purchase order line. Used for supplier performance scorecards, approved vendor list validation, and spend analytics by supplier.',
    `account_assignment_category` STRING COMMENT 'Determines how the procurement cost is assigned in financial accounting (e.g., to a cost center for indirect materials, to a production order for direct ingredients, to a project for capital expenditure). Critical for COGS and EBITDA reporting.. Valid values are `cost_center|order|project|asset|sales_order|not_assigned`',
    `allergen_flag` BOOLEAN COMMENT 'Indicates whether the material being procured on this line contains or may contain one or more regulated allergens (e.g., peanuts, tree nuts, milk, eggs, wheat, soy, fish, shellfish). Triggers allergen matrix validation and segregated storage requirements.',
    `batch_required` BOOLEAN COMMENT 'Indicates whether batch management is required for this material upon goods receipt, enabling lot traceability for food safety compliance (HACCP, FSMA). When true, a batch number must be assigned at goods receipt.',
    `confirmed_delivery_date` DATE COMMENT 'The delivery date confirmed by the supplier via order acknowledgment or Advanced Shipping Notice (ASN). Used to calculate delivery variance against the requested date for OTIF performance tracking.',
    `country_of_origin` STRING COMMENT 'ISO 3166-1 alpha-3 country code indicating the country where the raw material or ingredient was produced or sourced. Required for country-of-origin labeling (COOL) compliance, import duty calculation, and supply chain risk assessment.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this purchase order line record was first created in the source ERP system. Used for audit trail, procurement cycle time analysis, and data lineage tracking in the Silver layer.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the monetary values on this purchase order line (e.g., USD, EUR, GBP). Required for multi-currency procurement and financial consolidation.. Valid values are `^[A-Z]{3}$`',
    `deletion_indicator` BOOLEAN COMMENT 'Indicates whether this purchase order line has been marked for deletion in the source ERP system. Soft-delete flag used to exclude cancelled or obsolete lines from active procurement reporting while retaining audit history.',
    `delivery_date` DATE COMMENT 'The date on which delivery of the material or service is requested at the receiving plant or distribution center. Drives production scheduling, inventory planning, and OTIF (On Time In Full) performance measurement.',
    `goods_receipt_indicator` BOOLEAN COMMENT 'Indicates whether a goods receipt is required for this purchase order line before invoice payment can be processed. Mandatory for direct materials (ingredients, packaging) to enforce three-way match; may be waived for certain service lines.',
    `goods_receipt_quantity` DECIMAL(18,2) COMMENT 'Cumulative quantity of the material actually received against this purchase order line, expressed in the order unit of measure. Used to calculate open quantity, delivery completeness, and three-way match for invoice verification.',
    `incoterms_code` STRING COMMENT 'International Commercial Terms (Incoterms) code defining the delivery obligations, risk transfer point, and cost responsibilities between buyer and supplier for this purchase order line (e.g., FOB, DDP, CIF). Impacts landed cost calculation. [ENUM-REF-CANDIDATE: EXW|FCA|CPT|CIP|DAP|DPU|DDP|FAS|FOB|CFR|CIF — 11 candidates stripped; promote to reference product]',
    `invoice_receipt_indicator` BOOLEAN COMMENT 'Indicates whether an invoice is expected for this purchase order line. When false, the system may use evaluated receipt settlement (ERS/self-billing) for high-volume ingredient suppliers.',
    `invoiced_quantity` DECIMAL(18,2) COMMENT 'Cumulative quantity invoiced by the supplier against this purchase order line. Used in three-way match (PO quantity vs. GR quantity vs. invoice quantity) for accounts payable processing and accrual management.',
    `item_category` STRING COMMENT 'SAP item category code defining the procurement type for this line (e.g., standard stock material, subcontracting for toll manufacturing/co-packing, consignment, service). Determines goods receipt and invoice verification behavior.. Valid values are `standard|consignment|subcontracting|third_party|service|limit`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to this purchase order line in the source ERP system. Supports change detection for incremental data loads and audit compliance.',
    `line_number` STRING COMMENT 'Sequential line item number within the parent purchase order, as assigned by the ERP system (e.g., 10, 20, 30 in SAP). Used for ordering and referencing individual line items within a PO. Satisfies TRANSACTION_LINE category: LINE_SEQUENCE.',
    `line_status` STRING COMMENT 'Current processing status of the purchase order line item reflecting its fulfillment lifecycle. Drives procurement workflow, goods receipt matching, and accounts payable processing. [ENUM-REF-CANDIDATE: open|partially_delivered|fully_delivered|invoiced|closed|cancelled — promote to reference product]. Valid values are `open|partially_delivered|fully_delivered|invoiced|closed|cancelled`',
    `material_code` STRING COMMENT 'ERP-assigned alphanumeric code uniquely identifying the raw material, ingredient, or packaging material being procured. Aligns with the material master and Bill of Materials (BOM) for ingredient traceability and COGS tracking.',
    `material_description` STRING COMMENT 'Short descriptive name of the raw material, ingredient, or packaging item as defined in the material master. Supports procurement reporting, invoice matching, and supplier communication.',
    `material_group_code` STRING COMMENT 'Classification code grouping materials by commodity or category (e.g., sweeteners, dairy ingredients, flexible packaging, corrugated). Used for spend analytics, category management, and sourcing strategy.',
    `moq` DECIMAL(18,2) COMMENT 'Minimum Order Quantity as agreed with the supplier for this material. Used to validate that ordered_quantity meets supplier requirements and to optimize order quantities in demand planning and procurement.',
    `net_value` DECIMAL(18,2) COMMENT 'Total net monetary value of this purchase order line, calculated as (ordered_quantity / price_unit) × unit_price. Represents the committed spend for this line item and feeds into COGS and procurement spend analytics.',
    `order_unit` STRING COMMENT 'Unit of measure in which the ordered quantity is expressed (e.g., KG, LB, L, EA, CS, MT). Must align with the material master order unit for accurate goods receipt and invoice verification.',
    `ordered_quantity` DECIMAL(18,2) COMMENT 'Quantity of the material or service ordered on this purchase order line, expressed in the order unit of measure. Compared against Minimum Order Quantity (MOQ) thresholds and used for demand planning reconciliation. Satisfies TRANSACTION_LINE category: LINE_QUANTITY.',
    `organic_certified` BOOLEAN COMMENT 'Indicates whether the material procured on this line is certified organic, requiring supplier certification documentation and chain-of-custody compliance. Supports clean label and organic product formulation requirements.',
    `overdelivery_tolerance_pct` DECIMAL(18,2) COMMENT 'Maximum percentage by which the supplier may over-deliver against the ordered quantity without triggering a purchase order amendment. Common in bulk ingredient procurement where exact quantities are difficult to control.',
    `plant_code` STRING COMMENT 'SAP plant code identifying the manufacturing facility, distribution center, or co-packing location where the material is to be delivered and consumed. Links procurement to production and inventory management.',
    `price_unit` DECIMAL(18,2) COMMENT 'The quantity base for which the unit price is quoted (e.g., price per 100 KG, price per 1000 units). Required for accurate net value calculation when pricing is expressed per multiple units, as is common in bulk ingredient procurement.',
    `purchasing_group_code` STRING COMMENT 'Code identifying the buyer or purchasing group responsible for managing this purchase order line. Used for workload distribution, buyer performance reporting, and escalation routing.',
    `purchasing_org_code` STRING COMMENT 'Code identifying the purchasing organization responsible for this purchase order line. Determines the negotiating entity, contract scope, and spend reporting hierarchy in the ERP system.',
    `quality_inspection_required` BOOLEAN COMMENT 'Indicates whether incoming quality inspection is required for this material upon goods receipt, per HACCP, GMP, or SQF requirements. When true, the material is placed in quality inspection stock until released by the QM team.',
    `shelf_life_days` STRING COMMENT 'Minimum remaining shelf life in days required at the time of goods receipt for this raw material or ingredient. Enforces FEFO (First Expired First Out) inventory management and prevents use of near-expiry ingredients in production.',
    `storage_location_code` STRING COMMENT 'Code identifying the specific storage location within the plant where the received material will be placed (e.g., raw material warehouse, cold storage, dry goods). Supports FIFO/FEFO inventory management and WMS integration.',
    `underdelivery_tolerance_pct` DECIMAL(18,2) COMMENT 'Maximum percentage by which the supplier may under-deliver against the ordered quantity and still have the line considered fully delivered. Prevents unnecessary open PO lines for minor quantity shortfalls.',
    `unit_price` DECIMAL(18,2) COMMENT 'Agreed net price per unit of measure for this purchase order line as negotiated with the supplier or derived from a pricing contract. Core input for COGS calculation and raw material cost tracking. Satisfies TRANSACTION_LINE category: LINE_VALUE_OR_RESULT.',
    CONSTRAINT pk_po_line PRIMARY KEY(`po_line_id`)
) COMMENT 'Individual line item within a purchase order, representing a specific material or service being procured. Captures line number, material/ingredient code, material description, ordered quantity, unit of measure, agreed unit price, net value, delivery schedule, storage location, batch requirements, and allergen/regulatory flags relevant to F&B ingredient procurement. Supports BOM-driven procurement and raw material cost tracking (COGS).';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`procurement`.`goods_receipt` (
    `goods_receipt_id` BIGINT COMMENT 'Primary key for goods_receipt',
    `center_id` BIGINT COMMENT 'Foreign key linking to distribution.center. Business justification: In F&B, suppliers frequently deliver raw materials and finished goods directly to distribution centers (not just manufacturing plants). Linking goods_receipt to the receiving DC enables inbound dock s',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Goods receipts trigger inventory capitalization and expense recognition. Finance requires cost center assignment for proper expense allocation, variance analysis, and automated journal entry generatio',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Goods receipts post to inventory GL accounts (raw materials, packaging materials, work-in-process). Finance needs this for automated journal entry generation, inventory valuation, and balance sheet re',
    `packaging_spec_id` BIGINT COMMENT 'Foreign key linking to product.packaging_spec. Business justification: When packaging materials are received, quality teams verify the receipt against the approved packaging spec (dimensions, material type, food-contact compliance). This link enables receiving inspection',
    `plant_id` BIGINT COMMENT 'Reference to the manufacturing plant or distribution center where the goods were physically received. Critical for inventory positioning and FEFO/FIFO assignment.',
    `po_line_id` BIGINT COMMENT 'Reference to the specific line item on the purchase order for which goods are being received. Enables line-level receipt tracking.',
    `production_order_id` BIGINT COMMENT 'Foreign key linking to manufacturing.production_order. Business justification: Co-packer/toll manufacturer finished goods receipt reconciliation: In F&B, goods receipts for externally manufactured products must be reconciled against the originating production order for yield var',
    `purchase_order_id` BIGINT COMMENT 'Reference to the purchase order against which this goods receipt is recorded. Links to the purchase order that authorized the procurement.',
    `raw_material_id` BIGINT COMMENT 'Reference to the material master record for the received item. Identifies the raw material, ingredient, packaging component, or indirect material received.',
    `shipment_id` BIGINT COMMENT 'Foreign key linking to distribution.shipment. Business justification: Matching inbound supplier shipments to goods receipts is a core F&B receiving process enabling FSMA traceability, three-way match, and cold chain compliance verification. carrier_name and bill_of_ladi',
    `storage_location_id` BIGINT COMMENT 'Reference to the specific storage location within the plant where the received goods are placed. Enables warehouse bin-level traceability.',
    `supplier_id` BIGINT COMMENT 'Reference to the supplier who delivered the goods. Links to the supplier master data for vendor performance tracking and compliance.',
    `allergen_declaration_received_flag` BOOLEAN COMMENT 'Indicates whether the supplier-provided allergen declaration was received with the goods. Critical for allergen matrix management and food safety compliance.',
    `batch_number` STRING COMMENT 'The supplier-provided batch or lot number for the received material. Critical for lot traceability, FSMA compliance, recall management, and FEFO inventory rotation.. Valid values are `^[A-Z0-9]{6,20}$`',
    `best_before_date` DATE COMMENT 'The date until which the received material maintains optimal quality characteristics. Used for inventory prioritization and customer service level management.',
    `certificate_of_analysis_received_flag` BOOLEAN COMMENT 'Indicates whether the supplier-provided certificate of analysis was received with the goods. Required for raw material release and TraceGains compliance documentation.',
    `cold_chain_compliant_flag` BOOLEAN COMMENT 'Indicates whether the received material met cold chain temperature requirements during transportation and receipt. Non-compliance triggers quality hold and supplier corrective action.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this goods receipt record was first created in the system. Provides audit trail for data lineage and system reconciliation.',
    `currency_code` STRING COMMENT 'The three-letter ISO 4217 currency code in which the goods receipt value is denominated. Required for multi-currency procurement and financial consolidation. [ENUM-REF-CANDIDATE: USD|EUR|GBP|CAD|MXN|BRL|CNY|JPY|AUD — 9 candidates stripped; promote to reference product]',
    `delivery_note_number` STRING COMMENT 'The supplier-provided delivery note or packing slip number accompanying the shipment. Used for cross-reference with supplier documentation and ASN reconciliation.. Valid values are `^DN[A-Z0-9]{8,15}$`',
    `expiration_date` DATE COMMENT 'The date after which the received material should not be used or sold. Critical for FEFO inventory rotation, quality hold decisions, and food safety compliance.',
    `goods_receipt_date` DATE COMMENT 'The date on which the goods were physically received at the plant or distribution center. This is the principal business event timestamp for the receipt transaction and triggers inventory valuation and FEFO/FIFO aging calculations.',
    `goods_receipt_number` STRING COMMENT 'The externally-known business identifier for this goods receipt transaction. Used for cross-system reconciliation, three-way match with invoice, and audit trails.. Valid values are `^GR[0-9]{10}$`',
    `goods_receipt_status` STRING COMMENT 'The current lifecycle status of the goods receipt transaction. Tracks the receipt through posting, quality inspection, approval, and final disposition workflows.. Valid values are `posted|pending_inspection|quality_hold|approved|rejected|cancelled`',
    `goods_receipt_timestamp` TIMESTAMP COMMENT 'The precise date and time when the goods receipt transaction was posted in the system. Provides granular audit trail for receipt processing and system reconciliation.',
    `manufacturing_date` DATE COMMENT 'The date on which the received material was manufactured or produced by the supplier. Used for shelf life calculation and FEFO inventory management.',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when this goods receipt record was last modified in the system. Tracks changes for audit compliance and data quality monitoring.',
    `movement_type` STRING COMMENT 'The SAP movement type code that classifies the type of goods receipt transaction. Standard codes include 101 (GR for PO), 122 (return delivery), 161 (return from customer).. Valid values are `101|102|103|105|122|161`',
    `ordered_quantity` DECIMAL(18,2) COMMENT 'The quantity originally ordered on the purchase order line. Used to calculate receipt variance and trigger exception workflows for over-receipts or under-receipts.',
    `quality_inspection_lot_number` STRING COMMENT 'The quality management inspection lot number assigned to this goods receipt for quality testing and approval. Links to quality inspection results and certificate of analysis.. Valid values are `^QI[0-9]{10}$`',
    `quality_inspection_required_flag` BOOLEAN COMMENT 'Indicates whether the received material requires quality inspection before being released to unrestricted inventory. Triggers quality management workflows per GMP and HACCP requirements.',
    `quantity_variance` DECIMAL(18,2) COMMENT 'The difference between received quantity and ordered quantity. Positive values indicate over-receipt; negative values indicate under-receipt. Triggers procurement exception handling and supplier performance scoring.',
    `received_quantity` DECIMAL(18,2) COMMENT 'The actual quantity of material received and accepted at the plant or distribution center. This is the confirmed receipt quantity used for inventory updates and three-way match with purchase order and invoice.',
    `receiving_notes` STRING COMMENT 'Free-text notes entered by the receiving clerk documenting any observations, damage, discrepancies, or special handling instructions for the received goods.',
    `shelf_life_days` STRING COMMENT 'The remaining shelf life of the received material in days, calculated from goods receipt date to expiration date. Used for FEFO assignment and inventory aging analytics.',
    `tax_amount` DECIMAL(18,2) COMMENT 'The total tax amount associated with this goods receipt. Used for three-way match with invoice and tax compliance reporting.',
    `tax_code` STRING COMMENT 'The tax jurisdiction code applied to this goods receipt for sales and use tax calculation. Used for tax compliance and invoice verification.. Valid values are `^[A-Z0-9]{2,4}$`',
    `temperature_at_receipt_c` DECIMAL(18,2) COMMENT 'The temperature of the received material at the time of receipt, measured in degrees Celsius. Critical for cold chain compliance and temperature-sensitive ingredient quality verification.',
    `total_value` DECIMAL(18,2) COMMENT 'The total monetary value of the goods receipt, calculated as received quantity multiplied by unit price. Used for inventory accounting and financial reconciliation.',
    `unit_of_measure` STRING COMMENT 'The unit of measure in which the received quantity is expressed. Must align with the purchase order UOM and material master base UOM for accurate inventory accounting. [ENUM-REF-CANDIDATE: KG|LB|L|GAL|EA|CS|PAL|MT|OZ|ML — 10 candidates stripped; promote to reference product]',
    `unit_price` DECIMAL(18,2) COMMENT 'The per-unit purchase price of the received material as recorded on the purchase order. Used for inventory valuation and three-way match with invoice.',
    `unloading_point` STRING COMMENT 'The specific dock or unloading bay at the plant or distribution center where the goods were received. Supports warehouse operations and receiving efficiency analytics.',
    `valuation_type` STRING COMMENT 'The inventory valuation method applied to this goods receipt for financial accounting. Determines how the received material cost is recorded in inventory and COGS.. Valid values are `standard|moving_average|fifo|lifo`',
    CONSTRAINT pk_goods_receipt PRIMARY KEY(`goods_receipt_id`)
) COMMENT 'Procurement-side goods receipt (GR) transaction capturing physical receipt of raw materials, ingredients, packaging, or services at a plant or DC against a purchase order. Records GR number, GR date, received quantity, unit of measure, batch/lot number, shelf life/best-before date, storage location, FEFO/FIFO assignment, quality inspection trigger status, and quantity variance vs. PO. This is the procurement-owned PO-closure confirmation event — it triggers three-way match with finance (invoice verification) and signals inventory domain to update stock positions. SSOT boundary: procurement owns the receipt-against-PO confirmation; inventory domain owns resulting stock position changes. Sourced from SAP S/4HANA MM (MIGO). Critical for lot traceability, FSMA compliance, and PO closure.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`procurement`.`purchase_contract` (
    `purchase_contract_id` BIGINT COMMENT 'Unique identifier for the purchase contract. Primary key.',
    `category_id` BIGINT COMMENT 'Foreign key linking to product.category. Business justification: F&B category management organizes procurement contracts by product category. Linking purchase_contract to product.category replaces denormalized material_category/spend_category text fields, enabling ',
    `storage_location_id` BIGINT COMMENT 'Foreign key linking to inventory.storage_location. Business justification: Blanket contracts specify default delivery locations for automated PO generation and logistics planning. Reduces manual data entry, ensures consistent routing, and supports vendor-managed inventory pr',
    `product_registration_id` BIGINT COMMENT 'Foreign key linking to regulatory.product_registration. Business justification: Contract management tracks which product registrations are covered by each purchase contract to ensure legal market eligibility.',
    `raw_material_id` BIGINT COMMENT 'Foreign key linking to ingredient.raw_material. Business justification: F&B supply contracts are frequently negotiated for specific raw materials (e.g., contract for Grade A cocoa butter from Supplier X). Direct purchase_contract → raw_material linkage enables contract co',
    `specification_id` BIGINT COMMENT 'Foreign key linking to quality.specification. Business justification: Purchase contracts in F&B contractually bind suppliers to quality specifications. The quality_specification_reference plain-text field is a denormalization of quality.specification. A proper FK enforc',
    `supplier_id` BIGINT COMMENT 'Reference to the supplier party with whom this contract is established.',
    `allergen_handling_requirements` STRING COMMENT 'Specific allergen control and handling requirements stipulated in the contract to ensure compliance with allergen labeling and cross-contamination prevention (e.g., dedicated lines, allergen-free facility).',
    `auto_renewal_flag` BOOLEAN COMMENT 'Indicates whether the contract automatically renews for an additional term unless either party provides termination notice.',
    `contract_document_url` STRING COMMENT 'URL or file path to the signed contract document stored in the document management system.',
    `contract_number` STRING COMMENT 'Externally-known unique business identifier for the purchase contract, used in procurement documents and supplier communications.',
    `contract_status` STRING COMMENT 'Current lifecycle state of the purchase contract. Active contracts are in force; suspended contracts are temporarily paused; expired contracts have passed their end date; terminated contracts were ended early.. Valid values are `draft|active|suspended|expired|terminated|renewed`',
    `contract_type` STRING COMMENT 'Classification of the procurement contract structure. Value contracts specify total value with flexible quantities; quantity contracts commit to specific volumes; scheduling agreements include delivery schedules; framework agreements establish terms for multiple purchase orders.. Valid values are `value_contract|quantity_contract|scheduling_agreement|framework_agreement|blanket_order|master_agreement`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this contract record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary values in this contract.. Valid values are `^[A-Z]{3}$`',
    `delivery_schedule_type` STRING COMMENT 'Type of delivery arrangement under this contract. Scheduled deliveries follow a fixed calendar; just-in-time aligns with production schedules; vendor-managed inventory allows supplier to manage stock levels.. Valid values are `on_demand|scheduled|just_in_time|consignment|vendor_managed_inventory`',
    `effective_end_date` DATE COMMENT 'Date when the contract expires or terminates. Nullable for open-ended agreements.',
    `effective_start_date` DATE COMMENT 'Date when the contract terms become binding and procurement can begin under this agreement.',
    `exclusivity_clause_flag` BOOLEAN COMMENT 'Indicates whether this contract includes exclusivity terms requiring the buyer to source specified materials exclusively from this supplier, or vice versa.',
    `food_safety_certification_required` STRING COMMENT 'Food safety certifications that the supplier must maintain to fulfill this contract (e.g., SQF Level 2, FSSC 22000, BRC, GFSI-recognized standard).',
    `force_majeure_clause` STRING COMMENT 'Text describing the force majeure provisions that excuse performance due to unforeseeable circumstances (natural disasters, pandemics, war, government actions).',
    `incoterms` STRING COMMENT 'International Commercial Terms defining the responsibilities, costs, and risks between buyer and seller for delivery. Examples: FOB (Free On Board), CIF (Cost Insurance Freight), DDP (Delivered Duty Paid). [ENUM-REF-CANDIDATE: EXW|FCA|CPT|CIP|DAP|DPU|DDP|FAS|FOB|CFR|CIF — 11 candidates stripped; promote to reference product]',
    `incoterms_location` STRING COMMENT 'Named place or port specified in the Incoterms clause where risk and cost transfer occurs (e.g., Port of Los Angeles, Chicago DC).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this contract record was last updated.',
    `lead_time_days` STRING COMMENT 'Standard number of days from purchase order placement to delivery under this contract. Critical for production planning and inventory management.',
    `minimum_order_quantity` DECIMAL(18,2) COMMENT 'Minimum quantity that must be ordered per purchase order or delivery under this contract. Critical for production planning and supplier efficiency.',
    `moq_unit_of_measure` STRING COMMENT 'Unit of measure for the minimum order quantity (e.g., KG, LB, EA, CS, MT, GAL).',
    `payment_terms` STRING COMMENT 'Standard payment terms code defining the payment schedule and conditions (e.g., Net 30, Net 60, 2/10 Net 30 for early payment discounts).',
    `price_adjustment_mechanism` STRING COMMENT 'Method by which contract prices may be adjusted over time. Index-linked ties to commodity indices; cost-plus adjusts based on supplier cost changes; fixed prices remain constant; periodic reviews allow renegotiation.. Valid values are `fixed|index_linked|cost_plus|market_based|annual_review|quarterly_review`',
    `price_index_reference` STRING COMMENT 'Name of the commodity or inflation index used for price escalation (e.g., USDA Dairy Index, CPI, PPI, CME Corn Futures). Applicable when price_adjustment_mechanism is index_linked.',
    `price_validity_end_date` DATE COMMENT 'Date until which the pricing conditions remain valid. After this date, prices may be renegotiated or adjusted per escalation clauses.',
    `price_validity_start_date` DATE COMMENT 'Date from which the pricing conditions in this contract become effective.',
    `purchasing_group` STRING COMMENT 'Code identifying the buyer or procurement team responsible for managing this contract and related purchase orders.',
    `purchasing_organization` STRING COMMENT 'Code or name of the purchasing organization or business unit responsible for this contract within the enterprise.',
    `rebate_agreement_flag` BOOLEAN COMMENT 'Indicates whether this contract includes volume-based rebate or discount tiers that provide retroactive price reductions when volume thresholds are met.',
    `rebate_percentage` DECIMAL(18,2) COMMENT 'Percentage rebate applied when volume commitments or spend thresholds are achieved. May be tiered based on volume levels.',
    `renewal_notice_days` STRING COMMENT 'Number of days prior to contract expiration that termination notice must be provided to prevent automatic renewal.',
    `termination_notice_days` STRING COMMENT 'Number of days advance notice required for early termination of the contract by either party.',
    `total_contract_value` DECIMAL(18,2) COMMENT 'Maximum monetary value committed under this contract across all line items and purchase orders. For value contracts, this is the spending limit; for quantity contracts, this is the estimated total value.',
    `volume_commitment_quantity` DECIMAL(18,2) COMMENT 'Total quantity committed to be purchased over the contract period. Used for volume-based pricing tiers and rebate calculations.',
    `volume_commitment_uom` STRING COMMENT 'Unit of measure for the volume commitment quantity.',
    CONSTRAINT pk_purchase_contract PRIMARY KEY(`purchase_contract_id`)
) COMMENT 'Long-term procurement contract or framework agreement with a supplier covering raw materials, ingredients, packaging, or services. Captures contract type (value contract, quantity contract, scheduling agreement), contract period, total contract value, pricing conditions (unit prices, price scales, volume tiers, index-linked escalation), volume commitments, MOQ terms, rebate tiers, exclusivity clauses, force majeure terms, and renewal/termination provisions. Includes pricing validity periods and price adjustment mechanisms. Sourced from SAP MM outline agreements and Oracle Cloud Procurement contracts.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`procurement`.`supplier_scorecard` (
    `supplier_scorecard_id` BIGINT COMMENT 'Unique system-generated identifier for the supplier performance scorecard record. Primary key. Entity role: TRANSACTION_HEADER — a periodic business event capturing quantitative KPI snapshots across quality, delivery, service, cost, and compliance dimensions for a supplier.',
    `plant_id` BIGINT COMMENT 'Foreign key linking to manufacturing.plant. Business justification: Plant-level supplier performance reporting: F&B companies evaluate supplier performance per receiving plant (e.g., OTIF, defect rates vary by plant). Plant-specific scorecards drive local sourcing dec',
    `purchase_contract_id` BIGINT COMMENT 'Reference to the active procurement contract or framework agreement under which this supplier is being evaluated. Used to align scorecard results with contract renewal and AVL decisions.',
    `supplier_id` BIGINT COMMENT 'Reference to the supplier (vendor) being evaluated in this scorecard. Links to the supplier master record in SAP MM / TraceGains.',
    `allergen_compliance_rate` DECIMAL(18,2) COMMENT 'Percentage of shipments where the suppliers allergen matrix declarations matched the received products actual allergen profile during the evaluation period. Critical food safety KPI under FDA FSMA and EU Food Information Regulation.',
    `approved_date` DATE COMMENT 'Date on which the scorecard was formally approved by the category manager or quality director. Marks the transition from in_review to approved status and triggers supplier communication.',
    `avl_status` STRING COMMENT 'Current status of the supplier on the Approved Vendor List (AVL) as determined by this scorecard evaluation. Approved: cleared for procurement; Conditional: approved with restrictions; Suspended: temporarily blocked pending corrective action; Removed: delisted.. Valid values are `approved|conditional|suspended|removed|pending_review`',
    `coa_compliance_rate` DECIMAL(18,2) COMMENT 'Percentage of inbound shipments accompanied by a valid, specification-compliant Certificate of Analysis (CoA) during the evaluation period. Mandatory for food-grade raw materials and ingredients under FDA FSMA and GFSI requirements.',
    `comments` STRING COMMENT 'Free-text narrative field capturing qualitative observations, context for score deviations, notable supplier improvements, or escalation notes from the evaluator. Supports supplier development conversations.',
    `compliance_score` DECIMAL(18,2) COMMENT 'Weighted performance score for the regulatory and food safety compliance dimension, incorporating audit results, certificate currency, FSMA/HACCP documentation completeness, and allergen matrix accuracy. Expressed as a percentage (0.00–100.00).',
    `corrective_action_due_date` DATE COMMENT 'Target date by which the supplier must submit or complete the corrective action plan (CAP) in response to scorecard findings. Null when corrective_action_required is False.',
    `corrective_action_required` BOOLEAN COMMENT 'Indicates whether a formal Corrective Action Plan (CAP) has been triggered as a result of this scorecard evaluation. True when overall score or any critical dimension falls below the defined threshold.',
    `cost_score` DECIMAL(18,2) COMMENT 'Weighted performance score for the cost dimension, incorporating invoice accuracy, pricing compliance against contract, and cost reduction contribution. Expressed as a percentage (0.00–100.00).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this scorecard record was first created in the system. Used for data lineage, audit trail, and Silver layer ingestion tracking.',
    `critical_nonconformance_count` STRING COMMENT 'Number of non-conformances classified as critical severity (e.g., food safety risk, allergen contamination, HACCP critical control point failure) during the evaluation period. Critical NCRs may trigger immediate supplier suspension.',
    `defect_rate_ppm` DECIMAL(18,2) COMMENT 'Number of defective or rejected units per one million units received from the supplier during the evaluation period. Industry-standard quality metric (PPM). Sourced from SAP QM goods receipt inspection results.',
    `delivery_score` DECIMAL(18,2) COMMENT 'Weighted performance score for the delivery dimension, incorporating On Time In Full (OTIF) rate and fill rate. Expressed as a percentage (0.00–100.00).',
    `evaluation_period_end_date` DATE COMMENT 'Last calendar date of the performance measurement window covered by this scorecard. Defines the inclusive end of the data aggregation period for all KPI calculations.',
    `evaluation_period_start_date` DATE COMMENT 'First calendar date of the performance measurement window covered by this scorecard. Defines the inclusive start of the data aggregation period for all KPI calculations.',
    `evaluation_period_type` STRING COMMENT 'Frequency classification of the scorecard evaluation cycle. Quarterly scorecards are standard for strategic suppliers; annual for approved vendor list (AVL) renewal; ad-hoc for corrective action follow-up.. Valid values are `quarterly|semi_annual|annual|ad_hoc`',
    `fill_rate` DECIMAL(18,2) COMMENT 'Percentage of ordered quantity actually delivered by the supplier during the evaluation period. Measures supply availability and capacity reliability. Calculated as (quantity delivered / quantity ordered) × 100.',
    `food_safety_audit_result` STRING COMMENT 'Outcome of the most recent food safety audit conducted against the supplier during or immediately preceding the evaluation period. Audits may be conducted under GFSI-benchmarked schemes (SQF, BRC, FSSC 22000) or internal GMP standards.. Valid values are `pass|conditional_pass|fail|not_audited`',
    `food_safety_certification_scheme` STRING COMMENT 'GFSI-benchmarked or regulatory food safety certification scheme under which the supplier is currently certified. Determines the rigor of the suppliers food safety management system and influences AVL approval status. [ENUM-REF-CANDIDATE: SQF|BRC|FSSC_22000|ISO_22000|HACCP|GMP|none — 7 candidates stripped; promote to reference product]',
    `invoice_accuracy_rate` DECIMAL(18,2) COMMENT 'Percentage of supplier invoices that matched the corresponding purchase order and goods receipt without discrepancy during the evaluation period. Sourced from SAP FI three-way match results.',
    `lead_time_performance_rate` DECIMAL(18,2) COMMENT 'Percentage of purchase orders where the supplier met the agreed lead time (from PO issuance to confirmed delivery) during the evaluation period. Complements OTIF by isolating the lead time adherence component.',
    `nonconformance_count` STRING COMMENT 'Total number of non-conformance reports (NCRs) raised against this supplier during the evaluation period. Includes quality deviations, specification failures, and food safety non-conformances logged in SAP QM or TraceGains.',
    `otif_rate` DECIMAL(18,2) COMMENT 'Percentage of purchase order lines delivered both on time and in full quantity during the evaluation period. Industry-standard KPI for supply chain reliability. Calculated as (OTIF deliveries / total deliveries) × 100.',
    `overall_score` DECIMAL(18,2) COMMENT 'Composite weighted performance score for the supplier across all evaluation dimensions (quality, delivery, service, cost, compliance) for the evaluation period. Expressed as a percentage (0.00–100.00). Drives supplier tiering and AVL renewal decisions.',
    `preferred_supplier_flag` BOOLEAN COMMENT 'Indicates whether the supplier has been designated as a preferred supplier based on this scorecard outcome. Preferred suppliers receive priority in sourcing decisions, contract renewals, and new product development (NPD) ingredient sourcing.',
    `price_variance_rate` DECIMAL(18,2) COMMENT 'Percentage deviation of actual invoiced prices from contracted purchase prices during the evaluation period. Positive values indicate supplier overcharging; negative values indicate favorable pricing. Sourced from SAP MM/FI purchase price variance analysis.',
    `quality_score` DECIMAL(18,2) COMMENT 'Weighted performance score for the quality dimension, incorporating defect/rejection rate (PPM), non-conformance count and severity, and certificate of analysis (CoA) compliance rate. Expressed as a percentage (0.00–100.00).',
    `responsiveness_score` DECIMAL(18,2) COMMENT 'Qualitative-to-quantitative score (0.00–100.00) measuring the suppliers speed and quality of response to inquiries, issue escalations, corrective action requests, and change notifications during the evaluation period.',
    `scorecard_date` DATE COMMENT 'The principal business event date on which the scorecard was formally issued or generated. Distinct from the evaluation period dates and from audit timestamps.',
    `scorecard_number` STRING COMMENT 'Externally-known business identifier for the scorecard document, formatted as SC-{YYYY}-{NNNNNN}. Used for cross-referencing in SAP MM supplier evaluation reports and TraceGains compliance documents.. Valid values are `^SC-[0-9]{4}-[0-9]{6}$`',
    `scorecard_status` STRING COMMENT 'Current workflow lifecycle state of the scorecard. Draft: data being compiled; In Review: under procurement/quality review; Approved: signed off by category manager; Published: shared with supplier; Archived: superseded by newer period.. Valid values are `draft|in_review|approved|published|archived`',
    `service_score` DECIMAL(18,2) COMMENT 'Weighted performance score for the service dimension, incorporating responsiveness score, issue resolution time, and communication quality. Expressed as a percentage (0.00–100.00).',
    `shelf_life_compliance_rate` DECIMAL(18,2) COMMENT 'Percentage of inbound shipments meeting the minimum remaining shelf life requirement at time of receipt, as defined in the supplier specification and procurement contract. Supports FEFO inventory management.',
    `spend_currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the total_spend_amount field (e.g., USD, EUR, GBP). Required for multi-currency spend analytics and FX exposure reporting.. Valid values are `^[A-Z]{3}$`',
    `supplier_acknowledged_flag` BOOLEAN COMMENT 'Indicates whether the supplier has formally acknowledged receipt and acceptance of the scorecard results. Required for closed-loop supplier performance management and dispute resolution.',
    `supplier_category` STRING COMMENT 'Classification of the supplier by the type of goods or services procured. Drives which KPI weights and thresholds apply in the scorecard model. Co-packer and toll manufacturer categories are specific to food and beverage outsourced production. [ENUM-REF-CANDIDATE: raw_material|ingredient|packaging|indirect|co_packer|toll_manufacturer|service — promote to reference product]',
    `sustainability_rating` STRING COMMENT 'Letter-grade rating of the suppliers environmental, social, and governance (ESG) performance, including carbon footprint, water usage, ethical sourcing, and packaging recyclability. Increasingly required for Scope 3 emissions reporting and retailer sustainability mandates.. Valid values are `A|B|C|D|F|not_rated`',
    `total_purchase_orders` STRING COMMENT 'Total number of purchase orders (POs) issued to this supplier during the evaluation period. Provides volume context for interpreting rate-based KPIs such as OTIF rate and invoice accuracy rate.',
    `total_spend_amount` DECIMAL(18,2) COMMENT 'Total procurement spend with this supplier during the evaluation period in the reporting currency. Used for spend analytics, strategic sourcing prioritization, and COGS impact assessment.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this scorecard record was most recently modified. Tracks revisions during the review and approval workflow.',
    CONSTRAINT pk_supplier_scorecard PRIMARY KEY(`supplier_scorecard_id`)
) COMMENT 'Periodic supplier performance scorecard capturing quantitative KPIs across quality, delivery, service, cost, and compliance dimensions. Metrics include OTIF (On Time In Full) rate, fill rate, defect/rejection rate (PPM), non-conformance count and severity, certificate of analysis (CoA) compliance rate, invoice accuracy, responsiveness score, and sustainability rating. Scorecards are generated quarterly or annually and drive supplier tiering, preferred supplier status, AVL renewal decisions, and strategic sourcing decisions. Managed in TraceGains and SAP MM supplier evaluation.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`procurement`.`supplier_audit` (
    `supplier_audit_id` BIGINT COMMENT 'Unique identifier for the supplier audit record. Primary key for the supplier audit entity.',
    `storage_location_id` BIGINT COMMENT 'Foreign key linking to inventory.storage_location. Business justification: Supplier audits occur at specific facilities (supplier warehouses, co-packer sites). Audit scope, findings, and CAPA are location-specific. Essential for GFSI compliance, AVL management, and risk-base',
    `compliance_document_id` BIGINT COMMENT 'Reference identifier for the complete audit report document stored in the document management system (TraceGains or Veeva Vault).',
    `supplier_id` BIGINT COMMENT 'Identifier of the supplier being audited. Links to the supplier master data entity.',
    `supplier_site_id` BIGINT COMMENT 'Foreign key linking to procurement.supplier_site. Business justification: Supplier audits are conducted at specific physical supplier sites (manufacturing plants, warehouses). supplier_audit already has supplier_id -> supplier but lacks a link to the specific site audited. ',
    `audit_closure_date` DATE COMMENT 'Date on which the audit and all associated Corrective Action and Preventive Action (CAPA) activities were formally closed, indicating all findings have been satisfactorily resolved.',
    `audit_date` DATE COMMENT 'The date on which the audit was conducted at the supplier facility. Primary business event timestamp for the audit.',
    `audit_end_timestamp` TIMESTAMP COMMENT 'Precise date and time when the audit was concluded.',
    `audit_frequency_months` STRING COMMENT 'Required frequency of audits for this supplier in months (e.g., 12 for annual, 24 for biennial), based on risk assessment and regulatory requirements.',
    `audit_grade` STRING COMMENT 'Letter grade or qualitative rating assigned to the audit outcome based on the score and findings (e.g., A, B, C, D, F or excellent, good, acceptable, needs improvement, unacceptable). [ENUM-REF-CANDIDATE: A|B|C|D|F|excellent|good|acceptable|needs_improvement|unacceptable — 10 candidates stripped; promote to reference product]',
    `audit_notes` STRING COMMENT 'Free-text field for additional notes, observations, or context related to the audit that do not fit into structured fields.',
    `audit_reference_number` STRING COMMENT 'External business identifier for the audit, used for tracking and communication with suppliers and auditors.. Valid values are `^[A-Z0-9-]{6,20}$`',
    `audit_scope` STRING COMMENT 'Detailed description of the audit scope, including specific processes, product categories, facility areas, and compliance standards evaluated during the audit.',
    `audit_score` DECIMAL(18,2) COMMENT 'Numerical score assigned to the audit based on the evaluation criteria, typically expressed as a percentage (0.00 to 100.00) or point total reflecting compliance level.',
    `audit_start_timestamp` TIMESTAMP COMMENT 'Precise date and time when the on-site or remote audit commenced.',
    `audit_status` STRING COMMENT 'Current lifecycle status of the audit. Tracks progression from scheduling through completion and closure.. Valid values are `scheduled|in_progress|completed|cancelled|pending_review|closed`',
    `audit_type` STRING COMMENT 'Classification of the audit based on its scope and focus area. GMP (Good Manufacturing Practice), HACCP (Hazard Analysis Critical Control Points), SQF (Safe Quality Food), GFSI (Global Food Safety Initiative), social compliance, environmental, food safety, quality systems, organic certification, or allergen control. [ENUM-REF-CANDIDATE: GMP|HACCP|SQF|GFSI|social_compliance|environmental|food_safety|quality_systems|organic_certification|allergen_control — 10 candidates stripped; promote to reference product]',
    `auditor_certification` STRING COMMENT 'Professional certification or accreditation held by the auditor (e.g., GFSI-recognized, ISO 22000 Lead Auditor, HACCP Certified).',
    `auditor_organization` STRING COMMENT 'Name of the third-party auditing organization or certification body that performed the audit (e.g., NSF, SGS, Bureau Veritas, Intertek).',
    `capa_approval_date` DATE COMMENT 'Date on which the submitted Corrective Action and Preventive Action (CAPA) plan was reviewed and approved by the quality assurance team.',
    `capa_due_date` DATE COMMENT 'Date by which the supplier must submit their Corrective Action and Preventive Action (CAPA) response for all audit findings.',
    `capa_required_flag` BOOLEAN COMMENT 'Boolean indicator of whether Corrective Action and Preventive Action (CAPA) is required based on audit findings. True if any findings require formal CAPA response.',
    `capa_submission_date` DATE COMMENT 'Actual date on which the supplier submitted their Corrective Action and Preventive Action (CAPA) response documentation.',
    `capa_verification_date` DATE COMMENT 'Date on which the effectiveness of the implemented Corrective Action and Preventive Action (CAPA) was verified.',
    `capa_verification_method` STRING COMMENT 'Method used to verify that the supplier has effectively implemented the Corrective Action and Preventive Action (CAPA) plan (e.g., document review, follow-up audit, remote verification, supplier self-assessment, photographic evidence, test results).. Valid values are `document_review|follow_up_audit|remote_verification|supplier_self_assessment|photographic_evidence|test_results`',
    `capa_verification_status` STRING COMMENT 'Current status of the Corrective Action and Preventive Action (CAPA) verification process (e.g., pending, verified effective, verified ineffective, requires additional action, closed).. Valid values are `pending|verified_effective|verified_ineffective|requires_additional_action|closed`',
    `certification_expiry_date` DATE COMMENT 'Date on which the current certification expires and recertification audit is required.',
    `certification_status` STRING COMMENT 'Current certification status of the supplier facility based on the audit outcome (e.g., certified, not certified, certification suspended, certification withdrawn, recertification required).. Valid values are `certified|not_certified|certification_suspended|certification_withdrawn|recertification_required`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this supplier audit record was first created in the system.',
    `critical_findings_count` STRING COMMENT 'Total number of critical non-conformances identified during the audit. Critical findings represent immediate food safety or quality risks requiring urgent corrective action.',
    `fsma_compliance_flag` BOOLEAN COMMENT 'Boolean indicator of whether this audit satisfies Food Safety Modernization Act (FSMA) supplier verification requirements for the associated supplier.',
    `gfsi_recognized_flag` BOOLEAN COMMENT 'Boolean indicator of whether this audit was conducted under a Global Food Safety Initiative (GFSI)-recognized certification scheme (e.g., SQF, BRC, FSSC 22000, IFS).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this supplier audit record was last updated or modified.',
    `major_findings_count` STRING COMMENT 'Total number of major non-conformances identified during the audit. Major findings represent significant deviations from standards that could lead to food safety or quality issues.',
    `minor_findings_count` STRING COMMENT 'Total number of minor non-conformances identified during the audit. Minor findings represent low-risk deviations that should be addressed but do not pose immediate threats.',
    `next_audit_scheduled_date` DATE COMMENT 'Planned date for the next scheduled audit of this supplier facility, based on audit frequency requirements and previous audit outcomes.',
    `observation_count` STRING COMMENT 'Total number of observations or opportunities for improvement noted during the audit that do not constitute non-conformances but represent best practice recommendations.',
    `pass_fail_status` STRING COMMENT 'Overall pass or fail determination for the audit. Conditional pass indicates minor findings that must be addressed within a specified timeframe.. Valid values are `pass|fail|conditional_pass|pending`',
    CONSTRAINT pk_supplier_audit PRIMARY KEY(`supplier_audit_id`)
) COMMENT 'Supplier audit and corrective action (CAPA) record capturing on-site or remote quality and food safety audits conducted at supplier facilities, plus all resulting Corrective Action and Preventive Action (CAPA) records linked to findings. Tracks audit type (GMP, HACCP, SQF, GFSI, social compliance, environmental), audit date, auditor, scope, findings by severity (critical, major, minor), audit score, pass/fail status, next scheduled audit. For each finding: CAPA reference number, root cause description, corrective action plan, supplier response due date, actual response date, verification method, verification status, closure date, and preventive action implemented. Managed in TraceGains and Veeva Vault. Required for FSMA supplier verification and GFSI compliance. This product is the SSOT for both audit execution and CAPA lifecycle management.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`procurement`.`compliance_document` (
    `compliance_document_id` BIGINT COMMENT 'Unique identifier for the supplier compliance document record. Primary key.',
    `equipment_master_id` BIGINT COMMENT 'Foreign key linking to manufacturing.equipment_master. Business justification: GMP/regulatory equipment certification tracking: F&B compliance documents include calibration certificates, equipment sanitation certifications, and pressure vessel certifications tied to specific equ',
    `plant_id` BIGINT COMMENT 'Identifier of the supplier manufacturing facility or site that this compliance document applies to. Null if document is not facility-specific.',
    `raw_material_id` BIGINT COMMENT 'Identifier of the raw material, ingredient, or packaging component that this compliance document applies to. Null if document applies to supplier facility or general capability.',
    `superseded_document_compliance_document_id` BIGINT COMMENT 'Identifier of the previous version of the compliance document that this document replaces. Null if this is the first version.',
    `supplier_id` BIGINT COMMENT 'Identifier of the supplier who provided this compliance document.',
    `supplier_site_id` BIGINT COMMENT 'Foreign key linking to procurement.supplier_site. Business justification: Compliance documents (certificates of analysis, food safety certifications, HACCP records, TraceGains documents) are issued for specific supplier sites, not just suppliers at the enterprise level. com',
    `approval_date` DATE COMMENT 'Date on which the compliance document was internally approved by the quality or procurement team.',
    `approval_status` STRING COMMENT 'Internal approval status indicating whether the compliance document has been reviewed and accepted by the quality assurance or procurement team.. Valid values are `pending_approval|approved|conditionally_approved|rejected|under_review`',
    `approved_by` STRING COMMENT 'Name or identifier of the internal quality assurance or procurement professional who approved the compliance document for use.',
    `audit_grade` STRING COMMENT 'Letter grade or pass/fail classification assigned to a supplier audit or inspection. Null for non-audit documents. [ENUM-REF-CANDIDATE: A|B|C|D|F|pass|fail|conditional_pass — 8 candidates stripped; promote to reference product]',
    `audit_score` DECIMAL(18,2) COMMENT 'Numerical score or rating assigned during a GFSI audit or third-party inspection, typically expressed as a percentage or point value. Null for non-audit documents.',
    `comments` STRING COMMENT 'Free-text field for additional notes, observations, or context related to the compliance document provided by reviewers or suppliers.',
    `confidentiality_level` STRING COMMENT 'Data classification level indicating the sensitivity and access restrictions for the compliance document.. Valid values are `public|internal|confidential|restricted`',
    `country_of_origin` STRING COMMENT 'Three-letter ISO country code indicating the country where the material or product covered by this compliance document was produced or sourced.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the compliance document record was first created in the TraceGains system.',
    `critical_non_conformance_count` STRING COMMENT 'Number of critical or major non-conformances identified during an audit that require immediate corrective action. Null for non-audit documents.',
    `document_category` STRING COMMENT 'High-level classification grouping the compliance document by its primary business function or regulatory domain. [ENUM-REF-CANDIDATE: regulatory|quality|safety|sustainability|ethical_sourcing|allergen|nutritional|specification — 8 candidates stripped; promote to reference product]',
    `document_number` STRING COMMENT 'Unique business identifier or control number assigned to the compliance document by the supplier or issuing authority.',
    `document_status` STRING COMMENT 'Current lifecycle status of the compliance document indicating its approval state and validity for use in procurement and manufacturing operations. [ENUM-REF-CANDIDATE: draft|pending_review|approved|rejected|expired|superseded|archived — 7 candidates stripped; promote to reference product]',
    `document_title` STRING COMMENT 'Descriptive title or name of the compliance document as provided by the supplier or issuing authority.',
    `document_type` STRING COMMENT 'Classification of the compliance document indicating its purpose and regulatory or quality function. Types include Certificate of Analysis (CoA), Certificate of Conformance (CoC), allergen declarations, GMO (Genetically Modified Organism) status declarations, Kosher/Halal certificates, organic certificates, GFSI (Global Food Safety Initiative) audit certificates, FDA (Food and Drug Administration) registration, USDA (United States Department of Agriculture) inspection records, SDS (Safety Data Sheet) sheets, nutritional specifications, ingredient specifications, packaging specifications, third-party audit reports, and supplier questionnaires. [ENUM-REF-CANDIDATE: certificate_of_analysis|certificate_of_conformance|allergen_declaration|gmo_status_declaration|kosher_certificate|halal_certificate|organic_certificate|gfsi_audit_certificate|fda_registration|usda_inspection_record|sds_sheet|nutritional_specification|ingredient_specification|packaging_specification|third_party_audit_report|supplier_questionnaire — 16 candidates stripped; promote to reference product]',
    `effective_date` DATE COMMENT 'Date from which the compliance document becomes valid and enforceable for procurement and quality assurance purposes.',
    `expiry_date` DATE COMMENT 'Date on which the compliance document expires and is no longer valid for use. Null for documents without expiration.',
    `file_format` STRING COMMENT 'File format or extension of the compliance document (e.g., PDF, DOCX, XLSX, JPG). [ENUM-REF-CANDIDATE: pdf|docx|xlsx|jpg|png|xml|csv — 7 candidates stripped; promote to reference product]',
    `file_name` STRING COMMENT 'Name of the digital file containing the compliance document as stored in the document management system.',
    `file_path` STRING COMMENT 'Storage location or URI path where the compliance document file is stored in the document management system or cloud storage.',
    `file_size_kb` STRING COMMENT 'Size of the compliance document file in kilobytes.',
    `issue_date` DATE COMMENT 'Date on which the compliance document was issued or published by the supplier or certifying authority.',
    `issuing_authority` STRING COMMENT 'Name of the organization, certification body, or regulatory agency that issued or certified the compliance document (e.g., FDA, USDA, third-party auditor, supplier laboratory).',
    `issuing_authority_license_number` STRING COMMENT 'License, accreditation, or registration number of the issuing authority demonstrating their authorization to certify or audit.',
    `language_code` STRING COMMENT 'Two-letter ISO language code indicating the primary language in which the compliance document is written.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when the compliance document record was last updated or modified in the TraceGains system.',
    `lot_number` STRING COMMENT 'Specific production lot or batch number that this compliance document applies to. Used for lot-specific Certificates of Analysis. Null for general certificates.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next periodic review or renewal of the compliance document to ensure continued validity and compliance.',
    `non_conformance_count` STRING COMMENT 'Number of non-conformances, deficiencies, or findings identified during an audit or inspection. Null for non-audit documents.',
    `regulatory_framework` STRING COMMENT 'Name of the regulatory standard, certification scheme, or compliance framework that this document satisfies (e.g., FSMA, GFSI, ISO 22000, Organic NOP, Non-GMO Project).',
    `rejection_reason` STRING COMMENT 'Explanation or justification for why the compliance document was rejected during internal review. Null if document was not rejected.',
    `retention_period_years` STRING COMMENT 'Number of years the compliance document must be retained to meet regulatory, legal, or business requirements.',
    `version_number` STRING COMMENT 'Version identifier of the compliance document used to track revisions and updates over time. Follows supplier or internal versioning convention.',
    CONSTRAINT pk_compliance_document PRIMARY KEY(`compliance_document_id`)
) COMMENT 'Supplier compliance document record managing certificates, specifications, and regulatory documents required for approved supplier status. Document types include: Certificate of Analysis (CoA), Certificate of Conformance (CoC), allergen declarations, GMO status declarations, Kosher/Halal certificates, organic certificates, GFSI audit certificates, FDA registration, USDA inspection records, and SDS sheets. Tracks document version, issue date, expiry date, and approval status. Managed in TraceGains Document Management.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`procurement`.`purchase_requisition` (
    `purchase_requisition_id` BIGINT COMMENT 'Unique identifier for the purchase requisition record. Primary key.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Purchase requisitions must be charged to a cost center for budget validation, approval routing, and commitment tracking. Finance uses this for budget vs. actual reporting and spend control. Replaces d',
    `demand_plan_id` BIGINT COMMENT 'Foreign key linking to supply.demand_plan. Business justification: Demand‑driven purchase requisitions are generated from the demand plan; linking enables automated requisition creation per plan.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Purchase requisitions require GL account assignment for budget checking, commitment accounting, and downstream PO creation. Finance uses this for encumbrance tracking and budget consumption reporting.',
    `purchase_contract_id` BIGINT COMMENT 'Foreign key linking to procurement.purchase_contract. Business justification: purchase_requisition has a contract_number (STRING) field that is a denormalized reference to a purchase_contract. In F&B procurement, requisitions are often raised against existing framework contract',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to procurement.purchase_order. Business justification: A purchase requisition is converted into a purchase order — the conversion_date field confirms this lifecycle. Adding purchase_order_id as a proper FK to purchase_order normalizes the relationship and',
    `raw_material_id` BIGINT COMMENT 'Foreign key linking to ingredient.raw_material. Business justification: Purchase requisitions in F&B are raised for specific raw materials. material_number and material_description on purchase_requisition are denormalized from raw_material. Direct FK enables MRP-driven re',
    `supplier_id` BIGINT COMMENT 'Identifier of the preferred or suggested supplier for this purchase requisition, if specified by the requestor.',
    `approval_date` DATE COMMENT 'Date when the purchase requisition was approved by the designated approver.',
    `approval_workflow_code` STRING COMMENT 'Identifier of the approval workflow instance governing this purchase requisition, tracking routing and approval steps.. Valid values are `^[A-Z0-9]{8,16}$`',
    `conversion_date` DATE COMMENT 'Date when the purchase requisition was converted to a purchase order.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the purchase requisition record was first created in the source system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the estimated value (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `delivery_address` STRING COMMENT 'Full delivery address where the materials or services should be delivered, if different from the plant default address.',
    `estimated_total_value` DECIMAL(18,2) COMMENT 'Total estimated value of the purchase requisition, calculated as quantity requested multiplied by estimated unit price.',
    `estimated_unit_price` DECIMAL(18,2) COMMENT 'Estimated price per unit of measure for the requested material or service, used for budgeting and approval workflows.',
    `is_deleted` BOOLEAN COMMENT 'Boolean flag indicating whether the purchase requisition has been logically deleted or marked for archival.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the purchase requisition record was last updated or modified.',
    `material_group_code` STRING COMMENT 'Classification code grouping similar materials for procurement, planning, and reporting purposes (e.g., raw materials, packaging, indirect materials).. Valid values are `^[A-Z0-9]{4,8}$`',
    `plant_code` STRING COMMENT 'Four-character code identifying the manufacturing plant, distribution center, or facility where the materials or services are required.. Valid values are `^[A-Z0-9]{4}$`',
    `priority_level` STRING COMMENT 'Priority classification of the purchase requisition indicating urgency of procurement need.. Valid values are `low|medium|high|urgent`',
    `procurement_category` STRING COMMENT 'High-level category classifying the type of procurement: raw materials, ingredients, packaging, indirect materials, services, or capital equipment.. Valid values are `raw_material|ingredient|packaging|indirect_material|service|capital_equipment`',
    `quantity_requested` DECIMAL(18,2) COMMENT 'Quantity of the material or service requested in the purchase requisition, expressed in the base unit of measure.',
    `rejection_reason` STRING COMMENT 'Free-text explanation provided by the approver if the purchase requisition was rejected.',
    `requestor_email` STRING COMMENT 'Email address of the requestor for communication and notifications regarding the purchase requisition.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `requestor_name` STRING COMMENT 'Full name of the employee who requested the procurement.',
    `required_delivery_date` DATE COMMENT 'Date by which the requested materials or services must be delivered to meet operational or production requirements.',
    `requisition_date` DATE COMMENT 'Date when the purchase requisition was created or submitted by the requestor.',
    `requisition_number` STRING COMMENT 'Business identifier for the purchase requisition, externally visible and used in procurement workflows. Typically 10-character alphanumeric code from SAP MM.. Valid values are `^[A-Z0-9]{10}$`',
    `requisition_status` STRING COMMENT 'Current lifecycle status of the purchase requisition in the approval and conversion workflow. [ENUM-REF-CANDIDATE: draft|submitted|approved|rejected|partially_converted|fully_converted|cancelled|on_hold — 8 candidates stripped; promote to reference product]',
    `requisition_type` STRING COMMENT 'Classification of the purchase requisition based on procurement scenario: standard purchase, subcontracting, consignment, stock transfer between plants, service procurement, or third-party direct delivery.. Valid values are `standard|subcontracting|consignment|stock_transfer|service|third_party`',
    `source_system` STRING COMMENT 'System of record from which the purchase requisition originated (SAP S/4HANA MM, Oracle Cloud Procurement, or manual entry).. Valid values are `sap_s4hana|oracle_cloud|manual_entry`',
    `special_instructions` STRING COMMENT 'Additional instructions or notes provided by the requestor regarding handling, delivery, quality requirements, or other special considerations.',
    `storage_location_code` STRING COMMENT 'Code identifying the storage location or warehouse within the plant where the material will be received and stored.. Valid values are `^[A-Z0-9]{4}$`',
    `unit_of_measure` STRING COMMENT 'Unit of measure for the requested quantity (e.g., KG for kilograms, LB for pounds, EA for each, L for liters).. Valid values are `^[A-Z]{2,3}$`',
    CONSTRAINT pk_purchase_requisition PRIMARY KEY(`purchase_requisition_id`)
) COMMENT 'Internal purchase requisition (PR) record representing a formal internal request to procure raw materials, ingredients, packaging, indirect materials, or services. Captures requisition number, requestor, plant/cost center, material/service description, required quantity, required delivery date, estimated value, approval workflow status, and conversion status to purchase order. Sourced from SAP S/4HANA MM (ME51N) and Oracle Cloud Procurement self-service.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_site` ADD CONSTRAINT `fk_procurement_supplier_site_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `food_beverage_ecm`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `food_beverage_ecm`.`procurement`.`approved_vendor_list` ADD CONSTRAINT `fk_procurement_approved_vendor_list_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `food_beverage_ecm`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_purchase_contract_id` FOREIGN KEY (`purchase_contract_id`) REFERENCES `food_beverage_ecm`.`procurement`.`purchase_contract`(`purchase_contract_id`);
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `food_beverage_ecm`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `food_beverage_ecm`.`procurement`.`po_line` ADD CONSTRAINT `fk_procurement_po_line_purchase_contract_id` FOREIGN KEY (`purchase_contract_id`) REFERENCES `food_beverage_ecm`.`procurement`.`purchase_contract`(`purchase_contract_id`);
ALTER TABLE `food_beverage_ecm`.`procurement`.`po_line` ADD CONSTRAINT `fk_procurement_po_line_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `food_beverage_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `food_beverage_ecm`.`procurement`.`po_line` ADD CONSTRAINT `fk_procurement_po_line_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `food_beverage_ecm`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `food_beverage_ecm`.`procurement`.`goods_receipt` ADD CONSTRAINT `fk_procurement_goods_receipt_po_line_id` FOREIGN KEY (`po_line_id`) REFERENCES `food_beverage_ecm`.`procurement`.`po_line`(`po_line_id`);
ALTER TABLE `food_beverage_ecm`.`procurement`.`goods_receipt` ADD CONSTRAINT `fk_procurement_goods_receipt_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `food_beverage_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `food_beverage_ecm`.`procurement`.`goods_receipt` ADD CONSTRAINT `fk_procurement_goods_receipt_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `food_beverage_ecm`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_contract` ADD CONSTRAINT `fk_procurement_purchase_contract_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `food_beverage_ecm`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_scorecard` ADD CONSTRAINT `fk_procurement_supplier_scorecard_purchase_contract_id` FOREIGN KEY (`purchase_contract_id`) REFERENCES `food_beverage_ecm`.`procurement`.`purchase_contract`(`purchase_contract_id`);
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_scorecard` ADD CONSTRAINT `fk_procurement_supplier_scorecard_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `food_beverage_ecm`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_audit` ADD CONSTRAINT `fk_procurement_supplier_audit_compliance_document_id` FOREIGN KEY (`compliance_document_id`) REFERENCES `food_beverage_ecm`.`procurement`.`compliance_document`(`compliance_document_id`);
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_audit` ADD CONSTRAINT `fk_procurement_supplier_audit_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `food_beverage_ecm`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_audit` ADD CONSTRAINT `fk_procurement_supplier_audit_supplier_site_id` FOREIGN KEY (`supplier_site_id`) REFERENCES `food_beverage_ecm`.`procurement`.`supplier_site`(`supplier_site_id`);
ALTER TABLE `food_beverage_ecm`.`procurement`.`compliance_document` ADD CONSTRAINT `fk_procurement_compliance_document_superseded_document_compliance_document_id` FOREIGN KEY (`superseded_document_compliance_document_id`) REFERENCES `food_beverage_ecm`.`procurement`.`compliance_document`(`compliance_document_id`);
ALTER TABLE `food_beverage_ecm`.`procurement`.`compliance_document` ADD CONSTRAINT `fk_procurement_compliance_document_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `food_beverage_ecm`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `food_beverage_ecm`.`procurement`.`compliance_document` ADD CONSTRAINT `fk_procurement_compliance_document_supplier_site_id` FOREIGN KEY (`supplier_site_id`) REFERENCES `food_beverage_ecm`.`procurement`.`supplier_site`(`supplier_site_id`);
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_requisition` ADD CONSTRAINT `fk_procurement_purchase_requisition_purchase_contract_id` FOREIGN KEY (`purchase_contract_id`) REFERENCES `food_beverage_ecm`.`procurement`.`purchase_contract`(`purchase_contract_id`);
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_requisition` ADD CONSTRAINT `fk_procurement_purchase_requisition_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `food_beverage_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_requisition` ADD CONSTRAINT `fk_procurement_purchase_requisition_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `food_beverage_ecm`.`procurement`.`supplier`(`supplier_id`);

-- ========= TAGS =========
ALTER SCHEMA `food_beverage_ecm`.`procurement` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `food_beverage_ecm`.`procurement` SET TAGS ('dbx_domain' = 'procurement');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier` SET TAGS ('dbx_subdomain' = 'vendor_management');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier` ALTER COLUMN `establishment_registration_id` SET TAGS ('dbx_business_glossary_term' = 'Establishment Registration Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier` ALTER COLUMN `account_group_code` SET TAGS ('dbx_business_glossary_term' = 'Vendor Account Group Code');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier` ALTER COLUMN `allergen_control_program_flag` SET TAGS ('dbx_business_glossary_term' = 'Allergen Control Program Flag');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier` ALTER COLUMN `approved_vendor_list_flag` SET TAGS ('dbx_business_glossary_term' = 'Approved Vendor List (AVL) Flag');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier` ALTER COLUMN `audit_result` SET TAGS ('dbx_business_glossary_term' = 'Supplier Audit Result');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier` ALTER COLUMN `audit_result` SET TAGS ('dbx_value_regex' = 'pass|conditional_pass|fail|pending');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier` ALTER COLUMN `audit_score` SET TAGS ('dbx_business_glossary_term' = 'Supplier Audit Score');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'Supplier City');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Supplier Country Code');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier` ALTER COLUMN `deactivation_date` SET TAGS ('dbx_business_glossary_term' = 'Supplier Deactivation Date');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier` ALTER COLUMN `diversity_classification` SET TAGS ('dbx_business_glossary_term' = 'Supplier Diversity Classification');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier` ALTER COLUMN `diversity_classification` SET TAGS ('dbx_value_regex' = 'minority_owned|women_owned|veteran_owned|small_business|none|not_disclosed');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier` ALTER COLUMN `duns_number` SET TAGS ('dbx_business_glossary_term' = 'Data Universal Numbering System (DUNS) Number');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier` ALTER COLUMN `duns_number` SET TAGS ('dbx_value_regex' = '^[0-9]{9}$');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier` ALTER COLUMN `edi_capable_flag` SET TAGS ('dbx_business_glossary_term' = 'Electronic Data Interchange (EDI) Capable Flag');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier` ALTER COLUMN `food_safety_cert_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Food Safety Certification Expiry Date');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier` ALTER COLUMN `food_safety_certification` SET TAGS ('dbx_business_glossary_term' = 'Food Safety Certification');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier` ALTER COLUMN `gln` SET TAGS ('dbx_business_glossary_term' = 'Global Location Number (GLN)');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier` ALTER COLUMN `gln` SET TAGS ('dbx_value_regex' = '^[0-9]{13}$');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier` ALTER COLUMN `incoterms_code` SET TAGS ('dbx_business_glossary_term' = 'Incoterms Code');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier` ALTER COLUMN `last_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Last Supplier Audit Date');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Supplier Lead Time (Days)');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier` ALTER COLUMN `legal_name` SET TAGS ('dbx_business_glossary_term' = 'Supplier Legal Name');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier` ALTER COLUMN `legal_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier` ALTER COLUMN `moq` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity (MOQ)');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier` ALTER COLUMN `moq_unit` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity (MOQ) Unit of Measure');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier` ALTER COLUMN `onboarding_date` SET TAGS ('dbx_business_glossary_term' = 'Supplier Onboarding Date');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier` ALTER COLUMN `onboarding_status` SET TAGS ('dbx_business_glossary_term' = 'Supplier Onboarding Status');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier` ALTER COLUMN `onboarding_status` SET TAGS ('dbx_value_regex' = 'pending|under_review|approved|active|suspended|deactivated');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier` ALTER COLUMN `organic_certification_flag` SET TAGS ('dbx_business_glossary_term' = 'Organic Certification Flag');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier` ALTER COLUMN `payment_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Payment Currency Code');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier` ALTER COLUMN `payment_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier` ALTER COLUMN `payment_terms_code` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms Code');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier` ALTER COLUMN `portal_registration_flag` SET TAGS ('dbx_business_glossary_term' = 'Supplier Portal Registration Flag');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Supplier Postal Code');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Email Address');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Name');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Phone Number');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier` ALTER COLUMN `purchasing_org_code` SET TAGS ('dbx_business_glossary_term' = 'SAP Purchasing Organization Code');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier` ALTER COLUMN `region` SET TAGS ('dbx_business_glossary_term' = 'Supplier Geographic Region');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier` ALTER COLUMN `risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Supplier Risk Rating');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier` ALTER COLUMN `risk_rating` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier` ALTER COLUMN `single_source_flag` SET TAGS ('dbx_business_glossary_term' = 'Single Source Supplier Flag');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier` ALTER COLUMN `strategic_supplier_flag` SET TAGS ('dbx_business_glossary_term' = 'Strategic Supplier Flag');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier` ALTER COLUMN `supplier_tier` SET TAGS ('dbx_business_glossary_term' = 'Supplier Tier');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier` ALTER COLUMN `supplier_tier` SET TAGS ('dbx_value_regex' = 'tier_1|tier_2|tier_3');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier` ALTER COLUMN `supplier_type` SET TAGS ('dbx_business_glossary_term' = 'Supplier Type');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier` ALTER COLUMN `supplier_type` SET TAGS ('dbx_value_regex' = 'direct_material|indirect_material|co_packer|toll_manufacturer|3pl_logistics|service_provider');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier` ALTER COLUMN `sustainability_score` SET TAGS ('dbx_business_glossary_term' = 'Supplier Sustainability Score');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_business_glossary_term' = 'Supplier Tax Identification Number');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier` ALTER COLUMN `tracegains_supplier_code` SET TAGS ('dbx_business_glossary_term' = 'TraceGains Supplier ID');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier` ALTER COLUMN `trade_name` SET TAGS ('dbx_business_glossary_term' = 'Supplier Trade Name (DBA)');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier` ALTER COLUMN `vendor_code` SET TAGS ('dbx_business_glossary_term' = 'Vendor Code');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_site` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_site` SET TAGS ('dbx_subdomain' = 'vendor_management');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_site` ALTER COLUMN `supplier_site_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Site ID');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_site` ALTER COLUMN `establishment_registration_id` SET TAGS ('dbx_business_glossary_term' = 'Establishment Registration Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_site` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_site` ALTER COLUMN `address_line1` SET TAGS ('dbx_business_glossary_term' = 'Supplier Site Address Line 1');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_site` ALTER COLUMN `address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_site` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_site` ALTER COLUMN `address_line2` SET TAGS ('dbx_business_glossary_term' = 'Supplier Site Address Line 2');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_site` ALTER COLUMN `address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_site` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_site` ALTER COLUMN `annual_production_capacity` SET TAGS ('dbx_business_glossary_term' = 'Annual Production Capacity');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_site` ALTER COLUMN `approved_date` SET TAGS ('dbx_business_glossary_term' = 'Supplier Site Approved Date');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_site` ALTER COLUMN `approved_vendor_list_status` SET TAGS ('dbx_business_glossary_term' = 'Approved Vendor List (AVL) Status');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_site` ALTER COLUMN `approved_vendor_list_status` SET TAGS ('dbx_value_regex' = 'approved|conditional|probationary|suspended|not_approved');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_site` ALTER COLUMN `audit_result` SET TAGS ('dbx_business_glossary_term' = 'Supplier Audit Result');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_site` ALTER COLUMN `audit_result` SET TAGS ('dbx_value_regex' = 'pass|conditional_pass|fail|pending');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_site` ALTER COLUMN `capacity_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Capacity Unit of Measure');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_site` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'Supplier Site City');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_site` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_site` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_site` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Supplier Site Country Code');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_site` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_site` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_site` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Supplier Site Currency Code');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_site` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_site` ALTER COLUMN `fda_registration_number` SET TAGS ('dbx_business_glossary_term' = 'FDA Facility Registration Number');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_site` ALTER COLUMN `fda_registration_number` SET TAGS ('dbx_value_regex' = '^[0-9]{7,12}$');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_site` ALTER COLUMN `food_safety_cert_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Food Safety Certification Expiry Date');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_site` ALTER COLUMN `food_safety_certification` SET TAGS ('dbx_business_glossary_term' = 'Food Safety Certification');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_site` ALTER COLUMN `gfsi_scheme` SET TAGS ('dbx_business_glossary_term' = 'Global Food Safety Initiative (GFSI) Scheme');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_site` ALTER COLUMN `gfsi_scheme` SET TAGS ('dbx_value_regex' = 'SQF|FSSC_22000|BRC_GSFS|IFS_Food|GLOBALG.A.P.|PRIMUS_GFS|none');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_site` ALTER COLUMN `haccp_certified` SET TAGS ('dbx_business_glossary_term' = 'Hazard Analysis Critical Control Points (HACCP) Certified');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_site` ALTER COLUMN `halal_certified` SET TAGS ('dbx_business_glossary_term' = 'Halal Certified');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_site` ALTER COLUMN `incoterms_code` SET TAGS ('dbx_business_glossary_term' = 'Incoterms Code');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_site` ALTER COLUMN `kosher_certified` SET TAGS ('dbx_business_glossary_term' = 'Kosher Certified');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_site` ALTER COLUMN `last_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Last Supplier Audit Date');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_site` ALTER COLUMN `last_audit_score` SET TAGS ('dbx_business_glossary_term' = 'Last Supplier Audit Score');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_site` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_site` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Supplier Site Latitude');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_site` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_site` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_site` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Supplier Site Lead Time (Days)');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_site` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Supplier Site Longitude');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_site` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_site` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_site` ALTER COLUMN `moq` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity (MOQ)');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_site` ALTER COLUMN `moq_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity (MOQ) Unit of Measure');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_site` ALTER COLUMN `next_audit_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Supplier Audit Due Date');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_site` ALTER COLUMN `organic_certified` SET TAGS ('dbx_business_glossary_term' = 'Organic Certified');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_site` ALTER COLUMN `payment_terms_code` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms Code');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_site` ALTER COLUMN `payment_terms_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_site` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Supplier Site Postal Code');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_site` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_site` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_site` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Supplier Site Primary Contact Email');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_site` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_site` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_site` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_site` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Supplier Site Primary Contact Name');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_site` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_site` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_site` ALTER COLUMN `quality_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Supplier Site Quality Contact Name');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_site` ALTER COLUMN `quality_contact_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_site` ALTER COLUMN `quality_contact_name` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_site` ALTER COLUMN `risk_tier` SET TAGS ('dbx_business_glossary_term' = 'Supplier Site Risk Tier');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_site` ALTER COLUMN `risk_tier` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_site` ALTER COLUMN `site_code` SET TAGS ('dbx_business_glossary_term' = 'Supplier Site Code');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_site` ALTER COLUMN `site_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{2,20}$');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_site` ALTER COLUMN `site_email` SET TAGS ('dbx_business_glossary_term' = 'Supplier Site Email Address');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_site` ALTER COLUMN `site_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_site` ALTER COLUMN `site_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_site` ALTER COLUMN `site_email` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_site` ALTER COLUMN `site_name` SET TAGS ('dbx_business_glossary_term' = 'Supplier Site Name');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_site` ALTER COLUMN `site_phone` SET TAGS ('dbx_business_glossary_term' = 'Supplier Site Phone Number');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_site` ALTER COLUMN `site_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_site` ALTER COLUMN `site_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_site` ALTER COLUMN `site_status` SET TAGS ('dbx_business_glossary_term' = 'Supplier Site Status');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_site` ALTER COLUMN `site_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|pending_approval|deactivated');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_site` ALTER COLUMN `site_type` SET TAGS ('dbx_business_glossary_term' = 'Supplier Site Type');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_site` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'Supplier Site State or Province');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_site` ALTER COLUMN `state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_site` ALTER COLUMN `state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_site` ALTER COLUMN `usda_establishment_number` SET TAGS ('dbx_business_glossary_term' = 'USDA Establishment Number');
ALTER TABLE `food_beverage_ecm`.`procurement`.`approved_vendor_list` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `food_beverage_ecm`.`procurement`.`approved_vendor_list` SET TAGS ('dbx_subdomain' = 'vendor_management');
ALTER TABLE `food_beverage_ecm`.`procurement`.`approved_vendor_list` ALTER COLUMN `approved_vendor_list_id` SET TAGS ('dbx_business_glossary_term' = 'Approved Vendor List (AVL) ID');
ALTER TABLE `food_beverage_ecm`.`procurement`.`approved_vendor_list` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `food_beverage_ecm`.`procurement`.`approved_vendor_list` ALTER COLUMN `raw_material_id` SET TAGS ('dbx_business_glossary_term' = 'Material ID');
ALTER TABLE `food_beverage_ecm`.`procurement`.`approved_vendor_list` ALTER COLUMN `specification_id` SET TAGS ('dbx_business_glossary_term' = 'Specification Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`procurement`.`approved_vendor_list` ALTER COLUMN `supplier_quality_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Quality Assessment Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`procurement`.`approved_vendor_list` ALTER COLUMN `allergen_approved_flag` SET TAGS ('dbx_business_glossary_term' = 'Allergen Approved Flag');
ALTER TABLE `food_beverage_ecm`.`procurement`.`approved_vendor_list` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `food_beverage_ecm`.`procurement`.`approved_vendor_list` ALTER COLUMN `approval_notes` SET TAGS ('dbx_business_glossary_term' = 'Approval Notes');
ALTER TABLE `food_beverage_ecm`.`procurement`.`approved_vendor_list` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `food_beverage_ecm`.`procurement`.`approved_vendor_list` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'approved|conditionally_approved|suspended|revoked|pending_review|expired');
ALTER TABLE `food_beverage_ecm`.`procurement`.`approved_vendor_list` ALTER COLUMN `approval_tier` SET TAGS ('dbx_business_glossary_term' = 'Approval Tier');
ALTER TABLE `food_beverage_ecm`.`procurement`.`approved_vendor_list` ALTER COLUMN `approval_tier` SET TAGS ('dbx_value_regex' = 'primary|secondary|contingency');
ALTER TABLE `food_beverage_ecm`.`procurement`.`approved_vendor_list` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `food_beverage_ecm`.`procurement`.`approved_vendor_list` ALTER COLUMN `audit_type` SET TAGS ('dbx_business_glossary_term' = 'Audit Type');
ALTER TABLE `food_beverage_ecm`.`procurement`.`approved_vendor_list` ALTER COLUMN `audit_type` SET TAGS ('dbx_value_regex' = 'first_party|second_party|third_party|remote|desk_audit');
ALTER TABLE `food_beverage_ecm`.`procurement`.`approved_vendor_list` ALTER COLUMN `avl_record_number` SET TAGS ('dbx_business_glossary_term' = 'Approved Vendor List (AVL) Record Number');
ALTER TABLE `food_beverage_ecm`.`procurement`.`approved_vendor_list` ALTER COLUMN `avl_record_number` SET TAGS ('dbx_value_regex' = '^AVL-[0-9]{8}$');
ALTER TABLE `food_beverage_ecm`.`procurement`.`approved_vendor_list` ALTER COLUMN `certification_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Food Safety Certification Expiry Date');
ALTER TABLE `food_beverage_ecm`.`procurement`.`approved_vendor_list` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_business_glossary_term' = 'Country of Origin');
ALTER TABLE `food_beverage_ecm`.`procurement`.`approved_vendor_list` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `food_beverage_ecm`.`procurement`.`approved_vendor_list` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `food_beverage_ecm`.`procurement`.`approved_vendor_list` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Expiry Date');
ALTER TABLE `food_beverage_ecm`.`procurement`.`approved_vendor_list` ALTER COLUMN `food_safety_certification` SET TAGS ('dbx_business_glossary_term' = 'Food Safety Certification');
ALTER TABLE `food_beverage_ecm`.`procurement`.`approved_vendor_list` ALTER COLUMN `fsvp_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Foreign Supplier Verification Program (FSVP) Required Flag');
ALTER TABLE `food_beverage_ecm`.`procurement`.`approved_vendor_list` ALTER COLUMN `haccp_verified_flag` SET TAGS ('dbx_business_glossary_term' = 'Hazard Analysis Critical Control Points (HACCP) Verified Flag');
ALTER TABLE `food_beverage_ecm`.`procurement`.`approved_vendor_list` ALTER COLUMN `last_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Last Supplier Audit Date');
ALTER TABLE `food_beverage_ecm`.`procurement`.`approved_vendor_list` ALTER COLUMN `last_audit_score` SET TAGS ('dbx_business_glossary_term' = 'Last Supplier Audit Score');
ALTER TABLE `food_beverage_ecm`.`procurement`.`approved_vendor_list` ALTER COLUMN `last_requalification_date` SET TAGS ('dbx_business_glossary_term' = 'Last Requalification Date');
ALTER TABLE `food_beverage_ecm`.`procurement`.`approved_vendor_list` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `food_beverage_ecm`.`procurement`.`approved_vendor_list` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Supplier Lead Time (Days)');
ALTER TABLE `food_beverage_ecm`.`procurement`.`approved_vendor_list` ALTER COLUMN `moq` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity (MOQ)');
ALTER TABLE `food_beverage_ecm`.`procurement`.`approved_vendor_list` ALTER COLUMN `moq_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity (MOQ) Unit of Measure');
ALTER TABLE `food_beverage_ecm`.`procurement`.`approved_vendor_list` ALTER COLUMN `next_requalification_date` SET TAGS ('dbx_business_glossary_term' = 'Next Requalification Date');
ALTER TABLE `food_beverage_ecm`.`procurement`.`approved_vendor_list` ALTER COLUMN `non_gmo_verified_flag` SET TAGS ('dbx_business_glossary_term' = 'Non-GMO Verified Flag');
ALTER TABLE `food_beverage_ecm`.`procurement`.`approved_vendor_list` ALTER COLUMN `organic_certified_flag` SET TAGS ('dbx_business_glossary_term' = 'Organic Certified Flag');
ALTER TABLE `food_beverage_ecm`.`procurement`.`approved_vendor_list` ALTER COLUMN `plant_code` SET TAGS ('dbx_business_glossary_term' = 'Plant Code');
ALTER TABLE `food_beverage_ecm`.`procurement`.`approved_vendor_list` ALTER COLUMN `preferred_supplier_flag` SET TAGS ('dbx_business_glossary_term' = 'Preferred Supplier Flag');
ALTER TABLE `food_beverage_ecm`.`procurement`.`approved_vendor_list` ALTER COLUMN `purchasing_org_code` SET TAGS ('dbx_business_glossary_term' = 'Purchasing Organization Code');
ALTER TABLE `food_beverage_ecm`.`procurement`.`approved_vendor_list` ALTER COLUMN `qualification_basis` SET TAGS ('dbx_business_glossary_term' = 'Qualification Basis');
ALTER TABLE `food_beverage_ecm`.`procurement`.`approved_vendor_list` ALTER COLUMN `qualification_basis` SET TAGS ('dbx_value_regex' = 'audit|certificate|questionnaire|third_party_cert|historical_performance|regulatory_approval');
ALTER TABLE `food_beverage_ecm`.`procurement`.`approved_vendor_list` ALTER COLUMN `sap_info_record_number` SET TAGS ('dbx_business_glossary_term' = 'SAP Purchasing Info Record Number');
ALTER TABLE `food_beverage_ecm`.`procurement`.`approved_vendor_list` ALTER COLUMN `sole_source_flag` SET TAGS ('dbx_business_glossary_term' = 'Sole Source Flag');
ALTER TABLE `food_beverage_ecm`.`procurement`.`approved_vendor_list` ALTER COLUMN `source_list_indicator` SET TAGS ('dbx_business_glossary_term' = 'SAP Source List Indicator');
ALTER TABLE `food_beverage_ecm`.`procurement`.`approved_vendor_list` ALTER COLUMN `supplier_risk_tier` SET TAGS ('dbx_business_glossary_term' = 'Supplier Risk Tier');
ALTER TABLE `food_beverage_ecm`.`procurement`.`approved_vendor_list` ALTER COLUMN `supplier_risk_tier` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `food_beverage_ecm`.`procurement`.`approved_vendor_list` ALTER COLUMN `suspension_reason` SET TAGS ('dbx_business_glossary_term' = 'Suspension Reason');
ALTER TABLE `food_beverage_ecm`.`procurement`.`approved_vendor_list` ALTER COLUMN `tracegains_document_code` SET TAGS ('dbx_business_glossary_term' = 'TraceGains Document ID');
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_order` SET TAGS ('dbx_subdomain' = 'order_processing');
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_order` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) ID');
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_order` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_order` ALTER COLUMN `center_id` SET TAGS ('dbx_business_glossary_term' = 'Center Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_order` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_order` ALTER COLUMN `storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Storage Location Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_order` ALTER COLUMN `fsma_record_id` SET TAGS ('dbx_business_glossary_term' = 'Fsma Record Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_order` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_order` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant / Distribution Center (DC) ID');
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_order` ALTER COLUMN `purchase_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Procurement Contract ID');
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_order` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_order` ALTER COLUMN `actual_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Delivery Date');
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_order` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Approval Date');
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_order` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Workflow Status');
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_order` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|escalated');
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_order` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By (User ID)');
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_order` ALTER COLUMN `blanket_po_value_limit` SET TAGS ('dbx_business_glossary_term' = 'Blanket Purchase Order (PO) Value Limit');
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_order` ALTER COLUMN `blanket_po_value_limit` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_order` ALTER COLUMN `company_code` SET TAGS ('dbx_business_glossary_term' = 'Company Code');
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_order` ALTER COLUMN `company_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,6}$');
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_order` ALTER COLUMN `confirmed_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Supplier Confirmed Delivery Date');
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_order` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Currency Code');
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_order` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate');
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_order` ALTER COLUMN `food_safety_hold_indicator` SET TAGS ('dbx_business_glossary_term' = 'Food Safety Hold Indicator');
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_order` ALTER COLUMN `goods_receipt_indicator` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt (GR) Indicator');
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_order` ALTER COLUMN `hazmat_indicator` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Material (Hazmat) Indicator');
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_order` ALTER COLUMN `incoterms_code` SET TAGS ('dbx_business_glossary_term' = 'Incoterms Code');
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_order` ALTER COLUMN `incoterms_location` SET TAGS ('dbx_business_glossary_term' = 'Incoterms Named Place / Location');
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_order` ALTER COLUMN `invoice_verification_indicator` SET TAGS ('dbx_business_glossary_term' = 'Invoice Verification Indicator');
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_order` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_order` ALTER COLUMN `material_group_code` SET TAGS ('dbx_business_glossary_term' = 'Material Group Code');
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_order` ALTER COLUMN `material_group_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,10}$');
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_order` ALTER COLUMN `moq` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity (MOQ)');
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_order` ALTER COLUMN `net_amount` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Net Amount');
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_order` ALTER COLUMN `net_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_order` ALTER COLUMN `order_date` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Order Date');
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_order` ALTER COLUMN `payment_terms_code` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms Code');
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_order` ALTER COLUMN `payment_terms_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,10}$');
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_order` ALTER COLUMN `po_gross_amount` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Gross Amount');
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_order` ALTER COLUMN `po_gross_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_order` ALTER COLUMN `po_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Number');
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_order` ALTER COLUMN `po_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{1,20}$');
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_order` ALTER COLUMN `po_status` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Status');
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_order` ALTER COLUMN `po_type` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Type');
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_order` ALTER COLUMN `po_type` SET TAGS ('dbx_value_regex' = 'standard|blanket_release|subcontracting|service|consignment');
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_order` ALTER COLUMN `purchasing_group_code` SET TAGS ('dbx_business_glossary_term' = 'Purchasing Group Code');
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_order` ALTER COLUMN `purchasing_group_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,6}$');
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_order` ALTER COLUMN `purchasing_org_code` SET TAGS ('dbx_business_glossary_term' = 'Purchasing Organization Code');
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_order` ALTER COLUMN `purchasing_org_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,10}$');
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_order` ALTER COLUMN `requested_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Requested Delivery Date');
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_order` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_order` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'SAP_S4HANA|ORACLE_CLOUD|MANUAL');
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_order` ALTER COLUMN `source_system_po_key` SET TAGS ('dbx_business_glossary_term' = 'Source System Purchase Order (PO) Key');
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_order` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Tax Amount');
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_order` ALTER COLUMN `tax_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_order` ALTER COLUMN `total_quantity_ordered` SET TAGS ('dbx_business_glossary_term' = 'Total Quantity Ordered');
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_order` ALTER COLUMN `total_quantity_received` SET TAGS ('dbx_business_glossary_term' = 'Total Quantity Received');
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_order` ALTER COLUMN `tracegains_compliance_status` SET TAGS ('dbx_business_glossary_term' = 'TraceGains Supplier Compliance Status');
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_order` ALTER COLUMN `tracegains_compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending_review|not_required');
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_order` ALTER COLUMN `uom_code` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM) Code');
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_order` ALTER COLUMN `uom_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{1,6}$');
ALTER TABLE `food_beverage_ecm`.`procurement`.`po_line` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `food_beverage_ecm`.`procurement`.`po_line` SET TAGS ('dbx_subdomain' = 'order_processing');
ALTER TABLE `food_beverage_ecm`.`procurement`.`po_line` ALTER COLUMN `po_line_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Line ID');
ALTER TABLE `food_beverage_ecm`.`procurement`.`po_line` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`procurement`.`po_line` ALTER COLUMN `storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Storage Location Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`procurement`.`po_line` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`procurement`.`po_line` ALTER COLUMN `purchase_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Procurement Contract ID');
ALTER TABLE `food_beverage_ecm`.`procurement`.`po_line` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) ID');
ALTER TABLE `food_beverage_ecm`.`procurement`.`po_line` ALTER COLUMN `raw_material_id` SET TAGS ('dbx_business_glossary_term' = 'Material ID');
ALTER TABLE `food_beverage_ecm`.`procurement`.`po_line` ALTER COLUMN `specification_id` SET TAGS ('dbx_business_glossary_term' = 'TraceGains Specification ID');
ALTER TABLE `food_beverage_ecm`.`procurement`.`po_line` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `food_beverage_ecm`.`procurement`.`po_line` ALTER COLUMN `account_assignment_category` SET TAGS ('dbx_business_glossary_term' = 'Account Assignment Category');
ALTER TABLE `food_beverage_ecm`.`procurement`.`po_line` ALTER COLUMN `account_assignment_category` SET TAGS ('dbx_value_regex' = 'cost_center|order|project|asset|sales_order|not_assigned');
ALTER TABLE `food_beverage_ecm`.`procurement`.`po_line` ALTER COLUMN `allergen_flag` SET TAGS ('dbx_business_glossary_term' = 'Allergen Flag');
ALTER TABLE `food_beverage_ecm`.`procurement`.`po_line` ALTER COLUMN `batch_required` SET TAGS ('dbx_business_glossary_term' = 'Batch Management Required Flag');
ALTER TABLE `food_beverage_ecm`.`procurement`.`po_line` ALTER COLUMN `confirmed_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Confirmed Delivery Date');
ALTER TABLE `food_beverage_ecm`.`procurement`.`po_line` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_business_glossary_term' = 'Country of Origin');
ALTER TABLE `food_beverage_ecm`.`procurement`.`po_line` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `food_beverage_ecm`.`procurement`.`po_line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `food_beverage_ecm`.`procurement`.`po_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `food_beverage_ecm`.`procurement`.`po_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `food_beverage_ecm`.`procurement`.`po_line` ALTER COLUMN `deletion_indicator` SET TAGS ('dbx_business_glossary_term' = 'Deletion Indicator');
ALTER TABLE `food_beverage_ecm`.`procurement`.`po_line` ALTER COLUMN `delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Requested Delivery Date');
ALTER TABLE `food_beverage_ecm`.`procurement`.`po_line` ALTER COLUMN `goods_receipt_indicator` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt (GR) Indicator');
ALTER TABLE `food_beverage_ecm`.`procurement`.`po_line` ALTER COLUMN `goods_receipt_quantity` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt (GR) Quantity');
ALTER TABLE `food_beverage_ecm`.`procurement`.`po_line` ALTER COLUMN `incoterms_code` SET TAGS ('dbx_business_glossary_term' = 'Incoterms Code');
ALTER TABLE `food_beverage_ecm`.`procurement`.`po_line` ALTER COLUMN `invoice_receipt_indicator` SET TAGS ('dbx_business_glossary_term' = 'Invoice Receipt (IR) Indicator');
ALTER TABLE `food_beverage_ecm`.`procurement`.`po_line` ALTER COLUMN `invoiced_quantity` SET TAGS ('dbx_business_glossary_term' = 'Invoiced Quantity');
ALTER TABLE `food_beverage_ecm`.`procurement`.`po_line` ALTER COLUMN `item_category` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Item Category');
ALTER TABLE `food_beverage_ecm`.`procurement`.`po_line` ALTER COLUMN `item_category` SET TAGS ('dbx_value_regex' = 'standard|consignment|subcontracting|third_party|service|limit');
ALTER TABLE `food_beverage_ecm`.`procurement`.`po_line` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `food_beverage_ecm`.`procurement`.`po_line` ALTER COLUMN `line_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Line Number');
ALTER TABLE `food_beverage_ecm`.`procurement`.`po_line` ALTER COLUMN `line_status` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Line Status');
ALTER TABLE `food_beverage_ecm`.`procurement`.`po_line` ALTER COLUMN `line_status` SET TAGS ('dbx_value_regex' = 'open|partially_delivered|fully_delivered|invoiced|closed|cancelled');
ALTER TABLE `food_beverage_ecm`.`procurement`.`po_line` ALTER COLUMN `material_code` SET TAGS ('dbx_business_glossary_term' = 'Material Code');
ALTER TABLE `food_beverage_ecm`.`procurement`.`po_line` ALTER COLUMN `material_description` SET TAGS ('dbx_business_glossary_term' = 'Material Description');
ALTER TABLE `food_beverage_ecm`.`procurement`.`po_line` ALTER COLUMN `material_group_code` SET TAGS ('dbx_business_glossary_term' = 'Material Group Code');
ALTER TABLE `food_beverage_ecm`.`procurement`.`po_line` ALTER COLUMN `moq` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity (MOQ)');
ALTER TABLE `food_beverage_ecm`.`procurement`.`po_line` ALTER COLUMN `net_value` SET TAGS ('dbx_business_glossary_term' = 'Net Value');
ALTER TABLE `food_beverage_ecm`.`procurement`.`po_line` ALTER COLUMN `net_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`procurement`.`po_line` ALTER COLUMN `order_unit` SET TAGS ('dbx_business_glossary_term' = 'Order Unit of Measure (UoM)');
ALTER TABLE `food_beverage_ecm`.`procurement`.`po_line` ALTER COLUMN `ordered_quantity` SET TAGS ('dbx_business_glossary_term' = 'Ordered Quantity');
ALTER TABLE `food_beverage_ecm`.`procurement`.`po_line` ALTER COLUMN `organic_certified` SET TAGS ('dbx_business_glossary_term' = 'Organic Certified Flag');
ALTER TABLE `food_beverage_ecm`.`procurement`.`po_line` ALTER COLUMN `overdelivery_tolerance_pct` SET TAGS ('dbx_business_glossary_term' = 'Over-Delivery Tolerance Percentage');
ALTER TABLE `food_beverage_ecm`.`procurement`.`po_line` ALTER COLUMN `plant_code` SET TAGS ('dbx_business_glossary_term' = 'Plant Code');
ALTER TABLE `food_beverage_ecm`.`procurement`.`po_line` ALTER COLUMN `price_unit` SET TAGS ('dbx_business_glossary_term' = 'Price Unit Quantity');
ALTER TABLE `food_beverage_ecm`.`procurement`.`po_line` ALTER COLUMN `purchasing_group_code` SET TAGS ('dbx_business_glossary_term' = 'Purchasing Group Code');
ALTER TABLE `food_beverage_ecm`.`procurement`.`po_line` ALTER COLUMN `purchasing_org_code` SET TAGS ('dbx_business_glossary_term' = 'Purchasing Organization Code');
ALTER TABLE `food_beverage_ecm`.`procurement`.`po_line` ALTER COLUMN `quality_inspection_required` SET TAGS ('dbx_business_glossary_term' = 'Quality Inspection Required Flag');
ALTER TABLE `food_beverage_ecm`.`procurement`.`po_line` ALTER COLUMN `shelf_life_days` SET TAGS ('dbx_business_glossary_term' = 'Shelf Life (Days)');
ALTER TABLE `food_beverage_ecm`.`procurement`.`po_line` ALTER COLUMN `storage_location_code` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Code');
ALTER TABLE `food_beverage_ecm`.`procurement`.`po_line` ALTER COLUMN `underdelivery_tolerance_pct` SET TAGS ('dbx_business_glossary_term' = 'Under-Delivery Tolerance Percentage');
ALTER TABLE `food_beverage_ecm`.`procurement`.`po_line` ALTER COLUMN `unit_price` SET TAGS ('dbx_business_glossary_term' = 'Unit Price');
ALTER TABLE `food_beverage_ecm`.`procurement`.`po_line` ALTER COLUMN `unit_price` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`procurement`.`goods_receipt` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `food_beverage_ecm`.`procurement`.`goods_receipt` SET TAGS ('dbx_subdomain' = 'order_processing');
ALTER TABLE `food_beverage_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `goods_receipt_id` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt Identifier');
ALTER TABLE `food_beverage_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `center_id` SET TAGS ('dbx_business_glossary_term' = 'Center Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `packaging_spec_id` SET TAGS ('dbx_business_glossary_term' = 'Packaging Spec Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant ID');
ALTER TABLE `food_beverage_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `po_line_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Line ID');
ALTER TABLE `food_beverage_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `production_order_id` SET TAGS ('dbx_business_glossary_term' = 'Production Order Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) ID');
ALTER TABLE `food_beverage_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `raw_material_id` SET TAGS ('dbx_business_glossary_term' = 'Material ID');
ALTER TABLE `food_beverage_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'Storage Location ID');
ALTER TABLE `food_beverage_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `food_beverage_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `allergen_declaration_received_flag` SET TAGS ('dbx_business_glossary_term' = 'Allergen Declaration Received Flag');
ALTER TABLE `food_beverage_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Number');
ALTER TABLE `food_beverage_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `batch_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `food_beverage_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `best_before_date` SET TAGS ('dbx_business_glossary_term' = 'Best Before Date');
ALTER TABLE `food_beverage_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `certificate_of_analysis_received_flag` SET TAGS ('dbx_business_glossary_term' = 'Certificate of Analysis (COA) Received Flag');
ALTER TABLE `food_beverage_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `cold_chain_compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'Cold Chain Compliant Flag');
ALTER TABLE `food_beverage_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `food_beverage_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `food_beverage_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `delivery_note_number` SET TAGS ('dbx_business_glossary_term' = 'Delivery Note Number');
ALTER TABLE `food_beverage_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `delivery_note_number` SET TAGS ('dbx_value_regex' = '^DN[A-Z0-9]{8,15}$');
ALTER TABLE `food_beverage_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `food_beverage_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `goods_receipt_date` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt (GR) Date');
ALTER TABLE `food_beverage_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `goods_receipt_number` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt (GR) Number');
ALTER TABLE `food_beverage_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `goods_receipt_number` SET TAGS ('dbx_value_regex' = '^GR[0-9]{10}$');
ALTER TABLE `food_beverage_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `goods_receipt_status` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt (GR) Status');
ALTER TABLE `food_beverage_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `goods_receipt_status` SET TAGS ('dbx_value_regex' = 'posted|pending_inspection|quality_hold|approved|rejected|cancelled');
ALTER TABLE `food_beverage_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `goods_receipt_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt (GR) Timestamp');
ALTER TABLE `food_beverage_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `manufacturing_date` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Date');
ALTER TABLE `food_beverage_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `food_beverage_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `movement_type` SET TAGS ('dbx_business_glossary_term' = 'Movement Type');
ALTER TABLE `food_beverage_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `movement_type` SET TAGS ('dbx_value_regex' = '101|102|103|105|122|161');
ALTER TABLE `food_beverage_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `ordered_quantity` SET TAGS ('dbx_business_glossary_term' = 'Ordered Quantity');
ALTER TABLE `food_beverage_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `quality_inspection_lot_number` SET TAGS ('dbx_business_glossary_term' = 'Quality Inspection Lot Number');
ALTER TABLE `food_beverage_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `quality_inspection_lot_number` SET TAGS ('dbx_value_regex' = '^QI[0-9]{10}$');
ALTER TABLE `food_beverage_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `quality_inspection_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Quality Inspection Required Flag');
ALTER TABLE `food_beverage_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `quantity_variance` SET TAGS ('dbx_business_glossary_term' = 'Quantity Variance');
ALTER TABLE `food_beverage_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `received_quantity` SET TAGS ('dbx_business_glossary_term' = 'Received Quantity');
ALTER TABLE `food_beverage_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `receiving_notes` SET TAGS ('dbx_business_glossary_term' = 'Receiving Notes');
ALTER TABLE `food_beverage_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `shelf_life_days` SET TAGS ('dbx_business_glossary_term' = 'Shelf Life Days');
ALTER TABLE `food_beverage_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `food_beverage_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `tax_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Code');
ALTER TABLE `food_beverage_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `tax_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,4}$');
ALTER TABLE `food_beverage_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `temperature_at_receipt_c` SET TAGS ('dbx_business_glossary_term' = 'Temperature at Receipt (Celsius)');
ALTER TABLE `food_beverage_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `total_value` SET TAGS ('dbx_business_glossary_term' = 'Total Value');
ALTER TABLE `food_beverage_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `total_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `food_beverage_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `unit_price` SET TAGS ('dbx_business_glossary_term' = 'Unit Price');
ALTER TABLE `food_beverage_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `unit_price` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `unloading_point` SET TAGS ('dbx_business_glossary_term' = 'Unloading Point');
ALTER TABLE `food_beverage_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `valuation_type` SET TAGS ('dbx_business_glossary_term' = 'Valuation Type');
ALTER TABLE `food_beverage_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `valuation_type` SET TAGS ('dbx_value_regex' = 'standard|moving_average|fifo|lifo');
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_contract` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_contract` SET TAGS ('dbx_subdomain' = 'order_processing');
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_contract` ALTER COLUMN `purchase_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Contract ID');
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_contract` ALTER COLUMN `category_id` SET TAGS ('dbx_business_glossary_term' = 'Category Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_contract` ALTER COLUMN `storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'Default Delivery Storage Location Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_contract` ALTER COLUMN `product_registration_id` SET TAGS ('dbx_business_glossary_term' = 'Product Registration Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_contract` ALTER COLUMN `raw_material_id` SET TAGS ('dbx_business_glossary_term' = 'Raw Material Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_contract` ALTER COLUMN `specification_id` SET TAGS ('dbx_business_glossary_term' = 'Specification Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_contract` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_contract` ALTER COLUMN `allergen_handling_requirements` SET TAGS ('dbx_business_glossary_term' = 'Allergen Handling Requirements');
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_contract` ALTER COLUMN `auto_renewal_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto-Renewal Flag');
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_contract` ALTER COLUMN `contract_document_url` SET TAGS ('dbx_business_glossary_term' = 'Contract Document URL');
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_contract` ALTER COLUMN `contract_document_url` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_contract` ALTER COLUMN `contract_number` SET TAGS ('dbx_business_glossary_term' = 'Contract Number');
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_contract` ALTER COLUMN `contract_status` SET TAGS ('dbx_business_glossary_term' = 'Contract Status');
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_contract` ALTER COLUMN `contract_status` SET TAGS ('dbx_value_regex' = 'draft|active|suspended|expired|terminated|renewed');
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_contract` ALTER COLUMN `contract_type` SET TAGS ('dbx_business_glossary_term' = 'Contract Type');
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_contract` ALTER COLUMN `contract_type` SET TAGS ('dbx_value_regex' = 'value_contract|quantity_contract|scheduling_agreement|framework_agreement|blanket_order|master_agreement');
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_contract` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_contract` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_contract` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_contract` ALTER COLUMN `delivery_schedule_type` SET TAGS ('dbx_business_glossary_term' = 'Delivery Schedule Type');
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_contract` ALTER COLUMN `delivery_schedule_type` SET TAGS ('dbx_value_regex' = 'on_demand|scheduled|just_in_time|consignment|vendor_managed_inventory');
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_contract` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_contract` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_contract` ALTER COLUMN `exclusivity_clause_flag` SET TAGS ('dbx_business_glossary_term' = 'Exclusivity Clause Flag');
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_contract` ALTER COLUMN `food_safety_certification_required` SET TAGS ('dbx_business_glossary_term' = 'Food Safety Certification Required');
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_contract` ALTER COLUMN `force_majeure_clause` SET TAGS ('dbx_business_glossary_term' = 'Force Majeure Clause');
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_contract` ALTER COLUMN `incoterms` SET TAGS ('dbx_business_glossary_term' = 'Incoterms (International Commercial Terms)');
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_contract` ALTER COLUMN `incoterms_location` SET TAGS ('dbx_business_glossary_term' = 'Incoterms Location');
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_contract` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_contract` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time Days');
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_contract` ALTER COLUMN `minimum_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity (MOQ)');
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_contract` ALTER COLUMN `moq_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'MOQ Unit of Measure');
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_contract` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_contract` ALTER COLUMN `price_adjustment_mechanism` SET TAGS ('dbx_business_glossary_term' = 'Price Adjustment Mechanism');
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_contract` ALTER COLUMN `price_adjustment_mechanism` SET TAGS ('dbx_value_regex' = 'fixed|index_linked|cost_plus|market_based|annual_review|quarterly_review');
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_contract` ALTER COLUMN `price_index_reference` SET TAGS ('dbx_business_glossary_term' = 'Price Index Reference');
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_contract` ALTER COLUMN `price_validity_end_date` SET TAGS ('dbx_business_glossary_term' = 'Price Validity End Date');
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_contract` ALTER COLUMN `price_validity_start_date` SET TAGS ('dbx_business_glossary_term' = 'Price Validity Start Date');
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_contract` ALTER COLUMN `purchasing_group` SET TAGS ('dbx_business_glossary_term' = 'Purchasing Group');
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_contract` ALTER COLUMN `purchasing_organization` SET TAGS ('dbx_business_glossary_term' = 'Purchasing Organization');
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_contract` ALTER COLUMN `rebate_agreement_flag` SET TAGS ('dbx_business_glossary_term' = 'Rebate Agreement Flag');
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_contract` ALTER COLUMN `rebate_percentage` SET TAGS ('dbx_business_glossary_term' = 'Rebate Percentage');
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_contract` ALTER COLUMN `rebate_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_contract` ALTER COLUMN `renewal_notice_days` SET TAGS ('dbx_business_glossary_term' = 'Renewal Notice Days');
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_contract` ALTER COLUMN `termination_notice_days` SET TAGS ('dbx_business_glossary_term' = 'Termination Notice Days');
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_contract` ALTER COLUMN `total_contract_value` SET TAGS ('dbx_business_glossary_term' = 'Total Contract Value');
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_contract` ALTER COLUMN `total_contract_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_contract` ALTER COLUMN `volume_commitment_quantity` SET TAGS ('dbx_business_glossary_term' = 'Volume Commitment Quantity');
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_contract` ALTER COLUMN `volume_commitment_quantity` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_contract` ALTER COLUMN `volume_commitment_uom` SET TAGS ('dbx_business_glossary_term' = 'Volume Commitment Unit of Measure');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_scorecard` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_scorecard` SET TAGS ('dbx_subdomain' = 'vendor_management');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_scorecard` ALTER COLUMN `supplier_scorecard_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Scorecard ID');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_scorecard` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_scorecard` ALTER COLUMN `purchase_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract ID');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_scorecard` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_scorecard` ALTER COLUMN `allergen_compliance_rate` SET TAGS ('dbx_business_glossary_term' = 'Allergen Compliance Rate');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_scorecard` ALTER COLUMN `approved_date` SET TAGS ('dbx_business_glossary_term' = 'Scorecard Approved Date');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_scorecard` ALTER COLUMN `avl_status` SET TAGS ('dbx_business_glossary_term' = 'Approved Vendor List (AVL) Status');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_scorecard` ALTER COLUMN `avl_status` SET TAGS ('dbx_value_regex' = 'approved|conditional|suspended|removed|pending_review');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_scorecard` ALTER COLUMN `coa_compliance_rate` SET TAGS ('dbx_business_glossary_term' = 'Certificate of Analysis (CoA) Compliance Rate');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_scorecard` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Scorecard Comments');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_scorecard` ALTER COLUMN `compliance_score` SET TAGS ('dbx_business_glossary_term' = 'Compliance Dimension Score');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_scorecard` ALTER COLUMN `corrective_action_due_date` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Due Date');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_scorecard` ALTER COLUMN `corrective_action_required` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Required Flag');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_scorecard` ALTER COLUMN `cost_score` SET TAGS ('dbx_business_glossary_term' = 'Cost Dimension Score');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_scorecard` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_scorecard` ALTER COLUMN `critical_nonconformance_count` SET TAGS ('dbx_business_glossary_term' = 'Critical Non-Conformance Count');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_scorecard` ALTER COLUMN `defect_rate_ppm` SET TAGS ('dbx_business_glossary_term' = 'Defect Rate (Parts Per Million)');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_scorecard` ALTER COLUMN `delivery_score` SET TAGS ('dbx_business_glossary_term' = 'Delivery Dimension Score');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_scorecard` ALTER COLUMN `evaluation_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Period End Date');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_scorecard` ALTER COLUMN `evaluation_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Period Start Date');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_scorecard` ALTER COLUMN `evaluation_period_type` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Period Type');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_scorecard` ALTER COLUMN `evaluation_period_type` SET TAGS ('dbx_value_regex' = 'quarterly|semi_annual|annual|ad_hoc');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_scorecard` ALTER COLUMN `fill_rate` SET TAGS ('dbx_business_glossary_term' = 'Fill Rate');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_scorecard` ALTER COLUMN `food_safety_audit_result` SET TAGS ('dbx_business_glossary_term' = 'Food Safety Audit Result');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_scorecard` ALTER COLUMN `food_safety_audit_result` SET TAGS ('dbx_value_regex' = 'pass|conditional_pass|fail|not_audited');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_scorecard` ALTER COLUMN `food_safety_certification_scheme` SET TAGS ('dbx_business_glossary_term' = 'Food Safety Certification Scheme');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_scorecard` ALTER COLUMN `invoice_accuracy_rate` SET TAGS ('dbx_business_glossary_term' = 'Invoice Accuracy Rate');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_scorecard` ALTER COLUMN `lead_time_performance_rate` SET TAGS ('dbx_business_glossary_term' = 'Lead Time Performance Rate');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_scorecard` ALTER COLUMN `nonconformance_count` SET TAGS ('dbx_business_glossary_term' = 'Non-Conformance Count');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_scorecard` ALTER COLUMN `otif_rate` SET TAGS ('dbx_business_glossary_term' = 'On Time In Full (OTIF) Rate');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_scorecard` ALTER COLUMN `overall_score` SET TAGS ('dbx_business_glossary_term' = 'Overall Supplier Performance Score');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_scorecard` ALTER COLUMN `preferred_supplier_flag` SET TAGS ('dbx_business_glossary_term' = 'Preferred Supplier Flag');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_scorecard` ALTER COLUMN `price_variance_rate` SET TAGS ('dbx_business_glossary_term' = 'Price Variance Rate');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_scorecard` ALTER COLUMN `price_variance_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_scorecard` ALTER COLUMN `quality_score` SET TAGS ('dbx_business_glossary_term' = 'Quality Dimension Score');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_scorecard` ALTER COLUMN `responsiveness_score` SET TAGS ('dbx_business_glossary_term' = 'Supplier Responsiveness Score');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_scorecard` ALTER COLUMN `scorecard_date` SET TAGS ('dbx_business_glossary_term' = 'Scorecard Issue Date');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_scorecard` ALTER COLUMN `scorecard_number` SET TAGS ('dbx_business_glossary_term' = 'Scorecard Number');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_scorecard` ALTER COLUMN `scorecard_number` SET TAGS ('dbx_value_regex' = '^SC-[0-9]{4}-[0-9]{6}$');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_scorecard` ALTER COLUMN `scorecard_status` SET TAGS ('dbx_business_glossary_term' = 'Scorecard Status');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_scorecard` ALTER COLUMN `scorecard_status` SET TAGS ('dbx_value_regex' = 'draft|in_review|approved|published|archived');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_scorecard` ALTER COLUMN `service_score` SET TAGS ('dbx_business_glossary_term' = 'Service Dimension Score');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_scorecard` ALTER COLUMN `shelf_life_compliance_rate` SET TAGS ('dbx_business_glossary_term' = 'Shelf Life Compliance Rate');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_scorecard` ALTER COLUMN `spend_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Spend Currency Code');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_scorecard` ALTER COLUMN `spend_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_scorecard` ALTER COLUMN `supplier_acknowledged_flag` SET TAGS ('dbx_business_glossary_term' = 'Supplier Acknowledged Flag');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_scorecard` ALTER COLUMN `supplier_category` SET TAGS ('dbx_business_glossary_term' = 'Supplier Category');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_scorecard` ALTER COLUMN `sustainability_rating` SET TAGS ('dbx_business_glossary_term' = 'Sustainability Rating');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_scorecard` ALTER COLUMN `sustainability_rating` SET TAGS ('dbx_value_regex' = 'A|B|C|D|F|not_rated');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_scorecard` ALTER COLUMN `total_purchase_orders` SET TAGS ('dbx_business_glossary_term' = 'Total Purchase Orders');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_scorecard` ALTER COLUMN `total_spend_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Spend Amount');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_scorecard` ALTER COLUMN `total_spend_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_scorecard` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_audit` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_audit` SET TAGS ('dbx_subdomain' = 'vendor_management');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_audit` ALTER COLUMN `supplier_audit_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Audit ID');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_audit` ALTER COLUMN `storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'Audited Storage Location Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_audit` ALTER COLUMN `compliance_document_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Report Document ID');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_audit` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_audit` ALTER COLUMN `supplier_site_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Site Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_audit` ALTER COLUMN `audit_closure_date` SET TAGS ('dbx_business_glossary_term' = 'Audit Closure Date');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_audit` ALTER COLUMN `audit_date` SET TAGS ('dbx_business_glossary_term' = 'Audit Date');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_audit` ALTER COLUMN `audit_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Audit End Timestamp');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_audit` ALTER COLUMN `audit_frequency_months` SET TAGS ('dbx_business_glossary_term' = 'Audit Frequency Months');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_audit` ALTER COLUMN `audit_grade` SET TAGS ('dbx_business_glossary_term' = 'Audit Grade');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_audit` ALTER COLUMN `audit_notes` SET TAGS ('dbx_business_glossary_term' = 'Audit Notes');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_audit` ALTER COLUMN `audit_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Audit Reference Number');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_audit` ALTER COLUMN `audit_reference_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{6,20}$');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_audit` ALTER COLUMN `audit_scope` SET TAGS ('dbx_business_glossary_term' = 'Audit Scope');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_audit` ALTER COLUMN `audit_score` SET TAGS ('dbx_business_glossary_term' = 'Audit Score');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_audit` ALTER COLUMN `audit_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Audit Start Timestamp');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_audit` ALTER COLUMN `audit_status` SET TAGS ('dbx_business_glossary_term' = 'Audit Status');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_audit` ALTER COLUMN `audit_status` SET TAGS ('dbx_value_regex' = 'scheduled|in_progress|completed|cancelled|pending_review|closed');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_audit` ALTER COLUMN `audit_type` SET TAGS ('dbx_business_glossary_term' = 'Audit Type');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_audit` ALTER COLUMN `auditor_certification` SET TAGS ('dbx_business_glossary_term' = 'Auditor Certification');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_audit` ALTER COLUMN `auditor_organization` SET TAGS ('dbx_business_glossary_term' = 'Auditor Organization');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_audit` ALTER COLUMN `capa_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action and Preventive Action (CAPA) Approval Date');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_audit` ALTER COLUMN `capa_due_date` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action and Preventive Action (CAPA) Due Date');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_audit` ALTER COLUMN `capa_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action and Preventive Action (CAPA) Required Flag');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_audit` ALTER COLUMN `capa_submission_date` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action and Preventive Action (CAPA) Submission Date');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_audit` ALTER COLUMN `capa_verification_date` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action and Preventive Action (CAPA) Verification Date');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_audit` ALTER COLUMN `capa_verification_method` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action and Preventive Action (CAPA) Verification Method');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_audit` ALTER COLUMN `capa_verification_method` SET TAGS ('dbx_value_regex' = 'document_review|follow_up_audit|remote_verification|supplier_self_assessment|photographic_evidence|test_results');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_audit` ALTER COLUMN `capa_verification_status` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action and Preventive Action (CAPA) Verification Status');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_audit` ALTER COLUMN `capa_verification_status` SET TAGS ('dbx_value_regex' = 'pending|verified_effective|verified_ineffective|requires_additional_action|closed');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_audit` ALTER COLUMN `certification_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Certification Expiry Date');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_audit` ALTER COLUMN `certification_status` SET TAGS ('dbx_business_glossary_term' = 'Certification Status');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_audit` ALTER COLUMN `certification_status` SET TAGS ('dbx_value_regex' = 'certified|not_certified|certification_suspended|certification_withdrawn|recertification_required');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_audit` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_audit` ALTER COLUMN `critical_findings_count` SET TAGS ('dbx_business_glossary_term' = 'Critical Findings Count');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_audit` ALTER COLUMN `fsma_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Food Safety Modernization Act (FSMA) Compliance Flag');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_audit` ALTER COLUMN `gfsi_recognized_flag` SET TAGS ('dbx_business_glossary_term' = 'Global Food Safety Initiative (GFSI) Recognized Flag');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_audit` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_audit` ALTER COLUMN `major_findings_count` SET TAGS ('dbx_business_glossary_term' = 'Major Findings Count');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_audit` ALTER COLUMN `minor_findings_count` SET TAGS ('dbx_business_glossary_term' = 'Minor Findings Count');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_audit` ALTER COLUMN `next_audit_scheduled_date` SET TAGS ('dbx_business_glossary_term' = 'Next Audit Scheduled Date');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_audit` ALTER COLUMN `observation_count` SET TAGS ('dbx_business_glossary_term' = 'Observation Count');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_audit` ALTER COLUMN `pass_fail_status` SET TAGS ('dbx_business_glossary_term' = 'Pass/Fail Status');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_audit` ALTER COLUMN `pass_fail_status` SET TAGS ('dbx_value_regex' = 'pass|fail|conditional_pass|pending');
ALTER TABLE `food_beverage_ecm`.`procurement`.`compliance_document` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `food_beverage_ecm`.`procurement`.`compliance_document` SET TAGS ('dbx_subdomain' = 'vendor_management');
ALTER TABLE `food_beverage_ecm`.`procurement`.`compliance_document` ALTER COLUMN `compliance_document_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Document ID');
ALTER TABLE `food_beverage_ecm`.`procurement`.`compliance_document` ALTER COLUMN `equipment_master_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Master Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`procurement`.`compliance_document` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `food_beverage_ecm`.`procurement`.`compliance_document` ALTER COLUMN `raw_material_id` SET TAGS ('dbx_business_glossary_term' = 'Material ID');
ALTER TABLE `food_beverage_ecm`.`procurement`.`compliance_document` ALTER COLUMN `superseded_document_compliance_document_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded Document ID');
ALTER TABLE `food_beverage_ecm`.`procurement`.`compliance_document` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `food_beverage_ecm`.`procurement`.`compliance_document` ALTER COLUMN `supplier_site_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Site Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`procurement`.`compliance_document` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `food_beverage_ecm`.`procurement`.`compliance_document` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `food_beverage_ecm`.`procurement`.`compliance_document` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending_approval|approved|conditionally_approved|rejected|under_review');
ALTER TABLE `food_beverage_ecm`.`procurement`.`compliance_document` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `food_beverage_ecm`.`procurement`.`compliance_document` ALTER COLUMN `audit_grade` SET TAGS ('dbx_business_glossary_term' = 'Audit Grade');
ALTER TABLE `food_beverage_ecm`.`procurement`.`compliance_document` ALTER COLUMN `audit_score` SET TAGS ('dbx_business_glossary_term' = 'Audit Score');
ALTER TABLE `food_beverage_ecm`.`procurement`.`compliance_document` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `food_beverage_ecm`.`procurement`.`compliance_document` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Level');
ALTER TABLE `food_beverage_ecm`.`procurement`.`compliance_document` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_value_regex' = 'public|internal|confidential|restricted');
ALTER TABLE `food_beverage_ecm`.`procurement`.`compliance_document` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_business_glossary_term' = 'Country of Origin');
ALTER TABLE `food_beverage_ecm`.`procurement`.`compliance_document` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `food_beverage_ecm`.`procurement`.`compliance_document` ALTER COLUMN `critical_non_conformance_count` SET TAGS ('dbx_business_glossary_term' = 'Critical Non-Conformance Count');
ALTER TABLE `food_beverage_ecm`.`procurement`.`compliance_document` ALTER COLUMN `document_category` SET TAGS ('dbx_business_glossary_term' = 'Document Category');
ALTER TABLE `food_beverage_ecm`.`procurement`.`compliance_document` ALTER COLUMN `document_number` SET TAGS ('dbx_business_glossary_term' = 'Document Number');
ALTER TABLE `food_beverage_ecm`.`procurement`.`compliance_document` ALTER COLUMN `document_status` SET TAGS ('dbx_business_glossary_term' = 'Document Status');
ALTER TABLE `food_beverage_ecm`.`procurement`.`compliance_document` ALTER COLUMN `document_title` SET TAGS ('dbx_business_glossary_term' = 'Document Title');
ALTER TABLE `food_beverage_ecm`.`procurement`.`compliance_document` ALTER COLUMN `document_type` SET TAGS ('dbx_business_glossary_term' = 'Document Type');
ALTER TABLE `food_beverage_ecm`.`procurement`.`compliance_document` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `food_beverage_ecm`.`procurement`.`compliance_document` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `food_beverage_ecm`.`procurement`.`compliance_document` ALTER COLUMN `file_format` SET TAGS ('dbx_business_glossary_term' = 'File Format');
ALTER TABLE `food_beverage_ecm`.`procurement`.`compliance_document` ALTER COLUMN `file_name` SET TAGS ('dbx_business_glossary_term' = 'File Name');
ALTER TABLE `food_beverage_ecm`.`procurement`.`compliance_document` ALTER COLUMN `file_path` SET TAGS ('dbx_business_glossary_term' = 'File Path');
ALTER TABLE `food_beverage_ecm`.`procurement`.`compliance_document` ALTER COLUMN `file_size_kb` SET TAGS ('dbx_business_glossary_term' = 'File Size (KB)');
ALTER TABLE `food_beverage_ecm`.`procurement`.`compliance_document` ALTER COLUMN `issue_date` SET TAGS ('dbx_business_glossary_term' = 'Issue Date');
ALTER TABLE `food_beverage_ecm`.`procurement`.`compliance_document` ALTER COLUMN `issuing_authority` SET TAGS ('dbx_business_glossary_term' = 'Issuing Authority');
ALTER TABLE `food_beverage_ecm`.`procurement`.`compliance_document` ALTER COLUMN `issuing_authority_license_number` SET TAGS ('dbx_business_glossary_term' = 'Issuing Authority License Number');
ALTER TABLE `food_beverage_ecm`.`procurement`.`compliance_document` ALTER COLUMN `language_code` SET TAGS ('dbx_business_glossary_term' = 'Language Code');
ALTER TABLE `food_beverage_ecm`.`procurement`.`compliance_document` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `food_beverage_ecm`.`procurement`.`compliance_document` ALTER COLUMN `lot_number` SET TAGS ('dbx_business_glossary_term' = 'Lot Number');
ALTER TABLE `food_beverage_ecm`.`procurement`.`compliance_document` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `food_beverage_ecm`.`procurement`.`compliance_document` ALTER COLUMN `non_conformance_count` SET TAGS ('dbx_business_glossary_term' = 'Non-Conformance Count');
ALTER TABLE `food_beverage_ecm`.`procurement`.`compliance_document` ALTER COLUMN `regulatory_framework` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Framework');
ALTER TABLE `food_beverage_ecm`.`procurement`.`compliance_document` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `food_beverage_ecm`.`procurement`.`compliance_document` ALTER COLUMN `retention_period_years` SET TAGS ('dbx_business_glossary_term' = 'Retention Period (Years)');
ALTER TABLE `food_beverage_ecm`.`procurement`.`compliance_document` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_requisition` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_requisition` SET TAGS ('dbx_subdomain' = 'order_processing');
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `purchase_requisition_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Requisition (PR) ID');
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `demand_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Demand Plan Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `purchase_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Contract Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `raw_material_id` SET TAGS ('dbx_business_glossary_term' = 'Raw Material Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `approval_workflow_code` SET TAGS ('dbx_business_glossary_term' = 'Approval Workflow ID');
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `approval_workflow_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,16}$');
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `conversion_date` SET TAGS ('dbx_business_glossary_term' = 'Conversion Date');
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `delivery_address` SET TAGS ('dbx_business_glossary_term' = 'Delivery Address');
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `delivery_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `delivery_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `estimated_total_value` SET TAGS ('dbx_business_glossary_term' = 'Estimated Total Value');
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `estimated_unit_price` SET TAGS ('dbx_business_glossary_term' = 'Estimated Unit Price');
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `is_deleted` SET TAGS ('dbx_business_glossary_term' = 'Is Deleted Flag');
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `material_group_code` SET TAGS ('dbx_business_glossary_term' = 'Material Group Code');
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `material_group_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,8}$');
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `plant_code` SET TAGS ('dbx_business_glossary_term' = 'Plant Code');
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `plant_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|urgent');
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `procurement_category` SET TAGS ('dbx_business_glossary_term' = 'Procurement Category');
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `procurement_category` SET TAGS ('dbx_value_regex' = 'raw_material|ingredient|packaging|indirect_material|service|capital_equipment');
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `quantity_requested` SET TAGS ('dbx_business_glossary_term' = 'Quantity Requested');
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `requestor_email` SET TAGS ('dbx_business_glossary_term' = 'Requestor Email Address');
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `requestor_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `requestor_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `requestor_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `requestor_name` SET TAGS ('dbx_business_glossary_term' = 'Requestor Name');
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `required_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Required Delivery Date');
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `requisition_date` SET TAGS ('dbx_business_glossary_term' = 'Requisition Date');
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `requisition_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Requisition (PR) Number');
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `requisition_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{10}$');
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `requisition_status` SET TAGS ('dbx_business_glossary_term' = 'Requisition Status');
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `requisition_type` SET TAGS ('dbx_business_glossary_term' = 'Requisition Type');
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `requisition_type` SET TAGS ('dbx_value_regex' = 'standard|subcontracting|consignment|stock_transfer|service|third_party');
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'sap_s4hana|oracle_cloud|manual_entry');
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `special_instructions` SET TAGS ('dbx_business_glossary_term' = 'Special Instructions');
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `storage_location_code` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Code');
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `storage_location_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,3}$');
