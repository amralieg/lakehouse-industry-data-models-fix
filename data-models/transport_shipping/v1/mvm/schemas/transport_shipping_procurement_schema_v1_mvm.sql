-- Schema for Domain: procurement | Business: Transport Shipping | Version: v1_mvm
-- Generated on: 2026-05-08 22:35:07

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `transport_shipping_ecm`.`procurement` COMMENT 'Manages sourcing, supplier onboarding, purchase order lifecycle, carrier procurement, and spend management for operational and capital expenditures. Owns supplier master, RFQ/RFP processes, purchase orders, invoice matching, and contract compliance monitoring. Powered by Coupa and integrates with SAP S/4HANA Finance for budget control and with fleet and warehouse domains for asset procurement.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `transport_shipping_ecm`.`procurement`.`supplier` (
    `supplier_id` BIGINT COMMENT 'Unique identifier for the supplier record. Primary key.',
    `agent_id` BIGINT COMMENT 'Foreign key linking to network.agent. Business justification: Suppliers in international trade often designate customs brokers or freight forwarders (agents) for cross-border shipments. Tracks the preferred agent relationship for customs clearance coordination, ',
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
    `network_node_id` BIGINT COMMENT 'Foreign key linking to route.network_node. Business justification: Supplier sites must map to logistics network nodes for inbound routing, transit time calculation, lane assignment, and network planning. Essential for procurement to evaluate supplier locations agains',
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
    `partner_id` BIGINT COMMENT 'Foreign key linking to network.partner. Business justification: Supplier qualification includes vetting logistics partners (warehouses, consolidators, freight forwarders) in the suppliers distribution network for supply chain risk assessment, security screening (',
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
    `agent_id` BIGINT COMMENT 'Foreign key linking to network.agent. Business justification: RFQs for international freight often target freight forwarders or customs brokers (agents) for quotes on customs clearance, forwarding services, and door-to-door delivery. Essential for sourcing logis',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to contract.agreement. Business justification: RFQs issued under master agreements. Business process: sourcing events often occur within framework of existing master agreements that define pre-qualified suppliers, terms, and pricing structures for',
    `supplier_id` BIGINT COMMENT 'Identifier of the supplier who was awarded the business as a result of this RFQ. Null if RFQ is not yet awarded or was cancelled.',
    `carrier_id` BIGINT COMMENT 'Foreign key linking to network.carrier. Business justification: RFQs issued to carriers for freight rate quotes on specific lanes/services; standard freight procurement process. Enables carrier rate comparison, bid analysis, and award decisions. Tracks which carri',
    `lane_id` BIGINT COMMENT 'Foreign key linking to route.lane. Business justification: RFQs for freight and logistics services must specify the lane (origin-destination pair) to enable accurate carrier quoting. Freight RFQs without lane context cannot be priced. Standard procurement pra',
    `service_corridor_id` BIGINT COMMENT 'Foreign key linking to route.service_corridor. Business justification: RFQs for major trade lane services (e.g., Asia-Europe ocean freight, air express corridors) reference service corridors to define multi-modal service scope, transit commitments, and capacity requireme',
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
    `agent_id` BIGINT COMMENT 'Foreign key linking to network.agent. Business justification: Quotes from agents (freight forwarders, customs brokers) for logistics services related to procurement—customs clearance, import handling, last-mile delivery. Required for total landed cost evaluation',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to contract.agreement. Business justification: Supplier quotes reference master agreement terms. Business process: quotes submitted under existing rate agreements or framework contracts need to reference parent agreement for terms inheritance and ',
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
    `agent_id` BIGINT COMMENT 'Foreign key linking to network.agent. Business justification: POs may designate a customs broker or freight forwarder (agent) for handling import clearance and delivery coordination. Critical for international procurement where agent manages customs compliance a',
    `carrier_id` BIGINT COMMENT 'Foreign key linking to network.carrier. Business justification: Freight procurement POs specify carrier for transport services; essential for carrier spend analysis, contract compliance verification, and freight audit. Standard logistics procurement practice to tr',
    `facility_id` BIGINT COMMENT 'Foreign key linking to warehouse.facility. Business justification: POs specify a destination receiving facility — fundamental for inbound routing, dock scheduling, capacity planning, and facility-level procurement reporting. A logistics procurement expert expects eve',
    `lane_id` BIGINT COMMENT 'Foreign key linking to route.lane. Business justification: Inbound POs from suppliers require lane assignment for contracted routing, rate application, and transit time commitment. Procurement teams select lanes when planning supplier deliveries. The existing',
    `rfq_id` BIGINT COMMENT 'Foreign key linking to procurement.rfq. Business justification: A purchase order is typically the downstream outcome of a sourcing event (RFQ/RFP). Linking purchase_order.rfq_id → rfq.rfq_id provides end-to-end sourcing traceability: from internal demand (purchase',
    `supplier_id` BIGINT COMMENT 'Reference to the supplier receiving this purchase order.',
    `supplier_quote_id` BIGINT COMMENT 'Foreign key linking to procurement.supplier_quote. Business justification: A purchase order is issued against the winning supplier quote from the RFQ process. Linking purchase_order.supplier_quote_id → supplier_quote.supplier_quote_id captures which specific quote was accept',
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
    `carrier_id` BIGINT COMMENT 'Foreign key linking to network.carrier. Business justification: PO lines specify the carrier for inbound freight, especially under FOB origin terms where buyer controls transport. Required for freight cost allocation, carrier selection compliance, and inbound logi',
    `item_id` BIGINT COMMENT 'Reference to the master item or material being procured. Links to the product/service catalog entry.',
    `purchase_order_id` BIGINT COMMENT 'Reference to the parent purchase order header. Links this line item to its containing purchase order document.',
    `purchase_requisition_id` BIGINT COMMENT 'Reference to the originating purchase requisition line that triggered this PO line. Provides traceability from demand to procurement.',
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
    `bill_of_lading_id` BIGINT COMMENT 'Foreign key linking to freight.bill_of_lading. Business justification: Three-way match process (PO + goods receipt + supplier invoice) in ocean freight requires the bill of lading as the transport document proving shipment and delivery. AP teams and customs compliance te',
    `carrier_id` BIGINT COMMENT 'Foreign key linking to network.carrier. Business justification: Inbound shipments are delivered by carriers. Goods receipt must record which carrier performed the delivery for freight reconciliation, damage claims, carrier performance tracking, and proof-of-delive',
    `consignment_id` BIGINT COMMENT 'Reference to the inbound shipment or freight delivery that transported the goods to the receiving location, linking receipt to logistics tracking.',
    `declaration_id` BIGINT COMMENT 'Foreign key linking to customs.declaration. Business justification: Goods receipts are matched to customs release documents for inventory booking and duty allocation. Warehouse teams reconcile physical receipt against customs clearance for landed cost accounting and c',
    `declaration_line_id` BIGINT COMMENT 'Foreign key linking to customs.declaration_line. Business justification: Goods receipts must link to specific declaration lines for three-way matching (PO-GR-customs declaration) on imported goods. Critical for verifying received quantities match customs-cleared quantities',
    `facility_id` BIGINT COMMENT 'Foreign key linking to warehouse.facility. Business justification: Goods receipts occur at specific warehouse facilities; essential for location-based receipt tracking, inventory positioning, and facility-level procurement performance reporting. Enables accurate mult',
    `freight_order_id` BIGINT COMMENT 'Foreign key linking to freight.freight_order. Business justification: Goods receipts for inbound shipments must reference the freight order that delivered the goods. Essential for three-way matching (PO-GR-Invoice) and freight cost allocation to received inventory. Stan',
    `inbound_receipt_id` BIGINT COMMENT 'Foreign key linking to warehouse.inbound_receipt. Business justification: Three-way matching (PO-GR-Invoice) requires linking procurements goods receipt to warehouses physical inbound receipt. Critical for invoice verification, discrepancy resolution, and financial reconc',
    `invoice_id` BIGINT COMMENT 'Reference to the supplier invoice that has been matched to this goods receipt for payment processing. Null if invoice not yet received or matched.',
    `po_line_id` BIGINT COMMENT 'Reference to the specific line item on the purchase order being received.',
    `purchase_order_id` BIGINT COMMENT 'Reference to the purchase order against which goods are being received.',
    `storage_location_id` BIGINT COMMENT 'Foreign key linking to warehouse.storage_location. Business justification: Goods receipts record the physical storage location where goods are placed. A proper FK to storage_location enables directed putaway confirmation, inventory position updates, and quality inspection lo',
    `supplier_id` BIGINT COMMENT 'Reference to the supplier or vendor who provided the goods or services being received.',
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
    `three_way_match_status` STRING COMMENT 'Status of the three-way match process comparing purchase order, goods receipt, and supplier invoice: matched (all align within tolerance), quantity variance (receipt quantity differs), price variance (invoice price differs), not matched (significant discrepancies), or pending (invoice not yet received).. Valid values are `matched|quantity_variance|price_variance|not_matched|pending`',
    `unit_of_measure` STRING COMMENT 'The unit in which quantities are expressed (e.g., EA for each, KG for kilograms, LTR for liters, BOX, PALLET). Must match the purchase order line UOM.',
    CONSTRAINT pk_goods_receipt PRIMARY KEY(`goods_receipt_id`)
) COMMENT 'Records the physical or electronic receipt of goods and services against a purchase order line. Captures GR number, receipt date, received quantity, accepted quantity, rejected quantity, rejection reason, receiving location (warehouse, depot, hub), receiver employee ID, and three-way match status. Critical for accounts payable invoice matching and inventory replenishment confirmation. Sourced from Coupa and Manhattan WMS receiving workflows.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`procurement`.`supplier_invoice` (
    `supplier_invoice_id` BIGINT COMMENT 'Unique identifier for the supplier invoice record. Primary key.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to contract.agreement. Business justification: Supplier invoices reference master agreements. Business process: invoice validation requires checking against master agreement terms, negotiated rates, surcharge schedules, and payment terms for three',
    `carrier_id` BIGINT COMMENT 'Foreign key linking to network.carrier. Business justification: Freight invoices from carriers for inbound shipments are processed as supplier invoices. Links invoice to the carrier that provided the transport service for freight audit, accrual matching, and carri',
    `declaration_id` BIGINT COMMENT 'Foreign key linking to customs.declaration. Business justification: Supplier invoices are key valuation documents attached to customs declarations. Customs brokers and valuation teams verify invoice amounts against declared values for transaction value method complian',
    `duty_assessment_id` BIGINT COMMENT 'Foreign key linking to customs.duty_assessment. Business justification: Supplier invoices are matched to duty assessments for landed cost accounting. AP teams allocate duty charges to invoices for total cost capture, enabling accurate COGS calculation and supplier cost an',
    `freight_charge_id` BIGINT COMMENT 'Foreign key linking to freight.freight_charge. Business justification: Freight audit and invoice matching: a carrier/3PL supplier invoice must be reconciled against specific freight charges for cost verification before payment approval. Logistics finance teams perform li',
    `goods_receipt_id` BIGINT COMMENT 'Reference to the goods receipt or service entry sheet confirming delivery. Critical component of three-way match process. Null for service invoices without formal receipt.',
    `inbound_receipt_id` BIGINT COMMENT 'Foreign key linking to warehouse.inbound_receipt. Business justification: Invoice verification requires direct link to warehouse physical receipt for three-way match completion. Enables automated matching of invoice quantities/values against actual received goods, critical ',
    `purchase_order_id` BIGINT COMMENT 'Reference to the purchase order against which this invoice is submitted. Used for three-way match validation (PO, goods receipt, invoice). Null for non-PO invoices.',
    `supplier_id` BIGINT COMMENT 'Reference to the supplier who submitted this invoice. Links to supplier master data for vendor details, payment information, and compliance status.',
    `supplier_site_id` BIGINT COMMENT 'Foreign key linking to procurement.supplier_site. Business justification: Supplier invoices are submitted from and remitted to a specific supplier site. The supplier_site contains bank account details, payment currency, and contact information needed for payment processing.',
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
    `agreement_id` BIGINT COMMENT 'Foreign key linking to contract.agreement. Business justification: Requisitions reference preferred agreements. Business process: requisition-to-PO conversion should leverage existing master agreements for faster processing, pre-negotiated terms, and compliance with ',
    `facility_id` BIGINT COMMENT 'Foreign key linking to warehouse.facility. Business justification: Purchase requisitions specify a delivery facility for demand fulfillment. A proper FK to facility enables facility-level demand aggregation, procurement planning by location, and inventory replenishme',
    `item_id` BIGINT COMMENT 'Foreign key linking to procurement.item. Business justification: A purchase requisition specifies what item is being requested. The item master is a reference table in procurement. This normalizes the item reference on the requisition, enabling catalog-based orderi',
    `supplier_id` BIGINT COMMENT 'Identifier of the supplier preferred by the requestor for fulfilling this requisition.',
    `purchase_order_id` BIGINT COMMENT 'Identifier of the purchase order created from this requisition, if conversion outcome is converted_to_po.',
    `rfq_id` BIGINT COMMENT 'Identifier of the sourcing event (RFQ or RFP) created from this requisition, if routed to sourcing.',
    `sku_id` BIGINT COMMENT 'Foreign key linking to warehouse.sku. Business justification: Requisitions for inventory replenishment must reference specific warehouse SKUs to trigger accurate reordering. Essential for min-max replenishment, safety stock management, and linking procurement de',
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

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`procurement`.`item` (
    `item_id` BIGINT COMMENT 'Primary key for item',
    `parent_item_id` BIGINT COMMENT 'Self-referencing FK on item (parent_item_id)',
    `sku_id` BIGINT COMMENT 'Foreign key linking to warehouse.sku. Business justification: Procurement item master maps to WMS SKU — the catalog-to-inventory link enabling item-level inventory visibility, reorder point management, and catalog synchronization. po_line.sku_id exists at line l',
    CONSTRAINT pk_item PRIMARY KEY(`item_id`)
) COMMENT 'Master reference table for item. Referenced by item_id.';

