-- Schema for Domain: procurement | Business: Mining | Version: v1_mvm
-- Generated on: 2026-05-05 14:20:18

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `mining_ecm`.`procurement` COMMENT 'Manages the strategic and transactional procurement lifecycle including vendor management, purchase orders, goods receipts, sourcing events, contracts, and vendor performance evaluation for mining operations';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `mining_ecm`.`procurement`.`material_master` (
    `material_master_id` BIGINT COMMENT 'Primary key for material_master',
    `grade_parameter_id` BIGINT COMMENT 'Foreign key linking to product.grade_parameter. Business justification: Mining material masters for ore, concentrate, and process chemicals are defined against specific grade parameters (Fe%, Cu%, moisture%) governing quality acceptance, LIMS integration, and pricing adju',
    `abc_indicator` STRING COMMENT 'Classification of material importance based on consumption value or criticality. A=High value/critical, B=Medium, C=Low value/non-critical.. Valid values are `A|B|C`',
    `base_unit_of_measure` STRING COMMENT 'The primary unit in which the material quantity is managed (e.g., KG=kilogram, L=liter, EA=each, M=meter, TON=tonne).. Valid values are `^[A-Z]{2,3}$`',
    `batch_management_indicator` BOOLEAN COMMENT 'Flag indicating whether the material is managed in batches for traceability and quality control purposes.',
    `commodity_category` STRING COMMENT 'High-level classification of the material by commodity type for strategic sourcing and spend analysis in mining operations. [ENUM-REF-CANDIDATE: explosives|reagents|fuel|tyres|lubricants|spare_parts|consumables|ppe|chemicals|equipment — 10 candidates stripped; promote to reference product]',
    `created_date` DATE COMMENT 'Date when the material master record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO currency code for material pricing and valuation (e.g., USD, AUD, CAD).. Valid values are `^[A-Z]{3}$`',
    `deletion_indicator` BOOLEAN COMMENT 'Flag indicating that the material master record is marked for deletion and should not be used in new transactions.',
    `gross_weight` DECIMAL(18,2) COMMENT 'Total weight of the material including packaging, expressed in the weight unit.',
    `hazard_class` STRING COMMENT 'Classification code for hazardous materials according to regulatory standards (e.g., UN hazard class for explosives, flammable liquids, corrosives).',
    `hazardous_material_indicator` BOOLEAN COMMENT 'Flag indicating whether the material is classified as hazardous and requires special handling, storage, and regulatory compliance (e.g., explosives, acids, reagents).',
    `last_modified_date` DATE COMMENT 'Date when the material master record was last updated or changed.',
    `manufacturer_name` STRING COMMENT 'Name of the original equipment manufacturer or producer of the material.',
    `manufacturer_part_number` STRING COMMENT 'Original equipment manufacturers part number or catalog identifier for the material.',
    `material_description` STRING COMMENT 'Short textual description of the material providing human-readable identification of the item.',
    `material_group` STRING COMMENT 'Grouping code used to classify materials by commodity category for procurement and reporting purposes (e.g., explosives, reagents, fuel, tyres, lubricants, spare parts).. Valid values are `^[A-Z0-9]{4,10}$`',
    `material_number` STRING COMMENT 'Unique alphanumeric identifier assigned to the material in the ERP system. This is the business key used across procurement, inventory, and warehouse operations.. Valid values are `^[A-Z0-9]{8,18}$`',
    `material_status` STRING COMMENT 'Current lifecycle status of the material master record indicating whether the material is available for procurement and use.. Valid values are `active|inactive|blocked|obsolete|pending_approval`',
    `material_type` STRING COMMENT 'Classification of the material defining its procurement and inventory behavior. ROH=Raw Material, HIBE=Operating Supplies, FERT=Finished Product, HALB=Semi-Finished, ERSA=Spare Parts, VERP=Packaging, DIEN=Services, NLAG=Non-Stock Material. [ENUM-REF-CANDIDATE: ROH|HIBE|FERT|HALB|ERSA|VERP|DIEN|NLAG — 8 candidates stripped; promote to reference product]',
    `maximum_stock_quantity` DECIMAL(18,2) COMMENT 'Upper limit for inventory holding to prevent overstocking and optimize working capital.',
    `moving_average_price` DECIMAL(18,2) COMMENT 'Weighted average price calculated from goods receipts, used for material valuation in moving average price control scenarios.',
    `net_weight` DECIMAL(18,2) COMMENT 'Weight of the material excluding packaging, expressed in the weight unit.',
    `planned_delivery_lead_time_days` STRING COMMENT 'Expected number of days from purchase order creation to goods receipt, used for procurement planning and MRP calculations.',
    `plant_specific_status` STRING COMMENT 'Material status at the plant or site level, allowing different availability across mining operations.',
    `price_control_indicator` STRING COMMENT 'Defines the valuation method for the material. S=Standard Price, V=Moving Average Price.. Valid values are `S|V`',
    `price_unit` STRING COMMENT 'Quantity unit for which the price is defined (e.g., price per 1, 10, 100, or 1000 units).',
    `procurement_type` STRING COMMENT 'Method by which the material is procured, defining the procurement process and inventory ownership model.. Valid values are `standard|consignment|subcontracting|pipeline|external|stock_transfer`',
    `purchasing_group` STRING COMMENT 'Code identifying the procurement team or buyer responsible for sourcing this material category.. Valid values are `^[A-Z0-9]{3}$`',
    `reorder_point_quantity` DECIMAL(18,2) COMMENT 'Minimum inventory level that triggers automatic replenishment or procurement action to prevent stockouts.',
    `safety_stock_quantity` DECIMAL(18,2) COMMENT 'Buffer inventory level maintained to protect against demand variability and supply disruptions.',
    `serial_number_profile` STRING COMMENT 'Configuration code defining serial number management requirements for the material (applicable to high-value equipment and components).',
    `shelf_life_days` STRING COMMENT 'Maximum number of days the material can be stored before it expires or degrades and becomes unusable. Applicable to reagents, chemicals, and perishable items.',
    `standard_price` DECIMAL(18,2) COMMENT 'Fixed price used for material valuation in standard costing scenarios. Expressed in the company currency.',
    `storage_conditions` STRING COMMENT 'Required environmental and physical conditions for storing the material (e.g., temperature range, humidity control, ventilation requirements, segregation rules).',
    `valuation_class` STRING COMMENT 'Accounting classification code that determines the general ledger accounts to which material movements are posted.. Valid values are `^[0-9]{4}$`',
    `volume` DECIMAL(18,2) COMMENT 'Physical volume occupied by the material, used for storage and transportation planning.',
    `volume_unit` STRING COMMENT 'Unit of measure for volume (e.g., L=liter, M3=cubic meter, GAL=gallon).. Valid values are `^[A-Z]{2,3}$`',
    `weight_unit` STRING COMMENT 'Unit of measure for weight (e.g., KG=kilogram, LB=pound, TON=tonne).. Valid values are `^[A-Z]{2,3}$`',
    CONSTRAINT pk_material_master PRIMARY KEY(`material_master_id`)
) COMMENT 'Central master record for all procured operational inputs managed in the supply domain, including explosives, reagents, fuel, tyres, lubricants, and spare parts. Sourced from SAP S/4HANA MM module. Captures material number, description, unit of measure, material group, hazardous classification, storage conditions, reorder point, safety stock level, lead time, and commodity category. Serves as the SSOT for all material definitions used across procurement, inventory, and warehouse operations.';

CREATE OR REPLACE TABLE `mining_ecm`.`procurement`.`vendor` (
    `vendor_id` BIGINT COMMENT 'Primary key for vendor',
    `abn` STRING COMMENT 'The 11-digit Australian Business Number issued by the Australian Taxation Office for tax and business identification purposes. Required for Australian-registered vendors for GST and tax reporting compliance.. Valid values are `^[0-9]{11}$`',
    `acn` STRING COMMENT 'The 9-digit Australian Company Number issued by ASIC (Australian Securities and Investments Commission) for company registration. Applicable to Australian corporate entities.. Valid values are `^[0-9]{9}$`',
    `approved_commodity_categories` STRING COMMENT 'Comma-separated list of commodity categories or material groups that the vendor is approved to supply. Defines the scope of goods and services the vendor is authorized to provide based on their capabilities and prequalification assessment.',
    `bank_account_name` STRING COMMENT 'The name on the vendors bank account used for payment processing. Must match the legal name or authorized signatory for payment validation and fraud prevention.',
    `bank_account_number` STRING COMMENT 'The vendors bank account number for electronic funds transfer payments. Highly sensitive financial information requiring restricted access and encryption.',
    `bank_name` STRING COMMENT 'The name of the financial institution holding the vendors payment account. Used for payment reconciliation and banking relationship management.',
    `bank_routing_code` STRING COMMENT 'The bank routing code, BSB (Bank-State-Branch), SWIFT code, or equivalent identifier for the vendors bank. Required for domestic and international payment processing.',
    `blacklist_date` DATE COMMENT 'Date when the vendor was added to the blacklist.',
    `blacklist_flag` BOOLEAN COMMENT 'Boolean indicator showing whether the vendor is blacklisted and prohibited from receiving new purchase orders due to performance issues, compliance violations, or contractual breaches.',
    `blacklist_reason` STRING COMMENT 'Detailed explanation of why the vendor was blacklisted, including reference to incidents, policy violations, or performance failures.',
    `certification_expiry_date` DATE COMMENT 'Date when the vendors current certification expires. Used to trigger recertification workflows and ensure compliance with procurement policies.',
    `certification_status` STRING COMMENT 'Indicates whether the vendor holds required certifications for supplying to the mining operation (e.g., ISO 9001 quality management, ISO 14001 environmental, ISO 45001 safety, explosives handling license).. Valid values are `certified|not_certified|certification_pending|certification_expired`',
    `city` STRING COMMENT 'The city or locality of the vendors primary business address. Used for geographic analysis and regional sourcing strategies.',
    `classification` STRING COMMENT 'The primary business classification of the vendor based on the goods or services they provide to mining operations. Used for vendor segmentation, sourcing strategy, and spend analysis. [ENUM-REF-CANDIDATE: explosives_supplier|reagent_supplier|oem|contractor|logistics_provider|maintenance_service|consulting_service|equipment_rental|spare_parts_supplier|consumables_supplier|fuel_supplier|utilities_provider|catering_service|security_service|environmental_service|laboratory_service — promote to reference product]',
    `country_code` STRING COMMENT 'The three-letter ISO 3166-1 alpha-3 country code of the vendors country of registration. Used for international trade compliance, tax reporting, and supply chain risk analysis.. Valid values are `^[A-Z]{3}$`',
    `country_of_origin` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code representing the country where the vendor is legally registered and operates from.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'The system timestamp when this vendor record was first created in the procurement system. Used for data lineage, audit trails, and record lifecycle tracking.',
    `credit_limit_amount` DECIMAL(18,2) COMMENT 'The maximum outstanding accounts payable balance allowed for this vendor before payment or credit review is required. Used for financial risk management and cash flow control.',
    `credit_rating` STRING COMMENT 'The vendors credit rating or financial health score from an external credit rating agency (e.g., Dun & Bradstreet, Moodys). Used for financial risk assessment and vendor viability evaluation.',
    `currency_code` STRING COMMENT 'The three-letter ISO 4217 currency code for the vendors default transaction currency. Used for pricing, invoicing, and payment processing.. Valid values are `^[A-Z]{3}$`',
    `incoterms_code` STRING COMMENT 'The default Incoterms code defining the allocation of costs, risks, and responsibilities between buyer and seller for shipments from this vendor. Common mining terms include FOB (Free on Board) and CIF (Cost Insurance and Freight). [ENUM-REF-CANDIDATE: EXW|FCA|CPT|CIP|DAP|DPU|DDP|FAS|FOB|CFR|CIF — 11 candidates stripped; promote to reference product]',
    `insurance_certificate_number` STRING COMMENT 'The reference number of the vendors current public liability and professional indemnity insurance certificate. Required for contractor and service provider prequalification and risk management.',
    `insurance_coverage_amount` DECIMAL(18,2) COMMENT 'The total coverage amount of the vendors public liability insurance policy. Must meet minimum thresholds defined in procurement policies for high-risk categories such as explosives suppliers and heavy equipment contractors.',
    `insurance_expiry_date` DATE COMMENT 'The expiry date of the vendors insurance certificate. Used to trigger renewal reminders and ensure continuous insurance coverage for active vendors.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The system timestamp when this vendor record was last updated. Used for change tracking, data quality monitoring, and audit compliance.',
    `last_review_date` DATE COMMENT 'The date of the most recent vendor performance review or compliance audit. Used to track review frequency and ensure ongoing vendor evaluation.',
    `legal_name` STRING COMMENT 'The full registered legal name of the vendor organization as it appears on official business registration documents and contracts. Used for legal compliance, contract execution, and payment processing.',
    `next_review_date` DATE COMMENT 'The scheduled date for the next vendor performance review or compliance audit. Used for proactive vendor management and review planning.',
    `onboarding_date` DATE COMMENT 'The date the vendor was first registered and approved in the procurement system. Used for vendor relationship tenure analysis and anniversary tracking.',
    `payment_method` STRING COMMENT 'The preferred or required method of payment for transactions with this vendor. Determines the payment processing workflow and banking requirements.. Valid values are `eft|wire_transfer|cheque|credit_card|letter_of_credit`',
    `payment_terms_code` STRING COMMENT 'The standard payment terms code defining the payment schedule and conditions for invoices from this vendor (e.g., NET30, NET60, COD). Used for accounts payable processing and cash flow planning.. Valid values are `^[A-Z0-9]{2,6}$`',
    `postal_code` STRING COMMENT 'The postal or ZIP code of the vendors primary business address. Used for mail delivery and geographic segmentation.',
    `preferred_vendor_flag` BOOLEAN COMMENT 'Boolean indicator identifying whether this vendor has preferred vendor status based on performance, pricing, strategic relationship, or contract terms. Preferred vendors receive priority consideration in sourcing decisions.',
    `prequalification_expiry_date` DATE COMMENT 'The date on which the vendors prequalification status expires and requires renewal. Used to trigger re-evaluation workflows and ensure ongoing compliance with vendor standards.',
    `prequalification_status` STRING COMMENT 'Indicates whether the vendor has completed the prequalification process and meets the mining operations standards for safety, quality, financial stability, and compliance. Prequalified vendors are eligible for tender participation and contract awards.. Valid values are `prequalified|not_prequalified|expired|in_progress`',
    `primary_contact_email` STRING COMMENT 'The email address of the primary vendor contact. Used for purchase order transmission, delivery coordination, and business correspondence.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `primary_contact_name` STRING COMMENT 'The full name of the primary business contact person at the vendor organization. Used for procurement communications, order management, and issue resolution.',
    `primary_contact_phone` STRING COMMENT 'The telephone number of the primary vendor contact. Used for urgent communications, delivery coordination, and operational support.',
    `risk_rating` STRING COMMENT 'Risk classification assigned to the vendor based on financial stability, delivery performance, quality issues, and compliance history. Used for vendor management and procurement decision-making.. Valid values are `low|medium|high|critical`',
    `state_province` STRING COMMENT 'The state, province, or administrative region of the vendors primary business address. Used for tax jurisdiction determination and regional compliance.',
    `street_address` STRING COMMENT 'The street address of the vendors primary business location or registered office. Used for correspondence, legal notices, and logistics planning.',
    `tax_registration_number` STRING COMMENT 'Government-issued tax identification number for the vendor. May be ABN (Australian Business Number), TIN (Tax Identification Number), VAT number, or equivalent depending on jurisdiction.',
    `trading_name` STRING COMMENT 'The commercial or trading name under which the vendor operates, if different from the legal name. Used for day-to-day business communications and operational references.',
    `vendor_category` STRING COMMENT 'Classification of the vendor based on the primary type of goods or services they supply to the mining operation. Used for vendor segmentation and spend analysis. [ENUM-REF-CANDIDATE: explosives_supplier|reagent_manufacturer|fuel_distributor|tyre_supplier|spare_parts_dealer|equipment_oem|contractor_services|logistics_provider|consumables_supplier|professional_services — 10 candidates stripped; promote to reference product]',
    `vendor_code` STRING COMMENT 'Externally-known unique alphanumeric identifier assigned to the vendor in the procurement system. Used as the business key for vendor identification across purchase orders, invoices, and contracts.. Valid values are `^[A-Z0-9]{6,12}$`',
    `vendor_status` STRING COMMENT 'Current lifecycle status of the vendor in the procurement system. Active vendors can receive purchase orders; suspended or blacklisted vendors are blocked from new transactions.. Valid values are `active|inactive|suspended|pending_approval|blacklisted|under_review`',
    CONSTRAINT pk_vendor PRIMARY KEY(`vendor_id`)
) COMMENT 'Master register of all approved suppliers and vendors providing goods and services to the mining operation, including explosives suppliers, reagent manufacturers, fuel distributors, tyre suppliers, and spare parts dealers. Captures vendor code, legal name, ABN/tax registration, country of origin, vendor category, payment terms, currency, bank details, certification status, and blacklist flag. Sourced from SAP S/4HANA MM Vendor Master. Serves as the SSOT for vendor identity within the supply domain.';

CREATE OR REPLACE TABLE `mining_ecm`.`procurement`.`purchase_order` (
    `purchase_order_id` BIGINT COMMENT 'Primary key for purchase_order',
    `capex_budget_id` BIGINT COMMENT 'Foreign key linking to finance.capex_budget. Business justification: In mining, raising a capital PO creates a budget commitment against the approved CAPEX budget. Direct FK enables real-time committed vs. approved budget reporting — a mandatory control in mining proje',
    `contract_id` BIGINT COMMENT 'Foreign key linking to procurement.contract. Business justification: Purchase orders are often issued against framework agreements or master contracts. Converting STRING contract_number to FK enables proper contract compliance tracking and pricing validation. N:1 relat',
    `cost_centre_id` BIGINT COMMENT 'Foreign key linking to finance.cost_centre. Business justification: Mining operations require PO-to-cost-centre linkage for AISC/C1 cost reporting, budget variance analysis, and opex/capex classification. Essential for mine-level cost control and financial reporting.',
    `warehouse_location_id` BIGINT COMMENT 'Foreign key linking to procurement.warehouse_location. Business justification: Purchase orders specify a delivery destination. Currently this is stored as free-text address fields (delivery_address_line_1/2, delivery_city, delivery_postal_code, delivery_state_province, delivery_',
    `framework_agreement_id` BIGINT COMMENT 'Foreign key linking to procurement.framework_agreement. Business justification: Purchase orders can be call-offs against blanket purchase agreements or framework agreements. This is a standard procurement pattern where a framework agreement establishes terms, and individual POs a',
    `general_ledger_account_id` BIGINT COMMENT 'Foreign key linking to finance.general_ledger_account. Business justification: Every PO posts to GL for financial statement preparation, cost element classification, and audit trail. Fundamental for financial accounting and reporting in mining operations.',
    `opex_budget_id` BIGINT COMMENT 'Foreign key linking to finance.opex_budget. Business justification: Mining operations track OPEX budget encumbrances when POs are raised for consumables, maintenance, and services. Direct FK from PO to opex_budget supports budget commitment reporting and prevents over',
    `price_schedule_id` BIGINT COMMENT 'Foreign key linking to procurement.price_schedule. Business justification: A purchase order can be issued against a specific price schedule (contracted pricing). Adding price_schedule_id to procurement_purchase_order enables direct reference to the applicable pricing schedul',
    `requisition_id` BIGINT COMMENT 'Foreign key linking to procurement.requisition. Business justification: Procurement purchase order is created from requisition. Converting STRING requisition_number to FK enables proper traceability. N:1 relationship. Note: procurement_purchase_order appears to be duplica',
    `vendor_id` BIGINT COMMENT 'Identifier of the supplier or vendor to whom this purchase order is issued. Links to the vendor master data in the counterparty domain.',
    `wbs_element_id` BIGINT COMMENT 'Foreign key linking to finance.wbs_element. Business justification: Capital projects require PO-to-WBS linkage for capex tracking, project cost control, asset capitalization, and commitment reporting. Critical for capital project management in mining.',
    `approval_date` DATE COMMENT 'Date when the purchase order was formally approved by authorized personnel. Represents the completion of internal approval workflow.',
    `approval_status` STRING COMMENT 'Current approval workflow status of the purchase order. Indicates whether the order has passed through required authorization levels.. Valid values are `pending|approved|rejected`',
    `approved_by` STRING COMMENT 'Name or identifier of the person who provided final approval for the purchase order. Captures accountability for procurement authorization.',
    `company_code` STRING COMMENT 'Legal entity or company code for financial accounting purposes. Represents the smallest organizational unit for which a complete self-contained set of accounts can be drawn up.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when the purchase order record was first created. Audit trail for data lineage and compliance reporting.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the purchase order monetary values. Defines the currency in which the vendor will be paid.. Valid values are `^[A-Z]{3}$`',
    `deletion_indicator` BOOLEAN COMMENT 'Flag indicating whether the purchase order is marked for deletion. True indicates the order is flagged for archival or removal.',
    `delivery_date` DATE COMMENT 'Requested or committed delivery date for goods or services. Represents the expected fulfillment date agreed with the vendor.',
    `document_date` DATE COMMENT 'Date when the purchase order document was created in the system. Represents the official document creation timestamp for audit and compliance purposes.',
    `expenditure_type` STRING COMMENT 'Classification of purchase order as Operating Expenditure (OPEX) for day-to-day operations or Capital Expenditure (CAPEX) for long-term asset investments. Critical for financial reporting and mine economics.. Valid values are `OPEX|CAPEX`',
    `incoterms` STRING COMMENT 'International Commercial Terms (Incoterms) defining the responsibilities, costs, and risks between buyer and seller for transportation and delivery. Common mining terms include FOB (Free on Board) and CIF (Cost Insurance and Freight). [ENUM-REF-CANDIDATE: EXW|FCA|CPT|CIP|DAP|DPU|DDP|FAS|FOB|CFR|CIF — 11 candidates stripped; promote to reference product]',
    `incoterms_code` STRING COMMENT 'Standard trade terms defining the responsibilities of buyers and sellers for the delivery of goods. Common in mining: FOB (Free on Board) for port delivery, CIF (Cost Insurance and Freight) for international shipments. [ENUM-REF-CANDIDATE: EXW|FCA|CPT|CIP|DAP|DPU|DDP|FAS|FOB|CFR|CIF — 11 candidates stripped; promote to reference product]',
    `incoterms_location` STRING COMMENT 'Named place or port specified in the Incoterms agreement where the transfer of risk and costs occurs. Examples include port names, mine sites, or delivery destinations.',
    `is_deleted` BOOLEAN COMMENT 'Soft delete flag indicating whether the purchase order has been logically deleted from active use. Supports data retention and audit requirements without physical deletion.',
    `last_modified_by` STRING COMMENT 'User ID or name of the person who last updated the purchase order. Audit field for tracking change history.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'System timestamp when the purchase order record was last updated. Audit trail for tracking data changes and version control.',
    `net_value` DECIMAL(18,2) COMMENT 'Net monetary value of the purchase order after applying discounts and before tax. Represents the actual amount payable to the vendor excluding tax.',
    `notes` STRING COMMENT 'Free-text field for additional comments, special conditions, or internal notes related to the purchase order. Captures context not covered by structured fields.',
    `payment_terms` STRING COMMENT 'Payment terms code defining the payment schedule and conditions agreed with the vendor. Specifies due dates, discounts, and payment method requirements.. Valid values are `^[A-Z0-9]{4}$`',
    `payment_terms_code` STRING COMMENT 'Code representing the agreed payment terms with the vendor. Defines the payment schedule, discount periods, and due dates.',
    `plant_code` STRING COMMENT 'Mine site, processing facility, or operational location where materials or services will be delivered. Represents the receiving plant in the supply chain.. Valid values are `^[A-Z0-9]{4}$`',
    `po_date` DATE COMMENT 'Business event date when the purchase order was issued or approved for transmission to the vendor. Principal transaction timestamp for procurement analytics.',
    `po_number` STRING COMMENT 'Externally visible unique purchase order number assigned by the procurement system. The primary business identifier used in vendor communications and goods receipt documentation.',
    `po_status` STRING COMMENT 'Current lifecycle status of the purchase order. Draft indicates not yet released, open indicates released and awaiting delivery, partially delivered indicates some goods received, fully delivered indicates all goods received, invoiced indicates invoice received, closed indicates completed and archived, cancelled indicates order terminated before completion. [ENUM-REF-CANDIDATE: draft|open|partially_delivered|fully_delivered|invoiced|closed|cancelled — 7 candidates stripped; promote to reference product]',
    `po_type` STRING COMMENT 'Classification of the purchase order based on procurement scenario. Standard for regular goods procurement, subcontracting for components sent to vendor for processing, consignment for vendor-owned stock, stock transport for inter-plant transfers, framework for blanket agreements, service for service procurement.. Valid values are `standard|subcontracting|consignment|stock_transport|framework|service`',
    `priority` STRING COMMENT 'Urgency level of the purchase order indicating the criticality of delivery. Used for expediting critical materials for mine operations or maintenance shutdowns.. Valid values are `urgent|high|normal|low`',
    `purchasing_group` STRING COMMENT 'Buyer or procurement team responsible for managing this purchase order. Identifies the functional group handling vendor relationships and order execution.. Valid values are `^[A-Z0-9]{3}$`',
    `purchasing_organisation` STRING COMMENT 'Organizational unit responsible for procurement activities. Represents the legal entity or business unit negotiating and executing the purchase order.. Valid values are `^[A-Z0-9]{4}$`',
    `purchasing_organization` STRING COMMENT 'Organizational unit responsible for procurement activities. Represents the legal entity or business unit negotiating terms with vendors.',
    `requested_delivery_date` DATE COMMENT 'Date by which the buyer requests delivery of goods or completion of services. Used for planning and scheduling purposes.',
    `shipping_instructions` STRING COMMENT 'Special instructions for delivery, handling, or transportation of goods. Includes requirements for packaging, labeling, hazardous materials handling, or site-specific delivery protocols.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Total tax amount applicable to the purchase order. Includes VAT, GST, or other applicable sales taxes based on jurisdiction.',
    `total_value` DECIMAL(18,2) COMMENT 'Total monetary value of the purchase order including all line items before tax. Represents the gross committed spend for this procurement transaction.',
    `validity_end_date` DATE COMMENT 'Date until which the purchase order remains valid. After this date, no further deliveries or services should be accepted against this order.',
    `validity_start_date` DATE COMMENT 'Effective start date for blanket or framework purchase orders. Defines the beginning of the period during which the purchase order terms are valid.',
    `created_by` STRING COMMENT 'User ID or name of the procurement professional who created the purchase order in the system. Audit field for tracking document origination.',
    CONSTRAINT pk_purchase_order PRIMARY KEY(`purchase_order_id`)
) COMMENT 'Formal procurement document issued to a vendor for the supply of materials or services required for mining operations. Sourced from SAP S/4HANA MM Purchase Order (EKKO/EKPO). Captures PO number, vendor, plant, purchasing organisation, purchasing group, document date, delivery date, total value, currency, payment terms, Incoterms (FOB/CIF), approval status, and PO type (standard, blanket, framework). Serves as the SSOT for all committed procurement transactions within the supply domain. Core transactional entity linking requisition demand to vendor fulfilment.';

CREATE OR REPLACE TABLE `mining_ecm`.`procurement`.`purchase_order_line` (
    `purchase_order_line_id` BIGINT COMMENT 'Unique identifier for the purchase order line item. Primary key for the purchase order line entity.',
    `contract_id` BIGINT COMMENT 'Foreign key linking to procurement.contract. Business justification: Individual PO lines may reference specific contracts for pricing and terms. Converting STRING contract_number to FK enables line-level contract compliance. N:1 relationship (many PO lines under same c',
    `cost_centre_id` BIGINT COMMENT 'Foreign key linking to finance.cost_centre. Business justification: Line-level cost allocation enables detailed cost tracking by pit/plant/department for accurate AISC calculation and budget control. Standard practice in mining cost accounting.',
    `general_ledger_account_id` BIGINT COMMENT 'Foreign key linking to finance.general_ledger_account. Business justification: Line-level GL posting enables detailed financial reporting, cost element analysis, and opex/capex split. Required for accurate financial statements and cost reporting.',
    `price_schedule_id` BIGINT COMMENT 'Foreign key linking to procurement.price_schedule. Business justification: Each purchase order line item is priced according to a contracted price schedule. Adding price_schedule_id to purchase_order_line normalizes the pricing reference, enabling audit of whether the correc',
    `purchase_order_id` BIGINT COMMENT 'Foreign key reference to the parent purchase order header. Links this line item to its containing purchase order document.',
    `requisition_id` BIGINT COMMENT 'Foreign key linking to procurement.requisition. Business justification: PO line is created from requisition line; should reference source for traceability. Converting STRING requisition_number/line_number to FK enables proper line-level audit trail. N:1 relationship (typi',
    `specification_id` BIGINT COMMENT 'Foreign key linking to product.specification. Business justification: Mining PO lines for ore, concentrate, or reagent supply must reference the applicable product specification to enforce quality acceptance criteria at goods receipt and trigger penalty/bonus calculatio',
    `material_master_id` BIGINT COMMENT 'Foreign key reference to the material master record. Identifies the specific material, equipment part, consumable, or service being procured on this line.',
    `account_assignment_category` STRING COMMENT 'Defines how the purchase order line cost will be allocated in the financial system. Determines whether the expense is charged to a cost centre, capital project (CAPEX), fixed asset, or internal order.. Valid values are `cost_centre|project|asset|order`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this purchase order line record was first created in the system. Used for audit trail and procurement cycle time analysis.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the net price and line item value. Examples: USD, AUD, CAD, EUR, GBP.. Valid values are `^[A-Z]{3}$`',
    `deletion_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether this purchase order line has been marked for deletion. When true, the line is logically deleted but retained for audit and historical reporting purposes.',
    `delivery_date` DATE COMMENT 'The scheduled or requested delivery date for this purchase order line item. Represents when the material or service is expected to be received at the delivery location.',
    `final_invoice_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether the final invoice has been received for this purchase order line. When true, no further invoices are expected and the line can be closed.',
    `goods_receipt_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether a goods receipt transaction is required for this purchase order line. When true, physical receipt must be posted before invoice can be processed.',
    `goods_receipt_quantity` DECIMAL(18,2) COMMENT 'The cumulative quantity of material that has been physically received and posted against this purchase order line. Updated each time a goods receipt transaction is recorded.',
    `incoterm` STRING COMMENT 'International Commercial Terms code defining the delivery terms and transfer of risk between buyer and seller. Common mining examples: FOB (Free on Board), CIF (Cost Insurance and Freight), EXW (Ex Works), DDP (Delivered Duty Paid).',
    `invoice_quantity` DECIMAL(18,2) COMMENT 'The cumulative quantity that has been invoiced by the vendor against this purchase order line. Used for three-way matching between PO, goods receipt, and invoice.',
    `invoice_receipt_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether invoice verification is required for this purchase order line. When true, vendor invoice must be matched and posted.',
    `line_number` STRING COMMENT 'Sequential line item number within the purchase order. Determines the ordering and position of this line in the PO document.',
    `line_status` STRING COMMENT 'Current lifecycle status of the purchase order line item. Tracks progression from open order through goods receipt to final closure or cancellation.. Valid values are `open|partially_received|fully_received|closed|cancelled`',
    `material_group` STRING COMMENT 'Classification code grouping similar materials for procurement analysis and reporting. Examples include explosives, tyres, fuel, lubricants, spare parts, PPE (Personal Protective Equipment), consumables.',
    `material_number` STRING COMMENT 'Business identifier for the material being procured. Human-readable material code used across procurement, inventory, and operations systems.',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when this purchase order line record was last updated. Tracks changes to quantity, price, delivery date, or other line item attributes.',
    `net_order_value` DECIMAL(18,2) COMMENT 'Total net value of this purchase order line, calculated as quantity ordered multiplied by net price. Excludes taxes and freight charges.',
    `net_price` DECIMAL(18,2) COMMENT 'The net price per unit of measure for this line item, excluding taxes and additional charges. Used to calculate line item total value.',
    `outstanding_quantity` DECIMAL(18,2) COMMENT 'The remaining quantity yet to be received on this purchase order line. Calculated as quantity ordered minus goods receipt quantity.',
    `over_delivery_tolerance_percent` DECIMAL(18,2) COMMENT 'The acceptable percentage by which the vendor may over-deliver beyond the ordered quantity without requiring approval. Used for goods receipt tolerance checking.',
    `plant_code` STRING COMMENT 'The mine site, processing plant, or facility code where the material will be delivered and consumed. Represents the receiving organizational unit.',
    `price_unit` STRING COMMENT 'The quantity unit to which the net price applies. For example, if price is per 100 units, this field would contain 100.',
    `purchasing_group` STRING COMMENT 'Code identifying the procurement team or buyer responsible for this purchase order line. Used for workload distribution and performance tracking.',
    `quantity_ordered` DECIMAL(18,2) COMMENT 'The quantity of material or service ordered on this purchase order line. Represents the total amount requested from the vendor.',
    `short_text` STRING COMMENT 'Brief description of the material or service being procured. Provides human-readable context for the line item on purchase order documents and reports.',
    `storage_location` STRING COMMENT 'The specific warehouse, stockyard, or storage area within the plant where the material will be received and stored. Used for inventory management and goods receipt posting.',
    `tax_code` STRING COMMENT 'Tax classification code determining the applicable tax rate and tax jurisdiction for this line item. Used for Goods and Services Tax (GST), Value Added Tax (VAT), or sales tax calculation.',
    `under_delivery_tolerance_percent` DECIMAL(18,2) COMMENT 'The acceptable percentage by which the vendor may under-deliver below the ordered quantity without requiring approval. Used for goods receipt tolerance checking and automatic PO closure.',
    `unit_of_measure` STRING COMMENT 'The unit of measure for the ordered quantity. Examples include tonnes (T), kilograms (KG), litres (L), metres (M), each (EA), hours (HR) for services.',
    CONSTRAINT pk_purchase_order_line PRIMARY KEY(`purchase_order_line_id`)
) COMMENT 'Individual line item within a purchase order specifying a single material or service, quantity, unit price, delivery schedule, and storage location. Sourced from SAP S/4HANA MM (EKPO). Captures PO line number, material number, short text, quantity ordered, unit of measure, net price, tax code, delivery date, goods receipt quantity, invoice quantity, and line status. Enables granular tracking of multi-material procurement transactions.';

CREATE OR REPLACE TABLE `mining_ecm`.`procurement`.`goods_receipt` (
    `goods_receipt_id` BIGINT COMMENT 'Primary key for goods_receipt',
    `cost_centre_id` BIGINT COMMENT 'Foreign key linking to finance.cost_centre. Business justification: Duplicate goods_receipt product requires same cost centre linkage for actual spend tracking, inventory valuation, and AISC calculation. Core to mining cost accounting.',
    `delivery_schedule_id` BIGINT COMMENT 'Foreign key linking to procurement.delivery_schedule. Business justification: Goods receipt fulfills a delivery schedule line (call-off against blanket PO or schedule agreement). N:1 relationship (many GRs can fulfill one schedule line if partial receipts). Enables tracking of ',
    `inbound_delivery_id` BIGINT COMMENT 'Foreign key linking to procurement.inbound_delivery. Business justification: Goods receipt records warehouse acceptance of materials from an inbound delivery. One inbound delivery can result in multiple goods receipts if received in batches. N:1 relationship (many GRs per deli',
    `plant_id` BIGINT COMMENT 'Reference to the mine site, processing plant, or facility where goods are received. Identifies the receiving location at the organizational level.',
    `purchase_order_id` BIGINT COMMENT 'Reference to the purchase order against which this goods receipt is posted. Links the goods receipt to the originating procurement document.',
    `purchase_order_line_id` BIGINT COMMENT 'Reference to the specific purchase order line item for which goods are being received. Enables three-way match validation (PO-GR-Invoice).',
    `stock_transfer_id` BIGINT COMMENT 'Foreign key linking to procurement.stock_transfer. Business justification: A goods receipt can represent the receiving side of an internal stock transfer (STO). When materials are transferred between plants or storage locations, a goods receipt is posted at the receiving pla',
    `material_master_id` BIGINT COMMENT 'Reference to the material master record for the material or equipment being received. Links to the material catalog.',
    `vendor_id` BIGINT COMMENT 'Reference to the vendor or supplier who delivered the materials. Identifies the counterparty in the goods receipt transaction.',
    `warehouse_location_id` BIGINT COMMENT 'Reference to the specific warehouse, ROM (Run of Mine) pad, or storage area within the plant where materials are physically stored after receipt.',
    `wbs_element_id` BIGINT COMMENT 'Foreign key linking to finance.wbs_element. Business justification: Capital GRs post to WBS for asset under construction tracking, capex reporting, and project cost control. Essential for capital project accounting in mining.',
    `batch_number` STRING COMMENT 'The batch or lot number assigned to the received materials for traceability and quality control. Critical for tracking ore batches, chemical reagents, and spare parts through the supply chain.',
    `bill_of_lading_number` STRING COMMENT 'The shipping document number issued by the carrier for the transported goods. Critical for FOB (Free on Board) and CIF (Cost Insurance and Freight) shipments in mining commodity trading.',
    `certificate_of_analysis_number` STRING COMMENT 'Reference number of the certificate of analysis provided by the vendor or generated by the laboratory. Documents quality specifications and test results for the received material.',
    `created_by_user` STRING COMMENT 'User ID of the person who created the goods receipt document in the ERP system. Used for audit trail and accountability.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when the goods receipt record was first created in the system. Used for audit trail and processing time analysis.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the valuation amount (e.g., USD, AUD, CAD).. Valid values are `^[A-Z]{3}$`',
    `document_date` DATE COMMENT 'The date printed on the external delivery note or packing slip provided by the vendor. May differ from posting date due to processing delays.',
    `goods_receipt_status` STRING COMMENT 'The current lifecycle status of the goods receipt transaction. Posted indicates successful inventory update; reversed indicates cancellation; pending inspection indicates awaiting quality clearance; completed indicates full processing including invoice verification.. Valid values are `posted|reversed|cancelled|pending_inspection|completed`',
    `gr_document_number` STRING COMMENT 'The externally-known unique document number assigned to this goods receipt transaction in the ERP (Enterprise Resource Planning) system. Used for audit trail and three-way match in invoice verification.. Valid values are `^[A-Z0-9]{10}$`',
    `gr_document_year` STRING COMMENT 'The fiscal year in which the goods receipt document was posted. Used in combination with document number for unique identification in SAP systems.',
    `gr_line_item_number` STRING COMMENT 'The line item sequence number within the goods receipt document. Identifies individual material lines when multiple items are received in a single transaction.',
    `gross_weight` DECIMAL(18,2) COMMENT 'The total weight of the received shipment including packaging and containers. Used for freight reconciliation and logistics tracking.',
    `inspection_lot_number` STRING COMMENT 'The unique identifier for the quality inspection lot created for this goods receipt. Links to laboratory sample management and assay results in LIMS.',
    `last_modified_by_user` STRING COMMENT 'User ID of the person who last modified the goods receipt document. Used for change tracking and audit purposes.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when the goods receipt record was last updated. Tracks the most recent change to the document.',
    `line_item_number` STRING COMMENT 'Sequential line item number within the material document. Identifies individual material movements within a single goods receipt document.',
    `material_document_number` STRING COMMENT 'The unique material document number generated by the ERP system (SAP S/4HANA or Pronto Xi) upon posting the goods receipt. This is the business identifier for the goods receipt transaction.. Valid values are `^[A-Z0-9]{10}$`',
    `material_document_year` STRING COMMENT 'Fiscal year in which the material document was posted. Used in combination with material document number for unique identification in SAP systems.',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when the goods receipt record was last updated. Tracks changes to quantity, status, or other fields after initial creation.',
    `movement_indicator` STRING COMMENT 'A single-character code indicating the direction of the goods movement (e.g., B for goods receipt, H for reversal). Used for system processing logic.. Valid values are `^[A-Z]$`',
    `movement_type` STRING COMMENT 'The SAP movement type code that classifies the type of goods receipt transaction (e.g., 101 for GR against PO, 501 for transfer posting). Determines how inventory and financial accounts are updated.. Valid values are `^[0-9]{3}$`',
    `net_weight` DECIMAL(18,2) COMMENT 'The weight of the received materials excluding packaging and containers. Used for inventory valuation and yield calculations in mineral processing.',
    `posting_date` DATE COMMENT 'The date on which the goods receipt was posted to inventory in the financial and materials management system. This is the official accounting date for inventory valuation and triggers the three-way match process.',
    `quality_inspection_required_flag` BOOLEAN COMMENT 'Indicates whether the received materials must undergo quality inspection before being released for unrestricted use. When true, materials are placed in quality inspection stock pending LIMS (Laboratory Information Management System) assay results.',
    `quantity_ordered` DECIMAL(18,2) COMMENT 'The quantity originally ordered on the purchase order line. Used to calculate delivery variance and over/under delivery tolerance.',
    `quantity_received` DECIMAL(18,2) COMMENT 'The physical quantity of material received and accepted at the storage location. This quantity updates inventory levels and is used in the three-way match against purchase order quantity and invoice quantity.',
    `receipt_condition` STRING COMMENT 'Condition assessment of the goods upon physical receipt. Indicates whether materials were received in acceptable condition or if there were issues such as damage or quantity discrepancies.. Valid values are `acceptable|damaged|short_shipped|over_shipped|partial`',
    `received_date` DATE COMMENT 'The actual date when the physical goods were received at the mine site, warehouse, or processing plant. Used for delivery performance tracking.',
    `receiving_person_name` STRING COMMENT 'The name of the warehouse or stores personnel who physically accepted and verified the delivered goods. Used for accountability and audit trail.',
    `remarks` STRING COMMENT 'Free-text field for additional notes or comments about the goods receipt transaction. May include observations about packaging condition, delivery delays, or special handling instructions.',
    `reversal_document_number` STRING COMMENT 'The document number of the reversal transaction if this goods receipt has been cancelled. Links to the offsetting material document.',
    `reversal_indicator` BOOLEAN COMMENT 'Indicates whether this goods receipt has been reversed or cancelled. When true, the inventory movement has been negated and the original transaction is no longer valid.',
    `reversal_reason_code` STRING COMMENT 'The coded reason for reversing the goods receipt (e.g., damaged goods, quantity discrepancy, wrong material delivered). Used for root cause analysis and vendor performance evaluation.',
    `serial_number` STRING COMMENT 'Unique serial number for serialized equipment or high-value assets. Enables individual asset tracking and lifecycle management.',
    `stock_type` STRING COMMENT 'The inventory status category of the received goods. Unrestricted stock is available for use; quality inspection stock awaits testing; blocked stock cannot be used; restricted stock has limited usage.. Valid values are `unrestricted|quality_inspection|blocked|restricted`',
    `tare_weight` DECIMAL(18,2) COMMENT 'The weight of packaging, containers, or transport equipment. Calculated as gross weight minus net weight.',
    `unit_of_measure` STRING COMMENT 'The unit in which the received quantity is measured (e.g., TON for tonnes, KG for kilograms, EA for each, M3 for cubic meters). Must align with material master and purchase order UOM.. Valid values are `^[A-Z]{2,3}$`',
    `unloading_point` STRING COMMENT 'The specific physical location or dock where the delivery vehicle was unloaded (e.g., Dock 3, ROM Pad A, Reagent Bay 2). Used for logistics planning and congestion management.',
    `valuation_amount` DECIMAL(18,2) COMMENT 'Total value of the goods receipt in the local currency. Used for inventory valuation and financial accounting. Calculated as quantity received multiplied by material price.',
    `valuation_type` STRING COMMENT 'The valuation category for split-valuation scenarios where the same material is valued differently based on procurement source or quality grade (e.g., domestic vs. imported ore).',
    `vendor_batch_number` STRING COMMENT 'The batch or lot number assigned by the vendor to the delivered materials. Used for traceability back to the suppliers production records and quality certificates.',
    `weight_unit_of_measure` STRING COMMENT 'The unit in which weights are measured (e.g., TON for tonnes, KG for kilograms, LB for pounds). Must be consistent across gross, net, and tare weights.. Valid values are `^[A-Z]{2,3}$`',
    CONSTRAINT pk_goods_receipt PRIMARY KEY(`goods_receipt_id`)
) COMMENT 'Records the physical receipt of materials at a mine site warehouse or ROM pad against a purchase order or inbound delivery. Sourced from SAP S/4HANA MM Goods Receipt (MIGO/MSEG). Captures GR document number, posting date, delivery note reference, plant, storage location, material, quantity received, unit of measure, batch number, movement type, and quality inspection flag. Triggers inventory update and three-way match for invoice verification.';

