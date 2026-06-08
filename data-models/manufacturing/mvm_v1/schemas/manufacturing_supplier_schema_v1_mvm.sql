-- Schema for Domain: supplier | Business: Manufacturing | Version: v1_mvm
-- Generated on: 2026-05-06 09:42:37

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `manufacturing_ecm`.`supplier` COMMENT 'Supplier relationship and performance management domain tracking supplier profiles, qualification status, scorecards, audit results, certifications, risk ratings, and long-term relationship data. Distinct from procurement transactions — this domain owns the supplier identity and master data used across procurement, quality, and supply chain.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `manufacturing_ecm`.`supplier`.`supplier` (
    `supplier_id` BIGINT COMMENT 'Primary key for supplier',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Required for allocating supplier spend to internal cost centers (Procurement Cost Allocation Report).',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Default GL account for posting supplier invoices (AP posting rules).',
    `business_type` STRING COMMENT 'Classification of the supplier based on the type of goods or services provided. OEM (Original Equipment Manufacturer) supplies finished components, distributor resells products, raw_material provides base materials, MRO (Maintenance Repair Operations) supplies consumables, subcontractor provides manufacturing services, service_provider delivers non-manufacturing services.. Valid values are `OEM|distributor|raw_material|MRO|subcontractor|service_provider`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this supplier master record was first created in the system. Used for data lineage, audit trails, and master data governance.',
    `duns_number` STRING COMMENT 'Nine-digit unique identifier assigned by Dun & Bradstreet to identify business entities globally. Used for supplier credit checks, risk assessment, and compliance verification.. Valid values are `^[0-9]{9}$`',
    `headquarters_address_line1` STRING COMMENT 'Primary street address line for the suppliers corporate headquarters. Used for legal correspondence, audit notices, and official communications.',
    `headquarters_address_line2` STRING COMMENT 'Secondary address line for suite, building, or floor information at the suppliers headquarters location.',
    `headquarters_city` STRING COMMENT 'City or municipality where the suppliers headquarters is located.',
    `headquarters_country` STRING COMMENT 'Three-letter ISO country code for the suppliers headquarters location. May differ from incorporation country for multinational organizations.. Valid values are `^[A-Z]{3}$`',
    `headquarters_postal_code` STRING COMMENT 'Postal or ZIP code for the suppliers headquarters location.',
    `headquarters_state_province` STRING COMMENT 'State, province, or administrative region for the suppliers headquarters address.',
    `incorporation_country` STRING COMMENT 'Three-letter ISO country code representing the country where the supplier is legally incorporated and registered. Used for trade compliance, tax jurisdiction, and regulatory reporting.. Valid values are `^[A-Z]{3}$`',
    `incoterms` STRING COMMENT 'Standard three-letter Incoterms code defining the division of costs, risks, and responsibilities between buyer and seller in international trade (e.g., FOB, CIF, DDP). Published by International Chamber of Commerce. [ENUM-REF-CANDIDATE: EXW|FCA|CPT|CIP|DAP|DPU|DDP|FAS|FOB|CFR|CIF — 11 candidates stripped; promote to reference product]',
    `iso14001_certified` BOOLEAN COMMENT 'Indicates whether the supplier holds valid ISO 14001 Environmental Management System certification. True if certified, False if not certified or certification expired.',
    `iso45001_certified` BOOLEAN COMMENT 'Indicates whether the supplier holds valid ISO 45001 Occupational Health and Safety Management System certification. True if certified, False if not certified or certification expired.',
    `iso9001_certified` BOOLEAN COMMENT 'Indicates whether the supplier holds valid ISO 9001 Quality Management System certification. True if certified, False if not certified or certification expired.',
    `last_audit_date` DATE COMMENT 'Date of the most recent supplier audit conducted by Manufacturings quality or procurement team. Used to track audit frequency and schedule next audit per supplier management policy.',
    `last_modified_by` STRING COMMENT 'User ID or name of the person who last modified this supplier master record. Used for change accountability, audit trails, and data governance.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this supplier master record was last updated. Used for change tracking, data synchronization, and audit compliance.',
    `last_scorecard_date` DATE COMMENT 'Date of the most recent supplier scorecard evaluation. Scorecards typically assess quality, delivery, cost, and responsiveness on a quarterly or annual basis.',
    `minority_owned` BOOLEAN COMMENT 'Indicates whether the supplier is certified as a minority-owned business enterprise. Used for diversity supplier programs and regulatory reporting.',
    `next_audit_due_date` DATE COMMENT 'Scheduled date for the next supplier audit based on risk rating, performance, and audit frequency policy. Used for audit planning and compliance tracking.',
    `on_time_delivery_rate` DECIMAL(18,2) COMMENT 'Percentage of purchase orders delivered on or before the requested delivery date over the evaluation period. Key performance indicator (KPI) for supplier scorecard and performance management. Expressed as percentage (0.00 to 100.00).',
    `overall_scorecard_rating` DECIMAL(18,2) COMMENT 'Composite supplier performance score from the most recent scorecard evaluation, typically on a scale of 0.0 to 10.0 or 0.0 to 100.0. Aggregates quality, delivery, cost, and service metrics into a single performance indicator.',
    `payment_terms` STRING COMMENT 'Standard payment terms negotiated with the supplier (e.g., Net 30, Net 60, 2/10 Net 30). Defines the payment due date and any early payment discounts available.',
    `preferred_currency` STRING COMMENT 'Three-letter ISO 4217 currency code representing the suppliers preferred currency for invoicing and payment transactions (e.g., USD, EUR, CNY).. Valid values are `^[A-Z]{3}$`',
    `primary_contact_email` STRING COMMENT 'Email address of the primary supplier contact for business communications, purchase orders, and quality notifications.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `primary_contact_name` STRING COMMENT 'Full name of the primary business contact at the supplier organization for procurement, quality, and supply chain coordination.',
    `primary_contact_phone` STRING COMMENT 'Business phone number for the primary supplier contact including country code and extension if applicable.',
    `qualification_status` STRING COMMENT 'Quality and compliance qualification status indicating whether the supplier has passed required audits, certifications, and capability assessments. Qualified suppliers meet all requirements, conditional suppliers have minor gaps, not_qualified suppliers failed assessment, under_review suppliers are being evaluated.. Valid values are `qualified|conditional|not_qualified|under_review`',
    `quality_acceptance_rate` DECIMAL(18,2) COMMENT 'Percentage of received materials that passed incoming quality inspection without rejection or rework over the evaluation period. Key performance indicator (KPI) for supplier quality performance. Expressed as percentage (0.00 to 100.00).',
    `relationship_end_date` DATE COMMENT 'Date when the business relationship with this supplier was terminated or the vendor record was deactivated. Null for active suppliers. Used for supplier lifecycle tracking and historical analysis.',
    `relationship_start_date` DATE COMMENT 'Date when the business relationship with this supplier was established and the vendor record was first activated. Used for relationship tenure analysis and supplier lifecycle reporting.',
    `risk_rating` STRING COMMENT 'Overall risk assessment for the supplier based on financial stability, geopolitical factors, quality performance, delivery reliability, and compliance history. Used for supply chain risk management and contingency planning.. Valid values are `low|medium|high|critical`',
    `sap_vendor_number` STRING COMMENT 'Vendor master number from SAP S/4HANA MM (Materials Management) or SAP Ariba. This is the authoritative supplier identifier in the ERP system used for procurement transactions.',
    `small_business` BOOLEAN COMMENT 'Indicates whether the supplier qualifies as a small business based on revenue, employee count, or regulatory definitions. Used for small business procurement programs and compliance reporting.',
    `supplier_category` STRING COMMENT 'Strategic classification indicating the suppliers relationship tier and procurement priority. Strategic suppliers are critical long-term partners, preferred suppliers have favorable terms, approved suppliers meet minimum standards, conditional suppliers are under review, blocked suppliers are prohibited from new business.. Valid values are `strategic|preferred|approved|conditional|blocked`',
    `supplier_status` STRING COMMENT 'Current lifecycle status of the supplier relationship. Active suppliers are approved for procurement, inactive suppliers are no longer used, suspended suppliers are temporarily restricted, pending_approval suppliers are under qualification review, blocked suppliers are prohibited from new transactions.. Valid values are `active|inactive|suspended|pending_approval|blocked`',
    `tax_number` STRING COMMENT 'Government-issued tax identification number for the supplier (e.g., EIN in USA, VAT number in EU, GST number in India). Used for tax reporting, invoice validation, and compliance.',
    `vendor_code` STRING COMMENT 'Internal alphanumeric code assigned to the supplier for identification across procurement, quality, and supply chain systems. Often synchronized with SAP vendor master number.',
    `vendor_name` STRING COMMENT 'Full legal name of the supplier organization as registered with incorporation authorities. Used for contracts, purchase orders, and legal documentation.',
    `woman_owned` BOOLEAN COMMENT 'Indicates whether the supplier is certified as a woman-owned business enterprise. Used for diversity supplier programs and regulatory reporting.',
    `created_by` STRING COMMENT 'User ID or name of the person who created this supplier master record. Used for accountability, audit trails, and data governance.',
    CONSTRAINT pk_supplier PRIMARY KEY(`supplier_id`)
) COMMENT 'Core master entity representing the authoritative supplier identity record (SSOT) for all vendors, sub-contractors, and raw material suppliers engaged by Manufacturing. Captures legal entity name, DUNS number, tax ID, SAP vendor master number (from SAP Ariba/S4HANA MM), business type (OEM, distributor, raw material, MRO), incorporation country, headquarters address, primary contact, preferred currency, payment terms, incoterms, and active status. This is the golden record used across procurement, quality, supply chain, and logistics domains.';

CREATE OR REPLACE TABLE `manufacturing_ecm`.`supplier`.`site` (
    `site_id` BIGINT COMMENT 'Primary key for site',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Site‑specific cost allocation for production capacity spend (Site Cost Allocation process).',
    `supplier_id` BIGINT COMMENT 'Reference to the parent vendor legal entity that owns this site. Links to the vendor master record.',
    `active_from_date` DATE COMMENT 'Date when the vendor site became active and eligible for procurement transactions.',
    `active_to_date` DATE COMMENT 'Date when the vendor site was deactivated or disqualified. Null for currently active sites.',
    `address_line_1` STRING COMMENT 'Primary street address of the vendor site facility. Organizational contact data classified as confidential.',
    `address_line_2` STRING COMMENT 'Secondary address information such as building, suite, or floor number. Organizational contact data classified as confidential.',
    `approved_for_new_business` BOOLEAN COMMENT 'Indicates whether the vendor site is approved to receive new purchase orders and sourcing awards.',
    `capacity_unit_of_measure` STRING COMMENT 'Unit of measure for the production capacity metric such as units, tons, liters, or square meters.',
    `certification_expiry_date` DATE COMMENT 'Date when the primary quality management certification expires. Used to trigger recertification workflows.',
    `city` STRING COMMENT 'City or municipality where the vendor site is located. Organizational contact data classified as confidential.',
    `country_code` STRING COMMENT 'Three-letter ISO country code for the vendor site location. Used for trade compliance, tariff calculation, and regional risk assessment.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the vendor site record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO currency code for transactions with this vendor site.. Valid values are `^[A-Z]{3}$`',
    `delivery_performance_score` DECIMAL(18,2) COMMENT 'On-time delivery performance score for the vendor site. Scale 0-100.',
    `duns_number` STRING COMMENT 'Dun and Bradstreet Universal Numbering System identifier for the vendor site. Used for credit assessment and supplier verification.. Valid values are `^[0-9]{9}$`',
    `geographic_region` STRING COMMENT 'Macro-geographic region classification for supply chain planning and regional sourcing strategy.. Valid values are `north_america|south_america|europe|asia_pacific|middle_east|africa`',
    `iatf_16949_certified` BOOLEAN COMMENT 'Indicates whether the vendor site holds IATF 16949 automotive quality management certification. Required for automotive supply chain participation.',
    `iso_14001_certified` BOOLEAN COMMENT 'Indicates whether the vendor site holds ISO 14001 Environmental Management System certification.',
    `iso_45001_certified` BOOLEAN COMMENT 'Indicates whether the vendor site holds ISO 45001 Occupational Health and Safety Management System certification.',
    `iso_9001_certified` BOOLEAN COMMENT 'Indicates whether the vendor site holds ISO 9001 Quality Management System certification. Critical for supplier qualification.',
    `last_audit_date` DATE COMMENT 'Date of the most recent quality or compliance audit conducted at the vendor site.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the vendor site record was last updated.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the vendor site. Used for logistics optimization and distance calculations.',
    `lead_time_days` STRING COMMENT 'Standard procurement lead time in days from purchase order placement to delivery for this vendor site.',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the vendor site. Used for logistics optimization and distance calculations.',
    `minimum_order_quantity` DECIMAL(18,2) COMMENT 'Minimum order quantity required by the vendor site for purchase orders.',
    `moq_unit_of_measure` STRING COMMENT 'Unit of measure for the minimum order quantity such as pieces, kilograms, or pallets.',
    `next_audit_due_date` DATE COMMENT 'Scheduled date for the next quality or compliance audit at the vendor site.',
    `notes` STRING COMMENT 'Free-text field for additional comments, special instructions, or site-specific considerations relevant to procurement and quality teams.',
    `payment_terms` STRING COMMENT 'Standard payment terms applicable to this vendor site such as Net 30, Net 60, or 2/10 Net 30.',
    `postal_code` STRING COMMENT 'Postal or ZIP code for the vendor site address. Organizational contact data classified as confidential.',
    `preferred_supplier_flag` BOOLEAN COMMENT 'Indicates whether this vendor site has preferred supplier status for strategic sourcing decisions.',
    `primary_contact_email` STRING COMMENT 'Email address of the primary site contact. Organizational contact data classified as confidential.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `primary_contact_name` STRING COMMENT 'Full name of the primary business contact at the vendor site for procurement and quality coordination.',
    `primary_contact_phone` STRING COMMENT 'Primary telephone number for the vendor site contact. Organizational contact data classified as confidential.',
    `production_capacity_annual` DECIMAL(18,2) COMMENT 'Annual production capacity of the site in units relevant to the site type. Used for capacity planning and sourcing allocation decisions.',
    `quality_score` DECIMAL(18,2) COMMENT 'Composite quality performance score for the vendor site based on defect rates, audit results, and corrective action responsiveness. Scale 0-100.',
    `risk_rating` STRING COMMENT 'Overall risk classification of the vendor site based on quality performance, financial stability, geopolitical factors, and compliance history.. Valid values are `low|medium|high|critical`',
    `site_code` STRING COMMENT 'Unique alphanumeric code identifying the vendor site. Used for procurement routing and supplier qualification tracking.. Valid values are `^[A-Z0-9]{4,20}$`',
    `site_name` STRING COMMENT 'Business name or designation of the vendor site facility.',
    `site_status` STRING COMMENT 'Current lifecycle status of the vendor site. Controls whether the site is eligible for new purchase orders and sourcing decisions.. Valid values are `active|inactive|suspended|pending_qualification|disqualified`',
    `site_type` STRING COMMENT 'Classification of the vendor site by primary function. Determines sourcing eligibility and capability matching.. Valid values are `manufacturing|distribution|warehouse|service_center|r_and_d|office`',
    `state_province` STRING COMMENT 'State, province, or administrative region of the vendor site. Organizational contact data classified as confidential.',
    `tax_registration_number` STRING COMMENT 'Tax identification or VAT registration number for the vendor site. Used for tax compliance and invoice validation.',
    CONSTRAINT pk_site PRIMARY KEY(`site_id`)
) COMMENT 'Represents a specific physical manufacturing, warehouse, or service site belonging to a vendor. A single vendor legal entity may operate multiple sites with distinct capabilities, certifications, and risk profiles. Captures site address, site type (manufacturing, distribution, R&D), production capacity, geographic region, ISO certification scope, and site-level contact. Used by procurement and quality to route sourcing decisions to the correct facility.';

CREATE OR REPLACE TABLE `manufacturing_ecm`.`supplier`.`supplier_contact` (
    `supplier_contact_id` BIGINT COMMENT 'Primary key for contact',
    `supplier_id` BIGINT COMMENT 'Reference to the parent vendor organization this contact belongs to. Links to the supplier master record.',
    `site_id` BIGINT COMMENT 'Foreign key linking to supplier.site. Business justification: Supplier contacts are physically located at specific supplier sites. The supplier_contact table has office_location (STRING) but no normalized site FK. Adding vendor_site_id (nullable) enables site-le',
    `certification_held` STRING COMMENT 'Professional certifications or qualifications held by the contact relevant to their role (e.g., Six Sigma Black Belt, PMP, ISO Lead Auditor, APICS CPIM). Multiple certifications separated by semicolon.',
    `communication_preference` STRING COMMENT 'Preferred method of communication for reaching this contact for routine supplier relationship activities.. Valid values are `email|phone|mobile|portal|fax`',
    `contact_role` STRING COMMENT 'Primary functional role of the contact in the supplier relationship. Determines routing of communications and escalations.. Valid values are `commercial|technical|quality|logistics|executive|after_sales`',
    `contact_status` STRING COMMENT 'Current lifecycle status of the vendor contact. Inactive or terminated contacts should not receive communications.. Valid values are `active|inactive|on_leave|terminated`',
    `contact_type` STRING COMMENT 'Classification of the contact based on their priority and purpose in the supplier relationship hierarchy.. Valid values are `primary|secondary|escalation|technical_support|billing`',
    `created_by_user` STRING COMMENT 'User ID or username of the person who created this vendor contact record. Used for audit trail and accountability.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this vendor contact record was first created in the system. Used for audit trail and data lineage.',
    `department` STRING COMMENT 'Department or functional area within the vendor organization where the contact works (e.g., Sales, Quality Assurance, Logistics, Engineering, Customer Service).',
    `effective_end_date` DATE COMMENT 'Date when this contact ceased to be active or left the vendor organization. Null for currently active contacts.',
    `effective_start_date` DATE COMMENT 'Date when this contact became active and available for supplier relationship management activities.',
    `email_address` STRING COMMENT 'Primary email address for the vendor contact. Used for procurement communications, quality notifications, and supply chain coordination.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `escalation_level` STRING COMMENT 'Numeric escalation tier for this contact in the supplier relationship hierarchy. Level 1 is first point of contact, higher numbers represent management escalation paths.',
    `first_name` STRING COMMENT 'First name or given name of the vendor contact person.',
    `full_name` STRING COMMENT 'Complete name of the vendor contact person, typically concatenation of first and last name.',
    `interaction_frequency_days` STRING COMMENT 'Target frequency in days for regular business interactions with this contact. Used for relationship management planning and alerts.',
    `is_decision_maker` BOOLEAN COMMENT 'Flag indicating whether this contact has decision-making authority for commercial negotiations, contract approvals, or strategic supplier relationship matters.',
    `is_primary_contact` BOOLEAN COMMENT 'Flag indicating whether this contact is the primary point of contact for the vendor organization. Only one primary contact should exist per vendor.',
    `job_title` STRING COMMENT 'Official job title or position of the vendor contact within their organization (e.g., Account Manager, Quality Engineer, Logistics Coordinator, Sales Director).',
    `last_interaction_date` DATE COMMENT 'Date of the most recent business interaction or communication with this contact. Used for relationship health monitoring.',
    `last_modified_by_user` STRING COMMENT 'User ID or username of the person who most recently modified this vendor contact record. Used for audit trail and accountability.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this vendor contact record was most recently updated. Used for audit trail and change tracking.',
    `last_name` STRING COMMENT 'Last name or family name of the vendor contact person.',
    `linkedin_profile_url` STRING COMMENT 'URL to the contacts LinkedIn professional profile. Used for relationship intelligence and network mapping.',
    `mobile_number` STRING COMMENT 'Mobile phone number for the vendor contact. Used for urgent supply chain escalations and on-call support.',
    `notes` STRING COMMENT 'Free-text notes and observations about the contact, including communication preferences, relationship history, special considerations, or other relevant context for supplier relationship management.',
    `phone_number` STRING COMMENT 'Primary telephone number for the vendor contact. Includes country code and extension where applicable.',
    `preferred_language` STRING COMMENT 'ISO 639-2 three-letter language code representing the contacts preferred language for business communications (e.g., ENG, DEU, FRA, SPA, CHI, JPN).. Valid values are `^[A-Z]{3}$`',
    `relationship_strength_score` DECIMAL(18,2) COMMENT 'Quantitative score (0-100) representing the strength and quality of the business relationship with this contact. Based on interaction frequency, responsiveness, collaboration quality, and business outcomes.',
    `specialization_area` STRING COMMENT 'Specific area of expertise or specialization for the contact (e.g., electrification products, automation systems, quality management, supply chain logistics, contract negotiation).',
    `time_zone` STRING COMMENT 'IANA time zone identifier for the contacts primary work location (e.g., America/New_York, Europe/Berlin, Asia/Shanghai). Used for scheduling meetings and coordinating real-time communications.',
    `years_of_experience` STRING COMMENT 'Total years of professional experience the contact has in their field or industry. Used for relationship quality assessment.',
    CONSTRAINT pk_supplier_contact PRIMARY KEY(`supplier_contact_id`)
) COMMENT 'Tracks individual contacts associated with a vendor organization, including account managers, quality engineers, logistics coordinators, and executive sponsors. Captures full name, job title, department, email, phone, preferred language, contact role (commercial, technical, quality, logistics), and active status. Supports multi-threaded supplier relationship management across procurement, quality, and after-sales functions.';

CREATE OR REPLACE TABLE `manufacturing_ecm`.`supplier`.`qualification` (
    `qualification_id` BIGINT COMMENT 'Unique identifier for the supplier qualification record. Primary key.',
    `account_site_id` BIGINT COMMENT 'Foreign key linking to customer.account_site. Business justification: Customer site-specific supplier qualification (PPAP/APQP): in industrial manufacturing, a supplier is qualified to supply a specific customer plant. Qualification scope is customer-site-bound (e.g., a',
    `commodity_category_id` BIGINT COMMENT 'Foreign key linking to finance.commodity_category. Business justification: Supplier qualification in industrial manufacturing is scoped per commodity category — qualification gates procurement for specific commodity groups. commodity_category is a plain-text denormalized col',
    `family_id` BIGINT COMMENT 'Foreign key linking to product.family. Business justification: Supplier qualification in industrial manufacturing is scoped to product families (e.g., PPAP qualification for servo drives family, IATF qualification for electrification components). The existing par',
    `supplier_certification_id` BIGINT COMMENT 'Foreign key linking to supplier.supplier_certification. Business justification: A qualification record requires specific certifications (currently stored as a string in certification_required). Normalizing this to a FK to supplier_certification.supplier_certification_id allows th',
    `supplier_id` BIGINT COMMENT 'Reference to the supplier being qualified. Links to the supplier master data entity.',
    `site_id` BIGINT COMMENT 'Foreign key linking to supplier.site. Business justification: Supplier qualifications are frequently site-specific in industrial manufacturing — a suppliers site A may be qualified for aerospace components while site B is not. The qualification table already li',
    `affected_commodities` STRING COMMENT 'Comma-separated list or description of commodity categories affected by a disqualification event. Null if not disqualified or if disqualification is global.',
    `approval_date` DATE COMMENT 'Date when the supplier was formally approved for the specified scope. Null if not yet approved or if disqualified.',
    `audit_date` DATE COMMENT 'Date when the on-site or remote supplier audit was conducted as part of the qualification process. Null if no audit was performed.',
    `audit_score` DECIMAL(18,2) COMMENT 'Numerical score from the supplier qualification audit, typically expressed as a percentage (0.00 to 100.00). Null if no audit was conducted.',
    `basis` STRING COMMENT 'Primary method or standard used to qualify the supplier: PPAP (Production Part Approval Process), APQP (Advanced Product Quality Planning), on-site audit, sample approval, document review, third-party certification (ISO, UL, etc.), or legacy performance history. [ENUM-REF-CANDIDATE: ppap|apqp|on_site_audit|sample_approval|document_review|third_party_certification|legacy_performance — 7 candidates stripped; promote to reference product]',
    `conditional_approval_expiry_date` DATE COMMENT 'Date by which the supplier must satisfy conditional approval requirements to achieve full approval status. Null if not conditionally approved.',
    `conditional_approval_reason` STRING COMMENT 'Explanation of why the supplier was granted conditional approval rather than full approval, including specific restrictions or pending actions. Null if not conditionally approved.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the qualification record was first created in the system.',
    `disqualification_date` DATE COMMENT 'Date when the supplier was formally disqualified or approval was revoked. Null if not disqualified.',
    `disqualification_reason` STRING COMMENT 'Detailed explanation of why the supplier was disqualified or rejected, including specific quality, delivery, compliance, or financial issues. Null if not disqualified.',
    `document_reference` STRING COMMENT 'Reference identifier or link to the formal qualification documentation package, including audit reports, PPAP submissions, certificates, and approval memos.',
    `evaluation_end_date` DATE COMMENT 'Date when the qualification evaluation was completed and a decision was rendered.',
    `evaluation_notes` STRING COMMENT 'Free-text field capturing additional observations, findings, or context from the qualification evaluation process.',
    `evaluation_start_date` DATE COMMENT 'Date when the formal supplier qualification evaluation process was initiated.',
    `evaluation_team` STRING COMMENT 'Comma-separated list or description of the cross-functional team members who participated in the supplier qualification evaluation (e.g., quality, engineering, procurement, operations).',
    `expiry_date` DATE COMMENT 'Date when the qualification approval expires and re-qualification is required. Null for indefinite approvals or disqualified suppliers.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the qualification record was last updated, reflecting the most recent change to status, scope, or other attributes.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next periodic review or re-qualification assessment of the supplier. Null if no review is scheduled or if disqualified.',
    `ppap_level` STRING COMMENT 'PPAP submission level required or achieved (Level 1 through Level 5), or not applicable if PPAP was not the qualification basis. Higher levels require more comprehensive documentation.. Valid values are `level_1|level_2|level_3|level_4|level_5|not_applicable`',
    `qualification_number` STRING COMMENT 'Business identifier for the qualification record, typically system-generated and used in external communications and audit trails.. Valid values are `^QF-[0-9]{8}$`',
    `qualification_status` STRING COMMENT 'Current lifecycle status of the supplier qualification: prospective (initial inquiry), under evaluation (assessment in progress), approved (fully qualified), conditional (approved with restrictions or pending actions), disqualified (rejected or revoked), expired (approval period lapsed).. Valid values are `prospective|under_evaluation|approved|conditional|disqualified|expired`',
    `qualification_type` STRING COMMENT 'Type of qualification event: new supplier onboarding, periodic re-qualification, extension to new commodity categories, disqualification action, or conditional approval pending corrective action.. Valid values are `new_supplier|re_qualification|commodity_extension|disqualification|conditional_approval`',
    `re_qualification_conditions` STRING COMMENT 'Specific conditions or corrective actions the supplier must complete before being eligible for re-qualification. Null if not applicable or if permanently disqualified.',
    `re_qualification_eligible` BOOLEAN COMMENT 'Indicates whether a disqualified supplier is eligible to apply for re-qualification in the future. True if eligible, False if permanently disqualified.',
    `risk_rating` STRING COMMENT 'Overall risk assessment of the supplier at the time of qualification: low (minimal risk), medium (manageable risk), high (significant risk requiring mitigation), critical (unacceptable risk without immediate action).. Valid values are `low|medium|high|critical`',
    `scope_description` STRING COMMENT 'Detailed textual description of the qualification scope, including specific materials, processes, or services the supplier is approved to provide.',
    `transition_plan_reference` STRING COMMENT 'Reference identifier or document number for the supplier transition or phase-out plan in the event of disqualification. Null if not applicable.',
    CONSTRAINT pk_qualification PRIMARY KEY(`qualification_id`)
) COMMENT 'Records the formal supplier qualification lifecycle for each vendor, tracking whether a vendor has been approved or disqualified for specific commodity categories or part families. Captures qualification status (prospective, under evaluation, approved, conditional, disqualified), qualification type (new supplier, re-qualification, commodity extension, disqualification), evaluation start/end dates, approving engineer, qualification basis (PPAP, APQP, audit, sample approval), expiry date, and for disqualification events: disqualification reason, affected commodities, transition plan reference, and re-qualification eligibility. Managed in SAP Ariba and aligned with PPAP/APQP standards.';

