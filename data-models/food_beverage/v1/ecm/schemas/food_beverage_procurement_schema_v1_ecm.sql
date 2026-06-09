-- Schema for Domain: procurement | Business: Food Beverage | Version: v1_ecm
-- Generated on: 2026-05-05 21:26:24

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `food_beverage_ecm`.`procurement` COMMENT 'Sourcing and procurement of raw materials, ingredients, packaging, indirect materials, and services. Includes supplier master data, purchase orders, MOQs, contracts, supplier performance scorecards, supplier audits, TraceGains compliance documents, approved vendor lists, raw material pricing contracts, and spend analytics.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `food_beverage_ecm`.`procurement`.`supplier` (
    `supplier_id` BIGINT COMMENT 'Unique system-generated identifier for the supplier record. Primary key for the supplier master data product in the procurement domain. Sourced from SAP S/4HANA MM vendor master (LFA1-LIFNR mapped to BIGINT).',
    `esg_disclosure_id` BIGINT COMMENT 'Foreign key linking to sustainability.esg_disclosure. Business justification: Required for supplier onboarding: ESG disclosure submission is reviewed during qualification and stored per supplier.',
    `establishment_registration_id` BIGINT COMMENT 'Foreign key linking to regulatory.establishment_registration. Business justification: Compliance team needs to link each supplier to its FDA/USDA establishment registration for audit reporting and traceability.',
    `target_id` BIGINT COMMENT 'Foreign key linking to sustainability.sustainability_target. Business justification: Supplier sustainability performance targets are tracked to monitor compliance with corporate ESG goals.',
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
    `rd_project_id` BIGINT COMMENT 'Foreign key linking to research.rd_project. Business justification: Ingredient qualification process ties each AVL record to the rd_project that requested the material, enabling traceability in the qualification report.',
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
    `material_category` STRING COMMENT 'High-level classification of the material type the supplier is approved to provide. Drives procurement routing and compliance requirements. [ENUM-REF-CANDIDATE: ingredient|packaging|indirect|co-manufacturing|toll_manufacturing — promote to reference product if additional categories are added]. Valid values are `ingredient|packaging|indirect|co-manufacturing|toll_manufacturing`',
    `material_description` STRING COMMENT 'Short description of the raw material, ingredient, or packaging item as defined in the SAP Material Master. Supports readability in AVL reports.',
    `material_number` STRING COMMENT 'SAP material number (MATNR) for the raw material, ingredient, or packaging item that the supplier is approved to provide. Denormalized for operational reporting.',
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
    `asset_id` BIGINT COMMENT 'Foreign key linking to maintenance.asset. Business justification: CAPITAL EQUIPMENT PROCUREMENT process requires linking each purchase order to the asset created, enabling asset registration and cost tracking.',
    `bill_to_location_id` BIGINT COMMENT 'Foreign key linking to customer.bill_to_location. Business justification: Invoice generation requires the billing address; linking PO to the customers bill‑to location ensures accurate invoicing and tax handling.',
    `category_strategy_id` BIGINT COMMENT 'Foreign key linking to procurement.category_strategy. Business justification: Each purchase order is governed by a category strategy; linking provides strategic alignment and removes the redundant free‑text procurement_category column.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Required for allocating PO expenses to the appropriate cost center in financial reporting and budgeting, as the PO expense is posted to a cost center per standard F&B accounting practice.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: PO creation audit trail records which employee entered the order for compliance and cost control.',
    `fsma_record_id` BIGINT COMMENT 'Foreign key linking to regulatory.fsma_record. Business justification: Order processing records the associated FSMA compliance record for the supplier’s facility to support food safety audits.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Needed to map each purchase order to the GL account for expense posting, enabling accurate GL trial balance and compliance with financial statements.',
    `plant_id` BIGINT COMMENT 'Reference to the receiving plant or distribution center (DC) where the ordered goods or services are to be delivered. Maps to SAP EKPO-WERKS plant code.',
    `purchase_contract_id` BIGINT COMMENT 'Reference to the underlying procurement contract or blanket purchase agreement (outline agreement) against which this PO is released. Nullable for spot/one-time purchases. Maps to SAP EKKO-KONNR contract number.',
    `rd_project_id` BIGINT COMMENT 'Foreign key linking to research.rd_project. Business justification: R&D project spend tracking report requires each PO to be linked to the funding rd_project for budgeting and cost allocation.',
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
    `delivery_address` STRING COMMENT 'Full delivery address of the destination plant or DC where goods are to be received. Includes street, city, state/province, postal code, and country. Used for logistics coordination and ASN matching.',
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
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Links PO line items to GL accounts for precise posting of material costs, essential for financial reporting and audit trails.',
    `purchase_contract_id` BIGINT COMMENT 'Reference to the raw material pricing contract or framework agreement governing the terms of this purchase order line. Supports contract compliance and price variance analysis.',
    `purchase_order_id` BIGINT COMMENT 'Foreign key reference to the parent purchase order header. Establishes the header/detail relationship for BOM-driven procurement and spend analytics. Satisfies TRANSACTION_LINE category: HEADER_REFERENCE.',
    `raw_material_id` BIGINT COMMENT 'Reference to the material or ingredient master record being procured on this line. Links to the material master for BOM-driven procurement, allergen matrix, and raw material cost tracking (COGS). Satisfies TRANSACTION_LINE category: RESOURCE_REFERENCE.',
    `rd_project_id` BIGINT COMMENT 'Foreign key linking to research.rd_project. Business justification: Detailed material consumption analysis for R&D needs line‑level PO linkage to the rd_project to reconcile actual usage vs. plan.',
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
    `asset_id` BIGINT COMMENT 'Foreign key linking to maintenance.asset. Business justification: Upon receipt of capital equipment, the goods receipt must reference the corresponding asset for warranty and compliance tracking.',
    `raw_material_id` BIGINT COMMENT 'Reference to the material master record for the received item. Identifies the raw material, ingredient, packaging component, or indirect material received.',
    `plant_id` BIGINT COMMENT 'Reference to the manufacturing plant or distribution center where the goods were physically received. Critical for inventory positioning and FEFO/FIFO assignment.',
    `po_line_id` BIGINT COMMENT 'Reference to the specific line item on the purchase order for which goods are being received. Enables line-level receipt tracking.',
    `purchase_order_id` BIGINT COMMENT 'Reference to the purchase order against which this goods receipt is recorded. Links to the purchase order that authorized the procurement.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Receiving clerk identity is required for traceability, quality checks, and labor cost allocation.',
    `storage_location_id` BIGINT COMMENT 'Reference to the specific storage location within the plant where the received goods are placed. Enables warehouse bin-level traceability.',
    `supplier_id` BIGINT COMMENT 'Reference to the supplier who delivered the goods. Links to the supplier master data for vendor performance tracking and compliance.',
    `allergen_declaration_received_flag` BOOLEAN COMMENT 'Indicates whether the supplier-provided allergen declaration was received with the goods. Critical for allergen matrix management and food safety compliance.',
    `batch_number` STRING COMMENT 'The supplier-provided batch or lot number for the received material. Critical for lot traceability, FSMA compliance, recall management, and FEFO inventory rotation.. Valid values are `^[A-Z0-9]{6,20}$`',
    `best_before_date` DATE COMMENT 'The date until which the received material maintains optimal quality characteristics. Used for inventory prioritization and customer service level management.',
    `bill_of_lading_number` STRING COMMENT 'The carrier-issued bill of lading number for the shipment. Links goods receipt to transportation and logistics documentation for freight audit and claims.. Valid values are `^BOL[A-Z0-9]{8,20}$`',
    `carrier_name` STRING COMMENT 'The name of the transportation carrier who delivered the goods. Used for carrier performance tracking and freight cost allocation.',
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
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Contract ownership is assigned to a specific employee for responsibility tracking and reporting.',
    `initiative_id` BIGINT COMMENT 'Foreign key linking to sustainability.sustainability_initiative. Business justification: Procurement contracts are linked to internal sustainability initiatives they fund (e.g., carbon‑reduction projects).',
    `product_registration_id` BIGINT COMMENT 'Foreign key linking to regulatory.product_registration. Business justification: Contract management tracks which product registrations are covered by each purchase contract to ensure legal market eligibility.',
    `supplier_id` BIGINT COMMENT 'Reference to the supplier party with whom this contract is established.',
    `target_id` BIGINT COMMENT 'Foreign key linking to sustainability.sustainability_target. Business justification: Contracts embed ESG performance targets that suppliers must meet, tracked per contract.',
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
    `material_category` STRING COMMENT 'High-level classification of the materials or services covered by this contract. Raw materials and ingredients are used in production; packaging materials are for finished goods; indirect materials and MRO (Maintenance, Repair, Operations) support operations.. Valid values are `raw_material|ingredient|packaging|indirect_material|service|MRO`',
    `minimum_order_quantity` DECIMAL(18,2) COMMENT 'Minimum quantity that must be ordered per purchase order or delivery under this contract. Critical for production planning and supplier efficiency.',
    `moq_unit_of_measure` STRING COMMENT 'Unit of measure for the minimum order quantity (e.g., KG, LB, EA, CS, MT, GAL).',
    `payment_terms` STRING COMMENT 'Standard payment terms code defining the payment schedule and conditions (e.g., Net 30, Net 60, 2/10 Net 30 for early payment discounts).',
    `price_adjustment_mechanism` STRING COMMENT 'Method by which contract prices may be adjusted over time. Index-linked ties to commodity indices; cost-plus adjusts based on supplier cost changes; fixed prices remain constant; periodic reviews allow renegotiation.. Valid values are `fixed|index_linked|cost_plus|market_based|annual_review|quarterly_review`',
    `price_index_reference` STRING COMMENT 'Name of the commodity or inflation index used for price escalation (e.g., USDA Dairy Index, CPI, PPI, CME Corn Futures). Applicable when price_adjustment_mechanism is index_linked.',
    `price_validity_end_date` DATE COMMENT 'Date until which the pricing conditions remain valid. After this date, prices may be renegotiated or adjusted per escalation clauses.',
    `price_validity_start_date` DATE COMMENT 'Date from which the pricing conditions in this contract become effective.',
    `purchasing_group` STRING COMMENT 'Code identifying the buyer or procurement team responsible for managing this contract and related purchase orders.',
    `purchasing_organization` STRING COMMENT 'Code or name of the purchasing organization or business unit responsible for this contract within the enterprise.',
    `quality_specification_reference` STRING COMMENT 'Reference to the quality specification document or standard that materials supplied under this contract must meet (e.g., TraceGains spec ID, internal QA standard).',
    `rebate_agreement_flag` BOOLEAN COMMENT 'Indicates whether this contract includes volume-based rebate or discount tiers that provide retroactive price reductions when volume thresholds are met.',
    `rebate_percentage` DECIMAL(18,2) COMMENT 'Percentage rebate applied when volume commitments or spend thresholds are achieved. May be tiered based on volume levels.',
    `renewal_notice_days` STRING COMMENT 'Number of days prior to contract expiration that termination notice must be provided to prevent automatic renewal.',
    `spend_category` STRING COMMENT 'Detailed spend classification for analytics and category management (e.g., Dairy Ingredients, Flexible Packaging, Transportation Services).',
    `termination_notice_days` STRING COMMENT 'Number of days advance notice required for early termination of the contract by either party.',
    `total_contract_value` DECIMAL(18,2) COMMENT 'Maximum monetary value committed under this contract across all line items and purchase orders. For value contracts, this is the spending limit; for quantity contracts, this is the estimated total value.',
    `volume_commitment_quantity` DECIMAL(18,2) COMMENT 'Total quantity committed to be purchased over the contract period. Used for volume-based pricing tiers and rebate calculations.',
    `volume_commitment_uom` STRING COMMENT 'Unit of measure for the volume commitment quantity.',
    CONSTRAINT pk_purchase_contract PRIMARY KEY(`purchase_contract_id`)
) COMMENT 'Long-term procurement contract or framework agreement with a supplier covering raw materials, ingredients, packaging, or services. Captures contract type (value contract, quantity contract, scheduling agreement), contract period, total contract value, pricing conditions (unit prices, price scales, volume tiers, index-linked escalation), volume commitments, MOQ terms, rebate tiers, exclusivity clauses, force majeure terms, and renewal/termination provisions. Includes pricing validity periods and price adjustment mechanisms. Sourced from SAP MM outline agreements and Oracle Cloud Procurement contracts.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`procurement`.`supplier_scorecard` (
    `supplier_scorecard_id` BIGINT COMMENT 'Unique system-generated identifier for the supplier performance scorecard record. Primary key. Entity role: TRANSACTION_HEADER — a periodic business event capturing quantitative KPI snapshots across quality, delivery, service, cost, and compliance dimensions for a supplier.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Scorecard evaluation is performed by internal employees; linking evaluator enables performance reporting.',
    `purchase_contract_id` BIGINT COMMENT 'Reference to the active procurement contract or framework agreement under which this supplier is being evaluated. Used to align scorecard results with contract renewal and AVL decisions.',
    `rd_project_id` BIGINT COMMENT 'Foreign key linking to research.rd_project. Business justification: Supplier selection for R&D uses scorecards; linking scorecard to rd_project supports the supplier evaluation dashboard per project.',
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
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Audit Assignment process requires linking internal auditor employee to each supplier audit for accountability.',
    `compliance_document_id` BIGINT COMMENT 'Reference identifier for the complete audit report document stored in the document management system (TraceGains or Veeva Vault).',
    `supplier_id` BIGINT COMMENT 'Identifier of the supplier being audited. Links to the supplier master data entity.',
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
    `facility_address` STRING COMMENT 'Complete physical address of the audited supplier facility, including street, city, state/province, and postal code.',
    `facility_country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code for the location of the audited facility (e.g., USA, MEX, CHN, DEU).. Valid values are `^[A-Z]{3}$`',
    `facility_name` STRING COMMENT 'Name of the supplier facility or manufacturing site where the audit was conducted.',
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
    `raw_material_id` BIGINT COMMENT 'Identifier of the raw material, ingredient, or packaging component that this compliance document applies to. Null if document applies to supplier facility or general capability.',
    `plant_id` BIGINT COMMENT 'Identifier of the supplier manufacturing facility or site that this compliance document applies to. Null if document is not facility-specific.',
    `rd_project_id` BIGINT COMMENT 'Foreign key linking to research.rd_project. Business justification: Regulatory submission dossiers are attached to the rd_project they support; linking enables the compliance tracking matrix.',
    `superseded_document_compliance_document_id` BIGINT COMMENT 'Identifier of the previous version of the compliance document that this document replaces. Null if this is the first version.',
    `supplier_id` BIGINT COMMENT 'Identifier of the supplier who provided this compliance document.',
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
    `facility_name` STRING COMMENT 'Name of the supplier facility or production site covered by this compliance document as stated in the document.',
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
    `material_description` STRING COMMENT 'Textual description of the material or ingredient covered by this compliance document as stated in the document itself.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next periodic review or renewal of the compliance document to ensure continued validity and compliance.',
    `non_conformance_count` STRING COMMENT 'Number of non-conformances, deficiencies, or findings identified during an audit or inspection. Null for non-audit documents.',
    `regulatory_framework` STRING COMMENT 'Name of the regulatory standard, certification scheme, or compliance framework that this document satisfies (e.g., FSMA, GFSI, ISO 22000, Organic NOP, Non-GMO Project).',
    `rejection_reason` STRING COMMENT 'Explanation or justification for why the compliance document was rejected during internal review. Null if document was not rejected.',
    `retention_period_years` STRING COMMENT 'Number of years the compliance document must be retained to meet regulatory, legal, or business requirements.',
    `version_number` STRING COMMENT 'Version identifier of the compliance document used to track revisions and updates over time. Follows supplier or internal versioning convention.',
    CONSTRAINT pk_compliance_document PRIMARY KEY(`compliance_document_id`)
) COMMENT 'Supplier compliance document record managing certificates, specifications, and regulatory documents required for approved supplier status. Document types include: Certificate of Analysis (CoA), Certificate of Conformance (CoC), allergen declarations, GMO status declarations, Kosher/Halal certificates, organic certificates, GFSI audit certificates, FDA registration, USDA inspection records, and SDS sheets. Tracks document version, issue date, expiry date, and approval status. Managed in TraceGains Document Management.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`procurement`.`sourcing_event` (
    `sourcing_event_id` BIGINT COMMENT 'Unique identifier for the sourcing event record. Primary key.',
    `employee_id` BIGINT COMMENT 'Identifier of the procurement buyer or category manager responsible for managing this sourcing event.',
    `rd_project_id` BIGINT COMMENT 'Foreign key linking to research.rd_project. Business justification: Sourcing events for new ingredients are initiated by specific rd_projects; the event‑to‑project link is required for the sourcing performance report.',
    `award_date` DATE COMMENT 'Date when the sourcing event was awarded to the winning supplier(s). Null if event is not yet awarded or was cancelled.',
    `award_rationale` STRING COMMENT 'Business justification and rationale for the award decision, documenting why the winning supplier(s) were selected based on evaluation criteria.',
    `awarded_spend_amount` DECIMAL(18,2) COMMENT 'Total contracted spend amount awarded to winning supplier(s) as a result of this sourcing event. Null if event not yet awarded.',
    `baseline_spend_amount` DECIMAL(18,2) COMMENT 'Historical or budgeted spend amount for the commodity or service being sourced, used as the baseline for calculating savings achieved through the event.',
    `bid_opening_date` TIMESTAMP COMMENT 'Date and time when submitted bids are opened and made visible to the evaluation team. For sealed bid events, this is when confidentiality is lifted.',
    `bid_received_count` STRING COMMENT 'Total number of bids or quotes actually submitted by suppliers before the deadline.',
    `bid_submission_deadline` TIMESTAMP COMMENT 'Date and time by which suppliers must submit their bids or quotes. No late submissions accepted after this timestamp.',
    `buyer_email` STRING COMMENT 'Email address of the procurement buyer for supplier inquiries and event correspondence.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `buyer_name` STRING COMMENT 'Full name of the procurement buyer or category manager responsible for this sourcing event.',
    `cancellation_reason` STRING COMMENT 'Reason for cancelling the sourcing event if status is Cancelled. Null for non-cancelled events.',
    `commodity_category` STRING COMMENT 'Procurement commodity category being sourced (e.g., Raw Materials - Dairy, Packaging - Flexible Film, Indirect - MRO). Aligns with spend classification taxonomy.',
    `commodity_subcategory` STRING COMMENT 'Detailed subcategory within the commodity category for granular spend analytics and category management.',
    `contract_end_date` DATE COMMENT 'Expiration date of the contract awarded through this sourcing event. Null if event not yet awarded or contract is open-ended.',
    `contract_start_date` DATE COMMENT 'Effective start date of the contract awarded through this sourcing event. Null if event not yet awarded or does not result in a contract.',
    `contract_term_months` STRING COMMENT 'Duration of the contract resulting from this sourcing event, expressed in months. Null if event does not result in a long-term contract.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this sourcing event record was first created in the source system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this sourcing event (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `evaluation_criteria_lead_time_weight` DECIMAL(18,2) COMMENT 'Percentage weight assigned to lead time and delivery performance in the overall bid evaluation scoring model.',
    `evaluation_criteria_price_weight` DECIMAL(18,2) COMMENT 'Percentage weight assigned to price in the overall bid evaluation scoring model. Part of multi-criteria evaluation framework.',
    `evaluation_criteria_quality_weight` DECIMAL(18,2) COMMENT 'Percentage weight assigned to quality criteria (certifications, audit scores, defect rates) in the overall bid evaluation scoring model.',
    `evaluation_criteria_sustainability_weight` DECIMAL(18,2) COMMENT 'Percentage weight assigned to sustainability commitments and environmental certifications in the overall bid evaluation scoring model.',
    `evaluation_end_date` DATE COMMENT 'Target or actual date when bid evaluation is completed and award decision is finalized.',
    `evaluation_start_date` DATE COMMENT 'Date when the formal evaluation of supplier bids begins, following bid opening.',
    `event_description` STRING COMMENT 'Detailed description of the sourcing event scope, requirements, and objectives. May include technical specifications, quality standards, and delivery expectations.',
    `event_number` STRING COMMENT 'Business identifier for the sourcing event, externally visible and used in communications with suppliers. Typically system-generated in Oracle Cloud Procurement or SAP Ariba.. Valid values are `^[A-Z0-9]{8,20}$`',
    `event_status` STRING COMMENT 'Current lifecycle status of the sourcing event: Draft (being prepared), Published (sent to suppliers), Open (accepting bids), Closed (bid submission ended), Evaluation (scoring bids), Awarded (supplier selected), Cancelled (event terminated). [ENUM-REF-CANDIDATE: Draft|Published|Open|Closed|Evaluation|Awarded|Cancelled — 7 candidates stripped; promote to reference product]',
    `event_title` STRING COMMENT 'Descriptive title of the sourcing event, summarizing the scope and purpose for internal and supplier reference.',
    `event_type` STRING COMMENT 'Type of sourcing event: RFI (Request for Information), RFQ (Request for Quotation), RFP (Request for Proposal), E-Auction, Reverse Auction, or Sealed Bid.. Valid values are `RFI|RFQ|RFP|E-Auction|Reverse Auction|Sealed Bid`',
    `is_multi_year_contract` BOOLEAN COMMENT 'Boolean flag indicating whether the resulting contract spans multiple years (True) or is a single-year or spot buy (False).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this sourcing event record was last updated in the source system.',
    `participating_supplier_count` STRING COMMENT 'Total number of suppliers invited to participate in the sourcing event.',
    `procurement_organization` STRING COMMENT 'Procurement organization or business unit conducting the sourcing event (e.g., North America Procurement, EMEA Procurement, Global Indirect).',
    `published_date` DATE COMMENT 'Date when the sourcing event was published and made available to invited suppliers.',
    `requires_fssc_22000_certification` BOOLEAN COMMENT 'Boolean flag indicating whether suppliers must hold FSSC 22000 certification to be eligible for award. Part of GFSI-recognized food safety standards.',
    `requires_gmp_certification` BOOLEAN COMMENT 'Boolean flag indicating whether suppliers must hold GMP (Good Manufacturing Practice) certification to be eligible for award. Critical for food safety compliance.',
    `savings_amount` DECIMAL(18,2) COMMENT 'Total cost savings achieved through the sourcing event, calculated as baseline spend minus awarded spend. Null if event not yet awarded.',
    `savings_percentage` DECIMAL(18,2) COMMENT 'Percentage savings achieved relative to baseline spend. Calculated as (savings_amount / baseline_spend_amount) * 100.',
    `source_system` STRING COMMENT 'Operational system of record where this sourcing event was created and managed (e.g., Oracle Cloud Procurement, SAP Ariba).. Valid values are `Oracle Cloud Procurement|SAP Ariba|SAP S/4HANA MM|Manual Entry`',
    `source_system_event_code` STRING COMMENT 'Unique identifier of the sourcing event in the source operational system, used for traceability and reconciliation.',
    `tracegains_compliance_required` BOOLEAN COMMENT 'Boolean flag indicating whether suppliers must maintain active compliance documentation in TraceGains (supplier compliance and document management system) to be eligible.',
    CONSTRAINT pk_sourcing_event PRIMARY KEY(`sourcing_event_id`)
) COMMENT 'Strategic sourcing event record capturing RFx activities (RFI, RFQ, RFP) and e-auction events conducted to select or re-qualify suppliers, including all supplier bid/quote responses as line-level detail. Tracks event type, commodity category, participating suppliers, bid submission deadlines, evaluation criteria (price, quality, lead time, sustainability), event status, and award outcome. For each bid: bid reference number, supplier identity, bid submission date, quoted unit price, quoted lead time, MOQ (Minimum Order Quantity), payment terms offered, quality certifications cited, sustainability commitments, bid score against evaluation criteria, rank, and award/reject decision with rationale. Captures total savings achieved vs. baseline spend. Supports category management and spend optimization in Oracle Cloud Procurement and SAP Ariba. This product is the SSOT for both sourcing event execution and individual bid lifecycle management.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`procurement`.`sourcing_bid` (
    `sourcing_bid_id` BIGINT COMMENT 'Unique identifier for the sourcing bid record. Primary key for the sourcing bid entity.',
    `compliance_document_id` BIGINT COMMENT 'Reference to the TraceGains compliance document or specification associated with this bid, if applicable.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Bid creation is performed by a procurement employee; linking supports audit of bid submissions.',
    `rd_project_id` BIGINT COMMENT 'Foreign key linking to research.rd_project. Business justification: Bid evaluation dashboards compare supplier bids against the rd_project requirements; each bid must reference its originating rd_project.',
    `sourcing_event_id` BIGINT COMMENT 'Reference to the parent sourcing event (RFQ, RFP, or e-auction) for which this bid was submitted.',
    `supplier_id` BIGINT COMMENT 'Reference to the supplier who submitted this bid response.',
    `allergen_declaration` STRING COMMENT 'Allergen information declared by the supplier for the quoted ingredient or raw material, critical for food safety compliance.',
    `attachment_count` STRING COMMENT 'Number of supporting documents or attachments (e.g., certifications, technical specifications, compliance documents) submitted with this bid.',
    `award_decision_date` DATE COMMENT 'Date when the award decision was made for this bid line.',
    `award_recommendation_flag` BOOLEAN COMMENT 'Indicates whether this bid is recommended for award based on evaluation criteria and bid scoring.',
    `awarded_quantity` DECIMAL(18,2) COMMENT 'Quantity awarded to the supplier if this bid was selected. Null if bid was not awarded.',
    `bid_notes` STRING COMMENT 'Free-text notes or comments provided by the supplier or procurement team regarding this bid.',
    `bid_reference_number` STRING COMMENT 'External business identifier for the bid, typically assigned by the supplier or procurement system for tracking and audit purposes.',
    `bid_score` DECIMAL(18,2) COMMENT 'Composite score assigned to this bid based on evaluation criteria (price, quality, lead time, sustainability, supplier performance). Used for competitive bid comparison and award decision.',
    `bid_status` STRING COMMENT 'Current lifecycle status of the bid in the sourcing workflow.. Valid values are `draft|submitted|under_review|accepted|rejected|withdrawn`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this bid record was first created in the procurement system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the quoted price (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `delivery_location` STRING COMMENT 'Destination location or facility where the supplier will deliver the item or service.',
    `delivery_score` DECIMAL(18,2) COMMENT 'Score component reflecting the quoted lead time and suppliers on-time delivery performance history.',
    `incoterms` STRING COMMENT 'Incoterms code defining the delivery and risk transfer terms for the quoted item. [ENUM-REF-CANDIDATE: EXW|FCA|CPT|CIP|DAP|DPU|DDP|FAS|FOB|CFR|CIF — 11 candidates stripped; promote to reference product]',
    `last_modified_by_user` STRING COMMENT 'Username or identifier of the user who last modified this bid record in the procurement system.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this bid record was last updated in the procurement system.',
    `line_number` STRING COMMENT 'Sequential line number within the sourcing event identifying which item or service this bid addresses.',
    `moq` DECIMAL(18,2) COMMENT 'Minimum order quantity required by the supplier for this item or service.',
    `moq_unit_of_measure` STRING COMMENT 'Unit of measure for the minimum order quantity (e.g., EA, KG, LB, CS, MT).',
    `payment_terms` STRING COMMENT 'Payment terms offered by the supplier (e.g., Net 30, Net 60, 2/10 Net 30).',
    `price_score` DECIMAL(18,2) COMMENT 'Score component reflecting the competitiveness of the quoted price against evaluation criteria.',
    `quality_certification_codes` STRING COMMENT 'Comma-separated list of quality certifications cited by the supplier (e.g., SQF, GFSI, ISO 9001, HACCP, GMP, FSSC 22000).',
    `quality_score` DECIMAL(18,2) COMMENT 'Score component reflecting the quality certifications, compliance documentation, and quality track record of the supplier.',
    `quoted_lead_time_days` STRING COMMENT 'Number of days the supplier requires to deliver the item or service after order placement.',
    `quoted_unit_price` DECIMAL(18,2) COMMENT 'Unit price quoted by the supplier for the item or service in this bid line.',
    `rejection_reason` STRING COMMENT 'Reason code or description explaining why this bid was rejected, if applicable.',
    `shelf_life_days` STRING COMMENT 'Guaranteed shelf life in days for the quoted ingredient or raw material from date of manufacture.',
    `submission_timestamp` TIMESTAMP COMMENT 'Date and time when the supplier submitted this bid response to the sourcing event.',
    `supplier_contact_email` STRING COMMENT 'Email address of the supplier representative for bid-related communication.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `supplier_contact_name` STRING COMMENT 'Name of the supplier representative who submitted or is responsible for this bid.',
    `supplier_contact_phone` STRING COMMENT 'Phone number of the supplier representative for bid-related communication.',
    `sustainability_commitment_description` STRING COMMENT 'Detailed description of the sustainability commitments or certifications provided by the supplier in this bid.',
    `sustainability_commitment_flag` BOOLEAN COMMENT 'Indicates whether the supplier has committed to sustainability requirements (e.g., carbon neutrality, sustainable sourcing, ethical labor practices) in this bid.',
    `sustainability_score` DECIMAL(18,2) COMMENT 'Score component reflecting the suppliers sustainability commitments and certifications cited in the bid.',
    CONSTRAINT pk_sourcing_bid PRIMARY KEY(`sourcing_bid_id`)
) COMMENT 'Individual supplier bid or quote response submitted in response to a sourcing event (RFQ/RFP/e-auction). Captures bid reference, supplier identity, bid submission date, quoted unit price, quoted lead time, MOQ (Minimum Order Quantity), payment terms offered, quality certifications cited, sustainability commitments, and bid score against evaluation criteria. Enables competitive bid comparison and award decision documentation in Oracle Cloud Procurement.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`procurement`.`spend_transaction` (
    `spend_transaction_id` BIGINT COMMENT 'Unique surrogate identifier for each procurement spend transaction record at the invoice/purchase order (PO) line level in the Silver Layer lakehouse. Primary key for the spend_transaction data product.',
    `account_id` BIGINT COMMENT 'Foreign key linking to customer.account. Business justification: Financial spend reports allocate procurement costs to the customer account that generated the demand, supporting profitability analysis.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Spend transactions must reference the cost center to which the spend is charged, enabling cost center budgeting and performance reporting.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Associates each spend transaction with the GL account for proper ledger posting and regulatory financial reporting.',
    `raw_material_id` BIGINT COMMENT 'Reference to the material or item master record for the raw material, ingredient, packaging, indirect material, or service procured in this transaction. Supports material-level spend analytics and Bill of Materials (BOM) cost analysis.',
    `purchase_contract_id` BIGINT COMMENT 'Reference to the procurement contract or scheduling agreement under which this spend transaction was executed. Enables contract compliance tracking, contracted vs. off-contract spend analysis, and savings realization measurement.',
    `rd_project_id` BIGINT COMMENT 'Foreign key linking to research.rd_project. Business justification: Financial spend analysis by rd_project needs each transaction linked to the project to calculate true R&D cost of goods.',
    `supplier_id` BIGINT COMMENT 'Reference to the supplier (vendor) master record who fulfilled this procurement transaction. Links to the approved vendor list and supplier performance scorecard for spend consolidation and supplier analytics.',
    `contract_price` DECIMAL(18,2) COMMENT 'Negotiated contract price per unit of measure as specified in the procurement contract or scheduling agreement. Used to measure contract compliance and calculate savings vs. contract price.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this spend transaction record was first created or loaded into the Silver Layer lakehouse. Used for data lineage, audit trail, and incremental load tracking.',
    `fiscal_period` STRING COMMENT 'Fiscal accounting period (1–16 in SAP, typically 1–12 for regular periods plus special periods) within the fiscal year to which this spend transaction is attributed. Used for period-over-period spend analysis and monthly close reporting.',
    `fiscal_year` STRING COMMENT 'Four-digit fiscal year to which this spend transaction is attributed based on the posting date and the companys fiscal calendar. Used for year-over-year spend trending, budget vs. actual analysis, and annual savings tracking.',
    `goods_receipt_date` DATE COMMENT 'Date on which the goods or services were physically received and confirmed in the ERP system (SAP MIGO goods receipt or Oracle receiving transaction). Used for three-way match validation, FIFO/FEFO inventory management, and supplier on-time delivery performance.',
    `internal_category_code` STRING COMMENT 'Food Beverage internal commodity category code from the companys proprietary procurement taxonomy (e.g., RAW-ING-DAIRY, PKG-FLEX-FILM, IND-MRO). Used alongside UNSPSC for category management, sourcing strategy, and spend cube construction.',
    `invoice_date` DATE COMMENT 'Date on the supplier invoice document as issued by the vendor. Used for payment terms calculation, aging analysis, and fiscal period assignment. Represents the principal business event date for this spend transaction.',
    `invoice_line_number` STRING COMMENT 'Line item number within the supplier invoice document corresponding to this spend transaction. Supports granular invoice-level spend reconciliation and dispute resolution.',
    `invoice_number` STRING COMMENT 'Supplier-issued invoice document number associated with this spend transaction as recorded in SAP FI or Oracle Cloud Financials. Used for three-way match (PO, goods receipt, invoice) and accounts payable reconciliation.',
    `invoiced_quantity` DECIMAL(18,2) COMMENT 'Quantity of goods or services invoiced by the supplier on this transaction line. Used for unit price validation, purchase price variance (PPV) calculation, and volume-based spend analytics.',
    `is_contract_spend` BOOLEAN COMMENT 'Boolean flag indicating whether this spend transaction was executed under an approved procurement contract (True) or represents off-contract/maverick spend (False). Key metric for contract compliance rate and spend under management reporting.',
    `material_description` STRING COMMENT 'Short descriptive name of the procured material, ingredient, packaging component, or service as defined in the ERP material master. Supports spend reporting without requiring a join to the material master.',
    `material_group_code` STRING COMMENT 'SAP material group or Oracle category code grouping materials by procurement category (e.g., raw ingredients, packaging, MRO, services). Used for spend aggregation, sourcing strategy, and supplier consolidation analysis.',
    `material_number` STRING COMMENT 'ERP-assigned alphanumeric material or item number (SAP material number or Oracle item number) identifying the procured good or service. Used for cross-system reconciliation and spend cube construction.',
    `payment_due_date` DATE COMMENT 'Date by which payment must be made to the supplier to comply with agreed payment terms and avoid late payment penalties. Derived from invoice date and payment terms; stored for accounts payable aging and cash flow management.',
    `payment_terms_code` STRING COMMENT 'ERP payment terms code (e.g., NET30, 2/10NET30) defining the due date and any early payment discount conditions for this invoice. Used for cash flow forecasting, dynamic discounting, and working capital optimization.',
    `plant_code` STRING COMMENT 'SAP plant or Oracle organization code identifying the manufacturing facility, distribution center (DC), or business unit that received the goods or services and is accountable for the spend. Key dimension for plant-level spend analytics.',
    `po_line_number` STRING COMMENT 'Sequential line item number within the purchase order document identifying the specific goods or services line that generated this spend transaction. Enables granular PO line-level spend analysis.',
    `po_number` STRING COMMENT 'Externally-known purchase order document number from the source ERP system (SAP S/4HANA MM or Oracle Cloud Procurement) that authorizes the procurement spend. Used to trace spend back to the originating PO.',
    `posting_date` DATE COMMENT 'Date on which the spend transaction was posted to the general ledger in the ERP system. Determines the fiscal period and accounting period to which the spend is attributed. May differ from invoice date due to accruals or late processing.',
    `ppv_amount` DECIMAL(18,2) COMMENT 'Purchase Price Variance (PPV) amount calculated as the difference between the actual invoice price and the standard cost, multiplied by the invoiced quantity. Positive PPV indicates overspend vs. standard; negative indicates savings. Key metric for procurement performance and COGS management.',
    `purchasing_group_code` STRING COMMENT 'SAP purchasing group code identifying the buyer or procurement team responsible for this transaction. Used for buyer-level spend analytics, workload management, and procurement performance reporting.',
    `purchasing_org_code` STRING COMMENT 'SAP purchasing organization or Oracle procurement business unit code responsible for negotiating and managing the procurement of this transaction. Used for spend analytics by procurement organization and category management accountability.',
    `quantity_uom` STRING COMMENT 'Unit of measure for the invoiced quantity (e.g., KG, LB, L, EA, CS, MT). Required for accurate spend-per-unit analysis, minimum order quantity (MOQ) compliance, and cross-supplier price benchmarking.',
    `source_document_type` STRING COMMENT 'ERP document type code identifying the accounting document category for this spend transaction (e.g., SAP document types: RE=Invoice Receipt, KR=Vendor Invoice, KG=Vendor Credit Memo, KA=Vendor Document). Used for spend classification and financial reconciliation.. Valid values are `RE|KR|KG|KA|ZP|STANDARD`',
    `source_system` STRING COMMENT 'Identifier of the operational system of record from which this spend transaction was sourced (SAP S/4HANA FI/CO, Oracle Cloud Financials, or manual entry). Required for data lineage, reconciliation, and audit trail in the Silver Layer lakehouse.. Valid values are `SAP_S4HANA|ORACLE_CLOUD|MANUAL`',
    `spend_amount` DECIMAL(18,2) COMMENT 'Gross spend amount for this procurement transaction line in the transaction currency as invoiced by the supplier. Represents the actual purchase price multiplied by the invoiced quantity before any discounts or adjustments. Core metric for spend analytics and category management.',
    `spend_amount_local` DECIMAL(18,2) COMMENT 'Spend amount converted to the company code local currency (e.g., USD for US entities) using the exchange rate at the time of posting. Enables consistent spend aggregation and reporting across multi-currency procurement transactions.',
    `spend_classification` STRING COMMENT 'High-level classification of the procurement spend indicating whether it is direct (raw materials, ingredients, packaging used in finished goods), indirect (MRO, services, overhead), capital expenditure (capex), or operating expenditure (opex). Critical dimension for spend analytics and financial reporting.. Valid values are `direct|indirect|capex|opex`',
    `standard_cost` DECIMAL(18,2) COMMENT 'Standard cost per unit of measure for the material as defined in the ERP cost master (SAP CK11N standard cost estimate or Oracle standard cost). Used as the baseline for purchase price variance (PPV) calculation and COGS analysis.',
    `transaction_currency` STRING COMMENT 'Three-letter ISO 4217 currency code of the currency in which the supplier invoice was issued (e.g., USD, EUR, GBP). Required for multi-currency spend analytics and foreign exchange exposure reporting.. Valid values are `^[A-Z]{3}$`',
    `transaction_status` STRING COMMENT 'Current workflow status of the spend transaction in the source ERP system. Posted indicates the invoice is fully approved and posted to the general ledger; reversed indicates a reversal entry; blocked indicates a payment block; parked indicates a pending document; cleared indicates the payment has been made.. Valid values are `posted|reversed|blocked|parked|cleared`',
    `unit_price` DECIMAL(18,2) COMMENT 'Actual price per unit of measure paid to the supplier on this transaction as invoiced, in the transaction currency. Used for purchase price variance (PPV) calculation against standard cost and contract price benchmarking.',
    `unspsc_code` STRING COMMENT 'Eight-digit United Nations Standard Products and Services Code (UNSPSC) classifying the procured commodity or service into a standardized global taxonomy. Enables cross-supplier, cross-category spend benchmarking and category management.. Valid values are `^[0-9]{8}$`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this spend transaction record was last modified or refreshed in the Silver Layer lakehouse. Used for change data capture (CDC), incremental processing, and audit trail.',
    CONSTRAINT pk_spend_transaction PRIMARY KEY(`spend_transaction_id`)
) COMMENT 'Granular procurement spend transaction record capturing actual purchase spend at the invoice/PO line level for spend analytics and category management. Attributes include supplier, commodity category (UNSPSC or internal taxonomy), material group classification, plant/cost center, spend amount, currency, fiscal period, spend classification (direct/indirect, capex/opex), and purchase price variance vs. standard cost. Feeds spend cube for category management, supplier consolidation, savings tracking, and PPV analysis. Sourced from SAP FI/CO and Oracle Cloud Financials.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`procurement`.`purchase_requisition` (
    `purchase_requisition_id` BIGINT COMMENT 'Unique identifier for the purchase requisition record. Primary key.',
    `employee_id` BIGINT COMMENT 'Identifier of the employee who approved the purchase requisition, typically a manager or procurement officer.',
    `demand_plan_id` BIGINT COMMENT 'Foreign key linking to supply.demand_plan. Business justification: Demand‑driven purchase requisitions are generated from the demand plan; linking enables automated requisition creation per plan.',
    `primary_purchase_requestor_employee_id` BIGINT COMMENT 'Identifier of the employee who created or submitted the purchase requisition.',
    `rd_project_id` BIGINT COMMENT 'Foreign key linking to research.rd_project. Business justification: Requisition approval workflow includes the rd_project that originated the request, enabling the requisition‑to‑project audit trail.',
    `supplier_id` BIGINT COMMENT 'Identifier of the preferred or suggested supplier for this purchase requisition, if specified by the requestor.',
    `approval_date` DATE COMMENT 'Date when the purchase requisition was approved by the designated approver.',
    `approval_workflow_code` STRING COMMENT 'Identifier of the approval workflow instance governing this purchase requisition, tracking routing and approval steps.. Valid values are `^[A-Z0-9]{8,16}$`',
    `contract_number` STRING COMMENT 'Reference to an existing procurement contract or pricing agreement that governs this requisition, if applicable.. Valid values are `^[A-Z0-9]{10,20}$`',
    `conversion_date` DATE COMMENT 'Date when the purchase requisition was converted to a purchase order.',
    `cost_center_code` STRING COMMENT 'Cost center to which the purchase requisition expense will be charged for financial accounting and budget tracking.. Valid values are `^[A-Z0-9]{10}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the purchase requisition record was first created in the source system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the estimated value (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `delivery_address` STRING COMMENT 'Full delivery address where the materials or services should be delivered, if different from the plant default address.',
    `estimated_total_value` DECIMAL(18,2) COMMENT 'Total estimated value of the purchase requisition, calculated as quantity requested multiplied by estimated unit price.',
    `estimated_unit_price` DECIMAL(18,2) COMMENT 'Estimated price per unit of measure for the requested material or service, used for budgeting and approval workflows.',
    `general_ledger_account` STRING COMMENT 'General ledger account number to which the procurement expense will be posted in the financial system.. Valid values are `^[0-9]{6,10}$`',
    `is_deleted` BOOLEAN COMMENT 'Boolean flag indicating whether the purchase requisition has been logically deleted or marked for archival.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the purchase requisition record was last updated or modified.',
    `material_description` STRING COMMENT 'Short text description of the material, ingredient, packaging, or service being requested.',
    `material_group_code` STRING COMMENT 'Classification code grouping similar materials for procurement, planning, and reporting purposes (e.g., raw materials, packaging, indirect materials).. Valid values are `^[A-Z0-9]{4,8}$`',
    `material_number` STRING COMMENT 'Unique identifier for the material, ingredient, or packaging item being requisitioned. Corresponds to SAP material master.. Valid values are `^[A-Z0-9]{8,18}$`',
    `plant_code` STRING COMMENT 'Four-character code identifying the manufacturing plant, distribution center, or facility where the materials or services are required.. Valid values are `^[A-Z0-9]{4}$`',
    `priority_level` STRING COMMENT 'Priority classification of the purchase requisition indicating urgency of procurement need.. Valid values are `low|medium|high|urgent`',
    `procurement_category` STRING COMMENT 'High-level category classifying the type of procurement: raw materials, ingredients, packaging, indirect materials, services, or capital equipment.. Valid values are `raw_material|ingredient|packaging|indirect_material|service|capital_equipment`',
    `purchase_order_number` STRING COMMENT 'Purchase order number to which this requisition has been converted, if the conversion has occurred.. Valid values are `^[A-Z0-9]{10}$`',
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

CREATE OR REPLACE TABLE `food_beverage_ecm`.`procurement`.`category_strategy` (
    `category_strategy_id` BIGINT COMMENT 'Unique surrogate identifier for the procurement category strategy record. Primary key for the category_strategy data product in the Silver Layer lakehouse.',
    `allergen_relevance` BOOLEAN COMMENT 'Indicates whether this procurement category includes materials that are or may contain regulated allergens (e.g., dairy, tree nuts, wheat, soy, peanuts). When true, suppliers must provide allergen declarations and the category is subject to enhanced TraceGains specification management and FDA allergen labeling compliance.',
    `annual_savings_target_usd` DECIMAL(18,2) COMMENT 'Targeted procurement savings in US dollars for this category in the current strategy period. Represents the expected reduction in total cost of ownership (TCO) through sourcing initiatives, negotiations, and demand management. Feeds into annual procurement planning and EBITDA improvement targets.',
    `annual_spend_usd` DECIMAL(18,2) COMMENT 'Total annual procurement spend for this category in US dollars, based on the most recently completed fiscal year. Used to size the category, prioritize sourcing investment, and calculate savings targets. Classified confidential as it reveals commercial spend positioning.',
    `approved_supplier_target_count` STRING COMMENT 'Target number of approved suppliers to maintain on the Approved Vendor List (AVL) for this category. Balances supply security with supplier relationship management investment. Reviewed annually during strategic sourcing planning.',
    `business_unit_owner` STRING COMMENT 'Name or code of the primary business unit or division that owns and sponsors this category strategy (e.g., Snacks BU, Beverages BU, Dairy BU, Supply Chain). Supports category strategy alignment with business unit P&L and procurement planning.',
    `category_code` STRING COMMENT 'Externally-known alphanumeric code uniquely identifying the procurement category (e.g., DAIRY-ING, GRAIN-OIL, FLEX-PKG, CO-MFG, MRO). Sourced from SAP S/4HANA MM purchasing category hierarchy and used as the business key across ERP and sourcing systems.. Valid values are `^[A-Z0-9_-]{3,20}$`',
    `category_level` STRING COMMENT 'Numeric level of this category within the procurement category hierarchy (e.g., 1 = top-level segment, 2 = category, 3 = sub-category). Supports hierarchical drill-down in spend analytics and category management dashboards.',
    `category_manager_email` STRING COMMENT 'Corporate email address of the procurement category manager. Used for workflow notifications, strategy review communications, and stakeholder escalation. Classified confidential as it is an employee contact identifier.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `category_manager_name` STRING COMMENT 'Full name of the procurement category manager responsible for owning and executing this category strategy. Used for accountability, escalation routing, and category management reporting. Sourced from Workday HCM employee master.',
    `category_name` STRING COMMENT 'Full descriptive name of the procurement category (e.g., Dairy Ingredients, Grain and Oilseed Commodities, Flexible Packaging, Co-Manufacturing Services, Maintenance Repair and Operations). Used in category management reporting and strategic sourcing planning.',
    `commodity_type` STRING COMMENT 'Classification of the category by commodity type. agricultural_commodity = exchange-traded raw materials (grains, dairy, oils); industrial_commodity = packaging materials, chemicals; manufactured_input = processed ingredients, co-pack services; service = logistics, co-manufacturing; indirect = MRO, facilities, IT. Drives hedging eligibility and pricing contract structure.. Valid values are `agricultural_commodity|industrial_commodity|manufactured_input|service|indirect`',
    `contract_duration_months` STRING COMMENT 'Target contract duration in months for supplier agreements in this category. Informs negotiation strategy and contract renewal planning. Typical ranges: 12 months for commodity categories, 24–36 months for strategic categories with capital investment requirements.',
    `contract_type` STRING COMMENT 'Preferred commercial contract structure for this category. spot = transactional market pricing; annual_fixed = fixed price for 12-month period; multi_year = fixed or structured pricing over 2+ years; index_linked = price tied to commodity index (e.g., USDA, CBOT); cost_plus = supplier cost transparency with agreed margin. Drives contract strategy in SAP S/4HANA MM purchasing contracts.. Valid values are `spot|annual_fixed|multi_year|index_linked|cost_plus`',
    `dual_source_split_pct` DECIMAL(18,2) COMMENT 'Target volume allocation percentage to the primary supplier when a dual-source policy is in effect (0.00–100.00%). For example, 70.00 means 70% to primary supplier and 30% to secondary. Null when supply_base_policy is single_source or multi_source. Supports supply continuity risk management.',
    `effective_from` DATE COMMENT 'Date from which this category strategy version becomes binding and operational. Aligns with the annual procurement planning cycle start date (typically fiscal year start).',
    `effective_until` DATE COMMENT 'Date on which this category strategy version expires or is scheduled for renewal. Nullable for open-ended strategies. Triggers review workflow when approaching expiry.',
    `ethical_sourcing_standard` STRING COMMENT 'Ethical sourcing and labor standards audit framework required for suppliers in this category. sedex = Supplier Ethical Data Exchange; smeta = Sedex Members Ethical Trade Audit; bsci = Business Social Compliance Initiative; sa8000 = Social Accountability International; custom = company-specific standard; none = not applicable. Supports responsible sourcing programs.. Valid values are `none|sedex|smeta|bsci|sa8000|custom`',
    `food_safety_requirement` STRING COMMENT 'Minimum food safety certification or standard required for suppliers in this category. gmp = Good Manufacturing Practice; haccp = Hazard Analysis Critical Control Points; gfsi = Global Food Safety Initiative benchmarked scheme; sqf = Safe Quality Food; fssc22000 = Food Safety System Certification 22000. Mandatory for direct food ingredient and packaging categories. Managed via TraceGains supplier compliance.. Valid values are `none|gmp|haccp|gfsi|sqf|fssc22000`',
    `geographic_sourcing_scope` STRING COMMENT 'Geographic scope of the approved supply base for this category. domestic = suppliers within the home country only; regional = suppliers within a defined trade region; global = worldwide supplier base; preferred_domestic = global scope with preference for domestic suppliers. Impacts trade compliance, tariff exposure, and supply chain resilience.. Valid values are `domestic|regional|global|preferred_domestic`',
    `hedge_coverage_target_pct` DECIMAL(18,2) COMMENT 'Target percentage of forecasted commodity volume to be covered by hedging instruments (0.00–100.00%). For example, 75.00 means 75% of projected annual volume should be hedged. Supports COGS risk management and financial planning. Classified confidential as it reveals pricing risk posture.',
    `hedging_strategy` STRING COMMENT 'Commodity price risk management strategy applied to this category. no_hedge = market price accepted; forward_contract = fixed-price forward purchase agreements; futures = exchange-traded futures contracts (e.g., CBOT corn, CME dairy); options = price floor/ceiling options; index_pricing = contract pricing linked to published commodity index (e.g., USDA dairy price). Critical for COGS stability in food and beverage manufacturing.. Valid values are `no_hedge|forward_contract|futures|options|index_pricing`',
    `innovation_priority` STRING COMMENT 'Priority level assigned to supplier-led innovation and co-development activities for this category. high = active joint innovation programs with key suppliers (e.g., new ingredient technologies, sustainable packaging); medium = innovation considered in supplier reviews; low = transactional category with no formal innovation agenda. Supports NPD and R&D pipeline.. Valid values are `low|medium|high`',
    `kraljic_quadrant` STRING COMMENT 'Strategic classification of the procurement category using the Kraljic Portfolio Matrix. strategic = high spend impact, high supply risk (e.g., specialty dairy cultures); leverage = high spend impact, low supply risk (e.g., commodity grains); bottleneck = low spend impact, high supply risk (e.g., proprietary flavors); non_critical = low spend impact, low supply risk (e.g., general MRO). Drives sourcing strategy and supplier relationship investment.. Valid values are `strategic|leverage|bottleneck|non_critical`',
    `last_review_date` DATE COMMENT 'Date on which this category strategy was most recently formally reviewed and updated. Used to track review cadence compliance and identify overdue strategy refreshes.',
    `lead_time_target_days` STRING COMMENT 'Target supplier lead time in calendar days from purchase order placement to delivery at the receiving DC or plant. Used in supply planning, safety stock policy design, and supplier SLA negotiations. Feeds into JDA/Blue Yonder supply planning parameters.',
    `moq_policy` STRING COMMENT 'Policy governing Minimum Order Quantity (MOQ) requirements for this category. not_applicable = no MOQ constraints; supplier_standard = accept supplier-defined MOQs; negotiated = MOQs are negotiated as part of sourcing strategy; waived = MOQs formally waived in contract. Impacts inventory planning and working capital.. Valid values are `not_applicable|supplier_standard|negotiated|waived`',
    `next_review_date` DATE COMMENT 'Date on which the next formal review of this category strategy is scheduled. Calculated from last_review_date and review_frequency. Triggers workflow notifications to the category manager and procurement leadership.',
    `parent_category_code` STRING COMMENT 'Code of the parent category in the procurement category hierarchy, enabling multi-level category tree structures (e.g., INGREDIENTS as parent of DAIRY-ING). Supports roll-up spend analytics and hierarchical category reporting.. Valid values are `^[A-Z0-9_-]{3,20}$`',
    `payment_term_days` STRING COMMENT 'Standard payment term in days (net days) targeted for supplier contracts in this category (e.g., 30, 45, 60, 90). Longer payment terms improve working capital and cash conversion cycle. Negotiated as part of category sourcing strategy and reflected in SAP S/4HANA FI payment terms.',
    `preferred_incoterm` STRING COMMENT 'Preferred International Commercial Terms (Incoterms 2020) for supplier contracts in this category, defining the transfer of risk and responsibility for freight, insurance, and customs. Common food and beverage terms: FOB (Free on Board) for bulk commodities, DDP (Delivered Duty Paid) for finished ingredients. Impacts landed cost and supply chain risk allocation. [ENUM-REF-CANDIDATE: EXW|FCA|CPT|CIP|DAP|DPU|DDP|FAS|FOB|CFR|CIF — 11 candidates stripped; promote to reference product]',
    `review_frequency` STRING COMMENT 'Frequency at which this category strategy is formally reviewed and refreshed. Strategic and bottleneck categories typically require quarterly reviews; leverage and non-critical categories may be reviewed annually. Drives the procurement planning calendar.. Valid values are `monthly|quarterly|semi_annual|annual`',
    `savings_target_pct` DECIMAL(18,2) COMMENT 'Targeted procurement savings as a percentage of total annual category spend (0.00–100.00%). Provides a normalized savings ambition metric that enables cross-category comparison regardless of absolute spend size. Supports annual procurement planning cycles.',
    `sourcing_approach` STRING COMMENT 'Primary sourcing methodology applied to this category. competitive_bid = formal RFP/RFQ process; negotiated = direct negotiation with preferred suppliers; sole_source = single qualified supplier; consortium = industry buying group; spot_buy = open market transactional purchasing. Informs procurement execution strategy.. Valid values are `competitive_bid|negotiated|sole_source|consortium|spot_buy`',
    `spend_impact_rating` STRING COMMENT 'Assessed financial impact level of this category on total procurement spend and COGS. Used as one of the two axes in the Kraljic Matrix positioning. Combined with supply_risk_rating to determine the Kraljic quadrant classification.. Valid values are `low|medium|high|critical`',
    `spend_under_management_pct` DECIMAL(18,2) COMMENT 'Percentage of total category spend that is actively managed under formal procurement contracts and sourcing agreements (0.00–100.00%). A key procurement maturity KPI. Higher percentages indicate stronger category governance and compliance. Classified confidential as it reveals procurement control posture.',
    `strategy_approved_date` DATE COMMENT 'Date on which this version of the category strategy was formally approved by procurement leadership or the category governance board. Marks the transition from approved to active status in the strategy lifecycle.',
    `strategy_notes` STRING COMMENT 'Free-text field for additional strategic context, rationale, market intelligence, or special considerations relevant to this category strategy (e.g., market disruption notes, regulatory changes, geopolitical risk commentary). Supports category manager documentation and knowledge management.',
    `strategy_status` STRING COMMENT 'Current lifecycle status of the category strategy record. draft indicates the strategy is being developed; active means it is approved and in execution; under_review indicates a scheduled refresh cycle; approved means formally signed off pending activation; archived means superseded by a newer strategy version.. Valid values are `draft|active|under_review|approved|archived`',
    `strategy_version` STRING COMMENT 'Version identifier for the category strategy document (e.g., v1.0, v2.3). Supports version control and audit trail for strategy evolution across annual procurement planning cycles.. Valid values are `^vd+.d+$`',
    `supply_base_policy` STRING COMMENT 'Approved supply base policy for this category defining whether the business maintains a single, dual, or multiple qualified suppliers. Dual/multi-source policies mitigate supply continuity risk for critical ingredients and packaging materials.. Valid values are `single_source|dual_source|multi_source`',
    `supply_risk_rating` STRING COMMENT 'Assessed supply continuity risk level for this category based on factors including supplier concentration, geographic concentration, commodity volatility, regulatory exposure, and lead time. Drives risk mitigation actions and safety stock policy. Reviewed at minimum annually.. Valid values are `low|medium|high|critical`',
    `sustainability_certification_required` STRING COMMENT 'Specific third-party sustainability certification standard required for suppliers in this category when sustainability_requirement is certified (e.g., Rainforest Alliance, RSPO, Fair Trade, SBTi, GFSI, Organic USDA). Null when no certification is required. Supports TraceGains supplier compliance document management.',
    `sustainability_requirement` STRING COMMENT 'Level of sustainability and ethical sourcing requirement applied to suppliers in this category. none = no formal requirement; preferred = sustainability criteria considered in sourcing decisions; required = mandatory sustainability standards in supplier contracts; certified = third-party certification required (e.g., Rainforest Alliance, RSPO, Fair Trade, SBTi). Supports ESG reporting and ISO 20400 compliance.. Valid values are `none|preferred|required|certified`',
    CONSTRAINT pk_category_strategy PRIMARY KEY(`category_strategy_id`)
) COMMENT 'Procurement category strategy record defining the sourcing approach, supply base targets, risk posture, and savings objectives for each procurement category (e.g., dairy ingredients, grain/oilseed commodities, flexible packaging, co-manufacturing services, MRO). Captures category name, strategic classification (Kraljic quadrant positioning), number of approved suppliers target, dual/single source policy, commodity hedging strategy, sustainability and ethical sourcing requirements, annual savings target, and category manager ownership. Supports category management, strategic sourcing planning, and annual procurement planning cycles.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`procurement`.`supplier_risk` (
    `supplier_risk_id` BIGINT COMMENT 'Unique system-generated identifier for the supplier risk assessment record. Primary key for this entity.',
    `compliance_document_id` BIGINT COMMENT 'Reference identifier for the associated supplier compliance document, audit report, or specification record stored in TraceGains. Links the risk record to supporting evidence in the supplier compliance document management system.',
    `supplier_id` BIGINT COMMENT 'Reference to the supplier master record against which this risk is assessed.',
    `purchase_contract_id` BIGINT COMMENT 'Reference to the procurement contract or raw material pricing contract associated with this supplier risk. Enables linkage between risk exposure and contractual protections or obligations.',
    `rd_project_id` BIGINT COMMENT 'Foreign key linking to research.rd_project. Business justification: R&D risk assessment report requires mapping supplier risk entries to the rd_project that depends on the supplier.',
    `annual_spend` DECIMAL(18,2) COMMENT 'Total annual procurement spend with this supplier in the reporting currency, used to contextualize the financial significance of the risk and prioritize mitigation investment. Sourced from SAP S/4HANA spend analytics.',
    `approved_vendor_list_status` STRING COMMENT 'Current status of the supplier on the Approved Vendor List (AVL) at the time of risk assessment. A risk event may trigger a change from approved to conditional or suspended status. Aligns with TraceGains supplier qualification workflows.. Valid values are `approved|conditional|suspended|disqualified`',
    `audit_finding_reference` STRING COMMENT 'Reference number or identifier linking this risk record to a specific supplier audit finding, non-conformance report (NCR), or corrective action request (CAR) from a GMP, SQF, or GFSI audit.',
    `contingency_lead_time_days` STRING COMMENT 'Estimated number of days required to activate and onboard the contingency supplier and resume supply in the event the primary supplier fails. Used in business continuity planning and safety stock calculations.',
    `country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code for the suppliers primary operating country, used for regulatory jurisdiction mapping (FDA, EFSA, USDA) and trade compliance assessments.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this supplier risk record was first created in the system. Supports audit trail, data lineage, and compliance reporting requirements.',
    `estimated_financial_exposure` DECIMAL(18,2) COMMENT 'Estimated monetary value of the business impact if the risk event materializes, expressed in the reporting currency. Includes potential supply disruption costs, expediting fees, reformulation costs, and lost revenue. Used in risk prioritization and EBITDA impact analysis.',
    `exposure_currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the estimated_financial_exposure amount (e.g., USD, EUR, GBP). Supports multi-currency risk reporting.. Valid values are `^[A-Z]{3}$`',
    `financial_stability_rating` STRING COMMENT 'External or internally-assessed financial stability rating for the supplier (e.g., Dun & Bradstreet PAYDEX, credit rating agency score, or internal procurement rating). Indicates risk of supplier insolvency or financial distress impacting supply continuity.',
    `food_safety_risk_flag` BOOLEAN COMMENT 'Indicates whether this risk record involves a food safety dimension, including HACCP critical control point failures, allergen cross-contamination risk, microbiological contamination (CFU exceedance), or GMP non-compliance. Triggers mandatory escalation per FSMA and GFSI protocols.',
    `fsma_verification_required` BOOLEAN COMMENT 'Indicates whether this risk triggers a mandatory FSMA Foreign Supplier Verification Program (FSVP) or domestic supplier verification activity under 21 CFR Part 117. True = verification activity required.',
    `geopolitical_region` STRING COMMENT 'Geographic region or country (ISO 3166-1 alpha-3 code) where the supplier operates, used to assess geopolitical, trade, and climate-related risk exposure for agricultural commodities and raw material sourcing.',
    `identified_date` DATE COMMENT 'Calendar date on which the supplier risk was first formally identified and logged in the risk register. Used for aging analysis and risk trend reporting.',
    `impact_score` STRING COMMENT 'Numeric score (1–5) representing the assessed severity of business impact if the risk event materializes. 1 = negligible, 5 = catastrophic. Considers supply disruption, financial loss, food safety, and regulatory exposure.',
    `is_single_source` BOOLEAN COMMENT 'Indicates whether this supplier is the sole approved source for the associated material or ingredient, creating a single-source dependency risk. True = single source; False = multiple qualified sources exist. Critical for business continuity planning.',
    `last_review_date` DATE COMMENT 'Date of the most recent formal review of this supplier risk record, including reassessment of likelihood, impact, and mitigation effectiveness.',
    `likelihood_score` STRING COMMENT 'Numeric score (1–5) representing the assessed probability that the identified risk event will materialize within the review horizon. 1 = rare, 5 = almost certain. Used in risk matrix calculations.',
    `mitigation_completed_date` DATE COMMENT 'Actual date on which the mitigation strategy was fully executed and verified. Compared against mitigation_target_date to measure timeliness of risk treatment.',
    `mitigation_status` STRING COMMENT 'Current execution status of the mitigation strategy for this risk. Tracks whether corrective or preventive actions have been initiated, are in progress, completed, or placed on hold.. Valid values are `not_started|in_progress|completed|on_hold`',
    `mitigation_strategy` STRING COMMENT 'Documented strategy to reduce or eliminate the identified risk, including actions such as dual-sourcing, safety stock build, supplier development programs, contractual protections, or regulatory corrective action plans.',
    `mitigation_target_date` DATE COMMENT 'Target completion date for the mitigation strategy actions. Used to track on-time execution of risk treatment plans and escalate overdue mitigations.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next formal review of this supplier risk record. Drives review calendar workflows and ensures timely reassessment of high and critical risks.',
    `regulatory_compliance_risk_flag` BOOLEAN COMMENT 'Indicates whether this risk involves a regulatory compliance dimension, such as FDA labeling violations, USDA inspection failures, EFSA authorization issues, or FSSC 22000 certification lapses. Triggers compliance review workflows.',
    `residual_risk_rating` STRING COMMENT 'Risk rating remaining after mitigation actions have been applied. Represents the accepted level of risk exposure post-treatment. Distinct from risk_rating which reflects the inherent (pre-mitigation) risk level.. Valid values are `high|medium|low|critical`',
    `risk_category` STRING COMMENT 'Broader business category grouping for the risk, used for portfolio-level risk reporting and supply chain resilience dashboards. Distinct from risk_type which captures the specific risk driver.. Valid values are `supply_continuity|quality_compliance|financial|environmental|reputational|operational`',
    `risk_closed_date` DATE COMMENT 'Date on which the risk was formally closed, either through successful mitigation, risk acceptance, or supplier disqualification. Null if the risk remains open.',
    `risk_description` STRING COMMENT 'Detailed narrative description of the identified risk, including the specific risk event, root cause drivers, and potential business consequences. Authored by the procurement risk analyst.',
    `risk_open_date` DATE COMMENT 'Date on which the risk record was formally opened and entered into the active risk register. May differ from identified_date if there is a lag between identification and formal registration.',
    `risk_owner` STRING COMMENT 'Name or employee identifier of the procurement professional or category manager accountable for monitoring and managing this supplier risk. Aligns with risk ownership principles in ISO 31000.',
    `risk_rating` STRING COMMENT 'Overall risk rating assigned to this supplier risk record following assessment. Drives escalation workflows, mitigation prioritization, and business continuity planning. Values: critical, high, medium, low.. Valid values are `high|medium|low|critical`',
    `risk_reference_number` STRING COMMENT 'Externally-known alphanumeric identifier for the risk record, used in cross-functional communications, audit trails, and regulatory submissions. Format: SR-{YYYY}-{NNNNNN}.. Valid values are `^SR-[0-9]{4}-[0-9]{6}$`',
    `risk_reviewer` STRING COMMENT 'Name or employee identifier of the individual who conducted the most recent risk review or assessment. Distinct from risk_owner who holds ongoing accountability.',
    `risk_score` STRING COMMENT 'Composite risk score derived from the product of likelihood_score and impact_score (range 1–25). Stored as a business-assessed value at the time of review; not dynamically recalculated. Supports risk prioritization and heat map reporting.',
    `risk_status` STRING COMMENT 'Current lifecycle state of the supplier risk record. Tracks progression from initial identification through mitigation, acceptance, or closure. Drives workflow routing in procurement risk management processes.. Valid values are `identified|under_review|mitigated|accepted|closed|escalated`',
    `risk_type` STRING COMMENT 'Classification of the risk category associated with the supplier. Covers geopolitical instability, financial stability of the supplier, food safety and HACCP compliance failures, single-source dependency exposure, climate or weather-driven agricultural commodity risk, and regulatory compliance risk (FDA, FSMA, EFSA). [ENUM-REF-CANDIDATE: geopolitical|financial_stability|food_safety|single_source_dependency|climate_weather|regulatory_compliance — promote to reference product]. Valid values are `geopolitical|financial_stability|food_safety|single_source_dependency|climate_weather|regulatory_compliance`',
    `supply_category` STRING COMMENT 'Procurement spend category or commodity group associated with this risk (e.g., raw ingredients, packaging materials, indirect services, agricultural commodities). Aligns with the procurement category hierarchy in SAP S/4HANA MM.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to this supplier risk record. Used for change tracking, incremental data loads in the Databricks Silver Layer, and audit compliance.',
    CONSTRAINT pk_supplier_risk PRIMARY KEY(`supplier_risk_id`)
) COMMENT 'Supplier risk assessment record capturing identified risks associated with specific suppliers or supply categories — including geopolitical risk, single-source dependency, financial stability risk, food safety risk, climate/weather risk for agricultural commodities, and regulatory compliance risk. Tracks risk type, risk rating (high/medium/low), likelihood, impact score, mitigation strategy, contingency supplier identified, and risk review date. Supports supply chain resilience and business continuity planning.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`procurement`.`supplier_approval` (
    `supplier_approval_id` BIGINT COMMENT 'Primary key for the SupplierApproval association',
    `raw_material_id` BIGINT COMMENT 'Foreign key linking to the raw material',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to the supplier',
    `approval_date` DATE COMMENT 'Date when the supplier was approved for the raw material',
    `approval_status` STRING COMMENT 'Current approval state of the supplier for the raw material (e.g., Approved, Pending, Revoked)',
    CONSTRAINT pk_supplier_approval PRIMARY KEY(`supplier_approval_id`)
) COMMENT 'Represents the approval relationship between a raw material and a supplier. Each record tracks which supplier is approved for which raw material, including approval status and date.. Existence Justification: In procurement, each raw material can be approved for multiple suppliers, and each supplier can be approved for multiple raw materials. The approved‑supplier list is actively managed, with status and approval dates recorded for each raw material‑supplier pairing.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`procurement`.`sustainability_partnership` (
    `sustainability_partnership_id` BIGINT COMMENT 'Primary key for the sustainability_partnership association',
    `initiative_id` BIGINT COMMENT 'Links to the sustainability initiative',
    `supplier_id` BIGINT COMMENT 'Links to the supplier participating in the initiative',
    `partner_contact_name` STRING COMMENT 'Contact person responsible for the partnership on the supplier side',
    `partner_organization` STRING COMMENT 'Name of the suppliers organization as recorded for the partnership',
    `partner_type` STRING COMMENT 'Role of the supplier in the initiative (e.g., primary supplier, co‑partner)',
    CONSTRAINT pk_sustainability_partnership PRIMARY KEY(`sustainability_partnership_id`)
) COMMENT 'Represents the participation of a supplier in a sustainability initiative, capturing partnership details that are not intrinsic to either the supplier or the initiative.. Existence Justification: Suppliers are actively enrolled in multiple sustainability initiatives, and each initiative aggregates many suppliers. The partnership is managed as a distinct business entity that records the suppliers role, organization, and contact details for each initiative.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`procurement`.`supply_agreement` (
    `supply_agreement_id` BIGINT COMMENT 'Primary key for the SupplyAgreement association',
    `spare_part_id` BIGINT COMMENT 'Foreign key linking to the spare part',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to the supplier',
    `contract_terms` STRING COMMENT 'Textual description of contractual terms (payment, warranty, etc.) for this supplier‑part pair',
    `lead_time_days` STRING COMMENT 'Lead time in days specific to this supplier‑part contract',
    `unit_price` DECIMAL(18,2) COMMENT 'Agreed price per unit for this supplier‑part combination',
    CONSTRAINT pk_supply_agreement PRIMARY KEY(`supply_agreement_id`)
) COMMENT 'Represents the contractual relationship between a procurement supplier and a maintenance spare part. Each record captures the specific terms under which a supplier provides a particular spare part.. Existence Justification: A supplier can provide many spare parts, and a spare part can be sourced from multiple suppliers. Each supplier‑part pairing is actively managed with its own unit price, lead time, and contract terms, forming a distinct business entity that users create, update, and delete.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_site` ADD CONSTRAINT `fk_procurement_supplier_site_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `food_beverage_ecm`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `food_beverage_ecm`.`procurement`.`approved_vendor_list` ADD CONSTRAINT `fk_procurement_approved_vendor_list_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `food_beverage_ecm`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_category_strategy_id` FOREIGN KEY (`category_strategy_id`) REFERENCES `food_beverage_ecm`.`procurement`.`category_strategy`(`category_strategy_id`);
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
ALTER TABLE `food_beverage_ecm`.`procurement`.`compliance_document` ADD CONSTRAINT `fk_procurement_compliance_document_superseded_document_compliance_document_id` FOREIGN KEY (`superseded_document_compliance_document_id`) REFERENCES `food_beverage_ecm`.`procurement`.`compliance_document`(`compliance_document_id`);
ALTER TABLE `food_beverage_ecm`.`procurement`.`compliance_document` ADD CONSTRAINT `fk_procurement_compliance_document_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `food_beverage_ecm`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `food_beverage_ecm`.`procurement`.`sourcing_bid` ADD CONSTRAINT `fk_procurement_sourcing_bid_compliance_document_id` FOREIGN KEY (`compliance_document_id`) REFERENCES `food_beverage_ecm`.`procurement`.`compliance_document`(`compliance_document_id`);
ALTER TABLE `food_beverage_ecm`.`procurement`.`sourcing_bid` ADD CONSTRAINT `fk_procurement_sourcing_bid_sourcing_event_id` FOREIGN KEY (`sourcing_event_id`) REFERENCES `food_beverage_ecm`.`procurement`.`sourcing_event`(`sourcing_event_id`);
ALTER TABLE `food_beverage_ecm`.`procurement`.`sourcing_bid` ADD CONSTRAINT `fk_procurement_sourcing_bid_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `food_beverage_ecm`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `food_beverage_ecm`.`procurement`.`spend_transaction` ADD CONSTRAINT `fk_procurement_spend_transaction_purchase_contract_id` FOREIGN KEY (`purchase_contract_id`) REFERENCES `food_beverage_ecm`.`procurement`.`purchase_contract`(`purchase_contract_id`);
ALTER TABLE `food_beverage_ecm`.`procurement`.`spend_transaction` ADD CONSTRAINT `fk_procurement_spend_transaction_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `food_beverage_ecm`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_requisition` ADD CONSTRAINT `fk_procurement_purchase_requisition_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `food_beverage_ecm`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_risk` ADD CONSTRAINT `fk_procurement_supplier_risk_compliance_document_id` FOREIGN KEY (`compliance_document_id`) REFERENCES `food_beverage_ecm`.`procurement`.`compliance_document`(`compliance_document_id`);
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_risk` ADD CONSTRAINT `fk_procurement_supplier_risk_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `food_beverage_ecm`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_risk` ADD CONSTRAINT `fk_procurement_supplier_risk_purchase_contract_id` FOREIGN KEY (`purchase_contract_id`) REFERENCES `food_beverage_ecm`.`procurement`.`purchase_contract`(`purchase_contract_id`);
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_approval` ADD CONSTRAINT `fk_procurement_supplier_approval_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `food_beverage_ecm`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `food_beverage_ecm`.`procurement`.`sustainability_partnership` ADD CONSTRAINT `fk_procurement_sustainability_partnership_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `food_beverage_ecm`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `food_beverage_ecm`.`procurement`.`supply_agreement` ADD CONSTRAINT `fk_procurement_supply_agreement_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `food_beverage_ecm`.`procurement`.`supplier`(`supplier_id`);

-- ========= TAGS =========
ALTER SCHEMA `food_beverage_ecm`.`procurement` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `food_beverage_ecm`.`procurement` SET TAGS ('dbx_domain' = 'procurement');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier` SET TAGS ('dbx_subdomain' = 'supplier_management');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier` ALTER COLUMN `esg_disclosure_id` SET TAGS ('dbx_business_glossary_term' = 'Esg Disclosure Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier` ALTER COLUMN `establishment_registration_id` SET TAGS ('dbx_business_glossary_term' = 'Establishment Registration Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier` ALTER COLUMN `target_id` SET TAGS ('dbx_business_glossary_term' = 'Sustainability Target Id (Foreign Key)');
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
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_site` SET TAGS ('dbx_subdomain' = 'supplier_management');
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
ALTER TABLE `food_beverage_ecm`.`procurement`.`approved_vendor_list` SET TAGS ('dbx_subdomain' = 'sourcing_strategy');
ALTER TABLE `food_beverage_ecm`.`procurement`.`approved_vendor_list` ALTER COLUMN `approved_vendor_list_id` SET TAGS ('dbx_business_glossary_term' = 'Approved Vendor List (AVL) ID');
ALTER TABLE `food_beverage_ecm`.`procurement`.`approved_vendor_list` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `food_beverage_ecm`.`procurement`.`approved_vendor_list` ALTER COLUMN `raw_material_id` SET TAGS ('dbx_business_glossary_term' = 'Material ID');
ALTER TABLE `food_beverage_ecm`.`procurement`.`approved_vendor_list` ALTER COLUMN `rd_project_id` SET TAGS ('dbx_business_glossary_term' = 'Rd Project Id (Foreign Key)');
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
ALTER TABLE `food_beverage_ecm`.`procurement`.`approved_vendor_list` ALTER COLUMN `material_category` SET TAGS ('dbx_business_glossary_term' = 'Material Category');
ALTER TABLE `food_beverage_ecm`.`procurement`.`approved_vendor_list` ALTER COLUMN `material_category` SET TAGS ('dbx_value_regex' = 'ingredient|packaging|indirect|co-manufacturing|toll_manufacturing');
ALTER TABLE `food_beverage_ecm`.`procurement`.`approved_vendor_list` ALTER COLUMN `material_description` SET TAGS ('dbx_business_glossary_term' = 'Material Description');
ALTER TABLE `food_beverage_ecm`.`procurement`.`approved_vendor_list` ALTER COLUMN `material_number` SET TAGS ('dbx_business_glossary_term' = 'Material Number');
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
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_order` SET TAGS ('dbx_subdomain' = 'procurement_transactions');
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_order` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) ID');
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_order` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_order` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_order` ALTER COLUMN `bill_to_location_id` SET TAGS ('dbx_business_glossary_term' = 'Bill To Location Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_order` ALTER COLUMN `category_strategy_id` SET TAGS ('dbx_business_glossary_term' = 'Category Strategy Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_order` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By Employee Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_order` ALTER COLUMN `fsma_record_id` SET TAGS ('dbx_business_glossary_term' = 'Fsma Record Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_order` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_order` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant / Distribution Center (DC) ID');
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_order` ALTER COLUMN `purchase_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Procurement Contract ID');
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_order` ALTER COLUMN `rd_project_id` SET TAGS ('dbx_business_glossary_term' = 'Rd Project Id (Foreign Key)');
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
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_order` ALTER COLUMN `delivery_address` SET TAGS ('dbx_business_glossary_term' = 'Delivery Address');
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_order` ALTER COLUMN `delivery_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_order` ALTER COLUMN `delivery_address` SET TAGS ('dbx_pii_address' = 'true');
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
ALTER TABLE `food_beverage_ecm`.`procurement`.`po_line` SET TAGS ('dbx_subdomain' = 'procurement_transactions');
ALTER TABLE `food_beverage_ecm`.`procurement`.`po_line` ALTER COLUMN `po_line_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Line ID');
ALTER TABLE `food_beverage_ecm`.`procurement`.`po_line` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`procurement`.`po_line` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`procurement`.`po_line` ALTER COLUMN `purchase_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Procurement Contract ID');
ALTER TABLE `food_beverage_ecm`.`procurement`.`po_line` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) ID');
ALTER TABLE `food_beverage_ecm`.`procurement`.`po_line` ALTER COLUMN `raw_material_id` SET TAGS ('dbx_business_glossary_term' = 'Material ID');
ALTER TABLE `food_beverage_ecm`.`procurement`.`po_line` ALTER COLUMN `rd_project_id` SET TAGS ('dbx_business_glossary_term' = 'Rd Project Id (Foreign Key)');
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
ALTER TABLE `food_beverage_ecm`.`procurement`.`goods_receipt` SET TAGS ('dbx_subdomain' = 'procurement_transactions');
ALTER TABLE `food_beverage_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `goods_receipt_id` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt Identifier');
ALTER TABLE `food_beverage_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `raw_material_id` SET TAGS ('dbx_business_glossary_term' = 'Material ID');
ALTER TABLE `food_beverage_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant ID');
ALTER TABLE `food_beverage_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `po_line_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Line ID');
ALTER TABLE `food_beverage_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) ID');
ALTER TABLE `food_beverage_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Receiving Clerk Employee Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `food_beverage_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'Storage Location ID');
ALTER TABLE `food_beverage_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `food_beverage_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `allergen_declaration_received_flag` SET TAGS ('dbx_business_glossary_term' = 'Allergen Declaration Received Flag');
ALTER TABLE `food_beverage_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Number');
ALTER TABLE `food_beverage_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `batch_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `food_beverage_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `best_before_date` SET TAGS ('dbx_business_glossary_term' = 'Best Before Date');
ALTER TABLE `food_beverage_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `bill_of_lading_number` SET TAGS ('dbx_business_glossary_term' = 'Bill of Lading (BOL) Number');
ALTER TABLE `food_beverage_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `bill_of_lading_number` SET TAGS ('dbx_value_regex' = '^BOL[A-Z0-9]{8,20}$');
ALTER TABLE `food_beverage_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `carrier_name` SET TAGS ('dbx_business_glossary_term' = 'Carrier Name');
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
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_contract` SET TAGS ('dbx_subdomain' = 'procurement_transactions');
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_contract` ALTER COLUMN `purchase_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Contract ID');
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_contract` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Owner Employee Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_contract` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_contract` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_contract` ALTER COLUMN `initiative_id` SET TAGS ('dbx_business_glossary_term' = 'Sustainability Initiative Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_contract` ALTER COLUMN `product_registration_id` SET TAGS ('dbx_business_glossary_term' = 'Product Registration Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_contract` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_contract` ALTER COLUMN `target_id` SET TAGS ('dbx_business_glossary_term' = 'Sustainability Target Id (Foreign Key)');
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
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_contract` ALTER COLUMN `material_category` SET TAGS ('dbx_business_glossary_term' = 'Material Category');
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_contract` ALTER COLUMN `material_category` SET TAGS ('dbx_value_regex' = 'raw_material|ingredient|packaging|indirect_material|service|MRO');
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
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_contract` ALTER COLUMN `quality_specification_reference` SET TAGS ('dbx_business_glossary_term' = 'Quality Specification Reference');
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_contract` ALTER COLUMN `rebate_agreement_flag` SET TAGS ('dbx_business_glossary_term' = 'Rebate Agreement Flag');
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_contract` ALTER COLUMN `rebate_percentage` SET TAGS ('dbx_business_glossary_term' = 'Rebate Percentage');
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_contract` ALTER COLUMN `rebate_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_contract` ALTER COLUMN `renewal_notice_days` SET TAGS ('dbx_business_glossary_term' = 'Renewal Notice Days');
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_contract` ALTER COLUMN `spend_category` SET TAGS ('dbx_business_glossary_term' = 'Spend Category');
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_contract` ALTER COLUMN `termination_notice_days` SET TAGS ('dbx_business_glossary_term' = 'Termination Notice Days');
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_contract` ALTER COLUMN `total_contract_value` SET TAGS ('dbx_business_glossary_term' = 'Total Contract Value');
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_contract` ALTER COLUMN `total_contract_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_contract` ALTER COLUMN `volume_commitment_quantity` SET TAGS ('dbx_business_glossary_term' = 'Volume Commitment Quantity');
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_contract` ALTER COLUMN `volume_commitment_quantity` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_contract` ALTER COLUMN `volume_commitment_uom` SET TAGS ('dbx_business_glossary_term' = 'Volume Commitment Unit of Measure');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_scorecard` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_scorecard` SET TAGS ('dbx_subdomain' = 'supplier_management');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_scorecard` ALTER COLUMN `supplier_scorecard_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Scorecard ID');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_scorecard` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Evaluator Employee Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_scorecard` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_scorecard` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_scorecard` ALTER COLUMN `purchase_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract ID');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_scorecard` ALTER COLUMN `rd_project_id` SET TAGS ('dbx_business_glossary_term' = 'Rd Project Id (Foreign Key)');
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
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_audit` SET TAGS ('dbx_subdomain' = 'supplier_management');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_audit` ALTER COLUMN `supplier_audit_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Audit ID');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_audit` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Auditor Employee Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_audit` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_audit` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_audit` ALTER COLUMN `compliance_document_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Report Document ID');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_audit` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
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
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_audit` ALTER COLUMN `facility_address` SET TAGS ('dbx_business_glossary_term' = 'Facility Address');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_audit` ALTER COLUMN `facility_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_audit` ALTER COLUMN `facility_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_audit` ALTER COLUMN `facility_country_code` SET TAGS ('dbx_business_glossary_term' = 'Facility Country Code');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_audit` ALTER COLUMN `facility_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_audit` ALTER COLUMN `facility_name` SET TAGS ('dbx_business_glossary_term' = 'Facility Name');
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
ALTER TABLE `food_beverage_ecm`.`procurement`.`compliance_document` SET TAGS ('dbx_subdomain' = 'supplier_management');
ALTER TABLE `food_beverage_ecm`.`procurement`.`compliance_document` ALTER COLUMN `compliance_document_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Document ID');
ALTER TABLE `food_beverage_ecm`.`procurement`.`compliance_document` ALTER COLUMN `raw_material_id` SET TAGS ('dbx_business_glossary_term' = 'Material ID');
ALTER TABLE `food_beverage_ecm`.`procurement`.`compliance_document` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `food_beverage_ecm`.`procurement`.`compliance_document` ALTER COLUMN `rd_project_id` SET TAGS ('dbx_business_glossary_term' = 'Rd Project Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`procurement`.`compliance_document` ALTER COLUMN `superseded_document_compliance_document_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded Document ID');
ALTER TABLE `food_beverage_ecm`.`procurement`.`compliance_document` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
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
ALTER TABLE `food_beverage_ecm`.`procurement`.`compliance_document` ALTER COLUMN `facility_name` SET TAGS ('dbx_business_glossary_term' = 'Facility Name');
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
ALTER TABLE `food_beverage_ecm`.`procurement`.`compliance_document` ALTER COLUMN `material_description` SET TAGS ('dbx_business_glossary_term' = 'Material Description');
ALTER TABLE `food_beverage_ecm`.`procurement`.`compliance_document` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `food_beverage_ecm`.`procurement`.`compliance_document` ALTER COLUMN `non_conformance_count` SET TAGS ('dbx_business_glossary_term' = 'Non-Conformance Count');
ALTER TABLE `food_beverage_ecm`.`procurement`.`compliance_document` ALTER COLUMN `regulatory_framework` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Framework');
ALTER TABLE `food_beverage_ecm`.`procurement`.`compliance_document` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `food_beverage_ecm`.`procurement`.`compliance_document` ALTER COLUMN `retention_period_years` SET TAGS ('dbx_business_glossary_term' = 'Retention Period (Years)');
ALTER TABLE `food_beverage_ecm`.`procurement`.`compliance_document` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `food_beverage_ecm`.`procurement`.`sourcing_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `food_beverage_ecm`.`procurement`.`sourcing_event` SET TAGS ('dbx_subdomain' = 'sourcing_strategy');
ALTER TABLE `food_beverage_ecm`.`procurement`.`sourcing_event` ALTER COLUMN `sourcing_event_id` SET TAGS ('dbx_business_glossary_term' = 'Sourcing Event ID');
ALTER TABLE `food_beverage_ecm`.`procurement`.`sourcing_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Buyer ID');
ALTER TABLE `food_beverage_ecm`.`procurement`.`sourcing_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`procurement`.`sourcing_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `food_beverage_ecm`.`procurement`.`sourcing_event` ALTER COLUMN `rd_project_id` SET TAGS ('dbx_business_glossary_term' = 'Rd Project Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`procurement`.`sourcing_event` ALTER COLUMN `award_date` SET TAGS ('dbx_business_glossary_term' = 'Award Date');
ALTER TABLE `food_beverage_ecm`.`procurement`.`sourcing_event` ALTER COLUMN `award_rationale` SET TAGS ('dbx_business_glossary_term' = 'Award Rationale');
ALTER TABLE `food_beverage_ecm`.`procurement`.`sourcing_event` ALTER COLUMN `awarded_spend_amount` SET TAGS ('dbx_business_glossary_term' = 'Awarded Spend Amount');
ALTER TABLE `food_beverage_ecm`.`procurement`.`sourcing_event` ALTER COLUMN `baseline_spend_amount` SET TAGS ('dbx_business_glossary_term' = 'Baseline Spend Amount');
ALTER TABLE `food_beverage_ecm`.`procurement`.`sourcing_event` ALTER COLUMN `bid_opening_date` SET TAGS ('dbx_business_glossary_term' = 'Bid Opening Date');
ALTER TABLE `food_beverage_ecm`.`procurement`.`sourcing_event` ALTER COLUMN `bid_received_count` SET TAGS ('dbx_business_glossary_term' = 'Bid Received Count');
ALTER TABLE `food_beverage_ecm`.`procurement`.`sourcing_event` ALTER COLUMN `bid_submission_deadline` SET TAGS ('dbx_business_glossary_term' = 'Bid Submission Deadline');
ALTER TABLE `food_beverage_ecm`.`procurement`.`sourcing_event` ALTER COLUMN `buyer_email` SET TAGS ('dbx_business_glossary_term' = 'Buyer Email Address');
ALTER TABLE `food_beverage_ecm`.`procurement`.`sourcing_event` ALTER COLUMN `buyer_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `food_beverage_ecm`.`procurement`.`sourcing_event` ALTER COLUMN `buyer_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`procurement`.`sourcing_event` ALTER COLUMN `buyer_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `food_beverage_ecm`.`procurement`.`sourcing_event` ALTER COLUMN `buyer_name` SET TAGS ('dbx_business_glossary_term' = 'Buyer Name');
ALTER TABLE `food_beverage_ecm`.`procurement`.`sourcing_event` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `food_beverage_ecm`.`procurement`.`sourcing_event` ALTER COLUMN `commodity_category` SET TAGS ('dbx_business_glossary_term' = 'Commodity Category');
ALTER TABLE `food_beverage_ecm`.`procurement`.`sourcing_event` ALTER COLUMN `commodity_subcategory` SET TAGS ('dbx_business_glossary_term' = 'Commodity Subcategory');
ALTER TABLE `food_beverage_ecm`.`procurement`.`sourcing_event` ALTER COLUMN `contract_end_date` SET TAGS ('dbx_business_glossary_term' = 'Contract End Date');
ALTER TABLE `food_beverage_ecm`.`procurement`.`sourcing_event` ALTER COLUMN `contract_start_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Start Date');
ALTER TABLE `food_beverage_ecm`.`procurement`.`sourcing_event` ALTER COLUMN `contract_term_months` SET TAGS ('dbx_business_glossary_term' = 'Contract Term in Months');
ALTER TABLE `food_beverage_ecm`.`procurement`.`sourcing_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `food_beverage_ecm`.`procurement`.`sourcing_event` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `food_beverage_ecm`.`procurement`.`sourcing_event` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `food_beverage_ecm`.`procurement`.`sourcing_event` ALTER COLUMN `evaluation_criteria_lead_time_weight` SET TAGS ('dbx_business_glossary_term' = 'Lead Time Evaluation Weight Percentage');
ALTER TABLE `food_beverage_ecm`.`procurement`.`sourcing_event` ALTER COLUMN `evaluation_criteria_price_weight` SET TAGS ('dbx_business_glossary_term' = 'Price Evaluation Weight Percentage');
ALTER TABLE `food_beverage_ecm`.`procurement`.`sourcing_event` ALTER COLUMN `evaluation_criteria_quality_weight` SET TAGS ('dbx_business_glossary_term' = 'Quality Evaluation Weight Percentage');
ALTER TABLE `food_beverage_ecm`.`procurement`.`sourcing_event` ALTER COLUMN `evaluation_criteria_sustainability_weight` SET TAGS ('dbx_business_glossary_term' = 'Sustainability Evaluation Weight Percentage');
ALTER TABLE `food_beverage_ecm`.`procurement`.`sourcing_event` ALTER COLUMN `evaluation_end_date` SET TAGS ('dbx_business_glossary_term' = 'Evaluation End Date');
ALTER TABLE `food_beverage_ecm`.`procurement`.`sourcing_event` ALTER COLUMN `evaluation_start_date` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Start Date');
ALTER TABLE `food_beverage_ecm`.`procurement`.`sourcing_event` ALTER COLUMN `event_description` SET TAGS ('dbx_business_glossary_term' = 'Sourcing Event Description');
ALTER TABLE `food_beverage_ecm`.`procurement`.`sourcing_event` ALTER COLUMN `event_number` SET TAGS ('dbx_business_glossary_term' = 'Sourcing Event Number');
ALTER TABLE `food_beverage_ecm`.`procurement`.`sourcing_event` ALTER COLUMN `event_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `food_beverage_ecm`.`procurement`.`sourcing_event` ALTER COLUMN `event_status` SET TAGS ('dbx_business_glossary_term' = 'Sourcing Event Status');
ALTER TABLE `food_beverage_ecm`.`procurement`.`sourcing_event` ALTER COLUMN `event_title` SET TAGS ('dbx_business_glossary_term' = 'Sourcing Event Title');
ALTER TABLE `food_beverage_ecm`.`procurement`.`sourcing_event` ALTER COLUMN `event_type` SET TAGS ('dbx_business_glossary_term' = 'Request for X (RFx) Event Type');
ALTER TABLE `food_beverage_ecm`.`procurement`.`sourcing_event` ALTER COLUMN `event_type` SET TAGS ('dbx_value_regex' = 'RFI|RFQ|RFP|E-Auction|Reverse Auction|Sealed Bid');
ALTER TABLE `food_beverage_ecm`.`procurement`.`sourcing_event` ALTER COLUMN `is_multi_year_contract` SET TAGS ('dbx_business_glossary_term' = 'Multi-Year Contract Flag');
ALTER TABLE `food_beverage_ecm`.`procurement`.`sourcing_event` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `food_beverage_ecm`.`procurement`.`sourcing_event` ALTER COLUMN `participating_supplier_count` SET TAGS ('dbx_business_glossary_term' = 'Participating Supplier Count');
ALTER TABLE `food_beverage_ecm`.`procurement`.`sourcing_event` ALTER COLUMN `procurement_organization` SET TAGS ('dbx_business_glossary_term' = 'Procurement Organization');
ALTER TABLE `food_beverage_ecm`.`procurement`.`sourcing_event` ALTER COLUMN `published_date` SET TAGS ('dbx_business_glossary_term' = 'Event Published Date');
ALTER TABLE `food_beverage_ecm`.`procurement`.`sourcing_event` ALTER COLUMN `requires_fssc_22000_certification` SET TAGS ('dbx_business_glossary_term' = 'Food Safety System Certification (FSSC) 22000 Required Flag');
ALTER TABLE `food_beverage_ecm`.`procurement`.`sourcing_event` ALTER COLUMN `requires_gmp_certification` SET TAGS ('dbx_business_glossary_term' = 'Good Manufacturing Practice (GMP) Certification Required Flag');
ALTER TABLE `food_beverage_ecm`.`procurement`.`sourcing_event` ALTER COLUMN `savings_amount` SET TAGS ('dbx_business_glossary_term' = 'Savings Amount');
ALTER TABLE `food_beverage_ecm`.`procurement`.`sourcing_event` ALTER COLUMN `savings_percentage` SET TAGS ('dbx_business_glossary_term' = 'Savings Percentage');
ALTER TABLE `food_beverage_ecm`.`procurement`.`sourcing_event` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `food_beverage_ecm`.`procurement`.`sourcing_event` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'Oracle Cloud Procurement|SAP Ariba|SAP S/4HANA MM|Manual Entry');
ALTER TABLE `food_beverage_ecm`.`procurement`.`sourcing_event` ALTER COLUMN `source_system_event_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Event ID');
ALTER TABLE `food_beverage_ecm`.`procurement`.`sourcing_event` ALTER COLUMN `tracegains_compliance_required` SET TAGS ('dbx_business_glossary_term' = 'TraceGains Compliance Required Flag');
ALTER TABLE `food_beverage_ecm`.`procurement`.`sourcing_bid` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `food_beverage_ecm`.`procurement`.`sourcing_bid` SET TAGS ('dbx_subdomain' = 'sourcing_strategy');
ALTER TABLE `food_beverage_ecm`.`procurement`.`sourcing_bid` ALTER COLUMN `sourcing_bid_id` SET TAGS ('dbx_business_glossary_term' = 'Sourcing Bid Identifier (ID)');
ALTER TABLE `food_beverage_ecm`.`procurement`.`sourcing_bid` ALTER COLUMN `compliance_document_id` SET TAGS ('dbx_business_glossary_term' = 'TraceGains Document Identifier (ID)');
ALTER TABLE `food_beverage_ecm`.`procurement`.`sourcing_bid` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By Employee Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`procurement`.`sourcing_bid` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`procurement`.`sourcing_bid` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `food_beverage_ecm`.`procurement`.`sourcing_bid` ALTER COLUMN `rd_project_id` SET TAGS ('dbx_business_glossary_term' = 'Rd Project Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`procurement`.`sourcing_bid` ALTER COLUMN `sourcing_event_id` SET TAGS ('dbx_business_glossary_term' = 'Sourcing Event Identifier (ID)');
ALTER TABLE `food_beverage_ecm`.`procurement`.`sourcing_bid` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Identifier (ID)');
ALTER TABLE `food_beverage_ecm`.`procurement`.`sourcing_bid` ALTER COLUMN `allergen_declaration` SET TAGS ('dbx_business_glossary_term' = 'Allergen Declaration');
ALTER TABLE `food_beverage_ecm`.`procurement`.`sourcing_bid` ALTER COLUMN `attachment_count` SET TAGS ('dbx_business_glossary_term' = 'Attachment Count');
ALTER TABLE `food_beverage_ecm`.`procurement`.`sourcing_bid` ALTER COLUMN `award_decision_date` SET TAGS ('dbx_business_glossary_term' = 'Award Decision Date');
ALTER TABLE `food_beverage_ecm`.`procurement`.`sourcing_bid` ALTER COLUMN `award_recommendation_flag` SET TAGS ('dbx_business_glossary_term' = 'Award Recommendation Flag');
ALTER TABLE `food_beverage_ecm`.`procurement`.`sourcing_bid` ALTER COLUMN `awarded_quantity` SET TAGS ('dbx_business_glossary_term' = 'Awarded Quantity');
ALTER TABLE `food_beverage_ecm`.`procurement`.`sourcing_bid` ALTER COLUMN `bid_notes` SET TAGS ('dbx_business_glossary_term' = 'Bid Notes');
ALTER TABLE `food_beverage_ecm`.`procurement`.`sourcing_bid` ALTER COLUMN `bid_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Bid Reference Number');
ALTER TABLE `food_beverage_ecm`.`procurement`.`sourcing_bid` ALTER COLUMN `bid_score` SET TAGS ('dbx_business_glossary_term' = 'Bid Score');
ALTER TABLE `food_beverage_ecm`.`procurement`.`sourcing_bid` ALTER COLUMN `bid_status` SET TAGS ('dbx_business_glossary_term' = 'Bid Status');
ALTER TABLE `food_beverage_ecm`.`procurement`.`sourcing_bid` ALTER COLUMN `bid_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|under_review|accepted|rejected|withdrawn');
ALTER TABLE `food_beverage_ecm`.`procurement`.`sourcing_bid` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `food_beverage_ecm`.`procurement`.`sourcing_bid` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `food_beverage_ecm`.`procurement`.`sourcing_bid` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `food_beverage_ecm`.`procurement`.`sourcing_bid` ALTER COLUMN `delivery_location` SET TAGS ('dbx_business_glossary_term' = 'Delivery Location');
ALTER TABLE `food_beverage_ecm`.`procurement`.`sourcing_bid` ALTER COLUMN `delivery_score` SET TAGS ('dbx_business_glossary_term' = 'Delivery Score');
ALTER TABLE `food_beverage_ecm`.`procurement`.`sourcing_bid` ALTER COLUMN `incoterms` SET TAGS ('dbx_business_glossary_term' = 'International Commercial Terms (Incoterms)');
ALTER TABLE `food_beverage_ecm`.`procurement`.`sourcing_bid` ALTER COLUMN `last_modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified By User');
ALTER TABLE `food_beverage_ecm`.`procurement`.`sourcing_bid` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `food_beverage_ecm`.`procurement`.`sourcing_bid` ALTER COLUMN `line_number` SET TAGS ('dbx_business_glossary_term' = 'Bid Line Number');
ALTER TABLE `food_beverage_ecm`.`procurement`.`sourcing_bid` ALTER COLUMN `moq` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity (MOQ)');
ALTER TABLE `food_beverage_ecm`.`procurement`.`sourcing_bid` ALTER COLUMN `moq_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity (MOQ) Unit of Measure');
ALTER TABLE `food_beverage_ecm`.`procurement`.`sourcing_bid` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `food_beverage_ecm`.`procurement`.`sourcing_bid` ALTER COLUMN `price_score` SET TAGS ('dbx_business_glossary_term' = 'Price Score');
ALTER TABLE `food_beverage_ecm`.`procurement`.`sourcing_bid` ALTER COLUMN `quality_certification_codes` SET TAGS ('dbx_business_glossary_term' = 'Quality Certification Codes');
ALTER TABLE `food_beverage_ecm`.`procurement`.`sourcing_bid` ALTER COLUMN `quality_score` SET TAGS ('dbx_business_glossary_term' = 'Quality Score');
ALTER TABLE `food_beverage_ecm`.`procurement`.`sourcing_bid` ALTER COLUMN `quoted_lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Quoted Lead Time (Days)');
ALTER TABLE `food_beverage_ecm`.`procurement`.`sourcing_bid` ALTER COLUMN `quoted_unit_price` SET TAGS ('dbx_business_glossary_term' = 'Quoted Unit Price');
ALTER TABLE `food_beverage_ecm`.`procurement`.`sourcing_bid` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `food_beverage_ecm`.`procurement`.`sourcing_bid` ALTER COLUMN `shelf_life_days` SET TAGS ('dbx_business_glossary_term' = 'Shelf Life (Days)');
ALTER TABLE `food_beverage_ecm`.`procurement`.`sourcing_bid` ALTER COLUMN `submission_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Bid Submission Timestamp');
ALTER TABLE `food_beverage_ecm`.`procurement`.`sourcing_bid` ALTER COLUMN `supplier_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Supplier Contact Email Address');
ALTER TABLE `food_beverage_ecm`.`procurement`.`sourcing_bid` ALTER COLUMN `supplier_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `food_beverage_ecm`.`procurement`.`sourcing_bid` ALTER COLUMN `supplier_contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `food_beverage_ecm`.`procurement`.`sourcing_bid` ALTER COLUMN `supplier_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `food_beverage_ecm`.`procurement`.`sourcing_bid` ALTER COLUMN `supplier_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Supplier Contact Name');
ALTER TABLE `food_beverage_ecm`.`procurement`.`sourcing_bid` ALTER COLUMN `supplier_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `food_beverage_ecm`.`procurement`.`sourcing_bid` ALTER COLUMN `supplier_contact_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `food_beverage_ecm`.`procurement`.`sourcing_bid` ALTER COLUMN `supplier_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Supplier Contact Phone Number');
ALTER TABLE `food_beverage_ecm`.`procurement`.`sourcing_bid` ALTER COLUMN `supplier_contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `food_beverage_ecm`.`procurement`.`sourcing_bid` ALTER COLUMN `supplier_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `food_beverage_ecm`.`procurement`.`sourcing_bid` ALTER COLUMN `sustainability_commitment_description` SET TAGS ('dbx_business_glossary_term' = 'Sustainability Commitment Description');
ALTER TABLE `food_beverage_ecm`.`procurement`.`sourcing_bid` ALTER COLUMN `sustainability_commitment_flag` SET TAGS ('dbx_business_glossary_term' = 'Sustainability Commitment Flag');
ALTER TABLE `food_beverage_ecm`.`procurement`.`sourcing_bid` ALTER COLUMN `sustainability_score` SET TAGS ('dbx_business_glossary_term' = 'Sustainability Score');
ALTER TABLE `food_beverage_ecm`.`procurement`.`spend_transaction` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `food_beverage_ecm`.`procurement`.`spend_transaction` SET TAGS ('dbx_subdomain' = 'procurement_transactions');
ALTER TABLE `food_beverage_ecm`.`procurement`.`spend_transaction` ALTER COLUMN `spend_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Spend Transaction ID');
ALTER TABLE `food_beverage_ecm`.`procurement`.`spend_transaction` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`procurement`.`spend_transaction` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`procurement`.`spend_transaction` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`procurement`.`spend_transaction` ALTER COLUMN `raw_material_id` SET TAGS ('dbx_business_glossary_term' = 'Material ID');
ALTER TABLE `food_beverage_ecm`.`procurement`.`spend_transaction` ALTER COLUMN `purchase_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Procurement Contract ID');
ALTER TABLE `food_beverage_ecm`.`procurement`.`spend_transaction` ALTER COLUMN `rd_project_id` SET TAGS ('dbx_business_glossary_term' = 'Rd Project Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`procurement`.`spend_transaction` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `food_beverage_ecm`.`procurement`.`spend_transaction` ALTER COLUMN `contract_price` SET TAGS ('dbx_business_glossary_term' = 'Contracted Price per Unit');
ALTER TABLE `food_beverage_ecm`.`procurement`.`spend_transaction` ALTER COLUMN `contract_price` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`procurement`.`spend_transaction` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `food_beverage_ecm`.`procurement`.`spend_transaction` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `food_beverage_ecm`.`procurement`.`spend_transaction` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `food_beverage_ecm`.`procurement`.`spend_transaction` ALTER COLUMN `goods_receipt_date` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt Date');
ALTER TABLE `food_beverage_ecm`.`procurement`.`spend_transaction` ALTER COLUMN `internal_category_code` SET TAGS ('dbx_business_glossary_term' = 'Internal Procurement Category Code');
ALTER TABLE `food_beverage_ecm`.`procurement`.`spend_transaction` ALTER COLUMN `invoice_date` SET TAGS ('dbx_business_glossary_term' = 'Invoice Date');
ALTER TABLE `food_beverage_ecm`.`procurement`.`spend_transaction` ALTER COLUMN `invoice_line_number` SET TAGS ('dbx_business_glossary_term' = 'Invoice Line Number');
ALTER TABLE `food_beverage_ecm`.`procurement`.`spend_transaction` ALTER COLUMN `invoice_number` SET TAGS ('dbx_business_glossary_term' = 'Supplier Invoice Number');
ALTER TABLE `food_beverage_ecm`.`procurement`.`spend_transaction` ALTER COLUMN `invoiced_quantity` SET TAGS ('dbx_business_glossary_term' = 'Invoiced Quantity');
ALTER TABLE `food_beverage_ecm`.`procurement`.`spend_transaction` ALTER COLUMN `is_contract_spend` SET TAGS ('dbx_business_glossary_term' = 'Is Contract Spend Flag');
ALTER TABLE `food_beverage_ecm`.`procurement`.`spend_transaction` ALTER COLUMN `material_description` SET TAGS ('dbx_business_glossary_term' = 'Material Description');
ALTER TABLE `food_beverage_ecm`.`procurement`.`spend_transaction` ALTER COLUMN `material_group_code` SET TAGS ('dbx_business_glossary_term' = 'Material Group Code');
ALTER TABLE `food_beverage_ecm`.`procurement`.`spend_transaction` ALTER COLUMN `material_number` SET TAGS ('dbx_business_glossary_term' = 'Material Number');
ALTER TABLE `food_beverage_ecm`.`procurement`.`spend_transaction` ALTER COLUMN `payment_due_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Due Date');
ALTER TABLE `food_beverage_ecm`.`procurement`.`spend_transaction` ALTER COLUMN `payment_terms_code` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms Code');
ALTER TABLE `food_beverage_ecm`.`procurement`.`spend_transaction` ALTER COLUMN `plant_code` SET TAGS ('dbx_business_glossary_term' = 'Plant Code');
ALTER TABLE `food_beverage_ecm`.`procurement`.`spend_transaction` ALTER COLUMN `po_line_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Line Number');
ALTER TABLE `food_beverage_ecm`.`procurement`.`spend_transaction` ALTER COLUMN `po_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Number');
ALTER TABLE `food_beverage_ecm`.`procurement`.`spend_transaction` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Accounting Posting Date');
ALTER TABLE `food_beverage_ecm`.`procurement`.`spend_transaction` ALTER COLUMN `ppv_amount` SET TAGS ('dbx_business_glossary_term' = 'Purchase Price Variance (PPV) Amount');
ALTER TABLE `food_beverage_ecm`.`procurement`.`spend_transaction` ALTER COLUMN `ppv_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`procurement`.`spend_transaction` ALTER COLUMN `purchasing_group_code` SET TAGS ('dbx_business_glossary_term' = 'Purchasing Group Code');
ALTER TABLE `food_beverage_ecm`.`procurement`.`spend_transaction` ALTER COLUMN `purchasing_org_code` SET TAGS ('dbx_business_glossary_term' = 'Purchasing Organization Code');
ALTER TABLE `food_beverage_ecm`.`procurement`.`spend_transaction` ALTER COLUMN `quantity_uom` SET TAGS ('dbx_business_glossary_term' = 'Quantity Unit of Measure (UOM)');
ALTER TABLE `food_beverage_ecm`.`procurement`.`spend_transaction` ALTER COLUMN `source_document_type` SET TAGS ('dbx_business_glossary_term' = 'Source Document Type');
ALTER TABLE `food_beverage_ecm`.`procurement`.`spend_transaction` ALTER COLUMN `source_document_type` SET TAGS ('dbx_value_regex' = 'RE|KR|KG|KA|ZP|STANDARD');
ALTER TABLE `food_beverage_ecm`.`procurement`.`spend_transaction` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `food_beverage_ecm`.`procurement`.`spend_transaction` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'SAP_S4HANA|ORACLE_CLOUD|MANUAL');
ALTER TABLE `food_beverage_ecm`.`procurement`.`spend_transaction` ALTER COLUMN `spend_amount` SET TAGS ('dbx_business_glossary_term' = 'Spend Amount (Transaction Currency)');
ALTER TABLE `food_beverage_ecm`.`procurement`.`spend_transaction` ALTER COLUMN `spend_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`procurement`.`spend_transaction` ALTER COLUMN `spend_amount_local` SET TAGS ('dbx_business_glossary_term' = 'Spend Amount (Local/Company Currency)');
ALTER TABLE `food_beverage_ecm`.`procurement`.`spend_transaction` ALTER COLUMN `spend_amount_local` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`procurement`.`spend_transaction` ALTER COLUMN `spend_classification` SET TAGS ('dbx_business_glossary_term' = 'Spend Classification');
ALTER TABLE `food_beverage_ecm`.`procurement`.`spend_transaction` ALTER COLUMN `spend_classification` SET TAGS ('dbx_value_regex' = 'direct|indirect|capex|opex');
ALTER TABLE `food_beverage_ecm`.`procurement`.`spend_transaction` ALTER COLUMN `standard_cost` SET TAGS ('dbx_business_glossary_term' = 'Standard Cost per Unit');
ALTER TABLE `food_beverage_ecm`.`procurement`.`spend_transaction` ALTER COLUMN `standard_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`procurement`.`spend_transaction` ALTER COLUMN `transaction_currency` SET TAGS ('dbx_business_glossary_term' = 'Transaction Currency Code');
ALTER TABLE `food_beverage_ecm`.`procurement`.`spend_transaction` ALTER COLUMN `transaction_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `food_beverage_ecm`.`procurement`.`spend_transaction` ALTER COLUMN `transaction_status` SET TAGS ('dbx_business_glossary_term' = 'Spend Transaction Status');
ALTER TABLE `food_beverage_ecm`.`procurement`.`spend_transaction` ALTER COLUMN `transaction_status` SET TAGS ('dbx_value_regex' = 'posted|reversed|blocked|parked|cleared');
ALTER TABLE `food_beverage_ecm`.`procurement`.`spend_transaction` ALTER COLUMN `unit_price` SET TAGS ('dbx_business_glossary_term' = 'Actual Unit Price (Transaction Currency)');
ALTER TABLE `food_beverage_ecm`.`procurement`.`spend_transaction` ALTER COLUMN `unit_price` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`procurement`.`spend_transaction` ALTER COLUMN `unspsc_code` SET TAGS ('dbx_business_glossary_term' = 'United Nations Standard Products and Services Code (UNSPSC)');
ALTER TABLE `food_beverage_ecm`.`procurement`.`spend_transaction` ALTER COLUMN `unspsc_code` SET TAGS ('dbx_value_regex' = '^[0-9]{8}$');
ALTER TABLE `food_beverage_ecm`.`procurement`.`spend_transaction` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_requisition` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_requisition` SET TAGS ('dbx_subdomain' = 'procurement_transactions');
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `purchase_requisition_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Requisition (PR) ID');
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approver Employee ID');
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `demand_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Demand Plan Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `primary_purchase_requestor_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Requestor Employee ID');
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `primary_purchase_requestor_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `primary_purchase_requestor_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `rd_project_id` SET TAGS ('dbx_business_glossary_term' = 'Rd Project Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `approval_workflow_code` SET TAGS ('dbx_business_glossary_term' = 'Approval Workflow ID');
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `approval_workflow_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,16}$');
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `contract_number` SET TAGS ('dbx_business_glossary_term' = 'Contract Number');
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `contract_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{10,20}$');
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `conversion_date` SET TAGS ('dbx_business_glossary_term' = 'Conversion Date');
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{10}$');
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `delivery_address` SET TAGS ('dbx_business_glossary_term' = 'Delivery Address');
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `delivery_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `delivery_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `estimated_total_value` SET TAGS ('dbx_business_glossary_term' = 'Estimated Total Value');
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `estimated_unit_price` SET TAGS ('dbx_business_glossary_term' = 'Estimated Unit Price');
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `general_ledger_account` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account');
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `general_ledger_account` SET TAGS ('dbx_value_regex' = '^[0-9]{6,10}$');
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `is_deleted` SET TAGS ('dbx_business_glossary_term' = 'Is Deleted Flag');
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `material_description` SET TAGS ('dbx_business_glossary_term' = 'Material Description');
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `material_group_code` SET TAGS ('dbx_business_glossary_term' = 'Material Group Code');
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `material_group_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,8}$');
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `material_number` SET TAGS ('dbx_business_glossary_term' = 'Material Number');
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `material_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,18}$');
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `plant_code` SET TAGS ('dbx_business_glossary_term' = 'Plant Code');
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `plant_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|urgent');
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `procurement_category` SET TAGS ('dbx_business_glossary_term' = 'Procurement Category');
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `procurement_category` SET TAGS ('dbx_value_regex' = 'raw_material|ingredient|packaging|indirect_material|service|capital_equipment');
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `purchase_order_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Number');
ALTER TABLE `food_beverage_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `purchase_order_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{10}$');
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
ALTER TABLE `food_beverage_ecm`.`procurement`.`category_strategy` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `food_beverage_ecm`.`procurement`.`category_strategy` SET TAGS ('dbx_subdomain' = 'sourcing_strategy');
ALTER TABLE `food_beverage_ecm`.`procurement`.`category_strategy` ALTER COLUMN `category_strategy_id` SET TAGS ('dbx_business_glossary_term' = 'Category Strategy ID');
ALTER TABLE `food_beverage_ecm`.`procurement`.`category_strategy` ALTER COLUMN `allergen_relevance` SET TAGS ('dbx_business_glossary_term' = 'Allergen Relevance Flag');
ALTER TABLE `food_beverage_ecm`.`procurement`.`category_strategy` ALTER COLUMN `annual_savings_target_usd` SET TAGS ('dbx_business_glossary_term' = 'Annual Category Savings Target (USD)');
ALTER TABLE `food_beverage_ecm`.`procurement`.`category_strategy` ALTER COLUMN `annual_savings_target_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`procurement`.`category_strategy` ALTER COLUMN `annual_spend_usd` SET TAGS ('dbx_business_glossary_term' = 'Annual Category Spend (USD)');
ALTER TABLE `food_beverage_ecm`.`procurement`.`category_strategy` ALTER COLUMN `annual_spend_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`procurement`.`category_strategy` ALTER COLUMN `approved_supplier_target_count` SET TAGS ('dbx_business_glossary_term' = 'Approved Vendor List (AVL) Target Supplier Count');
ALTER TABLE `food_beverage_ecm`.`procurement`.`category_strategy` ALTER COLUMN `business_unit_owner` SET TAGS ('dbx_business_glossary_term' = 'Business Unit Owner');
ALTER TABLE `food_beverage_ecm`.`procurement`.`category_strategy` ALTER COLUMN `category_code` SET TAGS ('dbx_business_glossary_term' = 'Procurement Category Code');
ALTER TABLE `food_beverage_ecm`.`procurement`.`category_strategy` ALTER COLUMN `category_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{3,20}$');
ALTER TABLE `food_beverage_ecm`.`procurement`.`category_strategy` ALTER COLUMN `category_level` SET TAGS ('dbx_business_glossary_term' = 'Category Hierarchy Level');
ALTER TABLE `food_beverage_ecm`.`procurement`.`category_strategy` ALTER COLUMN `category_manager_email` SET TAGS ('dbx_business_glossary_term' = 'Category Manager Email Address');
ALTER TABLE `food_beverage_ecm`.`procurement`.`category_strategy` ALTER COLUMN `category_manager_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `food_beverage_ecm`.`procurement`.`category_strategy` ALTER COLUMN `category_manager_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`procurement`.`category_strategy` ALTER COLUMN `category_manager_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `food_beverage_ecm`.`procurement`.`category_strategy` ALTER COLUMN `category_manager_name` SET TAGS ('dbx_business_glossary_term' = 'Category Manager Name');
ALTER TABLE `food_beverage_ecm`.`procurement`.`category_strategy` ALTER COLUMN `category_name` SET TAGS ('dbx_business_glossary_term' = 'Procurement Category Name');
ALTER TABLE `food_beverage_ecm`.`procurement`.`category_strategy` ALTER COLUMN `commodity_type` SET TAGS ('dbx_business_glossary_term' = 'Commodity Type Classification');
ALTER TABLE `food_beverage_ecm`.`procurement`.`category_strategy` ALTER COLUMN `commodity_type` SET TAGS ('dbx_value_regex' = 'agricultural_commodity|industrial_commodity|manufactured_input|service|indirect');
ALTER TABLE `food_beverage_ecm`.`procurement`.`category_strategy` ALTER COLUMN `contract_duration_months` SET TAGS ('dbx_business_glossary_term' = 'Target Contract Duration (Months)');
ALTER TABLE `food_beverage_ecm`.`procurement`.`category_strategy` ALTER COLUMN `contract_type` SET TAGS ('dbx_business_glossary_term' = 'Preferred Contract Type');
ALTER TABLE `food_beverage_ecm`.`procurement`.`category_strategy` ALTER COLUMN `contract_type` SET TAGS ('dbx_value_regex' = 'spot|annual_fixed|multi_year|index_linked|cost_plus');
ALTER TABLE `food_beverage_ecm`.`procurement`.`category_strategy` ALTER COLUMN `dual_source_split_pct` SET TAGS ('dbx_business_glossary_term' = 'Dual Source Primary Supplier Split Percentage');
ALTER TABLE `food_beverage_ecm`.`procurement`.`category_strategy` ALTER COLUMN `dual_source_split_pct` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`procurement`.`category_strategy` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Strategy Effective From Date');
ALTER TABLE `food_beverage_ecm`.`procurement`.`category_strategy` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Strategy Effective Until Date');
ALTER TABLE `food_beverage_ecm`.`procurement`.`category_strategy` ALTER COLUMN `ethical_sourcing_standard` SET TAGS ('dbx_business_glossary_term' = 'Ethical Sourcing Audit Standard');
ALTER TABLE `food_beverage_ecm`.`procurement`.`category_strategy` ALTER COLUMN `ethical_sourcing_standard` SET TAGS ('dbx_value_regex' = 'none|sedex|smeta|bsci|sa8000|custom');
ALTER TABLE `food_beverage_ecm`.`procurement`.`category_strategy` ALTER COLUMN `food_safety_requirement` SET TAGS ('dbx_business_glossary_term' = 'Food Safety Certification Requirement');
ALTER TABLE `food_beverage_ecm`.`procurement`.`category_strategy` ALTER COLUMN `food_safety_requirement` SET TAGS ('dbx_value_regex' = 'none|gmp|haccp|gfsi|sqf|fssc22000');
ALTER TABLE `food_beverage_ecm`.`procurement`.`category_strategy` ALTER COLUMN `geographic_sourcing_scope` SET TAGS ('dbx_business_glossary_term' = 'Geographic Sourcing Scope');
ALTER TABLE `food_beverage_ecm`.`procurement`.`category_strategy` ALTER COLUMN `geographic_sourcing_scope` SET TAGS ('dbx_value_regex' = 'domestic|regional|global|preferred_domestic');
ALTER TABLE `food_beverage_ecm`.`procurement`.`category_strategy` ALTER COLUMN `hedge_coverage_target_pct` SET TAGS ('dbx_business_glossary_term' = 'Commodity Hedge Coverage Target Percentage');
ALTER TABLE `food_beverage_ecm`.`procurement`.`category_strategy` ALTER COLUMN `hedge_coverage_target_pct` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`procurement`.`category_strategy` ALTER COLUMN `hedging_strategy` SET TAGS ('dbx_business_glossary_term' = 'Commodity Hedging Strategy');
ALTER TABLE `food_beverage_ecm`.`procurement`.`category_strategy` ALTER COLUMN `hedging_strategy` SET TAGS ('dbx_value_regex' = 'no_hedge|forward_contract|futures|options|index_pricing');
ALTER TABLE `food_beverage_ecm`.`procurement`.`category_strategy` ALTER COLUMN `innovation_priority` SET TAGS ('dbx_business_glossary_term' = 'Supplier Innovation Priority');
ALTER TABLE `food_beverage_ecm`.`procurement`.`category_strategy` ALTER COLUMN `innovation_priority` SET TAGS ('dbx_value_regex' = 'low|medium|high');
ALTER TABLE `food_beverage_ecm`.`procurement`.`category_strategy` ALTER COLUMN `kraljic_quadrant` SET TAGS ('dbx_business_glossary_term' = 'Kraljic Matrix Quadrant Classification');
ALTER TABLE `food_beverage_ecm`.`procurement`.`category_strategy` ALTER COLUMN `kraljic_quadrant` SET TAGS ('dbx_value_regex' = 'strategic|leverage|bottleneck|non_critical');
ALTER TABLE `food_beverage_ecm`.`procurement`.`category_strategy` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Strategy Review Date');
ALTER TABLE `food_beverage_ecm`.`procurement`.`category_strategy` ALTER COLUMN `lead_time_target_days` SET TAGS ('dbx_business_glossary_term' = 'Target Supplier Lead Time (Days)');
ALTER TABLE `food_beverage_ecm`.`procurement`.`category_strategy` ALTER COLUMN `moq_policy` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity (MOQ) Policy');
ALTER TABLE `food_beverage_ecm`.`procurement`.`category_strategy` ALTER COLUMN `moq_policy` SET TAGS ('dbx_value_regex' = 'not_applicable|supplier_standard|negotiated|waived');
ALTER TABLE `food_beverage_ecm`.`procurement`.`category_strategy` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Scheduled Strategy Review Date');
ALTER TABLE `food_beverage_ecm`.`procurement`.`category_strategy` ALTER COLUMN `parent_category_code` SET TAGS ('dbx_business_glossary_term' = 'Parent Procurement Category Code');
ALTER TABLE `food_beverage_ecm`.`procurement`.`category_strategy` ALTER COLUMN `parent_category_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{3,20}$');
ALTER TABLE `food_beverage_ecm`.`procurement`.`category_strategy` ALTER COLUMN `payment_term_days` SET TAGS ('dbx_business_glossary_term' = 'Standard Payment Term (Days)');
ALTER TABLE `food_beverage_ecm`.`procurement`.`category_strategy` ALTER COLUMN `preferred_incoterm` SET TAGS ('dbx_business_glossary_term' = 'Preferred Incoterm');
ALTER TABLE `food_beverage_ecm`.`procurement`.`category_strategy` ALTER COLUMN `review_frequency` SET TAGS ('dbx_business_glossary_term' = 'Category Strategy Review Frequency');
ALTER TABLE `food_beverage_ecm`.`procurement`.`category_strategy` ALTER COLUMN `review_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|semi_annual|annual');
ALTER TABLE `food_beverage_ecm`.`procurement`.`category_strategy` ALTER COLUMN `savings_target_pct` SET TAGS ('dbx_business_glossary_term' = 'Annual Category Savings Target Percentage');
ALTER TABLE `food_beverage_ecm`.`procurement`.`category_strategy` ALTER COLUMN `savings_target_pct` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`procurement`.`category_strategy` ALTER COLUMN `sourcing_approach` SET TAGS ('dbx_business_glossary_term' = 'Sourcing Approach');
ALTER TABLE `food_beverage_ecm`.`procurement`.`category_strategy` ALTER COLUMN `sourcing_approach` SET TAGS ('dbx_value_regex' = 'competitive_bid|negotiated|sole_source|consortium|spot_buy');
ALTER TABLE `food_beverage_ecm`.`procurement`.`category_strategy` ALTER COLUMN `spend_impact_rating` SET TAGS ('dbx_business_glossary_term' = 'Spend Impact Rating');
ALTER TABLE `food_beverage_ecm`.`procurement`.`category_strategy` ALTER COLUMN `spend_impact_rating` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `food_beverage_ecm`.`procurement`.`category_strategy` ALTER COLUMN `spend_under_management_pct` SET TAGS ('dbx_business_glossary_term' = 'Spend Under Management Percentage');
ALTER TABLE `food_beverage_ecm`.`procurement`.`category_strategy` ALTER COLUMN `spend_under_management_pct` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`procurement`.`category_strategy` ALTER COLUMN `strategy_approved_date` SET TAGS ('dbx_business_glossary_term' = 'Strategy Approval Date');
ALTER TABLE `food_beverage_ecm`.`procurement`.`category_strategy` ALTER COLUMN `strategy_notes` SET TAGS ('dbx_business_glossary_term' = 'Category Strategy Notes');
ALTER TABLE `food_beverage_ecm`.`procurement`.`category_strategy` ALTER COLUMN `strategy_status` SET TAGS ('dbx_business_glossary_term' = 'Category Strategy Status');
ALTER TABLE `food_beverage_ecm`.`procurement`.`category_strategy` ALTER COLUMN `strategy_status` SET TAGS ('dbx_value_regex' = 'draft|active|under_review|approved|archived');
ALTER TABLE `food_beverage_ecm`.`procurement`.`category_strategy` ALTER COLUMN `strategy_version` SET TAGS ('dbx_business_glossary_term' = 'Category Strategy Version');
ALTER TABLE `food_beverage_ecm`.`procurement`.`category_strategy` ALTER COLUMN `strategy_version` SET TAGS ('dbx_value_regex' = '^vd+.d+$');
ALTER TABLE `food_beverage_ecm`.`procurement`.`category_strategy` ALTER COLUMN `supply_base_policy` SET TAGS ('dbx_business_glossary_term' = 'Supply Base Policy');
ALTER TABLE `food_beverage_ecm`.`procurement`.`category_strategy` ALTER COLUMN `supply_base_policy` SET TAGS ('dbx_value_regex' = 'single_source|dual_source|multi_source');
ALTER TABLE `food_beverage_ecm`.`procurement`.`category_strategy` ALTER COLUMN `supply_risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Supply Risk Rating');
ALTER TABLE `food_beverage_ecm`.`procurement`.`category_strategy` ALTER COLUMN `supply_risk_rating` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `food_beverage_ecm`.`procurement`.`category_strategy` ALTER COLUMN `sustainability_certification_required` SET TAGS ('dbx_business_glossary_term' = 'Required Sustainability Certification Standard');
ALTER TABLE `food_beverage_ecm`.`procurement`.`category_strategy` ALTER COLUMN `sustainability_requirement` SET TAGS ('dbx_business_glossary_term' = 'Sustainability and Ethical Sourcing Requirement Level');
ALTER TABLE `food_beverage_ecm`.`procurement`.`category_strategy` ALTER COLUMN `sustainability_requirement` SET TAGS ('dbx_value_regex' = 'none|preferred|required|certified');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_risk` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_risk` SET TAGS ('dbx_subdomain' = 'supplier_management');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_risk` ALTER COLUMN `supplier_risk_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Risk ID');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_risk` ALTER COLUMN `compliance_document_id` SET TAGS ('dbx_business_glossary_term' = 'TraceGains Document ID');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_risk` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_risk` ALTER COLUMN `purchase_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract ID');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_risk` ALTER COLUMN `rd_project_id` SET TAGS ('dbx_business_glossary_term' = 'Rd Project Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_risk` ALTER COLUMN `annual_spend` SET TAGS ('dbx_business_glossary_term' = 'Annual Spend');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_risk` ALTER COLUMN `annual_spend` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_risk` ALTER COLUMN `approved_vendor_list_status` SET TAGS ('dbx_business_glossary_term' = 'Approved Vendor List (AVL) Status');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_risk` ALTER COLUMN `approved_vendor_list_status` SET TAGS ('dbx_value_regex' = 'approved|conditional|suspended|disqualified');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_risk` ALTER COLUMN `audit_finding_reference` SET TAGS ('dbx_business_glossary_term' = 'Audit Finding Reference');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_risk` ALTER COLUMN `contingency_lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Contingency Lead Time (Days)');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_risk` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_risk` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_risk` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_risk` ALTER COLUMN `estimated_financial_exposure` SET TAGS ('dbx_business_glossary_term' = 'Estimated Financial Exposure');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_risk` ALTER COLUMN `estimated_financial_exposure` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_risk` ALTER COLUMN `exposure_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Exposure Currency Code');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_risk` ALTER COLUMN `exposure_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_risk` ALTER COLUMN `financial_stability_rating` SET TAGS ('dbx_business_glossary_term' = 'Financial Stability Rating');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_risk` ALTER COLUMN `financial_stability_rating` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_risk` ALTER COLUMN `food_safety_risk_flag` SET TAGS ('dbx_business_glossary_term' = 'Food Safety Risk Flag');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_risk` ALTER COLUMN `fsma_verification_required` SET TAGS ('dbx_business_glossary_term' = 'Food Safety Modernization Act (FSMA) Supplier Verification Required Flag');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_risk` ALTER COLUMN `geopolitical_region` SET TAGS ('dbx_business_glossary_term' = 'Geopolitical Region');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_risk` ALTER COLUMN `identified_date` SET TAGS ('dbx_business_glossary_term' = 'Risk Identified Date');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_risk` ALTER COLUMN `impact_score` SET TAGS ('dbx_business_glossary_term' = 'Impact Score');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_risk` ALTER COLUMN `is_single_source` SET TAGS ('dbx_business_glossary_term' = 'Single Source Dependency Flag');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_risk` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Risk Review Date');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_risk` ALTER COLUMN `likelihood_score` SET TAGS ('dbx_business_glossary_term' = 'Likelihood Score');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_risk` ALTER COLUMN `mitigation_completed_date` SET TAGS ('dbx_business_glossary_term' = 'Mitigation Completed Date');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_risk` ALTER COLUMN `mitigation_status` SET TAGS ('dbx_business_glossary_term' = 'Mitigation Status');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_risk` ALTER COLUMN `mitigation_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|completed|on_hold');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_risk` ALTER COLUMN `mitigation_strategy` SET TAGS ('dbx_business_glossary_term' = 'Mitigation Strategy');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_risk` ALTER COLUMN `mitigation_target_date` SET TAGS ('dbx_business_glossary_term' = 'Mitigation Target Date');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_risk` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Risk Review Date');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_risk` ALTER COLUMN `regulatory_compliance_risk_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Risk Flag');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_risk` ALTER COLUMN `residual_risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Residual Risk Rating');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_risk` ALTER COLUMN `residual_risk_rating` SET TAGS ('dbx_value_regex' = 'high|medium|low|critical');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_risk` ALTER COLUMN `risk_category` SET TAGS ('dbx_business_glossary_term' = 'Risk Category');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_risk` ALTER COLUMN `risk_category` SET TAGS ('dbx_value_regex' = 'supply_continuity|quality_compliance|financial|environmental|reputational|operational');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_risk` ALTER COLUMN `risk_closed_date` SET TAGS ('dbx_business_glossary_term' = 'Risk Closed Date');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_risk` ALTER COLUMN `risk_description` SET TAGS ('dbx_business_glossary_term' = 'Risk Description');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_risk` ALTER COLUMN `risk_open_date` SET TAGS ('dbx_business_glossary_term' = 'Risk Open Date');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_risk` ALTER COLUMN `risk_owner` SET TAGS ('dbx_business_glossary_term' = 'Risk Owner');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_risk` ALTER COLUMN `risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Risk Rating');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_risk` ALTER COLUMN `risk_rating` SET TAGS ('dbx_value_regex' = 'high|medium|low|critical');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_risk` ALTER COLUMN `risk_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Risk Reference Number');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_risk` ALTER COLUMN `risk_reference_number` SET TAGS ('dbx_value_regex' = '^SR-[0-9]{4}-[0-9]{6}$');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_risk` ALTER COLUMN `risk_reviewer` SET TAGS ('dbx_business_glossary_term' = 'Risk Reviewer');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_risk` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Risk Score');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_risk` ALTER COLUMN `risk_status` SET TAGS ('dbx_business_glossary_term' = 'Risk Status');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_risk` ALTER COLUMN `risk_status` SET TAGS ('dbx_value_regex' = 'identified|under_review|mitigated|accepted|closed|escalated');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_risk` ALTER COLUMN `risk_type` SET TAGS ('dbx_business_glossary_term' = 'Risk Type');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_risk` ALTER COLUMN `risk_type` SET TAGS ('dbx_value_regex' = 'geopolitical|financial_stability|food_safety|single_source_dependency|climate_weather|regulatory_compliance');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_risk` ALTER COLUMN `supply_category` SET TAGS ('dbx_business_glossary_term' = 'Supply Category');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_risk` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_approval` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_approval` SET TAGS ('dbx_subdomain' = 'supplier_management');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_approval` SET TAGS ('dbx_association_edges' = 'ingredient.raw_material,procurement.supplier');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_approval` ALTER COLUMN `supplier_approval_id` SET TAGS ('dbx_business_glossary_term' = 'Supplierapproval - Supplier Approval Id');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_approval` ALTER COLUMN `raw_material_id` SET TAGS ('dbx_business_glossary_term' = 'Supplierapproval - Raw Material Id');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_approval` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplierapproval - Supplier Id');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_approval` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supplier_approval` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `food_beverage_ecm`.`procurement`.`sustainability_partnership` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `food_beverage_ecm`.`procurement`.`sustainability_partnership` SET TAGS ('dbx_subdomain' = 'supplier_management');
ALTER TABLE `food_beverage_ecm`.`procurement`.`sustainability_partnership` SET TAGS ('dbx_association_edges' = 'procurement.supplier,sustainability.sustainability_initiative');
ALTER TABLE `food_beverage_ecm`.`procurement`.`sustainability_partnership` ALTER COLUMN `sustainability_partnership_id` SET TAGS ('dbx_business_glossary_term' = 'Sustainability Partnership - Supplier Initiative Participation Id');
ALTER TABLE `food_beverage_ecm`.`procurement`.`sustainability_partnership` ALTER COLUMN `initiative_id` SET TAGS ('dbx_business_glossary_term' = 'Sustainability Partnership - Sustainability Initiative Id');
ALTER TABLE `food_beverage_ecm`.`procurement`.`sustainability_partnership` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Sustainability Partnership - Supplier Id');
ALTER TABLE `food_beverage_ecm`.`procurement`.`sustainability_partnership` ALTER COLUMN `partner_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Partner Contact Name');
ALTER TABLE `food_beverage_ecm`.`procurement`.`sustainability_partnership` ALTER COLUMN `partner_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `food_beverage_ecm`.`procurement`.`sustainability_partnership` ALTER COLUMN `partner_contact_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `food_beverage_ecm`.`procurement`.`sustainability_partnership` ALTER COLUMN `partner_organization` SET TAGS ('dbx_business_glossary_term' = 'Partner Organization');
ALTER TABLE `food_beverage_ecm`.`procurement`.`sustainability_partnership` ALTER COLUMN `partner_type` SET TAGS ('dbx_business_glossary_term' = 'Partner Type');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supply_agreement` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supply_agreement` SET TAGS ('dbx_subdomain' = 'sourcing_strategy');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supply_agreement` SET TAGS ('dbx_association_edges' = 'procurement.supplier,maintenance.spare_part');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supply_agreement` ALTER COLUMN `supply_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Supplyagreement - Supply Agreement Id');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supply_agreement` ALTER COLUMN `spare_part_id` SET TAGS ('dbx_business_glossary_term' = 'Supplyagreement - Spare Part Id');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supply_agreement` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplyagreement - Supplier Id');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supply_agreement` ALTER COLUMN `contract_terms` SET TAGS ('dbx_business_glossary_term' = 'Contract Terms');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supply_agreement` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time');
ALTER TABLE `food_beverage_ecm`.`procurement`.`supply_agreement` ALTER COLUMN `unit_price` SET TAGS ('dbx_business_glossary_term' = 'Unit Price');