CREATE OR REPLACE TABLE `mining_ecm`.`procurement`.`goods_issue` (
    `goods_issue_id` BIGINT COMMENT 'Unique identifier for the goods issue transaction. Primary key for the goods issue record.',
    `area_id` BIGINT COMMENT 'Foreign key linking to mine.mine_area. Business justification: Consumables (fuel, ground support, explosives) are issued to specific mine areas (open cut phases, underground areas). Area-level goods issue tracking supports mine area cost centre reporting and enab',
    `blast_execution_id` BIGINT COMMENT 'Foreign key linking to mine.blast_execution. Business justification: Explosive materials and accessories are physically issued from the magazine for each blast execution. This link is required for explosive consumption reconciliation, regulatory compliance (explosive u',
    `cost_centre_id` BIGINT COMMENT 'Foreign key linking to finance.cost_centre. Business justification: Material consumption posts to cost centres for production cost tracking, AISC calculation, and budget variance analysis. Fundamental to mining operations cost accounting.',
    `drill_hole_id` BIGINT COMMENT 'Foreign key linking to exploration.drill_hole. Business justification: Drilling consumables (drill bits, rods, casing, chemicals) are issued from stores against specific drill holes for per-hole cost allocation and consumable consumption tracking. Mining operations requi',
    `freight_order_id` BIGINT COMMENT 'Foreign key linking to procurement.freight_order. Business justification: Goods issues for outbound shipments of processed mineral concentrate or commodity product are directly tied to freight orders. When materials are issued from a mine site warehouse for outbound logisti',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to procurement.purchase_order. Business justification: Stock transport orders are a type of purchase order in SAP used for inter-plant transfers. Goods issue can be executed against STO. N:1 relationship (many goods issues against one STO). Converting STR',
    `purchase_order_line_id` BIGINT COMMENT 'Foreign key linking to procurement.purchase_order_line. Business justification: A goods issue (stock movement out) can be executed against a specific purchase order line, particularly for return deliveries or consumption postings tied to a PO line. goods_issue already has procure',
    `rom_stockpile_id` BIGINT COMMENT 'Foreign key linking to mine.rom_stockpile. Business justification: Fuel, maintenance materials, and sampling consumables are issued directly to ROM stockpile operations. Linking goods_issue to rom_stockpile enables stockpile-level operating cost allocation, supportin',
    `shift_report_id` BIGINT COMMENT 'Foreign key linking to mine.shift_report. Business justification: Consumables (fuel, explosives, PPE, drill bits) issued from the warehouse are recorded against the shift in which they were consumed. Linking goods_issue to shift_report enables shift-level consumable',
    `stock_transfer_id` BIGINT COMMENT 'Foreign key linking to procurement.stock_transfer. Business justification: In SAP-style mining procurement systems, a stock transfer between plants/sites generates a goods issue posting on the sending side. The goods_issue table is described as a unified material movement l',
    `stope_design_id` BIGINT COMMENT 'Foreign key linking to mine.stope_design. Business justification: Ground support materials (cable bolts, mesh, shotcrete) are issued against specific stope designs in underground mining. Stope-level goods issue tracking enables actual vs. designed material consumpti',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to procurement.material_master. Business justification: Goods issue records movement of a specific material. N:1 relationship (many goods issues for one material). Converting STRING material_number to FK enables proper material master linkage. Material det',
    `warehouse_location_id` BIGINT COMMENT 'Foreign key linking to procurement.warehouse_location. Business justification: Goods issue originates from a warehouse storage location. N:1 relationship (many goods issues from one location). Converting STRING storage_location_code to FK enables proper inventory location tracki',
    `waste_dump_id` BIGINT COMMENT 'Foreign key linking to mine.waste_dump. Business justification: Liner materials, geotextiles, drainage materials, and monitoring equipment are issued against specific waste dump facilities. Linking goods_issue to waste_dump enables facility-level cost tracking req',
    `wbs_element_id` BIGINT COMMENT 'Foreign key linking to finance.wbs_element. Business justification: Capital project material issues post to WBS for project cost tracking and asset capitalization. Required for accurate capital project accounting.',
    `batch_number` STRING COMMENT 'Batch or lot number for batch-managed materials. Enables traceability of specific production runs or procurement lots.. Valid values are `^[A-Z0-9]{10}$`',
    `created_by_user` STRING COMMENT 'SAP user ID of the person who created the material document. Provides audit trail for transaction origination.. Valid values are `^[A-Z0-9]{12}$`',
    `delivery_number` STRING COMMENT 'Outbound delivery document number for stock transport orders. Links the goods issue to the logistics execution document.. Valid values are `^[0-9]{10}$`',
    `document_date` DATE COMMENT 'Date on the physical document or the date the transaction was initiated. May differ from posting date.',
    `entry_date` DATE COMMENT 'Date when the material document was created in the system. Represents when the record was first captured.',
    `entry_time` TIMESTAMP COMMENT 'Time when the material document was created in the system (HH:MM:SS format).',
    `goods_recipient` STRING COMMENT 'Name of the person or organizational unit receiving the material. Used for accountability and tracking.',
    `header_text` STRING COMMENT 'Free-text notes or comments entered at the material document header level. Provides additional context for the transaction.',
    `material_document_item` STRING COMMENT 'Line item number within the material document. Represents the sequence of individual material movements within a single document.',
    `material_document_number` STRING COMMENT 'SAP material document number (MBLNR) that uniquely identifies the goods movement transaction in the source system. This is the externally-known business identifier for the goods issue.. Valid values are `^[0-9]{10}$`',
    `material_document_year` STRING COMMENT 'Fiscal year in which the material document was posted. Part of the compound key in SAP along with material document number.',
    `movement_indicator` STRING COMMENT 'Single-character indicator that further classifies the movement (e.g., B for goods movement for purchase order, F for production order, L for delivery).. Valid values are `^[A-Z]$`',
    `movement_status` STRING COMMENT 'Current lifecycle status of the goods issue transaction. Indicates whether the movement has been successfully posted, reversed, or is pending.. Valid values are `posted|reversed|cancelled|pending`',
    `movement_type` STRING COMMENT 'SAP movement type code that classifies the nature of the goods movement. Common values include 201 (goods issue to cost center), 261 (goods issue to work order/production order), 301 (plant-to-plant transfer), 311 (storage location to storage location transfer), 551 (scrapping from storage location), 202/262 (reversal of 201/261).. Valid values are `^[0-9]{3}$`',
    `plant_code` STRING COMMENT 'Four-character code identifying the mine site or plant from which the material was issued. Represents the source location for the goods movement.. Valid values are `^[A-Z0-9]{4}$`',
    `posting_date` DATE COMMENT 'Date on which the goods issue was posted to inventory and financial accounting. This is the principal business event timestamp for the transaction.',
    `quantity` DECIMAL(18,2) COMMENT 'Quantity of material issued in the base unit of measure. Positive values represent outbound movements; negative values represent reversals.',
    `reason_code` STRING COMMENT 'Code indicating the business reason for the goods issue (e.g., planned maintenance, breakdown repair, operational consumption, scrapping due to damage).. Valid values are `^[A-Z0-9]{4}$`',
    `receiving_plant_code` STRING COMMENT 'Four-character code identifying the destination mine site or plant for inter-plant transfers (movement type 301). Null for consumption issues.. Valid values are `^[A-Z0-9]{4}$`',
    `receiving_storage_location_code` STRING COMMENT 'Four-character code identifying the destination storage location for inter-storage-location transfers (movement type 311). Null for consumption issues.. Valid values are `^[A-Z0-9]{4}$`',
    `reference_document_number` STRING COMMENT 'External reference document number (e.g., delivery note, packing slip, transfer note) associated with the goods issue.',
    `reservation_item` STRING COMMENT 'Line item number within the reservation document.',
    `reservation_number` STRING COMMENT 'Material reservation number that pre-allocated the stock for this issue. Links the goods issue to the planning document.. Valid values are `^[0-9]{10}$`',
    `reversal_indicator` BOOLEAN COMMENT 'Flag indicating whether this goods issue has been reversed (true) or is an active transaction (false).',
    `reversal_movement_type` STRING COMMENT 'Movement type used for the reversal transaction (e.g., 202 reverses 201, 262 reverses 261). Populated only if the transaction has been reversed.. Valid values are `^[0-9]{3}$`',
    `special_stock_indicator` STRING COMMENT 'Single-character code indicating special stock categories (e.g., E for sales order stock, Q for project stock, K for consignment stock).. Valid values are `^[A-Z]$`',
    `unit_of_measure` STRING COMMENT 'Unit of measure for the issued quantity (e.g., EA for each, KG for kilograms, L for liters, M for meters, TON for tonnes).. Valid values are `^[A-Z]{2,3}$`',
    `unloading_point` STRING COMMENT 'Physical location or area within the receiving site where the material is delivered (e.g., workshop bay, crusher station, ROM pad).',
    `valuation_type` STRING COMMENT 'Split valuation type for materials managed with multiple stock types (e.g., own stock vs consignment stock).. Valid values are `^[A-Z0-9]{10}$`',
    `work_order_number` STRING COMMENT 'Maintenance or production work order number to which the material is issued for movement type 261. Links material consumption to specific maintenance activities or production runs.. Valid values are `^[0-9]{12}$`',
    CONSTRAINT pk_goods_issue PRIMARY KEY(`goods_issue_id`)
) COMMENT 'Unified material movement ledger recording all stock movements out of, between, and within warehouse locations across the mining operation. Covers consumption issues to cost centres and work orders (SAP movement type 201/261), inter-plant and inter-site stock transfers (movement type 301/311), stock transport orders between mine sites, scrapping, and returns. Sourced from SAP S/4HANA MM (MIGO/MSEG). Captures document number, posting date, movement type, issuing plant, storage location, receiving plant/storage location (for transfers), receiving cost centre or work order (for consumption), material, quantity, unit of measure, transfer order number, transport reference, and movement status. Serves as the SSOT for all material movements within and between mine sites — no other product in this domain records material movements.';

CREATE OR REPLACE TABLE `mining_ecm`.`procurement`.`inventory_balance` (
    `inventory_balance_id` BIGINT COMMENT 'Unique identifier for the inventory balance record.',
    `plant_id` BIGINT COMMENT 'Reference to the plant where the material is stored.',
    `material_master_id` BIGINT COMMENT 'Reference to the material being tracked in inventory.',
    `warehouse_location_id` BIGINT COMMENT 'Reference to the storage location within the plant where the material is physically stored.',
    `batch_number` STRING COMMENT 'Batch or lot number for batch-managed materials, enabling traceability of material origin and processing history.',
    `blocked_stock_quantity` DECIMAL(18,2) COMMENT 'Quantity of material blocked from use due to quality issues, damage, or other restrictions.',
    `count_cycle_code` STRING COMMENT 'Cycle count assignment code indicating the frequency category for this material and location.',
    `count_frequency_category` STRING COMMENT 'Classification of count frequency based on material criticality and ABC analysis, determining how often physical counts are performed. [ENUM-REF-CANDIDATE: daily|weekly|monthly|quarterly|annual|abc_a|abc_b|abc_c — 8 candidates stripped; promote to reference product]',
    `counted_quantity` DECIMAL(18,2) COMMENT 'Actual quantity counted during the physical inventory count.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this inventory balance record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO currency code for the stock value. [ENUM-REF-CANDIDATE: USD|EUR|GBP|AUD|CAD|CNY|JPY|ZAR|BRL|CLP — 10 candidates stripped; promote to reference product]',
    `in_transit_stock_quantity` DECIMAL(18,2) COMMENT 'Quantity of material currently in transit between storage locations or plants.',
    `last_count_date` DATE COMMENT 'Date when the most recent physical inventory count was performed for this material and location.',
    `last_goods_issue_date` DATE COMMENT 'Date of the most recent goods issue transaction that decreased stock at this location.',
    `last_goods_receipt_date` DATE COMMENT 'Date of the most recent goods receipt transaction that increased stock at this location.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this inventory balance record was last modified.',
    `maximum_stock_level_quantity` DECIMAL(18,2) COMMENT 'Maximum allowable stock level for the material at this location to prevent overstocking.',
    `physical_inventory_document_number` STRING COMMENT 'Document number of the most recent physical inventory count for this material and location.',
    `posting_status` STRING COMMENT 'Status of the physical inventory count posting to the general ledger and material ledger.. Valid values are `not_posted|posted|partially_posted|reversed`',
    `quality_inspection_stock_quantity` DECIMAL(18,2) COMMENT 'Quantity of material currently under quality inspection and not yet released for use.',
    `recount_flag` BOOLEAN COMMENT 'Indicates whether a recount was required due to significant variance or count discrepancy.',
    `reorder_point_quantity` DECIMAL(18,2) COMMENT 'Minimum stock level that triggers a replenishment order to prevent stockouts.',
    `safety_stock_quantity` DECIMAL(18,2) COMMENT 'Buffer stock maintained to protect against demand variability and supply disruptions.',
    `snapshot_timestamp` TIMESTAMP COMMENT 'Timestamp when this inventory balance snapshot was captured, enabling historical trend analysis.',
    `stock_accuracy_percentage` DECIMAL(18,2) COMMENT 'Calculated stock accuracy percentage for this material and location, used for inventory KPI reporting.',
    `stock_status` STRING COMMENT 'Current operational status of the stock based on availability and business rules.. Valid values are `available|low_stock|out_of_stock|excess|obsolete`',
    `storage_location_code` STRING COMMENT 'Business identifier for the storage location within the plant.',
    `system_quantity_at_count` DECIMAL(18,2) COMMENT 'System-recorded quantity at the time of the physical inventory count, used for variance calculation.',
    `total_stock_value` DECIMAL(18,2) COMMENT 'Total monetary value of all stock at this location, calculated using standard cost or moving average price.',
    `unit_of_measure` STRING COMMENT 'Unit of measure for the stock quantities, such as kilograms, metric tons, liters, or pieces. [ENUM-REF-CANDIDATE: KG|MT|TON|L|M3|EA|PC|M|FT|GAL|LB — 11 candidates stripped; promote to reference product]',
    `unrestricted_stock_quantity` DECIMAL(18,2) COMMENT 'Quantity of material available for unrestricted use and consumption in operations.',
    `valuation_type` STRING COMMENT 'Method used to value the inventory, such as standard cost, moving average price, FIFO, or LIFO.. Valid values are `standard_cost|moving_average|fifo|lifo`',
    `variance_quantity` DECIMAL(18,2) COMMENT 'Difference between system quantity and counted quantity, calculated as counted minus system quantity.',
    `variance_value` DECIMAL(18,2) COMMENT 'Monetary value of the variance between system and counted quantities.',
    CONSTRAINT pk_inventory_balance PRIMARY KEY(`inventory_balance_id`)
) COMMENT 'Current and historical stock balance for each material at each storage location and plant, incorporating physical count records, cycle count results, and reconciliation outcomes. Sourced from SAP S/4HANA MM (MARD/MCHB/MI01/MI07). Captures material, plant, storage location, batch, unrestricted stock, quality inspection stock, blocked stock, in-transit stock, reorder point, safety stock, maximum stock level. Also records all physical inventory counts including count document number, count date, system quantity, counted quantity, variance quantity, variance value, recount flag, posting status, count cycle assignment, and count frequency category. Serves as the SSOT for real-time inventory visibility, physical count audit trail, stock accuracy KPI reporting, and cycle count compliance — no other product in this domain records stock balances or physical counts.';

CREATE OR REPLACE TABLE `mining_ecm`.`procurement`.`stock_transfer` (
    `stock_transfer_id` BIGINT COMMENT 'Unique identifier for the stock transfer record. Primary key.',
    `cost_centre_id` BIGINT COMMENT 'Foreign key reference to the cost centre that will bear the cost of the stock transfer, if applicable. Used for internal cost allocation and management accounting.',
    `delivery_schedule_id` BIGINT COMMENT 'Foreign key linking to procurement.delivery_schedule. Business justification: Stock transfers between mine sites or plants can be governed by a delivery schedule, particularly when they are part of a blanket agreement or scheduled replenishment plan. Linking stock_transfer to d',
    `freight_order_id` BIGINT COMMENT 'Foreign key linking to procurement.freight_order. Business justification: Stock transfers between mine sites or plants in a mining operation require freight execution. stock_transfer currently stores transport_reference_number as a string. Adding freight_order_id normalizes',
    `warehouse_location_id` BIGINT COMMENT 'Foreign key reference to the specific storage location within the sending plant from which the material is being issued (e.g., central warehouse, maintenance stores, ROM pad).',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to procurement.purchase_order. Business justification: In SAP-style procurement, inter-company or inter-plant stock transfers are often executed via a Stock Transfer Order (STO), which is a specific type of purchase order. Linking stock_transfer to purcha',
    `plant_id` BIGINT COMMENT 'Foreign key reference to the plant or site to which the material is being delivered. Links to the plant/site master data.',
    `receiving_storage_location_warehouse_location_id` BIGINT COMMENT 'Foreign key reference to the specific storage location within the receiving plant where the material will be received and stored (e.g., remote site stores, maintenance workshop, processing plant warehouse).',
    `sending_plant_id` BIGINT COMMENT 'Foreign key reference to the plant or site from which the material is being dispatched. Links to the plant/site master data.',
    `material_master_id` BIGINT COMMENT 'Foreign key reference to the material master record being transferred. Links to the material product in the procurement or inventory domain.',
    `actual_receipt_date` DATE COMMENT 'The actual date when the material was physically received and goods receipt was posted at the receiving storage location. Null if not yet received.',
    `batch_number` STRING COMMENT 'The batch or lot number of the material being transferred, if batch management is active for the material. Critical for traceability of consumables, chemicals, explosives, and quality-controlled items.',
    `carrier_name` STRING COMMENT 'The name of the logistics carrier, freight company, or internal fleet responsible for transporting the material between locations (e.g., Internal Fleet, ABC Logistics, Mine Haul Trucks).',
    `created_by_user` STRING COMMENT 'The SAP user ID or employee identifier of the person who created the stock transfer order in the system. Used for audit trail and accountability.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when the stock transfer order record was first created in SAP S/4HANA MM. Audit trail timestamp for record creation.',
    `currency_code` STRING COMMENT 'The three-letter ISO 4217 currency code for the valuation amount (e.g., USD, AUD, CAD, ZAR). Reflects the company code currency or plant-specific valuation currency.. Valid values are `^[A-Z]{3}$`',
    `goods_issue_posted_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the goods issue (dispatch) has been posted in SAP MM, reducing inventory at the sending location. True if posted, False if not yet posted.',
    `goods_receipt_posted_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the goods receipt has been posted in SAP MM, increasing inventory at the receiving location. True if posted, False if not yet received.',
    `last_modified_by_user` STRING COMMENT 'The SAP user ID or employee identifier of the person who last modified the stock transfer order. Used for audit trail and change tracking.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when the stock transfer order record was last updated in SAP S/4HANA MM. Audit trail timestamp for record modification.',
    `material_description` STRING COMMENT 'Short text description of the material being transferred, providing human-readable identification of the item (e.g., Hydraulic Pump Assembly, Grinding Media Balls 50mm, PPE Safety Helmet).',
    `movement_type` STRING COMMENT 'The SAP MM movement type code (3-digit numeric) that classifies the inventory transaction (e.g., 301 for transfer posting plant to plant, 311 for transfer posting storage location to storage location).. Valid values are `^[0-9]{3}$`',
    `priority` STRING COMMENT 'The urgency level assigned to the stock transfer order, influencing logistics scheduling and dispatch sequencing. Critical transfers support emergency breakdowns or safety-critical operations.. Valid values are `low|normal|high|urgent|critical`',
    `reason_code` STRING COMMENT 'Optional code indicating the business reason for the stock transfer (e.g., MAINT for maintenance requirement, PROJ for project demand, REBAL for inventory rebalancing, EMERG for emergency supply).',
    `receiving_storage_location_code` STRING COMMENT 'The SAP storage location code (4-character alphanumeric) within the receiving plant identifying the specific warehouse, bin, or stockpile area where material will be placed upon receipt.. Valid values are `^[A-Z0-9]{4}$`',
    `requested_delivery_date` DATE COMMENT 'The date by which the receiving plant or site requires the material to arrive. Used for planning and logistics scheduling to ensure operational continuity.',
    `sending_storage_location_code` STRING COMMENT 'The SAP storage location code (4-character alphanumeric) within the sending plant identifying the specific warehouse, bin, or stockpile area from which material is dispatched.. Valid values are `^[A-Z0-9]{4}$`',
    `serial_number` STRING COMMENT 'The unique serial number of the material item being transferred, if serial number management is active. Used for high-value equipment components, critical spare parts, and serialized assets.',
    `special_stock_indicator` STRING COMMENT 'SAP MM special stock indicator code if the material is held under special stock conditions (e.g., consignment stock, project stock, sales order stock). Blank for unrestricted stock.',
    `transfer_date` DATE COMMENT 'The planned or actual date when the stock transfer order was executed and goods were dispatched from the sending location. Business event date for the transfer transaction.',
    `transfer_order_number` STRING COMMENT 'The externally-known unique business identifier for the stock transfer order as recorded in SAP S/4HANA MM. Format: STO followed by 10 digits.. Valid values are `^STO[0-9]{10}$`',
    `transfer_quantity` DECIMAL(18,2) COMMENT 'The quantity of material being transferred in the base unit of measure. Supports up to 3 decimal places for precision in measuring spare parts, consumables, or bulk materials.',
    `transfer_status` STRING COMMENT 'Current lifecycle status of the stock transfer order: draft (not yet released), released (approved for execution), in transit (goods dispatched but not received), partially received (some items received), completed (all items received), or cancelled.. Valid values are `draft|released|in_transit|partially_received|completed|cancelled`',
    `transfer_type` STRING COMMENT 'Classification of the stock transfer based on the nature of the movement: plant-to-plant, storage location to storage location within same plant, site-to-site across mine operations, warehouse to mine site, or central warehouse to remote location.. Valid values are `plant_to_plant|storage_location_to_storage_location|site_to_site|warehouse_to_mine|central_to_remote`',
    `unit_of_measure` STRING COMMENT 'The base unit of measure for the transfer quantity (e.g., EA for each, KG for kilograms, MT for metric tonnes, L for litres, M for metres). ISO standard 2-3 character codes.. Valid values are `^[A-Z]{2,3}$`',
    `valuation_amount` DECIMAL(18,2) COMMENT 'The total monetary value of the stock being transferred, calculated based on the material valuation price and transfer quantity. Used for internal accounting and inventory valuation purposes.',
    `vehicle_registration` STRING COMMENT 'The registration or fleet number of the vehicle (truck, haul truck, light vehicle) used to transport the material. Enables tracking of transport asset utilization and route compliance.',
    CONSTRAINT pk_stock_transfer PRIMARY KEY(`stock_transfer_id`)
) COMMENT 'Records the movement of materials between plants, storage locations, or mine sites within the same organisation (e.g., transferring spare parts from central warehouse to a remote mine site). Sourced from SAP S/4HANA MM Stock Transfer Order (STO). Captures transfer order number, sending plant, receiving plant, sending storage location, receiving storage location, material, quantity, transfer date, transport reference, and status.';

CREATE OR REPLACE TABLE `mining_ecm`.`procurement`.`warehouse_location` (
    `warehouse_location_id` BIGINT COMMENT 'Unique identifier for the warehouse location record. Primary key.',
    `cost_centre_id` BIGINT COMMENT 'FK to finance.cost_centre',
    `mine_site_id` BIGINT COMMENT 'Reference to the mine site or port facility where this warehouse location is physically situated.',
    `access_restriction_level` STRING COMMENT 'Security classification level governing personnel access to the warehouse location. Determines required clearances and access control procedures.. Valid values are `unrestricted|controlled|restricted|high_security`',
    `address_line_1` STRING COMMENT 'Primary street address or location descriptor for the warehouse facility. Organizational contact data classified as confidential.',
    `address_line_2` STRING COMMENT 'Secondary address information such as building number, zone, or area designation. Organizational contact data classified as confidential.',
    `capacity_pallet_positions` STRING COMMENT 'Number of standard pallet positions available in the warehouse location. Used for space utilization planning.',
    `capacity_volume_m3` DECIMAL(18,2) COMMENT 'Maximum storage capacity of the location measured in cubic meters. Applicable for enclosed storage facilities.',
    `capacity_weight_tonnes` DECIMAL(18,2) COMMENT 'Maximum weight capacity of the storage location in metric tonnes. Critical for structural load limits and safety compliance.',
    `city` STRING COMMENT 'City or municipality where the warehouse location is situated. Organizational contact data classified as confidential.',
    `contact_email` STRING COMMENT 'Primary email address for warehouse location inquiries and communications. Organizational contact data classified as confidential.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `contact_phone` STRING COMMENT 'Primary contact telephone number for the warehouse location. Organizational contact data classified as confidential.',
    `country_code` STRING COMMENT 'Three-letter ISO country code where the warehouse location is situated.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this warehouse location record was first created in the system.',
    `effective_from_date` DATE COMMENT 'Date from which this warehouse location became operational and available for use.',
    `effective_to_date` DATE COMMENT 'Date on which this warehouse location ceased operations or was decommissioned. Null for currently active locations.',
    `environmental_monitoring_flag` BOOLEAN COMMENT 'Indicates whether the location has automated environmental monitoring systems for temperature, humidity, gas detection, or other parameters.',
    `explosives_license_expiry_date` DATE COMMENT 'Expiration date of the explosives storage license. Requires renewal before this date to maintain compliance.',
    `explosives_license_number` STRING COMMENT 'Government-issued license number authorizing storage of explosives at this magazine location. Applicable only for explosives storage facilities.',
    `fire_suppression_system_type` STRING COMMENT 'Type of fire suppression system installed at the warehouse location. Critical for emergency response planning and insurance compliance.. Valid values are `none|sprinkler|foam|gas|dry_chemical|water_mist`',
    `hazardous_goods_classification` STRING COMMENT 'UN hazardous materials classification code(s) for materials authorized to be stored at this location. Multiple classes separated by semicolon. Empty if non-hazardous storage only.',
    `last_inspection_date` DATE COMMENT 'Date of the most recent safety or compliance inspection conducted at this warehouse location.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this warehouse location record was last updated in the system.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the warehouse location in decimal degrees format. Used for logistics routing and emergency response.',
    `location_code` STRING COMMENT 'Unique business identifier code for the warehouse location used across procurement and inventory systems. Typically follows site-plant-area-bin hierarchy encoding.. Valid values are `^[A-Z0-9]{4,12}$`',
    `location_name` STRING COMMENT 'Human-readable name of the warehouse location or storage facility.',
    `location_type` STRING COMMENT 'Classification of the storage facility type based on its primary function and storage characteristics. Determines handling procedures and access controls. [ENUM-REF-CANDIDATE: bulk_storage|hazmat_bunker|cold_store|open_laydown|explosives_magazine|general_warehouse|parts_store|consumables_store|quarantine_area|scrap_yard — 10 candidates stripped; promote to reference product]',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the warehouse location in decimal degrees format. Used for logistics routing and emergency response.',
    `next_inspection_due_date` DATE COMMENT 'Scheduled date for the next mandatory safety or compliance inspection of the warehouse location.',
    `operating_hours` STRING COMMENT 'Standard operating hours for the warehouse location. Format: days and time ranges (e.g., Mon-Fri 0600-1800, Sat 0800-1200).',
    `operational_status` STRING COMMENT 'Current operational state of the warehouse location indicating availability for storage and retrieval operations.. Valid values are `active|inactive|under_construction|decommissioned|maintenance|temporarily_closed`',
    `plant_code` STRING COMMENT 'SAP plant code representing the operational unit or processing facility associated with this warehouse location.. Valid values are `^[A-Z0-9]{4}$`',
    `postal_code` STRING COMMENT 'Postal or ZIP code for the warehouse location address. Organizational contact data classified as confidential.',
    `ppe_requirements` STRING COMMENT 'Mandatory personal protective equipment required for entry to this warehouse location. Pipe-separated list of PPE types (e.g., hard_hat|safety_boots|high_vis_vest|respirator).',
    `state_province` STRING COMMENT 'State, province, or administrative region of the warehouse location. Organizational contact data classified as confidential.',
    `temperature_controlled_flag` BOOLEAN COMMENT 'Indicates whether the warehouse location has climate control systems for temperature-sensitive materials storage.',
    `temperature_max_celsius` DECIMAL(18,2) COMMENT 'Maximum operating temperature maintained in the storage location in degrees Celsius. Applicable for temperature-controlled facilities.',
    `temperature_min_celsius` DECIMAL(18,2) COMMENT 'Minimum operating temperature maintained in the storage location in degrees Celsius. Applicable for temperature-controlled facilities.',
    `warehouse_manager_name` STRING COMMENT 'Name of the person responsible for managing operations at this warehouse location. Business reference, not direct PII.',
    CONSTRAINT pk_warehouse_location PRIMARY KEY(`warehouse_location_id`)
) COMMENT 'Master register of all physical warehouse facilities, storage locations, laydown areas, and hazardous materials stores across mine sites and port facilities. Captures location code, name, plant, site, location type (bulk storage, hazmat bunker, cold store, open laydown, explosives magazine), capacity (volume/weight/pallet positions), hazardous goods classification, GPS coordinates, access restrictions, and operational status. Serves as the SSOT for all storage infrastructure managed by the supply function.';

CREATE OR REPLACE TABLE `mining_ecm`.`procurement`.`inbound_delivery` (
    `inbound_delivery_id` BIGINT COMMENT 'Unique identifier for the inbound delivery record. Primary key.',
    `delivery_schedule_id` BIGINT COMMENT 'Foreign key linking to procurement.delivery_schedule. Business justification: An inbound delivery fulfills a specific delivery schedule call-off line. While procurement_goods_receipt already links delivery_schedule_id, the inbound_delivery itself (which tracks logistics from ve',
    `freight_order_id` BIGINT COMMENT 'Foreign key linking to procurement.freight_order. Business justification: Inbound delivery is the receiving-side record of a freight order. One freight order results in one inbound delivery (1:1 or N:1). Freight order manages logistics execution; inbound delivery tracks sit',
    `purchase_order_id` BIGINT COMMENT 'Reference to the originating purchase order that this delivery fulfills. Links to procurement transaction.',
    `purchase_order_line_id` BIGINT COMMENT 'Foreign key linking to procurement.purchase_order_line. Business justification: An inbound delivery is typically executed against a specific purchase order line (not just the header PO). inbound_delivery already has procurement_purchase_order_id but lacks line-level granularity. ',
    `saleable_product_id` BIGINT COMMENT 'Foreign key linking to product.saleable_product. Business justification: Inbound deliveries of finished products from processing plants to port facilities require product specification matching for quality verification, inventory posting, and stockpile allocation. Critical',
    `specification_id` BIGINT COMMENT 'Foreign key linking to product.specification. Business justification: Inbound deliveries of purchased materials (reagents, ore feed, consumables) must be checked against a product specification for quality acceptance. The specification drives the quality inspection proc',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to procurement.material_master. Business justification: An inbound delivery tracks the physical movement of specific materials from vendor dispatch to mine site receipt. Linking inbound_delivery directly to material_master (via supply_material_master_id) e',
    `vendor_id` BIGINT COMMENT 'Reference to the vendor who dispatched the materials. Links to the vendor master data.',
    `warehouse_location_id` BIGINT COMMENT 'Foreign key linking to procurement.warehouse_location. Business justification: Inbound deliveries are received at specific warehouse storage locations. The inbound_delivery table has destination_storage_location (STRING) but no FK to warehouse_location. Adding destination_storag',
    `actual_arrival_date` DATE COMMENT 'The actual date when the delivery arrived at the destination plant. Null if delivery has not yet arrived. Used for performance tracking and variance analysis.',
    `container_number` STRING COMMENT 'The ISO standard container identification number for containerized sea freight. Format: 4 letters (owner code) + 7 digits.. Valid values are `^[A-Z]{4}[0-9]{7}$`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this inbound delivery record was first created in the system. Audit trail field.',
    `customs_clearance_date` DATE COMMENT 'The date when customs clearance was completed for international shipments. Null for domestic deliveries or pending clearances.',
    `customs_clearance_status` STRING COMMENT 'The status of customs clearance for international shipments. Not required for domestic deliveries.. Valid values are `not_required|pending|in_progress|cleared|held|rejected`',
    `customs_declaration_number` STRING COMMENT 'The official customs declaration reference number for international shipments. Used for compliance tracking and audit.',
    `dangerous_goods_declaration_reference` STRING COMMENT 'Reference number to the dangerous goods declaration document if the delivery contains hazardous materials. Required for compliance with transport safety regulations.',
    `dangerous_goods_flag` BOOLEAN COMMENT 'Indicates whether this delivery contains dangerous goods requiring special handling and documentation per international transport regulations.',
    `delivery_note_number` STRING COMMENT 'The externally-known delivery note number issued by the vendor or carrier. This is the business identifier used for tracking and reference across systems.. Valid values are `^[A-Z0-9]{10}$`',
    `delivery_notes` STRING COMMENT 'General notes and comments related to this delivery. May include vendor remarks, carrier observations, or internal receiving notes.',
    `delivery_priority` STRING COMMENT 'The business priority assigned to this delivery. Critical deliveries may contain materials needed for urgent production or maintenance activities.. Valid values are `low|normal|high|critical`',
    `delivery_status` STRING COMMENT 'Current lifecycle status of the inbound delivery. Tracks progression from planning through final goods receipt. [ENUM-REF-CANDIDATE: planned|dispatched|in_transit|arrived|goods_received|cancelled|delayed — 7 candidates stripped; promote to reference product]',
    `destination_plant_code` STRING COMMENT 'The mine site or processing plant code where the materials are to be received. Aligns with SAP plant master data.. Valid values are `^[A-Z0-9]{4}$`',
    `dispatch_date` DATE COMMENT 'The date when the vendor dispatched the materials from the origin location. Marks the start of the logistics journey.',
    `expected_arrival_date` DATE COMMENT 'The planned date when the delivery is expected to arrive at the destination plant. Used for planning and scheduling receipt operations.',
    `freight_cost_amount` DECIMAL(18,2) COMMENT 'The total freight cost charged for transporting this delivery. Includes carrier charges and may include fuel surcharges and accessorial fees.',
    `freight_cost_currency_code` STRING COMMENT 'The three-letter ISO currency code for the freight cost amount.. Valid values are `^[A-Z]{3}$`',
    `goods_receipt_completed_flag` BOOLEAN COMMENT 'Indicates whether the goods receipt process has been completed in the system. True when all items have been received and posted to inventory.',
    `incoterm_code` STRING COMMENT 'The International Commercial Terms code defining the responsibilities and risk transfer point between vendor and buyer. Common mining terms include FOB (Free on Board) and CIF (Cost Insurance and Freight).. Valid values are `^(EXW|FCA|CPT|CIP|DAP|DPU|DDP|FAS|FOB|CFR|CIF)$`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this inbound delivery record was last updated. Tracks the most recent change to any field in the record.',
    `origin_location` STRING COMMENT 'The dispatch location from which the materials were shipped. May be vendor warehouse, port, or distribution center.',
    `quality_inspection_required_flag` BOOLEAN COMMENT 'Indicates whether incoming materials require quality inspection before goods receipt posting. True for materials subject to quality control procedures.',
    `seal_number` STRING COMMENT 'The security seal number applied to the container or truck. Used to verify that the shipment has not been tampered with during transit.',
    `shipment_type` STRING COMMENT 'Classification of the shipment based on delivery urgency and consolidation strategy.. Valid values are `standard|express|consolidated|direct|partial`',
    `special_handling_instructions` STRING COMMENT 'Free-text field capturing any special handling requirements for this delivery such as temperature control, fragile materials, or specific unloading procedures.',
    `total_gross_weight_kg` DECIMAL(18,2) COMMENT 'The total gross weight of the delivery including packaging and pallets, measured in kilograms. Used for freight cost calculation and logistics planning.',
    `total_net_weight_kg` DECIMAL(18,2) COMMENT 'The net weight of the materials excluding packaging, measured in kilograms. Represents the actual usable material weight.',
    `total_volume_m3` DECIMAL(18,2) COMMENT 'The total volumetric space occupied by the delivery, measured in cubic meters. Used for transport capacity planning and freight cost calculation.',
    `transport_mode` STRING COMMENT 'The primary mode of transportation used for this delivery. Multimodal indicates multiple transport legs using different modes.. Valid values are `road|rail|sea|air|multimodal`',
    `un_number` STRING COMMENT 'The four-digit UN number identifying the dangerous goods classification if applicable. Used for hazardous material identification and handling.. Valid values are `^UN[0-9]{4}$`',
    CONSTRAINT pk_inbound_delivery PRIMARY KEY(`inbound_delivery_id`)
) COMMENT 'Tracks the inbound logistics of materials from vendor dispatch to mine site receipt, including road, rail, and sea freight legs. Sourced from SAP S/4HANA MM Inbound Delivery (VL31N). Captures delivery note number, vendor, carrier, origin location, destination plant, expected arrival date, actual arrival date, transport mode, freight cost, customs clearance status, dangerous goods declaration reference, and delivery status.';