CREATE OR REPLACE TABLE `manufacturing_ecm`.`supplier`.`scorecard` (
    `scorecard_id` BIGINT COMMENT 'Unique identifier for the supplier performance scorecard record.',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: Supplier scorecards are issued by purchasing organizations within a company code in multi-entity industrial manufacturers. Scorecard results feed into company-code-level spend analytics and supplier r',
    `supplier_id` BIGINT COMMENT 'Reference to the supplier being evaluated in this scorecard.',
    `site_id` BIGINT COMMENT 'Foreign key linking to supplier.site. Business justification: Scorecards can be scoped to a specific supplier site, not just the supplier as a whole. A supplier with multiple manufacturing sites may have different delivery and quality performance per site. Addin',
    `approved_timestamp` TIMESTAMP COMMENT 'Timestamp when the scorecard was officially approved by the designated approver.',
    `capa_count` STRING COMMENT 'Total number of corrective and preventive action requests issued to this supplier during the evaluation period.',
    `comments` STRING COMMENT 'Additional comments, notes, or contextual information about the scorecard evaluation and results.',
    `cost_score` DECIMAL(18,2) COMMENT 'Performance score for the cost pillar, measuring price competitiveness, cost variance, and total cost of ownership, expressed as a percentage (0-100).',
    `cost_variance_percentage` DECIMAL(18,2) COMMENT 'Percentage variance between actual costs and target or budgeted costs during the evaluation period, where negative values indicate cost savings.',
    `cost_weight_percentage` DECIMAL(18,2) COMMENT 'Percentage weight assigned to the cost pillar in the overall score calculation.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the scorecard record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for monetary values in this scorecard.. Valid values are `^[A-Z]{3}$`',
    `delivery_score` DECIMAL(18,2) COMMENT 'Performance score for the delivery pillar, measuring on-time delivery performance and schedule adherence, expressed as a percentage (0-100).',
    `delivery_weight_percentage` DECIMAL(18,2) COMMENT 'Percentage weight assigned to the delivery pillar in the overall score calculation.',
    `evaluation_methodology` STRING COMMENT 'Description of the scoring methodology, weighting scheme, and calculation approach used for this scorecard evaluation.',
    `evaluation_period_end_date` DATE COMMENT 'The end date of the performance evaluation period covered by this scorecard.',
    `evaluation_period_start_date` DATE COMMENT 'The start date of the performance evaluation period covered by this scorecard.',
    `improvement_actions_required` STRING COMMENT 'Summary of required improvement actions or corrective measures the supplier must implement based on scorecard results.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the scorecard record was last modified or updated.',
    `ncr_count` STRING COMMENT 'Total number of non-conformance reports issued against this supplier during the evaluation period.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next performance review or scorecard evaluation for this supplier.',
    `otd_percentage` DECIMAL(18,2) COMMENT 'Percentage of deliveries received on or before the scheduled delivery date during the evaluation period, a key delivery performance indicator.',
    `overall_score` DECIMAL(18,2) COMMENT 'Composite overall performance score for the supplier, typically calculated as a weighted average of individual pillar scores, expressed as a percentage (0-100).',
    `period_type` STRING COMMENT 'The frequency or type of evaluation period for this scorecard (monthly, quarterly, annual, or ad-hoc).. Valid values are `monthly|quarterly|semi-annual|annual|ad-hoc`',
    `ppm_defect_rate` DECIMAL(18,2) COMMENT 'Number of defective parts per million parts received during the evaluation period, a key quality performance indicator.',
    `previous_rating_tier` STRING COMMENT 'The rating tier assigned to the supplier in the previous evaluation period, used for trend analysis and tier movement tracking.. Valid values are `preferred|approved|conditional|development|probation|disqualified`',
    `published_date` DATE COMMENT 'The date when the scorecard was officially published and communicated to the supplier.',
    `quality_score` DECIMAL(18,2) COMMENT 'Performance score for the quality pillar, measuring defect rates, non-conformances, and quality compliance, expressed as a percentage (0-100).',
    `quality_weight_percentage` DECIMAL(18,2) COMMENT 'Percentage weight assigned to the quality pillar in the overall score calculation.',
    `rating_tier` STRING COMMENT 'Strategic classification tier assigned to the supplier based on scorecard performance, driving sourcing decisions and supplier development programs.. Valid values are `preferred|approved|conditional|development|probation|disqualified`',
    `responsiveness_index` DECIMAL(18,2) COMMENT 'Composite index measuring supplier responsiveness across communication, issue resolution, and collaboration dimensions, expressed as a percentage (0-100).',
    `responsiveness_score` DECIMAL(18,2) COMMENT 'Performance score for the responsiveness pillar, measuring communication effectiveness, issue resolution speed, and collaboration quality, expressed as a percentage (0-100).',
    `responsiveness_weight_percentage` DECIMAL(18,2) COMMENT 'Percentage weight assigned to the responsiveness pillar in the overall score calculation.',
    `rma_count` STRING COMMENT 'Total number of return material authorizations processed for defective or non-conforming materials from this supplier during the evaluation period.',
    `scorecard_number` STRING COMMENT 'Business identifier for the scorecard, typically formatted as a human-readable code used in reports and communications.',
    `scorecard_status` STRING COMMENT 'Current lifecycle status of the scorecard indicating its approval and publication state.. Valid values are `draft|in-review|approved|published|archived`',
    `strengths_summary` STRING COMMENT 'Summary of the suppliers key strengths and positive performance areas identified during the evaluation period.',
    `total_line_items_evaluated` STRING COMMENT 'Total number of purchase order line items included in the evaluation period for this scorecard.',
    `total_orders_evaluated` STRING COMMENT 'Total number of purchase orders included in the evaluation period for this scorecard.',
    `total_purchase_value` DECIMAL(18,2) COMMENT 'Total monetary value of purchases from this supplier during the evaluation period, used for spend-weighted performance analysis.',
    `total_receipts_evaluated` STRING COMMENT 'Total number of goods receipts or deliveries included in the evaluation period for this scorecard.',
    `weaknesses_summary` STRING COMMENT 'Summary of the suppliers key weaknesses and performance gaps identified during the evaluation period.',
    CONSTRAINT pk_scorecard PRIMARY KEY(`scorecard_id`)
) COMMENT 'Periodic supplier performance scorecard capturing aggregated KPI results across quality, delivery, cost, and responsiveness dimensions for a defined evaluation period (monthly, quarterly, annual). Stores overall score, individual pillar scores (OTD — On-Time Delivery, PPM — Parts Per Million defect rate, cost variance, responsiveness index), scorecard period, rating tier (preferred, approved, conditional, development), and issuing buyer. Drives strategic sourcing decisions and supplier development programs.';

CREATE OR REPLACE TABLE `manufacturing_ecm`.`supplier`.`supplier_audit` (
    `supplier_audit_id` BIGINT COMMENT 'Unique identifier for the supplier audit record. Primary key.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Audit costs (cost, cost_currency_code fields) must be charged to a cost center for budget tracking and departmental spend reporting. Industrial manufacturing procurement teams track audit expenditure ',
    `engineering_specification_id` BIGINT COMMENT 'Foreign key linking to engineering.engineering_specification. Business justification: Specification compliance audit: supplier audits in industrial manufacturing verify compliance with specific engineering specifications (special processes, material standards). Linking audit→specificat',
    `project_id` BIGINT COMMENT 'Foreign key linking to engineering.engineering_project. Business justification: APQP supplier audit: during NPI/APQP projects, supplier audits are conducted as a formal project gate (e.g., production readiness review). Linking audit→engineering_project enables program managers to',
    `supplier_id` BIGINT COMMENT 'Reference to the supplier being audited. Links to the supplier master data.',
    `site_id` BIGINT COMMENT 'Foreign key linking to supplier.supplier_site. Business justification: Site‑specific audit information; each audit occurs at a particular supplier site, enabling site‑level risk tracking and reporting.',
    `approved_by` STRING COMMENT 'Name of the quality manager or procurement director who approved the final audit report and findings.',
    `approved_date` DATE COMMENT 'Date when the audit report was formally approved by the quality or procurement management.',
    `audit_date` DATE COMMENT 'The date when the supplier audit was conducted at the vendor site. This is the principal business event timestamp for the audit.',
    `audit_method` STRING COMMENT 'Method used to conduct the audit: on-site visit, remote audit via video conference, hybrid approach, or document review only.. Valid values are `on_site|remote|hybrid|document_review`',
    `audit_number` STRING COMMENT 'Externally-known unique audit reference number assigned by the quality or procurement team for tracking and documentation purposes.',
    `audit_result` STRING COMMENT 'Overall outcome of the supplier audit: pass (no critical or major findings), conditional pass (findings require corrective action within timeframe), fail (critical findings or inability to meet standards), or pending (awaiting final determination).. Valid values are `pass|conditional_pass|fail|pending`',
    `audit_scope` STRING COMMENT 'Detailed description of the audit scope including specific processes, departments, product lines, or standards being evaluated during the audit.',
    `audit_status` STRING COMMENT 'Current lifecycle status of the audit: scheduled (planned but not started), in progress (fieldwork underway), completed (audit finished and report issued), cancelled (audit did not proceed), or report pending (fieldwork complete, awaiting final report).. Valid values are `scheduled|in_progress|completed|cancelled|report_pending`',
    `audit_type` STRING COMMENT 'Classification of the audit based on its focus area: quality system audits (ISO 9001, IATF 16949), process audits, environmental audits (ISO 14001), cybersecurity audits (IEC 62443), social compliance audits, financial audits, or product audits. [ENUM-REF-CANDIDATE: quality_system|process|environmental|cybersecurity|social_compliance|financial|product — 7 candidates stripped; promote to reference product]',
    `auditor_comments` STRING COMMENT 'Free-text comments and observations from the lead auditor summarizing key findings, strengths, and areas for improvement.',
    `capa_completion_date` DATE COMMENT 'Actual date when all required corrective and preventive actions were verified as complete and closed.',
    `capa_due_date` DATE COMMENT 'Target date by which the supplier must complete and submit corrective and preventive actions to address audit findings.',
    `capa_required_flag` BOOLEAN COMMENT 'Boolean indicator whether corrective and preventive action (CAPA) is required from the supplier to address audit findings.',
    `certification_standard` STRING COMMENT 'The specific certification standard or framework being audited against, such as ISO 9001, IATF 16949, ISO 14001, ISO 45001, IEC 62443, or other industry-specific standards.',
    `cost` DECIMAL(18,2) COMMENT 'Total cost incurred for conducting the audit, including auditor fees, travel expenses, and administrative costs.',
    `cost_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the audit cost (e.g., USD, EUR, CNY).. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the supplier audit record was first created in the system.',
    `critical_findings_count` STRING COMMENT 'Number of critical non-conformances or findings identified during the audit that pose immediate risk to quality, safety, or compliance and require urgent corrective action.',
    `end_date` DATE COMMENT 'The date when the audit fieldwork was completed, applicable for multi-day audits.',
    `follow_up_audit_date` DATE COMMENT 'Scheduled or actual date of the follow-up audit conducted to verify corrective action effectiveness.',
    `follow_up_audit_required_flag` BOOLEAN COMMENT 'Boolean indicator whether a follow-up audit is required to verify implementation and effectiveness of corrective actions.',
    `frequency_months` STRING COMMENT 'Standard audit frequency interval in months for this supplier based on risk classification and business requirements (e.g., 12, 24, 36 months).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the supplier audit record was last updated or modified in the system.',
    `lead_auditor_name` STRING COMMENT 'Full name of the lead auditor responsible for conducting and overseeing the supplier audit.',
    `location` STRING COMMENT 'Physical location or site where the audit was conducted, typically the supplier facility address or site name.',
    `major_findings_count` STRING COMMENT 'Number of major non-conformances or findings identified during the audit that represent significant deviations from standards or requirements.',
    `minor_findings_count` STRING COMMENT 'Number of minor non-conformances or findings identified during the audit that represent isolated or low-impact deviations from standards.',
    `next_audit_due_date` DATE COMMENT 'Scheduled date for the next supplier audit based on audit frequency policy, risk rating, and previous audit results.',
    `observation_count` STRING COMMENT 'Number of observations or opportunities for improvement noted during the audit that do not constitute non-conformances but warrant attention.',
    `report_date` DATE COMMENT 'Date when the formal audit report was issued to the supplier and internal stakeholders.',
    `risk_rating_post_audit` STRING COMMENT 'Updated supplier risk rating assigned after the audit based on audit findings and overall performance evaluation.. Valid values are `low|medium|high|critical`',
    `risk_rating_pre_audit` STRING COMMENT 'Supplier risk rating assigned before the audit based on historical performance, criticality, and risk assessment criteria.. Valid values are `low|medium|high|critical`',
    `score` DECIMAL(18,2) COMMENT 'Numerical score assigned to the audit based on evaluation criteria, typically expressed as a percentage or weighted score reflecting overall supplier performance.',
    `source_system` STRING COMMENT 'Name of the operational system from which this audit record originated (e.g., SAP QM, Ariba Supplier Management, or dedicated audit management system).',
    `start_date` DATE COMMENT 'The date when the audit fieldwork commenced, applicable for multi-day audits.',
    `supplier_response` STRING COMMENT 'Free-text response or feedback from the supplier regarding the audit findings and proposed corrective actions.',
    `team_members` STRING COMMENT 'Comma-separated list of additional auditor names who participated in the audit as team members.',
    `total_findings_count` STRING COMMENT 'Total number of all findings (critical, major, minor) identified during the audit, excluding observations.',
    CONSTRAINT pk_supplier_audit PRIMARY KEY(`supplier_audit_id`)
) COMMENT 'Records formal supplier audits conducted at vendor sites, including quality system audits (ISO 9001, IATF 16949), process audits, environmental audits (ISO 14001), cybersecurity audits (IEC 62443), and social compliance audits. Captures audit type, audit date, lead auditor, audit scope, findings count by severity (critical, major, minor), overall audit result (pass, conditional pass, fail), and next scheduled audit date. Linked to CAPA records for finding remediation tracking.';

CREATE OR REPLACE TABLE `manufacturing_ecm`.`supplier`.`supplier_certification` (
    `supplier_certification_id` BIGINT COMMENT 'Unique identifier for the supplier certification record. Primary key for the supplier certification entity.',
    `supplier_id` BIGINT COMMENT 'Reference to the supplier who holds this certification. Links to the supplier master data entity.',
    `site_id` BIGINT COMMENT 'Reference to the specific supplier site or facility where this certification applies. Nullable if certification applies to the entire supplier organization rather than a specific site.',
    `accreditation_body` STRING COMMENT 'The name of the accreditation body that accredits the issuing certification body. Examples include ANAB (ANSI National Accreditation Board), UKAS (United Kingdom Accreditation Service), DAkkS (German Accreditation Body), or other national accreditation authorities.',
    `alert_threshold_days` STRING COMMENT 'The number of days before expiry at which automated alerts should be triggered to notify stakeholders of the upcoming certification expiration. Typical values range from 30 to 180 days.',
    `audit_report_url` STRING COMMENT 'The URL or file path to the most recent audit report document stored in the document management system or cloud storage.',
    `audit_result` STRING COMMENT 'The outcome of the most recent audit. Passed indicates full compliance. Passed with observations indicates minor non-conformances that do not affect certification. Failed indicates major non-conformances. Conditional indicates certification granted pending corrective actions. Deferred indicates the audit decision is postponed.. Valid values are `passed|passed_with_observations|failed|conditional|deferred`',
    `audit_type` STRING COMMENT 'The type of audit that resulted in this certification or its most recent validation. Initial audit is the first certification audit. Surveillance audits are periodic checks. Recertification audits occur at the end of the certification cycle. Special audits address specific issues. Transfer audits occur when changing certification bodies.. Valid values are `initial|surveillance|recertification|special|transfer`',
    `auto_renewal_enabled` BOOLEAN COMMENT 'Boolean flag indicating whether automatic renewal workflows and alerts are enabled for this certification. True if the system should automatically trigger renewal processes and notifications. False if renewal is managed manually.',
    `business_criticality` STRING COMMENT 'The importance of this certification to the business relationship with the supplier. Critical certifications are mandatory for continued business. High criticality certifications are strongly preferred. Medium and low criticality certifications are informational or nice-to-have.. Valid values are `low|medium|high|critical`',
    `certificate_document_url` STRING COMMENT 'The URL or file path to the digital copy of the certification certificate document stored in the document management system or cloud storage.',
    `certification_level` STRING COMMENT 'The tier, grade, or level of certification achieved, if the standard defines multiple levels. Examples include Level 1, Level 2, Level 3 for IEC 62443, or Gold, Silver, Bronze for tiered certification programs.',
    `certification_number` STRING COMMENT 'The unique certificate number or registration number issued by the certifying body. This is the externally-known identifier for the certification.',
    `certification_status` STRING COMMENT 'The current lifecycle status of the certification. Active indicates the certification is valid and in good standing. Expired indicates the certification has passed its expiry date. Suspended indicates temporary suspension by the issuing body. Revoked indicates permanent withdrawal. Pending renewal indicates the certification is in the renewal process. Under review indicates the certification is being audited or reassessed.. Valid values are `active|expired|suspended|revoked|pending_renewal|under_review`',
    `certification_type` STRING COMMENT 'The category or domain of the certification. Classifies certifications into quality management, environmental management, health and safety, energy management, cybersecurity, product safety, industry-specific standards, or regulatory compliance. [ENUM-REF-CANDIDATE: quality|environmental|health_safety|energy|cybersecurity|product_safety|industry_specific|regulatory_compliance — 8 candidates stripped; promote to reference product]',
    `certified_processes` STRING COMMENT 'A comma-separated or structured list of specific manufacturing processes, production lines, or operational activities that are covered under this certification. Examples include welding, machining, assembly, testing, or packaging.',
    `certified_products` STRING COMMENT 'A comma-separated or structured list of specific product categories, product families, or SKUs (Stock Keeping Units) that are covered under this certification. Used to gate procurement decisions for regulated commodity categories.',
    `comments` STRING COMMENT 'Free-text field for additional notes, observations, or context about this certification. May include information about special conditions, limitations, or historical context.',
    `corrective_action_due_date` DATE COMMENT 'The deadline by which all required corrective actions must be completed and verified. Failure to meet this date may result in certification suspension or revocation.',
    `corrective_actions_required` BOOLEAN COMMENT 'Boolean flag indicating whether corrective actions are required to address audit findings. True if corrective actions are pending or in progress. False if no corrective actions are needed or all have been completed.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this certification record was first created in the system. Audit trail field for data lineage and compliance tracking.',
    `effective_date` DATE COMMENT 'The date from which the certification becomes effective and valid for business use. May differ from issue date if there is a grace period or transition period.',
    `expiry_date` DATE COMMENT 'The date on which the certification expires and is no longer valid. Critical for triggering renewal workflows and procurement gating decisions.',
    `gated_commodity_categories` STRING COMMENT 'A comma-separated list of commodity categories or material groups for which this certification is mandatory. Procurement of these commodities from this supplier is blocked if the certification is not active and valid.',
    `geographic_scope` STRING COMMENT 'The geographic regions, countries, or markets where this certification is recognized and valid. Examples include USA, EU, China, or Global. Uses 3-letter ISO country codes where applicable.',
    `issue_date` DATE COMMENT 'The date on which the certification was originally issued by the certifying body. Represents the start of the certification validity period.',
    `issuing_body` STRING COMMENT 'The name of the certification body, registrar, or regulatory authority that issued the certification. Examples include TUV, BSI, DNV, SGS, UL, Intertek, Bureau Veritas, LRQA, or government agencies.',
    `last_audit_date` DATE COMMENT 'The date of the most recent surveillance audit or recertification audit conducted by the certifying body to verify ongoing compliance with the certification standard.',
    `last_updated_by` STRING COMMENT 'The user identifier or system account that most recently modified this certification record. Audit trail field for accountability and data lineage.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'The date and time when this certification record was most recently modified. Audit trail field for data lineage and compliance tracking.',
    `major_nonconformance_count` STRING COMMENT 'The number of major non-conformances identified during the most recent audit. Major non-conformances are serious violations that can lead to certification suspension or revocation.',
    `minor_nonconformance_count` STRING COMMENT 'The number of minor non-conformances identified during the most recent audit. Minor non-conformances are less serious violations that require corrective action but do not immediately threaten certification status.',
    `next_audit_date` DATE COMMENT 'The scheduled date for the next surveillance audit or recertification audit. Used for planning and ensuring continuous compliance.',
    `nonconformance_count` STRING COMMENT 'The total number of non-conformances (major and minor) identified during the most recent audit. Used to assess the suppliers compliance maturity and risk level.',
    `procurement_gate_enabled` BOOLEAN COMMENT 'Boolean flag indicating whether this certification is used to gate procurement decisions. True if suppliers without valid certification in this standard cannot be selected for certain commodity categories. False if the certification is informational only.',
    `renewal_date` DATE COMMENT 'The target date by which the certification renewal process must be completed to avoid expiration. Typically occurs before the expiry date to allow for processing time.',
    `renewal_status` STRING COMMENT 'The current status of the certification renewal process. Not due indicates renewal is not yet required. Renewal initiated indicates the renewal process has started. Renewal in progress indicates active renewal activities. Renewal completed indicates successful renewal. Renewal overdue indicates the renewal deadline has passed.. Valid values are `not_due|renewal_initiated|renewal_in_progress|renewal_completed|renewal_overdue`',
    `risk_rating` STRING COMMENT 'The risk level associated with this certification based on its status, expiry proximity, audit findings, and business criticality. Low indicates minimal risk. Medium indicates moderate risk requiring monitoring. High indicates significant risk requiring action. Critical indicates immediate risk requiring urgent intervention.. Valid values are `low|medium|high|critical`',
    `scope_of_certification` STRING COMMENT 'A detailed description of the scope, activities, products, services, or processes covered by this certification. Defines the boundaries and applicability of the certification within the suppliers operations.',
    `standard` STRING COMMENT 'The regulatory, quality, or industry standard that this certification represents. Examples include ISO 9001 (Quality Management), ISO 14001 (Environmental Management), ISO 45001 (Occupational Health and Safety), ISO 50001 (Energy Management), IEC 62443 (Industrial Cybersecurity), IATF 16949 (Automotive Quality), AS9100 (Aerospace Quality), UL (Product Safety), CE Marking (European Conformity), RoHS (Restriction of Hazardous Substances), and REACH (Chemical Safety). [ENUM-REF-CANDIDATE: ISO 9001|ISO 14001|ISO 45001|ISO 50001|IEC 62443|IATF 16949|AS9100|UL|CE Marking|RoHS|REACH|ISO 27001|ISO 13485|OHSAS 18001 — 14 candidates stripped; promote to reference product]',
    `verification_date` DATE COMMENT 'The date on which the certification was last verified by internal quality assurance or procurement teams. Verification includes confirming the certificate is authentic, current, and matches the suppliers claims.',
    `verification_method` STRING COMMENT 'The method used to verify the certification. Document review indicates verification by examining the certificate document. Certifying body confirmation indicates direct verification with the issuing body. On-site inspection indicates physical verification during a supplier visit. Third-party verification indicates verification by an external auditor. Supplier declaration indicates acceptance of supplier-provided documentation without independent verification.. Valid values are `document_review|certifying_body_confirmation|on_site_inspection|third_party_verification|supplier_declaration`',
    `verified_by` STRING COMMENT 'The name or identifier of the internal employee or quality assurance team member who verified the authenticity and validity of this certification with the issuing body.',
    `created_by` STRING COMMENT 'The user identifier or system account that created this certification record. Audit trail field for accountability and data lineage.',
    CONSTRAINT pk_supplier_certification PRIMARY KEY(`supplier_certification_id`)
) COMMENT 'Tracks all regulatory, quality, and industry certifications held by a vendor or vendor site, including ISO 9001, ISO 14001, ISO 45001, ISO 50001, IEC 62443, UL, CE Marking, IATF 16949, AS9100, and RoHS compliance. Captures certification standard, issuing body, certificate number, issue date, expiry date, scope of certification, and renewal status. Drives automated alerts for expiring certifications and gates procurement decisions for regulated commodity categories.';

CREATE OR REPLACE TABLE `manufacturing_ecm`.`supplier`.`approved_vendor_list` (
    `approved_vendor_list_id` BIGINT COMMENT 'Unique identifier for the approved vendor list entry. Primary key for the AVL record linking a qualified supplier to authorized commodity categories.',
    `account_site_id` BIGINT COMMENT 'Foreign key linking to customer.account_site. Business justification: Site-specific AVL management: in industrial manufacturing, AVLs are scoped to specific customer account sites (factories/plants) that dictate approved suppliers for their production lines. A procureme',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to supplier.agreement. Business justification: AVL entries are typically governed by a framework agreement or quality agreement. The AVL currently stores contract_reference_number as a STRING. Normalizing to agreement_id FK enables direct navigati',
    `commodity_category_id` BIGINT COMMENT 'Foreign key linking to finance.commodity_category. Business justification: AVL management in industrial manufacturing is a commodity-category-driven process — category managers maintain approved vendor lists per commodity. commodity_code and commodity_description are denorma',
    `supplier_id` BIGINT COMMENT 'Reference to the qualified supplier authorized to supply materials or services for the specified commodity category.',
    `qualification_id` BIGINT COMMENT 'Foreign key linking to supplier.qualification. Business justification: An AVL entry should be backed by a formal qualification record — a supplier should only appear on the AVL if they have passed qualification for the relevant commodity. Linking approved_vendor_list.qua',
    `sku_master_id` BIGINT COMMENT 'Foreign key linking to product.sku_master. Business justification: The AVL is the gating document for procurement: no PO can be issued for a SKU without an approved AVL entry. Industrial manufacturing ERP systems (SAP, Oracle) require AVL entries to reference the spe',
    `site_id` BIGINT COMMENT 'Foreign key linking to supplier.site. Business justification: AVL entries in industrial manufacturing are often site-specific — a supplier may be approved for a commodity at their Detroit facility but not their Mexico facility. The AVL has supply_plant_code (STR',
    `annual_spend_target` DECIMAL(18,2) COMMENT 'Target annual procurement spend with this supplier for the specified commodity category, used for volume commitment tracking and supplier relationship management.',
    `approval_date` DATE COMMENT 'Date when the supplier was officially approved for the specified commodity category following qualification audits and assessments.',
    `approved_by_name` STRING COMMENT 'Name of the procurement manager, quality manager, or authorized approver who approved this AVL entry.',
    `avl_number` STRING COMMENT 'Business identifier for the AVL entry used in procurement documents and Material Requirements Planning (MRP) source selection.. Valid values are `^AVL-[A-Z0-9]{8,12}$`',
    `avl_status` STRING COMMENT 'Current lifecycle status of the AVL entry determining whether the supplier can be selected during purchase order creation in Material Requirements Planning (MRP) and procurement processes.. Valid values are `active|suspended|phased_out|pending_approval|expired|blocked`',
    `capacity_rating` STRING COMMENT 'Assessment of the suppliers production capacity and ability to scale volume for this commodity category.. Valid values are `high|medium|low|limited|unlimited`',
    `certification_list` STRING COMMENT 'Comma-separated list of required certifications such as ISO 9001, ISO 14001, IATF 16949, AS9100, or industry-specific quality standards.',
    `certification_required_flag` BOOLEAN COMMENT 'Indicates whether specific certifications (ISO, industry-specific, regulatory) are required for the supplier to maintain AVL status for this commodity.',
    `comments` STRING COMMENT 'Free-text comments providing additional context about the AVL entry, special conditions, restrictions, or notes for procurement teams.',
    `cost_competitiveness_rating` DECIMAL(18,2) COMMENT 'Cost competitiveness rating comparing the suppliers pricing for this commodity against market benchmarks and other approved suppliers.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this AVL record was first created in the system, supporting audit trail and data lineage requirements.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for pricing and invoicing transactions with this supplier for the specified commodity.. Valid values are `^[A-Z]{3}$`',
    `delivery_rating` DECIMAL(18,2) COMMENT 'Current on-time delivery performance rating for the supplier in this commodity category, used in Material Requirements Planning (MRP) source selection.',
    `effective_end_date` DATE COMMENT 'Date when the AVL entry expires or is phased out. Null indicates an open-ended approval with no planned expiration.',
    `effective_start_date` DATE COMMENT 'Date from which the AVL entry becomes active and the supplier can be selected for purchase orders in the specified commodity category.',
    `expedited_lead_time_days` STRING COMMENT 'Expedited lead time in days available for urgent orders, typically shorter than standard lead time but may incur additional costs.',
    `geographic_supply_region` STRING COMMENT 'Three-letter ISO country code or region code indicating the primary geographic region from which the supplier will ship materials for this commodity.. Valid values are `^[A-Z]{3}$`',
    `incoterms` STRING COMMENT 'International Commercial Terms (Incoterms) defining the division of costs and risks between buyer and supplier for shipments under this AVL entry. [ENUM-REF-CANDIDATE: EXW|FCA|CPT|CIP|DAP|DPU|DDP|FAS|FOB|CFR|CIF — 11 candidates stripped; promote to reference product]',
    `last_audit_date` DATE COMMENT 'Date of the most recent supplier audit conducted for this commodity category, supporting ongoing qualification status.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to this AVL record, supporting change tracking and audit requirements.',
    `material_group` STRING COMMENT 'Material group classification code used in Enterprise Resource Planning (ERP) systems to categorize materials and link to approved suppliers.. Valid values are `^[A-Z0-9]{4,8}$`',
    `moq` DECIMAL(18,2) COMMENT 'Minimum Order Quantity (MOQ) required by the supplier for this commodity category. Used by Material Requirements Planning (MRP) to ensure order quantities meet supplier constraints.',
    `moq_unit_of_measure` STRING COMMENT 'Unit of measure for the Minimum Order Quantity (MOQ) such as EA (each), KG (kilogram), M (meter), L (liter).. Valid values are `^[A-Z]{2,3}$`',
    `next_review_date` DATE COMMENT 'Scheduled date for the next periodic review of this AVL entry to assess continued supplier qualification and performance.',
    `part_family` STRING COMMENT 'Part family or product line grouping for which the supplier is qualified to provide components or assemblies.',
    `payment_terms` STRING COMMENT 'Standard payment terms applicable to purchase orders for this supplier and commodity combination, such as Net 30, Net 60, or 2/10 Net 30.',
    `ppap_level` STRING COMMENT 'Production Part Approval Process (PPAP) level required for parts supplied under this AVL entry, ranging from Level 1 (warrant only) to Level 5 (full submission with samples).. Valid values are `level_1|level_2|level_3|level_4|level_5|not_required`',
    `price_validity_end_date` DATE COMMENT 'End date for the current pricing agreement, after which prices must be renegotiated or updated.',
    `price_validity_start_date` DATE COMMENT 'Start date for the current pricing agreement applicable to this AVL entry.',
    `purchasing_group` STRING COMMENT 'Purchasing group or buyer team responsible for managing the supplier relationship and executing purchase orders for this commodity.. Valid values are `^[A-Z0-9]{3}$`',
    `purchasing_organization` STRING COMMENT 'Purchasing organization code responsible for managing this AVL entry and executing procurement transactions with the supplier.. Valid values are `^[A-Z0-9]{4}$`',
    `quality_rating` DECIMAL(18,2) COMMENT 'Current quality performance rating for the supplier in this commodity category, typically expressed as a percentage or score used in supplier selection decisions.',
    `review_frequency_months` STRING COMMENT 'Frequency in months at which this AVL entry must be reviewed and revalidated to ensure continued supplier qualification.',
    `risk_rating` STRING COMMENT 'Overall supply risk rating for this supplier and commodity combination considering financial stability, geopolitical factors, single-source dependency, and business continuity.. Valid values are `low|medium|high|critical`',
    `single_source_flag` BOOLEAN COMMENT 'Indicates whether this supplier is the only approved source for the commodity category, representing a supply chain risk requiring mitigation strategies.',
    `standard_lead_time_days` STRING COMMENT 'Standard procurement lead time in days from purchase order placement to delivery for this supplier and commodity combination. Used by Material Requirements Planning (MRP) for scheduling.',
    `supplier_designation` STRING COMMENT 'Designation indicating the suppliers priority level for sourcing decisions. Preferred suppliers are selected first by Material Requirements Planning (MRP), backup suppliers are used when preferred suppliers cannot fulfill demand.. Valid values are `preferred|approved|backup|conditional|strategic`',
    `supply_plant_code` STRING COMMENT 'Supplier plant or facility code from which materials will be shipped for this commodity category.. Valid values are `^[A-Z0-9]{4,6}$`',
    CONSTRAINT pk_approved_vendor_list PRIMARY KEY(`approved_vendor_list_id`)
) COMMENT 'The Approved Vendor List (AVL) entry linking a qualified vendor to a specific commodity category, material group, or part family for which they are authorized to supply. Captures AVL status (active, suspended, phased-out), commodity code, material group, preferred/backup designation, MOQ (Minimum Order Quantity), lead time, geographic supply region, and approval date. The AVL is the operational gate used by MRP and procurement to select valid sources during purchase order creation in SAP S/4HANA MM.';

CREATE OR REPLACE TABLE `manufacturing_ecm`.`supplier`.`purchase_requisition` (
    `purchase_requisition_id` BIGINT COMMENT 'Primary key for purchase_requisition',
    `account_site_id` BIGINT COMMENT 'Foreign key linking to customer.account_site. Business justification: REQUIRED: Internal requisitions are raised for a specific plant/site; linking enables site‑wise spend analysis.',
    `approved_vendor_list_id` BIGINT COMMENT 'Foreign key linking to supplier.approved_vendor_list. Business justification: When a purchase requisition is created (especially from MRP), the source determination process selects an approved vendor from the AVL. Linking purchase_requisition.approved_vendor_list_id → approved_',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: PRs are raised within a company code context for budget availability checks and approval workflow routing in multi-entity industrial manufacturers. purchasing_organization_code alone is insufficient —',
    `component_id` BIGINT COMMENT 'Foreign key linking to engineering.component. Business justification: Engineering Change Request triggers a purchase requisition for the affected component; linking enables traceability of component‑driven procurement.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Requisition budgeting and approval allocate planned spend to a cost center, essential for budget control.',
    `demand_forecast_id` BIGINT COMMENT 'Foreign key linking to supply.demand_forecast. Business justification: Demand forecasts drive requisitions; the relationship is needed for the Forecast‑Driven Requisition analysis.',
    `eco_id` BIGINT COMMENT 'Foreign key linking to engineering.eco. Business justification: Procurement requisitions are generated from Engineering Change Orders; linking provides audit of ECO‑driven spend.',
    `engineering_revision_id` BIGINT COMMENT 'Foreign key linking to engineering.engineering_revision. Business justification: Revision-controlled procurement: PRs must reference the approved engineering revision to ensure the correct version is procured. This prevents ordering obsolete or unapproved revisions — a critical qu',
    `equipment_register_id` BIGINT COMMENT 'Foreign key linking to asset.equipment_register. Business justification: CAPITAL ACQUISITION: Requisition must reference the equipment record for traceability of requested capital assets.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Requisition may be tied to a GL account for expense planning and forecast alignment.',
    `material_master_id` BIGINT COMMENT 'Identifier of the material or item being requested. Links to the material master data in SAP MM or inventory management system. Null for service or non-stock requisitions.',
    `mrp_run_id` BIGINT COMMENT 'Foreign key linking to supply.mrp_run. Business justification: MRP run creates purchase requisitions; the MRP run ID is required for the MRP Run to Requisition traceability report.',
    `opportunity_id` BIGINT COMMENT 'Foreign key linking to sales.opportunity. Business justification: Procurement creates a requisition based on a sales opportunity to ensure material availability for the promised delivery.',
    `planned_order_id` BIGINT COMMENT 'Foreign key linking to supply.planned_order. Business justification: Planned orders are converted to purchase requisitions; linking them enables the Planned Order Conversion audit.',
    `procurement_contract_id` BIGINT COMMENT 'Identifier of the existing contract or blanket purchase order against which this requisition should be fulfilled. Null for non-contract purchases.',
    `purchase_info_record_id` BIGINT COMMENT 'Foreign key linking to supplier.purchase_info_record. Business justification: In SAP-style procurement (standard in industrial manufacturing), a purchase requisition references a purchase info record for pricing, lead time, and source of supply. Adding purchase_info_record_id F',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to supplier.purchase_order. Business justification: A purchase requisition is converted into a purchase order — this is the core procurement lifecycle transition. The PR currently stores po_number as a STRING. Normalizing to purchase_order_id FK enable',
    `sku_master_id` BIGINT COMMENT 'Foreign key linking to product.sku_master. Business justification: Required for the Component Procurement Planning report linking requisitions to the final product SKU they support, enabling traceability from requisition to product.',
    `stock_location_id` BIGINT COMMENT 'Foreign key linking to inventory.stock_location. Business justification: REQUIRED: Requisition planning specifies target storage location for incoming material; needed for inbound logistics allocation and warehouse capacity reports.',
    `supplier_contact_id` BIGINT COMMENT 'Foreign key linking to supplier.supplier_contact. Business justification: Needed for Supplier Relationship Management process: requisition records the primary supplier contact for communication and escalation.',
    `supplier_id` BIGINT COMMENT 'Identifier of the preferred or suggested supplier for this requisition. Links to the supplier master data. Null if no preference specified.',
    `approval_level_required` STRING COMMENT 'Number of approval levels required for this requisition based on value thresholds and organizational policy. Higher values require more senior approvals.',
    `approved_date` DATE COMMENT 'Date when the purchase requisition received final approval and became ready for sourcing. Null if not yet approved.',
    `compliance_flag` BOOLEAN COMMENT 'Indicates whether this requisition requires special compliance review (e.g., environmental, safety, export control). True if compliance review is required.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the purchase requisition record was first created in the system. Used for audit trail and process cycle time analysis.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the estimated value (e.g., USD, EUR, GBP). Used for multi-currency procurement and financial reporting.. Valid values are `^[A-Z]{3}$`',
    `estimated_total_value` DECIMAL(18,2) COMMENT 'Total estimated value of the purchase requisition (quantity × estimated unit price). Used for budget control and approval routing.',
    `estimated_unit_price` DECIMAL(18,2) COMMENT 'Estimated price per unit of the requested material or service. Used for budget estimation and approval thresholds. Actual price is determined during sourcing and PO creation.',
    `justification_notes` STRING COMMENT 'Business justification or rationale provided by the requestor for the purchase. Required for high-value or non-standard requisitions.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the purchase requisition record was last updated. Tracks changes throughout the approval and sourcing lifecycle.',
    `mrp_controller` STRING COMMENT 'MRP controller responsible for material planning and requisition generation for production materials. Used for MRP-driven procurement.',
    `plant_code` STRING COMMENT 'Manufacturing plant or facility where the material or service is required. Used for delivery planning and inventory allocation in SAP PP.. Valid values are `^PLT-[0-9]{4}$`',
    `po_created_date` DATE COMMENT 'Date when the purchase order was created from this requisition. Marks the transition from requisition to order in the procure-to-pay cycle.',
    `pr_date` DATE COMMENT 'Date when the purchase requisition was created or submitted. Represents the principal business event timestamp for the requisition initiation.',
    `pr_number` STRING COMMENT 'Business identifier for the purchase requisition, externally visible and used in procurement workflows. Typically system-generated in SAP Ariba or SAP MM.. Valid values are `^PR-[0-9]{10}$`',
    `pr_status` STRING COMMENT 'Current lifecycle status of the purchase requisition in the procure-to-pay workflow. Tracks progression from draft through approval, sourcing, and conversion to purchase order. [ENUM-REF-CANDIDATE: draft|submitted|pending_approval|approved|rejected|sourcing_assigned|po_created|cancelled|closed — 9 candidates stripped; promote to reference product]',
    `pr_type` STRING COMMENT 'Classification of the purchase requisition based on the nature of the procurement: direct materials for production, indirect materials for operations, MRO (Maintenance, Repair, and Operations) supplies, capital equipment (CapEx), services, or subcontracting work.. Valid values are `direct_material|indirect_material|mro_supply|capital_equipment|service|subcontracting`',
    `priority_code` STRING COMMENT 'Priority level of the purchase requisition. Urgent and emergency priorities expedite approval and sourcing processes.. Valid values are `low|normal|high|urgent|emergency`',
    `purchasing_group_code` STRING COMMENT 'Code identifying the purchasing group or buyer responsible for sourcing this requisition. Used for workload distribution and supplier relationship management.. Valid values are `^PG-[0-9]{3}$`',
    `purchasing_organization_code` STRING COMMENT 'Code identifying the purchasing organization responsible for procurement activities. Defines the organizational unit for supplier contracts and purchase orders.. Valid values are `^PO-[0-9]{4}$`',
    `quantity_requested` DECIMAL(18,2) COMMENT 'Quantity of the material or service being requested. Expressed in the unit of measure specified in the UOM field.',
    `rejected_date` DATE COMMENT 'Date when the purchase requisition was rejected by an approver. Null if not rejected.',
    `rejection_reason` STRING COMMENT 'Explanation provided by the approver for rejecting the purchase requisition. Used for audit trail and process improvement.',
    `requestor_department` STRING COMMENT 'Department or organizational unit of the requestor. Used for spend analysis and budget allocation tracking.',
    `requestor_name` STRING COMMENT 'Full name of the employee who created the purchase requisition. Captured for audit trail and approval workflow visibility.',
    `required_delivery_date` DATE COMMENT 'Date by which the requested materials, supplies, or services must be delivered to meet operational or production requirements. Used for MRP (Material Requirements Planning) scheduling and supplier lead time calculation.',
    `source_determination_indicator` STRING COMMENT 'Indicates how the supplier source should be determined: automatic sourcing via system rules, manual buyer selection, contract-based assignment, or preferred supplier list.. Valid values are `automatic|manual|contract_based|preferred_supplier`',
    `unit_of_measure` STRING COMMENT 'Unit of measure for the requested quantity. Standard units include EA (each), KG (kilogram), L (liter), M (meter), HR (hour), etc. [ENUM-REF-CANDIDATE: EA|KG|L|M|M2|M3|HR|SET|BOX|ROLL|SHEET — 11 candidates stripped; promote to reference product]',
    CONSTRAINT pk_purchase_requisition PRIMARY KEY(`purchase_requisition_id`)
) COMMENT 'Master record for internal purchase requisition (PR) initiated by a department or MRP run. Captures the request for direct materials, indirect materials, MRO supplies, or capital equipment before a purchase order is raised. Tracks requestor, cost center, required delivery date, material/service description, estimated value, approval status, and sourcing assignment. Serves as the originating document in the procure-to-pay cycle.';

CREATE OR REPLACE TABLE `manufacturing_ecm`.`supplier`.`purchase_order` (
    `purchase_order_id` BIGINT COMMENT 'Unique system identifier for the purchase order record. Primary key.',
    `account_site_id` BIGINT COMMENT 'Foreign key linking to customer.account_site. Business justification: REQUIRED: PO delivery planning tracks which customer site receives purchased goods; used in site‑level inventory and cost reports.',
    `address_id` BIGINT COMMENT 'Foreign key linking to customer.address. Business justification: REQUIRED: Drop‑ship to customer needs PO delivery address for logistics and billing reports.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to supplier.agreement. Business justification: Purchase orders in industrial manufacturing are frequently issued against framework agreements or long-term supply agreements. Linking purchase_order.agreement_id → agreement.agreement_id enables cont',
    `bom_id` BIGINT COMMENT 'Foreign key linking to engineering.bom. Business justification: Purchase orders are raised against a specific BOM for a production run; linking supports BOM‑to‑PO cost tracking.',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: POs in industrial manufacturing are issued by a specific legal entity (company code) for AP processing, tax determination, and payment execution. company_code is a plain-text denormalized column on pu',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: PO posting requires cost center for internal accounting; mandatory for cost allocation reports.',
    `engineering_revision_id` BIGINT COMMENT 'Foreign key linking to engineering.engineering_revision. Business justification: Revision-controlled PO issuance: POs must specify the engineering revision to ensure suppliers manufacture to the correct drawing/specification version. This is a fundamental quality and traceability ',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Each PO expense is posted to a GL account for financial statements; required by accounting standards.',
    `header_id` BIGINT COMMENT 'Foreign key linking to order.order_header. Business justification: Required for Make‑to‑Order production planning; links each purchase order to the sales order it fulfills, enabling the Order‑to‑Procure fulfillment report.',
    `material_requirement_id` BIGINT COMMENT 'Foreign key linking to supply.material_requirement. Business justification: Purchase orders are issued to satisfy material requirements; the link supports the Material Requirement Fulfilment KPI.',
    `order_intake_id` BIGINT COMMENT 'Foreign key linking to sales.order_intake. Business justification: Each purchase order fulfills a specific sales order intake; linking enables end‑to‑end order‑to‑procurement tracking.',
    `sku_master_id` BIGINT COMMENT 'Foreign key linking to product.sku_master. Business justification: Needed for Order‑Driven Procurement process where purchase orders are tied to the specific product SKU being manufactured, supporting make‑to‑order execution.',
    `stock_location_id` BIGINT COMMENT 'Reference to the specific delivery address or warehouse location for goods receipt.',
    `supplier_id` BIGINT COMMENT 'Reference to the supplier or vendor to whom this purchase order is issued.',
    `plan_id` BIGINT COMMENT 'Foreign key linking to supply.plan. Business justification: Supply plans dictate purchase order creation; linking PO to supply_plan enables the Supply Plan Execution report.',
    `site_id` BIGINT COMMENT 'Foreign key linking to supplier.supplier_site. Business justification: Required for Logistics Planning Report: PO must reference the exact supplier site delivering goods, enabling site‑specific lead‑time and cost calculations.',
    `acknowledgement_date` DATE COMMENT 'Date when the supplier acknowledged the purchase order.',
    `acknowledgement_status` STRING COMMENT 'Status indicating whether the supplier has acknowledged receipt and acceptance of the purchase order.. Valid values are `not_sent|sent|acknowledged|rejected|partially_acknowledged`',
    `approval_date` DATE COMMENT 'Date when the purchase order received final approval.',
    `approval_status` STRING COMMENT 'Current approval workflow status for the purchase order.. Valid values are `not_required|pending|approved|rejected|escalated`',
    `closed_date` DATE COMMENT 'Date when the purchase order was administratively closed after all goods were received and invoices processed.',
    `compliance_status` STRING COMMENT 'Status indicating whether the purchase order meets all applicable procurement compliance policies and regulatory requirements.. Valid values are `compliant|non_compliant|under_review|exempted`',
    `confirmed_delivery_date` DATE COMMENT 'Date confirmed by the supplier for delivery of goods or completion of services.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when the purchase order record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts on this purchase order.. Valid values are `^[A-Z]{3}$`',
    `goods_receipt_status` STRING COMMENT 'Status indicating the extent to which ordered goods have been received against this purchase order.. Valid values are `not_received|partially_received|fully_received|over_received`',
    `incoterms` STRING COMMENT 'International Commercial Terms defining the responsibilities of buyer and seller for delivery, insurance, and risk transfer. [ENUM-REF-CANDIDATE: EXW|FCA|CPT|CIP|DAP|DPU|DDP|FAS|FOB|CFR|CIF — 11 candidates stripped; promote to reference product]',
    `incoterms_location` STRING COMMENT 'Named place or port specified in the Incoterms agreement where risk and cost transfer occurs.',
    `invoice_receipt_status` STRING COMMENT 'Status indicating the extent to which supplier invoices have been received and matched against this purchase order.. Valid values are `not_received|partially_invoiced|fully_invoiced|over_invoiced`',
    `material_category` STRING COMMENT 'High-level classification of the type of materials or services being procured. Direct materials are used in production, indirect materials support operations, MRO is maintenance/repair/operations supplies.. Valid values are `direct_material|indirect_material|mro|capital_equipment|services|subcontracting`',
    `modified_timestamp` TIMESTAMP COMMENT 'System timestamp when the purchase order record was last modified.',
    `net_po_value` DECIMAL(18,2) COMMENT 'Net total value of the purchase order after taxes and all adjustments.',
    `notes` STRING COMMENT 'Free-text field for additional instructions, special requirements, or comments related to the purchase order.',
    `payment_terms` STRING COMMENT 'Code representing the agreed payment terms with the supplier (e.g., Net 30, Net 60, 2/10 Net 30).. Valid values are `^[A-Z0-9]{4,10}$`',
    `po_date` DATE COMMENT 'Date when the purchase order was created and issued to the supplier. Principal business event timestamp for the transaction.',
    `po_number` STRING COMMENT 'Externally-known unique business identifier for the purchase order. Used in supplier communications and invoice matching.. Valid values are `^[A-Z0-9]{8,20}$`',
    `po_status` STRING COMMENT 'Current lifecycle status of the purchase order in the procure-to-pay workflow. [ENUM-REF-CANDIDATE: draft|pending_approval|approved|issued|acknowledged|in_progress|partially_received|fully_received|closed|cancelled — 10 candidates stripped; promote to reference product]',
    `po_type` STRING COMMENT 'Classification of the purchase order type. Standard for one-time orders, blanket for recurring orders with release schedules, framework for long-term agreements, subcontracting for external processing, consignment for supplier-owned inventory.. Valid values are `standard|blanket|framework|contract|subcontracting|consignment`',
    `priority` STRING COMMENT 'Business priority level assigned to the purchase order affecting processing and delivery urgency.. Valid values are `low|normal|high|urgent|critical`',
    `purchasing_group` STRING COMMENT 'Code identifying the buyer or procurement team responsible for this purchase order.. Valid values are `^[A-Z0-9]{3,6}$`',
    `purchasing_organization` STRING COMMENT 'Code identifying the organizational unit responsible for procurement activities. Represents the legal entity negotiating with suppliers.. Valid values are `^[A-Z0-9]{4,10}$`',
    `requested_delivery_date` DATE COMMENT 'Date by which the buyer requests delivery of goods or completion of services.',
    `shipping_method` STRING COMMENT 'Mode of transportation specified for delivery of goods.. Valid values are `air|ocean|rail|truck|courier|pickup`',
    `tax_amount` DECIMAL(18,2) COMMENT 'Total tax amount applicable to this purchase order.',
    `total_po_value` DECIMAL(18,2) COMMENT 'Total gross value of the purchase order including all line items before taxes and charges.',
    `wbs_element` STRING COMMENT 'Work breakdown structure element for project-based purchase orders, enabling cost tracking at the project task level.. Valid values are `^[A-Z0-9-.]{8,24}$`',
    CONSTRAINT pk_purchase_order PRIMARY KEY(`purchase_order_id`)
) COMMENT 'Core transactional document representing a legally binding purchase order (PO) issued to a supplier. Captures PO number, supplier, plant/delivery location, payment terms, incoterms, total PO value, currency, PO type (standard, blanket, framework, subcontracting), approval status, and confirmation status. Central document in the procure-to-pay process linking requisitions to goods receipts and supplier invoices.';

CREATE OR REPLACE TABLE `manufacturing_ecm`.`supplier`.`po_line_item` (
    `po_line_item_id` BIGINT COMMENT 'Unique identifier for the purchase order line item. Primary key for the po_line_item product.',
    `component_id` BIGINT COMMENT 'Foreign key linking to engineering.component. Business justification: Engineering-to-procurement traceability: PO line items must be traceable to the engineering component for BOM cost rollup, ECN impact analysis, and spend analytics by component. `manufacturer_part_num',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Line‑item expense allocation to cost center enables detailed cost reporting and variance analysis.',
    `engineering_bom_line_id` BIGINT COMMENT 'Foreign key linking to engineering.bom_line. Business justification: Order line items are derived from BOM lines during material planning; linking enables line‑level reconciliation.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Line‑item posting to GL account is required for accurate expense classification in the general ledger.',
    `material_master_id` BIGINT COMMENT 'Reference to the material master record being procured. Links to the specific product, component, or service being ordered.',
    `purchase_info_record_id` BIGINT COMMENT 'Foreign key linking to supplier.purchase_info_record. Business justification: Each PO line item is sourced from a specific purchase info record that defines the negotiated price, lead time, and approved source for that material-supplier combination. The po_line_item currently s',
    `purchase_order_id` BIGINT COMMENT 'Reference to the parent purchase order header. Links this line item to its containing purchase order document.',
    `stock_location_id` BIGINT COMMENT 'Foreign key linking to inventory.stock_location. Business justification: REQUIRED: Line item defines where received material will be stored; required for put‑away execution and inventory valuation per location.',
    `account_assignment_category` STRING COMMENT 'Classification determining how procurement costs are allocated in financial accounting (e.g., to cost center, asset, WBS element, or sales order).. Valid values are `cost_center|asset|project|sales_order|network|unknown`',
    `buyer_name` STRING COMMENT 'Name of the procurement professional responsible for sourcing and managing this purchase order line item.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this purchase order line item record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the net price and line item value (e.g., USD, EUR, CNY).. Valid values are `^[A-Z]{3}$`',
    `deletion_indicator` BOOLEAN COMMENT 'Flag indicating this line item has been marked for deletion or cancellation. Prevents further goods receipt and invoice posting.',
    `delivery_date` DATE COMMENT 'Requested or committed delivery date for this line item. Used for MRP planning, production scheduling, and supplier performance tracking.',
    `final_invoice_indicator` BOOLEAN COMMENT 'Flag indicating the final invoice has been received and no further invoices are expected for this line item.',
    `goods_receipt_indicator` BOOLEAN COMMENT 'Flag indicating whether goods receipt is required for this line item. Determines three-way match requirements for invoice verification.',
    `incoterms` STRING COMMENT 'Standardized trade terms defining responsibilities for shipping, insurance, and risk transfer (e.g., EXW, FOB, CIF, DDP).',
    `incoterms_location` STRING COMMENT 'Named place or port specified in the Incoterms clause where risk and cost transfer occurs.',
    `invoice_receipt_indicator` BOOLEAN COMMENT 'Flag indicating whether invoice verification is required for this line item. Controls accounts payable processing workflow.',
    `item_category` STRING COMMENT 'Classification of the procurement item type. Determines procurement processing rules, inventory treatment, and account assignment requirements.. Valid values are `standard|consignment|subcontracting|service|stock_transfer|third_party`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this purchase order line item record was last updated or modified.',
    `line_status` STRING COMMENT 'Current lifecycle status of the purchase order line item. Tracks progression from open through receipt to closure.. Valid values are `open|partially_received|fully_received|closed|cancelled`',
    `material_number` STRING COMMENT 'Business identifier for the material being procured. The externally-known SKU or part number used in procurement documents and supplier communication.',
    `net_order_value` DECIMAL(18,2) COMMENT 'Total value of this line item calculated as (quantity_ordered / price_unit) * net_price. Excludes taxes and freight charges.',
    `net_price` DECIMAL(18,2) COMMENT 'The negotiated price per unit of measure before taxes and additional charges. Used to calculate line item total value.',
    `open_quantity` DECIMAL(18,2) COMMENT 'Outstanding quantity still to be delivered, calculated as quantity_ordered minus quantity_received. Used for supplier follow-up and expediting.',
    `over_delivery_tolerance_percent` DECIMAL(18,2) COMMENT 'Acceptable percentage by which the supplier may over-deliver beyond the ordered quantity without requiring approval.',
    `plant_code` STRING COMMENT 'The manufacturing plant or facility where the material will be received and consumed. Determines receiving location and inventory posting.',
    `price_unit` STRING COMMENT 'The quantity for which the net price is valid (e.g., price per 1, per 100, per 1000 units). Used in unit price calculation.',
    `quality_inspection_required` BOOLEAN COMMENT 'Flag indicating whether incoming quality inspection is mandatory before goods receipt posting for this line item.',
    `quantity_invoiced` DECIMAL(18,2) COMMENT 'Cumulative quantity invoiced by the supplier against this line item to date. Used for invoice verification and payment processing.',
    `quantity_ordered` DECIMAL(18,2) COMMENT 'The quantity of material or service units being procured on this line item. Used for goods receipt matching and invoice verification.',
    `quantity_received` DECIMAL(18,2) COMMENT 'Cumulative quantity of goods received against this line item to date. Used for partial delivery tracking and open quantity calculation.',
    `requisitioner_name` STRING COMMENT 'Name of the employee or department that originated the purchase requisition leading to this line item.',
    `shipping_instruction` STRING COMMENT 'Special instructions for packaging, labeling, or delivery requirements specific to this line item.',
    `short_text` STRING COMMENT 'Brief description of the material or service being procured on this line. Provides human-readable context for the line item.',
    `supplier_material_number` STRING COMMENT 'The suppliers own part number or SKU for the material being procured. Used for supplier communication and catalog matching.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Total tax amount calculated for this line item based on tax code and net order value.',
    `tax_code` STRING COMMENT 'Tax classification code determining applicable tax rates and tax jurisdiction for this procurement line item.',
    `under_delivery_tolerance_percent` DECIMAL(18,2) COMMENT 'Acceptable percentage by which the supplier may under-deliver below the ordered quantity without penalty or rejection.',
    `unit_of_measure` STRING COMMENT 'The unit in which the ordered quantity is expressed (e.g., EA, KG, M, L, HR). Must align with material master and supplier agreement.',
    CONSTRAINT pk_po_line_item PRIMARY KEY(`po_line_item_id`)
) COMMENT 'Individual line item within a purchase order representing a specific material, service, or SKU being procured. Captures line number, material number, short text, quantity ordered, unit of measure, net price, delivery date, storage location, account assignment (cost center, WBS element, asset), and goods receipt indicator. Enables granular spend tracking, partial delivery management, and three-way match at the item level.';

