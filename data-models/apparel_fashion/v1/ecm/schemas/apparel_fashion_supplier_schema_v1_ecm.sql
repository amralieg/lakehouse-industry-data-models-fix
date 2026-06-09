-- Schema for Domain: supplier | Business: Apparel Fashion | Version: v1_ecm
-- Generated on: 2026-05-05 15:54:38

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `apparel_fashion_ecm`.`supplier` COMMENT 'SSOT for all vendor and supplier master data including manufacturer profiles, CMT factories, OEM/ODM partners, fabric mills, trim suppliers, and 3PL providers. Manages factory certifications, compliance audits (WRAP, FLA, GOTS, OEKO-TEX), capacity profiles, payment terms, LC terms, and supplier risk scorecards.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`supplier`.`vendor` (
    `vendor_id` BIGINT COMMENT 'Unique identifier for the vendor entity. Primary key for the vendor master record.',
    `bank_account_number` STRING COMMENT 'Vendors bank account number used for electronic payment transfers and settlements.',
    `bank_name` STRING COMMENT 'Name of the financial institution where the vendor maintains their primary business banking account.',
    `business_registration_number` STRING COMMENT 'Official government-issued business registration or tax identification number for the vendor entity.',
    `business_status` STRING COMMENT 'Current operational status of the vendor relationship indicating whether the vendor is actively engaged, suspended, or terminated.. Valid values are `Active|Inactive|Suspended|Pending Approval|Blocked|Terminated`',
    `compliance_certifications` STRING COMMENT 'Comma-separated list of compliance certifications held by the vendor, such as WRAP, FLA, GOTS, OEKO-TEX, ISO 9001, ISO 14001, ISO 45001, BCI, or other industry-recognized standards.',
    `country_of_origin` STRING COMMENT 'Three-letter ISO country code representing the primary country where the vendor is legally registered and operates.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the vendor record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO currency code representing the primary currency used for transactions and payments with this vendor.. Valid values are `^[A-Z]{3}$`',
    `edi_capable_flag` BOOLEAN COMMENT 'Boolean indicator of whether the vendor has the technical capability to exchange business documents electronically using EDI standards.',
    `final_approval_date` DATE COMMENT 'Date when the vendor received final executive or procurement approval to be added to the approved vendor list.',
    `fob_port` STRING COMMENT 'Name of the port or location where goods are loaded for shipment and where ownership and risk transfer from vendor to buyer under FOB terms.',
    `go_live_date` DATE COMMENT 'Actual date when the vendor became operational and began fulfilling orders or providing services to the business.',
    `headquarters_address` STRING COMMENT 'Full physical address of the vendors primary headquarters or registered office location.',
    `incoterms` STRING COMMENT 'Standard trade terms defining the responsibilities, costs, and risks associated with the transportation and delivery of goods between buyer and seller. [ENUM-REF-CANDIDATE: EXW|FCA|CPT|CIP|DAP|DPU|DDP|FAS|FOB|CFR|CIF — 11 candidates stripped; promote to reference product]',
    `last_audit_date` DATE COMMENT 'Date of the most recent compliance, quality, or social responsibility audit conducted at the vendors facilities.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when the vendor record was most recently updated or modified.',
    `lc_terms_required_flag` BOOLEAN COMMENT 'Boolean indicator of whether the vendor requires payment to be secured through a letter of credit for international transactions.',
    `lead_time_days` STRING COMMENT 'Standard number of days required from purchase order placement to delivery of goods or completion of services by the vendor.',
    `legal_entity_name` STRING COMMENT 'The full legal registered name of the vendor as it appears on official business registration documents and contracts.',
    `moq_units` STRING COMMENT 'Minimum number of units that must be ordered from the vendor in a single purchase order to meet their production or business requirements.',
    `moq_value` DECIMAL(18,2) COMMENT 'Minimum monetary value required for a purchase order to be accepted by the vendor, expressed in the vendors currency.',
    `next_audit_due_date` DATE COMMENT 'Scheduled date for the next compliance or quality audit to be conducted at the vendors facilities.',
    `onboarding_completion_date` DATE COMMENT 'Actual date when all onboarding activities and checklist items were completed and the vendor was approved for activation.',
    `onboarding_completion_percentage` DECIMAL(18,2) COMMENT 'Percentage of onboarding checklist items completed, calculated as completed tasks divided by total required tasks, expressed as a decimal (0.00 to 100.00).',
    `onboarding_manager` STRING COMMENT 'Name of the internal employee or team responsible for managing the vendor onboarding process and ensuring completion of all required steps.',
    `onboarding_stage` STRING COMMENT 'Current stage in the vendor onboarding workflow process, tracking progress from initial documentation through final approval and system setup. [ENUM-REF-CANDIDATE: Not Started|Documentation|Compliance Review|Factory Audit|Contract Negotiation|System Setup|Approved|Completed — 8 candidates stripped; promote to reference product]',
    `payment_terms` STRING COMMENT 'Negotiated payment terms defining the timeline and conditions for payment, such as Net 30, Net 60, or advance payment requirements.',
    `preferred_vendor_flag` BOOLEAN COMMENT 'Boolean indicator of whether the vendor has been designated as a preferred or strategic supplier with priority consideration for new business.',
    `primary_contact_email` STRING COMMENT 'Email address of the primary business contact for vendor communications and correspondence.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `primary_contact_name` STRING COMMENT 'Full name of the primary business contact person at the vendor organization for operational communications.',
    `primary_contact_phone` STRING COMMENT 'Primary telephone number for reaching the vendors main business contact.',
    `production_capacity_units_per_month` STRING COMMENT 'Maximum number of units the vendor can produce or supply per month based on their current production capacity and resources.',
    `quality_rating_score` DECIMAL(18,2) COMMENT 'Vendor quality performance score based on defect rates, compliance with specifications, and quality audit results, typically on a scale of 0.00 to 5.00.',
    `risk_score` DECIMAL(18,2) COMMENT 'Composite risk assessment score evaluating the vendor across financial stability, geopolitical risk, compliance history, and operational reliability, typically on a scale of 0.00 to 10.00.',
    `swift_code` STRING COMMENT 'International bank identifier code used for cross-border wire transfers and international payments to the vendor.. Valid values are `^[A-Z]{6}[A-Z0-9]{2}([A-Z0-9]{3})?$`',
    `target_go_live_date` DATE COMMENT 'Planned date when the vendor is expected to be fully operational and ready to begin fulfilling orders or providing services.',
    `tax_id_number` STRING COMMENT 'Government-issued tax identification number used for tax reporting and compliance purposes in the vendors country of operation.',
    `tier_classification` STRING COMMENT 'Supply chain tier level indicating the vendors position in the supply chain hierarchy. Tier 1 represents direct suppliers, Tier 2 represents suppliers to Tier 1, and so on.. Valid values are `Tier 1|Tier 2|Tier 3|Tier 4`',
    `vendor_code` STRING COMMENT 'Internal business identifier or short code used to reference the vendor in operational systems, purchase orders, and transactions.',
    `vendor_type` STRING COMMENT 'Classification of the vendor based on the type of goods or services provided. CMT (Cut Make Trim) for contract manufacturers, OEM (Original Equipment Manufacturer), ODM (Original Design Manufacturer), Fabric Mill for textile suppliers, Trim Supplier for accessories, 3PL (Third-Party Logistics) for logistics providers. [ENUM-REF-CANDIDATE: CMT|OEM|ODM|Fabric Mill|Trim Supplier|3PL|Raw Material|Packaging|Logistics|Other — 10 candidates stripped; promote to reference product]',
    `vmi_eligible_flag` BOOLEAN COMMENT 'Boolean indicator of whether the vendor is eligible and approved to participate in vendor-managed inventory programs where they manage stock levels at buyer locations.',
    CONSTRAINT pk_vendor PRIMARY KEY(`vendor_id`)
) COMMENT 'Master record for all supplier and vendor entities in the apparel-fashion supply chain, including CMT factories, OEM/ODM partners, fabric mills, trim suppliers, 3PL providers, and raw material vendors. Captures legal entity name, registration number, country of origin, vendor type (CMT/OEM/ODM/Mill/Trim/3PL), tier classification (Tier 1/2/3), business status, primary contact, headquarters address, currency, payment terms, incoterms, FOB port, lead time, MOQ thresholds, EDI capability flag, VMI eligibility, onboarding stage, onboarding checklist completion percentage, onboarding manager, target go-live date, onboarding completion date, go-live date, and final approval date. SSOT for all vendor identity, commercial terms, and lifecycle status (including onboarding workflow state) across sourcing, production, and supply chain domains.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`supplier`.`supplier_factory` (
    `supplier_factory_id` BIGINT COMMENT 'Unique identifier for the manufacturing facility. Primary key for the supplier factory entity.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Factories require operational managers for day-to-day oversight, performance accountability, compliance coordination, and escalation. Critical for factory scorecards, audit coordination, and capacity ',
    `vendor_id` BIGINT COMMENT 'Reference to the parent vendor or supplier legal entity that owns or operates this factory. One supplier may operate multiple factories.',
    `address_line_1` STRING COMMENT 'Primary street address of the factory facility including building number and street name.',
    `address_line_2` STRING COMMENT 'Secondary address information such as suite, floor, or industrial zone designation.',
    `audit_score` DECIMAL(18,2) COMMENT 'Most recent audit score or rating (typically 0-100 scale) reflecting compliance with labor standards, workplace safety, environmental practices, and quality systems. Used for supplier risk assessment and scorecard reporting.',
    `certifications` STRING COMMENT 'Comma-separated list of current valid certifications held by the factory (e.g., WRAP, FLA, GOTS, OEKO-TEX Standard 100, ISO 9001, ISO 14001, ISO 45001, BCI, BSCI). Required for compliance verification and ethical sourcing.',
    `city` STRING COMMENT 'City or municipality where the factory is located.',
    `country_code` STRING COMMENT 'Three-letter ISO country code identifying the country where the factory is located. Critical for trade compliance, duty calculation, and country-of-origin labeling per FTC requirements.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this factory record was first created in the system. Used for data lineage and audit trail.',
    `currency_code` STRING COMMENT 'Three-letter ISO currency code for transactions with this factory. Used for pricing, purchase orders, and financial settlement.. Valid values are `^[A-Z]{3}$`',
    `email_address` STRING COMMENT 'Primary email contact for factory operations, production coordination, and quality communications.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `established_date` DATE COMMENT 'Date when the factory was originally established or began operations. Indicates factory maturity and operational experience.',
    `factory_code` STRING COMMENT 'Internal alphanumeric code assigned to uniquely identify the factory within the enterprise sourcing system. Used in purchase orders and production planning.',
    `factory_name` STRING COMMENT 'Official business name of the manufacturing facility as registered with local authorities.',
    `factory_type` STRING COMMENT 'Classification of the manufacturing facility based on its primary production capability. Cut-Make-Trim (CMT) factories perform assembly only; Full Package factories handle design through production; specialized factories focus on fabric production or finishing processes. [ENUM-REF-CANDIDATE: Cut-Make-Trim|Full Package|Knitting|Weaving|Dyeing|Finishing|Embroidery — 7 candidates stripped; promote to reference product]',
    `floor_area_sqm` DECIMAL(18,2) COMMENT 'Total manufacturing floor space in square meters. Used to assess factory scale, capacity utilization, and compliance with workplace safety standards.',
    `gender_specialization` STRING COMMENT 'Primary gender category focus of the factory production capability. Some factories specialize in specific gender categories due to sizing, fit, and construction expertise.. Valid values are `Menswear|Womenswear|Kidswear|Unisex|All`',
    `incoterms` STRING COMMENT 'Standard Incoterms code defining the division of costs, risks, and responsibilities between buyer and seller for shipments from this factory. FOB (Free on Board) is most common in apparel sourcing. [ENUM-REF-CANDIDATE: EXW|FOB|CIF|DDP|FCA|CPT|CIP|DAP|DPU — 9 candidates stripped; promote to reference product]',
    `last_audit_date` DATE COMMENT 'Date of the most recent compliance or quality audit conducted at the factory. Used to track audit frequency and identify factories due for re-audit per WRAP and FLA requirements.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this factory record was last updated. Supports change tracking and data governance.',
    `last_order_date` DATE COMMENT 'Date of the most recent purchase order placed with this factory. Used to identify inactive suppliers and manage supplier lifecycle.',
    `lead_time_days` STRING COMMENT 'Standard production lead time from purchase order confirmation to ex-factory shipment readiness, measured in calendar days. Used for Time and Action (TNA) calendar planning and On Time In Full (OTIF) performance tracking.',
    `machinery_types` STRING COMMENT 'Comma-separated list of key machinery and equipment types available at the factory (e.g., single-needle machines, overlock machines, flatlock machines, buttonhole machines, pressing equipment, cutting tables). Determines production capabilities and product suitability.',
    `moq_units` STRING COMMENT 'Minimum Order Quantity (MOQ) required by the factory per style or purchase order, measured in units. Critical for order planning and vendor negotiation.',
    `next_audit_due_date` DATE COMMENT 'Scheduled date for the next compliance or certification audit. Factories must maintain current audit status to remain active in the approved supplier network.',
    `notes` STRING COMMENT 'Free-text field for additional operational notes, special instructions, quality observations, or compliance remarks related to the factory.',
    `number_of_production_lines` STRING COMMENT 'Total count of active production lines or assembly lines operating within the factory. Indicates scale and parallel production capability.',
    `onboarding_date` DATE COMMENT 'Date when the factory was approved and onboarded into the enterprise supplier network. Marks the start of the business relationship.',
    `operational_status` STRING COMMENT 'Current operational state of the factory in the supplier network. Active factories are approved for production; Suspended factories are temporarily blocked due to compliance or quality issues; Under Audit factories are undergoing certification review.. Valid values are `Active|Inactive|Suspended|Under Audit|Pending Approval|Decommissioned`',
    `payment_terms` STRING COMMENT 'Standard payment terms negotiated with the factory (e.g., Net 30, Net 60, 30% deposit + 70% on shipment, Letter of Credit at sight). Impacts cash flow planning and supplier relationship management.',
    `phone_number` STRING COMMENT 'Primary contact telephone number for the factory including country and area codes.',
    `postal_code` STRING COMMENT 'Postal or ZIP code for the factory location.',
    `primary_contact_name` STRING COMMENT 'Full name of the primary factory contact person responsible for production coordination and communication with the buying organization.',
    `primary_contact_title` STRING COMMENT 'Job title or role of the primary factory contact (e.g., Factory Manager, Production Director, Merchandising Manager).',
    `product_categories_manufactured` STRING COMMENT 'Comma-separated list of product categories the factory is equipped to manufacture (e.g., T-shirts, Dresses, Outerwear, Denim, Activewear, Footwear, Accessories). Used for supplier selection and product allocation.',
    `production_capacity_units_per_month` DECIMAL(18,2) COMMENT 'Maximum monthly production capacity of the factory measured in units (garments, pieces, or pairs). Used for capacity planning, order allocation, and Open-to-Buy (OTB) calculations.',
    `region` STRING COMMENT 'Broader geographic region classification for sourcing strategy and logistics planning (e.g., South Asia, Southeast Asia, East Asia, Europe, Americas).',
    `risk_rating` STRING COMMENT 'Overall supplier risk classification based on audit results, compliance history, financial stability, geopolitical factors, and operational performance. High or Critical risk factories require enhanced monitoring and corrective action plans.. Valid values are `Low|Medium|High|Critical`',
    `shift_structure` STRING COMMENT 'Daily shift operation model of the factory. Indicates production hours and capacity flexibility. Triple shift operations provide maximum throughput but require strong labor compliance oversight.. Valid values are `Single Shift|Double Shift|Triple Shift|Flexible`',
    `state_province` STRING COMMENT 'State, province, or administrative region where the factory operates.',
    `workforce_headcount` STRING COMMENT 'Total number of employees working at the factory including production workers, supervisors, quality control staff, and administrative personnel. Required for labor compliance audits.',
    CONSTRAINT pk_supplier_factory PRIMARY KEY(`supplier_factory_id`)
) COMMENT 'Detailed operational profile of a manufacturing facility associated with a vendor, capturing factory name, physical address, country, region, factory type (Cut-Make-Trim, Full Package, Knitting, Weaving, Dyeing, Finishing, Embroidery), production capacity (units/month), number of production lines, workforce headcount, floor area (sqm), machinery types, product categories manufactured, gender specialization (menswear/womenswear/kidswear), minimum order quantity (MOQ), lead time (days), shift structure, and operational status. Distinct from the vendor legal entity — one vendor may operate multiple factories.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`supplier`.`vendor_contact` (
    `vendor_contact_id` BIGINT COMMENT 'Unique identifier for the vendor contact person. Primary key.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Each vendor contact has an internal relationship owner (buyer, sourcing manager, QA lead) responsible for coordination, communication, and issue resolution. Essential for vendor management workflows, ',
    `supplier_factory_id` BIGINT COMMENT 'Foreign key linking to supplier.supplier_factory. Business justification: Vendor contacts can be factory-specific (factory manager, production planner, QC supervisor) or vendor-level (corporate procurement, finance). Currently vendor_contact only has vendor_id. Adding facto',
    `vendor_id` BIGINT COMMENT 'Identifier of the vendor or supplier organization this contact is associated with. Links to the vendor master record.',
    `authorization_level` STRING COMMENT 'Level of decision-making authority the contact has within the vendor organization (e.g., Operational, Managerial, Executive). Used to determine appropriate escalation paths and approval workflows.',
    `certification_credentials` STRING COMMENT 'Professional certifications or credentials held by the contact relevant to their role (e.g., WRAP Auditor, GOTS Certified, Six Sigma Black Belt, ISO 9001 Lead Auditor). Supports compliance verification and quality assurance.',
    `contact_first_name` STRING COMMENT 'First name or given name of the vendor contact person.',
    `contact_full_name` STRING COMMENT 'Full legal name of the vendor contact person, including first name, middle name, and last name.',
    `contact_last_name` STRING COMMENT 'Last name or family name of the vendor contact person.',
    `contact_status` STRING COMMENT 'Current lifecycle status of the vendor contact record. Indicates whether the contact is actively engaged, temporarily unavailable, or no longer with the vendor organization.. Valid values are `Active|Inactive|On Leave|Terminated|Transferred`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this vendor contact record was first created in the system. Used for audit trails and data lineage tracking.',
    `department` STRING COMMENT 'Department or functional area within the vendor organization where the contact works (e.g., Sales, Quality Assurance, Compliance, Logistics, Finance, Production).',
    `effective_end_date` DATE COMMENT 'Date when this contact persons role ended or they ceased to be the designated contact. Null if the contact is currently active. Used for contact history tracking and audit trails.',
    `effective_start_date` DATE COMMENT 'Date when this contact person began their role with the vendor or became the designated contact for this business relationship. Used for contact history tracking and audit trails.',
    `email_address` STRING COMMENT 'Primary business email address of the vendor contact person. Used for official communications, purchase orders, and compliance documentation.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `emergency_contact_number` STRING COMMENT 'Emergency contact phone number for urgent situations requiring immediate vendor response, such as production issues, quality failures, or compliance incidents.',
    `is_active` BOOLEAN COMMENT 'Boolean flag indicating whether this contact is currently active and should be used for communications. True if active, False if inactive or no longer with the vendor organization.',
    `is_primary_contact` BOOLEAN COMMENT 'Boolean flag indicating whether this contact is the primary point of contact for the vendor. True if primary, False otherwise. Only one primary contact should exist per vendor per role type.',
    `job_title` STRING COMMENT 'Official job title or position of the contact within the vendor organization (e.g., Account Manager, Quality Control Manager, Compliance Officer, Production Coordinator).',
    `language_preference` STRING COMMENT 'Primary language(s) spoken by the contact for business communications. Supports multilingual vendor management and reduces miscommunication risk. Use ISO 639-1 two-letter codes (e.g., EN, ZH, ES, FR, IT, PT, DE, JA, KO, VI, BN, HI).',
    `last_contact_date` DATE COMMENT 'Date of the most recent communication or interaction with this vendor contact. Used for relationship management and engagement tracking.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this vendor contact record was last updated or modified. Used for audit trails, change tracking, and data quality monitoring.',
    `mobile_number` STRING COMMENT 'Mobile phone number of the vendor contact person for urgent communications and field coordination.',
    `notes` STRING COMMENT 'Free-text field for additional notes, comments, or context about the vendor contact. May include communication preferences, special instructions, relationship history, or other relevant information.',
    `office_location` STRING COMMENT 'Physical office location or site where the contact is based within the vendor organization (e.g., factory name, office branch, city). Used for site visit planning and logistics coordination.',
    `phone_number` STRING COMMENT 'Primary business phone number of the vendor contact person, including country code and extension if applicable.',
    `preferred_communication_channel` STRING COMMENT 'The contacts preferred method of communication for routine business interactions. Used to optimize communication effectiveness and response times.. Valid values are `Email|Phone|WhatsApp|WeChat|Video Call|In-Person`',
    `reporting_manager_name` STRING COMMENT 'Name of the contacts direct manager or supervisor within the vendor organization. Used for escalation paths and organizational context.',
    `role_type` STRING COMMENT 'Standardized role classification indicating the primary function of the contact in the vendor relationship. Used for routing communications and workflow assignments.. Valid values are `Account Manager|QC Liaison|Compliance Officer|Logistics Coordinator|Finance Contact|Production Manager`',
    `specialization_area` STRING COMMENT 'Specific area of expertise or specialization of the contact within their role (e.g., Fabric Sourcing, Garment Construction, Chemical Compliance, Export Documentation, Quality Testing). Used for routing specialized inquiries.',
    `time_zone` STRING COMMENT 'Time zone of the vendor contacts primary work location. Used for scheduling meetings and coordinating communications across global supply chains. Use IANA time zone database format (e.g., Asia/Shanghai, America/New_York, Europe/London).',
    `wechat_handle` STRING COMMENT 'WeChat contact identifier or username used for instant messaging communication with the vendor contact, commonly used for China-based suppliers.',
    `whatsapp_handle` STRING COMMENT 'WhatsApp contact identifier (typically phone number) used for instant messaging communication with the vendor contact, commonly used in international sourcing operations.',
    `years_of_experience` STRING COMMENT 'Number of years of professional experience the contact has in their field or role. Used for assessing vendor capability and relationship strength.',
    CONSTRAINT pk_vendor_contact PRIMARY KEY(`vendor_contact_id`)
) COMMENT 'Individual contact persons associated with a vendor or factory, capturing full name, job title, department, email, phone, WhatsApp/WeChat handle, preferred communication channel, language, role type (Account Manager, QC Liaison, Compliance Officer, Logistics Coordinator, Finance Contact), primary contact flag, and active status. Supports multi-contact management per vendor for sourcing, production, compliance, and logistics workflows.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`supplier`.`vendor_bank_account` (
    `vendor_bank_account_id` BIGINT COMMENT 'Unique identifier for the vendor bank account record. Primary key.',
    `vendor_id` BIGINT COMMENT 'Reference to the vendor or supplier that owns this bank account. Links to the vendor master record.',
    `account_currency_code` STRING COMMENT 'Three-letter ISO currency code for the bank account. Determines the settlement currency for payments and impacts foreign exchange requirements.. Valid values are `^[A-Z]{3}$`',
    `account_holder_name` STRING COMMENT 'Legal name of the account holder as registered with the bank. Must match vendor legal name for payment processing and compliance verification.',
    `account_number` STRING COMMENT 'Bank account number for the vendor. Format varies by country and banking system. Used for domestic and international payment processing.',
    `account_status` STRING COMMENT 'Current lifecycle status of the vendor bank account. Active accounts are eligible for payment processing; inactive/suspended/closed accounts are blocked from new payments.. Valid values are `active|inactive|suspended|pending_verification|closed`',
    `account_type` STRING COMMENT 'Type of bank account (checking, savings, current, business, escrow). Determines payment processing rules and settlement timing.. Valid values are `checking|savings|current|business|escrow|other`',
    `bank_address` STRING COMMENT 'Full address of the bank branch or headquarters. Required for international payment routing and compliance documentation.',
    `bank_branch_code` STRING COMMENT 'Branch identifier or sort code used for domestic payment routing. Format varies by country (e.g., UK sort code, Indian IFSC code).',
    `bank_branch_name` STRING COMMENT 'Name of the specific bank branch where the account is held. Used for domestic payment routing and vendor communication.',
    `bank_country_code` STRING COMMENT 'Three-letter ISO country code of the banks domicile. Critical for cross-border payment routing, foreign exchange, and compliance with international sanctions and trade regulations.. Valid values are `^[A-Z]{3}$`',
    `bank_name` STRING COMMENT 'Full name of the financial institution holding the account. Used for payment routing and vendor master data management.',
    `beneficiary_address` STRING COMMENT 'Full address of the account beneficiary. Required for international wire transfers and compliance with anti-money laundering (AML) regulations.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this bank account record was first created in the system. Used for audit trails and data lineage tracking.',
    `effective_end_date` DATE COMMENT 'Date after which this bank account is no longer valid for payment processing. Null indicates an open-ended account. Used for account lifecycle management and historical tracking.',
    `effective_start_date` DATE COMMENT 'Date from which this bank account becomes effective for payment processing. Supports time-based account activation and vendor onboarding workflows.',
    `external_reference_code` STRING COMMENT 'External identifier for this bank account in the source system or vendor portal. Used for cross-system reconciliation and data integration.',
    `iban` STRING COMMENT 'International Bank Account Number for cross-border payments within SEPA and other regions. Standardized format for international payment routing.. Valid values are `^[A-Z]{2}[0-9]{2}[A-Z0-9]+$`',
    `intermediary_bank_name` STRING COMMENT 'Name of the intermediary or correspondent bank used for routing international payments when direct settlement is not available. Common in cross-border transactions.',
    `intermediary_bank_swift_code` STRING COMMENT 'SWIFT/BIC code of the intermediary bank. Required for routing payments through correspondent banking networks in international transactions.. Valid values are `^[A-Z]{4}[A-Z]{2}[A-Z0-9]{2}([A-Z0-9]{3})?$`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this bank account record was last updated. Used for change tracking, audit trails, and data synchronization.',
    `last_payment_amount` DECIMAL(18,2) COMMENT 'Amount of the most recent payment processed to this bank account in the account currency. Used for payment pattern analysis and fraud detection.',
    `last_payment_date` DATE COMMENT 'Date of the most recent payment processed to this bank account. Used for account activity monitoring and dormant account identification.',
    `lc_expiry_date` DATE COMMENT 'Expiration date of the current Letter of Credit arrangement for this vendor account. After this date, a new LC must be issued for continued payment processing.',
    `lc_issuing_bank` STRING COMMENT 'Name of the bank that issues Letters of Credit on behalf of the buyer (Apparel Fashion) for payments to this vendor. Required when LC payment method is used.',
    `lc_required_flag` BOOLEAN COMMENT 'Indicates whether a Letter of Credit is required for payments to this vendor account. True if LC is mandatory for trade finance compliance or vendor risk mitigation.',
    `lc_terms` STRING COMMENT 'Specific terms and conditions governing Letter of Credit issuance for this vendor, including sight/usance terms, document requirements, and negotiation conditions.',
    `modified_by_user` STRING COMMENT 'User ID or name of the person who last modified this bank account record. Used for audit trails and accountability in vendor master data management.',
    `payment_method` STRING COMMENT 'Preferred payment method for this account: Wire Transfer, ACH (Automated Clearing House), SEPA (Single Euro Payments Area), TT (Telegraphic Transfer), LC (Letter of Credit), Check, or EFT (Electronic Funds Transfer). Determines payment processing workflow and timing. [ENUM-REF-CANDIDATE: wire|ach|sepa|tt|lc|check|eft — 7 candidates stripped; promote to reference product]',
    `payment_priority` STRING COMMENT 'Priority ranking for this bank account when multiple accounts exist for a vendor. Lower numbers indicate higher priority. Used by AP automation to select payment account.',
    `payment_terms` STRING COMMENT 'Negotiated payment terms for this vendor account (e.g., Net 30, Net 60, Net 90, FOB, LDP, 2/10 Net 30). Defines when payment is due relative to invoice date or shipment.',
    `primary_account_flag` BOOLEAN COMMENT 'Indicates whether this is the primary/default bank account for the vendor. True if this account should be used by default for payment processing when multiple accounts exist.',
    `routing_number` STRING COMMENT 'ABA routing number for US domestic payments (ACH and wire transfers). Nine-digit code identifying the financial institution.. Valid values are `^[0-9]{9}$`',
    `source_system` STRING COMMENT 'Name of the source system from which this bank account record originated (e.g., SAP S/4HANA FI, Oracle Financials, vendor portal). Used for data lineage and integration troubleshooting.',
    `special_instructions` STRING COMMENT 'Free-text field for special payment instructions, reference requirements, or handling notes specific to this bank account. Used by AP processors for payment execution.',
    `swift_code` STRING COMMENT 'SWIFT/BIC code identifying the bank for international wire transfers. 8 or 11 character code used for cross-border payment routing.. Valid values are `^[A-Z]{4}[A-Z]{2}[A-Z0-9]{2}([A-Z0-9]{3})?$`',
    `tax_id_number` STRING COMMENT 'Tax identification number associated with this bank account (e.g., EIN, VAT number, TIN). Required for tax reporting (1099, withholding) and compliance with international tax regulations.',
    `verification_date` DATE COMMENT 'Date when the bank account was successfully verified. Used for audit trails and periodic re-verification scheduling per compliance policies.',
    `verification_method` STRING COMMENT 'Method used to verify the bank account: micro-deposit test transactions, document review (bank statement/voided check), third-party verification service, manual verification, or bank letter confirmation.. Valid values are `micro_deposit|document_review|third_party|manual|bank_letter`',
    `verification_status` STRING COMMENT 'Status of bank account verification process. Verified accounts have passed validation checks (micro-deposits, document review, third-party verification). Required for payment processing compliance.. Valid values are `verified|unverified|pending|failed`',
    CONSTRAINT pk_vendor_bank_account PRIMARY KEY(`vendor_bank_account_id`)
) COMMENT 'Banking and payment settlement details for vendors, including bank name, bank country, account holder name, IBAN/account number, SWIFT/BIC code, routing number, currency, payment method (Wire/ACH/LC/TT), Letter of Credit (LC) terms, LC issuing bank, LC expiry date, preferred payment terms (Net 30/60/90, FOB, LDP), and account verification status. Critical for AP processing, LC issuance, and cross-border payment compliance. Owned by the supplier domain as part of vendor master.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`supplier`.`supplier_factory_certification` (
    `supplier_factory_certification_id` BIGINT COMMENT 'Unique identifier for the factory certification record. Primary key.',
    `compliance_certification_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_certification. Business justification: Factory certifications must reference master compliance_certification records for centralized certificate lifecycle management, expiry tracking, and audit coordination. Sourcing teams verify factory c',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Certification costs (audit fees, renewal fees, corrective action expenses) are allocated to responsible compliance cost centers. Standard practice for compliance program cost tracking.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Certification expenses must be posted to specific GL accounts for financial reporting. Required for accurate classification of compliance costs in P&L and balance sheet.',
    `production_factory_id` BIGINT COMMENT 'Identifier of the factory or manufacturing facility that holds this certification. Links to the factory master data.',
    `accreditation_body` STRING COMMENT 'Name of the national or international accreditation body that accredits the certifying body (e.g., ANAB, UKAS, DAkkS, CNAS). Provides additional assurance of the certifying bodys competence.',
    `audit_date` DATE COMMENT 'Date on which the most recent certification audit was conducted at the factory. Format: yyyy-MM-dd.',
    `audit_grade` STRING COMMENT 'Grade or rating assigned during the certification audit. A indicates excellent compliance with no major findings. B indicates good compliance with minor findings. C indicates acceptable compliance with moderate findings requiring corrective action. D indicates poor compliance with major findings. Not Graded indicates the certification does not use a grading system.. Valid values are `A|B|C|D|Not Graded`',
    `audit_report_url` STRING COMMENT 'URL or file path to the detailed audit report document. Contains findings, observations, and recommendations from the certification audit.',
    `certificate_document_url` STRING COMMENT 'URL or file path to the digital copy of the certification certificate document stored in the document management system or cloud storage. Used for verification and audit trail purposes.',
    `certification_cost` DECIMAL(18,2) COMMENT 'Total cost incurred for obtaining or renewing the certification, including audit fees, consulting fees, and administrative costs. Expressed in the companys reporting currency.',
    `certification_cost_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the certification cost (e.g., USD, EUR, GBP, CNY).. Valid values are `^[A-Z]{3}$`',
    `certification_level` STRING COMMENT 'Level or tier of certification achieved, if the certification standard has multiple levels (e.g., Gold, Silver, Bronze, Level 1, Level 2). Null if the certification does not have levels.',
    `compliance_score` DECIMAL(18,2) COMMENT 'Numerical compliance score assigned during the audit, typically expressed as a percentage (0.00 to 100.00). Higher scores indicate better compliance with certification standards. Null if the certification does not use numerical scoring.',
    `corrective_action_due_date` DATE COMMENT 'Deadline by which corrective actions must be completed and verified. Format: yyyy-MM-dd. Null if no corrective actions are required.',
    `corrective_action_required_flag` BOOLEAN COMMENT 'Boolean flag indicating whether corrective actions are required to address audit findings. True if corrective action plan (CAP) is required. False if no corrective actions are needed.',
    `corrective_action_status` STRING COMMENT 'Current status of the corrective action plan. Not required indicates no corrective actions are needed. Pending indicates corrective actions have been identified but not yet started. In progress indicates corrective actions are being implemented. Completed indicates corrective actions have been implemented and are awaiting verification. Verified indicates corrective actions have been verified by the certifying body. Overdue indicates corrective actions have not been completed by the due date.. Valid values are `not_required|pending|in_progress|completed|verified|overdue`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this certification record was first created in the system. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX. Used for audit trail and data lineage.',
    `esg_reporting_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this certification is included in Environmental, Social, and Governance (ESG) reporting and sustainability disclosures. True if included in ESG reporting. False otherwise.',
    `geographic_scope` STRING COMMENT 'Geographic coverage of the certification, indicating which factory locations or sites are covered (e.g., Main facility only, All production sites, Facility A and Facility B). Relevant for multi-site certifications.',
    `major_findings_count` STRING COMMENT 'Number of major non-conformities or critical findings identified during the certification audit. Major findings typically require immediate corrective action and may impact certification status.',
    `minor_findings_count` STRING COMMENT 'Number of minor non-conformities or observations identified during the certification audit. Minor findings require corrective action but do not immediately threaten certification status.',
    `next_audit_date` DATE COMMENT 'Scheduled date for the next surveillance or recertification audit. Format: yyyy-MM-dd. Null if not yet scheduled.',
    `notes` STRING COMMENT 'Free-text field for additional notes, comments, or context about the certification, audit findings, or corrective actions. Used for internal documentation and knowledge sharing.',
    `product_category_scope` STRING COMMENT 'Specific product categories or types covered by the certification (e.g., Woven apparel, Knit garments, Footwear, Accessories). Indicates which product lines are certified.',
    `public_disclosure_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this certification is publicly disclosed on the companys website or in sustainability reports. True if publicly disclosed. False if confidential.',
    `renewal_initiated_date` DATE COMMENT 'Date on which the certification renewal process was formally initiated. Format: yyyy-MM-dd. Null if renewal has not been initiated.',
    `renewal_status` STRING COMMENT 'Status of the certification renewal process. Not due indicates renewal is not yet required. Renewal initiated indicates renewal process has been started. Renewal in progress indicates renewal audit or documentation review is underway. Renewal completed indicates certification has been successfully renewed. Renewal failed indicates renewal was not successful and certification may expire or be revoked.. Valid values are `not_due|renewal_initiated|renewal_in_progress|renewal_completed|renewal_failed`',
    `risk_rating` STRING COMMENT 'Risk rating assigned to the factory based on certification status and audit findings. Low indicates minimal compliance risk. Medium indicates moderate risk requiring monitoring. High indicates significant risk requiring immediate attention. Critical indicates severe risk that may result in supplier disqualification.. Valid values are `low|medium|high|critical`',
    `scope_of_certification` STRING COMMENT 'Detailed description of the scope and coverage of the certification, including specific product categories, processes, or facilities covered (e.g., Cut-Make-Trim operations for woven garments, Dyeing and finishing of cotton fabrics, Full manufacturing facility including warehousing).',
    `source_system` STRING COMMENT 'Name of the source operational system from which this certification record originated (e.g., Infor PLM, SAP S/4HANA MM, Centric PLM, Manual Entry). Used for data lineage and troubleshooting.',
    `source_system_code` STRING COMMENT 'Unique identifier of this certification record in the source operational system. Used for data reconciliation and traceability back to the source system.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this certification record was last updated in the system. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX. Used for audit trail and change tracking.',
    CONSTRAINT pk_supplier_factory_certification PRIMARY KEY(`supplier_factory_certification_id`)
) COMMENT 'Tracks all compliance certifications and ethical manufacturing accreditations held by a factory, including certification type (WRAP, FLA, GOTS, OEKO-TEX Standard 100, BCI, ISO 9001, ISO 14001, ISO 45001, SA8000, BSCI, Sedex/SMETA), certifying body, certificate number, issue date, expiry date, scope of certification, audit grade (A/B/C/D), corrective action required flag, certificate document URL, and renewal status. Enables compliance tracking against FTC, CPSC, and ESG reporting obligations.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`supplier`.`compliance_audit` (
    `compliance_audit_id` BIGINT COMMENT 'Unique identifier for the compliance audit record. Primary key for the compliance audit entity.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Internal employee coordinates audit scheduling, accompanies auditors, manages corrective action plan follow-up, and tracks remediation. Required for compliance reporting, audit calendar management, an',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Audit costs (auditor fees, travel, certification) are allocated to responsible cost centers for departmental expense tracking and budget management. Standard practice in apparel compliance operations.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Audit expenses must be posted to specific GL accounts (professional fees, compliance costs) for financial reporting and P&L classification. Required for accurate COGS and SG&A allocation.',
    `supplier_factory_id` BIGINT COMMENT 'Foreign key linking to supplier.supplier_factory. Business justification: Compliance audits (WRAP, FLA, social responsibility) are conducted at factory level, not vendor corporate level. Currently compliance_audit only has vendor_id. Adding factory_id links the audit to the',
    `vendor_id` BIGINT COMMENT 'Reference to the supplier or factory that was audited. Links to the supplier master data.',
    `announced_flag` BOOLEAN COMMENT 'Boolean indicator of whether the audit was announced to the supplier in advance. True indicates the supplier was notified ahead of time; False indicates an unannounced surprise audit.',
    `audit_cost_amount` DECIMAL(18,2) COMMENT 'Total cost incurred for conducting the audit, including auditor fees, travel expenses, and certification body charges. Expressed in the companys reporting currency.',
    `audit_cost_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the audit cost amount (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `audit_date` DATE COMMENT 'The date when the on-site audit was conducted or completed. This is the principal business event date for the audit.',
    `audit_duration_days` DECIMAL(18,2) COMMENT 'Total number of days spent conducting the on-site audit fieldwork. Includes partial days represented as decimals (e.g., 2.5 days).',
    `audit_end_date` DATE COMMENT 'The date when the audit fieldwork concluded. For multi-day audits, this represents the last day of on-site inspection.',
    `audit_framework` STRING COMMENT 'The compliance standard or framework against which the audit was conducted. Examples include FLA Workplace Code of Conduct, WRAP 12 Principles, BSCI Code of Conduct, Sedex SMETA, GOTS, OEKO-TEX Standard 100, ISO 14001, SA8000.',
    `audit_grade` STRING COMMENT 'Letter grade or categorical rating assigned to the factory based on audit performance. Grading systems vary by certification body and audit framework. [ENUM-REF-CANDIDATE: A|B|C|D|F|Pass|Conditional Pass|Fail|Gold|Silver|Bronze — 11 candidates stripped; promote to reference product]',
    `audit_number` STRING COMMENT 'Externally-known unique audit reference number assigned by the auditing organization or internal compliance team.. Valid values are `^[A-Z0-9]{8,20}$`',
    `audit_report_url` STRING COMMENT 'URL or file path to the full audit report document stored in the document management system. Provides access to detailed findings, evidence, and recommendations.',
    `audit_start_date` DATE COMMENT 'The date when the audit fieldwork began. For multi-day audits, this represents the first day of on-site inspection.',
    `audit_status` STRING COMMENT 'Current lifecycle status of the audit. Scheduled indicates the audit is planned but not yet started; In Progress indicates the audit is currently being conducted; Completed indicates the audit has been finalized and report issued; Cancelled indicates the audit was cancelled before completion; Pending Review indicates the audit is complete but awaiting final approval.. Valid values are `Scheduled|In Progress|Completed|Cancelled|Pending Review`',
    `audit_type` STRING COMMENT 'Classification of the audit based on its focus area. Social Compliance covers labor practices and working conditions; Environmental covers sustainability and environmental impact; Quality covers product quality systems; Fire Safety covers fire prevention and emergency preparedness; Chemical REACH covers chemical safety and REACH compliance; Structural Safety covers building and facility structural integrity.. Valid values are `Social Compliance|Environmental|Quality|Fire Safety|Chemical REACH|Structural Safety`',
    `auditing_firm` STRING COMMENT 'Name of the third-party auditing organization or certification body that conducted the audit. Examples include Bureau Veritas, SGS, Intertek, UL, TUV. Null if the audit was conducted by internal compliance team.',
    `auditor_name` STRING COMMENT 'Full name of the lead auditor who conducted the compliance audit. May be an internal compliance officer or external third-party auditor.',
    `cap_approved_flag` BOOLEAN COMMENT 'Boolean indicator of whether the submitted Corrective Action Plan has been reviewed and approved by the compliance team or auditing body. True indicates approval; False indicates rejection or pending review.',
    `cap_due_date` DATE COMMENT 'The deadline by which the supplier must submit a formal Corrective Action Plan addressing all identified non-conformances. Null if no CAP is required.',
    `cap_required_flag` BOOLEAN COMMENT 'Boolean indicator of whether a formal Corrective Action Plan is required from the supplier to address identified non-conformances. True indicates CAP is mandatory; False indicates no CAP required (typically for audits with no significant findings).',
    `cap_submitted_date` DATE COMMENT 'The date when the supplier submitted their Corrective Action Plan in response to audit findings. Null if CAP has not yet been submitted or is not required.',
    `certification_body` STRING COMMENT 'Name of the accredited certification body issuing the compliance certificate or audit credential. Relevant for WRAP, FLA, GOTS, OEKO-TEX, BSCI, and Sedex audits.',
    `certification_valid_from_date` DATE COMMENT 'The effective start date of the compliance certification issued as a result of this audit. Applicable for certification audits (WRAP, FLA, GOTS, OEKO-TEX). Null for non-certification audits.',
    `certification_valid_until_date` DATE COMMENT 'The expiration date of the compliance certification issued as a result of this audit. Applicable for certification audits (WRAP, FLA, GOTS, OEKO-TEX). Null for non-certification audits.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this compliance audit record was first created in the system.',
    `critical_ncr_count` STRING COMMENT 'Number of critical non-conformances identified during the audit. Critical NCRs represent severe violations that pose immediate risk to worker safety, health, or fundamental rights (e.g., child labor, forced labor, unsafe structural conditions).',
    `factory_score` DECIMAL(18,2) COMMENT 'Overall numerical score assigned to the factory based on audit findings. Scoring scale varies by audit framework (e.g., 0-100 for some frameworks, A-F letter grades converted to numeric for others). Higher scores indicate better compliance.',
    `final_audit_status` STRING COMMENT 'The final outcome determination of the audit after all reviews and corrective actions. Pass indicates full compliance; Conditional Pass indicates compliance with minor issues requiring monitoring; Fail indicates non-compliance requiring immediate action; Pending Corrective Action indicates awaiting CAP implementation; Certification Granted/Denied applies to certification audits.. Valid values are `Pass|Conditional Pass|Fail|Pending Corrective Action|Certification Granted|Certification Denied`',
    `findings_summary` STRING COMMENT 'High-level narrative summary of the key audit findings, including strengths, weaknesses, and areas of concern identified during the inspection. Provides context for the numerical scores and NCR counts.',
    `major_ncr_count` STRING COMMENT 'Number of major non-conformances identified during the audit. Major NCRs represent significant violations of compliance standards that require corrective action but do not pose immediate critical risk.',
    `management_interviews_count` STRING COMMENT 'Number of factory management personnel interviewed during the audit to assess management systems, policies, and commitment to compliance.',
    `minor_ncr_count` STRING COMMENT 'Number of minor non-conformances identified during the audit. Minor NCRs represent less severe violations or areas for improvement that do not significantly impact compliance status.',
    `next_audit_due_date` DATE COMMENT 'The scheduled date for the next periodic compliance audit of this supplier. Audit frequency is typically annual or biennial depending on risk profile and certification requirements.',
    `notes` STRING COMMENT 'Free-text field for additional comments, observations, or context related to the audit that do not fit into structured fields. May include special circumstances, follow-up actions, or stakeholder communications.',
    `reaudit_due_date` DATE COMMENT 'The scheduled date for the follow-up re-audit to verify corrective action implementation. Null if no re-audit is required.',
    `reaudit_required_flag` BOOLEAN COMMENT 'Boolean indicator of whether a follow-up re-audit is required to verify that corrective actions have been implemented and non-conformances have been resolved. True indicates re-audit is mandatory; False indicates no re-audit needed.',
    `risk_rating` STRING COMMENT 'Overall risk classification assigned to the supplier based on audit findings. Used to determine monitoring frequency and sourcing decisions. Low indicates minimal compliance risk; Critical indicates severe risk requiring immediate action or potential delisting.. Valid values are `Low|Medium|High|Critical`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this compliance audit record was last modified in the system.',
    `worker_interviews_count` STRING COMMENT 'Number of factory workers interviewed during the audit as part of the social compliance assessment. Worker interviews are a key component of FLA, WRAP, and BSCI audits.',
    CONSTRAINT pk_compliance_audit PRIMARY KEY(`compliance_audit_id`)
) COMMENT 'Records of factory compliance and social responsibility audits conducted by internal teams, third-party auditors, or certification bodies. Captures audit type (Social Compliance, Environmental, Quality, Fire Safety, Chemical/REACH), audit date, auditor name, auditing firm, factory score, findings summary, number of critical/major/minor non-conformances (NCRs), corrective action plan (CAP) required flag, CAP due date, re-audit required flag, and final audit status (Pass/Conditional Pass/Fail). Supports FLA, WRAP, BSCI, and Sedex audit workflows.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`supplier`.`supplier_audit_finding` (
    `supplier_audit_finding_id` BIGINT COMMENT 'Unique identifier for the supplier audit finding record. Primary key for the supplier audit finding entity.',
    `compliance_audit_id` BIGINT COMMENT 'Reference to the parent compliance or quality audit during which this finding was identified.',
    `actual_closure_date` DATE COMMENT 'Actual date when the corrective action was completed, verified, and the finding was formally closed. Null if the finding remains open.',
    `auditor_notes` STRING COMMENT 'Additional notes, observations, or context provided by the auditor regarding the finding, including mitigating factors, supplier cooperation, or special circumstances.',
    `business_impact` STRING COMMENT 'Description of the potential or actual business impact of the finding, including production delays, quality issues, regulatory penalties, reputational risk, or supply chain disruption.',
    `closure_status` STRING COMMENT 'Current status of the finding in the corrective action lifecycle. Open: newly identified, action not started. In Progress: corrective action underway. Pending Verification: action completed, awaiting verification. Closed: verified and accepted. Overdue: past target closure date without completion.. Valid values are `Open|In Progress|Pending Verification|Closed|Overdue`',
    `corrective_action_required` STRING COMMENT 'Detailed description of the corrective action plan (CAP) required to remediate the finding, including specific steps, process changes, training requirements, or infrastructure improvements needed.',
    `cost_to_remediate` DECIMAL(18,2) COMMENT 'Estimated or actual cost incurred by the supplier to implement the corrective action and remediate the finding, including infrastructure upgrades, training, process changes, or equipment purchases.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this supplier audit finding record was first created in the system, following the format yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the cost to remediate amount, such as USD, EUR, CNY, or INR.. Valid values are `^[A-Z]{3}$`',
    `escalation_date` DATE COMMENT 'Date when the finding was escalated to higher management levels or external stakeholders for intervention or decision-making.',
    `escalation_flag` BOOLEAN COMMENT 'Boolean indicator (True/False) identifying whether this finding has been escalated to senior management, legal, or executive leadership due to severity, regulatory risk, or failure to remediate within agreed timelines.',
    `evidence_document_url` STRING COMMENT 'URL or file path to supporting evidence documentation for the finding, including photographs, audit reports, corrective action plans, or verification records stored in the document management system.. Valid values are `^https?://.*$`',
    `finding_category` STRING COMMENT 'Primary classification of the non-conformance finding based on the compliance domain. Categories include Labor (working conditions, child labor, forced labor), Health & Safety (workplace safety, PPE, ergonomics), Environmental (waste management, emissions, water usage), Chemical (restricted substances, OEKO-TEX compliance), Fire Safety (exits, extinguishers, evacuation plans), and Wages (minimum wage, overtime pay, payroll records).. Valid values are `Labor|Health & Safety|Environmental|Chemical|Fire Safety|Wages`',
    `finding_description` STRING COMMENT 'Detailed narrative description of the non-conformance finding, including specific observations, conditions found, and evidence collected during the audit.',
    `finding_identified_date` DATE COMMENT 'Date when the non-conformance finding was first identified during the audit inspection or assessment.',
    `finding_reference_number` STRING COMMENT 'Business-readable unique reference number assigned to this non-conformance finding for tracking and communication purposes.. Valid values are `^[A-Z0-9-]+$`',
    `finding_subcategory` STRING COMMENT 'Detailed subcategory or specific compliance area within the primary finding category, providing granular classification for analysis and reporting.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this supplier audit finding record was last updated or modified, following the format yyyy-MM-ddTHH:mm:ss.SSSXXX. Used for tracking changes to corrective action status, closure dates, or verification results.',
    `previous_finding_reference` STRING COMMENT 'Reference number of the previous finding if this is identified as a repeat finding, enabling linkage and trend analysis of recurring non-conformances.',
    `regulatory_reference` STRING COMMENT 'Reference to the specific regulatory requirement, standard clause, or compliance framework that was violated or not met, such as WRAP Principle 3, FLA Code Section 2.1, or OEKO-TEX Standard 100 Annex 6.',
    `repeat_finding_flag` BOOLEAN COMMENT 'Boolean indicator (True/False) identifying whether this finding is a repeat occurrence of a previously identified and closed non-conformance at the same supplier, indicating systemic compliance issues or ineffective corrective actions.',
    `responsible_party_name` STRING COMMENT 'Name of the individual or role at the supplier factory responsible for implementing the corrective action and ensuring closure of the finding.',
    `responsible_party_title` STRING COMMENT 'Job title or position of the responsible party at the supplier factory, such as Factory Manager, Compliance Officer, or Health & Safety Coordinator.',
    `risk_score` DECIMAL(18,2) COMMENT 'Quantitative risk score assigned to the finding based on severity, likelihood of recurrence, and potential business impact, used for prioritization and supplier risk assessment.',
    `root_cause_analysis` STRING COMMENT 'Analysis of the underlying root cause of the non-conformance, identifying systemic issues, process gaps, or resource constraints that led to the finding.',
    `severity_level` STRING COMMENT 'Classification of the findings severity based on risk and impact. Critical: immediate threat to worker safety or legal compliance, requires immediate action. Major: significant non-compliance requiring corrective action. Minor: low-risk non-compliance requiring improvement. Observation: opportunity for improvement without formal non-compliance.. Valid values are `Critical|Major|Minor|Observation`',
    `target_closure_date` DATE COMMENT 'Target date by which the corrective action must be completed and the finding closed, based on severity level and agreed-upon remediation timeline.',
    `verification_date` DATE COMMENT 'Date when the corrective action was verified as complete and effective by the auditor or compliance team.',
    `verification_method` STRING COMMENT 'Method used to verify completion and effectiveness of the corrective action, such as document review, on-site re-inspection, remote verification via photos/videos, or third-party audit.. Valid values are `Document Review|On-Site Inspection|Remote Verification|Third-Party Audit`',
    `verified_by` STRING COMMENT 'Name of the auditor, compliance officer, or third-party inspector who verified the corrective action completion and effectiveness.',
    CONSTRAINT pk_supplier_audit_finding PRIMARY KEY(`supplier_audit_finding_id`)
) COMMENT 'Individual non-conformance findings (NCRs) identified during a compliance or quality audit, capturing finding reference number, audit reference, finding category (Labor, Health & Safety, Environmental, Chemical, Fire Safety, Wages, Working Hours), severity level (Critical/Major/Minor/Observation), finding description, root cause, corrective action required, responsible party at factory, target closure date, actual closure date, evidence document URL, and closure status. Enables granular CAP tracking and repeat-finding analysis.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`supplier`.`capacity_profile` (
    `capacity_profile_id` BIGINT COMMENT 'Unique identifier for the capacity profile record. Primary key.',
    `season_id` BIGINT COMMENT 'Foreign key linking to merchandising.season. Business justification: Factories commit capacity by season; merchandising requires seasonal capacity visibility for buy plan feasibility assessment, vendor allocation strategy, and OTB budget validation in apparel productio',
    `supplier_factory_id` BIGINT COMMENT 'Foreign key linking to supplier.supplier_factory. Business justification: Capacity profiles are factory-specific operational commitments. Currently capacity_profile has factory_code (STRING natural key) but no FK to supplier_factory. Adding factory_id FK normalizes this rel',
    `vendor_id` BIGINT COMMENT 'Reference to the supplier or factory for which this capacity profile is defined.',
    `allocated_capacity_units` BIGINT COMMENT 'Number of units already allocated to confirmed purchase orders (PO) or production orders.',
    `available_capacity_units` BIGINT COMMENT 'Number of units still available for booking or allocation within the planning period.',
    `capacity_confirmation_date` DATE COMMENT 'Date when the factory formally confirmed or committed to this capacity allocation.',
    `capacity_risk_level` STRING COMMENT 'Risk assessment level for capacity availability based on factory performance, compliance, and external factors (low, medium, high, critical).. Valid values are `low|medium|high|critical`',
    `capacity_status` STRING COMMENT 'Current lifecycle status of the capacity profile (active, inactive, suspended, expired, pending confirmation).. Valid values are `active|inactive|suspended|expired|pending`',
    `capacity_type` STRING COMMENT 'Classification of capacity status: allocated (assigned to orders), reserved (held for future orders), available (open for booking), committed (contractually bound), or planned (forecasted).. Valid values are `allocated|reserved|available|committed|planned`',
    `capacity_unit_of_measure` STRING COMMENT 'Unit of measure used to express capacity quantities (units, pieces, pairs, dozens, cases).. Valid values are `units|pieces|pairs|dozens|cases`',
    `capacity_units_per_month` BIGINT COMMENT 'Total production capacity expressed in units per month for the specified product category and season.',
    `capacity_valid_from_date` DATE COMMENT 'Start date of the period for which this capacity profile is valid and applicable.',
    `capacity_valid_to_date` DATE COMMENT 'End date of the period for which this capacity profile is valid and applicable.',
    `compliance_certification_status` STRING COMMENT 'Current status of factory compliance certifications (WRAP, FLA, GOTS, OEKO-TEX) relevant to this capacity profile.. Valid values are `certified|pending|expired|non_compliant`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this capacity profile record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for pricing and payment transactions related to this capacity profile (e.g., USD, EUR, CNY).. Valid values are `^[A-Z]{3}$`',
    `incoterms_code` STRING COMMENT 'International Commercial Terms (Incoterms) code defining delivery and risk transfer responsibilities (e.g., FOB, CIF, DDP).. Valid values are `^(EXW|FOB|CIF|DDP|FCA|CPT|CIP|DAP|DPU)$`',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this capacity profile record was last modified or updated.',
    `lead_time_days` STRING COMMENT 'Standard production lead time in days from order placement to shipment readiness for this product category at this factory.',
    `maximum_order_quantity` BIGINT COMMENT 'Maximum number of units that can be produced in a single production run or order cycle for this product category.',
    `minimum_order_quantity` BIGINT COMMENT 'Minimum number of units required per production run or purchase order (PO) for this product category at this factory.',
    `notes` STRING COMMENT 'Free-text notes or comments regarding special conditions, constraints, or considerations for this capacity profile.',
    `otif_target_percentage` DECIMAL(18,2) COMMENT 'Target percentage for on-time and in-full delivery performance expected from this factory for this capacity profile.',
    `payment_terms_code` STRING COMMENT 'Code representing the payment terms applicable to orders placed under this capacity profile (e.g., NET30, NET60, LC90).. Valid values are `^[A-Z0-9]{2,10}$`',
    `peak_season_flag` BOOLEAN COMMENT 'Indicator whether this capacity profile represents a peak production season with higher demand and tighter lead times.',
    `planning_system_source` STRING COMMENT 'Name of the source planning system or module from which this capacity profile was created or synchronized (e.g., Anaplan, SAP PP, Oracle RMS).',
    `product_category` STRING COMMENT 'High-level product category for which capacity is allocated (apparel, footwear, accessories, athletic, lifestyle, luxury).. Valid values are `apparel|footwear|accessories|athletic|lifestyle|luxury`',
    `product_subcategory` STRING COMMENT 'Detailed product subcategory or silhouette type (e.g., t-shirts, denim, outerwear, running shoes, handbags).',
    `production_line_count` STRING COMMENT 'Number of production lines or assembly lines dedicated to this product category during the capacity period.',
    `quality_acceptance_rate` DECIMAL(18,2) COMMENT 'Historical quality acceptance rate (percentage of units passing quality inspection) for this factory and product category.',
    `reserved_capacity_units` BIGINT COMMENT 'Number of units reserved or held for anticipated orders but not yet formally allocated.',
    `shift_count` STRING COMMENT 'Number of production shifts per day (e.g., 1, 2, or 3 shifts) operating during this capacity period.',
    `utilization_percentage` DECIMAL(18,2) COMMENT 'Percentage of total capacity currently utilized, calculated as (allocated + reserved) / total capacity * 100.',
    `workforce_headcount` STRING COMMENT 'Total number of workers or operators allocated to production for this product category during the capacity period.',
    CONSTRAINT pk_capacity_profile PRIMARY KEY(`capacity_profile_id`)
) COMMENT 'Seasonal and rolling production capacity commitments at the factory level, capturing season (SS25, FW25), product category, allocated/reserved/available capacity (units/month), utilization percentage, peak season flags, lead time by product type, minimum and maximum run sizes, and capacity confirmation date. Drives OTB (Open-to-Buy) planning, production scheduling, and factory loading decisions. One factory may have multiple capacity profiles across seasons and product categories.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`supplier`.`vendor_scorecard` (
    `vendor_scorecard_id` BIGINT COMMENT 'Unique identifier for the vendor scorecard evaluation record.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Vendor management activities (evaluation, monitoring, remediation) are cost center responsibilities. Links scorecard ownership to departmental budgets for vendor management program costs.',
    `designer_id` BIGINT COMMENT 'Foreign key linking to design.designer. Business justification: Scorecards may track designer satisfaction with vendor execution of their designs - quality feedback loop where designers evaluate how well vendors realized their creative vision in production.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Scorecards are prepared by sourcing managers or quality managers who evaluate vendor performance. Needed for approval workflows, performance review meetings, and accountability. Normalizes existing ev',
    `season_id` BIGINT COMMENT 'Foreign key linking to merchandising.season. Business justification: Vendor performance is evaluated by season for tier classification, future buy plan vendor selection, and seasonal OTIF/quality trending; critical for merchandising vendor strategy and sourcing decisio',
    `supplier_factory_id` BIGINT COMMENT 'Foreign key linking to supplier.supplier_factory. Business justification: Vendor scorecards evaluate performance at both vendor and factory levels. While vendor_scorecard already has vendor_id, adding factory_id allows factory-specific performance tracking (OTIF, AQL, capac',
    `vendor_id` BIGINT COMMENT 'Identifier of the vendor or supplier being evaluated in this scorecard.',
    `approval_date` DATE COMMENT 'Date when the scorecard evaluation was formally approved by management and published for use in sourcing decisions.',
    `aql_defect_rate_percent` DECIMAL(18,2) COMMENT 'Percentage of defective units found during quality inspections based on AQL sampling standards. Lower values indicate better quality performance.',
    `capacity_utilization_percent` DECIMAL(18,2) COMMENT 'Percentage of vendor production capacity allocated to this business during the evaluation period. Indicates strategic partnership depth and allocation priority.',
    `claim_rate_percent` DECIMAL(18,2) COMMENT 'Percentage of orders resulting in quality claims, chargebacks, or Return to Vendor (RTV) actions during the evaluation period. Lower is better.',
    `comments` STRING COMMENT 'Free-text field for evaluator notes, qualitative observations, context on performance issues, or strategic commentary on vendor relationship.',
    `compliance_audit_score` DECIMAL(18,2) COMMENT 'Composite score from social compliance and labor standards audits (WRAP, FLA, BSCI, Sedex). Typically scored 0-100 or letter grade converted to numeric.',
    `cost_competitiveness_index` DECIMAL(18,2) COMMENT 'Index comparing vendor pricing against market benchmarks and peer vendors. Values above 100 indicate above-market pricing; below 100 indicates competitive pricing.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this scorecard record was first created in the system.',
    `evaluation_frequency` STRING COMMENT 'Frequency at which this vendor scorecard evaluation is conducted (monthly, quarterly, seasonal, or annual).. Valid values are `monthly|quarterly|semi-annually|annually|seasonal`',
    `evaluation_period_end_date` DATE COMMENT 'End date of the performance evaluation period for this scorecard.',
    `evaluation_period_start_date` DATE COMMENT 'Start date of the performance evaluation period for this scorecard.',
    `evaluation_status` STRING COMMENT 'Current workflow status of the scorecard evaluation. Published scorecards are finalized and used for strategic decisions.. Valid values are `draft|submitted|approved|published|archived`',
    `evaluator_role` STRING COMMENT 'Job role or title of the evaluator (e.g., Senior Sourcing Manager, Quality Assurance Director, Procurement Lead).',
    `innovation_score` DECIMAL(18,2) COMMENT 'Subjective score evaluating vendor contributions to product innovation, material development, process improvements, and value engineering initiatives.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this scorecard record was last updated or modified.',
    `lead_time_performance_days` STRING COMMENT 'Average lead time in days from purchase order issuance to delivery during the evaluation period. Shorter lead times improve supply chain agility.',
    `on_time_sample_submission_rate_percent` DECIMAL(18,2) COMMENT 'Percentage of product samples (SMS, PP samples) submitted on or before the scheduled deadline per the Time and Action (TNA) calendar.',
    `order_fill_rate_percent` DECIMAL(18,2) COMMENT 'Percentage of ordered quantity successfully fulfilled without shortages or cancellations. Measures vendor reliability and inventory management.',
    `otif_rate_percent` DECIMAL(18,2) COMMENT 'Percentage of purchase orders delivered on time and in full during the evaluation period. Key operational KPI for supply chain reliability.',
    `overall_weighted_score` DECIMAL(18,2) COMMENT 'Composite weighted score aggregating all KPI dimensions (OTIF, quality, compliance, cost, responsiveness, sustainability) per the scorecard weighting methodology. Primary ranking metric.',
    `performance_tier` STRING COMMENT 'Vendor classification tier based on overall weighted score. Preferred vendors receive priority allocation; Probation/Delisted vendors face restrictions or exit.. Valid values are `preferred|approved|conditional|probation|delisted`',
    `pp_sample_approval_rate_percent` DECIMAL(18,2) COMMENT 'Percentage of pre-production samples approved on first submission without requiring rework or resubmission. Indicates design and technical capability.',
    `previous_tier` STRING COMMENT 'Vendor performance tier from the prior evaluation period. Enables trend analysis and tier movement tracking.. Valid values are `preferred|approved|conditional|probation|delisted`',
    `recommended_action` STRING COMMENT 'Strategic sourcing recommendation based on scorecard results. Drives allocation decisions, remediation plans, or vendor exit strategies.. Valid values are `increase_allocation|maintain_allocation|reduce_allocation|remediation_plan|exit_strategy|no_action`',
    `remediation_due_date` DATE COMMENT 'Target date by which the vendor must complete remediation actions and demonstrate improvement. Null if no remediation is required.',
    `remediation_plan_required_flag` BOOLEAN COMMENT 'Indicates whether a formal corrective action or remediation plan is required due to performance deficiencies (True) or not (False).',
    `responsiveness_rating` DECIMAL(18,2) COMMENT 'Subjective rating (typically 1-5 or 1-10 scale) assessing vendor communication quality, issue resolution speed, and collaboration effectiveness.',
    `sustainability_score` DECIMAL(18,2) COMMENT 'Composite score evaluating environmental and sustainability practices including certifications (GOTS, OEKO-TEX, BCI), energy efficiency, waste management, and chemical compliance.',
    `tier_change_flag` BOOLEAN COMMENT 'Indicates whether the vendor tier changed from the previous evaluation period (True) or remained the same (False).',
    `total_po_count` STRING COMMENT 'Total number of purchase orders issued to this vendor during the evaluation period. Indicates transaction volume and relationship scale.',
    `total_po_value_usd` DECIMAL(18,2) COMMENT 'Total value in USD of all purchase orders issued to this vendor during the evaluation period. Provides spend context for performance assessment.',
    CONSTRAINT pk_vendor_scorecard PRIMARY KEY(`vendor_scorecard_id`)
) COMMENT 'Periodic performance evaluation of vendor and factory performance across operational KPIs, generated monthly/quarterly/seasonally. Captures OTIF (On-Time In-Full) rate, AQL defect rate, on-time sample submission, PP sample approval rate, compliance audit score, sustainability score, responsiveness rating, cost competitiveness index, overall weighted score, performance tier (Preferred/Approved/Conditional/Probation/Delisted), and evaluation period. Drives strategic sourcing decisions, vendor tiering, allocation preferences, and exit/remediation actions.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`supplier`.`risk_assessment` (
    `risk_assessment_id` BIGINT COMMENT 'Unique identifier for the supplier risk assessment record. Primary key.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Risk assessments are owned by compliance managers or sourcing directors responsible for mitigation strategy execution and escalation. Critical for risk governance, remediation tracking, and regulatory',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Risk assessment activities incur costs (consultant fees, mitigation expenses) allocated to responsible cost centers. Essential for risk management program cost tracking and budget accountability.',
    `production_factory_id` BIGINT COMMENT 'Reference to the specific factory or manufacturing facility being assessed, if applicable. Supports facility-level risk tracking for CMT factories, OEM/ODM partners, and mills.',
    `vendor_id` BIGINT COMMENT 'Reference to the supplier or vendor being assessed. Links to the supplier master data entity.',
    `assessment_date` DATE COMMENT 'The date on which this risk assessment was conducted or recorded.',
    `assessment_method` STRING COMMENT 'The methodology or approach used to conduct the risk assessment. Self-Assessment relies on supplier-provided information. Third-Party Audit uses independent auditors. Site Visit involves on-site inspection. Document Review analyzes certifications and records. Questionnaire uses structured surveys. Scorecard applies a standardized rating framework. Hybrid combines multiple methods. [ENUM-REF-CANDIDATE: Self-Assessment|Third-Party Audit|Site Visit|Document Review|Questionnaire|Scorecard|Hybrid — 7 candidates stripped; promote to reference product]',
    `assessment_status` STRING COMMENT 'The current workflow status of the risk assessment record. Draft indicates the assessment is being prepared. Under Review indicates it is awaiting approval. Approved indicates it has been validated and accepted. Closed indicates the risk has been resolved or is no longer relevant. Escalated indicates the risk requires senior management attention.. Valid values are `Draft|Under Review|Approved|Closed|Escalated`',
    `assessment_type` STRING COMMENT 'The type or trigger of the risk assessment. Initial assessments occur during supplier onboarding, periodic assessments follow a schedule, triggered assessments respond to specific events or incidents.. Valid values are `Initial|Periodic|Triggered|Ad-Hoc|Pre-Qualification|Re-Assessment`',
    `auditor_name` STRING COMMENT 'The name of the individual or organization that conducted the risk assessment or audit, if applicable. Supports traceability and accountability.',
    `business_impact_area` STRING COMMENT 'The primary business function or area that would be affected if the risk materializes. Supports prioritization and cross-functional risk management.. Valid values are `Revenue|Cost|Brand|Operations|Compliance|Customer Satisfaction`',
    `certification_reference` STRING COMMENT 'Reference number or identifier of any relevant certification or compliance audit that informed this risk assessment, such as WRAP, FLA, GOTS, OEKO-TEX, or ISO certifications.',
    `comments` STRING COMMENT 'Additional free-text comments, notes, or observations related to the risk assessment. Provides context and qualitative insights not captured in structured fields.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this risk assessment record was first created in the system. Supports audit trail and data lineage.',
    `escalation_date` DATE COMMENT 'The date on which this risk was escalated to senior management or a risk committee, if applicable. Tracks critical risk visibility and governance.',
    `esg_flag` BOOLEAN COMMENT 'Indicates whether this risk assessment is related to Environmental, Social, or Governance (ESG) criteria. True if the risk has ESG implications, False otherwise. Supports ESG reporting and sustainability initiatives.',
    `geographic_risk_region` STRING COMMENT 'The geographic region or country associated with this risk, if the risk is location-specific. Supports geopolitical and regional risk analysis.',
    `impact_score` STRING COMMENT 'A numeric score representing the severity of consequences if the risk materializes. Typically scored on a scale of 1 to 5, where 1 is Negligible and 5 is Catastrophic. Considers financial, operational, reputational, and compliance impacts.',
    `inherent_risk_rating` STRING COMMENT 'The overall risk level before any mitigation measures are applied. Typically derived from the combination of likelihood and impact scores. Low indicates minimal concern, Medium requires monitoring, High requires active management, and Critical demands immediate action and escalation.. Valid values are `Low|Medium|High|Critical`',
    `likelihood_score` STRING COMMENT 'A numeric score representing the probability that the risk will materialize. Typically scored on a scale of 1 to 5, where 1 is Very Unlikely and 5 is Very Likely. Used in conjunction with impact score to calculate inherent risk rating.',
    `mitigation_cost` DECIMAL(18,2) COMMENT 'The estimated or actual cost of implementing the mitigation strategy, in the companys reporting currency. Supports cost-benefit analysis and risk management budgeting.',
    `mitigation_status` STRING COMMENT 'The current implementation status of the mitigation strategy. Tracks progress from planning through execution.. Valid values are `Not Started|In Progress|Completed|On Hold|Cancelled`',
    `mitigation_strategy` STRING COMMENT 'A detailed description of the actions, controls, or measures implemented or planned to reduce the likelihood or impact of the risk. May include supplier development programs, contract clauses, diversification strategies, audits, or contingency plans.',
    `next_review_date` DATE COMMENT 'The scheduled date for the next review or reassessment of this risk. Ensures periodic monitoring and updates to risk status and mitigation effectiveness.',
    `regulatory_reference` STRING COMMENT 'Reference to any specific regulation, law, or compliance framework that this risk assessment addresses, such as FTC labeling requirements, CPSC safety standards, or GDPR data protection.',
    `residual_risk_rating` STRING COMMENT 'The risk level remaining after mitigation measures have been applied. Represents the accepted or tolerated risk level. Used to determine if additional mitigation is required or if the risk is within acceptable tolerance.. Valid values are `Low|Medium|High|Critical`',
    `resolution_date` DATE COMMENT 'The date on which the risk was resolved, closed, or deemed no longer relevant. Supports risk lifecycle tracking and historical analysis.',
    `review_frequency` STRING COMMENT 'The standard interval at which this risk should be reviewed. High and Critical risks typically require more frequent review than Low risks.. Valid values are `Monthly|Quarterly|Semi-Annually|Annually|As Needed`',
    `risk_category` STRING COMMENT 'The primary category of risk being assessed. Geopolitical includes trade restrictions and political instability. Financial covers supplier solvency and payment risk. Compliance includes labor standards, environmental regulations, and certifications. Capacity addresses production volume and lead time risk. Quality covers defect rates and product safety. Environmental includes sustainability and carbon footprint. Labor covers working conditions and fair labor practices. Logistics includes transportation and delivery risk. Currency covers foreign exchange volatility. Reputational includes brand and ethical risk. Cybersecurity covers data protection and IT security. [ENUM-REF-CANDIDATE: Geopolitical|Financial|Compliance|Capacity|Quality|Environmental|Labor|Logistics|Currency|Reputational|Cybersecurity — 11 candidates stripped; promote to reference product]',
    `risk_description` STRING COMMENT 'A detailed narrative description of the identified risk, including context, potential triggers, and specific concerns. Provides qualitative detail for risk understanding and communication.',
    `risk_subcategory` STRING COMMENT 'A more granular classification of the risk within the primary category. For example, under Compliance, subcategories might include Child Labor, Forced Labor, Wage Violations, or Chemical Safety. Allows for detailed risk taxonomy.',
    `updated_by` STRING COMMENT 'The user ID or name of the individual who last modified this risk assessment record. Supports accountability and audit trail.',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this risk assessment record was last modified. Supports audit trail and change tracking.',
    `created_by` STRING COMMENT 'The user ID or name of the individual who created this risk assessment record. Supports accountability and audit trail.',
    CONSTRAINT pk_risk_assessment PRIMARY KEY(`risk_assessment_id`)
) COMMENT 'Structured risk assessment records for vendors and factories, capturing risk assessment date, risk category (Geopolitical, Financial, Compliance, Capacity, Quality, Environmental, Labor, Logistics, Currency), risk description, likelihood score (1-5), impact score (1-5), inherent risk rating (Low/Medium/High/Critical), mitigation strategy, residual risk rating, risk owner, next review date, and assessment status. Supports supply chain resilience planning and ESG risk reporting.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`supplier`.`vendor_agreement` (
    `vendor_agreement_id` BIGINT COMMENT 'Unique identifier for the vendor agreement record. Primary key.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Contract management is a procurement cost center function. Links agreement ownership to departmental budgets for legal review, negotiation, and contract administration costs.',
    `standard_id` BIGINT COMMENT 'Foreign key linking to quality.quality_standard. Business justification: Vendor agreements must specify enforceable quality standards (ISO, ASTM, brand-specific) that suppliers must meet. The quality_standards text field is denormalized. FK to quality_standard enables auto',
    `vendor_id` BIGINT COMMENT 'Reference to the supplier or vendor party covered by this agreement.',
    `agreement_number` STRING COMMENT 'Externally-known unique business identifier for the vendor agreement, typically formatted with prefix and numeric sequence.. Valid values are `^[A-Z]{2,4}-[0-9]{6,10}$`',
    `agreement_status` STRING COMMENT 'Current lifecycle state of the vendor agreement indicating its operational validity and enforceability.. Valid values are `Draft|Active|Suspended|Expired|Terminated|Pending Approval`',
    `agreement_type` STRING COMMENT 'Classification of the vendor agreement based on the nature of the commercial relationship and scope of services or goods covered.. Valid values are `Master Supply Agreement|CMT Contract|FOB Contract|Fabric Supply Agreement|3PL SLA|OEM Agreement`',
    `amendment_count` STRING COMMENT 'Number of formal amendments or addendums executed against this agreement since its original signing.',
    `audit_frequency` STRING COMMENT 'Frequency at which the vendor is subject to compliance audits (social, environmental, quality) as stipulated in the agreement.. Valid values are `Annual|Semi-Annual|Quarterly|Ad-Hoc|Not Required`',
    `auto_renewal_flag` BOOLEAN COMMENT 'Indicates whether the agreement automatically renews at expiry unless either party provides termination notice.',
    `compliance_certifications_required` STRING COMMENT 'List of mandatory compliance certifications the vendor must maintain (e.g., WRAP, FLA, BCI, GOTS, ISO 14001, ISO 45001).',
    `confidentiality_clause_flag` BOOLEAN COMMENT 'Indicates whether the agreement includes a confidentiality or non-disclosure clause protecting proprietary business information.',
    `contract_value_total` DECIMAL(18,2) COMMENT 'Total estimated or committed contract value over the agreement term, if applicable. Nullable for open-ended or volume-based agreements.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the vendor agreement record was first created in the system.',
    `credit_limit_amount` DECIMAL(18,2) COMMENT 'Maximum outstanding payable amount allowed under this agreement before additional approvals or holds are required.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code in which financial transactions under this agreement are denominated (e.g., USD, EUR, CNY).. Valid values are `^[A-Z]{3}$`',
    `default_incoterm` STRING COMMENT 'The default Incoterm rule applied to shipments under this agreement unless otherwise specified on the purchase order (PO). Common values include FOB (Free on Board), CIF (Cost Insurance Freight), DDP (Delivered Duty Paid). [ENUM-REF-CANDIDATE: EXW|FCA|CPT|CIP|DAP|DPU|DDP|FAS|FOB|CFR|CIF — 11 candidates stripped; promote to reference product]',
    `dispute_resolution_method` STRING COMMENT 'The agreed method for resolving disputes arising under this agreement.. Valid values are `Arbitration|Mediation|Litigation|Negotiation`',
    `effective_date` DATE COMMENT 'The date from which the vendor agreement becomes legally binding and operational.',
    `exclusivity_flag` BOOLEAN COMMENT 'Indicates whether the agreement includes an exclusivity clause restricting the vendor from supplying similar goods or services to competitors.',
    `expiry_date` DATE COMMENT 'The date on which the vendor agreement terminates unless renewed. Nullable for open-ended agreements.',
    `force_majeure_clause_flag` BOOLEAN COMMENT 'Indicates whether the agreement includes a force majeure clause excusing performance due to extraordinary events beyond the parties control.',
    `governing_law_jurisdiction` STRING COMMENT 'The legal jurisdiction and governing law under which the agreement is interpreted and enforced (e.g., State of New York, England and Wales).',
    `incoterms_version` STRING COMMENT 'The version of International Commercial Terms (Incoterms) governing the delivery, risk transfer, and cost allocation for goods under this agreement.. Valid values are `Incoterms 2010|Incoterms 2020`',
    `insurance_requirements` STRING COMMENT 'Description of insurance coverage the vendor is required to maintain (e.g., general liability, product liability, workers compensation).',
    `ip_ownership_clause` STRING COMMENT 'Summary of the intellectual property ownership terms, specifying whether designs, patterns, tech packs, or product innovations remain with the buyer, vendor, or are jointly owned.',
    `last_amendment_date` DATE COMMENT 'Date of the most recent amendment or addendum to the agreement. Nullable if no amendments have been made.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the vendor agreement record was last updated in the system.',
    `liability_cap_amount` DECIMAL(18,2) COMMENT 'Maximum liability amount either party is exposed to under the agreement, excluding cases of gross negligence or willful misconduct.',
    `minimum_order_quantity` STRING COMMENT 'The minimum order quantity (MOQ) required per purchase order (PO) or per style/SKU as stipulated in the agreement.',
    `notes` STRING COMMENT 'Free-text field for additional notes, special conditions, or internal comments related to the vendor agreement.',
    `payment_method` STRING COMMENT 'The primary method of payment authorized under this agreement.. Valid values are `Wire Transfer|ACH|Check|Letter of Credit|Documentary Collection`',
    `payment_terms` STRING COMMENT 'Standard payment terms agreed with the vendor, expressed as net days or other conditions (e.g., Net 30, Net 60, 2/10 Net 30, Letter of Credit at sight).',
    `performance_bond_required_flag` BOOLEAN COMMENT 'Indicates whether the vendor is required to provide a performance bond or bank guarantee to secure contractual obligations.',
    `renewal_notice_period_days` STRING COMMENT 'Number of days advance notice required to prevent auto-renewal or to initiate renewal discussions.',
    `signatory_name_buyer` STRING COMMENT 'Name of the authorized signatory representing the buyer (Apparel Fashion) on the agreement.',
    `signatory_name_vendor` STRING COMMENT 'Name of the authorized signatory representing the vendor on the agreement.',
    `signed_date` DATE COMMENT 'The date on which the agreement was signed by authorized representatives of both parties.',
    `termination_notice_period_days` STRING COMMENT 'Number of days advance written notice required by either party to terminate the agreement.',
    CONSTRAINT pk_vendor_agreement PRIMARY KEY(`vendor_agreement_id`)
) COMMENT 'Master vendor agreements and framework contracts governing the commercial relationship with a supplier, including agreement type (Master Supply Agreement, CMT Contract, FOB Contract, Fabric Supply Agreement, 3PL SLA), agreement reference number, effective date, expiry date, auto-renewal flag, governing law jurisdiction, incoterms version, payment terms, currency, credit limit, exclusivity clause flag, IP ownership clause, termination notice period, and agreement status (Draft/Active/Expired/Terminated). SSOT for vendor contractual terms within the supplier domain.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`supplier`.`vendor_document` (
    `vendor_document_id` BIGINT COMMENT 'Unique identifier for the vendor document record. Primary key.',
    `production_factory_id` BIGINT COMMENT 'Reference to the factory or manufacturing facility associated with this document, if applicable.',
    `vendor_id` BIGINT COMMENT 'Reference to the vendor or supplier to whom this document belongs.',
    `audit_date` DATE COMMENT 'Date on which the compliance or quality audit was conducted, if the document is an audit report.',
    `audit_score` DECIMAL(18,2) COMMENT 'Numerical score assigned during a compliance or quality audit, if the document is an audit report.',
    `certification_body` STRING COMMENT 'Name of the third-party certification or auditing body that issued the compliance or quality certificate, if applicable.',
    `compliance_standard` STRING COMMENT 'Name of the compliance standard or regulatory framework that the document certifies adherence to (e.g., WRAP, FLA, GOTS, OEKO-TEX Standard 100, ISO 9001).',
    `country_of_origin` STRING COMMENT 'Three-letter ISO country code representing the country where the goods or services covered by the document originate.',
    `coverage_amount` DECIMAL(18,2) COMMENT 'Monetary coverage amount specified in the insurance certificate or liability document.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for monetary amounts specified in the document.',
    `document_file_url` STRING COMMENT 'Uniform Resource Locator pointing to the stored digital file of the document in the document management system or cloud storage.',
    `document_number` STRING COMMENT 'Unique business identifier or reference number assigned to the document by the issuing authority or vendor.',
    `document_status` STRING COMMENT 'Current lifecycle status of the document indicating its validity and verification state. [ENUM-REF-CANDIDATE: Active|Expired|Pending Verification|Verified|Rejected|Suspended|Archived — 7 candidates stripped; promote to reference product]',
    `document_title` STRING COMMENT 'Full descriptive title or name of the document as it appears on the official record.',
    `document_type` STRING COMMENT 'Classification of the document indicating its purpose and regulatory or operational category. [ENUM-REF-CANDIDATE: Business License|Factory Registration|Insurance Certificate|Lab Test Report|Material Safety Data Sheet|Social Compliance Certificate|Export License|HS Code Declaration|GSP Certificate of Origin|Letter of Credit|Bill of Lading|Audit Report|Quality Certificate|Customs Declaration — promote to reference product]',
    `expiry_date` DATE COMMENT 'Date on which the document expires and is no longer valid. Null for documents without expiration.',
    `file_format` STRING COMMENT 'Digital file format of the stored document (e.g., PDF, JPEG, PNG, DOCX). [ENUM-REF-CANDIDATE: PDF|JPEG|PNG|DOCX|XLSX|TIFF|XML — 7 candidates stripped; promote to reference product]',
    `file_size_kb` DECIMAL(18,2) COMMENT 'Size of the document file in kilobytes.',
    `gsp_eligible` BOOLEAN COMMENT 'Indicates whether the document certifies eligibility for Generalized System of Preferences tariff benefits.',
    `hs_code` STRING COMMENT 'Harmonized System code declared in the document for customs and trade classification purposes.',
    `insurance_policy_number` STRING COMMENT 'Policy number of the insurance certificate, if the document is an insurance-related record.',
    `is_active` BOOLEAN COMMENT 'Indicates whether the document record is currently active and in use within the system.',
    `issue_date` DATE COMMENT 'Date on which the document was officially issued or signed by the issuing authority.',
    `issuing_authority` STRING COMMENT 'Name of the organization, government body, or certification agency that issued or authorized the document.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when the document record was last updated or modified.',
    `lc_number` STRING COMMENT 'Reference number of the Letter of Credit associated with this document, if applicable.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next review or renewal of the document.',
    `remarks` STRING COMMENT 'Additional notes, comments, or observations related to the document, its verification, or compliance status.',
    `uploaded_by` STRING COMMENT 'Name or identifier of the user who uploaded the document to the system.',
    `uploaded_timestamp` TIMESTAMP COMMENT 'Date and time when the document was uploaded to the system.',
    `verification_date` DATE COMMENT 'Date on which the document was verified by internal compliance or procurement personnel.',
    `verification_status` STRING COMMENT 'Status indicating whether the document has been reviewed and verified by internal compliance or procurement teams.. Valid values are `Not Verified|Verified|Failed|In Review|Pending`',
    `verified_by` STRING COMMENT 'Name or identifier of the internal user or team who performed the document verification.',
    CONSTRAINT pk_vendor_document PRIMARY KEY(`vendor_document_id`)
) COMMENT 'Repository of compliance, legal, and operational documents associated with vendors and factories, including document type (Business License, Factory Registration, Insurance Certificate, Lab Test Report, Material Safety Data Sheet, Social Compliance Certificate, Export License, HS Code Declaration, GSP Certificate of Origin), document title, issuing authority, issue date, expiry date, document file URL, verification status, and linked entity (vendor or factory). Supports FTC labeling compliance, CPSC product safety, and customs documentation requirements.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`supplier`.`supplier_material_supplier` (
    `supplier_material_supplier_id` BIGINT COMMENT 'Unique identifier for the material-supplier association record in the Approved Vendor List (AVL). Primary key for this data product.',
    `material_id` BIGINT COMMENT 'Reference to the material entity being supplied. Links to the material master data product.',
    `print_design_id` BIGINT COMMENT 'Foreign key linking to design.print_design. Business justification: Material suppliers provide fabrics with specific print designs applied - links fabric sourcing to design assets for print-on-fabric procurement, strike-off approvals, and print execution quality track',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Material approvals require technical employee sign-off (product developers, technical designers, lab managers) for quality, sustainability, and performance standards. Essential for material qualificat',
    `vendor_id` BIGINT COMMENT 'Reference to the supplier entity providing this material. Links to the supplier master data product.',
    `approval_status` STRING COMMENT 'Current approval status of this supplier-material association in the AVL (Approved Vendor List). Controls whether this supplier can be used for procurement.. Valid values are `Approved|Pending|Suspended|Rejected|Under Review`',
    `approved_colorways` STRING COMMENT 'List of approved color options or colorways that this supplier is qualified to provide for this material. Supports collection planning and merchandising.',
    `capacity_per_month` DECIMAL(18,2) COMMENT 'Suppliers monthly production capacity for this material in the specified unit of measure. Used for capacity planning and allocation decisions.',
    `composition_percentage` STRING COMMENT 'Detailed percentage breakdown of material composition by component. Supports multi-component materials and blends.',
    `country_of_origin` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code indicating where this material is manufactured by this supplier. Required for customs, GSP (Generalized System of Preferences), and trade compliance.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this material-supplier association record was first created in the system. Supports audit trail and data lineage.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the unit cost (e.g., USD, EUR, CNY). Required for multi-currency procurement and LC (Letter of Credit) processing.. Valid values are `^[A-Z]{3}$`',
    `delivery_performance_rating` STRING COMMENT 'Supplier delivery performance rating based on OTIF (On Time In Full) metrics. Critical for supply chain reliability and TNA (Time and Action) planning.. Valid values are `A|B|C|D|F`',
    `effective_from_date` DATE COMMENT 'Date from which this supplier-material association and its terms (pricing, lead time, MOQ) become effective. Supports time-based supplier agreements.',
    `effective_to_date` DATE COMMENT 'Date until which this supplier-material association and its terms remain valid. Null indicates open-ended agreement. Supports contract lifecycle management.',
    `fiber_content` STRING COMMENT 'Detailed fiber composition of the material (e.g., 100% Cotton, 60% Polyester 40% Cotton). Required for FTC (Federal Trade Commission) textile labeling compliance.',
    `hs_code` STRING COMMENT 'Harmonized System Code for customs classification of this material. Required for international trade, duty calculation, and customs clearance.',
    `incoterms` STRING COMMENT 'Incoterms 2020 delivery terms defining responsibility transfer point between supplier and buyer. Critical for landed cost calculation and logistics planning. [ENUM-REF-CANDIDATE: EXW|FCA|CPT|CIP|DAP|DPU|DDP|FAS|FOB|CFR|CIF — 11 candidates stripped; promote to reference product]',
    `is_active` BOOLEAN COMMENT 'Indicates whether this material-supplier association is currently active and available for procurement. Supports soft-delete and historical record retention.',
    `is_bci_cotton` BOOLEAN COMMENT 'Indicates whether cotton content is BCI (Better Cotton Initiative) certified. Supports sustainable sourcing commitments and supply chain transparency.',
    `is_oeko_tex_certified` BOOLEAN COMMENT 'Indicates whether this material holds OEKO-TEX Standard 100 certification for textile safety. Required for certain retail partners and consumer safety compliance.',
    `is_organic` BOOLEAN COMMENT 'Indicates whether this material is certified organic. Supports sustainability reporting and GOTS (Global Organic Textile Standard) compliance.',
    `is_recycled` BOOLEAN COMMENT 'Indicates whether this material contains recycled content. Supports sustainability initiatives and circular economy reporting.',
    `last_audit_date` DATE COMMENT 'Date of the most recent compliance audit for this supplier (WRAP, FLA, GOTS, OEKO-TEX). Used to track audit currency and re-audit scheduling.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this material-supplier association record was last updated. Supports change tracking and audit trail.',
    `lead_time_days` STRING COMMENT 'Standard production and delivery lead time in days from PO (Purchase Order) placement to FOB (Free on Board) delivery. Used in TNA (Time and Action) calendar planning.',
    `material_type` STRING COMMENT 'Classification of the material being supplied. Categorizes the material into major supply chain categories. [ENUM-REF-CANDIDATE: Fabric|Yarn|Trim|Button|Zipper|Label|Packaging — 7 candidates stripped; promote to reference product]',
    `moq` DECIMAL(18,2) COMMENT 'Minimum Order Quantity required by the supplier for this material. Critical for procurement planning and OTB (Open-to-Buy) calculations.',
    `next_audit_due_date` DATE COMMENT 'Scheduled date for the next compliance audit of this supplier. Supports proactive compliance management and risk mitigation.',
    `notes` STRING COMMENT 'Free-text notes capturing additional context, special handling requirements, or supplier-specific considerations for this material. Supports operational knowledge capture.',
    `oeko_tex_certificate_number` STRING COMMENT 'The OEKO-TEX Standard 100 certificate number for this material, if certified. Used for audit trail and compliance verification.',
    `payment_terms` STRING COMMENT 'Negotiated payment terms for this material from this supplier (e.g., Net 30, Net 60, LC at Sight). Impacts cash flow and working capital planning.',
    `preferred_supplier_flag` BOOLEAN COMMENT 'Indicates whether this supplier is a preferred or strategic supplier for this material. Influences sourcing decisions and allocation strategies.',
    `qualification_date` DATE COMMENT 'Date when this supplier-material combination was qualified and approved for the AVL (Approved Vendor List). Establishes the start of the supplier relationship for this material.',
    `quality_rating` STRING COMMENT 'Supplier quality performance rating for this material based on defect rates, inspection results, and quality audits. Used in supplier scorecard and sourcing decisions.. Valid values are `A|B|C|D|F`',
    `risk_score` DECIMAL(18,2) COMMENT 'Composite supplier risk score for this material based on financial stability, compliance history, geopolitical factors, and operational risk. Used in supplier risk management.',
    `sample_lead_time_days` STRING COMMENT 'Lead time in days for supplier to provide material samples for approval. Critical for PP (Pre-Production) and SMS (Sample Management System) workflows.',
    `supplier_item_code` STRING COMMENT 'The suppliers internal item code or SKU (Stock Keeping Unit) for this material. Used for purchase orders and supplier communication.',
    `sustainability_attributes` STRING COMMENT 'Additional sustainability certifications or attributes for this material (e.g., Fair Trade, Cradle to Cradle, bluesign). Supports ESG (Environmental Social Governance) reporting.',
    `unit_cost` DECIMAL(18,2) COMMENT 'Cost per unit of measure for this material from this supplier, quoted FOB (Free on Board). Used for COGS (Cost of Goods Sold) calculation and costing analysis.',
    `unit_of_measure` STRING COMMENT 'Standard unit of measure for ordering and pricing this material from the supplier. Aligns with supplier purchase order terms. [ENUM-REF-CANDIDATE: Yard|Meter|Kilogram|Piece|Gross|Roll|Each — 7 candidates stripped; promote to reference product]',
    CONSTRAINT pk_supplier_material_supplier PRIMARY KEY(`supplier_material_supplier_id`)
) COMMENT 'Qualified supplier-material association linking approved raw materials, fabrics, and trims to their vetted vendor sources within the Approved Vendor List (AVL). Captures material type (Fabric, Yarn, Trim, Button, Zipper, Label, Packaging), fiber content, composition, supplier item code, UoM, MOQ, lead time, sample lead time, unit cost (FOB), currency, approved colorways, sustainability attributes (organic, recycled, BCI cotton), OEKO-TEX certification flag, qualification date, and approval status. SSOT for vendor-side material qualification and AVL maintenance. Distinct from sourcing domains material development workflow — this product records WHICH vendors are approved to supply WHICH materials after qualification is complete.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`supplier`.`delivery_schedule` (
    `delivery_schedule_id` BIGINT COMMENT 'Unique identifier for the supplier delivery schedule record. Primary key for the Time and Action (T&A) calendar tracking production milestones from design handoff to ex-factory shipment.',
    `buy_plan_id` BIGINT COMMENT 'Foreign key linking to merchandising.buy_plan. Business justification: TNA schedules must link to buy plans to track ex-factory dates against planned receipt dates; core to merchandising timeline management, OTB reconciliation, and in-store date commitments in apparel su',
    `concept_id` BIGINT COMMENT 'Foreign key linking to design.concept. Business justification: TNA schedules track production timelines from original design concept through ex-factory - links design intent to manufacturing execution for concept-to-delivery traceability and performance analysis.',
    `inspection_id` BIGINT COMMENT 'Foreign key linking to quality.inspection. Business justification: Production delivery schedules track final inspection milestones (planned/actual dates, pass/fail results). Linking to actual quality.inspection records enables drill-down from schedule variance analys',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Production schedules are managed by internal planners or merchandisers who coordinate with factories, track critical path, and escalate delays. Required for accountability, workload balancing, and per',
    `sketch_id` BIGINT COMMENT 'Foreign key linking to design.design_sketch. Business justification: Delivery schedules reference approved design sketches for production tracking - ensures manufactured goods match original design intent and enables sketch-to-shipment traceability for quality and comp',
    `style_id` BIGINT COMMENT 'Reference to the style or product design for which this T&A calendar is tracking production milestones.',
    `supplier_factory_id` BIGINT COMMENT 'Foreign key linking to supplier.supplier_factory. Business justification: Time & Action calendars are factory-specific (production happens at factories, not at vendor corporate level). Currently supplier_delivery_schedule only has vendor_id. Adding factory_id FK links the T',
    `vendor_id` BIGINT COMMENT 'Reference to the supplier or factory executing this production order. Links to the supplier master data for manufacturer profiles, CMT factories, OEM/ODM partners.',
    `work_order_id` BIGINT COMMENT 'Reference to the production order or purchase order for which this delivery schedule tracks milestones.',
    `bulk_fabric_inhouse_actual_date` DATE COMMENT 'Actual date when bulk fabric arrived at the factory.',
    `bulk_fabric_inhouse_planned_date` DATE COMMENT 'Planned date for bulk fabric to arrive at the factory and be available for cutting.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this delivery schedule record was first created in the system.',
    `critical_path_flag` BOOLEAN COMMENT 'Indicates whether this schedule is on the critical path for the collection launch or sales floor delivery. True if any delay impacts go-live date.',
    `cut_actual_date` DATE COMMENT 'Actual date when fabric cutting began.',
    `cut_planned_date` DATE COMMENT 'Planned date for fabric cutting to begin in the Cut Make Trim (CMT) process.',
    `design_approval_actual_date` DATE COMMENT 'Actual date when design was approved. Variance from planned date impacts downstream milestones.',
    `design_approval_planned_date` DATE COMMENT 'Planned date for final design approval milestone before tech pack issue.',
    `escalation_flag` BOOLEAN COMMENT 'Indicates whether this schedule has been escalated to management due to delays, quality issues, or other risks requiring intervention.',
    `escalation_reason` STRING COMMENT 'Detailed explanation of why the schedule was escalated, including specific delays, quality failures, or capacity constraints.',
    `ex_factory_actual_date` DATE COMMENT 'Actual date when finished goods left the factory. Used to calculate On Time In Full (OTIF) performance and schedule variance.',
    `ex_factory_planned_date` DATE COMMENT 'Planned date when finished goods are scheduled to leave the factory and be ready for shipment. Critical milestone for supply chain planning.',
    `fabric_booking_actual_date` DATE COMMENT 'Actual date when bulk fabric was booked.',
    `fabric_booking_planned_date` DATE COMMENT 'Planned date for booking bulk fabric with mills or suppliers.',
    `factory_capacity_utilization_pct` DECIMAL(18,2) COMMENT 'Percentage of factory capacity allocated to this production order at the time of schedule creation. Used for capacity planning and risk assessment.',
    `final_inspection_actual_date` DATE COMMENT 'Actual date when final quality inspection was completed.',
    `final_inspection_planned_date` DATE COMMENT 'Planned date for final quality inspection before shipment authorization.',
    `finishing_actual_date` DATE COMMENT 'Actual date when finishing operations were completed.',
    `finishing_planned_date` DATE COMMENT 'Planned date for completing finishing operations including pressing, tagging, and packaging.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this delivery schedule record was last modified, reflecting the most recent milestone update or status change.',
    `overall_days_variance` STRING COMMENT 'Total number of days the schedule is ahead (negative) or behind (positive) the planned ex-factory date. Key metric for supplier performance.',
    `payment_terms` STRING COMMENT 'Payment terms agreed with the supplier for this production order, including Letter of Credit (LC) terms, advance payment percentage, and payment schedule.',
    `pp_sample_approval_actual_date` DATE COMMENT 'Actual date when pre-production samples were approved.',
    `pp_sample_approval_planned_date` DATE COMMENT 'Planned date for approving pre-production samples and authorizing bulk production.',
    `pp_sample_submission_actual_date` DATE COMMENT 'Actual date when pre-production samples were submitted.',
    `pp_sample_submission_planned_date` DATE COMMENT 'Planned date for factory to submit pre-production samples for approval.',
    `schedule_comments` STRING COMMENT 'Free-text comments and notes regarding schedule status, delays, risks, or special instructions for this T&A calendar.',
    `schedule_start_date` DATE COMMENT 'Planned start date of the T&A calendar, typically the design handoff or tech pack issue date.',
    `schedule_status` STRING COMMENT 'Current lifecycle status of the delivery schedule indicating overall progress and health of the T&A calendar. [ENUM-REF-CANDIDATE: draft|active|on_track|at_risk|delayed|completed|cancelled — 7 candidates stripped; promote to reference product]',
    `season_code` STRING COMMENT 'Code representing the fashion season or collection period for this production schedule (e.g., SS24, FW24, HO24).. Valid values are `^[A-Z0-9]{2,10}$`',
    `sew_completion_actual_date` DATE COMMENT 'Actual date when sewing was completed.',
    `sew_completion_planned_date` DATE COMMENT 'Planned date for completing the sewing phase of production.',
    `shipment_terms` STRING COMMENT 'International Commercial Terms (Incoterms) defining the responsibilities and costs for shipping, such as Free on Board (FOB) or Delivered Duty Paid (DDP).. Valid values are `FOB|CIF|DDP|EXW|FCA|CPT`',
    `tech_pack_issue_actual_date` DATE COMMENT 'Actual date when tech pack was issued to the factory.',
    `tech_pack_issue_planned_date` DATE COMMENT 'Planned date for issuing the technical specification package to the factory.',
    `tna_template_version` STRING COMMENT 'Version identifier of the T&A template used to define the milestone structure and critical path for this schedule.. Valid values are `^[A-Z0-9._-]{1,20}$`',
    CONSTRAINT pk_delivery_schedule PRIMARY KEY(`delivery_schedule_id`)
) COMMENT 'Time and Action (T&A) calendar defining the critical path from design handoff to ex-factory shipment for a production order or style at a specific factory. Contains calendar header (season, style reference, factory, T&A template version, overall status) and embedded milestone records (milestone name, type such as Sample/Approval/Production/Shipment, planned date, actual date, days variance, responsible party, completion status, escalation flag, comments). Standard milestones include design approval, tech pack issue, fabric booking, PP sample submission/approval, bulk fabric in-house, cut date, sew completion, finishing, final inspection, and ex-factory date. SSOT for factory-execution T&A tracking within the supplier domain. Sourcing domain owns strategic T&A planning; this product owns operational milestone execution at the factory level.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`supplier`.`sustainability_profile` (
    `sustainability_profile_id` BIGINT COMMENT 'Unique identifier for the sustainability and ESG profile record.',
    `compliance_certification_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_certification. Business justification: Sustainability profiles claim specific certifications (GOTS, OEKO-TEX, BSCI, WRAP). Linking to compliance_certification enables verification of claims, tracks cert expiry for profile validity, and sup',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Sustainability assessments (Higg Index, certifications, audits) are managed by ESG departments with cost center accountability. Required for ESG program cost allocation and reporting.',
    `supplier_factory_id` BIGINT COMMENT 'Foreign key linking to supplier.supplier_factory. Business justification: ESG profiles and certifications (GOTS, OEKO-TEX, WRAP, Higg FEM) are factory-specific. Different factories operated by the same vendor can have different sustainability certifications, carbon footprin',
    `vendor_id` BIGINT COMMENT 'Reference to the supplier or factory to which this sustainability profile belongs.',
    `assessment_date` DATE COMMENT 'Date when the most recent sustainability or ESG assessment was conducted for this profile.',
    `audit_frequency_months` STRING COMMENT 'Frequency in months at which sustainability and compliance audits are conducted for this supplier.',
    `bci_certified_flag` BOOLEAN COMMENT 'Indicates whether the supplier is certified under the Better Cotton Initiative for sustainable cotton sourcing.',
    `bluesign_certified_flag` BOOLEAN COMMENT 'Indicates whether the supplier holds Bluesign certification for sustainable textile production and chemical management.',
    `carbon_footprint_tco2e_year` DECIMAL(18,2) COMMENT 'Total annual carbon emissions measured in metric tons of CO2 equivalent (tCO2e) for the supplier facility.',
    `chemical_inventory_disclosed_flag` BOOLEAN COMMENT 'Indicates whether the supplier has disclosed a full chemical inventory and formulation list for transparency and compliance.',
    `community_investment_programs` STRING COMMENT 'Description of community investment and social responsibility programs operated by the supplier, including education, healthcare, and local development initiatives.',
    `corrective_action_plan_status` STRING COMMENT 'Status of any corrective action plan issued to address sustainability or compliance gaps identified during audits.. Valid values are `not_required|in_progress|completed|overdue|pending_verification`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this sustainability profile record was first created in the system.',
    `esg_reporting_framework` STRING COMMENT 'Primary ESG reporting framework or standard used by the supplier for sustainability disclosure (GRI, SASB, TCFD, CDP, UN Global Compact, or Integrated Reporting).. Valid values are `GRI|SASB|TCFD|CDP|UNGC|INTEGRATED`',
    `fla_accredited_flag` BOOLEAN COMMENT 'Indicates whether the supplier is accredited by the Fair Labor Association for labor rights compliance.',
    `gender_equality_score` DECIMAL(18,2) COMMENT 'Numerical score (0-100) representing the suppliers performance on gender equality metrics including pay equity, representation, and workplace policies.',
    `gots_certified_flag` BOOLEAN COMMENT 'Indicates whether the supplier holds valid GOTS certification for organic textile processing.',
    `higg_fem_score` DECIMAL(18,2) COMMENT 'Higg FEM score (0-100) measuring the environmental performance of the manufacturing facility across energy, water, waste, and emissions.',
    `higg_fslm_score` DECIMAL(18,2) COMMENT 'Higg FSLM score (0-100) measuring the social and labor performance of the facility including worker rights, health and safety, and management systems.',
    `iso_14001_certified_flag` BOOLEAN COMMENT 'Indicates whether the supplier holds valid ISO 14001 certification for environmental management systems.',
    `iso_45001_certified_flag` BOOLEAN COMMENT 'Indicates whether the supplier holds valid ISO 45001 certification for occupational health and safety management systems.',
    `living_wage_compliant_flag` BOOLEAN COMMENT 'Indicates whether the supplier pays workers a living wage that meets or exceeds local living wage benchmarks.',
    `next_assessment_date` DATE COMMENT 'Scheduled date for the next sustainability or ESG assessment or audit.',
    `notes` STRING COMMENT 'Free-text notes or comments providing additional context, observations, or action items related to the sustainability profile.',
    `oeko_tex_certified_flag` BOOLEAN COMMENT 'Indicates whether the supplier holds valid OEKO-TEX Standard 100 certification for textile safety.',
    `profile_name` STRING COMMENT 'Human-readable name or label for this sustainability profile, typically identifying the facility or program being assessed.',
    `profile_status` STRING COMMENT 'Current lifecycle status of the sustainability profile indicating whether it is active, under review, expired, or suspended.. Valid values are `active|inactive|under_review|expired|suspended|pending_certification`',
    `renewable_energy_percentage` DECIMAL(18,2) COMMENT 'Percentage of total energy consumption sourced from renewable energy sources (solar, wind, hydro, etc.).',
    `risk_score` DECIMAL(18,2) COMMENT 'Composite risk score (0-100) assessing the suppliers sustainability and ESG risk exposure, with higher scores indicating higher risk.',
    `traceability_level` STRING COMMENT 'Level of supply chain traceability achieved by the supplier, indicating visibility into upstream tiers (Tier 1, Tier 2, Tier 3, Tier 4, raw material, or full chain).. Valid values are `tier_1|tier_2|tier_3|tier_4|raw_material|full_chain`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this sustainability profile record was last updated or modified.',
    `waste_diversion_rate_percentage` DECIMAL(18,2) COMMENT 'Percentage of total waste diverted from landfill through recycling, composting, or reuse programs.',
    `water_usage_intensity_liters_kg` DECIMAL(18,2) COMMENT 'Water consumption intensity measured in liters per kilogram of product produced, indicating water efficiency.',
    `wrap_certified_flag` BOOLEAN COMMENT 'Indicates whether the supplier holds valid WRAP certification for ethical manufacturing and labor standards.',
    `zdhc_mrsl_compliant_flag` BOOLEAN COMMENT 'Indicates whether the supplier complies with ZDHC MRSL for chemical management and hazardous substance elimination.',
    CONSTRAINT pk_sustainability_profile PRIMARY KEY(`sustainability_profile_id`)
) COMMENT 'Sustainability and ESG (Environmental, Social, Governance) profile for a vendor or factory, capturing environmental certifications (GOTS, OEKO-TEX, BCI, Bluesign, Higg Index), carbon footprint (tCO2e/year), water usage intensity (liters/kg), chemical management compliance (ZDHC MRSL), renewable energy percentage, waste diversion rate, living wage compliance flag, gender equality score, community investment programs, Higg FEM score, Higg FSLM score, ESG reporting framework (GRI/SASB), and last assessment date. Supports ESG reporting and sustainable sourcing strategy.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`supplier`.`cmt_agreement` (
    `cmt_agreement_id` BIGINT COMMENT 'Unique identifier for the CMT agreement record. Primary key.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: CMT agreements are negotiated and managed by sourcing employees responsible for contract terms, renewals, amendments, and performance monitoring. Essential for contract lifecycle management, approval ',
    `production_factory_id` BIGINT COMMENT 'Reference to the specific factory facility covered by this CMT agreement.',
    `season_id` BIGINT COMMENT 'Foreign key linking to merchandising.season. Business justification: CMT rates and capacity commitments are negotiated per season; merchandising needs seasonal CMT cost visibility for buy plan costing, margin planning, and OTB budget allocation in apparel manufacturing',
    `standard_id` BIGINT COMMENT 'Foreign key linking to quality.quality_standard. Business justification: CMT (cut-make-trim) agreements have specific quality standards for manufacturing processes distinct from parent vendor_agreement. Links to quality_standard for workmanship inspection criteria, AQL lev',
    `vendor_agreement_id` BIGINT COMMENT 'Foreign key linking to supplier.vendor_agreement. Business justification: CMT agreements are specific contract types that should reference their parent master vendor agreement. vendor_agreement is the framework contract governing the overall commercial relationship; cmt_agr',
    `vendor_id` BIGINT COMMENT 'Reference to the vendor master record representing the CMT factory partner.',
    `renewed_cmt_agreement_id` BIGINT COMMENT 'Self-referencing FK on cmt_agreement (renewed_cmt_agreement_id)',
    `agreement_number` STRING COMMENT 'Externally-known unique business identifier for the CMT agreement, used in contracts and purchase orders.',
    `agreement_status` STRING COMMENT 'Current lifecycle status of the CMT agreement: draft (under negotiation), pending approval, active (in force), suspended (temporarily inactive), expired (past end date), or terminated (cancelled).. Valid values are `draft|pending_approval|active|suspended|expired|terminated`',
    `agreement_type` STRING COMMENT 'Classification of the manufacturing agreement model: CMT (Cut-Make-Trim), FOB (Free on Board), CMT plus materials, ODM (Original Design Manufacturer), OEM (Original Equipment Manufacturer), or full package.. Valid values are `cmt|fob|cmt_plus_materials|odm|oem|full_package`',
    `amendment_count` STRING COMMENT 'Number of formal amendments or addendums made to the original agreement.',
    `audit_frequency_months` STRING COMMENT 'Required frequency in months for compliance and social audits of the factory (e.g., 12 for annual, 6 for semi-annual).',
    `auto_renewal_flag` BOOLEAN COMMENT 'Indicates whether the agreement automatically renews at the end of the term unless terminated by either party.',
    `capacity_commitment_units_per_month` STRING COMMENT 'Contracted monthly production capacity in units that the factory commits to reserve for the brand.',
    `cmt_rate_per_unit` DECIMAL(18,2) COMMENT 'Contracted CMT manufacturing cost per unit (garment or pair). Excludes materials cost.',
    `compliance_certifications_required` STRING COMMENT 'Comma-separated list of mandatory compliance certifications the factory must maintain (e.g., WRAP, FLA, GOTS, OEKO-TEX, BSCI).',
    `confidentiality_clause_flag` BOOLEAN COMMENT 'Indicates whether a non-disclosure agreement (NDA) or confidentiality clause is included in this CMT agreement.',
    `contract_value_total` DECIMAL(18,2) COMMENT 'Total estimated or committed contract value over the agreement term, in agreement currency. May be null for open-ended agreements.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this CMT agreement record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary values in this agreement (e.g., USD, EUR, CNY).. Valid values are `^[A-Z]{3}$`',
    `dispute_resolution_method` STRING COMMENT 'Agreed method for resolving contractual disputes: negotiation, mediation, arbitration, or litigation.. Valid values are `negotiation|mediation|arbitration|litigation`',
    `effective_end_date` DATE COMMENT 'Date when the CMT agreement expires or terminates. Nullable for open-ended agreements.',
    `effective_start_date` DATE COMMENT 'Date when the CMT agreement becomes legally binding and operational.',
    `exclusivity_flag` BOOLEAN COMMENT 'Indicates whether this agreement grants the brand exclusive production rights for specified product categories at this factory.',
    `fob_port` STRING COMMENT 'Named port of shipment for FOB delivery terms (e.g., Shanghai, Ningbo, Ho Chi Minh City).',
    `force_majeure_clause_flag` BOOLEAN COMMENT 'Indicates whether the agreement includes a force majeure clause covering unforeseeable circumstances (natural disasters, pandemics, war) that prevent contract fulfillment.',
    `gender_specialization` STRING COMMENT 'Gender segment specialization for products manufactured under this agreement.. Valid values are `mens|womens|kids|unisex|all`',
    `governing_law_jurisdiction` STRING COMMENT 'Legal jurisdiction and governing law that applies to this agreement (e.g., New York USA, Hong Kong, England and Wales).',
    `incoterms` STRING COMMENT 'International Commercial Terms (Incoterms) defining delivery responsibilities and risk transfer point (e.g., FOB, CIF, DDP). [ENUM-REF-CANDIDATE: EXW|FCA|FAS|FOB|CFR|CIF|CPT|CIP|DAP|DPU|DDP — 11 candidates stripped; promote to reference product]',
    `insurance_requirements` STRING COMMENT 'Description of insurance coverage the factory must maintain (e.g., product liability, workers compensation, property insurance).',
    `ip_ownership_clause` STRING COMMENT 'Contractual clause defining ownership of designs, patterns, tech packs, and other intellectual property created under this agreement.',
    `last_amendment_date` DATE COMMENT 'Date of the most recent amendment to the agreement.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this CMT agreement record was last updated.',
    `lc_required_flag` BOOLEAN COMMENT 'Indicates whether a letter of credit is required for payment under this agreement.',
    `lc_terms` STRING COMMENT 'Specific terms and conditions for letter of credit issuance, including sight or usance period.',
    `lead_time_days` STRING COMMENT 'Standard production lead time in days from order confirmation to ex-factory date, as defined in the agreement.',
    `liability_cap_amount` DECIMAL(18,2) COMMENT 'Maximum liability amount that either party can claim for breach of contract or damages, in agreement currency.',
    `moq_units` STRING COMMENT 'Minimum order quantity in units required per style or per order under this CMT agreement.',
    `moq_value` DECIMAL(18,2) COMMENT 'Minimum order value threshold required per order or season, in agreement currency.',
    `notes` STRING COMMENT 'Free-text field for additional comments, special terms, or internal notes about the CMT agreement.',
    `payment_method` STRING COMMENT 'Primary payment instrument method specified in the agreement: wire transfer, letter of credit (LC), open account, or documentary collection.. Valid values are `wire_transfer|letter_of_credit|open_account|documentary_collection`',
    `payment_terms` STRING COMMENT 'Agreed payment terms for CMT invoices (e.g., Net 30, Net 60, 30% advance 70% on shipment).',
    `performance_bond_amount` DECIMAL(18,2) COMMENT 'Value of the performance bond or bank guarantee required, in agreement currency.',
    `performance_bond_required_flag` BOOLEAN COMMENT 'Indicates whether the factory is required to provide a performance bond or bank guarantee to secure contract obligations.',
    `product_category` STRING COMMENT 'Primary product category covered by this CMT agreement (e.g., mens apparel, womens footwear, accessories, activewear).',
    `product_subcategory` STRING COMMENT 'Specific product subcategory or silhouette covered (e.g., t-shirts, denim, outerwear, sneakers).',
    `renewal_notice_period_days` STRING COMMENT 'Number of days advance notice required to prevent automatic renewal or to initiate renewal negotiations.',
    `sample_lead_time_days` STRING COMMENT 'Standard lead time in days for pre-production (PP) sample submission.',
    `signatory_name_buyer` STRING COMMENT 'Full name and title of the authorized signatory representing the brand/buyer.',
    `signatory_name_vendor` STRING COMMENT 'Full name and title of the authorized signatory representing the vendor/factory.',
    `signed_date` DATE COMMENT 'Date when the CMT agreement was signed by both parties.',
    `termination_notice_period_days` STRING COMMENT 'Number of days advance notice required by either party to terminate the agreement.',
    CONSTRAINT pk_cmt_agreement PRIMARY KEY(`cmt_agreement_id`)
) COMMENT 'Cut-Make-Trim agreement record defining contractual terms between the brand and a CMT factory including CMT rates, MOQs, capacity commitments, and payment terms';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`supplier`.`oem_odm_agreement` (
    `oem_odm_agreement_id` BIGINT COMMENT 'Unique identifier for the OEM/ODM partnership agreement record.',
    `standard_id` BIGINT COMMENT 'Foreign key linking to quality.quality_standard. Business justification: OEM/ODM agreements require quality standards for design, materials, and finished goods distinct from CMT. Links to quality_standard for product certification requirements, lab testing protocols, and c',
    `vendor_agreement_id` BIGINT COMMENT 'Foreign key linking to supplier.vendor_agreement. Business justification: OEM/ODM agreements are specific contract types that should reference their parent master vendor agreement. Similar to cmt_agreement, oem_odm_agreement is a specialized contract for original equipment/',
    `vendor_id` BIGINT COMMENT 'Reference to the vendor or supplier entity that is party to this OEM/ODM agreement.',
    `renewed_oem_odm_agreement_id` BIGINT COMMENT 'Self-referencing FK on oem_odm_agreement (renewed_oem_odm_agreement_id)',
    `agreement_number` STRING COMMENT 'Externally-known unique business identifier for this OEM/ODM agreement, used for reference in contracts and communications.',
    `agreement_status` STRING COMMENT 'Current lifecycle status of the OEM/ODM agreement indicating its operational state.. Valid values are `Draft|Active|Suspended|Terminated|Expired|Pending Renewal`',
    `agreement_type` STRING COMMENT 'Classification of the manufacturing partnership: OEM (Original Equipment Manufacturer - buyer provides design, supplier manufactures), ODM (Original Design Manufacturer - supplier provides design and manufacturing), or Hybrid (combination of both models).. Valid values are `OEM|ODM|Hybrid`',
    `amendment_count` STRING COMMENT 'Total number of formal amendments or addendums made to this OEM/ODM agreement since its original execution.',
    `audit_frequency` STRING COMMENT 'Required frequency of compliance and quality audits for the supplier under this OEM/ODM agreement.. Valid values are `Annual|Semi-Annual|Quarterly|As Needed`',
    `auto_renewal_flag` BOOLEAN COMMENT 'Indicates whether the agreement automatically renews for successive terms unless either party provides termination notice.',
    `capacity_commitment_units_per_month` STRING COMMENT 'Guaranteed monthly production capacity in units that the supplier commits to reserve for the buyer under this agreement.',
    `compliance_certifications_required` STRING COMMENT 'Comma-separated list of mandatory certifications the supplier must maintain (e.g., WRAP, FLA, GOTS, OEKO-TEX, BSCI, SA8000).',
    `confidentiality_clause_flag` BOOLEAN COMMENT 'Indicates whether the agreement includes confidentiality and non-disclosure provisions protecting proprietary designs, specifications, and business information.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this OEM/ODM agreement record was first created in the data platform.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all financial transactions under this agreement (e.g., USD, EUR, CNY).. Valid values are `^[A-Z]{3}$`',
    `design_ownership` STRING COMMENT 'Specifies ownership rights for product designs, tech packs, and pattern specifications developed under this agreement.. Valid values are `Buyer|Supplier|Shared`',
    `dispute_resolution_method` STRING COMMENT 'Agreed method for resolving disputes arising from this agreement (e.g., international arbitration, mediation, court litigation).. Valid values are `Arbitration|Mediation|Litigation|Negotiation`',
    `effective_date` DATE COMMENT 'Date when the OEM/ODM agreement becomes legally binding and operational.',
    `exclusivity_flag` BOOLEAN COMMENT 'Indicates whether this agreement grants exclusive manufacturing rights to the supplier for specified products or categories, preventing the buyer from engaging other manufacturers for the same items.',
    `exclusivity_scope` STRING COMMENT 'Detailed description of the exclusivity terms including geographic regions, product lines, or market segments covered by the exclusivity clause.',
    `expiry_date` DATE COMMENT 'Date when the OEM/ODM agreement terminates or requires renewal. Nullable for open-ended agreements.',
    `force_majeure_clause_flag` BOOLEAN COMMENT 'Indicates whether the agreement includes force majeure provisions excusing performance during extraordinary events beyond either partys control.',
    `governing_law_jurisdiction` STRING COMMENT 'Legal jurisdiction and governing law that applies to this OEM/ODM agreement (e.g., New York USA, Hong Kong, England and Wales).',
    `incoterms` STRING COMMENT 'Standard trade terms defining responsibilities for shipping, insurance, and risk transfer between buyer and supplier. [ENUM-REF-CANDIDATE: EXW|FCA|CPT|CIP|DAP|DPU|DDP|FAS|FOB|CFR|CIF — 11 candidates stripped; promote to reference product]',
    `insurance_requirements` STRING COMMENT 'Mandatory insurance coverage types and minimum coverage amounts the supplier must maintain (e.g., product liability, workers compensation, property insurance).',
    `ip_ownership` STRING COMMENT 'Defines who owns the intellectual property rights (designs, patterns, technical specifications, trademarks) created or used under this agreement.. Valid values are `Buyer|Supplier|Shared|Joint`',
    `last_amendment_date` DATE COMMENT 'Date of the most recent amendment or modification to this agreement.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'System timestamp when this OEM/ODM agreement record was last updated in the data platform.',
    `lead_time_days` STRING COMMENT 'Standard production lead time in days from order confirmation to ex-factory date as agreed in this OEM/ODM partnership.',
    `liability_cap_amount` DECIMAL(18,2) COMMENT 'Maximum financial liability amount that either party can claim under this agreement for breaches, defects, or damages.',
    `manufacturing_scope` STRING COMMENT 'Detailed description of the product categories, styles, or collections covered under this OEM/ODM agreement (e.g., mens activewear, womens footwear, accessories).',
    `material_sourcing_responsibility` STRING COMMENT 'Defines who is responsible for sourcing raw materials and components: buyer-nominated suppliers, supplier-sourced, or a combination.. Valid values are `Buyer Nominated|Supplier Sourced|Hybrid`',
    `moq_units` STRING COMMENT 'Minimum number of units per order or per style that the buyer must commit to under this OEM/ODM agreement.',
    `non_compete_clause_flag` BOOLEAN COMMENT 'Indicates whether the agreement includes non-compete provisions restricting the supplier from manufacturing similar products for competitors.',
    `notes` STRING COMMENT 'Additional comments, special terms, or contextual information about this OEM/ODM agreement.',
    `payment_terms` STRING COMMENT 'Agreed payment terms for orders under this OEM/ODM agreement (e.g., 30% deposit, 70% before shipment, Net 30, Net 60).',
    `performance_bond_required_flag` BOOLEAN COMMENT 'Indicates whether the supplier must provide a performance bond or bank guarantee to secure their obligations under this agreement.',
    `pricing_model` STRING COMMENT 'Pricing structure agreed for manufacturing services under this OEM/ODM agreement (e.g., fixed unit price, cost-plus margin, volume-based discounts).. Valid values are `Fixed Price|Cost Plus|Volume Based|Tiered`',
    `product_categories` STRING COMMENT 'Comma-separated list of product categories authorized for manufacturing under this agreement (e.g., Apparel, Footwear, Accessories).',
    `renewal_notice_period_days` STRING COMMENT 'Number of days before expiry that either party must provide notice if they do not wish to renew the agreement.',
    `sample_development_terms` STRING COMMENT 'Terms governing sample development including lead times, costs, approval processes, and ownership of pre-production (PP) samples.',
    `signatory_name_buyer` STRING COMMENT 'Full name and title of the authorized representative who signed the agreement on behalf of the buyer.',
    `signatory_name_supplier` STRING COMMENT 'Full name and title of the authorized representative who signed the agreement on behalf of the supplier.',
    `signed_date` DATE COMMENT 'Date when both parties executed and signed the OEM/ODM agreement.',
    `termination_notice_period_days` STRING COMMENT 'Number of days advance notice required by either party to terminate this OEM/ODM agreement.',
    `territory_restriction` STRING COMMENT 'Geographic regions or markets where the supplier is authorized or restricted from manufacturing, selling, or distributing products under this agreement.',
    `tooling_ownership` STRING COMMENT 'Specifies ownership of molds, dies, patterns, and other tooling developed for production under this agreement.. Valid values are `Buyer|Supplier|Shared`',
    CONSTRAINT pk_oem_odm_agreement PRIMARY KEY(`oem_odm_agreement_id`)
) COMMENT 'OEM/ODM partnership agreement capturing terms of original equipment or original design manufacturing relationships including IP ownership and exclusivity';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`supplier`.`factory_sourcing_allocation` (
    `factory_sourcing_allocation_id` BIGINT COMMENT 'Unique identifier for this factory-agreement allocation record. Primary key.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to the master sourcing agreement framework under which this factory operates',
    `factory_supplier_factory_id` BIGINT COMMENT 'Foreign key linking to the specific manufacturing facility allocated to fulfill this sourcing agreement',
    `sourcing_agreement_id` BIGINT COMMENT 'Foreign key to sourcing.sourcing_agreement identifying the master agreement',
    `supplier_factory_id` BIGINT COMMENT 'Foreign key to supplier.supplier_factory identifying the manufacturing facility',
    `allocated_volume_quantity` DECIMAL(18,2) COMMENT 'The portion of the total agreement committed volume allocated to this specific factory. Subset of sourcing_agreement.committed_volume_quantity distributed across multiple factories.',
    `allocation_effective_from_date` DATE COMMENT 'The date when this factory allocation becomes operational. May differ from the master agreement effective date if factories are added mid-term.',
    `allocation_effective_to_date` DATE COMMENT 'The date when this factory allocation expires or is terminated. Nullable for ongoing allocations. May differ from master agreement end date if factories are rotated.',
    `allocation_status` STRING COMMENT 'Current operational status of this factory allocation. Active allocations are fulfilling orders; Suspended allocations are temporarily paused; Completed allocations have fulfilled their term; Cancelled allocations were terminated early.',
    `capacity_allocation_percent` DECIMAL(18,2) COMMENT 'The percentage of this factorys production capacity reserved for this sourcing agreement. Factory-specific allocation that may vary across agreements.',
    `created_date` TIMESTAMP COMMENT 'Timestamp when this factory allocation record was created in the system.',
    `factory_cmt_rate` DECIMAL(18,2) COMMENT 'The factory-specific Cut Make Trim labor rate for this agreement, reflecting factory labor costs and efficiency levels.',
    `factory_exclusivity_flag` BOOLEAN COMMENT 'Indicates whether this specific factory has exclusive production rights for products under this agreement. Factory-level exclusivity within a multi-factory vendor relationship.',
    `factory_fob_price` DECIMAL(18,2) COMMENT 'The factory-specific Free On Board unit price for this agreement, which may differ from the base agreement price due to factory capabilities, location, or negotiated terms.',
    `last_modified_by` STRING COMMENT 'User or system identifier that last modified this allocation record.',
    `last_modified_date` TIMESTAMP COMMENT 'Timestamp of the most recent modification to this allocation record.',
    `primary_factory_flag` BOOLEAN COMMENT 'Indicates whether this factory is the primary/lead facility for this agreement when multiple factories are allocated. Used for routing and prioritization decisions.',
    `product_category_scope` STRING COMMENT 'Comma-separated list of product categories this factory is authorized to produce under this agreement. Subset of agreement scope based on factory capabilities.',
    `created_by` STRING COMMENT 'User or system identifier that created this allocation record.',
    CONSTRAINT pk_factory_sourcing_allocation PRIMARY KEY(`factory_sourcing_allocation_id`)
) COMMENT 'This association product represents the operational allocation between supplier factories and sourcing agreements in the apparel manufacturing network. It captures factory-specific terms within multi-factory vendor relationships, including capacity commitments, pricing variations, volume allocations, and exclusivity arrangements that exist only when a specific factory is designated to fulfill a sourcing agreement. Each record links one supplier factory to one sourcing agreement with attributes reflecting the negotiated terms for that factory-agreement pairing.. Existence Justification: In apparel sourcing operations, vendors commonly operate multiple manufacturing facilities with different capabilities, and strategic sourcing agreements are executed across multiple factories to diversify risk, leverage specialized capabilities, and meet volume commitments. A single sourcing agreement covering 100,000 units may allocate 40,000 to Factory A (knitting specialist), 35,000 to Factory B (dyeing/finishing), and 25,000 to Factory C (CMT operations). Conversely, a high-performing factory participates in multiple concurrent sourcing agreements across different seasons, product categories, and buyer divisions. The business actively manages these factory-agreement allocations with factory-specific pricing, capacity reservations, exclusivity terms, and volume commitments.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`supplier`.`vendor_defect_occurrence` (
    `vendor_defect_occurrence_id` BIGINT COMMENT 'Unique identifier for this vendor-defect occurrence tracking record. Primary key for the association.',
    `defect_id` BIGINT COMMENT 'Foreign key linking to the quality defect taxonomy entry that classifies this occurrence',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to the vendor entity where this defect was observed',
    `active_flag` BOOLEAN COMMENT 'Boolean indicator of whether this vendor-defect combination is currently active (defect still occurring or CAPA in progress) or closed (defect resolved and verified).',
    `capa_completion_date` DATE COMMENT 'Actual date when the vendor completed corrective actions for this defect type. Used to measure vendor CAPA cycle time and on-time completion rates.',
    `capa_due_date` DATE COMMENT 'Target date by which the vendor must complete corrective actions for this defect type. Used to track vendor responsiveness and compliance with quality improvement timelines.',
    `corrective_action_status` STRING COMMENT 'Current status of the corrective and preventive action (CAPA) workflow for this vendor-defect combination. Tracks whether the vendor has implemented fixes and whether they have been verified effective.',
    `cost_impact_total` DECIMAL(18,2) COMMENT 'Cumulative financial impact of this defect type at this vendor, including rework costs, scrap, chargebacks, and claims. Used for vendor scorecarding and cost-of-quality analysis.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this vendor-defect occurrence record was first created in the quality management system.',
    `defect_frequency_count` STRING COMMENT 'Total number of times this specific defect type has been observed at this vendor across all inspections and production runs. Supports Pareto analysis and vendor quality trending.',
    `first_occurrence_date` DATE COMMENT 'The date when this defect type was first identified at this vendor. Tracks the emergence of quality issues and supports root cause timeline analysis.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this vendor-defect occurrence record was last updated. Tracks changes to frequency counts, CAPA status, and cost impacts.',
    `last_occurrence_date` DATE COMMENT 'The most recent date when this defect type was observed at this vendor. Used to assess whether corrective actions have been effective and whether the defect is recurring or resolved.',
    `recurrence_rate` DECIMAL(18,2) COMMENT 'Percentage of inspections or production runs at this vendor where this defect type recurs after corrective action. Indicates effectiveness of vendor quality improvements and process control.',
    `vendor_responsible_party` STRING COMMENT 'Name or role of the vendor contact responsible for addressing this defect type. Supports accountability and communication in CAPA workflows.',
    `verification_status` STRING COMMENT 'Status of quality team verification that the vendors corrective actions have effectively eliminated or reduced this defect type. Tracks CAPA effectiveness.',
    CONSTRAINT pk_vendor_defect_occurrence PRIMARY KEY(`vendor_defect_occurrence_id`)
) COMMENT 'This association product represents the operational tracking of quality defects observed at specific vendors in the apparel-fashion supply chain. It captures vendor-specific defect patterns, frequency, cost impact, and corrective action effectiveness for supplier scorecarding and quality improvement programs. Each record links one quality defect type to one vendor with attributes that exist only in the context of this vendor-defect relationship, enabling Pareto analysis, supplier quality rating, and targeted CAPA initiatives.. Existence Justification: In apparel-fashion supply chain operations, quality defects are tracked at the vendor level to enable supplier scorecarding, quality improvement programs, and sourcing decisions. A single defect type (e.g., seam puckering) occurs across multiple vendors with different frequencies and root causes, and each vendor exhibits multiple defect types across their production. The business actively manages vendor-specific defect patterns through CAPA workflows, cost tracking, and recurrence analysis—this is not a derived analytical correlation but an operational quality management process.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`supplier`.`vendor_quality_compliance` (
    `vendor_quality_compliance_id` BIGINT COMMENT 'Unique identifier for this vendor-quality standard compliance record. Primary key.',
    `quality_standard_id` BIGINT COMMENT 'Foreign key to quality_standard identifying which standard applies',
    `standard_id` BIGINT COMMENT 'Foreign key linking to the quality standard that applies to this vendor compliance record',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to the vendor entity subject to this quality standard compliance',
    `audit_frequency_override` STRING COMMENT 'Vendor-specific override of the default audit frequency defined in the quality standard, allowing more frequent audits for high-risk vendors or less frequent for consistently compliant vendors (e.g., Quarterly, Semi-Annual, Annual, Biennial)',
    `audit_score` DECIMAL(18,2) COMMENT 'Numerical score from the most recent audit of this vendor against this quality standard, typically expressed as a percentage or on a defined scale',
    `certification_expiry_date` DATE COMMENT 'Expiration date of the vendors certification for this quality standard, after which recertification is required',
    `certification_number` STRING COMMENT 'Official certification or registration number issued by the certifying body for this vendor-standard combination (e.g., GOTS certificate number, WRAP registration ID)',
    `certification_required_flag` BOOLEAN COMMENT 'Indicates whether this specific vendor must obtain formal third-party certification for this quality standard, which may differ from the standards general certification requirements based on vendor tier, product categories supplied, or target markets served',
    `certifying_body` STRING COMMENT 'Name of the third-party organization that issued the certification to this vendor for this standard (may differ from the standards issuing body)',
    `compliance_owner` STRING COMMENT 'Name or identifier of the internal quality manager or compliance officer responsible for managing this vendor-standard compliance relationship',
    `compliance_status` STRING COMMENT 'Current compliance status of this vendor for this specific quality standard, tracking whether the vendor meets all requirements, has open corrective actions, or is pending certification',
    `created_date` TIMESTAMP COMMENT 'Timestamp when this compliance record was created in the system',
    `effective_date` DATE COMMENT 'Date from which this quality standard became applicable to this specific vendor, which may differ from the standards global effective date based on vendor onboarding, contract terms, or product category changes',
    `last_audit_date` DATE COMMENT 'Date of the most recent quality audit conducted for this vendor against this specific quality standard',
    `last_updated_date` TIMESTAMP COMMENT 'Timestamp of the most recent update to this compliance record',
    `next_audit_due_date` DATE COMMENT 'Scheduled date for the next quality audit of this vendor for this quality standard, calculated based on audit frequency and last audit date',
    `notes` STRING COMMENT 'Free-text notes documenting vendor-specific compliance considerations, historical issues, or special requirements for this quality standard',
    `open_corrective_actions` STRING COMMENT 'Number of open corrective action requests (CARs) for this vendor related to this specific quality standard',
    `waiver_expiry_date` DATE COMMENT 'Date when the granted waiver expires and full compliance is required',
    `waiver_granted_flag` BOOLEAN COMMENT 'Indicates whether a temporary waiver or exception has been granted for this vendor for this quality standard, allowing production despite non-compliance under specific conditions',
    `waiver_justification` STRING COMMENT 'Business justification and approval documentation for the granted waiver',
    CONSTRAINT pk_vendor_quality_compliance PRIMARY KEY(`vendor_quality_compliance_id`)
) COMMENT 'This association product represents the compliance relationship between quality standards and vendors in the apparel-fashion supply chain. It captures vendor-specific compliance status, audit schedules, certification requirements, and quality performance tracking for each quality standard that applies to each vendor. Each record links one quality standard to one vendor with attributes that exist only in the context of this compliance relationship, enabling tracking of multi-standard compliance per vendor and multi-vendor applicability per standard.. Existence Justification: In apparel-fashion supply chain operations, vendors must comply with multiple quality standards simultaneously (ISO 9001, WRAP, GOTS, OEKO-TEX, brand-specific standards), and each quality standard applies to multiple vendors across the supply base. The business actively manages vendor-specific compliance status, audit schedules, certification tracking, and corrective actions for each standard-vendor combination. This is an operational compliance management process, not an analytical correlation.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`supplier`.`vendor_relationship` (
    `vendor_relationship_id` BIGINT COMMENT 'Unique identifier for this vendor-employee relationship assignment record. Primary key.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to the employee master record. Identifies which internal employee is assigned to work with this vendor.',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to the vendor master record. Identifies which vendor this relationship assignment is for.',
    `assignment_status` STRING COMMENT 'Current operational status of this vendor-employee relationship assignment. Active assignments are currently in effect. Inactive assignments have ended. Suspended assignments are temporarily paused. Pending assignments are scheduled to begin in the future.',
    `authorization_level` STRING COMMENT 'The level of authority or access this employee has in their interactions with this vendor. Determines what actions the employee can take (e.g., place orders, approve samples, negotiate terms, access confidential data). Examples: View Only (read-only access), Standard (routine operations), Elevated (can approve exceptions), Full Authorization (can modify vendor terms).',
    `created_date` TIMESTAMP COMMENT 'Timestamp when this vendor relationship assignment record was created in the system.',
    `effective_end_date` DATE COMMENT 'The date when this employee-vendor relationship assignment ended or is scheduled to end. Nullable for currently active relationships. Used to track relationship lifecycle and historical changes in vendor management assignments.',
    `effective_start_date` DATE COMMENT 'The date when this employee-vendor relationship assignment became active. Used to track historical assignments and determine current vs. past relationships.',
    `last_modified_by` STRING COMMENT 'User ID or system identifier of who last modified this vendor relationship assignment record.',
    `last_modified_date` TIMESTAMP COMMENT 'Timestamp when this vendor relationship assignment record was last updated.',
    `primary_contact_flag` BOOLEAN COMMENT 'Boolean indicator of whether this employee is the primary point of contact for this vendor in this role type. Used to identify the main responsible party when multiple employees have relationships with the same vendor. Only one employee per role_type should be marked as primary for a given vendor at any time.',
    `role_type` STRING COMMENT 'The functional role or capacity in which the employee interacts with the vendor. Determines the nature of the working relationship and authorization scope. Examples: Buyer (commercial negotiations), Quality Manager (QA/QC oversight), Compliance Auditor (social/environmental compliance), Technical Designer (product development), Costing Analyst (pricing analysis).',
    `specialization_area` STRING COMMENT 'The product category, material type, or functional area that defines the scope of this employee-vendor relationship. Examples: Mens Outerwear, Womens Denim, Knit Fabrics, Trims & Accessories, Footwear. Allows employees to specialize in specific vendor relationships by product line or material expertise.',
    `created_by` STRING COMMENT 'User ID or system identifier of who created this vendor relationship assignment record.',
    CONSTRAINT pk_vendor_relationship PRIMARY KEY(`vendor_relationship_id`)
) COMMENT 'This association product represents the operational assignment between internal employees and external vendors in the apparel-fashion supply chain. It captures which employees are authorized to interact with which vendors, in what capacity, and for what time period. Each record links one vendor to one employee with role-specific attributes that exist only in the context of this working relationship. This is distinct from vendor_contact (which tracks external vendor personnel) and represents internal employee-to-vendor assignments for sourcing, quality, compliance, and technical collaboration.. Existence Justification: In apparel-fashion sourcing operations, vendors are managed by multiple internal employees in different functional capacities simultaneously (a buyer negotiates commercial terms, a quality manager oversees QA, a compliance auditor conducts social audits, a technical designer collaborates on product development). Each employee manages a portfolio of multiple vendors, often specialized by product category or material type. The business actively manages these assignments with role definitions, authorization levels, and time-bound effective periods.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`supplier`.`vendor_certification` (
    `vendor_certification_id` BIGINT COMMENT 'Unique identifier for this vendor certification holding record. Primary key.',
    `compliance_certification_id` BIGINT COMMENT 'Foreign key linking to the compliance certification standard held by the vendor',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to the vendor entity that holds this certification',
    `certificate_number` STRING COMMENT 'The unique certificate number issued to this vendor for this certification. Vendor-specific certificate identifier.',
    `certification_scope` STRING COMMENT 'The scope at which this vendor holds this specific certification (e.g., facility-level WRAP, organization-level ISO 9001, product-line-level GOTS). Scope varies by vendor-certification combination.',
    `certification_status` STRING COMMENT 'Current status of this vendors certification holding. Tracks lifecycle state for this specific vendor-certification combination.',
    `certified_facility_location` STRING COMMENT 'The specific facility or site location covered by this vendor certification, if the scope is facility-level. May differ from vendor headquarters.',
    `cost_amount` DECIMAL(18,2) COMMENT 'The cost incurred by this vendor (or paid by Apparel Fashion on behalf of the vendor) to obtain or renew this specific certification. Cost varies by vendor, certification type, and scope.',
    `cost_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the certification cost amount.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this vendor certification record was created in the system.',
    `effective_date` DATE COMMENT 'The date on which this vendors holding of this certification became effective. May differ from the certifications original issue date if the vendor obtained it later.',
    `expiry_date` DATE COMMENT 'The date on which this vendors certification expires and must be renewed. Vendor-specific expiry tracking for sourcing eligibility.',
    `next_audit_due_date` DATE COMMENT 'Scheduled date for the next surveillance or renewal audit for this vendors certification. Used for compliance calendar management.',
    `notes` STRING COMMENT 'Free-text field for additional context about this vendors certification holding, such as special conditions, audit findings, or renewal negotiations.',
    `renewal_date` DATE COMMENT 'The date on which this vendor renewed this certification. Tracks renewal history for this vendor-certification relationship.',
    `responsible_party_name` STRING COMMENT 'The name of the individual or team at Apparel Fashion responsible for managing this vendors certification relationship and renewal tracking.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this vendor certification record was last updated.',
    CONSTRAINT pk_vendor_certification PRIMARY KEY(`vendor_certification_id`)
) COMMENT 'This association product represents the certification holdings of vendors in the apparel-fashion supply chain. It captures which certifications each vendor holds, the scope of certification at the vendor level, validity periods, renewal schedules, and costs. Each record links one vendor to one compliance certification with attributes that exist only in the context of this vendor-specific certification holding.. Existence Justification: In apparel-fashion supply chain operations, vendors hold multiple certifications (WRAP, BSCI, GOTS, ISO 9001, bluesign, etc.) simultaneously, and each certification standard is held by multiple vendors across the supply base. The business actively manages vendor-specific certification holdings with distinct effective dates, expiry dates, renewal schedules, costs, certificate numbers, and scope definitions (facility-level vs organization-level). Sourcing teams query which vendors hold which active certifications to determine order placement eligibility and compliance risk.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`supplier`.`vendor_substance_compliance` (
    `vendor_substance_compliance_id` BIGINT COMMENT 'Unique identifier for this vendor-substance compliance record. Primary key.',
    `restricted_substance_id` BIGINT COMMENT 'Foreign key linking to the restricted substance being tested for in vendor materials',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to the vendor being tested for substance compliance',
    `compliance_notes` STRING COMMENT 'Free-text field for compliance team notes specific to this vendor-substance relationship, including corrective actions, special conditions, or monitoring requirements',
    `compliance_status` STRING COMMENT 'Current compliance status of this vendor for this specific restricted substance based on test results and regulatory requirements',
    `concentration_unit` STRING COMMENT 'Unit of measure for the measured_concentration value',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this vendor-substance compliance record was first created in the system',
    `exemption_flag` BOOLEAN COMMENT 'Indicates whether this vendor has been granted an exemption or derogation for this specific substance based on material type, product category, or regulatory conditions',
    `is_active` BOOLEAN COMMENT 'Indicates whether this vendor-substance compliance monitoring relationship is currently active and requires ongoing testing',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this vendor-substance compliance record was last updated',
    `last_test_date` DATE COMMENT 'Date when this vendor was last tested for this specific restricted substance',
    `measured_concentration` DECIMAL(18,2) COMMENT 'Actual measured concentration of the restricted substance found in the vendors materials during the most recent test',
    `modified_by` STRING COMMENT 'User ID or name of the compliance team member who last modified this record',
    `next_test_due_date` DATE COMMENT 'Calculated date when the next compliance test is due for this vendor-substance combination based on test_frequency',
    `risk_level` STRING COMMENT 'Risk assessment level for this vendor-substance combination based on material type, product category, and historical test results',
    `test_frequency` STRING COMMENT 'Required frequency of testing for this vendor-substance combination based on risk assessment and contractual agreements',
    `test_method` STRING COMMENT 'Specific test method or protocol used by this vendor to detect and quantify this substance (may differ from standard test_method_standard in restricted_substance based on vendor capabilities and agreements)',
    `test_report_reference` STRING COMMENT 'Reference number or document ID for the most recent test report for this vendor-substance combination',
    `test_result` STRING COMMENT 'Most recent test result for this vendor-substance combination indicating whether the vendors materials comply with threshold limits',
    `testing_lab_name` STRING COMMENT 'Name of the third-party testing laboratory used by this vendor for this substance testing',
    CONSTRAINT pk_vendor_substance_compliance PRIMARY KEY(`vendor_substance_compliance_id`)
) COMMENT 'This association product represents the compliance testing and monitoring relationship between vendors and restricted substances in the apparel-fashion supply chain. It captures vendor-specific testing protocols, test results, and compliance status for chemical management and product safety clearance. Each record links one vendor to one restricted substance with attributes that exist only in the context of this compliance relationship, enabling tracking of which vendors have been tested for which substances, when, and with what results.. Existence Justification: In apparel-fashion supply chain operations, vendors must comply with multiple restricted substance regulations (REACH, Prop 65, CPSIA), and each restricted substance applies to multiple vendors. The business actively manages vendor-specific testing protocols, test schedules, test results, and compliance status for each vendor-substance combination as part of chemical management and product safety clearance processes. This is an operational compliance monitoring relationship, not an analytical correlation.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`supplier_factory` ADD CONSTRAINT `fk_supplier_supplier_factory_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `apparel_fashion_ecm`.`supplier`.`vendor`(`vendor_id`);
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_contact` ADD CONSTRAINT `fk_supplier_vendor_contact_supplier_factory_id` FOREIGN KEY (`supplier_factory_id`) REFERENCES `apparel_fashion_ecm`.`supplier`.`supplier_factory`(`supplier_factory_id`);
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_contact` ADD CONSTRAINT `fk_supplier_vendor_contact_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `apparel_fashion_ecm`.`supplier`.`vendor`(`vendor_id`);
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_bank_account` ADD CONSTRAINT `fk_supplier_vendor_bank_account_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `apparel_fashion_ecm`.`supplier`.`vendor`(`vendor_id`);
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`compliance_audit` ADD CONSTRAINT `fk_supplier_compliance_audit_supplier_factory_id` FOREIGN KEY (`supplier_factory_id`) REFERENCES `apparel_fashion_ecm`.`supplier`.`supplier_factory`(`supplier_factory_id`);
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`compliance_audit` ADD CONSTRAINT `fk_supplier_compliance_audit_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `apparel_fashion_ecm`.`supplier`.`vendor`(`vendor_id`);
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`supplier_audit_finding` ADD CONSTRAINT `fk_supplier_supplier_audit_finding_compliance_audit_id` FOREIGN KEY (`compliance_audit_id`) REFERENCES `apparel_fashion_ecm`.`supplier`.`compliance_audit`(`compliance_audit_id`);
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`capacity_profile` ADD CONSTRAINT `fk_supplier_capacity_profile_supplier_factory_id` FOREIGN KEY (`supplier_factory_id`) REFERENCES `apparel_fashion_ecm`.`supplier`.`supplier_factory`(`supplier_factory_id`);
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`capacity_profile` ADD CONSTRAINT `fk_supplier_capacity_profile_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `apparel_fashion_ecm`.`supplier`.`vendor`(`vendor_id`);
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_scorecard` ADD CONSTRAINT `fk_supplier_vendor_scorecard_supplier_factory_id` FOREIGN KEY (`supplier_factory_id`) REFERENCES `apparel_fashion_ecm`.`supplier`.`supplier_factory`(`supplier_factory_id`);
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_scorecard` ADD CONSTRAINT `fk_supplier_vendor_scorecard_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `apparel_fashion_ecm`.`supplier`.`vendor`(`vendor_id`);
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`risk_assessment` ADD CONSTRAINT `fk_supplier_risk_assessment_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `apparel_fashion_ecm`.`supplier`.`vendor`(`vendor_id`);
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_agreement` ADD CONSTRAINT `fk_supplier_vendor_agreement_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `apparel_fashion_ecm`.`supplier`.`vendor`(`vendor_id`);
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_document` ADD CONSTRAINT `fk_supplier_vendor_document_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `apparel_fashion_ecm`.`supplier`.`vendor`(`vendor_id`);
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`supplier_material_supplier` ADD CONSTRAINT `fk_supplier_supplier_material_supplier_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `apparel_fashion_ecm`.`supplier`.`vendor`(`vendor_id`);
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`delivery_schedule` ADD CONSTRAINT `fk_supplier_delivery_schedule_supplier_factory_id` FOREIGN KEY (`supplier_factory_id`) REFERENCES `apparel_fashion_ecm`.`supplier`.`supplier_factory`(`supplier_factory_id`);
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`delivery_schedule` ADD CONSTRAINT `fk_supplier_delivery_schedule_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `apparel_fashion_ecm`.`supplier`.`vendor`(`vendor_id`);
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`sustainability_profile` ADD CONSTRAINT `fk_supplier_sustainability_profile_supplier_factory_id` FOREIGN KEY (`supplier_factory_id`) REFERENCES `apparel_fashion_ecm`.`supplier`.`supplier_factory`(`supplier_factory_id`);
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`sustainability_profile` ADD CONSTRAINT `fk_supplier_sustainability_profile_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `apparel_fashion_ecm`.`supplier`.`vendor`(`vendor_id`);
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`cmt_agreement` ADD CONSTRAINT `fk_supplier_cmt_agreement_vendor_agreement_id` FOREIGN KEY (`vendor_agreement_id`) REFERENCES `apparel_fashion_ecm`.`supplier`.`vendor_agreement`(`vendor_agreement_id`);
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`cmt_agreement` ADD CONSTRAINT `fk_supplier_cmt_agreement_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `apparel_fashion_ecm`.`supplier`.`vendor`(`vendor_id`);
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`cmt_agreement` ADD CONSTRAINT `fk_supplier_cmt_agreement_renewed_cmt_agreement_id` FOREIGN KEY (`renewed_cmt_agreement_id`) REFERENCES `apparel_fashion_ecm`.`supplier`.`cmt_agreement`(`cmt_agreement_id`);
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`oem_odm_agreement` ADD CONSTRAINT `fk_supplier_oem_odm_agreement_vendor_agreement_id` FOREIGN KEY (`vendor_agreement_id`) REFERENCES `apparel_fashion_ecm`.`supplier`.`vendor_agreement`(`vendor_agreement_id`);
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`oem_odm_agreement` ADD CONSTRAINT `fk_supplier_oem_odm_agreement_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `apparel_fashion_ecm`.`supplier`.`vendor`(`vendor_id`);
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`oem_odm_agreement` ADD CONSTRAINT `fk_supplier_oem_odm_agreement_renewed_oem_odm_agreement_id` FOREIGN KEY (`renewed_oem_odm_agreement_id`) REFERENCES `apparel_fashion_ecm`.`supplier`.`oem_odm_agreement`(`oem_odm_agreement_id`);
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`factory_sourcing_allocation` ADD CONSTRAINT `fk_supplier_factory_sourcing_allocation_factory_supplier_factory_id` FOREIGN KEY (`factory_supplier_factory_id`) REFERENCES `apparel_fashion_ecm`.`supplier`.`supplier_factory`(`supplier_factory_id`);
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`factory_sourcing_allocation` ADD CONSTRAINT `fk_supplier_factory_sourcing_allocation_supplier_factory_id` FOREIGN KEY (`supplier_factory_id`) REFERENCES `apparel_fashion_ecm`.`supplier`.`supplier_factory`(`supplier_factory_id`);
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_defect_occurrence` ADD CONSTRAINT `fk_supplier_vendor_defect_occurrence_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `apparel_fashion_ecm`.`supplier`.`vendor`(`vendor_id`);
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_quality_compliance` ADD CONSTRAINT `fk_supplier_vendor_quality_compliance_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `apparel_fashion_ecm`.`supplier`.`vendor`(`vendor_id`);
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_relationship` ADD CONSTRAINT `fk_supplier_vendor_relationship_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `apparel_fashion_ecm`.`supplier`.`vendor`(`vendor_id`);
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_certification` ADD CONSTRAINT `fk_supplier_vendor_certification_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `apparel_fashion_ecm`.`supplier`.`vendor`(`vendor_id`);
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_substance_compliance` ADD CONSTRAINT `fk_supplier_vendor_substance_compliance_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `apparel_fashion_ecm`.`supplier`.`vendor`(`vendor_id`);

