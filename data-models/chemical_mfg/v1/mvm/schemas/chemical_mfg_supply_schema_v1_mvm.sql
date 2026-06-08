-- Schema for Domain: supply | Business: Chemical Mfg | Version: v1_mvm
-- Generated on: 2026-05-06 14:37:12

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `chemical_mfg_ecm`.`supply` COMMENT 'Governs end-to-end supply chain network including supplier master data, purchase orders (PO), ASN tracking, vendor performance scorecards, supply risk management, procurement planning, RFQ processes, contract pricing with chemical suppliers, supplier qualification and audits, and inbound logistics coordination. Integrates with SAP MM and Oracle Transportation Management.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`supply`.`vendor` (
    `vendor_id` BIGINT COMMENT 'Unique identifier for the vendor record. Primary key.',
    `billing_party_id` BIGINT COMMENT 'Foreign key linking to billing.party. Business justification: Vendor-party master data alignment: in chemical manufacturing ERP systems, vendors are registered as billing parties for intercompany transactions, rebate settlements, and credit memo processing. This',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: Vendors in chemical manufacturing are registered and managed per legal entity for tax reporting, payment processing, and regulatory compliance. Vendor master scoping to legal entity is required for in',
    `approved_by` STRING COMMENT 'Name or identifier of the procurement manager or executive who authorized the vendors approval and addition to the approved vendor list.',
    `approved_date` DATE COMMENT 'Date when the vendor was officially approved and added to the approved vendor list (AVL) following successful qualification and onboarding.',
    `classification` STRING COMMENT 'Primary business classification of the vendor indicating the type of goods or services they provide to the chemical manufacturing operation.. Valid values are `raw_material_supplier|chemical_manufacturer|distributor|toll_processor|packaging_supplier|logistics_provider`',
    `contract_expiration_date` DATE COMMENT 'Date when the current master supply agreement or contract with the vendor expires requiring renewal or renegotiation.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the vendor master record was first created in the system capturing the initial data entry event.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code indicating the primary currency used for pricing and invoicing with this vendor.. Valid values are `^[A-Z]{3}$`',
    `duns_number` STRING COMMENT 'Nine-digit Dun & Bradstreet identifier used globally to uniquely identify business entities for credit and compliance purposes.. Valid values are `^[0-9]{9}$`',
    `hazmat_handling_capable` BOOLEAN COMMENT 'Indicates whether the vendor has certified capabilities and infrastructure to handle, store, and transport hazardous chemical materials in compliance with DOT and OSHA regulations.',
    `headquarters_address_line1` STRING COMMENT 'First line of the vendors corporate headquarters street address including building number and street name.',
    `headquarters_address_line2` STRING COMMENT 'Second line of the vendors corporate headquarters address for suite, floor, or additional location details.',
    `headquarters_city` STRING COMMENT 'City or municipality where the vendors corporate headquarters is located.',
    `headquarters_country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code indicating the country where the vendors corporate headquarters is domiciled.. Valid values are `^[A-Z]{3}$`',
    `headquarters_postal_code` STRING COMMENT 'Postal or ZIP code for the vendors corporate headquarters address used for mail delivery and geographic classification.',
    `headquarters_state_province` STRING COMMENT 'State, province, or administrative region where the vendors corporate headquarters is located.',
    `incoterms` STRING COMMENT 'Preferred Incoterms rule defining the division of costs, risks, and responsibilities between buyer and seller for international shipments. [ENUM-REF-CANDIDATE: EXW|FCA|CPT|CIP|DAP|DPU|DDP|FAS|FOB|CFR|CIF — 11 candidates stripped; promote to reference product]',
    `iso_14001_certified` BOOLEAN COMMENT 'Indicates whether the vendor holds ISO 14001 certification for environmental management systems demonstrating commitment to environmental stewardship.',
    `iso_9001_certified` BOOLEAN COMMENT 'Indicates whether the vendor holds ISO 9001 certification for quality management systems at the corporate or site level.',
    `last_audit_date` DATE COMMENT 'Date of the most recent on-site vendor audit or qualification assessment conducted to verify compliance with quality, safety, and regulatory requirements.',
    `minority_owned` BOOLEAN COMMENT 'Indicates whether the vendor is certified as a minority-owned business enterprise for supplier diversity program tracking and reporting.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to any field in the vendor master record used for change tracking and data lineage.',
    `next_audit_due_date` DATE COMMENT 'Scheduled date for the next periodic vendor audit or re-qualification assessment based on audit frequency policy and risk tier.',
    `notes` STRING COMMENT 'Free-text field for capturing additional vendor information, special handling instructions, historical context, or operational notes relevant to procurement and supply chain teams.',
    `onboarding_status` STRING COMMENT 'Current stage in the vendor qualification and onboarding process including documentation review, site audits, and compliance verification.. Valid values are `not_started|in_progress|documentation_pending|audit_scheduled|approved|rejected`',
    `payment_terms` STRING COMMENT 'Standard payment terms negotiated with the vendor specifying due date calculation (e.g., Net 30, Net 60, 2/10 Net 30) for invoice settlement.',
    `performance_score` DECIMAL(18,2) COMMENT 'Composite performance scorecard rating (0-100 scale) based on on-time delivery, quality metrics, responsiveness, and compliance with contract terms.',
    `primary_contact_email` STRING COMMENT 'Email address of the primary vendor contact used for purchase orders, ASN notifications, and business correspondence.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `primary_contact_name` STRING COMMENT 'Full name of the primary business contact at the vendor organization responsible for account management and order coordination.',
    `primary_contact_phone` STRING COMMENT 'Telephone number of the primary vendor contact including country code and extension where applicable.',
    `reach_compliant` BOOLEAN COMMENT 'Indicates whether the vendor complies with European REACH regulation for chemical substance registration and safety data provision.',
    `responsible_care_certified` BOOLEAN COMMENT 'Indicates whether the vendor holds Responsible Care certification from the American Chemistry Council (ACC) demonstrating commitment to environmental health and safety standards.',
    `risk_rating` STRING COMMENT 'Overall supply chain risk assessment rating for the vendor based on financial stability, geopolitical factors, quality performance, and business continuity capabilities.. Valid values are `low|medium|high|critical`',
    `sap_vendor_number` STRING COMMENT 'Unique vendor identifier in SAP S/4HANA MM (Materials Management) module used for procurement and accounts payable transactions.',
    `small_business` BOOLEAN COMMENT 'Indicates whether the vendor qualifies as a small business enterprise based on SBA size standards for supplier diversity and government contracting purposes.',
    `tax_number` STRING COMMENT 'Government-issued tax identifier (EIN, VAT number, or equivalent) for the vendor used for tax reporting and compliance.',
    `vendor_code` STRING COMMENT 'Internal business identifier or short code used to reference the vendor in operational systems and reports.',
    `vendor_name` STRING COMMENT 'Full legal name of the chemical supplier or raw material vendor as registered with governing authorities.',
    `vendor_status` STRING COMMENT 'Current operational status of the vendor indicating whether they are approved for procurement transactions and order placement.. Valid values are `active|inactive|suspended|pending_approval|blocked|under_review`',
    `vendor_tier` STRING COMMENT 'Tiered classification reflecting the vendors strategic importance, performance history, and procurement preference level within the supply chain network.. Valid values are `strategic|preferred|approved|conditional|probationary|inactive`',
    `website_url` STRING COMMENT 'Primary website URL for the vendor providing access to product catalogs, technical documentation, and company information.',
    `woman_owned` BOOLEAN COMMENT 'Indicates whether the vendor is certified as a woman-owned business enterprise for supplier diversity program tracking and reporting.',
    CONSTRAINT pk_vendor PRIMARY KEY(`vendor_id`)
) COMMENT 'Master record for all chemical suppliers and raw material vendors including multi-site physical locations. Captures vendor identity, classification, SAP vendor number, DUNS number, tax identifiers, payment terms, currency, preferred incoterms, vendor tier (strategic/preferred/approved/conditional), Responsible Care certification status, REACH compliance flag, and onboarding status. Includes site-level detail: physical plant addresses, site types (manufacturing plant, distribution center, port of export), geographic regions, country of origin, UN/LOCODE, hazmat handling capabilities, ISO 9001/14001 certifications at site level, and site-level contacts. Single source of truth for supplier identity, locations, and site capabilities within the supply domain.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`supply`.`vendor_site` (
    `vendor_site_id` BIGINT COMMENT 'Unique identifier for the vendor site. Primary key.',
    `vendor_id` BIGINT COMMENT 'Reference to the parent vendor organization that owns or operates this site.',
    `active_from_date` DATE COMMENT 'Date when the vendor site became active in the supply chain network. Used for supplier relationship tracking and historical analysis.',
    `active_to_date` DATE COMMENT 'Date when the vendor site was deactivated or decommissioned. Null for currently active sites. Used for supplier lifecycle management.',
    `address_line_1` STRING COMMENT 'Primary street address line for the vendor site. Used for shipping, logistics planning, and regulatory reporting.',
    `address_line_2` STRING COMMENT 'Secondary address line for building, suite, or unit information.',
    `city` STRING COMMENT 'City or municipality where the vendor site is located.',
    `country_code` STRING COMMENT 'Three-letter ISO country code for the vendor site location. Critical for customs, trade compliance, and country-of-origin tracking.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the vendor site record was first created in the system. Used for audit trail and data lineage.',
    `dock_hours` STRING COMMENT 'Operating hours for receiving and shipping at the vendor site dock. Used for delivery scheduling and ASN planning.',
    `geographic_region` STRING COMMENT 'Macro-geographic region classification for supply chain planning and risk segmentation.. Valid values are `north_america|south_america|europe|asia_pacific|middle_east|africa`',
    `hazmat_handling_capable` BOOLEAN COMMENT 'Indicates whether the vendor site is certified and equipped to handle hazardous chemical materials per DOT and OSHA requirements. Critical for chemical raw material sourcing.',
    `incoterm` STRING COMMENT 'Default Incoterm for shipments from this vendor site. Defines responsibility for freight, insurance, and risk transfer. [ENUM-REF-CANDIDATE: EXW|FCA|CPT|CIP|DAP|DPU|DDP|FAS|FOB|CFR|CIF — 11 candidates stripped; promote to reference product]',
    `iso_14001_certificate_number` STRING COMMENT 'Certificate number for the sites ISO 14001 certification. Used for environmental compliance verification.',
    `iso_14001_certified` BOOLEAN COMMENT 'Indicates whether the vendor site holds ISO 14001 Environmental Management System certification. Used for sustainability and EHS compliance assessment.',
    `iso_14001_expiration_date` DATE COMMENT 'Expiration date of the sites ISO 14001 certification. Monitored for environmental compliance and supplier sustainability programs.',
    `iso_9001_certificate_number` STRING COMMENT 'Certificate number for the sites ISO 9001 certification. Used for audit verification and supplier qualification documentation.',
    `iso_9001_certified` BOOLEAN COMMENT 'Indicates whether the vendor site holds ISO 9001 Quality Management System certification. Used for supplier qualification and quality assurance.',
    `iso_9001_expiration_date` DATE COMMENT 'Expiration date of the sites ISO 9001 certification. Monitored for supplier compliance and re-qualification triggers.',
    `last_audit_date` DATE COMMENT 'Date of the most recent supplier audit conducted at this vendor site. Used for supplier performance tracking and re-audit scheduling.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the vendor site record was last updated. Used for change tracking and data quality monitoring.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the vendor site. Used for logistics optimization, distance calculations, and supply chain mapping.',
    `lead_time_days` STRING COMMENT 'Standard lead time in days from purchase order placement to shipment readiness at this vendor site. Used for procurement planning and MRP calculations.',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the vendor site. Used for logistics optimization, distance calculations, and supply chain mapping.',
    `minimum_order_quantity` DECIMAL(18,2) COMMENT 'Minimum order quantity required by this vendor site for purchase orders. Used for procurement planning and order consolidation.',
    `minimum_order_quantity_uom` STRING COMMENT 'Unit of measure for the minimum order quantity. Common chemical industry units include kilograms, liters, drums, totes, and railcars. [ENUM-REF-CANDIDATE: KG|LB|MT|L|GAL|M3|EA|DRUM|TOTE|RAILCAR — 10 candidates stripped; promote to reference product]',
    `next_audit_due_date` DATE COMMENT 'Scheduled date for the next supplier audit at this vendor site. Used for compliance monitoring and audit planning.',
    `postal_code` STRING COMMENT 'Postal or ZIP code for the vendor site address. Used for logistics routing and freight cost calculation.',
    `preferred_carrier` STRING COMMENT 'Preferred freight carrier or logistics provider for shipments from this vendor site. Used for logistics planning and freight cost estimation.',
    `primary_contact_email` STRING COMMENT 'Email address of the primary site contact for purchase order confirmations, ASN notifications, and operational communication.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `primary_contact_name` STRING COMMENT 'Full name of the primary contact person at the vendor site for procurement and logistics coordination.',
    `primary_contact_phone` STRING COMMENT 'Phone number of the primary site contact for urgent procurement and logistics issues.',
    `qualification_status` STRING COMMENT 'Current supplier qualification status of the vendor site. Determines whether site can be used for new purchase orders and material sourcing.. Valid values are `qualified|pending_audit|conditional|disqualified|not_assessed`',
    `responsible_care_certified` BOOLEAN COMMENT 'Indicates whether the vendor site participates in the American Chemistry Councils Responsible Care program. Key indicator for chemical industry supplier qualification.',
    `risk_rating` STRING COMMENT 'Supply chain risk rating for this vendor site based on factors including geographic risk, financial stability, quality history, and regulatory compliance. Used for supply risk management and dual-sourcing decisions.. Valid values are `low|medium|high|critical`',
    `site_code` STRING COMMENT 'Unique alphanumeric code identifying the vendor site within the vendors network. Used for operational reference and system integration.. Valid values are `^[A-Z0-9]{4,12}$`',
    `site_name` STRING COMMENT 'Official business name of the vendor site or facility.',
    `site_status` STRING COMMENT 'Current operational status of the vendor site in the supply chain network. Controls whether site can be used for new purchase orders.. Valid values are `active|inactive|suspended|pending_qualification|decommissioned`',
    `site_type` STRING COMMENT 'Classification of the vendor site based on its primary operational function. Determines handling capabilities and logistics planning.. Valid values are `manufacturing_plant|distribution_center|warehouse|port_of_export|research_facility|blending_facility`',
    `state_province` STRING COMMENT 'State, province, or administrative region of the vendor site. Used for tax jurisdiction and regulatory compliance.',
    `time_zone` STRING COMMENT 'IANA time zone identifier for the vendor site. Used for scheduling shipments, coordinating deliveries, and ASN timing.',
    `un_locode` STRING COMMENT 'UN/LOCODE for the site location. Used for international logistics, customs documentation, and port-of-export identification.. Valid values are `^[A-Z]{2}[A-Z0-9]{3}$`',
    CONSTRAINT pk_vendor_site PRIMARY KEY(`vendor_site_id`)
) COMMENT 'Physical plant, warehouse, or shipping location associated with a vendor. Tracks site address, site type (manufacturing plant, distribution center, port of export), geographic region, country of origin, UN/LOCODE, hazmat handling capability, ISO 9001/14001 certification at site level, and site-level contact information. Supports multi-site vendor relationships common in chemical raw material sourcing.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`supply`.`purchase_order` (
    `purchase_order_id` BIGINT COMMENT 'Unique identifier for the purchase order record in the lakehouse. Primary key.',
    `contract_id` BIGINT COMMENT 'Foreign key linking to supply.contract. Business justification: Purchase orders in chemical manufacturing are frequently issued against long-term supply contracts or blanket purchase agreements. The purchase_order table stores contract_number (STRING) but has no F',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Required for PO expense charging; finance cost center needed for budgeting and actual spend reporting per purchase order.',
    `internal_order_id` BIGINT COMMENT 'Foreign key linking to finance.internal_order. Business justification: Allocates PO costs to internal orders for project accounting and cost tracking in financial systems.',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: POs are issued by a specific legal entity for statutory reporting, intercompany procurement, and tax compliance. company_code is a denormalized legal entity identifier; replacing with proper FK enforc',
    `production_plant_id` BIGINT COMMENT 'Unique identifier of the manufacturing plant or facility where the ordered materials will be received and used.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Chemical manufacturing POs are posted against profit centers for product-line P&L and raw material spend allocation. Procurement controllers require this for segment-level cost reporting and budget va',
    `vendor_id` BIGINT COMMENT 'Unique identifier of the chemical supplier or service provider to whom this purchase order is issued.',
    `approval_status` STRING COMMENT 'Current approval workflow status: not_required (no approval needed), pending (awaiting approver action), approved (all approvals obtained), rejected (approval denied).. Valid values are `not_required|pending|approved|rejected`',
    `approved_by` STRING COMMENT 'User ID or name of the person who provided final approval for the purchase order release.',
    `approved_date` DATE COMMENT 'Date when the purchase order received final approval and was authorized for release to the vendor.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the purchase order record was first created in the system. Audit trail for record creation.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code in which the purchase order value is denominated (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `delivery_date` DATE COMMENT 'Date by which the ordered materials or services are requested to be delivered to the receiving plant or location.',
    `document_date` DATE COMMENT 'Date when the purchase order document was created in the system. Represents the business event timestamp for PO creation.',
    `freight_terms` STRING COMMENT 'Freight payment responsibility: prepaid (seller pays freight), collect (buyer pays freight), or third_party (third party pays freight).. Valid values are `prepaid|collect|third_party`',
    `incoterms` STRING COMMENT 'International Commercial Terms (Incoterms) defining the responsibilities of buyer and seller for transportation, insurance, and risk transfer (e.g., FOB, CIF, DDP). [ENUM-REF-CANDIDATE: EXW|FCA|CPT|CIP|DAP|DPU|DDP|FAS|FOB|CFR|CIF — 11 candidates stripped; promote to reference product]',
    `incoterms_location` STRING COMMENT 'Named place or port specified in the Incoterms clause where the transfer of risk and responsibility occurs (e.g., Houston Port, Vendor Warehouse).',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the purchase order record was last modified. Audit trail for record updates.',
    `payment_terms` STRING COMMENT 'Payment terms code defining the payment schedule and discount conditions (e.g., Net 30, 2/10 Net 30). Typically a 4-character SAP payment terms key.. Valid values are `^[A-Z0-9]{4}$`',
    `po_number` STRING COMMENT 'Externally-known unique purchase order document number issued to the supplier. Typically a 10-digit SAP document number from MM module.. Valid values are `^[0-9]{10}$`',
    `po_status` STRING COMMENT 'Current lifecycle status of the purchase order: draft (being created), pending_approval (awaiting authorization), approved (authorized but not yet released), released (transmitted to vendor), partially_received (some goods received), fully_received (all goods received), closed (completed and archived), cancelled (voided before fulfillment). [ENUM-REF-CANDIDATE: draft|pending_approval|approved|released|partially_received|fully_received|closed|cancelled — 8 candidates stripped; promote to reference product]',
    `po_type` STRING COMMENT 'Classification of the purchase order type: standard (one-time purchase), blanket (release against framework agreement), contract (long-term agreement), consignment (vendor-owned inventory), subcontracting (material provided to vendor for processing), or service (non-material procurement).. Valid values are `standard|blanket|contract|consignment|subcontracting|service`',
    `purchasing_group` STRING COMMENT 'Buyer or purchasing team responsible for this purchase order. Typically a 3-character code identifying the procurement specialist or commodity team (e.g., raw materials, packaging, services).. Valid values are `^[A-Z0-9]{3}$`',
    `purchasing_organization` STRING COMMENT 'SAP organizational unit responsible for procurement activities. Typically a 4-character alphanumeric code representing the central or regional purchasing group.. Valid values are `^[A-Z0-9]{4}$`',
    `release_date` DATE COMMENT 'Date when the purchase order was officially released and transmitted to the vendor for fulfillment.',
    `requisition_number` STRING COMMENT 'Reference number of the internal purchase requisition that triggered the creation of this purchase order.',
    `rfq_number` STRING COMMENT 'Reference number of the Request for Quotation (RFQ) document that preceded this purchase order, if applicable. Links PO to the sourcing event.',
    `shipping_address_line1` STRING COMMENT 'First line of the delivery address where the ordered materials should be shipped (street address, building number).',
    `shipping_city` STRING COMMENT 'City name of the delivery address for the purchase order shipment.',
    `shipping_country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code of the delivery address (e.g., USA, CAN, MEX).. Valid values are `^[A-Z]{3}$`',
    `shipping_method` STRING COMMENT 'Primary mode of transportation for delivering the ordered materials: truck (road freight), rail (railway), ocean (sea freight), air (air cargo), pipeline (bulk liquid/gas), or intermodal (combination).. Valid values are `truck|rail|ocean|air|pipeline|intermodal`',
    `shipping_postal_code` STRING COMMENT 'Postal code or ZIP code of the delivery address for the purchase order shipment.',
    `shipping_state_province` STRING COMMENT 'State or province of the delivery address for the purchase order shipment.',
    `special_instructions` STRING COMMENT 'Free-text field for any special handling, packaging, labeling, or delivery instructions communicated to the vendor.',
    `total_gross_value` DECIMAL(18,2) COMMENT 'Total gross monetary value of the purchase order including net value, taxes, freight, and all other charges.',
    `total_net_value` DECIMAL(18,2) COMMENT 'Total net monetary value of the purchase order before taxes, freight, and other charges. Sum of all line item net values.',
    `total_tax_amount` DECIMAL(18,2) COMMENT 'Total tax amount applicable to the purchase order, including sales tax, VAT, or other applicable taxes based on jurisdiction.',
    `validity_end_date` DATE COMMENT 'End date of the purchase order validity period. Applicable primarily for blanket or contract purchase orders defining the expiration date.',
    `validity_start_date` DATE COMMENT 'Start date of the purchase order validity period. Applicable primarily for blanket or contract purchase orders defining the effective-from date.',
    `vendor_contact_email` STRING COMMENT 'Email address of the primary vendor contact for order acknowledgment, shipping notifications, and issue resolution.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `vendor_contact_name` STRING COMMENT 'Name of the primary contact person at the vendor organization for this purchase order.',
    CONSTRAINT pk_purchase_order PRIMARY KEY(`purchase_order_id`)
) COMMENT 'Core procurement transaction representing a legally binding PO issued to a chemical supplier for raw materials, intermediates, packaging, or services. Captures PO number, PO type (standard, blanket release, consignment, subcontracting), vendor, plant, purchasing organization, purchasing group, document date, delivery date, incoterms, payment terms, currency, total net value, approval status, and SAP document number. Integrates with SAP MM ME21N/ME22N.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`supply`.`po_line` (
    `po_line_id` BIGINT COMMENT 'Unique identifier for the purchase order line item. Primary key for the po_line data product.',
    `contract_price_id` BIGINT COMMENT 'Foreign key linking to supply.contract_price. Business justification: PO line pricing in chemical manufacturing is typically derived from negotiated contract price conditions (price scales, condition records). Adding contract_price_id to po_line links each line item to ',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Individual PO line items in chemical manufacturing are account-assigned to cost centers (SAP account assignment category K) for direct cost posting. Required for cost center budget consumption and spe',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: PO line account assignment includes GL account for direct cost posting of consumables and services. Chemical manufacturers require this for automatic FI document generation and GL-level spend analysis',
    `inspection_plan_id` BIGINT COMMENT 'Foreign key linking to quality.inspection_plan. Business justification: PO lines with quality_inspection_required_flag=true reference a specific inspection plan in chemical manufacturing. Direct FK determines which inspection plan governs incoming inspection for that line',
    `internal_order_id` BIGINT COMMENT 'Foreign key linking to finance.internal_order. Business justification: PO lines for capital projects or production campaign materials in chemical manufacturing are assigned to internal orders for budget consumption tracking. Standard SAP account assignment enabling proje',
    `material_master_id` BIGINT COMMENT 'Foreign key reference to the material master record representing the raw material or chemical substance being procured on this line.',
    `purchase_order_id` BIGINT COMMENT 'Foreign key reference to the parent purchase order header. Links this line item to its containing purchase order document.',
    `batch_managed_flag` BOOLEAN COMMENT 'Indicates whether this material requires batch management and lot tracking for quality control and traceability purposes.',
    `cas_number` STRING COMMENT 'Unique numerical identifier assigned by the Chemical Abstracts Service to every chemical substance. Used for regulatory compliance and substance identification.. Valid values are `^[1-9][0-9]{1,6}-[0-9]{2}-[0-9]$`',
    `confirmation_control_key` STRING COMMENT 'Code defining the type of order confirmation required from the supplier (e.g., order acknowledgment, shipping notification, delivery confirmation).',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this purchase order line item record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code indicating the currency in which the net price is denominated (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `deletion_indicator` BOOLEAN COMMENT 'Flag indicating whether this purchase order line has been marked for deletion and should be excluded from active procurement processing.',
    `delivery_date` DATE COMMENT 'The requested or confirmed delivery date for this purchase order line item. Represents when the material is expected to arrive at the receiving location.',
    `ghs_hazard_category` STRING COMMENT 'The GHS hazard classification category for this chemical substance (e.g., Flammable Liquid Category 2, Acute Toxicity Category 3). Used for safety data sheet compliance and labeling.',
    `goods_receipt_quantity` DECIMAL(18,2) COMMENT 'Cumulative quantity of material that has been received against this purchase order line to date.',
    `goods_receipt_required_flag` BOOLEAN COMMENT 'Indicates whether a formal goods receipt transaction must be posted in the system before invoice processing can occur.',
    `hazmat_indicator` BOOLEAN COMMENT 'Flag indicating whether this material is classified as hazardous and requires special handling, storage, and transportation procedures.',
    `incoterms` STRING COMMENT 'The Incoterms code defining the delivery terms and transfer of risk between buyer and supplier (e.g., FOB, CIF, DDP).',
    `incoterms_location` STRING COMMENT 'The specific location or port associated with the Incoterms delivery terms (e.g., Houston Port, supplier facility).',
    `invoice_receipt_quantity` DECIMAL(18,2) COMMENT 'Cumulative quantity of material that has been invoiced by the supplier against this purchase order line.',
    `invoice_receipt_required_flag` BOOLEAN COMMENT 'Indicates whether an invoice must be received and verified before payment can be processed for this line item.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this purchase order line item record was most recently updated or changed.',
    `line_number` STRING COMMENT 'Sequential line item number within the purchase order. Determines the ordering and position of this line in the PO document.',
    `line_status` STRING COMMENT 'Current fulfillment status of this purchase order line item in its procurement lifecycle.. Valid values are `open|partially_received|fully_received|cancelled|blocked`',
    `material_description` STRING COMMENT 'Short text description of the material or chemical substance being procured, including common name and key characteristics.',
    `material_group` STRING COMMENT 'Classification code grouping similar materials together for procurement analysis and reporting (e.g., solvents, acids, polymers).',
    `material_number` STRING COMMENT 'The business material number or SKU (Stock Keeping Unit) code identifying the specific raw material or chemical being ordered.',
    `net_order_value` DECIMAL(18,2) COMMENT 'Total net value of this purchase order line, calculated as ordered quantity multiplied by net price, before taxes and freight.',
    `net_price` DECIMAL(18,2) COMMENT 'The negotiated unit price for the material before taxes and additional charges. Expressed per price unit.',
    `ordered_quantity` DECIMAL(18,2) COMMENT 'The quantity of material ordered on this purchase order line, expressed in the unit of measure specified.',
    `outstanding_quantity` DECIMAL(18,2) COMMENT 'Remaining quantity of material still to be delivered on this purchase order line, calculated as ordered quantity minus goods receipt quantity.',
    `over_delivery_tolerance_pct` DECIMAL(18,2) COMMENT 'Acceptable percentage by which the supplier may exceed the ordered quantity without requiring approval.',
    `plant_code` STRING COMMENT 'The manufacturing plant or facility code where the material will be received and used in production.',
    `price_unit` STRING COMMENT 'The quantity unit to which the net price applies (e.g., price per 1 unit, per 100 units, per 1000 units).',
    `purchasing_group` STRING COMMENT 'Code identifying the purchasing group or buyer responsible for procuring this material category.',
    `quality_inspection_required_flag` BOOLEAN COMMENT 'Indicates whether incoming material on this line must undergo quality control inspection and Certificate of Analysis (COA) verification before release to production.',
    `storage_location` STRING COMMENT 'The specific storage location or warehouse area within the plant where the material will be stored upon receipt.',
    `supplier_material_number` STRING COMMENT 'The suppliers own material number or product code for this chemical substance, used for cross-referencing and order confirmation.',
    `tax_code` STRING COMMENT 'Tax classification code determining the applicable tax rate and tax jurisdiction for this purchase order line.',
    `un_number` STRING COMMENT 'Four-digit UN identification number for hazardous materials used in international transport and shipping documentation.. Valid values are `^UN[0-9]{4}$`',
    `under_delivery_tolerance_pct` DECIMAL(18,2) COMMENT 'Acceptable percentage by which the supplier may deliver less than the ordered quantity without penalty.',
    `unit_of_measure` STRING COMMENT 'The unit in which the ordered quantity is expressed (e.g., KG for kilograms, L for liters, MT for metric tons, GAL for gallons).',
    CONSTRAINT pk_po_line PRIMARY KEY(`po_line_id`)
) COMMENT 'Individual line items within a purchase order, each representing a specific raw material or chemical substance being procured. Captures line number, material number, CAS number, material description, ordered quantity, unit of measure, net price, price unit, delivery date, storage location, batch management flag, hazmat classification, GHS hazard category, and line-level delivery status. Integrates with SAP MM EKPO table.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`supply`.`goods_receipt` (
    `goods_receipt_id` BIGINT COMMENT 'Primary key for goods_receipt',
    `asn_id` BIGINT COMMENT 'Foreign key linking to supply.asn. Business justification: Goods receipts in chemical manufacturing are frequently matched against ASNs (Advanced Shipping Notices) received from suppliers prior to physical delivery. The goods_receipt table stores asn_number (',
    `carrier_id` BIGINT COMMENT 'Foreign key linking to logistics.carrier. Business justification: Carrier traceability on goods receipt is a regulatory requirement in chemical manufacturing: DOT incident reporting and hazmat delivery audits require identifying the specific carrier. carrier_name on',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: GR/IR clearing and inventory valuation postings in chemical manufacturing are assigned to receiving plant cost centers. Standard MM-FI integration requires cost center assignment for automatic FI docu',
    `fiscal_period_id` BIGINT COMMENT 'Foreign key linking to finance.fiscal_period. Business justification: GR posting_date determines fiscal period for inventory valuation. Period-end GR cutoff is critical in chemical manufacturing for accurate inventory and COGS; this FK enables period-close reporting and',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: GR postings generate automatic FI documents to inventory and GR/IR clearing GL accounts. Chemical manufacturers require this link for inventory valuation audit trails and reconciliation of goods recei',
    `inbound_delivery_id` BIGINT COMMENT 'Foreign key linking to supply.inbound_delivery. Business justification: An inbound delivery record tracks the physical movement of materials to the plant, and the goods receipt records the formal posting of that receipt. These are sequential events in the inbound logistic',
    `material_master_id` BIGINT COMMENT 'Reference to the raw material or chemical product received. Links to material master data.',
    `po_line_id` BIGINT COMMENT 'Foreign key linking to supply.po_line. Business justification: A goods receipt in chemical manufacturing is always against a specific PO line item (specific raw material or chemical), not just the PO header. Adding po_line_id normalizes the line-level receipt ref',
    `process_order_id` BIGINT COMMENT 'Foreign key linking to production.process_order. Business justification: In chemical manufacturing, raw material goods receipts are posted directly against process orders (SAP movement type 101 to order) for order-based cost settlement and GMP batch traceability. This link',
    `production_plant_id` BIGINT COMMENT 'Reference to the manufacturing plant or facility where the goods were received.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Received raw materials in chemical manufacturing are valuated and posted to profit centers for product cost tracking and segment inventory reporting. Required for profit-center-level inventory valuati',
    `purchase_order_id` BIGINT COMMENT 'Reference to the purchase order against which this goods receipt is posted. Links to the originating procurement document.',
    `safety_data_sheet_id` BIGINT COMMENT 'Foreign key linking to ehs.safety_data_sheet. Business justification: Goods receipt for hazardous chemicals requires current SDS on file per OSHA HazCom. goods_receipt has sds_version (denormalized) — replacing with FK to safety_data_sheet enables version-controlled SDS',
    `vehicle_id` BIGINT COMMENT 'Foreign key linking to logistics.vehicle. Business justification: Vehicle traceability on inbound hazmat receipts is a DOT and EHS regulatory requirement in chemical manufacturing: temperature control verification, cleaning certification, and incident investigation ',
    `vendor_id` BIGINT COMMENT 'Reference to the supplier or vendor from whom the materials were received. Links to vendor master data.',
    `warehouse_location_id` BIGINT COMMENT 'Reference to the specific storage location or warehouse area where the received materials are stored.',
    `work_order_id` BIGINT COMMENT 'Foreign key linking to maintenance.work_order. Business justification: Spare parts goods receipts in chemical plants are consumed against specific maintenance work orders. Linking goods_receipt to work_order enables material cost allocation to work orders, supports three',
    `cas_number` STRING COMMENT 'The unique CAS registry number identifying the chemical substance received. Used for regulatory reporting and safety data sheet (SDS) lookup.. Valid values are `^[0-9]{2,7}-[0-9]{2}-[0-9]$`',
    `coa_document_number` STRING COMMENT 'The document number or reference identifier of the vendor-supplied Certificate of Analysis for the received batch.. Valid values are `^[A-Z0-9-]{8,20}$`',
    `coa_received_flag` BOOLEAN COMMENT 'Boolean indicator specifying whether the vendor-supplied Certificate of Analysis has been received and attached to the goods receipt record.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this goods receipt record was first created in the system. Part of the audit trail for regulatory compliance.',
    `currency_code` STRING COMMENT 'The three-letter ISO 4217 currency code for the valuation amount (e.g., USD, EUR, GBP). [ENUM-REF-CANDIDATE: USD|EUR|GBP|JPY|CNY|INR|CAD|AUD|CHF|MXN — 10 candidates stripped; promote to reference product]',
    `damage_description` STRING COMMENT 'Free-text description of any damage, leakage, or packaging issues observed during receipt inspection. Used for vendor claims and quality investigations.',
    `delivery_note_number` STRING COMMENT 'The vendor-supplied delivery note or packing slip number accompanying the shipment. Used for cross-referencing with vendor documentation.. Valid values are `^[A-Z0-9-]{6,20}$`',
    `expiration_date` DATE COMMENT 'The expiration or shelf-life date of the received material batch. Critical for FEFO (First Expired First Out) inventory management and quality compliance.',
    `gr_date` DATE COMMENT 'The date on which the goods were physically received at the plant gate or warehouse dock. This is the principal business event timestamp for the receipt transaction.',
    `gr_document_number` STRING COMMENT 'The unique goods receipt document number generated by the ERP system (SAP material document number). This is the business identifier for the receipt transaction.. Valid values are `^[A-Z0-9]{10}$`',
    `gr_status` STRING COMMENT 'Current lifecycle status of the goods receipt transaction. Indicates whether the receipt is posted, pending approval, reversed, or blocked.. Valid values are `posted|pending|reversed|cancelled|blocked`',
    `gr_timestamp` TIMESTAMP COMMENT 'The precise date and time when the goods receipt was recorded in the system, including time zone information.',
    `hazmat_flag` BOOLEAN COMMENT 'Boolean indicator specifying whether the received material is classified as hazardous under DOT, OSHA, or EPA regulations. Triggers special handling and storage requirements.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this goods receipt record was last updated or modified. Part of the audit trail for regulatory compliance.',
    `movement_type` STRING COMMENT 'SAP movement type code indicating the nature of the goods receipt transaction (e.g., 101 for GR against PO, 102 for GR reversal, 161 for return delivery). [ENUM-REF-CANDIDATE: 101|102|103|105|161|501|511|Z01|Z02 — 9 candidates stripped; promote to reference product]',
    `notes` STRING COMMENT 'Free-text field for additional comments, observations, or special instructions related to the goods receipt transaction.',
    `packaging_condition` STRING COMMENT 'Assessment of the physical condition of the packaging upon receipt. Critical for identifying damage, leaks, or contamination of chemical shipments.. Valid values are `good|damaged|leaking|contaminated|acceptable_with_notes`',
    `posting_date` DATE COMMENT 'The accounting date on which the goods receipt transaction was posted to inventory and financial ledgers. May differ from GR date for period-end adjustments.',
    `quality_inspection_required_flag` BOOLEAN COMMENT 'Boolean indicator specifying whether the received material requires quality control inspection before release to unrestricted stock. Triggers QC workflow in LIMS.',
    `received_quantity` DECIMAL(18,2) COMMENT 'The actual quantity of material received and accepted at the dock. This is the line quantity for the receipt transaction.',
    `receiver_name` STRING COMMENT 'The name of the warehouse or receiving dock employee who physically accepted and inspected the shipment.',
    `retest_date` DATE COMMENT 'The date by which the material must be retested to confirm continued compliance with specifications. Common for raw materials with limited stability.',
    `seal_intact_flag` BOOLEAN COMMENT 'Boolean indicator specifying whether the security seal was found intact upon arrival. False value triggers security investigation.',
    `seal_number` STRING COMMENT 'The security seal number applied to the shipment container or truck. Verified upon receipt to ensure shipment integrity and prevent tampering.. Valid values are `^[A-Z0-9]{6,15}$`',
    `stock_type` STRING COMMENT 'The inventory stock type to which the received goods are posted. Quality inspection stock requires QC release before use; blocked stock cannot be used.. Valid values are `unrestricted|quality_inspection|blocked|restricted`',
    `temperature_on_arrival_c` DECIMAL(18,2) COMMENT 'The measured temperature of the material shipment upon arrival at the receiving dock, recorded in degrees Celsius. Critical for temperature-sensitive chemicals and compliance with storage specifications.',
    `un_number` STRING COMMENT 'The four-digit UN identification number for hazardous materials, used for transportation and storage classification (e.g., UN1090 for acetone).. Valid values are `^UN[0-9]{4}$`',
    `unit_of_measure` STRING COMMENT 'The unit of measure in which the received quantity is expressed (e.g., kilograms, liters, metric tons, gallons). [ENUM-REF-CANDIDATE: KG|L|MT|GAL|LB|TON|M3|EA|BOX|DRUM|PALLET — 11 candidates stripped; promote to reference product]',
    `valuation_amount` DECIMAL(18,2) COMMENT 'The total monetary value of the goods receipt transaction, calculated based on purchase order price and received quantity. Posted to inventory and financial accounts.',
    CONSTRAINT pk_goods_receipt PRIMARY KEY(`goods_receipt_id`)
) COMMENT 'Records the physical receipt of raw materials and chemicals at the plant gate or warehouse dock against a purchase order. Captures GR document number, GR date, vendor, material, received quantity, unit of measure, storage location, batch number (LOT), movement type, quality inspection flag, COA received flag, temperature on arrival, and SAP material document number. Triggers QC inspection workflow in LIMS. Integrates with SAP MM MIGO/MSEG.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`supply`.`asn` (
    `asn_id` BIGINT COMMENT 'Unique identifier for the Advanced Shipping Notice record.',
    `carrier_id` BIGINT COMMENT 'Foreign key linking to logistics.carrier. Business justification: Inbound ASN carrier validation is a named process in chemical manufacturing: approved hazmat carriers must be verified before accepting delivery. Links ASN to carrier master for DOT compliance checks ',
    `purchase_order_id` BIGINT COMMENT 'Reference to the purchase order against which this shipment is being delivered.',
    `vendor_id` BIGINT COMMENT 'Identifier of the chemical supplier sending the shipment.',
    `vendor_site_id` BIGINT COMMENT 'Foreign key linking to supply.vendor_site. Business justification: An ASN (Advanced Shipping Notice) originates from a specific vendor shipping site. The asn table currently stores shipping_point_code as a free-text string. Adding vendor_site_id FK normalizes this to',
    `actual_arrival_timestamp` TIMESTAMP COMMENT 'Actual date and time when the shipment physically arrived at the receiving facility.',
    `asn_number` STRING COMMENT 'Externally-known unique ASN document number provided by the supplier.. Valid values are `^ASN-[A-Z0-9]{8,15}$`',
    `asn_status` STRING COMMENT 'Current lifecycle status of the ASN in the receiving workflow. [ENUM-REF-CANDIDATE: draft|transmitted|in_transit|arrived|receiving|completed|cancelled — 7 candidates stripped; promote to reference product]',
    `asn_type` STRING COMMENT 'Classification of the ASN based on shipment characteristics and handling requirements.. Valid values are `standard|expedited|hazmat|bulk|consignment|drop_ship`',
    `container_number` STRING COMMENT 'ISO standard container identification number for intermodal shipments.. Valid values are `^[A-Z]{4}[0-9]{7}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the ASN record was first created in the system.',
    `expected_delivery_date` DATE COMMENT 'Scheduled date when the shipment is expected to arrive at the receiving facility.',
    `expected_delivery_time` TIMESTAMP COMMENT 'Precise timestamp when the shipment is scheduled to arrive at the receiving dock.',
    `freight_terms` STRING COMMENT 'Terms specifying who is responsible for freight payment and when title transfers.. Valid values are `prepaid|collect|third_party|FOB_origin|FOB_destination`',
    `hazmat_indicator` BOOLEAN COMMENT 'Flag indicating whether the shipment contains hazardous materials requiring special handling.',
    `hazmat_placard_code` STRING COMMENT 'DOT hazard class placard code required for transportation (e.g., 3 for flammable liquids, 8 for corrosives).. Valid values are `^[0-9]{1}(.[0-9]{1})?$`',
    `incoterms_code` STRING COMMENT 'Standard trade terms defining responsibilities for shipping costs and risk transfer between buyer and seller. [ENUM-REF-CANDIDATE: EXW|FCA|CPT|CIP|DAP|DPU|DDP|FAS|FOB|CFR|CIF — 11 candidates stripped; promote to reference product]',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the ASN record was last updated.',
    `package_count` STRING COMMENT 'Total number of packages, containers, or handling units in the shipment.',
    `pallet_count` STRING COMMENT 'Total number of pallets included in the shipment for warehouse planning.',
    `pro_number` STRING COMMENT 'Carrier-assigned tracking number for Less Than Truckload (LTL) shipments.. Valid values are `^PRO-[0-9]{8,12}$`',
    `receiving_dock_location` STRING COMMENT 'Specific dock or bay location at the receiving facility designated for unloading this shipment.',
    `receiving_plant_code` STRING COMMENT 'Code identifying the destination plant or facility where the shipment will be received.. Valid values are `^[A-Z0-9]{4,10}$`',
    `required_temperature_max` DECIMAL(18,2) COMMENT 'Maximum temperature threshold allowed during transportation to maintain product integrity.',
    `required_temperature_min` DECIMAL(18,2) COMMENT 'Minimum temperature threshold required during transportation to maintain product integrity.',
    `seal_number` STRING COMMENT 'Unique identifier of the security seal applied to the container or trailer.. Valid values are `^SEAL-[A-Z0-9]{6,15}$`',
    `shipment_mode` STRING COMMENT 'Transportation mode used for this shipment (Less Than Truckload, Full Truckload, etc.).. Valid values are `LTL|FTL|parcel|rail|intermodal|air`',
    `special_handling_instructions` STRING COMMENT 'Free-text instructions for special handling requirements during transportation and receiving.',
    `temperature_controlled_indicator` BOOLEAN COMMENT 'Flag indicating whether the shipment requires temperature-controlled transportation.',
    `temperature_unit_of_measure` STRING COMMENT 'Unit of measure for temperature values (Celsius, Fahrenheit, Kelvin).. Valid values are `C|F|K`',
    `total_gross_weight` DECIMAL(18,2) COMMENT 'Total gross weight of the entire shipment including packaging materials.',
    `total_net_weight` DECIMAL(18,2) COMMENT 'Total net weight of the chemical materials excluding packaging.',
    `total_volume` DECIMAL(18,2) COMMENT 'Total volume of the shipment for capacity planning and storage allocation.',
    `trailer_number` STRING COMMENT 'Identification number of the trailer or truck used for transportation.. Valid values are `^TRL-[A-Z0-9]{6,12}$`',
    `transmitted_timestamp` TIMESTAMP COMMENT 'Timestamp when the ASN was transmitted by the vendor to the receiving system.',
    `un_number` STRING COMMENT 'Four-digit UN identification number for hazardous substances as per international transport regulations.. Valid values are `^UN[0-9]{4}$`',
    `volume_unit_of_measure` STRING COMMENT 'Unit of measure for volume values (liters, gallons, cubic meters, cubic feet).. Valid values are `L|GAL|M3|FT3`',
    `weight_unit_of_measure` STRING COMMENT 'Unit of measure for weight values (kilograms, pounds, metric tons, tons).. Valid values are `KG|LB|MT|TON`',
    CONSTRAINT pk_asn PRIMARY KEY(`asn_id`)
) COMMENT 'Advanced Shipping Notice received from chemical suppliers prior to physical delivery, with full line-level material detail. Captures ASN number, vendor, PO reference, expected delivery date/time, carrier, bill of lading, container/trailer ID, hazmat placard codes, UN numbers. Line-level detail includes: material, CAS number, shipped quantity, unit of measure, batch/lot number, expiry date, country of origin, REACH registration number, SDS version reference, packaging type (drum, IBC, tanker, bag), and net/gross weight per line. Enables pre-receipt planning and line-level receiving reconciliation against PO lines. Integrates with Oracle TMS and SAP MM inbound delivery.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`supply`.`contract` (
    `contract_id` BIGINT COMMENT 'Primary key for contract',
    `material_master_id` BIGINT COMMENT 'FK to rawmaterial.material_master',
    `contract_material_material_master_id` BIGINT COMMENT 'FK to rawmaterial.material_master',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: Supply contracts are executed by a specific legal entity for tax, regulatory, and intercompany compliance. company_code is a denormalized legal entity reference; proper FK supports cross-border chemic',
    `material_specification_id` BIGINT COMMENT 'Foreign key linking to rawmaterial.material_specification. Business justification: Supply contracts in chemical manufacturing mandate specific material specification versions as quality requirements. Replacing the denormalized quality_specification text field with a proper FK enable',
    `operating_permit_id` BIGINT COMMENT 'Foreign key linking to ehs.operating_permit. Business justification: Supply contracts for PSM/RMP-covered chemicals must comply with facility operating permit quantity thresholds. Linking contract to the governing operating_permit enables compliance verification that c',
    `primary_contract_material_master_id` BIGINT COMMENT 'Reference to the primary chemical raw material or product covered by this contract. For multi-material contracts, this represents the primary or representative material.',
    `production_plant_id` BIGINT COMMENT 'Foreign key linking to production.plant. Business justification: Supply contracts in chemical manufacturing are plant-specific — a vendor contract for a raw material is valid for a specific manufacturing plant. Direct FK replaces denormalized plant_code, enabling p',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Long-term supply contracts in chemical manufacturing are budgeted and tracked at profit center level for strategic sourcing cost management and committed spend reporting against segment P&L.',
    `quality_specification_id` BIGINT COMMENT 'Foreign key linking to quality.quality_specification. Business justification: Supply contracts in chemical manufacturing explicitly reference quality specifications the vendor must meet. Contract already has a plain text quality_specification field — proper FK replaces this d',
    `vendor_id` BIGINT COMMENT 'Reference to the chemical supplier or raw material vendor party with whom this contract is established.',
    `vendor_site_id` BIGINT COMMENT 'Reference to the specific vendor location or plant from which materials will be supplied under this contract.',
    `approval_date` DATE COMMENT 'Date when the contract was formally approved by authorized signatories and became legally binding.',
    `approved_by_name` STRING COMMENT 'Name of the executive or manager who provided final approval for this contract.',
    `auto_renewal_flag` BOOLEAN COMMENT 'Indicates whether the contract automatically renews for another term if not explicitly terminated before the end date. True = auto-renews, False = expires at end date.',
    `cas_number` STRING COMMENT 'Unique numerical identifier assigned by the Chemical Abstracts Service to every chemical substance described in the open scientific literature. Used for regulatory compliance and material identification.. Valid values are `^[0-9]{2,7}-[0-9]{2}-[0-9]$`',
    `contract_number` STRING COMMENT 'Externally-known unique business identifier for the contract. Used in SAP MM ME31K and across procurement documents.. Valid values are `^[A-Z0-9]{8,20}$`',
    `contract_status` STRING COMMENT 'Current lifecycle status of the contract: draft (being prepared), pending approval (awaiting authorization), active (in force), suspended (temporarily halted), expired (validity period ended), terminated (ended early), or closed (completed and archived). [ENUM-REF-CANDIDATE: draft|pending_approval|active|suspended|expired|terminated|closed — 7 candidates stripped; promote to reference product]',
    `contract_type` STRING COMMENT 'Classification of the contract arrangement: quantity contract (fixed volume), value contract (fixed spend), scheduling agreement (delivery schedule), blanket purchase agreement (BPA), framework agreement, or spot contract.. Valid values are `quantity_contract|value_contract|scheduling_agreement|blanket_purchase_agreement|framework_agreement|spot_contract`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this contract record was first created in the system. Audit trail for record creation.',
    `delivery_frequency` STRING COMMENT 'Planned frequency of material deliveries under this contract: daily, weekly, biweekly, monthly, quarterly, on-demand (as needed), or just-in-time (JIT synchronized with production). [ENUM-REF-CANDIDATE: daily|weekly|biweekly|monthly|quarterly|on_demand|just_in_time — 7 candidates stripped; promote to reference product]',
    `force_majeure_terms` STRING COMMENT 'Contractual provisions defining events beyond parties control (natural disasters, war, pandemics, regulatory changes) that excuse performance obligations without penalty.',
    `incoterms` STRING COMMENT 'Standardized trade terms defining responsibilities for shipping, insurance, and risk transfer between buyer and seller (e.g., FOB, CIF, DDP). Incoterms 2020 standard. [ENUM-REF-CANDIDATE: EXW|FCA|CPT|CIP|DAP|DPU|DDP|FAS|FOB|CFR|CIF — 11 candidates stripped; promote to reference product]',
    `incoterms_location` STRING COMMENT 'Named place or port specified in the Incoterms clause (e.g., Houston TX, Rotterdam Port). Defines the point where risk and cost transfer occurs.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this contract record was last updated. Audit trail for record changes.',
    `lead_time_days` STRING COMMENT 'Standard procurement lead time in calendar days from order placement to delivery. Used for MRP planning and scheduling.',
    `maximum_order_quantity` DECIMAL(18,2) COMMENT 'Maximum quantity that can be ordered per purchase order or delivery schedule line. Used to manage supplier capacity constraints.',
    `minimum_order_quantity` DECIMAL(18,2) COMMENT 'Minimum quantity that must be ordered per purchase order or delivery schedule line under this contract. Enforces supplier minimum batch requirements.',
    `payment_terms` STRING COMMENT 'Agreed payment terms and conditions (e.g., Net 30, Net 60, 2/10 Net 30 for 2% discount if paid within 10 days). SAP payment terms key.',
    `price_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the contracted price (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `price_escalation_clause` STRING COMMENT 'Description of price adjustment mechanism tied to market indices, inflation rates, or raw material cost changes (e.g., quarterly adjustment based on PPI Chemical Index).',
    `price_per_unit` DECIMAL(18,2) COMMENT 'Base contracted price per unit of measure. For contracts with price scales or condition-based pricing, this represents the baseline or reference price.',
    `price_unit` STRING COMMENT 'Quantity unit for which the price is specified (e.g., price per 1, per 100, per 1000 units). Used in SAP pricing to handle fractional pricing.',
    `purchasing_group` STRING COMMENT 'Buyer or procurement team responsible for managing this contract. Typically a three-character code in SAP MM.',
    `purchasing_organization` STRING COMMENT 'SAP organizational unit responsible for procurement activities and contract negotiation. Typically a four-character code.',
    `quantity_unit` STRING COMMENT 'Unit of measure for the target quantity (e.g., KG for kilograms, L for liters, MT for metric tons, GAL for gallons).',
    `renewal_term_months` STRING COMMENT 'Duration in months for each automatic renewal period if auto-renewal is enabled.',
    `target_quantity` DECIMAL(18,2) COMMENT 'Total volume or quantity of material committed under this contract. Applicable for quantity contracts and scheduling agreements.',
    `termination_notice_days` STRING COMMENT 'Number of calendar days advance notice required to terminate the contract early. Protects both parties from abrupt contract cancellation.',
    `validity_end_date` DATE COMMENT 'Date on which the contract expires or terminates. Nullable for open-ended contracts. After this date, contract terms no longer apply unless renewed.',
    `validity_start_date` DATE COMMENT 'Date from which the contract becomes legally binding and effective. Contract terms apply from this date forward.',
    `value_amount` DECIMAL(18,2) COMMENT 'Total monetary value committed under this contract. For value contracts, this is the maximum spend limit. For quantity contracts, this is the estimated total value based on contracted volumes and prices.',
    `value_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the contract value (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    CONSTRAINT pk_contract PRIMARY KEY(`contract_id`)
) COMMENT 'Long-term supply agreements, blanket purchase agreements, and scheduling agreements with chemical raw material suppliers. Captures contract number, type (quantity contract, value contract, scheduling agreement), vendor, material, validity period, total value, volume commitment, MOQ, delivery frequency, quality specifications, force majeure terms, and contract status. Includes all contracted pricing conditions (price scales, surcharges, discounts, escalation clauses, condition types, price determination sequences), and scheduling agreement delivery schedule lines (planned delivery dates, quantities, cumulative receipts, forecast vs. firm categories). Single source of truth for all long-term vendor commercial arrangements, their pricing, and delivery schedules. Integrates with SAP MM ME31K, condition records (KONP/KONH), and scheduling agreement transactions.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`supply`.`contract_price` (
    `contract_price_id` BIGINT COMMENT 'Unique identifier for the contract price record. Primary key for the contract price entity.',
    `cost_element_id` BIGINT COMMENT 'Foreign key linking to finance.cost_element. Business justification: Raw material purchase prices in chemical manufacturing are mapped to cost elements for standard costing and purchase price variance analysis. Procurement controllers use this link for cost roll-up and',
    `material_master_id` BIGINT COMMENT 'Reference to the chemical material or raw material covered by this contract price. Links to material master data.',
    `production_plant_id` BIGINT COMMENT 'Foreign key linking to production.plant. Business justification: Contract prices in chemical manufacturing are plant-specific — different plants negotiate different unit prices for the same raw material based on volume, logistics, and local regulations. Direct FK r',
    `contract_id` BIGINT COMMENT 'FK to supply.contract',
    `vendor_id` BIGINT COMMENT 'Reference to the chemical supplier or vendor providing the contracted pricing. Links to vendor master data.',
    `approval_status` STRING COMMENT 'Approval workflow status for the contract price. Indicates whether the price has been reviewed and authorized by procurement management.. Valid values are `approved|pending|rejected|not_required`',
    `approved_by` STRING COMMENT 'User ID or name of the procurement manager or authorized approver who approved this contract price.',
    `approved_date` DATE COMMENT 'Date when the contract price was formally approved and authorized for use in purchase orders.',
    `calculation_type` STRING COMMENT 'Method for calculating the condition value: percentage (e.g., 5% discount), fixed amount per unit, or absolute amount per order.. Valid values are `percentage|fixed_amount|absolute`',
    `condition_class` STRING COMMENT 'Classification of the pricing condition into business categories: base price, surcharge (e.g., hazmat handling), discount, freight, tax, or other adjustments.. Valid values are `base_price|surcharge|discount|freight|tax|other`',
    `condition_record_number` STRING COMMENT 'SAP MM condition record number (KNUMH) that uniquely identifies the pricing condition in the source system. Business identifier for the contract price.',
    `condition_type` STRING COMMENT 'SAP condition type code that classifies the pricing element (e.g., PB00 for gross price, FRA1 for freight, SKTO for cash discount). Determines how the price is applied in purchase order calculation.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the contract price record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the contract price (e.g., USD, EUR, GBP). Defines the monetary unit of the price amount.. Valid values are `^[A-Z]{3}$`',
    `freight_included_flag` BOOLEAN COMMENT 'Indicates whether freight and transportation costs are included in the contract price or billed separately.',
    `hazmat_surcharge_flag` BOOLEAN COMMENT 'Indicates whether this price includes or is subject to a hazardous material handling surcharge due to the chemical nature of the material.',
    `incoterms` STRING COMMENT 'Incoterms code defining the delivery terms and transfer of risk (e.g., EXW, FOB, CIF, DDP). Impacts freight and insurance pricing components.',
    `incoterms_location` STRING COMMENT 'Named place or port specified in the Incoterms agreement (e.g., Houston Port, Vendor Warehouse). Clarifies the point of delivery or risk transfer.',
    `info_record_number` STRING COMMENT 'SAP purchasing info record number that stores vendor-material pricing and procurement data. Alternative to contract-based pricing.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when the contract price record was last updated or modified.',
    `maximum_order_quantity` DECIMAL(18,2) COMMENT 'Maximum order quantity allowed under this contract price. Orders exceeding this limit may require renegotiation or different pricing.',
    `minimum_order_quantity` DECIMAL(18,2) COMMENT 'Minimum order quantity required to qualify for this contract price. Orders below this threshold may not receive the contracted rate.',
    `negotiation_date` DATE COMMENT 'Date when the contract price was negotiated and agreed upon with the vendor.',
    `payment_terms` STRING COMMENT 'Payment terms code defining the payment schedule and discount conditions (e.g., Net 30, 2/10 Net 30). Influences cash discount calculations.',
    `price_amount` DECIMAL(18,2) COMMENT 'The contracted price value or rate for the material. Represents the base price, surcharge, or discount amount depending on condition type.',
    `price_change_reason` STRING COMMENT 'Business justification or reason code for the price change or new pricing condition (e.g., raw material cost increase, volume commitment, market adjustment).',
    `price_determination_rule` STRING COMMENT 'Rule or logic used to determine the final price when multiple condition records exist (e.g., most specific, lowest price, highest discount). Governs price selection in purchase orders.',
    `price_source` STRING COMMENT 'Origin of the contract price: contract (formal supply agreement), info record (vendor-material record), quotation (RFQ response), catalog (vendor price list), or manual entry.. Valid values are `contract|info_record|quotation|catalog|manual`',
    `price_status` STRING COMMENT 'Current lifecycle status of the contract price: active (in use), inactive (disabled), pending (awaiting approval), expired (past validity), or superseded (replaced by newer price).. Valid values are `active|inactive|pending|expired|superseded`',
    `price_unit` DECIMAL(18,2) COMMENT 'Quantity unit for which the price amount applies (e.g., price per 1 unit, per 100 units, per 1000 kg). Used to normalize pricing across different order quantities.',
    `pricing_sequence` STRING COMMENT 'Order of application in the pricing procedure. Lower numbers are applied first. Determines the sequence of price calculations, surcharges, and discounts.',
    `purchasing_organization` STRING COMMENT 'Organizational unit responsible for procurement activities under this contract price. Defines the scope of the pricing agreement.',
    `scale_quantity_from` DECIMAL(18,2) COMMENT 'Lower bound of the quantity scale break for tiered pricing. Defines the minimum order quantity for this price tier. Null for non-scaled pricing.',
    `scale_quantity_to` DECIMAL(18,2) COMMENT 'Upper bound of the quantity scale break for tiered pricing. Defines the maximum order quantity for this price tier. Null for open-ended top tier.',
    `scale_type` STRING COMMENT 'Type of scale pricing applied: quantity-based (volume discounts), value-based (order value thresholds), or none for flat pricing.. Valid values are `quantity|value|none`',
    `tax_code` STRING COMMENT 'Tax jurisdiction code or tax type applicable to this contract price (e.g., sales tax, VAT, excise tax). Used for tax calculation in purchase orders.',
    `unit_of_measure` STRING COMMENT 'Unit of measure for the material quantity (e.g., KG for kilograms, L for liters, MT for metric tons, GAL for gallons). Aligns with material master UOM.',
    `valid_from_date` DATE COMMENT 'Start date of the contract price validity period. The price becomes effective on this date.',
    `valid_to_date` DATE COMMENT 'End date of the contract price validity period. The price expires after this date. May be open-ended (null) for indefinite agreements.',
    CONSTRAINT pk_contract_price PRIMARY KEY(`contract_price_id`)
) COMMENT 'Contracted pricing conditions and price scales negotiated with chemical suppliers under supply contracts or info records. Captures condition type, material, vendor, plant, validity period, base price, price unit, currency, quantity scale breaks, surcharges (freight, hazmat handling), discounts, and price determination sequence. Supports accurate PO pricing and cost variance analysis. Integrates with SAP MM condition records (KONP/KONH).';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`supply`.`vendor_qualification` (
    `vendor_qualification_id` BIGINT COMMENT 'Unique identifier for the vendor qualification record. Primary key for the vendor qualification lifecycle.',
    `inspection_audit_id` BIGINT COMMENT 'Foreign key linking to ehs.inspection_audit. Business justification: EHS inspection audits of vendor facilities directly determine vendor qualification outcomes in chemical manufacturing. Linking vendor_qualification to the triggering inspection_audit enables traceabil',
    `inspection_plan_id` BIGINT COMMENT 'Foreign key linking to quality.inspection_plan. Business justification: Vendor qualification in chemical manufacturing references the inspection plan used to assess the vendors materials. Direct FK enables Approved Vendor List (AVL) management linking qualification scope',
    `production_plant_id` BIGINT COMMENT 'Foreign key linking to production.plant. Business justification: Vendor qualifications in chemical manufacturing are plant-specific — a vendor may be qualified to supply one plant but not another due to local regulatory requirements, logistics, or process compatibi',
    `quality_specification_id` BIGINT COMMENT 'Foreign key linking to quality.quality_specification. Business justification: Qualifying a vendor means verifying they can meet the quality specification for the supplied material. Direct FK links qualification scope to the specific quality spec, enabling AVL management and reg',
    `vendor_id` BIGINT COMMENT 'Reference to the chemical supplier or vendor being qualified. Links to the vendor master data.',
    `actual_completion_date` DATE COMMENT 'Actual date when the qualification assessment was completed and final status determined.',
    `approval_date` DATE COMMENT 'Date when the vendor qualification was formally approved by authorized personnel.',
    `audit_duration_days` STRING COMMENT 'Total number of days spent conducting the qualification audit including preparation, on-site/remote assessment, and reporting.',
    `audit_method` STRING COMMENT 'Method used to conduct the qualification audit: on-site (physical visit to vendor facility), remote (virtual audit), hybrid (combination), or desktop_review (document-only assessment).. Valid values are `on_site|remote|hybrid|desktop_review`',
    `audit_team_members` STRING COMMENT 'Comma-separated list of employee names or identifiers who participated in the qualification audit team.',
    `capa_due_date` DATE COMMENT 'Target date by which the vendor must complete and submit CAPA (Corrective and Preventive Action) responses for audit findings.',
    `capa_required_flag` BOOLEAN COMMENT 'Indicates whether CAPA (Corrective and Preventive Action) is required from the vendor to address audit findings before or after qualification approval.',
    `delivery_performance_score` DECIMAL(18,2) COMMENT 'Score for logistics and delivery performance including on-time delivery rate, lead time reliability, and order fulfillment accuracy.',
    `effective_from_date` DATE COMMENT 'Date from which the vendor qualification becomes effective and the vendor is authorized for procurement activities.',
    `ehs_score` DECIMAL(18,2) COMMENT 'Score for environmental, health, and safety compliance assessment including EHS management systems, incident history, and regulatory compliance.',
    `expiry_date` DATE COMMENT 'Date when the vendor qualification expires and requires renewal or re-qualification assessment.',
    `financial_stability_score` DECIMAL(18,2) COMMENT 'Score for financial health assessment including credit rating, financial statements review, and business continuity risk.',
    `findings_critical_count` STRING COMMENT 'Number of critical findings identified during the qualification audit that represent major non-conformances or immediate risks requiring resolution before approval.',
    `findings_major_count` STRING COMMENT 'Number of major findings identified during the qualification audit that represent significant non-conformances requiring corrective action.',
    `findings_minor_count` STRING COMMENT 'Number of minor findings or observations identified during the qualification audit that represent opportunities for improvement.',
    `gmp_certified_flag` BOOLEAN COMMENT 'Indicates whether the vendor holds valid GMP (Good Manufacturing Practice) certification for pharmaceutical or food-contact chemical manufacturing.',
    `initiated_date` DATE COMMENT 'Date when the vendor qualification process was formally initiated.',
    `iso_14001_certified_flag` BOOLEAN COMMENT 'Indicates whether the vendor holds valid ISO 14001 Environmental Management System certification.',
    `iso_45001_certified_flag` BOOLEAN COMMENT 'Indicates whether the vendor holds valid ISO 45001 Occupational Health and Safety Management System certification.',
    `iso_9001_certified_flag` BOOLEAN COMMENT 'Indicates whether the vendor holds valid ISO 9001 Quality Management System certification.',
    `material_category` STRING COMMENT 'Primary chemical material category or product family that this qualification covers (e.g., solvents, polymers, catalysts, intermediates, specialty chemicals).',
    `next_review_date` DATE COMMENT 'Scheduled date for the next periodic review or re-qualification assessment of the vendor.',
    `notes` STRING COMMENT 'Additional notes, comments, or observations related to the vendor qualification assessment, including special conditions or restrictions.',
    `qualification_number` STRING COMMENT 'Business identifier for the vendor qualification record. Format: VQ-YYYYNNNN where YYYY is year and NNNN is sequence.. Valid values are `^VQ-[0-9]{8}$`',
    `qualification_scope` STRING COMMENT 'Detailed description of the scope of qualification including product categories, material types, and services covered by this qualification assessment.',
    `qualification_score` DECIMAL(18,2) COMMENT 'Composite numerical score representing the overall qualification assessment result, typically on a 0-100 scale based on weighted criteria.',
    `qualification_status` STRING COMMENT 'Current lifecycle status of the vendor qualification: draft (initiated), in_progress (assessment underway), under_review (pending approval), approved (vendor qualified), rejected (vendor not qualified), suspended (temporarily disqualified), expired (qualification period ended). [ENUM-REF-CANDIDATE: draft|in_progress|under_review|approved|rejected|suspended|expired — 7 candidates stripped; promote to reference product]',
    `qualification_type` STRING COMMENT 'Type of qualification assessment being performed: initial (new vendor), periodic (scheduled review), for-cause (triggered by incident), re-qualification (after suspension), or expedited (fast-track for critical need).. Valid values are `initial|periodic|for_cause|re_qualification|expedited`',
    `quality_score` DECIMAL(18,2) COMMENT 'Score for quality management system assessment including QMS (Quality Management System) certification, process controls, and product quality history.',
    `reach_compliant_flag` BOOLEAN COMMENT 'Indicates whether the vendor is compliant with REACH (Registration Evaluation Authorization and Restriction of Chemicals) regulation for European chemical substance registration.',
    `regulatory_compliance_score` DECIMAL(18,2) COMMENT 'Score for regulatory compliance assessment covering REACH (Registration Evaluation Authorization and Restriction of Chemicals), TSCA (Toxic Substances Control Act), GHS (Globally Harmonized System), and other applicable chemical regulations.',
    `rejection_reason` STRING COMMENT 'Detailed explanation of why the vendor qualification was rejected, including specific deficiencies or non-conformances that led to the rejection decision.',
    `responsible_care_member_flag` BOOLEAN COMMENT 'Indicates whether the vendor is a member of the Responsible Care program administered by the American Chemistry Council (ACC) or equivalent regional program.',
    `risk_classification` STRING COMMENT 'Overall supply risk classification of the vendor based on criticality of materials, single-source dependency, regulatory complexity, and business impact.. Valid values are `low|medium|high|critical`',
    `target_completion_date` DATE COMMENT 'Planned date by which the qualification assessment should be completed and decision rendered.',
    `tsca_compliant_flag` BOOLEAN COMMENT 'Indicates whether the vendor is compliant with TSCA (Toxic Substances Control Act) requirements for chemical substances manufactured or imported into the United States.',
    CONSTRAINT pk_vendor_qualification PRIMARY KEY(`vendor_qualification_id`)
) COMMENT 'Comprehensive supplier qualification, audit, and compliance documentation lifecycle for chemical vendors. Covers formal qualification assessments (initial, periodic, for-cause), on-site and remote audit records (quality, EHS, PSM, GMP) with findings by severity and audit ratings, and the full repository of compliance documents (SDS, COA, COC, REACH dossiers, TSCA certifications, ISO/GMP certificates, Responsible Care attestations). Captures qualification status, audit scores, document versions and expiry dates, CAPA requirements from audits, lead auditor assignments, and document validity. Single source of truth for is this vendor approved, what audits have been conducted, and what evidence supports that decision. Prerequisite for issuing POs to new suppliers.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`supply`.`vendor_audit` (
    `vendor_audit_id` BIGINT COMMENT 'Unique identifier for the vendor audit record. Primary key.',
    `vendor_id` BIGINT COMMENT 'Reference to the chemical supplier or vendor being audited.',
    `vendor_qualification_id` BIGINT COMMENT 'Foreign key linking to supply.vendor_qualification. Business justification: Vendor audits in chemical manufacturing are conducted as part of the supplier qualification and re-qualification lifecycle. A vendor_qualification record governs the overall qualification process, and',
    `vendor_site_id` BIGINT COMMENT 'Foreign key linking to supply.vendor_site. Business justification: Vendor audits are conducted at specific vendor facilities (plants, warehouses). The vendor_audit table stores audit_location as a free-text STRING but has no FK to vendor_site. Adding vendor_site_id n',
    `audit_closure_date` DATE COMMENT 'Date the audit was formally closed after all findings were addressed, CAPA verified, and follow-up activities completed.',
    `audit_date` DATE COMMENT 'The date the on-site or remote audit was conducted or commenced. Principal business event timestamp for the audit.',
    `audit_end_date` DATE COMMENT 'The date the audit fieldwork was completed. Nullable for single-day audits.',
    `audit_frequency_months` STRING COMMENT 'Frequency in months at which this vendor should be audited, based on risk classification and business criticality (e.g., 12, 24, 36 months).',
    `audit_method` STRING COMMENT 'Method by which the audit was conducted: on_site (physical presence at vendor facility), remote (virtual/online audit), hybrid (combination of on-site and remote).. Valid values are `on_site|remote|hybrid`',
    `audit_number` STRING COMMENT 'Externally-known unique audit identifier assigned by the auditing organization or system. Typically follows a pattern such as QA-20230145 or EHS-2023-0012.. Valid values are `^[A-Z]{2,4}-[0-9]{4,8}$`',
    `audit_report_issued_date` DATE COMMENT 'Date the formal audit report was issued to the vendor and internal stakeholders.',
    `audit_scope` STRING COMMENT 'Detailed description of the audit scope, including processes, systems, facilities, and standards evaluated during the audit.',
    `audit_score` DECIMAL(18,2) COMMENT 'Numerical score assigned to the audit, typically on a scale of 0-100, representing the vendors overall performance against audit criteria.',
    `audit_status` STRING COMMENT 'Current lifecycle status of the audit: scheduled (planned but not started), in_progress (audit fieldwork underway), completed (audit finished, report issued), closed (all CAPA completed and verified), cancelled (audit did not proceed).. Valid values are `scheduled|in_progress|completed|closed|cancelled`',
    `audit_team_members` STRING COMMENT 'Comma-separated list of additional auditor names who participated in the audit alongside the lead auditor.',
    `audit_type` STRING COMMENT 'Classification of the audit scope: quality (QM systems), EHS (Environment Health and Safety), PSM (Process Safety Management), GMP (Good Manufacturing Practice), combined (multiple disciplines), or responsible_care (ACC Responsible Care program).. Valid values are `quality|ehs|psm|gmp|combined|responsible_care`',
    `capa_approval_date` DATE COMMENT 'Date the vendors CAPA plan was reviewed and approved by the auditing organization. Nullable if not yet approved.',
    `capa_due_date` DATE COMMENT 'Target date by which the vendor must submit their CAPA plan addressing audit findings. Nullable if no CAPA is required.',
    `capa_required_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the vendor is required to submit a formal CAPA plan to address audit findings. True if CAPA is required, False otherwise.',
    `capa_submission_date` DATE COMMENT 'Actual date the vendor submitted their CAPA plan. Nullable if not yet submitted.',
    `comments` STRING COMMENT 'Free-text field for additional comments, observations, or context related to the audit that do not fit into structured fields.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this vendor audit record was first created in the system.',
    `findings_critical_count` STRING COMMENT 'Number of critical severity findings identified during the audit. Critical findings represent immediate risks to safety, compliance, or product quality requiring urgent corrective action.',
    `findings_major_count` STRING COMMENT 'Number of major severity findings identified during the audit. Major findings represent significant non-conformances that could impact quality, safety, or regulatory compliance.',
    `findings_minor_count` STRING COMMENT 'Number of minor severity findings identified during the audit. Minor findings represent isolated non-conformances or opportunities for improvement that do not pose immediate risk.',
    `findings_observation_count` STRING COMMENT 'Number of observations or recommendations noted during the audit that are not formal non-conformances but represent best practice suggestions.',
    `follow_up_audit_required_flag` BOOLEAN COMMENT 'Boolean flag indicating whether a follow-up audit is required to verify implementation of corrective actions. True if follow-up audit is required, False otherwise.',
    `follow_up_completion_date` DATE COMMENT 'Actual date the follow-up verification activities were completed. Nullable if not yet completed.',
    `follow_up_due_date` DATE COMMENT 'Target date by which follow-up verification activities (audit or desk review) must be completed to confirm CAPA effectiveness.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this vendor audit record was last updated in the system.',
    `lead_auditor_name` STRING COMMENT 'Full name of the lead auditor responsible for conducting and reporting the audit.',
    `next_audit_due_date` DATE COMMENT 'Scheduled date for the next periodic audit of this vendor, typically based on audit frequency policy and risk assessment.',
    `overall_audit_rating` STRING COMMENT 'Overall assessment rating assigned to the vendor based on audit results. Determines vendor qualification status and future business relationship.. Valid values are `excellent|satisfactory|needs_improvement|unsatisfactory|conditional_approval|not_approved`',
    `responsible_care_compliant_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the vendor demonstrates compliance with the American Chemistry Council (ACC) Responsible Care program requirements. True if compliant, False otherwise.',
    `standards_audited_against` STRING COMMENT 'Comma-separated list of standards, regulations, or frameworks against which the vendor was audited (e.g., ISO 9001, ISO 14001, ISO 45001, OSHA PSM, GMP, REACH, Responsible Care).',
    `vendor_response_date` DATE COMMENT 'Date the vendor submitted their formal response to the audit findings. Nullable if no response received.',
    `vendor_response_received_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the vendor has provided a formal response to the audit findings. True if response received, False otherwise.',
    CONSTRAINT pk_vendor_audit PRIMARY KEY(`vendor_audit_id`)
) COMMENT 'On-site and remote audit records conducted at chemical supplier facilities to assess quality systems, EHS compliance, process safety, and regulatory adherence. Captures audit number, vendor, audit type (quality, EHS, PSM, GMP, combined), audit date, lead auditor, audit scope, findings count by severity (critical, major, minor), overall audit rating, CAPA required flag, follow-up due date, and audit closure status. Supports Responsible Care program requirements.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`supply`.`purchase_requisition` (
    `purchase_requisition_id` BIGINT COMMENT 'Unique identifier for the purchase requisition record. Primary key.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Requisitions in chemical manufacturing are raised against cost centers for budget availability checking before PO creation. cost_center is a plain denormalized code; proper FK enables automated budget',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Requisitions specify GL account for account assignment driving automatic account determination on PO creation. gl_account_code is a denormalized GL reference; proper FK supports procurement-to-pay fin',
    `internal_order_id` BIGINT COMMENT 'Foreign key linking to finance.internal_order. Business justification: Requisitions for capital or project-specific chemical procurement are raised against internal orders for budget availability checks. This is a standard SAP account assignment enabling project cost com',
    `material_master_id` BIGINT COMMENT 'FK to rawmaterial.material_master',
    `mrp_run_id` BIGINT COMMENT 'Foreign key linking to planning.mrp_run. Business justification: MRP runs are the primary generator of purchase requisitions in chemical manufacturing ERP systems (SAP standard). Linking PRs to their originating MRP run is essential for exception management, re-pla',
    `vendor_id` BIGINT COMMENT 'Identifier of the preferred or suggested vendor for sourcing this requisition, if specified by the requester.',
    `process_order_id` BIGINT COMMENT 'Foreign key linking to production.process_order. Business justification: In chemical manufacturing, MRP generates purchase requisitions directly from process orders when raw material shortages are identified. Procurement planners use this link to expedite deliveries, alloc',
    `production_plant_id` BIGINT COMMENT 'Foreign key linking to production.plant. Business justification: Purchase requisitions in chemical manufacturing are plant-specific — MRP generates requisitions per plant based on plant-level stock requirements. Direct FK replaces denormalized plant_code, enabling ',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Chemical manufacturing requisitions are assigned to profit centers for segment-level spend visibility and committed cost reporting before PO creation. Required for product-line procurement budget mana',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to supply.purchase_order. Business justification: A purchase requisition converts to a purchase order — this is the fundamental procurement workflow in chemical manufacturing (MRP-driven PR → PO conversion). The table currently stores po_number (STRI',
    `quality_specification_id` BIGINT COMMENT 'Foreign key linking to quality.quality_specification. Business justification: Purchase requisitions for chemical raw materials specify the quality specification required from the supplier. Direct FK supports procurement quality requirements management and ensures requisitions r',
    `stock_position_id` BIGINT COMMENT 'Foreign key linking to inventory.stock_position. Business justification: MRP-driven purchase requisitions in chemical manufacturing are triggered by specific stock positions falling below reorder/safety stock thresholds. Linking requisition to the originating stock_positio',
    `supply_plan_id` BIGINT COMMENT 'Foreign key linking to planning.supply_plan. Business justification: In chemical manufacturing S&OP processes, purchase requisitions are generated in execution of approved supply plans. Linking PRs to their governing supply plan enables supply plan consumption tracking',
    `approval_date` DATE COMMENT 'Date when the requisition was approved by the authorized approver.',
    `approval_status` STRING COMMENT 'Current approval status of the requisition in the multi-level approval workflow.. Valid values are `pending|approved|rejected|escalated`',
    `approver_name` STRING COMMENT 'Name of the manager or authorized person who approved or rejected the requisition.',
    `campaign_production_flag` BOOLEAN COMMENT 'Indicates whether this requisition is aligned with a campaign production schedule for batch manufacturing.',
    `cas_number` STRING COMMENT 'Unique numerical identifier assigned by Chemical Abstracts Service to every chemical substance, used for regulatory compliance and material identification.. Valid values are `^[0-9]{2,7}-[0-9]{2}-[0-9]$`',
    `currency_code` STRING COMMENT 'Three-letter ISO currency code for the estimated price and total value.. Valid values are `^[A-Z]{3}$`',
    `estimated_total_value` DECIMAL(18,2) COMMENT 'Total estimated value of the requisition calculated as quantity multiplied by estimated unit price.',
    `estimated_unit_price` DECIMAL(18,2) COMMENT 'Estimated price per unit of the material or service at the time of requisition creation.',
    `hazmat_flag` BOOLEAN COMMENT 'Indicates whether the requisitioned material is classified as hazardous and requires special handling, transport, and regulatory compliance.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the requisition record, capturing any changes to status, quantities, or other fields.',
    `lead_time_days` STRING COMMENT 'Expected number of days from requisition approval to material delivery, including hazmat transport buffers if applicable.',
    `material_number` STRING COMMENT 'Unique identifier for the material being requisitioned, referencing the material master.. Valid values are `^[A-Z0-9]{18}$`',
    `mrp_element` STRING COMMENT 'Type of MRP element that generated or is associated with this requisition in the planning run.. Valid values are `planned_order|purchase_requisition|schedule_line`',
    `notes` STRING COMMENT 'Free-text notes or special instructions provided by the requester regarding material specifications, delivery requirements, or other procurement considerations.',
    `planner_code` STRING COMMENT 'Code identifying the MRP planner or buyer responsible for managing procurement of this material.. Valid values are `^[A-Z0-9]{3}$`',
    `planning_horizon` STRING COMMENT 'Time bucket granularity for forward-looking procurement planning associated with this requisition.. Valid values are `weekly|monthly|quarterly`',
    `po_conversion_status` STRING COMMENT 'Status indicating whether the requisition has been converted to one or more purchase orders.. Valid values are `not_converted|partially_converted|fully_converted`',
    `priority` STRING COMMENT 'Business priority level assigned to the requisition to guide procurement sequencing and expediting decisions.. Valid values are `low|normal|high|urgent`',
    `procurement_type` STRING COMMENT 'Classification of procurement purpose: stock replenishment, direct consumption, asset acquisition, or project-specific procurement.. Valid values are `stock|consumption|asset|project`',
    `purchasing_group` STRING COMMENT 'Organizational unit responsible for procurement activities related to this requisition.. Valid values are `^[A-Z0-9]{3}$`',
    `quantity` DECIMAL(18,2) COMMENT 'Quantity of material or service being requested in the requisition.',
    `requested_delivery_date` DATE COMMENT 'Date by which the requested material or service is required at the destination.',
    `requester_phone` STRING COMMENT 'Contact phone number of the requisition requester for clarifications and follow-up.',
    `requisition_number` STRING COMMENT 'Business identifier for the purchase requisition, externally visible and used in procurement workflows.. Valid values are `^PR[0-9]{10}$`',
    `requisition_status` STRING COMMENT 'Current lifecycle status of the requisition in the approval and conversion workflow. [ENUM-REF-CANDIDATE: draft|submitted|approved|rejected|partially_converted|fully_converted|cancelled|closed — 8 candidates stripped; promote to reference product]',
    `requisition_type` STRING COMMENT 'Classification of the requisition based on procurement scenario: standard purchase, subcontracting, consignment, stock transfer, service procurement, or third-party order.. Valid values are `standard|subcontracting|consignment|stock_transfer|service|third_party`',
    `safety_stock_trigger` BOOLEAN COMMENT 'Indicates whether this requisition was triggered by safety stock replenishment logic in MRP.',
    `source_of_supply` STRING COMMENT 'Planned source type for fulfilling the requisition: external procurement from vendor, internal stock transfer, subcontracting, or consignment.. Valid values are `external_procurement|internal_transfer|subcontracting|consignment`',
    `storage_location` STRING COMMENT 'Specific storage location within the plant where the material will be received.. Valid values are `^[A-Z0-9]{4}$`',
    `unit_of_measure` STRING COMMENT 'Unit of measure for the requisitioned quantity (e.g., KG for kilograms, L for liters, EA for each).. Valid values are `^[A-Z]{2,3}$`',
    `creation_date` DATE COMMENT 'Date when the purchase requisition was originally created in the system.',
    CONSTRAINT pk_purchase_requisition PRIMARY KEY(`purchase_requisition_id`)
) COMMENT 'Internal procurement request records and forward-looking procurement planning covering the full demand-to-sourcing lifecycle. Captures requisition number, type, requesting plant/cost center, material/CAS number, required quantity, delivery date, preferred vendor, estimated price, approval status, and PO conversion status. Also encompasses MRP-generated planned procurement schedules: planning horizons (weekly/monthly/quarterly), planned quantities and dates, source of supply assignments, procurement types, lead time buffers for hazmat transport, planner assignments, safety stock triggers, and campaign production schedule alignment. Integrates with SAP MM ME51N/ME52N and MRP outputs (MD04/MD07).';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`supply`.`source_list` (
    `source_list_id` BIGINT COMMENT 'Unique identifier for the source list record. Primary key.',
    `carrier_id` BIGINT COMMENT 'Foreign key linking to logistics.carrier. Business justification: Source lists in chemical manufacturing specify approved carriers for inbound hazmat material movements alongside approved vendors. Linking source_list to carrier enforces approved carrier routing for ',
    `contract_id` BIGINT COMMENT 'Foreign key linking to supply.contract. Business justification: In SAP MM procurement (referenced in domain description), source list entries reference outline agreements (contracts and scheduling agreements) that authorize a vendor to supply a specific material. ',
    `material_master_id` BIGINT COMMENT 'Reference to the raw material or chemical product that this source list entry applies to. Links to the material master data.',
    `production_plant_id` BIGINT COMMENT 'Foreign key linking to production.plant. Business justification: Source lists in chemical manufacturing define approved vendors for a material at a specific plant — they are inherently plant-specific procurement master data. Direct FK replaces denormalized plant_co',
    `quality_specification_id` BIGINT COMMENT 'Foreign key linking to quality.quality_specification. Business justification: Source list entries (Approved Vendor List) in chemical manufacturing reference the quality specification the vendor is approved to supply against. Direct FK enables AVL quality compliance reporting an',
    `vendor_id` BIGINT COMMENT 'Reference to the approved supplier or vendor authorized to supply this material to the specified plant.',
    `agreement_item` STRING COMMENT 'The line item number within the referenced contract or scheduling agreement that applies to this material-vendor-plant combination.',
    `agreement_type` STRING COMMENT 'The type of purchasing agreement that governs this source list entry. Indicates whether a formal contract or scheduling agreement is in place.. Valid values are `contract|scheduling_agreement|none`',
    `avl_status` STRING COMMENT 'The current status of this vendor on the Approved Vendor List for the material-plant combination. Enforces procurement compliance and quality standards.. Valid values are `approved|conditional|rejected|expired`',
    `blocked_flag` BOOLEAN COMMENT 'Indicates whether this source list entry is temporarily blocked from use in procurement. Used to suspend a vendor without deleting the source list record.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this source list entry was created in the system. Part of the audit trail for source list management.',
    `fixed_source_flag` BOOLEAN COMMENT 'Indicates whether this vendor is the mandatory (fixed) source for the material-plant combination. When true, procurement must use this vendor exclusively during the validity period.',
    `incoterm` STRING COMMENT 'The International Commercial Terms (Incoterms) that govern the delivery and risk transfer for shipments from this vendor. Examples: EXW, FOB, CIF, DDP.',
    `incoterm_location` STRING COMMENT 'The specific location (port, warehouse, plant) associated with the Incoterm for this source list entry. Clarifies the point of delivery or risk transfer.',
    `last_modified_by` STRING COMMENT 'The user ID or name of the person who last modified this source list entry. Supports change tracking and accountability.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this source list entry was last modified. Tracks the currency of the source list data.',
    `last_purchase_order_date` DATE COMMENT 'The date of the most recent purchase order issued to this vendor for this material-plant combination. Used to track vendor activity and source list currency.',
    `last_qualification_date` DATE COMMENT 'The date when the vendor was last qualified or re-qualified for supplying this material. Used to track qualification currency and trigger re-qualification cycles.',
    `lead_time_days` STRING COMMENT 'The standard procurement lead time in days from this vendor for the material-plant combination. Used in MRP planning and delivery scheduling.',
    `minimum_order_quantity` DECIMAL(18,2) COMMENT 'The minimum order quantity that the vendor requires for this material. Enforces vendor-specific ordering constraints in procurement.',
    `mrp_relevant_flag` BOOLEAN COMMENT 'Indicates whether this source list entry is considered during MRP runs for automatic source determination and purchase requisition generation.',
    `next_qualification_due_date` DATE COMMENT 'The date by which the vendor must be re-qualified for this material. Supports proactive supplier management and compliance with AVL (Approved Vendor List) policies.',
    `order_quantity_uom` STRING COMMENT 'The unit of measure for the minimum order quantity and standard ordering unit for this material from this vendor.',
    `preferred_vendor_flag` BOOLEAN COMMENT 'Indicates whether this vendor is the preferred source for the material-plant combination when multiple approved sources exist. Used to guide procurement decisions.',
    `purchasing_organization` STRING COMMENT 'The organizational unit responsible for procurement activities for this source list entry. Defines procurement authority and scope.',
    `qualification_status` STRING COMMENT 'The current qualification status of the vendor for supplying this material. Reflects the outcome of supplier audits, quality assessments, and compliance reviews.. Valid values are `qualified|conditional|pending|suspended`',
    `record` STRING COMMENT 'The sequential record number within the source list for the material-plant combination. Used for ordering and identification within SAP MM.',
    `risk_rating` STRING COMMENT 'The supply risk rating for this vendor-material-plant combination. Reflects factors such as vendor financial stability, geopolitical risk, quality history, and supply chain disruption potential.. Valid values are `low|medium|high|critical`',
    `source_list_category` STRING COMMENT 'The procurement category or special procurement type that this source list entry supports. Distinguishes between regular purchasing, subcontracting, consignment, and pipeline scenarios.. Valid values are `regular|subcontracting|consignment|pipeline`',
    `valid_from_date` DATE COMMENT 'The start date from which this vendor is approved to supply the material to the plant. Part of the validity period for the source list entry.',
    `valid_to_date` DATE COMMENT 'The end date until which this vendor is approved to supply the material. Null or far-future date indicates open-ended approval.',
    `vendor_priority` STRING COMMENT 'The priority ranking of this vendor for the material-plant combination when multiple approved sources exist. Lower numbers indicate higher priority for automatic source determination.',
    `created_by` STRING COMMENT 'The user ID or name of the person who created this source list entry. Supports audit trail and accountability.',
    CONSTRAINT pk_source_list PRIMARY KEY(`source_list_id`)
) COMMENT 'Approved source list defining which vendors are authorized to supply specific raw materials or chemicals to specific plants during defined validity periods. Captures material, plant, vendor, purchasing organization, validity start and end dates, fixed source flag, MRP relevance, agreement reference (contract or scheduling agreement), and source list status. Enforces approved vendor list (AVL) compliance and drives automatic source determination in SAP MM.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`supply`.`inbound_delivery` (
    `inbound_delivery_id` BIGINT COMMENT 'Unique identifier for the inbound delivery record. Primary key for this entity.',
    `asn_id` BIGINT COMMENT 'Reference to the Advanced Shipping Notice that preceded this delivery. Links the physical delivery to the electronic notification sent by the vendor.',
    `bill_of_lading_id` BIGINT COMMENT 'Foreign key linking to logistics.bill_of_lading. Business justification: The BOL is the primary legal document for inbound chemical deliveries governing hazmat compliance, title transfer, and carrier liability. Linking inbound_delivery to bill_of_lading enables regulatory ',
    `carrier_id` BIGINT COMMENT 'Identifier of the transportation carrier responsible for moving the materials from vendor to plant. May be third-party logistics provider or vendor-managed transport.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Inbound delivery freight and handling costs in chemical manufacturing are posted to cost centers for logistics cost allocation. Required for transportation cost center reporting and freight accrual ma',
    `site_id` BIGINT COMMENT 'Foreign key linking to customer.site. Business justification: Inbound logistics must know which customer site receives the delivery; used in ETA and dock scheduling reports.',
    `freight_order_id` BIGINT COMMENT 'Foreign key linking to logistics.freight_order. Business justification: In chemical manufacturing, inbound deliveries are executed under freight orders that govern carrier contracts, hazmat compliance terms, and delivery windows. Linking inbound_delivery to freight_order ',
    `lot_id` BIGINT COMMENT 'Foreign key linking to inventory.lot. Business justification: Inbound deliveries in chemical manufacturing carry lot/batch data for hazmat pre-notification and quality pre-screening. Linking inbound_delivery to lot enables lot-level traceability from supplier sh',
    `manufacturing_order_id` BIGINT COMMENT 'Foreign key linking to production.manufacturing_order. Business justification: REQUIRED: Receiving reports tie each inbound delivery to the specific manufacturing order that consumes the delivered material.',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to rawmaterial.material_master. Business justification: Required for inbound delivery tracking per material to reconcile receipts, support inventory and regulatory compliance reports.',
    `production_schedule_id` BIGINT COMMENT 'Foreign key linking to planning.production_schedule. Business justification: Inbound deliveries of raw materials in chemical manufacturing are scheduled against specific production schedule windows to ensure material availability for planned production runs. Production schedul',
    `purchase_order_id` BIGINT COMMENT 'Reference to the purchase order that authorized this delivery. Links delivery to procurement transaction.',
    `vendor_id` BIGINT COMMENT 'Identifier of the chemical supplier or vendor shipping the materials. Links to vendor master data.',
    `vendor_site_id` BIGINT COMMENT 'Identifier of the specific vendor site or facility from which the materials are being shipped. Origin location for the delivery.',
    `actual_arrival_date` DATE COMMENT 'Actual date the delivery arrived at the destination plant gate or receiving dock. Used for on-time delivery performance measurement.',
    `actual_arrival_time` TIMESTAMP COMMENT 'Actual date and time the delivery arrived at the destination plant, including time zone. Captured by gate systems or receiving personnel.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this inbound delivery record was first created in the system. Audit trail for record creation.',
    `delivery_number` STRING COMMENT 'Business identifier for the inbound delivery, typically generated by Oracle Transportation Management or SAP EWM. Externally visible tracking number used across systems and by vendors.. Valid values are `^[A-Z0-9]{10,20}$`',
    `delivery_status` STRING COMMENT 'Current lifecycle status of the inbound delivery. Tracks progression from scheduling through completion or cancellation. [ENUM-REF-CANDIDATE: scheduled|in_transit|arrived|unloading|completed|cancelled|delayed|rejected — 8 candidates stripped; promote to reference product]',
    `destination_plant_code` STRING COMMENT 'Code identifying the receiving chemical manufacturing plant or facility. Corresponds to SAP plant master data.. Valid values are `^[A-Z0-9]{4,10}$`',
    `destination_storage_location` STRING COMMENT 'Specific storage location code within the destination plant where materials will be received. May reference tank farm, warehouse zone, or hazmat storage area.. Valid values are `^[A-Z0-9]{4,10}$`',
    `dot_hazmat_document_number` STRING COMMENT 'DOT-required shipping document number for hazardous materials transport. Must accompany hazmat shipments and be available for inspection.',
    `freight_cost` DECIMAL(18,2) COMMENT 'Transportation cost for this delivery in the specified currency. May be vendor-paid or buyer-paid depending on Incoterm.',
    `freight_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for freight cost (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `ghs_hazard_class` STRING COMMENT 'GHS classification of the primary hazard class for materials in this delivery (e.g., flammable liquids, corrosive substances, toxic materials).',
    `goods_receipt_date` DATE COMMENT 'Date when the goods receipt was posted in SAP, confirming materials have been received into inventory. May differ from actual arrival date.',
    `goods_receipt_number` STRING COMMENT 'SAP goods receipt document number created when materials are physically received and posted to inventory. Links delivery to inventory transaction.',
    `gross_weight_kg` DECIMAL(18,2) COMMENT 'Total weight of the delivery including materials, packaging, and transport container, measured in kilograms. Used for freight billing and load planning.',
    `hazmat_indicator` BOOLEAN COMMENT 'Flag indicating whether the delivery contains hazardous materials requiring special handling, documentation, and compliance with DOT and EPA regulations.',
    `incoterm` STRING COMMENT 'Incoterm defining the division of costs and risks between vendor and buyer for this delivery. Determines responsibility for freight, insurance, and customs. [ENUM-REF-CANDIDATE: EXW|FCA|CPT|CIP|DAP|DPU|DDP|FAS|FOB|CFR|CIF — 11 candidates stripped; promote to reference product]',
    `inspection_lot_number` STRING COMMENT 'SAP QM inspection lot number created for quality testing of received materials. Links delivery to quality control process.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this inbound delivery record was last updated. Audit trail for tracking changes to delivery status and attributes.',
    `net_weight_kg` DECIMAL(18,2) COMMENT 'Weight of the actual chemical materials excluding packaging and container, measured in kilograms. Used for inventory valuation and goods receipt.',
    `notes` STRING COMMENT 'Free-text notes capturing special instructions, exceptions, incidents, or observations related to this delivery. Used for communication between logistics, receiving, and quality teams.',
    `quality_inspection_required_flag` BOOLEAN COMMENT 'Indicates whether incoming materials require quality inspection before release to unrestricted inventory. Triggers QM inspection lot creation.',
    `rejection_reason` STRING COMMENT 'Reason for rejecting the delivery if materials do not meet quality standards, documentation is incomplete, or delivery conditions are violated. Free-text field for detailed explanation.',
    `required_temperature_max_c` DECIMAL(18,2) COMMENT 'Maximum temperature in Celsius that must not be exceeded during transport to prevent material degradation or safety hazards.',
    `required_temperature_min_c` DECIMAL(18,2) COMMENT 'Minimum temperature in Celsius that must be maintained during transport to preserve material integrity. Applies to temperature-sensitive chemicals.',
    `scheduled_arrival_date` DATE COMMENT 'Planned date for the delivery to arrive at the destination plant. Used for production planning and resource allocation.',
    `scheduled_arrival_time` TIMESTAMP COMMENT 'Planned date and time for the delivery to arrive at the destination plant, including time zone. Precise timing critical for dock scheduling and unloading crew coordination.',
    `seal_intact_flag` BOOLEAN COMMENT 'Indicates whether the security seal was found intact upon arrival at the destination. Broken seals trigger investigation and potential rejection.',
    `seal_number` STRING COMMENT 'Security seal number applied to the transport container or tanker. Used to verify container integrity and detect tampering during transit.',
    `temperature_controlled_flag` BOOLEAN COMMENT 'Indicates whether the delivery requires temperature-controlled transport to maintain material stability and quality. Critical for temperature-sensitive chemicals.',
    `transport_equipment_number` STRING COMMENT 'Identifier of the specific transport equipment used (tanker truck number, rail car number, container number). Used for tracking and safety audits.',
    `transport_mode` STRING COMMENT 'Method of transportation used for the delivery. Critical for chemical logistics planning and hazmat compliance. [ENUM-REF-CANDIDATE: road_tanker|rail_car|sea_container|pipeline|bulk_truck|iso_tank|flexitank — 7 candidates stripped; promote to reference product]',
    `un_number` STRING COMMENT 'Four-digit UN identification number for hazardous materials being transported. Required for DOT compliance and emergency response.. Valid values are `^UN[0-9]{4}$`',
    `volume_liters` DECIMAL(18,2) COMMENT 'Total volume of liquid or bulk materials in the delivery, measured in liters. Critical for tank capacity planning and material balance.',
    CONSTRAINT pk_inbound_delivery PRIMARY KEY(`inbound_delivery_id`)
) COMMENT 'Inbound logistics delivery record tracking the physical movement of raw materials and chemicals from vendor to plant, coordinated with Oracle Transportation Management. Captures delivery number, vendor, carrier, origin location, destination plant and storage location, scheduled arrival date/time, actual arrival date/time, transport mode (road tanker, rail, sea container, pipeline), hazmat transport document number (DOT), temperature-controlled flag, seal number, and delivery status. Links ASN to goods receipt.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`supply`.`invoice_verification` (
    `invoice_verification_id` BIGINT COMMENT 'Unique identifier for the invoice verification record. Primary key for three-way match verification in SAP MM MIRO.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Invoice posting must allocate expense to the appropriate cost center for reporting and variance analysis.',
    `fiscal_period_id` BIGINT COMMENT 'Foreign key linking to finance.fiscal_period. Business justification: AP invoice posting must reference an open fiscal period for period-end close cutoff. Chemical manufacturers run strict AP cutoffs; this FK enables period-end accrual reporting and prevents posting to ',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: GL account is required to post invoice amounts to the correct ledger account per accounting standards.',
    `goods_receipt_id` BIGINT COMMENT 'Foreign key linking to supply.goods_receipt. Business justification: The three-way match explicitly reconciles vendor invoices against goods receipts. invoice_verification stores goods_receipt_number (STRING) and goods_receipt_date but has no FK to goods_receipt. Addin',
    `internal_order_id` BIGINT COMMENT 'Foreign key linking to finance.internal_order. Business justification: Chemical manufacturing invoices for capital projects or campaign-specific procurement are settled against internal orders. Budget availability and project cost tracking require this direct AP-to-inter',
    `legal_entity_id` BIGINT COMMENT 'Foreign key linking to finance.legal_entity. Business justification: AP invoices are posted within a legal entity for statutory financial reporting and tax compliance. company_code is a denormalized legal entity reference; proper FK supports intercompany AP reconciliat',
    `payment_term_id` BIGINT COMMENT 'Foreign key linking to billing.payment_term. Business justification: AP payment scheduling: invoice_verification has a denormalized payment_terms text field. Linking to billing.payment_term normalizes this, enabling consistent payment due date calculation, early paymen',
    `po_line_id` BIGINT COMMENT 'Foreign key linking to supply.po_line. Business justification: Invoice verification in chemical manufacturing operates at the line level — each invoice line is matched against a specific PO line for quantity and price verification. The table currently stores po_l',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: AP invoice posting in chemical manufacturing must allocate raw material costs to profit centers for segment P&L reporting. Standard SAP MM-FI integration requires profit center assignment on every ver',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to supply.purchase_order. Business justification: Three-way match (invoice/PO/GR) is the core of invoice_verification. The table currently stores po_number as a STRING but has no FK to purchase_order. Adding purchase_order_id normalizes this critical',
    `usage_decision_id` BIGINT COMMENT 'Foreign key linking to quality.usage_decision. Business justification: Quality-gated payment is a named process in chemical manufacturing: invoice payment is released only after the usage decision confirms lot acceptance. Direct FK enables automated payment block/release',
    `vendor_id` BIGINT COMMENT 'Unique identifier for the chemical supplier who issued the invoice. Links to vendor master data.',
    `baseline_date` DATE COMMENT 'Baseline date for payment terms calculation in SAP. Typically the invoice date or goods receipt date depending on payment terms configuration.',
    `blocking_reason` STRING COMMENT 'Reason why the invoice verification is blocked from payment. Common blocks include price tolerance exceeded, quantity short, or quality hold pending Certificate of Analysis (COA) review. [ENUM-REF-CANDIDATE: price_tolerance_exceeded|quantity_short|quality_hold_pending_coa|duplicate_invoice|missing_gr|missing_po|tax_code_mismatch|vendor_blocked|manual_review_required|unblocked — 10 candidates stripped; promote to reference product]',
    `coa_received_flag` BOOLEAN COMMENT 'Indicates whether the Certificate of Analysis has been received from the vendor. Critical for chemical procurement where COA review is required before payment release.',
    `coa_review_status` STRING COMMENT 'Status of the Certificate of Analysis review by Quality Control. Invoices may be blocked pending COA approval for chemical raw materials.. Valid values are `not_required|pending|approved|rejected|on_hold`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the invoice verification record was first created in the system. Audit trail for record lifecycle.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the invoice amount (e.g., USD, EUR, CNY). Critical for multi-currency chemical procurement.. Valid values are `^[A-Z]{3}$`',
    `document_date` DATE COMMENT 'Document date of the invoice verification record. Typically matches the vendor invoice date but may differ for backdated postings.',
    `fiscal_year` STRING COMMENT 'Fiscal year in which the invoice verification document was posted.',
    `freight_charge` DECIMAL(18,2) COMMENT 'Freight or transportation charge included in the vendor invoice. Common surcharge in chemical procurement for bulk material shipments.',
    `hazmat_handling_fee` DECIMAL(18,2) COMMENT 'Special handling fee for hazardous chemical materials. Charged by vendors for DOT-regulated hazmat transportation and storage compliance.',
    `index_escalator_amount` DECIMAL(18,2) COMMENT 'Price adjustment based on commodity index escalation clauses common in chemical supply contracts. Reflects market-driven price volatility.',
    `invoiced_amount` DECIMAL(18,2) COMMENT 'Total amount invoiced by the vendor before tax. Base amount for three-way match price variance calculation.',
    `invoiced_quantity` DECIMAL(18,2) COMMENT 'Quantity of chemical material invoiced by the vendor. Compared against PO quantity and GR quantity for variance detection.',
    `material_number` STRING COMMENT 'SAP material master number for the chemical raw material being invoiced. Enables material-level spend analysis.',
    `payment_block_indicator` BOOLEAN COMMENT 'Flag indicating whether the invoice is blocked for payment. True if blocked, False if released for payment processing.',
    `payment_due_date` DATE COMMENT 'Calculated date by which payment is due to the vendor based on invoice date and payment terms. Critical for cash flow management and vendor relationship.',
    `payment_release_by` STRING COMMENT 'User ID or name of the person who released the invoice for payment. Audit trail for payment authorization.',
    `payment_release_date` DATE COMMENT 'Date on which the invoice was released for payment after successful three-way match verification and block resolution.',
    `plant_code` STRING COMMENT 'Manufacturing plant or facility code where the chemical materials were received. Links to plant master data.',
    `posting_date` DATE COMMENT 'Date on which the invoice verification document was posted to the financial ledger in SAP FI.',
    `posting_status` STRING COMMENT 'Current posting status of the invoice verification document in SAP FI. Indicates whether the document has been financially posted to the general ledger.. Valid values are `draft|posted|reversed|parked|cancelled`',
    `price_variance` DECIMAL(18,2) COMMENT 'Difference between invoiced price and PO price. Common in chemical procurement due to index-linked pricing, freight surcharges, and hazmat handling fees.',
    `quantity_variance` DECIMAL(18,2) COMMENT 'Difference between invoiced quantity and goods receipt quantity. Typical with bulk liquid chemical deliveries measured by weight at receipt.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Total tax amount on the vendor invoice (VAT, GST, sales tax). Calculated based on tax jurisdiction and material tax classification.',
    `tax_code` STRING COMMENT 'SAP tax code determining the tax rate and tax account assignment. Varies by jurisdiction, material type, and vendor location.',
    `total_invoice_amount` DECIMAL(18,2) COMMENT 'Total invoice amount including tax. Gross amount payable to the vendor upon verification approval.',
    `unit_of_measure` STRING COMMENT 'Unit of measure for the invoiced quantity (e.g., KG, L, MT, GAL). Critical for bulk chemical deliveries measured by weight or volume.',
    `verification_document_number` STRING COMMENT 'SAP document number assigned to the invoice verification transaction. Unique business identifier for the three-way match record.',
    `verification_status` STRING COMMENT 'Overall status of the three-way match verification process. Tracks the invoice through verification workflow from receipt to approval.. Valid values are `pending|verified|rejected|blocked|approved|in_review`',
    `verified_by` STRING COMMENT 'User ID or name of the person who performed the invoice verification. Audit trail for accountability and compliance.',
    `verified_timestamp` TIMESTAMP COMMENT 'Date and time when the invoice verification was completed. Tracks verification cycle time for process efficiency analysis.',
    CONSTRAINT pk_invoice_verification PRIMARY KEY(`invoice_verification_id`)
) COMMENT 'Three-way match verification records reconciling vendor invoices against purchase orders and goods receipts for chemical raw material purchases. Captures verification document number, vendor invoice number and date, PO and GR references, invoiced amount, tax amount, currency, price variance (common with index-linked chemical pricing), quantity variance (typical with bulk liquid deliveries measured by weight), blocking reasons (price tolerance exceeded, quantity short, quality hold pending COA review), payment release status, and posting status. Critical for chemical procurement where pricing often includes freight surcharges, hazmat handling fees, and index-based escalators. Integrates with SAP MM MIRO and FI accounts payable.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`supply`.`material_info_record` (
    `material_info_record_id` BIGINT COMMENT 'Unique identifier for the material info record. Primary key for this purchasing master data entity.',
    `contract_id` BIGINT COMMENT 'Foreign key linking to supply.contract. Business justification: Material info records (purchasing info records in SAP MM) establish approved sourcing parameters and can reference a specific supply contract for pricing and terms. The material_info_record table stor',
    `inspection_plan_id` BIGINT COMMENT 'Foreign key linking to quality.inspection_plan. Business justification: The purchasing info record in chemical manufacturing specifies which inspection plan applies when ordering a material from a specific vendor. This vendor-material-inspection plan configuration is stan',
    `material_master_id` BIGINT COMMENT 'Reference to the material being sourced. Links to the material master data defining the chemical product, raw material, or finished good covered by this purchasing agreement.',
    `production_plant_id` BIGINT COMMENT 'Reference to the manufacturing plant or facility where this material will be delivered. Defines the destination location for this sourcing arrangement.',
    `safety_data_sheet_id` BIGINT COMMENT 'Foreign key linking to ehs.safety_data_sheet. Business justification: Material info records track safety_data_sheet_required flag for vendor-material combinations. Linking to the actual SDS record enables automated compliance verification during PO creation and goods re',
    `vendor_id` BIGINT COMMENT 'Reference to the approved supplier for this material. Links to vendor master data defining the chemical supplier authorized to provide this material.',
    `acknowledgement_required` BOOLEAN COMMENT 'Indicates whether the vendor must send a formal acknowledgement confirming receipt and acceptance of purchase orders. When true, procurement tracks acknowledgement status.',
    `agreement_item_number` STRING COMMENT 'Specific line item within the referenced contract that covers this material. Five-digit numeric identifier linking to the contract line item.. Valid values are `^[0-9]{5}$`',
    `blocked_source` BOOLEAN COMMENT 'Indicates whether this source is temporarily blocked from procurement. When true, no new purchase orders can be created using this material-vendor-plant combination.',
    `certificate_of_analysis_required` BOOLEAN COMMENT 'Indicates whether the vendor must provide a Certificate of Analysis with each shipment. Critical for chemical materials to verify composition, purity, and compliance with specifications.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this info record was first created in the system. Provides audit trail for sourcing relationship establishment.',
    `fixed_source` BOOLEAN COMMENT 'Indicates whether this is the mandatory source for the material. When true, Material Requirements Planning (MRP) and purchase requisitions must use this vendor exclusively.',
    `goods_receipt_required` BOOLEAN COMMENT 'Indicates whether a formal goods receipt transaction must be posted in SAP MM before invoice processing. Standard requirement for physical materials.',
    `incoterms_code` STRING COMMENT 'International Commercial Terms defining the division of costs and risks between buyer and seller. Standard three-letter code (e.g., DDP, FOB, CIF) governing shipping responsibilities. [ENUM-REF-CANDIDATE: EXW|FCA|CPT|CIP|DAP|DPU|DDP|FAS|FOB|CFR|CIF — 11 candidates stripped; promote to reference product]',
    `incoterms_location` STRING COMMENT 'Specific location or port referenced in the Incoterms agreement. Defines the point where risk and cost transfer occurs between vendor and buyer.',
    `info_record_category` STRING COMMENT 'Classification of the purchasing info record type. Defines the procurement model: standard purchase, subcontracting arrangement, consignment stock, or pipeline supply for bulk chemicals.. Valid values are `standard|subcontracting|consignment|pipeline`',
    `info_record_number` STRING COMMENT 'Business identifier for the purchasing info record. Unique alphanumeric code assigned by SAP MM system (ME11/ME12) to identify this material-vendor-plant sourcing relationship.. Valid values are `^[A-Z0-9]{10}$`',
    `info_record_status` STRING COMMENT 'Current lifecycle status of the purchasing info record. Determines whether this source can be used for new purchase orders and MRP planning.. Valid values are `active|inactive|pending_approval|expired|blocked`',
    `invoice_receipt_required` BOOLEAN COMMENT 'Indicates whether invoice verification is required for purchases from this source. When true, three-way match (PO, goods receipt, invoice) is enforced.',
    `last_modified_by` STRING COMMENT 'User ID of the person who most recently updated this info record. Used for change tracking and accountability.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent change to this info record. Tracks when pricing, terms, or other sourcing parameters were last updated.',
    `last_purchase_order_date` DATE COMMENT 'Date of the most recent purchase order created for this material-vendor-plant combination. Used to track sourcing activity and identify inactive sources.',
    `last_purchase_order_price` DECIMAL(18,2) COMMENT 'Most recent actual price paid for this material from this vendor. Used for price variance analysis and to track pricing trends over time.',
    `manufacturer_part_number` STRING COMMENT 'Original manufacturers part number when the vendor is a distributor. Ensures correct material identification and traceability to the chemical producer.',
    `maximum_order_quantity` DECIMAL(18,2) COMMENT 'Largest quantity that can be ordered in a single purchase order from this vendor. May be limited by vendor production capacity, storage constraints, or hazmat shipping regulations.',
    `minimum_order_quantity` DECIMAL(18,2) COMMENT 'Smallest quantity that can be ordered from this vendor for this material. Enforced during purchase order creation to ensure compliance with vendor minimum order requirements.',
    `mrp_relevant` BOOLEAN COMMENT 'Indicates whether this source is considered during MRP runs for automatic source determination. When true, MRP will propose this vendor when generating planned orders or purchase requisitions.',
    `net_price_indicator` BOOLEAN COMMENT 'Indicates whether the standard price is a net price (no further discounts apply) or a gross price (subject to additional discounts or surcharges).',
    `order_unit_of_measure` STRING COMMENT 'Standard unit of measure for ordering this material from this vendor. Examples: KG (kilograms), L (liters), MT (metric tons), GAL (gallons). Must align with vendor packaging and shipping capabilities.. Valid values are `^[A-Z]{2,3}$`',
    `over_delivery_tolerance_pct` DECIMAL(18,2) COMMENT 'Maximum percentage by which the vendor may exceed the ordered quantity without requiring approval. For example, 5.00 allows delivery of up to 105% of ordered quantity.',
    `planned_delivery_time_days` STRING COMMENT 'Expected lead time in calendar days from purchase order placement to goods receipt at the plant. Used by MRP for scheduling and by procurement for delivery date calculation.',
    `price_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the standard price. Defines the currency in which pricing is negotiated and invoiced.. Valid values are `^[A-Z]{3}$`',
    `price_unit` STRING COMMENT 'Quantity to which the standard price applies. For example, if price_unit is 100 and standard_price is 50.00, the price is 50.00 per 100 units.',
    `purchasing_group` STRING COMMENT 'Buyer or procurement team responsible for this material-vendor combination. Three-character code identifying the specific purchasing group handling this sourcing relationship.. Valid values are `^[A-Z0-9]{3}$`',
    `purchasing_organization` STRING COMMENT 'Organizational unit responsible for procurement activities. Four-character code identifying the purchasing group that negotiated and manages this sourcing relationship.. Valid values are `^[A-Z0-9]{4}$`',
    `quality_inspection_required` BOOLEAN COMMENT 'Indicates whether incoming materials from this vendor must undergo quality control inspection before release to production. When true, goods are placed in quality inspection stock upon receipt.',
    `reach_compliance_required` BOOLEAN COMMENT 'Indicates whether the vendor must provide REACH compliance documentation for materials supplied to European plants. Ensures regulatory compliance for chemical substance registration.',
    `safety_data_sheet_required` BOOLEAN COMMENT 'Indicates whether the vendor must provide a current Safety Data Sheet (SDS) with shipments. Mandatory for hazardous chemicals to ensure safe handling and compliance with OSHA and GHS requirements.',
    `source_list_record` BOOLEAN COMMENT 'Indicates whether this info record is part of the approved vendor list (AVL). When true, this vendor is authorized to supply this material to this plant during the validity period.',
    `standard_order_quantity` DECIMAL(18,2) COMMENT 'Recommended or typical order quantity for this material-vendor combination. Used as default value in purchase requisitions and for optimizing order economics.',
    `standard_price` DECIMAL(18,2) COMMENT 'Default unit price for this material from this vendor. Used as the baseline price for purchase order creation and cost estimation. Expressed in the currency specified in price_currency_code.',
    `supplier_material_number` STRING COMMENT 'Vendors internal part number or catalog code for this material. Used for cross-referencing between buyer and supplier systems and for accurate order communication.',
    `tax_code` STRING COMMENT 'Tax classification code determining applicable sales tax, VAT, or other tax treatment for purchases from this vendor. Two-character code linked to tax calculation rules.. Valid values are `^[A-Z0-9]{2}$`',
    `under_delivery_tolerance_pct` DECIMAL(18,2) COMMENT 'Maximum percentage by which the vendor may deliver less than the ordered quantity without triggering a shortage alert. For example, 2.00 allows delivery of as low as 98% of ordered quantity.',
    `unlimited_over_delivery` BOOLEAN COMMENT 'Indicates whether the vendor is allowed to deliver any quantity above the purchase order amount without restriction. Typically used for bulk chemicals where exact quantities are difficult to control.',
    `validity_end_date` DATE COMMENT 'Date after which this info record expires and can no longer be used for new purchase orders. Defines the end of the approved sourcing period. Null indicates indefinite validity.',
    `validity_start_date` DATE COMMENT 'Date from which this info record becomes active and can be used for purchase order creation. Defines the beginning of the approved sourcing period.',
    `created_by` STRING COMMENT 'User ID of the procurement specialist who created this info record in SAP MM. Used for audit trail and accountability.',
    CONSTRAINT pk_material_info_record PRIMARY KEY(`material_info_record_id`)
) COMMENT 'Purchasing master data establishing approved sourcing parameters and default procurement conditions for specific material-vendor-plant combinations. Captures info record number, material, vendor, plant, purchasing organization, standard price, planned delivery time, MOQ/max order quantity, delivery tolerances, last PO price, and source status. Also serves as the approved source list (AVL): defines which vendors are authorized to supply specific materials to specific plants during defined validity periods, with fixed source flags, MRP relevance indicators, and agreement references. Single source of truth for which vendors can supply which materials to which plants under what conditions. Drives automatic source determination and default PO values. Integrates with SAP MM ME11/ME12 and source list functionality.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_site` ADD CONSTRAINT `fk_supply_vendor_site_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `chemical_mfg_ecm`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `chemical_mfg_ecm`.`supply`.`purchase_order` ADD CONSTRAINT `fk_supply_purchase_order_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `chemical_mfg_ecm`.`supply`.`contract`(`contract_id`);
ALTER TABLE `chemical_mfg_ecm`.`supply`.`purchase_order` ADD CONSTRAINT `fk_supply_purchase_order_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `chemical_mfg_ecm`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `chemical_mfg_ecm`.`supply`.`po_line` ADD CONSTRAINT `fk_supply_po_line_contract_price_id` FOREIGN KEY (`contract_price_id`) REFERENCES `chemical_mfg_ecm`.`supply`.`contract_price`(`contract_price_id`);
ALTER TABLE `chemical_mfg_ecm`.`supply`.`po_line` ADD CONSTRAINT `fk_supply_po_line_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `chemical_mfg_ecm`.`supply`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `chemical_mfg_ecm`.`supply`.`goods_receipt` ADD CONSTRAINT `fk_supply_goods_receipt_asn_id` FOREIGN KEY (`asn_id`) REFERENCES `chemical_mfg_ecm`.`supply`.`asn`(`asn_id`);
ALTER TABLE `chemical_mfg_ecm`.`supply`.`goods_receipt` ADD CONSTRAINT `fk_supply_goods_receipt_inbound_delivery_id` FOREIGN KEY (`inbound_delivery_id`) REFERENCES `chemical_mfg_ecm`.`supply`.`inbound_delivery`(`inbound_delivery_id`);
ALTER TABLE `chemical_mfg_ecm`.`supply`.`goods_receipt` ADD CONSTRAINT `fk_supply_goods_receipt_po_line_id` FOREIGN KEY (`po_line_id`) REFERENCES `chemical_mfg_ecm`.`supply`.`po_line`(`po_line_id`);
ALTER TABLE `chemical_mfg_ecm`.`supply`.`goods_receipt` ADD CONSTRAINT `fk_supply_goods_receipt_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `chemical_mfg_ecm`.`supply`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `chemical_mfg_ecm`.`supply`.`goods_receipt` ADD CONSTRAINT `fk_supply_goods_receipt_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `chemical_mfg_ecm`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `chemical_mfg_ecm`.`supply`.`asn` ADD CONSTRAINT `fk_supply_asn_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `chemical_mfg_ecm`.`supply`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `chemical_mfg_ecm`.`supply`.`asn` ADD CONSTRAINT `fk_supply_asn_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `chemical_mfg_ecm`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `chemical_mfg_ecm`.`supply`.`asn` ADD CONSTRAINT `fk_supply_asn_vendor_site_id` FOREIGN KEY (`vendor_site_id`) REFERENCES `chemical_mfg_ecm`.`supply`.`vendor_site`(`vendor_site_id`);
ALTER TABLE `chemical_mfg_ecm`.`supply`.`contract` ADD CONSTRAINT `fk_supply_contract_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `chemical_mfg_ecm`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `chemical_mfg_ecm`.`supply`.`contract` ADD CONSTRAINT `fk_supply_contract_vendor_site_id` FOREIGN KEY (`vendor_site_id`) REFERENCES `chemical_mfg_ecm`.`supply`.`vendor_site`(`vendor_site_id`);
ALTER TABLE `chemical_mfg_ecm`.`supply`.`contract_price` ADD CONSTRAINT `fk_supply_contract_price_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `chemical_mfg_ecm`.`supply`.`contract`(`contract_id`);
ALTER TABLE `chemical_mfg_ecm`.`supply`.`contract_price` ADD CONSTRAINT `fk_supply_contract_price_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `chemical_mfg_ecm`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_qualification` ADD CONSTRAINT `fk_supply_vendor_qualification_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `chemical_mfg_ecm`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_audit` ADD CONSTRAINT `fk_supply_vendor_audit_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `chemical_mfg_ecm`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_audit` ADD CONSTRAINT `fk_supply_vendor_audit_vendor_qualification_id` FOREIGN KEY (`vendor_qualification_id`) REFERENCES `chemical_mfg_ecm`.`supply`.`vendor_qualification`(`vendor_qualification_id`);
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_audit` ADD CONSTRAINT `fk_supply_vendor_audit_vendor_site_id` FOREIGN KEY (`vendor_site_id`) REFERENCES `chemical_mfg_ecm`.`supply`.`vendor_site`(`vendor_site_id`);
ALTER TABLE `chemical_mfg_ecm`.`supply`.`purchase_requisition` ADD CONSTRAINT `fk_supply_purchase_requisition_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `chemical_mfg_ecm`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `chemical_mfg_ecm`.`supply`.`purchase_requisition` ADD CONSTRAINT `fk_supply_purchase_requisition_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `chemical_mfg_ecm`.`supply`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `chemical_mfg_ecm`.`supply`.`source_list` ADD CONSTRAINT `fk_supply_source_list_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `chemical_mfg_ecm`.`supply`.`contract`(`contract_id`);
ALTER TABLE `chemical_mfg_ecm`.`supply`.`source_list` ADD CONSTRAINT `fk_supply_source_list_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `chemical_mfg_ecm`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `chemical_mfg_ecm`.`supply`.`inbound_delivery` ADD CONSTRAINT `fk_supply_inbound_delivery_asn_id` FOREIGN KEY (`asn_id`) REFERENCES `chemical_mfg_ecm`.`supply`.`asn`(`asn_id`);
ALTER TABLE `chemical_mfg_ecm`.`supply`.`inbound_delivery` ADD CONSTRAINT `fk_supply_inbound_delivery_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `chemical_mfg_ecm`.`supply`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `chemical_mfg_ecm`.`supply`.`inbound_delivery` ADD CONSTRAINT `fk_supply_inbound_delivery_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `chemical_mfg_ecm`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `chemical_mfg_ecm`.`supply`.`inbound_delivery` ADD CONSTRAINT `fk_supply_inbound_delivery_vendor_site_id` FOREIGN KEY (`vendor_site_id`) REFERENCES `chemical_mfg_ecm`.`supply`.`vendor_site`(`vendor_site_id`);
ALTER TABLE `chemical_mfg_ecm`.`supply`.`invoice_verification` ADD CONSTRAINT `fk_supply_invoice_verification_goods_receipt_id` FOREIGN KEY (`goods_receipt_id`) REFERENCES `chemical_mfg_ecm`.`supply`.`goods_receipt`(`goods_receipt_id`);
ALTER TABLE `chemical_mfg_ecm`.`supply`.`invoice_verification` ADD CONSTRAINT `fk_supply_invoice_verification_po_line_id` FOREIGN KEY (`po_line_id`) REFERENCES `chemical_mfg_ecm`.`supply`.`po_line`(`po_line_id`);
ALTER TABLE `chemical_mfg_ecm`.`supply`.`invoice_verification` ADD CONSTRAINT `fk_supply_invoice_verification_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `chemical_mfg_ecm`.`supply`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `chemical_mfg_ecm`.`supply`.`invoice_verification` ADD CONSTRAINT `fk_supply_invoice_verification_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `chemical_mfg_ecm`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `chemical_mfg_ecm`.`supply`.`material_info_record` ADD CONSTRAINT `fk_supply_material_info_record_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `chemical_mfg_ecm`.`supply`.`contract`(`contract_id`);
ALTER TABLE `chemical_mfg_ecm`.`supply`.`material_info_record` ADD CONSTRAINT `fk_supply_material_info_record_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `chemical_mfg_ecm`.`supply`.`vendor`(`vendor_id`);

-- ========= TAGS =========
ALTER SCHEMA `chemical_mfg_ecm`.`supply` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `chemical_mfg_ecm`.`supply` SET TAGS ('dbx_domain' = 'supply');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor` SET TAGS ('dbx_subdomain' = 'supplier_management');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Identifier');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor` ALTER COLUMN `billing_party_id` SET TAGS ('dbx_business_glossary_term' = 'Party Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor` ALTER COLUMN `approved_date` SET TAGS ('dbx_business_glossary_term' = 'Vendor Approval Date');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor` ALTER COLUMN `classification` SET TAGS ('dbx_business_glossary_term' = 'Vendor Classification');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor` ALTER COLUMN `classification` SET TAGS ('dbx_value_regex' = 'raw_material_supplier|chemical_manufacturer|distributor|toll_processor|packaging_supplier|logistics_provider');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor` ALTER COLUMN `contract_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Expiration Date');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor` ALTER COLUMN `duns_number` SET TAGS ('dbx_business_glossary_term' = 'DUNS (Data Universal Numbering System) Number');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor` ALTER COLUMN `duns_number` SET TAGS ('dbx_value_regex' = '^[0-9]{9}$');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor` ALTER COLUMN `hazmat_handling_capable` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Materials (HAZMAT) Handling Capability');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor` ALTER COLUMN `headquarters_address_line1` SET TAGS ('dbx_business_glossary_term' = 'Headquarters Address Line 1');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor` ALTER COLUMN `headquarters_address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor` ALTER COLUMN `headquarters_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor` ALTER COLUMN `headquarters_address_line2` SET TAGS ('dbx_business_glossary_term' = 'Headquarters Address Line 2');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor` ALTER COLUMN `headquarters_address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor` ALTER COLUMN `headquarters_address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor` ALTER COLUMN `headquarters_city` SET TAGS ('dbx_business_glossary_term' = 'Headquarters City');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor` ALTER COLUMN `headquarters_city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor` ALTER COLUMN `headquarters_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor` ALTER COLUMN `headquarters_country_code` SET TAGS ('dbx_business_glossary_term' = 'Headquarters Country Code');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor` ALTER COLUMN `headquarters_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor` ALTER COLUMN `headquarters_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Headquarters Postal Code');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor` ALTER COLUMN `headquarters_postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor` ALTER COLUMN `headquarters_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor` ALTER COLUMN `headquarters_state_province` SET TAGS ('dbx_business_glossary_term' = 'Headquarters State or Province');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor` ALTER COLUMN `headquarters_state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor` ALTER COLUMN `headquarters_state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor` ALTER COLUMN `incoterms` SET TAGS ('dbx_business_glossary_term' = 'Incoterms (International Commercial Terms)');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor` ALTER COLUMN `iso_14001_certified` SET TAGS ('dbx_business_glossary_term' = 'ISO 14001 Environmental Management Certification');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor` ALTER COLUMN `iso_9001_certified` SET TAGS ('dbx_business_glossary_term' = 'ISO 9001 Quality Management Certification');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor` ALTER COLUMN `last_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Last Audit Date');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor` ALTER COLUMN `minority_owned` SET TAGS ('dbx_business_glossary_term' = 'Minority-Owned Business Enterprise');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor` ALTER COLUMN `next_audit_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Audit Due Date');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Vendor Notes');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor` ALTER COLUMN `onboarding_status` SET TAGS ('dbx_business_glossary_term' = 'Vendor Onboarding Status');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor` ALTER COLUMN `onboarding_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|documentation_pending|audit_scheduled|approved|rejected');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor` ALTER COLUMN `performance_score` SET TAGS ('dbx_business_glossary_term' = 'Vendor Performance Score');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Email Address');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Name');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Phone Number');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor` ALTER COLUMN `reach_compliant` SET TAGS ('dbx_business_glossary_term' = 'REACH (Registration Evaluation Authorization and Restriction of Chemicals) Compliance Flag');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor` ALTER COLUMN `responsible_care_certified` SET TAGS ('dbx_business_glossary_term' = 'Responsible Care Certification Status');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor` ALTER COLUMN `risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Vendor Risk Rating');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor` ALTER COLUMN `risk_rating` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor` ALTER COLUMN `sap_vendor_number` SET TAGS ('dbx_business_glossary_term' = 'SAP Vendor Number');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor` ALTER COLUMN `small_business` SET TAGS ('dbx_business_glossary_term' = 'Small Business Enterprise');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor` ALTER COLUMN `tax_number` SET TAGS ('dbx_business_glossary_term' = 'Tax Identification Number');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor` ALTER COLUMN `tax_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor` ALTER COLUMN `vendor_code` SET TAGS ('dbx_business_glossary_term' = 'Vendor Code');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor` ALTER COLUMN `vendor_name` SET TAGS ('dbx_business_glossary_term' = 'Vendor Legal Name');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor` ALTER COLUMN `vendor_status` SET TAGS ('dbx_business_glossary_term' = 'Vendor Lifecycle Status');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor` ALTER COLUMN `vendor_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|pending_approval|blocked|under_review');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor` ALTER COLUMN `vendor_tier` SET TAGS ('dbx_business_glossary_term' = 'Vendor Tier Status');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor` ALTER COLUMN `vendor_tier` SET TAGS ('dbx_value_regex' = 'strategic|preferred|approved|conditional|probationary|inactive');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor` ALTER COLUMN `website_url` SET TAGS ('dbx_business_glossary_term' = 'Vendor Website URL');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor` ALTER COLUMN `woman_owned` SET TAGS ('dbx_business_glossary_term' = 'Woman-Owned Business Enterprise');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_site` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_site` SET TAGS ('dbx_subdomain' = 'supplier_management');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_site` ALTER COLUMN `vendor_site_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Site Identifier (ID)');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_site` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Identifier (ID)');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_site` ALTER COLUMN `active_from_date` SET TAGS ('dbx_business_glossary_term' = 'Active From Date');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_site` ALTER COLUMN `active_to_date` SET TAGS ('dbx_business_glossary_term' = 'Active To Date');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_site` ALTER COLUMN `address_line_1` SET TAGS ('dbx_business_glossary_term' = 'Address Line 1');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_site` ALTER COLUMN `address_line_1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_site` ALTER COLUMN `address_line_1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_site` ALTER COLUMN `address_line_2` SET TAGS ('dbx_business_glossary_term' = 'Address Line 2');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_site` ALTER COLUMN `address_line_2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_site` ALTER COLUMN `address_line_2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_site` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_site` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_site` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_site` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_site` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_site` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_site` ALTER COLUMN `dock_hours` SET TAGS ('dbx_business_glossary_term' = 'Dock Hours');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_site` ALTER COLUMN `geographic_region` SET TAGS ('dbx_business_glossary_term' = 'Geographic Region');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_site` ALTER COLUMN `geographic_region` SET TAGS ('dbx_value_regex' = 'north_america|south_america|europe|asia_pacific|middle_east|africa');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_site` ALTER COLUMN `hazmat_handling_capable` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Materials (HAZMAT) Handling Capable');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_site` ALTER COLUMN `incoterm` SET TAGS ('dbx_business_glossary_term' = 'International Commercial Terms (Incoterm)');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_site` ALTER COLUMN `iso_14001_certificate_number` SET TAGS ('dbx_business_glossary_term' = 'ISO 14001 Certificate Number');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_site` ALTER COLUMN `iso_14001_certified` SET TAGS ('dbx_business_glossary_term' = 'ISO 14001 Certified');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_site` ALTER COLUMN `iso_14001_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'ISO 14001 Expiration Date');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_site` ALTER COLUMN `iso_9001_certificate_number` SET TAGS ('dbx_business_glossary_term' = 'ISO 9001 Certificate Number');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_site` ALTER COLUMN `iso_9001_certified` SET TAGS ('dbx_business_glossary_term' = 'ISO 9001 Certified');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_site` ALTER COLUMN `iso_9001_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'ISO 9001 Expiration Date');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_site` ALTER COLUMN `last_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Last Audit Date');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_site` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_site` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_site` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_site` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_site` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time in Days');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_site` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_site` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_site` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_site` ALTER COLUMN `minimum_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity (MOQ)');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_site` ALTER COLUMN `minimum_order_quantity_uom` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity Unit of Measure (UOM)');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_site` ALTER COLUMN `next_audit_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Audit Due Date');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_site` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_site` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_site` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_site` ALTER COLUMN `preferred_carrier` SET TAGS ('dbx_business_glossary_term' = 'Preferred Carrier');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_site` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Email Address');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_site` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_site` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_site` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_site` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Name');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_site` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_site` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_site` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Phone Number');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_site` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_site` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_site` ALTER COLUMN `qualification_status` SET TAGS ('dbx_business_glossary_term' = 'Qualification Status');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_site` ALTER COLUMN `qualification_status` SET TAGS ('dbx_value_regex' = 'qualified|pending_audit|conditional|disqualified|not_assessed');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_site` ALTER COLUMN `responsible_care_certified` SET TAGS ('dbx_business_glossary_term' = 'Responsible Care Certified');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_site` ALTER COLUMN `risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Risk Rating');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_site` ALTER COLUMN `risk_rating` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_site` ALTER COLUMN `site_code` SET TAGS ('dbx_business_glossary_term' = 'Site Code');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_site` ALTER COLUMN `site_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,12}$');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_site` ALTER COLUMN `site_name` SET TAGS ('dbx_business_glossary_term' = 'Site Name');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_site` ALTER COLUMN `site_status` SET TAGS ('dbx_business_glossary_term' = 'Site Status');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_site` ALTER COLUMN `site_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|pending_qualification|decommissioned');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_site` ALTER COLUMN `site_type` SET TAGS ('dbx_business_glossary_term' = 'Site Type');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_site` ALTER COLUMN `site_type` SET TAGS ('dbx_value_regex' = 'manufacturing_plant|distribution_center|warehouse|port_of_export|research_facility|blending_facility');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_site` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'State or Province');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_site` ALTER COLUMN `state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_site` ALTER COLUMN `state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_site` ALTER COLUMN `time_zone` SET TAGS ('dbx_business_glossary_term' = 'Time Zone');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_site` ALTER COLUMN `un_locode` SET TAGS ('dbx_business_glossary_term' = 'United Nations Location Code (UN/LOCODE)');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_site` ALTER COLUMN `un_locode` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}[A-Z0-9]{3}$');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`purchase_order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`purchase_order` SET TAGS ('dbx_subdomain' = 'procurement_execution');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`purchase_order` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) ID');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`purchase_order` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`purchase_order` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`purchase_order` ALTER COLUMN `internal_order_id` SET TAGS ('dbx_business_glossary_term' = 'Internal Order Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`purchase_order` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`purchase_order` ALTER COLUMN `production_plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant ID');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`purchase_order` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`purchase_order` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`purchase_order` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`purchase_order` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|approved|rejected');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`purchase_order` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`purchase_order` ALTER COLUMN `approved_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`purchase_order` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`purchase_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`purchase_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`purchase_order` ALTER COLUMN `delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Requested Delivery Date');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`purchase_order` ALTER COLUMN `document_date` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Document Date');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`purchase_order` ALTER COLUMN `freight_terms` SET TAGS ('dbx_business_glossary_term' = 'Freight Terms');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`purchase_order` ALTER COLUMN `freight_terms` SET TAGS ('dbx_value_regex' = 'prepaid|collect|third_party');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`purchase_order` ALTER COLUMN `incoterms` SET TAGS ('dbx_business_glossary_term' = 'Incoterms');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`purchase_order` ALTER COLUMN `incoterms_location` SET TAGS ('dbx_business_glossary_term' = 'Incoterms Location');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`purchase_order` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`purchase_order` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`purchase_order` ALTER COLUMN `payment_terms` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`purchase_order` ALTER COLUMN `po_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Number');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`purchase_order` ALTER COLUMN `po_number` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`purchase_order` ALTER COLUMN `po_status` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Status');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`purchase_order` ALTER COLUMN `po_type` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Type');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`purchase_order` ALTER COLUMN `po_type` SET TAGS ('dbx_value_regex' = 'standard|blanket|contract|consignment|subcontracting|service');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`purchase_order` ALTER COLUMN `purchasing_group` SET TAGS ('dbx_business_glossary_term' = 'Purchasing Group');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`purchase_order` ALTER COLUMN `purchasing_group` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3}$');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`purchase_order` ALTER COLUMN `purchasing_organization` SET TAGS ('dbx_business_glossary_term' = 'Purchasing Organization');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`purchase_order` ALTER COLUMN `purchasing_organization` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`purchase_order` ALTER COLUMN `release_date` SET TAGS ('dbx_business_glossary_term' = 'Release Date');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`purchase_order` ALTER COLUMN `requisition_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Requisition (PR) Number');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`purchase_order` ALTER COLUMN `rfq_number` SET TAGS ('dbx_business_glossary_term' = 'Request for Quotation (RFQ) Number');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`purchase_order` ALTER COLUMN `shipping_address_line1` SET TAGS ('dbx_business_glossary_term' = 'Shipping Address Line 1');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`purchase_order` ALTER COLUMN `shipping_address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`purchase_order` ALTER COLUMN `shipping_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`purchase_order` ALTER COLUMN `shipping_city` SET TAGS ('dbx_business_glossary_term' = 'Shipping City');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`purchase_order` ALTER COLUMN `shipping_city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`purchase_order` ALTER COLUMN `shipping_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`purchase_order` ALTER COLUMN `shipping_country_code` SET TAGS ('dbx_business_glossary_term' = 'Shipping Country Code');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`purchase_order` ALTER COLUMN `shipping_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`purchase_order` ALTER COLUMN `shipping_country_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`purchase_order` ALTER COLUMN `shipping_country_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`purchase_order` ALTER COLUMN `shipping_method` SET TAGS ('dbx_business_glossary_term' = 'Shipping Method');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`purchase_order` ALTER COLUMN `shipping_method` SET TAGS ('dbx_value_regex' = 'truck|rail|ocean|air|pipeline|intermodal');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`purchase_order` ALTER COLUMN `shipping_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Shipping Postal Code');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`purchase_order` ALTER COLUMN `shipping_postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`purchase_order` ALTER COLUMN `shipping_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`purchase_order` ALTER COLUMN `shipping_state_province` SET TAGS ('dbx_business_glossary_term' = 'Shipping State or Province');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`purchase_order` ALTER COLUMN `shipping_state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`purchase_order` ALTER COLUMN `shipping_state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`purchase_order` ALTER COLUMN `special_instructions` SET TAGS ('dbx_business_glossary_term' = 'Special Instructions');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`purchase_order` ALTER COLUMN `total_gross_value` SET TAGS ('dbx_business_glossary_term' = 'Total Gross Value');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`purchase_order` ALTER COLUMN `total_net_value` SET TAGS ('dbx_business_glossary_term' = 'Total Net Value');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`purchase_order` ALTER COLUMN `total_tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Tax Amount');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`purchase_order` ALTER COLUMN `validity_end_date` SET TAGS ('dbx_business_glossary_term' = 'Validity End Date');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`purchase_order` ALTER COLUMN `validity_start_date` SET TAGS ('dbx_business_glossary_term' = 'Validity Start Date');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`purchase_order` ALTER COLUMN `vendor_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Vendor Contact Email Address');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`purchase_order` ALTER COLUMN `vendor_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`purchase_order` ALTER COLUMN `vendor_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`purchase_order` ALTER COLUMN `vendor_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Vendor Contact Name');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`purchase_order` ALTER COLUMN `vendor_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`purchase_order` ALTER COLUMN `vendor_contact_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`po_line` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`po_line` SET TAGS ('dbx_subdomain' = 'procurement_execution');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`po_line` ALTER COLUMN `po_line_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Line Identifier');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`po_line` ALTER COLUMN `contract_price_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Price Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`po_line` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`po_line` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`po_line` ALTER COLUMN `inspection_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Plan Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`po_line` ALTER COLUMN `internal_order_id` SET TAGS ('dbx_business_glossary_term' = 'Internal Order Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`po_line` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Identifier');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`po_line` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Header Identifier');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`po_line` ALTER COLUMN `batch_managed_flag` SET TAGS ('dbx_business_glossary_term' = 'Batch Managed Flag');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`po_line` ALTER COLUMN `cas_number` SET TAGS ('dbx_business_glossary_term' = 'Chemical Abstracts Service (CAS) Number');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`po_line` ALTER COLUMN `cas_number` SET TAGS ('dbx_value_regex' = '^[1-9][0-9]{1,6}-[0-9]{2}-[0-9]$');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`po_line` ALTER COLUMN `confirmation_control_key` SET TAGS ('dbx_business_glossary_term' = 'Confirmation Control Key');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`po_line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`po_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`po_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`po_line` ALTER COLUMN `deletion_indicator` SET TAGS ('dbx_business_glossary_term' = 'Deletion Indicator');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`po_line` ALTER COLUMN `delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Delivery Date');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`po_line` ALTER COLUMN `ghs_hazard_category` SET TAGS ('dbx_business_glossary_term' = 'Globally Harmonized System (GHS) Hazard Category');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`po_line` ALTER COLUMN `goods_receipt_quantity` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt Quantity');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`po_line` ALTER COLUMN `goods_receipt_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt Required Flag');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`po_line` ALTER COLUMN `hazmat_indicator` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Material (HAZMAT) Indicator');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`po_line` ALTER COLUMN `incoterms` SET TAGS ('dbx_business_glossary_term' = 'International Commercial Terms (Incoterms)');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`po_line` ALTER COLUMN `incoterms_location` SET TAGS ('dbx_business_glossary_term' = 'Incoterms Location');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`po_line` ALTER COLUMN `invoice_receipt_quantity` SET TAGS ('dbx_business_glossary_term' = 'Invoice Receipt Quantity');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`po_line` ALTER COLUMN `invoice_receipt_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Invoice Receipt Required Flag');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`po_line` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`po_line` ALTER COLUMN `line_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Line Number');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`po_line` ALTER COLUMN `line_status` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Line Status');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`po_line` ALTER COLUMN `line_status` SET TAGS ('dbx_value_regex' = 'open|partially_received|fully_received|cancelled|blocked');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`po_line` ALTER COLUMN `material_description` SET TAGS ('dbx_business_glossary_term' = 'Material Description');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`po_line` ALTER COLUMN `material_group` SET TAGS ('dbx_business_glossary_term' = 'Material Group');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`po_line` ALTER COLUMN `material_number` SET TAGS ('dbx_business_glossary_term' = 'Material Number');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`po_line` ALTER COLUMN `net_order_value` SET TAGS ('dbx_business_glossary_term' = 'Net Order Value');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`po_line` ALTER COLUMN `net_price` SET TAGS ('dbx_business_glossary_term' = 'Net Price');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`po_line` ALTER COLUMN `ordered_quantity` SET TAGS ('dbx_business_glossary_term' = 'Ordered Quantity');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`po_line` ALTER COLUMN `outstanding_quantity` SET TAGS ('dbx_business_glossary_term' = 'Outstanding Quantity');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`po_line` ALTER COLUMN `over_delivery_tolerance_pct` SET TAGS ('dbx_business_glossary_term' = 'Over Delivery Tolerance Percentage');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`po_line` ALTER COLUMN `plant_code` SET TAGS ('dbx_business_glossary_term' = 'Plant Code');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`po_line` ALTER COLUMN `price_unit` SET TAGS ('dbx_business_glossary_term' = 'Price Unit');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`po_line` ALTER COLUMN `purchasing_group` SET TAGS ('dbx_business_glossary_term' = 'Purchasing Group');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`po_line` ALTER COLUMN `quality_inspection_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Quality Inspection Required Flag');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`po_line` ALTER COLUMN `storage_location` SET TAGS ('dbx_business_glossary_term' = 'Storage Location');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`po_line` ALTER COLUMN `supplier_material_number` SET TAGS ('dbx_business_glossary_term' = 'Supplier Material Number');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`po_line` ALTER COLUMN `tax_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Code');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`po_line` ALTER COLUMN `un_number` SET TAGS ('dbx_business_glossary_term' = 'United Nations (UN) Number');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`po_line` ALTER COLUMN `un_number` SET TAGS ('dbx_value_regex' = '^UN[0-9]{4}$');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`po_line` ALTER COLUMN `under_delivery_tolerance_pct` SET TAGS ('dbx_business_glossary_term' = 'Under Delivery Tolerance Percentage');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`po_line` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`goods_receipt` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`goods_receipt` SET TAGS ('dbx_subdomain' = 'inbound_logistics');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`goods_receipt` ALTER COLUMN `goods_receipt_id` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt Identifier');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`goods_receipt` ALTER COLUMN `asn_id` SET TAGS ('dbx_business_glossary_term' = 'Asn Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`goods_receipt` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`goods_receipt` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`goods_receipt` ALTER COLUMN `fiscal_period_id` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`goods_receipt` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`goods_receipt` ALTER COLUMN `inbound_delivery_id` SET TAGS ('dbx_business_glossary_term' = 'Inbound Delivery Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`goods_receipt` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material ID');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`goods_receipt` ALTER COLUMN `po_line_id` SET TAGS ('dbx_business_glossary_term' = 'Po Line Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`goods_receipt` ALTER COLUMN `process_order_id` SET TAGS ('dbx_business_glossary_term' = 'Process Order Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`goods_receipt` ALTER COLUMN `production_plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant ID');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`goods_receipt` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`goods_receipt` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) ID');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`goods_receipt` ALTER COLUMN `safety_data_sheet_id` SET TAGS ('dbx_business_glossary_term' = 'Safety Data Sheet Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`goods_receipt` ALTER COLUMN `vehicle_id` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`goods_receipt` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`goods_receipt` ALTER COLUMN `warehouse_location_id` SET TAGS ('dbx_business_glossary_term' = 'Storage Location ID');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`goods_receipt` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`goods_receipt` ALTER COLUMN `cas_number` SET TAGS ('dbx_business_glossary_term' = 'Chemical Abstracts Service (CAS) Number');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`goods_receipt` ALTER COLUMN `cas_number` SET TAGS ('dbx_value_regex' = '^[0-9]{2,7}-[0-9]{2}-[0-9]$');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`goods_receipt` ALTER COLUMN `coa_document_number` SET TAGS ('dbx_business_glossary_term' = 'Certificate of Analysis (COA) Document Number');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`goods_receipt` ALTER COLUMN `coa_document_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{8,20}$');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`goods_receipt` ALTER COLUMN `coa_received_flag` SET TAGS ('dbx_business_glossary_term' = 'Certificate of Analysis (COA) Received Flag');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`goods_receipt` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`goods_receipt` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`goods_receipt` ALTER COLUMN `damage_description` SET TAGS ('dbx_business_glossary_term' = 'Damage Description');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`goods_receipt` ALTER COLUMN `delivery_note_number` SET TAGS ('dbx_business_glossary_term' = 'Delivery Note Number');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`goods_receipt` ALTER COLUMN `delivery_note_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{6,20}$');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`goods_receipt` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`goods_receipt` ALTER COLUMN `gr_date` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt (GR) Date');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`goods_receipt` ALTER COLUMN `gr_document_number` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt (GR) Document Number');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`goods_receipt` ALTER COLUMN `gr_document_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{10}$');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`goods_receipt` ALTER COLUMN `gr_status` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt (GR) Status');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`goods_receipt` ALTER COLUMN `gr_status` SET TAGS ('dbx_value_regex' = 'posted|pending|reversed|cancelled|blocked');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`goods_receipt` ALTER COLUMN `gr_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt (GR) Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`goods_receipt` ALTER COLUMN `hazmat_flag` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Material (HAZMAT) Flag');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`goods_receipt` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`goods_receipt` ALTER COLUMN `movement_type` SET TAGS ('dbx_business_glossary_term' = 'Movement Type');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`goods_receipt` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt Notes');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`goods_receipt` ALTER COLUMN `packaging_condition` SET TAGS ('dbx_business_glossary_term' = 'Packaging Condition');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`goods_receipt` ALTER COLUMN `packaging_condition` SET TAGS ('dbx_value_regex' = 'good|damaged|leaking|contaminated|acceptable_with_notes');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`goods_receipt` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Date');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`goods_receipt` ALTER COLUMN `quality_inspection_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Quality Inspection Required Flag');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`goods_receipt` ALTER COLUMN `received_quantity` SET TAGS ('dbx_business_glossary_term' = 'Received Quantity');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`goods_receipt` ALTER COLUMN `receiver_name` SET TAGS ('dbx_business_glossary_term' = 'Receiver Name');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`goods_receipt` ALTER COLUMN `retest_date` SET TAGS ('dbx_business_glossary_term' = 'Retest Date');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`goods_receipt` ALTER COLUMN `seal_intact_flag` SET TAGS ('dbx_business_glossary_term' = 'Seal Intact Flag');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`goods_receipt` ALTER COLUMN `seal_number` SET TAGS ('dbx_business_glossary_term' = 'Seal Number');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`goods_receipt` ALTER COLUMN `seal_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,15}$');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`goods_receipt` ALTER COLUMN `stock_type` SET TAGS ('dbx_business_glossary_term' = 'Stock Type');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`goods_receipt` ALTER COLUMN `stock_type` SET TAGS ('dbx_value_regex' = 'unrestricted|quality_inspection|blocked|restricted');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`goods_receipt` ALTER COLUMN `temperature_on_arrival_c` SET TAGS ('dbx_business_glossary_term' = 'Temperature on Arrival (Celsius)');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`goods_receipt` ALTER COLUMN `un_number` SET TAGS ('dbx_business_glossary_term' = 'United Nations (UN) Number');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`goods_receipt` ALTER COLUMN `un_number` SET TAGS ('dbx_value_regex' = '^UN[0-9]{4}$');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`goods_receipt` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`goods_receipt` ALTER COLUMN `valuation_amount` SET TAGS ('dbx_business_glossary_term' = 'Valuation Amount');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`asn` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`asn` SET TAGS ('dbx_subdomain' = 'inbound_logistics');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`asn` ALTER COLUMN `asn_id` SET TAGS ('dbx_business_glossary_term' = 'Advanced Shipping Notice (ASN) ID');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`asn` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`asn` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) ID');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`asn` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`asn` ALTER COLUMN `vendor_site_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Site Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`asn` ALTER COLUMN `actual_arrival_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Arrival Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`asn` ALTER COLUMN `asn_number` SET TAGS ('dbx_business_glossary_term' = 'Advanced Shipping Notice (ASN) Number');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`asn` ALTER COLUMN `asn_number` SET TAGS ('dbx_value_regex' = '^ASN-[A-Z0-9]{8,15}$');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`asn` ALTER COLUMN `asn_status` SET TAGS ('dbx_business_glossary_term' = 'Advanced Shipping Notice (ASN) Status');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`asn` ALTER COLUMN `asn_type` SET TAGS ('dbx_business_glossary_term' = 'Advanced Shipping Notice (ASN) Type');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`asn` ALTER COLUMN `asn_type` SET TAGS ('dbx_value_regex' = 'standard|expedited|hazmat|bulk|consignment|drop_ship');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`asn` ALTER COLUMN `container_number` SET TAGS ('dbx_business_glossary_term' = 'Container ID');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`asn` ALTER COLUMN `container_number` SET TAGS ('dbx_value_regex' = '^[A-Z]{4}[0-9]{7}$');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`asn` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`asn` ALTER COLUMN `expected_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Expected Delivery Date');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`asn` ALTER COLUMN `expected_delivery_time` SET TAGS ('dbx_business_glossary_term' = 'Expected Delivery Time');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`asn` ALTER COLUMN `freight_terms` SET TAGS ('dbx_business_glossary_term' = 'Freight Terms');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`asn` ALTER COLUMN `freight_terms` SET TAGS ('dbx_value_regex' = 'prepaid|collect|third_party|FOB_origin|FOB_destination');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`asn` ALTER COLUMN `hazmat_indicator` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Material (HAZMAT) Indicator');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`asn` ALTER COLUMN `hazmat_placard_code` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Material (HAZMAT) Placard Code');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`asn` ALTER COLUMN `hazmat_placard_code` SET TAGS ('dbx_value_regex' = '^[0-9]{1}(.[0-9]{1})?$');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`asn` ALTER COLUMN `incoterms_code` SET TAGS ('dbx_business_glossary_term' = 'International Commercial Terms (Incoterms) Code');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`asn` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`asn` ALTER COLUMN `package_count` SET TAGS ('dbx_business_glossary_term' = 'Package Count');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`asn` ALTER COLUMN `pallet_count` SET TAGS ('dbx_business_glossary_term' = 'Pallet Count');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`asn` ALTER COLUMN `pro_number` SET TAGS ('dbx_business_glossary_term' = 'Progressive Number (PRO)');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`asn` ALTER COLUMN `pro_number` SET TAGS ('dbx_value_regex' = '^PRO-[0-9]{8,12}$');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`asn` ALTER COLUMN `receiving_dock_location` SET TAGS ('dbx_business_glossary_term' = 'Receiving Dock Location');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`asn` ALTER COLUMN `receiving_plant_code` SET TAGS ('dbx_business_glossary_term' = 'Receiving Plant Code');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`asn` ALTER COLUMN `receiving_plant_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`asn` ALTER COLUMN `required_temperature_max` SET TAGS ('dbx_business_glossary_term' = 'Required Maximum Temperature');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`asn` ALTER COLUMN `required_temperature_min` SET TAGS ('dbx_business_glossary_term' = 'Required Minimum Temperature');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`asn` ALTER COLUMN `seal_number` SET TAGS ('dbx_business_glossary_term' = 'Seal Number');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`asn` ALTER COLUMN `seal_number` SET TAGS ('dbx_value_regex' = '^SEAL-[A-Z0-9]{6,15}$');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`asn` ALTER COLUMN `shipment_mode` SET TAGS ('dbx_business_glossary_term' = 'Shipment Mode');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`asn` ALTER COLUMN `shipment_mode` SET TAGS ('dbx_value_regex' = 'LTL|FTL|parcel|rail|intermodal|air');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`asn` ALTER COLUMN `special_handling_instructions` SET TAGS ('dbx_business_glossary_term' = 'Special Handling Instructions');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`asn` ALTER COLUMN `temperature_controlled_indicator` SET TAGS ('dbx_business_glossary_term' = 'Temperature Controlled Indicator');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`asn` ALTER COLUMN `temperature_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Temperature Unit of Measure');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`asn` ALTER COLUMN `temperature_unit_of_measure` SET TAGS ('dbx_value_regex' = 'C|F|K');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`asn` ALTER COLUMN `total_gross_weight` SET TAGS ('dbx_business_glossary_term' = 'Total Gross Weight');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`asn` ALTER COLUMN `total_net_weight` SET TAGS ('dbx_business_glossary_term' = 'Total Net Weight');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`asn` ALTER COLUMN `total_volume` SET TAGS ('dbx_business_glossary_term' = 'Total Volume');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`asn` ALTER COLUMN `trailer_number` SET TAGS ('dbx_business_glossary_term' = 'Trailer Number');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`asn` ALTER COLUMN `trailer_number` SET TAGS ('dbx_value_regex' = '^TRL-[A-Z0-9]{6,12}$');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`asn` ALTER COLUMN `transmitted_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Transmitted Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`asn` ALTER COLUMN `un_number` SET TAGS ('dbx_business_glossary_term' = 'United Nations (UN) Number');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`asn` ALTER COLUMN `un_number` SET TAGS ('dbx_value_regex' = '^UN[0-9]{4}$');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`asn` ALTER COLUMN `volume_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Volume Unit of Measure');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`asn` ALTER COLUMN `volume_unit_of_measure` SET TAGS ('dbx_value_regex' = 'L|GAL|M3|FT3');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`asn` ALTER COLUMN `weight_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Weight Unit of Measure');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`asn` ALTER COLUMN `weight_unit_of_measure` SET TAGS ('dbx_value_regex' = 'KG|LB|MT|TON');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`contract` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`contract` SET TAGS ('dbx_subdomain' = 'procurement_execution');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`contract` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Identifier');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`contract` ALTER COLUMN `material_master_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`contract` ALTER COLUMN `contract_material_material_master_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`contract` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`contract` ALTER COLUMN `material_specification_id` SET TAGS ('dbx_business_glossary_term' = 'Material Specification Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`contract` ALTER COLUMN `operating_permit_id` SET TAGS ('dbx_business_glossary_term' = 'Operating Permit Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`contract` ALTER COLUMN `primary_contract_material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Identifier (ID)');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`contract` ALTER COLUMN `production_plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`contract` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`contract` ALTER COLUMN `quality_specification_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Specification Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`contract` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Identifier (ID)');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`contract` ALTER COLUMN `vendor_site_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Site Identifier (ID)');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`contract` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`contract` ALTER COLUMN `approved_by_name` SET TAGS ('dbx_business_glossary_term' = 'Approved By Name');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`contract` ALTER COLUMN `auto_renewal_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto Renewal Flag');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`contract` ALTER COLUMN `cas_number` SET TAGS ('dbx_business_glossary_term' = 'Chemical Abstracts Service (CAS) Number');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`contract` ALTER COLUMN `cas_number` SET TAGS ('dbx_value_regex' = '^[0-9]{2,7}-[0-9]{2}-[0-9]$');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`contract` ALTER COLUMN `contract_number` SET TAGS ('dbx_business_glossary_term' = 'Contract Number');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`contract` ALTER COLUMN `contract_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`contract` ALTER COLUMN `contract_status` SET TAGS ('dbx_business_glossary_term' = 'Contract Status');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`contract` ALTER COLUMN `contract_type` SET TAGS ('dbx_business_glossary_term' = 'Contract Type');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`contract` ALTER COLUMN `contract_type` SET TAGS ('dbx_value_regex' = 'quantity_contract|value_contract|scheduling_agreement|blanket_purchase_agreement|framework_agreement|spot_contract');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`contract` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`contract` ALTER COLUMN `delivery_frequency` SET TAGS ('dbx_business_glossary_term' = 'Delivery Frequency');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`contract` ALTER COLUMN `force_majeure_terms` SET TAGS ('dbx_business_glossary_term' = 'Force Majeure Terms');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`contract` ALTER COLUMN `incoterms` SET TAGS ('dbx_business_glossary_term' = 'International Commercial Terms (Incoterms)');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`contract` ALTER COLUMN `incoterms_location` SET TAGS ('dbx_business_glossary_term' = 'Incoterms Location');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`contract` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`contract` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time in Days');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`contract` ALTER COLUMN `maximum_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Maximum Order Quantity');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`contract` ALTER COLUMN `minimum_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity (MOQ)');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`contract` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`contract` ALTER COLUMN `price_currency` SET TAGS ('dbx_business_glossary_term' = 'Price Currency');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`contract` ALTER COLUMN `price_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`contract` ALTER COLUMN `price_escalation_clause` SET TAGS ('dbx_business_glossary_term' = 'Price Escalation Clause');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`contract` ALTER COLUMN `price_per_unit` SET TAGS ('dbx_business_glossary_term' = 'Price Per Unit');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`contract` ALTER COLUMN `price_unit` SET TAGS ('dbx_business_glossary_term' = 'Price Unit');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`contract` ALTER COLUMN `purchasing_group` SET TAGS ('dbx_business_glossary_term' = 'Purchasing Group');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`contract` ALTER COLUMN `purchasing_organization` SET TAGS ('dbx_business_glossary_term' = 'Purchasing Organization');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`contract` ALTER COLUMN `quantity_unit` SET TAGS ('dbx_business_glossary_term' = 'Quantity Unit of Measure (UOM)');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`contract` ALTER COLUMN `renewal_term_months` SET TAGS ('dbx_business_glossary_term' = 'Renewal Term in Months');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`contract` ALTER COLUMN `target_quantity` SET TAGS ('dbx_business_glossary_term' = 'Target Quantity');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`contract` ALTER COLUMN `termination_notice_days` SET TAGS ('dbx_business_glossary_term' = 'Termination Notice Period in Days');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`contract` ALTER COLUMN `validity_end_date` SET TAGS ('dbx_business_glossary_term' = 'Validity End Date');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`contract` ALTER COLUMN `validity_start_date` SET TAGS ('dbx_business_glossary_term' = 'Validity Start Date');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`contract` ALTER COLUMN `value_amount` SET TAGS ('dbx_business_glossary_term' = 'Contract Value Amount');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`contract` ALTER COLUMN `value_currency` SET TAGS ('dbx_business_glossary_term' = 'Contract Value Currency');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`contract` ALTER COLUMN `value_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`contract_price` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`contract_price` SET TAGS ('dbx_subdomain' = 'procurement_execution');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`contract_price` ALTER COLUMN `contract_price_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Price Identifier (ID)');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`contract_price` ALTER COLUMN `cost_element_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Element Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`contract_price` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Identifier (ID)');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`contract_price` ALTER COLUMN `production_plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`contract_price` ALTER COLUMN `contract_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`contract_price` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Identifier (ID)');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`contract_price` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`contract_price` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'approved|pending|rejected|not_required');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`contract_price` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`contract_price` ALTER COLUMN `approved_date` SET TAGS ('dbx_business_glossary_term' = 'Approved Date');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`contract_price` ALTER COLUMN `calculation_type` SET TAGS ('dbx_business_glossary_term' = 'Calculation Type');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`contract_price` ALTER COLUMN `calculation_type` SET TAGS ('dbx_value_regex' = 'percentage|fixed_amount|absolute');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`contract_price` ALTER COLUMN `condition_class` SET TAGS ('dbx_business_glossary_term' = 'Condition Class');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`contract_price` ALTER COLUMN `condition_class` SET TAGS ('dbx_value_regex' = 'base_price|surcharge|discount|freight|tax|other');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`contract_price` ALTER COLUMN `condition_record_number` SET TAGS ('dbx_business_glossary_term' = 'Condition Record Number');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`contract_price` ALTER COLUMN `condition_type` SET TAGS ('dbx_business_glossary_term' = 'Condition Type');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`contract_price` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`contract_price` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`contract_price` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`contract_price` ALTER COLUMN `freight_included_flag` SET TAGS ('dbx_business_glossary_term' = 'Freight Included Flag');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`contract_price` ALTER COLUMN `hazmat_surcharge_flag` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Material (HAZMAT) Surcharge Flag');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`contract_price` ALTER COLUMN `incoterms` SET TAGS ('dbx_business_glossary_term' = 'International Commercial Terms (Incoterms)');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`contract_price` ALTER COLUMN `incoterms_location` SET TAGS ('dbx_business_glossary_term' = 'Incoterms Location');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`contract_price` ALTER COLUMN `info_record_number` SET TAGS ('dbx_business_glossary_term' = 'Purchasing Info Record Number');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`contract_price` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`contract_price` ALTER COLUMN `maximum_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Maximum Order Quantity');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`contract_price` ALTER COLUMN `minimum_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity (MOQ)');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`contract_price` ALTER COLUMN `negotiation_date` SET TAGS ('dbx_business_glossary_term' = 'Negotiation Date');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`contract_price` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`contract_price` ALTER COLUMN `price_amount` SET TAGS ('dbx_business_glossary_term' = 'Price Amount');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`contract_price` ALTER COLUMN `price_change_reason` SET TAGS ('dbx_business_glossary_term' = 'Price Change Reason');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`contract_price` ALTER COLUMN `price_determination_rule` SET TAGS ('dbx_business_glossary_term' = 'Price Determination Rule');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`contract_price` ALTER COLUMN `price_source` SET TAGS ('dbx_business_glossary_term' = 'Price Source');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`contract_price` ALTER COLUMN `price_source` SET TAGS ('dbx_value_regex' = 'contract|info_record|quotation|catalog|manual');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`contract_price` ALTER COLUMN `price_status` SET TAGS ('dbx_business_glossary_term' = 'Price Status');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`contract_price` ALTER COLUMN `price_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|expired|superseded');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`contract_price` ALTER COLUMN `price_unit` SET TAGS ('dbx_business_glossary_term' = 'Price Unit');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`contract_price` ALTER COLUMN `pricing_sequence` SET TAGS ('dbx_business_glossary_term' = 'Pricing Sequence');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`contract_price` ALTER COLUMN `purchasing_organization` SET TAGS ('dbx_business_glossary_term' = 'Purchasing Organization');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`contract_price` ALTER COLUMN `scale_quantity_from` SET TAGS ('dbx_business_glossary_term' = 'Scale Quantity From');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`contract_price` ALTER COLUMN `scale_quantity_to` SET TAGS ('dbx_business_glossary_term' = 'Scale Quantity To');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`contract_price` ALTER COLUMN `scale_type` SET TAGS ('dbx_business_glossary_term' = 'Scale Type');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`contract_price` ALTER COLUMN `scale_type` SET TAGS ('dbx_value_regex' = 'quantity|value|none');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`contract_price` ALTER COLUMN `tax_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Code');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`contract_price` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`contract_price` ALTER COLUMN `valid_from_date` SET TAGS ('dbx_business_glossary_term' = 'Valid From Date');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`contract_price` ALTER COLUMN `valid_to_date` SET TAGS ('dbx_business_glossary_term' = 'Valid To Date');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_qualification` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_qualification` SET TAGS ('dbx_subdomain' = 'supplier_management');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_qualification` ALTER COLUMN `vendor_qualification_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Qualification Identifier (ID)');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_qualification` ALTER COLUMN `inspection_audit_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Audit Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_qualification` ALTER COLUMN `inspection_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Plan Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_qualification` ALTER COLUMN `production_plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_qualification` ALTER COLUMN `quality_specification_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Specification Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_qualification` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Identifier (ID)');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_qualification` ALTER COLUMN `actual_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Completion Date');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_qualification` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_qualification` ALTER COLUMN `audit_duration_days` SET TAGS ('dbx_business_glossary_term' = 'Audit Duration in Days');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_qualification` ALTER COLUMN `audit_method` SET TAGS ('dbx_business_glossary_term' = 'Audit Method');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_qualification` ALTER COLUMN `audit_method` SET TAGS ('dbx_value_regex' = 'on_site|remote|hybrid|desktop_review');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_qualification` ALTER COLUMN `audit_team_members` SET TAGS ('dbx_business_glossary_term' = 'Audit Team Members');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_qualification` ALTER COLUMN `capa_due_date` SET TAGS ('dbx_business_glossary_term' = 'Corrective and Preventive Action (CAPA) Due Date');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_qualification` ALTER COLUMN `capa_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Corrective and Preventive Action (CAPA) Required Flag');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_qualification` ALTER COLUMN `delivery_performance_score` SET TAGS ('dbx_business_glossary_term' = 'Delivery Performance Score');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_qualification` ALTER COLUMN `effective_from_date` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_qualification` ALTER COLUMN `ehs_score` SET TAGS ('dbx_business_glossary_term' = 'Environment Health and Safety (EHS) Score');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_qualification` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Qualification Expiry Date');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_qualification` ALTER COLUMN `financial_stability_score` SET TAGS ('dbx_business_glossary_term' = 'Financial Stability Score');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_qualification` ALTER COLUMN `findings_critical_count` SET TAGS ('dbx_business_glossary_term' = 'Critical Findings Count');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_qualification` ALTER COLUMN `findings_major_count` SET TAGS ('dbx_business_glossary_term' = 'Major Findings Count');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_qualification` ALTER COLUMN `findings_minor_count` SET TAGS ('dbx_business_glossary_term' = 'Minor Findings Count');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_qualification` ALTER COLUMN `gmp_certified_flag` SET TAGS ('dbx_business_glossary_term' = 'Good Manufacturing Practice (GMP) Certified Flag');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_qualification` ALTER COLUMN `initiated_date` SET TAGS ('dbx_business_glossary_term' = 'Qualification Initiated Date');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_qualification` ALTER COLUMN `iso_14001_certified_flag` SET TAGS ('dbx_business_glossary_term' = 'ISO 14001 Certified Flag');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_qualification` ALTER COLUMN `iso_45001_certified_flag` SET TAGS ('dbx_business_glossary_term' = 'ISO 45001 Certified Flag');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_qualification` ALTER COLUMN `iso_9001_certified_flag` SET TAGS ('dbx_business_glossary_term' = 'ISO 9001 Certified Flag');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_qualification` ALTER COLUMN `material_category` SET TAGS ('dbx_business_glossary_term' = 'Material Category');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_qualification` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_qualification` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Qualification Notes');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_qualification` ALTER COLUMN `qualification_number` SET TAGS ('dbx_business_glossary_term' = 'Qualification Number');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_qualification` ALTER COLUMN `qualification_number` SET TAGS ('dbx_value_regex' = '^VQ-[0-9]{8}$');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_qualification` ALTER COLUMN `qualification_scope` SET TAGS ('dbx_business_glossary_term' = 'Qualification Scope');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_qualification` ALTER COLUMN `qualification_score` SET TAGS ('dbx_business_glossary_term' = 'Overall Qualification Score');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_qualification` ALTER COLUMN `qualification_status` SET TAGS ('dbx_business_glossary_term' = 'Qualification Status');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_qualification` ALTER COLUMN `qualification_type` SET TAGS ('dbx_business_glossary_term' = 'Qualification Type');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_qualification` ALTER COLUMN `qualification_type` SET TAGS ('dbx_value_regex' = 'initial|periodic|for_cause|re_qualification|expedited');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_qualification` ALTER COLUMN `quality_score` SET TAGS ('dbx_business_glossary_term' = 'Quality Assessment Score');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_qualification` ALTER COLUMN `reach_compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'Registration Evaluation Authorization and Restriction of Chemicals (REACH) Compliant Flag');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_qualification` ALTER COLUMN `regulatory_compliance_score` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Score');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_qualification` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_qualification` ALTER COLUMN `responsible_care_member_flag` SET TAGS ('dbx_business_glossary_term' = 'Responsible Care Member Flag');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_qualification` ALTER COLUMN `risk_classification` SET TAGS ('dbx_business_glossary_term' = 'Risk Classification');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_qualification` ALTER COLUMN `risk_classification` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_qualification` ALTER COLUMN `target_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Target Completion Date');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_qualification` ALTER COLUMN `tsca_compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'Toxic Substances Control Act (TSCA) Compliant Flag');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_audit` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_audit` SET TAGS ('dbx_subdomain' = 'supplier_management');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_audit` ALTER COLUMN `vendor_audit_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Audit Identifier (ID)');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_audit` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Identifier (ID)');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_audit` ALTER COLUMN `vendor_qualification_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Qualification Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_audit` ALTER COLUMN `vendor_site_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Site Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_audit` ALTER COLUMN `audit_closure_date` SET TAGS ('dbx_business_glossary_term' = 'Audit Closure Date');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_audit` ALTER COLUMN `audit_date` SET TAGS ('dbx_business_glossary_term' = 'Audit Date');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_audit` ALTER COLUMN `audit_end_date` SET TAGS ('dbx_business_glossary_term' = 'Audit End Date');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_audit` ALTER COLUMN `audit_frequency_months` SET TAGS ('dbx_business_glossary_term' = 'Audit Frequency in Months');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_audit` ALTER COLUMN `audit_method` SET TAGS ('dbx_business_glossary_term' = 'Audit Method');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_audit` ALTER COLUMN `audit_method` SET TAGS ('dbx_value_regex' = 'on_site|remote|hybrid');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_audit` ALTER COLUMN `audit_number` SET TAGS ('dbx_business_glossary_term' = 'Audit Number');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_audit` ALTER COLUMN `audit_number` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,4}-[0-9]{4,8}$');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_audit` ALTER COLUMN `audit_report_issued_date` SET TAGS ('dbx_business_glossary_term' = 'Audit Report Issued Date');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_audit` ALTER COLUMN `audit_scope` SET TAGS ('dbx_business_glossary_term' = 'Audit Scope');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_audit` ALTER COLUMN `audit_score` SET TAGS ('dbx_business_glossary_term' = 'Audit Score');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_audit` ALTER COLUMN `audit_status` SET TAGS ('dbx_business_glossary_term' = 'Audit Status');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_audit` ALTER COLUMN `audit_status` SET TAGS ('dbx_value_regex' = 'scheduled|in_progress|completed|closed|cancelled');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_audit` ALTER COLUMN `audit_team_members` SET TAGS ('dbx_business_glossary_term' = 'Audit Team Members');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_audit` ALTER COLUMN `audit_type` SET TAGS ('dbx_business_glossary_term' = 'Audit Type');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_audit` ALTER COLUMN `audit_type` SET TAGS ('dbx_value_regex' = 'quality|ehs|psm|gmp|combined|responsible_care');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_audit` ALTER COLUMN `capa_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Corrective and Preventive Action (CAPA) Approval Date');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_audit` ALTER COLUMN `capa_due_date` SET TAGS ('dbx_business_glossary_term' = 'Corrective and Preventive Action (CAPA) Due Date');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_audit` ALTER COLUMN `capa_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Corrective and Preventive Action (CAPA) Required Flag');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_audit` ALTER COLUMN `capa_submission_date` SET TAGS ('dbx_business_glossary_term' = 'Corrective and Preventive Action (CAPA) Submission Date');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_audit` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Audit Comments');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_audit` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_audit` ALTER COLUMN `findings_critical_count` SET TAGS ('dbx_business_glossary_term' = 'Critical Findings Count');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_audit` ALTER COLUMN `findings_major_count` SET TAGS ('dbx_business_glossary_term' = 'Major Findings Count');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_audit` ALTER COLUMN `findings_minor_count` SET TAGS ('dbx_business_glossary_term' = 'Minor Findings Count');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_audit` ALTER COLUMN `findings_observation_count` SET TAGS ('dbx_business_glossary_term' = 'Observation Findings Count');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_audit` ALTER COLUMN `follow_up_audit_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Audit Required Flag');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_audit` ALTER COLUMN `follow_up_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Completion Date');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_audit` ALTER COLUMN `follow_up_due_date` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Due Date');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_audit` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_audit` ALTER COLUMN `lead_auditor_name` SET TAGS ('dbx_business_glossary_term' = 'Lead Auditor Name');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_audit` ALTER COLUMN `next_audit_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Audit Due Date');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_audit` ALTER COLUMN `overall_audit_rating` SET TAGS ('dbx_business_glossary_term' = 'Overall Audit Rating');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_audit` ALTER COLUMN `overall_audit_rating` SET TAGS ('dbx_value_regex' = 'excellent|satisfactory|needs_improvement|unsatisfactory|conditional_approval|not_approved');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_audit` ALTER COLUMN `responsible_care_compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'Responsible Care Compliant Flag');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_audit` ALTER COLUMN `standards_audited_against` SET TAGS ('dbx_business_glossary_term' = 'Standards Audited Against');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_audit` ALTER COLUMN `vendor_response_date` SET TAGS ('dbx_business_glossary_term' = 'Vendor Response Date');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_audit` ALTER COLUMN `vendor_response_received_flag` SET TAGS ('dbx_business_glossary_term' = 'Vendor Response Received Flag');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`purchase_requisition` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`purchase_requisition` SET TAGS ('dbx_subdomain' = 'procurement_execution');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`purchase_requisition` ALTER COLUMN `purchase_requisition_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Requisition (PR) ID');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`purchase_requisition` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`purchase_requisition` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`purchase_requisition` ALTER COLUMN `internal_order_id` SET TAGS ('dbx_business_glossary_term' = 'Internal Order Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`purchase_requisition` ALTER COLUMN `material_master_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`purchase_requisition` ALTER COLUMN `mrp_run_id` SET TAGS ('dbx_business_glossary_term' = 'Mrp Run Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`purchase_requisition` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Preferred Vendor ID');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`purchase_requisition` ALTER COLUMN `process_order_id` SET TAGS ('dbx_business_glossary_term' = 'Process Order Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`purchase_requisition` ALTER COLUMN `production_plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`purchase_requisition` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`purchase_requisition` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`purchase_requisition` ALTER COLUMN `quality_specification_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Specification Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`purchase_requisition` ALTER COLUMN `stock_position_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Position Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`purchase_requisition` ALTER COLUMN `supply_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Supply Plan Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`purchase_requisition` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`purchase_requisition` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`purchase_requisition` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|escalated');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`purchase_requisition` ALTER COLUMN `approver_name` SET TAGS ('dbx_business_glossary_term' = 'Approver Name');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`purchase_requisition` ALTER COLUMN `campaign_production_flag` SET TAGS ('dbx_business_glossary_term' = 'Campaign Production Flag');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`purchase_requisition` ALTER COLUMN `cas_number` SET TAGS ('dbx_business_glossary_term' = 'Chemical Abstracts Service (CAS) Number');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`purchase_requisition` ALTER COLUMN `cas_number` SET TAGS ('dbx_value_regex' = '^[0-9]{2,7}-[0-9]{2}-[0-9]$');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`purchase_requisition` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`purchase_requisition` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`purchase_requisition` ALTER COLUMN `estimated_total_value` SET TAGS ('dbx_business_glossary_term' = 'Estimated Total Value');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`purchase_requisition` ALTER COLUMN `estimated_unit_price` SET TAGS ('dbx_business_glossary_term' = 'Estimated Unit Price');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`purchase_requisition` ALTER COLUMN `hazmat_flag` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Material (HAZMAT) Flag');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`purchase_requisition` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`purchase_requisition` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Procurement Lead Time (Days)');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`purchase_requisition` ALTER COLUMN `material_number` SET TAGS ('dbx_business_glossary_term' = 'Material Number');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`purchase_requisition` ALTER COLUMN `material_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{18}$');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`purchase_requisition` ALTER COLUMN `mrp_element` SET TAGS ('dbx_business_glossary_term' = 'Material Requirements Planning (MRP) Element');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`purchase_requisition` ALTER COLUMN `mrp_element` SET TAGS ('dbx_value_regex' = 'planned_order|purchase_requisition|schedule_line');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`purchase_requisition` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Requisition Notes');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`purchase_requisition` ALTER COLUMN `planner_code` SET TAGS ('dbx_business_glossary_term' = 'Material Requirements Planning (MRP) Planner Code');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`purchase_requisition` ALTER COLUMN `planner_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3}$');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`purchase_requisition` ALTER COLUMN `planning_horizon` SET TAGS ('dbx_business_glossary_term' = 'Planning Horizon');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`purchase_requisition` ALTER COLUMN `planning_horizon` SET TAGS ('dbx_value_regex' = 'weekly|monthly|quarterly');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`purchase_requisition` ALTER COLUMN `po_conversion_status` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Conversion Status');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`purchase_requisition` ALTER COLUMN `po_conversion_status` SET TAGS ('dbx_value_regex' = 'not_converted|partially_converted|fully_converted');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`purchase_requisition` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Requisition Priority');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`purchase_requisition` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'low|normal|high|urgent');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`purchase_requisition` ALTER COLUMN `procurement_type` SET TAGS ('dbx_business_glossary_term' = 'Procurement Type');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`purchase_requisition` ALTER COLUMN `procurement_type` SET TAGS ('dbx_value_regex' = 'stock|consumption|asset|project');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`purchase_requisition` ALTER COLUMN `purchasing_group` SET TAGS ('dbx_business_glossary_term' = 'Purchasing Group');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`purchase_requisition` ALTER COLUMN `purchasing_group` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3}$');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`purchase_requisition` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Requisition Quantity');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`purchase_requisition` ALTER COLUMN `requested_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Requested Delivery Date');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`purchase_requisition` ALTER COLUMN `requester_phone` SET TAGS ('dbx_business_glossary_term' = 'Requester Phone Number');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`purchase_requisition` ALTER COLUMN `requester_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`purchase_requisition` ALTER COLUMN `requester_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`purchase_requisition` ALTER COLUMN `requisition_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Requisition (PR) Number');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`purchase_requisition` ALTER COLUMN `requisition_number` SET TAGS ('dbx_value_regex' = '^PR[0-9]{10}$');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`purchase_requisition` ALTER COLUMN `requisition_status` SET TAGS ('dbx_business_glossary_term' = 'Purchase Requisition (PR) Status');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`purchase_requisition` ALTER COLUMN `requisition_type` SET TAGS ('dbx_business_glossary_term' = 'Purchase Requisition (PR) Type');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`purchase_requisition` ALTER COLUMN `requisition_type` SET TAGS ('dbx_value_regex' = 'standard|subcontracting|consignment|stock_transfer|service|third_party');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`purchase_requisition` ALTER COLUMN `safety_stock_trigger` SET TAGS ('dbx_business_glossary_term' = 'Safety Stock Trigger Flag');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`purchase_requisition` ALTER COLUMN `source_of_supply` SET TAGS ('dbx_business_glossary_term' = 'Source of Supply');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`purchase_requisition` ALTER COLUMN `source_of_supply` SET TAGS ('dbx_value_regex' = 'external_procurement|internal_transfer|subcontracting|consignment');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`purchase_requisition` ALTER COLUMN `storage_location` SET TAGS ('dbx_business_glossary_term' = 'Storage Location');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`purchase_requisition` ALTER COLUMN `storage_location` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`purchase_requisition` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`purchase_requisition` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,3}$');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`purchase_requisition` ALTER COLUMN `creation_date` SET TAGS ('dbx_business_glossary_term' = 'Purchase Requisition (PR) Creation Date');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`source_list` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`source_list` SET TAGS ('dbx_subdomain' = 'supplier_management');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`source_list` ALTER COLUMN `source_list_id` SET TAGS ('dbx_business_glossary_term' = 'Source List ID');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`source_list` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`source_list` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`source_list` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material ID');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`source_list` ALTER COLUMN `production_plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`source_list` ALTER COLUMN `quality_specification_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Specification Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`source_list` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`source_list` ALTER COLUMN `agreement_item` SET TAGS ('dbx_business_glossary_term' = 'Agreement Item');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`source_list` ALTER COLUMN `agreement_type` SET TAGS ('dbx_business_glossary_term' = 'Agreement Type');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`source_list` ALTER COLUMN `agreement_type` SET TAGS ('dbx_value_regex' = 'contract|scheduling_agreement|none');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`source_list` ALTER COLUMN `avl_status` SET TAGS ('dbx_business_glossary_term' = 'Approved Vendor List (AVL) Status');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`source_list` ALTER COLUMN `avl_status` SET TAGS ('dbx_value_regex' = 'approved|conditional|rejected|expired');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`source_list` ALTER COLUMN `blocked_flag` SET TAGS ('dbx_business_glossary_term' = 'Blocked Flag');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`source_list` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`source_list` ALTER COLUMN `fixed_source_flag` SET TAGS ('dbx_business_glossary_term' = 'Fixed Source Flag');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`source_list` ALTER COLUMN `incoterm` SET TAGS ('dbx_business_glossary_term' = 'Incoterm');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`source_list` ALTER COLUMN `incoterm_location` SET TAGS ('dbx_business_glossary_term' = 'Incoterm Location');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`source_list` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`source_list` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`source_list` ALTER COLUMN `last_purchase_order_date` SET TAGS ('dbx_business_glossary_term' = 'Last Purchase Order (PO) Date');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`source_list` ALTER COLUMN `last_qualification_date` SET TAGS ('dbx_business_glossary_term' = 'Last Qualification Date');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`source_list` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time Days');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`source_list` ALTER COLUMN `minimum_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity (MOQ)');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`source_list` ALTER COLUMN `mrp_relevant_flag` SET TAGS ('dbx_business_glossary_term' = 'Material Requirements Planning (MRP) Relevant Flag');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`source_list` ALTER COLUMN `next_qualification_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Qualification Due Date');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`source_list` ALTER COLUMN `order_quantity_uom` SET TAGS ('dbx_business_glossary_term' = 'Order Quantity Unit of Measure (UOM)');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`source_list` ALTER COLUMN `preferred_vendor_flag` SET TAGS ('dbx_business_glossary_term' = 'Preferred Vendor Flag');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`source_list` ALTER COLUMN `purchasing_organization` SET TAGS ('dbx_business_glossary_term' = 'Purchasing Organization');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`source_list` ALTER COLUMN `qualification_status` SET TAGS ('dbx_business_glossary_term' = 'Qualification Status');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`source_list` ALTER COLUMN `qualification_status` SET TAGS ('dbx_value_regex' = 'qualified|conditional|pending|suspended');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`source_list` ALTER COLUMN `record` SET TAGS ('dbx_business_glossary_term' = 'Source List Record Number');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`source_list` ALTER COLUMN `risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Risk Rating');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`source_list` ALTER COLUMN `risk_rating` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`source_list` ALTER COLUMN `source_list_category` SET TAGS ('dbx_business_glossary_term' = 'Source List Category');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`source_list` ALTER COLUMN `source_list_category` SET TAGS ('dbx_value_regex' = 'regular|subcontracting|consignment|pipeline');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`source_list` ALTER COLUMN `valid_from_date` SET TAGS ('dbx_business_glossary_term' = 'Valid From Date');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`source_list` ALTER COLUMN `valid_to_date` SET TAGS ('dbx_business_glossary_term' = 'Valid To Date');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`source_list` ALTER COLUMN `vendor_priority` SET TAGS ('dbx_business_glossary_term' = 'Vendor Priority');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`source_list` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`inbound_delivery` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`inbound_delivery` SET TAGS ('dbx_subdomain' = 'inbound_logistics');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`inbound_delivery` ALTER COLUMN `inbound_delivery_id` SET TAGS ('dbx_business_glossary_term' = 'Inbound Delivery ID');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`inbound_delivery` ALTER COLUMN `asn_id` SET TAGS ('dbx_business_glossary_term' = 'Advanced Shipping Notice (ASN) ID');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`inbound_delivery` ALTER COLUMN `bill_of_lading_id` SET TAGS ('dbx_business_glossary_term' = 'Bill Of Lading Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`inbound_delivery` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier ID');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`inbound_delivery` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`inbound_delivery` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Site Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`inbound_delivery` ALTER COLUMN `freight_order_id` SET TAGS ('dbx_business_glossary_term' = 'Freight Order Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`inbound_delivery` ALTER COLUMN `lot_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`inbound_delivery` ALTER COLUMN `manufacturing_order_id` SET TAGS ('dbx_business_glossary_term' = 'Production Order Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`inbound_delivery` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`inbound_delivery` ALTER COLUMN `production_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Production Schedule Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`inbound_delivery` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Header ID');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`inbound_delivery` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`inbound_delivery` ALTER COLUMN `vendor_site_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Site ID');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`inbound_delivery` ALTER COLUMN `actual_arrival_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Arrival Date');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`inbound_delivery` ALTER COLUMN `actual_arrival_time` SET TAGS ('dbx_business_glossary_term' = 'Actual Arrival Time');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`inbound_delivery` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`inbound_delivery` ALTER COLUMN `delivery_number` SET TAGS ('dbx_business_glossary_term' = 'Delivery Number');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`inbound_delivery` ALTER COLUMN `delivery_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{10,20}$');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`inbound_delivery` ALTER COLUMN `delivery_status` SET TAGS ('dbx_business_glossary_term' = 'Delivery Status');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`inbound_delivery` ALTER COLUMN `destination_plant_code` SET TAGS ('dbx_business_glossary_term' = 'Destination Plant Code');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`inbound_delivery` ALTER COLUMN `destination_plant_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`inbound_delivery` ALTER COLUMN `destination_storage_location` SET TAGS ('dbx_business_glossary_term' = 'Destination Storage Location');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`inbound_delivery` ALTER COLUMN `destination_storage_location` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`inbound_delivery` ALTER COLUMN `dot_hazmat_document_number` SET TAGS ('dbx_business_glossary_term' = 'Department of Transportation (DOT) Hazardous Material Document Number');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`inbound_delivery` ALTER COLUMN `freight_cost` SET TAGS ('dbx_business_glossary_term' = 'Freight Cost');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`inbound_delivery` ALTER COLUMN `freight_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Freight Currency Code');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`inbound_delivery` ALTER COLUMN `freight_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`inbound_delivery` ALTER COLUMN `ghs_hazard_class` SET TAGS ('dbx_business_glossary_term' = 'Globally Harmonized System (GHS) Hazard Class');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`inbound_delivery` ALTER COLUMN `goods_receipt_date` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt Date');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`inbound_delivery` ALTER COLUMN `goods_receipt_number` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt Number');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`inbound_delivery` ALTER COLUMN `gross_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Gross Weight (Kilograms)');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`inbound_delivery` ALTER COLUMN `hazmat_indicator` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Material (HAZMAT) Indicator');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`inbound_delivery` ALTER COLUMN `incoterm` SET TAGS ('dbx_business_glossary_term' = 'International Commercial Terms (Incoterm)');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`inbound_delivery` ALTER COLUMN `inspection_lot_number` SET TAGS ('dbx_business_glossary_term' = 'Inspection Lot Number');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`inbound_delivery` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`inbound_delivery` ALTER COLUMN `net_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Net Weight (Kilograms)');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`inbound_delivery` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Delivery Notes');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`inbound_delivery` ALTER COLUMN `quality_inspection_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Quality Inspection Required Flag');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`inbound_delivery` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`inbound_delivery` ALTER COLUMN `required_temperature_max_c` SET TAGS ('dbx_business_glossary_term' = 'Required Maximum Temperature (Celsius)');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`inbound_delivery` ALTER COLUMN `required_temperature_min_c` SET TAGS ('dbx_business_glossary_term' = 'Required Minimum Temperature (Celsius)');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`inbound_delivery` ALTER COLUMN `scheduled_arrival_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Arrival Date');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`inbound_delivery` ALTER COLUMN `scheduled_arrival_time` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Arrival Time');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`inbound_delivery` ALTER COLUMN `seal_intact_flag` SET TAGS ('dbx_business_glossary_term' = 'Seal Intact Flag');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`inbound_delivery` ALTER COLUMN `seal_number` SET TAGS ('dbx_business_glossary_term' = 'Seal Number');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`inbound_delivery` ALTER COLUMN `temperature_controlled_flag` SET TAGS ('dbx_business_glossary_term' = 'Temperature Controlled Flag');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`inbound_delivery` ALTER COLUMN `transport_equipment_number` SET TAGS ('dbx_business_glossary_term' = 'Transport Equipment Number');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`inbound_delivery` ALTER COLUMN `transport_mode` SET TAGS ('dbx_business_glossary_term' = 'Transport Mode');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`inbound_delivery` ALTER COLUMN `un_number` SET TAGS ('dbx_business_glossary_term' = 'United Nations (UN) Number');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`inbound_delivery` ALTER COLUMN `un_number` SET TAGS ('dbx_value_regex' = '^UN[0-9]{4}$');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`inbound_delivery` ALTER COLUMN `volume_liters` SET TAGS ('dbx_business_glossary_term' = 'Volume (Liters)');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`invoice_verification` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`invoice_verification` SET TAGS ('dbx_subdomain' = 'inbound_logistics');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`invoice_verification` ALTER COLUMN `invoice_verification_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Verification ID');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`invoice_verification` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`invoice_verification` ALTER COLUMN `fiscal_period_id` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`invoice_verification` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`invoice_verification` ALTER COLUMN `goods_receipt_id` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`invoice_verification` ALTER COLUMN `internal_order_id` SET TAGS ('dbx_business_glossary_term' = 'Internal Order Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`invoice_verification` ALTER COLUMN `legal_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`invoice_verification` ALTER COLUMN `payment_term_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Term Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`invoice_verification` ALTER COLUMN `po_line_id` SET TAGS ('dbx_business_glossary_term' = 'Po Line Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`invoice_verification` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`invoice_verification` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`invoice_verification` ALTER COLUMN `usage_decision_id` SET TAGS ('dbx_business_glossary_term' = 'Usage Decision Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`invoice_verification` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`invoice_verification` ALTER COLUMN `baseline_date` SET TAGS ('dbx_business_glossary_term' = 'Baseline Date');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`invoice_verification` ALTER COLUMN `blocking_reason` SET TAGS ('dbx_business_glossary_term' = 'Blocking Reason');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`invoice_verification` ALTER COLUMN `coa_received_flag` SET TAGS ('dbx_business_glossary_term' = 'Certificate of Analysis (COA) Received Flag');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`invoice_verification` ALTER COLUMN `coa_review_status` SET TAGS ('dbx_business_glossary_term' = 'Certificate of Analysis (COA) Review Status');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`invoice_verification` ALTER COLUMN `coa_review_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|approved|rejected|on_hold');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`invoice_verification` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`invoice_verification` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`invoice_verification` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`invoice_verification` ALTER COLUMN `document_date` SET TAGS ('dbx_business_glossary_term' = 'Document Date');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`invoice_verification` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`invoice_verification` ALTER COLUMN `freight_charge` SET TAGS ('dbx_business_glossary_term' = 'Freight Charge');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`invoice_verification` ALTER COLUMN `hazmat_handling_fee` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Material (HAZMAT) Handling Fee');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`invoice_verification` ALTER COLUMN `index_escalator_amount` SET TAGS ('dbx_business_glossary_term' = 'Index Escalator Amount');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`invoice_verification` ALTER COLUMN `invoiced_amount` SET TAGS ('dbx_business_glossary_term' = 'Invoiced Amount');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`invoice_verification` ALTER COLUMN `invoiced_quantity` SET TAGS ('dbx_business_glossary_term' = 'Invoiced Quantity');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`invoice_verification` ALTER COLUMN `material_number` SET TAGS ('dbx_business_glossary_term' = 'Material Number');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`invoice_verification` ALTER COLUMN `payment_block_indicator` SET TAGS ('dbx_business_glossary_term' = 'Payment Block Indicator');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`invoice_verification` ALTER COLUMN `payment_due_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Due Date');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`invoice_verification` ALTER COLUMN `payment_release_by` SET TAGS ('dbx_business_glossary_term' = 'Payment Released By');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`invoice_verification` ALTER COLUMN `payment_release_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Release Date');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`invoice_verification` ALTER COLUMN `plant_code` SET TAGS ('dbx_business_glossary_term' = 'Plant Code');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`invoice_verification` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Date');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`invoice_verification` ALTER COLUMN `posting_status` SET TAGS ('dbx_business_glossary_term' = 'Posting Status');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`invoice_verification` ALTER COLUMN `posting_status` SET TAGS ('dbx_value_regex' = 'draft|posted|reversed|parked|cancelled');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`invoice_verification` ALTER COLUMN `price_variance` SET TAGS ('dbx_business_glossary_term' = 'Price Variance');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`invoice_verification` ALTER COLUMN `quantity_variance` SET TAGS ('dbx_business_glossary_term' = 'Quantity Variance');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`invoice_verification` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`invoice_verification` ALTER COLUMN `tax_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Code');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`invoice_verification` ALTER COLUMN `total_invoice_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Invoice Amount');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`invoice_verification` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`invoice_verification` ALTER COLUMN `verification_document_number` SET TAGS ('dbx_business_glossary_term' = 'Verification Document Number');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`invoice_verification` ALTER COLUMN `verification_status` SET TAGS ('dbx_business_glossary_term' = 'Verification Status');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`invoice_verification` ALTER COLUMN `verification_status` SET TAGS ('dbx_value_regex' = 'pending|verified|rejected|blocked|approved|in_review');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`invoice_verification` ALTER COLUMN `verified_by` SET TAGS ('dbx_business_glossary_term' = 'Verified By');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`invoice_verification` ALTER COLUMN `verified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Verified Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`material_info_record` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`material_info_record` SET TAGS ('dbx_subdomain' = 'procurement_execution');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`material_info_record` ALTER COLUMN `material_info_record_id` SET TAGS ('dbx_business_glossary_term' = 'Material Info Record Identifier (ID)');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`material_info_record` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`material_info_record` ALTER COLUMN `inspection_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Plan Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`material_info_record` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Identifier (ID)');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`material_info_record` ALTER COLUMN `production_plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant Identifier (ID)');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`material_info_record` ALTER COLUMN `safety_data_sheet_id` SET TAGS ('dbx_business_glossary_term' = 'Safety Data Sheet Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`material_info_record` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Identifier (ID)');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`material_info_record` ALTER COLUMN `acknowledgement_required` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Acknowledgement Required Flag');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`material_info_record` ALTER COLUMN `agreement_item_number` SET TAGS ('dbx_business_glossary_term' = 'Agreement Item Number');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`material_info_record` ALTER COLUMN `agreement_item_number` SET TAGS ('dbx_value_regex' = '^[0-9]{5}$');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`material_info_record` ALTER COLUMN `blocked_source` SET TAGS ('dbx_business_glossary_term' = 'Blocked Source Indicator');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`material_info_record` ALTER COLUMN `certificate_of_analysis_required` SET TAGS ('dbx_business_glossary_term' = 'Certificate of Analysis (COA) Required Flag');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`material_info_record` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`material_info_record` ALTER COLUMN `fixed_source` SET TAGS ('dbx_business_glossary_term' = 'Fixed Source Indicator');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`material_info_record` ALTER COLUMN `goods_receipt_required` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt Required Flag');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`material_info_record` ALTER COLUMN `incoterms_code` SET TAGS ('dbx_business_glossary_term' = 'Incoterms Code');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`material_info_record` ALTER COLUMN `incoterms_location` SET TAGS ('dbx_business_glossary_term' = 'Incoterms Location');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`material_info_record` ALTER COLUMN `info_record_category` SET TAGS ('dbx_business_glossary_term' = 'Info Record Category');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`material_info_record` ALTER COLUMN `info_record_category` SET TAGS ('dbx_value_regex' = 'standard|subcontracting|consignment|pipeline');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`material_info_record` ALTER COLUMN `info_record_number` SET TAGS ('dbx_business_glossary_term' = 'Info Record Number');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`material_info_record` ALTER COLUMN `info_record_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{10}$');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`material_info_record` ALTER COLUMN `info_record_status` SET TAGS ('dbx_business_glossary_term' = 'Info Record Status');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`material_info_record` ALTER COLUMN `info_record_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending_approval|expired|blocked');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`material_info_record` ALTER COLUMN `invoice_receipt_required` SET TAGS ('dbx_business_glossary_term' = 'Invoice Receipt Required Flag');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`material_info_record` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`material_info_record` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`material_info_record` ALTER COLUMN `last_purchase_order_date` SET TAGS ('dbx_business_glossary_term' = 'Last Purchase Order (PO) Date');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`material_info_record` ALTER COLUMN `last_purchase_order_price` SET TAGS ('dbx_business_glossary_term' = 'Last Purchase Order (PO) Price');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`material_info_record` ALTER COLUMN `manufacturer_part_number` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Part Number');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`material_info_record` ALTER COLUMN `maximum_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Maximum Order Quantity');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`material_info_record` ALTER COLUMN `minimum_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity (MOQ)');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`material_info_record` ALTER COLUMN `mrp_relevant` SET TAGS ('dbx_business_glossary_term' = 'Material Requirements Planning (MRP) Relevant Flag');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`material_info_record` ALTER COLUMN `net_price_indicator` SET TAGS ('dbx_business_glossary_term' = 'Net Price Indicator');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`material_info_record` ALTER COLUMN `order_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Order Unit of Measure (UOM)');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`material_info_record` ALTER COLUMN `order_unit_of_measure` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,3}$');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`material_info_record` ALTER COLUMN `over_delivery_tolerance_pct` SET TAGS ('dbx_business_glossary_term' = 'Over-Delivery Tolerance Percentage');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`material_info_record` ALTER COLUMN `planned_delivery_time_days` SET TAGS ('dbx_business_glossary_term' = 'Planned Delivery Time in Days');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`material_info_record` ALTER COLUMN `price_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Price Currency Code');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`material_info_record` ALTER COLUMN `price_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`material_info_record` ALTER COLUMN `price_unit` SET TAGS ('dbx_business_glossary_term' = 'Price Unit Quantity');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`material_info_record` ALTER COLUMN `purchasing_group` SET TAGS ('dbx_business_glossary_term' = 'Purchasing Group Code');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`material_info_record` ALTER COLUMN `purchasing_group` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3}$');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`material_info_record` ALTER COLUMN `purchasing_organization` SET TAGS ('dbx_business_glossary_term' = 'Purchasing Organization Code');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`material_info_record` ALTER COLUMN `purchasing_organization` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`material_info_record` ALTER COLUMN `quality_inspection_required` SET TAGS ('dbx_business_glossary_term' = 'Quality Inspection Required Flag');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`material_info_record` ALTER COLUMN `reach_compliance_required` SET TAGS ('dbx_business_glossary_term' = 'Registration Evaluation Authorization and Restriction of Chemicals (REACH) Compliance Required Flag');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`material_info_record` ALTER COLUMN `safety_data_sheet_required` SET TAGS ('dbx_business_glossary_term' = 'Safety Data Sheet (SDS) Required Flag');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`material_info_record` ALTER COLUMN `source_list_record` SET TAGS ('dbx_business_glossary_term' = 'Source List Record Flag');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`material_info_record` ALTER COLUMN `standard_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Standard Order Quantity');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`material_info_record` ALTER COLUMN `standard_price` SET TAGS ('dbx_business_glossary_term' = 'Standard Price');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`material_info_record` ALTER COLUMN `supplier_material_number` SET TAGS ('dbx_business_glossary_term' = 'Supplier Material Number');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`material_info_record` ALTER COLUMN `tax_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Code');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`material_info_record` ALTER COLUMN `tax_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2}$');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`material_info_record` ALTER COLUMN `under_delivery_tolerance_pct` SET TAGS ('dbx_business_glossary_term' = 'Under-Delivery Tolerance Percentage');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`material_info_record` ALTER COLUMN `unlimited_over_delivery` SET TAGS ('dbx_business_glossary_term' = 'Unlimited Over-Delivery Flag');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`material_info_record` ALTER COLUMN `validity_end_date` SET TAGS ('dbx_business_glossary_term' = 'Validity End Date');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`material_info_record` ALTER COLUMN `validity_start_date` SET TAGS ('dbx_business_glossary_term' = 'Validity Start Date');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`material_info_record` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
