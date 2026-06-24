-- Schema for Domain: supplier | Business: Retail | Version: v2_mvm
-- Generated on: 2026-06-24 00:49:14

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_retail_v1`.`supplier` COMMENT 'Authoritative source for supplier and vendor master data including contact information, contracts, compliance certifications, performance scorecards, chargebacks (vendor compliance penalties), RTV (Return to Vendor) processes, EDI integration, MOQ and lead time agreements, and VMI configurations. Manages supplier onboarding, qualification, risk assessment, and ongoing relationship management for national brands, private label manufacturers, and DSD vendors.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_retail_v1`.`supplier`.`vendor` (
    `vendor_id` BIGINT COMMENT 'Surrogate primary key uniquely identifying each vendor record.',
    `contract_expiry_date` DATE COMMENT 'Date on which the current master agreement with this vendor expires.',
    `created_timestamp` TIMESTAMP COMMENT 'UTC timestamp when this vendor record was first created.',
    `currency_code` STRING COMMENT 'ISO 4217 currency code for the vendors default transaction currency.. Valid values are `^[A-Z]{3}$`',
    `diversity_certification` STRING COMMENT 'Diversity certification type held by the vendor: minority_owned, women_owned, veteran_owned, disabled_owned, or none.',
    `duns_number` STRING COMMENT 'Dun & Bradstreet DUNS number for vendor identity verification and credit assessment.. Valid values are `^[0-9]{9}$`',
    `edi_capable_flag` BOOLEAN COMMENT 'Whether the vendor supports EDI-based electronic document exchange.',
    `edi_identifier` STRING COMMENT 'Vendors EDI interchange identifier (ISA ID) for electronic transactions.',
    `fill_rate_pct` DECIMAL(18,2) COMMENT 'Percentage of ordered units fulfilled completely on first shipment, measured over trailing period.',
    `insurance_certificate_expiry_date` DATE COMMENT 'Expiration date of the vendors liability insurance certificate on file.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'UTC timestamp of the most recent modification to this vendor record.',
    `last_purchase_order_date` DATE COMMENT 'Date of the last purchase order placed with this vendor.',
    `lead_time_days` STRING COMMENT 'Standard lead time in calendar days from PO placement to delivery.',
    `modified_by_user` STRING COMMENT 'Username or system identifier of the last user to modify this record.',
    `moq_units` DECIMAL(18,2) COMMENT 'Minimum order quantity in units required by the vendor per purchase order.',
    `vendor_name` STRING COMMENT 'Legal or trading name of the vendor organization.',
    `on_time_delivery_rate_pct` DECIMAL(18,2) COMMENT 'Percentage of purchase orders delivered on or before the agreed delivery date.',
    `onboarding_date` DATE COMMENT 'Date when the vendor completed the onboarding process and became active.',
    `payment_method` STRING COMMENT 'Preferred payment method: ach, wire, check, virtual_card.. Valid values are `ach|wire_transfer|check|eft|credit_card|virtual_card`',
    `payment_terms_code` STRING COMMENT 'Standard payment terms code, e.g. NET30, NET60, 2_10_NET30.',
    `primary_contact_email` STRING COMMENT 'Primary contact email address for this vendor.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `primary_contact_name` STRING COMMENT 'Full name of the primary contact person at this vendor.',
    `primary_contact_phone` STRING COMMENT 'Primary contact phone number for this vendor.',
    `quality_acceptance_rate_pct` DECIMAL(18,2) COMMENT 'Percentage of received units passing quality inspection without defect or damage.',
    `remittance_email` STRING COMMENT 'Email address for sending payment remittance advices to this vendor.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `risk_rating` STRING COMMENT 'Overall supply risk rating assigned to this vendor: low, medium, high, critical.. Valid values are `low|medium|high|critical`',
    `sustainability_certified_flag` BOOLEAN COMMENT 'Whether the vendor holds a recognized sustainability certification.',
    `tax_classification` STRING COMMENT 'Tax classification of the vendor entity for withholding and reporting purposes.. Valid values are `w9_us_person|w8_foreign_entity|exempt_organization|government_entity`',
    `tax_identifier` STRING COMMENT 'Tax identification number (EIN, VAT number, etc.) for this vendor entity.',
    `vendor_status` STRING COMMENT 'Current lifecycle status of the vendor relationship. Values: active, inactive, suspended, pending_onboarding, terminated.. Valid values are `active|inactive|suspended|pending_approval|blocked|terminated`',
    `vendor_type` STRING COMMENT 'Classification of vendor by business relationship type. Values: manufacturer, distributor, wholesaler, service_provider, drop_ship, private_label.. Valid values are `national_brand|private_label|dsd_vendor|3pl_partner|service_provider|raw_material_supplier`',
    `vmi_enabled_flag` BOOLEAN COMMENT 'Whether vendor-managed inventory is active for this vendor.',
    CONSTRAINT pk_vendor PRIMARY KEY(`vendor_id`)
) COMMENT 'Master record for each supplier/vendor with whom the retailer has a commercial relationship. Contains identity, contact, compliance, and performance attributes. Serves as the root entity for all supplier-domain relationships.';

CREATE OR REPLACE TABLE `vibe_retail_v1`.`supplier`.`vendor_contact` (
    `vendor_contact_id` BIGINT COMMENT 'Unique identifier for the vendor contact person. Primary key.',
    `vendor_id` BIGINT COMMENT 'Reference to the parent vendor organization this contact represents. Links to the vendor master record.',
    `address_line_1` STRING COMMENT 'First line of the business address for the vendor contacts office location. Typically includes street number and name.',
    `address_line_2` STRING COMMENT 'Second line of the business address for additional location details such as suite, floor, or building number.',
    `city` STRING COMMENT 'City or municipality where the vendor contacts office is located.',
    `contact_status` STRING COMMENT 'Current lifecycle status of the vendor contact. Inactive or terminated contacts should not receive communications.. Valid values are `active|inactive|on_leave|terminated`',
    `contact_type` STRING COMMENT 'The functional role or responsibility area of this contact within the vendor organization. Determines escalation paths and communication routing.. Valid values are `account_manager|edi_coordinator|compliance_contact|executive_sponsor|logistics_coordinator|quality_assurance`',
    `country_code` STRING COMMENT 'Three-letter ISO country code for the vendor contacts office location. [ENUM-REF-CANDIDATE: USA|CAN|MEX|GBR|DEU|FRA|CHN|JPN — 8 candidates stripped; promote to reference product]',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this vendor contact record was first created in the system. Supports audit trail and data lineage.',
    `department` STRING COMMENT 'The department or business unit within the vendor organization where this contact works (e.g., Sales, Logistics, Quality Assurance, Finance).',
    `effective_end_date` DATE COMMENT 'The date when this vendor contact ceased to be active. Null for currently active contacts. Used for historical tracking and audit trails.',
    `effective_start_date` DATE COMMENT 'The date when this vendor contact became active and available for business communications. Supports temporal tracking of contact relationships.',
    `email_address` STRING COMMENT 'Primary business email address for the vendor contact. Used for official communications, purchase orders, and compliance notifications.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `fax_number` STRING COMMENT 'Fax number for the vendor contact, if still used for formal document transmission.',
    `first_name` STRING COMMENT 'The given name of the vendor contact person.',
    `is_escalation_contact` BOOLEAN COMMENT 'Indicates whether this contact should be included in escalation workflows for critical issues such as compliance violations, quality failures, or delivery delays.',
    `is_primary_contact` BOOLEAN COMMENT 'Indicates whether this contact is the primary point of contact for the vendor. Used for default routing of communications and escalations.',
    `job_title` STRING COMMENT 'The official job title or position of the contact within the vendor organization (e.g., Account Manager, Supply Chain Director, Compliance Officer).',
    `language_preference` STRING COMMENT 'Preferred language for business communications with this contact. Uses ISO 639-2 three-letter language codes.. Valid values are `ENG|SPA|FRA|DEU|CHN|JPN`',
    `last_contact_date` DATE COMMENT 'The most recent date when this vendor contact was engaged in business communication. Used for relationship health monitoring and engagement tracking.',
    `last_name` STRING COMMENT 'The family name or surname of the vendor contact person.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'The date and time when this vendor contact record was most recently modified. Supports change tracking and audit compliance.',
    `middle_name` STRING COMMENT 'The middle name or initial of the vendor contact person, if applicable.',
    `mobile_number` STRING COMMENT 'Mobile phone number for the vendor contact. Used for urgent escalations and time-sensitive communications.',
    `notes` STRING COMMENT 'Free-form text field for additional information about the vendor contact, such as special instructions, preferences, or relationship history.',
    `office_location` STRING COMMENT 'The physical office location or site where this contact is based (e.g., headquarters, regional office, manufacturing plant).',
    `phone_number` STRING COMMENT 'Primary business phone number for the vendor contact. Includes country code and extension if applicable.',
    `postal_code` STRING COMMENT 'Postal or ZIP code for the vendor contacts office location.',
    `preferred_communication_channel` STRING COMMENT 'The contacts preferred method for receiving business communications. Supports personalized engagement and improved response rates.. Valid values are `email|phone|mobile|fax|edi|portal`',
    `state_province` STRING COMMENT 'State, province, or region where the vendor contacts office is located.',
    `time_zone` STRING COMMENT 'The time zone where the vendor contact is located. Used for scheduling meetings and understanding business hours. Format follows IANA Time Zone Database (e.g., America/New_York, Europe/London).',
    CONSTRAINT pk_vendor_contact PRIMARY KEY(`vendor_contact_id`)
) COMMENT 'Contact persons associated with a vendor including account managers, EDI coordinators, compliance contacts, and executive sponsors. Tracks name, title, role type, phone, email, preferred communication channel, and active status. Supports relationship management and escalation workflows.';

CREATE OR REPLACE TABLE `vibe_retail_v1`.`supplier`.`vendor_address` (
    `vendor_address_id` BIGINT COMMENT 'Unique identifier for the vendor address record. Primary key.',
    `vendor_id` BIGINT COMMENT 'Identifier of the vendor to whom this address belongs. Links to the vendor master record.',
    `address_line_1` STRING COMMENT 'Primary street address line including street number, street name, and building identifier. Organizational contact data classified as confidential.',
    `address_line_2` STRING COMMENT 'Secondary address line for suite, floor, department, or additional location details. Organizational contact data classified as confidential.',
    `address_line_3` STRING COMMENT 'Tertiary address line for complex addresses requiring additional location specification. Organizational contact data classified as confidential.',
    `address_name` STRING COMMENT 'Descriptive name or label for the address location (e.g., Main Distribution Center, Corporate HQ, Returns Processing Facility).',
    `address_status` STRING COMMENT 'Current lifecycle status of the address: active (in use), inactive (no longer used), pending_validation (awaiting verification), invalid (failed validation), temporary (short-term use).. Valid values are `active|inactive|pending_validation|invalid|temporary`',
    `address_type` STRING COMMENT 'Classification of the address purpose: headquarters (corporate office), remittance (payment processing), ship_from (origin for DSD or shipments), returns (RTV processing location), billing (invoice address), warehouse (distribution or storage facility).. Valid values are `headquarters|remittance|ship_from|returns|billing|warehouse`',
    `city` STRING COMMENT 'City or municipality name where the vendor address is located. Organizational contact data classified as confidential.',
    `country_code` STRING COMMENT 'Three-letter ISO country code identifying the country of the address (e.g., USA, CAN, MEX, GBR, DEU).. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this address record was first created in the system. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `duns_number` STRING COMMENT 'Dun & Bradstreet DUNS number for the location, used for business identity verification, credit assessment, and supplier risk management. 9-digit numeric identifier.. Valid values are `^[0-9]{9}$`',
    `effective_end_date` DATE COMMENT 'Date when this address is no longer valid or was deactivated. Null indicates the address is currently active. Format: yyyy-MM-dd.',
    `effective_start_date` DATE COMMENT 'Date when this address became active and valid for use in procurement, logistics, and vendor transactions. Format: yyyy-MM-dd.',
    `email_address` STRING COMMENT 'Primary email contact for the address location, used for logistics coordination, RTV notifications, and operational communication. Organizational contact data classified as confidential.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `fax_number` STRING COMMENT 'Fax number for the address location, used for EDI transmission or document exchange with vendors. Organizational contact data classified as confidential.',
    `gln` STRING COMMENT 'GS1 Global Location Number uniquely identifying the physical location for EDI transactions, logistics routing, and supply chain integration. 13-digit numeric identifier.. Valid values are `^[0-9]{13}$`',
    `is_dsd_location` BOOLEAN COMMENT 'Flag indicating whether this address is a DSD (Direct Store Delivery) origin location where vendors deliver directly to retail stores bypassing distribution centers. True if DSD location, False otherwise.',
    `is_primary_address` BOOLEAN COMMENT 'Flag indicating whether this is the primary or default address for the vendor. True if primary, False otherwise.',
    `is_remittance_address` BOOLEAN COMMENT 'Flag indicating whether this address is used for payment remittance and accounts payable processing. True if remittance address, False otherwise.',
    `is_rtv_address` BOOLEAN COMMENT 'Flag indicating whether this address is designated for RTV (Return to Vendor) processing and merchandise returns. True if RTV address, False otherwise. Critical for reverse logistics and vendor compliance.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this address record was last modified or updated. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate in decimal degrees for geospatial routing, logistics optimization, and mapping. Supports last-mile delivery planning and ship-from-store calculations.',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate in decimal degrees for geospatial routing, logistics optimization, and mapping. Supports last-mile delivery planning and ship-from-store calculations.',
    `notes` STRING COMMENT 'Free-text field for additional address-specific information, special delivery instructions, access requirements, or operational notes for logistics and procurement teams.',
    `phone_number` STRING COMMENT 'Primary contact phone number for the address location. Organizational contact data classified as confidential.',
    `postal_code` STRING COMMENT 'Postal or ZIP code for mail delivery routing. Format varies by country (e.g., 5-digit ZIP in USA, alphanumeric in Canada). Organizational contact data classified as confidential.',
    `state_province` STRING COMMENT 'State, province, or regional subdivision where the address is located. Organizational contact data classified as confidential.',
    `tax_jurisdiction_code` STRING COMMENT 'Tax jurisdiction or district code applicable to this address location, used for sales tax calculation, VAT compliance, and financial reporting.',
    `time_zone` STRING COMMENT 'IANA time zone identifier for the address location (e.g., America/New_York, America/Chicago, Europe/London). Supports scheduling, delivery windows, and cross-timezone coordination.',
    `validation_date` DATE COMMENT 'Date when the address was last validated against postal authority or third-party address verification services. Format: yyyy-MM-dd.',
    `validation_source` STRING COMMENT 'Name of the service or system used to validate the address (e.g., USPS Address Validation API, Canada Post AddressComplete, UPS Address Validation, manual verification).',
    `validation_status` STRING COMMENT 'Indicates whether the address has been verified against postal authority databases or third-party address validation services: validated (confirmed accurate), unvalidated (not yet checked), failed (does not match postal records), partial (some fields validated).. Valid values are `validated|unvalidated|failed|partial`',
    CONSTRAINT pk_vendor_address PRIMARY KEY(`vendor_address_id`)
) COMMENT 'Physical and mailing addresses for vendors including headquarters, remittance, ship-from, and returns (RTV) addresses. Tracks address type, street, city, state, postal code, country, geo-coordinates, and validation status. Supports procurement, logistics routing, and RTV processing.';

