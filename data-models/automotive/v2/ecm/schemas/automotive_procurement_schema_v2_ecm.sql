-- Schema for Domain: procurement | Business:  | Version: v2_ecm
-- Generated on: 2026-06-23 03:51:19

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_automotive_v1`.`procurement` COMMENT 'Strategic sourcing and procurement operations for direct materials (production parts) and indirect materials (MRO, tooling, services). Manages supplier contracts, SOR (Statement of Requirements), purchase requisitions, purchase orders, goods receipt, invoice verification, and spend analytics. Includes global sourcing strategies, supplier development programs, and CapEx procurement workflows. Integrates with SAP MM and Ariba for procure-to-pay processes.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_automotive_v1`.`procurement`.`procurement_supplier` (
    `procurement_supplier_id` BIGINT COMMENT 'System-generated unique identifier for the supplier master record.',
    `parent_supplier_procurement_supplier_id` BIGINT COMMENT 'Identifier of the parent organization in a corporate supplier hierarchy.',
    `address_line1` STRING COMMENT 'First line of the suppliers primary business address.',
    `bank_account_number` STRING COMMENT 'Suppliers bank account number for payments.',
    `bank_name` STRING COMMENT 'Name of the financial institution holding the suppliers account.',
    `certification_status` STRING COMMENT 'Current overall status of the suppliers certifications.. Valid values are `active|expired|pending`',
    `city` STRING COMMENT 'City component of the suppliers primary address.',
    `commodity_specialization` STRING COMMENT 'Specific commodity or material the supplier specializes in providing.',
    `country_code` STRING COMMENT 'Three‑letter ISO country code of the suppliers primary location.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the supplier record was first created.',
    `credit_limit` DECIMAL(18,2) COMMENT 'Maximum credit amount approved for the supplier.',
    `currency_code` STRING COMMENT 'Default currency used for transactions with the supplier.',
    `data_governance_ref` STRING COMMENT 'Reference to data governance catalog entry for lineage and ownership tracking',
    `deactivation_date` DATE COMMENT 'Date when the supplier record was marked inactive or blocked.',
    `duns_number` STRING COMMENT 'Dun & Bradstreet unique identifier for the supplier organization.',
    `iatf16949_cert_expiry` DATE COMMENT 'Expiration date of the suppliers IATF 16949 certification.',
    `iatf16949_certified` BOOLEAN COMMENT 'Indicates whether the supplier holds a valid IATF 16949 certification.',
    `incoterms` STRING COMMENT 'International commercial terms defining delivery responsibilities.. Valid values are `EXW|FOB|CIF|DAP|DDP`',
    `iso14001_cert_expiry` DATE COMMENT 'Expiration date of the ISO 14001 certification.',
    `iso14001_certified` BOOLEAN COMMENT 'Indicates whether the supplier holds an ISO 14001 environmental certification.',
    `iso9001_cert_expiry` DATE COMMENT 'Expiration date of the ISO 9001 certification.',
    `iso9001_certified` BOOLEAN COMMENT 'Indicates whether the supplier is ISO 9001 certified.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent update to the supplier record.',
    `lead_time_days` STRING COMMENT 'Typical number of days from order placement to delivery.',
    `legal_name` STRING COMMENT 'Full legal registered name of the supplier entity.',
    `max_order_quantity` BIGINT COMMENT 'Largest quantity the supplier can deliver in a single order.',
    `min_order_quantity` BIGINT COMMENT 'Smallest quantity the supplier accepts per purchase order.',
    `procurement_supplier_name` STRING COMMENT 'Primary display name of the supplier used in procurement processes.',
    `onboarding_date` DATE COMMENT 'Date when the supplier was first approved for procurement.',
    `payment_terms` STRING COMMENT 'Standard payment condition agreed with the supplier.. Valid values are `net30|net45|net60|cash|prepaid`',
    `postal_code` STRING COMMENT 'Postal or ZIP code of the suppliers primary address.',
    `preferred_language` STRING COMMENT 'Language used for communications with the supplier.',
    `primary_contact_email` STRING COMMENT 'Email address of the primary procurement contact.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `primary_contact_name` STRING COMMENT 'Name of the main contact person for procurement communications.',
    `primary_contact_phone` STRING COMMENT 'Telephone number of the primary procurement contact.',
    `procurement_supplier_status` STRING COMMENT 'Current operational status of the supplier record.. Valid values are `active|inactive|blocked|under_development`',
    `rating_score` DECIMAL(18,2) COMMENT 'Overall performance rating assigned by the procurement team.',
    `risk_score` DECIMAL(18,2) COMMENT 'Risk assessment score based on financial, compliance, and operational factors.',
    `state_province` STRING COMMENT 'State or province of the suppliers primary address.',
    `supplier_category` STRING COMMENT 'Broad business category describing the goods or services supplied.. Valid values are `raw_materials|components|services|logistics|technology`',
    `supplier_type` STRING COMMENT 'Classification of the supplier based on its position in the supply chain.. Valid values are `tier-1|tier-2|tier-3|internal|service`',
    `sustainability_score` DECIMAL(18,2) COMMENT 'Score reflecting the suppliers environmental and social sustainability performance.',
    `swift_code` STRING COMMENT 'International bank identifier for cross‑border payments.',
    `tax_identification_number` STRING COMMENT 'Government‑issued tax identifier for the supplier.',
    `vat_number` STRING COMMENT 'Value‑Added Tax registration number for the supplier.',
    `website_url` STRING COMMENT 'Public website address of the supplier.',
    CONSTRAINT pk_procurement_supplier PRIMARY KEY(`procurement_supplier_id`)
) COMMENT 'Master record for all suppliers and vendors providing direct materials (production parts, raw materials) and indirect materials (MRO, tooling, services) to Automotive. Captures supplier identity, classification (tier-1, tier-2, tier-3), business registration details, DUNS number, tax identifiers, payment terms, currency, incoterms, preferred language, supplier status (active, blocked, under-development), IATF 16949 certification status, ISO 9001/14001 certification flags, geographic footprint, commodity specialization, and strategic sourcing category. SSOT for supplier identity within the procurement domain; integrates with SAP MM vendor master.';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`procurement`.`procurement_supplier_plant` (
    `procurement_supplier_plant_id` BIGINT COMMENT 'Unique system-generated identifier for the supplier-plant relationship record.',
    `packaging_specification_id` BIGINT COMMENT 'Identifier of the packaging specification that the supplier must follow for deliveries to this plant.',
    `plant_id` BIGINT COMMENT 'Unique identifier of the manufacturing plant approved for the supplier.',
    `procurement_supplier_id` BIGINT COMMENT 'Unique identifier of the supplier (vendor) linked to the plant.',
    `address_line1` STRING COMMENT 'First line of the suppliers delivery address for the plant.',
    `address_line2` STRING COMMENT 'Second line of the suppliers delivery address for the plant, if applicable.',
    `approval_date` DATE COMMENT 'Calendar date on which the supplier received approval for the plant.',
    `approval_status` STRING COMMENT 'Lifecycle status of the suppliers approval for this plant.. Valid values are `approved|pending|rejected|suspended`',
    `city` STRING COMMENT 'City component of the suppliers delivery address for the plant.',
    `country_code` STRING COMMENT 'Three‑letter ISO country code of the delivery location.',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the supplier‑plant record was first created.',
    `data_governance_ref` STRING COMMENT 'Reference to data governance catalog entry for lineage and ownership tracking',
    `effective_end_date` DATE COMMENT 'Termination date of the suppliers authorization for the plant; null if open‑ended.',
    `effective_start_date` DATE COMMENT 'First date the supplier is authorized to supply the plant.',
    `freight_terms` STRING COMMENT 'Incoterm that defines cost and risk responsibilities for the shipment.. Valid values are `FOB|CIF|EXW|DDP`',
    `is_preferred_supplier` BOOLEAN COMMENT 'True if the supplier is designated as a preferred source for the plant.',
    `jis_delivery_flag` BOOLEAN COMMENT 'True if the supplier delivers parts in the production sequence (JIS) for this plant.',
    `jit_delivery_flag` BOOLEAN COMMENT 'True if the supplier delivers on a Just‑In‑Time basis for this plant.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent change to this record.',
    `lead_time_days` STRING COMMENT 'Typical number of days from purchase order issuance to receipt at the plant.',
    `minimum_order_quantity` STRING COMMENT 'Smallest quantity the plant will accept for a single delivery from this supplier.',
    `notes` STRING COMMENT 'Additional comments or special instructions related to the supplier‑plant relationship.',
    `postal_code` STRING COMMENT 'Postal/ZIP code of the suppliers delivery address.',
    `procurement_supplier_plant_status` STRING COMMENT 'Current operational status of the supplier‑plant association.. Valid values are `active|inactive|blocked`',
    `quality_rating` STRING COMMENT 'Internal quality score assigned to the supplier for deliveries to this plant.',
    `shipping_method` STRING COMMENT 'Standard mode of transportation used for deliveries to the plant.. Valid values are `truck|rail|ship|air`',
    `state_province` STRING COMMENT 'State or province component of the suppliers delivery address.',
    `supplier_contact_email` STRING COMMENT 'Email address of the suppliers plant liaison.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `supplier_contact_name` STRING COMMENT 'Name of the supplier representative responsible for deliveries to the plant.',
    `supplier_contact_phone` STRING COMMENT 'Telephone number for the suppliers plant liaison.',
    `unloading_point` STRING COMMENT 'Designated dock or bay where the suppliers goods are received at the plant.',
    CONSTRAINT pk_procurement_supplier_plant PRIMARY KEY(`procurement_supplier_plant_id`)
) COMMENT 'Association between a supplier and the Automotive manufacturing plants it is approved to supply. Captures plant-specific supplier data including delivery address, unloading point, JIT/JIS delivery flag, lead time, minimum order quantity, packaging specification reference, and plant-level approval status. Enables plant-level sourcing decisions and inbound logistics planning. Reflects SAP MM vendor-plant extension (LFM1/LFM2).';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`procurement`.`sourcing_event` (
    `sourcing_event_id` BIGINT COMMENT 'System-generated unique identifier for the sourcing event.',
    `eprocurement_portal_id` BIGINT COMMENT 'FK to the e-procurement portal through which this sourcing event was conducted.',
    `procurement_supplier_id` BIGINT COMMENT 'Unique identifier of the primary supplier nominated in the event.',
    `employee_id` BIGINT COMMENT 'Unique identifier of the internal buyer responsible for the event.',
    `sourcing_employee_id` BIGINT COMMENT 'Unique identifier of the internal buyer responsible for the event.',
    `spend_category_id` BIGINT COMMENT 'Foreign key linking to procurement.spend_category. Business justification: Sourcing events are organized by commodity/spend category. The existing commodity_group (STRING) is a denormalized text field. Linking sourcing_event to spend_category enables structured sourcing pipe',
    `supplier_contract_id` BIGINT COMMENT 'Identifier of the contract generated from the awarded event.',
    `vehicle_program_id` BIGINT COMMENT 'Foreign key linking to engineering.vehicle_program. Business justification: Sourcing events are launched per vehicle program to source components; required for program‑level sourcing reports.',
    `award_amount` DECIMAL(18,2) COMMENT 'Final contract value awarded to the selected supplier.',
    `award_currency_code` STRING COMMENT 'Currency of the award amount.. Valid values are `^[A-Z]{3}$`',
    `award_decision_date` DATE COMMENT 'Date on which the supplier award was formally decided.',
    `award_supplier_name` STRING COMMENT 'Legal name of the awarded supplier.',
    `buyer_department` STRING COMMENT 'Organizational department to which the buyer belongs.',
    `buyer_name` STRING COMMENT 'Full name of the internal buyer or procurement team.',
    `commodity_group` STRING COMMENT 'High-level classification of the goods or services being sourced (e.g., Powertrain, Electronics, MRO, Raw_Materials, Software, Services) [ENUM-REF-CANDIDATE: Powertrain|Electronics|MRO|Raw_Materials|Software|Services]',
    `confidentiality_level` STRING COMMENT 'Data classification level for the event record.. Valid values are `restricted|confidential|internal|public`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the sourcing event record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO currency code for monetary amounts.. Valid values are `^[A-Z]{3}$`',
    `data_governance_ref` STRING COMMENT 'Reference to data governance catalog entry for lineage and ownership tracking',
    `sourcing_event_description` STRING COMMENT 'Free-text description providing context and objectives of the sourcing event.',
    `evaluation_method` STRING COMMENT 'Method used to rank and select suppliers.. Valid values are `weighted|lowest_price|best_value`',
    `evaluation_score` DECIMAL(18,2) COMMENT 'Numeric score resulting from the supplier evaluation process.',
    `event_number` STRING COMMENT 'External reference number assigned to the sourcing event, used in communications and reporting.',
    `event_timestamp` TIMESTAMP COMMENT 'Date and time when the sourcing event was officially launched.',
    `event_type` STRING COMMENT 'Indicates whether the event is a Request for Quotation, Request for Information, or Request for Proposal.. Valid values are `RFQ|RFI|RFP`',
    `is_multi_source` BOOLEAN COMMENT 'Indicates whether the event is intended to select multiple suppliers.',
    `is_nda_required` BOOLEAN COMMENT 'True if a non-disclosure agreement is required from participants.',
    `sor_reference` STRING COMMENT 'Reference identifier for the SOR document linked to the event.',
    `sor_version` STRING COMMENT 'Version number of the SOR document used for this event.',
    `sourcing_event_status` STRING COMMENT 'Current lifecycle state of the sourcing event.. Valid values are `draft|open|closed|cancelled|awarded`',
    `sourcing_strategy` STRING COMMENT 'Chosen approach for supplier selection.. Valid values are `single_source|dual_source|competitive_bid|direct_negotiation`',
    `submission_deadline` DATE COMMENT 'Last date suppliers may submit their proposals.',
    `target_spend_amount` DECIMAL(18,2) COMMENT 'Estimated total spend the organization aims to achieve through this event.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the sourcing event record.',
    CONSTRAINT pk_sourcing_event PRIMARY KEY(`sourcing_event_id`)
) COMMENT 'Represents a formal strategic sourcing event initiated by Automotive procurement teams, including RFQ (Request for Quotation), RFI (Request for Information), and RFP (Request for Proposal) events. Captures event type, commodity group, target spend, SOR (Statement of Requirements) reference, sourcing strategy (single-source, dual-source, competitive bid), event status, award decision date, nominated suppliers, and responsible buyer. Supports global sourcing strategy execution and Ariba Sourcing integration.';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`procurement`.`supplier_quote` (
    `supplier_quote_id` BIGINT COMMENT 'Unique system-generated identifier for each supplier quote.',
    `compliance_document_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_document. Business justification: REQUIRED: Quotes for regulated components include a link to the suppliers compliance certificate, needed for part approval and downstream validation.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Supplier Quote Creation – created_by_employee_id identifies the employee who entered the quote, needed for quote provenance and compliance with pricing approval processes.',
    `eprocurement_portal_id` BIGINT COMMENT 'FK to the e-procurement portal through which this quote was submitted.',
    `procurement_supplier_id` BIGINT COMMENT 'Unique identifier of the supplier who submitted the quote.',
    `sku_master_id` BIGINT COMMENT 'Foreign key linking to inventory.sku_master. Business justification: REQUIRED: Quote evaluation compares quoted price against SKU master price list; linking quote to SKU enables price variance analysis.',
    `sourcing_event_id` BIGINT COMMENT 'Reference to the original sourcing request that this quote answers.',
    `vehicle_program_id` BIGINT COMMENT 'Foreign key linking to engineering.vehicle_program. Business justification: Supplier quotes are evaluated against a specific vehicle programs requirements; needed for quote comparison dashboards.',
    `amortization_rate_percent` DECIMAL(18,2) COMMENT 'Percentage rate applied to amortize tooling cost over the term.',
    `amortization_term_months` STRING COMMENT 'Number of months over which tooling cost is amortized.',
    `comments` STRING COMMENT 'Additional remarks or conditions supplied by the vendor.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the quote record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter currency identifier for the quoted amounts.. Valid values are `^[A-Z]{3}$`',
    `discount_amount` DECIMAL(18,2) COMMENT 'Monetary discount the supplier is offering on the base price.',
    `e_sourcing_platform` STRING COMMENT 'E-procurement platform used (Ariba, SupplyOn, Covisint)',
    `is_preferred` BOOLEAN COMMENT 'True if the supplier is marked as preferred for this part in the sourcing strategy.',
    `lead_time_days` STRING COMMENT 'Estimated number of days from order receipt to delivery.',
    `minimum_order_quantity` BIGINT COMMENT 'Smallest quantity the supplier will accept for this part.',
    `net_price` DECIMAL(18,2) COMMENT 'Final price per unit after applying discounts, excluding tax.',
    `payment_terms` STRING COMMENT 'Conditions under which payment must be made for the quoted items.. Valid values are `net_30|net_60|net_90|prepaid|cash_on_delivery|letter_of_credit`',
    `ppap_commitment_date` DATE COMMENT 'Date by which the supplier must complete Production Part Approval Process.',
    `quote_date` DATE COMMENT 'Quote date',
    `quote_number` STRING COMMENT 'Human‑readable reference number assigned to the quote by the procurement system.',
    `quote_status` STRING COMMENT 'Indicates the processing stage of the quote within the sourcing workflow.. Valid values are `submitted|under_review|awarded|rejected`',
    `quote_type` STRING COMMENT 'Indicates whether the quote is a response to an RFQ, RFP, RFI, etc.. Valid values are `rfq|rfp|rfi|rfq_response`',
    `quoted_amount` DECIMAL(18,2) COMMENT '',
    `quoted_price` DECIMAL(18,2) COMMENT 'Base price per unit offered by the supplier.',
    `submission_timestamp` TIMESTAMP COMMENT 'Date and time the supplier formally submitted the quote.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Estimated tax to be added to the net price.',
    `tooling_cost` DECIMAL(18,2) COMMENT 'One‑time cost for tooling or molds required to produce the part.',
    `total_amount` DECIMAL(18,2) COMMENT 'Total amount',
    `total_price` DECIMAL(18,2) COMMENT 'Final amount payable per unit after tax.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the quote record.',
    `valid_until_date` DATE COMMENT '',
    `validity_end_date` DATE COMMENT 'Date after which the quoted prices expire.',
    `validity_start_date` DATE COMMENT 'Date from which the quoted prices are considered valid.',
    CONSTRAINT pk_supplier_quote PRIMARY KEY(`supplier_quote_id`)
) COMMENT 'Supplier response to a sourcing event (RFQ/RFP), capturing quoted unit price, tooling cost, amortization terms, lead time, MOQ (minimum order quantity), payment terms, validity period, PPAP (Production Part Approval Process) commitment date, and quote status (submitted, under-review, awarded, rejected). Enables competitive bid analysis and total cost of ownership (TCO) evaluation. Linked to sourcing events and specific part numbers.';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`procurement`.`purchase_requisition` (
    `purchase_requisition_id` BIGINT COMMENT 'Unique identifier for the purchase requisition.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Requisition cost allocation to cost center is required for pre‑PO budgeting and approval.',
    `eprocurement_portal_id` BIGINT COMMENT 'FK to the e-procurement portal used for this requisition.',
    `equipment_registry_id` BIGINT COMMENT 'Foreign key linking to asset.equipment_registry. Business justification: Equipment Requisition initiates creation of a new equipment asset; linking requisition to equipment registry enables traceability from request to asset.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Requisition GL account enables automatic posting of approved requisitions to the ledger.',
    `opportunity_id` BIGINT COMMENT 'Foreign key linking to sales.opportunity. Business justification: Required for Procurement requisition generation from a won sales opportunity – experts expect a direct link to track which opportunity triggered the requisition.',
    `plant_id` BIGINT COMMENT 'Foreign key linking to manufacturing.plant. Business justification: Required for Plant Requisition Allocation Report linking each requisition to its manufacturing plant.',
    `employee_id` BIGINT COMMENT 'Identifier of the employee who created the requisition.',
    `procurement_supplier_id` BIGINT COMMENT 'Identifier of the selected vendor for the requisition (if known).',
    `purchase_approved_by_employee_id` BIGINT COMMENT 'Identifier of the employee who approved the requisition.',
    `purchase_employee_id` BIGINT COMMENT 'Identifier of the employee who created the requisition.',
    `sku_master_id` BIGINT COMMENT 'Foreign key linking to inventory.sku_master. Business justification: REQUIRED: Requisition planning and allocation reports need the SKU master to forecast demand and allocate inventory.',
    `spend_category_id` BIGINT COMMENT 'Foreign key linking to procurement.spend_category. Business justification: Purchase requisitions should be classified by spend category for spend analytics and sourcing strategy alignment. Linking purchase_requisition to spend_category enables category-level demand visibilit',
    `supplier_contract_id` BIGINT COMMENT 'Foreign key linking to procurement.supplier_contract. Business justification: In SAP MM, a purchase requisition can reference a source of supply (outline agreement/contract) to indicate which contract should be used for conversion to a PO. The existing source_of_supply field is',
    `vehicle_program_id` BIGINT COMMENT 'Foreign key linking to engineering.vehicle_program. Business justification: Program‑specific purchase requisition; finance and engineering track spend per vehicle program.',
    `vendor_id` BIGINT COMMENT 'Identifier of the selected vendor for the requisition (if known).',
    `account_assignment_category` STRING COMMENT 'Category indicating how the cost will be allocated (e.g., cost center, project).. Valid values are `cost_center|project|asset|order`',
    `approval_status` STRING COMMENT 'Current approval state of the requisition.. Valid values are `pending|approved|rejected`',
    `approved_timestamp` TIMESTAMP COMMENT 'Timestamp when the requisition was approved.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 currency code for the estimated value.. Valid values are `^[A-Z]{3}$`',
    `data_governance_ref` STRING COMMENT 'Reference to data governance catalog entry for lineage and ownership tracking',
    `estimated_value` DECIMAL(18,2) COMMENT 'Estimated monetary value of the requisition before approval.',
    `is_converted_to_po` BOOLEAN COMMENT 'Indicates whether the requisition has been converted into a purchase order.',
    `notes` STRING COMMENT 'Free‑text field for additional comments or special instructions.',
    `payment_terms` STRING COMMENT 'Standard payment terms (e.g., NET30) associated with the requisition.',
    `priority` STRING COMMENT 'Priority level assigned to the requisition for processing urgency.. Valid values are `low|medium|high|critical`',
    `procurement_type` STRING COMMENT 'Indicates whether the requisition is for direct materials, indirect, services, or capital assets.. Valid values are `direct|indirect|service|capital`',
    `purchase_group` STRING COMMENT 'Organizational group responsible for processing the requisition.',
    `purchase_order_number` STRING COMMENT 'Reference number of the purchase order generated from this requisition.',
    `purchase_requisition_status` STRING COMMENT 'Current lifecycle status of the requisition.. Valid values are `draft|submitted|approved|rejected|closed|cancelled`',
    `quantity` DECIMAL(18,2) COMMENT 'Quantity of the material or service requested.',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when the record was first captured in the system.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent update to the record.',
    `required_delivery_date` DATE COMMENT 'Date by which the material or service is needed.',
    `requisition_date` DATE COMMENT 'Date when the requisition was initially created.',
    `requisition_number` STRING COMMENT 'Business identifier assigned to the purchase requisition.',
    `source_of_supply` STRING COMMENT 'Specifies if the supply is internal, external vendor, or consignment.. Valid values are `internal|external|consignment`',
    `tax_code` STRING COMMENT 'Tax classification code applicable to the requisition.',
    `unit_of_measure` STRING COMMENT 'Unit in which the quantity is expressed (e.g., EA, KG, L).',
    CONSTRAINT pk_purchase_requisition PRIMARY KEY(`purchase_requisition_id`)
) COMMENT 'Internal request to procure direct or indirect materials, tooling, or services. Captures requisition number, requestor, cost center, plant, material/service description, quantity, required delivery date, estimated value, account assignment category (cost center, project, asset), approval status, and conversion-to-PO status. Represents the demand signal that initiates the procure-to-pay cycle. Sourced from SAP MM MRP-generated or manually created purchase requisitions (BANF/EBAN).';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`procurement`.`procurement_purchase_order` (
    `procurement_purchase_order_id` BIGINT COMMENT 'System-generated unique identifier for the purchase order record.',
    `compliance_document_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_document. Business justification: REQUIRED: PO must reference the compliance certification document for regulated parts (emissions, safety) to satisfy audit and legal reporting.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Required for PO cost allocation report; finance tracks spend by cost center for each purchase order.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Purchase Order Creation – created_by_employee_id logs the employee who created the PO, a mandatory field for PO creation audit and responsibility tracking.',
    `eprocurement_portal_id` BIGINT COMMENT 'FK to the e-procurement portal used for this purchase order.',
    `equipment_registry_id` BIGINT COMMENT 'Foreign key linking to asset.equipment_registry. Business justification: Capital Equipment Procurement process requires linking PO to the registered equipment asset for depreciation, warranty, and maintenance tracking.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: GL account needed for posting PO amounts to the general ledger; mandatory for financial statements.',
    `inspection_plan_id` BIGINT COMMENT 'Foreign key linking to quality.inspection_plan. Business justification: Incoming Inspection Planning: each PO is assigned an inspection plan used by quality to inspect received parts; standard practice in automotive manufacturing.',
    `plant_id` BIGINT COMMENT 'Identifier of the manufacturing plant or site receiving the goods/services.',
    `procurement_supplier_id` BIGINT COMMENT 'Unique identifier of the supplier (vendor) to which the purchase order is issued.',
    `production_line_id` BIGINT COMMENT 'Foreign key linking to manufacturing.production_line. Business justification: Needed for Line Delivery Schedule to allocate PO deliveries to specific production lines.',
    `supplier_contract_id` BIGINT COMMENT 'Identifier of the underlying procurement contract or framework agreement, if applicable.',
    `vehicle_order_id` BIGINT COMMENT 'Foreign key linking to sales.vehicle_order. Business justification: Needed for Production scheduling report that ties each PO of parts to the specific vehicle order it supplies.',
    `vehicle_program_id` BIGINT COMMENT 'Foreign key linking to engineering.vehicle_program. Business justification: Purchase orders are linked to vehicle programs for cost allocation and program profitability analysis.',
    `account_assignment` STRING COMMENT 'Cost object (e.g., cost center, internal order) to which the PO costs are charged.',
    `approval_status` STRING COMMENT 'Current status of the internal approval workflow for the PO.. Valid values are `pending|approved|rejected`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the purchase order record was first inserted into the data lake.',
    `currency_code` STRING COMMENT 'Three‑letter code of the currency used for the monetary amounts.. Valid values are `USD|EUR|JPY|CNY|GBP|CHF`',
    `currency_rate` DECIMAL(18,2) COMMENT 'Rate used to convert foreign currency amounts to the company code currency.',
    `data_governance_ref` STRING COMMENT 'Reference to data governance catalog entry for lineage and ownership tracking',
    `delivery_date` DATE COMMENT 'Planned date by which the supplier should deliver the ordered items.',
    `goods_receipt_date` DATE COMMENT 'Date on which the ordered goods were physically received at the plant.',
    `gr_ir_control_flag` BOOLEAN COMMENT 'Indicates whether Goods Receipt/Invoice Receipt (GR/IR) posting is active for this PO.',
    `gross_amount` DECIMAL(18,2) COMMENT 'Total payable amount including net amount, taxes, and any surcharges.',
    `incoterms` STRING COMMENT 'Standardized trade terms defining delivery responsibilities and costs.. Valid values are `EXW|FCA|CPT|CIP|DAP|DDP`',
    `invoice_receipt_date` DATE COMMENT 'Date on which the suppliers invoice was recorded in the system.',
    `net_amount` DECIMAL(18,2) COMMENT 'Total amount of the purchase order before taxes, fees, and discounts.',
    `order_date` DATE COMMENT 'Date on which the purchase order was created or released.',
    `payment_terms` STRING COMMENT 'Negotiated terms governing when and how the supplier will be paid.',
    `po_number` STRING COMMENT 'Externally visible purchase order number assigned by the procurement system.',
    `po_type` STRING COMMENT 'Category of the purchase order indicating its procurement contract model.. Valid values are `standard|blanket|consignment|subcontract|service`',
    `procurement_purchase_order_status` STRING COMMENT 'Current lifecycle state of the purchase order within the procure-to-pay process.. Valid values are `draft|released|approved|partially_received|closed|cancelled`',
    `purchase_group` STRING COMMENT 'Organizational group responsible for processing the purchase order.',
    `purchasing_organization` STRING COMMENT 'Entity within the enterprise that conducts procurement activities.',
    `supplier_name` STRING COMMENT 'Legal name of the supplier organization.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Aggregate tax amount applicable to the purchase order.',
    `tax_code` STRING COMMENT 'Code representing the tax jurisdiction and rate applied to the PO.',
    `total_quantity` BIGINT COMMENT 'Aggregate quantity of all line items on the purchase order.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the purchase order record.',
    CONSTRAINT pk_procurement_purchase_order PRIMARY KEY(`procurement_purchase_order_id`)
) COMMENT 'Legally binding procurement document issued to a supplier for delivery of direct materials, indirect materials, MRO, tooling, or services. Captures PO number, PO type (standard, blanket, consignment, subcontracting, service), supplier, plant, delivery date, incoterms, payment terms, total net value, currency, tax code, account assignment, approval workflow status, and GR/IR (Goods Receipt/Invoice Receipt) control flags. Core transactional entity of the procure-to-pay process. Sourced from SAP MM (EKKO/EKPO).';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`procurement`.`procurement_po_line` (
    `procurement_po_line_id` BIGINT COMMENT 'Primary key',
    `commodity_group_id` BIGINT COMMENT 'FK to the commodity group for this PO line item.',
    `cost_center_id` BIGINT COMMENT 'FK to cost center',
    `employee_id` BIGINT COMMENT 'FK to employee',
    `gl_account_id` BIGINT COMMENT 'FK to GL account',
    `inspection_plan_id` BIGINT COMMENT 'FK to inspection plan',
    `plant_id` BIGINT COMMENT 'FK to plant',
    `procurement_purchase_order_id` BIGINT COMMENT 'FK to purchase order',
    `procurement_supplier_id` BIGINT COMMENT 'FK to supplier',
    `sku_master_id` BIGINT COMMENT 'FK to SKU master',
    `spend_category_id` BIGINT COMMENT 'Foreign key linking to procurement.spend_category. Business justification: PO lines represent the actual committed spend and should be classified by spend_category for spend cube construction. The existing commodity_group_id links to supply.commodity_group (cross-domain), bu',
    `account_assignment_category` STRING COMMENT 'Account assignment category',
    `batch_management_flag` BOOLEAN COMMENT 'Whether batch management is enabled',
    `batch_number` STRING COMMENT 'Batch number',
    `confirmation_date` DATE COMMENT 'Confirmation date',
    `contract_number` STRING COMMENT 'Contract number reference',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `currency_code` STRING COMMENT 'Currency code',
    `data_governance_ref` STRING COMMENT 'Reference to data governance catalog entry for lineage and ownership tracking',
    `delivery_date` DATE COMMENT 'Expected delivery date',
    `goods_receipt_date` DATE COMMENT 'Goods receipt date',
    `gross_amount` DECIMAL(18,2) COMMENT 'Gross line amount',
    `internal_order_number` STRING COMMENT 'Internal order number',
    `invoice_number` STRING COMMENT 'Invoice number',
    `invoice_receipt_date` DATE COMMENT 'Invoice receipt date',
    `is_blocked` BOOLEAN COMMENT 'Whether line is blocked',
    `is_deleted` BOOLEAN COMMENT 'Soft delete flag',
    `last_updated_by` STRING COMMENT 'Last updated by user',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Last update timestamp',
    `line_number` STRING COMMENT 'PO line number',
    `line_status` STRING COMMENT 'Line status',
    `net_amount` DECIMAL(18,2) COMMENT 'Net line amount',
    `net_price` DECIMAL(18,2) COMMENT 'Net price per unit',
    `over_delivery_tolerance_percent` DECIMAL(18,2) COMMENT 'Over delivery tolerance percentage',
    `ppap_level` STRING COMMENT 'PPAP level required',
    `price_condition` DECIMAL(18,2) COMMENT 'Price condition amount',
    `purchasing_group` STRING COMMENT 'Purchasing group code',
    `quality_inspection_required` BOOLEAN COMMENT 'Whether quality inspection is required',
    `quantity_ordered` DECIMAL(18,2) COMMENT 'Quantity ordered',
    `release_number` STRING COMMENT 'Release number',
    `remarks` STRING COMMENT 'Remarks',
    `short_text` STRING COMMENT 'Short text description',
    `source_of_supply` STRING COMMENT 'Source of supply',
    `storage_location` STRING COMMENT 'Storage location',
    `supplier_part_number` STRING COMMENT 'Supplier part number',
    `tax_amount` DECIMAL(18,2) COMMENT 'Tax amount',
    `tax_code` STRING COMMENT 'Tax code',
    `under_delivery_tolerance_percent` DECIMAL(18,2) COMMENT 'Under delivery tolerance percentage',
    `unit_of_measure` STRING COMMENT 'Unit of measure',
    CONSTRAINT pk_procurement_po_line PRIMARY KEY(`procurement_po_line_id`)
) COMMENT 'Individual line item within a purchase order, representing a specific material, service, or part number being procured. Captures line number, material number, short text, quantity ordered, unit of measure, net price, delivery date, storage location, batch management flag, PPAP level required, over/under-delivery tolerance, and line-level confirmation status. Enables granular spend tracking and goods receipt matching at the part level. Sourced from SAP MM PO item table (EKPO).';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`procurement`.`supplier_contract` (
    `supplier_contract_id` BIGINT COMMENT 'Primary key',
    `employee_id` BIGINT COMMENT 'FK to employee',
    `eprocurement_portal_id` BIGINT COMMENT 'FK to the e-procurement portal managing this contract.',
    `gl_account_id` BIGINT COMMENT 'FK to GL account',
    `procurement_supplier_id` BIGINT COMMENT 'FK to supplier',
    `vehicle_program_id` BIGINT COMMENT 'FK to vehicle program',
    `approval_timestamp` TIMESTAMP COMMENT 'Approval timestamp',
    `audit_trail_notes` STRING COMMENT 'Audit trail notes',
    `compliance_requirements` STRING COMMENT 'Compliance requirements',
    `contract_category` STRING COMMENT 'Contract category',
    `contract_description` STRING COMMENT 'Contract description',
    `contract_document_url` STRING COMMENT 'URL to contract document',
    `contract_number` STRING COMMENT 'Contract number',
    `contract_scope` STRING COMMENT 'Contract scope',
    `contract_status` STRING COMMENT '',
    `contract_type` STRING COMMENT 'Contract type',
    `contract_version` STRING COMMENT 'Contract version number',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `currency_code` STRING COMMENT 'Currency code',
    `data_governance_ref` STRING COMMENT 'Reference to data governance catalog entry for lineage and ownership tracking',
    `delivery_schedule_description` STRING COMMENT 'Delivery schedule description',
    `effective_end_date` DATE COMMENT 'Contract end date',
    `effective_start_date` DATE COMMENT 'Contract start date',
    `governing_law` STRING COMMENT 'Governing law',
    `is_master_agreement` BOOLEAN COMMENT 'Whether this is a master agreement',
    `jurisdiction` STRING COMMENT 'Jurisdiction',
    `last_amended_timestamp` TIMESTAMP COMMENT 'Last amendment timestamp',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Last update timestamp',
    `payment_terms` STRING COMMENT 'Payment terms',
    `penalty_clause` STRING COMMENT 'Penalty clause',
    `price_escalation_clause` DECIMAL(18,2) COMMENT 'Price escalation clause amount',
    `renewal_option` STRING COMMENT 'Renewal option',
    `supplier_contract_status` STRING COMMENT 'Contract status',
    `termination_notice_period_days` STRING COMMENT 'Termination notice period in days',
    `total_contract_value` DECIMAL(18,2) COMMENT 'Total contract value',
    `volume_commitment_quantity` BIGINT COMMENT 'Volume commitment quantity',
    `volume_commitment_uom` STRING COMMENT 'Volume commitment unit of measure',
    CONSTRAINT pk_supplier_contract PRIMARY KEY(`supplier_contract_id`)
) COMMENT 'Long-term procurement contract (outline agreement) with a supplier covering pricing, volume commitments, delivery schedules, quality requirements, and commercial terms for direct or indirect materials. Captures contract type (value contract, quantity contract, scheduling agreement), validity period, target value, release order documentation requirement, price escalation clauses, penalty terms, and contract status. Supports blanket PO releases and scheduling agreement delivery lines. Sourced from SAP MM contract (EKKO with doc type MK/WK).';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`procurement`.`scheduling_agreement_line` (
    `scheduling_agreement_line_id` BIGINT COMMENT 'Primary key',
    `procurement_purchase_order_id` BIGINT COMMENT 'FK to purchase order',
    `scheduling_agreement_id` BIGINT COMMENT 'FK to scheduling agreement',
    `sku_master_id` BIGINT COMMENT 'FK to SKU master',
    `change_number` STRING COMMENT 'Change number',
    `confirmed_quantity` DECIMAL(18,2) COMMENT 'Confirmed quantity',
    `confirmed_quantity_unit` STRING COMMENT 'Confirmed quantity unit',
    `creation_timestamp` TIMESTAMP COMMENT 'Creation timestamp',
    `cumulative_received_quantity` DECIMAL(18,2) COMMENT 'Cumulative received quantity',
    `cumulative_received_quantity_unit` STRING COMMENT 'Cumulative received quantity unit',
    `currency_code` STRING COMMENT 'Currency code',
    `data_governance_ref` STRING COMMENT 'Reference to data governance catalog entry for lineage and ownership tracking',
    `delivery_date` DATE COMMENT 'Delivery date',
    `delivery_window_end` DATE COMMENT 'Delivery window end',
    `delivery_window_start` DATE COMMENT 'Delivery window start',
    `effective_from` DATE COMMENT 'Effective from date',
    `effective_until` DATE COMMENT 'Effective until date',
    `freight_terms` STRING COMMENT 'Freight terms',
    `incoterms_code` STRING COMMENT 'Incoterms code',
    `inspection_required` BOOLEAN COMMENT 'Whether inspection is required',
    `is_backorder` BOOLEAN COMMENT 'Backorder flag',
    `is_late` BOOLEAN COMMENT 'Late delivery flag',
    `last_received_timestamp` TIMESTAMP COMMENT 'Last received timestamp',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Last update timestamp',
    `line_sequence` STRING COMMENT 'Line sequence number',
    `line_status` STRING COMMENT 'Line status',
    `lot_number` STRING COMMENT 'Lot number',
    `plant_code` STRING COMMENT 'Plant code',
    `price_per_unit` DECIMAL(18,2) COMMENT 'Price per unit',
    `quality_status` STRING COMMENT 'Quality status',
    `remarks` STRING COMMENT 'Remarks',
    `schedule_line_category` STRING COMMENT 'Schedule line category',
    `scheduled_quantity` DECIMAL(18,2) COMMENT 'Scheduled quantity',
    `scheduled_quantity_unit` STRING COMMENT 'Scheduled quantity unit',
    `supplier_material_number` STRING COMMENT 'Supplier material number',
    `tax_rate_percent` DECIMAL(18,2) COMMENT 'Tax rate percentage',
    CONSTRAINT pk_scheduling_agreement_line PRIMARY KEY(`scheduling_agreement_line_id`)
) COMMENT 'Delivery schedule line within a scheduling agreement (JIT/JIS delivery plan) specifying the exact quantity and delivery date for a specific part number at a specific plant. Captures schedule line number, delivery date, scheduled quantity, confirmed quantity, cumulative received quantity, and schedule line category (firm, forecast). Critical for JIT and JIS production supply in automotive assembly operations. Sourced from SAP MM scheduling agreement delivery schedule (EKET).';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`procurement`.`procurement_goods_receipt` (
    `procurement_goods_receipt_id` BIGINT COMMENT 'Primary key',
    `employee_id` BIGINT COMMENT 'FK to employee',
    `procurement_po_line_id` BIGINT COMMENT 'Foreign key linking to procurement.procurement_po_line. Business justification: Goods receipts are posted at the PO line item level in SAP MM (each GR references a specific PO item). The existing purchase_order_item (INT) is a denormalized line number; a proper FK to procurement_',
    `procurement_purchase_order_id` BIGINT COMMENT 'Foreign key linking to procurement.procurement_purchase_order. Business justification: Every goods receipt in SAP MM is posted against a purchase order (movement type 101). The existing purchase_order_number is a denormalized STRING; a proper FK to procurement_purchase_order is essentia',
    `procurement_receipt_user_employee_id` BIGINT COMMENT 'FK to receiving user',
    `procurement_supplier_id` BIGINT COMMENT 'FK to supplier',
    `scheduling_agreement_line_id` BIGINT COMMENT 'Foreign key linking to procurement.scheduling_agreement_line. Business justification: For JIT/JIS deliveries, goods receipts are posted against scheduling agreement delivery lines rather than standard PO lines. Linking procurement_goods_receipt to scheduling_agreement_line enables trac',
    `shipment_id` BIGINT COMMENT 'FK to shipment',
    `sku_master_id` BIGINT COMMENT 'FK to SKU master',
    `accounting_document_number` STRING COMMENT 'Accounting document number',
    `accounting_year` STRING COMMENT 'Accounting year',
    `batch_number` STRING COMMENT 'Batch number',
    `cost_center_code` DECIMAL(18,2) COMMENT 'Cost center code',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `currency_code` STRING COMMENT 'Currency code',
    `data_governance_ref` STRING COMMENT 'Reference to data governance catalog entry for lineage and ownership tracking',
    `gross_amount` DECIMAL(18,2) COMMENT 'Gross amount',
    `inspection_lot_number` STRING COMMENT 'Inspection lot number',
    `invoice_match_status` STRING COMMENT 'Invoice match status',
    `is_blocked_stock` BOOLEAN COMMENT 'Whether stock is blocked',
    `is_quality_inspection_required` BOOLEAN COMMENT 'Quality inspection required flag',
    `movement_type` STRING COMMENT 'Movement type',
    `net_amount` DECIMAL(18,2) COMMENT 'Net amount',
    `plant_code` STRING COMMENT 'Plant code',
    `posting_date` DATE COMMENT 'Posting date',
    `procurement_goods_receipt_status` STRING COMMENT 'Goods receipt status',
    `profit_center_code` STRING COMMENT 'Profit center code',
    `quality_inspection_result` STRING COMMENT 'Quality inspection result',
    `quantity_received` DECIMAL(18,2) COMMENT 'Quantity received',
    `receipt_number` STRING COMMENT 'Receipt number',
    `receipt_timestamp` TIMESTAMP COMMENT 'Receipt timestamp',
    `receipt_type` STRING COMMENT 'Receipt type',
    `slip_number` STRING COMMENT 'Slip number',
    `source_system_load_timestamp` TIMESTAMP COMMENT 'Source system load timestamp',
    `storage_location` STRING COMMENT 'Storage location',
    `tax_amount` DECIMAL(18,2) COMMENT 'Tax amount',
    `unit_of_measure` STRING COMMENT 'Unit of measure',
    `updated_timestamp` TIMESTAMP COMMENT 'Last update timestamp',
    `vendor_invoice_number` STRING COMMENT 'Vendor invoice number',
    CONSTRAINT pk_procurement_goods_receipt PRIMARY KEY(`procurement_goods_receipt_id`)
) COMMENT 'Record of physical receipt of materials or services at an Automotive plant or warehouse against a purchase order or scheduling agreement. Captures GR document number, posting date, material document number, plant, storage location, received quantity, unit of measure, batch number, quality inspection lot reference, GR slip number, and movement type (101 standard GR, 103 GR blocked stock). Triggers inventory update and initiates three-way match for invoice verification. Sourced from SAP MM material document (MSEG/MKPF).';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`procurement`.`supplier_invoice` (
    `supplier_invoice_id` BIGINT COMMENT 'Primary key',
    `acquisition_id` BIGINT COMMENT 'FK to acquisition',
    `cost_center_id` BIGINT COMMENT 'FK to cost center',
    `gl_account_id` BIGINT COMMENT 'FK to GL account',
    `payment_run_id` BIGINT COMMENT 'Foreign key linking to procurement.payment_run. Business justification: Supplier invoices are settled through payment runs in SAP FI-AP. One payment run processes many invoices (1:N). Linking supplier_invoice to payment_run enables payment status tracking, cash flow forec',
    `procurement_goods_receipt_id` BIGINT COMMENT 'Foreign key linking to procurement.procurement_goods_receipt. Business justification: 3-way match in SAP MM requires linking the supplier invoice to the goods receipt that confirmed delivery. The existing goods_receipt_number is a denormalized STRING; a proper FK to procurement_goods_r',
    `procurement_purchase_order_id` BIGINT COMMENT 'Foreign key linking to procurement.procurement_purchase_order. Business justification: Supplier invoices are always matched against a purchase order in SAP MM 3-way match (PO → GR → Invoice). The existing purchase_order_number is a denormalized STRING field; replacing it with a proper F',
    `procurement_supplier_id` BIGINT COMMENT 'FK to supplier',
    `accounting_document_number` STRING COMMENT 'Accounting document number',
    `attachment_flag` BOOLEAN COMMENT 'Attachment flag',
    `blocking_reason` STRING COMMENT 'Blocking reason',
    `comments` STRING COMMENT 'Comments',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `currency_code` STRING COMMENT 'Currency code',
    `discount_amount` DECIMAL(18,2) COMMENT 'Discount amount',
    `due_date` DATE COMMENT 'Due date',
    `e_invoice_flag` BOOLEAN COMMENT 'Whether invoice was submitted via e-procurement portal',
    `ean_number` STRING COMMENT 'EAN number',
    `exchange_rate` DECIMAL(18,2) COMMENT 'Exchange rate',
    `fiscal_year` STRING COMMENT 'Fiscal year',
    `gross_amount` DECIMAL(18,2) COMMENT 'Gross amount',
    `internal_order_number` STRING COMMENT 'Internal order number',
    `invoice_amount` DECIMAL(18,2) COMMENT '',
    `invoice_currency_amount` DECIMAL(18,2) COMMENT 'Invoice currency amount',
    `invoice_date` DATE COMMENT 'Invoice date',
    `invoice_number` STRING COMMENT 'Invoice number',
    `invoice_status` STRING COMMENT '',
    `invoice_type` STRING COMMENT 'Invoice type',
    `line_item_count` STRING COMMENT 'Line item count',
    `net_amount` DECIMAL(18,2) COMMENT 'Net amount',
    `payment_date` DATE COMMENT 'Payment date',
    `payment_method` STRING COMMENT 'Payment method',
    `payment_reference` STRING COMMENT 'Payment reference',
    `payment_status` STRING COMMENT 'Payment status',
    `payment_terms` STRING COMMENT 'Payment terms',
    `posting_date` DATE COMMENT 'Posting date',
    `profit_center_code` STRING COMMENT 'Profit center code',
    `reference` STRING COMMENT 'Reference',
    `supplier_address_line` STRING COMMENT 'Supplier address line',
    `supplier_city` STRING COMMENT 'Supplier city',
    `supplier_country_code` STRING COMMENT 'Supplier country code',
    `supplier_invoice_status` STRING COMMENT 'Invoice status',
    `tax_amount` DECIMAL(18,2) COMMENT 'Tax amount',
    `tax_code` STRING COMMENT 'Tax code',
    `tax_exempt_flag` BOOLEAN COMMENT 'Tax exempt flag',
    `tax_rate` DECIMAL(18,2) COMMENT 'Tax rate',
    `three_way_match_status` STRING COMMENT 'Three way match status',
    `tolerance_check_result` STRING COMMENT 'Tolerance check result',
    `total_amount` DECIMAL(18,2) COMMENT 'Total amount',
    `updated_timestamp` TIMESTAMP COMMENT 'Last update timestamp',
    `vat_number` STRING COMMENT 'VAT number',
    CONSTRAINT pk_supplier_invoice PRIMARY KEY(`supplier_invoice_id`)
) COMMENT 'Supplier-submitted invoice for goods or services delivered to Automotive, processed through SAP MM invoice verification (Logistics Invoice Verification - LIV). Captures invoice number, supplier invoice reference, invoice date, posting date, gross amount, tax amount, currency, payment terms, due date, three-way match status (PO/GR/Invoice), tolerance check result, blocking reason, and payment status. Enables accounts payable processing and spend actuals capture. Sourced from SAP MM invoice document (RBKP/RSEG).';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`procurement`.`procurement_invoice_line` (
    `procurement_invoice_line_id` BIGINT COMMENT 'Primary key',
    `procurement_goods_receipt_id` BIGINT COMMENT 'Foreign key linking to procurement.procurement_goods_receipt. Business justification: Invoice line-level 3-way match requires linking each invoice line to the specific goods receipt that confirmed the delivery quantity. The existing goods_receipt_reference is a denormalized STRING; a p',
    `procurement_po_line_id` BIGINT COMMENT 'FK to PO line',
    `supplier_invoice_id` BIGINT COMMENT 'FK to supplier invoice',
    `acceptance_date` DATE COMMENT 'Date of acceptance for payment processing',
    `asset_capitalization_flag` BOOLEAN COMMENT 'Asset capitalization flag',
    `batch_number` STRING COMMENT 'Batch number of received goods',
    `commodity_code` STRING COMMENT 'Commodity classification code',
    `cost_center_code` STRING COMMENT 'Cost center code',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `currency_code` STRING COMMENT 'Currency code',
    `data_governance_ref` STRING COMMENT 'Reference to data governance catalog entry for lineage and ownership tracking',
    `delivery_note_number` STRING COMMENT 'Delivery note number',
    `procurement_invoice_line_description` STRING COMMENT 'Description',
    `discount_amount` DECIMAL(18,2) COMMENT 'Discount amount',
    `gl_account_code` STRING COMMENT 'GL account code',
    `gross_amount` DECIMAL(18,2) COMMENT 'Gross amount',
    `invoice_quantity` DECIMAL(18,2) COMMENT 'Invoiced quantity',
    `item_description` STRING COMMENT 'Item description',
    `line_amount` DECIMAL(18,2) COMMENT 'Line amount',
    `line_description` STRING COMMENT 'Line description',
    `line_number` STRING COMMENT 'Line number',
    `line_status` STRING COMMENT 'Line status',
    `material_number` STRING COMMENT 'Material number',
    `net_amount` DECIMAL(18,2) COMMENT 'Net amount',
    `payment_block_indicator` BOOLEAN COMMENT 'Payment block indicator',
    `plant_code` STRING COMMENT 'Plant code for cost allocation',
    `po_line_reference` STRING COMMENT 'PO line reference',
    `price_variance_amount` DECIMAL(18,2) COMMENT 'Price variance between PO and invoice',
    `profit_center_code` STRING COMMENT 'Profit center for cost allocation',
    `quantity` DECIMAL(18,2) COMMENT 'Quantity',
    `quantity_variance` DECIMAL(18,2) COMMENT 'Quantity variance between GR and invoice',
    `retention_amount` DECIMAL(18,2) COMMENT 'Retention amount',
    `serial_number` STRING COMMENT 'Serial number if applicable',
    `service_entry_reference` STRING COMMENT 'Service entry reference',
    `tax_amount` DECIMAL(18,2) COMMENT 'Tax amount',
    `tax_code` STRING COMMENT 'Tax code',
    `three_way_match_status` STRING COMMENT 'Three way match status',
    `unit_of_measure` STRING COMMENT 'Unit of measure',
    `unit_price` DECIMAL(18,2) COMMENT 'Unit price',
    `unit_price_amount` DECIMAL(18,2) COMMENT 'Unit price amount',
    `updated_timestamp` TIMESTAMP COMMENT 'Last update timestamp',
    `variance_amount` DECIMAL(18,2) COMMENT 'Variance amount',
    `variance_reason_code` STRING COMMENT 'Variance reason code',
    `wbs_element` STRING COMMENT 'WBS element for project cost allocation',
    `withholding_tax_amount` DECIMAL(18,2) COMMENT 'Withholding tax amount',
    CONSTRAINT pk_procurement_invoice_line PRIMARY KEY(`procurement_invoice_line_id`)
) COMMENT 'Individual line item on a supplier invoice, matched against a specific PO line and goods receipt line. Captures invoice line number, material or service description, invoiced quantity, unit price, net amount, tax code, PO reference line, GR reference, quantity variance, price variance, and line-level match status. Supports granular three-way match reconciliation and dispute resolution at the part/service level. This product is the single source of truth (SSOT) for its concept in the ECM Lakehouse.';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`procurement`.`spend_category` (
    `spend_category_id` BIGINT COMMENT 'Primary key',
    `gl_account_id` BIGINT COMMENT 'FK to GL account',
    `parent_category_spend_category_id` BIGINT COMMENT 'FK to parent category',
    `employee_id` BIGINT COMMENT 'FK to primary spend employee',
    `spend_employee_id` BIGINT COMMENT 'FK to employee',
    `category_code` STRING COMMENT 'Category code',
    `category_name` STRING COMMENT 'Category name',
    `commodity_group` STRING COMMENT 'Commodity group',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `data_governance_ref` STRING COMMENT 'Reference to data governance catalog entry for lineage and ownership tracking',
    `spend_category_description` STRING COMMENT 'Category description',
    `direct_indirect_flag` BOOLEAN COMMENT 'Direct vs indirect spend flag',
    `effective_from` DATE COMMENT 'Effective from date',
    `effective_until` DATE COMMENT 'Effective until date',
    `external_reference` STRING COMMENT 'External reference',
    `hierarchy_level` STRING COMMENT 'Hierarchy level',
    `is_leaf` BOOLEAN COMMENT 'Whether this is a leaf node',
    `scope` STRING COMMENT 'Category scope',
    `sourcing_strategy` DECIMAL(18,2) COMMENT 'Sourcing strategy score',
    `spend_category_status` STRING COMMENT 'Category status',
    `spend_category_type` STRING COMMENT 'Category type',
    `strategic_flag` BOOLEAN COMMENT 'Strategic flag',
    `updated_timestamp` TIMESTAMP COMMENT 'Last update timestamp',
    `version_number` STRING COMMENT 'Version number',
    CONSTRAINT pk_spend_category PRIMARY KEY(`spend_category_id`)
) COMMENT 'Hierarchical classification taxonomy for procurement spend, organizing all purchased goods and services into commodity groups and sub-categories aligned with UNSPSC or Automotive-internal commodity codes. Captures category code, category name, parent category, commodity group, direct/indirect flag, strategic category flag, responsible category manager, and applicable sourcing strategy. Enables spend analytics, category management, and supplier rationalization. Reference data used across all procurement transactions.';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`procurement`.`approved_vendor_list` (
    `approved_vendor_list_id` BIGINT COMMENT 'System-generated unique identifier for each approved vendor list record.',
    `info_record_id` BIGINT COMMENT 'Foreign key linking to procurement.info_record. Business justification: The approved_vendor_list (AVL) authorizes a supplier-material combination, while the info_record stores the commercial terms (price, lead time, MOQ) for the same supplier-material pair. These are comp',
    `material_id` BIGINT COMMENT 'Unique identifier of the material or part covered by the AVL.',
    `procurement_supplier_id` BIGINT COMMENT 'Unique identifier of the supplier authorized in this AVL.',
    `supplier_contract_id` BIGINT COMMENT 'Identifier of the underlying supplier contract governing the AVL.',
    `approval_date` DATE COMMENT 'Date the approval becomes effective (start of validity).',
    `approval_status` STRING COMMENT 'Current status of the AVL entry indicating if the supplier is approved, conditionally approved, or disqualified.. Valid values are `approved|conditional|disqualified`',
    `avl_number` STRING COMMENT 'Unique alphanumeric code assigned to the approved vendor list entry.',
    `backup_supplier_flag` BOOLEAN COMMENT 'True if the supplier serves as a backup source for the material.',
    `compliance_status` STRING COMMENT 'Indicates whether the supplier-material combination meets regulatory and IATF 16949 requirements.. Valid values are `compliant|non_compliant|pending`',
    `created_by_user` STRING COMMENT 'User identifier who created the AVL record.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the AVL record was first inserted into the lakehouse.',
    `currency_code` STRING COMMENT 'ISO 4217 currency code used for any price‑related fields in the AVL.. Valid values are `USD|EUR|JPY|GBP|CNY|CAD`',
    `data_governance_ref` STRING COMMENT 'Reference to data governance catalog entry for lineage and ownership tracking',
    `entry_date` DATE COMMENT 'Date the AVL record was initially created in the system.',
    `expiry_date` DATE COMMENT 'Date the AVL entry expires or must be re‑validated.',
    `last_review_date` DATE COMMENT 'Most recent date the AVL entry was reviewed for continued eligibility.',
    `lead_time_days` STRING COMMENT 'Standard supplier lead time in calendar days for the material.',
    `min_order_quantity` STRING COMMENT 'Minimum quantity that must be ordered per purchase order for this AVL.',
    `notes` STRING COMMENT 'Free‑form comments or observations about the AVL entry.',
    `ppap_approval_level` STRING COMMENT 'Production Part Approval Process level achieved for the supplier-material combination.. Valid values are `Level1|Level2|Level3|Level4|Level5`',
    `preferred_supplier_flag` BOOLEAN COMMENT 'True if the supplier is designated as a preferred source for the material.',
    `price_cap` DECIMAL(18,2) COMMENT 'Maximum unit price the supplier may charge for the material under this AVL.',
    `quality_rating_threshold` DECIMAL(18,2) COMMENT 'Minimum quality rating percentage the supplier must maintain for this material.',
    `regulatory_approval_required` BOOLEAN COMMENT 'True if additional regulatory approval (e.g., EPA, NHTSA) is required for the material.',
    `review_cycle_months` STRING COMMENT 'Number of months between mandatory AVL reviews.',
    `single_source_justification` STRING COMMENT 'Narrative explanation for why a single source supplier is required.',
    `source_list_flag` BOOLEAN COMMENT 'True if the AVL entry is reflected in SAP MM source list (EORD).',
    `updated_by_user` STRING COMMENT 'User identifier who last modified the AVL record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the AVL record.',
    CONSTRAINT pk_approved_vendor_list PRIMARY KEY(`approved_vendor_list_id`)
) COMMENT 'Formally approved supplier-material combination (AVL) authorizing a specific supplier to supply a specific part number or commodity to Automotive plants. Captures AVL entry date, approval status (approved, conditional, disqualified), PPAP approval level, quality rating threshold, preferred supplier flag, backup supplier flag, single-source justification, and expiry date. Governs which suppliers are eligible to receive purchase orders for specific materials. Integrates with SAP MM source list (EORD).';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`procurement`.`info_record` (
    `info_record_id` BIGINT COMMENT 'System-generated unique identifier for the purchasing info record.',
    `material_id` BIGINT COMMENT 'Unique identifier of the material or service category covered by this info record.',
    `procurement_supplier_id` BIGINT COMMENT 'Unique identifier of the supplier (vendor) associated with this info record.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the info record was first created.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for the price.. Valid values are `USD|EUR|JPY|GBP|CNY|CAD`',
    `data_governance_ref` STRING COMMENT 'Reference to data governance catalog entry for lineage and ownership tracking',
    `effective_from` DATE COMMENT 'Date on which the info record becomes effective.',
    `effective_until` DATE COMMENT 'Date on which the info record expires (null if open‑ended).',
    `info_record_number` STRING COMMENT 'Business identifier assigned to the info record, e.g., IR00001234.. Valid values are `^IR[0-9]{8}$`',
    `info_record_status` STRING COMMENT 'Current lifecycle status of the info record.. Valid values are `active|inactive|blocked|pending`',
    `info_record_type` STRING COMMENT 'Classification of the info record (standard, contract, or framework agreement).. Valid values are `standard|contract|framework`',
    `last_price_update_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent price change.',
    `lead_time_days` STRING COMMENT 'Planned delivery lead time in days from order to receipt.',
    `minimum_order_quantity` STRING COMMENT 'Minimum quantity that must be ordered under this info record.',
    `notes` STRING COMMENT 'Free‑form comments or special instructions related to the info record.',
    `order_quantity_uom` STRING COMMENT 'Unit of measure for the minimum order quantity.. Valid values are `EA|KG|L|M|PCS|BOX`',
    `over_delivery_tolerance_percent` DECIMAL(18,2) COMMENT 'Maximum allowed percentage over the ordered quantity.',
    `price_amount` DECIMAL(18,2) COMMENT 'Negotiated price per unit of the material or service.',
    `price_valid_from` DATE COMMENT 'Start date of the price validity period.',
    `price_valid_until` DATE COMMENT 'End date of the price validity period.',
    `procurement_category` STRING COMMENT 'Indicates whether the material is procured as direct or indirect.. Valid values are `direct|indirect`',
    `reminder_days` STRING COMMENT 'Number of days before price expiry to trigger a reminder.',
    `under_delivery_tolerance_percent` DECIMAL(18,2) COMMENT 'Maximum allowed percentage under the ordered quantity.',
    `updated_by` STRING COMMENT 'System user identifier who last updated the record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the info record.',
    `vendor_evaluation_score` DECIMAL(18,2) COMMENT 'Score (0‑5) reflecting supplier performance for this material.',
    `created_by` STRING COMMENT 'System user identifier who created the record.',
    CONSTRAINT pk_info_record PRIMARY KEY(`info_record_id`)
) COMMENT 'Purchasing info record storing the commercial relationship between a supplier and a specific material or service category, including the last negotiated price, price validity period, planned delivery time, over/under-delivery tolerance, reminder days, and vendor evaluation score. Serves as the default pricing and delivery condition source when creating purchase orders. Sourced from SAP MM purchasing info record (EINE/EINA/ME11).';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`procurement`.`supplier_evaluation` (
    `supplier_evaluation_id` BIGINT COMMENT 'System-generated unique identifier for each supplier evaluation record.',
    `procurement_supplier_id` BIGINT COMMENT 'Unique identifier of the supplier being evaluated.',
    `employee_id` BIGINT COMMENT 'Identifier of the employee or system that performed the evaluation.',
    `supplier_evaluator_employee_id` BIGINT COMMENT 'Identifier of the employee or system that performed the evaluation.',
    `comments` STRING COMMENT 'Free‑text notes from the evaluator providing context or observations.',
    `compliance_status` STRING COMMENT 'Indicates whether the supplier meets regulatory and internal compliance requirements.. Valid values are `compliant|non_compliant|exempt`',
    `cost_score` DECIMAL(18,2) COMMENT 'Score (0‑100) for commercial performance (price competitiveness, invoice accuracy).',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the evaluation record was first created in the system.',
    `delivery_score` DECIMAL(18,2) COMMENT 'Score (0‑100) for delivery performance (OTD, schedule adherence).',
    `development_score` DECIMAL(18,2) COMMENT 'Score (0‑100) for development dimension (responsiveness, engineering change support).',
    `digital_collaboration_score` DECIMAL(18,2) COMMENT 'Score for supplier digital collaboration capability (e-procurement portal usage)',
    `evaluation_date` DATE COMMENT 'Date on which the evaluation was performed.',
    `evaluation_method` STRING COMMENT 'How the evaluation data was collected (automated, manual, or mixed).. Valid values are `automated|manual|mixed`',
    `evaluation_number` STRING COMMENT 'Human‑readable identifier for the evaluation (e.g., EV‑2024‑Q1).',
    `evaluation_period` STRING COMMENT '',
    `evaluation_status` STRING COMMENT 'Current processing state of the evaluation record.. Valid values are `draft|in_progress|completed|approved|archived`',
    `evaluation_type` STRING COMMENT 'Frequency or trigger of the evaluation (annual, quarterly, or ad‑hoc).. Valid values are `annual|quarterly|ad_hoc`',
    `evaluation_version` STRING COMMENT 'Version number for the evaluation record to support revisions.',
    `failed_criteria_count` STRING COMMENT 'Number of criteria where the supplier fell below the required threshold.',
    `invoice_accuracy_pct` DECIMAL(18,2) COMMENT 'Percentage of invoices that match purchase order terms without discrepancies.',
    `on_time_delivery_pct` DECIMAL(18,2) COMMENT 'Percentage of deliveries arriving on or before the promised date.',
    `overall_score` DECIMAL(18,2) COMMENT 'Aggregated score (0‑100) summarising supplier performance.',
    `passed_criteria_count` STRING COMMENT 'Number of criteria where the supplier met or exceeded the threshold.',
    `period_end_date` DATE COMMENT 'Last day of the period covered by the evaluation.',
    `period_start_date` DATE COMMENT 'First day of the period covered by the evaluation.',
    `ppm_defect_rate` DECIMAL(18,2) COMMENT 'Parts‑per‑million defect rate observed during the period.',
    `price_variance_pct` DECIMAL(18,2) COMMENT 'Percentage difference between contracted price and actual invoiced price.',
    `quality_score` DECIMAL(18,2) COMMENT 'Score (0‑100) for quality dimension (PPM defect rate, PPAP compliance).',
    `recommended_action` STRING COMMENT 'Suggested strategic response based on evaluation results.. Valid values are `maintain|develop|reduce|disqualify`',
    `risk_level` STRING COMMENT 'Risk classification derived from evaluation outcomes.. Valid values are `low|medium|high|critical`',
    `supplier_category` STRING COMMENT 'Business classification of the supplier (e.g., Tier 1, Tier 2).. Valid values are `tier1|tier2|tier3|tier4`',
    `supplier_region` STRING COMMENT 'ISO‑3 country code of the suppliers primary operating location.. Valid values are `^[A-Z]{3}$`',
    `total_criteria_count` STRING COMMENT 'Number of evaluation criteria applied to the supplier.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent modification to the evaluation record.',
    CONSTRAINT pk_supplier_evaluation PRIMARY KEY(`supplier_evaluation_id`)
) COMMENT 'Periodic formal assessment of supplier performance across quality (PPM defect rate, PPAP compliance), delivery (OTD - On-Time Delivery, schedule adherence), commercial (price competitiveness, invoice accuracy), and development (responsiveness, engineering change support) dimensions. Captures evaluation period, overall score, sub-scores by criterion, evaluator, evaluation method (automated from SAP QM/MM or manual), and recommended action (maintain, develop, reduce, disqualify). Supports supplier development programs and strategic sourcing decisions.';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`procurement`.`supplier_development_plan` (
    `supplier_development_plan_id` BIGINT COMMENT 'Unique identifier for the supplier development plan.',
    `apqp_plan_id` BIGINT COMMENT 'Foreign key linking to quality.apqp_plan. Business justification: Supplier development is coordinated with APQP phases; linking ensures the development plan references the correct APQP plan.',
    `obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_obligation. Business justification: REQUIRED: Development plans are created to satisfy a particular compliance obligation, linking the plan to that obligation for tracking.',
    `employee_id` BIGINT COMMENT 'Identifier of the development engineer responsible for executing the plan.',
    `procurement_supplier_id` BIGINT COMMENT 'Identifier of the supplier for which the development plan is created.',
    `supplier_approved_by_employee_id` BIGINT COMMENT 'Identifier of the person who approved the plan.',
    `supplier_contract_id` BIGINT COMMENT 'Identifier of the supplier contract associated with the development plan.',
    `supplier_employee_id` BIGINT COMMENT 'Identifier of the development engineer responsible for executing the plan.',
    `supplier_evaluation_id` BIGINT COMMENT 'Foreign key linking to procurement.supplier_evaluation. Business justification: Supplier development plans are typically triggered by poor supplier evaluation results (low quality score, delivery performance below threshold). Linking supplier_development_plan to the triggering su',
    `actual_metric_timestamp` DATE COMMENT 'Date when the actual metric was recorded.',
    `actual_metric_value` DECIMAL(18,2) COMMENT 'Current measured value of the primary KPI.',
    `actual_progress_percent` DECIMAL(18,2) COMMENT 'Current progress of the plan expressed as a percentage.',
    `approval_timestamp` TIMESTAMP COMMENT 'Timestamp when the plan was approved.',
    `budget_status` STRING COMMENT 'Current budget status of the plan.. Valid values are `under_budget|on_budget|over_budget`',
    `change_reason` STRING COMMENT 'Reason for the latest version change of the plan.',
    `compliance_requirements` STRING COMMENT 'Regulatory or compliance requirements linked to the plan (e.g., IATF 16949).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the plan record was created.',
    `effective_from` DATE COMMENT 'Date when the plan becomes effective.',
    `effective_until` DATE COMMENT 'Planned end date of the plan (nullable for open‑ended).',
    `improvement_areas` STRING COMMENT 'Improvement areas',
    `investment_amount` DECIMAL(18,2) COMMENT 'Total monetary investment committed to the development plan.',
    `investment_currency` STRING COMMENT 'Currency code of the investment amount (ISO 4217).',
    `investment_type` STRING COMMENT 'Source of the investment funding.. Valid values are `automotive_funded|supplier_funded|joint`',
    `is_capex` BOOLEAN COMMENT 'Indicates if the investment is classified as capital expenditure.',
    `is_oem` BOOLEAN COMMENT 'Indicates if the supplier is an original equipment manufacturer.',
    `last_review_date` DATE COMMENT 'Date of the most recent plan review.',
    `milestone_schedule` STRING COMMENT 'Structured representation of milestones and their target dates (e.g., JSON or delimited string).',
    `next_milestone_date` DATE COMMENT 'Date of the upcoming milestone.',
    `notes` STRING COMMENT 'Free‑text notes or comments regarding the plan.',
    `plan_code` STRING COMMENT 'External reference code for the development plan.',
    `plan_name` STRING COMMENT 'Descriptive name of the development plan.',
    `plan_number` STRING COMMENT '',
    `plan_status` STRING COMMENT '',
    `plan_type` STRING COMMENT 'Category of the development plan indicating its primary focus.. Valid values are `quality_improvement|capacity_ramp|technology_development|cost_reduction`',
    `plan_version` STRING COMMENT 'Version number of the plan for change tracking.',
    `priority` STRING COMMENT 'Priority level assigned to the development plan.. Valid values are `low|medium|high|critical`',
    `related_sop_date` DATE COMMENT 'Target date for Start of Production readiness associated with the plan.',
    `risk_level` STRING COMMENT 'Risk assessment level for the plan.. Valid values are `low|medium|high`',
    `start_date` DATE COMMENT 'Start date',
    `supplier_development_plan_status` STRING COMMENT 'Current lifecycle status of the development plan.. Valid values are `draft|approved|in_progress|completed|on_hold|cancelled`',
    `target_completion_date` DATE COMMENT 'Target completion date',
    `target_date` DATE COMMENT '',
    `target_metric_name` STRING COMMENT 'Name of the primary KPI the plan aims to improve (e.g., defect_rate, on_time_delivery).',
    `target_metric_unit` STRING COMMENT 'Unit of measure for the target metric (e.g., %, ppm).',
    `target_metric_value` DECIMAL(18,2) COMMENT 'Target value for the primary KPI.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the plan.',
    CONSTRAINT pk_supplier_development_plan PRIMARY KEY(`supplier_development_plan_id`)
) COMMENT 'Structured improvement program initiated for a supplier requiring capability development, quality improvement, or capacity expansion. Captures plan type (quality improvement, capacity ramp, technology development, cost reduction), target metrics, milestone schedule, responsible development engineer, investment commitment (Automotive-funded tooling or CapEx), and plan status. Tracks progress against agreed KPIs and supports SOP (Start of Production) readiness for new model launches.';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`procurement`.`capex_requisition` (
    `capex_requisition_id` BIGINT COMMENT 'System-generated unique identifier for the capital expenditure requisition.',
    `budget_line_id` BIGINT COMMENT 'Budget line item that funds the requisition.',
    `employee_id` BIGINT COMMENT 'Employee who created the CapEx requisition.',
    `capex_project_manager_employee_id` BIGINT COMMENT 'Employee responsible for overseeing the capital project.',
    `cost_center_id` BIGINT COMMENT 'Cost center responsible for the expense.',
    `department_id` BIGINT COMMENT 'Department responsible for the request.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Capex request posting requires a GL account to capture capital expenditures in the ledger.',
    `plant_id` BIGINT COMMENT 'Identifier of the manufacturing plant where the asset will be used.',
    `primary_capex_employee_id` BIGINT COMMENT 'Employee who created the CapEx requisition.',
    `procurement_supplier_id` BIGINT COMMENT 'Supplier selected to provide the capital asset.',
    `supplier_quote_id` BIGINT COMMENT 'Identifier of the supplier quote linked to the requisition.',
    `vendor_id` BIGINT COMMENT 'Supplier selected to provide the capital asset.',
    `afe_number` STRING COMMENT 'Number of the AFE that authorizes the capital spend.',
    `approval_authority_level` STRING COMMENT 'Organizational level required to approve the requisition.. Valid values are `manager|director|vp|cfo|ceo`',
    `approval_date` DATE COMMENT 'Date the requisition received final approval.',
    `approved_budget` DECIMAL(18,2) COMMENT 'Budget amount approved for the requisition.',
    `asset_category` STRING COMMENT 'Category of the asset to be acquired (e.g., tooling, equipment, facility).. Valid values are `tooling|equipment|facility|software|infrastructure|other`',
    `asset_life_years` STRING COMMENT 'Estimated useful life of the asset for planning purposes.',
    `capex_requisition_status` STRING COMMENT 'Current processing status of the requisition.. Valid values are `draft|submitted|approved|rejected|closed|cancelled`',
    `capitalized_flag` BOOLEAN COMMENT 'Indicates whether the expense will be capitalized on the balance sheet.',
    `compliance_status` STRING COMMENT 'Overall compliance status with internal and external regulations.. Valid values are `compliant|non_compliant|pending`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the requisition record was created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for monetary values.',
    `data_governance_ref` STRING COMMENT 'Reference to data governance catalog entry for lineage and ownership tracking',
    `depreciation_life_years` STRING COMMENT 'Number of years over which the asset will be depreciated.',
    `depreciation_start_date` DATE COMMENT 'Date when depreciation of the asset begins.',
    `capex_requisition_description` STRING COMMENT 'Free‑text description providing business justification and details of the request.',
    `environmental_impact_assessment` STRING COMMENT 'Assessment of the environmental impact of the capital project.. Valid values are `low|medium|high|not_applicable`',
    `estimated_investment` DECIMAL(18,2) COMMENT 'Projected total cost of the capital investment.',
    `funding_source` STRING COMMENT 'Source of funds for the capital expenditure.. Valid values are `internal|external|loan|grant|other`',
    `justification_type` STRING COMMENT 'Reason for the CapEx request such as new model development, replacement, or capacity expansion.. Valid values are `new_model|replacement|capacity|maintenance|other`',
    `procurement_method` STRING COMMENT 'Method used to acquire the asset.. Valid values are `purchase|lease|internal|other`',
    `project_code` STRING COMMENT 'Code of the capital project or program to which the requisition belongs.',
    `regulatory_approval_required` BOOLEAN COMMENT 'Indicates if regulatory approval is needed for the asset.',
    `regulatory_approval_status` STRING COMMENT 'Current status of any required regulatory approvals.. Valid values are `pending|approved|rejected`',
    `request_date` DATE COMMENT 'Date the requisition was initially submitted.',
    `required_by_date` DATE COMMENT 'Date by which the asset is needed for production.',
    `requisition_number` STRING COMMENT 'External reference number assigned to the requisition for tracking and communication.',
    `risk_assessment` STRING COMMENT 'Risk level associated with the capital investment.. Valid values are `low|medium|high`',
    `tax_amount` DECIMAL(18,2) COMMENT 'Tax component associated with the approved budget.',
    `tax_code` STRING COMMENT 'Tax code applicable to the requisition.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the requisition record.',
    `wbs_element` STRING COMMENT 'WBS element code linking the requisition to project accounting hierarchy.',
    CONSTRAINT pk_capex_requisition PRIMARY KEY(`capex_requisition_id`)
) COMMENT 'Capital expenditure procurement request for tooling, dies, fixtures, production equipment, or plant infrastructure required for new model programs or capacity expansion. Captures CapEx project code, asset category, justification type (new model, replacement, capacity), estimated investment, approved budget, plant, cost center, WBS element, AFE (Authorization for Expenditure) number, approval authority level, and CapEx status. Distinct from standard MRO or direct material purchase requisitions due to asset capitalization workflow.';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`procurement`.`tooling_order` (
    `tooling_order_id` BIGINT COMMENT '',
    `capex_requisition_id` BIGINT COMMENT 'Foreign key linking to procurement.capex_requisition. Business justification: Tooling orders are typically initiated from a CapEx requisition (AFE - Authorization for Expenditure). Linking tooling_order to capex_requisition provides the full CapEx procurement chain: capex_requi',
    `cost_center_id` BIGINT COMMENT '',
    `plant_id` BIGINT COMMENT '',
    `procurement_purchase_order_id` BIGINT COMMENT 'Foreign key linking to procurement.procurement_purchase_order. Business justification: A tooling_order is a specialized purchase order for tooling/dies/molds. It should reference the parent procurement_purchase_order document that authorizes the tooling procurement. This enables tooling',
    `procurement_supplier_id` BIGINT COMMENT '',
    `project_id` BIGINT COMMENT '',
    `supplier_contract_id` BIGINT COMMENT 'Foreign key linking to procurement.supplier_contract. Business justification: Tooling orders are typically placed under a supplier contract that governs tooling ownership, amortization terms, and warranty conditions. Linking tooling_order to supplier_contract enables contract-d',
    `tooling_registry_id` BIGINT COMMENT '',
    `amortization_method` STRING COMMENT '',
    `amortization_rate_percent` DECIMAL(18,2) COMMENT '',
    `amortization_term_months` STRING COMMENT '',
    `approval_status` STRING COMMENT '',
    `capital_expenditure_flag` BOOLEAN COMMENT '',
    `compliance_certification` STRING COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT '',
    `currency_code` STRING COMMENT '',
    `delivery_date` DATE COMMENT '',
    `depreciation_end_date` DATE COMMENT '',
    `depreciation_method` STRING COMMENT '',
    `depreciation_start_date` DATE COMMENT '',
    `e_procurement_reference` STRING COMMENT '',
    `expected_life_months` STRING COMMENT '',
    `net_amount` DECIMAL(18,2) COMMENT '',
    `order_amount` DECIMAL(18,2) COMMENT '',
    `order_date` DATE COMMENT '',
    `order_number` STRING COMMENT '',
    `order_status` STRING COMMENT '',
    `order_timestamp` TIMESTAMP COMMENT '',
    `ownership` STRING COMMENT '',
    `part_number` STRING COMMENT '',
    `ppap_tryout_date` DATE COMMENT '',
    `record_source_timestamp` TIMESTAMP COMMENT '',
    `regulatory_approval_status` STRING COMMENT '',
    `tax_amount` DECIMAL(18,2) COMMENT '',
    `tool_number` STRING COMMENT '',
    `tooling_cost` DECIMAL(18,2) COMMENT '',
    `tooling_location` STRING COMMENT '',
    `tooling_order_status` STRING COMMENT '',
    `tooling_type` STRING COMMENT '',
    `total_amount` DECIMAL(18,2) COMMENT '',
    `tryout_schedule_date` DATE COMMENT '',
    `updated_timestamp` TIMESTAMP COMMENT '',
    `warranty_period_months` STRING COMMENT '',
    CONSTRAINT pk_tooling_order PRIMARY KEY(`tooling_order_id`)
) COMMENT 'Purchase order specifically for supplier-owned or Automotive-owned tooling (dies, molds, jigs, fixtures, gauges) required for production of specific parts. Captures tooling type, tool number, associated part numbers, tooling ownership (OEM-owned vs supplier-owned), amortization method (lump sum vs per-piece), tooling location (supplier plant), tryout schedule, PPAP tryout date, and tooling approval status. Tooling orders follow a distinct procurement and capitalization workflow separate from production part POs.';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`procurement`.`service_entry_sheet` (
    `service_entry_sheet_id` BIGINT COMMENT 'Unique surrogate key for the service entry sheet record.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Service entry costs are allocated to cost centers for service profitability analysis.',
    `plant_id` BIGINT COMMENT 'Identifier of the manufacturing plant or site where the service was performed.',
    `procurement_po_line_id` BIGINT COMMENT 'Foreign key linking to procurement.procurement_po_line. Business justification: Service entry sheets confirm services at the PO line level. Linking to procurement_po_line enables line-level service confirmation tracking, quantity vs. performed comparison, and line-level invoice v',
    `procurement_purchase_order_id` BIGINT COMMENT 'Foreign key linking to procurement.procurement_purchase_order. Business justification: Service entry sheets in SAP MM are always created against a service purchase order. The existing purchase_order_number is a denormalized STRING; a proper FK to procurement_purchase_order enables struc',
    `procurement_supplier_id` BIGINT COMMENT 'Identifier of the supplier providing the service.',
    `supplier_contract_id` BIGINT COMMENT 'Foreign key linking to procurement.supplier_contract. Business justification: Service entry sheets for framework service agreements should reference the governing supplier_contract. This enables contract utilization tracking, service spend against contract value monitoring, and',
    `work_center_id` BIGINT COMMENT 'Identifier of the work center responsible for the service execution.',
    `acceptance_status` STRING COMMENT 'Current status of the service acceptance process.. Valid values are `pending|accepted|rejected|partial`',
    `acceptance_timestamp` TIMESTAMP COMMENT 'Date and time when the service entry sheet was accepted.',
    `acceptor_name` STRING COMMENT 'Name of the person who accepted the service entry sheet.',
    `account_assignment` STRING COMMENT 'Account assignment object (e.g., cost object, internal order) used for financial posting.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the service entry sheet record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for the monetary amounts.',
    `data_governance_ref` STRING COMMENT 'Reference to data governance catalog entry for lineage and ownership tracking',
    `service_entry_sheet_description` STRING COMMENT 'Free‑text description of the service performed.',
    `external_reference_code` STRING COMMENT 'Optional reference to an external system identifier.',
    `invoice_triggered` BOOLEAN COMMENT 'Indicates whether the service entry sheet has triggered invoice verification (true) or not (false).',
    `net_amount` DECIMAL(18,2) COMMENT 'Net monetary value after tax and any discounts.',
    `notes` STRING COMMENT 'Free‑form notes or comments entered by users.',
    `quantity_performed` DECIMAL(18,2) COMMENT 'Actual quantity of service units delivered (e.g., hours, days).',
    `service_category` STRING COMMENT 'Classification of the service type performed.. Valid values are `maintenance|repair|consulting|logistics|installation|other`',
    `service_date` DATE COMMENT 'Calendar date on which the service was performed (principal business event date).',
    `service_end_timestamp` TIMESTAMP COMMENT 'Date and time when the service execution completed.',
    `service_entry_sheet_status` STRING COMMENT 'Overall lifecycle status of the service entry sheet.. Valid values are `draft|submitted|approved|rejected|cancelled|closed`',
    `service_line_item` STRING COMMENT 'Identifier of the line item on the service purchase order.',
    `service_location` STRING COMMENT 'Physical location or facility where the service was performed.',
    `service_order_number` STRING COMMENT 'External service order number associated with the entry sheet.',
    `service_start_timestamp` TIMESTAMP COMMENT 'Date and time when the service execution began.',
    `sheet_number` STRING COMMENT 'Business identifier assigned to the service entry sheet by the source system.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Tax component associated with the service total.',
    `tax_code` STRING COMMENT 'Tax code applicable to the service for tax calculation purposes.',
    `total_amount` DECIMAL(18,2) COMMENT 'Gross monetary value of the services before taxes and discounts.',
    `unit_of_measure` STRING COMMENT 'Unit in which the performed quantity is measured.. Valid values are `hour|day|service|unit|kg|liter`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the service entry sheet record.',
    CONSTRAINT pk_service_entry_sheet PRIMARY KEY(`service_entry_sheet_id`)
) COMMENT 'Confirmation document for services rendered by a supplier against a service purchase order, used for indirect procurement (maintenance services, contract labor, engineering services, logistics services). Captures service entry sheet number, service PO reference, service line items, actual quantities performed, acceptance status, acceptor name, acceptance date, and value accepted. Triggers invoice verification for service-based procurement. Sourced from SAP MM service entry sheet (ML81N/ESLH/ESLL).';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`procurement`.`procurement_price_condition` (
    `procurement_price_condition_id` BIGINT COMMENT 'Unique identifier for the procurement_price_condition data product (auto-inserted pre-linking).',
    `info_record_id` BIGINT COMMENT '',
    `procurement_supplier_id` BIGINT COMMENT 'Reference to the supplier this price condition applies to',
    `supplier_contract_id` BIGINT COMMENT 'Foreign key linking to procurement.supplier_contract. Business justification: A procurement price condition is defined at the contract level; linking to supplier_contract provides contract context and avoids redundant contract reference columns.',
    `benchmark_price_amount` DECIMAL(18,2) COMMENT 'Benchmark price for comparison',
    `calculation_type` STRING COMMENT 'How condition is calculated (fixed, percentage, per unit)',
    `condition_amount` DECIMAL(18,2) COMMENT '',
    `condition_code` STRING COMMENT '',
    `condition_rate` DECIMAL(18,2) COMMENT '',
    `condition_rate_pct` DECIMAL(18,2) COMMENT '',
    `condition_type` STRING COMMENT 'Type of price condition (base price, discount, surcharge, freight)',
    `condition_value` DECIMAL(18,2) COMMENT 'Value of the price condition',
    `created_timestamp` TIMESTAMP COMMENT '',
    `currency_code` STRING COMMENT 'Currency of the condition value',
    `data_governance_ref` STRING COMMENT 'Reference to data governance catalog entry for lineage and ownership tracking',
    `discount_percentage` DECIMAL(18,2) COMMENT 'Percentage discount applied in this condition',
    `early_payment_discount_pct` DECIMAL(18,2) COMMENT 'Early payment discount percentage',
    `escalation_formula` STRING COMMENT 'Price escalation/de-escalation formula',
    `freight_condition_amount` DECIMAL(18,2) COMMENT 'Freight cost condition amount',
    `incoterm_code` STRING COMMENT 'Incoterm applicable to this price condition (e.g., DDP, FCA, EXW)',
    `is_active` BOOLEAN COMMENT 'Whether this condition is currently active',
    `material_number` STRING COMMENT '',
    `maximum_order_quantity` DECIMAL(18,2) COMMENT 'Maximum order quantity cap for this price condition tier',
    `minimum_order_quantity` DECIMAL(18,2) COMMENT 'Minimum order quantity threshold for this price condition to apply',
    `negotiation_reference` STRING COMMENT 'Reference to negotiation event or round',
    `packaging_cost_amount` DECIMAL(18,2) COMMENT 'Packaging cost amount',
    `price_amount` DECIMAL(18,2) COMMENT '',
    `price_basis_quantity` DECIMAL(18,2) COMMENT 'Quantity basis for per-unit price calculation (e.g., price per 100 units)',
    `price_change_reason` STRING COMMENT 'Reason for the most recent price condition change or update',
    `price_list_type` STRING COMMENT 'Type of price list (standard, promotional, contract)',
    `price_unit` DECIMAL(18,2) COMMENT '',
    `raw_material_index_code` STRING COMMENT 'Raw material price index code for escalation',
    `scale_basis` STRING COMMENT 'Basis for scale pricing (quantity, value, weight)',
    `scale_quantity_from` DECIMAL(18,2) COMMENT 'Lower bound of the quantity scale for tiered pricing',
    `scale_quantity_to` DECIMAL(18,2) COMMENT 'Upper bound of the quantity scale for tiered pricing',
    `surcharge_amount` DECIMAL(18,2) COMMENT 'Additional surcharge amount (e.g., raw material surcharge, logistics surcharge)',
    `tooling_amortization_amount` DECIMAL(18,2) COMMENT 'Tooling amortization amount per unit',
    `unit_of_measure` STRING COMMENT '',
    `updated_timestamp` TIMESTAMP COMMENT '',
    `valid_from_date` DATE COMMENT 'Start date of condition validity',
    `valid_to_date` DATE COMMENT 'End date of condition validity',
    `volume_rebate_pct` DECIMAL(18,2) COMMENT 'Volume rebate percentage',
    `valid_from` DATE COMMENT '',
    `valid_to` DATE COMMENT '',
    CONSTRAINT pk_procurement_price_condition PRIMARY KEY(`procurement_price_condition_id`)
) COMMENT 'Negotiated pricing conditions and surcharges applicable to a supplier-material combination, including base price, freight surcharge, packaging surcharge, raw material index adjustment, currency exchange surcharge, and volume discount tiers. Captures condition type, validity period, scale basis, scale quantity, condition value, and currency. Enables accurate PO pricing and supports price variance analysis. Sourced from SAP MM condition records (KONP/KONH/MEK1). This product is the single source of truth (SSOT) for its concept in the ECM Lakehouse.';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`procurement`.`procurement_delivery_schedule` (
    `procurement_delivery_schedule_id` BIGINT COMMENT 'Unique identifier for the procurement_delivery_schedule data product (auto-inserted pre-linking).',
    `procurement_goods_receipt_id` BIGINT COMMENT 'Link to the goods receipt confirming delivery',
    `procurement_po_line_id` BIGINT COMMENT '',
    `procurement_purchase_order_id` BIGINT COMMENT 'Foreign key linking to procurement.purchase_order. Business justification: A delivery schedule always belongs to a purchase order; adding purchase_order_id FK to procurement_delivery_schedule links the schedule to its parent order.',
    `plant_id` BIGINT COMMENT 'Plant receiving the delivery',
    `scheduling_agreement_line_id` BIGINT COMMENT 'Foreign key linking to procurement.scheduling_agreement_line. Business justification: Procurement delivery schedules (JIT call-offs) are generated from scheduling agreement lines. Linking procurement_delivery_schedule to scheduling_agreement_line enables tracking of actual delivery cal',
    `actual_date` DATE COMMENT 'Actual delivery date',
    `actual_quantity` DECIMAL(18,2) COMMENT 'Actual quantity delivered',
    `asn_number` STRING COMMENT 'Advance shipping notification number from the supplier',
    `carrier_name` STRING COMMENT 'Name of the carrier responsible for this scheduled delivery',
    `confirmed_date` DATE COMMENT '',
    `confirmed_delivery_date` DATE COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT '',
    `data_governance_ref` STRING COMMENT 'Reference to data governance catalog entry for lineage and ownership tracking',
    `delivered_quantity` DECIMAL(18,2) COMMENT '',
    `delivery_date` DATE COMMENT '',
    `delivery_priority` STRING COMMENT 'Priority classification for this delivery schedule line (normal, urgent, critical)',
    `delivery_status` STRING COMMENT 'Status (planned, confirmed, in-transit, received)',
    `delivery_tolerance_days` STRING COMMENT 'Allowed tolerance in days for early or late delivery',
    `inbound_delivery_number` STRING COMMENT 'Reference number of the inbound delivery document',
    `jit_call_number` STRING COMMENT 'Just-in-time delivery call-off number for sequenced supply',
    `material_number` STRING COMMENT '',
    `on_time_delivery_flag` BOOLEAN COMMENT 'Indicates whether the delivery was received within the tolerance window',
    `open_quantity` DECIMAL(18,2) COMMENT '',
    `received_quantity` DECIMAL(18,2) COMMENT '',
    `requested_date` DATE COMMENT '',
    `requested_delivery_date` DATE COMMENT '',
    `schedule_line_number` STRING COMMENT '',
    `schedule_status` STRING COMMENT '',
    `scheduled_date` DATE COMMENT 'Scheduled delivery date',
    `scheduled_delivery_date` DATE COMMENT '',
    `scheduled_quantity` DECIMAL(18,2) COMMENT 'Quantity scheduled for delivery',
    `shipping_point` STRING COMMENT 'Shipping point of origin',
    `storage_location_code` STRING COMMENT 'Target storage location code for received materials',
    `unit_of_measure` STRING COMMENT '',
    `unloading_point` STRING COMMENT 'Specific unloading point or dock at the receiving plant',
    `uom` STRING COMMENT '',
    `updated_timestamp` TIMESTAMP COMMENT '',
    CONSTRAINT pk_procurement_delivery_schedule PRIMARY KEY(`procurement_delivery_schedule_id`)
) COMMENT 'Inbound delivery schedule communicated to suppliers specifying exact delivery windows, quantities, and dock assignments for JIT and JIS supply to assembly plants. Captures schedule type (firm, forecast, JIT call-off), delivery date and time window, dock door assignment, carrier, packaging type, number of containers, and schedule transmission status (EDI 830/862 sent). Enables synchronized inbound logistics and production line feeding. Distinct from scheduling agreement lines which are the contractual commitment.';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`procurement`.`supplier_nonconformance` (
    `supplier_nonconformance_id` BIGINT COMMENT 'System‑generated unique identifier for the supplier nonconformance record.',
    `procurement_goods_receipt_id` BIGINT COMMENT 'Foreign key linking to procurement.procurement_goods_receipt. Business justification: Supplier nonconformances are typically detected at goods receipt (incoming inspection). Linking supplier_nonconformance to the specific procurement_goods_receipt event enables traceability from NCR ba',
    `procurement_po_line_id` BIGINT COMMENT 'Foreign key linking to procurement.procurement_po_line. Business justification: Supplier nonconformances are raised against specific part numbers and PO line items. Linking to procurement_po_line enables traceability from NCR to the specific procurement transaction, supports defe',
    `procurement_supplier_id` BIGINT COMMENT 'Unique identifier of the supplier that provided the nonconforming part.',
    `closure_status` STRING COMMENT 'Current status of the nonconformance record.. Valid values are `open|closed|cancelled|deferred`',
    `closure_timestamp` TIMESTAMP COMMENT 'Date‑time when the nonconformance was formally closed.',
    `containment_action` STRING COMMENT 'Immediate action taken to contain the defect (e.g., quarantine, segregation).',
    `corrective_action_due_date` DATE COMMENT 'Date by which the supplier must implement a corrective action.',
    `corrective_action_status` STRING COMMENT 'Current state of the supplier corrective action request (SCAR).. Valid values are `pending|in_progress|completed|failed`',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the nonconformance record was first created in the lakehouse.',
    `defect_code` STRING COMMENT 'Standardized code that classifies the type of defect (e.g., surface, dimensional, functional).',
    `defect_description` STRING COMMENT 'Narrative description of the observed defect.',
    `supplier_nonconformance_description` STRING COMMENT 'Description',
    `detected_date` DATE COMMENT 'Detected date',
    `detection_point` STRING COMMENT 'Location in the value chain where the nonconformance was detected.. Valid values are `incoming_inspection|line_side|warranty|post_sale`',
    `detection_timestamp` TIMESTAMP COMMENT 'Exact date‑time when the defect was first recorded.',
    `eight_d_report_reference` STRING COMMENT 'Identifier of the associated 8‑D problem‑solving report.',
    `ncr_number` STRING COMMENT 'NCR number',
    `nonconformance_number` STRING COMMENT 'Business‑visible identifier assigned to the nonconformance event, used in reporting and communication.',
    `nonconformance_status` STRING COMMENT '',
    `part_description` STRING COMMENT 'Brief textual description of the part.',
    `part_number` STRING COMMENT 'Manufacturer part number (or SKU) of the component that failed inspection.',
    `portal_submission_flag` BOOLEAN COMMENT 'Whether nonconformance was submitted via supplier collaboration portal',
    `ppm_count` DECIMAL(18,2) COMMENT 'Defect rate expressed in parts per million.',
    `rejected_quantity` BIGINT COMMENT 'Number of units rejected because of the defect.',
    `reported_date` DATE COMMENT '',
    `root_cause_category` STRING COMMENT 'High‑level classification of the root cause.. Valid values are `design|process|material|supplier|external|unknown`',
    `root_cause_description` STRING COMMENT 'Detailed explanation of the underlying cause of the defect.',
    `severity` STRING COMMENT 'Severity',
    `severity_level` STRING COMMENT 'Impact rating of the nonconformance on product quality and safety.. Valid values are `critical|major|minor|warning|info`',
    `supplier_nonconformance_status` STRING COMMENT 'Status',
    `total_inspected_quantity` BIGINT COMMENT 'Total number of units inspected during the detection event.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent modification to the record.',
    CONSTRAINT pk_supplier_nonconformance PRIMARY KEY(`supplier_nonconformance_id`)
) COMMENT 'Formal record of a supplier quality nonconformance event, capturing the rejected part number, defect description, defect code, PPM count, detection point (incoming inspection, line-side, warranty), containment action, 8D report reference, root cause category, corrective action due date, and closure status. Triggers supplier corrective action requests (SCAR) and feeds into supplier evaluation scoring. Integrates with SAP QM quality notification (QM10).';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`procurement`.`spend_transaction` (
    `spend_transaction_id` BIGINT COMMENT 'System-generated unique identifier for the spend transaction record.',
    `equipment_registry_id` BIGINT COMMENT 'Foreign key linking to asset.equipment_registry. Business justification: Spend Transaction for equipment maintenance must be allocated to the specific equipment; linking supports cost accounting and OEE analysis.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Spend transaction must be posted to a GL account for accurate financial reporting.',
    `invoice_id` BIGINT COMMENT 'Identifier of the supplier invoice linked to this spend.',
    `plant_id` BIGINT COMMENT 'Identifier of the manufacturing plant or site where the spend was incurred.',
    `procurement_purchase_order_id` BIGINT COMMENT 'Identifier of the purchase order that generated this spend transaction.',
    `procurement_supplier_id` BIGINT COMMENT 'Unique identifier of the supplier associated with the spend.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Profit center tracking of spend transactions supports segment profitability reporting.',
    `purchase_requisition_id` BIGINT COMMENT 'Identifier of the purchase requisition that originated the transaction.',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_requirement. Business justification: REQUIRED: Spend transactions are allocated to specific regulatory requirements for compliance budgeting and audit traceability.',
    `sku_master_id` BIGINT COMMENT 'Foreign key linking to inventory.sku_master. Business justification: REQUIRED: Spend analytics and cost‑to‑serve reports aggregate spend by SKU; FK to SKU master provides consistent material identification.',
    `employee_id` BIGINT COMMENT 'Identifier of the employee who approved the spend.',
    `spend_category_id` BIGINT COMMENT 'Foreign key linking to procurement.spend_category. Business justification: spend_transaction has spend_category (STRING) and spend_subcategory (STRING) as denormalized text fields. Replacing with a FK to spend_category (which is a hierarchical taxonomy) enables structured sp',
    `spend_employee_id` BIGINT COMMENT 'Identifier of the employee who approved the spend.',
    `supplier_contract_id` BIGINT COMMENT 'Identifier of the supplier contract governing the transaction.',
    `supplier_invoice_id` BIGINT COMMENT 'Foreign key linking to procurement.supplier_invoice. Business justification: Spend transactions represent actual confirmed spend. They should reference the supplier invoice that generated the spend record for full procure-to-pay traceability. This enables reconciliation betwee',
    `vehicle_order_id` BIGINT COMMENT 'Foreign key linking to sales.vehicle_order. Business justification: Provides Financial reporting per vehicle order linking spend entries to the exact vehicle order they support.',
    `accounting_date` DATE COMMENT 'Date used for posting the transaction to the general ledger.',
    `amount` DECIMAL(18,2) COMMENT '',
    `approval_status` STRING COMMENT 'Current approval state of the spend transaction.. Valid values are `approved|rejected|pending`',
    `approved_timestamp` TIMESTAMP COMMENT 'Timestamp when the spend transaction received approval.',
    `commodity_code` STRING COMMENT 'Standard commodity classification code (e.g., UNSPSC) for the purchased item.',
    `cost_center_code` STRING COMMENT 'Internal cost‑center code used for allocating the spend.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the spend transaction record was first created in the data lake.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 currency code of the transaction.. Valid values are `^[A-Z]{3}$`',
    `data_governance_ref` STRING COMMENT 'Reference to data governance catalog entry for lineage and ownership tracking',
    `exchange_rate` DECIMAL(18,2) COMMENT 'Currency conversion rate to the corporate reporting currency at transaction time.',
    `fiscal_period` STRING COMMENT 'Fiscal period or month within the fiscal year (e.g., 2023Q1).',
    `fiscal_year` STRING COMMENT 'Fiscal year (e.g., FY2023) to which the spend is allocated.',
    `gross_amount` DECIMAL(18,2) COMMENT 'Total amount including net amount and tax.',
    `invoice_date` DATE COMMENT 'Date printed on the supplier invoice.',
    `is_blocked` BOOLEAN COMMENT 'Indicates whether the spend line is blocked for payment or further processing.',
    `is_service_line` BOOLEAN COMMENT 'True if the spend line represents a service rather than a material.',
    `is_tax_included` BOOLEAN COMMENT 'Flag indicating whether tax is already included in the unit price.',
    `net_amount` DECIMAL(18,2) COMMENT 'Total net spend amount (quantity × unit price) after discounts, before tax.',
    `payment_date` DATE COMMENT 'Date on which payment for the transaction was made or scheduled.',
    `payment_terms` STRING COMMENT 'Standard payment terms (e.g., Net 30, 2% 10 Net 30).',
    `project_code` STRING COMMENT 'Identifier of the internal project or initiative funded by the spend.',
    `quantity` DECIMAL(18,2) COMMENT 'Amount of material or service units purchased.',
    `receipt_number` STRING COMMENT 'Number of the goods receipt document linked to the spend.',
    `source_system_load_timestamp` TIMESTAMP COMMENT 'Timestamp when the source system record was loaded into the lakehouse.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Tax component applied to the net amount.',
    `tax_code` STRING COMMENT 'Tax jurisdiction code applied to the transaction.',
    `transaction_date` DATE COMMENT '',
    `transaction_number` STRING COMMENT 'Business-visible identifier assigned to the spend transaction (e.g., invoice or receipt number).',
    `transaction_status` STRING COMMENT 'Current lifecycle state of the spend transaction.. Valid values are `posted|pending|cancelled|reversed|draft|approved`',
    `transaction_timestamp` TIMESTAMP COMMENT 'Date and time when the spend transaction was recorded in the source system.',
    `unit_of_measure` STRING COMMENT 'UOM for the quantity (e.g., EA, KG, L).',
    `unit_price` DECIMAL(18,2) COMMENT 'Price per unit before taxes and discounts, in transaction currency.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the spend transaction record.',
    CONSTRAINT pk_spend_transaction PRIMARY KEY(`spend_transaction_id`)
) COMMENT 'Actuals-level spend record aggregating confirmed procurement spend by supplier, commodity, plant, cost center, and period. Captures transaction date, PO reference, invoice reference, material or service description, spend category, quantity, unit price, net spend amount, currency, tax amount, payment date, and spend classification (direct, indirect, CapEx, MRO). Serves as the foundational spend cube for category management, supplier rationalization, and savings tracking. Derived from confirmed goods receipts and posted invoices.';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`procurement`.`savings_initiative` (
    `savings_initiative_id` BIGINT COMMENT 'System-generated unique identifier for each savings initiative.',
    `procurement_supplier_id` BIGINT COMMENT 'Identifier of the supplier associated with the savings initiative.',
    `employee_id` BIGINT COMMENT 'Identifier of the internal buyer or procurement owner responsible for the initiative.',
    `savings_employee_id` BIGINT COMMENT 'Identifier of the internal buyer or procurement owner responsible for the initiative.',
    `sourcing_event_id` BIGINT COMMENT 'Foreign key linking to procurement.sourcing_event. Business justification: Savings initiatives are often generated through competitive sourcing events (RFQ/RFP). Linking savings_initiative to the sourcing_event that generated the savings enables tracking of sourcing-driven v',
    `spend_category_id` BIGINT COMMENT 'Foreign key linking to procurement.spend_category. Business justification: Savings initiatives are organized by commodity/spend category. The existing commodity (STRING) field is denormalized text. Linking to spend_category enables structured savings reporting by category hi',
    `supplier_contract_id` BIGINT COMMENT 'Foreign key linking to procurement.supplier_contract. Business justification: Procurement savings initiatives are typically realized through contract renegotiations, price reductions, or new contract terms. Linking savings_initiative to supplier_contract enables tracking of whi',
    `actual_savings_amount` DECIMAL(18,2) COMMENT 'Realized monetary savings after the initiative has been completed.',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when the initiative received formal approval.',
    `approved_by` BIGINT COMMENT 'Identifier of the employee who approved the initiative.',
    `baseline_spend` DECIMAL(18,2) COMMENT 'Annual spend amount for the commodity/supplier before any savings actions, expressed in the functional currency.',
    `commodity` STRING COMMENT 'Primary commodity or material group targeted by the initiative (e.g., steel, electronics).',
    `cost_center_code` STRING COMMENT 'Internal cost center responsible for the spend and savings.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the savings initiative record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for all monetary values in this record.. Valid values are `^[A-Z]{3}$`',
    `data_governance_ref` STRING COMMENT 'Reference to data governance catalog entry for lineage and ownership tracking',
    `effective_end_date` DATE COMMENT 'Date when the initiative is considered closed; may be null for open‑ended initiatives.',
    `effective_start_date` DATE COMMENT 'Date when the initiative becomes active and savings can start to be realized.',
    `initiative_name` STRING COMMENT 'Descriptive name of the savings initiative for reporting and search.',
    `initiative_number` STRING COMMENT 'Business-visible identifier or code assigned to the savings initiative.',
    `initiative_type` STRING COMMENT 'Category of the initiative indicating the nature of the expected savings.. Valid values are `hard_savings|cost_avoidance|payment_term_improvement|process_improvement`',
    `notes` STRING COMMENT 'Additional comments, observations, or rationale related to the initiative.',
    `plant_code` STRING COMMENT 'Manufacturing plant or site linked to the initiative.',
    `program_year` STRING COMMENT 'Fiscal year to which the initiative is assigned for budgeting and reporting.',
    `region_code` STRING COMMENT 'Three‑letter code representing the geographic region of the initiative.. Valid values are `^[A-Z]{3}$`',
    `savings_initiative_status` STRING COMMENT 'Current lifecycle state of the initiative.. Valid values are `identified|approved|in_negotiation|realized|cancelled`',
    `savings_validation_method` STRING COMMENT 'Method used to verify that the reported savings are accurate and compliant.. Valid values are `internal_audit|external_audit|financial_system|management_review`',
    `target_savings_amount` DECIMAL(18,2) COMMENT 'Projected monetary savings to be achieved by the initiative.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent modification to the record.',
    CONSTRAINT pk_savings_initiative PRIMARY KEY(`savings_initiative_id`)
) COMMENT 'Procurement cost savings project tracking negotiated price reductions, value engineering changes, demand reduction, specification changes, or payment term improvements. Captures initiative type (hard savings, cost avoidance, payment terms), commodity, supplier, baseline spend, target savings amount, actual realized savings, savings validation method, responsible buyer, program year, and initiative status (identified, approved, in-negotiation, realized, cancelled). Supports procurement KPI reporting and annual savings target tracking.';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`procurement`.`payment_run` (
    `payment_run_id` BIGINT COMMENT 'Unique identifier for the payment run batch.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Payment run aggregates payments to a GL account for cash‑flow and reconciliation reporting.',
    `procurement_supplier_id` BIGINT COMMENT 'Identifier of the supplier whose invoices are being paid in this run.',
    `approval_status` STRING COMMENT 'Approval workflow status for the run.. Valid values are `approved|pending|rejected`',
    `approved_by` STRING COMMENT 'User identifier who approved the payment run.',
    `approved_timestamp` TIMESTAMP COMMENT 'Timestamp when the payment run received approval.',
    `batch_number` STRING COMMENT 'Identifier of the batch within the automatic payment program.',
    `comments` STRING COMMENT 'Additional comments or remarks entered by the processor.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the payment run record was first created in the data lake.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 currency code for the payment run.',
    `currency_rate` DECIMAL(18,2) COMMENT 'Exchange rate applied to convert amounts to the reporting currency.',
    `data_governance_ref` STRING COMMENT 'Reference to data governance catalog entry for lineage and ownership tracking',
    `payment_run_description` STRING COMMENT 'Free‑text description or notes for the payment run.',
    `discount_taken_flag` BOOLEAN COMMENT 'Indicates whether any discount was applied in the run.',
    `execution_end_timestamp` TIMESTAMP COMMENT 'Timestamp when the automatic payment program finished processing.',
    `execution_start_timestamp` TIMESTAMP COMMENT 'Timestamp when the automatic payment program started processing.',
    `fee_amount` DECIMAL(18,2) COMMENT 'Total processing fees charged for the run.',
    `is_automated` BOOLEAN COMMENT 'True if the run was generated by an automated schedule, false if manually triggered.',
    `number_of_invoices` STRING COMMENT 'Count of supplier invoices cleared in this payment run.',
    `payment_method` STRING COMMENT 'Instrument used to execute the payments.. Valid values are `ACH|wire|check|virtual_card|direct_deposit`',
    `processing_time_seconds` STRING COMMENT 'Total duration of the run in seconds (end minus start).',
    `reference` STRING COMMENT 'Reference number from external banking or clearing house, if applicable.',
    `run_date` DATE COMMENT 'Calendar date on which the payment run was executed.',
    `run_number` STRING COMMENT 'Business identifier assigned to the payment run by the source system.',
    `run_status` STRING COMMENT 'Current lifecycle status of the payment run.. Valid values are `scheduled|in_progress|completed|failed|cancelled`',
    `run_timestamp` TIMESTAMP COMMENT 'Exact timestamp when the payment run was initiated.',
    `run_type` STRING COMMENT 'Classification of the run (e.g., regular scheduled, ad‑hoc, or correction).. Valid values are `regular|ad_hoc|correction`',
    `settlement_date` DATE COMMENT 'Date on which the funds are expected to settle in the suppliers account.',
    `settlement_status` STRING COMMENT 'Current settlement status of the payment run.. Valid values are `pending|settled|failed`',
    `status_reason` STRING COMMENT 'Free‑text explanation for the current status, e.g., error details.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Total tax amount included in the payment run.',
    `total_discount_amount` DECIMAL(18,2) COMMENT 'Aggregate discount amount applied across all invoices in the run.',
    `total_discount_percent` DECIMAL(18,2) COMMENT 'Overall discount percentage applied across the run.',
    `total_gross_amount` DECIMAL(18,2) COMMENT 'Sum of all invoice gross amounts before any discounts or fees.',
    `total_invoices_amount` DECIMAL(18,2) COMMENT 'Aggregate gross amount of all invoices before discounts.',
    `total_net_amount` DECIMAL(18,2) COMMENT 'Net amount paid after discounts, taxes, and fees.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the payment run record.',
    `created_by` STRING COMMENT 'User identifier who created the payment run record.',
    CONSTRAINT pk_payment_run PRIMARY KEY(`payment_run_id`)
) COMMENT 'Automated payment execution batch for supplier invoice payments, capturing payment run date, payment method (ACH, wire, check, virtual card), bank account, total payment amount, currency, number of invoices cleared, discount taken, and payment run status. Represents the final step of the procure-to-pay cycle. Sourced from SAP FI automatic payment program (F110/PAYR). Distinct from individual supplier invoices — this is the payment execution event.';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`procurement`.`approval` (
    `approval_id` BIGINT COMMENT 'System-generated unique identifier for the procurement approval record.',
    `employee_id` BIGINT COMMENT 'Identifier of the employee or user to whom the approval was delegated.',
    `approval_employee_id` BIGINT COMMENT 'Unique identifier of the employee or user who performed the approval.',
    `approval_group_id` BIGINT COMMENT 'Identifier of the approval group or committee responsible for this step.',
    `auto_approval_rule_id` BIGINT COMMENT 'Identifier of the rule that triggered automatic approval.',
    `primary_approval_delegated_to_employee_id` BIGINT COMMENT 'Identifier of the employee or user to whom the approval was delegated.',
    `procurement_document_id` BIGINT COMMENT 'Unique identifier of the underlying procurement document (e.g., requisition ID, PO number).',
    `action` STRING COMMENT 'Result of the approval decision for this step.. Valid values are `approved|rejected|escalated|withdrawn`',
    `approval_number` STRING COMMENT 'Human-readable identifier for the approval workflow instance.',
    `approval_status` STRING COMMENT 'Current lifecycle status of the approval record.. Valid values are `pending|in_progress|completed|cancelled`',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when the approval decision was recorded.',
    `approved_amount` DECIMAL(18,2) COMMENT 'Monetary amount that was approved in this step.',
    `approver_role` STRING COMMENT 'Organizational role of the individual responsible for this approval step.. Valid values are `procurement_manager|finance|legal|executive|operations|supply_chain`',
    `attachment_flag` BOOLEAN COMMENT 'Indicates whether supporting documents are attached to the approval record.',
    `attachment_url` STRING COMMENT 'Link to the location of attached supporting documentation.',
    `comments` STRING COMMENT 'Free-text comments provided by the approver regarding the decision.',
    `compliance_flag` BOOLEAN COMMENT 'True if the approval must satisfy regulatory or internal compliance requirements.',
    `compliance_requirements` STRING COMMENT 'Textual description of specific compliance criteria applicable to this approval.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the approval record was initially created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO currency code for the monetary amounts.. Valid values are `[A-Z]{3}`',
    `data_governance_ref` STRING COMMENT 'Reference to data governance catalog entry for lineage and ownership tracking',
    `deadline` DATE COMMENT 'Date by which the approval decision must be completed.',
    `decision_reason` STRING COMMENT 'Explanation provided for the approval decision, especially if rejected.',
    `delegation_flag` BOOLEAN COMMENT 'Indicates whether the approval was delegated to another individual (True) or performed by the assigned approver (False).',
    `document_type` STRING COMMENT 'Type of procurement document subject to this approval.. Valid values are `requisition|purchase_order|contract|capex`',
    `escalation_reason` STRING COMMENT 'Reason for escalating the approval to a higher authority.',
    `expiration_timestamp` TIMESTAMP COMMENT 'Date and time when the approval request expires if no action is taken.',
    `is_auto_approved` BOOLEAN COMMENT 'Indicates whether the approval was granted automatically by system rules.',
    `is_critical` BOOLEAN COMMENT 'Indicates whether the procurement item is classified as critical for business operations.',
    `is_final_approval` BOOLEAN COMMENT 'True if this step represents the final required approval in the workflow.',
    `policy_code` STRING COMMENT 'Code identifying the delegation of authority policy applied to this approval.',
    `policy_version` STRING COMMENT 'Version identifier of the approval policy.',
    `risk_score` DECIMAL(18,2) COMMENT 'Numerical risk rating (0-100) associated with the procurement request.',
    `spend_amount` DECIMAL(18,2) COMMENT 'Monetary amount requested for the procurement document subject to approval.',
    `step_sequence` STRING COMMENT 'Sequential order of this approval step within the overall workflow.',
    `threshold_amount` DECIMAL(18,2) COMMENT 'Spend threshold that triggers this approval level according to delegation of authority policy.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the approval record.',
    CONSTRAINT pk_approval PRIMARY KEY(`approval_id`)
) COMMENT 'Workflow approval record for procurement documents requiring authorization (purchase requisitions, purchase orders, contracts, CapEx requisitions) based on spend thresholds, commodity type, or strategic significance. Captures document reference, approval step sequence, approver role, approver identity, approval action (approved, rejected, escalated), approval timestamp, comments, and delegation flag. Supports Automotives procurement governance and delegation of authority (DOA) policy enforcement.';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`procurement`.`vendor` (
    `vendor_id` BIGINT COMMENT '',
    `parent_vendor_id` BIGINT COMMENT '',
    `address_line1` STRING COMMENT '',
    `address_line2` STRING COMMENT '',
    `bank_account_number` STRING COMMENT '',
    `bank_name` STRING COMMENT '',
    `city` STRING COMMENT '',
    `vendor_code` STRING COMMENT '',
    `commodity_specialization` STRING COMMENT '',
    `country_code` STRING COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT '',
    `credit_limit` DECIMAL(18,2) COMMENT '',
    `currency_code` STRING COMMENT '',
    `duns_number` STRING COMMENT '',
    `e_procurement_portal_enabled` BOOLEAN COMMENT '',
    `effective_end_date` DATE COMMENT '',
    `effective_start_date` DATE COMMENT '',
    `iatf16949_cert_expiry` DATE COMMENT '',
    `iatf16949_certified` BOOLEAN COMMENT '',
    `incoterms` STRING COMMENT '',
    `iso14001_cert_expiry` DATE COMMENT '',
    `iso14001_certified` BOOLEAN COMMENT '',
    `iso9001_cert_expiry` DATE COMMENT '',
    `iso9001_certified` BOOLEAN COMMENT '',
    `lead_time_days` STRING COMMENT '',
    `legal_name` STRING COMMENT '',
    `max_order_quantity` STRING COMMENT '',
    `min_order_quantity` STRING COMMENT '',
    `vendor_name` STRING COMMENT '',
    `notes` STRING COMMENT '',
    `onboarding_date` DATE COMMENT '',
    `payment_terms` STRING COMMENT '',
    `postal_code` STRING COMMENT '',
    `preferred_language` STRING COMMENT '',
    `primary_contact_email` STRING COMMENT '',
    `primary_contact_name` STRING COMMENT '',
    `primary_contact_phone` STRING COMMENT '',
    `state_province` STRING COMMENT '',
    `supplier_category` STRING COMMENT '',
    `swift_code` STRING COMMENT '',
    `tax_exempt_flag` BOOLEAN COMMENT '',
    `tax_identification_number` STRING COMMENT '',
    `updated_timestamp` TIMESTAMP COMMENT '',
    `vat_number` STRING COMMENT '',
    `vendor_status` STRING COMMENT '',
    `vendor_type` STRING COMMENT '',
    `website_url` STRING COMMENT '',
    CONSTRAINT pk_vendor PRIMARY KEY(`vendor_id`)
) COMMENT 'Master reference table for vendor. ';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`procurement`.`program_supplier_contract` (
    `program_supplier_contract_id` BIGINT COMMENT 'Primary key',
    `part_master_id` BIGINT COMMENT 'FK to part master',
    `procurement_supplier_id` BIGINT COMMENT 'FK to procurement supplier',
    `sourcing_event_id` BIGINT COMMENT 'FK to sourcing event',
    `supplier_contract_id` BIGINT COMMENT 'Foreign key linking to procurement.supplier_contract. Business justification: A program_supplier_contract is a program-specific contractual agreement that is typically derived from or references a master supplier_contract (framework agreement). Linking program_supplier_contract',
    `vehicle_program_id` BIGINT COMMENT 'FK to vehicle program',
    `annual_volume` STRING COMMENT 'Annual volume commitment',
    `contract_number` STRING COMMENT 'Unique contract number',
    `contract_status` STRING COMMENT 'Contract status',
    `contract_type` STRING COMMENT 'Type of contract',
    `cost_reduction_target_pct` DECIMAL(18,2) COMMENT 'Annual cost reduction target percentage',
    `created_timestamp` TIMESTAMP COMMENT 'Record creation timestamp',
    `currency_code` STRING COMMENT 'Currency code',
    `data_governance_ref` STRING COMMENT 'Reference to data governance catalog entry for lineage and ownership tracking',
    `delivery_performance_target_pct` DECIMAL(18,2) COMMENT 'Delivery performance target percentage',
    `effective_end_date` DATE COMMENT 'Contract end date',
    `effective_start_date` DATE COMMENT 'Contract start date',
    `incoterms` STRING COMMENT 'Incoterms',
    `inspection_level` STRING COMMENT 'Incoming inspection level (skip-lot, normal, tightened)',
    `ip_ownership` STRING COMMENT 'IP ownership terms',
    `liability_cap` DECIMAL(18,2) COMMENT 'Liability cap amount',
    `localization_content_pct` DECIMAL(18,2) COMMENT 'Required local content percentage for compliance',
    `minimum_order_quantity` STRING COMMENT 'Minimum order quantity per release',
    `packaging_specification` STRING COMMENT 'Required packaging specification for deliveries',
    `payment_terms` STRING COMMENT 'Payment terms',
    `penalty_rate_pct` DECIMAL(18,2) COMMENT 'Penalty rate percentage for non-compliance',
    `price_escalation_clause` DECIMAL(18,2) COMMENT 'Price escalation clause value',
    `quality_target_ppm` STRING COMMENT 'Quality target in PPM',
    `renewal_option_flag` BOOLEAN COMMENT 'Whether contract has renewal option',
    `sustainability_clause_flag` BOOLEAN COMMENT 'Whether contract includes sustainability/ESG requirements',
    `tooling_amortization_flag` BOOLEAN COMMENT 'Whether tooling is amortized in piece price',
    `total_contract_value` DECIMAL(18,2) COMMENT 'Total contract value',
    `updated_timestamp` TIMESTAMP COMMENT 'Record last update timestamp',
    `warranty_coverage_months` STRING COMMENT 'Warranty coverage in months',
    CONSTRAINT pk_program_supplier_contract PRIMARY KEY(`program_supplier_contract_id`)
) COMMENT 'Represents the contractual agreement between a vehicle development program and a supplier. Each record links one vehicle_program to one supplier and stores contract‑specific data that is relevant only to that pairing.. Existence Justification: Vehicle development programs engage multiple suppliers for parts, services, and components, and each supplier can provide for many different vehicle programs. The business creates and manages a contract for each program‑supplier pairing, capturing contract details such as number, type, effective dates, and price escalation clauses.';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`procurement`.`procurement_supply_agreement` (
    `procurement_supply_agreement_id` BIGINT COMMENT 'Primary key for the supply_agreement association',
    `procurement_supplier_id` BIGINT COMMENT 'Foreign key linking to the supplier master',
    `spare_parts_catalog_id` BIGINT COMMENT 'Foreign key linking to the spare parts catalog entry',
    `supplier_contract_id` BIGINT COMMENT '',
    `agreement_number` STRING COMMENT 'Supply agreement number',
    `agreement_status` STRING COMMENT '',
    `agreement_type` STRING COMMENT 'Type (blanket, consignment, VMI, JIT)',
    `committed_volume` DECIMAL(18,2) COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT '',
    `currency_code` STRING COMMENT 'Currency of the agreement',
    `data_governance_ref` STRING COMMENT 'Reference to data governance catalog entry for lineage and ownership tracking',
    `end_date` DATE COMMENT 'Agreement end date',
    `incoterms` STRING COMMENT '',
    `lead_time_days` STRING COMMENT 'Lead time in days for this supplier to deliver the part',
    `material_number` STRING COMMENT '',
    `minimum_order_quantity` DECIMAL(18,2) COMMENT 'Minimum order quantity per release',
    `payment_terms` STRING COMMENT '',
    `start_date` DATE COMMENT 'Agreement start date',
    `procurement_supply_agreement_status` STRING COMMENT 'Agreement status (draft, active, expired, terminated)',
    `total_value` DECIMAL(18,2) COMMENT 'Total agreement value',
    `unit_price` DECIMAL(18,2) COMMENT 'Agreed price for the part from this supplier',
    `updated_timestamp` TIMESTAMP COMMENT '',
    `valid_from_date` DATE COMMENT '',
    `valid_to_date` DATE COMMENT '',
    CONSTRAINT pk_procurement_supply_agreement PRIMARY KEY(`procurement_supply_agreement_id`)
) COMMENT 'Represents the contractual relationship between a supplier and a spare part catalog entry. Each record links one supplier to one spare part and stores attributes that are specific to that supplier‑part combination, such as price and lead time.. Existence Justification: A supplier can provide many spare parts, and each spare part can be sourced from multiple approved suppliers. The business actively manages a supply agreement for each supplier‑part pair, capturing unit price, lead time, and contract identifier. These agreements are created, updated, and retired as part of procurement planning.';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`procurement`.`supplier_regulatory_compliance` (
    `supplier_regulatory_compliance_id` BIGINT COMMENT 'Primary key for the SupplierRegulatoryCompliance association',
    `procurement_supplier_id` BIGINT COMMENT 'Foreign key linking to supplier',
    `regulatory_requirement_id` BIGINT COMMENT 'Foreign key linking to regulatory requirement',
    `employee_id` BIGINT COMMENT '',
    `assessment_date` DATE COMMENT '',
    `certification_number` STRING COMMENT 'Certification or registration number',
    `compliance_category` STRING COMMENT '',
    `compliance_deadline` DATE COMMENT 'Deadline by which the supplier must achieve compliance for this requirement',
    `compliance_status` STRING COMMENT 'Current compliance status of the supplier for the requirement (e.g., compliant, non‑compliant, pending)',
    `compliance_type` STRING COMMENT 'Type of regulatory compliance (REACH, RoHS, conflict minerals)',
    `created_timestamp` TIMESTAMP COMMENT '',
    `digital_certificate_url` STRING COMMENT 'URL to digitally stored compliance certificate',
    `effective_date` DATE COMMENT 'Effective date',
    `evidence_document_path` STRING COMMENT 'File path or URL to the evidence document supporting compliance',
    `expiry_date` DATE COMMENT 'Expiry date',
    `is_compliant` BOOLEAN COMMENT '',
    `issuing_authority` STRING COMMENT 'Authority that issued the compliance certification',
    `jurisdiction` STRING COMMENT '',
    `last_audit_date` DATE COMMENT 'Date of last compliance audit',
    `next_review_date` DATE COMMENT '',
    `regulation_name` STRING COMMENT '',
    `updated_timestamp` TIMESTAMP COMMENT '',
    `valid_from_date` DATE COMMENT 'Compliance validity start date',
    `valid_to_date` DATE COMMENT 'Compliance validity end date',
    CONSTRAINT pk_supplier_regulatory_compliance PRIMARY KEY(`supplier_regulatory_compliance_id`)
) COMMENT 'This association captures the compliance relationship between a supplier and a regulatory requirement, including the suppliers compliance status, supporting evidence, and deadline for each requirement.. Existence Justification: Suppliers must meet multiple regulatory requirements, and each regulatory requirement applies to many suppliers. The compliance team actively tracks the status, evidence, and deadlines for each supplier‑requirement pair, creating a many‑to‑many operational entity.';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`procurement`.`procurement_document` (
    `procurement_document_id` BIGINT COMMENT 'Primary key for procurement_document',
    `employee_id` BIGINT COMMENT 'Identifier of the employee who approved the document.',
    `predecessor_procurement_document_id` BIGINT COMMENT 'Self-referencing FK on procurement_document (predecessor_procurement_document_id)',
    `procurement_supplier_id` BIGINT COMMENT 'Unique identifier of the supplier associated with the document.',
    `approval_date` DATE COMMENT 'Date the document received final approval.',
    `confidentiality_level` STRING COMMENT 'Classification of the documents sensitivity.',
    `contract_term_months` STRING COMMENT 'Length of the contract in months.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the document record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for monetary values.',
    `data_governance_ref` STRING COMMENT 'Reference to data governance catalog entry for lineage and ownership tracking',
    `procurement_document_description` STRING COMMENT 'Free‑text description or summary of the documents purpose.',
    `discount_amount` DECIMAL(18,2) COMMENT 'Monetary value of the discount applied.',
    `discount_rate` DECIMAL(18,2) COMMENT 'Discount percentage granted on the gross amount.',
    `document_number` STRING COMMENT 'Business-visible identifier or reference number assigned to the document.',
    `document_status` STRING COMMENT 'Current lifecycle state of the document.',
    `document_type` STRING COMMENT 'Classification of the procurement document (e.g., contract, purchase order, invoice, statement of requirements).',
    `document_version` STRING COMMENT 'Sequential version number of the document.',
    `effective_from` DATE COMMENT 'Date on which the document becomes legally binding.',
    `effective_until` DATE COMMENT 'Date on which the document expires or is no longer in effect; null for open‑ended agreements.',
    `file_checksum` STRING COMMENT 'SHA‑256 checksum used to verify file integrity.',
    `file_path` STRING COMMENT 'Storage location or URI of the digital document file.',
    `issue_date` DATE COMMENT 'Date the document was formally issued by the organization.',
    `net_amount` DECIMAL(18,2) COMMENT 'Final payable amount after taxes and discounts.',
    `payment_due_date` DATE COMMENT 'Date by which payment must be received.',
    `payment_terms` STRING COMMENT 'Standard payment condition agreed for the document.',
    `procurement_category` STRING COMMENT 'Classification of spend (direct, indirect, capital expenditure, operating expenditure).',
    `received_date` DATE COMMENT 'Date the document was received by the counter‑party or internal stakeholder.',
    `renewal_flag` BOOLEAN COMMENT 'Indicates whether the contract is set for automatic renewal.',
    `renewal_notice_period_days` STRING COMMENT 'Number of days prior to expiry that renewal notice must be issued.',
    `retention_period_days` STRING COMMENT 'Number of days the document must be retained before archival or deletion.',
    `signed_by` STRING COMMENT 'Full legal name of the individual who signed the document.',
    `signed_date` DATE COMMENT 'Date the document was signed by the authorized signatory.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Total tax applied to the document.',
    `tax_rate` DECIMAL(18,2) COMMENT 'Applicable tax rate expressed as a percentage.',
    `total_amount` DECIMAL(18,2) COMMENT 'Gross monetary value of the document before taxes, discounts, or adjustments.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the document record.',
    CONSTRAINT pk_procurement_document PRIMARY KEY(`procurement_document_id`)
) COMMENT 'Master reference table for procurement_document. Referenced by document_id. SUPERSEDED: Use engineering.engineering_document as the single source of truth.';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`procurement`.`approval_group` (
    `approval_group_id` BIGINT COMMENT 'Primary key for approval_group',
    `parent_approval_group_id` BIGINT COMMENT 'Self-referencing FK on approval_group (parent_approval_group_id)',
    `approval_level` STRING COMMENT 'Numeric level indicating the hierarchy of the group within the approval chain.',
    `approval_threshold_amount` DECIMAL(18,2) COMMENT 'Monetary amount that must be met or exceeded before the group can approve a purchase.',
    `approval_group_code` STRING COMMENT 'Business code that uniquely identifies the approval group within the organization.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the approval group record was first created in the system.',
    `data_governance_ref` STRING COMMENT 'Reference to data governance catalog entry for lineage and ownership tracking',
    `department` STRING COMMENT 'Business department that owns and maintains the approval group.',
    `approval_group_description` STRING COMMENT 'Free‑form text describing the purpose, scope, and rules of the approval group.',
    `effective_from` DATE COMMENT 'Date when the approval group becomes active for use in procurement processes.',
    `effective_until` DATE COMMENT 'Date when the approval group is retired or no longer valid (null if open‑ended).',
    `escalation_policy` STRING COMMENT 'Policy that defines how approvals are escalated when thresholds are exceeded.',
    `is_system_defined` BOOLEAN COMMENT 'Indicates whether the approval group is a standard system‑defined group (true) or a custom user‑defined group (false).',
    `max_approvers` STRING COMMENT 'Maximum number of approvers allowed in this group for a single transaction.',
    `approval_group_name` STRING COMMENT 'Human‑readable name of the approval group used in procurement workflows.',
    `notes` STRING COMMENT 'Additional free‑form notes or comments about the approval group.',
    `region` STRING COMMENT 'Geographic region to which the approval group applies.',
    `requires_multi_approval` BOOLEAN COMMENT 'True if the group requires more than one approver for a transaction.',
    `approval_group_status` STRING COMMENT 'Current lifecycle status of the approval group.',
    `approval_group_type` STRING COMMENT 'Category of the approval group indicating its primary purpose (e.g., financial, operational).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the approval group record.',
    `created_by` STRING COMMENT 'User identifier of the person who initially created the approval group record.',
    CONSTRAINT pk_approval_group PRIMARY KEY(`approval_group_id`)
) COMMENT 'Master reference table for approval_group. Referenced by group_id.';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`procurement`.`auto_approval_rule` (
    `auto_approval_rule_id` BIGINT COMMENT 'Primary key for auto_approval_rule',
    `employee_id` BIGINT COMMENT 'Identifier of the user or team responsible for maintaining the rule.',
    `superseded_auto_approval_rule_id` BIGINT COMMENT 'Self-referencing FK on auto_approval_rule (superseded_auto_approval_rule_id)',
    `applies_to_purchase_category` STRING COMMENT 'Code of the purchase category (e.g., raw_materials, MRO) to which the rule applies.',
    `applies_to_supplier_segment` STRING COMMENT 'Supplier segment (e.g., tier‑1, strategic) for which the rule is relevant.',
    `approval_level` STRING COMMENT 'Numeric level indicating which approval tier the rule triggers (e.g., 1 = front‑line, 2 = manager).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the rule record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 currency code for the threshold amount.',
    `data_governance_ref` STRING COMMENT 'Reference to data governance catalog entry for lineage and ownership tracking',
    `auto_approval_rule_description` STRING COMMENT 'Detailed description of the rule purpose and logic.',
    `effective_from` DATE COMMENT 'Date when the rule becomes active and enforceable.',
    `effective_until` DATE COMMENT 'Date when the rule expires; null indicates an open‑ended rule.',
    `escalation_time_hours` STRING COMMENT 'Maximum hours allowed before the rule escalates to the next approval level.',
    `execution_count` BIGINT COMMENT 'Cumulative number of times the rule has been evaluated.',
    `is_mandatory` BOOLEAN COMMENT 'Indicates whether the rule must be satisfied for a purchase to be approved.',
    `last_executed_timestamp` TIMESTAMP COMMENT 'Timestamp of the last time the rule was evaluated against a purchase request.',
    `notes` STRING COMMENT 'Free‑form field for any supplemental information or comments about the rule.',
    `priority` STRING COMMENT 'Numeric priority determining rule evaluation order; lower numbers evaluate first.',
    `rule_code` STRING COMMENT 'Business code that uniquely identifies the rule across systems.',
    `rule_name` STRING COMMENT 'Human‑readable name of the rule used in procurement configuration.',
    `rule_type` STRING COMMENT 'Classification of the rule logic (e.g., amount threshold, supplier rating).',
    `auto_approval_rule_status` STRING COMMENT 'Current lifecycle status of the rule.',
    `threshold_value` DECIMAL(18,2) COMMENT 'Numeric threshold value used by amount‑based rules (e.g., maximum purchase amount).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the rule.',
    CONSTRAINT pk_auto_approval_rule PRIMARY KEY(`auto_approval_rule_id`)
) COMMENT 'Master reference table for auto_approval_rule. Referenced by auto_approval_rule_id.';

