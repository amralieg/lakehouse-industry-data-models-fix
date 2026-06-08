-- Schema for Domain: supplier | Business: Retail | Version: v1_mvm
-- Generated on: 2026-05-04 13:27:44

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `retail_ecm`.`supplier` COMMENT 'Authoritative source for supplier and vendor master data including contact information, contracts, compliance certifications, performance scorecards, chargebacks (vendor compliance penalties), RTV (Return to Vendor) processes, EDI integration, MOQ and lead time agreements, and VMI configurations. Manages supplier onboarding, qualification, risk assessment, and ongoing relationship management for national brands, private label manufacturers, and DSD vendors.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `retail_ecm`.`supplier`.`vendor` (
    `vendor_id` BIGINT COMMENT 'Unique identifier for the vendor. Primary key for the vendor master record.',
    `contract_expiry_date` DATE COMMENT 'Expiration date of the current master supply agreement or contract with this vendor. Used for contract renewal planning and vendor relationship management.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this vendor master record was first created in the system. Used for audit trail and data lineage tracking.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code representing the vendors preferred currency for invoicing and payment (e.g., USD, EUR, GBP, CAD).. Valid values are `^[A-Z]{3}$`',
    `diversity_certification` STRING COMMENT 'Diversity certification status of the vendor for supplier diversity programs. MBE (Minority Business Enterprise), WBE (Women Business Enterprise), DBE (Disadvantaged Business Enterprise), VBE (Veteran Business Enterprise), LGBTBE (LGBT Business Enterprise), SDVOSB (Service-Disabled Veteran-Owned Small Business), or none if not certified. [ENUM-REF-CANDIDATE: mbe|wbe|dbe|vbe|lgbtbe|sdvosb|none — 7 candidates stripped; promote to reference product]',
    `duns_number` STRING COMMENT 'Nine-digit unique identifier assigned by Dun & Bradstreet to identify business entities globally. Used for vendor qualification, credit assessment, and supplier risk management.. Valid values are `^[0-9]{9}$`',
    `edi_capable_flag` BOOLEAN COMMENT 'Boolean indicator of whether the vendor supports EDI (Electronic Data Interchange) for automated exchange of purchase orders, advance ship notices, invoices, and other business documents. True indicates EDI capability is enabled.',
    `edi_identifier` STRING COMMENT 'Unique EDI identifier or interchange ID used to route electronic documents to this vendor in EDI transactions (e.g., ISA ID, GS1 GLN).',
    `fill_rate_pct` DECIMAL(18,2) COMMENT 'Vendor performance metric representing the percentage of ordered quantity that the vendor successfully delivers (order completion percentage). A fill rate of 100% indicates all ordered items were delivered in full.',
    `insurance_certificate_expiry_date` DATE COMMENT 'Expiration date of the vendors general liability and product liability insurance certificate. Used to ensure vendors maintain required insurance coverage as per contract terms.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this vendor master record was last updated or modified. Used for change tracking and data quality monitoring.',
    `last_purchase_order_date` DATE COMMENT 'Date of the most recent purchase order issued to this vendor. Used to identify inactive vendors and support vendor rationalization initiatives.',
    `lead_time_days` STRING COMMENT 'Standard lead time in days from purchase order placement to delivery at the distribution center or store. Used for replenishment planning and inventory management.',
    `modified_by_user` STRING COMMENT 'User ID or system identifier of the person or process that last modified this vendor record. Used for audit trail and accountability.',
    `moq_units` DECIMAL(18,2) COMMENT 'Minimum Order Quantity (MOQ) in units that must be ordered from this vendor per purchase order or per SKU (Stock Keeping Unit). Used in procurement planning and order optimization.',
    `on_time_delivery_rate_pct` DECIMAL(18,2) COMMENT 'Vendor performance metric representing the percentage of orders delivered on or before the requested delivery date. Used in vendor scorecards and supplier performance management.',
    `onboarding_date` DATE COMMENT 'Date when the vendor was officially onboarded and approved for transactions in the vendor master system. Represents the start of the vendor relationship.',
    `payment_method` STRING COMMENT 'Preferred method for remitting payment to the vendor. ACH (Automated Clearing House) for electronic bank transfers, wire transfer for same-day transfers, check for paper checks, EFT (Electronic Funds Transfer) for direct deposit, credit card for card-based payments, and virtual card for single-use card numbers.. Valid values are `ach|wire_transfer|check|eft|credit_card|virtual_card`',
    `payment_terms_code` STRING COMMENT 'Standard payment terms code defining the payment schedule and discount conditions for this vendor (e.g., Net 30, 2/10 Net 30, Net 60). Determines when payment is due and any early payment discounts available.',
    `primary_contact_email` STRING COMMENT 'Email address of the primary contact person for operational communication, order management, and issue resolution.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `primary_contact_name` STRING COMMENT 'Full name of the primary contact person at the vendor organization, typically the account manager or sales representative responsible for the business relationship.',
    `primary_contact_phone` STRING COMMENT 'Primary telephone number for the vendor contact person, including country code and extension if applicable.',
    `quality_acceptance_rate_pct` DECIMAL(18,2) COMMENT 'Vendor performance metric representing the percentage of received goods that pass quality inspection and are accepted into inventory without rejection or return. Used to monitor product quality and vendor compliance.',
    `remittance_email` STRING COMMENT 'Email address for sending payment remittance advice and electronic payment notifications to the vendors accounts receivable department.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `risk_rating` STRING COMMENT 'Overall risk assessment rating for the vendor based on financial stability, operational performance, compliance history, and supply chain risk factors. Low indicates minimal risk, medium indicates moderate risk requiring monitoring, high indicates elevated risk requiring mitigation plans, and critical indicates severe risk requiring immediate action or alternative sourcing.. Valid values are `low|medium|high|critical`',
    `sustainability_certified_flag` BOOLEAN COMMENT 'Boolean indicator of whether the vendor holds recognized sustainability or environmental certifications (e.g., ISO 14001, B Corp, Fair Trade, Rainforest Alliance). True indicates the vendor has sustainability credentials.',
    `tax_classification` STRING COMMENT 'Tax classification of the vendor for withholding and reporting purposes. W-9 US person indicates a domestic US entity, W-8 foreign entity indicates a non-US entity subject to withholding, exempt organization indicates tax-exempt status, and government entity indicates a governmental body.. Valid values are `w9_us_person|w8_foreign_entity|exempt_organization|government_entity`',
    `tax_identifier` STRING COMMENT 'The vendors tax identification number (TIN) or Employer Identification Number (EIN) used for tax reporting and compliance. Format varies by jurisdiction (e.g., EIN in USA, VAT number in EU).',
    `vendor_name` STRING COMMENT 'The full legal name of the vendor or supplier as registered with governing authorities. Used for contracts, purchase orders, and legal documentation.',
    `vendor_status` STRING COMMENT 'Current operational status of the vendor in the vendor lifecycle. Active vendors are approved for transactions, inactive vendors are not currently used but remain in the system, suspended vendors are temporarily blocked due to performance or compliance issues, pending approval vendors are undergoing onboarding qualification, blocked vendors cannot transact due to critical issues, and terminated vendors have ended their relationship with the business.. Valid values are `active|inactive|suspended|pending_approval|blocked|terminated`',
    `vendor_type` STRING COMMENT 'Classification of the vendor based on the type of goods or services provided. National brand manufacturers supply branded products, private label producers manufacture store-brand products, DSD (Direct Store Delivery) vendors deliver directly to stores bypassing distribution centers, 3PL (Third-Party Logistics) partners provide logistics and fulfillment services, service providers offer non-product services, and raw material suppliers provide ingredients or components for private label manufacturing.. Valid values are `national_brand|private_label|dsd_vendor|3pl_partner|service_provider|raw_material_supplier`',
    `vmi_enabled_flag` BOOLEAN COMMENT 'Boolean indicator of whether this vendor participates in Vendor Managed Inventory (VMI) programs where the vendor monitors inventory levels and initiates replenishment orders. True indicates VMI is active for this vendor.',
    CONSTRAINT pk_vendor PRIMARY KEY(`vendor_id`)
) COMMENT 'Master record for all suppliers and vendors including national brand manufacturers, private label producers, DSD vendors, and 3PL partners. Serves as the authoritative golden record for vendor identity, classification, tax identifiers (W-9/W-8), remittance details, business type, ownership structure, diversity certifications, DUNS number, and onboarding status. Contains embedded contact persons (account managers, EDI coordinators, compliance contacts, executive sponsors) with role types, communication preferences, and escalation paths. Contains embedded multi-address records (headquarters, remittance, ship-from, RTV addresses) with geo-coordinates, address validation status, and address type classification. Sourced from Informatica MDM and SAP S/4HANA MM vendor master.';