CREATE OR REPLACE TABLE `vibe_retail_v1`.`supplier`.`vendor_contract` (
    `vendor_contract_id` BIGINT COMMENT 'Unique identifier for the vendor contract. Primary key for the vendor contract entity.',
    `location_id` BIGINT COMMENT 'Foreign key linking to store.location. Business justification: Vendor contracts specify which store or DC location receives goods — a core contract management and inbound logistics process. receiving_location_code is a denormalized text field; normalizing to loca',
    `sales_territory_id` BIGINT COMMENT 'Foreign key linking to store.sales_territory. Business justification: Exclusive distribution agreements in retail are scoped to sales territories — a legally significant contract term. exclusivity_scope is a plain-text denormalization of territory; normalizing to sales_',
    `vendor_id` BIGINT COMMENT 'Identifier of the supplier or vendor party to this contract. Links to the vendor master record.',
    `auto_renewal_flag` BOOLEAN COMMENT 'Indicates whether the contract automatically renews at expiration. True if the contract extends for another term unless either party provides termination notice. False if the contract expires without action.',
    `chargeback_terms` STRING COMMENT 'Description of vendor compliance penalties and chargeback conditions. Defines scenarios where the buyer may deduct fees from vendor payments for non-compliance (late delivery, incorrect labeling, missing ASN, pallet configuration errors).',
    `compliance_certifications_required` STRING COMMENT 'List of regulatory and industry certifications the vendor must maintain to fulfill this contract. Examples include FDA registration for food suppliers, CPSC compliance for consumer products, organic certifications, fair trade certifications, and safety standards.',
    `contract_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the contract value and payment terms. All financial terms in this contract are denominated in this currency.. Valid values are `^[A-Z]{3}$`',
    `contract_document_url` STRING COMMENT 'Uniform Resource Locator pointing to the digitally stored contract document. Links to the document management system or secure file repository where the full contract PDF or scanned image is stored.',
    `contract_number` STRING COMMENT 'Externally visible business identifier for the vendor contract. Used in procurement documents, purchase orders, and vendor communications.',
    `contract_status` STRING COMMENT 'Current lifecycle state of the vendor contract. Draft contracts are under negotiation. Pending approval contracts await internal sign-off. Active contracts are in force. Suspended contracts are temporarily paused. Terminated contracts are ended before expiry. Expired contracts have passed their end date. Renewed contracts have been extended. [ENUM-REF-CANDIDATE: draft|pending_approval|active|suspended|terminated|expired|renewed — 7 candidates stripped; promote to reference product]',
    `contract_type` STRING COMMENT 'Classification of the vendor contract. National brand contracts cover branded merchandise from manufacturers. Private label contracts govern store-brand product manufacturing. DSD (Direct Store Delivery) contracts define vendor-managed delivery terms. Master service agreements cover ongoing services. Blanket orders establish terms for recurring purchases. Framework agreements set umbrella terms for multiple purchase orders.. Valid values are `national_brand|private_label|dsd|master_service_agreement|blanket_order|framework_agreement`',
    `contract_value_amount` DECIMAL(18,2) COMMENT 'Total monetary value committed under this vendor contract. Represents the aggregate purchase commitment or spending cap over the contract term. Used for budget planning and vendor performance tracking.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this vendor contract record was first created in the system. Used for audit trail and data lineage tracking.',
    `discount_percentage` DECIMAL(18,2) COMMENT 'Standard discount rate applied to purchases under this contract. Expressed as a percentage off list price. Used for volume discounts, early payment discounts, or negotiated pricing agreements.',
    `edi_enabled_flag` BOOLEAN COMMENT 'Indicates whether Electronic Data Interchange is enabled for transactions under this contract. True if purchase orders, invoices, and shipping notices are exchanged via EDI. False for manual or email-based document exchange.',
    `edi_identifier` STRING COMMENT 'Vendor EDI interchange identifier corresponding to the EDI qualifier. Used in EDI message headers to identify the sender and receiver.',
    `edi_qualifier` STRING COMMENT 'EDI interchange identifier qualifier for the vendor. Examples include 01 (DUNS number), 12 (phone number), 14 (UPC), ZZ (mutually defined). Used to route EDI messages to the correct vendor system.',
    `effective_end_date` DATE COMMENT 'Date when the vendor contract terms expire. Nullable for open-ended contracts. Procurement transactions must occur before this date unless the contract is renewed.',
    `effective_start_date` DATE COMMENT 'Date when the vendor contract terms become binding and enforceable. Procurement transactions referencing this contract must occur on or after this date.',
    `exclusivity_flag` BOOLEAN COMMENT 'Indicates whether this contract grants the vendor exclusive rights to supply specific products or categories. True if the buyer commits to purchasing exclusively from this vendor for the covered scope. False for non-exclusive agreements.',
    `incoterms_code` STRING COMMENT 'International Commercial Terms code defining the division of costs and risks between buyer and seller. EXW (Ex Works) - buyer collects from vendor premises. FOB (Free On Board) - vendor delivers to shipping vessel. DDP (Delivered Duty Paid) - vendor delivers to buyer location with all duties paid. [ENUM-REF-CANDIDATE: EXW|FCA|CPT|CIP|DAP|DPU|DDP|FAS|FOB|CFR|CIF — 11 candidates stripped; promote to reference product]',
    `insurance_requirements` STRING COMMENT 'Minimum insurance coverage the vendor must carry to fulfill this contract. Typically includes general liability, product liability, and cargo insurance with specified coverage limits.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Date and time when this vendor contract record was most recently modified. Used for audit trail, change tracking, and data synchronization.',
    `lead_time_days` STRING COMMENT 'Standard number of calendar days from purchase order submission to delivery at the receiving location. Used for replenishment planning, inventory forecasting, and order scheduling.',
    `minimum_order_quantity` DECIMAL(18,2) COMMENT 'Minimum order quantity required per purchase order under this contract. Vendor will not accept orders below this threshold. Used for production planning and logistics optimization.',
    `moq_unit_of_measure` STRING COMMENT 'Unit of measure for the minimum order quantity. Examples include EA (each), CS (case), PLT (pallet), KG (kilogram), LB (pound). Must align with vendor catalog and purchase order units.',
    `notes` STRING COMMENT 'Free-text field for additional contract details, special terms, negotiation history, or operational notes. Used by procurement teams to capture context not covered by structured fields.',
    `payment_method` STRING COMMENT 'Preferred payment instrument for settling invoices under this contract. ACH (Automated Clearing House) for electronic bank transfers. Wire transfer for same-day settlement. Check for paper-based payment. EDI (Electronic Data Interchange) payment for automated remittance. Credit card for small purchases. Letter of credit for international trade.. Valid values are `ach|wire_transfer|check|edi_payment|credit_card|letter_of_credit`',
    `payment_terms_code` STRING COMMENT 'Standard payment terms code defining the due date calculation and discount structure. Examples include Net 30, Net 60, 2/10 Net 30 (2% discount if paid within 10 days, otherwise net 30 days).',
    `quality_assurance_terms` STRING COMMENT 'Quality standards and inspection requirements for goods supplied under this contract. Defines acceptable quality levels, sampling procedures, defect rates, and vendor quality certifications required.',
    `renewal_term_months` STRING COMMENT 'Duration in months for each automatic renewal period. Applicable only when auto_renewal_flag is true. Contract extends by this duration at each renewal.',
    `return_to_vendor_policy` STRING COMMENT 'Terms governing the return of defective, damaged, or unsold merchandise to the vendor. Defines RTV authorization process, restocking fees, return shipping responsibility, and credit issuance timeline.',
    `shipping_point` STRING COMMENT 'Vendor facility or distribution center from which goods are shipped under this contract. Used for logistics planning, freight cost calculation, and delivery time estimation.',
    `signature_date` DATE COMMENT 'Date when the contract was signed by the authorized buyer representative. Used for contract validity verification and audit trail.',
    `termination_notice_days` STRING COMMENT 'Number of calendar days advance notice required to terminate the contract. Either party must provide written notice this many days before the desired termination date.',
    `vendor_signatory_name` STRING COMMENT 'Full name of the authorized representative who signed the contract on behalf of the vendor organization. Used for contract validation and audit trail.',
    `vendor_signatory_title` STRING COMMENT 'Job title or role of the vendor authorized signatory. Examples include CEO, VP Sales, Director of Business Development. Used to verify vendor signing authority.',
    `vendor_signature_date` DATE COMMENT 'Date when the contract was signed by the authorized vendor representative. Used for contract validity verification and audit trail.',
    `vmi_enabled_flag` BOOLEAN COMMENT 'Indicates whether Vendor Managed Inventory is enabled under this contract. True if the vendor monitors buyer inventory levels and automatically replenishes stock. False for buyer-managed replenishment.',
    CONSTRAINT pk_vendor_contract PRIMARY KEY(`vendor_contract_id`)
) COMMENT 'Supplier trading agreements and master vendor contracts including terms and conditions, payment terms, discount structures, exclusivity clauses, private label agreements, and contract validity periods. Tracks contract type (national brand, private label, DSD), effective and expiry dates, auto-renewal flags, and signatory details. Sourced from SAP S/4HANA SD/MM contract management.';

CREATE OR REPLACE TABLE `vibe_retail_v1`.`supplier`.`chargeback` (
    `chargeback_id` BIGINT COMMENT 'Unique identifier for the vendor compliance chargeback penalty record.',
    `dc_facility_id` BIGINT COMMENT 'Reference to the distribution center or receiving facility where the compliance violation was detected.',
    `goods_receipt_id` BIGINT COMMENT 'Foreign key linking to inventory.goods_receipt. Business justification: Chargebacks for receipt discrepancies (short shipments, damaged goods, labeling violations) require direct link to the specific goods_receipt event for validation, dispute resolution, and vendor score',
    `inbound_shipment_id` BIGINT COMMENT 'Foreign key linking to supplychain.inbound_shipment. Business justification: Chargebacks triggered by shipment violations (short ship, ASN non-compliance, seal failure) require direct reference to the inbound_shipment for root cause investigation and vendor dispute resolution.',
    `lead_time_agreement_id` BIGINT COMMENT 'Foreign key linking to supplier.lead_time_agreement. Business justification: A chargeback issued for a lead time or MOQ violation should reference the specific lead_time_agreement that was breached. chargeback already has vendor_contract_id (the governing contract) and vendor_',
    `purchase_order_id` BIGINT COMMENT 'Reference to the purchase order associated with the compliance violation that triggered this chargeback.',
    `receiving_event_id` BIGINT COMMENT 'Foreign key linking to supplychain.receiving_event. Business justification: Receiving discrepancy chargebacks (shortage, damage, overage) are directly triggered by receiving_event records containing discrepancy_reason_code and damage_flag. Receiving discrepancy chargeback p',
    `rma_id` BIGINT COMMENT 'Foreign key linking to returns.rma. Business justification: Vendor chargebacks often stem from customer returns (damaged/defective goods). AP teams reconcile chargebacks against originating RMAs to validate penalty legitimacy and negotiate vendor disputes. Ena',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: Chargebacks for quality, compliance, or labeling violations must identify affected SKUs. Business process: chargeback dispute resolution, root cause analysis, vendor scorecard impact assessment, and f',
    `vendor_contract_id` BIGINT COMMENT 'Foreign key linking to supplier.vendor_contract. Business justification: Chargebacks enforce contract compliance by penalizing vendors for violations. Linking to vendor_contract enables retrieving penalty schedules, dispute resolution procedures, and recovery methods defin',
    `vendor_id` BIGINT COMMENT 'Reference to the supplier or vendor against whom this chargeback penalty is issued.',
    `vendor_item_id` BIGINT COMMENT 'Foreign key linking to supplier.vendor_item. Business justification: Chargebacks for item-specific violations (incorrect labeling, wrong UPC/GTIN, non-compliant pack configuration, wrong case pack quantity) must reference the specific vendor_item catalog entry — not ju',
    `vendor_promo_agreement_id` BIGINT COMMENT 'Foreign key linking to promotion.vendor_promo_agreement. Business justification: Promotional chargebacks are issued when vendors fail to fulfill promotional funding commitments. Promotional chargeback management requires linking each chargeback to the specific vendor_promo_agree',
    `location_id` BIGINT COMMENT 'Foreign key linking to store.store_location. Business justification: Chargebacks for routing guide violations, labeling errors, or receiving discrepancies originate at specific receiving locations (stores or DCs). Tracking the violation location supports root cause ana',
    `affected_units` STRING COMMENT 'The number of units (SKUs, cartons, or pallets) impacted by the compliance violation.',
    `approval_date` DATE COMMENT 'The date on which the chargeback was formally approved for issuance.',
    `approved_by` STRING COMMENT 'User ID of the procurement or compliance manager who approved the chargeback for issuance to the vendor.',
    `chargeback_number` STRING COMMENT 'Externally visible business identifier for the chargeback penalty, used in vendor communications and dispute resolution.',
    `chargeback_status` STRING COMMENT 'Current lifecycle state of the chargeback penalty in the dispute and recovery workflow. [ENUM-REF-CANDIDATE: pending|issued|disputed|under_review|approved|rejected|paid|written_off|cancelled — 9 candidates stripped; promote to reference product]',
    `chargeback_type` STRING COMMENT 'High-level category of the compliance violation that triggered the chargeback penalty. [ENUM-REF-CANDIDATE: routing_guide_violation|labeling_non_compliance|edi_failure|late_shipment|fill_rate_shortfall|asn_error|packaging_defect|quality_defect|documentation_error|other — 10 candidates stripped; promote to reference product]',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this chargeback record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the penalty amount.. Valid values are `USD|CAD|EUR|GBP|MXN|JPY`',
    `debit_memo_number` STRING COMMENT 'The external document number of the debit memo issued to the vendor for the chargeback penalty, if applicable.',
    `detection_date` DATE COMMENT 'The date on which the compliance violation was formally identified and logged in the system, which may differ from the violation date.',
    `dispute_date` DATE COMMENT 'The date on which the vendor formally disputed the chargeback penalty.',
    `dispute_reason` STRING COMMENT 'Free-text explanation provided by the vendor for disputing the chargeback, including supporting evidence references.',
    `dispute_status` STRING COMMENT 'Indicates whether the vendor has disputed the chargeback and the current state of the dispute resolution process.. Valid values are `not_disputed|disputed|under_investigation|resolved_vendor_favor|resolved_retailer_favor`',
    `is_repeat_violation` BOOLEAN COMMENT 'Flag indicating whether this chargeback represents a repeat violation of the same compliance rule by the vendor within a defined time window.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'The date and time when this chargeback record was most recently modified.',
    `notes` STRING COMMENT 'Free-text field for additional context, supporting documentation references, or special handling instructions related to the chargeback.',
    `notification_method` STRING COMMENT 'The communication channel used to notify the vendor of the chargeback penalty.. Valid values are `vendor_portal|edi|email|fax|mail`',
    `notification_sent_date` DATE COMMENT 'The date on which the chargeback notification was sent to the vendor through the vendor portal or EDI channel.',
    `penalty_amount` DECIMAL(18,2) COMMENT 'The monetary value of the chargeback penalty assessed against the vendor for the compliance violation.',
    `penalty_calculation_method` STRING COMMENT 'The method used to calculate the chargeback penalty amount, such as a fixed flat fee or a percentage of the order value.. Valid values are `flat_fee|percentage_of_order|per_unit|per_carton|per_pallet|tiered`',
    `penalty_percentage` DECIMAL(18,2) COMMENT 'The percentage rate applied to the order or shipment value when the penalty calculation method is percentage-based.',
    `previous_violation_count` STRING COMMENT 'The number of prior chargebacks issued to this vendor for the same violation category within the trailing 12-month period.',
    `recovery_date` DATE COMMENT 'The date on which the chargeback penalty amount was successfully recovered from the vendor through the specified recovery method.',
    `recovery_method` STRING COMMENT 'The mechanism used to recover the chargeback penalty amount from the vendor, such as accounts payable deduction or separate debit memo.. Valid values are `ap_deduction|debit_memo|credit_memo|offset_future_payment|written_off`',
    `resolution_date` DATE COMMENT 'The date on which the chargeback dispute was resolved and a final decision was made.',
    `resolution_notes` STRING COMMENT 'Internal notes documenting the outcome of the dispute resolution process, including any adjustments or waivers granted.',
    `vendor_scorecard_impact` DECIMAL(18,2) COMMENT 'The negative impact score applied to the vendors performance scorecard as a result of this chargeback, used in vendor relationship management and future sourcing decisions.',
    `violation_category` STRING COMMENT 'Detailed classification of the specific compliance rule or requirement that was violated, such as GS1-128 labeling failure, RFID tag missing, or incorrect pallet configuration.',
    `violation_date` DATE COMMENT 'The date on which the compliance violation occurred or was detected by the receiving facility or quality control process.',
    `created_by` STRING COMMENT 'User ID or system identifier of the person or automated process that created the chargeback record.',
    CONSTRAINT pk_chargeback PRIMARY KEY(`chargeback_id`)
) COMMENT 'Vendor compliance penalty records issued to suppliers for violations of routing guides, labeling requirements (GS1-128, RFID/EPC), EDI non-compliance, late shipments, fill rate shortfalls, ASN failures, and packaging defects. Tracks chargeback type, violation category, violation date, penalty amount (flat fee or percentage), dispute status, resolution date, recovery method (AP deduction or separate debit memo), and linkage to the originating routing guide rule. Critical for vendor compliance enforcement, cost recovery, and feeds vendor scorecard KPIs. Supports automated penalty calculation and vendor portal notification workflows.';

CREATE OR REPLACE TABLE `vibe_retail_v1`.`supplier`.`vendor_scorecard` (
    `vendor_scorecard_id` BIGINT COMMENT 'Unique identifier for the vendor scorecard record. Primary key. Role: TRANSACTION_HEADER (scorecard is a periodic performance evaluation event).',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to supplychain.purchase_order. Business justification: Scorecards measure vendor performance (on-time delivery, fill rate, invoice accuracy) across PO history. Retail buyers review scorecard metrics tied to specific POs for vendor negotiations, tier assig',
    `vendor_contract_id` BIGINT COMMENT 'Foreign key linking to supplier.vendor_contract. Business justification: Vendor scorecards measure performance against contract SLAs (on-time delivery rate, fill rate, EDI compliance). Linking to vendor_contract enables comparing actual performance metrics to contractual c',
    `vendor_id` BIGINT COMMENT 'Reference to the vendor being evaluated in this scorecard. Links to the vendor master data entity.',
    `chargeback_amount` DECIMAL(18,2) COMMENT 'Total monetary value of chargebacks assessed against the vendor during the scoring period, typically in USD.',
    `chargeback_count` STRING COMMENT 'Total number of chargebacks (vendor compliance penalties) issued to the vendor during the scoring period for violations such as late delivery, incorrect labeling, or packaging non-compliance.',
    `composite_score` DECIMAL(18,2) COMMENT 'Weighted overall vendor performance score calculated from individual KPI values (on-time delivery, fill rate, quality, etc.). Scale typically 0-100. Used for vendor tier classification.',
    `corrective_action_due_date` DATE COMMENT 'Deadline by which the vendor must submit a corrective action plan if required.',
    `corrective_action_required` BOOLEAN COMMENT 'Flag indicating whether the vendor is required to submit a corrective action plan based on scorecard results (true if performance is below acceptable thresholds).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this scorecard record was first created in the system.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for all monetary amounts in this scorecard (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `edi_compliance_rate` DECIMAL(18,2) COMMENT 'Percentage of transactions (purchase orders, ASNs, invoices) successfully transmitted via EDI without errors or manual intervention during the scoring period.',
    `evaluation_date` DATE COMMENT 'Date when the scorecard was completed and finalized by the evaluator.',
    `fill_rate` DECIMAL(18,2) COMMENT 'Percentage of ordered quantity that was fulfilled by the vendor during the scoring period. Measures vendor ability to meet demand without stockouts.',
    `invoice_accuracy_rate` DECIMAL(18,2) COMMENT 'Percentage of invoices submitted without pricing, quantity, or calculation errors during the scoring period. Measures vendor billing quality.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this scorecard record was last modified.',
    `lead_time_adherence_rate` DECIMAL(18,2) COMMENT 'Percentage of orders where the vendor met the agreed lead time from order placement to delivery during the scoring period.',
    `minimum_order_quantity_compliance_rate` DECIMAL(18,2) COMMENT 'Percentage of orders where the vendor honored MOQ agreements without imposing additional fees or rejecting orders during the scoring period.',
    `notes` STRING COMMENT 'Free-text field for additional comments, context, or qualitative observations about vendor performance during the scoring period.',
    `on_time_delivery_rate` DECIMAL(18,2) COMMENT 'Percentage of purchase orders or shipments delivered on or before the promised delivery date during the scoring period. Key KPI for vendor reliability.',
    `prior_period_composite_score` DECIMAL(18,2) COMMENT 'Composite score from the previous scoring period, used to calculate trend and performance improvement or decline.',
    `product_quality_score` DECIMAL(18,2) COMMENT 'Composite quality score based on defect rates, customer returns, and quality inspection results for products supplied by the vendor during the scoring period. Scale typically 0-100.',
    `return_to_vendor_amount` DECIMAL(18,2) COMMENT 'Total monetary value of goods returned to the vendor during the scoring period, typically in USD.',
    `return_to_vendor_count` STRING COMMENT 'Total number of RTV transactions initiated during the scoring period due to defects, overstock, or non-compliance.',
    `score_trend` STRING COMMENT 'Directional trend of vendor performance compared to the prior period (improving, stable, or declining).. Valid values are `improving|stable|declining`',
    `scorecard_number` STRING COMMENT 'Business identifier for the scorecard, typically formatted as SC-YYYYMMDD or similar pattern for external reference and reporting.. Valid values are `^SC-[0-9]{8}$`',
    `scorecard_status` STRING COMMENT 'Current lifecycle status of the scorecard indicating whether it is in draft, published for vendor review, under internal review, finalized, or archived.. Valid values are `draft|published|under_review|finalized|archived`',
    `scoring_period_end_date` DATE COMMENT 'The end date of the evaluation period covered by this scorecard (e.g., end of quarter or month).',
    `scoring_period_start_date` DATE COMMENT 'The start date of the evaluation period covered by this scorecard (e.g., beginning of quarter or month).',
    `total_purchase_order_count` STRING COMMENT 'Total number of purchase orders issued to the vendor during the scoring period. Provides context for volume-based KPI interpretation.',
    `total_purchase_order_value` DECIMAL(18,2) COMMENT 'Total monetary value of purchase orders issued to the vendor during the scoring period, typically in USD. Provides spend context for scorecard evaluation.',
    `vendor_acknowledgment_date` DATE COMMENT 'Date when the vendor acknowledged receipt and review of the scorecard.',
    `vendor_notification_date` DATE COMMENT 'Date when the scorecard was shared with the vendor for review and discussion.',
    `vendor_tier` STRING COMMENT 'Classification tier assigned to the vendor based on the composite score and strategic importance. Preferred vendors receive priority, probation vendors face restrictions, suspended vendors are blocked from new orders.. Valid values are `preferred|approved|conditional|probation|suspended`',
    CONSTRAINT pk_vendor_scorecard PRIMARY KEY(`vendor_scorecard_id`)
) COMMENT 'Periodic vendor performance scorecards measuring KPIs including on-time delivery rate, fill rate, EDI compliance rate, invoice accuracy, chargeback frequency, product quality scores, and overall vendor rating. Tracks scoring period, individual KPI values, weighted composite score, tier classification (preferred, approved, probation), and trend vs prior period. Enables strategic vendor relationship management.';

CREATE OR REPLACE TABLE `vibe_retail_v1`.`supplier`.`edi_config` (
    `edi_config_id` BIGINT COMMENT 'Unique identifier for the EDI configuration record. Primary key for the EDI configuration entity.',
    `vendor_id` BIGINT COMMENT 'Unique identifier assigned to the trading partner in the EDI network. Used in EDI envelope segments to identify sender and receiver.',
    `vendor_contract_id` BIGINT COMMENT 'Foreign key linking to supplier.vendor_contract. Business justification: EDI integration requirements (transaction sets, acknowledgment SLAs, compliance thresholds) are typically defined in vendor contracts. Linking edi_config to vendor_contract enables tracking which cont',
    `alert_email_addresses` STRING COMMENT 'Comma-separated list of email addresses to notify when EDI errors, SLA violations, or integration health issues occur. Used for operational alerting.',
    `authentication_method` STRING COMMENT 'The authentication mechanism used to secure the EDI connection. Certificate-based authentication is standard for AS2; SSH keys are common for SFTP.. Valid values are `certificate|username_password|ssh_key|oauth|api_key`',
    `certification_date` DATE COMMENT 'The date when the EDI integration was certified and approved for production use after successful testing. Null if not yet certified.',
    `chargeback_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the chargeback penalty amount. Example: USD, EUR, GBP.. Valid values are `^[A-Z]{3}$`',
    `chargeback_penalty_amount` DECIMAL(18,2) COMMENT 'The monetary penalty amount (in base currency) assessed per EDI compliance violation. Chargebacks are vendor compliance penalties for failing to meet EDI standards or SLAs.',
    `communication_protocol` STRING COMMENT 'The technical protocol used to transmit EDI documents between trading partners. AS2 is the most common secure protocol; VAN refers to Value-Added Network services.. Valid values are `AS2|SFTP|FTP|FTPS|VAN|API`',
    `compliance_threshold_error_rate` DECIMAL(18,2) COMMENT 'The maximum acceptable error rate (as a percentage) for EDI transactions before compliance penalties or chargebacks are triggered. Example: 2.00 means 2% error rate threshold.',
    `connection_endpoint` STRING COMMENT 'The URL, IP address, or network address used to connect to the trading partner for EDI transmission. May be an AS2 URL, SFTP host, or VAN mailbox identifier.',
    `connection_port` STRING COMMENT 'The network port number used for EDI communication. Common ports: 22 for SFTP, 443 for AS2 over HTTPS.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this EDI configuration record was first created in the system. Audit trail field for record lifecycle tracking.',
    `edi_version` STRING COMMENT 'The EDI standard version supported by this configuration. Examples: 4010, 5010 for ANSI X12; D96A, D01B for EDIFACT.',
    `effective_end_date` DATE COMMENT 'The date on which this EDI configuration ceases to be effective. Null for currently active configurations. Supports temporal validity tracking and configuration history.',
    `effective_start_date` DATE COMMENT 'The date from which this EDI configuration becomes effective and valid for use. Supports temporal validity tracking.',
    `environment_type` STRING COMMENT 'Indicates whether this EDI configuration is for production use or a non-production environment (test, development, staging). Test environments are used during EDI onboarding and integration testing.. Valid values are `production|test|development|staging`',
    `fa_sla_hours` STRING COMMENT 'The maximum number of hours allowed to send a functional acknowledgment (997) after receiving an EDI document. Failure to meet this SLA may trigger compliance chargebacks.',
    `functional_acknowledgment_required` BOOLEAN COMMENT 'Indicates whether the trading partner requires a 997 Functional Acknowledgment to be sent in response to received EDI documents. True if FA is mandatory per trading partner agreement.',
    `go_live_date` DATE COMMENT 'The date when the EDI configuration was activated for production transaction processing. Marks the transition from test to production environment.',
    `gs_qualifier` STRING COMMENT 'GS qualifier code that identifies the type of identification being used in the functional group envelope. Defines how the sender/receiver codes are interpreted.. Valid values are `01|02|12|14|ZZ`',
    `inbound_enabled` BOOLEAN COMMENT 'Indicates whether this configuration is enabled to receive inbound EDI documents from the trading partner. True if inbound processing is active.',
    `integration_health_status` STRING COMMENT 'Current operational health status of the EDI integration. Derived from recent transmission success rates, error rates, and SLA compliance. Used for proactive monitoring.. Valid values are `healthy|degraded|critical|offline`',
    `is_active` BOOLEAN COMMENT 'Indicates whether this EDI configuration is currently active and operational. False if the configuration has been deactivated or suspended.',
    `isa_qualifier` STRING COMMENT 'ISA qualifier code that identifies the type of identification being used in the EDI interchange envelope. Common values: 01=DUNS, 14=DUNS+4, ZZ=Mutually Defined. [ENUM-REF-CANDIDATE: 01|14|20|27|28|29|30|33|ZZ — 9 candidates stripped; promote to reference product]',
    `last_error_code` STRING COMMENT 'The error code or identifier for the most recent EDI processing failure. Used in conjunction with last_error_timestamp for diagnostics.',
    `last_error_description` STRING COMMENT 'Human-readable description of the most recent EDI error. Provides context for troubleshooting and resolution.',
    `last_error_timestamp` TIMESTAMP COMMENT 'The timestamp of the most recent EDI transmission or processing error. Used for troubleshooting and error resolution tracking.',
    `last_successful_transmission_timestamp` TIMESTAMP COMMENT 'The timestamp of the most recent successful EDI document transmission (inbound or outbound). Used for integration health monitoring and alerting.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this EDI configuration record was most recently modified. Audit trail field for change tracking.',
    `max_retry_attempts` STRING COMMENT 'The maximum number of times a failed EDI transmission will be retried before being marked as permanently failed and requiring manual intervention.',
    `notes` STRING COMMENT 'Free-form text field for capturing additional configuration details, special requirements, or historical context about the EDI integration.',
    `onboarding_start_date` DATE COMMENT 'The date when EDI onboarding activities began for this trading partner. Marks the start of the integration project.',
    `onboarding_status` STRING COMMENT 'Current status of the EDI onboarding lifecycle for this trading partner. Tracks progression from initial setup through testing, certification, and production activation. [ENUM-REF-CANDIDATE: not_started|in_progress|testing|certified|active|suspended|terminated — 7 candidates stripped; promote to reference product]',
    `outbound_enabled` BOOLEAN COMMENT 'Indicates whether this configuration is enabled to send outbound EDI documents to the trading partner. True if outbound processing is active.',
    `retry_policy` STRING COMMENT 'The retry strategy applied when EDI transmission failures occur. Defines how and when failed transmissions are retried.. Valid values are `immediate|exponential_backoff|scheduled|manual`',
    `supported_transaction_sets` STRING COMMENT 'Comma-separated list of EDI transaction set codes supported by this trading partner. Common retail sets: 850 (Purchase Order), 855 (PO Acknowledgment), 856 (Advance Ship Notice), 810 (Invoice), 832 (Price/Sales Catalog), 846 (Inventory Inquiry/Advice), 997 (Functional Acknowledgment).',
    CONSTRAINT pk_edi_config PRIMARY KEY(`edi_config_id`)
) COMMENT 'EDI (Electronic Data Interchange) integration configuration for each trading partner defining connection parameters and supported transaction sets. Captures vendor trading partner ID, ISA/GS qualifiers, supported EDI documents (850, 855, 856, 810, 832, 846), communication protocol (AS2, SFTP, VAN), test vs production status, functional acknowledgment SLA, and compliance thresholds that trigger chargebacks. Manages EDI onboarding lifecycle, ongoing integration health monitoring, and serves as the reference record for edi_transaction processing and error resolution.';