CREATE OR REPLACE TABLE `transport_shipping_ecm`.`procurement`.`supply_agreement` (
    `supply_agreement_id` BIGINT COMMENT 'Unique identifier for this supply agreement record. Primary key.',
    `item_id` BIGINT COMMENT 'Foreign key linking to the item that is supplied under this agreement',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to the supplier who provides the item under this agreement',
    `approval_status` STRING COMMENT 'Current approval status of this supply agreement in the approved supplier list workflow. Values: pending, approved, suspended, expired.',
    `contract_price` DECIMAL(18,2) COMMENT 'The contracted price for this item from this supplier, which may differ from the current unit_price due to volume discounts or promotional pricing. Explicitly identified in detection phase relationship data.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this supply agreement record was first created in the system.',
    `effective_from_date` DATE COMMENT 'The date from which this supply agreement pricing and terms become effective. Supports historical tracking of supplier-item relationships. Explicitly identified in detection phase relationship data.',
    `effective_to_date` DATE COMMENT 'The date until which this supply agreement pricing and terms remain effective. Null indicates currently active agreement. Supports historical tracking. Explicitly identified in detection phase relationship data.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this supply agreement record was last modified.',
    `lead_time_days` BIGINT COMMENT 'The number of days from order placement to delivery for this item from this supplier. Varies by supplier-item combination. Explicitly identified in detection phase relationship data.',
    `minimum_order_quantity` BIGINT COMMENT 'The minimum quantity that must be ordered for this item from this supplier. Varies by supplier-item combination. Explicitly identified in detection phase relationship data.',
    `preferred_flag` BOOLEAN COMMENT 'Indicates whether this supplier is the preferred source for this specific item. An item may have multiple approved suppliers but only one preferred. Explicitly identified in detection phase relationship data.',
    `unit_price` DECIMAL(18,2) COMMENT 'The negotiated price per unit for this item from this supplier. Varies by supplier-item combination and is a core attribute of the supply agreement. Explicitly identified in detection phase relationship data.',
    CONSTRAINT pk_supply_agreement PRIMARY KEY(`supply_agreement_id`)
) COMMENT 'This association product represents the contractual supply relationship between a supplier and an item. It captures the approved supplier list (ASL) and supplier item catalog maintained in procurement systems (Coupa, SAP SRM). Each record links one supplier to one item with pricing, lead time, minimum order quantities, and contract terms that exist only in the context of this specific supplier-item pairing. This is the foundation for sourcing decisions, RFQ evaluation, and preferred supplier management.. Existence Justification: In Transport Shippings procurement operations, suppliers provide multiple items (fuel, packaging materials, IT equipment, facility services, vehicle parts), and each item can be sourced from multiple suppliers to ensure supply chain resilience and competitive pricing. The supply agreement (also known as Approved Supplier List or Supplier Item Catalog in Coupa/SAP SRM) is a recognized business entity that procurement teams actively manage, with each supplier-item pairing having distinct pricing, lead times, minimum order quantities, and contract terms.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_site` ADD CONSTRAINT `fk_procurement_supplier_site_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `transport_shipping_ecm`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_qualification` ADD CONSTRAINT `fk_procurement_supplier_qualification_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `transport_shipping_ecm`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `transport_shipping_ecm`.`procurement`.`rfq` ADD CONSTRAINT `fk_procurement_rfq_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `transport_shipping_ecm`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_quote` ADD CONSTRAINT `fk_procurement_supplier_quote_rfq_id` FOREIGN KEY (`rfq_id`) REFERENCES `transport_shipping_ecm`.`procurement`.`rfq`(`rfq_id`);
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_quote` ADD CONSTRAINT `fk_procurement_supplier_quote_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `transport_shipping_ecm`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_quote` ADD CONSTRAINT `fk_procurement_supplier_quote_supplier_site_id` FOREIGN KEY (`supplier_site_id`) REFERENCES `transport_shipping_ecm`.`procurement`.`supplier_site`(`supplier_site_id`);
ALTER TABLE `transport_shipping_ecm`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_rfq_id` FOREIGN KEY (`rfq_id`) REFERENCES `transport_shipping_ecm`.`procurement`.`rfq`(`rfq_id`);
ALTER TABLE `transport_shipping_ecm`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `transport_shipping_ecm`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `transport_shipping_ecm`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_supplier_quote_id` FOREIGN KEY (`supplier_quote_id`) REFERENCES `transport_shipping_ecm`.`procurement`.`supplier_quote`(`supplier_quote_id`);
ALTER TABLE `transport_shipping_ecm`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_supplier_site_id` FOREIGN KEY (`supplier_site_id`) REFERENCES `transport_shipping_ecm`.`procurement`.`supplier_site`(`supplier_site_id`);
ALTER TABLE `transport_shipping_ecm`.`procurement`.`po_line` ADD CONSTRAINT `fk_procurement_po_line_item_id` FOREIGN KEY (`item_id`) REFERENCES `transport_shipping_ecm`.`procurement`.`item`(`item_id`);
ALTER TABLE `transport_shipping_ecm`.`procurement`.`po_line` ADD CONSTRAINT `fk_procurement_po_line_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `transport_shipping_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `transport_shipping_ecm`.`procurement`.`po_line` ADD CONSTRAINT `fk_procurement_po_line_purchase_requisition_id` FOREIGN KEY (`purchase_requisition_id`) REFERENCES `transport_shipping_ecm`.`procurement`.`purchase_requisition`(`purchase_requisition_id`);
ALTER TABLE `transport_shipping_ecm`.`procurement`.`po_line` ADD CONSTRAINT `fk_procurement_po_line_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `transport_shipping_ecm`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `transport_shipping_ecm`.`procurement`.`goods_receipt` ADD CONSTRAINT `fk_procurement_goods_receipt_po_line_id` FOREIGN KEY (`po_line_id`) REFERENCES `transport_shipping_ecm`.`procurement`.`po_line`(`po_line_id`);
ALTER TABLE `transport_shipping_ecm`.`procurement`.`goods_receipt` ADD CONSTRAINT `fk_procurement_goods_receipt_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `transport_shipping_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `transport_shipping_ecm`.`procurement`.`goods_receipt` ADD CONSTRAINT `fk_procurement_goods_receipt_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `transport_shipping_ecm`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_invoice` ADD CONSTRAINT `fk_procurement_supplier_invoice_goods_receipt_id` FOREIGN KEY (`goods_receipt_id`) REFERENCES `transport_shipping_ecm`.`procurement`.`goods_receipt`(`goods_receipt_id`);
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_invoice` ADD CONSTRAINT `fk_procurement_supplier_invoice_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `transport_shipping_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_invoice` ADD CONSTRAINT `fk_procurement_supplier_invoice_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `transport_shipping_ecm`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_invoice` ADD CONSTRAINT `fk_procurement_supplier_invoice_supplier_site_id` FOREIGN KEY (`supplier_site_id`) REFERENCES `transport_shipping_ecm`.`procurement`.`supplier_site`(`supplier_site_id`);
ALTER TABLE `transport_shipping_ecm`.`procurement`.`procurement_invoice_line` ADD CONSTRAINT `fk_procurement_procurement_invoice_line_goods_receipt_id` FOREIGN KEY (`goods_receipt_id`) REFERENCES `transport_shipping_ecm`.`procurement`.`goods_receipt`(`goods_receipt_id`);
ALTER TABLE `transport_shipping_ecm`.`procurement`.`procurement_invoice_line` ADD CONSTRAINT `fk_procurement_procurement_invoice_line_item_id` FOREIGN KEY (`item_id`) REFERENCES `transport_shipping_ecm`.`procurement`.`item`(`item_id`);
ALTER TABLE `transport_shipping_ecm`.`procurement`.`procurement_invoice_line` ADD CONSTRAINT `fk_procurement_procurement_invoice_line_po_line_id` FOREIGN KEY (`po_line_id`) REFERENCES `transport_shipping_ecm`.`procurement`.`po_line`(`po_line_id`);
ALTER TABLE `transport_shipping_ecm`.`procurement`.`procurement_invoice_line` ADD CONSTRAINT `fk_procurement_procurement_invoice_line_supplier_invoice_id` FOREIGN KEY (`supplier_invoice_id`) REFERENCES `transport_shipping_ecm`.`procurement`.`supplier_invoice`(`supplier_invoice_id`);
ALTER TABLE `transport_shipping_ecm`.`procurement`.`purchase_requisition` ADD CONSTRAINT `fk_procurement_purchase_requisition_item_id` FOREIGN KEY (`item_id`) REFERENCES `transport_shipping_ecm`.`procurement`.`item`(`item_id`);
ALTER TABLE `transport_shipping_ecm`.`procurement`.`purchase_requisition` ADD CONSTRAINT `fk_procurement_purchase_requisition_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `transport_shipping_ecm`.`procurement`.`supplier`(`supplier_id`);
ALTER TABLE `transport_shipping_ecm`.`procurement`.`purchase_requisition` ADD CONSTRAINT `fk_procurement_purchase_requisition_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `transport_shipping_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `transport_shipping_ecm`.`procurement`.`purchase_requisition` ADD CONSTRAINT `fk_procurement_purchase_requisition_rfq_id` FOREIGN KEY (`rfq_id`) REFERENCES `transport_shipping_ecm`.`procurement`.`rfq`(`rfq_id`);
ALTER TABLE `transport_shipping_ecm`.`procurement`.`item` ADD CONSTRAINT `fk_procurement_item_parent_item_id` FOREIGN KEY (`parent_item_id`) REFERENCES `transport_shipping_ecm`.`procurement`.`item`(`item_id`);
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supply_agreement` ADD CONSTRAINT `fk_procurement_supply_agreement_item_id` FOREIGN KEY (`item_id`) REFERENCES `transport_shipping_ecm`.`procurement`.`item`(`item_id`);
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supply_agreement` ADD CONSTRAINT `fk_procurement_supply_agreement_supplier_id` FOREIGN KEY (`supplier_id`) REFERENCES `transport_shipping_ecm`.`procurement`.`supplier`(`supplier_id`);

