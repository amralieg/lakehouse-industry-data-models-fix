-- Schema for Domain: procurement | Business: Airlines | Version: v1_ecm
-- Generated on: 2026-05-07 12:58:07

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `airlines_ecm`.`procurement` COMMENT 'Supply chain and procurement management including vendor sourcing, purchase orders, parts inventory, fuel procurement contracts, material management, supplier performance, and strategic sourcing for MRO parts, catering, and ground services';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `airlines_ecm`.`procurement`.`vendor` (
    `vendor_id` BIGINT COMMENT 'Unique identifier for the vendor record. Primary key.',
    `parent_vendor_id` BIGINT COMMENT 'Self-referencing FK on vendor (parent_vendor_id)',
    `as9100_certified` BOOLEAN COMMENT 'Indicates whether the vendor holds current AS9100 aerospace quality management system certification, critical for MRO parts suppliers.',
    `bank_account_number` STRING COMMENT 'The vendors bank account number for electronic funds transfer and payment processing.',
    `bank_name` STRING COMMENT 'Name of the financial institution holding the vendors primary payment account.',
    `bank_swift_code` STRING COMMENT 'SWIFT/BIC code of the vendors bank for international wire transfers and cross-border payments.. Valid values are `^[A-Z]{6}[A-Z0-9]{2}([A-Z0-9]{3})?$`',
    `blacklist_flag` BOOLEAN COMMENT 'Indicates whether the vendor is currently blacklisted or suspended from doing business with the airline due to performance, compliance, or ethical violations.',
    `country_of_incorporation` STRING COMMENT 'Three-letter ISO country code representing the country where the vendor is legally incorporated or registered.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this vendor record was first created in the system.',
    `credit_limit_amount` DECIMAL(18,2) COMMENT 'Maximum outstanding accounts payable balance allowed for this vendor before additional purchases require approval, expressed in the vendors preferred currency.',
    `duns_number` STRING COMMENT 'Nine-digit unique identifier assigned by Dun & Bradstreet for business entity identification and credit assessment.. Valid values are `^[0-9]{9}$`',
    `easa_part145_approved` BOOLEAN COMMENT 'Indicates whether the vendor holds EASA Part-145 approval for aircraft maintenance organization, required for MRO service providers operating in EU jurisdictions.',
    `faa_repair_station_certified` BOOLEAN COMMENT 'Indicates whether the vendor holds FAA repair station certification under 14 CFR Part 145, required for MRO service providers operating in US jurisdictions.',
    `iata_vendor_code` STRING COMMENT 'IATA-assigned alphanumeric code identifying the vendor within the aviation industry supply chain, used for standardized procurement and settlement.. Valid values are `^[A-Z0-9]{2,8}$`',
    `iso9001_certified` BOOLEAN COMMENT 'Indicates whether the vendor holds current ISO 9001 quality management system certification.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this vendor record was most recently updated or modified.',
    `last_performance_review_date` DATE COMMENT 'The date of the most recent formal performance review or scorecard assessment conducted for this vendor.',
    `legal_name` STRING COMMENT 'The full legal registered name of the vendor as it appears on incorporation documents and contracts.',
    `minority_owned_flag` BOOLEAN COMMENT 'Indicates whether the vendor is certified as a minority-owned business enterprise for diversity and inclusion reporting.',
    `onboarding_date` DATE COMMENT 'The date when the vendor was officially onboarded and approved to begin supplying goods or services to the airline.',
    `payment_terms_days` STRING COMMENT 'Standard number of days from invoice date within which payment is due to the vendor, as agreed in the master vendor agreement.',
    `preferred_currency_code` STRING COMMENT 'Three-letter ISO currency code representing the vendors preferred currency for invoicing and payment transactions.. Valid values are `^[A-Z]{3}$`',
    `primary_contact_email` STRING COMMENT 'Email address of the primary business contact at the vendor for procurement communications and order management.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `primary_contact_name` STRING COMMENT 'Full name of the primary business contact person at the vendor organization for procurement and operational matters.',
    `primary_contact_phone` STRING COMMENT 'Primary telephone number of the vendors business contact, including country and area codes.',
    `registered_address_line1` STRING COMMENT 'First line of the vendors official registered business address as recorded with the incorporation authority.',
    `registered_address_line2` STRING COMMENT 'Second line of the vendors official registered business address, typically containing suite, floor, or building details.',
    `registered_city` STRING COMMENT 'City or municipality of the vendors registered business address.',
    `registered_country` STRING COMMENT 'Three-letter ISO country code of the vendors registered business address.. Valid values are `^[A-Z]{3}$`',
    `registered_postal_code` STRING COMMENT 'Postal or ZIP code of the vendors registered business address.',
    `registered_state_province` STRING COMMENT 'State, province, or administrative region of the vendors registered business address.',
    `small_business_flag` BOOLEAN COMMENT 'Indicates whether the vendor qualifies as a small business under applicable regulatory definitions for procurement diversity programs.',
    `tax_identification_number` STRING COMMENT 'The primary tax identification number issued by the vendors country of tax residence, used for tax reporting and compliance.',
    `trade_name` STRING COMMENT 'The commercial or trading name under which the vendor operates, if different from legal name.',
    `vat_registration_number` STRING COMMENT 'VAT or GST registration number for vendors operating in jurisdictions requiring VAT registration, used for tax invoice validation.',
    `vendor_status` STRING COMMENT 'Current lifecycle status of the vendor relationship: active (approved and operational), inactive (no longer doing business), suspended (temporarily blocked), pending_approval (undergoing onboarding review).. Valid values are `active|inactive|suspended|pending_approval`',
    `vendor_tier` STRING COMMENT 'Strategic classification of the vendor based on business relationship strength, volume, and criticality: strategic (top-tier partners with long-term agreements), preferred (high-volume reliable suppliers), approved (qualified suppliers meeting minimum standards), conditional (suppliers under probation or limited approval).. Valid values are `strategic|preferred|approved|conditional`',
    `vendor_type` STRING COMMENT 'Primary classification of the vendor based on the category of goods or services provided: MRO (Maintenance Repair and Overhaul parts suppliers), fuel (aviation fuel suppliers), catering (inflight and lounge catering providers), ground_services (ground handling and airport service contractors), IT (information technology and software vendors), consumables (general supplies and consumables).. Valid values are `MRO|fuel|catering|ground_services|IT|consumables`',
    `website_url` STRING COMMENT 'The primary website URL of the vendor for reference and supplier portal access.',
    CONSTRAINT pk_vendor PRIMARY KEY(`vendor_id`)
) COMMENT 'Master record for all suppliers, vendors, and service providers engaged by the airline across all procurement categories — MRO parts suppliers, fuel suppliers, catering providers, ground service contractors, IT vendors, and consumables suppliers. Captures vendor legal name, DUNS number, IATA vendor code, vendor type classification (MRO, fuel, catering, ground services, IT, general), tax identification numbers, country of incorporation, registered address, primary contact details, payment terms, preferred currency, credit limit, vendor tier (strategic, preferred, approved, conditional), certification status (ISO 9001, AS9100, EASA Part-145 approval), blacklist flag, onboarding date, and last performance review date. This is the SSOT for all supplier identity and master data within the procurement domain.';

CREATE OR REPLACE TABLE `airlines_ecm`.`procurement`.`purchase_order` (
    `purchase_order_id` BIGINT COMMENT 'Unique identifier for the purchase order. Primary key for the purchase order entity.',
    `employee_id` BIGINT COMMENT 'Reference to the procurement buyer or purchasing agent responsible for creating and managing this purchase order.',
    `procurement_category_id` BIGINT COMMENT 'Foreign key linking to procurement.procurement_category. Business justification: Purchase orders have procurement_category (STRING) which should be normalized to procurement_category_id FK for proper spend classification, category management, and reporting. Remove procurement_cate',
    `sourcing_event_id` BIGINT COMMENT 'Foreign key linking to procurement.sourcing_event. Business justification: Purchase orders often result from sourcing events (RFQ/RFP). Currently uses sourcing_event_reference (STRING) which is a denormalized business reference. Adding sourcing_event_id FK normalizes this re',
    `supply_contract_id` BIGINT COMMENT 'Foreign key linking to procurement.supply_contract. Business justification: Purchase orders are often placed against supply contracts (call-off orders). Currently uses contract_reference (STRING) which is a denormalized business reference. Adding supply_contract_id FK normali',
    `vendor_id` BIGINT COMMENT 'Reference to the vendor or supplier to whom this purchase order is issued. Links to the vendor master data.',
    `blanket_purchase_order_id` BIGINT COMMENT 'Self-referencing FK on purchase_order (blanket_purchase_order_id)',
    `approval_authority_level` STRING COMMENT 'The highest approval authority level required for this purchase order based on value thresholds and procurement policy. Determines routing through approval hierarchy.. Valid values are `buyer|supervisor|manager|director|vp|cfo`',
    `approval_workflow_status` STRING COMMENT 'Current status of the purchase order in the approval workflow. Tracks progression through multi-level approval hierarchy based on purchase order value and authority limits.. Valid values are `not_submitted|pending_level_1|pending_level_2|pending_level_3|approved|rejected`',
    `approved_timestamp` TIMESTAMP COMMENT 'Timestamp when the purchase order received final approval and became authorized for transmission to the vendor.',
    `cancellation_reason` STRING COMMENT 'Explanation for why the purchase order was cancelled. Used for root cause analysis of procurement process issues and vendor relationship management.',
    `cancelled_timestamp` TIMESTAMP COMMENT 'Timestamp when the purchase order was cancelled before completion. Used for tracking procurement process failures and vendor performance issues.',
    `closed_timestamp` TIMESTAMP COMMENT 'Timestamp when the purchase order was closed after all goods/services were received and invoiced. Marks the end of the purchase order lifecycle.',
    `confirmed_delivery_date` DATE COMMENT 'The delivery date confirmed by the vendor in their purchase order acknowledgment. May differ from requested date based on vendor lead times and capacity.',
    `cost_center` STRING COMMENT 'The cost center to which this purchase order expenditure is charged. Used for internal financial allocation and budget tracking.. Valid values are `^CC[0-9]{6,10}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this purchase order record was first created in the procurement system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the purchase order value (e.g., USD, EUR, GBP). Defines the currency in which the vendor will be paid.. Valid values are `^[A-Z]{3}$`',
    `delivery_address` STRING COMMENT 'Full physical address where the goods or services are to be delivered. Includes street address, city, postal code, and country. Organizational contact data classified as confidential.',
    `delivery_address_type` STRING COMMENT 'Classification of the delivery location type. Station for airport locations, base for crew/operational bases, maintenance facility for MRO hangars, warehouse for central stores, headquarters for corporate offices, vendor managed for consignment inventory.. Valid values are `station|base|maintenance_facility|warehouse|headquarters|vendor_managed`',
    `delivery_station_code` STRING COMMENT 'Three-letter IATA airport or station code where goods or services are to be delivered. Used for logistics planning and inventory allocation.. Valid values are `^[A-Z]{3}$`',
    `exchange_rate` DECIMAL(18,2) COMMENT 'Exchange rate applied at the time of purchase order creation for converting vendor currency to airline base currency. Used for financial consolidation and reporting.',
    `gl_account_code` STRING COMMENT 'The general ledger account code to which this purchase order will be posted upon receipt and invoice processing. Ensures proper financial classification.. Valid values are `^[0-9]{6,10}$`',
    `incoterm` STRING COMMENT 'International Commercial Terms (Incoterms) code defining the responsibilities, costs, and risks between buyer and seller for delivery. Examples: EXW (Ex Works), FOB (Free on Board), DDP (Delivered Duty Paid). [ENUM-REF-CANDIDATE: EXW|FCA|CPT|CIP|DAP|DPU|DDP|FAS|FOB|CFR|CIF — 11 candidates stripped; promote to reference product]',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this purchase order record was last updated or modified.',
    `notes` STRING COMMENT 'Free-text field for additional instructions, special requirements, or comments related to this purchase order. May include delivery instructions, quality requirements, or vendor-specific notes.',
    `payment_terms` STRING COMMENT 'Contractual payment terms agreed with the vendor (e.g., Net 30, Net 60, 2/10 Net 30). Defines when payment is due and any early payment discounts available.',
    `po_date` DATE COMMENT 'The date when the purchase order was officially created and issued. This is the principal business event timestamp for the transaction.',
    `po_number` STRING COMMENT 'Externally-known business identifier for the purchase order, used across procurement systems and vendor communications. Typically follows airline-specific numbering convention.. Valid values are `^PO[0-9]{8,12}$`',
    `po_status` STRING COMMENT 'Current lifecycle status of the purchase order. Tracks the order from creation through approval, transmission to vendor, receipt of goods/services, and final closure or cancellation. [ENUM-REF-CANDIDATE: draft|pending_approval|approved|sent|acknowledged|partially_received|fully_received|closed|cancelled — 9 candidates stripped; promote to reference product]',
    `po_type` STRING COMMENT 'Classification of the purchase order type. Standard for one-time purchases, blanket for recurring purchases against a contract, framework for multi-release agreements, emergency AOG (Aircraft on Ground) for urgent aircraft parts, contract release for call-offs from master agreements, spot for ad-hoc market purchases.. Valid values are `standard|blanket|framework|emergency_aog|contract_release|spot`',
    `priority_level` STRING COMMENT 'Priority classification for the purchase order. AOG (Aircraft on Ground) critical for emergency aircraft parts, urgent for time-sensitive needs, high for important but not critical, routine for standard procurement.. Valid values are `routine|high|urgent|aog_critical`',
    `requested_delivery_date` DATE COMMENT 'The date by which the airline requests delivery of the goods or completion of services. Used for supply chain planning and vendor performance tracking.',
    `requisition_reference` STRING COMMENT 'Reference to the internal purchase requisition(s) that originated this purchase order. Links operational demand to procurement execution.',
    `sent_to_vendor_timestamp` TIMESTAMP COMMENT 'Timestamp when the purchase order was transmitted to the vendor via EDI, email, or vendor portal. Marks the start of vendor fulfillment cycle.',
    `shipping_method` STRING COMMENT 'Method of transportation for delivery of goods. AOG charter for emergency aircraft parts requiring immediate air charter, air freight for expedited delivery, sea freight for bulk shipments, ground for domestic transport, courier for small packages, vendor delivery for supplier-arranged transport.. Valid values are `air_freight|sea_freight|ground|courier|vendor_delivery|aog_charter`',
    `tax_amount` DECIMAL(18,2) COMMENT 'Total tax amount applicable to this purchase order, including VAT, GST, or other applicable taxes based on jurisdiction.',
    `total_po_value` DECIMAL(18,2) COMMENT 'The total monetary value of the purchase order, including all line items and charges, before taxes. Represents the committed spend amount.',
    `total_po_value_including_tax` DECIMAL(18,2) COMMENT 'The total monetary value of the purchase order including all taxes. This is the final committed amount payable to the vendor.',
    CONSTRAINT pk_purchase_order PRIMARY KEY(`purchase_order_id`)
) COMMENT 'Master transactional record for all purchase orders issued by the airline to vendors across all procurement categories — aircraft parts, fuel, catering supplies, ground handling services, MRO consumables, and general goods and services. Captures PO number, PO type (standard, blanket, framework, emergency AOG), vendor reference, buyer ID, procurement category, cost centre, GL account, total PO value, currency, exchange rate, payment terms, delivery address (station/base), requested delivery date, PO status (draft, approved, sent, partially received, fully received, closed, cancelled), approval workflow status, approval authority level, and sourcing event reference. The authoritative transactional record for all committed procurement spend.';

CREATE OR REPLACE TABLE `airlines_ecm`.`procurement`.`po_line` (
    `po_line_id` BIGINT COMMENT 'Unique identifier for the purchase order line item. Primary key for the po_line product.',
    `employee_id` BIGINT COMMENT 'Foreign key reference to the employee or user who requested this material or service. Links the procurement line to the originating purchase requisition and requestor.',
    `material_part_master_id` BIGINT COMMENT 'Foreign key reference to the material master record. Identifies the specific part, component, consumable, or service being procured on this line.',
    `part_master_id` BIGINT COMMENT 'Foreign key linking to procurement.part_master. Business justification: PO lines reference materials/parts that should link to part_master for normalization. Currently uses material_number, manufacturer_part_number, and vendor_material_number (STRING) which are denormaliz',
    `procurement_category_id` BIGINT COMMENT 'Foreign key linking to procurement.procurement_category. Business justification: PO lines currently have material_group (STRING) which appears to be a category/classification reference. Should normalize to procurement_category_id FK for proper spend classification, category manage',
    `purchase_order_id` BIGINT COMMENT 'Foreign key reference to the parent purchase order header. Links this line item to its containing purchase order document.',
    `parent_po_line_id` BIGINT COMMENT 'Self-referencing FK on po_line (parent_po_line_id)',
    `aircraft_type` STRING COMMENT 'The aircraft type or model for which this material or part is applicable. Critical for MRO parts procurement to ensure compatibility with specific fleet types (e.g., B737, A320, B787).',
    `ata_chapter` STRING COMMENT 'The ATA chapter code classifying the aircraft system or component category for this part. Standard aviation maintenance classification system (e.g., 32 for landing gear, 71 for powerplant).. Valid values are `^[0-9]{2}(-[0-9]{2}(-[0-9]{2})?)?$`',
    `cost_center` STRING COMMENT 'The cost center to which this procurement line will be charged. Enables departmental or functional cost allocation for expense items, services, or consumables.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this purchase order line record was first created in the system. Audit field for tracking line creation.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the monetary values on this line. Typically inherited from the PO header but may differ for specific line items in multi-currency scenarios.. Valid values are `^[A-Z]{3}$`',
    `deletion_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether this purchase order line has been marked for deletion or cancellation. Soft-delete mechanism to preserve audit trail while removing line from active processing.',
    `delivery_date` DATE COMMENT 'The scheduled or requested delivery date for this line item. Represents when the material or service is expected to be received or performed.',
    `delivery_tolerance_percent` DECIMAL(18,2) COMMENT 'The acceptable over-delivery or under-delivery tolerance as a percentage of the ordered quantity. Allows for minor quantity variances without requiring PO amendments.',
    `final_invoice_flag` BOOLEAN COMMENT 'Boolean indicator that the final invoice has been received and processed for this line, and no further invoices are expected. Signals readiness for line closure.',
    `gl_account` STRING COMMENT 'The general ledger account code to which this procurement expense will be posted. Enables financial classification and cost allocation for non-stock items or direct expenses.',
    `goods_receipt_required_flag` BOOLEAN COMMENT 'Boolean indicator of whether a goods receipt transaction is required before invoice processing for this line. Enforces three-way matching for physical materials.',
    `gross_amount` DECIMAL(18,2) COMMENT 'The total gross value of this line item including all taxes, surcharges, and fees. Represents the final line total that contributes to the overall PO value.',
    `hazmat_flag` BOOLEAN COMMENT 'Boolean indicator of whether this material is classified as hazardous or dangerous goods. Triggers special handling, storage, and transportation requirements per IATA DGR.',
    `incoterm` STRING COMMENT 'The Incoterms rule governing the transfer of risk, costs, and responsibilities between buyer and seller for this line item. Defines delivery terms and logistics obligations. [ENUM-REF-CANDIDATE: EXW|FCA|CPT|CIP|DAP|DPU|DDP|FAS|FOB|CFR|CIF — 11 candidates stripped; promote to reference product]',
    `invoice_receipt_required_flag` BOOLEAN COMMENT 'Boolean indicator of whether invoice verification is required for this line. Controls whether the line participates in invoice matching and payment processing.',
    `line_number` STRING COMMENT 'Sequential line item number within the purchase order. Determines the ordering and display sequence of line items in the PO document.',
    `line_status` STRING COMMENT 'Current lifecycle status of the purchase order line. Tracks progression from open through delivery to closure or cancellation.. Valid values are `open|partially_received|fully_received|cancelled|closed`',
    `long_text` STRING COMMENT 'Detailed description of the material or service, including specifications, technical requirements, or special instructions for this procurement line.',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when this purchase order line record was last modified. Audit field for tracking changes to line item details.',
    `net_price` DECIMAL(18,2) COMMENT 'The total net value of this line item before taxes and surcharges. Calculated as quantity_ordered multiplied by unit_price, adjusted for any line-level discounts.',
    `open_quantity` DECIMAL(18,2) COMMENT 'The remaining quantity still to be delivered on this purchase order line. Calculated as quantity_ordered minus quantity_received. Indicates outstanding procurement commitment.',
    `plant_code` STRING COMMENT 'The plant or facility code where the material will be received or the service will be performed. In aviation context, may represent maintenance base, hub station, or warehouse location.',
    `quantity_invoiced` DECIMAL(18,2) COMMENT 'The cumulative quantity that has been invoiced by the vendor against this purchase order line. Used for three-way matching and invoice verification.',
    `quantity_ordered` DECIMAL(18,2) COMMENT 'The quantity of material or service units ordered on this purchase order line. Expressed in the unit of measure specified for this line.',
    `quantity_received` DECIMAL(18,2) COMMENT 'The cumulative quantity of material that has been received against this purchase order line through goods receipt transactions. Used for three-way matching (PO vs GR vs invoice).',
    `short_text` STRING COMMENT 'Brief description of the material or service being procured on this line. Provides human-readable context for the line item.',
    `storage_location` STRING COMMENT 'The specific storage location or warehouse bin within the plant where the material will be stocked upon receipt. Enables precise inventory placement for MRO parts and consumables.',
    `tax_amount` DECIMAL(18,2) COMMENT 'The total tax amount applicable to this purchase order line. Includes VAT, GST, sales tax, or other applicable taxes based on jurisdiction and material tax classification.',
    `un_number` STRING COMMENT 'The four-digit UN number identifying the hazardous substance classification for dangerous goods. Required for HAZMAT materials to comply with international shipping and handling regulations.. Valid values are `^UN[0-9]{4}$`',
    `unit_of_measure` STRING COMMENT 'The unit of measure for the ordered quantity. Examples include EA (each), KG (kilogram), LT (liter), HR (hour), or aviation-specific units like FH (flight hours) or FC (flight cycles).',
    `unit_price` DECIMAL(18,2) COMMENT 'The price per unit of measure for this line item. Expressed in the currency specified on the purchase order header.',
    CONSTRAINT pk_po_line PRIMARY KEY(`po_line_id`)
) COMMENT 'Individual line item within a purchase order representing a single material, part, or service being procured. Captures PO line number, material number (linked to part master), item description, unit of measure, ordered quantity, unit price, line total value, delivery schedule date, goods receipt quantity, invoice quantity, open quantity, line status (open, partially delivered, fully delivered, cancelled), storage location, aircraft type applicability, ATA chapter code for parts, and hazardous material flag. Enables granular tracking of multi-line procurement transactions and three-way matching (PO line vs goods receipt vs invoice line).';

CREATE OR REPLACE TABLE `airlines_ecm`.`procurement`.`goods_receipt` (
    `goods_receipt_id` BIGINT COMMENT 'Unique identifier for the goods receipt transaction. Primary key for the goods receipt record.',
    `part_master_id` BIGINT COMMENT 'Foreign key linking to procurement.part_master. Business justification: Goods receipts reference materials/parts that should link to part_master for normalization. Currently uses material_number and material_description (STRING) which are denormalized. Adding part_master_',
    `po_line_id` BIGINT COMMENT 'Foreign key linking to procurement.po_line. Business justification: Goods receipts are against specific PO line items, not just the header. Currently uses po_line_item_number (INT) which is a line sequence number within the PO, not a FK. Adding po_line_id FK enables d',
    `purchase_order_id` BIGINT COMMENT 'Reference to the purchase order against which goods or services are being received. Links GR to originating procurement document.',
    `employee_id` BIGINT COMMENT 'Identifier of the warehouse or receiving clerk who physically accepted and recorded the goods receipt. Provides accountability.',
    `vendor_id` BIGINT COMMENT 'Identifier of the vendor or supplier delivering the goods or services. Links to vendor master data for supplier performance tracking.',
    `correction_goods_receipt_id` BIGINT COMMENT 'Self-referencing FK on goods_receipt (correction_goods_receipt_id)',
    `airworthiness_certificate_number` STRING COMMENT 'Certificate number for parts requiring airworthiness documentation. Mandatory for aviation-critical components per EASA/FAA regulations.',
    `batch_number` STRING COMMENT 'Manufacturer batch or lot number for the received goods. Critical for quality control, recalls, and traceability in MRO operations.',
    `certificate_of_conformance_number` STRING COMMENT 'Vendor-issued certificate number confirming that parts meet specified requirements. Required for quality assurance and regulatory compliance.',
    `condition_on_receipt` STRING COMMENT 'Physical and functional condition of goods upon receipt. Determines whether parts can be immediately used or require inspection, repair, or disposal.. Valid values are `serviceable|unserviceable|damaged|quarantine|as_is|repairable`',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when the goods receipt record was first created in the database. Audit trail for record creation.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the valuation amount. Enables multi-currency procurement and financial reporting.. Valid values are `^[A-Z]{3}$`',
    `delivery_note_date` DATE COMMENT 'Date on the vendor delivery note or packing slip. Used for lead time calculation and delivery performance analysis.',
    `gr_document_number` STRING COMMENT 'Externally-known business identifier for the goods receipt document. Used for cross-system reference and audit trails.. Valid values are `^GR[0-9]{10}$`',
    `gr_status` STRING COMMENT 'Current lifecycle status of the goods receipt document. Tracks progression from initial posting through inspection to final completion or reversal.. Valid values are `posted|reversed|cancelled|under_inspection|pending|completed`',
    `inspection_required_flag` BOOLEAN COMMENT 'Indicates whether the received goods require quality inspection before being released to stock. True triggers inspection workflow.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'System timestamp when the goods receipt record was last updated. Audit trail for record modification tracking.',
    `movement_type` STRING COMMENT 'SAP movement type code indicating the type of inventory transaction. Standard codes include 101 for GR against PO, 122 for return delivery.',
    `note` STRING COMMENT 'Free-text notes or comments recorded by the receiving clerk. Captures discrepancies, damage observations, or special handling instructions.',
    `po_line_item_number` STRING COMMENT 'Line item number within the purchase order for which goods are being received. Enables line-level matching for three-way verification.',
    `quarantine_flag` BOOLEAN COMMENT 'Indicates whether goods are placed in quarantine status pending inspection or resolution of quality issues. Blocks inventory usage.',
    `received_quantity` DECIMAL(18,2) COMMENT 'Actual quantity of goods received and accepted. Used for inventory update and variance analysis against PO quantity.',
    `receiving_date` DATE COMMENT 'Calendar date when goods were physically received at the station. Used for lead time analysis and supplier performance metrics.',
    `receiving_station_code` STRING COMMENT 'Three-letter IATA airport code or MRO base code where goods were physically received. Critical for inventory location tracking.. Valid values are `^[A-Z]{3}$`',
    `receiving_timestamp` TIMESTAMP COMMENT 'Precise date and time when goods receipt was recorded in the system. Business event timestamp for the GR transaction.',
    `reversal_reason_code` STRING COMMENT 'Code indicating the reason for reversing a goods receipt. Used when GR is cancelled due to errors, returns, or quality rejection.',
    `reversal_timestamp` TIMESTAMP COMMENT 'Date and time when the goods receipt was reversed or cancelled. Null if GR has not been reversed.',
    `serial_number` STRING COMMENT 'Unique serial number for serialized rotable parts and high-value components. Mandatory for airworthiness tracking and lifecycle management.',
    `shelf_life_expiration_date` DATE COMMENT 'Date after which time-sensitive materials such as chemicals, sealants, or perishables are no longer usable. Triggers inventory aging alerts.',
    `storage_location_code` STRING COMMENT 'Specific warehouse or storage location code within the receiving station where goods are placed. Enables bin-level inventory tracking.',
    `three_way_match_status` STRING COMMENT 'Status of the three-way matching process comparing PO, GR, and invoice. Matched status enables automatic invoice payment approval.. Valid values are `matched|variance|pending|blocked|approved`',
    `unit_of_measure` STRING COMMENT 'Unit of measure for the received quantity. Standard units include each, kilogram, liter, meter, box, pallet, set. [ENUM-REF-CANDIDATE: EA|KG|LB|LT|GL|M|FT|BOX|PAL|SET — 10 candidates stripped; promote to reference product]',
    `valuation_amount` DECIMAL(18,2) COMMENT 'Total monetary value of the goods received in the transaction currency. Used for inventory valuation and financial posting.',
    `vendor_delivery_note_number` STRING COMMENT 'External delivery note or packing slip number provided by the vendor. Used for reconciliation and proof of delivery.',
    CONSTRAINT pk_goods_receipt PRIMARY KEY(`goods_receipt_id`)
) COMMENT 'Transactional record capturing the physical receipt of goods or confirmation of service delivery against a purchase order. Captures GR document number, PO reference, vendor delivery note number, receiving station (airport/MRO base), receiving date and time, received quantity per line, unit of measure, batch number, serial numbers for rotable parts, condition on receipt (serviceable, unserviceable, damaged), inspection required flag, quarantine flag, storage location, received by employee ID, and GR status (posted, reversed, under inspection). Triggers inventory update and enables three-way matching for invoice verification. Critical for MRO parts traceability and airworthiness documentation.';

CREATE OR REPLACE TABLE `airlines_ecm`.`procurement`.`vendor_invoice` (
    `vendor_invoice_id` BIGINT COMMENT 'Unique identifier for the vendor invoice record in the procurement system. Primary key.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Vendor invoices require approval by procurement, finance, or cost center managers before payment. Three-way match exceptions and disputes require employee sign-off. Essential for financial controls, a',
    `goods_receipt_id` BIGINT COMMENT 'Foreign key linking to procurement.goods_receipt. Business justification: Vendor invoices reference goods receipts for 3-way matching (PO → GR → Invoice). Currently uses goods_receipt_reference (STRING) which is a denormalized business reference. Adding goods_receipt_id FK ',
    `purchase_order_id` BIGINT COMMENT 'Reference to the purchase order against which this invoice was received.',
    `vendor_id` BIGINT COMMENT 'Reference to the supplier who issued this invoice.',
    `credit_note_vendor_invoice_id` BIGINT COMMENT 'Self-referencing FK on vendor_invoice (credit_note_vendor_invoice_id)',
    `approved_timestamp` TIMESTAMP COMMENT 'The date and time when the invoice was approved for payment.',
    `blocking_reason_code` STRING COMMENT 'Code indicating why the invoice is blocked from payment, if applicable (e.g., price variance, quantity mismatch, missing documentation).',
    `company_code` STRING COMMENT 'The airlines company code or legal entity to which this invoice is assigned for financial reporting purposes.',
    `cost_center` STRING COMMENT 'The cost center to which the invoice expenses are allocated for internal cost tracking and management reporting.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this invoice record was first created in the procurement system.',
    `currency_code` STRING COMMENT 'The three-letter ISO 4217 currency code in which the invoice is denominated (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `discount_amount` DECIMAL(18,2) COMMENT 'Any discount amount applied to the invoice, such as early payment discounts or volume discounts.',
    `dispute_reason` STRING COMMENT 'Free-text description of the reason the invoice is disputed, if applicable.',
    `gl_account_code` STRING COMMENT 'The general ledger account code to which the invoice amount is posted in the financial accounting system.',
    `goods_receipt_date` DATE COMMENT 'The date goods or services were received and confirmed in the system, used for three-way matching.',
    `gross_amount` DECIMAL(18,2) COMMENT 'The total invoice amount before any deductions, including all line items and charges.',
    `internal_document_number` STRING COMMENT 'The airlines internal document number assigned to this invoice in the procurement or ERP system for tracking and reference.',
    `invoice_date` DATE COMMENT 'The date the vendor issued the invoice, as printed on the invoice document.',
    `invoice_received_date` DATE COMMENT 'The date the invoice was physically or electronically received by the airlines procurement or accounts payable department.',
    `invoice_status` STRING COMMENT 'Current status of the invoice in the procurement verification and approval workflow. [ENUM-REF-CANDIDATE: received|under_verification|approved|blocked|paid|disputed|cancelled — 7 candidates stripped; promote to reference product]',
    `invoice_type` STRING COMMENT 'Classification of the invoice type indicating whether it is a standard invoice, credit memo, debit memo, prepayment, or final invoice.. Valid values are `standard|credit_memo|debit_memo|prepayment|final`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this invoice record was last updated or modified.',
    `net_amount` DECIMAL(18,2) COMMENT 'The net payable amount after taxes, discounts, and adjustments. This is the amount that will be paid to the vendor.',
    `payment_date` DATE COMMENT 'The actual date payment was made to the vendor, if the invoice has been paid.',
    `payment_due_date` DATE COMMENT 'The date by which payment is due to the vendor according to the payment terms.',
    `payment_method` STRING COMMENT 'The method by which payment will be made to the vendor. BSP (Billing and Settlement Plan) and ARC (Airlines Reporting Corporation) are airline-specific settlement methods.. Valid values are `wire_transfer|ach|check|credit_card|bsp|arc`',
    `payment_run_reference` STRING COMMENT 'Reference number of the payment run in which this invoice was included for payment processing.',
    `payment_terms_code` STRING COMMENT 'The code representing the payment terms agreed with the vendor (e.g., NET30, NET60, 2/10NET30).',
    `posting_date` DATE COMMENT 'The date the invoice was posted into the airlines financial system for accounting purposes.',
    `procurement_category` STRING COMMENT 'The high-level procurement category this invoice belongs to, aligned with airline procurement taxonomy (MRO parts, fuel, catering, ground services, etc.). [ENUM-REF-CANDIDATE: mro_parts|fuel|catering|ground_services|it_services|professional_services|facilities|other — 8 candidates stripped; promote to reference product]',
    `tax_amount` DECIMAL(18,2) COMMENT 'The total tax amount charged on the invoice, including VAT, GST, or other applicable taxes.',
    `tax_code` STRING COMMENT 'The tax code applied to this invoice indicating the tax jurisdiction and rate (e.g., VAT code, GST code).',
    `three_way_match_status` STRING COMMENT 'Status of the three-way match between purchase order, goods receipt, and invoice. Indicates whether quantities and prices align across all three documents.. Valid values are `matched|quantity_variance|price_variance|not_matched|bypassed`',
    `vendor_invoice_number` STRING COMMENT 'The invoice number assigned by the vendor on their invoice document. This is the external identifier from the suppliers system.',
    CONSTRAINT pk_vendor_invoice PRIMARY KEY(`vendor_invoice_id`)
) COMMENT 'Vendor invoice record received from suppliers for goods delivered or services rendered against purchase orders. Captures invoice number (vendor-assigned), airline internal invoice document number, vendor reference, invoice date, posting date, payment due date, gross invoice amount, tax amount, net amount, currency, payment terms, PO reference, GR reference, invoice status (received, under verification, approved, blocked, paid, disputed, cancelled), three-way match status, blocking reason code, and payment run reference. Distinct from finance.accounts_payable which holds the accounting posting — this is the procurement-layer invoice verification record managing the matching and approval workflow.';

CREATE OR REPLACE TABLE `airlines_ecm`.`procurement`.`supply_contract` (
    `supply_contract_id` BIGINT COMMENT 'Unique identifier for the supply contract record. Primary key.',
    `employee_id` BIGINT COMMENT 'Reference to the procurement or category manager employee responsible for managing this contract and vendor relationship.',
    `procurement_category_id` BIGINT COMMENT 'Foreign key linking to procurement.procurement_category. Business justification: Supply contracts have procurement_category (STRING) which should be normalized to procurement_category_id FK for proper category management, contract portfolio analytics, and reporting. Remove procure',
    `vendor_id` BIGINT COMMENT 'Reference to the vendor party with whom this contract is established.',
    `renewed_supply_contract_id` BIGINT COMMENT 'Self-referencing FK on supply_contract (renewed_supply_contract_id)',
    `amendment_count` STRING COMMENT 'Total number of formal amendments or change orders issued against this contract since its original execution.',
    `annual_committed_spend` DECIMAL(18,2) COMMENT 'Minimum or expected annual spend commitment under this contract, used for budget planning and vendor performance tracking.',
    `approval_date` DATE COMMENT 'Date when the contract was formally approved by the authorized signatory or procurement governance board.',
    `auto_renewal_flag` BOOLEAN COMMENT 'Indicates whether the contract automatically renews for an additional term if not terminated by either party before the end date.',
    `confidentiality_clause_flag` BOOLEAN COMMENT 'Indicates whether the contract includes a confidentiality or non-disclosure clause restricting the sharing of contract terms or vendor information.',
    `contract_number` STRING COMMENT 'Externally-known unique business identifier for the contract, used in procurement systems and vendor communications.. Valid values are `^[A-Z0-9]{3,20}$`',
    `contract_status` STRING COMMENT 'Current lifecycle state of the contract: draft (being prepared), under negotiation (in vendor discussions), active (in force), suspended (temporarily paused), expired (end date reached), terminated (ended early), or cancelled (voided before activation). [ENUM-REF-CANDIDATE: draft|under_negotiation|active|suspended|expired|terminated|cancelled — 7 candidates stripped; promote to reference product]',
    `contract_title` STRING COMMENT 'Short descriptive title of the contract for quick identification and reporting purposes.',
    `contract_type` STRING COMMENT 'Classification of the contract pricing and engagement model: fixed price (lump sum), time and material (hourly/daily rates), framework (call-off agreement), blanket order (quantity-based), SLA-based (service level agreement), or cost-plus (reimbursable).. Valid values are `fixed_price|time_and_material|framework|blanket_order|sla_based|cost_plus`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this contract record was first created in the procurement system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code in which contract values and payments are denominated.. Valid values are `^[A-Z]{3}$`',
    `dispute_resolution_method` STRING COMMENT 'Contractually agreed method for resolving disputes: litigation (court proceedings), arbitration (binding third-party decision), mediation (facilitated negotiation), or negotiation (direct party discussions).. Valid values are `litigation|arbitration|mediation|negotiation`',
    `document_repository_reference` STRING COMMENT 'URI, file path, or document management system reference pointing to the signed contract document, amendments, and related legal attachments.',
    `effective_end_date` DATE COMMENT 'Date when the contract terms expire and the vendor obligation ends. Nullable for open-ended or evergreen contracts.',
    `effective_start_date` DATE COMMENT 'Date when the contract terms become binding and the vendor may begin delivering goods or services.',
    `governing_law_jurisdiction` STRING COMMENT 'Legal jurisdiction and governing law specified in the contract for dispute resolution and interpretation (e.g., State of New York, England and Wales, Singapore).',
    `insurance_requirement_flag` BOOLEAN COMMENT 'Indicates whether the vendor is contractually required to maintain specific insurance coverage (e.g., liability, professional indemnity, workers compensation) during the contract term.',
    `last_amendment_date` DATE COMMENT 'Date of the most recent amendment, addendum, or change order to the original contract terms.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this contract record was most recently updated in the procurement system.',
    `legal_entity_code` STRING COMMENT 'Code identifying the airline legal entity (subsidiary, operating company, or regional entity) that is the contracting party on behalf of the airline group.. Valid values are `^[A-Z0-9]{2,10}$`',
    `payment_terms_days` STRING COMMENT 'Number of days from invoice date within which payment is due to the vendor, as stipulated in the contract.',
    `penalty_clauses` STRING COMMENT 'Description of financial penalties, liquidated damages, or other remedies applicable if the vendor fails to meet contractual obligations or SLA targets.',
    `price_escalation_clause` STRING COMMENT 'Textual description of any contractual provisions allowing price adjustments over time due to inflation, index changes, or other economic factors.',
    `pricing_mechanism` STRING COMMENT 'Method by which prices are determined under this contract: fixed (static price), indexed (tied to external index such as fuel index or CPI), formula-based (calculated using agreed formula), market-rate (prevailing market price at time of order), or negotiated (case-by-case pricing).. Valid values are `fixed|indexed|formula_based|market_rate|negotiated`',
    `renewal_term_months` STRING COMMENT 'Duration in months for each automatic renewal period if auto-renewal is enabled.',
    `scope_description` STRING COMMENT 'Detailed narrative describing the goods, services, or materials covered under this contract, including any specific performance requirements or deliverables.',
    `signed_date` DATE COMMENT 'Date when the contract was executed (signed by both airline and vendor parties).',
    `sla_terms_summary` STRING COMMENT 'High-level summary of service level commitments, performance targets, response times, and availability guarantees stipulated in the contract.',
    `sustainability_criteria_flag` BOOLEAN COMMENT 'Indicates whether the contract includes environmental, social, or governance (ESG) performance criteria or sustainability commitments aligned with CORSIA or airline sustainability goals.',
    `termination_notice_period_days` STRING COMMENT 'Number of days advance written notice required by either party to terminate the contract before its natural expiration.',
    `total_contract_value` DECIMAL(18,2) COMMENT 'Total monetary value committed under this contract over its full term, including all line items and estimated volumes.',
    CONSTRAINT pk_supply_contract PRIMARY KEY(`supply_contract_id`)
) COMMENT 'Master record for all supply and service contracts negotiated between the airline and its vendors — fuel supply agreements, MRO framework agreements, catering contracts, ground handling agreements, and general procurement contracts. Captures contract number, contract type (fixed price, time-and-material, framework, blanket order, SLA-based), vendor reference, contract title, scope description, start date, end date, auto-renewal flag, total contract value, annual committed spend, currency, payment terms, pricing mechanism (fixed, indexed, formula-based), price escalation clause, SLA terms summary, penalty clauses, termination notice period, contract owner (buyer), legal entity, contract status (draft, under negotiation, active, expired, terminated), and document repository reference. SSOT for all vendor contractual commitments.';

CREATE OR REPLACE TABLE `airlines_ecm`.`procurement`.`part_master` (
    `part_master_id` BIGINT COMMENT 'Unique identifier for the part master record. Primary key for all aircraft parts, components, consumables, and materials managed within the airlines procurement and inventory system.',
    `vendor_id` BIGINT COMMENT 'Identifier of the preferred or primary vendor for this part, based on contract terms, pricing, quality, and delivery performance.',
    `superseded_by_part_master_id` BIGINT COMMENT 'Identifier of the replacement part that supersedes this part when it becomes obsolete or phased out. Null if no superseding part exists.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Airlines assign engineering employees as technical owners for part master records. Owner maintains airworthiness data, approves substitutions, manages obsolescence, and coordinates with OEMs. Essentia',
    `superseded_part_master_id` BIGINT COMMENT 'Self-referencing FK on part_master (superseded_part_master_id)',
    `airline_material_number` STRING COMMENT 'Internal material number assigned by the airline for inventory and procurement management. Used across ERP and MRO systems.. Valid values are `^[A-Z0-9]{6,20}$`',
    `airworthiness_approval_reference` STRING COMMENT 'Reference to the airworthiness certification or approval for this part, such as FAA Parts Manufacturer Approval (PMA) number, EASA ETSO authorization, or OEM type certificate reference.',
    `ata_chapter_code` STRING COMMENT 'Two-digit ATA chapter code classifying the aircraft system to which this part belongs (e.g., 32 for Landing Gear, 71 for Power Plant).. Valid values are `^[0-9]{2}$`',
    `ata_section_code` STRING COMMENT 'Four-digit ATA section code providing granular classification within the ATA chapter (e.g., 32-41 for Wheels and Brakes).. Valid values are `^[0-9]{2}-[0-9]{2}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this part master record was first created in the system.',
    `criticality_classification` STRING COMMENT 'Business criticality classification: aog_critical (Aircraft on Ground - immediate operational impact), flight_critical (required for flight safety or dispatch), non_critical (routine maintenance or support).. Valid values are `aog_critical|flight_critical|non_critical`',
    `easa_etso_flag` BOOLEAN COMMENT 'Indicates whether this part holds EASA European Technical Standard Order authorization, required for installation on EASA-certified aircraft.',
    `easa_part_classification` STRING COMMENT 'EASA classification code for the part, required for compliance with European aviation regulations and Part-21 certification.',
    `faa_pma_flag` BOOLEAN COMMENT 'Indicates whether this part holds FAA Parts Manufacturer Approval, allowing it to be used as a replacement part on FAA-certified aircraft.',
    `hazmat_classification` STRING COMMENT 'IATA Dangerous Goods Regulation (DGR) class if the part is classified as hazardous material (e.g., Class 3 Flammable Liquids, Class 9 Miscellaneous). Empty if non-hazardous.',
    `icao_part_classification` STRING COMMENT 'ICAO classification code for the part type, used for international regulatory compliance and customs documentation.',
    `interchangeable_part_group` STRING COMMENT 'Identifier for a group of parts that are functionally interchangeable and can substitute for one another in maintenance and inventory management.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this part master record was most recently updated or modified.',
    `last_purchase_date` DATE COMMENT 'Date of the most recent purchase order issued for this part, used to track procurement activity and identify slow-moving inventory.',
    `last_purchase_price_amount` DECIMAL(18,2) COMMENT 'Most recent actual purchase price paid per unit of measure for this part, used for cost trending and procurement analytics.',
    `last_purchase_price_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the last purchase price amount.. Valid values are `^[A-Z]{3}$`',
    `lead_time_days` STRING COMMENT 'Standard procurement lead time in days from purchase order issuance to delivery at the airlines warehouse or maintenance facility.',
    `manufacturer_cage_code` STRING COMMENT 'Five-character CAGE code assigned by NATO or US Defense Logistics Agency to identify the manufacturer. Used for traceability and airworthiness compliance.. Valid values are `^[A-Z0-9]{5}$`',
    `manufacturer_name` STRING COMMENT 'Legal name of the original equipment manufacturer (OEM) or parts manufacturer organization that produces this part.',
    `manufacturer_part_number` STRING COMMENT 'The original equipment manufacturer (OEM) part number as assigned by the manufacturer. This is the authoritative external identifier for the part.. Valid values are `^[A-Z0-9-]{5,30}$`',
    `minimum_order_quantity` STRING COMMENT 'Minimum quantity that must be ordered from the supplier in a single purchase order, as specified by vendor contract or manufacturer policy.',
    `obsolescence_date` DATE COMMENT 'Date on which the part was marked as obsolete or phased out. Null for active parts.',
    `part_description` STRING COMMENT 'Detailed textual description of the part, component, or material including its function, specifications, and identifying characteristics.',
    `part_master_status` STRING COMMENT 'Current lifecycle status of the part master record: active (available for procurement and use), obsolete (no longer procured or used), phased_out (being replaced), restricted (use limited by policy or regulation), pending_approval (awaiting engineering or quality approval).. Valid values are `active|obsolete|phased_out|restricted|pending_approval`',
    `part_type` STRING COMMENT 'Classification of the part based on its lifecycle and repairability: rotable (repairable high-value component tracked by serial number), repairable (can be repaired but lower value), expendable (discarded after use), consumable (used up in operations), raw material (bulk material).. Valid values are `rotable|repairable|expendable|consumable|raw_material`',
    `serialized_tracking_flag` BOOLEAN COMMENT 'Indicates whether this part requires individual serial number tracking for traceability, maintenance history, and airworthiness compliance. Typically true for rotable and high-value repairable parts.',
    `shelf_life_days` STRING COMMENT 'Maximum number of days the part can be stored before it must be used, inspected, or discarded. Null for parts with indefinite shelf life.',
    `standard_cost_amount` DECIMAL(18,2) COMMENT 'Standard cost per unit of measure for this part as maintained in the ERP system for inventory valuation and cost accounting purposes.',
    `standard_cost_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the standard cost amount (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `unit_of_measure` STRING COMMENT 'Standard unit of measure for ordering, stocking, and issuing this part (e.g., each, liter, kilogram). [ENUM-REF-CANDIDATE: each|set|kit|liter|gallon|kilogram|pound|meter|foot|box|case — 11 candidates stripped; promote to reference product]',
    CONSTRAINT pk_part_master PRIMARY KEY(`part_master_id`)
) COMMENT 'Master catalog record for all aircraft parts, components, consumables, and materials managed within the airlines procurement and inventory system. Captures part number (manufacturer P/N), airline internal material number, part description, ATA chapter and section code, part type (rotable, repairable, expendable, consumable, raw material), unit of measure, manufacturer name, manufacturer CAGE code, ICAO/EASA part classification, hazardous material classification (IATA DGR class), shelf life (days), minimum order quantity, standard cost, last purchase price, preferred vendor, lead time (days), criticality classification (AOG-critical, flight-critical, non-critical), airworthiness approval reference (FAA PMA, EASA ETSO), and active/obsolete status. The SSOT for all procurable materials and parts identity within the procurement domain.';

CREATE OR REPLACE TABLE `airlines_ecm`.`procurement`.`parts_inventory` (
    `parts_inventory_id` BIGINT COMMENT 'Unique identifier for the parts inventory record. Primary key for this entity.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Airlines assign warehouse employees as custodians for inventory locations/zones. Custodian is accountable for cycle counts, stock accuracy, and shelf-life monitoring. Essential for inventory audits, s',
    `part_master_id` BIGINT COMMENT 'FK to procurement.part_master',
    `vendor_id` BIGINT COMMENT 'Identifier of the primary vendor or supplier for this part, used for procurement planning and supplier performance tracking.',
    `transferred_from_parts_inventory_id` BIGINT COMMENT 'Self-referencing FK on parts_inventory (transferred_from_parts_inventory_id)',
    `abc_classification` STRING COMMENT 'Inventory classification based on value and criticality. A items are high-value or critical parts requiring tight control, B items are moderate importance, C items are low-value or non-critical parts.. Valid values are `A|B|C`',
    `average_weighted_cost` DECIMAL(18,2) COMMENT 'Average unit cost of the part calculated using weighted average costing method, used for inventory valuation and financial reporting.',
    `batch_number` STRING COMMENT 'Manufacturer batch or lot number for traceability of parts, critical for quality control and airworthiness compliance.',
    `bonded_store_flag` BOOLEAN COMMENT 'Indicates whether the inventory is held in a customs bonded warehouse, allowing duty-free storage until parts are released for domestic use or re-exported.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this inventory record was first created in the system.',
    `criticality_code` STRING COMMENT 'Operational criticality classification indicating the impact of part unavailability. AOG (Aircraft on Ground) critical parts cause immediate aircraft grounding, flight critical parts affect safety, standard parts support routine maintenance, non-critical parts have minimal operational impact.. Valid values are `aog_critical|flight_critical|standard|non_critical`',
    `currency_code` STRING COMMENT 'Three-letter ISO currency code for the cost and value amounts.. Valid values are `^[A-Z]{3}$`',
    `hazmat_flag` BOOLEAN COMMENT 'Indicates whether the part is classified as hazardous material requiring special handling, storage, and transportation procedures per IATA Dangerous Goods Regulations.',
    `last_issue_date` DATE COMMENT 'Date when the part was last issued from inventory to a maintenance work order or other consumption activity.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this inventory record was last updated, used for change tracking and data synchronization.',
    `last_movement_date` DATE COMMENT 'Date of the most recent inventory transaction for this part, including receipts, issues, transfers, or adjustments.',
    `last_physical_count_date` DATE COMMENT 'Date when the last physical inventory count or cycle count was performed for this part at this location to verify system accuracy.',
    `last_purchase_order_date` DATE COMMENT 'Date when the most recent purchase order was placed for this part, used for procurement pattern analysis.',
    `lead_time_days` STRING COMMENT 'Standard procurement lead time in days from purchase order placement to receipt of the part at the storage location.',
    `material_number` STRING COMMENT 'Unique material identifier assigned by the enterprise resource planning system. Standard part number used across procurement, maintenance, and inventory systems.. Valid values are `^[A-Z0-9]{8,18}$`',
    `maximum_stock_level` DECIMAL(18,2) COMMENT 'Maximum inventory quantity that should be maintained for this part at this location to avoid overstocking and excess carrying costs.',
    `minimum_order_quantity` DECIMAL(18,2) COMMENT 'Minimum quantity that must be ordered from the vendor per purchase order, often driven by vendor requirements or economic order quantity calculations.',
    `part_condition` STRING COMMENT 'Airworthiness condition status of the part. Serviceable parts are certified for installation, unserviceable parts require maintenance, repairable parts can be restored, beyond repair parts must be scrapped, and quarantine parts are under investigation.. Valid values are `serviceable|unserviceable|repairable|beyond_repair|quarantine`',
    `quantity_on_hand` DECIMAL(18,2) COMMENT 'Current physical quantity of the part available in the storage location, measured in the base unit of measure.',
    `quantity_on_order` DECIMAL(18,2) COMMENT 'Quantity of the part that has been ordered from vendors through purchase orders but not yet received into inventory.',
    `quantity_reserved` DECIMAL(18,2) COMMENT 'Quantity of the part that has been reserved or allocated for specific maintenance work orders, Aircraft on Ground (AOG) situations, or scheduled maintenance but not yet physically issued.',
    `reorder_point` DECIMAL(18,2) COMMENT 'Minimum inventory level threshold that triggers automatic procurement replenishment action. When quantity on hand falls below this level, a purchase requisition should be generated.',
    `rotable_flag` BOOLEAN COMMENT 'Indicates whether the part is a rotable component that can be repaired and returned to service multiple times, as opposed to expendable parts that are discarded after use.',
    `safety_stock_level` DECIMAL(18,2) COMMENT 'Buffer inventory quantity maintained to protect against demand variability and supply chain disruptions, particularly critical for AOG (Aircraft on Ground) prevention.',
    `serial_number` STRING COMMENT 'Unique serial number for serialized parts and rotable components that require individual tracking throughout their lifecycle.',
    `shelf_life_expiry_date` DATE COMMENT 'Expiration date for life-limited or time-sensitive parts such as chemicals, sealants, lubricants, and rubber components. Parts must be used or disposed of before this date per airworthiness regulations.',
    `station_iata_code` STRING COMMENT 'Three-letter IATA airport code identifying the station or airport where the inventory is located.. Valid values are `^[A-Z]{3}$`',
    `stock_status` STRING COMMENT 'Lifecycle status of the inventory item. Active items are currently stocked, inactive items are temporarily not replenished, obsolete items are no longer used, phase-out items are being replaced by newer parts.. Valid values are `active|inactive|obsolete|phase_out`',
    `stock_type` STRING COMMENT 'Classification of the inventory stock status indicating availability and usage restrictions. Unrestricted stock is available for use, quality inspection stock is under review, blocked stock cannot be used, consignment stock is vendor-owned, in-transit stock is being moved, and reserved stock is allocated to specific work orders.. Valid values are `unrestricted|quality_inspection|blocked|consignment|in_transit|reserved`',
    `storage_location_code` STRING COMMENT 'Code identifying the specific storage location within the warehouse or facility where the part is physically stored.. Valid values are `^[A-Z0-9]{4,10}$`',
    `total_stock_value` DECIMAL(18,2) COMMENT 'Total monetary value of the inventory on hand, calculated as quantity on hand multiplied by average weighted cost.',
    `unit_of_measure` STRING COMMENT 'Standard unit of measure for the part quantity, such as EA (each), KG (kilogram), LT (liter), or FT (feet).. Valid values are `^[A-Z]{2,3}$`',
    `warehouse_zone` STRING COMMENT 'Physical zone or area within the warehouse facility where the part is stored, used for optimizing picking and storage operations.',
    CONSTRAINT pk_parts_inventory PRIMARY KEY(`parts_inventory_id`)
) COMMENT 'Real-time and historical inventory position record for each part/material at each storage location (airline warehouse, MRO base, line station, bonded store). Captures material number, storage location code, station (airport IATA code), warehouse zone, stock type (unrestricted, quality inspection, blocked, consignment, in-transit), quantity on hand, quantity reserved, quantity on order, reorder point, maximum stock level, safety stock level, last physical count date, last movement date, average weighted cost, total stock value, and shelf-life expiry date for life-limited items. Enables procurement replenishment triggers and MRO material availability checks.';

CREATE OR REPLACE TABLE `airlines_ecm`.`procurement`.`sourcing_event` (
    `sourcing_event_id` BIGINT COMMENT 'Unique identifier for the sourcing event record. Primary key.',
    `employee_id` BIGINT COMMENT 'Reference to the executive or manager who approved the award decision. Null if approval not required or not yet obtained.',
    `vendor_id` BIGINT COMMENT 'Reference to the vendor that was awarded the contract or purchase order as a result of this sourcing event. Null if no award has been made or event was cancelled.',
    `primary_sourcing_employee_id` BIGINT COMMENT 'Reference to the procurement buyer or sourcing specialist responsible for issuing and managing this sourcing event.',
    `procurement_category_id` BIGINT COMMENT 'Reference to the procurement category this sourcing event belongs to (e.g., MRO parts, fuel, catering, ground services, IT services).',
    `prior_sourcing_event_id` BIGINT COMMENT 'Self-referencing FK on sourcing_event (prior_sourcing_event_id)',
    `approval_date` DATE COMMENT 'Date when the award decision was formally approved by the designated approver. Null if approval not required or not yet obtained.',
    `approval_required_flag` BOOLEAN COMMENT 'Indicates whether executive or management approval is required before awarding this sourcing event (true/false). Typically true for high-value contracts.',
    `award_date` DATE COMMENT 'Date when the contract or purchase order was formally awarded to the winning vendor.',
    `awarded_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the awarded contract value (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `awarded_value_amount` DECIMAL(18,2) COMMENT 'Total monetary value of the contract or purchase order awarded to the winning vendor. Null if no award has been made.',
    `baseline_value_amount` DECIMAL(18,2) COMMENT 'Baseline or budgeted amount for this sourcing event, used to calculate savings achieved. Typically based on current contract rates or market benchmarks.',
    `cancellation_reason` STRING COMMENT 'Explanation for why the sourcing event was cancelled, if applicable. Null if event was not cancelled.',
    `compliance_requirements` STRING COMMENT 'Specific regulatory, safety, or quality compliance requirements that vendors must meet (e.g., EASA Part 145, FAA repair station, ISO 9001, AS9100).',
    `confidentiality_level` STRING COMMENT 'Classification level for the sourcing event documentation and vendor responses (public, internal, confidential, restricted).. Valid values are `public|internal|confidential|restricted`',
    `contract_duration_months` STRING COMMENT 'Expected duration of the resulting contract in months. Used for multi-year agreements and framework contracts.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this sourcing event record was first created in the system.',
    `delivery_weight_percentage` DECIMAL(18,2) COMMENT 'Percentage weight assigned to delivery capability, lead time, and logistics in the evaluation criteria (0-100). Used in weighted scoring of vendor proposals.',
    `evaluation_completion_date` DATE COMMENT 'Date when the evaluation of vendor responses was completed and a decision was reached.',
    `evaluation_start_date` DATE COMMENT 'Date when the evaluation of vendor responses commenced.',
    `event_number` STRING COMMENT 'Business identifier for the sourcing event, externally visible and used in communications with vendors and internal stakeholders.. Valid values are `^[A-Z]{2,4}-[0-9]{6,10}$`',
    `event_status` STRING COMMENT 'Current lifecycle status of the sourcing event: draft (being prepared), published (open for vendor responses), responses received (submission deadline passed), evaluation (responses being assessed), awarded (vendor selected), cancelled (event terminated), or closed (completed). [ENUM-REF-CANDIDATE: draft|published|responses_received|evaluation|awarded|cancelled|closed — 7 candidates stripped; promote to reference product]',
    `event_title` STRING COMMENT 'Short descriptive title of the sourcing event for identification and reporting purposes.',
    `event_type` STRING COMMENT 'Type of sourcing event: RFI (Request for Information), RFQ (Request for Quotation), RFP (Request for Proposal), reverse auction, sealed bid, or framework agreement negotiation.. Valid values are `RFI|RFQ|RFP|reverse_auction|sealed_bid|framework_agreement`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this sourcing event record was last updated or modified.',
    `minimum_qualification_criteria` STRING COMMENT 'Mandatory minimum qualifications vendors must meet to be eligible for award (e.g., years in business, financial stability, certifications, references).',
    `notes` STRING COMMENT 'Free-text notes and comments about the sourcing event, evaluation process, or award decision for internal reference.',
    `price_weight_percentage` DECIMAL(18,2) COMMENT 'Percentage weight assigned to price in the evaluation criteria (0-100). Used in weighted scoring of vendor proposals.',
    `publication_date` DATE COMMENT 'Date when the sourcing event was published and made available to invited vendors.',
    `quality_weight_percentage` DECIMAL(18,2) COMMENT 'Percentage weight assigned to quality standards, certifications, and compliance in the evaluation criteria (0-100). Used in weighted scoring of vendor proposals.',
    `response_deadline` TIMESTAMP COMMENT 'Date and time by which vendors must submit their responses (bids, proposals, quotations) for this sourcing event.',
    `responses_received_count` STRING COMMENT 'Total number of vendor responses (bids, proposals, quotations) received by the response deadline.',
    `savings_achieved_amount` DECIMAL(18,2) COMMENT 'Total savings achieved versus the baseline value, calculated as baseline minus awarded value. Positive values indicate cost reduction.',
    `savings_percentage` DECIMAL(18,2) COMMENT 'Percentage savings achieved versus baseline, calculated as (savings_achieved_amount / baseline_value_amount) * 100.',
    `scope_description` STRING COMMENT 'Detailed description of the scope, requirements, and objectives of the sourcing event, including technical specifications and business requirements.',
    `strategic_initiative_reference` STRING COMMENT 'Reference code or identifier linking this sourcing event to a broader strategic sourcing initiative or cost reduction program.',
    `technical_weight_percentage` DECIMAL(18,2) COMMENT 'Percentage weight assigned to technical capability and quality in the evaluation criteria (0-100). Used in weighted scoring of vendor proposals.',
    `vendors_invited_count` STRING COMMENT 'Total number of vendors invited to participate in this sourcing event.',
    CONSTRAINT pk_sourcing_event PRIMARY KEY(`sourcing_event_id`)
) COMMENT 'Master record for formal sourcing and tendering events conducted by the procurement team — RFI (Request for Information), RFQ (Request for Quotation), RFP (Request for Proposal), and reverse auction events. Captures sourcing event number, event type (RFI, RFQ, RFP, reverse auction), procurement category, event title, scope description, issuing buyer, event status (draft, published, responses received, evaluation, awarded, cancelled), publication date, response deadline, evaluation criteria (price weight, technical weight, delivery weight), number of vendors invited, number of responses received, awarded vendor reference, awarded value, savings achieved versus baseline, and strategic sourcing initiative reference. Supports strategic sourcing governance and spend analytics.';

CREATE OR REPLACE TABLE `airlines_ecm`.`procurement`.`vendor_quote` (
    `vendor_quote_id` BIGINT COMMENT 'Unique identifier for the vendor quotation record. Primary key.',
    `employee_id` BIGINT COMMENT 'Reference to the procurement or technical specialist who evaluated this quotation.',
    `sourcing_event_id` BIGINT COMMENT 'Reference to the sourcing event (RFQ/RFP) that triggered this quotation. Links quote to the procurement request.',
    `vendor_id` BIGINT COMMENT 'Reference to the vendor who submitted this quotation.',
    `revised_vendor_quote_id` BIGINT COMMENT 'Self-referencing FK on vendor_quote (revised_vendor_quote_id)',
    `award_date` DATE COMMENT 'Date when this quotation was awarded and the vendor was notified of selection. Null if not awarded.',
    `commercial_evaluation_score` DECIMAL(18,2) COMMENT 'Numerical score assigned during commercial evaluation, reflecting price competitiveness, payment terms, and delivery lead time. Typically on a 0-100 scale.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this vendor quote record was first created in the procurement system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code in which the quotation is denominated (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `delivery_lead_time_days` STRING COMMENT 'Number of days the vendor requires to deliver the goods or services after purchase order issuance.',
    `evaluation_completed_date` DATE COMMENT 'Date when the evaluation of this quotation was completed and scores were finalized.',
    `exceptions_and_deviations` STRING COMMENT 'Free-text description of any exceptions, deviations, or clarifications the vendor has noted against the sourcing event requirements.',
    `incoterms` STRING COMMENT 'Incoterms rule defining the delivery point, risk transfer, and cost responsibilities between vendor and airline. [ENUM-REF-CANDIDATE: EXW|FCA|CPT|CIP|DAP|DPU|DDP|FAS|FOB|CFR|CIF — 11 candidates stripped; promote to reference product]',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this vendor quote record was last updated in the procurement system.',
    `minimum_order_quantity` DECIMAL(18,2) COMMENT 'Minimum order quantity required by the vendor for this quotation to be valid.',
    `overall_ranking` STRING COMMENT 'Overall rank of this quotation among all quotes received for the sourcing event, based on combined commercial and technical evaluation. Rank 1 is the best.',
    `payment_terms_offered` STRING COMMENT 'Payment terms proposed by the vendor (e.g., Net 30, Net 60, 2/10 Net 30, advance payment, letter of credit).',
    `quote_document_url` STRING COMMENT 'URL or file path to the original quotation document submitted by the vendor (PDF, Excel, etc.).',
    `quote_reference_number` STRING COMMENT 'Externally-known unique reference number assigned to this vendor quotation, used for tracking and communication with the vendor.. Valid values are `^[A-Z0-9]{8,20}$`',
    `quote_status` STRING COMMENT 'Current lifecycle status of the vendor quotation in the evaluation and award process. [ENUM-REF-CANDIDATE: received|under_evaluation|shortlisted|awarded|rejected|withdrawn|expired — 7 candidates stripped; promote to reference product]',
    `quote_type` STRING COMMENT 'Classification of the quotation based on the sourcing context (formal RFQ/RFP response, ad-hoc price enquiry, spot purchase, or framework agreement quote).. Valid values are `rfq_response|rfp_response|ad_hoc|spot_quote|framework_quote`',
    `quoted_total_value` DECIMAL(18,2) COMMENT 'Total value of the quotation across all line items, including all charges but before taxes. Expressed in the quote currency.',
    `quoted_unit_price` DECIMAL(18,2) COMMENT 'Unit price quoted by the vendor for the line item or material. Expressed in the quote currency.',
    `rejection_reason` STRING COMMENT 'Free-text explanation of why this quotation was rejected, if applicable (e.g., non-compliance, high price, late submission).',
    `submission_date` DATE COMMENT 'Date when the vendor submitted this quotation to the airline.',
    `submission_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the vendor submitted this quotation, used for deadline compliance verification.',
    `technical_compliance_notes` STRING COMMENT 'Free-text notes documenting the vendors technical compliance with specifications, standards, and regulatory requirements (e.g., EASA Part 145, FAA approval, OEM certification).',
    `technical_evaluation_score` DECIMAL(18,2) COMMENT 'Numerical score assigned during technical evaluation, reflecting compliance with specifications, certifications, and quality standards. Typically on a 0-100 scale.',
    `validity_end_date` DATE COMMENT 'Date until which the quoted prices and terms remain valid. After this date, vendor may revise pricing.',
    `validity_start_date` DATE COMMENT 'Date from which the quoted prices and terms become valid.',
    `vendor_contact_email` STRING COMMENT 'Email address of the vendor representative for communication regarding this quotation.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `vendor_contact_name` STRING COMMENT 'Name of the vendor representative who submitted or is responsible for this quotation.',
    `vendor_contact_phone` STRING COMMENT 'Phone number of the vendor representative for communication regarding this quotation.',
    `warranty_period_months` STRING COMMENT 'Duration of warranty coverage offered by the vendor, expressed in months.',
    CONSTRAINT pk_vendor_quote PRIMARY KEY(`vendor_quote_id`)
) COMMENT 'Vendor quotation record submitted in response to a sourcing event (RFQ/RFP) or ad-hoc price enquiry. Captures quote reference number, sourcing event reference, vendor reference, quote submission date, quote validity date, quoted unit price per line item, total quoted value, currency, delivery lead time offered, payment terms offered, technical compliance notes, exceptions and deviations noted, evaluation score (commercial), evaluation score (technical), overall ranking, and quote status (received, under evaluation, shortlisted, awarded, rejected). Enables competitive bid comparison and sourcing decision documentation.';

CREATE OR REPLACE TABLE `airlines_ecm`.`procurement`.`fuel_contract` (
    `fuel_contract_id` BIGINT COMMENT 'Unique identifier for the aviation fuel supply contract. Primary key.',
    `employee_id` BIGINT COMMENT 'Reference to the procurement or fuel management employee responsible for managing this contract.',
    `primary_fuel_approved_by_employee_id` BIGINT COMMENT 'Reference to the senior manager or executive who approved this fuel contract.',
    `procurement_category_id` BIGINT COMMENT 'Foreign key linking to procurement.procurement_category. Business justification: Fuel contracts must be classified by procurement category for spend analytics, category management, sourcing strategy alignment, and fuel cost benchmarking. Core to strategic fuel procurement and cost',
    `vendor_id` BIGINT COMMENT 'Reference to the fuel supplier providing aviation fuel under this contract.',
    `renewed_fuel_contract_id` BIGINT COMMENT 'Self-referencing FK on fuel_contract (renewed_fuel_contract_id)',
    `airport_iata_code` STRING COMMENT 'Three-letter IATA station code identifying the airport where fuel is supplied under this contract.. Valid values are `^[A-Z]{3}$`',
    `amendment_count` STRING COMMENT 'Total number of amendments made to the original contract since inception.',
    `approval_date` DATE COMMENT 'Date when the fuel contract was formally approved by authorized personnel.',
    `auto_renewal_flag` BOOLEAN COMMENT 'Indicates whether the contract automatically renews at the end of the term unless terminated by either party.',
    `base_price_per_litre` DECIMAL(18,2) COMMENT 'Base fuel price per litre in the contract currency, before uplift fees and adjustments. Confidential commercial term.',
    `carbon_intensity_gco2_per_mj` DECIMAL(18,2) COMMENT 'Carbon intensity of the fuel in grams of CO2 equivalent per megajoule of energy, used for sustainability reporting and CORSIA compliance.',
    `contract_number` STRING COMMENT 'Externally-known business identifier for the fuel supply contract, used in procurement documents and vendor communications.. Valid values are `^[A-Z0-9]{6,20}$`',
    `contract_status` STRING COMMENT 'Current lifecycle status of the fuel supply contract.. Valid values are `draft|active|suspended|expired|terminated`',
    `contract_type` STRING COMMENT 'Classification of the fuel contract: spot (short-term market rate), term (fixed period agreement), hedged (price-protected), into-plane (full-service fueling agreement including delivery).. Valid values are `spot|term|hedged|into-plane`',
    `contracted_volume_litres_per_month` DECIMAL(18,2) COMMENT 'Monthly fuel volume commitment in litres that the airline agrees to uplift under this contract.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this fuel contract record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary values in this contract (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `delivery_method` STRING COMMENT 'Physical method of fuel delivery at the airport: hydrant (underground pipeline to aircraft stand), bowser (mobile fuel truck), pipeline (direct line), truck (tanker delivery).. Valid values are `hydrant|bowser|pipeline|truck`',
    `effective_end_date` DATE COMMENT 'Date when the fuel supply contract expires or terminates. Nullable for open-ended contracts.',
    `effective_start_date` DATE COMMENT 'Date when the fuel supply contract becomes active and fuel delivery obligations commence.',
    `force_majeure_clause_flag` BOOLEAN COMMENT 'Indicates whether the contract includes a force majeure clause allowing suspension of obligations during extraordinary events.',
    `fuel_type` STRING COMMENT 'Type of aviation fuel covered by this contract: Jet-A (US standard), Jet-A1 (international standard), Avgas (aviation gasoline for piston engines), or SAF (Sustainable Aviation Fuel).. Valid values are `Jet-A|Jet-A1|Avgas|SAF`',
    `hedge_contract_reference` STRING COMMENT 'Reference identifier to the associated financial hedging instrument used to mitigate fuel price risk for this physical supply contract. Links to finance.hedge_contract.',
    `last_amendment_date` DATE COMMENT 'Date of the most recent amendment or modification to the contract terms.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this fuel contract record was last updated in the system.',
    `minimum_offtake_commitment_litres` DECIMAL(18,2) COMMENT 'Minimum total fuel volume in litres that the airline must uplift over the contract period to avoid penalties.',
    `notes` STRING COMMENT 'Free-text field for additional contract details, special terms, or operational notes relevant to fuel procurement and delivery.',
    `notice_period_days` STRING COMMENT 'Number of days advance notice required by either party to terminate or modify the contract.',
    `payment_terms_days` STRING COMMENT 'Number of days from invoice date within which payment is due to the fuel supplier.',
    `pricing_mechanism` STRING COMMENT 'Method used to determine fuel price: PLATTS-indexed (linked to PLATTS commodity index), fixed (predetermined price), formula (calculated based on agreed parameters), market-linked (tied to spot market rates).. Valid values are `PLATTS-indexed|fixed|formula|market-linked`',
    `quality_specification_reference` STRING COMMENT 'Reference to the fuel quality standard that the supplier must meet (e.g., DEF STAN 91-091, ASTM D1655, IATA Guidance Material).',
    `sustainability_certification` STRING COMMENT 'Certification standard for sustainable aviation fuel (SAF) if applicable, such as CORSIA-eligible, RSB (Roundtable on Sustainable Biomaterials), or ISCC (International Sustainability and Carbon Certification).',
    `uplift_fee_cents_per_litre` DECIMAL(18,2) COMMENT 'Additional fee charged per litre for into-plane fueling service, expressed in cents. Confidential commercial term.',
    `volume_tolerance_percentage` DECIMAL(18,2) COMMENT 'Allowable percentage variance (plus or minus) from contracted monthly volume without penalty.',
    CONSTRAINT pk_fuel_contract PRIMARY KEY(`fuel_contract_id`)
) COMMENT 'Master record for aviation fuel supply contracts and into-plane fueling agreements at specific airports. Captures fuel contract number, fuel supplier (vendor reference), airport (IATA station code), fuel type (Jet-A, Jet-A1, Avgas, SAF — Sustainable Aviation Fuel), contract type (spot, term, hedged, into-plane), contract start and end date, contracted volume (litres/month), pricing mechanism (PLATTS-indexed, fixed, formula), base price, uplift fee (cents per litre), currency, minimum offtake commitment, volume tolerance percentage, quality specification reference (DEF STAN 91-091, ASTM D1655), delivery method (hydrant, bowser), contract status, and associated hedge contract reference. Distinct from finance.hedge_contract which covers the financial hedging instrument — this is the physical supply agreement.';

CREATE OR REPLACE TABLE `airlines_ecm`.`procurement`.`fuel_uplift_order` (
    `fuel_uplift_order_id` BIGINT COMMENT 'Unique identifier for the fuel uplift order transaction. Primary key for this product.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Fuel uplift orders require approval by flight ops coordinators or fuel managers, especially for off-contract uplifts or variance disputes. Essential for cost control, quality assurance, and invoice re',
    `flight_leg_id` BIGINT COMMENT 'Reference to the specific flight leg for which this fuel uplift was ordered.',
    `fuel_contract_id` BIGINT COMMENT 'Reference to the master fuel supply contract under which this uplift order was placed.',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to procurement.vendor. Business justification: Fuel uplift orders are serviced by fueling companies which are vendors in the vendor master. Currently uses fueling_company_name and fueling_company_code (STRING) which are denormalized. Adding fuelin',
    `amended_fuel_uplift_order_id` BIGINT COMMENT 'Self-referencing FK on fuel_uplift_order (amended_fuel_uplift_order_id)',
    `actual_uplift_quantity` DECIMAL(18,2) COMMENT 'Actual quantity of fuel delivered and uplifted into the aircraft, measured in the unit specified by actual_uplift_quantity_unit.',
    `actual_uplift_quantity_unit` STRING COMMENT 'Unit of measure for the actual uplifted fuel quantity (litres, kilograms, gallons, pounds).. Valid values are `LITRES|KILOGRAMS|GALLONS|POUNDS`',
    `aircraft_registration` STRING COMMENT 'Tail number or registration mark of the aircraft receiving the fuel uplift.. Valid values are `^[A-Z0-9-]{5,10}$`',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when the fuel uplift order was approved for payment, in ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX).',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this fuel uplift order record was first created in the system, in ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX).',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the fuel uplift transaction (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `dispute_reason` STRING COMMENT 'Explanation or reason code if the fuel uplift order status is disputed, such as quantity discrepancy, quality issue, or pricing error.',
    `fuel_density` DECIMAL(18,2) COMMENT 'Density of the fuel at the time of uplift, measured in kg/litre, used for volume-to-weight conversion.',
    `fuel_receipt_document_number` STRING COMMENT 'Document number or reference from the fuel receipt provided by the into-plane agent, used for reconciliation.. Valid values are `^[A-Z0-9-]{8,20}$`',
    `fuel_temperature_celsius` DECIMAL(18,2) COMMENT 'Temperature of the fuel at the time of uplift, measured in degrees Celsius, affecting density calculations.',
    `fuel_type` STRING COMMENT 'Type of aviation fuel uplifted (e.g., Jet A-1, Jet A, Avgas 100LL).. Valid values are `JET_A1|JET_A|AVGAS_100LL|AVGAS_UL|JET_B`',
    `fueling_agent_name` STRING COMMENT 'Name of the individual fueling agent or technician who performed the fuel uplift operation.',
    `fueling_end_timestamp` TIMESTAMP COMMENT 'Date and time when the fuel uplift operation was completed, in ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX).',
    `fueling_start_timestamp` TIMESTAMP COMMENT 'Date and time when the fuel uplift operation began, in ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX).',
    `invoice_number` STRING COMMENT 'Invoice number issued by the fueling company for this fuel uplift transaction, used for accounts payable processing.. Valid values are `^[A-Z0-9-]{8,20}$`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this fuel uplift order record was last updated in the system, in ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX).',
    `order_placed_timestamp` TIMESTAMP COMMENT 'Date and time when the fuel uplift order was originally placed, in ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX). Represents the principal business event timestamp for this transaction.',
    `ordered_quantity` DECIMAL(18,2) COMMENT 'Quantity of fuel ordered for uplift, measured in the unit specified by ordered_quantity_unit.',
    `ordered_quantity_unit` STRING COMMENT 'Unit of measure for the ordered fuel quantity (litres, kilograms, gallons, pounds).. Valid values are `LITRES|KILOGRAMS|GALLONS|POUNDS`',
    `payment_status` STRING COMMENT 'Current payment status of the fuel uplift order invoice (pending, paid, overdue, disputed).. Valid values are `PENDING|PAID|OVERDUE|DISPUTED`',
    `quality_check_passed` BOOLEAN COMMENT 'Indicates whether the fuel quality inspection passed all required standards (True) or failed (False).',
    `quality_check_timestamp` TIMESTAMP COMMENT 'Date and time when the fuel quality check was performed, in ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX).',
    `remarks` STRING COMMENT 'Free-text field for additional notes, comments, or special instructions related to the fuel uplift order.',
    `station_code` STRING COMMENT 'Three-letter IATA airport code where the fuel uplift occurred.. Valid values are `^[A-Z]{3}$`',
    `total_cost` DECIMAL(18,2) COMMENT 'Total cost of the fuel uplift, calculated as actual uplift quantity multiplied by unit price.',
    `unit_price` DECIMAL(18,2) COMMENT 'Price per unit of fuel applied to this uplift order, as per the fuel contract terms.',
    `uplift_order_number` STRING COMMENT 'Business-facing unique order number for this fuel uplift transaction, used for tracking and reconciliation.. Valid values are `^FUO-[0-9]{10}$`',
    `uplift_status` STRING COMMENT 'Current lifecycle status of the fuel uplift order (ordered, in-progress, completed, disputed, cancelled).. Valid values are `ORDERED|IN_PROGRESS|COMPLETED|DISPUTED|CANCELLED`',
    `variance_quantity` DECIMAL(18,2) COMMENT 'Difference between ordered quantity and actual uplift quantity, calculated as (actual_uplift_quantity - ordered_quantity). Positive values indicate over-delivery, negative values indicate under-delivery.',
    CONSTRAINT pk_fuel_uplift_order PRIMARY KEY(`fuel_uplift_order_id`)
) COMMENT 'Transactional record for individual fuel uplift orders placed against fuel contracts for specific flight departures. Captures uplift order number, fuel contract reference, flight leg reference, station (airport IATA code), aircraft registration, fuel type, ordered quantity (litres/kg), actual uplift quantity, density, temperature, unit price applied, total cost, currency, fueling company (into-plane agent), fueling start and end time, fueling agent name, fuel receipt document number, quality check passed flag, and uplift status (ordered, in-progress, completed, disputed). Provides the procurement-layer fuel transaction record linking supply contracts to individual flight fuel events.';

CREATE OR REPLACE TABLE `airlines_ecm`.`procurement`.`catering_order` (
    `catering_order_id` BIGINT COMMENT 'Unique identifier for the catering order record. Primary key.',
    `flight_leg_id` BIGINT COMMENT 'Reference to the specific flight leg for which catering is being ordered.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Catering orders are initiated by crew schedulers, cabin services coordinators, or flight ops employees. Tracks who requested specific meal counts and special meals. Essential for accountability when c',
    `supply_contract_id` BIGINT COMMENT 'Foreign key linking to procurement.supply_contract. Business justification: Catering orders are placed against supply contracts with catering vendors. Currently uses contract_reference (STRING) which is a denormalized business reference. Adding supply_contract_id FK normalize',
    `vendor_id` BIGINT COMMENT 'Reference to the catering supplier providing the service for this order.',
    `amended_catering_order_id` BIGINT COMMENT 'Self-referencing FK on catering_order (amended_catering_order_id)',
    `actual_meal_count_delivered` STRING COMMENT 'Total number of meals actually delivered and uplifted, used to calculate variance against ordered quantity.',
    `actual_uplift_timestamp` TIMESTAMP COMMENT 'Date and time when catering was physically loaded onto the aircraft, recorded by ground handling or catering supervisor.',
    `beverage_quantity_units` STRING COMMENT 'Total quantity of beverage units ordered, measured in standard service units (bottles, cans, cartons) as defined in the catering contract.',
    `business_class_meal_count` STRING COMMENT 'Total number of standard meals ordered for Business Class cabin, excluding special meals.',
    `cancellation_reason` STRING COMMENT 'Explanation for order cancellation, typically due to flight cancellation, schedule change, or operational disruption.',
    `cancellation_timestamp` TIMESTAMP COMMENT 'Date and time when the catering order was cancelled, if applicable. Used for tracking Irregular Operations (IROP) impact on catering.',
    `catering_supervisor_name` STRING COMMENT 'Name of the catering supervisor who signed off on the order delivery and uplift, providing accountability for service completion.',
    `catering_supervisor_signature_timestamp` TIMESTAMP COMMENT 'Date and time when the catering supervisor signed off on the order, confirming completion of uplift.',
    `catering_uplift_station_code` STRING COMMENT 'Three-letter IATA airport code for the station where catering is physically loaded onto the aircraft. May differ from departure station for through flights.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this catering order record was first created in the system. Audit trail field.',
    `crew_meal_count` STRING COMMENT 'Total number of meals ordered for operating crew members (flight deck and cabin crew).',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the order cost amount.. Valid values are `^[A-Z]{3}$`',
    `departure_station_code` STRING COMMENT 'Three-letter IATA airport code for the departure station of the flight leg.. Valid values are `^[A-Z]{3}$`',
    `economy_class_meal_count` STRING COMMENT 'Total number of standard meals ordered for Economy Class cabin, excluding special meals.',
    `first_class_meal_count` STRING COMMENT 'Total number of standard meals ordered for First Class cabin, excluding special meals.',
    `galley_insert_count` STRING COMMENT 'Number of galley inserts (meal trays, containers) required for this catering order.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this catering order record was last updated. Audit trail field for tracking changes.',
    `meal_service_type` STRING COMMENT 'Classification of the catering service level provided on this flight, determining the scope and quality of food and beverage offerings.. Valid values are `full_service|snack|beverage_only|buy_on_board|premium_dining|light_refreshment`',
    `notes` STRING COMMENT 'Free-text field for additional instructions, special requests, or operational notes related to the catering order.',
    `order_number` STRING COMMENT 'Externally-known unique business identifier for the catering order, typically used in communications with catering suppliers and ground operations.. Valid values are `^CAT[0-9]{10}$`',
    `order_placement_timestamp` TIMESTAMP COMMENT 'Date and time when the catering order was placed with the supplier. Principal business event timestamp for this transaction.',
    `order_status` STRING COMMENT 'Current lifecycle status of the catering order, tracking progression from placement through delivery and uplift.. Valid values are `placed|confirmed|prepared|uplifted|short_delivered|cancelled`',
    `order_total_cost_amount` DECIMAL(18,2) COMMENT 'Total cost of the catering order in the contract currency, including all meals, beverages, equipment, and service charges.',
    `premium_economy_meal_count` STRING COMMENT 'Total number of standard meals ordered for Premium Economy cabin, excluding special meals.',
    `required_delivery_timestamp` TIMESTAMP COMMENT 'Date and time by which catering must be delivered to the aircraft for uplift, typically aligned with turnaround schedule.',
    `short_delivery_reason` STRING COMMENT 'Explanation for any shortfall in catering delivery, used for supplier performance tracking and operational analysis.',
    `special_meal_chml_count` STRING COMMENT 'Number of child special meals ordered, identified by IATA SSR code CHML.',
    `special_meal_dbml_count` STRING COMMENT 'Number of diabetic special meals ordered, identified by IATA SSR code DBML.',
    `special_meal_ksml_count` STRING COMMENT 'Number of kosher special meals ordered, identified by IATA SSR code KSML.',
    `special_meal_moml_count` STRING COMMENT 'Number of Muslim/Halal special meals ordered, identified by IATA SSR code MOML.',
    `special_meal_other_count` STRING COMMENT 'Number of other special meals ordered (AVML, GFML, LFML, NLML, etc.) not captured in specific categories.',
    `special_meal_vgml_count` STRING COMMENT 'Number of vegetarian special meals ordered, identified by IATA Special Service Request (SSR) code VGML.',
    `trolley_count` STRING COMMENT 'Number of service trolleys required for this catering order, used for in-flight meal and beverage service.',
    `variance_quantity` STRING COMMENT 'Difference between ordered meal count and actual delivered count. Positive indicates over-delivery, negative indicates short-delivery.',
    CONSTRAINT pk_catering_order PRIMARY KEY(`catering_order_id`)
) COMMENT 'Transactional record for catering orders placed with catering suppliers for specific flights. Captures catering order number, catering supplier (vendor reference), flight leg reference, departure station, catering uplift station, order placement date and time, meal service type (full service, snack, beverage only), cabin class breakdown (F/J/W/Y), total meal count by class, special meal count by type (VGML, KSML, MOML, DBML, CHML, etc.), beverage quantities, equipment (galley inserts, trolleys), order status (placed, confirmed, uplifted, short-delivered, cancelled), actual uplift quantity, variance quantity, catering supervisor sign-off, and contract reference. Supports catering cost control and service delivery compliance.';

CREATE OR REPLACE TABLE `airlines_ecm`.`procurement`.`vendor_performance` (
    `vendor_performance_id` BIGINT COMMENT 'Unique identifier for the vendor performance evaluation record.',
    `employee_id` BIGINT COMMENT 'Reference to the procurement buyer or category manager who conducted the performance evaluation.',
    `procurement_category_id` BIGINT COMMENT 'Foreign key linking to procurement.procurement_category. Business justification: Vendor performance evaluations have procurement_category (STRING) which should be normalized to procurement_category_id FK for category-specific vendor performance tracking and reporting. Remove procu',
    `vendor_id` BIGINT COMMENT 'Reference to the vendor being evaluated in this performance record.',
    `prior_vendor_performance_id` BIGINT COMMENT 'Self-referencing FK on vendor_performance (prior_vendor_performance_id)',
    `aog_response_time_hours` DECIMAL(18,2) COMMENT 'Average response time in hours for critical AOG parts requests during the evaluation period. Applicable to MRO parts suppliers.',
    `contract_renewal_eligible_flag` BOOLEAN COMMENT 'Indicates whether the vendor is eligible for contract renewal based on performance tier and evaluation results.',
    `corrective_action_plan_reference` STRING COMMENT 'Reference number or identifier for the corrective action plan document if corrective action is required.',
    `corrective_action_required_flag` BOOLEAN COMMENT 'Indicates whether corrective action is required from the vendor based on performance deficiencies.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this vendor performance evaluation record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the total order value amount.. Valid values are `^[A-Z]{3}$`',
    `evaluation_date` DATE COMMENT 'The date on which the performance evaluation was completed and recorded.',
    `evaluation_notes` STRING COMMENT 'Free-text notes and comments from the evaluating buyer regarding vendor performance, issues, or observations during the evaluation period.',
    `evaluation_period_end_date` DATE COMMENT 'The end date of the performance evaluation period.',
    `evaluation_period_start_date` DATE COMMENT 'The start date of the performance evaluation period (month, quarter, or custom period).',
    `evaluation_period_type` STRING COMMENT 'The type of evaluation period (monthly, quarterly, semi-annual, annual, or custom).. Valid values are `monthly|quarterly|semi-annual|annual|custom`',
    `invoice_accuracy_rate_percent` DECIMAL(18,2) COMMENT 'Percentage of invoices submitted without errors (pricing, quantity, or terms discrepancies) during the evaluation period.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this vendor performance evaluation record was last modified or updated.',
    `on_time_delivery_rate_percent` DECIMAL(18,2) COMMENT 'Percentage of orders delivered on or before the promised delivery date during the evaluation period.',
    `order_fill_rate_percent` DECIMAL(18,2) COMMENT 'Percentage of ordered quantity successfully fulfilled by the vendor during the evaluation period.',
    `overall_performance_score` DECIMAL(18,2) COMMENT 'Weighted composite performance score calculated from all measured KPIs, typically on a 0-100 scale.',
    `performance_tier` STRING COMMENT 'Categorical performance tier assigned based on overall performance score (excellent, satisfactory, needs improvement, critical).. Valid values are `excellent|satisfactory|needs_improvement|critical`',
    `price_compliance_rate_percent` DECIMAL(18,2) COMMENT 'Percentage of invoices that matched contracted pricing terms during the evaluation period.',
    `quality_rejection_rate_percent` DECIMAL(18,2) COMMENT 'Percentage of delivered items rejected due to quality defects or non-conformance during the evaluation period.',
    `sla_target_aog_response_hours` DECIMAL(18,2) COMMENT 'Contracted SLA target (maximum acceptable) for AOG response time in hours for critical parts suppliers.',
    `sla_target_on_time_delivery_percent` DECIMAL(18,2) COMMENT 'Contracted SLA target for on-time delivery rate percentage that the vendor is expected to meet.',
    `sla_target_quality_rejection_percent` DECIMAL(18,2) COMMENT 'Contracted SLA target (maximum acceptable) for quality rejection rate percentage.',
    `total_order_value_amount` DECIMAL(18,2) COMMENT 'Total monetary value of all purchase orders included in this evaluation period.',
    `total_orders_evaluated` STRING COMMENT 'Total number of purchase orders included in this performance evaluation period.',
    `trend_versus_prior_period` STRING COMMENT 'Performance trend indicator comparing this evaluation period to the previous period (improving, stable, declining, or first evaluation).. Valid values are `improving|stable|declining|first_evaluation`',
    `vendor_development_program_flag` BOOLEAN COMMENT 'Indicates whether the vendor has been enrolled in a vendor development program to improve performance.',
    CONSTRAINT pk_vendor_performance PRIMARY KEY(`vendor_performance_id`)
) COMMENT 'Periodic vendor performance evaluation record capturing measured KPIs against contracted SLAs for each vendor relationship. Captures evaluation period (month/quarter), vendor reference, procurement category, on-time delivery rate (%), quality rejection rate (%), invoice accuracy rate (%), order fill rate (%), AOG response time (hours) for critical parts suppliers, price compliance rate (%), overall performance score, performance tier (excellent, satisfactory, needs improvement, critical), corrective action required flag, corrective action plan reference, evaluating buyer, evaluation date, and trend versus prior period. Drives strategic sourcing decisions, contract renewals, and vendor development programs.';

CREATE OR REPLACE TABLE `airlines_ecm`.`procurement`.`procurement_category` (
    `procurement_category_id` BIGINT COMMENT 'Unique identifier for the procurement category. Primary key.',
    `parent_procurement_category_id` BIGINT COMMENT 'Self-referencing FK on procurement_category (parent_procurement_category_id)',
    `active_flag` BOOLEAN COMMENT 'Indicates whether the category is currently active and available for use in procurement transactions. False for retired or obsolete categories.',
    `annual_spend_estimate` DECIMAL(18,2) COMMENT 'Estimated total annual spend (in base currency) for this category. Used for category prioritization and strategic sourcing planning.',
    `approval_authority_level` STRING COMMENT 'Minimum organizational level required to approve purchases in this category based on spend thresholds and strategic importance.. Valid values are `buyer|manager|director|vp|cfo`',
    `category_code` STRING COMMENT 'Short alphanumeric code uniquely identifying the procurement category within the taxonomy. Used as business key for reporting and integration.. Valid values are `^[A-Z0-9]{2,12}$`',
    `category_description` STRING COMMENT 'Detailed description of the category scope, including typical items, services, and materials classified under this category.',
    `category_level` STRING COMMENT 'Hierarchical level of the category: 1=Family (top level), 2=Class (mid level), 3=Commodity (leaf level). Supports drill-down analytics.',
    `category_name` STRING COMMENT 'Full descriptive name of the procurement category (e.g., Aircraft Spare Parts, Jet Fuel, Catering Services).',
    `compliance_requirements` STRING COMMENT 'Summary of regulatory, safety, or quality compliance requirements applicable to this category (e.g., EASA Part 145 for MRO parts, FAA certification for avionics, ISO 9001 for catering).',
    `contract_renewal_cycle_months` STRING COMMENT 'Typical contract renewal cycle in months for this category. Used for proactive sourcing planning and contract lifecycle management.',
    `cost_center_default` STRING COMMENT 'Default cost center code for financial postings related to this category. Can be overridden at transaction level.. Valid values are `^[0-9]{4,10}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this category record was first created in the system.',
    `effective_date` DATE COMMENT 'Date from which this category definition became active and available for use in procurement transactions.',
    `expiry_date` DATE COMMENT 'Date on which this category definition expires or is retired. Null for categories with indefinite validity.',
    `gl_account_default` STRING COMMENT 'Default general ledger account code for expenses in this category. Supports automated financial posting and spend analytics.. Valid values are `^[0-9]{6,10}$`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this category record was last updated. Used for change tracking and audit trail.',
    `last_review_date` DATE COMMENT 'Date of the most recent strategic review or spend analysis for this category. Used to track category management governance.',
    `lead_time_days` STRING COMMENT 'Average procurement lead time in days from requisition to delivery for items in this category. Used for inventory planning and demand forecasting.',
    `minimum_order_value` DECIMAL(18,2) COMMENT 'Minimum order value (in base currency) required for purchases in this category. Used to enforce procurement efficiency and reduce transaction costs.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next strategic category review. Supports proactive category management and continuous improvement.',
    `preferred_vendor_count` STRING COMMENT 'Target number of preferred or approved vendors for this category. Supports supplier rationalization and risk management.',
    `risk_rating` STRING COMMENT 'Overall supply risk rating for the category based on supplier concentration, geopolitical factors, market volatility, and criticality to operations.. Valid values are `low|medium|high|critical`',
    `sourcing_strategy` STRING COMMENT 'Preferred sourcing approach for this category: single_source (one supplier), dual_source (two suppliers for redundancy), competitive_tender (RFx process), catalogue (pre-negotiated catalog), framework_agreement (call-off contract), spot_buy (ad-hoc purchase).. Valid values are `single_source|dual_source|competitive_tender|catalogue|framework_agreement|spot_buy`',
    `strategic_importance` STRING COMMENT 'Kraljic matrix classification indicating the strategic importance and supply risk of the category: strategic (high impact, high risk), leverage (high impact, low risk), bottleneck (low impact, high risk), non-critical (low impact, low risk).. Valid values are `strategic|leverage|bottleneck|non-critical`',
    `sustainability_flag` BOOLEAN COMMENT 'Indicates whether this category has specific sustainability or environmental sourcing requirements (e.g., sustainable aviation fuel, carbon offset programs, eco-friendly catering supplies).',
    `tax_category_code` STRING COMMENT 'Tax classification code for items in this category (e.g., standard VAT, reduced rate, exempt). Used for automated tax calculation.. Valid values are `^[A-Z0-9]{1,6}$`',
    `unspsc_code` STRING COMMENT 'Eight-digit UNSPSC classification code aligning the category to global commodity taxonomy for cross-industry benchmarking and reporting.. Valid values are `^[0-9]{8}$`',
    CONSTRAINT pk_procurement_category PRIMARY KEY(`procurement_category_id`)
) COMMENT 'Reference master defining the airlines procurement category taxonomy used to classify all spend, contracts, and sourcing activities. Captures category code, category name, parent category code (for hierarchy), category level (1=family, 2=class, 3=commodity), UNSPSC code, category description, category owner (lead buyer), annual spend estimate, strategic importance (strategic, leverage, bottleneck, non-critical — Kraljic matrix quadrant), sourcing strategy (single source, dual source, competitive tender, catalogue), preferred vendor count, and active flag. Enables spend analytics, category management, and strategic sourcing planning across MRO, fuel, catering, ground services, and general procurement.';

CREATE OR REPLACE TABLE `airlines_ecm`.`procurement`.`approved_vendor_list` (
    `approved_vendor_list_id` BIGINT COMMENT 'Unique identifier for the approved vendor list entry. Primary key for the AVL record.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: AVL entries require formal approval by engineering, quality, or procurement managers per EASA/FAA regulations. Tracks who authorized vendor for specific part numbers. Essential for audit trails, regul',
    `procurement_category_id` BIGINT COMMENT 'Foreign key linking to procurement.procurement_category. Business justification: Approved vendor list entries should link to procurement_category for proper category classification. Currently uses procurement_category_code (STRING) which is denormalized. Adding procurement_categor',
    `vendor_id` BIGINT COMMENT 'Reference to the vendor approved to supply parts, materials, or services. Links to the vendor master record.',
    `superseded_approved_vendor_list_id` BIGINT COMMENT 'Self-referencing FK on approved_vendor_list (superseded_approved_vendor_list_id)',
    `approval_date` DATE COMMENT 'The date on which the vendor was approved for this part or procurement category. Represents the effective start of the approval.',
    `approval_expiry_date` DATE COMMENT 'The date on which the vendor approval expires and must be renewed. Null indicates indefinite approval subject to periodic review.',
    `approval_status` STRING COMMENT 'Current approval status of the vendor for this part or category. Approved = fully authorized; Conditional = approved with restrictions; Suspended = temporarily not authorized; Delisted = permanently removed; Pending Review = under evaluation; Expired = approval period lapsed.. Valid values are `approved|conditional|suspended|delisted|pending_review|expired`',
    `audit_date` DATE COMMENT 'The date of the most recent quality audit conducted on the vendor. Null if no audit has been conducted.',
    `audit_score` DECIMAL(18,2) COMMENT 'The most recent quality audit score for the vendor, typically expressed as a percentage (0-100). Used to track vendor quality performance and compliance. Null if no audit has been conducted.',
    `conditional_approval_restrictions` STRING COMMENT 'Detailed description of any restrictions or conditions attached to the approval. Applicable when approval_status is conditional. May include quantity limits, usage restrictions, or additional oversight requirements.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when the approved vendor list entry was first created in the system. Audit trail field.',
    `delisting_date` DATE COMMENT 'The date on which the vendor was permanently delisted from the approved vendor list. Null if never delisted.',
    `delisting_reason` STRING COMMENT 'The reason for permanently removing the vendor from the approved vendor list. Applicable when approval_status is delisted. May include severe quality failures, fraud, bankruptcy, or regulatory sanctions.',
    `easa_part145_approved_flag` BOOLEAN COMMENT 'Indicates whether the vendor holds EASA Part-145 approval for maintenance organization. True = EASA Part-145 approved; False = not approved. Required for MRO parts suppliers in EASA jurisdictions.',
    `faa_repair_station_certificate_number` STRING COMMENT 'The FAA-issued repair station certificate number for the vendor. Unique identifier for the repair station certification.. Valid values are `^[A-Z0-9]{3,15}$`',
    `faa_repair_station_flag` BOOLEAN COMMENT 'Indicates whether the vendor holds FAA repair station certification. True = FAA certified repair station; False = not certified. Required for certain MRO parts suppliers in FAA jurisdictions.',
    `geographic_restriction` STRING COMMENT 'Specific geographic restrictions or limitations on the approval. May list countries, regions, or station codes where the vendor is approved or restricted. Null if no restrictions apply.',
    `geographic_scope` STRING COMMENT 'The geographic scope of the vendor approval. Global = approved for all airline operations worldwide; Regional = approved for specific regions (e.g., EMEA, APAC); Station Specific = approved only for specific airport stations; Country Specific = approved for operations in specific countries.. Valid values are `global|regional|station_specific|country_specific`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when the approved vendor list entry was last updated or modified. Audit trail field for tracking changes.',
    `last_review_date` DATE COMMENT 'The date of the most recent periodic review or re-evaluation of the vendors approved status. Used to track compliance with periodic review requirements.',
    `lead_time_days` STRING COMMENT 'The standard procurement lead time in days from order placement to delivery for this vendor and part combination. Used for materials planning and inventory management.',
    `minimum_order_quantity` DECIMAL(18,2) COMMENT 'The minimum order quantity required by the vendor for this part or category. Expressed in the parts unit of measure. Null if no minimum applies.',
    `next_review_date` DATE COMMENT 'The scheduled date for the next periodic review or re-evaluation of the vendors approved status. Ensures timely compliance with review cycles.',
    `oem_authorization_flag` BOOLEAN COMMENT 'Indicates whether the vendor is authorized by the original equipment manufacturer to supply the part or material. True = OEM authorized; False = not OEM authorized. Critical for airworthiness compliance.',
    `oem_authorization_reference` STRING COMMENT 'The reference number, certificate ID, or documentation reference for the OEM authorization. May include distributor agreement numbers or OEM approval letters.',
    `part_number` STRING COMMENT 'The specific part number or material code that the vendor is approved to supply. May be an OEM part number, airline internal part number, or industry standard part number.. Valid values are `^[A-Z0-9-]{6,25}$`',
    `preferred_vendor_flag` BOOLEAN COMMENT 'Indicates whether the vendor is designated as a preferred or strategic supplier for this part or category. True = preferred vendor; False = standard approved vendor. Preferred vendors may receive priority in sourcing decisions.',
    `qualification_basis` STRING COMMENT 'The primary basis or reason for approving the vendor. Audit Passed = vendor passed quality audit; OEM Authorization = authorized by original equipment manufacturer; Regulatory Approval = holds required regulatory certifications; Historical Performance = proven track record; Quality Certification = holds ISO/AS certifications; Technical Evaluation = passed technical capability assessment.. Valid values are `audit_passed|oem_authorization|regulatory_approval|historical_performance|quality_certification|technical_evaluation`',
    `quality_certification_reference` STRING COMMENT 'The certification number, certificate ID, or reference to the vendors quality system certification (e.g., ISO 9001:2015 certificate number, AS9100 registration number).',
    `quality_system_certification_required_flag` BOOLEAN COMMENT 'Indicates whether the vendor is required to maintain a quality management system certification (e.g., ISO 9001, AS9100) as a condition of approval. True = certification required; False = not required.',
    `remarks` STRING COMMENT 'Free-text field for additional notes, comments, or special instructions related to the vendor approval. May include procurement guidance, quality notes, or historical context.',
    `sole_source_flag` BOOLEAN COMMENT 'Indicates whether the vendor is the sole approved source for this part or category. True = sole source (no alternatives); False = multiple sources available. Critical for supply chain risk management.',
    `suspension_date` DATE COMMENT 'The date on which the vendors approval was suspended. Null if never suspended or currently not suspended.',
    `suspension_reason` STRING COMMENT 'The reason for suspending the vendors approval. Applicable when approval_status is suspended. May include quality issues, delivery failures, regulatory non-compliance, or pending investigation.',
    CONSTRAINT pk_approved_vendor_list PRIMARY KEY(`approved_vendor_list_id`)
) COMMENT 'Association master record defining the approved vendor list (AVL) — the authoritative list of vendors approved to supply specific parts, materials, or services within defined procurement categories. Captures AVL entry ID, vendor reference, part number or procurement category, approval status (approved, conditional, suspended, delisted), approval date, approval expiry date, approval authority, qualification basis (audit passed, OEM authorization, regulatory approval, historical performance), quality system certification required flag, certification reference, geographic scope (global, regional, station-specific), and last review date. Critical for MRO parts procurement compliance with EASA Part-145 and FAA AC 00-56 supplier approval requirements.';

CREATE OR REPLACE TABLE `airlines_ecm`.`procurement`.`spend_record` (
    `spend_record_id` BIGINT COMMENT 'Unique identifier for the procurement spend record. Primary key for the spend_record product.',
    `employee_id` BIGINT COMMENT 'The employee ID of the person who approved the procurement spend. Used for compliance monitoring and delegation of authority validation.',
    `primary_spend_requisitioner_employee_id` BIGINT COMMENT 'The employee ID of the person who initiated the procurement requisition. Used for spend authorization audit trails and accountability.',
    `procurement_category_id` BIGINT COMMENT 'Foreign key linking to procurement.procurement_category. Business justification: Spend records have procurement_category (STRING) which should be normalized to procurement_category_id FK for proper spend classification, category analytics, and reporting. Remove procurement_categor',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to procurement.purchase_order. Business justification: Spend records reference purchase orders for spend classification and tracking. Currently uses po_number (STRING) which is a denormalized business reference. Adding purchase_order_id FK normalizes this',
    `supply_contract_id` BIGINT COMMENT 'Foreign key linking to procurement.supply_contract. Business justification: Spend records reference supply contracts for contract spend tracking and compliance monitoring. Currently uses contract_reference (STRING) which is a denormalized business reference. Adding supply_con',
    `vendor_id` BIGINT COMMENT 'Reference to the vendor or supplier associated with this spend record, enabling supplier spend concentration analysis.',
    `vendor_invoice_id` BIGINT COMMENT 'Foreign key linking to procurement.vendor_invoice. Business justification: Spend records reference vendor invoices for spend classification and payment tracking. Currently uses invoice_number (STRING) which is a denormalized business reference. Adding vendor_invoice_id FK no',
    `reversal_spend_record_id` BIGINT COMMENT 'Self-referencing FK on spend_record (reversal_spend_record_id)',
    `aircraft_registration` STRING COMMENT 'The aircraft tail number or registration associated with this spend record, if the spend is aircraft-specific (e.g., MRO parts, fuel uplift). Enables aircraft-level cost tracking.',
    `business_unit` STRING COMMENT 'The business unit or division within the airline that incurred this spend (e.g., Flight Operations, Maintenance, Catering, Ground Services). Enables business unit spend analysis and chargeback.',
    `cost_centre_code` STRING COMMENT 'The organizational cost centre code to which this spend is allocated, enabling departmental spend tracking and budget accountability.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this spend record was first created in the procurement system. Used for audit trail and data lineage tracking.',
    `currency_code` STRING COMMENT 'The three-letter ISO 4217 currency code in which the spend amount is denominated (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `discount_amount` DECIMAL(18,2) COMMENT 'The total discount amount applied to this spend record, including early payment discounts, volume discounts, or negotiated rebates. Used for savings tracking and supplier performance evaluation.',
    `exchange_rate` DECIMAL(18,2) COMMENT 'The foreign exchange rate applied to convert the transaction currency to the local reporting currency at the time of the transaction.',
    `fiscal_period` STRING COMMENT 'The fiscal period (month or quarter) within the fiscal year when the spend was recorded, enabling period-over-period analysis.',
    `fiscal_year` STRING COMMENT 'The fiscal year in which the spend was recorded, used for annual financial reporting and budget tracking.',
    `gl_account_code` STRING COMMENT 'The general ledger account code under which this spend is recorded in the financial accounting system, linking procurement spend to financial statements.',
    `goods_receipt_date` DATE COMMENT 'The date on which the goods or services were received and accepted by the airline. Critical for three-way match validation (PO, goods receipt, invoice).',
    `invoice_date` DATE COMMENT 'The date on which the vendor invoice was issued. Used for invoice aging analysis and payment terms calculation.',
    `invoice_number` STRING COMMENT 'The vendor invoice number associated with this spend record, linking the spend to the actual invoice document for audit and reconciliation purposes.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this spend record was last updated or modified. Used for change tracking and audit compliance.',
    `local_currency_amount` DECIMAL(18,2) COMMENT 'The spend amount converted to the airlines reporting currency (typically USD) for consolidated financial reporting and cross-border spend analysis.',
    `maverick_spend_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this spend was executed outside of approved procurement channels or contracts (maverick spend). True indicates non-compliant procurement requiring corrective action.',
    `net_spend_amount` DECIMAL(18,2) COMMENT 'The net spend amount after applying discounts and before tax. Represents the actual cost to the airline for procurement analytics.',
    `payment_date` DATE COMMENT 'The date on which the payment was made to the vendor for this spend record. Used for cash flow analysis and payment terms compliance tracking.',
    `payment_status` STRING COMMENT 'The current payment status of the spend record (e.g., Pending, Approved, Paid, Overdue, Disputed, Cancelled). Used for cash flow management and accounts payable tracking.. Valid values are `Pending|Approved|Paid|Overdue|Disputed|Cancelled`',
    `po_number` STRING COMMENT 'The purchase order number associated with this spend record, if the spend is PO-backed. Enables traceability to the original procurement authorization.',
    `savings_amount` DECIMAL(18,2) COMMENT 'The calculated savings amount achieved through strategic sourcing, contract negotiation, or competitive bidding compared to baseline or market rates. Used for procurement performance measurement.',
    `sourcing_channel` STRING COMMENT 'The sourcing channel through which the procurement was executed (e.g., Contracted, Spot, Catalogue, P-Card, Emergency). Enables analysis of procurement compliance and strategic sourcing effectiveness.. Valid values are `Contracted|Spot|Catalogue|P-Card|Emergency`',
    `spend_amount` DECIMAL(18,2) COMMENT 'The monetary value of the spend in the transaction currency. Represents the actual committed or invoiced amount for this procurement transaction.',
    `spend_date` DATE COMMENT 'The date on which the spend was incurred or committed. This is the primary business event timestamp for spend recognition and period allocation.',
    `spend_type` STRING COMMENT 'Classification of the spend based on the procurement method used (e.g., PO-backed, Non-PO, Contract-backed, P-Card, Spot). Critical for compliance monitoring and maverick spend identification.. Valid values are `PO-backed|Non-PO|Contract-backed|P-Card|Spot`',
    `station_code` STRING COMMENT 'The three-letter IATA airport code of the station where the spend was incurred, if applicable. Enables location-based spend analysis for ground operations and station services.. Valid values are `^[A-Z]{3}$`',
    `tax_amount` DECIMAL(18,2) COMMENT 'The total tax amount (VAT, GST, sales tax) included in the spend amount. Used for tax reporting and reclaim analysis.',
    CONSTRAINT pk_spend_record PRIMARY KEY(`spend_record_id`)
) COMMENT 'Consolidated procurement spend record capturing actual committed and invoiced spend by vendor, category, cost centre, and period. Captures spend record ID, fiscal year, fiscal period, vendor reference, procurement category, cost centre, GL account, PO reference, invoice reference, spend type (PO-backed, non-PO, contract-backed), spend amount, currency, local currency equivalent, payment status, and sourcing channel (contracted, spot, catalogue, p-card). Provides the procurement-layer spend visibility record distinct from finance.general_ledger accounting entries — focused on category management, savings tracking, and supplier spend concentration analysis.';

CREATE OR REPLACE TABLE `airlines_ecm`.`procurement`.`ground_service_order` (
    `ground_service_order_id` BIGINT COMMENT 'Unique identifier for the ground service order. Primary key for this procurement-layer commercial service order record.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Ground service orders (ramp, cleaning, deicing) require station manager or ground ops supervisor approval before vendor execution. Essential for cost control, SLA enforcement, and dispute resolution. ',
    `supply_contract_id` BIGINT COMMENT 'Foreign key linking to procurement.supply_contract. Business justification: Ground service orders are placed against supply contracts with ground handling vendors. Currently uses contract_reference (STRING) which is a denormalized business reference. Adding supply_contract_id',
    `vendor_id` BIGINT COMMENT 'Reference to the contracted ground service provider (GSP) fulfilling this service order.',
    `amended_ground_service_order_id` BIGINT COMMENT 'Self-referencing FK on ground_service_order (amended_ground_service_order_id)',
    `actual_service_end_time` TIMESTAMP COMMENT 'Actual timestamp when the ground service provider completed or terminated service delivery.',
    `actual_service_start_time` TIMESTAMP COMMENT 'Actual timestamp when the ground service provider commenced service delivery on the aircraft or at the gate.',
    `aircraft_registration` STRING COMMENT 'Tail number or registration mark of the aircraft receiving ground services for this turnaround.. Valid values are `^[A-Z0-9-]{5,8}$`',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when this ground service order was approved for placement with the vendor.',
    `cancellation_reason` STRING COMMENT 'Textual explanation of why this ground service order was cancelled, if applicable (e.g., flight cancellation, vendor unavailability, operational change).',
    `cancelled_timestamp` TIMESTAMP COMMENT 'Date and time when this ground service order was cancelled.',
    `contracted_service_level` STRING COMMENT 'Service level agreement tier contracted for this order, defining performance standards and response times.. Valid values are `standard|premium|express|basic`',
    `cost_center` STRING COMMENT 'Financial cost center code to which this ground service order expense is allocated for accounting purposes.. Valid values are `^[A-Z0-9]{4,10}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this ground service order record was first created in the procurement system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this order.. Valid values are `^[A-Z]{3}$`',
    `dispute_flag` BOOLEAN COMMENT 'Indicates whether this service order is under dispute due to service quality issues, billing discrepancies, or contract disagreements.',
    `dispute_reason` STRING COMMENT 'Textual explanation of the reason for dispute if the dispute flag is set, including details of service failures or billing errors.',
    `flight_leg_reference` STRING COMMENT 'Reference to the specific flight leg (flight number and date) for which ground services are ordered. Format: carrier code + flight number + dash + date (YYYYMMDD).. Valid values are `^[A-Z0-9]{2}[0-9]{1,4}-[0-9]{8}$`',
    `gl_account_code` STRING COMMENT 'General ledger account code for posting this ground service order expense in the financial system.. Valid values are `^[0-9]{4,8}$`',
    `invoice_reference` STRING COMMENT 'Reference to the vendor invoice document associated with this ground service order for payment reconciliation.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this ground service order record was last updated in the procurement system.',
    `order_placed_timestamp` TIMESTAMP COMMENT 'Date and time when this ground service order was placed with the vendor.',
    `order_status` STRING COMMENT 'Current lifecycle status of the ground service order in the procurement workflow. [ENUM-REF-CANDIDATE: draft|confirmed|dispatched|in_progress|completed|partial|failed|cancelled — 8 candidates stripped; promote to reference product]',
    `order_value_amount` DECIMAL(18,2) COMMENT 'Total contracted value of this ground service order before adjustments, taxes, or penalties.',
    `payment_status` STRING COMMENT 'Current status of payment processing for this ground service order.. Valid values are `pending|approved|paid|disputed|cancelled`',
    `penalty_amount` DECIMAL(18,2) COMMENT 'Monetary penalty amount assessed against the vendor for this service order due to SLA breaches or quality failures.',
    `penalty_trigger_flag` BOOLEAN COMMENT 'Indicates whether this service order triggered contractual penalty clauses due to non-performance, delays, or quality failures.',
    `scheduled_service_start_time` TIMESTAMP COMMENT 'Contracted or planned start time for ground service delivery, typically aligned with aircraft arrival or turnaround schedule.',
    `service_completion_status` STRING COMMENT 'Operational completion status indicating whether the ground service provider successfully delivered the ordered services.. Valid values are `completed|partial|failed|cancelled|not_started`',
    `service_duration_minutes` STRING COMMENT 'Total elapsed time in minutes from actual service start to actual service end.',
    `service_order_number` STRING COMMENT 'Externally-known unique business identifier for this ground service order, used in vendor communications and invoicing.. Valid values are `^GSO-[A-Z0-9]{8,12}$`',
    `service_quality_score` DECIMAL(18,2) COMMENT 'Quantitative quality rating (0.00 to 100.00) assigned to the vendors service delivery performance for this order, based on timeliness, completeness, and adherence to standards.',
    `service_scope_description` STRING COMMENT 'Detailed textual description of the specific services included in this order, including any special requirements or non-standard tasks.',
    `service_type` STRING COMMENT 'Category of ground handling service ordered: ramp handling, passenger handling, baggage handling, aircraft cleaning, lavatory service, water service, GPU (Ground Power Unit) provision, or pushback. [ENUM-REF-CANDIDATE: ramp_handling|passenger_handling|baggage_handling|aircraft_cleaning|lavatory_service|water_service|gpu_provision|pushback — 8 candidates stripped; promote to reference product]',
    `sla_compliance_flag` BOOLEAN COMMENT 'Indicates whether the vendor met the contracted service level agreement performance standards for this order.',
    `special_instructions` STRING COMMENT 'Free-text field for any special handling instructions, non-standard requirements, or operational notes communicated to the ground service provider.',
    `station_code` STRING COMMENT 'Three-letter IATA airport code identifying the station where ground services are to be performed.. Valid values are `^[A-Z]{3}$`',
    `turnaround_reference` STRING COMMENT 'Reference to the operational aircraft turnaround event that this procurement service order supports.',
    CONSTRAINT pk_ground_service_order PRIMARY KEY(`ground_service_order_id`)
) COMMENT 'Transactional record for ground handling and airport service orders placed with contracted ground service providers (GSPs) for specific aircraft turnarounds or station operations. Captures service order number, ground handler (vendor reference), station (airport IATA code), flight leg reference, aircraft registration, service type (ramp handling, passenger handling, baggage handling, aircraft cleaning, lavatory service, water service, GPU provision, pushback), contracted service level, ordered service start time, actual service start time, actual service end time, service completion status (completed, partial, failed, cancelled), service quality score, penalty trigger flag, and contract reference. Distinct from airport.ramp_service_order which is the operational dispatch record — this is the procurement-layer commercial service order.';

CREATE OR REPLACE TABLE `airlines_ecm`.`procurement`.`vendor_audit` (
    `vendor_audit_id` BIGINT COMMENT 'Unique identifier for the vendor audit record. Primary key.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Vendor audits (EASA Part-145, FAA repair station compliance) require internal audit lead assignment. Quality assurance or procurement employees lead audits. Tracks accountability for audit findings, c',
    `vendor_id` BIGINT COMMENT 'Reference to the vendor being audited. Links to the vendor master record in the procurement domain.',
    `follow_up_vendor_audit_id` BIGINT COMMENT 'Self-referencing FK on vendor_audit (follow_up_vendor_audit_id)',
    `approval_authority` STRING COMMENT 'Name or title of the individual or committee with authority to approve the audit results and make vendor qualification decisions based on the audit outcome. Examples: Director of Procurement, Quality Assurance Manager, Vendor Qualification Board.',
    `approved_by` STRING COMMENT 'Name of the individual who formally approved the audit report and vendor qualification decision. Nullable if audit is not yet approved.',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when the audit report was formally approved. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX. Nullable if audit is not yet approved.',
    `audit_cost_amount` DECIMAL(18,2) COMMENT 'Total cost incurred for conducting the audit, including auditor fees, travel expenses, and third-party certification body charges. Used for procurement budget tracking and vendor management cost analysis.',
    `audit_cost_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the audit cost amount. Examples: USD, EUR, GBP.. Valid values are `^[A-Z]{3}$`',
    `audit_date` DATE COMMENT 'The principal date on which the audit was conducted or commenced. For multi-day audits, this represents the start date. Format: yyyy-MM-dd.',
    `audit_duration_days` DECIMAL(18,2) COMMENT 'Total duration of the audit in days, including fieldwork and on-site activities. Calculated as the difference between audit_end_date and audit_date plus one, or manually entered for complex audits. Supports fractional days for half-day audits.',
    `audit_end_date` DATE COMMENT 'The date on which the audit fieldwork was completed. Nullable for single-day audits. Format: yyyy-MM-dd.',
    `audit_lead_organization` STRING COMMENT 'Name of the organization employing the audit lead. May be the airlines internal audit department, a third-party certification body, or a regulatory authority.',
    `audit_location` STRING COMMENT 'Physical location where the audit was conducted. May include vendor facility address, city, country, or Remote for virtual audits conducted via video conference and document review.',
    `audit_method` STRING COMMENT 'Method by which the audit was conducted: on-site (physical presence at vendor facility), remote (virtual audit via video and document review), or hybrid (combination of on-site and remote activities).. Valid values are `on_site|remote|hybrid`',
    `audit_reference_number` STRING COMMENT 'Externally-known unique audit reference number assigned by the auditing organization or system. Used for tracking and reporting purposes.. Valid values are `^[A-Z0-9-]{6,20}$`',
    `audit_report_document_reference` STRING COMMENT 'Reference identifier or file path to the formal audit report document stored in the document management system. Enables retrieval of the full audit report with detailed findings, evidence, and recommendations.',
    `audit_scope` STRING COMMENT 'Detailed description of the audit scope covering areas such as quality system, safety management, financial stability, regulatory compliance, ISAGO (IATA Safety Audit for Ground Operations), AS9100 (aerospace quality management), environmental management, or specific operational processes. Free-text field capturing the full scope statement.',
    `audit_status` STRING COMMENT 'Current lifecycle status of the audit: scheduled (audit planned but not yet started), in_progress (audit fieldwork underway), completed (audit finished and report issued), cancelled (audit cancelled before completion), or report_pending (fieldwork complete, report being finalized).. Valid values are `scheduled|in_progress|completed|cancelled|report_pending`',
    `audit_type` STRING COMMENT 'Classification of the audit based on its purpose: initial qualification (first-time vendor approval), periodic surveillance (scheduled recurring audit), for-cause (triggered by incident or complaint), re-qualification (renewal after suspension or expiry), special audit (focused scope), or desktop review (document-only assessment).. Valid values are `initial_qualification|periodic_surveillance|for_cause|re_qualification|special_audit|desktop_review`',
    `auditor_team_size` STRING COMMENT 'Number of auditors in the audit team, including the lead auditor and any supporting auditors or technical experts. Used for resource planning and audit cost allocation.',
    `certification_standard` STRING COMMENT 'The specific certification standard or framework against which the vendor was audited. Examples: ISO 9001:2015, AS9100D, EASA Part-145, FAA Part 145, IATA ISAGO, ISO 14001 (environmental), OHSAS 18001 (occupational health and safety).',
    `corrective_action_deadline` DATE COMMENT 'The date by which the vendor must submit and implement corrective actions to address audit findings. Nullable if no corrective actions are required. Format: yyyy-MM-dd.',
    `corrective_action_required_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the vendor is required to submit a corrective action plan to address findings identified during the audit. True if corrective actions are required, False otherwise.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the vendor audit record was first created in the system. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX. Used for audit trail and data lineage.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when the vendor audit record was last updated. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX. Used for audit trail and change tracking.',
    `major_findings_count` STRING COMMENT 'Number of major non-conformities identified during the audit. Major findings represent significant deviations from requirements that could impact safety, quality, or regulatory compliance and typically require immediate corrective action.',
    `minor_findings_count` STRING COMMENT 'Number of minor non-conformities identified during the audit. Minor findings represent isolated or less significant deviations that do not pose immediate risk but require corrective action within a defined timeframe.',
    `next_audit_due_date` DATE COMMENT 'Scheduled date for the next periodic surveillance audit based on the audit frequency defined in the vendor qualification program. Typically set at 12, 24, or 36 months from the current audit date depending on vendor risk tier and regulatory requirements. Format: yyyy-MM-dd.',
    `observations_count` STRING COMMENT 'Number of observations or opportunities for improvement noted during the audit. Observations are not non-conformities but represent areas where the vendor could enhance processes or practices.',
    `overall_audit_result` STRING COMMENT 'Final outcome of the audit: pass (vendor meets all requirements), conditional pass (vendor approved subject to corrective actions within specified timeframe), fail (vendor does not meet requirements and is not approved), or pending (audit report under review, final decision not yet issued).. Valid values are `pass|conditional_pass|fail|pending`',
    `re_audit_date` DATE COMMENT 'Scheduled or actual date of the follow-up re-audit to verify corrective action effectiveness. Nullable if no re-audit is required or not yet scheduled. Format: yyyy-MM-dd.',
    `re_audit_required_flag` BOOLEAN COMMENT 'Boolean flag indicating whether a follow-up re-audit is required to verify closure of findings and effectiveness of corrective actions. True if re-audit is required, False otherwise.',
    `regulatory_authority` STRING COMMENT 'Name of the regulatory authority under whose standards the audit was conducted. Examples: EASA (European Union Aviation Safety Agency), FAA (Federal Aviation Administration), IATA (International Air Transport Association), or national civil aviation authorities.',
    `remarks` STRING COMMENT 'Free-text field for additional comments, notes, or context related to the audit. May include special circumstances, audit challenges, vendor cooperation level, or follow-up actions beyond standard corrective action plans.',
    CONSTRAINT pk_vendor_audit PRIMARY KEY(`vendor_audit_id`)
) COMMENT 'Vendor qualification audit and assessment record capturing formal on-site or remote audits conducted against approved vendors and prospective suppliers. Captures audit reference number, vendor reference, audit type (initial qualification, periodic surveillance, for-cause, re-qualification), audit scope (quality system, safety, financial, regulatory compliance, ISAGO, AS9100), audit date, audit lead (internal auditor or third-party), audit location, overall audit result (pass, conditional pass, fail), number of major findings, number of minor findings, number of observations, corrective action required flag, corrective action deadline, re-audit required flag, re-audit date, and audit report document reference. Supports EASA Part-145 and FAA supplier approval compliance.';

CREATE OR REPLACE TABLE `airlines_ecm`.`procurement`.`contract_price_schedule` (
    `contract_price_schedule_id` BIGINT COMMENT 'Unique identifier for the contract price schedule record. Primary key.',
    `employee_id` BIGINT COMMENT 'Reference to the employee who approved this price schedule line for use in procurement operations.',
    `part_master_id` BIGINT COMMENT 'Foreign key linking to procurement.part_master. Business justification: Contract price schedules reference materials/parts that should link to part_master for normalization. Currently uses material_number and manufacturer_part_number (STRING) which are denormalized. Addin',
    `superseded_by_schedule_contract_price_schedule_id` BIGINT COMMENT 'Reference to the newer contract price schedule record that replaces this one, enabling price history tracking and audit trails.',
    `supply_contract_id` BIGINT COMMENT 'Reference to the parent supply contract to which this price schedule is attached.',
    `superseded_contract_price_schedule_id` BIGINT COMMENT 'Self-referencing FK on contract_price_schedule (superseded_contract_price_schedule_id)',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when this price schedule line was approved and became available for use in purchase orders.',
    `base_unit_price` DECIMAL(18,2) COMMENT 'The agreed unit price for the material or service at the base volume tier, before any volume discounts, escalations, or adjustments are applied.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this contract price schedule record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the price schedule (e.g., USD, EUR, GBP). All prices in this schedule line are denominated in this currency.. Valid values are `^[A-Z]{3}$`',
    `discount_percentage` DECIMAL(18,2) COMMENT 'Additional discount percentage applied to the unit price, typically for early payment, volume commitments, or promotional periods. Expressed as a percentage (e.g., 5.00 for 5%).',
    `escalation_cap_percentage` DECIMAL(18,2) COMMENT 'Maximum percentage by which the price can increase in a single escalation period, protecting the buyer from excessive price volatility. Expressed as a percentage (e.g., 10.00 for 10% cap).',
    `escalation_frequency` STRING COMMENT 'The frequency at which price escalation adjustments are applied based on the selected index.. Valid values are `MONTHLY|QUARTERLY|SEMI_ANNUAL|ANNUAL|NONE`',
    `incoterm` STRING COMMENT 'International Commercial Terms (Incoterms) defining the delivery terms, risk transfer point, and cost responsibilities between buyer and seller for this price schedule line. [ENUM-REF-CANDIDATE: EXW|FCA|CPT|CIP|DAP|DPU|DDP|FAS|FOB|CFR|CIF — 11 candidates stripped; promote to reference product]',
    `item_description` STRING COMMENT 'Detailed textual description of the material or service covered by this price schedule line, including specifications, grade, and any special characteristics.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this contract price schedule record was last updated, supporting audit trails and change tracking.',
    `lead_time_days` STRING COMMENT 'Standard lead time in days from purchase order placement to expected delivery for items ordered under this price schedule line.',
    `maximum_order_quantity` DECIMAL(18,2) COMMENT 'The maximum quantity that can be ordered under this price schedule line in a single purchase order. Nullable if no maximum applies.',
    `minimum_order_quantity` DECIMAL(18,2) COMMENT 'The minimum quantity that must be ordered for this price schedule line to be valid. Orders below this quantity may not be accepted or may incur surcharges.',
    `notes` STRING COMMENT 'Free-text field for additional pricing terms, special conditions, or clarifications related to this price schedule line.',
    `payment_terms_code` STRING COMMENT 'Standard payment terms code applicable to purchases under this price schedule (e.g., NET30, NET60, 2/10NET30). May override contract-level payment terms.. Valid values are `^[A-Z0-9]{2,6}$`',
    `price_escalation_index_type` STRING COMMENT 'The type of economic index used for automatic price escalation adjustments. CPI=Consumer Price Index, PPI=Producer Price Index, FUEL=fuel price index (critical for aviation), LABOR=labor cost index, CUSTOM=custom index, NONE=no escalation.. Valid values are `CPI|PPI|FUEL|LABOR|CUSTOM|NONE`',
    `price_validity_end_date` DATE COMMENT 'The date on which this price schedule line expires and is no longer valid for new purchase orders. Nullable for open-ended pricing agreements.',
    `price_validity_start_date` DATE COMMENT 'The date from which this price schedule line becomes effective and can be used for purchase order pricing.',
    `schedule_line_number` STRING COMMENT 'Sequential line number within the contract price schedule, used for ordering and referencing specific pricing entries.',
    `schedule_status` STRING COMMENT 'Current lifecycle status of the price schedule line. ACTIVE=currently in use, SUPERSEDED=replaced by newer schedule, EXPIRED=validity period ended, SUSPENDED=temporarily inactive, PENDING=awaiting approval.. Valid values are `ACTIVE|SUPERSEDED|EXPIRED|SUSPENDED|PENDING`',
    `service_code` STRING COMMENT 'Unique identifier for the service covered by this price schedule line (e.g., ground handling, catering, maintenance services). Mutually exclusive with material_number for service-based contracts.. Valid values are `^[A-Z0-9]{4,12}$`',
    `tax_code` STRING COMMENT 'Tax classification code determining the applicable tax rate and tax type (VAT, GST, sales tax) for purchases under this price schedule line.. Valid values are `^[A-Z0-9]{2,4}$`',
    `unit_of_measure` STRING COMMENT 'Standard unit of measure for pricing and ordering (e.g., EA=each, KG=kilogram, LT=liter, HR=hour, GL=gallon). Aligns with IATA and ISO standards for aviation materials and services. [ENUM-REF-CANDIDATE: EA|KG|LB|LT|GL|HR|PC|MT|FT|M|BOX|PAL — 12 candidates stripped; promote to reference product]',
    `vendor_part_number` STRING COMMENT 'The vendors own part number or service code for this item, used for cross-referencing and order communication.',
    `volume_tier_1_breakpoint` DECIMAL(18,2) COMMENT 'The minimum quantity threshold for the first volume tier. Orders at or above this quantity qualify for tier 1 pricing.',
    `volume_tier_1_price` DECIMAL(18,2) COMMENT 'The unit price applicable when the order quantity meets or exceeds the volume tier 1 breakpoint.',
    `volume_tier_2_breakpoint` DECIMAL(18,2) COMMENT 'The minimum quantity threshold for the second volume tier. Orders at or above this quantity qualify for tier 2 pricing.',
    `volume_tier_2_price` DECIMAL(18,2) COMMENT 'The unit price applicable when the order quantity meets or exceeds the volume tier 2 breakpoint.',
    `volume_tier_3_breakpoint` DECIMAL(18,2) COMMENT 'The minimum quantity threshold for the third volume tier. Orders at or above this quantity qualify for tier 3 pricing.',
    `volume_tier_3_price` DECIMAL(18,2) COMMENT 'The unit price applicable when the order quantity meets or exceeds the volume tier 3 breakpoint.',
    CONSTRAINT pk_contract_price_schedule PRIMARY KEY(`contract_price_schedule_id`)
) COMMENT 'Detailed pricing schedule record attached to a supply contract defining the agreed unit prices, volume tiers, and price adjustment mechanisms for specific materials, parts, or services. Captures price schedule line ID, supply contract reference, material number or service code, description, unit of measure, base unit price, currency, volume tier breakpoints and corresponding tier prices, price validity start and end dates, price escalation index (CPI, PPI, fuel index), escalation frequency, escalation cap percentage, discount percentage, and price schedule status (active, superseded, expired). Enables accurate PO pricing, contract compliance checking, and price variance analysis.';

CREATE OR REPLACE TABLE `airlines_ecm`.`procurement`.`mro_exchange_order` (
    `mro_exchange_order_id` BIGINT COMMENT 'Unique identifier for the MRO component exchange or loan transaction record.',
    `part_master_id` BIGINT COMMENT 'Foreign key linking to procurement.part_master. Business justification: MRO exchange orders reference aircraft components that should link to part_master for normalization. Currently uses component_part_number and component_description (STRING) which are denormalized. Add',
    `employee_id` BIGINT COMMENT 'Identifier of the maintenance engineer or planner who initiated this exchange order request.',
    `vendor_id` BIGINT COMMENT 'Reference to the approved repair vendor or component pool operator executing this exchange or loan transaction.',
    `return_mro_exchange_order_id` BIGINT COMMENT 'Self-referencing FK on mro_exchange_order (return_mro_exchange_order_id)',
    `actual_return_date` DATE COMMENT 'Actual date when the replacement serviceable component was physically received and accepted into inventory.',
    `aircraft_registration` STRING COMMENT 'Tail number or registration identifier of the aircraft requiring the component exchange, critical for traceability and airworthiness compliance.. Valid values are `^[A-Z0-9-]{5,10}$`',
    `airworthiness_release_document` STRING COMMENT 'Reference number of the EASA Form 1 / FAA Form 8130-3 or equivalent airworthiness release certificate accompanying the incoming serviceable component.',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when this exchange order was formally approved and authorized for vendor dispatch.',
    `ata_chapter` STRING COMMENT 'Two-digit ATA chapter code classifying the aircraft system to which this component belongs (e.g., 32 for Landing Gear, 71 for Power Plant).. Valid values are `^[0-9]{2}$`',
    `cancellation_reason` STRING COMMENT 'Textual explanation for why this exchange order was cancelled before completion, if applicable.',
    `closed_timestamp` TIMESTAMP COMMENT 'Date and time when this exchange order was closed after successful receipt and acceptance of the replacement component.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this exchange order record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this exchange order (exchange fee, loan charges).. Valid values are `^[A-Z]{3}$`',
    `dispatch_date` DATE COMMENT 'Date when the outgoing component was physically dispatched to the vendor or repair station.',
    `exchange_fee` DECIMAL(18,2) COMMENT 'Fixed fee charged by the vendor or pool operator for the component exchange transaction, excluding loan or rental charges.',
    `exchange_order_number` STRING COMMENT 'Externally-known unique business identifier for this MRO exchange or loan transaction, used for vendor communication and tracking.. Valid values are `^[A-Z0-9-]{6,20}$`',
    `expected_return_date` DATE COMMENT 'Contractually agreed or estimated date by which the replacement serviceable component is expected to be received.',
    `incoming_condition` STRING COMMENT 'Airworthiness condition classification of the replacement component received: serviceable, overhauled, repaired, or as-new.. Valid values are `serviceable|overhauled|repaired|as-new`',
    `incoming_serial_number` STRING COMMENT 'Unique serial number of the serviceable replacement component received from the vendor or component pool.. Valid values are `^[A-Z0-9-]{4,20}$`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this exchange order record was most recently updated or modified.',
    `loan_fee_per_day` DECIMAL(18,2) COMMENT 'Daily rental or loan fee charged for the temporary use of the replacement component from the pool, applicable for loan-type orders.',
    `maximum_loan_period_days` STRING COMMENT 'Maximum number of days the component can be on loan before mandatory return or conversion to outright purchase, per pool agreement terms.',
    `notes` STRING COMMENT 'Free-text field for additional remarks, special handling instructions, or operational context related to this exchange transaction.',
    `order_status` STRING COMMENT 'Current lifecycle status of the exchange order: open (initiated), component-dispatched (outgoing sent), awaiting-return (incoming expected), closed (completed), overdue (past expected return), or cancelled.. Valid values are `open|component-dispatched|awaiting-return|closed|overdue|cancelled`',
    `order_type` STRING COMMENT 'Classification of the transaction type: exchange (swap serviceable for unserviceable), loan (temporary use), borrow (receive from pool), repair-and-return (send for repair), outright-purchase, or consignment.. Valid values are `exchange|loan|borrow|repair-and-return|outright-purchase|consignment`',
    `outgoing_condition` STRING COMMENT 'Airworthiness condition classification of the component being sent out: serviceable, unserviceable, repairable, beyond-economic-repair, or time-expired.. Valid values are `serviceable|unserviceable|repairable|beyond-economic-repair|time-expired`',
    `outgoing_serial_number` STRING COMMENT 'Unique serial number of the unserviceable or time-expired component being sent out to the vendor for exchange or repair.. Valid values are `^[A-Z0-9-]{4,20}$`',
    `priority_level` STRING COMMENT 'Business priority classification for this exchange: routine (planned maintenance), urgent (expedited), AOG (aircraft on ground - highest priority), or critical.. Valid values are `routine|urgent|aog|critical`',
    `shipping_method` STRING COMMENT 'Transportation method used for dispatching and receiving components: air-freight, ground, courier, or hand-carry (for AOG situations).. Valid values are `air-freight|ground|courier|hand-carry`',
    `total_loan_charges` DECIMAL(18,2) COMMENT 'Cumulative loan fees accrued based on the actual loan duration and daily rate, calculated at order closure.',
    `tracking_number` STRING COMMENT 'Carrier tracking number for the outgoing or incoming component shipment, enabling real-time logistics visibility.',
    `vendor_reference_number` STRING COMMENT 'Vendors internal reference or tracking number for this exchange transaction, used for reconciliation and dispute resolution.',
    `work_order_reference` STRING COMMENT 'Reference to the maintenance work order or Aircraft on Ground (AOG) event that triggered this component exchange requirement.',
    CONSTRAINT pk_mro_exchange_order PRIMARY KEY(`mro_exchange_order_id`)
) COMMENT 'Transactional record for MRO component exchange and loan transactions with approved repair vendors and component pool operators. Captures exchange order number, order type (exchange, loan, borrow, repair-and-return), vendor reference, component part number, component serial number (outgoing), component serial number (incoming), aircraft registration, work order reference, dispatch date, expected return date, actual return date, exchange fee, loan fee per day, maximum loan period, currency, component condition (serviceable, unserviceable), airworthiness release document reference, and order status (open, component dispatched, awaiting return, closed, overdue). Critical for rotable component pool management and AOG recovery.';

CREATE OR REPLACE TABLE `airlines_ecm`.`procurement`.`repair_order` (
    `repair_order_id` BIGINT COMMENT 'Unique identifier for the repair order record. Primary key for the repair order entity.',
    `employee_id` BIGINT COMMENT 'Identifier of the maintenance manager or authorized approver who approved the repair order and associated cost.',
    `part_master_id` BIGINT COMMENT 'Foreign key linking to procurement.part_master. Business justification: Repair orders reference aircraft components that should link to part_master for normalization. Currently uses component_part_number (STRING) which is denormalized. Adding part_master_id FK enables pro',
    `primary_repair_requestor_employee_id` BIGINT COMMENT 'Identifier of the maintenance engineer or planner who initiated the repair order request.',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to procurement.purchase_order. Business justification: Repair orders reference purchase orders for procurement tracking and invoice reconciliation. Currently uses purchase_order_reference (STRING) which is a denormalized business reference. Adding purchas',
    `flight_leg_id` BIGINT COMMENT 'Foreign key linking to flight.flight_leg. Business justification: Component removals triggering repair orders occur on specific flights where defects are discovered. Airlines track removal events for reliability analysis, warranty claims (proving in-service failure)',
    `vendor_id` BIGINT COMMENT 'Reference to the approved repair station or Part-145 Approved Maintenance Organization (AMO) performing the repair work.',
    `rework_repair_order_id` BIGINT COMMENT 'Self-referencing FK on repair_order (rework_repair_order_id)',
    `actual_return_date` DATE COMMENT 'Date the repaired component was actually received back from the vendor. Used to calculate actual turnaround time and vendor on-time delivery performance.',
    `aircraft_registration` STRING COMMENT 'Tail number or registration of the aircraft from which the component was removed, enabling traceability back to the specific aircraft.. Valid values are `^[A-Z0-9-]{5,10}$`',
    `airworthiness_certificate_type` STRING COMMENT 'Type of airworthiness release certificate issued by the repair station, indicating the regulatory authority under which the repair was certified.. Valid values are `FAA-8130-3|EASA-Form-1|JAA-Form-One|CAAC-Release|other`',
    `airworthiness_release_document_number` STRING COMMENT 'Reference number of the airworthiness release certificate issued by the repair station upon completion of work. May be an FAA Form 8130-3 (Authorized Release Certificate), EASA Form 1 (Authorized Release Certificate), or JAA Form One depending on jurisdiction.. Valid values are `^[A-Z0-9-]{6,30}$`',
    `ata_chapter` STRING COMMENT 'ATA iSpec 2200 chapter code classifying the aircraft system to which the component belongs (e.g., 32 for Landing Gear, 71 for Power Plant).. Valid values are `^[0-9]{2}(-[0-9]{2})?$`',
    `ber_flag` BOOLEAN COMMENT 'Indicator that the component was declared beyond economical repair by the vendor, meaning the repair cost exceeds the threshold value or replacement cost.',
    `ber_threshold_value` DECIMAL(18,2) COMMENT 'Maximum acceptable repair cost threshold for this component. If actual repair cost exceeds this value, the component is declared BER and a replacement is procured instead.',
    `component_serial_number` STRING COMMENT 'Unique serial number of the individual component unit being repaired. Enables full traceability of the specific rotable or repairable part throughout its lifecycle.. Valid values are `^[A-Z0-9-]{4,25}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the repair order record was first created in the system. Audit trail for data lineage and compliance.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the repair cost amounts (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `dispatch_date` DATE COMMENT 'Date the unserviceable component was shipped to the repair vendor. Marks the start of the repair turnaround time (TAT) measurement.',
    `fault_description` STRING COMMENT 'Detailed description of the defect, malfunction, or reason the component was removed from service and requires repair. Captured from maintenance logs or pilot reports.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the repair order record was last updated. Audit trail for data lineage and change tracking.',
    `notes` STRING COMMENT 'Free-text field for additional comments, special instructions to the vendor, or internal notes regarding the repair order.',
    `priority_level` STRING COMMENT 'Urgency classification for the repair order: AOG (Aircraft on Ground - highest priority), critical (fleet impact), high (near-term need), normal (standard turnaround), or low (non-urgent).. Valid values are `aog|critical|high|normal|low`',
    `promised_return_date` DATE COMMENT 'Date the repair vendor committed to return the serviceable component. Used for planning and vendor performance tracking.',
    `removal_date` DATE COMMENT 'Date the component was removed from the aircraft and tagged as unserviceable, prior to being dispatched for repair.',
    `removal_reason_code` STRING COMMENT 'Standardized code indicating the reason for component removal (e.g., scheduled maintenance, unscheduled failure, preventive action, modification). Aligns with ATA Spec 2000 reason codes.. Valid values are `^[A-Z0-9]{2,6}$`',
    `repair_cost_actual` DECIMAL(18,2) COMMENT 'Final invoiced cost for the completed repair work, including any additional charges for findings discovered during teardown or scope changes.',
    `repair_cost_quoted` DECIMAL(18,2) COMMENT 'Initial cost estimate provided by the repair vendor for the repair work, before any additional findings or scope changes.',
    `repair_order_number` STRING COMMENT 'Externally-known unique business identifier for the repair order, used for tracking and communication with repair vendors.. Valid values are `^RO-[A-Z0-9]{8,12}$`',
    `repair_order_status` STRING COMMENT 'Current lifecycle status of the repair order: dispatched (sent to vendor), in-repair (work in progress), awaiting-parts (vendor waiting for spare parts), completed (repair finished and component returned), ber-declared (beyond economical repair), or cancelled (order terminated).. Valid values are `dispatched|in-repair|awaiting-parts|completed|ber-declared|cancelled`',
    `repair_specification_reference` STRING COMMENT 'Reference to the technical specification, service bulletin, or Component Maintenance Manual (CMM) section governing the repair work to be performed.',
    `repair_station_certificate_number` STRING COMMENT 'Regulatory certificate number of the Part-145 repair station performing the work, issued by EASA, FAA, or other civil aviation authority.. Valid values are `^[A-Z0-9]{4,15}$`',
    `repair_type` STRING COMMENT 'Classification of the maintenance action being performed on the component: overhaul (complete disassembly and rebuild), repair (corrective action), test (functional verification), modification (design change), inspection (scheduled check), or calibration (instrument adjustment).. Valid values are `overhaul|repair|test|modification|inspection|calibration`',
    `replacement_part_ordered_flag` BOOLEAN COMMENT 'Indicator that a replacement part has been ordered because the original component was declared BER or the repair was not feasible.',
    `warranty_claim_flag` BOOLEAN COMMENT 'Indicator that this repair is being claimed under manufacturer or vendor warranty, potentially resulting in no-charge or reduced-cost repair.',
    `warranty_reference_number` STRING COMMENT 'Warranty claim reference number provided by the manufacturer or vendor when the repair is covered under warranty terms.',
    `work_order_reference` STRING COMMENT 'Reference to the internal maintenance work order under which the component removal and repair order were initiated.. Valid values are `^WO-[A-Z0-9]{6,12}$`',
    CONSTRAINT pk_repair_order PRIMARY KEY(`repair_order_id`)
) COMMENT 'Transactional record for component and part repair orders placed with approved repair stations (Part-145 AMOs) for unserviceable rotable and repairable parts. Captures repair order number, repair vendor (vendor reference), component part number, component serial number, ATA chapter, fault description, repair type (overhaul, repair, test, modification, inspection), repair specification reference, dispatch date to vendor, promised return date, actual return date, repair cost quoted, repair cost actual, beyond economical repair (BER) flag, BER threshold value, replacement part ordered flag, airworthiness release document number (CRS/8130-3/EASA Form 1), and repair order status (dispatched, in-repair, awaiting parts, completed, BER declared). Enables MRO cost control and component traceability.';

CREATE OR REPLACE TABLE `airlines_ecm`.`procurement`.`savings_initiative` (
    `savings_initiative_id` BIGINT COMMENT 'Unique identifier for the procurement savings initiative. Primary key.',
    `employee_id` BIGINT COMMENT 'Identifier of the procurement buyer or category manager responsible for leading and delivering this savings initiative.',
    `procurement_category_id` BIGINT COMMENT 'Foreign key linking to procurement.procurement_category. Business justification: Savings initiatives have procurement_category (STRING) which should be normalized to procurement_category_id FK for proper category-level savings tracking, portfolio management, and reporting. Remove ',
    `sourcing_event_id` BIGINT COMMENT 'Foreign key linking to procurement.sourcing_event. Business justification: Savings initiatives often result from sourcing events. Currently uses sourcing_event_reference (STRING) which is a denormalized business reference. Adding sourcing_event_id FK normalizes this relation',
    `supply_contract_id` BIGINT COMMENT 'Foreign key linking to procurement.supply_contract. Business justification: Savings initiatives often result from contract negotiations. Currently uses contract_reference (STRING) which is a denormalized business reference. Adding supply_contract_id FK normalizes this relatio',
    `tertiary_savings_finance_validator_employee_id` BIGINT COMMENT 'Identifier of the finance team member who validated the savings, ensuring accountability for the financial audit and confirmation process.',
    `vendor_id` BIGINT COMMENT 'Identifier of the primary vendor or supplier involved in this savings initiative, if the initiative is vendor-specific (e.g., price negotiation with a single supplier).',
    `parent_savings_initiative_id` BIGINT COMMENT 'Self-referencing FK on savings_initiative (parent_savings_initiative_id)',
    `actual_completion_date` DATE COMMENT 'The actual date when the initiative was completed and savings realization was finalized. Null if still in progress.',
    `approval_authority_level` STRING COMMENT 'The organizational level or role that approved the savings initiative, reflecting the governance and authorization hierarchy (buyer, category manager, CPO, CFO, or executive committee).. Valid values are `buyer|category_manager|cpo|cfo|executive_committee`',
    `approved_timestamp` TIMESTAMP COMMENT 'The date and time when the savings initiative was formally approved, marking the transition from proposed to authorized status.',
    `baseline_spend_amount` DECIMAL(18,2) COMMENT 'The baseline annual or period spend amount against which savings are measured, representing the pre-initiative cost level.',
    `business_case_summary` STRING COMMENT 'A brief summary of the business case and rationale for the savings initiative, explaining the strategic or operational drivers for the cost reduction project.',
    `cost_center` STRING COMMENT 'The cost center or business unit that will benefit from the savings, used for financial allocation and reporting of cost reduction impact.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this savings initiative record was first created in the system, providing audit trail for record origination.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this initiative (baseline spend, target savings, realized savings).. Valid values are `^[A-Z]{3}$`',
    `finance_validation_date` DATE COMMENT 'The date when the finance department validated and confirmed the realized savings, providing independent verification of the cost reduction achievement.',
    `gl_account_code` STRING COMMENT 'The general ledger account code to which the baseline spend and savings are allocated, enabling financial tracking and variance analysis.',
    `initiative_name` STRING COMMENT 'Descriptive name of the savings initiative, summarizing the cost reduction project or strategic sourcing effort.',
    `initiative_number` STRING COMMENT 'Business-facing reference number for the savings initiative, used for tracking and reporting to procurement leadership and finance.',
    `initiative_status` STRING COMMENT 'Current lifecycle status of the savings initiative: proposed (under evaluation), approved (authorized to proceed), in-progress (execution underway), completed (savings realized), cancelled (discontinued), or on-hold (temporarily paused).. Valid values are `proposed|approved|in_progress|completed|cancelled|on_hold`',
    `initiative_type` STRING COMMENT 'Classification of the savings initiative approach: negotiation (price reduction), consolidation (vendor or volume consolidation), specification change (material substitution), demand reduction (consumption reduction), process improvement (efficiency gains), or insourcing/outsourcing strategy change.. Valid values are `negotiation|consolidation|specification_change|demand_reduction|process_improvement|insourcing`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this savings initiative record was last updated, supporting change tracking and data currency verification.',
    `notes` STRING COMMENT 'Free-text notes and comments about the savings initiative, capturing additional context, lessons learned, or implementation details not covered by structured fields.',
    `realized_savings_amount` DECIMAL(18,2) COMMENT 'The actual savings amount achieved to date, representing the cumulative financial benefit delivered by the initiative.',
    `risk_assessment` STRING COMMENT 'Assessment of risks associated with the initiative, such as supplier performance risk, operational disruption risk, or quality impact risk, documented for governance and mitigation planning.',
    `savings_validation_status` STRING COMMENT 'The validation stage of the savings: pipeline (forecasted), committed (contractually agreed), realized (operationally achieved), validated by finance (audited and confirmed), or disputed (under review).. Valid values are `pipeline|committed|realized|validated_by_finance|disputed`',
    `start_date` DATE COMMENT 'The date when the savings initiative was officially launched or execution began.',
    `target_completion_date` DATE COMMENT 'The planned or target date by which the initiative is expected to be completed and savings fully realized.',
    `target_savings_amount` DECIMAL(18,2) COMMENT 'The target absolute savings amount (in currency) that the initiative aims to achieve, representing the financial goal for cost reduction.',
    `target_savings_percentage` DECIMAL(18,2) COMMENT 'The target savings expressed as a percentage of baseline spend, providing a relative measure of the cost reduction goal.',
    CONSTRAINT pk_savings_initiative PRIMARY KEY(`savings_initiative_id`)
) COMMENT 'Master record for procurement savings initiatives and cost reduction projects tracked by the procurement team. Captures initiative ID, initiative name, procurement category, initiative type (negotiation, consolidation, specification change, demand reduction, process improvement, insourcing, outsourcing), target savings amount, target savings percentage, baseline spend, currency, initiative owner (buyer), start date, target completion date, actual completion date, realized savings amount, savings validation status (pipeline, committed, realized, validated by finance), initiative status (proposed, approved, in-progress, completed, cancelled), and strategic sourcing event reference. Enables procurement value delivery tracking and CPO reporting.';

CREATE OR REPLACE TABLE `airlines_ecm`.`procurement`.`vendor_category_qualification` (
    `vendor_category_qualification_id` BIGINT COMMENT 'Unique identifier for this vendor-category qualification record. Primary key.',
    `employee_id` BIGINT COMMENT 'Foreign key to workforce.employee identifying the procurement manager or category owner who approved this vendor qualification.',
    `category_procurement_category_id` BIGINT COMMENT 'Foreign key linking to the procurement category for which the vendor is qualified',
    `procurement_category_id` BIGINT COMMENT 'Foreign key to procurement.procurement_category.procurement_category_id',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to the vendor being qualified for this category',
    `category_specific_lead_time_days` STRING COMMENT 'Average lead time in days from purchase order to delivery for this vendor supplying items in this category. May differ from vendor-level or category-level defaults. Explicitly identified in detection phase relationship data.',
    `category_specific_payment_terms` STRING COMMENT 'Payment terms negotiated specifically for this vendor-category combination (e.g., Net 30, Net 60, 2/10 Net 30). May differ from the vendors standard payment terms. Explicitly identified in detection phase relationship data.',
    `certification_level` STRING COMMENT 'Tier or certification level assigned to this vendor for this specific category based on performance, capabilities, and compliance: gold (top tier), silver (preferred), bronze (approved), standard (qualified), conditional (approved with restrictions). Explicitly identified in detection phase relationship data.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this qualification record was first created in the system.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this qualification record was last updated. Used for change tracking and audit.',
    `last_performance_review_date` DATE COMMENT 'Date of the most recent performance review or scorecard assessment for this vendor in this category. Used to track evaluation currency. Explicitly identified in detection phase relationship data.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next performance review or qualification renewal for this vendor-category combination.',
    `performance_tier_for_category` STRING COMMENT 'Performance rating assigned to this vendor for this specific category based on quality, delivery, cost, and service metrics: excellent (top performer), good (meets expectations), satisfactory (acceptable), needs_improvement (below target), poor (unacceptable). Explicitly identified in detection phase relationship data.',
    `preferred_vendor_flag` BOOLEAN COMMENT 'Indicates whether this vendor is designated as a preferred supplier for this category, receiving priority consideration in sourcing decisions. Explicitly identified in detection phase relationship data.',
    `qualification_date` DATE COMMENT 'Date when the vendor was officially qualified or approved to supply goods/services in this category. Explicitly identified in detection phase relationship data.',
    `qualification_expiry_date` DATE COMMENT 'Date when this qualification expires and requires renewal or re-evaluation. Null for qualifications without expiry. Explicitly identified in detection phase relationship data.',
    `qualification_notes` STRING COMMENT 'Free-text notes capturing special conditions, restrictions, or comments related to this vendor-category qualification (e.g., approved for emergency purchases only, requires dual approval above $50K).',
    `qualification_status` STRING COMMENT 'Current status of the vendor qualification for this category: active (approved and operational), suspended (temporarily not allowed), expired (qualification period ended), under_review (performance review in progress), pending_approval (awaiting approval). Explicitly identified in detection phase relationship data.',
    `spend_limit_amount` DECIMAL(18,2) COMMENT 'Maximum spend amount (in base currency) allowed for this vendor within this category during the qualification period. Used for spend control and vendor diversification. Explicitly identified in detection phase relationship data.',
    CONSTRAINT pk_vendor_category_qualification PRIMARY KEY(`vendor_category_qualification_id`)
) COMMENT 'This association product represents the qualification or approval of a vendor to supply goods or services within a specific procurement category. It captures the Approved Vendor List (AVL) or Qualified Supplier List (QSL) maintained by procurement teams. Each record links one vendor to one procurement category with attributes that exist only in the context of this qualification relationship, including qualification dates, performance metrics, spend limits, and category-specific terms. This is the operational record that buyers use to select qualified vendors for category-specific sourcing activities.. Existence Justification: In airline procurement operations, vendors are qualified to supply goods and services across multiple procurement categories (e.g., a vendor may be approved for both MRO parts and ground services), and each procurement category has multiple qualified vendors to ensure supply continuity and competitive sourcing. Procurement teams actively manage Approved Vendor Lists (AVLs) by category, tracking qualification dates, performance ratings, spend limits, and category-specific terms. Buyers must select from the qualified vendor list when sourcing within a category, and vendor performance is evaluated separately for each category they serve.';

CREATE OR REPLACE TABLE `airlines_ecm`.`procurement`.`vendor_audit_schedule` (
    `vendor_audit_schedule_id` BIGINT COMMENT 'Unique identifier for this vendor audit schedule record. Primary key.',
    `employee_id` BIGINT COMMENT 'Foreign key to workforce.employee identifying the lead auditor assigned to conduct this vendor audit under this program',
    `audit_program_id` BIGINT COMMENT 'Foreign key to compliance.audit_program identifying which audit program this schedule belongs to',
    `vendor_id` BIGINT COMMENT 'Foreign key to procurement.vendor identifying which vendor is being audited',
    `audit_exemption_flag` BOOLEAN COMMENT 'Indicates whether this vendor has been granted an exemption from this audit program based on alternative certifications or low-risk classification',
    `audit_frequency` STRING COMMENT 'The specific frequency at which this vendor must be audited under this program, which may differ from the programs default cycle based on vendor tier, risk profile, or contractual requirements',
    `audit_report_document_reference` BIGINT COMMENT 'Foreign key to document management system linking to the formal audit report for this vendor-program audit',
    `audit_result` STRING COMMENT 'The outcome or status of the most recent audit of this vendor under this program',
    `audit_scope` STRING COMMENT 'The specific scope of audit coverage applicable to this vendor under this program, which may be a subset of the programs full scope based on the vendors service category or contract terms',
    `audit_score` DECIMAL(18,2) COMMENT 'Numerical score or rating assigned to the vendor based on the audit results, if the audit program uses a scoring methodology',
    `corrective_action_plan_due_date` DATE COMMENT 'The date by which the vendor must submit their corrective action plan, if required',
    `corrective_action_plan_required` BOOLEAN COMMENT 'Indicates whether this vendor is required to submit a corrective action plan based on audit findings',
    `corrective_action_plan_status` STRING COMMENT 'Current status of the corrective action plan for this vendor-audit combination',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this vendor audit schedule record was first created in the system',
    `critical_findings_count` STRING COMMENT 'Number of critical or high-severity findings from the most recent audit',
    `effective_date` DATE COMMENT 'The date from which this vendor became subject to this audit program',
    `end_date` DATE COMMENT 'The date on which this vendor audit schedule ended, if no longer applicable',
    `exemption_expiry_date` DATE COMMENT 'The date on which the audit exemption expires and the vendor becomes subject to the audit program again',
    `exemption_reason` STRING COMMENT 'Business justification for why this vendor is exempt from this audit program, if applicable',
    `findings_count` STRING COMMENT 'Total number of audit findings identified during the most recent audit of this vendor under this program',
    `last_audit_date` DATE COMMENT 'The date when this vendor was last audited under this specific audit program',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this vendor audit schedule record was last updated or modified',
    `next_audit_due_date` DATE COMMENT 'The scheduled date by which the next audit of this vendor under this program must be completed',
    `notes` STRING COMMENT 'Free-text field for additional notes about this vendor audit schedule, special conditions, or historical context',
    `schedule_status` STRING COMMENT 'Current lifecycle status of this vendor audit schedule record',
    CONSTRAINT pk_vendor_audit_schedule PRIMARY KEY(`vendor_audit_schedule_id`)
) COMMENT 'This association product represents the scheduled audit relationship between audit programs and vendors. It captures the operational audit schedule, scope, and results for each vendor under each applicable audit program. Each record links one audit_program to one vendor with attributes that exist only in the context of this specific audit assignment, including when the audit is scheduled, what scope applies, and what results were obtained.. Existence Justification: In airline operations, multiple audit programs (IOSA, FAA ATOS, EASA, internal quality audits) apply to multiple vendors across different categories (MRO suppliers, fuel suppliers, catering, ground services). Each vendor-program combination requires its own audit schedule, scope customization, and result tracking. Compliance teams actively manage these audit schedules as operational records, assigning auditors, tracking findings, and managing corrective action plans for each vendor under each applicable program.';

CREATE OR REPLACE TABLE `airlines_ecm`.`procurement`.`vendor_authorization` (
    `vendor_authorization_id` BIGINT COMMENT 'Unique identifier for this vendor authorization record. Primary key.',
    `authorized_by_employee_id` BIGINT COMMENT 'Foreign key to the employee who granted this authorization. Used for audit trail and accountability.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to the employee who is authorized to transact with the vendor',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to the vendor for which the employee has authorization',
    `approval_limit_amount` DECIMAL(18,2) COMMENT 'The maximum monetary value that the employee is authorized to approve for transactions with this vendor. Enforces spending controls and segregation of duties.',
    `approval_limit_currency` STRING COMMENT 'Three-letter ISO currency code for the approval limit amount.',
    `authorization_level` STRING COMMENT 'The hierarchical level of authorization granted to the employee for this vendor. Higher levels permit larger transaction values and more critical procurement actions.',
    `authorization_status` STRING COMMENT 'Current lifecycle status of this vendor authorization record.',
    `effective_date` DATE COMMENT 'The date from which this vendor authorization becomes active and the employee is permitted to transact with the vendor.',
    `expiry_date` DATE COMMENT 'The date on which this vendor authorization expires. After this date, the employee is no longer authorized to transact with the vendor unless the authorization is renewed.',
    `last_review_date` DATE COMMENT 'The date when this authorization was last reviewed for continued validity and appropriateness.',
    `notes` STRING COMMENT 'Free-text notes capturing special conditions, restrictions, or context for this vendor authorization.',
    `relationship_type` STRING COMMENT 'The type of authorization relationship between the employee and vendor. Defines what actions the employee is permitted to perform with this vendor.',
    CONSTRAINT pk_vendor_authorization PRIMARY KEY(`vendor_authorization_id`)
) COMMENT 'This association product represents the authorization relationship between employees and vendors in the procurement process. It captures which employees are authorized to transact with which vendors, the type and level of authorization granted, spending limits, and validity periods. Each record links one employee to one vendor with attributes that exist only in the context of this authorization relationship. Essential for segregation of duties, approval workflows, and procurement compliance.. Existence Justification: In airline procurement operations, multiple employees across different functions (procurement managers, technical specialists, quality inspectors, station managers) are authorized to transact with each vendor, and each employee typically has authorization for multiple vendors based on their role and procurement category responsibility. The authorization relationship itself carries critical business data including authorization type, level, spending limits, and validity periods that belong to neither the employee nor the vendor alone but to the specific employee-vendor authorization pairing.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `airlines_ecm`.`procurement`.`vendor` ADD CONSTRAINT `fk_procurement_vendor_parent_vendor_id` FOREIGN KEY (`parent_vendor_id`) REFERENCES `airlines_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `airlines_ecm`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_procurement_category_id` FOREIGN KEY (`procurement_category_id`) REFERENCES `airlines_ecm`.`procurement`.`procurement_category`(`procurement_category_id`);
ALTER TABLE `airlines_ecm`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_sourcing_event_id` FOREIGN KEY (`sourcing_event_id`) REFERENCES `airlines_ecm`.`procurement`.`sourcing_event`(`sourcing_event_id`);
ALTER TABLE `airlines_ecm`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_supply_contract_id` FOREIGN KEY (`supply_contract_id`) REFERENCES `airlines_ecm`.`procurement`.`supply_contract`(`supply_contract_id`);
ALTER TABLE `airlines_ecm`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `airlines_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `airlines_ecm`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_blanket_purchase_order_id` FOREIGN KEY (`blanket_purchase_order_id`) REFERENCES `airlines_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `airlines_ecm`.`procurement`.`po_line` ADD CONSTRAINT `fk_procurement_po_line_material_part_master_id` FOREIGN KEY (`material_part_master_id`) REFERENCES `airlines_ecm`.`procurement`.`part_master`(`part_master_id`);
ALTER TABLE `airlines_ecm`.`procurement`.`po_line` ADD CONSTRAINT `fk_procurement_po_line_part_master_id` FOREIGN KEY (`part_master_id`) REFERENCES `airlines_ecm`.`procurement`.`part_master`(`part_master_id`);
ALTER TABLE `airlines_ecm`.`procurement`.`po_line` ADD CONSTRAINT `fk_procurement_po_line_procurement_category_id` FOREIGN KEY (`procurement_category_id`) REFERENCES `airlines_ecm`.`procurement`.`procurement_category`(`procurement_category_id`);
ALTER TABLE `airlines_ecm`.`procurement`.`po_line` ADD CONSTRAINT `fk_procurement_po_line_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `airlines_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `airlines_ecm`.`procurement`.`po_line` ADD CONSTRAINT `fk_procurement_po_line_parent_po_line_id` FOREIGN KEY (`parent_po_line_id`) REFERENCES `airlines_ecm`.`procurement`.`po_line`(`po_line_id`);
ALTER TABLE `airlines_ecm`.`procurement`.`goods_receipt` ADD CONSTRAINT `fk_procurement_goods_receipt_part_master_id` FOREIGN KEY (`part_master_id`) REFERENCES `airlines_ecm`.`procurement`.`part_master`(`part_master_id`);
ALTER TABLE `airlines_ecm`.`procurement`.`goods_receipt` ADD CONSTRAINT `fk_procurement_goods_receipt_po_line_id` FOREIGN KEY (`po_line_id`) REFERENCES `airlines_ecm`.`procurement`.`po_line`(`po_line_id`);
ALTER TABLE `airlines_ecm`.`procurement`.`goods_receipt` ADD CONSTRAINT `fk_procurement_goods_receipt_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `airlines_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `airlines_ecm`.`procurement`.`goods_receipt` ADD CONSTRAINT `fk_procurement_goods_receipt_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `airlines_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `airlines_ecm`.`procurement`.`goods_receipt` ADD CONSTRAINT `fk_procurement_goods_receipt_correction_goods_receipt_id` FOREIGN KEY (`correction_goods_receipt_id`) REFERENCES `airlines_ecm`.`procurement`.`goods_receipt`(`goods_receipt_id`);
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_invoice` ADD CONSTRAINT `fk_procurement_vendor_invoice_goods_receipt_id` FOREIGN KEY (`goods_receipt_id`) REFERENCES `airlines_ecm`.`procurement`.`goods_receipt`(`goods_receipt_id`);
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_invoice` ADD CONSTRAINT `fk_procurement_vendor_invoice_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `airlines_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_invoice` ADD CONSTRAINT `fk_procurement_vendor_invoice_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `airlines_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_invoice` ADD CONSTRAINT `fk_procurement_vendor_invoice_credit_note_vendor_invoice_id` FOREIGN KEY (`credit_note_vendor_invoice_id`) REFERENCES `airlines_ecm`.`procurement`.`vendor_invoice`(`vendor_invoice_id`);
ALTER TABLE `airlines_ecm`.`procurement`.`supply_contract` ADD CONSTRAINT `fk_procurement_supply_contract_procurement_category_id` FOREIGN KEY (`procurement_category_id`) REFERENCES `airlines_ecm`.`procurement`.`procurement_category`(`procurement_category_id`);
ALTER TABLE `airlines_ecm`.`procurement`.`supply_contract` ADD CONSTRAINT `fk_procurement_supply_contract_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `airlines_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `airlines_ecm`.`procurement`.`supply_contract` ADD CONSTRAINT `fk_procurement_supply_contract_renewed_supply_contract_id` FOREIGN KEY (`renewed_supply_contract_id`) REFERENCES `airlines_ecm`.`procurement`.`supply_contract`(`supply_contract_id`);
ALTER TABLE `airlines_ecm`.`procurement`.`part_master` ADD CONSTRAINT `fk_procurement_part_master_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `airlines_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `airlines_ecm`.`procurement`.`part_master` ADD CONSTRAINT `fk_procurement_part_master_superseded_by_part_master_id` FOREIGN KEY (`superseded_by_part_master_id`) REFERENCES `airlines_ecm`.`procurement`.`part_master`(`part_master_id`);
ALTER TABLE `airlines_ecm`.`procurement`.`part_master` ADD CONSTRAINT `fk_procurement_part_master_superseded_part_master_id` FOREIGN KEY (`superseded_part_master_id`) REFERENCES `airlines_ecm`.`procurement`.`part_master`(`part_master_id`);
ALTER TABLE `airlines_ecm`.`procurement`.`parts_inventory` ADD CONSTRAINT `fk_procurement_parts_inventory_part_master_id` FOREIGN KEY (`part_master_id`) REFERENCES `airlines_ecm`.`procurement`.`part_master`(`part_master_id`);
ALTER TABLE `airlines_ecm`.`procurement`.`parts_inventory` ADD CONSTRAINT `fk_procurement_parts_inventory_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `airlines_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `airlines_ecm`.`procurement`.`parts_inventory` ADD CONSTRAINT `fk_procurement_parts_inventory_transferred_from_parts_inventory_id` FOREIGN KEY (`transferred_from_parts_inventory_id`) REFERENCES `airlines_ecm`.`procurement`.`parts_inventory`(`parts_inventory_id`);
ALTER TABLE `airlines_ecm`.`procurement`.`sourcing_event` ADD CONSTRAINT `fk_procurement_sourcing_event_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `airlines_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `airlines_ecm`.`procurement`.`sourcing_event` ADD CONSTRAINT `fk_procurement_sourcing_event_procurement_category_id` FOREIGN KEY (`procurement_category_id`) REFERENCES `airlines_ecm`.`procurement`.`procurement_category`(`procurement_category_id`);
ALTER TABLE `airlines_ecm`.`procurement`.`sourcing_event` ADD CONSTRAINT `fk_procurement_sourcing_event_prior_sourcing_event_id` FOREIGN KEY (`prior_sourcing_event_id`) REFERENCES `airlines_ecm`.`procurement`.`sourcing_event`(`sourcing_event_id`);
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_quote` ADD CONSTRAINT `fk_procurement_vendor_quote_sourcing_event_id` FOREIGN KEY (`sourcing_event_id`) REFERENCES `airlines_ecm`.`procurement`.`sourcing_event`(`sourcing_event_id`);
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_quote` ADD CONSTRAINT `fk_procurement_vendor_quote_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `airlines_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_quote` ADD CONSTRAINT `fk_procurement_vendor_quote_revised_vendor_quote_id` FOREIGN KEY (`revised_vendor_quote_id`) REFERENCES `airlines_ecm`.`procurement`.`vendor_quote`(`vendor_quote_id`);
ALTER TABLE `airlines_ecm`.`procurement`.`fuel_contract` ADD CONSTRAINT `fk_procurement_fuel_contract_procurement_category_id` FOREIGN KEY (`procurement_category_id`) REFERENCES `airlines_ecm`.`procurement`.`procurement_category`(`procurement_category_id`);
ALTER TABLE `airlines_ecm`.`procurement`.`fuel_contract` ADD CONSTRAINT `fk_procurement_fuel_contract_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `airlines_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `airlines_ecm`.`procurement`.`fuel_contract` ADD CONSTRAINT `fk_procurement_fuel_contract_renewed_fuel_contract_id` FOREIGN KEY (`renewed_fuel_contract_id`) REFERENCES `airlines_ecm`.`procurement`.`fuel_contract`(`fuel_contract_id`);
ALTER TABLE `airlines_ecm`.`procurement`.`fuel_uplift_order` ADD CONSTRAINT `fk_procurement_fuel_uplift_order_fuel_contract_id` FOREIGN KEY (`fuel_contract_id`) REFERENCES `airlines_ecm`.`procurement`.`fuel_contract`(`fuel_contract_id`);
ALTER TABLE `airlines_ecm`.`procurement`.`fuel_uplift_order` ADD CONSTRAINT `fk_procurement_fuel_uplift_order_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `airlines_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `airlines_ecm`.`procurement`.`fuel_uplift_order` ADD CONSTRAINT `fk_procurement_fuel_uplift_order_amended_fuel_uplift_order_id` FOREIGN KEY (`amended_fuel_uplift_order_id`) REFERENCES `airlines_ecm`.`procurement`.`fuel_uplift_order`(`fuel_uplift_order_id`);
ALTER TABLE `airlines_ecm`.`procurement`.`catering_order` ADD CONSTRAINT `fk_procurement_catering_order_supply_contract_id` FOREIGN KEY (`supply_contract_id`) REFERENCES `airlines_ecm`.`procurement`.`supply_contract`(`supply_contract_id`);
ALTER TABLE `airlines_ecm`.`procurement`.`catering_order` ADD CONSTRAINT `fk_procurement_catering_order_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `airlines_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `airlines_ecm`.`procurement`.`catering_order` ADD CONSTRAINT `fk_procurement_catering_order_amended_catering_order_id` FOREIGN KEY (`amended_catering_order_id`) REFERENCES `airlines_ecm`.`procurement`.`catering_order`(`catering_order_id`);
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_performance` ADD CONSTRAINT `fk_procurement_vendor_performance_procurement_category_id` FOREIGN KEY (`procurement_category_id`) REFERENCES `airlines_ecm`.`procurement`.`procurement_category`(`procurement_category_id`);
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_performance` ADD CONSTRAINT `fk_procurement_vendor_performance_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `airlines_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_performance` ADD CONSTRAINT `fk_procurement_vendor_performance_prior_vendor_performance_id` FOREIGN KEY (`prior_vendor_performance_id`) REFERENCES `airlines_ecm`.`procurement`.`vendor_performance`(`vendor_performance_id`);
ALTER TABLE `airlines_ecm`.`procurement`.`procurement_category` ADD CONSTRAINT `fk_procurement_procurement_category_parent_procurement_category_id` FOREIGN KEY (`parent_procurement_category_id`) REFERENCES `airlines_ecm`.`procurement`.`procurement_category`(`procurement_category_id`);
ALTER TABLE `airlines_ecm`.`procurement`.`approved_vendor_list` ADD CONSTRAINT `fk_procurement_approved_vendor_list_procurement_category_id` FOREIGN KEY (`procurement_category_id`) REFERENCES `airlines_ecm`.`procurement`.`procurement_category`(`procurement_category_id`);
ALTER TABLE `airlines_ecm`.`procurement`.`approved_vendor_list` ADD CONSTRAINT `fk_procurement_approved_vendor_list_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `airlines_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `airlines_ecm`.`procurement`.`approved_vendor_list` ADD CONSTRAINT `fk_procurement_approved_vendor_list_superseded_approved_vendor_list_id` FOREIGN KEY (`superseded_approved_vendor_list_id`) REFERENCES `airlines_ecm`.`procurement`.`approved_vendor_list`(`approved_vendor_list_id`);
ALTER TABLE `airlines_ecm`.`procurement`.`spend_record` ADD CONSTRAINT `fk_procurement_spend_record_procurement_category_id` FOREIGN KEY (`procurement_category_id`) REFERENCES `airlines_ecm`.`procurement`.`procurement_category`(`procurement_category_id`);
ALTER TABLE `airlines_ecm`.`procurement`.`spend_record` ADD CONSTRAINT `fk_procurement_spend_record_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `airlines_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `airlines_ecm`.`procurement`.`spend_record` ADD CONSTRAINT `fk_procurement_spend_record_supply_contract_id` FOREIGN KEY (`supply_contract_id`) REFERENCES `airlines_ecm`.`procurement`.`supply_contract`(`supply_contract_id`);
ALTER TABLE `airlines_ecm`.`procurement`.`spend_record` ADD CONSTRAINT `fk_procurement_spend_record_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `airlines_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `airlines_ecm`.`procurement`.`spend_record` ADD CONSTRAINT `fk_procurement_spend_record_vendor_invoice_id` FOREIGN KEY (`vendor_invoice_id`) REFERENCES `airlines_ecm`.`procurement`.`vendor_invoice`(`vendor_invoice_id`);
ALTER TABLE `airlines_ecm`.`procurement`.`spend_record` ADD CONSTRAINT `fk_procurement_spend_record_reversal_spend_record_id` FOREIGN KEY (`reversal_spend_record_id`) REFERENCES `airlines_ecm`.`procurement`.`spend_record`(`spend_record_id`);
ALTER TABLE `airlines_ecm`.`procurement`.`ground_service_order` ADD CONSTRAINT `fk_procurement_ground_service_order_supply_contract_id` FOREIGN KEY (`supply_contract_id`) REFERENCES `airlines_ecm`.`procurement`.`supply_contract`(`supply_contract_id`);
ALTER TABLE `airlines_ecm`.`procurement`.`ground_service_order` ADD CONSTRAINT `fk_procurement_ground_service_order_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `airlines_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `airlines_ecm`.`procurement`.`ground_service_order` ADD CONSTRAINT `fk_procurement_ground_service_order_amended_ground_service_order_id` FOREIGN KEY (`amended_ground_service_order_id`) REFERENCES `airlines_ecm`.`procurement`.`ground_service_order`(`ground_service_order_id`);
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_audit` ADD CONSTRAINT `fk_procurement_vendor_audit_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `airlines_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_audit` ADD CONSTRAINT `fk_procurement_vendor_audit_follow_up_vendor_audit_id` FOREIGN KEY (`follow_up_vendor_audit_id`) REFERENCES `airlines_ecm`.`procurement`.`vendor_audit`(`vendor_audit_id`);
ALTER TABLE `airlines_ecm`.`procurement`.`contract_price_schedule` ADD CONSTRAINT `fk_procurement_contract_price_schedule_part_master_id` FOREIGN KEY (`part_master_id`) REFERENCES `airlines_ecm`.`procurement`.`part_master`(`part_master_id`);
ALTER TABLE `airlines_ecm`.`procurement`.`contract_price_schedule` ADD CONSTRAINT `fk_procurement_contract_price_schedule_superseded_by_schedule_contract_price_schedule_id` FOREIGN KEY (`superseded_by_schedule_contract_price_schedule_id`) REFERENCES `airlines_ecm`.`procurement`.`contract_price_schedule`(`contract_price_schedule_id`);
ALTER TABLE `airlines_ecm`.`procurement`.`contract_price_schedule` ADD CONSTRAINT `fk_procurement_contract_price_schedule_supply_contract_id` FOREIGN KEY (`supply_contract_id`) REFERENCES `airlines_ecm`.`procurement`.`supply_contract`(`supply_contract_id`);
ALTER TABLE `airlines_ecm`.`procurement`.`contract_price_schedule` ADD CONSTRAINT `fk_procurement_contract_price_schedule_superseded_contract_price_schedule_id` FOREIGN KEY (`superseded_contract_price_schedule_id`) REFERENCES `airlines_ecm`.`procurement`.`contract_price_schedule`(`contract_price_schedule_id`);
ALTER TABLE `airlines_ecm`.`procurement`.`mro_exchange_order` ADD CONSTRAINT `fk_procurement_mro_exchange_order_part_master_id` FOREIGN KEY (`part_master_id`) REFERENCES `airlines_ecm`.`procurement`.`part_master`(`part_master_id`);
ALTER TABLE `airlines_ecm`.`procurement`.`mro_exchange_order` ADD CONSTRAINT `fk_procurement_mro_exchange_order_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `airlines_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `airlines_ecm`.`procurement`.`mro_exchange_order` ADD CONSTRAINT `fk_procurement_mro_exchange_order_return_mro_exchange_order_id` FOREIGN KEY (`return_mro_exchange_order_id`) REFERENCES `airlines_ecm`.`procurement`.`mro_exchange_order`(`mro_exchange_order_id`);
ALTER TABLE `airlines_ecm`.`procurement`.`repair_order` ADD CONSTRAINT `fk_procurement_repair_order_part_master_id` FOREIGN KEY (`part_master_id`) REFERENCES `airlines_ecm`.`procurement`.`part_master`(`part_master_id`);
ALTER TABLE `airlines_ecm`.`procurement`.`repair_order` ADD CONSTRAINT `fk_procurement_repair_order_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `airlines_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `airlines_ecm`.`procurement`.`repair_order` ADD CONSTRAINT `fk_procurement_repair_order_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `airlines_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `airlines_ecm`.`procurement`.`repair_order` ADD CONSTRAINT `fk_procurement_repair_order_rework_repair_order_id` FOREIGN KEY (`rework_repair_order_id`) REFERENCES `airlines_ecm`.`procurement`.`repair_order`(`repair_order_id`);
ALTER TABLE `airlines_ecm`.`procurement`.`savings_initiative` ADD CONSTRAINT `fk_procurement_savings_initiative_procurement_category_id` FOREIGN KEY (`procurement_category_id`) REFERENCES `airlines_ecm`.`procurement`.`procurement_category`(`procurement_category_id`);
ALTER TABLE `airlines_ecm`.`procurement`.`savings_initiative` ADD CONSTRAINT `fk_procurement_savings_initiative_sourcing_event_id` FOREIGN KEY (`sourcing_event_id`) REFERENCES `airlines_ecm`.`procurement`.`sourcing_event`(`sourcing_event_id`);
ALTER TABLE `airlines_ecm`.`procurement`.`savings_initiative` ADD CONSTRAINT `fk_procurement_savings_initiative_supply_contract_id` FOREIGN KEY (`supply_contract_id`) REFERENCES `airlines_ecm`.`procurement`.`supply_contract`(`supply_contract_id`);
ALTER TABLE `airlines_ecm`.`procurement`.`savings_initiative` ADD CONSTRAINT `fk_procurement_savings_initiative_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `airlines_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `airlines_ecm`.`procurement`.`savings_initiative` ADD CONSTRAINT `fk_procurement_savings_initiative_parent_savings_initiative_id` FOREIGN KEY (`parent_savings_initiative_id`) REFERENCES `airlines_ecm`.`procurement`.`savings_initiative`(`savings_initiative_id`);
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_category_qualification` ADD CONSTRAINT `fk_procurement_vendor_category_qualification_category_procurement_category_id` FOREIGN KEY (`category_procurement_category_id`) REFERENCES `airlines_ecm`.`procurement`.`procurement_category`(`procurement_category_id`);
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_category_qualification` ADD CONSTRAINT `fk_procurement_vendor_category_qualification_procurement_category_id` FOREIGN KEY (`procurement_category_id`) REFERENCES `airlines_ecm`.`procurement`.`procurement_category`(`procurement_category_id`);
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_category_qualification` ADD CONSTRAINT `fk_procurement_vendor_category_qualification_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `airlines_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_audit_schedule` ADD CONSTRAINT `fk_procurement_vendor_audit_schedule_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `airlines_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_authorization` ADD CONSTRAINT `fk_procurement_vendor_authorization_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `airlines_ecm`.`procurement`.`vendor`(`vendor_id`);

-- ========= TAGS =========
ALTER SCHEMA `airlines_ecm`.`procurement` SET TAGS ('dbx_division' = 'corporate');
ALTER SCHEMA `airlines_ecm`.`procurement` SET TAGS ('dbx_domain' = 'procurement');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor` SET TAGS ('dbx_subdomain' = 'supplier_management');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Identifier');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor` ALTER COLUMN `parent_vendor_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor` ALTER COLUMN `as9100_certified` SET TAGS ('dbx_business_glossary_term' = 'AS9100 Aerospace Quality Certification Status');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor` ALTER COLUMN `bank_account_number` SET TAGS ('dbx_business_glossary_term' = 'Vendor Bank Account Number');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor` ALTER COLUMN `bank_account_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor` ALTER COLUMN `bank_account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor` ALTER COLUMN `bank_name` SET TAGS ('dbx_business_glossary_term' = 'Vendor Bank Name');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor` ALTER COLUMN `bank_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor` ALTER COLUMN `bank_swift_code` SET TAGS ('dbx_business_glossary_term' = 'Bank SWIFT Code');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor` ALTER COLUMN `bank_swift_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{6}[A-Z0-9]{2}([A-Z0-9]{3})?$');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor` ALTER COLUMN `bank_swift_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor` ALTER COLUMN `blacklist_flag` SET TAGS ('dbx_business_glossary_term' = 'Vendor Blacklist Flag');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor` ALTER COLUMN `country_of_incorporation` SET TAGS ('dbx_business_glossary_term' = 'Country of Incorporation');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor` ALTER COLUMN `country_of_incorporation` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor` ALTER COLUMN `credit_limit_amount` SET TAGS ('dbx_business_glossary_term' = 'Credit Limit Amount');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor` ALTER COLUMN `credit_limit_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor` ALTER COLUMN `duns_number` SET TAGS ('dbx_business_glossary_term' = 'Data Universal Numbering System (DUNS) Number');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor` ALTER COLUMN `duns_number` SET TAGS ('dbx_value_regex' = '^[0-9]{9}$');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor` ALTER COLUMN `easa_part145_approved` SET TAGS ('dbx_business_glossary_term' = 'European Union Aviation Safety Agency (EASA) Part-145 Approval Status');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor` ALTER COLUMN `faa_repair_station_certified` SET TAGS ('dbx_business_glossary_term' = 'Federal Aviation Administration (FAA) Repair Station Certification Status');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor` ALTER COLUMN `iata_vendor_code` SET TAGS ('dbx_business_glossary_term' = 'International Air Transport Association (IATA) Vendor Code');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor` ALTER COLUMN `iata_vendor_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,8}$');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor` ALTER COLUMN `iso9001_certified` SET TAGS ('dbx_business_glossary_term' = 'ISO 9001 Quality Management Certification Status');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor` ALTER COLUMN `last_performance_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Performance Review Date');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor` ALTER COLUMN `legal_name` SET TAGS ('dbx_business_glossary_term' = 'Vendor Legal Name');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor` ALTER COLUMN `minority_owned_flag` SET TAGS ('dbx_business_glossary_term' = 'Minority-Owned Business Flag');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor` ALTER COLUMN `onboarding_date` SET TAGS ('dbx_business_glossary_term' = 'Vendor Onboarding Date');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor` ALTER COLUMN `payment_terms_days` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms in Days');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor` ALTER COLUMN `preferred_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Preferred Currency Code');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor` ALTER COLUMN `preferred_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Email Address');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Name');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Phone Number');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor` ALTER COLUMN `registered_address_line1` SET TAGS ('dbx_business_glossary_term' = 'Registered Address Line 1');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor` ALTER COLUMN `registered_address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor` ALTER COLUMN `registered_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor` ALTER COLUMN `registered_address_line2` SET TAGS ('dbx_business_glossary_term' = 'Registered Address Line 2');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor` ALTER COLUMN `registered_address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor` ALTER COLUMN `registered_address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor` ALTER COLUMN `registered_city` SET TAGS ('dbx_business_glossary_term' = 'Registered City');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor` ALTER COLUMN `registered_city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor` ALTER COLUMN `registered_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor` ALTER COLUMN `registered_country` SET TAGS ('dbx_business_glossary_term' = 'Registered Country');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor` ALTER COLUMN `registered_country` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor` ALTER COLUMN `registered_country` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor` ALTER COLUMN `registered_country` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor` ALTER COLUMN `registered_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Registered Postal Code');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor` ALTER COLUMN `registered_postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor` ALTER COLUMN `registered_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor` ALTER COLUMN `registered_state_province` SET TAGS ('dbx_business_glossary_term' = 'Registered State or Province');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor` ALTER COLUMN `registered_state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor` ALTER COLUMN `registered_state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor` ALTER COLUMN `small_business_flag` SET TAGS ('dbx_business_glossary_term' = 'Small Business Flag');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_business_glossary_term' = 'Tax Identification Number (TIN)');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor` ALTER COLUMN `trade_name` SET TAGS ('dbx_business_glossary_term' = 'Vendor Trade Name');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor` ALTER COLUMN `vat_registration_number` SET TAGS ('dbx_business_glossary_term' = 'Value Added Tax (VAT) Registration Number');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor` ALTER COLUMN `vat_registration_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor` ALTER COLUMN `vendor_status` SET TAGS ('dbx_business_glossary_term' = 'Vendor Status');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor` ALTER COLUMN `vendor_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|pending_approval');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor` ALTER COLUMN `vendor_tier` SET TAGS ('dbx_business_glossary_term' = 'Vendor Tier Classification');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor` ALTER COLUMN `vendor_tier` SET TAGS ('dbx_value_regex' = 'strategic|preferred|approved|conditional');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor` ALTER COLUMN `vendor_type` SET TAGS ('dbx_business_glossary_term' = 'Vendor Type Classification');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor` ALTER COLUMN `vendor_type` SET TAGS ('dbx_value_regex' = 'MRO|fuel|catering|ground_services|IT|consumables');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor` ALTER COLUMN `website_url` SET TAGS ('dbx_business_glossary_term' = 'Vendor Website URL');
ALTER TABLE `airlines_ecm`.`procurement`.`purchase_order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `airlines_ecm`.`procurement`.`purchase_order` SET TAGS ('dbx_subdomain' = 'order_processing');
ALTER TABLE `airlines_ecm`.`procurement`.`purchase_order` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) ID');
ALTER TABLE `airlines_ecm`.`procurement`.`purchase_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Buyer ID');
ALTER TABLE `airlines_ecm`.`procurement`.`purchase_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`procurement`.`purchase_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `airlines_ecm`.`procurement`.`purchase_order` ALTER COLUMN `procurement_category_id` SET TAGS ('dbx_business_glossary_term' = 'Procurement Category Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`procurement`.`purchase_order` ALTER COLUMN `sourcing_event_id` SET TAGS ('dbx_business_glossary_term' = 'Sourcing Event Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`procurement`.`purchase_order` ALTER COLUMN `supply_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Supply Contract Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`procurement`.`purchase_order` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `airlines_ecm`.`procurement`.`purchase_order` ALTER COLUMN `blanket_purchase_order_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `airlines_ecm`.`procurement`.`purchase_order` ALTER COLUMN `approval_authority_level` SET TAGS ('dbx_business_glossary_term' = 'Approval Authority Level');
ALTER TABLE `airlines_ecm`.`procurement`.`purchase_order` ALTER COLUMN `approval_authority_level` SET TAGS ('dbx_value_regex' = 'buyer|supervisor|manager|director|vp|cfo');
ALTER TABLE `airlines_ecm`.`procurement`.`purchase_order` ALTER COLUMN `approval_workflow_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Workflow Status');
ALTER TABLE `airlines_ecm`.`procurement`.`purchase_order` ALTER COLUMN `approval_workflow_status` SET TAGS ('dbx_value_regex' = 'not_submitted|pending_level_1|pending_level_2|pending_level_3|approved|rejected');
ALTER TABLE `airlines_ecm`.`procurement`.`purchase_order` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `airlines_ecm`.`procurement`.`purchase_order` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `airlines_ecm`.`procurement`.`purchase_order` ALTER COLUMN `cancelled_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Cancelled Timestamp');
ALTER TABLE `airlines_ecm`.`procurement`.`purchase_order` ALTER COLUMN `closed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Closed Timestamp');
ALTER TABLE `airlines_ecm`.`procurement`.`purchase_order` ALTER COLUMN `confirmed_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Confirmed Delivery Date');
ALTER TABLE `airlines_ecm`.`procurement`.`purchase_order` ALTER COLUMN `cost_center` SET TAGS ('dbx_business_glossary_term' = 'Cost Center');
ALTER TABLE `airlines_ecm`.`procurement`.`purchase_order` ALTER COLUMN `cost_center` SET TAGS ('dbx_value_regex' = '^CC[0-9]{6,10}$');
ALTER TABLE `airlines_ecm`.`procurement`.`purchase_order` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `airlines_ecm`.`procurement`.`purchase_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `airlines_ecm`.`procurement`.`purchase_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`procurement`.`purchase_order` ALTER COLUMN `delivery_address` SET TAGS ('dbx_business_glossary_term' = 'Delivery Address');
ALTER TABLE `airlines_ecm`.`procurement`.`purchase_order` ALTER COLUMN `delivery_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`procurement`.`purchase_order` ALTER COLUMN `delivery_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `airlines_ecm`.`procurement`.`purchase_order` ALTER COLUMN `delivery_address_type` SET TAGS ('dbx_business_glossary_term' = 'Delivery Address Type');
ALTER TABLE `airlines_ecm`.`procurement`.`purchase_order` ALTER COLUMN `delivery_address_type` SET TAGS ('dbx_value_regex' = 'station|base|maintenance_facility|warehouse|headquarters|vendor_managed');
ALTER TABLE `airlines_ecm`.`procurement`.`purchase_order` ALTER COLUMN `delivery_station_code` SET TAGS ('dbx_business_glossary_term' = 'Delivery Station Code');
ALTER TABLE `airlines_ecm`.`procurement`.`purchase_order` ALTER COLUMN `delivery_station_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`procurement`.`purchase_order` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate');
ALTER TABLE `airlines_ecm`.`procurement`.`purchase_order` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `airlines_ecm`.`procurement`.`purchase_order` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_value_regex' = '^[0-9]{6,10}$');
ALTER TABLE `airlines_ecm`.`procurement`.`purchase_order` ALTER COLUMN `incoterm` SET TAGS ('dbx_business_glossary_term' = 'Incoterm');
ALTER TABLE `airlines_ecm`.`procurement`.`purchase_order` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `airlines_ecm`.`procurement`.`purchase_order` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Notes');
ALTER TABLE `airlines_ecm`.`procurement`.`purchase_order` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `airlines_ecm`.`procurement`.`purchase_order` ALTER COLUMN `po_date` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Date');
ALTER TABLE `airlines_ecm`.`procurement`.`purchase_order` ALTER COLUMN `po_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Number');
ALTER TABLE `airlines_ecm`.`procurement`.`purchase_order` ALTER COLUMN `po_number` SET TAGS ('dbx_value_regex' = '^PO[0-9]{8,12}$');
ALTER TABLE `airlines_ecm`.`procurement`.`purchase_order` ALTER COLUMN `po_status` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Status');
ALTER TABLE `airlines_ecm`.`procurement`.`purchase_order` ALTER COLUMN `po_type` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Type');
ALTER TABLE `airlines_ecm`.`procurement`.`purchase_order` ALTER COLUMN `po_type` SET TAGS ('dbx_value_regex' = 'standard|blanket|framework|emergency_aog|contract_release|spot');
ALTER TABLE `airlines_ecm`.`procurement`.`purchase_order` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `airlines_ecm`.`procurement`.`purchase_order` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'routine|high|urgent|aog_critical');
ALTER TABLE `airlines_ecm`.`procurement`.`purchase_order` ALTER COLUMN `requested_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Requested Delivery Date');
ALTER TABLE `airlines_ecm`.`procurement`.`purchase_order` ALTER COLUMN `requisition_reference` SET TAGS ('dbx_business_glossary_term' = 'Requisition Reference');
ALTER TABLE `airlines_ecm`.`procurement`.`purchase_order` ALTER COLUMN `sent_to_vendor_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Sent to Vendor Timestamp');
ALTER TABLE `airlines_ecm`.`procurement`.`purchase_order` ALTER COLUMN `shipping_method` SET TAGS ('dbx_business_glossary_term' = 'Shipping Method');
ALTER TABLE `airlines_ecm`.`procurement`.`purchase_order` ALTER COLUMN `shipping_method` SET TAGS ('dbx_value_regex' = 'air_freight|sea_freight|ground|courier|vendor_delivery|aog_charter');
ALTER TABLE `airlines_ecm`.`procurement`.`purchase_order` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `airlines_ecm`.`procurement`.`purchase_order` ALTER COLUMN `total_po_value` SET TAGS ('dbx_business_glossary_term' = 'Total Purchase Order (PO) Value');
ALTER TABLE `airlines_ecm`.`procurement`.`purchase_order` ALTER COLUMN `total_po_value_including_tax` SET TAGS ('dbx_business_glossary_term' = 'Total Purchase Order (PO) Value Including Tax');
ALTER TABLE `airlines_ecm`.`procurement`.`po_line` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `airlines_ecm`.`procurement`.`po_line` SET TAGS ('dbx_subdomain' = 'order_processing');
ALTER TABLE `airlines_ecm`.`procurement`.`po_line` ALTER COLUMN `po_line_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Line Identifier');
ALTER TABLE `airlines_ecm`.`procurement`.`po_line` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Requisitioner Identifier');
ALTER TABLE `airlines_ecm`.`procurement`.`po_line` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`procurement`.`po_line` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `airlines_ecm`.`procurement`.`po_line` ALTER COLUMN `material_part_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Identifier');
ALTER TABLE `airlines_ecm`.`procurement`.`po_line` ALTER COLUMN `part_master_id` SET TAGS ('dbx_business_glossary_term' = 'Part Master Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`procurement`.`po_line` ALTER COLUMN `procurement_category_id` SET TAGS ('dbx_business_glossary_term' = 'Procurement Category Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`procurement`.`po_line` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Header Identifier');
ALTER TABLE `airlines_ecm`.`procurement`.`po_line` ALTER COLUMN `parent_po_line_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `airlines_ecm`.`procurement`.`po_line` ALTER COLUMN `aircraft_type` SET TAGS ('dbx_business_glossary_term' = 'Aircraft Type');
ALTER TABLE `airlines_ecm`.`procurement`.`po_line` ALTER COLUMN `ata_chapter` SET TAGS ('dbx_business_glossary_term' = 'Air Transport Association (ATA) Chapter Code');
ALTER TABLE `airlines_ecm`.`procurement`.`po_line` ALTER COLUMN `ata_chapter` SET TAGS ('dbx_value_regex' = '^[0-9]{2}(-[0-9]{2}(-[0-9]{2})?)?$');
ALTER TABLE `airlines_ecm`.`procurement`.`po_line` ALTER COLUMN `cost_center` SET TAGS ('dbx_business_glossary_term' = 'Cost Center');
ALTER TABLE `airlines_ecm`.`procurement`.`po_line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `airlines_ecm`.`procurement`.`po_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `airlines_ecm`.`procurement`.`po_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`procurement`.`po_line` ALTER COLUMN `deletion_indicator` SET TAGS ('dbx_business_glossary_term' = 'Deletion Indicator');
ALTER TABLE `airlines_ecm`.`procurement`.`po_line` ALTER COLUMN `delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Delivery Date');
ALTER TABLE `airlines_ecm`.`procurement`.`po_line` ALTER COLUMN `delivery_tolerance_percent` SET TAGS ('dbx_business_glossary_term' = 'Delivery Tolerance Percentage');
ALTER TABLE `airlines_ecm`.`procurement`.`po_line` ALTER COLUMN `final_invoice_flag` SET TAGS ('dbx_business_glossary_term' = 'Final Invoice Flag');
ALTER TABLE `airlines_ecm`.`procurement`.`po_line` ALTER COLUMN `gl_account` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account');
ALTER TABLE `airlines_ecm`.`procurement`.`po_line` ALTER COLUMN `goods_receipt_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt (GR) Required Flag');
ALTER TABLE `airlines_ecm`.`procurement`.`po_line` ALTER COLUMN `gross_amount` SET TAGS ('dbx_business_glossary_term' = 'Gross Amount');
ALTER TABLE `airlines_ecm`.`procurement`.`po_line` ALTER COLUMN `hazmat_flag` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Material (HAZMAT) Flag');
ALTER TABLE `airlines_ecm`.`procurement`.`po_line` ALTER COLUMN `incoterm` SET TAGS ('dbx_business_glossary_term' = 'International Commercial Terms (Incoterms)');
ALTER TABLE `airlines_ecm`.`procurement`.`po_line` ALTER COLUMN `invoice_receipt_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Invoice Receipt (IR) Required Flag');
ALTER TABLE `airlines_ecm`.`procurement`.`po_line` ALTER COLUMN `line_number` SET TAGS ('dbx_business_glossary_term' = 'Line Number');
ALTER TABLE `airlines_ecm`.`procurement`.`po_line` ALTER COLUMN `line_status` SET TAGS ('dbx_business_glossary_term' = 'Line Status');
ALTER TABLE `airlines_ecm`.`procurement`.`po_line` ALTER COLUMN `line_status` SET TAGS ('dbx_value_regex' = 'open|partially_received|fully_received|cancelled|closed');
ALTER TABLE `airlines_ecm`.`procurement`.`po_line` ALTER COLUMN `long_text` SET TAGS ('dbx_business_glossary_term' = 'Long Text Description');
ALTER TABLE `airlines_ecm`.`procurement`.`po_line` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `airlines_ecm`.`procurement`.`po_line` ALTER COLUMN `net_price` SET TAGS ('dbx_business_glossary_term' = 'Net Price');
ALTER TABLE `airlines_ecm`.`procurement`.`po_line` ALTER COLUMN `open_quantity` SET TAGS ('dbx_business_glossary_term' = 'Open Quantity');
ALTER TABLE `airlines_ecm`.`procurement`.`po_line` ALTER COLUMN `plant_code` SET TAGS ('dbx_business_glossary_term' = 'Plant Code');
ALTER TABLE `airlines_ecm`.`procurement`.`po_line` ALTER COLUMN `quantity_invoiced` SET TAGS ('dbx_business_glossary_term' = 'Quantity Invoiced');
ALTER TABLE `airlines_ecm`.`procurement`.`po_line` ALTER COLUMN `quantity_ordered` SET TAGS ('dbx_business_glossary_term' = 'Quantity Ordered');
ALTER TABLE `airlines_ecm`.`procurement`.`po_line` ALTER COLUMN `quantity_received` SET TAGS ('dbx_business_glossary_term' = 'Quantity Received');
ALTER TABLE `airlines_ecm`.`procurement`.`po_line` ALTER COLUMN `short_text` SET TAGS ('dbx_business_glossary_term' = 'Short Text Description');
ALTER TABLE `airlines_ecm`.`procurement`.`po_line` ALTER COLUMN `storage_location` SET TAGS ('dbx_business_glossary_term' = 'Storage Location');
ALTER TABLE `airlines_ecm`.`procurement`.`po_line` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `airlines_ecm`.`procurement`.`po_line` ALTER COLUMN `un_number` SET TAGS ('dbx_business_glossary_term' = 'United Nations (UN) Number');
ALTER TABLE `airlines_ecm`.`procurement`.`po_line` ALTER COLUMN `un_number` SET TAGS ('dbx_value_regex' = '^UN[0-9]{4}$');
ALTER TABLE `airlines_ecm`.`procurement`.`po_line` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `airlines_ecm`.`procurement`.`po_line` ALTER COLUMN `unit_price` SET TAGS ('dbx_business_glossary_term' = 'Unit Price');
ALTER TABLE `airlines_ecm`.`procurement`.`goods_receipt` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `airlines_ecm`.`procurement`.`goods_receipt` SET TAGS ('dbx_subdomain' = 'order_processing');
ALTER TABLE `airlines_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `goods_receipt_id` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt (GR) ID');
ALTER TABLE `airlines_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `part_master_id` SET TAGS ('dbx_business_glossary_term' = 'Part Master Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `po_line_id` SET TAGS ('dbx_business_glossary_term' = 'Po Line Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) ID');
ALTER TABLE `airlines_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Received By Employee ID');
ALTER TABLE `airlines_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `airlines_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `airlines_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `correction_goods_receipt_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `airlines_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `airworthiness_certificate_number` SET TAGS ('dbx_business_glossary_term' = 'Airworthiness Certificate Number');
ALTER TABLE `airlines_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Number');
ALTER TABLE `airlines_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `certificate_of_conformance_number` SET TAGS ('dbx_business_glossary_term' = 'Certificate of Conformance (CoC) Number');
ALTER TABLE `airlines_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `condition_on_receipt` SET TAGS ('dbx_business_glossary_term' = 'Condition on Receipt');
ALTER TABLE `airlines_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `condition_on_receipt` SET TAGS ('dbx_value_regex' = 'serviceable|unserviceable|damaged|quarantine|as_is|repairable');
ALTER TABLE `airlines_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `airlines_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `airlines_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `delivery_note_date` SET TAGS ('dbx_business_glossary_term' = 'Delivery Note Date');
ALTER TABLE `airlines_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `gr_document_number` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt (GR) Document Number');
ALTER TABLE `airlines_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `gr_document_number` SET TAGS ('dbx_value_regex' = '^GR[0-9]{10}$');
ALTER TABLE `airlines_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `gr_status` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt (GR) Status');
ALTER TABLE `airlines_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `gr_status` SET TAGS ('dbx_value_regex' = 'posted|reversed|cancelled|under_inspection|pending|completed');
ALTER TABLE `airlines_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `inspection_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Inspection Required Flag');
ALTER TABLE `airlines_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `airlines_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `movement_type` SET TAGS ('dbx_business_glossary_term' = 'Movement Type');
ALTER TABLE `airlines_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `note` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt Note');
ALTER TABLE `airlines_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `po_line_item_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Line Item Number');
ALTER TABLE `airlines_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `quarantine_flag` SET TAGS ('dbx_business_glossary_term' = 'Quarantine Flag');
ALTER TABLE `airlines_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `received_quantity` SET TAGS ('dbx_business_glossary_term' = 'Received Quantity');
ALTER TABLE `airlines_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `receiving_date` SET TAGS ('dbx_business_glossary_term' = 'Receiving Date');
ALTER TABLE `airlines_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `receiving_station_code` SET TAGS ('dbx_business_glossary_term' = 'Receiving Station Code');
ALTER TABLE `airlines_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `receiving_station_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `receiving_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Receiving Timestamp');
ALTER TABLE `airlines_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `reversal_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Reversal Reason Code');
ALTER TABLE `airlines_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `reversal_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Reversal Timestamp');
ALTER TABLE `airlines_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `serial_number` SET TAGS ('dbx_business_glossary_term' = 'Serial Number');
ALTER TABLE `airlines_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `shelf_life_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Shelf Life Expiration Date');
ALTER TABLE `airlines_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `storage_location_code` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Code');
ALTER TABLE `airlines_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `three_way_match_status` SET TAGS ('dbx_business_glossary_term' = 'Three-Way Match Status');
ALTER TABLE `airlines_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `three_way_match_status` SET TAGS ('dbx_value_regex' = 'matched|variance|pending|blocked|approved');
ALTER TABLE `airlines_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `airlines_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `valuation_amount` SET TAGS ('dbx_business_glossary_term' = 'Valuation Amount');
ALTER TABLE `airlines_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `vendor_delivery_note_number` SET TAGS ('dbx_business_glossary_term' = 'Vendor Delivery Note Number');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_invoice` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_invoice` SET TAGS ('dbx_subdomain' = 'order_processing');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_invoice` ALTER COLUMN `vendor_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Invoice ID');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_invoice` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Employee Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_invoice` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_invoice` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_invoice` ALTER COLUMN `goods_receipt_id` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_invoice` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) ID');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_invoice` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_invoice` ALTER COLUMN `credit_note_vendor_invoice_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_invoice` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_invoice` ALTER COLUMN `blocking_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Blocking Reason Code');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_invoice` ALTER COLUMN `company_code` SET TAGS ('dbx_business_glossary_term' = 'Company Code');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_invoice` ALTER COLUMN `cost_center` SET TAGS ('dbx_business_glossary_term' = 'Cost Center');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_invoice` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_invoice` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_invoice` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_invoice` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_invoice` ALTER COLUMN `dispute_reason` SET TAGS ('dbx_business_glossary_term' = 'Dispute Reason');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_invoice` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_invoice` ALTER COLUMN `goods_receipt_date` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt (GR) Date');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_invoice` ALTER COLUMN `gross_amount` SET TAGS ('dbx_business_glossary_term' = 'Gross Invoice Amount');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_invoice` ALTER COLUMN `internal_document_number` SET TAGS ('dbx_business_glossary_term' = 'Internal Document Number');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_invoice` ALTER COLUMN `invoice_date` SET TAGS ('dbx_business_glossary_term' = 'Invoice Date');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_invoice` ALTER COLUMN `invoice_received_date` SET TAGS ('dbx_business_glossary_term' = 'Invoice Received Date');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_invoice` ALTER COLUMN `invoice_status` SET TAGS ('dbx_business_glossary_term' = 'Invoice Status');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_invoice` ALTER COLUMN `invoice_type` SET TAGS ('dbx_business_glossary_term' = 'Invoice Type');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_invoice` ALTER COLUMN `invoice_type` SET TAGS ('dbx_value_regex' = 'standard|credit_memo|debit_memo|prepayment|final');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_invoice` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_invoice` ALTER COLUMN `net_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Invoice Amount');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_invoice` ALTER COLUMN `payment_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Date');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_invoice` ALTER COLUMN `payment_due_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Due Date');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_invoice` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_invoice` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'wire_transfer|ach|check|credit_card|bsp|arc');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_invoice` ALTER COLUMN `payment_run_reference` SET TAGS ('dbx_business_glossary_term' = 'Payment Run Reference');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_invoice` ALTER COLUMN `payment_terms_code` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms Code');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_invoice` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Date');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_invoice` ALTER COLUMN `procurement_category` SET TAGS ('dbx_business_glossary_term' = 'Procurement Category');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_invoice` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_invoice` ALTER COLUMN `tax_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Code');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_invoice` ALTER COLUMN `three_way_match_status` SET TAGS ('dbx_business_glossary_term' = 'Three-Way Match Status');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_invoice` ALTER COLUMN `three_way_match_status` SET TAGS ('dbx_value_regex' = 'matched|quantity_variance|price_variance|not_matched|bypassed');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_invoice` ALTER COLUMN `vendor_invoice_number` SET TAGS ('dbx_business_glossary_term' = 'Vendor Invoice Number');
ALTER TABLE `airlines_ecm`.`procurement`.`supply_contract` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `airlines_ecm`.`procurement`.`supply_contract` SET TAGS ('dbx_subdomain' = 'supplier_management');
ALTER TABLE `airlines_ecm`.`procurement`.`supply_contract` ALTER COLUMN `supply_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Supply Contract Identifier (ID)');
ALTER TABLE `airlines_ecm`.`procurement`.`supply_contract` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Owner Employee Identifier (ID)');
ALTER TABLE `airlines_ecm`.`procurement`.`supply_contract` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`procurement`.`supply_contract` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `airlines_ecm`.`procurement`.`supply_contract` ALTER COLUMN `procurement_category_id` SET TAGS ('dbx_business_glossary_term' = 'Procurement Category Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`procurement`.`supply_contract` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Identifier (ID)');
ALTER TABLE `airlines_ecm`.`procurement`.`supply_contract` ALTER COLUMN `renewed_supply_contract_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `airlines_ecm`.`procurement`.`supply_contract` ALTER COLUMN `amendment_count` SET TAGS ('dbx_business_glossary_term' = 'Amendment Count');
ALTER TABLE `airlines_ecm`.`procurement`.`supply_contract` ALTER COLUMN `annual_committed_spend` SET TAGS ('dbx_business_glossary_term' = 'Annual Committed Spend');
ALTER TABLE `airlines_ecm`.`procurement`.`supply_contract` ALTER COLUMN `annual_committed_spend` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`procurement`.`supply_contract` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `airlines_ecm`.`procurement`.`supply_contract` ALTER COLUMN `auto_renewal_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto-Renewal Flag');
ALTER TABLE `airlines_ecm`.`procurement`.`supply_contract` ALTER COLUMN `confidentiality_clause_flag` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Clause Flag');
ALTER TABLE `airlines_ecm`.`procurement`.`supply_contract` ALTER COLUMN `contract_number` SET TAGS ('dbx_business_glossary_term' = 'Contract Number');
ALTER TABLE `airlines_ecm`.`procurement`.`supply_contract` ALTER COLUMN `contract_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,20}$');
ALTER TABLE `airlines_ecm`.`procurement`.`supply_contract` ALTER COLUMN `contract_status` SET TAGS ('dbx_business_glossary_term' = 'Contract Status');
ALTER TABLE `airlines_ecm`.`procurement`.`supply_contract` ALTER COLUMN `contract_title` SET TAGS ('dbx_business_glossary_term' = 'Contract Title');
ALTER TABLE `airlines_ecm`.`procurement`.`supply_contract` ALTER COLUMN `contract_type` SET TAGS ('dbx_business_glossary_term' = 'Contract Type');
ALTER TABLE `airlines_ecm`.`procurement`.`supply_contract` ALTER COLUMN `contract_type` SET TAGS ('dbx_value_regex' = 'fixed_price|time_and_material|framework|blanket_order|sla_based|cost_plus');
ALTER TABLE `airlines_ecm`.`procurement`.`supply_contract` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `airlines_ecm`.`procurement`.`supply_contract` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `airlines_ecm`.`procurement`.`supply_contract` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`procurement`.`supply_contract` ALTER COLUMN `dispute_resolution_method` SET TAGS ('dbx_business_glossary_term' = 'Dispute Resolution Method');
ALTER TABLE `airlines_ecm`.`procurement`.`supply_contract` ALTER COLUMN `dispute_resolution_method` SET TAGS ('dbx_value_regex' = 'litigation|arbitration|mediation|negotiation');
ALTER TABLE `airlines_ecm`.`procurement`.`supply_contract` ALTER COLUMN `document_repository_reference` SET TAGS ('dbx_business_glossary_term' = 'Document Repository Reference');
ALTER TABLE `airlines_ecm`.`procurement`.`supply_contract` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `airlines_ecm`.`procurement`.`supply_contract` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `airlines_ecm`.`procurement`.`supply_contract` ALTER COLUMN `governing_law_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Governing Law Jurisdiction');
ALTER TABLE `airlines_ecm`.`procurement`.`supply_contract` ALTER COLUMN `insurance_requirement_flag` SET TAGS ('dbx_business_glossary_term' = 'Insurance Requirement Flag');
ALTER TABLE `airlines_ecm`.`procurement`.`supply_contract` ALTER COLUMN `last_amendment_date` SET TAGS ('dbx_business_glossary_term' = 'Last Amendment Date');
ALTER TABLE `airlines_ecm`.`procurement`.`supply_contract` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `airlines_ecm`.`procurement`.`supply_contract` ALTER COLUMN `legal_entity_code` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Code');
ALTER TABLE `airlines_ecm`.`procurement`.`supply_contract` ALTER COLUMN `legal_entity_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `airlines_ecm`.`procurement`.`supply_contract` ALTER COLUMN `payment_terms_days` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms (Days)');
ALTER TABLE `airlines_ecm`.`procurement`.`supply_contract` ALTER COLUMN `penalty_clauses` SET TAGS ('dbx_business_glossary_term' = 'Penalty Clauses');
ALTER TABLE `airlines_ecm`.`procurement`.`supply_contract` ALTER COLUMN `price_escalation_clause` SET TAGS ('dbx_business_glossary_term' = 'Price Escalation Clause');
ALTER TABLE `airlines_ecm`.`procurement`.`supply_contract` ALTER COLUMN `pricing_mechanism` SET TAGS ('dbx_business_glossary_term' = 'Pricing Mechanism');
ALTER TABLE `airlines_ecm`.`procurement`.`supply_contract` ALTER COLUMN `pricing_mechanism` SET TAGS ('dbx_value_regex' = 'fixed|indexed|formula_based|market_rate|negotiated');
ALTER TABLE `airlines_ecm`.`procurement`.`supply_contract` ALTER COLUMN `renewal_term_months` SET TAGS ('dbx_business_glossary_term' = 'Renewal Term (Months)');
ALTER TABLE `airlines_ecm`.`procurement`.`supply_contract` ALTER COLUMN `scope_description` SET TAGS ('dbx_business_glossary_term' = 'Scope Description');
ALTER TABLE `airlines_ecm`.`procurement`.`supply_contract` ALTER COLUMN `signed_date` SET TAGS ('dbx_business_glossary_term' = 'Signed Date');
ALTER TABLE `airlines_ecm`.`procurement`.`supply_contract` ALTER COLUMN `sla_terms_summary` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Terms Summary');
ALTER TABLE `airlines_ecm`.`procurement`.`supply_contract` ALTER COLUMN `sustainability_criteria_flag` SET TAGS ('dbx_business_glossary_term' = 'Sustainability Criteria Flag');
ALTER TABLE `airlines_ecm`.`procurement`.`supply_contract` ALTER COLUMN `termination_notice_period_days` SET TAGS ('dbx_business_glossary_term' = 'Termination Notice Period (Days)');
ALTER TABLE `airlines_ecm`.`procurement`.`supply_contract` ALTER COLUMN `total_contract_value` SET TAGS ('dbx_business_glossary_term' = 'Total Contract Value');
ALTER TABLE `airlines_ecm`.`procurement`.`supply_contract` ALTER COLUMN `total_contract_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`procurement`.`part_master` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `airlines_ecm`.`procurement`.`part_master` SET TAGS ('dbx_subdomain' = 'inventory_control');
ALTER TABLE `airlines_ecm`.`procurement`.`part_master` ALTER COLUMN `part_master_id` SET TAGS ('dbx_business_glossary_term' = 'Part Master Identifier (ID)');
ALTER TABLE `airlines_ecm`.`procurement`.`part_master` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Preferred Vendor Identifier (ID)');
ALTER TABLE `airlines_ecm`.`procurement`.`part_master` ALTER COLUMN `superseded_by_part_master_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded By Part Master Identifier (ID)');
ALTER TABLE `airlines_ecm`.`procurement`.`part_master` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Technical Owner Employee Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`procurement`.`part_master` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`procurement`.`part_master` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `airlines_ecm`.`procurement`.`part_master` ALTER COLUMN `superseded_part_master_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `airlines_ecm`.`procurement`.`part_master` ALTER COLUMN `airline_material_number` SET TAGS ('dbx_business_glossary_term' = 'Airline Internal Material Number');
ALTER TABLE `airlines_ecm`.`procurement`.`part_master` ALTER COLUMN `airline_material_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `airlines_ecm`.`procurement`.`part_master` ALTER COLUMN `airworthiness_approval_reference` SET TAGS ('dbx_business_glossary_term' = 'Airworthiness Approval Reference');
ALTER TABLE `airlines_ecm`.`procurement`.`part_master` ALTER COLUMN `ata_chapter_code` SET TAGS ('dbx_business_glossary_term' = 'Air Transport Association (ATA) Chapter Code');
ALTER TABLE `airlines_ecm`.`procurement`.`part_master` ALTER COLUMN `ata_chapter_code` SET TAGS ('dbx_value_regex' = '^[0-9]{2}$');
ALTER TABLE `airlines_ecm`.`procurement`.`part_master` ALTER COLUMN `ata_section_code` SET TAGS ('dbx_business_glossary_term' = 'Air Transport Association (ATA) Section Code');
ALTER TABLE `airlines_ecm`.`procurement`.`part_master` ALTER COLUMN `ata_section_code` SET TAGS ('dbx_value_regex' = '^[0-9]{2}-[0-9]{2}$');
ALTER TABLE `airlines_ecm`.`procurement`.`part_master` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `airlines_ecm`.`procurement`.`part_master` ALTER COLUMN `criticality_classification` SET TAGS ('dbx_business_glossary_term' = 'Criticality Classification');
ALTER TABLE `airlines_ecm`.`procurement`.`part_master` ALTER COLUMN `criticality_classification` SET TAGS ('dbx_value_regex' = 'aog_critical|flight_critical|non_critical');
ALTER TABLE `airlines_ecm`.`procurement`.`part_master` ALTER COLUMN `easa_etso_flag` SET TAGS ('dbx_business_glossary_term' = 'European Union Aviation Safety Agency (EASA) European Technical Standard Order (ETSO) Flag');
ALTER TABLE `airlines_ecm`.`procurement`.`part_master` ALTER COLUMN `easa_part_classification` SET TAGS ('dbx_business_glossary_term' = 'European Union Aviation Safety Agency (EASA) Part Classification');
ALTER TABLE `airlines_ecm`.`procurement`.`part_master` ALTER COLUMN `faa_pma_flag` SET TAGS ('dbx_business_glossary_term' = 'Federal Aviation Administration (FAA) Parts Manufacturer Approval (PMA) Flag');
ALTER TABLE `airlines_ecm`.`procurement`.`part_master` ALTER COLUMN `hazmat_classification` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Material (HAZMAT) Classification');
ALTER TABLE `airlines_ecm`.`procurement`.`part_master` ALTER COLUMN `icao_part_classification` SET TAGS ('dbx_business_glossary_term' = 'International Civil Aviation Organization (ICAO) Part Classification');
ALTER TABLE `airlines_ecm`.`procurement`.`part_master` ALTER COLUMN `interchangeable_part_group` SET TAGS ('dbx_business_glossary_term' = 'Interchangeable Part Group');
ALTER TABLE `airlines_ecm`.`procurement`.`part_master` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `airlines_ecm`.`procurement`.`part_master` ALTER COLUMN `last_purchase_date` SET TAGS ('dbx_business_glossary_term' = 'Last Purchase Date');
ALTER TABLE `airlines_ecm`.`procurement`.`part_master` ALTER COLUMN `last_purchase_price_amount` SET TAGS ('dbx_business_glossary_term' = 'Last Purchase Price Amount');
ALTER TABLE `airlines_ecm`.`procurement`.`part_master` ALTER COLUMN `last_purchase_price_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`procurement`.`part_master` ALTER COLUMN `last_purchase_price_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Last Purchase Price Currency Code');
ALTER TABLE `airlines_ecm`.`procurement`.`part_master` ALTER COLUMN `last_purchase_price_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`procurement`.`part_master` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time in Days');
ALTER TABLE `airlines_ecm`.`procurement`.`part_master` ALTER COLUMN `manufacturer_cage_code` SET TAGS ('dbx_business_glossary_term' = 'Commercial and Government Entity (CAGE) Code');
ALTER TABLE `airlines_ecm`.`procurement`.`part_master` ALTER COLUMN `manufacturer_cage_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{5}$');
ALTER TABLE `airlines_ecm`.`procurement`.`part_master` ALTER COLUMN `manufacturer_name` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Name');
ALTER TABLE `airlines_ecm`.`procurement`.`part_master` ALTER COLUMN `manufacturer_part_number` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Part Number (P/N)');
ALTER TABLE `airlines_ecm`.`procurement`.`part_master` ALTER COLUMN `manufacturer_part_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{5,30}$');
ALTER TABLE `airlines_ecm`.`procurement`.`part_master` ALTER COLUMN `minimum_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity (MOQ)');
ALTER TABLE `airlines_ecm`.`procurement`.`part_master` ALTER COLUMN `obsolescence_date` SET TAGS ('dbx_business_glossary_term' = 'Obsolescence Date');
ALTER TABLE `airlines_ecm`.`procurement`.`part_master` ALTER COLUMN `part_description` SET TAGS ('dbx_business_glossary_term' = 'Part Description');
ALTER TABLE `airlines_ecm`.`procurement`.`part_master` ALTER COLUMN `part_master_status` SET TAGS ('dbx_business_glossary_term' = 'Part Master Status');
ALTER TABLE `airlines_ecm`.`procurement`.`part_master` ALTER COLUMN `part_master_status` SET TAGS ('dbx_value_regex' = 'active|obsolete|phased_out|restricted|pending_approval');
ALTER TABLE `airlines_ecm`.`procurement`.`part_master` ALTER COLUMN `part_type` SET TAGS ('dbx_business_glossary_term' = 'Part Type Classification');
ALTER TABLE `airlines_ecm`.`procurement`.`part_master` ALTER COLUMN `part_type` SET TAGS ('dbx_value_regex' = 'rotable|repairable|expendable|consumable|raw_material');
ALTER TABLE `airlines_ecm`.`procurement`.`part_master` ALTER COLUMN `serialized_tracking_flag` SET TAGS ('dbx_business_glossary_term' = 'Serialized Tracking Flag');
ALTER TABLE `airlines_ecm`.`procurement`.`part_master` ALTER COLUMN `shelf_life_days` SET TAGS ('dbx_business_glossary_term' = 'Shelf Life in Days');
ALTER TABLE `airlines_ecm`.`procurement`.`part_master` ALTER COLUMN `standard_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Standard Cost Amount');
ALTER TABLE `airlines_ecm`.`procurement`.`part_master` ALTER COLUMN `standard_cost_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`procurement`.`part_master` ALTER COLUMN `standard_cost_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Standard Cost Currency Code');
ALTER TABLE `airlines_ecm`.`procurement`.`part_master` ALTER COLUMN `standard_cost_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`procurement`.`part_master` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `airlines_ecm`.`procurement`.`parts_inventory` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `airlines_ecm`.`procurement`.`parts_inventory` SET TAGS ('dbx_subdomain' = 'inventory_control');
ALTER TABLE `airlines_ecm`.`procurement`.`parts_inventory` ALTER COLUMN `parts_inventory_id` SET TAGS ('dbx_business_glossary_term' = 'Parts Inventory ID');
ALTER TABLE `airlines_ecm`.`procurement`.`parts_inventory` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Custodian Employee Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`procurement`.`parts_inventory` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`procurement`.`parts_inventory` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `airlines_ecm`.`procurement`.`parts_inventory` ALTER COLUMN `part_master_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `airlines_ecm`.`procurement`.`parts_inventory` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `airlines_ecm`.`procurement`.`parts_inventory` ALTER COLUMN `transferred_from_parts_inventory_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `airlines_ecm`.`procurement`.`parts_inventory` ALTER COLUMN `abc_classification` SET TAGS ('dbx_business_glossary_term' = 'ABC Classification');
ALTER TABLE `airlines_ecm`.`procurement`.`parts_inventory` ALTER COLUMN `abc_classification` SET TAGS ('dbx_value_regex' = 'A|B|C');
ALTER TABLE `airlines_ecm`.`procurement`.`parts_inventory` ALTER COLUMN `average_weighted_cost` SET TAGS ('dbx_business_glossary_term' = 'Average Weighted Cost');
ALTER TABLE `airlines_ecm`.`procurement`.`parts_inventory` ALTER COLUMN `average_weighted_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`procurement`.`parts_inventory` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Number');
ALTER TABLE `airlines_ecm`.`procurement`.`parts_inventory` ALTER COLUMN `bonded_store_flag` SET TAGS ('dbx_business_glossary_term' = 'Bonded Store Flag');
ALTER TABLE `airlines_ecm`.`procurement`.`parts_inventory` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `airlines_ecm`.`procurement`.`parts_inventory` ALTER COLUMN `criticality_code` SET TAGS ('dbx_business_glossary_term' = 'Criticality Code');
ALTER TABLE `airlines_ecm`.`procurement`.`parts_inventory` ALTER COLUMN `criticality_code` SET TAGS ('dbx_value_regex' = 'aog_critical|flight_critical|standard|non_critical');
ALTER TABLE `airlines_ecm`.`procurement`.`parts_inventory` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `airlines_ecm`.`procurement`.`parts_inventory` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`procurement`.`parts_inventory` ALTER COLUMN `hazmat_flag` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Material (HAZMAT) Flag');
ALTER TABLE `airlines_ecm`.`procurement`.`parts_inventory` ALTER COLUMN `last_issue_date` SET TAGS ('dbx_business_glossary_term' = 'Last Issue Date');
ALTER TABLE `airlines_ecm`.`procurement`.`parts_inventory` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `airlines_ecm`.`procurement`.`parts_inventory` ALTER COLUMN `last_movement_date` SET TAGS ('dbx_business_glossary_term' = 'Last Movement Date');
ALTER TABLE `airlines_ecm`.`procurement`.`parts_inventory` ALTER COLUMN `last_physical_count_date` SET TAGS ('dbx_business_glossary_term' = 'Last Physical Count Date');
ALTER TABLE `airlines_ecm`.`procurement`.`parts_inventory` ALTER COLUMN `last_purchase_order_date` SET TAGS ('dbx_business_glossary_term' = 'Last Purchase Order Date');
ALTER TABLE `airlines_ecm`.`procurement`.`parts_inventory` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time Days');
ALTER TABLE `airlines_ecm`.`procurement`.`parts_inventory` ALTER COLUMN `material_number` SET TAGS ('dbx_business_glossary_term' = 'Material Number');
ALTER TABLE `airlines_ecm`.`procurement`.`parts_inventory` ALTER COLUMN `material_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,18}$');
ALTER TABLE `airlines_ecm`.`procurement`.`parts_inventory` ALTER COLUMN `maximum_stock_level` SET TAGS ('dbx_business_glossary_term' = 'Maximum Stock Level');
ALTER TABLE `airlines_ecm`.`procurement`.`parts_inventory` ALTER COLUMN `minimum_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity (MOQ)');
ALTER TABLE `airlines_ecm`.`procurement`.`parts_inventory` ALTER COLUMN `part_condition` SET TAGS ('dbx_business_glossary_term' = 'Part Condition');
ALTER TABLE `airlines_ecm`.`procurement`.`parts_inventory` ALTER COLUMN `part_condition` SET TAGS ('dbx_value_regex' = 'serviceable|unserviceable|repairable|beyond_repair|quarantine');
ALTER TABLE `airlines_ecm`.`procurement`.`parts_inventory` ALTER COLUMN `quantity_on_hand` SET TAGS ('dbx_business_glossary_term' = 'Quantity On Hand');
ALTER TABLE `airlines_ecm`.`procurement`.`parts_inventory` ALTER COLUMN `quantity_on_order` SET TAGS ('dbx_business_glossary_term' = 'Quantity On Order');
ALTER TABLE `airlines_ecm`.`procurement`.`parts_inventory` ALTER COLUMN `quantity_reserved` SET TAGS ('dbx_business_glossary_term' = 'Quantity Reserved');
ALTER TABLE `airlines_ecm`.`procurement`.`parts_inventory` ALTER COLUMN `reorder_point` SET TAGS ('dbx_business_glossary_term' = 'Reorder Point');
ALTER TABLE `airlines_ecm`.`procurement`.`parts_inventory` ALTER COLUMN `rotable_flag` SET TAGS ('dbx_business_glossary_term' = 'Rotable Flag');
ALTER TABLE `airlines_ecm`.`procurement`.`parts_inventory` ALTER COLUMN `safety_stock_level` SET TAGS ('dbx_business_glossary_term' = 'Safety Stock Level');
ALTER TABLE `airlines_ecm`.`procurement`.`parts_inventory` ALTER COLUMN `serial_number` SET TAGS ('dbx_business_glossary_term' = 'Serial Number');
ALTER TABLE `airlines_ecm`.`procurement`.`parts_inventory` ALTER COLUMN `shelf_life_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Shelf Life Expiry Date');
ALTER TABLE `airlines_ecm`.`procurement`.`parts_inventory` ALTER COLUMN `station_iata_code` SET TAGS ('dbx_business_glossary_term' = 'Station IATA (International Air Transport Association) Code');
ALTER TABLE `airlines_ecm`.`procurement`.`parts_inventory` ALTER COLUMN `station_iata_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`procurement`.`parts_inventory` ALTER COLUMN `stock_status` SET TAGS ('dbx_business_glossary_term' = 'Stock Status');
ALTER TABLE `airlines_ecm`.`procurement`.`parts_inventory` ALTER COLUMN `stock_status` SET TAGS ('dbx_value_regex' = 'active|inactive|obsolete|phase_out');
ALTER TABLE `airlines_ecm`.`procurement`.`parts_inventory` ALTER COLUMN `stock_type` SET TAGS ('dbx_business_glossary_term' = 'Stock Type');
ALTER TABLE `airlines_ecm`.`procurement`.`parts_inventory` ALTER COLUMN `stock_type` SET TAGS ('dbx_value_regex' = 'unrestricted|quality_inspection|blocked|consignment|in_transit|reserved');
ALTER TABLE `airlines_ecm`.`procurement`.`parts_inventory` ALTER COLUMN `storage_location_code` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Code');
ALTER TABLE `airlines_ecm`.`procurement`.`parts_inventory` ALTER COLUMN `storage_location_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `airlines_ecm`.`procurement`.`parts_inventory` ALTER COLUMN `total_stock_value` SET TAGS ('dbx_business_glossary_term' = 'Total Stock Value');
ALTER TABLE `airlines_ecm`.`procurement`.`parts_inventory` ALTER COLUMN `total_stock_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`procurement`.`parts_inventory` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `airlines_ecm`.`procurement`.`parts_inventory` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,3}$');
ALTER TABLE `airlines_ecm`.`procurement`.`parts_inventory` ALTER COLUMN `warehouse_zone` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Zone');
ALTER TABLE `airlines_ecm`.`procurement`.`sourcing_event` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `airlines_ecm`.`procurement`.`sourcing_event` SET TAGS ('dbx_subdomain' = 'supplier_management');
ALTER TABLE `airlines_ecm`.`procurement`.`sourcing_event` ALTER COLUMN `sourcing_event_id` SET TAGS ('dbx_business_glossary_term' = 'Sourcing Event Identifier (ID)');
ALTER TABLE `airlines_ecm`.`procurement`.`sourcing_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approver Identifier (ID)');
ALTER TABLE `airlines_ecm`.`procurement`.`sourcing_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`procurement`.`sourcing_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `airlines_ecm`.`procurement`.`sourcing_event` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Awarded Vendor Identifier (ID)');
ALTER TABLE `airlines_ecm`.`procurement`.`sourcing_event` ALTER COLUMN `primary_sourcing_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Issuing Buyer Identifier (ID)');
ALTER TABLE `airlines_ecm`.`procurement`.`sourcing_event` ALTER COLUMN `primary_sourcing_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`procurement`.`sourcing_event` ALTER COLUMN `primary_sourcing_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `airlines_ecm`.`procurement`.`sourcing_event` ALTER COLUMN `procurement_category_id` SET TAGS ('dbx_business_glossary_term' = 'Procurement Category Identifier (ID)');
ALTER TABLE `airlines_ecm`.`procurement`.`sourcing_event` ALTER COLUMN `prior_sourcing_event_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `airlines_ecm`.`procurement`.`sourcing_event` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `airlines_ecm`.`procurement`.`sourcing_event` ALTER COLUMN `approval_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Approval Required Flag');
ALTER TABLE `airlines_ecm`.`procurement`.`sourcing_event` ALTER COLUMN `award_date` SET TAGS ('dbx_business_glossary_term' = 'Award Date');
ALTER TABLE `airlines_ecm`.`procurement`.`sourcing_event` ALTER COLUMN `awarded_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Awarded Value Currency Code');
ALTER TABLE `airlines_ecm`.`procurement`.`sourcing_event` ALTER COLUMN `awarded_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`procurement`.`sourcing_event` ALTER COLUMN `awarded_value_amount` SET TAGS ('dbx_business_glossary_term' = 'Awarded Contract Value Amount');
ALTER TABLE `airlines_ecm`.`procurement`.`sourcing_event` ALTER COLUMN `awarded_value_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`procurement`.`sourcing_event` ALTER COLUMN `baseline_value_amount` SET TAGS ('dbx_business_glossary_term' = 'Baseline Value Amount');
ALTER TABLE `airlines_ecm`.`procurement`.`sourcing_event` ALTER COLUMN `baseline_value_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`procurement`.`sourcing_event` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `airlines_ecm`.`procurement`.`sourcing_event` ALTER COLUMN `compliance_requirements` SET TAGS ('dbx_business_glossary_term' = 'Compliance Requirements');
ALTER TABLE `airlines_ecm`.`procurement`.`sourcing_event` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Level');
ALTER TABLE `airlines_ecm`.`procurement`.`sourcing_event` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_value_regex' = 'public|internal|confidential|restricted');
ALTER TABLE `airlines_ecm`.`procurement`.`sourcing_event` ALTER COLUMN `contract_duration_months` SET TAGS ('dbx_business_glossary_term' = 'Contract Duration in Months');
ALTER TABLE `airlines_ecm`.`procurement`.`sourcing_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `airlines_ecm`.`procurement`.`sourcing_event` ALTER COLUMN `delivery_weight_percentage` SET TAGS ('dbx_business_glossary_term' = 'Delivery Evaluation Weight Percentage');
ALTER TABLE `airlines_ecm`.`procurement`.`sourcing_event` ALTER COLUMN `evaluation_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Completion Date');
ALTER TABLE `airlines_ecm`.`procurement`.`sourcing_event` ALTER COLUMN `evaluation_start_date` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Start Date');
ALTER TABLE `airlines_ecm`.`procurement`.`sourcing_event` ALTER COLUMN `event_number` SET TAGS ('dbx_business_glossary_term' = 'Sourcing Event Number');
ALTER TABLE `airlines_ecm`.`procurement`.`sourcing_event` ALTER COLUMN `event_number` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,4}-[0-9]{6,10}$');
ALTER TABLE `airlines_ecm`.`procurement`.`sourcing_event` ALTER COLUMN `event_status` SET TAGS ('dbx_business_glossary_term' = 'Sourcing Event Status');
ALTER TABLE `airlines_ecm`.`procurement`.`sourcing_event` ALTER COLUMN `event_title` SET TAGS ('dbx_business_glossary_term' = 'Sourcing Event Title');
ALTER TABLE `airlines_ecm`.`procurement`.`sourcing_event` ALTER COLUMN `event_type` SET TAGS ('dbx_business_glossary_term' = 'Sourcing Event Type');
ALTER TABLE `airlines_ecm`.`procurement`.`sourcing_event` ALTER COLUMN `event_type` SET TAGS ('dbx_value_regex' = 'RFI|RFQ|RFP|reverse_auction|sealed_bid|framework_agreement');
ALTER TABLE `airlines_ecm`.`procurement`.`sourcing_event` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `airlines_ecm`.`procurement`.`sourcing_event` ALTER COLUMN `minimum_qualification_criteria` SET TAGS ('dbx_business_glossary_term' = 'Minimum Qualification Criteria');
ALTER TABLE `airlines_ecm`.`procurement`.`sourcing_event` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Sourcing Event Notes');
ALTER TABLE `airlines_ecm`.`procurement`.`sourcing_event` ALTER COLUMN `price_weight_percentage` SET TAGS ('dbx_business_glossary_term' = 'Price Evaluation Weight Percentage');
ALTER TABLE `airlines_ecm`.`procurement`.`sourcing_event` ALTER COLUMN `publication_date` SET TAGS ('dbx_business_glossary_term' = 'Sourcing Event Publication Date');
ALTER TABLE `airlines_ecm`.`procurement`.`sourcing_event` ALTER COLUMN `quality_weight_percentage` SET TAGS ('dbx_business_glossary_term' = 'Quality Evaluation Weight Percentage');
ALTER TABLE `airlines_ecm`.`procurement`.`sourcing_event` ALTER COLUMN `response_deadline` SET TAGS ('dbx_business_glossary_term' = 'Vendor Response Deadline Timestamp');
ALTER TABLE `airlines_ecm`.`procurement`.`sourcing_event` ALTER COLUMN `responses_received_count` SET TAGS ('dbx_business_glossary_term' = 'Number of Responses Received');
ALTER TABLE `airlines_ecm`.`procurement`.`sourcing_event` ALTER COLUMN `savings_achieved_amount` SET TAGS ('dbx_business_glossary_term' = 'Savings Achieved Amount');
ALTER TABLE `airlines_ecm`.`procurement`.`sourcing_event` ALTER COLUMN `savings_achieved_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`procurement`.`sourcing_event` ALTER COLUMN `savings_percentage` SET TAGS ('dbx_business_glossary_term' = 'Savings Percentage');
ALTER TABLE `airlines_ecm`.`procurement`.`sourcing_event` ALTER COLUMN `scope_description` SET TAGS ('dbx_business_glossary_term' = 'Sourcing Event Scope Description');
ALTER TABLE `airlines_ecm`.`procurement`.`sourcing_event` ALTER COLUMN `strategic_initiative_reference` SET TAGS ('dbx_business_glossary_term' = 'Strategic Sourcing Initiative Reference');
ALTER TABLE `airlines_ecm`.`procurement`.`sourcing_event` ALTER COLUMN `technical_weight_percentage` SET TAGS ('dbx_business_glossary_term' = 'Technical Evaluation Weight Percentage');
ALTER TABLE `airlines_ecm`.`procurement`.`sourcing_event` ALTER COLUMN `vendors_invited_count` SET TAGS ('dbx_business_glossary_term' = 'Number of Vendors Invited');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_quote` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_quote` SET TAGS ('dbx_subdomain' = 'supplier_management');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_quote` ALTER COLUMN `vendor_quote_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Quote Identifier (ID)');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_quote` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Evaluator Identifier (ID)');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_quote` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_quote` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_quote` ALTER COLUMN `sourcing_event_id` SET TAGS ('dbx_business_glossary_term' = 'Sourcing Event Identifier (ID)');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_quote` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Identifier (ID)');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_quote` ALTER COLUMN `revised_vendor_quote_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_quote` ALTER COLUMN `award_date` SET TAGS ('dbx_business_glossary_term' = 'Award Date');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_quote` ALTER COLUMN `commercial_evaluation_score` SET TAGS ('dbx_business_glossary_term' = 'Commercial Evaluation Score');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_quote` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_quote` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_quote` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_quote` ALTER COLUMN `delivery_lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Delivery Lead Time (Days)');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_quote` ALTER COLUMN `evaluation_completed_date` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Completed Date');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_quote` ALTER COLUMN `exceptions_and_deviations` SET TAGS ('dbx_business_glossary_term' = 'Exceptions and Deviations');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_quote` ALTER COLUMN `incoterms` SET TAGS ('dbx_business_glossary_term' = 'International Commercial Terms (Incoterms)');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_quote` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_quote` ALTER COLUMN `minimum_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity (MOQ)');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_quote` ALTER COLUMN `overall_ranking` SET TAGS ('dbx_business_glossary_term' = 'Overall Ranking');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_quote` ALTER COLUMN `payment_terms_offered` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms Offered');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_quote` ALTER COLUMN `quote_document_url` SET TAGS ('dbx_business_glossary_term' = 'Quote Document Uniform Resource Locator (URL)');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_quote` ALTER COLUMN `quote_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Quote Reference Number');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_quote` ALTER COLUMN `quote_reference_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_quote` ALTER COLUMN `quote_status` SET TAGS ('dbx_business_glossary_term' = 'Quote Status');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_quote` ALTER COLUMN `quote_type` SET TAGS ('dbx_business_glossary_term' = 'Quote Type');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_quote` ALTER COLUMN `quote_type` SET TAGS ('dbx_value_regex' = 'rfq_response|rfp_response|ad_hoc|spot_quote|framework_quote');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_quote` ALTER COLUMN `quoted_total_value` SET TAGS ('dbx_business_glossary_term' = 'Quoted Total Value');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_quote` ALTER COLUMN `quoted_unit_price` SET TAGS ('dbx_business_glossary_term' = 'Quoted Unit Price');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_quote` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_quote` ALTER COLUMN `submission_date` SET TAGS ('dbx_business_glossary_term' = 'Quote Submission Date');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_quote` ALTER COLUMN `submission_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Quote Submission Timestamp');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_quote` ALTER COLUMN `technical_compliance_notes` SET TAGS ('dbx_business_glossary_term' = 'Technical Compliance Notes');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_quote` ALTER COLUMN `technical_evaluation_score` SET TAGS ('dbx_business_glossary_term' = 'Technical Evaluation Score');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_quote` ALTER COLUMN `validity_end_date` SET TAGS ('dbx_business_glossary_term' = 'Quote Validity End Date');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_quote` ALTER COLUMN `validity_start_date` SET TAGS ('dbx_business_glossary_term' = 'Quote Validity Start Date');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_quote` ALTER COLUMN `vendor_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Vendor Contact Email Address');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_quote` ALTER COLUMN `vendor_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_quote` ALTER COLUMN `vendor_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_quote` ALTER COLUMN `vendor_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_quote` ALTER COLUMN `vendor_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Vendor Contact Name');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_quote` ALTER COLUMN `vendor_contact_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_quote` ALTER COLUMN `vendor_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Vendor Contact Phone Number');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_quote` ALTER COLUMN `vendor_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_quote` ALTER COLUMN `vendor_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_quote` ALTER COLUMN `warranty_period_months` SET TAGS ('dbx_business_glossary_term' = 'Warranty Period (Months)');
ALTER TABLE `airlines_ecm`.`procurement`.`fuel_contract` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `airlines_ecm`.`procurement`.`fuel_contract` SET TAGS ('dbx_subdomain' = 'inventory_control');
ALTER TABLE `airlines_ecm`.`procurement`.`fuel_contract` ALTER COLUMN `fuel_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Fuel Contract ID');
ALTER TABLE `airlines_ecm`.`procurement`.`fuel_contract` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Owner Employee ID');
ALTER TABLE `airlines_ecm`.`procurement`.`fuel_contract` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`procurement`.`fuel_contract` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `airlines_ecm`.`procurement`.`fuel_contract` ALTER COLUMN `primary_fuel_approved_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Employee ID');
ALTER TABLE `airlines_ecm`.`procurement`.`fuel_contract` ALTER COLUMN `primary_fuel_approved_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`procurement`.`fuel_contract` ALTER COLUMN `primary_fuel_approved_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `airlines_ecm`.`procurement`.`fuel_contract` ALTER COLUMN `procurement_category_id` SET TAGS ('dbx_business_glossary_term' = 'Procurement Category Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`procurement`.`fuel_contract` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `airlines_ecm`.`procurement`.`fuel_contract` ALTER COLUMN `renewed_fuel_contract_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `airlines_ecm`.`procurement`.`fuel_contract` ALTER COLUMN `airport_iata_code` SET TAGS ('dbx_business_glossary_term' = 'Airport IATA (International Air Transport Association) Code');
ALTER TABLE `airlines_ecm`.`procurement`.`fuel_contract` ALTER COLUMN `airport_iata_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`procurement`.`fuel_contract` ALTER COLUMN `amendment_count` SET TAGS ('dbx_business_glossary_term' = 'Amendment Count');
ALTER TABLE `airlines_ecm`.`procurement`.`fuel_contract` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `airlines_ecm`.`procurement`.`fuel_contract` ALTER COLUMN `auto_renewal_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto Renewal Flag');
ALTER TABLE `airlines_ecm`.`procurement`.`fuel_contract` ALTER COLUMN `base_price_per_litre` SET TAGS ('dbx_business_glossary_term' = 'Base Price Per Litre');
ALTER TABLE `airlines_ecm`.`procurement`.`fuel_contract` ALTER COLUMN `base_price_per_litre` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`procurement`.`fuel_contract` ALTER COLUMN `carbon_intensity_gco2_per_mj` SET TAGS ('dbx_business_glossary_term' = 'Carbon Intensity gCO2 Per MJ (Megajoule)');
ALTER TABLE `airlines_ecm`.`procurement`.`fuel_contract` ALTER COLUMN `contract_number` SET TAGS ('dbx_business_glossary_term' = 'Fuel Contract Number');
ALTER TABLE `airlines_ecm`.`procurement`.`fuel_contract` ALTER COLUMN `contract_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `airlines_ecm`.`procurement`.`fuel_contract` ALTER COLUMN `contract_status` SET TAGS ('dbx_business_glossary_term' = 'Contract Status');
ALTER TABLE `airlines_ecm`.`procurement`.`fuel_contract` ALTER COLUMN `contract_status` SET TAGS ('dbx_value_regex' = 'draft|active|suspended|expired|terminated');
ALTER TABLE `airlines_ecm`.`procurement`.`fuel_contract` ALTER COLUMN `contract_type` SET TAGS ('dbx_business_glossary_term' = 'Contract Type');
ALTER TABLE `airlines_ecm`.`procurement`.`fuel_contract` ALTER COLUMN `contract_type` SET TAGS ('dbx_value_regex' = 'spot|term|hedged|into-plane');
ALTER TABLE `airlines_ecm`.`procurement`.`fuel_contract` ALTER COLUMN `contracted_volume_litres_per_month` SET TAGS ('dbx_business_glossary_term' = 'Contracted Volume Litres Per Month');
ALTER TABLE `airlines_ecm`.`procurement`.`fuel_contract` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `airlines_ecm`.`procurement`.`fuel_contract` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `airlines_ecm`.`procurement`.`fuel_contract` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`procurement`.`fuel_contract` ALTER COLUMN `delivery_method` SET TAGS ('dbx_business_glossary_term' = 'Delivery Method');
ALTER TABLE `airlines_ecm`.`procurement`.`fuel_contract` ALTER COLUMN `delivery_method` SET TAGS ('dbx_value_regex' = 'hydrant|bowser|pipeline|truck');
ALTER TABLE `airlines_ecm`.`procurement`.`fuel_contract` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Effective End Date');
ALTER TABLE `airlines_ecm`.`procurement`.`fuel_contract` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Effective Start Date');
ALTER TABLE `airlines_ecm`.`procurement`.`fuel_contract` ALTER COLUMN `force_majeure_clause_flag` SET TAGS ('dbx_business_glossary_term' = 'Force Majeure Clause Flag');
ALTER TABLE `airlines_ecm`.`procurement`.`fuel_contract` ALTER COLUMN `fuel_type` SET TAGS ('dbx_business_glossary_term' = 'Fuel Type');
ALTER TABLE `airlines_ecm`.`procurement`.`fuel_contract` ALTER COLUMN `fuel_type` SET TAGS ('dbx_value_regex' = 'Jet-A|Jet-A1|Avgas|SAF');
ALTER TABLE `airlines_ecm`.`procurement`.`fuel_contract` ALTER COLUMN `hedge_contract_reference` SET TAGS ('dbx_business_glossary_term' = 'Hedge Contract Reference');
ALTER TABLE `airlines_ecm`.`procurement`.`fuel_contract` ALTER COLUMN `last_amendment_date` SET TAGS ('dbx_business_glossary_term' = 'Last Amendment Date');
ALTER TABLE `airlines_ecm`.`procurement`.`fuel_contract` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `airlines_ecm`.`procurement`.`fuel_contract` ALTER COLUMN `minimum_offtake_commitment_litres` SET TAGS ('dbx_business_glossary_term' = 'Minimum Offtake Commitment Litres');
ALTER TABLE `airlines_ecm`.`procurement`.`fuel_contract` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Contract Notes');
ALTER TABLE `airlines_ecm`.`procurement`.`fuel_contract` ALTER COLUMN `notice_period_days` SET TAGS ('dbx_business_glossary_term' = 'Notice Period Days');
ALTER TABLE `airlines_ecm`.`procurement`.`fuel_contract` ALTER COLUMN `payment_terms_days` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms Days');
ALTER TABLE `airlines_ecm`.`procurement`.`fuel_contract` ALTER COLUMN `pricing_mechanism` SET TAGS ('dbx_business_glossary_term' = 'Pricing Mechanism');
ALTER TABLE `airlines_ecm`.`procurement`.`fuel_contract` ALTER COLUMN `pricing_mechanism` SET TAGS ('dbx_value_regex' = 'PLATTS-indexed|fixed|formula|market-linked');
ALTER TABLE `airlines_ecm`.`procurement`.`fuel_contract` ALTER COLUMN `quality_specification_reference` SET TAGS ('dbx_business_glossary_term' = 'Quality Specification Reference');
ALTER TABLE `airlines_ecm`.`procurement`.`fuel_contract` ALTER COLUMN `sustainability_certification` SET TAGS ('dbx_business_glossary_term' = 'Sustainability Certification');
ALTER TABLE `airlines_ecm`.`procurement`.`fuel_contract` ALTER COLUMN `uplift_fee_cents_per_litre` SET TAGS ('dbx_business_glossary_term' = 'Uplift Fee Cents Per Litre');
ALTER TABLE `airlines_ecm`.`procurement`.`fuel_contract` ALTER COLUMN `uplift_fee_cents_per_litre` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`procurement`.`fuel_contract` ALTER COLUMN `volume_tolerance_percentage` SET TAGS ('dbx_business_glossary_term' = 'Volume Tolerance Percentage');
ALTER TABLE `airlines_ecm`.`procurement`.`fuel_uplift_order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `airlines_ecm`.`procurement`.`fuel_uplift_order` SET TAGS ('dbx_subdomain' = 'order_processing');
ALTER TABLE `airlines_ecm`.`procurement`.`fuel_uplift_order` ALTER COLUMN `fuel_uplift_order_id` SET TAGS ('dbx_business_glossary_term' = 'Fuel Uplift Order Identifier (ID)');
ALTER TABLE `airlines_ecm`.`procurement`.`fuel_uplift_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Employee Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`procurement`.`fuel_uplift_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`procurement`.`fuel_uplift_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `airlines_ecm`.`procurement`.`fuel_uplift_order` ALTER COLUMN `flight_leg_id` SET TAGS ('dbx_business_glossary_term' = 'Flight Leg Identifier (ID)');
ALTER TABLE `airlines_ecm`.`procurement`.`fuel_uplift_order` ALTER COLUMN `fuel_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Fuel Contract Identifier (ID)');
ALTER TABLE `airlines_ecm`.`procurement`.`fuel_uplift_order` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Fueling Vendor Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`procurement`.`fuel_uplift_order` ALTER COLUMN `amended_fuel_uplift_order_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `airlines_ecm`.`procurement`.`fuel_uplift_order` ALTER COLUMN `actual_uplift_quantity` SET TAGS ('dbx_business_glossary_term' = 'Actual Uplift Quantity');
ALTER TABLE `airlines_ecm`.`procurement`.`fuel_uplift_order` ALTER COLUMN `actual_uplift_quantity_unit` SET TAGS ('dbx_business_glossary_term' = 'Actual Uplift Quantity Unit of Measure (UOM)');
ALTER TABLE `airlines_ecm`.`procurement`.`fuel_uplift_order` ALTER COLUMN `actual_uplift_quantity_unit` SET TAGS ('dbx_value_regex' = 'LITRES|KILOGRAMS|GALLONS|POUNDS');
ALTER TABLE `airlines_ecm`.`procurement`.`fuel_uplift_order` ALTER COLUMN `aircraft_registration` SET TAGS ('dbx_business_glossary_term' = 'Aircraft Registration Number');
ALTER TABLE `airlines_ecm`.`procurement`.`fuel_uplift_order` ALTER COLUMN `aircraft_registration` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{5,10}$');
ALTER TABLE `airlines_ecm`.`procurement`.`fuel_uplift_order` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `airlines_ecm`.`procurement`.`fuel_uplift_order` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `airlines_ecm`.`procurement`.`fuel_uplift_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `airlines_ecm`.`procurement`.`fuel_uplift_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`procurement`.`fuel_uplift_order` ALTER COLUMN `dispute_reason` SET TAGS ('dbx_business_glossary_term' = 'Dispute Reason');
ALTER TABLE `airlines_ecm`.`procurement`.`fuel_uplift_order` ALTER COLUMN `fuel_density` SET TAGS ('dbx_business_glossary_term' = 'Fuel Density');
ALTER TABLE `airlines_ecm`.`procurement`.`fuel_uplift_order` ALTER COLUMN `fuel_receipt_document_number` SET TAGS ('dbx_business_glossary_term' = 'Fuel Receipt Document Number');
ALTER TABLE `airlines_ecm`.`procurement`.`fuel_uplift_order` ALTER COLUMN `fuel_receipt_document_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{8,20}$');
ALTER TABLE `airlines_ecm`.`procurement`.`fuel_uplift_order` ALTER COLUMN `fuel_temperature_celsius` SET TAGS ('dbx_business_glossary_term' = 'Fuel Temperature (Celsius)');
ALTER TABLE `airlines_ecm`.`procurement`.`fuel_uplift_order` ALTER COLUMN `fuel_type` SET TAGS ('dbx_business_glossary_term' = 'Fuel Type');
ALTER TABLE `airlines_ecm`.`procurement`.`fuel_uplift_order` ALTER COLUMN `fuel_type` SET TAGS ('dbx_value_regex' = 'JET_A1|JET_A|AVGAS_100LL|AVGAS_UL|JET_B');
ALTER TABLE `airlines_ecm`.`procurement`.`fuel_uplift_order` ALTER COLUMN `fueling_agent_name` SET TAGS ('dbx_business_glossary_term' = 'Fueling Agent Name');
ALTER TABLE `airlines_ecm`.`procurement`.`fuel_uplift_order` ALTER COLUMN `fueling_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Fueling End Timestamp');
ALTER TABLE `airlines_ecm`.`procurement`.`fuel_uplift_order` ALTER COLUMN `fueling_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Fueling Start Timestamp');
ALTER TABLE `airlines_ecm`.`procurement`.`fuel_uplift_order` ALTER COLUMN `invoice_number` SET TAGS ('dbx_business_glossary_term' = 'Invoice Number');
ALTER TABLE `airlines_ecm`.`procurement`.`fuel_uplift_order` ALTER COLUMN `invoice_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{8,20}$');
ALTER TABLE `airlines_ecm`.`procurement`.`fuel_uplift_order` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `airlines_ecm`.`procurement`.`fuel_uplift_order` ALTER COLUMN `order_placed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Order Placed Timestamp');
ALTER TABLE `airlines_ecm`.`procurement`.`fuel_uplift_order` ALTER COLUMN `ordered_quantity` SET TAGS ('dbx_business_glossary_term' = 'Ordered Fuel Quantity');
ALTER TABLE `airlines_ecm`.`procurement`.`fuel_uplift_order` ALTER COLUMN `ordered_quantity_unit` SET TAGS ('dbx_business_glossary_term' = 'Ordered Quantity Unit of Measure (UOM)');
ALTER TABLE `airlines_ecm`.`procurement`.`fuel_uplift_order` ALTER COLUMN `ordered_quantity_unit` SET TAGS ('dbx_value_regex' = 'LITRES|KILOGRAMS|GALLONS|POUNDS');
ALTER TABLE `airlines_ecm`.`procurement`.`fuel_uplift_order` ALTER COLUMN `payment_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Status');
ALTER TABLE `airlines_ecm`.`procurement`.`fuel_uplift_order` ALTER COLUMN `payment_status` SET TAGS ('dbx_value_regex' = 'PENDING|PAID|OVERDUE|DISPUTED');
ALTER TABLE `airlines_ecm`.`procurement`.`fuel_uplift_order` ALTER COLUMN `quality_check_passed` SET TAGS ('dbx_business_glossary_term' = 'Quality Check Passed Flag');
ALTER TABLE `airlines_ecm`.`procurement`.`fuel_uplift_order` ALTER COLUMN `quality_check_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Quality Check Timestamp');
ALTER TABLE `airlines_ecm`.`procurement`.`fuel_uplift_order` ALTER COLUMN `remarks` SET TAGS ('dbx_business_glossary_term' = 'Remarks');
ALTER TABLE `airlines_ecm`.`procurement`.`fuel_uplift_order` ALTER COLUMN `station_code` SET TAGS ('dbx_business_glossary_term' = 'Station Code (IATA Airport Code)');
ALTER TABLE `airlines_ecm`.`procurement`.`fuel_uplift_order` ALTER COLUMN `station_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`procurement`.`fuel_uplift_order` ALTER COLUMN `total_cost` SET TAGS ('dbx_business_glossary_term' = 'Total Fuel Uplift Cost');
ALTER TABLE `airlines_ecm`.`procurement`.`fuel_uplift_order` ALTER COLUMN `total_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`procurement`.`fuel_uplift_order` ALTER COLUMN `unit_price` SET TAGS ('dbx_business_glossary_term' = 'Fuel Unit Price');
ALTER TABLE `airlines_ecm`.`procurement`.`fuel_uplift_order` ALTER COLUMN `unit_price` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`procurement`.`fuel_uplift_order` ALTER COLUMN `uplift_order_number` SET TAGS ('dbx_business_glossary_term' = 'Fuel Uplift Order Number');
ALTER TABLE `airlines_ecm`.`procurement`.`fuel_uplift_order` ALTER COLUMN `uplift_order_number` SET TAGS ('dbx_value_regex' = '^FUO-[0-9]{10}$');
ALTER TABLE `airlines_ecm`.`procurement`.`fuel_uplift_order` ALTER COLUMN `uplift_status` SET TAGS ('dbx_business_glossary_term' = 'Fuel Uplift Order Status');
ALTER TABLE `airlines_ecm`.`procurement`.`fuel_uplift_order` ALTER COLUMN `uplift_status` SET TAGS ('dbx_value_regex' = 'ORDERED|IN_PROGRESS|COMPLETED|DISPUTED|CANCELLED');
ALTER TABLE `airlines_ecm`.`procurement`.`fuel_uplift_order` ALTER COLUMN `variance_quantity` SET TAGS ('dbx_business_glossary_term' = 'Fuel Quantity Variance');
ALTER TABLE `airlines_ecm`.`procurement`.`catering_order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `airlines_ecm`.`procurement`.`catering_order` SET TAGS ('dbx_subdomain' = 'order_processing');
ALTER TABLE `airlines_ecm`.`procurement`.`catering_order` ALTER COLUMN `catering_order_id` SET TAGS ('dbx_business_glossary_term' = 'Catering Order Identifier (ID)');
ALTER TABLE `airlines_ecm`.`procurement`.`catering_order` ALTER COLUMN `flight_leg_id` SET TAGS ('dbx_business_glossary_term' = 'Flight Leg Identifier (ID)');
ALTER TABLE `airlines_ecm`.`procurement`.`catering_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Requested By Employee Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`procurement`.`catering_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`procurement`.`catering_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `airlines_ecm`.`procurement`.`catering_order` ALTER COLUMN `supply_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Supply Contract Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`procurement`.`catering_order` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Identifier (ID)');
ALTER TABLE `airlines_ecm`.`procurement`.`catering_order` ALTER COLUMN `amended_catering_order_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `airlines_ecm`.`procurement`.`catering_order` ALTER COLUMN `actual_meal_count_delivered` SET TAGS ('dbx_business_glossary_term' = 'Actual Meal Count Delivered');
ALTER TABLE `airlines_ecm`.`procurement`.`catering_order` ALTER COLUMN `actual_uplift_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Uplift Timestamp');
ALTER TABLE `airlines_ecm`.`procurement`.`catering_order` ALTER COLUMN `beverage_quantity_units` SET TAGS ('dbx_business_glossary_term' = 'Beverage Quantity Units');
ALTER TABLE `airlines_ecm`.`procurement`.`catering_order` ALTER COLUMN `business_class_meal_count` SET TAGS ('dbx_business_glossary_term' = 'Business Class (J) Meal Count');
ALTER TABLE `airlines_ecm`.`procurement`.`catering_order` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `airlines_ecm`.`procurement`.`catering_order` ALTER COLUMN `cancellation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Timestamp');
ALTER TABLE `airlines_ecm`.`procurement`.`catering_order` ALTER COLUMN `catering_supervisor_name` SET TAGS ('dbx_business_glossary_term' = 'Catering Supervisor Name');
ALTER TABLE `airlines_ecm`.`procurement`.`catering_order` ALTER COLUMN `catering_supervisor_signature_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Catering Supervisor Signature Timestamp');
ALTER TABLE `airlines_ecm`.`procurement`.`catering_order` ALTER COLUMN `catering_uplift_station_code` SET TAGS ('dbx_business_glossary_term' = 'Catering Uplift Station Code');
ALTER TABLE `airlines_ecm`.`procurement`.`catering_order` ALTER COLUMN `catering_uplift_station_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`procurement`.`catering_order` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `airlines_ecm`.`procurement`.`catering_order` ALTER COLUMN `crew_meal_count` SET TAGS ('dbx_business_glossary_term' = 'Crew Meal Count');
ALTER TABLE `airlines_ecm`.`procurement`.`catering_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `airlines_ecm`.`procurement`.`catering_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`procurement`.`catering_order` ALTER COLUMN `departure_station_code` SET TAGS ('dbx_business_glossary_term' = 'Departure Station Code');
ALTER TABLE `airlines_ecm`.`procurement`.`catering_order` ALTER COLUMN `departure_station_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`procurement`.`catering_order` ALTER COLUMN `economy_class_meal_count` SET TAGS ('dbx_business_glossary_term' = 'Economy Class (Y) Meal Count');
ALTER TABLE `airlines_ecm`.`procurement`.`catering_order` ALTER COLUMN `first_class_meal_count` SET TAGS ('dbx_business_glossary_term' = 'First Class (F) Meal Count');
ALTER TABLE `airlines_ecm`.`procurement`.`catering_order` ALTER COLUMN `galley_insert_count` SET TAGS ('dbx_business_glossary_term' = 'Galley Insert Count');
ALTER TABLE `airlines_ecm`.`procurement`.`catering_order` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `airlines_ecm`.`procurement`.`catering_order` ALTER COLUMN `meal_service_type` SET TAGS ('dbx_business_glossary_term' = 'Meal Service Type');
ALTER TABLE `airlines_ecm`.`procurement`.`catering_order` ALTER COLUMN `meal_service_type` SET TAGS ('dbx_value_regex' = 'full_service|snack|beverage_only|buy_on_board|premium_dining|light_refreshment');
ALTER TABLE `airlines_ecm`.`procurement`.`catering_order` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Order Notes');
ALTER TABLE `airlines_ecm`.`procurement`.`catering_order` ALTER COLUMN `order_number` SET TAGS ('dbx_business_glossary_term' = 'Catering Order Number');
ALTER TABLE `airlines_ecm`.`procurement`.`catering_order` ALTER COLUMN `order_number` SET TAGS ('dbx_value_regex' = '^CAT[0-9]{10}$');
ALTER TABLE `airlines_ecm`.`procurement`.`catering_order` ALTER COLUMN `order_placement_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Order Placement Timestamp');
ALTER TABLE `airlines_ecm`.`procurement`.`catering_order` ALTER COLUMN `order_status` SET TAGS ('dbx_business_glossary_term' = 'Order Status');
ALTER TABLE `airlines_ecm`.`procurement`.`catering_order` ALTER COLUMN `order_status` SET TAGS ('dbx_value_regex' = 'placed|confirmed|prepared|uplifted|short_delivered|cancelled');
ALTER TABLE `airlines_ecm`.`procurement`.`catering_order` ALTER COLUMN `order_total_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Order Total Cost Amount');
ALTER TABLE `airlines_ecm`.`procurement`.`catering_order` ALTER COLUMN `order_total_cost_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`procurement`.`catering_order` ALTER COLUMN `premium_economy_meal_count` SET TAGS ('dbx_business_glossary_term' = 'Premium Economy (W) Meal Count');
ALTER TABLE `airlines_ecm`.`procurement`.`catering_order` ALTER COLUMN `required_delivery_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Required Delivery Timestamp');
ALTER TABLE `airlines_ecm`.`procurement`.`catering_order` ALTER COLUMN `short_delivery_reason` SET TAGS ('dbx_business_glossary_term' = 'Short Delivery Reason');
ALTER TABLE `airlines_ecm`.`procurement`.`catering_order` ALTER COLUMN `special_meal_chml_count` SET TAGS ('dbx_business_glossary_term' = 'Child Meal (CHML) Count');
ALTER TABLE `airlines_ecm`.`procurement`.`catering_order` ALTER COLUMN `special_meal_dbml_count` SET TAGS ('dbx_business_glossary_term' = 'Diabetic Meal (DBML) Count');
ALTER TABLE `airlines_ecm`.`procurement`.`catering_order` ALTER COLUMN `special_meal_ksml_count` SET TAGS ('dbx_business_glossary_term' = 'Kosher Meal (KSML) Count');
ALTER TABLE `airlines_ecm`.`procurement`.`catering_order` ALTER COLUMN `special_meal_moml_count` SET TAGS ('dbx_business_glossary_term' = 'Muslim Meal (MOML) Count');
ALTER TABLE `airlines_ecm`.`procurement`.`catering_order` ALTER COLUMN `special_meal_other_count` SET TAGS ('dbx_business_glossary_term' = 'Other Special Meal Count');
ALTER TABLE `airlines_ecm`.`procurement`.`catering_order` ALTER COLUMN `special_meal_vgml_count` SET TAGS ('dbx_business_glossary_term' = 'Vegetarian Meal (VGML) Count');
ALTER TABLE `airlines_ecm`.`procurement`.`catering_order` ALTER COLUMN `trolley_count` SET TAGS ('dbx_business_glossary_term' = 'Trolley Count');
ALTER TABLE `airlines_ecm`.`procurement`.`catering_order` ALTER COLUMN `variance_quantity` SET TAGS ('dbx_business_glossary_term' = 'Variance Quantity');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_performance` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_performance` SET TAGS ('dbx_subdomain' = 'supplier_management');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_performance` ALTER COLUMN `vendor_performance_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Performance ID');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_performance` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Evaluating Buyer ID');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_performance` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_performance` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_performance` ALTER COLUMN `procurement_category_id` SET TAGS ('dbx_business_glossary_term' = 'Procurement Category Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_performance` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_performance` ALTER COLUMN `prior_vendor_performance_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_performance` ALTER COLUMN `aog_response_time_hours` SET TAGS ('dbx_business_glossary_term' = 'Aircraft on Ground (AOG) Response Time Hours');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_performance` ALTER COLUMN `contract_renewal_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Contract Renewal Eligible Flag');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_performance` ALTER COLUMN `corrective_action_plan_reference` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Plan Reference');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_performance` ALTER COLUMN `corrective_action_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Required Flag');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_performance` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_performance` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_performance` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_performance` ALTER COLUMN `evaluation_date` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Date');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_performance` ALTER COLUMN `evaluation_notes` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Notes');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_performance` ALTER COLUMN `evaluation_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Period End Date');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_performance` ALTER COLUMN `evaluation_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Period Start Date');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_performance` ALTER COLUMN `evaluation_period_type` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Period Type');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_performance` ALTER COLUMN `evaluation_period_type` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|semi-annual|annual|custom');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_performance` ALTER COLUMN `invoice_accuracy_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Invoice Accuracy Rate Percentage');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_performance` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_performance` ALTER COLUMN `on_time_delivery_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'On-Time Delivery Rate Percentage');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_performance` ALTER COLUMN `order_fill_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Order Fill Rate Percentage');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_performance` ALTER COLUMN `overall_performance_score` SET TAGS ('dbx_business_glossary_term' = 'Overall Performance Score');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_performance` ALTER COLUMN `performance_tier` SET TAGS ('dbx_business_glossary_term' = 'Performance Tier');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_performance` ALTER COLUMN `performance_tier` SET TAGS ('dbx_value_regex' = 'excellent|satisfactory|needs_improvement|critical');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_performance` ALTER COLUMN `price_compliance_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Price Compliance Rate Percentage');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_performance` ALTER COLUMN `quality_rejection_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Quality Rejection Rate Percentage');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_performance` ALTER COLUMN `sla_target_aog_response_hours` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Target Aircraft on Ground (AOG) Response Hours');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_performance` ALTER COLUMN `sla_target_on_time_delivery_percent` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Target On-Time Delivery Percentage');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_performance` ALTER COLUMN `sla_target_quality_rejection_percent` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Target Quality Rejection Percentage');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_performance` ALTER COLUMN `total_order_value_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Order Value Amount');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_performance` ALTER COLUMN `total_orders_evaluated` SET TAGS ('dbx_business_glossary_term' = 'Total Orders Evaluated');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_performance` ALTER COLUMN `trend_versus_prior_period` SET TAGS ('dbx_business_glossary_term' = 'Trend Versus Prior Period');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_performance` ALTER COLUMN `trend_versus_prior_period` SET TAGS ('dbx_value_regex' = 'improving|stable|declining|first_evaluation');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_performance` ALTER COLUMN `vendor_development_program_flag` SET TAGS ('dbx_business_glossary_term' = 'Vendor Development Program Flag');
ALTER TABLE `airlines_ecm`.`procurement`.`procurement_category` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `airlines_ecm`.`procurement`.`procurement_category` SET TAGS ('dbx_subdomain' = 'inventory_control');
ALTER TABLE `airlines_ecm`.`procurement`.`procurement_category` ALTER COLUMN `procurement_category_id` SET TAGS ('dbx_business_glossary_term' = 'Procurement Category ID');
ALTER TABLE `airlines_ecm`.`procurement`.`procurement_category` ALTER COLUMN `parent_procurement_category_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `airlines_ecm`.`procurement`.`procurement_category` ALTER COLUMN `active_flag` SET TAGS ('dbx_business_glossary_term' = 'Active Flag');
ALTER TABLE `airlines_ecm`.`procurement`.`procurement_category` ALTER COLUMN `annual_spend_estimate` SET TAGS ('dbx_business_glossary_term' = 'Annual Spend Estimate');
ALTER TABLE `airlines_ecm`.`procurement`.`procurement_category` ALTER COLUMN `approval_authority_level` SET TAGS ('dbx_business_glossary_term' = 'Approval Authority Level');
ALTER TABLE `airlines_ecm`.`procurement`.`procurement_category` ALTER COLUMN `approval_authority_level` SET TAGS ('dbx_value_regex' = 'buyer|manager|director|vp|cfo');
ALTER TABLE `airlines_ecm`.`procurement`.`procurement_category` ALTER COLUMN `category_code` SET TAGS ('dbx_business_glossary_term' = 'Category Code');
ALTER TABLE `airlines_ecm`.`procurement`.`procurement_category` ALTER COLUMN `category_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,12}$');
ALTER TABLE `airlines_ecm`.`procurement`.`procurement_category` ALTER COLUMN `category_description` SET TAGS ('dbx_business_glossary_term' = 'Category Description');
ALTER TABLE `airlines_ecm`.`procurement`.`procurement_category` ALTER COLUMN `category_level` SET TAGS ('dbx_business_glossary_term' = 'Category Level');
ALTER TABLE `airlines_ecm`.`procurement`.`procurement_category` ALTER COLUMN `category_name` SET TAGS ('dbx_business_glossary_term' = 'Category Name');
ALTER TABLE `airlines_ecm`.`procurement`.`procurement_category` ALTER COLUMN `compliance_requirements` SET TAGS ('dbx_business_glossary_term' = 'Compliance Requirements');
ALTER TABLE `airlines_ecm`.`procurement`.`procurement_category` ALTER COLUMN `contract_renewal_cycle_months` SET TAGS ('dbx_business_glossary_term' = 'Contract Renewal Cycle (Months)');
ALTER TABLE `airlines_ecm`.`procurement`.`procurement_category` ALTER COLUMN `cost_center_default` SET TAGS ('dbx_business_glossary_term' = 'Default Cost Center');
ALTER TABLE `airlines_ecm`.`procurement`.`procurement_category` ALTER COLUMN `cost_center_default` SET TAGS ('dbx_value_regex' = '^[0-9]{4,10}$');
ALTER TABLE `airlines_ecm`.`procurement`.`procurement_category` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `airlines_ecm`.`procurement`.`procurement_category` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `airlines_ecm`.`procurement`.`procurement_category` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `airlines_ecm`.`procurement`.`procurement_category` ALTER COLUMN `gl_account_default` SET TAGS ('dbx_business_glossary_term' = 'Default General Ledger (GL) Account');
ALTER TABLE `airlines_ecm`.`procurement`.`procurement_category` ALTER COLUMN `gl_account_default` SET TAGS ('dbx_value_regex' = '^[0-9]{6,10}$');
ALTER TABLE `airlines_ecm`.`procurement`.`procurement_category` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `airlines_ecm`.`procurement`.`procurement_category` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `airlines_ecm`.`procurement`.`procurement_category` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time (Days)');
ALTER TABLE `airlines_ecm`.`procurement`.`procurement_category` ALTER COLUMN `minimum_order_value` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Value');
ALTER TABLE `airlines_ecm`.`procurement`.`procurement_category` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `airlines_ecm`.`procurement`.`procurement_category` ALTER COLUMN `preferred_vendor_count` SET TAGS ('dbx_business_glossary_term' = 'Preferred Vendor Count');
ALTER TABLE `airlines_ecm`.`procurement`.`procurement_category` ALTER COLUMN `risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Risk Rating');
ALTER TABLE `airlines_ecm`.`procurement`.`procurement_category` ALTER COLUMN `risk_rating` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `airlines_ecm`.`procurement`.`procurement_category` ALTER COLUMN `sourcing_strategy` SET TAGS ('dbx_business_glossary_term' = 'Sourcing Strategy');
ALTER TABLE `airlines_ecm`.`procurement`.`procurement_category` ALTER COLUMN `sourcing_strategy` SET TAGS ('dbx_value_regex' = 'single_source|dual_source|competitive_tender|catalogue|framework_agreement|spot_buy');
ALTER TABLE `airlines_ecm`.`procurement`.`procurement_category` ALTER COLUMN `strategic_importance` SET TAGS ('dbx_business_glossary_term' = 'Strategic Importance (Kraljic Matrix Quadrant)');
ALTER TABLE `airlines_ecm`.`procurement`.`procurement_category` ALTER COLUMN `strategic_importance` SET TAGS ('dbx_value_regex' = 'strategic|leverage|bottleneck|non-critical');
ALTER TABLE `airlines_ecm`.`procurement`.`procurement_category` ALTER COLUMN `sustainability_flag` SET TAGS ('dbx_business_glossary_term' = 'Sustainability Flag');
ALTER TABLE `airlines_ecm`.`procurement`.`procurement_category` ALTER COLUMN `tax_category_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Category Code');
ALTER TABLE `airlines_ecm`.`procurement`.`procurement_category` ALTER COLUMN `tax_category_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,6}$');
ALTER TABLE `airlines_ecm`.`procurement`.`procurement_category` ALTER COLUMN `unspsc_code` SET TAGS ('dbx_business_glossary_term' = 'United Nations Standard Products and Services Code (UNSPSC)');
ALTER TABLE `airlines_ecm`.`procurement`.`procurement_category` ALTER COLUMN `unspsc_code` SET TAGS ('dbx_value_regex' = '^[0-9]{8}$');
ALTER TABLE `airlines_ecm`.`procurement`.`approved_vendor_list` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `airlines_ecm`.`procurement`.`approved_vendor_list` SET TAGS ('dbx_subdomain' = 'supplier_management');
ALTER TABLE `airlines_ecm`.`procurement`.`approved_vendor_list` ALTER COLUMN `approved_vendor_list_id` SET TAGS ('dbx_business_glossary_term' = 'Approved Vendor List (AVL) Entry ID');
ALTER TABLE `airlines_ecm`.`procurement`.`approved_vendor_list` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Employee Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`procurement`.`approved_vendor_list` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`procurement`.`approved_vendor_list` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `airlines_ecm`.`procurement`.`approved_vendor_list` ALTER COLUMN `procurement_category_id` SET TAGS ('dbx_business_glossary_term' = 'Procurement Category Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`procurement`.`approved_vendor_list` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `airlines_ecm`.`procurement`.`approved_vendor_list` ALTER COLUMN `superseded_approved_vendor_list_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `airlines_ecm`.`procurement`.`approved_vendor_list` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `airlines_ecm`.`procurement`.`approved_vendor_list` ALTER COLUMN `approval_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Expiry Date');
ALTER TABLE `airlines_ecm`.`procurement`.`approved_vendor_list` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `airlines_ecm`.`procurement`.`approved_vendor_list` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'approved|conditional|suspended|delisted|pending_review|expired');
ALTER TABLE `airlines_ecm`.`procurement`.`approved_vendor_list` ALTER COLUMN `audit_date` SET TAGS ('dbx_business_glossary_term' = 'Audit Date');
ALTER TABLE `airlines_ecm`.`procurement`.`approved_vendor_list` ALTER COLUMN `audit_score` SET TAGS ('dbx_business_glossary_term' = 'Audit Score');
ALTER TABLE `airlines_ecm`.`procurement`.`approved_vendor_list` ALTER COLUMN `conditional_approval_restrictions` SET TAGS ('dbx_business_glossary_term' = 'Conditional Approval Restrictions');
ALTER TABLE `airlines_ecm`.`procurement`.`approved_vendor_list` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `airlines_ecm`.`procurement`.`approved_vendor_list` ALTER COLUMN `delisting_date` SET TAGS ('dbx_business_glossary_term' = 'Delisting Date');
ALTER TABLE `airlines_ecm`.`procurement`.`approved_vendor_list` ALTER COLUMN `delisting_reason` SET TAGS ('dbx_business_glossary_term' = 'Delisting Reason');
ALTER TABLE `airlines_ecm`.`procurement`.`approved_vendor_list` ALTER COLUMN `easa_part145_approved_flag` SET TAGS ('dbx_business_glossary_term' = 'European Union Aviation Safety Agency (EASA) Part-145 Approved Flag');
ALTER TABLE `airlines_ecm`.`procurement`.`approved_vendor_list` ALTER COLUMN `faa_repair_station_certificate_number` SET TAGS ('dbx_business_glossary_term' = 'Federal Aviation Administration (FAA) Repair Station Certificate Number');
ALTER TABLE `airlines_ecm`.`procurement`.`approved_vendor_list` ALTER COLUMN `faa_repair_station_certificate_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,15}$');
ALTER TABLE `airlines_ecm`.`procurement`.`approved_vendor_list` ALTER COLUMN `faa_repair_station_flag` SET TAGS ('dbx_business_glossary_term' = 'Federal Aviation Administration (FAA) Repair Station Flag');
ALTER TABLE `airlines_ecm`.`procurement`.`approved_vendor_list` ALTER COLUMN `geographic_restriction` SET TAGS ('dbx_business_glossary_term' = 'Geographic Restriction');
ALTER TABLE `airlines_ecm`.`procurement`.`approved_vendor_list` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_business_glossary_term' = 'Geographic Scope');
ALTER TABLE `airlines_ecm`.`procurement`.`approved_vendor_list` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_value_regex' = 'global|regional|station_specific|country_specific');
ALTER TABLE `airlines_ecm`.`procurement`.`approved_vendor_list` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `airlines_ecm`.`procurement`.`approved_vendor_list` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `airlines_ecm`.`procurement`.`approved_vendor_list` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time Days');
ALTER TABLE `airlines_ecm`.`procurement`.`approved_vendor_list` ALTER COLUMN `minimum_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity (MOQ)');
ALTER TABLE `airlines_ecm`.`procurement`.`approved_vendor_list` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `airlines_ecm`.`procurement`.`approved_vendor_list` ALTER COLUMN `oem_authorization_flag` SET TAGS ('dbx_business_glossary_term' = 'Original Equipment Manufacturer (OEM) Authorization Flag');
ALTER TABLE `airlines_ecm`.`procurement`.`approved_vendor_list` ALTER COLUMN `oem_authorization_reference` SET TAGS ('dbx_business_glossary_term' = 'Original Equipment Manufacturer (OEM) Authorization Reference');
ALTER TABLE `airlines_ecm`.`procurement`.`approved_vendor_list` ALTER COLUMN `part_number` SET TAGS ('dbx_business_glossary_term' = 'Part Number');
ALTER TABLE `airlines_ecm`.`procurement`.`approved_vendor_list` ALTER COLUMN `part_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{6,25}$');
ALTER TABLE `airlines_ecm`.`procurement`.`approved_vendor_list` ALTER COLUMN `preferred_vendor_flag` SET TAGS ('dbx_business_glossary_term' = 'Preferred Vendor Flag');
ALTER TABLE `airlines_ecm`.`procurement`.`approved_vendor_list` ALTER COLUMN `qualification_basis` SET TAGS ('dbx_business_glossary_term' = 'Qualification Basis');
ALTER TABLE `airlines_ecm`.`procurement`.`approved_vendor_list` ALTER COLUMN `qualification_basis` SET TAGS ('dbx_value_regex' = 'audit_passed|oem_authorization|regulatory_approval|historical_performance|quality_certification|technical_evaluation');
ALTER TABLE `airlines_ecm`.`procurement`.`approved_vendor_list` ALTER COLUMN `quality_certification_reference` SET TAGS ('dbx_business_glossary_term' = 'Quality Certification Reference');
ALTER TABLE `airlines_ecm`.`procurement`.`approved_vendor_list` ALTER COLUMN `quality_system_certification_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Quality System Certification Required Flag');
ALTER TABLE `airlines_ecm`.`procurement`.`approved_vendor_list` ALTER COLUMN `remarks` SET TAGS ('dbx_business_glossary_term' = 'Remarks');
ALTER TABLE `airlines_ecm`.`procurement`.`approved_vendor_list` ALTER COLUMN `sole_source_flag` SET TAGS ('dbx_business_glossary_term' = 'Sole Source Flag');
ALTER TABLE `airlines_ecm`.`procurement`.`approved_vendor_list` ALTER COLUMN `suspension_date` SET TAGS ('dbx_business_glossary_term' = 'Suspension Date');
ALTER TABLE `airlines_ecm`.`procurement`.`approved_vendor_list` ALTER COLUMN `suspension_reason` SET TAGS ('dbx_business_glossary_term' = 'Suspension Reason');
ALTER TABLE `airlines_ecm`.`procurement`.`spend_record` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `airlines_ecm`.`procurement`.`spend_record` SET TAGS ('dbx_subdomain' = 'inventory_control');
ALTER TABLE `airlines_ecm`.`procurement`.`spend_record` ALTER COLUMN `spend_record_id` SET TAGS ('dbx_business_glossary_term' = 'Spend Record ID');
ALTER TABLE `airlines_ecm`.`procurement`.`spend_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approver Employee ID');
ALTER TABLE `airlines_ecm`.`procurement`.`spend_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`procurement`.`spend_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `airlines_ecm`.`procurement`.`spend_record` ALTER COLUMN `primary_spend_requisitioner_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Requisitioner Employee ID');
ALTER TABLE `airlines_ecm`.`procurement`.`spend_record` ALTER COLUMN `primary_spend_requisitioner_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`procurement`.`spend_record` ALTER COLUMN `primary_spend_requisitioner_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `airlines_ecm`.`procurement`.`spend_record` ALTER COLUMN `procurement_category_id` SET TAGS ('dbx_business_glossary_term' = 'Procurement Category Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`procurement`.`spend_record` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`procurement`.`spend_record` ALTER COLUMN `supply_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Supply Contract Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`procurement`.`spend_record` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `airlines_ecm`.`procurement`.`spend_record` ALTER COLUMN `vendor_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Invoice Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`procurement`.`spend_record` ALTER COLUMN `reversal_spend_record_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `airlines_ecm`.`procurement`.`spend_record` ALTER COLUMN `aircraft_registration` SET TAGS ('dbx_business_glossary_term' = 'Aircraft Registration');
ALTER TABLE `airlines_ecm`.`procurement`.`spend_record` ALTER COLUMN `business_unit` SET TAGS ('dbx_business_glossary_term' = 'Business Unit');
ALTER TABLE `airlines_ecm`.`procurement`.`spend_record` ALTER COLUMN `cost_centre_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Centre Code');
ALTER TABLE `airlines_ecm`.`procurement`.`spend_record` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `airlines_ecm`.`procurement`.`spend_record` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `airlines_ecm`.`procurement`.`spend_record` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`procurement`.`spend_record` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount');
ALTER TABLE `airlines_ecm`.`procurement`.`spend_record` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate');
ALTER TABLE `airlines_ecm`.`procurement`.`spend_record` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `airlines_ecm`.`procurement`.`spend_record` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `airlines_ecm`.`procurement`.`spend_record` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `airlines_ecm`.`procurement`.`spend_record` ALTER COLUMN `goods_receipt_date` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt Date');
ALTER TABLE `airlines_ecm`.`procurement`.`spend_record` ALTER COLUMN `invoice_date` SET TAGS ('dbx_business_glossary_term' = 'Invoice Date');
ALTER TABLE `airlines_ecm`.`procurement`.`spend_record` ALTER COLUMN `invoice_number` SET TAGS ('dbx_business_glossary_term' = 'Invoice Number');
ALTER TABLE `airlines_ecm`.`procurement`.`spend_record` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `airlines_ecm`.`procurement`.`spend_record` ALTER COLUMN `local_currency_amount` SET TAGS ('dbx_business_glossary_term' = 'Local Currency Amount');
ALTER TABLE `airlines_ecm`.`procurement`.`spend_record` ALTER COLUMN `maverick_spend_flag` SET TAGS ('dbx_business_glossary_term' = 'Maverick Spend Flag');
ALTER TABLE `airlines_ecm`.`procurement`.`spend_record` ALTER COLUMN `net_spend_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Spend Amount');
ALTER TABLE `airlines_ecm`.`procurement`.`spend_record` ALTER COLUMN `payment_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Date');
ALTER TABLE `airlines_ecm`.`procurement`.`spend_record` ALTER COLUMN `payment_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Status');
ALTER TABLE `airlines_ecm`.`procurement`.`spend_record` ALTER COLUMN `payment_status` SET TAGS ('dbx_value_regex' = 'Pending|Approved|Paid|Overdue|Disputed|Cancelled');
ALTER TABLE `airlines_ecm`.`procurement`.`spend_record` ALTER COLUMN `po_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Number');
ALTER TABLE `airlines_ecm`.`procurement`.`spend_record` ALTER COLUMN `savings_amount` SET TAGS ('dbx_business_glossary_term' = 'Savings Amount');
ALTER TABLE `airlines_ecm`.`procurement`.`spend_record` ALTER COLUMN `sourcing_channel` SET TAGS ('dbx_business_glossary_term' = 'Sourcing Channel');
ALTER TABLE `airlines_ecm`.`procurement`.`spend_record` ALTER COLUMN `sourcing_channel` SET TAGS ('dbx_value_regex' = 'Contracted|Spot|Catalogue|P-Card|Emergency');
ALTER TABLE `airlines_ecm`.`procurement`.`spend_record` ALTER COLUMN `spend_amount` SET TAGS ('dbx_business_glossary_term' = 'Spend Amount');
ALTER TABLE `airlines_ecm`.`procurement`.`spend_record` ALTER COLUMN `spend_date` SET TAGS ('dbx_business_glossary_term' = 'Spend Date');
ALTER TABLE `airlines_ecm`.`procurement`.`spend_record` ALTER COLUMN `spend_type` SET TAGS ('dbx_business_glossary_term' = 'Spend Type');
ALTER TABLE `airlines_ecm`.`procurement`.`spend_record` ALTER COLUMN `spend_type` SET TAGS ('dbx_value_regex' = 'PO-backed|Non-PO|Contract-backed|P-Card|Spot');
ALTER TABLE `airlines_ecm`.`procurement`.`spend_record` ALTER COLUMN `station_code` SET TAGS ('dbx_business_glossary_term' = 'Station Code');
ALTER TABLE `airlines_ecm`.`procurement`.`spend_record` ALTER COLUMN `station_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`procurement`.`spend_record` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `airlines_ecm`.`procurement`.`ground_service_order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `airlines_ecm`.`procurement`.`ground_service_order` SET TAGS ('dbx_subdomain' = 'order_processing');
ALTER TABLE `airlines_ecm`.`procurement`.`ground_service_order` ALTER COLUMN `ground_service_order_id` SET TAGS ('dbx_business_glossary_term' = 'Ground Service Order ID');
ALTER TABLE `airlines_ecm`.`procurement`.`ground_service_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Employee Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`procurement`.`ground_service_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`procurement`.`ground_service_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `airlines_ecm`.`procurement`.`ground_service_order` ALTER COLUMN `supply_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Supply Contract Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`procurement`.`ground_service_order` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `airlines_ecm`.`procurement`.`ground_service_order` ALTER COLUMN `amended_ground_service_order_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `airlines_ecm`.`procurement`.`ground_service_order` ALTER COLUMN `actual_service_end_time` SET TAGS ('dbx_business_glossary_term' = 'Actual Service End Time');
ALTER TABLE `airlines_ecm`.`procurement`.`ground_service_order` ALTER COLUMN `actual_service_start_time` SET TAGS ('dbx_business_glossary_term' = 'Actual Service Start Time');
ALTER TABLE `airlines_ecm`.`procurement`.`ground_service_order` ALTER COLUMN `aircraft_registration` SET TAGS ('dbx_business_glossary_term' = 'Aircraft Registration Number');
ALTER TABLE `airlines_ecm`.`procurement`.`ground_service_order` ALTER COLUMN `aircraft_registration` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{5,8}$');
ALTER TABLE `airlines_ecm`.`procurement`.`ground_service_order` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `airlines_ecm`.`procurement`.`ground_service_order` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `airlines_ecm`.`procurement`.`ground_service_order` ALTER COLUMN `cancelled_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Timestamp');
ALTER TABLE `airlines_ecm`.`procurement`.`ground_service_order` ALTER COLUMN `contracted_service_level` SET TAGS ('dbx_business_glossary_term' = 'Contracted Service Level');
ALTER TABLE `airlines_ecm`.`procurement`.`ground_service_order` ALTER COLUMN `contracted_service_level` SET TAGS ('dbx_value_regex' = 'standard|premium|express|basic');
ALTER TABLE `airlines_ecm`.`procurement`.`ground_service_order` ALTER COLUMN `cost_center` SET TAGS ('dbx_business_glossary_term' = 'Cost Center');
ALTER TABLE `airlines_ecm`.`procurement`.`ground_service_order` ALTER COLUMN `cost_center` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `airlines_ecm`.`procurement`.`ground_service_order` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `airlines_ecm`.`procurement`.`ground_service_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `airlines_ecm`.`procurement`.`ground_service_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`procurement`.`ground_service_order` ALTER COLUMN `dispute_flag` SET TAGS ('dbx_business_glossary_term' = 'Dispute Flag');
ALTER TABLE `airlines_ecm`.`procurement`.`ground_service_order` ALTER COLUMN `dispute_reason` SET TAGS ('dbx_business_glossary_term' = 'Dispute Reason');
ALTER TABLE `airlines_ecm`.`procurement`.`ground_service_order` ALTER COLUMN `flight_leg_reference` SET TAGS ('dbx_business_glossary_term' = 'Flight Leg Reference');
ALTER TABLE `airlines_ecm`.`procurement`.`ground_service_order` ALTER COLUMN `flight_leg_reference` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2}[0-9]{1,4}-[0-9]{8}$');
ALTER TABLE `airlines_ecm`.`procurement`.`ground_service_order` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `airlines_ecm`.`procurement`.`ground_service_order` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_value_regex' = '^[0-9]{4,8}$');
ALTER TABLE `airlines_ecm`.`procurement`.`ground_service_order` ALTER COLUMN `invoice_reference` SET TAGS ('dbx_business_glossary_term' = 'Vendor Invoice Reference');
ALTER TABLE `airlines_ecm`.`procurement`.`ground_service_order` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `airlines_ecm`.`procurement`.`ground_service_order` ALTER COLUMN `order_placed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Order Placed Timestamp');
ALTER TABLE `airlines_ecm`.`procurement`.`ground_service_order` ALTER COLUMN `order_status` SET TAGS ('dbx_business_glossary_term' = 'Order Status');
ALTER TABLE `airlines_ecm`.`procurement`.`ground_service_order` ALTER COLUMN `order_value_amount` SET TAGS ('dbx_business_glossary_term' = 'Order Value Amount');
ALTER TABLE `airlines_ecm`.`procurement`.`ground_service_order` ALTER COLUMN `payment_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Status');
ALTER TABLE `airlines_ecm`.`procurement`.`ground_service_order` ALTER COLUMN `payment_status` SET TAGS ('dbx_value_regex' = 'pending|approved|paid|disputed|cancelled');
ALTER TABLE `airlines_ecm`.`procurement`.`ground_service_order` ALTER COLUMN `penalty_amount` SET TAGS ('dbx_business_glossary_term' = 'Penalty Amount');
ALTER TABLE `airlines_ecm`.`procurement`.`ground_service_order` ALTER COLUMN `penalty_trigger_flag` SET TAGS ('dbx_business_glossary_term' = 'Penalty Trigger Flag');
ALTER TABLE `airlines_ecm`.`procurement`.`ground_service_order` ALTER COLUMN `scheduled_service_start_time` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Service Start Time');
ALTER TABLE `airlines_ecm`.`procurement`.`ground_service_order` ALTER COLUMN `service_completion_status` SET TAGS ('dbx_business_glossary_term' = 'Service Completion Status');
ALTER TABLE `airlines_ecm`.`procurement`.`ground_service_order` ALTER COLUMN `service_completion_status` SET TAGS ('dbx_value_regex' = 'completed|partial|failed|cancelled|not_started');
ALTER TABLE `airlines_ecm`.`procurement`.`ground_service_order` ALTER COLUMN `service_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Service Duration (Minutes)');
ALTER TABLE `airlines_ecm`.`procurement`.`ground_service_order` ALTER COLUMN `service_order_number` SET TAGS ('dbx_business_glossary_term' = 'Service Order Number');
ALTER TABLE `airlines_ecm`.`procurement`.`ground_service_order` ALTER COLUMN `service_order_number` SET TAGS ('dbx_value_regex' = '^GSO-[A-Z0-9]{8,12}$');
ALTER TABLE `airlines_ecm`.`procurement`.`ground_service_order` ALTER COLUMN `service_quality_score` SET TAGS ('dbx_business_glossary_term' = 'Service Quality Score');
ALTER TABLE `airlines_ecm`.`procurement`.`ground_service_order` ALTER COLUMN `service_scope_description` SET TAGS ('dbx_business_glossary_term' = 'Service Scope Description');
ALTER TABLE `airlines_ecm`.`procurement`.`ground_service_order` ALTER COLUMN `service_type` SET TAGS ('dbx_business_glossary_term' = 'Ground Service Type');
ALTER TABLE `airlines_ecm`.`procurement`.`ground_service_order` ALTER COLUMN `sla_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Compliance Flag');
ALTER TABLE `airlines_ecm`.`procurement`.`ground_service_order` ALTER COLUMN `special_instructions` SET TAGS ('dbx_business_glossary_term' = 'Special Instructions');
ALTER TABLE `airlines_ecm`.`procurement`.`ground_service_order` ALTER COLUMN `station_code` SET TAGS ('dbx_business_glossary_term' = 'Station Code (IATA Airport Code)');
ALTER TABLE `airlines_ecm`.`procurement`.`ground_service_order` ALTER COLUMN `station_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`procurement`.`ground_service_order` ALTER COLUMN `turnaround_reference` SET TAGS ('dbx_business_glossary_term' = 'Turnaround Reference');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_audit` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_audit` SET TAGS ('dbx_subdomain' = 'supplier_management');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_audit` ALTER COLUMN `vendor_audit_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Audit Identifier (ID)');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_audit` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Lead Employee Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_audit` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_audit` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_audit` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Identifier (ID)');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_audit` ALTER COLUMN `follow_up_vendor_audit_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_audit` ALTER COLUMN `approval_authority` SET TAGS ('dbx_business_glossary_term' = 'Approval Authority');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_audit` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_audit` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_audit` ALTER COLUMN `audit_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Audit Cost Amount');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_audit` ALTER COLUMN `audit_cost_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_audit` ALTER COLUMN `audit_cost_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Audit Cost Currency Code');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_audit` ALTER COLUMN `audit_cost_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_audit` ALTER COLUMN `audit_date` SET TAGS ('dbx_business_glossary_term' = 'Audit Date');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_audit` ALTER COLUMN `audit_duration_days` SET TAGS ('dbx_business_glossary_term' = 'Audit Duration Days');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_audit` ALTER COLUMN `audit_end_date` SET TAGS ('dbx_business_glossary_term' = 'Audit End Date');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_audit` ALTER COLUMN `audit_lead_organization` SET TAGS ('dbx_business_glossary_term' = 'Audit Lead Organization');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_audit` ALTER COLUMN `audit_location` SET TAGS ('dbx_business_glossary_term' = 'Audit Location');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_audit` ALTER COLUMN `audit_method` SET TAGS ('dbx_business_glossary_term' = 'Audit Method');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_audit` ALTER COLUMN `audit_method` SET TAGS ('dbx_value_regex' = 'on_site|remote|hybrid');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_audit` ALTER COLUMN `audit_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Audit Reference Number');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_audit` ALTER COLUMN `audit_reference_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{6,20}$');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_audit` ALTER COLUMN `audit_report_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Audit Report Document Reference');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_audit` ALTER COLUMN `audit_scope` SET TAGS ('dbx_business_glossary_term' = 'Audit Scope');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_audit` ALTER COLUMN `audit_status` SET TAGS ('dbx_business_glossary_term' = 'Audit Status');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_audit` ALTER COLUMN `audit_status` SET TAGS ('dbx_value_regex' = 'scheduled|in_progress|completed|cancelled|report_pending');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_audit` ALTER COLUMN `audit_type` SET TAGS ('dbx_business_glossary_term' = 'Audit Type');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_audit` ALTER COLUMN `audit_type` SET TAGS ('dbx_value_regex' = 'initial_qualification|periodic_surveillance|for_cause|re_qualification|special_audit|desktop_review');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_audit` ALTER COLUMN `auditor_team_size` SET TAGS ('dbx_business_glossary_term' = 'Auditor Team Size');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_audit` ALTER COLUMN `certification_standard` SET TAGS ('dbx_business_glossary_term' = 'Certification Standard');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_audit` ALTER COLUMN `corrective_action_deadline` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Deadline');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_audit` ALTER COLUMN `corrective_action_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Required Flag');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_audit` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_audit` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_audit` ALTER COLUMN `major_findings_count` SET TAGS ('dbx_business_glossary_term' = 'Major Findings Count');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_audit` ALTER COLUMN `minor_findings_count` SET TAGS ('dbx_business_glossary_term' = 'Minor Findings Count');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_audit` ALTER COLUMN `next_audit_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Audit Due Date');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_audit` ALTER COLUMN `observations_count` SET TAGS ('dbx_business_glossary_term' = 'Observations Count');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_audit` ALTER COLUMN `overall_audit_result` SET TAGS ('dbx_business_glossary_term' = 'Overall Audit Result');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_audit` ALTER COLUMN `overall_audit_result` SET TAGS ('dbx_value_regex' = 'pass|conditional_pass|fail|pending');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_audit` ALTER COLUMN `re_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Re-Audit Date');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_audit` ALTER COLUMN `re_audit_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Re-Audit Required Flag');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_audit` ALTER COLUMN `regulatory_authority` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Authority');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_audit` ALTER COLUMN `remarks` SET TAGS ('dbx_business_glossary_term' = 'Remarks');
ALTER TABLE `airlines_ecm`.`procurement`.`contract_price_schedule` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `airlines_ecm`.`procurement`.`contract_price_schedule` SET TAGS ('dbx_subdomain' = 'inventory_control');
ALTER TABLE `airlines_ecm`.`procurement`.`contract_price_schedule` ALTER COLUMN `contract_price_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Price Schedule ID');
ALTER TABLE `airlines_ecm`.`procurement`.`contract_price_schedule` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Employee ID');
ALTER TABLE `airlines_ecm`.`procurement`.`contract_price_schedule` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`procurement`.`contract_price_schedule` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `airlines_ecm`.`procurement`.`contract_price_schedule` ALTER COLUMN `part_master_id` SET TAGS ('dbx_business_glossary_term' = 'Part Master Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`procurement`.`contract_price_schedule` ALTER COLUMN `superseded_by_schedule_contract_price_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded By Schedule ID');
ALTER TABLE `airlines_ecm`.`procurement`.`contract_price_schedule` ALTER COLUMN `supply_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Supply Contract ID');
ALTER TABLE `airlines_ecm`.`procurement`.`contract_price_schedule` ALTER COLUMN `superseded_contract_price_schedule_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `airlines_ecm`.`procurement`.`contract_price_schedule` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `airlines_ecm`.`procurement`.`contract_price_schedule` ALTER COLUMN `base_unit_price` SET TAGS ('dbx_business_glossary_term' = 'Base Unit Price');
ALTER TABLE `airlines_ecm`.`procurement`.`contract_price_schedule` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `airlines_ecm`.`procurement`.`contract_price_schedule` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `airlines_ecm`.`procurement`.`contract_price_schedule` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`procurement`.`contract_price_schedule` ALTER COLUMN `discount_percentage` SET TAGS ('dbx_business_glossary_term' = 'Discount Percentage');
ALTER TABLE `airlines_ecm`.`procurement`.`contract_price_schedule` ALTER COLUMN `escalation_cap_percentage` SET TAGS ('dbx_business_glossary_term' = 'Escalation Cap Percentage');
ALTER TABLE `airlines_ecm`.`procurement`.`contract_price_schedule` ALTER COLUMN `escalation_frequency` SET TAGS ('dbx_business_glossary_term' = 'Escalation Frequency');
ALTER TABLE `airlines_ecm`.`procurement`.`contract_price_schedule` ALTER COLUMN `escalation_frequency` SET TAGS ('dbx_value_regex' = 'MONTHLY|QUARTERLY|SEMI_ANNUAL|ANNUAL|NONE');
ALTER TABLE `airlines_ecm`.`procurement`.`contract_price_schedule` ALTER COLUMN `incoterm` SET TAGS ('dbx_business_glossary_term' = 'Incoterm');
ALTER TABLE `airlines_ecm`.`procurement`.`contract_price_schedule` ALTER COLUMN `item_description` SET TAGS ('dbx_business_glossary_term' = 'Item Description');
ALTER TABLE `airlines_ecm`.`procurement`.`contract_price_schedule` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `airlines_ecm`.`procurement`.`contract_price_schedule` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time Days');
ALTER TABLE `airlines_ecm`.`procurement`.`contract_price_schedule` ALTER COLUMN `maximum_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Maximum Order Quantity');
ALTER TABLE `airlines_ecm`.`procurement`.`contract_price_schedule` ALTER COLUMN `minimum_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity (MOQ)');
ALTER TABLE `airlines_ecm`.`procurement`.`contract_price_schedule` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `airlines_ecm`.`procurement`.`contract_price_schedule` ALTER COLUMN `payment_terms_code` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms Code');
ALTER TABLE `airlines_ecm`.`procurement`.`contract_price_schedule` ALTER COLUMN `payment_terms_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,6}$');
ALTER TABLE `airlines_ecm`.`procurement`.`contract_price_schedule` ALTER COLUMN `price_escalation_index_type` SET TAGS ('dbx_business_glossary_term' = 'Price Escalation Index Type');
ALTER TABLE `airlines_ecm`.`procurement`.`contract_price_schedule` ALTER COLUMN `price_escalation_index_type` SET TAGS ('dbx_value_regex' = 'CPI|PPI|FUEL|LABOR|CUSTOM|NONE');
ALTER TABLE `airlines_ecm`.`procurement`.`contract_price_schedule` ALTER COLUMN `price_validity_end_date` SET TAGS ('dbx_business_glossary_term' = 'Price Validity End Date');
ALTER TABLE `airlines_ecm`.`procurement`.`contract_price_schedule` ALTER COLUMN `price_validity_start_date` SET TAGS ('dbx_business_glossary_term' = 'Price Validity Start Date');
ALTER TABLE `airlines_ecm`.`procurement`.`contract_price_schedule` ALTER COLUMN `schedule_line_number` SET TAGS ('dbx_business_glossary_term' = 'Schedule Line Number');
ALTER TABLE `airlines_ecm`.`procurement`.`contract_price_schedule` ALTER COLUMN `schedule_status` SET TAGS ('dbx_business_glossary_term' = 'Schedule Status');
ALTER TABLE `airlines_ecm`.`procurement`.`contract_price_schedule` ALTER COLUMN `schedule_status` SET TAGS ('dbx_value_regex' = 'ACTIVE|SUPERSEDED|EXPIRED|SUSPENDED|PENDING');
ALTER TABLE `airlines_ecm`.`procurement`.`contract_price_schedule` ALTER COLUMN `service_code` SET TAGS ('dbx_business_glossary_term' = 'Service Code');
ALTER TABLE `airlines_ecm`.`procurement`.`contract_price_schedule` ALTER COLUMN `service_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,12}$');
ALTER TABLE `airlines_ecm`.`procurement`.`contract_price_schedule` ALTER COLUMN `tax_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Code');
ALTER TABLE `airlines_ecm`.`procurement`.`contract_price_schedule` ALTER COLUMN `tax_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,4}$');
ALTER TABLE `airlines_ecm`.`procurement`.`contract_price_schedule` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `airlines_ecm`.`procurement`.`contract_price_schedule` ALTER COLUMN `vendor_part_number` SET TAGS ('dbx_business_glossary_term' = 'Vendor Part Number');
ALTER TABLE `airlines_ecm`.`procurement`.`contract_price_schedule` ALTER COLUMN `volume_tier_1_breakpoint` SET TAGS ('dbx_business_glossary_term' = 'Volume Tier 1 Breakpoint');
ALTER TABLE `airlines_ecm`.`procurement`.`contract_price_schedule` ALTER COLUMN `volume_tier_1_price` SET TAGS ('dbx_business_glossary_term' = 'Volume Tier 1 Price');
ALTER TABLE `airlines_ecm`.`procurement`.`contract_price_schedule` ALTER COLUMN `volume_tier_2_breakpoint` SET TAGS ('dbx_business_glossary_term' = 'Volume Tier 2 Breakpoint');
ALTER TABLE `airlines_ecm`.`procurement`.`contract_price_schedule` ALTER COLUMN `volume_tier_2_price` SET TAGS ('dbx_business_glossary_term' = 'Volume Tier 2 Price');
ALTER TABLE `airlines_ecm`.`procurement`.`contract_price_schedule` ALTER COLUMN `volume_tier_3_breakpoint` SET TAGS ('dbx_business_glossary_term' = 'Volume Tier 3 Breakpoint');
ALTER TABLE `airlines_ecm`.`procurement`.`contract_price_schedule` ALTER COLUMN `volume_tier_3_price` SET TAGS ('dbx_business_glossary_term' = 'Volume Tier 3 Price');
ALTER TABLE `airlines_ecm`.`procurement`.`mro_exchange_order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `airlines_ecm`.`procurement`.`mro_exchange_order` SET TAGS ('dbx_subdomain' = 'order_processing');
ALTER TABLE `airlines_ecm`.`procurement`.`mro_exchange_order` ALTER COLUMN `mro_exchange_order_id` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Repair and Overhaul (MRO) Exchange Order ID');
ALTER TABLE `airlines_ecm`.`procurement`.`mro_exchange_order` ALTER COLUMN `part_master_id` SET TAGS ('dbx_business_glossary_term' = 'Part Master Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`procurement`.`mro_exchange_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Requested By Employee ID');
ALTER TABLE `airlines_ecm`.`procurement`.`mro_exchange_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`procurement`.`mro_exchange_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `airlines_ecm`.`procurement`.`mro_exchange_order` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `airlines_ecm`.`procurement`.`mro_exchange_order` ALTER COLUMN `return_mro_exchange_order_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `airlines_ecm`.`procurement`.`mro_exchange_order` ALTER COLUMN `actual_return_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Component Return Date');
ALTER TABLE `airlines_ecm`.`procurement`.`mro_exchange_order` ALTER COLUMN `aircraft_registration` SET TAGS ('dbx_business_glossary_term' = 'Aircraft Registration Number');
ALTER TABLE `airlines_ecm`.`procurement`.`mro_exchange_order` ALTER COLUMN `aircraft_registration` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{5,10}$');
ALTER TABLE `airlines_ecm`.`procurement`.`mro_exchange_order` ALTER COLUMN `airworthiness_release_document` SET TAGS ('dbx_business_glossary_term' = 'Airworthiness Release Document Reference');
ALTER TABLE `airlines_ecm`.`procurement`.`mro_exchange_order` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `airlines_ecm`.`procurement`.`mro_exchange_order` ALTER COLUMN `ata_chapter` SET TAGS ('dbx_business_glossary_term' = 'Air Transport Association (ATA) Chapter Code');
ALTER TABLE `airlines_ecm`.`procurement`.`mro_exchange_order` ALTER COLUMN `ata_chapter` SET TAGS ('dbx_value_regex' = '^[0-9]{2}$');
ALTER TABLE `airlines_ecm`.`procurement`.`mro_exchange_order` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `airlines_ecm`.`procurement`.`mro_exchange_order` ALTER COLUMN `closed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Order Closed Timestamp');
ALTER TABLE `airlines_ecm`.`procurement`.`mro_exchange_order` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `airlines_ecm`.`procurement`.`mro_exchange_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `airlines_ecm`.`procurement`.`mro_exchange_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`procurement`.`mro_exchange_order` ALTER COLUMN `dispatch_date` SET TAGS ('dbx_business_glossary_term' = 'Component Dispatch Date');
ALTER TABLE `airlines_ecm`.`procurement`.`mro_exchange_order` ALTER COLUMN `exchange_fee` SET TAGS ('dbx_business_glossary_term' = 'Exchange Fee Amount');
ALTER TABLE `airlines_ecm`.`procurement`.`mro_exchange_order` ALTER COLUMN `exchange_order_number` SET TAGS ('dbx_business_glossary_term' = 'Exchange Order Number');
ALTER TABLE `airlines_ecm`.`procurement`.`mro_exchange_order` ALTER COLUMN `exchange_order_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{6,20}$');
ALTER TABLE `airlines_ecm`.`procurement`.`mro_exchange_order` ALTER COLUMN `expected_return_date` SET TAGS ('dbx_business_glossary_term' = 'Expected Component Return Date');
ALTER TABLE `airlines_ecm`.`procurement`.`mro_exchange_order` ALTER COLUMN `incoming_condition` SET TAGS ('dbx_business_glossary_term' = 'Incoming Component Condition');
ALTER TABLE `airlines_ecm`.`procurement`.`mro_exchange_order` ALTER COLUMN `incoming_condition` SET TAGS ('dbx_value_regex' = 'serviceable|overhauled|repaired|as-new');
ALTER TABLE `airlines_ecm`.`procurement`.`mro_exchange_order` ALTER COLUMN `incoming_serial_number` SET TAGS ('dbx_business_glossary_term' = 'Incoming Component Serial Number');
ALTER TABLE `airlines_ecm`.`procurement`.`mro_exchange_order` ALTER COLUMN `incoming_serial_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{4,20}$');
ALTER TABLE `airlines_ecm`.`procurement`.`mro_exchange_order` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `airlines_ecm`.`procurement`.`mro_exchange_order` ALTER COLUMN `loan_fee_per_day` SET TAGS ('dbx_business_glossary_term' = 'Loan Fee Per Day Amount');
ALTER TABLE `airlines_ecm`.`procurement`.`mro_exchange_order` ALTER COLUMN `maximum_loan_period_days` SET TAGS ('dbx_business_glossary_term' = 'Maximum Loan Period in Days');
ALTER TABLE `airlines_ecm`.`procurement`.`mro_exchange_order` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Exchange Order Notes');
ALTER TABLE `airlines_ecm`.`procurement`.`mro_exchange_order` ALTER COLUMN `order_status` SET TAGS ('dbx_business_glossary_term' = 'Exchange Order Status');
ALTER TABLE `airlines_ecm`.`procurement`.`mro_exchange_order` ALTER COLUMN `order_status` SET TAGS ('dbx_value_regex' = 'open|component-dispatched|awaiting-return|closed|overdue|cancelled');
ALTER TABLE `airlines_ecm`.`procurement`.`mro_exchange_order` ALTER COLUMN `order_type` SET TAGS ('dbx_business_glossary_term' = 'Exchange Order Type');
ALTER TABLE `airlines_ecm`.`procurement`.`mro_exchange_order` ALTER COLUMN `order_type` SET TAGS ('dbx_value_regex' = 'exchange|loan|borrow|repair-and-return|outright-purchase|consignment');
ALTER TABLE `airlines_ecm`.`procurement`.`mro_exchange_order` ALTER COLUMN `outgoing_condition` SET TAGS ('dbx_business_glossary_term' = 'Outgoing Component Condition');
ALTER TABLE `airlines_ecm`.`procurement`.`mro_exchange_order` ALTER COLUMN `outgoing_condition` SET TAGS ('dbx_value_regex' = 'serviceable|unserviceable|repairable|beyond-economic-repair|time-expired');
ALTER TABLE `airlines_ecm`.`procurement`.`mro_exchange_order` ALTER COLUMN `outgoing_serial_number` SET TAGS ('dbx_business_glossary_term' = 'Outgoing Component Serial Number');
ALTER TABLE `airlines_ecm`.`procurement`.`mro_exchange_order` ALTER COLUMN `outgoing_serial_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{4,20}$');
ALTER TABLE `airlines_ecm`.`procurement`.`mro_exchange_order` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Exchange Order Priority Level');
ALTER TABLE `airlines_ecm`.`procurement`.`mro_exchange_order` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'routine|urgent|aog|critical');
ALTER TABLE `airlines_ecm`.`procurement`.`mro_exchange_order` ALTER COLUMN `shipping_method` SET TAGS ('dbx_business_glossary_term' = 'Shipping Method');
ALTER TABLE `airlines_ecm`.`procurement`.`mro_exchange_order` ALTER COLUMN `shipping_method` SET TAGS ('dbx_value_regex' = 'air-freight|ground|courier|hand-carry');
ALTER TABLE `airlines_ecm`.`procurement`.`mro_exchange_order` ALTER COLUMN `total_loan_charges` SET TAGS ('dbx_business_glossary_term' = 'Total Loan Charges Amount');
ALTER TABLE `airlines_ecm`.`procurement`.`mro_exchange_order` ALTER COLUMN `tracking_number` SET TAGS ('dbx_business_glossary_term' = 'Shipment Tracking Number');
ALTER TABLE `airlines_ecm`.`procurement`.`mro_exchange_order` ALTER COLUMN `vendor_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Vendor Reference Number');
ALTER TABLE `airlines_ecm`.`procurement`.`mro_exchange_order` ALTER COLUMN `work_order_reference` SET TAGS ('dbx_business_glossary_term' = 'Work Order Reference Number');
ALTER TABLE `airlines_ecm`.`procurement`.`repair_order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `airlines_ecm`.`procurement`.`repair_order` SET TAGS ('dbx_subdomain' = 'order_processing');
ALTER TABLE `airlines_ecm`.`procurement`.`repair_order` ALTER COLUMN `repair_order_id` SET TAGS ('dbx_business_glossary_term' = 'Repair Order Identifier (ID)');
ALTER TABLE `airlines_ecm`.`procurement`.`repair_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approver Employee Identifier (ID)');
ALTER TABLE `airlines_ecm`.`procurement`.`repair_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`procurement`.`repair_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `airlines_ecm`.`procurement`.`repair_order` ALTER COLUMN `part_master_id` SET TAGS ('dbx_business_glossary_term' = 'Part Master Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`procurement`.`repair_order` ALTER COLUMN `primary_repair_requestor_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Requestor Employee Identifier (ID)');
ALTER TABLE `airlines_ecm`.`procurement`.`repair_order` ALTER COLUMN `primary_repair_requestor_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`procurement`.`repair_order` ALTER COLUMN `primary_repair_requestor_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `airlines_ecm`.`procurement`.`repair_order` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`procurement`.`repair_order` ALTER COLUMN `flight_leg_id` SET TAGS ('dbx_business_glossary_term' = 'Removal Flight Leg Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`procurement`.`repair_order` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Repair Vendor Identifier (ID)');
ALTER TABLE `airlines_ecm`.`procurement`.`repair_order` ALTER COLUMN `rework_repair_order_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `airlines_ecm`.`procurement`.`repair_order` ALTER COLUMN `actual_return_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Return Date');
ALTER TABLE `airlines_ecm`.`procurement`.`repair_order` ALTER COLUMN `aircraft_registration` SET TAGS ('dbx_business_glossary_term' = 'Aircraft Registration Number');
ALTER TABLE `airlines_ecm`.`procurement`.`repair_order` ALTER COLUMN `aircraft_registration` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{5,10}$');
ALTER TABLE `airlines_ecm`.`procurement`.`repair_order` ALTER COLUMN `airworthiness_certificate_type` SET TAGS ('dbx_business_glossary_term' = 'Airworthiness Certificate Type');
ALTER TABLE `airlines_ecm`.`procurement`.`repair_order` ALTER COLUMN `airworthiness_certificate_type` SET TAGS ('dbx_value_regex' = 'FAA-8130-3|EASA-Form-1|JAA-Form-One|CAAC-Release|other');
ALTER TABLE `airlines_ecm`.`procurement`.`repair_order` ALTER COLUMN `airworthiness_release_document_number` SET TAGS ('dbx_business_glossary_term' = 'Airworthiness Release Document Number');
ALTER TABLE `airlines_ecm`.`procurement`.`repair_order` ALTER COLUMN `airworthiness_release_document_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{6,30}$');
ALTER TABLE `airlines_ecm`.`procurement`.`repair_order` ALTER COLUMN `ata_chapter` SET TAGS ('dbx_business_glossary_term' = 'Air Transport Association (ATA) Chapter Code');
ALTER TABLE `airlines_ecm`.`procurement`.`repair_order` ALTER COLUMN `ata_chapter` SET TAGS ('dbx_value_regex' = '^[0-9]{2}(-[0-9]{2})?$');
ALTER TABLE `airlines_ecm`.`procurement`.`repair_order` ALTER COLUMN `ber_flag` SET TAGS ('dbx_business_glossary_term' = 'Beyond Economical Repair (BER) Flag');
ALTER TABLE `airlines_ecm`.`procurement`.`repair_order` ALTER COLUMN `ber_threshold_value` SET TAGS ('dbx_business_glossary_term' = 'Beyond Economical Repair (BER) Threshold Value');
ALTER TABLE `airlines_ecm`.`procurement`.`repair_order` ALTER COLUMN `component_serial_number` SET TAGS ('dbx_business_glossary_term' = 'Component Serial Number');
ALTER TABLE `airlines_ecm`.`procurement`.`repair_order` ALTER COLUMN `component_serial_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{4,25}$');
ALTER TABLE `airlines_ecm`.`procurement`.`repair_order` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `airlines_ecm`.`procurement`.`repair_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `airlines_ecm`.`procurement`.`repair_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`procurement`.`repair_order` ALTER COLUMN `dispatch_date` SET TAGS ('dbx_business_glossary_term' = 'Dispatch Date to Vendor');
ALTER TABLE `airlines_ecm`.`procurement`.`repair_order` ALTER COLUMN `fault_description` SET TAGS ('dbx_business_glossary_term' = 'Fault Description');
ALTER TABLE `airlines_ecm`.`procurement`.`repair_order` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `airlines_ecm`.`procurement`.`repair_order` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Repair Order Notes');
ALTER TABLE `airlines_ecm`.`procurement`.`repair_order` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Repair Priority Level');
ALTER TABLE `airlines_ecm`.`procurement`.`repair_order` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'aog|critical|high|normal|low');
ALTER TABLE `airlines_ecm`.`procurement`.`repair_order` ALTER COLUMN `promised_return_date` SET TAGS ('dbx_business_glossary_term' = 'Promised Return Date');
ALTER TABLE `airlines_ecm`.`procurement`.`repair_order` ALTER COLUMN `removal_date` SET TAGS ('dbx_business_glossary_term' = 'Component Removal Date');
ALTER TABLE `airlines_ecm`.`procurement`.`repair_order` ALTER COLUMN `removal_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Removal Reason Code');
ALTER TABLE `airlines_ecm`.`procurement`.`repair_order` ALTER COLUMN `removal_reason_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,6}$');
ALTER TABLE `airlines_ecm`.`procurement`.`repair_order` ALTER COLUMN `repair_cost_actual` SET TAGS ('dbx_business_glossary_term' = 'Repair Cost Actual Amount');
ALTER TABLE `airlines_ecm`.`procurement`.`repair_order` ALTER COLUMN `repair_cost_quoted` SET TAGS ('dbx_business_glossary_term' = 'Repair Cost Quoted Amount');
ALTER TABLE `airlines_ecm`.`procurement`.`repair_order` ALTER COLUMN `repair_order_number` SET TAGS ('dbx_business_glossary_term' = 'Repair Order Number');
ALTER TABLE `airlines_ecm`.`procurement`.`repair_order` ALTER COLUMN `repair_order_number` SET TAGS ('dbx_value_regex' = '^RO-[A-Z0-9]{8,12}$');
ALTER TABLE `airlines_ecm`.`procurement`.`repair_order` ALTER COLUMN `repair_order_status` SET TAGS ('dbx_business_glossary_term' = 'Repair Order Status');
ALTER TABLE `airlines_ecm`.`procurement`.`repair_order` ALTER COLUMN `repair_order_status` SET TAGS ('dbx_value_regex' = 'dispatched|in-repair|awaiting-parts|completed|ber-declared|cancelled');
ALTER TABLE `airlines_ecm`.`procurement`.`repair_order` ALTER COLUMN `repair_specification_reference` SET TAGS ('dbx_business_glossary_term' = 'Repair Specification Reference');
ALTER TABLE `airlines_ecm`.`procurement`.`repair_order` ALTER COLUMN `repair_station_certificate_number` SET TAGS ('dbx_business_glossary_term' = 'Repair Station Certificate Number');
ALTER TABLE `airlines_ecm`.`procurement`.`repair_order` ALTER COLUMN `repair_station_certificate_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,15}$');
ALTER TABLE `airlines_ecm`.`procurement`.`repair_order` ALTER COLUMN `repair_type` SET TAGS ('dbx_business_glossary_term' = 'Repair Type');
ALTER TABLE `airlines_ecm`.`procurement`.`repair_order` ALTER COLUMN `repair_type` SET TAGS ('dbx_value_regex' = 'overhaul|repair|test|modification|inspection|calibration');
ALTER TABLE `airlines_ecm`.`procurement`.`repair_order` ALTER COLUMN `replacement_part_ordered_flag` SET TAGS ('dbx_business_glossary_term' = 'Replacement Part Ordered Flag');
ALTER TABLE `airlines_ecm`.`procurement`.`repair_order` ALTER COLUMN `warranty_claim_flag` SET TAGS ('dbx_business_glossary_term' = 'Warranty Claim Flag');
ALTER TABLE `airlines_ecm`.`procurement`.`repair_order` ALTER COLUMN `warranty_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Warranty Reference Number');
ALTER TABLE `airlines_ecm`.`procurement`.`repair_order` ALTER COLUMN `work_order_reference` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Work Order Reference');
ALTER TABLE `airlines_ecm`.`procurement`.`repair_order` ALTER COLUMN `work_order_reference` SET TAGS ('dbx_value_regex' = '^WO-[A-Z0-9]{6,12}$');
ALTER TABLE `airlines_ecm`.`procurement`.`savings_initiative` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `airlines_ecm`.`procurement`.`savings_initiative` SET TAGS ('dbx_subdomain' = 'supplier_management');
ALTER TABLE `airlines_ecm`.`procurement`.`savings_initiative` ALTER COLUMN `savings_initiative_id` SET TAGS ('dbx_business_glossary_term' = 'Savings Initiative ID');
ALTER TABLE `airlines_ecm`.`procurement`.`savings_initiative` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Initiative Owner ID');
ALTER TABLE `airlines_ecm`.`procurement`.`savings_initiative` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`procurement`.`savings_initiative` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `airlines_ecm`.`procurement`.`savings_initiative` ALTER COLUMN `procurement_category_id` SET TAGS ('dbx_business_glossary_term' = 'Procurement Category Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`procurement`.`savings_initiative` ALTER COLUMN `sourcing_event_id` SET TAGS ('dbx_business_glossary_term' = 'Sourcing Event Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`procurement`.`savings_initiative` ALTER COLUMN `supply_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Supply Contract Id (Foreign Key)');
ALTER TABLE `airlines_ecm`.`procurement`.`savings_initiative` ALTER COLUMN `tertiary_savings_finance_validator_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Finance Validator ID');
ALTER TABLE `airlines_ecm`.`procurement`.`savings_initiative` ALTER COLUMN `tertiary_savings_finance_validator_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`procurement`.`savings_initiative` ALTER COLUMN `tertiary_savings_finance_validator_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `airlines_ecm`.`procurement`.`savings_initiative` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `airlines_ecm`.`procurement`.`savings_initiative` ALTER COLUMN `parent_savings_initiative_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `airlines_ecm`.`procurement`.`savings_initiative` ALTER COLUMN `actual_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Completion Date');
ALTER TABLE `airlines_ecm`.`procurement`.`savings_initiative` ALTER COLUMN `approval_authority_level` SET TAGS ('dbx_business_glossary_term' = 'Approval Authority Level');
ALTER TABLE `airlines_ecm`.`procurement`.`savings_initiative` ALTER COLUMN `approval_authority_level` SET TAGS ('dbx_value_regex' = 'buyer|category_manager|cpo|cfo|executive_committee');
ALTER TABLE `airlines_ecm`.`procurement`.`savings_initiative` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `airlines_ecm`.`procurement`.`savings_initiative` ALTER COLUMN `baseline_spend_amount` SET TAGS ('dbx_business_glossary_term' = 'Baseline Spend Amount');
ALTER TABLE `airlines_ecm`.`procurement`.`savings_initiative` ALTER COLUMN `business_case_summary` SET TAGS ('dbx_business_glossary_term' = 'Business Case Summary');
ALTER TABLE `airlines_ecm`.`procurement`.`savings_initiative` ALTER COLUMN `cost_center` SET TAGS ('dbx_business_glossary_term' = 'Cost Center');
ALTER TABLE `airlines_ecm`.`procurement`.`savings_initiative` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `airlines_ecm`.`procurement`.`savings_initiative` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `airlines_ecm`.`procurement`.`savings_initiative` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `airlines_ecm`.`procurement`.`savings_initiative` ALTER COLUMN `finance_validation_date` SET TAGS ('dbx_business_glossary_term' = 'Finance Validation Date');
ALTER TABLE `airlines_ecm`.`procurement`.`savings_initiative` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `airlines_ecm`.`procurement`.`savings_initiative` ALTER COLUMN `initiative_name` SET TAGS ('dbx_business_glossary_term' = 'Initiative Name');
ALTER TABLE `airlines_ecm`.`procurement`.`savings_initiative` ALTER COLUMN `initiative_number` SET TAGS ('dbx_business_glossary_term' = 'Initiative Number');
ALTER TABLE `airlines_ecm`.`procurement`.`savings_initiative` ALTER COLUMN `initiative_status` SET TAGS ('dbx_business_glossary_term' = 'Initiative Status');
ALTER TABLE `airlines_ecm`.`procurement`.`savings_initiative` ALTER COLUMN `initiative_status` SET TAGS ('dbx_value_regex' = 'proposed|approved|in_progress|completed|cancelled|on_hold');
ALTER TABLE `airlines_ecm`.`procurement`.`savings_initiative` ALTER COLUMN `initiative_type` SET TAGS ('dbx_business_glossary_term' = 'Initiative Type');
ALTER TABLE `airlines_ecm`.`procurement`.`savings_initiative` ALTER COLUMN `initiative_type` SET TAGS ('dbx_value_regex' = 'negotiation|consolidation|specification_change|demand_reduction|process_improvement|insourcing');
ALTER TABLE `airlines_ecm`.`procurement`.`savings_initiative` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `airlines_ecm`.`procurement`.`savings_initiative` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `airlines_ecm`.`procurement`.`savings_initiative` ALTER COLUMN `realized_savings_amount` SET TAGS ('dbx_business_glossary_term' = 'Realized Savings Amount');
ALTER TABLE `airlines_ecm`.`procurement`.`savings_initiative` ALTER COLUMN `risk_assessment` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment');
ALTER TABLE `airlines_ecm`.`procurement`.`savings_initiative` ALTER COLUMN `savings_validation_status` SET TAGS ('dbx_business_glossary_term' = 'Savings Validation Status');
ALTER TABLE `airlines_ecm`.`procurement`.`savings_initiative` ALTER COLUMN `savings_validation_status` SET TAGS ('dbx_value_regex' = 'pipeline|committed|realized|validated_by_finance|disputed');
ALTER TABLE `airlines_ecm`.`procurement`.`savings_initiative` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Start Date');
ALTER TABLE `airlines_ecm`.`procurement`.`savings_initiative` ALTER COLUMN `target_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Target Completion Date');
ALTER TABLE `airlines_ecm`.`procurement`.`savings_initiative` ALTER COLUMN `target_savings_amount` SET TAGS ('dbx_business_glossary_term' = 'Target Savings Amount');
ALTER TABLE `airlines_ecm`.`procurement`.`savings_initiative` ALTER COLUMN `target_savings_percentage` SET TAGS ('dbx_business_glossary_term' = 'Target Savings Percentage');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_category_qualification` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_category_qualification` SET TAGS ('dbx_subdomain' = 'supplier_management');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_category_qualification` SET TAGS ('dbx_association_edges' = 'procurement.vendor,procurement.procurement_category');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_category_qualification` ALTER COLUMN `vendor_category_qualification_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Category Qualification ID');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_category_qualification` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Employee ID');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_category_qualification` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_category_qualification` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_category_qualification` ALTER COLUMN `category_procurement_category_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Category Qualification - Procurement Category Id');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_category_qualification` ALTER COLUMN `procurement_category_id` SET TAGS ('dbx_business_glossary_term' = 'Procurement Category ID');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_category_qualification` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Category Qualification - Vendor Id');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_category_qualification` ALTER COLUMN `category_specific_lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Category Specific Lead Time Days');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_category_qualification` ALTER COLUMN `category_specific_payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Category Specific Payment Terms');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_category_qualification` ALTER COLUMN `certification_level` SET TAGS ('dbx_business_glossary_term' = 'Certification Level');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_category_qualification` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_category_qualification` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_category_qualification` ALTER COLUMN `last_performance_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Performance Review Date');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_category_qualification` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_category_qualification` ALTER COLUMN `performance_tier_for_category` SET TAGS ('dbx_business_glossary_term' = 'Performance Tier for Category');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_category_qualification` ALTER COLUMN `preferred_vendor_flag` SET TAGS ('dbx_business_glossary_term' = 'Preferred Vendor Flag');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_category_qualification` ALTER COLUMN `qualification_date` SET TAGS ('dbx_business_glossary_term' = 'Qualification Date');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_category_qualification` ALTER COLUMN `qualification_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Qualification Expiry Date');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_category_qualification` ALTER COLUMN `qualification_notes` SET TAGS ('dbx_business_glossary_term' = 'Qualification Notes');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_category_qualification` ALTER COLUMN `qualification_status` SET TAGS ('dbx_business_glossary_term' = 'Qualification Status');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_category_qualification` ALTER COLUMN `spend_limit_amount` SET TAGS ('dbx_business_glossary_term' = 'Spend Limit Amount');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_audit_schedule` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_audit_schedule` SET TAGS ('dbx_subdomain' = 'supplier_management');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_audit_schedule` SET TAGS ('dbx_association_edges' = 'compliance.audit_program,procurement.vendor');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_audit_schedule` ALTER COLUMN `vendor_audit_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Audit Schedule ID');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_audit_schedule` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Auditor Employee ID');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_audit_schedule` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_audit_schedule` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_audit_schedule` ALTER COLUMN `audit_program_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Program ID');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_audit_schedule` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_audit_schedule` ALTER COLUMN `audit_exemption_flag` SET TAGS ('dbx_business_glossary_term' = 'Audit Exemption Flag');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_audit_schedule` ALTER COLUMN `audit_frequency` SET TAGS ('dbx_business_glossary_term' = 'Audit Frequency');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_audit_schedule` ALTER COLUMN `audit_report_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Audit Report Document ID');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_audit_schedule` ALTER COLUMN `audit_result` SET TAGS ('dbx_business_glossary_term' = 'Audit Result');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_audit_schedule` ALTER COLUMN `audit_scope` SET TAGS ('dbx_business_glossary_term' = 'Audit Scope');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_audit_schedule` ALTER COLUMN `audit_score` SET TAGS ('dbx_business_glossary_term' = 'Audit Score');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_audit_schedule` ALTER COLUMN `corrective_action_plan_due_date` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Plan Due Date');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_audit_schedule` ALTER COLUMN `corrective_action_plan_required` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Plan Required');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_audit_schedule` ALTER COLUMN `corrective_action_plan_status` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Plan Status');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_audit_schedule` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_audit_schedule` ALTER COLUMN `critical_findings_count` SET TAGS ('dbx_business_glossary_term' = 'Critical Findings Count');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_audit_schedule` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_audit_schedule` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'End Date');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_audit_schedule` ALTER COLUMN `exemption_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Exemption Expiry Date');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_audit_schedule` ALTER COLUMN `exemption_reason` SET TAGS ('dbx_business_glossary_term' = 'Exemption Reason');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_audit_schedule` ALTER COLUMN `findings_count` SET TAGS ('dbx_business_glossary_term' = 'Findings Count');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_audit_schedule` ALTER COLUMN `last_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Last Audit Date');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_audit_schedule` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_audit_schedule` ALTER COLUMN `next_audit_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Audit Due Date');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_audit_schedule` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_audit_schedule` ALTER COLUMN `schedule_status` SET TAGS ('dbx_business_glossary_term' = 'Schedule Status');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_authorization` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_authorization` SET TAGS ('dbx_subdomain' = 'supplier_management');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_authorization` SET TAGS ('dbx_association_edges' = 'workforce.employee,procurement.vendor');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_authorization` ALTER COLUMN `vendor_authorization_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Authorization ID');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_authorization` ALTER COLUMN `authorized_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Authorizing Employee ID');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_authorization` ALTER COLUMN `authorized_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_authorization` ALTER COLUMN `authorized_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_authorization` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Authorization - Employee Id');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_authorization` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_authorization` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_authorization` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Authorization - Vendor Id');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_authorization` ALTER COLUMN `approval_limit_amount` SET TAGS ('dbx_business_glossary_term' = 'Approval Limit Amount');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_authorization` ALTER COLUMN `approval_limit_currency` SET TAGS ('dbx_business_glossary_term' = 'Approval Limit Currency');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_authorization` ALTER COLUMN `authorization_level` SET TAGS ('dbx_business_glossary_term' = 'Authorization Level');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_authorization` ALTER COLUMN `authorization_status` SET TAGS ('dbx_business_glossary_term' = 'Authorization Status');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_authorization` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Authorization Effective Date');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_authorization` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Authorization Expiry Date');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_authorization` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_authorization` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Authorization Notes');
ALTER TABLE `airlines_ecm`.`procurement`.`vendor_authorization` ALTER COLUMN `relationship_type` SET TAGS ('dbx_business_glossary_term' = 'Authorization Relationship Type');