CREATE OR REPLACE TABLE `mining_ecm`.`procurement`.`outbound_shipment` (
    `outbound_shipment_id` BIGINT COMMENT 'Unique identifier for the outbound shipment record. Primary key for the outbound shipment entity.',
    `cargo_shipment_id` BIGINT COMMENT 'Foreign key linking to sales.cargo_shipment. Business justification: Port reconciliation, demurrage settlement, and revenue recognition require matching the physical outbound shipment (procurement logistics) to the commercial cargo shipment (sales contract). Mining ope',
    `contract_id` BIGINT COMMENT 'Foreign key linking to procurement.contract. Business justification: Outbound shipments of mineral concentrate or commodity product are executed against procurement/sales contracts. The outbound_shipment table currently stores sales_contract_number as a free-text strin',
    `counterparty_id` BIGINT COMMENT 'Unique identifier of the customer purchasing and receiving the shipment, linking to the customer master data.',
    `delivery_destination_id` BIGINT COMMENT 'Foreign key linking to customer.delivery_destination. Business justification: Outbound shipments in mining must reference the customers discharge port/terminal for berth scheduling, draft restrictions, and demurrage tracking. destination_port_code and destination_port_name are',
    `freight_order_id` BIGINT COMMENT 'Foreign key linking to procurement.freight_order. Business justification: Outbound shipment is the shipping-side record of a freight order. One freight order results in one outbound shipment (1:1 or N:1). Freight order manages logistics execution; outbound shipment tracks c',
    `warehouse_location_id` BIGINT COMMENT 'Foreign key linking to procurement.warehouse_location. Business justification: Outbound shipments originate from specific warehouse/port locations. The outbound_shipment table has origin_location_code (STRING) but no FK to warehouse_location. Adding origin_warehouse_location_id ',
    `quality_certificate_id` BIGINT COMMENT 'Foreign key linking to sales.quality_certificate. Business justification: Quality certificates are required for customs clearance, customer acceptance, and provisional price finalisation on every physical shipment. Mining logistics teams must link the outbound shipment to i',
    `saleable_product_id` BIGINT COMMENT 'Foreign key linking to product.saleable_product. Business justification: Outbound shipments transport specific saleable products with defined grade specifications. Essential for cargo manifests, quality certificates, sales contract fulfillment, and revenue recognition. Dir',
    `specification_id` BIGINT COMMENT 'Foreign key linking to product.specification. Business justification: Outbound shipments of saleable mining product must reference the specific specification version used for contractual compliance, quality certificate issuance, and demurrage dispute resolution. The exa',
    `vessel_id` BIGINT COMMENT 'Foreign key linking to sales.vessel. Business justification: Outbound shipments in mining are executed by specific vessels; vessel vetting status, deadweight tonnage, and charter details are required for port authority compliance and demurrage calculation. vess',
    `actual_arrival_date` DATE COMMENT 'Actual date the vessel arrived at the destination port.',
    `actual_departure_date` DATE COMMENT 'Actual date the vessel departed from the origin port or loading facility.',
    `average_grade_percent` DECIMAL(18,2) COMMENT 'Average grade or concentration of the valuable mineral in the shipped product, expressed as a percentage (e.g., iron content in iron ore concentrate).',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this shipment record was first created in the system.',
    `demurrage_cost` DECIMAL(18,2) COMMENT 'Total demurrage cost incurred due to delays beyond agreed laytime, calculated based on daily demurrage rate and number of demurrage days.',
    `demurrage_days` DECIMAL(18,2) COMMENT 'Number of days the vessel was delayed beyond the agreed laytime at the loading or discharge port, potentially incurring demurrage charges.',
    `destination_country_code` STRING COMMENT 'Three-letter ISO country code for the destination country of the shipment.. Valid values are `^[A-Z]{3}$`',
    `estimated_arrival_date` DATE COMMENT 'Estimated date the vessel will arrive at the destination port, updated based on voyage progress and weather conditions.',
    `freight_currency_code` STRING COMMENT 'Three-letter ISO currency code in which the freight rate is denominated.. Valid values are `^[A-Z]{3}$`',
    `freight_rate_per_tonne` DECIMAL(18,2) COMMENT 'Negotiated freight cost per metric tonne for transporting the shipment from origin to destination.',
    `incoterms_code` STRING COMMENT 'Three-letter INCOTERMS code defining the delivery terms and transfer of risk between seller and buyer (e.g., FOB for Free on Board, CIF for Cost Insurance and Freight). [ENUM-REF-CANDIDATE: FOB|CIF|CFR|EXW|FCA|CPT|CIP|DAP|DPU|DDP — 10 candidates stripped; promote to reference product]',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Date and time when this shipment record was most recently modified.',
    `laycan_end_date` DATE COMMENT 'End date of the laycan window, representing the latest date the vessel may arrive for loading before the charter party may be cancelled.',
    `laycan_start_date` DATE COMMENT 'Start date of the laycan (lay days cancelling) window, representing the earliest date the vessel may arrive for loading.',
    `loaded_quantity_tonnes` DECIMAL(18,2) COMMENT 'Actual quantity of commodity product loaded onto the vessel, measured in metric tonnes as per draft survey or weighbridge.',
    `loading_completion_timestamp` TIMESTAMP COMMENT 'Date and time when loading operations were completed and the vessel was ready to depart.',
    `loading_start_timestamp` TIMESTAMP COMMENT 'Date and time when loading operations commenced at the origin port or stockpile.',
    `moisture_content_percent` DECIMAL(18,2) COMMENT 'Moisture content of the shipped commodity product, expressed as a percentage of total weight, used for quality and pricing adjustments.',
    `nominated_quantity_tonnes` DECIMAL(18,2) COMMENT 'Planned or nominated quantity of commodity product to be shipped, measured in metric tonnes.',
    `origin_location_name` STRING COMMENT 'Full name of the origin port, mine site, or stockpile facility from which the shipment departs.',
    `quantity_variance_tonnes` DECIMAL(18,2) COMMENT 'Difference between nominated and loaded quantity in metric tonnes, calculated as loaded minus nominated.',
    `remarks` STRING COMMENT 'Free-text field for additional notes, special instructions, or observations related to the shipment (e.g., weather delays, quality issues, customer requests).',
    `shipment_number` STRING COMMENT 'Externally-known unique business identifier for the shipment, used for tracking and reference across systems and with customers.. Valid values are `^[A-Z0-9]{8,20}$`',
    `shipment_status` STRING COMMENT 'Current lifecycle status of the outbound shipment, tracking progress from planning through to delivery completion. [ENUM-REF-CANDIDATE: planned|loading|in_transit|arrived|discharged|completed|cancelled — 7 candidates stripped; promote to reference product]',
    `shipping_agent_name` STRING COMMENT 'Name of the shipping agent or freight forwarder managing the logistics and documentation for this shipment.',
    `total_freight_cost` DECIMAL(18,2) COMMENT 'Total freight cost for the shipment, calculated as loaded quantity multiplied by freight rate per tonne.',
    CONSTRAINT pk_outbound_shipment PRIMARY KEY(`outbound_shipment_id`)
) COMMENT 'Manages the outbound logistics of processed mineral concentrate or commodity product from mine site or port stockpile to customer delivery point. Captures shipment number, origin port or stockpile, destination port, vessel name, voyage number, bill of lading number, commodity product, nominated quantity, loaded quantity, laycan dates, actual departure date, ETA, Incoterms (FOB/CIF), freight rate, and shipment status. Coordinates with the sales domain for offtake fulfilment.';

CREATE OR REPLACE TABLE `mining_ecm`.`procurement`.`procurement_vendor_performance` (
    `procurement_vendor_performance_id` BIGINT COMMENT 'Primary key for vendor_performance',
    `commodity_id` BIGINT COMMENT 'Foreign key linking to product.commodity. Business justification: Mining vendor performance is evaluated per commodity (e.g., explosives supplier vs. reagent supplier scorecards). A FK to commodity replaces the denormalized commodity_category text field and enables ',
    `contract_id` BIGINT COMMENT 'Foreign key linking to procurement.procurement_contract. Business justification: vendor_performance evaluates a suppliers performance, which is most meaningful in the context of a specific procurement contract. Adding procurement_contract_id allows contract-specific performance t',
    `framework_agreement_id` BIGINT COMMENT 'Foreign key linking to procurement.framework_agreement. Business justification: Vendor performance evaluations in mining procurement are frequently conducted in the context of long-term framework agreements. Linking procurement_vendor_performance to framework_agreement enables pe',
    `vendor_id` BIGINT COMMENT 'Reference to the vendor being evaluated. Links to the vendor master record in SAP S/4HANA MM.',
    `approval_date` DATE COMMENT 'Date when the vendor performance evaluation was formally approved by the designated authority.',
    `approved_by` STRING COMMENT 'Name of the manager or executive who approved the vendor performance evaluation and its recommendations.',
    `approved_date` DATE COMMENT 'The date when the vendor performance evaluation was approved.',
    `average_issue_resolution_time_days` DECIMAL(18,2) COMMENT 'The average number of days taken by the vendor to resolve reported issues, complaints, or non-conformances during the evaluation period.',
    `corrective_action_description` STRING COMMENT 'Detailed description of the corrective actions required from the vendor, including specific performance gaps and expected improvements.',
    `corrective_action_required_flag` BOOLEAN COMMENT 'Indicates whether corrective action is required from the vendor to address performance deficiencies identified during the evaluation.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the vendor performance evaluation record was first created in the system. Audit trail field.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the total procurement value (e.g., USD, AUD, CAD).. Valid values are `^[A-Z]{3}$`',
    `delivery_performance_score` DECIMAL(18,2) COMMENT 'The score measuring the vendors delivery performance, including on-time delivery rate and order fulfillment metrics.',
    `evaluation_date` DATE COMMENT 'The date when the vendor performance evaluation was formally conducted and recorded.',
    `evaluation_notes` STRING COMMENT 'Free-text notes and comments from the evaluator providing additional context, observations, or recommendations regarding the vendors performance.',
    `evaluation_period_end_date` DATE COMMENT 'The end date of the performance evaluation period. Defines the conclusion of the assessment window for vendor KPIs.',
    `evaluation_period_start_date` DATE COMMENT 'The start date of the performance evaluation period. Defines the beginning of the assessment window for vendor KPIs.',
    `evaluation_status` STRING COMMENT 'Current workflow status of the vendor performance evaluation record. Tracks the evaluation through draft, approval, and closure stages.. Valid values are `draft|submitted|approved|rejected|closed`',
    `evaluator_name` STRING COMMENT 'Name of the procurement or category manager who conducted the vendor performance evaluation.',
    `evaluator_role` STRING COMMENT 'Job role or title of the person who conducted the evaluation (e.g., Procurement Manager, Category Manager, Supply Chain Lead).',
    `hse_incident_count` STRING COMMENT 'Total number of health, safety, and environmental incidents attributed to the vendor during the evaluation period. Sourced from IsoMetrix HSE incident management system.',
    `invoice_accuracy_rate_percent` DECIMAL(18,2) COMMENT 'Percentage of vendor invoices that matched purchase orders and goods receipts without discrepancies (three-way match success rate). Sourced from SAP S/4HANA FI invoice verification.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the vendor performance evaluation record was last updated. Audit trail field for tracking changes.',
    `ncr_count` STRING COMMENT 'The total number of Non-Conformance Reports (NCRs) raised against the vendor during the evaluation period for quality issues.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next vendor performance evaluation. Supports periodic review cycles (e.g., quarterly, semi-annual, annual).',
    `on_time_delivery_rate_percent` DECIMAL(18,2) COMMENT 'Percentage of purchase orders delivered on or before the scheduled delivery date during the evaluation period. Key delivery performance KPI.',
    `order_fill_rate_percent` DECIMAL(18,2) COMMENT 'The percentage of purchase order line items completely fulfilled by the vendor without shortages or backorders during the evaluation period.',
    `overall_performance_rating` STRING COMMENT 'Composite performance rating summarizing the vendors overall performance across all evaluation dimensions. Used for contract renewal and preferred supplier decisions.. Valid values are `excellent|good|satisfactory|needs_improvement|unsatisfactory`',
    `overall_performance_score` DECIMAL(18,2) COMMENT 'The composite overall performance score for the vendor across all evaluation dimensions, typically expressed as a percentage or weighted average.',
    `performance_rating` STRING COMMENT 'The overall performance rating classification assigned to the vendor based on the evaluation results, used for vendor rationalization and preferred supplier decisions.. Valid values are `preferred|approved|conditional|probation|suspended`',
    `preferred_vendor_flag` BOOLEAN COMMENT 'Indicates whether the vendor has been designated as a preferred supplier based on this performance evaluation. Preferred vendors receive priority in sourcing decisions.',
    `price_performance_score` DECIMAL(18,2) COMMENT 'The score measuring the vendors price competitiveness and adherence to contracted pricing.',
    `price_variance_percent` DECIMAL(18,2) COMMENT 'The percentage variance between actual invoiced prices and contracted prices during the evaluation period. Positive values indicate overcharges, negative values indicate discounts.',
    `quality_acceptance_rate_percent` DECIMAL(18,2) COMMENT 'Percentage of goods receipts that passed quality inspection without rejection or non-conformance during the evaluation period. Calculated from LabWare LIMS and SAP quality inspection data.',
    `quality_performance_score` DECIMAL(18,2) COMMENT 'The score measuring the vendors quality performance, including rejection rates and non-conformance records.',
    `rejection_count` STRING COMMENT 'Total number of goods receipts rejected due to quality non-conformance during the evaluation period. Used to calculate quality acceptance rate.',
    `rejection_rate_percent` DECIMAL(18,2) COMMENT 'The percentage of goods receipts rejected due to quality defects or non-conformance during the evaluation period.',
    `responsiveness_rating` STRING COMMENT 'Qualitative rating of the vendors responsiveness to inquiries, requests, and communications during the evaluation period.. Valid values are `excellent|good|satisfactory|poor|unacceptable`',
    `responsiveness_score` DECIMAL(18,2) COMMENT 'Qualitative score (0-100) assessing the vendors responsiveness to inquiries, issue resolution, and communication timeliness. Evaluated by procurement and operational teams.',
    `risk_level` STRING COMMENT 'The supply risk level assigned to the vendor based on performance evaluation results, used for supply risk management and mitigation planning.. Valid values are `low|medium|high|critical`',
    `service_performance_score` DECIMAL(18,2) COMMENT 'The score measuring the vendors service quality, including responsiveness and issue resolution capabilities.',
    `total_goods_receipt_count` STRING COMMENT 'Total number of goods receipts processed for the vendor during the evaluation period. Used to calculate delivery and quality metrics.',
    `total_po_count` STRING COMMENT 'The total number of purchase orders issued to the vendor during the evaluation period that were included in this performance assessment.',
    `total_po_line_count` STRING COMMENT 'The total number of purchase order line items issued to the vendor during the evaluation period.',
    `total_procurement_value` DECIMAL(18,2) COMMENT 'Total monetary value of all procurement transactions with the vendor during the evaluation period. Represents the vendors business volume.',
    `total_purchase_order_count` STRING COMMENT 'Total number of purchase orders issued to the vendor during the evaluation period. Provides context for performance metrics.',
    `total_rejection_count` STRING COMMENT 'The total number of goods receipts rejected due to quality defects or non-conformance during the evaluation period.',
    CONSTRAINT pk_procurement_vendor_performance PRIMARY KEY(`procurement_vendor_performance_id`)
) COMMENT 'Tracks and records periodic vendor performance evaluations against key supply metrics for vendors delivering to mining operations. Captures evaluation period, vendor, overall score, delivery score (on-time delivery rate, order fill rate), quality score (rejection rate, NCR count), price score (price variance to contract), service score (responsiveness, issue resolution time), number of POs evaluated, number of rejections, and evaluator. Sourced from SAP S/4HANA MM Vendor Evaluation (ME61). Distinct from procurement domains strategic supplier evaluation — this product focuses on operational delivery performance metrics measured against actual goods receipts and PO fulfilment. Supports vendor rationalisation, preferred supplier decisions, and supply risk management.';

CREATE OR REPLACE TABLE `mining_ecm`.`procurement`.`requisition` (
    `requisition_id` BIGINT COMMENT 'Unique identifier for the purchase requisition record. Primary key.',
    `commodity_id` BIGINT COMMENT 'Foreign key linking to product.commodity. Business justification: Mining requisitions are raised for specific commodities (grinding media, reagents, fuel). Linking requisition to commodity enables commodity-level demand planning, budget tracking, and MRP-driven proc',
    `contract_id` BIGINT COMMENT 'Foreign key linking to procurement.contract. Business justification: Requisition may reference a framework contract for pricing and terms. Converting STRING contract_number to FK enables proper contract governance and pricing lookup. N:1 relationship (many requisitions',
    `cost_centre_id` BIGINT COMMENT 'Foreign key linking to finance.cost_centre. Business justification: Requisitions originate from cost centres for budget control, approval workflow, and commitment tracking. Essential for procurement budget management in mining.',
    `framework_agreement_id` BIGINT COMMENT 'Foreign key linking to procurement.framework_agreement. Business justification: In mining procurement, requisitions are often sourced against framework agreements (blanket orders/schedule agreements). Adding framework_agreement_id to requisition enables source determination — ide',
    `general_ledger_account_id` BIGINT COMMENT 'Foreign key linking to finance.general_ledger_account. Business justification: Requisitions specify GL account for budget checking, commitment tracking, and cost element classification. Required for financial control and reporting.',
    `price_schedule_id` BIGINT COMMENT 'Foreign key linking to procurement.price_schedule. Business justification: Purchase requisitions in mining operations are often raised against pre-negotiated price schedules (contracted rates for consumables, reagents, spare parts). Linking requisition to price_schedule enab',
    `material_master_id` BIGINT COMMENT 'Foreign key reference to the material master record for stock materials. Null for service requisitions or non-stock materials.',
    `vendor_id` BIGINT COMMENT 'Foreign key reference to the preferred or assigned vendor for this requisition. Populated when a source of supply is pre-determined or suggested by the requisitioner.',
    `warehouse_location_id` BIGINT COMMENT 'Foreign key linking to procurement.warehouse_location. Business justification: Requisitions specify where materials should be delivered or stored. Currently storage_location is stored as a string code. Adding warehouse_location_id normalizes this to the warehouse_location master',
    `wbs_element_id` BIGINT COMMENT 'Foreign key linking to finance.wbs_element. Business justification: Capital requisitions link to WBS for project budget control, approval workflow, and commitment reporting. Critical for capital project procurement management.',
    `account_assignment_category` STRING COMMENT 'Classification of how the requisition expenditure is assigned for financial accounting purposes. Determines whether costs are tracked against cost centres, capital projects, assets, or sales orders.. Valid values are `cost_centre|internal_order|project|asset|sales_order`',
    `approval_date` DATE COMMENT 'Date when the requisition received final approval and became eligible for conversion to purchase order. Null if still pending approval or rejected.',
    `approval_workflow_status` STRING COMMENT 'Current stage in the multi-level approval workflow. Requisitions above certain value thresholds require manager, department head, and executive approvals.. Valid values are `not_submitted|pending_level_1|pending_level_2|pending_level_3|approved|rejected`',
    `approver_name` STRING COMMENT 'Full name of the current or final approver in the approval chain. Identifies the person responsible for authorizing the procurement expenditure.',
    `asset_number` STRING COMMENT 'Twelve-digit fixed asset number when the requisition is for asset procurement or asset-related maintenance. Used for asset lifecycle tracking and depreciation.. Valid values are `^[0-9]{12}$`',
    `conversion_status` STRING COMMENT 'Status indicating whether the requisition has been converted to a purchase order. Tracks the progression from demand signal to formal procurement commitment.. Valid values are `not_converted|partially_converted|fully_converted`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the requisition record was first created in the system. Audit field for data lineage and compliance reporting.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the estimated value. Typically AUD for Australian mining operations, USD for international procurement.. Valid values are `^[A-Z]{3}$`',
    `deletion_indicator` BOOLEAN COMMENT 'Boolean flag indicating the requisition line has been marked for deletion. Soft delete mechanism preserving audit trail while excluding from active procurement workflows.',
    `estimated_value` DECIMAL(18,2) COMMENT 'Estimated total value of the requisition line in the requisition currency. Used for budgeting and approval threshold determination.',
    `internal_order_number` STRING COMMENT 'Twelve-digit internal order number for tracking costs against specific operational activities or maintenance campaigns. Used when account assignment category is internal order.. Valid values are `^[0-9]{12}$`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the requisition record. Tracks changes throughout the requisition lifecycle for audit and compliance purposes.',
    `line_number` STRING COMMENT 'Sequential line item number within the requisition. Identifies individual material or service requests within a single requisition document.',
    `material_group` STRING COMMENT 'Nine-character hierarchical code classifying the material or service category. Used for spend analysis, supplier segmentation, and procurement strategy.. Valid values are `^[A-Z0-9]{9}$`',
    `mrp_controller` STRING COMMENT 'Three-character code identifying the MRP (Material Requirements Planning) controller responsible for material planning. Relevant for requisitions generated automatically by MRP run.. Valid values are `^[A-Z0-9]{3}$`',
    `plant_code` STRING COMMENT 'Four-character code identifying the mine site, processing plant, or facility where the material or service is required. Represents the receiving location.. Valid values are `^[A-Z0-9]{4}$`',
    `priority_indicator` STRING COMMENT 'Priority level assigned to the requisition. Urgent requisitions are expedited for critical operational needs such as equipment breakdowns or safety-critical items.. Valid values are `urgent|high|normal|low`',
    `purchasing_group` STRING COMMENT 'Three-character code identifying the procurement team responsible for sourcing this requisition. Examples include mining equipment, consumables, services, or contracts teams.. Valid values are `^[A-Z0-9]{3}$`',
    `quantity` DECIMAL(18,2) COMMENT 'Quantity of material or service units being requested. Precision supports fractional quantities for materials measured in decimal units.',
    `rejection_reason` STRING COMMENT 'Free-text explanation provided by the approver when a requisition is rejected. Captures business justification for denial such as budget constraints, alternative sourcing, or specification issues.',
    `required_delivery_date` DATE COMMENT 'Date by which the requested material or service must be delivered to the requesting location. Drives procurement planning and supplier selection.',
    `requisition_date` DATE COMMENT 'Date when the purchase requisition was created in the system. Represents the formal initiation of the procurement demand signal.',
    `requisition_number` STRING COMMENT 'Business identifier for the purchase requisition as displayed in SAP S/4HANA MM. Ten-digit numeric code used for tracking and reference across procurement workflows.. Valid values are `^[0-9]{10}$`',
    `requisition_status` STRING COMMENT 'Current lifecycle status of the requisition in the approval and conversion workflow. Tracks progression from creation through approval to purchase order conversion. [ENUM-REF-CANDIDATE: draft|pending_approval|approved|rejected|partially_converted|fully_converted|cancelled — 7 candidates stripped; promote to reference product]',
    `requisition_type` STRING COMMENT 'Classification of the requisition based on procurement scenario: standard purchase, stock transfer between plants, subcontracting with vendor, consignment arrangement, or service procurement.. Valid values are `standard|stock_transfer|subcontracting|consignment|service`',
    `requisitioner_email` STRING COMMENT 'Email address of the requisitioner for communication regarding the requisition status, approvals, and delivery notifications.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `short_text` STRING COMMENT 'Brief description of the material or service being requisitioned. Used when material master does not exist or for additional context.',
    `source_determination_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether automatic source determination should be performed to identify preferred vendors or contracts. True triggers sourcing logic in procurement workflow.',
    `unit_of_measure` STRING COMMENT 'Unit in which the requisitioned quantity is expressed. ISO standard unit codes such as EA (each), KG (kilogram), L (liter), M (meter), TON (tonne).. Valid values are `^[A-Z]{2,3}$`',
    CONSTRAINT pk_requisition PRIMARY KEY(`requisition_id`)
) COMMENT 'Internal purchase requisition raised by mine site departments or generated automatically by MRP run, requesting procurement of materials or services. Sourced from SAP S/4HANA MM (EBAN). Captures requisition number, requesting cost centre, plant, material or service description, quantity, required delivery date, estimated value, priority (urgent/normal), approval workflow status, approver chain, and conversion status to purchase order. Serves as the SSOT for procurement demand signals. Initiates the formal procurement workflow and provides input to supply planning and material plan execution.';

CREATE OR REPLACE TABLE `mining_ecm`.`procurement`.`framework_agreement` (
    `framework_agreement_id` BIGINT COMMENT 'Primary key for framework_agreement',
    `commodity_id` BIGINT COMMENT 'Foreign key linking to product.commodity. Business justification: Framework agreements in mining are established per commodity (explosives, reagents, fuel). A FK to commodity replaces the denormalized commodity_category text field and enables commodity-level contrac',
    `cost_centre_id` BIGINT COMMENT 'Foreign key linking to finance.cost_centre. Business justification: Contracts often tied to specific cost centres for budget allocation, spend tracking, and contract performance monitoring. Common in site-specific mining contracts.',
    `vendor_id` BIGINT COMMENT 'Reference to the vendor or supplier party with whom this framework agreement is established.',
    `approval_date` DATE COMMENT 'Date on which the framework agreement was formally approved by the authorized signatory or procurement governance board.',
    `base_price` DECIMAL(18,2) COMMENT 'Standard unit price agreed in the framework agreement for fixed-price contracts, or baseline price for variable pricing mechanisms. Expressed per unit of measure.',
    `company_code` STRING COMMENT 'Legal entity or company code on behalf of which this framework agreement is established. Relevant for multi-entity mining groups.',
    `contract_number` STRING COMMENT 'Externally-known business identifier for the framework agreement, typically a 10-character alphanumeric code assigned by the procurement system.. Valid values are `^[A-Z0-9]{10}$`',
    `contract_status` STRING COMMENT 'Current lifecycle status of the framework agreement. Draft indicates under negotiation, active means in force, suspended means temporarily halted, expired means validity period ended, terminated means cancelled before expiry, closed means completed and archived.. Valid values are `draft|active|suspended|expired|terminated|closed`',
    `contract_type` STRING COMMENT 'Classification of the framework agreement type. Quantity contracts specify total quantity, value contracts specify total spend, scheduling agreements define delivery schedules, blanket orders allow multiple releases, master agreements set terms for multiple sites, and call-off contracts enable on-demand ordering.. Valid values are `quantity_contract|value_contract|scheduling_agreement|blanket_order|master_agreement|call_off_contract`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this framework agreement record was first created in the procurement system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code in which the contract value and pricing are denominated (e.g., USD, AUD, CAD, ZAR).. Valid values are `^[A-Z]{3}$`',
    `delivery_lead_time_days` STRING COMMENT 'Standard number of calendar days from order placement to expected delivery at the designated location, as agreed in the framework agreement.',
    `end_date` DATE COMMENT 'Effective end date after which the framework agreement expires and no further orders can be placed unless renewed. Nullable for open-ended agreements.',
    `incoterms_code` STRING COMMENT 'International Commercial Terms code defining the allocation of costs, risks, and responsibilities between buyer and seller for delivery under this framework agreement. [ENUM-REF-CANDIDATE: EXW|FCA|CPT|CIP|DAP|DPU|DDP|FAS|FOB|CFR|CIF — 11 candidates stripped; promote to reference product]',
    `incoterms_location` STRING COMMENT 'Named place or port specified in the Incoterms clause, such as the delivery destination, port of loading, or place of transfer of risk.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this framework agreement record was last updated in the procurement system.',
    `last_review_date` DATE COMMENT 'Date of the most recent formal performance review conducted for this framework agreement.',
    `maximum_order_quantity` DECIMAL(18,2) COMMENT 'Maximum quantity that can be ordered in a single release or call-off against this framework agreement. Nullable if no upper limit per order.',
    `minimum_order_quantity` DECIMAL(18,2) COMMENT 'Minimum quantity that must be ordered in each release or call-off against this framework agreement. Enforces vendor minimum batch or economic order size.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next formal performance review of this framework agreement.',
    `payment_terms_code` STRING COMMENT 'Standard payment terms code defining the due date calculation and discount conditions for invoices under this framework agreement (e.g., Net 30, 2/10 Net 30).',
    `performance_review_frequency` STRING COMMENT 'Scheduled frequency at which vendor performance under this framework agreement is formally reviewed and documented.. Valid values are `monthly|quarterly|semi_annually|annually`',
    `plant_code` STRING COMMENT 'Primary mine site, processing plant, or operational facility for which this framework agreement is intended. Nullable for corporate-wide agreements.',
    `price_unit` STRING COMMENT 'Quantity of units to which the base price applies. For example, if base_price is 100 USD per 10 units, price_unit is 10.',
    `pricing_condition_type` STRING COMMENT 'Mechanism by which pricing is determined under this framework agreement. Fixed price remains constant, variable price adjusts per order, cost-plus adds margin to vendor cost, index-linked ties to commodity index, market-based uses spot rates, tiered pricing varies by volume.. Valid values are `fixed_price|variable_price|cost_plus|index_linked|market_based|tiered_pricing`',
    `purchasing_group` STRING COMMENT 'Buyer or procurement team responsible for day-to-day administration and call-offs against this framework agreement.',
    `purchasing_organization` STRING COMMENT 'Organizational unit responsible for negotiating and managing this framework agreement. Typically a centralized procurement function or regional procurement office.',
    `renewal_indicator` BOOLEAN COMMENT 'Flag indicating whether this framework agreement is eligible for automatic renewal upon expiry. True if renewal clause exists, false otherwise.',
    `renewal_notice_period_days` STRING COMMENT 'Number of days prior to contract end date by which either party must provide notice if they do not wish to renew. Nullable if no renewal clause.',
    `start_date` DATE COMMENT 'Effective start date from which the framework agreement becomes binding and orders can be placed against it.',
    `termination_date` DATE COMMENT 'Actual date on which the framework agreement was terminated early, if applicable. Nullable if contract ran to natural expiry or is still active.',
    `termination_notice_period_days` STRING COMMENT 'Number of days advance notice required by either party to terminate the framework agreement before its natural expiry date.',
    `termination_reason` STRING COMMENT 'Free-text explanation of why the framework agreement was terminated early, such as vendor performance issues, business requirement changes, or mutual agreement.',
    `total_contract_quantity` DECIMAL(18,2) COMMENT 'Maximum quantity of goods or services committed under this framework agreement for quantity contracts. Nullable for value contracts or service agreements without fixed quantities.',
    `total_contract_value` DECIMAL(18,2) COMMENT 'Maximum monetary value committed under this framework agreement for value contracts, or estimated total spend for quantity contracts. Represents the financial ceiling or budget allocation.',
    `unit_of_measure` STRING COMMENT 'Base unit of measure for the contracted quantity, such as tonnes (MT), litres (L), kilograms (KG), units (EA), or hours (HR). Aligns with material master UOM.',
    CONSTRAINT pk_framework_agreement PRIMARY KEY(`framework_agreement_id`)
) COMMENT 'Long-term supply agreements and framework contracts with vendors for the ongoing provision of operational inputs such as explosives, reagents, fuel, and tyres. Sourced from SAP S/4HANA MM Outline Agreement (EKKO type MK/WK). Captures contract number, vendor, contract type (quantity/value contract, scheduling agreement), commodity category, start date, end date, total contract value, currency, pricing conditions, minimum order quantity, and contract status. Distinct from the procurement domains contract lifecycle management.';

CREATE OR REPLACE TABLE `mining_ecm`.`procurement`.`freight_order` (
    `freight_order_id` BIGINT COMMENT 'Unique identifier for the freight order. Primary key for the freight order entity.',
    `contract_id` BIGINT COMMENT 'Foreign key linking to procurement.contract. Business justification: Freight orders for outbound mineral shipments are executed under long-term freight contracts or offtake agreements. Linking freight_order to contract enables contract utilization tracking, freight rat',
    `counterparty_id` BIGINT COMMENT 'Reference to the customer receiving goods for outbound freight movements. Null for inbound and inter-site movements.',
    `delivery_destination_id` BIGINT COMMENT 'Foreign key linking to customer.delivery_destination. Business justification: Freight orders in mining transport ore to customer discharge ports. Linking to delivery_destination enables berth/draft constraint validation, operating hours scheduling, and customs clearance status ',
    `warehouse_location_id` BIGINT COMMENT 'Foreign key linking to procurement.warehouse_location. Business justification: Freight orders have origin locations that should reference warehouse_location master. Currently freight_order has origin_location_code and origin_location_name as denormalized strings. Creating this F',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to procurement.purchase_order. Business justification: Freight orders in mining procurement are frequently created to execute the logistics of a specific purchase order — particularly for bulk material deliveries (explosives, reagents, fuel, equipment). L',
    `saleable_product_id` BIGINT COMMENT 'Foreign key linking to product.saleable_product. Business justification: Freight orders transport specific saleable products requiring product-specific handling, packaging, and hazmat classification. Essential for logistics planning, freight cost allocation by product, and',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to procurement.material_master. Business justification: Freight orders carry specific materials (mineral concentrate, reagents, equipment, consumables). Linking freight_order to material_master via supply_material_master_id enables material-level freight c',
    `vendor_id` BIGINT COMMENT 'Reference to the vendor dispatching goods for inbound freight movements. Null for outbound and inter-site movements.',
    `vessel_id` BIGINT COMMENT 'Foreign key linking to sales.vessel. Business justification: Freight orders in mining are executed by specific vessels requiring vetting approval, deadweight verification, and charter rate tracking. Linking freight_order to vessel enables vessel vetting complia',
    `actual_arrival_timestamp` TIMESTAMP COMMENT 'Actual date and time when the freight arrived at the destination location.',
    `actual_departure_timestamp` TIMESTAMP COMMENT 'Actual date and time when the freight departed from the origin location.',
    `cargo_description` STRING COMMENT 'Detailed textual description of the cargo being transported, including packaging and handling requirements.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the freight order record was first created in the system.',
    `customs_clearance_date` DATE COMMENT 'Date when customs clearance was completed for international freight. Null if not applicable or not yet cleared.',
    `customs_clearance_status` STRING COMMENT 'Status of customs clearance for international freight movements: not-required, pending, cleared, held, or rejected.. Valid values are `not-required|pending|cleared|held|rejected`',
    `dangerous_goods_class` STRING COMMENT 'UN dangerous goods classification code (e.g., 1.1, 3, 8) if cargo contains hazardous materials. Null if not dangerous goods.. Valid values are `^[1-9](.[1-6])?$`',
    `dangerous_goods_flag` BOOLEAN COMMENT 'Indicates whether the cargo contains dangerous goods requiring special handling and regulatory compliance.',
    `dangerous_goods_un_number` STRING COMMENT 'Four-digit UN number identifying the dangerous goods substance (e.g., UN1203 for gasoline). Null if not dangerous goods.. Valid values are `^UN[0-9]{4}$`',
    `delivery_note_reference` STRING COMMENT 'Reference number of the delivery note or goods receipt document associated with this freight order.',
    `direction` STRING COMMENT 'Direction of freight movement: inbound (vendor to site), outbound (site to customer), or inter-site (between mining sites).. Valid values are `inbound|outbound|inter-site`',
    `expected_arrival_date` DATE COMMENT 'Planned or scheduled date when the freight is expected to arrive at the destination location.',
    `expected_departure_date` DATE COMMENT 'Planned or scheduled date when the freight is expected to depart from the origin location.',
    `freight_cost_amount` DECIMAL(18,2) COMMENT 'Total freight cost for this shipment in the specified currency.',
    `freight_cost_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the freight cost amount (e.g., USD, AUD, EUR).. Valid values are `^[A-Z]{3}$`',
    `freight_order_number` STRING COMMENT 'Business-facing unique freight order number used for tracking and reference across logistics operations.. Valid values are `^FO-[0-9]{8}$`',
    `freight_rate_per_tonne` DECIMAL(18,2) COMMENT 'Freight rate charged per metric tonne of cargo. Applicable primarily to bulk commodity shipments.',
    `freight_status` STRING COMMENT 'Current lifecycle status of the freight order: planned, booked, in-transit, arrived, delivered, or cancelled.. Valid values are `planned|booked|in-transit|arrived|delivered|cancelled`',
    `gross_weight_tonnes` DECIMAL(18,2) COMMENT 'Total gross weight of the cargo including packaging and containers, measured in metric tonnes.',
    `incoterms_code` STRING COMMENT 'International Commercial Terms (Incoterms) code defining the responsibilities of buyer and seller for freight costs and risk transfer (e.g., FOB, CIF). [ENUM-REF-CANDIDATE: EXW|FCA|CPT|CIP|DAP|DPU|DDP|FAS|FOB|CFR|CIF — 11 candidates stripped; promote to reference product]',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when the freight order record was last updated in the system.',
    `laycan_end_date` DATE COMMENT 'End date of the laycan period (latest date vessel can arrive for loading) for sea freight. Null for non-sea transport.',
    `laycan_start_date` DATE COMMENT 'Start date of the laycan period (earliest date vessel can arrive for loading) for sea freight. Null for non-sea transport.',
    `loaded_quantity_tonnes` DECIMAL(18,2) COMMENT 'Actual quantity of commodity loaded onto the vessel, measured in metric tonnes. Applicable to sea freight.',
    `net_weight_tonnes` DECIMAL(18,2) COMMENT 'Net weight of the cargo excluding packaging and containers, measured in metric tonnes.',
    `nominated_quantity_tonnes` DECIMAL(18,2) COMMENT 'Quantity of commodity nominated or planned for loading onto the vessel, measured in metric tonnes. Applicable to sea freight.',
    `tracking_reference` STRING COMMENT 'Carrier-provided tracking reference number for real-time shipment visibility and status updates.',
    `transport_mode` STRING COMMENT 'Primary mode of transportation for this freight movement: road, rail, sea, air, pipeline, or multimodal.. Valid values are `road|rail|sea|air|pipeline|multimodal`',
    `volume_cubic_metres` DECIMAL(18,2) COMMENT 'Total volume of the cargo measured in cubic metres.',
    `voyage_number` STRING COMMENT 'Voyage or sailing number for sea freight movements. Null for non-sea transport modes.',
    CONSTRAINT pk_freight_order PRIMARY KEY(`freight_order_id`)
) COMMENT 'Unified logistics execution entity managing all freight movements across the mining supply chain — inbound material deliveries from vendors (road/rail/sea), outbound commodity shipments to customers (road/rail/sea), and inter-site transfers. Captures freight order number, direction (inbound/outbound/inter-site), transport mode (road/rail/sea), carrier, vendor (for inbound), customer (for outbound), origin location, destination plant/port, cargo description, commodity product, gross weight/tonnage, volume, dangerous goods flag, freight cost, expected/actual departure and arrival dates, customs clearance status, delivery note reference, tracking reference, and freight status. For sea freight: vessel name, voyage number, bill of lading number, laycan dates, nominated/loaded quantity, loaded quantity, Incoterms (FOB/CIF), freight rate, and shipment status. For inbound: vendor dispatch tracking, carrier ETA, and dangerous goods declaration reference. Serves as the SSOT for end-to-end transport visibility across all logistics legs and directions — no other product in this domain records freight or shipment movements.';