CREATE OR REPLACE TABLE `manufacturing_ecm`.`supplier`.`procurement_goods_receipt` (
    `procurement_goods_receipt_id` BIGINT COMMENT 'Unique identifier for the goods receipt document. Primary key for the procurement goods receipt entity.',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: GR postings generate GR/IR clearing account entries scoped to a company code in SAP-style manufacturing ERP. receiving_plant_code alone does not determine the legal entity. Company code FK is required',
    `engineering_revision_id` BIGINT COMMENT 'Foreign key linking to engineering.engineering_revision. Business justification: Incoming inspection revision verification: goods receipt must confirm the received revision matches the ordered revision. This is a critical incoming quality control step — receiving the wrong revisio',
    `equipment_register_id` BIGINT COMMENT 'Foreign key linking to asset.equipment_register. Business justification: GOODS RECEIPT: Receiving equipment updates the equipment register for inventory, commissioning, and warranty start dates.',
    `material_master_id` BIGINT COMMENT 'Identifier of the material or service received. Links to the material master for product specifications and inventory management.',
    `po_line_item_id` BIGINT COMMENT 'Reference to the specific line item on the purchase order for which goods are being received. Enables line-level three-way matching.',
    `purchase_order_id` BIGINT COMMENT 'Reference to the purchase order against which this goods receipt is recorded. Links the GR to the originating procurement document.',
    `stock_location_id` BIGINT COMMENT 'Identifier of the specific storage location within the warehouse where the received goods are placed. Enables precise inventory tracking.',
    `supplier_id` BIGINT COMMENT 'Identifier of the supplier from whom the goods or services were received. Key counterparty in the procurement transaction.',
    `warehouse_id` BIGINT COMMENT 'Identifier of the warehouse or receiving facility where the goods were physically received.',
    `accounting_document_number` STRING COMMENT 'The financial accounting document number generated when the goods receipt value is posted to the General Ledger (GL). Links the GR to financial transactions.. Valid values are `^[0-9]{10}$`',
    `batch_number` STRING COMMENT 'The batch or lot number assigned to the received material. Critical for traceability, quality control, and recall management in regulated industries.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this goods receipt record was first created in the system. Used for audit trail and data lineage tracking.',
    `currency_code` STRING COMMENT 'The three-letter ISO 4217 currency code in which the goods receipt value is denominated (e.g., USD, EUR, CNY).. Valid values are `^[A-Z]{3}$`',
    `damage_flag` BOOLEAN COMMENT 'Indicates whether the received goods were damaged during transit or delivery. True if damage was observed; false otherwise. Triggers quality hold and supplier notification.',
    `delivery_date` DATE COMMENT 'The actual date on which the goods were physically delivered to the receiving location. Used for supplier performance evaluation and lead time analysis.',
    `delivery_note_number` STRING COMMENT 'The delivery note or packing slip number provided by the supplier. Used to match physical delivery documentation with the goods receipt record.',
    `document_date` DATE COMMENT 'The date printed on the goods receipt document. May differ from the posting date for backdated or forward-dated transactions.',
    `document_number` STRING COMMENT 'The externally-known unique document number assigned to this goods receipt transaction. Used for tracking, auditing, and cross-system reconciliation.. Valid values are `^GR[0-9]{10}$`',
    `expiration_date` DATE COMMENT 'The date on which the received material expires or becomes unusable. Critical for perishable goods, chemicals, and materials with shelf-life constraints.',
    `goods_receipt_status` STRING COMMENT 'Current lifecycle status of the goods receipt document. Indicates whether the GR is in draft, posted to inventory, blocked for quality issues, cancelled, or reversed.. Valid values are `draft|posted|blocked|cancelled|reversed`',
    `goods_receipt_value` DECIMAL(18,2) COMMENT 'The total monetary value of the goods received, calculated as received quantity multiplied by the purchase order unit price. Posted to inventory and General Ledger (GL) accounts.',
    `gr_ir_clearing_status` STRING COMMENT 'Indicates the clearing status of the GR/IR account in accounts payable. Open means no invoice received; partially cleared means partial invoice match; fully cleared means invoice fully matched and cleared.. Valid values are `open|partially_cleared|fully_cleared`',
    `invoice_verification_flag` BOOLEAN COMMENT 'Indicates whether an invoice has been received and verified against this goods receipt as part of the three-way match process (PO-GR-Invoice). True if invoice verified; false otherwise.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this goods receipt record was last updated. Used for change tracking and audit trail purposes.',
    `manufacturing_date` DATE COMMENT 'The date on which the received material was manufactured by the supplier. Used for shelf-life calculation and quality tracking.',
    `material_document_number` STRING COMMENT 'The SAP material document number generated when the goods receipt is posted. Links the GR to inventory movements and financial postings in the ERP system.. Valid values are `^[0-9]{10}$`',
    `material_document_year` STRING COMMENT 'The fiscal year in which the material document was created. Used in combination with material document number for unique identification in SAP.',
    `movement_type` STRING COMMENT 'The SAP movement type code that classifies the type of goods receipt transaction (e.g., 101 for GR against PO, 501 for GR without PO). Drives inventory and financial posting logic.. Valid values are `^[0-9]{3}$`',
    `notes` STRING COMMENT 'Free-text notes or comments recorded by the receiving personnel regarding the condition of the goods, packaging issues, or any discrepancies observed during receipt.',
    `ordered_quantity` DECIMAL(18,2) COMMENT 'The quantity originally ordered on the purchase order line. Used to calculate over-delivery or under-delivery variances.',
    `posting_date` DATE COMMENT 'The date on which the goods receipt was posted to the inventory and financial systems. This is the accounting date for inventory valuation and General Ledger (GL) posting.',
    `quality_inspection_required_flag` BOOLEAN COMMENT 'Indicates whether the received goods must undergo quality inspection before being released to unrestricted inventory. True if inspection is required; false otherwise.',
    `quality_inspection_status` STRING COMMENT 'Current status of the quality inspection process for the received goods. Determines whether goods can be moved to unrestricted stock or must remain in quality hold.. Valid values are `not_required|pending|in_progress|passed|failed|waived`',
    `quantity_variance` DECIMAL(18,2) COMMENT 'The difference between the received quantity and the ordered quantity. Positive values indicate over-delivery; negative values indicate under-delivery.',
    `received_quantity` DECIMAL(18,2) COMMENT 'The quantity of material or service units physically received and recorded in this goods receipt. Used for inventory update and three-way match validation.',
    `receiving_person_name` STRING COMMENT 'The name of the individual who physically received and inspected the goods. Used for accountability and audit trail purposes.',
    `receiving_plant_code` STRING COMMENT 'The code of the manufacturing plant or facility that received the goods. Used for multi-plant inventory and cost center allocation.. Valid values are `^[A-Z0-9]{4}$`',
    `return_authorization_flag` BOOLEAN COMMENT 'Indicates whether a Return Material Authorization (RMA) has been initiated for the received goods due to quality issues, damage, or incorrect delivery. True if RMA initiated; false otherwise.',
    `reversal_date` DATE COMMENT 'The date on which this goods receipt was reversed. Used for audit trail and financial period reconciliation.',
    `reversal_document_number` STRING COMMENT 'The document number of the reversal transaction if this goods receipt has been reversed. Links to the cancelling document for audit trail.',
    `reversal_flag` BOOLEAN COMMENT 'Indicates whether this goods receipt has been reversed or cancelled. True if reversed; false otherwise. Reversed GRs do not contribute to inventory or financial balances.',
    `serial_number` STRING COMMENT 'The unique serial number of the received item, applicable for serialized inventory such as equipment, tools, or high-value components.',
    `stock_type` STRING COMMENT 'The inventory stock type to which the received goods are posted. Unrestricted stock is available for use; quality inspection and blocked stock are not.. Valid values are `unrestricted|quality_inspection|blocked|restricted`',
    `unit_of_measure` STRING COMMENT 'The unit of measure in which the received quantity is expressed (e.g., EA for each, KG for kilogram, L for liter). Must align with the purchase order and material master UOM.. Valid values are `^[A-Z]{2,3}$`',
    `vendor_batch_number` STRING COMMENT 'The batch or lot number assigned by the supplier to the delivered goods. Used for supplier traceability and quality issue root cause analysis.',
    CONSTRAINT pk_procurement_goods_receipt PRIMARY KEY(`procurement_goods_receipt_id`)
) COMMENT 'Goods receipt (GR) document recorded when materials or services are physically received from a supplier against a purchase order. Captures GR document number, posting date, delivery note number, received quantity, unit of measure, storage location, batch number, quality inspection flag, and GR/IR clearing status. Triggers inventory update and initiates the three-way match process (PO–GR–Invoice) for accounts payable.';