CREATE OR REPLACE TABLE `vibe_retail_v1`.`supplier`.`lead_time_agreement` (
    `lead_time_agreement_id` BIGINT COMMENT 'Unique identifier for the lead time agreement record. Primary key.',
    `dc_facility_id` BIGINT COMMENT 'Reference to the distribution center or warehouse that receives shipments under this agreement.',
    `inventory_node_id` BIGINT COMMENT 'Foreign key linking to inventory.inventory_node. Business justification: Lead time agreements specify delivery terms to specific DCs, stores, or cross-dock facilities. Essential for replenishment planning, inbound appointment scheduling, and on-time delivery SLA measuremen',
    `vendor_contract_id` BIGINT COMMENT 'Foreign key linking to supplier.vendor_contract. Business justification: Lead time agreements define MOQ, lead times, and delivery SLAs that are typically negotiated as part of vendor contracts. Linking to vendor_contract enables tracking agreement lineage, contract renewa',
    `vendor_id` BIGINT COMMENT 'Reference to the supplier or vendor party covered by this lead time agreement.',
    `agreement_name` STRING COMMENT 'Descriptive name or title of the lead time agreement for easy identification.',
    `agreement_number` STRING COMMENT 'Business identifier for the lead time agreement, used for external reference and vendor communication.',
    `agreement_status` STRING COMMENT 'Current lifecycle status of the lead time agreement.. Valid values are `draft|active|suspended|expired|terminated`',
    `agreement_type` STRING COMMENT 'Classification of the lead time agreement based on its purpose and operational context. VMI indicates Vendor Managed Inventory agreements.. Valid values are `standard|expedited|seasonal|promotional|emergency|vmi`',
    `auto_renewal_flag` BOOLEAN COMMENT 'Indicates whether this agreement automatically renews upon expiration.',
    `compliance_penalty_rate` DECIMAL(18,2) COMMENT 'Percentage rate applied as chargeback penalty for vendor non-compliance with lead time or delivery terms.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this lead time agreement record was first created in the system.',
    `delivery_frequency` STRING COMMENT 'Standard frequency of deliveries from vendor. DSD indicates Direct Store Delivery model.. Valid values are `daily|weekly|biweekly|monthly|on_demand|dsd`',
    `delivery_window_end_time` TIMESTAMP COMMENT 'End time of the agreed delivery window at distribution center (HH:MM format).',
    `delivery_window_start_time` TIMESTAMP COMMENT 'Start time of the agreed delivery window at distribution center (HH:MM format).',
    `edi_enabled_flag` BOOLEAN COMMENT 'Indicates whether purchase orders and ASNs are exchanged via EDI for this agreement.',
    `effective_end_date` DATE COMMENT 'Date when this lead time agreement expires or is terminated. Null for open-ended agreements.',
    `effective_start_date` DATE COMMENT 'Date when this lead time agreement becomes active and enforceable.',
    `expedited_lead_time_days` STRING COMMENT 'Reduced lead time in days available for rush or expedited orders, typically at premium cost.',
    `fill_rate_sla_percent` DECIMAL(18,2) COMMENT 'Target percentage of ordered quantity that vendor must deliver to meet order completion SLA.',
    `incoterm` STRING COMMENT 'Standard trade term defining responsibilities for shipping, insurance, and customs (e.g., FOB, CIF, DDP).. Valid values are `EXW|FOB|CIF|DDP|DAP|FCA`',
    `inner_pack_quantity` STRING COMMENT 'Number of consumer units in an inner pack within the master case, used for store-level replenishment.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this lead time agreement record was last modified.',
    `minimum_order_quantity` DECIMAL(18,2) COMMENT 'Minimum number of units that must be ordered per purchase order to meet vendor requirements.',
    `notes` STRING COMMENT 'Free-text field for additional terms, special instructions, or exceptions related to this lead time agreement.',
    `on_time_delivery_sla_percent` DECIMAL(18,2) COMMENT 'Target percentage of deliveries that must arrive within the agreed lead time window to meet SLA.',
    `order_increment_quantity` DECIMAL(18,2) COMMENT 'Quantity increment in which orders must be placed above the MOQ (e.g., must order in multiples of 12 units).',
    `origin_location` STRING COMMENT 'Geographic location or facility from which vendor ships products (city, state, country).',
    `pack_size` STRING COMMENT 'Number of consumer units contained in a single vendor pack or case.',
    `pallet_quantity` STRING COMMENT 'Standard number of cases or units per pallet for warehouse receiving and cross-docking operations.',
    `renewal_notice_days` STRING COMMENT 'Number of days advance notice required before agreement renewal or termination.',
    `scope_level` STRING COMMENT 'Granularity level at which this lead time agreement applies: vendor-wide, product category, subcategory, individual SKU, or product group.. Valid values are `vendor|category|subcategory|sku|product_group`',
    `seasonal_lead_time_adjustment_days` STRING COMMENT 'Additional days added to standard lead time during peak seasonal periods (e.g., holiday season, back-to-school).',
    `seasonal_period_end_date` DATE COMMENT 'End date of the seasonal period when lead time adjustments apply.',
    `seasonal_period_start_date` DATE COMMENT 'Start date of the seasonal period when lead time adjustments apply.',
    `sku` STRING COMMENT 'Specific SKU identifier when this agreement applies to an individual product. Null when agreement is at vendor or category level.',
    `standard_lead_time_days` STRING COMMENT 'Standard number of days from purchase order placement to goods receipt at distribution center under normal operating conditions.',
    `transportation_mode` STRING COMMENT 'Primary mode of transportation used for shipments under this agreement.. Valid values are `truck|rail|air|ocean|intermodal|parcel`',
    `unit_of_measure` STRING COMMENT 'Standard unit of measure for quantities in this agreement (each, case, pallet, weight, volume). [ENUM-REF-CANDIDATE: each|case|pallet|pound|kilogram|liter|gallon — 7 candidates stripped; promote to reference product]',
    `vmi_enabled_flag` BOOLEAN COMMENT 'Indicates whether this agreement operates under a VMI model where vendor manages inventory replenishment.',
    `created_by` STRING COMMENT 'User ID or name of the procurement specialist who created this agreement record.',
    CONSTRAINT pk_lead_time_agreement PRIMARY KEY(`lead_time_agreement_id`)
) COMMENT 'Documented lead time and MOQ (Minimum Order Quantity) agreements per vendor and product category or SKU. Captures standard lead time (days), expedited lead time, MOQ units, order increment, pack size, inner pack quantity, and seasonal lead time adjustments. Feeds Blue Yonder demand planning replenishment parameters and OTB calculations.';