CREATE OR REPLACE TABLE `mining_ecm`.`procurement`.`physical_inventory` (
    `physical_inventory_id` BIGINT COMMENT 'Unique identifier for the physical inventory count document. Primary key for the physical inventory record.',
    `cost_centre_id` BIGINT COMMENT 'Foreign key linking to finance.cost_centre. Business justification: Inventory variance posting requires cost centre for write-off/adjustment allocation and budget impact tracking. Essential for inventory accounting and cost control.',
    `general_ledger_account_id` BIGINT COMMENT 'Foreign key linking to finance.general_ledger_account. Business justification: Inventory adjustments post to GL for financial reporting, variance analysis, and audit trail. Required for accurate financial statements and inventory valuation.',
    `inventory_balance_id` BIGINT COMMENT 'Foreign key linking to procurement.inventory_balance. Business justification: Physical inventory counts are conducted to verify and reconcile the inventory_balance records. Adding inventory_balance_id to physical_inventory creates a direct link between the count document and th',
    `journal_entry_id` BIGINT COMMENT 'Foreign key linking to finance.journal_entry. Business justification: Physical inventory variance postings in mining generate journal entries for stock write-up or write-down. Linking the physical inventory document to its accounting posting supports inventory valuation',
    `material_master_id` BIGINT COMMENT 'Foreign key reference to the material being counted in the physical inventory.',
    `warehouse_location_id` BIGINT COMMENT 'Foreign key linking to procurement.warehouse_location. Business justification: Physical inventory counts are conducted at specific warehouse locations. The physical_inventory table has storage_location_code (STRING) but no FK to warehouse_location. Adding storage_location_id FK ',
    `approval_date` DATE COMMENT 'The date on which the physical inventory variance was approved for posting.',
    `approval_required_indicator` BOOLEAN COMMENT 'Flag indicating whether the variance requires management or supervisor approval before posting.',
    `approved_by_user` STRING COMMENT 'The user ID of the person who approved the physical inventory variance for posting.. Valid values are `^[A-Z0-9]{1,12}$`',
    `batch_number` STRING COMMENT 'The batch or lot number of the material counted, if batch management is active for the material.. Valid values are `^[A-Z0-9]{1,10}$`',
    `book_quantity` DECIMAL(18,2) COMMENT 'The system-recorded inventory quantity (book inventory) at the time of the physical count.',
    `count_date` DATE COMMENT 'The date on which the physical inventory count was conducted at the storage location.',
    `count_status` STRING COMMENT 'The current status of the physical inventory count document in its lifecycle.. Valid values are `created|counted|recounted|posted|cancelled`',
    `count_type` STRING COMMENT 'The type of physical inventory count performed: scheduled periodic count, ad-hoc count, cycle count, annual stocktake, or spot check.. Valid values are `scheduled|ad_hoc|cycle_count|annual|spot_check`',
    `counted_quantity` DECIMAL(18,2) COMMENT 'The actual physical quantity counted during the inventory count process.',
    `counter_name` STRING COMMENT 'The name of the person or team who performed the physical count.',
    `created_by_user` STRING COMMENT 'The user ID of the person who created the physical inventory count document in the system.. Valid values are `^[A-Z0-9]{1,12}$`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when the physical inventory count document was created in the system.',
    `currency_code` STRING COMMENT 'The three-letter ISO 4217 currency code for the variance value (e.g., USD, AUD, CAD).. Valid values are `^[A-Z]{3}$`',
    `document_number` STRING COMMENT 'The unique document number assigned to the physical inventory count in the source system (SAP MI01/MI07).. Valid values are `^[0-9]{10}$`',
    `fiscal_year` STRING COMMENT 'The fiscal year in which the physical inventory count was conducted.',
    `freeze_book_inventory_indicator` BOOLEAN COMMENT 'Flag indicating whether the book inventory was frozen at the time of count to prevent movements during counting.',
    `last_modified_by_user` STRING COMMENT 'The user ID of the person who last modified the physical inventory count document.. Valid values are `^[A-Z0-9]{1,12}$`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when the physical inventory count document was last modified.',
    `material_description` STRING COMMENT 'The descriptive name of the material being counted.',
    `material_document_number` STRING COMMENT 'The material document number generated when the physical inventory variance is posted to update stock levels.. Valid values are `^[0-9]{10}$`',
    `plant_code` STRING COMMENT 'The mine site or plant code where the physical inventory count was performed.. Valid values are `^[A-Z0-9]{4}$`',
    `posting_date` DATE COMMENT 'The date on which the inventory variance was posted to the financial and stock accounts.',
    `posting_status` STRING COMMENT 'Indicates whether the inventory variance has been posted to the general ledger and stock accounts.. Valid values are `not_posted|posted|posting_error`',
    `reason_code` STRING COMMENT 'The code indicating the reason for the inventory variance (e.g., theft, damage, counting error, system error).. Valid values are `^[A-Z0-9]{1,4}$`',
    `reason_description` STRING COMMENT 'Detailed description or notes explaining the reason for the inventory variance.',
    `recount_date` DATE COMMENT 'The date on which the recount was performed, if applicable.',
    `recount_indicator` BOOLEAN COMMENT 'Flag indicating whether a recount was required or performed due to significant variance or discrepancy.',
    `special_stock_indicator` STRING COMMENT 'Indicator for special stock types such as consignment stock, project stock, or vendor-owned inventory.. Valid values are `^[A-Z]{1}$`',
    `tolerance_exceeded_indicator` BOOLEAN COMMENT 'Flag indicating whether the variance exceeded the configured tolerance threshold requiring management approval.',
    `unit_of_measure` STRING COMMENT 'The unit of measure in which the material quantity is expressed (e.g., EA, KG, MT, L).. Valid values are `^[A-Z]{2,3}$`',
    `variance_quantity` DECIMAL(18,2) COMMENT 'The difference between the book quantity and the counted quantity (counted minus book).',
    `variance_value` DECIMAL(18,2) COMMENT 'The monetary value of the inventory variance, calculated as variance quantity multiplied by material valuation price.',
    CONSTRAINT pk_physical_inventory PRIMARY KEY(`physical_inventory_id`)
) COMMENT 'Records scheduled and ad-hoc physical stock counts conducted at mine site warehouses and storage locations to reconcile system inventory balances against actual on-hand quantities. Sourced from SAP S/4HANA MM Physical Inventory (MI01/MI07). Captures count document number, plant, storage location, count date, material, system quantity, counted quantity, variance quantity, variance value, recount flag, and posting status.';

CREATE OR REPLACE TABLE `mining_ecm`.`procurement`.`contract` (
    `contract_id` BIGINT COMMENT 'Unique identifier for the procurement contract record. Primary key.',
    `commodity_id` BIGINT COMMENT 'Foreign key linking to product.commodity. Business justification: Mining procurement contracts are commodity-specific (e.g., sodium cyanide, diesel, copper concentrate). A proper FK to commodity replaces the denormalized commodity_category text field and enables com',
    `framework_agreement_id` BIGINT COMMENT 'Foreign key linking to procurement.framework_agreement. Business justification: In mining procurement, a procurement contract is often derived from or operates under a framework agreement. The framework_agreement establishes the commercial umbrella terms, while procurement_contra',
    `price_index_id` BIGINT COMMENT 'Foreign key linking to sales.price_index. Business justification: Mining procurement contracts for fuel, explosives, and reagents routinely include price escalation clauses tied to commodity price indices. Linking procurement_contract to price_index enables automate',
    `pricing_basis_id` BIGINT COMMENT 'Foreign key linking to product.pricing_basis. Business justification: Mining procurement contracts for commodity purchase (copper concentrate, iron ore) reference a pricing basis defining index-linkage, provisional pricing percentage, and quotational period. A FK to pri',
    `specification_id` BIGINT COMMENT 'Foreign key linking to product.specification. Business justification: Mining procurement contracts for ore purchase or material supply contractually reference a product specification defining quality parameters, penalty/bonus thresholds, and rejection limits. This is a ',
    `vendor_id` BIGINT COMMENT 'Reference to the vendor party with whom the contract is established.',
    `amendment_count` STRING COMMENT 'Total number of formal amendments executed against this contract since inception. Used for audit trail and change tracking.',
    `approval_date` DATE COMMENT 'Date when the contract received final authorization from the appropriate approval authority.',
    `approved_by_name` STRING COMMENT 'Full name of the executive or manager who provided final approval for the contract.',
    `base_price` DECIMAL(18,2) COMMENT 'Initial unit price established at contract inception, before any escalation or de-escalation adjustments.',
    `company_code` STRING COMMENT 'Legal entity code under which the contract is executed for financial reporting and tax purposes.',
    `contract_number` STRING COMMENT 'Externally-known unique contract identifier used across procurement systems and vendor communications.. Valid values are `^[A-Z0-9]{8,20}$`',
    `contract_status` STRING COMMENT 'Current lifecycle state of the contract: draft (being prepared), pending_approval (awaiting authorization), approved (authorized but not yet effective), active (in force), suspended (temporarily halted), expired (end date reached), terminated (ended early), closed (completed and archived). [ENUM-REF-CANDIDATE: draft|pending_approval|approved|active|suspended|expired|terminated|closed — 8 candidates stripped; promote to reference product]',
    `contract_type` STRING COMMENT 'Classification of the contract structure: blanket order (quantity-based), outline agreement (value-based), schedule agreement (delivery schedule), service contract (time and materials), framework agreement (multi-year umbrella), or call-off contract (release-based).. Valid values are `blanket_order|outline_agreement|schedule_agreement|service_contract|framework_agreement|call_off_contract`',
    `contracted_quantity` DECIMAL(18,2) COMMENT 'Total quantity of goods or service units committed under the contract. Nullable for value-based contracts without quantity commitments.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when the contract record was first created in the procurement system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary values in the contract (e.g., USD, AUD, CAD).. Valid values are `^[A-Z]{3}$`',
    `delivery_lead_time_days` STRING COMMENT 'Standard number of calendar days from purchase order placement to expected goods receipt at the mine site or designated location.',
    `end_date` DATE COMMENT 'Date when the contract expires or is scheduled to terminate. Nullable for open-ended contracts.',
    `incoterms_code` STRING COMMENT 'Three-letter International Commercial Terms code defining delivery responsibilities and risk transfer (e.g., FOB, CIF, EXW, DDP).. Valid values are `^[A-Z]{3}$`',
    `incoterms_location` STRING COMMENT 'Named place or port specified in the Incoterms clause where risk and cost transfer occurs.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'System timestamp when the contract record was last updated in the procurement system.',
    `last_review_date` DATE COMMENT 'Date when the contract was last formally reviewed for performance, pricing, and compliance.',
    `latest_amendment_date` DATE COMMENT 'Date when the most recent contract amendment was executed. Nullable if no amendments have been executed.',
    `latest_amendment_description` STRING COMMENT 'Summary of changes made in the most recent amendment (e.g., price adjustment, scope extension, volume change, term extension).',
    `latest_amendment_number` STRING COMMENT 'Identifier of the most recent contract amendment. Nullable if no amendments have been executed.',
    `maximum_order_quantity` DECIMAL(18,2) COMMENT 'Largest quantity that can be ordered under the contract in a single purchase order release. Nullable if no upper limit applies.',
    `minimum_order_quantity` DECIMAL(18,2) COMMENT 'Smallest quantity that can be ordered under the contract in a single purchase order release.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next formal contract review.',
    `owner_email` STRING COMMENT 'Email address of the contract owner for escalations and contract-related communications.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `owner_name` STRING COMMENT 'Full name of the procurement professional or contract manager responsible for this contract.',
    `payment_terms_code` STRING COMMENT 'Standard payment terms identifier defining due date calculation and discount conditions (e.g., NET30, 2/10NET30).',
    `performance_kpi_description` STRING COMMENT 'Narrative description of the performance metrics and service level agreements the vendor must meet under the contract (e.g., on-time delivery rate, quality acceptance rate, response time).',
    `plant_code` STRING COMMENT 'Mine site or processing facility code to which the contract applies. Nullable for enterprise-wide contracts.',
    `price_effective_date` DATE COMMENT 'Date from which the current pricing schedule becomes applicable.',
    `price_escalation_clause` STRING COMMENT 'Contractual terms governing automatic price increases based on index movements, cost changes, or time-based triggers.',
    `price_expiry_date` DATE COMMENT 'Date when the current pricing schedule ceases to be valid. Nullable for indefinite pricing.',
    `price_review_frequency` STRING COMMENT 'Scheduled interval for formal price review and renegotiation as stipulated in the contract.. Valid values are `monthly|quarterly|semi_annually|annually|biannually|ad_hoc`',
    `price_unit` STRING COMMENT 'Quantity denominator for the base price (e.g., price per 1 unit, per 100 units, per 1000 units).',
    `purchasing_group` STRING COMMENT 'Buyer or procurement team code responsible for day-to-day contract administration and purchase order releases.',
    `purchasing_organization` STRING COMMENT 'Organizational unit responsible for negotiating and managing the contract (e.g., corporate procurement, regional procurement, site-level procurement).',
    `renewal_indicator` BOOLEAN COMMENT 'Flag indicating whether the contract includes automatic renewal provisions (True) or requires explicit renegotiation (False).',
    `renewal_notice_period_days` STRING COMMENT 'Number of days before contract expiry that renewal or termination notice must be provided to the vendor.',
    `start_date` DATE COMMENT 'Date when the contract becomes effective and binding.',
    `termination_date` DATE COMMENT 'Actual date when the contract was terminated early. Nullable if contract was not terminated.',
    `termination_notice_period_days` STRING COMMENT 'Number of days advance notice required to terminate the contract before its natural expiry date.',
    `termination_reason` STRING COMMENT 'Business justification or cause for early contract termination (e.g., vendor non-performance, scope change, mine closure, cost reduction initiative).',
    `total_contract_value` DECIMAL(18,2) COMMENT 'Maximum monetary value committed under the contract over its full term. Used for budget tracking and contract compliance monitoring.',
    `unit_of_measure` STRING COMMENT 'Standard unit for contracted quantities (e.g., tonne, litre, each, hour, metre).',
    CONSTRAINT pk_contract PRIMARY KEY(`contract_id`)
) COMMENT 'Master procurement contract or framework agreement establishing commercial terms between the mining company and a vendor for the ongoing supply of goods or services. Captures contract number, contract type (blanket order, outline agreement, schedule agreement, service contract), vendor, commodity category, contracted volumes, and contract status. Includes full pricing schedule management: base price per line item, price basis (fixed, CPI-indexed, commodity-indexed), effective and expiry dates per price line, price escalation/de-escalation clauses, price review triggers, and applicable mine site or region. Includes complete amendment lifecycle: amendment number, amendment date, description of change (price adjustment, scope extension, volume change, term extension), commercial impact (value delta), approval authority, and amendment status (proposed, approved, executed). Also captures contract start and end dates, renewal options, performance KPIs, and termination conditions. Supports automated PO pricing via price condition linkage, price variance analysis, contract compliance monitoring, and full audit trail of commercial changes. Sourced from SAP S/4HANA MM contract management, pricing conditions, and change documents.';

CREATE OR REPLACE TABLE `mining_ecm`.`procurement`.`vendor_performance` (
    `vendor_performance_id` BIGINT COMMENT 'Primary key for vendor_performance',
    `contract_id` BIGINT COMMENT 'Foreign key linking to procurement.contract. Business justification: Vendor performance evaluations in mining procurement are frequently conducted in the context of specific contracts — particularly for long-term supply agreements where KPIs and performance obligations',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to procurement.purchase_order. Business justification: Vendor performance evaluations can be triggered by or associated with specific purchase orders — particularly for one-off or project-based procurement where performance is assessed at the PO level rat',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to procurement.vendor. Business justification: vendor_performance is a periodic vendor performance evaluation record. It is completely siloed with no existing FK links. The primary relationship is to the vendor being evaluated — vendor_id is the e',
    CONSTRAINT pk_vendor_performance PRIMARY KEY(`vendor_performance_id`)
) COMMENT 'Periodic vendor performance evaluation record assessing a suppliers delivery, quality, commercial, and HSE performance against contracted KPIs. Captures evaluation period, vendor, commodity category, on-time delivery rate, quality acceptance rate, invoice accuracy rate, HSE incident count, responsiveness score, overall performance rating, and corrective action requirements. Supports supplier relationship management, contract renewal decisions, and preferred supplier designation. Sourced from SAP S/4HANA MM vendor evaluation and IsoMetrix HSE data.';

CREATE OR REPLACE TABLE `mining_ecm`.`procurement`.`price_schedule` (
    `price_schedule_id` BIGINT COMMENT 'Unique identifier for the price schedule record. Primary key.',
    `commodity_id` BIGINT COMMENT 'Foreign key linking to product.commodity. Business justification: Price schedules in mining procurement are commodity-specific — pricing for iron ore fines, copper concentrate, or diesel is tracked per commodity to enable commodity price benchmarking, index-linked p',
    `contract_id` BIGINT COMMENT 'Reference to the parent procurement contract or framework agreement under which this price schedule is defined.',
    `framework_agreement_id` BIGINT COMMENT 'Foreign key linking to procurement.framework_agreement. Business justification: A price schedule in mining procurement is frequently established under a framework agreement (blanket/schedule agreement). Adding framework_agreement_id to price_schedule allows pricing schedules to b',
    `price_index_id` BIGINT COMMENT 'Foreign key linking to sales.price_index. Business justification: Procurement price schedules for fuel, reagents, and consumables in mining are indexed to commodity price indices for automated escalation calculations. Linking price_schedule to price_index enables pr',
    `material_master_id` BIGINT COMMENT 'Reference to the material master record for which this price schedule applies. Null if the schedule applies to a service.',
    `tertiary_price_material_master_id` BIGINT COMMENT 'FK to procurement.material_master',
    `vendor_id` BIGINT COMMENT 'Reference to the vendor or supplier providing the material or service under this price schedule.',
    `warehouse_location_id` BIGINT COMMENT 'Foreign key linking to procurement.warehouse_location. Business justification: Price schedules in mining procurement are often location-specific — different mine sites or plants may have different contracted rates for the same material (due to transport costs, local supplier agr',
    `approval_required_flag` BOOLEAN COMMENT 'Indicates whether purchase orders using this price schedule require additional approval beyond standard procurement authority limits.',
    `auto_po_creation_flag` BOOLEAN COMMENT 'Indicates whether this price schedule supports automated purchase order creation from materials requirements planning (MRP) or requisitions without manual intervention.',
    `base_price` DECIMAL(18,2) COMMENT 'The contracted unit price for the material or service at the time of agreement, serving as the baseline for pricing calculations and adjustments.',
    `created_by_user` STRING COMMENT 'The username or employee identifier of the person who created this price schedule record in the system.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this price schedule record was first created in the system, supporting audit trail and data lineage requirements.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code in which the price is denominated, such as USD, AUD, EUR, or GBP.. Valid values are `^[A-Z]{3}$`',
    `delivery_lead_time_days` STRING COMMENT 'The standard number of days between purchase order placement and expected delivery under this price schedule, used for materials planning and scheduling.',
    `effective_from_date` DATE COMMENT 'The date from which this price schedule becomes valid and can be applied to purchase orders and goods receipts.',
    `effective_to_date` DATE COMMENT 'The date on which this price schedule expires and is no longer valid for new purchase orders. Null indicates an open-ended schedule.',
    `escalation_formula` STRING COMMENT 'The mathematical formula or calculation method used to adjust the base price based on index movements or other variables, supporting automated price variance analysis.',
    `incoterms_code` STRING COMMENT 'The International Commercial Terms (Incoterms) code defining the delivery terms and transfer of risk, such as FOB (Free on Board), CIF (Cost Insurance and Freight), or EXW (Ex Works).. Valid values are `^[A-Z]{3}$`',
    `last_modified_by_user` STRING COMMENT 'The username or employee identifier of the person who most recently updated this price schedule record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this price schedule record was most recently updated, enabling change tracking and version control.',
    `maximum_order_quantity` DECIMAL(18,2) COMMENT 'The maximum quantity that can be ordered under this price schedule, used to enforce contract limits and prevent over-commitment.',
    `minimum_order_quantity` DECIMAL(18,2) COMMENT 'The minimum quantity that must be ordered to qualify for this price schedule, supporting volume-based pricing strategies.',
    `payment_terms_code` STRING COMMENT 'The payment terms applicable to purchases under this price schedule, defining the timing and conditions of payment to the vendor.',
    `price_basis` STRING COMMENT 'The pricing mechanism or indexation method used to determine the actual price, indicating whether the price is fixed for the contract term or subject to adjustment based on external indices or formulas.. Valid values are `fixed|cpi_indexed|commodity_indexed|formula_based|market_linked`',
    `price_unit` STRING COMMENT 'The quantity unit to which the base price applies, typically 1 but may be 10, 100, or 1000 for bulk pricing scenarios.',
    `price_variance_tolerance_percent` DECIMAL(18,2) COMMENT 'The acceptable percentage deviation from the scheduled price before triggering a price variance alert or approval workflow, supporting contract compliance monitoring.',
    `purchasing_group` STRING COMMENT 'The buyer or procurement team responsible for managing this price schedule and associated vendor relationships.',
    `purchasing_organization` STRING COMMENT 'The organizational unit responsible for procurement activities under this price schedule, typically aligned with regional or divisional procurement structures.',
    `schedule_notes` STRING COMMENT 'Free-text field for additional comments, special conditions, or instructions related to this price schedule, such as quality requirements or delivery constraints.',
    `schedule_number` STRING COMMENT 'Business identifier for the price schedule, typically a human-readable code or reference number used in procurement documents and purchase orders.',
    `schedule_status` STRING COMMENT 'Current lifecycle status of the price schedule indicating whether it is available for use in purchase order pricing.. Valid values are `draft|active|suspended|expired|cancelled`',
    `service_description` STRING COMMENT 'Detailed description of the service covered by this price schedule when the schedule applies to services rather than materials.',
    `unit_of_measure` STRING COMMENT 'The unit of measure in which the material or service is priced and ordered, such as tonnes, kilograms, litres, hours, or each.',
    `volume_tier` STRING COMMENT 'The volume bracket or tier to which this price schedule applies, enabling tiered pricing structures where unit price decreases with higher volumes.',
    CONSTRAINT pk_price_schedule PRIMARY KEY(`price_schedule_id`)
) COMMENT 'Reference record defining contracted or standard pricing schedules for materials and services within a procurement contract or framework agreement. Captures price schedule reference, contract reference, material or service description, unit of measure, base price, price basis (fixed, CPI-indexed, commodity-indexed), effective date, expiry date, and applicable mine site or region. Supports automated PO pricing, price variance analysis, and contract compliance monitoring. Sourced from SAP S/4HANA MM contract pricing conditions.';

CREATE OR REPLACE TABLE `mining_ecm`.`procurement`.`delivery_schedule` (
    `delivery_schedule_id` BIGINT COMMENT 'Unique identifier for the delivery schedule record. Primary key for the delivery schedule entity.',
    `contract_id` BIGINT COMMENT 'Foreign key linking to procurement.contract. Business justification: Delivery schedules are call-offs against framework agreements or blanket purchase orders. Converting STRING contract_number to FK enables proper contract compliance tracking. N:1 relationship (many de',
    `freight_order_id` BIGINT COMMENT 'Foreign key linking to procurement.freight_order. Business justification: Delivery schedules (call-offs against blanket POs or schedule agreements) are executed via freight orders in mining logistics. Linking delivery_schedule to freight_order enables tracking of whether sc',
    `production_schedule_id` BIGINT COMMENT 'Foreign key linking to mine.production_schedule. Business justification: Delivery schedules for critical mining consumables (explosives, fuel, ground support) are aligned with production schedule periods to ensure materials arrive before planned blast and development activ',
    `purchase_order_id` BIGINT COMMENT 'Reference to the parent blanket purchase order or schedule agreement under which this delivery schedule is created. Links the schedule to the overarching procurement contract.',
    `purchase_order_line_id` BIGINT COMMENT 'Foreign key linking to procurement.purchase_order_line. Business justification: Delivery schedules are call-offs against specific purchase order line items. The delivery_schedule table already has purchase_order_id (header FK) but no FK to purchase_order_line. Adding purchase_ord',
    `revised_delivery_schedule_id` BIGINT COMMENT 'Self-referencing FK on delivery_schedule (revised_delivery_schedule_id)',
    `material_master_id` BIGINT COMMENT 'Reference to the material master record for the item being scheduled for delivery. Identifies the specific mining consumable (explosives, reagents, fuel, tyres) covered by this schedule line.',
    `vendor_id` BIGINT COMMENT 'Reference to the supplier responsible for fulfilling this delivery schedule. Links to the vendor master record for the contracted supplier.',
    `warehouse_location_id` BIGINT COMMENT 'Foreign key linking to procurement.warehouse_location. Business justification: Delivery schedules specify where materials are to be delivered. Currently delivery_location_code and delivery_location_name are stored as strings. Adding warehouse_location_id normalizes this to the w',
    `actual_delivery_date` DATE COMMENT 'Actual date on which the material was delivered and goods receipt was posted. Used for supplier performance evaluation and schedule adherence tracking.',
    `call_off_date` DATE COMMENT 'Date on which the call-off or release was issued to the vendor. Marks the formal request for delivery under the blanket agreement.',
    `called_off_quantity` DECIMAL(18,2) COMMENT 'Quantity of material released or called off from the blanket purchase order for this specific delivery schedule line. Represents the amount requested from the supplier for this delivery.',
    `company_code` STRING COMMENT 'Financial accounting organizational unit representing the legal entity for which this delivery schedule is recorded. Used for financial reporting and compliance.',
    `confirmed_quantity` DECIMAL(18,2) COMMENT 'Quantity confirmed by the vendor for delivery on the planned delivery date. May differ from called-off quantity if supplier cannot fulfill the full request.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this delivery schedule record was first created in the system. Used for audit trail and data lineage.',
    `delivered_quantity` DECIMAL(18,2) COMMENT 'Actual quantity of material delivered and received against this schedule line. Updated upon goods receipt posting.',
    `delivery_note_number` STRING COMMENT 'Supplier-provided delivery note or packing slip number accompanying the shipment. Used for cross-referencing and reconciliation.',
    `delivery_tolerance_percent` DECIMAL(18,2) COMMENT 'Acceptable percentage variance (over or under) from the called-off quantity that the supplier may deliver without requiring approval. Used for managing supply flexibility.',
    `goods_receipt_number` STRING COMMENT 'Material document number generated when goods are received against this delivery schedule. Links the schedule to the physical receipt transaction.',
    `hazardous_material_indicator` BOOLEAN COMMENT 'Flag indicating whether the scheduled material is classified as hazardous or dangerous goods. Triggers special handling and compliance requirements.',
    `incoterms_code` STRING COMMENT 'International Commercial Terms code defining the responsibilities and risks between buyer and supplier for this delivery (e.g., FOB, CIF, DDP). Critical for logistics and cost allocation.',
    `incoterms_location` STRING COMMENT 'Specific location or port associated with the Incoterms code (e.g., FOB Perth, CIF Singapore). Defines the point at which risk and cost transfer occurs.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this delivery schedule record was last updated. Used for change tracking and audit purposes.',
    `outstanding_quantity` DECIMAL(18,2) COMMENT 'Remaining quantity yet to be delivered against this schedule line. Calculated as called-off quantity minus delivered quantity.',
    `planned_delivery_date` DATE COMMENT 'Scheduled date on which the material is expected to be delivered to the designated location. Used for planning and coordination of mining operations and inventory management.',
    `plant_code` STRING COMMENT 'SAP plant code representing the receiving organizational unit or mine site. Used for inventory management and cost allocation.',
    `priority_indicator` STRING COMMENT 'Business priority level assigned to this delivery schedule. Used for expediting critical materials and managing supplier attention.. Valid values are `low|normal|high|urgent`',
    `purchasing_group` STRING COMMENT 'Organizational unit or buyer responsible for managing this delivery schedule and supplier relationship. Used for accountability and workload distribution.',
    `purchasing_organization` STRING COMMENT 'Higher-level organizational unit responsible for procurement activities. Defines the legal entity or business unit conducting the purchase.',
    `schedule_line_number` STRING COMMENT 'Sequential line number within the parent purchase order or schedule agreement identifying this specific delivery schedule line. Used for ordering and referencing individual schedule lines within a blanket agreement.',
    `schedule_notes` STRING COMMENT 'Free-text notes or comments related to this delivery schedule. Used for capturing additional context, exceptions, or coordination details.',
    `schedule_status` STRING COMMENT 'Current lifecycle status of the delivery schedule line. Tracks progression from planning through delivery completion or cancellation. [ENUM-REF-CANDIDATE: planned|called_off|confirmed|in_transit|delivered|partially_delivered|overdue|cancelled — 8 candidates stripped; promote to reference product]',
    `schedule_type` STRING COMMENT 'Frequency or pattern of the delivery schedule (weekly, monthly, quarterly, or ad-hoc). Defines the cadence of call-offs under the blanket agreement.. Valid values are `weekly|monthly|quarterly|ad_hoc`',
    `special_handling_instructions` STRING COMMENT 'Free-text instructions for special handling requirements for this delivery (e.g., temperature control, hazardous materials handling, security requirements). Critical for mining consumables like explosives.',
    `storage_location_code` STRING COMMENT 'Specific storage location within the plant where the delivered material will be received and stored. Critical for warehouse management and inventory tracking.',
    `unit_of_measure` STRING COMMENT 'Unit in which the scheduled quantity is expressed (e.g., tonnes, litres, each, kilograms). Aligns with material master base unit or order unit.',
    CONSTRAINT pk_delivery_schedule PRIMARY KEY(`delivery_schedule_id`)
) COMMENT 'Delivery schedule and call-off record against a blanket purchase order or schedule agreement, specifying planned delivery dates, quantities, and delivery locations for periodic releases of contracted materials. Captures schedule line number, parent PO or contract reference, material, planned delivery date, called-off quantity, confirmed quantity, delivery location (mine site, warehouse, port), schedule status (planned, called-off, delivered, overdue), and actual delivery date. Critical for managing long-term supply agreements for mining consumables (explosives, reagents, fuel, tyres) where annual contracts are released in weekly or monthly call-offs. Sourced from SAP S/4HANA MM schedule lines and delivery schedules.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `mining_ecm`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `mining_ecm`.`procurement`.`contract`(`contract_id`);
ALTER TABLE `mining_ecm`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_warehouse_location_id` FOREIGN KEY (`warehouse_location_id`) REFERENCES `mining_ecm`.`procurement`.`warehouse_location`(`warehouse_location_id`);
ALTER TABLE `mining_ecm`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_framework_agreement_id` FOREIGN KEY (`framework_agreement_id`) REFERENCES `mining_ecm`.`procurement`.`framework_agreement`(`framework_agreement_id`);
ALTER TABLE `mining_ecm`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_price_schedule_id` FOREIGN KEY (`price_schedule_id`) REFERENCES `mining_ecm`.`procurement`.`price_schedule`(`price_schedule_id`);
ALTER TABLE `mining_ecm`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_requisition_id` FOREIGN KEY (`requisition_id`) REFERENCES `mining_ecm`.`procurement`.`requisition`(`requisition_id`);
ALTER TABLE `mining_ecm`.`procurement`.`purchase_order` ADD CONSTRAINT `fk_procurement_purchase_order_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `mining_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `mining_ecm`.`procurement`.`purchase_order_line` ADD CONSTRAINT `fk_procurement_purchase_order_line_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `mining_ecm`.`procurement`.`contract`(`contract_id`);
ALTER TABLE `mining_ecm`.`procurement`.`purchase_order_line` ADD CONSTRAINT `fk_procurement_purchase_order_line_price_schedule_id` FOREIGN KEY (`price_schedule_id`) REFERENCES `mining_ecm`.`procurement`.`price_schedule`(`price_schedule_id`);
ALTER TABLE `mining_ecm`.`procurement`.`purchase_order_line` ADD CONSTRAINT `fk_procurement_purchase_order_line_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `mining_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `mining_ecm`.`procurement`.`purchase_order_line` ADD CONSTRAINT `fk_procurement_purchase_order_line_requisition_id` FOREIGN KEY (`requisition_id`) REFERENCES `mining_ecm`.`procurement`.`requisition`(`requisition_id`);
ALTER TABLE `mining_ecm`.`procurement`.`purchase_order_line` ADD CONSTRAINT `fk_procurement_purchase_order_line_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `mining_ecm`.`procurement`.`material_master`(`material_master_id`);
ALTER TABLE `mining_ecm`.`procurement`.`goods_receipt` ADD CONSTRAINT `fk_procurement_goods_receipt_delivery_schedule_id` FOREIGN KEY (`delivery_schedule_id`) REFERENCES `mining_ecm`.`procurement`.`delivery_schedule`(`delivery_schedule_id`);
ALTER TABLE `mining_ecm`.`procurement`.`goods_receipt` ADD CONSTRAINT `fk_procurement_goods_receipt_inbound_delivery_id` FOREIGN KEY (`inbound_delivery_id`) REFERENCES `mining_ecm`.`procurement`.`inbound_delivery`(`inbound_delivery_id`);
ALTER TABLE `mining_ecm`.`procurement`.`goods_receipt` ADD CONSTRAINT `fk_procurement_goods_receipt_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `mining_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `mining_ecm`.`procurement`.`goods_receipt` ADD CONSTRAINT `fk_procurement_goods_receipt_purchase_order_line_id` FOREIGN KEY (`purchase_order_line_id`) REFERENCES `mining_ecm`.`procurement`.`purchase_order_line`(`purchase_order_line_id`);
ALTER TABLE `mining_ecm`.`procurement`.`goods_receipt` ADD CONSTRAINT `fk_procurement_goods_receipt_stock_transfer_id` FOREIGN KEY (`stock_transfer_id`) REFERENCES `mining_ecm`.`procurement`.`stock_transfer`(`stock_transfer_id`);
ALTER TABLE `mining_ecm`.`procurement`.`goods_receipt` ADD CONSTRAINT `fk_procurement_goods_receipt_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `mining_ecm`.`procurement`.`material_master`(`material_master_id`);
ALTER TABLE `mining_ecm`.`procurement`.`goods_receipt` ADD CONSTRAINT `fk_procurement_goods_receipt_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `mining_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `mining_ecm`.`procurement`.`goods_receipt` ADD CONSTRAINT `fk_procurement_goods_receipt_warehouse_location_id` FOREIGN KEY (`warehouse_location_id`) REFERENCES `mining_ecm`.`procurement`.`warehouse_location`(`warehouse_location_id`);
ALTER TABLE `mining_ecm`.`procurement`.`goods_issue` ADD CONSTRAINT `fk_procurement_goods_issue_freight_order_id` FOREIGN KEY (`freight_order_id`) REFERENCES `mining_ecm`.`procurement`.`freight_order`(`freight_order_id`);
ALTER TABLE `mining_ecm`.`procurement`.`goods_issue` ADD CONSTRAINT `fk_procurement_goods_issue_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `mining_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `mining_ecm`.`procurement`.`goods_issue` ADD CONSTRAINT `fk_procurement_goods_issue_purchase_order_line_id` FOREIGN KEY (`purchase_order_line_id`) REFERENCES `mining_ecm`.`procurement`.`purchase_order_line`(`purchase_order_line_id`);
ALTER TABLE `mining_ecm`.`procurement`.`goods_issue` ADD CONSTRAINT `fk_procurement_goods_issue_stock_transfer_id` FOREIGN KEY (`stock_transfer_id`) REFERENCES `mining_ecm`.`procurement`.`stock_transfer`(`stock_transfer_id`);
ALTER TABLE `mining_ecm`.`procurement`.`goods_issue` ADD CONSTRAINT `fk_procurement_goods_issue_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `mining_ecm`.`procurement`.`material_master`(`material_master_id`);
ALTER TABLE `mining_ecm`.`procurement`.`goods_issue` ADD CONSTRAINT `fk_procurement_goods_issue_warehouse_location_id` FOREIGN KEY (`warehouse_location_id`) REFERENCES `mining_ecm`.`procurement`.`warehouse_location`(`warehouse_location_id`);
ALTER TABLE `mining_ecm`.`procurement`.`inventory_balance` ADD CONSTRAINT `fk_procurement_inventory_balance_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `mining_ecm`.`procurement`.`material_master`(`material_master_id`);
ALTER TABLE `mining_ecm`.`procurement`.`inventory_balance` ADD CONSTRAINT `fk_procurement_inventory_balance_warehouse_location_id` FOREIGN KEY (`warehouse_location_id`) REFERENCES `mining_ecm`.`procurement`.`warehouse_location`(`warehouse_location_id`);
ALTER TABLE `mining_ecm`.`procurement`.`stock_transfer` ADD CONSTRAINT `fk_procurement_stock_transfer_delivery_schedule_id` FOREIGN KEY (`delivery_schedule_id`) REFERENCES `mining_ecm`.`procurement`.`delivery_schedule`(`delivery_schedule_id`);
ALTER TABLE `mining_ecm`.`procurement`.`stock_transfer` ADD CONSTRAINT `fk_procurement_stock_transfer_freight_order_id` FOREIGN KEY (`freight_order_id`) REFERENCES `mining_ecm`.`procurement`.`freight_order`(`freight_order_id`);
ALTER TABLE `mining_ecm`.`procurement`.`stock_transfer` ADD CONSTRAINT `fk_procurement_stock_transfer_warehouse_location_id` FOREIGN KEY (`warehouse_location_id`) REFERENCES `mining_ecm`.`procurement`.`warehouse_location`(`warehouse_location_id`);
ALTER TABLE `mining_ecm`.`procurement`.`stock_transfer` ADD CONSTRAINT `fk_procurement_stock_transfer_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `mining_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `mining_ecm`.`procurement`.`stock_transfer` ADD CONSTRAINT `fk_procurement_stock_transfer_receiving_storage_location_warehouse_location_id` FOREIGN KEY (`receiving_storage_location_warehouse_location_id`) REFERENCES `mining_ecm`.`procurement`.`warehouse_location`(`warehouse_location_id`);
ALTER TABLE `mining_ecm`.`procurement`.`stock_transfer` ADD CONSTRAINT `fk_procurement_stock_transfer_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `mining_ecm`.`procurement`.`material_master`(`material_master_id`);
ALTER TABLE `mining_ecm`.`procurement`.`inbound_delivery` ADD CONSTRAINT `fk_procurement_inbound_delivery_delivery_schedule_id` FOREIGN KEY (`delivery_schedule_id`) REFERENCES `mining_ecm`.`procurement`.`delivery_schedule`(`delivery_schedule_id`);
ALTER TABLE `mining_ecm`.`procurement`.`inbound_delivery` ADD CONSTRAINT `fk_procurement_inbound_delivery_freight_order_id` FOREIGN KEY (`freight_order_id`) REFERENCES `mining_ecm`.`procurement`.`freight_order`(`freight_order_id`);
ALTER TABLE `mining_ecm`.`procurement`.`inbound_delivery` ADD CONSTRAINT `fk_procurement_inbound_delivery_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `mining_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `mining_ecm`.`procurement`.`inbound_delivery` ADD CONSTRAINT `fk_procurement_inbound_delivery_purchase_order_line_id` FOREIGN KEY (`purchase_order_line_id`) REFERENCES `mining_ecm`.`procurement`.`purchase_order_line`(`purchase_order_line_id`);
ALTER TABLE `mining_ecm`.`procurement`.`inbound_delivery` ADD CONSTRAINT `fk_procurement_inbound_delivery_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `mining_ecm`.`procurement`.`material_master`(`material_master_id`);
ALTER TABLE `mining_ecm`.`procurement`.`inbound_delivery` ADD CONSTRAINT `fk_procurement_inbound_delivery_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `mining_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `mining_ecm`.`procurement`.`inbound_delivery` ADD CONSTRAINT `fk_procurement_inbound_delivery_warehouse_location_id` FOREIGN KEY (`warehouse_location_id`) REFERENCES `mining_ecm`.`procurement`.`warehouse_location`(`warehouse_location_id`);
ALTER TABLE `mining_ecm`.`procurement`.`outbound_shipment` ADD CONSTRAINT `fk_procurement_outbound_shipment_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `mining_ecm`.`procurement`.`contract`(`contract_id`);
ALTER TABLE `mining_ecm`.`procurement`.`outbound_shipment` ADD CONSTRAINT `fk_procurement_outbound_shipment_freight_order_id` FOREIGN KEY (`freight_order_id`) REFERENCES `mining_ecm`.`procurement`.`freight_order`(`freight_order_id`);
ALTER TABLE `mining_ecm`.`procurement`.`outbound_shipment` ADD CONSTRAINT `fk_procurement_outbound_shipment_warehouse_location_id` FOREIGN KEY (`warehouse_location_id`) REFERENCES `mining_ecm`.`procurement`.`warehouse_location`(`warehouse_location_id`);
ALTER TABLE `mining_ecm`.`procurement`.`procurement_vendor_performance` ADD CONSTRAINT `fk_procurement_procurement_vendor_performance_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `mining_ecm`.`procurement`.`contract`(`contract_id`);
ALTER TABLE `mining_ecm`.`procurement`.`procurement_vendor_performance` ADD CONSTRAINT `fk_procurement_procurement_vendor_performance_framework_agreement_id` FOREIGN KEY (`framework_agreement_id`) REFERENCES `mining_ecm`.`procurement`.`framework_agreement`(`framework_agreement_id`);
ALTER TABLE `mining_ecm`.`procurement`.`procurement_vendor_performance` ADD CONSTRAINT `fk_procurement_procurement_vendor_performance_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `mining_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `mining_ecm`.`procurement`.`requisition` ADD CONSTRAINT `fk_procurement_requisition_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `mining_ecm`.`procurement`.`contract`(`contract_id`);
ALTER TABLE `mining_ecm`.`procurement`.`requisition` ADD CONSTRAINT `fk_procurement_requisition_framework_agreement_id` FOREIGN KEY (`framework_agreement_id`) REFERENCES `mining_ecm`.`procurement`.`framework_agreement`(`framework_agreement_id`);
ALTER TABLE `mining_ecm`.`procurement`.`requisition` ADD CONSTRAINT `fk_procurement_requisition_price_schedule_id` FOREIGN KEY (`price_schedule_id`) REFERENCES `mining_ecm`.`procurement`.`price_schedule`(`price_schedule_id`);
ALTER TABLE `mining_ecm`.`procurement`.`requisition` ADD CONSTRAINT `fk_procurement_requisition_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `mining_ecm`.`procurement`.`material_master`(`material_master_id`);
ALTER TABLE `mining_ecm`.`procurement`.`requisition` ADD CONSTRAINT `fk_procurement_requisition_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `mining_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `mining_ecm`.`procurement`.`requisition` ADD CONSTRAINT `fk_procurement_requisition_warehouse_location_id` FOREIGN KEY (`warehouse_location_id`) REFERENCES `mining_ecm`.`procurement`.`warehouse_location`(`warehouse_location_id`);
ALTER TABLE `mining_ecm`.`procurement`.`framework_agreement` ADD CONSTRAINT `fk_procurement_framework_agreement_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `mining_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `mining_ecm`.`procurement`.`freight_order` ADD CONSTRAINT `fk_procurement_freight_order_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `mining_ecm`.`procurement`.`contract`(`contract_id`);
ALTER TABLE `mining_ecm`.`procurement`.`freight_order` ADD CONSTRAINT `fk_procurement_freight_order_warehouse_location_id` FOREIGN KEY (`warehouse_location_id`) REFERENCES `mining_ecm`.`procurement`.`warehouse_location`(`warehouse_location_id`);
ALTER TABLE `mining_ecm`.`procurement`.`freight_order` ADD CONSTRAINT `fk_procurement_freight_order_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `mining_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `mining_ecm`.`procurement`.`freight_order` ADD CONSTRAINT `fk_procurement_freight_order_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `mining_ecm`.`procurement`.`material_master`(`material_master_id`);
ALTER TABLE `mining_ecm`.`procurement`.`freight_order` ADD CONSTRAINT `fk_procurement_freight_order_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `mining_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `mining_ecm`.`procurement`.`physical_inventory` ADD CONSTRAINT `fk_procurement_physical_inventory_inventory_balance_id` FOREIGN KEY (`inventory_balance_id`) REFERENCES `mining_ecm`.`procurement`.`inventory_balance`(`inventory_balance_id`);
ALTER TABLE `mining_ecm`.`procurement`.`physical_inventory` ADD CONSTRAINT `fk_procurement_physical_inventory_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `mining_ecm`.`procurement`.`material_master`(`material_master_id`);
ALTER TABLE `mining_ecm`.`procurement`.`physical_inventory` ADD CONSTRAINT `fk_procurement_physical_inventory_warehouse_location_id` FOREIGN KEY (`warehouse_location_id`) REFERENCES `mining_ecm`.`procurement`.`warehouse_location`(`warehouse_location_id`);
ALTER TABLE `mining_ecm`.`procurement`.`contract` ADD CONSTRAINT `fk_procurement_contract_framework_agreement_id` FOREIGN KEY (`framework_agreement_id`) REFERENCES `mining_ecm`.`procurement`.`framework_agreement`(`framework_agreement_id`);
ALTER TABLE `mining_ecm`.`procurement`.`contract` ADD CONSTRAINT `fk_procurement_contract_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `mining_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `mining_ecm`.`procurement`.`vendor_performance` ADD CONSTRAINT `fk_procurement_vendor_performance_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `mining_ecm`.`procurement`.`contract`(`contract_id`);
ALTER TABLE `mining_ecm`.`procurement`.`vendor_performance` ADD CONSTRAINT `fk_procurement_vendor_performance_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `mining_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `mining_ecm`.`procurement`.`vendor_performance` ADD CONSTRAINT `fk_procurement_vendor_performance_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `mining_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `mining_ecm`.`procurement`.`price_schedule` ADD CONSTRAINT `fk_procurement_price_schedule_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `mining_ecm`.`procurement`.`contract`(`contract_id`);
ALTER TABLE `mining_ecm`.`procurement`.`price_schedule` ADD CONSTRAINT `fk_procurement_price_schedule_framework_agreement_id` FOREIGN KEY (`framework_agreement_id`) REFERENCES `mining_ecm`.`procurement`.`framework_agreement`(`framework_agreement_id`);
ALTER TABLE `mining_ecm`.`procurement`.`price_schedule` ADD CONSTRAINT `fk_procurement_price_schedule_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `mining_ecm`.`procurement`.`material_master`(`material_master_id`);
ALTER TABLE `mining_ecm`.`procurement`.`price_schedule` ADD CONSTRAINT `fk_procurement_price_schedule_tertiary_price_material_master_id` FOREIGN KEY (`tertiary_price_material_master_id`) REFERENCES `mining_ecm`.`procurement`.`material_master`(`material_master_id`);
ALTER TABLE `mining_ecm`.`procurement`.`price_schedule` ADD CONSTRAINT `fk_procurement_price_schedule_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `mining_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `mining_ecm`.`procurement`.`price_schedule` ADD CONSTRAINT `fk_procurement_price_schedule_warehouse_location_id` FOREIGN KEY (`warehouse_location_id`) REFERENCES `mining_ecm`.`procurement`.`warehouse_location`(`warehouse_location_id`);
ALTER TABLE `mining_ecm`.`procurement`.`delivery_schedule` ADD CONSTRAINT `fk_procurement_delivery_schedule_contract_id` FOREIGN KEY (`contract_id`) REFERENCES `mining_ecm`.`procurement`.`contract`(`contract_id`);
ALTER TABLE `mining_ecm`.`procurement`.`delivery_schedule` ADD CONSTRAINT `fk_procurement_delivery_schedule_freight_order_id` FOREIGN KEY (`freight_order_id`) REFERENCES `mining_ecm`.`procurement`.`freight_order`(`freight_order_id`);
ALTER TABLE `mining_ecm`.`procurement`.`delivery_schedule` ADD CONSTRAINT `fk_procurement_delivery_schedule_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `mining_ecm`.`procurement`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `mining_ecm`.`procurement`.`delivery_schedule` ADD CONSTRAINT `fk_procurement_delivery_schedule_purchase_order_line_id` FOREIGN KEY (`purchase_order_line_id`) REFERENCES `mining_ecm`.`procurement`.`purchase_order_line`(`purchase_order_line_id`);
ALTER TABLE `mining_ecm`.`procurement`.`delivery_schedule` ADD CONSTRAINT `fk_procurement_delivery_schedule_revised_delivery_schedule_id` FOREIGN KEY (`revised_delivery_schedule_id`) REFERENCES `mining_ecm`.`procurement`.`delivery_schedule`(`delivery_schedule_id`);
ALTER TABLE `mining_ecm`.`procurement`.`delivery_schedule` ADD CONSTRAINT `fk_procurement_delivery_schedule_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `mining_ecm`.`procurement`.`material_master`(`material_master_id`);
ALTER TABLE `mining_ecm`.`procurement`.`delivery_schedule` ADD CONSTRAINT `fk_procurement_delivery_schedule_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `mining_ecm`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `mining_ecm`.`procurement`.`delivery_schedule` ADD CONSTRAINT `fk_procurement_delivery_schedule_warehouse_location_id` FOREIGN KEY (`warehouse_location_id`) REFERENCES `mining_ecm`.`procurement`.`warehouse_location`(`warehouse_location_id`);

