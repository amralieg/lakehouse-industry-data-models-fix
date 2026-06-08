-- Schema for Domain: procurement | Business: Waste Management | Version: v1_ecm
-- Generated on: 2026-05-07 20:07:56

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `waste_management_ecm`.`procurement` COMMENT 'Sourcing and purchasing of goods and services including fleet parts, fuel (diesel, CNG), PPE, containers, chemicals, equipment, facility supplies, professional services, and third-party disposal services. Manages purchase orders (PO), supplier contracts, vendor master, vendor performance, accounts payable (AP), procurement workflows, and spend analytics. Supports cost control for COGS and EBITDA reporting. Integrates with SAP MM and SAP AP.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `waste_management_ecm`.`procurement`.`vendor` (
    `vendor_id` BIGINT COMMENT 'Unique identifier for the vendor record. Primary key sourced from SAP MM vendor master (LFA1).',
    `accounts_payable_contact_email` STRING COMMENT 'Email address for the vendors accounts payable contact.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `accounts_payable_contact_name` STRING COMMENT 'Full name of the vendors accounts payable or billing contact for invoice and payment inquiries.',
    `address_line_1` STRING COMMENT 'Primary street address line for the vendors business location or remittance address.',
    `address_line_2` STRING COMMENT 'Secondary address line for suite, building, or unit information.',
    `approved_date` DATE COMMENT 'Date the vendor was approved and activated in the vendor master, marking completion of onboarding and compliance checks.',
    `city` STRING COMMENT 'City name for the vendors business address.',
    `classification` STRING COMMENT 'Primary business classification of the vendor based on goods or services provided. Used for spend analytics and vendor segmentation. [ENUM-REF-CANDIDATE: fleet_parts_supplier|fuel_distributor|ppe_vendor|container_manufacturer|chemical_supplier|equipment_oem|facility_supply_vendor|professional_services|tsdf_operator|other — 10 candidates stripped; promote to reference product]',
    `country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code for the vendors business address.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the vendor record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for vendor transactions and invoices.. Valid values are `^[A-Z]{3}$`',
    `duns_number` STRING COMMENT 'Nine-digit unique identifier assigned by Dun & Bradstreet, used for vendor credit checks and risk assessment.. Valid values are `^[0-9]{9}$`',
    `email_address` STRING COMMENT 'Primary business email address for vendor communication and invoice delivery.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `fax_number` STRING COMMENT 'Business fax number for the vendor, if applicable.. Valid values are `^+?[0-9]{10,15}$`',
    `insurance_certificate_on_file_flag` BOOLEAN COMMENT 'Indicates whether a current certificate of insurance (COI) is on file for the vendor, required for risk management and contract compliance.',
    `insurance_expiration_date` DATE COMMENT 'Expiration date of the vendors insurance certificate on file. Vendors with expired insurance may be blocked from receiving new purchase orders.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the vendor record was last updated, used for change tracking and audit trails.',
    `minority_owned_flag` BOOLEAN COMMENT 'Indicates whether the vendor is certified as a minority-owned business enterprise (MBE) for diversity spend reporting.',
    `name_2` STRING COMMENT 'Additional name line for vendor, used for extended legal names or doing-business-as (DBA) names.',
    `onboarding_status` STRING COMMENT 'Status of the vendor onboarding process, tracking completion of required documentation, insurance certificates, and compliance checks.. Valid values are `not_started|in_progress|documents_pending|approved|rejected`',
    `payment_method` STRING COMMENT 'Preferred payment method for remitting payment to the vendor.. Valid values are `ach|wire|check|credit_card|procurement_card`',
    `payment_terms_code` STRING COMMENT 'Standard payment terms code defining the number of days for payment and any early payment discounts (e.g., NET30, 2/10NET30).. Valid values are `^[A-Z0-9]{2,4}$`',
    `performance_rating` STRING COMMENT 'Overall performance rating for the vendor based on quality, delivery, responsiveness, and compliance. Used for vendor scorecard and sourcing decisions.. Valid values are `excellent|good|satisfactory|needs_improvement|poor|not_rated`',
    `phone_number` STRING COMMENT 'Primary business phone number for the vendor.. Valid values are `^+?[0-9]{10,15}$`',
    `postal_code` STRING COMMENT 'ZIP or postal code for the vendors business address.. Valid values are `^[0-9]{5}(-[0-9]{4})?$`',
    `primary_contact_email` STRING COMMENT 'Email address for the primary vendor contact.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `primary_contact_name` STRING COMMENT 'Full name of the primary business contact at the vendor for procurement and account management.',
    `primary_contact_phone` STRING COMMENT 'Direct phone number for the primary vendor contact.. Valid values are `^+?[0-9]{10,15}$`',
    `primary_contact_title` STRING COMMENT 'Job title or role of the primary contact at the vendor.',
    `small_business_flag` BOOLEAN COMMENT 'Indicates whether the vendor is certified as a small business for government contracting and diversity reporting.',
    `state_province` STRING COMMENT 'Two-letter state or province code for the vendors business address.. Valid values are `^[A-Z]{2}$`',
    `tax_classification` STRING COMMENT 'IRS tax classification of the vendor entity, determines tax reporting requirements and withholding rules. [ENUM-REF-CANDIDATE: corporation|s_corporation|partnership|sole_proprietor|llc|non_profit|government — 7 candidates stripped; promote to reference product]',
    `tax_identification_number` STRING COMMENT 'Federal Employer Identification Number (EIN) or Tax Identification Number for the vendor, used for tax reporting and 1099 processing.. Valid values are `^[0-9]{2}-[0-9]{7}$`',
    `vendor_name` STRING COMMENT 'Legal business name of the vendor as registered with tax authorities and used on contracts and purchase orders.',
    `vendor_number` STRING COMMENT 'External business identifier for the vendor, used in procurement documents, purchase orders, and invoices. Unique across the enterprise.. Valid values are `^[A-Z0-9]{6,10}$`',
    `vendor_status` STRING COMMENT 'Current lifecycle status of the vendor record. Active vendors can receive purchase orders; blocked vendors cannot transact.. Valid values are `active|inactive|blocked|pending_approval|suspended`',
    `vendor_type` STRING COMMENT 'Indicates whether the vendor provides goods, services, or both.. Valid values are `goods|services|both`',
    `veteran_owned_flag` BOOLEAN COMMENT 'Indicates whether the vendor is certified as a veteran-owned business enterprise for diversity spend reporting.',
    `w9_on_file_flag` BOOLEAN COMMENT 'Indicates whether a completed IRS Form W-9 is on file for the vendor, required for tax reporting and 1099 processing.',
    `website_url` STRING COMMENT 'Vendors corporate website URL for reference and supplier portal access.',
    `woman_owned_flag` BOOLEAN COMMENT 'Indicates whether the vendor is certified as a woman-owned business enterprise (WBE) for diversity spend reporting.',
    CONSTRAINT pk_vendor PRIMARY KEY(`vendor_id`)
) COMMENT 'Master record for all suppliers and vendors providing goods and services to Waste Management, including fleet parts suppliers, fuel distributors (diesel, CNG/RNG), PPE vendors, container manufacturers, chemical suppliers, equipment OEMs, facility supply vendors, professional services firms, and third-party disposal/TSDF operators. Serves as the SSOT for vendor identity, classification, tax information, payment terms, and onboarding status. Sourced from SAP MM vendor master (LFA1/LFB1).';

CREATE OR REPLACE TABLE `waste_management_ecm`.`procurement`.`vendor_contact` (
    `vendor_contact_id` BIGINT COMMENT 'Unique identifier for the vendor contact record. Primary key.',
    `vendor_id` BIGINT COMMENT 'Reference to the parent vendor organization this contact represents. Links to the vendor master record in SAP MM.',
    `address_line_1` STRING COMMENT 'First line of the vendor contacts business address (street number and name). Used for correspondence and physical document delivery.',
    `address_line_2` STRING COMMENT 'Second line of the vendor contacts business address (suite, floor, building). Optional field for additional address details.',
    `city` STRING COMMENT 'City or municipality of the vendor contacts business address.',
    `contact_status` STRING COMMENT 'Current lifecycle status of the vendor contact. Inactive or terminated contacts are excluded from active routing and communication workflows.. Valid values are `active|inactive|on_leave|terminated`',
    `contact_type` STRING COMMENT 'Classification of the contacts role within the vendor relationship. Determines routing and escalation workflows.. Valid values are `account_manager|sales_representative|technical_support|compliance_officer|emergency_contact|billing_contact`',
    `country_code` STRING COMMENT 'ISO 3166-1 alpha-3 three-letter country code for the vendor contacts business address (e.g., USA, CAN, MEX).. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this vendor contact record was first created in the system. Used for audit trail and data lineage tracking.',
    `department` STRING COMMENT 'Organizational department or division within the vendor company where this contact works (e.g., Sales, Compliance, Technical Support, Customer Service).',
    `effective_end_date` DATE COMMENT 'Date when this contact ceased to be active or left the vendor organization. Null for currently active contacts.',
    `effective_start_date` DATE COMMENT 'Date when this contact became active and available for vendor communication. Used for contact history tracking and audit trails.',
    `email_address` STRING COMMENT 'Primary business email address for the vendor contact. Used for Purchase Order (PO) confirmations, compliance notifications, and general correspondence.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `extension` STRING COMMENT 'Telephone extension number within the vendors phone system for direct routing to this contact.',
    `fax_number` STRING COMMENT 'Fax number for the vendor contact. Used for formal Purchase Order (PO) transmission and compliance documentation where required.',
    `first_name` STRING COMMENT 'Given name of the vendor contact person.',
    `full_name` STRING COMMENT 'Complete formatted name of the vendor contact as it should appear in correspondence and reports.',
    `is_authorized_signer` BOOLEAN COMMENT 'Indicates whether this contact has authority to sign contracts, Purchase Orders (PO), or other legally binding documents on behalf of the vendor.',
    `is_emergency_contact` BOOLEAN COMMENT 'Indicates whether this contact should be reached for emergency situations such as hazardous waste incidents, equipment failures, or urgent supply shortages.',
    `is_primary_contact` BOOLEAN COMMENT 'Indicates whether this contact is the primary point of contact for the vendor relationship. Used for default routing of Purchase Orders (PO) and escalations.',
    `job_title` STRING COMMENT 'Official position or title of the contact within the vendor organization (e.g., Regional Sales Manager, Compliance Director, Technical Support Lead).',
    `language_code` STRING COMMENT 'ISO 639-2 three-letter language code representing the contacts preferred language for business communication (e.g., ENG for English, SPA for Spanish, FRA for French).. Valid values are `^[A-Z]{3}$`',
    `last_contact_date` DATE COMMENT 'Date of the most recent communication or interaction with this vendor contact. Used for relationship management and contact freshness tracking.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this vendor contact record was last updated. Used for change tracking and data quality monitoring.',
    `last_name` STRING COMMENT 'Family name of the vendor contact person.',
    `middle_name` STRING COMMENT 'Middle name or initial of the vendor contact person.',
    `mobile_phone_number` STRING COMMENT 'Mobile telephone number for the vendor contact. Used for emergency escalations and after-hours support coordination.',
    `notes` STRING COMMENT 'Free-form text field for additional information about the vendor contact, such as special handling instructions, availability constraints, or relationship history.',
    `phone_number` STRING COMMENT 'Primary business telephone number for the vendor contact. Used for urgent procurement matters and vendor coordination.',
    `postal_code` STRING COMMENT 'Postal or ZIP code of the vendor contacts business address. Used for mail routing and geographic analysis.',
    `preferred_communication_channel` STRING COMMENT 'The contacts preferred method of communication for routine business matters. Guides procurement workflow routing and notification preferences.. Valid values are `email|phone|mobile|fax|portal`',
    `secondary_email_address` STRING COMMENT 'Alternate email address for the vendor contact, used for backup communication or escalation purposes.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `state_province` STRING COMMENT 'State, province, or region of the vendor contacts business address. Uses standard postal abbreviations (e.g., TX, CA, ON).',
    `time_zone` STRING COMMENT 'IANA time zone identifier for the contacts primary work location (e.g., America/New_York, America/Chicago). Used for scheduling calls and coordinating delivery windows.',
    CONSTRAINT pk_vendor_contact PRIMARY KEY(`vendor_contact_id`)
) COMMENT 'Individual contact persons associated with a vendor record — account managers, sales representatives, technical support contacts, compliance officers, and emergency contacts. Tracks name, title, phone, email, preferred communication channel, and role classification per vendor relationship. Supports vendor communication workflows and escalation routing.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`procurement`.`vendor_certification` (
    `vendor_certification_id` BIGINT COMMENT 'Unique identifier for the vendor certification record. Primary key.',
    `document_id` BIGINT COMMENT 'Reference to the document management system record containing the scanned or uploaded copy of the certification, permit, or insurance certificate. Links to document repository.',
    `employee_id` BIGINT COMMENT 'Reference to the Waste Management employee who performed the most recent verification. Links to user or employee master data.',
    `tertiary_vendor_last_modified_by_user_employee_id` BIGINT COMMENT 'Reference to the user who most recently modified this vendor certification record. Links to user or employee master data.',
    `vendor_id` BIGINT COMMENT 'Reference to the vendor holding this certification. Links to the vendor master record in SAP MM.',
    `certificate_holder_name` STRING COMMENT 'The name of the entity designated as the certificate holder or additional insured on insurance certificates. Typically Waste Management or a subsidiary. Null for non-insurance certifications.',
    `certification_number` STRING COMMENT 'The unique certificate or permit number issued by the certifying authority. This is the externally-known identifier for the certification.',
    `certification_scope` STRING COMMENT 'A description of the scope, coverage, or limitations of the certification. For EPA TSDF permits, this includes waste types and treatment methods authorized. For DOT hazmat carriers, this includes hazard classes authorized. For insurance, this includes coverage limits and exclusions. For ISO certifications, this includes the facilities or processes covered.',
    `certification_status` STRING COMMENT 'Current lifecycle status of the certification. Active certifications are valid and in good standing. Expired certifications have passed their expiration date. Suspended certifications are temporarily invalid due to compliance issues. Pending renewal indicates renewal application submitted but not yet approved. Revoked certifications have been permanently withdrawn by the issuing authority. Pending approval indicates initial application under review.. Valid values are `ACTIVE|EXPIRED|SUSPENDED|PENDING_RENEWAL|REVOKED|PENDING_APPROVAL`',
    `certification_type` STRING COMMENT 'The category of certification held by the vendor. Includes regulatory permits (EPA TSDF, DOT hazmat carrier, RCRA compliance, state environmental permits), quality/safety certifications (ISO 14001 environmental management, ISO 45001 occupational health and safety), business designations (MWBE minority/women-owned business enterprise), insurance certificates (general liability, workers compensation, auto liability), and bonding (performance bond, payment bond). [ENUM-REF-CANDIDATE: EPA_TSDF_PERMIT|DOT_HAZMAT_CARRIER|RCRA_COMPLIANCE|ISO_14001|ISO_45001|MWBE_DESIGNATION|GENERAL_LIABILITY_INSURANCE|WORKERS_COMP_INSURANCE|AUTO_LIABILITY_INSURANCE|PERFORMANCE_BOND|PAYMENT_BOND|STATE_ENVIRONMENTAL_PERMIT|LOCAL_BUSINESS_LICENSE — 13 candidates stripped; promote to reference product]',
    `compliance_gate_flag` BOOLEAN COMMENT 'Boolean indicator of whether this certification is a mandatory compliance gate for vendor qualification. True indicates that the vendor cannot be approved or used for relevant procurement categories without this certification being active and valid. False indicates the certification is supplementary or optional.',
    `coverage_amount` DECIMAL(18,2) COMMENT 'The monetary coverage limit for insurance certificates or bonding amounts. Expressed in USD. Null for non-financial certifications such as permits or quality certifications.',
    `coverage_currency_code` STRING COMMENT 'The three-letter ISO 4217 currency code for the coverage amount. Typically USD for U.S. operations.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this vendor certification record was first created in the system. Audit trail field.',
    `deductible_amount` DECIMAL(18,2) COMMENT 'The deductible amount applicable to insurance certificates. Expressed in the same currency as coverage amount. Null for non-insurance certifications.',
    `effective_date` DATE COMMENT 'The date on which the certification becomes valid and enforceable. This is the start date of the certification period.',
    `expiration_date` DATE COMMENT 'The date on which the certification expires and is no longer valid. Nullable for certifications with indefinite validity or one-time designations.',
    `issuing_authority` STRING COMMENT 'The name of the regulatory body, government agency, or standards organization that issued the certification. Examples include U.S. EPA, state environmental quality departments, DOT FMCSA, ISO certification bodies, insurance carriers, and bonding companies.',
    `issuing_authority_jurisdiction` STRING COMMENT 'The geographic or regulatory jurisdiction of the issuing authority. Examples include federal (USA), state (e.g., California, Texas), regional (e.g., EPA Region 5), or international (e.g., ISO global).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this vendor certification record was most recently updated. Audit trail field.',
    `last_renewal_date` DATE COMMENT 'The date on which the certification was most recently renewed. Null for certifications that have never been renewed.',
    `next_renewal_date` DATE COMMENT 'The scheduled date for the next certification renewal. May differ from expiration date if renewal must be initiated before expiration.',
    `notes` STRING COMMENT 'Free-text field for additional notes, comments, or special conditions related to the certification. May include details on restrictions, conditional approvals, or follow-up actions required.',
    `policy_holder_name` STRING COMMENT 'The legal name of the policy holder for insurance certificates. Should match the vendor legal name. Null for non-insurance certifications.',
    `procurement_category` STRING COMMENT 'The procurement category or service line for which this certification is required or relevant. Examples include hazardous waste disposal, fleet parts, fuel supply, PPE, third-party hauling, landfill services, recycling services. Multiple categories may be pipe-separated if the certification applies broadly.',
    `renewal_alert_threshold_days` STRING COMMENT 'The number of days before expiration when the system should trigger a renewal alert to procurement and vendor management teams. Typical values range from 30 to 90 days depending on certification type and renewal complexity.',
    `verification_date` DATE COMMENT 'The date on which the certification was last verified by Waste Management procurement or compliance teams.',
    `verification_method` STRING COMMENT 'The method used to verify the authenticity and validity of the certification. Document upload indicates vendor provided certificate copy. Third-party verification indicates independent verification service used. Registry lookup indicates verification via public regulatory database (e.g., EPA TSDF registry, DOT carrier database). Self-attestation indicates vendor declaration without independent verification. On-site audit indicates physical inspection or audit conducted.. Valid values are `DOCUMENT_UPLOAD|THIRD_PARTY_VERIFICATION|REGISTRY_LOOKUP|SELF_ATTESTATION|ON_SITE_AUDIT`',
    CONSTRAINT pk_vendor_certification PRIMARY KEY(`vendor_certification_id`)
) COMMENT 'Tracks regulatory and business certifications held by vendors, including EPA-permitted TSDF status, DOT hazmat carrier authorization, RCRA compliance certifications, ISO 14001/45001 certifications, minority/women-owned business (MWBE) designations, insurance certificates (general liability, workers comp, auto), and bonding status. Captures certification type, issuing authority, effective date, expiration date, and renewal alert thresholds. Critical for vendor qualification and compliance gating in hazmat and environmental services procurement.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`procurement`.`vendor_performance` (
    `vendor_performance_id` BIGINT COMMENT 'Unique identifier for the vendor performance evaluation record.',
    `employee_id` BIGINT COMMENT 'Reference to the employee who conducted the vendor performance evaluation.',
    `sourcing_contract_id` BIGINT COMMENT 'Foreign key linking to procurement.sourcing_contract. Business justification: Vendor performance evaluations are often contract-specific, measuring vendor performance against specific contract terms and SLAs. This FK enables tracking performance metrics at the contract level, s',
    `vendor_id` BIGINT COMMENT 'Reference to the vendor being evaluated in the vendor master.',
    `approval_date` DATE COMMENT 'Date when the vendor performance evaluation was formally approved.',
    `contract_compliance_rate_percent` DECIMAL(18,2) COMMENT 'Percentage of transactions that adhered to negotiated contract terms including pricing, payment terms, and service level agreements (SLA) during the evaluation period.',
    `corrective_action_due_date` DATE COMMENT 'Target date by which the vendor must complete corrective actions to address performance deficiencies.',
    `corrective_action_required_flag` BOOLEAN COMMENT 'Indicates whether the vendor performance evaluation identified deficiencies requiring formal corrective action plan.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the vendor performance evaluation record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the total spend amount.. Valid values are `^[A-Z]{3}$`',
    `environmental_compliance_violation_count` STRING COMMENT 'Total number of environmental compliance violations or non-conformances identified during the evaluation period. Tracked per U.S. Environmental Protection Agency (EPA) and Resource Conservation and Recovery Act (RCRA) requirements.',
    `evaluation_date` DATE COMMENT 'Date when the vendor performance evaluation was completed and recorded.',
    `evaluation_notes` STRING COMMENT 'Free-text comments and observations from the evaluator regarding vendor performance, strengths, weaknesses, and recommendations.',
    `evaluation_period_end_date` DATE COMMENT 'End date of the performance evaluation period.',
    `evaluation_period_start_date` DATE COMMENT 'Start date of the performance evaluation period.',
    `evaluation_status` STRING COMMENT 'Current status of the vendor performance evaluation in the approval workflow.. Valid values are `draft|submitted|approved|rejected|archived`',
    `fill_rate_percent` DECIMAL(18,2) COMMENT 'Percentage of purchase order line items completely fulfilled without backorders or shortages during the evaluation period.',
    `invoice_accuracy_rate_percent` DECIMAL(18,2) COMMENT 'Percentage of invoices received without pricing errors, quantity discrepancies, or other billing issues requiring correction.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the vendor performance evaluation record was last updated.',
    `lead_time_days_avg` DECIMAL(18,2) COMMENT 'Average number of days from purchase order (PO) placement to delivery during the evaluation period.',
    `next_evaluation_due_date` DATE COMMENT 'Scheduled date for the next periodic vendor performance evaluation.',
    `on_time_delivery_rate_percent` DECIMAL(18,2) COMMENT 'Percentage of purchase orders delivered on or before the scheduled delivery date during the evaluation period. Key performance indicator (KPI) for vendor reliability.',
    `overall_scorecard_rating` DECIMAL(18,2) COMMENT 'Composite vendor performance score calculated from weighted performance metrics. Scale typically 0-100 or 0-5 depending on organizational scoring methodology.',
    `quality_defect_rate_percent` DECIMAL(18,2) COMMENT 'Percentage of received goods or services that failed quality inspection or were rejected due to defects during the evaluation period.',
    `response_time_days_avg` DECIMAL(18,2) COMMENT 'Average number of days for the vendor to respond to inquiries, requests for quotation, or issue resolution during the evaluation period.',
    `safety_incident_count` STRING COMMENT 'Total number of safety incidents involving the vendors personnel, equipment, or materials during the evaluation period. Tracked per Occupational Safety and Health Administration (OSHA) requirements.',
    `total_invoice_count_evaluated` STRING COMMENT 'Total number of vendor invoices reviewed during the evaluation period for accuracy assessment.',
    `total_purchase_orders_evaluated` STRING COMMENT 'Total number of purchase orders (PO) included in the evaluation period sample for performance calculation.',
    `total_spend_amount` DECIMAL(18,2) COMMENT 'Total procurement spend with the vendor during the evaluation period in USD. Used for spend analytics and cost control reporting aligned with Cost of Goods Sold (COGS) and Earnings Before Interest Taxes Depreciation and Amortization (EBITDA) metrics.',
    `vendor_tier` STRING COMMENT 'Strategic vendor classification tier based on performance evaluation results. Determines eligibility for preferred pricing, contract renewals, and sourcing priority.. Valid values are `preferred|approved|conditional|probation|disqualified`',
    CONSTRAINT pk_vendor_performance PRIMARY KEY(`vendor_performance_id`)
) COMMENT 'Periodic vendor performance evaluation records capturing on-time delivery rate, fill rate, invoice accuracy, quality defect rate, safety incident count, environmental compliance violations, and overall scorecard rating. Supports strategic sourcing decisions, contract renewals, and preferred vendor tier management. Aligned with NWRA and SWANA supplier quality standards. Sourced from SAP MM and manual evaluation workflows.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`procurement`.`material` (
    `material_id` BIGINT COMMENT 'Unique identifier for the material master record. Primary key.',
    `class_id` BIGINT COMMENT 'Foreign key linking to asset.asset_class. Business justification: Spare parts and consumables must map to the asset classes they support for MRO planning, criticality-based inventory optimization, bill-of-materials management, and asset lifecycle cost analysis. Enab',
    `waste_stream_id` BIGINT COMMENT 'Foreign key linking to service.service_waste_stream. Business justification: Materials used in operations (PPE, chemicals, supplies) generate specific waste streams requiring proper characterization and disposal. Real business process: waste characterization, disposal planning',
    `material_group_id` BIGINT COMMENT 'Foreign key linking to procurement.material_group. Business justification: Material classification FK. material.material_group is a STRING code; need FK to material_group.material_group_id for proper normalization. Remove material_group code column as it becomes redundant (c',
    `safety_program_id` BIGINT COMMENT 'Foreign key linking to safety.safety_program. Business justification: Hazardous materials and PPE procurement requires verification that safety program requirements (OSHA compliance, training, handling procedures) are met. Material master must reference governing safety',
    `abc_indicator` STRING COMMENT 'ABC classification for inventory management prioritization. A = high-value/high-usage, B = moderate, C = low-value/low-usage.. Valid values are `A|B|C`',
    `base_unit_of_measure` STRING COMMENT 'Primary unit of measure for inventory, ordering, and usage tracking. Common values: EA (each), GAL (gallon), LB (pound), TON, KG (kilogram), L (liter), M (meter), FT (foot), BOX, CASE, DRUM, PALLET. [ENUM-REF-CANDIDATE: EA|GAL|LB|TON|KG|L|M|FT|BOX|CASE|DRUM|PALLET — 12 candidates stripped; promote to reference product]',
    `batch_managed_flag` BOOLEAN COMMENT 'Indicates whether the material requires batch/lot number tracking for quality control, expiration management, and recall capability.',
    `created_date` DATE COMMENT 'Date when the material master record was first created in the system.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for standard cost and moving average price (e.g., USD, CAD).. Valid values are `^[A-Z]{3}$`',
    `dot_hazard_class` STRING COMMENT 'DOT hazard classification for transportation of hazardous materials (e.g., Class 3 Flammable Liquids, Class 8 Corrosives).',
    `environmental_compliance_flag` BOOLEAN COMMENT 'Indicates whether the material is subject to environmental regulations requiring special tracking, reporting, or disposal procedures under EPA, Clean Air Act, or Clean Water Act.',
    `gross_weight` DECIMAL(18,2) COMMENT 'Total weight of the material including packaging. Used for transportation planning and freight cost calculation.',
    `hazardous_material_flag` BOOLEAN COMMENT 'Indicates whether the material is classified as hazardous under RCRA, DOT, or OSHA regulations, requiring special handling, storage, and disposal procedures.',
    `last_modified_by` STRING COMMENT 'User ID or name of the person who last modified the material master record. Used for audit trail and change tracking.',
    `last_modified_date` DATE COMMENT 'Date when the material master record was last updated or changed.',
    `lead_time_days` STRING COMMENT 'Expected number of days from purchase order creation to material receipt. Used for procurement planning and MRP calculations.',
    `long_description` STRING COMMENT 'Extended description providing detailed specifications, usage instructions, or technical details for the material.',
    `manufacturer_name` STRING COMMENT 'Name of the original equipment manufacturer (OEM) or producer of the material. Used for quality control and warranty tracking.',
    `manufacturer_part_number` STRING COMMENT 'OEM part number or catalog identifier used for cross-referencing and procurement from authorized suppliers.',
    `material_description` STRING COMMENT 'Short textual description of the material for identification and procurement purposes.',
    `material_number` STRING COMMENT 'Externally-known unique material identifier used across procurement, inventory, and operations. Sourced from SAP MM Material Master.. Valid values are `^[A-Z0-9]{8,18}$`',
    `material_status` STRING COMMENT 'Current lifecycle status of the material master record. Active materials are available for procurement and use; inactive/obsolete materials are phased out.. Valid values are `active|inactive|obsolete|blocked|pending_approval`',
    `material_type` STRING COMMENT 'High-level classification of the material defining its procurement and inventory treatment (e.g., raw material, spare part, fuel, PPE, container, chemical, consumable, service, equipment). [ENUM-REF-CANDIDATE: raw_material|spare_part|fuel|ppe|container|chemical|consumable|service|equipment — 9 candidates stripped; promote to reference product]',
    `minimum_order_quantity` DECIMAL(18,2) COMMENT 'Minimum quantity that must be ordered from the vendor per purchase order. Used in procurement planning and MRP.',
    `moving_average_price` DECIMAL(18,2) COMMENT 'Moving average price calculated from actual procurement costs. Used for inventory valuation and variance analysis.',
    `net_weight` DECIMAL(18,2) COMMENT 'Weight of the material excluding packaging. Used for usage tracking and disposal cost calculation.',
    `ppe_category` STRING COMMENT 'Classification of PPE type if applicable (e.g., gloves, hi-vis vests, respirators, safety boots, hard hats). Used for OSHA compliance and workforce safety tracking.',
    `procurement_type` STRING COMMENT 'Defines whether the material is procured externally from vendors, produced internally, or both.. Valid values are `external|internal|both`',
    `purchase_order_unit` STRING COMMENT 'Unit of measure used when creating purchase orders for this material. May differ from base UOM for bulk purchasing. [ENUM-REF-CANDIDATE: EA|GAL|LB|TON|KG|L|M|FT|BOX|CASE|DRUM|PALLET — 12 candidates stripped; promote to reference product]',
    `rcra_waste_code` STRING COMMENT 'EPA RCRA waste code if the material is a hazardous waste or chemical requiring regulated disposal (e.g., D001 for ignitable waste, F001 for spent halogenated solvents).. Valid values are `^[DUFKP][0-9]{3}$`',
    `reorder_point` DECIMAL(18,2) COMMENT 'Inventory level at which a replenishment order should be triggered to avoid stockouts. Used in automated procurement workflows.',
    `safety_stock_quantity` DECIMAL(18,2) COMMENT 'Buffer inventory quantity maintained to mitigate supply chain variability and prevent operational disruptions.',
    `serial_number_profile` STRING COMMENT 'Configuration code indicating whether the material requires serial number tracking for individual unit traceability (e.g., high-value equipment, containers).',
    `shelf_life_days` STRING COMMENT 'Number of days the material remains usable from receipt date. Applicable to chemicals, lubricants, and perishable supplies.',
    `standard_cost` DECIMAL(18,2) COMMENT 'Standard unit cost for the material used in cost accounting, budgeting, and COGS calculation. Supports EBITDA reporting.',
    `storage_class` STRING COMMENT 'Classification code defining storage requirements and warehouse location assignment (e.g., flammable storage, refrigerated, outdoor, hazmat cage).',
    `un_number` STRING COMMENT 'Four-digit UN identification number for hazardous materials used in international shipping and transport documentation.. Valid values are `^UN[0-9]{4}$`',
    `volume` DECIMAL(18,2) COMMENT 'Physical volume of the material used for storage space planning and transportation optimization.',
    `volume_unit` STRING COMMENT 'Unit of measure for volume (e.g., GAL, L, FT3, M3, IN3).. Valid values are `GAL|L|FT3|M3|IN3`',
    `weight_unit` STRING COMMENT 'Unit of measure for gross and net weight (e.g., LB, KG, TON, G, OZ).. Valid values are `LB|KG|TON|G|OZ`',
    `created_by` STRING COMMENT 'User ID or name of the person who created the material master record. Used for audit trail and data governance.',
    CONSTRAINT pk_material PRIMARY KEY(`material_id`)
) COMMENT 'Material master catalog defining all procured goods and materials used across Waste Management operations — fleet parts (filters, tires, hydraulic components), fuels (diesel, CNG, RNG, DEF), PPE (gloves, hi-vis vests, respirators), containers (carts, dumpsters, roll-offs), chemicals (leachate treatment, landfill cover agents), lubricants, and facility supplies. Captures material number, description, unit of measure, material group, hazardous material flag, RCRA waste code applicability, storage class, and standard cost. Sourced from SAP MM Material Master (MARA/MARC).';

CREATE OR REPLACE TABLE `waste_management_ecm`.`procurement`.`material_group` (
    `material_group_id` BIGINT COMMENT 'Unique identifier for the material group. Primary key.',
    `parent_material_group_id` BIGINT COMMENT 'Reference to parent material group for hierarchical classification. Supports multi-level spend category rollups and reporting. Null for top-level groups.',
    `active_flag` BOOLEAN COMMENT 'Indicates whether this material group is currently active and available for use in procurement transactions. Inactive groups are retained for historical reporting only.',
    `approval_workflow_code` STRING COMMENT 'Code identifying the approval workflow required for purchase requisitions and purchase orders in this material group. Maps to SAP MM release strategy.. Valid values are `^[A-Z0-9_]{3,20}$`',
    `carbon_footprint_category` STRING COMMENT 'Carbon footprint classification for materials in this group, used for greenhouse gas (GHG) emissions tracking and carbon dioxide equivalent (CO2e) reporting.. Valid values are `Low|Medium|High|Not Assessed`',
    `commodity_code` STRING COMMENT 'United Nations Standard Products and Services Code (UNSPSC) for global commodity classification and supplier catalog alignment.. Valid values are `^[0-9]{8,10}$`',
    `contract_required_flag` BOOLEAN COMMENT 'Indicates whether purchases from this material group require an active supplier contract or blanket purchase order (PO) before procurement.',
    `cost_center_code` STRING COMMENT 'Default cost center for expense allocation of materials in this group. Used for departmental budget tracking and COGS analysis.. Valid values are `^[A-Z0-9]{4,10}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this material group record was first created in the system.',
    `dot_regulated_indicator` BOOLEAN COMMENT 'Flag indicating whether materials in this group require DOT compliance for transportation, including placarding, manifesting, and driver certification.',
    `effective_end_date` DATE COMMENT 'Date when this material group was deactivated or retired. Null for currently active groups.',
    `effective_start_date` DATE COMMENT 'Date when this material group became active and available for procurement use.',
    `epa_regulated_indicator` BOOLEAN COMMENT 'Flag indicating whether materials in this group are subject to EPA environmental compliance tracking and reporting requirements.',
    `gl_account_code` STRING COMMENT 'Default general ledger account code for financial posting of purchases within this material group. Maps to SAP FI chart of accounts.. Valid values are `^[0-9]{6,10}$`',
    `hazmat_indicator` BOOLEAN COMMENT 'Flag indicating whether materials in this group are classified as hazardous under RCRA, DOT, or OSHA regulations. Triggers special handling, storage, and disposal requirements.',
    `hierarchy_level` STRING COMMENT 'Level in the material group hierarchy (1=top level, 2=second level, etc.). Used for rollup reporting and drill-down analytics.',
    `last_modified_by` STRING COMMENT 'User ID or name of the person who last modified this material group record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this material group record was last modified in the system.',
    `lead_time_days` STRING COMMENT 'Typical procurement lead time in days from purchase order creation to goods receipt for materials in this group.',
    `material_group_code` STRING COMMENT 'SAP material group code (MATKL) used for classification and procurement categorization. Alphanumeric identifier matching SAP MM material group master.. Valid values are `^[A-Z0-9]{4,10}$`',
    `material_group_description` STRING COMMENT 'Detailed description of the material group, including scope, typical items, and usage guidance for procurement teams.',
    `material_group_name` STRING COMMENT 'Full business name of the material group for display and reporting purposes.',
    `material_type` STRING COMMENT 'SAP material type code (MTART): ROH=Raw Material, HALB=Semi-Finished, FERT=Finished Product, HAWA=Trading Goods, DIEN=Services, VERP=Packaging, NLAG=Non-Stock, UNBW=Non-Valuated, ERSA=Spare Parts. [ENUM-REF-CANDIDATE: ROH|HALB|FERT|HAWA|DIEN|VERP|NLAG|UNBW|ERSA — 9 candidates stripped; promote to reference product]',
    `minimum_order_quantity` DECIMAL(18,2) COMMENT 'Default minimum order quantity for materials in this group, used for procurement planning and supplier negotiation.',
    `osha_ppe_required_indicator` BOOLEAN COMMENT 'Flag indicating whether handling materials in this group requires specific PPE under OSHA safety standards.',
    `procurement_type` STRING COMMENT 'Classification of procurement nature: direct materials for operations, indirect materials for support, services, capital equipment, maintenance-repair-operations (MRO), or subcontracting.. Valid values are `Direct Material|Indirect Material|Services|Capital Equipment|MRO|Subcontracting`',
    `purchasing_group_code` STRING COMMENT 'Default purchasing group responsible for sourcing and vendor management for this material group. Maps to SAP MM purchasing organization.. Valid values are `^[A-Z0-9]{3,6}$`',
    `shelf_life_days` STRING COMMENT 'Maximum shelf life in days for perishable or time-sensitive materials in this group. Null for non-perishable items.',
    `sort_order` STRING COMMENT 'Numeric value controlling display sequence of material groups in reports and user interfaces.',
    `spend_category` STRING COMMENT 'High-level spend classification for strategic sourcing and budget allocation. Aligns with COGS and EBITDA reporting categories. [ENUM-REF-CANDIDATE: Fleet Parts & Components|Fuel & Energy|PPE & Safety Equipment|Containers & Equipment|Chemicals & Reagents|Facility Supplies|Professional Services|Third-Party Disposal Services|IT & Technology|Other — 10 candidates stripped; promote to reference product]',
    `storage_condition_code` STRING COMMENT 'Required storage conditions for materials in this group: ambient, refrigerated, frozen, climate-controlled, hazmat-compliant storage, outdoor, or secure storage. [ENUM-REF-CANDIDATE: AMBIENT|REFRIGERATED|FROZEN|CLIMATE_CONTROLLED|HAZMAT_STORAGE|OUTDOOR|SECURE — 7 candidates stripped; promote to reference product]',
    `strategic_sourcing_flag` BOOLEAN COMMENT 'Indicates whether this material group is managed under a strategic sourcing program with negotiated contracts, preferred suppliers, and volume commitments.',
    `supplier_diversity_flag` BOOLEAN COMMENT 'Indicates whether this material group is targeted for supplier diversity programs (minority-owned, women-owned, veteran-owned, small business suppliers).',
    `sustainability_category` STRING COMMENT 'Sustainability classification for materials in this group, supporting green procurement initiatives and ESG reporting. [ENUM-REF-CANDIDATE: Renewable|Recycled Content|Energy Efficient|Low Emission|Biodegradable|Conventional|Not Applicable — 7 candidates stripped; promote to reference product]',
    `tax_classification_code` STRING COMMENT 'Tax classification code for materials in this group, determining applicable sales tax, use tax, or VAT treatment. Maps to SAP SD tax determination.. Valid values are `^[A-Z0-9]{1,4}$`',
    `unit_of_measure` STRING COMMENT 'Standard unit of measure for ordering and inventory tracking: EA=Each, LB=Pound, KG=Kilogram, GAL=Gallon, L=Liter, TON=Ton, M=Meter, FT=Foot, HR=Hour, DAY=Day, CASE=Case, PALLET=Pallet. [ENUM-REF-CANDIDATE: EA|LB|KG|GAL|L|TON|M|FT|HR|DAY|CASE|PALLET — 12 candidates stripped; promote to reference product]',
    `valuation_class` STRING COMMENT 'SAP valuation class for inventory accounting and balance sheet classification. Determines how material value is posted to financial accounts.. Valid values are `^[0-9]{4}$`',
    `created_by` STRING COMMENT 'User ID or name of the person who created this material group record in the system.',
    CONSTRAINT pk_material_group PRIMARY KEY(`material_group_id`)
) COMMENT 'Reference classification taxonomy for grouping procured materials and services into spend categories — Fleet Parts & Components, Fuel & Energy (Diesel/CNG/RNG), PPE & Safety Equipment, Containers & Equipment, Chemicals & Reagents, Facility Supplies, Professional Services, Third-Party Disposal Services, IT & Technology. Supports spend analytics, budget allocation by COGS category, and sourcing strategy segmentation. Maps to SAP MM material group (MATKL) and GL account assignment.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`procurement`.`purchase_requisition` (
    `purchase_requisition_id` BIGINT COMMENT 'Unique identifier for the purchase requisition. Primary key.',
    `employee_id` BIGINT COMMENT 'Employee ID of the manager or authorized approver who approved or rejected the requisition.',
    `material_group_id` BIGINT COMMENT 'Foreign key linking to procurement.material_group. Business justification: Requisitions are categorized by material group for spend classification. Currently has material_group_code (STRING); need FK to material_group.material_group_id. Remove material_group_code as it becom',
    `material_id` BIGINT COMMENT 'Foreign key linking to procurement.material. Business justification: Requisitions request specific materials. Currently has material_code (STRING) and material_description; need FK to material.material_id. Remove material_code and material_description as they can be re',
    `requester_employee_id` BIGINT COMMENT 'Unique identifier of the employee who created the purchase requisition.',
    `approval_date` DATE COMMENT 'Date when the purchase requisition was approved by the authorized approver.',
    `asset_number` STRING COMMENT 'Fixed asset number if the requisition is for capital equipment or asset acquisition requiring capitalization.. Valid values are `^[A-Z0-9]{8,12}$`',
    `budget_period` STRING COMMENT 'Fiscal period (month) within the budget year for granular budget tracking and variance analysis.',
    `budget_year` STRING COMMENT 'Fiscal year against which the requisition expense is budgeted and tracked for financial planning.',
    `contract_number` STRING COMMENT 'Reference to an existing supplier contract or blanket purchase agreement, if applicable.. Valid values are `^[A-Z0-9]{10,20}$`',
    `cost_center_code` STRING COMMENT 'Cost center to which the requisition expense will be charged for budget tracking and financial reporting.. Valid values are `^[0-9]{6,10}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the purchase requisition record was first created in the source system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the estimated value (e.g., USD, CAD).. Valid values are `^[A-Z]{3}$`',
    `estimated_total_value` DECIMAL(18,2) COMMENT 'Total estimated value of the requisition (quantity × estimated unit price) for budget authorization and spend control.',
    `estimated_unit_price` DECIMAL(18,2) COMMENT 'Estimated price per unit for budget planning and pre-commitment purposes.',
    `gl_account_code` STRING COMMENT 'General ledger account code for financial classification and posting of the requisition expense.. Valid values are `^[0-9]{6,10}$`',
    `internal_order_number` STRING COMMENT 'Internal order number for tracking costs related to specific operational activities or maintenance work orders.. Valid values are `^[0-9]{10}$`',
    `is_capital_expenditure` BOOLEAN COMMENT 'Flag indicating whether the requisition is for capital expenditure requiring asset capitalization (true) or operational expenditure (false).',
    `is_emergency_purchase` BOOLEAN COMMENT 'Flag indicating whether this is an emergency requisition requiring expedited approval and procurement due to operational urgency.',
    `justification` STRING COMMENT 'Business justification or reason for the purchase requisition, explaining the operational need and urgency.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the purchase requisition record was last updated or modified in the source system.',
    `plant_code` STRING COMMENT 'SAP plant code representing the facility or operational location where the material or service will be delivered (e.g., landfill, MRF, transfer station).. Valid values are `^[A-Z0-9]{4}$`',
    `pr_number` STRING COMMENT 'Business-facing unique purchase requisition number used for tracking and reference across procurement workflows.. Valid values are `^PR[0-9]{10}$`',
    `pr_status` STRING COMMENT 'Current lifecycle status of the purchase requisition in the approval and procurement workflow. [ENUM-REF-CANDIDATE: draft|submitted|pending_approval|approved|rejected|partially_ordered|fully_ordered|cancelled|closed — 9 candidates stripped; promote to reference product]',
    `pr_type` STRING COMMENT 'Classification of the requisition based on procurement category: standard purchase, stock replenishment, service procurement, subcontracting, consignment, or third-party.. Valid values are `standard|stock_replenishment|service|subcontracting|consignment|third_party`',
    `preferred_vendor_code` STRING COMMENT 'Vendor code for the preferred or suggested supplier, if specified by the requester.. Valid values are `^[A-Z0-9]{6,10}$`',
    `priority_code` STRING COMMENT 'Priority level of the requisition indicating urgency for procurement and delivery.. Valid values are `low|normal|high|urgent|emergency`',
    `purchase_order_number` STRING COMMENT 'Purchase order number generated from this requisition once converted to a formal PO. Null if not yet ordered.. Valid values are `^PO[0-9]{10}$`',
    `purchasing_group_code` STRING COMMENT 'Code identifying the purchasing group responsible for sourcing and procurement execution.. Valid values are `^[A-Z0-9]{3}$`',
    `quantity` DECIMAL(18,2) COMMENT 'Quantity of the material or service units being requested.',
    `rejection_reason` STRING COMMENT 'Explanation provided by the approver if the requisition was rejected, including corrective actions needed.',
    `requesting_department_code` STRING COMMENT 'Code identifying the operational department initiating the requisition (e.g., fleet maintenance, landfill operations, MRF, hazmat, facilities).. Valid values are `^[A-Z0-9]{4,10}$`',
    `requesting_department_name` STRING COMMENT 'Full name of the department requesting the goods or services.',
    `required_delivery_date` DATE COMMENT 'Date by which the requested goods or services must be delivered to meet operational needs.',
    `requisition_date` DATE COMMENT 'Date when the purchase requisition was created or submitted by the requesting department.',
    `source_system` STRING COMMENT 'Source system from which the purchase requisition record originated (e.g., SAP MM, external procurement portal).',
    `storage_location_code` STRING COMMENT 'Storage location within the plant where the material will be received and stored.. Valid values are `^[A-Z0-9]{4}$`',
    `unit_of_measure` STRING COMMENT 'Unit of measure for the requested quantity (e.g., EA for each, GAL for gallons, TON for tons, HR for hours).. Valid values are `^[A-Z]{2,3}$`',
    `wbs_element` STRING COMMENT 'WBS element code for project-related requisitions, linking the expense to a specific capital project or initiative.. Valid values are `^[A-Z0-9-]{8,24}$`',
    CONSTRAINT pk_purchase_requisition PRIMARY KEY(`purchase_requisition_id`)
) COMMENT 'Internal procurement request initiated by operational departments (fleet maintenance, landfill operations, MRF, hazmat, facilities) to request goods or services before a formal PO is issued. Captures requesting department, cost center, GL account, material or service description, quantity, estimated value, required delivery date, justification, and approval workflow status. Supports budget pre-commitment and spend authorization controls. Sourced from SAP MM PR (EBAN).';

CREATE OR REPLACE TABLE `waste_management_ecm`.`procurement`.`purchase_order` (
    `purchase_order_id` BIGINT COMMENT 'Unique identifier for the purchase order. Primary key.',
    `purchase_requisition_id` BIGINT COMMENT 'Foreign key linking to procurement.purchase_requisition. Business justification: Purchase orders are created from purchase requisitions. Currently has requisition_reference (STRING PR number); need FK to purchase_requisition.purchase_requisition_id for proper lineage tracking. Rem',
    `sourcing_contract_id` BIGINT COMMENT 'Foreign key linking to procurement.sourcing_contract. Business justification: Purchase orders can be released against framework sourcing contracts. Currently has contract_reference (STRING contract number); need FK to sourcing_contract.sourcing_contract_id. Remove contract_refe',
    `vendor_id` BIGINT COMMENT 'Identifier of the vendor to whom this purchase order is issued. References the supplier master record.',
    `approval_date` DATE COMMENT 'Date when the purchase order received final approval and was authorized for release to the vendor.',
    `approval_status` STRING COMMENT 'Current approval workflow status for the purchase order. Indicates whether the PO has passed required authorization levels per procurement policy and spending thresholds.. Valid values are `not_required|pending|approved|rejected`',
    `approved_by` STRING COMMENT 'User ID or name of the person who provided final approval for the purchase order. Used for audit trail and accountability.',
    `collective_number` STRING COMMENT 'Grouping identifier for related purchase orders processed together. Used for batch processing and consolidated vendor communication.',
    `company_code` STRING COMMENT 'Financial accounting organizational unit to which this purchase order is assigned. Used for General Ledger (GL) posting and financial reporting.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the purchase order record was first created in the system. Used for audit trail and process cycle time analysis.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the purchase order value (e.g., USD, CAD, MXN).. Valid values are `^[A-Z]{3}$`',
    `deletion_indicator` BOOLEAN COMMENT 'Flag indicating whether the purchase order is marked for deletion. Soft-delete flag used to exclude PO from active processing while retaining historical record.',
    `delivery_date` DATE COMMENT 'Requested or promised delivery date for goods or services specified in the purchase order. Used for vendor performance tracking and logistics planning.',
    `document_date` DATE COMMENT 'Date when the purchase order document was created in the system. Represents the business event timestamp for PO issuance.',
    `exchange_rate` DECIMAL(18,2) COMMENT 'Currency exchange rate applied at the time of purchase order creation for foreign currency transactions. Used to convert PO value to company code currency for financial reporting.',
    `goods_receipt_indicator` BOOLEAN COMMENT 'Flag indicating whether goods receipt posting is required for this purchase order. True for material procurement, false for service-only POs.',
    `incoterms` STRING COMMENT 'International Commercial Terms defining the responsibilities of buyer and seller for delivery, insurance, and risk transfer (e.g., FOB, CIF, DDP). Standardized by International Chamber of Commerce.',
    `incoterms_location` STRING COMMENT 'Named place or port specified in the Incoterms clause where risk and cost transfer occurs.',
    `invoice_receipt_indicator` BOOLEAN COMMENT 'Flag indicating whether invoice verification is required for this purchase order. Controls Accounts Payable (AP) processing workflow.',
    `modified_by` STRING COMMENT 'User ID or name of the person who last modified the purchase order. Used for change tracking and accountability.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when the purchase order was last modified. Tracks the most recent change to the PO record.',
    `net_po_value` DECIMAL(18,2) COMMENT 'Total purchase order value including tax. Represents the final amount payable to the vendor upon fulfillment.',
    `notes` STRING COMMENT 'Free-text field for additional comments, special terms, or internal notes related to the purchase order. Used for non-standard requirements or clarifications.',
    `payment_terms` STRING COMMENT 'Agreed payment conditions between Waste Management and the vendor. Specifies due date calculation, discount periods, and cash discount percentages (e.g., Net 30, 2/10 Net 30).',
    `plant` STRING COMMENT 'Physical location or facility where goods will be received or services will be performed. May represent landfill sites, Materials Recovery Facility (MRF), fleet maintenance depots, or administrative offices.',
    `po_number` STRING COMMENT 'Externally-known unique purchase order document number issued to vendor. Standard 10-digit SAP PO number format.. Valid values are `^[0-9]{10}$`',
    `po_status` STRING COMMENT 'Current lifecycle status of the purchase order in the procurement workflow. Draft indicates initial creation, pending approval awaits authorization, approved is authorized but not yet released to vendor, released is transmitted to vendor, partially received indicates some goods/services delivered, fully received indicates complete delivery, closed is administratively finalized, cancelled is voided. [ENUM-REF-CANDIDATE: draft|pending_approval|approved|released|partially_received|fully_received|closed|cancelled — 8 candidates stripped; promote to reference product]',
    `po_type` STRING COMMENT 'Classification of the purchase order type. Standard for one-time orders, blanket for recurring orders with release strategy, framework for long-term agreements, contract for service-based procurement, subcontracting for external processing, consignment for vendor-owned inventory.. Valid values are `standard|blanket|framework|contract|subcontracting|consignment`',
    `purchasing_group` STRING COMMENT 'Buyer or procurement team responsible for this purchase order. Used for workload distribution and accountability.',
    `purchasing_organization` STRING COMMENT 'Organizational unit responsible for procurement activities. Represents the legal entity or division negotiating with vendors.',
    `release_date` DATE COMMENT 'Date when the purchase order was released and transmitted to the vendor. Marks the start of vendor fulfillment obligations.',
    `shipping_instructions` STRING COMMENT 'Special instructions for delivery, handling, or transportation of goods. May include requirements for hazardous materials handling, Department of Transportation (DOT) compliance, or site-specific access procedures.',
    `storage_location` STRING COMMENT 'Specific storage area within the plant where materials will be received and stored. Used for inventory management and warehouse operations.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Total tax amount calculated for the purchase order based on applicable tax jurisdiction and rates.',
    `total_po_value` DECIMAL(18,2) COMMENT 'Total monetary value of the purchase order including all line items, before tax. Used for spend analytics, budget tracking, and Cost of Goods Sold (COGS) reporting.',
    `validity_end_date` DATE COMMENT 'End date of the purchase order validity period. After this date, no further releases or goods receipts are permitted against the PO.',
    `validity_start_date` DATE COMMENT 'Start date of the purchase order validity period. Relevant for blanket and framework orders with defined time windows.',
    `vendor_contact_email` STRING COMMENT 'Email address of the vendor contact person. Organizational contact data classified as confidential business information.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `vendor_contact_person` STRING COMMENT 'Name of the primary contact person at the vendor organization for this purchase order. Used for order clarification and issue resolution.',
    `vendor_contact_phone` STRING COMMENT 'Phone number of the vendor contact person. Organizational contact data classified as confidential business information.',
    `created_by` STRING COMMENT 'User ID or name of the procurement specialist who created the purchase order in the system.',
    CONSTRAINT pk_purchase_order PRIMARY KEY(`purchase_order_id`)
) COMMENT 'Formal legally binding purchase order issued to a vendor for procurement of goods or services. Captures PO number, vendor, PO type (standard, blanket, framework, subcontracting), document date, delivery date, plant/storage location, payment terms, incoterms, total PO value, currency, approval status, and sourcing contract reference. Core transactional entity for all procurement spend at Waste Management. Sourced from SAP MM PO (EKKO).';

CREATE OR REPLACE TABLE `waste_management_ecm`.`procurement`.`po_line` (
    `po_line_id` BIGINT COMMENT 'Unique identifier for the purchase order line item. Primary key.',
    `material_id` BIGINT COMMENT 'Foreign key reference to the material master record being procured. Identifies the specific material, part, or service item.',
    `purchase_order_id` BIGINT COMMENT 'Foreign key reference to the parent purchase order header. Links this line item to its containing purchase order document.',
    `asset_number` STRING COMMENT 'The fixed asset number when the procurement is capitalized as an asset. Used for fleet vehicles, equipment, and facility infrastructure purchases.',
    `cost_center` STRING COMMENT 'The cost center to which this purchase order line is charged. Enables cost allocation and departmental expense tracking for Earnings Before Interest Taxes Depreciation and Amortization (EBITDA) reporting.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this purchase order line item record was first created in the system. Used for audit trail and procurement cycle time analysis.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the line item pricing (e.g., USD, CAD, MXN). Supports multi-currency procurement operations.. Valid values are `^[A-Z]{3}$`',
    `deletion_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether this purchase order line has been marked for deletion. Deleted lines are excluded from further processing but retained for audit history.',
    `delivery_date` DATE COMMENT 'The requested or scheduled delivery date for this line item. Critical for fleet maintenance scheduling and operational planning.',
    `final_invoice_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether the final invoice has been received for this line item. When true, no further invoices are expected and the line can be closed.',
    `gl_account` STRING COMMENT 'The general ledger account code for expense or asset posting. Determines the financial classification of the procurement spend.',
    `goods_receipt_based_invoice_verification` BOOLEAN COMMENT 'Boolean flag indicating whether invoice verification is based on goods receipt rather than purchase order. When true, invoices are matched against goods receipts.',
    `goods_receipt_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether a goods receipt is required for this line item. When true, a goods receipt transaction must be posted before invoice verification.',
    `invoice_receipt_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether invoice verification is required for this line item. Controls the three-way match process (Purchase Order - Goods Receipt - Invoice).',
    `item_category` STRING COMMENT 'The purchase order item category code that controls the procurement behavior (e.g., standard item, consignment, subcontracting, service, text item). Determines processing rules and account assignment.',
    `line_number` STRING COMMENT 'Sequential line item number within the purchase order. Determines the ordering and display sequence of line items.',
    `line_status` STRING COMMENT 'The current lifecycle status of the purchase order line item. Tracks progression from open through receipt, invoicing, and closure.. Valid values are `open|partially_received|fully_received|invoiced|closed|cancelled`',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when this purchase order line item record was last modified. Tracks changes to quantities, pricing, delivery dates, or account assignments.',
    `net_value` DECIMAL(18,2) COMMENT 'The total net value of this purchase order line (quantity ordered multiplied by unit price). Excludes taxes and surcharges. Key metric for spend analytics and Cost of Goods Sold (COGS) reporting.',
    `open_quantity` DECIMAL(18,2) COMMENT 'The remaining quantity still outstanding for delivery. Calculated as quantity ordered minus quantity received.',
    `over_delivery_tolerance_percent` DECIMAL(18,2) COMMENT 'The acceptable percentage over-delivery tolerance for this line item. Allows goods receipt posting up to this percentage above the ordered quantity.',
    `plant_code` STRING COMMENT 'The plant or facility code where the material or service will be received or consumed. Maps to waste collection facilities, Materials Recovery Facilities (MRF), landfills, or maintenance depots.',
    `purchasing_info_record` STRING COMMENT 'Reference to the purchasing info record that contains vendor-specific material data, pricing conditions, and delivery terms. Supports vendor performance tracking and price history.',
    `quantity_invoiced` DECIMAL(18,2) COMMENT 'The cumulative quantity that has been invoiced by the vendor against this purchase order line. Used for three-way match validation.',
    `quantity_ordered` DECIMAL(18,2) COMMENT 'The total quantity of material or service units ordered on this line item. Represents the original purchase order commitment.',
    `quantity_received` DECIMAL(18,2) COMMENT 'The cumulative quantity of goods or services that have been received against this purchase order line. Updated through goods receipt (GR) transactions.',
    `requisitioner_name` STRING COMMENT 'The name of the employee or department that requested this procurement. Used for accountability and spend analysis by requesting organization.',
    `short_text` STRING COMMENT 'Brief description of the material or service being procured on this line. Provides human-readable context for the line item.',
    `storage_location` STRING COMMENT 'The specific storage location within the plant where the material will be stocked. Used for parts inventory and supply management.',
    `tax_amount` DECIMAL(18,2) COMMENT 'The calculated tax amount for this purchase order line based on the tax code and net value.',
    `tax_code` STRING COMMENT 'The tax code applied to this purchase order line. Determines the tax calculation rules and rates for the line item.',
    `tracking_number` STRING COMMENT 'The shipment tracking number provided by the carrier for this line item delivery. Enables delivery monitoring and receipt coordination.',
    `under_delivery_tolerance_percent` DECIMAL(18,2) COMMENT 'The acceptable percentage under-delivery tolerance for this line item. Allows the line to be closed when delivery is within this percentage below the ordered quantity.',
    `unit_of_measure` STRING COMMENT 'The unit of measure for the quantity ordered (e.g., EA for each, GAL for gallons, TON for tons, HR for hours). Critical for fleet parts, fuel, and container procurement.',
    `unit_price` DECIMAL(18,2) COMMENT 'The price per unit of measure for this line item. Used to calculate the net value of the line.',
    `vendor_material_number` STRING COMMENT 'The vendors own part number or service code for the material being procured. Facilitates vendor communication and order fulfillment.',
    `wbs_element` STRING COMMENT 'The project Work Breakdown Structure element for capital project procurement. Used when procuring materials or services for capital projects such as landfill cell construction or facility upgrades.',
    `created_by` STRING COMMENT 'The user ID of the person who created this purchase order line item. Supports audit trail and procurement accountability.',
    CONSTRAINT pk_po_line PRIMARY KEY(`po_line_id`)
) COMMENT 'Individual line items within a purchase order, each representing a distinct material, service, or cost object being procured. Captures line number, material or service description, quantity ordered, unit of measure, unit price, net value, delivery date, account assignment (cost center, WBS element, asset), goods receipt indicator, invoice receipt indicator, and open quantity. Enables line-level spend tracking, partial delivery management, and three-way match (PO-GR-Invoice). Sourced from SAP MM PO item (EKPO).';

CREATE OR REPLACE TABLE `waste_management_ecm`.`procurement`.`goods_receipt` (
    `goods_receipt_id` BIGINT COMMENT 'Unique identifier for the goods receipt transaction. Primary key for the goods receipt record.',
    `fixed_asset_id` BIGINT COMMENT 'Foreign key linking to asset.fixed_asset. Business justification: Capital asset purchases require linking goods receipt to the capitalized fixed asset for audit trail, asset accounting reconciliation, and SOX compliance. Essential for matching acquisition cost (proc',
    `site_id` BIGINT COMMENT 'Foreign key linking to landfill.site. Business justification: Materials and equipment (daily cover material, liner components, monitoring equipment, safety supplies, fuel, parts) are delivered directly to landfill sites. Site managers need goods receipt tracking',
    `material_id` BIGINT COMMENT 'Reference to the material master record for the received item (fleet parts, fuel, containers, chemicals, PPE, equipment, facility supplies). Enables inventory tracking and spend analytics.',
    `po_line_id` BIGINT COMMENT 'Reference to the specific line item on the purchase order for which goods were received. Enables line-level three-way match.',
    `purchase_order_id` BIGINT COMMENT 'Reference to the purchase order against which goods or services were received. Links to the originating procurement document.',
    `employee_id` BIGINT COMMENT 'Reference to the employee who physically received and verified the goods. Supports accountability and audit trails for high-value or controlled materials.',
    `storeroom_id` BIGINT COMMENT 'Foreign key linking to maintenance.storeroom. Business justification: Goods receipts for maintenance parts are delivered to specific storerooms. Tracking this enables inventory reconciliation (procurement GR quantity vs. storeroom on-hand), receiving workflow management',
    `vendor_id` BIGINT COMMENT 'Reference to the supplier or vendor from whom the goods or services were received. Supports vendor performance tracking and accounts payable (AP) processing.',
    `asset_number` STRING COMMENT 'Fixed asset number if the goods receipt is for a capital asset or equipment that will be capitalized rather than expensed. Links to asset management and depreciation tracking.',
    `batch_number` STRING COMMENT 'The batch or lot number assigned to the received goods. Critical for chemicals, fuel, and materials requiring traceability for quality or regulatory compliance.',
    `cost_center` STRING COMMENT 'The cost center to which the goods receipt is charged for accounting purposes. Used for COGS and EBITDA reporting, particularly for consumables and services.. Valid values are `^[0-9]{10}$`',
    `created_by_user` STRING COMMENT 'The system user ID who created the goods receipt transaction. Supports accountability and audit compliance.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when the goods receipt record was first created in the system. Supports audit trails and process cycle time analysis.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the valuation amount (e.g., USD, CAD, MXN). Supports multi-currency operations and financial consolidation.. Valid values are `^[A-Z]{3}$`',
    `delivery_note_number` STRING COMMENT 'The external delivery note or packing slip number provided by the vendor. Used for reconciliation and dispute resolution.',
    `document_date` DATE COMMENT 'The date on the delivery note or packing slip provided by the vendor. May differ from posting date due to processing delays.',
    `fiscal_period` STRING COMMENT 'The fiscal period (month) within the fiscal year in which the goods receipt was posted. Supports monthly financial close and variance analysis.',
    `fiscal_year` STRING COMMENT 'The fiscal year in which the goods receipt was posted. Used for period-based financial reporting and year-end closing processes.',
    `general_ledger_account` STRING COMMENT 'The general ledger account number to which the goods receipt value is posted. Determines the financial statement line item impacted by the receipt.. Valid values are `^[0-9]{10}$`',
    `gr_document_number` STRING COMMENT 'The externally-known unique document number assigned to this goods receipt transaction in the source ERP system. Used for audit trails and cross-system reconciliation.. Valid values are `^[0-9]{10}$`',
    `gr_line_number` STRING COMMENT 'Sequential line item number within the goods receipt document. Supports multi-line receipts where multiple materials are received in a single transaction.',
    `last_modified_by_user` STRING COMMENT 'The system user ID who last modified the goods receipt record. Supports change tracking and audit compliance.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when the goods receipt record was last updated. Tracks changes for audit and data quality purposes.',
    `movement_type` STRING COMMENT 'SAP movement type code indicating the nature of the inventory transaction (e.g., 101 for GR against PO, 501 for transfer posting). Determines accounting and inventory impact.. Valid values are `^[0-9]{3}$`',
    `notes` STRING COMMENT 'Free-text notes or comments entered by the receiving employee regarding the condition of goods, discrepancies, or special handling instructions. Supports dispute resolution and quality tracking.',
    `plant_code` STRING COMMENT 'The facility or plant code where the goods were received (e.g., maintenance shop, landfill, MRF, transfer station). Determines inventory location and cost center assignment.. Valid values are `^[A-Z0-9]{4}$`',
    `posting_date` DATE COMMENT 'The date on which the goods receipt was posted to inventory and financial accounting. Used for period-end closing and financial reporting.',
    `quality_inspection_required_flag` BOOLEAN COMMENT 'Indicates whether the received goods require quality inspection before being released to unrestricted inventory. True for chemicals, hazardous materials, and critical fleet parts.',
    `quality_inspection_status` STRING COMMENT 'Current status of the quality inspection process for this goods receipt. Determines whether goods can be used or must remain in blocked stock.. Valid values are `pending|passed|failed|waived|not_required`',
    `reason_code` STRING COMMENT 'Optional code indicating the reason for the goods receipt transaction, particularly for non-standard movements (e.g., return from customer, transfer from another plant, emergency procurement).',
    `received_quantity` DECIMAL(18,2) COMMENT 'The actual quantity of goods received and accepted. Used for three-way match against PO quantity and invoice quantity.',
    `reference_document_number` STRING COMMENT 'External reference document number such as a Bill of Lading (BOL), shipping manifest, or work order (WO) number. Provides additional traceability for the receipt.',
    `reversal_date` DATE COMMENT 'The date on which this goods receipt was reversed. Null if the receipt has not been reversed.',
    `reversal_document_number` STRING COMMENT 'The document number of the reversal transaction if this goods receipt was cancelled. Provides audit trail for corrected transactions.',
    `reversal_flag` BOOLEAN COMMENT 'Indicates whether this goods receipt has been reversed or cancelled. True if the receipt was posted in error or if goods were returned to the vendor.',
    `source_system` STRING COMMENT 'The operational system from which the goods receipt record originated (e.g., SAP MM, AMCS Platform, manual entry). Supports data lineage and reconciliation.. Valid values are `SAP_MM|AMCS|MANUAL`',
    `stock_type` STRING COMMENT 'Classification of the inventory stock status after goods receipt. Unrestricted stock is available for use; quality inspection and blocked stock require clearance before use.. Valid values are `unrestricted|quality_inspection|blocked|restricted`',
    `storage_location` STRING COMMENT 'The specific storage location or warehouse within the plant where the goods were placed (e.g., parts room, fuel depot, chemical storage). Enables bin-level inventory tracking.. Valid values are `^[A-Z0-9]{4}$`',
    `unit_of_measure` STRING COMMENT 'The unit in which the received quantity is measured (e.g., EA=each, CS=case, GAL=gallon, TON=ton). Must match PO unit of measure for three-way match. [ENUM-REF-CANDIDATE: EA|CS|LB|KG|GAL|L|TON|M|FT|HR|DA — 11 candidates stripped; promote to reference product]',
    `valuation_amount` DECIMAL(18,2) COMMENT 'The total value of the goods received in the local currency, calculated as received quantity multiplied by the standard or moving average price. Updates inventory value and triggers financial postings.',
    `work_order_number` STRING COMMENT 'Maintenance work order number if the goods receipt is for parts or materials consumed in a fleet maintenance or facility repair activity. Enables job costing and maintenance spend tracking.',
    CONSTRAINT pk_goods_receipt PRIMARY KEY(`goods_receipt_id`)
) COMMENT 'Records the physical receipt of goods or confirmation of service delivery against a purchase order line. Captures GR document number, posting date, delivery note number, received quantity, unit of measure, storage location, plant, movement type, quality inspection flag, and receiving employee. Triggers inventory update and initiates the three-way match process for AP invoice verification. Critical for fleet parts receiving at maintenance shops, fuel deliveries, container deliveries, and chemical receipts at landfill/MRF sites. Sourced from SAP MM GR (MSEG/MKPF).';

CREATE OR REPLACE TABLE `waste_management_ecm`.`procurement`.`service_entry_sheet` (
    `service_entry_sheet_id` BIGINT COMMENT 'Unique identifier for the service entry sheet record. Primary key.',
    `facility_id` BIGINT COMMENT 'Reference to the facility where the service was performed, such as a landfill, MRF, or transfer station.',
    `site_id` BIGINT COMMENT 'Foreign key linking to landfill.site. Business justification: Professional services (environmental consulting, lab testing, engineering surveys, regulatory compliance audits, equipment maintenance) are frequently performed at specific landfill sites. Operations ',
    `po_line_id` BIGINT COMMENT 'Foreign key linking to procurement.po_line. Business justification: Service entry sheets confirm services against specific PO line items. Currently has po_line_item_number (INT line number within PO) but needs FK to po_line.po_line_id for proper referential integrity.',
    `employee_id` BIGINT COMMENT 'Reference to the employee who approved the service entry sheet for payment.',
    `purchase_order_id` BIGINT COMMENT 'Reference to the parent service-based purchase order against which this service entry is recorded.',
    `offering_id` BIGINT COMMENT 'Foreign key linking to service.offering. Business justification: Service entry sheets confirm delivery of purchased services and enable invoice matching. Real business process: service receipt confirmation, three-way matching, and invoice verification. Essential fo',
    `tertiary_service_last_modified_by_user_employee_id` BIGINT COMMENT 'User ID of the person who last modified the service entry sheet record.',
    `vendor_id` BIGINT COMMENT 'Reference to the vendor who performed the service.',
    `work_order_id` BIGINT COMMENT 'Reference to the work order or maintenance order that the service supports, if applicable.',
    `acceptance_date` DATE COMMENT 'Date when the service entry was formally accepted by the approver, enabling invoice verification and payment processing.',
    `acceptance_status` STRING COMMENT 'Current lifecycle status of the service entry sheet: draft (being prepared), submitted (awaiting approval), accepted (approved for payment), rejected (not accepted), or cancelled.. Valid values are `draft|submitted|accepted|rejected|cancelled`',
    `approver_name` STRING COMMENT 'Full name of the employee who approved the service entry sheet.',
    `cost_center_code` STRING COMMENT 'Cost center to which the service expense is allocated for financial reporting and cost control.. Valid values are `^[A-Z0-9]{6,10}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the service entry sheet record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the service amount (e.g., USD, CAD, MXN).. Valid values are `^[A-Z]{3}$`',
    `gl_account_code` STRING COMMENT 'General ledger account code to which the service expense is posted for financial accounting.. Valid values are `^[0-9]{6,10}$`',
    `invoice_reference_number` STRING COMMENT 'Vendor invoice number that references this service entry sheet for payment verification.',
    `invoice_verification_status` STRING COMMENT 'Status of invoice verification against this service entry: not verified, verified (matched to invoice), blocked (discrepancy found), or posted (payment released).. Valid values are `not_verified|verified|blocked|posted`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when the service entry sheet record was last modified.',
    `notes` STRING COMMENT 'Additional free-text notes or comments related to the service entry, such as special conditions or observations.',
    `rejection_reason` STRING COMMENT 'Textual explanation for why the service entry was rejected, if applicable.',
    `service_end_date` DATE COMMENT 'Date when the service performance period ended.',
    `service_entry_sheet_number` STRING COMMENT 'Business identifier for the service entry sheet, externally visible document number used for tracking and reference in SAP MM.. Valid values are `^[A-Z0-9]{10}$`',
    `service_performer_name` STRING COMMENT 'Name of the individual or team from the vendor who performed the service.',
    `service_quantity` DECIMAL(18,2) COMMENT 'Quantity of service units performed by the vendor, measured in the unit of measure specified for the service line.',
    `service_start_date` DATE COMMENT 'Date when the service performance period began.',
    `service_total_amount` DECIMAL(18,2) COMMENT 'Total monetary value of the service entry, calculated as service quantity multiplied by unit price.',
    `service_unit_of_measure` STRING COMMENT 'Unit of measure for the service quantity: hour, day, ton, cubic yard, each, trip, or month. [ENUM-REF-CANDIDATE: hour|day|ton|cubic_yard|each|trip|month — 7 candidates stripped; promote to reference product]',
    `service_unit_price` DECIMAL(18,2) COMMENT 'Price per unit of service as agreed in the purchase order, used for invoice verification.',
    CONSTRAINT pk_service_entry_sheet PRIMARY KEY(`service_entry_sheet_id`)
) COMMENT 'Formal confirmation of services rendered by a vendor against a service-based purchase order line. Used for professional services, third-party disposal services, environmental consulting, equipment rental, and contract labor. Captures service entry sheet number, service description, quantity of service units performed, acceptance status, approver, and acceptance date. Required for AP invoice verification for service POs. Sourced from SAP MM Service Entry Sheet (ESLL/ESLH).';

CREATE OR REPLACE TABLE `waste_management_ecm`.`procurement`.`vendor_invoice` (
    `vendor_invoice_id` BIGINT COMMENT 'Unique system identifier for the vendor invoice record. Primary key.',
    `employee_id` BIGINT COMMENT 'Reference to the employee who approved this invoice for payment. Used for audit trail and approval workflow tracking.',
    `goods_receipt_id` BIGINT COMMENT 'Reference to the goods receipt document confirming physical receipt of materials or services. Used in three-way match validation.',
    `run_id` BIGINT COMMENT 'Reference to the payment run batch in which this invoice was paid. Links to the payment execution process for cash management and reconciliation.',
    `purchase_order_id` BIGINT COMMENT 'Reference to the purchase order against which this invoice is submitted. Used for three-way match validation (PO-GR-Invoice).',
    `vendor_id` BIGINT COMMENT 'Reference to the vendor (supplier) who submitted this invoice. Links to vendor master data.',
    `approval_date` DATE COMMENT 'The date the invoice was approved for payment. Used for tracking approval cycle time and compliance with internal controls.',
    `baseline_date` DATE COMMENT 'The baseline date used for calculating payment due date and cash discount periods. Typically the invoice date or goods receipt date depending on payment terms configuration.',
    `company_code` STRING COMMENT 'The company code (legal entity) to which this invoice is assigned. Used for multi-entity financial consolidation and legal reporting.',
    `cost_center_code` STRING COMMENT 'The cost center to which the invoice expense is allocated. Used for internal cost accounting and departmental budget tracking.',
    `created_by_user` STRING COMMENT 'The username or user ID of the person who created this invoice record in the system. Used for audit trail and accountability.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this invoice record was first created in the system. Used for audit trail and data lineage tracking.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the invoice (e.g., USD, CAD, MXN). All monetary amounts on this invoice are denominated in this currency.. Valid values are `^[A-Z]{3}$`',
    `discount_amount` DECIMAL(18,2) COMMENT 'The total discount amount applied to the invoice, including early payment discounts, volume discounts, or negotiated rebates.',
    `due_date` DATE COMMENT 'The date by which payment is due to the vendor, calculated based on invoice date and payment terms. Used for cash flow planning and avoiding late payment penalties.',
    `fiscal_period` STRING COMMENT 'The fiscal period (month) within the fiscal year when the invoice was posted. Used for monthly financial close and period-based reporting.',
    `fiscal_year` STRING COMMENT 'The fiscal year in which the invoice was posted, used for financial period assignment and year-end reporting.',
    `gl_account_code` STRING COMMENT 'The General Ledger (GL) account code to which the invoice amount is posted. Determines the expense or asset category for financial statement reporting.',
    `gross_amount` DECIMAL(18,2) COMMENT 'The total invoice amount before any deductions, including all line items, taxes, and surcharges. This is the headline invoice value from the vendor.',
    `invoice_date` DATE COMMENT 'The date the vendor issued the invoice. This is the document date from the vendors perspective and is used for aging and payment term calculations.',
    `invoice_description` STRING COMMENT 'Free-text description or header text from the vendor invoice providing additional context about the invoice purpose or contents.',
    `invoice_number` STRING COMMENT 'The invoice number assigned by the vendor. This is the externally-known identifier for the invoice document and must be unique per vendor.',
    `invoice_status` STRING COMMENT 'Current lifecycle status of the invoice in the AP workflow. Tracks progression from receipt through approval, posting, and payment. [ENUM-REF-CANDIDATE: draft|pending_approval|approved|blocked|posted|paid|cancelled|disputed — 8 candidates stripped; promote to reference product]',
    `invoice_type` STRING COMMENT 'The type of invoice document (e.g., standard invoice, credit memo for returns, debit memo for additional charges, prepayment invoice).. Valid values are `standard|credit_memo|debit_memo|prepayment|recurring|adjustment`',
    `modified_by_user` STRING COMMENT 'The username or user ID of the person who last modified this invoice record. Used for audit trail and change management.',
    `modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this invoice record was last modified. Used for audit trail and change tracking.',
    `net_amount` DECIMAL(18,2) COMMENT 'The net payable amount after applying taxes, discounts, and adjustments. This is the amount that will be paid to the vendor and drives Accounts Payable (AP) and cash outflow.',
    `payment_block_flag` BOOLEAN COMMENT 'Boolean indicator (True/False) showing whether payment is currently blocked. When True, the invoice cannot be paid until the block is released.',
    `payment_block_reason` STRING COMMENT 'The reason code or description explaining why payment is blocked (e.g., price variance, quantity mismatch, missing goods receipt, quality issue, duplicate invoice).',
    `payment_method` STRING COMMENT 'The payment method or instrument used to pay this invoice (e.g., ACH, wire transfer, check, credit card, EFT, virtual card).. Valid values are `ach|wire_transfer|check|credit_card|eft|virtual_card`',
    `payment_status` STRING COMMENT 'Current payment status indicating whether the invoice has been paid, is awaiting payment, or is overdue. Used for cash management and vendor relationship management.. Valid values are `unpaid|partially_paid|paid|overdue`',
    `payment_terms_code` STRING COMMENT 'The payment terms code defining the payment schedule and discount conditions (e.g., Net 30, 2/10 Net 30). References standard payment terms master data.',
    `posting_date` DATE COMMENT 'The date the invoice was posted into the financial system. This is the accounting date used for General Ledger (GL) period assignment and financial reporting.',
    `receipt_date` DATE COMMENT 'The date the invoice document was received by Waste Management. Used for tracking invoice processing cycle time and compliance with payment terms.',
    `reference_document_number` STRING COMMENT 'External reference number from the vendor or related document (e.g., delivery note number, contract number, service entry sheet number) for cross-reference and audit trail.',
    `tax_amount` DECIMAL(18,2) COMMENT 'The total tax amount included in the invoice, covering sales tax, VAT, GST, or other applicable taxes. Used for tax reporting and reconciliation.',
    `three_way_match_status` STRING COMMENT 'Status of the three-way match validation comparing Purchase Order (PO), Goods Receipt (GR), and Invoice. Indicates whether quantities, prices, and terms align across all three documents.. Valid values are `matched|po_mismatch|gr_mismatch|price_variance|quantity_variance|not_applicable`',
    `withholding_tax_amount` DECIMAL(18,2) COMMENT 'The amount of withholding tax deducted from the invoice payment as required by tax regulations. Reduces the net payment to the vendor.',
    CONSTRAINT pk_vendor_invoice PRIMARY KEY(`vendor_invoice_id`)
) COMMENT 'Vendor-submitted invoice received for payment against a purchase order or service entry sheet. Captures invoice number (vendor-assigned), invoice date, posting date, gross amount, tax amount, net amount, currency, payment terms, due date, three-way match status (PO-GR-Invoice), blocking reason, and payment block flag. Central AP document driving cash outflow and COGS recognition. Sourced from SAP AP/MM Invoice Verification (RBKP/RSEG).';

CREATE OR REPLACE TABLE `waste_management_ecm`.`procurement`.`vendor_invoice_line` (
    `vendor_invoice_line_id` BIGINT COMMENT 'Unique identifier for the vendor invoice line item. Primary key for this entity.',
    `fixed_asset_id` BIGINT COMMENT 'Reference to fixed asset master when this invoice line represents a capital expenditure. Triggers asset capitalization and depreciation.',
    `goods_receipt_id` BIGINT COMMENT 'Reference to the goods receipt document confirming physical receipt of materials. Part of three-way match process.',
    `material_id` BIGINT COMMENT 'Reference to the material master record for goods-based invoice lines. Identifies the specific part, supply, or equipment being invoiced.',
    `offering_id` BIGINT COMMENT 'Reference to the service master record for service-based invoice lines. Identifies professional services, maintenance, or third-party disposal services.',
    `parts_catalog_id` BIGINT COMMENT 'Foreign key linking to maintenance.parts_catalog. Business justification: Invoice line items for maintenance parts reference specific catalog parts. Enables three-way match at part level (PO-GR-Invoice), warranty claim validation against invoiced parts, and cost variance an',
    `po_line_id` BIGINT COMMENT 'Foreign key linking to procurement.po_line. Business justification: Invoice lines map to specific PO lines for three-way match (PO-GR-Invoice). Currently has po_line_number (INT) but needs FK to po_line.po_line_id. Remove po_line_number as it becomes redundant.',
    `purchase_order_id` BIGINT COMMENT 'Reference to the purchase order against which this invoice line is matched. Used for three-way match validation (PO, GR, Invoice).',
    `service_entry_sheet_id` BIGINT COMMENT 'Reference to the service entry sheet confirming completion of services. Used for service-based invoice verification.',
    `vendor_invoice_id` BIGINT COMMENT 'Reference to the parent vendor invoice header. Links this line item to the overall invoice document.',
    `baseline_date` DATE COMMENT 'Reference date for payment terms calculation. Typically the invoice date or goods receipt date, used to determine payment due date.',
    `blocked_for_payment` BOOLEAN COMMENT 'Indicates whether this invoice line is blocked from payment due to matching errors, quality issues, or pending approval. True if blocked, false if cleared for payment.',
    `cost_center_code` STRING COMMENT 'Cost center to which this expense is allocated. Enables operational cost tracking by department, facility, or business unit for EBITDA reporting.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this invoice line record was first created in the system. Used for audit trail and data lineage tracking.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts on this line (e.g., USD, CAD, MXN).. Valid values are `^[A-Z]{3}$`',
    `delivery_date` DATE COMMENT 'Date when the material was delivered or service was completed. Used for accrual accounting and period-end cutoff validation.',
    `discount_amount` DECIMAL(18,2) COMMENT 'Discount amount applied to this invoice line. May represent volume discounts, early payment discounts, or negotiated rebates.',
    `discount_percentage` DECIMAL(18,2) COMMENT 'Discount percentage applied to the line net amount. Used for calculating discount amount when percentage-based discounts are applied.',
    `gl_account_code` STRING COMMENT 'General ledger account code to which this invoice line expense is posted. Determines financial statement classification and COGS categorization.',
    `invoiced_quantity` DECIMAL(18,2) COMMENT 'Quantity of material or service units being invoiced on this line. Compared against PO quantity and GR quantity for variance analysis.',
    `line_description` STRING COMMENT 'Detailed text description of the material or service being invoiced. May include vendor-specific item descriptions, specifications, or service details.',
    `line_gross_amount` DECIMAL(18,2) COMMENT 'Total gross amount for this invoice line including taxes and surcharges. Sum of line net amount and line tax amount.',
    `line_net_amount` DECIMAL(18,2) COMMENT 'Net amount for this invoice line before taxes and surcharges. Calculated as invoiced quantity multiplied by unit price, minus any line-level discounts.',
    `line_notes` STRING COMMENT 'Free-text notes or comments specific to this invoice line. May include variance explanations, special handling instructions, or dispute details.',
    `line_number` STRING COMMENT 'Sequential line number within the invoice. Determines the ordering of line items on the invoice document.',
    `line_tax_amount` DECIMAL(18,2) COMMENT 'Total tax amount applicable to this invoice line. Calculated based on tax code and jurisdiction.',
    `manufacturer_part_number` STRING COMMENT 'Original equipment manufacturer (OEM) part number. Critical for fleet parts procurement and warranty tracking.',
    `match_status` STRING COMMENT 'Status of the three-way match process comparing invoice line to PO and GR. Indicates whether the line passed validation or has discrepancies requiring resolution.. Valid values are `matched|unmatched|partially_matched|variance_detected|blocked`',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this invoice line record was last modified. Tracks changes to match status, amounts, or other attributes during invoice verification process.',
    `payment_block_reason` STRING COMMENT 'Reason code or description explaining why this line is blocked for payment. Examples include price variance, quantity variance, quality hold, or pending approval.',
    `payment_terms` STRING COMMENT 'Payment terms applicable to this invoice line. May differ from header-level terms for specific line items with special arrangements.',
    `plant_code` STRING COMMENT 'Plant or facility code where the material was received or service was performed. Links spend to operational locations (landfills, MRFs, transfer stations, fleet yards).',
    `posting_date` DATE COMMENT 'Date when this invoice line was posted to the general ledger. Determines the fiscal period for financial reporting and COGS recognition.',
    `price_variance` DECIMAL(18,2) COMMENT 'Difference between invoiced unit price and PO unit price. Used for spend variance analysis and vendor performance evaluation.',
    `profit_center_code` STRING COMMENT 'Profit center for internal management reporting. Enables P&L analysis by business segment or geographic region.',
    `quantity_variance` DECIMAL(18,2) COMMENT 'Difference between invoiced quantity and received quantity (from GR). Positive values indicate over-invoicing; negative values indicate under-invoicing.',
    `storage_location` STRING COMMENT 'Storage location within the plant where material was received. Enables inventory tracking at sub-facility level (e.g., parts warehouse, fuel depot, PPE storage).',
    `tax_code` STRING COMMENT 'Tax code determining the tax rate and tax type applicable to this line. Drives tax calculation and GL posting.',
    `tax_jurisdiction` STRING COMMENT 'Geographic tax jurisdiction (state, county, city) where the tax is assessed. Critical for multi-state operations and compliance reporting.',
    `unit_of_measure` STRING COMMENT 'Unit of measure for the invoiced quantity (e.g., EA for each, GAL for gallons, TON for tons, HR for hours). Must match PO unit of measure.',
    `unit_price` DECIMAL(18,2) COMMENT 'Price per unit of measure as stated on the vendor invoice. Compared against PO price for variance detection.',
    `vendor_material_number` STRING COMMENT 'Vendors own part number or service code for the invoiced item. Used for cross-reference and vendor catalog matching.',
    `wbs_element` STRING COMMENT 'Work breakdown structure element for project-related expenses. Links invoice line to capital projects or specific initiatives.',
    CONSTRAINT pk_vendor_invoice_line PRIMARY KEY(`vendor_invoice_line_id`)
) COMMENT 'Individual line items on a vendor invoice, each mapped to a specific PO line or service entry sheet line. Captures line number, material or service description, invoiced quantity, unit price, line amount, tax code, GL account, cost center, WBS element, and match status against the corresponding PO/GR line. Enables granular spend allocation to COGS categories, cost centers, and operational facilities for EBITDA reporting.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`procurement`.`ap_payment` (
    `ap_payment_id` BIGINT COMMENT 'Unique identifier for the accounts payable payment transaction. Primary key.',
    `bank_account_id` BIGINT COMMENT 'Reference to the company bank account from which funds were disbursed for this payment.',
    `employee_id` BIGINT COMMENT 'Reference to the user who approved this payment for processing. Links to employee or user master data.',
    `run_id` BIGINT COMMENT 'Identifier for the batch payment run that generated this payment. Multiple payments may share the same payment run ID.. Valid values are `^PR[0-9]{8}$`',
    `vendor_id` BIGINT COMMENT 'Reference to the vendor receiving this payment. Links to vendor master data.',
    `vendor_invoice_id` BIGINT COMMENT 'Reference to the vendor invoice being paid by this payment transaction.',
    `approval_date` DATE COMMENT 'The date on which the payment was approved for processing. Format: yyyy-MM-dd.',
    `baseline_date` DATE COMMENT 'The date from which payment terms are calculated. Typically the invoice date or goods receipt date. Format: yyyy-MM-dd.',
    `check_number` STRING COMMENT 'The physical or virtual check number if payment method is check. Null for electronic payment methods.. Valid values are `^CHK[0-9]{8}$`',
    `clearing_document_number` STRING COMMENT 'The financial document number that cleared the open vendor invoice items. Links payment to invoice clearing in the general ledger.. Valid values are `^[A-Z0-9]{10}$`',
    `company_code` STRING COMMENT 'The organizational unit (legal entity) within Waste Management that made the payment. Four-character SAP company code.. Valid values are `^[A-Z0-9]{4}$`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this payment record was first created in the system. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the payment transaction (e.g., USD, CAD, MXN).. Valid values are `^[A-Z]{3}$`',
    `discount_amount` DECIMAL(18,2) COMMENT 'The early payment discount or cash discount amount taken by the company on this payment, reducing the total disbursement.',
    `due_date` DATE COMMENT 'The date by which the payment was contractually due based on payment terms. Used for aging and working capital analysis. Format: yyyy-MM-dd.',
    `fiscal_period` STRING COMMENT 'The fiscal period (month) within the fiscal year in which the payment was posted. Typically 1-12.',
    `fiscal_year` STRING COMMENT 'The fiscal year in which the payment was posted for financial reporting purposes.',
    `gl_posting_date` DATE COMMENT 'The accounting date on which the payment transaction was posted to the general ledger. May differ from payment_date. Format: yyyy-MM-dd.',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when this payment record was last modified or updated. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `net_payment_amount` DECIMAL(18,2) COMMENT 'The final net amount disbursed after applying discounts and adjustments. Equals payment_amount minus discount_amount.',
    `payment_amount` DECIMAL(18,2) COMMENT 'The gross amount disbursed to the vendor in this payment transaction, before any adjustments or discounts.',
    `payment_batch_number` STRING COMMENT 'Identifier for the payment batch file sent to the bank or payment processor. Used for reconciliation and error tracking.. Valid values are `^BATCH[0-9]{10}$`',
    `payment_block_code` STRING COMMENT 'Single-character code indicating if payment was blocked for review or approval. Blank if no block applied.. Valid values are `^[A-Z]{1}$`',
    `payment_date` DATE COMMENT 'The date on which the payment was executed and funds were disbursed to the vendor. Format: yyyy-MM-dd.',
    `payment_document_number` STRING COMMENT 'The externally-known payment document number assigned by the financial system. Corresponds to SAP FI payment document (BELNR in BKPF).. Valid values are `^[A-Z0-9]{10}$`',
    `payment_memo` STRING COMMENT 'Free-text memo or notes field providing additional context about the payment for internal reference.',
    `payment_method` STRING COMMENT 'The payment instrument or mechanism used to disburse funds. ACH = Automated Clearing House, EFT = Electronic Funds Transfer.. Valid values are `ACH|check|wire|virtual_card|EFT|cash`',
    `payment_processor` STRING COMMENT 'The name of the third-party payment processor or banking partner that executed the payment (e.g., JP Morgan, Bank of America, PayPal).',
    `payment_reference_number` STRING COMMENT 'External reference number or transaction ID provided by the bank or payment processor for tracking and reconciliation.',
    `payment_status` STRING COMMENT 'Current lifecycle status of the payment transaction. Tracks progression from initiation through clearing or failure.. Valid values are `pending|processed|cleared|failed|cancelled|reversed`',
    `payment_terms` STRING COMMENT 'The payment terms code that governed this payment (e.g., Net 30, 2/10 Net 30). Determines discount eligibility and due date.',
    `reversal_date` DATE COMMENT 'The date on which this payment was reversed. Null if not reversed. Format: yyyy-MM-dd.',
    `reversal_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether this payment has been reversed or cancelled. True if reversed, False otherwise.',
    `reversal_reason` STRING COMMENT 'Free-text explanation of why the payment was reversed (e.g., duplicate payment, incorrect amount, vendor request).',
    `vendor_bank_account_number` STRING COMMENT 'The vendors bank account number to which payment was sent. Confidential financial information.',
    `vendor_bank_routing_number` STRING COMMENT 'The ABA routing number for the vendors bank (US payments). Nine-digit code identifying the financial institution.. Valid values are `^[0-9]{9}$`',
    `withholding_tax_amount` DECIMAL(18,2) COMMENT 'The amount of withholding tax deducted from the payment as required by tax regulations. Reduces net payment to vendor.',
    CONSTRAINT pk_ap_payment PRIMARY KEY(`ap_payment_id`)
) COMMENT 'Records actual payment disbursements made to vendors against approved vendor invoices. Captures payment document number, payment date, payment method (ACH, check, wire, virtual card), bank account, payment amount, currency, discount taken, clearing document reference, and payment run ID. Tracks cash outflow for AP aging, working capital management, and GL reconciliation. Sourced from SAP FI payment transactions (BKPF/BSEG).';

CREATE OR REPLACE TABLE `waste_management_ecm`.`procurement`.`sourcing_contract` (
    `sourcing_contract_id` BIGINT COMMENT 'Unique identifier for the sourcing contract. Primary key.',
    `material_group_id` BIGINT COMMENT 'Foreign key linking to procurement.material_group. Business justification: Sourcing contracts cover commodity categories (material groups). Currently has commodity_category (STRING); need FK to material_group.material_group_id. Remove commodity_category as it can be retrieve',
    `employee_id` BIGINT COMMENT 'Identifier of the Waste Management employee responsible for managing this sourcing contract, typically a procurement specialist or category manager.',
    `primary_sourcing_approved_by_employee_id` BIGINT COMMENT 'Identifier of the employee who provided final approval for this sourcing contract, typically a procurement director or authorized signatory.',
    `safety_program_id` BIGINT COMMENT 'Foreign key linking to safety.safety_program. Business justification: Master service agreements for safety services (training providers, PPE suppliers, medical surveillance, IH testing) must link to safety programs they support for contract compliance verification, prog',
    `offering_id` BIGINT COMMENT 'Foreign key linking to service.offering. Business justification: Sourcing contracts may cover recurring service purchases (disposal, recycling processing, transportation). Real business process: contracted service procurement, rate management, and vendor performanc',
    `vendor_id` BIGINT COMMENT 'Identifier of the supplier or vendor party to this sourcing contract. References the vendor master record.',
    `approval_date` DATE COMMENT 'Date when the sourcing contract received final approval and authorization to proceed. Null if still pending approval.',
    `auto_renewal_flag` BOOLEAN COMMENT 'Indicates whether the contract automatically renews at the end of its term. True if auto-renewal is enabled, False if manual renewal or termination is required.',
    `company_code` STRING COMMENT 'SAP company code representing the legal entity entering into this sourcing contract. Used for financial reporting and General Ledger (GL) posting.. Valid values are `^[A-Z0-9]{4}$`',
    `compliance_certifications_required` STRING COMMENT 'List of regulatory certifications and compliance documentation required from the vendor (e.g., ISO 14001, OSHA compliance, DOT certification, EPA permits). Pipe-separated if multiple.',
    `confidentiality_flag` BOOLEAN COMMENT 'Indicates whether this contract contains confidential or proprietary terms that require restricted access. True if confidential, False if standard business terms.',
    `contract_document_reference` STRING COMMENT 'Reference identifier or file path to the signed contract document stored in the document management system.',
    `contract_number` STRING COMMENT 'Business identifier for the sourcing contract, externally visible and used in procurement documents and vendor communications.. Valid values are `^[A-Z0-9]{10,20}$`',
    `contract_status` STRING COMMENT 'Current lifecycle status of the sourcing contract. Draft indicates initial creation, Pending Approval awaits authorization, Active is in force, Suspended is temporarily halted, Expired has passed validity period, Terminated is ended early, Closed is completed and archived. [ENUM-REF-CANDIDATE: draft|pending_approval|active|suspended|expired|terminated|closed — 7 candidates stripped; promote to reference product]',
    `contract_type` STRING COMMENT 'Classification of the sourcing contract structure. Blanket Purchase Agreement (BPA) for recurring purchases, Outline Agreement for long-term commitments, Quantity Contract for fixed volumes, Value Contract for fixed spend, Scheduling Agreement for delivery schedules, Framework Agreement for multi-supplier arrangements.. Valid values are `blanket_purchase_agreement|outline_agreement|quantity_contract|value_contract|scheduling_agreement|framework_agreement`',
    `contract_value_total` DECIMAL(18,2) COMMENT 'Total monetary value committed under this sourcing contract over its full term. Used for spend tracking and EBITDA reporting.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this sourcing contract record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary values in this contract (e.g., USD, CAD, EUR).. Valid values are `^[A-Z]{3}$`',
    `delivery_terms` STRING COMMENT 'Specific delivery requirements and conditions negotiated with the vendor, including lead times, delivery windows, and special handling instructions.',
    `dispute_resolution_method` STRING COMMENT 'Agreed method for resolving disputes arising from this contract. Negotiation for direct discussion, Mediation for facilitated resolution, Arbitration for binding third-party decision, Litigation for court proceedings.. Valid values are `negotiation|mediation|arbitration|litigation`',
    `effective_end_date` DATE COMMENT 'Date when the sourcing contract expires or terminates. Null for open-ended contracts. No purchases can be made after this date unless renewed.',
    `effective_start_date` DATE COMMENT 'Date when the sourcing contract becomes active and binding. Purchases can be made against the contract from this date forward.',
    `governing_law_jurisdiction` STRING COMMENT 'Legal jurisdiction and governing law applicable to this contract (e.g., State of Texas, Province of Ontario). Determines which courts and laws apply in case of disputes.',
    `incoterms` STRING COMMENT 'International Commercial Terms defining the responsibilities of buyer and seller for shipping, insurance, and risk transfer. EXW (Ex Works), FCA (Free Carrier), CPT (Carriage Paid To), CIP (Carriage and Insurance Paid), DAP (Delivered at Place), DPU (Delivered at Place Unloaded), DDP (Delivered Duty Paid), FAS (Free Alongside Ship), FOB (Free on Board), CFR (Cost and Freight), CIF (Cost Insurance and Freight). [ENUM-REF-CANDIDATE: EXW|FCA|CPT|CIP|DAP|DPU|DDP|FAS|FOB|CFR|CIF — 11 candidates stripped; promote to reference product]',
    `insurance_requirements` STRING COMMENT 'Insurance coverage types and minimum limits required from the vendor (e.g., general liability, professional liability, workers compensation). Null if no insurance requirements.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this sourcing contract record was last updated or modified.',
    `maximum_quantity_commitment` DECIMAL(18,2) COMMENT 'Maximum quantity of goods or services that can be purchased under this contract. Null if no maximum limit exists.',
    `minimum_quantity_commitment` DECIMAL(18,2) COMMENT 'Minimum quantity of goods or services that Waste Management commits to purchase under this contract. Null if no minimum commitment exists.',
    `notes` STRING COMMENT 'Free-text field for additional comments, special instructions, or contextual information about this sourcing contract not captured in structured fields.',
    `payment_terms` STRING COMMENT 'Standard payment terms negotiated with the vendor. Net 30/45/60/90 indicates days until payment is due, Due on Receipt requires immediate payment, 2/10 Net 30 offers 2% discount if paid within 10 days otherwise net 30. [ENUM-REF-CANDIDATE: net_30|net_45|net_60|net_90|due_on_receipt|2_10_net_30|other — 7 candidates stripped; promote to reference product]',
    `penalty_provisions` STRING COMMENT 'Financial penalties or liquidated damages applicable for vendor non-performance, late delivery, quality failures, or other contract breaches.',
    `performance_metrics` STRING COMMENT 'Key Performance Indicators (KPIs) and Service Level Agreements (SLAs) defined for vendor performance measurement (e.g., on-time delivery rate, defect rate, response time).',
    `plant_code` STRING COMMENT 'Primary plant or facility code associated with this contract for goods receipt and inventory management. Null for service-only contracts.',
    `pricing_condition_type` STRING COMMENT 'Pricing structure applied to this contract. Fixed Price for constant unit cost, Variable Price for fluctuating rates, Cost Plus for cost recovery plus margin, Market Indexed for prices tied to commodity indices, Tiered Pricing for volume-based rates, Volume Discount for quantity-based reductions.. Valid values are `fixed_price|variable_price|cost_plus|market_indexed|tiered_pricing|volume_discount`',
    `purchasing_group` STRING COMMENT 'Buyer group or procurement team responsible for this contract within the purchasing organization. Used for workload distribution and reporting.',
    `purchasing_organization` STRING COMMENT 'Organizational unit within Waste Management responsible for procurement activities under this contract. Aligns with SAP purchasing organization structure.',
    `quality_requirements` STRING COMMENT 'Quality standards, specifications, and acceptance criteria that goods or services must meet under this contract. May reference industry standards or internal specifications.',
    `renewal_notice_days` STRING COMMENT 'Number of days prior to contract expiration that renewal or termination notice must be provided. Null if not applicable.',
    `sustainability_requirements` STRING COMMENT 'Environmental and sustainability commitments required from the vendor, including Greenhouse Gas (GHG) reduction targets, recycled content minimums, Carbon Dioxide Equivalent (CO2e) reporting, or Renewable Natural Gas (RNG) usage.',
    `termination_clause` STRING COMMENT 'Conditions and procedures under which either party may terminate the contract early, including notice periods, penalties, and termination for cause or convenience.',
    `unit_of_measure` STRING COMMENT 'Standard unit of measure for quantity commitments and pricing. EA for Each, TON for Tons, GAL for Gallons, LB for Pounds, KG for Kilograms, HR for Hours, DAY for Days, CASE for Cases, PALLET for Pallets, M3 for Cubic Meters, FT3 for Cubic Feet. [ENUM-REF-CANDIDATE: EA|TON|GAL|LB|KG|HR|DAY|CASE|PALLET|M3|FT3|other — 12 candidates stripped; promote to reference product]',
    CONSTRAINT pk_sourcing_contract PRIMARY KEY(`sourcing_contract_id`)
) COMMENT 'Procurement-side supplier contracts and framework agreements governing the terms under which Waste Management purchases goods and services from vendors. Includes blanket purchase agreements, outline agreements, quantity contracts, value contracts, and scheduling agreements for high-volume items (fuel, fleet parts, containers, disposal services). Captures contract number, vendor, contract type, commodity category, total contract value, minimum/maximum quantity commitments, pricing conditions, validity period, auto-renewal flag, and contract owner. Distinct from customer-facing service contracts owned by the contract domain. Sourced from SAP MM Contract (EKKO with BSART=MK/WK).';

CREATE OR REPLACE TABLE `waste_management_ecm`.`procurement`.`sourcing_contract_line` (
    `sourcing_contract_line_id` BIGINT COMMENT 'Unique identifier for the sourcing contract line item. Primary key.',
    `material_id` BIGINT COMMENT 'Foreign key linking to procurement.material. Business justification: Contract lines define specific materials with pricing and terms. Currently has material_number (STRING) and material_description; need FK to material.material_id. Remove material_number and material_d',
    `offering_id` BIGINT COMMENT 'Foreign key linking to service.offering. Business justification: Contract lines specify individual service offerings with pricing and terms. Real business process: line-item service procurement, rate schedules, and contract compliance. Essential for detailed servic',
    `sourcing_contract_id` BIGINT COMMENT 'Reference to the parent sourcing contract header. Links this line item to its master agreement.',
    `cost_center` STRING COMMENT 'Cost center to which expenses for this contract line are allocated. Enables departmental cost tracking and budget management.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this contract line item record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for pricing on this contract line (e.g., USD, CAD, MXN).. Valid values are `^[A-Z]{3}$`',
    `deletion_indicator` BOOLEAN COMMENT 'Flag indicating this contract line is marked for deletion. True if line is logically deleted but retained for audit history.',
    `gl_account_code` STRING COMMENT 'General ledger account code to which costs for this contract line will be posted. Supports cost control for COGS (Cost of Goods Sold) and EBITDA (Earnings Before Interest Taxes Depreciation and Amortization) reporting.',
    `incoterms` STRING COMMENT 'International Commercial Terms (Incoterms) defining delivery responsibilities and risk transfer (e.g., FOB, CIF, DDP). Applies to material procurement.',
    `incoterms_location` STRING COMMENT 'Named location associated with the Incoterms (e.g., port of shipment, destination facility). Clarifies delivery point.',
    `last_modified_by` STRING COMMENT 'User ID of the person who last modified this contract line item.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this contract line item record was last updated.',
    `lead_time_days` STRING COMMENT 'Standard delivery lead time in days from order placement to receipt. Used for procurement planning and inventory management.',
    `line_number` STRING COMMENT 'Sequential line item number within the sourcing contract. Determines ordering and display sequence.',
    `line_status` STRING COMMENT 'Current lifecycle status of the contract line item. Active lines are available for release; blocked or closed lines cannot be used.. Valid values are `active|inactive|blocked|expired|closed`',
    `line_type` STRING COMMENT 'Classification of the contract line item indicating whether it covers materials, services, equipment, fuel, personal protective equipment (PPE), or chemicals.. Valid values are `material|service|equipment|fuel|ppe|chemical`',
    `line_valid_from_date` DATE COMMENT 'Start date from which this contract line item becomes effective and can be used for procurement.',
    `line_valid_to_date` DATE COMMENT 'End date after which this contract line item expires and can no longer be used for procurement. Nullable for open-ended lines.',
    `manufacturer_part_number` STRING COMMENT 'Original equipment manufacturer (OEM) part number for the material. Critical for fleet parts and equipment procurement.',
    `maximum_order_quantity` DECIMAL(18,2) COMMENT 'Maximum quantity that can be ordered per release against this contract line. Enforces contract limits or vendor capacity constraints.',
    `minimum_order_quantity` DECIMAL(18,2) COMMENT 'Minimum quantity that must be ordered per release against this contract line. Enforces vendor minimum order requirements.',
    `plant_code` STRING COMMENT 'SAP plant or facility code where the material or service will be delivered or consumed. Links to landfill, MRF (Materials Recovery Facility), or fleet maintenance facility.',
    `price_scale_basis` STRING COMMENT 'Basis for price scaling: quantity-based tiers, value-based tiers, or none if flat pricing applies.. Valid values are `quantity|value|none`',
    `price_scale_indicator` BOOLEAN COMMENT 'Flag indicating whether this contract line uses tiered or volume-based pricing scales. True if price varies by quantity thresholds.',
    `purchasing_group` STRING COMMENT 'Purchasing group or buyer responsible for managing this contract line. Links to procurement team structure.',
    `purchasing_organization` STRING COMMENT 'Purchasing organization responsible for this contract line. Defines procurement authority and organizational scope.',
    `release_order_count` STRING COMMENT 'Total number of purchase orders (PO) or release orders created against this contract line. Tracks utilization frequency.',
    `released_quantity` DECIMAL(18,2) COMMENT 'Cumulative quantity released against this contract line through purchase orders (PO) or release orders. Tracks spend-against-contract compliance.',
    `remaining_quantity` DECIMAL(18,2) COMMENT 'Remaining quantity available for release under this contract line. Calculated as target quantity minus released quantity.',
    `storage_location` STRING COMMENT 'Storage location within the plant where materials will be received and stored. Applies to material line types.',
    `target_quantity` DECIMAL(18,2) COMMENT 'Total contracted quantity or volume commitment for this line item over the contract validity period. Used for contract utilization tracking.',
    `tax_code` STRING COMMENT 'Tax classification code for this contract line. Determines applicable sales tax, use tax, or VAT treatment.',
    `unit_of_measure` STRING COMMENT 'Unit of measure for quantities on this line (e.g., EA for each, GAL for gallons, TON for tons, HR for hours). Aligns with material master or service master UOM.',
    `unit_price` DECIMAL(18,2) COMMENT 'Base price per unit of measure for this contract line. May be subject to price scale conditions or tiered pricing.',
    `vendor_material_number` STRING COMMENT 'Vendors own part number or material identifier for the procured item. Used for cross-reference and ordering.',
    `wbs_element` STRING COMMENT 'Work breakdown structure element for project-related procurement. Links contract line to capital projects or specific initiatives.',
    `created_by` STRING COMMENT 'User ID of the person who created this contract line item in the system.',
    CONSTRAINT pk_sourcing_contract_line PRIMARY KEY(`sourcing_contract_line_id`)
) COMMENT 'Individual line items within a sourcing contract defining specific materials, services, pricing tiers, and quantity commitments. Captures line number, material or service, target quantity, released quantity, remaining quantity, unit price, price scale conditions, validity dates, and release order count. Enables contract utilization tracking and spend-against-contract compliance monitoring.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`procurement`.`rfq` (
    `rfq_id` BIGINT COMMENT 'Unique identifier for the request for quotation record. Primary key.',
    `vendor_id` BIGINT COMMENT 'Identifier of the vendor selected and awarded the business following RFQ evaluation. Null if RFQ is not yet awarded or was cancelled.',
    `employee_id` BIGINT COMMENT 'Identifier of the procurement professional responsible for issuing and managing this RFQ. Links to employee or user master data.',
    `material_group_id` BIGINT COMMENT 'Foreign key linking to procurement.material_group. Business justification: RFQs are issued for commodity categories (material groups). Currently has commodity_code (STRING); material_group also has commodity_code. Need FK to material_group.material_group_id for proper commod',
    `purchase_requisition_id` BIGINT COMMENT 'Foreign key linking to procurement.purchase_requisition. Business justification: RFQs are often initiated from approved purchase requisitions as part of the competitive sourcing process. This FK establishes traceability from PR → RFQ → PO, enabling complete procurement workflow tr',
    `offering_id` BIGINT COMMENT 'Foreign key linking to service.offering. Business justification: RFQs may solicit bids for service delivery (disposal, processing, transportation services). Real business process: competitive bidding for service procurement, vendor selection, and rate negotiation. ',
    `sourcing_event_id` BIGINT COMMENT 'Identifier linking this RFQ to a broader strategic sourcing event or category management initiative. Used for spend analytics and sourcing program tracking.',
    `award_date` DATE COMMENT 'Date when the RFQ was formally awarded to the selected vendor. Marks the transition from sourcing to contracting phase.',
    `award_justification` STRING COMMENT 'Business rationale and documentation for the vendor selection decision. Includes evaluation summary and compliance with procurement policies.',
    `buyer_name` STRING COMMENT 'Full name of the procurement buyer who created and is managing the RFQ process.',
    `commodity_description` STRING COMMENT 'Detailed textual description of the materials, equipment, fuel, containers, or services being requested. Includes specifications, quality requirements, and technical details.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the RFQ record was first created in the procurement system. Audit trail for record lifecycle.',
    `currency_code` STRING COMMENT 'Three-letter ISO currency code for all monetary values in the RFQ (e.g., USD, CAD, MXN).. Valid values are `^[A-Z]{3}$`',
    `delivery_address_line_1` STRING COMMENT 'Primary street address line for delivery of goods or performance of services. Organizational contact data classified as confidential.',
    `delivery_address_line_2` STRING COMMENT 'Secondary address line for delivery location (suite, building, department). Organizational contact data classified as confidential.',
    `delivery_city` STRING COMMENT 'City name for the delivery address. Organizational contact data classified as confidential.',
    `delivery_country_code` STRING COMMENT 'Three-letter ISO country code for the delivery address (e.g., USA, CAN, MEX).. Valid values are `^[A-Z]{3}$`',
    `delivery_postal_code` STRING COMMENT 'Postal or ZIP code for the delivery address. Organizational contact data classified as confidential.',
    `delivery_state_province` STRING COMMENT 'State or province code for the delivery address. Organizational contact data classified as confidential.',
    `estimated_budget_amount` DECIMAL(18,2) COMMENT 'Internal budget estimate or target price for the procurement. Confidential business data not shared with vendors. Used for cost control and EBITDA planning.',
    `evaluation_criteria` STRING COMMENT 'Documented criteria and weighting factors used to evaluate and compare vendor quotations. May include price, quality, delivery time, vendor performance history, sustainability, and compliance factors.',
    `incoterms_code` STRING COMMENT 'Standard trade terms defining responsibilities for shipping, insurance, and risk transfer (e.g., FOB, CIF, DDP). Applicable for equipment and material purchases.',
    `issue_date` DATE COMMENT 'Date when the RFQ was formally issued and distributed to prospective vendors. Marks the start of the vendor response period.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when the RFQ record was last updated. Tracks changes throughout the sourcing lifecycle.',
    `minimum_qualification_requirements` STRING COMMENT 'Mandatory qualifications vendors must meet to be considered, such as certifications, insurance coverage, safety records, or regulatory compliance (e.g., RCRA, DOT, OSHA).',
    `minority_owned_preference_flag` BOOLEAN COMMENT 'Indicates whether this RFQ includes preference or set-aside provisions for minority-owned businesses. Supports supplier diversity goals.',
    `notes` STRING COMMENT 'Free-form text field for additional instructions, clarifications, or internal comments related to the RFQ process.',
    `number_of_responses_received` STRING COMMENT 'Count of vendor quotations received by the submission deadline. Indicates market interest and competitive intensity.',
    `number_of_vendors_invited` STRING COMMENT 'Count of vendors to whom the RFQ was issued. Used to measure competitive sourcing effectiveness.',
    `payment_terms_code` STRING COMMENT 'Standard payment terms code requested from vendors (e.g., Net 30, Net 60, 2/10 Net 30). Impacts cash flow and accounts payable (AP) management.',
    `plant_code` STRING COMMENT 'Code identifying the facility, landfill, MRF, or operational location where the goods or services will be delivered or consumed.',
    `purchasing_group` STRING COMMENT 'Team or category group within the purchasing organization responsible for this commodity or service category. Used for workload distribution and specialization.',
    `purchasing_organization` STRING COMMENT 'Organizational unit responsible for the procurement activity. Typically represents a business division, region, or legal entity.',
    `quantity_requested` DECIMAL(18,2) COMMENT 'Total quantity of goods or volume of services requested in the RFQ. Used for vendor pricing and capacity evaluation.',
    `required_delivery_date` DATE COMMENT 'Target date by which the goods or services must be delivered to meet operational needs. Critical for vendor evaluation and lead time assessment.',
    `rfq_number` STRING COMMENT 'Business document number assigned to the RFQ in the procurement system. Externally visible identifier used for vendor communication and tracking.',
    `rfq_status` STRING COMMENT 'Current lifecycle status of the RFQ. Draft indicates preparation phase, issued means sent to vendors, open indicates awaiting responses, closed means submission deadline passed, awarded means vendor selected, cancelled means RFQ withdrawn.. Valid values are `draft|issued|open|closed|awarded|cancelled`',
    `rfq_type` STRING COMMENT 'Classification of the RFQ based on procurement strategy and urgency. Standard for routine sourcing, blanket for framework agreements, spot for one-time purchases, emergency for urgent needs, strategic for high-value or high-risk categories.. Valid values are `standard|blanket|spot|emergency|strategic`',
    `small_business_preference_flag` BOOLEAN COMMENT 'Indicates whether this RFQ includes preference or set-aside provisions for small businesses. Supports supplier diversity and local sourcing goals.',
    `submission_deadline_timestamp` TIMESTAMP COMMENT 'Date and time by which vendors must submit their quotations. After this timestamp, the RFQ is typically closed to new submissions.',
    `sustainability_requirements` STRING COMMENT 'Environmental and sustainability criteria vendors must meet, such as greenhouse gas (GHG) emissions reporting, renewable natural gas (RNG) availability, recycled content, or ISO 14001 certification.',
    `unit_of_measure` STRING COMMENT 'Standard unit in which the requested quantity is expressed. Examples: EA (each), TON (tons), GAL (gallons), HR (hours), CY (cubic yards).',
    CONSTRAINT pk_rfq PRIMARY KEY(`rfq_id`)
) COMMENT 'Request for Quotation issued to prospective vendors during the competitive sourcing process for materials, equipment, fuel, containers, or services. Captures RFQ number, commodity description, quantity, required delivery date, evaluation criteria, submission deadline, issuing buyer, and status (draft, issued, closed, awarded). Supports strategic sourcing events for high-value or high-risk spend categories. Sourced from SAP MM RFQ (EKKO with BSART=AN).';

CREATE OR REPLACE TABLE `waste_management_ecm`.`procurement`.`vendor_quote` (
    `vendor_quote_id` BIGINT COMMENT 'Unique identifier for the vendor quote record. Primary key.',
    `material_id` BIGINT COMMENT 'Reference to the material or service being quoted. Links to material master for fleet parts, fuel, PPE, containers, chemicals, equipment, or facility supplies.',
    `rfq_id` BIGINT COMMENT 'Reference to the RFQ document that this quote responds to.',
    `vendor_contact_id` BIGINT COMMENT 'Foreign key linking to procurement.vendor_contact. Business justification: Vendor quotes are submitted by specific vendor contact persons. Currently has vendor_contact_name, vendor_contact_email, vendor_contact_phone (STRING attributes); need FK to vendor_contact.vendor_cont',
    `vendor_id` BIGINT COMMENT 'Reference to the vendor who submitted this quote.',
    `award_decision_date` DATE COMMENT 'Date when the award decision was made and the quote was accepted or rejected.',
    `award_decision_flag` BOOLEAN COMMENT 'Indicates whether this quote was selected and awarded a purchase order. True if awarded, false otherwise.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the vendor quote record was first created in the system. Audit trail for record creation.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the quoted price (e.g., USD, CAD, EUR).. Valid values are `^[A-Z]{3}$`',
    `delivery_location` STRING COMMENT 'Destination location or facility where the vendor will deliver the quoted goods or services.',
    `discount_amount` DECIMAL(18,2) COMMENT 'Absolute discount amount offered by the vendor, reducing the total quote amount.',
    `discount_percentage` DECIMAL(18,2) COMMENT 'Percentage discount offered by the vendor off the list price or standard rate.',
    `evaluation_score` DECIMAL(18,2) COMMENT 'Composite evaluation score assigned to the quote based on weighted criteria (price, quality, delivery, vendor performance). Supports competitive bid comparison.',
    `freight_terms` STRING COMMENT 'Freight and shipping terms specified in the quote, indicating who pays for transportation costs.. Valid values are `prepaid|collect|third_party|fob_origin|fob_destination`',
    `incoterms_code` STRING COMMENT 'International Commercial Terms (Incoterms) defining delivery terms and responsibility transfer point (e.g., FOB, CIF, DDP). [ENUM-REF-CANDIDATE: EXW|FCA|CPT|CIP|DAP|DPU|DDP|FAS|FOB|CFR|CIF — 11 candidates stripped; promote to reference product]',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the vendor quote record was last updated. Audit trail for record changes.',
    `lead_time_days` STRING COMMENT 'Number of days from purchase order placement to delivery, as committed by the vendor in the quote.',
    `minimum_order_quantity` DECIMAL(18,2) COMMENT 'Minimum quantity that must be ordered to receive the quoted price, as specified by the vendor.',
    `net_quote_amount` DECIMAL(18,2) COMMENT 'Net total amount after applying discounts and adding taxes. Final amount for competitive bid comparison.',
    `payment_terms_code` STRING COMMENT 'Payment terms offered by the vendor in the quote (e.g., Net 30, Net 60, 2/10 Net 30). References standard payment term codes.. Valid values are `^[A-Z0-9]{2,10}$`',
    `quote_notes` STRING COMMENT 'Additional notes, comments, or special conditions provided by the vendor or procurement team regarding the quote.',
    `quote_number` STRING COMMENT 'Externally-known unique quote number assigned by the vendor or system. Business identifier for the quotation.. Valid values are `^[A-Z0-9]{10,20}$`',
    `quote_ranking` STRING COMMENT 'Comparative ranking of this quote among all quotes received for the same RFQ, based on price, lead time, and technical compliance. Used for award decision.',
    `quote_status` STRING COMMENT 'Current lifecycle status of the vendor quote in the procurement workflow. [ENUM-REF-CANDIDATE: draft|submitted|under_review|accepted|rejected|expired|withdrawn — 7 candidates stripped; promote to reference product]',
    `quote_submission_date` DATE COMMENT 'Date when the vendor submitted the quote in response to the RFQ.',
    `quote_valid_from_date` DATE COMMENT 'Start date of the quote validity period. The quoted price is effective from this date.',
    `quote_valid_to_date` DATE COMMENT 'End date of the quote validity period. The quoted price expires after this date.',
    `quoted_quantity` DECIMAL(18,2) COMMENT 'Quantity of material or service that the vendor is offering to supply at the quoted price.',
    `rejection_reason` STRING COMMENT 'Reason for rejecting the quote, if applicable. Supports audit trail and vendor feedback for future RFQs.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Estimated tax amount applicable to the quoted goods or services, based on jurisdiction and tax rules.',
    `technical_compliance_flag` BOOLEAN COMMENT 'Indicates whether the quoted material or service meets the technical specifications and requirements defined in the RFQ.',
    `technical_compliance_notes` STRING COMMENT 'Detailed notes on technical compliance, deviations, or exceptions to RFQ specifications. Supports award decision documentation.',
    `total_quote_amount` DECIMAL(18,2) COMMENT 'Total amount for the quoted quantity (unit price multiplied by quantity). Gross quote value before taxes and adjustments.',
    `unit_of_measure` STRING COMMENT 'Unit of measure for the quoted quantity (e.g., each, ton, gallon, pound, kilogram, liter, cubic meter, hour, day). [ENUM-REF-CANDIDATE: EA|TON|GAL|LB|KG|L|M3|FT3|HR|DAY — 10 candidates stripped; promote to reference product]',
    `unit_price` DECIMAL(18,2) COMMENT 'Price per unit quoted by the vendor. Used for competitive bid comparison and price benchmarking.',
    `warranty_period_months` STRING COMMENT 'Duration of the warranty period in months, as offered by the vendor in the quote.',
    `warranty_terms` STRING COMMENT 'Warranty terms and conditions offered by the vendor for the quoted material or service.',
    CONSTRAINT pk_vendor_quote PRIMARY KEY(`vendor_quote_id`)
) COMMENT 'Vendor-submitted price quotation in response to an RFQ. Captures quote number, vendor, RFQ reference, quoted price per unit, quantity offered, lead time, validity period, payment terms offered, delivery terms, and technical compliance notes. Enables competitive bid comparison, price benchmarking, and award decision documentation. Sourced from SAP MM Quotation (EKKO with BSART=AN vendor response).';

CREATE OR REPLACE TABLE `waste_management_ecm`.`procurement`.`info_record` (
    `info_record_id` BIGINT COMMENT 'Unique identifier for the purchasing info record. Primary key.',
    `material_id` BIGINT COMMENT 'Reference to the material or service for which this purchasing info record is established.',
    `sourcing_contract_id` BIGINT COMMENT 'Foreign key linking to procurement.sourcing_contract. Business justification: Purchasing info records are often created from sourcing contract terms, establishing the operational purchasing conditions (price, lead time, MOQ) agreed in the contract. This FK provides traceability',
    `vendor_id` BIGINT COMMENT 'Reference to the vendor (supplier) for whom this purchasing info record is established.',
    `created_by_user` STRING COMMENT 'User ID or employee identifier of the person who created this purchasing info record in the system.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this purchasing info record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the standard price (e.g., USD, CAD, MXN).. Valid values are `^[A-Z]{3}$`',
    `deletion_flag` BOOLEAN COMMENT 'Indicates whether this info record is marked for deletion and should not be used for new purchase orders.',
    `gr_processing_time_days` STRING COMMENT 'Number of days required for internal goods receipt processing after delivery. Added to planned delivery time for total lead time.',
    `incoterms` STRING COMMENT 'International Commercial Terms defining the responsibilities of buyer and seller for delivery, insurance, and risk transfer (e.g., FOB, CIF, EXW).',
    `incoterms_location` STRING COMMENT 'The specific location or point referenced in the Incoterms (e.g., port name, facility address).',
    `info_record_category` STRING COMMENT 'Category of the purchasing info record indicating the procurement type (standard purchase, subcontracting, consignment, pipeline).. Valid values are `standard|subcontracting|consignment|pipeline`',
    `info_record_number` STRING COMMENT 'Business identifier for the purchasing info record, typically system-generated or manually assigned.',
    `info_record_status` STRING COMMENT 'Current lifecycle status of the purchasing info record indicating whether it is available for use in purchase order creation.. Valid values are `active|inactive|blocked|pending_approval`',
    `last_modified_by_user` STRING COMMENT 'User ID or employee identifier of the person who last modified this purchasing info record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this purchasing info record was last modified in the system.',
    `last_purchase_order_date` DATE COMMENT 'The date of the most recent purchase order created using this info record.',
    `last_purchase_order_number` STRING COMMENT 'The most recent purchase order number created using this info record, used for audit and reference purposes.',
    `manufacturer_part_number` STRING COMMENT 'The original equipment manufacturer (OEM) part number for the material, distinct from the vendor part number.',
    `minimum_order_quantity` DECIMAL(18,2) COMMENT 'The minimum quantity that must be ordered from this vendor for this material. Used to enforce vendor MOQ requirements in PO creation.',
    `net_price_flag` BOOLEAN COMMENT 'Indicates whether the standard price is a net price (no further discounts apply) or a gross price (subject to discounts and conditions).',
    `order_unit` STRING COMMENT 'Unit of measure in which the material is ordered from the vendor (e.g., EA, GAL, TON, LB).',
    `overdelivery_tolerance_percent` DECIMAL(18,2) COMMENT 'Percentage by which the vendor is allowed to overdeliver against the purchase order quantity without triggering an exception.',
    `planned_delivery_time_days` STRING COMMENT 'The number of calendar days from purchase order placement to expected delivery at the receiving location. Used for MRP and scheduling.',
    `plant_code` STRING COMMENT 'Code identifying the plant or facility for which this info record applies. May be null for organization-level records.',
    `price_date_category` STRING COMMENT 'Indicates how the price is determined: fixed price, variable price based on market conditions, or contract-based pricing.. Valid values are `fixed|variable|contract_based`',
    `price_unit` STRING COMMENT 'The quantity unit to which the standard price applies (e.g., price per 1, per 10, per 100 units).',
    `purchase_order_acknowledgment_required_flag` BOOLEAN COMMENT 'Indicates whether the vendor is required to send a formal acknowledgment of the purchase order before processing can proceed.',
    `purchasing_group_code` STRING COMMENT 'Code identifying the purchasing group or buyer responsible for managing this vendor-material relationship.',
    `purchasing_organization_code` STRING COMMENT 'Code identifying the purchasing organization responsible for this vendor-material relationship. Aligns with SAP organizational structure.',
    `quotation_date` DATE COMMENT 'Date of the vendor quotation or RFQ response that established the pricing and terms in this info record.',
    `quotation_number` STRING COMMENT 'Reference number of the vendor quotation or request for quotation (RFQ) that led to the creation of this info record.',
    `regular_vendor_flag` BOOLEAN COMMENT 'Indicates whether this vendor is designated as the regular or preferred supplier for this material, used for automatic source determination.',
    `reminder_days` STRING COMMENT 'Number of days before delivery date when a reminder should be sent to the vendor if no goods receipt has been posted.',
    `standard_order_quantity` DECIMAL(18,2) COMMENT 'The standard or recommended order quantity for this vendor-material combination, often used for lot-sizing.',
    `standard_price` DECIMAL(18,2) COMMENT 'The agreed standard price per unit for the material or service from this vendor. This is the base price before any discounts or surcharges.',
    `tax_code` STRING COMMENT 'Tax code applicable to purchases of this material from this vendor, used for automatic tax calculation in purchase orders and invoices.',
    `underdelivery_tolerance_percent` DECIMAL(18,2) COMMENT 'Percentage by which the vendor is allowed to underdeliver against the purchase order quantity without triggering an exception.',
    `unlimited_overdelivery_flag` BOOLEAN COMMENT 'Indicates whether unlimited overdelivery is allowed for this vendor-material combination, overriding the overdelivery tolerance percentage.',
    `valid_from_date` DATE COMMENT 'The date from which this purchasing info record and its pricing conditions become effective.',
    `valid_to_date` DATE COMMENT 'The date until which this purchasing info record and its pricing conditions remain effective. Null indicates no expiration.',
    `vendor_material_number` STRING COMMENT 'The vendors own part number or material identifier for this item, used for cross-referencing in purchase orders and communications.',
    CONSTRAINT pk_info_record PRIMARY KEY(`info_record_id`)
) COMMENT 'Purchasing info record establishing the agreed purchasing conditions between Waste Management and a specific vendor for a specific material or service — the vendor-material price relationship master. Captures vendor, material, plant, purchasing organization, standard price, price unit, minimum order quantity, planned delivery time, tolerance levels, and last PO reference. Drives automatic price defaulting in PO creation and supports price variance analysis. Sourced from SAP MM Purchasing Info Record (EINA/EINE).';

CREATE OR REPLACE TABLE `waste_management_ecm`.`procurement`.`source_list` (
    `source_list_id` BIGINT COMMENT 'Unique identifier for the source list record. Primary key.',
    `info_record_id` BIGINT COMMENT 'Foreign key linking to procurement.info_record. Business justification: Source lists define approved vendors for materials and should reference the purchasing info record that contains the detailed purchasing conditions (price, lead time, terms). This FK links the approve',
    `material_id` BIGINT COMMENT 'Reference to the material for which this source list entry defines approved vendors. Links to the material master record.',
    `employee_id` BIGINT COMMENT 'The system user ID of the procurement employee who created this source list entry. Provides audit trail for record creation.',
    `source_employee_id` BIGINT COMMENT 'The system user ID of the procurement or vendor management employee who blocked this source list entry. Provides accountability for blocking decisions.',
    `source_last_modified_by_user_employee_id` BIGINT COMMENT 'The system user ID of the procurement employee who last modified this source list entry. Provides audit trail for record changes.',
    `sourcing_contract_id` BIGINT COMMENT 'Foreign key linking to procurement.sourcing_contract. Business justification: Source lists reference framework sourcing contracts for approved vendor-material combinations. Currently has agreement_number (STRING contract number); need FK to sourcing_contract.sourcing_contract_i',
    `vendor_id` BIGINT COMMENT 'Reference to the approved vendor authorized to supply the material to the specified plant. Links to the vendor master record.',
    `agreement_item_number` STRING COMMENT 'Five-digit line item number within the referenced purchasing agreement that corresponds to this source list entry. Identifies the specific material line in the contract.. Valid values are `^[0-9]{5}$`',
    `blocked_date` DATE COMMENT 'The date on which this source list entry was blocked from use. Used for audit trails and vendor performance tracking.',
    `blocked_flag` BOOLEAN COMMENT 'Flag indicating whether this source list entry is temporarily blocked from use. When true, prevents new purchase orders from being created with this vendor for this material, typically due to quality issues, contract disputes, or vendor performance problems.',
    `blocked_reason_code` STRING COMMENT 'Categorical code indicating the reason why this source list entry is blocked, if applicable. Provides context for procurement restrictions and vendor management actions.. Valid values are `quality_issue|contract_dispute|performance_failure|compliance_violation|financial_risk|other`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this source list record was first created in the system. Follows ISO 8601 format yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `critical_material_flag` BOOLEAN COMMENT 'Flag indicating whether this material is classified as business-critical at this plant, requiring special procurement controls. Examples include CNG fuel for fleet operations, hazmat disposal services, or OEM parts for critical equipment.',
    `environmental_compliance_certified_flag` BOOLEAN COMMENT 'Flag indicating whether this vendor holds required environmental certifications such as ISO 14001, EPA permits, or state environmental quality approvals relevant to the material being supplied.',
    `fixed_source_indicator` BOOLEAN COMMENT 'Flag indicating whether this vendor is the sole authorized source for the material at this plant. When true, enforces sole-source procurement policy and prevents PO creation with other vendors.',
    `hazmat_approved_flag` BOOLEAN COMMENT 'Flag indicating whether this vendor is approved and certified to supply hazardous materials per RCRA, DOT, and EPA requirements. Required for vendors supplying chemicals, hazardous waste disposal services, or regulated substances.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this source list record was last modified in the system. Follows ISO 8601 format yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `last_purchase_order_date` DATE COMMENT 'The date of the most recent purchase order created against this source list entry. Used for vendor activity tracking and source list maintenance.',
    `last_purchase_order_number` STRING COMMENT 'The ten-digit purchase order number of the most recent PO created against this source list entry. Provides audit trail and quick reference to recent procurement activity.. Valid values are `^[0-9]{10}$`',
    `minimum_order_quantity` DECIMAL(18,2) COMMENT 'The minimum quantity that must be ordered from this vendor for this material at this plant. Enforces vendor-specific MOQ requirements in purchase order creation.',
    `mrp_relevant_flag` BOOLEAN COMMENT 'Flag indicating whether this source list entry is considered during MRP runs for automatic purchase requisition generation. When true, MRP will propose this vendor for material replenishment.',
    `notes` STRING COMMENT 'Free-text field for procurement buyers and vendor managers to document special instructions, restrictions, quality requirements, or other relevant information about this source list entry.',
    `oem_authorized_flag` BOOLEAN COMMENT 'Flag indicating whether this vendor is an authorized OEM supplier or distributor for the material. Critical for fleet parts procurement to ensure warranty compliance and genuine parts sourcing.',
    `order_unit_of_measure` STRING COMMENT 'The unit of measure in which orders must be placed with this vendor for this material. Examples include EA (each), GAL (gallon), TON (ton), LB (pound), or CY (cubic yard).. Valid values are `^[A-Z]{2,3}$`',
    `plant_code` STRING COMMENT 'Four-character code identifying the plant or facility where this source list entry applies. Represents landfills, MRFs, transfer stations, maintenance depots, or administrative offices.. Valid values are `^[A-Z0-9]{4}$`',
    `preferred_vendor_rank` STRING COMMENT 'Numeric ranking indicating vendor preference order when multiple approved sources exist for the same material at the same plant. Lower numbers indicate higher preference. Used for automated vendor selection in procurement workflows.',
    `purchasing_organization_code` STRING COMMENT 'Four-character code identifying the purchasing organization responsible for procurement activities under this source list entry. Defines procurement authority and contract scope.. Valid values are `^[A-Z0-9]{4}$`',
    `quota_arrangement_number` STRING COMMENT 'Reference to the quota arrangement that governs order distribution when multiple vendors supply the same material. Defines percentage splits and allocation rules across approved sources.. Valid values are `^[0-9]{10}$`',
    `record_number` STRING COMMENT 'Ten-digit business identifier for the source list entry in the SAP system. Used for cross-system reconciliation and audit trails.. Valid values are `^[0-9]{10}$`',
    `source_determination_rule` STRING COMMENT 'Defines how the system should select this vendor during purchase requisition processing. Automatic allows system-driven vendor selection, manual requires buyer intervention, and quota arrangement distributes orders across multiple vendors per defined percentages.. Valid values are `automatic|manual|quota_arrangement`',
    `standard_delivery_lead_time_days` STRING COMMENT 'The expected number of calendar days from purchase order placement to material delivery for this vendor-material-plant combination. Used for MRP planning and delivery date calculation.',
    `validity_end_date` DATE COMMENT 'The date on which this source list entry expires. Vendor authorization to supply the material ends on this date. Null indicates indefinite validity.',
    `validity_start_date` DATE COMMENT 'The date from which this source list entry becomes effective. Vendor is authorized to supply the material starting on this date.',
    `vendor_material_number` STRING COMMENT 'The vendors own part number or catalog number for this material. Used for cross-referencing in purchase orders, invoices, and vendor communications.',
    CONSTRAINT pk_source_list PRIMARY KEY(`source_list_id`)
) COMMENT 'Approved source list defining which vendors are authorized to supply specific materials to specific plants during defined validity periods. Captures material, plant, vendor, purchasing organization, validity start/end dates, fixed source indicator, MRP relevance flag, and blocked status. Enforces preferred vendor and sole-source policies for critical materials such as CNG fuel, hazmat disposal services, and OEM fleet parts. Sourced from SAP MM Source List (EORD).';

CREATE OR REPLACE TABLE `waste_management_ecm`.`procurement`.`spend_category` (
    `spend_category_id` BIGINT COMMENT 'Unique identifier for the spend category. Primary key.',
    `employee_id` BIGINT COMMENT 'Employee identifier for the procurement category manager or owner responsible for strategic sourcing and vendor management for this category.',
    `parent_category_spend_category_id` BIGINT COMMENT 'Foreign key reference to the parent spend category in the hierarchical taxonomy. Null for top-level categories.',
    `primary_spend_employee_id` BIGINT COMMENT 'System user identifier of the person who created this spend category record.',
    `annual_spend_budget_amount` DECIMAL(18,2) COMMENT 'Budgeted annual spend amount for this category in the current fiscal year. Used for budget variance reporting and spend analytics.',
    `approval_workflow_required_flag` BOOLEAN COMMENT 'Indicates whether purchases in this category require multi-level approval workflow beyond standard Purchase Order (PO) authorization.',
    `budget_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the annual spend budget amount (e.g., USD, CAD, EUR).. Valid values are `^[A-Z]{3}$`',
    `category_code` STRING COMMENT 'Unique alphanumeric code identifying the spend category in the enterprise taxonomy. Used for reporting and system integration.. Valid values are `^[A-Z0-9]{4,12}$`',
    `category_description` STRING COMMENT 'Detailed description of the spend category scope, including examples of goods or services classified under this category.',
    `category_name` STRING COMMENT 'Full business name of the spend category (e.g., Fleet Parts, Diesel Fuel, Personal Protective Equipment).',
    `category_type` STRING COMMENT 'Indicates whether this category applies to goods, services, or both.. Valid values are `Goods|Services|Both`',
    `cogs_classification` STRING COMMENT 'Classification indicating how spend in this category impacts Cost of Goods Sold (COGS) and Earnings Before Interest Taxes Depreciation and Amortization (EBITDA) reporting.. Valid values are `Direct COGS|Indirect COGS|Operating Expense|Capital Expenditure|Non-Operating`',
    `commodity_code` STRING COMMENT 'Standard commodity classification code (e.g., UNSPSC, NAICS) used for industry benchmarking and supplier market analysis.. Valid values are `^[0-9]{8,10}$`',
    `contract_coverage_percent` DECIMAL(18,2) COMMENT 'Percentage of spend in this category covered by active supplier contracts. Higher coverage indicates better cost control and compliance.',
    `cost_element_group` STRING COMMENT 'SAP Controlling (CO) cost element group code associated with this spend category. Used for internal cost allocation and profitability analysis.. Valid values are `^[A-Z0-9_]{2,20}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this spend category record was first created in the system.',
    `ebitda_impact_flag` BOOLEAN COMMENT 'Indicates whether spend in this category directly impacts EBITDA calculations. True if the category affects EBITDA, False otherwise.',
    `effective_end_date` DATE COMMENT 'Date when this spend category was retired or deprecated. Null for currently active categories.',
    `effective_start_date` DATE COMMENT 'Date when this spend category became active and available for use in procurement transactions.',
    `environmental_compliance_required_flag` BOOLEAN COMMENT 'Indicates whether procurement in this category requires environmental compliance documentation or certifications (e.g., ISO 14001, EPA permits).',
    `gl_account_range_end` STRING COMMENT 'Ending General Ledger account number in the range mapped to this spend category. Used for financial reporting and Cost of Goods Sold (COGS) allocation.. Valid values are `^[0-9]{6,10}$`',
    `gl_account_range_start` STRING COMMENT 'Starting General Ledger account number in the range mapped to this spend category. Used for financial reporting and Cost of Goods Sold (COGS) allocation.. Valid values are `^[0-9]{6,10}$`',
    `hazardous_material_flag` BOOLEAN COMMENT 'Indicates whether this spend category includes hazardous materials requiring special handling, storage, or disposal per Resource Conservation and Recovery Act (RCRA) and Environmental Protection Agency (EPA) regulations.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this spend category record was last updated in the system.',
    `last_review_date` DATE COMMENT 'Date when this spend category taxonomy and mapping were last reviewed and validated by the procurement team.',
    `level_1_category` STRING COMMENT 'Top-level classification in the spend hierarchy. Direct Operations includes operational expenditures directly tied to service delivery. Indirect includes support and administrative costs. Capital includes long-term asset investments.. Valid values are `Direct Operations|Indirect|Capital`',
    `level_2_category` STRING COMMENT 'Second-level classification providing functional grouping within Level 1 (e.g., Fleet, Fuel, Disposal, Facilities, Safety, Professional Services). [ENUM-REF-CANDIDATE: Fleet|Fuel|Disposal|Facilities|Safety|Professional Services|Equipment|Containers|Chemicals|IT|HR|Marketing — 12 candidates stripped; promote to reference product]',
    `level_3_category` STRING COMMENT 'Granular sub-category providing detailed classification within Level 2 (e.g., Diesel Fuel, Compressed Natural Gas (CNG), Hydraulic Fluids, Brake Parts, Safety Gloves).',
    `minimum_order_value` DECIMAL(18,2) COMMENT 'Minimum purchase order value threshold for this category. Orders below this threshold may require consolidation or alternative procurement methods.',
    `next_review_due_date` DATE COMMENT 'Scheduled date for the next periodic review of this spend category definition and GL account mappings.',
    `notes` STRING COMMENT 'Free-text notes providing additional context, special instructions, or historical information about this spend category.',
    `preferred_vendor_count` STRING COMMENT 'Number of preferred or approved vendors for this spend category. Used to track supplier concentration and sourcing strategy execution.',
    `safety_certification_required_flag` BOOLEAN COMMENT 'Indicates whether goods or services in this category require Occupational Safety and Health Administration (OSHA) or other safety certifications.',
    `spend_category_status` STRING COMMENT 'Current lifecycle status of the spend category. Active categories are available for use in procurement transactions. Inactive or deprecated categories are retained for historical reporting only.. Valid values are `Active|Inactive|Deprecated|Pending Approval`',
    `strategic_sourcing_priority` STRING COMMENT 'Priority level assigned to this spend category for strategic sourcing initiatives. Critical and High priority categories receive focused supplier negotiation and contract management.. Valid values are `Critical|High|Medium|Low`',
    CONSTRAINT pk_spend_category PRIMARY KEY(`spend_category_id`)
) COMMENT 'Enterprise spend taxonomy classifying all procurement expenditures into a hierarchical category structure aligned with COGS and EBITDA reporting — Level 1 (Direct Operations, Indirect, Capital), Level 2 (Fleet, Fuel, Disposal, Facilities, Safety, Professional Services), Level 3 (granular sub-categories). Supports spend analytics, budget variance reporting, and strategic sourcing prioritization. Maps to GL account ranges and SAP CO cost element groups.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`procurement`.`approval_workflow` (
    `approval_workflow_id` BIGINT COMMENT 'Unique identifier for the approval workflow instance. Primary key for the approval workflow product.',
    `employee_id` BIGINT COMMENT 'Foreign key reference to the employee assigned as the approver for this workflow step. Links to the workforce/employee master data.',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to procurement.purchase_order. Business justification: Approval workflows for purchase orders need a typed FK to the PO being approved. Similar to PR workflows, this provides direct typed relationship from workflow instance to the PO record, enabling work',
    `requester_employee_id` BIGINT COMMENT 'Foreign key reference to the employee who initiated the procurement request. Used for segregation of duties validation and audit trail.',
    `rfq_id` BIGINT COMMENT 'Foreign key linking to procurement.rfq. Business justification: Approval workflows for RFQs need a typed FK to the RFQ being approved. RFQs above certain thresholds require approval before being issued to vendors. This typed relationship enables tracking of RFQ ap',
    `sourcing_contract_id` BIGINT COMMENT 'Foreign key linking to procurement.sourcing_contract. Business justification: Approval workflows track authorization chains for sourcing contracts. Need typed FK to sourcing_contract.sourcing_contract_id when document_type=CONTRACT. No columns to remove as document_reference_',
    `action_timestamp` TIMESTAMP COMMENT 'Date and time when the approver took action on this workflow step. Critical for SLA tracking and audit compliance. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `approval_action` STRING COMMENT 'Action taken by the approver at this workflow step. Indicates whether the approver approved, rejected, delegated to another person, requested additional information, escalated to higher authority, or withdrew the request.. Valid values are `approve|reject|delegate|request_info|escalate|withdraw`',
    `approval_comments` STRING COMMENT 'Free-text comments or notes provided by the approver explaining the rationale for their decision, especially for rejections or requests for additional information.',
    `approval_step_sequence` STRING COMMENT 'Sequential order of the current approval step within the workflow. Indicates the position in the approval chain (e.g., 1 for first approver, 2 for second approver).',
    `approver_role` STRING COMMENT 'Organizational role or position responsible for approval at this step (e.g., Procurement Manager, Finance Director, VP Operations, CFO). Defines the authority level required.',
    `assigned_approver_email` STRING COMMENT 'Email address of the assigned approver. Used for workflow notifications and audit trail. Classified as confidential PII.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `assigned_approver_name` STRING COMMENT 'Full name of the employee assigned as the approver for this workflow step. Denormalized for reporting convenience.',
    `budget_check_status` STRING COMMENT 'Result of the budget availability check performed during the approval workflow. Indicates whether sufficient budget exists for the procurement spend.. Valid values are `passed|failed|warning|not_required`',
    `budget_check_timestamp` TIMESTAMP COMMENT 'Date and time when the budget availability check was performed. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `cost_center_code` STRING COMMENT 'Cost center code to which the procurement spend will be charged. Used for budget validation and financial reporting. Links to the general ledger (GL) cost center master.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this approval workflow record was first created in the system. Audit trail for data lineage. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the spend amount (e.g., USD, EUR, CAD). Required for multi-currency procurement operations.. Valid values are `^[A-Z]{3}$`',
    `delegated_to_approver_name` STRING COMMENT 'Full name of the employee to whom approval authority was delegated. Denormalized for reporting convenience.',
    `delegation_reason` STRING COMMENT 'Free-text explanation for why the approval was delegated to another person (e.g., out of office, conflict of interest, lack of expertise).',
    `document_number` STRING COMMENT 'Business document number of the procurement document being approved (e.g., PO number, PR number, contract number). Denormalized for reporting convenience.',
    `document_reference_number` BIGINT COMMENT 'Foreign key reference to the specific procurement document (purchase requisition, purchase order, or contract) that is subject to this approval workflow.',
    `document_type` STRING COMMENT 'Type of procurement document requiring approval. Indicates whether the workflow is for a purchase requisition (PR), purchase order (PO), sourcing contract, request for quotation (RFQ), service entry sheet, or blanket order.. Valid values are `purchase_requisition|purchase_order|contract|rfq|service_entry_sheet|blanket_order`',
    `escalation_flag` BOOLEAN COMMENT 'Boolean indicator (True/False) showing whether this workflow step has been escalated to a higher authority due to timeout, complexity, or policy exception.',
    `escalation_reason` STRING COMMENT 'Free-text explanation for why the workflow was escalated (e.g., approval timeout, spend threshold exceeded, policy exception required).',
    `escalation_timestamp` TIMESTAMP COMMENT 'Date and time when the workflow was escalated to a higher authority. Null if no escalation occurred. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `gl_account_code` STRING COMMENT 'General ledger account code to which the procurement expense will be posted. Used for financial classification and COGS/EBITDA reporting.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this approval workflow record was last updated. Audit trail for change tracking. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `priority_level` STRING COMMENT 'Priority classification of the approval workflow. Urgent priority may trigger expedited routing or shorter SLA targets. Determined by business criticality and spend urgency.. Valid values are `low|normal|high|urgent`',
    `rejection_reason_code` STRING COMMENT 'Standardized code indicating the reason for rejection (e.g., budget_exceeded, vendor_not_approved, insufficient_justification, duplicate_request). Used for root cause analysis and process improvement.',
    `requester_department` STRING COMMENT 'Department or organizational unit of the employee who initiated the procurement request. Used for spend analytics and budget tracking.',
    `requester_name` STRING COMMENT 'Full name of the employee who initiated the procurement request. Denormalized for reporting convenience.',
    `segregation_of_duties_check_status` STRING COMMENT 'Result of the segregation of duties validation. Ensures that the requester, approver, and receiver are different individuals to prevent fraud. Critical for SOX compliance.. Valid values are `passed|failed|not_applicable`',
    `sla_actual_hours` DECIMAL(18,2) COMMENT 'Actual number of hours taken to complete the approval workflow. Calculated as the difference between workflow_initiated_timestamp and workflow_completed_timestamp. Used for SLA compliance reporting.',
    `sla_breach_flag` BOOLEAN COMMENT 'Boolean indicator (True/False) showing whether the approval workflow exceeded the SLA target hours. True indicates an SLA breach requiring management attention.',
    `sla_target_hours` STRING COMMENT 'Target number of hours within which the approval workflow should be completed, as defined by the service level agreement (SLA). Used for performance monitoring and escalation triggers.',
    `sox_compliance_flag` BOOLEAN COMMENT 'Boolean indicator (True/False) showing whether this workflow instance is subject to Sarbanes-Oxley (SOX) segregation of duties and spend authority controls. True for workflows above materiality thresholds.',
    `spend_amount` DECIMAL(18,2) COMMENT 'Total monetary value of the procurement document subject to approval. Used to determine approval authority levels and routing. Drives SOX segregation of duties controls.',
    `spend_threshold_tier` STRING COMMENT 'Categorization of the spend amount into approval tiers (e.g., tier_1_under_5k, tier_2_5k_to_25k, tier_3_25k_to_100k, tier_4_over_100k). Determines the number and level of approvers required.',
    `total_approval_steps` STRING COMMENT 'Total number of approval steps required for this workflow instance. Determined by spend threshold, document type, and organizational approval rules.',
    `workflow_completed_timestamp` TIMESTAMP COMMENT 'Date and time when the approval workflow was completed (either fully approved or rejected). Null if workflow is still in progress. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `workflow_initiated_timestamp` TIMESTAMP COMMENT 'Date and time when the approval workflow was initiated. Marks the start of the approval cycle for SLA tracking. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `workflow_instance_number` STRING COMMENT 'Business-facing unique identifier for the workflow instance, typically generated by the workflow engine (SAP workflow ID).',
    `workflow_status` STRING COMMENT 'Current lifecycle status of the approval workflow instance. Indicates whether the workflow is pending initiation, in progress, fully approved, rejected, cancelled, escalated to higher authority, or delegated to another approver. [ENUM-REF-CANDIDATE: pending|in_progress|approved|rejected|cancelled|escalated|delegated — 7 candidates stripped; promote to reference product]',
    CONSTRAINT pk_approval_workflow PRIMARY KEY(`approval_workflow_id`)
) COMMENT 'Procurement approval workflow instances tracking the authorization chain for purchase requisitions, purchase orders, and sourcing contracts above defined spend thresholds. Captures workflow instance ID, document type and reference, approval step sequence, approver role, assigned approver, approval action (approve/reject/delegate), action timestamp, comments, and escalation status. Enforces Sarbanes-Oxley (SOX) segregation of duties and spend authority limits. Sourced from SAP workflow (SWWWIHEAD) and procurement approval rules.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`procurement`.`invoice_exception` (
    `invoice_exception_id` BIGINT COMMENT 'Unique identifier for the invoice exception record. Primary key for the invoice exception entity.',
    `goods_receipt_id` BIGINT COMMENT 'Reference to the goods receipt document involved in the three-way match, if applicable. Null for service-based exceptions.',
    `invoice_id` BIGINT COMMENT 'Reference to the vendor invoice that triggered the exception during invoice verification.',
    `material_id` BIGINT COMMENT 'Reference to the material or service involved in the exception. Null for non-material service exceptions.',
    `po_line_id` BIGINT COMMENT 'Foreign key linking to procurement.po_line. Business justification: Invoice exceptions occur at PO line level during three-way match. Currently has po_line_item_number (INT); need FK to po_line.po_line_id for proper exception tracking. Remove po_line_item_number as it',
    `employee_id` BIGINT COMMENT 'Reference to the employee who resolved or is assigned to resolve the exception. Typically an AP specialist or procurement analyst.',
    `purchase_order_id` BIGINT COMMENT 'Reference to the purchase order involved in the three-way match exception.',
    `tertiary_invoice_last_modified_by_user_employee_id` BIGINT COMMENT 'System user ID of the person who last updated the exception record.',
    `vendor_id` BIGINT COMMENT 'Reference to the vendor whose invoice contains the exception.',
    `vendor_invoice_id` BIGINT COMMENT 'Foreign key linking to procurement.vendor_invoice. Business justification: Invoice exceptions are detected during vendor invoice processing and should have a direct FK to the procurement vendor_invoice being validated. Currently has invoice_id pointing to billing.invoice, bu',
    `audit_trail_reference` STRING COMMENT 'Reference identifier linking this exception to audit trail documentation for SOX compliance and internal audit purposes.',
    `cost_center_code` STRING COMMENT 'Cost center code associated with the purchase order line item where the exception occurred. Used for variance tracking and financial reporting.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the exception record was first created in the system.',
    `credit_memo_number` STRING COMMENT 'Reference number of the credit memo requested or received from vendor to correct the invoice discrepancy. Null if no credit memo was involved.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the exception amount (e.g., USD, CAD, MXN).. Valid values are `^[A-Z]{3}$`',
    `escalation_level` STRING COMMENT 'Number of times this exception has been escalated to higher management levels. Zero indicates no escalation. Used to track complex or high-value disputes.',
    `exception_amount` DECIMAL(18,2) COMMENT 'Monetary value of the discrepancy between expected and actual invoice amount. Positive values indicate invoice overcharge, negative values indicate undercharge.',
    `exception_detected_timestamp` TIMESTAMP COMMENT 'Date and time when the invoice matching exception was first identified by the system during invoice verification processing.',
    `exception_status` STRING COMMENT 'Current lifecycle status of the exception in the AP exception management workflow.. Valid values are `open|under_review|pending_vendor_response|resolved|rejected|escalated`',
    `exception_type` STRING COMMENT 'Classification of the invoice matching exception. Identifies the specific type of discrepancy detected during three-way match processing (PO-GR-Invoice). [ENUM-REF-CANDIDATE: price_variance|quantity_variance|missing_goods_receipt|duplicate_invoice|po_tolerance_breach|tax_variance|payment_terms_mismatch|blocked_invoice|other — 9 candidates stripped; promote to reference product]',
    `final_disposition` STRING COMMENT 'Final outcome of the exception resolution process. Indicates whether the invoice was ultimately accepted, rejected, or required adjustment.. Valid values are `accepted|rejected|credit_memo_requested|po_adjusted|cancelled`',
    `gl_account_code` STRING COMMENT 'General ledger account code associated with the purchase order line item. Used for financial impact analysis of exceptions.',
    `gr_quantity` DECIMAL(18,2) COMMENT 'Quantity recorded on the goods receipt document. Null for service-based transactions.',
    `invoice_exception_number` STRING COMMENT 'Business-facing unique exception tracking number assigned to this invoice matching discrepancy for reference and communication with vendors and AP team.',
    `invoice_quantity` DECIMAL(18,2) COMMENT 'Quantity stated on the vendor invoice that is being compared against PO and GR quantities.',
    `invoice_unit_price` DECIMAL(18,2) COMMENT 'Unit price stated on the vendor invoice that is being compared against the PO price.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when the exception record was last updated in the system.',
    `plant_code` STRING COMMENT 'Plant or facility code where the goods were received or service was performed. Used for location-based exception analysis.',
    `po_quantity` DECIMAL(18,2) COMMENT 'Quantity specified on the purchase order line item for comparison during three-way match.',
    `po_unit_price` DECIMAL(18,2) COMMENT 'Unit price specified on the purchase order line item for comparison during three-way match.',
    `price_variance_amount` DECIMAL(18,2) COMMENT 'Calculated difference between PO unit price and invoice unit price, multiplied by quantity. Null if exception type is not price-related.',
    `quantity_variance` DECIMAL(18,2) COMMENT 'Calculated difference between expected quantity (PO or GR) and invoice quantity. Null if exception type is not quantity-related.',
    `resolution_action` STRING COMMENT 'Action taken or planned to resolve the invoice exception. Captures the disposition decision made by AP team or approver. [ENUM-REF-CANDIDATE: accept_variance|reject_invoice|request_credit_memo|adjust_po|vendor_correction|escalate_to_manager|pending_investigation — 7 candidates stripped; promote to reference product]',
    `resolution_date` DATE COMMENT 'Date when the exception was resolved and final disposition was recorded. Null for open exceptions.',
    `resolution_notes` STRING COMMENT 'Detailed notes explaining the resolution decision, root cause analysis, and any corrective actions taken or vendor communications.',
    `sox_control_flag` BOOLEAN COMMENT 'Indicates whether this exception is subject to SOX AP controls compliance monitoring and audit trail requirements (true) or is below materiality threshold (false).',
    `tolerance_breached_flag` BOOLEAN COMMENT 'Indicates whether the exception variance exceeded the configured tolerance thresholds (true) or fell within acceptable limits (false).',
    `tolerance_threshold_amount` DECIMAL(18,2) COMMENT 'Absolute monetary tolerance threshold configured for this PO line item or vendor. Exception is triggered when variance exceeds this amount.',
    `tolerance_threshold_percent` DECIMAL(18,2) COMMENT 'Percentage tolerance threshold configured for this PO line item or vendor. Exception is triggered when variance exceeds this threshold.',
    `unit_of_measure` STRING COMMENT 'Unit of measure for quantities (e.g., EA for each, TON for tons, GAL for gallons, HR for hours).',
    `vendor_response_date` DATE COMMENT 'Date when the vendor provided a response or corrective action regarding the exception. Null if no vendor response was required or received.',
    CONSTRAINT pk_invoice_exception PRIMARY KEY(`invoice_exception_id`)
) COMMENT 'Records invoice matching exceptions and discrepancies identified during three-way match (PO-GR-Invoice) processing. Captures exception type (price variance, quantity variance, missing GR, duplicate invoice, PO tolerance breach), exception amount, tolerance threshold breached, resolution action, resolver, resolution date, and final disposition (accept/reject/credit memo requested). Supports AP exception management workflows and vendor dispute resolution. Critical for SOX AP controls compliance.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`procurement`.`fuel_purchase` (
    `fuel_purchase_id` BIGINT COMMENT 'Unique identifier for the fuel purchase transaction record.',
    `employee_id` BIGINT COMMENT 'Employee who approved the fuel purchase for payment processing.',
    `facility_id` BIGINT COMMENT 'Reference to the facility, depot, CNG station, or fueling facility where the fuel was delivered.',
    `goods_receipt_id` BIGINT COMMENT 'Foreign key linking to procurement.goods_receipt. Business justification: Fuel purchases should link to goods receipt records for three-way match validation (PO-GR-Invoice). Currently has goods_receipt_number as string but no FK to goods_receipt table. Adding goods_receipt_',
    `material_id` BIGINT COMMENT 'Foreign key linking to procurement.material. Business justification: Fuel purchases are for specific fuel materials (diesel, CNG, RNG, DEF). Currently has fuel_type (STRING descriptor); need FK to material.material_id to link to material master for fuel SKUs. No column',
    `purchase_order_id` BIGINT COMMENT 'Reference to the purchase order that authorized this fuel procurement.',
    `receiving_employee_id` BIGINT COMMENT 'Employee who received and verified the fuel delivery at the site.',
    `vendor_id` BIGINT COMMENT 'Reference to the fuel supplier or vendor providing the fuel delivery.',
    `approval_date` DATE COMMENT 'Date when the fuel purchase was approved for payment.',
    `approval_status` STRING COMMENT 'Approval status of the fuel purchase transaction for financial posting and payment processing.. Valid values are `pending|approved|rejected`',
    `bol_number` STRING COMMENT 'Bill of Lading number provided by the carrier documenting the fuel shipment and delivery.',
    `carbon_intensity_score` DECIMAL(18,2) COMMENT 'Carbon intensity score for RNG fuel, measured in grams of CO2 equivalent per megajoule (gCO2e/MJ), supporting GHG and sustainability reporting.',
    `company_code` STRING COMMENT 'SAP company code representing the legal entity making the fuel purchase.',
    `cost_center_code` STRING COMMENT 'Cost center code to which the fuel purchase cost is allocated for COGS and EBITDA reporting.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the fuel purchase record was first created in the system.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the purchase transaction.. Valid values are `USD|CAD|MXN|EUR|GBP`',
    `delivery_date` DATE COMMENT 'Date when the fuel was delivered to the facility or fueling site.',
    `delivery_note_number` STRING COMMENT 'Delivery note or packing slip number provided by the vendor at the time of fuel delivery.',
    `delivery_timestamp` TIMESTAMP COMMENT 'Precise date and time when the fuel delivery was completed at the receiving site.',
    `freight_charge` DECIMAL(18,2) COMMENT 'Delivery or freight charge for transporting the fuel to the delivery site.',
    `fuel_type` STRING COMMENT 'Type of fuel purchased. CNG = Compressed Natural Gas, RNG = Renewable Natural Gas, DEF = Diesel Exhaust Fluid.. Valid values are `diesel|cng|rng|def|gasoline|biodiesel`',
    `gl_account_code` STRING COMMENT 'General ledger account code for posting the fuel purchase expense.',
    `invoice_date` DATE COMMENT 'Date on the vendor invoice for this fuel purchase.',
    `invoice_number` STRING COMMENT 'Invoice number provided by the vendor for this fuel purchase, used for accounts payable processing.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the fuel purchase record was last updated in the system.',
    `net_amount` DECIMAL(18,2) COMMENT 'Net total amount for the fuel purchase including base cost, taxes, and freight charges.',
    `notes` STRING COMMENT 'Free-text notes or comments related to the fuel purchase, delivery conditions, or special circumstances.',
    `payment_terms_code` STRING COMMENT 'Payment terms code defining the due date and discount conditions for this fuel purchase (e.g., Net 30, 2/10 Net 30).',
    `plant_code` STRING COMMENT 'SAP plant code representing the operational site or facility receiving the fuel.',
    `purchase_number` STRING COMMENT 'Business-facing unique identifier for the fuel purchase transaction, used for tracking and reconciliation.',
    `purchase_status` STRING COMMENT 'Current lifecycle status of the fuel purchase transaction.. Valid values are `ordered|delivered|invoiced|paid|cancelled`',
    `purchasing_group` STRING COMMENT 'Purchasing group responsible for procuring the fuel, typically aligned with fleet or operations teams.',
    `purchasing_organization` STRING COMMENT 'SAP purchasing organization that executed the fuel procurement transaction.',
    `quantity` DECIMAL(18,2) COMMENT 'Quantity of fuel purchased and delivered, measured in gallons or GGE (gasoline gallon equivalent) for CNG/RNG.',
    `renewable_fuel_flag` BOOLEAN COMMENT 'Indicates whether the fuel is a renewable type (RNG, biodiesel) for sustainability tracking and reporting.',
    `tank_gauge_reading_post_delivery` DECIMAL(18,2) COMMENT 'Fuel tank gauge reading (in gallons or liters) recorded after the delivery, used to verify delivered quantity.',
    `tank_gauge_reading_pre_delivery` DECIMAL(18,2) COMMENT 'Fuel tank gauge reading (in gallons or liters) recorded before the delivery, used for reconciliation.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Total tax amount applied to the fuel purchase, including federal and state fuel excise taxes.',
    `total_cost` DECIMAL(18,2) COMMENT 'Total cost of the fuel purchase, calculated as quantity multiplied by unit price, before taxes and fees.',
    `unit_of_measure` STRING COMMENT 'Unit of measure for the fuel quantity. GGE = Gasoline Gallon Equivalent used for CNG and RNG to normalize energy content.. Valid values are `gallons|gge|liters|kg`',
    `unit_price` DECIMAL(18,2) COMMENT 'Price per unit (gallon or GGE) of fuel at the time of purchase.',
    CONSTRAINT pk_fuel_purchase PRIMARY KEY(`fuel_purchase_id`)
) COMMENT 'Specialized transactional record capturing bulk fuel procurement events — diesel, CNG, RNG, and DEF purchases for the fleet. Captures fuel type, supplier, delivery site (depot, CNG station, fueling facility), quantity in gallons or GGE (gasoline gallon equivalent), unit price, total cost, delivery date, BOL number, tank gauge readings pre/post delivery, and carbon intensity score for RNG (supporting GHG/CO2e reporting). Distinct from fleet-level fuel dispensing records owned by the fleet domain. Supports fuel cost COGS allocation and sustainability reporting.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`procurement`.`disposal_purchase_order` (
    `disposal_purchase_order_id` BIGINT COMMENT 'Unique identifier for the disposal purchase order. Primary key for this entity.',
    `approver_employee_id` BIGINT COMMENT 'Employee who provided final approval for this disposal purchase order per authorization limits and approval workflow.',
    `offering_id` BIGINT COMMENT 'Foreign key linking to service.offering. Business justification: Disposal POs purchase disposal services from TSDFs, which are service offerings in the catalog. Real business process: hazardous waste disposal procurement, rate management, and vendor service trackin',
    `employee_id` BIGINT COMMENT 'System user ID of the person who created this disposal purchase order record.',
    `epa_id_registration_id` BIGINT COMMENT 'EPA-issued 12-character identification number for the TSDF facility. Required for RCRA cradle-to-grave tracking. Format: 3 letters (state code) + 9 digits.. Valid values are `^[A-Z]{3}[0-9]{9}$`',
    `last_modified_by_user_employee_id` BIGINT COMMENT 'System user ID of the person who last modified this disposal purchase order record.',
    `facility_id` BIGINT COMMENT 'Foreign key linking to asset.facility. Business justification: Disposal POs for offsite waste treatment must track the originating facility for EPA/state regulatory reporting, hazardous waste manifest reconciliation, cost allocation by facility, and environmental',
    `requester_employee_id` BIGINT COMMENT 'Employee who initiated the disposal service request and purchase requisition that led to this purchase order.',
    `tsdf_facility_id` BIGINT COMMENT 'Foreign key linking to hazmat.tsdf_facility. Business justification: Disposal purchase orders for hazardous waste treatment/disposal should link to the approved TSDF facility record to ensure only approved facilities are used and to track vendor performance for hazmat ',
    `vendor_id` BIGINT COMMENT 'Reference to the third-party disposal vendor providing waste treatment or disposal services. Links to licensed TSDF, landfill, recycling processor, or WTE facility.',
    `waste_stream_id` BIGINT COMMENT 'Foreign key linking to service.service_waste_stream. Business justification: Disposal POs specify the waste stream being disposed for manifest generation and regulatory compliance. Real business process: waste manifest creation, EPA reporting, and disposal tracking. Essential ',
    `approval_date` DATE COMMENT 'Date when the disposal purchase order received final approval and was released to the vendor.',
    `company_code` STRING COMMENT 'SAP company code representing the legal entity issuing this disposal purchase order for financial reporting and consolidation.. Valid values are `^[A-Z0-9]{4}$`',
    `contract_number` STRING COMMENT 'Reference to the master sourcing contract or blanket agreement under which this disposal purchase order is issued, if applicable.',
    `cost_center_code` STRING COMMENT 'Cost center to which disposal expenses will be charged for internal cost allocation and COGS tracking.. Valid values are `^[A-Z0-9]{10}$`',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this disposal purchase order record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts on this purchase order.. Valid values are `^[A-Z]{3}$`',
    `delivery_location` STRING COMMENT 'Physical address or site identifier where waste will be delivered for disposal. Typically the TSDF facility address.',
    `disposal_site_permit_number` STRING COMMENT 'State or local permit number authorizing the disposal facility to accept and process waste. Required for regulatory compliance verification.',
    `estimated_tonnage` DECIMAL(18,2) COMMENT 'Estimated quantity of waste to be disposed under this purchase order, measured in tons. Used for cost estimation and capacity planning.',
    `estimated_total_amount` DECIMAL(18,2) COMMENT 'Total estimated cost for disposal services under this purchase order. Calculated as estimated tonnage multiplied by tipping fee, plus any surcharges.',
    `gl_account_code` STRING COMMENT 'General ledger account code for posting disposal service expenses. Typically mapped to COGS or operating expense accounts.. Valid values are `^[0-9]{6,10}$`',
    `incoterms_code` STRING COMMENT 'Incoterms code defining the delivery terms and transfer of risk between buyer and seller for waste transportation to disposal site. [ENUM-REF-CANDIDATE: EXW|FCA|CPT|CIP|DAP|DPU|DDP — 7 candidates stripped; promote to reference product]',
    `last_modified_timestamp` TIMESTAMP COMMENT 'System timestamp when this disposal purchase order record was last updated or modified.',
    `manifest_required_flag` BOOLEAN COMMENT 'Indicates whether a hazardous waste manifest (EPA Form 8700-22) is required for this disposal transaction per RCRA cradle-to-grave tracking requirements.',
    `net_amount` DECIMAL(18,2) COMMENT 'Final net amount for the disposal purchase order including all fees, surcharges, and taxes.',
    `notes` STRING COMMENT 'Free-text field for additional instructions, special handling requirements, or comments related to the disposal purchase order.',
    `payment_terms_code` STRING COMMENT 'SAP payment terms code defining the payment schedule and discount terms for this purchase order.. Valid values are `^[A-Z0-9]{4}$`',
    `po_date` DATE COMMENT 'Date when the disposal purchase order was created and issued to the vendor.',
    `po_number` STRING COMMENT 'Externally-known unique purchase order number assigned by SAP MM for tracking and reference. Standard 10-digit format.. Valid values are `^[0-9]{10}$`',
    `po_status` STRING COMMENT 'Current lifecycle status of the disposal purchase order in the procurement workflow. [ENUM-REF-CANDIDATE: draft|submitted|approved|in_process|partially_received|completed|cancelled|closed — 8 candidates stripped; promote to reference product]',
    `po_type` STRING COMMENT 'Classification of the purchase order type indicating the procurement method and workflow.. Valid values are `standard|blanket|contract_release|emergency|subcontracting`',
    `purchasing_group` STRING COMMENT 'SAP purchasing group (buyer team) responsible for managing this disposal purchase order and vendor relationship.. Valid values are `^[A-Z0-9]{3}$`',
    `purchasing_organization` STRING COMMENT 'SAP purchasing organization responsible for procuring disposal services and managing vendor relationships.. Valid values are `^[A-Z0-9]{4}$`',
    `regulatory_compliance_attestation` STRING COMMENT 'Attestation status confirming that the disposal vendor and method meet all applicable EPA, RCRA, state, and local regulatory requirements.. Valid values are `compliant|pending_review|non_compliant|exempted`',
    `requested_delivery_date` DATE COMMENT 'Target date by which waste disposal services are required to be completed.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Total tax amount applicable to this disposal purchase order based on jurisdiction and tax rules.',
    `tipping_fee_per_unit` DECIMAL(18,2) COMMENT 'Contracted disposal fee charged per unit of waste (typically per ton). Core pricing component for disposal cost calculation and COGS allocation.',
    `unit_of_measure` STRING COMMENT 'Unit of measure for waste quantity. Ton is standard for most disposal contracts; cubic yards for volume-based pricing.. Valid values are `ton|cubic_yard|gallon|drum|container`',
    `wbs_element` STRING COMMENT 'Project WBS element for capital projects or special initiatives requiring disposal services. Used for project cost tracking.',
    CONSTRAINT pk_disposal_purchase_order PRIMARY KEY(`disposal_purchase_order_id`)
) COMMENT 'Specialized purchase order variant for third-party waste disposal and treatment services procured from licensed TSDFs, landfills, recycling processors, and WTE facilities. Captures disposal vendor (TSDF), waste stream type (MSW, C&D, hazmat, universal waste), disposal method (landfill, incineration, treatment, recycling), contracted tipping fee per ton, estimated tonnage, disposal site permit number, EPA ID, manifest requirement flag, and regulatory compliance attestation. Supports RCRA cradle-to-grave tracking and disposal cost COGS allocation. Distinct from standard goods POs.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`procurement`.`purchasing_info_record` (
    `purchasing_info_record_id` BIGINT COMMENT 'Primary key for purchasing_info_record',
    `info_record_id` BIGINT COMMENT 'Unique identifier for the purchasing info record. Primary key.',
    `material_id` BIGINT COMMENT 'Foreign key linking to the material being sourced from this vendor',
    `vendor_id` BIGINT COMMENT 'Foreign key to vendor. Part of the vendor-material relationship.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the standard price in this info record.',
    `info_record_status` STRING COMMENT 'Current status of the purchasing info record. Active records are used for PO creation; blocked records prevent procurement.',
    `last_purchase_order_date` DATE COMMENT 'Date of the most recent purchase order created using this info record. Used for vendor performance tracking and sourcing analytics.',
    `minimum_order_quantity` DECIMAL(18,2) COMMENT 'Vendor-specific minimum order quantity for this material. Each vendor may have different MOQ requirements for the same material.',
    `planned_delivery_time_days` STRING COMMENT 'Vendor-specific lead time in days from PO creation to material receipt. Lead time varies by vendor for the same material.',
    `plant_code` STRING COMMENT 'Specific plant or facility for which this info record applies. Allows plant-specific vendor sourcing and pricing.',
    `price_unit` STRING COMMENT 'Quantity unit for which the standard price applies (e.g., price per 1, per 100, per 1000 units).',
    `purchasing_organization` STRING COMMENT 'SAP purchasing organization code that negotiated this info record. Supports multi-org procurement structures.',
    `standard_price` DECIMAL(18,2) COMMENT 'Negotiated unit price for this material from this vendor. Price is specific to the vendor-material combination and varies by vendor.',
    `valid_from_date` DATE COMMENT 'Start date of the validity period for this purchasing info record. Supports time-based pricing and contract terms.',
    `valid_to_date` DATE COMMENT 'End date of the validity period for this purchasing info record. Null indicates open-ended validity.',
    `vendor_material_number` STRING COMMENT 'Vendors own part number or catalog identifier for this material. Used for cross-referencing in purchase orders and vendor communications.',
    CONSTRAINT pk_purchasing_info_record PRIMARY KEY(`purchasing_info_record_id`)
) COMMENT 'This association product represents the sourcing agreement between a vendor and a material in SAP MM. It captures vendor-specific procurement terms for each material, including negotiated pricing, lead times, minimum order quantities, and vendor material identifiers. Each record links one vendor to one material with attributes that exist only in the context of this vendor-material sourcing relationship. Sourced from SAP MM EINE/EINA tables.. Existence Justification: In waste management procurement operations, materials (fleet parts, fuels, PPE, containers, chemicals) are sourced from multiple vendors, and each vendor supplies multiple materials. The purchasing info record is a standard SAP MM business concept that captures vendor-specific procurement terms for each material, including negotiated prices, lead times, minimum order quantities, and vendor material identifiers. This is an operational M:N relationship actively managed by procurement teams during vendor negotiations, sourcing decisions, and purchase order creation.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`procurement`.`vendor_waste_stream_approval` (
    `vendor_waste_stream_approval_id` BIGINT COMMENT 'Unique identifier for this vendor-waste stream approval record. Primary key.',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to the vendor master record. Identifies which vendor is approved to handle this waste stream.',
    `waste_stream_id` BIGINT COMMENT 'Foreign key linking to the waste stream classification record. Identifies which waste stream this approval covers.',
    `approval_date` DATE COMMENT 'Date when this vendor was approved to handle this specific waste stream. Sourced from regulatory compliance or vendor qualification process.',
    `approval_status` STRING COMMENT 'Current status of this vendor approval for this waste stream: Active (approved and operational), Suspended (temporarily halted), Expired (permit lapsed), Revoked (approval withdrawn), Pending (under review).',
    `capacity_tons_per_month` DECIMAL(18,2) COMMENT 'Maximum monthly tonnage capacity this vendor can accept for this specific waste stream. Used for vendor selection and load balancing.',
    `certification_number` STRING COMMENT 'Vendor-specific certification or license number authorizing them to handle this waste stream type (e.g., RCRA permit number, state hazmat license).',
    `effective_end_date` DATE COMMENT 'Date when this vendor approval expired or was terminated for this waste stream. Null if currently active.',
    `effective_start_date` DATE COMMENT 'Date when this vendor approval and pricing became effective for this waste stream.',
    `last_audit_date` DATE COMMENT 'Date of the most recent compliance audit or site inspection for this vendor-waste stream approval.',
    `next_recertification_date` DATE COMMENT 'Date when this vendor must recertify or renew their approval to continue handling this waste stream.',
    `permit_number` STRING COMMENT 'Regulatory permit number issued by EPA or state environmental agency authorizing this vendor to process this waste stream.',
    `preferred_vendor_flag` BOOLEAN COMMENT 'Indicates whether this vendor is the preferred/primary vendor for this waste stream based on pricing, capacity, or service quality.',
    `unit_price` DECIMAL(18,2) COMMENT 'Contracted price per ton (or per unit) for this vendor to process this waste stream. Varies by vendor-waste stream combination.',
    CONSTRAINT pk_vendor_waste_stream_approval PRIMARY KEY(`vendor_waste_stream_approval_id`)
) COMMENT 'This association product represents the regulatory approval and commercial agreement between a waste stream classification and a vendor authorized to handle that waste stream. It captures vendor-specific permits, certifications, capacity constraints, and pricing for each waste stream they are approved to process. Each record links one waste stream to one vendor with attributes that exist only in the context of this approval relationship. This is the SSOT for approved vendor selection, regulatory compliance verification, and disposal vendor routing decisions.. Existence Justification: In waste management operations, multiple vendors can be approved to handle the same waste stream (e.g., multiple TSDFs certified for RCRA hazardous waste code D001), and each vendor is approved to handle multiple waste stream types. The business actively manages vendor-specific approvals, permits, certifications, capacity constraints, and pricing for each waste stream-vendor combination as part of regulatory compliance and disposal vendor selection processes.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`procurement`.`bank_account` (
    `bank_account_id` BIGINT COMMENT 'Primary key for bank_account',
    `cost_center_id` BIGINT COMMENT 'Reference to the cost center responsible for transactions through this bank account.',
    `legal_entity_id` BIGINT COMMENT 'Reference to the legal entity that owns or controls this bank account.',
    `superseded_bank_account_id` BIGINT COMMENT 'Self-referencing FK on bank_account (superseded_bank_account_id)',
    `account_closed_date` DATE COMMENT 'The date when the bank account was officially closed, if applicable.',
    `account_holder_name` STRING COMMENT 'The legal name of the entity or individual who is the registered holder of the bank account.',
    `account_holder_tax_number` STRING COMMENT 'The tax identification number (EIN or SSN) of the account holder for tax reporting purposes.',
    `account_name` STRING COMMENT 'The legal name or title associated with the bank account as registered with the financial institution.',
    `account_number` STRING COMMENT 'The unique account number assigned by the financial institution.',
    `account_opened_date` DATE COMMENT 'The date when the bank account was originally opened with the financial institution.',
    `account_purpose` STRING COMMENT 'The primary business purpose or function for which the bank account is used within procurement and treasury operations.',
    `account_status` STRING COMMENT 'Current operational status of the bank account in the system.',
    `account_type` STRING COMMENT 'Classification of the bank account based on its purpose and functionality.',
    `bank_contact_email` STRING COMMENT 'The email address of the primary bank contact for account communications.',
    `bank_contact_name` STRING COMMENT 'The name of the primary contact person at the bank for this account.',
    `bank_contact_phone` STRING COMMENT 'The phone number of the primary bank contact for account inquiries and support.',
    `bank_name` STRING COMMENT 'The legal name of the financial institution holding the account.',
    `bank_routing_number` STRING COMMENT 'The nine-digit American Bankers Association (ABA) routing transit number identifying the financial institution.',
    `branch_address` STRING COMMENT 'The complete street address of the bank branch holding the account.',
    `branch_city` STRING COMMENT 'The city where the bank branch is located.',
    `branch_country_code` STRING COMMENT 'The three-letter ISO country code where the bank branch is located.',
    `branch_name` STRING COMMENT 'The name of the specific bank branch where the account is held.',
    `branch_postal_code` STRING COMMENT 'The postal code of the bank branch location.',
    `branch_state` STRING COMMENT 'The two-letter state code where the bank branch is located.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this bank account record was first created in the system.',
    `currency_code` STRING COMMENT 'The three-letter ISO currency code representing the primary currency of the bank account.',
    `current_balance` DECIMAL(18,2) COMMENT 'The current available balance in the bank account as of the last reconciliation.',
    `effective_end_date` DATE COMMENT 'The date until which this bank account record is effective; null indicates the account is currently active.',
    `effective_start_date` DATE COMMENT 'The date from which this bank account record is effective for use in procurement and payment operations.',
    `gl_account_code` STRING COMMENT 'The general ledger account code to which this bank account is mapped for financial reporting.',
    `iban` STRING COMMENT 'The International Bank Account Number used for international wire transfers and cross-border payments.',
    `internal_notes` STRING COMMENT 'Free-form text field for internal notes, special instructions, or comments about the bank account.',
    `is_active_for_payments` BOOLEAN COMMENT 'Indicates whether this bank account is currently enabled for outgoing payment transactions.',
    `is_active_for_receipts` BOOLEAN COMMENT 'Indicates whether this bank account is currently enabled for incoming receipt transactions.',
    `is_primary_account` BOOLEAN COMMENT 'Indicates whether this is the primary bank account for the associated legal entity or cost center.',
    `last_reconciliation_date` DATE COMMENT 'The date when the bank account was last reconciled with bank statements.',
    `minimum_balance_required` DECIMAL(18,2) COMMENT 'The minimum account balance required to be maintained as per bank or internal policy.',
    `modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this bank account record was last modified in the system.',
    `swift_code` STRING COMMENT 'The Society for Worldwide Interbank Financial Telecommunication (SWIFT) Bank Identifier Code (BIC) for international transactions.',
    CONSTRAINT pk_bank_account PRIMARY KEY(`bank_account_id`)
) COMMENT 'Master reference table for bank_account. Referenced by bank_account_id.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`procurement`.`sourcing_event` (
    `sourcing_event_id` BIGINT COMMENT 'Primary key for sourcing_event',
    `approver_employee_id` BIGINT COMMENT 'Identifier of the manager or executive who approved the sourcing event.',
    `employee_id` BIGINT COMMENT 'Identifier of the procurement buyer or sourcing specialist responsible for managing this event.',
    `vendor_id` BIGINT COMMENT 'Identifier of the supplier awarded the sourcing event (if single award).',
    `rebid_sourcing_event_id` BIGINT COMMENT 'Self-referencing FK on sourcing_event (rebid_sourcing_event_id)',
    `approval_date` DATE COMMENT 'Date when the sourcing event was approved for publication.',
    `approval_status` STRING COMMENT 'Internal approval status of the sourcing event before publication.',
    `award_date` DATE COMMENT 'Date when the sourcing event was awarded to the winning supplier(s).',
    `awarded_value` DECIMAL(18,2) COMMENT 'Total monetary value awarded as a result of the sourcing event in the specified currency.',
    `cancellation_reason` STRING COMMENT 'Explanation for why the sourcing event was cancelled, if applicable.',
    `commodity_code` STRING COMMENT 'Standardized commodity classification code (e.g., UNSPSC or internal taxonomy) identifying the goods or services being sourced.',
    `contract_end_date` DATE COMMENT 'Planned or actual end date for the resulting contract or purchase agreement.',
    `contract_start_date` DATE COMMENT 'Planned or actual start date for the resulting contract or purchase agreement.',
    `cost_center` STRING COMMENT 'Financial cost center code to which sourcing costs and resulting purchases will be allocated.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the sourcing event record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the sourcing event (e.g., USD, CAD, EUR).',
    `delivery_location` STRING COMMENT 'Primary delivery location or site for goods or services resulting from the sourcing event.',
    `sourcing_event_description` STRING COMMENT 'Detailed description of the sourcing event scope, requirements, and objectives.',
    `estimated_value` DECIMAL(18,2) COMMENT 'Estimated total monetary value of the sourcing event in USD.',
    `evaluation_criteria` STRING COMMENT 'Summary of the criteria used to evaluate and score supplier responses (e.g., price, quality, delivery, sustainability).',
    `evaluation_start_date` DATE COMMENT 'Date when evaluation of supplier responses begins.',
    `event_name` STRING COMMENT 'Human-readable name or title of the sourcing event describing its purpose.',
    `event_number` STRING COMMENT 'Externally-known business identifier for the sourcing event, typically formatted as SE-NNNNNNNN.',
    `event_status` STRING COMMENT 'Current lifecycle status of the sourcing event indicating its workflow state.',
    `event_type` STRING COMMENT 'Classification of the sourcing event: Request for Information (RFI), Request for Proposal (RFP), Request for Quotation (RFQ), Auction, Tender, or Negotiation.',
    `invited_supplier_count` STRING COMMENT 'Number of suppliers invited to participate in the sourcing event.',
    `is_multi_award` BOOLEAN COMMENT 'Indicates whether the sourcing event allows for multiple suppliers to be awarded (True) or single award only (False).',
    `is_reverse_auction` BOOLEAN COMMENT 'Indicates whether the sourcing event is conducted as a reverse auction where suppliers compete by lowering prices in real-time (True/False).',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when the sourcing event record was last modified.',
    `notes` STRING COMMENT 'Additional internal notes or comments related to the sourcing event.',
    `payment_terms` STRING COMMENT 'Payment terms specified for the sourcing event (e.g., Net 30, Net 60, 2/10 Net 30).',
    `procurement_category` STRING COMMENT 'High-level category of goods or services being sourced (e.g., Fleet Parts, Fuel, PPE, Containers, Chemicals, Equipment, Facility Supplies, Professional Services, Disposal Services).',
    `publish_date` DATE COMMENT 'Date when the sourcing event was published and made available to suppliers.',
    `requesting_department` STRING COMMENT 'Business unit or department that initiated the sourcing request.',
    `response_count` STRING COMMENT 'Number of supplier responses or bids received for the sourcing event.',
    `response_deadline` TIMESTAMP COMMENT 'Date and time by which suppliers must submit their responses or bids.',
    `savings_amount` DECIMAL(18,2) COMMENT 'Cost savings achieved compared to baseline or estimated value, in the specified currency.',
    `sustainability_required` BOOLEAN COMMENT 'Indicates whether sustainability or environmental compliance criteria are mandatory for supplier participation (True/False).',
    `terms_and_conditions` STRING COMMENT 'Legal and commercial terms and conditions applicable to the sourcing event and resulting contract.',
    CONSTRAINT pk_sourcing_event PRIMARY KEY(`sourcing_event_id`)
) COMMENT 'Master reference table for sourcing_event. Referenced by sourcing_event_id.';

CREATE OR REPLACE TABLE `waste_management_ecm`.`procurement`.`legal_entity` (
    `legal_entity_id` BIGINT COMMENT 'Primary key for legal_entity',
    `annual_revenue_amount` DECIMAL(18,2) COMMENT 'The most recent annual revenue amount reported by the legal entity, in the base currency.',
    `base_currency_code` STRING COMMENT 'The three-letter ISO currency code representing the primary functional currency used by the legal entity for financial reporting.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this legal entity record was first created in the system.',
    `credit_rating` STRING COMMENT 'The current credit rating assigned to the legal entity by a recognized credit rating agency (e.g., Moodys, S&P, Fitch).',
    `credit_rating_agency` STRING COMMENT 'The name of the credit rating agency that assigned the credit rating (e.g., Moodys, Standard & Poors, Fitch).',
    `dissolution_date` DATE COMMENT 'The date on which the legal entity was officially dissolved or ceased operations, if applicable.',
    `doing_business_as_name` STRING COMMENT 'Trade name or DBA name under which the legal entity operates commercially, if different from the legal name.',
    `duns_number` STRING COMMENT 'The nine-digit DUNS number assigned by Dun & Bradstreet to uniquely identify the legal entity globally.',
    `employee_count` STRING COMMENT 'The total number of employees employed by the legal entity as of the most recent reporting period.',
    `entity_status` STRING COMMENT 'Current operational and legal status of the entity (e.g., active, inactive, dissolved, suspended, merged).',
    `entity_type` STRING COMMENT 'The legal structure classification of the entity (e.g., corporation, LLC, partnership, sole proprietorship, joint venture, subsidiary).',
    `environmental_permit_number` STRING COMMENT 'The primary environmental operating permit number issued to the legal entity by the regulatory authority.',
    `fiscal_year_end_month` STRING COMMENT 'The month (1-12) in which the legal entitys fiscal year ends for financial reporting purposes.',
    `incorporation_date` DATE COMMENT 'The date on which the legal entity was officially incorporated or registered with the governing authority.',
    `incorporation_jurisdiction` STRING COMMENT 'The state, province, or country where the legal entity is incorporated or registered.',
    `insurance_carrier_name` STRING COMMENT 'The name of the insurance company providing primary liability coverage for the legal entity.',
    `insurance_coverage_amount` DECIMAL(18,2) COMMENT 'The total liability coverage amount provided by the primary insurance policy, in the base currency.',
    `insurance_policy_number` STRING COMMENT 'The primary general liability insurance policy number covering the legal entitys operations.',
    `is_active` BOOLEAN COMMENT 'Boolean flag indicating whether the legal entity record is currently active and in use for business operations.',
    `is_publicly_traded` BOOLEAN COMMENT 'Boolean flag indicating whether the legal entity is publicly traded on a stock exchange.',
    `is_regulated_entity` BOOLEAN COMMENT 'Boolean flag indicating whether the legal entity is subject to specific regulatory oversight (e.g., EPA, state environmental agencies).',
    `legal_name` STRING COMMENT 'The full legal registered name of the entity as it appears on official incorporation documents and regulatory filings.',
    `naics_code` STRING COMMENT 'The six-digit NAICS code that classifies the legal entitys primary business activity.',
    `parent_legal_entity_id` BIGINT COMMENT 'Reference to the parent legal entity if this entity is a subsidiary or part of a corporate hierarchy.',
    `permit_expiration_date` DATE COMMENT 'The date on which the legal entitys primary environmental operating permit expires and requires renewal.',
    `primary_business_activity` STRING COMMENT 'Description of the primary business activity or industry sector in which the legal entity operates (e.g., waste collection, recycling, landfill operations).',
    `primary_contact_email` STRING COMMENT 'The email address of the primary contact person or registered agent for the legal entity.',
    `primary_contact_name` STRING COMMENT 'The name of the primary contact person or registered agent for the legal entity.',
    `primary_contact_phone` STRING COMMENT 'The phone number of the primary contact person or registered agent for the legal entity.',
    `registered_address_line_1` STRING COMMENT 'The first line of the official registered address of the legal entity as filed with the incorporation authority.',
    `registered_address_line_2` STRING COMMENT 'The second line of the official registered address (suite, floor, building) if applicable.',
    `registered_city` STRING COMMENT 'The city of the official registered address of the legal entity.',
    `registered_country_code` STRING COMMENT 'The three-letter ISO country code of the official registered address of the legal entity.',
    `registered_postal_code` STRING COMMENT 'The postal or ZIP code of the official registered address of the legal entity.',
    `registered_state_province` STRING COMMENT 'The state or province of the official registered address of the legal entity.',
    `registration_number` STRING COMMENT 'The official registration or charter number assigned by the incorporation jurisdiction authority.',
    `regulatory_authority` STRING COMMENT 'The name of the primary regulatory authority or agency that oversees the legal entitys operations (e.g., EPA, state environmental department).',
    `stock_exchange_symbol` STRING COMMENT 'The ticker symbol under which the legal entitys stock is traded, if publicly traded.',
    `tax_identification_number` STRING COMMENT 'The federal tax identification number (EIN in the US) assigned to the legal entity by the tax authority.',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this legal entity record was last modified in the system.',
    CONSTRAINT pk_legal_entity PRIMARY KEY(`legal_entity_id`)
) COMMENT 'Master reference table for legal_entity. Referenced by legal_entity_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_contact` ADD CONSTRAINT `fk_procurement_vendor_contact_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `waste_management_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_certification` ADD CONSTRAINT `fk_procurement_vendor_certification_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `waste_management_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_performance` ADD CONSTRAINT `fk_procurement_vendor_performance_sourcing_contract_id` FOREIGN KEY (`sourcing_contract_id`) REFERENCES `waste_management_ecm`.`procurement`.`sourcing_contract`(`sourcing_contract_id`);
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_performance` ADD CONSTRAINT `fk_procurement_vendor_performance_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `waste_management_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `waste_management_ecm`.`procurement`.`material` ADD CONSTRAINT `fk_procurement_material_material_group_id` FOREIGN KEY (`material_group_id`) REFERENCES `waste_management_ecm`.`procurement`.`material_group`(`material_group_id`);
ALTER TABLE `waste_management_ecm`.`procurement`.`material_group` ADD CONSTRAINT `fk_procurement_material_group_parent_material_group_id` FOREIGN KEY (`parent_material_group_id`) REFERENCES `waste_management_ecm`.`procurement`.`material_group`(`material_group_id`);
ALTER TABLE `waste_management_ecm`.`procurement`.`purchase_requisition` ADD CONSTRAINT `fk_procurement_purchase_requisition_material_group_id` FOREIGN KEY (`material_group_id`) REFERENCES `waste_management_ecm`.`procurement`.`material_group`(`material_group_id`);
ALTER TABLE `waste_management_ecm`.`procurement`.`purchase_requisition` ADD CONSTRAINT `fk_procurement_purchase_requisition_material_id` FOREIGN KEY (`material_id`) REFERENCES `waste_management_ecm`.`procurement`.`material`(`material_id`);
ALTER TABLE `waste_management_ecm`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_purchase_requisition_id` FOREIGN KEY (`purchase_requisition_id`) REFERENCES `waste_management_ecm`.`procurement`.`purchase_requisition`(`purchase_requisition_id`);
ALTER TABLE `waste_management_ecm`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_sourcing_contract_id` FOREIGN KEY (`sourcing_contract_id`) REFERENCES `waste_management_ecm`.`procurement`.`sourcing_contract`(`sourcing_contract_id`);
ALTER TABLE `waste_management_ecm`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `waste_management_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `waste_management_ecm`.`procurement`.`po_line` ADD CONSTRAINT `fk_procurement_po_line_material_id` FOREIGN KEY (`material_id`) REFERENCES `waste_management_ecm`.`procurement`.`material`(`material_id`);
ALTER TABLE `waste_management_ecm`.`procurement`.`po_line` ADD CONSTRAINT `fk_procurement_po_line_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `waste_management_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `waste_management_ecm`.`procurement`.`goods_receipt` ADD CONSTRAINT `fk_procurement_goods_receipt_material_id` FOREIGN KEY (`material_id`) REFERENCES `waste_management_ecm`.`procurement`.`material`(`material_id`);
ALTER TABLE `waste_management_ecm`.`procurement`.`goods_receipt` ADD CONSTRAINT `fk_procurement_goods_receipt_po_line_id` FOREIGN KEY (`po_line_id`) REFERENCES `waste_management_ecm`.`procurement`.`po_line`(`po_line_id`);
ALTER TABLE `waste_management_ecm`.`procurement`.`goods_receipt` ADD CONSTRAINT `fk_procurement_goods_receipt_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `waste_management_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `waste_management_ecm`.`procurement`.`goods_receipt` ADD CONSTRAINT `fk_procurement_goods_receipt_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `waste_management_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `waste_management_ecm`.`procurement`.`service_entry_sheet` ADD CONSTRAINT `fk_procurement_service_entry_sheet_po_line_id` FOREIGN KEY (`po_line_id`) REFERENCES `waste_management_ecm`.`procurement`.`po_line`(`po_line_id`);
ALTER TABLE `waste_management_ecm`.`procurement`.`service_entry_sheet` ADD CONSTRAINT `fk_procurement_service_entry_sheet_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `waste_management_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `waste_management_ecm`.`procurement`.`service_entry_sheet` ADD CONSTRAINT `fk_procurement_service_entry_sheet_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `waste_management_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_invoice` ADD CONSTRAINT `fk_procurement_vendor_invoice_goods_receipt_id` FOREIGN KEY (`goods_receipt_id`) REFERENCES `waste_management_ecm`.`procurement`.`goods_receipt`(`goods_receipt_id`);
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_invoice` ADD CONSTRAINT `fk_procurement_vendor_invoice_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `waste_management_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_invoice` ADD CONSTRAINT `fk_procurement_vendor_invoice_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `waste_management_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_invoice_line` ADD CONSTRAINT `fk_procurement_vendor_invoice_line_goods_receipt_id` FOREIGN KEY (`goods_receipt_id`) REFERENCES `waste_management_ecm`.`procurement`.`goods_receipt`(`goods_receipt_id`);
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_invoice_line` ADD CONSTRAINT `fk_procurement_vendor_invoice_line_material_id` FOREIGN KEY (`material_id`) REFERENCES `waste_management_ecm`.`procurement`.`material`(`material_id`);
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_invoice_line` ADD CONSTRAINT `fk_procurement_vendor_invoice_line_po_line_id` FOREIGN KEY (`po_line_id`) REFERENCES `waste_management_ecm`.`procurement`.`po_line`(`po_line_id`);
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_invoice_line` ADD CONSTRAINT `fk_procurement_vendor_invoice_line_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `waste_management_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_invoice_line` ADD CONSTRAINT `fk_procurement_vendor_invoice_line_service_entry_sheet_id` FOREIGN KEY (`service_entry_sheet_id`) REFERENCES `waste_management_ecm`.`procurement`.`service_entry_sheet`(`service_entry_sheet_id`);
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_invoice_line` ADD CONSTRAINT `fk_procurement_vendor_invoice_line_vendor_invoice_id` FOREIGN KEY (`vendor_invoice_id`) REFERENCES `waste_management_ecm`.`procurement`.`vendor_invoice`(`vendor_invoice_id`);
ALTER TABLE `waste_management_ecm`.`procurement`.`ap_payment` ADD CONSTRAINT `fk_procurement_ap_payment_bank_account_id` FOREIGN KEY (`bank_account_id`) REFERENCES `waste_management_ecm`.`procurement`.`bank_account`(`bank_account_id`);
ALTER TABLE `waste_management_ecm`.`procurement`.`ap_payment` ADD CONSTRAINT `fk_procurement_ap_payment_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `waste_management_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `waste_management_ecm`.`procurement`.`ap_payment` ADD CONSTRAINT `fk_procurement_ap_payment_vendor_invoice_id` FOREIGN KEY (`vendor_invoice_id`) REFERENCES `waste_management_ecm`.`procurement`.`vendor_invoice`(`vendor_invoice_id`);
ALTER TABLE `waste_management_ecm`.`procurement`.`sourcing_contract` ADD CONSTRAINT `fk_procurement_sourcing_contract_material_group_id` FOREIGN KEY (`material_group_id`) REFERENCES `waste_management_ecm`.`procurement`.`material_group`(`material_group_id`);
ALTER TABLE `waste_management_ecm`.`procurement`.`sourcing_contract` ADD CONSTRAINT `fk_procurement_sourcing_contract_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `waste_management_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `waste_management_ecm`.`procurement`.`sourcing_contract_line` ADD CONSTRAINT `fk_procurement_sourcing_contract_line_material_id` FOREIGN KEY (`material_id`) REFERENCES `waste_management_ecm`.`procurement`.`material`(`material_id`);
ALTER TABLE `waste_management_ecm`.`procurement`.`sourcing_contract_line` ADD CONSTRAINT `fk_procurement_sourcing_contract_line_sourcing_contract_id` FOREIGN KEY (`sourcing_contract_id`) REFERENCES `waste_management_ecm`.`procurement`.`sourcing_contract`(`sourcing_contract_id`);
ALTER TABLE `waste_management_ecm`.`procurement`.`rfq` ADD CONSTRAINT `fk_procurement_rfq_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `waste_management_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `waste_management_ecm`.`procurement`.`rfq` ADD CONSTRAINT `fk_procurement_rfq_material_group_id` FOREIGN KEY (`material_group_id`) REFERENCES `waste_management_ecm`.`procurement`.`material_group`(`material_group_id`);
ALTER TABLE `waste_management_ecm`.`procurement`.`rfq` ADD CONSTRAINT `fk_procurement_rfq_purchase_requisition_id` FOREIGN KEY (`purchase_requisition_id`) REFERENCES `waste_management_ecm`.`procurement`.`purchase_requisition`(`purchase_requisition_id`);
ALTER TABLE `waste_management_ecm`.`procurement`.`rfq` ADD CONSTRAINT `fk_procurement_rfq_sourcing_event_id` FOREIGN KEY (`sourcing_event_id`) REFERENCES `waste_management_ecm`.`procurement`.`sourcing_event`(`sourcing_event_id`);
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_quote` ADD CONSTRAINT `fk_procurement_vendor_quote_material_id` FOREIGN KEY (`material_id`) REFERENCES `waste_management_ecm`.`procurement`.`material`(`material_id`);
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_quote` ADD CONSTRAINT `fk_procurement_vendor_quote_rfq_id` FOREIGN KEY (`rfq_id`) REFERENCES `waste_management_ecm`.`procurement`.`rfq`(`rfq_id`);
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_quote` ADD CONSTRAINT `fk_procurement_vendor_quote_vendor_contact_id` FOREIGN KEY (`vendor_contact_id`) REFERENCES `waste_management_ecm`.`procurement`.`vendor_contact`(`vendor_contact_id`);
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_quote` ADD CONSTRAINT `fk_procurement_vendor_quote_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `waste_management_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `waste_management_ecm`.`procurement`.`info_record` ADD CONSTRAINT `fk_procurement_info_record_material_id` FOREIGN KEY (`material_id`) REFERENCES `waste_management_ecm`.`procurement`.`material`(`material_id`);
ALTER TABLE `waste_management_ecm`.`procurement`.`info_record` ADD CONSTRAINT `fk_procurement_info_record_sourcing_contract_id` FOREIGN KEY (`sourcing_contract_id`) REFERENCES `waste_management_ecm`.`procurement`.`sourcing_contract`(`sourcing_contract_id`);
ALTER TABLE `waste_management_ecm`.`procurement`.`info_record` ADD CONSTRAINT `fk_procurement_info_record_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `waste_management_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `waste_management_ecm`.`procurement`.`source_list` ADD CONSTRAINT `fk_procurement_source_list_info_record_id` FOREIGN KEY (`info_record_id`) REFERENCES `waste_management_ecm`.`procurement`.`info_record`(`info_record_id`);
ALTER TABLE `waste_management_ecm`.`procurement`.`source_list` ADD CONSTRAINT `fk_procurement_source_list_material_id` FOREIGN KEY (`material_id`) REFERENCES `waste_management_ecm`.`procurement`.`material`(`material_id`);
ALTER TABLE `waste_management_ecm`.`procurement`.`source_list` ADD CONSTRAINT `fk_procurement_source_list_sourcing_contract_id` FOREIGN KEY (`sourcing_contract_id`) REFERENCES `waste_management_ecm`.`procurement`.`sourcing_contract`(`sourcing_contract_id`);
ALTER TABLE `waste_management_ecm`.`procurement`.`source_list` ADD CONSTRAINT `fk_procurement_source_list_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `waste_management_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `waste_management_ecm`.`procurement`.`spend_category` ADD CONSTRAINT `fk_procurement_spend_category_parent_category_spend_category_id` FOREIGN KEY (`parent_category_spend_category_id`) REFERENCES `waste_management_ecm`.`procurement`.`spend_category`(`spend_category_id`);
ALTER TABLE `waste_management_ecm`.`procurement`.`approval_workflow` ADD CONSTRAINT `fk_procurement_approval_workflow_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `waste_management_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `waste_management_ecm`.`procurement`.`approval_workflow` ADD CONSTRAINT `fk_procurement_approval_workflow_rfq_id` FOREIGN KEY (`rfq_id`) REFERENCES `waste_management_ecm`.`procurement`.`rfq`(`rfq_id`);
ALTER TABLE `waste_management_ecm`.`procurement`.`approval_workflow` ADD CONSTRAINT `fk_procurement_approval_workflow_sourcing_contract_id` FOREIGN KEY (`sourcing_contract_id`) REFERENCES `waste_management_ecm`.`procurement`.`sourcing_contract`(`sourcing_contract_id`);
ALTER TABLE `waste_management_ecm`.`procurement`.`invoice_exception` ADD CONSTRAINT `fk_procurement_invoice_exception_goods_receipt_id` FOREIGN KEY (`goods_receipt_id`) REFERENCES `waste_management_ecm`.`procurement`.`goods_receipt`(`goods_receipt_id`);
ALTER TABLE `waste_management_ecm`.`procurement`.`invoice_exception` ADD CONSTRAINT `fk_procurement_invoice_exception_material_id` FOREIGN KEY (`material_id`) REFERENCES `waste_management_ecm`.`procurement`.`material`(`material_id`);
ALTER TABLE `waste_management_ecm`.`procurement`.`invoice_exception` ADD CONSTRAINT `fk_procurement_invoice_exception_po_line_id` FOREIGN KEY (`po_line_id`) REFERENCES `waste_management_ecm`.`procurement`.`po_line`(`po_line_id`);
ALTER TABLE `waste_management_ecm`.`procurement`.`invoice_exception` ADD CONSTRAINT `fk_procurement_invoice_exception_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `waste_management_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `waste_management_ecm`.`procurement`.`invoice_exception` ADD CONSTRAINT `fk_procurement_invoice_exception_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `waste_management_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `waste_management_ecm`.`procurement`.`invoice_exception` ADD CONSTRAINT `fk_procurement_invoice_exception_vendor_invoice_id` FOREIGN KEY (`vendor_invoice_id`) REFERENCES `waste_management_ecm`.`procurement`.`vendor_invoice`(`vendor_invoice_id`);
ALTER TABLE `waste_management_ecm`.`procurement`.`fuel_purchase` ADD CONSTRAINT `fk_procurement_fuel_purchase_goods_receipt_id` FOREIGN KEY (`goods_receipt_id`) REFERENCES `waste_management_ecm`.`procurement`.`goods_receipt`(`goods_receipt_id`);
ALTER TABLE `waste_management_ecm`.`procurement`.`fuel_purchase` ADD CONSTRAINT `fk_procurement_fuel_purchase_material_id` FOREIGN KEY (`material_id`) REFERENCES `waste_management_ecm`.`procurement`.`material`(`material_id`);
ALTER TABLE `waste_management_ecm`.`procurement`.`fuel_purchase` ADD CONSTRAINT `fk_procurement_fuel_purchase_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `waste_management_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `waste_management_ecm`.`procurement`.`fuel_purchase` ADD CONSTRAINT `fk_procurement_fuel_purchase_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `waste_management_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `waste_management_ecm`.`procurement`.`disposal_purchase_order` ADD CONSTRAINT `fk_procurement_disposal_purchase_order_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `waste_management_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `waste_management_ecm`.`procurement`.`purchasing_info_record` ADD CONSTRAINT `fk_procurement_purchasing_info_record_info_record_id` FOREIGN KEY (`info_record_id`) REFERENCES `waste_management_ecm`.`procurement`.`info_record`(`info_record_id`);
ALTER TABLE `waste_management_ecm`.`procurement`.`purchasing_info_record` ADD CONSTRAINT `fk_procurement_purchasing_info_record_material_id` FOREIGN KEY (`material_id`) REFERENCES `waste_management_ecm`.`procurement`.`material`(`material_id`);
ALTER TABLE `waste_management_ecm`.`procurement`.`purchasing_info_record` ADD CONSTRAINT `fk_procurement_purchasing_info_record_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `waste_management_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_waste_stream_approval` ADD CONSTRAINT `fk_procurement_vendor_waste_stream_approval_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `waste_management_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `waste_management_ecm`.`procurement`.`bank_account` ADD CONSTRAINT `fk_procurement_bank_account_legal_entity_id` FOREIGN KEY (`legal_entity_id`) REFERENCES `waste_management_ecm`.`procurement`.`legal_entity`(`legal_entity_id`);
ALTER TABLE `waste_management_ecm`.`procurement`.`bank_account` ADD CONSTRAINT `fk_procurement_bank_account_superseded_bank_account_id` FOREIGN KEY (`superseded_bank_account_id`) REFERENCES `waste_management_ecm`.`procurement`.`bank_account`(`bank_account_id`);
ALTER TABLE `waste_management_ecm`.`procurement`.`sourcing_event` ADD CONSTRAINT `fk_procurement_sourcing_event_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `waste_management_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `waste_management_ecm`.`procurement`.`sourcing_event` ADD CONSTRAINT `fk_procurement_sourcing_event_rebid_sourcing_event_id` FOREIGN KEY (`rebid_sourcing_event_id`) REFERENCES `waste_management_ecm`.`procurement`.`sourcing_event`(`sourcing_event_id`);

-- ========= TAGS =========
ALTER SCHEMA `waste_management_ecm`.`procurement` SET TAGS ('dbx_division' = 'corporate');
ALTER SCHEMA `waste_management_ecm`.`procurement` SET TAGS ('dbx_domain' = 'procurement');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor` SET TAGS ('dbx_subdomain' = 'supplier_management');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor` ALTER COLUMN `accounts_payable_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Accounts Payable (AP) Contact Email');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor` ALTER COLUMN `accounts_payable_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor` ALTER COLUMN `accounts_payable_contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor` ALTER COLUMN `accounts_payable_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor` ALTER COLUMN `accounts_payable_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Accounts Payable (AP) Contact Name');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor` ALTER COLUMN `accounts_payable_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor` ALTER COLUMN `accounts_payable_contact_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor` ALTER COLUMN `address_line_1` SET TAGS ('dbx_business_glossary_term' = 'Address Line 1');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor` ALTER COLUMN `address_line_1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor` ALTER COLUMN `address_line_1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor` ALTER COLUMN `address_line_2` SET TAGS ('dbx_business_glossary_term' = 'Address Line 2');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor` ALTER COLUMN `address_line_2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor` ALTER COLUMN `address_line_2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor` ALTER COLUMN `approved_date` SET TAGS ('dbx_business_glossary_term' = 'Approved Date');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor` ALTER COLUMN `classification` SET TAGS ('dbx_business_glossary_term' = 'Vendor Classification');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor` ALTER COLUMN `duns_number` SET TAGS ('dbx_business_glossary_term' = 'Data Universal Numbering System (DUNS) Number');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor` ALTER COLUMN `duns_number` SET TAGS ('dbx_value_regex' = '^[0-9]{9}$');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor` ALTER COLUMN `email_address` SET TAGS ('dbx_business_glossary_term' = 'Email Address');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor` ALTER COLUMN `email_address` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor` ALTER COLUMN `email_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor` ALTER COLUMN `fax_number` SET TAGS ('dbx_business_glossary_term' = 'Fax Number');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor` ALTER COLUMN `fax_number` SET TAGS ('dbx_value_regex' = '^+?[0-9]{10,15}$');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor` ALTER COLUMN `fax_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor` ALTER COLUMN `fax_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor` ALTER COLUMN `insurance_certificate_on_file_flag` SET TAGS ('dbx_business_glossary_term' = 'Insurance Certificate on File Flag');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor` ALTER COLUMN `insurance_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Insurance Expiration Date');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor` ALTER COLUMN `minority_owned_flag` SET TAGS ('dbx_business_glossary_term' = 'Minority-Owned Business Flag');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor` ALTER COLUMN `name_2` SET TAGS ('dbx_business_glossary_term' = 'Vendor Name Line 2');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor` ALTER COLUMN `onboarding_status` SET TAGS ('dbx_business_glossary_term' = 'Onboarding Status');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor` ALTER COLUMN `onboarding_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|documents_pending|approved|rejected');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'ach|wire|check|credit_card|procurement_card');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor` ALTER COLUMN `payment_terms_code` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms Code');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor` ALTER COLUMN `payment_terms_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,4}$');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor` ALTER COLUMN `performance_rating` SET TAGS ('dbx_business_glossary_term' = 'Vendor Performance Rating');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor` ALTER COLUMN `performance_rating` SET TAGS ('dbx_value_regex' = 'excellent|good|satisfactory|needs_improvement|poor|not_rated');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor` ALTER COLUMN `phone_number` SET TAGS ('dbx_business_glossary_term' = 'Phone Number');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor` ALTER COLUMN `phone_number` SET TAGS ('dbx_value_regex' = '^+?[0-9]{10,15}$');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor` ALTER COLUMN `phone_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor` ALTER COLUMN `postal_code` SET TAGS ('dbx_value_regex' = '^[0-9]{5}(-[0-9]{4})?$');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Email');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Name');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Phone');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_value_regex' = '^+?[0-9]{10,15}$');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor` ALTER COLUMN `primary_contact_title` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Title');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor` ALTER COLUMN `small_business_flag` SET TAGS ('dbx_business_glossary_term' = 'Small Business Flag');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'State or Province');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor` ALTER COLUMN `state_province` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor` ALTER COLUMN `tax_classification` SET TAGS ('dbx_business_glossary_term' = 'Tax Classification');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_business_glossary_term' = 'Tax Identification Number (TIN)');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_value_regex' = '^[0-9]{2}-[0-9]{7}$');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor` ALTER COLUMN `vendor_name` SET TAGS ('dbx_business_glossary_term' = 'Vendor Name');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor` ALTER COLUMN `vendor_number` SET TAGS ('dbx_business_glossary_term' = 'Vendor Number');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor` ALTER COLUMN `vendor_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,10}$');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor` ALTER COLUMN `vendor_status` SET TAGS ('dbx_business_glossary_term' = 'Vendor Status');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor` ALTER COLUMN `vendor_status` SET TAGS ('dbx_value_regex' = 'active|inactive|blocked|pending_approval|suspended');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor` ALTER COLUMN `vendor_type` SET TAGS ('dbx_business_glossary_term' = 'Vendor Type');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor` ALTER COLUMN `vendor_type` SET TAGS ('dbx_value_regex' = 'goods|services|both');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor` ALTER COLUMN `veteran_owned_flag` SET TAGS ('dbx_business_glossary_term' = 'Veteran-Owned Business Flag');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor` ALTER COLUMN `w9_on_file_flag` SET TAGS ('dbx_business_glossary_term' = 'W-9 Form on File Flag');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor` ALTER COLUMN `website_url` SET TAGS ('dbx_business_glossary_term' = 'Website URL');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor` ALTER COLUMN `woman_owned_flag` SET TAGS ('dbx_business_glossary_term' = 'Woman-Owned Business Flag');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_contact` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_contact` SET TAGS ('dbx_subdomain' = 'supplier_management');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_contact` ALTER COLUMN `vendor_contact_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Contact ID');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_contact` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_contact` ALTER COLUMN `address_line_1` SET TAGS ('dbx_business_glossary_term' = 'Address Line 1');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_contact` ALTER COLUMN `address_line_1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_contact` ALTER COLUMN `address_line_1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_contact` ALTER COLUMN `address_line_2` SET TAGS ('dbx_business_glossary_term' = 'Address Line 2');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_contact` ALTER COLUMN `address_line_2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_contact` ALTER COLUMN `address_line_2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_contact` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_contact` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_contact` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_contact` ALTER COLUMN `contact_status` SET TAGS ('dbx_business_glossary_term' = 'Contact Status');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_contact` ALTER COLUMN `contact_status` SET TAGS ('dbx_value_regex' = 'active|inactive|on_leave|terminated');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_contact` ALTER COLUMN `contact_type` SET TAGS ('dbx_business_glossary_term' = 'Contact Type');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_contact` ALTER COLUMN `contact_type` SET TAGS ('dbx_value_regex' = 'account_manager|sales_representative|technical_support|compliance_officer|emergency_contact|billing_contact');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_contact` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_contact` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_contact` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_contact` ALTER COLUMN `department` SET TAGS ('dbx_business_glossary_term' = 'Department');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_contact` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_contact` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_contact` ALTER COLUMN `email_address` SET TAGS ('dbx_business_glossary_term' = 'Email Address');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_contact` ALTER COLUMN `email_address` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_contact` ALTER COLUMN `email_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_contact` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_contact` ALTER COLUMN `extension` SET TAGS ('dbx_business_glossary_term' = 'Phone Extension');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_contact` ALTER COLUMN `fax_number` SET TAGS ('dbx_business_glossary_term' = 'Fax Number');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_contact` ALTER COLUMN `fax_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_contact` ALTER COLUMN `fax_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_contact` ALTER COLUMN `first_name` SET TAGS ('dbx_business_glossary_term' = 'Contact First Name');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_contact` ALTER COLUMN `first_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_contact` ALTER COLUMN `first_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_contact` ALTER COLUMN `full_name` SET TAGS ('dbx_business_glossary_term' = 'Contact Full Name');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_contact` ALTER COLUMN `full_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_contact` ALTER COLUMN `full_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_contact` ALTER COLUMN `is_authorized_signer` SET TAGS ('dbx_business_glossary_term' = 'Is Authorized Signer Flag');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_contact` ALTER COLUMN `is_emergency_contact` SET TAGS ('dbx_business_glossary_term' = 'Is Emergency Contact Flag');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_contact` ALTER COLUMN `is_primary_contact` SET TAGS ('dbx_business_glossary_term' = 'Is Primary Contact Flag');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_contact` ALTER COLUMN `job_title` SET TAGS ('dbx_business_glossary_term' = 'Job Title');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_contact` ALTER COLUMN `language_code` SET TAGS ('dbx_business_glossary_term' = 'Language Code');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_contact` ALTER COLUMN `language_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_contact` ALTER COLUMN `last_contact_date` SET TAGS ('dbx_business_glossary_term' = 'Last Contact Date');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_contact` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_contact` ALTER COLUMN `last_name` SET TAGS ('dbx_business_glossary_term' = 'Contact Last Name');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_contact` ALTER COLUMN `last_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_contact` ALTER COLUMN `last_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_contact` ALTER COLUMN `middle_name` SET TAGS ('dbx_business_glossary_term' = 'Contact Middle Name');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_contact` ALTER COLUMN `middle_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_contact` ALTER COLUMN `middle_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_contact` ALTER COLUMN `mobile_phone_number` SET TAGS ('dbx_business_glossary_term' = 'Mobile Phone Number');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_contact` ALTER COLUMN `mobile_phone_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_contact` ALTER COLUMN `mobile_phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_contact` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Contact Notes');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_contact` ALTER COLUMN `phone_number` SET TAGS ('dbx_business_glossary_term' = 'Phone Number');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_contact` ALTER COLUMN `phone_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_contact` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_contact` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_contact` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_contact` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_contact` ALTER COLUMN `preferred_communication_channel` SET TAGS ('dbx_business_glossary_term' = 'Preferred Communication Channel');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_contact` ALTER COLUMN `preferred_communication_channel` SET TAGS ('dbx_value_regex' = 'email|phone|mobile|fax|portal');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_contact` ALTER COLUMN `secondary_email_address` SET TAGS ('dbx_business_glossary_term' = 'Secondary Email Address');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_contact` ALTER COLUMN `secondary_email_address` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_contact` ALTER COLUMN `secondary_email_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_contact` ALTER COLUMN `secondary_email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_contact` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'State or Province');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_contact` ALTER COLUMN `state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_contact` ALTER COLUMN `state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_contact` ALTER COLUMN `time_zone` SET TAGS ('dbx_business_glossary_term' = 'Time Zone');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_certification` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_certification` SET TAGS ('dbx_subdomain' = 'supplier_management');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_certification` ALTER COLUMN `vendor_certification_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Certification Identifier (ID)');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_certification` ALTER COLUMN `document_id` SET TAGS ('dbx_business_glossary_term' = 'Attachment Document Identifier (ID)');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_certification` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Verified By User Identifier (ID)');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_certification` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_certification` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_certification` ALTER COLUMN `tertiary_vendor_last_modified_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User Identifier (ID)');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_certification` ALTER COLUMN `tertiary_vendor_last_modified_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_certification` ALTER COLUMN `tertiary_vendor_last_modified_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_certification` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Identifier (ID)');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_certification` ALTER COLUMN `certificate_holder_name` SET TAGS ('dbx_business_glossary_term' = 'Certificate Holder Name');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_certification` ALTER COLUMN `certification_number` SET TAGS ('dbx_business_glossary_term' = 'Certification Number');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_certification` ALTER COLUMN `certification_scope` SET TAGS ('dbx_business_glossary_term' = 'Certification Scope');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_certification` ALTER COLUMN `certification_status` SET TAGS ('dbx_business_glossary_term' = 'Certification Status');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_certification` ALTER COLUMN `certification_status` SET TAGS ('dbx_value_regex' = 'ACTIVE|EXPIRED|SUSPENDED|PENDING_RENEWAL|REVOKED|PENDING_APPROVAL');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_certification` ALTER COLUMN `certification_type` SET TAGS ('dbx_business_glossary_term' = 'Certification Type');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_certification` ALTER COLUMN `compliance_gate_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Gate Flag');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_certification` ALTER COLUMN `coverage_amount` SET TAGS ('dbx_business_glossary_term' = 'Coverage Amount');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_certification` ALTER COLUMN `coverage_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Coverage Currency Code');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_certification` ALTER COLUMN `coverage_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_certification` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_certification` ALTER COLUMN `deductible_amount` SET TAGS ('dbx_business_glossary_term' = 'Deductible Amount');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_certification` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_certification` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_certification` ALTER COLUMN `issuing_authority` SET TAGS ('dbx_business_glossary_term' = 'Issuing Authority');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_certification` ALTER COLUMN `issuing_authority_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Issuing Authority Jurisdiction');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_certification` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_certification` ALTER COLUMN `last_renewal_date` SET TAGS ('dbx_business_glossary_term' = 'Last Renewal Date');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_certification` ALTER COLUMN `next_renewal_date` SET TAGS ('dbx_business_glossary_term' = 'Next Renewal Date');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_certification` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_certification` ALTER COLUMN `policy_holder_name` SET TAGS ('dbx_business_glossary_term' = 'Policy Holder Name');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_certification` ALTER COLUMN `procurement_category` SET TAGS ('dbx_business_glossary_term' = 'Procurement Category');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_certification` ALTER COLUMN `renewal_alert_threshold_days` SET TAGS ('dbx_business_glossary_term' = 'Renewal Alert Threshold Days');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_certification` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'Verification Date');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_certification` ALTER COLUMN `verification_method` SET TAGS ('dbx_business_glossary_term' = 'Verification Method');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_certification` ALTER COLUMN `verification_method` SET TAGS ('dbx_value_regex' = 'DOCUMENT_UPLOAD|THIRD_PARTY_VERIFICATION|REGISTRY_LOOKUP|SELF_ATTESTATION|ON_SITE_AUDIT');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_performance` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_performance` SET TAGS ('dbx_subdomain' = 'supplier_management');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_performance` ALTER COLUMN `vendor_performance_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Performance ID');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_performance` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Evaluator Employee ID');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_performance` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_performance` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_performance` ALTER COLUMN `sourcing_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Sourcing Contract Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_performance` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_performance` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_performance` ALTER COLUMN `contract_compliance_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Contract Compliance Rate Percentage');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_performance` ALTER COLUMN `corrective_action_due_date` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Due Date');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_performance` ALTER COLUMN `corrective_action_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Required Flag');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_performance` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_performance` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_performance` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_performance` ALTER COLUMN `environmental_compliance_violation_count` SET TAGS ('dbx_business_glossary_term' = 'Environmental Compliance Violation Count');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_performance` ALTER COLUMN `evaluation_date` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Date');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_performance` ALTER COLUMN `evaluation_notes` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Notes');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_performance` ALTER COLUMN `evaluation_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Period End Date');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_performance` ALTER COLUMN `evaluation_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Period Start Date');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_performance` ALTER COLUMN `evaluation_status` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Status');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_performance` ALTER COLUMN `evaluation_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|approved|rejected|archived');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_performance` ALTER COLUMN `fill_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Fill Rate Percentage');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_performance` ALTER COLUMN `invoice_accuracy_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Invoice Accuracy Rate Percentage');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_performance` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_performance` ALTER COLUMN `lead_time_days_avg` SET TAGS ('dbx_business_glossary_term' = 'Average Lead Time Days');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_performance` ALTER COLUMN `next_evaluation_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Evaluation Due Date');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_performance` ALTER COLUMN `on_time_delivery_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'On-Time Delivery Rate Percentage');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_performance` ALTER COLUMN `overall_scorecard_rating` SET TAGS ('dbx_business_glossary_term' = 'Overall Scorecard Rating');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_performance` ALTER COLUMN `quality_defect_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Quality Defect Rate Percentage');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_performance` ALTER COLUMN `response_time_days_avg` SET TAGS ('dbx_business_glossary_term' = 'Average Response Time Days');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_performance` ALTER COLUMN `safety_incident_count` SET TAGS ('dbx_business_glossary_term' = 'Safety Incident Count');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_performance` ALTER COLUMN `total_invoice_count_evaluated` SET TAGS ('dbx_business_glossary_term' = 'Total Invoice Count Evaluated');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_performance` ALTER COLUMN `total_purchase_orders_evaluated` SET TAGS ('dbx_business_glossary_term' = 'Total Purchase Orders (PO) Evaluated');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_performance` ALTER COLUMN `total_spend_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Spend Amount');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_performance` ALTER COLUMN `vendor_tier` SET TAGS ('dbx_business_glossary_term' = 'Vendor Tier');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_performance` ALTER COLUMN `vendor_tier` SET TAGS ('dbx_value_regex' = 'preferred|approved|conditional|probation|disqualified');
ALTER TABLE `waste_management_ecm`.`procurement`.`material` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `waste_management_ecm`.`procurement`.`material` SET TAGS ('dbx_subdomain' = 'supplier_management');
ALTER TABLE `waste_management_ecm`.`procurement`.`material` ALTER COLUMN `material_id` SET TAGS ('dbx_business_glossary_term' = 'Material ID');
ALTER TABLE `waste_management_ecm`.`procurement`.`material` ALTER COLUMN `class_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Class Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`procurement`.`material` ALTER COLUMN `waste_stream_id` SET TAGS ('dbx_business_glossary_term' = 'Generated Waste Stream Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`procurement`.`material` ALTER COLUMN `material_group_id` SET TAGS ('dbx_business_glossary_term' = 'Material Group Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`procurement`.`material` ALTER COLUMN `safety_program_id` SET TAGS ('dbx_business_glossary_term' = 'Safety Program Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`procurement`.`material` ALTER COLUMN `abc_indicator` SET TAGS ('dbx_business_glossary_term' = 'ABC Indicator');
ALTER TABLE `waste_management_ecm`.`procurement`.`material` ALTER COLUMN `abc_indicator` SET TAGS ('dbx_value_regex' = 'A|B|C');
ALTER TABLE `waste_management_ecm`.`procurement`.`material` ALTER COLUMN `base_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Base Unit of Measure (UOM)');
ALTER TABLE `waste_management_ecm`.`procurement`.`material` ALTER COLUMN `batch_managed_flag` SET TAGS ('dbx_business_glossary_term' = 'Batch Managed Flag');
ALTER TABLE `waste_management_ecm`.`procurement`.`material` ALTER COLUMN `created_date` SET TAGS ('dbx_business_glossary_term' = 'Created Date');
ALTER TABLE `waste_management_ecm`.`procurement`.`material` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `waste_management_ecm`.`procurement`.`material` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `waste_management_ecm`.`procurement`.`material` ALTER COLUMN `dot_hazard_class` SET TAGS ('dbx_business_glossary_term' = 'Department of Transportation (DOT) Hazard Class');
ALTER TABLE `waste_management_ecm`.`procurement`.`material` ALTER COLUMN `environmental_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Environmental Compliance Flag');
ALTER TABLE `waste_management_ecm`.`procurement`.`material` ALTER COLUMN `gross_weight` SET TAGS ('dbx_business_glossary_term' = 'Gross Weight');
ALTER TABLE `waste_management_ecm`.`procurement`.`material` ALTER COLUMN `hazardous_material_flag` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Material Flag');
ALTER TABLE `waste_management_ecm`.`procurement`.`material` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `waste_management_ecm`.`procurement`.`material` ALTER COLUMN `last_modified_date` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Date');
ALTER TABLE `waste_management_ecm`.`procurement`.`material` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time (Days)');
ALTER TABLE `waste_management_ecm`.`procurement`.`material` ALTER COLUMN `long_description` SET TAGS ('dbx_business_glossary_term' = 'Material Long Description');
ALTER TABLE `waste_management_ecm`.`procurement`.`material` ALTER COLUMN `manufacturer_name` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Name');
ALTER TABLE `waste_management_ecm`.`procurement`.`material` ALTER COLUMN `manufacturer_part_number` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Part Number');
ALTER TABLE `waste_management_ecm`.`procurement`.`material` ALTER COLUMN `material_description` SET TAGS ('dbx_business_glossary_term' = 'Material Description');
ALTER TABLE `waste_management_ecm`.`procurement`.`material` ALTER COLUMN `material_number` SET TAGS ('dbx_business_glossary_term' = 'Material Number');
ALTER TABLE `waste_management_ecm`.`procurement`.`material` ALTER COLUMN `material_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,18}$');
ALTER TABLE `waste_management_ecm`.`procurement`.`material` ALTER COLUMN `material_status` SET TAGS ('dbx_business_glossary_term' = 'Material Status');
ALTER TABLE `waste_management_ecm`.`procurement`.`material` ALTER COLUMN `material_status` SET TAGS ('dbx_value_regex' = 'active|inactive|obsolete|blocked|pending_approval');
ALTER TABLE `waste_management_ecm`.`procurement`.`material` ALTER COLUMN `material_type` SET TAGS ('dbx_business_glossary_term' = 'Material Type');
ALTER TABLE `waste_management_ecm`.`procurement`.`material` ALTER COLUMN `minimum_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity (MOQ)');
ALTER TABLE `waste_management_ecm`.`procurement`.`material` ALTER COLUMN `moving_average_price` SET TAGS ('dbx_business_glossary_term' = 'Moving Average Price (MAP)');
ALTER TABLE `waste_management_ecm`.`procurement`.`material` ALTER COLUMN `moving_average_price` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`procurement`.`material` ALTER COLUMN `net_weight` SET TAGS ('dbx_business_glossary_term' = 'Net Weight');
ALTER TABLE `waste_management_ecm`.`procurement`.`material` ALTER COLUMN `ppe_category` SET TAGS ('dbx_business_glossary_term' = 'Personal Protective Equipment (PPE) Category');
ALTER TABLE `waste_management_ecm`.`procurement`.`material` ALTER COLUMN `procurement_type` SET TAGS ('dbx_business_glossary_term' = 'Procurement Type');
ALTER TABLE `waste_management_ecm`.`procurement`.`material` ALTER COLUMN `procurement_type` SET TAGS ('dbx_value_regex' = 'external|internal|both');
ALTER TABLE `waste_management_ecm`.`procurement`.`material` ALTER COLUMN `purchase_order_unit` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Unit of Measure');
ALTER TABLE `waste_management_ecm`.`procurement`.`material` ALTER COLUMN `rcra_waste_code` SET TAGS ('dbx_business_glossary_term' = 'Resource Conservation and Recovery Act (RCRA) Waste Code');
ALTER TABLE `waste_management_ecm`.`procurement`.`material` ALTER COLUMN `rcra_waste_code` SET TAGS ('dbx_value_regex' = '^[DUFKP][0-9]{3}$');
ALTER TABLE `waste_management_ecm`.`procurement`.`material` ALTER COLUMN `reorder_point` SET TAGS ('dbx_business_glossary_term' = 'Reorder Point');
ALTER TABLE `waste_management_ecm`.`procurement`.`material` ALTER COLUMN `safety_stock_quantity` SET TAGS ('dbx_business_glossary_term' = 'Safety Stock Quantity');
ALTER TABLE `waste_management_ecm`.`procurement`.`material` ALTER COLUMN `serial_number_profile` SET TAGS ('dbx_business_glossary_term' = 'Serial Number Profile');
ALTER TABLE `waste_management_ecm`.`procurement`.`material` ALTER COLUMN `shelf_life_days` SET TAGS ('dbx_business_glossary_term' = 'Shelf Life (Days)');
ALTER TABLE `waste_management_ecm`.`procurement`.`material` ALTER COLUMN `standard_cost` SET TAGS ('dbx_business_glossary_term' = 'Standard Cost');
ALTER TABLE `waste_management_ecm`.`procurement`.`material` ALTER COLUMN `standard_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`procurement`.`material` ALTER COLUMN `storage_class` SET TAGS ('dbx_business_glossary_term' = 'Storage Class');
ALTER TABLE `waste_management_ecm`.`procurement`.`material` ALTER COLUMN `un_number` SET TAGS ('dbx_business_glossary_term' = 'United Nations (UN) Number');
ALTER TABLE `waste_management_ecm`.`procurement`.`material` ALTER COLUMN `un_number` SET TAGS ('dbx_value_regex' = '^UN[0-9]{4}$');
ALTER TABLE `waste_management_ecm`.`procurement`.`material` ALTER COLUMN `volume` SET TAGS ('dbx_business_glossary_term' = 'Volume');
ALTER TABLE `waste_management_ecm`.`procurement`.`material` ALTER COLUMN `volume_unit` SET TAGS ('dbx_business_glossary_term' = 'Volume Unit of Measure');
ALTER TABLE `waste_management_ecm`.`procurement`.`material` ALTER COLUMN `volume_unit` SET TAGS ('dbx_value_regex' = 'GAL|L|FT3|M3|IN3');
ALTER TABLE `waste_management_ecm`.`procurement`.`material` ALTER COLUMN `weight_unit` SET TAGS ('dbx_business_glossary_term' = 'Weight Unit of Measure');
ALTER TABLE `waste_management_ecm`.`procurement`.`material` ALTER COLUMN `weight_unit` SET TAGS ('dbx_value_regex' = 'LB|KG|TON|G|OZ');
ALTER TABLE `waste_management_ecm`.`procurement`.`material` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `waste_management_ecm`.`procurement`.`material_group` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `waste_management_ecm`.`procurement`.`material_group` SET TAGS ('dbx_subdomain' = 'supplier_management');
ALTER TABLE `waste_management_ecm`.`procurement`.`material_group` ALTER COLUMN `material_group_id` SET TAGS ('dbx_business_glossary_term' = 'Material Group ID');
ALTER TABLE `waste_management_ecm`.`procurement`.`material_group` ALTER COLUMN `parent_material_group_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Material Group ID');
ALTER TABLE `waste_management_ecm`.`procurement`.`material_group` ALTER COLUMN `active_flag` SET TAGS ('dbx_business_glossary_term' = 'Active Flag');
ALTER TABLE `waste_management_ecm`.`procurement`.`material_group` ALTER COLUMN `approval_workflow_code` SET TAGS ('dbx_business_glossary_term' = 'Approval Workflow Code');
ALTER TABLE `waste_management_ecm`.`procurement`.`material_group` ALTER COLUMN `approval_workflow_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{3,20}$');
ALTER TABLE `waste_management_ecm`.`procurement`.`material_group` ALTER COLUMN `carbon_footprint_category` SET TAGS ('dbx_business_glossary_term' = 'Carbon Footprint Category');
ALTER TABLE `waste_management_ecm`.`procurement`.`material_group` ALTER COLUMN `carbon_footprint_category` SET TAGS ('dbx_value_regex' = 'Low|Medium|High|Not Assessed');
ALTER TABLE `waste_management_ecm`.`procurement`.`material_group` ALTER COLUMN `commodity_code` SET TAGS ('dbx_business_glossary_term' = 'Commodity Code (UNSPSC)');
ALTER TABLE `waste_management_ecm`.`procurement`.`material_group` ALTER COLUMN `commodity_code` SET TAGS ('dbx_value_regex' = '^[0-9]{8,10}$');
ALTER TABLE `waste_management_ecm`.`procurement`.`material_group` ALTER COLUMN `contract_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Contract Required Flag');
ALTER TABLE `waste_management_ecm`.`procurement`.`material_group` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `waste_management_ecm`.`procurement`.`material_group` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `waste_management_ecm`.`procurement`.`material_group` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `waste_management_ecm`.`procurement`.`material_group` ALTER COLUMN `dot_regulated_indicator` SET TAGS ('dbx_business_glossary_term' = 'Department of Transportation (DOT) Regulated Indicator');
ALTER TABLE `waste_management_ecm`.`procurement`.`material_group` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `waste_management_ecm`.`procurement`.`material_group` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `waste_management_ecm`.`procurement`.`material_group` ALTER COLUMN `epa_regulated_indicator` SET TAGS ('dbx_business_glossary_term' = 'Environmental Protection Agency (EPA) Regulated Indicator');
ALTER TABLE `waste_management_ecm`.`procurement`.`material_group` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `waste_management_ecm`.`procurement`.`material_group` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_value_regex' = '^[0-9]{6,10}$');
ALTER TABLE `waste_management_ecm`.`procurement`.`material_group` ALTER COLUMN `hazmat_indicator` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Material (HAZMAT) Indicator');
ALTER TABLE `waste_management_ecm`.`procurement`.`material_group` ALTER COLUMN `hierarchy_level` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Level');
ALTER TABLE `waste_management_ecm`.`procurement`.`material_group` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `waste_management_ecm`.`procurement`.`material_group` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `waste_management_ecm`.`procurement`.`material_group` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time (Days)');
ALTER TABLE `waste_management_ecm`.`procurement`.`material_group` ALTER COLUMN `material_group_code` SET TAGS ('dbx_business_glossary_term' = 'Material Group Code (MATKL)');
ALTER TABLE `waste_management_ecm`.`procurement`.`material_group` ALTER COLUMN `material_group_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `waste_management_ecm`.`procurement`.`material_group` ALTER COLUMN `material_group_description` SET TAGS ('dbx_business_glossary_term' = 'Material Group Description');
ALTER TABLE `waste_management_ecm`.`procurement`.`material_group` ALTER COLUMN `material_group_name` SET TAGS ('dbx_business_glossary_term' = 'Material Group Name');
ALTER TABLE `waste_management_ecm`.`procurement`.`material_group` ALTER COLUMN `material_type` SET TAGS ('dbx_business_glossary_term' = 'Material Type (SAP MTART)');
ALTER TABLE `waste_management_ecm`.`procurement`.`material_group` ALTER COLUMN `minimum_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity (MOQ)');
ALTER TABLE `waste_management_ecm`.`procurement`.`material_group` ALTER COLUMN `osha_ppe_required_indicator` SET TAGS ('dbx_business_glossary_term' = 'Occupational Safety and Health Administration (OSHA) Personal Protective Equipment (PPE) Required Indicator');
ALTER TABLE `waste_management_ecm`.`procurement`.`material_group` ALTER COLUMN `procurement_type` SET TAGS ('dbx_business_glossary_term' = 'Procurement Type');
ALTER TABLE `waste_management_ecm`.`procurement`.`material_group` ALTER COLUMN `procurement_type` SET TAGS ('dbx_value_regex' = 'Direct Material|Indirect Material|Services|Capital Equipment|MRO|Subcontracting');
ALTER TABLE `waste_management_ecm`.`procurement`.`material_group` ALTER COLUMN `purchasing_group_code` SET TAGS ('dbx_business_glossary_term' = 'Purchasing Group Code');
ALTER TABLE `waste_management_ecm`.`procurement`.`material_group` ALTER COLUMN `purchasing_group_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,6}$');
ALTER TABLE `waste_management_ecm`.`procurement`.`material_group` ALTER COLUMN `shelf_life_days` SET TAGS ('dbx_business_glossary_term' = 'Shelf Life (Days)');
ALTER TABLE `waste_management_ecm`.`procurement`.`material_group` ALTER COLUMN `sort_order` SET TAGS ('dbx_business_glossary_term' = 'Sort Order');
ALTER TABLE `waste_management_ecm`.`procurement`.`material_group` ALTER COLUMN `spend_category` SET TAGS ('dbx_business_glossary_term' = 'Spend Category');
ALTER TABLE `waste_management_ecm`.`procurement`.`material_group` ALTER COLUMN `storage_condition_code` SET TAGS ('dbx_business_glossary_term' = 'Storage Condition Code');
ALTER TABLE `waste_management_ecm`.`procurement`.`material_group` ALTER COLUMN `strategic_sourcing_flag` SET TAGS ('dbx_business_glossary_term' = 'Strategic Sourcing Flag');
ALTER TABLE `waste_management_ecm`.`procurement`.`material_group` ALTER COLUMN `supplier_diversity_flag` SET TAGS ('dbx_business_glossary_term' = 'Supplier Diversity Flag');
ALTER TABLE `waste_management_ecm`.`procurement`.`material_group` ALTER COLUMN `sustainability_category` SET TAGS ('dbx_business_glossary_term' = 'Sustainability Category');
ALTER TABLE `waste_management_ecm`.`procurement`.`material_group` ALTER COLUMN `tax_classification_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Classification Code');
ALTER TABLE `waste_management_ecm`.`procurement`.`material_group` ALTER COLUMN `tax_classification_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,4}$');
ALTER TABLE `waste_management_ecm`.`procurement`.`material_group` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `waste_management_ecm`.`procurement`.`material_group` ALTER COLUMN `valuation_class` SET TAGS ('dbx_business_glossary_term' = 'Valuation Class');
ALTER TABLE `waste_management_ecm`.`procurement`.`material_group` ALTER COLUMN `valuation_class` SET TAGS ('dbx_value_regex' = '^[0-9]{4}$');
ALTER TABLE `waste_management_ecm`.`procurement`.`material_group` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `waste_management_ecm`.`procurement`.`purchase_requisition` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `waste_management_ecm`.`procurement`.`purchase_requisition` SET TAGS ('dbx_subdomain' = 'order_processing');
ALTER TABLE `waste_management_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `purchase_requisition_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Requisition (PR) ID');
ALTER TABLE `waste_management_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approver Employee ID');
ALTER TABLE `waste_management_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `waste_management_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `material_group_id` SET TAGS ('dbx_business_glossary_term' = 'Material Group Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `material_id` SET TAGS ('dbx_business_glossary_term' = 'Material Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `requester_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Requester Employee ID');
ALTER TABLE `waste_management_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `requester_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `requester_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `waste_management_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `waste_management_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `asset_number` SET TAGS ('dbx_business_glossary_term' = 'Asset Number');
ALTER TABLE `waste_management_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `asset_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,12}$');
ALTER TABLE `waste_management_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `budget_period` SET TAGS ('dbx_business_glossary_term' = 'Budget Period');
ALTER TABLE `waste_management_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `budget_year` SET TAGS ('dbx_business_glossary_term' = 'Budget Year');
ALTER TABLE `waste_management_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `contract_number` SET TAGS ('dbx_business_glossary_term' = 'Contract Number');
ALTER TABLE `waste_management_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `contract_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{10,20}$');
ALTER TABLE `waste_management_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `waste_management_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_value_regex' = '^[0-9]{6,10}$');
ALTER TABLE `waste_management_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `waste_management_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `waste_management_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `waste_management_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `estimated_total_value` SET TAGS ('dbx_business_glossary_term' = 'Estimated Total Value');
ALTER TABLE `waste_management_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `estimated_unit_price` SET TAGS ('dbx_business_glossary_term' = 'Estimated Unit Price');
ALTER TABLE `waste_management_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `waste_management_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_value_regex' = '^[0-9]{6,10}$');
ALTER TABLE `waste_management_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `internal_order_number` SET TAGS ('dbx_business_glossary_term' = 'Internal Order Number');
ALTER TABLE `waste_management_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `internal_order_number` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `waste_management_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `is_capital_expenditure` SET TAGS ('dbx_business_glossary_term' = 'Is Capital Expenditure (CapEx)');
ALTER TABLE `waste_management_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `is_emergency_purchase` SET TAGS ('dbx_business_glossary_term' = 'Is Emergency Purchase');
ALTER TABLE `waste_management_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `justification` SET TAGS ('dbx_business_glossary_term' = 'Justification');
ALTER TABLE `waste_management_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `waste_management_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `plant_code` SET TAGS ('dbx_business_glossary_term' = 'Plant Code');
ALTER TABLE `waste_management_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `plant_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `waste_management_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `pr_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Requisition (PR) Number');
ALTER TABLE `waste_management_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `pr_number` SET TAGS ('dbx_value_regex' = '^PR[0-9]{10}$');
ALTER TABLE `waste_management_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `pr_status` SET TAGS ('dbx_business_glossary_term' = 'Purchase Requisition (PR) Status');
ALTER TABLE `waste_management_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `pr_type` SET TAGS ('dbx_business_glossary_term' = 'Purchase Requisition (PR) Type');
ALTER TABLE `waste_management_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `pr_type` SET TAGS ('dbx_value_regex' = 'standard|stock_replenishment|service|subcontracting|consignment|third_party');
ALTER TABLE `waste_management_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `preferred_vendor_code` SET TAGS ('dbx_business_glossary_term' = 'Preferred Vendor Code');
ALTER TABLE `waste_management_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `preferred_vendor_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,10}$');
ALTER TABLE `waste_management_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `priority_code` SET TAGS ('dbx_business_glossary_term' = 'Priority Code');
ALTER TABLE `waste_management_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `priority_code` SET TAGS ('dbx_value_regex' = 'low|normal|high|urgent|emergency');
ALTER TABLE `waste_management_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `purchase_order_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Number');
ALTER TABLE `waste_management_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `purchase_order_number` SET TAGS ('dbx_value_regex' = '^PO[0-9]{10}$');
ALTER TABLE `waste_management_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `purchasing_group_code` SET TAGS ('dbx_business_glossary_term' = 'Purchasing Group Code');
ALTER TABLE `waste_management_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `purchasing_group_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3}$');
ALTER TABLE `waste_management_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `waste_management_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `waste_management_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `requesting_department_code` SET TAGS ('dbx_business_glossary_term' = 'Requesting Department Code');
ALTER TABLE `waste_management_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `requesting_department_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `waste_management_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `requesting_department_name` SET TAGS ('dbx_business_glossary_term' = 'Requesting Department Name');
ALTER TABLE `waste_management_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `required_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Required Delivery Date');
ALTER TABLE `waste_management_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `requisition_date` SET TAGS ('dbx_business_glossary_term' = 'Requisition Date');
ALTER TABLE `waste_management_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `waste_management_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `storage_location_code` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Code');
ALTER TABLE `waste_management_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `storage_location_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `waste_management_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `waste_management_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,3}$');
ALTER TABLE `waste_management_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `wbs_element` SET TAGS ('dbx_business_glossary_term' = 'Work Breakdown Structure (WBS) Element');
ALTER TABLE `waste_management_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `wbs_element` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{8,24}$');
ALTER TABLE `waste_management_ecm`.`procurement`.`purchase_order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `waste_management_ecm`.`procurement`.`purchase_order` SET TAGS ('dbx_subdomain' = 'order_processing');
ALTER TABLE `waste_management_ecm`.`procurement`.`purchase_order` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) ID');
ALTER TABLE `waste_management_ecm`.`procurement`.`purchase_order` ALTER COLUMN `purchase_requisition_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Requisition Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`procurement`.`purchase_order` ALTER COLUMN `sourcing_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Sourcing Contract Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`procurement`.`purchase_order` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `waste_management_ecm`.`procurement`.`purchase_order` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `waste_management_ecm`.`procurement`.`purchase_order` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `waste_management_ecm`.`procurement`.`purchase_order` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|approved|rejected');
ALTER TABLE `waste_management_ecm`.`procurement`.`purchase_order` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `waste_management_ecm`.`procurement`.`purchase_order` ALTER COLUMN `collective_number` SET TAGS ('dbx_business_glossary_term' = 'Collective Number');
ALTER TABLE `waste_management_ecm`.`procurement`.`purchase_order` ALTER COLUMN `company_code` SET TAGS ('dbx_business_glossary_term' = 'Company Code');
ALTER TABLE `waste_management_ecm`.`procurement`.`purchase_order` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `waste_management_ecm`.`procurement`.`purchase_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `waste_management_ecm`.`procurement`.`purchase_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `waste_management_ecm`.`procurement`.`purchase_order` ALTER COLUMN `deletion_indicator` SET TAGS ('dbx_business_glossary_term' = 'Deletion Indicator');
ALTER TABLE `waste_management_ecm`.`procurement`.`purchase_order` ALTER COLUMN `delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Delivery Date');
ALTER TABLE `waste_management_ecm`.`procurement`.`purchase_order` ALTER COLUMN `document_date` SET TAGS ('dbx_business_glossary_term' = 'Document Date');
ALTER TABLE `waste_management_ecm`.`procurement`.`purchase_order` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate');
ALTER TABLE `waste_management_ecm`.`procurement`.`purchase_order` ALTER COLUMN `goods_receipt_indicator` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt Indicator');
ALTER TABLE `waste_management_ecm`.`procurement`.`purchase_order` ALTER COLUMN `incoterms` SET TAGS ('dbx_business_glossary_term' = 'Incoterms');
ALTER TABLE `waste_management_ecm`.`procurement`.`purchase_order` ALTER COLUMN `incoterms_location` SET TAGS ('dbx_business_glossary_term' = 'Incoterms Location');
ALTER TABLE `waste_management_ecm`.`procurement`.`purchase_order` ALTER COLUMN `invoice_receipt_indicator` SET TAGS ('dbx_business_glossary_term' = 'Invoice Receipt Indicator');
ALTER TABLE `waste_management_ecm`.`procurement`.`purchase_order` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By');
ALTER TABLE `waste_management_ecm`.`procurement`.`purchase_order` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `waste_management_ecm`.`procurement`.`purchase_order` ALTER COLUMN `net_po_value` SET TAGS ('dbx_business_glossary_term' = 'Net Purchase Order (PO) Value');
ALTER TABLE `waste_management_ecm`.`procurement`.`purchase_order` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `waste_management_ecm`.`procurement`.`purchase_order` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `waste_management_ecm`.`procurement`.`purchase_order` ALTER COLUMN `plant` SET TAGS ('dbx_business_glossary_term' = 'Plant');
ALTER TABLE `waste_management_ecm`.`procurement`.`purchase_order` ALTER COLUMN `po_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Number');
ALTER TABLE `waste_management_ecm`.`procurement`.`purchase_order` ALTER COLUMN `po_number` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `waste_management_ecm`.`procurement`.`purchase_order` ALTER COLUMN `po_status` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Status');
ALTER TABLE `waste_management_ecm`.`procurement`.`purchase_order` ALTER COLUMN `po_type` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Type');
ALTER TABLE `waste_management_ecm`.`procurement`.`purchase_order` ALTER COLUMN `po_type` SET TAGS ('dbx_value_regex' = 'standard|blanket|framework|contract|subcontracting|consignment');
ALTER TABLE `waste_management_ecm`.`procurement`.`purchase_order` ALTER COLUMN `purchasing_group` SET TAGS ('dbx_business_glossary_term' = 'Purchasing Group');
ALTER TABLE `waste_management_ecm`.`procurement`.`purchase_order` ALTER COLUMN `purchasing_organization` SET TAGS ('dbx_business_glossary_term' = 'Purchasing Organization');
ALTER TABLE `waste_management_ecm`.`procurement`.`purchase_order` ALTER COLUMN `release_date` SET TAGS ('dbx_business_glossary_term' = 'Release Date');
ALTER TABLE `waste_management_ecm`.`procurement`.`purchase_order` ALTER COLUMN `shipping_instructions` SET TAGS ('dbx_business_glossary_term' = 'Shipping Instructions');
ALTER TABLE `waste_management_ecm`.`procurement`.`purchase_order` ALTER COLUMN `storage_location` SET TAGS ('dbx_business_glossary_term' = 'Storage Location');
ALTER TABLE `waste_management_ecm`.`procurement`.`purchase_order` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `waste_management_ecm`.`procurement`.`purchase_order` ALTER COLUMN `total_po_value` SET TAGS ('dbx_business_glossary_term' = 'Total Purchase Order (PO) Value');
ALTER TABLE `waste_management_ecm`.`procurement`.`purchase_order` ALTER COLUMN `validity_end_date` SET TAGS ('dbx_business_glossary_term' = 'Validity End Date');
ALTER TABLE `waste_management_ecm`.`procurement`.`purchase_order` ALTER COLUMN `validity_start_date` SET TAGS ('dbx_business_glossary_term' = 'Validity Start Date');
ALTER TABLE `waste_management_ecm`.`procurement`.`purchase_order` ALTER COLUMN `vendor_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Vendor Contact Email');
ALTER TABLE `waste_management_ecm`.`procurement`.`purchase_order` ALTER COLUMN `vendor_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `waste_management_ecm`.`procurement`.`purchase_order` ALTER COLUMN `vendor_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`procurement`.`purchase_order` ALTER COLUMN `vendor_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `waste_management_ecm`.`procurement`.`purchase_order` ALTER COLUMN `vendor_contact_person` SET TAGS ('dbx_business_glossary_term' = 'Vendor Contact Person');
ALTER TABLE `waste_management_ecm`.`procurement`.`purchase_order` ALTER COLUMN `vendor_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Vendor Contact Phone');
ALTER TABLE `waste_management_ecm`.`procurement`.`purchase_order` ALTER COLUMN `vendor_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`procurement`.`purchase_order` ALTER COLUMN `vendor_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `waste_management_ecm`.`procurement`.`purchase_order` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `waste_management_ecm`.`procurement`.`po_line` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `waste_management_ecm`.`procurement`.`po_line` SET TAGS ('dbx_subdomain' = 'order_processing');
ALTER TABLE `waste_management_ecm`.`procurement`.`po_line` ALTER COLUMN `po_line_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Line ID');
ALTER TABLE `waste_management_ecm`.`procurement`.`po_line` ALTER COLUMN `material_id` SET TAGS ('dbx_business_glossary_term' = 'Material ID');
ALTER TABLE `waste_management_ecm`.`procurement`.`po_line` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Header ID');
ALTER TABLE `waste_management_ecm`.`procurement`.`po_line` ALTER COLUMN `asset_number` SET TAGS ('dbx_business_glossary_term' = 'Asset Number');
ALTER TABLE `waste_management_ecm`.`procurement`.`po_line` ALTER COLUMN `cost_center` SET TAGS ('dbx_business_glossary_term' = 'Cost Center');
ALTER TABLE `waste_management_ecm`.`procurement`.`po_line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `waste_management_ecm`.`procurement`.`po_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `waste_management_ecm`.`procurement`.`po_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `waste_management_ecm`.`procurement`.`po_line` ALTER COLUMN `deletion_indicator` SET TAGS ('dbx_business_glossary_term' = 'Deletion Indicator');
ALTER TABLE `waste_management_ecm`.`procurement`.`po_line` ALTER COLUMN `delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Delivery Date');
ALTER TABLE `waste_management_ecm`.`procurement`.`po_line` ALTER COLUMN `final_invoice_indicator` SET TAGS ('dbx_business_glossary_term' = 'Final Invoice Indicator');
ALTER TABLE `waste_management_ecm`.`procurement`.`po_line` ALTER COLUMN `gl_account` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account');
ALTER TABLE `waste_management_ecm`.`procurement`.`po_line` ALTER COLUMN `goods_receipt_based_invoice_verification` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt (GR) Based Invoice Verification');
ALTER TABLE `waste_management_ecm`.`procurement`.`po_line` ALTER COLUMN `goods_receipt_indicator` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt (GR) Indicator');
ALTER TABLE `waste_management_ecm`.`procurement`.`po_line` ALTER COLUMN `invoice_receipt_indicator` SET TAGS ('dbx_business_glossary_term' = 'Invoice Receipt (IR) Indicator');
ALTER TABLE `waste_management_ecm`.`procurement`.`po_line` ALTER COLUMN `item_category` SET TAGS ('dbx_business_glossary_term' = 'Item Category');
ALTER TABLE `waste_management_ecm`.`procurement`.`po_line` ALTER COLUMN `line_number` SET TAGS ('dbx_business_glossary_term' = 'Line Item Number');
ALTER TABLE `waste_management_ecm`.`procurement`.`po_line` ALTER COLUMN `line_status` SET TAGS ('dbx_business_glossary_term' = 'Line Status');
ALTER TABLE `waste_management_ecm`.`procurement`.`po_line` ALTER COLUMN `line_status` SET TAGS ('dbx_value_regex' = 'open|partially_received|fully_received|invoiced|closed|cancelled');
ALTER TABLE `waste_management_ecm`.`procurement`.`po_line` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `waste_management_ecm`.`procurement`.`po_line` ALTER COLUMN `net_value` SET TAGS ('dbx_business_glossary_term' = 'Net Value');
ALTER TABLE `waste_management_ecm`.`procurement`.`po_line` ALTER COLUMN `open_quantity` SET TAGS ('dbx_business_glossary_term' = 'Open Quantity');
ALTER TABLE `waste_management_ecm`.`procurement`.`po_line` ALTER COLUMN `over_delivery_tolerance_percent` SET TAGS ('dbx_business_glossary_term' = 'Over Delivery Tolerance Percent');
ALTER TABLE `waste_management_ecm`.`procurement`.`po_line` ALTER COLUMN `plant_code` SET TAGS ('dbx_business_glossary_term' = 'Plant Code');
ALTER TABLE `waste_management_ecm`.`procurement`.`po_line` ALTER COLUMN `purchasing_info_record` SET TAGS ('dbx_business_glossary_term' = 'Purchasing Info Record');
ALTER TABLE `waste_management_ecm`.`procurement`.`po_line` ALTER COLUMN `quantity_invoiced` SET TAGS ('dbx_business_glossary_term' = 'Quantity Invoiced');
ALTER TABLE `waste_management_ecm`.`procurement`.`po_line` ALTER COLUMN `quantity_ordered` SET TAGS ('dbx_business_glossary_term' = 'Quantity Ordered');
ALTER TABLE `waste_management_ecm`.`procurement`.`po_line` ALTER COLUMN `quantity_received` SET TAGS ('dbx_business_glossary_term' = 'Quantity Received');
ALTER TABLE `waste_management_ecm`.`procurement`.`po_line` ALTER COLUMN `requisitioner_name` SET TAGS ('dbx_business_glossary_term' = 'Requisitioner Name');
ALTER TABLE `waste_management_ecm`.`procurement`.`po_line` ALTER COLUMN `short_text` SET TAGS ('dbx_business_glossary_term' = 'Short Text Description');
ALTER TABLE `waste_management_ecm`.`procurement`.`po_line` ALTER COLUMN `storage_location` SET TAGS ('dbx_business_glossary_term' = 'Storage Location');
ALTER TABLE `waste_management_ecm`.`procurement`.`po_line` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `waste_management_ecm`.`procurement`.`po_line` ALTER COLUMN `tax_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Code');
ALTER TABLE `waste_management_ecm`.`procurement`.`po_line` ALTER COLUMN `tracking_number` SET TAGS ('dbx_business_glossary_term' = 'Tracking Number');
ALTER TABLE `waste_management_ecm`.`procurement`.`po_line` ALTER COLUMN `under_delivery_tolerance_percent` SET TAGS ('dbx_business_glossary_term' = 'Under Delivery Tolerance Percent');
ALTER TABLE `waste_management_ecm`.`procurement`.`po_line` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `waste_management_ecm`.`procurement`.`po_line` ALTER COLUMN `unit_price` SET TAGS ('dbx_business_glossary_term' = 'Unit Price');
ALTER TABLE `waste_management_ecm`.`procurement`.`po_line` ALTER COLUMN `vendor_material_number` SET TAGS ('dbx_business_glossary_term' = 'Vendor Material Number');
ALTER TABLE `waste_management_ecm`.`procurement`.`po_line` ALTER COLUMN `wbs_element` SET TAGS ('dbx_business_glossary_term' = 'Work Breakdown Structure (WBS) Element');
ALTER TABLE `waste_management_ecm`.`procurement`.`po_line` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `waste_management_ecm`.`procurement`.`goods_receipt` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `waste_management_ecm`.`procurement`.`goods_receipt` SET TAGS ('dbx_subdomain' = 'order_processing');
ALTER TABLE `waste_management_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `goods_receipt_id` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt (GR) ID');
ALTER TABLE `waste_management_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `fixed_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Fixed Asset Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Landfill Site Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `material_id` SET TAGS ('dbx_business_glossary_term' = 'Material ID');
ALTER TABLE `waste_management_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `po_line_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Line ID');
ALTER TABLE `waste_management_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) ID');
ALTER TABLE `waste_management_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Receiving Employee ID');
ALTER TABLE `waste_management_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `waste_management_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `storeroom_id` SET TAGS ('dbx_business_glossary_term' = 'Storeroom Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `waste_management_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `asset_number` SET TAGS ('dbx_business_glossary_term' = 'Asset Number');
ALTER TABLE `waste_management_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Number');
ALTER TABLE `waste_management_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `cost_center` SET TAGS ('dbx_business_glossary_term' = 'Cost Center');
ALTER TABLE `waste_management_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `cost_center` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `waste_management_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `waste_management_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `waste_management_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `waste_management_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `waste_management_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `delivery_note_number` SET TAGS ('dbx_business_glossary_term' = 'Delivery Note Number');
ALTER TABLE `waste_management_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `document_date` SET TAGS ('dbx_business_glossary_term' = 'Document Date');
ALTER TABLE `waste_management_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `waste_management_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `waste_management_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `general_ledger_account` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account');
ALTER TABLE `waste_management_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `general_ledger_account` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `waste_management_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `gr_document_number` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt (GR) Document Number');
ALTER TABLE `waste_management_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `gr_document_number` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `waste_management_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `gr_line_number` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt (GR) Line Number');
ALTER TABLE `waste_management_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `last_modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `waste_management_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `waste_management_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `movement_type` SET TAGS ('dbx_business_glossary_term' = 'Movement Type');
ALTER TABLE `waste_management_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `movement_type` SET TAGS ('dbx_value_regex' = '^[0-9]{3}$');
ALTER TABLE `waste_management_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `waste_management_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `plant_code` SET TAGS ('dbx_business_glossary_term' = 'Plant Code');
ALTER TABLE `waste_management_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `plant_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `waste_management_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Date');
ALTER TABLE `waste_management_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `quality_inspection_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Quality Inspection Required Flag');
ALTER TABLE `waste_management_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `quality_inspection_status` SET TAGS ('dbx_business_glossary_term' = 'Quality Inspection Status');
ALTER TABLE `waste_management_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `quality_inspection_status` SET TAGS ('dbx_value_regex' = 'pending|passed|failed|waived|not_required');
ALTER TABLE `waste_management_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `reason_code` SET TAGS ('dbx_business_glossary_term' = 'Reason Code');
ALTER TABLE `waste_management_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `received_quantity` SET TAGS ('dbx_business_glossary_term' = 'Received Quantity');
ALTER TABLE `waste_management_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `reference_document_number` SET TAGS ('dbx_business_glossary_term' = 'Reference Document Number');
ALTER TABLE `waste_management_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `reversal_date` SET TAGS ('dbx_business_glossary_term' = 'Reversal Date');
ALTER TABLE `waste_management_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `reversal_document_number` SET TAGS ('dbx_business_glossary_term' = 'Reversal Document Number');
ALTER TABLE `waste_management_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `reversal_flag` SET TAGS ('dbx_business_glossary_term' = 'Reversal Flag');
ALTER TABLE `waste_management_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `waste_management_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'SAP_MM|AMCS|MANUAL');
ALTER TABLE `waste_management_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `stock_type` SET TAGS ('dbx_business_glossary_term' = 'Stock Type');
ALTER TABLE `waste_management_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `stock_type` SET TAGS ('dbx_value_regex' = 'unrestricted|quality_inspection|blocked|restricted');
ALTER TABLE `waste_management_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `storage_location` SET TAGS ('dbx_business_glossary_term' = 'Storage Location');
ALTER TABLE `waste_management_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `storage_location` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `waste_management_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `waste_management_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `valuation_amount` SET TAGS ('dbx_business_glossary_term' = 'Valuation Amount');
ALTER TABLE `waste_management_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `work_order_number` SET TAGS ('dbx_business_glossary_term' = 'Work Order (WO) Number');
ALTER TABLE `waste_management_ecm`.`procurement`.`service_entry_sheet` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `waste_management_ecm`.`procurement`.`service_entry_sheet` SET TAGS ('dbx_subdomain' = 'order_processing');
ALTER TABLE `waste_management_ecm`.`procurement`.`service_entry_sheet` ALTER COLUMN `service_entry_sheet_id` SET TAGS ('dbx_business_glossary_term' = 'Service Entry Sheet ID');
ALTER TABLE `waste_management_ecm`.`procurement`.`service_entry_sheet` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `waste_management_ecm`.`procurement`.`service_entry_sheet` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Landfill Site Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`procurement`.`service_entry_sheet` ALTER COLUMN `po_line_id` SET TAGS ('dbx_business_glossary_term' = 'Po Line Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`procurement`.`service_entry_sheet` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approver ID');
ALTER TABLE `waste_management_ecm`.`procurement`.`service_entry_sheet` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`procurement`.`service_entry_sheet` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `waste_management_ecm`.`procurement`.`service_entry_sheet` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) ID');
ALTER TABLE `waste_management_ecm`.`procurement`.`service_entry_sheet` ALTER COLUMN `offering_id` SET TAGS ('dbx_business_glossary_term' = 'Service Offering Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`procurement`.`service_entry_sheet` ALTER COLUMN `tertiary_service_last_modified_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User ID');
ALTER TABLE `waste_management_ecm`.`procurement`.`service_entry_sheet` ALTER COLUMN `tertiary_service_last_modified_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`procurement`.`service_entry_sheet` ALTER COLUMN `tertiary_service_last_modified_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `waste_management_ecm`.`procurement`.`service_entry_sheet` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `waste_management_ecm`.`procurement`.`service_entry_sheet` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order (WO) ID');
ALTER TABLE `waste_management_ecm`.`procurement`.`service_entry_sheet` ALTER COLUMN `acceptance_date` SET TAGS ('dbx_business_glossary_term' = 'Acceptance Date');
ALTER TABLE `waste_management_ecm`.`procurement`.`service_entry_sheet` ALTER COLUMN `acceptance_status` SET TAGS ('dbx_business_glossary_term' = 'Acceptance Status');
ALTER TABLE `waste_management_ecm`.`procurement`.`service_entry_sheet` ALTER COLUMN `acceptance_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|accepted|rejected|cancelled');
ALTER TABLE `waste_management_ecm`.`procurement`.`service_entry_sheet` ALTER COLUMN `approver_name` SET TAGS ('dbx_business_glossary_term' = 'Approver Name');
ALTER TABLE `waste_management_ecm`.`procurement`.`service_entry_sheet` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `waste_management_ecm`.`procurement`.`service_entry_sheet` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,10}$');
ALTER TABLE `waste_management_ecm`.`procurement`.`service_entry_sheet` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `waste_management_ecm`.`procurement`.`service_entry_sheet` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `waste_management_ecm`.`procurement`.`service_entry_sheet` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `waste_management_ecm`.`procurement`.`service_entry_sheet` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `waste_management_ecm`.`procurement`.`service_entry_sheet` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_value_regex' = '^[0-9]{6,10}$');
ALTER TABLE `waste_management_ecm`.`procurement`.`service_entry_sheet` ALTER COLUMN `invoice_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Invoice Reference Number');
ALTER TABLE `waste_management_ecm`.`procurement`.`service_entry_sheet` ALTER COLUMN `invoice_verification_status` SET TAGS ('dbx_business_glossary_term' = 'Invoice Verification Status');
ALTER TABLE `waste_management_ecm`.`procurement`.`service_entry_sheet` ALTER COLUMN `invoice_verification_status` SET TAGS ('dbx_value_regex' = 'not_verified|verified|blocked|posted');
ALTER TABLE `waste_management_ecm`.`procurement`.`service_entry_sheet` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `waste_management_ecm`.`procurement`.`service_entry_sheet` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `waste_management_ecm`.`procurement`.`service_entry_sheet` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `waste_management_ecm`.`procurement`.`service_entry_sheet` ALTER COLUMN `service_end_date` SET TAGS ('dbx_business_glossary_term' = 'Service End Date');
ALTER TABLE `waste_management_ecm`.`procurement`.`service_entry_sheet` ALTER COLUMN `service_entry_sheet_number` SET TAGS ('dbx_business_glossary_term' = 'Service Entry Sheet Number');
ALTER TABLE `waste_management_ecm`.`procurement`.`service_entry_sheet` ALTER COLUMN `service_entry_sheet_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{10}$');
ALTER TABLE `waste_management_ecm`.`procurement`.`service_entry_sheet` ALTER COLUMN `service_performer_name` SET TAGS ('dbx_business_glossary_term' = 'Service Performer Name');
ALTER TABLE `waste_management_ecm`.`procurement`.`service_entry_sheet` ALTER COLUMN `service_quantity` SET TAGS ('dbx_business_glossary_term' = 'Service Quantity');
ALTER TABLE `waste_management_ecm`.`procurement`.`service_entry_sheet` ALTER COLUMN `service_start_date` SET TAGS ('dbx_business_glossary_term' = 'Service Start Date');
ALTER TABLE `waste_management_ecm`.`procurement`.`service_entry_sheet` ALTER COLUMN `service_total_amount` SET TAGS ('dbx_business_glossary_term' = 'Service Total Amount');
ALTER TABLE `waste_management_ecm`.`procurement`.`service_entry_sheet` ALTER COLUMN `service_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Service Unit of Measure');
ALTER TABLE `waste_management_ecm`.`procurement`.`service_entry_sheet` ALTER COLUMN `service_unit_price` SET TAGS ('dbx_business_glossary_term' = 'Service Unit Price');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_invoice` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_invoice` SET TAGS ('dbx_subdomain' = 'payment_reconciliation');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_invoice` ALTER COLUMN `vendor_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Invoice ID');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_invoice` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approver ID');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_invoice` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_invoice` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_invoice` ALTER COLUMN `goods_receipt_id` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt (GR) ID');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_invoice` ALTER COLUMN `run_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Run ID');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_invoice` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) ID');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_invoice` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_invoice` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_invoice` ALTER COLUMN `baseline_date` SET TAGS ('dbx_business_glossary_term' = 'Baseline Date');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_invoice` ALTER COLUMN `company_code` SET TAGS ('dbx_business_glossary_term' = 'Company Code');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_invoice` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_invoice` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_invoice` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_invoice` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_invoice` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_invoice` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_invoice` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Due Date');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_invoice` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_invoice` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_invoice` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_invoice` ALTER COLUMN `gross_amount` SET TAGS ('dbx_business_glossary_term' = 'Gross Invoice Amount');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_invoice` ALTER COLUMN `invoice_date` SET TAGS ('dbx_business_glossary_term' = 'Invoice Date');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_invoice` ALTER COLUMN `invoice_description` SET TAGS ('dbx_business_glossary_term' = 'Invoice Description');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_invoice` ALTER COLUMN `invoice_number` SET TAGS ('dbx_business_glossary_term' = 'Vendor Invoice Number');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_invoice` ALTER COLUMN `invoice_status` SET TAGS ('dbx_business_glossary_term' = 'Invoice Status');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_invoice` ALTER COLUMN `invoice_type` SET TAGS ('dbx_business_glossary_term' = 'Invoice Type');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_invoice` ALTER COLUMN `invoice_type` SET TAGS ('dbx_value_regex' = 'standard|credit_memo|debit_memo|prepayment|recurring|adjustment');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_invoice` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_invoice` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_invoice` ALTER COLUMN `net_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Invoice Amount');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_invoice` ALTER COLUMN `payment_block_flag` SET TAGS ('dbx_business_glossary_term' = 'Payment Block Flag');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_invoice` ALTER COLUMN `payment_block_reason` SET TAGS ('dbx_business_glossary_term' = 'Payment Block Reason');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_invoice` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_invoice` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'ach|wire_transfer|check|credit_card|eft|virtual_card');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_invoice` ALTER COLUMN `payment_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Status');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_invoice` ALTER COLUMN `payment_status` SET TAGS ('dbx_value_regex' = 'unpaid|partially_paid|paid|overdue');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_invoice` ALTER COLUMN `payment_terms_code` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms Code');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_invoice` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Date');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_invoice` ALTER COLUMN `receipt_date` SET TAGS ('dbx_business_glossary_term' = 'Invoice Receipt Date');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_invoice` ALTER COLUMN `reference_document_number` SET TAGS ('dbx_business_glossary_term' = 'Reference Document Number');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_invoice` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_invoice` ALTER COLUMN `three_way_match_status` SET TAGS ('dbx_business_glossary_term' = 'Three-Way Match Status');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_invoice` ALTER COLUMN `three_way_match_status` SET TAGS ('dbx_value_regex' = 'matched|po_mismatch|gr_mismatch|price_variance|quantity_variance|not_applicable');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_invoice` ALTER COLUMN `withholding_tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Withholding Tax Amount');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_invoice_line` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_invoice_line` SET TAGS ('dbx_subdomain' = 'payment_reconciliation');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_invoice_line` ALTER COLUMN `vendor_invoice_line_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Invoice Line ID');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_invoice_line` ALTER COLUMN `fixed_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Fixed Asset ID');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_invoice_line` ALTER COLUMN `goods_receipt_id` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt (GR) ID');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_invoice_line` ALTER COLUMN `material_id` SET TAGS ('dbx_business_glossary_term' = 'Material ID');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_invoice_line` ALTER COLUMN `offering_id` SET TAGS ('dbx_business_glossary_term' = 'Service ID');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_invoice_line` ALTER COLUMN `parts_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Parts Catalog Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_invoice_line` ALTER COLUMN `po_line_id` SET TAGS ('dbx_business_glossary_term' = 'Po Line Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_invoice_line` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) ID');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_invoice_line` ALTER COLUMN `service_entry_sheet_id` SET TAGS ('dbx_business_glossary_term' = 'Service Entry Sheet ID');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_invoice_line` ALTER COLUMN `vendor_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Invoice ID');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_invoice_line` ALTER COLUMN `baseline_date` SET TAGS ('dbx_business_glossary_term' = 'Baseline Date');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_invoice_line` ALTER COLUMN `blocked_for_payment` SET TAGS ('dbx_business_glossary_term' = 'Blocked for Payment Flag');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_invoice_line` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_invoice_line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_invoice_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_invoice_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_invoice_line` ALTER COLUMN `delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Delivery Date');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_invoice_line` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Line Discount Amount');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_invoice_line` ALTER COLUMN `discount_percentage` SET TAGS ('dbx_business_glossary_term' = 'Line Discount Percentage');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_invoice_line` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_invoice_line` ALTER COLUMN `invoiced_quantity` SET TAGS ('dbx_business_glossary_term' = 'Invoiced Quantity');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_invoice_line` ALTER COLUMN `line_description` SET TAGS ('dbx_business_glossary_term' = 'Invoice Line Description');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_invoice_line` ALTER COLUMN `line_gross_amount` SET TAGS ('dbx_business_glossary_term' = 'Line Gross Amount');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_invoice_line` ALTER COLUMN `line_net_amount` SET TAGS ('dbx_business_glossary_term' = 'Line Net Amount');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_invoice_line` ALTER COLUMN `line_notes` SET TAGS ('dbx_business_glossary_term' = 'Invoice Line Notes');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_invoice_line` ALTER COLUMN `line_number` SET TAGS ('dbx_business_glossary_term' = 'Invoice Line Number');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_invoice_line` ALTER COLUMN `line_tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Line Tax Amount');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_invoice_line` ALTER COLUMN `manufacturer_part_number` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Part Number');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_invoice_line` ALTER COLUMN `match_status` SET TAGS ('dbx_business_glossary_term' = 'Invoice Match Status');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_invoice_line` ALTER COLUMN `match_status` SET TAGS ('dbx_value_regex' = 'matched|unmatched|partially_matched|variance_detected|blocked');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_invoice_line` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_invoice_line` ALTER COLUMN `payment_block_reason` SET TAGS ('dbx_business_glossary_term' = 'Payment Block Reason');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_invoice_line` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_invoice_line` ALTER COLUMN `plant_code` SET TAGS ('dbx_business_glossary_term' = 'Plant Code');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_invoice_line` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Date');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_invoice_line` ALTER COLUMN `price_variance` SET TAGS ('dbx_business_glossary_term' = 'Price Variance');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_invoice_line` ALTER COLUMN `profit_center_code` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Code');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_invoice_line` ALTER COLUMN `quantity_variance` SET TAGS ('dbx_business_glossary_term' = 'Quantity Variance');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_invoice_line` ALTER COLUMN `storage_location` SET TAGS ('dbx_business_glossary_term' = 'Storage Location');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_invoice_line` ALTER COLUMN `tax_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Code');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_invoice_line` ALTER COLUMN `tax_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Tax Jurisdiction');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_invoice_line` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_invoice_line` ALTER COLUMN `unit_price` SET TAGS ('dbx_business_glossary_term' = 'Unit Price');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_invoice_line` ALTER COLUMN `vendor_material_number` SET TAGS ('dbx_business_glossary_term' = 'Vendor Material Number');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_invoice_line` ALTER COLUMN `wbs_element` SET TAGS ('dbx_business_glossary_term' = 'Work Breakdown Structure (WBS) Element');
ALTER TABLE `waste_management_ecm`.`procurement`.`ap_payment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `waste_management_ecm`.`procurement`.`ap_payment` SET TAGS ('dbx_subdomain' = 'payment_reconciliation');
ALTER TABLE `waste_management_ecm`.`procurement`.`ap_payment` ALTER COLUMN `ap_payment_id` SET TAGS ('dbx_business_glossary_term' = 'Accounts Payable (AP) Payment ID');
ALTER TABLE `waste_management_ecm`.`procurement`.`ap_payment` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_business_glossary_term' = 'Bank Account ID');
ALTER TABLE `waste_management_ecm`.`procurement`.`ap_payment` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`procurement`.`ap_payment` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `waste_management_ecm`.`procurement`.`ap_payment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By User ID');
ALTER TABLE `waste_management_ecm`.`procurement`.`ap_payment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`procurement`.`ap_payment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `waste_management_ecm`.`procurement`.`ap_payment` ALTER COLUMN `run_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Run ID');
ALTER TABLE `waste_management_ecm`.`procurement`.`ap_payment` ALTER COLUMN `run_id` SET TAGS ('dbx_value_regex' = '^PR[0-9]{8}$');
ALTER TABLE `waste_management_ecm`.`procurement`.`ap_payment` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `waste_management_ecm`.`procurement`.`ap_payment` ALTER COLUMN `vendor_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Invoice ID');
ALTER TABLE `waste_management_ecm`.`procurement`.`ap_payment` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `waste_management_ecm`.`procurement`.`ap_payment` ALTER COLUMN `baseline_date` SET TAGS ('dbx_business_glossary_term' = 'Baseline Date');
ALTER TABLE `waste_management_ecm`.`procurement`.`ap_payment` ALTER COLUMN `check_number` SET TAGS ('dbx_business_glossary_term' = 'Check Number');
ALTER TABLE `waste_management_ecm`.`procurement`.`ap_payment` ALTER COLUMN `check_number` SET TAGS ('dbx_value_regex' = '^CHK[0-9]{8}$');
ALTER TABLE `waste_management_ecm`.`procurement`.`ap_payment` ALTER COLUMN `clearing_document_number` SET TAGS ('dbx_business_glossary_term' = 'Clearing Document Number');
ALTER TABLE `waste_management_ecm`.`procurement`.`ap_payment` ALTER COLUMN `clearing_document_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{10}$');
ALTER TABLE `waste_management_ecm`.`procurement`.`ap_payment` ALTER COLUMN `company_code` SET TAGS ('dbx_business_glossary_term' = 'Company Code');
ALTER TABLE `waste_management_ecm`.`procurement`.`ap_payment` ALTER COLUMN `company_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `waste_management_ecm`.`procurement`.`ap_payment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `waste_management_ecm`.`procurement`.`ap_payment` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `waste_management_ecm`.`procurement`.`ap_payment` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `waste_management_ecm`.`procurement`.`ap_payment` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount');
ALTER TABLE `waste_management_ecm`.`procurement`.`ap_payment` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Due Date');
ALTER TABLE `waste_management_ecm`.`procurement`.`ap_payment` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `waste_management_ecm`.`procurement`.`ap_payment` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `waste_management_ecm`.`procurement`.`ap_payment` ALTER COLUMN `gl_posting_date` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Posting Date');
ALTER TABLE `waste_management_ecm`.`procurement`.`ap_payment` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `waste_management_ecm`.`procurement`.`ap_payment` ALTER COLUMN `net_payment_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Payment Amount');
ALTER TABLE `waste_management_ecm`.`procurement`.`ap_payment` ALTER COLUMN `payment_amount` SET TAGS ('dbx_business_glossary_term' = 'Payment Amount');
ALTER TABLE `waste_management_ecm`.`procurement`.`ap_payment` ALTER COLUMN `payment_batch_number` SET TAGS ('dbx_business_glossary_term' = 'Payment Batch ID');
ALTER TABLE `waste_management_ecm`.`procurement`.`ap_payment` ALTER COLUMN `payment_batch_number` SET TAGS ('dbx_value_regex' = '^BATCH[0-9]{10}$');
ALTER TABLE `waste_management_ecm`.`procurement`.`ap_payment` ALTER COLUMN `payment_block_code` SET TAGS ('dbx_business_glossary_term' = 'Payment Block Code');
ALTER TABLE `waste_management_ecm`.`procurement`.`ap_payment` ALTER COLUMN `payment_block_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{1}$');
ALTER TABLE `waste_management_ecm`.`procurement`.`ap_payment` ALTER COLUMN `payment_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Date');
ALTER TABLE `waste_management_ecm`.`procurement`.`ap_payment` ALTER COLUMN `payment_document_number` SET TAGS ('dbx_business_glossary_term' = 'Payment Document Number');
ALTER TABLE `waste_management_ecm`.`procurement`.`ap_payment` ALTER COLUMN `payment_document_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{10}$');
ALTER TABLE `waste_management_ecm`.`procurement`.`ap_payment` ALTER COLUMN `payment_memo` SET TAGS ('dbx_business_glossary_term' = 'Payment Memo');
ALTER TABLE `waste_management_ecm`.`procurement`.`ap_payment` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `waste_management_ecm`.`procurement`.`ap_payment` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'ACH|check|wire|virtual_card|EFT|cash');
ALTER TABLE `waste_management_ecm`.`procurement`.`ap_payment` ALTER COLUMN `payment_processor` SET TAGS ('dbx_business_glossary_term' = 'Payment Processor');
ALTER TABLE `waste_management_ecm`.`procurement`.`ap_payment` ALTER COLUMN `payment_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Payment Reference Number');
ALTER TABLE `waste_management_ecm`.`procurement`.`ap_payment` ALTER COLUMN `payment_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Status');
ALTER TABLE `waste_management_ecm`.`procurement`.`ap_payment` ALTER COLUMN `payment_status` SET TAGS ('dbx_value_regex' = 'pending|processed|cleared|failed|cancelled|reversed');
ALTER TABLE `waste_management_ecm`.`procurement`.`ap_payment` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `waste_management_ecm`.`procurement`.`ap_payment` ALTER COLUMN `reversal_date` SET TAGS ('dbx_business_glossary_term' = 'Reversal Date');
ALTER TABLE `waste_management_ecm`.`procurement`.`ap_payment` ALTER COLUMN `reversal_indicator` SET TAGS ('dbx_business_glossary_term' = 'Reversal Indicator');
ALTER TABLE `waste_management_ecm`.`procurement`.`ap_payment` ALTER COLUMN `reversal_reason` SET TAGS ('dbx_business_glossary_term' = 'Reversal Reason');
ALTER TABLE `waste_management_ecm`.`procurement`.`ap_payment` ALTER COLUMN `vendor_bank_account_number` SET TAGS ('dbx_business_glossary_term' = 'Vendor Bank Account Number');
ALTER TABLE `waste_management_ecm`.`procurement`.`ap_payment` ALTER COLUMN `vendor_bank_account_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`procurement`.`ap_payment` ALTER COLUMN `vendor_bank_account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `waste_management_ecm`.`procurement`.`ap_payment` ALTER COLUMN `vendor_bank_routing_number` SET TAGS ('dbx_business_glossary_term' = 'Vendor Bank Routing Number');
ALTER TABLE `waste_management_ecm`.`procurement`.`ap_payment` ALTER COLUMN `vendor_bank_routing_number` SET TAGS ('dbx_value_regex' = '^[0-9]{9}$');
ALTER TABLE `waste_management_ecm`.`procurement`.`ap_payment` ALTER COLUMN `vendor_bank_routing_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`procurement`.`ap_payment` ALTER COLUMN `withholding_tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Withholding Tax Amount');
ALTER TABLE `waste_management_ecm`.`procurement`.`sourcing_contract` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `waste_management_ecm`.`procurement`.`sourcing_contract` SET TAGS ('dbx_subdomain' = 'supplier_management');
ALTER TABLE `waste_management_ecm`.`procurement`.`sourcing_contract` ALTER COLUMN `sourcing_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Sourcing Contract ID');
ALTER TABLE `waste_management_ecm`.`procurement`.`sourcing_contract` ALTER COLUMN `material_group_id` SET TAGS ('dbx_business_glossary_term' = 'Material Group Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`procurement`.`sourcing_contract` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Owner Employee ID');
ALTER TABLE `waste_management_ecm`.`procurement`.`sourcing_contract` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`procurement`.`sourcing_contract` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `waste_management_ecm`.`procurement`.`sourcing_contract` ALTER COLUMN `primary_sourcing_approved_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Employee ID');
ALTER TABLE `waste_management_ecm`.`procurement`.`sourcing_contract` ALTER COLUMN `primary_sourcing_approved_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`procurement`.`sourcing_contract` ALTER COLUMN `primary_sourcing_approved_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `waste_management_ecm`.`procurement`.`sourcing_contract` ALTER COLUMN `safety_program_id` SET TAGS ('dbx_business_glossary_term' = 'Safety Program Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`procurement`.`sourcing_contract` ALTER COLUMN `offering_id` SET TAGS ('dbx_business_glossary_term' = 'Service Offering Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`procurement`.`sourcing_contract` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `waste_management_ecm`.`procurement`.`sourcing_contract` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `waste_management_ecm`.`procurement`.`sourcing_contract` ALTER COLUMN `auto_renewal_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto Renewal Flag');
ALTER TABLE `waste_management_ecm`.`procurement`.`sourcing_contract` ALTER COLUMN `company_code` SET TAGS ('dbx_business_glossary_term' = 'Company Code');
ALTER TABLE `waste_management_ecm`.`procurement`.`sourcing_contract` ALTER COLUMN `company_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `waste_management_ecm`.`procurement`.`sourcing_contract` ALTER COLUMN `compliance_certifications_required` SET TAGS ('dbx_business_glossary_term' = 'Compliance Certifications Required');
ALTER TABLE `waste_management_ecm`.`procurement`.`sourcing_contract` ALTER COLUMN `confidentiality_flag` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Flag');
ALTER TABLE `waste_management_ecm`.`procurement`.`sourcing_contract` ALTER COLUMN `contract_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Contract Document Reference');
ALTER TABLE `waste_management_ecm`.`procurement`.`sourcing_contract` ALTER COLUMN `contract_number` SET TAGS ('dbx_business_glossary_term' = 'Contract Number');
ALTER TABLE `waste_management_ecm`.`procurement`.`sourcing_contract` ALTER COLUMN `contract_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{10,20}$');
ALTER TABLE `waste_management_ecm`.`procurement`.`sourcing_contract` ALTER COLUMN `contract_status` SET TAGS ('dbx_business_glossary_term' = 'Contract Status');
ALTER TABLE `waste_management_ecm`.`procurement`.`sourcing_contract` ALTER COLUMN `contract_type` SET TAGS ('dbx_business_glossary_term' = 'Contract Type');
ALTER TABLE `waste_management_ecm`.`procurement`.`sourcing_contract` ALTER COLUMN `contract_type` SET TAGS ('dbx_value_regex' = 'blanket_purchase_agreement|outline_agreement|quantity_contract|value_contract|scheduling_agreement|framework_agreement');
ALTER TABLE `waste_management_ecm`.`procurement`.`sourcing_contract` ALTER COLUMN `contract_value_total` SET TAGS ('dbx_business_glossary_term' = 'Contract Total Value');
ALTER TABLE `waste_management_ecm`.`procurement`.`sourcing_contract` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `waste_management_ecm`.`procurement`.`sourcing_contract` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `waste_management_ecm`.`procurement`.`sourcing_contract` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `waste_management_ecm`.`procurement`.`sourcing_contract` ALTER COLUMN `delivery_terms` SET TAGS ('dbx_business_glossary_term' = 'Delivery Terms');
ALTER TABLE `waste_management_ecm`.`procurement`.`sourcing_contract` ALTER COLUMN `dispute_resolution_method` SET TAGS ('dbx_business_glossary_term' = 'Dispute Resolution Method');
ALTER TABLE `waste_management_ecm`.`procurement`.`sourcing_contract` ALTER COLUMN `dispute_resolution_method` SET TAGS ('dbx_value_regex' = 'negotiation|mediation|arbitration|litigation');
ALTER TABLE `waste_management_ecm`.`procurement`.`sourcing_contract` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `waste_management_ecm`.`procurement`.`sourcing_contract` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `waste_management_ecm`.`procurement`.`sourcing_contract` ALTER COLUMN `governing_law_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Governing Law Jurisdiction');
ALTER TABLE `waste_management_ecm`.`procurement`.`sourcing_contract` ALTER COLUMN `incoterms` SET TAGS ('dbx_business_glossary_term' = 'Incoterms');
ALTER TABLE `waste_management_ecm`.`procurement`.`sourcing_contract` ALTER COLUMN `insurance_requirements` SET TAGS ('dbx_business_glossary_term' = 'Insurance Requirements');
ALTER TABLE `waste_management_ecm`.`procurement`.`sourcing_contract` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `waste_management_ecm`.`procurement`.`sourcing_contract` ALTER COLUMN `maximum_quantity_commitment` SET TAGS ('dbx_business_glossary_term' = 'Maximum Quantity Commitment');
ALTER TABLE `waste_management_ecm`.`procurement`.`sourcing_contract` ALTER COLUMN `minimum_quantity_commitment` SET TAGS ('dbx_business_glossary_term' = 'Minimum Quantity Commitment');
ALTER TABLE `waste_management_ecm`.`procurement`.`sourcing_contract` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Contract Notes');
ALTER TABLE `waste_management_ecm`.`procurement`.`sourcing_contract` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `waste_management_ecm`.`procurement`.`sourcing_contract` ALTER COLUMN `penalty_provisions` SET TAGS ('dbx_business_glossary_term' = 'Penalty Provisions');
ALTER TABLE `waste_management_ecm`.`procurement`.`sourcing_contract` ALTER COLUMN `performance_metrics` SET TAGS ('dbx_business_glossary_term' = 'Performance Metrics');
ALTER TABLE `waste_management_ecm`.`procurement`.`sourcing_contract` ALTER COLUMN `plant_code` SET TAGS ('dbx_business_glossary_term' = 'Plant Code');
ALTER TABLE `waste_management_ecm`.`procurement`.`sourcing_contract` ALTER COLUMN `pricing_condition_type` SET TAGS ('dbx_business_glossary_term' = 'Pricing Condition Type');
ALTER TABLE `waste_management_ecm`.`procurement`.`sourcing_contract` ALTER COLUMN `pricing_condition_type` SET TAGS ('dbx_value_regex' = 'fixed_price|variable_price|cost_plus|market_indexed|tiered_pricing|volume_discount');
ALTER TABLE `waste_management_ecm`.`procurement`.`sourcing_contract` ALTER COLUMN `purchasing_group` SET TAGS ('dbx_business_glossary_term' = 'Purchasing Group');
ALTER TABLE `waste_management_ecm`.`procurement`.`sourcing_contract` ALTER COLUMN `purchasing_organization` SET TAGS ('dbx_business_glossary_term' = 'Purchasing Organization');
ALTER TABLE `waste_management_ecm`.`procurement`.`sourcing_contract` ALTER COLUMN `quality_requirements` SET TAGS ('dbx_business_glossary_term' = 'Quality Requirements');
ALTER TABLE `waste_management_ecm`.`procurement`.`sourcing_contract` ALTER COLUMN `renewal_notice_days` SET TAGS ('dbx_business_glossary_term' = 'Renewal Notice Days');
ALTER TABLE `waste_management_ecm`.`procurement`.`sourcing_contract` ALTER COLUMN `sustainability_requirements` SET TAGS ('dbx_business_glossary_term' = 'Sustainability Requirements');
ALTER TABLE `waste_management_ecm`.`procurement`.`sourcing_contract` ALTER COLUMN `termination_clause` SET TAGS ('dbx_business_glossary_term' = 'Termination Clause');
ALTER TABLE `waste_management_ecm`.`procurement`.`sourcing_contract` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `waste_management_ecm`.`procurement`.`sourcing_contract_line` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `waste_management_ecm`.`procurement`.`sourcing_contract_line` SET TAGS ('dbx_subdomain' = 'supplier_management');
ALTER TABLE `waste_management_ecm`.`procurement`.`sourcing_contract_line` ALTER COLUMN `sourcing_contract_line_id` SET TAGS ('dbx_business_glossary_term' = 'Sourcing Contract Line ID');
ALTER TABLE `waste_management_ecm`.`procurement`.`sourcing_contract_line` ALTER COLUMN `material_id` SET TAGS ('dbx_business_glossary_term' = 'Material Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`procurement`.`sourcing_contract_line` ALTER COLUMN `offering_id` SET TAGS ('dbx_business_glossary_term' = 'Service Offering Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`procurement`.`sourcing_contract_line` ALTER COLUMN `sourcing_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Sourcing Contract ID');
ALTER TABLE `waste_management_ecm`.`procurement`.`sourcing_contract_line` ALTER COLUMN `cost_center` SET TAGS ('dbx_business_glossary_term' = 'Cost Center');
ALTER TABLE `waste_management_ecm`.`procurement`.`sourcing_contract_line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `waste_management_ecm`.`procurement`.`sourcing_contract_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `waste_management_ecm`.`procurement`.`sourcing_contract_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `waste_management_ecm`.`procurement`.`sourcing_contract_line` ALTER COLUMN `deletion_indicator` SET TAGS ('dbx_business_glossary_term' = 'Deletion Indicator');
ALTER TABLE `waste_management_ecm`.`procurement`.`sourcing_contract_line` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `waste_management_ecm`.`procurement`.`sourcing_contract_line` ALTER COLUMN `incoterms` SET TAGS ('dbx_business_glossary_term' = 'Incoterms');
ALTER TABLE `waste_management_ecm`.`procurement`.`sourcing_contract_line` ALTER COLUMN `incoterms_location` SET TAGS ('dbx_business_glossary_term' = 'Incoterms Location');
ALTER TABLE `waste_management_ecm`.`procurement`.`sourcing_contract_line` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `waste_management_ecm`.`procurement`.`sourcing_contract_line` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `waste_management_ecm`.`procurement`.`sourcing_contract_line` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time Days');
ALTER TABLE `waste_management_ecm`.`procurement`.`sourcing_contract_line` ALTER COLUMN `line_number` SET TAGS ('dbx_business_glossary_term' = 'Line Number');
ALTER TABLE `waste_management_ecm`.`procurement`.`sourcing_contract_line` ALTER COLUMN `line_status` SET TAGS ('dbx_business_glossary_term' = 'Line Status');
ALTER TABLE `waste_management_ecm`.`procurement`.`sourcing_contract_line` ALTER COLUMN `line_status` SET TAGS ('dbx_value_regex' = 'active|inactive|blocked|expired|closed');
ALTER TABLE `waste_management_ecm`.`procurement`.`sourcing_contract_line` ALTER COLUMN `line_type` SET TAGS ('dbx_business_glossary_term' = 'Line Type');
ALTER TABLE `waste_management_ecm`.`procurement`.`sourcing_contract_line` ALTER COLUMN `line_type` SET TAGS ('dbx_value_regex' = 'material|service|equipment|fuel|ppe|chemical');
ALTER TABLE `waste_management_ecm`.`procurement`.`sourcing_contract_line` ALTER COLUMN `line_valid_from_date` SET TAGS ('dbx_business_glossary_term' = 'Line Valid From Date');
ALTER TABLE `waste_management_ecm`.`procurement`.`sourcing_contract_line` ALTER COLUMN `line_valid_to_date` SET TAGS ('dbx_business_glossary_term' = 'Line Valid To Date');
ALTER TABLE `waste_management_ecm`.`procurement`.`sourcing_contract_line` ALTER COLUMN `manufacturer_part_number` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Part Number (MPN)');
ALTER TABLE `waste_management_ecm`.`procurement`.`sourcing_contract_line` ALTER COLUMN `maximum_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Maximum Order Quantity');
ALTER TABLE `waste_management_ecm`.`procurement`.`sourcing_contract_line` ALTER COLUMN `minimum_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity (MOQ)');
ALTER TABLE `waste_management_ecm`.`procurement`.`sourcing_contract_line` ALTER COLUMN `plant_code` SET TAGS ('dbx_business_glossary_term' = 'Plant Code');
ALTER TABLE `waste_management_ecm`.`procurement`.`sourcing_contract_line` ALTER COLUMN `price_scale_basis` SET TAGS ('dbx_business_glossary_term' = 'Price Scale Basis');
ALTER TABLE `waste_management_ecm`.`procurement`.`sourcing_contract_line` ALTER COLUMN `price_scale_basis` SET TAGS ('dbx_value_regex' = 'quantity|value|none');
ALTER TABLE `waste_management_ecm`.`procurement`.`sourcing_contract_line` ALTER COLUMN `price_scale_indicator` SET TAGS ('dbx_business_glossary_term' = 'Price Scale Indicator');
ALTER TABLE `waste_management_ecm`.`procurement`.`sourcing_contract_line` ALTER COLUMN `purchasing_group` SET TAGS ('dbx_business_glossary_term' = 'Purchasing Group');
ALTER TABLE `waste_management_ecm`.`procurement`.`sourcing_contract_line` ALTER COLUMN `purchasing_organization` SET TAGS ('dbx_business_glossary_term' = 'Purchasing Organization');
ALTER TABLE `waste_management_ecm`.`procurement`.`sourcing_contract_line` ALTER COLUMN `release_order_count` SET TAGS ('dbx_business_glossary_term' = 'Release Order Count');
ALTER TABLE `waste_management_ecm`.`procurement`.`sourcing_contract_line` ALTER COLUMN `released_quantity` SET TAGS ('dbx_business_glossary_term' = 'Released Quantity');
ALTER TABLE `waste_management_ecm`.`procurement`.`sourcing_contract_line` ALTER COLUMN `remaining_quantity` SET TAGS ('dbx_business_glossary_term' = 'Remaining Quantity');
ALTER TABLE `waste_management_ecm`.`procurement`.`sourcing_contract_line` ALTER COLUMN `storage_location` SET TAGS ('dbx_business_glossary_term' = 'Storage Location');
ALTER TABLE `waste_management_ecm`.`procurement`.`sourcing_contract_line` ALTER COLUMN `target_quantity` SET TAGS ('dbx_business_glossary_term' = 'Target Quantity');
ALTER TABLE `waste_management_ecm`.`procurement`.`sourcing_contract_line` ALTER COLUMN `tax_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Code');
ALTER TABLE `waste_management_ecm`.`procurement`.`sourcing_contract_line` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `waste_management_ecm`.`procurement`.`sourcing_contract_line` ALTER COLUMN `unit_price` SET TAGS ('dbx_business_glossary_term' = 'Unit Price');
ALTER TABLE `waste_management_ecm`.`procurement`.`sourcing_contract_line` ALTER COLUMN `vendor_material_number` SET TAGS ('dbx_business_glossary_term' = 'Vendor Material Number');
ALTER TABLE `waste_management_ecm`.`procurement`.`sourcing_contract_line` ALTER COLUMN `wbs_element` SET TAGS ('dbx_business_glossary_term' = 'Work Breakdown Structure (WBS) Element');
ALTER TABLE `waste_management_ecm`.`procurement`.`sourcing_contract_line` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `waste_management_ecm`.`procurement`.`rfq` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `waste_management_ecm`.`procurement`.`rfq` SET TAGS ('dbx_subdomain' = 'supplier_management');
ALTER TABLE `waste_management_ecm`.`procurement`.`rfq` ALTER COLUMN `rfq_id` SET TAGS ('dbx_business_glossary_term' = 'Request for Quotation (RFQ) ID');
ALTER TABLE `waste_management_ecm`.`procurement`.`rfq` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Awarded Vendor ID');
ALTER TABLE `waste_management_ecm`.`procurement`.`rfq` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Buyer ID');
ALTER TABLE `waste_management_ecm`.`procurement`.`rfq` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`procurement`.`rfq` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `waste_management_ecm`.`procurement`.`rfq` ALTER COLUMN `material_group_id` SET TAGS ('dbx_business_glossary_term' = 'Material Group Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`procurement`.`rfq` ALTER COLUMN `purchase_requisition_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Requisition Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`procurement`.`rfq` ALTER COLUMN `offering_id` SET TAGS ('dbx_business_glossary_term' = 'Service Offering Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`procurement`.`rfq` ALTER COLUMN `sourcing_event_id` SET TAGS ('dbx_business_glossary_term' = 'Sourcing Event ID');
ALTER TABLE `waste_management_ecm`.`procurement`.`rfq` ALTER COLUMN `award_date` SET TAGS ('dbx_business_glossary_term' = 'Award Date');
ALTER TABLE `waste_management_ecm`.`procurement`.`rfq` ALTER COLUMN `award_justification` SET TAGS ('dbx_business_glossary_term' = 'Award Justification');
ALTER TABLE `waste_management_ecm`.`procurement`.`rfq` ALTER COLUMN `buyer_name` SET TAGS ('dbx_business_glossary_term' = 'Buyer Name');
ALTER TABLE `waste_management_ecm`.`procurement`.`rfq` ALTER COLUMN `commodity_description` SET TAGS ('dbx_business_glossary_term' = 'Commodity Description');
ALTER TABLE `waste_management_ecm`.`procurement`.`rfq` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `waste_management_ecm`.`procurement`.`rfq` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `waste_management_ecm`.`procurement`.`rfq` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `waste_management_ecm`.`procurement`.`rfq` ALTER COLUMN `delivery_address_line_1` SET TAGS ('dbx_business_glossary_term' = 'Delivery Address Line 1');
ALTER TABLE `waste_management_ecm`.`procurement`.`rfq` ALTER COLUMN `delivery_address_line_1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`procurement`.`rfq` ALTER COLUMN `delivery_address_line_1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `waste_management_ecm`.`procurement`.`rfq` ALTER COLUMN `delivery_address_line_2` SET TAGS ('dbx_business_glossary_term' = 'Delivery Address Line 2');
ALTER TABLE `waste_management_ecm`.`procurement`.`rfq` ALTER COLUMN `delivery_address_line_2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`procurement`.`rfq` ALTER COLUMN `delivery_address_line_2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `waste_management_ecm`.`procurement`.`rfq` ALTER COLUMN `delivery_city` SET TAGS ('dbx_business_glossary_term' = 'Delivery City');
ALTER TABLE `waste_management_ecm`.`procurement`.`rfq` ALTER COLUMN `delivery_city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`procurement`.`rfq` ALTER COLUMN `delivery_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `waste_management_ecm`.`procurement`.`rfq` ALTER COLUMN `delivery_country_code` SET TAGS ('dbx_business_glossary_term' = 'Delivery Country Code');
ALTER TABLE `waste_management_ecm`.`procurement`.`rfq` ALTER COLUMN `delivery_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `waste_management_ecm`.`procurement`.`rfq` ALTER COLUMN `delivery_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Delivery Postal Code');
ALTER TABLE `waste_management_ecm`.`procurement`.`rfq` ALTER COLUMN `delivery_postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`procurement`.`rfq` ALTER COLUMN `delivery_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `waste_management_ecm`.`procurement`.`rfq` ALTER COLUMN `delivery_state_province` SET TAGS ('dbx_business_glossary_term' = 'Delivery State or Province');
ALTER TABLE `waste_management_ecm`.`procurement`.`rfq` ALTER COLUMN `delivery_state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`procurement`.`rfq` ALTER COLUMN `delivery_state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `waste_management_ecm`.`procurement`.`rfq` ALTER COLUMN `estimated_budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Estimated Budget Amount');
ALTER TABLE `waste_management_ecm`.`procurement`.`rfq` ALTER COLUMN `estimated_budget_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`procurement`.`rfq` ALTER COLUMN `evaluation_criteria` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Criteria');
ALTER TABLE `waste_management_ecm`.`procurement`.`rfq` ALTER COLUMN `incoterms_code` SET TAGS ('dbx_business_glossary_term' = 'International Commercial Terms (Incoterms) Code');
ALTER TABLE `waste_management_ecm`.`procurement`.`rfq` ALTER COLUMN `issue_date` SET TAGS ('dbx_business_glossary_term' = 'Issue Date');
ALTER TABLE `waste_management_ecm`.`procurement`.`rfq` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `waste_management_ecm`.`procurement`.`rfq` ALTER COLUMN `minimum_qualification_requirements` SET TAGS ('dbx_business_glossary_term' = 'Minimum Qualification Requirements');
ALTER TABLE `waste_management_ecm`.`procurement`.`rfq` ALTER COLUMN `minority_owned_preference_flag` SET TAGS ('dbx_business_glossary_term' = 'Minority-Owned Business Preference Flag');
ALTER TABLE `waste_management_ecm`.`procurement`.`rfq` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `waste_management_ecm`.`procurement`.`rfq` ALTER COLUMN `number_of_responses_received` SET TAGS ('dbx_business_glossary_term' = 'Number of Responses Received');
ALTER TABLE `waste_management_ecm`.`procurement`.`rfq` ALTER COLUMN `number_of_vendors_invited` SET TAGS ('dbx_business_glossary_term' = 'Number of Vendors Invited');
ALTER TABLE `waste_management_ecm`.`procurement`.`rfq` ALTER COLUMN `payment_terms_code` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms Code');
ALTER TABLE `waste_management_ecm`.`procurement`.`rfq` ALTER COLUMN `plant_code` SET TAGS ('dbx_business_glossary_term' = 'Plant Code');
ALTER TABLE `waste_management_ecm`.`procurement`.`rfq` ALTER COLUMN `purchasing_group` SET TAGS ('dbx_business_glossary_term' = 'Purchasing Group');
ALTER TABLE `waste_management_ecm`.`procurement`.`rfq` ALTER COLUMN `purchasing_organization` SET TAGS ('dbx_business_glossary_term' = 'Purchasing Organization');
ALTER TABLE `waste_management_ecm`.`procurement`.`rfq` ALTER COLUMN `quantity_requested` SET TAGS ('dbx_business_glossary_term' = 'Quantity Requested');
ALTER TABLE `waste_management_ecm`.`procurement`.`rfq` ALTER COLUMN `required_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Required Delivery Date');
ALTER TABLE `waste_management_ecm`.`procurement`.`rfq` ALTER COLUMN `rfq_number` SET TAGS ('dbx_business_glossary_term' = 'Request for Quotation (RFQ) Number');
ALTER TABLE `waste_management_ecm`.`procurement`.`rfq` ALTER COLUMN `rfq_status` SET TAGS ('dbx_business_glossary_term' = 'Request for Quotation (RFQ) Status');
ALTER TABLE `waste_management_ecm`.`procurement`.`rfq` ALTER COLUMN `rfq_status` SET TAGS ('dbx_value_regex' = 'draft|issued|open|closed|awarded|cancelled');
ALTER TABLE `waste_management_ecm`.`procurement`.`rfq` ALTER COLUMN `rfq_type` SET TAGS ('dbx_business_glossary_term' = 'Request for Quotation (RFQ) Type');
ALTER TABLE `waste_management_ecm`.`procurement`.`rfq` ALTER COLUMN `rfq_type` SET TAGS ('dbx_value_regex' = 'standard|blanket|spot|emergency|strategic');
ALTER TABLE `waste_management_ecm`.`procurement`.`rfq` ALTER COLUMN `small_business_preference_flag` SET TAGS ('dbx_business_glossary_term' = 'Small Business Preference Flag');
ALTER TABLE `waste_management_ecm`.`procurement`.`rfq` ALTER COLUMN `submission_deadline_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Submission Deadline Timestamp');
ALTER TABLE `waste_management_ecm`.`procurement`.`rfq` ALTER COLUMN `sustainability_requirements` SET TAGS ('dbx_business_glossary_term' = 'Sustainability Requirements');
ALTER TABLE `waste_management_ecm`.`procurement`.`rfq` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_quote` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_quote` SET TAGS ('dbx_subdomain' = 'supplier_management');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_quote` ALTER COLUMN `vendor_quote_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Quote Identifier (ID)');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_quote` ALTER COLUMN `material_id` SET TAGS ('dbx_business_glossary_term' = 'Material Identifier (ID)');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_quote` ALTER COLUMN `rfq_id` SET TAGS ('dbx_business_glossary_term' = 'Request for Quotation (RFQ) Identifier (ID)');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_quote` ALTER COLUMN `vendor_contact_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Contact Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_quote` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Identifier (ID)');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_quote` ALTER COLUMN `award_decision_date` SET TAGS ('dbx_business_glossary_term' = 'Award Decision Date');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_quote` ALTER COLUMN `award_decision_flag` SET TAGS ('dbx_business_glossary_term' = 'Award Decision Flag');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_quote` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_quote` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_quote` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_quote` ALTER COLUMN `delivery_location` SET TAGS ('dbx_business_glossary_term' = 'Delivery Location');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_quote` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_quote` ALTER COLUMN `discount_percentage` SET TAGS ('dbx_business_glossary_term' = 'Discount Percentage');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_quote` ALTER COLUMN `evaluation_score` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Score');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_quote` ALTER COLUMN `freight_terms` SET TAGS ('dbx_business_glossary_term' = 'Freight Terms');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_quote` ALTER COLUMN `freight_terms` SET TAGS ('dbx_value_regex' = 'prepaid|collect|third_party|fob_origin|fob_destination');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_quote` ALTER COLUMN `incoterms_code` SET TAGS ('dbx_business_glossary_term' = 'Incoterms Code');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_quote` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_quote` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time (Days)');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_quote` ALTER COLUMN `minimum_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity (MOQ)');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_quote` ALTER COLUMN `net_quote_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Quote Amount');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_quote` ALTER COLUMN `payment_terms_code` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms Code');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_quote` ALTER COLUMN `payment_terms_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_quote` ALTER COLUMN `quote_notes` SET TAGS ('dbx_business_glossary_term' = 'Quote Notes');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_quote` ALTER COLUMN `quote_number` SET TAGS ('dbx_business_glossary_term' = 'Quote Number');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_quote` ALTER COLUMN `quote_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{10,20}$');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_quote` ALTER COLUMN `quote_ranking` SET TAGS ('dbx_business_glossary_term' = 'Quote Ranking');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_quote` ALTER COLUMN `quote_status` SET TAGS ('dbx_business_glossary_term' = 'Quote Status');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_quote` ALTER COLUMN `quote_submission_date` SET TAGS ('dbx_business_glossary_term' = 'Quote Submission Date');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_quote` ALTER COLUMN `quote_valid_from_date` SET TAGS ('dbx_business_glossary_term' = 'Quote Valid From Date');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_quote` ALTER COLUMN `quote_valid_to_date` SET TAGS ('dbx_business_glossary_term' = 'Quote Valid To Date');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_quote` ALTER COLUMN `quoted_quantity` SET TAGS ('dbx_business_glossary_term' = 'Quoted Quantity');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_quote` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_quote` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_quote` ALTER COLUMN `technical_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Technical Compliance Flag');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_quote` ALTER COLUMN `technical_compliance_notes` SET TAGS ('dbx_business_glossary_term' = 'Technical Compliance Notes');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_quote` ALTER COLUMN `total_quote_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Quote Amount');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_quote` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_quote` ALTER COLUMN `unit_price` SET TAGS ('dbx_business_glossary_term' = 'Unit Price');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_quote` ALTER COLUMN `warranty_period_months` SET TAGS ('dbx_business_glossary_term' = 'Warranty Period (Months)');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_quote` ALTER COLUMN `warranty_terms` SET TAGS ('dbx_business_glossary_term' = 'Warranty Terms');
ALTER TABLE `waste_management_ecm`.`procurement`.`info_record` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `waste_management_ecm`.`procurement`.`info_record` SET TAGS ('dbx_subdomain' = 'supplier_management');
ALTER TABLE `waste_management_ecm`.`procurement`.`info_record` ALTER COLUMN `info_record_id` SET TAGS ('dbx_business_glossary_term' = 'Info Record ID');
ALTER TABLE `waste_management_ecm`.`procurement`.`info_record` ALTER COLUMN `material_id` SET TAGS ('dbx_business_glossary_term' = 'Material ID');
ALTER TABLE `waste_management_ecm`.`procurement`.`info_record` ALTER COLUMN `sourcing_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Sourcing Contract Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`procurement`.`info_record` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `waste_management_ecm`.`procurement`.`info_record` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `waste_management_ecm`.`procurement`.`info_record` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `waste_management_ecm`.`procurement`.`info_record` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `waste_management_ecm`.`procurement`.`info_record` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `waste_management_ecm`.`procurement`.`info_record` ALTER COLUMN `deletion_flag` SET TAGS ('dbx_business_glossary_term' = 'Deletion Flag');
ALTER TABLE `waste_management_ecm`.`procurement`.`info_record` ALTER COLUMN `gr_processing_time_days` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt (GR) Processing Time (Days)');
ALTER TABLE `waste_management_ecm`.`procurement`.`info_record` ALTER COLUMN `incoterms` SET TAGS ('dbx_business_glossary_term' = 'Incoterms');
ALTER TABLE `waste_management_ecm`.`procurement`.`info_record` ALTER COLUMN `incoterms_location` SET TAGS ('dbx_business_glossary_term' = 'Incoterms Location');
ALTER TABLE `waste_management_ecm`.`procurement`.`info_record` ALTER COLUMN `info_record_category` SET TAGS ('dbx_business_glossary_term' = 'Info Record Category');
ALTER TABLE `waste_management_ecm`.`procurement`.`info_record` ALTER COLUMN `info_record_category` SET TAGS ('dbx_value_regex' = 'standard|subcontracting|consignment|pipeline');
ALTER TABLE `waste_management_ecm`.`procurement`.`info_record` ALTER COLUMN `info_record_number` SET TAGS ('dbx_business_glossary_term' = 'Info Record Number');
ALTER TABLE `waste_management_ecm`.`procurement`.`info_record` ALTER COLUMN `info_record_status` SET TAGS ('dbx_business_glossary_term' = 'Info Record Status');
ALTER TABLE `waste_management_ecm`.`procurement`.`info_record` ALTER COLUMN `info_record_status` SET TAGS ('dbx_value_regex' = 'active|inactive|blocked|pending_approval');
ALTER TABLE `waste_management_ecm`.`procurement`.`info_record` ALTER COLUMN `last_modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `waste_management_ecm`.`procurement`.`info_record` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `waste_management_ecm`.`procurement`.`info_record` ALTER COLUMN `last_purchase_order_date` SET TAGS ('dbx_business_glossary_term' = 'Last Purchase Order (PO) Date');
ALTER TABLE `waste_management_ecm`.`procurement`.`info_record` ALTER COLUMN `last_purchase_order_number` SET TAGS ('dbx_business_glossary_term' = 'Last Purchase Order (PO) Number');
ALTER TABLE `waste_management_ecm`.`procurement`.`info_record` ALTER COLUMN `manufacturer_part_number` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Part Number (MPN)');
ALTER TABLE `waste_management_ecm`.`procurement`.`info_record` ALTER COLUMN `minimum_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity (MOQ)');
ALTER TABLE `waste_management_ecm`.`procurement`.`info_record` ALTER COLUMN `net_price_flag` SET TAGS ('dbx_business_glossary_term' = 'Net Price Flag');
ALTER TABLE `waste_management_ecm`.`procurement`.`info_record` ALTER COLUMN `order_unit` SET TAGS ('dbx_business_glossary_term' = 'Order Unit of Measure');
ALTER TABLE `waste_management_ecm`.`procurement`.`info_record` ALTER COLUMN `overdelivery_tolerance_percent` SET TAGS ('dbx_business_glossary_term' = 'Overdelivery Tolerance Percent');
ALTER TABLE `waste_management_ecm`.`procurement`.`info_record` ALTER COLUMN `planned_delivery_time_days` SET TAGS ('dbx_business_glossary_term' = 'Planned Delivery Time (Days)');
ALTER TABLE `waste_management_ecm`.`procurement`.`info_record` ALTER COLUMN `plant_code` SET TAGS ('dbx_business_glossary_term' = 'Plant Code');
ALTER TABLE `waste_management_ecm`.`procurement`.`info_record` ALTER COLUMN `price_date_category` SET TAGS ('dbx_business_glossary_term' = 'Price Date Category');
ALTER TABLE `waste_management_ecm`.`procurement`.`info_record` ALTER COLUMN `price_date_category` SET TAGS ('dbx_value_regex' = 'fixed|variable|contract_based');
ALTER TABLE `waste_management_ecm`.`procurement`.`info_record` ALTER COLUMN `price_unit` SET TAGS ('dbx_business_glossary_term' = 'Price Unit');
ALTER TABLE `waste_management_ecm`.`procurement`.`info_record` ALTER COLUMN `purchase_order_acknowledgment_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Acknowledgment Required Flag');
ALTER TABLE `waste_management_ecm`.`procurement`.`info_record` ALTER COLUMN `purchasing_group_code` SET TAGS ('dbx_business_glossary_term' = 'Purchasing Group Code');
ALTER TABLE `waste_management_ecm`.`procurement`.`info_record` ALTER COLUMN `purchasing_organization_code` SET TAGS ('dbx_business_glossary_term' = 'Purchasing Organization Code');
ALTER TABLE `waste_management_ecm`.`procurement`.`info_record` ALTER COLUMN `quotation_date` SET TAGS ('dbx_business_glossary_term' = 'Quotation Date');
ALTER TABLE `waste_management_ecm`.`procurement`.`info_record` ALTER COLUMN `quotation_number` SET TAGS ('dbx_business_glossary_term' = 'Quotation Number');
ALTER TABLE `waste_management_ecm`.`procurement`.`info_record` ALTER COLUMN `regular_vendor_flag` SET TAGS ('dbx_business_glossary_term' = 'Regular Vendor Flag');
ALTER TABLE `waste_management_ecm`.`procurement`.`info_record` ALTER COLUMN `reminder_days` SET TAGS ('dbx_business_glossary_term' = 'Reminder Days');
ALTER TABLE `waste_management_ecm`.`procurement`.`info_record` ALTER COLUMN `standard_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Standard Order Quantity');
ALTER TABLE `waste_management_ecm`.`procurement`.`info_record` ALTER COLUMN `standard_price` SET TAGS ('dbx_business_glossary_term' = 'Standard Price');
ALTER TABLE `waste_management_ecm`.`procurement`.`info_record` ALTER COLUMN `tax_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Code');
ALTER TABLE `waste_management_ecm`.`procurement`.`info_record` ALTER COLUMN `underdelivery_tolerance_percent` SET TAGS ('dbx_business_glossary_term' = 'Underdelivery Tolerance Percent');
ALTER TABLE `waste_management_ecm`.`procurement`.`info_record` ALTER COLUMN `unlimited_overdelivery_flag` SET TAGS ('dbx_business_glossary_term' = 'Unlimited Overdelivery Flag');
ALTER TABLE `waste_management_ecm`.`procurement`.`info_record` ALTER COLUMN `valid_from_date` SET TAGS ('dbx_business_glossary_term' = 'Valid From Date');
ALTER TABLE `waste_management_ecm`.`procurement`.`info_record` ALTER COLUMN `valid_to_date` SET TAGS ('dbx_business_glossary_term' = 'Valid To Date');
ALTER TABLE `waste_management_ecm`.`procurement`.`info_record` ALTER COLUMN `vendor_material_number` SET TAGS ('dbx_business_glossary_term' = 'Vendor Material Number');
ALTER TABLE `waste_management_ecm`.`procurement`.`source_list` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `waste_management_ecm`.`procurement`.`source_list` SET TAGS ('dbx_subdomain' = 'supplier_management');
ALTER TABLE `waste_management_ecm`.`procurement`.`source_list` ALTER COLUMN `source_list_id` SET TAGS ('dbx_business_glossary_term' = 'Source List ID');
ALTER TABLE `waste_management_ecm`.`procurement`.`source_list` ALTER COLUMN `info_record_id` SET TAGS ('dbx_business_glossary_term' = 'Info Record Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`procurement`.`source_list` ALTER COLUMN `material_id` SET TAGS ('dbx_business_glossary_term' = 'Material ID');
ALTER TABLE `waste_management_ecm`.`procurement`.`source_list` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `waste_management_ecm`.`procurement`.`source_list` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`procurement`.`source_list` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `waste_management_ecm`.`procurement`.`source_list` ALTER COLUMN `source_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Blocked By User ID');
ALTER TABLE `waste_management_ecm`.`procurement`.`source_list` ALTER COLUMN `source_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`procurement`.`source_list` ALTER COLUMN `source_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `waste_management_ecm`.`procurement`.`source_list` ALTER COLUMN `source_last_modified_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User ID');
ALTER TABLE `waste_management_ecm`.`procurement`.`source_list` ALTER COLUMN `source_last_modified_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`procurement`.`source_list` ALTER COLUMN `source_last_modified_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `waste_management_ecm`.`procurement`.`source_list` ALTER COLUMN `sourcing_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Sourcing Contract Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`procurement`.`source_list` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `waste_management_ecm`.`procurement`.`source_list` ALTER COLUMN `agreement_item_number` SET TAGS ('dbx_business_glossary_term' = 'Agreement Item Number');
ALTER TABLE `waste_management_ecm`.`procurement`.`source_list` ALTER COLUMN `agreement_item_number` SET TAGS ('dbx_value_regex' = '^[0-9]{5}$');
ALTER TABLE `waste_management_ecm`.`procurement`.`source_list` ALTER COLUMN `blocked_date` SET TAGS ('dbx_business_glossary_term' = 'Blocked Date');
ALTER TABLE `waste_management_ecm`.`procurement`.`source_list` ALTER COLUMN `blocked_flag` SET TAGS ('dbx_business_glossary_term' = 'Blocked Flag');
ALTER TABLE `waste_management_ecm`.`procurement`.`source_list` ALTER COLUMN `blocked_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Blocked Reason Code');
ALTER TABLE `waste_management_ecm`.`procurement`.`source_list` ALTER COLUMN `blocked_reason_code` SET TAGS ('dbx_value_regex' = 'quality_issue|contract_dispute|performance_failure|compliance_violation|financial_risk|other');
ALTER TABLE `waste_management_ecm`.`procurement`.`source_list` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `waste_management_ecm`.`procurement`.`source_list` ALTER COLUMN `critical_material_flag` SET TAGS ('dbx_business_glossary_term' = 'Critical Material Flag');
ALTER TABLE `waste_management_ecm`.`procurement`.`source_list` ALTER COLUMN `environmental_compliance_certified_flag` SET TAGS ('dbx_business_glossary_term' = 'Environmental Compliance Certified Flag');
ALTER TABLE `waste_management_ecm`.`procurement`.`source_list` ALTER COLUMN `fixed_source_indicator` SET TAGS ('dbx_business_glossary_term' = 'Fixed Source Indicator');
ALTER TABLE `waste_management_ecm`.`procurement`.`source_list` ALTER COLUMN `hazmat_approved_flag` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Material (HAZMAT) Approved Flag');
ALTER TABLE `waste_management_ecm`.`procurement`.`source_list` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `waste_management_ecm`.`procurement`.`source_list` ALTER COLUMN `last_purchase_order_date` SET TAGS ('dbx_business_glossary_term' = 'Last Purchase Order (PO) Date');
ALTER TABLE `waste_management_ecm`.`procurement`.`source_list` ALTER COLUMN `last_purchase_order_number` SET TAGS ('dbx_business_glossary_term' = 'Last Purchase Order (PO) Number');
ALTER TABLE `waste_management_ecm`.`procurement`.`source_list` ALTER COLUMN `last_purchase_order_number` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `waste_management_ecm`.`procurement`.`source_list` ALTER COLUMN `minimum_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity (MOQ)');
ALTER TABLE `waste_management_ecm`.`procurement`.`source_list` ALTER COLUMN `mrp_relevant_flag` SET TAGS ('dbx_business_glossary_term' = 'Material Requirements Planning (MRP) Relevant Flag');
ALTER TABLE `waste_management_ecm`.`procurement`.`source_list` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `waste_management_ecm`.`procurement`.`source_list` ALTER COLUMN `oem_authorized_flag` SET TAGS ('dbx_business_glossary_term' = 'Original Equipment Manufacturer (OEM) Authorized Flag');
ALTER TABLE `waste_management_ecm`.`procurement`.`source_list` ALTER COLUMN `order_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Order Unit of Measure (UOM)');
ALTER TABLE `waste_management_ecm`.`procurement`.`source_list` ALTER COLUMN `order_unit_of_measure` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,3}$');
ALTER TABLE `waste_management_ecm`.`procurement`.`source_list` ALTER COLUMN `plant_code` SET TAGS ('dbx_business_glossary_term' = 'Plant Code');
ALTER TABLE `waste_management_ecm`.`procurement`.`source_list` ALTER COLUMN `plant_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `waste_management_ecm`.`procurement`.`source_list` ALTER COLUMN `preferred_vendor_rank` SET TAGS ('dbx_business_glossary_term' = 'Preferred Vendor Rank');
ALTER TABLE `waste_management_ecm`.`procurement`.`source_list` ALTER COLUMN `purchasing_organization_code` SET TAGS ('dbx_business_glossary_term' = 'Purchasing Organization Code');
ALTER TABLE `waste_management_ecm`.`procurement`.`source_list` ALTER COLUMN `purchasing_organization_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `waste_management_ecm`.`procurement`.`source_list` ALTER COLUMN `quota_arrangement_number` SET TAGS ('dbx_business_glossary_term' = 'Quota Arrangement Number');
ALTER TABLE `waste_management_ecm`.`procurement`.`source_list` ALTER COLUMN `quota_arrangement_number` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `waste_management_ecm`.`procurement`.`source_list` ALTER COLUMN `record_number` SET TAGS ('dbx_business_glossary_term' = 'Source List Record Number');
ALTER TABLE `waste_management_ecm`.`procurement`.`source_list` ALTER COLUMN `record_number` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `waste_management_ecm`.`procurement`.`source_list` ALTER COLUMN `source_determination_rule` SET TAGS ('dbx_business_glossary_term' = 'Source Determination Rule');
ALTER TABLE `waste_management_ecm`.`procurement`.`source_list` ALTER COLUMN `source_determination_rule` SET TAGS ('dbx_value_regex' = 'automatic|manual|quota_arrangement');
ALTER TABLE `waste_management_ecm`.`procurement`.`source_list` ALTER COLUMN `standard_delivery_lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Standard Delivery Lead Time (Days)');
ALTER TABLE `waste_management_ecm`.`procurement`.`source_list` ALTER COLUMN `validity_end_date` SET TAGS ('dbx_business_glossary_term' = 'Validity End Date');
ALTER TABLE `waste_management_ecm`.`procurement`.`source_list` ALTER COLUMN `validity_start_date` SET TAGS ('dbx_business_glossary_term' = 'Validity Start Date');
ALTER TABLE `waste_management_ecm`.`procurement`.`source_list` ALTER COLUMN `vendor_material_number` SET TAGS ('dbx_business_glossary_term' = 'Vendor Material Number');
ALTER TABLE `waste_management_ecm`.`procurement`.`spend_category` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `waste_management_ecm`.`procurement`.`spend_category` SET TAGS ('dbx_subdomain' = 'supplier_management');
ALTER TABLE `waste_management_ecm`.`procurement`.`spend_category` ALTER COLUMN `spend_category_id` SET TAGS ('dbx_business_glossary_term' = 'Spend Category ID');
ALTER TABLE `waste_management_ecm`.`procurement`.`spend_category` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Category Owner Employee ID');
ALTER TABLE `waste_management_ecm`.`procurement`.`spend_category` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`procurement`.`spend_category` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `waste_management_ecm`.`procurement`.`spend_category` ALTER COLUMN `parent_category_spend_category_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Spend Category ID');
ALTER TABLE `waste_management_ecm`.`procurement`.`spend_category` ALTER COLUMN `primary_spend_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `waste_management_ecm`.`procurement`.`spend_category` ALTER COLUMN `primary_spend_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`procurement`.`spend_category` ALTER COLUMN `primary_spend_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `waste_management_ecm`.`procurement`.`spend_category` ALTER COLUMN `annual_spend_budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Annual Spend Budget Amount');
ALTER TABLE `waste_management_ecm`.`procurement`.`spend_category` ALTER COLUMN `approval_workflow_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Approval Workflow Required Flag');
ALTER TABLE `waste_management_ecm`.`procurement`.`spend_category` ALTER COLUMN `budget_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Budget Currency Code');
ALTER TABLE `waste_management_ecm`.`procurement`.`spend_category` ALTER COLUMN `budget_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `waste_management_ecm`.`procurement`.`spend_category` ALTER COLUMN `category_code` SET TAGS ('dbx_business_glossary_term' = 'Spend Category Code');
ALTER TABLE `waste_management_ecm`.`procurement`.`spend_category` ALTER COLUMN `category_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,12}$');
ALTER TABLE `waste_management_ecm`.`procurement`.`spend_category` ALTER COLUMN `category_description` SET TAGS ('dbx_business_glossary_term' = 'Spend Category Description');
ALTER TABLE `waste_management_ecm`.`procurement`.`spend_category` ALTER COLUMN `category_name` SET TAGS ('dbx_business_glossary_term' = 'Spend Category Name');
ALTER TABLE `waste_management_ecm`.`procurement`.`spend_category` ALTER COLUMN `category_type` SET TAGS ('dbx_business_glossary_term' = 'Spend Category Type');
ALTER TABLE `waste_management_ecm`.`procurement`.`spend_category` ALTER COLUMN `category_type` SET TAGS ('dbx_value_regex' = 'Goods|Services|Both');
ALTER TABLE `waste_management_ecm`.`procurement`.`spend_category` ALTER COLUMN `cogs_classification` SET TAGS ('dbx_business_glossary_term' = 'Cost of Goods Sold (COGS) Classification');
ALTER TABLE `waste_management_ecm`.`procurement`.`spend_category` ALTER COLUMN `cogs_classification` SET TAGS ('dbx_value_regex' = 'Direct COGS|Indirect COGS|Operating Expense|Capital Expenditure|Non-Operating');
ALTER TABLE `waste_management_ecm`.`procurement`.`spend_category` ALTER COLUMN `commodity_code` SET TAGS ('dbx_business_glossary_term' = 'Commodity Code');
ALTER TABLE `waste_management_ecm`.`procurement`.`spend_category` ALTER COLUMN `commodity_code` SET TAGS ('dbx_value_regex' = '^[0-9]{8,10}$');
ALTER TABLE `waste_management_ecm`.`procurement`.`spend_category` ALTER COLUMN `contract_coverage_percent` SET TAGS ('dbx_business_glossary_term' = 'Contract Coverage Percentage');
ALTER TABLE `waste_management_ecm`.`procurement`.`spend_category` ALTER COLUMN `cost_element_group` SET TAGS ('dbx_business_glossary_term' = 'Cost Element Group');
ALTER TABLE `waste_management_ecm`.`procurement`.`spend_category` ALTER COLUMN `cost_element_group` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{2,20}$');
ALTER TABLE `waste_management_ecm`.`procurement`.`spend_category` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `waste_management_ecm`.`procurement`.`spend_category` ALTER COLUMN `ebitda_impact_flag` SET TAGS ('dbx_business_glossary_term' = 'Earnings Before Interest Taxes Depreciation and Amortization (EBITDA) Impact Flag');
ALTER TABLE `waste_management_ecm`.`procurement`.`spend_category` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `waste_management_ecm`.`procurement`.`spend_category` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `waste_management_ecm`.`procurement`.`spend_category` ALTER COLUMN `environmental_compliance_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Environmental Compliance Required Flag');
ALTER TABLE `waste_management_ecm`.`procurement`.`spend_category` ALTER COLUMN `gl_account_range_end` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Range End');
ALTER TABLE `waste_management_ecm`.`procurement`.`spend_category` ALTER COLUMN `gl_account_range_end` SET TAGS ('dbx_value_regex' = '^[0-9]{6,10}$');
ALTER TABLE `waste_management_ecm`.`procurement`.`spend_category` ALTER COLUMN `gl_account_range_start` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Range Start');
ALTER TABLE `waste_management_ecm`.`procurement`.`spend_category` ALTER COLUMN `gl_account_range_start` SET TAGS ('dbx_value_regex' = '^[0-9]{6,10}$');
ALTER TABLE `waste_management_ecm`.`procurement`.`spend_category` ALTER COLUMN `hazardous_material_flag` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Material Flag');
ALTER TABLE `waste_management_ecm`.`procurement`.`spend_category` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `waste_management_ecm`.`procurement`.`spend_category` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `waste_management_ecm`.`procurement`.`spend_category` ALTER COLUMN `level_1_category` SET TAGS ('dbx_business_glossary_term' = 'Level 1 Spend Category');
ALTER TABLE `waste_management_ecm`.`procurement`.`spend_category` ALTER COLUMN `level_1_category` SET TAGS ('dbx_value_regex' = 'Direct Operations|Indirect|Capital');
ALTER TABLE `waste_management_ecm`.`procurement`.`spend_category` ALTER COLUMN `level_2_category` SET TAGS ('dbx_business_glossary_term' = 'Level 2 Spend Category');
ALTER TABLE `waste_management_ecm`.`procurement`.`spend_category` ALTER COLUMN `level_3_category` SET TAGS ('dbx_business_glossary_term' = 'Level 3 Spend Category');
ALTER TABLE `waste_management_ecm`.`procurement`.`spend_category` ALTER COLUMN `minimum_order_value` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Value');
ALTER TABLE `waste_management_ecm`.`procurement`.`spend_category` ALTER COLUMN `next_review_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Due Date');
ALTER TABLE `waste_management_ecm`.`procurement`.`spend_category` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Spend Category Notes');
ALTER TABLE `waste_management_ecm`.`procurement`.`spend_category` ALTER COLUMN `preferred_vendor_count` SET TAGS ('dbx_business_glossary_term' = 'Preferred Vendor Count');
ALTER TABLE `waste_management_ecm`.`procurement`.`spend_category` ALTER COLUMN `safety_certification_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Safety Certification Required Flag');
ALTER TABLE `waste_management_ecm`.`procurement`.`spend_category` ALTER COLUMN `spend_category_status` SET TAGS ('dbx_business_glossary_term' = 'Spend Category Status');
ALTER TABLE `waste_management_ecm`.`procurement`.`spend_category` ALTER COLUMN `spend_category_status` SET TAGS ('dbx_value_regex' = 'Active|Inactive|Deprecated|Pending Approval');
ALTER TABLE `waste_management_ecm`.`procurement`.`spend_category` ALTER COLUMN `strategic_sourcing_priority` SET TAGS ('dbx_business_glossary_term' = 'Strategic Sourcing Priority');
ALTER TABLE `waste_management_ecm`.`procurement`.`spend_category` ALTER COLUMN `strategic_sourcing_priority` SET TAGS ('dbx_value_regex' = 'Critical|High|Medium|Low');
ALTER TABLE `waste_management_ecm`.`procurement`.`approval_workflow` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `waste_management_ecm`.`procurement`.`approval_workflow` SET TAGS ('dbx_subdomain' = 'order_processing');
ALTER TABLE `waste_management_ecm`.`procurement`.`approval_workflow` ALTER COLUMN `approval_workflow_id` SET TAGS ('dbx_business_glossary_term' = 'Approval Workflow Instance ID');
ALTER TABLE `waste_management_ecm`.`procurement`.`approval_workflow` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Approver Employee ID');
ALTER TABLE `waste_management_ecm`.`procurement`.`approval_workflow` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`procurement`.`approval_workflow` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `waste_management_ecm`.`procurement`.`approval_workflow` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`procurement`.`approval_workflow` ALTER COLUMN `requester_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Requester Employee ID');
ALTER TABLE `waste_management_ecm`.`procurement`.`approval_workflow` ALTER COLUMN `requester_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`procurement`.`approval_workflow` ALTER COLUMN `requester_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `waste_management_ecm`.`procurement`.`approval_workflow` ALTER COLUMN `rfq_id` SET TAGS ('dbx_business_glossary_term' = 'Rfq Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`procurement`.`approval_workflow` ALTER COLUMN `sourcing_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Sourcing Contract Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`procurement`.`approval_workflow` ALTER COLUMN `action_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Action Timestamp');
ALTER TABLE `waste_management_ecm`.`procurement`.`approval_workflow` ALTER COLUMN `approval_action` SET TAGS ('dbx_business_glossary_term' = 'Approval Action');
ALTER TABLE `waste_management_ecm`.`procurement`.`approval_workflow` ALTER COLUMN `approval_action` SET TAGS ('dbx_value_regex' = 'approve|reject|delegate|request_info|escalate|withdraw');
ALTER TABLE `waste_management_ecm`.`procurement`.`approval_workflow` ALTER COLUMN `approval_comments` SET TAGS ('dbx_business_glossary_term' = 'Approval Comments');
ALTER TABLE `waste_management_ecm`.`procurement`.`approval_workflow` ALTER COLUMN `approval_step_sequence` SET TAGS ('dbx_business_glossary_term' = 'Approval Step Sequence');
ALTER TABLE `waste_management_ecm`.`procurement`.`approval_workflow` ALTER COLUMN `approver_role` SET TAGS ('dbx_business_glossary_term' = 'Approver Role');
ALTER TABLE `waste_management_ecm`.`procurement`.`approval_workflow` ALTER COLUMN `assigned_approver_email` SET TAGS ('dbx_business_glossary_term' = 'Assigned Approver Email Address');
ALTER TABLE `waste_management_ecm`.`procurement`.`approval_workflow` ALTER COLUMN `assigned_approver_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `waste_management_ecm`.`procurement`.`approval_workflow` ALTER COLUMN `assigned_approver_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`procurement`.`approval_workflow` ALTER COLUMN `assigned_approver_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `waste_management_ecm`.`procurement`.`approval_workflow` ALTER COLUMN `assigned_approver_name` SET TAGS ('dbx_business_glossary_term' = 'Assigned Approver Name');
ALTER TABLE `waste_management_ecm`.`procurement`.`approval_workflow` ALTER COLUMN `budget_check_status` SET TAGS ('dbx_business_glossary_term' = 'Budget Check Status');
ALTER TABLE `waste_management_ecm`.`procurement`.`approval_workflow` ALTER COLUMN `budget_check_status` SET TAGS ('dbx_value_regex' = 'passed|failed|warning|not_required');
ALTER TABLE `waste_management_ecm`.`procurement`.`approval_workflow` ALTER COLUMN `budget_check_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Budget Check Timestamp');
ALTER TABLE `waste_management_ecm`.`procurement`.`approval_workflow` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `waste_management_ecm`.`procurement`.`approval_workflow` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `waste_management_ecm`.`procurement`.`approval_workflow` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `waste_management_ecm`.`procurement`.`approval_workflow` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `waste_management_ecm`.`procurement`.`approval_workflow` ALTER COLUMN `delegated_to_approver_name` SET TAGS ('dbx_business_glossary_term' = 'Delegated To Approver Name');
ALTER TABLE `waste_management_ecm`.`procurement`.`approval_workflow` ALTER COLUMN `delegation_reason` SET TAGS ('dbx_business_glossary_term' = 'Delegation Reason');
ALTER TABLE `waste_management_ecm`.`procurement`.`approval_workflow` ALTER COLUMN `document_number` SET TAGS ('dbx_business_glossary_term' = 'Document Number');
ALTER TABLE `waste_management_ecm`.`procurement`.`approval_workflow` ALTER COLUMN `document_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Document Reference ID');
ALTER TABLE `waste_management_ecm`.`procurement`.`approval_workflow` ALTER COLUMN `document_type` SET TAGS ('dbx_business_glossary_term' = 'Document Type');
ALTER TABLE `waste_management_ecm`.`procurement`.`approval_workflow` ALTER COLUMN `document_type` SET TAGS ('dbx_value_regex' = 'purchase_requisition|purchase_order|contract|rfq|service_entry_sheet|blanket_order');
ALTER TABLE `waste_management_ecm`.`procurement`.`approval_workflow` ALTER COLUMN `escalation_flag` SET TAGS ('dbx_business_glossary_term' = 'Escalation Flag');
ALTER TABLE `waste_management_ecm`.`procurement`.`approval_workflow` ALTER COLUMN `escalation_reason` SET TAGS ('dbx_business_glossary_term' = 'Escalation Reason');
ALTER TABLE `waste_management_ecm`.`procurement`.`approval_workflow` ALTER COLUMN `escalation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Escalation Timestamp');
ALTER TABLE `waste_management_ecm`.`procurement`.`approval_workflow` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `waste_management_ecm`.`procurement`.`approval_workflow` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `waste_management_ecm`.`procurement`.`approval_workflow` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `waste_management_ecm`.`procurement`.`approval_workflow` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'low|normal|high|urgent');
ALTER TABLE `waste_management_ecm`.`procurement`.`approval_workflow` ALTER COLUMN `rejection_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason Code');
ALTER TABLE `waste_management_ecm`.`procurement`.`approval_workflow` ALTER COLUMN `requester_department` SET TAGS ('dbx_business_glossary_term' = 'Requester Department');
ALTER TABLE `waste_management_ecm`.`procurement`.`approval_workflow` ALTER COLUMN `requester_name` SET TAGS ('dbx_business_glossary_term' = 'Requester Name');
ALTER TABLE `waste_management_ecm`.`procurement`.`approval_workflow` ALTER COLUMN `segregation_of_duties_check_status` SET TAGS ('dbx_business_glossary_term' = 'Segregation of Duties (SOD) Check Status');
ALTER TABLE `waste_management_ecm`.`procurement`.`approval_workflow` ALTER COLUMN `segregation_of_duties_check_status` SET TAGS ('dbx_value_regex' = 'passed|failed|not_applicable');
ALTER TABLE `waste_management_ecm`.`procurement`.`approval_workflow` ALTER COLUMN `sla_actual_hours` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Actual Hours');
ALTER TABLE `waste_management_ecm`.`procurement`.`approval_workflow` ALTER COLUMN `sla_breach_flag` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Breach Flag');
ALTER TABLE `waste_management_ecm`.`procurement`.`approval_workflow` ALTER COLUMN `sla_target_hours` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Target Hours');
ALTER TABLE `waste_management_ecm`.`procurement`.`approval_workflow` ALTER COLUMN `sox_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Sarbanes-Oxley (SOX) Compliance Flag');
ALTER TABLE `waste_management_ecm`.`procurement`.`approval_workflow` ALTER COLUMN `spend_amount` SET TAGS ('dbx_business_glossary_term' = 'Spend Amount');
ALTER TABLE `waste_management_ecm`.`procurement`.`approval_workflow` ALTER COLUMN `spend_threshold_tier` SET TAGS ('dbx_business_glossary_term' = 'Spend Threshold Tier');
ALTER TABLE `waste_management_ecm`.`procurement`.`approval_workflow` ALTER COLUMN `total_approval_steps` SET TAGS ('dbx_business_glossary_term' = 'Total Approval Steps');
ALTER TABLE `waste_management_ecm`.`procurement`.`approval_workflow` ALTER COLUMN `workflow_completed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Workflow Completed Timestamp');
ALTER TABLE `waste_management_ecm`.`procurement`.`approval_workflow` ALTER COLUMN `workflow_initiated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Workflow Initiated Timestamp');
ALTER TABLE `waste_management_ecm`.`procurement`.`approval_workflow` ALTER COLUMN `workflow_instance_number` SET TAGS ('dbx_business_glossary_term' = 'Workflow Instance Number');
ALTER TABLE `waste_management_ecm`.`procurement`.`approval_workflow` ALTER COLUMN `workflow_status` SET TAGS ('dbx_business_glossary_term' = 'Workflow Status');
ALTER TABLE `waste_management_ecm`.`procurement`.`invoice_exception` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `waste_management_ecm`.`procurement`.`invoice_exception` SET TAGS ('dbx_subdomain' = 'payment_reconciliation');
ALTER TABLE `waste_management_ecm`.`procurement`.`invoice_exception` ALTER COLUMN `invoice_exception_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Exception Identifier (ID)');
ALTER TABLE `waste_management_ecm`.`procurement`.`invoice_exception` ALTER COLUMN `goods_receipt_id` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt (GR) Identifier (ID)');
ALTER TABLE `waste_management_ecm`.`procurement`.`invoice_exception` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Identifier (ID)');
ALTER TABLE `waste_management_ecm`.`procurement`.`invoice_exception` ALTER COLUMN `material_id` SET TAGS ('dbx_business_glossary_term' = 'Material Identifier (ID)');
ALTER TABLE `waste_management_ecm`.`procurement`.`invoice_exception` ALTER COLUMN `po_line_id` SET TAGS ('dbx_business_glossary_term' = 'Po Line Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`procurement`.`invoice_exception` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Resolver Employee Identifier (ID)');
ALTER TABLE `waste_management_ecm`.`procurement`.`invoice_exception` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`procurement`.`invoice_exception` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `waste_management_ecm`.`procurement`.`invoice_exception` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Identifier (ID)');
ALTER TABLE `waste_management_ecm`.`procurement`.`invoice_exception` ALTER COLUMN `tertiary_invoice_last_modified_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User Identifier (ID)');
ALTER TABLE `waste_management_ecm`.`procurement`.`invoice_exception` ALTER COLUMN `tertiary_invoice_last_modified_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`procurement`.`invoice_exception` ALTER COLUMN `tertiary_invoice_last_modified_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `waste_management_ecm`.`procurement`.`invoice_exception` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Identifier (ID)');
ALTER TABLE `waste_management_ecm`.`procurement`.`invoice_exception` ALTER COLUMN `vendor_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Invoice Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`procurement`.`invoice_exception` ALTER COLUMN `audit_trail_reference` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail Reference');
ALTER TABLE `waste_management_ecm`.`procurement`.`invoice_exception` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `waste_management_ecm`.`procurement`.`invoice_exception` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `waste_management_ecm`.`procurement`.`invoice_exception` ALTER COLUMN `credit_memo_number` SET TAGS ('dbx_business_glossary_term' = 'Credit Memo Number');
ALTER TABLE `waste_management_ecm`.`procurement`.`invoice_exception` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `waste_management_ecm`.`procurement`.`invoice_exception` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `waste_management_ecm`.`procurement`.`invoice_exception` ALTER COLUMN `escalation_level` SET TAGS ('dbx_business_glossary_term' = 'Escalation Level');
ALTER TABLE `waste_management_ecm`.`procurement`.`invoice_exception` ALTER COLUMN `exception_amount` SET TAGS ('dbx_business_glossary_term' = 'Exception Amount');
ALTER TABLE `waste_management_ecm`.`procurement`.`invoice_exception` ALTER COLUMN `exception_detected_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Exception Detected Timestamp');
ALTER TABLE `waste_management_ecm`.`procurement`.`invoice_exception` ALTER COLUMN `exception_status` SET TAGS ('dbx_business_glossary_term' = 'Exception Status');
ALTER TABLE `waste_management_ecm`.`procurement`.`invoice_exception` ALTER COLUMN `exception_status` SET TAGS ('dbx_value_regex' = 'open|under_review|pending_vendor_response|resolved|rejected|escalated');
ALTER TABLE `waste_management_ecm`.`procurement`.`invoice_exception` ALTER COLUMN `exception_type` SET TAGS ('dbx_business_glossary_term' = 'Exception Type');
ALTER TABLE `waste_management_ecm`.`procurement`.`invoice_exception` ALTER COLUMN `final_disposition` SET TAGS ('dbx_business_glossary_term' = 'Final Disposition');
ALTER TABLE `waste_management_ecm`.`procurement`.`invoice_exception` ALTER COLUMN `final_disposition` SET TAGS ('dbx_value_regex' = 'accepted|rejected|credit_memo_requested|po_adjusted|cancelled');
ALTER TABLE `waste_management_ecm`.`procurement`.`invoice_exception` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `waste_management_ecm`.`procurement`.`invoice_exception` ALTER COLUMN `gr_quantity` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt (GR) Quantity');
ALTER TABLE `waste_management_ecm`.`procurement`.`invoice_exception` ALTER COLUMN `invoice_exception_number` SET TAGS ('dbx_business_glossary_term' = 'Invoice Exception Number');
ALTER TABLE `waste_management_ecm`.`procurement`.`invoice_exception` ALTER COLUMN `invoice_quantity` SET TAGS ('dbx_business_glossary_term' = 'Invoice Quantity');
ALTER TABLE `waste_management_ecm`.`procurement`.`invoice_exception` ALTER COLUMN `invoice_unit_price` SET TAGS ('dbx_business_glossary_term' = 'Invoice Unit Price');
ALTER TABLE `waste_management_ecm`.`procurement`.`invoice_exception` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `waste_management_ecm`.`procurement`.`invoice_exception` ALTER COLUMN `plant_code` SET TAGS ('dbx_business_glossary_term' = 'Plant Code');
ALTER TABLE `waste_management_ecm`.`procurement`.`invoice_exception` ALTER COLUMN `po_quantity` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Quantity');
ALTER TABLE `waste_management_ecm`.`procurement`.`invoice_exception` ALTER COLUMN `po_unit_price` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Unit Price');
ALTER TABLE `waste_management_ecm`.`procurement`.`invoice_exception` ALTER COLUMN `price_variance_amount` SET TAGS ('dbx_business_glossary_term' = 'Price Variance Amount');
ALTER TABLE `waste_management_ecm`.`procurement`.`invoice_exception` ALTER COLUMN `quantity_variance` SET TAGS ('dbx_business_glossary_term' = 'Quantity Variance');
ALTER TABLE `waste_management_ecm`.`procurement`.`invoice_exception` ALTER COLUMN `resolution_action` SET TAGS ('dbx_business_glossary_term' = 'Resolution Action');
ALTER TABLE `waste_management_ecm`.`procurement`.`invoice_exception` ALTER COLUMN `resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Resolution Date');
ALTER TABLE `waste_management_ecm`.`procurement`.`invoice_exception` ALTER COLUMN `resolution_notes` SET TAGS ('dbx_business_glossary_term' = 'Resolution Notes');
ALTER TABLE `waste_management_ecm`.`procurement`.`invoice_exception` ALTER COLUMN `sox_control_flag` SET TAGS ('dbx_business_glossary_term' = 'Sarbanes-Oxley (SOX) Control Flag');
ALTER TABLE `waste_management_ecm`.`procurement`.`invoice_exception` ALTER COLUMN `tolerance_breached_flag` SET TAGS ('dbx_business_glossary_term' = 'Tolerance Breached Flag');
ALTER TABLE `waste_management_ecm`.`procurement`.`invoice_exception` ALTER COLUMN `tolerance_threshold_amount` SET TAGS ('dbx_business_glossary_term' = 'Tolerance Threshold Amount');
ALTER TABLE `waste_management_ecm`.`procurement`.`invoice_exception` ALTER COLUMN `tolerance_threshold_percent` SET TAGS ('dbx_business_glossary_term' = 'Tolerance Threshold Percentage');
ALTER TABLE `waste_management_ecm`.`procurement`.`invoice_exception` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `waste_management_ecm`.`procurement`.`invoice_exception` ALTER COLUMN `vendor_response_date` SET TAGS ('dbx_business_glossary_term' = 'Vendor Response Date');
ALTER TABLE `waste_management_ecm`.`procurement`.`fuel_purchase` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `waste_management_ecm`.`procurement`.`fuel_purchase` SET TAGS ('dbx_subdomain' = 'order_processing');
ALTER TABLE `waste_management_ecm`.`procurement`.`fuel_purchase` ALTER COLUMN `fuel_purchase_id` SET TAGS ('dbx_business_glossary_term' = 'Fuel Purchase Identifier (ID)');
ALTER TABLE `waste_management_ecm`.`procurement`.`fuel_purchase` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approver Employee Identifier (ID)');
ALTER TABLE `waste_management_ecm`.`procurement`.`fuel_purchase` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`procurement`.`fuel_purchase` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `waste_management_ecm`.`procurement`.`fuel_purchase` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Site Identifier (ID)');
ALTER TABLE `waste_management_ecm`.`procurement`.`fuel_purchase` ALTER COLUMN `goods_receipt_id` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`procurement`.`fuel_purchase` ALTER COLUMN `material_id` SET TAGS ('dbx_business_glossary_term' = 'Material Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`procurement`.`fuel_purchase` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Identifier (ID)');
ALTER TABLE `waste_management_ecm`.`procurement`.`fuel_purchase` ALTER COLUMN `receiving_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Receiving Employee Identifier (ID)');
ALTER TABLE `waste_management_ecm`.`procurement`.`fuel_purchase` ALTER COLUMN `receiving_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`procurement`.`fuel_purchase` ALTER COLUMN `receiving_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `waste_management_ecm`.`procurement`.`fuel_purchase` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Identifier (ID)');
ALTER TABLE `waste_management_ecm`.`procurement`.`fuel_purchase` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `waste_management_ecm`.`procurement`.`fuel_purchase` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `waste_management_ecm`.`procurement`.`fuel_purchase` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected');
ALTER TABLE `waste_management_ecm`.`procurement`.`fuel_purchase` ALTER COLUMN `bol_number` SET TAGS ('dbx_business_glossary_term' = 'Bill of Lading (BOL) Number');
ALTER TABLE `waste_management_ecm`.`procurement`.`fuel_purchase` ALTER COLUMN `carbon_intensity_score` SET TAGS ('dbx_business_glossary_term' = 'Carbon Intensity (CI) Score');
ALTER TABLE `waste_management_ecm`.`procurement`.`fuel_purchase` ALTER COLUMN `company_code` SET TAGS ('dbx_business_glossary_term' = 'Company Code');
ALTER TABLE `waste_management_ecm`.`procurement`.`fuel_purchase` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `waste_management_ecm`.`procurement`.`fuel_purchase` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `waste_management_ecm`.`procurement`.`fuel_purchase` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `waste_management_ecm`.`procurement`.`fuel_purchase` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|CAD|MXN|EUR|GBP');
ALTER TABLE `waste_management_ecm`.`procurement`.`fuel_purchase` ALTER COLUMN `delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Fuel Delivery Date');
ALTER TABLE `waste_management_ecm`.`procurement`.`fuel_purchase` ALTER COLUMN `delivery_note_number` SET TAGS ('dbx_business_glossary_term' = 'Delivery Note Number');
ALTER TABLE `waste_management_ecm`.`procurement`.`fuel_purchase` ALTER COLUMN `delivery_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Fuel Delivery Timestamp');
ALTER TABLE `waste_management_ecm`.`procurement`.`fuel_purchase` ALTER COLUMN `freight_charge` SET TAGS ('dbx_business_glossary_term' = 'Freight Charge');
ALTER TABLE `waste_management_ecm`.`procurement`.`fuel_purchase` ALTER COLUMN `fuel_type` SET TAGS ('dbx_business_glossary_term' = 'Fuel Type');
ALTER TABLE `waste_management_ecm`.`procurement`.`fuel_purchase` ALTER COLUMN `fuel_type` SET TAGS ('dbx_value_regex' = 'diesel|cng|rng|def|gasoline|biodiesel');
ALTER TABLE `waste_management_ecm`.`procurement`.`fuel_purchase` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `waste_management_ecm`.`procurement`.`fuel_purchase` ALTER COLUMN `invoice_date` SET TAGS ('dbx_business_glossary_term' = 'Vendor Invoice Date');
ALTER TABLE `waste_management_ecm`.`procurement`.`fuel_purchase` ALTER COLUMN `invoice_number` SET TAGS ('dbx_business_glossary_term' = 'Vendor Invoice Number');
ALTER TABLE `waste_management_ecm`.`procurement`.`fuel_purchase` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `waste_management_ecm`.`procurement`.`fuel_purchase` ALTER COLUMN `net_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Purchase Amount');
ALTER TABLE `waste_management_ecm`.`procurement`.`fuel_purchase` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Purchase Notes');
ALTER TABLE `waste_management_ecm`.`procurement`.`fuel_purchase` ALTER COLUMN `payment_terms_code` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms Code');
ALTER TABLE `waste_management_ecm`.`procurement`.`fuel_purchase` ALTER COLUMN `plant_code` SET TAGS ('dbx_business_glossary_term' = 'Plant Code');
ALTER TABLE `waste_management_ecm`.`procurement`.`fuel_purchase` ALTER COLUMN `purchase_number` SET TAGS ('dbx_business_glossary_term' = 'Fuel Purchase Number');
ALTER TABLE `waste_management_ecm`.`procurement`.`fuel_purchase` ALTER COLUMN `purchase_status` SET TAGS ('dbx_business_glossary_term' = 'Fuel Purchase Status');
ALTER TABLE `waste_management_ecm`.`procurement`.`fuel_purchase` ALTER COLUMN `purchase_status` SET TAGS ('dbx_value_regex' = 'ordered|delivered|invoiced|paid|cancelled');
ALTER TABLE `waste_management_ecm`.`procurement`.`fuel_purchase` ALTER COLUMN `purchasing_group` SET TAGS ('dbx_business_glossary_term' = 'Purchasing Group');
ALTER TABLE `waste_management_ecm`.`procurement`.`fuel_purchase` ALTER COLUMN `purchasing_organization` SET TAGS ('dbx_business_glossary_term' = 'Purchasing Organization');
ALTER TABLE `waste_management_ecm`.`procurement`.`fuel_purchase` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Fuel Quantity');
ALTER TABLE `waste_management_ecm`.`procurement`.`fuel_purchase` ALTER COLUMN `renewable_fuel_flag` SET TAGS ('dbx_business_glossary_term' = 'Renewable Fuel Flag');
ALTER TABLE `waste_management_ecm`.`procurement`.`fuel_purchase` ALTER COLUMN `tank_gauge_reading_post_delivery` SET TAGS ('dbx_business_glossary_term' = 'Tank Gauge Reading Post-Delivery');
ALTER TABLE `waste_management_ecm`.`procurement`.`fuel_purchase` ALTER COLUMN `tank_gauge_reading_pre_delivery` SET TAGS ('dbx_business_glossary_term' = 'Tank Gauge Reading Pre-Delivery');
ALTER TABLE `waste_management_ecm`.`procurement`.`fuel_purchase` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Fuel Tax Amount');
ALTER TABLE `waste_management_ecm`.`procurement`.`fuel_purchase` ALTER COLUMN `total_cost` SET TAGS ('dbx_business_glossary_term' = 'Total Fuel Purchase Cost');
ALTER TABLE `waste_management_ecm`.`procurement`.`fuel_purchase` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `waste_management_ecm`.`procurement`.`fuel_purchase` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'gallons|gge|liters|kg');
ALTER TABLE `waste_management_ecm`.`procurement`.`fuel_purchase` ALTER COLUMN `unit_price` SET TAGS ('dbx_business_glossary_term' = 'Fuel Unit Price');
ALTER TABLE `waste_management_ecm`.`procurement`.`disposal_purchase_order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `waste_management_ecm`.`procurement`.`disposal_purchase_order` SET TAGS ('dbx_subdomain' = 'order_processing');
ALTER TABLE `waste_management_ecm`.`procurement`.`disposal_purchase_order` ALTER COLUMN `disposal_purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Disposal Purchase Order (PO) Identifier');
ALTER TABLE `waste_management_ecm`.`procurement`.`disposal_purchase_order` ALTER COLUMN `approver_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approver Employee Identifier');
ALTER TABLE `waste_management_ecm`.`procurement`.`disposal_purchase_order` ALTER COLUMN `approver_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`procurement`.`disposal_purchase_order` ALTER COLUMN `approver_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `waste_management_ecm`.`procurement`.`disposal_purchase_order` ALTER COLUMN `offering_id` SET TAGS ('dbx_business_glossary_term' = 'Disposal Service Offering Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`procurement`.`disposal_purchase_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User Identifier');
ALTER TABLE `waste_management_ecm`.`procurement`.`disposal_purchase_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`procurement`.`disposal_purchase_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `waste_management_ecm`.`procurement`.`disposal_purchase_order` ALTER COLUMN `epa_id_registration_id` SET TAGS ('dbx_business_glossary_term' = 'Treatment Storage and Disposal Facility (TSDF) Environmental Protection Agency (EPA) Identification Number');
ALTER TABLE `waste_management_ecm`.`procurement`.`disposal_purchase_order` ALTER COLUMN `epa_id_registration_id` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}[0-9]{9}$');
ALTER TABLE `waste_management_ecm`.`procurement`.`disposal_purchase_order` ALTER COLUMN `last_modified_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User Identifier');
ALTER TABLE `waste_management_ecm`.`procurement`.`disposal_purchase_order` ALTER COLUMN `last_modified_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`procurement`.`disposal_purchase_order` ALTER COLUMN `last_modified_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `waste_management_ecm`.`procurement`.`disposal_purchase_order` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Originating Facility Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`procurement`.`disposal_purchase_order` ALTER COLUMN `requester_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Requester Employee Identifier');
ALTER TABLE `waste_management_ecm`.`procurement`.`disposal_purchase_order` ALTER COLUMN `requester_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`procurement`.`disposal_purchase_order` ALTER COLUMN `requester_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `waste_management_ecm`.`procurement`.`disposal_purchase_order` ALTER COLUMN `tsdf_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Tsdf Facility Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`procurement`.`disposal_purchase_order` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Identifier');
ALTER TABLE `waste_management_ecm`.`procurement`.`disposal_purchase_order` ALTER COLUMN `waste_stream_id` SET TAGS ('dbx_business_glossary_term' = 'Waste Stream Id (Foreign Key)');
ALTER TABLE `waste_management_ecm`.`procurement`.`disposal_purchase_order` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `waste_management_ecm`.`procurement`.`disposal_purchase_order` ALTER COLUMN `company_code` SET TAGS ('dbx_business_glossary_term' = 'Company Code');
ALTER TABLE `waste_management_ecm`.`procurement`.`disposal_purchase_order` ALTER COLUMN `company_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `waste_management_ecm`.`procurement`.`disposal_purchase_order` ALTER COLUMN `contract_number` SET TAGS ('dbx_business_glossary_term' = 'Contract Number');
ALTER TABLE `waste_management_ecm`.`procurement`.`disposal_purchase_order` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `waste_management_ecm`.`procurement`.`disposal_purchase_order` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{10}$');
ALTER TABLE `waste_management_ecm`.`procurement`.`disposal_purchase_order` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `waste_management_ecm`.`procurement`.`disposal_purchase_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `waste_management_ecm`.`procurement`.`disposal_purchase_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `waste_management_ecm`.`procurement`.`disposal_purchase_order` ALTER COLUMN `delivery_location` SET TAGS ('dbx_business_glossary_term' = 'Delivery Location');
ALTER TABLE `waste_management_ecm`.`procurement`.`disposal_purchase_order` ALTER COLUMN `disposal_site_permit_number` SET TAGS ('dbx_business_glossary_term' = 'Disposal Site Permit Number');
ALTER TABLE `waste_management_ecm`.`procurement`.`disposal_purchase_order` ALTER COLUMN `estimated_tonnage` SET TAGS ('dbx_business_glossary_term' = 'Estimated Tonnage');
ALTER TABLE `waste_management_ecm`.`procurement`.`disposal_purchase_order` ALTER COLUMN `estimated_total_amount` SET TAGS ('dbx_business_glossary_term' = 'Estimated Total Amount');
ALTER TABLE `waste_management_ecm`.`procurement`.`disposal_purchase_order` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `waste_management_ecm`.`procurement`.`disposal_purchase_order` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_value_regex' = '^[0-9]{6,10}$');
ALTER TABLE `waste_management_ecm`.`procurement`.`disposal_purchase_order` ALTER COLUMN `incoterms_code` SET TAGS ('dbx_business_glossary_term' = 'International Commercial Terms (Incoterms) Code');
ALTER TABLE `waste_management_ecm`.`procurement`.`disposal_purchase_order` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `waste_management_ecm`.`procurement`.`disposal_purchase_order` ALTER COLUMN `manifest_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Manifest Required Flag');
ALTER TABLE `waste_management_ecm`.`procurement`.`disposal_purchase_order` ALTER COLUMN `net_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Amount');
ALTER TABLE `waste_management_ecm`.`procurement`.`disposal_purchase_order` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `waste_management_ecm`.`procurement`.`disposal_purchase_order` ALTER COLUMN `payment_terms_code` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms Code');
ALTER TABLE `waste_management_ecm`.`procurement`.`disposal_purchase_order` ALTER COLUMN `payment_terms_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `waste_management_ecm`.`procurement`.`disposal_purchase_order` ALTER COLUMN `po_date` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Date');
ALTER TABLE `waste_management_ecm`.`procurement`.`disposal_purchase_order` ALTER COLUMN `po_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Number');
ALTER TABLE `waste_management_ecm`.`procurement`.`disposal_purchase_order` ALTER COLUMN `po_number` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `waste_management_ecm`.`procurement`.`disposal_purchase_order` ALTER COLUMN `po_status` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Status');
ALTER TABLE `waste_management_ecm`.`procurement`.`disposal_purchase_order` ALTER COLUMN `po_type` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Type');
ALTER TABLE `waste_management_ecm`.`procurement`.`disposal_purchase_order` ALTER COLUMN `po_type` SET TAGS ('dbx_value_regex' = 'standard|blanket|contract_release|emergency|subcontracting');
ALTER TABLE `waste_management_ecm`.`procurement`.`disposal_purchase_order` ALTER COLUMN `purchasing_group` SET TAGS ('dbx_business_glossary_term' = 'Purchasing Group');
ALTER TABLE `waste_management_ecm`.`procurement`.`disposal_purchase_order` ALTER COLUMN `purchasing_group` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3}$');
ALTER TABLE `waste_management_ecm`.`procurement`.`disposal_purchase_order` ALTER COLUMN `purchasing_organization` SET TAGS ('dbx_business_glossary_term' = 'Purchasing Organization');
ALTER TABLE `waste_management_ecm`.`procurement`.`disposal_purchase_order` ALTER COLUMN `purchasing_organization` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `waste_management_ecm`.`procurement`.`disposal_purchase_order` ALTER COLUMN `regulatory_compliance_attestation` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Attestation');
ALTER TABLE `waste_management_ecm`.`procurement`.`disposal_purchase_order` ALTER COLUMN `regulatory_compliance_attestation` SET TAGS ('dbx_value_regex' = 'compliant|pending_review|non_compliant|exempted');
ALTER TABLE `waste_management_ecm`.`procurement`.`disposal_purchase_order` ALTER COLUMN `requested_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Requested Delivery Date');
ALTER TABLE `waste_management_ecm`.`procurement`.`disposal_purchase_order` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `waste_management_ecm`.`procurement`.`disposal_purchase_order` ALTER COLUMN `tipping_fee_per_unit` SET TAGS ('dbx_business_glossary_term' = 'Tipping Fee Per Unit');
ALTER TABLE `waste_management_ecm`.`procurement`.`disposal_purchase_order` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `waste_management_ecm`.`procurement`.`disposal_purchase_order` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'ton|cubic_yard|gallon|drum|container');
ALTER TABLE `waste_management_ecm`.`procurement`.`disposal_purchase_order` ALTER COLUMN `wbs_element` SET TAGS ('dbx_business_glossary_term' = 'Work Breakdown Structure (WBS) Element');
ALTER TABLE `waste_management_ecm`.`procurement`.`purchasing_info_record` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `waste_management_ecm`.`procurement`.`purchasing_info_record` SET TAGS ('dbx_subdomain' = 'supplier_management');
ALTER TABLE `waste_management_ecm`.`procurement`.`purchasing_info_record` SET TAGS ('dbx_association_edges' = 'procurement.vendor,procurement.material');
ALTER TABLE `waste_management_ecm`.`procurement`.`purchasing_info_record` ALTER COLUMN `purchasing_info_record_id` SET TAGS ('dbx_business_glossary_term' = 'purchasing_info_record Identifier');
ALTER TABLE `waste_management_ecm`.`procurement`.`purchasing_info_record` ALTER COLUMN `info_record_id` SET TAGS ('dbx_business_glossary_term' = 'Info Record ID');
ALTER TABLE `waste_management_ecm`.`procurement`.`purchasing_info_record` ALTER COLUMN `material_id` SET TAGS ('dbx_business_glossary_term' = 'Purchasing Info Record - Material Id');
ALTER TABLE `waste_management_ecm`.`procurement`.`purchasing_info_record` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `waste_management_ecm`.`procurement`.`purchasing_info_record` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `waste_management_ecm`.`procurement`.`purchasing_info_record` ALTER COLUMN `info_record_status` SET TAGS ('dbx_business_glossary_term' = 'Info Record Status');
ALTER TABLE `waste_management_ecm`.`procurement`.`purchasing_info_record` ALTER COLUMN `last_purchase_order_date` SET TAGS ('dbx_business_glossary_term' = 'Last Purchase Order Date');
ALTER TABLE `waste_management_ecm`.`procurement`.`purchasing_info_record` ALTER COLUMN `minimum_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity');
ALTER TABLE `waste_management_ecm`.`procurement`.`purchasing_info_record` ALTER COLUMN `planned_delivery_time_days` SET TAGS ('dbx_business_glossary_term' = 'Planned Delivery Time');
ALTER TABLE `waste_management_ecm`.`procurement`.`purchasing_info_record` ALTER COLUMN `plant_code` SET TAGS ('dbx_business_glossary_term' = 'Plant Code');
ALTER TABLE `waste_management_ecm`.`procurement`.`purchasing_info_record` ALTER COLUMN `price_unit` SET TAGS ('dbx_business_glossary_term' = 'Price Unit');
ALTER TABLE `waste_management_ecm`.`procurement`.`purchasing_info_record` ALTER COLUMN `purchasing_organization` SET TAGS ('dbx_business_glossary_term' = 'Purchasing Organization');
ALTER TABLE `waste_management_ecm`.`procurement`.`purchasing_info_record` ALTER COLUMN `standard_price` SET TAGS ('dbx_business_glossary_term' = 'Standard Price');
ALTER TABLE `waste_management_ecm`.`procurement`.`purchasing_info_record` ALTER COLUMN `valid_from_date` SET TAGS ('dbx_business_glossary_term' = 'Valid From Date');
ALTER TABLE `waste_management_ecm`.`procurement`.`purchasing_info_record` ALTER COLUMN `valid_to_date` SET TAGS ('dbx_business_glossary_term' = 'Valid To Date');
ALTER TABLE `waste_management_ecm`.`procurement`.`purchasing_info_record` ALTER COLUMN `vendor_material_number` SET TAGS ('dbx_business_glossary_term' = 'Vendor Material Number');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_waste_stream_approval` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_waste_stream_approval` SET TAGS ('dbx_subdomain' = 'supplier_management');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_waste_stream_approval` SET TAGS ('dbx_association_edges' = 'service.service_waste_stream,procurement.vendor');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_waste_stream_approval` ALTER COLUMN `vendor_waste_stream_approval_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Waste Stream Approval ID');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_waste_stream_approval` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Waste Stream Approval - Vendor Id');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_waste_stream_approval` ALTER COLUMN `waste_stream_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Waste Stream Approval - Service Waste Stream Id');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_waste_stream_approval` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_waste_stream_approval` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_waste_stream_approval` ALTER COLUMN `capacity_tons_per_month` SET TAGS ('dbx_business_glossary_term' = 'Capacity Tons Per Month');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_waste_stream_approval` ALTER COLUMN `certification_number` SET TAGS ('dbx_business_glossary_term' = 'Certification Number');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_waste_stream_approval` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_waste_stream_approval` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_waste_stream_approval` ALTER COLUMN `last_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Last Audit Date');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_waste_stream_approval` ALTER COLUMN `next_recertification_date` SET TAGS ('dbx_business_glossary_term' = 'Next Recertification Date');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_waste_stream_approval` ALTER COLUMN `permit_number` SET TAGS ('dbx_business_glossary_term' = 'Permit Number');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_waste_stream_approval` ALTER COLUMN `preferred_vendor_flag` SET TAGS ('dbx_business_glossary_term' = 'Preferred Vendor Flag');
ALTER TABLE `waste_management_ecm`.`procurement`.`vendor_waste_stream_approval` ALTER COLUMN `unit_price` SET TAGS ('dbx_business_glossary_term' = 'Unit Price');
ALTER TABLE `waste_management_ecm`.`procurement`.`bank_account` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `waste_management_ecm`.`procurement`.`bank_account` SET TAGS ('dbx_subdomain' = 'supplier_management');
ALTER TABLE `waste_management_ecm`.`procurement`.`bank_account` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_business_glossary_term' = 'Bank Account Identifier');
ALTER TABLE `waste_management_ecm`.`procurement`.`bank_account` ALTER COLUMN `superseded_bank_account_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `waste_management_ecm`.`procurement`.`bank_account` ALTER COLUMN `account_holder_tax_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`procurement`.`bank_account` ALTER COLUMN `account_holder_tax_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `waste_management_ecm`.`procurement`.`bank_account` ALTER COLUMN `account_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`procurement`.`bank_account` ALTER COLUMN `account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `waste_management_ecm`.`procurement`.`bank_account` ALTER COLUMN `bank_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`procurement`.`bank_account` ALTER COLUMN `bank_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `waste_management_ecm`.`procurement`.`bank_account` ALTER COLUMN `bank_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`procurement`.`bank_account` ALTER COLUMN `bank_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `waste_management_ecm`.`procurement`.`bank_account` ALTER COLUMN `bank_routing_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`procurement`.`bank_account` ALTER COLUMN `branch_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`procurement`.`bank_account` ALTER COLUMN `branch_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `waste_management_ecm`.`procurement`.`bank_account` ALTER COLUMN `current_balance` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`procurement`.`bank_account` ALTER COLUMN `iban` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `waste_management_ecm`.`procurement`.`bank_account` ALTER COLUMN `iban` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `waste_management_ecm`.`procurement`.`sourcing_event` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `waste_management_ecm`.`procurement`.`sourcing_event` SET TAGS ('dbx_subdomain' = 'supplier_management');
ALTER TABLE `waste_management_ecm`.`procurement`.`sourcing_event` ALTER COLUMN `sourcing_event_id` SET TAGS ('dbx_business_glossary_term' = 'Sourcing Event Identifier');
ALTER TABLE `waste_management_ecm`.`procurement`.`sourcing_event` ALTER COLUMN `rebid_sourcing_event_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `waste_management_ecm`.`procurement`.`sourcing_event` ALTER COLUMN `awarded_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`procurement`.`sourcing_event` ALTER COLUMN `estimated_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`procurement`.`sourcing_event` ALTER COLUMN `savings_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`procurement`.`legal_entity` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `waste_management_ecm`.`procurement`.`legal_entity` SET TAGS ('dbx_subdomain' = 'supplier_management');
ALTER TABLE `waste_management_ecm`.`procurement`.`legal_entity` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Identifier');
ALTER TABLE `waste_management_ecm`.`procurement`.`legal_entity` ALTER COLUMN `annual_revenue_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`procurement`.`legal_entity` ALTER COLUMN `credit_rating` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`procurement`.`legal_entity` ALTER COLUMN `insurance_coverage_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`procurement`.`legal_entity` ALTER COLUMN `insurance_policy_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`procurement`.`legal_entity` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`procurement`.`legal_entity` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `waste_management_ecm`.`procurement`.`legal_entity` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`procurement`.`legal_entity` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`procurement`.`legal_entity` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `waste_management_ecm`.`procurement`.`legal_entity` ALTER COLUMN `registered_address_line_1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`procurement`.`legal_entity` ALTER COLUMN `registered_address_line_1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `waste_management_ecm`.`procurement`.`legal_entity` ALTER COLUMN `registered_address_line_2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`procurement`.`legal_entity` ALTER COLUMN `registered_address_line_2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `waste_management_ecm`.`procurement`.`legal_entity` ALTER COLUMN `registered_city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`procurement`.`legal_entity` ALTER COLUMN `registered_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `waste_management_ecm`.`procurement`.`legal_entity` ALTER COLUMN `registered_postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`procurement`.`legal_entity` ALTER COLUMN `registered_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `waste_management_ecm`.`procurement`.`legal_entity` ALTER COLUMN `registered_state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `waste_management_ecm`.`procurement`.`legal_entity` ALTER COLUMN `registered_state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `waste_management_ecm`.`procurement`.`legal_entity` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_confidential' = 'true');