CREATE OR REPLACE TABLE `manufacturing_ecm`.`supplier`.`invoice_line_item` (
    `invoice_line_item_id` BIGINT COMMENT 'Unique identifier for the invoice line item. Primary key for this entity.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Line‑level cost allocation to cost center supports detailed profitability and variance reporting.',
    `equipment_register_id` BIGINT COMMENT 'Foreign key linking to asset.equipment_register. Business justification: INVOICE ALLOCATION: Invoice line items for equipment need a FK to the equipment register for accurate asset cost tracking.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Each invoice line must map to a GL account for correct posting in the general ledger.',
    `material_master_id` BIGINT COMMENT 'Reference to the material master record for the product or material being invoiced. Links to the material catalog for direct materials, indirect materials, or MRO supplies.',
    `po_line_item_id` BIGINT COMMENT 'Reference to the purchase order line item that this invoice line corresponds to. Used for three-way matching between PO, goods receipt, and invoice.',
    `procurement_goods_receipt_id` BIGINT COMMENT 'Foreign key linking to supplier.procurement_goods_receipt. Business justification: Three-way matching (PO → GR → Invoice) is the cornerstone of procurement invoice verification in industrial manufacturing. The invoice_line_item currently stores goods_receipt_number as a STRING. Norm',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Profitability analysis requires linking invoice lines to profit centers for revenue/expense attribution.',
    `baseline_date` DATE COMMENT 'The baseline date from which payment terms are calculated for this line item. Typically the invoice date or goods receipt date depending on payment term configuration.',
    `batch_number` STRING COMMENT 'The batch or lot number for the material being invoiced. Critical for traceability, quality management, and recall management in regulated industries.',
    `blocking_reason` STRING COMMENT 'The reason code or description explaining why this invoice line is blocked from payment. Examples include price variance exceeds tolerance, quantity mismatch, missing goods receipt, or quality hold.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the line amount and unit price (e.g., USD, EUR, GBP, CNY). Must match the invoice header currency.. Valid values are `^[A-Z]{3}$`',
    `delivery_note_number` STRING COMMENT 'The supplier delivery note or packing slip number referenced on this invoice line. Used for traceability and shipment reconciliation.',
    `discount_amount` DECIMAL(18,2) COMMENT 'Any discount amount applied at the line level. Reduces the line amount before tax calculation. May represent early payment discounts, volume discounts, or promotional discounts.',
    `discount_percent` DECIMAL(18,2) COMMENT 'The discount percentage applied to this line item. Expressed as a percentage (e.g., 5.00 for 5% discount).',
    `goods_receipt_quantity` DECIMAL(18,2) COMMENT 'The quantity recorded on the goods receipt document. Used to compare against invoiced quantity for quantity variance detection.',
    `invoiced_quantity` DECIMAL(18,2) COMMENT 'The quantity of material or service units being invoiced on this line. Used for three-way match verification against PO quantity and goods receipt quantity.',
    `line_amount` DECIMAL(18,2) COMMENT 'The total amount for this invoice line before taxes. Typically calculated as invoiced quantity multiplied by unit price, adjusted for any line-level discounts or surcharges.',
    `line_number` STRING COMMENT 'Sequential line number within the invoice. Determines the ordering and position of this line item on the invoice document.',
    `line_type` STRING COMMENT 'Classification of the invoice line item type. Distinguishes between material purchases, services, freight charges, handling fees, taxes, discounts, surcharges, and other cost elements. [ENUM-REF-CANDIDATE: material|service|freight|handling|tax|discount|surcharge|other — 8 candidates stripped; promote to reference product]',
    `match_status` STRING COMMENT 'The three-way match status of this invoice line. Indicates whether the line passed matching validation or has variances requiring resolution. Blocked status prevents payment until resolved.. Valid values are `matched|quantity_variance|price_variance|blocked|unmatched|pending`',
    `material_description` STRING COMMENT 'Textual description of the material, service, or item being invoiced. Provides human-readable detail about what was purchased.',
    `material_number` STRING COMMENT 'The material number or SKU (Stock Keeping Unit) as specified on the invoice line. May differ from internal material master number in case of supplier-specific identifiers.',
    `net_amount` DECIMAL(18,2) COMMENT 'The net amount for this invoice line after applying discounts and adding taxes. Represents the final cost impact of this line item.',
    `notes` STRING COMMENT 'Free-text notes or comments related to this invoice line. May contain variance explanations, special handling instructions, or resolution details.',
    `payment_terms` STRING COMMENT 'The payment terms applicable to this invoice line if different from header-level terms. May specify early payment discounts or extended payment periods.',
    `plant_code` STRING COMMENT 'The manufacturing plant or facility code where the material or service is consumed or delivered. Used for multi-site cost allocation.',
    `po_quantity` DECIMAL(18,2) COMMENT 'The quantity specified on the original purchase order line. Used as the baseline for three-way match verification.',
    `po_unit_price` DECIMAL(18,2) COMMENT 'The unit price specified on the original purchase order line. Used as the baseline for price variance detection during invoice verification.',
    `price_variance` DECIMAL(18,2) COMMENT 'The difference between invoiced unit price and PO unit price, multiplied by invoiced quantity. Indicates pricing discrepancies requiring review.',
    `quantity_variance` DECIMAL(18,2) COMMENT 'The difference between invoiced quantity and goods receipt quantity. Positive values indicate over-invoicing, negative values indicate under-invoicing.',
    `serial_number` STRING COMMENT 'The serial number for serialized materials or equipment. Enables individual unit tracking for warranty, maintenance, and asset management.',
    `storage_location` STRING COMMENT 'The storage location within the plant where the material is received or stored. Used for inventory management and warehouse assignment.',
    `tax_amount` DECIMAL(18,2) COMMENT 'The calculated tax amount for this invoice line based on the tax code and line amount. Added to line amount to determine total line cost.',
    `tax_code` STRING COMMENT 'The tax code applied to this invoice line. Determines the tax rate and tax jurisdiction for calculating line-level tax amounts.',
    `tax_rate_percent` DECIMAL(18,2) COMMENT 'The tax rate percentage applied to this line item. Expressed as a percentage (e.g., 7.50 for 7.5% tax rate).',
    `tolerance_group` STRING COMMENT 'The tolerance group that defines acceptable variance thresholds for this line item. Different tolerance groups may apply to different material categories or supplier relationships.',
    `unit_of_measure` STRING COMMENT 'The unit of measure for the invoiced quantity (e.g., EA for each, KG for kilograms, M for meters, HR for hours). Must align with PO and material master UOM for proper matching.',
    `unit_price` DECIMAL(18,2) COMMENT 'The price per unit of measure as stated on the invoice line. Used to calculate line amount and compared against PO price for variance detection.',
    `valuation_type` STRING COMMENT 'The valuation type for split valuation scenarios where the same material is valued differently based on procurement source, quality grade, or other criteria.',
    `verification_date` DATE COMMENT 'The date when this invoice line was verified and approved for payment. Critical for tracking invoice processing cycle time and SLA compliance.',
    `verification_status` STRING COMMENT 'The current verification status of this invoice line in the approval workflow. Tracks progress through invoice verification and approval process.. Valid values are `pending|verified|rejected|on_hold|approved`',
    `wbs_element` STRING COMMENT 'The WBS element for project-related procurement. Links invoice line to specific project phases or deliverables for project cost tracking.',
    CONSTRAINT pk_invoice_line_item PRIMARY KEY(`invoice_line_item_id`)
) COMMENT 'Individual line item on a supplier invoice corresponding to a specific PO line, service entry sheet, or unplanned delivery cost. Captures line number, material or service description, invoiced quantity, unit price, line amount, tax code, account assignment, and three-way match status (matched, quantity variance, price variance, blocked). Enables granular invoice verification and exception management in logistics invoice verification.';

CREATE OR REPLACE TABLE `manufacturing_ecm`.`supplier`.`purchase_info_record` (
    `purchase_info_record_id` BIGINT COMMENT 'System-generated unique identifier for the purchase info record.',
    `approved_vendor_list_id` BIGINT COMMENT 'Foreign key linking to supplier.approved_vendor_list. Business justification: A purchase info record is the operational pricing/lead-time detail that backs an AVL entry. Linking purchase_info_record.approved_vendor_list_id → approved_vendor_list.approved_vendor_list_id creates ',
    `material_master_id` BIGINT COMMENT 'Unique identifier of the material or service for which this info record is maintained.',
    `sku_master_id` BIGINT COMMENT 'Foreign key linking to product.sku_master. Business justification: The Purchase Info Record is the ERP master record for supplier-SKU pricing and sourcing conditions (net_price, lead time, validity). In industrial manufacturing MRP, the PIR is always tied to a specif',
    `supplier_id` BIGINT COMMENT 'Unique identifier of the supplier linked to this info record.',
    `site_id` BIGINT COMMENT 'Foreign key linking to supplier.site. Business justification: Purchase info records in industrial manufacturing are often site-specific — the negotiated price and lead time for a material may differ between a suppliers manufacturing sites. The purchase_info_rec',
    `approved_source_flag` BOOLEAN COMMENT 'Indicates whether the supplier is an approved source for the material (true = approved).',
    `contract_reference` STRING COMMENT 'Reference to an outline agreement or contract that governs this price.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the info record was initially created.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 code of the currency in which the net price is expressed.. Valid values are `^[A-Z]{3}$`',
    `fixed_source_flag` BOOLEAN COMMENT 'True if procurement must always source from this supplier for the material.',
    `incoterms` STRING COMMENT 'International commercial terms defining delivery responsibilities; limited to six most common values.. Valid values are `EXW|FCA|FOB|CFR|CIF|DAP`',
    `info_record_number` STRING COMMENT 'Business identifier assigned to the purchase info record, used for reference in procurement processes.',
    `info_record_type` STRING COMMENT 'Classification of the info record indicating the sourcing strategy (e.g., standard, subcontracting, pipeline, consignment).. Valid values are `standard|subcontracting|pipeline|consignment`',
    `last_price_update_timestamp` TIMESTAMP COMMENT 'Date‑time when the price information was last updated in the system.',
    `minimum_order_quantity` DECIMAL(18,2) COMMENT 'Smallest quantity that can be ordered from the approved source.',
    `mrp_relevant_flag` BOOLEAN COMMENT 'True if the info record should be considered during MRP runs.',
    `net_price` DECIMAL(18,2) COMMENT 'Negotiated net price for the material/service from the approved supplier.',
    `notes` STRING COMMENT 'Free‑text field for additional comments or special instructions.',
    `order_quantity_multiple` DECIMAL(18,2) COMMENT 'Quantity increment that must be respected when ordering (e.g., multiples of 10).',
    `planned_delivery_time_days` STRING COMMENT 'Expected number of days from order creation to delivery for this source.',
    `plant_code` STRING COMMENT 'Code of the plant where the approved source is valid.',
    `price_change_date` DATE COMMENT 'Date on which the most recent price change became effective.',
    `price_change_indicator` STRING COMMENT 'Indicates whether the price has increased, decreased, or remained unchanged since the previous version.. Valid values are `increase|decrease|no_change`',
    `price_change_reason` STRING COMMENT 'Business justification for the latest price adjustment.',
    `price_unit` STRING COMMENT 'Unit of measure for the net price (e.g., per piece, per kilogram).',
    `purchase_info_record_status` STRING COMMENT 'Current lifecycle status of the info record.. Valid values are `active|inactive|blocked|pending|expired`',
    `purchasing_group` STRING COMMENT 'Group of buyers assigned to handle transactions for this info record.',
    `purchasing_organization` STRING COMMENT 'Organizational unit responsible for procurement activities for this info record.',
    `reminder_lead_time_days` STRING COMMENT 'Number of days before the planned delivery date when a reminder is generated.',
    `source_of_supply_category` STRING COMMENT 'Broad classification of the source (e.g., internal, external, third‑party).',
    `source_priority` STRING COMMENT 'Numeric rank indicating preference order among multiple approved sources for the same material.',
    `tax_code` STRING COMMENT 'Tax classification applicable to the purchase price.',
    `tolerance_limit_percent` DECIMAL(18,2) COMMENT 'Maximum allowed deviation (percentage) from the negotiated price before a tolerance check is triggered.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the info record.',
    `validity_end_date` DATE COMMENT 'Date after which the info record is no longer valid (nullable for open‑ended).',
    `validity_start_date` DATE COMMENT 'Date from which the info record becomes effective.',
    `vendor_material_number` STRING COMMENT 'Suppliers own material identifier for the supplied item.',
    `vendor_price_list` STRING COMMENT 'Reference to the suppliers price list or catalogue containing this price.',
    CONSTRAINT pk_purchase_info_record PRIMARY KEY(`purchase_info_record_id`)
) COMMENT 'Approved source master record linking a material or service to a qualified supplier, storing the negotiated price, standard order quantity, planned delivery time, tolerance limits, validity period, and plant-level sourcing assignments. Captures info record type (standard, subcontracting, pipeline, consignment), net price, price unit, minimum order quantity, reminder lead times, approved source indicators, MRP relevance flags, fixed source flags, valid-from/to dates, and outline agreement references. Drives automatic price proposals during PO creation and ensures MRP-driven orders are directed to approved suppliers at the correct plant.';

CREATE OR REPLACE TABLE `manufacturing_ecm`.`supplier`.`agreement` (
    `agreement_id` BIGINT COMMENT 'System-generated unique identifier for the supplier agreement record.',
    `account_site_id` BIGINT COMMENT 'Foreign key linking to customer.account_site. Business justification: Site-specific supply agreements: in industrial manufacturing, supplier agreements are scoped to specific customer factories/plants (e.g., JIT supply agreement for a single production site). agreement ',
    `commodity_category_id` BIGINT COMMENT 'Foreign key linking to finance.commodity_category. Business justification: Supply agreements are managed by commodity category in industrial manufacturing — category managers own contract coverage per commodity. commodity_scope is a plain-text denormalization of the commodit',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: Supply agreements are legally bound to a specific company code in multi-entity industrial manufacturers. Payment terms, total_value, and governing_law are all company-code-scoped. SAP-style contract m',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Agreement linked to cost center for budgeting of contracted spend (Supplier Agreement Cost Tracking).',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Agreement defines GL account for expense posting (Contractual GL mapping).',
    `master_agreement_id` BIGINT COMMENT 'Self-referencing FK on agreement (master_agreement_id)',
    `supplier_id` BIGINT COMMENT 'Reference to the supplier (vendor) that is party to the agreement.',
    `site_id` BIGINT COMMENT 'Foreign key linking to supplier.site. Business justification: Framework agreements and quality agreements in industrial manufacturing are often scoped to a specific supplier site (e.g., a quality agreement with a suppliers ISO-certified facility). The agreement',
    `agreement_number` STRING COMMENT 'External business identifier or contract number assigned to the agreement.',
    `agreement_status` STRING COMMENT 'Current lifecycle state of the agreement.. Valid values are `draft|active|expired|terminated|pending|suspended`',
    `agreement_type` STRING COMMENT 'Classification of the agreement (e.g., framework, quality, NDA, long‑term agreement, consignment, tooling loan).. Valid values are `framework|quality|nda|lta|consignment|tooling_loan`',
    `amendment_date` DATE COMMENT 'Date on which the amendment became effective.',
    `amendment_description` STRING COMMENT 'Narrative description of changes introduced by the amendment.',
    `amendment_number` STRING COMMENT 'Identifier of the specific amendment applied to the base agreement.',
    `approval_date` DATE COMMENT 'Date on which the agreement received formal approval.',
    `auto_renewal_flag` BOOLEAN COMMENT 'Indicates whether the agreement automatically renews at expiry.',
    `auto_renewal_term_months` STRING COMMENT 'Length of each renewal period in months when auto‑renewal is enabled.',
    `confidentiality_clause_flag` BOOLEAN COMMENT 'Indicates whether a confidentiality clause is included in the agreement.',
    `contractual_term_months` STRING COMMENT 'Original length of the agreement in months, excluding renewals.',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the agreement record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 code of the currency used for monetary terms.. Valid values are `^[A-Z]{3}$`',
    `discount_terms` STRING COMMENT 'Conditions under which discounts apply (e.g., volume rebates, early‑pay discounts).',
    `effective_end_date` DATE COMMENT 'Date on which the agreement expires or terminates (null for open‑ended).',
    `effective_start_date` DATE COMMENT 'Date on which the agreement becomes legally binding.',
    `esg_compliance_flag` BOOLEAN COMMENT 'Indicates whether the agreement includes ESG (environmental, social, governance) compliance requirements.',
    `governing_law` STRING COMMENT 'Jurisdiction whose law governs the agreement.',
    `ip_protection_clause_flag` BOOLEAN COMMENT 'Indicates whether intellectual‑property protection terms are present.',
    `jurisdiction` STRING COMMENT 'Geographic or legal jurisdiction applicable to the agreement.',
    `last_review_date` DATE COMMENT 'Date of the most recent formal review of the agreement terms.',
    `next_review_date` DATE COMMENT 'Planned date for the next scheduled review of the agreement.',
    `payment_terms` STRING COMMENT 'Standard payment conditions (e.g., net 30, milestone‑based) defined in the agreement.',
    `performance_kpi_summary` STRING COMMENT 'Key performance indicators and targets defined in the agreement (e.g., OEE, delivery reliability).',
    `price_index` STRING COMMENT 'Reference to any price index or formula used to adjust pricing over time.',
    `quality_expectations_summary` STRING COMMENT 'High‑level description of quality standards and metrics required from the supplier.',
    `renewal_notice_period_days` STRING COMMENT 'Number of days prior to expiry that a renewal notice must be issued.',
    `termination_notice_period_days` STRING COMMENT 'Number of days required to give notice before terminating the agreement.',
    `total_value` DECIMAL(18,2) COMMENT 'Maximum monetary value covered by the agreement, expressed in the specified currency.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent modification to the agreement record.',
    `version_number` STRING COMMENT 'Sequential version of the agreement document (incremented on each amendment).',
    CONSTRAINT pk_agreement PRIMARY KEY(`agreement_id`)
) COMMENT 'Master record for supplier-level framework agreements, quality agreements, NDAs, long-term supply agreements (LTAs), and consignment agreements that govern the overall commercial and quality relationship between Manufacturing and a vendor. Distinct from individual purchase orders (owned by procurement) — this captures the umbrella contractual instruments that set terms, pricing frameworks, IP protections, and quality expectations across multiple POs. Captures agreement type (framework, quality, NDA, LTA, consignment, tooling loan), effective date, expiry date, auto-renewal terms, governing law, key commercial terms summary, associated commodity scope, and agreement status (draft, active, expired, terminated).';

-- ========= FOREIGN KEYS =========
ALTER TABLE `manufacturing_ecm`.`supplier`.`site` ADD CONSTRAINT `fk_supplier_site_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `manufacturing_ecm`.`supplier`.`supplier`(`supplier_id`);
ALTER TABLE `manufacturing_ecm`.`supplier`.`supplier_contact` ADD CONSTRAINT `fk_supplier_supplier_contact_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `manufacturing_ecm`.`supplier`.`supplier`(`supplier_id`);
ALTER TABLE `manufacturing_ecm`.`supplier`.`supplier_contact` ADD CONSTRAINT `fk_supplier_supplier_contact_site_id` FOREIGN KEY (`site_id`) REFERENCES `manufacturing_ecm`.`supplier`.`site`(`site_id`);
ALTER TABLE `manufacturing_ecm`.`supplier`.`qualification` ADD CONSTRAINT `fk_supplier_qualification_supplier_certification_id` FOREIGN KEY (`supplier_certification_id`) REFERENCES `manufacturing_ecm`.`supplier`.`supplier_certification`(`supplier_certification_id`);
ALTER TABLE `manufacturing_ecm`.`supplier`.`qualification` ADD CONSTRAINT `fk_supplier_qualification_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `manufacturing_ecm`.`supplier`.`supplier`(`supplier_id`);
ALTER TABLE `manufacturing_ecm`.`supplier`.`qualification` ADD CONSTRAINT `fk_supplier_qualification_site_id` FOREIGN KEY (`site_id`) REFERENCES `manufacturing_ecm`.`supplier`.`site`(`site_id`);
ALTER TABLE `manufacturing_ecm`.`supplier`.`scorecard` ADD CONSTRAINT `fk_supplier_scorecard_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `manufacturing_ecm`.`supplier`.`supplier`(`supplier_id`);
ALTER TABLE `manufacturing_ecm`.`supplier`.`scorecard` ADD CONSTRAINT `fk_supplier_scorecard_site_id` FOREIGN KEY (`site_id`) REFERENCES `manufacturing_ecm`.`supplier`.`site`(`site_id`);
ALTER TABLE `manufacturing_ecm`.`supplier`.`supplier_audit` ADD CONSTRAINT `fk_supplier_supplier_audit_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `manufacturing_ecm`.`supplier`.`supplier`(`supplier_id`);
ALTER TABLE `manufacturing_ecm`.`supplier`.`supplier_audit` ADD CONSTRAINT `fk_supplier_supplier_audit_site_id` FOREIGN KEY (`site_id`) REFERENCES `manufacturing_ecm`.`supplier`.`site`(`site_id`);
ALTER TABLE `manufacturing_ecm`.`supplier`.`supplier_certification` ADD CONSTRAINT `fk_supplier_supplier_certification_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `manufacturing_ecm`.`supplier`.`supplier`(`supplier_id`);
ALTER TABLE `manufacturing_ecm`.`supplier`.`supplier_certification` ADD CONSTRAINT `fk_supplier_supplier_certification_site_id` FOREIGN KEY (`site_id`) REFERENCES `manufacturing_ecm`.`supplier`.`site`(`site_id`);
ALTER TABLE `manufacturing_ecm`.`supplier`.`approved_vendor_list` ADD CONSTRAINT `fk_supplier_approved_vendor_list_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `manufacturing_ecm`.`supplier`.`agreement`(`agreement_id`);
ALTER TABLE `manufacturing_ecm`.`supplier`.`approved_vendor_list` ADD CONSTRAINT `fk_supplier_approved_vendor_list_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `manufacturing_ecm`.`supplier`.`supplier`(`supplier_id`);
ALTER TABLE `manufacturing_ecm`.`supplier`.`approved_vendor_list` ADD CONSTRAINT `fk_supplier_approved_vendor_list_qualification_id` FOREIGN KEY (`qualification_id`) REFERENCES `manufacturing_ecm`.`supplier`.`qualification`(`qualification_id`);
ALTER TABLE `manufacturing_ecm`.`supplier`.`approved_vendor_list` ADD CONSTRAINT `fk_supplier_approved_vendor_list_site_id` FOREIGN KEY (`site_id`) REFERENCES `manufacturing_ecm`.`supplier`.`site`(`site_id`);
ALTER TABLE `manufacturing_ecm`.`supplier`.`purchase_requisition` ADD CONSTRAINT `fk_supplier_purchase_requisition_approved_vendor_list_id` FOREIGN KEY (`approved_vendor_list_id`) REFERENCES `manufacturing_ecm`.`supplier`.`approved_vendor_list`(`approved_vendor_list_id`);
ALTER TABLE `manufacturing_ecm`.`supplier`.`purchase_requisition` ADD CONSTRAINT `fk_supplier_purchase_requisition_purchase_info_record_id` FOREIGN KEY (`purchase_info_record_id`) REFERENCES `manufacturing_ecm`.`supplier`.`purchase_info_record`(`purchase_info_record_id`);
ALTER TABLE `manufacturing_ecm`.`supplier`.`purchase_requisition` ADD CONSTRAINT `fk_supplier_purchase_requisition_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `manufacturing_ecm`.`supplier`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `manufacturing_ecm`.`supplier`.`purchase_requisition` ADD CONSTRAINT `fk_supplier_purchase_requisition_supplier_contact_id` FOREIGN KEY (`supplier_contact_id`) REFERENCES `manufacturing_ecm`.`supplier`.`supplier_contact`(`supplier_contact_id`);
ALTER TABLE `manufacturing_ecm`.`supplier`.`purchase_requisition` ADD CONSTRAINT `fk_supplier_purchase_requisition_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `manufacturing_ecm`.`supplier`.`supplier`(`supplier_id`);
ALTER TABLE `manufacturing_ecm`.`supplier`.`purchase_order` ADD CONSTRAINT `fk_supplier_purchase_order_agreement_id` FOREIGN KEY (`agreement_id`) REFERENCES `manufacturing_ecm`.`supplier`.`agreement`(`agreement_id`);
ALTER TABLE `manufacturing_ecm`.`supplier`.`purchase_order` ADD CONSTRAINT `fk_supplier_purchase_order_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `manufacturing_ecm`.`supplier`.`supplier`(`supplier_id`);
ALTER TABLE `manufacturing_ecm`.`supplier`.`purchase_order` ADD CONSTRAINT `fk_supplier_purchase_order_site_id` FOREIGN KEY (`site_id`) REFERENCES `manufacturing_ecm`.`supplier`.`site`(`site_id`);
ALTER TABLE `manufacturing_ecm`.`supplier`.`po_line_item` ADD CONSTRAINT `fk_supplier_po_line_item_purchase_info_record_id` FOREIGN KEY (`purchase_info_record_id`) REFERENCES `manufacturing_ecm`.`supplier`.`purchase_info_record`(`purchase_info_record_id`);
ALTER TABLE `manufacturing_ecm`.`supplier`.`po_line_item` ADD CONSTRAINT `fk_supplier_po_line_item_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `manufacturing_ecm`.`supplier`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `manufacturing_ecm`.`supplier`.`procurement_goods_receipt` ADD CONSTRAINT `fk_supplier_procurement_goods_receipt_po_line_item_id` FOREIGN KEY (`po_line_item_id`) REFERENCES `manufacturing_ecm`.`supplier`.`po_line_item`(`po_line_item_id`);
ALTER TABLE `manufacturing_ecm`.`supplier`.`procurement_goods_receipt` ADD CONSTRAINT `fk_supplier_procurement_goods_receipt_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `manufacturing_ecm`.`supplier`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `manufacturing_ecm`.`supplier`.`procurement_goods_receipt` ADD CONSTRAINT `fk_supplier_procurement_goods_receipt_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `manufacturing_ecm`.`supplier`.`supplier`(`supplier_id`);
ALTER TABLE `manufacturing_ecm`.`supplier`.`invoice_line_item` ADD CONSTRAINT `fk_supplier_invoice_line_item_po_line_item_id` FOREIGN KEY (`po_line_item_id`) REFERENCES `manufacturing_ecm`.`supplier`.`po_line_item`(`po_line_item_id`);
ALTER TABLE `manufacturing_ecm`.`supplier`.`invoice_line_item` ADD CONSTRAINT `fk_supplier_invoice_line_item_procurement_goods_receipt_id` FOREIGN KEY (`procurement_goods_receipt_id`) REFERENCES `manufacturing_ecm`.`supplier`.`procurement_goods_receipt`(`procurement_goods_receipt_id`);
ALTER TABLE `manufacturing_ecm`.`supplier`.`purchase_info_record` ADD CONSTRAINT `fk_supplier_purchase_info_record_approved_vendor_list_id` FOREIGN KEY (`approved_vendor_list_id`) REFERENCES `manufacturing_ecm`.`supplier`.`approved_vendor_list`(`approved_vendor_list_id`);
ALTER TABLE `manufacturing_ecm`.`supplier`.`purchase_info_record` ADD CONSTRAINT `fk_supplier_purchase_info_record_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `manufacturing_ecm`.`supplier`.`supplier`(`supplier_id`);
ALTER TABLE `manufacturing_ecm`.`supplier`.`purchase_info_record` ADD CONSTRAINT `fk_supplier_purchase_info_record_site_id` FOREIGN KEY (`site_id`) REFERENCES `manufacturing_ecm`.`supplier`.`site`(`site_id`);
ALTER TABLE `manufacturing_ecm`.`supplier`.`agreement` ADD CONSTRAINT `fk_supplier_agreement_master_agreement_id` FOREIGN KEY (`master_agreement_id`) REFERENCES `manufacturing_ecm`.`supplier`.`agreement`(`agreement_id`);
ALTER TABLE `manufacturing_ecm`.`supplier`.`agreement` ADD CONSTRAINT `fk_supplier_agreement_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `manufacturing_ecm`.`supplier`.`supplier`(`supplier_id`);
ALTER TABLE `manufacturing_ecm`.`supplier`.`agreement` ADD CONSTRAINT `fk_supplier_agreement_site_id` FOREIGN KEY (`site_id`) REFERENCES `manufacturing_ecm`.`supplier`.`site`(`site_id`);