-- ========= TAGS =========
ALTER SCHEMA `mining_ecm`.`procurement` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `mining_ecm`.`procurement` SET TAGS ('dbx_domain' = 'procurement');
ALTER TABLE `mining_ecm`.`procurement`.`material_master` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `mining_ecm`.`procurement`.`material_master` SET TAGS ('dbx_subdomain' = 'supplier_contracts');
ALTER TABLE `mining_ecm`.`procurement`.`material_master` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Identifier');
ALTER TABLE `mining_ecm`.`procurement`.`material_master` ALTER COLUMN `grade_parameter_id` SET TAGS ('dbx_business_glossary_term' = 'Grade Parameter Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`procurement`.`material_master` ALTER COLUMN `abc_indicator` SET TAGS ('dbx_business_glossary_term' = 'ABC Indicator');
ALTER TABLE `mining_ecm`.`procurement`.`material_master` ALTER COLUMN `abc_indicator` SET TAGS ('dbx_value_regex' = 'A|B|C');
ALTER TABLE `mining_ecm`.`procurement`.`material_master` ALTER COLUMN `base_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Base Unit of Measure (UoM)');
ALTER TABLE `mining_ecm`.`procurement`.`material_master` ALTER COLUMN `base_unit_of_measure` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,3}$');
ALTER TABLE `mining_ecm`.`procurement`.`material_master` ALTER COLUMN `batch_management_indicator` SET TAGS ('dbx_business_glossary_term' = 'Batch Management Indicator');
ALTER TABLE `mining_ecm`.`procurement`.`material_master` ALTER COLUMN `commodity_category` SET TAGS ('dbx_business_glossary_term' = 'Commodity Category');
ALTER TABLE `mining_ecm`.`procurement`.`material_master` ALTER COLUMN `created_date` SET TAGS ('dbx_business_glossary_term' = 'Created Date');
ALTER TABLE `mining_ecm`.`procurement`.`material_master` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `mining_ecm`.`procurement`.`material_master` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `mining_ecm`.`procurement`.`material_master` ALTER COLUMN `deletion_indicator` SET TAGS ('dbx_business_glossary_term' = 'Deletion Indicator');
ALTER TABLE `mining_ecm`.`procurement`.`material_master` ALTER COLUMN `gross_weight` SET TAGS ('dbx_business_glossary_term' = 'Gross Weight');
ALTER TABLE `mining_ecm`.`procurement`.`material_master` ALTER COLUMN `hazard_class` SET TAGS ('dbx_business_glossary_term' = 'Hazard Class');
ALTER TABLE `mining_ecm`.`procurement`.`material_master` ALTER COLUMN `hazardous_material_indicator` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Material Indicator');
ALTER TABLE `mining_ecm`.`procurement`.`material_master` ALTER COLUMN `last_modified_date` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Date');
ALTER TABLE `mining_ecm`.`procurement`.`material_master` ALTER COLUMN `manufacturer_name` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Name');
ALTER TABLE `mining_ecm`.`procurement`.`material_master` ALTER COLUMN `manufacturer_part_number` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Part Number (MPN)');
ALTER TABLE `mining_ecm`.`procurement`.`material_master` ALTER COLUMN `material_description` SET TAGS ('dbx_business_glossary_term' = 'Material Description');
ALTER TABLE `mining_ecm`.`procurement`.`material_master` ALTER COLUMN `material_group` SET TAGS ('dbx_business_glossary_term' = 'Material Group');
ALTER TABLE `mining_ecm`.`procurement`.`material_master` ALTER COLUMN `material_group` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `mining_ecm`.`procurement`.`material_master` ALTER COLUMN `material_number` SET TAGS ('dbx_business_glossary_term' = 'Material Number');
ALTER TABLE `mining_ecm`.`procurement`.`material_master` ALTER COLUMN `material_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,18}$');
ALTER TABLE `mining_ecm`.`procurement`.`material_master` ALTER COLUMN `material_status` SET TAGS ('dbx_business_glossary_term' = 'Material Status');
ALTER TABLE `mining_ecm`.`procurement`.`material_master` ALTER COLUMN `material_status` SET TAGS ('dbx_value_regex' = 'active|inactive|blocked|obsolete|pending_approval');
ALTER TABLE `mining_ecm`.`procurement`.`material_master` ALTER COLUMN `material_type` SET TAGS ('dbx_business_glossary_term' = 'Material Type');
ALTER TABLE `mining_ecm`.`procurement`.`material_master` ALTER COLUMN `maximum_stock_quantity` SET TAGS ('dbx_business_glossary_term' = 'Maximum Stock Quantity');
ALTER TABLE `mining_ecm`.`procurement`.`material_master` ALTER COLUMN `moving_average_price` SET TAGS ('dbx_business_glossary_term' = 'Moving Average Price (MAP)');
ALTER TABLE `mining_ecm`.`procurement`.`material_master` ALTER COLUMN `moving_average_price` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`procurement`.`material_master` ALTER COLUMN `net_weight` SET TAGS ('dbx_business_glossary_term' = 'Net Weight');
ALTER TABLE `mining_ecm`.`procurement`.`material_master` ALTER COLUMN `planned_delivery_lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Planned Delivery Lead Time (Days)');
ALTER TABLE `mining_ecm`.`procurement`.`material_master` ALTER COLUMN `plant_specific_status` SET TAGS ('dbx_business_glossary_term' = 'Plant-Specific Material Status');
ALTER TABLE `mining_ecm`.`procurement`.`material_master` ALTER COLUMN `price_control_indicator` SET TAGS ('dbx_business_glossary_term' = 'Price Control Indicator');
ALTER TABLE `mining_ecm`.`procurement`.`material_master` ALTER COLUMN `price_control_indicator` SET TAGS ('dbx_value_regex' = 'S|V');
ALTER TABLE `mining_ecm`.`procurement`.`material_master` ALTER COLUMN `price_unit` SET TAGS ('dbx_business_glossary_term' = 'Price Unit');
ALTER TABLE `mining_ecm`.`procurement`.`material_master` ALTER COLUMN `procurement_type` SET TAGS ('dbx_business_glossary_term' = 'Procurement Type');
ALTER TABLE `mining_ecm`.`procurement`.`material_master` ALTER COLUMN `procurement_type` SET TAGS ('dbx_value_regex' = 'standard|consignment|subcontracting|pipeline|external|stock_transfer');
ALTER TABLE `mining_ecm`.`procurement`.`material_master` ALTER COLUMN `purchasing_group` SET TAGS ('dbx_business_glossary_term' = 'Purchasing Group');
ALTER TABLE `mining_ecm`.`procurement`.`material_master` ALTER COLUMN `purchasing_group` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3}$');
ALTER TABLE `mining_ecm`.`procurement`.`material_master` ALTER COLUMN `reorder_point_quantity` SET TAGS ('dbx_business_glossary_term' = 'Reorder Point Quantity');
ALTER TABLE `mining_ecm`.`procurement`.`material_master` ALTER COLUMN `safety_stock_quantity` SET TAGS ('dbx_business_glossary_term' = 'Safety Stock Quantity');
ALTER TABLE `mining_ecm`.`procurement`.`material_master` ALTER COLUMN `serial_number_profile` SET TAGS ('dbx_business_glossary_term' = 'Serial Number Profile');
ALTER TABLE `mining_ecm`.`procurement`.`material_master` ALTER COLUMN `shelf_life_days` SET TAGS ('dbx_business_glossary_term' = 'Shelf Life (Days)');
ALTER TABLE `mining_ecm`.`procurement`.`material_master` ALTER COLUMN `standard_price` SET TAGS ('dbx_business_glossary_term' = 'Standard Price');
ALTER TABLE `mining_ecm`.`procurement`.`material_master` ALTER COLUMN `standard_price` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`procurement`.`material_master` ALTER COLUMN `storage_conditions` SET TAGS ('dbx_business_glossary_term' = 'Storage Conditions');
ALTER TABLE `mining_ecm`.`procurement`.`material_master` ALTER COLUMN `valuation_class` SET TAGS ('dbx_business_glossary_term' = 'Valuation Class');
ALTER TABLE `mining_ecm`.`procurement`.`material_master` ALTER COLUMN `valuation_class` SET TAGS ('dbx_value_regex' = '^[0-9]{4}$');
ALTER TABLE `mining_ecm`.`procurement`.`material_master` ALTER COLUMN `volume` SET TAGS ('dbx_business_glossary_term' = 'Volume');
ALTER TABLE `mining_ecm`.`procurement`.`material_master` ALTER COLUMN `volume_unit` SET TAGS ('dbx_business_glossary_term' = 'Volume Unit');
ALTER TABLE `mining_ecm`.`procurement`.`material_master` ALTER COLUMN `volume_unit` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,3}$');
ALTER TABLE `mining_ecm`.`procurement`.`material_master` ALTER COLUMN `weight_unit` SET TAGS ('dbx_business_glossary_term' = 'Weight Unit');
ALTER TABLE `mining_ecm`.`procurement`.`material_master` ALTER COLUMN `weight_unit` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,3}$');
ALTER TABLE `mining_ecm`.`procurement`.`vendor` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `mining_ecm`.`procurement`.`vendor` SET TAGS ('dbx_subdomain' = 'supplier_contracts');
ALTER TABLE `mining_ecm`.`procurement`.`vendor` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Identifier');
ALTER TABLE `mining_ecm`.`procurement`.`vendor` ALTER COLUMN `abn` SET TAGS ('dbx_business_glossary_term' = 'Australian Business Number (ABN)');
ALTER TABLE `mining_ecm`.`procurement`.`vendor` ALTER COLUMN `abn` SET TAGS ('dbx_value_regex' = '^[0-9]{11}$');
ALTER TABLE `mining_ecm`.`procurement`.`vendor` ALTER COLUMN `acn` SET TAGS ('dbx_business_glossary_term' = 'Australian Company Number (ACN)');
ALTER TABLE `mining_ecm`.`procurement`.`vendor` ALTER COLUMN `acn` SET TAGS ('dbx_value_regex' = '^[0-9]{9}$');
ALTER TABLE `mining_ecm`.`procurement`.`vendor` ALTER COLUMN `approved_commodity_categories` SET TAGS ('dbx_business_glossary_term' = 'Approved Commodity Categories');
ALTER TABLE `mining_ecm`.`procurement`.`vendor` ALTER COLUMN `bank_account_name` SET TAGS ('dbx_business_glossary_term' = 'Bank Account Name');
ALTER TABLE `mining_ecm`.`procurement`.`vendor` ALTER COLUMN `bank_account_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`procurement`.`vendor` ALTER COLUMN `bank_account_number` SET TAGS ('dbx_business_glossary_term' = 'Bank Account Number');
ALTER TABLE `mining_ecm`.`procurement`.`vendor` ALTER COLUMN `bank_account_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `mining_ecm`.`procurement`.`vendor` ALTER COLUMN `bank_account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `mining_ecm`.`procurement`.`vendor` ALTER COLUMN `bank_name` SET TAGS ('dbx_business_glossary_term' = 'Bank Name');
ALTER TABLE `mining_ecm`.`procurement`.`vendor` ALTER COLUMN `bank_routing_code` SET TAGS ('dbx_business_glossary_term' = 'Bank Routing Code');
ALTER TABLE `mining_ecm`.`procurement`.`vendor` ALTER COLUMN `bank_routing_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`procurement`.`vendor` ALTER COLUMN `blacklist_date` SET TAGS ('dbx_business_glossary_term' = 'Blacklist Date');
ALTER TABLE `mining_ecm`.`procurement`.`vendor` ALTER COLUMN `blacklist_flag` SET TAGS ('dbx_business_glossary_term' = 'Blacklist Flag');
ALTER TABLE `mining_ecm`.`procurement`.`vendor` ALTER COLUMN `blacklist_reason` SET TAGS ('dbx_business_glossary_term' = 'Blacklist Reason');
ALTER TABLE `mining_ecm`.`procurement`.`vendor` ALTER COLUMN `certification_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Certification Expiry Date');
ALTER TABLE `mining_ecm`.`procurement`.`vendor` ALTER COLUMN `certification_status` SET TAGS ('dbx_business_glossary_term' = 'Vendor Certification Status');
ALTER TABLE `mining_ecm`.`procurement`.`vendor` ALTER COLUMN `certification_status` SET TAGS ('dbx_value_regex' = 'certified|not_certified|certification_pending|certification_expired');
ALTER TABLE `mining_ecm`.`procurement`.`vendor` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'Vendor City');
ALTER TABLE `mining_ecm`.`procurement`.`vendor` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`procurement`.`vendor` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `mining_ecm`.`procurement`.`vendor` ALTER COLUMN `classification` SET TAGS ('dbx_business_glossary_term' = 'Vendor Business Classification');
ALTER TABLE `mining_ecm`.`procurement`.`vendor` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Vendor Country Code');
ALTER TABLE `mining_ecm`.`procurement`.`vendor` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `mining_ecm`.`procurement`.`vendor` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_business_glossary_term' = 'Country of Origin');
ALTER TABLE `mining_ecm`.`procurement`.`vendor` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `mining_ecm`.`procurement`.`vendor` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `mining_ecm`.`procurement`.`vendor` ALTER COLUMN `credit_limit_amount` SET TAGS ('dbx_business_glossary_term' = 'Vendor Credit Limit Amount');
ALTER TABLE `mining_ecm`.`procurement`.`vendor` ALTER COLUMN `credit_rating` SET TAGS ('dbx_business_glossary_term' = 'Vendor Credit Rating');
ALTER TABLE `mining_ecm`.`procurement`.`vendor` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `mining_ecm`.`procurement`.`vendor` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `mining_ecm`.`procurement`.`vendor` ALTER COLUMN `incoterms_code` SET TAGS ('dbx_business_glossary_term' = 'International Commercial Terms (Incoterms) Code');
ALTER TABLE `mining_ecm`.`procurement`.`vendor` ALTER COLUMN `insurance_certificate_number` SET TAGS ('dbx_business_glossary_term' = 'Insurance Certificate Number');
ALTER TABLE `mining_ecm`.`procurement`.`vendor` ALTER COLUMN `insurance_coverage_amount` SET TAGS ('dbx_business_glossary_term' = 'Insurance Coverage Amount');
ALTER TABLE `mining_ecm`.`procurement`.`vendor` ALTER COLUMN `insurance_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Insurance Certificate Expiry Date');
ALTER TABLE `mining_ecm`.`procurement`.`vendor` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `mining_ecm`.`procurement`.`vendor` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Vendor Review Date');
ALTER TABLE `mining_ecm`.`procurement`.`vendor` ALTER COLUMN `legal_name` SET TAGS ('dbx_business_glossary_term' = 'Vendor Legal Name');
ALTER TABLE `mining_ecm`.`procurement`.`vendor` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Vendor Review Date');
ALTER TABLE `mining_ecm`.`procurement`.`vendor` ALTER COLUMN `onboarding_date` SET TAGS ('dbx_business_glossary_term' = 'Vendor Onboarding Date');
ALTER TABLE `mining_ecm`.`procurement`.`vendor` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `mining_ecm`.`procurement`.`vendor` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'eft|wire_transfer|cheque|credit_card|letter_of_credit');
ALTER TABLE `mining_ecm`.`procurement`.`vendor` ALTER COLUMN `payment_terms_code` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms Code');
ALTER TABLE `mining_ecm`.`procurement`.`vendor` ALTER COLUMN `payment_terms_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,6}$');
ALTER TABLE `mining_ecm`.`procurement`.`vendor` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Vendor Postal Code');
ALTER TABLE `mining_ecm`.`procurement`.`vendor` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`procurement`.`vendor` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `mining_ecm`.`procurement`.`vendor` ALTER COLUMN `preferred_vendor_flag` SET TAGS ('dbx_business_glossary_term' = 'Preferred Vendor Flag');
ALTER TABLE `mining_ecm`.`procurement`.`vendor` ALTER COLUMN `prequalification_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Prequalification Expiry Date');
ALTER TABLE `mining_ecm`.`procurement`.`vendor` ALTER COLUMN `prequalification_status` SET TAGS ('dbx_business_glossary_term' = 'Vendor Prequalification Status');
ALTER TABLE `mining_ecm`.`procurement`.`vendor` ALTER COLUMN `prequalification_status` SET TAGS ('dbx_value_regex' = 'prequalified|not_prequalified|expired|in_progress');
ALTER TABLE `mining_ecm`.`procurement`.`vendor` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Email Address');
ALTER TABLE `mining_ecm`.`procurement`.`vendor` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `mining_ecm`.`procurement`.`vendor` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`procurement`.`vendor` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `mining_ecm`.`procurement`.`vendor` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Name');
ALTER TABLE `mining_ecm`.`procurement`.`vendor` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `mining_ecm`.`procurement`.`vendor` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `mining_ecm`.`procurement`.`vendor` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Phone Number');
ALTER TABLE `mining_ecm`.`procurement`.`vendor` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`procurement`.`vendor` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `mining_ecm`.`procurement`.`vendor` ALTER COLUMN `risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Vendor Risk Rating');
ALTER TABLE `mining_ecm`.`procurement`.`vendor` ALTER COLUMN `risk_rating` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `mining_ecm`.`procurement`.`vendor` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'Vendor State or Province');
ALTER TABLE `mining_ecm`.`procurement`.`vendor` ALTER COLUMN `street_address` SET TAGS ('dbx_business_glossary_term' = 'Vendor Street Address');
ALTER TABLE `mining_ecm`.`procurement`.`vendor` ALTER COLUMN `street_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`procurement`.`vendor` ALTER COLUMN `street_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `mining_ecm`.`procurement`.`vendor` ALTER COLUMN `tax_registration_number` SET TAGS ('dbx_business_glossary_term' = 'Tax Registration Number');
ALTER TABLE `mining_ecm`.`procurement`.`vendor` ALTER COLUMN `tax_registration_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`procurement`.`vendor` ALTER COLUMN `trading_name` SET TAGS ('dbx_business_glossary_term' = 'Vendor Trading Name');
ALTER TABLE `mining_ecm`.`procurement`.`vendor` ALTER COLUMN `vendor_category` SET TAGS ('dbx_business_glossary_term' = 'Vendor Category');
ALTER TABLE `mining_ecm`.`procurement`.`vendor` ALTER COLUMN `vendor_code` SET TAGS ('dbx_business_glossary_term' = 'Vendor Code');
ALTER TABLE `mining_ecm`.`procurement`.`vendor` ALTER COLUMN `vendor_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,12}$');
ALTER TABLE `mining_ecm`.`procurement`.`vendor` ALTER COLUMN `vendor_status` SET TAGS ('dbx_business_glossary_term' = 'Vendor Status');
ALTER TABLE `mining_ecm`.`procurement`.`vendor` ALTER COLUMN `vendor_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|pending_approval|blacklisted|under_review');
ALTER TABLE `mining_ecm`.`procurement`.`purchase_order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `mining_ecm`.`procurement`.`purchase_order` SET TAGS ('dbx_subdomain' = 'purchase_requisition');
ALTER TABLE `mining_ecm`.`procurement`.`purchase_order` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Identifier');
ALTER TABLE `mining_ecm`.`procurement`.`purchase_order` ALTER COLUMN `capex_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Capex Budget Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`procurement`.`purchase_order` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`procurement`.`purchase_order` ALTER COLUMN `cost_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Centre Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`procurement`.`purchase_order` ALTER COLUMN `warehouse_location_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Warehouse Location Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`procurement`.`purchase_order` ALTER COLUMN `framework_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Blanket Agreement Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`procurement`.`purchase_order` ALTER COLUMN `general_ledger_account_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger Account Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`procurement`.`purchase_order` ALTER COLUMN `opex_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Opex Budget Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`procurement`.`purchase_order` ALTER COLUMN `price_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Price Schedule Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`procurement`.`purchase_order` ALTER COLUMN `requisition_id` SET TAGS ('dbx_business_glossary_term' = 'Requisition Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`procurement`.`purchase_order` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `mining_ecm`.`procurement`.`purchase_order` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Wbs Element Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`procurement`.`purchase_order` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `mining_ecm`.`procurement`.`purchase_order` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `mining_ecm`.`procurement`.`purchase_order` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected');
ALTER TABLE `mining_ecm`.`procurement`.`purchase_order` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `mining_ecm`.`procurement`.`purchase_order` ALTER COLUMN `company_code` SET TAGS ('dbx_business_glossary_term' = 'Company Code');
ALTER TABLE `mining_ecm`.`procurement`.`purchase_order` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `mining_ecm`.`procurement`.`purchase_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `mining_ecm`.`procurement`.`purchase_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `mining_ecm`.`procurement`.`purchase_order` ALTER COLUMN `deletion_indicator` SET TAGS ('dbx_business_glossary_term' = 'Deletion Indicator');
ALTER TABLE `mining_ecm`.`procurement`.`purchase_order` ALTER COLUMN `delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Delivery Date');
ALTER TABLE `mining_ecm`.`procurement`.`purchase_order` ALTER COLUMN `document_date` SET TAGS ('dbx_business_glossary_term' = 'Document Date');
ALTER TABLE `mining_ecm`.`procurement`.`purchase_order` ALTER COLUMN `expenditure_type` SET TAGS ('dbx_business_glossary_term' = 'Expenditure Type');
ALTER TABLE `mining_ecm`.`procurement`.`purchase_order` ALTER COLUMN `expenditure_type` SET TAGS ('dbx_value_regex' = 'OPEX|CAPEX');
ALTER TABLE `mining_ecm`.`procurement`.`purchase_order` ALTER COLUMN `incoterms` SET TAGS ('dbx_business_glossary_term' = 'Incoterms');
ALTER TABLE `mining_ecm`.`procurement`.`purchase_order` ALTER COLUMN `incoterms_code` SET TAGS ('dbx_business_glossary_term' = 'International Commercial Terms (INCOTERMS) Code');
ALTER TABLE `mining_ecm`.`procurement`.`purchase_order` ALTER COLUMN `incoterms_location` SET TAGS ('dbx_business_glossary_term' = 'Incoterms Location');
ALTER TABLE `mining_ecm`.`procurement`.`purchase_order` ALTER COLUMN `is_deleted` SET TAGS ('dbx_business_glossary_term' = 'Is Deleted');
ALTER TABLE `mining_ecm`.`procurement`.`purchase_order` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By');
ALTER TABLE `mining_ecm`.`procurement`.`purchase_order` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `mining_ecm`.`procurement`.`purchase_order` ALTER COLUMN `net_value` SET TAGS ('dbx_business_glossary_term' = 'Net Value');
ALTER TABLE `mining_ecm`.`procurement`.`purchase_order` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `mining_ecm`.`procurement`.`purchase_order` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `mining_ecm`.`procurement`.`purchase_order` ALTER COLUMN `payment_terms` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `mining_ecm`.`procurement`.`purchase_order` ALTER COLUMN `payment_terms_code` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms Code');
ALTER TABLE `mining_ecm`.`procurement`.`purchase_order` ALTER COLUMN `plant_code` SET TAGS ('dbx_business_glossary_term' = 'Plant Code');
ALTER TABLE `mining_ecm`.`procurement`.`purchase_order` ALTER COLUMN `plant_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `mining_ecm`.`procurement`.`purchase_order` ALTER COLUMN `po_date` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Date');
ALTER TABLE `mining_ecm`.`procurement`.`purchase_order` ALTER COLUMN `po_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Number');
ALTER TABLE `mining_ecm`.`procurement`.`purchase_order` ALTER COLUMN `po_status` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Status');
ALTER TABLE `mining_ecm`.`procurement`.`purchase_order` ALTER COLUMN `po_type` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Type');
ALTER TABLE `mining_ecm`.`procurement`.`purchase_order` ALTER COLUMN `po_type` SET TAGS ('dbx_value_regex' = 'standard|subcontracting|consignment|stock_transport|framework|service');
ALTER TABLE `mining_ecm`.`procurement`.`purchase_order` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Priority');
ALTER TABLE `mining_ecm`.`procurement`.`purchase_order` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'urgent|high|normal|low');
ALTER TABLE `mining_ecm`.`procurement`.`purchase_order` ALTER COLUMN `purchasing_group` SET TAGS ('dbx_business_glossary_term' = 'Purchasing Group');
ALTER TABLE `mining_ecm`.`procurement`.`purchase_order` ALTER COLUMN `purchasing_group` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3}$');
ALTER TABLE `mining_ecm`.`procurement`.`purchase_order` ALTER COLUMN `purchasing_organisation` SET TAGS ('dbx_business_glossary_term' = 'Purchasing Organisation');
ALTER TABLE `mining_ecm`.`procurement`.`purchase_order` ALTER COLUMN `purchasing_organisation` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `mining_ecm`.`procurement`.`purchase_order` ALTER COLUMN `purchasing_organization` SET TAGS ('dbx_business_glossary_term' = 'Purchasing Organization');
ALTER TABLE `mining_ecm`.`procurement`.`purchase_order` ALTER COLUMN `requested_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Requested Delivery Date');
ALTER TABLE `mining_ecm`.`procurement`.`purchase_order` ALTER COLUMN `shipping_instructions` SET TAGS ('dbx_business_glossary_term' = 'Shipping Instructions');
ALTER TABLE `mining_ecm`.`procurement`.`purchase_order` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `mining_ecm`.`procurement`.`purchase_order` ALTER COLUMN `total_value` SET TAGS ('dbx_business_glossary_term' = 'Total Value');
ALTER TABLE `mining_ecm`.`procurement`.`purchase_order` ALTER COLUMN `validity_end_date` SET TAGS ('dbx_business_glossary_term' = 'Validity End Date');
ALTER TABLE `mining_ecm`.`procurement`.`purchase_order` ALTER COLUMN `validity_start_date` SET TAGS ('dbx_business_glossary_term' = 'Validity Start Date');
ALTER TABLE `mining_ecm`.`procurement`.`purchase_order` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `mining_ecm`.`procurement`.`purchase_order_line` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `mining_ecm`.`procurement`.`purchase_order_line` SET TAGS ('dbx_subdomain' = 'purchase_requisition');
ALTER TABLE `mining_ecm`.`procurement`.`purchase_order_line` ALTER COLUMN `purchase_order_line_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Line Identifier');
ALTER TABLE `mining_ecm`.`procurement`.`purchase_order_line` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`procurement`.`purchase_order_line` ALTER COLUMN `cost_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Centre Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`procurement`.`purchase_order_line` ALTER COLUMN `general_ledger_account_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger Account Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`procurement`.`purchase_order_line` ALTER COLUMN `price_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Price Schedule Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`procurement`.`purchase_order_line` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Identifier');
ALTER TABLE `mining_ecm`.`procurement`.`purchase_order_line` ALTER COLUMN `requisition_id` SET TAGS ('dbx_business_glossary_term' = 'Requisition Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`procurement`.`purchase_order_line` ALTER COLUMN `specification_id` SET TAGS ('dbx_business_glossary_term' = 'Specification Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`procurement`.`purchase_order_line` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Identifier');
ALTER TABLE `mining_ecm`.`procurement`.`purchase_order_line` ALTER COLUMN `account_assignment_category` SET TAGS ('dbx_business_glossary_term' = 'Account Assignment Category');
ALTER TABLE `mining_ecm`.`procurement`.`purchase_order_line` ALTER COLUMN `account_assignment_category` SET TAGS ('dbx_value_regex' = 'cost_centre|project|asset|order');
ALTER TABLE `mining_ecm`.`procurement`.`purchase_order_line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `mining_ecm`.`procurement`.`purchase_order_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `mining_ecm`.`procurement`.`purchase_order_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `mining_ecm`.`procurement`.`purchase_order_line` ALTER COLUMN `deletion_indicator` SET TAGS ('dbx_business_glossary_term' = 'Deletion Indicator Flag');
ALTER TABLE `mining_ecm`.`procurement`.`purchase_order_line` ALTER COLUMN `delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Delivery Date');
ALTER TABLE `mining_ecm`.`procurement`.`purchase_order_line` ALTER COLUMN `final_invoice_indicator` SET TAGS ('dbx_business_glossary_term' = 'Final Invoice Indicator Flag');
ALTER TABLE `mining_ecm`.`procurement`.`purchase_order_line` ALTER COLUMN `goods_receipt_indicator` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt (GR) Required Indicator');
ALTER TABLE `mining_ecm`.`procurement`.`purchase_order_line` ALTER COLUMN `goods_receipt_quantity` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt (GR) Quantity');
ALTER TABLE `mining_ecm`.`procurement`.`purchase_order_line` ALTER COLUMN `incoterm` SET TAGS ('dbx_business_glossary_term' = 'Incoterm Code');
ALTER TABLE `mining_ecm`.`procurement`.`purchase_order_line` ALTER COLUMN `invoice_quantity` SET TAGS ('dbx_business_glossary_term' = 'Invoice Receipt (IR) Quantity');
ALTER TABLE `mining_ecm`.`procurement`.`purchase_order_line` ALTER COLUMN `invoice_receipt_indicator` SET TAGS ('dbx_business_glossary_term' = 'Invoice Receipt (IR) Required Indicator');
ALTER TABLE `mining_ecm`.`procurement`.`purchase_order_line` ALTER COLUMN `line_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Line Number');
ALTER TABLE `mining_ecm`.`procurement`.`purchase_order_line` ALTER COLUMN `line_status` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Line Status');
ALTER TABLE `mining_ecm`.`procurement`.`purchase_order_line` ALTER COLUMN `line_status` SET TAGS ('dbx_value_regex' = 'open|partially_received|fully_received|closed|cancelled');
ALTER TABLE `mining_ecm`.`procurement`.`purchase_order_line` ALTER COLUMN `material_group` SET TAGS ('dbx_business_glossary_term' = 'Material Group Code');
ALTER TABLE `mining_ecm`.`procurement`.`purchase_order_line` ALTER COLUMN `material_number` SET TAGS ('dbx_business_glossary_term' = 'Material Number');
ALTER TABLE `mining_ecm`.`procurement`.`purchase_order_line` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `mining_ecm`.`procurement`.`purchase_order_line` ALTER COLUMN `net_order_value` SET TAGS ('dbx_business_glossary_term' = 'Net Order Value');
ALTER TABLE `mining_ecm`.`procurement`.`purchase_order_line` ALTER COLUMN `net_price` SET TAGS ('dbx_business_glossary_term' = 'Net Unit Price');
ALTER TABLE `mining_ecm`.`procurement`.`purchase_order_line` ALTER COLUMN `outstanding_quantity` SET TAGS ('dbx_business_glossary_term' = 'Outstanding Quantity');
ALTER TABLE `mining_ecm`.`procurement`.`purchase_order_line` ALTER COLUMN `over_delivery_tolerance_percent` SET TAGS ('dbx_business_glossary_term' = 'Over-Delivery Tolerance Percentage');
ALTER TABLE `mining_ecm`.`procurement`.`purchase_order_line` ALTER COLUMN `plant_code` SET TAGS ('dbx_business_glossary_term' = 'Plant Code');
ALTER TABLE `mining_ecm`.`procurement`.`purchase_order_line` ALTER COLUMN `price_unit` SET TAGS ('dbx_business_glossary_term' = 'Price Unit Quantity');
ALTER TABLE `mining_ecm`.`procurement`.`purchase_order_line` ALTER COLUMN `purchasing_group` SET TAGS ('dbx_business_glossary_term' = 'Purchasing Group Code');
ALTER TABLE `mining_ecm`.`procurement`.`purchase_order_line` ALTER COLUMN `quantity_ordered` SET TAGS ('dbx_business_glossary_term' = 'Quantity Ordered');
ALTER TABLE `mining_ecm`.`procurement`.`purchase_order_line` ALTER COLUMN `short_text` SET TAGS ('dbx_business_glossary_term' = 'Material Short Text Description');
ALTER TABLE `mining_ecm`.`procurement`.`purchase_order_line` ALTER COLUMN `storage_location` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Code');
ALTER TABLE `mining_ecm`.`procurement`.`purchase_order_line` ALTER COLUMN `tax_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Code');
ALTER TABLE `mining_ecm`.`procurement`.`purchase_order_line` ALTER COLUMN `under_delivery_tolerance_percent` SET TAGS ('dbx_business_glossary_term' = 'Under-Delivery Tolerance Percentage');
ALTER TABLE `mining_ecm`.`procurement`.`purchase_order_line` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `mining_ecm`.`procurement`.`goods_receipt` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `mining_ecm`.`procurement`.`goods_receipt` SET TAGS ('dbx_subdomain' = 'inventory_movement');
ALTER TABLE `mining_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `goods_receipt_id` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt Identifier');
ALTER TABLE `mining_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `cost_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Centre Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `delivery_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Schedule Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `inbound_delivery_id` SET TAGS ('dbx_business_glossary_term' = 'Inbound Delivery Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant ID');
ALTER TABLE `mining_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) ID');
ALTER TABLE `mining_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `purchase_order_line_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Line ID');
ALTER TABLE `mining_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `stock_transfer_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Transfer Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material ID');
ALTER TABLE `mining_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `mining_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `warehouse_location_id` SET TAGS ('dbx_business_glossary_term' = 'Storage Location ID');
ALTER TABLE `mining_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Wbs Element Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Number');
ALTER TABLE `mining_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `bill_of_lading_number` SET TAGS ('dbx_business_glossary_term' = 'Bill of Lading (BOL) Number');
ALTER TABLE `mining_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `certificate_of_analysis_number` SET TAGS ('dbx_business_glossary_term' = 'Certificate of Analysis (COA) Number');
ALTER TABLE `mining_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `mining_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `mining_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `mining_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `mining_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `document_date` SET TAGS ('dbx_business_glossary_term' = 'Document Date');
ALTER TABLE `mining_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `goods_receipt_status` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt (GR) Status');
ALTER TABLE `mining_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `goods_receipt_status` SET TAGS ('dbx_value_regex' = 'posted|reversed|cancelled|pending_inspection|completed');
ALTER TABLE `mining_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `gr_document_number` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt (GR) Document Number');
ALTER TABLE `mining_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `gr_document_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{10}$');
ALTER TABLE `mining_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `gr_document_year` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt (GR) Document Year');
ALTER TABLE `mining_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `gr_line_item_number` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt (GR) Line Item Number');
ALTER TABLE `mining_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `gross_weight` SET TAGS ('dbx_business_glossary_term' = 'Gross Weight');
ALTER TABLE `mining_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `inspection_lot_number` SET TAGS ('dbx_business_glossary_term' = 'Inspection Lot Number');
ALTER TABLE `mining_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `last_modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `mining_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `mining_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `line_item_number` SET TAGS ('dbx_business_glossary_term' = 'Line Item Number');
ALTER TABLE `mining_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `material_document_number` SET TAGS ('dbx_business_glossary_term' = 'Material Document Number');
ALTER TABLE `mining_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `material_document_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{10}$');
ALTER TABLE `mining_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `material_document_year` SET TAGS ('dbx_business_glossary_term' = 'Material Document Year');
ALTER TABLE `mining_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `mining_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `movement_indicator` SET TAGS ('dbx_business_glossary_term' = 'Movement Indicator');
ALTER TABLE `mining_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `movement_indicator` SET TAGS ('dbx_value_regex' = '^[A-Z]$');
ALTER TABLE `mining_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `movement_type` SET TAGS ('dbx_business_glossary_term' = 'Movement Type');
ALTER TABLE `mining_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `movement_type` SET TAGS ('dbx_value_regex' = '^[0-9]{3}$');
ALTER TABLE `mining_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `net_weight` SET TAGS ('dbx_business_glossary_term' = 'Net Weight');
ALTER TABLE `mining_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Date');
ALTER TABLE `mining_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `quality_inspection_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Quality Inspection Required Flag');
ALTER TABLE `mining_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `quantity_ordered` SET TAGS ('dbx_business_glossary_term' = 'Quantity Ordered');
ALTER TABLE `mining_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `quantity_received` SET TAGS ('dbx_business_glossary_term' = 'Quantity Received');
ALTER TABLE `mining_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `receipt_condition` SET TAGS ('dbx_business_glossary_term' = 'Receipt Condition');
ALTER TABLE `mining_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `receipt_condition` SET TAGS ('dbx_value_regex' = 'acceptable|damaged|short_shipped|over_shipped|partial');
ALTER TABLE `mining_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `received_date` SET TAGS ('dbx_business_glossary_term' = 'Received Date');
ALTER TABLE `mining_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `receiving_person_name` SET TAGS ('dbx_business_glossary_term' = 'Receiving Person Name');
ALTER TABLE `mining_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `receiving_person_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `mining_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `receiving_person_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `mining_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `remarks` SET TAGS ('dbx_business_glossary_term' = 'Remarks');
ALTER TABLE `mining_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `reversal_document_number` SET TAGS ('dbx_business_glossary_term' = 'Reversal Document Number');
ALTER TABLE `mining_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `reversal_indicator` SET TAGS ('dbx_business_glossary_term' = 'Reversal Indicator');
ALTER TABLE `mining_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `reversal_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Reversal Reason Code');
ALTER TABLE `mining_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `serial_number` SET TAGS ('dbx_business_glossary_term' = 'Serial Number');
ALTER TABLE `mining_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `stock_type` SET TAGS ('dbx_business_glossary_term' = 'Stock Type');
ALTER TABLE `mining_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `stock_type` SET TAGS ('dbx_value_regex' = 'unrestricted|quality_inspection|blocked|restricted');
ALTER TABLE `mining_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `tare_weight` SET TAGS ('dbx_business_glossary_term' = 'Tare Weight');
ALTER TABLE `mining_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `mining_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,3}$');
ALTER TABLE `mining_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `unloading_point` SET TAGS ('dbx_business_glossary_term' = 'Unloading Point');
ALTER TABLE `mining_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `valuation_amount` SET TAGS ('dbx_business_glossary_term' = 'Valuation Amount');
ALTER TABLE `mining_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `valuation_type` SET TAGS ('dbx_business_glossary_term' = 'Valuation Type');
ALTER TABLE `mining_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `vendor_batch_number` SET TAGS ('dbx_business_glossary_term' = 'Vendor Batch Number');
ALTER TABLE `mining_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `weight_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Weight Unit of Measure');
ALTER TABLE `mining_ecm`.`procurement`.`goods_receipt` ALTER COLUMN `weight_unit_of_measure` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,3}$');
ALTER TABLE `mining_ecm`.`procurement`.`goods_issue` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `mining_ecm`.`procurement`.`goods_issue` SET TAGS ('dbx_subdomain' = 'inventory_movement');
ALTER TABLE `mining_ecm`.`procurement`.`goods_issue` ALTER COLUMN `goods_issue_id` SET TAGS ('dbx_business_glossary_term' = 'Goods Issue Identifier (ID)');
ALTER TABLE `mining_ecm`.`procurement`.`goods_issue` ALTER COLUMN `area_id` SET TAGS ('dbx_business_glossary_term' = 'Mine Area Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`procurement`.`goods_issue` ALTER COLUMN `blast_execution_id` SET TAGS ('dbx_business_glossary_term' = 'Blast Execution Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`procurement`.`goods_issue` ALTER COLUMN `cost_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Centre Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`procurement`.`goods_issue` ALTER COLUMN `drill_hole_id` SET TAGS ('dbx_business_glossary_term' = 'Drill Hole Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`procurement`.`goods_issue` ALTER COLUMN `freight_order_id` SET TAGS ('dbx_business_glossary_term' = 'Freight Order Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`procurement`.`goods_issue` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Transport Order Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`procurement`.`goods_issue` ALTER COLUMN `purchase_order_line_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Line Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`procurement`.`goods_issue` ALTER COLUMN `rom_stockpile_id` SET TAGS ('dbx_business_glossary_term' = 'Rom Stockpile Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`procurement`.`goods_issue` ALTER COLUMN `shift_report_id` SET TAGS ('dbx_business_glossary_term' = 'Shift Report Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`procurement`.`goods_issue` ALTER COLUMN `stock_transfer_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Transfer Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`procurement`.`goods_issue` ALTER COLUMN `stope_design_id` SET TAGS ('dbx_business_glossary_term' = 'Stope Design Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`procurement`.`goods_issue` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Supply Material Master Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`procurement`.`goods_issue` ALTER COLUMN `warehouse_location_id` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`procurement`.`goods_issue` ALTER COLUMN `waste_dump_id` SET TAGS ('dbx_business_glossary_term' = 'Waste Dump Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`procurement`.`goods_issue` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Wbs Element Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`procurement`.`goods_issue` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Number');
ALTER TABLE `mining_ecm`.`procurement`.`goods_issue` ALTER COLUMN `batch_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{10}$');
ALTER TABLE `mining_ecm`.`procurement`.`goods_issue` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User Identifier (ID)');
ALTER TABLE `mining_ecm`.`procurement`.`goods_issue` ALTER COLUMN `created_by_user` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{12}$');
ALTER TABLE `mining_ecm`.`procurement`.`goods_issue` ALTER COLUMN `delivery_number` SET TAGS ('dbx_business_glossary_term' = 'Delivery Document Number');
ALTER TABLE `mining_ecm`.`procurement`.`goods_issue` ALTER COLUMN `delivery_number` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `mining_ecm`.`procurement`.`goods_issue` ALTER COLUMN `document_date` SET TAGS ('dbx_business_glossary_term' = 'Document Date');
ALTER TABLE `mining_ecm`.`procurement`.`goods_issue` ALTER COLUMN `entry_date` SET TAGS ('dbx_business_glossary_term' = 'Entry Date');
ALTER TABLE `mining_ecm`.`procurement`.`goods_issue` ALTER COLUMN `entry_time` SET TAGS ('dbx_business_glossary_term' = 'Entry Time');
ALTER TABLE `mining_ecm`.`procurement`.`goods_issue` ALTER COLUMN `goods_recipient` SET TAGS ('dbx_business_glossary_term' = 'Goods Recipient Name');
ALTER TABLE `mining_ecm`.`procurement`.`goods_issue` ALTER COLUMN `header_text` SET TAGS ('dbx_business_glossary_term' = 'Header Text');
ALTER TABLE `mining_ecm`.`procurement`.`goods_issue` ALTER COLUMN `material_document_item` SET TAGS ('dbx_business_glossary_term' = 'Material Document Item Number');
ALTER TABLE `mining_ecm`.`procurement`.`goods_issue` ALTER COLUMN `material_document_number` SET TAGS ('dbx_business_glossary_term' = 'Material Document Number');
ALTER TABLE `mining_ecm`.`procurement`.`goods_issue` ALTER COLUMN `material_document_number` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `mining_ecm`.`procurement`.`goods_issue` ALTER COLUMN `material_document_year` SET TAGS ('dbx_business_glossary_term' = 'Material Document Year');
ALTER TABLE `mining_ecm`.`procurement`.`goods_issue` ALTER COLUMN `movement_indicator` SET TAGS ('dbx_business_glossary_term' = 'Movement Indicator');
ALTER TABLE `mining_ecm`.`procurement`.`goods_issue` ALTER COLUMN `movement_indicator` SET TAGS ('dbx_value_regex' = '^[A-Z]$');
ALTER TABLE `mining_ecm`.`procurement`.`goods_issue` ALTER COLUMN `movement_status` SET TAGS ('dbx_business_glossary_term' = 'Movement Status');
ALTER TABLE `mining_ecm`.`procurement`.`goods_issue` ALTER COLUMN `movement_status` SET TAGS ('dbx_value_regex' = 'posted|reversed|cancelled|pending');
ALTER TABLE `mining_ecm`.`procurement`.`goods_issue` ALTER COLUMN `movement_type` SET TAGS ('dbx_business_glossary_term' = 'Movement Type');
ALTER TABLE `mining_ecm`.`procurement`.`goods_issue` ALTER COLUMN `movement_type` SET TAGS ('dbx_value_regex' = '^[0-9]{3}$');
ALTER TABLE `mining_ecm`.`procurement`.`goods_issue` ALTER COLUMN `plant_code` SET TAGS ('dbx_business_glossary_term' = 'Issuing Plant Code');
ALTER TABLE `mining_ecm`.`procurement`.`goods_issue` ALTER COLUMN `plant_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `mining_ecm`.`procurement`.`goods_issue` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Date');
ALTER TABLE `mining_ecm`.`procurement`.`goods_issue` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity Issued');
ALTER TABLE `mining_ecm`.`procurement`.`goods_issue` ALTER COLUMN `reason_code` SET TAGS ('dbx_business_glossary_term' = 'Reason Code for Movement');
ALTER TABLE `mining_ecm`.`procurement`.`goods_issue` ALTER COLUMN `reason_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `mining_ecm`.`procurement`.`goods_issue` ALTER COLUMN `receiving_plant_code` SET TAGS ('dbx_business_glossary_term' = 'Receiving Plant Code');
ALTER TABLE `mining_ecm`.`procurement`.`goods_issue` ALTER COLUMN `receiving_plant_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `mining_ecm`.`procurement`.`goods_issue` ALTER COLUMN `receiving_storage_location_code` SET TAGS ('dbx_business_glossary_term' = 'Receiving Storage Location Code');
ALTER TABLE `mining_ecm`.`procurement`.`goods_issue` ALTER COLUMN `receiving_storage_location_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `mining_ecm`.`procurement`.`goods_issue` ALTER COLUMN `reference_document_number` SET TAGS ('dbx_business_glossary_term' = 'Reference Document Number');
ALTER TABLE `mining_ecm`.`procurement`.`goods_issue` ALTER COLUMN `reservation_item` SET TAGS ('dbx_business_glossary_term' = 'Reservation Item Number');
ALTER TABLE `mining_ecm`.`procurement`.`goods_issue` ALTER COLUMN `reservation_number` SET TAGS ('dbx_business_glossary_term' = 'Reservation Number');
ALTER TABLE `mining_ecm`.`procurement`.`goods_issue` ALTER COLUMN `reservation_number` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `mining_ecm`.`procurement`.`goods_issue` ALTER COLUMN `reversal_indicator` SET TAGS ('dbx_business_glossary_term' = 'Reversal Indicator');
ALTER TABLE `mining_ecm`.`procurement`.`goods_issue` ALTER COLUMN `reversal_movement_type` SET TAGS ('dbx_business_glossary_term' = 'Reversal Movement Type');
ALTER TABLE `mining_ecm`.`procurement`.`goods_issue` ALTER COLUMN `reversal_movement_type` SET TAGS ('dbx_value_regex' = '^[0-9]{3}$');
ALTER TABLE `mining_ecm`.`procurement`.`goods_issue` ALTER COLUMN `special_stock_indicator` SET TAGS ('dbx_business_glossary_term' = 'Special Stock Indicator');
ALTER TABLE `mining_ecm`.`procurement`.`goods_issue` ALTER COLUMN `special_stock_indicator` SET TAGS ('dbx_value_regex' = '^[A-Z]$');
ALTER TABLE `mining_ecm`.`procurement`.`goods_issue` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `mining_ecm`.`procurement`.`goods_issue` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,3}$');
ALTER TABLE `mining_ecm`.`procurement`.`goods_issue` ALTER COLUMN `unloading_point` SET TAGS ('dbx_business_glossary_term' = 'Unloading Point');
ALTER TABLE `mining_ecm`.`procurement`.`goods_issue` ALTER COLUMN `valuation_type` SET TAGS ('dbx_business_glossary_term' = 'Valuation Type');
ALTER TABLE `mining_ecm`.`procurement`.`goods_issue` ALTER COLUMN `valuation_type` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{10}$');
ALTER TABLE `mining_ecm`.`procurement`.`goods_issue` ALTER COLUMN `work_order_number` SET TAGS ('dbx_business_glossary_term' = 'Work Order Number');
ALTER TABLE `mining_ecm`.`procurement`.`goods_issue` ALTER COLUMN `work_order_number` SET TAGS ('dbx_value_regex' = '^[0-9]{12}$');
ALTER TABLE `mining_ecm`.`procurement`.`inventory_balance` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `mining_ecm`.`procurement`.`inventory_balance` SET TAGS ('dbx_subdomain' = 'inventory_movement');
ALTER TABLE `mining_ecm`.`procurement`.`inventory_balance` ALTER COLUMN `inventory_balance_id` SET TAGS ('dbx_business_glossary_term' = 'Inventory Balance ID');
ALTER TABLE `mining_ecm`.`procurement`.`inventory_balance` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant ID');
ALTER TABLE `mining_ecm`.`procurement`.`inventory_balance` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material ID');
ALTER TABLE `mining_ecm`.`procurement`.`inventory_balance` ALTER COLUMN `warehouse_location_id` SET TAGS ('dbx_business_glossary_term' = 'Storage Location ID');
ALTER TABLE `mining_ecm`.`procurement`.`inventory_balance` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Number');
ALTER TABLE `mining_ecm`.`procurement`.`inventory_balance` ALTER COLUMN `blocked_stock_quantity` SET TAGS ('dbx_business_glossary_term' = 'Blocked Stock Quantity');
ALTER TABLE `mining_ecm`.`procurement`.`inventory_balance` ALTER COLUMN `count_cycle_code` SET TAGS ('dbx_business_glossary_term' = 'Count Cycle Code');
ALTER TABLE `mining_ecm`.`procurement`.`inventory_balance` ALTER COLUMN `count_frequency_category` SET TAGS ('dbx_business_glossary_term' = 'Count Frequency Category');
ALTER TABLE `mining_ecm`.`procurement`.`inventory_balance` ALTER COLUMN `counted_quantity` SET TAGS ('dbx_business_glossary_term' = 'Counted Quantity');
ALTER TABLE `mining_ecm`.`procurement`.`inventory_balance` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `mining_ecm`.`procurement`.`inventory_balance` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `mining_ecm`.`procurement`.`inventory_balance` ALTER COLUMN `in_transit_stock_quantity` SET TAGS ('dbx_business_glossary_term' = 'In-Transit Stock Quantity');
ALTER TABLE `mining_ecm`.`procurement`.`inventory_balance` ALTER COLUMN `last_count_date` SET TAGS ('dbx_business_glossary_term' = 'Last Count Date');
ALTER TABLE `mining_ecm`.`procurement`.`inventory_balance` ALTER COLUMN `last_goods_issue_date` SET TAGS ('dbx_business_glossary_term' = 'Last Goods Issue Date');
ALTER TABLE `mining_ecm`.`procurement`.`inventory_balance` ALTER COLUMN `last_goods_receipt_date` SET TAGS ('dbx_business_glossary_term' = 'Last Goods Receipt Date');
ALTER TABLE `mining_ecm`.`procurement`.`inventory_balance` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `mining_ecm`.`procurement`.`inventory_balance` ALTER COLUMN `maximum_stock_level_quantity` SET TAGS ('dbx_business_glossary_term' = 'Maximum Stock Level Quantity');
ALTER TABLE `mining_ecm`.`procurement`.`inventory_balance` ALTER COLUMN `physical_inventory_document_number` SET TAGS ('dbx_business_glossary_term' = 'Physical Inventory Document Number');
ALTER TABLE `mining_ecm`.`procurement`.`inventory_balance` ALTER COLUMN `posting_status` SET TAGS ('dbx_business_glossary_term' = 'Posting Status');
ALTER TABLE `mining_ecm`.`procurement`.`inventory_balance` ALTER COLUMN `posting_status` SET TAGS ('dbx_value_regex' = 'not_posted|posted|partially_posted|reversed');
ALTER TABLE `mining_ecm`.`procurement`.`inventory_balance` ALTER COLUMN `quality_inspection_stock_quantity` SET TAGS ('dbx_business_glossary_term' = 'Quality Inspection Stock Quantity');
ALTER TABLE `mining_ecm`.`procurement`.`inventory_balance` ALTER COLUMN `recount_flag` SET TAGS ('dbx_business_glossary_term' = 'Recount Flag');
ALTER TABLE `mining_ecm`.`procurement`.`inventory_balance` ALTER COLUMN `reorder_point_quantity` SET TAGS ('dbx_business_glossary_term' = 'Reorder Point Quantity');
ALTER TABLE `mining_ecm`.`procurement`.`inventory_balance` ALTER COLUMN `safety_stock_quantity` SET TAGS ('dbx_business_glossary_term' = 'Safety Stock Quantity');
ALTER TABLE `mining_ecm`.`procurement`.`inventory_balance` ALTER COLUMN `snapshot_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Snapshot Timestamp');
ALTER TABLE `mining_ecm`.`procurement`.`inventory_balance` ALTER COLUMN `stock_accuracy_percentage` SET TAGS ('dbx_business_glossary_term' = 'Stock Accuracy Percentage');
ALTER TABLE `mining_ecm`.`procurement`.`inventory_balance` ALTER COLUMN `stock_status` SET TAGS ('dbx_business_glossary_term' = 'Stock Status');
ALTER TABLE `mining_ecm`.`procurement`.`inventory_balance` ALTER COLUMN `stock_status` SET TAGS ('dbx_value_regex' = 'available|low_stock|out_of_stock|excess|obsolete');
ALTER TABLE `mining_ecm`.`procurement`.`inventory_balance` ALTER COLUMN `storage_location_code` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Code');
ALTER TABLE `mining_ecm`.`procurement`.`inventory_balance` ALTER COLUMN `system_quantity_at_count` SET TAGS ('dbx_business_glossary_term' = 'System Quantity at Count');
ALTER TABLE `mining_ecm`.`procurement`.`inventory_balance` ALTER COLUMN `total_stock_value` SET TAGS ('dbx_business_glossary_term' = 'Total Stock Value');
ALTER TABLE `mining_ecm`.`procurement`.`inventory_balance` ALTER COLUMN `total_stock_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`procurement`.`inventory_balance` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `mining_ecm`.`procurement`.`inventory_balance` ALTER COLUMN `unrestricted_stock_quantity` SET TAGS ('dbx_business_glossary_term' = 'Unrestricted Stock Quantity');
ALTER TABLE `mining_ecm`.`procurement`.`inventory_balance` ALTER COLUMN `valuation_type` SET TAGS ('dbx_business_glossary_term' = 'Valuation Type');
ALTER TABLE `mining_ecm`.`procurement`.`inventory_balance` ALTER COLUMN `valuation_type` SET TAGS ('dbx_value_regex' = 'standard_cost|moving_average|fifo|lifo');
ALTER TABLE `mining_ecm`.`procurement`.`inventory_balance` ALTER COLUMN `variance_quantity` SET TAGS ('dbx_business_glossary_term' = 'Variance Quantity');
ALTER TABLE `mining_ecm`.`procurement`.`inventory_balance` ALTER COLUMN `variance_value` SET TAGS ('dbx_business_glossary_term' = 'Variance Value');
ALTER TABLE `mining_ecm`.`procurement`.`inventory_balance` ALTER COLUMN `variance_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`procurement`.`stock_transfer` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `mining_ecm`.`procurement`.`stock_transfer` SET TAGS ('dbx_subdomain' = 'inventory_movement');
ALTER TABLE `mining_ecm`.`procurement`.`stock_transfer` ALTER COLUMN `stock_transfer_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Transfer ID');
ALTER TABLE `mining_ecm`.`procurement`.`stock_transfer` ALTER COLUMN `cost_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Centre ID');
ALTER TABLE `mining_ecm`.`procurement`.`stock_transfer` ALTER COLUMN `delivery_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Schedule Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`procurement`.`stock_transfer` ALTER COLUMN `freight_order_id` SET TAGS ('dbx_business_glossary_term' = 'Freight Order Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`procurement`.`stock_transfer` ALTER COLUMN `warehouse_location_id` SET TAGS ('dbx_business_glossary_term' = 'Sending Storage Location ID');
ALTER TABLE `mining_ecm`.`procurement`.`stock_transfer` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`procurement`.`stock_transfer` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Receiving Plant ID');
ALTER TABLE `mining_ecm`.`procurement`.`stock_transfer` ALTER COLUMN `receiving_storage_location_warehouse_location_id` SET TAGS ('dbx_business_glossary_term' = 'Receiving Storage Location ID');
ALTER TABLE `mining_ecm`.`procurement`.`stock_transfer` ALTER COLUMN `sending_plant_id` SET TAGS ('dbx_business_glossary_term' = 'Sending Plant ID');
ALTER TABLE `mining_ecm`.`procurement`.`stock_transfer` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material ID');
ALTER TABLE `mining_ecm`.`procurement`.`stock_transfer` ALTER COLUMN `actual_receipt_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Receipt Date');
ALTER TABLE `mining_ecm`.`procurement`.`stock_transfer` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Number');
ALTER TABLE `mining_ecm`.`procurement`.`stock_transfer` ALTER COLUMN `carrier_name` SET TAGS ('dbx_business_glossary_term' = 'Carrier Name');
ALTER TABLE `mining_ecm`.`procurement`.`stock_transfer` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `mining_ecm`.`procurement`.`stock_transfer` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `mining_ecm`.`procurement`.`stock_transfer` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `mining_ecm`.`procurement`.`stock_transfer` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `mining_ecm`.`procurement`.`stock_transfer` ALTER COLUMN `goods_issue_posted_flag` SET TAGS ('dbx_business_glossary_term' = 'Goods Issue Posted Flag');
ALTER TABLE `mining_ecm`.`procurement`.`stock_transfer` ALTER COLUMN `goods_receipt_posted_flag` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt Posted Flag');
ALTER TABLE `mining_ecm`.`procurement`.`stock_transfer` ALTER COLUMN `last_modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `mining_ecm`.`procurement`.`stock_transfer` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `mining_ecm`.`procurement`.`stock_transfer` ALTER COLUMN `material_description` SET TAGS ('dbx_business_glossary_term' = 'Material Description');
ALTER TABLE `mining_ecm`.`procurement`.`stock_transfer` ALTER COLUMN `movement_type` SET TAGS ('dbx_business_glossary_term' = 'Movement Type');
ALTER TABLE `mining_ecm`.`procurement`.`stock_transfer` ALTER COLUMN `movement_type` SET TAGS ('dbx_value_regex' = '^[0-9]{3}$');
ALTER TABLE `mining_ecm`.`procurement`.`stock_transfer` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Transfer Priority');
ALTER TABLE `mining_ecm`.`procurement`.`stock_transfer` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'low|normal|high|urgent|critical');
ALTER TABLE `mining_ecm`.`procurement`.`stock_transfer` ALTER COLUMN `reason_code` SET TAGS ('dbx_business_glossary_term' = 'Reason Code');
ALTER TABLE `mining_ecm`.`procurement`.`stock_transfer` ALTER COLUMN `receiving_storage_location_code` SET TAGS ('dbx_business_glossary_term' = 'Receiving Storage Location Code');
ALTER TABLE `mining_ecm`.`procurement`.`stock_transfer` ALTER COLUMN `receiving_storage_location_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `mining_ecm`.`procurement`.`stock_transfer` ALTER COLUMN `requested_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Requested Delivery Date');
ALTER TABLE `mining_ecm`.`procurement`.`stock_transfer` ALTER COLUMN `sending_storage_location_code` SET TAGS ('dbx_business_glossary_term' = 'Sending Storage Location Code');
ALTER TABLE `mining_ecm`.`procurement`.`stock_transfer` ALTER COLUMN `sending_storage_location_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `mining_ecm`.`procurement`.`stock_transfer` ALTER COLUMN `serial_number` SET TAGS ('dbx_business_glossary_term' = 'Serial Number');
ALTER TABLE `mining_ecm`.`procurement`.`stock_transfer` ALTER COLUMN `special_stock_indicator` SET TAGS ('dbx_business_glossary_term' = 'Special Stock Indicator');
ALTER TABLE `mining_ecm`.`procurement`.`stock_transfer` ALTER COLUMN `transfer_date` SET TAGS ('dbx_business_glossary_term' = 'Transfer Date');
ALTER TABLE `mining_ecm`.`procurement`.`stock_transfer` ALTER COLUMN `transfer_order_number` SET TAGS ('dbx_business_glossary_term' = 'Stock Transfer Order (STO) Number');
ALTER TABLE `mining_ecm`.`procurement`.`stock_transfer` ALTER COLUMN `transfer_order_number` SET TAGS ('dbx_value_regex' = '^STO[0-9]{10}$');
ALTER TABLE `mining_ecm`.`procurement`.`stock_transfer` ALTER COLUMN `transfer_quantity` SET TAGS ('dbx_business_glossary_term' = 'Transfer Quantity');
ALTER TABLE `mining_ecm`.`procurement`.`stock_transfer` ALTER COLUMN `transfer_status` SET TAGS ('dbx_business_glossary_term' = 'Transfer Status');
ALTER TABLE `mining_ecm`.`procurement`.`stock_transfer` ALTER COLUMN `transfer_status` SET TAGS ('dbx_value_regex' = 'draft|released|in_transit|partially_received|completed|cancelled');
ALTER TABLE `mining_ecm`.`procurement`.`stock_transfer` ALTER COLUMN `transfer_type` SET TAGS ('dbx_business_glossary_term' = 'Transfer Type');
ALTER TABLE `mining_ecm`.`procurement`.`stock_transfer` ALTER COLUMN `transfer_type` SET TAGS ('dbx_value_regex' = 'plant_to_plant|storage_location_to_storage_location|site_to_site|warehouse_to_mine|central_to_remote');
ALTER TABLE `mining_ecm`.`procurement`.`stock_transfer` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `mining_ecm`.`procurement`.`stock_transfer` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,3}$');
ALTER TABLE `mining_ecm`.`procurement`.`stock_transfer` ALTER COLUMN `valuation_amount` SET TAGS ('dbx_business_glossary_term' = 'Valuation Amount');
ALTER TABLE `mining_ecm`.`procurement`.`stock_transfer` ALTER COLUMN `valuation_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`procurement`.`stock_transfer` ALTER COLUMN `vehicle_registration` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Registration Number');
ALTER TABLE `mining_ecm`.`procurement`.`warehouse_location` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `mining_ecm`.`procurement`.`warehouse_location` SET TAGS ('dbx_subdomain' = 'inventory_movement');
ALTER TABLE `mining_ecm`.`procurement`.`warehouse_location` ALTER COLUMN `warehouse_location_id` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Location Identifier (ID)');
ALTER TABLE `mining_ecm`.`procurement`.`warehouse_location` ALTER COLUMN `cost_centre_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `mining_ecm`.`procurement`.`warehouse_location` ALTER COLUMN `mine_site_id` SET TAGS ('dbx_business_glossary_term' = 'Site Identifier (ID)');
ALTER TABLE `mining_ecm`.`procurement`.`warehouse_location` ALTER COLUMN `access_restriction_level` SET TAGS ('dbx_business_glossary_term' = 'Access Restriction Level');
ALTER TABLE `mining_ecm`.`procurement`.`warehouse_location` ALTER COLUMN `access_restriction_level` SET TAGS ('dbx_value_regex' = 'unrestricted|controlled|restricted|high_security');
ALTER TABLE `mining_ecm`.`procurement`.`warehouse_location` ALTER COLUMN `address_line_1` SET TAGS ('dbx_business_glossary_term' = 'Address Line 1');
ALTER TABLE `mining_ecm`.`procurement`.`warehouse_location` ALTER COLUMN `address_line_1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`procurement`.`warehouse_location` ALTER COLUMN `address_line_1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `mining_ecm`.`procurement`.`warehouse_location` ALTER COLUMN `address_line_2` SET TAGS ('dbx_business_glossary_term' = 'Address Line 2');
ALTER TABLE `mining_ecm`.`procurement`.`warehouse_location` ALTER COLUMN `address_line_2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`procurement`.`warehouse_location` ALTER COLUMN `address_line_2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `mining_ecm`.`procurement`.`warehouse_location` ALTER COLUMN `capacity_pallet_positions` SET TAGS ('dbx_business_glossary_term' = 'Capacity Pallet Positions');
ALTER TABLE `mining_ecm`.`procurement`.`warehouse_location` ALTER COLUMN `capacity_volume_m3` SET TAGS ('dbx_business_glossary_term' = 'Capacity Volume (Cubic Meters)');
ALTER TABLE `mining_ecm`.`procurement`.`warehouse_location` ALTER COLUMN `capacity_weight_tonnes` SET TAGS ('dbx_business_glossary_term' = 'Capacity Weight (Tonnes)');
ALTER TABLE `mining_ecm`.`procurement`.`warehouse_location` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `mining_ecm`.`procurement`.`warehouse_location` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`procurement`.`warehouse_location` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `mining_ecm`.`procurement`.`warehouse_location` ALTER COLUMN `contact_email` SET TAGS ('dbx_business_glossary_term' = 'Contact Email Address');
ALTER TABLE `mining_ecm`.`procurement`.`warehouse_location` ALTER COLUMN `contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `mining_ecm`.`procurement`.`warehouse_location` ALTER COLUMN `contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`procurement`.`warehouse_location` ALTER COLUMN `contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `mining_ecm`.`procurement`.`warehouse_location` ALTER COLUMN `contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Contact Phone Number');
ALTER TABLE `mining_ecm`.`procurement`.`warehouse_location` ALTER COLUMN `contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`procurement`.`warehouse_location` ALTER COLUMN `contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `mining_ecm`.`procurement`.`warehouse_location` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `mining_ecm`.`procurement`.`warehouse_location` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `mining_ecm`.`procurement`.`warehouse_location` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `mining_ecm`.`procurement`.`warehouse_location` ALTER COLUMN `effective_from_date` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `mining_ecm`.`procurement`.`warehouse_location` ALTER COLUMN `effective_to_date` SET TAGS ('dbx_business_glossary_term' = 'Effective To Date');
ALTER TABLE `mining_ecm`.`procurement`.`warehouse_location` ALTER COLUMN `environmental_monitoring_flag` SET TAGS ('dbx_business_glossary_term' = 'Environmental Monitoring Flag');
ALTER TABLE `mining_ecm`.`procurement`.`warehouse_location` ALTER COLUMN `explosives_license_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Explosives License Expiry Date');
ALTER TABLE `mining_ecm`.`procurement`.`warehouse_location` ALTER COLUMN `explosives_license_expiry_date` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`procurement`.`warehouse_location` ALTER COLUMN `explosives_license_number` SET TAGS ('dbx_business_glossary_term' = 'Explosives License Number');
ALTER TABLE `mining_ecm`.`procurement`.`warehouse_location` ALTER COLUMN `explosives_license_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`procurement`.`warehouse_location` ALTER COLUMN `fire_suppression_system_type` SET TAGS ('dbx_business_glossary_term' = 'Fire Suppression System Type');
ALTER TABLE `mining_ecm`.`procurement`.`warehouse_location` ALTER COLUMN `fire_suppression_system_type` SET TAGS ('dbx_value_regex' = 'none|sprinkler|foam|gas|dry_chemical|water_mist');
ALTER TABLE `mining_ecm`.`procurement`.`warehouse_location` ALTER COLUMN `hazardous_goods_classification` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Goods Classification');
ALTER TABLE `mining_ecm`.`procurement`.`warehouse_location` ALTER COLUMN `last_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Last Inspection Date');
ALTER TABLE `mining_ecm`.`procurement`.`warehouse_location` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `mining_ecm`.`procurement`.`warehouse_location` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude (GPS Coordinate)');
ALTER TABLE `mining_ecm`.`procurement`.`warehouse_location` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `mining_ecm`.`procurement`.`warehouse_location` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `mining_ecm`.`procurement`.`warehouse_location` ALTER COLUMN `location_code` SET TAGS ('dbx_business_glossary_term' = 'Location Code');
ALTER TABLE `mining_ecm`.`procurement`.`warehouse_location` ALTER COLUMN `location_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,12}$');
ALTER TABLE `mining_ecm`.`procurement`.`warehouse_location` ALTER COLUMN `location_name` SET TAGS ('dbx_business_glossary_term' = 'Location Name');
ALTER TABLE `mining_ecm`.`procurement`.`warehouse_location` ALTER COLUMN `location_type` SET TAGS ('dbx_business_glossary_term' = 'Location Type');
ALTER TABLE `mining_ecm`.`procurement`.`warehouse_location` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude (GPS Coordinate)');
ALTER TABLE `mining_ecm`.`procurement`.`warehouse_location` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `mining_ecm`.`procurement`.`warehouse_location` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `mining_ecm`.`procurement`.`warehouse_location` ALTER COLUMN `next_inspection_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Inspection Due Date');
ALTER TABLE `mining_ecm`.`procurement`.`warehouse_location` ALTER COLUMN `operating_hours` SET TAGS ('dbx_business_glossary_term' = 'Operating Hours');
ALTER TABLE `mining_ecm`.`procurement`.`warehouse_location` ALTER COLUMN `operational_status` SET TAGS ('dbx_business_glossary_term' = 'Operational Status');
ALTER TABLE `mining_ecm`.`procurement`.`warehouse_location` ALTER COLUMN `operational_status` SET TAGS ('dbx_value_regex' = 'active|inactive|under_construction|decommissioned|maintenance|temporarily_closed');
ALTER TABLE `mining_ecm`.`procurement`.`warehouse_location` ALTER COLUMN `plant_code` SET TAGS ('dbx_business_glossary_term' = 'Plant Code');
ALTER TABLE `mining_ecm`.`procurement`.`warehouse_location` ALTER COLUMN `plant_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `mining_ecm`.`procurement`.`warehouse_location` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `mining_ecm`.`procurement`.`warehouse_location` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`procurement`.`warehouse_location` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `mining_ecm`.`procurement`.`warehouse_location` ALTER COLUMN `ppe_requirements` SET TAGS ('dbx_business_glossary_term' = 'Personal Protective Equipment (PPE) Requirements');
ALTER TABLE `mining_ecm`.`procurement`.`warehouse_location` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'State or Province');
ALTER TABLE `mining_ecm`.`procurement`.`warehouse_location` ALTER COLUMN `state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`procurement`.`warehouse_location` ALTER COLUMN `state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `mining_ecm`.`procurement`.`warehouse_location` ALTER COLUMN `temperature_controlled_flag` SET TAGS ('dbx_business_glossary_term' = 'Temperature Controlled Flag');
ALTER TABLE `mining_ecm`.`procurement`.`warehouse_location` ALTER COLUMN `temperature_max_celsius` SET TAGS ('dbx_business_glossary_term' = 'Maximum Temperature (Celsius)');
ALTER TABLE `mining_ecm`.`procurement`.`warehouse_location` ALTER COLUMN `temperature_min_celsius` SET TAGS ('dbx_business_glossary_term' = 'Minimum Temperature (Celsius)');
ALTER TABLE `mining_ecm`.`procurement`.`warehouse_location` ALTER COLUMN `warehouse_manager_name` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Manager Name');
ALTER TABLE `mining_ecm`.`procurement`.`inbound_delivery` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `mining_ecm`.`procurement`.`inbound_delivery` SET TAGS ('dbx_subdomain' = 'freight_logistics');
ALTER TABLE `mining_ecm`.`procurement`.`inbound_delivery` ALTER COLUMN `inbound_delivery_id` SET TAGS ('dbx_business_glossary_term' = 'Inbound Delivery Identifier (ID)');
ALTER TABLE `mining_ecm`.`procurement`.`inbound_delivery` ALTER COLUMN `delivery_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Schedule Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`procurement`.`inbound_delivery` ALTER COLUMN `freight_order_id` SET TAGS ('dbx_business_glossary_term' = 'Freight Order Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`procurement`.`inbound_delivery` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Identifier (ID)');
ALTER TABLE `mining_ecm`.`procurement`.`inbound_delivery` ALTER COLUMN `purchase_order_line_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Line Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`procurement`.`inbound_delivery` ALTER COLUMN `saleable_product_id` SET TAGS ('dbx_business_glossary_term' = 'Saleable Product Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`procurement`.`inbound_delivery` ALTER COLUMN `specification_id` SET TAGS ('dbx_business_glossary_term' = 'Specification Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`procurement`.`inbound_delivery` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Supply Material Master Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`procurement`.`inbound_delivery` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Identifier (ID)');
ALTER TABLE `mining_ecm`.`procurement`.`inbound_delivery` ALTER COLUMN `warehouse_location_id` SET TAGS ('dbx_business_glossary_term' = 'Destination Storage Location Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`procurement`.`inbound_delivery` ALTER COLUMN `actual_arrival_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Arrival Date');
ALTER TABLE `mining_ecm`.`procurement`.`inbound_delivery` ALTER COLUMN `container_number` SET TAGS ('dbx_business_glossary_term' = 'Container Number');
ALTER TABLE `mining_ecm`.`procurement`.`inbound_delivery` ALTER COLUMN `container_number` SET TAGS ('dbx_value_regex' = '^[A-Z]{4}[0-9]{7}$');
ALTER TABLE `mining_ecm`.`procurement`.`inbound_delivery` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `mining_ecm`.`procurement`.`inbound_delivery` ALTER COLUMN `customs_clearance_date` SET TAGS ('dbx_business_glossary_term' = 'Customs Clearance Date');
ALTER TABLE `mining_ecm`.`procurement`.`inbound_delivery` ALTER COLUMN `customs_clearance_status` SET TAGS ('dbx_business_glossary_term' = 'Customs Clearance Status');
ALTER TABLE `mining_ecm`.`procurement`.`inbound_delivery` ALTER COLUMN `customs_clearance_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|in_progress|cleared|held|rejected');
ALTER TABLE `mining_ecm`.`procurement`.`inbound_delivery` ALTER COLUMN `customs_declaration_number` SET TAGS ('dbx_business_glossary_term' = 'Customs Declaration Number');
ALTER TABLE `mining_ecm`.`procurement`.`inbound_delivery` ALTER COLUMN `dangerous_goods_declaration_reference` SET TAGS ('dbx_business_glossary_term' = 'Dangerous Goods Declaration Reference');
ALTER TABLE `mining_ecm`.`procurement`.`inbound_delivery` ALTER COLUMN `dangerous_goods_flag` SET TAGS ('dbx_business_glossary_term' = 'Dangerous Goods Flag');
ALTER TABLE `mining_ecm`.`procurement`.`inbound_delivery` ALTER COLUMN `delivery_note_number` SET TAGS ('dbx_business_glossary_term' = 'Delivery Note Number');
ALTER TABLE `mining_ecm`.`procurement`.`inbound_delivery` ALTER COLUMN `delivery_note_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{10}$');
ALTER TABLE `mining_ecm`.`procurement`.`inbound_delivery` ALTER COLUMN `delivery_notes` SET TAGS ('dbx_business_glossary_term' = 'Delivery Notes');
ALTER TABLE `mining_ecm`.`procurement`.`inbound_delivery` ALTER COLUMN `delivery_priority` SET TAGS ('dbx_business_glossary_term' = 'Delivery Priority');
ALTER TABLE `mining_ecm`.`procurement`.`inbound_delivery` ALTER COLUMN `delivery_priority` SET TAGS ('dbx_value_regex' = 'low|normal|high|critical');
ALTER TABLE `mining_ecm`.`procurement`.`inbound_delivery` ALTER COLUMN `delivery_status` SET TAGS ('dbx_business_glossary_term' = 'Delivery Status');
ALTER TABLE `mining_ecm`.`procurement`.`inbound_delivery` ALTER COLUMN `destination_plant_code` SET TAGS ('dbx_business_glossary_term' = 'Destination Plant Code');
ALTER TABLE `mining_ecm`.`procurement`.`inbound_delivery` ALTER COLUMN `destination_plant_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `mining_ecm`.`procurement`.`inbound_delivery` ALTER COLUMN `dispatch_date` SET TAGS ('dbx_business_glossary_term' = 'Dispatch Date');
ALTER TABLE `mining_ecm`.`procurement`.`inbound_delivery` ALTER COLUMN `expected_arrival_date` SET TAGS ('dbx_business_glossary_term' = 'Expected Arrival Date');
ALTER TABLE `mining_ecm`.`procurement`.`inbound_delivery` ALTER COLUMN `freight_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Freight Cost Amount');
ALTER TABLE `mining_ecm`.`procurement`.`inbound_delivery` ALTER COLUMN `freight_cost_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`procurement`.`inbound_delivery` ALTER COLUMN `freight_cost_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Freight Cost Currency Code');
ALTER TABLE `mining_ecm`.`procurement`.`inbound_delivery` ALTER COLUMN `freight_cost_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `mining_ecm`.`procurement`.`inbound_delivery` ALTER COLUMN `goods_receipt_completed_flag` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt Completed Flag');
ALTER TABLE `mining_ecm`.`procurement`.`inbound_delivery` ALTER COLUMN `incoterm_code` SET TAGS ('dbx_business_glossary_term' = 'Incoterm Code');
ALTER TABLE `mining_ecm`.`procurement`.`inbound_delivery` ALTER COLUMN `incoterm_code` SET TAGS ('dbx_value_regex' = '^(EXW|FCA|CPT|CIP|DAP|DPU|DDP|FAS|FOB|CFR|CIF)$');
ALTER TABLE `mining_ecm`.`procurement`.`inbound_delivery` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `mining_ecm`.`procurement`.`inbound_delivery` ALTER COLUMN `origin_location` SET TAGS ('dbx_business_glossary_term' = 'Origin Location');
ALTER TABLE `mining_ecm`.`procurement`.`inbound_delivery` ALTER COLUMN `quality_inspection_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Quality Inspection Required Flag');
ALTER TABLE `mining_ecm`.`procurement`.`inbound_delivery` ALTER COLUMN `seal_number` SET TAGS ('dbx_business_glossary_term' = 'Seal Number');
ALTER TABLE `mining_ecm`.`procurement`.`inbound_delivery` ALTER COLUMN `shipment_type` SET TAGS ('dbx_business_glossary_term' = 'Shipment Type');
ALTER TABLE `mining_ecm`.`procurement`.`inbound_delivery` ALTER COLUMN `shipment_type` SET TAGS ('dbx_value_regex' = 'standard|express|consolidated|direct|partial');
ALTER TABLE `mining_ecm`.`procurement`.`inbound_delivery` ALTER COLUMN `special_handling_instructions` SET TAGS ('dbx_business_glossary_term' = 'Special Handling Instructions');
ALTER TABLE `mining_ecm`.`procurement`.`inbound_delivery` ALTER COLUMN `total_gross_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Total Gross Weight in Kilograms (kg)');
ALTER TABLE `mining_ecm`.`procurement`.`inbound_delivery` ALTER COLUMN `total_net_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Total Net Weight in Kilograms (kg)');
ALTER TABLE `mining_ecm`.`procurement`.`inbound_delivery` ALTER COLUMN `total_volume_m3` SET TAGS ('dbx_business_glossary_term' = 'Total Volume in Cubic Meters (m³)');
ALTER TABLE `mining_ecm`.`procurement`.`inbound_delivery` ALTER COLUMN `transport_mode` SET TAGS ('dbx_business_glossary_term' = 'Transport Mode');
ALTER TABLE `mining_ecm`.`procurement`.`inbound_delivery` ALTER COLUMN `transport_mode` SET TAGS ('dbx_value_regex' = 'road|rail|sea|air|multimodal');
ALTER TABLE `mining_ecm`.`procurement`.`inbound_delivery` ALTER COLUMN `un_number` SET TAGS ('dbx_business_glossary_term' = 'United Nations (UN) Number');
ALTER TABLE `mining_ecm`.`procurement`.`inbound_delivery` ALTER COLUMN `un_number` SET TAGS ('dbx_value_regex' = '^UN[0-9]{4}$');
ALTER TABLE `mining_ecm`.`procurement`.`outbound_shipment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `mining_ecm`.`procurement`.`outbound_shipment` SET TAGS ('dbx_subdomain' = 'freight_logistics');
ALTER TABLE `mining_ecm`.`procurement`.`outbound_shipment` ALTER COLUMN `outbound_shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Outbound Shipment Identifier');
ALTER TABLE `mining_ecm`.`procurement`.`outbound_shipment` ALTER COLUMN `cargo_shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Cargo Shipment Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`procurement`.`outbound_shipment` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`procurement`.`outbound_shipment` ALTER COLUMN `counterparty_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Identifier');
ALTER TABLE `mining_ecm`.`procurement`.`outbound_shipment` ALTER COLUMN `delivery_destination_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Destination Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`procurement`.`outbound_shipment` ALTER COLUMN `freight_order_id` SET TAGS ('dbx_business_glossary_term' = 'Freight Order Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`procurement`.`outbound_shipment` ALTER COLUMN `warehouse_location_id` SET TAGS ('dbx_business_glossary_term' = 'Origin Warehouse Location Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`procurement`.`outbound_shipment` ALTER COLUMN `quality_certificate_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Certificate Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`procurement`.`outbound_shipment` ALTER COLUMN `saleable_product_id` SET TAGS ('dbx_business_glossary_term' = 'Saleable Product Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`procurement`.`outbound_shipment` ALTER COLUMN `specification_id` SET TAGS ('dbx_business_glossary_term' = 'Specification Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`procurement`.`outbound_shipment` ALTER COLUMN `vessel_id` SET TAGS ('dbx_business_glossary_term' = 'Vessel Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`procurement`.`outbound_shipment` ALTER COLUMN `actual_arrival_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Arrival Date');
ALTER TABLE `mining_ecm`.`procurement`.`outbound_shipment` ALTER COLUMN `actual_departure_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Departure Date');
ALTER TABLE `mining_ecm`.`procurement`.`outbound_shipment` ALTER COLUMN `average_grade_percent` SET TAGS ('dbx_business_glossary_term' = 'Average Grade Percentage');
ALTER TABLE `mining_ecm`.`procurement`.`outbound_shipment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `mining_ecm`.`procurement`.`outbound_shipment` ALTER COLUMN `demurrage_cost` SET TAGS ('dbx_business_glossary_term' = 'Demurrage Cost');
ALTER TABLE `mining_ecm`.`procurement`.`outbound_shipment` ALTER COLUMN `demurrage_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`procurement`.`outbound_shipment` ALTER COLUMN `demurrage_days` SET TAGS ('dbx_business_glossary_term' = 'Demurrage Days');
ALTER TABLE `mining_ecm`.`procurement`.`outbound_shipment` ALTER COLUMN `destination_country_code` SET TAGS ('dbx_business_glossary_term' = 'Destination Country Code');
ALTER TABLE `mining_ecm`.`procurement`.`outbound_shipment` ALTER COLUMN `destination_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `mining_ecm`.`procurement`.`outbound_shipment` ALTER COLUMN `estimated_arrival_date` SET TAGS ('dbx_business_glossary_term' = 'Estimated Time of Arrival (ETA) Date');
ALTER TABLE `mining_ecm`.`procurement`.`outbound_shipment` ALTER COLUMN `freight_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Freight Currency Code');
ALTER TABLE `mining_ecm`.`procurement`.`outbound_shipment` ALTER COLUMN `freight_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `mining_ecm`.`procurement`.`outbound_shipment` ALTER COLUMN `freight_rate_per_tonne` SET TAGS ('dbx_business_glossary_term' = 'Freight Rate per Tonne');
ALTER TABLE `mining_ecm`.`procurement`.`outbound_shipment` ALTER COLUMN `freight_rate_per_tonne` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`procurement`.`outbound_shipment` ALTER COLUMN `incoterms_code` SET TAGS ('dbx_business_glossary_term' = 'International Commercial Terms (INCOTERMS) Code');
ALTER TABLE `mining_ecm`.`procurement`.`outbound_shipment` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `mining_ecm`.`procurement`.`outbound_shipment` ALTER COLUMN `laycan_end_date` SET TAGS ('dbx_business_glossary_term' = 'Laycan End Date');
ALTER TABLE `mining_ecm`.`procurement`.`outbound_shipment` ALTER COLUMN `laycan_start_date` SET TAGS ('dbx_business_glossary_term' = 'Laycan Start Date');
ALTER TABLE `mining_ecm`.`procurement`.`outbound_shipment` ALTER COLUMN `loaded_quantity_tonnes` SET TAGS ('dbx_business_glossary_term' = 'Loaded Quantity (Tonnes)');
ALTER TABLE `mining_ecm`.`procurement`.`outbound_shipment` ALTER COLUMN `loading_completion_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Loading Completion Timestamp');
ALTER TABLE `mining_ecm`.`procurement`.`outbound_shipment` ALTER COLUMN `loading_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Loading Start Timestamp');
ALTER TABLE `mining_ecm`.`procurement`.`outbound_shipment` ALTER COLUMN `moisture_content_percent` SET TAGS ('dbx_business_glossary_term' = 'Moisture Content Percentage');
ALTER TABLE `mining_ecm`.`procurement`.`outbound_shipment` ALTER COLUMN `nominated_quantity_tonnes` SET TAGS ('dbx_business_glossary_term' = 'Nominated Quantity (Tonnes)');
ALTER TABLE `mining_ecm`.`procurement`.`outbound_shipment` ALTER COLUMN `origin_location_name` SET TAGS ('dbx_business_glossary_term' = 'Origin Location Name');
ALTER TABLE `mining_ecm`.`procurement`.`outbound_shipment` ALTER COLUMN `quantity_variance_tonnes` SET TAGS ('dbx_business_glossary_term' = 'Quantity Variance (Tonnes)');
ALTER TABLE `mining_ecm`.`procurement`.`outbound_shipment` ALTER COLUMN `remarks` SET TAGS ('dbx_business_glossary_term' = 'Shipment Remarks');
ALTER TABLE `mining_ecm`.`procurement`.`outbound_shipment` ALTER COLUMN `shipment_number` SET TAGS ('dbx_business_glossary_term' = 'Shipment Number');
ALTER TABLE `mining_ecm`.`procurement`.`outbound_shipment` ALTER COLUMN `shipment_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `mining_ecm`.`procurement`.`outbound_shipment` ALTER COLUMN `shipment_status` SET TAGS ('dbx_business_glossary_term' = 'Shipment Status');
ALTER TABLE `mining_ecm`.`procurement`.`outbound_shipment` ALTER COLUMN `shipping_agent_name` SET TAGS ('dbx_business_glossary_term' = 'Shipping Agent Name');
ALTER TABLE `mining_ecm`.`procurement`.`outbound_shipment` ALTER COLUMN `total_freight_cost` SET TAGS ('dbx_business_glossary_term' = 'Total Freight Cost');
ALTER TABLE `mining_ecm`.`procurement`.`outbound_shipment` ALTER COLUMN `total_freight_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`procurement`.`procurement_vendor_performance` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `mining_ecm`.`procurement`.`procurement_vendor_performance` SET TAGS ('dbx_subdomain' = 'supplier_contracts');
ALTER TABLE `mining_ecm`.`procurement`.`procurement_vendor_performance` ALTER COLUMN `procurement_vendor_performance_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Performance Identifier');
ALTER TABLE `mining_ecm`.`procurement`.`procurement_vendor_performance` ALTER COLUMN `commodity_id` SET TAGS ('dbx_business_glossary_term' = 'Commodity Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`procurement`.`procurement_vendor_performance` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Procurement Contract Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`procurement`.`procurement_vendor_performance` ALTER COLUMN `framework_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Framework Agreement Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`procurement`.`procurement_vendor_performance` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `mining_ecm`.`procurement`.`procurement_vendor_performance` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `mining_ecm`.`procurement`.`procurement_vendor_performance` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `mining_ecm`.`procurement`.`procurement_vendor_performance` ALTER COLUMN `approved_date` SET TAGS ('dbx_business_glossary_term' = 'Approved Date');
ALTER TABLE `mining_ecm`.`procurement`.`procurement_vendor_performance` ALTER COLUMN `average_issue_resolution_time_days` SET TAGS ('dbx_business_glossary_term' = 'Average Issue Resolution Time Days');
ALTER TABLE `mining_ecm`.`procurement`.`procurement_vendor_performance` ALTER COLUMN `corrective_action_description` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Description');
ALTER TABLE `mining_ecm`.`procurement`.`procurement_vendor_performance` ALTER COLUMN `corrective_action_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Required Flag');
ALTER TABLE `mining_ecm`.`procurement`.`procurement_vendor_performance` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `mining_ecm`.`procurement`.`procurement_vendor_performance` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `mining_ecm`.`procurement`.`procurement_vendor_performance` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `mining_ecm`.`procurement`.`procurement_vendor_performance` ALTER COLUMN `delivery_performance_score` SET TAGS ('dbx_business_glossary_term' = 'Delivery Performance Score');
ALTER TABLE `mining_ecm`.`procurement`.`procurement_vendor_performance` ALTER COLUMN `evaluation_date` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Date');
ALTER TABLE `mining_ecm`.`procurement`.`procurement_vendor_performance` ALTER COLUMN `evaluation_notes` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Notes');
ALTER TABLE `mining_ecm`.`procurement`.`procurement_vendor_performance` ALTER COLUMN `evaluation_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Period End Date');
ALTER TABLE `mining_ecm`.`procurement`.`procurement_vendor_performance` ALTER COLUMN `evaluation_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Period Start Date');
ALTER TABLE `mining_ecm`.`procurement`.`procurement_vendor_performance` ALTER COLUMN `evaluation_status` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Status');
ALTER TABLE `mining_ecm`.`procurement`.`procurement_vendor_performance` ALTER COLUMN `evaluation_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|approved|rejected|closed');
ALTER TABLE `mining_ecm`.`procurement`.`procurement_vendor_performance` ALTER COLUMN `evaluator_name` SET TAGS ('dbx_business_glossary_term' = 'Evaluator Name');
ALTER TABLE `mining_ecm`.`procurement`.`procurement_vendor_performance` ALTER COLUMN `evaluator_role` SET TAGS ('dbx_business_glossary_term' = 'Evaluator Role');
ALTER TABLE `mining_ecm`.`procurement`.`procurement_vendor_performance` ALTER COLUMN `hse_incident_count` SET TAGS ('dbx_business_glossary_term' = 'Health Safety and Environment (HSE) Incident Count');
ALTER TABLE `mining_ecm`.`procurement`.`procurement_vendor_performance` ALTER COLUMN `invoice_accuracy_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Invoice Accuracy Rate Percent');
ALTER TABLE `mining_ecm`.`procurement`.`procurement_vendor_performance` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `mining_ecm`.`procurement`.`procurement_vendor_performance` ALTER COLUMN `ncr_count` SET TAGS ('dbx_business_glossary_term' = 'Non-Conformance Report (NCR) Count');
ALTER TABLE `mining_ecm`.`procurement`.`procurement_vendor_performance` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `mining_ecm`.`procurement`.`procurement_vendor_performance` ALTER COLUMN `on_time_delivery_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'On-Time Delivery Rate Percent');
ALTER TABLE `mining_ecm`.`procurement`.`procurement_vendor_performance` ALTER COLUMN `order_fill_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Order Fill Rate Percent');
ALTER TABLE `mining_ecm`.`procurement`.`procurement_vendor_performance` ALTER COLUMN `overall_performance_rating` SET TAGS ('dbx_business_glossary_term' = 'Overall Performance Rating');
ALTER TABLE `mining_ecm`.`procurement`.`procurement_vendor_performance` ALTER COLUMN `overall_performance_rating` SET TAGS ('dbx_value_regex' = 'excellent|good|satisfactory|needs_improvement|unsatisfactory');
ALTER TABLE `mining_ecm`.`procurement`.`procurement_vendor_performance` ALTER COLUMN `overall_performance_score` SET TAGS ('dbx_business_glossary_term' = 'Overall Performance Score');
ALTER TABLE `mining_ecm`.`procurement`.`procurement_vendor_performance` ALTER COLUMN `performance_rating` SET TAGS ('dbx_business_glossary_term' = 'Performance Rating');
ALTER TABLE `mining_ecm`.`procurement`.`procurement_vendor_performance` ALTER COLUMN `performance_rating` SET TAGS ('dbx_value_regex' = 'preferred|approved|conditional|probation|suspended');
ALTER TABLE `mining_ecm`.`procurement`.`procurement_vendor_performance` ALTER COLUMN `preferred_vendor_flag` SET TAGS ('dbx_business_glossary_term' = 'Preferred Vendor Flag');
ALTER TABLE `mining_ecm`.`procurement`.`procurement_vendor_performance` ALTER COLUMN `price_performance_score` SET TAGS ('dbx_business_glossary_term' = 'Price Performance Score');
ALTER TABLE `mining_ecm`.`procurement`.`procurement_vendor_performance` ALTER COLUMN `price_variance_percent` SET TAGS ('dbx_business_glossary_term' = 'Price Variance Percent');
ALTER TABLE `mining_ecm`.`procurement`.`procurement_vendor_performance` ALTER COLUMN `quality_acceptance_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Quality Acceptance Rate Percent');
ALTER TABLE `mining_ecm`.`procurement`.`procurement_vendor_performance` ALTER COLUMN `quality_performance_score` SET TAGS ('dbx_business_glossary_term' = 'Quality Performance Score');
ALTER TABLE `mining_ecm`.`procurement`.`procurement_vendor_performance` ALTER COLUMN `rejection_count` SET TAGS ('dbx_business_glossary_term' = 'Rejection Count');
ALTER TABLE `mining_ecm`.`procurement`.`procurement_vendor_performance` ALTER COLUMN `rejection_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Rejection Rate Percent');
ALTER TABLE `mining_ecm`.`procurement`.`procurement_vendor_performance` ALTER COLUMN `responsiveness_rating` SET TAGS ('dbx_business_glossary_term' = 'Responsiveness Rating');
ALTER TABLE `mining_ecm`.`procurement`.`procurement_vendor_performance` ALTER COLUMN `responsiveness_rating` SET TAGS ('dbx_value_regex' = 'excellent|good|satisfactory|poor|unacceptable');
ALTER TABLE `mining_ecm`.`procurement`.`procurement_vendor_performance` ALTER COLUMN `responsiveness_score` SET TAGS ('dbx_business_glossary_term' = 'Responsiveness Score');
ALTER TABLE `mining_ecm`.`procurement`.`procurement_vendor_performance` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Level');
ALTER TABLE `mining_ecm`.`procurement`.`procurement_vendor_performance` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `mining_ecm`.`procurement`.`procurement_vendor_performance` ALTER COLUMN `service_performance_score` SET TAGS ('dbx_business_glossary_term' = 'Service Performance Score');
ALTER TABLE `mining_ecm`.`procurement`.`procurement_vendor_performance` ALTER COLUMN `total_goods_receipt_count` SET TAGS ('dbx_business_glossary_term' = 'Total Goods Receipt Count');
ALTER TABLE `mining_ecm`.`procurement`.`procurement_vendor_performance` ALTER COLUMN `total_po_count` SET TAGS ('dbx_business_glossary_term' = 'Total Purchase Order (PO) Count');
ALTER TABLE `mining_ecm`.`procurement`.`procurement_vendor_performance` ALTER COLUMN `total_po_line_count` SET TAGS ('dbx_business_glossary_term' = 'Total Purchase Order (PO) Line Count');
ALTER TABLE `mining_ecm`.`procurement`.`procurement_vendor_performance` ALTER COLUMN `total_procurement_value` SET TAGS ('dbx_business_glossary_term' = 'Total Procurement Value');
ALTER TABLE `mining_ecm`.`procurement`.`procurement_vendor_performance` ALTER COLUMN `total_purchase_order_count` SET TAGS ('dbx_business_glossary_term' = 'Total Purchase Order (PO) Count');
ALTER TABLE `mining_ecm`.`procurement`.`procurement_vendor_performance` ALTER COLUMN `total_rejection_count` SET TAGS ('dbx_business_glossary_term' = 'Total Rejection Count');
ALTER TABLE `mining_ecm`.`procurement`.`requisition` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `mining_ecm`.`procurement`.`requisition` SET TAGS ('dbx_subdomain' = 'purchase_requisition');
ALTER TABLE `mining_ecm`.`procurement`.`requisition` ALTER COLUMN `requisition_id` SET TAGS ('dbx_business_glossary_term' = 'Requisition ID');
ALTER TABLE `mining_ecm`.`procurement`.`requisition` ALTER COLUMN `commodity_id` SET TAGS ('dbx_business_glossary_term' = 'Commodity Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`procurement`.`requisition` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`procurement`.`requisition` ALTER COLUMN `cost_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Centre Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`procurement`.`requisition` ALTER COLUMN `framework_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Framework Agreement Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`procurement`.`requisition` ALTER COLUMN `general_ledger_account_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger Account Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`procurement`.`requisition` ALTER COLUMN `price_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Price Schedule Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`procurement`.`requisition` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material ID');
ALTER TABLE `mining_ecm`.`procurement`.`requisition` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `mining_ecm`.`procurement`.`requisition` ALTER COLUMN `warehouse_location_id` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Location Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`procurement`.`requisition` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Wbs Element Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`procurement`.`requisition` ALTER COLUMN `account_assignment_category` SET TAGS ('dbx_business_glossary_term' = 'Account Assignment Category');
ALTER TABLE `mining_ecm`.`procurement`.`requisition` ALTER COLUMN `account_assignment_category` SET TAGS ('dbx_value_regex' = 'cost_centre|internal_order|project|asset|sales_order');
ALTER TABLE `mining_ecm`.`procurement`.`requisition` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `mining_ecm`.`procurement`.`requisition` ALTER COLUMN `approval_workflow_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Workflow Status');
ALTER TABLE `mining_ecm`.`procurement`.`requisition` ALTER COLUMN `approval_workflow_status` SET TAGS ('dbx_value_regex' = 'not_submitted|pending_level_1|pending_level_2|pending_level_3|approved|rejected');
ALTER TABLE `mining_ecm`.`procurement`.`requisition` ALTER COLUMN `approver_name` SET TAGS ('dbx_business_glossary_term' = 'Approver Name');
ALTER TABLE `mining_ecm`.`procurement`.`requisition` ALTER COLUMN `approver_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `mining_ecm`.`procurement`.`requisition` ALTER COLUMN `approver_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `mining_ecm`.`procurement`.`requisition` ALTER COLUMN `asset_number` SET TAGS ('dbx_business_glossary_term' = 'Asset Number');
ALTER TABLE `mining_ecm`.`procurement`.`requisition` ALTER COLUMN `asset_number` SET TAGS ('dbx_value_regex' = '^[0-9]{12}$');
ALTER TABLE `mining_ecm`.`procurement`.`requisition` ALTER COLUMN `conversion_status` SET TAGS ('dbx_business_glossary_term' = 'Conversion Status');
ALTER TABLE `mining_ecm`.`procurement`.`requisition` ALTER COLUMN `conversion_status` SET TAGS ('dbx_value_regex' = 'not_converted|partially_converted|fully_converted');
ALTER TABLE `mining_ecm`.`procurement`.`requisition` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `mining_ecm`.`procurement`.`requisition` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `mining_ecm`.`procurement`.`requisition` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `mining_ecm`.`procurement`.`requisition` ALTER COLUMN `deletion_indicator` SET TAGS ('dbx_business_glossary_term' = 'Deletion Indicator');
ALTER TABLE `mining_ecm`.`procurement`.`requisition` ALTER COLUMN `estimated_value` SET TAGS ('dbx_business_glossary_term' = 'Estimated Value');
ALTER TABLE `mining_ecm`.`procurement`.`requisition` ALTER COLUMN `internal_order_number` SET TAGS ('dbx_business_glossary_term' = 'Internal Order Number');
ALTER TABLE `mining_ecm`.`procurement`.`requisition` ALTER COLUMN `internal_order_number` SET TAGS ('dbx_value_regex' = '^[0-9]{12}$');
ALTER TABLE `mining_ecm`.`procurement`.`requisition` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `mining_ecm`.`procurement`.`requisition` ALTER COLUMN `line_number` SET TAGS ('dbx_business_glossary_term' = 'Requisition Line Number');
ALTER TABLE `mining_ecm`.`procurement`.`requisition` ALTER COLUMN `material_group` SET TAGS ('dbx_business_glossary_term' = 'Material Group');
ALTER TABLE `mining_ecm`.`procurement`.`requisition` ALTER COLUMN `material_group` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{9}$');
ALTER TABLE `mining_ecm`.`procurement`.`requisition` ALTER COLUMN `mrp_controller` SET TAGS ('dbx_business_glossary_term' = 'Material Requirements Planning (MRP) Controller');
ALTER TABLE `mining_ecm`.`procurement`.`requisition` ALTER COLUMN `mrp_controller` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3}$');
ALTER TABLE `mining_ecm`.`procurement`.`requisition` ALTER COLUMN `plant_code` SET TAGS ('dbx_business_glossary_term' = 'Plant Code');
ALTER TABLE `mining_ecm`.`procurement`.`requisition` ALTER COLUMN `plant_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `mining_ecm`.`procurement`.`requisition` ALTER COLUMN `priority_indicator` SET TAGS ('dbx_business_glossary_term' = 'Priority Indicator');
ALTER TABLE `mining_ecm`.`procurement`.`requisition` ALTER COLUMN `priority_indicator` SET TAGS ('dbx_value_regex' = 'urgent|high|normal|low');
ALTER TABLE `mining_ecm`.`procurement`.`requisition` ALTER COLUMN `purchasing_group` SET TAGS ('dbx_business_glossary_term' = 'Purchasing Group');
ALTER TABLE `mining_ecm`.`procurement`.`requisition` ALTER COLUMN `purchasing_group` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3}$');
ALTER TABLE `mining_ecm`.`procurement`.`requisition` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Requisition Quantity');
ALTER TABLE `mining_ecm`.`procurement`.`requisition` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `mining_ecm`.`procurement`.`requisition` ALTER COLUMN `required_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Required Delivery Date');
ALTER TABLE `mining_ecm`.`procurement`.`requisition` ALTER COLUMN `requisition_date` SET TAGS ('dbx_business_glossary_term' = 'Requisition Date');
ALTER TABLE `mining_ecm`.`procurement`.`requisition` ALTER COLUMN `requisition_number` SET TAGS ('dbx_business_glossary_term' = 'Requisition Number');
ALTER TABLE `mining_ecm`.`procurement`.`requisition` ALTER COLUMN `requisition_number` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `mining_ecm`.`procurement`.`requisition` ALTER COLUMN `requisition_status` SET TAGS ('dbx_business_glossary_term' = 'Requisition Status');
ALTER TABLE `mining_ecm`.`procurement`.`requisition` ALTER COLUMN `requisition_type` SET TAGS ('dbx_business_glossary_term' = 'Requisition Type');
ALTER TABLE `mining_ecm`.`procurement`.`requisition` ALTER COLUMN `requisition_type` SET TAGS ('dbx_value_regex' = 'standard|stock_transfer|subcontracting|consignment|service');
ALTER TABLE `mining_ecm`.`procurement`.`requisition` ALTER COLUMN `requisitioner_email` SET TAGS ('dbx_business_glossary_term' = 'Requisitioner Email Address');
ALTER TABLE `mining_ecm`.`procurement`.`requisition` ALTER COLUMN `requisitioner_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `mining_ecm`.`procurement`.`requisition` ALTER COLUMN `requisitioner_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `mining_ecm`.`procurement`.`requisition` ALTER COLUMN `requisitioner_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `mining_ecm`.`procurement`.`requisition` ALTER COLUMN `short_text` SET TAGS ('dbx_business_glossary_term' = 'Short Text Description');
ALTER TABLE `mining_ecm`.`procurement`.`requisition` ALTER COLUMN `source_determination_indicator` SET TAGS ('dbx_business_glossary_term' = 'Source Determination Indicator');
ALTER TABLE `mining_ecm`.`procurement`.`requisition` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `mining_ecm`.`procurement`.`requisition` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,3}$');
ALTER TABLE `mining_ecm`.`procurement`.`framework_agreement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `mining_ecm`.`procurement`.`framework_agreement` SET TAGS ('dbx_subdomain' = 'supplier_contracts');
ALTER TABLE `mining_ecm`.`procurement`.`framework_agreement` ALTER COLUMN `framework_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Framework Agreement Identifier');
ALTER TABLE `mining_ecm`.`procurement`.`framework_agreement` ALTER COLUMN `commodity_id` SET TAGS ('dbx_business_glossary_term' = 'Commodity Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`procurement`.`framework_agreement` ALTER COLUMN `cost_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Centre Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`procurement`.`framework_agreement` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `mining_ecm`.`procurement`.`framework_agreement` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `mining_ecm`.`procurement`.`framework_agreement` ALTER COLUMN `base_price` SET TAGS ('dbx_business_glossary_term' = 'Base Price');
ALTER TABLE `mining_ecm`.`procurement`.`framework_agreement` ALTER COLUMN `base_price` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`procurement`.`framework_agreement` ALTER COLUMN `company_code` SET TAGS ('dbx_business_glossary_term' = 'Company Code');
ALTER TABLE `mining_ecm`.`procurement`.`framework_agreement` ALTER COLUMN `contract_number` SET TAGS ('dbx_business_glossary_term' = 'Contract Number');
ALTER TABLE `mining_ecm`.`procurement`.`framework_agreement` ALTER COLUMN `contract_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{10}$');
ALTER TABLE `mining_ecm`.`procurement`.`framework_agreement` ALTER COLUMN `contract_status` SET TAGS ('dbx_business_glossary_term' = 'Contract Status');
ALTER TABLE `mining_ecm`.`procurement`.`framework_agreement` ALTER COLUMN `contract_status` SET TAGS ('dbx_value_regex' = 'draft|active|suspended|expired|terminated|closed');
ALTER TABLE `mining_ecm`.`procurement`.`framework_agreement` ALTER COLUMN `contract_type` SET TAGS ('dbx_business_glossary_term' = 'Contract Type');
ALTER TABLE `mining_ecm`.`procurement`.`framework_agreement` ALTER COLUMN `contract_type` SET TAGS ('dbx_value_regex' = 'quantity_contract|value_contract|scheduling_agreement|blanket_order|master_agreement|call_off_contract');
ALTER TABLE `mining_ecm`.`procurement`.`framework_agreement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `mining_ecm`.`procurement`.`framework_agreement` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `mining_ecm`.`procurement`.`framework_agreement` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `mining_ecm`.`procurement`.`framework_agreement` ALTER COLUMN `delivery_lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Delivery Lead Time (Days)');
ALTER TABLE `mining_ecm`.`procurement`.`framework_agreement` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Contract End Date');
ALTER TABLE `mining_ecm`.`procurement`.`framework_agreement` ALTER COLUMN `incoterms_code` SET TAGS ('dbx_business_glossary_term' = 'Incoterms Code');
ALTER TABLE `mining_ecm`.`procurement`.`framework_agreement` ALTER COLUMN `incoterms_location` SET TAGS ('dbx_business_glossary_term' = 'Incoterms Location');
ALTER TABLE `mining_ecm`.`procurement`.`framework_agreement` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `mining_ecm`.`procurement`.`framework_agreement` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `mining_ecm`.`procurement`.`framework_agreement` ALTER COLUMN `maximum_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Maximum Order Quantity');
ALTER TABLE `mining_ecm`.`procurement`.`framework_agreement` ALTER COLUMN `minimum_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity (MOQ)');
ALTER TABLE `mining_ecm`.`procurement`.`framework_agreement` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `mining_ecm`.`procurement`.`framework_agreement` ALTER COLUMN `payment_terms_code` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms Code');
ALTER TABLE `mining_ecm`.`procurement`.`framework_agreement` ALTER COLUMN `performance_review_frequency` SET TAGS ('dbx_business_glossary_term' = 'Performance Review Frequency');
ALTER TABLE `mining_ecm`.`procurement`.`framework_agreement` ALTER COLUMN `performance_review_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|semi_annually|annually');
ALTER TABLE `mining_ecm`.`procurement`.`framework_agreement` ALTER COLUMN `plant_code` SET TAGS ('dbx_business_glossary_term' = 'Plant Code');
ALTER TABLE `mining_ecm`.`procurement`.`framework_agreement` ALTER COLUMN `price_unit` SET TAGS ('dbx_business_glossary_term' = 'Price Unit');
ALTER TABLE `mining_ecm`.`procurement`.`framework_agreement` ALTER COLUMN `pricing_condition_type` SET TAGS ('dbx_business_glossary_term' = 'Pricing Condition Type');
ALTER TABLE `mining_ecm`.`procurement`.`framework_agreement` ALTER COLUMN `pricing_condition_type` SET TAGS ('dbx_value_regex' = 'fixed_price|variable_price|cost_plus|index_linked|market_based|tiered_pricing');
ALTER TABLE `mining_ecm`.`procurement`.`framework_agreement` ALTER COLUMN `purchasing_group` SET TAGS ('dbx_business_glossary_term' = 'Purchasing Group');
ALTER TABLE `mining_ecm`.`procurement`.`framework_agreement` ALTER COLUMN `purchasing_organization` SET TAGS ('dbx_business_glossary_term' = 'Purchasing Organization');
ALTER TABLE `mining_ecm`.`procurement`.`framework_agreement` ALTER COLUMN `renewal_indicator` SET TAGS ('dbx_business_glossary_term' = 'Renewal Indicator');
ALTER TABLE `mining_ecm`.`procurement`.`framework_agreement` ALTER COLUMN `renewal_notice_period_days` SET TAGS ('dbx_business_glossary_term' = 'Renewal Notice Period (Days)');
ALTER TABLE `mining_ecm`.`procurement`.`framework_agreement` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Start Date');
ALTER TABLE `mining_ecm`.`procurement`.`framework_agreement` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `mining_ecm`.`procurement`.`framework_agreement` ALTER COLUMN `termination_notice_period_days` SET TAGS ('dbx_business_glossary_term' = 'Termination Notice Period (Days)');
ALTER TABLE `mining_ecm`.`procurement`.`framework_agreement` ALTER COLUMN `termination_reason` SET TAGS ('dbx_business_glossary_term' = 'Termination Reason');
ALTER TABLE `mining_ecm`.`procurement`.`framework_agreement` ALTER COLUMN `total_contract_quantity` SET TAGS ('dbx_business_glossary_term' = 'Total Contract Quantity');
ALTER TABLE `mining_ecm`.`procurement`.`framework_agreement` ALTER COLUMN `total_contract_value` SET TAGS ('dbx_business_glossary_term' = 'Total Contract Value');
ALTER TABLE `mining_ecm`.`procurement`.`framework_agreement` ALTER COLUMN `total_contract_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`procurement`.`framework_agreement` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `mining_ecm`.`procurement`.`freight_order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `mining_ecm`.`procurement`.`freight_order` SET TAGS ('dbx_subdomain' = 'freight_logistics');
ALTER TABLE `mining_ecm`.`procurement`.`freight_order` ALTER COLUMN `freight_order_id` SET TAGS ('dbx_business_glossary_term' = 'Freight Order Identifier (ID)');
ALTER TABLE `mining_ecm`.`procurement`.`freight_order` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`procurement`.`freight_order` ALTER COLUMN `counterparty_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Identifier (ID)');
ALTER TABLE `mining_ecm`.`procurement`.`freight_order` ALTER COLUMN `delivery_destination_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Destination Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`procurement`.`freight_order` ALTER COLUMN `warehouse_location_id` SET TAGS ('dbx_business_glossary_term' = 'Origin Warehouse Location Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`procurement`.`freight_order` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`procurement`.`freight_order` ALTER COLUMN `saleable_product_id` SET TAGS ('dbx_business_glossary_term' = 'Saleable Product Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`procurement`.`freight_order` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Supply Material Master Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`procurement`.`freight_order` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Identifier (ID)');
ALTER TABLE `mining_ecm`.`procurement`.`freight_order` ALTER COLUMN `vessel_id` SET TAGS ('dbx_business_glossary_term' = 'Vessel Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`procurement`.`freight_order` ALTER COLUMN `actual_arrival_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Arrival Timestamp');
ALTER TABLE `mining_ecm`.`procurement`.`freight_order` ALTER COLUMN `actual_departure_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Departure Timestamp');
ALTER TABLE `mining_ecm`.`procurement`.`freight_order` ALTER COLUMN `cargo_description` SET TAGS ('dbx_business_glossary_term' = 'Cargo Description');
ALTER TABLE `mining_ecm`.`procurement`.`freight_order` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `mining_ecm`.`procurement`.`freight_order` ALTER COLUMN `customs_clearance_date` SET TAGS ('dbx_business_glossary_term' = 'Customs Clearance Date');
ALTER TABLE `mining_ecm`.`procurement`.`freight_order` ALTER COLUMN `customs_clearance_status` SET TAGS ('dbx_business_glossary_term' = 'Customs Clearance Status');
ALTER TABLE `mining_ecm`.`procurement`.`freight_order` ALTER COLUMN `customs_clearance_status` SET TAGS ('dbx_value_regex' = 'not-required|pending|cleared|held|rejected');
ALTER TABLE `mining_ecm`.`procurement`.`freight_order` ALTER COLUMN `dangerous_goods_class` SET TAGS ('dbx_business_glossary_term' = 'Dangerous Goods Class');
ALTER TABLE `mining_ecm`.`procurement`.`freight_order` ALTER COLUMN `dangerous_goods_class` SET TAGS ('dbx_value_regex' = '^[1-9](.[1-6])?$');
ALTER TABLE `mining_ecm`.`procurement`.`freight_order` ALTER COLUMN `dangerous_goods_flag` SET TAGS ('dbx_business_glossary_term' = 'Dangerous Goods Flag');
ALTER TABLE `mining_ecm`.`procurement`.`freight_order` ALTER COLUMN `dangerous_goods_un_number` SET TAGS ('dbx_business_glossary_term' = 'Dangerous Goods United Nations (UN) Number');
ALTER TABLE `mining_ecm`.`procurement`.`freight_order` ALTER COLUMN `dangerous_goods_un_number` SET TAGS ('dbx_value_regex' = '^UN[0-9]{4}$');
ALTER TABLE `mining_ecm`.`procurement`.`freight_order` ALTER COLUMN `delivery_note_reference` SET TAGS ('dbx_business_glossary_term' = 'Delivery Note Reference');
ALTER TABLE `mining_ecm`.`procurement`.`freight_order` ALTER COLUMN `direction` SET TAGS ('dbx_business_glossary_term' = 'Freight Direction');
ALTER TABLE `mining_ecm`.`procurement`.`freight_order` ALTER COLUMN `direction` SET TAGS ('dbx_value_regex' = 'inbound|outbound|inter-site');
ALTER TABLE `mining_ecm`.`procurement`.`freight_order` ALTER COLUMN `expected_arrival_date` SET TAGS ('dbx_business_glossary_term' = 'Expected Arrival Date');
ALTER TABLE `mining_ecm`.`procurement`.`freight_order` ALTER COLUMN `expected_departure_date` SET TAGS ('dbx_business_glossary_term' = 'Expected Departure Date');
ALTER TABLE `mining_ecm`.`procurement`.`freight_order` ALTER COLUMN `freight_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Freight Cost Amount');
ALTER TABLE `mining_ecm`.`procurement`.`freight_order` ALTER COLUMN `freight_cost_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`procurement`.`freight_order` ALTER COLUMN `freight_cost_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Freight Cost Currency Code');
ALTER TABLE `mining_ecm`.`procurement`.`freight_order` ALTER COLUMN `freight_cost_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `mining_ecm`.`procurement`.`freight_order` ALTER COLUMN `freight_order_number` SET TAGS ('dbx_business_glossary_term' = 'Freight Order Number');
ALTER TABLE `mining_ecm`.`procurement`.`freight_order` ALTER COLUMN `freight_order_number` SET TAGS ('dbx_value_regex' = '^FO-[0-9]{8}$');
ALTER TABLE `mining_ecm`.`procurement`.`freight_order` ALTER COLUMN `freight_rate_per_tonne` SET TAGS ('dbx_business_glossary_term' = 'Freight Rate per Tonne');
ALTER TABLE `mining_ecm`.`procurement`.`freight_order` ALTER COLUMN `freight_rate_per_tonne` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`procurement`.`freight_order` ALTER COLUMN `freight_status` SET TAGS ('dbx_business_glossary_term' = 'Freight Status');
ALTER TABLE `mining_ecm`.`procurement`.`freight_order` ALTER COLUMN `freight_status` SET TAGS ('dbx_value_regex' = 'planned|booked|in-transit|arrived|delivered|cancelled');
ALTER TABLE `mining_ecm`.`procurement`.`freight_order` ALTER COLUMN `gross_weight_tonnes` SET TAGS ('dbx_business_glossary_term' = 'Gross Weight (Tonnes)');
ALTER TABLE `mining_ecm`.`procurement`.`freight_order` ALTER COLUMN `incoterms_code` SET TAGS ('dbx_business_glossary_term' = 'Incoterms Code');
ALTER TABLE `mining_ecm`.`procurement`.`freight_order` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `mining_ecm`.`procurement`.`freight_order` ALTER COLUMN `laycan_end_date` SET TAGS ('dbx_business_glossary_term' = 'Laycan End Date (Laytime Cancelling)');
ALTER TABLE `mining_ecm`.`procurement`.`freight_order` ALTER COLUMN `laycan_start_date` SET TAGS ('dbx_business_glossary_term' = 'Laycan Start Date (Laytime Cancelling)');
ALTER TABLE `mining_ecm`.`procurement`.`freight_order` ALTER COLUMN `loaded_quantity_tonnes` SET TAGS ('dbx_business_glossary_term' = 'Loaded Quantity (Tonnes)');
ALTER TABLE `mining_ecm`.`procurement`.`freight_order` ALTER COLUMN `net_weight_tonnes` SET TAGS ('dbx_business_glossary_term' = 'Net Weight (Tonnes)');
ALTER TABLE `mining_ecm`.`procurement`.`freight_order` ALTER COLUMN `nominated_quantity_tonnes` SET TAGS ('dbx_business_glossary_term' = 'Nominated Quantity (Tonnes)');
ALTER TABLE `mining_ecm`.`procurement`.`freight_order` ALTER COLUMN `tracking_reference` SET TAGS ('dbx_business_glossary_term' = 'Tracking Reference');
ALTER TABLE `mining_ecm`.`procurement`.`freight_order` ALTER COLUMN `transport_mode` SET TAGS ('dbx_business_glossary_term' = 'Transport Mode');
ALTER TABLE `mining_ecm`.`procurement`.`freight_order` ALTER COLUMN `transport_mode` SET TAGS ('dbx_value_regex' = 'road|rail|sea|air|pipeline|multimodal');
ALTER TABLE `mining_ecm`.`procurement`.`freight_order` ALTER COLUMN `volume_cubic_metres` SET TAGS ('dbx_business_glossary_term' = 'Volume (Cubic Metres)');
ALTER TABLE `mining_ecm`.`procurement`.`freight_order` ALTER COLUMN `voyage_number` SET TAGS ('dbx_business_glossary_term' = 'Voyage Number');
ALTER TABLE `mining_ecm`.`procurement`.`physical_inventory` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `mining_ecm`.`procurement`.`physical_inventory` SET TAGS ('dbx_subdomain' = 'inventory_movement');
ALTER TABLE `mining_ecm`.`procurement`.`physical_inventory` ALTER COLUMN `physical_inventory_id` SET TAGS ('dbx_business_glossary_term' = 'Physical Inventory Identifier');
ALTER TABLE `mining_ecm`.`procurement`.`physical_inventory` ALTER COLUMN `cost_centre_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Centre Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`procurement`.`physical_inventory` ALTER COLUMN `general_ledger_account_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger Account Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`procurement`.`physical_inventory` ALTER COLUMN `inventory_balance_id` SET TAGS ('dbx_business_glossary_term' = 'Inventory Balance Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`procurement`.`physical_inventory` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`procurement`.`physical_inventory` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Identifier');
ALTER TABLE `mining_ecm`.`procurement`.`physical_inventory` ALTER COLUMN `warehouse_location_id` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`procurement`.`physical_inventory` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `mining_ecm`.`procurement`.`physical_inventory` ALTER COLUMN `approval_required_indicator` SET TAGS ('dbx_business_glossary_term' = 'Approval Required Indicator');
ALTER TABLE `mining_ecm`.`procurement`.`physical_inventory` ALTER COLUMN `approved_by_user` SET TAGS ('dbx_business_glossary_term' = 'Approved By User');
ALTER TABLE `mining_ecm`.`procurement`.`physical_inventory` ALTER COLUMN `approved_by_user` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,12}$');
ALTER TABLE `mining_ecm`.`procurement`.`physical_inventory` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Number');
ALTER TABLE `mining_ecm`.`procurement`.`physical_inventory` ALTER COLUMN `batch_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,10}$');
ALTER TABLE `mining_ecm`.`procurement`.`physical_inventory` ALTER COLUMN `book_quantity` SET TAGS ('dbx_business_glossary_term' = 'Book Quantity');
ALTER TABLE `mining_ecm`.`procurement`.`physical_inventory` ALTER COLUMN `count_date` SET TAGS ('dbx_business_glossary_term' = 'Physical Count Date');
ALTER TABLE `mining_ecm`.`procurement`.`physical_inventory` ALTER COLUMN `count_status` SET TAGS ('dbx_business_glossary_term' = 'Physical Count Status');
ALTER TABLE `mining_ecm`.`procurement`.`physical_inventory` ALTER COLUMN `count_status` SET TAGS ('dbx_value_regex' = 'created|counted|recounted|posted|cancelled');
ALTER TABLE `mining_ecm`.`procurement`.`physical_inventory` ALTER COLUMN `count_type` SET TAGS ('dbx_business_glossary_term' = 'Physical Count Type');
ALTER TABLE `mining_ecm`.`procurement`.`physical_inventory` ALTER COLUMN `count_type` SET TAGS ('dbx_value_regex' = 'scheduled|ad_hoc|cycle_count|annual|spot_check');
ALTER TABLE `mining_ecm`.`procurement`.`physical_inventory` ALTER COLUMN `counted_quantity` SET TAGS ('dbx_business_glossary_term' = 'Counted Quantity');
ALTER TABLE `mining_ecm`.`procurement`.`physical_inventory` ALTER COLUMN `counter_name` SET TAGS ('dbx_business_glossary_term' = 'Counter Name');
ALTER TABLE `mining_ecm`.`procurement`.`physical_inventory` ALTER COLUMN `counter_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`procurement`.`physical_inventory` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `mining_ecm`.`procurement`.`physical_inventory` ALTER COLUMN `created_by_user` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,12}$');
ALTER TABLE `mining_ecm`.`procurement`.`physical_inventory` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `mining_ecm`.`procurement`.`physical_inventory` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `mining_ecm`.`procurement`.`physical_inventory` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `mining_ecm`.`procurement`.`physical_inventory` ALTER COLUMN `document_number` SET TAGS ('dbx_business_glossary_term' = 'Physical Inventory Document Number');
ALTER TABLE `mining_ecm`.`procurement`.`physical_inventory` ALTER COLUMN `document_number` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `mining_ecm`.`procurement`.`physical_inventory` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `mining_ecm`.`procurement`.`physical_inventory` ALTER COLUMN `freeze_book_inventory_indicator` SET TAGS ('dbx_business_glossary_term' = 'Freeze Book Inventory Indicator');
ALTER TABLE `mining_ecm`.`procurement`.`physical_inventory` ALTER COLUMN `last_modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `mining_ecm`.`procurement`.`physical_inventory` ALTER COLUMN `last_modified_by_user` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,12}$');
ALTER TABLE `mining_ecm`.`procurement`.`physical_inventory` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `mining_ecm`.`procurement`.`physical_inventory` ALTER COLUMN `material_description` SET TAGS ('dbx_business_glossary_term' = 'Material Description');
ALTER TABLE `mining_ecm`.`procurement`.`physical_inventory` ALTER COLUMN `material_document_number` SET TAGS ('dbx_business_glossary_term' = 'Material Document Number');
ALTER TABLE `mining_ecm`.`procurement`.`physical_inventory` ALTER COLUMN `material_document_number` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `mining_ecm`.`procurement`.`physical_inventory` ALTER COLUMN `plant_code` SET TAGS ('dbx_business_glossary_term' = 'Plant Code');
ALTER TABLE `mining_ecm`.`procurement`.`physical_inventory` ALTER COLUMN `plant_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `mining_ecm`.`procurement`.`physical_inventory` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Date');
ALTER TABLE `mining_ecm`.`procurement`.`physical_inventory` ALTER COLUMN `posting_status` SET TAGS ('dbx_business_glossary_term' = 'Posting Status');
ALTER TABLE `mining_ecm`.`procurement`.`physical_inventory` ALTER COLUMN `posting_status` SET TAGS ('dbx_value_regex' = 'not_posted|posted|posting_error');
ALTER TABLE `mining_ecm`.`procurement`.`physical_inventory` ALTER COLUMN `reason_code` SET TAGS ('dbx_business_glossary_term' = 'Variance Reason Code');
ALTER TABLE `mining_ecm`.`procurement`.`physical_inventory` ALTER COLUMN `reason_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,4}$');
ALTER TABLE `mining_ecm`.`procurement`.`physical_inventory` ALTER COLUMN `reason_description` SET TAGS ('dbx_business_glossary_term' = 'Variance Reason Description');
ALTER TABLE `mining_ecm`.`procurement`.`physical_inventory` ALTER COLUMN `recount_date` SET TAGS ('dbx_business_glossary_term' = 'Recount Date');
ALTER TABLE `mining_ecm`.`procurement`.`physical_inventory` ALTER COLUMN `recount_indicator` SET TAGS ('dbx_business_glossary_term' = 'Recount Indicator');
ALTER TABLE `mining_ecm`.`procurement`.`physical_inventory` ALTER COLUMN `special_stock_indicator` SET TAGS ('dbx_business_glossary_term' = 'Special Stock Indicator');
ALTER TABLE `mining_ecm`.`procurement`.`physical_inventory` ALTER COLUMN `special_stock_indicator` SET TAGS ('dbx_value_regex' = '^[A-Z]{1}$');
ALTER TABLE `mining_ecm`.`procurement`.`physical_inventory` ALTER COLUMN `tolerance_exceeded_indicator` SET TAGS ('dbx_business_glossary_term' = 'Tolerance Exceeded Indicator');
ALTER TABLE `mining_ecm`.`procurement`.`physical_inventory` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `mining_ecm`.`procurement`.`physical_inventory` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,3}$');
ALTER TABLE `mining_ecm`.`procurement`.`physical_inventory` ALTER COLUMN `variance_quantity` SET TAGS ('dbx_business_glossary_term' = 'Variance Quantity');
ALTER TABLE `mining_ecm`.`procurement`.`physical_inventory` ALTER COLUMN `variance_value` SET TAGS ('dbx_business_glossary_term' = 'Variance Value');
ALTER TABLE `mining_ecm`.`procurement`.`contract` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `mining_ecm`.`procurement`.`contract` SET TAGS ('dbx_subdomain' = 'supplier_contracts');
ALTER TABLE `mining_ecm`.`procurement`.`contract` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Procurement Contract ID');
ALTER TABLE `mining_ecm`.`procurement`.`contract` ALTER COLUMN `commodity_id` SET TAGS ('dbx_business_glossary_term' = 'Commodity Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`procurement`.`contract` ALTER COLUMN `framework_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Framework Agreement Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`procurement`.`contract` ALTER COLUMN `price_index_id` SET TAGS ('dbx_business_glossary_term' = 'Price Index Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`procurement`.`contract` ALTER COLUMN `pricing_basis_id` SET TAGS ('dbx_business_glossary_term' = 'Pricing Basis Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`procurement`.`contract` ALTER COLUMN `specification_id` SET TAGS ('dbx_business_glossary_term' = 'Specification Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`procurement`.`contract` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `mining_ecm`.`procurement`.`contract` ALTER COLUMN `amendment_count` SET TAGS ('dbx_business_glossary_term' = 'Amendment Count');
ALTER TABLE `mining_ecm`.`procurement`.`contract` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Approval Date');
ALTER TABLE `mining_ecm`.`procurement`.`contract` ALTER COLUMN `approved_by_name` SET TAGS ('dbx_business_glossary_term' = 'Approved By Name');
ALTER TABLE `mining_ecm`.`procurement`.`contract` ALTER COLUMN `base_price` SET TAGS ('dbx_business_glossary_term' = 'Base Price');
ALTER TABLE `mining_ecm`.`procurement`.`contract` ALTER COLUMN `base_price` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`procurement`.`contract` ALTER COLUMN `company_code` SET TAGS ('dbx_business_glossary_term' = 'Company Code');
ALTER TABLE `mining_ecm`.`procurement`.`contract` ALTER COLUMN `contract_number` SET TAGS ('dbx_business_glossary_term' = 'Contract Number');
ALTER TABLE `mining_ecm`.`procurement`.`contract` ALTER COLUMN `contract_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `mining_ecm`.`procurement`.`contract` ALTER COLUMN `contract_status` SET TAGS ('dbx_business_glossary_term' = 'Contract Status');
ALTER TABLE `mining_ecm`.`procurement`.`contract` ALTER COLUMN `contract_type` SET TAGS ('dbx_business_glossary_term' = 'Contract Type');
ALTER TABLE `mining_ecm`.`procurement`.`contract` ALTER COLUMN `contract_type` SET TAGS ('dbx_value_regex' = 'blanket_order|outline_agreement|schedule_agreement|service_contract|framework_agreement|call_off_contract');
ALTER TABLE `mining_ecm`.`procurement`.`contract` ALTER COLUMN `contracted_quantity` SET TAGS ('dbx_business_glossary_term' = 'Contracted Quantity');
ALTER TABLE `mining_ecm`.`procurement`.`contract` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `mining_ecm`.`procurement`.`contract` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `mining_ecm`.`procurement`.`contract` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `mining_ecm`.`procurement`.`contract` ALTER COLUMN `delivery_lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Delivery Lead Time (Days)');
ALTER TABLE `mining_ecm`.`procurement`.`contract` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Contract End Date');
ALTER TABLE `mining_ecm`.`procurement`.`contract` ALTER COLUMN `incoterms_code` SET TAGS ('dbx_business_glossary_term' = 'Incoterms Code');
ALTER TABLE `mining_ecm`.`procurement`.`contract` ALTER COLUMN `incoterms_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `mining_ecm`.`procurement`.`contract` ALTER COLUMN `incoterms_location` SET TAGS ('dbx_business_glossary_term' = 'Incoterms Location');
ALTER TABLE `mining_ecm`.`procurement`.`contract` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `mining_ecm`.`procurement`.`contract` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `mining_ecm`.`procurement`.`contract` ALTER COLUMN `latest_amendment_date` SET TAGS ('dbx_business_glossary_term' = 'Latest Amendment Date');
ALTER TABLE `mining_ecm`.`procurement`.`contract` ALTER COLUMN `latest_amendment_description` SET TAGS ('dbx_business_glossary_term' = 'Latest Amendment Description');
ALTER TABLE `mining_ecm`.`procurement`.`contract` ALTER COLUMN `latest_amendment_number` SET TAGS ('dbx_business_glossary_term' = 'Latest Amendment Number');
ALTER TABLE `mining_ecm`.`procurement`.`contract` ALTER COLUMN `maximum_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Maximum Order Quantity');
ALTER TABLE `mining_ecm`.`procurement`.`contract` ALTER COLUMN `minimum_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity (MOQ)');
ALTER TABLE `mining_ecm`.`procurement`.`contract` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `mining_ecm`.`procurement`.`contract` ALTER COLUMN `owner_email` SET TAGS ('dbx_business_glossary_term' = 'Contract Owner Email Address');
ALTER TABLE `mining_ecm`.`procurement`.`contract` ALTER COLUMN `owner_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `mining_ecm`.`procurement`.`contract` ALTER COLUMN `owner_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `mining_ecm`.`procurement`.`contract` ALTER COLUMN `owner_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `mining_ecm`.`procurement`.`contract` ALTER COLUMN `owner_name` SET TAGS ('dbx_business_glossary_term' = 'Contract Owner Name');
ALTER TABLE `mining_ecm`.`procurement`.`contract` ALTER COLUMN `payment_terms_code` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms Code');
ALTER TABLE `mining_ecm`.`procurement`.`contract` ALTER COLUMN `performance_kpi_description` SET TAGS ('dbx_business_glossary_term' = 'Performance Key Performance Indicator (KPI) Description');
ALTER TABLE `mining_ecm`.`procurement`.`contract` ALTER COLUMN `plant_code` SET TAGS ('dbx_business_glossary_term' = 'Plant Code');
ALTER TABLE `mining_ecm`.`procurement`.`contract` ALTER COLUMN `price_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Price Effective Date');
ALTER TABLE `mining_ecm`.`procurement`.`contract` ALTER COLUMN `price_escalation_clause` SET TAGS ('dbx_business_glossary_term' = 'Price Escalation Clause');
ALTER TABLE `mining_ecm`.`procurement`.`contract` ALTER COLUMN `price_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Price Expiry Date');
ALTER TABLE `mining_ecm`.`procurement`.`contract` ALTER COLUMN `price_review_frequency` SET TAGS ('dbx_business_glossary_term' = 'Price Review Frequency');
ALTER TABLE `mining_ecm`.`procurement`.`contract` ALTER COLUMN `price_review_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|semi_annually|annually|biannually|ad_hoc');
ALTER TABLE `mining_ecm`.`procurement`.`contract` ALTER COLUMN `price_unit` SET TAGS ('dbx_business_glossary_term' = 'Price Unit');
ALTER TABLE `mining_ecm`.`procurement`.`contract` ALTER COLUMN `purchasing_group` SET TAGS ('dbx_business_glossary_term' = 'Purchasing Group');
ALTER TABLE `mining_ecm`.`procurement`.`contract` ALTER COLUMN `purchasing_organization` SET TAGS ('dbx_business_glossary_term' = 'Purchasing Organization');
ALTER TABLE `mining_ecm`.`procurement`.`contract` ALTER COLUMN `renewal_indicator` SET TAGS ('dbx_business_glossary_term' = 'Renewal Indicator');
ALTER TABLE `mining_ecm`.`procurement`.`contract` ALTER COLUMN `renewal_notice_period_days` SET TAGS ('dbx_business_glossary_term' = 'Renewal Notice Period (Days)');
ALTER TABLE `mining_ecm`.`procurement`.`contract` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Start Date');
ALTER TABLE `mining_ecm`.`procurement`.`contract` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Termination Date');
ALTER TABLE `mining_ecm`.`procurement`.`contract` ALTER COLUMN `termination_notice_period_days` SET TAGS ('dbx_business_glossary_term' = 'Termination Notice Period (Days)');
ALTER TABLE `mining_ecm`.`procurement`.`contract` ALTER COLUMN `termination_reason` SET TAGS ('dbx_business_glossary_term' = 'Contract Termination Reason');
ALTER TABLE `mining_ecm`.`procurement`.`contract` ALTER COLUMN `total_contract_value` SET TAGS ('dbx_business_glossary_term' = 'Total Contract Value');
ALTER TABLE `mining_ecm`.`procurement`.`contract` ALTER COLUMN `total_contract_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `mining_ecm`.`procurement`.`contract` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `mining_ecm`.`procurement`.`vendor_performance` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `mining_ecm`.`procurement`.`vendor_performance` SET TAGS ('dbx_subdomain' = 'supplier_contracts');
ALTER TABLE `mining_ecm`.`procurement`.`vendor_performance` ALTER COLUMN `vendor_performance_id` SET TAGS ('dbx_business_glossary_term' = 'vendor_performance Identifier');
ALTER TABLE `mining_ecm`.`procurement`.`vendor_performance` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`procurement`.`vendor_performance` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`procurement`.`vendor_performance` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`procurement`.`price_schedule` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `mining_ecm`.`procurement`.`price_schedule` SET TAGS ('dbx_subdomain' = 'supplier_contracts');
ALTER TABLE `mining_ecm`.`procurement`.`price_schedule` ALTER COLUMN `price_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Price Schedule Identifier (ID)');
ALTER TABLE `mining_ecm`.`procurement`.`price_schedule` ALTER COLUMN `commodity_id` SET TAGS ('dbx_business_glossary_term' = 'Commodity Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`procurement`.`price_schedule` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Identifier (ID)');
ALTER TABLE `mining_ecm`.`procurement`.`price_schedule` ALTER COLUMN `framework_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Framework Agreement Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`procurement`.`price_schedule` ALTER COLUMN `price_index_id` SET TAGS ('dbx_business_glossary_term' = 'Price Index Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`procurement`.`price_schedule` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Identifier (ID)');
ALTER TABLE `mining_ecm`.`procurement`.`price_schedule` ALTER COLUMN `tertiary_price_material_master_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `mining_ecm`.`procurement`.`price_schedule` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Identifier (ID)');
ALTER TABLE `mining_ecm`.`procurement`.`price_schedule` ALTER COLUMN `warehouse_location_id` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Location Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`procurement`.`price_schedule` ALTER COLUMN `approval_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Approval Required Flag');
ALTER TABLE `mining_ecm`.`procurement`.`price_schedule` ALTER COLUMN `auto_po_creation_flag` SET TAGS ('dbx_business_glossary_term' = 'Automatic Purchase Order (PO) Creation Flag');
ALTER TABLE `mining_ecm`.`procurement`.`price_schedule` ALTER COLUMN `base_price` SET TAGS ('dbx_business_glossary_term' = 'Base Price');
ALTER TABLE `mining_ecm`.`procurement`.`price_schedule` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `mining_ecm`.`procurement`.`price_schedule` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `mining_ecm`.`procurement`.`price_schedule` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `mining_ecm`.`procurement`.`price_schedule` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `mining_ecm`.`procurement`.`price_schedule` ALTER COLUMN `delivery_lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Delivery Lead Time (Days)');
ALTER TABLE `mining_ecm`.`procurement`.`price_schedule` ALTER COLUMN `effective_from_date` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `mining_ecm`.`procurement`.`price_schedule` ALTER COLUMN `effective_to_date` SET TAGS ('dbx_business_glossary_term' = 'Effective To Date');
ALTER TABLE `mining_ecm`.`procurement`.`price_schedule` ALTER COLUMN `escalation_formula` SET TAGS ('dbx_business_glossary_term' = 'Escalation Formula');
ALTER TABLE `mining_ecm`.`procurement`.`price_schedule` ALTER COLUMN `incoterms_code` SET TAGS ('dbx_business_glossary_term' = 'Incoterms Code');
ALTER TABLE `mining_ecm`.`procurement`.`price_schedule` ALTER COLUMN `incoterms_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `mining_ecm`.`procurement`.`price_schedule` ALTER COLUMN `last_modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `mining_ecm`.`procurement`.`price_schedule` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `mining_ecm`.`procurement`.`price_schedule` ALTER COLUMN `maximum_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Maximum Order Quantity');
ALTER TABLE `mining_ecm`.`procurement`.`price_schedule` ALTER COLUMN `minimum_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity (MOQ)');
ALTER TABLE `mining_ecm`.`procurement`.`price_schedule` ALTER COLUMN `payment_terms_code` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms Code');
ALTER TABLE `mining_ecm`.`procurement`.`price_schedule` ALTER COLUMN `price_basis` SET TAGS ('dbx_business_glossary_term' = 'Price Basis');
ALTER TABLE `mining_ecm`.`procurement`.`price_schedule` ALTER COLUMN `price_basis` SET TAGS ('dbx_value_regex' = 'fixed|cpi_indexed|commodity_indexed|formula_based|market_linked');
ALTER TABLE `mining_ecm`.`procurement`.`price_schedule` ALTER COLUMN `price_unit` SET TAGS ('dbx_business_glossary_term' = 'Price Unit');
ALTER TABLE `mining_ecm`.`procurement`.`price_schedule` ALTER COLUMN `price_variance_tolerance_percent` SET TAGS ('dbx_business_glossary_term' = 'Price Variance Tolerance Percentage');
ALTER TABLE `mining_ecm`.`procurement`.`price_schedule` ALTER COLUMN `purchasing_group` SET TAGS ('dbx_business_glossary_term' = 'Purchasing Group');
ALTER TABLE `mining_ecm`.`procurement`.`price_schedule` ALTER COLUMN `purchasing_organization` SET TAGS ('dbx_business_glossary_term' = 'Purchasing Organization');
ALTER TABLE `mining_ecm`.`procurement`.`price_schedule` ALTER COLUMN `schedule_notes` SET TAGS ('dbx_business_glossary_term' = 'Price Schedule Notes');
ALTER TABLE `mining_ecm`.`procurement`.`price_schedule` ALTER COLUMN `schedule_number` SET TAGS ('dbx_business_glossary_term' = 'Price Schedule Number');
ALTER TABLE `mining_ecm`.`procurement`.`price_schedule` ALTER COLUMN `schedule_status` SET TAGS ('dbx_business_glossary_term' = 'Price Schedule Status');
ALTER TABLE `mining_ecm`.`procurement`.`price_schedule` ALTER COLUMN `schedule_status` SET TAGS ('dbx_value_regex' = 'draft|active|suspended|expired|cancelled');
ALTER TABLE `mining_ecm`.`procurement`.`price_schedule` ALTER COLUMN `service_description` SET TAGS ('dbx_business_glossary_term' = 'Service Description');
ALTER TABLE `mining_ecm`.`procurement`.`price_schedule` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `mining_ecm`.`procurement`.`price_schedule` ALTER COLUMN `volume_tier` SET TAGS ('dbx_business_glossary_term' = 'Volume Tier');
ALTER TABLE `mining_ecm`.`procurement`.`delivery_schedule` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `mining_ecm`.`procurement`.`delivery_schedule` SET TAGS ('dbx_subdomain' = 'purchase_requisition');
ALTER TABLE `mining_ecm`.`procurement`.`delivery_schedule` ALTER COLUMN `delivery_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Schedule ID');
ALTER TABLE `mining_ecm`.`procurement`.`delivery_schedule` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`procurement`.`delivery_schedule` ALTER COLUMN `freight_order_id` SET TAGS ('dbx_business_glossary_term' = 'Freight Order Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`procurement`.`delivery_schedule` ALTER COLUMN `production_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Production Schedule Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`procurement`.`delivery_schedule` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) ID');
ALTER TABLE `mining_ecm`.`procurement`.`delivery_schedule` ALTER COLUMN `purchase_order_line_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Line Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`procurement`.`delivery_schedule` ALTER COLUMN `revised_delivery_schedule_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `mining_ecm`.`procurement`.`delivery_schedule` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material ID');
ALTER TABLE `mining_ecm`.`procurement`.`delivery_schedule` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `mining_ecm`.`procurement`.`delivery_schedule` ALTER COLUMN `warehouse_location_id` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Location Id (Foreign Key)');
ALTER TABLE `mining_ecm`.`procurement`.`delivery_schedule` ALTER COLUMN `actual_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Delivery Date');
ALTER TABLE `mining_ecm`.`procurement`.`delivery_schedule` ALTER COLUMN `call_off_date` SET TAGS ('dbx_business_glossary_term' = 'Call-Off Date');
ALTER TABLE `mining_ecm`.`procurement`.`delivery_schedule` ALTER COLUMN `called_off_quantity` SET TAGS ('dbx_business_glossary_term' = 'Called-Off Quantity');
ALTER TABLE `mining_ecm`.`procurement`.`delivery_schedule` ALTER COLUMN `company_code` SET TAGS ('dbx_business_glossary_term' = 'Company Code');
ALTER TABLE `mining_ecm`.`procurement`.`delivery_schedule` ALTER COLUMN `confirmed_quantity` SET TAGS ('dbx_business_glossary_term' = 'Confirmed Quantity');
ALTER TABLE `mining_ecm`.`procurement`.`delivery_schedule` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `mining_ecm`.`procurement`.`delivery_schedule` ALTER COLUMN `delivered_quantity` SET TAGS ('dbx_business_glossary_term' = 'Delivered Quantity');
ALTER TABLE `mining_ecm`.`procurement`.`delivery_schedule` ALTER COLUMN `delivery_note_number` SET TAGS ('dbx_business_glossary_term' = 'Delivery Note Number');
ALTER TABLE `mining_ecm`.`procurement`.`delivery_schedule` ALTER COLUMN `delivery_tolerance_percent` SET TAGS ('dbx_business_glossary_term' = 'Delivery Tolerance Percent');
ALTER TABLE `mining_ecm`.`procurement`.`delivery_schedule` ALTER COLUMN `goods_receipt_number` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt (GR) Number');
ALTER TABLE `mining_ecm`.`procurement`.`delivery_schedule` ALTER COLUMN `hazardous_material_indicator` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Material Indicator');
ALTER TABLE `mining_ecm`.`procurement`.`delivery_schedule` ALTER COLUMN `incoterms_code` SET TAGS ('dbx_business_glossary_term' = 'Incoterms Code');
ALTER TABLE `mining_ecm`.`procurement`.`delivery_schedule` ALTER COLUMN `incoterms_location` SET TAGS ('dbx_business_glossary_term' = 'Incoterms Location');
ALTER TABLE `mining_ecm`.`procurement`.`delivery_schedule` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `mining_ecm`.`procurement`.`delivery_schedule` ALTER COLUMN `outstanding_quantity` SET TAGS ('dbx_business_glossary_term' = 'Outstanding Quantity');
ALTER TABLE `mining_ecm`.`procurement`.`delivery_schedule` ALTER COLUMN `planned_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Delivery Date');
ALTER TABLE `mining_ecm`.`procurement`.`delivery_schedule` ALTER COLUMN `plant_code` SET TAGS ('dbx_business_glossary_term' = 'Plant Code');
ALTER TABLE `mining_ecm`.`procurement`.`delivery_schedule` ALTER COLUMN `priority_indicator` SET TAGS ('dbx_business_glossary_term' = 'Priority Indicator');
ALTER TABLE `mining_ecm`.`procurement`.`delivery_schedule` ALTER COLUMN `priority_indicator` SET TAGS ('dbx_value_regex' = 'low|normal|high|urgent');
ALTER TABLE `mining_ecm`.`procurement`.`delivery_schedule` ALTER COLUMN `purchasing_group` SET TAGS ('dbx_business_glossary_term' = 'Purchasing Group');
ALTER TABLE `mining_ecm`.`procurement`.`delivery_schedule` ALTER COLUMN `purchasing_organization` SET TAGS ('dbx_business_glossary_term' = 'Purchasing Organization');
ALTER TABLE `mining_ecm`.`procurement`.`delivery_schedule` ALTER COLUMN `schedule_line_number` SET TAGS ('dbx_business_glossary_term' = 'Schedule Line Number');
ALTER TABLE `mining_ecm`.`procurement`.`delivery_schedule` ALTER COLUMN `schedule_notes` SET TAGS ('dbx_business_glossary_term' = 'Schedule Notes');
ALTER TABLE `mining_ecm`.`procurement`.`delivery_schedule` ALTER COLUMN `schedule_status` SET TAGS ('dbx_business_glossary_term' = 'Schedule Status');
ALTER TABLE `mining_ecm`.`procurement`.`delivery_schedule` ALTER COLUMN `schedule_type` SET TAGS ('dbx_business_glossary_term' = 'Schedule Type');
ALTER TABLE `mining_ecm`.`procurement`.`delivery_schedule` ALTER COLUMN `schedule_type` SET TAGS ('dbx_value_regex' = 'weekly|monthly|quarterly|ad_hoc');
ALTER TABLE `mining_ecm`.`procurement`.`delivery_schedule` ALTER COLUMN `special_handling_instructions` SET TAGS ('dbx_business_glossary_term' = 'Special Handling Instructions');
ALTER TABLE `mining_ecm`.`procurement`.`delivery_schedule` ALTER COLUMN `storage_location_code` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Code');
ALTER TABLE `mining_ecm`.`procurement`.`delivery_schedule` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
