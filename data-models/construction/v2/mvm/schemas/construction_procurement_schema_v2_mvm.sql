-- Schema for Domain: procurement | Business: Construction | Version: v2_mvm
-- Generated on: 2026-06-22 17:24:52

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_construction_v1`.`procurement` COMMENT 'Procurement and supply chain domain managing the full source-to-contract lifecycle including RFQ/RFP issuance, vendor evaluation, PO (Purchase Order) creation, MTO (Material Take-Off) data, supplier qualification records, and procurement lead times. Coordinates material delivery schedules with project timelines and manages vendor master data via SAP MM.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_construction_v1`.`procurement`.`vendor` (
    `vendor_id` BIGINT COMMENT 'Unique identifier for the vendor record. Primary key for the vendor master data product. System-generated surrogate key used across all procurement and supply chain transactions.',
    `account_number` STRING COMMENT 'SAP vendor account number assigned in SAP MM Vendor Master. External business identifier used in purchase orders, invoices, and payment processing. Unique across the ERP system.. Valid values are `^[A-Z0-9]{6,10}$`',
    `address_line_1` STRING COMMENT 'First line of the vendors registered business address. Typically contains street number and street name. Used for correspondence, legal notices, and payment remittance.',
    `address_line_2` STRING COMMENT 'Second line of the vendors business address. Contains suite, floor, building, or other secondary address information. Nullable if not applicable.',
    `annual_revenue_amount` DECIMAL(18,2) COMMENT 'Vendors reported annual revenue in the vendors default currency. Used for vendor size classification, capacity assessment, and financial stability evaluation. Typically self-reported or obtained from financial statements.',
    `approval_date` DATE COMMENT 'Date when the vendor was approved for procurement transactions following successful completion of prequalification, due diligence, and compliance checks. Nullable for prospective vendors not yet approved.',
    `audit_result` STRING COMMENT 'Outcome of the most recent vendor audit. Passed indicates full compliance; passed with conditions indicates minor findings requiring corrective action; failed indicates major non-conformances; not audited indicates no audit has been conducted.. Valid values are `passed|passed_with_conditions|failed|not_audited`',
    `bank_account_number` STRING COMMENT 'Vendors bank account number for electronic payment receipt. Highly sensitive financial information used for ACH and wire transfer processing. Encrypted at rest and in transit.',
    `bank_name` STRING COMMENT 'Name of the financial institution where the vendor maintains their primary business account for payment receipt. Used for electronic payment processing and wire transfers.',
    `bank_routing_number` STRING COMMENT 'Bank routing number, SWIFT code, or IBAN for the vendors bank account. Used to route electronic payments to the correct financial institution. Format varies by country and payment network.',
    `bonding_capacity_amount` DECIMAL(18,2) COMMENT 'Maximum bonding capacity available to the vendor in the vendors default currency. Represents the total value of performance bonds and payment bonds the vendor can secure from their surety. Critical for subcontractor prequalification and large contract awards.',
    `city` STRING COMMENT 'City or municipality where the vendors registered business address is located. Used for geographic analysis, local sourcing initiatives, and logistics planning.',
    `classification` STRING COMMENT 'Primary business classification of the vendor based on the type of goods or services provided. Determines procurement workflows, approval hierarchies, and contract templates. Material suppliers provide construction materials; equipment rental provides machinery; specialist subcontractors perform MEP, civil, or structural work; general contractors manage construction execution; professional services include design, engineering, and consulting; utility providers supply power, water, and telecommunications.. Valid values are `material_supplier|equipment_rental|specialist_subcontractor|general_contractor|professional_services|utility_provider`',
    `country_code` STRING COMMENT 'Three-letter ISO country code for the vendors registered business location. Used for international trade compliance, currency determination, and cross-border procurement regulations.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this vendor record was first created in the system. Used for data lineage, audit trails, and vendor relationship tenure analysis. System-generated and immutable.',
    `credit_rating` STRING COMMENT 'Credit rating assigned by credit rating agencies (Dun & Bradstreet, Moodys, S&P) reflecting the vendors financial stability and creditworthiness. Used for vendor risk assessment and payment term determination. NR indicates not rated. [ENUM-REF-CANDIDATE: aaa|aa|a|bbb|bb|b|ccc|cc|c|d|nr — 11 candidates stripped; promote to reference product]',
    `currency_code` STRING COMMENT 'Three-letter ISO currency code for the vendors default transaction currency. Determines the currency used for purchase orders, invoices, and payments. Used for foreign exchange exposure analysis.. Valid values are `^[A-Z]{3}$`',
    `diversity_classification` STRING COMMENT 'Diversity certification status for the vendor. MBE (Minority Business Enterprise), WBE (Women Business Enterprise), DBE (Disadvantaged Business Enterprise), SDVOSB (Service-Disabled Veteran-Owned Small Business), HUBZone (Historically Underutilized Business Zone). Used for diversity spend reporting and compliance with client diversity requirements.. Valid values are `mbe|wbe|dbe|sdvosb|hubzone|none`',
    `duns_number` STRING COMMENT 'Nine-digit DUNS number issued by Dun & Bradstreet for unique identification of business entities. Used for credit checks, vendor risk assessment, and compliance with government contracting requirements.. Valid values are `^[0-9]{9}$`',
    `employee_count` STRING COMMENT 'Total number of employees working for the vendor organization. Used for vendor capacity assessment, small business classification, and resource availability evaluation.',
    `geographic_coverage` STRING COMMENT 'Geographic regions or markets where the vendor operates and can provide services. Free-text field listing countries, states, or regions. Used for project-specific vendor selection and logistics planning.',
    `insurance_certificate_number` STRING COMMENT 'Certificate number for the vendors current general liability and professional indemnity insurance policy. Used to verify insurance coverage before contract execution and during vendor compliance audits.',
    `insurance_expiry_date` DATE COMMENT 'Expiration date of the vendors current insurance certificate. Monitored to ensure continuous insurance coverage throughout the contract period. Triggers renewal reminders and compliance alerts.',
    `last_audit_date` DATE COMMENT 'Date of the most recent vendor audit or compliance review. Audits assess quality systems, safety practices, financial controls, and contract compliance. Used to schedule periodic re-audits and maintain vendor qualification status.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this vendor record was last updated. Tracks the most recent change to any field in the vendor master record. Used for change tracking, data quality monitoring, and synchronization with downstream systems.',
    `vendor_name` STRING COMMENT 'Full legal name of the vendor organization as registered with tax authorities. Used on contracts, purchase orders, and payment documents. Must match legal registration documents.',
    `payment_method` DECIMAL(18,2) COMMENT 'Preferred payment method for remitting payment to the vendor. ACH for automated clearing house electronic transfer; wire transfer for same-day international payments; check for traditional paper payments; credit card for small purchases; letter of credit for international trade.',
    `payment_terms_code` DECIMAL(18,2) COMMENT 'Standard payment terms code defining the payment schedule and discount structure for this vendor. Examples include NET30 (net 30 days), NET60, 2/10NET30 (2% discount if paid within 10 days, otherwise net 30). Drives accounts payable processing and cash flow planning.',
    `postal_code` STRING COMMENT 'Postal or ZIP code for the vendors business address. Used for mail delivery, logistics planning, and geographic segmentation. Format varies by country.',
    `preferred_vendor_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this vendor has preferred vendor status. Preferred vendors receive priority consideration for bid invitations, expedited approval processes, and favorable payment terms based on proven performance and strategic relationship.',
    `prequalification_score` DECIMAL(18,2) COMMENT 'Composite score from the vendor prequalification process evaluating financial stability, technical capability, safety record, quality performance, and past project experience. Scale typically 0-100. Used for vendor ranking and bid invitation decisions.',
    `primary_contact_email` STRING COMMENT 'Email address of the primary vendor contact. Used for purchase order transmission, RFQ distribution, invoice queries, and general procurement communication.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `primary_contact_name` STRING COMMENT 'Full name of the primary business contact at the vendor organization. This individual serves as the main point of contact for procurement, contract administration, and operational coordination.',
    `primary_contact_phone` STRING COMMENT 'Primary telephone number for the vendor contact. Used for urgent procurement matters, delivery coordination, and issue resolution. Includes country code and extension where applicable.',
    `quality_certification` STRING COMMENT 'Quality management system certifications held by the vendor. Common certifications include ISO 9001 (Quality Management), ISO 14001 (Environmental Management), ISO 45001 (Occupational Health and Safety). Multiple certifications separated by semicolons.',
    `registration_date` DECIMAL(18,2) COMMENT 'Date when the vendor was first registered in the vendor master system. Marks the beginning of the vendor relationship and is used for vendor tenure analysis and anniversary tracking.',
    `state_province` STRING COMMENT 'State, province, or region where the vendor is located. Used for tax jurisdiction determination, regional sourcing analysis, and compliance with local content requirements.',
    `suspension_end_date` DATE COMMENT 'Planned or actual date when vendor suspension will be or was lifted. Nullable for indefinite suspensions or vendors that have never been suspended. Used for reinstatement planning and compliance tracking.',
    `suspension_reason` STRING COMMENT 'Reason for vendor suspension or blocking if vendor_status is suspended or blocked. Examples include quality issues, safety violations, contract breaches, financial instability, or ethical violations. Nullable for active vendors.',
    `suspension_start_date` DATE COMMENT 'Date when vendor suspension or blocking became effective. Used to track suspension duration and trigger review processes. Nullable for vendors that have never been suspended.',
    `tax_identification_number` STRING COMMENT 'Government-issued tax identification number for the vendor. Used for tax reporting, 1099 processing, and compliance with tax regulations. Format varies by jurisdiction (EIN in USA, VAT number in EU, GST number in other regions).',
    `vendor_status` STRING COMMENT 'Current lifecycle status of the vendor in the vendor master. Approved vendors can receive purchase orders; prospective vendors are under evaluation; suspended vendors have temporary restrictions; blocked vendors cannot receive new orders; inactive vendors are no longer used; under_review vendors are being re-qualified.. Valid values are `approved|prospective|suspended|blocked|inactive|under_review`',
    CONSTRAINT pk_vendor PRIMARY KEY(`vendor_id`)
) COMMENT 'Master record for all approved and prospective suppliers, subcontractors, and material vendors managed via SAP MM Vendor Master. Captures vendor identity, classification (material supplier, equipment rental, specialist subcontractor), registration status, tax identifiers, payment terms, currency, bank details, geographic coverage, diversity classification (MBE/WBE/DBE), bonding capacity, insurance certificates, and SAP vendor account number. SSOT for vendor identity across the procurement domain.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`procurement`.`vendor_qualification` (
    `vendor_qualification_id` BIGINT COMMENT 'Unique identifier for the vendor qualification record. Primary key for the vendor qualification entity.',
    `asset_category_id` BIGINT COMMENT 'Foreign key linking to equipment.asset_category. Business justification: Construction vendor prequalification specifies which equipment categories a vendor is certified to maintain or operate (e.g., crane service vendors, lifting equipment). Vendor qualification by equipm',
    `vendor_id` BIGINT COMMENT 'Reference to the vendor master record being qualified. Links to the vendor entity in the procurement domain.',
    `approval_date` DATE COMMENT 'Date when the vendor qualification was formally approved and the vendor was added to the AVL (Approved Vendor List).',
    `approved_material_categories` STRING COMMENT 'Comma-separated list of material categories the vendor is qualified to supply. Examples include concrete, steel, MEP (Mechanical Electrical and Plumbing) equipment, formwork, aggregates. Aligns with MTO (Material Take-Off) classification.',
    `approved_service_types` STRING COMMENT 'Comma-separated list of service types the vendor is qualified to provide. Examples include earthworks, structural steel erection, electrical installation, HVAC installation, concrete placement, surveying.',
    `bonding_capacity_currency` STRING COMMENT 'ISO 4217 three-letter currency code for bonding capacity limit. Typically USD for US-based projects.. Valid values are `^[A-Z]{3}$`',
    `bonding_capacity_limit` DECIMAL(18,2) COMMENT 'Maximum bonding capacity available from the vendors surety company. Determines the maximum contract value the vendor can undertake. Critical for GC (General Contractor) and major subcontractor qualifications.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the vendor qualification record was first created in the system. Part of audit trail for compliance and governance.',
    `financial_health_score` DECIMAL(18,2) COMMENT 'Composite financial health assessment score ranging from 0.00 to 100.00. Based on credit rating, liquidity ratios, debt-to-equity, and financial statement analysis. Minimum threshold typically 60.00 for approval.',
    `geographic_coverage` STRING COMMENT 'Geographic regions or countries where the vendor is qualified to operate. Comma-separated list of ISO 3166 country codes or region names. Important for multi-site and international projects.',
    `hse_performance_rating` STRING COMMENT 'HSE (Health Safety and Environment) performance rating based on TRIR (Total Recordable Incident Rate), LTI (Lost Time Injury) frequency, safety audit results, and compliance with OSHA (Occupational Safety and Health Administration) standards. Critical factor for vendor approval.. Valid values are `excellent|good|satisfactory|needs_improvement|unacceptable`',
    `insurance_certificate_expiry_date` DATE COMMENT 'Expiry date of the vendors insurance certificate. Procurement tracks this to ensure continuous coverage throughout contract execution.',
    `insurance_general_liability_limit` DECIMAL(18,2) COMMENT 'General liability insurance coverage limit. Minimum requirements typically range from $1M to $10M depending on project size and risk profile.',
    `insurance_workers_comp_verified` BOOLEAN COMMENT 'Indicates whether valid workers compensation insurance has been verified. Mandatory for all vendors providing on-site labor per OSHA (Occupational Safety and Health Administration) requirements.',
    `iso_14001_certificate_number` STRING COMMENT 'Certificate number for ISO 14001 Environmental Management System certification.',
    `iso_14001_certified` BOOLEAN COMMENT 'Indicates whether the vendor holds valid ISO 14001 Environmental Management System certification. Increasingly required for LEED (Leadership in Energy and Environmental Design) projects and environmentally sensitive sites.',
    `iso_14001_expiry_date` DATE COMMENT 'Expiry date of ISO 14001 certification. Critical for projects with EPA (Environmental Protection Agency) compliance requirements.',
    `iso_45001_certificate_number` STRING COMMENT 'Certificate number for ISO 45001 Occupational Health and Safety Management System certification.',
    `iso_45001_certified` BOOLEAN COMMENT 'Indicates whether the vendor holds valid ISO 45001 Occupational Health and Safety Management System certification. Demonstrates commitment to worker safety and HSE (Health Safety and Environment) excellence.',
    `iso_45001_expiry_date` DATE COMMENT 'Expiry date of ISO 45001 certification. Monitored to ensure ongoing HSE (Health Safety and Environment) compliance.',
    `iso_9001_certificate_number` STRING COMMENT 'Certificate number for ISO 9001 Quality Management System certification. Used for verification with certification body.',
    `iso_9001_certified` BOOLEAN COMMENT 'Indicates whether the vendor holds valid ISO 9001 Quality Management System certification. Often mandatory for critical material suppliers and major subcontractors.',
    `iso_9001_expiry_date` DATE COMMENT 'Expiry date of ISO 9001 certification. Procurement monitors this to ensure vendors maintain valid certification throughout contract execution.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the vendor qualification record was last updated. Tracks changes to qualification status, scores, certifications, or other attributes.',
    `lti_frequency_rate` DECIMAL(18,2) COMMENT 'LTI (Lost Time Injury) frequency rate calculated as (number of LTIs × 1,000,000) / total hours worked. Measures severity of safety incidents. Target is typically below 1.0 for qualified vendors.',
    `notes` STRING COMMENT 'Free-text notes capturing additional qualification details, special conditions, limitations, or observations from the assessment process. Used by procurement team for decision support.',
    `on_time_delivery_rate` DECIMAL(18,2) COMMENT 'Percentage of past deliveries completed on or before scheduled date. Critical metric for CPM (Critical Path Method) schedule-sensitive projects. Target is typically above 90.00%.',
    `past_performance_score` DECIMAL(18,2) COMMENT 'Composite past performance score ranging from 0.00 to 100.00. Based on historical project delivery, quality, schedule adherence, cost control, and client satisfaction. Derived from completed project evaluations and NCR (Non-Conformance Report) history.',
    `qualification_assessment_date` DATE COMMENT 'Date when the qualification assessment was conducted. Includes site visits, document reviews, financial analysis, and technical capability evaluation.',
    `qualification_category` STRING COMMENT 'Primary category of goods or services the vendor is qualified to supply. MEP (Mechanical Electrical and Plumbing) is a specialized category for building systems contractors.. Valid values are `materials|equipment|services|subcontractor|mep|specialty`',
    `qualification_expiry_date` DATE COMMENT 'Date on which the vendor qualification expires and requires renewal. Typically set 1-3 years from start date depending on vendor category and risk profile.',
    `qualification_number` STRING COMMENT 'Business identifier for the vendor qualification record. Externally visible unique reference number used in procurement communications and AVL (Approved Vendor List) documentation.. Valid values are `^VQ-[0-9]{8}$`',
    `qualification_start_date` DATE COMMENT 'Effective date from which the vendor qualification becomes valid. Vendors can only receive PO (Purchase Order) assignments on or after this date.',
    `qualification_status` STRING COMMENT 'Current lifecycle status of the vendor qualification. Approved vendors are eligible for PO (Purchase Order) issuance. Suspended vendors require re-qualification. Expired qualifications require renewal.. Valid values are `draft|under_review|approved|rejected|suspended|expired`',
    `qualification_type` STRING COMMENT 'Type of qualification process being conducted. Initial for new vendors, renewal for periodic re-assessment, re-qualification for vendors returning after suspension, conditional for limited-scope approval, emergency for urgent project needs.. Valid values are `initial|renewal|re_qualification|conditional|emergency`',
    `quality_defect_rate` DECIMAL(18,2) COMMENT 'Historical quality defect rate expressed as percentage of deliverables requiring rework or NCR (Non-Conformance Report) issuance. Lower values indicate better quality performance. Target is typically below 5.00%.',
    `rejection_reason` STRING COMMENT 'Detailed explanation if the vendor qualification was rejected. Includes specific deficiencies in financial health, technical capability, HSE (Health Safety and Environment) performance, or documentation.',
    `suspension_date` DATE COMMENT 'Date when the vendor qualification was suspended. Suspended vendors cannot receive new PO (Purchase Order) assignments until re-qualified.',
    `suspension_reason` STRING COMMENT 'Reason for suspending an approved vendor qualification. Common causes include safety incidents, quality failures, financial distress, contract breaches, or regulatory violations.',
    `technical_capability_score` DECIMAL(18,2) COMMENT 'Assessment score of vendor technical capabilities ranging from 0.00 to 100.00. Evaluates equipment, workforce skills, past project complexity, and technical certifications. Minimum threshold typically 70.00 for complex EPC (Engineering Procurement and Construction) projects.',
    `trir_rate` DECIMAL(18,2) COMMENT 'TRIR (Total Recordable Incident Rate) calculated as (number of recordable incidents × 200,000) / total hours worked. Industry benchmark for construction is typically below 3.0. Lower values indicate better safety performance.',
    CONSTRAINT pk_vendor_qualification PRIMARY KEY(`vendor_qualification_id`)
) COMMENT 'Supplier pre-qualification and approved vendor list (AVL) records capturing qualification status, financial health assessments, technical capability evaluations, HSE performance ratings, quality certifications (ISO 9001, ISO 14001, ISO 45001), bonding limits, insurance coverage verification, past performance scores, and qualification expiry dates. Tracks the full vendor onboarding and re-qualification lifecycle required before a vendor can receive a PO.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`procurement`.`material_catalog` (
    `material_catalog_id` BIGINT COMMENT 'Primary key for material_catalog',
    `master_id` BIGINT COMMENT 'Unique identifier for the material master record in the procurement catalog. Primary key for the material catalog product.',
    `technical_specification_id` BIGINT COMMENT 'Foreign key linking to design.technical_specification. Business justification: Spec-qualified catalog items: Material catalog entries are qualified against technical specifications that define the standard the material must meet. The existing specification_reference plain-text',
    `abc_classification` STRING COMMENT 'Inventory classification based on value and consumption frequency. A=High value/critical items requiring tight control, B=Moderate value, C=Low value/high volume items. Drives inventory policy and cycle counting frequency.. Valid values are `A|B|C`',
    `alternative_unit_of_measure` STRING COMMENT 'Secondary unit of measure for materials that can be ordered or issued in multiple units (e.g., cement ordered in bags but tracked in tons). Supports conversion factor calculations.',
    `base_unit_of_measure` STRING COMMENT 'Primary unit of measure for material quantity tracking, ordering, and inventory management. Aligns with industry standards for construction materials (EA=Each, M=Meter, M2=Square Meter, M3=Cubic Meter, KG=Kilogram, TON=Metric Ton). [ENUM-REF-CANDIDATE: EA|M|M2|M3|KG|TON|L|GAL|FT|YD|LB|BAG|BOX|ROLL — 14 candidates stripped; promote to reference product]',
    `bim_object_reference` STRING COMMENT 'Unique identifier linking the material to its corresponding 3D object in BIM 360 or other BIM platforms. Enables digital twin integration and clash detection during design and construction phases.',
    `cost_currency` DECIMAL(18,2) COMMENT 'Three-letter ISO 4217 currency code for standard cost (e.g., USD, EUR, GBP). Supports multi-currency procurement and financial consolidation.',
    `country_of_origin` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code indicating where the material is manufactured or sourced. Required for customs compliance, trade regulations, and local content reporting.. Valid values are `^[A-Z]{3}$`',
    `created_date` DATE COMMENT 'Date when the material master record was first created in the system. Used for audit trail and master data governance.',
    `customs_tariff_number` STRING COMMENT 'Harmonized System (HS) code for international trade classification. Used for customs clearance, duty calculation, and import/export documentation for cross-border procurement.. Valid values are `^[0-9]{6,10}$`',
    `dimension_unit` STRING COMMENT 'Unit of measure for length, width, and height dimensions. Typically meters (M) for construction industry standards.. Valid values are `M|CM|MM|FT|IN`',
    `environmental_certification` STRING COMMENT 'Environmental sustainability certification held by the material (e.g., LEED certified, FSC certified, Energy Star). Supports green building requirements and sustainability reporting.',
    `gross_weight` DECIMAL(18,2) COMMENT 'Total weight of the material including packaging, measured in kilograms. Used for logistics planning, transportation cost calculation, and site delivery scheduling.',
    `hazard_class` STRING COMMENT 'UN hazard classification code for hazardous materials (e.g., Class 3 Flammable Liquids, Class 8 Corrosives). Required for transportation, storage, and safety data sheet (SDS) compliance.',
    `hazardous_material_indicator` BOOLEAN COMMENT 'Flag indicating whether the material is classified as hazardous per OSHA and EPA regulations. Triggers special handling, storage, and HSE (Health Safety and Environment) compliance requirements.',
    `height` DECIMAL(18,2) COMMENT 'Height dimension of the material in meters. Essential for volume calculations and warehouse stacking constraints.',
    `last_modified_by` STRING COMMENT 'User ID or name of the person who last updated the material master record. Tracks data ownership and change responsibility.',
    `last_modified_date` DATE COMMENT 'Date when the material master record was last updated. Tracks data currency and supports change management processes.',
    `length` DECIMAL(18,2) COMMENT 'Length dimension of the material in meters. Critical for structural materials (beams, pipes, cables) and storage space planning.',
    `manufacturer_name` STRING COMMENT 'Name of the primary manufacturer or brand for the material. Used for quality assurance, warranty tracking, and approved vendor list (AVL) compliance.',
    `manufacturer_part_number` STRING COMMENT 'Manufacturers unique part number or model code for the material. Critical for exact specification matching, warranty claims, and spare parts procurement.',
    `material_description` STRING COMMENT 'Full textual description of the material, equipment component, or consumable item. Provides detailed specification and identification information for procurement and inventory purposes.',
    `material_group` STRING COMMENT 'Classification code grouping materials by procurement category (e.g., concrete, steel, MEP equipment, PPE). Used for procurement strategy, vendor assignment, and spend analysis.. Valid values are `^[A-Z0-9]{4,10}$`',
    `material_number` STRING COMMENT 'Unique business identifier for the material as defined in SAP MM Material Master. This is the externally-known code used across MTO (Material Take-Off), PO (Purchase Order), and goods receipt processes.. Valid values are `^[A-Z0-9]{8,18}$`',
    `material_status` STRING COMMENT 'Current lifecycle status of the material in the catalog. Controls procurement eligibility and inventory transactions. Blocked materials cannot be ordered; obsolete materials are phased out.. Valid values are `active|inactive|blocked|obsolete|pending_approval|restricted`',
    `material_type` STRING COMMENT 'SAP material type classification defining procurement and inventory control behavior. RAW=Raw Material, SEMI=Semi-Finished, FERT=Finished Product, HAWA=Trading Goods, NLAG=Non-Stock Material, UNBW=Non-Valuated Material, DIEN=Services, VERP=Packaging, HIBE=Operating Supplies. [ENUM-REF-CANDIDATE: RAW|SEMI|FERT|HAWA|NLAG|UNBW|DIEN|VERP|HIBE — 9 candidates stripped; promote to reference product]',
    `minimum_order_quantity` DECIMAL(18,2) COMMENT 'Smallest quantity that can be ordered from suppliers in base unit of measure. Drives procurement batch sizing and inventory optimization.',
    `net_weight` DECIMAL(18,2) COMMENT 'Weight of the material excluding packaging, measured in kilograms. Used for material quantity verification and yield calculations in construction processes.',
    `procurement_lead_time_days` STRING COMMENT 'Standard number of days from PO (Purchase Order) issuance to material delivery on site. Used for project scheduling, MRP (Material Requirements Planning), and critical path analysis.',
    `quality_inspection_required` BOOLEAN COMMENT 'Flag indicating whether incoming goods receipt requires quality inspection per ITP (Inspection and Test Plan) before acceptance. Triggers QA/QC workflow in goods receipt process.',
    `shelf_life_days` STRING COMMENT 'Maximum number of days the material can be stored before expiration or quality degradation. Critical for perishable materials (adhesives, sealants, chemicals) and inventory rotation (FIFO/FEFO).',
    `short_description` STRING COMMENT 'Abbreviated description of the material for display in transaction screens, reports, and mobile applications. Limited to 40 characters for operational efficiency.',
    `standard_cost` DECIMAL(18,2) COMMENT 'Baseline unit cost of the material used for project budgeting, cost estimation, and variance analysis. Updated periodically based on procurement history and market conditions.',
    `storage_condition` STRING COMMENT 'Required environmental conditions for material storage to maintain quality and safety. Drives warehouse zone assignment and inventory handling procedures. [ENUM-REF-CANDIDATE: ambient|climate_controlled|refrigerated|dry|ventilated|hazmat_certified|outdoor_covered|outdoor_uncovered — 8 candidates stripped; promote to reference product]',
    `valuation_class` STRING COMMENT 'SAP valuation class code linking material to general ledger (GL) accounts for inventory valuation and cost of goods sold (COGS) posting. Drives financial accounting integration.. Valid values are `^[0-9]{4}$`',
    `volume` DECIMAL(18,2) COMMENT 'Volumetric measurement of the material in cubic meters. Used for bulk materials (concrete, aggregates) and transportation capacity planning.',
    `volume_unit` STRING COMMENT 'Unit of measure for volume field. Typically cubic meters (M3) for construction bulk materials.. Valid values are `M3|L|GAL|FT3`',
    `weight_unit` STRING COMMENT 'Unit of measure for gross and net weight fields. Typically kilograms (KG) or metric tons (TON) for construction materials.. Valid values are `KG|TON|LB|G`',
    `width` DECIMAL(18,2) COMMENT 'Width dimension of the material in meters. Used for area calculations and storage layout planning.',
    `created_by` STRING COMMENT 'User ID or name of the person who created the material master record. Supports audit trail and data stewardship accountability.',
    CONSTRAINT pk_material_catalog PRIMARY KEY(`material_catalog_id`)
) COMMENT 'Authoritative catalog of all procurable materials, equipment components, and consumables managed in SAP MM Material Master. Captures material number, description, material group, base unit of measure, weight, dimensions, hazardous material classification, storage conditions, lead time, minimum order quantity, standard cost, and BIM object reference. SSOT for material identity used across MTO, PO, and goods receipt processes.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`procurement`.`rfq` (
    `rfq_id` BIGINT COMMENT 'Unique identifier for the Request for Quotation record. Primary key for the RFQ entity.',
    `vendor_id` BIGINT COMMENT 'Identifier of the vendor to whom the contract or purchase order was awarded following RFQ evaluation. Null if RFQ is not yet awarded or was cancelled.',
    `bim_model_id` BIGINT COMMENT 'Foreign key linking to design.bim_model. Business justification: BIM-based quantity takeoff for procurement: RFQs in construction are scoped against a BIM model to extract quantities and element specifications. The existing bim_reference plain-text field is a den',
    `account_id` BIGINT COMMENT 'Foreign key linking to client.account. Business justification: RFQ is issued by a client account; linking enables audit of which client requested each quotation.',
    `construction_project_id` BIGINT COMMENT 'Identifier of the construction project for which this RFQ is issued. Links the RFQ to the specific project requiring materials, equipment, or services.',
    `drawing_id` BIGINT COMMENT 'Foreign key linking to design.drawing. Business justification: RFQ includes design drawing to define item scope; procurement uses drawing for accurate material specification.',
    `mto_header_id` BIGINT COMMENT 'Foreign key linking to material.mto_header. Business justification: In construction, RFQs are issued to cover an MTO package (mto_header). The existing mto_reference is a denormalized string; a proper FK enables procurement teams to track which MTO packages are under ',
    `purchase_requisition_id` BIGINT COMMENT 'Foreign key linking to procurement.purchase_requisition. Business justification: An RFQ is typically initiated to fulfill one or more purchase requisitions — the PR is the internal demand signal that triggers the external sourcing event. Linking rfq.purchase_requisition_id → purch',
    `technical_specification_id` BIGINT COMMENT 'Foreign key linking to design.technical_specification. Business justification: RFQ references technical specification that defines material requirements; linking ensures traceability from procurement to design spec.',
    `award_date` DATE COMMENT 'Date on which the contract or purchase order was awarded to the selected vendor. Null if RFQ is not yet awarded.',
    `awarded_amount` DECIMAL(18,2) COMMENT 'Total monetary value of the contract or purchase order awarded to the winning vendor. Null if RFQ is not yet awarded.',
    `bid_bond_amount` DECIMAL(18,2) COMMENT 'Monetary value of the bid bond required from vendors, if applicable. Typically a percentage of the estimated contract value.',
    `bid_bond_required` BOOLEAN COMMENT 'Indicates whether vendors must submit a bid bond or financial guarantee with their quotation to demonstrate commitment and financial capacity.',
    `boq_reference` STRING COMMENT 'Reference to the Bill of Quantities document or section that this RFQ is based on. Links the RFQ to the project cost estimation and material take-off data.',
    `cancellation_reason` STRING COMMENT 'Explanation for why the RFQ was cancelled or withdrawn, if applicable. May include project scope changes, budget constraints, or inadequate vendor response.',
    `closed_timestamp` TIMESTAMP COMMENT 'Date and time when the RFQ was officially closed, either through award, cancellation, or withdrawal. Marks the end of the vendor response period.',
    `contract_type` STRING COMMENT 'Type of contract structure anticipated for the awarded work: lump sum, unit price, cost plus fee, Guaranteed Maximum Price (GMP), or time and materials.. Valid values are `lump_sum|unit_price|cost_plus|gmp|time_and_materials`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the RFQ record was first created in the system. Used for audit trail and lifecycle tracking.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code in which vendor quotations must be submitted (e.g., USD, EUR, GBP). Ensures consistent pricing comparison.. Valid values are `^[A-Z]{3}$`',
    `delivery_location` STRING COMMENT 'Physical site address or location code where the materials or equipment must be delivered. May reference a specific construction site, warehouse, or laydown area.',
    `evaluation_criteria` STRING COMMENT 'Description of the criteria and weighting used to evaluate vendor quotations. May include price, delivery time, quality certifications, past performance, and technical compliance.',
    `hse_requirements` STRING COMMENT 'Health, safety, and environmental requirements that vendors must meet, including OSHA compliance, PPE standards, SWMS, and environmental permits.',
    `incoterms` STRING COMMENT 'Incoterms code defining the responsibilities of buyer and seller for transportation, insurance, and risk transfer. Critical for international procurement. [ENUM-REF-CANDIDATE: EXW|FCA|CPT|CIP|DAP|DPU|DDP|FAS|FOB|CFR|CIF — 11 candidates stripped; promote to reference product]',
    `invited_vendor_count` STRING COMMENT 'Number of vendors invited to submit quotations for this RFQ. Used to track competitive bidding and ensure adequate market coverage.',
    `issue_date` DATE COMMENT 'Date on which the RFQ was officially issued to vendors. Marks the start of the vendor response period.',
    `issuing_department` STRING COMMENT 'Name or code of the department or business unit that issued the RFQ, such as Procurement, Project Management, or Engineering.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when the RFQ record was last updated. Tracks changes to scope, dates, or status throughout the RFQ lifecycle.',
    `payment_terms` DECIMAL(18,2) COMMENT 'Standard payment terms specified in the RFQ, such as net 30, net 60, progress payments, or milestone-based payments. Defines when and how vendors will be paid.',
    `procurement_lead_time_days` STRING COMMENT 'Estimated or actual number of days from RFQ issuance to material delivery or service commencement. Used for project scheduling and critical path analysis.',
    `quality_requirements` STRING COMMENT 'Description of quality assurance and quality control requirements, including certifications (ISO 9001), testing protocols (FAT, SAT), and inspection plans (ITP) that vendors must comply with.',
    `required_delivery_date` DATE COMMENT 'Target date by which the materials, equipment, or services must be delivered to the project site. Critical for project scheduling alignment using CPM.',
    `response_count` STRING COMMENT 'Number of vendor quotations received in response to this RFQ. Indicates level of vendor interest and competitive response.',
    `retention_percentage` DECIMAL(18,2) COMMENT 'Percentage of each payment that will be retained until project completion or defects liability period ends. Standard risk mitigation practice in construction contracts.',
    `rfq_number` STRING COMMENT 'Business identifier for the RFQ, externally visible and used in vendor communications and procurement workflows. Typically follows organizational numbering conventions.. Valid values are `^RFQ-[A-Z0-9]{6,12}$`',
    `rfq_status` STRING COMMENT 'Current lifecycle status of the RFQ. Tracks progression from draft creation through vendor response collection to final award or cancellation. [ENUM-REF-CANDIDATE: draft|issued|open|closed|awarded|cancelled|withdrawn — 7 candidates stripped; promote to reference product]',
    `rfq_type` STRING COMMENT 'Classification of the RFQ based on the category of procurement: materials (concrete, steel), equipment (cranes, generators), services (engineering, testing), or subcontract work packages.. Valid values are `materials|equipment|services|subcontract|design_build`',
    `submission_deadline` TIMESTAMP COMMENT 'Date and time by which vendors must submit their quotations. Late submissions may be rejected per procurement policy.',
    `title` STRING COMMENT 'Short descriptive title summarizing the scope of the RFQ, such as Structural Steel for Bridge Phase 2 or MEP Equipment for Terminal Building.',
    `vendor_prequalification_required` BOOLEAN COMMENT 'Indicates whether vendors must be prequalified or approved before they can submit quotations. Ensures only qualified vendors participate in the bidding process.',
    `warranty_period_months` STRING COMMENT 'Duration in months for which the vendor must provide warranty coverage for materials or equipment. Also known as Defects Liability Period (DLP) in some jurisdictions.',
    CONSTRAINT pk_rfq PRIMARY KEY(`rfq_id`)
) COMMENT 'Request for Quotation records issued to vendors for pricing and availability of materials, equipment, or services, including header-level metadata and granular line-item detail. Captures RFQ number, issuing project, scope description, BOQ reference, submission deadline, bid bond requirement, evaluation criteria, invited vendor list, currency, RFQ status (draft, issued, closed, awarded, cancelled), and individual line items (line number, material/service description, quantity, UoM, required delivery date, site delivery location, technical specification reference, drawing/BIM reference). Sourced from SAP MM RFQ process and Procore bid management workflows. Enables granular vendor pricing comparison at the line-item level.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`procurement`.`rfq_line` (
    `rfq_line_id` BIGINT COMMENT 'Unique identifier for the RFQ line item. Primary key for this entity.',
    `bim_model_id` BIGINT COMMENT 'Foreign key linking to design.bim_model. Business justification: Model-based procurement at line level: RFQ line items are linked to BIM model elements for quantity extraction and scope definition. The existing bim_model_reference plain-text field denormalizes th',
    `cost_code_id` BIGINT COMMENT 'Foreign key linking to finance.cost_code. Business justification: RFQ lines in construction reference cost codes to validate bids against budget line items. Proper FK replaces denormalized cost_code text field, enabling budget-to-bid comparison reporting, cost code ',
    `drawing_id` BIGINT COMMENT 'Foreign key linking to design.drawing. Business justification: Line-level drawing traceability: Each RFQ line item corresponds to a specific drawing callout or detail. The existing drawing_reference plain-text field denormalizes this FK. Construction estimators',
    `material_catalog_id` BIGINT COMMENT 'Foreign key linking to procurement.material_catalog. Business justification: Link RFQ line material to master catalog for normalization and remove redundant material_id column.',
    `vendor_id` BIGINT COMMENT 'Reference to a preferred or pre-qualified vendor for this item, if applicable.',
    `construction_project_id` BIGINT COMMENT 'Reference to the construction project for which this material or service is being procured.',
    `rfq_id` BIGINT COMMENT 'Reference to the parent RFQ header document under which this line item is issued.',
    `technical_specification_id` BIGINT COMMENT 'Foreign key linking to design.technical_specification. Business justification: Line-level spec compliance: Each RFQ line item has specific technical requirements defined by a specification section. The existing technical_specification_reference plain-text field denormalizes th',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this RFQ line item record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the estimated amounts and vendor quotations (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `delivery_location` STRING COMMENT 'The site, warehouse, or facility address where the material or service is to be delivered.',
    `estimated_total_amount` DECIMAL(18,2) COMMENT 'The total estimated cost for this line item (quantity × estimated unit price), used for internal budget tracking.',
    `estimated_unit_price` DECIMAL(18,2) COMMENT 'The internal estimated or budgeted unit price for this item, used for cost comparison and budget control. Not shared with vendors.',
    `incoterm` STRING COMMENT 'The Incoterm defining the delivery terms and transfer of risk between buyer and seller (e.g., EXW, FOB, CIF, DDP). [ENUM-REF-CANDIDATE: EXW|FCA|CPT|CIP|DAP|DPU|DDP|FAS|FOB|CFR|CIF — 11 candidates stripped; promote to reference product]',
    `inspection_required_flag` BOOLEAN COMMENT 'Indicates whether this item requires formal inspection or testing upon delivery before acceptance (True/False).',
    `item_description` STRING COMMENT 'Detailed textual description of the material or service being requested, including specifications, grade, and any special requirements.',
    `lead_time_days` STRING COMMENT 'The expected or required procurement lead time in days from purchase order issuance to delivery.',
    `line_number` STRING COMMENT 'Sequential line number within the RFQ document for ordering and reference purposes.',
    `line_status` STRING COMMENT 'Current lifecycle status of this RFQ line item: draft (being prepared), issued (sent to vendors), quoted (responses received), evaluated (under review), awarded (vendor selected), or cancelled.. Valid values are `draft|issued|quoted|evaluated|awarded|cancelled`',
    `material_group` STRING COMMENT 'Classification or category code for the material or service type (e.g., concrete, steel, electrical, mechanical) used for grouping and reporting.',
    `modified_by` STRING COMMENT 'User ID or name of the person who last modified this RFQ line item.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this RFQ line item record was last updated.',
    `notes` STRING COMMENT 'Additional free-text notes, instructions, or clarifications for vendors regarding this line item.',
    `priority` STRING COMMENT 'The urgency or priority level of this procurement line item relative to project schedule and critical path.. Valid values are `critical|high|medium|low`',
    `procurement_category` STRING COMMENT 'High-level classification of the procurement type: direct material (project-specific), indirect material (general supplies), subcontract service, equipment rental, professional service, or consumable.. Valid values are `direct_material|indirect_material|subcontract_service|equipment_rental|professional_service|consumable`',
    `quality_requirement` STRING COMMENT 'Description of quality standards, certifications, or inspection requirements that the material or service must meet (e.g., ISO 9001, ASTM standards, factory acceptance test).',
    `quantity` DECIMAL(18,2) COMMENT 'The quantity of material or service units being requested from vendors in this RFQ line.',
    `required_delivery_date` DATE COMMENT 'The date by which the material or service must be delivered to the site or designated location to meet project schedule requirements.',
    `short_text` STRING COMMENT 'Brief summary or short description of the line item for quick reference and display purposes.',
    `source_of_supply` STRING COMMENT 'Indicates the preferred or required sourcing strategy for this item: local, regional, international, preferred vendor, or open market.. Valid values are `local|regional|international|preferred_vendor|open_market`',
    `tax_code` STRING COMMENT 'The tax classification code applicable to this line item, determining VAT, GST, or other tax treatment.',
    `unit_of_measure` STRING COMMENT 'The unit in which the quantity is measured (e.g., EA=Each, M=Meter, M2=Square Meter, M3=Cubic Meter, KG=Kilogram, TON=Metric Ton, L=Liter, HR=Hour, DAY=Day, LOT=Lot, SET=Set, CUM=Cubic Meter, SQM=Square Meter, LM=Linear Meter, MT=Metric Ton). [ENUM-REF-CANDIDATE: EA|M|M2|M3|KG|TON|L|HR|DAY|LOT|SET|CUM|SQM|LM|MT — 15 candidates stripped; promote to reference product]',
    `vendor_evaluation_criteria` STRING COMMENT 'Specific criteria or weighting factors to be used when evaluating vendor quotations for this line item (e.g., price 60%, delivery 20%, quality 20%).',
    `wbs_element` STRING COMMENT 'The WBS code or element that this procurement line item is charged to, enabling project cost tracking and control.',
    `created_by` STRING COMMENT 'User ID or name of the procurement professional who created this RFQ line item.',
    CONSTRAINT pk_rfq_line PRIMARY KEY(`rfq_line_id`)
) COMMENT 'Individual line items within an RFQ corresponding to specific materials, services, or BOQ positions. Captures line number, material or service description, quantity, unit of measure, required delivery date, site delivery location, technical specification reference, and any applicable drawing or BIM model reference. Enables granular vendor pricing comparison at the line-item level.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`procurement`.`purchase_order` (
    `purchase_order_id` BIGINT COMMENT 'Unique system identifier for the purchase order record. Primary key.',
    `construction_project_id` BIGINT COMMENT 'Reference to the construction project for which materials, equipment, or services are being procured. Links to project master data.',
    `cost_center_id` BIGINT COMMENT 'Reference to the organizational cost center responsible for this procurement expenditure. Used for financial reporting and budget tracking.',
    `crew_id` BIGINT COMMENT 'Foreign key linking to workforce.crew. Business justification: REQUIRED: Subcontractor Labor PO Allocation – labor purchase orders are assigned to a specific crew to track labor costs against crew productivity.',
    `drawing_id` BIGINT COMMENT 'Foreign key linking to design.drawing. Business justification: Purchase Order references the drawing for fabricated components, ensuring delivery matches design intent.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Required for posting purchase order accruals to the general ledger; finance GL account needed for expense recognition.',
    `project_site_id` BIGINT COMMENT 'Foreign key linking to project.project_site. Business justification: Site managers track all POs delivering to their construction site for logistics coordination, gate access, and receiving planning. Linking PO to project_site replaces six denormalized delivery address',
    `purchase_requisition_id` BIGINT COMMENT 'Foreign key linking to procurement.purchase_requisition. Business justification: Add link from purchase order to its originating purchase requisition to capture parent-child relationship.',
    `rfq_id` BIGINT COMMENT 'Foreign key linking to procurement.rfq. Business justification: A Purchase Order is typically the contractual outcome of an RFQ/tender process — the awarded vendor from the RFQ becomes the PO vendor. Linking purchase_order.rfq_id → rfq captures the full source-to-',
    `subcontract_id` BIGINT COMMENT 'Foreign key linking to contract.subcontract. Business justification: Construction POs are frequently issued to execute subcontract work packages. Linking PO to subcontract enables subcontract commitment vs. PO value reconciliation — a standard construction cost control',
    `vendor_id` BIGINT COMMENT 'Reference to the supplier or subcontractor to whom this purchase order is issued. Links to vendor master data.',
    `acknowledgment_date` DATE COMMENT 'Date on which the vendor formally acknowledged receipt and acceptance of the purchase order terms.',
    `amendment_count` STRING COMMENT 'Total number of formal amendments or change orders issued against this purchase order. Used for contract change management reporting.',
    `approval_date` DATE COMMENT 'Date on which final approval was granted for this purchase order.',
    `approval_status` STRING COMMENT 'Current approval state of the purchase order in the authorization workflow. Tracks whether PO has received required management and financial approvals.. Valid values are `pending|approved|rejected|conditional`',
    `approved_by` STRING COMMENT 'Name or identifier of the authorized person who approved this purchase order for issuance.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this purchase order record was first created in the procurement system.',
    `cumulative_amendment_value` DECIMAL(18,2) COMMENT 'Net change in purchase order value resulting from all amendments and change orders (positive or negative delta from original value).',
    `currency_code` STRING COMMENT 'Three-letter ISO currency code for all monetary values in this purchase order (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `current_revision_number` STRING COMMENT 'Revision number tracking minor corrections or clarifications within the current version. Used for document control and audit trail.',
    `current_version_number` STRING COMMENT 'Version number of the purchase order reflecting amendments and change orders. Increments with each approved modification.',
    `gmp_amount` DECIMAL(18,2) COMMENT 'The contractual ceiling amount for this purchase order when GMP terms apply. Vendor cannot exceed this amount without approved change orders.',
    `gmp_flag` BOOLEAN COMMENT 'Indicates whether this purchase order is subject to a Guaranteed Maximum Price contract, capping the total cost exposure.',
    `incoterms` STRING COMMENT 'Standard trade terms defining responsibilities for shipping, insurance, and risk transfer between buyer and seller (e.g., DDP, FOB, CIF). [ENUM-REF-CANDIDATE: EXW|FCA|CPT|CIP|DAP|DPU|DDP|FAS|FOB|CFR|CIF — 11 candidates stripped; promote to reference product]',
    `issued_date` DATE COMMENT 'Date on which the purchase order was formally issued to the vendor. Marks the start of the contractual commitment.',
    `last_amendment_date` DATE COMMENT 'Date of the most recent amendment or change order applied to this purchase order.',
    `last_amendment_type` STRING COMMENT 'Classification of the most recent amendment: scope change, quantity adjustment, price revision, delivery reschedule, formal change order, or terms modification.. Valid values are `scope_change|quantity_change|price_adjustment|delivery_date_change|change_order|terms_modification`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'System timestamp of the most recent update to this purchase order record, including amendments, status changes, or data corrections.',
    `ntp_date` DATE COMMENT 'Official date on which the vendor is authorized to commence work or delivery. Critical milestone for schedule tracking and contract start.',
    `original_po_value` DECIMAL(18,2) COMMENT 'Initial total value of the purchase order at time of first issuance, before any amendments or change orders. Used for cost variance analysis.',
    `payment_terms` DECIMAL(18,2) COMMENT 'Contractual payment terms specifying due date calculation (e.g., Net 30, Net 60, 2/10 Net 30, progress payment schedule, milestone-based).',
    `po_number` STRING COMMENT 'Externally-known unique purchase order number issued to vendor. Business identifier used in all procurement correspondence and invoicing.. Valid values are `^PO-[0-9]{8,12}$`',
    `po_status` STRING COMMENT 'Current lifecycle status of the purchase order in the procurement workflow. Tracks progression from draft through approval, issuance, receipt, and closure. [ENUM-REF-CANDIDATE: draft|pending_approval|approved|issued|acknowledged|in_progress|partially_received|fully_received|closed|cancelled — 10 candidates stripped; promote to reference product]',
    `po_type` STRING COMMENT 'Classification of purchase order by procurement pattern: standard (one-time material/equipment), blanket (recurring supply agreement), framework (multi-project master agreement), subcontract (labor/construction services), service (professional services), rental (equipment lease).. Valid values are `standard|blanket|framework|subcontract|service|rental`',
    `promised_delivery_date` DATE COMMENT 'Vendor-committed delivery date as confirmed in purchase order acknowledgment. Used for schedule risk assessment and expediting.',
    `requested_delivery_date` DATE COMMENT 'Target date by which materials, equipment, or services are required on site. Used for procurement lead time planning and CPM schedule integration.',
    `requisition_number` STRING COMMENT 'Reference to the originating purchase requisition that triggered this purchase order. Links procurement request to fulfillment.. Valid values are `^PR-[0-9]{8,12}$`',
    `retention_amount` DECIMAL(18,2) COMMENT 'Absolute monetary value withheld as retention, calculated from total PO value and retention percentage.',
    `retention_percentage` DECIMAL(18,2) COMMENT 'Percentage of payment withheld until contract completion or defects liability period expires. Common in construction subcontracts (typically 5-10%).',
    `sap_document_number` STRING COMMENT 'SAP MM system-generated unique document number for this purchase order. Used for ERP integration and cross-system reconciliation.. Valid values are `^[0-9]{10}$`',
    `tax_amount` DECIMAL(18,2) COMMENT 'Total tax amount applicable to this purchase order (VAT, GST, sales tax) as calculated per jurisdiction and tax code.',
    `total_po_value` DECIMAL(18,2) COMMENT 'Total monetary value of the purchase order including all line items, taxes, and charges. Expressed in the currency specified by currency_code.',
    `wbs_element` STRING COMMENT 'Hierarchical WBS code identifying the specific project phase, deliverable, or cost element to which this PO is charged. Used for project cost control and EVM tracking.. Valid values are `^[A-Z0-9]{2,4}-[0-9]{4,8}(.[0-9]{1,4})*$`',
    CONSTRAINT pk_purchase_order PRIMARY KEY(`purchase_order_id`)
) COMMENT 'Legally binding purchase order issued to a vendor for supply of materials, equipment, or services, including full amendment and change order history as versioned records. Captures PO number, vendor, project and WBS element, delivery address, incoterms, payment terms, currency, total PO value, GMP flag, retention percentage, PO type (standard, blanket, framework, subcontract), approval status, NTP date, SAP document number, current version/revision number, and complete amendment audit trail (amendment number, amendment type — scope change, quantity change, price adjustment, delivery date change, CO, original value, amended value, value delta, reason, approval status, amendment date). Core transactional anchor of the procurement domain sourced from SAP MM. SSOT for all PO commercial state including historical changes and amendments.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`procurement`.`po_line` (
    `po_line_id` BIGINT COMMENT 'Unique identifier for the purchase order line item. Primary key for the PO line entity.',
    `cost_code_id` BIGINT COMMENT 'Foreign key linking to finance.cost_code. Business justification: PO lines in construction are assigned to cost codes for job costing and budget tracking. Proper FK replaces denormalized cost_code text field, enabling cost code validation at order line level, commit',
    `itp_line_id` BIGINT COMMENT 'Foreign key linking to quality.itp_line. Business justification: In construction QA/QC, specific PO line items for quality-critical materials are governed by specific ITP lines (hold/witness points). This link enables material-level quality gate tracking and is req',
    `material_catalog_id` BIGINT COMMENT 'Foreign key linking to procurement.material_catalog. Business justification: Link PO line material to master catalog for normalization and remove redundant material_id column.',
    `purchase_order_id` BIGINT COMMENT 'Reference to the parent purchase order header under which this line item is grouped. Links line-level detail to the overall PO document.',
    `rfq_line_id` BIGINT COMMENT 'Foreign key linking to procurement.rfq_line. Business justification: A PO line item is the contractual commitment that originates from a specific RFQ line item — the quoted price, quantity, and material from the RFQ line become the ordered values on the PO line. This l',
    `account_assignment_category` STRING COMMENT 'SAP account assignment category indicating how costs are allocated: K=Cost Center, A=Asset, F=Order, P=Project, N=Network, U=Unknown. Determines financial posting logic.. Valid values are `K|A|F|P|N|U`',
    `buyer_name` STRING COMMENT 'Name of the procurement professional responsible for sourcing and purchasing this line item. Used for vendor communication and procurement accountability.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this purchase order line item record was first created in the system. Used for audit trail and process timing analysis.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code representing the currency in which the line item is priced and will be paid. [ENUM-REF-CANDIDATE: USD|EUR|GBP|JPY|CNY|AUD|CAD — 7 candidates stripped; promote to reference product]',
    `deletion_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether this line item has been marked for deletion. True if the line is logically deleted but retained for audit purposes.',
    `delivery_date` DATE COMMENT 'The scheduled or requested delivery date for the material or completion date for the service on this line item. Critical for project scheduling and material planning.',
    `free_text_note` STRING COMMENT 'Additional free-form notes or special instructions related to this line item, such as quality requirements, packaging instructions, or delivery constraints.',
    `gl_account_code` STRING COMMENT 'The general ledger account code to which this line item expenditure will be posted for financial reporting and compliance.',
    `goods_receipt_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether a goods receipt is required for this line item. True if GR is mandatory before invoice processing.',
    `goods_receipt_quantity` DECIMAL(18,2) COMMENT 'The cumulative quantity of goods received to date against this line item. Used to track delivery progress and outstanding quantities.',
    `incoterms` STRING COMMENT 'Standard trade terms defining the responsibilities of buyers and sellers for delivery, insurance, and risk transfer per ICC Incoterms 2020. [ENUM-REF-CANDIDATE: EXW|FCA|CPT|CIP|DAP|DPU|DDP|FAS|FOB|CFR|CIF — 11 candidates stripped; promote to reference product]',
    `incoterms_location` STRING COMMENT 'The specific named place or port associated with the Incoterms designation, defining the point of delivery or risk transfer.',
    `invoice_receipt_indicator` DECIMAL(18,2) COMMENT 'Boolean flag indicating whether invoice verification is required for this line item. True if IR is mandatory for payment processing.',
    `invoiced_quantity` DECIMAL(18,2) COMMENT 'The cumulative quantity that has been invoiced to date against this line item. Used for three-way matching and payment reconciliation.',
    `item_category` STRING COMMENT 'Classification of the line item type indicating the procurement scenario: standard purchase, service procurement, consignment, subcontracting, or stock transfer.. Valid values are `standard|service|consignment|subcontracting|stock_transfer`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this purchase order line item record was most recently updated. Used for change tracking and audit purposes.',
    `line_number` STRING COMMENT 'Sequential line item number within the purchase order, used for ordering and referencing specific line items in the PO document.',
    `line_status` STRING COMMENT 'Current lifecycle status of the purchase order line item indicating its fulfillment state: open (not yet received), partially received, fully received, closed (completed), or cancelled.. Valid values are `open|partially_received|fully_received|closed|cancelled`',
    `manufacturer_part_number` STRING COMMENT 'The original equipment manufacturer (OEM) part number for the material, used for quality assurance and warranty tracking.',
    `material_description` STRING COMMENT 'Detailed textual description of the material or service being procured on this line, including specifications, grade, and any special requirements.',
    `material_group` STRING COMMENT 'Classification code grouping similar materials together for procurement analysis, vendor management, and spend reporting.',
    `net_value` DECIMAL(18,2) COMMENT 'The total net value of this line item calculated as ordered quantity multiplied by unit price, before taxes and discounts.',
    `ordered_quantity` DECIMAL(18,2) COMMENT 'The quantity of material or service ordered on this line item, expressed in the unit of measure specified.',
    `outstanding_quantity` DECIMAL(18,2) COMMENT 'The remaining quantity yet to be delivered, calculated as ordered quantity minus goods receipt quantity. Critical for expediting and delivery monitoring.',
    `over_delivery_tolerance_percent` DECIMAL(18,2) COMMENT 'The acceptable percentage by which the vendor may over-deliver beyond the ordered quantity without requiring approval. Used for goods receipt tolerance checking.',
    `plant_code` STRING COMMENT 'The plant or site location code where the material will be delivered or the service will be performed. Used for multi-site inventory and logistics management.',
    `price_unit` DECIMAL(18,2) COMMENT 'The quantity of units to which the unit price applies (e.g., price per 1, per 10, per 100 units). Used for bulk pricing scenarios.',
    `requisitioner_name` STRING COMMENT 'Name of the person or department who requested this material or service, used for accountability and follow-up communication.',
    `short_text` STRING COMMENT 'Brief descriptive text for the line item, typically used for quick identification and reporting purposes.',
    `storage_location` STRING COMMENT 'The specific storage location or warehouse within the plant where the material will be received and stored.',
    `tax_amount` DECIMAL(18,2) COMMENT 'The calculated tax amount applicable to this line item based on the tax code and net value.',
    `tax_code` STRING COMMENT 'Tax classification code that determines the applicable tax rate and tax jurisdiction for this line item.',
    `under_delivery_tolerance_percent` DECIMAL(18,2) COMMENT 'The acceptable percentage by which the vendor may under-deliver below the ordered quantity without penalty. Used for goods receipt tolerance checking.',
    `unit_of_measure` STRING COMMENT 'The unit in which the ordered quantity is measured (e.g., each, meter, square meter, cubic meter, kilogram, ton, liter, hour, day, set, lot, box, roll, bag). [ENUM-REF-CANDIDATE: EA|M|M2|M3|KG|TON|L|HR|DAY|SET|LOT|BOX|ROLL|BAG — 14 candidates stripped; promote to reference product]',
    `unit_price` DECIMAL(18,2) COMMENT 'The price per unit of measure for the material or service on this line item, excluding taxes and additional charges.',
    `vendor_material_number` STRING COMMENT 'The suppliers own material or part number for the item being procured. Used for cross-referencing and supplier communication.',
    `wbs_element` STRING COMMENT 'The WBS element code to which this line item cost is assigned, enabling project-level cost tracking and allocation per CPM methodology.',
    CONSTRAINT pk_po_line PRIMARY KEY(`po_line_id`)
) COMMENT 'Individual line items within a purchase order capturing material or service description, ordered quantity, unit of measure, unit price, line total, delivery schedule date, WBS element, cost code, account assignment category, goods receipt indicator, invoice receipt indicator, and cumulative goods receipt quantity to date. Enables granular cost tracking and delivery monitoring at the PO line level.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`procurement`.`goods_receipt` (
    `goods_receipt_id` BIGINT COMMENT 'Primary key for goods_receipt',
    `batch_lot_id` BIGINT COMMENT 'Foreign key linking to material.batch_lot. Business justification: Goods receipt in construction triggers batch/lot assignment for material traceability. Quality inspection, shelf-life tracking, and regulatory compliance all require linking the GR document to the spe',
    `construction_project_id` BIGINT COMMENT 'Reference to the construction project for which the materials were received. Enables project-level cost tracking and material allocation.',
    `material_catalog_id` BIGINT COMMENT 'Foreign key linking to procurement.material_catalog. Business justification: Link goods receipt material to master catalog for normalization and remove redundant material_id column.',
    `po_line_id` BIGINT COMMENT 'Foreign key linking to procurement.po_line. Business justification: A goods receipt is physically received against a specific PO line item. The existing po_line_item_number (INT) is a denormalized line number reference that becomes redundant once a proper FK to po_lin',
    `purchase_order_id` BIGINT COMMENT 'Reference to the purchase order against which this goods receipt is recorded. Links the physical delivery to the procurement contract.',
    `craft_worker_id` BIGINT COMMENT 'Foreign key linking to workforce.craft_worker. Business justification: Goods receipts in construction require a named craft worker (foreman or inspector) to sign off on material delivery. This link supports quality accountability, regulatory audit trails, and three-way m',
    `crew_id` BIGINT COMMENT 'Foreign key linking to workforce.crew. Business justification: The crew physically receiving and unloading materials on a construction site is a key operational link for site logistics, material accountability, and cost allocation to the correct crew. This suppor',
    `technical_specification_id` BIGINT COMMENT 'Foreign key linking to design.technical_specification. Business justification: Goods receipt QC inspection: Receiving inspectors verify delivered materials against the governing technical specification. This link enables spec-based acceptance criteria at goods receipt, supports ',
    `vendor_id` BIGINT COMMENT 'Reference to the supplier or vendor who delivered the materials. Used for supplier performance tracking and three-way match verification.',
    `batch_number` STRING COMMENT 'Manufacturer batch or lot number for the received materials. Critical for traceability, quality control, and recall management.',
    `carrier_name` STRING COMMENT 'Name of the transportation carrier or logistics provider who delivered the materials. Used for carrier performance tracking.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the goods receipt value (e.g., USD, EUR, GBP). Used for multi-currency financial reporting.. Valid values are `^[A-Z]{3}$`',
    `delivery_completed_flag` BOOLEAN COMMENT 'Indicates whether this goods receipt completes the delivery for the purchase order line item (True=complete, False=partial delivery expected).',
    `delivery_note_number` STRING COMMENT 'External delivery note or packing slip number provided by the vendor. Used for cross-referencing vendor shipment documentation.',
    `gr_document_number` STRING COMMENT 'Unique business document number assigned to this goods receipt transaction. Used for audit trail and cross-system reconciliation.. Valid values are `^GR[0-9]{10}$`',
    `inspection_status` STRING COMMENT 'Quality inspection status for the received materials. Determines whether materials can be released to inventory or must remain in quarantine.. Valid values are `not_required|pending|in_progress|passed|failed|waived`',
    `invoice_verification_status` DECIMAL(18,2) COMMENT 'Status of three-way match process comparing PO, goods receipt, and vendor invoice. Determines whether invoice can be paid.',
    `material_document_number` STRING COMMENT 'SAP material document number generated upon goods receipt posting. Used for inventory movement tracking and financial integration.. Valid values are `^[0-9]{10}$`',
    `movement_type` STRING COMMENT 'SAP movement type code indicating the type of inventory transaction (e.g., 101=GR for PO, 122=Return Delivery). Determines financial and inventory impact.. Valid values are `^[0-9]{3}$`',
    `ordered_quantity` DECIMAL(18,2) COMMENT 'Quantity of material originally ordered on the purchase order line item. Used for variance analysis against received quantity.',
    `posting_date` DATE COMMENT 'Financial posting date for the goods receipt transaction. Used for period-end closing and financial reporting alignment.',
    `receipt_condition` STRING COMMENT 'Condition status of the received materials upon inspection (accepted=fully accepted, rejected=fully rejected, partial=partially accepted, damaged=damaged on arrival, on_hold=pending inspection, quarantine=quality hold).. Valid values are `accepted|rejected|partial|damaged|on_hold|quarantine`',
    `receipt_date` DATE COMMENT 'Date on which the materials were physically received at the site or warehouse. Used for lead time analysis and schedule compliance tracking.',
    `receipt_timestamp` TIMESTAMP COMMENT 'Precise date and time when the goods receipt was recorded in the system. Used for audit trail and real-time inventory updates.',
    `received_quantity` DECIMAL(18,2) COMMENT 'Actual quantity of material physically received and accepted. This is the quantity that updates inventory and triggers invoice verification.',
    `rejected_quantity` DECIMAL(18,2) COMMENT 'Quantity of material rejected due to quality issues, damage, or non-conformance. Triggers vendor return or credit memo process.',
    `reversal_document_number` STRING COMMENT 'Document number of the reversal transaction if this goods receipt was cancelled. Used for audit trail and reconciliation.',
    `reversal_flag` BOOLEAN COMMENT 'Indicates whether this goods receipt has been reversed or cancelled (True=reversed, False=active). Reversed receipts do not update inventory.',
    `reversal_reason` STRING COMMENT 'Reason code or description explaining why the goods receipt was reversed (e.g., incorrect posting, return to vendor, data entry error).',
    `serial_number` STRING COMMENT 'Unique serial number for serialized equipment or high-value items. Enables individual asset tracking and warranty management.',
    `special_handling_instructions` STRING COMMENT 'Any special handling requirements or instructions for the received materials (e.g., temperature control, hazardous material protocols, fragile handling).',
    `storage_location_code` STRING COMMENT 'Code identifying the specific storage location, warehouse bin, or laydown area where the materials are stored after receipt.. Valid values are `^[A-Z0-9]{4}$`',
    `tax_code` STRING COMMENT 'Tax jurisdiction code applied to the goods receipt for sales tax, VAT, or GST calculation. Determines tax treatment in financial posting.',
    `total_value` DECIMAL(18,2) COMMENT 'Total monetary value of the goods receipt (received quantity × unit price). Updates inventory value and triggers accounts payable accrual.',
    `tracking_number` STRING COMMENT 'Shipment tracking number provided by the carrier. Enables real-time delivery status monitoring and proof of delivery.',
    `transportation_mode` STRING COMMENT 'Method of transportation used to deliver the materials (truck, rail, air, sea, courier, pickup). Used for logistics analysis and lead time optimization.. Valid values are `truck|rail|air|sea|courier|pickup`',
    `unit_of_measure` STRING COMMENT 'Unit of measure for the received quantity (e.g., EA=Each, M=Meter, M2=Square Meter, M3=Cubic Meter, KG=Kilogram, TON=Ton, L=Liter). [ENUM-REF-CANDIDATE: EA|M|M2|M3|KG|TON|L|BOX|PALLET|SET — 10 candidates stripped; promote to reference product]',
    `unit_price` DECIMAL(18,2) COMMENT 'Price per unit of measure for the received material as per the purchase order. Used for inventory valuation and three-way match with invoice.',
    `unloading_point` STRING COMMENT 'Specific unloading dock, gate, or receiving area where the materials were delivered at the construction site.',
    `valuation_type` STRING COMMENT 'Material valuation category used for inventory accounting (e.g., standard cost, moving average price). Determines how the receipt is valued financially.',
    `variance_notes` STRING COMMENT 'Free-text notes explaining any discrepancies, damages, or special conditions observed during goods receipt. Used for dispute resolution and vendor performance tracking.',
    `variance_reason_code` STRING COMMENT 'Code indicating the reason for any variance between ordered and received quantities (e.g., short shipment, over delivery, damaged goods).',
    CONSTRAINT pk_goods_receipt PRIMARY KEY(`goods_receipt_id`)
) COMMENT 'Material goods receipt records capturing physical delivery of materials or equipment to site or warehouse against a PO. Records GR document number, delivery date, received quantity, unit of measure, storage location, batch number, delivery note reference, condition on receipt (accepted, rejected, partial), receiving inspector, and SAP material document number. Triggers inventory update and three-way match for invoice verification.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`procurement`.`purchase_requisition` (
    `purchase_requisition_id` BIGINT COMMENT 'Unique identifier for the purchase requisition. Primary key for the purchase requisition entity.',
    `construction_project_id` BIGINT COMMENT 'Identifier of the construction project for which this purchase requisition is raised. Links the requisition to the project master data for cost tracking and budget control.',
    `cost_account_id` BIGINT COMMENT 'Foreign key linking to project.cost_account. Business justification: Budget availability checking at PR approval requires linking requisitions to project cost accounts. Construction PMO processes validate PR cost against cost account budgets before approval. No existin',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: PRs are raised by cost centers in construction organizations. Proper FK replaces denormalized cost_center_code text field, enabling cost center budget availability checks, overhead allocation reportin',
    `cost_code_id` BIGINT COMMENT 'Foreign key linking to finance.cost_code. Business justification: Purchase requisitions in construction are coded to cost codes for budget allocation and cost tracking. Proper FK to finance.cost_code enables cost code validation at requisition stage, supports cost r',
    `drawing_id` BIGINT COMMENT 'Foreign key linking to design.drawing. Business justification: Material Take-Off (MTO) process: PRs in construction are raised against specific drawings that define what materials are needed. The existing mto_reference plain-text field denormalizes this relatio',
    `master_id` BIGINT COMMENT 'Foreign key linking to material.material_master. Business justification: Purchase requisitions are created for specific materials; linking to material master enables accurate budgeting, inventory checks, and compliance with approved material lists.',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to procurement.vendor. Business justification: purchase_requisition has a preferred_vendor_code (STRING) — a denormalized vendor reference used by requisitioners to suggest a preferred supplier. Replacing this with a proper FK preferred_vendor_id ',
    `project_budget_id` BIGINT COMMENT 'Foreign key linking to finance.project_budget. Business justification: Construction PRs require budget availability validation before approval. Linking PR to project_budget enables real-time budget commitment tracking, supports the budget_available_flag and budget_varian',
    `scope_id` BIGINT COMMENT 'Foreign key linking to contract.contract_scope. Business justification: Purchase requisitions in construction are raised against specific contract scope items (work packages). This link enables scope-level procurement budget tracking and ensures PRs are authorized within ',
    `technical_specification_id` BIGINT COMMENT 'Foreign key linking to design.technical_specification. Business justification: Spec-driven requisitioning: PRs must reference the technical specification defining material quality and type requirements. The boolean technical_specification_attached flag is a weak substitute for',
    `approval_date` DATE COMMENT 'Date when the purchase requisition received final approval and became eligible for conversion to RFQ or PO.',
    `budget_available_flag` DECIMAL(18,2) COMMENT 'Indicates whether sufficient budget is available in the assigned WBS element or cost center to cover the estimated cost of this requisition. True if budget is available, False if insufficient.',
    `budget_variance_amount` DECIMAL(18,2) COMMENT 'Difference between available budget and the estimated total cost. Positive value indicates surplus budget, negative indicates deficit requiring approval override.',
    `closed_date` DATE COMMENT 'Date when the purchase requisition was administratively closed after full conversion to procurement documents or cancellation, marking the end of its active lifecycle.',
    `conversion_date` DATE COMMENT 'Date when the purchase requisition was converted to an RFQ or PO document.',
    `conversion_status` STRING COMMENT 'Indicates whether and how the approved purchase requisition has been converted into downstream procurement documents (RFQ for competitive bidding or direct PO for known vendors).. Valid values are `not_converted|converted_to_rfq|converted_to_po|partially_converted`',
    `converted_document_number` STRING COMMENT 'Document number of the RFQ or PO that was created from this purchase requisition, establishing traceability through the procurement lifecycle.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when the purchase requisition record was first created in the ERP system. Used for audit trail and process cycle time analysis.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the estimated cost amounts (e.g., USD, EUR, GBP, AED).. Valid values are `^[A-Z]{3}$`',
    `current_approver_name` STRING COMMENT 'Name of the individual currently responsible for reviewing and approving the purchase requisition in the workflow sequence.',
    `delivery_location` STRING COMMENT 'Site address, warehouse, or specific location where the materials or equipment should be delivered. Critical for logistics planning and site coordination.',
    `estimated_total_cost` DECIMAL(18,2) COMMENT 'Total estimated cost for the requisition line, calculated as quantity multiplied by estimated unit cost. Used for budget availability verification.',
    `estimated_unit_cost` DECIMAL(18,2) COMMENT 'Estimated cost per unit of the requested material or service, used for budget checking and preliminary cost estimation.',
    `justification_notes` STRING COMMENT 'Business justification and rationale for the purchase requisition, including project need, schedule impact, and any special circumstances requiring expedited processing.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'System timestamp when the purchase requisition record was last updated, capturing any changes to status, approvals, or requisition details.',
    `material_description` STRING COMMENT 'Detailed textual description of the material, equipment, or service being requested. Includes specifications, grade, dimensions, and any special requirements.',
    `material_group` STRING COMMENT 'Classification code grouping similar materials or services for procurement strategy, vendor assignment, and reporting (e.g., concrete, steel, electrical, MEP services).',
    `pr_number` STRING COMMENT 'Business identifier for the purchase requisition, externally visible and used in procurement workflows and communications.. Valid values are `^PR-[0-9]{8}$`',
    `pr_status` STRING COMMENT 'Current lifecycle status of the purchase requisition in the approval and conversion workflow. [ENUM-REF-CANDIDATE: draft|pending_approval|approved|rejected|converted|cancelled|closed — 7 candidates stripped; promote to reference product]',
    `pr_type` STRING COMMENT 'Classification of the purchase requisition based on procurement category: standard materials, subcontract services, general services, stock transfers between sites, consignment arrangements, or equipment rental.. Valid values are `standard|subcontract|service|stock_transfer|consignment|rental`',
    `procurement_strategy` STRING COMMENT 'Sourcing approach to be used for fulfilling this requisition based on value, complexity, vendor availability, and time constraints.. Valid values are `direct_po|competitive_rfq|framework_agreement|spot_buy|emergency_procurement`',
    `quantity` DECIMAL(18,2) COMMENT 'Quantity of the material or service being requested, expressed in the unit of measure specified.',
    `rejection_date` DATE COMMENT 'Date when the purchase requisition was rejected by an approver in the workflow, if applicable.',
    `rejection_reason` STRING COMMENT 'Explanation provided by the approver for rejecting the purchase requisition, including corrective actions required for resubmission.',
    `requester_email` STRING COMMENT 'Email address of the requester for communication regarding the purchase requisition status, clarifications, and approvals.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `requester_name` STRING COMMENT 'Full name of the individual who created and submitted the purchase requisition.',
    `requesting_department` STRING COMMENT 'Name or code of the department or functional unit that originated the purchase requisition (e.g., Site Operations, Engineering, Procurement, MEP).',
    `required_delivery_date` DATE COMMENT 'Date by which the requested materials, equipment, or services must be delivered to the project site or requesting location to meet project schedule requirements.',
    `requisition_date` DATE COMMENT 'Date when the purchase requisition was created and submitted by the requesting party. Principal business event timestamp for the requisition.',
    `technical_specification_attached` BOOLEAN COMMENT 'Indicates whether detailed technical specifications, drawings, or engineering documents are attached to support the requisition evaluation and vendor quotation process.',
    `unit_of_measure` STRING COMMENT 'Standard unit in which the requested quantity is measured (e.g., EA for each, M for meter, M3 for cubic meter, KG for kilogram, HR for hour). [ENUM-REF-CANDIDATE: EA|M|M2|M3|KG|TON|L|HR|DAY|SET|LOT — 11 candidates stripped; promote to reference product]',
    `urgency_classification` STRING COMMENT 'Priority level of the purchase requisition based on project schedule impact and delivery timeline requirements. Emergency requisitions bypass standard approval workflows.. Valid values are `routine|urgent|critical|emergency`',
    `wbs_element` STRING COMMENT 'Specific WBS element within the project structure to which this requisition is charged. Enables granular cost control and tracking at the work package level.. Valid values are `^[A-Z0-9]{2}-[0-9]{4}-[0-9]{2}-[0-9]{3}$`',
    CONSTRAINT pk_purchase_requisition PRIMARY KEY(`purchase_requisition_id`)
) COMMENT 'Internal purchase requisition raised by project or site teams to initiate procurement of materials, equipment, or services. Captures requisition number, requesting department, project and WBS element, material or service description, required quantity, unit of measure, required delivery date, estimated cost, budget availability flag, approval workflow status (pending, approved, rejected), approver, urgency classification, and conversion status (converted to RFQ or PO). Sourced from SAP MM PR process. Entry point for all formal procurement activity.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`procurement`.`vendor_invoice` (
    `vendor_invoice_id` BIGINT COMMENT 'Unique identifier for the vendor invoice record. Primary key.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to contract.agreement. Business justification: Ensures invoice verification against contract terms, supporting audit of payments versus agreed contract values.',
    `asset_id` BIGINT COMMENT 'Foreign key linking to equipment.asset. Business justification: Invoices for equipment purchases/rentals must link to the asset to close the financial‑asset loop for accounting and warranty tracking.',
    `construction_project_id` BIGINT COMMENT 'Reference to the construction project to which this invoice is allocated. Used for project cost tracking and job costing.',
    `cost_center_id` BIGINT COMMENT 'Reference to the cost center to which this invoice is charged for financial accounting and cost control purposes.',
    `cost_code_id` BIGINT COMMENT 'Foreign key linking to finance.cost_code. Business justification: Vendor invoices need a cost‑code reference to map spend to project cost structures and support earned‑value analysis.',
    `gl_account_id` BIGINT COMMENT 'Reference to the general ledger account to which this invoice is posted in the financial accounting system.',
    `goods_receipt_id` BIGINT COMMENT 'Foreign key linking to procurement.goods_receipt. Business justification: Vendor invoices in construction procurement are validated via 3-way match: Purchase Order → Goods Receipt → Invoice. The existing goods_receipt_number (STRING) on vendor_invoice is a denormalized docu',
    `invoice_id` BIGINT COMMENT 'Foreign key linking to finance.invoice. Business justification: Vendor invoices (procurement) are matched to AP invoice records (finance) in the three-way match process. Linking enables AP reconciliation, duplicate invoice detection, and payment processing workflo',
    `journal_entry_id` BIGINT COMMENT 'Foreign key linking to finance.journal_entry. Business justification: Vendor invoice posting generates an AP journal entry (liability posting). Proper FK replaces denormalized fi_document_number text field, enabling AP posting audit trail, period-end accrual reporting, ',
    `payment_certificate_id` BIGINT COMMENT 'Foreign key linking to contract.payment_certificate. Business justification: Construction payment certification drives vendor invoice approval. Linking vendor_invoice to payment_certificate enables the three-way match (PO → payment certificate → invoice) mandated by constructi',
    `purchase_order_id` BIGINT COMMENT 'Reference to the purchase order against which this invoice was received. Used for three-way match validation (PO-GR-Invoice).',
    `rental_agreement_id` BIGINT COMMENT 'Foreign key linking to equipment.rental_agreement. Business justification: Rental invoices from equipment vendors must be matched against the rental agreement for rate validation and payment approval. Rental invoice three-way match (rental_agreement + equipment hours logge',
    `subcontract_id` BIGINT COMMENT 'Foreign key linking to contract.subcontract. Business justification: Vendor invoices for subcontract work must be reconciled at subcontract level, not just head-contract level. vendor_invoice already has agreement_id (head contract) but subcontract-level invoice tracki',
    `vendor_id` BIGINT COMMENT 'Reference to the vendor who issued this invoice. Links to vendor master data.',
    `approval_date` DATE COMMENT 'The date on which the invoice was approved for payment by the authorized approver.',
    `blocked_reason` STRING COMMENT 'Reason why the invoice is blocked from payment, such as pending approval, missing documentation, price variance, or quality hold.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this invoice record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code indicating the currency in which the invoice is denominated.. Valid values are `^[A-Z]{3}$`',
    `discount_amount` DECIMAL(18,2) COMMENT 'Total discount amount applied to the invoice, including early payment discounts, volume discounts, or negotiated rebates.',
    `dispute_flag` BOOLEAN COMMENT 'Boolean indicator of whether this invoice is currently under dispute due to discrepancies in quantity, quality, pricing, or terms.',
    `dispute_reason` STRING COMMENT 'Detailed explanation of the reason for the invoice dispute, such as quantity mismatch, pricing error, quality issues, or missing documentation.',
    `fiscal_period` STRING COMMENT 'The fiscal period (month) within the fiscal year in which this invoice is recorded.',
    `fiscal_year` STRING COMMENT 'The fiscal year in which this invoice is recorded for financial reporting purposes.',
    `invoice_date` DECIMAL(18,2) COMMENT 'The date the vendor issued the invoice. This is the principal business event timestamp for the invoice transaction.',
    `invoice_description` DECIMAL(18,2) COMMENT 'Textual description of the goods or services covered by this invoice, providing context for the transaction.',
    `invoice_gross_amount` DECIMAL(18,2) COMMENT 'Total invoice amount before taxes and adjustments. Represents the base value of goods or services invoiced.',
    `invoice_net_amount` DECIMAL(18,2) COMMENT 'Total invoice amount payable after applying taxes, discounts, and adjustments. This is the final amount due to the vendor.',
    `invoice_received_date` DECIMAL(18,2) COMMENT 'The date the invoice was received by the procurement or accounts payable department.',
    `invoice_status` DECIMAL(18,2) COMMENT 'Current lifecycle status of the vendor invoice in the verification and payment workflow. [ENUM-REF-CANDIDATE: draft|received|under_review|blocked|approved|posted|paid|disputed|cancelled — 9 candidates stripped; promote to reference product]',
    `invoice_type` DECIMAL(18,2) COMMENT 'Classification of the invoice document type indicating the nature of the transaction (standard invoice, credit memo for returns, debit memo for additional charges, etc.). [ENUM-REF-CANDIDATE: standard|credit_memo|debit_memo|prepayment|final|progress|retention_release — 7 candidates stripped; promote to reference product]',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this invoice record was last modified or updated.',
    `notes` STRING COMMENT 'Additional free-text notes or comments related to this invoice, such as special instructions, clarifications, or internal remarks.',
    `payment_date` DECIMAL(18,2) COMMENT 'The actual date on which payment was made to the vendor for this invoice.',
    `payment_due_date` DECIMAL(18,2) COMMENT 'The date by which payment must be made to the vendor to comply with payment terms and avoid late payment penalties.',
    `payment_method` DECIMAL(18,2) COMMENT 'The method by which payment will be made to the vendor for this invoice.',
    `payment_reference_number` DECIMAL(18,2) COMMENT 'Reference number of the payment transaction when the invoice is paid, linking the invoice to the payment record.',
    `payment_terms` DECIMAL(18,2) COMMENT 'The agreed payment terms for this invoice, such as Net 30, Net 60, or 2/10 Net 30, defining the payment schedule and any early payment discount conditions.',
    `retention_amount` DECIMAL(18,2) COMMENT 'Amount withheld from the invoice payment as retention per contract terms, typically released upon project completion or after the Defects Liability Period (DLP).',
    `retention_percentage` DECIMAL(18,2) COMMENT 'Percentage of the invoice amount withheld as retention, typically ranging from 5% to 10% per construction contract terms.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Total tax amount applied to the invoice, including sales tax, VAT, GST, or other applicable taxes.',
    `tax_code` STRING COMMENT 'The tax code applied to this invoice, defining the tax rate and tax type (VAT, GST, sales tax) per jurisdiction.',
    `three_way_match_status` STRING COMMENT 'Result of the three-way match validation comparing purchase order, goods receipt (GR), and invoice. Indicates whether quantities, prices, and terms align across all three documents.. Valid values are `matched|quantity_variance|price_variance|not_matched|bypassed`',
    `verification_status` STRING COMMENT 'Status of the invoice verification process indicating whether the invoice has been validated against the purchase order and goods receipt.. Valid values are `pending|verified|rejected|on_hold`',
    `withholding_tax_amount` DECIMAL(18,2) COMMENT 'Amount of withholding tax deducted from the invoice payment per tax regulations, to be remitted to tax authorities.',
    CONSTRAINT pk_vendor_invoice PRIMARY KEY(`vendor_invoice_id`)
) COMMENT 'Vendor invoices received against purchase orders capturing invoice number, vendor, PO reference, invoice date, invoice amount, tax amount, currency, payment due date, three-way match status (PO-GR-Invoice), invoice verification status (blocked, approved, posted), SAP FI document number, and dispute flag. Distinct from client billing invoices owned by the finance domain — this is the SSOT for vendor payable documents in procurement.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`procurement`.`sourcing_info_record` (
    `sourcing_info_record_id` BIGINT COMMENT 'Primary key for the sourcing_info_record association',
    `material_catalog_id` BIGINT COMMENT 'Foreign key linking to the material catalog entry for which these vendor-specific sourcing terms apply.',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to the vendor master record that is approved to supply the material under these sourcing terms.',
    `effective_date` DATE COMMENT 'Date from which this vendor-material sourcing record is valid and the vendor is eligible to supply this material at the stated terms. Used for time-bounded source determination during PO creation.',
    `expiry_date` DATE COMMENT 'Date after which this vendor-material sourcing record is no longer valid. Expired records are retained for historical pricing and audit purposes but excluded from active source determination.',
    `lead_time_days` BIGINT COMMENT 'Vendor-specific number of calendar days from PO issuance to material delivery for this vendor-material combination. Overrides the standard procurement_lead_time_days on material_catalog when this sourcing record is active. Cannot reside on material_catalog (varies by vendor) or vendor (varies by material).',
    `minimum_order_quantity` DECIMAL(18,2) COMMENT 'Vendor-specific minimum quantity that must be ordered for this material in the materials base unit of measure. Overrides the standard minimum_order_quantity on material_catalog when this sourcing record is active. Varies per vendor-material combination.',
    `preferred_flag` BOOLEAN COMMENT 'Indicates whether this vendor is the preferred (primary) source for this material. When true, the procurement system defaults to this vendor during automatic source determination. Only one sourcing record per material should carry preferred_flag = true at any given time.',
    `price_currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the negotiated unit_price. Defaults to the vendors currency_code but may differ for international sourcing agreements.',
    `price_unit_quantity` DECIMAL(18,2) COMMENT 'The quantity basis for the unit_price (e.g., price per 100 units, price per 1 tonne). Required to correctly compute PO line item costs when the pricing unit differs from the order unit of measure.',
    `sourcing_info_record_status` STRING COMMENT 'Lifecycle status of this vendor-material sourcing record. ACTIVE = currently valid for PO creation; EXPIRED = past expiry_date; SUSPENDED = temporarily blocked (e.g., vendor compliance issue); PENDING_APPROVAL = awaiting procurement approval before activation.',
    `unit_price` DECIMAL(18,2) COMMENT 'Vendor-negotiated unit price for this material in the vendors transaction currency. Varies per vendor-material combination and cannot reside on either vendor or material_catalog alone. Used as the default price during PO creation in SAP MM.',
    CONSTRAINT pk_sourcing_info_record PRIMARY KEY(`sourcing_info_record_id`)
) COMMENT 'This association product represents the Contract/Agreement between vendor and material_catalog in the procurement domain. It captures the approved sourcing terms under which a specific vendor may supply a specific material, including negotiated price, vendor-specific lead time, minimum order quantity, preferred source flag, and validity period. Each record links one vendor to one material_catalog entry and carries attributes that exist only in the context of this vendor-material sourcing relationship. Equivalent to the SAP MM Purchasing Info Record (PIR) and serves as the authoritative source for vendor-material pricing and sourcing eligibility used during PO creation and MTO processes.. Existence Justification: In construction procurement, a vendor can supply multiple materials from the catalog, and a single material can be sourced from multiple vendors — each at different unit prices, lead times, minimum order quantities, and validity periods. This is the SAP MM Purchasing Info Record concept, a well-established operational business entity that procurement teams actively create, maintain, and expire as sourcing conditions change. The relationship is not derivable from transactional data; it is a standing master data record that governs which vendor-material combinations are approved for purchasing and under what commercial terms.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_qualification` ADD CONSTRAINT `fk_procurement_vendor_qualification_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_construction_v1`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_construction_v1`.`procurement`.`rfq` ADD CONSTRAINT `fk_procurement_rfq_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_construction_v1`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_construction_v1`.`procurement`.`rfq` ADD CONSTRAINT `fk_procurement_rfq_purchase_requisition_id` FOREIGN KEY (`purchase_requisition_id`) REFERENCES `vibe_construction_v1`.`procurement`.`purchase_requisition`(`purchase_requisition_id`);
ALTER TABLE `vibe_construction_v1`.`procurement`.`rfq_line` ADD CONSTRAINT `fk_procurement_rfq_line_material_catalog_id` FOREIGN KEY (`material_catalog_id`) REFERENCES `vibe_construction_v1`.`procurement`.`material_catalog`(`material_catalog_id`);
ALTER TABLE `vibe_construction_v1`.`procurement`.`rfq_line` ADD CONSTRAINT `fk_procurement_rfq_line_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_construction_v1`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_construction_v1`.`procurement`.`rfq_line` ADD CONSTRAINT `fk_procurement_rfq_line_rfq_id` FOREIGN KEY (`rfq_id`) REFERENCES `vibe_construction_v1`.`procurement`.`rfq`(`rfq_id`);
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_purchase_requisition_id` FOREIGN KEY (`purchase_requisition_id`) REFERENCES `vibe_construction_v1`.`procurement`.`purchase_requisition`(`purchase_requisition_id`);
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_rfq_id` FOREIGN KEY (`rfq_id`) REFERENCES `vibe_construction_v1`.`procurement`.`rfq`(`rfq_id`);
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_construction_v1`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_construction_v1`.`procurement`.`po_line` ADD CONSTRAINT `fk_procurement_po_line_material_catalog_id` FOREIGN KEY (`material_catalog_id`) REFERENCES `vibe_construction_v1`.`procurement`.`material_catalog`(`material_catalog_id`);
ALTER TABLE `vibe_construction_v1`.`procurement`.`po_line` ADD CONSTRAINT `fk_procurement_po_line_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `vibe_construction_v1`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `vibe_construction_v1`.`procurement`.`po_line` ADD CONSTRAINT `fk_procurement_po_line_rfq_line_id` FOREIGN KEY (`rfq_line_id`) REFERENCES `vibe_construction_v1`.`procurement`.`rfq_line`(`rfq_line_id`);
ALTER TABLE `vibe_construction_v1`.`procurement`.`goods_receipt` ADD CONSTRAINT `fk_procurement_goods_receipt_material_catalog_id` FOREIGN KEY (`material_catalog_id`) REFERENCES `vibe_construction_v1`.`procurement`.`material_catalog`(`material_catalog_id`);
ALTER TABLE `vibe_construction_v1`.`procurement`.`goods_receipt` ADD CONSTRAINT `fk_procurement_goods_receipt_po_line_id` FOREIGN KEY (`po_line_id`) REFERENCES `vibe_construction_v1`.`procurement`.`po_line`(`po_line_id`);
ALTER TABLE `vibe_construction_v1`.`procurement`.`goods_receipt` ADD CONSTRAINT `fk_procurement_goods_receipt_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `vibe_construction_v1`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `vibe_construction_v1`.`procurement`.`goods_receipt` ADD CONSTRAINT `fk_procurement_goods_receipt_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_construction_v1`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_requisition` ADD CONSTRAINT `fk_procurement_purchase_requisition_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_construction_v1`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_invoice` ADD CONSTRAINT `fk_procurement_vendor_invoice_goods_receipt_id` FOREIGN KEY (`goods_receipt_id`) REFERENCES `vibe_construction_v1`.`procurement`.`goods_receipt`(`goods_receipt_id`);
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_invoice` ADD CONSTRAINT `fk_procurement_vendor_invoice_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `vibe_construction_v1`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_invoice` ADD CONSTRAINT `fk_procurement_vendor_invoice_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_construction_v1`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_construction_v1`.`procurement`.`sourcing_info_record` ADD CONSTRAINT `fk_procurement_sourcing_info_record_material_catalog_id` FOREIGN KEY (`material_catalog_id`) REFERENCES `vibe_construction_v1`.`procurement`.`material_catalog`(`material_catalog_id`);
ALTER TABLE `vibe_construction_v1`.`procurement`.`sourcing_info_record` ADD CONSTRAINT `fk_procurement_sourcing_info_record_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_construction_v1`.`procurement`.`vendor`(`vendor_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_construction_v1`.`procurement` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `vibe_construction_v1`.`procurement` SET TAGS ('dbx_domain' = 'procurement');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor` SET TAGS ('dbx_subdomain' = 'vendor_management');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor` ALTER COLUMN `account_number` SET TAGS ('dbx_business_glossary_term' = 'Vendor Account Number');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor` ALTER COLUMN `account_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,10}$');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor` ALTER COLUMN `account_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor` ALTER COLUMN `account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor` ALTER COLUMN `address_line_1` SET TAGS ('dbx_business_glossary_term' = 'Vendor Address Line 1');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor` ALTER COLUMN `address_line_1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor` ALTER COLUMN `address_line_1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor` ALTER COLUMN `address_line_2` SET TAGS ('dbx_business_glossary_term' = 'Vendor Address Line 2');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor` ALTER COLUMN `address_line_2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor` ALTER COLUMN `address_line_2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor` ALTER COLUMN `annual_revenue_amount` SET TAGS ('dbx_business_glossary_term' = 'Annual Revenue Amount');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor` ALTER COLUMN `annual_revenue_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Vendor Approval Date');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor` ALTER COLUMN `audit_result` SET TAGS ('dbx_business_glossary_term' = 'Audit Result');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor` ALTER COLUMN `audit_result` SET TAGS ('dbx_value_regex' = 'passed|passed_with_conditions|failed|not_audited');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor` ALTER COLUMN `bank_account_number` SET TAGS ('dbx_business_glossary_term' = 'Vendor Bank Account Number');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor` ALTER COLUMN `bank_account_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor` ALTER COLUMN `bank_account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor` ALTER COLUMN `bank_name` SET TAGS ('dbx_business_glossary_term' = 'Vendor Bank Name');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor` ALTER COLUMN `bank_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor` ALTER COLUMN `bank_name` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor` ALTER COLUMN `bank_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor` ALTER COLUMN `bank_routing_number` SET TAGS ('dbx_business_glossary_term' = 'Bank Routing Number');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor` ALTER COLUMN `bank_routing_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor` ALTER COLUMN `bank_routing_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor` ALTER COLUMN `bonding_capacity_amount` SET TAGS ('dbx_business_glossary_term' = 'Bonding Capacity Amount');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'Vendor City');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor` ALTER COLUMN `classification` SET TAGS ('dbx_business_glossary_term' = 'Vendor Classification');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor` ALTER COLUMN `classification` SET TAGS ('dbx_value_regex' = 'material_supplier|equipment_rental|specialist_subcontractor|general_contractor|professional_services|utility_provider');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Vendor Country Code');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor` ALTER COLUMN `credit_rating` SET TAGS ('dbx_business_glossary_term' = 'Vendor Credit Rating');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Vendor Currency Code');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor` ALTER COLUMN `diversity_classification` SET TAGS ('dbx_business_glossary_term' = 'Diversity Classification');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor` ALTER COLUMN `diversity_classification` SET TAGS ('dbx_value_regex' = 'mbe|wbe|dbe|sdvosb|hubzone|none');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor` ALTER COLUMN `duns_number` SET TAGS ('dbx_business_glossary_term' = 'Data Universal Numbering System (DUNS) Number');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor` ALTER COLUMN `duns_number` SET TAGS ('dbx_value_regex' = '^[0-9]{9}$');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor` ALTER COLUMN `employee_count` SET TAGS ('dbx_business_glossary_term' = 'Employee Count');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor` ALTER COLUMN `geographic_coverage` SET TAGS ('dbx_business_glossary_term' = 'Geographic Coverage');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor` ALTER COLUMN `insurance_certificate_number` SET TAGS ('dbx_business_glossary_term' = 'Insurance Certificate Number');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor` ALTER COLUMN `insurance_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Insurance Expiry Date');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor` ALTER COLUMN `last_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Last Audit Date');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor` ALTER COLUMN `vendor_name` SET TAGS ('dbx_business_glossary_term' = 'Vendor Legal Name');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor` ALTER COLUMN `vendor_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor` ALTER COLUMN `payment_terms_code` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms Code');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Vendor Postal Code');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor` ALTER COLUMN `preferred_vendor_flag` SET TAGS ('dbx_business_glossary_term' = 'Preferred Vendor Flag');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor` ALTER COLUMN `prequalification_score` SET TAGS ('dbx_business_glossary_term' = 'Prequalification Score');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Email Address');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Name');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Phone Number');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor` ALTER COLUMN `quality_certification` SET TAGS ('dbx_business_glossary_term' = 'Quality Certification');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor` ALTER COLUMN `registration_date` SET TAGS ('dbx_business_glossary_term' = 'Vendor Registration Date');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'Vendor State or Province');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor` ALTER COLUMN `state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor` ALTER COLUMN `state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor` ALTER COLUMN `suspension_end_date` SET TAGS ('dbx_business_glossary_term' = 'Suspension End Date');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor` ALTER COLUMN `suspension_reason` SET TAGS ('dbx_business_glossary_term' = 'Suspension Reason');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor` ALTER COLUMN `suspension_start_date` SET TAGS ('dbx_business_glossary_term' = 'Suspension Start Date');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_business_glossary_term' = 'Tax Identification Number (TIN)');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor` ALTER COLUMN `vendor_status` SET TAGS ('dbx_business_glossary_term' = 'Vendor Registration Status');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor` ALTER COLUMN `vendor_status` SET TAGS ('dbx_value_regex' = 'approved|prospective|suspended|blocked|inactive|under_review');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_qualification` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_qualification` SET TAGS ('dbx_subdomain' = 'vendor_management');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_qualification` ALTER COLUMN `vendor_qualification_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Qualification ID');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_qualification` ALTER COLUMN `asset_category_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Category Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_qualification` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_qualification` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Qualification Approval Date');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_qualification` ALTER COLUMN `approved_material_categories` SET TAGS ('dbx_business_glossary_term' = 'Approved Material Categories');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_qualification` ALTER COLUMN `approved_service_types` SET TAGS ('dbx_business_glossary_term' = 'Approved Service Types');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_qualification` ALTER COLUMN `bonding_capacity_currency` SET TAGS ('dbx_business_glossary_term' = 'Bonding Capacity Currency');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_qualification` ALTER COLUMN `bonding_capacity_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_qualification` ALTER COLUMN `bonding_capacity_limit` SET TAGS ('dbx_business_glossary_term' = 'Bonding Capacity Limit');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_qualification` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_qualification` ALTER COLUMN `financial_health_score` SET TAGS ('dbx_business_glossary_term' = 'Financial Health Score');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_qualification` ALTER COLUMN `financial_health_score` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_qualification` ALTER COLUMN `financial_health_score` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_qualification` ALTER COLUMN `geographic_coverage` SET TAGS ('dbx_business_glossary_term' = 'Geographic Coverage');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_qualification` ALTER COLUMN `hse_performance_rating` SET TAGS ('dbx_business_glossary_term' = 'Health Safety and Environment (HSE) Performance Rating');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_qualification` ALTER COLUMN `hse_performance_rating` SET TAGS ('dbx_value_regex' = 'excellent|good|satisfactory|needs_improvement|unacceptable');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_qualification` ALTER COLUMN `insurance_certificate_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Insurance Certificate Expiry Date');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_qualification` ALTER COLUMN `insurance_general_liability_limit` SET TAGS ('dbx_business_glossary_term' = 'General Liability Insurance Limit');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_qualification` ALTER COLUMN `insurance_workers_comp_verified` SET TAGS ('dbx_business_glossary_term' = 'Workers Compensation Insurance Verified');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_qualification` ALTER COLUMN `iso_14001_certificate_number` SET TAGS ('dbx_business_glossary_term' = 'ISO 14001 Certificate Number');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_qualification` ALTER COLUMN `iso_14001_certified` SET TAGS ('dbx_business_glossary_term' = 'ISO 14001 Environmental Management Certified');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_qualification` ALTER COLUMN `iso_14001_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'ISO 14001 Certificate Expiry Date');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_qualification` ALTER COLUMN `iso_45001_certificate_number` SET TAGS ('dbx_business_glossary_term' = 'ISO 45001 Certificate Number');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_qualification` ALTER COLUMN `iso_45001_certified` SET TAGS ('dbx_business_glossary_term' = 'ISO 45001 Occupational Health and Safety Certified');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_qualification` ALTER COLUMN `iso_45001_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'ISO 45001 Certificate Expiry Date');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_qualification` ALTER COLUMN `iso_9001_certificate_number` SET TAGS ('dbx_business_glossary_term' = 'ISO 9001 Certificate Number');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_qualification` ALTER COLUMN `iso_9001_certified` SET TAGS ('dbx_business_glossary_term' = 'ISO 9001 Quality Management Certified');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_qualification` ALTER COLUMN `iso_9001_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'ISO 9001 Certificate Expiry Date');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_qualification` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_qualification` ALTER COLUMN `lti_frequency_rate` SET TAGS ('dbx_business_glossary_term' = 'Lost Time Injury (LTI) Frequency Rate');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_qualification` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Qualification Notes');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_qualification` ALTER COLUMN `on_time_delivery_rate` SET TAGS ('dbx_business_glossary_term' = 'On-Time Delivery Rate Percentage');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_qualification` ALTER COLUMN `past_performance_score` SET TAGS ('dbx_business_glossary_term' = 'Past Performance Score');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_qualification` ALTER COLUMN `qualification_assessment_date` SET TAGS ('dbx_business_glossary_term' = 'Qualification Assessment Date');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_qualification` ALTER COLUMN `qualification_category` SET TAGS ('dbx_business_glossary_term' = 'Qualification Category');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_qualification` ALTER COLUMN `qualification_category` SET TAGS ('dbx_value_regex' = 'materials|equipment|services|subcontractor|mep|specialty');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_qualification` ALTER COLUMN `qualification_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Qualification Expiry Date');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_qualification` ALTER COLUMN `qualification_number` SET TAGS ('dbx_business_glossary_term' = 'Vendor Qualification Number');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_qualification` ALTER COLUMN `qualification_number` SET TAGS ('dbx_value_regex' = '^VQ-[0-9]{8}$');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_qualification` ALTER COLUMN `qualification_start_date` SET TAGS ('dbx_business_glossary_term' = 'Qualification Start Date');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_qualification` ALTER COLUMN `qualification_status` SET TAGS ('dbx_business_glossary_term' = 'Qualification Status');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_qualification` ALTER COLUMN `qualification_status` SET TAGS ('dbx_value_regex' = 'draft|under_review|approved|rejected|suspended|expired');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_qualification` ALTER COLUMN `qualification_type` SET TAGS ('dbx_business_glossary_term' = 'Qualification Type');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_qualification` ALTER COLUMN `qualification_type` SET TAGS ('dbx_value_regex' = 'initial|renewal|re_qualification|conditional|emergency');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_qualification` ALTER COLUMN `quality_defect_rate` SET TAGS ('dbx_business_glossary_term' = 'Quality Defect Rate Percentage');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_qualification` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Qualification Rejection Reason');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_qualification` ALTER COLUMN `suspension_date` SET TAGS ('dbx_business_glossary_term' = 'Qualification Suspension Date');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_qualification` ALTER COLUMN `suspension_reason` SET TAGS ('dbx_business_glossary_term' = 'Qualification Suspension Reason');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_qualification` ALTER COLUMN `technical_capability_score` SET TAGS ('dbx_business_glossary_term' = 'Technical Capability Score');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_qualification` ALTER COLUMN `trir_rate` SET TAGS ('dbx_business_glossary_term' = 'Total Recordable Incident Rate (TRIR)');
ALTER TABLE `vibe_construction_v1`.`procurement`.`material_catalog` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_construction_v1`.`procurement`.`material_catalog` SET TAGS ('dbx_subdomain' = 'material_sourcing');
ALTER TABLE `vibe_construction_v1`.`procurement`.`material_catalog` ALTER COLUMN `material_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Material Catalog Identifier');
ALTER TABLE `vibe_construction_v1`.`procurement`.`material_catalog` ALTER COLUMN `master_id` SET TAGS ('dbx_business_glossary_term' = 'Procurement Material Master ID');
ALTER TABLE `vibe_construction_v1`.`procurement`.`material_catalog` ALTER COLUMN `technical_specification_id` SET TAGS ('dbx_business_glossary_term' = 'Technical Specification Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`procurement`.`material_catalog` ALTER COLUMN `abc_classification` SET TAGS ('dbx_business_glossary_term' = 'ABC Classification');
ALTER TABLE `vibe_construction_v1`.`procurement`.`material_catalog` ALTER COLUMN `abc_classification` SET TAGS ('dbx_value_regex' = 'A|B|C');
ALTER TABLE `vibe_construction_v1`.`procurement`.`material_catalog` ALTER COLUMN `alternative_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Alternative Unit of Measure (UOM)');
ALTER TABLE `vibe_construction_v1`.`procurement`.`material_catalog` ALTER COLUMN `base_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Base Unit of Measure (UOM)');
ALTER TABLE `vibe_construction_v1`.`procurement`.`material_catalog` ALTER COLUMN `bim_object_reference` SET TAGS ('dbx_business_glossary_term' = 'BIM (Building Information Modeling) Object Reference');
ALTER TABLE `vibe_construction_v1`.`procurement`.`material_catalog` ALTER COLUMN `cost_currency` SET TAGS ('dbx_business_glossary_term' = 'Cost Currency');
ALTER TABLE `vibe_construction_v1`.`procurement`.`material_catalog` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_business_glossary_term' = 'Country of Origin');
ALTER TABLE `vibe_construction_v1`.`procurement`.`material_catalog` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_construction_v1`.`procurement`.`material_catalog` ALTER COLUMN `created_date` SET TAGS ('dbx_business_glossary_term' = 'Created Date');
ALTER TABLE `vibe_construction_v1`.`procurement`.`material_catalog` ALTER COLUMN `customs_tariff_number` SET TAGS ('dbx_business_glossary_term' = 'Customs Tariff Number (HS Code)');
ALTER TABLE `vibe_construction_v1`.`procurement`.`material_catalog` ALTER COLUMN `customs_tariff_number` SET TAGS ('dbx_value_regex' = '^[0-9]{6,10}$');
ALTER TABLE `vibe_construction_v1`.`procurement`.`material_catalog` ALTER COLUMN `dimension_unit` SET TAGS ('dbx_business_glossary_term' = 'Dimension Unit');
ALTER TABLE `vibe_construction_v1`.`procurement`.`material_catalog` ALTER COLUMN `dimension_unit` SET TAGS ('dbx_value_regex' = 'M|CM|MM|FT|IN');
ALTER TABLE `vibe_construction_v1`.`procurement`.`material_catalog` ALTER COLUMN `environmental_certification` SET TAGS ('dbx_business_glossary_term' = 'Environmental Certification');
ALTER TABLE `vibe_construction_v1`.`procurement`.`material_catalog` ALTER COLUMN `gross_weight` SET TAGS ('dbx_business_glossary_term' = 'Gross Weight');
ALTER TABLE `vibe_construction_v1`.`procurement`.`material_catalog` ALTER COLUMN `hazard_class` SET TAGS ('dbx_business_glossary_term' = 'Hazard Class');
ALTER TABLE `vibe_construction_v1`.`procurement`.`material_catalog` ALTER COLUMN `hazardous_material_indicator` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Material Indicator');
ALTER TABLE `vibe_construction_v1`.`procurement`.`material_catalog` ALTER COLUMN `height` SET TAGS ('dbx_business_glossary_term' = 'Height Dimension');
ALTER TABLE `vibe_construction_v1`.`procurement`.`material_catalog` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `vibe_construction_v1`.`procurement`.`material_catalog` ALTER COLUMN `last_modified_date` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Date');
ALTER TABLE `vibe_construction_v1`.`procurement`.`material_catalog` ALTER COLUMN `length` SET TAGS ('dbx_business_glossary_term' = 'Length Dimension');
ALTER TABLE `vibe_construction_v1`.`procurement`.`material_catalog` ALTER COLUMN `manufacturer_name` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Name');
ALTER TABLE `vibe_construction_v1`.`procurement`.`material_catalog` ALTER COLUMN `manufacturer_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_construction_v1`.`procurement`.`material_catalog` ALTER COLUMN `manufacturer_part_number` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Part Number (MPN)');
ALTER TABLE `vibe_construction_v1`.`procurement`.`material_catalog` ALTER COLUMN `material_description` SET TAGS ('dbx_business_glossary_term' = 'Material Description');
ALTER TABLE `vibe_construction_v1`.`procurement`.`material_catalog` ALTER COLUMN `material_group` SET TAGS ('dbx_business_glossary_term' = 'Material Group');
ALTER TABLE `vibe_construction_v1`.`procurement`.`material_catalog` ALTER COLUMN `material_group` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `vibe_construction_v1`.`procurement`.`material_catalog` ALTER COLUMN `material_number` SET TAGS ('dbx_business_glossary_term' = 'Material Number');
ALTER TABLE `vibe_construction_v1`.`procurement`.`material_catalog` ALTER COLUMN `material_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,18}$');
ALTER TABLE `vibe_construction_v1`.`procurement`.`material_catalog` ALTER COLUMN `material_status` SET TAGS ('dbx_business_glossary_term' = 'Material Status');
ALTER TABLE `vibe_construction_v1`.`procurement`.`material_catalog` ALTER COLUMN `material_status` SET TAGS ('dbx_value_regex' = 'active|inactive|blocked|obsolete|pending_approval|restricted');
ALTER TABLE `vibe_construction_v1`.`procurement`.`material_catalog` ALTER COLUMN `material_type` SET TAGS ('dbx_business_glossary_term' = 'Material Type');
ALTER TABLE `vibe_construction_v1`.`procurement`.`material_catalog` ALTER COLUMN `minimum_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity (MOQ)');
ALTER TABLE `vibe_construction_v1`.`procurement`.`material_catalog` ALTER COLUMN `net_weight` SET TAGS ('dbx_business_glossary_term' = 'Net Weight');
ALTER TABLE `vibe_construction_v1`.`procurement`.`material_catalog` ALTER COLUMN `procurement_lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Procurement Lead Time (Days)');
ALTER TABLE `vibe_construction_v1`.`procurement`.`material_catalog` ALTER COLUMN `quality_inspection_required` SET TAGS ('dbx_business_glossary_term' = 'Quality Inspection Required');
ALTER TABLE `vibe_construction_v1`.`procurement`.`material_catalog` ALTER COLUMN `shelf_life_days` SET TAGS ('dbx_business_glossary_term' = 'Shelf Life (Days)');
ALTER TABLE `vibe_construction_v1`.`procurement`.`material_catalog` ALTER COLUMN `short_description` SET TAGS ('dbx_business_glossary_term' = 'Short Description');
ALTER TABLE `vibe_construction_v1`.`procurement`.`material_catalog` ALTER COLUMN `standard_cost` SET TAGS ('dbx_business_glossary_term' = 'Standard Cost');
ALTER TABLE `vibe_construction_v1`.`procurement`.`material_catalog` ALTER COLUMN `standard_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`procurement`.`material_catalog` ALTER COLUMN `storage_condition` SET TAGS ('dbx_business_glossary_term' = 'Storage Condition');
ALTER TABLE `vibe_construction_v1`.`procurement`.`material_catalog` ALTER COLUMN `valuation_class` SET TAGS ('dbx_business_glossary_term' = 'Valuation Class');
ALTER TABLE `vibe_construction_v1`.`procurement`.`material_catalog` ALTER COLUMN `valuation_class` SET TAGS ('dbx_value_regex' = '^[0-9]{4}$');
ALTER TABLE `vibe_construction_v1`.`procurement`.`material_catalog` ALTER COLUMN `volume` SET TAGS ('dbx_business_glossary_term' = 'Volume');
ALTER TABLE `vibe_construction_v1`.`procurement`.`material_catalog` ALTER COLUMN `volume_unit` SET TAGS ('dbx_business_glossary_term' = 'Volume Unit');
ALTER TABLE `vibe_construction_v1`.`procurement`.`material_catalog` ALTER COLUMN `volume_unit` SET TAGS ('dbx_value_regex' = 'M3|L|GAL|FT3');
ALTER TABLE `vibe_construction_v1`.`procurement`.`material_catalog` ALTER COLUMN `weight_unit` SET TAGS ('dbx_business_glossary_term' = 'Weight Unit');
ALTER TABLE `vibe_construction_v1`.`procurement`.`material_catalog` ALTER COLUMN `weight_unit` SET TAGS ('dbx_value_regex' = 'KG|TON|LB|G');
ALTER TABLE `vibe_construction_v1`.`procurement`.`material_catalog` ALTER COLUMN `width` SET TAGS ('dbx_business_glossary_term' = 'Width Dimension');
ALTER TABLE `vibe_construction_v1`.`procurement`.`material_catalog` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `vibe_construction_v1`.`procurement`.`rfq` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_construction_v1`.`procurement`.`rfq` SET TAGS ('dbx_subdomain' = 'material_sourcing');
ALTER TABLE `vibe_construction_v1`.`procurement`.`rfq` ALTER COLUMN `rfq_id` SET TAGS ('dbx_business_glossary_term' = 'Request for Quotation (RFQ) ID');
ALTER TABLE `vibe_construction_v1`.`procurement`.`rfq` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Awarded Vendor ID');
ALTER TABLE `vibe_construction_v1`.`procurement`.`rfq` ALTER COLUMN `bim_model_id` SET TAGS ('dbx_business_glossary_term' = 'Bim Model Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`procurement`.`rfq` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Client Account Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`procurement`.`rfq` ALTER COLUMN `construction_project_id` SET TAGS ('dbx_business_glossary_term' = 'Project ID');
ALTER TABLE `vibe_construction_v1`.`procurement`.`rfq` ALTER COLUMN `drawing_id` SET TAGS ('dbx_business_glossary_term' = 'Drawing Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`procurement`.`rfq` ALTER COLUMN `mto_header_id` SET TAGS ('dbx_business_glossary_term' = 'Mto Header Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`procurement`.`rfq` ALTER COLUMN `purchase_requisition_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Requisition Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`procurement`.`rfq` ALTER COLUMN `technical_specification_id` SET TAGS ('dbx_business_glossary_term' = 'Technical Specification Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`procurement`.`rfq` ALTER COLUMN `award_date` SET TAGS ('dbx_business_glossary_term' = 'Award Date');
ALTER TABLE `vibe_construction_v1`.`procurement`.`rfq` ALTER COLUMN `awarded_amount` SET TAGS ('dbx_business_glossary_term' = 'Awarded Amount');
ALTER TABLE `vibe_construction_v1`.`procurement`.`rfq` ALTER COLUMN `bid_bond_amount` SET TAGS ('dbx_business_glossary_term' = 'Bid Bond Amount');
ALTER TABLE `vibe_construction_v1`.`procurement`.`rfq` ALTER COLUMN `bid_bond_required` SET TAGS ('dbx_business_glossary_term' = 'Bid Bond Required');
ALTER TABLE `vibe_construction_v1`.`procurement`.`rfq` ALTER COLUMN `boq_reference` SET TAGS ('dbx_business_glossary_term' = 'Bill of Quantities (BOQ) Reference');
ALTER TABLE `vibe_construction_v1`.`procurement`.`rfq` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `vibe_construction_v1`.`procurement`.`rfq` ALTER COLUMN `closed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Closed Timestamp');
ALTER TABLE `vibe_construction_v1`.`procurement`.`rfq` ALTER COLUMN `contract_type` SET TAGS ('dbx_business_glossary_term' = 'Contract Type');
ALTER TABLE `vibe_construction_v1`.`procurement`.`rfq` ALTER COLUMN `contract_type` SET TAGS ('dbx_value_regex' = 'lump_sum|unit_price|cost_plus|gmp|time_and_materials');
ALTER TABLE `vibe_construction_v1`.`procurement`.`rfq` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`procurement`.`rfq` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_construction_v1`.`procurement`.`rfq` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_construction_v1`.`procurement`.`rfq` ALTER COLUMN `delivery_location` SET TAGS ('dbx_business_glossary_term' = 'Delivery Location');
ALTER TABLE `vibe_construction_v1`.`procurement`.`rfq` ALTER COLUMN `evaluation_criteria` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Criteria');
ALTER TABLE `vibe_construction_v1`.`procurement`.`rfq` ALTER COLUMN `hse_requirements` SET TAGS ('dbx_business_glossary_term' = 'Health Safety and Environment (HSE) Requirements');
ALTER TABLE `vibe_construction_v1`.`procurement`.`rfq` ALTER COLUMN `incoterms` SET TAGS ('dbx_business_glossary_term' = 'International Commercial Terms (Incoterms)');
ALTER TABLE `vibe_construction_v1`.`procurement`.`rfq` ALTER COLUMN `invited_vendor_count` SET TAGS ('dbx_business_glossary_term' = 'Invited Vendor Count');
ALTER TABLE `vibe_construction_v1`.`procurement`.`rfq` ALTER COLUMN `issue_date` SET TAGS ('dbx_business_glossary_term' = 'Issue Date');
ALTER TABLE `vibe_construction_v1`.`procurement`.`rfq` ALTER COLUMN `issuing_department` SET TAGS ('dbx_business_glossary_term' = 'Issuing Department');
ALTER TABLE `vibe_construction_v1`.`procurement`.`rfq` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_construction_v1`.`procurement`.`rfq` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `vibe_construction_v1`.`procurement`.`rfq` ALTER COLUMN `procurement_lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Procurement Lead Time (Days)');
ALTER TABLE `vibe_construction_v1`.`procurement`.`rfq` ALTER COLUMN `quality_requirements` SET TAGS ('dbx_business_glossary_term' = 'Quality Requirements');
ALTER TABLE `vibe_construction_v1`.`procurement`.`rfq` ALTER COLUMN `required_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Required Delivery Date');
ALTER TABLE `vibe_construction_v1`.`procurement`.`rfq` ALTER COLUMN `response_count` SET TAGS ('dbx_business_glossary_term' = 'Response Count');
ALTER TABLE `vibe_construction_v1`.`procurement`.`rfq` ALTER COLUMN `retention_percentage` SET TAGS ('dbx_business_glossary_term' = 'Retention Percentage');
ALTER TABLE `vibe_construction_v1`.`procurement`.`rfq` ALTER COLUMN `rfq_number` SET TAGS ('dbx_business_glossary_term' = 'Request for Quotation (RFQ) Number');
ALTER TABLE `vibe_construction_v1`.`procurement`.`rfq` ALTER COLUMN `rfq_number` SET TAGS ('dbx_value_regex' = '^RFQ-[A-Z0-9]{6,12}$');
ALTER TABLE `vibe_construction_v1`.`procurement`.`rfq` ALTER COLUMN `rfq_status` SET TAGS ('dbx_business_glossary_term' = 'Request for Quotation (RFQ) Status');
ALTER TABLE `vibe_construction_v1`.`procurement`.`rfq` ALTER COLUMN `rfq_type` SET TAGS ('dbx_business_glossary_term' = 'Request for Quotation (RFQ) Type');
ALTER TABLE `vibe_construction_v1`.`procurement`.`rfq` ALTER COLUMN `rfq_type` SET TAGS ('dbx_value_regex' = 'materials|equipment|services|subcontract|design_build');
ALTER TABLE `vibe_construction_v1`.`procurement`.`rfq` ALTER COLUMN `submission_deadline` SET TAGS ('dbx_business_glossary_term' = 'Submission Deadline');
ALTER TABLE `vibe_construction_v1`.`procurement`.`rfq` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Request for Quotation (RFQ) Title');
ALTER TABLE `vibe_construction_v1`.`procurement`.`rfq` ALTER COLUMN `vendor_prequalification_required` SET TAGS ('dbx_business_glossary_term' = 'Vendor Prequalification Required');
ALTER TABLE `vibe_construction_v1`.`procurement`.`rfq` ALTER COLUMN `warranty_period_months` SET TAGS ('dbx_business_glossary_term' = 'Warranty Period (Months)');
ALTER TABLE `vibe_construction_v1`.`procurement`.`rfq_line` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_construction_v1`.`procurement`.`rfq_line` SET TAGS ('dbx_subdomain' = 'material_sourcing');
ALTER TABLE `vibe_construction_v1`.`procurement`.`rfq_line` ALTER COLUMN `rfq_line_id` SET TAGS ('dbx_business_glossary_term' = 'Request for Quotation (RFQ) Line Identifier');
ALTER TABLE `vibe_construction_v1`.`procurement`.`rfq_line` ALTER COLUMN `bim_model_id` SET TAGS ('dbx_business_glossary_term' = 'Bim Model Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`procurement`.`rfq_line` ALTER COLUMN `cost_code_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Code Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`procurement`.`rfq_line` ALTER COLUMN `drawing_id` SET TAGS ('dbx_business_glossary_term' = 'Drawing Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`procurement`.`rfq_line` ALTER COLUMN `material_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Procurement Material Master Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`procurement`.`rfq_line` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Preferred Vendor Identifier');
ALTER TABLE `vibe_construction_v1`.`procurement`.`rfq_line` ALTER COLUMN `construction_project_id` SET TAGS ('dbx_business_glossary_term' = 'Project Identifier');
ALTER TABLE `vibe_construction_v1`.`procurement`.`rfq_line` ALTER COLUMN `rfq_id` SET TAGS ('dbx_business_glossary_term' = 'Request for Quotation (RFQ) Identifier');
ALTER TABLE `vibe_construction_v1`.`procurement`.`rfq_line` ALTER COLUMN `technical_specification_id` SET TAGS ('dbx_business_glossary_term' = 'Technical Specification Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`procurement`.`rfq_line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`procurement`.`rfq_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_construction_v1`.`procurement`.`rfq_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_construction_v1`.`procurement`.`rfq_line` ALTER COLUMN `delivery_location` SET TAGS ('dbx_business_glossary_term' = 'Delivery Location');
ALTER TABLE `vibe_construction_v1`.`procurement`.`rfq_line` ALTER COLUMN `estimated_total_amount` SET TAGS ('dbx_business_glossary_term' = 'Estimated Total Amount');
ALTER TABLE `vibe_construction_v1`.`procurement`.`rfq_line` ALTER COLUMN `estimated_total_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`procurement`.`rfq_line` ALTER COLUMN `estimated_unit_price` SET TAGS ('dbx_business_glossary_term' = 'Estimated Unit Price');
ALTER TABLE `vibe_construction_v1`.`procurement`.`rfq_line` ALTER COLUMN `estimated_unit_price` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`procurement`.`rfq_line` ALTER COLUMN `incoterm` SET TAGS ('dbx_business_glossary_term' = 'International Commercial Terms (Incoterm)');
ALTER TABLE `vibe_construction_v1`.`procurement`.`rfq_line` ALTER COLUMN `inspection_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Inspection Required Flag');
ALTER TABLE `vibe_construction_v1`.`procurement`.`rfq_line` ALTER COLUMN `item_description` SET TAGS ('dbx_business_glossary_term' = 'Item Description');
ALTER TABLE `vibe_construction_v1`.`procurement`.`rfq_line` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time (Days)');
ALTER TABLE `vibe_construction_v1`.`procurement`.`rfq_line` ALTER COLUMN `line_number` SET TAGS ('dbx_business_glossary_term' = 'Line Number');
ALTER TABLE `vibe_construction_v1`.`procurement`.`rfq_line` ALTER COLUMN `line_status` SET TAGS ('dbx_business_glossary_term' = 'Line Status');
ALTER TABLE `vibe_construction_v1`.`procurement`.`rfq_line` ALTER COLUMN `line_status` SET TAGS ('dbx_value_regex' = 'draft|issued|quoted|evaluated|awarded|cancelled');
ALTER TABLE `vibe_construction_v1`.`procurement`.`rfq_line` ALTER COLUMN `material_group` SET TAGS ('dbx_business_glossary_term' = 'Material Group');
ALTER TABLE `vibe_construction_v1`.`procurement`.`rfq_line` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By');
ALTER TABLE `vibe_construction_v1`.`procurement`.`rfq_line` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_construction_v1`.`procurement`.`rfq_line` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_construction_v1`.`procurement`.`rfq_line` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Priority');
ALTER TABLE `vibe_construction_v1`.`procurement`.`rfq_line` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `vibe_construction_v1`.`procurement`.`rfq_line` ALTER COLUMN `procurement_category` SET TAGS ('dbx_business_glossary_term' = 'Procurement Category');
ALTER TABLE `vibe_construction_v1`.`procurement`.`rfq_line` ALTER COLUMN `procurement_category` SET TAGS ('dbx_value_regex' = 'direct_material|indirect_material|subcontract_service|equipment_rental|professional_service|consumable');
ALTER TABLE `vibe_construction_v1`.`procurement`.`rfq_line` ALTER COLUMN `quality_requirement` SET TAGS ('dbx_business_glossary_term' = 'Quality Requirement');
ALTER TABLE `vibe_construction_v1`.`procurement`.`rfq_line` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_construction_v1`.`procurement`.`rfq_line` ALTER COLUMN `required_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Required Delivery Date');
ALTER TABLE `vibe_construction_v1`.`procurement`.`rfq_line` ALTER COLUMN `short_text` SET TAGS ('dbx_business_glossary_term' = 'Short Text');
ALTER TABLE `vibe_construction_v1`.`procurement`.`rfq_line` ALTER COLUMN `source_of_supply` SET TAGS ('dbx_business_glossary_term' = 'Source of Supply');
ALTER TABLE `vibe_construction_v1`.`procurement`.`rfq_line` ALTER COLUMN `source_of_supply` SET TAGS ('dbx_value_regex' = 'local|regional|international|preferred_vendor|open_market');
ALTER TABLE `vibe_construction_v1`.`procurement`.`rfq_line` ALTER COLUMN `tax_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Code');
ALTER TABLE `vibe_construction_v1`.`procurement`.`rfq_line` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `vibe_construction_v1`.`procurement`.`rfq_line` ALTER COLUMN `vendor_evaluation_criteria` SET TAGS ('dbx_business_glossary_term' = 'Vendor Evaluation Criteria');
ALTER TABLE `vibe_construction_v1`.`procurement`.`rfq_line` ALTER COLUMN `wbs_element` SET TAGS ('dbx_business_glossary_term' = 'Work Breakdown Structure (WBS) Element');
ALTER TABLE `vibe_construction_v1`.`procurement`.`rfq_line` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_order` SET TAGS ('dbx_subdomain' = 'order_fulfillment');
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_order` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) ID');
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_order` ALTER COLUMN `construction_project_id` SET TAGS ('dbx_business_glossary_term' = 'Project ID');
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_order` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center ID');
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_order` ALTER COLUMN `crew_id` SET TAGS ('dbx_business_glossary_term' = 'Crew Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_order` ALTER COLUMN `drawing_id` SET TAGS ('dbx_business_glossary_term' = 'Drawing Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_order` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_order` ALTER COLUMN `project_site_id` SET TAGS ('dbx_business_glossary_term' = 'Project Site Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_order` ALTER COLUMN `purchase_requisition_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Requisition Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_order` ALTER COLUMN `rfq_id` SET TAGS ('dbx_business_glossary_term' = 'Rfq Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_order` ALTER COLUMN `subcontract_id` SET TAGS ('dbx_business_glossary_term' = 'Subcontract Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_order` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_order` ALTER COLUMN `acknowledgment_date` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgment Date');
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_order` ALTER COLUMN `amendment_count` SET TAGS ('dbx_business_glossary_term' = 'Amendment Count');
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_order` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_order` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_order` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|conditional');
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_order` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_order` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_order` ALTER COLUMN `cumulative_amendment_value` SET TAGS ('dbx_business_glossary_term' = 'Cumulative Amendment Value');
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_order` ALTER COLUMN `cumulative_amendment_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_order` ALTER COLUMN `current_revision_number` SET TAGS ('dbx_business_glossary_term' = 'Current Revision Number');
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_order` ALTER COLUMN `current_version_number` SET TAGS ('dbx_business_glossary_term' = 'Current Version Number');
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_order` ALTER COLUMN `gmp_amount` SET TAGS ('dbx_business_glossary_term' = 'Guaranteed Maximum Price (GMP) Amount');
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_order` ALTER COLUMN `gmp_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_order` ALTER COLUMN `gmp_flag` SET TAGS ('dbx_business_glossary_term' = 'Guaranteed Maximum Price (GMP) Flag');
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_order` ALTER COLUMN `incoterms` SET TAGS ('dbx_business_glossary_term' = 'International Commercial Terms (Incoterms)');
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_order` ALTER COLUMN `issued_date` SET TAGS ('dbx_business_glossary_term' = 'Issued Date');
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_order` ALTER COLUMN `last_amendment_date` SET TAGS ('dbx_business_glossary_term' = 'Last Amendment Date');
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_order` ALTER COLUMN `last_amendment_type` SET TAGS ('dbx_business_glossary_term' = 'Last Amendment Type');
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_order` ALTER COLUMN `last_amendment_type` SET TAGS ('dbx_value_regex' = 'scope_change|quantity_change|price_adjustment|delivery_date_change|change_order|terms_modification');
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_order` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_order` ALTER COLUMN `ntp_date` SET TAGS ('dbx_business_glossary_term' = 'Notice to Proceed (NTP) Date');
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_order` ALTER COLUMN `original_po_value` SET TAGS ('dbx_business_glossary_term' = 'Original Purchase Order (PO) Value');
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_order` ALTER COLUMN `original_po_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_order` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_order` ALTER COLUMN `po_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Number');
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_order` ALTER COLUMN `po_number` SET TAGS ('dbx_value_regex' = '^PO-[0-9]{8,12}$');
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_order` ALTER COLUMN `po_status` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Status');
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_order` ALTER COLUMN `po_type` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Type');
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_order` ALTER COLUMN `po_type` SET TAGS ('dbx_value_regex' = 'standard|blanket|framework|subcontract|service|rental');
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_order` ALTER COLUMN `promised_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Promised Delivery Date');
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_order` ALTER COLUMN `requested_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Requested Delivery Date');
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_order` ALTER COLUMN `requisition_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Requisition (PR) Number');
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_order` ALTER COLUMN `requisition_number` SET TAGS ('dbx_value_regex' = '^PR-[0-9]{8,12}$');
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_order` ALTER COLUMN `retention_amount` SET TAGS ('dbx_business_glossary_term' = 'Retention Amount');
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_order` ALTER COLUMN `retention_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_order` ALTER COLUMN `retention_percentage` SET TAGS ('dbx_business_glossary_term' = 'Retention Percentage');
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_order` ALTER COLUMN `sap_document_number` SET TAGS ('dbx_business_glossary_term' = 'SAP Document Number');
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_order` ALTER COLUMN `sap_document_number` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_order` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_order` ALTER COLUMN `tax_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_order` ALTER COLUMN `total_po_value` SET TAGS ('dbx_business_glossary_term' = 'Total Purchase Order (PO) Value');
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_order` ALTER COLUMN `total_po_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_order` ALTER COLUMN `wbs_element` SET TAGS ('dbx_business_glossary_term' = 'Work Breakdown Structure (WBS) Element');
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_order` ALTER COLUMN `wbs_element` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,4}-[0-9]{4,8}(.[0-9]{1,4})*$');
ALTER TABLE `vibe_construction_v1`.`procurement`.`po_line` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_construction_v1`.`procurement`.`po_line` SET TAGS ('dbx_subdomain' = 'order_fulfillment');
ALTER TABLE `vibe_construction_v1`.`procurement`.`po_line` ALTER COLUMN `po_line_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Line ID');
ALTER TABLE `vibe_construction_v1`.`procurement`.`po_line` ALTER COLUMN `cost_code_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Code Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`procurement`.`po_line` ALTER COLUMN `itp_line_id` SET TAGS ('dbx_business_glossary_term' = 'Itp Line Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`procurement`.`po_line` ALTER COLUMN `material_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Procurement Material Master Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`procurement`.`po_line` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Header ID');
ALTER TABLE `vibe_construction_v1`.`procurement`.`po_line` ALTER COLUMN `rfq_line_id` SET TAGS ('dbx_business_glossary_term' = 'Rfq Line Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`procurement`.`po_line` ALTER COLUMN `account_assignment_category` SET TAGS ('dbx_business_glossary_term' = 'Account Assignment Category');
ALTER TABLE `vibe_construction_v1`.`procurement`.`po_line` ALTER COLUMN `account_assignment_category` SET TAGS ('dbx_value_regex' = 'K|A|F|P|N|U');
ALTER TABLE `vibe_construction_v1`.`procurement`.`po_line` ALTER COLUMN `buyer_name` SET TAGS ('dbx_business_glossary_term' = 'Buyer Name');
ALTER TABLE `vibe_construction_v1`.`procurement`.`po_line` ALTER COLUMN `buyer_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_construction_v1`.`procurement`.`po_line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`procurement`.`po_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_construction_v1`.`procurement`.`po_line` ALTER COLUMN `deletion_indicator` SET TAGS ('dbx_business_glossary_term' = 'Deletion Indicator');
ALTER TABLE `vibe_construction_v1`.`procurement`.`po_line` ALTER COLUMN `delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Delivery Date');
ALTER TABLE `vibe_construction_v1`.`procurement`.`po_line` ALTER COLUMN `free_text_note` SET TAGS ('dbx_business_glossary_term' = 'Free Text Note');
ALTER TABLE `vibe_construction_v1`.`procurement`.`po_line` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `vibe_construction_v1`.`procurement`.`po_line` ALTER COLUMN `goods_receipt_indicator` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt (GR) Indicator');
ALTER TABLE `vibe_construction_v1`.`procurement`.`po_line` ALTER COLUMN `goods_receipt_quantity` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt (GR) Quantity');
ALTER TABLE `vibe_construction_v1`.`procurement`.`po_line` ALTER COLUMN `incoterms` SET TAGS ('dbx_business_glossary_term' = 'International Commercial Terms (Incoterms)');
ALTER TABLE `vibe_construction_v1`.`procurement`.`po_line` ALTER COLUMN `incoterms_location` SET TAGS ('dbx_business_glossary_term' = 'Incoterms Location');
ALTER TABLE `vibe_construction_v1`.`procurement`.`po_line` ALTER COLUMN `invoice_receipt_indicator` SET TAGS ('dbx_business_glossary_term' = 'Invoice Receipt (IR) Indicator');
ALTER TABLE `vibe_construction_v1`.`procurement`.`po_line` ALTER COLUMN `invoiced_quantity` SET TAGS ('dbx_business_glossary_term' = 'Invoiced Quantity');
ALTER TABLE `vibe_construction_v1`.`procurement`.`po_line` ALTER COLUMN `item_category` SET TAGS ('dbx_business_glossary_term' = 'Item Category');
ALTER TABLE `vibe_construction_v1`.`procurement`.`po_line` ALTER COLUMN `item_category` SET TAGS ('dbx_value_regex' = 'standard|service|consignment|subcontracting|stock_transfer');
ALTER TABLE `vibe_construction_v1`.`procurement`.`po_line` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_construction_v1`.`procurement`.`po_line` ALTER COLUMN `line_number` SET TAGS ('dbx_business_glossary_term' = 'Line Number');
ALTER TABLE `vibe_construction_v1`.`procurement`.`po_line` ALTER COLUMN `line_status` SET TAGS ('dbx_business_glossary_term' = 'Line Status');
ALTER TABLE `vibe_construction_v1`.`procurement`.`po_line` ALTER COLUMN `line_status` SET TAGS ('dbx_value_regex' = 'open|partially_received|fully_received|closed|cancelled');
ALTER TABLE `vibe_construction_v1`.`procurement`.`po_line` ALTER COLUMN `manufacturer_part_number` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Part Number');
ALTER TABLE `vibe_construction_v1`.`procurement`.`po_line` ALTER COLUMN `material_description` SET TAGS ('dbx_business_glossary_term' = 'Material Description');
ALTER TABLE `vibe_construction_v1`.`procurement`.`po_line` ALTER COLUMN `material_group` SET TAGS ('dbx_business_glossary_term' = 'Material Group');
ALTER TABLE `vibe_construction_v1`.`procurement`.`po_line` ALTER COLUMN `net_value` SET TAGS ('dbx_business_glossary_term' = 'Net Value');
ALTER TABLE `vibe_construction_v1`.`procurement`.`po_line` ALTER COLUMN `ordered_quantity` SET TAGS ('dbx_business_glossary_term' = 'Ordered Quantity');
ALTER TABLE `vibe_construction_v1`.`procurement`.`po_line` ALTER COLUMN `outstanding_quantity` SET TAGS ('dbx_business_glossary_term' = 'Outstanding Quantity');
ALTER TABLE `vibe_construction_v1`.`procurement`.`po_line` ALTER COLUMN `over_delivery_tolerance_percent` SET TAGS ('dbx_business_glossary_term' = 'Over Delivery Tolerance Percentage');
ALTER TABLE `vibe_construction_v1`.`procurement`.`po_line` ALTER COLUMN `plant_code` SET TAGS ('dbx_business_glossary_term' = 'Plant Code');
ALTER TABLE `vibe_construction_v1`.`procurement`.`po_line` ALTER COLUMN `price_unit` SET TAGS ('dbx_business_glossary_term' = 'Price Unit');
ALTER TABLE `vibe_construction_v1`.`procurement`.`po_line` ALTER COLUMN `requisitioner_name` SET TAGS ('dbx_business_glossary_term' = 'Requisitioner Name');
ALTER TABLE `vibe_construction_v1`.`procurement`.`po_line` ALTER COLUMN `requisitioner_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_construction_v1`.`procurement`.`po_line` ALTER COLUMN `short_text` SET TAGS ('dbx_business_glossary_term' = 'Short Text');
ALTER TABLE `vibe_construction_v1`.`procurement`.`po_line` ALTER COLUMN `storage_location` SET TAGS ('dbx_business_glossary_term' = 'Storage Location');
ALTER TABLE `vibe_construction_v1`.`procurement`.`po_line` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `vibe_construction_v1`.`procurement`.`po_line` ALTER COLUMN `tax_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Code');
ALTER TABLE `vibe_construction_v1`.`procurement`.`po_line` ALTER COLUMN `under_delivery_tolerance_percent` SET TAGS ('dbx_business_glossary_term' = 'Under Delivery Tolerance Percentage');
ALTER TABLE `vibe_construction_v1`.`procurement`.`po_line` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `vibe_construction_v1`.`procurement`.`po_line` ALTER COLUMN `unit_price` SET TAGS ('dbx_business_glossary_term' = 'Unit Price');
ALTER TABLE `vibe_construction_v1`.`procurement`.`po_line` ALTER COLUMN `vendor_material_number` SET TAGS ('dbx_business_glossary_term' = 'Vendor Material Number');
ALTER TABLE `vibe_construction_v1`.`procurement`.`po_line` ALTER COLUMN `wbs_element` SET TAGS ('dbx_business_glossary_term' = 'Work Breakdown Structure (WBS) Element');
ALTER TABLE `vibe_construction_v1`.`procurement`.`goods_receipt` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_construction_v1`.`procurement`.`goods_receipt` SET TAGS ('dbx_subdomain' = 'order_fulfillment');
ALTER TABLE `vibe_construction_v1`.`procurement`.`goods_receipt` ALTER COLUMN `goods_receipt_id` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt Identifier');
ALTER TABLE `vibe_construction_v1`.`procurement`.`goods_receipt` ALTER COLUMN `batch_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Batch Lot Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`procurement`.`goods_receipt` ALTER COLUMN `construction_project_id` SET TAGS ('dbx_business_glossary_term' = 'Project ID');
ALTER TABLE `vibe_construction_v1`.`procurement`.`goods_receipt` ALTER COLUMN `material_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Procurement Material Master Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`procurement`.`goods_receipt` ALTER COLUMN `po_line_id` SET TAGS ('dbx_business_glossary_term' = 'Po Line Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`procurement`.`goods_receipt` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) ID');
ALTER TABLE `vibe_construction_v1`.`procurement`.`goods_receipt` ALTER COLUMN `craft_worker_id` SET TAGS ('dbx_business_glossary_term' = 'Receiving Craft Worker Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`procurement`.`goods_receipt` ALTER COLUMN `crew_id` SET TAGS ('dbx_business_glossary_term' = 'Receiving Crew Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`procurement`.`goods_receipt` ALTER COLUMN `technical_specification_id` SET TAGS ('dbx_business_glossary_term' = 'Technical Specification Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`procurement`.`goods_receipt` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `vibe_construction_v1`.`procurement`.`goods_receipt` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Number');
ALTER TABLE `vibe_construction_v1`.`procurement`.`goods_receipt` ALTER COLUMN `carrier_name` SET TAGS ('dbx_business_glossary_term' = 'Carrier Name');
ALTER TABLE `vibe_construction_v1`.`procurement`.`goods_receipt` ALTER COLUMN `carrier_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_construction_v1`.`procurement`.`goods_receipt` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_construction_v1`.`procurement`.`goods_receipt` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_construction_v1`.`procurement`.`goods_receipt` ALTER COLUMN `delivery_completed_flag` SET TAGS ('dbx_business_glossary_term' = 'Delivery Completed Flag');
ALTER TABLE `vibe_construction_v1`.`procurement`.`goods_receipt` ALTER COLUMN `delivery_note_number` SET TAGS ('dbx_business_glossary_term' = 'Delivery Note Number');
ALTER TABLE `vibe_construction_v1`.`procurement`.`goods_receipt` ALTER COLUMN `gr_document_number` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt (GR) Document Number');
ALTER TABLE `vibe_construction_v1`.`procurement`.`goods_receipt` ALTER COLUMN `gr_document_number` SET TAGS ('dbx_value_regex' = '^GR[0-9]{10}$');
ALTER TABLE `vibe_construction_v1`.`procurement`.`goods_receipt` ALTER COLUMN `inspection_status` SET TAGS ('dbx_business_glossary_term' = 'Inspection Status');
ALTER TABLE `vibe_construction_v1`.`procurement`.`goods_receipt` ALTER COLUMN `inspection_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|in_progress|passed|failed|waived');
ALTER TABLE `vibe_construction_v1`.`procurement`.`goods_receipt` ALTER COLUMN `invoice_verification_status` SET TAGS ('dbx_business_glossary_term' = 'Invoice Verification Status');
ALTER TABLE `vibe_construction_v1`.`procurement`.`goods_receipt` ALTER COLUMN `material_document_number` SET TAGS ('dbx_business_glossary_term' = 'Material Document Number');
ALTER TABLE `vibe_construction_v1`.`procurement`.`goods_receipt` ALTER COLUMN `material_document_number` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `vibe_construction_v1`.`procurement`.`goods_receipt` ALTER COLUMN `movement_type` SET TAGS ('dbx_business_glossary_term' = 'Movement Type');
ALTER TABLE `vibe_construction_v1`.`procurement`.`goods_receipt` ALTER COLUMN `movement_type` SET TAGS ('dbx_value_regex' = '^[0-9]{3}$');
ALTER TABLE `vibe_construction_v1`.`procurement`.`goods_receipt` ALTER COLUMN `ordered_quantity` SET TAGS ('dbx_business_glossary_term' = 'Ordered Quantity');
ALTER TABLE `vibe_construction_v1`.`procurement`.`goods_receipt` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Date');
ALTER TABLE `vibe_construction_v1`.`procurement`.`goods_receipt` ALTER COLUMN `receipt_condition` SET TAGS ('dbx_business_glossary_term' = 'Receipt Condition');
ALTER TABLE `vibe_construction_v1`.`procurement`.`goods_receipt` ALTER COLUMN `receipt_condition` SET TAGS ('dbx_value_regex' = 'accepted|rejected|partial|damaged|on_hold|quarantine');
ALTER TABLE `vibe_construction_v1`.`procurement`.`goods_receipt` ALTER COLUMN `receipt_date` SET TAGS ('dbx_business_glossary_term' = 'Receipt Date');
ALTER TABLE `vibe_construction_v1`.`procurement`.`goods_receipt` ALTER COLUMN `receipt_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Receipt Timestamp');
ALTER TABLE `vibe_construction_v1`.`procurement`.`goods_receipt` ALTER COLUMN `received_quantity` SET TAGS ('dbx_business_glossary_term' = 'Received Quantity');
ALTER TABLE `vibe_construction_v1`.`procurement`.`goods_receipt` ALTER COLUMN `rejected_quantity` SET TAGS ('dbx_business_glossary_term' = 'Rejected Quantity');
ALTER TABLE `vibe_construction_v1`.`procurement`.`goods_receipt` ALTER COLUMN `reversal_document_number` SET TAGS ('dbx_business_glossary_term' = 'Reversal Document Number');
ALTER TABLE `vibe_construction_v1`.`procurement`.`goods_receipt` ALTER COLUMN `reversal_flag` SET TAGS ('dbx_business_glossary_term' = 'Reversal Flag');
ALTER TABLE `vibe_construction_v1`.`procurement`.`goods_receipt` ALTER COLUMN `reversal_reason` SET TAGS ('dbx_business_glossary_term' = 'Reversal Reason');
ALTER TABLE `vibe_construction_v1`.`procurement`.`goods_receipt` ALTER COLUMN `serial_number` SET TAGS ('dbx_business_glossary_term' = 'Serial Number');
ALTER TABLE `vibe_construction_v1`.`procurement`.`goods_receipt` ALTER COLUMN `special_handling_instructions` SET TAGS ('dbx_business_glossary_term' = 'Special Handling Instructions');
ALTER TABLE `vibe_construction_v1`.`procurement`.`goods_receipt` ALTER COLUMN `storage_location_code` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Code');
ALTER TABLE `vibe_construction_v1`.`procurement`.`goods_receipt` ALTER COLUMN `storage_location_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `vibe_construction_v1`.`procurement`.`goods_receipt` ALTER COLUMN `tax_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Code');
ALTER TABLE `vibe_construction_v1`.`procurement`.`goods_receipt` ALTER COLUMN `total_value` SET TAGS ('dbx_business_glossary_term' = 'Total Value');
ALTER TABLE `vibe_construction_v1`.`procurement`.`goods_receipt` ALTER COLUMN `total_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`procurement`.`goods_receipt` ALTER COLUMN `tracking_number` SET TAGS ('dbx_business_glossary_term' = 'Tracking Number');
ALTER TABLE `vibe_construction_v1`.`procurement`.`goods_receipt` ALTER COLUMN `transportation_mode` SET TAGS ('dbx_business_glossary_term' = 'Transportation Mode');
ALTER TABLE `vibe_construction_v1`.`procurement`.`goods_receipt` ALTER COLUMN `transportation_mode` SET TAGS ('dbx_value_regex' = 'truck|rail|air|sea|courier|pickup');
ALTER TABLE `vibe_construction_v1`.`procurement`.`goods_receipt` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `vibe_construction_v1`.`procurement`.`goods_receipt` ALTER COLUMN `unit_price` SET TAGS ('dbx_business_glossary_term' = 'Unit Price');
ALTER TABLE `vibe_construction_v1`.`procurement`.`goods_receipt` ALTER COLUMN `unit_price` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`procurement`.`goods_receipt` ALTER COLUMN `unloading_point` SET TAGS ('dbx_business_glossary_term' = 'Unloading Point');
ALTER TABLE `vibe_construction_v1`.`procurement`.`goods_receipt` ALTER COLUMN `valuation_type` SET TAGS ('dbx_business_glossary_term' = 'Valuation Type');
ALTER TABLE `vibe_construction_v1`.`procurement`.`goods_receipt` ALTER COLUMN `variance_notes` SET TAGS ('dbx_business_glossary_term' = 'Variance Notes');
ALTER TABLE `vibe_construction_v1`.`procurement`.`goods_receipt` ALTER COLUMN `variance_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Variance Reason Code');
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_requisition` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_requisition` SET TAGS ('dbx_subdomain' = 'material_sourcing');
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `purchase_requisition_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Requisition (PR) ID');
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `construction_project_id` SET TAGS ('dbx_business_glossary_term' = 'Project ID');
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `cost_account_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Account Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `cost_code_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Code Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `drawing_id` SET TAGS ('dbx_business_glossary_term' = 'Drawing Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Preferred Vendor Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `project_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Project Budget Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `scope_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Scope Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `technical_specification_id` SET TAGS ('dbx_business_glossary_term' = 'Technical Specification Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `budget_available_flag` SET TAGS ('dbx_business_glossary_term' = 'Budget Available Flag');
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `budget_variance_amount` SET TAGS ('dbx_business_glossary_term' = 'Budget Variance Amount');
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `closed_date` SET TAGS ('dbx_business_glossary_term' = 'Closed Date');
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `conversion_date` SET TAGS ('dbx_business_glossary_term' = 'Conversion Date');
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `conversion_status` SET TAGS ('dbx_business_glossary_term' = 'Conversion Status');
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `conversion_status` SET TAGS ('dbx_value_regex' = 'not_converted|converted_to_rfq|converted_to_po|partially_converted');
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `converted_document_number` SET TAGS ('dbx_business_glossary_term' = 'Converted Document Number');
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `current_approver_name` SET TAGS ('dbx_business_glossary_term' = 'Current Approver Name');
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `current_approver_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `delivery_location` SET TAGS ('dbx_business_glossary_term' = 'Delivery Location');
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `estimated_total_cost` SET TAGS ('dbx_business_glossary_term' = 'Estimated Total Cost');
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `estimated_unit_cost` SET TAGS ('dbx_business_glossary_term' = 'Estimated Unit Cost');
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `justification_notes` SET TAGS ('dbx_business_glossary_term' = 'Justification Notes');
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `material_description` SET TAGS ('dbx_business_glossary_term' = 'Material or Service Description');
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `material_group` SET TAGS ('dbx_business_glossary_term' = 'Material Group');
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `pr_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Requisition (PR) Number');
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `pr_number` SET TAGS ('dbx_value_regex' = '^PR-[0-9]{8}$');
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `pr_status` SET TAGS ('dbx_business_glossary_term' = 'Purchase Requisition (PR) Status');
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `pr_type` SET TAGS ('dbx_business_glossary_term' = 'Purchase Requisition (PR) Type');
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `pr_type` SET TAGS ('dbx_value_regex' = 'standard|subcontract|service|stock_transfer|consignment|rental');
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `procurement_strategy` SET TAGS ('dbx_business_glossary_term' = 'Procurement Strategy');
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `procurement_strategy` SET TAGS ('dbx_value_regex' = 'direct_po|competitive_rfq|framework_agreement|spot_buy|emergency_procurement');
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Requested Quantity');
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `rejection_date` SET TAGS ('dbx_business_glossary_term' = 'Rejection Date');
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `requester_email` SET TAGS ('dbx_business_glossary_term' = 'Requester Email Address');
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `requester_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `requester_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `requester_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `requester_email` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `requester_name` SET TAGS ('dbx_business_glossary_term' = 'Requester Name');
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `requester_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `requesting_department` SET TAGS ('dbx_business_glossary_term' = 'Requesting Department');
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `required_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Required Delivery Date');
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `requisition_date` SET TAGS ('dbx_business_glossary_term' = 'Requisition Date');
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `technical_specification_attached` SET TAGS ('dbx_business_glossary_term' = 'Technical Specification Attached Flag');
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `urgency_classification` SET TAGS ('dbx_business_glossary_term' = 'Urgency Classification');
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `urgency_classification` SET TAGS ('dbx_value_regex' = 'routine|urgent|critical|emergency');
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `wbs_element` SET TAGS ('dbx_business_glossary_term' = 'Work Breakdown Structure (WBS) Element');
ALTER TABLE `vibe_construction_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `wbs_element` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2}-[0-9]{4}-[0-9]{2}-[0-9]{3}$');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_invoice` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_invoice` SET TAGS ('dbx_subdomain' = 'order_fulfillment');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_invoice` ALTER COLUMN `vendor_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Invoice ID');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_invoice` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_invoice` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_invoice` ALTER COLUMN `construction_project_id` SET TAGS ('dbx_business_glossary_term' = 'Project ID');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_invoice` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center ID');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_invoice` ALTER COLUMN `cost_code_id` SET TAGS ('dbx_business_glossary_term' = 'Finance Cost Code Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_invoice` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account ID');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_invoice` ALTER COLUMN `goods_receipt_id` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_invoice` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_invoice` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_invoice` ALTER COLUMN `payment_certificate_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Certificate Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_invoice` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) ID');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_invoice` ALTER COLUMN `rental_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Rental Agreement Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_invoice` ALTER COLUMN `subcontract_id` SET TAGS ('dbx_business_glossary_term' = 'Subcontract Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_invoice` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_invoice` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_invoice` ALTER COLUMN `blocked_reason` SET TAGS ('dbx_business_glossary_term' = 'Blocked Reason');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_invoice` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_invoice` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_invoice` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_invoice` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_invoice` ALTER COLUMN `dispute_flag` SET TAGS ('dbx_business_glossary_term' = 'Dispute Flag');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_invoice` ALTER COLUMN `dispute_reason` SET TAGS ('dbx_business_glossary_term' = 'Dispute Reason');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_invoice` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_invoice` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_invoice` ALTER COLUMN `invoice_date` SET TAGS ('dbx_business_glossary_term' = 'Invoice Date');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_invoice` ALTER COLUMN `invoice_description` SET TAGS ('dbx_business_glossary_term' = 'Invoice Description');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_invoice` ALTER COLUMN `invoice_gross_amount` SET TAGS ('dbx_business_glossary_term' = 'Invoice Gross Amount');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_invoice` ALTER COLUMN `invoice_net_amount` SET TAGS ('dbx_business_glossary_term' = 'Invoice Net Amount');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_invoice` ALTER COLUMN `invoice_received_date` SET TAGS ('dbx_business_glossary_term' = 'Invoice Received Date');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_invoice` ALTER COLUMN `invoice_status` SET TAGS ('dbx_business_glossary_term' = 'Invoice Status');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_invoice` ALTER COLUMN `invoice_type` SET TAGS ('dbx_business_glossary_term' = 'Invoice Type');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_invoice` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_invoice` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_invoice` ALTER COLUMN `payment_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Date');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_invoice` ALTER COLUMN `payment_due_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Due Date');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_invoice` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_invoice` ALTER COLUMN `payment_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Payment Reference Number');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_invoice` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_invoice` ALTER COLUMN `retention_amount` SET TAGS ('dbx_business_glossary_term' = 'Retention Amount');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_invoice` ALTER COLUMN `retention_percentage` SET TAGS ('dbx_business_glossary_term' = 'Retention Percentage');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_invoice` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_invoice` ALTER COLUMN `tax_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Code');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_invoice` ALTER COLUMN `three_way_match_status` SET TAGS ('dbx_business_glossary_term' = 'Three-Way Match Status');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_invoice` ALTER COLUMN `three_way_match_status` SET TAGS ('dbx_value_regex' = 'matched|quantity_variance|price_variance|not_matched|bypassed');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_invoice` ALTER COLUMN `verification_status` SET TAGS ('dbx_business_glossary_term' = 'Verification Status');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_invoice` ALTER COLUMN `verification_status` SET TAGS ('dbx_value_regex' = 'pending|verified|rejected|on_hold');
ALTER TABLE `vibe_construction_v1`.`procurement`.`vendor_invoice` ALTER COLUMN `withholding_tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Withholding Tax Amount');
ALTER TABLE `vibe_construction_v1`.`procurement`.`sourcing_info_record` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_construction_v1`.`procurement`.`sourcing_info_record` SET TAGS ('dbx_subdomain' = 'vendor_management');
ALTER TABLE `vibe_construction_v1`.`procurement`.`sourcing_info_record` SET TAGS ('dbx_association_edges' = 'procurement.vendor,procurement.material_catalog');
ALTER TABLE `vibe_construction_v1`.`procurement`.`sourcing_info_record` ALTER COLUMN `sourcing_info_record_id` SET TAGS ('dbx_business_glossary_term' = 'Sourcing Info Record - Sourcing Info Record Id');
ALTER TABLE `vibe_construction_v1`.`procurement`.`sourcing_info_record` ALTER COLUMN `material_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Sourcing Info Record - Material Catalog Id');
ALTER TABLE `vibe_construction_v1`.`procurement`.`sourcing_info_record` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Sourcing Info Record - Vendor Id');
ALTER TABLE `vibe_construction_v1`.`procurement`.`sourcing_info_record` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Sourcing Agreement Effective Date');
ALTER TABLE `vibe_construction_v1`.`procurement`.`sourcing_info_record` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Sourcing Agreement Expiry Date');
ALTER TABLE `vibe_construction_v1`.`procurement`.`sourcing_info_record` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Vendor Lead Time (Days)');
ALTER TABLE `vibe_construction_v1`.`procurement`.`sourcing_info_record` ALTER COLUMN `minimum_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Vendor Minimum Order Quantity');
ALTER TABLE `vibe_construction_v1`.`procurement`.`sourcing_info_record` ALTER COLUMN `preferred_flag` SET TAGS ('dbx_business_glossary_term' = 'Preferred Source Flag');
ALTER TABLE `vibe_construction_v1`.`procurement`.`sourcing_info_record` ALTER COLUMN `price_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Price Currency Code');
ALTER TABLE `vibe_construction_v1`.`procurement`.`sourcing_info_record` ALTER COLUMN `price_unit_quantity` SET TAGS ('dbx_business_glossary_term' = 'Price Per Unit Quantity');
ALTER TABLE `vibe_construction_v1`.`procurement`.`sourcing_info_record` ALTER COLUMN `sourcing_info_record_status` SET TAGS ('dbx_business_glossary_term' = 'Sourcing Record Status');
ALTER TABLE `vibe_construction_v1`.`procurement`.`sourcing_info_record` ALTER COLUMN `unit_price` SET TAGS ('dbx_business_glossary_term' = 'Negotiated Unit Price');
ALTER TABLE `vibe_construction_v1`.`procurement`.`sourcing_info_record` ALTER COLUMN `unit_price` SET TAGS ('dbx_financial_sensitive' = 'true');
