-- Schema for Domain: supply | Business: Chemical Mfg | Version: v1_ecm
-- Generated on: 2026-05-06 12:33:23

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `chemical_mfg_ecm`.`supply` COMMENT 'Governs end-to-end supply chain network including supplier master data, purchase orders (PO), ASN tracking, vendor performance scorecards, supply risk management, procurement planning, RFQ processes, contract pricing with chemical suppliers, supplier qualification and audits, and inbound logistics coordination. Integrates with SAP MM and Oracle Transportation Management.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`supply`.`vendor` (
    `vendor_id` BIGINT COMMENT 'Unique identifier for the vendor record. Primary key.',
    `strategy_id` BIGINT COMMENT 'Foreign key linking to pricing.pricing_strategy. Business justification: Vendor‑specific pricing strategy governs margin targets and cost components for all procurements from that vendor.',
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
    `account_id` BIGINT COMMENT 'Foreign key linking to customer.account. Business justification: POs are cost‑allocated to the originating customer account; financial reporting and charge‑back require this link.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: PROCUREMENT: PO creation requires a buyer employee for approval workflow and audit reporting; buyer details are already captured as name/email.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Required for PO expense charging; finance cost center needed for budgeting and actual spend reporting per purchase order.',
    `internal_order_id` BIGINT COMMENT 'Foreign key linking to finance.internal_order. Business justification: Allocates PO costs to internal orders for project accounting and cost tracking in financial systems.',
    `plant_id` BIGINT COMMENT 'Unique identifier of the manufacturing plant or facility where the ordered materials will be received and used.',
    `price_list_id` BIGINT COMMENT 'Foreign key linking to pricing.price_list. Business justification: Purchase orders reference the price list used to derive line prices, required for audit and variance analysis.',
    `project_id` BIGINT COMMENT 'Foreign key linking to research.project. Business justification: Project spend tracking report requires linking each PO to the research project it funds.',
    `vendor_id` BIGINT COMMENT 'Unique identifier of the chemical supplier or service provider to whom this purchase order is issued.',
    `approval_status` STRING COMMENT 'Current approval workflow status: not_required (no approval needed), pending (awaiting approver action), approved (all approvals obtained), rejected (approval denied).. Valid values are `not_required|pending|approved|rejected`',
    `approved_by` STRING COMMENT 'User ID or name of the person who provided final approval for the purchase order release.',
    `approved_date` DATE COMMENT 'Date when the purchase order received final approval and was authorized for release to the vendor.',
    `company_code` STRING COMMENT 'Legal entity or company code in SAP FI/CO to which this purchase order is assigned for financial accounting and reporting purposes.. Valid values are `^[A-Z0-9]{4}$`',
    `contract_number` STRING COMMENT 'Reference number of the master contract or framework agreement under which this purchase order is issued, if applicable.',
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
    `experimental_formulation_id` BIGINT COMMENT 'Foreign key linking to research.experimental_formulation. Business justification: Formulation cost allocation needs each PO line to reference the experimental formulation using the material.',
    `material_master_id` BIGINT COMMENT 'Foreign key reference to the material master record representing the raw material or chemical substance being procured on this line.',
    `price_list_item_id` BIGINT COMMENT 'Foreign key linking to pricing.price_list_item. Business justification: Each PO line is priced from a specific price‑list item; linking enables traceability to the exact price record.',
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
    `site_id` BIGINT COMMENT 'Foreign key linking to customer.site. Business justification: Receipt quality and inventory allocation are tracked per customer site; essential for site‑level stock reconciliation.',
    `inspection_lot_id` BIGINT COMMENT 'Foreign key linking to quality.inspection_lot. Business justification: Goods receipt initiates a quality inspection lot; linking enables the inspection‑lot‑based quality report.',
    `lab_experiment_id` BIGINT COMMENT 'Foreign key linking to research.lab_experiment. Business justification: Lab material consumption tracking links each goods receipt to the specific lab experiment that used the material.',
    `material_master_id` BIGINT COMMENT 'Reference to the raw material or chemical product received. Links to material master data.',
    `plant_id` BIGINT COMMENT 'Reference to the manufacturing plant or facility where the goods were received.',
    `purchase_order_id` BIGINT COMMENT 'Reference to the purchase order against which this goods receipt is posted. Links to the originating procurement document.',
    `employee_id` BIGINT COMMENT 'The employee identifier of the person who performed the goods receipt. Used for audit trail and accountability.',
    `vendor_id` BIGINT COMMENT 'Reference to the supplier or vendor from whom the materials were received. Links to vendor master data.',
    `warehouse_location_id` BIGINT COMMENT 'Reference to the specific storage location or warehouse area where the received materials are stored.',
    `asn_number` STRING COMMENT 'The Advanced Shipping Notice number sent by the vendor prior to shipment arrival. Used for dock scheduling and receiving preparation.. Valid values are `^[A-Z0-9-]{8,20}$`',
    `batch_number` STRING COMMENT 'The lot or batch number assigned to the received material shipment. Critical for traceability, quality control, and recall management in chemical manufacturing.. Valid values are `^[A-Z0-9]{6,20}$`',
    `carrier_name` STRING COMMENT 'The name of the transportation carrier or logistics provider that delivered the shipment to the receiving location.',
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
    `sds_version` STRING COMMENT 'The version number of the Safety Data Sheet (formerly MSDS) on file for the received chemical. Must be current per OSHA Hazard Communication Standard.. Valid values are `^[0-9]{1,3}.[0-9]{1,2}$`',
    `seal_intact_flag` BOOLEAN COMMENT 'Boolean indicator specifying whether the security seal was found intact upon arrival. False value triggers security investigation.',
    `seal_number` STRING COMMENT 'The security seal number applied to the shipment container or truck. Verified upon receipt to ensure shipment integrity and prevent tampering.. Valid values are `^[A-Z0-9]{6,15}$`',
    `stock_type` STRING COMMENT 'The inventory stock type to which the received goods are posted. Quality inspection stock requires QC release before use; blocked stock cannot be used.. Valid values are `unrestricted|quality_inspection|blocked|restricted`',
    `temperature_on_arrival_c` DECIMAL(18,2) COMMENT 'The measured temperature of the material shipment upon arrival at the receiving dock, recorded in degrees Celsius. Critical for temperature-sensitive chemicals and compliance with storage specifications.',
    `un_number` STRING COMMENT 'The four-digit UN identification number for hazardous materials, used for transportation and storage classification (e.g., UN1090 for acetone).. Valid values are `^UN[0-9]{4}$`',
    `unit_of_measure` STRING COMMENT 'The unit of measure in which the received quantity is expressed (e.g., kilograms, liters, metric tons, gallons). [ENUM-REF-CANDIDATE: KG|L|MT|GAL|LB|TON|M3|EA|BOX|DRUM|PALLET — 11 candidates stripped; promote to reference product]',
    `valuation_amount` DECIMAL(18,2) COMMENT 'The total monetary value of the goods receipt transaction, calculated based on purchase order price and received quantity. Posted to inventory and financial accounts.',
    `vehicle_identification` STRING COMMENT 'The truck number, container number, or other vehicle identification used for the delivery. Important for hazardous material tracking and security.',
    CONSTRAINT pk_goods_receipt PRIMARY KEY(`goods_receipt_id`)
) COMMENT 'Records the physical receipt of raw materials and chemicals at the plant gate or warehouse dock against a purchase order. Captures GR document number, GR date, vendor, material, received quantity, unit of measure, storage location, batch number (LOT), movement type, quality inspection flag, COA received flag, temperature on arrival, and SAP material document number. Triggers QC inspection workflow in LIMS. Integrates with SAP MM MIGO/MSEG.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`supply`.`asn` (
    `asn_id` BIGINT COMMENT 'Unique identifier for the Advanced Shipping Notice record.',
    `purchase_order_id` BIGINT COMMENT 'Reference to the purchase order against which this shipment is being delivered.',
    `vendor_id` BIGINT COMMENT 'Identifier of the chemical supplier sending the shipment.',
    `actual_arrival_timestamp` TIMESTAMP COMMENT 'Actual date and time when the shipment physically arrived at the receiving facility.',
    `asn_number` STRING COMMENT 'Externally-known unique ASN document number provided by the supplier.. Valid values are `^ASN-[A-Z0-9]{8,15}$`',
    `asn_status` STRING COMMENT 'Current lifecycle status of the ASN in the receiving workflow. [ENUM-REF-CANDIDATE: draft|transmitted|in_transit|arrived|receiving|completed|cancelled — 7 candidates stripped; promote to reference product]',
    `asn_type` STRING COMMENT 'Classification of the ASN based on shipment characteristics and handling requirements.. Valid values are `standard|expedited|hazmat|bulk|consignment|drop_ship`',
    `bill_of_lading_number` STRING COMMENT 'Unique document number issued by the carrier as receipt of goods for shipment.. Valid values are `^BOL-[A-Z0-9]{8,20}$`',
    `carrier_name` STRING COMMENT 'Name of the transportation carrier responsible for delivering the shipment.',
    `carrier_scac_code` STRING COMMENT 'Four-letter code uniquely identifying the transportation carrier.. Valid values are `^[A-Z]{2,4}$`',
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
    `shipping_point_code` STRING COMMENT 'Code identifying the vendor facility or warehouse from which the shipment originated.. Valid values are `^[A-Z0-9]{4,10}$`',
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

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`supply`.`asn_line` (
    `asn_line_id` BIGINT COMMENT 'Unique identifier for the ASN line item. Primary key for the ASN line entity.',
    `asn_id` BIGINT COMMENT 'Foreign key reference to the parent ASN header document. Links this line item to its containing shipment notice.',
    `experimental_formulation_id` BIGINT COMMENT 'Foreign key linking to research.experimental_formulation. Business justification: Shipment planning for a formulation requires ASN lines to reference the experimental formulation they supply.',
    `material_master_id` BIGINT COMMENT 'Reference to the material master record for the chemical product being shipped. Links to the material catalog.',
    `purchase_order_id` BIGINT COMMENT 'Reference to the purchase order that this ASN line is fulfilling. Enables reconciliation between ordered and shipped quantities.',
    `batch_number` STRING COMMENT 'Manufacturer batch or lot number for the shipped material. Critical for traceability, quality control, and recall management in chemical manufacturing.',
    `cas_number` STRING COMMENT 'Unique numerical identifier assigned by Chemical Abstracts Service to every chemical substance. Critical for regulatory compliance, safety documentation, and material identification.. Valid values are `^[1-9][0-9]{1,6}-[0-9]{2}-[0-9]$`',
    `coa_number` STRING COMMENT 'Reference number for the Certificate of Analysis document that accompanies this material shipment. Links to quality test results and specifications compliance.',
    `coc_number` STRING COMMENT 'Reference number for the Certificate of Compliance document certifying the material meets regulatory and specification requirements.',
    `country_of_origin` STRING COMMENT 'Three-letter ISO country code indicating where the chemical material was manufactured. Required for customs clearance, trade compliance, and regulatory reporting.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this ASN line record was first created in the system. Audit trail for data lineage and compliance.',
    `currency_code` STRING COMMENT 'Three-letter ISO currency code for the line value amount. Enables multi-currency procurement and financial reporting.. Valid values are `^[A-Z]{3}$`',
    `delivery_note_number` STRING COMMENT 'Supplier delivery note or packing slip number associated with this shipment line. Used for cross-referencing supplier documentation.',
    `expiry_date` DATE COMMENT 'Date after which the chemical material should not be used due to degradation or regulatory restrictions. Critical for FEFO inventory management and quality assurance.',
    `flash_point_celsius` DECIMAL(18,2) COMMENT 'Lowest temperature at which the chemical can vaporize to form an ignitable mixture in air. Critical safety parameter for flammable materials storage and handling.',
    `gross_weight` DECIMAL(18,2) COMMENT 'Total weight including chemical material and packaging. Used for freight calculations, warehouse capacity planning, and transportation compliance.',
    `hazard_class` STRING COMMENT 'DOT or UN hazard classification for the chemical material. Determines transportation requirements, storage restrictions, and emergency response procedures.',
    `inspection_required_flag` BOOLEAN COMMENT 'Indicates whether this material shipment requires quality inspection upon receipt before being released to inventory. Drives goods receipt workflow.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this ASN line record was last updated. Tracks changes for audit and data quality monitoring.',
    `line_number` STRING COMMENT 'Sequential line item number within the ASN document. Determines the ordering and position of this line in the shipment notice.',
    `line_value_amount` DECIMAL(18,2) COMMENT 'Monetary value of this ASN line item based on purchase order pricing. Used for goods receipt valuation and inventory accounting.',
    `lot_number` STRING COMMENT 'Supplier lot number for the material shipment. May differ from internal batch number and is used for supplier traceability and quality investigations.',
    `manufacturing_date` DATE COMMENT 'Date when the chemical material was manufactured or formulated by the supplier. Used to calculate shelf life and support quality investigations.',
    `material_description` STRING COMMENT 'Full text description of the chemical material including grade, purity, and key characteristics. Provides human-readable context for the material.',
    `material_number` STRING COMMENT 'Business identifier for the chemical material being shipped. Human-readable material code used across procurement and production systems.',
    `net_weight` DECIMAL(18,2) COMMENT 'Net weight of the chemical material excluding packaging. Used for inventory valuation, yield calculations, and regulatory reporting.',
    `number_of_packages` STRING COMMENT 'Total count of individual packages or containers for this ASN line item. Used for receiving verification and warehouse space planning.',
    `packaging_type` STRING COMMENT 'Type of container or packaging used for shipping the chemical material. Critical for handling instructions, storage planning, and safety protocols. [ENUM-REF-CANDIDATE: DRUM|IBC|TANKER|BAG|BOTTLE|CARBOY|PAIL|TOTE|CYLINDER|BULK — 10 candidates stripped; promote to reference product]',
    `packing_group` STRING COMMENT 'UN packing group indicating the degree of danger for hazardous materials. Group I is high danger, II is medium, III is low. Determines packaging and handling requirements.. Valid values are `I|II|III`',
    `po_line_number` STRING COMMENT 'Specific line item number on the purchase order that this ASN line corresponds to. Enables line-level PO-to-ASN reconciliation.',
    `quarantine_status` STRING COMMENT 'Quality control status indicating whether the material is released for use, held in quarantine pending inspection, rejected, or awaiting quality decision.. Valid values are `RELEASED|QUARANTINE|REJECTED|PENDING`',
    `reach_registration_number` STRING COMMENT 'REACH registration number for the chemical substance as required by European chemicals regulation. Mandatory for chemicals imported into or manufactured in the EU above threshold tonnages.',
    `sds_revision_date` DATE COMMENT 'Date when the Safety Data Sheet was last revised. Critical for ensuring compliance with current hazard communication requirements.',
    `sds_version` STRING COMMENT 'Version number of the Safety Data Sheet applicable to this material shipment. Ensures receiving facility has current safety and handling information.',
    `shipped_quantity` DECIMAL(18,2) COMMENT 'Quantity of material being shipped on this ASN line. Represents the actual amount dispatched by the supplier for this line item.',
    `storage_temperature_max_celsius` DECIMAL(18,2) COMMENT 'Maximum temperature at which the chemical material can be stored without degradation. Defines upper bound for warehouse climate control.',
    `storage_temperature_min_celsius` DECIMAL(18,2) COMMENT 'Minimum temperature at which the chemical material must be stored to maintain stability and quality. Defines lower bound for warehouse climate control.',
    `un_number` STRING COMMENT 'Four-digit UN identification number for hazardous materials transport. Required for shipping documentation and emergency response planning.. Valid values are `^UN[0-9]{4}$`',
    `unit_of_measure` STRING COMMENT 'Unit in which the shipped quantity is expressed. Common chemical industry units include kilograms, liters, metric tons, gallons, drums, and intermediate bulk containers. [ENUM-REF-CANDIDATE: KG|L|MT|GAL|LB|TON|M3|EA|DR|IBC — 10 candidates stripped; promote to reference product]',
    `volume` DECIMAL(18,2) COMMENT 'Volume of the chemical material being shipped. Particularly important for liquid chemicals and storage capacity planning.',
    `volume_unit_of_measure` STRING COMMENT 'Unit of measure for volume values. Standardizes volume reporting for liquid chemical shipments.. Valid values are `L|GAL|M3|ML`',
    `weight_unit_of_measure` STRING COMMENT 'Unit of measure for net and gross weight values. Standardizes weight reporting across international shipments.. Valid values are `KG|LB|MT|TON`',
    CONSTRAINT pk_asn_line PRIMARY KEY(`asn_line_id`)
) COMMENT 'Individual material line items within an Advanced Shipping Notice. Captures ASN line number, material number, CAS number, shipped quantity, unit of measure, batch/lot number, expiry date, country of origin, REACH registration number, SDS version reference, packaging type (drum, IBC, tanker, bag), and net/gross weight per line. Enables line-level receiving reconciliation against PO lines.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`supply`.`rfq` (
    `rfq_id` BIGINT COMMENT 'Unique identifier for the request for quotation record. Primary key.',
    `awarded_date` DATE COMMENT 'Date when the RFQ was awarded to the selected supplier. Marks the transition from evaluation to contracting phase.',
    `awarded_price` DECIMAL(18,2) COMMENT 'Final negotiated unit price from the winning supplier. Confidential business data used for cost analysis and future price benchmarking.',
    `awarded_supplier_code` STRING COMMENT 'Vendor code of the supplier who was awarded the business after evaluation. Null if RFQ is not yet awarded or was cancelled.. Valid values are `^[A-Z0-9]{6,10}$`',
    `buyer_email` STRING COMMENT 'Email address of the buyer for supplier communication and clarification requests. Organizational contact data classified as confidential.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `buyer_name` STRING COMMENT 'Name of the procurement specialist or buyer who created and is managing this RFQ. Business reference, not direct PII.',
    `buyer_phone` STRING COMMENT 'Phone number of the buyer for urgent supplier inquiries. Organizational contact data classified as confidential.',
    `cas_number` STRING COMMENT 'Unique numerical identifier assigned by the Chemical Abstracts Service to every chemical substance. Used for precise chemical identification in procurement and regulatory compliance.. Valid values are `^[0-9]{2,7}-[0-9]{2}-[0-9]$`',
    `closed_timestamp` TIMESTAMP COMMENT 'Timestamp when the RFQ was closed (either awarded or cancelled). Marks the end of the RFQ lifecycle. Null if still open.',
    `contract_number` STRING COMMENT 'Contract or framework agreement number if the RFQ resulted in a long-term supply agreement. Null for spot purchases.. Valid values are `^CTR-[0-9]{8,12}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this RFQ record was first created in the system. Used for audit trail and process cycle time analysis.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for pricing (e.g., USD, EUR, GBP, CNY). Suppliers must quote prices in this currency.. Valid values are `^[A-Z]{3}$`',
    `delivery_address` STRING COMMENT 'Full physical address where the material should be delivered, including street, city, state, postal code, and country. Organizational contact data classified as confidential.',
    `delivery_plant_code` STRING COMMENT 'Code identifying the manufacturing plant or warehouse where the material should be delivered. Links to plant master data.. Valid values are `^[A-Z0-9]{4,10}$`',
    `evaluation_criteria` STRING COMMENT 'Detailed criteria that will be used to evaluate and compare supplier quotations, such as price (weight 40%), lead time (20%), quality certifications (20%), payment terms (10%), supplier track record (10%). May include scoring methodology.',
    `incoterm` STRING COMMENT 'Standard trade terms defining responsibilities for shipping, insurance, and risk transfer between buyer and seller. Examples: EXW (Ex Works), FOB (Free on Board), CIF (Cost Insurance Freight), DDP (Delivered Duty Paid). [ENUM-REF-CANDIDATE: EXW|FCA|CPT|CIP|DAP|DPU|DDP|FAS|FOB|CFR|CIF — 11 candidates stripped; promote to reference product]',
    `issue_date` DATE COMMENT 'Date when the RFQ was officially issued and sent to suppliers. Marks the start of the quotation solicitation period.',
    `material_code` STRING COMMENT 'Internal material master code for the chemical or raw material being sourced. Links to material master data in SAP MM.. Valid values are `^[A-Z0-9]{6,18}$`',
    `material_description` STRING COMMENT 'Detailed description of the chemical material being sourced, including grade, purity, form (liquid, powder, granular), and any special specifications.',
    `minimum_order_quantity` DECIMAL(18,2) COMMENT 'Minimum quantity that suppliers must be willing to supply. Used to filter suppliers who cannot meet minimum volume requirements.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this RFQ record was last modified. Used for audit trail and change tracking.',
    `notes` STRING COMMENT 'Free-text field for additional instructions, special requirements, clarifications, or internal notes related to the RFQ process.',
    `payment_terms` STRING COMMENT 'Standard payment terms requested from suppliers, such as Net 30, Net 60, 2/10 Net 30 (2% discount if paid within 10 days, otherwise net 30 days), or advance payment requirements.',
    `purchase_order_number` STRING COMMENT 'Purchase order number generated after RFQ award. Links the RFQ to the resulting procurement transaction. Null if no PO has been created yet.. Valid values are `^PO-[0-9]{8,12}$`',
    `purchasing_group` STRING COMMENT 'Code identifying the buyer or procurement team responsible for this RFQ. Used for workload distribution and accountability.. Valid values are `^[A-Z0-9]{3,6}$`',
    `purchasing_organization` STRING COMMENT 'Code identifying the organizational unit responsible for procurement activities. Links to organizational hierarchy in SAP MM.. Valid values are `^[A-Z0-9]{4,10}$`',
    `quality_requirements` STRING COMMENT 'Quality standards and certifications required from suppliers, such as ISO 9001, GMP (Good Manufacturing Practice), REACH compliance, specific test methods, and Certificate of Analysis (COA) requirements.',
    `reach_compliance_required_flag` BOOLEAN COMMENT 'Indicates whether the material must comply with EU REACH regulation. True if REACH compliance documentation is mandatory, False if not applicable (e.g., non-EU supply).',
    `requested_quantity` DECIMAL(18,2) COMMENT 'Total quantity of material requested in the RFQ. Used by suppliers to calculate pricing and assess capacity to fulfill the order.',
    `required_delivery_date` DATE COMMENT 'Target date by which the material must be delivered to the plant. Used to evaluate supplier lead times and logistics capabilities.',
    `response_count` STRING COMMENT 'Number of quotation responses received from suppliers. Used to calculate response rate and assess market interest.',
    `rfq_number` STRING COMMENT 'Business identifier for the RFQ, externally visible to suppliers and internal procurement teams. Typically follows format RFQ-YYYYMMDD-NNNN.. Valid values are `^RFQ-[0-9]{8,12}$`',
    `rfq_status` STRING COMMENT 'Current lifecycle status of the RFQ: draft (being prepared), issued (sent to suppliers), open (accepting responses), under_evaluation (responses being reviewed), awarded (supplier selected), closed (process complete), cancelled (RFQ withdrawn). [ENUM-REF-CANDIDATE: draft|issued|open|under_evaluation|awarded|closed|cancelled — 7 candidates stripped; promote to reference product]',
    `rfq_type` STRING COMMENT 'Classification of the RFQ based on procurement strategy: spot buy for one-time purchases, annual contract bid for long-term agreements, emergency source for urgent needs, framework agreement for multi-year supply, trial order for new supplier evaluation, bulk purchase for volume discounts.. Valid values are `spot_buy|annual_contract_bid|emergency_source|framework_agreement|trial_order|bulk_purchase`',
    `sds_required_flag` BOOLEAN COMMENT 'Indicates whether suppliers must provide a current Safety Data Sheet (SDS) compliant with GHS (Globally Harmonized System) standards with their quotation. True if SDS is mandatory, False if not required.',
    `submission_deadline` TIMESTAMP COMMENT 'Date and time by which suppliers must submit their quotation responses. Late submissions may be rejected or evaluated separately.',
    `supplier_count` STRING COMMENT 'Number of suppliers to whom this RFQ was sent. Used to track competitive bidding scope and response rate analysis.',
    `technical_specifications` STRING COMMENT 'Detailed technical requirements for the material including purity levels, physical properties, packaging requirements, shelf life, storage conditions, and any industry-specific quality standards (GMP, ISO, REACH compliance).',
    `tsca_compliance_required_flag` BOOLEAN COMMENT 'Indicates whether the material must be listed on the EPA TSCA inventory for use in the United States. True if TSCA compliance is mandatory, False if not applicable.',
    `unit_of_measure` STRING COMMENT 'Standard unit of measure for the requested quantity: KG (kilogram), MT (metric ton), L (liter), GAL (gallon), LB (pound), TON (ton), M3 (cubic meter), DRUM, IBC (intermediate bulk container), BAG. [ENUM-REF-CANDIDATE: KG|MT|L|GAL|LB|TON|M3|DRUM|IBC|BAG — 10 candidates stripped; promote to reference product]',
    CONSTRAINT pk_rfq PRIMARY KEY(`rfq_id`)
) COMMENT 'Request for Quotation issued to chemical suppliers and the full vendor response lifecycle, covering solicitation through award. Captures RFQ number, type (spot buy, annual contract bid, emergency source), materials/CAS numbers, required quantities, submission deadline, and evaluation criteria. Includes all vendor quotation responses: quoted prices, price validity periods, lead times, MOQs, payment terms, incoterms, technical compliance notes, SDS availability confirmation, REACH compliance statements, and response evaluation status (submitted, under evaluation, accepted, rejected). Supports strategic sourcing events, competitive bid analysis, and supplier selection. Integrates with SAP MM ME41/ME47.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`supply`.`rfq_response` (
    `rfq_response_id` BIGINT COMMENT 'Unique identifier for the vendor quotation response submitted in reply to a chemical raw material or service RFQ.',
    `rfq_id` BIGINT COMMENT 'Reference to the originating RFQ document that this response addresses.',
    `vendor_id` BIGINT COMMENT 'Reference to the supplier or vendor submitting this quotation response.',
    `acceptance_date` DATE COMMENT 'Date when the procurement team formally accepted the quotation response and selected the vendor for award.',
    `cas_number` STRING COMMENT 'CAS registry number uniquely identifying the chemical substance being quoted, in format XXXXXX-XX-X.. Valid values are `^d{2,7}-d{2}-d$`',
    `coa_provided_flag` BOOLEAN COMMENT 'Indicates whether the vendor will provide a Certificate of Analysis with each shipment documenting quality test results.',
    `coc_provided_flag` BOOLEAN COMMENT 'Indicates whether the vendor will provide a Certificate of Compliance documenting regulatory and specification adherence.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this RFQ response record was first created in the procurement system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the quoted price (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `delivery_location` STRING COMMENT 'Named location or address where the vendor will deliver the chemical materials as specified in the Incoterms.',
    `evaluation_notes` STRING COMMENT 'Internal procurement team notes documenting the evaluation rationale, strengths, weaknesses, and decision factors for this response.',
    `evaluation_score` DECIMAL(18,2) COMMENT 'Composite score assigned by the procurement team during competitive bid analysis, based on price, quality, lead time, and compliance factors.',
    `incoterms` STRING COMMENT 'Incoterms code defining the delivery terms and transfer of risk (e.g., EXW, FOB, CIF, DDP) per ICC standards.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'System timestamp when this RFQ response record was last updated, tracking changes to status, evaluation, or vendor revisions.',
    `material_grade` STRING COMMENT 'Grade or quality specification of the chemical material being quoted (e.g., technical grade, pharmaceutical grade, food grade, reagent grade).',
    `minimum_order_quantity` DECIMAL(18,2) COMMENT 'Minimum quantity that must be ordered for the vendor to accept the purchase order at the quoted price.',
    `moq_unit_of_measure` STRING COMMENT 'Unit of measure for the minimum order quantity (e.g., kilogram, liter, drum, pallet).',
    `packaging_size` STRING COMMENT 'Size or capacity of the packaging unit (e.g., 200L drum, 1000L IBC, 25kg bag).',
    `packaging_type` STRING COMMENT 'Type of packaging in which the chemical material will be delivered (e.g., drum, IBC tote, bulk tanker, bag, cylinder).',
    `payment_terms` STRING COMMENT 'Payment terms proposed by the vendor (e.g., Net 30, Net 60, 2/10 Net 30, advance payment, letter of credit).',
    `price_unit_of_measure` STRING COMMENT 'Unit of measure for the quoted price (e.g., per kilogram, per liter, per metric ton, per drum).',
    `price_validity_end_date` DATE COMMENT 'Date until which the quoted price remains valid, after which the vendor may revise pricing.',
    `price_validity_start_date` DATE COMMENT 'Date from which the quoted price becomes valid and can be applied to purchase orders.',
    `purity_percentage` DECIMAL(18,2) COMMENT 'Guaranteed minimum purity of the chemical material expressed as a percentage (e.g., 99.5% purity).',
    `quoted_lead_time_days` STRING COMMENT 'Number of calendar days from purchase order placement to delivery, as committed by the vendor.',
    `quoted_price` DECIMAL(18,2) COMMENT 'Unit price quoted by the vendor for the requested chemical raw material or service.',
    `reach_compliant_flag` BOOLEAN COMMENT 'Indicates whether the vendor has confirmed that the quoted chemical material complies with EU REACH regulation.',
    `rejection_reason` STRING COMMENT 'Reason code or description explaining why the quotation response was rejected (e.g., non-competitive pricing, non-compliance, excessive lead time).',
    `response_number` STRING COMMENT 'Business identifier for the vendor quotation response, typically assigned by the vendor or procurement system.',
    `response_status` STRING COMMENT 'Current lifecycle status of the RFQ response in the procurement evaluation workflow.. Valid values are `submitted|under_evaluation|accepted|rejected|withdrawn|expired`',
    `sds_available_flag` BOOLEAN COMMENT 'Indicates whether the vendor has confirmed availability of a current Safety Data Sheet for the quoted chemical material.',
    `shelf_life_months` STRING COMMENT 'Guaranteed shelf life of the chemical material from manufacturing date, expressed in months.',
    `submission_date` DATE COMMENT 'Date when the vendor submitted the quotation response to the procurement team.',
    `submission_timestamp` TIMESTAMP COMMENT 'Precise date and time when the vendor submitted the quotation response, used for deadline compliance verification.',
    `technical_compliance_notes` STRING COMMENT 'Vendor notes addressing technical specifications, quality standards, and compliance with RFQ requirements.',
    `tsca_compliant_flag` BOOLEAN COMMENT 'Indicates whether the vendor has confirmed that the quoted chemical material is listed on the TSCA inventory for US market.',
    `vendor_contact_email` STRING COMMENT 'Email address of the vendor representative for correspondence regarding this quotation response.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `vendor_contact_name` STRING COMMENT 'Name of the vendor representative who submitted the quotation and serves as the primary contact for this response.',
    `vendor_contact_phone` STRING COMMENT 'Phone number of the vendor representative for direct communication regarding this quotation response.',
    CONSTRAINT pk_rfq_response PRIMARY KEY(`rfq_response_id`)
) COMMENT 'Vendor quotation submitted in response to an RFQ for chemical raw materials or services. Captures response number, vendor, RFQ reference, quoted price, price validity period, quoted lead time, MOQ, payment terms, incoterms, technical compliance notes, SDS availability confirmation, REACH compliance statement, and response status (submitted, under evaluation, accepted, rejected). Supports competitive bid analysis and supplier selection.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`supply`.`contract` (
    `contract_id` BIGINT COMMENT 'Primary key for contract',
    `account_id` BIGINT COMMENT 'Foreign key linking to customer.account. Business justification: Vendor contracts are negotiated per customer account; contract management dashboards need this link.',
    `material_master_id` BIGINT COMMENT 'FK to rawmaterial.material_master',
    `contract_material_material_master_id` BIGINT COMMENT 'FK to rawmaterial.material_master',
    `opportunity_id` BIGINT COMMENT 'Foreign key linking to sales.opportunity. Business justification: Vendor contracts are tied to the originating sales opportunity for revenue attribution and compliance reporting.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: CONTRACT MGMT: Ownership of a contract is assigned to a procurement employee; needed for contract performance dashboards.',
    `price_list_id` BIGINT COMMENT 'Foreign key linking to pricing.price_list. Business justification: Contract pricing process requires linking each vendor contract to the agreed price list for accurate cost calculation.',
    `primary_contract_material_master_id` BIGINT COMMENT 'Reference to the primary chemical raw material or product covered by this contract. For multi-material contracts, this represents the primary or representative material.',
    `project_id` BIGINT COMMENT 'Foreign key linking to research.project. Business justification: Supply contracts are often scoped to a specific research project; linking enables contract‑project compliance reporting.',
    `vendor_id` BIGINT COMMENT 'Reference to the chemical supplier or raw material vendor party with whom this contract is established.',
    `vendor_site_id` BIGINT COMMENT 'Reference to the specific vendor location or plant from which materials will be supplied under this contract.',
    `approval_date` DATE COMMENT 'Date when the contract was formally approved by authorized signatories and became legally binding.',
    `approved_by_name` STRING COMMENT 'Name of the executive or manager who provided final approval for this contract.',
    `auto_renewal_flag` BOOLEAN COMMENT 'Indicates whether the contract automatically renews for another term if not explicitly terminated before the end date. True = auto-renews, False = expires at end date.',
    `cas_number` STRING COMMENT 'Unique numerical identifier assigned by the Chemical Abstracts Service to every chemical substance described in the open scientific literature. Used for regulatory compliance and material identification.. Valid values are `^[0-9]{2,7}-[0-9]{2}-[0-9]$`',
    `company_code` STRING COMMENT 'Legal entity or company code in SAP FI/CO that owns this contract for financial reporting purposes.',
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
    `plant_code` STRING COMMENT 'Manufacturing plant or facility for which this contract supplies materials. Four-character SAP plant code.',
    `price_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the contracted price (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `price_escalation_clause` STRING COMMENT 'Description of price adjustment mechanism tied to market indices, inflation rates, or raw material cost changes (e.g., quarterly adjustment based on PPI Chemical Index).',
    `price_per_unit` DECIMAL(18,2) COMMENT 'Base contracted price per unit of measure. For contracts with price scales or condition-based pricing, this represents the baseline or reference price.',
    `price_unit` STRING COMMENT 'Quantity unit for which the price is specified (e.g., price per 1, per 100, per 1000 units). Used in SAP pricing to handle fractional pricing.',
    `purchasing_group` STRING COMMENT 'Buyer or procurement team responsible for managing this contract. Typically a three-character code in SAP MM.',
    `purchasing_organization` STRING COMMENT 'SAP organizational unit responsible for procurement activities and contract negotiation. Typically a four-character code.',
    `quality_specification` STRING COMMENT 'Reference to quality standards, specifications, or Certificate of Analysis (COA) requirements that the supplied material must meet (e.g., purity >= 99.5%, pH 7.0-7.5, meets ASTM D1234).',
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
    `material_master_id` BIGINT COMMENT 'Reference to the chemical material or raw material covered by this contract price. Links to material master data.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: PRICING AUDIT: Price negotiations are performed by a specific employee; linking supports pricing compliance and audit trails.',
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
    `plant_code` STRING COMMENT 'Manufacturing plant or facility code where this contract price is applicable. May be blank for company-wide pricing agreements.',
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

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`supply`.`vendor_scorecard` (
    `vendor_scorecard_id` BIGINT COMMENT 'Unique identifier for the vendor scorecard evaluation record.',
    `employee_id` BIGINT COMMENT 'Reference to the procurement or quality professional who conducted the scorecard evaluation.',
    `vendor_id` BIGINT COMMENT 'Reference to the chemical supplier being evaluated in this scorecard.',
    `action_plan_required_flag` BOOLEAN COMMENT 'Indicates whether a formal vendor improvement action plan is required based on scorecard results.',
    `approved_date` DATE COMMENT 'Date when the vendor scorecard was formally approved and published.',
    `audit_score` DECIMAL(18,2) COMMENT 'Most recent vendor qualification audit score if an audit was conducted during or prior to the evaluation period.',
    `coa_compliance_rate_pct` DECIMAL(18,2) COMMENT 'Percentage of shipments accompanied by valid Certificate of Analysis documentation meeting quality specifications.',
    `comments` STRING COMMENT 'Free-text comments and observations from the evaluator regarding vendor performance, improvement areas, or strategic considerations.',
    `corrective_action_count` STRING COMMENT 'Number of Corrective and Preventive Action (CAPA) requests issued to the vendor during the evaluation period.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the vendor scorecard record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the total purchase value.. Valid values are `^[A-Z]{3}$`',
    `evaluation_period_end_date` DATE COMMENT 'End date of the performance evaluation period for this scorecard.',
    `evaluation_period_start_date` DATE COMMENT 'Start date of the performance evaluation period for this scorecard.',
    `evaluation_status` STRING COMMENT 'Current workflow status of the vendor scorecard evaluation record.. Valid values are `Draft|Under Review|Approved|Published|Archived`',
    `innovation_score` DECIMAL(18,2) COMMENT 'Score evaluating vendor contribution to product innovation, process improvements, and collaborative R&D initiatives.',
    `last_audit_date` DATE COMMENT 'Date of the most recent vendor qualification or compliance audit.',
    `lead_time_adherence_pct` DECIMAL(18,2) COMMENT 'Percentage of orders where the vendor met the agreed-upon lead time from purchase order issuance to delivery.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the vendor scorecard record was last modified.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next vendor scorecard evaluation.',
    `on_time_delivery_rate_pct` DECIMAL(18,2) COMMENT 'Percentage of purchase orders delivered on or before the requested delivery date during the evaluation period.',
    `oos_incident_count` STRING COMMENT 'Number of material receipts that failed quality testing and were found to be out of specification during the evaluation period.',
    `oot_incident_count` STRING COMMENT 'Number of material receipts showing quality parameter trends outside expected ranges during the evaluation period.',
    `overall_score` DECIMAL(18,2) COMMENT 'Composite vendor performance score calculated across all evaluation dimensions, typically on a 0-100 scale.',
    `packaging_compliance_rate_pct` DECIMAL(18,2) COMMENT 'Percentage of shipments meeting packaging specifications including hazmat labeling, UN packaging standards, and customer-specific requirements.',
    `price_variance_pct` DECIMAL(18,2) COMMENT 'Average percentage variance between contracted prices and actual invoiced prices during the evaluation period. Positive values indicate overcharges, negative values indicate favorable pricing.',
    `quantity_accuracy_rate_pct` DECIMAL(18,2) COMMENT 'Percentage of deliveries where the received quantity matched the ordered quantity within acceptable tolerance.',
    `reach_compliance_status` STRING COMMENT 'Vendor compliance status with European REACH regulation for chemical substance registration and authorization.. Valid values are `Fully Compliant|Partially Compliant|Non-Compliant|Not Applicable`',
    `rejected_shipment_count` STRING COMMENT 'Number of shipments rejected due to quality, documentation, or compliance failures during the evaluation period.',
    `responsible_care_compliance_rating` STRING COMMENT 'Vendor compliance status with American Chemistry Council Responsible Care program standards for health, safety, and environmental performance.. Valid values are `Certified|Compliant|Partially Compliant|Non-Compliant|Not Applicable`',
    `responsiveness_score` DECIMAL(18,2) COMMENT 'Qualitative score measuring vendor responsiveness to inquiries, RFQs, technical questions, and issue resolution, typically on a 0-100 scale.',
    `scorecard_number` STRING COMMENT 'Business identifier for the vendor scorecard evaluation record.. Valid values are `^VSC-[0-9]{8}$`',
    `sds_compliance_rate_pct` DECIMAL(18,2) COMMENT 'Percentage of shipments accompanied by current, GHS-compliant Safety Data Sheets.',
    `sustainability_score` DECIMAL(18,2) COMMENT 'Score evaluating vendor environmental and sustainability practices including waste reduction, emissions management, and green chemistry initiatives.',
    `total_order_count` STRING COMMENT 'Total number of purchase orders issued to this vendor during the evaluation period.',
    `total_purchase_value` DECIMAL(18,2) COMMENT 'Total monetary value of all purchase orders issued to this vendor during the evaluation period.',
    `tsca_compliance_status` STRING COMMENT 'Vendor compliance status with US EPA TSCA requirements for chemical substance inventory and reporting.. Valid values are `Compliant|Non-Compliant|Not Applicable`',
    CONSTRAINT pk_vendor_scorecard PRIMARY KEY(`vendor_scorecard_id`)
) COMMENT 'Periodic vendor performance evaluation records measuring chemical supplier performance across key procurement KPIs. Captures evaluation period, vendor, overall score, on-time delivery rate, quantity accuracy rate, COA compliance rate, OOS/OOT incident count, price variance percentage, lead time adherence, responsiveness score, sustainability score, and Responsible Care compliance rating. Supports strategic sourcing decisions and vendor tiering reviews.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`supply`.`vendor_qualification` (
    `vendor_qualification_id` BIGINT COMMENT 'Unique identifier for the vendor qualification record. Primary key for the vendor qualification lifecycle.',
    `employee_id` BIGINT COMMENT 'Reference to the employee assigned as lead auditor responsible for conducting the vendor qualification assessment.',
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
    `employee_id` BIGINT COMMENT 'Reference to the employee or contractor record of the lead auditor.',
    `vendor_document_id` BIGINT COMMENT 'Reference identifier or file path to the formal audit report document stored in the document management system.',
    `vendor_id` BIGINT COMMENT 'Reference to the chemical supplier or vendor being audited.',
    `audit_closure_date` DATE COMMENT 'Date the audit was formally closed after all findings were addressed, CAPA verified, and follow-up activities completed.',
    `audit_date` DATE COMMENT 'The date the on-site or remote audit was conducted or commenced. Principal business event timestamp for the audit.',
    `audit_end_date` DATE COMMENT 'The date the audit fieldwork was completed. Nullable for single-day audits.',
    `audit_frequency_months` STRING COMMENT 'Frequency in months at which this vendor should be audited, based on risk classification and business criticality (e.g., 12, 24, 36 months).',
    `audit_location` STRING COMMENT 'Physical location or facility where the audit was conducted (e.g., vendor plant address, city, country). For remote audits, indicates Remote or virtual platform used.',
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

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`supply`.`sourcing_risk` (
    `sourcing_risk_id` BIGINT COMMENT 'Primary key for sourcing_risk',
    `material_master_id` BIGINT COMMENT 'Reference to the raw material or chemical compound affected by this supply risk. Links to material master data.',
    `vendor_id` BIGINT COMMENT 'Reference to the vendor associated with this supply risk. Links to the vendor master data in the supply domain.',
    `employee_id` BIGINT COMMENT 'Reference to the employee responsible for monitoring and managing this supply risk, typically a procurement manager, supply chain planner, or category manager. Links to workforce/employee master data.',
    `affected_supply_lane` STRING COMMENT 'Identification of the specific supply lane or transportation route affected by this risk (e.g., China-to-USA West Coast, Rotterdam-to-Antwerp rail, Gulf Coast LTL network), used for logistics disruption risk tracking.',
    `annual_spend_at_risk_usd` DECIMAL(18,2) COMMENT 'Total annual procurement spend (in USD) associated with the affected vendor or material that is exposed to this supply risk, used for financial impact assessment and prioritization.',
    `assessment_date` DATE COMMENT 'Date when the most recent risk assessment (severity, probability, score) was performed, following yyyy-MM-dd format. Used to track assessment currency and trigger periodic reviews.',
    `business_impact_description` STRING COMMENT 'Detailed description of the potential business impact if the supply risk materializes, including effects on production schedules, customer commitments, revenue, market share, and strategic objectives.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this supply risk record was first created in the system, following yyyy-MM-ddTHH:mm:ss.SSSXXX format. Used for audit trail and data lineage.',
    `escalation_date` DATE COMMENT 'Date when the supply risk was escalated to senior management or executive leadership, following yyyy-MM-dd format. Null if no escalation has occurred.',
    `escalation_required_flag` BOOLEAN COMMENT 'Boolean indicator (True/False) denoting whether this supply risk requires escalation to senior management or executive leadership due to severity, financial exposure, or strategic importance.',
    `external_reference_code` STRING COMMENT 'External reference identifier linking this supply risk to related records in other systems (e.g., RFQ number, contract ID, incident ticket number, audit finding ID), enabling cross-system traceability.',
    `geographic_region` STRING COMMENT 'Geographic region or country code (ISO 3166-1 alpha-3) where the supply risk originates or has primary impact (e.g., CHN for China, USA for United States, DEU for Germany), used for geopolitical and logistics risk analysis.',
    `identified_date` DATE COMMENT 'Date when the supply risk was first identified and recorded in the risk management system, following yyyy-MM-dd format.',
    `lead_time_buffer_days` STRING COMMENT 'Additional lead time buffer (in days) recommended for procurement planning to account for potential delays or disruptions associated with this supply risk.',
    `mitigation_actual_date` DATE COMMENT 'Actual date when mitigation actions were completed and risk status changed to mitigated, following yyyy-MM-dd format. Null if mitigation is not yet complete.',
    `mitigation_start_date` DATE COMMENT 'Date when mitigation actions were initiated for this supply risk, following yyyy-MM-dd format. Null if no mitigation has been started.',
    `mitigation_strategy` STRING COMMENT 'Detailed description of the mitigation actions and strategies planned or implemented to reduce the likelihood or impact of the supply risk (e.g., dual-sourcing, safety stock increase, contract renegotiation, supplier development program, alternative material qualification).',
    `mitigation_target_date` DATE COMMENT 'Target date by which mitigation actions are planned to be completed and risk reduced to acceptable levels, following yyyy-MM-dd format.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this supply risk record was last updated or modified, following yyyy-MM-ddTHH:mm:ss.SSSXXX format. Used for audit trail and change tracking.',
    `next_review_date` DATE COMMENT 'Date when the next periodic review of this supply risk is scheduled, following yyyy-MM-dd format. Used for proactive risk monitoring and governance.',
    `notes` STRING COMMENT 'Free-form text field for additional notes, comments, or context related to the supply risk assessment, mitigation progress, stakeholder communications, or lessons learned.',
    `regulatory_framework` STRING COMMENT 'Identification of the specific regulatory framework or compliance requirement associated with this risk (e.g., REACH, TSCA, GHS, EPA, OSHA), particularly relevant for regulatory/compliance category risks.',
    `review_frequency_days` STRING COMMENT 'Scheduled frequency (in days) for periodic review and reassessment of this supply risk. Critical risks typically reviewed more frequently (e.g., 30 days) than low risks (e.g., 180 days).',
    `risk_category` STRING COMMENT 'Primary classification of the supply risk type. Categories include single-source dependency (sole supplier risk), geopolitical (trade restrictions, sanctions, political instability), regulatory/REACH (compliance and registration risks under REACH and other chemical regulations), raw material scarcity (limited availability or depletion), financial instability (vendor bankruptcy or credit risk), natural disaster (weather events, earthquakes, floods affecting supply), and logistics disruption (transportation, port, or infrastructure failures). [ENUM-REF-CANDIDATE: single_source_dependency|geopolitical|regulatory_reach|raw_material_scarcity|financial_instability|natural_disaster|logistics_disruption — promote to reference product]. Valid values are `single_source_dependency|geopolitical|regulatory_reach|raw_material_scarcity|financial_instability|natural_disaster`',
    `risk_description` STRING COMMENT 'Comprehensive narrative description of the supply risk, including background, potential impact on operations, affected products or production lines, and any relevant context for stakeholders.',
    `risk_exposure_value_usd` DECIMAL(18,2) COMMENT 'Estimated financial exposure or potential loss in USD if the risk materializes, calculated based on affected material spend, production value at risk, or revenue impact.',
    `risk_identifier` STRING COMMENT 'Human-readable business identifier for the supply risk record, following the pattern SRISK-NNNNNNNN for external communication and tracking.. Valid values are `^SRISK-[0-9]{8}$`',
    `risk_probability` STRING COMMENT 'Qualitative assessment of the likelihood that the risk event will occur within the assessment time horizon. Very high (>75% probability), high (50-75%), medium (25-50%), low (10-25%), very low (<10%).. Valid values are `very_high|high|medium|low|very_low`',
    `risk_score` DECIMAL(18,2) COMMENT 'Quantitative risk score calculated from severity and probability assessments, typically on a scale of 0-100, used for prioritization and risk ranking across the supply portfolio.',
    `risk_severity` STRING COMMENT 'Qualitative assessment of the potential impact severity if the risk materializes. Critical indicates potential production shutdown or major revenue loss; high indicates significant operational disruption; medium indicates manageable impact with workarounds; low indicates minimal operational impact.. Valid values are `critical|high|medium|low`',
    `risk_status` STRING COMMENT 'Current lifecycle status of the supply risk. Open indicates newly identified and under assessment; in_mitigation indicates active mitigation actions in progress; mitigated indicates risk has been successfully reduced to acceptable levels; accepted indicates risk acknowledged but no further action planned; closed indicates risk no longer applicable or threat has passed.. Valid values are `open|in_mitigation|mitigated|accepted|closed`',
    `risk_subcategory` STRING COMMENT 'Secondary classification providing additional granularity within the primary risk category (e.g., under geopolitical: trade_embargo, sanctions, border_closure; under regulatory: REACH_authorization, TSCA_restriction, GHS_reclassification).',
    `risk_title` STRING COMMENT 'Brief descriptive title summarizing the supply risk for quick identification and reporting (e.g., Single-source TiO2 supplier capacity constraint, REACH authorization deadline for Substance X).',
    `safety_stock_recommendation_qty` DECIMAL(18,2) COMMENT 'Recommended additional safety stock quantity (in base unit of measure) to buffer against supply disruption risk, calculated based on lead time variability, demand volatility, and risk severity.',
    `safety_stock_uom` STRING COMMENT 'Unit of measure for the safety stock recommendation quantity (e.g., KG for kilograms, L for liters, MT for metric tons, EA for each), aligned with material master base UOM.',
    `source_system` STRING COMMENT 'Identification of the operational system where this supply risk record originated (e.g., SAP MM, Oracle TMS, Intelex EHS, custom risk management application), used for data lineage and integration tracking.',
    CONSTRAINT pk_sourcing_risk PRIMARY KEY(`sourcing_risk_id`)
) COMMENT 'Supply risk assessment records identifying and tracking risks associated with specific vendors, materials, or supply lanes. Captures risk ID, risk category (single-source dependency, geopolitical, regulatory/REACH, raw material scarcity, financial instability, natural disaster, logistics disruption), affected vendor or material, risk severity, probability, risk score, mitigation strategy, contingency supplier, safety stock recommendation, and risk status (open, mitigated, accepted, closed). Supports procurement planning and business continuity.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`supply`.`supply_procurement_plan` (
    `supply_procurement_plan_id` BIGINT COMMENT 'Unique identifier for the procurement plan record. Primary key for the procurement planning entity.',
    `account_id` BIGINT COMMENT 'Foreign key linking to customer.account. Business justification: Procurement plans are created for specific customer accounts; budgeting and demand‑supply alignment reports depend on it.',
    `campaign_id` BIGINT COMMENT 'Reference to the production campaign or batch manufacturing schedule that drives this procurement requirement for campaign-based planning.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Procurement plans are tied to cost centers to align planned spend with financial budgeting and control.',
    `plant_id` BIGINT COMMENT 'Reference to the manufacturing plant or facility where the procured material will be delivered and consumed.',
    `employee_id` BIGINT COMMENT 'Reference to the procurement planner or buyer responsible for executing this procurement plan and managing supplier relationships.',
    `material_master_id` BIGINT COMMENT 'Reference to the material master record for the chemical raw material, intermediate, or finished good being procured.',
    `project_id` BIGINT COMMENT 'Foreign key linking to research.project. Business justification: Procurement planning per project requires each plan to be tied to the research project it supports.',
    `tertiary_supply_planner_employee_id` BIGINT COMMENT 'FK to workforce.employee',
    `vendor_id` BIGINT COMMENT 'Reference to the supplier or vendor master record from whom the material will be procured, applicable for external vendor sourcing.',
    `approval_date` DATE COMMENT 'The date when the procurement plan was formally approved for execution by authorized personnel.',
    `approval_required_flag` BOOLEAN COMMENT 'Indicates whether this procurement plan requires management approval before execution due to value thresholds, strategic importance, or policy requirements.',
    `cas_number` STRING COMMENT 'Unique numerical identifier assigned by the Chemical Abstracts Service to every chemical substance, used for regulatory compliance and material identification.. Valid values are `^[0-9]{2,7}-[0-9]{2}-[0-9]$`',
    `contract_number` STRING COMMENT 'Reference to the master purchasing contract or blanket agreement under which this procurement will be executed, if applicable.. Valid values are `^[0-9]{10}$`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this procurement plan record was first created in the system, capturing the initial planning event.',
    `estimated_unit_price` DECIMAL(18,2) COMMENT 'The estimated or planned unit price for the material based on contract pricing, historical purchases, or market intelligence, used for budget planning.',
    `hazmat_transport_flag` BOOLEAN COMMENT 'Indicates whether the material being procured is classified as hazardous and requires special handling, documentation, and transport compliance per DOT/IATA regulations.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this procurement plan record was last updated, reflecting the most recent planning adjustment or status change.',
    `lead_time_buffer_days` STRING COMMENT 'Additional buffer time in days added to standard lead time to account for hazmat transport delays, customs clearance, quality inspection, or supply chain variability.',
    `lead_time_days` STRING COMMENT 'The standard procurement lead time in calendar days from order placement to delivery, based on vendor agreements and historical performance.',
    `long_lead_time_flag` BOOLEAN COMMENT 'Indicates whether the material is classified as a long lead-time specialty chemical requiring extended procurement planning horizons (typically greater than 90 days).',
    `mrp_element` STRING COMMENT 'Reference to the SAP MRP element (planned order, production order, or sales order) that generated this procurement requirement via MRP run (MD04/MD07).. Valid values are `^[A-Z0-9]{10}$`',
    `mrp_run_date` DATE COMMENT 'The date when the MRP calculation was executed that generated this procurement plan requirement.',
    `notes` STRING COMMENT 'Free-text field for planners to capture special instructions, supplier constraints, quality requirements, or other contextual information relevant to procurement execution.',
    `plan_number` STRING COMMENT 'Business identifier for the procurement plan, externally visible and used for cross-system reference and communication with procurement teams.. Valid values are `^PP-[0-9]{8}-[A-Z0-9]{4}$`',
    `plan_status` STRING COMMENT 'Current lifecycle status of the procurement plan indicating its progression from draft through execution to completion or cancellation. [ENUM-REF-CANDIDATE: DRAFT|APPROVED|IN_EXECUTION|PARTIALLY_FULFILLED|COMPLETED|CANCELLED|ON_HOLD — 7 candidates stripped; promote to reference product]',
    `plan_type` STRING COMMENT 'Classification of the procurement plan based on the triggering mechanism: MRP-driven requirements, safety stock replenishment, campaign production schedules, spot purchases, strategic sourcing initiatives, or consignment stock replenishment.. Valid values are `MRP_DRIVEN|SAFETY_STOCK|CAMPAIGN_BASED|SPOT_PURCHASE|STRATEGIC_SOURCING|CONSIGNMENT_REPLENISHMENT`',
    `planned_delivery_date` DATE COMMENT 'The target date when the material is expected to be delivered to the receiving plant or warehouse location.',
    `planned_order_date` DATE COMMENT 'The target date when the purchase order or procurement request should be created and released to the supplier to meet delivery requirements.',
    `planned_procurement_quantity` DECIMAL(18,2) COMMENT 'The quantity of material planned to be procured in this plan record, expressed in the base unit of measure for the material.',
    `planning_horizon` STRING COMMENT 'Time period scope for the procurement plan, defining whether it covers weekly, monthly, quarterly, annual, rolling 12-month, or campaign-specific planning cycles.. Valid values are `WEEKLY|MONTHLY|QUARTERLY|ANNUAL|ROLLING_12_MONTH|CAMPAIGN_SPECIFIC`',
    `plant_code` STRING COMMENT 'Four-character alphanumeric code identifying the manufacturing plant or distribution center receiving the material.. Valid values are `^[A-Z0-9]{4}$`',
    `price_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the estimated unit price and total planned value.. Valid values are `^[A-Z]{3}$`',
    `priority_code` STRING COMMENT 'Priority classification for the procurement plan indicating urgency and importance for execution: critical for production-critical materials, high for near-term requirements, normal for standard planning, low for long-term strategic sourcing.. Valid values are `CRITICAL|HIGH|NORMAL|LOW`',
    `procurement_type` STRING COMMENT 'The procurement method to be used for this plan: standard purchase order, blanket order release, contract release, spot buy, emergency procurement, or stock transfer order.. Valid values are `STANDARD_PO|BLANKET_ORDER|CONTRACT_RELEASE|SPOT_BUY|EMERGENCY_PROCUREMENT|STOCK_TRANSFER`',
    `purchasing_group` STRING COMMENT 'Three-character code identifying the purchasing group or procurement team responsible for this material category or commodity.. Valid values are `^[A-Z0-9]{3}$`',
    `purchasing_organization` STRING COMMENT 'Four-character code identifying the purchasing organization or procurement entity responsible for negotiating and executing this procurement.. Valid values are `^[A-Z0-9]{4}$`',
    `safety_stock_trigger_flag` BOOLEAN COMMENT 'Indicates whether this procurement plan was triggered by safety stock replenishment logic due to inventory falling below minimum stock levels.',
    `seasonal_material_flag` BOOLEAN COMMENT 'Indicates whether the material has seasonal availability constraints requiring advance procurement planning and inventory build-up strategies.',
    `source_of_supply` STRING COMMENT 'Classification of the procurement source indicating whether material will be sourced from external vendors, intercompany transfers, toll manufacturing arrangements, consignment stock, or contract manufacturers.. Valid values are `EXTERNAL_VENDOR|INTERCOMPANY_TRANSFER|TOLL_MANUFACTURING|CONSIGNMENT|CONTRACT_MANUFACTURER`',
    `supply_risk_level` STRING COMMENT 'Assessment of supply chain risk for this material based on supplier concentration, geopolitical factors, market volatility, and availability constraints.. Valid values are `LOW|MEDIUM|HIGH|CRITICAL`',
    `total_planned_value` DECIMAL(18,2) COMMENT 'The total estimated monetary value of this procurement plan calculated as planned quantity multiplied by estimated unit price, used for budget allocation and spend forecasting.',
    `un_number` STRING COMMENT 'Four-digit UN identification number for hazardous materials transport classification, required for shipping documentation and regulatory compliance.. Valid values are `^UN[0-9]{4}$`',
    `unit_of_measure` STRING COMMENT 'The unit of measure for the planned procurement quantity, typically kilograms, metric tons, liters, gallons, or container units for chemical materials. [ENUM-REF-CANDIDATE: KG|MT|L|GAL|LB|TON|M3|DRUM|IBC|BAG — 10 candidates stripped; promote to reference product]',
    CONSTRAINT pk_supply_procurement_plan PRIMARY KEY(`supply_procurement_plan_id`)
) COMMENT 'Forward-looking procurement planning records translating MRP-generated requirements, safety stock replenishment triggers, and campaign production schedules into actionable material procurement schedules. Captures plan ID, planning horizon (weekly/monthly/quarterly), material and CAS number, plant, planned procurement quantity, planned order date, planned delivery date, source of supply (vendor or intercompany), procurement type, lead time buffer for hazmat transport, planner assignment, and plan status. Critical for managing long lead-time specialty chemical orders and seasonal raw material availability. Integrates with SAP PP/MM MRP run outputs (MD04/MD07).';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`supply`.`purchase_requisition` (
    `purchase_requisition_id` BIGINT COMMENT 'Unique identifier for the purchase requisition record. Primary key.',
    `opportunity_id` BIGINT COMMENT 'Foreign key linking to sales.opportunity. Business justification: Procurement creates purchase requisitions to fulfill a specific sales opportunity, enabling end‑to‑end order‑to‑cash traceability.',
    `vendor_id` BIGINT COMMENT 'Identifier of the preferred or suggested vendor for sourcing this requisition, if specified by the requester.',
    `project_id` BIGINT COMMENT 'Foreign key linking to research.project. Business justification: Requisition budgeting and approval workflows reference the research project that initiates the request.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: REQUISITION: The employee who raises a requisition must be recorded for traceability and spend analysis.',
    `rfq_id` BIGINT COMMENT 'Foreign key linking to supply.rfq. Business justification: Link purchase requisition to its originating RFQ to give RFQ an inbound relationship and enable traceability from requisition to request for quotation.',
    `approval_date` DATE COMMENT 'Date when the requisition was approved by the authorized approver.',
    `approval_status` STRING COMMENT 'Current approval status of the requisition in the multi-level approval workflow.. Valid values are `pending|approved|rejected|escalated`',
    `approver_name` STRING COMMENT 'Name of the manager or authorized person who approved or rejected the requisition.',
    `campaign_production_flag` BOOLEAN COMMENT 'Indicates whether this requisition is aligned with a campaign production schedule for batch manufacturing.',
    `cas_number` STRING COMMENT 'Unique numerical identifier assigned by Chemical Abstracts Service to every chemical substance, used for regulatory compliance and material identification.. Valid values are `^[0-9]{2,7}-[0-9]{2}-[0-9]$`',
    `cost_center` STRING COMMENT 'Cost center to which the procurement expense will be charged for accounting purposes.. Valid values are `^[A-Z0-9]{10}$`',
    `currency_code` STRING COMMENT 'Three-letter ISO currency code for the estimated price and total value.. Valid values are `^[A-Z]{3}$`',
    `estimated_total_value` DECIMAL(18,2) COMMENT 'Total estimated value of the requisition calculated as quantity multiplied by estimated unit price.',
    `estimated_unit_price` DECIMAL(18,2) COMMENT 'Estimated price per unit of the material or service at the time of requisition creation.',
    `ghs_classification` STRING COMMENT 'GHS hazard classification code for the chemical material being requisitioned, used for safety and regulatory compliance.',
    `gl_account_code` STRING COMMENT 'General ledger account code for financial posting of the procurement expense.. Valid values are `^[0-9]{10}$`',
    `hazmat_flag` BOOLEAN COMMENT 'Indicates whether the requisitioned material is classified as hazardous and requires special handling, transport, and regulatory compliance.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the requisition record, capturing any changes to status, quantities, or other fields.',
    `lead_time_days` STRING COMMENT 'Expected number of days from requisition approval to material delivery, including hazmat transport buffers if applicable.',
    `material_description` STRING COMMENT 'Short text description of the material or service being requisitioned.',
    `material_number` STRING COMMENT 'Unique identifier for the material being requisitioned, referencing the material master.. Valid values are `^[A-Z0-9]{18}$`',
    `mrp_element` STRING COMMENT 'Type of MRP element that generated or is associated with this requisition in the planning run.. Valid values are `planned_order|purchase_requisition|schedule_line`',
    `notes` STRING COMMENT 'Free-text notes or special instructions provided by the requester regarding material specifications, delivery requirements, or other procurement considerations.',
    `planner_code` STRING COMMENT 'Code identifying the MRP planner or buyer responsible for managing procurement of this material.. Valid values are `^[A-Z0-9]{3}$`',
    `planning_horizon` STRING COMMENT 'Time bucket granularity for forward-looking procurement planning associated with this requisition.. Valid values are `weekly|monthly|quarterly`',
    `plant_code` STRING COMMENT 'Manufacturing or distribution plant where the material or service is required.. Valid values are `^[A-Z0-9]{4}$`',
    `po_conversion_status` STRING COMMENT 'Status indicating whether the requisition has been converted to one or more purchase orders.. Valid values are `not_converted|partially_converted|fully_converted`',
    `po_number` STRING COMMENT 'Purchase order number generated from this requisition, if conversion has occurred.. Valid values are `^PO[0-9]{10}$`',
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
    `material_master_id` BIGINT COMMENT 'Reference to the raw material or chemical product that this source list entry applies to. Links to the material master data.',
    `vendor_id` BIGINT COMMENT 'Reference to the approved supplier or vendor authorized to supply this material to the specified plant.',
    `agreement_item` STRING COMMENT 'The line item number within the referenced contract or scheduling agreement that applies to this material-vendor-plant combination.',
    `agreement_number` STRING COMMENT 'The document number of the contract or scheduling agreement that this source list entry references. Null if no formal agreement exists.',
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
    `material_number` STRING COMMENT 'The business identifier (SKU or material code) for the raw material or chemical. Denormalized for reporting convenience.',
    `minimum_order_quantity` DECIMAL(18,2) COMMENT 'The minimum order quantity that the vendor requires for this material. Enforces vendor-specific ordering constraints in procurement.',
    `mrp_relevant_flag` BOOLEAN COMMENT 'Indicates whether this source list entry is considered during MRP runs for automatic source determination and purchase requisition generation.',
    `next_qualification_due_date` DATE COMMENT 'The date by which the vendor must be re-qualified for this material. Supports proactive supplier management and compliance with AVL (Approved Vendor List) policies.',
    `order_quantity_uom` STRING COMMENT 'The unit of measure for the minimum order quantity and standard ordering unit for this material from this vendor.',
    `plant_code` STRING COMMENT 'The manufacturing plant or facility to which this approved source applies. Defines the scope of the source list entry.',
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
    `carrier_id` BIGINT COMMENT 'Identifier of the transportation carrier responsible for moving the materials from vendor to plant. May be third-party logistics provider or vendor-managed transport.',
    `site_id` BIGINT COMMENT 'Foreign key linking to customer.site. Business justification: Inbound logistics must know which customer site receives the delivery; used in ETA and dock scheduling reports.',
    `lab_experiment_id` BIGINT COMMENT 'Foreign key linking to research.lab_experiment. Business justification: Delivery execution teams need to know which lab experiment the inbound delivery supports for traceability.',
    `manufacturing_order_id` BIGINT COMMENT 'Foreign key linking to production.manufacturing_order. Business justification: REQUIRED: Receiving reports tie each inbound delivery to the specific manufacturing order that consumes the delivered material.',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to rawmaterial.material_master. Business justification: Required for inbound delivery tracking per material to reconcile receipts, support inventory and regulatory compliance reports.',
    `purchase_order_id` BIGINT COMMENT 'Reference to the purchase order that authorized this delivery. Links delivery to procurement transaction.',
    `vendor_id` BIGINT COMMENT 'Identifier of the chemical supplier or vendor shipping the materials. Links to vendor master data.',
    `vendor_site_id` BIGINT COMMENT 'Identifier of the specific vendor site or facility from which the materials are being shipped. Origin location for the delivery.',
    `actual_arrival_date` DATE COMMENT 'Actual date the delivery arrived at the destination plant gate or receiving dock. Used for on-time delivery performance measurement.',
    `actual_arrival_time` TIMESTAMP COMMENT 'Actual date and time the delivery arrived at the destination plant, including time zone. Captured by gate systems or receiving personnel.',
    `bill_of_lading_number` STRING COMMENT 'Bill of lading number issued by the carrier. Legal document serving as receipt of goods and contract of carriage.',
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
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: GL account is required to post invoice amounts to the correct ledger account per accounting standards.',
    `project_id` BIGINT COMMENT 'Foreign key linking to research.project. Business justification: Invoice validation against project budgets requires linking each invoice verification to its research project.',
    `vendor_id` BIGINT COMMENT 'Unique identifier for the chemical supplier who issued the invoice. Links to vendor master data.',
    `baseline_date` DATE COMMENT 'Baseline date for payment terms calculation in SAP. Typically the invoice date or goods receipt date depending on payment terms configuration.',
    `blocking_reason` STRING COMMENT 'Reason why the invoice verification is blocked from payment. Common blocks include price tolerance exceeded, quantity short, or quality hold pending Certificate of Analysis (COA) review. [ENUM-REF-CANDIDATE: price_tolerance_exceeded|quantity_short|quality_hold_pending_coa|duplicate_invoice|missing_gr|missing_po|tax_code_mismatch|vendor_blocked|manual_review_required|unblocked — 10 candidates stripped; promote to reference product]',
    `coa_received_flag` BOOLEAN COMMENT 'Indicates whether the Certificate of Analysis has been received from the vendor. Critical for chemical procurement where COA review is required before payment release.',
    `coa_review_status` STRING COMMENT 'Status of the Certificate of Analysis review by Quality Control. Invoices may be blocked pending COA approval for chemical raw materials.. Valid values are `not_required|pending|approved|rejected|on_hold`',
    `company_code` STRING COMMENT 'SAP company code representing the legal entity receiving the invoice. Required for financial posting and legal compliance.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the invoice verification record was first created in the system. Audit trail for record lifecycle.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the invoice amount (e.g., USD, EUR, CNY). Critical for multi-currency chemical procurement.. Valid values are `^[A-Z]{3}$`',
    `document_date` DATE COMMENT 'Document date of the invoice verification record. Typically matches the vendor invoice date but may differ for backdated postings.',
    `fiscal_year` STRING COMMENT 'Fiscal year in which the invoice verification document was posted.',
    `freight_charge` DECIMAL(18,2) COMMENT 'Freight or transportation charge included in the vendor invoice. Common surcharge in chemical procurement for bulk material shipments.',
    `goods_receipt_date` DATE COMMENT 'Date on which the chemical materials were physically received and recorded in SAP MM.',
    `goods_receipt_number` STRING COMMENT 'Goods receipt document number confirming physical receipt of chemical materials. Third element of three-way match (PO, GR, Invoice).',
    `hazmat_handling_fee` DECIMAL(18,2) COMMENT 'Special handling fee for hazardous chemical materials. Charged by vendors for DOT-regulated hazmat transportation and storage compliance.',
    `index_escalator_amount` DECIMAL(18,2) COMMENT 'Price adjustment based on commodity index escalation clauses common in chemical supply contracts. Reflects market-driven price volatility.',
    `invoiced_amount` DECIMAL(18,2) COMMENT 'Total amount invoiced by the vendor before tax. Base amount for three-way match price variance calculation.',
    `invoiced_quantity` DECIMAL(18,2) COMMENT 'Quantity of chemical material invoiced by the vendor. Compared against PO quantity and GR quantity for variance detection.',
    `material_number` STRING COMMENT 'SAP material master number for the chemical raw material being invoiced. Enables material-level spend analysis.',
    `payment_block_indicator` BOOLEAN COMMENT 'Flag indicating whether the invoice is blocked for payment. True if blocked, False if released for payment processing.',
    `payment_due_date` DATE COMMENT 'Calculated date by which payment is due to the vendor based on invoice date and payment terms. Critical for cash flow management and vendor relationship.',
    `payment_release_by` STRING COMMENT 'User ID or name of the person who released the invoice for payment. Audit trail for payment authorization.',
    `payment_release_date` DATE COMMENT 'Date on which the invoice was released for payment after successful three-way match verification and block resolution.',
    `payment_terms` STRING COMMENT 'Payment terms code from the purchase order or vendor master (e.g., Net 30, 2/10 Net 30). Determines payment due date and early payment discount eligibility.',
    `plant_code` STRING COMMENT 'Manufacturing plant or facility code where the chemical materials were received. Links to plant master data.',
    `po_line_number` STRING COMMENT 'Line item number within the purchase order being verified. Enables line-level reconciliation for multi-material POs.',
    `po_number` STRING COMMENT 'Purchase order number against which the vendor invoice is being verified. Core reference for three-way match.',
    `posting_date` DATE COMMENT 'Date on which the invoice verification document was posted to the financial ledger in SAP FI.',
    `posting_status` STRING COMMENT 'Current posting status of the invoice verification document in SAP FI. Indicates whether the document has been financially posted to the general ledger.. Valid values are `draft|posted|reversed|parked|cancelled`',
    `price_variance` DECIMAL(18,2) COMMENT 'Difference between invoiced price and PO price. Common in chemical procurement due to index-linked pricing, freight surcharges, and hazmat handling fees.',
    `quantity_variance` DECIMAL(18,2) COMMENT 'Difference between invoiced quantity and goods receipt quantity. Typical with bulk liquid chemical deliveries measured by weight at receipt.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Total tax amount on the vendor invoice (VAT, GST, sales tax). Calculated based on tax jurisdiction and material tax classification.',
    `tax_code` STRING COMMENT 'SAP tax code determining the tax rate and tax account assignment. Varies by jurisdiction, material type, and vendor location.',
    `total_invoice_amount` DECIMAL(18,2) COMMENT 'Total invoice amount including tax. Gross amount payable to the vendor upon verification approval.',
    `unit_of_measure` STRING COMMENT 'Unit of measure for the invoiced quantity (e.g., KG, L, MT, GAL). Critical for bulk chemical deliveries measured by weight or volume.',
    `vendor_invoice_date` DATE COMMENT 'Date on which the vendor issued the invoice. Used for payment terms calculation and aging analysis.',
    `vendor_invoice_number` STRING COMMENT 'Invoice number provided by the chemical supplier on their invoice document. Critical for reconciliation and payment processing.',
    `verification_document_number` STRING COMMENT 'SAP document number assigned to the invoice verification transaction. Unique business identifier for the three-way match record.',
    `verification_status` STRING COMMENT 'Overall status of the three-way match verification process. Tracks the invoice through verification workflow from receipt to approval.. Valid values are `pending|verified|rejected|blocked|approved|in_review`',
    `verified_by` STRING COMMENT 'User ID or name of the person who performed the invoice verification. Audit trail for accountability and compliance.',
    `verified_timestamp` TIMESTAMP COMMENT 'Date and time when the invoice verification was completed. Tracks verification cycle time for process efficiency analysis.',
    CONSTRAINT pk_invoice_verification PRIMARY KEY(`invoice_verification_id`)
) COMMENT 'Three-way match verification records reconciling vendor invoices against purchase orders and goods receipts for chemical raw material purchases. Captures verification document number, vendor invoice number and date, PO and GR references, invoiced amount, tax amount, currency, price variance (common with index-linked chemical pricing), quantity variance (typical with bulk liquid deliveries measured by weight), blocking reasons (price tolerance exceeded, quantity short, quality hold pending COA review), payment release status, and posting status. Critical for chemical procurement where pricing often includes freight surcharges, hazmat handling fees, and index-based escalators. Integrates with SAP MM MIRO and FI accounts payable.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`supply`.`material_info_record` (
    `material_info_record_id` BIGINT COMMENT 'Unique identifier for the material info record. Primary key for this purchasing master data entity.',
    `material_master_id` BIGINT COMMENT 'Reference to the material being sourced. Links to the material master data defining the chemical product, raw material, or finished good covered by this purchasing agreement.',
    `plant_id` BIGINT COMMENT 'Reference to the manufacturing plant or facility where this material will be delivered. Defines the destination location for this sourcing arrangement.',
    `vendor_id` BIGINT COMMENT 'Reference to the approved supplier for this material. Links to vendor master data defining the chemical supplier authorized to provide this material.',
    `acknowledgement_required` BOOLEAN COMMENT 'Indicates whether the vendor must send a formal acknowledgement confirming receipt and acceptance of purchase orders. When true, procurement tracks acknowledgement status.',
    `agreement_item_number` STRING COMMENT 'Specific line item within the referenced contract that covers this material. Five-digit numeric identifier linking to the contract line item.. Valid values are `^[0-9]{5}$`',
    `blocked_source` BOOLEAN COMMENT 'Indicates whether this source is temporarily blocked from procurement. When true, no new purchase orders can be created using this material-vendor-plant combination.',
    `certificate_of_analysis_required` BOOLEAN COMMENT 'Indicates whether the vendor must provide a Certificate of Analysis with each shipment. Critical for chemical materials to verify composition, purity, and compliance with specifications.',
    `contract_number` STRING COMMENT 'Reference to the master purchasing contract or agreement governing this sourcing relationship. Links to long-term supply agreements with negotiated terms and pricing.. Valid values are `^[A-Z0-9]{10}$`',
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

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`supply`.`delivery_schedule` (
    `delivery_schedule_id` BIGINT COMMENT 'Unique identifier for the delivery schedule line. Primary key for the supply delivery schedule entity.',
    `material_master_id` BIGINT COMMENT 'Identifier of the raw material, chemical compound, or finished product being scheduled for delivery. Links to material master data.',
    `supply_agreement_id` BIGINT COMMENT 'Reference to the parent scheduling agreement contract that governs this delivery schedule line. Links to the long-term supply arrangement with the chemical vendor.',
    `vendor_id` BIGINT COMMENT 'Identifier of the chemical supplier responsible for delivering materials according to this schedule line. Links to vendor master data.',
    `actual_delivered_quantity` DECIMAL(18,2) COMMENT 'Actual quantity of material delivered and received. Used to track delivery accuracy and calculate over-delivery or under-delivery variances.',
    `actual_delivery_date` DATE COMMENT 'Actual date when the material was delivered and goods receipt was posted. Used for vendor performance measurement and on-time delivery KPI calculation.',
    `batch_managed_flag` BOOLEAN COMMENT 'Indicates whether the material requires batch or lot number tracking for quality control, traceability, and Certificate of Analysis (COA) management.',
    `cas_number` STRING COMMENT 'Unique numerical identifier assigned by Chemical Abstracts Service to every chemical substance. Used for regulatory reporting, safety data sheet (SDS) management, and chemical inventory tracking.. Valid values are `^[0-9]{2,7}-[0-9]{2}-[0-9]$`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this delivery schedule line record was first created in the system. Used for audit trail and data lineage tracking.',
    `cumulative_received_quantity` DECIMAL(18,2) COMMENT 'Total quantity of material received to date against this scheduling agreement. Used to track fulfillment progress and calculate outstanding delivery obligations.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the price per unit (e.g., USD, EUR, GBP). Supports multi-currency procurement operations.. Valid values are `^[A-Z]{3}$`',
    `delivery_category` STRING COMMENT 'Classification of the delivery schedule line indicating the commitment level. Forecast deliveries are planning estimates, firm deliveries are binding commitments, just-in-time deliveries support lean manufacturing, blanket deliveries cover long-term agreements, and trade-off deliveries allow quantity adjustments.. Valid values are `forecast|firm|just_in_time|blanket|trade_off`',
    `delivery_tolerance_percentage` DECIMAL(18,2) COMMENT 'Acceptable percentage variance (plus or minus) from the scheduled quantity that the vendor is allowed to deliver without requiring approval. Supports flexible chemical supply chain management.',
    `goods_receipt_number` STRING COMMENT 'Document number of the goods receipt posted against this schedule line. Links delivery schedule to warehouse management and inventory transactions.',
    `hazmat_indicator` BOOLEAN COMMENT 'Flag indicating whether the scheduled material is classified as hazardous and requires special handling, transportation, and storage procedures per DOT and OSHA regulations.',
    `incoterms_code` STRING COMMENT 'International Commercial Terms code defining the responsibilities and risks between buyer and seller for this delivery (e.g., EXW, FOB, CIF, DDP). Critical for chemical logistics and customs compliance.',
    `incoterms_location` STRING COMMENT 'Specific location or port associated with the Incoterms code (e.g., Houston Port, Vendor Warehouse). Defines the point where risk and cost transfer occurs.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this delivery schedule line record was last updated. Supports change tracking and data quality monitoring.',
    `material_group` STRING COMMENT 'Classification code grouping similar materials for procurement analysis, spend management, and supplier performance reporting (e.g., solvents, polymers, catalysts).',
    `net_value` DECIMAL(18,2) COMMENT 'Total net value of this schedule line calculated as scheduled quantity multiplied by price per unit. Used for budget tracking and financial planning.',
    `outstanding_quantity` DECIMAL(18,2) COMMENT 'Remaining quantity yet to be delivered under this schedule line. Calculated as scheduled quantity minus cumulative received quantity.',
    `plant_code` STRING COMMENT 'Code identifying the manufacturing plant or facility where the scheduled material delivery will be received. Supports multi-site chemical manufacturing operations.',
    `price_per_unit` DECIMAL(18,2) COMMENT 'Agreed unit price for the material as defined in the scheduling agreement. Used for cost planning and invoice verification.',
    `purchasing_group` STRING COMMENT 'Code identifying the procurement team or buyer responsible for managing this scheduling agreement and delivery schedule. Used for workload distribution and accountability.',
    `quality_inspection_required_flag` BOOLEAN COMMENT 'Indicates whether incoming material must undergo quality control (QC) inspection and laboratory testing before release to production. Supports Good Manufacturing Practice (GMP) compliance.',
    `release_date` DATE COMMENT 'Date when this schedule line was officially released to the vendor for fulfillment. Marks the transition from planning to execution.',
    `release_strategy` STRING COMMENT 'Method by which schedule lines are released to the vendor for fulfillment. Immediate releases are sent directly, forecast-based uses demand planning, consumption-based triggers on usage, and manual requires buyer approval.. Valid values are `immediate|forecast_based|consumption_based|manual`',
    `schedule_line_number` STRING COMMENT 'Sequential line number within the scheduling agreement that uniquely identifies this delivery schedule entry. Used for ordering and referencing specific schedule lines.',
    `schedule_line_status` STRING COMMENT 'Current lifecycle status of the delivery schedule line. Tracks progression from initial scheduling through vendor confirmation, partial fulfillment, completion, or cancellation.. Valid values are `open|confirmed|partially_delivered|fully_delivered|cancelled|blocked`',
    `scheduled_delivery_date` DATE COMMENT 'Planned date when the vendor is expected to deliver the material quantity to the receiving plant. Used for just-in-time manufacturing planning and production scheduling.',
    `scheduled_quantity` DECIMAL(18,2) COMMENT 'Planned quantity of material to be delivered on the scheduled delivery date. Supports continuous chemical manufacturing process planning and inventory optimization.',
    `shipping_method` STRING COMMENT 'Mode of transportation planned for this delivery. Critical for hazardous material transportation planning and Department of Transportation (DOT) compliance.. Valid values are `truck|rail|ocean|air|pipeline|intermodal`',
    `special_handling_instructions` STRING COMMENT 'Free-text field capturing specific requirements for material handling, storage, or transportation (e.g., temperature control, moisture sensitivity, light protection). Critical for chemical safety and quality preservation.',
    `storage_location` STRING COMMENT 'Specific storage location code within the plant where the delivered material will be stored. Critical for hazardous material segregation and inventory management.',
    `un_number` STRING COMMENT 'Four-digit UN identification number for hazardous materials used in international transportation (e.g., UN1090 for acetone). Required for shipping documentation and emergency response.. Valid values are `^UN[0-9]{4}$`',
    `unit_of_measure` STRING COMMENT 'Unit of measure for the scheduled quantity (e.g., KG for kilograms, L for liters, MT for metric tons, GAL for gallons). Critical for chemical quantity calculations and conversions.',
    `vendor_confirmation_date` DATE COMMENT 'Date when the vendor confirmed their ability to meet the scheduled delivery date and quantity. Critical for supply chain reliability tracking.',
    `vendor_confirmed_quantity` DECIMAL(18,2) COMMENT 'Quantity that the vendor has confirmed they can deliver on the scheduled date. May differ from scheduled quantity if vendor capacity constraints exist.',
    CONSTRAINT pk_delivery_schedule PRIMARY KEY(`delivery_schedule_id`)
) COMMENT 'Scheduling agreement delivery schedule lines defining planned delivery dates and quantities for long-term supply arrangements with chemical vendors. Captures schedule line number, scheduling agreement reference, material, plant, scheduled delivery date, scheduled quantity, cumulative received quantity, delivery category (forecast vs. firm), and schedule line status. Supports just-in-time raw material delivery planning for continuous chemical manufacturing processes.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`supply`.`vendor_document` (
    `vendor_document_id` BIGINT COMMENT 'Unique identifier for the vendor document record. Primary key.',
    `material_master_id` BIGINT COMMENT 'Reference to the specific chemical material or product that this document pertains to. May be null for vendor-level certificates.',
    `superseded_by_document_vendor_document_id` BIGINT COMMENT 'Reference to the newer vendor document that supersedes this document. Null if this is the current version.',
    `vendor_id` BIGINT COMMENT 'Reference to the chemical supplier who provided this document. Links to the vendor master data.',
    `applicable_region` STRING COMMENT 'Geographic region or jurisdiction for which this document is valid (e.g., USA, EU, APAC). Pipe-separated list if multiple regions apply.',
    `approval_status` STRING COMMENT 'The approval workflow status of the document for use in procurement and operations.. Valid values are `APPROVED|PENDING_APPROVAL|REJECTED|NOT_REQUIRED`',
    `approved_by` STRING COMMENT 'Name or employee identifier of the person who approved the document for operational use.',
    `approved_date` DATE COMMENT 'The date on which the document was formally approved for use by the authorized approver.',
    `cas_number` STRING COMMENT 'The CAS registry number identifying the chemical substance covered by this document. Format: XXXXXX-XX-X.. Valid values are `^[1-9][0-9]{1,6}-[0-9]{2}-[0-9]$`',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this vendor document record was first created in the system.',
    `document_hash` STRING COMMENT 'SHA-256 or MD5 hash of the document file for integrity verification and duplicate detection.',
    `document_language` STRING COMMENT 'Two-letter ISO 639-1 language code indicating the primary language of the document content.. Valid values are `^[a-z]{2}$`',
    `document_number` STRING COMMENT 'Unique business identifier or control number assigned to the document by the vendor or issuing authority.',
    `document_status` STRING COMMENT 'Current validity status of the vendor document in the compliance repository.. Valid values are `ACTIVE|EXPIRED|SUPERSEDED|PENDING_REVIEW|REJECTED|ARCHIVED`',
    `document_type` STRING COMMENT 'Classification of the vendor document. SDS = Safety Data Sheet, MSDS = Material Safety Data Sheet, COA = Certificate of Analysis, COC = Certificate of Compliance, REACH = Registration Evaluation Authorization and Restriction of Chemicals dossier, TSCA = Toxic Substances Control Act certification, GMP = Good Manufacturing Practice certificate. [ENUM-REF-CANDIDATE: SDS|MSDS|COA|COC|REACH_DOSSIER|TSCA_CERTIFICATION|ISO_9001_CERTIFICATE|ISO_14001_CERTIFICATE|GMP_CERTIFICATE|RESPONSIBLE_CARE_ATTESTATION|HAZMAT_DECLARATION|TECHNICAL_DATA_SHEET|ALLERGEN_STATEMENT|HALAL_CERTIFICATE|KOSHER_CERTIFICATE|CONFLICT_MINERALS_DECLARATION — 16 candidates stripped; promote to reference product]',
    `document_version` STRING COMMENT 'Version or revision number of the document as assigned by the issuing authority or vendor.',
    `effective_date` DATE COMMENT 'The date from which the document becomes valid and enforceable for compliance purposes.',
    `expiration_date` DATE COMMENT 'The date on which the document expires and is no longer valid for regulatory or compliance purposes. Null for documents without expiration.',
    `file_format` STRING COMMENT 'The digital file format or MIME type of the stored document. [ENUM-REF-CANDIDATE: PDF|DOCX|XLSX|XML|HTML|TXT|TIFF|JPG|PNG — 9 candidates stripped; promote to reference product]',
    `file_name` STRING COMMENT 'The name of the digital file as stored in the document management system or data lake.',
    `file_path` STRING COMMENT 'The storage location or URI path where the document file is stored in the lakehouse or document repository.',
    `file_size_kb` DECIMAL(18,2) COMMENT 'The size of the document file in kilobytes.',
    `ghs_compliant_flag` BOOLEAN COMMENT 'Indicates whether the document (typically SDS/MSDS) complies with GHS classification and labeling standards.',
    `issue_date` DATE COMMENT 'The date on which the document was issued or published by the vendor or certifying authority.',
    `issuing_authority` STRING COMMENT 'The name of the organization, certification body, or regulatory agency that issued or certified the document.',
    `issuing_authority_country` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code of the issuing authority or certification body.. Valid values are `^[A-Z]{3}$`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this vendor document record was last updated or modified.',
    `material_number` STRING COMMENT 'The material code or SKU (Stock Keeping Unit) that this document covers. Denormalized for reporting convenience.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next periodic review or renewal of the document to ensure continued compliance.',
    `notes` STRING COMMENT 'Free-text field for additional comments, special handling instructions, or compliance notes related to the document.',
    `reach_compliant_flag` BOOLEAN COMMENT 'Indicates whether the document demonstrates compliance with EU REACH regulation for chemical substance registration and authorization.',
    `received_by` STRING COMMENT 'Name or employee identifier of the person who received and registered the document in the system.',
    `received_date` DATE COMMENT 'The date on which the document was received from the vendor and entered into the system.',
    `rejection_reason` STRING COMMENT 'Explanation or reason code if the document was rejected during review or approval process.',
    `reviewed_by` STRING COMMENT 'Name or employee identifier of the person who performed the last compliance review of the document.',
    `reviewed_date` DATE COMMENT 'The date on which the document was last reviewed by EHS, procurement, or quality assurance personnel for compliance verification.',
    `tsca_compliant_flag` BOOLEAN COMMENT 'Indicates whether the document certifies compliance with US EPA TSCA requirements for chemical substances.',
    CONSTRAINT pk_vendor_document PRIMARY KEY(`vendor_document_id`)
) COMMENT 'Repository of compliance and regulatory documents received from chemical suppliers including SDS/MSDS, COA, COC, REACH registration dossiers, TSCA certifications, ISO certificates, GMP certificates, and Responsible Care attestations. Captures document type, vendor, material or CAS number reference, document version, issue date, expiry date, issuing authority, document file reference, and document validity status. Ensures regulatory document currency for EHS and procurement compliance.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`supply`.`toll_manufacturing_order` (
    `toll_manufacturing_order_id` BIGINT COMMENT 'System-generated unique identifier for the toll manufacturing order.',
    `manufacturing_order_id` BIGINT COMMENT 'Foreign key linking to production.manufacturing_order. Business justification: REQUIRED: Contract manufacturing orders must be linked to the internal manufacturing order they fulfill for cost allocation and traceability.',
    `material_master_id` BIGINT COMMENT 'Identifier of the chemical material to be produced under the toll order.',
    `toll_manufacturer_id` BIGINT COMMENT 'Identifier of the third‑party manufacturer performing the toll production.',
    `vendor_id` BIGINT COMMENT 'Identifier of the external vendor supplying the toll manufacturing service.',
    `rework_toll_manufacturing_order_id` BIGINT COMMENT 'Self-referencing FK on toll_manufacturing_order (rework_toll_manufacturing_order_id)',
    `actual_delivery_date` DATE COMMENT 'Date the product was actually received from the toll manufacturer.',
    `approval_status` STRING COMMENT 'Current approval state of the toll manufacturing order.. Valid values are `approved|rejected|pending`',
    `approved_by` BIGINT COMMENT 'Identifier of the employee who approved the order.',
    `approved_timestamp` TIMESTAMP COMMENT 'Timestamp when the order received final approval.',
    `batch_number` STRING COMMENT 'Identifier of the production batch generated by the toll manufacturer.',
    `cas_number` STRING COMMENT 'Chemical Abstracts Service registry number uniquely identifying the chemical substance.',
    `certificate_of_analysis_provided` BOOLEAN COMMENT 'Indicates whether a COA was supplied with the toll order.',
    `contract_number` STRING COMMENT 'Reference to the overarching contract governing this toll order.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this record was first captured in the lakehouse.',
    `currency_code` STRING COMMENT 'Three‑letter ISO code of the currency used for pricing.. Valid values are `USD|EUR|GBP|JPY|CNY|CAD`',
    `delivery_location_code` STRING COMMENT 'Plant or site code where the finished product will be received.',
    `delivery_schedule_end_date` DATE COMMENT 'Planned end date for the delivery window.',
    `delivery_schedule_start_date` DATE COMMENT 'Planned start date for the delivery window.',
    `ghs_hazard_category` STRING COMMENT 'GHS classification category for the material.',
    `gross_amount` DECIMAL(18,2) COMMENT 'Total amount before taxes and fees.',
    `hazmat_indicator` BOOLEAN COMMENT 'Flag indicating whether the material is classified as hazardous.',
    `incoterms` STRING COMMENT 'International commercial terms defining delivery responsibilities.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to this record.',
    `material_number` STRING COMMENT 'Customer‑facing material number or SKU for the product.',
    `net_amount` DECIMAL(18,2) COMMENT 'Final amount after taxes and any discounts.',
    `notes` STRING COMMENT 'Additional comments or special instructions related to the toll order.',
    `order_date` TIMESTAMP COMMENT 'Timestamp when the toll manufacturing order was created in the source system.',
    `order_number` STRING COMMENT 'External business identifier assigned to the toll manufacturing order.',
    `payment_terms` STRING COMMENT 'Payment terms agreed with the toll manufacturer (e.g., Net 30).',
    `price_per_unit` DECIMAL(18,2) COMMENT 'Agreed price for each unit of material produced.',
    `quality_requirements` STRING COMMENT 'Specific testing or certification requirements for the toll order.',
    `quality_specification` STRING COMMENT 'Detailed quality criteria the produced material must meet.',
    `quantity_requested` DECIMAL(18,2) COMMENT 'Amount of material to be produced by the toll manufacturer.',
    `required_delivery_date` DATE COMMENT 'Date by which the customer expects the finished product.',
    `safety_data_sheet_version` STRING COMMENT 'Version identifier of the SDS provided for the material.',
    `storage_location_code` STRING COMMENT 'Warehouse or storage bin identifier for the received product.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Tax component applied to the gross amount.',
    `tax_code` STRING COMMENT 'Code representing the tax jurisdiction and rate applied.',
    `toll_manufacturing_order_status` STRING COMMENT 'Current lifecycle state of the toll manufacturing order.. Valid values are `draft|released|in_progress|completed|cancelled|closed`',
    `un_number` STRING COMMENT 'United Nations identification number for hazardous substances.',
    `unit_of_measure` STRING COMMENT 'Measurement unit for the requested quantity.. Valid values are `kg|L|g|mg|m3|lb`',
    CONSTRAINT pk_toll_manufacturing_order PRIMARY KEY(`toll_manufacturing_order_id`)
) COMMENT 'Toll manufacturing (contract manufacturing) order record tracking outsourced chemical production to third-party manufacturers. Captures toll manufacturer, material, quantity, quality requirements, pricing terms, and delivery schedule.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`supply`.`toll_manufacturer` (
    `toll_manufacturer_id` BIGINT COMMENT 'System-generated unique identifier for the toll manufacturer record.',
    `parent_toll_manufacturer_id` BIGINT COMMENT 'Self-referencing FK on toll_manufacturer (parent_toll_manufacturer_id)',
    `capacity_annual_tons` DECIMAL(18,2) COMMENT 'Maximum amount of product the manufacturer can produce per year, expressed in metric tons.',
    `capacity_units` STRING COMMENT 'Unit of measure for the annual capacity field.. Valid values are `tons_per_year`',
    `effective_end_date` DATE COMMENT 'Date when the manufacturer record is no longer effective (null if still active).',
    `effective_start_date` DATE COMMENT 'Date when the manufacturer record became effective for business use.',
    `environmental_performance_rating` STRING COMMENT 'Rating of the manufacturer’s environmental compliance performance.. Valid values are `A|B|C|D|E`',
    `global_coverage_flag` BOOLEAN COMMENT 'Indicates whether the manufacturer can serve global supply locations.',
    `manufacturer_code` STRING COMMENT 'Internal alphanumeric code used to reference the toll manufacturer.',
    `manufacturer_name` STRING COMMENT 'Full legal name of the toll manufacturing organization.',
    `manufacturer_type` STRING COMMENT 'Classification of the toll manufacturer relationship type.. Valid values are `toll_contract|joint_venture|licensed_producer`',
    `manufacturing_process_type` STRING COMMENT 'Primary process mode the manufacturer uses for production.. Valid values are `batch|continuous|both`',
    `max_batch_size_kg` DECIMAL(18,2) COMMENT 'Largest single batch the manufacturer can produce, expressed in kilograms.',
    `max_continuous_rate_tph` DECIMAL(18,2) COMMENT 'Maximum continuous production rate, expressed in metric tons per hour.',
    `notes` STRING COMMENT 'Free‑form comments or observations about the manufacturer.',
    `number_of_sites` STRING COMMENT 'Count of distinct production sites operated by the manufacturer.',
    `primary_product_category` STRING COMMENT 'Main category of chemicals the manufacturer is qualified to produce.. Valid values are `basic_chemicals|intermediates|specialty|pharma|agri`',
    `regulatory_approvals` STRING COMMENT 'Comma‑separated list of key regulatory approvals held (e.g., REACH, TSCA, FDA).',
    `toll_manufacturer_status` STRING COMMENT 'Current lifecycle status of the toll manufacturer record.. Valid values are `active|inactive|suspended|pending|terminated`',
    CONSTRAINT pk_toll_manufacturer PRIMARY KEY(`toll_manufacturer_id`)
) COMMENT 'Master record for approved toll (contract) manufacturers qualified to produce chemical products on behalf of Chemical Mfg. Captures site capabilities, certifications, capacity, and qualification status.';