-- ========= TAGS =========
ALTER SCHEMA `manufacturing_ecm`.`supplier` SET TAGS ('dbx_division' = 'corporate');
ALTER SCHEMA `manufacturing_ecm`.`supplier` SET TAGS ('dbx_domain' = 'supplier');
ALTER TABLE `manufacturing_ecm`.`supplier`.`supplier` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `manufacturing_ecm`.`supplier`.`supplier` SET TAGS ('dbx_subdomain' = 'vendor_registry');
ALTER TABLE `manufacturing_ecm`.`supplier`.`supplier` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Identifier');
ALTER TABLE `manufacturing_ecm`.`supplier`.`supplier` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`supplier`.`supplier` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`supplier`.`supplier` ALTER COLUMN `business_type` SET TAGS ('dbx_business_glossary_term' = 'Business Type');
ALTER TABLE `manufacturing_ecm`.`supplier`.`supplier` ALTER COLUMN `business_type` SET TAGS ('dbx_value_regex' = 'OEM|distributor|raw_material|MRO|subcontractor|service_provider');
ALTER TABLE `manufacturing_ecm`.`supplier`.`supplier` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `manufacturing_ecm`.`supplier`.`supplier` ALTER COLUMN `duns_number` SET TAGS ('dbx_business_glossary_term' = 'DUNS (Data Universal Numbering System) Number');
ALTER TABLE `manufacturing_ecm`.`supplier`.`supplier` ALTER COLUMN `duns_number` SET TAGS ('dbx_value_regex' = '^[0-9]{9}$');
ALTER TABLE `manufacturing_ecm`.`supplier`.`supplier` ALTER COLUMN `headquarters_address_line1` SET TAGS ('dbx_business_glossary_term' = 'Headquarters Address Line 1');
ALTER TABLE `manufacturing_ecm`.`supplier`.`supplier` ALTER COLUMN `headquarters_address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `manufacturing_ecm`.`supplier`.`supplier` ALTER COLUMN `headquarters_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `manufacturing_ecm`.`supplier`.`supplier` ALTER COLUMN `headquarters_address_line2` SET TAGS ('dbx_business_glossary_term' = 'Headquarters Address Line 2');
ALTER TABLE `manufacturing_ecm`.`supplier`.`supplier` ALTER COLUMN `headquarters_address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `manufacturing_ecm`.`supplier`.`supplier` ALTER COLUMN `headquarters_address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `manufacturing_ecm`.`supplier`.`supplier` ALTER COLUMN `headquarters_city` SET TAGS ('dbx_business_glossary_term' = 'Headquarters City');
ALTER TABLE `manufacturing_ecm`.`supplier`.`supplier` ALTER COLUMN `headquarters_city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `manufacturing_ecm`.`supplier`.`supplier` ALTER COLUMN `headquarters_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `manufacturing_ecm`.`supplier`.`supplier` ALTER COLUMN `headquarters_country` SET TAGS ('dbx_business_glossary_term' = 'Headquarters Country');
ALTER TABLE `manufacturing_ecm`.`supplier`.`supplier` ALTER COLUMN `headquarters_country` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `manufacturing_ecm`.`supplier`.`supplier` ALTER COLUMN `headquarters_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Headquarters Postal Code');
ALTER TABLE `manufacturing_ecm`.`supplier`.`supplier` ALTER COLUMN `headquarters_postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `manufacturing_ecm`.`supplier`.`supplier` ALTER COLUMN `headquarters_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `manufacturing_ecm`.`supplier`.`supplier` ALTER COLUMN `headquarters_state_province` SET TAGS ('dbx_business_glossary_term' = 'Headquarters State or Province');
ALTER TABLE `manufacturing_ecm`.`supplier`.`supplier` ALTER COLUMN `headquarters_state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `manufacturing_ecm`.`supplier`.`supplier` ALTER COLUMN `headquarters_state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `manufacturing_ecm`.`supplier`.`supplier` ALTER COLUMN `incorporation_country` SET TAGS ('dbx_business_glossary_term' = 'Incorporation Country');
ALTER TABLE `manufacturing_ecm`.`supplier`.`supplier` ALTER COLUMN `incorporation_country` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `manufacturing_ecm`.`supplier`.`supplier` ALTER COLUMN `incoterms` SET TAGS ('dbx_business_glossary_term' = 'Incoterms (International Commercial Terms)');
ALTER TABLE `manufacturing_ecm`.`supplier`.`supplier` ALTER COLUMN `iso14001_certified` SET TAGS ('dbx_business_glossary_term' = 'ISO 14001 Certified');
ALTER TABLE `manufacturing_ecm`.`supplier`.`supplier` ALTER COLUMN `iso45001_certified` SET TAGS ('dbx_business_glossary_term' = 'ISO 45001 Certified');
ALTER TABLE `manufacturing_ecm`.`supplier`.`supplier` ALTER COLUMN `iso9001_certified` SET TAGS ('dbx_business_glossary_term' = 'ISO 9001 Certified');
ALTER TABLE `manufacturing_ecm`.`supplier`.`supplier` ALTER COLUMN `last_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Last Audit Date');
ALTER TABLE `manufacturing_ecm`.`supplier`.`supplier` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified By User');
ALTER TABLE `manufacturing_ecm`.`supplier`.`supplier` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `manufacturing_ecm`.`supplier`.`supplier` ALTER COLUMN `last_scorecard_date` SET TAGS ('dbx_business_glossary_term' = 'Last Scorecard Date');
ALTER TABLE `manufacturing_ecm`.`supplier`.`supplier` ALTER COLUMN `minority_owned` SET TAGS ('dbx_business_glossary_term' = 'Minority Owned Business');
ALTER TABLE `manufacturing_ecm`.`supplier`.`supplier` ALTER COLUMN `next_audit_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Audit Due Date');
ALTER TABLE `manufacturing_ecm`.`supplier`.`supplier` ALTER COLUMN `on_time_delivery_rate` SET TAGS ('dbx_business_glossary_term' = 'On-Time Delivery (OTD) Rate Percentage');
ALTER TABLE `manufacturing_ecm`.`supplier`.`supplier` ALTER COLUMN `overall_scorecard_rating` SET TAGS ('dbx_business_glossary_term' = 'Overall Scorecard Rating');
ALTER TABLE `manufacturing_ecm`.`supplier`.`supplier` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `manufacturing_ecm`.`supplier`.`supplier` ALTER COLUMN `preferred_currency` SET TAGS ('dbx_business_glossary_term' = 'Preferred Currency Code');
ALTER TABLE `manufacturing_ecm`.`supplier`.`supplier` ALTER COLUMN `preferred_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `manufacturing_ecm`.`supplier`.`supplier` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Email Address');
ALTER TABLE `manufacturing_ecm`.`supplier`.`supplier` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `manufacturing_ecm`.`supplier`.`supplier` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `manufacturing_ecm`.`supplier`.`supplier` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `manufacturing_ecm`.`supplier`.`supplier` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Name');
ALTER TABLE `manufacturing_ecm`.`supplier`.`supplier` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `manufacturing_ecm`.`supplier`.`supplier` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Phone Number');
ALTER TABLE `manufacturing_ecm`.`supplier`.`supplier` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `manufacturing_ecm`.`supplier`.`supplier` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `manufacturing_ecm`.`supplier`.`supplier` ALTER COLUMN `qualification_status` SET TAGS ('dbx_business_glossary_term' = 'Qualification Status');
ALTER TABLE `manufacturing_ecm`.`supplier`.`supplier` ALTER COLUMN `qualification_status` SET TAGS ('dbx_value_regex' = 'qualified|conditional|not_qualified|under_review');
ALTER TABLE `manufacturing_ecm`.`supplier`.`supplier` ALTER COLUMN `quality_acceptance_rate` SET TAGS ('dbx_business_glossary_term' = 'Quality Acceptance Rate Percentage');
ALTER TABLE `manufacturing_ecm`.`supplier`.`supplier` ALTER COLUMN `relationship_end_date` SET TAGS ('dbx_business_glossary_term' = 'Relationship End Date');
ALTER TABLE `manufacturing_ecm`.`supplier`.`supplier` ALTER COLUMN `relationship_start_date` SET TAGS ('dbx_business_glossary_term' = 'Relationship Start Date');
ALTER TABLE `manufacturing_ecm`.`supplier`.`supplier` ALTER COLUMN `risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Risk Rating');
ALTER TABLE `manufacturing_ecm`.`supplier`.`supplier` ALTER COLUMN `risk_rating` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `manufacturing_ecm`.`supplier`.`supplier` ALTER COLUMN `sap_vendor_number` SET TAGS ('dbx_business_glossary_term' = 'SAP Vendor Master Number');
ALTER TABLE `manufacturing_ecm`.`supplier`.`supplier` ALTER COLUMN `small_business` SET TAGS ('dbx_business_glossary_term' = 'Small Business');
ALTER TABLE `manufacturing_ecm`.`supplier`.`supplier` ALTER COLUMN `supplier_category` SET TAGS ('dbx_business_glossary_term' = 'Supplier Category');
ALTER TABLE `manufacturing_ecm`.`supplier`.`supplier` ALTER COLUMN `supplier_category` SET TAGS ('dbx_value_regex' = 'strategic|preferred|approved|conditional|blocked');
ALTER TABLE `manufacturing_ecm`.`supplier`.`supplier` ALTER COLUMN `supplier_status` SET TAGS ('dbx_business_glossary_term' = 'Supplier Status');
ALTER TABLE `manufacturing_ecm`.`supplier`.`supplier` ALTER COLUMN `supplier_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|pending_approval|blocked');
ALTER TABLE `manufacturing_ecm`.`supplier`.`supplier` ALTER COLUMN `tax_number` SET TAGS ('dbx_business_glossary_term' = 'Tax Identification Number');
ALTER TABLE `manufacturing_ecm`.`supplier`.`supplier` ALTER COLUMN `tax_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `manufacturing_ecm`.`supplier`.`supplier` ALTER COLUMN `vendor_code` SET TAGS ('dbx_business_glossary_term' = 'Vendor Code');
ALTER TABLE `manufacturing_ecm`.`supplier`.`supplier` ALTER COLUMN `vendor_name` SET TAGS ('dbx_business_glossary_term' = 'Vendor Legal Name');
ALTER TABLE `manufacturing_ecm`.`supplier`.`supplier` ALTER COLUMN `woman_owned` SET TAGS ('dbx_business_glossary_term' = 'Woman Owned Business');
ALTER TABLE `manufacturing_ecm`.`supplier`.`supplier` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Created By User');
ALTER TABLE `manufacturing_ecm`.`supplier`.`site` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `manufacturing_ecm`.`supplier`.`site` SET TAGS ('dbx_subdomain' = 'vendor_registry');
ALTER TABLE `manufacturing_ecm`.`supplier`.`site` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Site Identifier');
ALTER TABLE `manufacturing_ecm`.`supplier`.`site` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`supplier`.`site` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `manufacturing_ecm`.`supplier`.`site` ALTER COLUMN `active_from_date` SET TAGS ('dbx_business_glossary_term' = 'Active From Date');
ALTER TABLE `manufacturing_ecm`.`supplier`.`site` ALTER COLUMN `active_to_date` SET TAGS ('dbx_business_glossary_term' = 'Active To Date');
ALTER TABLE `manufacturing_ecm`.`supplier`.`site` ALTER COLUMN `address_line_1` SET TAGS ('dbx_business_glossary_term' = 'Address Line 1');
ALTER TABLE `manufacturing_ecm`.`supplier`.`site` ALTER COLUMN `address_line_1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `manufacturing_ecm`.`supplier`.`site` ALTER COLUMN `address_line_1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `manufacturing_ecm`.`supplier`.`site` ALTER COLUMN `address_line_2` SET TAGS ('dbx_business_glossary_term' = 'Address Line 2');
ALTER TABLE `manufacturing_ecm`.`supplier`.`site` ALTER COLUMN `address_line_2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `manufacturing_ecm`.`supplier`.`site` ALTER COLUMN `address_line_2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `manufacturing_ecm`.`supplier`.`site` ALTER COLUMN `approved_for_new_business` SET TAGS ('dbx_business_glossary_term' = 'Approved for New Business');
ALTER TABLE `manufacturing_ecm`.`supplier`.`site` ALTER COLUMN `capacity_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Capacity Unit of Measure (UOM)');
ALTER TABLE `manufacturing_ecm`.`supplier`.`site` ALTER COLUMN `certification_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Certification Expiry Date');
ALTER TABLE `manufacturing_ecm`.`supplier`.`site` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `manufacturing_ecm`.`supplier`.`site` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `manufacturing_ecm`.`supplier`.`site` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `manufacturing_ecm`.`supplier`.`site` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `manufacturing_ecm`.`supplier`.`site` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `manufacturing_ecm`.`supplier`.`site` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `manufacturing_ecm`.`supplier`.`site` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `manufacturing_ecm`.`supplier`.`site` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `manufacturing_ecm`.`supplier`.`site` ALTER COLUMN `delivery_performance_score` SET TAGS ('dbx_business_glossary_term' = 'Delivery Performance Score');
ALTER TABLE `manufacturing_ecm`.`supplier`.`site` ALTER COLUMN `duns_number` SET TAGS ('dbx_business_glossary_term' = 'DUNS Number');
ALTER TABLE `manufacturing_ecm`.`supplier`.`site` ALTER COLUMN `duns_number` SET TAGS ('dbx_value_regex' = '^[0-9]{9}$');
ALTER TABLE `manufacturing_ecm`.`supplier`.`site` ALTER COLUMN `geographic_region` SET TAGS ('dbx_business_glossary_term' = 'Geographic Region');
ALTER TABLE `manufacturing_ecm`.`supplier`.`site` ALTER COLUMN `geographic_region` SET TAGS ('dbx_value_regex' = 'north_america|south_america|europe|asia_pacific|middle_east|africa');
ALTER TABLE `manufacturing_ecm`.`supplier`.`site` ALTER COLUMN `iatf_16949_certified` SET TAGS ('dbx_business_glossary_term' = 'IATF 16949 Certified');
ALTER TABLE `manufacturing_ecm`.`supplier`.`site` ALTER COLUMN `iso_14001_certified` SET TAGS ('dbx_business_glossary_term' = 'ISO 14001 Certified');
ALTER TABLE `manufacturing_ecm`.`supplier`.`site` ALTER COLUMN `iso_45001_certified` SET TAGS ('dbx_business_glossary_term' = 'ISO 45001 Certified');
ALTER TABLE `manufacturing_ecm`.`supplier`.`site` ALTER COLUMN `iso_9001_certified` SET TAGS ('dbx_business_glossary_term' = 'ISO 9001 Certified');
ALTER TABLE `manufacturing_ecm`.`supplier`.`site` ALTER COLUMN `last_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Last Audit Date');
ALTER TABLE `manufacturing_ecm`.`supplier`.`site` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `manufacturing_ecm`.`supplier`.`site` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude');
ALTER TABLE `manufacturing_ecm`.`supplier`.`site` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `manufacturing_ecm`.`supplier`.`site` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `manufacturing_ecm`.`supplier`.`site` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time Days');
ALTER TABLE `manufacturing_ecm`.`supplier`.`site` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude');
ALTER TABLE `manufacturing_ecm`.`supplier`.`site` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `manufacturing_ecm`.`supplier`.`site` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `manufacturing_ecm`.`supplier`.`site` ALTER COLUMN `minimum_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity (MOQ)');
ALTER TABLE `manufacturing_ecm`.`supplier`.`site` ALTER COLUMN `moq_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'MOQ Unit of Measure (UOM)');
ALTER TABLE `manufacturing_ecm`.`supplier`.`site` ALTER COLUMN `next_audit_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Audit Due Date');
ALTER TABLE `manufacturing_ecm`.`supplier`.`site` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `manufacturing_ecm`.`supplier`.`site` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `manufacturing_ecm`.`supplier`.`site` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `manufacturing_ecm`.`supplier`.`site` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `manufacturing_ecm`.`supplier`.`site` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `manufacturing_ecm`.`supplier`.`site` ALTER COLUMN `preferred_supplier_flag` SET TAGS ('dbx_business_glossary_term' = 'Preferred Supplier Flag');
ALTER TABLE `manufacturing_ecm`.`supplier`.`site` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Email');
ALTER TABLE `manufacturing_ecm`.`supplier`.`site` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `manufacturing_ecm`.`supplier`.`site` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `manufacturing_ecm`.`supplier`.`site` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `manufacturing_ecm`.`supplier`.`site` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Name');
ALTER TABLE `manufacturing_ecm`.`supplier`.`site` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `manufacturing_ecm`.`supplier`.`site` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `manufacturing_ecm`.`supplier`.`site` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Phone');
ALTER TABLE `manufacturing_ecm`.`supplier`.`site` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `manufacturing_ecm`.`supplier`.`site` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `manufacturing_ecm`.`supplier`.`site` ALTER COLUMN `production_capacity_annual` SET TAGS ('dbx_business_glossary_term' = 'Production Capacity Annual');
ALTER TABLE `manufacturing_ecm`.`supplier`.`site` ALTER COLUMN `quality_score` SET TAGS ('dbx_business_glossary_term' = 'Quality Score');
ALTER TABLE `manufacturing_ecm`.`supplier`.`site` ALTER COLUMN `risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Risk Rating');
ALTER TABLE `manufacturing_ecm`.`supplier`.`site` ALTER COLUMN `risk_rating` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `manufacturing_ecm`.`supplier`.`site` ALTER COLUMN `site_code` SET TAGS ('dbx_business_glossary_term' = 'Site Code');
ALTER TABLE `manufacturing_ecm`.`supplier`.`site` ALTER COLUMN `site_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,20}$');
ALTER TABLE `manufacturing_ecm`.`supplier`.`site` ALTER COLUMN `site_name` SET TAGS ('dbx_business_glossary_term' = 'Site Name');
ALTER TABLE `manufacturing_ecm`.`supplier`.`site` ALTER COLUMN `site_status` SET TAGS ('dbx_business_glossary_term' = 'Site Status');
ALTER TABLE `manufacturing_ecm`.`supplier`.`site` ALTER COLUMN `site_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|pending_qualification|disqualified');
ALTER TABLE `manufacturing_ecm`.`supplier`.`site` ALTER COLUMN `site_type` SET TAGS ('dbx_business_glossary_term' = 'Site Type');
ALTER TABLE `manufacturing_ecm`.`supplier`.`site` ALTER COLUMN `site_type` SET TAGS ('dbx_value_regex' = 'manufacturing|distribution|warehouse|service_center|r_and_d|office');
ALTER TABLE `manufacturing_ecm`.`supplier`.`site` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'State or Province');
ALTER TABLE `manufacturing_ecm`.`supplier`.`site` ALTER COLUMN `state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `manufacturing_ecm`.`supplier`.`site` ALTER COLUMN `state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `manufacturing_ecm`.`supplier`.`site` ALTER COLUMN `tax_registration_number` SET TAGS ('dbx_business_glossary_term' = 'Tax Registration Number');
ALTER TABLE `manufacturing_ecm`.`supplier`.`site` ALTER COLUMN `tax_registration_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `manufacturing_ecm`.`supplier`.`supplier_contact` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `manufacturing_ecm`.`supplier`.`supplier_contact` SET TAGS ('dbx_subdomain' = 'vendor_registry');
ALTER TABLE `manufacturing_ecm`.`supplier`.`supplier_contact` ALTER COLUMN `supplier_contact_id` SET TAGS ('dbx_business_glossary_term' = 'Contact Identifier');
ALTER TABLE `manufacturing_ecm`.`supplier`.`supplier_contact` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `manufacturing_ecm`.`supplier`.`supplier_contact` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Site Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`supplier`.`supplier_contact` ALTER COLUMN `certification_held` SET TAGS ('dbx_business_glossary_term' = 'Professional Certifications Held');
ALTER TABLE `manufacturing_ecm`.`supplier`.`supplier_contact` ALTER COLUMN `communication_preference` SET TAGS ('dbx_business_glossary_term' = 'Preferred Communication Channel');
ALTER TABLE `manufacturing_ecm`.`supplier`.`supplier_contact` ALTER COLUMN `communication_preference` SET TAGS ('dbx_value_regex' = 'email|phone|mobile|portal|fax');
ALTER TABLE `manufacturing_ecm`.`supplier`.`supplier_contact` ALTER COLUMN `contact_role` SET TAGS ('dbx_business_glossary_term' = 'Contact Role Type');
ALTER TABLE `manufacturing_ecm`.`supplier`.`supplier_contact` ALTER COLUMN `contact_role` SET TAGS ('dbx_value_regex' = 'commercial|technical|quality|logistics|executive|after_sales');
ALTER TABLE `manufacturing_ecm`.`supplier`.`supplier_contact` ALTER COLUMN `contact_status` SET TAGS ('dbx_business_glossary_term' = 'Contact Status');
ALTER TABLE `manufacturing_ecm`.`supplier`.`supplier_contact` ALTER COLUMN `contact_status` SET TAGS ('dbx_value_regex' = 'active|inactive|on_leave|terminated');
ALTER TABLE `manufacturing_ecm`.`supplier`.`supplier_contact` ALTER COLUMN `contact_type` SET TAGS ('dbx_business_glossary_term' = 'Contact Type Classification');
ALTER TABLE `manufacturing_ecm`.`supplier`.`supplier_contact` ALTER COLUMN `contact_type` SET TAGS ('dbx_value_regex' = 'primary|secondary|escalation|technical_support|billing');
ALTER TABLE `manufacturing_ecm`.`supplier`.`supplier_contact` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Record Created By User');
ALTER TABLE `manufacturing_ecm`.`supplier`.`supplier_contact` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `manufacturing_ecm`.`supplier`.`supplier_contact` ALTER COLUMN `department` SET TAGS ('dbx_business_glossary_term' = 'Contact Department');
ALTER TABLE `manufacturing_ecm`.`supplier`.`supplier_contact` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Contact Effective End Date');
ALTER TABLE `manufacturing_ecm`.`supplier`.`supplier_contact` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Contact Effective Start Date');
ALTER TABLE `manufacturing_ecm`.`supplier`.`supplier_contact` ALTER COLUMN `email_address` SET TAGS ('dbx_business_glossary_term' = 'Contact Email Address');
ALTER TABLE `manufacturing_ecm`.`supplier`.`supplier_contact` ALTER COLUMN `email_address` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `manufacturing_ecm`.`supplier`.`supplier_contact` ALTER COLUMN `email_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `manufacturing_ecm`.`supplier`.`supplier_contact` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `manufacturing_ecm`.`supplier`.`supplier_contact` ALTER COLUMN `escalation_level` SET TAGS ('dbx_business_glossary_term' = 'Escalation Level');
ALTER TABLE `manufacturing_ecm`.`supplier`.`supplier_contact` ALTER COLUMN `first_name` SET TAGS ('dbx_business_glossary_term' = 'Contact First Name');
ALTER TABLE `manufacturing_ecm`.`supplier`.`supplier_contact` ALTER COLUMN `first_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `manufacturing_ecm`.`supplier`.`supplier_contact` ALTER COLUMN `first_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `manufacturing_ecm`.`supplier`.`supplier_contact` ALTER COLUMN `full_name` SET TAGS ('dbx_business_glossary_term' = 'Contact Full Name');
ALTER TABLE `manufacturing_ecm`.`supplier`.`supplier_contact` ALTER COLUMN `full_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `manufacturing_ecm`.`supplier`.`supplier_contact` ALTER COLUMN `full_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `manufacturing_ecm`.`supplier`.`supplier_contact` ALTER COLUMN `interaction_frequency_days` SET TAGS ('dbx_business_glossary_term' = 'Interaction Frequency in Days');
ALTER TABLE `manufacturing_ecm`.`supplier`.`supplier_contact` ALTER COLUMN `is_decision_maker` SET TAGS ('dbx_business_glossary_term' = 'Decision Maker Indicator');
ALTER TABLE `manufacturing_ecm`.`supplier`.`supplier_contact` ALTER COLUMN `is_primary_contact` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Indicator');
ALTER TABLE `manufacturing_ecm`.`supplier`.`supplier_contact` ALTER COLUMN `job_title` SET TAGS ('dbx_business_glossary_term' = 'Contact Job Title');
ALTER TABLE `manufacturing_ecm`.`supplier`.`supplier_contact` ALTER COLUMN `last_interaction_date` SET TAGS ('dbx_business_glossary_term' = 'Last Interaction Date');
ALTER TABLE `manufacturing_ecm`.`supplier`.`supplier_contact` ALTER COLUMN `last_modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified By User');
ALTER TABLE `manufacturing_ecm`.`supplier`.`supplier_contact` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `manufacturing_ecm`.`supplier`.`supplier_contact` ALTER COLUMN `last_name` SET TAGS ('dbx_business_glossary_term' = 'Contact Last Name');
ALTER TABLE `manufacturing_ecm`.`supplier`.`supplier_contact` ALTER COLUMN `last_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `manufacturing_ecm`.`supplier`.`supplier_contact` ALTER COLUMN `last_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `manufacturing_ecm`.`supplier`.`supplier_contact` ALTER COLUMN `linkedin_profile_url` SET TAGS ('dbx_business_glossary_term' = 'LinkedIn Profile URL');
ALTER TABLE `manufacturing_ecm`.`supplier`.`supplier_contact` ALTER COLUMN `mobile_number` SET TAGS ('dbx_business_glossary_term' = 'Contact Mobile Number');
ALTER TABLE `manufacturing_ecm`.`supplier`.`supplier_contact` ALTER COLUMN `mobile_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `manufacturing_ecm`.`supplier`.`supplier_contact` ALTER COLUMN `mobile_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `manufacturing_ecm`.`supplier`.`supplier_contact` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Contact Notes');
ALTER TABLE `manufacturing_ecm`.`supplier`.`supplier_contact` ALTER COLUMN `phone_number` SET TAGS ('dbx_business_glossary_term' = 'Contact Phone Number');
ALTER TABLE `manufacturing_ecm`.`supplier`.`supplier_contact` ALTER COLUMN `phone_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `manufacturing_ecm`.`supplier`.`supplier_contact` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `manufacturing_ecm`.`supplier`.`supplier_contact` ALTER COLUMN `preferred_language` SET TAGS ('dbx_business_glossary_term' = 'Preferred Communication Language');
ALTER TABLE `manufacturing_ecm`.`supplier`.`supplier_contact` ALTER COLUMN `preferred_language` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `manufacturing_ecm`.`supplier`.`supplier_contact` ALTER COLUMN `relationship_strength_score` SET TAGS ('dbx_business_glossary_term' = 'Relationship Strength Score');
ALTER TABLE `manufacturing_ecm`.`supplier`.`supplier_contact` ALTER COLUMN `specialization_area` SET TAGS ('dbx_business_glossary_term' = 'Contact Specialization Area');
ALTER TABLE `manufacturing_ecm`.`supplier`.`supplier_contact` ALTER COLUMN `time_zone` SET TAGS ('dbx_business_glossary_term' = 'Contact Time Zone');
ALTER TABLE `manufacturing_ecm`.`supplier`.`supplier_contact` ALTER COLUMN `years_of_experience` SET TAGS ('dbx_business_glossary_term' = 'Years of Professional Experience');
ALTER TABLE `manufacturing_ecm`.`supplier`.`qualification` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `manufacturing_ecm`.`supplier`.`qualification` SET TAGS ('dbx_subdomain' = 'vendor_registry');
ALTER TABLE `manufacturing_ecm`.`supplier`.`qualification` ALTER COLUMN `qualification_id` SET TAGS ('dbx_business_glossary_term' = 'Qualification ID');
ALTER TABLE `manufacturing_ecm`.`supplier`.`qualification` ALTER COLUMN `account_site_id` SET TAGS ('dbx_business_glossary_term' = 'Account Site Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`supplier`.`qualification` ALTER COLUMN `commodity_category_id` SET TAGS ('dbx_business_glossary_term' = 'Commodity Category Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`supplier`.`qualification` ALTER COLUMN `family_id` SET TAGS ('dbx_business_glossary_term' = 'Family Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`supplier`.`qualification` ALTER COLUMN `supplier_certification_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Certification Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`supplier`.`qualification` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `manufacturing_ecm`.`supplier`.`qualification` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Site Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`supplier`.`qualification` ALTER COLUMN `affected_commodities` SET TAGS ('dbx_business_glossary_term' = 'Affected Commodities');
ALTER TABLE `manufacturing_ecm`.`supplier`.`qualification` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `manufacturing_ecm`.`supplier`.`qualification` ALTER COLUMN `audit_date` SET TAGS ('dbx_business_glossary_term' = 'Audit Date');
ALTER TABLE `manufacturing_ecm`.`supplier`.`qualification` ALTER COLUMN `audit_score` SET TAGS ('dbx_business_glossary_term' = 'Audit Score');
ALTER TABLE `manufacturing_ecm`.`supplier`.`qualification` ALTER COLUMN `basis` SET TAGS ('dbx_business_glossary_term' = 'Qualification Basis');
ALTER TABLE `manufacturing_ecm`.`supplier`.`qualification` ALTER COLUMN `conditional_approval_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Conditional Approval Expiry Date');
ALTER TABLE `manufacturing_ecm`.`supplier`.`qualification` ALTER COLUMN `conditional_approval_reason` SET TAGS ('dbx_business_glossary_term' = 'Conditional Approval Reason');
ALTER TABLE `manufacturing_ecm`.`supplier`.`qualification` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `manufacturing_ecm`.`supplier`.`qualification` ALTER COLUMN `disqualification_date` SET TAGS ('dbx_business_glossary_term' = 'Disqualification Date');
ALTER TABLE `manufacturing_ecm`.`supplier`.`qualification` ALTER COLUMN `disqualification_reason` SET TAGS ('dbx_business_glossary_term' = 'Disqualification Reason');
ALTER TABLE `manufacturing_ecm`.`supplier`.`qualification` ALTER COLUMN `document_reference` SET TAGS ('dbx_business_glossary_term' = 'Document Reference');
ALTER TABLE `manufacturing_ecm`.`supplier`.`qualification` ALTER COLUMN `evaluation_end_date` SET TAGS ('dbx_business_glossary_term' = 'Evaluation End Date');
ALTER TABLE `manufacturing_ecm`.`supplier`.`qualification` ALTER COLUMN `evaluation_notes` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Notes');
ALTER TABLE `manufacturing_ecm`.`supplier`.`qualification` ALTER COLUMN `evaluation_start_date` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Start Date');
ALTER TABLE `manufacturing_ecm`.`supplier`.`qualification` ALTER COLUMN `evaluation_team` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Team');
ALTER TABLE `manufacturing_ecm`.`supplier`.`qualification` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `manufacturing_ecm`.`supplier`.`qualification` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `manufacturing_ecm`.`supplier`.`qualification` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `manufacturing_ecm`.`supplier`.`qualification` ALTER COLUMN `ppap_level` SET TAGS ('dbx_business_glossary_term' = 'Production Part Approval Process (PPAP) Level');
ALTER TABLE `manufacturing_ecm`.`supplier`.`qualification` ALTER COLUMN `ppap_level` SET TAGS ('dbx_value_regex' = 'level_1|level_2|level_3|level_4|level_5|not_applicable');
ALTER TABLE `manufacturing_ecm`.`supplier`.`qualification` ALTER COLUMN `qualification_number` SET TAGS ('dbx_business_glossary_term' = 'Qualification Number');
ALTER TABLE `manufacturing_ecm`.`supplier`.`qualification` ALTER COLUMN `qualification_number` SET TAGS ('dbx_value_regex' = '^QF-[0-9]{8}$');
ALTER TABLE `manufacturing_ecm`.`supplier`.`qualification` ALTER COLUMN `qualification_status` SET TAGS ('dbx_business_glossary_term' = 'Qualification Status');
ALTER TABLE `manufacturing_ecm`.`supplier`.`qualification` ALTER COLUMN `qualification_status` SET TAGS ('dbx_value_regex' = 'prospective|under_evaluation|approved|conditional|disqualified|expired');
ALTER TABLE `manufacturing_ecm`.`supplier`.`qualification` ALTER COLUMN `qualification_type` SET TAGS ('dbx_business_glossary_term' = 'Qualification Type');
ALTER TABLE `manufacturing_ecm`.`supplier`.`qualification` ALTER COLUMN `qualification_type` SET TAGS ('dbx_value_regex' = 'new_supplier|re_qualification|commodity_extension|disqualification|conditional_approval');
ALTER TABLE `manufacturing_ecm`.`supplier`.`qualification` ALTER COLUMN `re_qualification_conditions` SET TAGS ('dbx_business_glossary_term' = 'Re-Qualification Conditions');
ALTER TABLE `manufacturing_ecm`.`supplier`.`qualification` ALTER COLUMN `re_qualification_eligible` SET TAGS ('dbx_business_glossary_term' = 'Re-Qualification Eligible');
ALTER TABLE `manufacturing_ecm`.`supplier`.`qualification` ALTER COLUMN `risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Risk Rating');
ALTER TABLE `manufacturing_ecm`.`supplier`.`qualification` ALTER COLUMN `risk_rating` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `manufacturing_ecm`.`supplier`.`qualification` ALTER COLUMN `scope_description` SET TAGS ('dbx_business_glossary_term' = 'Scope Description');
ALTER TABLE `manufacturing_ecm`.`supplier`.`qualification` ALTER COLUMN `transition_plan_reference` SET TAGS ('dbx_business_glossary_term' = 'Transition Plan Reference');
ALTER TABLE `manufacturing_ecm`.`supplier`.`scorecard` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `manufacturing_ecm`.`supplier`.`scorecard` SET TAGS ('dbx_subdomain' = 'performance_compliance');
ALTER TABLE `manufacturing_ecm`.`supplier`.`scorecard` ALTER COLUMN `scorecard_id` SET TAGS ('dbx_business_glossary_term' = 'Scorecard ID');
ALTER TABLE `manufacturing_ecm`.`supplier`.`scorecard` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`supplier`.`scorecard` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `manufacturing_ecm`.`supplier`.`scorecard` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Site Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`supplier`.`scorecard` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `manufacturing_ecm`.`supplier`.`scorecard` ALTER COLUMN `capa_count` SET TAGS ('dbx_business_glossary_term' = 'Corrective and Preventive Action (CAPA) Count');
ALTER TABLE `manufacturing_ecm`.`supplier`.`scorecard` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `manufacturing_ecm`.`supplier`.`scorecard` ALTER COLUMN `cost_score` SET TAGS ('dbx_business_glossary_term' = 'Cost Score');
ALTER TABLE `manufacturing_ecm`.`supplier`.`scorecard` ALTER COLUMN `cost_variance_percentage` SET TAGS ('dbx_business_glossary_term' = 'Cost Variance Percentage');
ALTER TABLE `manufacturing_ecm`.`supplier`.`scorecard` ALTER COLUMN `cost_weight_percentage` SET TAGS ('dbx_business_glossary_term' = 'Cost Weight Percentage');
ALTER TABLE `manufacturing_ecm`.`supplier`.`scorecard` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `manufacturing_ecm`.`supplier`.`scorecard` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `manufacturing_ecm`.`supplier`.`scorecard` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `manufacturing_ecm`.`supplier`.`scorecard` ALTER COLUMN `delivery_score` SET TAGS ('dbx_business_glossary_term' = 'Delivery Score');
ALTER TABLE `manufacturing_ecm`.`supplier`.`scorecard` ALTER COLUMN `delivery_weight_percentage` SET TAGS ('dbx_business_glossary_term' = 'Delivery Weight Percentage');
ALTER TABLE `manufacturing_ecm`.`supplier`.`scorecard` ALTER COLUMN `evaluation_methodology` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Methodology');
ALTER TABLE `manufacturing_ecm`.`supplier`.`scorecard` ALTER COLUMN `evaluation_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Period End Date');
ALTER TABLE `manufacturing_ecm`.`supplier`.`scorecard` ALTER COLUMN `evaluation_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Period Start Date');
ALTER TABLE `manufacturing_ecm`.`supplier`.`scorecard` ALTER COLUMN `improvement_actions_required` SET TAGS ('dbx_business_glossary_term' = 'Improvement Actions Required');
ALTER TABLE `manufacturing_ecm`.`supplier`.`scorecard` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `manufacturing_ecm`.`supplier`.`scorecard` ALTER COLUMN `ncr_count` SET TAGS ('dbx_business_glossary_term' = 'Non-Conformance Report (NCR) Count');
ALTER TABLE `manufacturing_ecm`.`supplier`.`scorecard` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `manufacturing_ecm`.`supplier`.`scorecard` ALTER COLUMN `otd_percentage` SET TAGS ('dbx_business_glossary_term' = 'On-Time Delivery (OTD) Percentage');
ALTER TABLE `manufacturing_ecm`.`supplier`.`scorecard` ALTER COLUMN `overall_score` SET TAGS ('dbx_business_glossary_term' = 'Overall Score');
ALTER TABLE `manufacturing_ecm`.`supplier`.`scorecard` ALTER COLUMN `period_type` SET TAGS ('dbx_business_glossary_term' = 'Period Type');
ALTER TABLE `manufacturing_ecm`.`supplier`.`scorecard` ALTER COLUMN `period_type` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|semi-annual|annual|ad-hoc');
ALTER TABLE `manufacturing_ecm`.`supplier`.`scorecard` ALTER COLUMN `ppm_defect_rate` SET TAGS ('dbx_business_glossary_term' = 'Parts Per Million (PPM) Defect Rate');
ALTER TABLE `manufacturing_ecm`.`supplier`.`scorecard` ALTER COLUMN `previous_rating_tier` SET TAGS ('dbx_business_glossary_term' = 'Previous Rating Tier');
ALTER TABLE `manufacturing_ecm`.`supplier`.`scorecard` ALTER COLUMN `previous_rating_tier` SET TAGS ('dbx_value_regex' = 'preferred|approved|conditional|development|probation|disqualified');
ALTER TABLE `manufacturing_ecm`.`supplier`.`scorecard` ALTER COLUMN `published_date` SET TAGS ('dbx_business_glossary_term' = 'Published Date');
ALTER TABLE `manufacturing_ecm`.`supplier`.`scorecard` ALTER COLUMN `quality_score` SET TAGS ('dbx_business_glossary_term' = 'Quality Score');
ALTER TABLE `manufacturing_ecm`.`supplier`.`scorecard` ALTER COLUMN `quality_weight_percentage` SET TAGS ('dbx_business_glossary_term' = 'Quality Weight Percentage');
ALTER TABLE `manufacturing_ecm`.`supplier`.`scorecard` ALTER COLUMN `rating_tier` SET TAGS ('dbx_business_glossary_term' = 'Rating Tier');
ALTER TABLE `manufacturing_ecm`.`supplier`.`scorecard` ALTER COLUMN `rating_tier` SET TAGS ('dbx_value_regex' = 'preferred|approved|conditional|development|probation|disqualified');
ALTER TABLE `manufacturing_ecm`.`supplier`.`scorecard` ALTER COLUMN `responsiveness_index` SET TAGS ('dbx_business_glossary_term' = 'Responsiveness Index');
ALTER TABLE `manufacturing_ecm`.`supplier`.`scorecard` ALTER COLUMN `responsiveness_score` SET TAGS ('dbx_business_glossary_term' = 'Responsiveness Score');
ALTER TABLE `manufacturing_ecm`.`supplier`.`scorecard` ALTER COLUMN `responsiveness_weight_percentage` SET TAGS ('dbx_business_glossary_term' = 'Responsiveness Weight Percentage');
ALTER TABLE `manufacturing_ecm`.`supplier`.`scorecard` ALTER COLUMN `rma_count` SET TAGS ('dbx_business_glossary_term' = 'Return Material Authorization (RMA) Count');
ALTER TABLE `manufacturing_ecm`.`supplier`.`scorecard` ALTER COLUMN `scorecard_number` SET TAGS ('dbx_business_glossary_term' = 'Scorecard Number');
ALTER TABLE `manufacturing_ecm`.`supplier`.`scorecard` ALTER COLUMN `scorecard_status` SET TAGS ('dbx_business_glossary_term' = 'Scorecard Status');
ALTER TABLE `manufacturing_ecm`.`supplier`.`scorecard` ALTER COLUMN `scorecard_status` SET TAGS ('dbx_value_regex' = 'draft|in-review|approved|published|archived');
ALTER TABLE `manufacturing_ecm`.`supplier`.`scorecard` ALTER COLUMN `strengths_summary` SET TAGS ('dbx_business_glossary_term' = 'Strengths Summary');
ALTER TABLE `manufacturing_ecm`.`supplier`.`scorecard` ALTER COLUMN `total_line_items_evaluated` SET TAGS ('dbx_business_glossary_term' = 'Total Line Items Evaluated');
ALTER TABLE `manufacturing_ecm`.`supplier`.`scorecard` ALTER COLUMN `total_orders_evaluated` SET TAGS ('dbx_business_glossary_term' = 'Total Orders Evaluated');
ALTER TABLE `manufacturing_ecm`.`supplier`.`scorecard` ALTER COLUMN `total_purchase_value` SET TAGS ('dbx_business_glossary_term' = 'Total Purchase Value');
ALTER TABLE `manufacturing_ecm`.`supplier`.`scorecard` ALTER COLUMN `total_receipts_evaluated` SET TAGS ('dbx_business_glossary_term' = 'Total Receipts Evaluated');
ALTER TABLE `manufacturing_ecm`.`supplier`.`scorecard` ALTER COLUMN `weaknesses_summary` SET TAGS ('dbx_business_glossary_term' = 'Weaknesses Summary');
ALTER TABLE `manufacturing_ecm`.`supplier`.`supplier_audit` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `manufacturing_ecm`.`supplier`.`supplier_audit` SET TAGS ('dbx_subdomain' = 'performance_compliance');
ALTER TABLE `manufacturing_ecm`.`supplier`.`supplier_audit` ALTER COLUMN `supplier_audit_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Audit Identifier');
ALTER TABLE `manufacturing_ecm`.`supplier`.`supplier_audit` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`supplier`.`supplier_audit` ALTER COLUMN `engineering_specification_id` SET TAGS ('dbx_business_glossary_term' = 'Engineering Specification Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`supplier`.`supplier_audit` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Engineering Project Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`supplier`.`supplier_audit` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Identifier');
ALTER TABLE `manufacturing_ecm`.`supplier`.`supplier_audit` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Site Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`supplier`.`supplier_audit` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `manufacturing_ecm`.`supplier`.`supplier_audit` ALTER COLUMN `approved_date` SET TAGS ('dbx_business_glossary_term' = 'Approved Date');
ALTER TABLE `manufacturing_ecm`.`supplier`.`supplier_audit` ALTER COLUMN `audit_date` SET TAGS ('dbx_business_glossary_term' = 'Audit Date');
ALTER TABLE `manufacturing_ecm`.`supplier`.`supplier_audit` ALTER COLUMN `audit_method` SET TAGS ('dbx_business_glossary_term' = 'Audit Method');
ALTER TABLE `manufacturing_ecm`.`supplier`.`supplier_audit` ALTER COLUMN `audit_method` SET TAGS ('dbx_value_regex' = 'on_site|remote|hybrid|document_review');
ALTER TABLE `manufacturing_ecm`.`supplier`.`supplier_audit` ALTER COLUMN `audit_number` SET TAGS ('dbx_business_glossary_term' = 'Audit Number');
ALTER TABLE `manufacturing_ecm`.`supplier`.`supplier_audit` ALTER COLUMN `audit_result` SET TAGS ('dbx_business_glossary_term' = 'Audit Result');
ALTER TABLE `manufacturing_ecm`.`supplier`.`supplier_audit` ALTER COLUMN `audit_result` SET TAGS ('dbx_value_regex' = 'pass|conditional_pass|fail|pending');
ALTER TABLE `manufacturing_ecm`.`supplier`.`supplier_audit` ALTER COLUMN `audit_scope` SET TAGS ('dbx_business_glossary_term' = 'Audit Scope');
ALTER TABLE `manufacturing_ecm`.`supplier`.`supplier_audit` ALTER COLUMN `audit_status` SET TAGS ('dbx_business_glossary_term' = 'Audit Status');
ALTER TABLE `manufacturing_ecm`.`supplier`.`supplier_audit` ALTER COLUMN `audit_status` SET TAGS ('dbx_value_regex' = 'scheduled|in_progress|completed|cancelled|report_pending');
ALTER TABLE `manufacturing_ecm`.`supplier`.`supplier_audit` ALTER COLUMN `audit_type` SET TAGS ('dbx_business_glossary_term' = 'Audit Type');
ALTER TABLE `manufacturing_ecm`.`supplier`.`supplier_audit` ALTER COLUMN `auditor_comments` SET TAGS ('dbx_business_glossary_term' = 'Auditor Comments');
ALTER TABLE `manufacturing_ecm`.`supplier`.`supplier_audit` ALTER COLUMN `capa_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Corrective and Preventive Action (CAPA) Completion Date');
ALTER TABLE `manufacturing_ecm`.`supplier`.`supplier_audit` ALTER COLUMN `capa_due_date` SET TAGS ('dbx_business_glossary_term' = 'Corrective and Preventive Action (CAPA) Due Date');
ALTER TABLE `manufacturing_ecm`.`supplier`.`supplier_audit` ALTER COLUMN `capa_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Corrective and Preventive Action (CAPA) Required Flag');
ALTER TABLE `manufacturing_ecm`.`supplier`.`supplier_audit` ALTER COLUMN `certification_standard` SET TAGS ('dbx_business_glossary_term' = 'Certification Standard');
ALTER TABLE `manufacturing_ecm`.`supplier`.`supplier_audit` ALTER COLUMN `cost` SET TAGS ('dbx_business_glossary_term' = 'Audit Cost');
ALTER TABLE `manufacturing_ecm`.`supplier`.`supplier_audit` ALTER COLUMN `cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `manufacturing_ecm`.`supplier`.`supplier_audit` ALTER COLUMN `cost_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Audit Cost Currency Code');
ALTER TABLE `manufacturing_ecm`.`supplier`.`supplier_audit` ALTER COLUMN `cost_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `manufacturing_ecm`.`supplier`.`supplier_audit` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `manufacturing_ecm`.`supplier`.`supplier_audit` ALTER COLUMN `critical_findings_count` SET TAGS ('dbx_business_glossary_term' = 'Critical Findings Count');
ALTER TABLE `manufacturing_ecm`.`supplier`.`supplier_audit` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Audit End Date');
ALTER TABLE `manufacturing_ecm`.`supplier`.`supplier_audit` ALTER COLUMN `follow_up_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Audit Date');
ALTER TABLE `manufacturing_ecm`.`supplier`.`supplier_audit` ALTER COLUMN `follow_up_audit_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Audit Required Flag');
ALTER TABLE `manufacturing_ecm`.`supplier`.`supplier_audit` ALTER COLUMN `frequency_months` SET TAGS ('dbx_business_glossary_term' = 'Audit Frequency in Months');
ALTER TABLE `manufacturing_ecm`.`supplier`.`supplier_audit` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `manufacturing_ecm`.`supplier`.`supplier_audit` ALTER COLUMN `lead_auditor_name` SET TAGS ('dbx_business_glossary_term' = 'Lead Auditor Name');
ALTER TABLE `manufacturing_ecm`.`supplier`.`supplier_audit` ALTER COLUMN `location` SET TAGS ('dbx_business_glossary_term' = 'Audit Location');
ALTER TABLE `manufacturing_ecm`.`supplier`.`supplier_audit` ALTER COLUMN `major_findings_count` SET TAGS ('dbx_business_glossary_term' = 'Major Findings Count');
ALTER TABLE `manufacturing_ecm`.`supplier`.`supplier_audit` ALTER COLUMN `minor_findings_count` SET TAGS ('dbx_business_glossary_term' = 'Minor Findings Count');
ALTER TABLE `manufacturing_ecm`.`supplier`.`supplier_audit` ALTER COLUMN `next_audit_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Audit Due Date');
ALTER TABLE `manufacturing_ecm`.`supplier`.`supplier_audit` ALTER COLUMN `observation_count` SET TAGS ('dbx_business_glossary_term' = 'Observation Count');
ALTER TABLE `manufacturing_ecm`.`supplier`.`supplier_audit` ALTER COLUMN `report_date` SET TAGS ('dbx_business_glossary_term' = 'Audit Report Date');
ALTER TABLE `manufacturing_ecm`.`supplier`.`supplier_audit` ALTER COLUMN `risk_rating_post_audit` SET TAGS ('dbx_business_glossary_term' = 'Risk Rating Post-Audit');
ALTER TABLE `manufacturing_ecm`.`supplier`.`supplier_audit` ALTER COLUMN `risk_rating_post_audit` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `manufacturing_ecm`.`supplier`.`supplier_audit` ALTER COLUMN `risk_rating_pre_audit` SET TAGS ('dbx_business_glossary_term' = 'Risk Rating Pre-Audit');
ALTER TABLE `manufacturing_ecm`.`supplier`.`supplier_audit` ALTER COLUMN `risk_rating_pre_audit` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `manufacturing_ecm`.`supplier`.`supplier_audit` ALTER COLUMN `score` SET TAGS ('dbx_business_glossary_term' = 'Audit Score');
ALTER TABLE `manufacturing_ecm`.`supplier`.`supplier_audit` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `manufacturing_ecm`.`supplier`.`supplier_audit` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Audit Start Date');
ALTER TABLE `manufacturing_ecm`.`supplier`.`supplier_audit` ALTER COLUMN `supplier_response` SET TAGS ('dbx_business_glossary_term' = 'Supplier Response');
ALTER TABLE `manufacturing_ecm`.`supplier`.`supplier_audit` ALTER COLUMN `team_members` SET TAGS ('dbx_business_glossary_term' = 'Audit Team Members');
ALTER TABLE `manufacturing_ecm`.`supplier`.`supplier_audit` ALTER COLUMN `total_findings_count` SET TAGS ('dbx_business_glossary_term' = 'Total Findings Count');
ALTER TABLE `manufacturing_ecm`.`supplier`.`supplier_certification` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `manufacturing_ecm`.`supplier`.`supplier_certification` SET TAGS ('dbx_subdomain' = 'vendor_registry');
ALTER TABLE `manufacturing_ecm`.`supplier`.`supplier_certification` ALTER COLUMN `supplier_certification_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Certification Identifier (ID)');
ALTER TABLE `manufacturing_ecm`.`supplier`.`supplier_certification` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Identifier (ID)');
ALTER TABLE `manufacturing_ecm`.`supplier`.`supplier_certification` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Site Identifier (ID)');
ALTER TABLE `manufacturing_ecm`.`supplier`.`supplier_certification` ALTER COLUMN `accreditation_body` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Body');
ALTER TABLE `manufacturing_ecm`.`supplier`.`supplier_certification` ALTER COLUMN `alert_threshold_days` SET TAGS ('dbx_business_glossary_term' = 'Alert Threshold Days');
ALTER TABLE `manufacturing_ecm`.`supplier`.`supplier_certification` ALTER COLUMN `audit_report_url` SET TAGS ('dbx_business_glossary_term' = 'Audit Report Uniform Resource Locator (URL)');
ALTER TABLE `manufacturing_ecm`.`supplier`.`supplier_certification` ALTER COLUMN `audit_result` SET TAGS ('dbx_business_glossary_term' = 'Audit Result');
ALTER TABLE `manufacturing_ecm`.`supplier`.`supplier_certification` ALTER COLUMN `audit_result` SET TAGS ('dbx_value_regex' = 'passed|passed_with_observations|failed|conditional|deferred');
ALTER TABLE `manufacturing_ecm`.`supplier`.`supplier_certification` ALTER COLUMN `audit_type` SET TAGS ('dbx_business_glossary_term' = 'Audit Type');
ALTER TABLE `manufacturing_ecm`.`supplier`.`supplier_certification` ALTER COLUMN `audit_type` SET TAGS ('dbx_value_regex' = 'initial|surveillance|recertification|special|transfer');
ALTER TABLE `manufacturing_ecm`.`supplier`.`supplier_certification` ALTER COLUMN `auto_renewal_enabled` SET TAGS ('dbx_business_glossary_term' = 'Auto-Renewal Enabled');
ALTER TABLE `manufacturing_ecm`.`supplier`.`supplier_certification` ALTER COLUMN `business_criticality` SET TAGS ('dbx_business_glossary_term' = 'Business Criticality');
ALTER TABLE `manufacturing_ecm`.`supplier`.`supplier_certification` ALTER COLUMN `business_criticality` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `manufacturing_ecm`.`supplier`.`supplier_certification` ALTER COLUMN `certificate_document_url` SET TAGS ('dbx_business_glossary_term' = 'Certificate Document Uniform Resource Locator (URL)');
ALTER TABLE `manufacturing_ecm`.`supplier`.`supplier_certification` ALTER COLUMN `certification_level` SET TAGS ('dbx_business_glossary_term' = 'Certification Level');
ALTER TABLE `manufacturing_ecm`.`supplier`.`supplier_certification` ALTER COLUMN `certification_number` SET TAGS ('dbx_business_glossary_term' = 'Certification Number');
ALTER TABLE `manufacturing_ecm`.`supplier`.`supplier_certification` ALTER COLUMN `certification_status` SET TAGS ('dbx_business_glossary_term' = 'Certification Status');
ALTER TABLE `manufacturing_ecm`.`supplier`.`supplier_certification` ALTER COLUMN `certification_status` SET TAGS ('dbx_value_regex' = 'active|expired|suspended|revoked|pending_renewal|under_review');
ALTER TABLE `manufacturing_ecm`.`supplier`.`supplier_certification` ALTER COLUMN `certification_type` SET TAGS ('dbx_business_glossary_term' = 'Certification Type');
ALTER TABLE `manufacturing_ecm`.`supplier`.`supplier_certification` ALTER COLUMN `certified_processes` SET TAGS ('dbx_business_glossary_term' = 'Certified Processes');
ALTER TABLE `manufacturing_ecm`.`supplier`.`supplier_certification` ALTER COLUMN `certified_products` SET TAGS ('dbx_business_glossary_term' = 'Certified Products');
ALTER TABLE `manufacturing_ecm`.`supplier`.`supplier_certification` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `manufacturing_ecm`.`supplier`.`supplier_certification` ALTER COLUMN `corrective_action_due_date` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Due Date');
ALTER TABLE `manufacturing_ecm`.`supplier`.`supplier_certification` ALTER COLUMN `corrective_actions_required` SET TAGS ('dbx_business_glossary_term' = 'Corrective Actions Required');
ALTER TABLE `manufacturing_ecm`.`supplier`.`supplier_certification` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `manufacturing_ecm`.`supplier`.`supplier_certification` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `manufacturing_ecm`.`supplier`.`supplier_certification` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `manufacturing_ecm`.`supplier`.`supplier_certification` ALTER COLUMN `gated_commodity_categories` SET TAGS ('dbx_business_glossary_term' = 'Gated Commodity Categories');
ALTER TABLE `manufacturing_ecm`.`supplier`.`supplier_certification` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_business_glossary_term' = 'Geographic Scope');
ALTER TABLE `manufacturing_ecm`.`supplier`.`supplier_certification` ALTER COLUMN `issue_date` SET TAGS ('dbx_business_glossary_term' = 'Issue Date');
ALTER TABLE `manufacturing_ecm`.`supplier`.`supplier_certification` ALTER COLUMN `issuing_body` SET TAGS ('dbx_business_glossary_term' = 'Issuing Body');
ALTER TABLE `manufacturing_ecm`.`supplier`.`supplier_certification` ALTER COLUMN `last_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Last Audit Date');
ALTER TABLE `manufacturing_ecm`.`supplier`.`supplier_certification` ALTER COLUMN `last_updated_by` SET TAGS ('dbx_business_glossary_term' = 'Last Updated By');
ALTER TABLE `manufacturing_ecm`.`supplier`.`supplier_certification` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `manufacturing_ecm`.`supplier`.`supplier_certification` ALTER COLUMN `major_nonconformance_count` SET TAGS ('dbx_business_glossary_term' = 'Major Non-Conformance Count');
ALTER TABLE `manufacturing_ecm`.`supplier`.`supplier_certification` ALTER COLUMN `minor_nonconformance_count` SET TAGS ('dbx_business_glossary_term' = 'Minor Non-Conformance Count');
ALTER TABLE `manufacturing_ecm`.`supplier`.`supplier_certification` ALTER COLUMN `next_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Next Audit Date');
ALTER TABLE `manufacturing_ecm`.`supplier`.`supplier_certification` ALTER COLUMN `nonconformance_count` SET TAGS ('dbx_business_glossary_term' = 'Non-Conformance Count');
ALTER TABLE `manufacturing_ecm`.`supplier`.`supplier_certification` ALTER COLUMN `procurement_gate_enabled` SET TAGS ('dbx_business_glossary_term' = 'Procurement Gate Enabled');
ALTER TABLE `manufacturing_ecm`.`supplier`.`supplier_certification` ALTER COLUMN `renewal_date` SET TAGS ('dbx_business_glossary_term' = 'Renewal Date');
ALTER TABLE `manufacturing_ecm`.`supplier`.`supplier_certification` ALTER COLUMN `renewal_status` SET TAGS ('dbx_business_glossary_term' = 'Renewal Status');
ALTER TABLE `manufacturing_ecm`.`supplier`.`supplier_certification` ALTER COLUMN `renewal_status` SET TAGS ('dbx_value_regex' = 'not_due|renewal_initiated|renewal_in_progress|renewal_completed|renewal_overdue');
ALTER TABLE `manufacturing_ecm`.`supplier`.`supplier_certification` ALTER COLUMN `risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Risk Rating');
ALTER TABLE `manufacturing_ecm`.`supplier`.`supplier_certification` ALTER COLUMN `risk_rating` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `manufacturing_ecm`.`supplier`.`supplier_certification` ALTER COLUMN `scope_of_certification` SET TAGS ('dbx_business_glossary_term' = 'Scope of Certification');
ALTER TABLE `manufacturing_ecm`.`supplier`.`supplier_certification` ALTER COLUMN `standard` SET TAGS ('dbx_business_glossary_term' = 'Certification Standard');
ALTER TABLE `manufacturing_ecm`.`supplier`.`supplier_certification` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'Verification Date');
ALTER TABLE `manufacturing_ecm`.`supplier`.`supplier_certification` ALTER COLUMN `verification_method` SET TAGS ('dbx_business_glossary_term' = 'Verification Method');
ALTER TABLE `manufacturing_ecm`.`supplier`.`supplier_certification` ALTER COLUMN `verification_method` SET TAGS ('dbx_value_regex' = 'document_review|certifying_body_confirmation|on_site_inspection|third_party_verification|supplier_declaration');
ALTER TABLE `manufacturing_ecm`.`supplier`.`supplier_certification` ALTER COLUMN `verified_by` SET TAGS ('dbx_business_glossary_term' = 'Verified By');
ALTER TABLE `manufacturing_ecm`.`supplier`.`supplier_certification` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `manufacturing_ecm`.`supplier`.`approved_vendor_list` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `manufacturing_ecm`.`supplier`.`approved_vendor_list` SET TAGS ('dbx_subdomain' = 'vendor_registry');
ALTER TABLE `manufacturing_ecm`.`supplier`.`approved_vendor_list` ALTER COLUMN `approved_vendor_list_id` SET TAGS ('dbx_business_glossary_term' = 'Approved Vendor List (AVL) ID');
ALTER TABLE `manufacturing_ecm`.`supplier`.`approved_vendor_list` ALTER COLUMN `account_site_id` SET TAGS ('dbx_business_glossary_term' = 'Account Site Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`supplier`.`approved_vendor_list` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`supplier`.`approved_vendor_list` ALTER COLUMN `commodity_category_id` SET TAGS ('dbx_business_glossary_term' = 'Commodity Category Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`supplier`.`approved_vendor_list` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `manufacturing_ecm`.`supplier`.`approved_vendor_list` ALTER COLUMN `qualification_id` SET TAGS ('dbx_business_glossary_term' = 'Qualification Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`supplier`.`approved_vendor_list` ALTER COLUMN `sku_master_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Master Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`supplier`.`approved_vendor_list` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Site Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`supplier`.`approved_vendor_list` ALTER COLUMN `annual_spend_target` SET TAGS ('dbx_business_glossary_term' = 'Annual Spend Target');
ALTER TABLE `manufacturing_ecm`.`supplier`.`approved_vendor_list` ALTER COLUMN `annual_spend_target` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `manufacturing_ecm`.`supplier`.`approved_vendor_list` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `manufacturing_ecm`.`supplier`.`approved_vendor_list` ALTER COLUMN `approved_by_name` SET TAGS ('dbx_business_glossary_term' = 'Approved By Name');
ALTER TABLE `manufacturing_ecm`.`supplier`.`approved_vendor_list` ALTER COLUMN `avl_number` SET TAGS ('dbx_business_glossary_term' = 'Approved Vendor List (AVL) Number');
ALTER TABLE `manufacturing_ecm`.`supplier`.`approved_vendor_list` ALTER COLUMN `avl_number` SET TAGS ('dbx_value_regex' = '^AVL-[A-Z0-9]{8,12}$');
ALTER TABLE `manufacturing_ecm`.`supplier`.`approved_vendor_list` ALTER COLUMN `avl_status` SET TAGS ('dbx_business_glossary_term' = 'Approved Vendor List (AVL) Status');
ALTER TABLE `manufacturing_ecm`.`supplier`.`approved_vendor_list` ALTER COLUMN `avl_status` SET TAGS ('dbx_value_regex' = 'active|suspended|phased_out|pending_approval|expired|blocked');
ALTER TABLE `manufacturing_ecm`.`supplier`.`approved_vendor_list` ALTER COLUMN `capacity_rating` SET TAGS ('dbx_business_glossary_term' = 'Capacity Rating');
ALTER TABLE `manufacturing_ecm`.`supplier`.`approved_vendor_list` ALTER COLUMN `capacity_rating` SET TAGS ('dbx_value_regex' = 'high|medium|low|limited|unlimited');
ALTER TABLE `manufacturing_ecm`.`supplier`.`approved_vendor_list` ALTER COLUMN `certification_list` SET TAGS ('dbx_business_glossary_term' = 'Certification List');
ALTER TABLE `manufacturing_ecm`.`supplier`.`approved_vendor_list` ALTER COLUMN `certification_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Certification Required Flag');
ALTER TABLE `manufacturing_ecm`.`supplier`.`approved_vendor_list` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `manufacturing_ecm`.`supplier`.`approved_vendor_list` ALTER COLUMN `cost_competitiveness_rating` SET TAGS ('dbx_business_glossary_term' = 'Cost Competitiveness Rating');
ALTER TABLE `manufacturing_ecm`.`supplier`.`approved_vendor_list` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `manufacturing_ecm`.`supplier`.`approved_vendor_list` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `manufacturing_ecm`.`supplier`.`approved_vendor_list` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `manufacturing_ecm`.`supplier`.`approved_vendor_list` ALTER COLUMN `delivery_rating` SET TAGS ('dbx_business_glossary_term' = 'Delivery Rating');
ALTER TABLE `manufacturing_ecm`.`supplier`.`approved_vendor_list` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `manufacturing_ecm`.`supplier`.`approved_vendor_list` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `manufacturing_ecm`.`supplier`.`approved_vendor_list` ALTER COLUMN `expedited_lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Expedited Lead Time (Days)');
ALTER TABLE `manufacturing_ecm`.`supplier`.`approved_vendor_list` ALTER COLUMN `geographic_supply_region` SET TAGS ('dbx_business_glossary_term' = 'Geographic Supply Region');
ALTER TABLE `manufacturing_ecm`.`supplier`.`approved_vendor_list` ALTER COLUMN `geographic_supply_region` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `manufacturing_ecm`.`supplier`.`approved_vendor_list` ALTER COLUMN `incoterms` SET TAGS ('dbx_business_glossary_term' = 'International Commercial Terms (Incoterms)');
ALTER TABLE `manufacturing_ecm`.`supplier`.`approved_vendor_list` ALTER COLUMN `last_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Last Audit Date');
ALTER TABLE `manufacturing_ecm`.`supplier`.`approved_vendor_list` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `manufacturing_ecm`.`supplier`.`approved_vendor_list` ALTER COLUMN `material_group` SET TAGS ('dbx_business_glossary_term' = 'Material Group');
ALTER TABLE `manufacturing_ecm`.`supplier`.`approved_vendor_list` ALTER COLUMN `material_group` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,8}$');
ALTER TABLE `manufacturing_ecm`.`supplier`.`approved_vendor_list` ALTER COLUMN `moq` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity (MOQ)');
ALTER TABLE `manufacturing_ecm`.`supplier`.`approved_vendor_list` ALTER COLUMN `moq_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity (MOQ) Unit of Measure');
ALTER TABLE `manufacturing_ecm`.`supplier`.`approved_vendor_list` ALTER COLUMN `moq_unit_of_measure` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,3}$');
ALTER TABLE `manufacturing_ecm`.`supplier`.`approved_vendor_list` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `manufacturing_ecm`.`supplier`.`approved_vendor_list` ALTER COLUMN `part_family` SET TAGS ('dbx_business_glossary_term' = 'Part Family');
ALTER TABLE `manufacturing_ecm`.`supplier`.`approved_vendor_list` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `manufacturing_ecm`.`supplier`.`approved_vendor_list` ALTER COLUMN `ppap_level` SET TAGS ('dbx_business_glossary_term' = 'Production Part Approval Process (PPAP) Level');
ALTER TABLE `manufacturing_ecm`.`supplier`.`approved_vendor_list` ALTER COLUMN `ppap_level` SET TAGS ('dbx_value_regex' = 'level_1|level_2|level_3|level_4|level_5|not_required');
ALTER TABLE `manufacturing_ecm`.`supplier`.`approved_vendor_list` ALTER COLUMN `price_validity_end_date` SET TAGS ('dbx_business_glossary_term' = 'Price Validity End Date');
ALTER TABLE `manufacturing_ecm`.`supplier`.`approved_vendor_list` ALTER COLUMN `price_validity_start_date` SET TAGS ('dbx_business_glossary_term' = 'Price Validity Start Date');
ALTER TABLE `manufacturing_ecm`.`supplier`.`approved_vendor_list` ALTER COLUMN `purchasing_group` SET TAGS ('dbx_business_glossary_term' = 'Purchasing Group');
ALTER TABLE `manufacturing_ecm`.`supplier`.`approved_vendor_list` ALTER COLUMN `purchasing_group` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3}$');
ALTER TABLE `manufacturing_ecm`.`supplier`.`approved_vendor_list` ALTER COLUMN `purchasing_organization` SET TAGS ('dbx_business_glossary_term' = 'Purchasing Organization');
ALTER TABLE `manufacturing_ecm`.`supplier`.`approved_vendor_list` ALTER COLUMN `purchasing_organization` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `manufacturing_ecm`.`supplier`.`approved_vendor_list` ALTER COLUMN `quality_rating` SET TAGS ('dbx_business_glossary_term' = 'Quality Rating');
ALTER TABLE `manufacturing_ecm`.`supplier`.`approved_vendor_list` ALTER COLUMN `review_frequency_months` SET TAGS ('dbx_business_glossary_term' = 'Review Frequency (Months)');
ALTER TABLE `manufacturing_ecm`.`supplier`.`approved_vendor_list` ALTER COLUMN `risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Risk Rating');
ALTER TABLE `manufacturing_ecm`.`supplier`.`approved_vendor_list` ALTER COLUMN `risk_rating` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `manufacturing_ecm`.`supplier`.`approved_vendor_list` ALTER COLUMN `single_source_flag` SET TAGS ('dbx_business_glossary_term' = 'Single Source Flag');
ALTER TABLE `manufacturing_ecm`.`supplier`.`approved_vendor_list` ALTER COLUMN `standard_lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Standard Lead Time (Days)');
ALTER TABLE `manufacturing_ecm`.`supplier`.`approved_vendor_list` ALTER COLUMN `supplier_designation` SET TAGS ('dbx_business_glossary_term' = 'Supplier Designation');
ALTER TABLE `manufacturing_ecm`.`supplier`.`approved_vendor_list` ALTER COLUMN `supplier_designation` SET TAGS ('dbx_value_regex' = 'preferred|approved|backup|conditional|strategic');
ALTER TABLE `manufacturing_ecm`.`supplier`.`approved_vendor_list` ALTER COLUMN `supply_plant_code` SET TAGS ('dbx_business_glossary_term' = 'Supply Plant Code');
ALTER TABLE `manufacturing_ecm`.`supplier`.`approved_vendor_list` ALTER COLUMN `supply_plant_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,6}$');
ALTER TABLE `manufacturing_ecm`.`supplier`.`purchase_requisition` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `manufacturing_ecm`.`supplier`.`purchase_requisition` SET TAGS ('dbx_subdomain' = 'procurement_operations');
ALTER TABLE `manufacturing_ecm`.`supplier`.`purchase_requisition` ALTER COLUMN `purchase_requisition_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Requisition Identifier');
ALTER TABLE `manufacturing_ecm`.`supplier`.`purchase_requisition` ALTER COLUMN `account_site_id` SET TAGS ('dbx_business_glossary_term' = 'Account Site Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`supplier`.`purchase_requisition` ALTER COLUMN `approved_vendor_list_id` SET TAGS ('dbx_business_glossary_term' = 'Approved Vendor List Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`supplier`.`purchase_requisition` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`supplier`.`purchase_requisition` ALTER COLUMN `component_id` SET TAGS ('dbx_business_glossary_term' = 'Component Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`supplier`.`purchase_requisition` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`supplier`.`purchase_requisition` ALTER COLUMN `demand_forecast_id` SET TAGS ('dbx_business_glossary_term' = 'Demand Forecast Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`supplier`.`purchase_requisition` ALTER COLUMN `eco_id` SET TAGS ('dbx_business_glossary_term' = 'Eco Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`supplier`.`purchase_requisition` ALTER COLUMN `engineering_revision_id` SET TAGS ('dbx_business_glossary_term' = 'Engineering Revision Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`supplier`.`purchase_requisition` ALTER COLUMN `equipment_register_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Register Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`supplier`.`purchase_requisition` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`supplier`.`purchase_requisition` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material ID');
ALTER TABLE `manufacturing_ecm`.`supplier`.`purchase_requisition` ALTER COLUMN `mrp_run_id` SET TAGS ('dbx_business_glossary_term' = 'Mrp Run Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`supplier`.`purchase_requisition` ALTER COLUMN `opportunity_id` SET TAGS ('dbx_business_glossary_term' = 'Opportunity Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`supplier`.`purchase_requisition` ALTER COLUMN `planned_order_id` SET TAGS ('dbx_business_glossary_term' = 'Planned Order Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`supplier`.`purchase_requisition` ALTER COLUMN `procurement_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract ID');
ALTER TABLE `manufacturing_ecm`.`supplier`.`purchase_requisition` ALTER COLUMN `purchase_info_record_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Info Record Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`supplier`.`purchase_requisition` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`supplier`.`purchase_requisition` ALTER COLUMN `sku_master_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Master Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`supplier`.`purchase_requisition` ALTER COLUMN `stock_location_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Location Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`supplier`.`purchase_requisition` ALTER COLUMN `supplier_contact_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Contact Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`supplier`.`purchase_requisition` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Preferred Supplier ID');
ALTER TABLE `manufacturing_ecm`.`supplier`.`purchase_requisition` ALTER COLUMN `approval_level_required` SET TAGS ('dbx_business_glossary_term' = 'Approval Level Required');
ALTER TABLE `manufacturing_ecm`.`supplier`.`purchase_requisition` ALTER COLUMN `approved_date` SET TAGS ('dbx_business_glossary_term' = 'Approved Date');
ALTER TABLE `manufacturing_ecm`.`supplier`.`purchase_requisition` ALTER COLUMN `compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Flag');
ALTER TABLE `manufacturing_ecm`.`supplier`.`purchase_requisition` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `manufacturing_ecm`.`supplier`.`purchase_requisition` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `manufacturing_ecm`.`supplier`.`purchase_requisition` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `manufacturing_ecm`.`supplier`.`purchase_requisition` ALTER COLUMN `estimated_total_value` SET TAGS ('dbx_business_glossary_term' = 'Estimated Total Value');
ALTER TABLE `manufacturing_ecm`.`supplier`.`purchase_requisition` ALTER COLUMN `estimated_unit_price` SET TAGS ('dbx_business_glossary_term' = 'Estimated Unit Price');
ALTER TABLE `manufacturing_ecm`.`supplier`.`purchase_requisition` ALTER COLUMN `justification_notes` SET TAGS ('dbx_business_glossary_term' = 'Justification Notes');
ALTER TABLE `manufacturing_ecm`.`supplier`.`purchase_requisition` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `manufacturing_ecm`.`supplier`.`purchase_requisition` ALTER COLUMN `mrp_controller` SET TAGS ('dbx_business_glossary_term' = 'Material Requirements Planning (MRP) Controller');
ALTER TABLE `manufacturing_ecm`.`supplier`.`purchase_requisition` ALTER COLUMN `plant_code` SET TAGS ('dbx_business_glossary_term' = 'Plant Code');
ALTER TABLE `manufacturing_ecm`.`supplier`.`purchase_requisition` ALTER COLUMN `plant_code` SET TAGS ('dbx_value_regex' = '^PLT-[0-9]{4}$');
ALTER TABLE `manufacturing_ecm`.`supplier`.`purchase_requisition` ALTER COLUMN `po_created_date` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Created Date');
ALTER TABLE `manufacturing_ecm`.`supplier`.`purchase_requisition` ALTER COLUMN `pr_date` SET TAGS ('dbx_business_glossary_term' = 'Purchase Requisition (PR) Date');
ALTER TABLE `manufacturing_ecm`.`supplier`.`purchase_requisition` ALTER COLUMN `pr_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Requisition (PR) Number');
ALTER TABLE `manufacturing_ecm`.`supplier`.`purchase_requisition` ALTER COLUMN `pr_number` SET TAGS ('dbx_value_regex' = '^PR-[0-9]{10}$');
ALTER TABLE `manufacturing_ecm`.`supplier`.`purchase_requisition` ALTER COLUMN `pr_status` SET TAGS ('dbx_business_glossary_term' = 'Purchase Requisition (PR) Status');
ALTER TABLE `manufacturing_ecm`.`supplier`.`purchase_requisition` ALTER COLUMN `pr_type` SET TAGS ('dbx_business_glossary_term' = 'Purchase Requisition (PR) Type');
ALTER TABLE `manufacturing_ecm`.`supplier`.`purchase_requisition` ALTER COLUMN `pr_type` SET TAGS ('dbx_value_regex' = 'direct_material|indirect_material|mro_supply|capital_equipment|service|subcontracting');
ALTER TABLE `manufacturing_ecm`.`supplier`.`purchase_requisition` ALTER COLUMN `priority_code` SET TAGS ('dbx_business_glossary_term' = 'Priority Code');
ALTER TABLE `manufacturing_ecm`.`supplier`.`purchase_requisition` ALTER COLUMN `priority_code` SET TAGS ('dbx_value_regex' = 'low|normal|high|urgent|emergency');
ALTER TABLE `manufacturing_ecm`.`supplier`.`purchase_requisition` ALTER COLUMN `purchasing_group_code` SET TAGS ('dbx_business_glossary_term' = 'Purchasing Group Code');
ALTER TABLE `manufacturing_ecm`.`supplier`.`purchase_requisition` ALTER COLUMN `purchasing_group_code` SET TAGS ('dbx_value_regex' = '^PG-[0-9]{3}$');
ALTER TABLE `manufacturing_ecm`.`supplier`.`purchase_requisition` ALTER COLUMN `purchasing_organization_code` SET TAGS ('dbx_business_glossary_term' = 'Purchasing Organization Code');
ALTER TABLE `manufacturing_ecm`.`supplier`.`purchase_requisition` ALTER COLUMN `purchasing_organization_code` SET TAGS ('dbx_value_regex' = '^PO-[0-9]{4}$');
ALTER TABLE `manufacturing_ecm`.`supplier`.`purchase_requisition` ALTER COLUMN `quantity_requested` SET TAGS ('dbx_business_glossary_term' = 'Quantity Requested');
ALTER TABLE `manufacturing_ecm`.`supplier`.`purchase_requisition` ALTER COLUMN `rejected_date` SET TAGS ('dbx_business_glossary_term' = 'Rejected Date');
ALTER TABLE `manufacturing_ecm`.`supplier`.`purchase_requisition` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `manufacturing_ecm`.`supplier`.`purchase_requisition` ALTER COLUMN `requestor_department` SET TAGS ('dbx_business_glossary_term' = 'Requestor Department');
ALTER TABLE `manufacturing_ecm`.`supplier`.`purchase_requisition` ALTER COLUMN `requestor_name` SET TAGS ('dbx_business_glossary_term' = 'Requestor Name');
ALTER TABLE `manufacturing_ecm`.`supplier`.`purchase_requisition` ALTER COLUMN `required_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Required Delivery Date');
ALTER TABLE `manufacturing_ecm`.`supplier`.`purchase_requisition` ALTER COLUMN `source_determination_indicator` SET TAGS ('dbx_business_glossary_term' = 'Source Determination Indicator');
ALTER TABLE `manufacturing_ecm`.`supplier`.`purchase_requisition` ALTER COLUMN `source_determination_indicator` SET TAGS ('dbx_value_regex' = 'automatic|manual|contract_based|preferred_supplier');
ALTER TABLE `manufacturing_ecm`.`supplier`.`purchase_requisition` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `manufacturing_ecm`.`supplier`.`purchase_order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `manufacturing_ecm`.`supplier`.`purchase_order` SET TAGS ('dbx_subdomain' = 'procurement_operations');
ALTER TABLE `manufacturing_ecm`.`supplier`.`purchase_order` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) ID');
ALTER TABLE `manufacturing_ecm`.`supplier`.`purchase_order` ALTER COLUMN `account_site_id` SET TAGS ('dbx_business_glossary_term' = 'Account Site Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`supplier`.`purchase_order` ALTER COLUMN `address_id` SET TAGS ('dbx_business_glossary_term' = 'Address Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`supplier`.`purchase_order` ALTER COLUMN `address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `manufacturing_ecm`.`supplier`.`purchase_order` ALTER COLUMN `address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `manufacturing_ecm`.`supplier`.`purchase_order` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`supplier`.`purchase_order` ALTER COLUMN `bom_id` SET TAGS ('dbx_business_glossary_term' = 'Bom Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`supplier`.`purchase_order` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`supplier`.`purchase_order` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`supplier`.`purchase_order` ALTER COLUMN `engineering_revision_id` SET TAGS ('dbx_business_glossary_term' = 'Engineering Revision Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`supplier`.`purchase_order` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`supplier`.`purchase_order` ALTER COLUMN `header_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Order Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`supplier`.`purchase_order` ALTER COLUMN `material_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Material Requirement Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`supplier`.`purchase_order` ALTER COLUMN `order_intake_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Order Intake Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`supplier`.`purchase_order` ALTER COLUMN `sku_master_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Master Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`supplier`.`purchase_order` ALTER COLUMN `stock_location_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Location ID');
ALTER TABLE `manufacturing_ecm`.`supplier`.`purchase_order` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `manufacturing_ecm`.`supplier`.`purchase_order` ALTER COLUMN `plan_id` SET TAGS ('dbx_business_glossary_term' = 'Supply Plan Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`supplier`.`purchase_order` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Site Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`supplier`.`purchase_order` ALTER COLUMN `acknowledgement_date` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgement Date');
ALTER TABLE `manufacturing_ecm`.`supplier`.`purchase_order` ALTER COLUMN `acknowledgement_status` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgement Status');
ALTER TABLE `manufacturing_ecm`.`supplier`.`purchase_order` ALTER COLUMN `acknowledgement_status` SET TAGS ('dbx_value_regex' = 'not_sent|sent|acknowledged|rejected|partially_acknowledged');
ALTER TABLE `manufacturing_ecm`.`supplier`.`purchase_order` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `manufacturing_ecm`.`supplier`.`purchase_order` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `manufacturing_ecm`.`supplier`.`purchase_order` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|approved|rejected|escalated');
ALTER TABLE `manufacturing_ecm`.`supplier`.`purchase_order` ALTER COLUMN `closed_date` SET TAGS ('dbx_business_glossary_term' = 'Closed Date');
ALTER TABLE `manufacturing_ecm`.`supplier`.`purchase_order` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `manufacturing_ecm`.`supplier`.`purchase_order` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|under_review|exempted');
ALTER TABLE `manufacturing_ecm`.`supplier`.`purchase_order` ALTER COLUMN `confirmed_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Confirmed Delivery Date');
ALTER TABLE `manufacturing_ecm`.`supplier`.`purchase_order` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `manufacturing_ecm`.`supplier`.`purchase_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `manufacturing_ecm`.`supplier`.`purchase_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `manufacturing_ecm`.`supplier`.`purchase_order` ALTER COLUMN `goods_receipt_status` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt Status');
ALTER TABLE `manufacturing_ecm`.`supplier`.`purchase_order` ALTER COLUMN `goods_receipt_status` SET TAGS ('dbx_value_regex' = 'not_received|partially_received|fully_received|over_received');
ALTER TABLE `manufacturing_ecm`.`supplier`.`purchase_order` ALTER COLUMN `incoterms` SET TAGS ('dbx_business_glossary_term' = 'Incoterms');
ALTER TABLE `manufacturing_ecm`.`supplier`.`purchase_order` ALTER COLUMN `incoterms_location` SET TAGS ('dbx_business_glossary_term' = 'Incoterms Location');
ALTER TABLE `manufacturing_ecm`.`supplier`.`purchase_order` ALTER COLUMN `invoice_receipt_status` SET TAGS ('dbx_business_glossary_term' = 'Invoice Receipt Status');
ALTER TABLE `manufacturing_ecm`.`supplier`.`purchase_order` ALTER COLUMN `invoice_receipt_status` SET TAGS ('dbx_value_regex' = 'not_received|partially_invoiced|fully_invoiced|over_invoiced');
ALTER TABLE `manufacturing_ecm`.`supplier`.`purchase_order` ALTER COLUMN `material_category` SET TAGS ('dbx_business_glossary_term' = 'Material Category');
ALTER TABLE `manufacturing_ecm`.`supplier`.`purchase_order` ALTER COLUMN `material_category` SET TAGS ('dbx_value_regex' = 'direct_material|indirect_material|mro|capital_equipment|services|subcontracting');
ALTER TABLE `manufacturing_ecm`.`supplier`.`purchase_order` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `manufacturing_ecm`.`supplier`.`purchase_order` ALTER COLUMN `net_po_value` SET TAGS ('dbx_business_glossary_term' = 'Net Purchase Order (PO) Value');
ALTER TABLE `manufacturing_ecm`.`supplier`.`purchase_order` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `manufacturing_ecm`.`supplier`.`purchase_order` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `manufacturing_ecm`.`supplier`.`purchase_order` ALTER COLUMN `payment_terms` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `manufacturing_ecm`.`supplier`.`purchase_order` ALTER COLUMN `po_date` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Date');
ALTER TABLE `manufacturing_ecm`.`supplier`.`purchase_order` ALTER COLUMN `po_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Number');
ALTER TABLE `manufacturing_ecm`.`supplier`.`purchase_order` ALTER COLUMN `po_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `manufacturing_ecm`.`supplier`.`purchase_order` ALTER COLUMN `po_status` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Status');
ALTER TABLE `manufacturing_ecm`.`supplier`.`purchase_order` ALTER COLUMN `po_type` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Type');
ALTER TABLE `manufacturing_ecm`.`supplier`.`purchase_order` ALTER COLUMN `po_type` SET TAGS ('dbx_value_regex' = 'standard|blanket|framework|contract|subcontracting|consignment');
ALTER TABLE `manufacturing_ecm`.`supplier`.`purchase_order` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Priority');
ALTER TABLE `manufacturing_ecm`.`supplier`.`purchase_order` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'low|normal|high|urgent|critical');
ALTER TABLE `manufacturing_ecm`.`supplier`.`purchase_order` ALTER COLUMN `purchasing_group` SET TAGS ('dbx_business_glossary_term' = 'Purchasing Group');
ALTER TABLE `manufacturing_ecm`.`supplier`.`purchase_order` ALTER COLUMN `purchasing_group` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,6}$');
ALTER TABLE `manufacturing_ecm`.`supplier`.`purchase_order` ALTER COLUMN `purchasing_organization` SET TAGS ('dbx_business_glossary_term' = 'Purchasing Organization');
ALTER TABLE `manufacturing_ecm`.`supplier`.`purchase_order` ALTER COLUMN `purchasing_organization` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `manufacturing_ecm`.`supplier`.`purchase_order` ALTER COLUMN `requested_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Requested Delivery Date');
ALTER TABLE `manufacturing_ecm`.`supplier`.`purchase_order` ALTER COLUMN `shipping_method` SET TAGS ('dbx_business_glossary_term' = 'Shipping Method');
ALTER TABLE `manufacturing_ecm`.`supplier`.`purchase_order` ALTER COLUMN `shipping_method` SET TAGS ('dbx_value_regex' = 'air|ocean|rail|truck|courier|pickup');
ALTER TABLE `manufacturing_ecm`.`supplier`.`purchase_order` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `manufacturing_ecm`.`supplier`.`purchase_order` ALTER COLUMN `total_po_value` SET TAGS ('dbx_business_glossary_term' = 'Total Purchase Order (PO) Value');
ALTER TABLE `manufacturing_ecm`.`supplier`.`purchase_order` ALTER COLUMN `wbs_element` SET TAGS ('dbx_business_glossary_term' = 'Work Breakdown Structure (WBS) Element');
ALTER TABLE `manufacturing_ecm`.`supplier`.`purchase_order` ALTER COLUMN `wbs_element` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-.]{8,24}$');
ALTER TABLE `manufacturing_ecm`.`supplier`.`po_line_item` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `manufacturing_ecm`.`supplier`.`po_line_item` SET TAGS ('dbx_subdomain' = 'procurement_operations');
ALTER TABLE `manufacturing_ecm`.`supplier`.`po_line_item` ALTER COLUMN `po_line_item_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Line Item ID');
ALTER TABLE `manufacturing_ecm`.`supplier`.`po_line_item` ALTER COLUMN `component_id` SET TAGS ('dbx_business_glossary_term' = 'Component Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`supplier`.`po_line_item` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`supplier`.`po_line_item` ALTER COLUMN `engineering_bom_line_id` SET TAGS ('dbx_business_glossary_term' = 'Bom Line Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`supplier`.`po_line_item` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`supplier`.`po_line_item` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material ID');
ALTER TABLE `manufacturing_ecm`.`supplier`.`po_line_item` ALTER COLUMN `purchase_info_record_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Info Record Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`supplier`.`po_line_item` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) ID');
ALTER TABLE `manufacturing_ecm`.`supplier`.`po_line_item` ALTER COLUMN `stock_location_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Location Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`supplier`.`po_line_item` ALTER COLUMN `account_assignment_category` SET TAGS ('dbx_business_glossary_term' = 'Account Assignment Category');
ALTER TABLE `manufacturing_ecm`.`supplier`.`po_line_item` ALTER COLUMN `account_assignment_category` SET TAGS ('dbx_value_regex' = 'cost_center|asset|project|sales_order|network|unknown');
ALTER TABLE `manufacturing_ecm`.`supplier`.`po_line_item` ALTER COLUMN `buyer_name` SET TAGS ('dbx_business_glossary_term' = 'Buyer Name');
ALTER TABLE `manufacturing_ecm`.`supplier`.`po_line_item` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `manufacturing_ecm`.`supplier`.`po_line_item` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `manufacturing_ecm`.`supplier`.`po_line_item` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `manufacturing_ecm`.`supplier`.`po_line_item` ALTER COLUMN `deletion_indicator` SET TAGS ('dbx_business_glossary_term' = 'Deletion Indicator');
ALTER TABLE `manufacturing_ecm`.`supplier`.`po_line_item` ALTER COLUMN `delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Delivery Date');
ALTER TABLE `manufacturing_ecm`.`supplier`.`po_line_item` ALTER COLUMN `final_invoice_indicator` SET TAGS ('dbx_business_glossary_term' = 'Final Invoice Indicator');
ALTER TABLE `manufacturing_ecm`.`supplier`.`po_line_item` ALTER COLUMN `goods_receipt_indicator` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt (GR) Indicator');
ALTER TABLE `manufacturing_ecm`.`supplier`.`po_line_item` ALTER COLUMN `incoterms` SET TAGS ('dbx_business_glossary_term' = 'International Commercial Terms (Incoterms)');
ALTER TABLE `manufacturing_ecm`.`supplier`.`po_line_item` ALTER COLUMN `incoterms_location` SET TAGS ('dbx_business_glossary_term' = 'Incoterms Location');
ALTER TABLE `manufacturing_ecm`.`supplier`.`po_line_item` ALTER COLUMN `invoice_receipt_indicator` SET TAGS ('dbx_business_glossary_term' = 'Invoice Receipt (IR) Indicator');
ALTER TABLE `manufacturing_ecm`.`supplier`.`po_line_item` ALTER COLUMN `item_category` SET TAGS ('dbx_business_glossary_term' = 'Item Category');
ALTER TABLE `manufacturing_ecm`.`supplier`.`po_line_item` ALTER COLUMN `item_category` SET TAGS ('dbx_value_regex' = 'standard|consignment|subcontracting|service|stock_transfer|third_party');
ALTER TABLE `manufacturing_ecm`.`supplier`.`po_line_item` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `manufacturing_ecm`.`supplier`.`po_line_item` ALTER COLUMN `line_status` SET TAGS ('dbx_business_glossary_term' = 'Line Item Status');
ALTER TABLE `manufacturing_ecm`.`supplier`.`po_line_item` ALTER COLUMN `line_status` SET TAGS ('dbx_value_regex' = 'open|partially_received|fully_received|closed|cancelled');
ALTER TABLE `manufacturing_ecm`.`supplier`.`po_line_item` ALTER COLUMN `material_number` SET TAGS ('dbx_business_glossary_term' = 'Material Number');
ALTER TABLE `manufacturing_ecm`.`supplier`.`po_line_item` ALTER COLUMN `net_order_value` SET TAGS ('dbx_business_glossary_term' = 'Net Order Value');
ALTER TABLE `manufacturing_ecm`.`supplier`.`po_line_item` ALTER COLUMN `net_price` SET TAGS ('dbx_business_glossary_term' = 'Net Price per Unit');
ALTER TABLE `manufacturing_ecm`.`supplier`.`po_line_item` ALTER COLUMN `open_quantity` SET TAGS ('dbx_business_glossary_term' = 'Open Quantity');
ALTER TABLE `manufacturing_ecm`.`supplier`.`po_line_item` ALTER COLUMN `over_delivery_tolerance_percent` SET TAGS ('dbx_business_glossary_term' = 'Over-Delivery Tolerance Percentage');
ALTER TABLE `manufacturing_ecm`.`supplier`.`po_line_item` ALTER COLUMN `plant_code` SET TAGS ('dbx_business_glossary_term' = 'Plant Code');
ALTER TABLE `manufacturing_ecm`.`supplier`.`po_line_item` ALTER COLUMN `price_unit` SET TAGS ('dbx_business_glossary_term' = 'Price Unit');
ALTER TABLE `manufacturing_ecm`.`supplier`.`po_line_item` ALTER COLUMN `quality_inspection_required` SET TAGS ('dbx_business_glossary_term' = 'Quality Inspection Required Indicator');
ALTER TABLE `manufacturing_ecm`.`supplier`.`po_line_item` ALTER COLUMN `quantity_invoiced` SET TAGS ('dbx_business_glossary_term' = 'Quantity Invoiced');
ALTER TABLE `manufacturing_ecm`.`supplier`.`po_line_item` ALTER COLUMN `quantity_ordered` SET TAGS ('dbx_business_glossary_term' = 'Quantity Ordered');
ALTER TABLE `manufacturing_ecm`.`supplier`.`po_line_item` ALTER COLUMN `quantity_received` SET TAGS ('dbx_business_glossary_term' = 'Quantity Received');
ALTER TABLE `manufacturing_ecm`.`supplier`.`po_line_item` ALTER COLUMN `requisitioner_name` SET TAGS ('dbx_business_glossary_term' = 'Requisitioner Name');
ALTER TABLE `manufacturing_ecm`.`supplier`.`po_line_item` ALTER COLUMN `shipping_instruction` SET TAGS ('dbx_business_glossary_term' = 'Shipping Instruction');
ALTER TABLE `manufacturing_ecm`.`supplier`.`po_line_item` ALTER COLUMN `short_text` SET TAGS ('dbx_business_glossary_term' = 'Short Text Description');
ALTER TABLE `manufacturing_ecm`.`supplier`.`po_line_item` ALTER COLUMN `supplier_material_number` SET TAGS ('dbx_business_glossary_term' = 'Supplier Material Number');
ALTER TABLE `manufacturing_ecm`.`supplier`.`po_line_item` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `manufacturing_ecm`.`supplier`.`po_line_item` ALTER COLUMN `tax_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Code');
ALTER TABLE `manufacturing_ecm`.`supplier`.`po_line_item` ALTER COLUMN `under_delivery_tolerance_percent` SET TAGS ('dbx_business_glossary_term' = 'Under-Delivery Tolerance Percentage');
ALTER TABLE `manufacturing_ecm`.`supplier`.`po_line_item` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `manufacturing_ecm`.`supplier`.`procurement_goods_receipt` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `manufacturing_ecm`.`supplier`.`procurement_goods_receipt` SET TAGS ('dbx_subdomain' = 'procurement_operations');
ALTER TABLE `manufacturing_ecm`.`supplier`.`procurement_goods_receipt` ALTER COLUMN `procurement_goods_receipt_id` SET TAGS ('dbx_business_glossary_term' = 'Procurement Goods Receipt (GR) ID');
ALTER TABLE `manufacturing_ecm`.`supplier`.`procurement_goods_receipt` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`supplier`.`procurement_goods_receipt` ALTER COLUMN `engineering_revision_id` SET TAGS ('dbx_business_glossary_term' = 'Engineering Revision Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`supplier`.`procurement_goods_receipt` ALTER COLUMN `equipment_register_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Register Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`supplier`.`procurement_goods_receipt` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material ID');
ALTER TABLE `manufacturing_ecm`.`supplier`.`procurement_goods_receipt` ALTER COLUMN `po_line_item_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Line ID');
ALTER TABLE `manufacturing_ecm`.`supplier`.`procurement_goods_receipt` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) ID');
ALTER TABLE `manufacturing_ecm`.`supplier`.`procurement_goods_receipt` ALTER COLUMN `stock_location_id` SET TAGS ('dbx_business_glossary_term' = 'Storage Location ID');
ALTER TABLE `manufacturing_ecm`.`supplier`.`procurement_goods_receipt` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `manufacturing_ecm`.`supplier`.`procurement_goods_receipt` ALTER COLUMN `warehouse_id` SET TAGS ('dbx_business_glossary_term' = 'Warehouse ID');
ALTER TABLE `manufacturing_ecm`.`supplier`.`procurement_goods_receipt` ALTER COLUMN `accounting_document_number` SET TAGS ('dbx_business_glossary_term' = 'Accounting Document Number');
ALTER TABLE `manufacturing_ecm`.`supplier`.`procurement_goods_receipt` ALTER COLUMN `accounting_document_number` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `manufacturing_ecm`.`supplier`.`procurement_goods_receipt` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Number');
ALTER TABLE `manufacturing_ecm`.`supplier`.`procurement_goods_receipt` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `manufacturing_ecm`.`supplier`.`procurement_goods_receipt` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `manufacturing_ecm`.`supplier`.`procurement_goods_receipt` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `manufacturing_ecm`.`supplier`.`procurement_goods_receipt` ALTER COLUMN `damage_flag` SET TAGS ('dbx_business_glossary_term' = 'Damage Flag');
ALTER TABLE `manufacturing_ecm`.`supplier`.`procurement_goods_receipt` ALTER COLUMN `delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Delivery Date');
ALTER TABLE `manufacturing_ecm`.`supplier`.`procurement_goods_receipt` ALTER COLUMN `delivery_note_number` SET TAGS ('dbx_business_glossary_term' = 'Delivery Note Number');
ALTER TABLE `manufacturing_ecm`.`supplier`.`procurement_goods_receipt` ALTER COLUMN `document_date` SET TAGS ('dbx_business_glossary_term' = 'Document Date');
ALTER TABLE `manufacturing_ecm`.`supplier`.`procurement_goods_receipt` ALTER COLUMN `document_number` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt (GR) Document Number');
ALTER TABLE `manufacturing_ecm`.`supplier`.`procurement_goods_receipt` ALTER COLUMN `document_number` SET TAGS ('dbx_value_regex' = '^GR[0-9]{10}$');
ALTER TABLE `manufacturing_ecm`.`supplier`.`procurement_goods_receipt` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `manufacturing_ecm`.`supplier`.`procurement_goods_receipt` ALTER COLUMN `goods_receipt_status` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt (GR) Status');
ALTER TABLE `manufacturing_ecm`.`supplier`.`procurement_goods_receipt` ALTER COLUMN `goods_receipt_status` SET TAGS ('dbx_value_regex' = 'draft|posted|blocked|cancelled|reversed');
ALTER TABLE `manufacturing_ecm`.`supplier`.`procurement_goods_receipt` ALTER COLUMN `goods_receipt_value` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt (GR) Value');
ALTER TABLE `manufacturing_ecm`.`supplier`.`procurement_goods_receipt` ALTER COLUMN `gr_ir_clearing_status` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt / Invoice Receipt (GR/IR) Clearing Status');
ALTER TABLE `manufacturing_ecm`.`supplier`.`procurement_goods_receipt` ALTER COLUMN `gr_ir_clearing_status` SET TAGS ('dbx_value_regex' = 'open|partially_cleared|fully_cleared');
ALTER TABLE `manufacturing_ecm`.`supplier`.`procurement_goods_receipt` ALTER COLUMN `invoice_verification_flag` SET TAGS ('dbx_business_glossary_term' = 'Invoice Verification Flag');
ALTER TABLE `manufacturing_ecm`.`supplier`.`procurement_goods_receipt` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `manufacturing_ecm`.`supplier`.`procurement_goods_receipt` ALTER COLUMN `manufacturing_date` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Date');
ALTER TABLE `manufacturing_ecm`.`supplier`.`procurement_goods_receipt` ALTER COLUMN `material_document_number` SET TAGS ('dbx_business_glossary_term' = 'Material Document Number');
ALTER TABLE `manufacturing_ecm`.`supplier`.`procurement_goods_receipt` ALTER COLUMN `material_document_number` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `manufacturing_ecm`.`supplier`.`procurement_goods_receipt` ALTER COLUMN `material_document_year` SET TAGS ('dbx_business_glossary_term' = 'Material Document Year');
ALTER TABLE `manufacturing_ecm`.`supplier`.`procurement_goods_receipt` ALTER COLUMN `movement_type` SET TAGS ('dbx_business_glossary_term' = 'Movement Type');
ALTER TABLE `manufacturing_ecm`.`supplier`.`procurement_goods_receipt` ALTER COLUMN `movement_type` SET TAGS ('dbx_value_regex' = '^[0-9]{3}$');
ALTER TABLE `manufacturing_ecm`.`supplier`.`procurement_goods_receipt` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt (GR) Notes');
ALTER TABLE `manufacturing_ecm`.`supplier`.`procurement_goods_receipt` ALTER COLUMN `ordered_quantity` SET TAGS ('dbx_business_glossary_term' = 'Ordered Quantity');
ALTER TABLE `manufacturing_ecm`.`supplier`.`procurement_goods_receipt` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Date');
ALTER TABLE `manufacturing_ecm`.`supplier`.`procurement_goods_receipt` ALTER COLUMN `quality_inspection_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Quality Inspection Required Flag');
ALTER TABLE `manufacturing_ecm`.`supplier`.`procurement_goods_receipt` ALTER COLUMN `quality_inspection_status` SET TAGS ('dbx_business_glossary_term' = 'Quality Inspection Status');
ALTER TABLE `manufacturing_ecm`.`supplier`.`procurement_goods_receipt` ALTER COLUMN `quality_inspection_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|in_progress|passed|failed|waived');
ALTER TABLE `manufacturing_ecm`.`supplier`.`procurement_goods_receipt` ALTER COLUMN `quantity_variance` SET TAGS ('dbx_business_glossary_term' = 'Quantity Variance');
ALTER TABLE `manufacturing_ecm`.`supplier`.`procurement_goods_receipt` ALTER COLUMN `received_quantity` SET TAGS ('dbx_business_glossary_term' = 'Received Quantity');
ALTER TABLE `manufacturing_ecm`.`supplier`.`procurement_goods_receipt` ALTER COLUMN `receiving_person_name` SET TAGS ('dbx_business_glossary_term' = 'Receiving Person Name');
ALTER TABLE `manufacturing_ecm`.`supplier`.`procurement_goods_receipt` ALTER COLUMN `receiving_person_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `manufacturing_ecm`.`supplier`.`procurement_goods_receipt` ALTER COLUMN `receiving_plant_code` SET TAGS ('dbx_business_glossary_term' = 'Receiving Plant Code');
ALTER TABLE `manufacturing_ecm`.`supplier`.`procurement_goods_receipt` ALTER COLUMN `receiving_plant_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `manufacturing_ecm`.`supplier`.`procurement_goods_receipt` ALTER COLUMN `return_authorization_flag` SET TAGS ('dbx_business_glossary_term' = 'Return Authorization Flag');
ALTER TABLE `manufacturing_ecm`.`supplier`.`procurement_goods_receipt` ALTER COLUMN `reversal_date` SET TAGS ('dbx_business_glossary_term' = 'Reversal Date');
ALTER TABLE `manufacturing_ecm`.`supplier`.`procurement_goods_receipt` ALTER COLUMN `reversal_document_number` SET TAGS ('dbx_business_glossary_term' = 'Reversal Document Number');
ALTER TABLE `manufacturing_ecm`.`supplier`.`procurement_goods_receipt` ALTER COLUMN `reversal_flag` SET TAGS ('dbx_business_glossary_term' = 'Reversal Flag');
ALTER TABLE `manufacturing_ecm`.`supplier`.`procurement_goods_receipt` ALTER COLUMN `serial_number` SET TAGS ('dbx_business_glossary_term' = 'Serial Number');
ALTER TABLE `manufacturing_ecm`.`supplier`.`procurement_goods_receipt` ALTER COLUMN `stock_type` SET TAGS ('dbx_business_glossary_term' = 'Stock Type');
ALTER TABLE `manufacturing_ecm`.`supplier`.`procurement_goods_receipt` ALTER COLUMN `stock_type` SET TAGS ('dbx_value_regex' = 'unrestricted|quality_inspection|blocked|restricted');
ALTER TABLE `manufacturing_ecm`.`supplier`.`procurement_goods_receipt` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `manufacturing_ecm`.`supplier`.`procurement_goods_receipt` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,3}$');
ALTER TABLE `manufacturing_ecm`.`supplier`.`procurement_goods_receipt` ALTER COLUMN `vendor_batch_number` SET TAGS ('dbx_business_glossary_term' = 'Vendor Batch Number');
ALTER TABLE `manufacturing_ecm`.`supplier`.`invoice_line_item` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `manufacturing_ecm`.`supplier`.`invoice_line_item` SET TAGS ('dbx_subdomain' = 'procurement_operations');
ALTER TABLE `manufacturing_ecm`.`supplier`.`invoice_line_item` ALTER COLUMN `invoice_line_item_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Line Item ID');
ALTER TABLE `manufacturing_ecm`.`supplier`.`invoice_line_item` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`supplier`.`invoice_line_item` ALTER COLUMN `equipment_register_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Register Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`supplier`.`invoice_line_item` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`supplier`.`invoice_line_item` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material ID');
ALTER TABLE `manufacturing_ecm`.`supplier`.`invoice_line_item` ALTER COLUMN `po_line_item_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Line Item ID');
ALTER TABLE `manufacturing_ecm`.`supplier`.`invoice_line_item` ALTER COLUMN `procurement_goods_receipt_id` SET TAGS ('dbx_business_glossary_term' = 'Procurement Goods Receipt Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`supplier`.`invoice_line_item` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`supplier`.`invoice_line_item` ALTER COLUMN `baseline_date` SET TAGS ('dbx_business_glossary_term' = 'Baseline Date');
ALTER TABLE `manufacturing_ecm`.`supplier`.`invoice_line_item` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Number');
ALTER TABLE `manufacturing_ecm`.`supplier`.`invoice_line_item` ALTER COLUMN `blocking_reason` SET TAGS ('dbx_business_glossary_term' = 'Blocking Reason');
ALTER TABLE `manufacturing_ecm`.`supplier`.`invoice_line_item` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `manufacturing_ecm`.`supplier`.`invoice_line_item` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `manufacturing_ecm`.`supplier`.`invoice_line_item` ALTER COLUMN `delivery_note_number` SET TAGS ('dbx_business_glossary_term' = 'Delivery Note Number');
ALTER TABLE `manufacturing_ecm`.`supplier`.`invoice_line_item` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount');
ALTER TABLE `manufacturing_ecm`.`supplier`.`invoice_line_item` ALTER COLUMN `discount_percent` SET TAGS ('dbx_business_glossary_term' = 'Discount Percent');
ALTER TABLE `manufacturing_ecm`.`supplier`.`invoice_line_item` ALTER COLUMN `goods_receipt_quantity` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt Quantity');
ALTER TABLE `manufacturing_ecm`.`supplier`.`invoice_line_item` ALTER COLUMN `invoiced_quantity` SET TAGS ('dbx_business_glossary_term' = 'Invoiced Quantity');
ALTER TABLE `manufacturing_ecm`.`supplier`.`invoice_line_item` ALTER COLUMN `line_amount` SET TAGS ('dbx_business_glossary_term' = 'Line Amount');
ALTER TABLE `manufacturing_ecm`.`supplier`.`invoice_line_item` ALTER COLUMN `line_number` SET TAGS ('dbx_business_glossary_term' = 'Line Number');
ALTER TABLE `manufacturing_ecm`.`supplier`.`invoice_line_item` ALTER COLUMN `line_type` SET TAGS ('dbx_business_glossary_term' = 'Line Type');
ALTER TABLE `manufacturing_ecm`.`supplier`.`invoice_line_item` ALTER COLUMN `match_status` SET TAGS ('dbx_business_glossary_term' = 'Match Status');
ALTER TABLE `manufacturing_ecm`.`supplier`.`invoice_line_item` ALTER COLUMN `match_status` SET TAGS ('dbx_value_regex' = 'matched|quantity_variance|price_variance|blocked|unmatched|pending');
ALTER TABLE `manufacturing_ecm`.`supplier`.`invoice_line_item` ALTER COLUMN `material_description` SET TAGS ('dbx_business_glossary_term' = 'Material Description');
ALTER TABLE `manufacturing_ecm`.`supplier`.`invoice_line_item` ALTER COLUMN `material_number` SET TAGS ('dbx_business_glossary_term' = 'Material Number');
ALTER TABLE `manufacturing_ecm`.`supplier`.`invoice_line_item` ALTER COLUMN `net_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Amount');
ALTER TABLE `manufacturing_ecm`.`supplier`.`invoice_line_item` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `manufacturing_ecm`.`supplier`.`invoice_line_item` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `manufacturing_ecm`.`supplier`.`invoice_line_item` ALTER COLUMN `plant_code` SET TAGS ('dbx_business_glossary_term' = 'Plant Code');
ALTER TABLE `manufacturing_ecm`.`supplier`.`invoice_line_item` ALTER COLUMN `po_quantity` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Quantity');
ALTER TABLE `manufacturing_ecm`.`supplier`.`invoice_line_item` ALTER COLUMN `po_unit_price` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Unit Price');
ALTER TABLE `manufacturing_ecm`.`supplier`.`invoice_line_item` ALTER COLUMN `price_variance` SET TAGS ('dbx_business_glossary_term' = 'Price Variance');
ALTER TABLE `manufacturing_ecm`.`supplier`.`invoice_line_item` ALTER COLUMN `quantity_variance` SET TAGS ('dbx_business_glossary_term' = 'Quantity Variance');
ALTER TABLE `manufacturing_ecm`.`supplier`.`invoice_line_item` ALTER COLUMN `serial_number` SET TAGS ('dbx_business_glossary_term' = 'Serial Number');
ALTER TABLE `manufacturing_ecm`.`supplier`.`invoice_line_item` ALTER COLUMN `storage_location` SET TAGS ('dbx_business_glossary_term' = 'Storage Location');
ALTER TABLE `manufacturing_ecm`.`supplier`.`invoice_line_item` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `manufacturing_ecm`.`supplier`.`invoice_line_item` ALTER COLUMN `tax_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Code');
ALTER TABLE `manufacturing_ecm`.`supplier`.`invoice_line_item` ALTER COLUMN `tax_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Tax Rate Percent');
ALTER TABLE `manufacturing_ecm`.`supplier`.`invoice_line_item` ALTER COLUMN `tolerance_group` SET TAGS ('dbx_business_glossary_term' = 'Tolerance Group');
ALTER TABLE `manufacturing_ecm`.`supplier`.`invoice_line_item` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `manufacturing_ecm`.`supplier`.`invoice_line_item` ALTER COLUMN `unit_price` SET TAGS ('dbx_business_glossary_term' = 'Unit Price');
ALTER TABLE `manufacturing_ecm`.`supplier`.`invoice_line_item` ALTER COLUMN `valuation_type` SET TAGS ('dbx_business_glossary_term' = 'Valuation Type');
ALTER TABLE `manufacturing_ecm`.`supplier`.`invoice_line_item` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'Verification Date');
ALTER TABLE `manufacturing_ecm`.`supplier`.`invoice_line_item` ALTER COLUMN `verification_status` SET TAGS ('dbx_business_glossary_term' = 'Verification Status');
ALTER TABLE `manufacturing_ecm`.`supplier`.`invoice_line_item` ALTER COLUMN `verification_status` SET TAGS ('dbx_value_regex' = 'pending|verified|rejected|on_hold|approved');
ALTER TABLE `manufacturing_ecm`.`supplier`.`invoice_line_item` ALTER COLUMN `wbs_element` SET TAGS ('dbx_business_glossary_term' = 'Work Breakdown Structure (WBS) Element');
ALTER TABLE `manufacturing_ecm`.`supplier`.`purchase_info_record` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `manufacturing_ecm`.`supplier`.`purchase_info_record` SET TAGS ('dbx_subdomain' = 'procurement_operations');
ALTER TABLE `manufacturing_ecm`.`supplier`.`purchase_info_record` ALTER COLUMN `purchase_info_record_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Info Record ID');
ALTER TABLE `manufacturing_ecm`.`supplier`.`purchase_info_record` ALTER COLUMN `approved_vendor_list_id` SET TAGS ('dbx_business_glossary_term' = 'Approved Vendor List Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`supplier`.`purchase_info_record` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material ID');
ALTER TABLE `manufacturing_ecm`.`supplier`.`purchase_info_record` ALTER COLUMN `sku_master_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Master Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`supplier`.`purchase_info_record` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `manufacturing_ecm`.`supplier`.`purchase_info_record` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Site Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`supplier`.`purchase_info_record` ALTER COLUMN `approved_source_flag` SET TAGS ('dbx_business_glossary_term' = 'Approved Source Flag');
ALTER TABLE `manufacturing_ecm`.`supplier`.`purchase_info_record` ALTER COLUMN `contract_reference` SET TAGS ('dbx_business_glossary_term' = 'Contract Reference');
ALTER TABLE `manufacturing_ecm`.`supplier`.`purchase_info_record` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `manufacturing_ecm`.`supplier`.`purchase_info_record` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `manufacturing_ecm`.`supplier`.`purchase_info_record` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `manufacturing_ecm`.`supplier`.`purchase_info_record` ALTER COLUMN `fixed_source_flag` SET TAGS ('dbx_business_glossary_term' = 'Fixed Source Flag');
ALTER TABLE `manufacturing_ecm`.`supplier`.`purchase_info_record` ALTER COLUMN `incoterms` SET TAGS ('dbx_business_glossary_term' = 'Incoterms');
ALTER TABLE `manufacturing_ecm`.`supplier`.`purchase_info_record` ALTER COLUMN `incoterms` SET TAGS ('dbx_value_regex' = 'EXW|FCA|FOB|CFR|CIF|DAP');
ALTER TABLE `manufacturing_ecm`.`supplier`.`purchase_info_record` ALTER COLUMN `info_record_number` SET TAGS ('dbx_business_glossary_term' = 'Info Record Number');
ALTER TABLE `manufacturing_ecm`.`supplier`.`purchase_info_record` ALTER COLUMN `info_record_type` SET TAGS ('dbx_business_glossary_term' = 'Info Record Type');
ALTER TABLE `manufacturing_ecm`.`supplier`.`purchase_info_record` ALTER COLUMN `info_record_type` SET TAGS ('dbx_value_regex' = 'standard|subcontracting|pipeline|consignment');
ALTER TABLE `manufacturing_ecm`.`supplier`.`purchase_info_record` ALTER COLUMN `last_price_update_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Price Update Timestamp');
ALTER TABLE `manufacturing_ecm`.`supplier`.`purchase_info_record` ALTER COLUMN `minimum_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity');
ALTER TABLE `manufacturing_ecm`.`supplier`.`purchase_info_record` ALTER COLUMN `mrp_relevant_flag` SET TAGS ('dbx_business_glossary_term' = 'MRP Relevant Flag');
ALTER TABLE `manufacturing_ecm`.`supplier`.`purchase_info_record` ALTER COLUMN `net_price` SET TAGS ('dbx_business_glossary_term' = 'Net Price');
ALTER TABLE `manufacturing_ecm`.`supplier`.`purchase_info_record` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `manufacturing_ecm`.`supplier`.`purchase_info_record` ALTER COLUMN `order_quantity_multiple` SET TAGS ('dbx_business_glossary_term' = 'Order Quantity Multiple');
ALTER TABLE `manufacturing_ecm`.`supplier`.`purchase_info_record` ALTER COLUMN `planned_delivery_time_days` SET TAGS ('dbx_business_glossary_term' = 'Planned Delivery Time (Days)');
ALTER TABLE `manufacturing_ecm`.`supplier`.`purchase_info_record` ALTER COLUMN `plant_code` SET TAGS ('dbx_business_glossary_term' = 'Plant Code');
ALTER TABLE `manufacturing_ecm`.`supplier`.`purchase_info_record` ALTER COLUMN `price_change_date` SET TAGS ('dbx_business_glossary_term' = 'Price Change Date');
ALTER TABLE `manufacturing_ecm`.`supplier`.`purchase_info_record` ALTER COLUMN `price_change_indicator` SET TAGS ('dbx_business_glossary_term' = 'Price Change Indicator');
ALTER TABLE `manufacturing_ecm`.`supplier`.`purchase_info_record` ALTER COLUMN `price_change_indicator` SET TAGS ('dbx_value_regex' = 'increase|decrease|no_change');
ALTER TABLE `manufacturing_ecm`.`supplier`.`purchase_info_record` ALTER COLUMN `price_change_reason` SET TAGS ('dbx_business_glossary_term' = 'Price Change Reason');
ALTER TABLE `manufacturing_ecm`.`supplier`.`purchase_info_record` ALTER COLUMN `price_unit` SET TAGS ('dbx_business_glossary_term' = 'Price Unit');
ALTER TABLE `manufacturing_ecm`.`supplier`.`purchase_info_record` ALTER COLUMN `purchase_info_record_status` SET TAGS ('dbx_business_glossary_term' = 'Info Record Status');
ALTER TABLE `manufacturing_ecm`.`supplier`.`purchase_info_record` ALTER COLUMN `purchase_info_record_status` SET TAGS ('dbx_value_regex' = 'active|inactive|blocked|pending|expired');
ALTER TABLE `manufacturing_ecm`.`supplier`.`purchase_info_record` ALTER COLUMN `purchasing_group` SET TAGS ('dbx_business_glossary_term' = 'Purchasing Group');
ALTER TABLE `manufacturing_ecm`.`supplier`.`purchase_info_record` ALTER COLUMN `purchasing_organization` SET TAGS ('dbx_business_glossary_term' = 'Purchasing Organization');
ALTER TABLE `manufacturing_ecm`.`supplier`.`purchase_info_record` ALTER COLUMN `reminder_lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Reminder Lead Time (Days)');
ALTER TABLE `manufacturing_ecm`.`supplier`.`purchase_info_record` ALTER COLUMN `source_of_supply_category` SET TAGS ('dbx_business_glossary_term' = 'Source of Supply Category');
ALTER TABLE `manufacturing_ecm`.`supplier`.`purchase_info_record` ALTER COLUMN `source_priority` SET TAGS ('dbx_business_glossary_term' = 'Source Priority');
ALTER TABLE `manufacturing_ecm`.`supplier`.`purchase_info_record` ALTER COLUMN `tax_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Code');
ALTER TABLE `manufacturing_ecm`.`supplier`.`purchase_info_record` ALTER COLUMN `tolerance_limit_percent` SET TAGS ('dbx_business_glossary_term' = 'Tolerance Limit (%)');
ALTER TABLE `manufacturing_ecm`.`supplier`.`purchase_info_record` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `manufacturing_ecm`.`supplier`.`purchase_info_record` ALTER COLUMN `validity_end_date` SET TAGS ('dbx_business_glossary_term' = 'Validity End Date');
ALTER TABLE `manufacturing_ecm`.`supplier`.`purchase_info_record` ALTER COLUMN `validity_start_date` SET TAGS ('dbx_business_glossary_term' = 'Validity Start Date');
ALTER TABLE `manufacturing_ecm`.`supplier`.`purchase_info_record` ALTER COLUMN `vendor_material_number` SET TAGS ('dbx_business_glossary_term' = 'Vendor Material Number');
ALTER TABLE `manufacturing_ecm`.`supplier`.`purchase_info_record` ALTER COLUMN `vendor_price_list` SET TAGS ('dbx_business_glossary_term' = 'Vendor Price List');
ALTER TABLE `manufacturing_ecm`.`supplier`.`agreement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `manufacturing_ecm`.`supplier`.`agreement` SET TAGS ('dbx_subdomain' = 'performance_compliance');
ALTER TABLE `manufacturing_ecm`.`supplier`.`agreement` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Agreement Identifier');
ALTER TABLE `manufacturing_ecm`.`supplier`.`agreement` ALTER COLUMN `account_site_id` SET TAGS ('dbx_business_glossary_term' = 'Account Site Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`supplier`.`agreement` ALTER COLUMN `commodity_category_id` SET TAGS ('dbx_business_glossary_term' = 'Commodity Category Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`supplier`.`agreement` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`supplier`.`agreement` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`supplier`.`agreement` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`supplier`.`agreement` ALTER COLUMN `master_agreement_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `manufacturing_ecm`.`supplier`.`agreement` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Identifier');
ALTER TABLE `manufacturing_ecm`.`supplier`.`agreement` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Site Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`supplier`.`agreement` ALTER COLUMN `agreement_number` SET TAGS ('dbx_business_glossary_term' = 'Agreement Number');
ALTER TABLE `manufacturing_ecm`.`supplier`.`agreement` ALTER COLUMN `agreement_status` SET TAGS ('dbx_business_glossary_term' = 'Agreement Status');
ALTER TABLE `manufacturing_ecm`.`supplier`.`agreement` ALTER COLUMN `agreement_status` SET TAGS ('dbx_value_regex' = 'draft|active|expired|terminated|pending|suspended');
ALTER TABLE `manufacturing_ecm`.`supplier`.`agreement` ALTER COLUMN `agreement_type` SET TAGS ('dbx_business_glossary_term' = 'Agreement Type');
ALTER TABLE `manufacturing_ecm`.`supplier`.`agreement` ALTER COLUMN `agreement_type` SET TAGS ('dbx_value_regex' = 'framework|quality|nda|lta|consignment|tooling_loan');
ALTER TABLE `manufacturing_ecm`.`supplier`.`agreement` ALTER COLUMN `amendment_date` SET TAGS ('dbx_business_glossary_term' = 'Amendment Date');
ALTER TABLE `manufacturing_ecm`.`supplier`.`agreement` ALTER COLUMN `amendment_description` SET TAGS ('dbx_business_glossary_term' = 'Amendment Description');
ALTER TABLE `manufacturing_ecm`.`supplier`.`agreement` ALTER COLUMN `amendment_number` SET TAGS ('dbx_business_glossary_term' = 'Amendment Number');
ALTER TABLE `manufacturing_ecm`.`supplier`.`agreement` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `manufacturing_ecm`.`supplier`.`agreement` ALTER COLUMN `auto_renewal_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto‑Renewal Flag');
ALTER TABLE `manufacturing_ecm`.`supplier`.`agreement` ALTER COLUMN `auto_renewal_term_months` SET TAGS ('dbx_business_glossary_term' = 'Auto‑Renewal Term (Months)');
ALTER TABLE `manufacturing_ecm`.`supplier`.`agreement` ALTER COLUMN `confidentiality_clause_flag` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Clause Flag');
ALTER TABLE `manufacturing_ecm`.`supplier`.`agreement` ALTER COLUMN `contractual_term_months` SET TAGS ('dbx_business_glossary_term' = 'Contractual Term (Months)');
ALTER TABLE `manufacturing_ecm`.`supplier`.`agreement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `manufacturing_ecm`.`supplier`.`agreement` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `manufacturing_ecm`.`supplier`.`agreement` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `manufacturing_ecm`.`supplier`.`agreement` ALTER COLUMN `discount_terms` SET TAGS ('dbx_business_glossary_term' = 'Discount Terms');
ALTER TABLE `manufacturing_ecm`.`supplier`.`agreement` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `manufacturing_ecm`.`supplier`.`agreement` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `manufacturing_ecm`.`supplier`.`agreement` ALTER COLUMN `esg_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'ESG Compliance Flag');
ALTER TABLE `manufacturing_ecm`.`supplier`.`agreement` ALTER COLUMN `governing_law` SET TAGS ('dbx_business_glossary_term' = 'Governing Law');
ALTER TABLE `manufacturing_ecm`.`supplier`.`agreement` ALTER COLUMN `ip_protection_clause_flag` SET TAGS ('dbx_business_glossary_term' = 'IP Protection Clause Flag');
ALTER TABLE `manufacturing_ecm`.`supplier`.`agreement` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction');
ALTER TABLE `manufacturing_ecm`.`supplier`.`agreement` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `manufacturing_ecm`.`supplier`.`agreement` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `manufacturing_ecm`.`supplier`.`agreement` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `manufacturing_ecm`.`supplier`.`agreement` ALTER COLUMN `performance_kpi_summary` SET TAGS ('dbx_business_glossary_term' = 'Performance KPI Summary');
ALTER TABLE `manufacturing_ecm`.`supplier`.`agreement` ALTER COLUMN `price_index` SET TAGS ('dbx_business_glossary_term' = 'Price Index Reference');
ALTER TABLE `manufacturing_ecm`.`supplier`.`agreement` ALTER COLUMN `quality_expectations_summary` SET TAGS ('dbx_business_glossary_term' = 'Quality Expectations Summary');
ALTER TABLE `manufacturing_ecm`.`supplier`.`agreement` ALTER COLUMN `renewal_notice_period_days` SET TAGS ('dbx_business_glossary_term' = 'Renewal Notice Period (Days)');
ALTER TABLE `manufacturing_ecm`.`supplier`.`agreement` ALTER COLUMN `termination_notice_period_days` SET TAGS ('dbx_business_glossary_term' = 'Termination Notice Period (Days)');
ALTER TABLE `manufacturing_ecm`.`supplier`.`agreement` ALTER COLUMN `total_value` SET TAGS ('dbx_business_glossary_term' = 'Total Agreement Value');
ALTER TABLE `manufacturing_ecm`.`supplier`.`agreement` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `manufacturing_ecm`.`supplier`.`agreement` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