CREATE OR REPLACE TABLE `vibe_automotive_v1`.`procurement`.`eprocurement_portal` (
    `eprocurement_portal_id` BIGINT COMMENT 'Primary key for eprocurement_portal',
    `parent_eprocurement_portal_id` BIGINT COMMENT 'Self-referencing FK on eprocurement_portal (parent_eprocurement_portal_id)',
    `annual_license_cost` DECIMAL(18,2) COMMENT 'Annual software licensing cost paid to the platform provider for this portal instance, in the default currency.',
    `annual_spend_limit` DECIMAL(18,2) COMMENT 'Maximum total annual procurement spend authorized to be processed through this portal instance, used for budget governance.',
    `api_endpoint_url` STRING COMMENT 'Base URL of the portals REST or SOAP API endpoint used for system-to-system integration with SAP MM, ERP, and supplier systems.',
    `auction_enabled_flag` BOOLEAN COMMENT 'Indicates whether the portal supports reverse auction (e-auction) sourcing events for competitive bidding among suppliers.',
    `catalog_enabled_flag` BOOLEAN COMMENT 'Indicates whether the portal supports hosted or punchout supplier catalogs for standardized item ordering.',
    `contract_end_date` DATE COMMENT 'Date on which the platform provider contract for this portal expires or is scheduled for renewal.',
    `contract_management_flag` BOOLEAN COMMENT 'Indicates whether the portal includes contract lifecycle management (CLM) capabilities for supplier agreements and supply contracts.',
    `contract_start_date` DATE COMMENT 'Date on which the platform provider contract for this portal became effective.',
    `country_codes_in_scope` STRING COMMENT 'Comma-separated list of ISO 3166-1 alpha-3 country codes representing the countries where this portal is operationally active.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this eProcurement portal record was first created in the data platform.',
    `data_encryption_standard` STRING COMMENT 'Encryption standard applied to data in transit and at rest within the portal (e.g., AES-256, TLS 1.3).',
    `data_residency_region` STRING COMMENT 'Geographic region where portal data is stored and processed, relevant for data sovereignty and GDPR compliance (e.g., EU, US, APAC).',
    `decommission_date` DATE COMMENT 'Planned or actual date on which the portal was or will be decommissioned and taken out of service.',
    `default_currency_code` STRING COMMENT 'ISO 4217 three-letter currency code used as the default transaction currency for this portal instance.',
    `default_language_code` STRING COMMENT 'ISO 639-1 language code for the default user interface language of the portal.',
    `deployment_model` STRING COMMENT 'Infrastructure deployment model for the portal: cloud SaaS, on-premise, hybrid, or private cloud.',
    `erp_system_code` STRING COMMENT 'Identifier of the ERP system instance (e.g., SAP MM client/system ID) to which this portal is integrated for purchase order and goods receipt processing.',
    `gdpr_compliant_flag` BOOLEAN COMMENT 'Indicates whether the portal has been assessed and confirmed as compliant with GDPR requirements for personal data processing.',
    `geographic_scope` STRING COMMENT 'Operational geographic coverage of the portal: global enterprise-wide, regional (e.g., EMEA, APAC), country-specific, or plant-level.',
    `go_live_date` DATE COMMENT 'Date on which the eProcurement portal was first made available to end users in production.',
    `integration_standard` STRING COMMENT 'Electronic data interchange or integration protocol used to connect the portal with ERP and supplier systems (e.g., cXML for Ariba, EDI X12, EDIFACT, REST API).',
    `invoice_automation_flag` BOOLEAN COMMENT 'Indicates whether the portal supports automated invoice processing, including electronic invoice submission, three-way matching, and straight-through processing.',
    `maintenance_window` STRING COMMENT 'Scheduled maintenance window for the portal expressed as a recurring time pattern (e.g., Sunday 02:00-04:00 UTC), during which the portal may be unavailable.',
    `max_concurrent_users` STRING COMMENT 'Maximum number of simultaneous user sessions the portal is licensed and configured to support.',
    `max_po_value` DECIMAL(18,2) COMMENT 'Maximum monetary value of a single purchase order that can be processed through this portal, enforced as a procurement control threshold.',
    `mfa_required_flag` BOOLEAN COMMENT 'Indicates whether multi-factor authentication is mandatory for all users accessing this portal.',
    `owning_company_code` STRING COMMENT 'SAP company code or legal entity identifier of the automotive business unit that owns and operates this eProcurement portal instance.',
    `platform_provider` STRING COMMENT 'Name of the third-party software vendor or platform provider hosting the eProcurement portal (e.g., SAP Ariba, Coupa, Jaggaer, Oracle Procurement Cloud, Ivalua).',
    `platform_version` STRING COMMENT 'Version or release number of the eProcurement platform software currently deployed for this portal instance.',
    `po_approval_threshold` DECIMAL(18,2) COMMENT 'Monetary threshold above which purchase orders require additional approval workflow steps within the portal.',
    `portal_code` STRING COMMENT 'Unique alphanumeric business identifier for the eProcurement portal, used in cross-system references and integration mappings (e.g., SAP Ariba, Coupa, Jaggaer).',
    `portal_name` STRING COMMENT 'Human-readable name of the eProcurement portal instance (e.g., Global Direct Materials Portal, EMEA Indirect Procurement Hub).',
    `portal_owner_email` STRING COMMENT 'Email address of the internal business owner responsible for this portal. Classified as PII per GDPR.',
    `portal_owner_name` STRING COMMENT 'Name of the internal business owner or procurement manager responsible for the governance and operation of this portal.',
    `portal_status` STRING COMMENT 'Current operational lifecycle status of the eProcurement portal instance.',
    `portal_type` STRING COMMENT 'Classification of the portal by procurement category scope: direct materials (production parts), indirect materials (MRO, office), CapEx, services, or marketplace. [ENUM-REF-CANDIDATE: direct_materials|indirect_materials|capex|services|mro|marketplace — promote to reference product]',
    `portal_url` STRING COMMENT 'Primary web address (URL) through which suppliers and internal users access the eProcurement portal.',
    `punchout_enabled_flag` BOOLEAN COMMENT 'Indicates whether the portal supports cXML PunchOut integration, allowing buyers to access supplier web catalogs directly from within the procurement portal.',
    `purchasing_org_code` STRING COMMENT 'SAP purchasing organization code responsible for procurement activities conducted through this portal, defining the legal and contractual framework for purchasing.',
    `registered_supplier_count` STRING COMMENT 'Total number of supplier organizations currently registered and active on this eProcurement portal.',
    `rfx_enabled_flag` BOOLEAN COMMENT 'Indicates whether the portal supports RFI (Request for Information), RFP (Request for Proposal), and RFQ (Request for Quotation) sourcing events.',
    `spend_category_scope` STRING COMMENT 'Indicates whether the portal handles direct spend (production materials), indirect spend (MRO, services), or both categories.',
    `sso_enabled_flag` BOOLEAN COMMENT 'Indicates whether the portal supports Single Sign-On (SSO) authentication integration with the enterprise identity provider (e.g., Azure AD, Okta).',
    `supplier_onboarding_flag` BOOLEAN COMMENT 'Indicates whether the portal includes supplier registration, qualification, and onboarding workflow capabilities.',
    `supplier_portal_access_model` STRING COMMENT 'Access control model governing how suppliers can register and gain access to the portal: open self-registration, invitation-only, or pre-approved supplier list.',
    `supported_currencies` STRING COMMENT 'Comma-separated list of ISO 4217 three-letter currency codes supported by the portal for transaction processing (e.g., EUR,USD,GBP,CNY,JPY).',
    `supported_languages` STRING COMMENT 'Comma-separated list of ISO 639-1 language codes supported by the portal user interface (e.g., en,de,fr,zh,ja,ko).',
    `technical_contact_email` STRING COMMENT 'Email address of the IT or technical administrator responsible for portal integration and system maintenance. Classified as PII per GDPR.',
    `three_way_match_flag` BOOLEAN COMMENT 'Indicates whether the portal enforces three-way matching (purchase order, goods receipt, and invoice) before approving invoice payment.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this eProcurement portal record was last modified in the data platform.',
    `uptime_sla_percent` DECIMAL(18,2) COMMENT 'Contractually agreed minimum uptime percentage for the portal (e.g., 99.9 for 99.9% availability), as defined in the platform provider SLA.',
    CONSTRAINT pk_eprocurement_portal PRIMARY KEY(`eprocurement_portal_id`)
) COMMENT 'Master reference table for eprocurement_portal. Referenced by eprocurement_portal_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_supplier` ADD CONSTRAINT `fk_procurement_procurement_supplier_parent_supplier_procurement_supplier_id` FOREIGN KEY (`parent_supplier_procurement_supplier_id`) REFERENCES `vibe_automotive_v1`.`procurement`.`procurement_supplier`(`procurement_supplier_id`);
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_supplier_plant` ADD CONSTRAINT `fk_procurement_procurement_supplier_plant_procurement_supplier_id` FOREIGN KEY (`procurement_supplier_id`) REFERENCES `vibe_automotive_v1`.`procurement`.`procurement_supplier`(`procurement_supplier_id`);
ALTER TABLE `vibe_automotive_v1`.`procurement`.`sourcing_event` ADD CONSTRAINT `fk_procurement_sourcing_event_eprocurement_portal_id` FOREIGN KEY (`eprocurement_portal_id`) REFERENCES `vibe_automotive_v1`.`procurement`.`eprocurement_portal`(`eprocurement_portal_id`);
ALTER TABLE `vibe_automotive_v1`.`procurement`.`sourcing_event` ADD CONSTRAINT `fk_procurement_sourcing_event_procurement_supplier_id` FOREIGN KEY (`procurement_supplier_id`) REFERENCES `vibe_automotive_v1`.`procurement`.`procurement_supplier`(`procurement_supplier_id`);
ALTER TABLE `vibe_automotive_v1`.`procurement`.`sourcing_event` ADD CONSTRAINT `fk_procurement_sourcing_event_spend_category_id` FOREIGN KEY (`spend_category_id`) REFERENCES `vibe_automotive_v1`.`procurement`.`spend_category`(`spend_category_id`);
ALTER TABLE `vibe_automotive_v1`.`procurement`.`sourcing_event` ADD CONSTRAINT `fk_procurement_sourcing_event_supplier_contract_id` FOREIGN KEY (`supplier_contract_id`) REFERENCES `vibe_automotive_v1`.`procurement`.`supplier_contract`(`supplier_contract_id`);
ALTER TABLE `vibe_automotive_v1`.`procurement`.`supplier_quote` ADD CONSTRAINT `fk_procurement_supplier_quote_eprocurement_portal_id` FOREIGN KEY (`eprocurement_portal_id`) REFERENCES `vibe_automotive_v1`.`procurement`.`eprocurement_portal`(`eprocurement_portal_id`);
ALTER TABLE `vibe_automotive_v1`.`procurement`.`supplier_quote` ADD CONSTRAINT `fk_procurement_supplier_quote_procurement_supplier_id` FOREIGN KEY (`procurement_supplier_id`) REFERENCES `vibe_automotive_v1`.`procurement`.`procurement_supplier`(`procurement_supplier_id`);
ALTER TABLE `vibe_automotive_v1`.`procurement`.`supplier_quote` ADD CONSTRAINT `fk_procurement_supplier_quote_sourcing_event_id` FOREIGN KEY (`sourcing_event_id`) REFERENCES `vibe_automotive_v1`.`procurement`.`sourcing_event`(`sourcing_event_id`);
ALTER TABLE `vibe_automotive_v1`.`procurement`.`purchase_requisition` ADD CONSTRAINT `fk_procurement_purchase_requisition_eprocurement_portal_id` FOREIGN KEY (`eprocurement_portal_id`) REFERENCES `vibe_automotive_v1`.`procurement`.`eprocurement_portal`(`eprocurement_portal_id`);
ALTER TABLE `vibe_automotive_v1`.`procurement`.`purchase_requisition` ADD CONSTRAINT `fk_procurement_purchase_requisition_procurement_supplier_id` FOREIGN KEY (`procurement_supplier_id`) REFERENCES `vibe_automotive_v1`.`procurement`.`procurement_supplier`(`procurement_supplier_id`);
ALTER TABLE `vibe_automotive_v1`.`procurement`.`purchase_requisition` ADD CONSTRAINT `fk_procurement_purchase_requisition_spend_category_id` FOREIGN KEY (`spend_category_id`) REFERENCES `vibe_automotive_v1`.`procurement`.`spend_category`(`spend_category_id`);
ALTER TABLE `vibe_automotive_v1`.`procurement`.`purchase_requisition` ADD CONSTRAINT `fk_procurement_purchase_requisition_supplier_contract_id` FOREIGN KEY (`supplier_contract_id`) REFERENCES `vibe_automotive_v1`.`procurement`.`supplier_contract`(`supplier_contract_id`);
ALTER TABLE `vibe_automotive_v1`.`procurement`.`purchase_requisition` ADD CONSTRAINT `fk_procurement_purchase_requisition_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_automotive_v1`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_purchase_order` ADD CONSTRAINT `fk_procurement_procurement_purchase_order_eprocurement_portal_id` FOREIGN KEY (`eprocurement_portal_id`) REFERENCES `vibe_automotive_v1`.`procurement`.`eprocurement_portal`(`eprocurement_portal_id`);
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_purchase_order` ADD CONSTRAINT `fk_procurement_procurement_purchase_order_procurement_supplier_id` FOREIGN KEY (`procurement_supplier_id`) REFERENCES `vibe_automotive_v1`.`procurement`.`procurement_supplier`(`procurement_supplier_id`);
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_purchase_order` ADD CONSTRAINT `fk_procurement_procurement_purchase_order_supplier_contract_id` FOREIGN KEY (`supplier_contract_id`) REFERENCES `vibe_automotive_v1`.`procurement`.`supplier_contract`(`supplier_contract_id`);
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_po_line` ADD CONSTRAINT `fk_procurement_procurement_po_line_procurement_purchase_order_id` FOREIGN KEY (`procurement_purchase_order_id`) REFERENCES `vibe_automotive_v1`.`procurement`.`procurement_purchase_order`(`procurement_purchase_order_id`);
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_po_line` ADD CONSTRAINT `fk_procurement_procurement_po_line_procurement_supplier_id` FOREIGN KEY (`procurement_supplier_id`) REFERENCES `vibe_automotive_v1`.`procurement`.`procurement_supplier`(`procurement_supplier_id`);
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_po_line` ADD CONSTRAINT `fk_procurement_procurement_po_line_spend_category_id` FOREIGN KEY (`spend_category_id`) REFERENCES `vibe_automotive_v1`.`procurement`.`spend_category`(`spend_category_id`);
ALTER TABLE `vibe_automotive_v1`.`procurement`.`supplier_contract` ADD CONSTRAINT `fk_procurement_supplier_contract_eprocurement_portal_id` FOREIGN KEY (`eprocurement_portal_id`) REFERENCES `vibe_automotive_v1`.`procurement`.`eprocurement_portal`(`eprocurement_portal_id`);
ALTER TABLE `vibe_automotive_v1`.`procurement`.`supplier_contract` ADD CONSTRAINT `fk_procurement_supplier_contract_procurement_supplier_id` FOREIGN KEY (`procurement_supplier_id`) REFERENCES `vibe_automotive_v1`.`procurement`.`procurement_supplier`(`procurement_supplier_id`);
ALTER TABLE `vibe_automotive_v1`.`procurement`.`scheduling_agreement_line` ADD CONSTRAINT `fk_procurement_scheduling_agreement_line_procurement_purchase_order_id` FOREIGN KEY (`procurement_purchase_order_id`) REFERENCES `vibe_automotive_v1`.`procurement`.`procurement_purchase_order`(`procurement_purchase_order_id`);
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_goods_receipt` ADD CONSTRAINT `fk_procurement_procurement_goods_receipt_procurement_po_line_id` FOREIGN KEY (`procurement_po_line_id`) REFERENCES `vibe_automotive_v1`.`procurement`.`procurement_po_line`(`procurement_po_line_id`);
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_goods_receipt` ADD CONSTRAINT `fk_procurement_procurement_goods_receipt_procurement_purchase_order_id` FOREIGN KEY (`procurement_purchase_order_id`) REFERENCES `vibe_automotive_v1`.`procurement`.`procurement_purchase_order`(`procurement_purchase_order_id`);
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_goods_receipt` ADD CONSTRAINT `fk_procurement_procurement_goods_receipt_procurement_supplier_id` FOREIGN KEY (`procurement_supplier_id`) REFERENCES `vibe_automotive_v1`.`procurement`.`procurement_supplier`(`procurement_supplier_id`);
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_goods_receipt` ADD CONSTRAINT `fk_procurement_procurement_goods_receipt_scheduling_agreement_line_id` FOREIGN KEY (`scheduling_agreement_line_id`) REFERENCES `vibe_automotive_v1`.`procurement`.`scheduling_agreement_line`(`scheduling_agreement_line_id`);
ALTER TABLE `vibe_automotive_v1`.`procurement`.`supplier_invoice` ADD CONSTRAINT `fk_procurement_supplier_invoice_payment_run_id` FOREIGN KEY (`payment_run_id`) REFERENCES `vibe_automotive_v1`.`procurement`.`payment_run`(`payment_run_id`);
ALTER TABLE `vibe_automotive_v1`.`procurement`.`supplier_invoice` ADD CONSTRAINT `fk_procurement_supplier_invoice_procurement_goods_receipt_id` FOREIGN KEY (`procurement_goods_receipt_id`) REFERENCES `vibe_automotive_v1`.`procurement`.`procurement_goods_receipt`(`procurement_goods_receipt_id`);
ALTER TABLE `vibe_automotive_v1`.`procurement`.`supplier_invoice` ADD CONSTRAINT `fk_procurement_supplier_invoice_procurement_purchase_order_id` FOREIGN KEY (`procurement_purchase_order_id`) REFERENCES `vibe_automotive_v1`.`procurement`.`procurement_purchase_order`(`procurement_purchase_order_id`);
ALTER TABLE `vibe_automotive_v1`.`procurement`.`supplier_invoice` ADD CONSTRAINT `fk_procurement_supplier_invoice_procurement_supplier_id` FOREIGN KEY (`procurement_supplier_id`) REFERENCES `vibe_automotive_v1`.`procurement`.`procurement_supplier`(`procurement_supplier_id`);
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_invoice_line` ADD CONSTRAINT `fk_procurement_procurement_invoice_line_procurement_goods_receipt_id` FOREIGN KEY (`procurement_goods_receipt_id`) REFERENCES `vibe_automotive_v1`.`procurement`.`procurement_goods_receipt`(`procurement_goods_receipt_id`);
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_invoice_line` ADD CONSTRAINT `fk_procurement_procurement_invoice_line_procurement_po_line_id` FOREIGN KEY (`procurement_po_line_id`) REFERENCES `vibe_automotive_v1`.`procurement`.`procurement_po_line`(`procurement_po_line_id`);
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_invoice_line` ADD CONSTRAINT `fk_procurement_procurement_invoice_line_supplier_invoice_id` FOREIGN KEY (`supplier_invoice_id`) REFERENCES `vibe_automotive_v1`.`procurement`.`supplier_invoice`(`supplier_invoice_id`);
ALTER TABLE `vibe_automotive_v1`.`procurement`.`spend_category` ADD CONSTRAINT `fk_procurement_spend_category_parent_category_spend_category_id` FOREIGN KEY (`parent_category_spend_category_id`) REFERENCES `vibe_automotive_v1`.`procurement`.`spend_category`(`spend_category_id`);
ALTER TABLE `vibe_automotive_v1`.`procurement`.`approved_vendor_list` ADD CONSTRAINT `fk_procurement_approved_vendor_list_info_record_id` FOREIGN KEY (`info_record_id`) REFERENCES `vibe_automotive_v1`.`procurement`.`info_record`(`info_record_id`);
ALTER TABLE `vibe_automotive_v1`.`procurement`.`approved_vendor_list` ADD CONSTRAINT `fk_procurement_approved_vendor_list_procurement_supplier_id` FOREIGN KEY (`procurement_supplier_id`) REFERENCES `vibe_automotive_v1`.`procurement`.`procurement_supplier`(`procurement_supplier_id`);
ALTER TABLE `vibe_automotive_v1`.`procurement`.`approved_vendor_list` ADD CONSTRAINT `fk_procurement_approved_vendor_list_supplier_contract_id` FOREIGN KEY (`supplier_contract_id`) REFERENCES `vibe_automotive_v1`.`procurement`.`supplier_contract`(`supplier_contract_id`);
ALTER TABLE `vibe_automotive_v1`.`procurement`.`info_record` ADD CONSTRAINT `fk_procurement_info_record_procurement_supplier_id` FOREIGN KEY (`procurement_supplier_id`) REFERENCES `vibe_automotive_v1`.`procurement`.`procurement_supplier`(`procurement_supplier_id`);
ALTER TABLE `vibe_automotive_v1`.`procurement`.`supplier_evaluation` ADD CONSTRAINT `fk_procurement_supplier_evaluation_procurement_supplier_id` FOREIGN KEY (`procurement_supplier_id`) REFERENCES `vibe_automotive_v1`.`procurement`.`procurement_supplier`(`procurement_supplier_id`);
ALTER TABLE `vibe_automotive_v1`.`procurement`.`supplier_development_plan` ADD CONSTRAINT `fk_procurement_supplier_development_plan_procurement_supplier_id` FOREIGN KEY (`procurement_supplier_id`) REFERENCES `vibe_automotive_v1`.`procurement`.`procurement_supplier`(`procurement_supplier_id`);
ALTER TABLE `vibe_automotive_v1`.`procurement`.`supplier_development_plan` ADD CONSTRAINT `fk_procurement_supplier_development_plan_supplier_contract_id` FOREIGN KEY (`supplier_contract_id`) REFERENCES `vibe_automotive_v1`.`procurement`.`supplier_contract`(`supplier_contract_id`);
ALTER TABLE `vibe_automotive_v1`.`procurement`.`supplier_development_plan` ADD CONSTRAINT `fk_procurement_supplier_development_plan_supplier_evaluation_id` FOREIGN KEY (`supplier_evaluation_id`) REFERENCES `vibe_automotive_v1`.`procurement`.`supplier_evaluation`(`supplier_evaluation_id`);
ALTER TABLE `vibe_automotive_v1`.`procurement`.`capex_requisition` ADD CONSTRAINT `fk_procurement_capex_requisition_procurement_supplier_id` FOREIGN KEY (`procurement_supplier_id`) REFERENCES `vibe_automotive_v1`.`procurement`.`procurement_supplier`(`procurement_supplier_id`);
ALTER TABLE `vibe_automotive_v1`.`procurement`.`capex_requisition` ADD CONSTRAINT `fk_procurement_capex_requisition_supplier_quote_id` FOREIGN KEY (`supplier_quote_id`) REFERENCES `vibe_automotive_v1`.`procurement`.`supplier_quote`(`supplier_quote_id`);
ALTER TABLE `vibe_automotive_v1`.`procurement`.`capex_requisition` ADD CONSTRAINT `fk_procurement_capex_requisition_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `vibe_automotive_v1`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_automotive_v1`.`procurement`.`tooling_order` ADD CONSTRAINT `fk_procurement_tooling_order_capex_requisition_id` FOREIGN KEY (`capex_requisition_id`) REFERENCES `vibe_automotive_v1`.`procurement`.`capex_requisition`(`capex_requisition_id`);
ALTER TABLE `vibe_automotive_v1`.`procurement`.`tooling_order` ADD CONSTRAINT `fk_procurement_tooling_order_procurement_purchase_order_id` FOREIGN KEY (`procurement_purchase_order_id`) REFERENCES `vibe_automotive_v1`.`procurement`.`procurement_purchase_order`(`procurement_purchase_order_id`);
ALTER TABLE `vibe_automotive_v1`.`procurement`.`tooling_order` ADD CONSTRAINT `fk_procurement_tooling_order_procurement_supplier_id` FOREIGN KEY (`procurement_supplier_id`) REFERENCES `vibe_automotive_v1`.`procurement`.`procurement_supplier`(`procurement_supplier_id`);
ALTER TABLE `vibe_automotive_v1`.`procurement`.`tooling_order` ADD CONSTRAINT `fk_procurement_tooling_order_supplier_contract_id` FOREIGN KEY (`supplier_contract_id`) REFERENCES `vibe_automotive_v1`.`procurement`.`supplier_contract`(`supplier_contract_id`);
ALTER TABLE `vibe_automotive_v1`.`procurement`.`service_entry_sheet` ADD CONSTRAINT `fk_procurement_service_entry_sheet_procurement_po_line_id` FOREIGN KEY (`procurement_po_line_id`) REFERENCES `vibe_automotive_v1`.`procurement`.`procurement_po_line`(`procurement_po_line_id`);
ALTER TABLE `vibe_automotive_v1`.`procurement`.`service_entry_sheet` ADD CONSTRAINT `fk_procurement_service_entry_sheet_procurement_purchase_order_id` FOREIGN KEY (`procurement_purchase_order_id`) REFERENCES `vibe_automotive_v1`.`procurement`.`procurement_purchase_order`(`procurement_purchase_order_id`);
ALTER TABLE `vibe_automotive_v1`.`procurement`.`service_entry_sheet` ADD CONSTRAINT `fk_procurement_service_entry_sheet_procurement_supplier_id` FOREIGN KEY (`procurement_supplier_id`) REFERENCES `vibe_automotive_v1`.`procurement`.`procurement_supplier`(`procurement_supplier_id`);
ALTER TABLE `vibe_automotive_v1`.`procurement`.`service_entry_sheet` ADD CONSTRAINT `fk_procurement_service_entry_sheet_supplier_contract_id` FOREIGN KEY (`supplier_contract_id`) REFERENCES `vibe_automotive_v1`.`procurement`.`supplier_contract`(`supplier_contract_id`);
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_price_condition` ADD CONSTRAINT `fk_procurement_procurement_price_condition_info_record_id` FOREIGN KEY (`info_record_id`) REFERENCES `vibe_automotive_v1`.`procurement`.`info_record`(`info_record_id`);
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_price_condition` ADD CONSTRAINT `fk_procurement_procurement_price_condition_procurement_supplier_id` FOREIGN KEY (`procurement_supplier_id`) REFERENCES `vibe_automotive_v1`.`procurement`.`procurement_supplier`(`procurement_supplier_id`);
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_price_condition` ADD CONSTRAINT `fk_procurement_procurement_price_condition_supplier_contract_id` FOREIGN KEY (`supplier_contract_id`) REFERENCES `vibe_automotive_v1`.`procurement`.`supplier_contract`(`supplier_contract_id`);
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_delivery_schedule` ADD CONSTRAINT `fk_procurement_procurement_delivery_schedule_procurement_goods_receipt_id` FOREIGN KEY (`procurement_goods_receipt_id`) REFERENCES `vibe_automotive_v1`.`procurement`.`procurement_goods_receipt`(`procurement_goods_receipt_id`);
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_delivery_schedule` ADD CONSTRAINT `fk_procurement_procurement_delivery_schedule_procurement_po_line_id` FOREIGN KEY (`procurement_po_line_id`) REFERENCES `vibe_automotive_v1`.`procurement`.`procurement_po_line`(`procurement_po_line_id`);
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_delivery_schedule` ADD CONSTRAINT `fk_procurement_procurement_delivery_schedule_procurement_purchase_order_id` FOREIGN KEY (`procurement_purchase_order_id`) REFERENCES `vibe_automotive_v1`.`procurement`.`procurement_purchase_order`(`procurement_purchase_order_id`);
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_delivery_schedule` ADD CONSTRAINT `fk_procurement_procurement_delivery_schedule_scheduling_agreement_line_id` FOREIGN KEY (`scheduling_agreement_line_id`) REFERENCES `vibe_automotive_v1`.`procurement`.`scheduling_agreement_line`(`scheduling_agreement_line_id`);
ALTER TABLE `vibe_automotive_v1`.`procurement`.`supplier_nonconformance` ADD CONSTRAINT `fk_procurement_supplier_nonconformance_procurement_goods_receipt_id` FOREIGN KEY (`procurement_goods_receipt_id`) REFERENCES `vibe_automotive_v1`.`procurement`.`procurement_goods_receipt`(`procurement_goods_receipt_id`);
ALTER TABLE `vibe_automotive_v1`.`procurement`.`supplier_nonconformance` ADD CONSTRAINT `fk_procurement_supplier_nonconformance_procurement_po_line_id` FOREIGN KEY (`procurement_po_line_id`) REFERENCES `vibe_automotive_v1`.`procurement`.`procurement_po_line`(`procurement_po_line_id`);
ALTER TABLE `vibe_automotive_v1`.`procurement`.`supplier_nonconformance` ADD CONSTRAINT `fk_procurement_supplier_nonconformance_procurement_supplier_id` FOREIGN KEY (`procurement_supplier_id`) REFERENCES `vibe_automotive_v1`.`procurement`.`procurement_supplier`(`procurement_supplier_id`);
ALTER TABLE `vibe_automotive_v1`.`procurement`.`spend_transaction` ADD CONSTRAINT `fk_procurement_spend_transaction_procurement_purchase_order_id` FOREIGN KEY (`procurement_purchase_order_id`) REFERENCES `vibe_automotive_v1`.`procurement`.`procurement_purchase_order`(`procurement_purchase_order_id`);
ALTER TABLE `vibe_automotive_v1`.`procurement`.`spend_transaction` ADD CONSTRAINT `fk_procurement_spend_transaction_procurement_supplier_id` FOREIGN KEY (`procurement_supplier_id`) REFERENCES `vibe_automotive_v1`.`procurement`.`procurement_supplier`(`procurement_supplier_id`);
ALTER TABLE `vibe_automotive_v1`.`procurement`.`spend_transaction` ADD CONSTRAINT `fk_procurement_spend_transaction_purchase_requisition_id` FOREIGN KEY (`purchase_requisition_id`) REFERENCES `vibe_automotive_v1`.`procurement`.`purchase_requisition`(`purchase_requisition_id`);
ALTER TABLE `vibe_automotive_v1`.`procurement`.`spend_transaction` ADD CONSTRAINT `fk_procurement_spend_transaction_spend_category_id` FOREIGN KEY (`spend_category_id`) REFERENCES `vibe_automotive_v1`.`procurement`.`spend_category`(`spend_category_id`);
ALTER TABLE `vibe_automotive_v1`.`procurement`.`spend_transaction` ADD CONSTRAINT `fk_procurement_spend_transaction_supplier_contract_id` FOREIGN KEY (`supplier_contract_id`) REFERENCES `vibe_automotive_v1`.`procurement`.`supplier_contract`(`supplier_contract_id`);
ALTER TABLE `vibe_automotive_v1`.`procurement`.`spend_transaction` ADD CONSTRAINT `fk_procurement_spend_transaction_supplier_invoice_id` FOREIGN KEY (`supplier_invoice_id`) REFERENCES `vibe_automotive_v1`.`procurement`.`supplier_invoice`(`supplier_invoice_id`);
ALTER TABLE `vibe_automotive_v1`.`procurement`.`savings_initiative` ADD CONSTRAINT `fk_procurement_savings_initiative_procurement_supplier_id` FOREIGN KEY (`procurement_supplier_id`) REFERENCES `vibe_automotive_v1`.`procurement`.`procurement_supplier`(`procurement_supplier_id`);
ALTER TABLE `vibe_automotive_v1`.`procurement`.`savings_initiative` ADD CONSTRAINT `fk_procurement_savings_initiative_sourcing_event_id` FOREIGN KEY (`sourcing_event_id`) REFERENCES `vibe_automotive_v1`.`procurement`.`sourcing_event`(`sourcing_event_id`);
ALTER TABLE `vibe_automotive_v1`.`procurement`.`savings_initiative` ADD CONSTRAINT `fk_procurement_savings_initiative_spend_category_id` FOREIGN KEY (`spend_category_id`) REFERENCES `vibe_automotive_v1`.`procurement`.`spend_category`(`spend_category_id`);
ALTER TABLE `vibe_automotive_v1`.`procurement`.`savings_initiative` ADD CONSTRAINT `fk_procurement_savings_initiative_supplier_contract_id` FOREIGN KEY (`supplier_contract_id`) REFERENCES `vibe_automotive_v1`.`procurement`.`supplier_contract`(`supplier_contract_id`);
ALTER TABLE `vibe_automotive_v1`.`procurement`.`payment_run` ADD CONSTRAINT `fk_procurement_payment_run_procurement_supplier_id` FOREIGN KEY (`procurement_supplier_id`) REFERENCES `vibe_automotive_v1`.`procurement`.`procurement_supplier`(`procurement_supplier_id`);
ALTER TABLE `vibe_automotive_v1`.`procurement`.`approval` ADD CONSTRAINT `fk_procurement_approval_approval_group_id` FOREIGN KEY (`approval_group_id`) REFERENCES `vibe_automotive_v1`.`procurement`.`approval_group`(`approval_group_id`);
ALTER TABLE `vibe_automotive_v1`.`procurement`.`approval` ADD CONSTRAINT `fk_procurement_approval_auto_approval_rule_id` FOREIGN KEY (`auto_approval_rule_id`) REFERENCES `vibe_automotive_v1`.`procurement`.`auto_approval_rule`(`auto_approval_rule_id`);
ALTER TABLE `vibe_automotive_v1`.`procurement`.`approval` ADD CONSTRAINT `fk_procurement_approval_procurement_document_id` FOREIGN KEY (`procurement_document_id`) REFERENCES `vibe_automotive_v1`.`procurement`.`procurement_document`(`procurement_document_id`);
ALTER TABLE `vibe_automotive_v1`.`procurement`.`vendor` ADD CONSTRAINT `fk_procurement_vendor_parent_vendor_id` FOREIGN KEY (`parent_vendor_id`) REFERENCES `vibe_automotive_v1`.`procurement`.`vendor`(`vendor_id`);
ALTER TABLE `vibe_automotive_v1`.`procurement`.`program_supplier_contract` ADD CONSTRAINT `fk_procurement_program_supplier_contract_procurement_supplier_id` FOREIGN KEY (`procurement_supplier_id`) REFERENCES `vibe_automotive_v1`.`procurement`.`procurement_supplier`(`procurement_supplier_id`);
ALTER TABLE `vibe_automotive_v1`.`procurement`.`program_supplier_contract` ADD CONSTRAINT `fk_procurement_program_supplier_contract_sourcing_event_id` FOREIGN KEY (`sourcing_event_id`) REFERENCES `vibe_automotive_v1`.`procurement`.`sourcing_event`(`sourcing_event_id`);
ALTER TABLE `vibe_automotive_v1`.`procurement`.`program_supplier_contract` ADD CONSTRAINT `fk_procurement_program_supplier_contract_supplier_contract_id` FOREIGN KEY (`supplier_contract_id`) REFERENCES `vibe_automotive_v1`.`procurement`.`supplier_contract`(`supplier_contract_id`);
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_supply_agreement` ADD CONSTRAINT `fk_procurement_procurement_supply_agreement_procurement_supplier_id` FOREIGN KEY (`procurement_supplier_id`) REFERENCES `vibe_automotive_v1`.`procurement`.`procurement_supplier`(`procurement_supplier_id`);
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_supply_agreement` ADD CONSTRAINT `fk_procurement_procurement_supply_agreement_supplier_contract_id` FOREIGN KEY (`supplier_contract_id`) REFERENCES `vibe_automotive_v1`.`procurement`.`supplier_contract`(`supplier_contract_id`);
ALTER TABLE `vibe_automotive_v1`.`procurement`.`supplier_regulatory_compliance` ADD CONSTRAINT `fk_procurement_supplier_regulatory_compliance_procurement_supplier_id` FOREIGN KEY (`procurement_supplier_id`) REFERENCES `vibe_automotive_v1`.`procurement`.`procurement_supplier`(`procurement_supplier_id`);
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_document` ADD CONSTRAINT `fk_procurement_procurement_document_predecessor_procurement_document_id` FOREIGN KEY (`predecessor_procurement_document_id`) REFERENCES `vibe_automotive_v1`.`procurement`.`procurement_document`(`procurement_document_id`);
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_document` ADD CONSTRAINT `fk_procurement_procurement_document_procurement_supplier_id` FOREIGN KEY (`procurement_supplier_id`) REFERENCES `vibe_automotive_v1`.`procurement`.`procurement_supplier`(`procurement_supplier_id`);
ALTER TABLE `vibe_automotive_v1`.`procurement`.`approval_group` ADD CONSTRAINT `fk_procurement_approval_group_parent_approval_group_id` FOREIGN KEY (`parent_approval_group_id`) REFERENCES `vibe_automotive_v1`.`procurement`.`approval_group`(`approval_group_id`);
ALTER TABLE `vibe_automotive_v1`.`procurement`.`auto_approval_rule` ADD CONSTRAINT `fk_procurement_auto_approval_rule_superseded_auto_approval_rule_id` FOREIGN KEY (`superseded_auto_approval_rule_id`) REFERENCES `vibe_automotive_v1`.`procurement`.`auto_approval_rule`(`auto_approval_rule_id`);
ALTER TABLE `vibe_automotive_v1`.`procurement`.`eprocurement_portal` ADD CONSTRAINT `fk_procurement_eprocurement_portal_parent_eprocurement_portal_id` FOREIGN KEY (`parent_eprocurement_portal_id`) REFERENCES `vibe_automotive_v1`.`procurement`.`eprocurement_portal`(`eprocurement_portal_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_automotive_v1`.`procurement` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `vibe_automotive_v1`.`procurement` SET TAGS ('dbx_domain' = 'procurement');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_supplier` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_supplier` SET TAGS ('dbx_subdomain' = 'supplier_management');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_supplier` SET TAGS ('dbx_source_of_record' = 'SAP MM');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_supplier` SET TAGS ('dbx_SAP_SRM' = 'true');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_supplier` SET TAGS ('dbx_mvm_status' = 'include');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_supplier` SET TAGS ('dbx_mvm_scope' = 'basic_purchasing');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_supplier` SET TAGS ('dbx_source_system' = 'SAP MM');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_supplier` SET TAGS ('dbx_SAP_SRM' = 'true');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_supplier` SET TAGS ('dbx_eprocurement_integrated' = 'true');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_supplier` SET TAGS ('dbx_commodity_aware' = 'true');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_supplier` ALTER COLUMN `procurement_supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Identifier (SUPPLIER_ID)');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_supplier` ALTER COLUMN `parent_supplier_procurement_supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Supplier Identifier (PARENT_SUPPLIER_ID)');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_supplier` ALTER COLUMN `address_line1` SET TAGS ('dbx_business_glossary_term' = 'Supplier Address Line 1 (ADDRESS_LINE1)');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_supplier` ALTER COLUMN `address_line1` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_supplier` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_supplier` ALTER COLUMN `bank_account_number` SET TAGS ('dbx_business_glossary_term' = 'Bank Account Number (BANK_ACCOUNT_NUMBER)');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_supplier` ALTER COLUMN `bank_account_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_supplier` ALTER COLUMN `bank_account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_supplier` ALTER COLUMN `bank_name` SET TAGS ('dbx_business_glossary_term' = 'Bank Name (BANK_NAME)');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_supplier` ALTER COLUMN `certification_status` SET TAGS ('dbx_business_glossary_term' = 'Overall Certification Status (CERTIFICATION_STATUS)');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_supplier` ALTER COLUMN `certification_status` SET TAGS ('dbx_value_regex' = 'active|expired|pending');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_supplier` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'Supplier City (CITY)');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_supplier` ALTER COLUMN `commodity_specialization` SET TAGS ('dbx_business_glossary_term' = 'Commodity Specialization (COMMODITY_SPECIALIZATION)');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_supplier` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Supplier Country Code (COUNTRY_CODE)');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_supplier` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (CREATED_TIMESTAMP)');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_supplier` ALTER COLUMN `credit_limit` SET TAGS ('dbx_business_glossary_term' = 'Credit Limit (CREDIT_LIMIT)');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_supplier` ALTER COLUMN `credit_limit` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_supplier` ALTER COLUMN `credit_limit` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_supplier` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Transaction Currency Code (CURRENCY_CODE)');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_supplier` ALTER COLUMN `data_governance_ref` SET TAGS ('dbx_business_glossary_term' = 'Data Governance Reference');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_supplier` ALTER COLUMN `deactivation_date` SET TAGS ('dbx_business_glossary_term' = 'Supplier Deactivation Date (DEACTIVATION_DATE)');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_supplier` ALTER COLUMN `duns_number` SET TAGS ('dbx_business_glossary_term' = 'DUNS Number (DUNS_NUMBER)');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_supplier` ALTER COLUMN `duns_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_supplier` ALTER COLUMN `duns_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_supplier` ALTER COLUMN `iatf16949_cert_expiry` SET TAGS ('dbx_business_glossary_term' = 'IATF 16949 Certification Expiry Date (IATF16949_CERT_EXPIRY)');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_supplier` ALTER COLUMN `iatf16949_certified` SET TAGS ('dbx_business_glossary_term' = 'IATF 16949 Certification Flag (IATF16949_CERTIFIED)');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_supplier` ALTER COLUMN `incoterms` SET TAGS ('dbx_business_glossary_term' = 'Incoterms (INCOTERMS)');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_supplier` ALTER COLUMN `incoterms` SET TAGS ('dbx_value_regex' = 'EXW|FOB|CIF|DAP|DDP');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_supplier` ALTER COLUMN `iso14001_cert_expiry` SET TAGS ('dbx_business_glossary_term' = 'ISO 14001 Certification Expiry Date (ISO14001_CERT_EXPIRY)');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_supplier` ALTER COLUMN `iso14001_certified` SET TAGS ('dbx_business_glossary_term' = 'ISO 14001 Certification Flag (ISO14001_CERTIFIED)');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_supplier` ALTER COLUMN `iso9001_cert_expiry` SET TAGS ('dbx_business_glossary_term' = 'ISO 9001 Certification Expiry Date (ISO9001_CERT_EXPIRY)');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_supplier` ALTER COLUMN `iso9001_certified` SET TAGS ('dbx_business_glossary_term' = 'ISO 9001 Certification Flag (ISO9001_CERTIFIED)');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_supplier` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp (LAST_UPDATED_TIMESTAMP)');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_supplier` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Average Lead Time (LEAD_TIME_DAYS)');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_supplier` ALTER COLUMN `legal_name` SET TAGS ('dbx_business_glossary_term' = 'Legal Supplier Name (LEGAL_NAME)');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_supplier` ALTER COLUMN `max_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Maximum Order Quantity (MAX_ORDER_QUANTITY)');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_supplier` ALTER COLUMN `min_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity (MIN_ORDER_QUANTITY)');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_supplier` ALTER COLUMN `procurement_supplier_name` SET TAGS ('dbx_business_glossary_term' = 'Supplier Name (SUPPLIER_NAME)');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_supplier` ALTER COLUMN `onboarding_date` SET TAGS ('dbx_business_glossary_term' = 'Supplier Onboarding Date (ONBOARDING_DATE)');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_supplier` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms (PAYMENT_TERMS)');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_supplier` ALTER COLUMN `payment_terms` SET TAGS ('dbx_value_regex' = 'net30|net45|net60|cash|prepaid');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_supplier` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Supplier Postal Code (POSTAL_CODE)');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_supplier` ALTER COLUMN `postal_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_supplier` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_supplier` ALTER COLUMN `preferred_language` SET TAGS ('dbx_business_glossary_term' = 'Preferred Language (PREFERRED_LANGUAGE)');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_supplier` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Email Address (PRIMARY_CONTACT_EMAIL)');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_supplier` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_supplier` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_supplier` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_supplier` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Person Name (PRIMARY_CONTACT_NAME)');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_supplier` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_supplier` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_supplier` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Phone Number (PRIMARY_CONTACT_PHONE)');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_supplier` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_supplier` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_supplier` ALTER COLUMN `procurement_supplier_status` SET TAGS ('dbx_business_glossary_term' = 'Supplier Status (STATUS)');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_supplier` ALTER COLUMN `procurement_supplier_status` SET TAGS ('dbx_value_regex' = 'active|inactive|blocked|under_development');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_supplier` ALTER COLUMN `rating_score` SET TAGS ('dbx_business_glossary_term' = 'Supplier Rating Score (RATING_SCORE)');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_supplier` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Supplier Risk Score (RISK_SCORE)');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_supplier` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'Supplier State or Province (STATE_PROVINCE)');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_supplier` ALTER COLUMN `supplier_category` SET TAGS ('dbx_business_glossary_term' = 'Supplier Category (SUPPLIER_CATEGORY)');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_supplier` ALTER COLUMN `supplier_category` SET TAGS ('dbx_value_regex' = 'raw_materials|components|services|logistics|technology');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_supplier` ALTER COLUMN `supplier_type` SET TAGS ('dbx_business_glossary_term' = 'Supplier Type (SUPPLIER_TYPE)');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_supplier` ALTER COLUMN `supplier_type` SET TAGS ('dbx_value_regex' = 'tier-1|tier-2|tier-3|internal|service');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_supplier` ALTER COLUMN `sustainability_score` SET TAGS ('dbx_business_glossary_term' = 'Supplier Sustainability Score (SUSTAINABILITY_SCORE)');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_supplier` ALTER COLUMN `swift_code` SET TAGS ('dbx_business_glossary_term' = 'SWIFT/BIC Code (SWIFT_CODE)');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_supplier` ALTER COLUMN `swift_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_supplier` ALTER COLUMN `swift_code` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_supplier` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_business_glossary_term' = 'Tax Identification Number (TAX_ID)');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_supplier` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_supplier` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_supplier` ALTER COLUMN `vat_number` SET TAGS ('dbx_business_glossary_term' = 'VAT Registration Number (VAT_NUMBER)');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_supplier` ALTER COLUMN `vat_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_supplier` ALTER COLUMN `vat_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_supplier` ALTER COLUMN `website_url` SET TAGS ('dbx_business_glossary_term' = 'Supplier Website URL (WEBSITE_URL)');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_supplier_plant` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_supplier_plant` SET TAGS ('dbx_subdomain' = 'supplier_management');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_supplier_plant` SET TAGS ('dbx_source_of_record' = 'SAP MM');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_supplier_plant` SET TAGS ('dbx_SAP_SRM' = 'true');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_supplier_plant` SET TAGS ('dbx_source_system' = 'SAP MM');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_supplier_plant` SET TAGS ('dbx_SAP_SRM' = 'true');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_supplier_plant` SET TAGS ('dbx_eprocurement_integrated' = 'true');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_supplier_plant` SET TAGS ('dbx_commodity_aware' = 'true');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_supplier_plant` ALTER COLUMN `procurement_supplier_plant_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Plant Association ID (SUPPLIER_PLANT_ID)');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_supplier_plant` ALTER COLUMN `packaging_specification_id` SET TAGS ('dbx_business_glossary_term' = 'Packaging Specification ID (PKG_SPEC_ID)');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_supplier_plant` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant ID (PLANT_ID)');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_supplier_plant` ALTER COLUMN `procurement_supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID (SUPPLIER_ID)');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_supplier_plant` ALTER COLUMN `address_line1` SET TAGS ('dbx_business_glossary_term' = 'Delivery Address Line 1 (ADDR_LINE1)');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_supplier_plant` ALTER COLUMN `address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_supplier_plant` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_supplier_plant` ALTER COLUMN `address_line2` SET TAGS ('dbx_business_glossary_term' = 'Delivery Address Line 2 (ADDR_LINE2)');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_supplier_plant` ALTER COLUMN `address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_supplier_plant` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_supplier_plant` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date (APPROVAL_DATE)');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_supplier_plant` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Supplier Plant Approval Status (APPROVAL_STATUS)');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_supplier_plant` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'approved|pending|rejected|suspended');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_supplier_plant` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'Delivery City (CITY)');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_supplier_plant` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_supplier_plant` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_supplier_plant` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Delivery Country Code (COUNTRY_CODE)');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_supplier_plant` ALTER COLUMN `country_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_supplier_plant` ALTER COLUMN `country_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_supplier_plant` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp (CREATED_TS)');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_supplier_plant` ALTER COLUMN `data_governance_ref` SET TAGS ('dbx_business_glossary_term' = 'Data Governance Reference');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_supplier_plant` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date (EFFECTIVE_UNTIL)');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_supplier_plant` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date (EFFECTIVE_FROM)');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_supplier_plant` ALTER COLUMN `freight_terms` SET TAGS ('dbx_business_glossary_term' = 'Freight Terms (FREIGHT_TERMS)');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_supplier_plant` ALTER COLUMN `freight_terms` SET TAGS ('dbx_value_regex' = 'FOB|CIF|EXW|DDP');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_supplier_plant` ALTER COLUMN `is_preferred_supplier` SET TAGS ('dbx_business_glossary_term' = 'Preferred Supplier Flag (PREFERRED_FLAG)');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_supplier_plant` ALTER COLUMN `jis_delivery_flag` SET TAGS ('dbx_business_glossary_term' = 'JIS Delivery Flag (JIS_FLAG)');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_supplier_plant` ALTER COLUMN `jit_delivery_flag` SET TAGS ('dbx_business_glossary_term' = 'JIT Delivery Flag (JIT_FLAG)');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_supplier_plant` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp (LAST_UPDATED_TS)');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_supplier_plant` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time (DAYS)');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_supplier_plant` ALTER COLUMN `minimum_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity (MOQ)');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_supplier_plant` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes (NOTES)');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_supplier_plant` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Delivery Postal Code (POSTAL_CODE)');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_supplier_plant` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_supplier_plant` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_supplier_plant` ALTER COLUMN `procurement_supplier_plant_status` SET TAGS ('dbx_business_glossary_term' = 'Relationship Status (STATUS)');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_supplier_plant` ALTER COLUMN `procurement_supplier_plant_status` SET TAGS ('dbx_value_regex' = 'active|inactive|blocked');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_supplier_plant` ALTER COLUMN `quality_rating` SET TAGS ('dbx_business_glossary_term' = 'Quality Rating (QUALITY_RATING)');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_supplier_plant` ALTER COLUMN `shipping_method` SET TAGS ('dbx_business_glossary_term' = 'Shipping Method (SHIPPING_METHOD)');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_supplier_plant` ALTER COLUMN `shipping_method` SET TAGS ('dbx_value_regex' = 'truck|rail|ship|air');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_supplier_plant` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'Delivery State/Province (STATE_PROV)');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_supplier_plant` ALTER COLUMN `state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_supplier_plant` ALTER COLUMN `state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_supplier_plant` ALTER COLUMN `supplier_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Supplier Contact Email (CONTACT_EMAIL)');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_supplier_plant` ALTER COLUMN `supplier_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_supplier_plant` ALTER COLUMN `supplier_contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_supplier_plant` ALTER COLUMN `supplier_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_supplier_plant` ALTER COLUMN `supplier_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Supplier Contact Name (CONTACT_NAME)');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_supplier_plant` ALTER COLUMN `supplier_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_supplier_plant` ALTER COLUMN `supplier_contact_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_supplier_plant` ALTER COLUMN `supplier_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Supplier Contact Phone (CONTACT_PHONE)');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_supplier_plant` ALTER COLUMN `supplier_contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_supplier_plant` ALTER COLUMN `supplier_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_supplier_plant` ALTER COLUMN `unloading_point` SET TAGS ('dbx_business_glossary_term' = 'Unloading Point (UNLOADING_POINT)');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`sourcing_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`sourcing_event` SET TAGS ('dbx_subdomain' = 'sourcing_contracting');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`sourcing_event` SET TAGS ('dbx_source_of_record' = 'SAP MM');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`sourcing_event` SET TAGS ('dbx_SAP_SRM' = 'true');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`sourcing_event` SET TAGS ('dbx_source_system' = 'SAP MM');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`sourcing_event` SET TAGS ('dbx_SAP_SRM' = 'true');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`sourcing_event` SET TAGS ('dbx_eprocurement_integrated' = 'true');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`sourcing_event` SET TAGS ('dbx_commodity_aware' = 'true');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`sourcing_event` ALTER COLUMN `sourcing_event_id` SET TAGS ('dbx_business_glossary_term' = 'Sourcing Event ID');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`sourcing_event` ALTER COLUMN `eprocurement_portal_id` SET TAGS ('dbx_business_glossary_term' = 'E-Procurement Portal Reference');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`sourcing_event` ALTER COLUMN `procurement_supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Identifier (SUPPLIER_ID)');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`sourcing_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Buyer Identifier (BUYER_ID)');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`sourcing_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`sourcing_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`sourcing_event` ALTER COLUMN `sourcing_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Buyer Identifier (BUYER_ID)');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`sourcing_event` ALTER COLUMN `sourcing_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`sourcing_event` ALTER COLUMN `sourcing_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`sourcing_event` ALTER COLUMN `spend_category_id` SET TAGS ('dbx_business_glossary_term' = 'Spend Category Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`sourcing_event` ALTER COLUMN `supplier_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Identifier (CONTRACT_ID)');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`sourcing_event` ALTER COLUMN `vehicle_program_id` SET TAGS ('dbx_business_glossary_term' = 'Program Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`sourcing_event` ALTER COLUMN `award_amount` SET TAGS ('dbx_business_glossary_term' = 'Award Amount (AWARD_AMT)');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`sourcing_event` ALTER COLUMN `award_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Award Currency Code (ISO 4217)');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`sourcing_event` ALTER COLUMN `award_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`sourcing_event` ALTER COLUMN `award_decision_date` SET TAGS ('dbx_business_glossary_term' = 'Award Decision Date (AWARD_DATE)');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`sourcing_event` ALTER COLUMN `award_supplier_name` SET TAGS ('dbx_business_glossary_term' = 'Awarded Supplier Name (AWARD_SUPPLIER_NAME)');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`sourcing_event` ALTER COLUMN `buyer_department` SET TAGS ('dbx_business_glossary_term' = 'Buyer Department (DEPT)');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`sourcing_event` ALTER COLUMN `buyer_name` SET TAGS ('dbx_business_glossary_term' = 'Buyer Name (BUYER_NAME)');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`sourcing_event` ALTER COLUMN `commodity_group` SET TAGS ('dbx_business_glossary_term' = 'Commodity Group (COMMODITY_GRP)');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`sourcing_event` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Level (CONF_LEVEL)');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`sourcing_event` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_value_regex' = 'restricted|confidential|internal|public');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`sourcing_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (CREATED_TS)');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`sourcing_event` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`sourcing_event` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`sourcing_event` ALTER COLUMN `data_governance_ref` SET TAGS ('dbx_business_glossary_term' = 'Data Governance Reference');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`sourcing_event` ALTER COLUMN `sourcing_event_description` SET TAGS ('dbx_business_glossary_term' = 'Event Description (DESC)');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`sourcing_event` ALTER COLUMN `evaluation_method` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Method (EVAL_METHOD)');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`sourcing_event` ALTER COLUMN `evaluation_method` SET TAGS ('dbx_value_regex' = 'weighted|lowest_price|best_value');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`sourcing_event` ALTER COLUMN `evaluation_score` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Score (EVAL_SCORE)');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`sourcing_event` ALTER COLUMN `event_number` SET TAGS ('dbx_business_glossary_term' = 'Sourcing Event Number (EVT_NO)');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`sourcing_event` ALTER COLUMN `event_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Event Launch Timestamp (EVENT_TS)');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`sourcing_event` ALTER COLUMN `event_type` SET TAGS ('dbx_business_glossary_term' = 'Sourcing Event Type (RFQ/RFI/RFP)');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`sourcing_event` ALTER COLUMN `event_type` SET TAGS ('dbx_value_regex' = 'RFQ|RFI|RFP');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`sourcing_event` ALTER COLUMN `is_multi_source` SET TAGS ('dbx_business_glossary_term' = 'Multi-Source Flag (MULTI_SOURCE)');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`sourcing_event` ALTER COLUMN `is_nda_required` SET TAGS ('dbx_business_glossary_term' = 'NDA Required Flag (NDA_REQ)');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`sourcing_event` ALTER COLUMN `sor_reference` SET TAGS ('dbx_business_glossary_term' = 'Statement of Requirements Reference (SOR_REF)');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`sourcing_event` ALTER COLUMN `sor_version` SET TAGS ('dbx_business_glossary_term' = 'SOR Version (SOR_VER)');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`sourcing_event` ALTER COLUMN `sourcing_event_status` SET TAGS ('dbx_business_glossary_term' = 'Sourcing Event Status (STATUS)');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`sourcing_event` ALTER COLUMN `sourcing_event_status` SET TAGS ('dbx_value_regex' = 'draft|open|closed|cancelled|awarded');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`sourcing_event` ALTER COLUMN `sourcing_strategy` SET TAGS ('dbx_business_glossary_term' = 'Sourcing Strategy (STRATEGY)');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`sourcing_event` ALTER COLUMN `sourcing_strategy` SET TAGS ('dbx_value_regex' = 'single_source|dual_source|competitive_bid|direct_negotiation');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`sourcing_event` ALTER COLUMN `submission_deadline` SET TAGS ('dbx_business_glossary_term' = 'Submission Deadline (SUB_DEADLINE)');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`sourcing_event` ALTER COLUMN `target_spend_amount` SET TAGS ('dbx_business_glossary_term' = 'Target Spend Amount (TARGET_SPEND)');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`sourcing_event` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (UPDATED_TS)');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`supplier_quote` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`supplier_quote` SET TAGS ('dbx_subdomain' = 'sourcing_contracting');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`supplier_quote` SET TAGS ('dbx_source_of_record' = 'SAP MM');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`supplier_quote` SET TAGS ('dbx_SAP_SRM' = 'true');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`supplier_quote` SET TAGS ('dbx_source_system' = 'SAP MM');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`supplier_quote` SET TAGS ('dbx_SAP_SRM' = 'true');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`supplier_quote` SET TAGS ('dbx_eprocurement_integrated' = 'true');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`supplier_quote` SET TAGS ('dbx_commodity_aware' = 'true');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`supplier_quote` ALTER COLUMN `supplier_quote_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Quote ID');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`supplier_quote` ALTER COLUMN `compliance_document_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Document Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`supplier_quote` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By Employee Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`supplier_quote` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`supplier_quote` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`supplier_quote` ALTER COLUMN `eprocurement_portal_id` SET TAGS ('dbx_business_glossary_term' = 'E-Procurement Portal Reference');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`supplier_quote` ALTER COLUMN `procurement_supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`supplier_quote` ALTER COLUMN `sku_master_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Master Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`supplier_quote` ALTER COLUMN `sourcing_event_id` SET TAGS ('dbx_business_glossary_term' = 'Source Event ID');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`supplier_quote` ALTER COLUMN `vehicle_program_id` SET TAGS ('dbx_business_glossary_term' = 'Program Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`supplier_quote` ALTER COLUMN `amortization_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Amortization Rate Percent');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`supplier_quote` ALTER COLUMN `amortization_term_months` SET TAGS ('dbx_business_glossary_term' = 'Amortization Term (Months)');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`supplier_quote` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Supplier Comments');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`supplier_quote` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`supplier_quote` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`supplier_quote` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`supplier_quote` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`supplier_quote` ALTER COLUMN `e_sourcing_platform` SET TAGS ('dbx_business_glossary_term' = 'E-Sourcing Platform');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`supplier_quote` ALTER COLUMN `is_preferred` SET TAGS ('dbx_business_glossary_term' = 'Preferred Supplier Flag');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`supplier_quote` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time (Days)');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`supplier_quote` ALTER COLUMN `minimum_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`supplier_quote` ALTER COLUMN `net_price` SET TAGS ('dbx_business_glossary_term' = 'Net Price');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`supplier_quote` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`supplier_quote` ALTER COLUMN `payment_terms` SET TAGS ('dbx_value_regex' = 'net_30|net_60|net_90|prepaid|cash_on_delivery|letter_of_credit');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`supplier_quote` ALTER COLUMN `ppap_commitment_date` SET TAGS ('dbx_business_glossary_term' = 'PPAP Commitment Date');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`supplier_quote` ALTER COLUMN `quote_number` SET TAGS ('dbx_business_glossary_term' = 'Quote Number');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`supplier_quote` ALTER COLUMN `quote_status` SET TAGS ('dbx_business_glossary_term' = 'Quote Status');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`supplier_quote` ALTER COLUMN `quote_status` SET TAGS ('dbx_value_regex' = 'submitted|under_review|awarded|rejected');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`supplier_quote` ALTER COLUMN `quote_type` SET TAGS ('dbx_business_glossary_term' = 'Quote Type');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`supplier_quote` ALTER COLUMN `quote_type` SET TAGS ('dbx_value_regex' = 'rfq|rfp|rfi|rfq_response');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`supplier_quote` ALTER COLUMN `quoted_price` SET TAGS ('dbx_business_glossary_term' = 'Quoted Unit Price');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`supplier_quote` ALTER COLUMN `submission_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Quote Submission Timestamp');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`supplier_quote` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`supplier_quote` ALTER COLUMN `tooling_cost` SET TAGS ('dbx_business_glossary_term' = 'Tooling Cost');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`supplier_quote` ALTER COLUMN `total_price` SET TAGS ('dbx_business_glossary_term' = 'Total Price');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`supplier_quote` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`supplier_quote` ALTER COLUMN `validity_end_date` SET TAGS ('dbx_business_glossary_term' = 'Quote Validity End Date');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`supplier_quote` ALTER COLUMN `validity_start_date` SET TAGS ('dbx_business_glossary_term' = 'Quote Validity Start Date');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`purchase_requisition` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`purchase_requisition` SET TAGS ('dbx_subdomain' = 'order_execution');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`purchase_requisition` SET TAGS ('dbx_source_of_record' = 'SAP MM');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`purchase_requisition` SET TAGS ('dbx_SAP_SRM' = 'true');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`purchase_requisition` SET TAGS ('dbx_mvm_status' = 'include');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`purchase_requisition` SET TAGS ('dbx_mvm_scope' = 'basic_purchasing');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`purchase_requisition` SET TAGS ('dbx_source_system' = 'SAP MM');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`purchase_requisition` SET TAGS ('dbx_SAP_SRM' = 'true');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`purchase_requisition` SET TAGS ('dbx_eprocurement_integrated' = 'true');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`purchase_requisition` SET TAGS ('dbx_commodity_aware' = 'true');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `purchase_requisition_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Requisition ID');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `eprocurement_portal_id` SET TAGS ('dbx_business_glossary_term' = 'E-Procurement Portal Reference');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `equipment_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Registry Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `opportunity_id` SET TAGS ('dbx_business_glossary_term' = 'Opportunity Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Requestor Employee ID');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `procurement_supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `purchase_approved_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approver Employee ID');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `purchase_approved_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `purchase_approved_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `purchase_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Requestor Employee ID');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `purchase_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `purchase_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `sku_master_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Master Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `spend_category_id` SET TAGS ('dbx_business_glossary_term' = 'Spend Category Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `supplier_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Contract Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `vehicle_program_id` SET TAGS ('dbx_business_glossary_term' = 'Program Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `account_assignment_category` SET TAGS ('dbx_business_glossary_term' = 'Account Assignment Category');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `account_assignment_category` SET TAGS ('dbx_value_regex' = 'cost_center|project|asset|order');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `data_governance_ref` SET TAGS ('dbx_business_glossary_term' = 'Data Governance Reference');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `estimated_value` SET TAGS ('dbx_business_glossary_term' = 'Estimated Value');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `is_converted_to_po` SET TAGS ('dbx_business_glossary_term' = 'Converted to Purchase Order Flag');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Requisition Notes');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Requisition Priority');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `procurement_type` SET TAGS ('dbx_business_glossary_term' = 'Procurement Type');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `procurement_type` SET TAGS ('dbx_value_regex' = 'direct|indirect|service|capital');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `purchase_group` SET TAGS ('dbx_business_glossary_term' = 'Purchase Group');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `purchase_order_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Number');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `purchase_requisition_status` SET TAGS ('dbx_business_glossary_term' = 'Purchase Requisition Status');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `purchase_requisition_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|approved|rejected|closed|cancelled');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Requested Quantity');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Created Timestamp');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Updated Timestamp');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `required_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Required Delivery Date');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `requisition_date` SET TAGS ('dbx_business_glossary_term' = 'Requisition Date');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `requisition_number` SET TAGS ('dbx_business_glossary_term' = 'Requisition Number');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `source_of_supply` SET TAGS ('dbx_business_glossary_term' = 'Source of Supply');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `source_of_supply` SET TAGS ('dbx_value_regex' = 'internal|external|consignment');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `tax_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Code');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`purchase_requisition` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_purchase_order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_purchase_order` SET TAGS ('dbx_subdomain' = 'order_execution');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_purchase_order` SET TAGS ('dbx_source_of_record' = 'SAP MM');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_purchase_order` SET TAGS ('dbx_SAP_SRM' = 'true');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_purchase_order` SET TAGS ('dbx_mvm_status' = 'include');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_purchase_order` SET TAGS ('dbx_mvm_scope' = 'basic_purchasing');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_purchase_order` SET TAGS ('dbx_source_system' = 'SAP MM');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_purchase_order` SET TAGS ('dbx_SAP_SRM' = 'true');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_purchase_order` SET TAGS ('dbx_eprocurement_integrated' = 'true');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_purchase_order` SET TAGS ('dbx_commodity_aware' = 'true');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_purchase_order` ALTER COLUMN `procurement_purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order ID');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_purchase_order` ALTER COLUMN `compliance_document_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Document Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_purchase_order` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_purchase_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By Employee Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_purchase_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_purchase_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_purchase_order` ALTER COLUMN `eprocurement_portal_id` SET TAGS ('dbx_business_glossary_term' = 'E-Procurement Portal Reference');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_purchase_order` ALTER COLUMN `equipment_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Registry Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_purchase_order` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_purchase_order` ALTER COLUMN `inspection_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Plan Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_purchase_order` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant ID');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_purchase_order` ALTER COLUMN `procurement_supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_purchase_order` ALTER COLUMN `production_line_id` SET TAGS ('dbx_business_glossary_term' = 'Production Line Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_purchase_order` ALTER COLUMN `supplier_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract ID');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_purchase_order` ALTER COLUMN `vehicle_order_id` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Order Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_purchase_order` ALTER COLUMN `vehicle_program_id` SET TAGS ('dbx_business_glossary_term' = 'Program Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_purchase_order` ALTER COLUMN `account_assignment` SET TAGS ('dbx_business_glossary_term' = 'Account Assignment');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_purchase_order` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_purchase_order` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_purchase_order` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_purchase_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_purchase_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|EUR|JPY|CNY|GBP|CHF');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_purchase_order` ALTER COLUMN `currency_rate` SET TAGS ('dbx_business_glossary_term' = 'Currency Exchange Rate');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_purchase_order` ALTER COLUMN `data_governance_ref` SET TAGS ('dbx_business_glossary_term' = 'Data Governance Reference');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_purchase_order` ALTER COLUMN `delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Requested Delivery Date');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_purchase_order` ALTER COLUMN `goods_receipt_date` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt Date');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_purchase_order` ALTER COLUMN `gr_ir_control_flag` SET TAGS ('dbx_business_glossary_term' = 'GR/IR Control Flag');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_purchase_order` ALTER COLUMN `gross_amount` SET TAGS ('dbx_business_glossary_term' = 'Gross Amount (PO_GROSS)');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_purchase_order` ALTER COLUMN `incoterms` SET TAGS ('dbx_business_glossary_term' = 'Incoterms (International Commercial Terms)');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_purchase_order` ALTER COLUMN `incoterms` SET TAGS ('dbx_value_regex' = 'EXW|FCA|CPT|CIP|DAP|DDP');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_purchase_order` ALTER COLUMN `invoice_receipt_date` SET TAGS ('dbx_business_glossary_term' = 'Invoice Receipt Date');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_purchase_order` ALTER COLUMN `net_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Amount (PO_NET)');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_purchase_order` ALTER COLUMN `order_date` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Date (PO_DATE)');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_purchase_order` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_purchase_order` ALTER COLUMN `po_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Number (PO_NUMBER)');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_purchase_order` ALTER COLUMN `po_type` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Type (PO_TYPE)');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_purchase_order` ALTER COLUMN `po_type` SET TAGS ('dbx_value_regex' = 'standard|blanket|consignment|subcontract|service');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_purchase_order` ALTER COLUMN `procurement_purchase_order_status` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Status (PO_STATUS)');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_purchase_order` ALTER COLUMN `procurement_purchase_order_status` SET TAGS ('dbx_value_regex' = 'draft|released|approved|partially_received|closed|cancelled');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_purchase_order` ALTER COLUMN `purchase_group` SET TAGS ('dbx_business_glossary_term' = 'Purchase Group');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_purchase_order` ALTER COLUMN `purchasing_organization` SET TAGS ('dbx_business_glossary_term' = 'Purchasing Organization');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_purchase_order` ALTER COLUMN `supplier_name` SET TAGS ('dbx_business_glossary_term' = 'Supplier Name');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_purchase_order` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount (PO_TAX)');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_purchase_order` ALTER COLUMN `tax_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Code');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_purchase_order` ALTER COLUMN `total_quantity` SET TAGS ('dbx_business_glossary_term' = 'Total Quantity');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_purchase_order` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_po_line` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_po_line` SET TAGS ('dbx_subdomain' = 'order_execution');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_po_line` SET TAGS ('dbx_source_of_record' = 'SAP MM');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_po_line` SET TAGS ('dbx_SAP_SRM' = 'true');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_po_line` SET TAGS ('dbx_mvm_status' = 'include');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_po_line` SET TAGS ('dbx_mvm_scope' = 'basic_purchasing');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_po_line` SET TAGS ('dbx_source_system' = 'SAP MM');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_po_line` SET TAGS ('dbx_SAP_SRM' = 'true');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_po_line` SET TAGS ('dbx_eprocurement_integrated' = 'true');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_po_line` SET TAGS ('dbx_commodity_aware' = 'true');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_po_line` ALTER COLUMN `commodity_group_id` SET TAGS ('dbx_business_glossary_term' = 'Commodity Group Reference');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_po_line` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_po_line` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_po_line` ALTER COLUMN `spend_category_id` SET TAGS ('dbx_business_glossary_term' = 'Spend Category Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_po_line` ALTER COLUMN `data_governance_ref` SET TAGS ('dbx_business_glossary_term' = 'Data Governance Reference');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`supplier_contract` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`supplier_contract` SET TAGS ('dbx_subdomain' = 'sourcing_contracting');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`supplier_contract` SET TAGS ('dbx_source_of_record' = 'SAP MM');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`supplier_contract` SET TAGS ('dbx_SAP_SRM' = 'true');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`supplier_contract` SET TAGS ('dbx_mvm_status' = 'include');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`supplier_contract` SET TAGS ('dbx_mvm_scope' = 'basic_purchasing');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`supplier_contract` SET TAGS ('dbx_source_system' = 'SAP MM');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`supplier_contract` SET TAGS ('dbx_SAP_SRM' = 'true');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`supplier_contract` SET TAGS ('dbx_eprocurement_integrated' = 'true');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`supplier_contract` SET TAGS ('dbx_commodity_aware' = 'true');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`supplier_contract` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`supplier_contract` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`supplier_contract` ALTER COLUMN `eprocurement_portal_id` SET TAGS ('dbx_business_glossary_term' = 'E-Procurement Portal Reference');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`supplier_contract` ALTER COLUMN `data_governance_ref` SET TAGS ('dbx_business_glossary_term' = 'Data Governance Reference');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`scheduling_agreement_line` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`scheduling_agreement_line` SET TAGS ('dbx_subdomain' = 'order_execution');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`scheduling_agreement_line` SET TAGS ('dbx_source_of_record' = 'SAP MM');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`scheduling_agreement_line` SET TAGS ('dbx_SAP_SRM' = 'true');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`scheduling_agreement_line` SET TAGS ('dbx_source_system' = 'SAP MM');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`scheduling_agreement_line` SET TAGS ('dbx_SAP_SRM' = 'true');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`scheduling_agreement_line` SET TAGS ('dbx_eprocurement_integrated' = 'true');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`scheduling_agreement_line` SET TAGS ('dbx_commodity_aware' = 'true');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`scheduling_agreement_line` ALTER COLUMN `data_governance_ref` SET TAGS ('dbx_business_glossary_term' = 'Data Governance Reference');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_goods_receipt` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_goods_receipt` SET TAGS ('dbx_subdomain' = 'invoice_settlement');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_goods_receipt` SET TAGS ('dbx_source_of_record' = 'SAP MM');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_goods_receipt` SET TAGS ('dbx_SAP_SRM' = 'true');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_goods_receipt` SET TAGS ('dbx_mvm_status' = 'include');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_goods_receipt` SET TAGS ('dbx_mvm_scope' = 'basic_purchasing');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_goods_receipt` SET TAGS ('dbx_source_system' = 'SAP MM');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_goods_receipt` SET TAGS ('dbx_SAP_SRM' = 'true');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_goods_receipt` SET TAGS ('dbx_eprocurement_integrated' = 'true');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_goods_receipt` SET TAGS ('dbx_commodity_aware' = 'true');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_goods_receipt` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_goods_receipt` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_goods_receipt` ALTER COLUMN `procurement_po_line_id` SET TAGS ('dbx_business_glossary_term' = 'Procurement Po Line Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_goods_receipt` ALTER COLUMN `procurement_purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Procurement Purchase Order Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_goods_receipt` ALTER COLUMN `procurement_receipt_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_goods_receipt` ALTER COLUMN `procurement_receipt_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_goods_receipt` ALTER COLUMN `scheduling_agreement_line_id` SET TAGS ('dbx_business_glossary_term' = 'Scheduling Agreement Line Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_goods_receipt` ALTER COLUMN `data_governance_ref` SET TAGS ('dbx_business_glossary_term' = 'Data Governance Reference');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`supplier_invoice` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`supplier_invoice` SET TAGS ('dbx_subdomain' = 'invoice_settlement');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`supplier_invoice` SET TAGS ('dbx_source_of_record' = 'SAP MM');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`supplier_invoice` SET TAGS ('dbx_SAP_SRM' = 'true');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`supplier_invoice` SET TAGS ('dbx_mvm_status' = 'include');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`supplier_invoice` SET TAGS ('dbx_mvm_scope' = 'basic_purchasing');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`supplier_invoice` SET TAGS ('dbx_source_system' = 'SAP MM');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`supplier_invoice` SET TAGS ('dbx_SAP_SRM' = 'true');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`supplier_invoice` SET TAGS ('dbx_eprocurement_integrated' = 'true');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`supplier_invoice` SET TAGS ('dbx_commodity_aware' = 'true');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `payment_run_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Run Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `procurement_goods_receipt_id` SET TAGS ('dbx_business_glossary_term' = 'Procurement Goods Receipt Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `procurement_purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Procurement Purchase Order Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `e_invoice_flag` SET TAGS ('dbx_business_glossary_term' = 'E-Invoice Flag');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`supplier_invoice` ALTER COLUMN `supplier_address_line` SET TAGS ('dbx_sensitivity' = 'pii');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_invoice_line` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_invoice_line` SET TAGS ('dbx_subdomain' = 'invoice_settlement');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_invoice_line` SET TAGS ('dbx_ssot_owner' = 'billing');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_invoice_line` SET TAGS ('dbx_ssot_concept' = 'invoice_line');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_invoice_line` SET TAGS ('dbx_ssot_reference' = 'true');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_invoice_line` SET TAGS ('dbx_source_of_record' = 'SAP MM');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_invoice_line` SET TAGS ('dbx_SAP_SRM' = 'true');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_invoice_line` SET TAGS ('dbx_source_system' = 'SAP MM');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_invoice_line` SET TAGS ('dbx_SAP_SRM' = 'true');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_invoice_line` SET TAGS ('dbx_eprocurement_integrated' = 'true');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_invoice_line` SET TAGS ('dbx_commodity_aware' = 'true');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_invoice_line` SET TAGS ('dbx_ssot_role' = 'owner');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_invoice_line` ALTER COLUMN `procurement_goods_receipt_id` SET TAGS ('dbx_business_glossary_term' = 'Procurement Goods Receipt Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_invoice_line` ALTER COLUMN `data_governance_ref` SET TAGS ('dbx_business_glossary_term' = 'Data Governance Reference');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`spend_category` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`spend_category` SET TAGS ('dbx_subdomain' = 'spend_analytics');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`spend_category` SET TAGS ('dbx_esg_relevant' = 'true');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`spend_category` SET TAGS ('dbx_source_of_record' = 'SAP MM');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`spend_category` SET TAGS ('dbx_SAP_SRM' = 'true');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`spend_category` SET TAGS ('dbx_source_system' = 'SAP MM');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`spend_category` SET TAGS ('dbx_SAP_SRM' = 'true');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`spend_category` SET TAGS ('dbx_eprocurement_integrated' = 'true');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`spend_category` SET TAGS ('dbx_commodity_aware' = 'true');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`spend_category` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`spend_category` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`spend_category` ALTER COLUMN `spend_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`spend_category` ALTER COLUMN `spend_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`spend_category` ALTER COLUMN `data_governance_ref` SET TAGS ('dbx_business_glossary_term' = 'Data Governance Reference');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`approved_vendor_list` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`approved_vendor_list` SET TAGS ('dbx_subdomain' = 'supplier_management');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`approved_vendor_list` SET TAGS ('dbx_source_of_record' = 'SAP MM');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`approved_vendor_list` SET TAGS ('dbx_SAP_SRM' = 'true');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`approved_vendor_list` SET TAGS ('dbx_source_system' = 'SAP MM');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`approved_vendor_list` SET TAGS ('dbx_SAP_SRM' = 'true');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`approved_vendor_list` SET TAGS ('dbx_eprocurement_integrated' = 'true');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`approved_vendor_list` SET TAGS ('dbx_commodity_aware' = 'true');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`approved_vendor_list` ALTER COLUMN `approved_vendor_list_id` SET TAGS ('dbx_business_glossary_term' = 'Approved Vendor List ID');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`approved_vendor_list` ALTER COLUMN `info_record_id` SET TAGS ('dbx_business_glossary_term' = 'Info Record Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`approved_vendor_list` ALTER COLUMN `material_id` SET TAGS ('dbx_business_glossary_term' = 'Material ID');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`approved_vendor_list` ALTER COLUMN `procurement_supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`approved_vendor_list` ALTER COLUMN `supplier_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract ID');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`approved_vendor_list` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Effective Date');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`approved_vendor_list` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`approved_vendor_list` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'approved|conditional|disqualified');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`approved_vendor_list` ALTER COLUMN `avl_number` SET TAGS ('dbx_business_glossary_term' = 'Approved Vendor List Number (AVL)');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`approved_vendor_list` ALTER COLUMN `backup_supplier_flag` SET TAGS ('dbx_business_glossary_term' = 'Backup Supplier Indicator');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`approved_vendor_list` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`approved_vendor_list` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`approved_vendor_list` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`approved_vendor_list` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`approved_vendor_list` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`approved_vendor_list` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|EUR|JPY|GBP|CNY|CAD');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`approved_vendor_list` ALTER COLUMN `data_governance_ref` SET TAGS ('dbx_business_glossary_term' = 'Data Governance Reference');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`approved_vendor_list` ALTER COLUMN `entry_date` SET TAGS ('dbx_business_glossary_term' = 'Entry Date');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`approved_vendor_list` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`approved_vendor_list` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`approved_vendor_list` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time (Days)');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`approved_vendor_list` ALTER COLUMN `min_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`approved_vendor_list` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`approved_vendor_list` ALTER COLUMN `ppap_approval_level` SET TAGS ('dbx_business_glossary_term' = 'PPAP Approval Level');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`approved_vendor_list` ALTER COLUMN `ppap_approval_level` SET TAGS ('dbx_value_regex' = 'Level1|Level2|Level3|Level4|Level5');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`approved_vendor_list` ALTER COLUMN `preferred_supplier_flag` SET TAGS ('dbx_business_glossary_term' = 'Preferred Supplier Indicator');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`approved_vendor_list` ALTER COLUMN `price_cap` SET TAGS ('dbx_business_glossary_term' = 'Price Cap (Maximum Allowed Price)');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`approved_vendor_list` ALTER COLUMN `quality_rating_threshold` SET TAGS ('dbx_business_glossary_term' = 'Quality Rating Threshold (%)');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`approved_vendor_list` ALTER COLUMN `regulatory_approval_required` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Required');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`approved_vendor_list` ALTER COLUMN `review_cycle_months` SET TAGS ('dbx_business_glossary_term' = 'Review Cycle (Months)');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`approved_vendor_list` ALTER COLUMN `single_source_justification` SET TAGS ('dbx_business_glossary_term' = 'Single Source Justification');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`approved_vendor_list` ALTER COLUMN `source_list_flag` SET TAGS ('dbx_business_glossary_term' = 'Source List Indicator');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`approved_vendor_list` ALTER COLUMN `updated_by_user` SET TAGS ('dbx_business_glossary_term' = 'Updated By User');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`approved_vendor_list` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`info_record` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`info_record` SET TAGS ('dbx_subdomain' = 'supplier_management');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`info_record` SET TAGS ('dbx_source_of_record' = 'SAP MM');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`info_record` SET TAGS ('dbx_SAP_SRM' = 'true');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`info_record` SET TAGS ('dbx_source_system' = 'SAP MM');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`info_record` SET TAGS ('dbx_SAP_SRM' = 'true');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`info_record` SET TAGS ('dbx_eprocurement_integrated' = 'true');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`info_record` SET TAGS ('dbx_commodity_aware' = 'true');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`info_record` ALTER COLUMN `info_record_id` SET TAGS ('dbx_business_glossary_term' = 'Purchasing Info Record ID');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`info_record` ALTER COLUMN `material_id` SET TAGS ('dbx_business_glossary_term' = 'Material Identifier');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`info_record` ALTER COLUMN `procurement_supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Identifier');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`info_record` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`info_record` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`info_record` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|EUR|JPY|GBP|CNY|CAD');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`info_record` ALTER COLUMN `data_governance_ref` SET TAGS ('dbx_business_glossary_term' = 'Data Governance Reference');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`info_record` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`info_record` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`info_record` ALTER COLUMN `info_record_number` SET TAGS ('dbx_business_glossary_term' = 'Info Record Number (IRN)');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`info_record` ALTER COLUMN `info_record_number` SET TAGS ('dbx_value_regex' = '^IR[0-9]{8}$');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`info_record` ALTER COLUMN `info_record_status` SET TAGS ('dbx_business_glossary_term' = 'Info Record Status');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`info_record` ALTER COLUMN `info_record_status` SET TAGS ('dbx_value_regex' = 'active|inactive|blocked|pending');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`info_record` ALTER COLUMN `info_record_type` SET TAGS ('dbx_business_glossary_term' = 'Info Record Type');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`info_record` ALTER COLUMN `info_record_type` SET TAGS ('dbx_value_regex' = 'standard|contract|framework');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`info_record` ALTER COLUMN `last_price_update_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Price Update Timestamp');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`info_record` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Planned Lead Time (Days)');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`info_record` ALTER COLUMN `minimum_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`info_record` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Info Record Notes');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`info_record` ALTER COLUMN `order_quantity_uom` SET TAGS ('dbx_business_glossary_term' = 'Order Quantity Unit of Measure (UOM)');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`info_record` ALTER COLUMN `order_quantity_uom` SET TAGS ('dbx_value_regex' = 'EA|KG|L|M|PCS|BOX');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`info_record` ALTER COLUMN `over_delivery_tolerance_percent` SET TAGS ('dbx_business_glossary_term' = 'Over‑Delivery Tolerance (%)');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`info_record` ALTER COLUMN `price_amount` SET TAGS ('dbx_business_glossary_term' = 'Unit Price Amount (USD)');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`info_record` ALTER COLUMN `price_valid_from` SET TAGS ('dbx_business_glossary_term' = 'Price Valid From Date');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`info_record` ALTER COLUMN `price_valid_until` SET TAGS ('dbx_business_glossary_term' = 'Price Valid Until Date');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`info_record` ALTER COLUMN `procurement_category` SET TAGS ('dbx_business_glossary_term' = 'Procurement Category');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`info_record` ALTER COLUMN `procurement_category` SET TAGS ('dbx_value_regex' = 'direct|indirect');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`info_record` ALTER COLUMN `reminder_days` SET TAGS ('dbx_business_glossary_term' = 'Reminder Days');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`info_record` ALTER COLUMN `under_delivery_tolerance_percent` SET TAGS ('dbx_business_glossary_term' = 'Under‑Delivery Tolerance (%)');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`info_record` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Updated By User ID');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`info_record` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`info_record` ALTER COLUMN `vendor_evaluation_score` SET TAGS ('dbx_business_glossary_term' = 'Vendor Evaluation Score');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`info_record` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`supplier_evaluation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`supplier_evaluation` SET TAGS ('dbx_subdomain' = 'supplier_management');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`supplier_evaluation` SET TAGS ('dbx_esg_relevant' = 'true');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`supplier_evaluation` SET TAGS ('dbx_source_of_record' = 'SAP MM');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`supplier_evaluation` SET TAGS ('dbx_SAP_SRM' = 'true');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`supplier_evaluation` SET TAGS ('dbx_source_system' = 'SAP MM');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`supplier_evaluation` SET TAGS ('dbx_SAP_SRM' = 'true');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`supplier_evaluation` SET TAGS ('dbx_eprocurement_integrated' = 'true');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`supplier_evaluation` SET TAGS ('dbx_commodity_aware' = 'true');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`supplier_evaluation` ALTER COLUMN `supplier_evaluation_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Evaluation ID');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`supplier_evaluation` ALTER COLUMN `procurement_supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`supplier_evaluation` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Evaluator ID');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`supplier_evaluation` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`supplier_evaluation` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`supplier_evaluation` ALTER COLUMN `supplier_evaluator_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Evaluator ID');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`supplier_evaluation` ALTER COLUMN `supplier_evaluator_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`supplier_evaluation` ALTER COLUMN `supplier_evaluator_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`supplier_evaluation` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Comments');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`supplier_evaluation` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`supplier_evaluation` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|exempt');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`supplier_evaluation` ALTER COLUMN `cost_score` SET TAGS ('dbx_business_glossary_term' = 'Cost Score');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`supplier_evaluation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`supplier_evaluation` ALTER COLUMN `delivery_score` SET TAGS ('dbx_business_glossary_term' = 'Delivery Score');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`supplier_evaluation` ALTER COLUMN `development_score` SET TAGS ('dbx_business_glossary_term' = 'Development Score');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`supplier_evaluation` ALTER COLUMN `digital_collaboration_score` SET TAGS ('dbx_business_glossary_term' = 'Digital Collaboration Score');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`supplier_evaluation` ALTER COLUMN `evaluation_date` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Date');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`supplier_evaluation` ALTER COLUMN `evaluation_method` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Method');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`supplier_evaluation` ALTER COLUMN `evaluation_method` SET TAGS ('dbx_value_regex' = 'automated|manual|mixed');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`supplier_evaluation` ALTER COLUMN `evaluation_number` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Number');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`supplier_evaluation` ALTER COLUMN `evaluation_status` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Status');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`supplier_evaluation` ALTER COLUMN `evaluation_status` SET TAGS ('dbx_value_regex' = 'draft|in_progress|completed|approved|archived');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`supplier_evaluation` ALTER COLUMN `evaluation_type` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Type');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`supplier_evaluation` ALTER COLUMN `evaluation_type` SET TAGS ('dbx_value_regex' = 'annual|quarterly|ad_hoc');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`supplier_evaluation` ALTER COLUMN `evaluation_version` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Version');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`supplier_evaluation` ALTER COLUMN `failed_criteria_count` SET TAGS ('dbx_business_glossary_term' = 'Failed Criteria Count');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`supplier_evaluation` ALTER COLUMN `invoice_accuracy_pct` SET TAGS ('dbx_business_glossary_term' = 'Invoice Accuracy Percentage');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`supplier_evaluation` ALTER COLUMN `on_time_delivery_pct` SET TAGS ('dbx_business_glossary_term' = 'On‑Time Delivery Percentage');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`supplier_evaluation` ALTER COLUMN `overall_score` SET TAGS ('dbx_business_glossary_term' = 'Overall Evaluation Score');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`supplier_evaluation` ALTER COLUMN `passed_criteria_count` SET TAGS ('dbx_business_glossary_term' = 'Passed Criteria Count');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`supplier_evaluation` ALTER COLUMN `period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Period End Date');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`supplier_evaluation` ALTER COLUMN `period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Period Start Date');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`supplier_evaluation` ALTER COLUMN `ppm_defect_rate` SET TAGS ('dbx_business_glossary_term' = 'PPM Defect Rate');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`supplier_evaluation` ALTER COLUMN `price_variance_pct` SET TAGS ('dbx_business_glossary_term' = 'Price Variance Percentage');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`supplier_evaluation` ALTER COLUMN `quality_score` SET TAGS ('dbx_business_glossary_term' = 'Quality Score');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`supplier_evaluation` ALTER COLUMN `recommended_action` SET TAGS ('dbx_business_glossary_term' = 'Recommended Action');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`supplier_evaluation` ALTER COLUMN `recommended_action` SET TAGS ('dbx_value_regex' = 'maintain|develop|reduce|disqualify');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`supplier_evaluation` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Level');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`supplier_evaluation` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`supplier_evaluation` ALTER COLUMN `supplier_category` SET TAGS ('dbx_business_glossary_term' = 'Supplier Category');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`supplier_evaluation` ALTER COLUMN `supplier_category` SET TAGS ('dbx_value_regex' = 'tier1|tier2|tier3|tier4');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`supplier_evaluation` ALTER COLUMN `supplier_region` SET TAGS ('dbx_business_glossary_term' = 'Supplier Region');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`supplier_evaluation` ALTER COLUMN `supplier_region` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`supplier_evaluation` ALTER COLUMN `total_criteria_count` SET TAGS ('dbx_business_glossary_term' = 'Total Criteria Count');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`supplier_evaluation` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`supplier_development_plan` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`supplier_development_plan` SET TAGS ('dbx_subdomain' = 'supplier_management');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`supplier_development_plan` SET TAGS ('dbx_source_of_record' = 'SAP MM');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`supplier_development_plan` SET TAGS ('dbx_SAP_SRM' = 'true');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`supplier_development_plan` SET TAGS ('dbx_source_system' = 'SAP MM');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`supplier_development_plan` SET TAGS ('dbx_SAP_SRM' = 'true');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`supplier_development_plan` SET TAGS ('dbx_eprocurement_integrated' = 'true');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`supplier_development_plan` SET TAGS ('dbx_commodity_aware' = 'true');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`supplier_development_plan` ALTER COLUMN `supplier_development_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Development Plan ID');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`supplier_development_plan` ALTER COLUMN `apqp_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Apqp Plan Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`supplier_development_plan` ALTER COLUMN `obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Obligation Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`supplier_development_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Engineer ID');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`supplier_development_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`supplier_development_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`supplier_development_plan` ALTER COLUMN `procurement_supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`supplier_development_plan` ALTER COLUMN `supplier_approved_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By ID');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`supplier_development_plan` ALTER COLUMN `supplier_approved_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`supplier_development_plan` ALTER COLUMN `supplier_approved_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`supplier_development_plan` ALTER COLUMN `supplier_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Contract ID');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`supplier_development_plan` ALTER COLUMN `supplier_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Engineer ID');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`supplier_development_plan` ALTER COLUMN `supplier_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`supplier_development_plan` ALTER COLUMN `supplier_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`supplier_development_plan` ALTER COLUMN `supplier_evaluation_id` SET TAGS ('dbx_business_glossary_term' = 'Triggering Supplier Evaluation Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`supplier_development_plan` ALTER COLUMN `actual_metric_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Metric Timestamp');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`supplier_development_plan` ALTER COLUMN `actual_metric_value` SET TAGS ('dbx_business_glossary_term' = 'Actual Metric Value');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`supplier_development_plan` ALTER COLUMN `actual_progress_percent` SET TAGS ('dbx_business_glossary_term' = 'Actual Progress Percent');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`supplier_development_plan` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`supplier_development_plan` ALTER COLUMN `budget_status` SET TAGS ('dbx_business_glossary_term' = 'Budget Status');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`supplier_development_plan` ALTER COLUMN `budget_status` SET TAGS ('dbx_value_regex' = 'under_budget|on_budget|over_budget');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`supplier_development_plan` ALTER COLUMN `change_reason` SET TAGS ('dbx_business_glossary_term' = 'Change Reason');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`supplier_development_plan` ALTER COLUMN `compliance_requirements` SET TAGS ('dbx_business_glossary_term' = 'Compliance Requirements');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`supplier_development_plan` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`supplier_development_plan` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`supplier_development_plan` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`supplier_development_plan` ALTER COLUMN `investment_amount` SET TAGS ('dbx_business_glossary_term' = 'Investment Amount');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`supplier_development_plan` ALTER COLUMN `investment_currency` SET TAGS ('dbx_business_glossary_term' = 'Investment Currency');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`supplier_development_plan` ALTER COLUMN `investment_type` SET TAGS ('dbx_business_glossary_term' = 'Investment Type');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`supplier_development_plan` ALTER COLUMN `investment_type` SET TAGS ('dbx_value_regex' = 'automotive_funded|supplier_funded|joint');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`supplier_development_plan` ALTER COLUMN `is_capex` SET TAGS ('dbx_business_glossary_term' = 'Is CapEx');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`supplier_development_plan` ALTER COLUMN `is_oem` SET TAGS ('dbx_business_glossary_term' = 'Is OEM Supplier');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`supplier_development_plan` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`supplier_development_plan` ALTER COLUMN `milestone_schedule` SET TAGS ('dbx_business_glossary_term' = 'Milestone Schedule');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`supplier_development_plan` ALTER COLUMN `next_milestone_date` SET TAGS ('dbx_business_glossary_term' = 'Next Milestone Date');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`supplier_development_plan` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Plan Notes');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`supplier_development_plan` ALTER COLUMN `plan_code` SET TAGS ('dbx_business_glossary_term' = 'Plan Code');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`supplier_development_plan` ALTER COLUMN `plan_name` SET TAGS ('dbx_business_glossary_term' = 'Plan Name');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`supplier_development_plan` ALTER COLUMN `plan_type` SET TAGS ('dbx_business_glossary_term' = 'Plan Type');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`supplier_development_plan` ALTER COLUMN `plan_type` SET TAGS ('dbx_value_regex' = 'quality_improvement|capacity_ramp|technology_development|cost_reduction');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`supplier_development_plan` ALTER COLUMN `plan_version` SET TAGS ('dbx_business_glossary_term' = 'Plan Version');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`supplier_development_plan` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Plan Priority');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`supplier_development_plan` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`supplier_development_plan` ALTER COLUMN `related_sop_date` SET TAGS ('dbx_business_glossary_term' = 'Related SOP Date');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`supplier_development_plan` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Level');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`supplier_development_plan` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'low|medium|high');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`supplier_development_plan` ALTER COLUMN `supplier_development_plan_status` SET TAGS ('dbx_business_glossary_term' = 'Plan Status');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`supplier_development_plan` ALTER COLUMN `supplier_development_plan_status` SET TAGS ('dbx_value_regex' = 'draft|approved|in_progress|completed|on_hold|cancelled');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`supplier_development_plan` ALTER COLUMN `target_metric_name` SET TAGS ('dbx_business_glossary_term' = 'Target Metric Name');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`supplier_development_plan` ALTER COLUMN `target_metric_unit` SET TAGS ('dbx_business_glossary_term' = 'Target Metric Unit');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`supplier_development_plan` ALTER COLUMN `target_metric_value` SET TAGS ('dbx_business_glossary_term' = 'Target Metric Value');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`supplier_development_plan` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`capex_requisition` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`capex_requisition` SET TAGS ('dbx_subdomain' = 'order_execution');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`capex_requisition` SET TAGS ('dbx_source_of_record' = 'SAP MM');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`capex_requisition` SET TAGS ('dbx_SAP_SRM' = 'true');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`capex_requisition` SET TAGS ('dbx_source_system' = 'SAP MM');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`capex_requisition` SET TAGS ('dbx_SAP_SRM' = 'true');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`capex_requisition` SET TAGS ('dbx_eprocurement_integrated' = 'true');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`capex_requisition` SET TAGS ('dbx_commodity_aware' = 'true');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`capex_requisition` ALTER COLUMN `capex_requisition_id` SET TAGS ('dbx_business_glossary_term' = 'CapEx Requisition Identifier (CAPEX_REQ_ID)');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`capex_requisition` ALTER COLUMN `budget_line_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Line Identifier (BUDGET_LINE_ID)');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`capex_requisition` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Requestor Employee Identifier (REQ_EMP_ID)');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`capex_requisition` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`capex_requisition` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`capex_requisition` ALTER COLUMN `capex_project_manager_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Project Manager Employee Identifier (PM_EMP_ID)');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`capex_requisition` ALTER COLUMN `capex_project_manager_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`capex_requisition` ALTER COLUMN `capex_project_manager_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`capex_requisition` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Identifier (COST_CENTER_ID)');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`capex_requisition` ALTER COLUMN `department_id` SET TAGS ('dbx_business_glossary_term' = 'Requesting Department Identifier (DEPT_ID)');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`capex_requisition` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`capex_requisition` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant Identifier (PLANT_ID)');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`capex_requisition` ALTER COLUMN `primary_capex_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Requestor Employee Identifier (REQ_EMP_ID)');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`capex_requisition` ALTER COLUMN `primary_capex_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`capex_requisition` ALTER COLUMN `primary_capex_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`capex_requisition` ALTER COLUMN `procurement_supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Supplier Identifier (VENDOR_ID)');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`capex_requisition` ALTER COLUMN `supplier_quote_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Quote Identifier (VENDOR_QUOTE_ID)');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`capex_requisition` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Supplier Identifier (VENDOR_ID)');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`capex_requisition` ALTER COLUMN `afe_number` SET TAGS ('dbx_business_glossary_term' = 'Authorization for Expenditure Number (AFE_NO)');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`capex_requisition` ALTER COLUMN `approval_authority_level` SET TAGS ('dbx_business_glossary_term' = 'Approval Authority Level (APPROVAL_LVL)');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`capex_requisition` ALTER COLUMN `approval_authority_level` SET TAGS ('dbx_value_regex' = 'manager|director|vp|cfo|ceo');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`capex_requisition` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date (APPROVAL_DATE)');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`capex_requisition` ALTER COLUMN `approved_budget` SET TAGS ('dbx_business_glossary_term' = 'Approved Budget Amount (APPROVED_BUDGET_AMT)');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`capex_requisition` ALTER COLUMN `asset_category` SET TAGS ('dbx_business_glossary_term' = 'Asset Category (ASSET_CAT)');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`capex_requisition` ALTER COLUMN `asset_category` SET TAGS ('dbx_value_regex' = 'tooling|equipment|facility|software|infrastructure|other');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`capex_requisition` ALTER COLUMN `asset_life_years` SET TAGS ('dbx_business_glossary_term' = 'Asset Useful Life (Years) (ASSET_LIFE_YRS)');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`capex_requisition` ALTER COLUMN `capex_requisition_status` SET TAGS ('dbx_business_glossary_term' = 'Requisition Status (REQ_STATUS)');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`capex_requisition` ALTER COLUMN `capex_requisition_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|approved|rejected|closed|cancelled');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`capex_requisition` ALTER COLUMN `capitalized_flag` SET TAGS ('dbx_business_glossary_term' = 'Capitalization Flag (CAPITALIZED_FLG)');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`capex_requisition` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status (COMPLIANCE_STATUS)');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`capex_requisition` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`capex_requisition` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (CREATED_TS)');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`capex_requisition` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (CURR_CD)');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`capex_requisition` ALTER COLUMN `data_governance_ref` SET TAGS ('dbx_business_glossary_term' = 'Data Governance Reference');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`capex_requisition` ALTER COLUMN `depreciation_life_years` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Life (Years) (DEP_LIFE_YRS)');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`capex_requisition` ALTER COLUMN `depreciation_start_date` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Start Date (DEP_START_DATE)');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`capex_requisition` ALTER COLUMN `capex_requisition_description` SET TAGS ('dbx_business_glossary_term' = 'Requisition Description (REQ_DESC)');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`capex_requisition` ALTER COLUMN `environmental_impact_assessment` SET TAGS ('dbx_business_glossary_term' = 'Environmental Impact Assessment (ENV_IMPACT_ASSESSMENT)');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`capex_requisition` ALTER COLUMN `environmental_impact_assessment` SET TAGS ('dbx_value_regex' = 'low|medium|high|not_applicable');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`capex_requisition` ALTER COLUMN `estimated_investment` SET TAGS ('dbx_business_glossary_term' = 'Estimated Investment Amount (EST_INV_AMT)');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`capex_requisition` ALTER COLUMN `funding_source` SET TAGS ('dbx_business_glossary_term' = 'Funding Source (FUND_SRC)');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`capex_requisition` ALTER COLUMN `funding_source` SET TAGS ('dbx_value_regex' = 'internal|external|loan|grant|other');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`capex_requisition` ALTER COLUMN `justification_type` SET TAGS ('dbx_business_glossary_term' = 'Justification Type (JUST_TYPE)');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`capex_requisition` ALTER COLUMN `justification_type` SET TAGS ('dbx_value_regex' = 'new_model|replacement|capacity|maintenance|other');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`capex_requisition` ALTER COLUMN `procurement_method` SET TAGS ('dbx_business_glossary_term' = 'Procurement Method (PROC_METHOD)');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`capex_requisition` ALTER COLUMN `procurement_method` SET TAGS ('dbx_value_regex' = 'purchase|lease|internal|other');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`capex_requisition` ALTER COLUMN `project_code` SET TAGS ('dbx_business_glossary_term' = 'Project Code (PRJ_CD)');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`capex_requisition` ALTER COLUMN `regulatory_approval_required` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Required Flag (REG_APPROVAL_REQ_FLG)');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`capex_requisition` ALTER COLUMN `regulatory_approval_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Status (REG_APPROVAL_STATUS)');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`capex_requisition` ALTER COLUMN `regulatory_approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`capex_requisition` ALTER COLUMN `request_date` SET TAGS ('dbx_business_glossary_term' = 'Request Date (REQ_DATE)');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`capex_requisition` ALTER COLUMN `required_by_date` SET TAGS ('dbx_business_glossary_term' = 'Required By Date (REQ_BY_DATE)');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`capex_requisition` ALTER COLUMN `requisition_number` SET TAGS ('dbx_business_glossary_term' = 'CapEx Requisition Number (REQ_NO)');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`capex_requisition` ALTER COLUMN `risk_assessment` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Level (RISK_ASSESSMENT)');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`capex_requisition` ALTER COLUMN `risk_assessment` SET TAGS ('dbx_value_regex' = 'low|medium|high');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`capex_requisition` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount (TAX_AMT)');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`capex_requisition` ALTER COLUMN `tax_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Code (TAX_CD)');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`capex_requisition` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp (UPDATED_TS)');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`capex_requisition` ALTER COLUMN `wbs_element` SET TAGS ('dbx_business_glossary_term' = 'Work Breakdown Structure Element (WBS_ELM)');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`tooling_order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`tooling_order` SET TAGS ('dbx_subdomain' = 'order_execution');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`tooling_order` SET TAGS ('dbx_source_of_record' = 'SAP MM');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`tooling_order` SET TAGS ('dbx_SAP_SRM' = 'true');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`tooling_order` SET TAGS ('dbx_source_system' = 'SAP MM');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`tooling_order` SET TAGS ('dbx_SAP_SRM' = 'true');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`tooling_order` SET TAGS ('dbx_eprocurement_integrated' = 'true');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`tooling_order` SET TAGS ('dbx_commodity_aware' = 'true');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`tooling_order` ALTER COLUMN `capex_requisition_id` SET TAGS ('dbx_business_glossary_term' = 'Capex Requisition Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`tooling_order` ALTER COLUMN `procurement_purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Procurement Purchase Order Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`tooling_order` ALTER COLUMN `supplier_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Contract Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`service_entry_sheet` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`service_entry_sheet` SET TAGS ('dbx_subdomain' = 'invoice_settlement');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`service_entry_sheet` SET TAGS ('dbx_source_of_record' = 'SAP MM');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`service_entry_sheet` SET TAGS ('dbx_SAP_SRM' = 'true');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`service_entry_sheet` SET TAGS ('dbx_source_system' = 'SAP MM');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`service_entry_sheet` SET TAGS ('dbx_SAP_SRM' = 'true');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`service_entry_sheet` SET TAGS ('dbx_eprocurement_integrated' = 'true');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`service_entry_sheet` SET TAGS ('dbx_commodity_aware' = 'true');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`service_entry_sheet` ALTER COLUMN `service_entry_sheet_id` SET TAGS ('dbx_business_glossary_term' = 'Service Entry Sheet ID');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`service_entry_sheet` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`service_entry_sheet` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant ID');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`service_entry_sheet` ALTER COLUMN `procurement_po_line_id` SET TAGS ('dbx_business_glossary_term' = 'Procurement Po Line Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`service_entry_sheet` ALTER COLUMN `procurement_purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Procurement Purchase Order Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`service_entry_sheet` ALTER COLUMN `procurement_supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`service_entry_sheet` ALTER COLUMN `supplier_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Contract Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`service_entry_sheet` ALTER COLUMN `work_center_id` SET TAGS ('dbx_business_glossary_term' = 'Work Center ID');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`service_entry_sheet` ALTER COLUMN `acceptance_status` SET TAGS ('dbx_business_glossary_term' = 'Acceptance Status');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`service_entry_sheet` ALTER COLUMN `acceptance_status` SET TAGS ('dbx_value_regex' = 'pending|accepted|rejected|partial');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`service_entry_sheet` ALTER COLUMN `acceptance_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Acceptance Timestamp');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`service_entry_sheet` ALTER COLUMN `acceptor_name` SET TAGS ('dbx_business_glossary_term' = 'Acceptor Name');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`service_entry_sheet` ALTER COLUMN `account_assignment` SET TAGS ('dbx_business_glossary_term' = 'Account Assignment');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`service_entry_sheet` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`service_entry_sheet` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`service_entry_sheet` ALTER COLUMN `data_governance_ref` SET TAGS ('dbx_business_glossary_term' = 'Data Governance Reference');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`service_entry_sheet` ALTER COLUMN `service_entry_sheet_description` SET TAGS ('dbx_business_glossary_term' = 'Service Description');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`service_entry_sheet` ALTER COLUMN `external_reference_code` SET TAGS ('dbx_business_glossary_term' = 'External Reference ID');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`service_entry_sheet` ALTER COLUMN `invoice_triggered` SET TAGS ('dbx_business_glossary_term' = 'Invoice Triggered Flag');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`service_entry_sheet` ALTER COLUMN `net_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Amount');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`service_entry_sheet` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`service_entry_sheet` ALTER COLUMN `quantity_performed` SET TAGS ('dbx_business_glossary_term' = 'Quantity Performed');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`service_entry_sheet` ALTER COLUMN `service_category` SET TAGS ('dbx_business_glossary_term' = 'Service Category');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`service_entry_sheet` ALTER COLUMN `service_category` SET TAGS ('dbx_value_regex' = 'maintenance|repair|consulting|logistics|installation|other');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`service_entry_sheet` ALTER COLUMN `service_date` SET TAGS ('dbx_business_glossary_term' = 'Service Date');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`service_entry_sheet` ALTER COLUMN `service_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Service End Timestamp');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`service_entry_sheet` ALTER COLUMN `service_entry_sheet_status` SET TAGS ('dbx_business_glossary_term' = 'Service Entry Sheet Status');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`service_entry_sheet` ALTER COLUMN `service_entry_sheet_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|approved|rejected|cancelled|closed');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`service_entry_sheet` ALTER COLUMN `service_line_item` SET TAGS ('dbx_business_glossary_term' = 'Service Line Item Identifier');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`service_entry_sheet` ALTER COLUMN `service_location` SET TAGS ('dbx_business_glossary_term' = 'Service Location');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`service_entry_sheet` ALTER COLUMN `service_order_number` SET TAGS ('dbx_business_glossary_term' = 'Service Order Number');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`service_entry_sheet` ALTER COLUMN `service_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Service Start Timestamp');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`service_entry_sheet` ALTER COLUMN `sheet_number` SET TAGS ('dbx_business_glossary_term' = 'Service Entry Sheet Number');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`service_entry_sheet` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`service_entry_sheet` ALTER COLUMN `tax_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Code');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`service_entry_sheet` ALTER COLUMN `total_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Amount (Gross)');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`service_entry_sheet` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`service_entry_sheet` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'hour|day|service|unit|kg|liter');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`service_entry_sheet` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_price_condition` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_price_condition` SET TAGS ('dbx_subdomain' = 'spend_analytics');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_price_condition` SET TAGS ('dbx_ssot_owner' = 'billing');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_price_condition` SET TAGS ('dbx_ssot_concept' = 'price_condition');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_price_condition` SET TAGS ('dbx_ssot_reference' = 'true');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_price_condition` SET TAGS ('dbx_source_of_record' = 'SAP MM');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_price_condition` SET TAGS ('dbx_SAP_SRM' = 'true');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_price_condition` SET TAGS ('dbx_source_system' = 'SAP MM');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_price_condition` SET TAGS ('dbx_SAP_SRM' = 'true');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_price_condition` SET TAGS ('dbx_eprocurement_integrated' = 'true');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_price_condition` SET TAGS ('dbx_commodity_aware' = 'true');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_price_condition` SET TAGS ('dbx_ssot_role' = 'owner');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_price_condition` ALTER COLUMN `procurement_price_condition_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Key for procurement_price_condition');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_price_condition` ALTER COLUMN `procurement_supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_price_condition` ALTER COLUMN `supplier_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Contract Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_price_condition` ALTER COLUMN `calculation_type` SET TAGS ('dbx_business_glossary_term' = 'Calculation Type');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_price_condition` ALTER COLUMN `condition_type` SET TAGS ('dbx_business_glossary_term' = 'Condition Type');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_price_condition` ALTER COLUMN `condition_value` SET TAGS ('dbx_business_glossary_term' = 'Condition Value');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_price_condition` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_price_condition` ALTER COLUMN `data_governance_ref` SET TAGS ('dbx_business_glossary_term' = 'Data Governance Reference');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_price_condition` ALTER COLUMN `discount_percentage` SET TAGS ('dbx_business_glossary_term' = 'Discount Percentage');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_price_condition` ALTER COLUMN `incoterm_code` SET TAGS ('dbx_business_glossary_term' = 'Incoterm Code');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_price_condition` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_price_condition` ALTER COLUMN `maximum_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Maximum Order Quantity');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_price_condition` ALTER COLUMN `minimum_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_price_condition` ALTER COLUMN `price_basis_quantity` SET TAGS ('dbx_business_glossary_term' = 'Price Basis Quantity');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_price_condition` ALTER COLUMN `price_change_reason` SET TAGS ('dbx_business_glossary_term' = 'Price Change Reason');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_price_condition` ALTER COLUMN `scale_basis` SET TAGS ('dbx_business_glossary_term' = 'Scale Basis');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_price_condition` ALTER COLUMN `scale_quantity_from` SET TAGS ('dbx_business_glossary_term' = 'Scale Quantity From');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_price_condition` ALTER COLUMN `scale_quantity_to` SET TAGS ('dbx_business_glossary_term' = 'Scale Quantity To');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_price_condition` ALTER COLUMN `surcharge_amount` SET TAGS ('dbx_business_glossary_term' = 'Surcharge Amount');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_price_condition` ALTER COLUMN `valid_from_date` SET TAGS ('dbx_business_glossary_term' = 'Valid From Date');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_price_condition` ALTER COLUMN `valid_to_date` SET TAGS ('dbx_business_glossary_term' = 'Valid To Date');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_delivery_schedule` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_delivery_schedule` SET TAGS ('dbx_subdomain' = 'order_execution');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_delivery_schedule` SET TAGS ('dbx_source_of_record' = 'SAP MM');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_delivery_schedule` SET TAGS ('dbx_SAP_SRM' = 'true');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_delivery_schedule` SET TAGS ('dbx_source_system' = 'SAP MM');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_delivery_schedule` SET TAGS ('dbx_SAP_SRM' = 'true');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_delivery_schedule` SET TAGS ('dbx_eprocurement_integrated' = 'true');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_delivery_schedule` SET TAGS ('dbx_commodity_aware' = 'true');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_delivery_schedule` ALTER COLUMN `procurement_delivery_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Key for procurement_delivery_schedule');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_delivery_schedule` ALTER COLUMN `procurement_goods_receipt_id` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt ID');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_delivery_schedule` ALTER COLUMN `procurement_purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_delivery_schedule` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Receiving Plant');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_delivery_schedule` ALTER COLUMN `scheduling_agreement_line_id` SET TAGS ('dbx_business_glossary_term' = 'Scheduling Agreement Line Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_delivery_schedule` ALTER COLUMN `actual_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Date');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_delivery_schedule` ALTER COLUMN `actual_quantity` SET TAGS ('dbx_business_glossary_term' = 'Actual Quantity');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_delivery_schedule` ALTER COLUMN `asn_number` SET TAGS ('dbx_business_glossary_term' = 'ASN Number');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_delivery_schedule` ALTER COLUMN `carrier_name` SET TAGS ('dbx_business_glossary_term' = 'Carrier Name');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_delivery_schedule` ALTER COLUMN `data_governance_ref` SET TAGS ('dbx_business_glossary_term' = 'Data Governance Reference');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_delivery_schedule` ALTER COLUMN `delivery_priority` SET TAGS ('dbx_business_glossary_term' = 'Delivery Priority');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_delivery_schedule` ALTER COLUMN `delivery_status` SET TAGS ('dbx_business_glossary_term' = 'Delivery Status');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_delivery_schedule` ALTER COLUMN `delivery_tolerance_days` SET TAGS ('dbx_business_glossary_term' = 'Delivery Tolerance Days');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_delivery_schedule` ALTER COLUMN `inbound_delivery_number` SET TAGS ('dbx_business_glossary_term' = 'Inbound Delivery Number');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_delivery_schedule` ALTER COLUMN `jit_call_number` SET TAGS ('dbx_business_glossary_term' = 'JIT Call Number');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_delivery_schedule` ALTER COLUMN `on_time_delivery_flag` SET TAGS ('dbx_business_glossary_term' = 'On Time Delivery Flag');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_delivery_schedule` ALTER COLUMN `scheduled_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Date');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_delivery_schedule` ALTER COLUMN `scheduled_quantity` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Quantity');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_delivery_schedule` ALTER COLUMN `shipping_point` SET TAGS ('dbx_business_glossary_term' = 'Shipping Point');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_delivery_schedule` ALTER COLUMN `storage_location_code` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Code');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_delivery_schedule` ALTER COLUMN `unloading_point` SET TAGS ('dbx_business_glossary_term' = 'Unloading Point');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`supplier_nonconformance` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`supplier_nonconformance` SET TAGS ('dbx_subdomain' = 'spend_analytics');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`supplier_nonconformance` SET TAGS ('dbx_source_of_record' = 'SAP MM');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`supplier_nonconformance` SET TAGS ('dbx_SAP_SRM' = 'true');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`supplier_nonconformance` SET TAGS ('dbx_source_system' = 'SAP MM');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`supplier_nonconformance` SET TAGS ('dbx_SAP_SRM' = 'true');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`supplier_nonconformance` SET TAGS ('dbx_eprocurement_integrated' = 'true');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`supplier_nonconformance` SET TAGS ('dbx_commodity_aware' = 'true');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`supplier_nonconformance` ALTER COLUMN `supplier_nonconformance_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Nonconformance ID');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`supplier_nonconformance` ALTER COLUMN `procurement_goods_receipt_id` SET TAGS ('dbx_business_glossary_term' = 'Procurement Goods Receipt Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`supplier_nonconformance` ALTER COLUMN `procurement_po_line_id` SET TAGS ('dbx_business_glossary_term' = 'Procurement Po Line Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`supplier_nonconformance` ALTER COLUMN `procurement_supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`supplier_nonconformance` ALTER COLUMN `closure_status` SET TAGS ('dbx_business_glossary_term' = 'Closure Status');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`supplier_nonconformance` ALTER COLUMN `closure_status` SET TAGS ('dbx_value_regex' = 'open|closed|cancelled|deferred');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`supplier_nonconformance` ALTER COLUMN `closure_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Closure Timestamp');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`supplier_nonconformance` ALTER COLUMN `containment_action` SET TAGS ('dbx_business_glossary_term' = 'Containment Action');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`supplier_nonconformance` ALTER COLUMN `corrective_action_due_date` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Due Date (CAD)');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`supplier_nonconformance` ALTER COLUMN `corrective_action_status` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Status');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`supplier_nonconformance` ALTER COLUMN `corrective_action_status` SET TAGS ('dbx_value_regex' = 'pending|in_progress|completed|failed');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`supplier_nonconformance` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`supplier_nonconformance` ALTER COLUMN `defect_code` SET TAGS ('dbx_business_glossary_term' = 'Defect Code (DC)');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`supplier_nonconformance` ALTER COLUMN `defect_description` SET TAGS ('dbx_business_glossary_term' = 'Defect Description');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`supplier_nonconformance` ALTER COLUMN `detection_point` SET TAGS ('dbx_business_glossary_term' = 'Detection Point (DP)');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`supplier_nonconformance` ALTER COLUMN `detection_point` SET TAGS ('dbx_value_regex' = 'incoming_inspection|line_side|warranty|post_sale');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`supplier_nonconformance` ALTER COLUMN `detection_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Detection Timestamp');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`supplier_nonconformance` ALTER COLUMN `eight_d_report_reference` SET TAGS ('dbx_business_glossary_term' = '8‑D Report Reference');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`supplier_nonconformance` ALTER COLUMN `nonconformance_number` SET TAGS ('dbx_business_glossary_term' = 'Nonconformance Number (NCN)');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`supplier_nonconformance` ALTER COLUMN `part_description` SET TAGS ('dbx_business_glossary_term' = 'Part Description');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`supplier_nonconformance` ALTER COLUMN `part_number` SET TAGS ('dbx_business_glossary_term' = 'Part Number (PN)');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`supplier_nonconformance` ALTER COLUMN `portal_submission_flag` SET TAGS ('dbx_business_glossary_term' = 'Portal Submission');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`supplier_nonconformance` ALTER COLUMN `ppm_count` SET TAGS ('dbx_business_glossary_term' = 'Parts‑Per‑Million (PPM) Count');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`supplier_nonconformance` ALTER COLUMN `rejected_quantity` SET TAGS ('dbx_business_glossary_term' = 'Rejected Quantity');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`supplier_nonconformance` ALTER COLUMN `root_cause_category` SET TAGS ('dbx_business_glossary_term' = 'Root‑Cause Category (RCC)');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`supplier_nonconformance` ALTER COLUMN `root_cause_category` SET TAGS ('dbx_value_regex' = 'design|process|material|supplier|external|unknown');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`supplier_nonconformance` ALTER COLUMN `root_cause_description` SET TAGS ('dbx_business_glossary_term' = 'Root‑Cause Description');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`supplier_nonconformance` ALTER COLUMN `severity_level` SET TAGS ('dbx_business_glossary_term' = 'Severity Level');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`supplier_nonconformance` ALTER COLUMN `severity_level` SET TAGS ('dbx_value_regex' = 'critical|major|minor|warning|info');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`supplier_nonconformance` ALTER COLUMN `total_inspected_quantity` SET TAGS ('dbx_business_glossary_term' = 'Total Inspected Quantity');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`supplier_nonconformance` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`spend_transaction` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`spend_transaction` SET TAGS ('dbx_subdomain' = 'invoice_settlement');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`spend_transaction` SET TAGS ('dbx_source_of_record' = 'SAP MM');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`spend_transaction` SET TAGS ('dbx_SAP_SRM' = 'true');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`spend_transaction` SET TAGS ('dbx_source_system' = 'SAP MM');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`spend_transaction` SET TAGS ('dbx_SAP_SRM' = 'true');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`spend_transaction` SET TAGS ('dbx_eprocurement_integrated' = 'true');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`spend_transaction` SET TAGS ('dbx_commodity_aware' = 'true');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`spend_transaction` ALTER COLUMN `spend_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Spend Transaction ID');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`spend_transaction` ALTER COLUMN `equipment_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Registry Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`spend_transaction` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`spend_transaction` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice ID');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`spend_transaction` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant ID');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`spend_transaction` ALTER COLUMN `procurement_purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order ID');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`spend_transaction` ALTER COLUMN `procurement_supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`spend_transaction` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`spend_transaction` ALTER COLUMN `purchase_requisition_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Requisition ID');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`spend_transaction` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`spend_transaction` ALTER COLUMN `sku_master_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Master Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`spend_transaction` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By ID');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`spend_transaction` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`spend_transaction` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`spend_transaction` ALTER COLUMN `spend_category_id` SET TAGS ('dbx_business_glossary_term' = 'Spend Category Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`spend_transaction` ALTER COLUMN `spend_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By ID');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`spend_transaction` ALTER COLUMN `spend_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`spend_transaction` ALTER COLUMN `spend_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`spend_transaction` ALTER COLUMN `supplier_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Contract ID');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`spend_transaction` ALTER COLUMN `supplier_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Invoice Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`spend_transaction` ALTER COLUMN `vehicle_order_id` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Order Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`spend_transaction` ALTER COLUMN `accounting_date` SET TAGS ('dbx_business_glossary_term' = 'Accounting Date');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`spend_transaction` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`spend_transaction` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'approved|rejected|pending');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`spend_transaction` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`spend_transaction` ALTER COLUMN `commodity_code` SET TAGS ('dbx_business_glossary_term' = 'Commodity Code');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`spend_transaction` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`spend_transaction` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`spend_transaction` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`spend_transaction` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`spend_transaction` ALTER COLUMN `data_governance_ref` SET TAGS ('dbx_business_glossary_term' = 'Data Governance Reference');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`spend_transaction` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`spend_transaction` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`spend_transaction` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`spend_transaction` ALTER COLUMN `gross_amount` SET TAGS ('dbx_business_glossary_term' = 'Gross Amount');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`spend_transaction` ALTER COLUMN `invoice_date` SET TAGS ('dbx_business_glossary_term' = 'Invoice Date');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`spend_transaction` ALTER COLUMN `is_blocked` SET TAGS ('dbx_business_glossary_term' = 'Is Blocked');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`spend_transaction` ALTER COLUMN `is_service_line` SET TAGS ('dbx_business_glossary_term' = 'Is Service Line');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`spend_transaction` ALTER COLUMN `is_tax_included` SET TAGS ('dbx_business_glossary_term' = 'Is Tax Included');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`spend_transaction` ALTER COLUMN `net_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Amount');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`spend_transaction` ALTER COLUMN `payment_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Date');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`spend_transaction` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`spend_transaction` ALTER COLUMN `project_code` SET TAGS ('dbx_business_glossary_term' = 'Project Code');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`spend_transaction` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`spend_transaction` ALTER COLUMN `receipt_number` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt Number');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`spend_transaction` ALTER COLUMN `source_system_load_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Source System Load Timestamp');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`spend_transaction` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`spend_transaction` ALTER COLUMN `tax_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Code');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`spend_transaction` ALTER COLUMN `transaction_number` SET TAGS ('dbx_business_glossary_term' = 'Transaction Number');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`spend_transaction` ALTER COLUMN `transaction_status` SET TAGS ('dbx_business_glossary_term' = 'Transaction Status');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`spend_transaction` ALTER COLUMN `transaction_status` SET TAGS ('dbx_value_regex' = 'posted|pending|cancelled|reversed|draft|approved');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`spend_transaction` ALTER COLUMN `transaction_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Transaction Timestamp');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`spend_transaction` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`spend_transaction` ALTER COLUMN `unit_price` SET TAGS ('dbx_business_glossary_term' = 'Unit Price');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`spend_transaction` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`savings_initiative` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`savings_initiative` SET TAGS ('dbx_subdomain' = 'sourcing_contracting');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`savings_initiative` SET TAGS ('dbx_source_of_record' = 'SAP MM');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`savings_initiative` SET TAGS ('dbx_SAP_SRM' = 'true');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`savings_initiative` SET TAGS ('dbx_source_system' = 'SAP MM');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`savings_initiative` SET TAGS ('dbx_SAP_SRM' = 'true');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`savings_initiative` SET TAGS ('dbx_eprocurement_integrated' = 'true');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`savings_initiative` SET TAGS ('dbx_commodity_aware' = 'true');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`savings_initiative` ALTER COLUMN `savings_initiative_id` SET TAGS ('dbx_business_glossary_term' = 'Savings Initiative ID');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`savings_initiative` ALTER COLUMN `procurement_supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`savings_initiative` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Buyer ID');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`savings_initiative` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`savings_initiative` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`savings_initiative` ALTER COLUMN `savings_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Buyer ID');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`savings_initiative` ALTER COLUMN `savings_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`savings_initiative` ALTER COLUMN `savings_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`savings_initiative` ALTER COLUMN `sourcing_event_id` SET TAGS ('dbx_business_glossary_term' = 'Sourcing Event Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`savings_initiative` ALTER COLUMN `spend_category_id` SET TAGS ('dbx_business_glossary_term' = 'Spend Category Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`savings_initiative` ALTER COLUMN `supplier_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Contract Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`savings_initiative` ALTER COLUMN `actual_savings_amount` SET TAGS ('dbx_business_glossary_term' = 'Actual Savings Amount (USD)');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`savings_initiative` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`savings_initiative` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By (Employee ID)');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`savings_initiative` ALTER COLUMN `baseline_spend` SET TAGS ('dbx_business_glossary_term' = 'Baseline Spend (USD)');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`savings_initiative` ALTER COLUMN `commodity` SET TAGS ('dbx_business_glossary_term' = 'Commodity');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`savings_initiative` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`savings_initiative` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`savings_initiative` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`savings_initiative` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`savings_initiative` ALTER COLUMN `data_governance_ref` SET TAGS ('dbx_business_glossary_term' = 'Data Governance Reference');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`savings_initiative` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`savings_initiative` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`savings_initiative` ALTER COLUMN `initiative_name` SET TAGS ('dbx_business_glossary_term' = 'Savings Initiative Name');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`savings_initiative` ALTER COLUMN `initiative_number` SET TAGS ('dbx_business_glossary_term' = 'Savings Initiative Number');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`savings_initiative` ALTER COLUMN `initiative_type` SET TAGS ('dbx_business_glossary_term' = 'Savings Initiative Type');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`savings_initiative` ALTER COLUMN `initiative_type` SET TAGS ('dbx_value_regex' = 'hard_savings|cost_avoidance|payment_term_improvement|process_improvement');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`savings_initiative` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Initiative Notes');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`savings_initiative` ALTER COLUMN `plant_code` SET TAGS ('dbx_business_glossary_term' = 'Plant Code');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`savings_initiative` ALTER COLUMN `program_year` SET TAGS ('dbx_business_glossary_term' = 'Program Year');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`savings_initiative` ALTER COLUMN `region_code` SET TAGS ('dbx_business_glossary_term' = 'Region Code (ISO 3166‑3)');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`savings_initiative` ALTER COLUMN `region_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`savings_initiative` ALTER COLUMN `savings_initiative_status` SET TAGS ('dbx_business_glossary_term' = 'Savings Initiative Status');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`savings_initiative` ALTER COLUMN `savings_initiative_status` SET TAGS ('dbx_value_regex' = 'identified|approved|in_negotiation|realized|cancelled');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`savings_initiative` ALTER COLUMN `savings_validation_method` SET TAGS ('dbx_business_glossary_term' = 'Savings Validation Method');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`savings_initiative` ALTER COLUMN `savings_validation_method` SET TAGS ('dbx_value_regex' = 'internal_audit|external_audit|financial_system|management_review');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`savings_initiative` ALTER COLUMN `target_savings_amount` SET TAGS ('dbx_business_glossary_term' = 'Target Savings Amount (USD)');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`savings_initiative` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`payment_run` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`payment_run` SET TAGS ('dbx_subdomain' = 'invoice_settlement');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`payment_run` SET TAGS ('dbx_source_of_record' = 'SAP MM');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`payment_run` SET TAGS ('dbx_SAP_SRM' = 'true');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`payment_run` SET TAGS ('dbx_source_system' = 'SAP MM');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`payment_run` SET TAGS ('dbx_SAP_SRM' = 'true');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`payment_run` SET TAGS ('dbx_eprocurement_integrated' = 'true');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`payment_run` SET TAGS ('dbx_commodity_aware' = 'true');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`payment_run` ALTER COLUMN `payment_run_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Run ID');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`payment_run` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`payment_run` ALTER COLUMN `procurement_supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`payment_run` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Run Approval Status');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`payment_run` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'approved|pending|rejected');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`payment_run` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Payment Run Approved By');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`payment_run` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Payment Run Approved Timestamp');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`payment_run` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Payment Run Batch ID');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`payment_run` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Payment Run Comments');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`payment_run` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`payment_run` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`payment_run` ALTER COLUMN `currency_rate` SET TAGS ('dbx_business_glossary_term' = 'Currency Exchange Rate');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`payment_run` ALTER COLUMN `data_governance_ref` SET TAGS ('dbx_business_glossary_term' = 'Data Governance Reference');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`payment_run` ALTER COLUMN `payment_run_description` SET TAGS ('dbx_business_glossary_term' = 'Payment Run Description');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`payment_run` ALTER COLUMN `discount_taken_flag` SET TAGS ('dbx_business_glossary_term' = 'Discount Taken Flag');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`payment_run` ALTER COLUMN `execution_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Execution End Timestamp');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`payment_run` ALTER COLUMN `execution_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Execution Start Timestamp');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`payment_run` ALTER COLUMN `fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Payment Run Fee Amount');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`payment_run` ALTER COLUMN `is_automated` SET TAGS ('dbx_business_glossary_term' = 'Is Automated Flag');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`payment_run` ALTER COLUMN `number_of_invoices` SET TAGS ('dbx_business_glossary_term' = 'Number of Invoices');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`payment_run` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`payment_run` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'ACH|wire|check|virtual_card|direct_deposit');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`payment_run` ALTER COLUMN `processing_time_seconds` SET TAGS ('dbx_business_glossary_term' = 'Processing Time (Seconds)');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`payment_run` ALTER COLUMN `reference` SET TAGS ('dbx_business_glossary_term' = 'External Payment Run Reference');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`payment_run` ALTER COLUMN `run_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Run Date');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`payment_run` ALTER COLUMN `run_number` SET TAGS ('dbx_business_glossary_term' = 'Payment Run Number');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`payment_run` ALTER COLUMN `run_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Run Status');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`payment_run` ALTER COLUMN `run_status` SET TAGS ('dbx_value_regex' = 'scheduled|in_progress|completed|failed|cancelled');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`payment_run` ALTER COLUMN `run_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Payment Run Timestamp');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`payment_run` ALTER COLUMN `run_type` SET TAGS ('dbx_business_glossary_term' = 'Payment Run Type');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`payment_run` ALTER COLUMN `run_type` SET TAGS ('dbx_value_regex' = 'regular|ad_hoc|correction');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`payment_run` ALTER COLUMN `settlement_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Run Settlement Date');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`payment_run` ALTER COLUMN `settlement_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Run Settlement Status');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`payment_run` ALTER COLUMN `settlement_status` SET TAGS ('dbx_value_regex' = 'pending|settled|failed');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`payment_run` ALTER COLUMN `status_reason` SET TAGS ('dbx_business_glossary_term' = 'Payment Run Status Reason');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`payment_run` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Payment Run Tax Amount');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`payment_run` ALTER COLUMN `total_discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Discount Amount');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`payment_run` ALTER COLUMN `total_discount_percent` SET TAGS ('dbx_business_glossary_term' = 'Total Discount Percent');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`payment_run` ALTER COLUMN `total_gross_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Gross Amount');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`payment_run` ALTER COLUMN `total_invoices_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Invoices Amount');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`payment_run` ALTER COLUMN `total_net_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Net Amount');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`payment_run` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`payment_run` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`approval` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`approval` SET TAGS ('dbx_subdomain' = 'order_execution');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`approval` SET TAGS ('dbx_source_of_record' = 'SAP MM');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`approval` SET TAGS ('dbx_SAP_SRM' = 'true');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`approval` SET TAGS ('dbx_source_system' = 'SAP MM');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`approval` SET TAGS ('dbx_SAP_SRM' = 'true');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`approval` SET TAGS ('dbx_eprocurement_integrated' = 'true');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`approval` SET TAGS ('dbx_commodity_aware' = 'true');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`approval` ALTER COLUMN `approval_id` SET TAGS ('dbx_business_glossary_term' = 'Procurement Approval ID');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`approval` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Delegated To ID');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`approval` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`approval` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`approval` ALTER COLUMN `approval_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approver ID');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`approval` ALTER COLUMN `approval_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`approval` ALTER COLUMN `approval_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`approval` ALTER COLUMN `approval_group_id` SET TAGS ('dbx_business_glossary_term' = 'Approval Group ID');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`approval` ALTER COLUMN `auto_approval_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Auto-Approval Rule ID');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`approval` ALTER COLUMN `primary_approval_delegated_to_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Delegated To ID');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`approval` ALTER COLUMN `primary_approval_delegated_to_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`approval` ALTER COLUMN `primary_approval_delegated_to_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`approval` ALTER COLUMN `procurement_document_id` SET TAGS ('dbx_business_glossary_term' = 'Document Identifier');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`approval` ALTER COLUMN `action` SET TAGS ('dbx_business_glossary_term' = 'Approval Action');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`approval` ALTER COLUMN `action` SET TAGS ('dbx_value_regex' = 'approved|rejected|escalated|withdrawn');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`approval` ALTER COLUMN `approval_number` SET TAGS ('dbx_business_glossary_term' = 'Approval Number');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`approval` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`approval` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|in_progress|completed|cancelled');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`approval` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`approval` ALTER COLUMN `approved_amount` SET TAGS ('dbx_business_glossary_term' = 'Approved Spend Amount');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`approval` ALTER COLUMN `approver_role` SET TAGS ('dbx_business_glossary_term' = 'Approver Role');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`approval` ALTER COLUMN `approver_role` SET TAGS ('dbx_value_regex' = 'procurement_manager|finance|legal|executive|operations|supply_chain');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`approval` ALTER COLUMN `attachment_flag` SET TAGS ('dbx_business_glossary_term' = 'Attachment Flag');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`approval` ALTER COLUMN `attachment_url` SET TAGS ('dbx_business_glossary_term' = 'Attachment URL');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`approval` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Approval Comments');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`approval` ALTER COLUMN `compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Required Flag');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`approval` ALTER COLUMN `compliance_requirements` SET TAGS ('dbx_business_glossary_term' = 'Compliance Requirements');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`approval` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`approval` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`approval` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '[A-Z]{3}');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`approval` ALTER COLUMN `data_governance_ref` SET TAGS ('dbx_business_glossary_term' = 'Data Governance Reference');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`approval` ALTER COLUMN `deadline` SET TAGS ('dbx_business_glossary_term' = 'Approval Deadline');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`approval` ALTER COLUMN `decision_reason` SET TAGS ('dbx_business_glossary_term' = 'Decision Reason');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`approval` ALTER COLUMN `delegation_flag` SET TAGS ('dbx_business_glossary_term' = 'Delegation Flag');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`approval` ALTER COLUMN `document_type` SET TAGS ('dbx_business_glossary_term' = 'Document Type');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`approval` ALTER COLUMN `document_type` SET TAGS ('dbx_value_regex' = 'requisition|purchase_order|contract|capex');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`approval` ALTER COLUMN `escalation_reason` SET TAGS ('dbx_business_glossary_term' = 'Escalation Reason');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`approval` ALTER COLUMN `expiration_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Expiration Timestamp');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`approval` ALTER COLUMN `is_auto_approved` SET TAGS ('dbx_business_glossary_term' = 'Auto-Approved Flag');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`approval` ALTER COLUMN `is_critical` SET TAGS ('dbx_business_glossary_term' = 'Critical Approval Flag');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`approval` ALTER COLUMN `is_final_approval` SET TAGS ('dbx_business_glossary_term' = 'Final Approval Flag');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`approval` ALTER COLUMN `policy_code` SET TAGS ('dbx_business_glossary_term' = 'Approval Policy Code');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`approval` ALTER COLUMN `policy_version` SET TAGS ('dbx_business_glossary_term' = 'Approval Policy Version');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`approval` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Risk Score');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`approval` ALTER COLUMN `spend_amount` SET TAGS ('dbx_business_glossary_term' = 'Requested Spend Amount');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`approval` ALTER COLUMN `step_sequence` SET TAGS ('dbx_business_glossary_term' = 'Approval Step Sequence');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`approval` ALTER COLUMN `threshold_amount` SET TAGS ('dbx_business_glossary_term' = 'Approval Threshold Amount');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`approval` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`vendor` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`vendor` SET TAGS ('dbx_subdomain' = 'supplier_management');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`vendor` SET TAGS ('dbx_source_of_record' = 'SAP MM');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`vendor` SET TAGS ('dbx_SAP_SRM' = 'true');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`vendor` SET TAGS ('dbx_source_system' = 'SAP MM');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`vendor` SET TAGS ('dbx_SAP_SRM' = 'true');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`vendor` SET TAGS ('dbx_eprocurement_integrated' = 'true');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`vendor` SET TAGS ('dbx_commodity_aware' = 'true');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`vendor` ALTER COLUMN `address_line1` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`vendor` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`vendor` ALTER COLUMN `address_line2` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`vendor` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`vendor` ALTER COLUMN `bank_account_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`vendor` ALTER COLUMN `bank_account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`vendor` ALTER COLUMN `postal_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`vendor` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`vendor` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`vendor` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`vendor` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`vendor` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`vendor` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`vendor` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`vendor` ALTER COLUMN `swift_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`vendor` ALTER COLUMN `swift_code` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`program_supplier_contract` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`program_supplier_contract` SET TAGS ('dbx_subdomain' = 'sourcing_contracting');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`program_supplier_contract` SET TAGS ('dbx_association_edges' = 'engineering.vehicle_program,procurement.supplier');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`program_supplier_contract` SET TAGS ('dbx_source_of_record' = 'SAP MM');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`program_supplier_contract` SET TAGS ('dbx_SAP_SRM' = 'true');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`program_supplier_contract` SET TAGS ('dbx_source_system' = 'SAP MM');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`program_supplier_contract` SET TAGS ('dbx_SAP_SRM' = 'true');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`program_supplier_contract` SET TAGS ('dbx_eprocurement_integrated' = 'true');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`program_supplier_contract` SET TAGS ('dbx_commodity_aware' = 'true');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`program_supplier_contract` ALTER COLUMN `supplier_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Contract Id (Foreign Key)');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`program_supplier_contract` ALTER COLUMN `data_governance_ref` SET TAGS ('dbx_business_glossary_term' = 'Data Governance Reference');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_supply_agreement` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_supply_agreement` SET TAGS ('dbx_subdomain' = 'sourcing_contracting');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_supply_agreement` SET TAGS ('dbx_association_edges' = 'procurement.supplier,asset.spare_parts_catalog');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_supply_agreement` SET TAGS ('dbx_source_of_record' = 'SAP MM');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_supply_agreement` SET TAGS ('dbx_SAP_SRM' = 'true');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_supply_agreement` SET TAGS ('dbx_source_system' = 'SAP MM');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_supply_agreement` SET TAGS ('dbx_SAP_SRM' = 'true');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_supply_agreement` SET TAGS ('dbx_eprocurement_integrated' = 'true');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_supply_agreement` SET TAGS ('dbx_commodity_aware' = 'true');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_supply_agreement` ALTER COLUMN `procurement_supply_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Supply Agreement - Supply Agreement Id');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_supply_agreement` ALTER COLUMN `procurement_supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supply Agreement - Supplier Id');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_supply_agreement` ALTER COLUMN `spare_parts_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Supply Agreement - Spare Parts Catalog Id');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_supply_agreement` ALTER COLUMN `agreement_number` SET TAGS ('dbx_business_glossary_term' = 'Agreement Number');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_supply_agreement` ALTER COLUMN `agreement_type` SET TAGS ('dbx_business_glossary_term' = 'Agreement Type');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_supply_agreement` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_supply_agreement` ALTER COLUMN `data_governance_ref` SET TAGS ('dbx_business_glossary_term' = 'Data Governance Reference');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_supply_agreement` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'End Date');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_supply_agreement` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_supply_agreement` ALTER COLUMN `minimum_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_supply_agreement` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Start Date');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_supply_agreement` ALTER COLUMN `procurement_supply_agreement_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_supply_agreement` ALTER COLUMN `total_value` SET TAGS ('dbx_business_glossary_term' = 'Total Value');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_supply_agreement` ALTER COLUMN `unit_price` SET TAGS ('dbx_business_glossary_term' = 'Unit Price');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`supplier_regulatory_compliance` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`supplier_regulatory_compliance` SET TAGS ('dbx_subdomain' = 'supplier_management');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`supplier_regulatory_compliance` SET TAGS ('dbx_association_edges' = 'procurement.supplier,compliance.regulatory_requirement');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`supplier_regulatory_compliance` SET TAGS ('dbx_source_of_record' = 'SAP MM');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`supplier_regulatory_compliance` SET TAGS ('dbx_SAP_SRM' = 'true');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`supplier_regulatory_compliance` SET TAGS ('dbx_source_system' = 'SAP MM');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`supplier_regulatory_compliance` SET TAGS ('dbx_SAP_SRM' = 'true');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`supplier_regulatory_compliance` SET TAGS ('dbx_eprocurement_integrated' = 'true');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`supplier_regulatory_compliance` SET TAGS ('dbx_commodity_aware' = 'true');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`supplier_regulatory_compliance` ALTER COLUMN `supplier_regulatory_compliance_id` SET TAGS ('dbx_business_glossary_term' = 'Supplierregulatorycompliance - Supplier Regulatory Compliance Id');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`supplier_regulatory_compliance` ALTER COLUMN `procurement_supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplierregulatorycompliance - Supplier Id');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`supplier_regulatory_compliance` ALTER COLUMN `regulatory_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Supplierregulatorycompliance - Regulatory Requirement Id');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`supplier_regulatory_compliance` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`supplier_regulatory_compliance` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`supplier_regulatory_compliance` ALTER COLUMN `certification_number` SET TAGS ('dbx_business_glossary_term' = 'Certification Number');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`supplier_regulatory_compliance` ALTER COLUMN `compliance_deadline` SET TAGS ('dbx_business_glossary_term' = 'Compliance Deadline');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`supplier_regulatory_compliance` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`supplier_regulatory_compliance` ALTER COLUMN `compliance_type` SET TAGS ('dbx_business_glossary_term' = 'Compliance Type');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`supplier_regulatory_compliance` ALTER COLUMN `digital_certificate_url` SET TAGS ('dbx_business_glossary_term' = 'Digital Certificate URL');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`supplier_regulatory_compliance` ALTER COLUMN `evidence_document_path` SET TAGS ('dbx_business_glossary_term' = 'Evidence Document');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`supplier_regulatory_compliance` ALTER COLUMN `issuing_authority` SET TAGS ('dbx_business_glossary_term' = 'Issuing Authority');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`supplier_regulatory_compliance` ALTER COLUMN `last_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Last Audit Date');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`supplier_regulatory_compliance` ALTER COLUMN `valid_from_date` SET TAGS ('dbx_business_glossary_term' = 'Valid From Date');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`supplier_regulatory_compliance` ALTER COLUMN `valid_to_date` SET TAGS ('dbx_business_glossary_term' = 'Valid To Date');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_document` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_document` SET TAGS ('dbx_subdomain' = 'spend_analytics');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_document` SET TAGS ('dbx_ssot_owner' = 'engineering');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_document` SET TAGS ('dbx_ssot_concept' = 'document');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_document` SET TAGS ('dbx_ssot_reference' = 'true');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_document` SET TAGS ('dbx_source_of_record' = 'SAP MM');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_document` SET TAGS ('dbx_SAP_SRM' = 'true');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_document` SET TAGS ('dbx_source_system' = 'SAP MM');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_document` SET TAGS ('dbx_SAP_SRM' = 'true');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_document` SET TAGS ('dbx_eprocurement_integrated' = 'true');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_document` SET TAGS ('dbx_commodity_aware' = 'true');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_document` SET TAGS ('dbx_status' = 'superseded');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_document` ALTER COLUMN `procurement_document_id` SET TAGS ('dbx_business_glossary_term' = 'Procurement Document Identifier');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_document` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Id');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_document` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_document` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_document` ALTER COLUMN `predecessor_procurement_document_id` SET TAGS ('dbx_business_glossary_term' = 'Predecessor Procurement Document Id');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_document` ALTER COLUMN `predecessor_procurement_document_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_document` ALTER COLUMN `procurement_supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_document` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_document` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Level');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_document` ALTER COLUMN `contract_term_months` SET TAGS ('dbx_business_glossary_term' = 'Contract Term Months');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_document` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_document` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_document` ALTER COLUMN `data_governance_ref` SET TAGS ('dbx_business_glossary_term' = 'Data Governance Reference');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_document` ALTER COLUMN `procurement_document_description` SET TAGS ('dbx_business_glossary_term' = 'Description');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_document` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_document` ALTER COLUMN `discount_rate` SET TAGS ('dbx_business_glossary_term' = 'Discount Rate');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_document` ALTER COLUMN `document_number` SET TAGS ('dbx_business_glossary_term' = 'Document Number');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_document` ALTER COLUMN `document_status` SET TAGS ('dbx_business_glossary_term' = 'Document Status');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_document` ALTER COLUMN `document_type` SET TAGS ('dbx_business_glossary_term' = 'Document Type');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_document` ALTER COLUMN `document_version` SET TAGS ('dbx_business_glossary_term' = 'Document Version');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_document` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_document` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_document` ALTER COLUMN `file_checksum` SET TAGS ('dbx_business_glossary_term' = 'File Checksum');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_document` ALTER COLUMN `file_path` SET TAGS ('dbx_business_glossary_term' = 'File Path');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_document` ALTER COLUMN `issue_date` SET TAGS ('dbx_business_glossary_term' = 'Issue Date');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_document` ALTER COLUMN `net_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Amount');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_document` ALTER COLUMN `payment_due_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Due Date');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_document` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_document` ALTER COLUMN `procurement_category` SET TAGS ('dbx_business_glossary_term' = 'Procurement Category');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_document` ALTER COLUMN `received_date` SET TAGS ('dbx_business_glossary_term' = 'Received Date');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_document` ALTER COLUMN `renewal_flag` SET TAGS ('dbx_business_glossary_term' = 'Renewal Flag');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_document` ALTER COLUMN `renewal_notice_period_days` SET TAGS ('dbx_business_glossary_term' = 'Renewal Notice Period Days');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_document` ALTER COLUMN `retention_period_days` SET TAGS ('dbx_business_glossary_term' = 'Retention Period Days');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_document` ALTER COLUMN `signed_by` SET TAGS ('dbx_business_glossary_term' = 'Signed By');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_document` ALTER COLUMN `signed_by` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_document` ALTER COLUMN `signed_by` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_document` ALTER COLUMN `signed_date` SET TAGS ('dbx_business_glossary_term' = 'Signed Date');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_document` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_document` ALTER COLUMN `tax_rate` SET TAGS ('dbx_business_glossary_term' = 'Tax Rate');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_document` ALTER COLUMN `total_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Amount');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`procurement_document` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`approval_group` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`approval_group` SET TAGS ('dbx_subdomain' = 'order_execution');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`approval_group` SET TAGS ('dbx_source_of_record' = 'SAP MM');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`approval_group` SET TAGS ('dbx_SAP_SRM' = 'true');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`approval_group` SET TAGS ('dbx_source_system' = 'SAP MM');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`approval_group` SET TAGS ('dbx_SAP_SRM' = 'true');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`approval_group` SET TAGS ('dbx_eprocurement_integrated' = 'true');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`approval_group` SET TAGS ('dbx_commodity_aware' = 'true');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`approval_group` ALTER COLUMN `approval_group_id` SET TAGS ('dbx_business_glossary_term' = 'Approval Group Identifier');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`approval_group` ALTER COLUMN `parent_approval_group_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Approval Group Id');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`approval_group` ALTER COLUMN `parent_approval_group_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`approval_group` ALTER COLUMN `approval_level` SET TAGS ('dbx_business_glossary_term' = 'Approval Level');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`approval_group` ALTER COLUMN `approval_threshold_amount` SET TAGS ('dbx_business_glossary_term' = 'Approval Threshold Amount');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`approval_group` ALTER COLUMN `approval_group_code` SET TAGS ('dbx_business_glossary_term' = 'Code');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`approval_group` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`approval_group` ALTER COLUMN `data_governance_ref` SET TAGS ('dbx_business_glossary_term' = 'Data Governance Reference');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`approval_group` ALTER COLUMN `department` SET TAGS ('dbx_business_glossary_term' = 'Department');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`approval_group` ALTER COLUMN `approval_group_description` SET TAGS ('dbx_business_glossary_term' = 'Description');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`approval_group` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`approval_group` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`approval_group` ALTER COLUMN `escalation_policy` SET TAGS ('dbx_business_glossary_term' = 'Escalation Policy');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`approval_group` ALTER COLUMN `is_system_defined` SET TAGS ('dbx_business_glossary_term' = 'Is System Defined');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`approval_group` ALTER COLUMN `max_approvers` SET TAGS ('dbx_business_glossary_term' = 'Max Approvers');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`approval_group` ALTER COLUMN `approval_group_name` SET TAGS ('dbx_business_glossary_term' = 'Name');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`approval_group` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`approval_group` ALTER COLUMN `region` SET TAGS ('dbx_business_glossary_term' = 'Region');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`approval_group` ALTER COLUMN `requires_multi_approval` SET TAGS ('dbx_business_glossary_term' = 'Requires Multi Approval');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`approval_group` ALTER COLUMN `approval_group_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`approval_group` ALTER COLUMN `approval_group_type` SET TAGS ('dbx_business_glossary_term' = 'Type');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`approval_group` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`approval_group` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`auto_approval_rule` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`auto_approval_rule` SET TAGS ('dbx_subdomain' = 'order_execution');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`auto_approval_rule` SET TAGS ('dbx_source_of_record' = 'SAP MM');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`auto_approval_rule` SET TAGS ('dbx_SAP_SRM' = 'true');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`auto_approval_rule` SET TAGS ('dbx_source_system' = 'SAP MM');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`auto_approval_rule` SET TAGS ('dbx_SAP_SRM' = 'true');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`auto_approval_rule` SET TAGS ('dbx_eprocurement_integrated' = 'true');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`auto_approval_rule` SET TAGS ('dbx_commodity_aware' = 'true');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`auto_approval_rule` ALTER COLUMN `auto_approval_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Auto Approval Rule Identifier');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`auto_approval_rule` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Id');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`auto_approval_rule` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`auto_approval_rule` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`auto_approval_rule` ALTER COLUMN `superseded_auto_approval_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded Auto Approval Rule Id');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`auto_approval_rule` ALTER COLUMN `superseded_auto_approval_rule_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`auto_approval_rule` ALTER COLUMN `applies_to_purchase_category` SET TAGS ('dbx_business_glossary_term' = 'Applies To Purchase Category');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`auto_approval_rule` ALTER COLUMN `applies_to_supplier_segment` SET TAGS ('dbx_business_glossary_term' = 'Applies To Supplier Segment');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`auto_approval_rule` ALTER COLUMN `approval_level` SET TAGS ('dbx_business_glossary_term' = 'Approval Level');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`auto_approval_rule` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`auto_approval_rule` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`auto_approval_rule` ALTER COLUMN `data_governance_ref` SET TAGS ('dbx_business_glossary_term' = 'Data Governance Reference');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`auto_approval_rule` ALTER COLUMN `auto_approval_rule_description` SET TAGS ('dbx_business_glossary_term' = 'Description');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`auto_approval_rule` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`auto_approval_rule` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`auto_approval_rule` ALTER COLUMN `escalation_time_hours` SET TAGS ('dbx_business_glossary_term' = 'Escalation Time Hours');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`auto_approval_rule` ALTER COLUMN `execution_count` SET TAGS ('dbx_business_glossary_term' = 'Execution Count');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`auto_approval_rule` ALTER COLUMN `is_mandatory` SET TAGS ('dbx_business_glossary_term' = 'Is Mandatory');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`auto_approval_rule` ALTER COLUMN `last_executed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Executed Timestamp');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`auto_approval_rule` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`auto_approval_rule` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Priority');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`auto_approval_rule` ALTER COLUMN `rule_code` SET TAGS ('dbx_business_glossary_term' = 'Rule Code');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`auto_approval_rule` ALTER COLUMN `rule_name` SET TAGS ('dbx_business_glossary_term' = 'Rule Name');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`auto_approval_rule` ALTER COLUMN `rule_type` SET TAGS ('dbx_business_glossary_term' = 'Rule Type');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`auto_approval_rule` ALTER COLUMN `auto_approval_rule_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`auto_approval_rule` ALTER COLUMN `threshold_value` SET TAGS ('dbx_business_glossary_term' = 'Threshold Value');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`auto_approval_rule` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`eprocurement_portal` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`eprocurement_portal` SET TAGS ('dbx_subdomain' = 'sourcing_contracting');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`eprocurement_portal` ALTER COLUMN `eprocurement_portal_id` SET TAGS ('dbx_business_glossary_term' = 'Eprocurement Portal Identifier');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`eprocurement_portal` ALTER COLUMN `parent_eprocurement_portal_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`eprocurement_portal` ALTER COLUMN `annual_license_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`eprocurement_portal` ALTER COLUMN `annual_spend_limit` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`eprocurement_portal` ALTER COLUMN `api_endpoint_url` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`eprocurement_portal` ALTER COLUMN `max_po_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`eprocurement_portal` ALTER COLUMN `po_approval_threshold` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`eprocurement_portal` ALTER COLUMN `portal_owner_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`eprocurement_portal` ALTER COLUMN `portal_owner_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`eprocurement_portal` ALTER COLUMN `portal_url` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`eprocurement_portal` ALTER COLUMN `technical_contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_automotive_v1`.`procurement`.`eprocurement_portal` ALTER COLUMN `technical_contact_email` SET TAGS ('dbx_pii_email' = 'true');