CREATE OR REPLACE TABLE `chemical_mfg_ecm`.`supply`.`supply_agreement` (
    `supply_agreement_id` BIGINT COMMENT 'Primary key for the SupplyAgreement association',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to the material master',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to the vendor',
    `compliance_status` STRING COMMENT 'Compliance status of the vendor for the material (e.g., REACH compliant, ISO certified)',
    `packaging_type` STRING COMMENT 'Packaging type used by the vendor for this material (e.g., Drum, Bulk, Bag)',
    `qualification_date` DATE COMMENT 'Date when the vendor was qualified for the material',
    `qualification_status` STRING COMMENT 'Current qualification status of the vendor for the material (e.g., Qualified, Pending, Disqualified)',
    `sds_version` STRING COMMENT 'Version identifier of the Safety Data Sheet used for the material from this vendor',
    `supply_risk_tier` STRING COMMENT 'Risk tier assigned to the vendor‑material supply relationship',
    CONSTRAINT pk_supply_agreement PRIMARY KEY(`supply_agreement_id`)
) COMMENT 'Represents the contractual and qualification relationship between a vendor and a raw material. Each record captures qualification status, qualification date, supply risk tier, compliance status, SDS version, and packaging type for a specific vendor‑material pairing.. Existence Justification: In chemical manufacturing a vendor can supply many raw materials and a raw material can be sourced from multiple vendors. The business actively manages each vendor‑material pairing with qualification status, dates, risk tier, compliance and packaging details. Therefore the relationship is an operational entity that is created, updated, and deleted by procurement teams.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_site` ADD CONSTRAINT `fk_supply_vendor_site_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `chemical_mfg_ecm`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `chemical_mfg_ecm`.`supply`.`purchase_order` ADD CONSTRAINT `fk_supply_purchase_order_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `chemical_mfg_ecm`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `chemical_mfg_ecm`.`supply`.`po_line` ADD CONSTRAINT `fk_supply_po_line_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `chemical_mfg_ecm`.`supply`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `chemical_mfg_ecm`.`supply`.`goods_receipt` ADD CONSTRAINT `fk_supply_goods_receipt_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `chemical_mfg_ecm`.`supply`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `chemical_mfg_ecm`.`supply`.`goods_receipt` ADD CONSTRAINT `fk_supply_goods_receipt_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `chemical_mfg_ecm`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `chemical_mfg_ecm`.`supply`.`asn` ADD CONSTRAINT `fk_supply_asn_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `chemical_mfg_ecm`.`supply`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `chemical_mfg_ecm`.`supply`.`asn` ADD CONSTRAINT `fk_supply_asn_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `chemical_mfg_ecm`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `chemical_mfg_ecm`.`supply`.`asn_line` ADD CONSTRAINT `fk_supply_asn_line_asn_id` FOREIGN KEY (`asn_id`) REFERENCES `chemical_mfg_ecm`.`supply`.`asn`(`asn_id`);
ALTER TABLE `chemical_mfg_ecm`.`supply`.`asn_line` ADD CONSTRAINT `fk_supply_asn_line_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `chemical_mfg_ecm`.`supply`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `chemical_mfg_ecm`.`supply`.`rfq_response` ADD CONSTRAINT `fk_supply_rfq_response_rfq_id` FOREIGN KEY (`rfq_id`) REFERENCES `chemical_mfg_ecm`.`supply`.`rfq`(`rfq_id`);
ALTER TABLE `chemical_mfg_ecm`.`supply`.`rfq_response` ADD CONSTRAINT `fk_supply_rfq_response_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `chemical_mfg_ecm`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `chemical_mfg_ecm`.`supply`.`contract` ADD CONSTRAINT `fk_supply_contract_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `chemical_mfg_ecm`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `chemical_mfg_ecm`.`supply`.`contract` ADD CONSTRAINT `fk_supply_contract_vendor_site_id` FOREIGN KEY (`vendor_site_id`) REFERENCES `chemical_mfg_ecm`.`supply`.`vendor_site`(`vendor_site_id`);
ALTER TABLE `chemical_mfg_ecm`.`supply`.`contract_price` ADD CONSTRAINT `fk_supply_contract_price_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `chemical_mfg_ecm`.`supply`.`contract`(`contract_id`);
ALTER TABLE `chemical_mfg_ecm`.`supply`.`contract_price` ADD CONSTRAINT `fk_supply_contract_price_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `chemical_mfg_ecm`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_scorecard` ADD CONSTRAINT `fk_supply_vendor_scorecard_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `chemical_mfg_ecm`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_qualification` ADD CONSTRAINT `fk_supply_vendor_qualification_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `chemical_mfg_ecm`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_audit` ADD CONSTRAINT `fk_supply_vendor_audit_vendor_document_id` FOREIGN KEY (`vendor_document_id`) REFERENCES `chemical_mfg_ecm`.`supply`.`vendor_document`(`vendor_document_id`);
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_audit` ADD CONSTRAINT `fk_supply_vendor_audit_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `chemical_mfg_ecm`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `chemical_mfg_ecm`.`supply`.`sourcing_risk` ADD CONSTRAINT `fk_supply_sourcing_risk_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `chemical_mfg_ecm`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `chemical_mfg_ecm`.`supply`.`supply_procurement_plan` ADD CONSTRAINT `fk_supply_supply_procurement_plan_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `chemical_mfg_ecm`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `chemical_mfg_ecm`.`supply`.`purchase_requisition` ADD CONSTRAINT `fk_supply_purchase_requisition_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `chemical_mfg_ecm`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `chemical_mfg_ecm`.`supply`.`purchase_requisition` ADD CONSTRAINT `fk_supply_purchase_requisition_rfq_id` FOREIGN KEY (`rfq_id`) REFERENCES `chemical_mfg_ecm`.`supply`.`rfq`(`rfq_id`);
ALTER TABLE `chemical_mfg_ecm`.`supply`.`source_list` ADD CONSTRAINT `fk_supply_source_list_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `chemical_mfg_ecm`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `chemical_mfg_ecm`.`supply`.`inbound_delivery` ADD CONSTRAINT `fk_supply_inbound_delivery_asn_id` FOREIGN KEY (`asn_id`) REFERENCES `chemical_mfg_ecm`.`supply`.`asn`(`asn_id`);
ALTER TABLE `chemical_mfg_ecm`.`supply`.`inbound_delivery` ADD CONSTRAINT `fk_supply_inbound_delivery_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `chemical_mfg_ecm`.`supply`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `chemical_mfg_ecm`.`supply`.`inbound_delivery` ADD CONSTRAINT `fk_supply_inbound_delivery_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `chemical_mfg_ecm`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `chemical_mfg_ecm`.`supply`.`inbound_delivery` ADD CONSTRAINT `fk_supply_inbound_delivery_vendor_site_id` FOREIGN KEY (`vendor_site_id`) REFERENCES `chemical_mfg_ecm`.`supply`.`vendor_site`(`vendor_site_id`);
ALTER TABLE `chemical_mfg_ecm`.`supply`.`invoice_verification` ADD CONSTRAINT `fk_supply_invoice_verification_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `chemical_mfg_ecm`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `chemical_mfg_ecm`.`supply`.`material_info_record` ADD CONSTRAINT `fk_supply_material_info_record_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `chemical_mfg_ecm`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `chemical_mfg_ecm`.`supply`.`delivery_schedule` ADD CONSTRAINT `fk_supply_delivery_schedule_supply_agreement_id` FOREIGN KEY (`supply_agreement_id`) REFERENCES `chemical_mfg_ecm`.`supply`.`supply_agreement`(`supply_agreement_id`);
ALTER TABLE `chemical_mfg_ecm`.`supply`.`delivery_schedule` ADD CONSTRAINT `fk_supply_delivery_schedule_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `chemical_mfg_ecm`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_document` ADD CONSTRAINT `fk_supply_vendor_document_superseded_by_document_vendor_document_id` FOREIGN KEY (`superseded_by_document_vendor_document_id`) REFERENCES `chemical_mfg_ecm`.`supply`.`vendor_document`(`vendor_document_id`);
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_document` ADD CONSTRAINT `fk_supply_vendor_document_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `chemical_mfg_ecm`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `chemical_mfg_ecm`.`supply`.`toll_manufacturing_order` ADD CONSTRAINT `fk_supply_toll_manufacturing_order_toll_manufacturer_id` FOREIGN KEY (`toll_manufacturer_id`) REFERENCES `chemical_mfg_ecm`.`supply`.`toll_manufacturer`(`toll_manufacturer_id`);
ALTER TABLE `chemical_mfg_ecm`.`supply`.`toll_manufacturing_order` ADD CONSTRAINT `fk_supply_toll_manufacturing_order_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `chemical_mfg_ecm`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `chemical_mfg_ecm`.`supply`.`toll_manufacturing_order` ADD CONSTRAINT `fk_supply_toll_manufacturing_order_rework_toll_manufacturing_order_id` FOREIGN KEY (`rework_toll_manufacturing_order_id`) REFERENCES `chemical_mfg_ecm`.`supply`.`toll_manufacturing_order`(`toll_manufacturing_order_id`);
ALTER TABLE `chemical_mfg_ecm`.`supply`.`toll_manufacturer` ADD CONSTRAINT `fk_supply_toll_manufacturer_parent_toll_manufacturer_id` FOREIGN KEY (`parent_toll_manufacturer_id`) REFERENCES `chemical_mfg_ecm`.`supply`.`toll_manufacturer`(`toll_manufacturer_id`);
ALTER TABLE `chemical_mfg_ecm`.`supply`.`supply_agreement` ADD CONSTRAINT `fk_supply_supply_agreement_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `chemical_mfg_ecm`.`supply`.`vendor`(`vendor_id`);