CREATE OR REPLACE TABLE `vibe_retail_v1`.`supplier`.`vendor_item` (
    `vendor_item_id` BIGINT COMMENT 'Unique identifier for the vendor-item relationship record. Primary key.',
    `lead_time_agreement_id` BIGINT COMMENT 'Foreign key linking to supplier.lead_time_agreement. Business justification: Vendor_item captures item-specific lead times and MOQ values that should be governed by a lead_time_agreement. Adding this FK normalizes lead time and MOQ data to the authoritative agreement record. R',
    `sku_id` BIGINT COMMENT 'Reference to the internal product master record. Links vendor catalog to internal SKU (Stock Keeping Unit).',
    `vendor_contract_id` BIGINT COMMENT 'Foreign key linking to supplier.vendor_contract. Business justification: A vendor items unit_cost, cost_effective_date, cost_expiration_date, and terms (dsd_eligible_flag, vmi_enabled_flag, edi_enabled_flag) are governed by a specific vendor contract. vendor_item already ',
    `vendor_id` BIGINT COMMENT 'Reference to the supplier or vendor providing this item. Links to the vendor master record.',
    `case_pack_quantity` STRING COMMENT 'Number of individual units contained in one vendor case pack. Used for ordering and receiving calculations.',
    `vendor_item_category` STRING COMMENT 'The vendors product category classification for this item. May differ from internal merchandising hierarchy.',
    `cost_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the unit cost (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `cost_effective_date` DATE COMMENT 'The date from which the current unit cost is effective. Used for cost change tracking and historical cost analysis.',
    `cost_expiration_date` DATE COMMENT 'The date through which the current unit cost remains valid. Null indicates open-ended pricing.',
    `country_of_origin` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code indicating where the item is manufactured or produced. Required for customs, tariffs, and trade compliance.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this vendor-item record was first created in the system.',
    `vendor_item_description` STRING COMMENT 'The vendors description of the item as it appears in their catalog. May differ from internal product description.',
    `dsd_eligible_flag` BOOLEAN COMMENT 'Indicates whether this item can be delivered directly to stores by the vendor, bypassing the DC (Distribution Center). Common for beverages, bread, and snacks.',
    `ean` STRING COMMENT '13-digit European Article Number barcode identifier used internationally for retail product identification.. Valid values are `^[0-9]{13}$`',
    `edi_enabled_flag` BOOLEAN COMMENT 'Indicates whether purchase orders and ASN (Advanced Shipping Notice) transactions for this vendor-item are transmitted via EDI (Electronic Data Interchange).',
    `effective_end_date` DATE COMMENT 'The date through which this vendor-item relationship remains active. Null indicates an open-ended relationship.',
    `effective_start_date` DATE COMMENT 'The date from which this vendor-item relationship became active and available for ordering.',
    `gtin` STRING COMMENT 'Global Trade Item Number assigned by GS1 for worldwide product identification. Can be 8, 12, 13, or 14 digits.. Valid values are `^[0-9]{8,14}$`',
    `inner_pack_quantity` STRING COMMENT 'Number of individual units contained in one inner pack within a case. Used for shelf-ready packaging and store replenishment.',
    `last_cost_change_date` DATE COMMENT 'The date when the unit cost was last modified. Used for cost trend analysis and vendor negotiation tracking.',
    `last_order_date` DATE COMMENT 'The date when this vendor-item combination was last ordered. Used to identify slow-moving or obsolete vendor relationships.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'The date and time when this vendor-item record was last modified.',
    `notes` STRING COMMENT 'Free-form text field for additional information about this vendor-item relationship, such as special handling instructions or ordering restrictions.',
    `pallet_hi` STRING COMMENT 'Number of layers (tiers) stacked on a pallet. Part of the TI/HI pallet configuration used in warehouse and DC operations.',
    `pallet_ti` STRING COMMENT 'Number of cases per layer on a pallet. Part of the TI/HI pallet configuration used in warehouse and DC (Distribution Center) operations.',
    `preferred_vendor_flag` BOOLEAN COMMENT 'Indicates whether this vendor is the preferred source for this item when multiple vendors supply the same product. Used in automated sourcing decisions.',
    `private_label_flag` BOOLEAN COMMENT 'Indicates whether this item is a private label (store brand) product manufactured exclusively for the retailer by this vendor.',
    `seasonal_lead_time_adjustment_days` STRING COMMENT 'Additional lead time days required during peak seasonal periods (e.g., holiday season). Added to standard lead time for seasonal planning.',
    `unit_cost` DECIMAL(18,2) COMMENT 'The cost per individual unit charged by the vendor. Used for COGS (Cost of Goods Sold) calculations and margin analysis. Excludes freight and other charges.',
    `upc` STRING COMMENT '12-digit Universal Product Code barcode identifier used primarily in North America for retail scanning at POS (Point of Sale).. Valid values are `^[0-9]{12}$`',
    `vendor_item_number` STRING COMMENT 'The vendors unique part number or catalog identifier for this item. Used in purchase orders and EDI (Electronic Data Interchange) transactions.',
    `vendor_item_status` STRING COMMENT 'Current lifecycle status of this vendor-item relationship. Active items are available for ordering; discontinued items are being phased out.. Valid values are `active|inactive|discontinued|pending|suspended`',
    `vendor_pack_configuration` STRING COMMENT 'Description of how the vendor packages this item (e.g., case pack, master carton, pallet). Defines the vendors standard shipping unit.',
    `vmi_enabled_flag` BOOLEAN COMMENT 'Indicates whether this vendor-item combination is managed under a VMI (Vendor Managed Inventory) agreement where the vendor controls replenishment.',
    CONSTRAINT pk_vendor_item PRIMARY KEY(`vendor_item_id`)
) COMMENT 'Vendor-specific item catalog linking vendor part numbers, UPCs, GTINs, and EANs to internal SKUs. Captures vendor item number, vendor pack configuration, case pack quantity, inner pack, pallet TI/HI, unit cost, cost effective date, country of origin, and item status. Includes lead time and MOQ agreements per vendor-item combination: standard lead time (days), expedited lead time, MOQ units, order increment, pack size, inner pack quantity, seasonal lead time adjustments, and category-level defaults. Serves as the cross-reference between vendor catalogs and the internal product master, and feeds Blue Yonder demand planning replenishment parameters and OTB calculations.';

CREATE OR REPLACE TABLE `vibe_retail_v1`.`supplier`.`vendor_allowance` (
    `vendor_allowance_id` BIGINT COMMENT 'Unique identifier for the vendor allowance record. Primary key.',
    `circular_ad_id` BIGINT COMMENT 'Foreign key linking to promotion.circular_ad. Business justification: Co-op advertising is a core retail process: vendors pay allowances specifically to fund circular ad placements. Retailers track vendor-funded circular placement — matching allowance payments to the ',
    `cluster_id` BIGINT COMMENT 'Foreign key linking to store.cluster. Business justification: Trade promotion allowances in retail are routinely negotiated at the store-cluster level (e.g., regional promotional funding for a cluster of stores). Linking vendor_allowance to cluster enables clust',
    `promo_campaign_id` BIGINT COMMENT 'Identifier linking the allowance to a specific promotional campaign or event if the allowance is promotion-specific.',
    `promo_offer_id` BIGINT COMMENT 'Foreign key linking to promotion.promo_offer. Business justification: Vendor allowances frequently fund specific promotional offers (e.g., temporary price reductions, BOGOs) rather than entire campaigns. Merchandising teams reconcile allowance accruals and claims agains',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: Vendor allowances (scan-based trading, promotional funding, volume rebates) are frequently SKU-specific or apply to defined SKU lists. Business process: promotional cost accounting, margin analysis, a',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to supplychain.purchase_order. Business justification: Allowances (rebates, volume discounts, promotional funding) accrue based on qualifying PO spend. Retail finance teams reconcile allowance claims to PO history for accrual accuracy, settlement validati',
    `vendor_contract_id` BIGINT COMMENT 'Foreign key linking to supplier.vendor_contract. Business justification: Vendor_allowance currently has contract_reference as a STRING field. Trade allowances, co-op funds, and promotional funding are typically defined in vendor contracts. Normalizing this to a FK enables ',
    `vendor_id` BIGINT COMMENT 'Identifier of the supplier or vendor providing the allowance. Links to the vendor master record.',
    `vendor_promo_agreement_id` BIGINT COMMENT 'Foreign key linking to promotion.vendor_promo_agreement. Business justification: Vendor allowances are the financial execution of vendor_promo_agreements. AP teams perform promotional funding reconciliation — matching allowance payments received against committed funding in the ',
    `accrual_method` STRING COMMENT 'Method by which the allowance is accrued in financial systems: invoice-based (at purchase), sales-based (at POS), volume-based (cumulative tier), time-based (periodic), or event-based (specific milestone).. Valid values are `invoice_based|sales_based|volume_based|time_based|event_based`',
    `accrued_amount` DECIMAL(18,2) COMMENT 'Total monetary value of allowances earned but not yet settled or paid by the vendor.',
    `allowance_amount` DECIMAL(18,2) COMMENT 'Fixed monetary value of the allowance if structured as a lump sum payment or credit.',
    `allowance_description` STRING COMMENT 'Detailed narrative description of the allowance terms, purpose, and business rationale.',
    `allowance_number` STRING COMMENT 'Business identifier or agreement number for the vendor allowance as referenced in contracts and supplier communications.',
    `allowance_percentage` DECIMAL(18,2) COMMENT 'Percentage rate applied to qualifying purchase volume or sales to calculate the allowance value.',
    `allowance_status` STRING COMMENT 'Current lifecycle status of the vendor allowance agreement.. Valid values are `draft|active|suspended|expired|settled|cancelled`',
    `allowance_type` STRING COMMENT 'Classification of the vendor allowance mechanism: off-invoice (deducted at purchase), bill-back (claimed post-sale), scan-based (tied to POS data), slotting fee (shelf placement), co-op advertising (marketing fund), or volume rebate (tier-based discount).. Valid values are `off_invoice|bill_back|scan_based|slotting_fee|co_op_advertising|volume_rebate`',
    `approval_status` STRING COMMENT 'Internal approval workflow status for the allowance setup or claim.. Valid values are `pending_approval|approved|rejected`',
    `approved_by` STRING COMMENT 'Name or identifier of the procurement or finance manager who approved the allowance agreement or claim.',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when the allowance was approved in the system.',
    `claimed_amount` DECIMAL(18,2) COMMENT 'Total monetary value of allowances formally claimed from the vendor through bill-back or settlement process.',
    `cost_center_code` STRING COMMENT 'Cost center or profit center code associated with the allowance for internal financial allocation and P&L reporting.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the vendor allowance record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the allowance monetary values.. Valid values are `^[A-Z]{3}$`',
    `disputed_amount` DECIMAL(18,2) COMMENT 'Monetary value of allowances under dispute or chargeback contention with the vendor.',
    `effective_end_date` DATE COMMENT 'Date when the vendor allowance agreement expires or is no longer eligible for new accruals.',
    `effective_start_date` DATE COMMENT 'Date when the vendor allowance agreement becomes active and eligible for accrual.',
    `gl_account_code` STRING COMMENT 'General ledger account code to which the vendor allowance is posted for financial reporting and cost of goods sold (COGS) adjustment.',
    `last_claim_date` DATE COMMENT 'Most recent date when an allowance claim was submitted to the vendor.',
    `last_settlement_date` DATE COMMENT 'Most recent date when the vendor made a payment or credit against the allowance.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Date and time when the vendor allowance record was most recently modified.',
    `minimum_purchase_amount` DECIMAL(18,2) COMMENT 'Minimum purchase value required to qualify for the allowance.',
    `minimum_purchase_quantity` DECIMAL(18,2) COMMENT 'Minimum order quantity (MOQ) in units required to qualify for the allowance.',
    `notes` STRING COMMENT 'Free-text field for additional comments, special instructions, or clarifications regarding the allowance agreement or settlement.',
    `payment_method` STRING COMMENT 'Mechanism by which the vendor settles the allowance: credit memo, check, electronic funds transfer (EFT), invoice offset, or promotional credit.. Valid values are `credit_memo|check|eft|offset_invoice|promotional_credit`',
    `payment_terms` STRING COMMENT 'Negotiated terms for allowance settlement timing and conditions, such as net 30, net 60, or upon claim submission.',
    `product_category` STRING COMMENT 'Merchandise category or product line to which the allowance applies, used for category management and gross margin return on investment (GMROI) analysis.',
    `qualifying_condition` STRING COMMENT 'Business rules and criteria that must be met to earn or claim the allowance, such as minimum order quantity (MOQ), purchase volume thresholds, promotional participation, or compliance requirements.',
    `redemption_end_date` DATE COMMENT 'Final date by which accrued allowances must be claimed or they expire.',
    `redemption_start_date` DATE COMMENT 'Earliest date when accrued allowances can be claimed or redeemed from the vendor.',
    `settled_amount` DECIMAL(18,2) COMMENT 'Total monetary value of allowances paid or credited by the vendor.',
    `settlement_status` STRING COMMENT 'Current state of financial settlement for the allowance: pending claim, partially paid, fully paid, under dispute, or written off.. Valid values are `pending|partially_settled|fully_settled|disputed|written_off`',
    `sku_list` STRING COMMENT 'Comma-separated or structured list of specific SKUs (Stock Keeping Units) eligible for the allowance, if restricted to specific items.',
    CONSTRAINT pk_vendor_allowance PRIMARY KEY(`vendor_allowance_id`)
) COMMENT 'Vendor-funded trade allowances, co-op advertising funds, slotting fees, promotional funding, and volume rebates negotiated with suppliers. Tracks allowance type (off-invoice, bill-back, scan-based), allowance amount or percentage, qualifying conditions, accrual method, redemption period, and settlement status. Critical for net landed cost and P&L accuracy.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_contact` ADD CONSTRAINT `fk_supplier_vendor_contact_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_retail_v1`.`supplier`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_address` ADD CONSTRAINT `fk_supplier_vendor_address_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_retail_v1`.`supplier`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_contract` ADD CONSTRAINT `fk_supplier_vendor_contract_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_retail_v1`.`supplier`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_retail_v1`.`supplier`.`chargeback` ADD CONSTRAINT `fk_supplier_chargeback_lead_time_agreement_id` FOREIGN KEY (`lead_time_agreement_id`) REFERENCES `vibe_retail_v1`.`supplier`.`lead_time_agreement`(`lead_time_agreement_id`);
ALTER TABLE `vibe_retail_v1`.`supplier`.`chargeback` ADD CONSTRAINT `fk_supplier_chargeback_vendor_contract_id` FOREIGN KEY (`vendor_contract_id`) REFERENCES `vibe_retail_v1`.`supplier`.`vendor_contract`(`vendor_contract_id`);
ALTER TABLE `vibe_retail_v1`.`supplier`.`chargeback` ADD CONSTRAINT `fk_supplier_chargeback_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_retail_v1`.`supplier`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_retail_v1`.`supplier`.`chargeback` ADD CONSTRAINT `fk_supplier_chargeback_vendor_item_id` FOREIGN KEY (`vendor_item_id`) REFERENCES `vibe_retail_v1`.`supplier`.`vendor_item`(`vendor_item_id`);
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_scorecard` ADD CONSTRAINT `fk_supplier_vendor_scorecard_vendor_contract_id` FOREIGN KEY (`vendor_contract_id`) REFERENCES `vibe_retail_v1`.`supplier`.`vendor_contract`(`vendor_contract_id`);
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_scorecard` ADD CONSTRAINT `fk_supplier_vendor_scorecard_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_retail_v1`.`supplier`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_retail_v1`.`supplier`.`edi_config` ADD CONSTRAINT `fk_supplier_edi_config_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_retail_v1`.`supplier`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_retail_v1`.`supplier`.`edi_config` ADD CONSTRAINT `fk_supplier_edi_config_vendor_contract_id` FOREIGN KEY (`vendor_contract_id`) REFERENCES `vibe_retail_v1`.`supplier`.`vendor_contract`(`vendor_contract_id`);
ALTER TABLE `vibe_retail_v1`.`supplier`.`lead_time_agreement` ADD CONSTRAINT `fk_supplier_lead_time_agreement_vendor_contract_id` FOREIGN KEY (`vendor_contract_id`) REFERENCES `vibe_retail_v1`.`supplier`.`vendor_contract`(`vendor_contract_id`);
ALTER TABLE `vibe_retail_v1`.`supplier`.`lead_time_agreement` ADD CONSTRAINT `fk_supplier_lead_time_agreement_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_retail_v1`.`supplier`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_item` ADD CONSTRAINT `fk_supplier_vendor_item_lead_time_agreement_id` FOREIGN KEY (`lead_time_agreement_id`) REFERENCES `vibe_retail_v1`.`supplier`.`lead_time_agreement`(`lead_time_agreement_id`);
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_item` ADD CONSTRAINT `fk_supplier_vendor_item_vendor_contract_id` FOREIGN KEY (`vendor_contract_id`) REFERENCES `vibe_retail_v1`.`supplier`.`vendor_contract`(`vendor_contract_id`);
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_item` ADD CONSTRAINT `fk_supplier_vendor_item_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_retail_v1`.`supplier`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_allowance` ADD CONSTRAINT `fk_supplier_vendor_allowance_vendor_contract_id` FOREIGN KEY (`vendor_contract_id`) REFERENCES `vibe_retail_v1`.`supplier`.`vendor_contract`(`vendor_contract_id`);
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_allowance` ADD CONSTRAINT `fk_supplier_vendor_allowance_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_retail_v1`.`supplier`.`vendor`(`vendor_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_retail_v1`.`supplier` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `vibe_retail_v1`.`supplier` SET TAGS ('dbx_domain' = 'supplier');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor` SET TAGS ('dbx_subdomain' = 'vendor_master');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor` ALTER COLUMN `contract_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Expiry Date');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor` ALTER COLUMN `diversity_certification` SET TAGS ('dbx_business_glossary_term' = 'Diversity Certification Type');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor` ALTER COLUMN `duns_number` SET TAGS ('dbx_business_glossary_term' = 'Data Universal Numbering System (DUNS) Number');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor` ALTER COLUMN `duns_number` SET TAGS ('dbx_value_regex' = '^[0-9]{9}$');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor` ALTER COLUMN `duns_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor` ALTER COLUMN `duns_number` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor` ALTER COLUMN `edi_capable_flag` SET TAGS ('dbx_business_glossary_term' = 'Electronic Data Interchange (EDI) Capable Flag');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor` ALTER COLUMN `edi_identifier` SET TAGS ('dbx_business_glossary_term' = 'Electronic Data Interchange (EDI) Identifier');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor` ALTER COLUMN `insurance_certificate_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Insurance Certificate Expiry Date');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time Days');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Modified By User ID');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor` ALTER COLUMN `moq_units` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity (MOQ) Units');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor` ALTER COLUMN `vendor_name` SET TAGS ('dbx_business_glossary_term' = 'Vendor Legal Name');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor` ALTER COLUMN `vendor_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor` ALTER COLUMN `vendor_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor` ALTER COLUMN `onboarding_date` SET TAGS ('dbx_business_glossary_term' = 'Vendor Onboarding Date');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'ach|wire_transfer|check|eft|credit_card|virtual_card');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor` ALTER COLUMN `payment_terms_code` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms Code');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Email Address');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Person Name');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Phone Number');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor` ALTER COLUMN `remittance_email` SET TAGS ('dbx_business_glossary_term' = 'Remittance Email Address');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor` ALTER COLUMN `remittance_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor` ALTER COLUMN `remittance_email` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor` ALTER COLUMN `remittance_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor` ALTER COLUMN `risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Vendor Risk Rating');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor` ALTER COLUMN `risk_rating` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor` ALTER COLUMN `sustainability_certified_flag` SET TAGS ('dbx_business_glossary_term' = 'Sustainability Certified Flag');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor` ALTER COLUMN `tax_classification` SET TAGS ('dbx_business_glossary_term' = 'Tax Classification Type');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor` ALTER COLUMN `tax_classification` SET TAGS ('dbx_value_regex' = 'w9_us_person|w8_foreign_entity|exempt_organization|government_entity');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_business_glossary_term' = 'Tax Identification Number');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor` ALTER COLUMN `vendor_status` SET TAGS ('dbx_business_glossary_term' = 'Vendor Lifecycle Status');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor` ALTER COLUMN `vendor_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|pending_approval|blocked|terminated');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor` ALTER COLUMN `vendor_type` SET TAGS ('dbx_business_glossary_term' = 'Vendor Type Classification');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor` ALTER COLUMN `vendor_type` SET TAGS ('dbx_value_regex' = 'national_brand|private_label|dsd_vendor|3pl_partner|service_provider|raw_material_supplier');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor` ALTER COLUMN `vmi_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Vendor Managed Inventory (VMI) Enabled Flag');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_contact` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_contact` SET TAGS ('dbx_subdomain' = 'vendor_master');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_contact` ALTER COLUMN `vendor_contact_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Contact ID');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_contact` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_contact` ALTER COLUMN `address_line_1` SET TAGS ('dbx_business_glossary_term' = 'Address Line 1');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_contact` ALTER COLUMN `address_line_1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_contact` ALTER COLUMN `address_line_1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_contact` ALTER COLUMN `address_line_2` SET TAGS ('dbx_business_glossary_term' = 'Address Line 2');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_contact` ALTER COLUMN `address_line_2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_contact` ALTER COLUMN `address_line_2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_contact` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_contact` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_contact` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_contact` ALTER COLUMN `contact_status` SET TAGS ('dbx_business_glossary_term' = 'Contact Status');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_contact` ALTER COLUMN `contact_status` SET TAGS ('dbx_value_regex' = 'active|inactive|on_leave|terminated');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_contact` ALTER COLUMN `contact_type` SET TAGS ('dbx_business_glossary_term' = 'Contact Type');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_contact` ALTER COLUMN `contact_type` SET TAGS ('dbx_value_regex' = 'account_manager|edi_coordinator|compliance_contact|executive_sponsor|logistics_coordinator|quality_assurance');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_contact` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_contact` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_contact` ALTER COLUMN `department` SET TAGS ('dbx_business_glossary_term' = 'Department');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_contact` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_contact` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_contact` ALTER COLUMN `email_address` SET TAGS ('dbx_business_glossary_term' = 'Email Address');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_contact` ALTER COLUMN `email_address` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_contact` ALTER COLUMN `email_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_contact` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_contact` ALTER COLUMN `email_address` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_contact` ALTER COLUMN `fax_number` SET TAGS ('dbx_business_glossary_term' = 'Fax Number');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_contact` ALTER COLUMN `fax_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_contact` ALTER COLUMN `fax_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_contact` ALTER COLUMN `fax_number` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_contact` ALTER COLUMN `first_name` SET TAGS ('dbx_business_glossary_term' = 'First Name');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_contact` ALTER COLUMN `first_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_contact` ALTER COLUMN `first_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_contact` ALTER COLUMN `first_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_contact` ALTER COLUMN `is_escalation_contact` SET TAGS ('dbx_business_glossary_term' = 'Is Escalation Contact');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_contact` ALTER COLUMN `is_primary_contact` SET TAGS ('dbx_business_glossary_term' = 'Is Primary Contact');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_contact` ALTER COLUMN `job_title` SET TAGS ('dbx_business_glossary_term' = 'Job Title');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_contact` ALTER COLUMN `language_preference` SET TAGS ('dbx_business_glossary_term' = 'Language Preference');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_contact` ALTER COLUMN `language_preference` SET TAGS ('dbx_value_regex' = 'ENG|SPA|FRA|DEU|CHN|JPN');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_contact` ALTER COLUMN `last_contact_date` SET TAGS ('dbx_business_glossary_term' = 'Last Contact Date');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_contact` ALTER COLUMN `last_name` SET TAGS ('dbx_business_glossary_term' = 'Last Name');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_contact` ALTER COLUMN `last_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_contact` ALTER COLUMN `last_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_contact` ALTER COLUMN `last_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_contact` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_contact` ALTER COLUMN `middle_name` SET TAGS ('dbx_business_glossary_term' = 'Middle Name');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_contact` ALTER COLUMN `middle_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_contact` ALTER COLUMN `middle_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_contact` ALTER COLUMN `mobile_number` SET TAGS ('dbx_business_glossary_term' = 'Mobile Number');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_contact` ALTER COLUMN `mobile_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_contact` ALTER COLUMN `mobile_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_contact` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_contact` ALTER COLUMN `office_location` SET TAGS ('dbx_business_glossary_term' = 'Office Location');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_contact` ALTER COLUMN `phone_number` SET TAGS ('dbx_business_glossary_term' = 'Phone Number');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_contact` ALTER COLUMN `phone_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_contact` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_contact` ALTER COLUMN `phone_number` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_contact` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_contact` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_contact` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_contact` ALTER COLUMN `preferred_communication_channel` SET TAGS ('dbx_business_glossary_term' = 'Preferred Communication Channel');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_contact` ALTER COLUMN `preferred_communication_channel` SET TAGS ('dbx_value_regex' = 'email|phone|mobile|fax|edi|portal');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_contact` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'State or Province');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_contact` ALTER COLUMN `state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_contact` ALTER COLUMN `state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_contact` ALTER COLUMN `time_zone` SET TAGS ('dbx_business_glossary_term' = 'Time Zone');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_address` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_address` SET TAGS ('dbx_subdomain' = 'vendor_master');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_address` ALTER COLUMN `vendor_address_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Address ID');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_address` ALTER COLUMN `vendor_address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_address` ALTER COLUMN `vendor_address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_address` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_address` ALTER COLUMN `address_line_1` SET TAGS ('dbx_business_glossary_term' = 'Address Line 1');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_address` ALTER COLUMN `address_line_1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_address` ALTER COLUMN `address_line_1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_address` ALTER COLUMN `address_line_2` SET TAGS ('dbx_business_glossary_term' = 'Address Line 2');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_address` ALTER COLUMN `address_line_2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_address` ALTER COLUMN `address_line_2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_address` ALTER COLUMN `address_line_3` SET TAGS ('dbx_business_glossary_term' = 'Address Line 3');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_address` ALTER COLUMN `address_line_3` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_address` ALTER COLUMN `address_line_3` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_address` ALTER COLUMN `address_name` SET TAGS ('dbx_business_glossary_term' = 'Address Name');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_address` ALTER COLUMN `address_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_address` ALTER COLUMN `address_name` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_address` ALTER COLUMN `address_status` SET TAGS ('dbx_business_glossary_term' = 'Address Status');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_address` ALTER COLUMN `address_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending_validation|invalid|temporary');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_address` ALTER COLUMN `address_status` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_address` ALTER COLUMN `address_status` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_address` ALTER COLUMN `address_type` SET TAGS ('dbx_business_glossary_term' = 'Address Type');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_address` ALTER COLUMN `address_type` SET TAGS ('dbx_value_regex' = 'headquarters|remittance|ship_from|returns|billing|warehouse');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_address` ALTER COLUMN `address_type` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_address` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_address` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_address` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_address` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_address` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_address` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_address` ALTER COLUMN `duns_number` SET TAGS ('dbx_business_glossary_term' = 'Data Universal Numbering System (DUNS) Number');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_address` ALTER COLUMN `duns_number` SET TAGS ('dbx_value_regex' = '^[0-9]{9}$');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_address` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_address` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_address` ALTER COLUMN `email_address` SET TAGS ('dbx_business_glossary_term' = 'Email Address');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_address` ALTER COLUMN `email_address` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_address` ALTER COLUMN `email_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_address` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_address` ALTER COLUMN `email_address` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_address` ALTER COLUMN `fax_number` SET TAGS ('dbx_business_glossary_term' = 'Fax Number');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_address` ALTER COLUMN `fax_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_address` ALTER COLUMN `fax_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_address` ALTER COLUMN `fax_number` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_address` ALTER COLUMN `gln` SET TAGS ('dbx_business_glossary_term' = 'Global Location Number (GLN)');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_address` ALTER COLUMN `gln` SET TAGS ('dbx_value_regex' = '^[0-9]{13}$');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_address` ALTER COLUMN `is_dsd_location` SET TAGS ('dbx_business_glossary_term' = 'Is Direct Store Delivery (DSD) Location');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_address` ALTER COLUMN `is_primary_address` SET TAGS ('dbx_business_glossary_term' = 'Is Primary Address');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_address` ALTER COLUMN `is_primary_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_address` ALTER COLUMN `is_primary_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_address` ALTER COLUMN `is_remittance_address` SET TAGS ('dbx_business_glossary_term' = 'Is Remittance Address');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_address` ALTER COLUMN `is_remittance_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_address` ALTER COLUMN `is_remittance_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_address` ALTER COLUMN `is_rtv_address` SET TAGS ('dbx_business_glossary_term' = 'Is Return to Vendor (RTV) Address');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_address` ALTER COLUMN `is_rtv_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_address` ALTER COLUMN `is_rtv_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_address` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_address` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_address` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_address` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_address` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_address` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_address` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_address` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_address` ALTER COLUMN `phone_number` SET TAGS ('dbx_business_glossary_term' = 'Phone Number');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_address` ALTER COLUMN `phone_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_address` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_address` ALTER COLUMN `phone_number` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_address` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_address` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_address` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_address` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'State or Province');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_address` ALTER COLUMN `state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_address` ALTER COLUMN `state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_address` ALTER COLUMN `tax_jurisdiction_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Jurisdiction Code');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_address` ALTER COLUMN `time_zone` SET TAGS ('dbx_business_glossary_term' = 'Time Zone');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_address` ALTER COLUMN `validation_date` SET TAGS ('dbx_business_glossary_term' = 'Validation Date');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_address` ALTER COLUMN `validation_source` SET TAGS ('dbx_business_glossary_term' = 'Validation Source');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_address` ALTER COLUMN `validation_status` SET TAGS ('dbx_business_glossary_term' = 'Validation Status');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_address` ALTER COLUMN `validation_status` SET TAGS ('dbx_value_regex' = 'validated|unvalidated|failed|partial');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_contract` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_contract` SET TAGS ('dbx_subdomain' = 'vendor_master');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_contract` ALTER COLUMN `vendor_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Contract ID');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_contract` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Receiving Location Id (Foreign Key)');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_contract` ALTER COLUMN `sales_territory_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Territory Id (Foreign Key)');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_contract` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_contract` ALTER COLUMN `auto_renewal_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto Renewal Flag');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_contract` ALTER COLUMN `chargeback_terms` SET TAGS ('dbx_business_glossary_term' = 'Chargeback Terms');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_contract` ALTER COLUMN `compliance_certifications_required` SET TAGS ('dbx_business_glossary_term' = 'Compliance Certifications Required');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_contract` ALTER COLUMN `contract_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Contract Currency Code');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_contract` ALTER COLUMN `contract_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_contract` ALTER COLUMN `contract_document_url` SET TAGS ('dbx_business_glossary_term' = 'Contract Document URL');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_contract` ALTER COLUMN `contract_document_url` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_contract` ALTER COLUMN `contract_number` SET TAGS ('dbx_business_glossary_term' = 'Contract Number');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_contract` ALTER COLUMN `contract_status` SET TAGS ('dbx_business_glossary_term' = 'Contract Status');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_contract` ALTER COLUMN `contract_type` SET TAGS ('dbx_business_glossary_term' = 'Contract Type');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_contract` ALTER COLUMN `contract_type` SET TAGS ('dbx_value_regex' = 'national_brand|private_label|dsd|master_service_agreement|blanket_order|framework_agreement');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_contract` ALTER COLUMN `contract_value_amount` SET TAGS ('dbx_business_glossary_term' = 'Contract Value Amount');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_contract` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_contract` ALTER COLUMN `discount_percentage` SET TAGS ('dbx_business_glossary_term' = 'Discount Percentage');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_contract` ALTER COLUMN `edi_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Electronic Data Interchange (EDI) Enabled Flag');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_contract` ALTER COLUMN `edi_identifier` SET TAGS ('dbx_business_glossary_term' = 'EDI Identifier');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_contract` ALTER COLUMN `edi_qualifier` SET TAGS ('dbx_business_glossary_term' = 'EDI Qualifier');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_contract` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_contract` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_contract` ALTER COLUMN `exclusivity_flag` SET TAGS ('dbx_business_glossary_term' = 'Exclusivity Flag');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_contract` ALTER COLUMN `incoterms_code` SET TAGS ('dbx_business_glossary_term' = 'Incoterms Code');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_contract` ALTER COLUMN `insurance_requirements` SET TAGS ('dbx_business_glossary_term' = 'Insurance Requirements');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_contract` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_contract` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time Days');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_contract` ALTER COLUMN `minimum_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity (MOQ)');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_contract` ALTER COLUMN `moq_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'MOQ Unit of Measure');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_contract` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Contract Notes');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_contract` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_contract` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'ach|wire_transfer|check|edi_payment|credit_card|letter_of_credit');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_contract` ALTER COLUMN `payment_terms_code` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms Code');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_contract` ALTER COLUMN `quality_assurance_terms` SET TAGS ('dbx_business_glossary_term' = 'Quality Assurance Terms');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_contract` ALTER COLUMN `renewal_term_months` SET TAGS ('dbx_business_glossary_term' = 'Renewal Term Months');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_contract` ALTER COLUMN `return_to_vendor_policy` SET TAGS ('dbx_business_glossary_term' = 'Return to Vendor (RTV) Policy');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_contract` ALTER COLUMN `shipping_point` SET TAGS ('dbx_business_glossary_term' = 'Shipping Point');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_contract` ALTER COLUMN `signature_date` SET TAGS ('dbx_business_glossary_term' = 'Signature Date');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_contract` ALTER COLUMN `termination_notice_days` SET TAGS ('dbx_business_glossary_term' = 'Termination Notice Days');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_contract` ALTER COLUMN `vendor_signatory_name` SET TAGS ('dbx_business_glossary_term' = 'Vendor Signatory Name');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_contract` ALTER COLUMN `vendor_signatory_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_contract` ALTER COLUMN `vendor_signatory_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_contract` ALTER COLUMN `vendor_signatory_title` SET TAGS ('dbx_business_glossary_term' = 'Vendor Signatory Title');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_contract` ALTER COLUMN `vendor_signature_date` SET TAGS ('dbx_business_glossary_term' = 'Vendor Signature Date');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_contract` ALTER COLUMN `vmi_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Vendor Managed Inventory (VMI) Enabled Flag');
ALTER TABLE `vibe_retail_v1`.`supplier`.`chargeback` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_retail_v1`.`supplier`.`chargeback` SET TAGS ('dbx_subdomain' = 'trading_compliance');
ALTER TABLE `vibe_retail_v1`.`supplier`.`chargeback` ALTER COLUMN `chargeback_id` SET TAGS ('dbx_business_glossary_term' = 'Chargeback ID');
ALTER TABLE `vibe_retail_v1`.`supplier`.`chargeback` ALTER COLUMN `dc_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Center (DC) ID');
ALTER TABLE `vibe_retail_v1`.`supplier`.`chargeback` ALTER COLUMN `goods_receipt_id` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt Id (Foreign Key)');
ALTER TABLE `vibe_retail_v1`.`supplier`.`chargeback` ALTER COLUMN `inbound_shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Inbound Shipment Id (Foreign Key)');
ALTER TABLE `vibe_retail_v1`.`supplier`.`chargeback` ALTER COLUMN `lead_time_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Lead Time Agreement Id (Foreign Key)');
ALTER TABLE `vibe_retail_v1`.`supplier`.`chargeback` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) ID');
ALTER TABLE `vibe_retail_v1`.`supplier`.`chargeback` ALTER COLUMN `receiving_event_id` SET TAGS ('dbx_business_glossary_term' = 'Receiving Event Id (Foreign Key)');
ALTER TABLE `vibe_retail_v1`.`supplier`.`chargeback` ALTER COLUMN `rma_id` SET TAGS ('dbx_business_glossary_term' = 'Returns Rma Id (Foreign Key)');
ALTER TABLE `vibe_retail_v1`.`supplier`.`chargeback` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id (Foreign Key)');
ALTER TABLE `vibe_retail_v1`.`supplier`.`chargeback` ALTER COLUMN `vendor_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Contract Id (Foreign Key)');
ALTER TABLE `vibe_retail_v1`.`supplier`.`chargeback` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `vibe_retail_v1`.`supplier`.`chargeback` ALTER COLUMN `vendor_item_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Item Id (Foreign Key)');
ALTER TABLE `vibe_retail_v1`.`supplier`.`chargeback` ALTER COLUMN `vendor_promo_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Promo Agreement Id (Foreign Key)');
ALTER TABLE `vibe_retail_v1`.`supplier`.`chargeback` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Violation Location Id (Foreign Key)');
ALTER TABLE `vibe_retail_v1`.`supplier`.`chargeback` ALTER COLUMN `affected_units` SET TAGS ('dbx_business_glossary_term' = 'Affected Units');
ALTER TABLE `vibe_retail_v1`.`supplier`.`chargeback` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_retail_v1`.`supplier`.`chargeback` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_retail_v1`.`supplier`.`chargeback` ALTER COLUMN `approved_by` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_retail_v1`.`supplier`.`chargeback` ALTER COLUMN `approved_by` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_retail_v1`.`supplier`.`chargeback` ALTER COLUMN `chargeback_number` SET TAGS ('dbx_business_glossary_term' = 'Chargeback Number');
ALTER TABLE `vibe_retail_v1`.`supplier`.`chargeback` ALTER COLUMN `chargeback_status` SET TAGS ('dbx_business_glossary_term' = 'Chargeback Status');
ALTER TABLE `vibe_retail_v1`.`supplier`.`chargeback` ALTER COLUMN `chargeback_type` SET TAGS ('dbx_business_glossary_term' = 'Chargeback Type');
ALTER TABLE `vibe_retail_v1`.`supplier`.`chargeback` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_retail_v1`.`supplier`.`chargeback` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_retail_v1`.`supplier`.`chargeback` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|CAD|EUR|GBP|MXN|JPY');
ALTER TABLE `vibe_retail_v1`.`supplier`.`chargeback` ALTER COLUMN `debit_memo_number` SET TAGS ('dbx_business_glossary_term' = 'Debit Memo Number');
ALTER TABLE `vibe_retail_v1`.`supplier`.`chargeback` ALTER COLUMN `detection_date` SET TAGS ('dbx_business_glossary_term' = 'Detection Date');
ALTER TABLE `vibe_retail_v1`.`supplier`.`chargeback` ALTER COLUMN `dispute_date` SET TAGS ('dbx_business_glossary_term' = 'Dispute Date');
ALTER TABLE `vibe_retail_v1`.`supplier`.`chargeback` ALTER COLUMN `dispute_reason` SET TAGS ('dbx_business_glossary_term' = 'Dispute Reason');
ALTER TABLE `vibe_retail_v1`.`supplier`.`chargeback` ALTER COLUMN `dispute_status` SET TAGS ('dbx_business_glossary_term' = 'Dispute Status');
ALTER TABLE `vibe_retail_v1`.`supplier`.`chargeback` ALTER COLUMN `dispute_status` SET TAGS ('dbx_value_regex' = 'not_disputed|disputed|under_investigation|resolved_vendor_favor|resolved_retailer_favor');
ALTER TABLE `vibe_retail_v1`.`supplier`.`chargeback` ALTER COLUMN `is_repeat_violation` SET TAGS ('dbx_business_glossary_term' = 'Is Repeat Violation');
ALTER TABLE `vibe_retail_v1`.`supplier`.`chargeback` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `vibe_retail_v1`.`supplier`.`chargeback` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_retail_v1`.`supplier`.`chargeback` ALTER COLUMN `notification_method` SET TAGS ('dbx_business_glossary_term' = 'Notification Method');
ALTER TABLE `vibe_retail_v1`.`supplier`.`chargeback` ALTER COLUMN `notification_method` SET TAGS ('dbx_value_regex' = 'vendor_portal|edi|email|fax|mail');
ALTER TABLE `vibe_retail_v1`.`supplier`.`chargeback` ALTER COLUMN `notification_sent_date` SET TAGS ('dbx_business_glossary_term' = 'Notification Sent Date');
ALTER TABLE `vibe_retail_v1`.`supplier`.`chargeback` ALTER COLUMN `penalty_amount` SET TAGS ('dbx_business_glossary_term' = 'Penalty Amount');
ALTER TABLE `vibe_retail_v1`.`supplier`.`chargeback` ALTER COLUMN `penalty_calculation_method` SET TAGS ('dbx_business_glossary_term' = 'Penalty Calculation Method');
ALTER TABLE `vibe_retail_v1`.`supplier`.`chargeback` ALTER COLUMN `penalty_calculation_method` SET TAGS ('dbx_value_regex' = 'flat_fee|percentage_of_order|per_unit|per_carton|per_pallet|tiered');
ALTER TABLE `vibe_retail_v1`.`supplier`.`chargeback` ALTER COLUMN `penalty_percentage` SET TAGS ('dbx_business_glossary_term' = 'Penalty Percentage');
ALTER TABLE `vibe_retail_v1`.`supplier`.`chargeback` ALTER COLUMN `previous_violation_count` SET TAGS ('dbx_business_glossary_term' = 'Previous Violation Count');
ALTER TABLE `vibe_retail_v1`.`supplier`.`chargeback` ALTER COLUMN `recovery_date` SET TAGS ('dbx_business_glossary_term' = 'Recovery Date');
ALTER TABLE `vibe_retail_v1`.`supplier`.`chargeback` ALTER COLUMN `recovery_method` SET TAGS ('dbx_business_glossary_term' = 'Recovery Method');
ALTER TABLE `vibe_retail_v1`.`supplier`.`chargeback` ALTER COLUMN `recovery_method` SET TAGS ('dbx_value_regex' = 'ap_deduction|debit_memo|credit_memo|offset_future_payment|written_off');
ALTER TABLE `vibe_retail_v1`.`supplier`.`chargeback` ALTER COLUMN `resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Resolution Date');
ALTER TABLE `vibe_retail_v1`.`supplier`.`chargeback` ALTER COLUMN `resolution_notes` SET TAGS ('dbx_business_glossary_term' = 'Resolution Notes');
ALTER TABLE `vibe_retail_v1`.`supplier`.`chargeback` ALTER COLUMN `vendor_scorecard_impact` SET TAGS ('dbx_business_glossary_term' = 'Vendor Scorecard Impact');
ALTER TABLE `vibe_retail_v1`.`supplier`.`chargeback` ALTER COLUMN `vendor_scorecard_impact` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_retail_v1`.`supplier`.`chargeback` ALTER COLUMN `violation_category` SET TAGS ('dbx_business_glossary_term' = 'Violation Category');
ALTER TABLE `vibe_retail_v1`.`supplier`.`chargeback` ALTER COLUMN `violation_date` SET TAGS ('dbx_business_glossary_term' = 'Violation Date');
ALTER TABLE `vibe_retail_v1`.`supplier`.`chargeback` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_scorecard` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_scorecard` SET TAGS ('dbx_subdomain' = 'trading_compliance');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_scorecard` ALTER COLUMN `vendor_scorecard_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Scorecard ID');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_scorecard` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Supply Purchase Order Id (Foreign Key)');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_scorecard` ALTER COLUMN `vendor_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Contract Id (Foreign Key)');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_scorecard` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_scorecard` ALTER COLUMN `chargeback_amount` SET TAGS ('dbx_business_glossary_term' = 'Chargeback Amount');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_scorecard` ALTER COLUMN `chargeback_count` SET TAGS ('dbx_business_glossary_term' = 'Chargeback Count');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_scorecard` ALTER COLUMN `composite_score` SET TAGS ('dbx_business_glossary_term' = 'Composite Score');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_scorecard` ALTER COLUMN `corrective_action_due_date` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Due Date');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_scorecard` ALTER COLUMN `corrective_action_required` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Required');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_scorecard` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_scorecard` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_scorecard` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_scorecard` ALTER COLUMN `edi_compliance_rate` SET TAGS ('dbx_business_glossary_term' = 'Electronic Data Interchange (EDI) Compliance Rate');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_scorecard` ALTER COLUMN `evaluation_date` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Date');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_scorecard` ALTER COLUMN `fill_rate` SET TAGS ('dbx_business_glossary_term' = 'Fill Rate');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_scorecard` ALTER COLUMN `invoice_accuracy_rate` SET TAGS ('dbx_business_glossary_term' = 'Invoice Accuracy Rate');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_scorecard` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_scorecard` ALTER COLUMN `lead_time_adherence_rate` SET TAGS ('dbx_business_glossary_term' = 'Lead Time Adherence Rate');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_scorecard` ALTER COLUMN `minimum_order_quantity_compliance_rate` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity (MOQ) Compliance Rate');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_scorecard` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Scorecard Notes');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_scorecard` ALTER COLUMN `on_time_delivery_rate` SET TAGS ('dbx_business_glossary_term' = 'On-Time Delivery Rate');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_scorecard` ALTER COLUMN `prior_period_composite_score` SET TAGS ('dbx_business_glossary_term' = 'Prior Period Composite Score');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_scorecard` ALTER COLUMN `product_quality_score` SET TAGS ('dbx_business_glossary_term' = 'Product Quality Score');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_scorecard` ALTER COLUMN `return_to_vendor_amount` SET TAGS ('dbx_business_glossary_term' = 'Return to Vendor (RTV) Amount');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_scorecard` ALTER COLUMN `return_to_vendor_count` SET TAGS ('dbx_business_glossary_term' = 'Return to Vendor (RTV) Count');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_scorecard` ALTER COLUMN `score_trend` SET TAGS ('dbx_business_glossary_term' = 'Score Trend');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_scorecard` ALTER COLUMN `score_trend` SET TAGS ('dbx_value_regex' = 'improving|stable|declining');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_scorecard` ALTER COLUMN `scorecard_number` SET TAGS ('dbx_business_glossary_term' = 'Scorecard Number');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_scorecard` ALTER COLUMN `scorecard_number` SET TAGS ('dbx_value_regex' = '^SC-[0-9]{8}$');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_scorecard` ALTER COLUMN `scorecard_number` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_scorecard` ALTER COLUMN `scorecard_status` SET TAGS ('dbx_business_glossary_term' = 'Scorecard Status');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_scorecard` ALTER COLUMN `scorecard_status` SET TAGS ('dbx_value_regex' = 'draft|published|under_review|finalized|archived');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_scorecard` ALTER COLUMN `scorecard_status` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_scorecard` ALTER COLUMN `scoring_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Scoring Period End Date');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_scorecard` ALTER COLUMN `scoring_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Scoring Period Start Date');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_scorecard` ALTER COLUMN `total_purchase_order_count` SET TAGS ('dbx_business_glossary_term' = 'Total Purchase Order (PO) Count');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_scorecard` ALTER COLUMN `total_purchase_order_value` SET TAGS ('dbx_business_glossary_term' = 'Total Purchase Order (PO) Value');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_scorecard` ALTER COLUMN `vendor_acknowledgment_date` SET TAGS ('dbx_business_glossary_term' = 'Vendor Acknowledgment Date');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_scorecard` ALTER COLUMN `vendor_notification_date` SET TAGS ('dbx_business_glossary_term' = 'Vendor Notification Date');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_scorecard` ALTER COLUMN `vendor_tier` SET TAGS ('dbx_business_glossary_term' = 'Vendor Tier');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_scorecard` ALTER COLUMN `vendor_tier` SET TAGS ('dbx_value_regex' = 'preferred|approved|conditional|probation|suspended');
ALTER TABLE `vibe_retail_v1`.`supplier`.`edi_config` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_retail_v1`.`supplier`.`edi_config` SET TAGS ('dbx_subdomain' = 'trading_compliance');
ALTER TABLE `vibe_retail_v1`.`supplier`.`edi_config` ALTER COLUMN `edi_config_id` SET TAGS ('dbx_business_glossary_term' = 'Electronic Data Interchange (EDI) Configuration ID');
ALTER TABLE `vibe_retail_v1`.`supplier`.`edi_config` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Trading Partner ID');
ALTER TABLE `vibe_retail_v1`.`supplier`.`edi_config` ALTER COLUMN `vendor_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Contract Id (Foreign Key)');
ALTER TABLE `vibe_retail_v1`.`supplier`.`edi_config` ALTER COLUMN `alert_email_addresses` SET TAGS ('dbx_business_glossary_term' = 'Alert Email Addresses');
ALTER TABLE `vibe_retail_v1`.`supplier`.`edi_config` ALTER COLUMN `alert_email_addresses` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_retail_v1`.`supplier`.`edi_config` ALTER COLUMN `alert_email_addresses` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_retail_v1`.`supplier`.`edi_config` ALTER COLUMN `alert_email_addresses` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_retail_v1`.`supplier`.`edi_config` ALTER COLUMN `authentication_method` SET TAGS ('dbx_business_glossary_term' = 'Authentication Method');
ALTER TABLE `vibe_retail_v1`.`supplier`.`edi_config` ALTER COLUMN `authentication_method` SET TAGS ('dbx_value_regex' = 'certificate|username_password|ssh_key|oauth|api_key');
ALTER TABLE `vibe_retail_v1`.`supplier`.`edi_config` ALTER COLUMN `certification_date` SET TAGS ('dbx_business_glossary_term' = 'Certification Date');
ALTER TABLE `vibe_retail_v1`.`supplier`.`edi_config` ALTER COLUMN `chargeback_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Chargeback Currency Code');
ALTER TABLE `vibe_retail_v1`.`supplier`.`edi_config` ALTER COLUMN `chargeback_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_retail_v1`.`supplier`.`edi_config` ALTER COLUMN `chargeback_penalty_amount` SET TAGS ('dbx_business_glossary_term' = 'Chargeback Penalty Amount');
ALTER TABLE `vibe_retail_v1`.`supplier`.`edi_config` ALTER COLUMN `communication_protocol` SET TAGS ('dbx_business_glossary_term' = 'Communication Protocol');
ALTER TABLE `vibe_retail_v1`.`supplier`.`edi_config` ALTER COLUMN `communication_protocol` SET TAGS ('dbx_value_regex' = 'AS2|SFTP|FTP|FTPS|VAN|API');
ALTER TABLE `vibe_retail_v1`.`supplier`.`edi_config` ALTER COLUMN `compliance_threshold_error_rate` SET TAGS ('dbx_business_glossary_term' = 'Compliance Threshold Error Rate Percentage');
ALTER TABLE `vibe_retail_v1`.`supplier`.`edi_config` ALTER COLUMN `connection_endpoint` SET TAGS ('dbx_business_glossary_term' = 'Connection Endpoint');
ALTER TABLE `vibe_retail_v1`.`supplier`.`edi_config` ALTER COLUMN `connection_endpoint` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_retail_v1`.`supplier`.`edi_config` ALTER COLUMN `connection_port` SET TAGS ('dbx_business_glossary_term' = 'Connection Port');
ALTER TABLE `vibe_retail_v1`.`supplier`.`edi_config` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_retail_v1`.`supplier`.`edi_config` ALTER COLUMN `edi_version` SET TAGS ('dbx_business_glossary_term' = 'Electronic Data Interchange (EDI) Version');
ALTER TABLE `vibe_retail_v1`.`supplier`.`edi_config` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_retail_v1`.`supplier`.`edi_config` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_retail_v1`.`supplier`.`edi_config` ALTER COLUMN `environment_type` SET TAGS ('dbx_business_glossary_term' = 'Environment Type');
ALTER TABLE `vibe_retail_v1`.`supplier`.`edi_config` ALTER COLUMN `environment_type` SET TAGS ('dbx_value_regex' = 'production|test|development|staging');
ALTER TABLE `vibe_retail_v1`.`supplier`.`edi_config` ALTER COLUMN `fa_sla_hours` SET TAGS ('dbx_business_glossary_term' = 'Functional Acknowledgment (FA) Service Level Agreement (SLA) Hours');
ALTER TABLE `vibe_retail_v1`.`supplier`.`edi_config` ALTER COLUMN `functional_acknowledgment_required` SET TAGS ('dbx_business_glossary_term' = 'Functional Acknowledgment (FA) Required');
ALTER TABLE `vibe_retail_v1`.`supplier`.`edi_config` ALTER COLUMN `go_live_date` SET TAGS ('dbx_business_glossary_term' = 'Go-Live Date');
ALTER TABLE `vibe_retail_v1`.`supplier`.`edi_config` ALTER COLUMN `gs_qualifier` SET TAGS ('dbx_business_glossary_term' = 'Application Sender/Receiver Code Qualifier (GS)');
ALTER TABLE `vibe_retail_v1`.`supplier`.`edi_config` ALTER COLUMN `gs_qualifier` SET TAGS ('dbx_value_regex' = '01|02|12|14|ZZ');
ALTER TABLE `vibe_retail_v1`.`supplier`.`edi_config` ALTER COLUMN `inbound_enabled` SET TAGS ('dbx_business_glossary_term' = 'Inbound Enabled');
ALTER TABLE `vibe_retail_v1`.`supplier`.`edi_config` ALTER COLUMN `integration_health_status` SET TAGS ('dbx_business_glossary_term' = 'Integration Health Status');
ALTER TABLE `vibe_retail_v1`.`supplier`.`edi_config` ALTER COLUMN `integration_health_status` SET TAGS ('dbx_value_regex' = 'healthy|degraded|critical|offline');
ALTER TABLE `vibe_retail_v1`.`supplier`.`edi_config` ALTER COLUMN `integration_health_status` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_retail_v1`.`supplier`.`edi_config` ALTER COLUMN `integration_health_status` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_retail_v1`.`supplier`.`edi_config` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_retail_v1`.`supplier`.`edi_config` ALTER COLUMN `isa_qualifier` SET TAGS ('dbx_business_glossary_term' = 'Interchange Sender/Receiver ID Qualifier (ISA)');
ALTER TABLE `vibe_retail_v1`.`supplier`.`edi_config` ALTER COLUMN `last_error_code` SET TAGS ('dbx_business_glossary_term' = 'Last Error Code');
ALTER TABLE `vibe_retail_v1`.`supplier`.`edi_config` ALTER COLUMN `last_error_description` SET TAGS ('dbx_business_glossary_term' = 'Last Error Description');
ALTER TABLE `vibe_retail_v1`.`supplier`.`edi_config` ALTER COLUMN `last_error_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Error Timestamp');
ALTER TABLE `vibe_retail_v1`.`supplier`.`edi_config` ALTER COLUMN `last_successful_transmission_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Successful Transmission Timestamp');
ALTER TABLE `vibe_retail_v1`.`supplier`.`edi_config` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `vibe_retail_v1`.`supplier`.`edi_config` ALTER COLUMN `max_retry_attempts` SET TAGS ('dbx_business_glossary_term' = 'Maximum Retry Attempts');
ALTER TABLE `vibe_retail_v1`.`supplier`.`edi_config` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_retail_v1`.`supplier`.`edi_config` ALTER COLUMN `onboarding_start_date` SET TAGS ('dbx_business_glossary_term' = 'Onboarding Start Date');
ALTER TABLE `vibe_retail_v1`.`supplier`.`edi_config` ALTER COLUMN `onboarding_status` SET TAGS ('dbx_business_glossary_term' = 'Onboarding Status');
ALTER TABLE `vibe_retail_v1`.`supplier`.`edi_config` ALTER COLUMN `outbound_enabled` SET TAGS ('dbx_business_glossary_term' = 'Outbound Enabled');
ALTER TABLE `vibe_retail_v1`.`supplier`.`edi_config` ALTER COLUMN `retry_policy` SET TAGS ('dbx_business_glossary_term' = 'Retry Policy');
ALTER TABLE `vibe_retail_v1`.`supplier`.`edi_config` ALTER COLUMN `retry_policy` SET TAGS ('dbx_value_regex' = 'immediate|exponential_backoff|scheduled|manual');
ALTER TABLE `vibe_retail_v1`.`supplier`.`edi_config` ALTER COLUMN `supported_transaction_sets` SET TAGS ('dbx_business_glossary_term' = 'Supported Transaction Sets');
ALTER TABLE `vibe_retail_v1`.`supplier`.`lead_time_agreement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_retail_v1`.`supplier`.`lead_time_agreement` SET TAGS ('dbx_subdomain' = 'vendor_master');
ALTER TABLE `vibe_retail_v1`.`supplier`.`lead_time_agreement` ALTER COLUMN `lead_time_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Lead Time Agreement ID');
ALTER TABLE `vibe_retail_v1`.`supplier`.`lead_time_agreement` ALTER COLUMN `dc_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Destination Distribution Center (DC) ID');
ALTER TABLE `vibe_retail_v1`.`supplier`.`lead_time_agreement` ALTER COLUMN `inventory_node_id` SET TAGS ('dbx_business_glossary_term' = 'Destination Inventory Node Id (Foreign Key)');
ALTER TABLE `vibe_retail_v1`.`supplier`.`lead_time_agreement` ALTER COLUMN `vendor_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Contract Id (Foreign Key)');
ALTER TABLE `vibe_retail_v1`.`supplier`.`lead_time_agreement` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `vibe_retail_v1`.`supplier`.`lead_time_agreement` ALTER COLUMN `agreement_name` SET TAGS ('dbx_business_glossary_term' = 'Agreement Name');
ALTER TABLE `vibe_retail_v1`.`supplier`.`lead_time_agreement` ALTER COLUMN `agreement_name` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_retail_v1`.`supplier`.`lead_time_agreement` ALTER COLUMN `agreement_number` SET TAGS ('dbx_business_glossary_term' = 'Agreement Number');
ALTER TABLE `vibe_retail_v1`.`supplier`.`lead_time_agreement` ALTER COLUMN `agreement_status` SET TAGS ('dbx_business_glossary_term' = 'Agreement Status');
ALTER TABLE `vibe_retail_v1`.`supplier`.`lead_time_agreement` ALTER COLUMN `agreement_status` SET TAGS ('dbx_value_regex' = 'draft|active|suspended|expired|terminated');
ALTER TABLE `vibe_retail_v1`.`supplier`.`lead_time_agreement` ALTER COLUMN `agreement_type` SET TAGS ('dbx_business_glossary_term' = 'Agreement Type');
ALTER TABLE `vibe_retail_v1`.`supplier`.`lead_time_agreement` ALTER COLUMN `agreement_type` SET TAGS ('dbx_value_regex' = 'standard|expedited|seasonal|promotional|emergency|vmi');
ALTER TABLE `vibe_retail_v1`.`supplier`.`lead_time_agreement` ALTER COLUMN `auto_renewal_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto Renewal Flag');
ALTER TABLE `vibe_retail_v1`.`supplier`.`lead_time_agreement` ALTER COLUMN `compliance_penalty_rate` SET TAGS ('dbx_business_glossary_term' = 'Compliance Penalty Rate');
ALTER TABLE `vibe_retail_v1`.`supplier`.`lead_time_agreement` ALTER COLUMN `compliance_penalty_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_retail_v1`.`supplier`.`lead_time_agreement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_retail_v1`.`supplier`.`lead_time_agreement` ALTER COLUMN `delivery_frequency` SET TAGS ('dbx_business_glossary_term' = 'Delivery Frequency');
ALTER TABLE `vibe_retail_v1`.`supplier`.`lead_time_agreement` ALTER COLUMN `delivery_frequency` SET TAGS ('dbx_value_regex' = 'daily|weekly|biweekly|monthly|on_demand|dsd');
ALTER TABLE `vibe_retail_v1`.`supplier`.`lead_time_agreement` ALTER COLUMN `delivery_window_end_time` SET TAGS ('dbx_business_glossary_term' = 'Delivery Window End Time');
ALTER TABLE `vibe_retail_v1`.`supplier`.`lead_time_agreement` ALTER COLUMN `delivery_window_start_time` SET TAGS ('dbx_business_glossary_term' = 'Delivery Window Start Time');
ALTER TABLE `vibe_retail_v1`.`supplier`.`lead_time_agreement` ALTER COLUMN `edi_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Electronic Data Interchange (EDI) Enabled Flag');
ALTER TABLE `vibe_retail_v1`.`supplier`.`lead_time_agreement` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_retail_v1`.`supplier`.`lead_time_agreement` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_retail_v1`.`supplier`.`lead_time_agreement` ALTER COLUMN `expedited_lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Expedited Lead Time Days');
ALTER TABLE `vibe_retail_v1`.`supplier`.`lead_time_agreement` ALTER COLUMN `fill_rate_sla_percent` SET TAGS ('dbx_business_glossary_term' = 'Fill Rate Service Level Agreement (SLA) Percent');
ALTER TABLE `vibe_retail_v1`.`supplier`.`lead_time_agreement` ALTER COLUMN `incoterm` SET TAGS ('dbx_business_glossary_term' = 'International Commercial Terms (Incoterm)');
ALTER TABLE `vibe_retail_v1`.`supplier`.`lead_time_agreement` ALTER COLUMN `incoterm` SET TAGS ('dbx_value_regex' = 'EXW|FOB|CIF|DDP|DAP|FCA');
ALTER TABLE `vibe_retail_v1`.`supplier`.`lead_time_agreement` ALTER COLUMN `inner_pack_quantity` SET TAGS ('dbx_business_glossary_term' = 'Inner Pack Quantity');
ALTER TABLE `vibe_retail_v1`.`supplier`.`lead_time_agreement` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `vibe_retail_v1`.`supplier`.`lead_time_agreement` ALTER COLUMN `minimum_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity (MOQ)');
ALTER TABLE `vibe_retail_v1`.`supplier`.`lead_time_agreement` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Agreement Notes');
ALTER TABLE `vibe_retail_v1`.`supplier`.`lead_time_agreement` ALTER COLUMN `on_time_delivery_sla_percent` SET TAGS ('dbx_business_glossary_term' = 'On-Time Delivery Service Level Agreement (SLA) Percent');
ALTER TABLE `vibe_retail_v1`.`supplier`.`lead_time_agreement` ALTER COLUMN `order_increment_quantity` SET TAGS ('dbx_business_glossary_term' = 'Order Increment Quantity');
ALTER TABLE `vibe_retail_v1`.`supplier`.`lead_time_agreement` ALTER COLUMN `origin_location` SET TAGS ('dbx_business_glossary_term' = 'Origin Location');
ALTER TABLE `vibe_retail_v1`.`supplier`.`lead_time_agreement` ALTER COLUMN `pack_size` SET TAGS ('dbx_business_glossary_term' = 'Pack Size');
ALTER TABLE `vibe_retail_v1`.`supplier`.`lead_time_agreement` ALTER COLUMN `pallet_quantity` SET TAGS ('dbx_business_glossary_term' = 'Pallet Quantity');
ALTER TABLE `vibe_retail_v1`.`supplier`.`lead_time_agreement` ALTER COLUMN `renewal_notice_days` SET TAGS ('dbx_business_glossary_term' = 'Renewal Notice Days');
ALTER TABLE `vibe_retail_v1`.`supplier`.`lead_time_agreement` ALTER COLUMN `scope_level` SET TAGS ('dbx_business_glossary_term' = 'Scope Level');
ALTER TABLE `vibe_retail_v1`.`supplier`.`lead_time_agreement` ALTER COLUMN `scope_level` SET TAGS ('dbx_value_regex' = 'vendor|category|subcategory|sku|product_group');
ALTER TABLE `vibe_retail_v1`.`supplier`.`lead_time_agreement` ALTER COLUMN `seasonal_lead_time_adjustment_days` SET TAGS ('dbx_business_glossary_term' = 'Seasonal Lead Time Adjustment Days');
ALTER TABLE `vibe_retail_v1`.`supplier`.`lead_time_agreement` ALTER COLUMN `seasonal_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Seasonal Period End Date');
ALTER TABLE `vibe_retail_v1`.`supplier`.`lead_time_agreement` ALTER COLUMN `seasonal_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Seasonal Period Start Date');
ALTER TABLE `vibe_retail_v1`.`supplier`.`lead_time_agreement` ALTER COLUMN `sku` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU)');
ALTER TABLE `vibe_retail_v1`.`supplier`.`lead_time_agreement` ALTER COLUMN `standard_lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Standard Lead Time Days');
ALTER TABLE `vibe_retail_v1`.`supplier`.`lead_time_agreement` ALTER COLUMN `transportation_mode` SET TAGS ('dbx_business_glossary_term' = 'Transportation Mode');
ALTER TABLE `vibe_retail_v1`.`supplier`.`lead_time_agreement` ALTER COLUMN `transportation_mode` SET TAGS ('dbx_value_regex' = 'truck|rail|air|ocean|intermodal|parcel');
ALTER TABLE `vibe_retail_v1`.`supplier`.`lead_time_agreement` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `vibe_retail_v1`.`supplier`.`lead_time_agreement` ALTER COLUMN `vmi_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Vendor Managed Inventory (VMI) Enabled Flag');
ALTER TABLE `vibe_retail_v1`.`supplier`.`lead_time_agreement` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_item` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_item` SET TAGS ('dbx_subdomain' = 'vendor_master');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_item` ALTER COLUMN `vendor_item_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Item ID');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_item` ALTER COLUMN `lead_time_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Lead Time Agreement Id (Foreign Key)');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_item` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Product ID');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_item` ALTER COLUMN `vendor_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Contract Id (Foreign Key)');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_item` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_item` ALTER COLUMN `case_pack_quantity` SET TAGS ('dbx_business_glossary_term' = 'Case Pack Quantity');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_item` ALTER COLUMN `vendor_item_category` SET TAGS ('dbx_business_glossary_term' = 'Vendor Item Category');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_item` ALTER COLUMN `cost_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Currency Code');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_item` ALTER COLUMN `cost_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_item` ALTER COLUMN `cost_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Cost Effective Date');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_item` ALTER COLUMN `cost_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Cost Expiration Date');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_item` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_business_glossary_term' = 'Country of Origin');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_item` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_item` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_item` ALTER COLUMN `vendor_item_description` SET TAGS ('dbx_business_glossary_term' = 'Vendor Item Description');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_item` ALTER COLUMN `dsd_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Direct Store Delivery (DSD) Eligible Flag');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_item` ALTER COLUMN `ean` SET TAGS ('dbx_business_glossary_term' = 'European Article Number (EAN)');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_item` ALTER COLUMN `ean` SET TAGS ('dbx_value_regex' = '^[0-9]{13}$');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_item` ALTER COLUMN `edi_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Electronic Data Interchange (EDI) Enabled Flag');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_item` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_item` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_item` ALTER COLUMN `gtin` SET TAGS ('dbx_business_glossary_term' = 'Global Trade Item Number (GTIN)');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_item` ALTER COLUMN `gtin` SET TAGS ('dbx_value_regex' = '^[0-9]{8,14}$');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_item` ALTER COLUMN `inner_pack_quantity` SET TAGS ('dbx_business_glossary_term' = 'Inner Pack Quantity');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_item` ALTER COLUMN `last_cost_change_date` SET TAGS ('dbx_business_glossary_term' = 'Last Cost Change Date');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_item` ALTER COLUMN `last_order_date` SET TAGS ('dbx_business_glossary_term' = 'Last Order Date');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_item` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_item` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_item` ALTER COLUMN `pallet_hi` SET TAGS ('dbx_business_glossary_term' = 'Pallet HI (High)');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_item` ALTER COLUMN `pallet_ti` SET TAGS ('dbx_business_glossary_term' = 'Pallet TI (Tier)');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_item` ALTER COLUMN `preferred_vendor_flag` SET TAGS ('dbx_business_glossary_term' = 'Preferred Vendor Flag');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_item` ALTER COLUMN `private_label_flag` SET TAGS ('dbx_business_glossary_term' = 'Private Label Flag');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_item` ALTER COLUMN `seasonal_lead_time_adjustment_days` SET TAGS ('dbx_business_glossary_term' = 'Seasonal Lead Time Adjustment (Days)');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_item` ALTER COLUMN `unit_cost` SET TAGS ('dbx_business_glossary_term' = 'Unit Cost');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_item` ALTER COLUMN `unit_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_item` ALTER COLUMN `upc` SET TAGS ('dbx_business_glossary_term' = 'Universal Product Code (UPC)');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_item` ALTER COLUMN `upc` SET TAGS ('dbx_value_regex' = '^[0-9]{12}$');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_item` ALTER COLUMN `vendor_item_number` SET TAGS ('dbx_business_glossary_term' = 'Vendor Item Number');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_item` ALTER COLUMN `vendor_item_status` SET TAGS ('dbx_business_glossary_term' = 'Vendor Item Status');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_item` ALTER COLUMN `vendor_item_status` SET TAGS ('dbx_value_regex' = 'active|inactive|discontinued|pending|suspended');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_item` ALTER COLUMN `vendor_pack_configuration` SET TAGS ('dbx_business_glossary_term' = 'Vendor Pack Configuration');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_item` ALTER COLUMN `vmi_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Vendor Managed Inventory (VMI) Enabled Flag');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_allowance` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_allowance` SET TAGS ('dbx_subdomain' = 'trading_compliance');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_allowance` ALTER COLUMN `vendor_allowance_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Allowance ID');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_allowance` ALTER COLUMN `circular_ad_id` SET TAGS ('dbx_business_glossary_term' = 'Circular Ad Id (Foreign Key)');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_allowance` ALTER COLUMN `cluster_id` SET TAGS ('dbx_business_glossary_term' = 'Cluster Id (Foreign Key)');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_allowance` ALTER COLUMN `promo_campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Promotion ID');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_allowance` ALTER COLUMN `promo_offer_id` SET TAGS ('dbx_business_glossary_term' = 'Promo Offer Id (Foreign Key)');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_allowance` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id (Foreign Key)');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_allowance` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Supply Purchase Order Id (Foreign Key)');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_allowance` ALTER COLUMN `vendor_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Contract Id (Foreign Key)');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_allowance` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_allowance` ALTER COLUMN `vendor_promo_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Promo Agreement Id (Foreign Key)');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_allowance` ALTER COLUMN `accrual_method` SET TAGS ('dbx_business_glossary_term' = 'Accrual Method');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_allowance` ALTER COLUMN `accrual_method` SET TAGS ('dbx_value_regex' = 'invoice_based|sales_based|volume_based|time_based|event_based');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_allowance` ALTER COLUMN `accrued_amount` SET TAGS ('dbx_business_glossary_term' = 'Accrued Amount');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_allowance` ALTER COLUMN `allowance_amount` SET TAGS ('dbx_business_glossary_term' = 'Allowance Amount');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_allowance` ALTER COLUMN `allowance_description` SET TAGS ('dbx_business_glossary_term' = 'Allowance Description');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_allowance` ALTER COLUMN `allowance_number` SET TAGS ('dbx_business_glossary_term' = 'Allowance Agreement Number');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_allowance` ALTER COLUMN `allowance_percentage` SET TAGS ('dbx_business_glossary_term' = 'Allowance Percentage');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_allowance` ALTER COLUMN `allowance_status` SET TAGS ('dbx_business_glossary_term' = 'Allowance Status');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_allowance` ALTER COLUMN `allowance_status` SET TAGS ('dbx_value_regex' = 'draft|active|suspended|expired|settled|cancelled');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_allowance` ALTER COLUMN `allowance_type` SET TAGS ('dbx_business_glossary_term' = 'Allowance Type');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_allowance` ALTER COLUMN `allowance_type` SET TAGS ('dbx_value_regex' = 'off_invoice|bill_back|scan_based|slotting_fee|co_op_advertising|volume_rebate');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_allowance` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_allowance` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending_approval|approved|rejected');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_allowance` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_allowance` ALTER COLUMN `approved_by` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_allowance` ALTER COLUMN `approved_by` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_allowance` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_allowance` ALTER COLUMN `claimed_amount` SET TAGS ('dbx_business_glossary_term' = 'Claimed Amount');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_allowance` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_allowance` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_allowance` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_allowance` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_allowance` ALTER COLUMN `disputed_amount` SET TAGS ('dbx_business_glossary_term' = 'Disputed Amount');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_allowance` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_allowance` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_allowance` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_allowance` ALTER COLUMN `last_claim_date` SET TAGS ('dbx_business_glossary_term' = 'Last Claim Date');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_allowance` ALTER COLUMN `last_settlement_date` SET TAGS ('dbx_business_glossary_term' = 'Last Settlement Date');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_allowance` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_allowance` ALTER COLUMN `minimum_purchase_amount` SET TAGS ('dbx_business_glossary_term' = 'Minimum Purchase Amount');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_allowance` ALTER COLUMN `minimum_purchase_quantity` SET TAGS ('dbx_business_glossary_term' = 'Minimum Purchase Quantity');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_allowance` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_allowance` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_allowance` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'credit_memo|check|eft|offset_invoice|promotional_credit');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_allowance` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_allowance` ALTER COLUMN `product_category` SET TAGS ('dbx_business_glossary_term' = 'Product Category');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_allowance` ALTER COLUMN `qualifying_condition` SET TAGS ('dbx_business_glossary_term' = 'Qualifying Condition');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_allowance` ALTER COLUMN `redemption_end_date` SET TAGS ('dbx_business_glossary_term' = 'Redemption End Date');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_allowance` ALTER COLUMN `redemption_start_date` SET TAGS ('dbx_business_glossary_term' = 'Redemption Start Date');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_allowance` ALTER COLUMN `settled_amount` SET TAGS ('dbx_business_glossary_term' = 'Settled Amount');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_allowance` ALTER COLUMN `settlement_status` SET TAGS ('dbx_business_glossary_term' = 'Settlement Status');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_allowance` ALTER COLUMN `settlement_status` SET TAGS ('dbx_value_regex' = 'pending|partially_settled|fully_settled|disputed|written_off');
ALTER TABLE `vibe_retail_v1`.`supplier`.`vendor_allowance` ALTER COLUMN `sku_list` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) List');