-- ========= TAGS =========
ALTER SCHEMA `transport_shipping_ecm`.`procurement` SET TAGS ('dbx_division' = 'corporate');
ALTER SCHEMA `transport_shipping_ecm`.`procurement` SET TAGS ('dbx_domain' = 'procurement');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier` SET TAGS ('dbx_subdomain' = 'vendor_management');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier` ALTER COLUMN `agent_id` SET TAGS ('dbx_business_glossary_term' = 'Agent Id (Foreign Key)');
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
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_site` ALTER COLUMN `network_node_id` SET TAGS ('dbx_business_glossary_term' = 'Network Node Id (Foreign Key)');
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
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_qualification` ALTER COLUMN `partner_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Id (Foreign Key)');
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
ALTER TABLE `transport_shipping_ecm`.`procurement`.`rfq` SET TAGS ('dbx_subdomain' = 'sourcing_negotiation');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`rfq` ALTER COLUMN `rfq_id` SET TAGS ('dbx_business_glossary_term' = 'Request for Quotation (RFQ) ID');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`rfq` ALTER COLUMN `agent_id` SET TAGS ('dbx_business_glossary_term' = 'Agent Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`rfq` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`rfq` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Awarded Supplier ID');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`rfq` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`rfq` ALTER COLUMN `lane_id` SET TAGS ('dbx_business_glossary_term' = 'Lane Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`rfq` ALTER COLUMN `service_corridor_id` SET TAGS ('dbx_business_glossary_term' = 'Service Corridor Id (Foreign Key)');
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
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_quote` SET TAGS ('dbx_subdomain' = 'sourcing_negotiation');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_quote` ALTER COLUMN `supplier_quote_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Quote ID');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_quote` ALTER COLUMN `agent_id` SET TAGS ('dbx_business_glossary_term' = 'Agent Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_quote` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Id (Foreign Key)');
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
ALTER TABLE `transport_shipping_ecm`.`procurement`.`purchase_order` ALTER COLUMN `agent_id` SET TAGS ('dbx_business_glossary_term' = 'Agent Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`purchase_order` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`purchase_order` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`purchase_order` ALTER COLUMN `lane_id` SET TAGS ('dbx_business_glossary_term' = 'Inbound Lane Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`purchase_order` ALTER COLUMN `rfq_id` SET TAGS ('dbx_business_glossary_term' = 'Rfq Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`purchase_order` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`purchase_order` ALTER COLUMN `supplier_quote_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Quote Id (Foreign Key)');
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
ALTER TABLE `transport_shipping_ecm`.`procurement`.`po_line` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`po_line` ALTER COLUMN `item_id` SET TAGS ('dbx_business_glossary_term' = 'Item ID');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`po_line` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) ID');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`po_line` ALTER COLUMN `purchase_requisition_id` SET TAGS ('dbx_business_glossary_term' = 'Requisition Line ID');
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
ALTER TABLE `transport_shipping_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `bill_of_lading_id` SET TAGS ('dbx_business_glossary_term' = 'Bill Of Lading Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `consignment_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment ID');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `declaration_id` SET TAGS ('dbx_business_glossary_term' = 'Customs Declaration Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `declaration_line_id` SET TAGS ('dbx_business_glossary_term' = 'Declaration Line Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `freight_order_id` SET TAGS ('dbx_business_glossary_term' = 'Freight Order Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `inbound_receipt_id` SET TAGS ('dbx_business_glossary_term' = 'Inbound Receipt Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice ID');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `po_line_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Line ID');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) ID');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
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
ALTER TABLE `transport_shipping_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `three_way_match_status` SET TAGS ('dbx_business_glossary_term' = 'Three-Way Match Status');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `three_way_match_status` SET TAGS ('dbx_value_regex' = 'matched|quantity_variance|price_variance|not_matched|pending');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_invoice` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_invoice` SET TAGS ('dbx_subdomain' = 'order_fulfillment');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_invoice` ALTER COLUMN `supplier_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Invoice ID');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_invoice` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_invoice` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_invoice` ALTER COLUMN `declaration_id` SET TAGS ('dbx_business_glossary_term' = 'Customs Declaration Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_invoice` ALTER COLUMN `duty_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Duty Assessment Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_invoice` ALTER COLUMN `freight_charge_id` SET TAGS ('dbx_business_glossary_term' = 'Freight Charge Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_invoice` ALTER COLUMN `goods_receipt_id` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt (GR) ID');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_invoice` ALTER COLUMN `inbound_receipt_id` SET TAGS ('dbx_business_glossary_term' = 'Inbound Receipt Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_invoice` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) ID');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_invoice` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supplier_invoice` ALTER COLUMN `supplier_site_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Site Id (Foreign Key)');
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
ALTER TABLE `transport_shipping_ecm`.`procurement`.`purchase_requisition` SET TAGS ('dbx_subdomain' = 'sourcing_negotiation');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `purchase_requisition_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Requisition ID');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `item_id` SET TAGS ('dbx_business_glossary_term' = 'Item Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Preferred Supplier ID');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) ID');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `rfq_id` SET TAGS ('dbx_business_glossary_term' = 'Sourcing Event ID');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`purchase_requisition` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id (Foreign Key)');
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
ALTER TABLE `transport_shipping_ecm`.`procurement`.`item` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`item` SET TAGS ('dbx_subdomain' = 'order_fulfillment');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`item` ALTER COLUMN `item_id` SET TAGS ('dbx_business_glossary_term' = 'Item Identifier');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`item` ALTER COLUMN `parent_item_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`item` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id (Foreign Key)');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supply_agreement` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supply_agreement` SET TAGS ('dbx_subdomain' = 'vendor_management');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supply_agreement` SET TAGS ('dbx_association_edges' = 'procurement.supplier,procurement.item');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supply_agreement` ALTER COLUMN `supply_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Supply Agreement ID');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supply_agreement` ALTER COLUMN `item_id` SET TAGS ('dbx_business_glossary_term' = 'Supply Agreement - Item Id');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supply_agreement` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supply Agreement - Supplier Id');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supply_agreement` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supply_agreement` ALTER COLUMN `contract_price` SET TAGS ('dbx_business_glossary_term' = 'Contract Price');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supply_agreement` ALTER COLUMN `contract_price` SET TAGS ('dbx_financial' = 'true');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supply_agreement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supply_agreement` ALTER COLUMN `effective_from_date` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supply_agreement` ALTER COLUMN `effective_to_date` SET TAGS ('dbx_business_glossary_term' = 'Effective To Date');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supply_agreement` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supply_agreement` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time Days');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supply_agreement` ALTER COLUMN `minimum_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supply_agreement` ALTER COLUMN `preferred_flag` SET TAGS ('dbx_business_glossary_term' = 'Preferred Supplier Flag');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supply_agreement` ALTER COLUMN `unit_price` SET TAGS ('dbx_business_glossary_term' = 'Unit Price');
ALTER TABLE `transport_shipping_ecm`.`procurement`.`supply_agreement` ALTER COLUMN `unit_price` SET TAGS ('dbx_financial' = 'true');