CREATE OR REPLACE TABLE `retail_ecm`.`supplier`.`vendor_contact` (
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

CREATE OR REPLACE TABLE `retail_ecm`.`supplier`.`vendor_address` (
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

CREATE OR REPLACE TABLE `retail_ecm`.`supplier`.`vendor_contract` (
    `vendor_contract_id` BIGINT COMMENT 'Unique identifier for the vendor contract. Primary key for the vendor contract entity.',
    `buyer_id` BIGINT COMMENT 'Foreign key linking to merchandising.buyer. Business justification: Vendor contracts are negotiated, approved, and managed by the buyer responsible for that vendor relationship. Contract approval workflows route to the assigned buyer, and buyers are accountable for co',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Retail vendor contracts are tied to cost centers for open-to-buy (OTB) budget tracking and commitment accounting. Buyers manage spend by cost center; linking contracts enables automated budget consump',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Retail vendor contracts specify GL accounts for accruals, COGS allocation, and commitment accounting. Finance teams require contract-level GL coding to automate journal entries on goods receipt and fo',
    `program_id` BIGINT COMMENT 'Foreign key linking to loyalty.loyalty_program. Business justification: Vendor contracts in retail frequently include co-op marketing clauses tied to a specific loyalty program (e.g., vendor funds X points per dollar on their SKUs within the program). Linking vendor_contr',
    `location_id` BIGINT COMMENT 'Foreign key linking to store.location. Business justification: DSD and direct-delivery vendor contracts are scoped to specific store receiving locations. Retail contract compliance reporting and store-level vendor management require this link. receiving_location_',
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
    `exclusivity_scope` STRING COMMENT 'Description of the product categories, geographic regions, or channels covered by the exclusivity clause. Applicable only when exclusivity_flag is true. Defines the boundaries of the exclusive supply arrangement.',
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

CREATE OR REPLACE TABLE `retail_ecm`.`supplier`.`chargeback` (
    `chargeback_id` BIGINT COMMENT 'Unique identifier for the vendor compliance chargeback penalty record.',
    `ap_invoice_id` BIGINT COMMENT 'Reference to the AP invoice from which the chargeback penalty was deducted, if the recovery method was AP deduction.',
    `asn_id` BIGINT COMMENT 'Reference to the ASN document related to the shipment that violated compliance rules, if applicable.',
    `buying_order_id` BIGINT COMMENT 'Foreign key linking to merchandising.buying_order. Business justification: Chargebacks reference original buying orders when vendors violate compliance terms on specific merchandise purchases. Compliance teams trace routing guide violations, ASN errors, and quality issues ba',
    `buying_order_line_id` BIGINT COMMENT 'Foreign key linking to merchandising.buying_order_line. Business justification: Chargebacks in retail are assessed at the SKU/line level (short-ship, labeling violation, pack-size non-compliance). Linking chargeback to buying_order_line enables accurate penalty calculation, dispu',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Vendor compliance chargebacks are operational expenses that must be allocated to cost centers for vendor performance cost analysis, budget tracking, and supply chain expense management reporting.',
    `dc_facility_id` BIGINT COMMENT 'Reference to the distribution center or receiving facility where the compliance violation was detected.',
    `financial_period_id` BIGINT COMMENT 'Foreign key linking to finance.financial_period. Business justification: Chargebacks must be posted in the correct financial period for AP reconciliation and period-end close. Retail finance teams track chargeback accruals by fiscal period for vendor compliance reporting a',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Chargebacks post to specific GL accounts (typically vendor compliance expense or freight recovery accounts) for financial statement preparation, P&L reporting, and audit compliance in retail supply ch',
    `goods_receipt_id` BIGINT COMMENT 'Foreign key linking to inventory.goods_receipt. Business justification: Chargebacks for receipt discrepancies (short shipments, damaged goods, labeling violations) require direct link to the specific goods_receipt event for validation, dispute resolution, and vendor score',
    `inbound_shipment_id` BIGINT COMMENT 'Foreign key linking to supplychain.inbound_shipment. Business justification: Chargebacks for routing guide violations, packing non-compliance, and ASN errors are traced to the specific inbound shipment. Retail DC compliance teams require this link to audit which shipment trigg',
    `ledger_id` BIGINT COMMENT 'Foreign key linking to finance.ledger. Business justification: Retail enterprises operating under multiple accounting standards (IFRS/US GAAP) post chargebacks to specific ledgers. Ledger assignment on chargebacks is required for parallel accounting and statutory',
    `order_line_id` BIGINT COMMENT 'Foreign key linking to order.order_line. Business justification: Chargebacks are triggered by specific order line violations (short-ship, wrong item, labeling non-compliance on a specific line). Linking chargeback to order_line enables precise violation traceabilit',
    `po_line_id` BIGINT COMMENT 'Foreign key linking to supplychain.po_line. Business justification: Retail compliance chargebacks are raised at the PO line level (specific SKU/line violations: short-ship, labeling, packing). Linking chargeback to po_line enables line-level penalty calculation and di',
    `pos_transaction_id` BIGINT COMMENT 'Foreign key linking to order.pos_transaction. Business justification: DSD vendor chargebacks arising from POS-level pricing discrepancies, unauthorized promotions, or scan-based trading violations must reference the specific POS transaction for store-level dispute resol',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Retail chargebacks are allocated to profit centers for department/category P&L reporting. Finance teams require profit center assignment on chargebacks to report vendor compliance costs by business un',
    `purchase_order_id` BIGINT COMMENT 'Reference to the purchase order associated with the compliance violation that triggered this chargeback.',
    `receiving_event_id` BIGINT COMMENT 'Foreign key linking to supplychain.receiving_event. Business justification: Receiving events capture shortage_flag, overage_flag, and damage_flag — the direct operational triggers for chargeback generation in retail. Linking chargeback to receiving_event enables automated cha',
    `return_receipt_id` BIGINT COMMENT 'Foreign key linking to returns.return_receipt. Business justification: Chargebacks for receiving violations (damaged goods, short shipments) are triggered by return receipt inspection findings. The AP compliance process requires linking chargeback to the physical return ',
    `rma_id` BIGINT COMMENT 'Foreign key linking to returns.rma. Business justification: Vendor chargebacks often stem from customer returns (damaged/defective goods). AP teams reconcile chargebacks against originating RMAs to validate penalty legitimacy and negotiate vendor disputes. Ena',
    `rtv_request_id` BIGINT COMMENT 'Foreign key linking to supplier.rtv_request. Business justification: In retail vendor compliance, chargebacks can be issued as a direct result of RTV process violations — for example, when a vendor fails to comply with return routing instructions, labeling requirements',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: Chargebacks for quality, compliance, or labeling violations must identify affected SKUs. Business process: chargeback dispute resolution, root cause analysis, vendor scorecard impact assessment, and f',
    `vendor_contract_id` BIGINT COMMENT 'Foreign key linking to supplier.vendor_contract. Business justification: Chargebacks enforce contract compliance by penalizing vendors for violations. Linking to vendor_contract enables retrieving penalty schedules, dispute resolution procedures, and recovery methods defin',
    `vendor_id` BIGINT COMMENT 'Reference to the supplier or vendor against whom this chargeback penalty is issued.',
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

CREATE OR REPLACE TABLE `retail_ecm`.`supplier`.`rtv_request` (
    `rtv_request_id` BIGINT COMMENT 'Primary key for rtv_request',
    `ap_invoice_id` BIGINT COMMENT 'Foreign key linking to finance.ap_invoice. Business justification: RTVs in retail are reconciled against the original AP invoice for debit memo processing and vendor credit recovery. Retail AP teams require the invoice reference on RTV requests to validate credit amo',
    `buying_order_id` BIGINT COMMENT 'Foreign key linking to merchandising.buying_order. Business justification: RTV requests reference the original buying order that authorized the merchandise purchase being returned. Receiving teams and AP need this link to reconcile vendor credits against original purchase te',
    `buying_order_line_id` BIGINT COMMENT 'Foreign key linking to merchandising.buying_order_line. Business justification: RTVs are initiated at the line/SKU level against a specific buying order line (quality failure, recall, overstock). Retail operations require tracing each RTV to its originating buying order line for ',
    `carrier_id` BIGINT COMMENT 'Foreign key linking to fulfillment.carrier. Business justification: RTV shipments require carrier assignment for physical return of goods to vendors. rtv_request.carrier_name is a denormalized plain-text field; a proper FK to fulfillment.carrier normalizes this, enabl',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Return-to-vendor transactions impact inventory shrink and vendor quality costs that must be allocated to cost centers for operational expense tracking, budget variance analysis, and supply chain cost ',
    `dc_facility_id` BIGINT COMMENT 'Foreign key linking to supplychain.dc_facility. Business justification: RTVs originate from a DC facility where non-conforming goods are staged for return. Retail operations track RTV volume by DC for capacity planning and vendor compliance reporting. rtv_request has stor',
    `location_id` BIGINT COMMENT 'Identifier of the vendor facility or location where the returned merchandise is to be delivered.',
    `financial_period_id` BIGINT COMMENT 'Foreign key linking to finance.financial_period. Business justification: RTVs must be posted in the correct financial period for accurate inventory shrink reporting and AP reconciliation at period-end close. Retail finance teams require period assignment on RTVs to ensure ',
    `fulfillment_node_id` BIGINT COMMENT 'Foreign key linking to fulfillment.fulfillment_node. Business justification: RTVs frequently originate from DC/fulfillment nodes, not just store locations. Tracking the originating fulfillment node on an RTV request is required for DC-level RTV volume reporting, vendor credit ',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: RTVs generate inventory adjustment journal entries and vendor credit memos requiring a specific GL account for debit/credit posting. Retail AP teams require GL account on RTV requests to automate jour',
    `goods_receipt_id` BIGINT COMMENT 'Foreign key linking to inventory.goods_receipt. Business justification: RTV requests originate from defective or non-conforming goods identified at receipt. Linking to goods_receipt enables root cause analysis, quality trend tracking, and automated RMA generation tied to ',
    `inbound_shipment_id` BIGINT COMMENT 'Foreign key linking to supplychain.inbound_shipment. Business justification: RTVs are initiated when defective or non-conforming goods arrive on a specific inbound shipment. Retail operations require tracing each RTV back to its originating shipment for freight cost recovery, ',
    `lot_id` BIGINT COMMENT 'Foreign key linking to inventory.lot. Business justification: RTV requests for recalled, expired, or defective goods must reference the specific lot for FEFO compliance, food safety traceability, and recall documentation. Retail quality and compliance teams requ',
    `order_line_id` BIGINT COMMENT 'Foreign key linking to order.order_line. Business justification: RTV requests initiated from defective or non-conforming order line receipts must reference the originating order line for vendor credit reconciliation, return merchandise authorization matching, and a',
    `origin_location_id` BIGINT COMMENT 'Identifier of the retailer location (store, distribution center, or warehouse) from which the merchandise is being returned.',
    `rma_id` BIGINT COMMENT 'Foreign key linking to returns.rma. Business justification: Supplier RTVs are frequently triggered by customer returns. Buyers analyze which customer return reasons drive vendor RTVs to negotiate better contract terms and identify systemic quality issues. Enab',
    `receiving_event_id` BIGINT COMMENT 'Foreign key linking to supplychain.receiving_event. Business justification: Receiving events with quality_inspection_required_flag or damage_flag are the operational triggers for RTV requests in retail DCs. Linking rtv_request to receiving_event supports the end-to-end return',
    `return_receipt_id` BIGINT COMMENT 'Foreign key linking to returns.return_receipt. Business justification: RTV requests are initiated based on return receipt inspection results (defective/damaged goods confirmed at DC). Linking rtv_request to return_receipt provides the physical receipt evidence supporting',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: Return-to-vendor requests must specify which SKUs are being returned for defects, damage, or overstock. Business process: RTV authorization, credit memo generation, inventory disposition, quality trac',
    `stock_position_id` BIGINT COMMENT 'Foreign key linking to inventory.stock_position. Business justification: RTV authorization requires validating available stock quantity at the originating location before approving the return. Retail operations teams check stock_position to confirm sufficient on-hand quant',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to supplychain.purchase_order. Business justification: RTV requests reference originating PO for credit memo reconciliation, chargeback calculation, and vendor dispute resolution. AP teams match RTV claims to PO invoice for cost recovery. Real-world retai',
    `vendor_address_id` BIGINT COMMENT 'Foreign key linking to supplier.vendor_address. Business justification: RTV requests must specify the vendors physical return address — where merchandise is being shipped back to. The vendor_address table has an is_rtv_address BOOLEAN flag explicitly designed to identify',
    `vendor_contact_id` BIGINT COMMENT 'Identifier of the specific vendor contact person handling this RTV request on the supplier side.',
    `vendor_contract_id` BIGINT COMMENT 'Foreign key linking to supplier.vendor_contract. Business justification: RTV requests are authorized and governed by the terms defined in the vendor contract (specifically the return_to_vendor_policy field on vendor_contract). Linking rtv_request to vendor_contract enables',
    `vendor_id` BIGINT COMMENT 'Identifier of the supplier or vendor to whom the merchandise is being returned. Links to the vendor master record.',
    `approver_name` STRING COMMENT 'The name of the retailer manager or authorized personnel who approved the RTV request before submission to the vendor.',
    `authorization_date` DATE COMMENT 'The date when the vendor approved and authorized the return, issuing the RMA number.',
    `chargeback_amount` DECIMAL(18,2) COMMENT 'The monetary penalty amount assessed against the vendor for non-compliance or quality failures that triggered the return. Part of vendor performance management.',
    `chargeback_reason` STRING COMMENT 'Explanation of the vendor compliance violation or quality issue that resulted in the chargeback penalty.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this RTV request record was first created in the system. Used for audit trail and data lineage.',
    `credit_date` DATE COMMENT 'The date when the vendor issued credit or replacement for the returned merchandise.',
    `credit_memo_number` STRING COMMENT 'The credit memo number issued by the vendor to document the financial credit provided for the returned merchandise.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the return value (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `disposition_method` STRING COMMENT 'The method by which the vendor will handle the returned merchandise and compensate the retailer (e.g., issue credit, send replacement, authorize destruction).. Valid values are `credit|replacement|repair|destroy|donate|salvage`',
    `edi_control_number` STRING COMMENT 'The unique control number assigned to the EDI transmission of this RTV request for tracking and reconciliation purposes.',
    `edi_transaction_set` STRING COMMENT 'The EDI transaction set identifier used for electronic communication of this RTV request with the vendor (e.g., EDI 180 Return Merchandise Authorization).',
    `freight_cost` DECIMAL(18,2) COMMENT 'The actual or estimated cost of freight for shipping the returned merchandise back to the vendor.',
    `freight_responsibility` STRING COMMENT 'Indicates which party (vendor or retailer) is responsible for paying the freight costs associated with returning the merchandise.. Valid values are `vendor|retailer|shared|prepaid_and_add|collect`',
    `inspection_result` STRING COMMENT 'The outcome of the vendors quality inspection of the returned merchandise, determining eligibility for credit or replacement.. Valid values are `passed|failed|partial|pending|not_applicable`',
    `invoice_number` STRING COMMENT 'The vendor invoice number associated with the original purchase of the merchandise being returned. Used for credit memo reconciliation.',
    `is_recall_related` BOOLEAN COMMENT 'Boolean flag indicating whether this RTV request is related to a product recall mandated by regulatory authorities or the manufacturer.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this RTV request record was most recently modified. Used for audit trail and change tracking.',
    `notes` STRING COMMENT 'Free-text field for additional comments, special instructions, or contextual information related to the RTV request.',
    `quality_inspection_required` BOOLEAN COMMENT 'Boolean flag indicating whether the vendor requires a quality inspection of the returned merchandise before issuing credit or replacement.',
    `recall_number` STRING COMMENT 'The official recall identification number issued by the regulatory body or manufacturer if this RTV is recall-related.',
    `received_date` DATE COMMENT 'The date when the vendor confirmed receipt of the returned merchandise at their facility.',
    `request_date` DATE COMMENT 'The date when the RTV request was initiated by the retailer. This is the principal business event timestamp for the transaction.',
    `return_reason_code` STRING COMMENT 'Standardized code indicating the business reason for returning the merchandise to the vendor. Used for vendor performance tracking and chargeback determination. [ENUM-REF-CANDIDATE: defective|damaged|overstock|seasonal_clearance|recall|quality_failure|expired|wrong_item|obsolete|vendor_error — 10 candidates stripped; promote to reference product]',
    `return_reason_description` STRING COMMENT 'Detailed free-text explanation of the reason for the return, providing additional context beyond the standardized reason code.',
    `rma_number` STRING COMMENT 'The authorization number issued by the vendor permitting the return of merchandise. This is the externally-known business identifier for the RTV transaction.. Valid values are `^[A-Z0-9]{8,20}$`',
    `rtv_status` STRING COMMENT 'Current lifecycle status of the RTV request indicating its position in the return workflow from draft through final credit or closure. [ENUM-REF-CANDIDATE: draft|submitted|approved|rejected|in_transit|received|credited|closed|cancelled — 9 candidates stripped; promote to reference product]',
    `ship_date` DATE COMMENT 'The date when the returned merchandise was shipped back to the vendor from the retailers location.',
    `total_return_quantity` DECIMAL(18,2) COMMENT 'The total quantity of units being returned to the vendor across all SKUs in this RTV request, measured in the base unit of measure.',
    `total_return_value` DECIMAL(18,2) COMMENT 'The total monetary value of the merchandise being returned, calculated at cost basis. Represents the expected credit or reimbursement amount.',
    `tracking_number` STRING COMMENT 'The tracking number provided by the carrier for monitoring the shipment of returned merchandise in transit.',
    CONSTRAINT pk_rtv_request PRIMARY KEY(`rtv_request_id`)
) COMMENT 'Return to Vendor (RTV) requests authorizing the return of merchandise to suppliers due to defects, overstock, seasonal clearance, product recalls, or quality failures. Tracks RMA number, return reason code, SKU and quantity, return authorization date, disposition method (credit, replacement, destroy), freight responsibility, and RTV status. Sourced from Salesforce Service Cloud and SAP MM.';

CREATE OR REPLACE TABLE `retail_ecm`.`supplier`.`vendor_scorecard` (
    `vendor_scorecard_id` BIGINT COMMENT 'Unique identifier for the vendor scorecard record. Primary key. Role: TRANSACTION_HEADER (scorecard is a periodic performance evaluation event).',
    `buyer_id` BIGINT COMMENT 'Foreign key linking to merchandising.buyer. Business justification: Vendor scorecards are reviewed and acted upon by the buyer managing that vendor relationship. Buyer performance evaluations, vendor selection decisions, and contract renewal workflows depend on scorec',
    `category_id` BIGINT COMMENT 'Foreign key linking to merchandising.category. Business justification: Retail vendor scorecards are evaluated at the category level (e.g., produce, apparel). Category managers use category-scoped scorecards for vendor rationalization, line review decisions, and category ',
    `dc_facility_id` BIGINT COMMENT 'Foreign key linking to supplychain.dc_facility. Business justification: Retail buyers evaluate vendor performance by DC to identify facility-specific issues (e.g., a vendor performing well nationally but poorly at one DC). Vendor scorecards scoped to a DC enable targeted ',
    `financial_period_id` BIGINT COMMENT 'Foreign key linking to finance.financial_period. Business justification: Vendor scorecards are produced aligned to fiscal periods for period-end chargeback reconciliation and vendor accrual decisions. Retail finance teams require scorecard-to-period alignment for accurate ',
    `item_hierarchy_id` BIGINT COMMENT 'Foreign key linking to product.item_hierarchy. Business justification: Retail vendor scorecards are evaluated at the category level — buyers score vendor performance per category (e.g., beverages, snacks). Linking vendor_scorecard to item_hierarchy enables category-level',
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

CREATE OR REPLACE TABLE `retail_ecm`.`supplier`.`lead_time_agreement` (
    `lead_time_agreement_id` BIGINT COMMENT 'Unique identifier for the lead time agreement record. Primary key.',
    `assortment_plan_id` BIGINT COMMENT 'Foreign key linking to merchandising.assortment_plan. Business justification: Assortment planning depends on lead time agreements to set first-receipt dates, buy deadlines, and seasonal receipt windows. Retail planners must know which lead time agreement constrains an assortmen',
    `dc_facility_id` BIGINT COMMENT 'Reference to the distribution center or warehouse that receives shipments under this agreement.',
    `inventory_node_id` BIGINT COMMENT 'Foreign key linking to inventory.inventory_node. Business justification: Lead time agreements specify delivery terms to specific DCs, stores, or cross-dock facilities. Essential for replenishment planning, inbound appointment scheduling, and on-time delivery SLA measuremen',
    `category_id` BIGINT COMMENT 'Reference to the product category covered by this agreement when scope_level is category or subcategory.',
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

CREATE OR REPLACE TABLE `retail_ecm`.`supplier`.`vendor_item` (
    `vendor_item_id` BIGINT COMMENT 'Unique identifier for the vendor-item relationship record. Primary key.',
    `assortment_item_id` BIGINT COMMENT 'Foreign key linking to merchandising.assortment_item. Business justification: Assortment planning requires referencing the specific vendor item record (unit cost, pack size, lead time, GTIN) to validate feasibility. Retail buyers building assortment plans must tie each planned ',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: In retail, vendor-item combinations are mapped to GL accounts for COGS and inventory valuation. This drives automated posting when POs are received (three-way match). Retail merchandise finance expert',
    `lead_time_agreement_id` BIGINT COMMENT 'Foreign key linking to supplier.lead_time_agreement. Business justification: Vendor_item captures item-specific lead times and MOQ values that should be governed by a lead_time_agreement. Adding this FK normalizes lead time and MOQ data to the authoritative agreement record. R',
    `return_policy_id` BIGINT COMMENT 'Foreign key linking to returns.return_policy. Business justification: Each vendor item carries a specific return policy (electronics 15-day, apparel 30-day) enforced at POS and e-commerce checkout. Linking vendor_item to return_policy enables automated return eligibilit',
    `sku_id` BIGINT COMMENT 'Reference to the internal product master record. Links vendor catalog to internal SKU (Stock Keeping Unit).',
    `vendor_id` BIGINT COMMENT 'Reference to the supplier or vendor providing this item. Links to the vendor master record.',
    `case_pack_quantity` STRING COMMENT 'Number of individual units contained in one vendor case pack. Used for ordering and receiving calculations.',
    `cost_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the unit cost (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `cost_effective_date` DATE COMMENT 'The date from which the current unit cost is effective. Used for cost change tracking and historical cost analysis.',
    `cost_expiration_date` DATE COMMENT 'The date through which the current unit cost remains valid. Null indicates open-ended pricing.',
    `country_of_origin` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code indicating where the item is manufactured or produced. Required for customs, tariffs, and trade compliance.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this vendor-item record was first created in the system.',
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
    `vendor_item_category` STRING COMMENT 'The vendors product category classification for this item. May differ from internal merchandising hierarchy.',
    `vendor_item_description` STRING COMMENT 'The vendors description of the item as it appears in their catalog. May differ from internal product description.',
    `vendor_item_number` STRING COMMENT 'The vendors unique part number or catalog identifier for this item. Used in purchase orders and EDI (Electronic Data Interchange) transactions.',
    `vendor_item_status` STRING COMMENT 'Current lifecycle status of this vendor-item relationship. Active items are available for ordering; discontinued items are being phased out.. Valid values are `active|inactive|discontinued|pending|suspended`',
    `vendor_pack_configuration` STRING COMMENT 'Description of how the vendor packages this item (e.g., case pack, master carton, pallet). Defines the vendors standard shipping unit.',
    `vmi_enabled_flag` BOOLEAN COMMENT 'Indicates whether this vendor-item combination is managed under a VMI (Vendor Managed Inventory) agreement where the vendor controls replenishment.',
    CONSTRAINT pk_vendor_item PRIMARY KEY(`vendor_item_id`)
) COMMENT 'Vendor-specific item catalog linking vendor part numbers, UPCs, GTINs, and EANs to internal SKUs. Captures vendor item number, vendor pack configuration, case pack quantity, inner pack, pallet TI/HI, unit cost, cost effective date, country of origin, and item status. Includes lead time and MOQ agreements per vendor-item combination: standard lead time (days), expedited lead time, MOQ units, order increment, pack size, inner pack quantity, seasonal lead time adjustments, and category-level defaults. Serves as the cross-reference between vendor catalogs and the internal product master, and feeds Blue Yonder demand planning replenishment parameters and OTB calculations.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `retail_ecm`.`supplier`.`vendor_contact` ADD CONSTRAINT `fk_supplier_vendor_contact_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `retail_ecm`.`supplier`.`vendor`(`vendor_id`);
ALTER TABLE `retail_ecm`.`supplier`.`vendor_address` ADD CONSTRAINT `fk_supplier_vendor_address_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `retail_ecm`.`supplier`.`vendor`(`vendor_id`);
ALTER TABLE `retail_ecm`.`supplier`.`vendor_contract` ADD CONSTRAINT `fk_supplier_vendor_contract_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `retail_ecm`.`supplier`.`vendor`(`vendor_id`);
ALTER TABLE `retail_ecm`.`supplier`.`chargeback` ADD CONSTRAINT `fk_supplier_chargeback_rtv_request_id` FOREIGN KEY (`rtv_request_id`) REFERENCES `retail_ecm`.`supplier`.`rtv_request`(`rtv_request_id`);
ALTER TABLE `retail_ecm`.`supplier`.`chargeback` ADD CONSTRAINT `fk_supplier_chargeback_vendor_contract_id` FOREIGN KEY (`vendor_contract_id`) REFERENCES `retail_ecm`.`supplier`.`vendor_contract`(`vendor_contract_id`);
ALTER TABLE `retail_ecm`.`supplier`.`chargeback` ADD CONSTRAINT `fk_supplier_chargeback_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `retail_ecm`.`supplier`.`vendor`(`vendor_id`);
ALTER TABLE `retail_ecm`.`supplier`.`rtv_request` ADD CONSTRAINT `fk_supplier_rtv_request_vendor_address_id` FOREIGN KEY (`vendor_address_id`) REFERENCES `retail_ecm`.`supplier`.`vendor_address`(`vendor_address_id`);
ALTER TABLE `retail_ecm`.`supplier`.`rtv_request` ADD CONSTRAINT `fk_supplier_rtv_request_vendor_contact_id` FOREIGN KEY (`vendor_contact_id`) REFERENCES `retail_ecm`.`supplier`.`vendor_contact`(`vendor_contact_id`);
ALTER TABLE `retail_ecm`.`supplier`.`rtv_request` ADD CONSTRAINT `fk_supplier_rtv_request_vendor_contract_id` FOREIGN KEY (`vendor_contract_id`) REFERENCES `retail_ecm`.`supplier`.`vendor_contract`(`vendor_contract_id`);
ALTER TABLE `retail_ecm`.`supplier`.`rtv_request` ADD CONSTRAINT `fk_supplier_rtv_request_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `retail_ecm`.`supplier`.`vendor`(`vendor_id`);
ALTER TABLE `retail_ecm`.`supplier`.`vendor_scorecard` ADD CONSTRAINT `fk_supplier_vendor_scorecard_vendor_contract_id` FOREIGN KEY (`vendor_contract_id`) REFERENCES `retail_ecm`.`supplier`.`vendor_contract`(`vendor_contract_id`);
ALTER TABLE `retail_ecm`.`supplier`.`vendor_scorecard` ADD CONSTRAINT `fk_supplier_vendor_scorecard_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `retail_ecm`.`supplier`.`vendor`(`vendor_id`);
ALTER TABLE `retail_ecm`.`supplier`.`lead_time_agreement` ADD CONSTRAINT `fk_supplier_lead_time_agreement_vendor_contract_id` FOREIGN KEY (`vendor_contract_id`) REFERENCES `retail_ecm`.`supplier`.`vendor_contract`(`vendor_contract_id`);
ALTER TABLE `retail_ecm`.`supplier`.`lead_time_agreement` ADD CONSTRAINT `fk_supplier_lead_time_agreement_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `retail_ecm`.`supplier`.`vendor`(`vendor_id`);
ALTER TABLE `retail_ecm`.`supplier`.`vendor_item` ADD CONSTRAINT `fk_supplier_vendor_item_lead_time_agreement_id` FOREIGN KEY (`lead_time_agreement_id`) REFERENCES `retail_ecm`.`supplier`.`lead_time_agreement`(`lead_time_agreement_id`);
ALTER TABLE `retail_ecm`.`supplier`.`vendor_item` ADD CONSTRAINT `fk_supplier_vendor_item_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `retail_ecm`.`supplier`.`vendor`(`vendor_id`);

-- ========= TAGS =========
ALTER SCHEMA `retail_ecm`.`supplier` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `retail_ecm`.`supplier` SET TAGS ('dbx_domain' = 'supplier');
ALTER TABLE `retail_ecm`.`supplier`.`vendor` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `retail_ecm`.`supplier`.`vendor` SET TAGS ('dbx_subdomain' = 'vendor_management');
ALTER TABLE `retail_ecm`.`supplier`.`vendor` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `retail_ecm`.`supplier`.`vendor` ALTER COLUMN `contract_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Expiry Date');
ALTER TABLE `retail_ecm`.`supplier`.`vendor` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `retail_ecm`.`supplier`.`vendor` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `retail_ecm`.`supplier`.`vendor` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `retail_ecm`.`supplier`.`vendor` ALTER COLUMN `diversity_certification` SET TAGS ('dbx_business_glossary_term' = 'Diversity Certification Type');
ALTER TABLE `retail_ecm`.`supplier`.`vendor` ALTER COLUMN `duns_number` SET TAGS ('dbx_business_glossary_term' = 'Data Universal Numbering System (DUNS) Number');
ALTER TABLE `retail_ecm`.`supplier`.`vendor` ALTER COLUMN `duns_number` SET TAGS ('dbx_value_regex' = '^[0-9]{9}$');
ALTER TABLE `retail_ecm`.`supplier`.`vendor` ALTER COLUMN `edi_capable_flag` SET TAGS ('dbx_business_glossary_term' = 'Electronic Data Interchange (EDI) Capable Flag');
ALTER TABLE `retail_ecm`.`supplier`.`vendor` ALTER COLUMN `edi_identifier` SET TAGS ('dbx_business_glossary_term' = 'Electronic Data Interchange (EDI) Identifier');
ALTER TABLE `retail_ecm`.`supplier`.`vendor` ALTER COLUMN `fill_rate_pct` SET TAGS ('dbx_business_glossary_term' = 'Fill Rate Percentage');
ALTER TABLE `retail_ecm`.`supplier`.`vendor` ALTER COLUMN `insurance_certificate_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Insurance Certificate Expiry Date');
ALTER TABLE `retail_ecm`.`supplier`.`vendor` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `retail_ecm`.`supplier`.`vendor` ALTER COLUMN `last_purchase_order_date` SET TAGS ('dbx_business_glossary_term' = 'Last Purchase Order Date');
ALTER TABLE `retail_ecm`.`supplier`.`vendor` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time Days');
ALTER TABLE `retail_ecm`.`supplier`.`vendor` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Modified By User ID');
ALTER TABLE `retail_ecm`.`supplier`.`vendor` ALTER COLUMN `moq_units` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity (MOQ) Units');
ALTER TABLE `retail_ecm`.`supplier`.`vendor` ALTER COLUMN `on_time_delivery_rate_pct` SET TAGS ('dbx_business_glossary_term' = 'On-Time Delivery Rate Percentage');
ALTER TABLE `retail_ecm`.`supplier`.`vendor` ALTER COLUMN `onboarding_date` SET TAGS ('dbx_business_glossary_term' = 'Vendor Onboarding Date');
ALTER TABLE `retail_ecm`.`supplier`.`vendor` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `retail_ecm`.`supplier`.`vendor` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'ach|wire_transfer|check|eft|credit_card|virtual_card');
ALTER TABLE `retail_ecm`.`supplier`.`vendor` ALTER COLUMN `payment_terms_code` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms Code');
ALTER TABLE `retail_ecm`.`supplier`.`vendor` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Email Address');
ALTER TABLE `retail_ecm`.`supplier`.`vendor` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `retail_ecm`.`supplier`.`vendor` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `retail_ecm`.`supplier`.`vendor` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `retail_ecm`.`supplier`.`vendor` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Person Name');
ALTER TABLE `retail_ecm`.`supplier`.`vendor` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `retail_ecm`.`supplier`.`vendor` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `retail_ecm`.`supplier`.`vendor` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Phone Number');
ALTER TABLE `retail_ecm`.`supplier`.`vendor` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `retail_ecm`.`supplier`.`vendor` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `retail_ecm`.`supplier`.`vendor` ALTER COLUMN `quality_acceptance_rate_pct` SET TAGS ('dbx_business_glossary_term' = 'Quality Acceptance Rate Percentage');
ALTER TABLE `retail_ecm`.`supplier`.`vendor` ALTER COLUMN `remittance_email` SET TAGS ('dbx_business_glossary_term' = 'Remittance Email Address');
ALTER TABLE `retail_ecm`.`supplier`.`vendor` ALTER COLUMN `remittance_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `retail_ecm`.`supplier`.`vendor` ALTER COLUMN `remittance_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `retail_ecm`.`supplier`.`vendor` ALTER COLUMN `remittance_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `retail_ecm`.`supplier`.`vendor` ALTER COLUMN `risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Vendor Risk Rating');
ALTER TABLE `retail_ecm`.`supplier`.`vendor` ALTER COLUMN `risk_rating` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `retail_ecm`.`supplier`.`vendor` ALTER COLUMN `sustainability_certified_flag` SET TAGS ('dbx_business_glossary_term' = 'Sustainability Certified Flag');
ALTER TABLE `retail_ecm`.`supplier`.`vendor` ALTER COLUMN `tax_classification` SET TAGS ('dbx_business_glossary_term' = 'Tax Classification Type');
ALTER TABLE `retail_ecm`.`supplier`.`vendor` ALTER COLUMN `tax_classification` SET TAGS ('dbx_value_regex' = 'w9_us_person|w8_foreign_entity|exempt_organization|government_entity');
ALTER TABLE `retail_ecm`.`supplier`.`vendor` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_business_glossary_term' = 'Tax Identification Number');
ALTER TABLE `retail_ecm`.`supplier`.`vendor` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `retail_ecm`.`supplier`.`vendor` ALTER COLUMN `vendor_name` SET TAGS ('dbx_business_glossary_term' = 'Vendor Legal Name');
ALTER TABLE `retail_ecm`.`supplier`.`vendor` ALTER COLUMN `vendor_status` SET TAGS ('dbx_business_glossary_term' = 'Vendor Lifecycle Status');
ALTER TABLE `retail_ecm`.`supplier`.`vendor` ALTER COLUMN `vendor_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|pending_approval|blocked|terminated');
ALTER TABLE `retail_ecm`.`supplier`.`vendor` ALTER COLUMN `vendor_type` SET TAGS ('dbx_business_glossary_term' = 'Vendor Type Classification');
ALTER TABLE `retail_ecm`.`supplier`.`vendor` ALTER COLUMN `vendor_type` SET TAGS ('dbx_value_regex' = 'national_brand|private_label|dsd_vendor|3pl_partner|service_provider|raw_material_supplier');
ALTER TABLE `retail_ecm`.`supplier`.`vendor` ALTER COLUMN `vmi_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Vendor Managed Inventory (VMI) Enabled Flag');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_contact` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_contact` SET TAGS ('dbx_subdomain' = 'vendor_management');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_contact` ALTER COLUMN `vendor_contact_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Contact ID');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_contact` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_contact` ALTER COLUMN `address_line_1` SET TAGS ('dbx_business_glossary_term' = 'Address Line 1');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_contact` ALTER COLUMN `address_line_1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_contact` ALTER COLUMN `address_line_1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_contact` ALTER COLUMN `address_line_2` SET TAGS ('dbx_business_glossary_term' = 'Address Line 2');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_contact` ALTER COLUMN `address_line_2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_contact` ALTER COLUMN `address_line_2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_contact` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_contact` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_contact` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_contact` ALTER COLUMN `contact_status` SET TAGS ('dbx_business_glossary_term' = 'Contact Status');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_contact` ALTER COLUMN `contact_status` SET TAGS ('dbx_value_regex' = 'active|inactive|on_leave|terminated');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_contact` ALTER COLUMN `contact_type` SET TAGS ('dbx_business_glossary_term' = 'Contact Type');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_contact` ALTER COLUMN `contact_type` SET TAGS ('dbx_value_regex' = 'account_manager|edi_coordinator|compliance_contact|executive_sponsor|logistics_coordinator|quality_assurance');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_contact` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_contact` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_contact` ALTER COLUMN `department` SET TAGS ('dbx_business_glossary_term' = 'Department');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_contact` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_contact` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_contact` ALTER COLUMN `email_address` SET TAGS ('dbx_business_glossary_term' = 'Email Address');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_contact` ALTER COLUMN `email_address` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_contact` ALTER COLUMN `email_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_contact` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_contact` ALTER COLUMN `fax_number` SET TAGS ('dbx_business_glossary_term' = 'Fax Number');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_contact` ALTER COLUMN `fax_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_contact` ALTER COLUMN `fax_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_contact` ALTER COLUMN `first_name` SET TAGS ('dbx_business_glossary_term' = 'First Name');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_contact` ALTER COLUMN `first_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_contact` ALTER COLUMN `first_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_contact` ALTER COLUMN `is_escalation_contact` SET TAGS ('dbx_business_glossary_term' = 'Is Escalation Contact');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_contact` ALTER COLUMN `is_primary_contact` SET TAGS ('dbx_business_glossary_term' = 'Is Primary Contact');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_contact` ALTER COLUMN `job_title` SET TAGS ('dbx_business_glossary_term' = 'Job Title');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_contact` ALTER COLUMN `language_preference` SET TAGS ('dbx_business_glossary_term' = 'Language Preference');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_contact` ALTER COLUMN `language_preference` SET TAGS ('dbx_value_regex' = 'ENG|SPA|FRA|DEU|CHN|JPN');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_contact` ALTER COLUMN `last_contact_date` SET TAGS ('dbx_business_glossary_term' = 'Last Contact Date');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_contact` ALTER COLUMN `last_name` SET TAGS ('dbx_business_glossary_term' = 'Last Name');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_contact` ALTER COLUMN `last_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_contact` ALTER COLUMN `last_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_contact` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_contact` ALTER COLUMN `middle_name` SET TAGS ('dbx_business_glossary_term' = 'Middle Name');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_contact` ALTER COLUMN `middle_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_contact` ALTER COLUMN `middle_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_contact` ALTER COLUMN `mobile_number` SET TAGS ('dbx_business_glossary_term' = 'Mobile Number');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_contact` ALTER COLUMN `mobile_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_contact` ALTER COLUMN `mobile_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_contact` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_contact` ALTER COLUMN `office_location` SET TAGS ('dbx_business_glossary_term' = 'Office Location');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_contact` ALTER COLUMN `phone_number` SET TAGS ('dbx_business_glossary_term' = 'Phone Number');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_contact` ALTER COLUMN `phone_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_contact` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_contact` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_contact` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_contact` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_contact` ALTER COLUMN `preferred_communication_channel` SET TAGS ('dbx_business_glossary_term' = 'Preferred Communication Channel');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_contact` ALTER COLUMN `preferred_communication_channel` SET TAGS ('dbx_value_regex' = 'email|phone|mobile|fax|edi|portal');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_contact` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'State or Province');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_contact` ALTER COLUMN `state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_contact` ALTER COLUMN `state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_contact` ALTER COLUMN `time_zone` SET TAGS ('dbx_business_glossary_term' = 'Time Zone');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_address` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_address` SET TAGS ('dbx_subdomain' = 'vendor_management');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_address` ALTER COLUMN `vendor_address_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Address ID');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_address` ALTER COLUMN `vendor_address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_address` ALTER COLUMN `vendor_address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_address` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_address` ALTER COLUMN `address_line_1` SET TAGS ('dbx_business_glossary_term' = 'Address Line 1');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_address` ALTER COLUMN `address_line_1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_address` ALTER COLUMN `address_line_1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_address` ALTER COLUMN `address_line_2` SET TAGS ('dbx_business_glossary_term' = 'Address Line 2');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_address` ALTER COLUMN `address_line_2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_address` ALTER COLUMN `address_line_2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_address` ALTER COLUMN `address_line_3` SET TAGS ('dbx_business_glossary_term' = 'Address Line 3');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_address` ALTER COLUMN `address_line_3` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_address` ALTER COLUMN `address_line_3` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_address` ALTER COLUMN `address_name` SET TAGS ('dbx_business_glossary_term' = 'Address Name');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_address` ALTER COLUMN `address_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_address` ALTER COLUMN `address_name` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_address` ALTER COLUMN `address_status` SET TAGS ('dbx_business_glossary_term' = 'Address Status');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_address` ALTER COLUMN `address_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending_validation|invalid|temporary');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_address` ALTER COLUMN `address_status` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_address` ALTER COLUMN `address_status` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_address` ALTER COLUMN `address_type` SET TAGS ('dbx_business_glossary_term' = 'Address Type');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_address` ALTER COLUMN `address_type` SET TAGS ('dbx_value_regex' = 'headquarters|remittance|ship_from|returns|billing|warehouse');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_address` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_address` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_address` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_address` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_address` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_address` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_address` ALTER COLUMN `duns_number` SET TAGS ('dbx_business_glossary_term' = 'Data Universal Numbering System (DUNS) Number');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_address` ALTER COLUMN `duns_number` SET TAGS ('dbx_value_regex' = '^[0-9]{9}$');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_address` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_address` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_address` ALTER COLUMN `email_address` SET TAGS ('dbx_business_glossary_term' = 'Email Address');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_address` ALTER COLUMN `email_address` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_address` ALTER COLUMN `email_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_address` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_address` ALTER COLUMN `fax_number` SET TAGS ('dbx_business_glossary_term' = 'Fax Number');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_address` ALTER COLUMN `fax_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_address` ALTER COLUMN `fax_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_address` ALTER COLUMN `gln` SET TAGS ('dbx_business_glossary_term' = 'Global Location Number (GLN)');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_address` ALTER COLUMN `gln` SET TAGS ('dbx_value_regex' = '^[0-9]{13}$');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_address` ALTER COLUMN `is_dsd_location` SET TAGS ('dbx_business_glossary_term' = 'Is Direct Store Delivery (DSD) Location');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_address` ALTER COLUMN `is_primary_address` SET TAGS ('dbx_business_glossary_term' = 'Is Primary Address');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_address` ALTER COLUMN `is_primary_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_address` ALTER COLUMN `is_primary_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_address` ALTER COLUMN `is_remittance_address` SET TAGS ('dbx_business_glossary_term' = 'Is Remittance Address');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_address` ALTER COLUMN `is_remittance_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_address` ALTER COLUMN `is_remittance_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_address` ALTER COLUMN `is_rtv_address` SET TAGS ('dbx_business_glossary_term' = 'Is Return to Vendor (RTV) Address');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_address` ALTER COLUMN `is_rtv_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_address` ALTER COLUMN `is_rtv_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_address` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_address` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_address` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_address` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_address` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_address` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_address` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_address` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_address` ALTER COLUMN `phone_number` SET TAGS ('dbx_business_glossary_term' = 'Phone Number');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_address` ALTER COLUMN `phone_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_address` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_address` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_address` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_address` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_address` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'State or Province');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_address` ALTER COLUMN `state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_address` ALTER COLUMN `state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_address` ALTER COLUMN `tax_jurisdiction_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Jurisdiction Code');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_address` ALTER COLUMN `time_zone` SET TAGS ('dbx_business_glossary_term' = 'Time Zone');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_address` ALTER COLUMN `validation_date` SET TAGS ('dbx_business_glossary_term' = 'Validation Date');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_address` ALTER COLUMN `validation_source` SET TAGS ('dbx_business_glossary_term' = 'Validation Source');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_address` ALTER COLUMN `validation_status` SET TAGS ('dbx_business_glossary_term' = 'Validation Status');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_address` ALTER COLUMN `validation_status` SET TAGS ('dbx_value_regex' = 'validated|unvalidated|failed|partial');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_contract` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_contract` SET TAGS ('dbx_subdomain' = 'vendor_management');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_contract` ALTER COLUMN `vendor_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Contract ID');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_contract` ALTER COLUMN `buyer_id` SET TAGS ('dbx_business_glossary_term' = 'Buyer Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_contract` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_contract` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_contract` ALTER COLUMN `program_id` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Program Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_contract` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Receiving Location Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_contract` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_contract` ALTER COLUMN `auto_renewal_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto Renewal Flag');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_contract` ALTER COLUMN `chargeback_terms` SET TAGS ('dbx_business_glossary_term' = 'Chargeback Terms');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_contract` ALTER COLUMN `compliance_certifications_required` SET TAGS ('dbx_business_glossary_term' = 'Compliance Certifications Required');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_contract` ALTER COLUMN `contract_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Contract Currency Code');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_contract` ALTER COLUMN `contract_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_contract` ALTER COLUMN `contract_document_url` SET TAGS ('dbx_business_glossary_term' = 'Contract Document URL');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_contract` ALTER COLUMN `contract_document_url` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_contract` ALTER COLUMN `contract_number` SET TAGS ('dbx_business_glossary_term' = 'Contract Number');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_contract` ALTER COLUMN `contract_status` SET TAGS ('dbx_business_glossary_term' = 'Contract Status');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_contract` ALTER COLUMN `contract_type` SET TAGS ('dbx_business_glossary_term' = 'Contract Type');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_contract` ALTER COLUMN `contract_type` SET TAGS ('dbx_value_regex' = 'national_brand|private_label|dsd|master_service_agreement|blanket_order|framework_agreement');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_contract` ALTER COLUMN `contract_value_amount` SET TAGS ('dbx_business_glossary_term' = 'Contract Value Amount');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_contract` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_contract` ALTER COLUMN `discount_percentage` SET TAGS ('dbx_business_glossary_term' = 'Discount Percentage');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_contract` ALTER COLUMN `edi_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Electronic Data Interchange (EDI) Enabled Flag');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_contract` ALTER COLUMN `edi_identifier` SET TAGS ('dbx_business_glossary_term' = 'EDI Identifier');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_contract` ALTER COLUMN `edi_qualifier` SET TAGS ('dbx_business_glossary_term' = 'EDI Qualifier');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_contract` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_contract` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_contract` ALTER COLUMN `exclusivity_flag` SET TAGS ('dbx_business_glossary_term' = 'Exclusivity Flag');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_contract` ALTER COLUMN `exclusivity_scope` SET TAGS ('dbx_business_glossary_term' = 'Exclusivity Scope');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_contract` ALTER COLUMN `incoterms_code` SET TAGS ('dbx_business_glossary_term' = 'Incoterms Code');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_contract` ALTER COLUMN `insurance_requirements` SET TAGS ('dbx_business_glossary_term' = 'Insurance Requirements');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_contract` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_contract` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time Days');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_contract` ALTER COLUMN `minimum_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity (MOQ)');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_contract` ALTER COLUMN `moq_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'MOQ Unit of Measure');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_contract` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Contract Notes');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_contract` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_contract` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'ach|wire_transfer|check|edi_payment|credit_card|letter_of_credit');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_contract` ALTER COLUMN `payment_terms_code` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms Code');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_contract` ALTER COLUMN `quality_assurance_terms` SET TAGS ('dbx_business_glossary_term' = 'Quality Assurance Terms');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_contract` ALTER COLUMN `renewal_term_months` SET TAGS ('dbx_business_glossary_term' = 'Renewal Term Months');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_contract` ALTER COLUMN `return_to_vendor_policy` SET TAGS ('dbx_business_glossary_term' = 'Return to Vendor (RTV) Policy');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_contract` ALTER COLUMN `shipping_point` SET TAGS ('dbx_business_glossary_term' = 'Shipping Point');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_contract` ALTER COLUMN `signature_date` SET TAGS ('dbx_business_glossary_term' = 'Signature Date');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_contract` ALTER COLUMN `termination_notice_days` SET TAGS ('dbx_business_glossary_term' = 'Termination Notice Days');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_contract` ALTER COLUMN `vendor_signatory_name` SET TAGS ('dbx_business_glossary_term' = 'Vendor Signatory Name');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_contract` ALTER COLUMN `vendor_signatory_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_contract` ALTER COLUMN `vendor_signatory_title` SET TAGS ('dbx_business_glossary_term' = 'Vendor Signatory Title');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_contract` ALTER COLUMN `vendor_signature_date` SET TAGS ('dbx_business_glossary_term' = 'Vendor Signature Date');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_contract` ALTER COLUMN `vmi_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Vendor Managed Inventory (VMI) Enabled Flag');
ALTER TABLE `retail_ecm`.`supplier`.`chargeback` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `retail_ecm`.`supplier`.`chargeback` SET TAGS ('dbx_subdomain' = 'supplier_performance');
ALTER TABLE `retail_ecm`.`supplier`.`chargeback` ALTER COLUMN `chargeback_id` SET TAGS ('dbx_business_glossary_term' = 'Chargeback ID');
ALTER TABLE `retail_ecm`.`supplier`.`chargeback` ALTER COLUMN `ap_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Accounts Payable (AP) Invoice ID');
ALTER TABLE `retail_ecm`.`supplier`.`chargeback` ALTER COLUMN `asn_id` SET TAGS ('dbx_business_glossary_term' = 'Advanced Shipping Notice (ASN) ID');
ALTER TABLE `retail_ecm`.`supplier`.`chargeback` ALTER COLUMN `buying_order_id` SET TAGS ('dbx_business_glossary_term' = 'Buying Order Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`supplier`.`chargeback` ALTER COLUMN `buying_order_line_id` SET TAGS ('dbx_business_glossary_term' = 'Buying Order Line Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`supplier`.`chargeback` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`supplier`.`chargeback` ALTER COLUMN `dc_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Center (DC) ID');
ALTER TABLE `retail_ecm`.`supplier`.`chargeback` ALTER COLUMN `financial_period_id` SET TAGS ('dbx_business_glossary_term' = 'Financial Period Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`supplier`.`chargeback` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`supplier`.`chargeback` ALTER COLUMN `goods_receipt_id` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`supplier`.`chargeback` ALTER COLUMN `inbound_shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Inbound Shipment Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`supplier`.`chargeback` ALTER COLUMN `ledger_id` SET TAGS ('dbx_business_glossary_term' = 'Ledger Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`supplier`.`chargeback` ALTER COLUMN `order_line_id` SET TAGS ('dbx_business_glossary_term' = 'Order Line Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`supplier`.`chargeback` ALTER COLUMN `po_line_id` SET TAGS ('dbx_business_glossary_term' = 'Po Line Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`supplier`.`chargeback` ALTER COLUMN `pos_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Pos Transaction Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`supplier`.`chargeback` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`supplier`.`chargeback` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) ID');
ALTER TABLE `retail_ecm`.`supplier`.`chargeback` ALTER COLUMN `receiving_event_id` SET TAGS ('dbx_business_glossary_term' = 'Receiving Event Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`supplier`.`chargeback` ALTER COLUMN `return_receipt_id` SET TAGS ('dbx_business_glossary_term' = 'Return Receipt Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`supplier`.`chargeback` ALTER COLUMN `rma_id` SET TAGS ('dbx_business_glossary_term' = 'Returns Rma Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`supplier`.`chargeback` ALTER COLUMN `rtv_request_id` SET TAGS ('dbx_business_glossary_term' = 'Rtv Request Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`supplier`.`chargeback` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`supplier`.`chargeback` ALTER COLUMN `vendor_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Contract Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`supplier`.`chargeback` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `retail_ecm`.`supplier`.`chargeback` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Violation Location Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`supplier`.`chargeback` ALTER COLUMN `affected_units` SET TAGS ('dbx_business_glossary_term' = 'Affected Units');
ALTER TABLE `retail_ecm`.`supplier`.`chargeback` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `retail_ecm`.`supplier`.`chargeback` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `retail_ecm`.`supplier`.`chargeback` ALTER COLUMN `chargeback_number` SET TAGS ('dbx_business_glossary_term' = 'Chargeback Number');
ALTER TABLE `retail_ecm`.`supplier`.`chargeback` ALTER COLUMN `chargeback_status` SET TAGS ('dbx_business_glossary_term' = 'Chargeback Status');
ALTER TABLE `retail_ecm`.`supplier`.`chargeback` ALTER COLUMN `chargeback_type` SET TAGS ('dbx_business_glossary_term' = 'Chargeback Type');
ALTER TABLE `retail_ecm`.`supplier`.`chargeback` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `retail_ecm`.`supplier`.`chargeback` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `retail_ecm`.`supplier`.`chargeback` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|CAD|EUR|GBP|MXN|JPY');
ALTER TABLE `retail_ecm`.`supplier`.`chargeback` ALTER COLUMN `debit_memo_number` SET TAGS ('dbx_business_glossary_term' = 'Debit Memo Number');
ALTER TABLE `retail_ecm`.`supplier`.`chargeback` ALTER COLUMN `detection_date` SET TAGS ('dbx_business_glossary_term' = 'Detection Date');
ALTER TABLE `retail_ecm`.`supplier`.`chargeback` ALTER COLUMN `dispute_date` SET TAGS ('dbx_business_glossary_term' = 'Dispute Date');
ALTER TABLE `retail_ecm`.`supplier`.`chargeback` ALTER COLUMN `dispute_reason` SET TAGS ('dbx_business_glossary_term' = 'Dispute Reason');
ALTER TABLE `retail_ecm`.`supplier`.`chargeback` ALTER COLUMN `dispute_status` SET TAGS ('dbx_business_glossary_term' = 'Dispute Status');
ALTER TABLE `retail_ecm`.`supplier`.`chargeback` ALTER COLUMN `dispute_status` SET TAGS ('dbx_value_regex' = 'not_disputed|disputed|under_investigation|resolved_vendor_favor|resolved_retailer_favor');
ALTER TABLE `retail_ecm`.`supplier`.`chargeback` ALTER COLUMN `is_repeat_violation` SET TAGS ('dbx_business_glossary_term' = 'Is Repeat Violation');
ALTER TABLE `retail_ecm`.`supplier`.`chargeback` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `retail_ecm`.`supplier`.`chargeback` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `retail_ecm`.`supplier`.`chargeback` ALTER COLUMN `notification_method` SET TAGS ('dbx_business_glossary_term' = 'Notification Method');
ALTER TABLE `retail_ecm`.`supplier`.`chargeback` ALTER COLUMN `notification_method` SET TAGS ('dbx_value_regex' = 'vendor_portal|edi|email|fax|mail');
ALTER TABLE `retail_ecm`.`supplier`.`chargeback` ALTER COLUMN `notification_sent_date` SET TAGS ('dbx_business_glossary_term' = 'Notification Sent Date');
ALTER TABLE `retail_ecm`.`supplier`.`chargeback` ALTER COLUMN `penalty_amount` SET TAGS ('dbx_business_glossary_term' = 'Penalty Amount');
ALTER TABLE `retail_ecm`.`supplier`.`chargeback` ALTER COLUMN `penalty_calculation_method` SET TAGS ('dbx_business_glossary_term' = 'Penalty Calculation Method');
ALTER TABLE `retail_ecm`.`supplier`.`chargeback` ALTER COLUMN `penalty_calculation_method` SET TAGS ('dbx_value_regex' = 'flat_fee|percentage_of_order|per_unit|per_carton|per_pallet|tiered');
ALTER TABLE `retail_ecm`.`supplier`.`chargeback` ALTER COLUMN `penalty_percentage` SET TAGS ('dbx_business_glossary_term' = 'Penalty Percentage');
ALTER TABLE `retail_ecm`.`supplier`.`chargeback` ALTER COLUMN `previous_violation_count` SET TAGS ('dbx_business_glossary_term' = 'Previous Violation Count');
ALTER TABLE `retail_ecm`.`supplier`.`chargeback` ALTER COLUMN `recovery_date` SET TAGS ('dbx_business_glossary_term' = 'Recovery Date');
ALTER TABLE `retail_ecm`.`supplier`.`chargeback` ALTER COLUMN `recovery_method` SET TAGS ('dbx_business_glossary_term' = 'Recovery Method');
ALTER TABLE `retail_ecm`.`supplier`.`chargeback` ALTER COLUMN `recovery_method` SET TAGS ('dbx_value_regex' = 'ap_deduction|debit_memo|credit_memo|offset_future_payment|written_off');
ALTER TABLE `retail_ecm`.`supplier`.`chargeback` ALTER COLUMN `resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Resolution Date');
ALTER TABLE `retail_ecm`.`supplier`.`chargeback` ALTER COLUMN `resolution_notes` SET TAGS ('dbx_business_glossary_term' = 'Resolution Notes');
ALTER TABLE `retail_ecm`.`supplier`.`chargeback` ALTER COLUMN `vendor_scorecard_impact` SET TAGS ('dbx_business_glossary_term' = 'Vendor Scorecard Impact');
ALTER TABLE `retail_ecm`.`supplier`.`chargeback` ALTER COLUMN `violation_category` SET TAGS ('dbx_business_glossary_term' = 'Violation Category');
ALTER TABLE `retail_ecm`.`supplier`.`chargeback` ALTER COLUMN `violation_date` SET TAGS ('dbx_business_glossary_term' = 'Violation Date');
ALTER TABLE `retail_ecm`.`supplier`.`chargeback` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `retail_ecm`.`supplier`.`rtv_request` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `retail_ecm`.`supplier`.`rtv_request` SET TAGS ('dbx_subdomain' = 'supplier_performance');
ALTER TABLE `retail_ecm`.`supplier`.`rtv_request` ALTER COLUMN `rtv_request_id` SET TAGS ('dbx_business_glossary_term' = 'Rtv Request Identifier');
ALTER TABLE `retail_ecm`.`supplier`.`rtv_request` ALTER COLUMN `ap_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Ap Invoice Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`supplier`.`rtv_request` ALTER COLUMN `buying_order_id` SET TAGS ('dbx_business_glossary_term' = 'Buying Order Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`supplier`.`rtv_request` ALTER COLUMN `buying_order_line_id` SET TAGS ('dbx_business_glossary_term' = 'Buying Order Line Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`supplier`.`rtv_request` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`supplier`.`rtv_request` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`supplier`.`rtv_request` ALTER COLUMN `dc_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Dc Facility Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`supplier`.`rtv_request` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Destination Location ID');
ALTER TABLE `retail_ecm`.`supplier`.`rtv_request` ALTER COLUMN `financial_period_id` SET TAGS ('dbx_business_glossary_term' = 'Financial Period Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`supplier`.`rtv_request` ALTER COLUMN `fulfillment_node_id` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Node Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`supplier`.`rtv_request` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`supplier`.`rtv_request` ALTER COLUMN `goods_receipt_id` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`supplier`.`rtv_request` ALTER COLUMN `inbound_shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Inbound Shipment Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`supplier`.`rtv_request` ALTER COLUMN `lot_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`supplier`.`rtv_request` ALTER COLUMN `order_line_id` SET TAGS ('dbx_business_glossary_term' = 'Order Line Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`supplier`.`rtv_request` ALTER COLUMN `origin_location_id` SET TAGS ('dbx_business_glossary_term' = 'Origin Location ID');
ALTER TABLE `retail_ecm`.`supplier`.`rtv_request` ALTER COLUMN `rma_id` SET TAGS ('dbx_business_glossary_term' = 'Originating Returns Rma Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`supplier`.`rtv_request` ALTER COLUMN `receiving_event_id` SET TAGS ('dbx_business_glossary_term' = 'Receiving Event Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`supplier`.`rtv_request` ALTER COLUMN `return_receipt_id` SET TAGS ('dbx_business_glossary_term' = 'Return Receipt Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`supplier`.`rtv_request` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`supplier`.`rtv_request` ALTER COLUMN `stock_position_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Position Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`supplier`.`rtv_request` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Supply Purchase Order Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`supplier`.`rtv_request` ALTER COLUMN `vendor_address_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Address Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`supplier`.`rtv_request` ALTER COLUMN `vendor_address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `retail_ecm`.`supplier`.`rtv_request` ALTER COLUMN `vendor_address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `retail_ecm`.`supplier`.`rtv_request` ALTER COLUMN `vendor_contact_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Contact ID');
ALTER TABLE `retail_ecm`.`supplier`.`rtv_request` ALTER COLUMN `vendor_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Contract Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`supplier`.`rtv_request` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `retail_ecm`.`supplier`.`rtv_request` ALTER COLUMN `approver_name` SET TAGS ('dbx_business_glossary_term' = 'Approver Name');
ALTER TABLE `retail_ecm`.`supplier`.`rtv_request` ALTER COLUMN `authorization_date` SET TAGS ('dbx_business_glossary_term' = 'RTV Authorization Date');
ALTER TABLE `retail_ecm`.`supplier`.`rtv_request` ALTER COLUMN `chargeback_amount` SET TAGS ('dbx_business_glossary_term' = 'Chargeback Amount');
ALTER TABLE `retail_ecm`.`supplier`.`rtv_request` ALTER COLUMN `chargeback_reason` SET TAGS ('dbx_business_glossary_term' = 'Chargeback Reason');
ALTER TABLE `retail_ecm`.`supplier`.`rtv_request` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `retail_ecm`.`supplier`.`rtv_request` ALTER COLUMN `credit_date` SET TAGS ('dbx_business_glossary_term' = 'RTV Credit Date');
ALTER TABLE `retail_ecm`.`supplier`.`rtv_request` ALTER COLUMN `credit_memo_number` SET TAGS ('dbx_business_glossary_term' = 'Credit Memo Number');
ALTER TABLE `retail_ecm`.`supplier`.`rtv_request` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `retail_ecm`.`supplier`.`rtv_request` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `retail_ecm`.`supplier`.`rtv_request` ALTER COLUMN `disposition_method` SET TAGS ('dbx_business_glossary_term' = 'Disposition Method');
ALTER TABLE `retail_ecm`.`supplier`.`rtv_request` ALTER COLUMN `disposition_method` SET TAGS ('dbx_value_regex' = 'credit|replacement|repair|destroy|donate|salvage');
ALTER TABLE `retail_ecm`.`supplier`.`rtv_request` ALTER COLUMN `edi_control_number` SET TAGS ('dbx_business_glossary_term' = 'Electronic Data Interchange (EDI) Control Number');
ALTER TABLE `retail_ecm`.`supplier`.`rtv_request` ALTER COLUMN `edi_transaction_set` SET TAGS ('dbx_business_glossary_term' = 'Electronic Data Interchange (EDI) Transaction Set');
ALTER TABLE `retail_ecm`.`supplier`.`rtv_request` ALTER COLUMN `freight_cost` SET TAGS ('dbx_business_glossary_term' = 'Freight Cost');
ALTER TABLE `retail_ecm`.`supplier`.`rtv_request` ALTER COLUMN `freight_responsibility` SET TAGS ('dbx_business_glossary_term' = 'Freight Responsibility');
ALTER TABLE `retail_ecm`.`supplier`.`rtv_request` ALTER COLUMN `freight_responsibility` SET TAGS ('dbx_value_regex' = 'vendor|retailer|shared|prepaid_and_add|collect');
ALTER TABLE `retail_ecm`.`supplier`.`rtv_request` ALTER COLUMN `inspection_result` SET TAGS ('dbx_business_glossary_term' = 'Quality Inspection Result');
ALTER TABLE `retail_ecm`.`supplier`.`rtv_request` ALTER COLUMN `inspection_result` SET TAGS ('dbx_value_regex' = 'passed|failed|partial|pending|not_applicable');
ALTER TABLE `retail_ecm`.`supplier`.`rtv_request` ALTER COLUMN `invoice_number` SET TAGS ('dbx_business_glossary_term' = 'Vendor Invoice Number');
ALTER TABLE `retail_ecm`.`supplier`.`rtv_request` ALTER COLUMN `is_recall_related` SET TAGS ('dbx_business_glossary_term' = 'Is Recall Related Flag');
ALTER TABLE `retail_ecm`.`supplier`.`rtv_request` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `retail_ecm`.`supplier`.`rtv_request` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'RTV Notes');
ALTER TABLE `retail_ecm`.`supplier`.`rtv_request` ALTER COLUMN `quality_inspection_required` SET TAGS ('dbx_business_glossary_term' = 'Quality Inspection Required Flag');
ALTER TABLE `retail_ecm`.`supplier`.`rtv_request` ALTER COLUMN `recall_number` SET TAGS ('dbx_business_glossary_term' = 'Product Recall Number');
ALTER TABLE `retail_ecm`.`supplier`.`rtv_request` ALTER COLUMN `received_date` SET TAGS ('dbx_business_glossary_term' = 'RTV Received Date');
ALTER TABLE `retail_ecm`.`supplier`.`rtv_request` ALTER COLUMN `request_date` SET TAGS ('dbx_business_glossary_term' = 'RTV Request Date');
ALTER TABLE `retail_ecm`.`supplier`.`rtv_request` ALTER COLUMN `return_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Return Reason Code');
ALTER TABLE `retail_ecm`.`supplier`.`rtv_request` ALTER COLUMN `return_reason_description` SET TAGS ('dbx_business_glossary_term' = 'Return Reason Description');
ALTER TABLE `retail_ecm`.`supplier`.`rtv_request` ALTER COLUMN `rma_number` SET TAGS ('dbx_business_glossary_term' = 'Return Merchandise Authorization (RMA) Number');
ALTER TABLE `retail_ecm`.`supplier`.`rtv_request` ALTER COLUMN `rma_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `retail_ecm`.`supplier`.`rtv_request` ALTER COLUMN `rtv_status` SET TAGS ('dbx_business_glossary_term' = 'Return to Vendor (RTV) Status');
ALTER TABLE `retail_ecm`.`supplier`.`rtv_request` ALTER COLUMN `ship_date` SET TAGS ('dbx_business_glossary_term' = 'RTV Ship Date');
ALTER TABLE `retail_ecm`.`supplier`.`rtv_request` ALTER COLUMN `total_return_quantity` SET TAGS ('dbx_business_glossary_term' = 'Total Return Quantity');
ALTER TABLE `retail_ecm`.`supplier`.`rtv_request` ALTER COLUMN `total_return_value` SET TAGS ('dbx_business_glossary_term' = 'Total Return Value');
ALTER TABLE `retail_ecm`.`supplier`.`rtv_request` ALTER COLUMN `tracking_number` SET TAGS ('dbx_business_glossary_term' = 'Shipment Tracking Number');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_scorecard` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_scorecard` SET TAGS ('dbx_subdomain' = 'supplier_performance');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_scorecard` ALTER COLUMN `vendor_scorecard_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Scorecard ID');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_scorecard` ALTER COLUMN `buyer_id` SET TAGS ('dbx_business_glossary_term' = 'Buyer Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_scorecard` ALTER COLUMN `category_id` SET TAGS ('dbx_business_glossary_term' = 'Category Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_scorecard` ALTER COLUMN `dc_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Dc Facility Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_scorecard` ALTER COLUMN `financial_period_id` SET TAGS ('dbx_business_glossary_term' = 'Financial Period Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_scorecard` ALTER COLUMN `item_hierarchy_id` SET TAGS ('dbx_business_glossary_term' = 'Item Hierarchy Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_scorecard` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Supply Purchase Order Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_scorecard` ALTER COLUMN `vendor_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Contract Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_scorecard` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_scorecard` ALTER COLUMN `chargeback_amount` SET TAGS ('dbx_business_glossary_term' = 'Chargeback Amount');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_scorecard` ALTER COLUMN `chargeback_count` SET TAGS ('dbx_business_glossary_term' = 'Chargeback Count');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_scorecard` ALTER COLUMN `composite_score` SET TAGS ('dbx_business_glossary_term' = 'Composite Score');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_scorecard` ALTER COLUMN `corrective_action_due_date` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Due Date');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_scorecard` ALTER COLUMN `corrective_action_required` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Required');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_scorecard` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_scorecard` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_scorecard` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_scorecard` ALTER COLUMN `edi_compliance_rate` SET TAGS ('dbx_business_glossary_term' = 'Electronic Data Interchange (EDI) Compliance Rate');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_scorecard` ALTER COLUMN `evaluation_date` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Date');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_scorecard` ALTER COLUMN `fill_rate` SET TAGS ('dbx_business_glossary_term' = 'Fill Rate');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_scorecard` ALTER COLUMN `invoice_accuracy_rate` SET TAGS ('dbx_business_glossary_term' = 'Invoice Accuracy Rate');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_scorecard` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_scorecard` ALTER COLUMN `lead_time_adherence_rate` SET TAGS ('dbx_business_glossary_term' = 'Lead Time Adherence Rate');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_scorecard` ALTER COLUMN `minimum_order_quantity_compliance_rate` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity (MOQ) Compliance Rate');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_scorecard` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Scorecard Notes');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_scorecard` ALTER COLUMN `on_time_delivery_rate` SET TAGS ('dbx_business_glossary_term' = 'On-Time Delivery Rate');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_scorecard` ALTER COLUMN `prior_period_composite_score` SET TAGS ('dbx_business_glossary_term' = 'Prior Period Composite Score');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_scorecard` ALTER COLUMN `product_quality_score` SET TAGS ('dbx_business_glossary_term' = 'Product Quality Score');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_scorecard` ALTER COLUMN `return_to_vendor_amount` SET TAGS ('dbx_business_glossary_term' = 'Return to Vendor (RTV) Amount');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_scorecard` ALTER COLUMN `return_to_vendor_count` SET TAGS ('dbx_business_glossary_term' = 'Return to Vendor (RTV) Count');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_scorecard` ALTER COLUMN `score_trend` SET TAGS ('dbx_business_glossary_term' = 'Score Trend');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_scorecard` ALTER COLUMN `score_trend` SET TAGS ('dbx_value_regex' = 'improving|stable|declining');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_scorecard` ALTER COLUMN `scorecard_number` SET TAGS ('dbx_business_glossary_term' = 'Scorecard Number');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_scorecard` ALTER COLUMN `scorecard_number` SET TAGS ('dbx_value_regex' = '^SC-[0-9]{8}$');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_scorecard` ALTER COLUMN `scorecard_status` SET TAGS ('dbx_business_glossary_term' = 'Scorecard Status');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_scorecard` ALTER COLUMN `scorecard_status` SET TAGS ('dbx_value_regex' = 'draft|published|under_review|finalized|archived');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_scorecard` ALTER COLUMN `scoring_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Scoring Period End Date');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_scorecard` ALTER COLUMN `scoring_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Scoring Period Start Date');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_scorecard` ALTER COLUMN `total_purchase_order_count` SET TAGS ('dbx_business_glossary_term' = 'Total Purchase Order (PO) Count');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_scorecard` ALTER COLUMN `total_purchase_order_value` SET TAGS ('dbx_business_glossary_term' = 'Total Purchase Order (PO) Value');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_scorecard` ALTER COLUMN `vendor_acknowledgment_date` SET TAGS ('dbx_business_glossary_term' = 'Vendor Acknowledgment Date');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_scorecard` ALTER COLUMN `vendor_notification_date` SET TAGS ('dbx_business_glossary_term' = 'Vendor Notification Date');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_scorecard` ALTER COLUMN `vendor_tier` SET TAGS ('dbx_business_glossary_term' = 'Vendor Tier');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_scorecard` ALTER COLUMN `vendor_tier` SET TAGS ('dbx_value_regex' = 'preferred|approved|conditional|probation|suspended');
ALTER TABLE `retail_ecm`.`supplier`.`lead_time_agreement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `retail_ecm`.`supplier`.`lead_time_agreement` SET TAGS ('dbx_subdomain' = 'vendor_management');
ALTER TABLE `retail_ecm`.`supplier`.`lead_time_agreement` ALTER COLUMN `lead_time_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Lead Time Agreement ID');
ALTER TABLE `retail_ecm`.`supplier`.`lead_time_agreement` ALTER COLUMN `assortment_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Assortment Plan Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`supplier`.`lead_time_agreement` ALTER COLUMN `dc_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Destination Distribution Center (DC) ID');
ALTER TABLE `retail_ecm`.`supplier`.`lead_time_agreement` ALTER COLUMN `inventory_node_id` SET TAGS ('dbx_business_glossary_term' = 'Destination Inventory Node Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`supplier`.`lead_time_agreement` ALTER COLUMN `category_id` SET TAGS ('dbx_business_glossary_term' = 'Product Category ID');
ALTER TABLE `retail_ecm`.`supplier`.`lead_time_agreement` ALTER COLUMN `vendor_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Contract Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`supplier`.`lead_time_agreement` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `retail_ecm`.`supplier`.`lead_time_agreement` ALTER COLUMN `agreement_name` SET TAGS ('dbx_business_glossary_term' = 'Agreement Name');
ALTER TABLE `retail_ecm`.`supplier`.`lead_time_agreement` ALTER COLUMN `agreement_number` SET TAGS ('dbx_business_glossary_term' = 'Agreement Number');
ALTER TABLE `retail_ecm`.`supplier`.`lead_time_agreement` ALTER COLUMN `agreement_status` SET TAGS ('dbx_business_glossary_term' = 'Agreement Status');
ALTER TABLE `retail_ecm`.`supplier`.`lead_time_agreement` ALTER COLUMN `agreement_status` SET TAGS ('dbx_value_regex' = 'draft|active|suspended|expired|terminated');
ALTER TABLE `retail_ecm`.`supplier`.`lead_time_agreement` ALTER COLUMN `agreement_type` SET TAGS ('dbx_business_glossary_term' = 'Agreement Type');
ALTER TABLE `retail_ecm`.`supplier`.`lead_time_agreement` ALTER COLUMN `agreement_type` SET TAGS ('dbx_value_regex' = 'standard|expedited|seasonal|promotional|emergency|vmi');
ALTER TABLE `retail_ecm`.`supplier`.`lead_time_agreement` ALTER COLUMN `auto_renewal_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto Renewal Flag');
ALTER TABLE `retail_ecm`.`supplier`.`lead_time_agreement` ALTER COLUMN `compliance_penalty_rate` SET TAGS ('dbx_business_glossary_term' = 'Compliance Penalty Rate');
ALTER TABLE `retail_ecm`.`supplier`.`lead_time_agreement` ALTER COLUMN `compliance_penalty_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `retail_ecm`.`supplier`.`lead_time_agreement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `retail_ecm`.`supplier`.`lead_time_agreement` ALTER COLUMN `delivery_frequency` SET TAGS ('dbx_business_glossary_term' = 'Delivery Frequency');
ALTER TABLE `retail_ecm`.`supplier`.`lead_time_agreement` ALTER COLUMN `delivery_frequency` SET TAGS ('dbx_value_regex' = 'daily|weekly|biweekly|monthly|on_demand|dsd');
ALTER TABLE `retail_ecm`.`supplier`.`lead_time_agreement` ALTER COLUMN `delivery_window_end_time` SET TAGS ('dbx_business_glossary_term' = 'Delivery Window End Time');
ALTER TABLE `retail_ecm`.`supplier`.`lead_time_agreement` ALTER COLUMN `delivery_window_start_time` SET TAGS ('dbx_business_glossary_term' = 'Delivery Window Start Time');
ALTER TABLE `retail_ecm`.`supplier`.`lead_time_agreement` ALTER COLUMN `edi_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Electronic Data Interchange (EDI) Enabled Flag');
ALTER TABLE `retail_ecm`.`supplier`.`lead_time_agreement` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `retail_ecm`.`supplier`.`lead_time_agreement` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `retail_ecm`.`supplier`.`lead_time_agreement` ALTER COLUMN `expedited_lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Expedited Lead Time Days');
ALTER TABLE `retail_ecm`.`supplier`.`lead_time_agreement` ALTER COLUMN `fill_rate_sla_percent` SET TAGS ('dbx_business_glossary_term' = 'Fill Rate Service Level Agreement (SLA) Percent');
ALTER TABLE `retail_ecm`.`supplier`.`lead_time_agreement` ALTER COLUMN `incoterm` SET TAGS ('dbx_business_glossary_term' = 'International Commercial Terms (Incoterm)');
ALTER TABLE `retail_ecm`.`supplier`.`lead_time_agreement` ALTER COLUMN `incoterm` SET TAGS ('dbx_value_regex' = 'EXW|FOB|CIF|DDP|DAP|FCA');
ALTER TABLE `retail_ecm`.`supplier`.`lead_time_agreement` ALTER COLUMN `inner_pack_quantity` SET TAGS ('dbx_business_glossary_term' = 'Inner Pack Quantity');
ALTER TABLE `retail_ecm`.`supplier`.`lead_time_agreement` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `retail_ecm`.`supplier`.`lead_time_agreement` ALTER COLUMN `minimum_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity (MOQ)');
ALTER TABLE `retail_ecm`.`supplier`.`lead_time_agreement` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Agreement Notes');
ALTER TABLE `retail_ecm`.`supplier`.`lead_time_agreement` ALTER COLUMN `on_time_delivery_sla_percent` SET TAGS ('dbx_business_glossary_term' = 'On-Time Delivery Service Level Agreement (SLA) Percent');
ALTER TABLE `retail_ecm`.`supplier`.`lead_time_agreement` ALTER COLUMN `order_increment_quantity` SET TAGS ('dbx_business_glossary_term' = 'Order Increment Quantity');
ALTER TABLE `retail_ecm`.`supplier`.`lead_time_agreement` ALTER COLUMN `origin_location` SET TAGS ('dbx_business_glossary_term' = 'Origin Location');
ALTER TABLE `retail_ecm`.`supplier`.`lead_time_agreement` ALTER COLUMN `pack_size` SET TAGS ('dbx_business_glossary_term' = 'Pack Size');
ALTER TABLE `retail_ecm`.`supplier`.`lead_time_agreement` ALTER COLUMN `pallet_quantity` SET TAGS ('dbx_business_glossary_term' = 'Pallet Quantity');
ALTER TABLE `retail_ecm`.`supplier`.`lead_time_agreement` ALTER COLUMN `renewal_notice_days` SET TAGS ('dbx_business_glossary_term' = 'Renewal Notice Days');
ALTER TABLE `retail_ecm`.`supplier`.`lead_time_agreement` ALTER COLUMN `scope_level` SET TAGS ('dbx_business_glossary_term' = 'Scope Level');
ALTER TABLE `retail_ecm`.`supplier`.`lead_time_agreement` ALTER COLUMN `scope_level` SET TAGS ('dbx_value_regex' = 'vendor|category|subcategory|sku|product_group');
ALTER TABLE `retail_ecm`.`supplier`.`lead_time_agreement` ALTER COLUMN `seasonal_lead_time_adjustment_days` SET TAGS ('dbx_business_glossary_term' = 'Seasonal Lead Time Adjustment Days');
ALTER TABLE `retail_ecm`.`supplier`.`lead_time_agreement` ALTER COLUMN `seasonal_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Seasonal Period End Date');
ALTER TABLE `retail_ecm`.`supplier`.`lead_time_agreement` ALTER COLUMN `seasonal_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Seasonal Period Start Date');
ALTER TABLE `retail_ecm`.`supplier`.`lead_time_agreement` ALTER COLUMN `sku` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU)');
ALTER TABLE `retail_ecm`.`supplier`.`lead_time_agreement` ALTER COLUMN `standard_lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Standard Lead Time Days');
ALTER TABLE `retail_ecm`.`supplier`.`lead_time_agreement` ALTER COLUMN `transportation_mode` SET TAGS ('dbx_business_glossary_term' = 'Transportation Mode');
ALTER TABLE `retail_ecm`.`supplier`.`lead_time_agreement` ALTER COLUMN `transportation_mode` SET TAGS ('dbx_value_regex' = 'truck|rail|air|ocean|intermodal|parcel');
ALTER TABLE `retail_ecm`.`supplier`.`lead_time_agreement` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `retail_ecm`.`supplier`.`lead_time_agreement` ALTER COLUMN `vmi_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Vendor Managed Inventory (VMI) Enabled Flag');
ALTER TABLE `retail_ecm`.`supplier`.`lead_time_agreement` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_item` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_item` SET TAGS ('dbx_subdomain' = 'vendor_management');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_item` ALTER COLUMN `vendor_item_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Item ID');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_item` ALTER COLUMN `assortment_item_id` SET TAGS ('dbx_business_glossary_term' = 'Assortment Item Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_item` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_item` ALTER COLUMN `lead_time_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Lead Time Agreement Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_item` ALTER COLUMN `return_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Return Policy Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_item` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Product ID');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_item` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_item` ALTER COLUMN `case_pack_quantity` SET TAGS ('dbx_business_glossary_term' = 'Case Pack Quantity');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_item` ALTER COLUMN `cost_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Currency Code');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_item` ALTER COLUMN `cost_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_item` ALTER COLUMN `cost_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Cost Effective Date');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_item` ALTER COLUMN `cost_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Cost Expiration Date');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_item` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_business_glossary_term' = 'Country of Origin');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_item` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_item` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_item` ALTER COLUMN `dsd_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Direct Store Delivery (DSD) Eligible Flag');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_item` ALTER COLUMN `ean` SET TAGS ('dbx_business_glossary_term' = 'European Article Number (EAN)');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_item` ALTER COLUMN `ean` SET TAGS ('dbx_value_regex' = '^[0-9]{13}$');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_item` ALTER COLUMN `edi_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Electronic Data Interchange (EDI) Enabled Flag');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_item` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_item` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_item` ALTER COLUMN `gtin` SET TAGS ('dbx_business_glossary_term' = 'Global Trade Item Number (GTIN)');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_item` ALTER COLUMN `gtin` SET TAGS ('dbx_value_regex' = '^[0-9]{8,14}$');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_item` ALTER COLUMN `inner_pack_quantity` SET TAGS ('dbx_business_glossary_term' = 'Inner Pack Quantity');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_item` ALTER COLUMN `last_cost_change_date` SET TAGS ('dbx_business_glossary_term' = 'Last Cost Change Date');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_item` ALTER COLUMN `last_order_date` SET TAGS ('dbx_business_glossary_term' = 'Last Order Date');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_item` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_item` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_item` ALTER COLUMN `pallet_hi` SET TAGS ('dbx_business_glossary_term' = 'Pallet HI (High)');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_item` ALTER COLUMN `pallet_ti` SET TAGS ('dbx_business_glossary_term' = 'Pallet TI (Tier)');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_item` ALTER COLUMN `preferred_vendor_flag` SET TAGS ('dbx_business_glossary_term' = 'Preferred Vendor Flag');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_item` ALTER COLUMN `private_label_flag` SET TAGS ('dbx_business_glossary_term' = 'Private Label Flag');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_item` ALTER COLUMN `seasonal_lead_time_adjustment_days` SET TAGS ('dbx_business_glossary_term' = 'Seasonal Lead Time Adjustment (Days)');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_item` ALTER COLUMN `unit_cost` SET TAGS ('dbx_business_glossary_term' = 'Unit Cost');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_item` ALTER COLUMN `unit_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_item` ALTER COLUMN `upc` SET TAGS ('dbx_business_glossary_term' = 'Universal Product Code (UPC)');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_item` ALTER COLUMN `upc` SET TAGS ('dbx_value_regex' = '^[0-9]{12}$');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_item` ALTER COLUMN `vendor_item_category` SET TAGS ('dbx_business_glossary_term' = 'Vendor Item Category');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_item` ALTER COLUMN `vendor_item_description` SET TAGS ('dbx_business_glossary_term' = 'Vendor Item Description');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_item` ALTER COLUMN `vendor_item_number` SET TAGS ('dbx_business_glossary_term' = 'Vendor Item Number');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_item` ALTER COLUMN `vendor_item_status` SET TAGS ('dbx_business_glossary_term' = 'Vendor Item Status');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_item` ALTER COLUMN `vendor_item_status` SET TAGS ('dbx_value_regex' = 'active|inactive|discontinued|pending|suspended');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_item` ALTER COLUMN `vendor_pack_configuration` SET TAGS ('dbx_business_glossary_term' = 'Vendor Pack Configuration');
ALTER TABLE `retail_ecm`.`supplier`.`vendor_item` ALTER COLUMN `vmi_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Vendor Managed Inventory (VMI) Enabled Flag');