-- ========= TAGS =========
ALTER SCHEMA `chemical_mfg_ecm`.`supply` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `chemical_mfg_ecm`.`supply` SET TAGS ('dbx_domain' = 'supply');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor` SET TAGS ('dbx_subdomain' = 'vendor_management');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Identifier');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor` ALTER COLUMN `strategy_id` SET TAGS ('dbx_business_glossary_term' = 'Pricing Strategy Id (Foreign Key)');
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
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_site` SET TAGS ('dbx_subdomain' = 'vendor_management');
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
ALTER TABLE `chemical_mfg_ecm`.`supply`.`purchase_order` SET TAGS ('dbx_subdomain' = 'procurement_operations');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`purchase_order` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) ID');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`purchase_order` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`purchase_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Buyer Employee Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`purchase_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`purchase_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`purchase_order` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`purchase_order` ALTER COLUMN `internal_order_id` SET TAGS ('dbx_business_glossary_term' = 'Internal Order Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`purchase_order` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant ID');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`purchase_order` ALTER COLUMN `price_list_id` SET TAGS ('dbx_business_glossary_term' = 'Price List Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`purchase_order` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Rd Project Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`purchase_order` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`purchase_order` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`purchase_order` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|approved|rejected');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`purchase_order` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`purchase_order` ALTER COLUMN `approved_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`purchase_order` ALTER COLUMN `company_code` SET TAGS ('dbx_business_glossary_term' = 'Company Code');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`purchase_order` ALTER COLUMN `company_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`purchase_order` ALTER COLUMN `contract_number` SET TAGS ('dbx_business_glossary_term' = 'Contract Number');
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
ALTER TABLE `chemical_mfg_ecm`.`supply`.`po_line` SET TAGS ('dbx_subdomain' = 'procurement_operations');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`po_line` ALTER COLUMN `po_line_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Line Identifier');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`po_line` ALTER COLUMN `experimental_formulation_id` SET TAGS ('dbx_business_glossary_term' = 'Experimental Formulation Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`po_line` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Identifier');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`po_line` ALTER COLUMN `price_list_item_id` SET TAGS ('dbx_business_glossary_term' = 'Price List Item Id (Foreign Key)');
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
ALTER TABLE `chemical_mfg_ecm`.`supply`.`goods_receipt` SET TAGS ('dbx_subdomain' = 'logistics_receiving');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`goods_receipt` ALTER COLUMN `goods_receipt_id` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt Identifier');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`goods_receipt` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Site Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`goods_receipt` ALTER COLUMN `inspection_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Lot Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`goods_receipt` ALTER COLUMN `lab_experiment_id` SET TAGS ('dbx_business_glossary_term' = 'Lab Experiment Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`goods_receipt` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material ID');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`goods_receipt` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant ID');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`goods_receipt` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) ID');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`goods_receipt` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Receiver Employee ID');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`goods_receipt` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`goods_receipt` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`goods_receipt` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`goods_receipt` ALTER COLUMN `warehouse_location_id` SET TAGS ('dbx_business_glossary_term' = 'Storage Location ID');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`goods_receipt` ALTER COLUMN `asn_number` SET TAGS ('dbx_business_glossary_term' = 'Advanced Shipping Notice (ASN) Number');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`goods_receipt` ALTER COLUMN `asn_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{8,20}$');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`goods_receipt` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Number (LOT)');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`goods_receipt` ALTER COLUMN `batch_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`goods_receipt` ALTER COLUMN `carrier_name` SET TAGS ('dbx_business_glossary_term' = 'Carrier Name');
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
ALTER TABLE `chemical_mfg_ecm`.`supply`.`goods_receipt` ALTER COLUMN `sds_version` SET TAGS ('dbx_business_glossary_term' = 'Safety Data Sheet (SDS) Version');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`goods_receipt` ALTER COLUMN `sds_version` SET TAGS ('dbx_value_regex' = '^[0-9]{1,3}.[0-9]{1,2}$');
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
ALTER TABLE `chemical_mfg_ecm`.`supply`.`goods_receipt` ALTER COLUMN `vehicle_identification` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Identification');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`asn` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`asn` SET TAGS ('dbx_subdomain' = 'logistics_receiving');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`asn` ALTER COLUMN `asn_id` SET TAGS ('dbx_business_glossary_term' = 'Advanced Shipping Notice (ASN) ID');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`asn` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) ID');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`asn` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`asn` ALTER COLUMN `actual_arrival_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Arrival Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`asn` ALTER COLUMN `asn_number` SET TAGS ('dbx_business_glossary_term' = 'Advanced Shipping Notice (ASN) Number');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`asn` ALTER COLUMN `asn_number` SET TAGS ('dbx_value_regex' = '^ASN-[A-Z0-9]{8,15}$');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`asn` ALTER COLUMN `asn_status` SET TAGS ('dbx_business_glossary_term' = 'Advanced Shipping Notice (ASN) Status');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`asn` ALTER COLUMN `asn_type` SET TAGS ('dbx_business_glossary_term' = 'Advanced Shipping Notice (ASN) Type');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`asn` ALTER COLUMN `asn_type` SET TAGS ('dbx_value_regex' = 'standard|expedited|hazmat|bulk|consignment|drop_ship');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`asn` ALTER COLUMN `bill_of_lading_number` SET TAGS ('dbx_business_glossary_term' = 'Bill of Lading (BOL) Number');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`asn` ALTER COLUMN `bill_of_lading_number` SET TAGS ('dbx_value_regex' = '^BOL-[A-Z0-9]{8,20}$');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`asn` ALTER COLUMN `carrier_name` SET TAGS ('dbx_business_glossary_term' = 'Carrier Name');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`asn` ALTER COLUMN `carrier_scac_code` SET TAGS ('dbx_business_glossary_term' = 'Standard Carrier Alpha Code (SCAC)');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`asn` ALTER COLUMN `carrier_scac_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,4}$');
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
ALTER TABLE `chemical_mfg_ecm`.`supply`.`asn` ALTER COLUMN `shipping_point_code` SET TAGS ('dbx_business_glossary_term' = 'Shipping Point Code');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`asn` ALTER COLUMN `shipping_point_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
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
ALTER TABLE `chemical_mfg_ecm`.`supply`.`asn_line` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`asn_line` SET TAGS ('dbx_subdomain' = 'logistics_receiving');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`asn_line` ALTER COLUMN `asn_line_id` SET TAGS ('dbx_business_glossary_term' = 'Advanced Shipping Notice (ASN) Line Identifier');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`asn_line` ALTER COLUMN `asn_id` SET TAGS ('dbx_business_glossary_term' = 'Advanced Shipping Notice (ASN) Header Identifier');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`asn_line` ALTER COLUMN `experimental_formulation_id` SET TAGS ('dbx_business_glossary_term' = 'Experimental Formulation Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`asn_line` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Identifier');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`asn_line` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Identifier');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`asn_line` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Number');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`asn_line` ALTER COLUMN `cas_number` SET TAGS ('dbx_business_glossary_term' = 'Chemical Abstracts Service (CAS) Number');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`asn_line` ALTER COLUMN `cas_number` SET TAGS ('dbx_value_regex' = '^[1-9][0-9]{1,6}-[0-9]{2}-[0-9]$');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`asn_line` ALTER COLUMN `coa_number` SET TAGS ('dbx_business_glossary_term' = 'Certificate of Analysis (COA) Number');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`asn_line` ALTER COLUMN `coc_number` SET TAGS ('dbx_business_glossary_term' = 'Certificate of Compliance (COC) Number');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`asn_line` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_business_glossary_term' = 'Country of Origin');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`asn_line` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`asn_line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`asn_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`asn_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`asn_line` ALTER COLUMN `delivery_note_number` SET TAGS ('dbx_business_glossary_term' = 'Delivery Note Number');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`asn_line` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`asn_line` ALTER COLUMN `flash_point_celsius` SET TAGS ('dbx_business_glossary_term' = 'Flash Point (Celsius)');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`asn_line` ALTER COLUMN `gross_weight` SET TAGS ('dbx_business_glossary_term' = 'Gross Weight');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`asn_line` ALTER COLUMN `hazard_class` SET TAGS ('dbx_business_glossary_term' = 'Hazard Class');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`asn_line` ALTER COLUMN `inspection_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Inspection Required Flag');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`asn_line` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`asn_line` ALTER COLUMN `line_number` SET TAGS ('dbx_business_glossary_term' = 'Line Number');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`asn_line` ALTER COLUMN `line_value_amount` SET TAGS ('dbx_business_glossary_term' = 'Line Value Amount');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`asn_line` ALTER COLUMN `line_value_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`asn_line` ALTER COLUMN `lot_number` SET TAGS ('dbx_business_glossary_term' = 'Lot Number (LOT)');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`asn_line` ALTER COLUMN `manufacturing_date` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Date');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`asn_line` ALTER COLUMN `material_description` SET TAGS ('dbx_business_glossary_term' = 'Material Description');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`asn_line` ALTER COLUMN `material_number` SET TAGS ('dbx_business_glossary_term' = 'Material Number');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`asn_line` ALTER COLUMN `net_weight` SET TAGS ('dbx_business_glossary_term' = 'Net Weight');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`asn_line` ALTER COLUMN `number_of_packages` SET TAGS ('dbx_business_glossary_term' = 'Number of Packages');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`asn_line` ALTER COLUMN `packaging_type` SET TAGS ('dbx_business_glossary_term' = 'Packaging Type');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`asn_line` ALTER COLUMN `packing_group` SET TAGS ('dbx_business_glossary_term' = 'Packing Group');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`asn_line` ALTER COLUMN `packing_group` SET TAGS ('dbx_value_regex' = 'I|II|III');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`asn_line` ALTER COLUMN `po_line_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Line Number');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`asn_line` ALTER COLUMN `quarantine_status` SET TAGS ('dbx_business_glossary_term' = 'Quarantine Status');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`asn_line` ALTER COLUMN `quarantine_status` SET TAGS ('dbx_value_regex' = 'RELEASED|QUARANTINE|REJECTED|PENDING');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`asn_line` ALTER COLUMN `reach_registration_number` SET TAGS ('dbx_business_glossary_term' = 'Registration Evaluation Authorization and Restriction of Chemicals (REACH) Registration Number');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`asn_line` ALTER COLUMN `sds_revision_date` SET TAGS ('dbx_business_glossary_term' = 'Safety Data Sheet (SDS) Revision Date');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`asn_line` ALTER COLUMN `sds_version` SET TAGS ('dbx_business_glossary_term' = 'Safety Data Sheet (SDS) Version');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`asn_line` ALTER COLUMN `shipped_quantity` SET TAGS ('dbx_business_glossary_term' = 'Shipped Quantity');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`asn_line` ALTER COLUMN `storage_temperature_max_celsius` SET TAGS ('dbx_business_glossary_term' = 'Maximum Storage Temperature (Celsius)');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`asn_line` ALTER COLUMN `storage_temperature_min_celsius` SET TAGS ('dbx_business_glossary_term' = 'Minimum Storage Temperature (Celsius)');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`asn_line` ALTER COLUMN `un_number` SET TAGS ('dbx_business_glossary_term' = 'United Nations (UN) Number');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`asn_line` ALTER COLUMN `un_number` SET TAGS ('dbx_value_regex' = '^UN[0-9]{4}$');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`asn_line` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`asn_line` ALTER COLUMN `volume` SET TAGS ('dbx_business_glossary_term' = 'Volume');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`asn_line` ALTER COLUMN `volume_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Volume Unit of Measure');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`asn_line` ALTER COLUMN `volume_unit_of_measure` SET TAGS ('dbx_value_regex' = 'L|GAL|M3|ML');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`asn_line` ALTER COLUMN `weight_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Weight Unit of Measure');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`asn_line` ALTER COLUMN `weight_unit_of_measure` SET TAGS ('dbx_value_regex' = 'KG|LB|MT|TON');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`rfq` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`rfq` SET TAGS ('dbx_subdomain' = 'procurement_operations');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`rfq` ALTER COLUMN `rfq_id` SET TAGS ('dbx_business_glossary_term' = 'Request for Quotation (RFQ) ID');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`rfq` ALTER COLUMN `awarded_date` SET TAGS ('dbx_business_glossary_term' = 'Award Date');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`rfq` ALTER COLUMN `awarded_price` SET TAGS ('dbx_business_glossary_term' = 'Awarded Price');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`rfq` ALTER COLUMN `awarded_price` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`rfq` ALTER COLUMN `awarded_supplier_code` SET TAGS ('dbx_business_glossary_term' = 'Awarded Supplier Code');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`rfq` ALTER COLUMN `awarded_supplier_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,10}$');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`rfq` ALTER COLUMN `buyer_email` SET TAGS ('dbx_business_glossary_term' = 'Buyer Email Address');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`rfq` ALTER COLUMN `buyer_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`rfq` ALTER COLUMN `buyer_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`rfq` ALTER COLUMN `buyer_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`rfq` ALTER COLUMN `buyer_name` SET TAGS ('dbx_business_glossary_term' = 'Buyer Name');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`rfq` ALTER COLUMN `buyer_phone` SET TAGS ('dbx_business_glossary_term' = 'Buyer Phone Number');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`rfq` ALTER COLUMN `buyer_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`rfq` ALTER COLUMN `buyer_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`rfq` ALTER COLUMN `cas_number` SET TAGS ('dbx_business_glossary_term' = 'Chemical Abstracts Service (CAS) Number');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`rfq` ALTER COLUMN `cas_number` SET TAGS ('dbx_value_regex' = '^[0-9]{2,7}-[0-9]{2}-[0-9]$');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`rfq` ALTER COLUMN `closed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Request for Quotation (RFQ) Closed Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`rfq` ALTER COLUMN `contract_number` SET TAGS ('dbx_business_glossary_term' = 'Contract Number');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`rfq` ALTER COLUMN `contract_number` SET TAGS ('dbx_value_regex' = '^CTR-[0-9]{8,12}$');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`rfq` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`rfq` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`rfq` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`rfq` ALTER COLUMN `delivery_address` SET TAGS ('dbx_business_glossary_term' = 'Delivery Address');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`rfq` ALTER COLUMN `delivery_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`rfq` ALTER COLUMN `delivery_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`rfq` ALTER COLUMN `delivery_plant_code` SET TAGS ('dbx_business_glossary_term' = 'Delivery Plant Code');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`rfq` ALTER COLUMN `delivery_plant_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`rfq` ALTER COLUMN `evaluation_criteria` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Criteria');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`rfq` ALTER COLUMN `incoterm` SET TAGS ('dbx_business_glossary_term' = 'International Commercial Terms (Incoterms)');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`rfq` ALTER COLUMN `issue_date` SET TAGS ('dbx_business_glossary_term' = 'Request for Quotation (RFQ) Issue Date');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`rfq` ALTER COLUMN `material_code` SET TAGS ('dbx_business_glossary_term' = 'Material Code');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`rfq` ALTER COLUMN `material_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,18}$');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`rfq` ALTER COLUMN `material_description` SET TAGS ('dbx_business_glossary_term' = 'Material Description');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`rfq` ALTER COLUMN `minimum_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity (MOQ)');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`rfq` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`rfq` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Request for Quotation (RFQ) Notes');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`rfq` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`rfq` ALTER COLUMN `purchase_order_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Number');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`rfq` ALTER COLUMN `purchase_order_number` SET TAGS ('dbx_value_regex' = '^PO-[0-9]{8,12}$');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`rfq` ALTER COLUMN `purchasing_group` SET TAGS ('dbx_business_glossary_term' = 'Purchasing Group');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`rfq` ALTER COLUMN `purchasing_group` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,6}$');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`rfq` ALTER COLUMN `purchasing_organization` SET TAGS ('dbx_business_glossary_term' = 'Purchasing Organization');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`rfq` ALTER COLUMN `purchasing_organization` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`rfq` ALTER COLUMN `quality_requirements` SET TAGS ('dbx_business_glossary_term' = 'Quality Requirements');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`rfq` ALTER COLUMN `reach_compliance_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Registration Evaluation Authorization and Restriction of Chemicals (REACH) Compliance Required Flag');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`rfq` ALTER COLUMN `requested_quantity` SET TAGS ('dbx_business_glossary_term' = 'Requested Quantity');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`rfq` ALTER COLUMN `required_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Required Delivery Date');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`rfq` ALTER COLUMN `response_count` SET TAGS ('dbx_business_glossary_term' = 'Response Count');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`rfq` ALTER COLUMN `rfq_number` SET TAGS ('dbx_business_glossary_term' = 'Request for Quotation (RFQ) Number');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`rfq` ALTER COLUMN `rfq_number` SET TAGS ('dbx_value_regex' = '^RFQ-[0-9]{8,12}$');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`rfq` ALTER COLUMN `rfq_status` SET TAGS ('dbx_business_glossary_term' = 'Request for Quotation (RFQ) Status');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`rfq` ALTER COLUMN `rfq_type` SET TAGS ('dbx_business_glossary_term' = 'Request for Quotation (RFQ) Type');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`rfq` ALTER COLUMN `rfq_type` SET TAGS ('dbx_value_regex' = 'spot_buy|annual_contract_bid|emergency_source|framework_agreement|trial_order|bulk_purchase');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`rfq` ALTER COLUMN `sds_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Safety Data Sheet (SDS) Required Flag');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`rfq` ALTER COLUMN `submission_deadline` SET TAGS ('dbx_business_glossary_term' = 'Quotation Submission Deadline');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`rfq` ALTER COLUMN `supplier_count` SET TAGS ('dbx_business_glossary_term' = 'Supplier Count');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`rfq` ALTER COLUMN `technical_specifications` SET TAGS ('dbx_business_glossary_term' = 'Technical Specifications');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`rfq` ALTER COLUMN `tsca_compliance_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Toxic Substances Control Act (TSCA) Compliance Required Flag');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`rfq` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`rfq_response` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`rfq_response` SET TAGS ('dbx_subdomain' = 'procurement_operations');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`rfq_response` ALTER COLUMN `rfq_response_id` SET TAGS ('dbx_business_glossary_term' = 'Request for Quotation (RFQ) Response Identifier');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`rfq_response` ALTER COLUMN `rfq_id` SET TAGS ('dbx_business_glossary_term' = 'Request for Quotation (RFQ) Identifier');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`rfq_response` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Identifier');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`rfq_response` ALTER COLUMN `acceptance_date` SET TAGS ('dbx_business_glossary_term' = 'Acceptance Date');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`rfq_response` ALTER COLUMN `cas_number` SET TAGS ('dbx_business_glossary_term' = 'Chemical Abstracts Service (CAS) Number');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`rfq_response` ALTER COLUMN `cas_number` SET TAGS ('dbx_value_regex' = '^d{2,7}-d{2}-d$');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`rfq_response` ALTER COLUMN `coa_provided_flag` SET TAGS ('dbx_business_glossary_term' = 'Certificate of Analysis (COA) Provided Flag');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`rfq_response` ALTER COLUMN `coc_provided_flag` SET TAGS ('dbx_business_glossary_term' = 'Certificate of Compliance (COC) Provided Flag');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`rfq_response` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`rfq_response` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`rfq_response` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`rfq_response` ALTER COLUMN `delivery_location` SET TAGS ('dbx_business_glossary_term' = 'Delivery Location');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`rfq_response` ALTER COLUMN `evaluation_notes` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Notes');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`rfq_response` ALTER COLUMN `evaluation_score` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Score');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`rfq_response` ALTER COLUMN `incoterms` SET TAGS ('dbx_business_glossary_term' = 'International Commercial Terms (Incoterms)');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`rfq_response` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`rfq_response` ALTER COLUMN `material_grade` SET TAGS ('dbx_business_glossary_term' = 'Material Grade');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`rfq_response` ALTER COLUMN `minimum_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity (MOQ)');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`rfq_response` ALTER COLUMN `moq_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity (MOQ) Unit of Measure');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`rfq_response` ALTER COLUMN `packaging_size` SET TAGS ('dbx_business_glossary_term' = 'Packaging Size');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`rfq_response` ALTER COLUMN `packaging_type` SET TAGS ('dbx_business_glossary_term' = 'Packaging Type');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`rfq_response` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`rfq_response` ALTER COLUMN `price_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Price Unit of Measure (UOM)');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`rfq_response` ALTER COLUMN `price_validity_end_date` SET TAGS ('dbx_business_glossary_term' = 'Price Validity End Date');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`rfq_response` ALTER COLUMN `price_validity_start_date` SET TAGS ('dbx_business_glossary_term' = 'Price Validity Start Date');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`rfq_response` ALTER COLUMN `purity_percentage` SET TAGS ('dbx_business_glossary_term' = 'Purity Percentage');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`rfq_response` ALTER COLUMN `quoted_lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Quoted Lead Time (Days)');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`rfq_response` ALTER COLUMN `quoted_price` SET TAGS ('dbx_business_glossary_term' = 'Quoted Price');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`rfq_response` ALTER COLUMN `reach_compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'Registration Evaluation Authorization and Restriction of Chemicals (REACH) Compliant Flag');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`rfq_response` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`rfq_response` ALTER COLUMN `response_number` SET TAGS ('dbx_business_glossary_term' = 'Response Number');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`rfq_response` ALTER COLUMN `response_status` SET TAGS ('dbx_business_glossary_term' = 'Response Status');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`rfq_response` ALTER COLUMN `response_status` SET TAGS ('dbx_value_regex' = 'submitted|under_evaluation|accepted|rejected|withdrawn|expired');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`rfq_response` ALTER COLUMN `sds_available_flag` SET TAGS ('dbx_business_glossary_term' = 'Safety Data Sheet (SDS) Available Flag');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`rfq_response` ALTER COLUMN `shelf_life_months` SET TAGS ('dbx_business_glossary_term' = 'Shelf Life (Months)');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`rfq_response` ALTER COLUMN `submission_date` SET TAGS ('dbx_business_glossary_term' = 'Submission Date');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`rfq_response` ALTER COLUMN `submission_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Submission Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`rfq_response` ALTER COLUMN `technical_compliance_notes` SET TAGS ('dbx_business_glossary_term' = 'Technical Compliance Notes');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`rfq_response` ALTER COLUMN `tsca_compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'Toxic Substances Control Act (TSCA) Compliant Flag');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`rfq_response` ALTER COLUMN `vendor_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Vendor Contact Email Address');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`rfq_response` ALTER COLUMN `vendor_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`rfq_response` ALTER COLUMN `vendor_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`rfq_response` ALTER COLUMN `vendor_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Vendor Contact Name');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`rfq_response` ALTER COLUMN `vendor_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`rfq_response` ALTER COLUMN `vendor_contact_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`rfq_response` ALTER COLUMN `vendor_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Vendor Contact Phone Number');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`rfq_response` ALTER COLUMN `vendor_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`contract` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`contract` SET TAGS ('dbx_subdomain' = 'contract_administration');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`contract` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Identifier');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`contract` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`contract` ALTER COLUMN `material_master_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`contract` ALTER COLUMN `contract_material_material_master_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`contract` ALTER COLUMN `opportunity_id` SET TAGS ('dbx_business_glossary_term' = 'Opportunity Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`contract` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Owner Employee Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`contract` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`contract` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`contract` ALTER COLUMN `price_list_id` SET TAGS ('dbx_business_glossary_term' = 'Price List Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`contract` ALTER COLUMN `primary_contract_material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Identifier (ID)');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`contract` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Rd Project Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`contract` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Identifier (ID)');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`contract` ALTER COLUMN `vendor_site_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Site Identifier (ID)');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`contract` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`contract` ALTER COLUMN `approved_by_name` SET TAGS ('dbx_business_glossary_term' = 'Approved By Name');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`contract` ALTER COLUMN `auto_renewal_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto Renewal Flag');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`contract` ALTER COLUMN `cas_number` SET TAGS ('dbx_business_glossary_term' = 'Chemical Abstracts Service (CAS) Number');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`contract` ALTER COLUMN `cas_number` SET TAGS ('dbx_value_regex' = '^[0-9]{2,7}-[0-9]{2}-[0-9]$');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`contract` ALTER COLUMN `company_code` SET TAGS ('dbx_business_glossary_term' = 'Company Code');
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
ALTER TABLE `chemical_mfg_ecm`.`supply`.`contract` ALTER COLUMN `plant_code` SET TAGS ('dbx_business_glossary_term' = 'Plant Code');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`contract` ALTER COLUMN `price_currency` SET TAGS ('dbx_business_glossary_term' = 'Price Currency');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`contract` ALTER COLUMN `price_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`contract` ALTER COLUMN `price_escalation_clause` SET TAGS ('dbx_business_glossary_term' = 'Price Escalation Clause');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`contract` ALTER COLUMN `price_per_unit` SET TAGS ('dbx_business_glossary_term' = 'Price Per Unit');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`contract` ALTER COLUMN `price_unit` SET TAGS ('dbx_business_glossary_term' = 'Price Unit');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`contract` ALTER COLUMN `purchasing_group` SET TAGS ('dbx_business_glossary_term' = 'Purchasing Group');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`contract` ALTER COLUMN `purchasing_organization` SET TAGS ('dbx_business_glossary_term' = 'Purchasing Organization');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`contract` ALTER COLUMN `quality_specification` SET TAGS ('dbx_business_glossary_term' = 'Quality Specification');
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
ALTER TABLE `chemical_mfg_ecm`.`supply`.`contract_price` SET TAGS ('dbx_subdomain' = 'contract_administration');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`contract_price` ALTER COLUMN `contract_price_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Price Identifier (ID)');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`contract_price` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Identifier (ID)');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`contract_price` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Negotiated By Employee Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`contract_price` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`contract_price` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
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
ALTER TABLE `chemical_mfg_ecm`.`supply`.`contract_price` ALTER COLUMN `plant_code` SET TAGS ('dbx_business_glossary_term' = 'Plant Code');
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
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_scorecard` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_scorecard` SET TAGS ('dbx_subdomain' = 'vendor_management');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_scorecard` ALTER COLUMN `vendor_scorecard_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Scorecard ID');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_scorecard` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Evaluator ID');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_scorecard` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_scorecard` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_scorecard` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_scorecard` ALTER COLUMN `action_plan_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Action Plan Required Flag');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_scorecard` ALTER COLUMN `approved_date` SET TAGS ('dbx_business_glossary_term' = 'Approved Date');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_scorecard` ALTER COLUMN `audit_score` SET TAGS ('dbx_business_glossary_term' = 'Vendor Audit Score');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_scorecard` ALTER COLUMN `coa_compliance_rate_pct` SET TAGS ('dbx_business_glossary_term' = 'Certificate of Analysis (COA) Compliance Rate Percentage');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_scorecard` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Comments');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_scorecard` ALTER COLUMN `corrective_action_count` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Count');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_scorecard` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_scorecard` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_scorecard` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_scorecard` ALTER COLUMN `evaluation_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Period End Date');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_scorecard` ALTER COLUMN `evaluation_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Period Start Date');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_scorecard` ALTER COLUMN `evaluation_status` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Status');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_scorecard` ALTER COLUMN `evaluation_status` SET TAGS ('dbx_value_regex' = 'Draft|Under Review|Approved|Published|Archived');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_scorecard` ALTER COLUMN `innovation_score` SET TAGS ('dbx_business_glossary_term' = 'Innovation Score');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_scorecard` ALTER COLUMN `last_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Last Audit Date');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_scorecard` ALTER COLUMN `lead_time_adherence_pct` SET TAGS ('dbx_business_glossary_term' = 'Lead Time Adherence Percentage');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_scorecard` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_scorecard` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_scorecard` ALTER COLUMN `on_time_delivery_rate_pct` SET TAGS ('dbx_business_glossary_term' = 'On-Time Delivery Rate Percentage');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_scorecard` ALTER COLUMN `oos_incident_count` SET TAGS ('dbx_business_glossary_term' = 'Out of Specification (OOS) Incident Count');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_scorecard` ALTER COLUMN `oot_incident_count` SET TAGS ('dbx_business_glossary_term' = 'Out of Trend (OOT) Incident Count');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_scorecard` ALTER COLUMN `overall_score` SET TAGS ('dbx_business_glossary_term' = 'Overall Vendor Score');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_scorecard` ALTER COLUMN `packaging_compliance_rate_pct` SET TAGS ('dbx_business_glossary_term' = 'Packaging Compliance Rate Percentage');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_scorecard` ALTER COLUMN `price_variance_pct` SET TAGS ('dbx_business_glossary_term' = 'Price Variance Percentage');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_scorecard` ALTER COLUMN `quantity_accuracy_rate_pct` SET TAGS ('dbx_business_glossary_term' = 'Quantity Accuracy Rate Percentage');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_scorecard` ALTER COLUMN `reach_compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Registration Evaluation Authorization and Restriction of Chemicals (REACH) Compliance Status');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_scorecard` ALTER COLUMN `reach_compliance_status` SET TAGS ('dbx_value_regex' = 'Fully Compliant|Partially Compliant|Non-Compliant|Not Applicable');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_scorecard` ALTER COLUMN `rejected_shipment_count` SET TAGS ('dbx_business_glossary_term' = 'Rejected Shipment Count');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_scorecard` ALTER COLUMN `responsible_care_compliance_rating` SET TAGS ('dbx_business_glossary_term' = 'Responsible Care Compliance Rating');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_scorecard` ALTER COLUMN `responsible_care_compliance_rating` SET TAGS ('dbx_value_regex' = 'Certified|Compliant|Partially Compliant|Non-Compliant|Not Applicable');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_scorecard` ALTER COLUMN `responsiveness_score` SET TAGS ('dbx_business_glossary_term' = 'Vendor Responsiveness Score');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_scorecard` ALTER COLUMN `scorecard_number` SET TAGS ('dbx_business_glossary_term' = 'Scorecard Number');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_scorecard` ALTER COLUMN `scorecard_number` SET TAGS ('dbx_value_regex' = '^VSC-[0-9]{8}$');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_scorecard` ALTER COLUMN `sds_compliance_rate_pct` SET TAGS ('dbx_business_glossary_term' = 'Safety Data Sheet (SDS) Compliance Rate Percentage');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_scorecard` ALTER COLUMN `sustainability_score` SET TAGS ('dbx_business_glossary_term' = 'Sustainability Score');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_scorecard` ALTER COLUMN `total_order_count` SET TAGS ('dbx_business_glossary_term' = 'Total Order Count');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_scorecard` ALTER COLUMN `total_purchase_value` SET TAGS ('dbx_business_glossary_term' = 'Total Purchase Value');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_scorecard` ALTER COLUMN `total_purchase_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_scorecard` ALTER COLUMN `tsca_compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Toxic Substances Control Act (TSCA) Compliance Status');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_scorecard` ALTER COLUMN `tsca_compliance_status` SET TAGS ('dbx_value_regex' = 'Compliant|Non-Compliant|Not Applicable');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_qualification` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_qualification` SET TAGS ('dbx_subdomain' = 'vendor_management');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_qualification` ALTER COLUMN `vendor_qualification_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Qualification Identifier (ID)');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_qualification` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Lead Auditor Identifier (ID)');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_qualification` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_qualification` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
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
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_audit` SET TAGS ('dbx_subdomain' = 'vendor_management');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_audit` ALTER COLUMN `vendor_audit_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Audit Identifier (ID)');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_audit` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Lead Auditor Identifier (ID)');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_audit` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_audit` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_audit` ALTER COLUMN `vendor_document_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Report Document Identifier (ID)');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_audit` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Identifier (ID)');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_audit` ALTER COLUMN `audit_closure_date` SET TAGS ('dbx_business_glossary_term' = 'Audit Closure Date');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_audit` ALTER COLUMN `audit_date` SET TAGS ('dbx_business_glossary_term' = 'Audit Date');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_audit` ALTER COLUMN `audit_end_date` SET TAGS ('dbx_business_glossary_term' = 'Audit End Date');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_audit` ALTER COLUMN `audit_frequency_months` SET TAGS ('dbx_business_glossary_term' = 'Audit Frequency in Months');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_audit` ALTER COLUMN `audit_location` SET TAGS ('dbx_business_glossary_term' = 'Audit Location');
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
ALTER TABLE `chemical_mfg_ecm`.`supply`.`sourcing_risk` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`sourcing_risk` SET TAGS ('dbx_subdomain' = 'contract_administration');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`sourcing_risk` ALTER COLUMN `sourcing_risk_id` SET TAGS ('dbx_business_glossary_term' = 'Sourcing Risk Identifier');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`sourcing_risk` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Identifier (ID)');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`sourcing_risk` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Identifier (ID)');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`sourcing_risk` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Owner Employee Identifier (ID)');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`sourcing_risk` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`sourcing_risk` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`sourcing_risk` ALTER COLUMN `affected_supply_lane` SET TAGS ('dbx_business_glossary_term' = 'Affected Supply Lane Route');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`sourcing_risk` ALTER COLUMN `annual_spend_at_risk_usd` SET TAGS ('dbx_business_glossary_term' = 'Annual Spend at Risk in United States Dollars (USD)');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`sourcing_risk` ALTER COLUMN `annual_spend_at_risk_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`sourcing_risk` ALTER COLUMN `assessment_date` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Date');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`sourcing_risk` ALTER COLUMN `business_impact_description` SET TAGS ('dbx_business_glossary_term' = 'Business Impact Description');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`sourcing_risk` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`sourcing_risk` ALTER COLUMN `escalation_date` SET TAGS ('dbx_business_glossary_term' = 'Risk Escalation Date');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`sourcing_risk` ALTER COLUMN `escalation_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Escalation Required Flag');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`sourcing_risk` ALTER COLUMN `external_reference_code` SET TAGS ('dbx_business_glossary_term' = 'External Reference Identifier (ID)');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`sourcing_risk` ALTER COLUMN `geographic_region` SET TAGS ('dbx_business_glossary_term' = 'Geographic Region Affected');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`sourcing_risk` ALTER COLUMN `identified_date` SET TAGS ('dbx_business_glossary_term' = 'Risk Identification Date');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`sourcing_risk` ALTER COLUMN `lead_time_buffer_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time Buffer in Days');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`sourcing_risk` ALTER COLUMN `mitigation_actual_date` SET TAGS ('dbx_business_glossary_term' = 'Mitigation Actual Completion Date');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`sourcing_risk` ALTER COLUMN `mitigation_start_date` SET TAGS ('dbx_business_glossary_term' = 'Mitigation Start Date');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`sourcing_risk` ALTER COLUMN `mitigation_strategy` SET TAGS ('dbx_business_glossary_term' = 'Risk Mitigation Strategy Plan');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`sourcing_risk` ALTER COLUMN `mitigation_target_date` SET TAGS ('dbx_business_glossary_term' = 'Mitigation Target Completion Date');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`sourcing_risk` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`sourcing_risk` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Scheduled Review Date');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`sourcing_risk` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Risk Management Notes');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`sourcing_risk` ALTER COLUMN `regulatory_framework` SET TAGS ('dbx_business_glossary_term' = 'Applicable Regulatory Framework');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`sourcing_risk` ALTER COLUMN `review_frequency_days` SET TAGS ('dbx_business_glossary_term' = 'Risk Review Frequency in Days');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`sourcing_risk` ALTER COLUMN `risk_category` SET TAGS ('dbx_business_glossary_term' = 'Risk Category Classification');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`sourcing_risk` ALTER COLUMN `risk_category` SET TAGS ('dbx_value_regex' = 'single_source_dependency|geopolitical|regulatory_reach|raw_material_scarcity|financial_instability|natural_disaster');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`sourcing_risk` ALTER COLUMN `risk_description` SET TAGS ('dbx_business_glossary_term' = 'Risk Detailed Description');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`sourcing_risk` ALTER COLUMN `risk_exposure_value_usd` SET TAGS ('dbx_business_glossary_term' = 'Risk Exposure Value in United States Dollars (USD)');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`sourcing_risk` ALTER COLUMN `risk_exposure_value_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`sourcing_risk` ALTER COLUMN `risk_identifier` SET TAGS ('dbx_business_glossary_term' = 'Risk Business Identifier');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`sourcing_risk` ALTER COLUMN `risk_identifier` SET TAGS ('dbx_value_regex' = '^SRISK-[0-9]{8}$');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`sourcing_risk` ALTER COLUMN `risk_probability` SET TAGS ('dbx_business_glossary_term' = 'Risk Probability Likelihood');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`sourcing_risk` ALTER COLUMN `risk_probability` SET TAGS ('dbx_value_regex' = 'very_high|high|medium|low|very_low');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`sourcing_risk` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Risk Composite Score');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`sourcing_risk` ALTER COLUMN `risk_severity` SET TAGS ('dbx_business_glossary_term' = 'Risk Severity Level');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`sourcing_risk` ALTER COLUMN `risk_severity` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`sourcing_risk` ALTER COLUMN `risk_status` SET TAGS ('dbx_business_glossary_term' = 'Risk Lifecycle Status');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`sourcing_risk` ALTER COLUMN `risk_status` SET TAGS ('dbx_value_regex' = 'open|in_mitigation|mitigated|accepted|closed');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`sourcing_risk` ALTER COLUMN `risk_subcategory` SET TAGS ('dbx_business_glossary_term' = 'Risk Subcategory Detail');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`sourcing_risk` ALTER COLUMN `risk_title` SET TAGS ('dbx_business_glossary_term' = 'Risk Title Summary');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`sourcing_risk` ALTER COLUMN `safety_stock_recommendation_qty` SET TAGS ('dbx_business_glossary_term' = 'Safety Stock Recommendation Quantity');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`sourcing_risk` ALTER COLUMN `safety_stock_uom` SET TAGS ('dbx_business_glossary_term' = 'Safety Stock Unit of Measure (UOM)');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`sourcing_risk` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System of Record');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`supply_procurement_plan` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`supply_procurement_plan` SET TAGS ('dbx_subdomain' = 'procurement_operations');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`supply_procurement_plan` ALTER COLUMN `supply_procurement_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Procurement Plan ID');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`supply_procurement_plan` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`supply_procurement_plan` ALTER COLUMN `campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Production Campaign ID');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`supply_procurement_plan` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`supply_procurement_plan` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant ID');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`supply_procurement_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Planner ID');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`supply_procurement_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`supply_procurement_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`supply_procurement_plan` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material ID');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`supply_procurement_plan` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Rd Project Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`supply_procurement_plan` ALTER COLUMN `tertiary_supply_planner_employee_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`supply_procurement_plan` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`supply_procurement_plan` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`supply_procurement_plan` ALTER COLUMN `approval_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Approval Required Flag');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`supply_procurement_plan` ALTER COLUMN `cas_number` SET TAGS ('dbx_business_glossary_term' = 'Chemical Abstracts Service (CAS) Number');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`supply_procurement_plan` ALTER COLUMN `cas_number` SET TAGS ('dbx_value_regex' = '^[0-9]{2,7}-[0-9]{2}-[0-9]$');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`supply_procurement_plan` ALTER COLUMN `contract_number` SET TAGS ('dbx_business_glossary_term' = 'Contract Number');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`supply_procurement_plan` ALTER COLUMN `contract_number` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`supply_procurement_plan` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`supply_procurement_plan` ALTER COLUMN `estimated_unit_price` SET TAGS ('dbx_business_glossary_term' = 'Estimated Unit Price');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`supply_procurement_plan` ALTER COLUMN `estimated_unit_price` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`supply_procurement_plan` ALTER COLUMN `hazmat_transport_flag` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Material (HAZMAT) Transport Flag');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`supply_procurement_plan` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`supply_procurement_plan` ALTER COLUMN `lead_time_buffer_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time Buffer Days');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`supply_procurement_plan` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time Days');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`supply_procurement_plan` ALTER COLUMN `long_lead_time_flag` SET TAGS ('dbx_business_glossary_term' = 'Long Lead Time Flag');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`supply_procurement_plan` ALTER COLUMN `mrp_element` SET TAGS ('dbx_business_glossary_term' = 'Material Requirements Planning (MRP) Element');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`supply_procurement_plan` ALTER COLUMN `mrp_element` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{10}$');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`supply_procurement_plan` ALTER COLUMN `mrp_run_date` SET TAGS ('dbx_business_glossary_term' = 'Material Requirements Planning (MRP) Run Date');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`supply_procurement_plan` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Procurement Plan Notes');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`supply_procurement_plan` ALTER COLUMN `plan_number` SET TAGS ('dbx_business_glossary_term' = 'Procurement Plan Number');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`supply_procurement_plan` ALTER COLUMN `plan_number` SET TAGS ('dbx_value_regex' = '^PP-[0-9]{8}-[A-Z0-9]{4}$');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`supply_procurement_plan` ALTER COLUMN `plan_status` SET TAGS ('dbx_business_glossary_term' = 'Procurement Plan Status');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`supply_procurement_plan` ALTER COLUMN `plan_type` SET TAGS ('dbx_business_glossary_term' = 'Procurement Plan Type');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`supply_procurement_plan` ALTER COLUMN `plan_type` SET TAGS ('dbx_value_regex' = 'MRP_DRIVEN|SAFETY_STOCK|CAMPAIGN_BASED|SPOT_PURCHASE|STRATEGIC_SOURCING|CONSIGNMENT_REPLENISHMENT');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`supply_procurement_plan` ALTER COLUMN `planned_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Delivery Date');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`supply_procurement_plan` ALTER COLUMN `planned_order_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Order Date');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`supply_procurement_plan` ALTER COLUMN `planned_procurement_quantity` SET TAGS ('dbx_business_glossary_term' = 'Planned Procurement Quantity');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`supply_procurement_plan` ALTER COLUMN `planning_horizon` SET TAGS ('dbx_business_glossary_term' = 'Planning Horizon');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`supply_procurement_plan` ALTER COLUMN `planning_horizon` SET TAGS ('dbx_value_regex' = 'WEEKLY|MONTHLY|QUARTERLY|ANNUAL|ROLLING_12_MONTH|CAMPAIGN_SPECIFIC');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`supply_procurement_plan` ALTER COLUMN `plant_code` SET TAGS ('dbx_business_glossary_term' = 'Plant Code');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`supply_procurement_plan` ALTER COLUMN `plant_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`supply_procurement_plan` ALTER COLUMN `price_currency` SET TAGS ('dbx_business_glossary_term' = 'Price Currency');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`supply_procurement_plan` ALTER COLUMN `price_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`supply_procurement_plan` ALTER COLUMN `priority_code` SET TAGS ('dbx_business_glossary_term' = 'Priority Code');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`supply_procurement_plan` ALTER COLUMN `priority_code` SET TAGS ('dbx_value_regex' = 'CRITICAL|HIGH|NORMAL|LOW');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`supply_procurement_plan` ALTER COLUMN `procurement_type` SET TAGS ('dbx_business_glossary_term' = 'Procurement Type');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`supply_procurement_plan` ALTER COLUMN `procurement_type` SET TAGS ('dbx_value_regex' = 'STANDARD_PO|BLANKET_ORDER|CONTRACT_RELEASE|SPOT_BUY|EMERGENCY_PROCUREMENT|STOCK_TRANSFER');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`supply_procurement_plan` ALTER COLUMN `purchasing_group` SET TAGS ('dbx_business_glossary_term' = 'Purchasing Group');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`supply_procurement_plan` ALTER COLUMN `purchasing_group` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3}$');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`supply_procurement_plan` ALTER COLUMN `purchasing_organization` SET TAGS ('dbx_business_glossary_term' = 'Purchasing Organization');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`supply_procurement_plan` ALTER COLUMN `purchasing_organization` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`supply_procurement_plan` ALTER COLUMN `safety_stock_trigger_flag` SET TAGS ('dbx_business_glossary_term' = 'Safety Stock Trigger Flag');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`supply_procurement_plan` ALTER COLUMN `seasonal_material_flag` SET TAGS ('dbx_business_glossary_term' = 'Seasonal Material Flag');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`supply_procurement_plan` ALTER COLUMN `source_of_supply` SET TAGS ('dbx_business_glossary_term' = 'Source of Supply');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`supply_procurement_plan` ALTER COLUMN `source_of_supply` SET TAGS ('dbx_value_regex' = 'EXTERNAL_VENDOR|INTERCOMPANY_TRANSFER|TOLL_MANUFACTURING|CONSIGNMENT|CONTRACT_MANUFACTURER');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`supply_procurement_plan` ALTER COLUMN `supply_risk_level` SET TAGS ('dbx_business_glossary_term' = 'Supply Risk Level');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`supply_procurement_plan` ALTER COLUMN `supply_risk_level` SET TAGS ('dbx_value_regex' = 'LOW|MEDIUM|HIGH|CRITICAL');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`supply_procurement_plan` ALTER COLUMN `total_planned_value` SET TAGS ('dbx_business_glossary_term' = 'Total Planned Value');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`supply_procurement_plan` ALTER COLUMN `total_planned_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`supply_procurement_plan` ALTER COLUMN `un_number` SET TAGS ('dbx_business_glossary_term' = 'United Nations (UN) Number');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`supply_procurement_plan` ALTER COLUMN `un_number` SET TAGS ('dbx_value_regex' = '^UN[0-9]{4}$');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`supply_procurement_plan` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`purchase_requisition` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`purchase_requisition` SET TAGS ('dbx_subdomain' = 'procurement_operations');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`purchase_requisition` ALTER COLUMN `purchase_requisition_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Requisition (PR) ID');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`purchase_requisition` ALTER COLUMN `opportunity_id` SET TAGS ('dbx_business_glossary_term' = 'Opportunity Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`purchase_requisition` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Preferred Vendor ID');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`purchase_requisition` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Rd Project Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`purchase_requisition` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Requester Employee Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`purchase_requisition` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`purchase_requisition` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`purchase_requisition` ALTER COLUMN `rfq_id` SET TAGS ('dbx_business_glossary_term' = 'Rfq Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`purchase_requisition` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`purchase_requisition` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`purchase_requisition` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|escalated');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`purchase_requisition` ALTER COLUMN `approver_name` SET TAGS ('dbx_business_glossary_term' = 'Approver Name');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`purchase_requisition` ALTER COLUMN `campaign_production_flag` SET TAGS ('dbx_business_glossary_term' = 'Campaign Production Flag');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`purchase_requisition` ALTER COLUMN `cas_number` SET TAGS ('dbx_business_glossary_term' = 'Chemical Abstracts Service (CAS) Number');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`purchase_requisition` ALTER COLUMN `cas_number` SET TAGS ('dbx_value_regex' = '^[0-9]{2,7}-[0-9]{2}-[0-9]$');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`purchase_requisition` ALTER COLUMN `cost_center` SET TAGS ('dbx_business_glossary_term' = 'Cost Center');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`purchase_requisition` ALTER COLUMN `cost_center` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{10}$');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`purchase_requisition` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`purchase_requisition` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`purchase_requisition` ALTER COLUMN `estimated_total_value` SET TAGS ('dbx_business_glossary_term' = 'Estimated Total Value');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`purchase_requisition` ALTER COLUMN `estimated_unit_price` SET TAGS ('dbx_business_glossary_term' = 'Estimated Unit Price');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`purchase_requisition` ALTER COLUMN `ghs_classification` SET TAGS ('dbx_business_glossary_term' = 'Globally Harmonized System (GHS) Classification');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`purchase_requisition` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`purchase_requisition` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`purchase_requisition` ALTER COLUMN `hazmat_flag` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Material (HAZMAT) Flag');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`purchase_requisition` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`purchase_requisition` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Procurement Lead Time (Days)');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`purchase_requisition` ALTER COLUMN `material_description` SET TAGS ('dbx_business_glossary_term' = 'Material Description');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`purchase_requisition` ALTER COLUMN `material_number` SET TAGS ('dbx_business_glossary_term' = 'Material Number');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`purchase_requisition` ALTER COLUMN `material_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{18}$');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`purchase_requisition` ALTER COLUMN `mrp_element` SET TAGS ('dbx_business_glossary_term' = 'Material Requirements Planning (MRP) Element');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`purchase_requisition` ALTER COLUMN `mrp_element` SET TAGS ('dbx_value_regex' = 'planned_order|purchase_requisition|schedule_line');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`purchase_requisition` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Requisition Notes');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`purchase_requisition` ALTER COLUMN `planner_code` SET TAGS ('dbx_business_glossary_term' = 'Material Requirements Planning (MRP) Planner Code');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`purchase_requisition` ALTER COLUMN `planner_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3}$');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`purchase_requisition` ALTER COLUMN `planning_horizon` SET TAGS ('dbx_business_glossary_term' = 'Planning Horizon');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`purchase_requisition` ALTER COLUMN `planning_horizon` SET TAGS ('dbx_value_regex' = 'weekly|monthly|quarterly');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`purchase_requisition` ALTER COLUMN `plant_code` SET TAGS ('dbx_business_glossary_term' = 'Plant Code');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`purchase_requisition` ALTER COLUMN `plant_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`purchase_requisition` ALTER COLUMN `po_conversion_status` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Conversion Status');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`purchase_requisition` ALTER COLUMN `po_conversion_status` SET TAGS ('dbx_value_regex' = 'not_converted|partially_converted|fully_converted');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`purchase_requisition` ALTER COLUMN `po_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Number');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`purchase_requisition` ALTER COLUMN `po_number` SET TAGS ('dbx_value_regex' = '^PO[0-9]{10}$');
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
ALTER TABLE `chemical_mfg_ecm`.`supply`.`source_list` SET TAGS ('dbx_subdomain' = 'vendor_management');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`source_list` ALTER COLUMN `source_list_id` SET TAGS ('dbx_business_glossary_term' = 'Source List ID');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`source_list` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material ID');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`source_list` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`source_list` ALTER COLUMN `agreement_item` SET TAGS ('dbx_business_glossary_term' = 'Agreement Item');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`source_list` ALTER COLUMN `agreement_number` SET TAGS ('dbx_business_glossary_term' = 'Agreement Number');
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
ALTER TABLE `chemical_mfg_ecm`.`supply`.`source_list` ALTER COLUMN `material_number` SET TAGS ('dbx_business_glossary_term' = 'Material Number');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`source_list` ALTER COLUMN `minimum_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity (MOQ)');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`source_list` ALTER COLUMN `mrp_relevant_flag` SET TAGS ('dbx_business_glossary_term' = 'Material Requirements Planning (MRP) Relevant Flag');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`source_list` ALTER COLUMN `next_qualification_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Qualification Due Date');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`source_list` ALTER COLUMN `order_quantity_uom` SET TAGS ('dbx_business_glossary_term' = 'Order Quantity Unit of Measure (UOM)');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`source_list` ALTER COLUMN `plant_code` SET TAGS ('dbx_business_glossary_term' = 'Plant Code');
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
ALTER TABLE `chemical_mfg_ecm`.`supply`.`inbound_delivery` SET TAGS ('dbx_subdomain' = 'logistics_receiving');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`inbound_delivery` ALTER COLUMN `inbound_delivery_id` SET TAGS ('dbx_business_glossary_term' = 'Inbound Delivery ID');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`inbound_delivery` ALTER COLUMN `asn_id` SET TAGS ('dbx_business_glossary_term' = 'Advanced Shipping Notice (ASN) ID');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`inbound_delivery` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier ID');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`inbound_delivery` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Site Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`inbound_delivery` ALTER COLUMN `lab_experiment_id` SET TAGS ('dbx_business_glossary_term' = 'Lab Experiment Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`inbound_delivery` ALTER COLUMN `manufacturing_order_id` SET TAGS ('dbx_business_glossary_term' = 'Production Order Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`inbound_delivery` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`inbound_delivery` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Header ID');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`inbound_delivery` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`inbound_delivery` ALTER COLUMN `vendor_site_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Site ID');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`inbound_delivery` ALTER COLUMN `actual_arrival_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Arrival Date');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`inbound_delivery` ALTER COLUMN `actual_arrival_time` SET TAGS ('dbx_business_glossary_term' = 'Actual Arrival Time');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`inbound_delivery` ALTER COLUMN `bill_of_lading_number` SET TAGS ('dbx_business_glossary_term' = 'Bill of Lading (BOL) Number');
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
ALTER TABLE `chemical_mfg_ecm`.`supply`.`invoice_verification` SET TAGS ('dbx_subdomain' = 'logistics_receiving');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`invoice_verification` ALTER COLUMN `invoice_verification_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Verification ID');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`invoice_verification` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`invoice_verification` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`invoice_verification` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Rd Project Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`invoice_verification` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`invoice_verification` ALTER COLUMN `baseline_date` SET TAGS ('dbx_business_glossary_term' = 'Baseline Date');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`invoice_verification` ALTER COLUMN `blocking_reason` SET TAGS ('dbx_business_glossary_term' = 'Blocking Reason');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`invoice_verification` ALTER COLUMN `coa_received_flag` SET TAGS ('dbx_business_glossary_term' = 'Certificate of Analysis (COA) Received Flag');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`invoice_verification` ALTER COLUMN `coa_review_status` SET TAGS ('dbx_business_glossary_term' = 'Certificate of Analysis (COA) Review Status');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`invoice_verification` ALTER COLUMN `coa_review_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|approved|rejected|on_hold');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`invoice_verification` ALTER COLUMN `company_code` SET TAGS ('dbx_business_glossary_term' = 'Company Code');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`invoice_verification` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`invoice_verification` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`invoice_verification` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`invoice_verification` ALTER COLUMN `document_date` SET TAGS ('dbx_business_glossary_term' = 'Document Date');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`invoice_verification` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`invoice_verification` ALTER COLUMN `freight_charge` SET TAGS ('dbx_business_glossary_term' = 'Freight Charge');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`invoice_verification` ALTER COLUMN `goods_receipt_date` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt (GR) Date');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`invoice_verification` ALTER COLUMN `goods_receipt_number` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt (GR) Number');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`invoice_verification` ALTER COLUMN `hazmat_handling_fee` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Material (HAZMAT) Handling Fee');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`invoice_verification` ALTER COLUMN `index_escalator_amount` SET TAGS ('dbx_business_glossary_term' = 'Index Escalator Amount');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`invoice_verification` ALTER COLUMN `invoiced_amount` SET TAGS ('dbx_business_glossary_term' = 'Invoiced Amount');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`invoice_verification` ALTER COLUMN `invoiced_quantity` SET TAGS ('dbx_business_glossary_term' = 'Invoiced Quantity');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`invoice_verification` ALTER COLUMN `material_number` SET TAGS ('dbx_business_glossary_term' = 'Material Number');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`invoice_verification` ALTER COLUMN `payment_block_indicator` SET TAGS ('dbx_business_glossary_term' = 'Payment Block Indicator');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`invoice_verification` ALTER COLUMN `payment_due_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Due Date');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`invoice_verification` ALTER COLUMN `payment_release_by` SET TAGS ('dbx_business_glossary_term' = 'Payment Released By');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`invoice_verification` ALTER COLUMN `payment_release_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Release Date');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`invoice_verification` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`invoice_verification` ALTER COLUMN `plant_code` SET TAGS ('dbx_business_glossary_term' = 'Plant Code');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`invoice_verification` ALTER COLUMN `po_line_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Line Number');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`invoice_verification` ALTER COLUMN `po_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Number');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`invoice_verification` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Date');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`invoice_verification` ALTER COLUMN `posting_status` SET TAGS ('dbx_business_glossary_term' = 'Posting Status');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`invoice_verification` ALTER COLUMN `posting_status` SET TAGS ('dbx_value_regex' = 'draft|posted|reversed|parked|cancelled');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`invoice_verification` ALTER COLUMN `price_variance` SET TAGS ('dbx_business_glossary_term' = 'Price Variance');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`invoice_verification` ALTER COLUMN `quantity_variance` SET TAGS ('dbx_business_glossary_term' = 'Quantity Variance');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`invoice_verification` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`invoice_verification` ALTER COLUMN `tax_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Code');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`invoice_verification` ALTER COLUMN `total_invoice_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Invoice Amount');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`invoice_verification` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`invoice_verification` ALTER COLUMN `vendor_invoice_date` SET TAGS ('dbx_business_glossary_term' = 'Vendor Invoice Date');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`invoice_verification` ALTER COLUMN `vendor_invoice_number` SET TAGS ('dbx_business_glossary_term' = 'Vendor Invoice Number');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`invoice_verification` ALTER COLUMN `verification_document_number` SET TAGS ('dbx_business_glossary_term' = 'Verification Document Number');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`invoice_verification` ALTER COLUMN `verification_status` SET TAGS ('dbx_business_glossary_term' = 'Verification Status');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`invoice_verification` ALTER COLUMN `verification_status` SET TAGS ('dbx_value_regex' = 'pending|verified|rejected|blocked|approved|in_review');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`invoice_verification` ALTER COLUMN `verified_by` SET TAGS ('dbx_business_glossary_term' = 'Verified By');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`invoice_verification` ALTER COLUMN `verified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Verified Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`material_info_record` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`material_info_record` SET TAGS ('dbx_subdomain' = 'procurement_operations');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`material_info_record` ALTER COLUMN `material_info_record_id` SET TAGS ('dbx_business_glossary_term' = 'Material Info Record Identifier (ID)');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`material_info_record` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Identifier (ID)');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`material_info_record` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant Identifier (ID)');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`material_info_record` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Identifier (ID)');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`material_info_record` ALTER COLUMN `acknowledgement_required` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Acknowledgement Required Flag');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`material_info_record` ALTER COLUMN `agreement_item_number` SET TAGS ('dbx_business_glossary_term' = 'Agreement Item Number');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`material_info_record` ALTER COLUMN `agreement_item_number` SET TAGS ('dbx_value_regex' = '^[0-9]{5}$');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`material_info_record` ALTER COLUMN `blocked_source` SET TAGS ('dbx_business_glossary_term' = 'Blocked Source Indicator');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`material_info_record` ALTER COLUMN `certificate_of_analysis_required` SET TAGS ('dbx_business_glossary_term' = 'Certificate of Analysis (COA) Required Flag');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`material_info_record` ALTER COLUMN `contract_number` SET TAGS ('dbx_business_glossary_term' = 'Contract Number');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`material_info_record` ALTER COLUMN `contract_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{10}$');
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
ALTER TABLE `chemical_mfg_ecm`.`supply`.`delivery_schedule` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`delivery_schedule` SET TAGS ('dbx_subdomain' = 'logistics_receiving');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`delivery_schedule` ALTER COLUMN `delivery_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Supply Delivery Schedule ID');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`delivery_schedule` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material ID');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`delivery_schedule` ALTER COLUMN `supply_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Scheduling Agreement ID');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`delivery_schedule` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`delivery_schedule` ALTER COLUMN `actual_delivered_quantity` SET TAGS ('dbx_business_glossary_term' = 'Actual Delivered Quantity');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`delivery_schedule` ALTER COLUMN `actual_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Delivery Date');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`delivery_schedule` ALTER COLUMN `batch_managed_flag` SET TAGS ('dbx_business_glossary_term' = 'Batch Managed Flag');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`delivery_schedule` ALTER COLUMN `cas_number` SET TAGS ('dbx_business_glossary_term' = 'Chemical Abstracts Service (CAS) Number');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`delivery_schedule` ALTER COLUMN `cas_number` SET TAGS ('dbx_value_regex' = '^[0-9]{2,7}-[0-9]{2}-[0-9]$');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`delivery_schedule` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`delivery_schedule` ALTER COLUMN `cumulative_received_quantity` SET TAGS ('dbx_business_glossary_term' = 'Cumulative Received Quantity');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`delivery_schedule` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`delivery_schedule` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`delivery_schedule` ALTER COLUMN `delivery_category` SET TAGS ('dbx_business_glossary_term' = 'Delivery Category');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`delivery_schedule` ALTER COLUMN `delivery_category` SET TAGS ('dbx_value_regex' = 'forecast|firm|just_in_time|blanket|trade_off');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`delivery_schedule` ALTER COLUMN `delivery_tolerance_percentage` SET TAGS ('dbx_business_glossary_term' = 'Delivery Tolerance Percentage');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`delivery_schedule` ALTER COLUMN `goods_receipt_number` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt Number');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`delivery_schedule` ALTER COLUMN `hazmat_indicator` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Material (HAZMAT) Indicator');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`delivery_schedule` ALTER COLUMN `incoterms_code` SET TAGS ('dbx_business_glossary_term' = 'Incoterms Code');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`delivery_schedule` ALTER COLUMN `incoterms_location` SET TAGS ('dbx_business_glossary_term' = 'Incoterms Location');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`delivery_schedule` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`delivery_schedule` ALTER COLUMN `material_group` SET TAGS ('dbx_business_glossary_term' = 'Material Group');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`delivery_schedule` ALTER COLUMN `net_value` SET TAGS ('dbx_business_glossary_term' = 'Net Value');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`delivery_schedule` ALTER COLUMN `outstanding_quantity` SET TAGS ('dbx_business_glossary_term' = 'Outstanding Quantity');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`delivery_schedule` ALTER COLUMN `plant_code` SET TAGS ('dbx_business_glossary_term' = 'Plant Code');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`delivery_schedule` ALTER COLUMN `price_per_unit` SET TAGS ('dbx_business_glossary_term' = 'Price Per Unit');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`delivery_schedule` ALTER COLUMN `purchasing_group` SET TAGS ('dbx_business_glossary_term' = 'Purchasing Group');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`delivery_schedule` ALTER COLUMN `quality_inspection_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Quality Inspection Required Flag');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`delivery_schedule` ALTER COLUMN `release_date` SET TAGS ('dbx_business_glossary_term' = 'Release Date');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`delivery_schedule` ALTER COLUMN `release_strategy` SET TAGS ('dbx_business_glossary_term' = 'Release Strategy');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`delivery_schedule` ALTER COLUMN `release_strategy` SET TAGS ('dbx_value_regex' = 'immediate|forecast_based|consumption_based|manual');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`delivery_schedule` ALTER COLUMN `schedule_line_number` SET TAGS ('dbx_business_glossary_term' = 'Schedule Line Number');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`delivery_schedule` ALTER COLUMN `schedule_line_status` SET TAGS ('dbx_business_glossary_term' = 'Schedule Line Status');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`delivery_schedule` ALTER COLUMN `schedule_line_status` SET TAGS ('dbx_value_regex' = 'open|confirmed|partially_delivered|fully_delivered|cancelled|blocked');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`delivery_schedule` ALTER COLUMN `scheduled_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Delivery Date');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`delivery_schedule` ALTER COLUMN `scheduled_quantity` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Quantity');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`delivery_schedule` ALTER COLUMN `shipping_method` SET TAGS ('dbx_business_glossary_term' = 'Shipping Method');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`delivery_schedule` ALTER COLUMN `shipping_method` SET TAGS ('dbx_value_regex' = 'truck|rail|ocean|air|pipeline|intermodal');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`delivery_schedule` ALTER COLUMN `special_handling_instructions` SET TAGS ('dbx_business_glossary_term' = 'Special Handling Instructions');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`delivery_schedule` ALTER COLUMN `storage_location` SET TAGS ('dbx_business_glossary_term' = 'Storage Location');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`delivery_schedule` ALTER COLUMN `un_number` SET TAGS ('dbx_business_glossary_term' = 'United Nations (UN) Number');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`delivery_schedule` ALTER COLUMN `un_number` SET TAGS ('dbx_value_regex' = '^UN[0-9]{4}$');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`delivery_schedule` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`delivery_schedule` ALTER COLUMN `vendor_confirmation_date` SET TAGS ('dbx_business_glossary_term' = 'Vendor Confirmation Date');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`delivery_schedule` ALTER COLUMN `vendor_confirmed_quantity` SET TAGS ('dbx_business_glossary_term' = 'Vendor Confirmed Quantity');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_document` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_document` SET TAGS ('dbx_subdomain' = 'vendor_management');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_document` ALTER COLUMN `vendor_document_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Document ID');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_document` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material ID');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_document` ALTER COLUMN `superseded_by_document_vendor_document_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded By Document ID');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_document` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_document` ALTER COLUMN `applicable_region` SET TAGS ('dbx_business_glossary_term' = 'Applicable Region');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_document` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_document` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'APPROVED|PENDING_APPROVAL|REJECTED|NOT_REQUIRED');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_document` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_document` ALTER COLUMN `approved_date` SET TAGS ('dbx_business_glossary_term' = 'Approved Date');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_document` ALTER COLUMN `cas_number` SET TAGS ('dbx_business_glossary_term' = 'Chemical Abstracts Service (CAS) Number');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_document` ALTER COLUMN `cas_number` SET TAGS ('dbx_value_regex' = '^[1-9][0-9]{1,6}-[0-9]{2}-[0-9]$');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_document` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_document` ALTER COLUMN `document_hash` SET TAGS ('dbx_business_glossary_term' = 'Document Hash');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_document` ALTER COLUMN `document_language` SET TAGS ('dbx_business_glossary_term' = 'Document Language');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_document` ALTER COLUMN `document_language` SET TAGS ('dbx_value_regex' = '^[a-z]{2}$');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_document` ALTER COLUMN `document_number` SET TAGS ('dbx_business_glossary_term' = 'Document Number');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_document` ALTER COLUMN `document_status` SET TAGS ('dbx_business_glossary_term' = 'Document Status');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_document` ALTER COLUMN `document_status` SET TAGS ('dbx_value_regex' = 'ACTIVE|EXPIRED|SUPERSEDED|PENDING_REVIEW|REJECTED|ARCHIVED');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_document` ALTER COLUMN `document_type` SET TAGS ('dbx_business_glossary_term' = 'Document Type');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_document` ALTER COLUMN `document_version` SET TAGS ('dbx_business_glossary_term' = 'Document Version');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_document` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_document` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_document` ALTER COLUMN `file_format` SET TAGS ('dbx_business_glossary_term' = 'File Format');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_document` ALTER COLUMN `file_name` SET TAGS ('dbx_business_glossary_term' = 'File Name');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_document` ALTER COLUMN `file_path` SET TAGS ('dbx_business_glossary_term' = 'File Path');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_document` ALTER COLUMN `file_size_kb` SET TAGS ('dbx_business_glossary_term' = 'File Size (KB)');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_document` ALTER COLUMN `ghs_compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'Globally Harmonized System (GHS) Compliant Flag');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_document` ALTER COLUMN `issue_date` SET TAGS ('dbx_business_glossary_term' = 'Issue Date');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_document` ALTER COLUMN `issuing_authority` SET TAGS ('dbx_business_glossary_term' = 'Issuing Authority');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_document` ALTER COLUMN `issuing_authority_country` SET TAGS ('dbx_business_glossary_term' = 'Issuing Authority Country');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_document` ALTER COLUMN `issuing_authority_country` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_document` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_document` ALTER COLUMN `material_number` SET TAGS ('dbx_business_glossary_term' = 'Material Number');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_document` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_document` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_document` ALTER COLUMN `reach_compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'Registration Evaluation Authorization and Restriction of Chemicals (REACH) Compliant Flag');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_document` ALTER COLUMN `received_by` SET TAGS ('dbx_business_glossary_term' = 'Received By');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_document` ALTER COLUMN `received_date` SET TAGS ('dbx_business_glossary_term' = 'Received Date');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_document` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_document` ALTER COLUMN `reviewed_by` SET TAGS ('dbx_business_glossary_term' = 'Reviewed By');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_document` ALTER COLUMN `reviewed_date` SET TAGS ('dbx_business_glossary_term' = 'Reviewed Date');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`vendor_document` ALTER COLUMN `tsca_compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'Toxic Substances Control Act (TSCA) Compliant Flag');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`toll_manufacturing_order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`toll_manufacturing_order` SET TAGS ('dbx_subdomain' = 'contract_administration');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`toll_manufacturing_order` ALTER COLUMN `toll_manufacturing_order_id` SET TAGS ('dbx_business_glossary_term' = 'Toll Manufacturing Order ID');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`toll_manufacturing_order` ALTER COLUMN `manufacturing_order_id` SET TAGS ('dbx_business_glossary_term' = 'Production Order Id (Foreign Key)');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`toll_manufacturing_order` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material ID');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`toll_manufacturing_order` ALTER COLUMN `toll_manufacturer_id` SET TAGS ('dbx_business_glossary_term' = 'Toll Manufacturer ID');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`toll_manufacturing_order` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`toll_manufacturing_order` ALTER COLUMN `rework_toll_manufacturing_order_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`toll_manufacturing_order` ALTER COLUMN `actual_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Delivery Date');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`toll_manufacturing_order` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`toll_manufacturing_order` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'approved|rejected|pending');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`toll_manufacturing_order` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By Employee ID');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`toll_manufacturing_order` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`toll_manufacturing_order` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Number');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`toll_manufacturing_order` ALTER COLUMN `cas_number` SET TAGS ('dbx_business_glossary_term' = 'CAS Number');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`toll_manufacturing_order` ALTER COLUMN `certificate_of_analysis_provided` SET TAGS ('dbx_business_glossary_term' = 'Certificate of Analysis Provided');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`toll_manufacturing_order` ALTER COLUMN `contract_number` SET TAGS ('dbx_business_glossary_term' = 'Contract Number');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`toll_manufacturing_order` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`toll_manufacturing_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`toll_manufacturing_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|EUR|GBP|JPY|CNY|CAD');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`toll_manufacturing_order` ALTER COLUMN `delivery_location_code` SET TAGS ('dbx_business_glossary_term' = 'Delivery Location Code');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`toll_manufacturing_order` ALTER COLUMN `delivery_schedule_end_date` SET TAGS ('dbx_business_glossary_term' = 'Delivery Schedule End Date');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`toll_manufacturing_order` ALTER COLUMN `delivery_schedule_start_date` SET TAGS ('dbx_business_glossary_term' = 'Delivery Schedule Start Date');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`toll_manufacturing_order` ALTER COLUMN `ghs_hazard_category` SET TAGS ('dbx_business_glossary_term' = 'GHS Hazard Category');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`toll_manufacturing_order` ALTER COLUMN `gross_amount` SET TAGS ('dbx_business_glossary_term' = 'Gross Amount');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`toll_manufacturing_order` ALTER COLUMN `hazmat_indicator` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Material Indicator');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`toll_manufacturing_order` ALTER COLUMN `incoterms` SET TAGS ('dbx_business_glossary_term' = 'Incoterms');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`toll_manufacturing_order` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`toll_manufacturing_order` ALTER COLUMN `material_number` SET TAGS ('dbx_business_glossary_term' = 'Material Number');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`toll_manufacturing_order` ALTER COLUMN `net_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Amount');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`toll_manufacturing_order` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`toll_manufacturing_order` ALTER COLUMN `order_date` SET TAGS ('dbx_business_glossary_term' = 'Order Date');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`toll_manufacturing_order` ALTER COLUMN `order_number` SET TAGS ('dbx_business_glossary_term' = 'Order Number');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`toll_manufacturing_order` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`toll_manufacturing_order` ALTER COLUMN `price_per_unit` SET TAGS ('dbx_business_glossary_term' = 'Price Per Unit');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`toll_manufacturing_order` ALTER COLUMN `quality_requirements` SET TAGS ('dbx_business_glossary_term' = 'Quality Requirements');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`toll_manufacturing_order` ALTER COLUMN `quality_specification` SET TAGS ('dbx_business_glossary_term' = 'Quality Specification');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`toll_manufacturing_order` ALTER COLUMN `quantity_requested` SET TAGS ('dbx_business_glossary_term' = 'Requested Quantity');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`toll_manufacturing_order` ALTER COLUMN `required_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Required Delivery Date');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`toll_manufacturing_order` ALTER COLUMN `safety_data_sheet_version` SET TAGS ('dbx_business_glossary_term' = 'Safety Data Sheet Version');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`toll_manufacturing_order` ALTER COLUMN `storage_location_code` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Code');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`toll_manufacturing_order` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`toll_manufacturing_order` ALTER COLUMN `tax_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Code');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`toll_manufacturing_order` ALTER COLUMN `toll_manufacturing_order_status` SET TAGS ('dbx_business_glossary_term' = 'Order Status');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`toll_manufacturing_order` ALTER COLUMN `toll_manufacturing_order_status` SET TAGS ('dbx_value_regex' = 'draft|released|in_progress|completed|cancelled|closed');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`toll_manufacturing_order` ALTER COLUMN `un_number` SET TAGS ('dbx_business_glossary_term' = 'UN Number');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`toll_manufacturing_order` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`toll_manufacturing_order` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'kg|L|g|mg|m3|lb');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`toll_manufacturer` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`toll_manufacturer` SET TAGS ('dbx_subdomain' = 'vendor_management');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`toll_manufacturer` ALTER COLUMN `toll_manufacturer_id` SET TAGS ('dbx_business_glossary_term' = 'Toll Manufacturer Identifier');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`toll_manufacturer` ALTER COLUMN `parent_toll_manufacturer_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`toll_manufacturer` ALTER COLUMN `capacity_annual_tons` SET TAGS ('dbx_business_glossary_term' = 'Annual Production Capacity (Tons)');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`toll_manufacturer` ALTER COLUMN `capacity_units` SET TAGS ('dbx_business_glossary_term' = 'Capacity Unit of Measure');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`toll_manufacturer` ALTER COLUMN `capacity_units` SET TAGS ('dbx_value_regex' = 'tons_per_year');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`toll_manufacturer` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`toll_manufacturer` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`toll_manufacturer` ALTER COLUMN `environmental_performance_rating` SET TAGS ('dbx_business_glossary_term' = 'Environmental Performance Rating');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`toll_manufacturer` ALTER COLUMN `environmental_performance_rating` SET TAGS ('dbx_value_regex' = 'A|B|C|D|E');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`toll_manufacturer` ALTER COLUMN `global_coverage_flag` SET TAGS ('dbx_business_glossary_term' = 'Global Coverage Flag');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`toll_manufacturer` ALTER COLUMN `manufacturer_code` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Code');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`toll_manufacturer` ALTER COLUMN `manufacturer_name` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Legal Name');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`toll_manufacturer` ALTER COLUMN `manufacturer_type` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Type');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`toll_manufacturer` ALTER COLUMN `manufacturer_type` SET TAGS ('dbx_value_regex' = 'toll_contract|joint_venture|licensed_producer');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`toll_manufacturer` ALTER COLUMN `manufacturing_process_type` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Process Type');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`toll_manufacturer` ALTER COLUMN `manufacturing_process_type` SET TAGS ('dbx_value_regex' = 'batch|continuous|both');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`toll_manufacturer` ALTER COLUMN `max_batch_size_kg` SET TAGS ('dbx_business_glossary_term' = 'Maximum Batch Size (Kg)');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`toll_manufacturer` ALTER COLUMN `max_continuous_rate_tph` SET TAGS ('dbx_business_glossary_term' = 'Maximum Continuous Rate (Tons per Hour)');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`toll_manufacturer` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`toll_manufacturer` ALTER COLUMN `number_of_sites` SET TAGS ('dbx_business_glossary_term' = 'Number of Manufacturing Sites');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`toll_manufacturer` ALTER COLUMN `primary_product_category` SET TAGS ('dbx_business_glossary_term' = 'Primary Product Category');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`toll_manufacturer` ALTER COLUMN `primary_product_category` SET TAGS ('dbx_value_regex' = 'basic_chemicals|intermediates|specialty|pharma|agri');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`toll_manufacturer` ALTER COLUMN `regulatory_approvals` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approvals');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`toll_manufacturer` ALTER COLUMN `toll_manufacturer_status` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Status');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`toll_manufacturer` ALTER COLUMN `toll_manufacturer_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|pending|terminated');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`supply_agreement` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`supply_agreement` SET TAGS ('dbx_subdomain' = 'contract_administration');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`supply_agreement` SET TAGS ('dbx_association_edges' = 'supply.vendor,rawmaterial.material_master');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`supply_agreement` ALTER COLUMN `supply_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Supplyagreement - Supply Agreement Id');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`supply_agreement` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Supplyagreement - Material Master Id');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`supply_agreement` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Supplyagreement - Vendor Id');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`supply_agreement` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`supply_agreement` ALTER COLUMN `packaging_type` SET TAGS ('dbx_business_glossary_term' = 'Packaging Type');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`supply_agreement` ALTER COLUMN `qualification_date` SET TAGS ('dbx_business_glossary_term' = 'Qualification Date');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`supply_agreement` ALTER COLUMN `qualification_status` SET TAGS ('dbx_business_glossary_term' = 'Qualification Status');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`supply_agreement` ALTER COLUMN `sds_version` SET TAGS ('dbx_business_glossary_term' = 'SDS Version');
ALTER TABLE `chemical_mfg_ecm`.`supply`.`supply_agreement` ALTER COLUMN `supply_risk_tier` SET TAGS ('dbx_business_glossary_term' = 'Supply Risk Tier');
