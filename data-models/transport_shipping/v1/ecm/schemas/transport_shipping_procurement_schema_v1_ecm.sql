-- Schema for Domain: procurement | Business: Transport Shipping | Version: v1_ecm
-- Generated on: 2026-05-08 19:52:14

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `transport_shipping_ecm`.`procurement` COMMENT 'Manages sourcing, supplier onboarding, purchase order lifecycle, carrier procurement, and spend management for operational and capital expenditures. Owns supplier master, RFQ/RFP processes, purchase orders, invoice matching, and contract compliance monitoring. Powered by Coupa and integrates with SAP S/4HANA Finance for budget control and with fleet and warehouse domains for asset procurement.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `transport_shipping_ecm`.`procurement`.`supplier` (
    `supplier_id` BIGINT COMMENT 'Unique identifier for the supplier record. Primary key.',
    `org_unit_id` BIGINT COMMENT 'Foreign key linking to workforce.org_unit. Business justification: Suppliers assigned to organizational units for regional/divisional procurement management. Enables supplier segmentation by responsible org unit, spend reporting by division, decentralized vendor mana',
    `program_id` BIGINT COMMENT 'Foreign key linking to safety.safety_program. Business justification: Suppliers (especially carriers) must meet safety program requirements (ISO 45001, carrier safety standards). Tracked for supplier qualification, contract compliance, and performance evaluation in logi',
    `tpl_provider_id` BIGINT COMMENT 'Foreign key linking to network.tpl_provider. Business justification: Many suppliers in logistics ARE 3PL providers offering warehousing/distribution services; this link enables dual-role tracking (supplier of goods AND provider of logistics services), essential for int',
    `address_line1` STRING COMMENT 'First line of the suppliers primary business address (street number and name).',
    `address_line2` STRING COMMENT 'Second line of the suppliers primary business address (suite, floor, building name).',
    `aeo_certification_number` STRING COMMENT 'The unique AEO certification identifier issued by the customs authority.',
    `aeo_certified` BOOLEAN COMMENT 'Indicates whether the supplier holds AEO certification, demonstrating compliance with customs and supply chain security standards. AEO status enables expedited customs clearance and reduced inspections.',
    `city` STRING COMMENT 'City or municipality of the suppliers primary business address.',
    `contract_expiry_date` DATE COMMENT 'The date on which the current master service agreement or contract with the supplier expires. Used for contract renewal planning and supplier relationship management.',
    `country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code of the suppliers primary business address (e.g., USA, GBR, CHN, DEU).. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this supplier record was first created in the system.',
    `ctpat_certification_number` STRING COMMENT 'The unique C-TPAT certification identifier issued by US Customs and Border Protection.',
    `ctpat_certified` BOOLEAN COMMENT 'Indicates whether the supplier is C-TPAT certified, a US Customs and Border Protection voluntary supply chain security program. C-TPAT members receive expedited processing and reduced inspections at US borders.',
    `dba_name` STRING COMMENT 'Trade name or doing-business-as name if different from legal name.',
    `duns_number` STRING COMMENT 'Nine-digit unique identifier assigned by Dun & Bradstreet to identify business entities globally. Used for credit assessment and supplier risk management.. Valid values are `^[0-9]{9}$`',
    `geographic_coverage` STRING COMMENT 'Comma-separated list of ISO 3166-1 alpha-3 country codes representing the geographic regions where the supplier can provide services or deliver goods. Used for carrier and logistics service provider selection.',
    `iso_14001_certified` BOOLEAN COMMENT 'Indicates whether the supplier holds ISO 14001 certification for environmental management systems, relevant for sustainability and emissions reduction initiatives.',
    `iso_9001_certified` BOOLEAN COMMENT 'Indicates whether the supplier holds ISO 9001 certification for quality management systems.',
    `last_audit_date` DATE COMMENT 'The date of the most recent supplier audit or compliance review. Audits assess quality, financial stability, security, and regulatory compliance.',
    `minority_owned` BOOLEAN COMMENT 'Indicates whether the supplier is certified as a minority-owned business enterprise (MBE). Used for diversity and inclusion reporting and supplier diversity programs.',
    `next_audit_date` DATE COMMENT 'The scheduled date for the next supplier audit or compliance review.',
    `onboarding_date` DATE COMMENT 'The date the supplier was approved and onboarded into the procurement system.',
    `onboarding_status` STRING COMMENT 'Current stage in the supplier onboarding workflow. Tracks progression through KYC (Know Your Customer), compliance screening, contract negotiation, and final approval.. Valid values are `not_started|in_progress|kyc_review|compliance_review|approved|rejected`',
    `payment_method` STRING COMMENT 'Preferred payment instrument for settling invoices. ACH (Automated Clearing House) for electronic bank transfers, wire transfer for same-day international payments, check for traditional paper payments, credit card for small purchases, letter of credit for international trade, purchase card (P-Card) for employee procurement.. Valid values are `ach|wire_transfer|check|credit_card|letter_of_credit|purchase_card`',
    `payment_terms` STRING COMMENT 'Standard payment terms negotiated with the supplier, expressed in days or terms such as Net 30, Net 60, 2/10 Net 30 (2% discount if paid within 10 days, otherwise net 30 days), or Due on Receipt.',
    `performance_rating` DECIMAL(18,2) COMMENT 'Composite performance score on a scale of 0.00 to 5.00, calculated from on-time delivery, quality, responsiveness, compliance, and cost metrics. Used for supplier scorecarding and strategic sourcing decisions.',
    `postal_code` STRING COMMENT 'Postal code or ZIP code of the suppliers primary business address.',
    `preferred_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the suppliers preferred invoicing and payment currency (e.g., USD, EUR, GBP, CNY).. Valid values are `^[A-Z]{3}$`',
    `preferred_supplier` BOOLEAN COMMENT 'Indicates whether the supplier has been designated as a preferred or strategic supplier based on performance, pricing, reliability, or strategic partnership agreements. Preferred suppliers receive priority consideration in sourcing decisions.',
    `primary_contact_email` STRING COMMENT 'Email address of the primary business contact at the supplier organization.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `primary_contact_name` STRING COMMENT 'Full name of the primary business contact at the supplier organization for procurement and operational matters.',
    `primary_contact_phone` STRING COMMENT 'Phone number of the primary business contact at the supplier organization.',
    `risk_tier` STRING COMMENT 'Risk classification based on financial stability, compliance history, geographic location, criticality to operations, and exposure to sanctions or trade restrictions. Critical tier requires enhanced due diligence and monitoring.. Valid values are `low|medium|high|critical`',
    `service_capabilities` STRING COMMENT 'Comma-separated list of service capabilities the supplier can provide, such as air_freight, ocean_freight, road_transport, rail_transport, warehousing, customs_brokerage, last_mile_delivery, cold_chain, hazmat_handling, cross_border_shipping. Used for carrier and 3PL selection.',
    `small_business` BOOLEAN COMMENT 'Indicates whether the supplier is certified as a small business according to the applicable jurisdictions definition (e.g., US SBA size standards). Used for small business procurement programs and reporting.',
    `state_province` STRING COMMENT 'State, province, or region of the suppliers primary business address.',
    `supplier_category` STRING COMMENT 'Spend category classification. Direct suppliers provide goods/services directly tied to core logistics operations (carriers, fuel, packaging). Indirect suppliers provide operational support (IT, facilities, office supplies). Capital suppliers provide long-term assets (vehicles, equipment, infrastructure).. Valid values are `direct|indirect|capital`',
    `supplier_name` STRING COMMENT 'The full legal name of the supplier organization as registered with governing authorities.',
    `supplier_number` STRING COMMENT 'Externally-known unique business identifier for the supplier, typically assigned during onboarding. Used in purchase orders, invoices, and contracts.. Valid values are `^[A-Z0-9]{6,20}$`',
    `supplier_status` STRING COMMENT 'Current lifecycle status of the supplier relationship. Active: approved and transacting. Inactive: approved but not currently transacting. Suspended: temporarily blocked due to performance or compliance issues. Pending approval: onboarding in progress. Blocked: prohibited from new transactions. Terminated: relationship ended.. Valid values are `active|inactive|suspended|pending_approval|blocked|terminated`',
    `supplier_type` STRING COMMENT 'Primary classification of the supplier based on the goods or services provided. Carrier includes air, ocean, road, rail freight carriers; fuel supplier provides bunker fuel, diesel, jet fuel; IT vendor provides software, hardware, telecom; facility lessor provides warehouse, office, terminal leases; equipment provider supplies vehicles, containers, handling equipment; professional services includes consulting, legal, audit.. Valid values are `carrier|fuel_supplier|it_vendor|facility_lessor|equipment_provider|professional_services`',
    `tax_identifier` STRING COMMENT 'The suppliers tax identification number issued by the tax authority in their country of registration. In the US this is the EIN (Employer Identification Number) or SSN for sole proprietors; in the EU this is the VAT number.',
    `termination_date` DATE COMMENT 'The date the supplier relationship was terminated or the supplier was deactivated. Null for active suppliers.',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this supplier record was last modified.',
    `vat_registration_number` STRING COMMENT 'The suppliers VAT registration number for EU and other jurisdictions that use VAT. Required for cross-border invoicing and tax compliance.',
    `woman_owned` BOOLEAN COMMENT 'Indicates whether the supplier is certified as a woman-owned business enterprise (WBE). Used for diversity and inclusion reporting and supplier diversity programs.',
    CONSTRAINT pk_supplier PRIMARY KEY(`supplier_id`)
) COMMENT 'Master record for all suppliers, vendors, and service providers engaged by Transport Shipping. Captures supplier identity, classification (carrier, fuel supplier, IT vendor, facility lessor, etc.), onboarding status, risk tier, AEO/C-TPAT certification status, payment terms, preferred currency, tax identifiers, and geographic coverage. This is the SSOT for supplier identity within the procurement domain and serves as the anchor for all sourcing, purchasing, and spend management activities. Sourced from Coupa Supplier Management module.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`procurement`.`supplier_site` (
    `supplier_site_id` BIGINT COMMENT 'Unique identifier for the supplier site. Primary key.',
    `supplier_id` BIGINT COMMENT 'Reference to the parent supplier entity. A single supplier may operate multiple sites for different purposes (remit-to, ship-from, order-from).',
    `address_line_1` STRING COMMENT 'Primary street address line for the supplier site (street number, street name, building identifier).',
    `address_line_2` STRING COMMENT 'Secondary address line for additional location details (suite, floor, unit, department).',
    `bank_account_number` STRING COMMENT 'Bank account number associated with this supplier site for payment remittance. Used for Accounts Payable (AP) processing.',
    `bank_branch_code` STRING COMMENT 'Branch code or routing number for the supplier sites bank account, used for electronic funds transfer.',
    `bank_name` STRING COMMENT 'Name of the financial institution holding the supplier sites bank account.',
    `city` STRING COMMENT 'City or municipality where the supplier site is located.',
    `contact_person_name` STRING COMMENT 'Full name of the primary contact person at the supplier site for procurement and operational matters.',
    `contact_person_title` STRING COMMENT 'Job title or role of the primary contact person at the supplier site (e.g., Site Manager, Procurement Coordinator, Operations Director).',
    `country_code` STRING COMMENT 'Three-letter ISO country code for the supplier site location (e.g., USA, GBR, CHN, DEU).. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the supplier site record was first created in the procurement system. Used for audit trail and data lineage.',
    `effective_from_date` DATE COMMENT 'Date when the supplier site became active and available for procurement transactions. Used for temporal validity and historical analysis.',
    `effective_to_date` DATE COMMENT 'Date when the supplier site was deactivated or closed. Null for currently active sites. Used for temporal validity and supplier lifecycle management.',
    `email_address` STRING COMMENT 'Primary email address for the supplier site, used for purchase order transmission, invoice submission, and operational correspondence.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `fax_number` STRING COMMENT 'Fax number for the supplier site, if applicable for document transmission.',
    `iban` STRING COMMENT 'International Bank Account Number for the supplier site, used for cross-border payments in SEPA and other international payment systems.',
    `incoterm` STRING COMMENT 'Default Incoterm for shipments from this supplier site, defining the division of costs and risks between buyer and seller (e.g., EXW, FOB, CIF, DDP). [ENUM-REF-CANDIDATE: EXW|FCA|CPT|CIP|DAP|DPU|DDP|FAS|FOB|CFR|CIF — 11 candidates stripped; promote to reference product]',
    `is_primary_site` BOOLEAN COMMENT 'Flag indicating whether this is the primary or default site for the supplier. True if this is the main operational site; false for secondary or regional sites.',
    `is_remit_to_site` BOOLEAN COMMENT 'Flag indicating whether this site is designated as a remit-to address for payment processing. True if payments should be sent to this sites bank account.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the supplier site record was last updated. Used for change tracking and data synchronization.',
    `last_transaction_date` DATE COMMENT 'Date of the most recent purchase order or procurement transaction with this supplier site. Used for supplier performance analysis and dormant site identification.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the supplier site in decimal degrees. Used for route optimization, distance calculations, and geospatial analytics.',
    `lead_time_days` STRING COMMENT 'Standard lead time in days from purchase order placement to shipment or delivery from this supplier site. Used for procurement planning and inventory management.',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the supplier site in decimal degrees. Used for route optimization, distance calculations, and geospatial analytics.',
    `minimum_order_value` DECIMAL(18,2) COMMENT 'Minimum order value required for purchases from this supplier site, in the sites payment currency. Orders below this threshold may incur additional fees or be rejected.',
    `notes` STRING COMMENT 'Free-text notes or comments about the supplier site, including special handling instructions, access requirements, or operational constraints.',
    `operating_hours` STRING COMMENT 'Standard operating hours for the supplier site (e.g., 08:00-17:00 Mon-Fri, 24/7). Used for scheduling deliveries, pickups, and service appointments.',
    `payment_currency_code` STRING COMMENT 'Three-letter ISO currency code for payments to this supplier site (e.g., USD, EUR, GBP, CNY). Site-level currency may differ from supplier-level default.. Valid values are `^[A-Z]{3}$`',
    `payment_method` STRING COMMENT 'Preferred payment method for remittance to this supplier site: wire transfer, Automated Clearing House (ACH), check, credit card, purchase card (P-Card), or Electronic Funds Transfer (EFT).. Valid values are `wire_transfer|ach|check|credit_card|purchase_card|eft`',
    `payment_terms` STRING COMMENT 'Site-specific payment terms negotiated with the supplier (e.g., Net 30, Net 60, 2/10 Net 30). Overrides supplier-level default payment terms when specified.',
    `phone_number` STRING COMMENT 'Primary contact phone number for the supplier site, used for operational communication and order coordination.',
    `postal_code` STRING COMMENT 'Postal or ZIP code for the supplier site address, used for mail delivery and logistics routing.',
    `site_code` STRING COMMENT 'Externally-known unique code or identifier for the site, used in procurement documents and purchase orders.',
    `site_name` STRING COMMENT 'Human-readable name or label for the supplier site (e.g., Regional Hub - Chicago, Fuel Depot - Rotterdam, Equipment Warehouse - Singapore).',
    `site_status` STRING COMMENT 'Current lifecycle status of the supplier site. Active sites are available for procurement transactions; inactive or suspended sites are temporarily unavailable; closed sites are permanently retired.. Valid values are `active|inactive|suspended|pending_approval|closed`',
    `site_type` STRING COMMENT 'Classification of the sites operational purpose: remit-to (payment address), ship-from (origin for goods), order-from (procurement contact point), bill-to (invoicing address), service-location (on-site service delivery), or warehouse (storage facility).. Valid values are `remit_to|ship_from|order_from|bill_to|service_location|warehouse`',
    `state_province` STRING COMMENT 'State, province, or administrative region for the supplier site address.',
    `swift_code` STRING COMMENT 'Society for Worldwide Interbank Financial Telecommunication (SWIFT) code for international wire transfers to the supplier sites bank account.. Valid values are `^[A-Z]{6}[A-Z0-9]{2}([A-Z0-9]{3})?$`',
    `tax_exemption_status` STRING COMMENT 'Indicates whether the supplier site qualifies for tax exemption on purchases (e.g., Free Trade Zone (FTZ) location, government entity, non-profit organization).. Valid values are `exempt|non_exempt|partial_exempt`',
    `tax_registration_number` STRING COMMENT 'Tax identification or registration number for the supplier site in the local jurisdiction (e.g., VAT number, GST registration, EIN). Used for tax compliance and invoice validation.',
    `time_zone` STRING COMMENT 'IANA time zone identifier for the supplier site location (e.g., America/Chicago, Europe/London, Asia/Singapore). Used for coordinating communications and scheduling.',
    CONSTRAINT pk_supplier_site PRIMARY KEY(`supplier_site_id`)
) COMMENT 'Represents a physical or operational site (address, bank account, contact point) associated with a supplier. A single supplier may have multiple sites — e.g., a carrier with regional hubs, a fuel supplier with depot locations, or a warehouse equipment vendor with multiple warehouses. Tracks site type (remit-to, ship-from, order-from), site-level payment terms, currency, and active status. Sourced from Coupa Supplier Management.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`procurement`.`supplier_qualification` (
    `supplier_qualification_id` BIGINT COMMENT 'Unique identifier for the supplier qualification record. Primary key.',
    `audit_id` BIGINT COMMENT 'Foreign key linking to safety.safety_audit. Business justification: Supplier safety qualifications require third-party safety audits (carriers, dangerous goods handlers, warehouse operators). Links qualification records to formal audit results for compliance verificat',
    `certificate_id` BIGINT COMMENT 'Foreign key linking to document.certificate. Business justification: Supplier (carrier) qualifications require linking to certificates (ISO, AEO, CTPAT, insurance) as compliance evidence. Business process: carrier onboarding and periodic qualification reviews require c',
    `dg_certification_id` BIGINT COMMENT 'Foreign key linking to safety.dg_certification. Business justification: Suppliers handling dangerous goods must hold valid DG certifications. Links supplier qualification to specific DG certification records for regulatory compliance verification (IATA, IMDG, ADR) in tran',
    `employee_id` BIGINT COMMENT 'Reference to the user who approved the supplier qualification. Links to the workforce user master for accountability and audit purposes.',
    `org_unit_id` BIGINT COMMENT 'Foreign key linking to workforce.org_unit. Business justification: Supplier qualifications owned by responsible organizational units for divisional supplier onboarding, org-specific compliance requirements, regional vendor qualification management in decentralized lo',
    `supplier_emissions_disclosure_id` BIGINT COMMENT 'Foreign key linking to sustainability.supplier_emissions_disclosure. Business justification: Supplier qualification in transport logistics must verify carrier carbon disclosure completeness and quality for regulatory compliance (CSRD, GLEC Framework) and Scope 3 data quality. Required ESG gat',
    `supplier_id` BIGINT COMMENT 'Reference to the supplier undergoing qualification. Links to the supplier master record in the procurement domain.',
    `trade_party_id` BIGINT COMMENT 'Foreign key linking to customs.trade_party. Business justification: Supplier qualification includes denied party screening and compliance certifications (AEO, C-TPAT) aligned with customs trade party records. Procurement onboarding validates supplier against customs t',
    `aeo_certificate_expiry_date` DATE COMMENT 'Expiration date of the AEO certification. Must be monitored to maintain customs compliance and trade facilitation benefits.',
    `aeo_certification_status` STRING COMMENT 'Status of Authorized Economic Operator certification, a customs compliance program that provides trade facilitation benefits. Critical for international freight forwarders and customs brokers.. Valid values are `certified|not_certified|expired|pending_renewal`',
    `approval_timestamp` TIMESTAMP COMMENT 'Precise date and time when the qualification was approved. Critical for compliance audit trails and SLA tracking.',
    `assessment_score` DECIMAL(18,2) COMMENT 'Composite numerical score from the qualification assessment, typically on a 0-100 scale. Aggregates performance across multiple evaluation criteria including quality, delivery, financial health, and compliance.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this qualification record was first created in the system. Audit field for data lineage and compliance reporting.',
    `ctpat_certificate_expiry_date` DATE COMMENT 'Expiration date of the C-TPAT certification. Critical for maintaining supply chain security compliance for US-bound shipments.',
    `ctpat_certification_status` STRING COMMENT 'Status of C-TPAT certification, a US Customs and Border Protection voluntary supply chain security program. Provides benefits for US import operations.. Valid values are `certified|not_certified|expired|pending_renewal`',
    `denied_party_screening_date` DATE COMMENT 'Date when the most recent denied party screening was performed. Must be refreshed periodically per trade compliance policies.',
    `denied_party_screening_status` STRING COMMENT 'Result of screening against OFAC (Office of Foreign Assets Control), EU sanctions lists, and other denied party databases. Cleared indicates no matches; flagged requires investigation; pending awaits screening completion.. Valid values are `cleared|flagged|pending|not_screened`',
    `due_diligence_completed_flag` BOOLEAN COMMENT 'Indicates whether comprehensive due diligence checks (financial, legal, operational, reputational) have been completed for this qualification event. True when all required checks are finalized.',
    `due_diligence_completion_date` DATE COMMENT 'Date when all due diligence activities were completed. Marks readiness for final qualification decision.',
    `eu_sanctions_screening_result` STRING COMMENT 'Result of screening against European Union consolidated sanctions lists. Critical for suppliers involved in EU trade lanes.. Valid values are `pass|fail|review_required`',
    `financial_health_score` DECIMAL(18,2) COMMENT 'Quantitative assessment of supplier financial stability derived from credit reports, financial statements, and payment history. Scale 0-100 where higher indicates stronger financial position.',
    `insurance_certificate_status` STRING COMMENT 'Status of supplier liability insurance certificate. Valid indicates current coverage meeting minimum requirements; insufficient coverage indicates policy limits below contract thresholds.. Valid values are `valid|expired|insufficient_coverage|not_provided`',
    `insurance_coverage_amount` DECIMAL(18,2) COMMENT 'Total liability coverage amount in the supplier insurance policy. Must meet or exceed contract-specified minimum coverage thresholds.',
    `insurance_expiry_date` DATE COMMENT 'Expiration date of the supplier insurance certificate. Triggers renewal requirements and may suspend supplier eligibility if expired.',
    `iso_certificate_expiry_date` DATE COMMENT 'Expiration date of the supplier ISO certification. Triggers re-certification requirements and compliance monitoring.',
    `iso_certification_status` STRING COMMENT 'Status of supplier ISO certifications (e.g., ISO 9001 Quality Management, ISO 14001 Environmental Management, ISO 28000 Supply Chain Security). Indicates whether valid certifications are on file.. Valid values are `certified|not_certified|expired|pending_renewal`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to this qualification record. Tracks data currency and supports change auditing.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next periodic qualification review. Drives proactive supplier monitoring and re-qualification workflows.',
    `ofac_screening_result` STRING COMMENT 'Specific result of screening against US OFAC sanctions lists. Pass indicates no match; fail indicates positive match requiring immediate action; review required indicates potential match needing manual investigation.. Valid values are `pass|fail|review_required`',
    `qualification_completion_date` DATE COMMENT 'Date when the qualification process was finalized with a decision (approved or rejected). Null if still in progress.',
    `qualification_expiry_date` DATE COMMENT 'Date when the qualification approval expires and re-qualification is required. Critical for compliance monitoring and supplier lifecycle management.',
    `qualification_notes` STRING COMMENT 'Free-text field capturing assessor observations, special conditions, remediation requirements, or other contextual information relevant to the qualification decision. Used for audit trails and future reference.',
    `qualification_number` STRING COMMENT 'Business identifier for the qualification event. Externally visible reference number used in communications and audit trails.. Valid values are `^SQ-[0-9]{8}$`',
    `qualification_start_date` DATE COMMENT 'Date when the qualification process was initiated. Marks the beginning of the assessment lifecycle.',
    `qualification_status` STRING COMMENT 'Current lifecycle state of the qualification: pending (awaiting initiation), in progress (under review), approved (passed all checks), rejected (failed qualification), suspended (temporarily halted), or expired (validity period ended).. Valid values are `pending|in_progress|approved|rejected|suspended|expired`',
    `qualification_type` STRING COMMENT 'Category of qualification event: initial onboarding for new suppliers, periodic review for scheduled reassessments, re-qualification after suspension, ad-hoc audit triggered by incidents, compliance verification for regulatory changes, or risk assessment for high-value contracts.. Valid values are `initial_onboarding|periodic_review|re_qualification|ad_hoc_audit|compliance_verification|risk_assessment`',
    `rejection_reason` STRING COMMENT 'Detailed explanation for qualification rejection. Captures specific deficiencies (e.g., failed financial checks, denied party match, insufficient insurance, non-compliance with quality standards) for supplier feedback and internal analysis.',
    `risk_rating` STRING COMMENT 'Overall risk classification assigned to the supplier based on financial stability, operational capacity, compliance history, and geopolitical factors. Drives procurement approval thresholds and monitoring frequency.. Valid values are `low|medium|high|critical`',
    `source_system` STRING COMMENT 'System of record that originated this qualification event. Coupa for procurement-driven qualifications, Descartes Customs for trade compliance screenings, manual entry for offline assessments, or third-party service for external due diligence providers.. Valid values are `coupa|descartes_customs|manual_entry|third_party_service`',
    CONSTRAINT pk_supplier_qualification PRIMARY KEY(`supplier_qualification_id`)
) COMMENT 'Tracks the formal qualification and onboarding lifecycle of a supplier, including pre-qualification assessments, due diligence checks, denied party screening results (OFAC, EU sanctions), financial health scores, insurance certificate validity, ISO/AEO/C-TPAT certification records, and qualification expiry dates. Each qualification event is a distinct record enabling audit trails for trade compliance and regulatory reporting. Sourced from Coupa and Descartes Customs screening.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`procurement`.`rfq` (
    `rfq_id` BIGINT COMMENT 'Unique identifier for the request for quotation record. Primary key.',
    `approver_employee_id` BIGINT COMMENT 'Identifier of the manager or executive who approved this RFQ for issuance. Null if approval is not required or still pending.',
    `supplier_id` BIGINT COMMENT 'Identifier of the supplier who was awarded the business as a result of this RFQ. Null if RFQ is not yet awarded or was cancelled.',
    `carrier_id` BIGINT COMMENT 'Foreign key linking to network.carrier. Business justification: RFQs issued to carriers for freight rate quotes on specific lanes/services; standard freight procurement process. Enables carrier rate comparison, bid analysis, and award decisions. Tracks which carri',
    `employee_id` BIGINT COMMENT 'FK to workforce.employee',
    `org_unit_id` BIGINT COMMENT 'Foreign key linking to workforce.org_unit. Business justification: RFQs issued by organizational units for org-level sourcing activity tracking, decentralized procurement operations. Critical for divisional RFQ analytics, org-specific sourcing strategy execution in m',
    `primary_rfq_employee_id` BIGINT COMMENT 'Identifier of the procurement professional or buyer responsible for managing this RFQ process.',
    `procurement_contract_id` BIGINT COMMENT 'Identifier of the purchase contract or purchase order that was created as a result of this RFQ award. Null if not yet awarded or if award did not result in a formal contract.',
    `requester_employee_id` BIGINT COMMENT 'Identifier of the internal employee or stakeholder who originated the request for these goods or services.',
    `rfq_buyer_employee_id` BIGINT COMMENT 'FK to workforce.employee',
    `rfq_employee_id` BIGINT COMMENT 'FK to workforce.employee',
    `approval_date` DATE COMMENT 'The date when the RFQ was approved for issuance. Null if approval is not required or still pending.',
    `approval_status` STRING COMMENT 'Current approval status of the RFQ within internal governance workflows. RFQs above certain spend thresholds require management approval before issuance.. Valid values are `pending|approved|rejected`',
    `award_date` DATE COMMENT 'The date when the supplier award decision was made and communicated. Null if RFQ is not yet awarded.',
    `awarded_amount` DECIMAL(18,2) COMMENT 'The total contract value awarded to the winning supplier. Null if RFQ is not yet awarded.',
    `cancellation_reason` STRING COMMENT 'Explanation for why the RFQ was cancelled, if applicable. Common reasons include budget cuts, requirement changes, insufficient responses, or business need no longer exists.',
    `confidentiality_level` STRING COMMENT 'Data classification level for this RFQ and its associated documents. Determines access controls and sharing restrictions.. Valid values are `public|internal|confidential|restricted`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this RFQ record was first created in the system. Audit trail field.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the estimated spend and expected quotations (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `delivery_country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code for the delivery destination country.. Valid values are `^[A-Z]{3}$`',
    `delivery_location` STRING COMMENT 'The facility, warehouse, or site where goods should be delivered or where services should be performed.',
    `delivery_weight_percentage` DECIMAL(18,2) COMMENT 'The percentage weight assigned to delivery time and reliability in the overall evaluation scoring model.',
    `estimated_spend_amount` DECIMAL(18,2) COMMENT 'The estimated total monetary value of this procurement, used for budget planning and approval routing. May be shared with suppliers or kept confidential depending on sourcing strategy.',
    `evaluation_criteria` STRING COMMENT 'The criteria and weighting that will be used to evaluate and score supplier quotations. May include price, quality, delivery time, service level, sustainability, financial stability, and past performance.',
    `incoterms` STRING COMMENT 'Incoterms rule applicable to this RFQ if it involves international shipment of goods. Defines responsibilities for shipping, insurance, and customs clearance between buyer and supplier. [ENUM-REF-CANDIDATE: EXW|FCA|CPT|CIP|DAP|DPU|DDP|FAS|FOB|CFR|CIF — 11 candidates stripped; promote to reference product]',
    `is_multi_round` BOOLEAN COMMENT 'Indicates whether this RFQ involves multiple rounds of bidding (e.g., initial submission followed by best-and-final-offer round). True = multi-round; False = single-round.',
    `is_reverse_auction` BOOLEAN COMMENT 'Indicates whether this RFQ includes a reverse auction phase where suppliers can see competitor pricing and submit lower bids in real-time. True = includes reverse auction; False = sealed bid only.',
    `issue_date` DATE COMMENT 'The date when the RFQ was officially issued and sent to suppliers. Marks the start of the supplier response period.',
    `issuing_business_unit` STRING COMMENT 'The business unit, division, or department within Transport Shipping that is requesting the goods or services and issuing this RFQ.',
    `issuing_country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code for the country where the RFQ is being issued from.. Valid values are `^[A-Z]{3}$`',
    `issuing_location` STRING COMMENT 'The geographic location, facility, or site that is the origin of this RFQ request.',
    `modified_by` STRING COMMENT 'Username or identifier of the system user who last modified this RFQ record. Audit trail field.',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when this RFQ record was last modified. Audit trail field.',
    `notes` STRING COMMENT 'Free-form notes and comments about this RFQ, including special instructions, clarifications, or internal observations.',
    `payment_terms` STRING COMMENT 'Standard payment terms being offered to suppliers (e.g., Net 30, Net 60, 2/10 Net 30). Influences supplier pricing and cash flow.',
    `price_weight_percentage` DECIMAL(18,2) COMMENT 'The percentage weight assigned to price in the overall evaluation scoring model. Typically ranges from 30% to 70% depending on procurement strategy.',
    `quality_weight_percentage` DECIMAL(18,2) COMMENT 'The percentage weight assigned to quality criteria in the overall evaluation scoring model.',
    `required_delivery_date` DATE COMMENT 'The date by which the requested goods or services must be delivered or available for use. Critical for supplier capacity planning and bid evaluation.',
    `response_count` STRING COMMENT 'The number of suppliers who submitted quotations in response to this RFQ.',
    `rfq_category` STRING COMMENT 'Classification of the procurement category for this RFQ. Determines routing, approval workflow, and evaluation criteria. Categories include carrier services (3PL, freight forwarding), fuel (diesel, aviation fuel), warehouse equipment (forklifts, racking), IT (hardware, software, services), facilities (maintenance, construction), fleet vehicles, and professional services. [ENUM-REF-CANDIDATE: carrier_services|fuel|warehouse_equipment|it_hardware|it_software|facilities|fleet_vehicles|professional_services — 8 candidates stripped; promote to reference product]',
    `rfq_description` STRING COMMENT 'Detailed description of the goods or services being requested, including specifications, requirements, and scope of work.',
    `rfq_number` STRING COMMENT 'Externally-known business identifier for the RFQ, used in communications with suppliers and internal stakeholders. Typically follows format RFQ-YYYYMMDD-NNNN.. Valid values are `^RFQ-[0-9]{8,12}$`',
    `rfq_status` STRING COMMENT 'Current lifecycle status of the RFQ. Draft = being prepared; Issued/Open = sent to suppliers and accepting responses; Closed = submission deadline passed, under evaluation; Awarded = supplier(s) selected and notified; Cancelled = RFQ withdrawn; Expired = deadline passed with no award. [ENUM-REF-CANDIDATE: draft|issued|open|closed|awarded|cancelled|expired — 7 candidates stripped; promote to reference product]',
    `sourcing_event_type` STRING COMMENT 'Classification of the sourcing event complexity and strategic importance. Spot = one-time immediate need; Tactical = recurring operational procurement; Strategic = high-value, long-term, complex sourcing.. Valid values are `spot|tactical|strategic`',
    `subcategory` STRING COMMENT 'More granular classification within the procurement category, providing additional detail on the type of goods or services being sourced.',
    `submission_deadline` TIMESTAMP COMMENT 'The date and time by which suppliers must submit their quotations. No late submissions are typically accepted after this timestamp.',
    `supplier_count` STRING COMMENT 'The number of suppliers invited to participate in this RFQ. Influences competition level and response rate.',
    `title` STRING COMMENT 'Brief descriptive title summarizing the goods or services being requested in this RFQ.',
    `created_by` STRING COMMENT 'Username or identifier of the system user who created this RFQ record. Audit trail field.',
    CONSTRAINT pk_rfq PRIMARY KEY(`rfq_id`)
) COMMENT 'Request for Quotation issued to one or more suppliers for goods or services required by Transport Shipping. Captures RFQ number, category (carrier services, fuel, warehouse equipment, IT, facilities), issuing business unit, required delivery date, estimated spend, currency, evaluation criteria, submission deadline, and RFQ status (draft, issued, closed, awarded, cancelled). Supports the sourcing event lifecycle in Coupa. Distinct from RFP which is used for strategic/complex sourcing.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`procurement`.`supplier_quote` (
    `supplier_quote_id` BIGINT COMMENT 'Unique identifier for the supplier quote record. Primary key.',
    `carrier_id` BIGINT COMMENT 'Foreign key linking to network.carrier. Business justification: Carrier quotes in response to freight RFQs; enables carrier rate comparison, service level evaluation, and award decisions. Essential for freight procurement optimization and carrier selection based o',
    `rfq_id` BIGINT COMMENT 'Reference to the RFQ or RFP event that this quote responds to.',
    `supplier_id` BIGINT COMMENT 'Reference to the supplier who submitted this quote.',
    `supplier_site_id` BIGINT COMMENT 'Foreign key linking to procurement.supplier_site. Business justification: Supplier quotes are submitted from a specific supplier site. The supplier_site contains contact person details, address, and operational information. Removing contact_person_name, contact_email, conta',
    `award_date` DATE COMMENT 'Date on which the quote was awarded or accepted by the procurement team.',
    `award_status` STRING COMMENT 'Indicates whether this quote was awarded a purchase order or contract.. Valid values are `not_awarded|awarded|partially_awarded|declined`',
    `compliance_certification` STRING COMMENT 'Certifications or compliance declarations provided by the supplier, such as ISO 9001, C-TPAT, AEO, or industry-specific standards.',
    `created_by_user` STRING COMMENT 'Username or identifier of the system user who created the quote record.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the quote record was first created in the procurement system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code in which the quote is denominated.. Valid values are `^[A-Z]{3}$`',
    `customs_duty_estimate` DECIMAL(18,2) COMMENT 'Estimated customs duties or tariffs applicable to the quoted goods, if included by the supplier.',
    `delivery_terms` STRING COMMENT 'Incoterms or delivery terms specified in the quote, such as FOB, CIF, DDP, DAP, EXW.',
    `destination_location` STRING COMMENT 'Delivery destination or port specified in the quote.',
    `discount_amount` DECIMAL(18,2) COMMENT 'Absolute monetary discount applied to the quote.',
    `discount_percentage` DECIMAL(18,2) COMMENT 'Percentage discount offered by the supplier off the list price or base quote amount.',
    `evaluation_score` DECIMAL(18,2) COMMENT 'Composite score assigned during quote evaluation based on price, quality, delivery, and other criteria.',
    `freight_charges` DECIMAL(18,2) COMMENT 'Freight or shipping charges included in or added to the quote.',
    `handling_charges` DECIMAL(18,2) COMMENT 'Handling or packaging charges specified in the quote.',
    `insurance_charges` DECIMAL(18,2) COMMENT 'Insurance charges included in the quote for shipment coverage.',
    `lead_time_days` STRING COMMENT 'Number of calendar days from purchase order issuance to delivery, as committed by the supplier.',
    `maximum_order_quantity` DECIMAL(18,2) COMMENT 'Maximum order quantity the supplier can fulfill under this quote.',
    `minimum_order_quantity` DECIMAL(18,2) COMMENT 'Minimum order quantity required by the supplier for this quote to be valid.',
    `modified_by_user` STRING COMMENT 'Username or identifier of the system user who last modified the quote record.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the quote record was last updated or modified.',
    `notes` STRING COMMENT 'Free-text notes or comments from the supplier or procurement team regarding the quote.',
    `payment_method` STRING COMMENT 'Preferred or required payment method specified by the supplier for this quote.. Valid values are `bank_transfer|letter_of_credit|check|electronic_payment|cash_on_delivery`',
    `payment_terms` STRING COMMENT 'Payment terms offered by the supplier, such as Net 30, Net 60, or advance payment requirements.',
    `quote_reference_number` STRING COMMENT 'External reference number assigned by the supplier to this quotation. Used for supplier correspondence and tracking.',
    `quote_status` STRING COMMENT 'Current lifecycle status of the supplier quote in the sourcing process. [ENUM-REF-CANDIDATE: submitted|under_review|clarification_requested|accepted|rejected|withdrawn|expired — 7 candidates stripped; promote to reference product]',
    `quote_type` STRING COMMENT 'Classification of the quote based on pricing structure or sourcing context.. Valid values are `standard|volume_discount|spot|contract|framework`',
    `rank` STRING COMMENT 'Ranking of this quote relative to other quotes received for the same RFQ, with 1 being the best.',
    `rejection_reason` STRING COMMENT 'Reason for rejecting the quote, such as high price, long lead time, or non-compliance with specifications.',
    `shipping_point` STRING COMMENT 'Origin location or port from which the supplier will ship the goods.',
    `submission_timestamp` TIMESTAMP COMMENT 'Date and time when the supplier submitted the quote to the procurement system.',
    `sustainability_rating` STRING COMMENT 'Sustainability or environmental rating of the supplier or quoted goods, supporting green procurement initiatives.. Valid values are `A|B|C|D|not_rated`',
    `tax_amount` DECIMAL(18,2) COMMENT 'Total tax amount applicable to the quoted goods or services.',
    `total_amount_including_tax` DECIMAL(18,2) COMMENT 'Grand total of the quote including all taxes and charges.',
    `total_quoted_amount` DECIMAL(18,2) COMMENT 'Total monetary value of the quote across all line items, before taxes and adjustments.',
    `unit_of_measure` STRING COMMENT 'Standard unit of measure for quantities in this quote, such as EA (each), KG (kilogram), LTR (liter), TEU (Twenty-foot Equivalent Unit).',
    `valid_from_date` DATE COMMENT 'Start date from which the quoted prices and terms are effective.',
    `valid_until_date` DATE COMMENT 'Expiration date after which the quoted prices and terms are no longer binding.',
    `warranty_terms` STRING COMMENT 'Warranty or guarantee terms offered by the supplier for the quoted goods or services.',
    CONSTRAINT pk_supplier_quote PRIMARY KEY(`supplier_quote_id`)
) COMMENT 'Formal quotation submitted by a supplier in response to an RFQ or RFP. Captures quote reference number, submission timestamp, validity period, total quoted amount, currency, payment terms offered, lead time, and overall quote status (submitted, under review, accepted, rejected). Serves as the basis for sourcing award decisions and contract negotiation. Sourced from Coupa Sourcing.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`procurement`.`purchase_order` (
    `purchase_order_id` BIGINT COMMENT 'Unique identifier for the purchase order. Primary key.',
    `blanket_order_id` BIGINT COMMENT 'Foreign key linking to procurement.blanket_order. Business justification: Purchase orders can be releases against blanket orders (call-off mechanism). This establishes the relationship between framework agreements and their individual releases at the header level.',
    `carrier_id` BIGINT COMMENT 'Foreign key linking to network.carrier. Business justification: Freight procurement POs specify carrier for transport services; essential for carrier spend analysis, contract compliance verification, and freight audit. Standard logistics procurement practice to tr',
    `freight_order_id` BIGINT COMMENT 'Foreign key linking to freight.freight_order. Business justification: Purchase orders for physical goods trigger inbound freight orders. Tracking this link enables freight cost accrual to inventory cost, delivery performance monitoring against PO required dates, and fre',
    `location_id` BIGINT COMMENT 'Reference to the facility, warehouse, or office location issuing the purchase order.',
    `company_code_id` BIGINT COMMENT 'Reference to the internal business entity (legal entity, subsidiary, operating company) issuing this purchase order.',
    `employee_id` BIGINT COMMENT 'Reference to the procurement professional or employee who created and manages this purchase order.',
    `procurement_contract_id` BIGINT COMMENT 'Reference to the master procurement contract or blanket agreement under which this purchase order is issued, if applicable.',
    `requester_employee_id` BIGINT COMMENT 'Reference to the employee who originated the purchase requisition that led to this purchase order.',
    `risk_assessment_id` BIGINT COMMENT 'Foreign key linking to safety.risk_assessment. Business justification: High-value or hazardous material purchase orders require formal risk assessments before approval. Links PO to risk assessment for audit trail, approval justification, and compliance documentation in l',
    `ship_to_location_id` BIGINT COMMENT 'Reference to the destination location where goods or services should be delivered.',
    `supplier_id` BIGINT COMMENT 'Reference to the supplier receiving this purchase order.',
    `supplier_site_id` BIGINT COMMENT 'Foreign key linking to procurement.supplier_site. Business justification: Purchase orders are directed to a specific supplier site for fulfillment. The supplier_site identifies the physical location, bank details, and contact for the order. No columns removed as PO doesnt ',
    `acknowledgement_received_timestamp` TIMESTAMP COMMENT 'Date and time when the supplier acknowledged receipt and acceptance of the purchase order.',
    `approval_status` STRING COMMENT 'Current approval workflow status for this purchase order.. Valid values are `not_required|pending|approved|rejected|escalated`',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when the purchase order was approved.',
    `budget_code` STRING COMMENT 'Budget line or project code against which this purchase order is charged for budget tracking and control.',
    `cancellation_reason` STRING COMMENT 'Explanation or reason code for why the purchase order was cancelled.',
    `cancelled_timestamp` TIMESTAMP COMMENT 'Date and time when the purchase order was cancelled, if applicable.',
    `closed_timestamp` TIMESTAMP COMMENT 'Date and time when the purchase order was closed after full receipt and invoice matching.',
    `cost_center_code` STRING COMMENT 'Cost center to which this purchase order expenditure is allocated for financial accounting and budget control.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this purchase order record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the purchase order monetary values (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `expenditure_type` STRING COMMENT 'Classification of purchase order as Capital Expenditure (CAPEX) for long-term assets or Operating Expenditure (OPEX) for operational costs.. Valid values are `CAPEX|OPEX`',
    `freight_term` STRING COMMENT 'Freight payment responsibility: prepaid (supplier pays), collect (buyer pays), third-party (designated carrier), FOB origin, FOB destination.. Valid values are `prepaid|collect|third_party|fob_origin|fob_destination`',
    `gl_account_code` STRING COMMENT 'General ledger account code for posting this purchase order expenditure in the financial system.',
    `incoterm` STRING COMMENT 'International Commercial Terms defining the responsibilities of buyer and supplier for delivery, insurance, and risk transfer (e.g., FOB, CIF, DDP, EXW). [ENUM-REF-CANDIDATE: EXW|FCA|CPT|CIP|DAP|DPU|DDP|FAS|FOB|CFR|CIF — 11 candidates stripped; promote to reference product]',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this purchase order record was last modified or updated.',
    `net_amount` DECIMAL(18,2) COMMENT 'Net total value of the purchase order including taxes and all adjustments. Final payable amount.',
    `payment_method` STRING COMMENT 'Method by which payment will be made to the supplier.. Valid values are `wire_transfer|ach|check|credit_card|letter_of_credit|cash`',
    `payment_term_code` STRING COMMENT 'Code representing the payment terms agreed with the supplier (e.g., NET30, NET60, 2/10NET30).',
    `po_date` DATE COMMENT 'Date when the purchase order was created and issued. Principal business event timestamp for this transaction.',
    `po_number` STRING COMMENT 'Externally-known unique purchase order number issued to supplier. Business identifier for procurement transactions.. Valid values are `^PO-[0-9]{8,12}$`',
    `po_status` STRING COMMENT 'Current lifecycle status of the purchase order in the procurement workflow. [ENUM-REF-CANDIDATE: draft|pending_approval|approved|sent|acknowledged|partially_received|fully_received|closed|cancelled — 9 candidates stripped; promote to reference product]',
    `po_type` STRING COMMENT 'Classification of purchase order type: standard (one-time purchase), blanket (recurring purchases against agreement), planned (scheduled delivery), contract-release (release against master contract), spot (ad-hoc), emergency (urgent procurement).. Valid values are `standard|blanket|planned|contract_release|spot|emergency`',
    `priority` STRING COMMENT 'Priority level assigned to this purchase order for supplier attention and internal processing.. Valid values are `low|normal|high|urgent|critical`',
    `procurement_category` STRING COMMENT 'High-level procurement category or commodity classification (e.g., Fleet & Vehicles, IT Equipment, Warehouse Supplies, Professional Services, Fuel & Energy).',
    `promised_delivery_date` DATE COMMENT 'Date confirmed by the supplier for delivery of goods or completion of services.',
    `requested_delivery_date` DATE COMMENT 'Date by which the buyer requests delivery of goods or completion of services.',
    `sent_to_supplier_timestamp` TIMESTAMP COMMENT 'Date and time when the purchase order was transmitted to the supplier via EDI, email, or portal.',
    `shipping_method` STRING COMMENT 'Preferred or required shipping method for delivery (e.g., air freight, ocean freight, ground, courier).',
    `source_system` STRING COMMENT 'Name of the operational system where this purchase order was originally created (e.g., Coupa, SAP S/4HANA).',
    `source_system_code` STRING COMMENT 'Unique identifier of this purchase order in the source operational system.',
    `special_instructions` STRING COMMENT 'Additional instructions, notes, or requirements communicated to the supplier regarding this purchase order.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Total tax amount applicable to this purchase order (VAT, GST, sales tax, etc.).',
    `total_amount` DECIMAL(18,2) COMMENT 'Total gross value of the purchase order before taxes and adjustments.',
    CONSTRAINT pk_purchase_order PRIMARY KEY(`purchase_order_id`)
) COMMENT 'Formal purchase order issued to a supplier authorizing the procurement of goods or services. Captures PO number, PO type (standard, blanket, planned, contract-release), issuing entity, supplier, ship-to location, bill-to entity, total PO value, currency, payment terms, INCOTERMS, delivery date, budget code, cost center, CAPEX/OPEX classification, and PO status (draft, approved, sent, partially received, fully received, closed, cancelled). SSOT for all purchase commitments. Sourced from Coupa, integrated with SAP S/4HANA Finance for budget control.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`procurement`.`po_line` (
    `po_line_id` BIGINT COMMENT 'Unique identifier for the purchase order line item. Primary key.',
    `blanket_order_id` BIGINT COMMENT 'Foreign key linking to procurement.blanket_order. Business justification: PO lines can be call-off releases against blanket orders. This is a standard procurement pattern where individual purchase orders are issued against pre-negotiated framework agreements. Establishes th',
    `chart_of_accounts_id` BIGINT COMMENT 'Foreign key linking to finance.chart_of_accounts. Business justification: Account assignment at line level supports automated accrual posting and three-way match GL integration. Each PO line must specify GL account for goods receipt and invoice verification.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Line-level cost center assignment is standard for mixed-purpose POs where different lines charge to different departments. Enables accurate departmental expense allocation and budget tracking.',
    `location_id` BIGINT COMMENT 'Reference to the warehouse, facility, or site where the goods should be delivered or the service performed. Links to the location master.',
    `hazard_register_id` BIGINT COMMENT 'Foreign key linking to safety.hazard_register. Business justification: PO lines for hazardous materials, dangerous goods, or hazardous equipment reference hazard register entries. Links procurement to hazard management for handling requirements, PPE specifications, and s',
    `item_id` BIGINT COMMENT 'Reference to the master item or material being procured. Links to the product/service catalog entry.',
    `employee_id` BIGINT COMMENT 'Reference to the procurement professional responsible for managing this line item. Used for workload distribution and performance tracking.',
    `procurement_contract_id` BIGINT COMMENT 'Reference to the master procurement contract or blanket purchase agreement under which this line item is released. Used for contract compliance monitoring and spend tracking.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Service line cost allocation at PO line level enables accurate project costing and segment profitability analysis. Required for customer-specific procurement and landed cost calculation.',
    `purchase_order_id` BIGINT COMMENT 'Reference to the parent purchase order header. Links this line item to its containing purchase order document.',
    `purchase_requisition_id` BIGINT COMMENT 'Reference to the originating purchase requisition line that triggered this PO line. Provides traceability from demand to procurement.',
    `requester_employee_id` BIGINT COMMENT 'Reference to the employee or business unit that requested this item. Used for chargeback and spend analysis by department.',
    `sku_id` BIGINT COMMENT 'Foreign key linking to warehouse.sku. Business justification: PO lines must reference warehouse SKU master for receipt validation, inventory planning, and putaway routing. Essential for matching ordered items to warehouse inventory records during receiving and q',
    `supplier_id` BIGINT COMMENT 'Reference to the supplier providing the goods or services for this line item. May differ from the PO header supplier in cases of drop-ship or multi-supplier orders.',
    `asset_number` STRING COMMENT 'The fixed asset number if this line item represents the procurement of a capital asset. Used for asset capitalization and depreciation tracking.',
    `closed_date` DATE COMMENT 'The date when this line item was administratively closed, either due to full receipt, cancellation, or manual closure. Used for open PO reporting and aging analysis.',
    `commodity_category` STRING COMMENT 'Classification of the item into a procurement commodity category for spend analysis and sourcing strategy. Examples include Fleet Vehicles, Warehouse Equipment, IT Hardware, Professional Services, Fuel, Packaging Materials.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this purchase order line record was first created in the system. Used for audit trail and process cycle time analysis.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the unit price and line total. Examples: USD, EUR, GBP, CNY.. Valid values are `^[A-Z]{3}$`',
    `discount_amount` DECIMAL(18,2) COMMENT 'Any discount applied to this line item, expressed as a monetary value. May result from volume discounts, promotional pricing, or negotiated contract terms.',
    `incoterm` STRING COMMENT 'The Incoterm that defines the division of costs and risks between buyer and supplier for this line item. Examples: EXW, FOB, CIF, DDP, DAP.',
    `invoiced_quantity` DECIMAL(18,2) COMMENT 'The cumulative quantity that has been invoiced by the supplier for this line item. Used for invoice matching and payment processing.',
    `is_capital_expenditure` BOOLEAN COMMENT 'Flag indicating whether this line item represents a capital expenditure (CAPEX) rather than an operating expenditure (OPEX). Determines accounting treatment and approval workflow.',
    `is_services` BOOLEAN COMMENT 'Flag indicating whether this line item represents services rather than goods. Affects receipt processing and invoice matching rules.',
    `line_notes` STRING COMMENT 'Free-text notes or special instructions specific to this line item. May include delivery instructions, quality requirements, or handling notes.',
    `line_number` STRING COMMENT 'Sequential line number within the purchase order. Determines the ordering and display sequence of line items on the PO document.',
    `line_status` STRING COMMENT 'Current lifecycle status of the purchase order line item. Tracks progression from open order through receipt and closure.. Valid values are `open|partially_received|fully_received|cancelled|closed`',
    `line_total_amount` DECIMAL(18,2) COMMENT 'The total monetary value for this line item, calculated as ordered quantity multiplied by unit price, before taxes and adjustments.',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when this purchase order line record was last modified. Used for change tracking and audit compliance.',
    `net_amount` DECIMAL(18,2) COMMENT 'The final net amount for this line after applying discounts and adding taxes. Represents the actual financial commitment for this line item.',
    `ordered_quantity` DECIMAL(18,2) COMMENT 'The quantity of the item ordered on this line, expressed in the unit of measure. Represents the total amount requested from the supplier.',
    `payment_term_code` STRING COMMENT 'The payment terms applicable to this line item, defining when payment is due. Examples: Net 30, Net 60, 2/10 Net 30.',
    `promised_delivery_date` DATE COMMENT 'The date the supplier has committed to deliver the goods or complete the service. May differ from the requested date based on supplier lead times and capacity.',
    `received_quantity` DECIMAL(18,2) COMMENT 'The cumulative quantity of goods received against this line item to date. Used for goods receipt matching and three-way invoice matching.',
    `requested_delivery_date` DATE COMMENT 'The date by which the buyer requests delivery of the goods or completion of the service for this line item.',
    `supplier_part_number` STRING COMMENT 'The suppliers own part number or SKU for the item being procured. Used for supplier catalog matching and order communication.',
    `tax_amount` DECIMAL(18,2) COMMENT 'The total tax amount applicable to this line item. May include VAT, GST, sales tax, or other applicable taxes based on jurisdiction.',
    `tax_code` STRING COMMENT 'The tax classification code that determines the tax treatment for this line item. Used for tax calculation and compliance reporting.',
    `unit_of_measure` STRING COMMENT 'The unit in which the item quantity is measured. Examples: EA (Each), KG (Kilogram), LTR (Liter), HR (Hour), DAY (Day), BOX, PALLET.',
    `unit_price` DECIMAL(18,2) COMMENT 'The price per unit of measure for the item. Used to calculate the line total amount.',
    `wbs_element` STRING COMMENT 'The project work breakdown structure element for capital projects or project-based procurement. Used for project cost tracking and CAPEX management.',
    CONSTRAINT pk_po_line PRIMARY KEY(`po_line_id`)
) COMMENT 'Individual line items on a purchase order, each representing a distinct good or service being procured. Captures line number, item description, commodity category, unit of measure, ordered quantity, unit price, line total, delivery schedule, account assignment (cost center, WBS element, asset), and line status (open, partially received, fully received, cancelled). Enables granular goods receipt matching and three-way invoice matching. Sourced from Coupa.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`procurement`.`goods_receipt` (
    `goods_receipt_id` BIGINT COMMENT 'Unique identifier for the goods receipt record. Primary key.',
    `consignment_id` BIGINT COMMENT 'Reference to the inbound shipment or freight delivery that transported the goods to the receiving location, linking receipt to logistics tracking.',
    `cost_center_id` BIGINT COMMENT 'Reference to the cost center or department that will be charged for the received goods or services, used for budget tracking and financial reporting.',
    `declaration_id` BIGINT COMMENT 'Foreign key linking to customs.declaration. Business justification: Goods receipts are matched to customs release documents for inventory booking and duty allocation. Warehouse teams reconcile physical receipt against customs clearance for landed cost accounting and c',
    `facility_id` BIGINT COMMENT 'Foreign key linking to warehouse.facility. Business justification: Goods receipts occur at specific warehouse facilities; essential for location-based receipt tracking, inventory positioning, and facility-level procurement performance reporting. Enables accurate mult',
    `facility_inspection_id` BIGINT COMMENT 'Foreign key linking to safety.facility_inspection. Business justification: Goods receipts of hazardous materials trigger mandatory facility inspections. Links receipt to inspection record for compliance verification, storage authorization, and regulatory documentation in war',
    `freight_order_id` BIGINT COMMENT 'Foreign key linking to freight.freight_order. Business justification: Goods receipts for inbound shipments must reference the freight order that delivered the goods. Essential for three-way matching (PO-GR-Invoice) and freight cost allocation to received inventory. Stan',
    `inbound_receipt_id` BIGINT COMMENT 'Foreign key linking to warehouse.inbound_receipt. Business justification: Three-way matching (PO-GR-Invoice) requires linking procurements goods receipt to warehouses physical inbound receipt. Critical for invoice verification, discrepancy resolution, and financial reconc',
    `employee_id` BIGINT COMMENT 'Reference to the quality inspector or employee who performed the inspection and acceptance decision, if different from the receiver.',
    `invoice_id` BIGINT COMMENT 'Reference to the supplier invoice that has been matched to this goods receipt for payment processing. Null if invoice not yet received or matched.',
    `material_id` BIGINT COMMENT 'Reference to the material, product, or service master record being received. Links to the item catalog for specifications and inventory management.',
    `po_line_id` BIGINT COMMENT 'Reference to the specific line item on the purchase order being received.',
    `primary_goods_receiver_employee_id` BIGINT COMMENT 'Reference to the employee who physically received and recorded the goods receipt, responsible for verifying quantity and condition.',
    `purchase_order_id` BIGINT COMMENT 'Reference to the purchase order against which goods are being received.',
    `location_id` BIGINT COMMENT 'Reference to the warehouse, depot, hub, or facility where the goods were physically received.',
    `shift_schedule_id` BIGINT COMMENT 'Foreign key linking to workforce.shift_schedule. Business justification: Goods receipts processed during scheduled shifts for warehouse receiving labor productivity analysis, shift-level receiving KPIs, labor cost allocation to receiving operations. Critical for warehouse ',
    `supplier_id` BIGINT COMMENT 'Reference to the supplier or vendor who provided the goods or services being received.',
    `transport_document_id` BIGINT COMMENT 'Foreign key linking to document.transport_document. Business justification: Goods receipts for inbound shipments reference transport documents (delivery notes, BOLs, AWBs) as receiving evidence. Business process: 3-way match validation requires linking goods receipt to transp',
    `accepted_quantity` DECIMAL(18,2) COMMENT 'The quantity of goods that passed inspection and were accepted into inventory or for use. Used for three-way match with purchase order and invoice.',
    `batch_number` STRING COMMENT 'Manufacturer or supplier batch/lot number for traceability, quality control, and recall management. Critical for regulated materials and perishables.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the goods receipt record was first created in the system, marking the start of the receipt lifecycle.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code in which the receipt value is denominated (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `delivery_note_number` STRING COMMENT 'Supplier-provided delivery note, packing slip, or dispatch advice number accompanying the shipment. Used for cross-referencing and dispute resolution.',
    `expected_delivery_date` DATE COMMENT 'The date on which the goods were originally scheduled to arrive per the purchase order, used to measure supplier on-time delivery performance.',
    `expiry_date` DATE COMMENT 'Date after which the goods should not be used or sold, applicable to perishables, chemicals, pharmaceuticals, and time-sensitive materials.',
    `gl_account_code` STRING COMMENT 'General ledger account code to which the goods receipt value will be posted, linking procurement to financial accounting.',
    `gr_number` STRING COMMENT 'Business-facing unique identifier for the goods receipt, typically system-generated and used in communications with suppliers and internal stakeholders.. Valid values are `^GR[0-9]{10}$`',
    `inspection_certificate_number` STRING COMMENT 'Reference number of the quality inspection certificate or test report issued for the received goods, required for regulated or critical materials.',
    `inspection_date` DATE COMMENT 'Date on which the quality inspection was performed, which may differ from the receipt date if inspection is deferred or requires specialized testing.',
    `manufacture_date` DATE COMMENT 'Date on which the goods were manufactured, as declared by the supplier. Used for shelf-life management and compliance with age-sensitive material policies.',
    `match_tolerance_exceeded_flag` BOOLEAN COMMENT 'Indicates whether the variance between ordered and received quantity exceeds the acceptable tolerance threshold defined in procurement policy, triggering manual review.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when the goods receipt record was last updated, used for audit trail and change tracking.',
    `ordered_quantity` DECIMAL(18,2) COMMENT 'The quantity of goods originally ordered on the purchase order line, used as the baseline for receipt variance analysis.',
    `payment_cleared_flag` BOOLEAN COMMENT 'Indicates whether the supplier invoice associated with this goods receipt has been paid, completing the procure-to-pay cycle.',
    `receipt_date` DATE COMMENT 'The date on which the goods or services were physically or electronically received at the receiving location.',
    `receipt_status` STRING COMMENT 'Current lifecycle status of the goods receipt: draft (not yet finalized), pending inspection (awaiting quality check), accepted (fully approved), partially accepted (some items accepted), rejected (failed inspection), or cancelled.. Valid values are `draft|pending_inspection|accepted|partially_accepted|rejected|cancelled`',
    `receipt_timestamp` TIMESTAMP COMMENT 'Precise date and time when the goods receipt was recorded in the system, used for audit trail and time-sensitive matching processes.',
    `receipt_type` STRING COMMENT 'Classification of the goods receipt transaction: standard purchase, return to supplier, inter-location transfer, consignment receipt, or service acknowledgment.. Valid values are `standard|return|transfer|consignment|service`',
    `receipt_value_amount` DECIMAL(18,2) COMMENT 'Total monetary value of the accepted goods based on purchase order price, used for accrual accounting and inventory valuation.',
    `received_quantity` DECIMAL(18,2) COMMENT 'The total quantity of goods physically received, regardless of acceptance status. May differ from ordered quantity due to over-shipment, under-shipment, or partial delivery.',
    `receiving_dock` STRING COMMENT 'Specific dock, bay, or receiving area within the location where the goods were unloaded and inspected.',
    `rejected_quantity` DECIMAL(18,2) COMMENT 'The quantity of goods that failed inspection and were rejected, to be returned to supplier or disposed of per quality procedures.',
    `rejection_notes` STRING COMMENT 'Free-text detailed explanation of the rejection, including specific defects observed, photos taken, and actions required from the supplier.',
    `rejection_reason_code` STRING COMMENT 'Standardized code indicating the primary reason for rejection: quality defect, quantity mismatch, damage during transit, incorrect item shipped, expired goods, late delivery beyond tolerance, or missing/incorrect documentation. [ENUM-REF-CANDIDATE: quality_defect|quantity_mismatch|damaged_in_transit|wrong_item|expired|late_delivery|documentation_error — 7 candidates stripped; promote to reference product]',
    `return_authorization_number` STRING COMMENT 'RMA number issued by the supplier authorizing the return of rejected goods, used to track the reverse logistics process and credit issuance.',
    `serial_number` STRING COMMENT 'Unique serial number for individually tracked items such as equipment, vehicles, or high-value assets. Enables unit-level traceability.',
    `source_system` STRING COMMENT 'Name of the operational system from which the goods receipt record originated (e.g., Coupa, Manhattan WMS, SAP), used for data lineage and troubleshooting.',
    `source_system_code` STRING COMMENT 'Unique identifier of the goods receipt record in the source operational system, used for reconciliation and audit trail back to the system of record.',
    `storage_location` STRING COMMENT 'Specific storage area, bin, or zone within the receiving location where accepted goods have been placed, used for inventory locator accuracy.',
    `three_way_match_status` STRING COMMENT 'Status of the three-way match process comparing purchase order, goods receipt, and supplier invoice: matched (all align within tolerance), quantity variance (receipt quantity differs), price variance (invoice price differs), not matched (significant discrepancies), or pending (invoice not yet received).. Valid values are `matched|quantity_variance|price_variance|not_matched|pending`',
    `unit_of_measure` STRING COMMENT 'The unit in which quantities are expressed (e.g., EA for each, KG for kilograms, LTR for liters, BOX, PALLET). Must match the purchase order line UOM.',
    CONSTRAINT pk_goods_receipt PRIMARY KEY(`goods_receipt_id`)
) COMMENT 'Records the physical or electronic receipt of goods and services against a purchase order line. Captures GR number, receipt date, received quantity, accepted quantity, rejected quantity, rejection reason, receiving location (warehouse, depot, hub), receiver employee ID, and three-way match status. Critical for accounts payable invoice matching and inventory replenishment confirmation. Sourced from Coupa and Manhattan WMS receiving workflows.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`procurement`.`supplier_invoice` (
    `supplier_invoice_id` BIGINT COMMENT 'Unique identifier for the supplier invoice record. Primary key.',
    `chart_of_accounts_id` BIGINT COMMENT 'Foreign key linking to finance.chart_of_accounts. Business justification: Invoice posting requires GL account determination from chart of accounts for proper financial statement classification. Automated account assignment rules depend on this link for freight, warehousing,',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: Supplier invoices must post to a legal entity for GL integration, tax reporting, and SOX controls. Every AP invoice in logistics operations requires company code assignment for financial statement con',
    `contract_approval_workflow_id` BIGINT COMMENT 'Reference to the approval workflow instance governing this invoice. Links to workflow tracking for approval routing, delegation, and audit trail.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Freight and logistics service invoices allocate to cost centers for departmental expense tracking and budget consumption. Standard procurement-to-finance integration point for operational cost managem',
    `declaration_id` BIGINT COMMENT 'Foreign key linking to customs.declaration. Business justification: Supplier invoices are key valuation documents attached to customs declarations. Customs brokers and valuation teams verify invoice amounts against declared values for transaction value method complian',
    `duty_assessment_id` BIGINT COMMENT 'Foreign key linking to customs.duty_assessment. Business justification: Supplier invoices are matched to duty assessments for landed cost accounting. AP teams allocate duty charges to invoices for total cost capture, enabling accurate COGS calculation and supplier cost an',
    `fiscal_period_id` BIGINT COMMENT 'Foreign key linking to finance.fiscal_period. Business justification: Period-end close process requires invoices assigned to correct fiscal period for accrual accuracy, cutoff controls, and revenue/expense matching. Critical for monthly financial reporting and audit tra',
    `goods_receipt_id` BIGINT COMMENT 'Reference to the goods receipt or service entry sheet confirming delivery. Critical component of three-way match process. Null for service invoices without formal receipt.',
    `inbound_receipt_id` BIGINT COMMENT 'Foreign key linking to warehouse.inbound_receipt. Business justification: Invoice verification requires direct link to warehouse physical receipt for three-way match completion. Enables automated matching of invoice quantities/values against actual received goods, critical ',
    `employee_id` BIGINT COMMENT 'Reference to the employee who approved this invoice for payment. Null if invoice is not yet approved or approval is not required.',
    `procurement_contract_id` BIGINT COMMENT 'Reference to the master contract or agreement under which this invoice is issued. Used for contract compliance validation and spend tracking. Null if not contract-based.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Service line P&L reporting requires profit center assignment on supplier invoices for margin analysis by business segment. Enables landed cost calculation and profitability tracking in logistics opera',
    `purchase_order_id` BIGINT COMMENT 'Reference to the purchase order against which this invoice is submitted. Used for three-way match validation (PO, goods receipt, invoice). Null for non-PO invoices.',
    `supplier_id` BIGINT COMMENT 'Reference to the supplier who submitted this invoice. Links to supplier master data for vendor details, payment information, and compliance status.',
    `supplier_site_id` BIGINT COMMENT 'Foreign key linking to procurement.supplier_site. Business justification: Supplier invoices are submitted from and remitted to a specific supplier site. The supplier_site contains bank account details, payment currency, and contact information needed for payment processing.',
    `tertiary_supplier_modified_by_user_employee_id` BIGINT COMMENT 'Reference to the user who last modified this invoice record. Used for audit trail and change accountability.',
    `transport_document_id` BIGINT COMMENT 'Foreign key linking to document.transport_document. Business justification: Freight invoices from carriers reference transport documents (BOL, AWB) as proof of service delivery. Business process: freight invoice reconciliation requires matching invoice line items to transport',
    `approval_date` DATE COMMENT 'Date the invoice was approved for payment. Null if not yet approved.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this invoice record was first created in the system. Used for audit trail and data lineage.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the invoice amounts. Used for multi-currency accounting and foreign exchange management.. Valid values are `^[A-Z]{3}$`',
    `discount_amount` DECIMAL(18,2) COMMENT 'Total discount applied to the invoice. Includes early payment discounts, volume discounts, or negotiated reductions.',
    `dispute_date` DATE COMMENT 'Date the invoice was flagged as disputed. Null if not disputed.',
    `dispute_flag` BOOLEAN COMMENT 'Indicates whether this invoice is currently under dispute. True if disputed, false otherwise.',
    `dispute_reason` STRING COMMENT 'Reason for disputing the invoice. Examples: incorrect pricing, goods not received, quality issues, duplicate invoice. Null if not disputed.',
    `document_reference_url` STRING COMMENT 'URL or file path to the original invoice document (PDF, image, EDI file). Used for document retrieval and audit purposes.',
    `due_date` DATE COMMENT 'Date by which payment is due to the supplier per agreed payment terms. Critical for cash flow management and supplier relationship.',
    `exchange_rate` DECIMAL(18,2) COMMENT 'Foreign exchange rate applied to convert invoice currency to base accounting currency. Null if invoice is in base currency.',
    `gross_amount` DECIMAL(18,2) COMMENT 'Total invoice amount before tax and adjustments. Sum of all line item amounts.',
    `invoice_date` DATE COMMENT 'Date the supplier issued the invoice. Principal business event timestamp for accounting period assignment and payment term calculation.',
    `invoice_description` STRING COMMENT 'Free-text description of the invoice purpose or contents. Provides business context for the invoice.',
    `invoice_number` STRING COMMENT 'Supplier-assigned unique invoice number. Business identifier for external reference and reconciliation.',
    `invoice_status` STRING COMMENT 'Current lifecycle status of the invoice in the accounts payable workflow. Tracks progression from submission through approval, matching, and payment. [ENUM-REF-CANDIDATE: draft|submitted|pending_approval|approved|rejected|matched|paid|cancelled|disputed — 9 candidates stripped; promote to reference product]',
    `invoice_type` STRING COMMENT 'Classification of the invoice document type. Standard for regular invoices, credit memo for returns/adjustments, debit memo for additional charges, prepayment for advance payments, proforma for quotations, self-billing for buyer-generated invoices.. Valid values are `standard|credit_memo|debit_memo|prepayment|proforma|self_billing`',
    `match_exception_amount` DECIMAL(18,2) COMMENT 'Monetary value of the discrepancy identified in three-way match. Null if no exception or exception is non-monetary.',
    `match_exception_resolution` STRING COMMENT 'Description of how the match exception was resolved. Examples: supplier credit issued, PO amended, goods receipt corrected, management override. Null if exception is unresolved.',
    `match_exception_type` STRING COMMENT 'Type of discrepancy identified during three-way match. Examples: price variance, quantity variance, tax variance, missing PO, missing goods receipt. Null if no exception. [ENUM-REF-CANDIDATE: price_variance|quantity_variance|tax_variance|missing_po|missing_gr|duplicate_invoice|unauthorized_charge — promote to reference product]',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this invoice record was last modified. Used for audit trail and change tracking.',
    `net_amount` DECIMAL(18,2) COMMENT 'Final payable amount after applying tax, discounts, and adjustments. This is the amount due to the supplier.',
    `payment_date` DATE COMMENT 'Actual date payment was executed to the supplier. Null if invoice is unpaid.',
    `payment_method` STRING COMMENT 'Method by which payment will be or was executed. Wire transfer for international payments, ACH for domestic electronic, check for paper-based, credit/virtual card for card-based, letter of credit for trade finance.. Valid values are `wire_transfer|ach|check|credit_card|virtual_card|letter_of_credit`',
    `payment_reference_number` STRING COMMENT 'Bank or payment system reference number for the executed payment. Used for payment reconciliation and audit trail. Null if unpaid.',
    `payment_term_code` STRING COMMENT 'Code representing the agreed payment terms. Examples: NET30, NET60, 2/10NET30 (2% discount if paid within 10 days, net due in 30 days).',
    `received_date` DATE COMMENT 'Date the invoice was received by the organization. Used for processing SLA tracking and aging analysis.',
    `submission_method` STRING COMMENT 'Channel through which the supplier submitted the invoice. EDI for Electronic Data Interchange, email for scanned/PDF invoices, portal for supplier self-service, paper for physical mail, API for system-to-system integration.. Valid values are `edi|email|portal|paper|api`',
    `tax_amount` DECIMAL(18,2) COMMENT 'Total tax amount applied to the invoice. Includes VAT, GST, sales tax, or other applicable taxes per jurisdiction.',
    `tax_jurisdiction` STRING COMMENT 'Tax jurisdiction or authority under which tax is calculated and remitted. Examples: US-CA (California), GB-VAT (UK VAT), EU-VAT. Critical for tax compliance and reporting.',
    `tax_registration_number` STRING COMMENT 'Suppliers tax registration number or VAT identification number. Used for tax validation and compliance verification.',
    `three_way_match_status` STRING COMMENT 'Status of the three-way match validation comparing purchase order, goods receipt, and invoice. Not applicable for non-PO invoices, pending during validation, matched when all documents align, exception when discrepancies exist, override approved when exceptions are manually approved.. Valid values are `not_applicable|pending|matched|exception|override_approved`',
    `withholding_tax_amount` DECIMAL(18,2) COMMENT 'Amount of tax withheld at source per local tax regulations. Deducted from payment to supplier and remitted to tax authority. Null if no withholding applies.',
    CONSTRAINT pk_supplier_invoice PRIMARY KEY(`supplier_invoice_id`)
) COMMENT 'Supplier-submitted invoice for goods or services delivered under a purchase order or contract. Captures invoice number, dates, amounts (gross/tax/net), currency, payment terms, PO reference, invoice type (standard, credit memo, debit memo), and three-way match status including exception details and resolution workflow. SSOT for accounts payable obligations within procurement. Integrates with SAP S/4HANA AP for payment execution.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`procurement`.`procurement_invoice_line` (
    `procurement_invoice_line_id` BIGINT COMMENT 'Unique identifier for the procurement invoice line item. Primary key for this entity.',
    `fiscal_period_id` BIGINT COMMENT 'Foreign key linking to finance.fiscal_period. Business justification: Line-level period assignment enables detailed accrual reconciliation and supports three-way match variance analysis by period. Required for multi-period service contracts and freight accruals spanning',
    `goods_receipt_id` BIGINT COMMENT 'Reference to the goods receipt line record. Used for three-way matching to verify that goods or services were received before payment.',
    `item_id` BIGINT COMMENT 'Foreign key linking to procurement.item. Business justification: Invoice lines reference specific catalog items for three-way matching against PO lines and goods receipts. The item master provides the authoritative item reference. No columns removed as item is a th',
    `po_line_id` BIGINT COMMENT 'Reference to the originating purchase order line item. Used for three-way matching between PO, goods receipt, and invoice.',
    `supplier_invoice_id` BIGINT COMMENT 'Reference to the parent procurement invoice header. Links this line item to its parent invoice document.',
    `approval_status` STRING COMMENT 'Current approval status of this invoice line. Indicates whether the line has been reviewed and approved for payment.. Valid values are `pending|approved|rejected|on_hold`',
    `approved_by` STRING COMMENT 'User ID or name of the person who approved this invoice line for payment. Used for audit trail and accountability.',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when this invoice line was approved for payment. Used for audit trail and payment processing workflow.',
    `asset_number` STRING COMMENT 'Fixed asset number if this line represents a capital asset purchase. Used for asset capitalization and depreciation tracking.',
    `cost_center_code` STRING COMMENT 'Cost center code for expense allocation. Used for internal cost tracking and departmental budget management.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this invoice line record was first created in the system. Used for audit trail and data lineage.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts on this line. Examples: USD, EUR, GBP, CNY.. Valid values are `^[A-Z]{3}$`',
    `delivery_date` DATE COMMENT 'Date when goods or services for this line were delivered or performed. Used for accrual accounting and service level verification.',
    `discount_amount` DECIMAL(18,2) COMMENT 'Total discount applied to this invoice line. May include early payment discounts, volume discounts, or promotional discounts.',
    `dispute_flag` BOOLEAN COMMENT 'Indicates whether this invoice line is under dispute. True if the line has been flagged for investigation or resolution.',
    `dispute_reason` STRING COMMENT 'Detailed explanation of the dispute reason if dispute flag is true. Captures the business justification for withholding payment or requesting credit.',
    `gl_account_code` STRING COMMENT 'General ledger account code for posting this invoice line. Determines the financial account assignment for expense or asset recognition.',
    `invoiced_quantity` DECIMAL(18,2) COMMENT 'Quantity of goods or services invoiced on this line. Used for variance analysis against PO quantity and goods receipt quantity.',
    `item_category` STRING COMMENT 'Classification of the invoiced item type. Distinguishes between goods, services, freight, fuel, maintenance, capital equipment, software, and consulting services. [ENUM-REF-CANDIDATE: goods|services|freight|fuel|maintenance|capital_equipment|software|consulting — 8 candidates stripped; promote to reference product]',
    `item_description` STRING COMMENT 'Detailed textual description of the goods or services invoiced on this line. May include specifications, model numbers, or service details.',
    `line_amount` DECIMAL(18,2) COMMENT 'Total amount for this invoice line before taxes and adjustments. Typically calculated as invoiced quantity multiplied by unit price.',
    `line_number` STRING COMMENT 'Sequential line number within the invoice. Determines the ordering and position of this line item in the invoice document.',
    `match_status` STRING COMMENT 'Three-way match status for this invoice line. Indicates whether the invoice line matches the PO and goods receipt within acceptable tolerances.. Valid values are `matched|price_variance|quantity_variance|unmatched|disputed|approved`',
    `material_code` STRING COMMENT 'Internal material or service master code. Links to the organizations master data catalog for goods or services.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this invoice line record was last modified. Used for audit trail and change tracking.',
    `net_line_amount` DECIMAL(18,2) COMMENT 'Net amount for this invoice line after discounts and taxes. Represents the final payable amount for this line item.',
    `notes` STRING COMMENT 'Free-text notes or comments related to this invoice line. May include special instructions, variance explanations, or additional context.',
    `payment_terms` STRING COMMENT 'Payment terms applicable to this invoice line. May differ from header-level terms for specific line items. Examples: Net 30, Net 60, 2/10 Net 30.',
    `price_variance_amount` DECIMAL(18,2) COMMENT 'Difference between invoiced unit price and PO unit price multiplied by invoiced quantity. Positive values indicate invoice price exceeds PO price.',
    `profit_center_code` STRING COMMENT 'Profit center code for revenue and cost allocation. Used for business unit profitability analysis.',
    `project_code` STRING COMMENT 'Project or work order code for capital expenditure (CAPEX) or project-specific expense tracking. Used for project accounting and cost allocation.',
    `quantity_variance` DECIMAL(18,2) COMMENT 'Difference between invoiced quantity and goods receipt quantity. Positive values indicate invoice quantity exceeds received quantity.',
    `service_period_end_date` DATE COMMENT 'End date of the service period for this invoice line. Used for accrual accounting and service period reconciliation.',
    `service_period_start_date` DATE COMMENT 'Start date of the service period for this invoice line. Applicable for recurring services, subscriptions, or time-based billing.',
    `source_system` STRING COMMENT 'Name of the source system from which this invoice line was extracted. Typically Coupa Procurement or SAP S/4HANA Finance.',
    `source_system_code` STRING COMMENT 'Unique identifier of this invoice line in the source system. Used for data reconciliation and traceability back to the operational system.',
    `supplier_part_number` STRING COMMENT 'Suppliers unique part or service identifier. Used for cross-referencing with supplier catalogs and purchase orders.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Total tax amount calculated for this invoice line. Includes VAT, GST, sales tax, or other applicable taxes based on the tax code.',
    `tax_code` STRING COMMENT 'Tax classification code applied to this line item. Determines the applicable tax rate and tax jurisdiction for this transaction.',
    `tax_rate_percent` DECIMAL(18,2) COMMENT 'Tax rate percentage applied to this line item. Used for tax calculation and compliance reporting.',
    `unit_of_measure` STRING COMMENT 'Unit of measure for the invoiced quantity. Examples include EA (each), KG (kilogram), L (liter), HR (hour), CBM (cubic meter), TEU (twenty-foot equivalent unit).',
    `unit_price` DECIMAL(18,2) COMMENT 'Price per unit of measure as stated on the invoice. Used to calculate line amount and for price variance analysis against PO unit price.',
    `variance_reason_code` STRING COMMENT 'Coded reason for price or quantity variance. Used for root cause analysis and supplier performance management. [ENUM-REF-CANDIDATE: price_increase|quantity_adjustment|partial_delivery|damaged_goods|service_change|contract_amendment|billing_error|freight_surcharge|currency_fluctuation — promote to reference product]',
    `withholding_tax_amount` DECIMAL(18,2) COMMENT 'Amount of withholding tax deducted from this invoice line. Applicable in jurisdictions requiring tax withholding at source.',
    `withholding_tax_code` STRING COMMENT 'Tax code for withholding tax calculation. Determines the applicable withholding tax rate and reporting requirements.',
    CONSTRAINT pk_procurement_invoice_line PRIMARY KEY(`procurement_invoice_line_id`)
) COMMENT 'Line-level detail of a supplier invoice, mapping to PO lines and goods receipt records for three-way matching. Captures line number, item description, invoiced quantity, unit price, line amount, tax code, account assignment, match status per line, and variance amount (price variance, quantity variance). Enables granular discrepancy identification and dispute resolution. Sourced from Coupa Invoice Management.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`procurement`.`purchase_requisition` (
    `purchase_requisition_id` BIGINT COMMENT 'Unique identifier for the purchase requisition. Primary key for this entity.',
    `org_unit_id` BIGINT COMMENT 'Identifier of the business unit or department that is requesting the purchase.',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: Requisitions must specify requesting legal entity for approval routing and subsequent PO/invoice company code defaulting. Ensures procurement documents align with correct financial entity from initiat',
    `contract_approval_workflow_id` BIGINT COMMENT 'Identifier of the approval workflow instance triggered for this requisition.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Budget check at requisition stage requires cost center link to validate available budget before PO creation. Prevents overspending and enforces budget controls at earliest procurement stage.',
    `location_id` BIGINT COMMENT 'Identifier of the facility, warehouse, or office location where the goods or services should be delivered.',
    `item_id` BIGINT COMMENT 'Foreign key linking to procurement.item. Business justification: A purchase requisition specifies what item is being requested. The item master is a reference table in procurement. This normalizes the item reference on the requisition, enabling catalog-based orderi',
    `position_id` BIGINT COMMENT 'Foreign key linking to workforce.position. Business justification: Requisitions tied to positions for budget authority, approval routing by role, position-based spending limits. Essential for role-level requisition analytics, position-specific procurement authority e',
    `supplier_id` BIGINT COMMENT 'Identifier of the supplier preferred by the requestor for fulfilling this requisition.',
    `employee_id` BIGINT COMMENT 'Identifier of the employee who initiated the purchase requisition.',
    `procurement_contract_id` BIGINT COMMENT 'Identifier of the existing contract or blanket purchase agreement under which this requisition is being placed.',
    `purchase_order_id` BIGINT COMMENT 'Identifier of the purchase order created from this requisition, if conversion outcome is converted_to_po.',
    `quaternary_purchase_last_modified_by_employee_id` BIGINT COMMENT 'Identifier of the employee who last modified the purchase requisition record.',
    `requestor_employee_id` BIGINT COMMENT 'FK to workforce.employee',
    `rfq_id` BIGINT COMMENT 'Identifier of the sourcing event (RFQ or RFP) created from this requisition, if routed to sourcing.',
    `sku_id` BIGINT COMMENT 'Foreign key linking to warehouse.sku. Business justification: Requisitions for inventory replenishment must reference specific warehouse SKUs to trigger accurate reordering. Essential for min-max replenishment, safety stock management, and linking procurement de',
    `tertiary_purchase_final_approver_employee_id` BIGINT COMMENT 'Identifier of the employee who provided the final approval for the requisition.',
    `approval_level` STRING COMMENT 'Current approval level in the multi-tier approval hierarchy (e.g., 1 for manager, 2 for director, 3 for VP).',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when the requisition received final approval.',
    `budget_check_status` STRING COMMENT 'Result of the budget availability check performed against the cost center and GL account at requisition submission.. Valid values are `not_checked|passed|failed|override_approved`',
    `budget_check_timestamp` TIMESTAMP COMMENT 'Date and time when the budget availability check was performed.',
    `conversion_outcome` STRING COMMENT 'Outcome of the requisition after approval, indicating whether it was converted to a purchase order, routed to a sourcing event, or cancelled.. Valid values are `not_converted|converted_to_po|routed_to_rfq|routed_to_rfp|cancelled`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the purchase requisition record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the estimated amounts (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `delivery_address` STRING COMMENT 'Full delivery address for the requisitioned goods or services, including street, city, state, and postal code.',
    `estimated_total_amount` DECIMAL(18,2) COMMENT 'Total estimated cost of the requisition, calculated as quantity requested multiplied by estimated unit price.',
    `estimated_unit_price` DECIMAL(18,2) COMMENT 'Estimated price per unit of the item or service being requisitioned, used for budget validation.',
    `gl_account_code` STRING COMMENT 'General ledger account code to which the requisition amount will be posted upon purchase order creation and invoice receipt.. Valid values are `^[0-9]{4,10}$`',
    `is_capital_expenditure` BOOLEAN COMMENT 'Boolean flag indicating whether this requisition represents a capital expenditure (true) or operating expenditure (false).',
    `justification` STRING COMMENT 'Business rationale and justification provided by the requestor for the purchase requisition.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when the purchase requisition record was last updated.',
    `priority_level` STRING COMMENT 'Priority classification of the requisition indicating urgency of the procurement need.. Valid values are `low|medium|high|urgent`',
    `quantity_requested` DECIMAL(18,2) COMMENT 'Quantity of the item or service being requisitioned.',
    `rejected_timestamp` TIMESTAMP COMMENT 'Date and time when the requisition was rejected by an approver.',
    `rejection_reason` STRING COMMENT 'Explanation provided by the approver for rejecting the purchase requisition.',
    `required_delivery_date` DATE COMMENT 'Date by which the requestor needs the goods or services to be delivered.',
    `requisition_number` STRING COMMENT 'Business-facing unique identifier for the purchase requisition, typically system-generated and used in communications and approvals.. Valid values are `^PR-[0-9]{8,12}$`',
    `requisition_status` STRING COMMENT 'Current lifecycle status of the purchase requisition in the approval and procurement workflow. [ENUM-REF-CANDIDATE: draft|submitted|pending_approval|approved|rejected|cancelled|converted_to_po — 7 candidates stripped; promote to reference product]',
    `requisition_type` STRING COMMENT 'Classification of the purchase requisition based on the nature of goods or services being requested.. Valid values are `goods|services|capital_equipment|maintenance_repair_operations|fleet_acquisition|warehouse_equipment`',
    `special_instructions` STRING COMMENT 'Additional instructions or requirements for the supplier regarding delivery, handling, or service execution.',
    `submitted_timestamp` TIMESTAMP COMMENT 'Date and time when the requisition was submitted for approval by the requestor.',
    `unit_of_measure` STRING COMMENT 'Unit of measure for the quantity requested (e.g., each, box, kilogram, hour). [ENUM-REF-CANDIDATE: each|box|pallet|kilogram|liter|hour|day|month|unit — 9 candidates stripped; promote to reference product]',
    CONSTRAINT pk_purchase_requisition PRIMARY KEY(`purchase_requisition_id`)
) COMMENT 'Internal demand signal raised by a business unit to initiate procurement. Captures requisition number, requestor, business unit, item details, estimated cost, required delivery date, justification, budget check result, approval status, and conversion outcome (converted to PO, routed to sourcing event, or rejected). Represents the entry point of the procure-to-pay lifecycle.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`procurement`.`blanket_order` (
    `blanket_order_id` BIGINT COMMENT 'Unique identifier for the blanket purchase order. Primary key.',
    `carrier_id` BIGINT COMMENT 'Foreign key linking to network.carrier. Business justification: Blanket purchase agreements with carriers for recurring freight services (e.g., annual lane commitments, volume-based rate agreements); standard logistics procurement practice to secure capacity and p',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: Blanket purchase agreements are legal commitments of a specific company code entity, required for commitment accounting and budget encumbrance. Each blanket order is a financial obligation of one lega',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Standing orders for recurring services (warehousing, transportation) default to cost centers for budget consumption tracking. Enables release-level cost center inheritance and variance reporting.',
    `facility_id` BIGINT COMMENT 'Foreign key linking to warehouse.facility. Business justification: Blanket orders specify target delivery facilities for release planning, capacity allocation, and inbound scheduling. Critical for coordinating supplier releases with warehouse receiving capacity and d',
    `org_unit_id` BIGINT COMMENT 'Foreign key linking to workforce.org_unit. Business justification: Blanket orders owned by organizational units for decentralized procurement in multi-location logistics operations. Enables org-level spend tracking, budget allocation, divisional procurement analytics',
    `procurement_contract_id` BIGINT COMMENT 'Foreign key linking to procurement.procurement_contract. Business justification: Blanket orders are typically established under master procurement contracts. The blanket_order table has contract_reference_number (STRING) which should be replaced with a formal FK to procurement_con',
    `rfq_id` BIGINT COMMENT 'Foreign key linking to procurement.rfq. Business justification: Blanket orders may originate from RFQ sourcing events. The blanket_order table has rfq_reference_number (STRING) which should be replaced with a formal FK to rfq. This establishes the sourcing lineage',
    `supplier_id` BIGINT COMMENT 'Reference to the supplier with whom this blanket order is established.',
    `agreement_number` STRING COMMENT 'Externally-known unique identifier for the blanket purchase agreement, used in communications with suppliers and internal procurement tracking.. Valid values are `^[A-Z0-9-]{6,20}$`',
    `agreement_type` STRING COMMENT 'Classification of the blanket order by its primary control mechanism: value-based (spend limit), quantity-based (volume limit), time-based (duration only), or hybrid (multiple constraints).. Valid values are `value_based|quantity_based|time_based|hybrid`',
    `approval_status` STRING COMMENT 'Current approval state of the blanket order in the procurement workflow.. Valid values are `pending|approved|rejected`',
    `approved_by` STRING COMMENT 'Name or identifier of the person who approved this blanket order. Nullable if not yet approved.',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when the blanket order was approved. Nullable if not yet approved.',
    `blanket_order_status` STRING COMMENT 'Current lifecycle state of the blanket order: draft (being prepared), active (available for releases), suspended (temporarily inactive), expired (validity period ended), closed (completed normally), cancelled (terminated early).. Valid values are `draft|active|suspended|expired|closed|cancelled`',
    `category_code` STRING COMMENT 'Classification code identifying the spend category or commodity group covered by this blanket order (e.g., fuel, courier services, warehouse consumables, fleet parts).. Valid values are `^[A-Z0-9-]{4,15}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this blanket order record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary values in this blanket order.. Valid values are `^[A-Z]{3}$`',
    `delivery_terms` STRING COMMENT 'International Commercial Terms defining delivery responsibilities and risk transfer (e.g., FOB, CIF, DDP, DAP, EXW).',
    `discount_percentage` DECIMAL(18,2) COMMENT 'Negotiated discount percentage applied to list prices for releases under this blanket order. Nullable if no standard discount applies.',
    `effective_from_date` DATE COMMENT 'Date when the blanket order becomes active and available for call-off releases.',
    `effective_until_date` DATE COMMENT 'Date when the blanket order expires and is no longer available for new releases. Nullable for open-ended agreements.',
    `lead_time_days` STRING COMMENT 'Standard number of days from release order placement to expected delivery, as negotiated in the blanket agreement.',
    `material_group` STRING COMMENT 'Material or service group code for classification and reporting purposes.. Valid values are `^[A-Z0-9]{4,10}$`',
    `maximum_release_value` DECIMAL(18,2) COMMENT 'Maximum monetary value allowed for each individual release order against this blanket order. Nullable if no maximum applies.',
    `minimum_release_value` DECIMAL(18,2) COMMENT 'Minimum monetary value required for each individual release order against this blanket order. Nullable if no minimum applies.',
    `modified_by` STRING COMMENT 'Name or identifier of the user who last modified this blanket order record.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this blanket order record was last modified.',
    `notes` STRING COMMENT 'Free-text field for additional comments, special instructions, or internal notes related to this blanket order.',
    `payment_terms` STRING COMMENT 'Negotiated payment terms for releases under this blanket order (e.g., Net 30, Net 60, 2/10 Net 30).',
    `pricing_condition` STRING COMMENT 'Pricing structure negotiated in the blanket order: fixed (locked price), variable (market-based), index-linked (tied to commodity index), tiered (volume-based discounts).. Valid values are `fixed|variable|index_linked|tiered`',
    `purchasing_group` STRING COMMENT 'Code identifying the buyer or procurement team responsible for managing this blanket order.. Valid values are `^[A-Z0-9]{3,6}$`',
    `purchasing_organization` STRING COMMENT 'Code identifying the organizational unit responsible for this blanket order (e.g., regional procurement center, business unit).. Valid values are `^[A-Z0-9]{4,10}$`',
    `quality_requirements` STRING COMMENT 'Quality standards, certifications, or specifications that the supplier must meet for deliveries under this blanket order (e.g., ISO 9001, industry-specific standards).',
    `release_mechanism` STRING COMMENT 'Method by which purchase order releases are generated: manual (buyer-initiated), automatic (system-triggered by inventory levels), scheduled (periodic releases), demand-triggered (consumption-based).. Valid values are `manual|automatic|scheduled|demand_triggered`',
    `remaining_quantity` DECIMAL(18,2) COMMENT 'Available quantity balance remaining on the blanket order, calculated as total committed quantity minus total released quantity.',
    `remaining_value` DECIMAL(18,2) COMMENT 'Available balance remaining on the blanket order, calculated as total committed value minus total released value.',
    `shipping_point` STRING COMMENT 'Default origin location or supplier facility from which goods will be shipped for releases under this blanket order.',
    `sustainability_criteria` STRING COMMENT 'Environmental, social, and governance (ESG) requirements or sustainability commitments included in the blanket order (e.g., carbon footprint targets, ethical sourcing).',
    `tax_code` STRING COMMENT 'Tax classification code determining applicable tax rates and treatment for releases under this blanket order.. Valid values are `^[A-Z0-9]{2,6}$`',
    `total_committed_quantity` DECIMAL(18,2) COMMENT 'Maximum total quantity committed under this blanket order for quantity-based agreements. Nullable for value-based agreements.',
    `total_committed_value` DECIMAL(18,2) COMMENT 'Maximum total spend amount committed under this blanket order. Represents the upper financial limit for all releases combined.',
    `total_released_quantity` DECIMAL(18,2) COMMENT 'Cumulative quantity of all releases issued against this blanket order to date.',
    `total_released_value` DECIMAL(18,2) COMMENT 'Cumulative value of all purchase order releases issued against this blanket order to date.',
    `unit_of_measure` STRING COMMENT 'Standard unit of measure for quantity tracking (e.g., EA for each, KG for kilogram, LTR for liter, TEU for twenty-foot equivalent unit).. Valid values are `^[A-Z]{2,6}$`',
    `warranty_terms` STRING COMMENT 'Warranty or guarantee terms negotiated with the supplier for goods or services covered by this blanket order.',
    `created_by` STRING COMMENT 'Name or identifier of the procurement user who created this blanket order record.',
    CONSTRAINT pk_blanket_order PRIMARY KEY(`blanket_order_id`)
) COMMENT 'Long-term framework purchase agreement establishing pre-negotiated pricing and terms with a supplier for recurring goods or services (e.g., annual fuel supply, recurring courier services, warehouse consumables). Captures validity period, committed value, release mechanism, consumption tracking, and remaining balance. Enables call-off releases without re-negotiation.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`procurement`.`rate_agreement` (
    `rate_agreement_id` BIGINT COMMENT 'Primary key for rate_agreement',
    `carrier_id` BIGINT COMMENT 'Identifier of the transport carrier (road haulier, airline, ocean carrier, rail operator) party to this rate agreement.',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: Carrier rate contracts are negotiated and signed by specific legal entities; company code is the contracting party. Required for freight invoice validation and contract compliance reporting by entity.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Transportation cost allocation requires default cost center assignment on rate agreements for automated freight expense posting. Enables cost center inheritance on shipments using contracted rates.',
    `driver_safety_program_id` BIGINT COMMENT 'Foreign key linking to safety.driver_safety_program. Business justification: Carrier rate agreements specify required driver safety program participation (telematics monitoring, safety training, incident thresholds). Links rate agreement to program for compliance verification ',
    `emissions_factor_id` BIGINT COMMENT 'Foreign key linking to sustainability.emissions_factor. Business justification: Carrier rate agreements must reference the emission factor used for carbon-adjusted pricing, green surcharges, and customer carbon cost allocation. Required for transparent carbon pricing and regulato',
    `position_id` BIGINT COMMENT 'Foreign key linking to workforce.position. Business justification: Carrier rate agreements negotiated by positions (Procurement Manager, Logistics Director) for position-level authority tracking, role-based rate approval workflows. Essential for freight rate negotiat',
    `employee_id` BIGINT COMMENT 'Identifier of the procurement or sourcing manager who negotiated this rate agreement.',
    `procurement_contract_id` BIGINT COMMENT 'Reference to the master procurement contract under which this rate agreement is executed.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Freight rates impact service line profitability; profit center assignment enables landed cost analysis by business segment. Critical for customer profitability analysis and pricing decisions in logist',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to procurement.supplier. Business justification: Rate agreements are negotiated with transport carriers who are registered as suppliers in the supplier master. Linking rate_agreement to supplier enables spend analysis, supplier performance tracking,',
    `transport_document_id` BIGINT COMMENT 'Foreign key linking to document.transport_document. Business justification: Carrier rate agreements specify which transport documents must be issued for contracted lanes/services. Business process: rate agreement compliance audits require linking agreements to issued transpor',
    `accessorial_charges_included` BOOLEAN COMMENT 'Indicates whether accessorial charges (THC, documentation fees, customs clearance, liftgate, inside delivery) are included in the base rate or billed separately.',
    `agreement_name` STRING COMMENT 'Descriptive name of the rate agreement for business reference (e.g., Q1 2024 Asia-Pacific Ocean Freight Rates).',
    `agreement_number` STRING COMMENT 'Externally-known business identifier for this rate agreement, used in procurement and finance communications.',
    `agreement_type` STRING COMMENT 'Classification of the rate agreement structure: spot (one-time), contract (fixed term), framework (umbrella), volume commitment (tiered pricing), or seasonal (time-bound rates).. Valid values are `spot|contract|framework|volume_commitment|seasonal`',
    `approval_date` DATE COMMENT 'Date on which the rate agreement was formally approved and authorized for use.',
    `auto_renewal_flag` BOOLEAN COMMENT 'Indicates whether the rate agreement automatically renews at expiry unless either party provides termination notice.',
    `base_rate` DECIMAL(18,2) COMMENT 'Core transportation rate per unit (per kg, per TEU, per mile, per shipment) before surcharges and adjustments.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this rate agreement record was first created in the data platform.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this rate agreement (e.g., USD, EUR, CNY).. Valid values are `^[A-Z]{3}$`',
    `destination_location_code` STRING COMMENT 'IATA, UN/LOCODE, or internal code identifying the destination point or region for this rate agreement lane.',
    `documentation_fee` DECIMAL(18,2) COMMENT 'Fee charged by the carrier for preparing and processing shipping documentation (AWB, BOL, customs forms).',
    `fuel_surcharge_type` STRING COMMENT 'Method for calculating fuel surcharge: fixed amount, percentage of base rate, index-linked (tied to fuel price index), BAF (Bunker Adjustment Factor for ocean), or CAF (Currency Adjustment Factor).. Valid values are `fixed|percentage|index_linked|baf|caf`',
    `fuel_surcharge_value` DECIMAL(18,2) COMMENT 'Numeric value of the fuel surcharge: fixed amount or percentage, depending on fuel_surcharge_type.',
    `gri_clause` STRING COMMENT 'Contractual terms governing General Rate Increase (GRI) adjustments: frequency, notice period, cap percentage, and approval process.',
    `incoterms` STRING COMMENT 'International Commercial Terms (Incoterms) defining the division of costs and risks between buyer and seller: EXW, FCA, CPT, CIP, DAP, DPU, DDP, FAS, FOB, CFR, CIF. [ENUM-REF-CANDIDATE: EXW|FCA|CPT|CIP|DAP|DPU|DDP|FAS|FOB|CFR|CIF — 11 candidates stripped; promote to reference product]',
    `lane_description` STRING COMMENT 'Human-readable description of the origin-destination lane covered by this rate agreement (e.g., Shanghai to Los Angeles - West Coast Express).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this rate agreement record was last updated in the data platform.',
    `last_rate_review_date` DATE COMMENT 'Date of the most recent rate review or adjustment under this agreement.',
    `maximum_charge` DECIMAL(18,2) COMMENT 'Maximum cap on total charge per shipment or transaction under this rate agreement, if applicable.',
    `minimum_charge` DECIMAL(18,2) COMMENT 'Minimum total charge per shipment or transaction under this rate agreement, regardless of actual weight or volume.',
    `next_rate_review_date` DATE COMMENT 'Scheduled date for the next rate review or renegotiation under this agreement.',
    `notes` STRING COMMENT 'Free-text notes capturing special terms, exceptions, negotiation history, or operational instructions related to this rate agreement.',
    `origin_location_code` STRING COMMENT 'IATA, UN/LOCODE, or internal code identifying the origin point or region for this rate agreement lane.',
    `payment_terms` STRING COMMENT 'Agreed payment terms for invoices under this rate agreement (e.g., Net 30, Net 60, prepaid, COD).',
    `rate_agreement_status` STRING COMMENT 'Current lifecycle state of the rate agreement: draft (under negotiation), pending approval (awaiting sign-off), active (in force), suspended (temporarily paused), expired (validity ended), terminated (cancelled before expiry).. Valid values are `draft|pending_approval|active|suspended|expired|terminated`',
    `rate_review_frequency` STRING COMMENT 'Scheduled frequency for reviewing and potentially adjusting rates under this agreement: monthly, quarterly, semi-annually, annually, or none (fixed for term).. Valid values are `monthly|quarterly|semi_annually|annually|none`',
    `rate_unit_of_measure` STRING COMMENT 'Unit basis for the base rate: per kilogram, per TEU (Twenty-foot Equivalent Unit), per CBM (Cubic Meter), per mile, per kilometer, per shipment, or per pallet. [ENUM-REF-CANDIDATE: per_kg|per_teu|per_cbm|per_mile|per_km|per_shipment|per_pallet — 7 candidates stripped; promote to reference product]',
    `renewal_notice_days` STRING COMMENT 'Number of days advance notice required to terminate or renegotiate the agreement before auto-renewal takes effect.',
    `service_type` STRING COMMENT 'Service level classification: FTL (Full Truckload), LTL (Less Than Truckload), FCL (Full Container Load), LCL (Less Than Container Load), express, standard, or economy. [ENUM-REF-CANDIDATE: FTL|LTL|FCL|LCL|express|standard|economy — 7 candidates stripped; promote to reference product]',
    `source_system` STRING COMMENT 'Operational system of record from which this rate agreement was sourced: SAP TM (carrier procurement), Coupa (procurement management), Oracle TMS, or manual entry.. Valid values are `SAP_TM|Coupa|Oracle_TMS|manual`',
    `source_system_code` STRING COMMENT 'Unique identifier of this rate agreement in the source operational system (SAP TM agreement number, Coupa contract ID).',
    `termination_date` DATE COMMENT 'Actual date on which the rate agreement was terminated or cancelled, if applicable.',
    `termination_reason` STRING COMMENT 'Business reason for early termination of the rate agreement (e.g., carrier performance issues, cost optimization, service discontinuation).',
    `thc_amount` DECIMAL(18,2) COMMENT 'Terminal Handling Charge (THC) per container or shipment at origin or destination terminal, if applicable.',
    `transport_mode` STRING COMMENT 'Primary mode of transport covered by this rate agreement: air, ocean, road, rail, or multimodal (combination).. Valid values are `air|ocean|road|rail|multimodal`',
    `valid_from_date` DATE COMMENT 'Date from which this rate agreement becomes effective and rates can be applied to shipments.',
    `valid_until_date` DATE COMMENT 'Date on which this rate agreement expires. Nullable for open-ended agreements subject to termination notice.',
    `volume_commitment_period` STRING COMMENT 'Time period over which the volume commitment must be met: monthly, quarterly, annually, or over the full contract term.. Valid values are `monthly|quarterly|annually|contract_term`',
    `volume_commitment_quantity` DECIMAL(18,2) COMMENT 'Minimum volume (weight, TEUs, shipments) the buyer commits to ship under this agreement to qualify for the negotiated rates.',
    `volume_commitment_unit` STRING COMMENT 'Unit of measure for the volume commitment: kilograms, TEUs, cubic meters, number of shipments, or pallets.. Valid values are `kg|teu|cbm|shipments|pallets`',
    CONSTRAINT pk_rate_agreement PRIMARY KEY(`rate_agreement_id`)
) COMMENT 'Procurement-side rate agreement negotiated with transport carriers (road hauliers, airlines, ocean carriers, rail operators) covering lane-specific rates, fuel surcharge schedules, accessorial charges, volume commitments, and rate validity periods. Distinct from the customer-facing pricing domain — this is the buy-side cost structure. Captures carrier ID, mode (air/ocean/road/rail), origin-destination lane, base rate, currency, GRI clauses, BAF/CAF surcharge terms, minimum volume commitment, and contract reference. Sourced from SAP TM carrier procurement and Coupa.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`procurement`.`supplier_performance` (
    `supplier_performance_id` BIGINT COMMENT 'Unique identifier for the supplier performance evaluation record. Primary key.',
    `carrier_id` BIGINT COMMENT 'Foreign key linking to network.carrier. Business justification: Carrier performance evaluation (OTD, transit time, claims ratio, damage rate) is distinct from general supplier performance; logistics companies track carrier-specific KPIs for carrier selection, rate',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: Supplier scorecards are often company-code-specific due to regional sourcing teams and localized performance metrics. Enables entity-level supplier risk assessment and spend concentration analysis.',
    `freight_audit_id` BIGINT COMMENT 'Foreign key linking to billing.freight_audit. Business justification: Freight audit findings (billing accuracy, rate compliance, overcharges) are key supplier performance metrics. Direct link enables automated scorecard updates from audit results and tracks invoice accu',
    `hse_incident_id` BIGINT COMMENT 'Foreign key linking to safety.hse_incident. Business justification: Supplier performance evaluations must track HSE incidents caused by supplier (carrier accidents, facility incidents, dangerous goods releases). Links performance record to incident for safety scoring,',
    `org_unit_id` BIGINT COMMENT 'Foreign key linking to workforce.org_unit. Business justification: Supplier performance evaluated by responsible organizational units. Enables divisional supplier scorecards, org-specific vendor management KPIs, regional supplier performance tracking in decentralized',
    `supplier_emissions_disclosure_id` BIGINT COMMENT 'Foreign key linking to sustainability.supplier_emissions_disclosure. Business justification: Supplier scorecards in logistics must link to the carriers latest emissions disclosure for ESG-driven supplier evaluation, CDP scoring integration, and Scope 3 Category 4 (upstream transport) risk as',
    `supplier_id` BIGINT COMMENT 'Reference to the supplier being evaluated in this performance record.',
    `approved_by` STRING COMMENT 'Name of the manager or executive who approved and signed off on this performance evaluation.',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when the performance evaluation was formally approved and published.',
    `corrective_action_count` STRING COMMENT 'Total number of corrective action requests issued to the supplier for performance or quality issues during the evaluation period.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this performance evaluation record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the total order value.. Valid values are `^[A-Z]{3}$`',
    `defect_count` STRING COMMENT 'Total number of quality defects, rejections, or non-conformances identified in goods or services received from the supplier during the evaluation period.',
    `evaluation_cycle_type` STRING COMMENT 'The frequency or type of evaluation cycle (monthly, quarterly, annual, or ad-hoc).. Valid values are `monthly|quarterly|semi-annual|annual|ad-hoc`',
    `evaluation_notes` STRING COMMENT 'Free-text notes and comments from the evaluator providing qualitative context, observations, and recommendations regarding supplier performance.',
    `evaluation_period_end_date` DATE COMMENT 'The end date of the performance evaluation period.',
    `evaluation_period_start_date` DATE COMMENT 'The start date of the performance evaluation period (monthly, quarterly, or annual cycle).',
    `evaluation_status` STRING COMMENT 'Current lifecycle status of the performance evaluation record.. Valid values are `draft|in-review|approved|published|archived`',
    `evaluator_email` STRING COMMENT 'Email address of the evaluator for follow-up and audit trail purposes.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `evaluator_name` STRING COMMENT 'Name of the procurement professional or team responsible for conducting and approving this performance evaluation.',
    `improvement_areas` STRING COMMENT 'Specific areas where the supplier needs to improve performance, documented for supplier development and corrective action planning.',
    `invoice_accuracy_rate` DECIMAL(18,2) COMMENT 'Percentage of invoices submitted by the supplier that matched purchase orders and receipts without discrepancies, requiring no corrections.',
    `invoice_discrepancy_count` STRING COMMENT 'Total number of invoices that contained errors, mismatches, or discrepancies requiring correction during the evaluation period.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this performance evaluation record was last updated or modified.',
    `late_delivery_count` STRING COMMENT 'Total number of deliveries that arrived after the promised delivery date or time window during the evaluation period.',
    `otd_rate` DECIMAL(18,2) COMMENT 'Percentage of deliveries that met the promised delivery date or time window during the evaluation period. Key performance indicator for supplier reliability.',
    `overall_score` DECIMAL(18,2) COMMENT 'Numeric composite score (0-100) representing the weighted average of all performance metrics for the evaluation period.',
    `overall_scorecard_grade` STRING COMMENT 'Composite letter grade summarizing the suppliers overall performance across all evaluation dimensions (OTD, quality, invoice accuracy, SLA compliance, responsiveness, sustainability).. Valid values are `A|B|C|D|F`',
    `preferred_supplier_flag` BOOLEAN COMMENT 'Boolean indicator whether the supplier has been designated as a preferred supplier based on this evaluation, qualifying for priority consideration in sourcing decisions.',
    `published_timestamp` TIMESTAMP COMMENT 'Date and time when the performance evaluation was communicated to the supplier.',
    `published_to_supplier_flag` BOOLEAN COMMENT 'Boolean indicator whether this performance evaluation has been shared with the supplier for transparency and supplier development purposes.',
    `quality_acceptance_rate` DECIMAL(18,2) COMMENT 'Percentage of received goods or services that passed quality inspection without defects or rejections during the evaluation period.',
    `renewal_recommendation` STRING COMMENT 'Recommendation for contract renewal or continuation based on the performance evaluation results.. Valid values are `renew|renew-with-conditions|review|terminate|not-applicable`',
    `responsiveness_score` DECIMAL(18,2) COMMENT 'Score measuring the suppliers timeliness and effectiveness in responding to inquiries, requests for quotation, change orders, and issue resolution.',
    `risk_level` STRING COMMENT 'Risk classification assigned to the supplier based on performance trends, compliance issues, and business impact.. Valid values are `low|medium|high|critical`',
    `sla_compliance_score` DECIMAL(18,2) COMMENT 'Overall score representing the suppliers adherence to contractual service level agreements across all defined metrics during the evaluation period.',
    `source_system` STRING COMMENT 'Name of the source system from which this performance evaluation record originated (e.g., Coupa Supplier Performance Management).',
    `strengths` STRING COMMENT 'Documented strengths and positive performance attributes of the supplier during the evaluation period.',
    `supplier_tier` STRING COMMENT 'Tiering classification assigned to the supplier based on performance results (preferred, approved, conditional, probation, disqualified). Drives sourcing decisions and contract renewals.. Valid values are `preferred|approved|conditional|probation|disqualified`',
    `sustainability_rating` STRING COMMENT 'Letter grade rating the suppliers environmental and social sustainability practices, including carbon footprint, ethical sourcing, and compliance with environmental regulations.. Valid values are `A|B|C|D|F|not-rated`',
    `total_order_value` DECIMAL(18,2) COMMENT 'Total monetary value of all purchase orders issued to the supplier during the evaluation period.',
    `total_purchase_orders` STRING COMMENT 'Total number of purchase orders issued to the supplier during the evaluation period.',
    CONSTRAINT pk_supplier_performance PRIMARY KEY(`supplier_performance_id`)
) COMMENT 'Periodic performance evaluation records for suppliers, capturing on-time delivery rate (OTD), quality acceptance rate, invoice accuracy rate, SLA compliance score, responsiveness score, sustainability rating, and overall scorecard grade. Each record represents a formal evaluation cycle (monthly, quarterly, annual) for a supplier. Drives supplier tiering, preferred supplier designation, and renewal/termination decisions. Sourced from Coupa Supplier Performance Management.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`procurement`.`procurement_contract` (
    `procurement_contract_id` BIGINT COMMENT 'Unique identifier for the procurement contract record. Primary key.',
    `employee_id` BIGINT COMMENT 'Identifier of the person who approved or is responsible for approving this contract.',
    `carbon_offset_program_id` BIGINT COMMENT 'Foreign key linking to sustainability.carbon_offset_program. Business justification: Logistics contracts increasingly include carbon neutrality commitments specifying the offset program (Gold Standard, Verra) for green product delivery. Essential for contractual carbon neutrality fulf',
    `carrier_id` BIGINT COMMENT 'Foreign key linking to network.carrier. Business justification: Formal contracts with carriers for transport services; foundational to logistics procurement. Tracks carrier service agreements, rate cards, SLAs, liability terms, and capacity commitments. Essential ',
    `chart_of_accounts_id` BIGINT COMMENT 'Foreign key linking to finance.chart_of_accounts. Business justification: Contract terms determine GL account assignment rules for automated invoice posting and accrual generation. Freight contracts specify expense account categories for transportation, fuel surcharges, and',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: Contracts bind specific legal entities; company code assignment is mandatory for contract liability tracking, commitment accounting, and SOX controls. Each logistics contract is signed by a defined le',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Master service agreements and blanket orders often allocate to default cost centers for budget control and spend tracking. Enables automated cost center defaulting on POs and invoices.',
    `emissions_factor_id` BIGINT COMMENT 'Foreign key linking to sustainability.emissions_factor. Business justification: Logistics contracts with carriers specify the emission calculation methodology (GLEC Framework, EN 16258) for carbon reporting and green logistics SLA compliance. Essential for contractual carbon acco',
    `owner_employee_id` BIGINT COMMENT 'FK to workforce.employee',
    `position_id` BIGINT COMMENT 'Foreign key linking to workforce.position. Business justification: Contracts owned by positions (not just employees) for succession planning, role-based contract ownership, position-level spend authority tracking. Critical for contract continuity when employees chang',
    `partner_id` BIGINT COMMENT 'Foreign key linking to network.network_partner. Business justification: Contracts with network partners (agents, correspondents, handling partners, customs brokers) for global logistics services; essential for international operations. Tracks service agreements, commissio',
    `procurement_contract_employee_id` BIGINT COMMENT 'Identifier of the internal employee or buyer responsible for managing and administering this contract.',
    `program_id` BIGINT COMMENT 'Foreign key linking to safety.safety_program. Business justification: Procurement contracts with carriers and suppliers mandate participation in specific safety programs (driver safety, facility safety, DG handling). Links contract to program for compliance monitoring a',
    `supplier_id` BIGINT COMMENT 'Identifier of the supplier party with whom this procurement contract is established.',
    `supplier_site_id` BIGINT COMMENT 'Identifier of the specific supplier site or location associated with this contract for delivery or service provision.',
    `tpl_provider_id` BIGINT COMMENT 'Foreign key linking to network.tpl_provider. Business justification: Contracts with 3PLs for warehousing, distribution, fulfillment services; core logistics procurement relationship. Tracks service scope, pricing, SLAs, facility assignments, and performance obligations',
    `trade_agreement_id` BIGINT COMMENT 'Foreign key linking to customs.trade_agreement. Business justification: Procurement contracts reference trade agreements (USMCA, EU FTAs) for preferential duty rates and origin requirements. Sourcing teams structure supplier contracts to leverage FTA benefits, requiring t',
    `approval_date` DATE COMMENT 'Date when the contract was formally approved by the authorized approver.',
    `approval_status` STRING COMMENT 'Current approval status of the contract within the internal approval workflow.. Valid values are `pending|approved|rejected`',
    `auto_renewal_flag` BOOLEAN COMMENT 'Indicates whether the contract automatically renews upon expiry unless terminated by either party.',
    `business_unit` STRING COMMENT 'Business unit or division within the organization that owns or benefits from this procurement contract.',
    `compliance_certifications_required` STRING COMMENT 'List of compliance certifications and standards the supplier must hold or achieve (e.g., ISO 9001, C-TPAT, AEO).',
    `confidentiality_level` STRING COMMENT 'Data classification level indicating the sensitivity and confidentiality of the contract information.. Valid values are `public|internal|confidential|restricted`',
    `contract_number` STRING COMMENT 'Externally-known unique business identifier for the procurement contract, used for reference in communications and documentation.',
    `contract_status` STRING COMMENT 'Current lifecycle status of the procurement contract indicating its operational state. [ENUM-REF-CANDIDATE: draft|pending_approval|active|suspended|expired|terminated|renewed — 7 candidates stripped; promote to reference product]',
    `contract_type` STRING COMMENT 'Classification of the procurement contract indicating the nature of the agreement (e.g., master supply agreement, service level agreement, carrier contract, maintenance contract).. Valid values are `master_supply_agreement|service_level_agreement|carrier_contract|maintenance_contract|spot_purchase|framework_agreement`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the procurement contract record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the contract value and financial terms.. Valid values are `^[A-Z]{3}$`',
    `delivery_terms` STRING COMMENT 'Specific delivery terms and conditions agreed upon in the contract, including lead times and delivery locations.',
    `dispute_resolution_method` STRING COMMENT 'Agreed method for resolving disputes arising from the contract (e.g., arbitration, mediation, litigation).. Valid values are `litigation|arbitration|mediation|negotiation`',
    `effective_date` DATE COMMENT 'Date when the procurement contract becomes legally binding and operational.',
    `expiry_date` DATE COMMENT 'Date when the procurement contract ends or expires. Nullable for open-ended contracts.',
    `governing_law` STRING COMMENT 'Legal jurisdiction and governing law under which the contract is executed and disputes are resolved.',
    `incoterm` STRING COMMENT 'International Commercial Terms defining the responsibilities of buyer and supplier for delivery, risk, and cost allocation. [ENUM-REF-CANDIDATE: EXW|FCA|CPT|CIP|DAP|DPU|DDP|FAS|FOB|CFR|CIF — 11 candidates stripped; promote to reference product]',
    `insurance_requirements` STRING COMMENT 'Insurance coverage requirements that the supplier must maintain as a condition of the contract.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the procurement contract record was last updated or modified.',
    `lead_time_days` STRING COMMENT 'Standard lead time in days from order placement to delivery as specified in the contract.',
    `maximum_order_value` DECIMAL(18,2) COMMENT 'Maximum monetary value allowed for a single purchase order under this contract.',
    `minimum_order_value` DECIMAL(18,2) COMMENT 'Minimum monetary value required for each purchase order under this contract.',
    `notes` STRING COMMENT 'Additional notes, comments, or special instructions related to the procurement contract.',
    `payment_method` STRING COMMENT 'Method by which payments will be made to the supplier under this contract.. Valid values are `bank_transfer|check|credit_card|ach|wire_transfer|letter_of_credit`',
    `payment_terms` STRING COMMENT 'Agreed payment terms specifying when and how payments are to be made (e.g., Net 30, Net 60, advance payment, milestone-based).',
    `penalty_clause` STRING COMMENT 'Description of penalties or liquidated damages applicable for non-compliance, late delivery, or breach of contract terms.',
    `procurement_contract_category` STRING COMMENT 'High-level procurement category or commodity group to which this contract belongs (e.g., transportation services, IT equipment, facilities maintenance).',
    `renewal_notice_period_days` STRING COMMENT 'Number of days advance notice required to prevent automatic renewal or to initiate renewal negotiations.',
    `signed_date` DATE COMMENT 'Date when the contract was signed by both parties, making it legally binding.',
    `sla_target_delivery_days` STRING COMMENT 'Target number of days for delivery as defined in the service level agreement within the contract.',
    `sla_uptime_percentage` DECIMAL(18,2) COMMENT 'Guaranteed uptime or availability percentage for services provided under this contract.',
    `subcategory` STRING COMMENT 'Detailed subcategory within the procurement category for more granular classification.',
    `termination_clause` STRING COMMENT 'Detailed terms and conditions under which the contract may be terminated by either party.',
    `termination_notice_period_days` STRING COMMENT 'Number of days advance notice required by either party to terminate the contract.',
    `title` STRING COMMENT 'Descriptive title or name of the procurement contract summarizing its purpose.',
    `total_contract_value` DECIMAL(18,2) COMMENT 'Total monetary value of the procurement contract over its entire term, representing the maximum committed spend.',
    `warranty_terms` STRING COMMENT 'Warranty provisions and guarantees provided by the supplier for goods or services under this contract.',
    CONSTRAINT pk_procurement_contract PRIMARY KEY(`procurement_contract_id`)
) COMMENT 'Procurement-side contracts with suppliers governing the terms of supply — master supply agreements, service level agreements, carrier contracts, and maintenance contracts. Captures contract number, contract type, supplier, effective date, expiry date, auto-renewal flag, total contract value, currency, key commercial terms, penalty clauses, termination notice period, and contract status (draft, active, expired, terminated). Distinct from the customer-facing contract domain — this is the buy-side agreement SSOT within procurement. Sourced from Coupa Contract Management.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`procurement`.`procurement_approval_workflow` (
    `procurement_approval_workflow_id` BIGINT COMMENT 'Unique identifier for the procurement approval workflow record. Primary key.',
    `approval_rule_id` BIGINT COMMENT 'Identifier of the approval rule or policy that determined this approval routing (e.g., rule based on amount, category, supplier risk, location).',
    `employee_id` BIGINT COMMENT 'Unique identifier of the employee assigned as approver for this step.',
    `primary_procurement_delegated_to_employee_id` BIGINT COMMENT 'Unique identifier of the employee to whom this approval step was delegated, if applicable.',
    `requester_employee_id` BIGINT COMMENT 'Unique identifier of the employee who initiated or requested the document being approved.',
    `approval_session_id` BIGINT COMMENT 'System session identifier for the approval transaction, used for audit trail and troubleshooting.',
    `supplier_id` BIGINT COMMENT 'Unique identifier of the supplier associated with the document being approved (for POs, invoices, contracts).',
    `action_timestamp` TIMESTAMP COMMENT 'Date and time when the approver took action on this approval step (approved, rejected, delegated, etc.). Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `approval_action` STRING COMMENT 'Action taken by the approver at this step (approved, rejected, delegated to another approver, escalated to higher authority, pending decision, recalled by submitter, cancelled). [ENUM-REF-CANDIDATE: approved|rejected|delegated|escalated|pending|recalled|cancelled — 7 candidates stripped; promote to reference product]',
    `approval_comments` STRING COMMENT 'Free-text comments or notes provided by the approver explaining their decision, conditions, or concerns.',
    `approval_level` STRING COMMENT 'Hierarchical level or functional role required for this approval step (manager, director, VP, CFO, procurement head, legal, compliance). [ENUM-REF-CANDIDATE: manager|director|vp|svp|cfo|ceo|procurement_head|legal|compliance — 9 candidates stripped; promote to reference product]',
    `approval_method` STRING COMMENT 'Method or channel through which the approval action was submitted (web portal, email, mobile app, API integration, system auto-approval).. Valid values are `web_portal|email|mobile_app|api|system_auto`',
    `approval_rule_name` STRING COMMENT 'Name or description of the approval rule that triggered this workflow step.',
    `approval_status` STRING COMMENT 'Current status of this approval step in the workflow lifecycle. [ENUM-REF-CANDIDATE: pending|approved|rejected|delegated|escalated|expired|cancelled — 7 candidates stripped; promote to reference product]',
    `approval_step_sequence` STRING COMMENT 'Sequential order of this approval step in the overall approval routing chain (1 = first approver, 2 = second approver, etc.).',
    `approval_threshold_amount` DECIMAL(18,2) COMMENT 'Monetary threshold amount that triggered this approval level (e.g., manager approves up to $10,000, director approves $10,001-$50,000).',
    `approval_threshold_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the approval threshold amount.. Valid values are `^[A-Z]{3}$`',
    `approver_email` STRING COMMENT 'Email address of the approver for notification and audit trail purposes.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `approver_name` STRING COMMENT 'Full name of the employee who is the approver for this step.',
    `approver_role` STRING COMMENT 'Business role or job title of the approver assigned to this step (e.g., Procurement Manager, Finance Director, Legal Counsel).',
    `assigned_timestamp` TIMESTAMP COMMENT 'Date and time when this approval step was assigned to the approver. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `business_unit_code` STRING COMMENT 'Code of the business unit or division that owns the document being approved.',
    `cost_center_code` STRING COMMENT 'Cost center code associated with the document being approved, for budget control and financial reporting.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this approval workflow record was created in the system. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `delegated_to_name` STRING COMMENT 'Full name of the employee to whom approval was delegated.',
    `delegation_reason` STRING COMMENT 'Reason provided for delegating the approval to another employee (e.g., out of office, conflict of interest, workload).',
    `document_amount` DECIMAL(18,2) COMMENT 'Total monetary value of the document being approved (e.g., PO total, invoice amount, contract value).',
    `document_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the document amount.. Valid values are `^[A-Z]{3}$`',
    `document_reference_code` STRING COMMENT 'Reference identifier of the procurement document being approved (e.g., PO number, requisition number, invoice number, contract ID).',
    `document_reference_number` STRING COMMENT 'Human-readable business number of the document being approved (e.g., PO-2024-00123, REQ-45678).',
    `document_type` STRING COMMENT 'Type of procurement document being routed for approval (requisition, purchase order, invoice, contract, sourcing event). [ENUM-REF-CANDIDATE: requisition|purchase_order|invoice|contract|rfq|rfp|change_order — 7 candidates stripped; promote to reference product]',
    `due_date` DATE COMMENT 'Target date by which the approver should complete this approval step. Format: yyyy-MM-dd.',
    `escalated_to_name` STRING COMMENT 'Full name of the higher-authority employee to whom approval was escalated.',
    `escalation_reason` STRING COMMENT 'Reason for escalating the approval to a higher authority (e.g., exceeds approval limit, policy exception required, risk concern).',
    `ip_address` STRING COMMENT 'IP address from which the approval action was submitted, for audit and security purposes.',
    `is_mandatory_approval` BOOLEAN COMMENT 'Indicates whether this approval step is mandatory (true) or optional/advisory (false).',
    `is_parallel_approval` BOOLEAN COMMENT 'Indicates whether this approval step runs in parallel with other steps (true) or sequentially (false).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this approval workflow record was last updated. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `last_reminder_timestamp` TIMESTAMP COMMENT 'Date and time when the most recent reminder notification was sent to the approver. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `notification_sent_timestamp` TIMESTAMP COMMENT 'Date and time when the approval notification was sent to the approver. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `procurement_category` STRING COMMENT 'Procurement category or commodity classification of the document being approved (e.g., fleet services, warehouse equipment, IT hardware, professional services).',
    `rejection_reason` STRING COMMENT 'Reason code or explanation provided when the approver rejects the document (e.g., budget exceeded, incorrect supplier, missing documentation).',
    `reminder_count` STRING COMMENT 'Number of reminder notifications sent to the approver for this pending approval step.',
    CONSTRAINT pk_procurement_approval_workflow PRIMARY KEY(`procurement_approval_workflow_id`)
) COMMENT 'Records the approval routing and decision history for procurement documents (requisitions, POs, invoices, contracts, sourcing events). Captures document type, document reference ID, approval step sequence, approver role, approver employee ID, approval action (approved, rejected, delegated, escalated), action timestamp, comments, and delegation chain. Provides a complete audit trail for SOX compliance and procurement governance. Sourced from Coupa Approval Workflow engine.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`procurement`.`carbon_offset_procurement_agreement` (
    `carbon_offset_procurement_agreement_id` BIGINT COMMENT 'Unique identifier for the carbon offset procurement agreement. Primary key.',
    `carbon_offset_program_id` BIGINT COMMENT 'Foreign key to sustainability.carbon_offset_program.carbon_offset_program_id',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to the supplier providing carbon offset credits',
    `agreement_status` STRING COMMENT 'The current lifecycle status of this procurement agreement. Draft: under negotiation; Active: in force; Suspended: temporarily paused; Expired: contract term ended; Terminated: cancelled before expiration.',
    `committed_volume_tco2e` DECIMAL(18,2) COMMENT 'The total quantity of carbon offset credits (in tonnes CO2e) that Transport Shipping has committed to purchase from this supplier for this specific program under the terms of this agreement. Represents the volume commitment negotiated in the contract.',
    `contract_end_date` DATE COMMENT 'The date when the procurement agreement for this supplier-program combination expires or terminates. Defines the end of the contractual relationship for purchasing carbon offset credits from this specific supplier for this specific program.',
    `contract_start_date` DATE COMMENT 'The date when the procurement agreement for this supplier-program combination becomes effective. Defines the beginning of the contractual relationship for purchasing carbon offset credits from this specific supplier for this specific program.',
    `created_date` TIMESTAMP COMMENT 'Timestamp when this procurement agreement record was created in the system.',
    `currency_code` STRING COMMENT 'The ISO 4217 three-letter currency code for the unit price in this procurement agreement (e.g., USD, EUR, GBP).',
    `delivery_schedule` STRING COMMENT 'The agreed-upon schedule for delivery or transfer of carbon offset credits from the supplier to Transport Shipping for this program. May specify quarterly tranches, annual delivery, or event-triggered delivery terms.',
    `last_modified_date` TIMESTAMP COMMENT 'Timestamp when this procurement agreement record was last modified.',
    `lead_time_days` STRING COMMENT 'The number of days required from order placement to delivery/transfer of carbon offset credits from this supplier for this program. Represents the procurement lead time specific to this supplier-program combination.',
    `minimum_order_quantity_tco2e` DECIMAL(18,2) COMMENT 'The minimum quantity of carbon offset credits (in tonnes CO2e) that must be purchased in a single order or tranche from this supplier for this program. Represents supplier-imposed or negotiated minimum purchase requirements.',
    `payment_terms` STRING COMMENT 'The payment terms negotiated with this supplier for this program, expressed in days or terms (e.g., Net 30, Net 60, Payment on Delivery). May differ from the suppliers standard payment terms based on program-specific negotiations.',
    `procurement_contact_email` STRING COMMENT 'The email address of the primary contact at the supplier organization responsible for this specific carbon offset program procurement relationship.',
    `procurement_contact_name` STRING COMMENT 'The name of the primary contact at the supplier organization responsible for this specific carbon offset program procurement relationship.',
    `procurement_method` STRING COMMENT 'The method by which Transport Shipping procures carbon offset credits from this program (e.g., Direct Purchase, Broker, Exchange, Auction, Forward Contract). [Moved from carbon_offset_program: This attribute currently exists in carbon_offset_program but represents how Transport Shipping procures credits from a specific supplier for this program. Since procurement methods may vary by supplier (direct purchase from one, broker arrangement with another), this attribute belongs to the supplier-program association, not the program itself.]. Valid values are `Direct Purchase|Broker|Exchange|Auction|Forward Contract`',
    `quality_standard` STRING COMMENT 'The quality or verification standard that the supplier must meet for carbon offset credits delivered under this agreement. May specify minimum certification requirements, additionality verification, permanence guarantees, or co-benefit requirements specific to this supplier-program relationship.',
    `unit_price` DECIMAL(18,2) COMMENT 'The negotiated purchase price per metric tonne of CO2e offset credit for this specific supplier-program combination. This price may differ from the programs base price due to volume discounts, contract terms, or supplier-specific negotiations.',
    `vintage_year_preference` STRING COMMENT 'The preferred vintage year or vintage year range for carbon offset credits to be delivered under this agreement. Transport Shipping may negotiate specific vintage preferences with each supplier for each program based on regulatory requirements, pricing, or strategic priorities.',
    CONSTRAINT pk_carbon_offset_procurement_agreement PRIMARY KEY(`carbon_offset_procurement_agreement_id`)
) COMMENT 'This association product represents the contractual procurement relationship between a supplier and a carbon offset program. It captures the commercial terms, pricing, volume commitments, delivery schedules, and quality standards negotiated for each supplier-program combination. Each record links one supplier to one carbon offset program with attributes that exist only in the context of this procurement relationship.. Existence Justification: In the logistics industry, Transport Shipping procures carbon offset credits from multiple suppliers (brokers, project developers, offset aggregators), and each supplier can offer multiple carbon offset programs with different project types, vintages, and geographies. The procurement relationship is a managed business entity with specific contract terms, negotiated pricing, volume commitments, delivery schedules, and quality standards that vary by supplier-program combination. Business stakeholders actively manage these procurement agreements as distinct contracts.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`procurement`.`contracted_service` (
    `contracted_service_id` BIGINT COMMENT 'Unique identifier for this contracted service relationship. Primary key.',
    `carrier_service_id` BIGINT COMMENT 'Foreign key linking to the specific carrier service product covered by this contract',
    `procurement_contract_id` BIGINT COMMENT 'Foreign key linking to the procurement contract that governs this service relationship',
    `allocation_priority` STRING COMMENT 'The priority ranking for allocating shipments to this contracted service when multiple contracted services are available for a lane (1=highest priority).',
    `contract_status` STRING COMMENT 'The current operational status of this contracted service relationship (active, suspended, expired, terminated).',
    `contracted_rate` DECIMAL(18,2) COMMENT 'The negotiated rate for this specific carrier service under this procurement contract. Rate structure varies by service (per kg, per shipment, per container).',
    `effective_date` DATE COMMENT 'The date from which this service-specific contract term becomes active. May differ from the master contract effective date if services are added mid-term.',
    `expiry_date` DATE COMMENT 'The date on which this service-specific contract term expires. May differ from the master contract expiry if services are removed or renegotiated.',
    `fuel_surcharge_applicable` BOOLEAN COMMENT 'Indicates whether fuel surcharges apply to this contracted service or if rates are all-inclusive.',
    `fuel_surcharge_formula` STRING COMMENT 'The formula or reference index used to calculate fuel surcharges for this service (e.g., DOE index, carrier-specific table).',
    `minimum_charge` DECIMAL(18,2) COMMENT 'The minimum charge per shipment for this contracted service, regardless of weight or volume.',
    `notes` STRING COMMENT 'Free-text notes capturing service-specific terms, exceptions, or operational considerations for this contracted service.',
    `peak_season_surcharge_applicable` BOOLEAN COMMENT 'Indicates whether peak season surcharges apply to this contracted service.',
    `rate_unit` STRING COMMENT 'The unit of measure for the contracted rate (per kg, per shipment, per container, per pallet, per CBM).',
    `service_level_target` STRING COMMENT 'The specific SLA target negotiated for this service (e.g., 99.5% on-time delivery, 48-hour transit time guarantee).',
    `volume_commitment` DECIMAL(18,2) COMMENT 'The minimum volume commitment for this service under the contract, used to secure preferential rates. Unit depends on service type (kg, shipments, TEUs).',
    `volume_commitment_period` STRING COMMENT 'The time period over which the volume commitment is measured (monthly, quarterly, annually).',
    `volume_commitment_unit` STRING COMMENT 'The unit of measure for the volume commitment (kg, shipments, TEUs, CBM, pallets).',
    CONSTRAINT pk_contracted_service PRIMARY KEY(`contracted_service_id`)
) COMMENT 'This association product represents the Contract between procurement_contract and carrier_service. It captures the service-specific commercial terms negotiated within a procurement contract for each carrier service. Each record links one procurement contract to one carrier service with pricing, volume commitments, SLAs, and allocation rules that exist only in the context of this contractual relationship.. Existence Justification: In logistics procurement, a single master procurement contract with a carrier typically covers multiple distinct service products (express, standard, economy services across different lanes and modes). Conversely, a specific carrier service (e.g., DHL Express EU-to-US) can be contracted by multiple shippers under separate procurement agreements. The business actively manages service-specific rates, volume commitments, SLAs, and allocation priorities that vary by contract-service combination.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`procurement`.`contract_sustainability_contribution` (
    `contract_sustainability_contribution_id` BIGINT COMMENT 'Unique identifier for this contract-target contribution relationship. Primary key.',
    `procurement_contract_id` BIGINT COMMENT 'Foreign key linking to the procurement contract that contributes to the sustainability target',
    `target_id` BIGINT COMMENT 'Foreign key linking to the sustainability target being supported by the procurement contract',
    `baseline_year` STRING COMMENT 'The baseline year against which this contracts contribution is measured, may differ from the corporate target baseline if the contract was established later.',
    `contribution_end_date` DATE COMMENT 'Date when this contracts contribution toward the sustainability target ends, typically aligned with contract expiry but may differ if sustainability commitments have different terms.',
    `contribution_start_date` DATE COMMENT 'Date when this contract began contributing toward the sustainability target, typically aligned with contract effective date but may differ if sustainability terms were added later.',
    `contribution_status` STRING COMMENT 'Current performance status of this contracts contribution toward the sustainability target (on_track, at_risk, off_track, achieved, not_started).',
    `last_reported_date` DATE COMMENT 'Date when the most recent sustainability performance data was reported for this contract-target contribution.',
    `last_reported_value` DECIMAL(18,2) COMMENT 'The most recent reported value for this contracts contribution in the targets unit of measure (e.g., actual tCO2e reduced, actual renewable energy percentage achieved).',
    `notes` STRING COMMENT 'Free-text notes capturing additional context, assumptions, calculation methodology, or special circumstances related to this contracts sustainability contribution.',
    `penalty_clause` STRING COMMENT 'Description of penalties or financial consequences if the contract fails to deliver the committed sustainability contribution (e.g., liquidated damages for missing renewable energy percentage, rebates for exceeding emissions thresholds).',
    `reduction_commitment_tco2e` DECIMAL(18,2) COMMENT 'The absolute emissions reduction commitment in tonnes of CO2 equivalent that this contract is expected to deliver toward the target (e.g., 50000.0000 tCO2e reduction from switching to electric fleet).',
    `reporting_frequency` STRING COMMENT 'How frequently the supplier or contract owner must report progress on sustainability metrics to track contribution toward the target (monthly, quarterly, semi-annual, annual).',
    `sustainability_requirements` STRING COMMENT 'Environmental and sustainability standards or commitments required from the supplier under this contract. [Moved from procurement_contract: This attribute in procurement_contract is a generic text field describing sustainability requirements. When a contract contributes to specific targets, the quantified commitments (reduction_commitment_tco2e, target_contribution_percentage) belong in the association, not as generic text in the contract. The association provides structured, measurable tracking of sustainability contributions.]',
    `target_contribution_percentage` DECIMAL(18,2) COMMENT 'The percentage of the sustainability target that this specific procurement contract is expected to contribute toward achieving (e.g., 12.50 means this contract accounts for 12.5% of the target reduction).',
    `verification_method` STRING COMMENT 'The method used to verify and validate the sustainability contribution from this contract (third_party_audit, supplier_self_report, internal_measurement, iot_sensor, fuel_receipts, utility_bills).',
    CONSTRAINT pk_contract_sustainability_contribution PRIMARY KEY(`contract_sustainability_contribution_id`)
) COMMENT 'This association product represents the contribution relationship between procurement contracts and corporate sustainability targets. It captures how specific procurement agreements (carrier contracts, fuel supply agreements, fleet leasing) contribute to achieving sustainability commitments (emissions reduction, renewable energy adoption, net-zero pledges). Each record links one procurement contract to one sustainability target with quantified contribution metrics, reduction commitments, and performance tracking attributes that exist only in the context of this relationship.. Existence Justification: In logistics operations, procurement contracts (carrier agreements, fuel supply contracts, fleet leasing) are strategically designed to contribute to multiple corporate sustainability targets simultaneously. A single electric vehicle fleet contract contributes to Scope 1 emissions reduction, renewable energy percentage targets, and potentially Scope 3 Category 4 (upstream transportation) targets. Conversely, achieving a single sustainability target like 50% emissions reduction by 2030 requires contributions from multiple contracts across fuel procurement, carrier selection, warehouse energy, and fleet electrification. The business actively manages these contribution relationships with quantified commitments, performance tracking, and penalty clauses.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`procurement`.`item` (
    `item_id` BIGINT COMMENT 'Primary key for item',
    `parent_item_id` BIGINT COMMENT 'Self-referencing FK on item (parent_item_id)',
    CONSTRAINT pk_item PRIMARY KEY(`item_id`)
) COMMENT 'Master reference table for item. Referenced by item_id.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`procurement`.`approval_rule` (
    `approval_rule_id` BIGINT COMMENT 'Primary key for approval_rule',
    `template_id` BIGINT COMMENT 'Identifier of the notification template used for approvals.',
    `parent_approval_rule_id` BIGINT COMMENT 'Self-referencing FK on approval_rule (parent_approval_rule_id)',
    `approval_level` STRING COMMENT 'Number of approval levels required for the rule.',
    `approval_method` STRING COMMENT 'Method by which approvals are processed.',
    `approval_notification_method` STRING COMMENT 'Channel used to notify approvers of pending approvals.',
    `approval_role` STRING COMMENT 'Role or position responsible for approving under this rule.',
    `approval_rule_notes` STRING COMMENT 'Additional notes or comments about the approval rule.',
    `approval_threshold_amount` DECIMAL(18,2) COMMENT 'Monetary threshold that triggers the approval rule.',
    `approval_threshold_currency` STRING COMMENT 'ISO 4217 currency code for the approval threshold amount.',
    `approval_timeout_action` STRING COMMENT 'Action taken when an approval request times out.',
    `approval_timeout_days` STRING COMMENT 'Number of days before an approval request times out.',
    `created_at` TIMESTAMP COMMENT 'Timestamp when the approval rule record was first created.',
    `effective_from` DATE COMMENT 'Date when the approval rule becomes active.',
    `effective_until` DATE COMMENT 'Date when the approval rule expires or is no longer active.',
    `lifecycle_status` STRING COMMENT 'Current lifecycle state of the approval rule.',
    `rule_code` STRING COMMENT 'Alphanumeric code used to reference the approval rule in systems.',
    `rule_description` STRING COMMENT 'Detailed description of the rule’s purpose and logic.',
    `rule_expression` STRING COMMENT 'Logical expression or script that defines the approval criteria.',
    `rule_name` STRING COMMENT 'Human-readable name of the approval rule.',
    `rule_priority` STRING COMMENT 'Numeric priority used to order rules when multiple rules apply.',
    `rule_type` STRING COMMENT 'Category of the approval rule, e.g., policy, workflow, threshold, or custom.',
    `rule_version` STRING COMMENT 'Version number of the approval rule for change tracking.',
    `rule_version_created_at` TIMESTAMP COMMENT 'Timestamp when the approval rule version was created.',
    `rule_version_created_by` STRING COMMENT 'Identifier of the user or system that created the rule version.',
    `rule_version_description` STRING COMMENT 'Description of the changes in this rule version.',
    `rule_version_effective_from` DATE COMMENT 'Date when the rule version becomes effective.',
    `rule_version_effective_until` DATE COMMENT 'Date when the rule version expires or is no longer effective.',
    `rule_version_status` STRING COMMENT 'Lifecycle status of the rule version.',
    `updated_at` TIMESTAMP COMMENT 'Timestamp of the most recent update to the approval rule.',
    `updated_by` STRING COMMENT 'Identifier of the user or system that performed the last update.',
    `created_by` STRING COMMENT 'Identifier of the user or system that created the approval rule.',
    CONSTRAINT pk_approval_rule PRIMARY KEY(`approval_rule_id`)
) COMMENT 'Master reference table for approval_rule. Referenced by approval_rule_id.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`procurement`.`approval_session` (
    `approval_session_id` BIGINT COMMENT 'Primary key for approval_session',
    `trade_document_id` BIGINT COMMENT 'Identifier of the primary document associated with the approval session.',
    `employee_id` BIGINT COMMENT 'Identifier of the user who initiated the approval session.',
    `reopened_approval_session_id` BIGINT COMMENT 'Self-referencing FK on approval_session (reopened_approval_session_id)',
    `approval_amount` DECIMAL(18,2) COMMENT 'Total gross monetary value associated with the approval session.',
    `approval_approved_count` STRING COMMENT 'Number of approvals that have been approved.',
    `approval_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the approval amounts.',
    `approval_document_checksum` STRING COMMENT 'Checksum value for the approval document to verify integrity.',
    `approval_document_created_at` TIMESTAMP COMMENT 'Timestamp when the approval document was created.',
    `approval_document_hash` STRING COMMENT 'Cryptographic hash of the approval document.',
    `approval_document_mime_type` STRING COMMENT 'MIME type of the approval document.',
    `approval_document_name` STRING COMMENT 'Human-readable name of the approval document.',
    `approval_document_size` BIGINT COMMENT 'Size of the approval document in bytes.',
    `approval_document_status` STRING COMMENT 'Current status of the approval document.',
    `approval_document_type` STRING COMMENT 'File format of the approval document.',
    `approval_document_updated_at` TIMESTAMP COMMENT 'Timestamp of the most recent update to the approval document.',
    `approval_document_url` STRING COMMENT 'URL to access the approval document.',
    `approval_failed_count` STRING COMMENT 'Number of approvals that have failed.',
    `approval_last_action` STRING COMMENT 'Most recent action taken in the approval session.',
    `approval_last_action_at` TIMESTAMP COMMENT 'Timestamp of the most recent action in the approval session.',
    `approval_last_action_by` BIGINT COMMENT 'Identifier of the user who performed the last action in the approval session.',
    `approval_net_amount` DECIMAL(18,2) COMMENT 'Net monetary value after tax and other adjustments.',
    `approval_passed_count` STRING COMMENT 'Number of approvals that have passed.',
    `approval_pending_count` STRING COMMENT 'Number of approvals that are pending.',
    `approval_rejected_count` STRING COMMENT 'Number of approvals that have been rejected.',
    `approval_required_count` STRING COMMENT 'Number of approvals required to complete the session.',
    `approval_session_description` STRING COMMENT 'Narrative description of the approval session.',
    `approval_session_level` STRING COMMENT 'Operational level or tier of the approval session.',
    `approval_session_notes` STRING COMMENT 'Additional notes or comments related to the approval session.',
    `approval_session_priority` STRING COMMENT 'Priority level assigned to the approval session.',
    `approval_session_reason` STRING COMMENT 'Reason or justification for initiating the approval session.',
    `approval_status` STRING COMMENT 'Current lifecycle state of the approval session.',
    `approval_tax_amount` DECIMAL(18,2) COMMENT 'Tax component of the approval amount.',
    `approval_type` STRING COMMENT 'Category of the approval session, e.g., purchase order, contract, carrier, or asset procurement.',
    `created_at` TIMESTAMP COMMENT 'Timestamp when the approval session record was first created in the system.',
    `initiator_user_country` STRING COMMENT 'Country of residence or operation for the user who initiated the approval session.',
    `initiator_user_department` STRING COMMENT 'Department or business unit of the user who initiated the approval session.',
    `initiator_user_email` STRING COMMENT 'Primary email address of the user who initiated the approval session.',
    `initiator_user_name` STRING COMMENT 'Full legal name of the user who initiated the approval session.',
    `initiator_user_phone` STRING COMMENT 'Primary phone number of the user who initiated the approval session.',
    `initiator_user_role` STRING COMMENT 'Role or job title of the user who initiated the approval session.',
    `session_end_timestamp` TIMESTAMP COMMENT 'Timestamp when the approval session concluded or was terminated.',
    `session_start_timestamp` TIMESTAMP COMMENT 'Timestamp when the approval session became active.',
    `updated_at` TIMESTAMP COMMENT 'Timestamp of the most recent update to the approval session record.',
    CONSTRAINT pk_approval_session PRIMARY KEY(`approval_session_id`)
) COMMENT 'Master reference table for approval_session. Referenced by session_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_site` ADD CONSTRAINT `fk_procurement_supplier_site_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `transport_shipping_ecm`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_qualification` ADD CONSTRAINT `fk_procurement_supplier_qualification_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `transport_shipping_ecm`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `transport_shipping_ecm`.`procurement`.`rfq` ADD CONSTRAINT `fk_procurement_rfq_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `transport_shipping_ecm`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `transport_shipping_ecm`.`procurement`.`rfq` ADD CONSTRAINT `fk_procurement_rfq_procurement_contract_id` FOREIGN KEY (`procurement_contract_id`) REFERENCES `transport_shipping_ecm`.`procurement`.`procurement_contract`(`procurement_contract_id`);
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_quote` ADD CONSTRAINT `fk_procurement_supplier_quote_rfq_id` FOREIGN KEY (`rfq_id`) REFERENCES `transport_shipping_ecm`.`procurement`.`rfq`(`rfq_id`);
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_quote` ADD CONSTRAINT `fk_procurement_supplier_quote_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `transport_shipping_ecm`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_quote` ADD CONSTRAINT `fk_procurement_supplier_quote_supplier_site_id` FOREIGN KEY (`supplier_site_id`) REFERENCES `transport_shipping_ecm`.`procurement`.`supplier_site`(`supplier_site_id`);
ALTER TABLE `transport_shipping_ecm`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_blanket_order_id` FOREIGN KEY (`blanket_order_id`) REFERENCES `transport_shipping_ecm`.`procurement`.`blanket_order`(`blanket_order_id`);
ALTER TABLE `transport_shipping_ecm`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_procurement_contract_id` FOREIGN KEY (`procurement_contract_id`) REFERENCES `transport_shipping_ecm`.`procurement`.`procurement_contract`(`procurement_contract_id`);
ALTER TABLE `transport_shipping_ecm`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `transport_shipping_ecm`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `transport_shipping_ecm`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_supplier_site_id` FOREIGN KEY (`supplier_site_id`) REFERENCES `transport_shipping_ecm`.`procurement`.`supplier_site`(`supplier_site_id`);
ALTER TABLE `transport_shipping_ecm`.`procurement`.`po_line` ADD CONSTRAINT `fk_procurement_po_line_blanket_order_id` FOREIGN KEY (`blanket_order_id`) REFERENCES `transport_shipping_ecm`.`procurement`.`blanket_order`(`blanket_order_id`);
ALTER TABLE `transport_shipping_ecm`.`procurement`.`po_line` ADD CONSTRAINT `fk_procurement_po_line_item_id` FOREIGN KEY (`item_id`) REFERENCES `transport_shipping_ecm`.`procurement`.`item`(`item_id`);
ALTER TABLE `transport_shipping_ecm`.`procurement`.`po_line` ADD CONSTRAINT `fk_procurement_po_line_procurement_contract_id` FOREIGN KEY (`procurement_contract_id`) REFERENCES `transport_shipping_ecm`.`procurement`.`procurement_contract`(`procurement_contract_id`);
ALTER TABLE `transport_shipping_ecm`.`procurement`.`po_line` ADD CONSTRAINT `fk_procurement_po_line_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `transport_shipping_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `transport_shipping_ecm`.`procurement`.`po_line` ADD CONSTRAINT `fk_procurement_po_line_purchase_requisition_id` FOREIGN KEY (`purchase_requisition_id`) REFERENCES `transport_shipping_ecm`.`procurement`.`purchase_requisition`(`purchase_requisition_id`);
ALTER TABLE `transport_shipping_ecm`.`procurement`.`po_line` ADD CONSTRAINT `fk_procurement_po_line_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `transport_shipping_ecm`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `transport_shipping_ecm`.`procurement`.`goods_receipt` ADD CONSTRAINT `fk_procurement_goods_receipt_po_line_id` FOREIGN KEY (`po_line_id`) REFERENCES `transport_shipping_ecm`.`procurement`.`po_line`(`po_line_id`);
ALTER TABLE `transport_shipping_ecm`.`procurement`.`goods_receipt` ADD CONSTRAINT `fk_procurement_goods_receipt_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `transport_shipping_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `transport_shipping_ecm`.`procurement`.`goods_receipt` ADD CONSTRAINT `fk_procurement_goods_receipt_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `transport_shipping_ecm`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_invoice` ADD CONSTRAINT `fk_procurement_supplier_invoice_goods_receipt_id` FOREIGN KEY (`goods_receipt_id`) REFERENCES `transport_shipping_ecm`.`procurement`.`goods_receipt`(`goods_receipt_id`);
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_invoice` ADD CONSTRAINT `fk_procurement_supplier_invoice_procurement_contract_id` FOREIGN KEY (`procurement_contract_id`) REFERENCES `transport_shipping_ecm`.`procurement`.`procurement_contract`(`procurement_contract_id`);
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_invoice` ADD CONSTRAINT `fk_procurement_supplier_invoice_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `transport_shipping_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_invoice` ADD CONSTRAINT `fk_procurement_supplier_invoice_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `transport_shipping_ecm`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_invoice` ADD CONSTRAINT `fk_procurement_supplier_invoice_supplier_site_id` FOREIGN KEY (`supplier_site_id`) REFERENCES `transport_shipping_ecm`.`procurement`.`supplier_site`(`supplier_site_id`);
ALTER TABLE `transport_shipping_ecm`.`procurement`.`procurement_invoice_line` ADD CONSTRAINT `fk_procurement_procurement_invoice_line_goods_receipt_id` FOREIGN KEY (`goods_receipt_id`) REFERENCES `transport_shipping_ecm`.`procurement`.`goods_receipt`(`goods_receipt_id`);
ALTER TABLE `transport_shipping_ecm`.`procurement`.`procurement_invoice_line` ADD CONSTRAINT `fk_procurement_procurement_invoice_line_item_id` FOREIGN KEY (`item_id`) REFERENCES `transport_shipping_ecm`.`procurement`.`item`(`item_id`);
ALTER TABLE `transport_shipping_ecm`.`procurement`.`procurement_invoice_line` ADD CONSTRAINT `fk_procurement_procurement_invoice_line_po_line_id` FOREIGN KEY (`po_line_id`) REFERENCES `transport_shipping_ecm`.`procurement`.`po_line`(`po_line_id`);
ALTER TABLE `transport_shipping_ecm`.`procurement`.`procurement_invoice_line` ADD CONSTRAINT `fk_procurement_procurement_invoice_line_supplier_invoice_id` FOREIGN KEY (`supplier_invoice_id`) REFERENCES `transport_shipping_ecm`.`procurement`.`supplier_invoice`(`supplier_invoice_id`);
ALTER TABLE `transport_shipping_ecm`.`procurement`.`purchase_requisition` ADD CONSTRAINT `fk_procurement_purchase_requisition_item_id` FOREIGN KEY (`item_id`) REFERENCES `transport_shipping_ecm`.`procurement`.`item`(`item_id`);
ALTER TABLE `transport_shipping_ecm`.`procurement`.`purchase_requisition` ADD CONSTRAINT `fk_procurement_purchase_requisition_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `transport_shipping_ecm`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `transport_shipping_ecm`.`procurement`.`purchase_requisition` ADD CONSTRAINT `fk_procurement_purchase_requisition_procurement_contract_id` FOREIGN KEY (`procurement_contract_id`) REFERENCES `transport_shipping_ecm`.`procurement`.`procurement_contract`(`procurement_contract_id`);
ALTER TABLE `transport_shipping_ecm`.`procurement`.`purchase_requisition` ADD CONSTRAINT `fk_procurement_purchase_requisition_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `transport_shipping_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `transport_shipping_ecm`.`procurement`.`purchase_requisition` ADD CONSTRAINT `fk_procurement_purchase_requisition_rfq_id` FOREIGN KEY (`rfq_id`) REFERENCES `transport_shipping_ecm`.`procurement`.`rfq`(`rfq_id`);
ALTER TABLE `transport_shipping_ecm`.`procurement`.`blanket_order` ADD CONSTRAINT `fk_procurement_blanket_order_procurement_contract_id` FOREIGN KEY (`procurement_contract_id`) REFERENCES `transport_shipping_ecm`.`procurement`.`procurement_contract`(`procurement_contract_id`);
ALTER TABLE `transport_shipping_ecm`.`procurement`.`blanket_order` ADD CONSTRAINT `fk_procurement_blanket_order_rfq_id` FOREIGN KEY (`rfq_id`) REFERENCES `transport_shipping_ecm`.`procurement`.`rfq`(`rfq_id`);
ALTER TABLE `transport_shipping_ecm`.`procurement`.`blanket_order` ADD CONSTRAINT `fk_procurement_blanket_order_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `transport_shipping_ecm`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `transport_shipping_ecm`.`procurement`.`rate_agreement` ADD CONSTRAINT `fk_procurement_rate_agreement_procurement_contract_id` FOREIGN KEY (`procurement_contract_id`) REFERENCES `transport_shipping_ecm`.`procurement`.`procurement_contract`(`procurement_contract_id`);
ALTER TABLE `transport_shipping_ecm`.`procurement`.`rate_agreement` ADD CONSTRAINT `fk_procurement_rate_agreement_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `transport_shipping_ecm`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_performance` ADD CONSTRAINT `fk_procurement_supplier_performance_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `transport_shipping_ecm`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `transport_shipping_ecm`.`procurement`.`procurement_contract` ADD CONSTRAINT `fk_procurement_procurement_contract_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `transport_shipping_ecm`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `transport_shipping_ecm`.`procurement`.`procurement_contract` ADD CONSTRAINT `fk_procurement_procurement_contract_supplier_site_id` FOREIGN KEY (`supplier_site_id`) REFERENCES `transport_shipping_ecm`.`procurement`.`supplier_site`(`supplier_site_id`);
ALTER TABLE `transport_shipping_ecm`.`procurement`.`procurement_approval_workflow` ADD CONSTRAINT `fk_procurement_procurement_approval_workflow_approval_rule_id` FOREIGN KEY (`approval_rule_id`) REFERENCES `transport_shipping_ecm`.`procurement`.`approval_rule`(`approval_rule_id`);
ALTER TABLE `transport_shipping_ecm`.`procurement`.`procurement_approval_workflow` ADD CONSTRAINT `fk_procurement_procurement_approval_workflow_approval_session_id` FOREIGN KEY (`approval_session_id`) REFERENCES `transport_shipping_ecm`.`procurement`.`approval_session`(`approval_session_id`);
ALTER TABLE `transport_shipping_ecm`.`procurement`.`procurement_approval_workflow` ADD CONSTRAINT `fk_procurement_procurement_approval_workflow_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `transport_shipping_ecm`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `transport_shipping_ecm`.`procurement`.`carbon_offset_procurement_agreement` ADD CONSTRAINT `fk_procurement_carbon_offset_procurement_agreement_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `transport_shipping_ecm`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `transport_shipping_ecm`.`procurement`.`contracted_service` ADD CONSTRAINT `fk_procurement_contracted_service_procurement_contract_id` FOREIGN KEY (`procurement_contract_id`) REFERENCES `transport_shipping_ecm`.`procurement`.`procurement_contract`(`procurement_contract_id`);
ALTER TABLE `transport_shipping_ecm`.`procurement`.`contract_sustainability_contribution` ADD CONSTRAINT `fk_procurement_contract_sustainability_contribution_procurement_contract_id` FOREIGN KEY (`procurement_contract_id`) REFERENCES `transport_shipping_ecm`.`procurement`.`procurement_contract`(`procurement_contract_id`);
ALTER TABLE `transport_shipping_ecm`.`procurement`.`item` ADD CONSTRAINT `fk_procurement_item_parent_item_id` FOREIGN KEY (`parent_item_id`) REFERENCES `transport_shipping_ecm`.`procurement`.`item`(`item_id`);
ALTER TABLE `transport_shipping_ecm`.`procurement`.`approval_rule` ADD CONSTRAINT `fk_procurement_approval_rule_parent_approval_rule_id` FOREIGN KEY (`parent_approval_rule_id`) REFERENCES `transport_shipping_ecm`.`procurement`.`approval_rule`(`approval_rule_id`);
ALTER TABLE `transport_shipping_ecm`.`procurement`.`approval_session` ADD CONSTRAINT `fk_procurement_approval_session_reopened_approval_session_id` FOREIGN KEY (`reopened_approval_session_id`) REFERENCES `transport_shipping_ecm`.`procurement`.`approval_session`(`approval_session_id`);

-- ========= TAGS =========
ALTER SCHEMA `transport_shipping_ecm`.`procurement` SET TAGS ('dbx_division' = 'corporate');
ALTER SCHEMA `transport_shipping_ecm`.`procurement` SET TAGS ('dbx_domain' = 'procurement');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier` SET TAGS ('dbx_subdomain' = 'vendor_management');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Org Unit Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Safety Program Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier` ALTER COLUMN `tpl_provider_id` SET TAGS ('dbx_business_glossary_term' = 'Tpl Provider Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier` ALTER COLUMN `address_line1` SET TAGS ('dbx_business_glossary_term' = 'Address Line 1');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier` ALTER COLUMN `address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier` ALTER COLUMN `address_line2` SET TAGS ('dbx_business_glossary_term' = 'Address Line 2');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier` ALTER COLUMN `address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier` ALTER COLUMN `aeo_certification_number` SET TAGS ('dbx_business_glossary_term' = 'Authorized Economic Operator (AEO) Certification Number');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier` ALTER COLUMN `aeo_certified` SET TAGS ('dbx_business_glossary_term' = 'Authorized Economic Operator (AEO) Certified');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier` ALTER COLUMN `contract_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Expiry Date');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier` ALTER COLUMN `ctpat_certification_number` SET TAGS ('dbx_business_glossary_term' = 'Customs-Trade Partnership Against Terrorism (C-TPAT) Certification Number');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier` ALTER COLUMN `ctpat_certified` SET TAGS ('dbx_business_glossary_term' = 'Customs-Trade Partnership Against Terrorism (C-TPAT) Certified');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier` ALTER COLUMN `dba_name` SET TAGS ('dbx_business_glossary_term' = 'Supplier Doing Business As (DBA) Name');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier` ALTER COLUMN `duns_number` SET TAGS ('dbx_business_glossary_term' = 'Data Universal Numbering System (DUNS) Number');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier` ALTER COLUMN `duns_number` SET TAGS ('dbx_value_regex' = '^[0-9]{9}$');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier` ALTER COLUMN `geographic_coverage` SET TAGS ('dbx_business_glossary_term' = 'Geographic Coverage');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier` ALTER COLUMN `iso_14001_certified` SET TAGS ('dbx_business_glossary_term' = 'ISO 14001 Environmental Management Certified');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier` ALTER COLUMN `iso_9001_certified` SET TAGS ('dbx_business_glossary_term' = 'ISO 9001 Quality Management Certified');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier` ALTER COLUMN `last_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Last Audit Date');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier` ALTER COLUMN `minority_owned` SET TAGS ('dbx_business_glossary_term' = 'Minority-Owned Business');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier` ALTER COLUMN `next_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Next Audit Date');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier` ALTER COLUMN `onboarding_date` SET TAGS ('dbx_business_glossary_term' = 'Onboarding Date');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier` ALTER COLUMN `onboarding_status` SET TAGS ('dbx_business_glossary_term' = 'Onboarding Status');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier` ALTER COLUMN `onboarding_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|kyc_review|compliance_review|approved|rejected');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'ach|wire_transfer|check|credit_card|letter_of_credit|purchase_card');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier` ALTER COLUMN `performance_rating` SET TAGS ('dbx_business_glossary_term' = 'Supplier Performance Rating');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier` ALTER COLUMN `preferred_currency` SET TAGS ('dbx_business_glossary_term' = 'Preferred Currency');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier` ALTER COLUMN `preferred_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier` ALTER COLUMN `preferred_supplier` SET TAGS ('dbx_business_glossary_term' = 'Preferred Supplier');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Email Address');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Name');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Phone Number');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier` ALTER COLUMN `risk_tier` SET TAGS ('dbx_business_glossary_term' = 'Supplier Risk Tier');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier` ALTER COLUMN `risk_tier` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier` ALTER COLUMN `service_capabilities` SET TAGS ('dbx_business_glossary_term' = 'Service Capabilities');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier` ALTER COLUMN `small_business` SET TAGS ('dbx_business_glossary_term' = 'Small Business');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'State or Province');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier` ALTER COLUMN `state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier` ALTER COLUMN `state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier` ALTER COLUMN `supplier_category` SET TAGS ('dbx_business_glossary_term' = 'Supplier Category');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier` ALTER COLUMN `supplier_category` SET TAGS ('dbx_value_regex' = 'direct|indirect|capital');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier` ALTER COLUMN `supplier_name` SET TAGS ('dbx_business_glossary_term' = 'Supplier Legal Name');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier` ALTER COLUMN `supplier_number` SET TAGS ('dbx_business_glossary_term' = 'Supplier Number');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier` ALTER COLUMN `supplier_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier` ALTER COLUMN `supplier_status` SET TAGS ('dbx_business_glossary_term' = 'Supplier Status');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier` ALTER COLUMN `supplier_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|pending_approval|blocked|terminated');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier` ALTER COLUMN `supplier_type` SET TAGS ('dbx_business_glossary_term' = 'Supplier Type');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier` ALTER COLUMN `supplier_type` SET TAGS ('dbx_value_regex' = 'carrier|fuel_supplier|it_vendor|facility_lessor|equipment_provider|professional_services');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_business_glossary_term' = 'Tax Identification Number');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier` ALTER COLUMN `vat_registration_number` SET TAGS ('dbx_business_glossary_term' = 'Value Added Tax (VAT) Registration Number');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier` ALTER COLUMN `vat_registration_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier` ALTER COLUMN `woman_owned` SET TAGS ('dbx_business_glossary_term' = 'Woman-Owned Business');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_site` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_site` SET TAGS ('dbx_subdomain' = 'vendor_management');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_site` ALTER COLUMN `supplier_site_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Site ID');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_site` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_site` ALTER COLUMN `address_line_1` SET TAGS ('dbx_business_glossary_term' = 'Address Line 1');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_site` ALTER COLUMN `address_line_1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_site` ALTER COLUMN `address_line_1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_site` ALTER COLUMN `address_line_2` SET TAGS ('dbx_business_glossary_term' = 'Address Line 2');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_site` ALTER COLUMN `address_line_2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_site` ALTER COLUMN `address_line_2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_site` ALTER COLUMN `bank_account_number` SET TAGS ('dbx_business_glossary_term' = 'Bank Account Number');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_site` ALTER COLUMN `bank_account_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_site` ALTER COLUMN `bank_account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_site` ALTER COLUMN `bank_branch_code` SET TAGS ('dbx_business_glossary_term' = 'Bank Branch Code');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_site` ALTER COLUMN `bank_branch_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_site` ALTER COLUMN `bank_name` SET TAGS ('dbx_business_glossary_term' = 'Bank Name');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_site` ALTER COLUMN `bank_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_site` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_site` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_site` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_site` ALTER COLUMN `contact_person_name` SET TAGS ('dbx_business_glossary_term' = 'Contact Person Name');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_site` ALTER COLUMN `contact_person_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_site` ALTER COLUMN `contact_person_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_site` ALTER COLUMN `contact_person_title` SET TAGS ('dbx_business_glossary_term' = 'Contact Person Title');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_site` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_site` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_site` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_site` ALTER COLUMN `effective_from_date` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_site` ALTER COLUMN `effective_to_date` SET TAGS ('dbx_business_glossary_term' = 'Effective To Date');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_site` ALTER COLUMN `email_address` SET TAGS ('dbx_business_glossary_term' = 'Email Address');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_site` ALTER COLUMN `email_address` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_site` ALTER COLUMN `email_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_site` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_site` ALTER COLUMN `fax_number` SET TAGS ('dbx_business_glossary_term' = 'Fax Number');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_site` ALTER COLUMN `fax_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_site` ALTER COLUMN `fax_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_site` ALTER COLUMN `iban` SET TAGS ('dbx_business_glossary_term' = 'International Bank Account Number (IBAN)');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_site` ALTER COLUMN `iban` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_site` ALTER COLUMN `iban` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_site` ALTER COLUMN `incoterm` SET TAGS ('dbx_business_glossary_term' = 'International Commercial Terms (Incoterms)');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_site` ALTER COLUMN `is_primary_site` SET TAGS ('dbx_business_glossary_term' = 'Is Primary Site');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_site` ALTER COLUMN `is_remit_to_site` SET TAGS ('dbx_business_glossary_term' = 'Is Remit-To Site');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_site` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_site` ALTER COLUMN `last_transaction_date` SET TAGS ('dbx_business_glossary_term' = 'Last Transaction Date');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_site` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_site` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_site` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_site` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time Days');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_site` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_site` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_site` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_site` ALTER COLUMN `minimum_order_value` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Value');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_site` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_site` ALTER COLUMN `operating_hours` SET TAGS ('dbx_business_glossary_term' = 'Operating Hours');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_site` ALTER COLUMN `payment_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Payment Currency Code');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_site` ALTER COLUMN `payment_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_site` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_site` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'wire_transfer|ach|check|credit_card|purchase_card|eft');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_site` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_site` ALTER COLUMN `phone_number` SET TAGS ('dbx_business_glossary_term' = 'Phone Number');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_site` ALTER COLUMN `phone_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_site` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_site` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_site` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_site` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_site` ALTER COLUMN `site_code` SET TAGS ('dbx_business_glossary_term' = 'Site Code');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_site` ALTER COLUMN `site_name` SET TAGS ('dbx_business_glossary_term' = 'Site Name');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_site` ALTER COLUMN `site_status` SET TAGS ('dbx_business_glossary_term' = 'Site Status');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_site` ALTER COLUMN `site_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|pending_approval|closed');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_site` ALTER COLUMN `site_type` SET TAGS ('dbx_business_glossary_term' = 'Site Type');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_site` ALTER COLUMN `site_type` SET TAGS ('dbx_value_regex' = 'remit_to|ship_from|order_from|bill_to|service_location|warehouse');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_site` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'State or Province');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_site` ALTER COLUMN `state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_site` ALTER COLUMN `state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_site` ALTER COLUMN `swift_code` SET TAGS ('dbx_business_glossary_term' = 'SWIFT Code');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_site` ALTER COLUMN `swift_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{6}[A-Z0-9]{2}([A-Z0-9]{3})?$');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_site` ALTER COLUMN `swift_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_site` ALTER COLUMN `tax_exemption_status` SET TAGS ('dbx_business_glossary_term' = 'Tax Exemption Status');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_site` ALTER COLUMN `tax_exemption_status` SET TAGS ('dbx_value_regex' = 'exempt|non_exempt|partial_exempt');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_site` ALTER COLUMN `tax_registration_number` SET TAGS ('dbx_business_glossary_term' = 'Tax Registration Number');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_site` ALTER COLUMN `tax_registration_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_site` ALTER COLUMN `time_zone` SET TAGS ('dbx_business_glossary_term' = 'Time Zone');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_qualification` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_qualification` SET TAGS ('dbx_subdomain' = 'vendor_management');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_qualification` ALTER COLUMN `supplier_qualification_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Qualification ID');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_qualification` ALTER COLUMN `audit_id` SET TAGS ('dbx_business_glossary_term' = 'Safety Audit Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_qualification` ALTER COLUMN `certificate_id` SET TAGS ('dbx_business_glossary_term' = 'Certificate Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_qualification` ALTER COLUMN `dg_certification_id` SET TAGS ('dbx_business_glossary_term' = 'Dg Certification Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_qualification` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By User ID');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_qualification` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_qualification` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_qualification` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Org Unit Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_qualification` ALTER COLUMN `supplier_emissions_disclosure_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Emissions Disclosure Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_qualification` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_qualification` ALTER COLUMN `trade_party_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Party Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_qualification` ALTER COLUMN `aeo_certificate_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'AEO (Authorized Economic Operator) Certificate Expiry Date');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_qualification` ALTER COLUMN `aeo_certification_status` SET TAGS ('dbx_business_glossary_term' = 'AEO (Authorized Economic Operator) Certification Status');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_qualification` ALTER COLUMN `aeo_certification_status` SET TAGS ('dbx_value_regex' = 'certified|not_certified|expired|pending_renewal');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_qualification` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_qualification` ALTER COLUMN `assessment_score` SET TAGS ('dbx_business_glossary_term' = 'Assessment Score');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_qualification` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_qualification` ALTER COLUMN `ctpat_certificate_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'C-TPAT (Customs-Trade Partnership Against Terrorism) Certificate Expiry Date');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_qualification` ALTER COLUMN `ctpat_certification_status` SET TAGS ('dbx_business_glossary_term' = 'C-TPAT (Customs-Trade Partnership Against Terrorism) Certification Status');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_qualification` ALTER COLUMN `ctpat_certification_status` SET TAGS ('dbx_value_regex' = 'certified|not_certified|expired|pending_renewal');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_qualification` ALTER COLUMN `denied_party_screening_date` SET TAGS ('dbx_business_glossary_term' = 'Denied Party Screening Date');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_qualification` ALTER COLUMN `denied_party_screening_status` SET TAGS ('dbx_business_glossary_term' = 'Denied Party Screening Status');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_qualification` ALTER COLUMN `denied_party_screening_status` SET TAGS ('dbx_value_regex' = 'cleared|flagged|pending|not_screened');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_qualification` ALTER COLUMN `due_diligence_completed_flag` SET TAGS ('dbx_business_glossary_term' = 'Due Diligence Completed Flag');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_qualification` ALTER COLUMN `due_diligence_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Due Diligence Completion Date');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_qualification` ALTER COLUMN `eu_sanctions_screening_result` SET TAGS ('dbx_business_glossary_term' = 'EU (European Union) Sanctions Screening Result');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_qualification` ALTER COLUMN `eu_sanctions_screening_result` SET TAGS ('dbx_value_regex' = 'pass|fail|review_required');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_qualification` ALTER COLUMN `financial_health_score` SET TAGS ('dbx_business_glossary_term' = 'Financial Health Score');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_qualification` ALTER COLUMN `financial_health_score` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_qualification` ALTER COLUMN `insurance_certificate_status` SET TAGS ('dbx_business_glossary_term' = 'Insurance Certificate Status');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_qualification` ALTER COLUMN `insurance_certificate_status` SET TAGS ('dbx_value_regex' = 'valid|expired|insufficient_coverage|not_provided');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_qualification` ALTER COLUMN `insurance_coverage_amount` SET TAGS ('dbx_business_glossary_term' = 'Insurance Coverage Amount');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_qualification` ALTER COLUMN `insurance_coverage_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_qualification` ALTER COLUMN `insurance_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Insurance Expiry Date');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_qualification` ALTER COLUMN `iso_certificate_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'ISO (International Organization for Standardization) Certificate Expiry Date');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_qualification` ALTER COLUMN `iso_certification_status` SET TAGS ('dbx_business_glossary_term' = 'ISO (International Organization for Standardization) Certification Status');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_qualification` ALTER COLUMN `iso_certification_status` SET TAGS ('dbx_value_regex' = 'certified|not_certified|expired|pending_renewal');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_qualification` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_qualification` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_qualification` ALTER COLUMN `ofac_screening_result` SET TAGS ('dbx_business_glossary_term' = 'OFAC (Office of Foreign Assets Control) Screening Result');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_qualification` ALTER COLUMN `ofac_screening_result` SET TAGS ('dbx_value_regex' = 'pass|fail|review_required');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_qualification` ALTER COLUMN `qualification_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Qualification Completion Date');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_qualification` ALTER COLUMN `qualification_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Qualification Expiry Date');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_qualification` ALTER COLUMN `qualification_notes` SET TAGS ('dbx_business_glossary_term' = 'Qualification Notes');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_qualification` ALTER COLUMN `qualification_number` SET TAGS ('dbx_business_glossary_term' = 'Qualification Number');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_qualification` ALTER COLUMN `qualification_number` SET TAGS ('dbx_value_regex' = '^SQ-[0-9]{8}$');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_qualification` ALTER COLUMN `qualification_start_date` SET TAGS ('dbx_business_glossary_term' = 'Qualification Start Date');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_qualification` ALTER COLUMN `qualification_status` SET TAGS ('dbx_business_glossary_term' = 'Qualification Status');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_qualification` ALTER COLUMN `qualification_status` SET TAGS ('dbx_value_regex' = 'pending|in_progress|approved|rejected|suspended|expired');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_qualification` ALTER COLUMN `qualification_type` SET TAGS ('dbx_business_glossary_term' = 'Qualification Type');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_qualification` ALTER COLUMN `qualification_type` SET TAGS ('dbx_value_regex' = 'initial_onboarding|periodic_review|re_qualification|ad_hoc_audit|compliance_verification|risk_assessment');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_qualification` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_qualification` ALTER COLUMN `risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Risk Rating');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_qualification` ALTER COLUMN `risk_rating` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_qualification` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_qualification` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'coupa|descartes_customs|manual_entry|third_party_service');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`rfq` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`rfq` SET TAGS ('dbx_subdomain' = 'sourcing_agreements');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`rfq` ALTER COLUMN `rfq_id` SET TAGS ('dbx_business_glossary_term' = 'Request for Quotation (RFQ) ID');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`rfq` ALTER COLUMN `approver_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approver ID');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`rfq` ALTER COLUMN `approver_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`rfq` ALTER COLUMN `approver_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`rfq` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Awarded Supplier ID');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`rfq` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`rfq` ALTER COLUMN `employee_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`rfq` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Issuing Org Unit Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`rfq` ALTER COLUMN `primary_rfq_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Buyer ID');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`rfq` ALTER COLUMN `primary_rfq_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`rfq` ALTER COLUMN `primary_rfq_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`rfq` ALTER COLUMN `procurement_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract ID');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`rfq` ALTER COLUMN `requester_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Requester ID');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`rfq` ALTER COLUMN `requester_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`rfq` ALTER COLUMN `requester_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`rfq` ALTER COLUMN `rfq_buyer_employee_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`rfq` ALTER COLUMN `rfq_employee_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`rfq` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`rfq` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`rfq` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`rfq` ALTER COLUMN `award_date` SET TAGS ('dbx_business_glossary_term' = 'Award Date');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`rfq` ALTER COLUMN `awarded_amount` SET TAGS ('dbx_business_glossary_term' = 'Awarded Amount');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`rfq` ALTER COLUMN `awarded_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`rfq` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`rfq` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Level');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`rfq` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_value_regex' = 'public|internal|confidential|restricted');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`rfq` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`rfq` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`rfq` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`rfq` ALTER COLUMN `delivery_country_code` SET TAGS ('dbx_business_glossary_term' = 'Delivery Country Code');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`rfq` ALTER COLUMN `delivery_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`rfq` ALTER COLUMN `delivery_location` SET TAGS ('dbx_business_glossary_term' = 'Delivery Location');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`rfq` ALTER COLUMN `delivery_weight_percentage` SET TAGS ('dbx_business_glossary_term' = 'Delivery Weight Percentage');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`rfq` ALTER COLUMN `estimated_spend_amount` SET TAGS ('dbx_business_glossary_term' = 'Estimated Spend Amount');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`rfq` ALTER COLUMN `estimated_spend_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`rfq` ALTER COLUMN `evaluation_criteria` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Criteria');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`rfq` ALTER COLUMN `incoterms` SET TAGS ('dbx_business_glossary_term' = 'International Commercial Terms (Incoterms)');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`rfq` ALTER COLUMN `is_multi_round` SET TAGS ('dbx_business_glossary_term' = 'Is Multi-Round');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`rfq` ALTER COLUMN `is_reverse_auction` SET TAGS ('dbx_business_glossary_term' = 'Is Reverse Auction');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`rfq` ALTER COLUMN `issue_date` SET TAGS ('dbx_business_glossary_term' = 'Request for Quotation (RFQ) Issue Date');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`rfq` ALTER COLUMN `issuing_business_unit` SET TAGS ('dbx_business_glossary_term' = 'Issuing Business Unit');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`rfq` ALTER COLUMN `issuing_country_code` SET TAGS ('dbx_business_glossary_term' = 'Issuing Country Code');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`rfq` ALTER COLUMN `issuing_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`rfq` ALTER COLUMN `issuing_location` SET TAGS ('dbx_business_glossary_term' = 'Issuing Location');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`rfq` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`rfq` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`rfq` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`rfq` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`rfq` ALTER COLUMN `price_weight_percentage` SET TAGS ('dbx_business_glossary_term' = 'Price Weight Percentage');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`rfq` ALTER COLUMN `quality_weight_percentage` SET TAGS ('dbx_business_glossary_term' = 'Quality Weight Percentage');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`rfq` ALTER COLUMN `required_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Required Delivery Date');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`rfq` ALTER COLUMN `response_count` SET TAGS ('dbx_business_glossary_term' = 'Response Count');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`rfq` ALTER COLUMN `rfq_category` SET TAGS ('dbx_business_glossary_term' = 'Procurement Category');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`rfq` ALTER COLUMN `rfq_description` SET TAGS ('dbx_business_glossary_term' = 'Request for Quotation (RFQ) Description');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`rfq` ALTER COLUMN `rfq_number` SET TAGS ('dbx_business_glossary_term' = 'Request for Quotation (RFQ) Number');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`rfq` ALTER COLUMN `rfq_number` SET TAGS ('dbx_value_regex' = '^RFQ-[0-9]{8,12}$');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`rfq` ALTER COLUMN `rfq_status` SET TAGS ('dbx_business_glossary_term' = 'Request for Quotation (RFQ) Status');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`rfq` ALTER COLUMN `sourcing_event_type` SET TAGS ('dbx_business_glossary_term' = 'Sourcing Event Type');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`rfq` ALTER COLUMN `sourcing_event_type` SET TAGS ('dbx_value_regex' = 'spot|tactical|strategic');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`rfq` ALTER COLUMN `subcategory` SET TAGS ('dbx_business_glossary_term' = 'Procurement Subcategory');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`rfq` ALTER COLUMN `submission_deadline` SET TAGS ('dbx_business_glossary_term' = 'Submission Deadline');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`rfq` ALTER COLUMN `supplier_count` SET TAGS ('dbx_business_glossary_term' = 'Supplier Count');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`rfq` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Request for Quotation (RFQ) Title');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`rfq` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_quote` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_quote` SET TAGS ('dbx_subdomain' = 'sourcing_agreements');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_quote` ALTER COLUMN `supplier_quote_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Quote ID');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_quote` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_quote` ALTER COLUMN `rfq_id` SET TAGS ('dbx_business_glossary_term' = 'Request for Quotation (RFQ) ID');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_quote` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_quote` ALTER COLUMN `supplier_site_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Site Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_quote` ALTER COLUMN `award_date` SET TAGS ('dbx_business_glossary_term' = 'Award Date');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_quote` ALTER COLUMN `award_status` SET TAGS ('dbx_business_glossary_term' = 'Award Status');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_quote` ALTER COLUMN `award_status` SET TAGS ('dbx_value_regex' = 'not_awarded|awarded|partially_awarded|declined');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_quote` ALTER COLUMN `compliance_certification` SET TAGS ('dbx_business_glossary_term' = 'Compliance Certification');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_quote` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_quote` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_quote` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_quote` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_quote` ALTER COLUMN `customs_duty_estimate` SET TAGS ('dbx_business_glossary_term' = 'Customs Duty Estimate');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_quote` ALTER COLUMN `delivery_terms` SET TAGS ('dbx_business_glossary_term' = 'Delivery Terms');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_quote` ALTER COLUMN `destination_location` SET TAGS ('dbx_business_glossary_term' = 'Destination Location');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_quote` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_quote` ALTER COLUMN `discount_percentage` SET TAGS ('dbx_business_glossary_term' = 'Discount Percentage');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_quote` ALTER COLUMN `evaluation_score` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Score');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_quote` ALTER COLUMN `freight_charges` SET TAGS ('dbx_business_glossary_term' = 'Freight Charges');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_quote` ALTER COLUMN `handling_charges` SET TAGS ('dbx_business_glossary_term' = 'Handling Charges');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_quote` ALTER COLUMN `insurance_charges` SET TAGS ('dbx_business_glossary_term' = 'Insurance Charges');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_quote` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time Days');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_quote` ALTER COLUMN `maximum_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Maximum Order Quantity');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_quote` ALTER COLUMN `minimum_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity (MOQ)');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_quote` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_quote` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_quote` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Quote Notes');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_quote` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_quote` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'bank_transfer|letter_of_credit|check|electronic_payment|cash_on_delivery');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_quote` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_quote` ALTER COLUMN `quote_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Quote Reference Number');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_quote` ALTER COLUMN `quote_status` SET TAGS ('dbx_business_glossary_term' = 'Quote Status');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_quote` ALTER COLUMN `quote_type` SET TAGS ('dbx_business_glossary_term' = 'Quote Type');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_quote` ALTER COLUMN `quote_type` SET TAGS ('dbx_value_regex' = 'standard|volume_discount|spot|contract|framework');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_quote` ALTER COLUMN `rank` SET TAGS ('dbx_business_glossary_term' = 'Quote Rank');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_quote` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_quote` ALTER COLUMN `shipping_point` SET TAGS ('dbx_business_glossary_term' = 'Shipping Point');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_quote` ALTER COLUMN `submission_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Submission Timestamp');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_quote` ALTER COLUMN `sustainability_rating` SET TAGS ('dbx_business_glossary_term' = 'Sustainability Rating');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_quote` ALTER COLUMN `sustainability_rating` SET TAGS ('dbx_value_regex' = 'A|B|C|D|not_rated');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_quote` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_quote` ALTER COLUMN `total_amount_including_tax` SET TAGS ('dbx_business_glossary_term' = 'Total Amount Including Tax');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_quote` ALTER COLUMN `total_quoted_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Quoted Amount');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_quote` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_quote` ALTER COLUMN `valid_from_date` SET TAGS ('dbx_business_glossary_term' = 'Valid From Date');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_quote` ALTER COLUMN `valid_until_date` SET TAGS ('dbx_business_glossary_term' = 'Valid Until Date');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_quote` ALTER COLUMN `warranty_terms` SET TAGS ('dbx_business_glossary_term' = 'Warranty Terms');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`purchase_order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`purchase_order` SET TAGS ('dbx_subdomain' = 'order_fulfillment');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`purchase_order` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) ID');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`purchase_order` ALTER COLUMN `blanket_order_id` SET TAGS ('dbx_business_glossary_term' = 'Blanket Order Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`purchase_order` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`purchase_order` ALTER COLUMN `freight_order_id` SET TAGS ('dbx_business_glossary_term' = 'Inbound Freight Order Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`purchase_order` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Issuing Location ID');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`purchase_order` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Issuing Entity ID');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`purchase_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Buyer ID');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`purchase_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`purchase_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`purchase_order` ALTER COLUMN `procurement_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract ID');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`purchase_order` ALTER COLUMN `requester_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Requester ID');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`purchase_order` ALTER COLUMN `requester_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`purchase_order` ALTER COLUMN `requester_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`purchase_order` ALTER COLUMN `risk_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`purchase_order` ALTER COLUMN `ship_to_location_id` SET TAGS ('dbx_business_glossary_term' = 'Ship-To Location ID');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`purchase_order` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`purchase_order` ALTER COLUMN `supplier_site_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Site Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`purchase_order` ALTER COLUMN `acknowledgement_received_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgement Received Timestamp');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`purchase_order` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`purchase_order` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|approved|rejected|escalated');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`purchase_order` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`purchase_order` ALTER COLUMN `budget_code` SET TAGS ('dbx_business_glossary_term' = 'Budget Code');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`purchase_order` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`purchase_order` ALTER COLUMN `cancelled_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Cancelled Timestamp');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`purchase_order` ALTER COLUMN `closed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Closed Timestamp');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`purchase_order` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`purchase_order` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`purchase_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`purchase_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`purchase_order` ALTER COLUMN `expenditure_type` SET TAGS ('dbx_business_glossary_term' = 'Capital Expenditure (CAPEX) / Operating Expenditure (OPEX) Classification');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`purchase_order` ALTER COLUMN `expenditure_type` SET TAGS ('dbx_value_regex' = 'CAPEX|OPEX');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`purchase_order` ALTER COLUMN `freight_term` SET TAGS ('dbx_business_glossary_term' = 'Freight Term');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`purchase_order` ALTER COLUMN `freight_term` SET TAGS ('dbx_value_regex' = 'prepaid|collect|third_party|fob_origin|fob_destination');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`purchase_order` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`purchase_order` ALTER COLUMN `incoterm` SET TAGS ('dbx_business_glossary_term' = 'Incoterms (International Commercial Terms)');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`purchase_order` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`purchase_order` ALTER COLUMN `net_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Purchase Order (PO) Amount');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`purchase_order` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`purchase_order` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'wire_transfer|ach|check|credit_card|letter_of_credit|cash');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`purchase_order` ALTER COLUMN `payment_term_code` SET TAGS ('dbx_business_glossary_term' = 'Payment Term Code');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`purchase_order` ALTER COLUMN `po_date` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Date');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`purchase_order` ALTER COLUMN `po_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Number');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`purchase_order` ALTER COLUMN `po_number` SET TAGS ('dbx_value_regex' = '^PO-[0-9]{8,12}$');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`purchase_order` ALTER COLUMN `po_status` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Status');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`purchase_order` ALTER COLUMN `po_type` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Type');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`purchase_order` ALTER COLUMN `po_type` SET TAGS ('dbx_value_regex' = 'standard|blanket|planned|contract_release|spot|emergency');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`purchase_order` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Priority');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`purchase_order` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'low|normal|high|urgent|critical');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`purchase_order` ALTER COLUMN `procurement_category` SET TAGS ('dbx_business_glossary_term' = 'Procurement Category');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`purchase_order` ALTER COLUMN `promised_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Promised Delivery Date');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`purchase_order` ALTER COLUMN `requested_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Requested Delivery Date');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`purchase_order` ALTER COLUMN `sent_to_supplier_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Sent to Supplier Timestamp');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`purchase_order` ALTER COLUMN `shipping_method` SET TAGS ('dbx_business_glossary_term' = 'Shipping Method');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`purchase_order` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`purchase_order` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System ID');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`purchase_order` ALTER COLUMN `special_instructions` SET TAGS ('dbx_business_glossary_term' = 'Special Instructions');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`purchase_order` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`purchase_order` ALTER COLUMN `total_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Purchase Order (PO) Amount');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`po_line` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`po_line` SET TAGS ('dbx_subdomain' = 'order_fulfillment');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`po_line` ALTER COLUMN `po_line_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Line ID');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`po_line` ALTER COLUMN `blanket_order_id` SET TAGS ('dbx_business_glossary_term' = 'Blanket Order Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`po_line` ALTER COLUMN `chart_of_accounts_id` SET TAGS ('dbx_business_glossary_term' = 'Chart Of Accounts Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`po_line` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`po_line` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Location ID');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`po_line` ALTER COLUMN `hazard_register_id` SET TAGS ('dbx_business_glossary_term' = 'Hazard Register Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`po_line` ALTER COLUMN `item_id` SET TAGS ('dbx_business_glossary_term' = 'Item ID');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`po_line` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Buyer ID');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`po_line` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`po_line` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`po_line` ALTER COLUMN `procurement_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract ID');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`po_line` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`po_line` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) ID');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`po_line` ALTER COLUMN `purchase_requisition_id` SET TAGS ('dbx_business_glossary_term' = 'Requisition Line ID');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`po_line` ALTER COLUMN `requester_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Requester ID');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`po_line` ALTER COLUMN `requester_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`po_line` ALTER COLUMN `requester_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`po_line` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`po_line` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`po_line` ALTER COLUMN `asset_number` SET TAGS ('dbx_business_glossary_term' = 'Asset Number');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`po_line` ALTER COLUMN `closed_date` SET TAGS ('dbx_business_glossary_term' = 'Closed Date');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`po_line` ALTER COLUMN `commodity_category` SET TAGS ('dbx_business_glossary_term' = 'Commodity Category');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`po_line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`po_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`po_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`po_line` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`po_line` ALTER COLUMN `incoterm` SET TAGS ('dbx_business_glossary_term' = 'International Commercial Terms (Incoterms)');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`po_line` ALTER COLUMN `invoiced_quantity` SET TAGS ('dbx_business_glossary_term' = 'Invoiced Quantity');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`po_line` ALTER COLUMN `is_capital_expenditure` SET TAGS ('dbx_business_glossary_term' = 'Is Capital Expenditure (CAPEX)');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`po_line` ALTER COLUMN `is_services` SET TAGS ('dbx_business_glossary_term' = 'Is Services');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`po_line` ALTER COLUMN `line_notes` SET TAGS ('dbx_business_glossary_term' = 'Line Notes');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`po_line` ALTER COLUMN `line_number` SET TAGS ('dbx_business_glossary_term' = 'Line Number');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`po_line` ALTER COLUMN `line_status` SET TAGS ('dbx_business_glossary_term' = 'Line Status');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`po_line` ALTER COLUMN `line_status` SET TAGS ('dbx_value_regex' = 'open|partially_received|fully_received|cancelled|closed');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`po_line` ALTER COLUMN `line_total_amount` SET TAGS ('dbx_business_glossary_term' = 'Line Total Amount');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`po_line` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`po_line` ALTER COLUMN `net_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Amount');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`po_line` ALTER COLUMN `ordered_quantity` SET TAGS ('dbx_business_glossary_term' = 'Ordered Quantity');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`po_line` ALTER COLUMN `payment_term_code` SET TAGS ('dbx_business_glossary_term' = 'Payment Term Code');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`po_line` ALTER COLUMN `promised_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Promised Delivery Date');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`po_line` ALTER COLUMN `received_quantity` SET TAGS ('dbx_business_glossary_term' = 'Received Quantity');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`po_line` ALTER COLUMN `requested_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Requested Delivery Date');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`po_line` ALTER COLUMN `supplier_part_number` SET TAGS ('dbx_business_glossary_term' = 'Supplier Part Number');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`po_line` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`po_line` ALTER COLUMN `tax_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Code');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`po_line` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`po_line` ALTER COLUMN `unit_price` SET TAGS ('dbx_business_glossary_term' = 'Unit Price');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`po_line` ALTER COLUMN `wbs_element` SET TAGS ('dbx_business_glossary_term' = 'Work Breakdown Structure (WBS) Element');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`goods_receipt` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`goods_receipt` SET TAGS ('dbx_subdomain' = 'order_fulfillment');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `goods_receipt_id` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt (GR) ID');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `consignment_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment ID');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center ID');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `declaration_id` SET TAGS ('dbx_business_glossary_term' = 'Customs Declaration Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `facility_inspection_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Inspection Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `freight_order_id` SET TAGS ('dbx_business_glossary_term' = 'Freight Order Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `inbound_receipt_id` SET TAGS ('dbx_business_glossary_term' = 'Inbound Receipt Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Inspector Employee ID');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice ID');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `material_id` SET TAGS ('dbx_business_glossary_term' = 'Material ID');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `po_line_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Line ID');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `primary_goods_receiver_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Receiver Employee ID');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `primary_goods_receiver_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `primary_goods_receiver_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) ID');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Receiving Location ID');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `shift_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Shift Schedule Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `transport_document_id` SET TAGS ('dbx_business_glossary_term' = 'Transport Document Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `accepted_quantity` SET TAGS ('dbx_business_glossary_term' = 'Accepted Quantity');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Number');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `delivery_note_number` SET TAGS ('dbx_business_glossary_term' = 'Delivery Note Number');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `expected_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Expected Delivery Date');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `gr_number` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt (GR) Number');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `gr_number` SET TAGS ('dbx_value_regex' = '^GR[0-9]{10}$');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `inspection_certificate_number` SET TAGS ('dbx_business_glossary_term' = 'Inspection Certificate Number');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Inspection Date');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `manufacture_date` SET TAGS ('dbx_business_glossary_term' = 'Manufacture Date');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `match_tolerance_exceeded_flag` SET TAGS ('dbx_business_glossary_term' = 'Match Tolerance Exceeded Flag');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `ordered_quantity` SET TAGS ('dbx_business_glossary_term' = 'Ordered Quantity');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `payment_cleared_flag` SET TAGS ('dbx_business_glossary_term' = 'Payment Cleared Flag');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `receipt_date` SET TAGS ('dbx_business_glossary_term' = 'Receipt Date');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `receipt_status` SET TAGS ('dbx_business_glossary_term' = 'Receipt Status');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `receipt_status` SET TAGS ('dbx_value_regex' = 'draft|pending_inspection|accepted|partially_accepted|rejected|cancelled');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `receipt_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Receipt Timestamp');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `receipt_type` SET TAGS ('dbx_business_glossary_term' = 'Receipt Type');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `receipt_type` SET TAGS ('dbx_value_regex' = 'standard|return|transfer|consignment|service');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `receipt_value_amount` SET TAGS ('dbx_business_glossary_term' = 'Receipt Value Amount');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `received_quantity` SET TAGS ('dbx_business_glossary_term' = 'Received Quantity');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `receiving_dock` SET TAGS ('dbx_business_glossary_term' = 'Receiving Dock');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `rejected_quantity` SET TAGS ('dbx_business_glossary_term' = 'Rejected Quantity');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `rejection_notes` SET TAGS ('dbx_business_glossary_term' = 'Rejection Notes');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `rejection_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason Code');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `return_authorization_number` SET TAGS ('dbx_business_glossary_term' = 'Return Merchandise Authorization (RMA) Number');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `serial_number` SET TAGS ('dbx_business_glossary_term' = 'Serial Number');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System ID');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `storage_location` SET TAGS ('dbx_business_glossary_term' = 'Storage Location');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `three_way_match_status` SET TAGS ('dbx_business_glossary_term' = 'Three-Way Match Status');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `three_way_match_status` SET TAGS ('dbx_value_regex' = 'matched|quantity_variance|price_variance|not_matched|pending');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_invoice` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_invoice` SET TAGS ('dbx_subdomain' = 'order_fulfillment');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_invoice` ALTER COLUMN `supplier_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Invoice ID');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_invoice` ALTER COLUMN `chart_of_accounts_id` SET TAGS ('dbx_business_glossary_term' = 'Chart Of Accounts Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_invoice` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_invoice` ALTER COLUMN `contract_approval_workflow_id` SET TAGS ('dbx_business_glossary_term' = 'Approval Workflow ID');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_invoice` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_invoice` ALTER COLUMN `declaration_id` SET TAGS ('dbx_business_glossary_term' = 'Customs Declaration Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_invoice` ALTER COLUMN `duty_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Duty Assessment Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_invoice` ALTER COLUMN `fiscal_period_id` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_invoice` ALTER COLUMN `goods_receipt_id` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt (GR) ID');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_invoice` ALTER COLUMN `inbound_receipt_id` SET TAGS ('dbx_business_glossary_term' = 'Inbound Receipt Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_invoice` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approver ID');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_invoice` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_invoice` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_invoice` ALTER COLUMN `procurement_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract ID');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_invoice` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_invoice` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) ID');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_invoice` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_invoice` ALTER COLUMN `supplier_site_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Site Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_invoice` ALTER COLUMN `tertiary_supplier_modified_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Modified By User ID');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_invoice` ALTER COLUMN `tertiary_supplier_modified_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_invoice` ALTER COLUMN `tertiary_supplier_modified_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_invoice` ALTER COLUMN `transport_document_id` SET TAGS ('dbx_business_glossary_term' = 'Transport Document Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_invoice` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_invoice` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_invoice` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_invoice` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_invoice` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_invoice` ALTER COLUMN `dispute_date` SET TAGS ('dbx_business_glossary_term' = 'Dispute Date');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_invoice` ALTER COLUMN `dispute_flag` SET TAGS ('dbx_business_glossary_term' = 'Dispute Flag');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_invoice` ALTER COLUMN `dispute_reason` SET TAGS ('dbx_business_glossary_term' = 'Dispute Reason');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_invoice` ALTER COLUMN `document_reference_url` SET TAGS ('dbx_business_glossary_term' = 'Document Reference URL');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_invoice` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Due Date');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_invoice` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_invoice` ALTER COLUMN `gross_amount` SET TAGS ('dbx_business_glossary_term' = 'Gross Invoice Amount');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_invoice` ALTER COLUMN `invoice_date` SET TAGS ('dbx_business_glossary_term' = 'Invoice Date');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_invoice` ALTER COLUMN `invoice_description` SET TAGS ('dbx_business_glossary_term' = 'Invoice Description');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_invoice` ALTER COLUMN `invoice_number` SET TAGS ('dbx_business_glossary_term' = 'Invoice Number');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_invoice` ALTER COLUMN `invoice_status` SET TAGS ('dbx_business_glossary_term' = 'Invoice Status');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_invoice` ALTER COLUMN `invoice_type` SET TAGS ('dbx_business_glossary_term' = 'Invoice Type');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_invoice` ALTER COLUMN `invoice_type` SET TAGS ('dbx_value_regex' = 'standard|credit_memo|debit_memo|prepayment|proforma|self_billing');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_invoice` ALTER COLUMN `match_exception_amount` SET TAGS ('dbx_business_glossary_term' = 'Match Exception Amount');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_invoice` ALTER COLUMN `match_exception_resolution` SET TAGS ('dbx_business_glossary_term' = 'Match Exception Resolution');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_invoice` ALTER COLUMN `match_exception_type` SET TAGS ('dbx_business_glossary_term' = 'Match Exception Type');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_invoice` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_invoice` ALTER COLUMN `net_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Invoice Amount');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_invoice` ALTER COLUMN `payment_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Date');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_invoice` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_invoice` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'wire_transfer|ach|check|credit_card|virtual_card|letter_of_credit');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_invoice` ALTER COLUMN `payment_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Payment Reference Number');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_invoice` ALTER COLUMN `payment_term_code` SET TAGS ('dbx_business_glossary_term' = 'Payment Term Code');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_invoice` ALTER COLUMN `received_date` SET TAGS ('dbx_business_glossary_term' = 'Invoice Received Date');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_invoice` ALTER COLUMN `submission_method` SET TAGS ('dbx_business_glossary_term' = 'Submission Method');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_invoice` ALTER COLUMN `submission_method` SET TAGS ('dbx_value_regex' = 'edi|email|portal|paper|api');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_invoice` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_invoice` ALTER COLUMN `tax_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Tax Jurisdiction');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_invoice` ALTER COLUMN `tax_registration_number` SET TAGS ('dbx_business_glossary_term' = 'Tax Registration Number');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_invoice` ALTER COLUMN `three_way_match_status` SET TAGS ('dbx_business_glossary_term' = 'Three-Way Match Status');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_invoice` ALTER COLUMN `three_way_match_status` SET TAGS ('dbx_value_regex' = 'not_applicable|pending|matched|exception|override_approved');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_invoice` ALTER COLUMN `withholding_tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Withholding Tax Amount');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`procurement_invoice_line` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`procurement_invoice_line` SET TAGS ('dbx_subdomain' = 'order_fulfillment');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`procurement_invoice_line` ALTER COLUMN `procurement_invoice_line_id` SET TAGS ('dbx_business_glossary_term' = 'Procurement Invoice Line ID');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`procurement_invoice_line` ALTER COLUMN `fiscal_period_id` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`procurement_invoice_line` ALTER COLUMN `goods_receipt_id` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt Line ID');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`procurement_invoice_line` ALTER COLUMN `item_id` SET TAGS ('dbx_business_glossary_term' = 'Item Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`procurement_invoice_line` ALTER COLUMN `po_line_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Line ID');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`procurement_invoice_line` ALTER COLUMN `supplier_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Procurement Invoice ID');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`procurement_invoice_line` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`procurement_invoice_line` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|on_hold');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`procurement_invoice_line` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`procurement_invoice_line` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`procurement_invoice_line` ALTER COLUMN `asset_number` SET TAGS ('dbx_business_glossary_term' = 'Asset Number');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`procurement_invoice_line` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`procurement_invoice_line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`procurement_invoice_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`procurement_invoice_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`procurement_invoice_line` ALTER COLUMN `delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Delivery Date');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`procurement_invoice_line` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`procurement_invoice_line` ALTER COLUMN `dispute_flag` SET TAGS ('dbx_business_glossary_term' = 'Dispute Flag');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`procurement_invoice_line` ALTER COLUMN `dispute_reason` SET TAGS ('dbx_business_glossary_term' = 'Dispute Reason');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`procurement_invoice_line` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`procurement_invoice_line` ALTER COLUMN `invoiced_quantity` SET TAGS ('dbx_business_glossary_term' = 'Invoiced Quantity');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`procurement_invoice_line` ALTER COLUMN `item_category` SET TAGS ('dbx_business_glossary_term' = 'Item Category');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`procurement_invoice_line` ALTER COLUMN `item_description` SET TAGS ('dbx_business_glossary_term' = 'Line Item Description');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`procurement_invoice_line` ALTER COLUMN `line_amount` SET TAGS ('dbx_business_glossary_term' = 'Line Amount');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`procurement_invoice_line` ALTER COLUMN `line_number` SET TAGS ('dbx_business_glossary_term' = 'Invoice Line Number');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`procurement_invoice_line` ALTER COLUMN `match_status` SET TAGS ('dbx_business_glossary_term' = 'Match Status');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`procurement_invoice_line` ALTER COLUMN `match_status` SET TAGS ('dbx_value_regex' = 'matched|price_variance|quantity_variance|unmatched|disputed|approved');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`procurement_invoice_line` ALTER COLUMN `material_code` SET TAGS ('dbx_business_glossary_term' = 'Material Code');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`procurement_invoice_line` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`procurement_invoice_line` ALTER COLUMN `net_line_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Line Amount');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`procurement_invoice_line` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Line Notes');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`procurement_invoice_line` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`procurement_invoice_line` ALTER COLUMN `price_variance_amount` SET TAGS ('dbx_business_glossary_term' = 'Price Variance Amount');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`procurement_invoice_line` ALTER COLUMN `profit_center_code` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Code');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`procurement_invoice_line` ALTER COLUMN `project_code` SET TAGS ('dbx_business_glossary_term' = 'Project Code');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`procurement_invoice_line` ALTER COLUMN `quantity_variance` SET TAGS ('dbx_business_glossary_term' = 'Quantity Variance');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`procurement_invoice_line` ALTER COLUMN `service_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Service Period End Date');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`procurement_invoice_line` ALTER COLUMN `service_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Service Period Start Date');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`procurement_invoice_line` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`procurement_invoice_line` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System ID');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`procurement_invoice_line` ALTER COLUMN `supplier_part_number` SET TAGS ('dbx_business_glossary_term' = 'Supplier Part Number');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`procurement_invoice_line` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`procurement_invoice_line` ALTER COLUMN `tax_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Code');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`procurement_invoice_line` ALTER COLUMN `tax_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Tax Rate Percentage');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`procurement_invoice_line` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`procurement_invoice_line` ALTER COLUMN `unit_price` SET TAGS ('dbx_business_glossary_term' = 'Unit Price');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`procurement_invoice_line` ALTER COLUMN `variance_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Variance Reason Code');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`procurement_invoice_line` ALTER COLUMN `withholding_tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Withholding Tax Amount');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`procurement_invoice_line` ALTER COLUMN `withholding_tax_code` SET TAGS ('dbx_business_glossary_term' = 'Withholding Tax Code');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`purchase_requisition` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`purchase_requisition` SET TAGS ('dbx_subdomain' = 'order_fulfillment');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `purchase_requisition_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Requisition ID');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Business Unit ID');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `contract_approval_workflow_id` SET TAGS ('dbx_business_glossary_term' = 'Approval Workflow ID');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Location ID');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `item_id` SET TAGS ('dbx_business_glossary_term' = 'Item Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `position_id` SET TAGS ('dbx_business_glossary_term' = 'Position Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Preferred Supplier ID');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Requestor Employee ID');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `procurement_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract ID');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) ID');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `quaternary_purchase_last_modified_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By Employee ID');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `quaternary_purchase_last_modified_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `quaternary_purchase_last_modified_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `requestor_employee_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `rfq_id` SET TAGS ('dbx_business_glossary_term' = 'Sourcing Event ID');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `tertiary_purchase_final_approver_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Final Approver Employee ID');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `tertiary_purchase_final_approver_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `tertiary_purchase_final_approver_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `approval_level` SET TAGS ('dbx_business_glossary_term' = 'Approval Level');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `budget_check_status` SET TAGS ('dbx_business_glossary_term' = 'Budget Check Status');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `budget_check_status` SET TAGS ('dbx_value_regex' = 'not_checked|passed|failed|override_approved');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `budget_check_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Budget Check Timestamp');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `conversion_outcome` SET TAGS ('dbx_business_glossary_term' = 'Conversion Outcome');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `conversion_outcome` SET TAGS ('dbx_value_regex' = 'not_converted|converted_to_po|routed_to_rfq|routed_to_rfp|cancelled');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `delivery_address` SET TAGS ('dbx_business_glossary_term' = 'Delivery Address');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `delivery_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `delivery_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `estimated_total_amount` SET TAGS ('dbx_business_glossary_term' = 'Estimated Total Amount');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `estimated_unit_price` SET TAGS ('dbx_business_glossary_term' = 'Estimated Unit Price');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_value_regex' = '^[0-9]{4,10}$');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `is_capital_expenditure` SET TAGS ('dbx_business_glossary_term' = 'Is Capital Expenditure (CAPEX) Flag');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `justification` SET TAGS ('dbx_business_glossary_term' = 'Business Justification');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|urgent');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `quantity_requested` SET TAGS ('dbx_business_glossary_term' = 'Quantity Requested');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `rejected_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Rejected Timestamp');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `required_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Required Delivery Date');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `requisition_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Requisition Number');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `requisition_number` SET TAGS ('dbx_value_regex' = '^PR-[0-9]{8,12}$');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `requisition_status` SET TAGS ('dbx_business_glossary_term' = 'Requisition Status');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `requisition_type` SET TAGS ('dbx_business_glossary_term' = 'Requisition Type');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `requisition_type` SET TAGS ('dbx_value_regex' = 'goods|services|capital_equipment|maintenance_repair_operations|fleet_acquisition|warehouse_equipment');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `special_instructions` SET TAGS ('dbx_business_glossary_term' = 'Special Instructions');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `submitted_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Submitted Timestamp');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`blanket_order` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`blanket_order` SET TAGS ('dbx_subdomain' = 'sourcing_agreements');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`blanket_order` ALTER COLUMN `blanket_order_id` SET TAGS ('dbx_business_glossary_term' = 'Blanket Order ID');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`blanket_order` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`blanket_order` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`blanket_order` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`blanket_order` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`blanket_order` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Org Unit Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`blanket_order` ALTER COLUMN `procurement_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Procurement Contract Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`blanket_order` ALTER COLUMN `rfq_id` SET TAGS ('dbx_business_glossary_term' = 'Rfq Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`blanket_order` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`blanket_order` ALTER COLUMN `agreement_number` SET TAGS ('dbx_business_glossary_term' = 'Blanket Agreement Number');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`blanket_order` ALTER COLUMN `agreement_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{6,20}$');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`blanket_order` ALTER COLUMN `agreement_type` SET TAGS ('dbx_business_glossary_term' = 'Agreement Type');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`blanket_order` ALTER COLUMN `agreement_type` SET TAGS ('dbx_value_regex' = 'value_based|quantity_based|time_based|hybrid');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`blanket_order` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`blanket_order` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`blanket_order` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`blanket_order` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`blanket_order` ALTER COLUMN `blanket_order_status` SET TAGS ('dbx_business_glossary_term' = 'Blanket Order Status');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`blanket_order` ALTER COLUMN `blanket_order_status` SET TAGS ('dbx_value_regex' = 'draft|active|suspended|expired|closed|cancelled');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`blanket_order` ALTER COLUMN `category_code` SET TAGS ('dbx_business_glossary_term' = 'Procurement Category Code');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`blanket_order` ALTER COLUMN `category_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{4,15}$');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`blanket_order` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`blanket_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`blanket_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`blanket_order` ALTER COLUMN `delivery_terms` SET TAGS ('dbx_business_glossary_term' = 'Delivery Terms (Incoterms)');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`blanket_order` ALTER COLUMN `discount_percentage` SET TAGS ('dbx_business_glossary_term' = 'Discount Percentage');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`blanket_order` ALTER COLUMN `effective_from_date` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`blanket_order` ALTER COLUMN `effective_until_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`blanket_order` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time Days');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`blanket_order` ALTER COLUMN `material_group` SET TAGS ('dbx_business_glossary_term' = 'Material Group');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`blanket_order` ALTER COLUMN `material_group` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`blanket_order` ALTER COLUMN `maximum_release_value` SET TAGS ('dbx_business_glossary_term' = 'Maximum Release Value');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`blanket_order` ALTER COLUMN `minimum_release_value` SET TAGS ('dbx_business_glossary_term' = 'Minimum Release Value');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`blanket_order` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`blanket_order` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`blanket_order` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`blanket_order` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`blanket_order` ALTER COLUMN `pricing_condition` SET TAGS ('dbx_business_glossary_term' = 'Pricing Condition');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`blanket_order` ALTER COLUMN `pricing_condition` SET TAGS ('dbx_value_regex' = 'fixed|variable|index_linked|tiered');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`blanket_order` ALTER COLUMN `purchasing_group` SET TAGS ('dbx_business_glossary_term' = 'Purchasing Group');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`blanket_order` ALTER COLUMN `purchasing_group` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,6}$');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`blanket_order` ALTER COLUMN `purchasing_organization` SET TAGS ('dbx_business_glossary_term' = 'Purchasing Organization');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`blanket_order` ALTER COLUMN `purchasing_organization` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`blanket_order` ALTER COLUMN `quality_requirements` SET TAGS ('dbx_business_glossary_term' = 'Quality Requirements');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`blanket_order` ALTER COLUMN `release_mechanism` SET TAGS ('dbx_business_glossary_term' = 'Release Mechanism');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`blanket_order` ALTER COLUMN `release_mechanism` SET TAGS ('dbx_value_regex' = 'manual|automatic|scheduled|demand_triggered');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`blanket_order` ALTER COLUMN `remaining_quantity` SET TAGS ('dbx_business_glossary_term' = 'Remaining Quantity');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`blanket_order` ALTER COLUMN `remaining_value` SET TAGS ('dbx_business_glossary_term' = 'Remaining Value');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`blanket_order` ALTER COLUMN `shipping_point` SET TAGS ('dbx_business_glossary_term' = 'Shipping Point');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`blanket_order` ALTER COLUMN `sustainability_criteria` SET TAGS ('dbx_business_glossary_term' = 'Sustainability Criteria');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`blanket_order` ALTER COLUMN `tax_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Code');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`blanket_order` ALTER COLUMN `tax_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,6}$');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`blanket_order` ALTER COLUMN `total_committed_quantity` SET TAGS ('dbx_business_glossary_term' = 'Total Committed Quantity');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`blanket_order` ALTER COLUMN `total_committed_value` SET TAGS ('dbx_business_glossary_term' = 'Total Committed Value');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`blanket_order` ALTER COLUMN `total_released_quantity` SET TAGS ('dbx_business_glossary_term' = 'Total Released Quantity');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`blanket_order` ALTER COLUMN `total_released_value` SET TAGS ('dbx_business_glossary_term' = 'Total Released Value');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`blanket_order` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`blanket_order` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,6}$');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`blanket_order` ALTER COLUMN `warranty_terms` SET TAGS ('dbx_business_glossary_term' = 'Warranty Terms');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`blanket_order` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`rate_agreement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`rate_agreement` SET TAGS ('dbx_subdomain' = 'sourcing_agreements');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`rate_agreement` ALTER COLUMN `rate_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Agreement Identifier');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`rate_agreement` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier ID');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`rate_agreement` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`rate_agreement` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`rate_agreement` ALTER COLUMN `driver_safety_program_id` SET TAGS ('dbx_business_glossary_term' = 'Driver Safety Program Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`rate_agreement` ALTER COLUMN `emissions_factor_id` SET TAGS ('dbx_business_glossary_term' = 'Emissions Factor Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`rate_agreement` ALTER COLUMN `position_id` SET TAGS ('dbx_business_glossary_term' = 'Negotiator Position Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`rate_agreement` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Negotiated By User ID');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`rate_agreement` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`rate_agreement` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`rate_agreement` ALTER COLUMN `procurement_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract ID');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`rate_agreement` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`rate_agreement` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`rate_agreement` ALTER COLUMN `transport_document_id` SET TAGS ('dbx_business_glossary_term' = 'Transport Document Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`rate_agreement` ALTER COLUMN `accessorial_charges_included` SET TAGS ('dbx_business_glossary_term' = 'Accessorial Charges Included Flag');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`rate_agreement` ALTER COLUMN `agreement_name` SET TAGS ('dbx_business_glossary_term' = 'Agreement Name');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`rate_agreement` ALTER COLUMN `agreement_number` SET TAGS ('dbx_business_glossary_term' = 'Agreement Number');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`rate_agreement` ALTER COLUMN `agreement_type` SET TAGS ('dbx_business_glossary_term' = 'Agreement Type');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`rate_agreement` ALTER COLUMN `agreement_type` SET TAGS ('dbx_value_regex' = 'spot|contract|framework|volume_commitment|seasonal');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`rate_agreement` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`rate_agreement` ALTER COLUMN `auto_renewal_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto Renewal Flag');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`rate_agreement` ALTER COLUMN `base_rate` SET TAGS ('dbx_business_glossary_term' = 'Base Rate');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`rate_agreement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`rate_agreement` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`rate_agreement` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`rate_agreement` ALTER COLUMN `destination_location_code` SET TAGS ('dbx_business_glossary_term' = 'Destination Location Code');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`rate_agreement` ALTER COLUMN `documentation_fee` SET TAGS ('dbx_business_glossary_term' = 'Documentation Fee');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`rate_agreement` ALTER COLUMN `fuel_surcharge_type` SET TAGS ('dbx_business_glossary_term' = 'Fuel Surcharge Type');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`rate_agreement` ALTER COLUMN `fuel_surcharge_type` SET TAGS ('dbx_value_regex' = 'fixed|percentage|index_linked|baf|caf');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`rate_agreement` ALTER COLUMN `fuel_surcharge_value` SET TAGS ('dbx_business_glossary_term' = 'Fuel Surcharge Value');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`rate_agreement` ALTER COLUMN `gri_clause` SET TAGS ('dbx_business_glossary_term' = 'General Rate Increase (GRI) Clause');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`rate_agreement` ALTER COLUMN `incoterms` SET TAGS ('dbx_business_glossary_term' = 'Incoterms');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`rate_agreement` ALTER COLUMN `lane_description` SET TAGS ('dbx_business_glossary_term' = 'Lane Description');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`rate_agreement` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`rate_agreement` ALTER COLUMN `last_rate_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Rate Review Date');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`rate_agreement` ALTER COLUMN `maximum_charge` SET TAGS ('dbx_business_glossary_term' = 'Maximum Charge');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`rate_agreement` ALTER COLUMN `minimum_charge` SET TAGS ('dbx_business_glossary_term' = 'Minimum Charge');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`rate_agreement` ALTER COLUMN `next_rate_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Rate Review Date');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`rate_agreement` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Agreement Notes');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`rate_agreement` ALTER COLUMN `origin_location_code` SET TAGS ('dbx_business_glossary_term' = 'Origin Location Code');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`rate_agreement` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`rate_agreement` ALTER COLUMN `rate_agreement_status` SET TAGS ('dbx_business_glossary_term' = 'Agreement Status');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`rate_agreement` ALTER COLUMN `rate_agreement_status` SET TAGS ('dbx_value_regex' = 'draft|pending_approval|active|suspended|expired|terminated');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`rate_agreement` ALTER COLUMN `rate_review_frequency` SET TAGS ('dbx_business_glossary_term' = 'Rate Review Frequency');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`rate_agreement` ALTER COLUMN `rate_review_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|semi_annually|annually|none');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`rate_agreement` ALTER COLUMN `rate_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Rate Unit of Measure');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`rate_agreement` ALTER COLUMN `renewal_notice_days` SET TAGS ('dbx_business_glossary_term' = 'Renewal Notice Days');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`rate_agreement` ALTER COLUMN `service_type` SET TAGS ('dbx_business_glossary_term' = 'Service Type');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`rate_agreement` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`rate_agreement` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'SAP_TM|Coupa|Oracle_TMS|manual');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`rate_agreement` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System ID');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`rate_agreement` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`rate_agreement` ALTER COLUMN `termination_reason` SET TAGS ('dbx_business_glossary_term' = 'Termination Reason');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`rate_agreement` ALTER COLUMN `thc_amount` SET TAGS ('dbx_business_glossary_term' = 'Terminal Handling Charge (THC) Amount');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`rate_agreement` ALTER COLUMN `transport_mode` SET TAGS ('dbx_business_glossary_term' = 'Transport Mode');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`rate_agreement` ALTER COLUMN `transport_mode` SET TAGS ('dbx_value_regex' = 'air|ocean|road|rail|multimodal');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`rate_agreement` ALTER COLUMN `valid_from_date` SET TAGS ('dbx_business_glossary_term' = 'Valid From Date');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`rate_agreement` ALTER COLUMN `valid_until_date` SET TAGS ('dbx_business_glossary_term' = 'Valid Until Date');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`rate_agreement` ALTER COLUMN `volume_commitment_period` SET TAGS ('dbx_business_glossary_term' = 'Volume Commitment Period');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`rate_agreement` ALTER COLUMN `volume_commitment_period` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|annually|contract_term');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`rate_agreement` ALTER COLUMN `volume_commitment_quantity` SET TAGS ('dbx_business_glossary_term' = 'Volume Commitment Quantity');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`rate_agreement` ALTER COLUMN `volume_commitment_unit` SET TAGS ('dbx_business_glossary_term' = 'Volume Commitment Unit');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`rate_agreement` ALTER COLUMN `volume_commitment_unit` SET TAGS ('dbx_value_regex' = 'kg|teu|cbm|shipments|pallets');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_performance` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_performance` SET TAGS ('dbx_subdomain' = 'vendor_management');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_performance` ALTER COLUMN `supplier_performance_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Performance ID');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_performance` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_performance` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_performance` ALTER COLUMN `freight_audit_id` SET TAGS ('dbx_business_glossary_term' = 'Freight Audit Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_performance` ALTER COLUMN `hse_incident_id` SET TAGS ('dbx_business_glossary_term' = 'Related Hse Incident Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_performance` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Org Unit Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_performance` ALTER COLUMN `supplier_emissions_disclosure_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Emissions Disclosure Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_performance` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_performance` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_performance` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_performance` ALTER COLUMN `corrective_action_count` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Count');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_performance` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_performance` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_performance` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_performance` ALTER COLUMN `defect_count` SET TAGS ('dbx_business_glossary_term' = 'Defect Count');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_performance` ALTER COLUMN `evaluation_cycle_type` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Cycle Type');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_performance` ALTER COLUMN `evaluation_cycle_type` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|semi-annual|annual|ad-hoc');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_performance` ALTER COLUMN `evaluation_notes` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Notes');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_performance` ALTER COLUMN `evaluation_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Period End Date');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_performance` ALTER COLUMN `evaluation_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Period Start Date');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_performance` ALTER COLUMN `evaluation_status` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Status');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_performance` ALTER COLUMN `evaluation_status` SET TAGS ('dbx_value_regex' = 'draft|in-review|approved|published|archived');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_performance` ALTER COLUMN `evaluator_email` SET TAGS ('dbx_business_glossary_term' = 'Evaluator Email Address');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_performance` ALTER COLUMN `evaluator_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_performance` ALTER COLUMN `evaluator_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_performance` ALTER COLUMN `evaluator_name` SET TAGS ('dbx_business_glossary_term' = 'Evaluator Name');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_performance` ALTER COLUMN `improvement_areas` SET TAGS ('dbx_business_glossary_term' = 'Improvement Areas');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_performance` ALTER COLUMN `invoice_accuracy_rate` SET TAGS ('dbx_business_glossary_term' = 'Invoice Accuracy Rate');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_performance` ALTER COLUMN `invoice_discrepancy_count` SET TAGS ('dbx_business_glossary_term' = 'Invoice Discrepancy Count');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_performance` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_performance` ALTER COLUMN `late_delivery_count` SET TAGS ('dbx_business_glossary_term' = 'Late Delivery Count');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_performance` ALTER COLUMN `otd_rate` SET TAGS ('dbx_business_glossary_term' = 'On-Time Delivery (OTD) Rate');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_performance` ALTER COLUMN `overall_score` SET TAGS ('dbx_business_glossary_term' = 'Overall Performance Score');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_performance` ALTER COLUMN `overall_scorecard_grade` SET TAGS ('dbx_business_glossary_term' = 'Overall Scorecard Grade');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_performance` ALTER COLUMN `overall_scorecard_grade` SET TAGS ('dbx_value_regex' = 'A|B|C|D|F');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_performance` ALTER COLUMN `preferred_supplier_flag` SET TAGS ('dbx_business_glossary_term' = 'Preferred Supplier Flag');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_performance` ALTER COLUMN `published_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Published Timestamp');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_performance` ALTER COLUMN `published_to_supplier_flag` SET TAGS ('dbx_business_glossary_term' = 'Published to Supplier Flag');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_performance` ALTER COLUMN `quality_acceptance_rate` SET TAGS ('dbx_business_glossary_term' = 'Quality Acceptance Rate');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_performance` ALTER COLUMN `renewal_recommendation` SET TAGS ('dbx_business_glossary_term' = 'Renewal Recommendation');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_performance` ALTER COLUMN `renewal_recommendation` SET TAGS ('dbx_value_regex' = 'renew|renew-with-conditions|review|terminate|not-applicable');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_performance` ALTER COLUMN `responsiveness_score` SET TAGS ('dbx_business_glossary_term' = 'Responsiveness Score');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_performance` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Level');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_performance` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_performance` ALTER COLUMN `sla_compliance_score` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Compliance Score');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_performance` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_performance` ALTER COLUMN `strengths` SET TAGS ('dbx_business_glossary_term' = 'Supplier Strengths');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_performance` ALTER COLUMN `supplier_tier` SET TAGS ('dbx_business_glossary_term' = 'Supplier Tier');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_performance` ALTER COLUMN `supplier_tier` SET TAGS ('dbx_value_regex' = 'preferred|approved|conditional|probation|disqualified');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_performance` ALTER COLUMN `sustainability_rating` SET TAGS ('dbx_business_glossary_term' = 'Sustainability Rating');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_performance` ALTER COLUMN `sustainability_rating` SET TAGS ('dbx_value_regex' = 'A|B|C|D|F|not-rated');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_performance` ALTER COLUMN `total_order_value` SET TAGS ('dbx_business_glossary_term' = 'Total Order Value');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_performance` ALTER COLUMN `total_purchase_orders` SET TAGS ('dbx_business_glossary_term' = 'Total Purchase Orders');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`procurement_contract` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`procurement_contract` SET TAGS ('dbx_subdomain' = 'sourcing_agreements');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`procurement_contract` ALTER COLUMN `procurement_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Procurement Contract ID');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`procurement_contract` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approver ID');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`procurement_contract` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`procurement_contract` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`procurement_contract` ALTER COLUMN `carbon_offset_program_id` SET TAGS ('dbx_business_glossary_term' = 'Carbon Offset Program Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`procurement_contract` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`procurement_contract` ALTER COLUMN `chart_of_accounts_id` SET TAGS ('dbx_business_glossary_term' = 'Chart Of Accounts Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`procurement_contract` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`procurement_contract` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`procurement_contract` ALTER COLUMN `emissions_factor_id` SET TAGS ('dbx_business_glossary_term' = 'Emissions Factor Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`procurement_contract` ALTER COLUMN `owner_employee_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`procurement_contract` ALTER COLUMN `position_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Owner Position Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`procurement_contract` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Network Partner Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`procurement_contract` ALTER COLUMN `procurement_contract_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Owner ID');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`procurement_contract` ALTER COLUMN `procurement_contract_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`procurement_contract` ALTER COLUMN `procurement_contract_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`procurement_contract` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Safety Program Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`procurement_contract` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`procurement_contract` ALTER COLUMN `supplier_site_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Site ID');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`procurement_contract` ALTER COLUMN `tpl_provider_id` SET TAGS ('dbx_business_glossary_term' = 'Tpl Provider Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`procurement_contract` ALTER COLUMN `trade_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Agreement Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`procurement_contract` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`procurement_contract` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`procurement_contract` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`procurement_contract` ALTER COLUMN `auto_renewal_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto Renewal Flag');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`procurement_contract` ALTER COLUMN `business_unit` SET TAGS ('dbx_business_glossary_term' = 'Business Unit');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`procurement_contract` ALTER COLUMN `compliance_certifications_required` SET TAGS ('dbx_business_glossary_term' = 'Compliance Certifications Required');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`procurement_contract` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Level');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`procurement_contract` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_value_regex' = 'public|internal|confidential|restricted');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`procurement_contract` ALTER COLUMN `contract_number` SET TAGS ('dbx_business_glossary_term' = 'Contract Number');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`procurement_contract` ALTER COLUMN `contract_status` SET TAGS ('dbx_business_glossary_term' = 'Contract Status');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`procurement_contract` ALTER COLUMN `contract_type` SET TAGS ('dbx_business_glossary_term' = 'Contract Type');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`procurement_contract` ALTER COLUMN `contract_type` SET TAGS ('dbx_value_regex' = 'master_supply_agreement|service_level_agreement|carrier_contract|maintenance_contract|spot_purchase|framework_agreement');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`procurement_contract` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`procurement_contract` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`procurement_contract` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`procurement_contract` ALTER COLUMN `delivery_terms` SET TAGS ('dbx_business_glossary_term' = 'Delivery Terms');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`procurement_contract` ALTER COLUMN `dispute_resolution_method` SET TAGS ('dbx_business_glossary_term' = 'Dispute Resolution Method');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`procurement_contract` ALTER COLUMN `dispute_resolution_method` SET TAGS ('dbx_value_regex' = 'litigation|arbitration|mediation|negotiation');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`procurement_contract` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`procurement_contract` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`procurement_contract` ALTER COLUMN `governing_law` SET TAGS ('dbx_business_glossary_term' = 'Governing Law');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`procurement_contract` ALTER COLUMN `incoterm` SET TAGS ('dbx_business_glossary_term' = 'Incoterms (International Commercial Terms)');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`procurement_contract` ALTER COLUMN `insurance_requirements` SET TAGS ('dbx_business_glossary_term' = 'Insurance Requirements');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`procurement_contract` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`procurement_contract` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time Days');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`procurement_contract` ALTER COLUMN `maximum_order_value` SET TAGS ('dbx_business_glossary_term' = 'Maximum Order Value');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`procurement_contract` ALTER COLUMN `minimum_order_value` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Value (MOV)');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`procurement_contract` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`procurement_contract` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`procurement_contract` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'bank_transfer|check|credit_card|ach|wire_transfer|letter_of_credit');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`procurement_contract` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`procurement_contract` ALTER COLUMN `penalty_clause` SET TAGS ('dbx_business_glossary_term' = 'Penalty Clause');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`procurement_contract` ALTER COLUMN `penalty_clause` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`procurement_contract` ALTER COLUMN `procurement_contract_category` SET TAGS ('dbx_business_glossary_term' = 'Procurement Category');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`procurement_contract` ALTER COLUMN `renewal_notice_period_days` SET TAGS ('dbx_business_glossary_term' = 'Renewal Notice Period Days');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`procurement_contract` ALTER COLUMN `signed_date` SET TAGS ('dbx_business_glossary_term' = 'Signed Date');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`procurement_contract` ALTER COLUMN `sla_target_delivery_days` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Target Delivery Days');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`procurement_contract` ALTER COLUMN `sla_uptime_percentage` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Uptime Percentage');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`procurement_contract` ALTER COLUMN `subcategory` SET TAGS ('dbx_business_glossary_term' = 'Procurement Subcategory');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`procurement_contract` ALTER COLUMN `termination_clause` SET TAGS ('dbx_business_glossary_term' = 'Termination Clause');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`procurement_contract` ALTER COLUMN `termination_clause` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`procurement_contract` ALTER COLUMN `termination_notice_period_days` SET TAGS ('dbx_business_glossary_term' = 'Termination Notice Period Days');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`procurement_contract` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Contract Title');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`procurement_contract` ALTER COLUMN `total_contract_value` SET TAGS ('dbx_business_glossary_term' = 'Total Contract Value');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`procurement_contract` ALTER COLUMN `total_contract_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`procurement_contract` ALTER COLUMN `warranty_terms` SET TAGS ('dbx_business_glossary_term' = 'Warranty Terms');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`procurement_approval_workflow` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`procurement_approval_workflow` SET TAGS ('dbx_subdomain' = 'order_fulfillment');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`procurement_approval_workflow` ALTER COLUMN `procurement_approval_workflow_id` SET TAGS ('dbx_business_glossary_term' = 'Procurement Approval Workflow ID');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`procurement_approval_workflow` ALTER COLUMN `approval_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Approval Rule ID');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`procurement_approval_workflow` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approver Employee ID');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`procurement_approval_workflow` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`procurement_approval_workflow` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`procurement_approval_workflow` ALTER COLUMN `primary_procurement_delegated_to_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Delegated To Employee ID');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`procurement_approval_workflow` ALTER COLUMN `primary_procurement_delegated_to_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`procurement_approval_workflow` ALTER COLUMN `primary_procurement_delegated_to_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`procurement_approval_workflow` ALTER COLUMN `requester_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Requester Employee ID');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`procurement_approval_workflow` ALTER COLUMN `requester_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`procurement_approval_workflow` ALTER COLUMN `requester_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`procurement_approval_workflow` ALTER COLUMN `approval_session_id` SET TAGS ('dbx_business_glossary_term' = 'Session ID');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`procurement_approval_workflow` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`procurement_approval_workflow` ALTER COLUMN `action_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Action Timestamp');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`procurement_approval_workflow` ALTER COLUMN `approval_action` SET TAGS ('dbx_business_glossary_term' = 'Approval Action');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`procurement_approval_workflow` ALTER COLUMN `approval_comments` SET TAGS ('dbx_business_glossary_term' = 'Approval Comments');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`procurement_approval_workflow` ALTER COLUMN `approval_level` SET TAGS ('dbx_business_glossary_term' = 'Approval Level');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`procurement_approval_workflow` ALTER COLUMN `approval_method` SET TAGS ('dbx_business_glossary_term' = 'Approval Method');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`procurement_approval_workflow` ALTER COLUMN `approval_method` SET TAGS ('dbx_value_regex' = 'web_portal|email|mobile_app|api|system_auto');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`procurement_approval_workflow` ALTER COLUMN `approval_rule_name` SET TAGS ('dbx_business_glossary_term' = 'Approval Rule Name');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`procurement_approval_workflow` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`procurement_approval_workflow` ALTER COLUMN `approval_step_sequence` SET TAGS ('dbx_business_glossary_term' = 'Approval Step Sequence');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`procurement_approval_workflow` ALTER COLUMN `approval_threshold_amount` SET TAGS ('dbx_business_glossary_term' = 'Approval Threshold Amount');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`procurement_approval_workflow` ALTER COLUMN `approval_threshold_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Approval Threshold Currency Code');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`procurement_approval_workflow` ALTER COLUMN `approval_threshold_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`procurement_approval_workflow` ALTER COLUMN `approver_email` SET TAGS ('dbx_business_glossary_term' = 'Approver Email Address');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`procurement_approval_workflow` ALTER COLUMN `approver_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`procurement_approval_workflow` ALTER COLUMN `approver_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`procurement_approval_workflow` ALTER COLUMN `approver_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`procurement_approval_workflow` ALTER COLUMN `approver_name` SET TAGS ('dbx_business_glossary_term' = 'Approver Name');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`procurement_approval_workflow` ALTER COLUMN `approver_role` SET TAGS ('dbx_business_glossary_term' = 'Approver Role');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`procurement_approval_workflow` ALTER COLUMN `assigned_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Assigned Timestamp');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`procurement_approval_workflow` ALTER COLUMN `business_unit_code` SET TAGS ('dbx_business_glossary_term' = 'Business Unit Code');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`procurement_approval_workflow` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`procurement_approval_workflow` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`procurement_approval_workflow` ALTER COLUMN `delegated_to_name` SET TAGS ('dbx_business_glossary_term' = 'Delegated To Name');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`procurement_approval_workflow` ALTER COLUMN `delegation_reason` SET TAGS ('dbx_business_glossary_term' = 'Delegation Reason');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`procurement_approval_workflow` ALTER COLUMN `document_amount` SET TAGS ('dbx_business_glossary_term' = 'Document Amount');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`procurement_approval_workflow` ALTER COLUMN `document_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Document Currency Code');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`procurement_approval_workflow` ALTER COLUMN `document_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`procurement_approval_workflow` ALTER COLUMN `document_reference_code` SET TAGS ('dbx_business_glossary_term' = 'Document Reference ID');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`procurement_approval_workflow` ALTER COLUMN `document_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Document Reference Number');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`procurement_approval_workflow` ALTER COLUMN `document_type` SET TAGS ('dbx_business_glossary_term' = 'Document Type');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`procurement_approval_workflow` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Due Date');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`procurement_approval_workflow` ALTER COLUMN `escalated_to_name` SET TAGS ('dbx_business_glossary_term' = 'Escalated To Name');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`procurement_approval_workflow` ALTER COLUMN `escalation_reason` SET TAGS ('dbx_business_glossary_term' = 'Escalation Reason');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`procurement_approval_workflow` ALTER COLUMN `ip_address` SET TAGS ('dbx_business_glossary_term' = 'IP Address');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`procurement_approval_workflow` ALTER COLUMN `ip_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`procurement_approval_workflow` ALTER COLUMN `ip_address` SET TAGS ('dbx_pii_ip' = 'true');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`procurement_approval_workflow` ALTER COLUMN `is_mandatory_approval` SET TAGS ('dbx_business_glossary_term' = 'Is Mandatory Approval');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`procurement_approval_workflow` ALTER COLUMN `is_parallel_approval` SET TAGS ('dbx_business_glossary_term' = 'Is Parallel Approval');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`procurement_approval_workflow` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`procurement_approval_workflow` ALTER COLUMN `last_reminder_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Reminder Timestamp');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`procurement_approval_workflow` ALTER COLUMN `notification_sent_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Notification Sent Timestamp');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`procurement_approval_workflow` ALTER COLUMN `procurement_category` SET TAGS ('dbx_business_glossary_term' = 'Procurement Category');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`procurement_approval_workflow` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`procurement_approval_workflow` ALTER COLUMN `reminder_count` SET TAGS ('dbx_business_glossary_term' = 'Reminder Count');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`carbon_offset_procurement_agreement` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`carbon_offset_procurement_agreement` SET TAGS ('dbx_subdomain' = 'sourcing_agreements');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`carbon_offset_procurement_agreement` SET TAGS ('dbx_association_edges' = 'procurement.supplier,sustainability.carbon_offset_program');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`carbon_offset_procurement_agreement` ALTER COLUMN `carbon_offset_procurement_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Carbon Offset Procurement Agreement ID');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`carbon_offset_procurement_agreement` ALTER COLUMN `carbon_offset_program_id` SET TAGS ('dbx_business_glossary_term' = 'Carbon Offset Program ID');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`carbon_offset_procurement_agreement` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Carbon Offset Procurement Agreement - Supplier Id');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`carbon_offset_procurement_agreement` ALTER COLUMN `agreement_status` SET TAGS ('dbx_business_glossary_term' = 'Agreement Status');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`carbon_offset_procurement_agreement` ALTER COLUMN `committed_volume_tco2e` SET TAGS ('dbx_business_glossary_term' = 'Committed Volume (tCO2e)');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`carbon_offset_procurement_agreement` ALTER COLUMN `contract_end_date` SET TAGS ('dbx_business_glossary_term' = 'Contract End Date');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`carbon_offset_procurement_agreement` ALTER COLUMN `contract_start_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Start Date');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`carbon_offset_procurement_agreement` ALTER COLUMN `created_date` SET TAGS ('dbx_business_glossary_term' = 'Created Date');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`carbon_offset_procurement_agreement` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`carbon_offset_procurement_agreement` ALTER COLUMN `delivery_schedule` SET TAGS ('dbx_business_glossary_term' = 'Delivery Schedule');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`carbon_offset_procurement_agreement` ALTER COLUMN `last_modified_date` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Date');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`carbon_offset_procurement_agreement` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time (Days)');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`carbon_offset_procurement_agreement` ALTER COLUMN `minimum_order_quantity_tco2e` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity (tCO2e)');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`carbon_offset_procurement_agreement` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`carbon_offset_procurement_agreement` ALTER COLUMN `procurement_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Procurement Contact Email');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`carbon_offset_procurement_agreement` ALTER COLUMN `procurement_contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`carbon_offset_procurement_agreement` ALTER COLUMN `procurement_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`carbon_offset_procurement_agreement` ALTER COLUMN `procurement_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Procurement Contact Name');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`carbon_offset_procurement_agreement` ALTER COLUMN `procurement_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`carbon_offset_procurement_agreement` ALTER COLUMN `procurement_contact_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`carbon_offset_procurement_agreement` ALTER COLUMN `procurement_method` SET TAGS ('dbx_business_glossary_term' = 'Procurement Method');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`carbon_offset_procurement_agreement` ALTER COLUMN `procurement_method` SET TAGS ('dbx_value_regex' = 'Direct Purchase|Broker|Exchange|Auction|Forward Contract');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`carbon_offset_procurement_agreement` ALTER COLUMN `quality_standard` SET TAGS ('dbx_business_glossary_term' = 'Quality Standard');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`carbon_offset_procurement_agreement` ALTER COLUMN `unit_price` SET TAGS ('dbx_business_glossary_term' = 'Unit Price');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`carbon_offset_procurement_agreement` ALTER COLUMN `vintage_year_preference` SET TAGS ('dbx_business_glossary_term' = 'Vintage Year Preference');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`contracted_service` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`contracted_service` SET TAGS ('dbx_subdomain' = 'sourcing_agreements');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`contracted_service` SET TAGS ('dbx_association_edges' = 'procurement.procurement_contract,network.carrier_service');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`contracted_service` ALTER COLUMN `contracted_service_id` SET TAGS ('dbx_business_glossary_term' = 'Contracted Service Identifier');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`contracted_service` ALTER COLUMN `carrier_service_id` SET TAGS ('dbx_business_glossary_term' = 'Contracted Service - Carrier Service Id');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`contracted_service` ALTER COLUMN `procurement_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contracted Service - Procurement Contract Id');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`contracted_service` ALTER COLUMN `allocation_priority` SET TAGS ('dbx_business_glossary_term' = 'Allocation Priority');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`contracted_service` ALTER COLUMN `contract_status` SET TAGS ('dbx_business_glossary_term' = 'Contract Status');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`contracted_service` ALTER COLUMN `contracted_rate` SET TAGS ('dbx_business_glossary_term' = 'Contracted Rate');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`contracted_service` ALTER COLUMN `contracted_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`contracted_service` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`contracted_service` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`contracted_service` ALTER COLUMN `fuel_surcharge_applicable` SET TAGS ('dbx_business_glossary_term' = 'Fuel Surcharge Applicable');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`contracted_service` ALTER COLUMN `fuel_surcharge_formula` SET TAGS ('dbx_business_glossary_term' = 'Fuel Surcharge Formula');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`contracted_service` ALTER COLUMN `minimum_charge` SET TAGS ('dbx_business_glossary_term' = 'Minimum Charge');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`contracted_service` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`contracted_service` ALTER COLUMN `peak_season_surcharge_applicable` SET TAGS ('dbx_business_glossary_term' = 'Peak Season Surcharge Applicable');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`contracted_service` ALTER COLUMN `rate_unit` SET TAGS ('dbx_business_glossary_term' = 'Rate Unit');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`contracted_service` ALTER COLUMN `service_level_target` SET TAGS ('dbx_business_glossary_term' = 'Service Level Target');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`contracted_service` ALTER COLUMN `volume_commitment` SET TAGS ('dbx_business_glossary_term' = 'Volume Commitment');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`contracted_service` ALTER COLUMN `volume_commitment_period` SET TAGS ('dbx_business_glossary_term' = 'Volume Commitment Period');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`contracted_service` ALTER COLUMN `volume_commitment_unit` SET TAGS ('dbx_business_glossary_term' = 'Volume Commitment Unit');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`contract_sustainability_contribution` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`contract_sustainability_contribution` SET TAGS ('dbx_subdomain' = 'sourcing_agreements');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`contract_sustainability_contribution` SET TAGS ('dbx_association_edges' = 'procurement.procurement_contract,sustainability.sustainability_target');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`contract_sustainability_contribution` ALTER COLUMN `contract_sustainability_contribution_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Sustainability Contribution ID');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`contract_sustainability_contribution` ALTER COLUMN `procurement_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Sustainability Contribution - Procurement Contract Id');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`contract_sustainability_contribution` ALTER COLUMN `target_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Sustainability Contribution - Sustainability Target Id');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`contract_sustainability_contribution` ALTER COLUMN `baseline_year` SET TAGS ('dbx_business_glossary_term' = 'Contribution Baseline Year');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`contract_sustainability_contribution` ALTER COLUMN `contribution_end_date` SET TAGS ('dbx_business_glossary_term' = 'Contribution End Date');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`contract_sustainability_contribution` ALTER COLUMN `contribution_start_date` SET TAGS ('dbx_business_glossary_term' = 'Contribution Start Date');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`contract_sustainability_contribution` ALTER COLUMN `contribution_status` SET TAGS ('dbx_business_glossary_term' = 'Contribution Status');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`contract_sustainability_contribution` ALTER COLUMN `last_reported_date` SET TAGS ('dbx_business_glossary_term' = 'Last Reported Date');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`contract_sustainability_contribution` ALTER COLUMN `last_reported_value` SET TAGS ('dbx_business_glossary_term' = 'Last Reported Value');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`contract_sustainability_contribution` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Contribution Notes');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`contract_sustainability_contribution` ALTER COLUMN `penalty_clause` SET TAGS ('dbx_business_glossary_term' = 'Sustainability Penalty Clause');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`contract_sustainability_contribution` ALTER COLUMN `reduction_commitment_tco2e` SET TAGS ('dbx_business_glossary_term' = 'Reduction Commitment in tCO2e');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`contract_sustainability_contribution` ALTER COLUMN `reporting_frequency` SET TAGS ('dbx_business_glossary_term' = 'Reporting Frequency');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`contract_sustainability_contribution` ALTER COLUMN `sustainability_requirements` SET TAGS ('dbx_business_glossary_term' = 'Sustainability Requirements');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`contract_sustainability_contribution` ALTER COLUMN `target_contribution_percentage` SET TAGS ('dbx_business_glossary_term' = 'Target Contribution Percentage');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`contract_sustainability_contribution` ALTER COLUMN `verification_method` SET TAGS ('dbx_business_glossary_term' = 'Verification Method');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`item` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`item` SET TAGS ('dbx_subdomain' = 'order_fulfillment');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`item` ALTER COLUMN `item_id` SET TAGS ('dbx_business_glossary_term' = 'Item Identifier');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`item` ALTER COLUMN `parent_item_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`approval_rule` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`approval_rule` SET TAGS ('dbx_subdomain' = 'order_fulfillment');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`approval_rule` ALTER COLUMN `approval_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Approval Rule Identifier');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`approval_rule` ALTER COLUMN `parent_approval_rule_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`approval_session` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`approval_session` SET TAGS ('dbx_subdomain' = 'order_fulfillment');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`approval_session` ALTER COLUMN `approval_session_id` SET TAGS ('dbx_business_glossary_term' = 'Approval Session Identifier');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`approval_session` ALTER COLUMN `trade_document_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`approval_session` ALTER COLUMN `trade_document_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`approval_session` ALTER COLUMN `employee_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`approval_session` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`approval_session` ALTER COLUMN `reopened_approval_session_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`approval_session` ALTER COLUMN `approval_last_action_by` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`approval_session` ALTER COLUMN `approval_last_action_by` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`approval_session` ALTER COLUMN `initiator_user_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`approval_session` ALTER COLUMN `initiator_user_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`approval_session` ALTER COLUMN `initiator_user_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`approval_session` ALTER COLUMN `initiator_user_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`approval_session` ALTER COLUMN `initiator_user_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`approval_session` ALTER COLUMN `initiator_user_phone` SET TAGS ('dbx_pii_phone' = 'true');