-- ========= TAGS =========
ALTER SCHEMA `apparel_fashion_ecm`.`supplier` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `apparel_fashion_ecm`.`supplier` SET TAGS ('dbx_domain' = 'supplier');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor` SET TAGS ('dbx_subdomain' = 'partner_management');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Identifier (ID)');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor` ALTER COLUMN `bank_account_number` SET TAGS ('dbx_business_glossary_term' = 'Bank Account Number');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor` ALTER COLUMN `bank_account_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor` ALTER COLUMN `bank_account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor` ALTER COLUMN `bank_name` SET TAGS ('dbx_business_glossary_term' = 'Bank Name');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor` ALTER COLUMN `business_registration_number` SET TAGS ('dbx_business_glossary_term' = 'Business Registration Number');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor` ALTER COLUMN `business_status` SET TAGS ('dbx_business_glossary_term' = 'Business Status');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor` ALTER COLUMN `business_status` SET TAGS ('dbx_value_regex' = 'Active|Inactive|Suspended|Pending Approval|Blocked|Terminated');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor` ALTER COLUMN `compliance_certifications` SET TAGS ('dbx_business_glossary_term' = 'Compliance Certifications');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_business_glossary_term' = 'Country of Origin');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor` ALTER COLUMN `edi_capable_flag` SET TAGS ('dbx_business_glossary_term' = 'Electronic Data Interchange (EDI) Capable Flag');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor` ALTER COLUMN `final_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Final Approval Date');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor` ALTER COLUMN `fob_port` SET TAGS ('dbx_business_glossary_term' = 'Free On Board (FOB) Port');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor` ALTER COLUMN `go_live_date` SET TAGS ('dbx_business_glossary_term' = 'Go-Live Date');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor` ALTER COLUMN `headquarters_address` SET TAGS ('dbx_business_glossary_term' = 'Headquarters Address');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor` ALTER COLUMN `headquarters_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor` ALTER COLUMN `headquarters_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor` ALTER COLUMN `incoterms` SET TAGS ('dbx_business_glossary_term' = 'International Commercial Terms (Incoterms)');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor` ALTER COLUMN `last_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Last Audit Date');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor` ALTER COLUMN `lc_terms_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Letter of Credit (LC) Terms Required Flag');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time in Days');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor` ALTER COLUMN `legal_entity_name` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Name');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor` ALTER COLUMN `moq_units` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity (MOQ) in Units');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor` ALTER COLUMN `moq_value` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity (MOQ) Value');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor` ALTER COLUMN `next_audit_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Audit Due Date');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor` ALTER COLUMN `onboarding_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Onboarding Completion Date');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor` ALTER COLUMN `onboarding_completion_percentage` SET TAGS ('dbx_business_glossary_term' = 'Onboarding Completion Percentage');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor` ALTER COLUMN `onboarding_manager` SET TAGS ('dbx_business_glossary_term' = 'Onboarding Manager');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor` ALTER COLUMN `onboarding_stage` SET TAGS ('dbx_business_glossary_term' = 'Onboarding Stage');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor` ALTER COLUMN `preferred_vendor_flag` SET TAGS ('dbx_business_glossary_term' = 'Preferred Vendor Flag');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Email Address');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Name');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Phone Number');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor` ALTER COLUMN `production_capacity_units_per_month` SET TAGS ('dbx_business_glossary_term' = 'Production Capacity in Units Per Month');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor` ALTER COLUMN `quality_rating_score` SET TAGS ('dbx_business_glossary_term' = 'Quality Rating Score');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Risk Score');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor` ALTER COLUMN `swift_code` SET TAGS ('dbx_business_glossary_term' = 'Society for Worldwide Interbank Financial Telecommunication (SWIFT) Code');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor` ALTER COLUMN `swift_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{6}[A-Z0-9]{2}([A-Z0-9]{3})?$');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor` ALTER COLUMN `swift_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor` ALTER COLUMN `swift_code` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor` ALTER COLUMN `target_go_live_date` SET TAGS ('dbx_business_glossary_term' = 'Target Go-Live Date');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor` ALTER COLUMN `tax_id_number` SET TAGS ('dbx_business_glossary_term' = 'Tax Identification (ID) Number');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor` ALTER COLUMN `tax_id_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor` ALTER COLUMN `tier_classification` SET TAGS ('dbx_business_glossary_term' = 'Tier Classification');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor` ALTER COLUMN `tier_classification` SET TAGS ('dbx_value_regex' = 'Tier 1|Tier 2|Tier 3|Tier 4');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor` ALTER COLUMN `vendor_code` SET TAGS ('dbx_business_glossary_term' = 'Vendor Code');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor` ALTER COLUMN `vendor_type` SET TAGS ('dbx_business_glossary_term' = 'Vendor Type');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor` ALTER COLUMN `vmi_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Vendor Managed Inventory (VMI) Eligible Flag');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`supplier_factory` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`supplier_factory` SET TAGS ('dbx_subdomain' = 'partner_management');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`supplier_factory` ALTER COLUMN `supplier_factory_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Factory ID');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`supplier_factory` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Factory Manager Employee Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`supplier_factory` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`supplier_factory` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`supplier_factory` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`supplier_factory` ALTER COLUMN `address_line_1` SET TAGS ('dbx_business_glossary_term' = 'Address Line 1');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`supplier_factory` ALTER COLUMN `address_line_1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`supplier_factory` ALTER COLUMN `address_line_1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`supplier_factory` ALTER COLUMN `address_line_2` SET TAGS ('dbx_business_glossary_term' = 'Address Line 2');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`supplier_factory` ALTER COLUMN `address_line_2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`supplier_factory` ALTER COLUMN `address_line_2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`supplier_factory` ALTER COLUMN `audit_score` SET TAGS ('dbx_business_glossary_term' = 'Audit Score');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`supplier_factory` ALTER COLUMN `certifications` SET TAGS ('dbx_business_glossary_term' = 'Factory Certifications');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`supplier_factory` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`supplier_factory` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`supplier_factory` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`supplier_factory` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`supplier_factory` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`supplier_factory` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`supplier_factory` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`supplier_factory` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`supplier_factory` ALTER COLUMN `email_address` SET TAGS ('dbx_business_glossary_term' = 'Email Address');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`supplier_factory` ALTER COLUMN `email_address` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`supplier_factory` ALTER COLUMN `email_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`supplier_factory` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`supplier_factory` ALTER COLUMN `established_date` SET TAGS ('dbx_business_glossary_term' = 'Established Date');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`supplier_factory` ALTER COLUMN `factory_code` SET TAGS ('dbx_business_glossary_term' = 'Factory Code');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`supplier_factory` ALTER COLUMN `factory_name` SET TAGS ('dbx_business_glossary_term' = 'Factory Name');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`supplier_factory` ALTER COLUMN `factory_type` SET TAGS ('dbx_business_glossary_term' = 'Factory Type');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`supplier_factory` ALTER COLUMN `floor_area_sqm` SET TAGS ('dbx_business_glossary_term' = 'Floor Area Square Meters');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`supplier_factory` ALTER COLUMN `gender_specialization` SET TAGS ('dbx_business_glossary_term' = 'Gender Specialization');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`supplier_factory` ALTER COLUMN `gender_specialization` SET TAGS ('dbx_value_regex' = 'Menswear|Womenswear|Kidswear|Unisex|All');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`supplier_factory` ALTER COLUMN `gender_specialization` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`supplier_factory` ALTER COLUMN `gender_specialization` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`supplier_factory` ALTER COLUMN `incoterms` SET TAGS ('dbx_business_glossary_term' = 'International Commercial Terms (Incoterms)');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`supplier_factory` ALTER COLUMN `last_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Last Audit Date');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`supplier_factory` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`supplier_factory` ALTER COLUMN `last_order_date` SET TAGS ('dbx_business_glossary_term' = 'Last Order Date');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`supplier_factory` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time Days');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`supplier_factory` ALTER COLUMN `machinery_types` SET TAGS ('dbx_business_glossary_term' = 'Machinery Types');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`supplier_factory` ALTER COLUMN `moq_units` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity (MOQ) Units');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`supplier_factory` ALTER COLUMN `next_audit_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Audit Due Date');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`supplier_factory` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Factory Notes');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`supplier_factory` ALTER COLUMN `number_of_production_lines` SET TAGS ('dbx_business_glossary_term' = 'Number of Production Lines');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`supplier_factory` ALTER COLUMN `onboarding_date` SET TAGS ('dbx_business_glossary_term' = 'Onboarding Date');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`supplier_factory` ALTER COLUMN `operational_status` SET TAGS ('dbx_business_glossary_term' = 'Operational Status');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`supplier_factory` ALTER COLUMN `operational_status` SET TAGS ('dbx_value_regex' = 'Active|Inactive|Suspended|Under Audit|Pending Approval|Decommissioned');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`supplier_factory` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`supplier_factory` ALTER COLUMN `phone_number` SET TAGS ('dbx_business_glossary_term' = 'Phone Number');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`supplier_factory` ALTER COLUMN `phone_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`supplier_factory` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`supplier_factory` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`supplier_factory` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`supplier_factory` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`supplier_factory` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Name');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`supplier_factory` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`supplier_factory` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`supplier_factory` ALTER COLUMN `primary_contact_title` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Title');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`supplier_factory` ALTER COLUMN `product_categories_manufactured` SET TAGS ('dbx_business_glossary_term' = 'Product Categories Manufactured');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`supplier_factory` ALTER COLUMN `production_capacity_units_per_month` SET TAGS ('dbx_business_glossary_term' = 'Production Capacity Units Per Month');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`supplier_factory` ALTER COLUMN `region` SET TAGS ('dbx_business_glossary_term' = 'Geographic Region');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`supplier_factory` ALTER COLUMN `risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Risk Rating');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`supplier_factory` ALTER COLUMN `risk_rating` SET TAGS ('dbx_value_regex' = 'Low|Medium|High|Critical');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`supplier_factory` ALTER COLUMN `shift_structure` SET TAGS ('dbx_business_glossary_term' = 'Shift Structure');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`supplier_factory` ALTER COLUMN `shift_structure` SET TAGS ('dbx_value_regex' = 'Single Shift|Double Shift|Triple Shift|Flexible');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`supplier_factory` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'State or Province');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`supplier_factory` ALTER COLUMN `state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`supplier_factory` ALTER COLUMN `state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`supplier_factory` ALTER COLUMN `workforce_headcount` SET TAGS ('dbx_business_glossary_term' = 'Workforce Headcount');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_contact` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_contact` SET TAGS ('dbx_subdomain' = 'partner_management');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_contact` ALTER COLUMN `vendor_contact_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Contact ID');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_contact` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Internal Relationship Owner Employee Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_contact` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_contact` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_contact` ALTER COLUMN `supplier_factory_id` SET TAGS ('dbx_business_glossary_term' = 'Factory Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_contact` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_contact` ALTER COLUMN `authorization_level` SET TAGS ('dbx_business_glossary_term' = 'Authorization Level');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_contact` ALTER COLUMN `certification_credentials` SET TAGS ('dbx_business_glossary_term' = 'Certification Credentials');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_contact` ALTER COLUMN `contact_first_name` SET TAGS ('dbx_business_glossary_term' = 'Contact First Name');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_contact` ALTER COLUMN `contact_first_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_contact` ALTER COLUMN `contact_first_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_contact` ALTER COLUMN `contact_full_name` SET TAGS ('dbx_business_glossary_term' = 'Contact Full Name');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_contact` ALTER COLUMN `contact_full_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_contact` ALTER COLUMN `contact_full_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_contact` ALTER COLUMN `contact_last_name` SET TAGS ('dbx_business_glossary_term' = 'Contact Last Name');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_contact` ALTER COLUMN `contact_last_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_contact` ALTER COLUMN `contact_last_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_contact` ALTER COLUMN `contact_status` SET TAGS ('dbx_business_glossary_term' = 'Contact Status');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_contact` ALTER COLUMN `contact_status` SET TAGS ('dbx_value_regex' = 'Active|Inactive|On Leave|Terminated|Transferred');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_contact` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_contact` ALTER COLUMN `department` SET TAGS ('dbx_business_glossary_term' = 'Department');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_contact` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_contact` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_contact` ALTER COLUMN `email_address` SET TAGS ('dbx_business_glossary_term' = 'Email Address');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_contact` ALTER COLUMN `email_address` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_contact` ALTER COLUMN `email_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_contact` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_contact` ALTER COLUMN `emergency_contact_number` SET TAGS ('dbx_business_glossary_term' = 'Emergency Contact Number');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_contact` ALTER COLUMN `emergency_contact_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_contact` ALTER COLUMN `emergency_contact_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_contact` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active Flag');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_contact` ALTER COLUMN `is_primary_contact` SET TAGS ('dbx_business_glossary_term' = 'Is Primary Contact Flag');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_contact` ALTER COLUMN `job_title` SET TAGS ('dbx_business_glossary_term' = 'Job Title');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_contact` ALTER COLUMN `language_preference` SET TAGS ('dbx_business_glossary_term' = 'Language Preference');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_contact` ALTER COLUMN `last_contact_date` SET TAGS ('dbx_business_glossary_term' = 'Last Contact Date');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_contact` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_contact` ALTER COLUMN `mobile_number` SET TAGS ('dbx_business_glossary_term' = 'Mobile Number');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_contact` ALTER COLUMN `mobile_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_contact` ALTER COLUMN `mobile_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_contact` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_contact` ALTER COLUMN `office_location` SET TAGS ('dbx_business_glossary_term' = 'Office Location');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_contact` ALTER COLUMN `phone_number` SET TAGS ('dbx_business_glossary_term' = 'Phone Number');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_contact` ALTER COLUMN `phone_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_contact` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_contact` ALTER COLUMN `preferred_communication_channel` SET TAGS ('dbx_business_glossary_term' = 'Preferred Communication Channel');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_contact` ALTER COLUMN `preferred_communication_channel` SET TAGS ('dbx_value_regex' = 'Email|Phone|WhatsApp|WeChat|Video Call|In-Person');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_contact` ALTER COLUMN `reporting_manager_name` SET TAGS ('dbx_business_glossary_term' = 'Reporting Manager Name');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_contact` ALTER COLUMN `role_type` SET TAGS ('dbx_business_glossary_term' = 'Role Type');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_contact` ALTER COLUMN `role_type` SET TAGS ('dbx_value_regex' = 'Account Manager|QC Liaison|Compliance Officer|Logistics Coordinator|Finance Contact|Production Manager');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_contact` ALTER COLUMN `specialization_area` SET TAGS ('dbx_business_glossary_term' = 'Specialization Area');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_contact` ALTER COLUMN `time_zone` SET TAGS ('dbx_business_glossary_term' = 'Time Zone');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_contact` ALTER COLUMN `wechat_handle` SET TAGS ('dbx_business_glossary_term' = 'WeChat Handle');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_contact` ALTER COLUMN `wechat_handle` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_contact` ALTER COLUMN `wechat_handle` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_contact` ALTER COLUMN `whatsapp_handle` SET TAGS ('dbx_business_glossary_term' = 'WhatsApp Handle');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_contact` ALTER COLUMN `whatsapp_handle` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_contact` ALTER COLUMN `whatsapp_handle` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_contact` ALTER COLUMN `years_of_experience` SET TAGS ('dbx_business_glossary_term' = 'Years of Experience');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_bank_account` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_bank_account` SET TAGS ('dbx_subdomain' = 'partner_management');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_bank_account` ALTER COLUMN `vendor_bank_account_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Bank Account ID');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_bank_account` ALTER COLUMN `vendor_bank_account_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_bank_account` ALTER COLUMN `vendor_bank_account_id` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_bank_account` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_bank_account` ALTER COLUMN `account_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Account Currency Code');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_bank_account` ALTER COLUMN `account_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_bank_account` ALTER COLUMN `account_holder_name` SET TAGS ('dbx_business_glossary_term' = 'Account Holder Name');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_bank_account` ALTER COLUMN `account_holder_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_bank_account` ALTER COLUMN `account_number` SET TAGS ('dbx_business_glossary_term' = 'Account Number');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_bank_account` ALTER COLUMN `account_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_bank_account` ALTER COLUMN `account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_bank_account` ALTER COLUMN `account_status` SET TAGS ('dbx_business_glossary_term' = 'Account Status');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_bank_account` ALTER COLUMN `account_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|pending_verification|closed');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_bank_account` ALTER COLUMN `account_type` SET TAGS ('dbx_business_glossary_term' = 'Account Type');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_bank_account` ALTER COLUMN `account_type` SET TAGS ('dbx_value_regex' = 'checking|savings|current|business|escrow|other');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_bank_account` ALTER COLUMN `bank_address` SET TAGS ('dbx_business_glossary_term' = 'Bank Address');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_bank_account` ALTER COLUMN `bank_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_bank_account` ALTER COLUMN `bank_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_bank_account` ALTER COLUMN `bank_branch_code` SET TAGS ('dbx_business_glossary_term' = 'Bank Branch Code');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_bank_account` ALTER COLUMN `bank_branch_name` SET TAGS ('dbx_business_glossary_term' = 'Bank Branch Name');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_bank_account` ALTER COLUMN `bank_country_code` SET TAGS ('dbx_business_glossary_term' = 'Bank Country Code');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_bank_account` ALTER COLUMN `bank_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_bank_account` ALTER COLUMN `bank_name` SET TAGS ('dbx_business_glossary_term' = 'Bank Name');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_bank_account` ALTER COLUMN `beneficiary_address` SET TAGS ('dbx_business_glossary_term' = 'Beneficiary Address');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_bank_account` ALTER COLUMN `beneficiary_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_bank_account` ALTER COLUMN `beneficiary_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_bank_account` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_bank_account` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_bank_account` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_bank_account` ALTER COLUMN `external_reference_code` SET TAGS ('dbx_business_glossary_term' = 'External Reference ID');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_bank_account` ALTER COLUMN `iban` SET TAGS ('dbx_business_glossary_term' = 'International Bank Account Number (IBAN)');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_bank_account` ALTER COLUMN `iban` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}[0-9]{2}[A-Z0-9]+$');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_bank_account` ALTER COLUMN `iban` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_bank_account` ALTER COLUMN `iban` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_bank_account` ALTER COLUMN `intermediary_bank_name` SET TAGS ('dbx_business_glossary_term' = 'Intermediary Bank Name');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_bank_account` ALTER COLUMN `intermediary_bank_swift_code` SET TAGS ('dbx_business_glossary_term' = 'Intermediary Bank Society for Worldwide Interbank Financial Telecommunication (SWIFT) Code');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_bank_account` ALTER COLUMN `intermediary_bank_swift_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{4}[A-Z]{2}[A-Z0-9]{2}([A-Z0-9]{3})?$');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_bank_account` ALTER COLUMN `intermediary_bank_swift_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_bank_account` ALTER COLUMN `intermediary_bank_swift_code` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_bank_account` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_bank_account` ALTER COLUMN `last_payment_amount` SET TAGS ('dbx_business_glossary_term' = 'Last Payment Amount');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_bank_account` ALTER COLUMN `last_payment_date` SET TAGS ('dbx_business_glossary_term' = 'Last Payment Date');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_bank_account` ALTER COLUMN `lc_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Letter of Credit (LC) Expiry Date');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_bank_account` ALTER COLUMN `lc_issuing_bank` SET TAGS ('dbx_business_glossary_term' = 'Letter of Credit (LC) Issuing Bank');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_bank_account` ALTER COLUMN `lc_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Letter of Credit (LC) Required Flag');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_bank_account` ALTER COLUMN `lc_terms` SET TAGS ('dbx_business_glossary_term' = 'Letter of Credit (LC) Terms');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_bank_account` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_bank_account` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_bank_account` ALTER COLUMN `payment_priority` SET TAGS ('dbx_business_glossary_term' = 'Payment Priority');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_bank_account` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_bank_account` ALTER COLUMN `primary_account_flag` SET TAGS ('dbx_business_glossary_term' = 'Primary Account Flag');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_bank_account` ALTER COLUMN `routing_number` SET TAGS ('dbx_business_glossary_term' = 'Routing Number');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_bank_account` ALTER COLUMN `routing_number` SET TAGS ('dbx_value_regex' = '^[0-9]{9}$');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_bank_account` ALTER COLUMN `routing_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_bank_account` ALTER COLUMN `routing_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_bank_account` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_bank_account` ALTER COLUMN `special_instructions` SET TAGS ('dbx_business_glossary_term' = 'Special Instructions');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_bank_account` ALTER COLUMN `swift_code` SET TAGS ('dbx_business_glossary_term' = 'Society for Worldwide Interbank Financial Telecommunication (SWIFT) Code');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_bank_account` ALTER COLUMN `swift_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{4}[A-Z]{2}[A-Z0-9]{2}([A-Z0-9]{3})?$');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_bank_account` ALTER COLUMN `swift_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_bank_account` ALTER COLUMN `swift_code` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_bank_account` ALTER COLUMN `tax_id_number` SET TAGS ('dbx_business_glossary_term' = 'Tax Identification Number');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_bank_account` ALTER COLUMN `tax_id_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_bank_account` ALTER COLUMN `tax_id_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_bank_account` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'Verification Date');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_bank_account` ALTER COLUMN `verification_method` SET TAGS ('dbx_business_glossary_term' = 'Verification Method');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_bank_account` ALTER COLUMN `verification_method` SET TAGS ('dbx_value_regex' = 'micro_deposit|document_review|third_party|manual|bank_letter');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_bank_account` ALTER COLUMN `verification_status` SET TAGS ('dbx_business_glossary_term' = 'Verification Status');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_bank_account` ALTER COLUMN `verification_status` SET TAGS ('dbx_value_regex' = 'verified|unverified|pending|failed');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`supplier_factory_certification` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`supplier_factory_certification` SET TAGS ('dbx_subdomain' = 'compliance_assurance');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`supplier_factory_certification` ALTER COLUMN `supplier_factory_certification_id` SET TAGS ('dbx_business_glossary_term' = 'Factory Certification ID');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`supplier_factory_certification` ALTER COLUMN `compliance_certification_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Certification Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`supplier_factory_certification` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`supplier_factory_certification` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`supplier_factory_certification` ALTER COLUMN `production_factory_id` SET TAGS ('dbx_business_glossary_term' = 'Factory ID');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`supplier_factory_certification` ALTER COLUMN `accreditation_body` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Body');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`supplier_factory_certification` ALTER COLUMN `audit_date` SET TAGS ('dbx_business_glossary_term' = 'Audit Date');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`supplier_factory_certification` ALTER COLUMN `audit_grade` SET TAGS ('dbx_business_glossary_term' = 'Audit Grade');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`supplier_factory_certification` ALTER COLUMN `audit_grade` SET TAGS ('dbx_value_regex' = 'A|B|C|D|Not Graded');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`supplier_factory_certification` ALTER COLUMN `audit_report_url` SET TAGS ('dbx_business_glossary_term' = 'Audit Report URL');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`supplier_factory_certification` ALTER COLUMN `audit_report_url` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`supplier_factory_certification` ALTER COLUMN `certificate_document_url` SET TAGS ('dbx_business_glossary_term' = 'Certificate Document URL');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`supplier_factory_certification` ALTER COLUMN `certificate_document_url` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`supplier_factory_certification` ALTER COLUMN `certification_cost` SET TAGS ('dbx_business_glossary_term' = 'Certification Cost');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`supplier_factory_certification` ALTER COLUMN `certification_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`supplier_factory_certification` ALTER COLUMN `certification_cost_currency` SET TAGS ('dbx_business_glossary_term' = 'Certification Cost Currency');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`supplier_factory_certification` ALTER COLUMN `certification_cost_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`supplier_factory_certification` ALTER COLUMN `certification_level` SET TAGS ('dbx_business_glossary_term' = 'Certification Level');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`supplier_factory_certification` ALTER COLUMN `compliance_score` SET TAGS ('dbx_business_glossary_term' = 'Compliance Score');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`supplier_factory_certification` ALTER COLUMN `corrective_action_due_date` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Due Date');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`supplier_factory_certification` ALTER COLUMN `corrective_action_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Required Flag');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`supplier_factory_certification` ALTER COLUMN `corrective_action_status` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Status');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`supplier_factory_certification` ALTER COLUMN `corrective_action_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|in_progress|completed|verified|overdue');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`supplier_factory_certification` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`supplier_factory_certification` ALTER COLUMN `esg_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'ESG Reporting Flag');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`supplier_factory_certification` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_business_glossary_term' = 'Geographic Scope');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`supplier_factory_certification` ALTER COLUMN `major_findings_count` SET TAGS ('dbx_business_glossary_term' = 'Major Findings Count');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`supplier_factory_certification` ALTER COLUMN `minor_findings_count` SET TAGS ('dbx_business_glossary_term' = 'Minor Findings Count');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`supplier_factory_certification` ALTER COLUMN `next_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Next Audit Date');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`supplier_factory_certification` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`supplier_factory_certification` ALTER COLUMN `product_category_scope` SET TAGS ('dbx_business_glossary_term' = 'Product Category Scope');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`supplier_factory_certification` ALTER COLUMN `public_disclosure_flag` SET TAGS ('dbx_business_glossary_term' = 'Public Disclosure Flag');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`supplier_factory_certification` ALTER COLUMN `renewal_initiated_date` SET TAGS ('dbx_business_glossary_term' = 'Renewal Initiated Date');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`supplier_factory_certification` ALTER COLUMN `renewal_status` SET TAGS ('dbx_business_glossary_term' = 'Renewal Status');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`supplier_factory_certification` ALTER COLUMN `renewal_status` SET TAGS ('dbx_value_regex' = 'not_due|renewal_initiated|renewal_in_progress|renewal_completed|renewal_failed');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`supplier_factory_certification` ALTER COLUMN `risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Risk Rating');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`supplier_factory_certification` ALTER COLUMN `risk_rating` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`supplier_factory_certification` ALTER COLUMN `scope_of_certification` SET TAGS ('dbx_business_glossary_term' = 'Scope of Certification');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`supplier_factory_certification` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`supplier_factory_certification` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System ID');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`supplier_factory_certification` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`compliance_audit` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`compliance_audit` SET TAGS ('dbx_subdomain' = 'compliance_assurance');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`compliance_audit` ALTER COLUMN `compliance_audit_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Audit ID');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`compliance_audit` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Coordinator Employee Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`compliance_audit` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`compliance_audit` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`compliance_audit` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`compliance_audit` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`compliance_audit` ALTER COLUMN `supplier_factory_id` SET TAGS ('dbx_business_glossary_term' = 'Factory Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`compliance_audit` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`compliance_audit` ALTER COLUMN `announced_flag` SET TAGS ('dbx_business_glossary_term' = 'Announced Audit Flag');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`compliance_audit` ALTER COLUMN `audit_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Audit Cost Amount');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`compliance_audit` ALTER COLUMN `audit_cost_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`compliance_audit` ALTER COLUMN `audit_cost_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Audit Cost Currency Code');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`compliance_audit` ALTER COLUMN `audit_cost_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`compliance_audit` ALTER COLUMN `audit_date` SET TAGS ('dbx_business_glossary_term' = 'Audit Date');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`compliance_audit` ALTER COLUMN `audit_duration_days` SET TAGS ('dbx_business_glossary_term' = 'Audit Duration Days');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`compliance_audit` ALTER COLUMN `audit_end_date` SET TAGS ('dbx_business_glossary_term' = 'Audit End Date');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`compliance_audit` ALTER COLUMN `audit_framework` SET TAGS ('dbx_business_glossary_term' = 'Audit Framework');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`compliance_audit` ALTER COLUMN `audit_grade` SET TAGS ('dbx_business_glossary_term' = 'Audit Grade');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`compliance_audit` ALTER COLUMN `audit_number` SET TAGS ('dbx_business_glossary_term' = 'Audit Number');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`compliance_audit` ALTER COLUMN `audit_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`compliance_audit` ALTER COLUMN `audit_report_url` SET TAGS ('dbx_business_glossary_term' = 'Audit Report Uniform Resource Locator (URL)');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`compliance_audit` ALTER COLUMN `audit_start_date` SET TAGS ('dbx_business_glossary_term' = 'Audit Start Date');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`compliance_audit` ALTER COLUMN `audit_status` SET TAGS ('dbx_business_glossary_term' = 'Audit Status');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`compliance_audit` ALTER COLUMN `audit_status` SET TAGS ('dbx_value_regex' = 'Scheduled|In Progress|Completed|Cancelled|Pending Review');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`compliance_audit` ALTER COLUMN `audit_type` SET TAGS ('dbx_business_glossary_term' = 'Audit Type');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`compliance_audit` ALTER COLUMN `audit_type` SET TAGS ('dbx_value_regex' = 'Social Compliance|Environmental|Quality|Fire Safety|Chemical REACH|Structural Safety');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`compliance_audit` ALTER COLUMN `auditing_firm` SET TAGS ('dbx_business_glossary_term' = 'Auditing Firm');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`compliance_audit` ALTER COLUMN `auditor_name` SET TAGS ('dbx_business_glossary_term' = 'Auditor Name');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`compliance_audit` ALTER COLUMN `cap_approved_flag` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Plan (CAP) Approved Flag');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`compliance_audit` ALTER COLUMN `cap_due_date` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Plan (CAP) Due Date');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`compliance_audit` ALTER COLUMN `cap_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Plan (CAP) Required Flag');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`compliance_audit` ALTER COLUMN `cap_submitted_date` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Plan (CAP) Submitted Date');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`compliance_audit` ALTER COLUMN `certification_body` SET TAGS ('dbx_business_glossary_term' = 'Certification Body');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`compliance_audit` ALTER COLUMN `certification_valid_from_date` SET TAGS ('dbx_business_glossary_term' = 'Certification Valid From Date');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`compliance_audit` ALTER COLUMN `certification_valid_until_date` SET TAGS ('dbx_business_glossary_term' = 'Certification Valid Until Date');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`compliance_audit` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`compliance_audit` ALTER COLUMN `critical_ncr_count` SET TAGS ('dbx_business_glossary_term' = 'Critical Non-Conformance Report (NCR) Count');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`compliance_audit` ALTER COLUMN `factory_score` SET TAGS ('dbx_business_glossary_term' = 'Factory Score');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`compliance_audit` ALTER COLUMN `final_audit_status` SET TAGS ('dbx_business_glossary_term' = 'Final Audit Status');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`compliance_audit` ALTER COLUMN `final_audit_status` SET TAGS ('dbx_value_regex' = 'Pass|Conditional Pass|Fail|Pending Corrective Action|Certification Granted|Certification Denied');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`compliance_audit` ALTER COLUMN `findings_summary` SET TAGS ('dbx_business_glossary_term' = 'Findings Summary');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`compliance_audit` ALTER COLUMN `major_ncr_count` SET TAGS ('dbx_business_glossary_term' = 'Major Non-Conformance Report (NCR) Count');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`compliance_audit` ALTER COLUMN `management_interviews_count` SET TAGS ('dbx_business_glossary_term' = 'Management Interviews Count');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`compliance_audit` ALTER COLUMN `minor_ncr_count` SET TAGS ('dbx_business_glossary_term' = 'Minor Non-Conformance Report (NCR) Count');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`compliance_audit` ALTER COLUMN `next_audit_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Audit Due Date');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`compliance_audit` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`compliance_audit` ALTER COLUMN `reaudit_due_date` SET TAGS ('dbx_business_glossary_term' = 'Re-Audit Due Date');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`compliance_audit` ALTER COLUMN `reaudit_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Re-Audit Required Flag');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`compliance_audit` ALTER COLUMN `risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Risk Rating');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`compliance_audit` ALTER COLUMN `risk_rating` SET TAGS ('dbx_value_regex' = 'Low|Medium|High|Critical');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`compliance_audit` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`compliance_audit` ALTER COLUMN `worker_interviews_count` SET TAGS ('dbx_business_glossary_term' = 'Worker Interviews Count');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`supplier_audit_finding` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`supplier_audit_finding` SET TAGS ('dbx_subdomain' = 'compliance_assurance');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`supplier_audit_finding` ALTER COLUMN `supplier_audit_finding_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Audit Finding Identifier (ID)');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`supplier_audit_finding` ALTER COLUMN `compliance_audit_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Identifier (ID)');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`supplier_audit_finding` ALTER COLUMN `actual_closure_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Closure Date');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`supplier_audit_finding` ALTER COLUMN `auditor_notes` SET TAGS ('dbx_business_glossary_term' = 'Auditor Notes');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`supplier_audit_finding` ALTER COLUMN `business_impact` SET TAGS ('dbx_business_glossary_term' = 'Business Impact');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`supplier_audit_finding` ALTER COLUMN `closure_status` SET TAGS ('dbx_business_glossary_term' = 'Closure Status');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`supplier_audit_finding` ALTER COLUMN `closure_status` SET TAGS ('dbx_value_regex' = 'Open|In Progress|Pending Verification|Closed|Overdue');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`supplier_audit_finding` ALTER COLUMN `corrective_action_required` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Required');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`supplier_audit_finding` ALTER COLUMN `cost_to_remediate` SET TAGS ('dbx_business_glossary_term' = 'Cost to Remediate');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`supplier_audit_finding` ALTER COLUMN `cost_to_remediate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`supplier_audit_finding` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`supplier_audit_finding` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`supplier_audit_finding` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`supplier_audit_finding` ALTER COLUMN `escalation_date` SET TAGS ('dbx_business_glossary_term' = 'Escalation Date');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`supplier_audit_finding` ALTER COLUMN `escalation_flag` SET TAGS ('dbx_business_glossary_term' = 'Escalation Flag');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`supplier_audit_finding` ALTER COLUMN `evidence_document_url` SET TAGS ('dbx_business_glossary_term' = 'Evidence Document Uniform Resource Locator (URL)');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`supplier_audit_finding` ALTER COLUMN `evidence_document_url` SET TAGS ('dbx_value_regex' = '^https?://.*$');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`supplier_audit_finding` ALTER COLUMN `finding_category` SET TAGS ('dbx_business_glossary_term' = 'Finding Category');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`supplier_audit_finding` ALTER COLUMN `finding_category` SET TAGS ('dbx_value_regex' = 'Labor|Health & Safety|Environmental|Chemical|Fire Safety|Wages');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`supplier_audit_finding` ALTER COLUMN `finding_description` SET TAGS ('dbx_business_glossary_term' = 'Finding Description');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`supplier_audit_finding` ALTER COLUMN `finding_identified_date` SET TAGS ('dbx_business_glossary_term' = 'Finding Identified Date');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`supplier_audit_finding` ALTER COLUMN `finding_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Finding Reference Number');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`supplier_audit_finding` ALTER COLUMN `finding_reference_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]+$');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`supplier_audit_finding` ALTER COLUMN `finding_subcategory` SET TAGS ('dbx_business_glossary_term' = 'Finding Subcategory');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`supplier_audit_finding` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`supplier_audit_finding` ALTER COLUMN `previous_finding_reference` SET TAGS ('dbx_business_glossary_term' = 'Previous Finding Reference');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`supplier_audit_finding` ALTER COLUMN `regulatory_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reference');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`supplier_audit_finding` ALTER COLUMN `repeat_finding_flag` SET TAGS ('dbx_business_glossary_term' = 'Repeat Finding Flag');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`supplier_audit_finding` ALTER COLUMN `responsible_party_name` SET TAGS ('dbx_business_glossary_term' = 'Responsible Party Name');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`supplier_audit_finding` ALTER COLUMN `responsible_party_title` SET TAGS ('dbx_business_glossary_term' = 'Responsible Party Title');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`supplier_audit_finding` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Risk Score');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`supplier_audit_finding` ALTER COLUMN `root_cause_analysis` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Analysis');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`supplier_audit_finding` ALTER COLUMN `severity_level` SET TAGS ('dbx_business_glossary_term' = 'Severity Level');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`supplier_audit_finding` ALTER COLUMN `severity_level` SET TAGS ('dbx_value_regex' = 'Critical|Major|Minor|Observation');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`supplier_audit_finding` ALTER COLUMN `target_closure_date` SET TAGS ('dbx_business_glossary_term' = 'Target Closure Date');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`supplier_audit_finding` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'Verification Date');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`supplier_audit_finding` ALTER COLUMN `verification_method` SET TAGS ('dbx_business_glossary_term' = 'Verification Method');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`supplier_audit_finding` ALTER COLUMN `verification_method` SET TAGS ('dbx_value_regex' = 'Document Review|On-Site Inspection|Remote Verification|Third-Party Audit');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`supplier_audit_finding` ALTER COLUMN `verified_by` SET TAGS ('dbx_business_glossary_term' = 'Verified By');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`capacity_profile` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`capacity_profile` SET TAGS ('dbx_subdomain' = 'production_operations');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`capacity_profile` ALTER COLUMN `capacity_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Capacity Profile ID');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`capacity_profile` ALTER COLUMN `season_id` SET TAGS ('dbx_business_glossary_term' = 'Season Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`capacity_profile` ALTER COLUMN `supplier_factory_id` SET TAGS ('dbx_business_glossary_term' = 'Factory Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`capacity_profile` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`capacity_profile` ALTER COLUMN `allocated_capacity_units` SET TAGS ('dbx_business_glossary_term' = 'Allocated Capacity Units');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`capacity_profile` ALTER COLUMN `available_capacity_units` SET TAGS ('dbx_business_glossary_term' = 'Available Capacity Units');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`capacity_profile` ALTER COLUMN `capacity_confirmation_date` SET TAGS ('dbx_business_glossary_term' = 'Capacity Confirmation Date');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`capacity_profile` ALTER COLUMN `capacity_risk_level` SET TAGS ('dbx_business_glossary_term' = 'Capacity Risk Level');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`capacity_profile` ALTER COLUMN `capacity_risk_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`capacity_profile` ALTER COLUMN `capacity_status` SET TAGS ('dbx_business_glossary_term' = 'Capacity Status');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`capacity_profile` ALTER COLUMN `capacity_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|expired|pending');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`capacity_profile` ALTER COLUMN `capacity_type` SET TAGS ('dbx_business_glossary_term' = 'Capacity Type');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`capacity_profile` ALTER COLUMN `capacity_type` SET TAGS ('dbx_value_regex' = 'allocated|reserved|available|committed|planned');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`capacity_profile` ALTER COLUMN `capacity_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Capacity Unit of Measure (UOM)');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`capacity_profile` ALTER COLUMN `capacity_unit_of_measure` SET TAGS ('dbx_value_regex' = 'units|pieces|pairs|dozens|cases');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`capacity_profile` ALTER COLUMN `capacity_units_per_month` SET TAGS ('dbx_business_glossary_term' = 'Capacity Units Per Month');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`capacity_profile` ALTER COLUMN `capacity_valid_from_date` SET TAGS ('dbx_business_glossary_term' = 'Capacity Valid From Date');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`capacity_profile` ALTER COLUMN `capacity_valid_to_date` SET TAGS ('dbx_business_glossary_term' = 'Capacity Valid To Date');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`capacity_profile` ALTER COLUMN `compliance_certification_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Certification Status');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`capacity_profile` ALTER COLUMN `compliance_certification_status` SET TAGS ('dbx_value_regex' = 'certified|pending|expired|non_compliant');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`capacity_profile` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`capacity_profile` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`capacity_profile` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`capacity_profile` ALTER COLUMN `incoterms_code` SET TAGS ('dbx_business_glossary_term' = 'Incoterms Code');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`capacity_profile` ALTER COLUMN `incoterms_code` SET TAGS ('dbx_value_regex' = '^(EXW|FOB|CIF|DDP|FCA|CPT|CIP|DAP|DPU)$');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`capacity_profile` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`capacity_profile` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time Days');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`capacity_profile` ALTER COLUMN `maximum_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Maximum Order Quantity');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`capacity_profile` ALTER COLUMN `minimum_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity (MOQ)');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`capacity_profile` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`capacity_profile` ALTER COLUMN `otif_target_percentage` SET TAGS ('dbx_business_glossary_term' = 'On Time In Full (OTIF) Target Percentage');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`capacity_profile` ALTER COLUMN `payment_terms_code` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms Code');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`capacity_profile` ALTER COLUMN `payment_terms_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`capacity_profile` ALTER COLUMN `peak_season_flag` SET TAGS ('dbx_business_glossary_term' = 'Peak Season Flag');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`capacity_profile` ALTER COLUMN `planning_system_source` SET TAGS ('dbx_business_glossary_term' = 'Planning System Source');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`capacity_profile` ALTER COLUMN `product_category` SET TAGS ('dbx_business_glossary_term' = 'Product Category');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`capacity_profile` ALTER COLUMN `product_category` SET TAGS ('dbx_value_regex' = 'apparel|footwear|accessories|athletic|lifestyle|luxury');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`capacity_profile` ALTER COLUMN `product_subcategory` SET TAGS ('dbx_business_glossary_term' = 'Product Subcategory');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`capacity_profile` ALTER COLUMN `production_line_count` SET TAGS ('dbx_business_glossary_term' = 'Production Line Count');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`capacity_profile` ALTER COLUMN `quality_acceptance_rate` SET TAGS ('dbx_business_glossary_term' = 'Quality Acceptance Rate');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`capacity_profile` ALTER COLUMN `reserved_capacity_units` SET TAGS ('dbx_business_glossary_term' = 'Reserved Capacity Units');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`capacity_profile` ALTER COLUMN `shift_count` SET TAGS ('dbx_business_glossary_term' = 'Shift Count');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`capacity_profile` ALTER COLUMN `utilization_percentage` SET TAGS ('dbx_business_glossary_term' = 'Utilization Percentage');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`capacity_profile` ALTER COLUMN `workforce_headcount` SET TAGS ('dbx_business_glossary_term' = 'Workforce Headcount');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_scorecard` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_scorecard` SET TAGS ('dbx_subdomain' = 'quality_performance');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_scorecard` ALTER COLUMN `vendor_scorecard_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Scorecard ID');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_scorecard` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_scorecard` ALTER COLUMN `designer_id` SET TAGS ('dbx_business_glossary_term' = 'Designer Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_scorecard` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Evaluator Employee Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_scorecard` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_scorecard` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_scorecard` ALTER COLUMN `season_id` SET TAGS ('dbx_business_glossary_term' = 'Season Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_scorecard` ALTER COLUMN `supplier_factory_id` SET TAGS ('dbx_business_glossary_term' = 'Factory Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_scorecard` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_scorecard` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_scorecard` ALTER COLUMN `aql_defect_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Acceptable Quality Level (AQL) Defect Rate Percent');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_scorecard` ALTER COLUMN `capacity_utilization_percent` SET TAGS ('dbx_business_glossary_term' = 'Capacity Utilization Percent');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_scorecard` ALTER COLUMN `claim_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Claim Rate Percent');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_scorecard` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Comments');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_scorecard` ALTER COLUMN `compliance_audit_score` SET TAGS ('dbx_business_glossary_term' = 'Compliance Audit Score');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_scorecard` ALTER COLUMN `cost_competitiveness_index` SET TAGS ('dbx_business_glossary_term' = 'Cost Competitiveness Index');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_scorecard` ALTER COLUMN `cost_competitiveness_index` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_scorecard` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_scorecard` ALTER COLUMN `evaluation_frequency` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Frequency');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_scorecard` ALTER COLUMN `evaluation_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|semi-annually|annually|seasonal');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_scorecard` ALTER COLUMN `evaluation_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Period End Date');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_scorecard` ALTER COLUMN `evaluation_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Period Start Date');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_scorecard` ALTER COLUMN `evaluation_status` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Status');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_scorecard` ALTER COLUMN `evaluation_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|approved|published|archived');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_scorecard` ALTER COLUMN `evaluator_role` SET TAGS ('dbx_business_glossary_term' = 'Evaluator Role');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_scorecard` ALTER COLUMN `innovation_score` SET TAGS ('dbx_business_glossary_term' = 'Innovation Score');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_scorecard` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_scorecard` ALTER COLUMN `lead_time_performance_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time Performance Days');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_scorecard` ALTER COLUMN `on_time_sample_submission_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'On-Time Sample Submission Rate Percent');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_scorecard` ALTER COLUMN `order_fill_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Order Fill Rate Percent');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_scorecard` ALTER COLUMN `otif_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'On-Time In-Full (OTIF) Rate Percent');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_scorecard` ALTER COLUMN `overall_weighted_score` SET TAGS ('dbx_business_glossary_term' = 'Overall Weighted Score');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_scorecard` ALTER COLUMN `performance_tier` SET TAGS ('dbx_business_glossary_term' = 'Performance Tier');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_scorecard` ALTER COLUMN `performance_tier` SET TAGS ('dbx_value_regex' = 'preferred|approved|conditional|probation|delisted');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_scorecard` ALTER COLUMN `pp_sample_approval_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Pre-Production (PP) Sample Approval Rate Percent');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_scorecard` ALTER COLUMN `previous_tier` SET TAGS ('dbx_business_glossary_term' = 'Previous Performance Tier');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_scorecard` ALTER COLUMN `previous_tier` SET TAGS ('dbx_value_regex' = 'preferred|approved|conditional|probation|delisted');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_scorecard` ALTER COLUMN `recommended_action` SET TAGS ('dbx_business_glossary_term' = 'Recommended Action');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_scorecard` ALTER COLUMN `recommended_action` SET TAGS ('dbx_value_regex' = 'increase_allocation|maintain_allocation|reduce_allocation|remediation_plan|exit_strategy|no_action');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_scorecard` ALTER COLUMN `remediation_due_date` SET TAGS ('dbx_business_glossary_term' = 'Remediation Due Date');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_scorecard` ALTER COLUMN `remediation_plan_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Remediation Plan Required Flag');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_scorecard` ALTER COLUMN `responsiveness_rating` SET TAGS ('dbx_business_glossary_term' = 'Responsiveness Rating');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_scorecard` ALTER COLUMN `sustainability_score` SET TAGS ('dbx_business_glossary_term' = 'Sustainability Score');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_scorecard` ALTER COLUMN `tier_change_flag` SET TAGS ('dbx_business_glossary_term' = 'Tier Change Flag');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_scorecard` ALTER COLUMN `total_po_count` SET TAGS ('dbx_business_glossary_term' = 'Total Purchase Order (PO) Count');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_scorecard` ALTER COLUMN `total_po_value_usd` SET TAGS ('dbx_business_glossary_term' = 'Total Purchase Order (PO) Value United States Dollar (USD)');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_scorecard` ALTER COLUMN `total_po_value_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`risk_assessment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`risk_assessment` SET TAGS ('dbx_subdomain' = 'compliance_assurance');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`risk_assessment` ALTER COLUMN `risk_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment ID');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`risk_assessment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assessment Owner Employee Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`risk_assessment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`risk_assessment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`risk_assessment` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`risk_assessment` ALTER COLUMN `production_factory_id` SET TAGS ('dbx_business_glossary_term' = 'Factory ID');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`risk_assessment` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`risk_assessment` ALTER COLUMN `assessment_date` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Date');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`risk_assessment` ALTER COLUMN `assessment_method` SET TAGS ('dbx_business_glossary_term' = 'Assessment Method');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`risk_assessment` ALTER COLUMN `assessment_status` SET TAGS ('dbx_business_glossary_term' = 'Assessment Status');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`risk_assessment` ALTER COLUMN `assessment_status` SET TAGS ('dbx_value_regex' = 'Draft|Under Review|Approved|Closed|Escalated');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`risk_assessment` ALTER COLUMN `assessment_type` SET TAGS ('dbx_business_glossary_term' = 'Assessment Type');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`risk_assessment` ALTER COLUMN `assessment_type` SET TAGS ('dbx_value_regex' = 'Initial|Periodic|Triggered|Ad-Hoc|Pre-Qualification|Re-Assessment');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`risk_assessment` ALTER COLUMN `auditor_name` SET TAGS ('dbx_business_glossary_term' = 'Auditor Name');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`risk_assessment` ALTER COLUMN `business_impact_area` SET TAGS ('dbx_business_glossary_term' = 'Business Impact Area');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`risk_assessment` ALTER COLUMN `business_impact_area` SET TAGS ('dbx_value_regex' = 'Revenue|Cost|Brand|Operations|Compliance|Customer Satisfaction');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`risk_assessment` ALTER COLUMN `certification_reference` SET TAGS ('dbx_business_glossary_term' = 'Certification Reference');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`risk_assessment` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Assessment Comments');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`risk_assessment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`risk_assessment` ALTER COLUMN `escalation_date` SET TAGS ('dbx_business_glossary_term' = 'Escalation Date');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`risk_assessment` ALTER COLUMN `esg_flag` SET TAGS ('dbx_business_glossary_term' = 'Environmental Social Governance (ESG) Flag');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`risk_assessment` ALTER COLUMN `geographic_risk_region` SET TAGS ('dbx_business_glossary_term' = 'Geographic Risk Region');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`risk_assessment` ALTER COLUMN `impact_score` SET TAGS ('dbx_business_glossary_term' = 'Impact Score');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`risk_assessment` ALTER COLUMN `inherent_risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Inherent Risk Rating');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`risk_assessment` ALTER COLUMN `inherent_risk_rating` SET TAGS ('dbx_value_regex' = 'Low|Medium|High|Critical');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`risk_assessment` ALTER COLUMN `likelihood_score` SET TAGS ('dbx_business_glossary_term' = 'Likelihood Score');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`risk_assessment` ALTER COLUMN `mitigation_cost` SET TAGS ('dbx_business_glossary_term' = 'Mitigation Cost');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`risk_assessment` ALTER COLUMN `mitigation_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`risk_assessment` ALTER COLUMN `mitigation_status` SET TAGS ('dbx_business_glossary_term' = 'Mitigation Status');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`risk_assessment` ALTER COLUMN `mitigation_status` SET TAGS ('dbx_value_regex' = 'Not Started|In Progress|Completed|On Hold|Cancelled');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`risk_assessment` ALTER COLUMN `mitigation_strategy` SET TAGS ('dbx_business_glossary_term' = 'Mitigation Strategy');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`risk_assessment` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`risk_assessment` ALTER COLUMN `regulatory_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reference');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`risk_assessment` ALTER COLUMN `residual_risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Residual Risk Rating');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`risk_assessment` ALTER COLUMN `residual_risk_rating` SET TAGS ('dbx_value_regex' = 'Low|Medium|High|Critical');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`risk_assessment` ALTER COLUMN `resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Resolution Date');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`risk_assessment` ALTER COLUMN `review_frequency` SET TAGS ('dbx_business_glossary_term' = 'Review Frequency');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`risk_assessment` ALTER COLUMN `review_frequency` SET TAGS ('dbx_value_regex' = 'Monthly|Quarterly|Semi-Annually|Annually|As Needed');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`risk_assessment` ALTER COLUMN `risk_category` SET TAGS ('dbx_business_glossary_term' = 'Risk Category');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`risk_assessment` ALTER COLUMN `risk_description` SET TAGS ('dbx_business_glossary_term' = 'Risk Description');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`risk_assessment` ALTER COLUMN `risk_subcategory` SET TAGS ('dbx_business_glossary_term' = 'Risk Subcategory');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`risk_assessment` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Record Updated By');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`risk_assessment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`risk_assessment` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Created By');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_agreement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_agreement` SET TAGS ('dbx_subdomain' = 'partner_management');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_agreement` ALTER COLUMN `vendor_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Agreement ID');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_agreement` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_agreement` ALTER COLUMN `standard_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Standard Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_agreement` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_agreement` ALTER COLUMN `agreement_number` SET TAGS ('dbx_business_glossary_term' = 'Agreement Reference Number');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_agreement` ALTER COLUMN `agreement_number` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,4}-[0-9]{6,10}$');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_agreement` ALTER COLUMN `agreement_status` SET TAGS ('dbx_business_glossary_term' = 'Agreement Status');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_agreement` ALTER COLUMN `agreement_status` SET TAGS ('dbx_value_regex' = 'Draft|Active|Suspended|Expired|Terminated|Pending Approval');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_agreement` ALTER COLUMN `agreement_type` SET TAGS ('dbx_business_glossary_term' = 'Agreement Type');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_agreement` ALTER COLUMN `agreement_type` SET TAGS ('dbx_value_regex' = 'Master Supply Agreement|CMT Contract|FOB Contract|Fabric Supply Agreement|3PL SLA|OEM Agreement');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_agreement` ALTER COLUMN `amendment_count` SET TAGS ('dbx_business_glossary_term' = 'Amendment Count');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_agreement` ALTER COLUMN `audit_frequency` SET TAGS ('dbx_business_glossary_term' = 'Audit Frequency');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_agreement` ALTER COLUMN `audit_frequency` SET TAGS ('dbx_value_regex' = 'Annual|Semi-Annual|Quarterly|Ad-Hoc|Not Required');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_agreement` ALTER COLUMN `auto_renewal_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto-Renewal Flag');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_agreement` ALTER COLUMN `compliance_certifications_required` SET TAGS ('dbx_business_glossary_term' = 'Compliance Certifications Required');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_agreement` ALTER COLUMN `confidentiality_clause_flag` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Clause Flag');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_agreement` ALTER COLUMN `contract_value_total` SET TAGS ('dbx_business_glossary_term' = 'Contract Value Total');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_agreement` ALTER COLUMN `contract_value_total` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_agreement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_agreement` ALTER COLUMN `credit_limit_amount` SET TAGS ('dbx_business_glossary_term' = 'Credit Limit Amount');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_agreement` ALTER COLUMN `credit_limit_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_agreement` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_agreement` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_agreement` ALTER COLUMN `default_incoterm` SET TAGS ('dbx_business_glossary_term' = 'Default Incoterm');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_agreement` ALTER COLUMN `dispute_resolution_method` SET TAGS ('dbx_business_glossary_term' = 'Dispute Resolution Method');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_agreement` ALTER COLUMN `dispute_resolution_method` SET TAGS ('dbx_value_regex' = 'Arbitration|Mediation|Litigation|Negotiation');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_agreement` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_agreement` ALTER COLUMN `exclusivity_flag` SET TAGS ('dbx_business_glossary_term' = 'Exclusivity Clause Flag');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_agreement` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_agreement` ALTER COLUMN `force_majeure_clause_flag` SET TAGS ('dbx_business_glossary_term' = 'Force Majeure Clause Flag');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_agreement` ALTER COLUMN `governing_law_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Governing Law Jurisdiction');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_agreement` ALTER COLUMN `incoterms_version` SET TAGS ('dbx_business_glossary_term' = 'Incoterms Version');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_agreement` ALTER COLUMN `incoterms_version` SET TAGS ('dbx_value_regex' = 'Incoterms 2010|Incoterms 2020');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_agreement` ALTER COLUMN `insurance_requirements` SET TAGS ('dbx_business_glossary_term' = 'Insurance Requirements');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_agreement` ALTER COLUMN `ip_ownership_clause` SET TAGS ('dbx_business_glossary_term' = 'Intellectual Property (IP) Ownership Clause');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_agreement` ALTER COLUMN `ip_ownership_clause` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_agreement` ALTER COLUMN `last_amendment_date` SET TAGS ('dbx_business_glossary_term' = 'Last Amendment Date');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_agreement` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_agreement` ALTER COLUMN `liability_cap_amount` SET TAGS ('dbx_business_glossary_term' = 'Liability Cap Amount');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_agreement` ALTER COLUMN `liability_cap_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_agreement` ALTER COLUMN `minimum_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity (MOQ)');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_agreement` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Agreement Notes');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_agreement` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_agreement` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'Wire Transfer|ACH|Check|Letter of Credit|Documentary Collection');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_agreement` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_agreement` ALTER COLUMN `performance_bond_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Performance Bond Required Flag');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_agreement` ALTER COLUMN `renewal_notice_period_days` SET TAGS ('dbx_business_glossary_term' = 'Renewal Notice Period (Days)');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_agreement` ALTER COLUMN `signatory_name_buyer` SET TAGS ('dbx_business_glossary_term' = 'Signatory Name (Buyer)');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_agreement` ALTER COLUMN `signatory_name_buyer` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_agreement` ALTER COLUMN `signatory_name_vendor` SET TAGS ('dbx_business_glossary_term' = 'Signatory Name (Vendor)');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_agreement` ALTER COLUMN `signatory_name_vendor` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_agreement` ALTER COLUMN `signed_date` SET TAGS ('dbx_business_glossary_term' = 'Signed Date');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_agreement` ALTER COLUMN `termination_notice_period_days` SET TAGS ('dbx_business_glossary_term' = 'Termination Notice Period (Days)');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_document` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_document` SET TAGS ('dbx_subdomain' = 'partner_management');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_document` ALTER COLUMN `vendor_document_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Document ID');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_document` ALTER COLUMN `production_factory_id` SET TAGS ('dbx_business_glossary_term' = 'Factory ID');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_document` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_document` ALTER COLUMN `audit_date` SET TAGS ('dbx_business_glossary_term' = 'Audit Date');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_document` ALTER COLUMN `audit_score` SET TAGS ('dbx_business_glossary_term' = 'Audit Score');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_document` ALTER COLUMN `certification_body` SET TAGS ('dbx_business_glossary_term' = 'Certification Body');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_document` ALTER COLUMN `compliance_standard` SET TAGS ('dbx_business_glossary_term' = 'Compliance Standard');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_document` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_business_glossary_term' = 'Country of Origin');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_document` ALTER COLUMN `coverage_amount` SET TAGS ('dbx_business_glossary_term' = 'Coverage Amount');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_document` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_document` ALTER COLUMN `document_file_url` SET TAGS ('dbx_business_glossary_term' = 'Document File URL (Uniform Resource Locator)');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_document` ALTER COLUMN `document_number` SET TAGS ('dbx_business_glossary_term' = 'Document Number');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_document` ALTER COLUMN `document_status` SET TAGS ('dbx_business_glossary_term' = 'Document Status');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_document` ALTER COLUMN `document_title` SET TAGS ('dbx_business_glossary_term' = 'Document Title');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_document` ALTER COLUMN `document_type` SET TAGS ('dbx_business_glossary_term' = 'Document Type');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_document` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_document` ALTER COLUMN `file_format` SET TAGS ('dbx_business_glossary_term' = 'File Format');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_document` ALTER COLUMN `file_size_kb` SET TAGS ('dbx_business_glossary_term' = 'File Size (Kilobytes)');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_document` ALTER COLUMN `gsp_eligible` SET TAGS ('dbx_business_glossary_term' = 'Generalized System of Preferences (GSP) Eligible');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_document` ALTER COLUMN `hs_code` SET TAGS ('dbx_business_glossary_term' = 'Harmonized System (HS) Code');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_document` ALTER COLUMN `insurance_policy_number` SET TAGS ('dbx_business_glossary_term' = 'Insurance Policy Number');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_document` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_document` ALTER COLUMN `issue_date` SET TAGS ('dbx_business_glossary_term' = 'Issue Date');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_document` ALTER COLUMN `issuing_authority` SET TAGS ('dbx_business_glossary_term' = 'Issuing Authority');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_document` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_document` ALTER COLUMN `lc_number` SET TAGS ('dbx_business_glossary_term' = 'Letter of Credit (LC) Number');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_document` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_document` ALTER COLUMN `remarks` SET TAGS ('dbx_business_glossary_term' = 'Remarks');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_document` ALTER COLUMN `uploaded_by` SET TAGS ('dbx_business_glossary_term' = 'Uploaded By');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_document` ALTER COLUMN `uploaded_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Uploaded Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_document` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'Verification Date');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_document` ALTER COLUMN `verification_status` SET TAGS ('dbx_business_glossary_term' = 'Verification Status');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_document` ALTER COLUMN `verification_status` SET TAGS ('dbx_value_regex' = 'Not Verified|Verified|Failed|In Review|Pending');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_document` ALTER COLUMN `verified_by` SET TAGS ('dbx_business_glossary_term' = 'Verified By');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`supplier_material_supplier` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`supplier_material_supplier` SET TAGS ('dbx_subdomain' = 'production_operations');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`supplier_material_supplier` ALTER COLUMN `supplier_material_supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Material Supplier ID');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`supplier_material_supplier` ALTER COLUMN `material_id` SET TAGS ('dbx_business_glossary_term' = 'Material ID');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`supplier_material_supplier` ALTER COLUMN `print_design_id` SET TAGS ('dbx_business_glossary_term' = 'Print Design Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`supplier_material_supplier` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Technical Approver Employee Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`supplier_material_supplier` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`supplier_material_supplier` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`supplier_material_supplier` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`supplier_material_supplier` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`supplier_material_supplier` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'Approved|Pending|Suspended|Rejected|Under Review');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`supplier_material_supplier` ALTER COLUMN `approved_colorways` SET TAGS ('dbx_business_glossary_term' = 'Approved Colorways');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`supplier_material_supplier` ALTER COLUMN `capacity_per_month` SET TAGS ('dbx_business_glossary_term' = 'Capacity Per Month');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`supplier_material_supplier` ALTER COLUMN `capacity_per_month` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`supplier_material_supplier` ALTER COLUMN `composition_percentage` SET TAGS ('dbx_business_glossary_term' = 'Composition Percentage');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`supplier_material_supplier` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_business_glossary_term' = 'Country of Origin');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`supplier_material_supplier` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`supplier_material_supplier` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`supplier_material_supplier` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`supplier_material_supplier` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`supplier_material_supplier` ALTER COLUMN `delivery_performance_rating` SET TAGS ('dbx_business_glossary_term' = 'Delivery Performance Rating');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`supplier_material_supplier` ALTER COLUMN `delivery_performance_rating` SET TAGS ('dbx_value_regex' = 'A|B|C|D|F');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`supplier_material_supplier` ALTER COLUMN `effective_from_date` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`supplier_material_supplier` ALTER COLUMN `effective_to_date` SET TAGS ('dbx_business_glossary_term' = 'Effective To Date');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`supplier_material_supplier` ALTER COLUMN `fiber_content` SET TAGS ('dbx_business_glossary_term' = 'Fiber Content');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`supplier_material_supplier` ALTER COLUMN `hs_code` SET TAGS ('dbx_business_glossary_term' = 'Harmonized System (HS) Code');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`supplier_material_supplier` ALTER COLUMN `incoterms` SET TAGS ('dbx_business_glossary_term' = 'International Commercial Terms (Incoterms)');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`supplier_material_supplier` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Active Record Flag');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`supplier_material_supplier` ALTER COLUMN `is_bci_cotton` SET TAGS ('dbx_business_glossary_term' = 'Better Cotton Initiative (BCI) Cotton Flag');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`supplier_material_supplier` ALTER COLUMN `is_oeko_tex_certified` SET TAGS ('dbx_business_glossary_term' = 'OEKO-TEX Certified Flag');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`supplier_material_supplier` ALTER COLUMN `is_organic` SET TAGS ('dbx_business_glossary_term' = 'Organic Material Flag');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`supplier_material_supplier` ALTER COLUMN `is_recycled` SET TAGS ('dbx_business_glossary_term' = 'Recycled Material Flag');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`supplier_material_supplier` ALTER COLUMN `last_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Last Audit Date');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`supplier_material_supplier` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`supplier_material_supplier` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time Days');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`supplier_material_supplier` ALTER COLUMN `material_type` SET TAGS ('dbx_business_glossary_term' = 'Material Type');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`supplier_material_supplier` ALTER COLUMN `moq` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity (MOQ)');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`supplier_material_supplier` ALTER COLUMN `next_audit_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Audit Due Date');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`supplier_material_supplier` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`supplier_material_supplier` ALTER COLUMN `oeko_tex_certificate_number` SET TAGS ('dbx_business_glossary_term' = 'OEKO-TEX Certificate Number');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`supplier_material_supplier` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`supplier_material_supplier` ALTER COLUMN `preferred_supplier_flag` SET TAGS ('dbx_business_glossary_term' = 'Preferred Supplier Flag');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`supplier_material_supplier` ALTER COLUMN `qualification_date` SET TAGS ('dbx_business_glossary_term' = 'Qualification Date');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`supplier_material_supplier` ALTER COLUMN `quality_rating` SET TAGS ('dbx_business_glossary_term' = 'Quality Rating');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`supplier_material_supplier` ALTER COLUMN `quality_rating` SET TAGS ('dbx_value_regex' = 'A|B|C|D|F');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`supplier_material_supplier` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Risk Score');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`supplier_material_supplier` ALTER COLUMN `sample_lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Sample Lead Time Days');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`supplier_material_supplier` ALTER COLUMN `supplier_item_code` SET TAGS ('dbx_business_glossary_term' = 'Supplier Item Code');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`supplier_material_supplier` ALTER COLUMN `sustainability_attributes` SET TAGS ('dbx_business_glossary_term' = 'Sustainability Attributes');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`supplier_material_supplier` ALTER COLUMN `unit_cost` SET TAGS ('dbx_business_glossary_term' = 'Unit Cost');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`supplier_material_supplier` ALTER COLUMN `unit_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`supplier_material_supplier` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UoM)');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`delivery_schedule` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`delivery_schedule` SET TAGS ('dbx_subdomain' = 'production_operations');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`delivery_schedule` ALTER COLUMN `delivery_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Delivery Schedule ID');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`delivery_schedule` ALTER COLUMN `buy_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Buy Plan Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`delivery_schedule` ALTER COLUMN `concept_id` SET TAGS ('dbx_business_glossary_term' = 'Concept Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`delivery_schedule` ALTER COLUMN `inspection_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`delivery_schedule` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Planner Employee Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`delivery_schedule` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`delivery_schedule` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`delivery_schedule` ALTER COLUMN `sketch_id` SET TAGS ('dbx_business_glossary_term' = 'Design Sketch Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`delivery_schedule` ALTER COLUMN `style_id` SET TAGS ('dbx_business_glossary_term' = 'Style ID');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`delivery_schedule` ALTER COLUMN `supplier_factory_id` SET TAGS ('dbx_business_glossary_term' = 'Factory Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`delivery_schedule` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`delivery_schedule` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Production Order (PO) ID');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`delivery_schedule` ALTER COLUMN `bulk_fabric_inhouse_actual_date` SET TAGS ('dbx_business_glossary_term' = 'Bulk Fabric In-House Actual Date');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`delivery_schedule` ALTER COLUMN `bulk_fabric_inhouse_planned_date` SET TAGS ('dbx_business_glossary_term' = 'Bulk Fabric In-House Planned Date');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`delivery_schedule` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`delivery_schedule` ALTER COLUMN `critical_path_flag` SET TAGS ('dbx_business_glossary_term' = 'Critical Path Flag');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`delivery_schedule` ALTER COLUMN `cut_actual_date` SET TAGS ('dbx_business_glossary_term' = 'Cut Actual Date');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`delivery_schedule` ALTER COLUMN `cut_planned_date` SET TAGS ('dbx_business_glossary_term' = 'Cut Planned Date');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`delivery_schedule` ALTER COLUMN `design_approval_actual_date` SET TAGS ('dbx_business_glossary_term' = 'Design Approval Actual Date');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`delivery_schedule` ALTER COLUMN `design_approval_planned_date` SET TAGS ('dbx_business_glossary_term' = 'Design Approval Planned Date');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`delivery_schedule` ALTER COLUMN `escalation_flag` SET TAGS ('dbx_business_glossary_term' = 'Escalation Flag');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`delivery_schedule` ALTER COLUMN `escalation_reason` SET TAGS ('dbx_business_glossary_term' = 'Escalation Reason');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`delivery_schedule` ALTER COLUMN `ex_factory_actual_date` SET TAGS ('dbx_business_glossary_term' = 'Ex-Factory Actual Date');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`delivery_schedule` ALTER COLUMN `ex_factory_planned_date` SET TAGS ('dbx_business_glossary_term' = 'Ex-Factory Planned Date');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`delivery_schedule` ALTER COLUMN `fabric_booking_actual_date` SET TAGS ('dbx_business_glossary_term' = 'Fabric Booking Actual Date');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`delivery_schedule` ALTER COLUMN `fabric_booking_planned_date` SET TAGS ('dbx_business_glossary_term' = 'Fabric Booking Planned Date');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`delivery_schedule` ALTER COLUMN `factory_capacity_utilization_pct` SET TAGS ('dbx_business_glossary_term' = 'Factory Capacity Utilization Percentage');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`delivery_schedule` ALTER COLUMN `final_inspection_actual_date` SET TAGS ('dbx_business_glossary_term' = 'Final Inspection Actual Date');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`delivery_schedule` ALTER COLUMN `final_inspection_planned_date` SET TAGS ('dbx_business_glossary_term' = 'Final Inspection Planned Date');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`delivery_schedule` ALTER COLUMN `finishing_actual_date` SET TAGS ('dbx_business_glossary_term' = 'Finishing Actual Date');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`delivery_schedule` ALTER COLUMN `finishing_planned_date` SET TAGS ('dbx_business_glossary_term' = 'Finishing Planned Date');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`delivery_schedule` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`delivery_schedule` ALTER COLUMN `overall_days_variance` SET TAGS ('dbx_business_glossary_term' = 'Overall Days Variance');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`delivery_schedule` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`delivery_schedule` ALTER COLUMN `pp_sample_approval_actual_date` SET TAGS ('dbx_business_glossary_term' = 'Pre-Production (PP) Sample Approval Actual Date');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`delivery_schedule` ALTER COLUMN `pp_sample_approval_planned_date` SET TAGS ('dbx_business_glossary_term' = 'Pre-Production (PP) Sample Approval Planned Date');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`delivery_schedule` ALTER COLUMN `pp_sample_submission_actual_date` SET TAGS ('dbx_business_glossary_term' = 'Pre-Production (PP) Sample Submission Actual Date');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`delivery_schedule` ALTER COLUMN `pp_sample_submission_planned_date` SET TAGS ('dbx_business_glossary_term' = 'Pre-Production (PP) Sample Submission Planned Date');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`delivery_schedule` ALTER COLUMN `schedule_comments` SET TAGS ('dbx_business_glossary_term' = 'Schedule Comments');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`delivery_schedule` ALTER COLUMN `schedule_start_date` SET TAGS ('dbx_business_glossary_term' = 'Schedule Start Date');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`delivery_schedule` ALTER COLUMN `schedule_status` SET TAGS ('dbx_business_glossary_term' = 'Schedule Status');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`delivery_schedule` ALTER COLUMN `season_code` SET TAGS ('dbx_business_glossary_term' = 'Season Code');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`delivery_schedule` ALTER COLUMN `season_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`delivery_schedule` ALTER COLUMN `sew_completion_actual_date` SET TAGS ('dbx_business_glossary_term' = 'Sew Completion Actual Date');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`delivery_schedule` ALTER COLUMN `sew_completion_planned_date` SET TAGS ('dbx_business_glossary_term' = 'Sew Completion Planned Date');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`delivery_schedule` ALTER COLUMN `shipment_terms` SET TAGS ('dbx_business_glossary_term' = 'Shipment Terms (Incoterms)');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`delivery_schedule` ALTER COLUMN `shipment_terms` SET TAGS ('dbx_value_regex' = 'FOB|CIF|DDP|EXW|FCA|CPT');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`delivery_schedule` ALTER COLUMN `tech_pack_issue_actual_date` SET TAGS ('dbx_business_glossary_term' = 'Tech Pack Issue Actual Date');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`delivery_schedule` ALTER COLUMN `tech_pack_issue_planned_date` SET TAGS ('dbx_business_glossary_term' = 'Tech Pack Issue Planned Date');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`delivery_schedule` ALTER COLUMN `tna_template_version` SET TAGS ('dbx_business_glossary_term' = 'Time and Action (TNA) Template Version');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`delivery_schedule` ALTER COLUMN `tna_template_version` SET TAGS ('dbx_value_regex' = '^[A-Z0-9._-]{1,20}$');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`sustainability_profile` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`sustainability_profile` SET TAGS ('dbx_subdomain' = 'compliance_assurance');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`sustainability_profile` ALTER COLUMN `sustainability_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Sustainability Profile ID');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`sustainability_profile` ALTER COLUMN `compliance_certification_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Certification Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`sustainability_profile` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`sustainability_profile` ALTER COLUMN `supplier_factory_id` SET TAGS ('dbx_business_glossary_term' = 'Factory Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`sustainability_profile` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`sustainability_profile` ALTER COLUMN `assessment_date` SET TAGS ('dbx_business_glossary_term' = 'Last Assessment Date');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`sustainability_profile` ALTER COLUMN `audit_frequency_months` SET TAGS ('dbx_business_glossary_term' = 'Audit Frequency (Months)');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`sustainability_profile` ALTER COLUMN `bci_certified_flag` SET TAGS ('dbx_business_glossary_term' = 'Better Cotton Initiative (BCI) Certified Flag');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`sustainability_profile` ALTER COLUMN `bluesign_certified_flag` SET TAGS ('dbx_business_glossary_term' = 'Bluesign Certified Flag');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`sustainability_profile` ALTER COLUMN `carbon_footprint_tco2e_year` SET TAGS ('dbx_business_glossary_term' = 'Carbon Footprint (tCO2e per Year)');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`sustainability_profile` ALTER COLUMN `chemical_inventory_disclosed_flag` SET TAGS ('dbx_business_glossary_term' = 'Chemical Inventory Disclosed Flag');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`sustainability_profile` ALTER COLUMN `community_investment_programs` SET TAGS ('dbx_business_glossary_term' = 'Community Investment Programs');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`sustainability_profile` ALTER COLUMN `corrective_action_plan_status` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Plan (CAP) Status');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`sustainability_profile` ALTER COLUMN `corrective_action_plan_status` SET TAGS ('dbx_value_regex' = 'not_required|in_progress|completed|overdue|pending_verification');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`sustainability_profile` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`sustainability_profile` ALTER COLUMN `esg_reporting_framework` SET TAGS ('dbx_business_glossary_term' = 'Environmental Social Governance (ESG) Reporting Framework');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`sustainability_profile` ALTER COLUMN `esg_reporting_framework` SET TAGS ('dbx_value_regex' = 'GRI|SASB|TCFD|CDP|UNGC|INTEGRATED');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`sustainability_profile` ALTER COLUMN `fla_accredited_flag` SET TAGS ('dbx_business_glossary_term' = 'Fair Labor Association (FLA) Accredited Flag');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`sustainability_profile` ALTER COLUMN `gender_equality_score` SET TAGS ('dbx_business_glossary_term' = 'Gender Equality Score');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`sustainability_profile` ALTER COLUMN `gender_equality_score` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`sustainability_profile` ALTER COLUMN `gender_equality_score` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`sustainability_profile` ALTER COLUMN `gots_certified_flag` SET TAGS ('dbx_business_glossary_term' = 'Global Organic Textile Standard (GOTS) Certified Flag');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`sustainability_profile` ALTER COLUMN `higg_fem_score` SET TAGS ('dbx_business_glossary_term' = 'Higg Facility Environmental Module (FEM) Score');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`sustainability_profile` ALTER COLUMN `higg_fslm_score` SET TAGS ('dbx_business_glossary_term' = 'Higg Facility Social and Labor Module (FSLM) Score');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`sustainability_profile` ALTER COLUMN `iso_14001_certified_flag` SET TAGS ('dbx_business_glossary_term' = 'ISO 14001 Certified Flag');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`sustainability_profile` ALTER COLUMN `iso_45001_certified_flag` SET TAGS ('dbx_business_glossary_term' = 'ISO 45001 Certified Flag');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`sustainability_profile` ALTER COLUMN `living_wage_compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'Living Wage Compliant Flag');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`sustainability_profile` ALTER COLUMN `living_wage_compliant_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`sustainability_profile` ALTER COLUMN `living_wage_compliant_flag` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`sustainability_profile` ALTER COLUMN `next_assessment_date` SET TAGS ('dbx_business_glossary_term' = 'Next Assessment Date');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`sustainability_profile` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Sustainability Profile Notes');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`sustainability_profile` ALTER COLUMN `oeko_tex_certified_flag` SET TAGS ('dbx_business_glossary_term' = 'OEKO-TEX Standard 100 Certified Flag');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`sustainability_profile` ALTER COLUMN `profile_name` SET TAGS ('dbx_business_glossary_term' = 'Sustainability Profile Name');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`sustainability_profile` ALTER COLUMN `profile_status` SET TAGS ('dbx_business_glossary_term' = 'Profile Status');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`sustainability_profile` ALTER COLUMN `profile_status` SET TAGS ('dbx_value_regex' = 'active|inactive|under_review|expired|suspended|pending_certification');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`sustainability_profile` ALTER COLUMN `renewable_energy_percentage` SET TAGS ('dbx_business_glossary_term' = 'Renewable Energy Percentage');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`sustainability_profile` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Sustainability Risk Score');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`sustainability_profile` ALTER COLUMN `traceability_level` SET TAGS ('dbx_business_glossary_term' = 'Supply Chain Traceability Level');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`sustainability_profile` ALTER COLUMN `traceability_level` SET TAGS ('dbx_value_regex' = 'tier_1|tier_2|tier_3|tier_4|raw_material|full_chain');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`sustainability_profile` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`sustainability_profile` ALTER COLUMN `waste_diversion_rate_percentage` SET TAGS ('dbx_business_glossary_term' = 'Waste Diversion Rate Percentage');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`sustainability_profile` ALTER COLUMN `water_usage_intensity_liters_kg` SET TAGS ('dbx_business_glossary_term' = 'Water Usage Intensity (Liters per Kilogram)');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`sustainability_profile` ALTER COLUMN `wrap_certified_flag` SET TAGS ('dbx_business_glossary_term' = 'Worldwide Responsible Accredited Production (WRAP) Certified Flag');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`sustainability_profile` ALTER COLUMN `zdhc_mrsl_compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'Zero Discharge of Hazardous Chemicals (ZDHC) Manufacturing Restricted Substances List (MRSL) Compliant Flag');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`cmt_agreement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`cmt_agreement` SET TAGS ('dbx_subdomain' = 'partner_management');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`cmt_agreement` ALTER COLUMN `cmt_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Cut-Make-Trim (CMT) Agreement ID');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`cmt_agreement` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Owner Employee Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`cmt_agreement` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`cmt_agreement` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`cmt_agreement` ALTER COLUMN `production_factory_id` SET TAGS ('dbx_business_glossary_term' = 'Factory ID');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`cmt_agreement` ALTER COLUMN `season_id` SET TAGS ('dbx_business_glossary_term' = 'Season Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`cmt_agreement` ALTER COLUMN `standard_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Standard Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`cmt_agreement` ALTER COLUMN `vendor_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Agreement Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`cmt_agreement` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`cmt_agreement` ALTER COLUMN `renewed_cmt_agreement_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`cmt_agreement` ALTER COLUMN `agreement_number` SET TAGS ('dbx_business_glossary_term' = 'Agreement Number');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`cmt_agreement` ALTER COLUMN `agreement_status` SET TAGS ('dbx_business_glossary_term' = 'Agreement Status');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`cmt_agreement` ALTER COLUMN `agreement_status` SET TAGS ('dbx_value_regex' = 'draft|pending_approval|active|suspended|expired|terminated');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`cmt_agreement` ALTER COLUMN `agreement_type` SET TAGS ('dbx_business_glossary_term' = 'Agreement Type');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`cmt_agreement` ALTER COLUMN `agreement_type` SET TAGS ('dbx_value_regex' = 'cmt|fob|cmt_plus_materials|odm|oem|full_package');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`cmt_agreement` ALTER COLUMN `amendment_count` SET TAGS ('dbx_business_glossary_term' = 'Amendment Count');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`cmt_agreement` ALTER COLUMN `audit_frequency_months` SET TAGS ('dbx_business_glossary_term' = 'Audit Frequency Months');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`cmt_agreement` ALTER COLUMN `auto_renewal_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto Renewal Flag');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`cmt_agreement` ALTER COLUMN `capacity_commitment_units_per_month` SET TAGS ('dbx_business_glossary_term' = 'Capacity Commitment Units Per Month');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`cmt_agreement` ALTER COLUMN `cmt_rate_per_unit` SET TAGS ('dbx_business_glossary_term' = 'Cut-Make-Trim (CMT) Rate Per Unit');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`cmt_agreement` ALTER COLUMN `compliance_certifications_required` SET TAGS ('dbx_business_glossary_term' = 'Compliance Certifications Required');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`cmt_agreement` ALTER COLUMN `confidentiality_clause_flag` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Clause Flag');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`cmt_agreement` ALTER COLUMN `contract_value_total` SET TAGS ('dbx_business_glossary_term' = 'Contract Value Total');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`cmt_agreement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`cmt_agreement` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`cmt_agreement` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`cmt_agreement` ALTER COLUMN `dispute_resolution_method` SET TAGS ('dbx_business_glossary_term' = 'Dispute Resolution Method');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`cmt_agreement` ALTER COLUMN `dispute_resolution_method` SET TAGS ('dbx_value_regex' = 'negotiation|mediation|arbitration|litigation');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`cmt_agreement` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`cmt_agreement` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`cmt_agreement` ALTER COLUMN `exclusivity_flag` SET TAGS ('dbx_business_glossary_term' = 'Exclusivity Flag');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`cmt_agreement` ALTER COLUMN `fob_port` SET TAGS ('dbx_business_glossary_term' = 'Free on Board (FOB) Port');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`cmt_agreement` ALTER COLUMN `force_majeure_clause_flag` SET TAGS ('dbx_business_glossary_term' = 'Force Majeure Clause Flag');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`cmt_agreement` ALTER COLUMN `gender_specialization` SET TAGS ('dbx_business_glossary_term' = 'Gender Specialization');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`cmt_agreement` ALTER COLUMN `gender_specialization` SET TAGS ('dbx_value_regex' = 'mens|womens|kids|unisex|all');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`cmt_agreement` ALTER COLUMN `gender_specialization` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`cmt_agreement` ALTER COLUMN `gender_specialization` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`cmt_agreement` ALTER COLUMN `governing_law_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Governing Law Jurisdiction');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`cmt_agreement` ALTER COLUMN `incoterms` SET TAGS ('dbx_business_glossary_term' = 'Incoterms');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`cmt_agreement` ALTER COLUMN `insurance_requirements` SET TAGS ('dbx_business_glossary_term' = 'Insurance Requirements');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`cmt_agreement` ALTER COLUMN `ip_ownership_clause` SET TAGS ('dbx_business_glossary_term' = 'Intellectual Property (IP) Ownership Clause');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`cmt_agreement` ALTER COLUMN `ip_ownership_clause` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`cmt_agreement` ALTER COLUMN `last_amendment_date` SET TAGS ('dbx_business_glossary_term' = 'Last Amendment Date');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`cmt_agreement` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`cmt_agreement` ALTER COLUMN `lc_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Letter of Credit (LC) Required Flag');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`cmt_agreement` ALTER COLUMN `lc_terms` SET TAGS ('dbx_business_glossary_term' = 'Letter of Credit (LC) Terms');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`cmt_agreement` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time Days');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`cmt_agreement` ALTER COLUMN `liability_cap_amount` SET TAGS ('dbx_business_glossary_term' = 'Liability Cap Amount');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`cmt_agreement` ALTER COLUMN `moq_units` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity (MOQ) Units');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`cmt_agreement` ALTER COLUMN `moq_value` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity (MOQ) Value');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`cmt_agreement` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`cmt_agreement` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`cmt_agreement` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'wire_transfer|letter_of_credit|open_account|documentary_collection');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`cmt_agreement` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`cmt_agreement` ALTER COLUMN `performance_bond_amount` SET TAGS ('dbx_business_glossary_term' = 'Performance Bond Amount');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`cmt_agreement` ALTER COLUMN `performance_bond_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Performance Bond Required Flag');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`cmt_agreement` ALTER COLUMN `product_category` SET TAGS ('dbx_business_glossary_term' = 'Product Category');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`cmt_agreement` ALTER COLUMN `product_subcategory` SET TAGS ('dbx_business_glossary_term' = 'Product Subcategory');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`cmt_agreement` ALTER COLUMN `renewal_notice_period_days` SET TAGS ('dbx_business_glossary_term' = 'Renewal Notice Period Days');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`cmt_agreement` ALTER COLUMN `sample_lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Sample Lead Time Days');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`cmt_agreement` ALTER COLUMN `signatory_name_buyer` SET TAGS ('dbx_business_glossary_term' = 'Signatory Name Buyer');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`cmt_agreement` ALTER COLUMN `signatory_name_vendor` SET TAGS ('dbx_business_glossary_term' = 'Signatory Name Vendor');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`cmt_agreement` ALTER COLUMN `signed_date` SET TAGS ('dbx_business_glossary_term' = 'Signed Date');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`cmt_agreement` ALTER COLUMN `termination_notice_period_days` SET TAGS ('dbx_business_glossary_term' = 'Termination Notice Period Days');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`oem_odm_agreement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`oem_odm_agreement` SET TAGS ('dbx_subdomain' = 'partner_management');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`oem_odm_agreement` ALTER COLUMN `oem_odm_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Original Equipment Manufacturer (OEM) / Original Design Manufacturer (ODM) Agreement ID');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`oem_odm_agreement` ALTER COLUMN `standard_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Standard Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`oem_odm_agreement` ALTER COLUMN `vendor_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Agreement Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`oem_odm_agreement` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`oem_odm_agreement` ALTER COLUMN `renewed_oem_odm_agreement_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`oem_odm_agreement` ALTER COLUMN `agreement_number` SET TAGS ('dbx_business_glossary_term' = 'Agreement Number');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`oem_odm_agreement` ALTER COLUMN `agreement_status` SET TAGS ('dbx_business_glossary_term' = 'Agreement Status');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`oem_odm_agreement` ALTER COLUMN `agreement_status` SET TAGS ('dbx_value_regex' = 'Draft|Active|Suspended|Terminated|Expired|Pending Renewal');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`oem_odm_agreement` ALTER COLUMN `agreement_type` SET TAGS ('dbx_business_glossary_term' = 'Agreement Type');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`oem_odm_agreement` ALTER COLUMN `agreement_type` SET TAGS ('dbx_value_regex' = 'OEM|ODM|Hybrid');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`oem_odm_agreement` ALTER COLUMN `amendment_count` SET TAGS ('dbx_business_glossary_term' = 'Amendment Count');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`oem_odm_agreement` ALTER COLUMN `audit_frequency` SET TAGS ('dbx_business_glossary_term' = 'Audit Frequency');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`oem_odm_agreement` ALTER COLUMN `audit_frequency` SET TAGS ('dbx_value_regex' = 'Annual|Semi-Annual|Quarterly|As Needed');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`oem_odm_agreement` ALTER COLUMN `auto_renewal_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto-Renewal Flag');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`oem_odm_agreement` ALTER COLUMN `capacity_commitment_units_per_month` SET TAGS ('dbx_business_glossary_term' = 'Capacity Commitment Units Per Month');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`oem_odm_agreement` ALTER COLUMN `capacity_commitment_units_per_month` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`oem_odm_agreement` ALTER COLUMN `compliance_certifications_required` SET TAGS ('dbx_business_glossary_term' = 'Compliance Certifications Required');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`oem_odm_agreement` ALTER COLUMN `confidentiality_clause_flag` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Clause Flag');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`oem_odm_agreement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`oem_odm_agreement` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`oem_odm_agreement` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`oem_odm_agreement` ALTER COLUMN `design_ownership` SET TAGS ('dbx_business_glossary_term' = 'Design Ownership');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`oem_odm_agreement` ALTER COLUMN `design_ownership` SET TAGS ('dbx_value_regex' = 'Buyer|Supplier|Shared');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`oem_odm_agreement` ALTER COLUMN `design_ownership` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`oem_odm_agreement` ALTER COLUMN `dispute_resolution_method` SET TAGS ('dbx_business_glossary_term' = 'Dispute Resolution Method');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`oem_odm_agreement` ALTER COLUMN `dispute_resolution_method` SET TAGS ('dbx_value_regex' = 'Arbitration|Mediation|Litigation|Negotiation');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`oem_odm_agreement` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`oem_odm_agreement` ALTER COLUMN `exclusivity_flag` SET TAGS ('dbx_business_glossary_term' = 'Exclusivity Flag');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`oem_odm_agreement` ALTER COLUMN `exclusivity_flag` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`oem_odm_agreement` ALTER COLUMN `exclusivity_scope` SET TAGS ('dbx_business_glossary_term' = 'Exclusivity Scope');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`oem_odm_agreement` ALTER COLUMN `exclusivity_scope` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`oem_odm_agreement` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`oem_odm_agreement` ALTER COLUMN `force_majeure_clause_flag` SET TAGS ('dbx_business_glossary_term' = 'Force Majeure Clause Flag');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`oem_odm_agreement` ALTER COLUMN `governing_law_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Governing Law Jurisdiction');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`oem_odm_agreement` ALTER COLUMN `incoterms` SET TAGS ('dbx_business_glossary_term' = 'International Commercial Terms (INCOTERMS)');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`oem_odm_agreement` ALTER COLUMN `insurance_requirements` SET TAGS ('dbx_business_glossary_term' = 'Insurance Requirements');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`oem_odm_agreement` ALTER COLUMN `ip_ownership` SET TAGS ('dbx_business_glossary_term' = 'Intellectual Property (IP) Ownership');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`oem_odm_agreement` ALTER COLUMN `ip_ownership` SET TAGS ('dbx_value_regex' = 'Buyer|Supplier|Shared|Joint');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`oem_odm_agreement` ALTER COLUMN `ip_ownership` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`oem_odm_agreement` ALTER COLUMN `last_amendment_date` SET TAGS ('dbx_business_glossary_term' = 'Last Amendment Date');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`oem_odm_agreement` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`oem_odm_agreement` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time Days');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`oem_odm_agreement` ALTER COLUMN `liability_cap_amount` SET TAGS ('dbx_business_glossary_term' = 'Liability Cap Amount');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`oem_odm_agreement` ALTER COLUMN `liability_cap_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`oem_odm_agreement` ALTER COLUMN `manufacturing_scope` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Scope');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`oem_odm_agreement` ALTER COLUMN `material_sourcing_responsibility` SET TAGS ('dbx_business_glossary_term' = 'Material Sourcing Responsibility');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`oem_odm_agreement` ALTER COLUMN `material_sourcing_responsibility` SET TAGS ('dbx_value_regex' = 'Buyer Nominated|Supplier Sourced|Hybrid');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`oem_odm_agreement` ALTER COLUMN `moq_units` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity (MOQ) Units');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`oem_odm_agreement` ALTER COLUMN `non_compete_clause_flag` SET TAGS ('dbx_business_glossary_term' = 'Non-Compete Clause Flag');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`oem_odm_agreement` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`oem_odm_agreement` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`oem_odm_agreement` ALTER COLUMN `payment_terms` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`oem_odm_agreement` ALTER COLUMN `performance_bond_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Performance Bond Required Flag');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`oem_odm_agreement` ALTER COLUMN `pricing_model` SET TAGS ('dbx_business_glossary_term' = 'Pricing Model');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`oem_odm_agreement` ALTER COLUMN `pricing_model` SET TAGS ('dbx_value_regex' = 'Fixed Price|Cost Plus|Volume Based|Tiered');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`oem_odm_agreement` ALTER COLUMN `pricing_model` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`oem_odm_agreement` ALTER COLUMN `product_categories` SET TAGS ('dbx_business_glossary_term' = 'Product Categories');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`oem_odm_agreement` ALTER COLUMN `renewal_notice_period_days` SET TAGS ('dbx_business_glossary_term' = 'Renewal Notice Period Days');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`oem_odm_agreement` ALTER COLUMN `sample_development_terms` SET TAGS ('dbx_business_glossary_term' = 'Sample Development Terms');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`oem_odm_agreement` ALTER COLUMN `signatory_name_buyer` SET TAGS ('dbx_business_glossary_term' = 'Signatory Name Buyer');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`oem_odm_agreement` ALTER COLUMN `signatory_name_supplier` SET TAGS ('dbx_business_glossary_term' = 'Signatory Name Supplier');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`oem_odm_agreement` ALTER COLUMN `signed_date` SET TAGS ('dbx_business_glossary_term' = 'Signed Date');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`oem_odm_agreement` ALTER COLUMN `termination_notice_period_days` SET TAGS ('dbx_business_glossary_term' = 'Termination Notice Period Days');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`oem_odm_agreement` ALTER COLUMN `territory_restriction` SET TAGS ('dbx_business_glossary_term' = 'Territory Restriction');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`oem_odm_agreement` ALTER COLUMN `tooling_ownership` SET TAGS ('dbx_business_glossary_term' = 'Tooling Ownership');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`oem_odm_agreement` ALTER COLUMN `tooling_ownership` SET TAGS ('dbx_value_regex' = 'Buyer|Supplier|Shared');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`oem_odm_agreement` ALTER COLUMN `tooling_ownership` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`factory_sourcing_allocation` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`factory_sourcing_allocation` SET TAGS ('dbx_subdomain' = 'production_operations');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`factory_sourcing_allocation` SET TAGS ('dbx_association_edges' = 'supplier.supplier_factory,sourcing.sourcing_agreement');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`factory_sourcing_allocation` ALTER COLUMN `factory_sourcing_allocation_id` SET TAGS ('dbx_business_glossary_term' = 'Factory Sourcing Allocation ID');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`factory_sourcing_allocation` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Factory Sourcing Allocation - Sourcing Agreement Id');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`factory_sourcing_allocation` ALTER COLUMN `factory_supplier_factory_id` SET TAGS ('dbx_business_glossary_term' = 'Factory Sourcing Allocation - Supplier Factory Id');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`factory_sourcing_allocation` ALTER COLUMN `sourcing_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Sourcing Agreement ID');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`factory_sourcing_allocation` ALTER COLUMN `supplier_factory_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Factory ID');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`factory_sourcing_allocation` ALTER COLUMN `allocated_volume_quantity` SET TAGS ('dbx_business_glossary_term' = 'Allocated Volume Quantity');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`factory_sourcing_allocation` ALTER COLUMN `allocation_effective_from_date` SET TAGS ('dbx_business_glossary_term' = 'Allocation Effective From Date');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`factory_sourcing_allocation` ALTER COLUMN `allocation_effective_to_date` SET TAGS ('dbx_business_glossary_term' = 'Allocation Effective To Date');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`factory_sourcing_allocation` ALTER COLUMN `allocation_status` SET TAGS ('dbx_business_glossary_term' = 'Allocation Status');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`factory_sourcing_allocation` ALTER COLUMN `capacity_allocation_percent` SET TAGS ('dbx_business_glossary_term' = 'Capacity Allocation Percent');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`factory_sourcing_allocation` ALTER COLUMN `created_date` SET TAGS ('dbx_business_glossary_term' = 'Created Date');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`factory_sourcing_allocation` ALTER COLUMN `factory_cmt_rate` SET TAGS ('dbx_business_glossary_term' = 'Factory CMT Rate');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`factory_sourcing_allocation` ALTER COLUMN `factory_exclusivity_flag` SET TAGS ('dbx_business_glossary_term' = 'Factory Exclusivity Flag');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`factory_sourcing_allocation` ALTER COLUMN `factory_fob_price` SET TAGS ('dbx_business_glossary_term' = 'Factory FOB Price');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`factory_sourcing_allocation` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`factory_sourcing_allocation` ALTER COLUMN `last_modified_date` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Date');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`factory_sourcing_allocation` ALTER COLUMN `primary_factory_flag` SET TAGS ('dbx_business_glossary_term' = 'Primary Factory Flag');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`factory_sourcing_allocation` ALTER COLUMN `product_category_scope` SET TAGS ('dbx_business_glossary_term' = 'Product Category Scope');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`factory_sourcing_allocation` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_defect_occurrence` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_defect_occurrence` SET TAGS ('dbx_subdomain' = 'quality_performance');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_defect_occurrence` SET TAGS ('dbx_association_edges' = 'quality.quality_defect,supplier.vendor');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_defect_occurrence` ALTER COLUMN `vendor_defect_occurrence_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Defect Occurrence ID');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_defect_occurrence` ALTER COLUMN `defect_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Defect Occurrence - Quality Defect Id');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_defect_occurrence` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Defect Occurrence - Vendor Id');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_defect_occurrence` ALTER COLUMN `active_flag` SET TAGS ('dbx_business_glossary_term' = 'Active Flag');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_defect_occurrence` ALTER COLUMN `capa_completion_date` SET TAGS ('dbx_business_glossary_term' = 'CAPA Completion Date');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_defect_occurrence` ALTER COLUMN `capa_due_date` SET TAGS ('dbx_business_glossary_term' = 'CAPA Due Date');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_defect_occurrence` ALTER COLUMN `corrective_action_status` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Status');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_defect_occurrence` ALTER COLUMN `cost_impact_total` SET TAGS ('dbx_business_glossary_term' = 'Cost Impact Total');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_defect_occurrence` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_defect_occurrence` ALTER COLUMN `defect_frequency_count` SET TAGS ('dbx_business_glossary_term' = 'Defect Frequency Count');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_defect_occurrence` ALTER COLUMN `first_occurrence_date` SET TAGS ('dbx_business_glossary_term' = 'First Occurrence Date');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_defect_occurrence` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_defect_occurrence` ALTER COLUMN `last_occurrence_date` SET TAGS ('dbx_business_glossary_term' = 'Last Occurrence Date');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_defect_occurrence` ALTER COLUMN `recurrence_rate` SET TAGS ('dbx_business_glossary_term' = 'Recurrence Rate');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_defect_occurrence` ALTER COLUMN `vendor_responsible_party` SET TAGS ('dbx_business_glossary_term' = 'Vendor Responsible Party');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_defect_occurrence` ALTER COLUMN `verification_status` SET TAGS ('dbx_business_glossary_term' = 'Verification Status');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_quality_compliance` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_quality_compliance` SET TAGS ('dbx_subdomain' = 'quality_performance');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_quality_compliance` SET TAGS ('dbx_association_edges' = 'quality.quality_standard,supplier.vendor');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_quality_compliance` ALTER COLUMN `vendor_quality_compliance_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Quality Compliance ID');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_quality_compliance` ALTER COLUMN `quality_standard_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Standard ID');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_quality_compliance` ALTER COLUMN `standard_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Quality Compliance - Quality Standard Id');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_quality_compliance` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Quality Compliance - Vendor Id');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_quality_compliance` ALTER COLUMN `audit_frequency_override` SET TAGS ('dbx_business_glossary_term' = 'Audit Frequency Override');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_quality_compliance` ALTER COLUMN `audit_score` SET TAGS ('dbx_business_glossary_term' = 'Audit Score');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_quality_compliance` ALTER COLUMN `certification_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Certification Expiry Date');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_quality_compliance` ALTER COLUMN `certification_number` SET TAGS ('dbx_business_glossary_term' = 'Certification Number');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_quality_compliance` ALTER COLUMN `certification_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Certification Required Flag');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_quality_compliance` ALTER COLUMN `certifying_body` SET TAGS ('dbx_business_glossary_term' = 'Certifying Body');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_quality_compliance` ALTER COLUMN `compliance_owner` SET TAGS ('dbx_business_glossary_term' = 'Compliance Owner');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_quality_compliance` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_quality_compliance` ALTER COLUMN `created_date` SET TAGS ('dbx_business_glossary_term' = 'Record Created Date');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_quality_compliance` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Compliance Effective Date');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_quality_compliance` ALTER COLUMN `last_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Last Audit Date');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_quality_compliance` ALTER COLUMN `last_updated_date` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Date');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_quality_compliance` ALTER COLUMN `next_audit_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Audit Due Date');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_quality_compliance` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Compliance Notes');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_quality_compliance` ALTER COLUMN `open_corrective_actions` SET TAGS ('dbx_business_glossary_term' = 'Open Corrective Actions Count');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_quality_compliance` ALTER COLUMN `waiver_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Waiver Expiry Date');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_quality_compliance` ALTER COLUMN `waiver_granted_flag` SET TAGS ('dbx_business_glossary_term' = 'Waiver Granted Flag');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_quality_compliance` ALTER COLUMN `waiver_justification` SET TAGS ('dbx_business_glossary_term' = 'Waiver Justification');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_relationship` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_relationship` SET TAGS ('dbx_subdomain' = 'partner_management');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_relationship` SET TAGS ('dbx_association_edges' = 'supplier.vendor,workforce.employee');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_relationship` ALTER COLUMN `vendor_relationship_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Relationship ID');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_relationship` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Relationship - Employee Id');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_relationship` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_relationship` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_relationship` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Relationship - Vendor Id');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_relationship` ALTER COLUMN `assignment_status` SET TAGS ('dbx_business_glossary_term' = 'Assignment Status');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_relationship` ALTER COLUMN `authorization_level` SET TAGS ('dbx_business_glossary_term' = 'Authorization Level');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_relationship` ALTER COLUMN `created_date` SET TAGS ('dbx_business_glossary_term' = 'Record Created Date');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_relationship` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Relationship Effective End Date');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_relationship` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Relationship Effective Start Date');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_relationship` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified By');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_relationship` ALTER COLUMN `last_modified_date` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Date');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_relationship` ALTER COLUMN `primary_contact_flag` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Flag');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_relationship` ALTER COLUMN `role_type` SET TAGS ('dbx_business_glossary_term' = 'Relationship Role Type');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_relationship` ALTER COLUMN `specialization_area` SET TAGS ('dbx_business_glossary_term' = 'Specialization Area');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_relationship` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Created By');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_certification` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_certification` SET TAGS ('dbx_subdomain' = 'compliance_assurance');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_certification` SET TAGS ('dbx_association_edges' = 'supplier.vendor,compliance.compliance_certification');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_certification` ALTER COLUMN `vendor_certification_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Certification ID');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_certification` ALTER COLUMN `compliance_certification_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Certification - Compliance Certification Id');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_certification` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Certification - Vendor Id');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_certification` ALTER COLUMN `certificate_number` SET TAGS ('dbx_business_glossary_term' = 'Certificate Number');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_certification` ALTER COLUMN `certification_scope` SET TAGS ('dbx_business_glossary_term' = 'Certification Scope');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_certification` ALTER COLUMN `certification_status` SET TAGS ('dbx_business_glossary_term' = 'Certification Status');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_certification` ALTER COLUMN `certified_facility_location` SET TAGS ('dbx_business_glossary_term' = 'Certified Facility Location');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_certification` ALTER COLUMN `cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Cost Amount');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_certification` ALTER COLUMN `cost_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Currency Code');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_certification` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_certification` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_certification` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_certification` ALTER COLUMN `next_audit_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Audit Due Date');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_certification` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_certification` ALTER COLUMN `renewal_date` SET TAGS ('dbx_business_glossary_term' = 'Renewal Date');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_certification` ALTER COLUMN `responsible_party_name` SET TAGS ('dbx_business_glossary_term' = 'Responsible Party Name');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_certification` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_substance_compliance` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_substance_compliance` SET TAGS ('dbx_subdomain' = 'compliance_assurance');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_substance_compliance` SET TAGS ('dbx_association_edges' = 'supplier.vendor,compliance.restricted_substance');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_substance_compliance` ALTER COLUMN `vendor_substance_compliance_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Substance Compliance ID');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_substance_compliance` ALTER COLUMN `restricted_substance_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Substance Compliance - Restricted Substance Id');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_substance_compliance` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Substance Compliance - Vendor Id');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_substance_compliance` ALTER COLUMN `compliance_notes` SET TAGS ('dbx_business_glossary_term' = 'Compliance Notes');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_substance_compliance` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_substance_compliance` ALTER COLUMN `concentration_unit` SET TAGS ('dbx_business_glossary_term' = 'Concentration Unit');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_substance_compliance` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_substance_compliance` ALTER COLUMN `exemption_flag` SET TAGS ('dbx_business_glossary_term' = 'Exemption Flag');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_substance_compliance` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_substance_compliance` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_substance_compliance` ALTER COLUMN `last_test_date` SET TAGS ('dbx_business_glossary_term' = 'Last Test Date');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_substance_compliance` ALTER COLUMN `measured_concentration` SET TAGS ('dbx_business_glossary_term' = 'Measured Concentration');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_substance_compliance` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_substance_compliance` ALTER COLUMN `next_test_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Test Due Date');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_substance_compliance` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Level');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_substance_compliance` ALTER COLUMN `test_frequency` SET TAGS ('dbx_business_glossary_term' = 'Test Frequency');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_substance_compliance` ALTER COLUMN `test_method` SET TAGS ('dbx_business_glossary_term' = 'Test Method');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_substance_compliance` ALTER COLUMN `test_report_reference` SET TAGS ('dbx_business_glossary_term' = 'Test Report Reference');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_substance_compliance` ALTER COLUMN `test_result` SET TAGS ('dbx_business_glossary_term' = 'Test Result');
ALTER TABLE `apparel_fashion_ecm`.`supplier`.`vendor_substance_compliance` ALTER COLUMN `testing_lab_name` SET TAGS ('dbx_business_glossary_term' = 'Testing Lab Name');
