-- Schema for Domain: order | Business: Genomics Biotech | Version: v1_ecm
-- Generated on: 2026-05-06 13:04:43

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `genomics_biotech_ecm`.`order` COMMENT 'Manages the complete commercial order lifecycle — quotes, sales orders, fulfillment instructions, shipment tracking, returns, and customer acceptance — for instruments, reagents, consumables, sequencing services, and software. Integrates SAP SD for order-to-cash processing and Salesforce CRM for opportunity-to-order handoff. SSOT for order status, SLA-driven TAT commitments, and delivery records.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`order`.`header` (
    `header_id` BIGINT COMMENT 'Primary key for header',
    `account_id` BIGINT COMMENT 'Foreign key reference to the party (location, facility, or contact) where the order should be physically delivered. May differ from bill-to party for multi-site organizations.',
    `approval_id` BIGINT COMMENT 'Foreign key linking to regulatory.regulatory_approval. Business justification: Orders for IVD/regulated genomics products must reference the regulatory approval under which theyre sold for market authorization compliance, export documentation, labeling requirements, and revenue',
    `bill_to_party_account_id` BIGINT COMMENT 'Foreign key reference to the party responsible for payment. Invoices are sent to this party. May differ from ship-to party for centralized billing.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Biotech organizations with matrix structures allocate order revenue/costs to requesting department cost centers for internal chargeback and project accounting. Enables P&L reporting by research progra',
    `created_by_user_employee_id` BIGINT COMMENT 'System user ID of the person or service account that created this order record. Audit trail for accountability.',
    `opportunity_id` BIGINT COMMENT 'Salesforce CRM opportunity identifier representing the sales opportunity that converted into this order. Enables opportunity-to-order traceability.',
    `customer_account_id` BIGINT COMMENT 'Foreign key reference to the customer account that placed this order. Links to the customer master data entity.',
    `employee_id` BIGINT COMMENT 'Foreign key reference to the sales representative or account manager who owns this customer relationship and order. Used for commission calculation and performance tracking.',
    `last_modified_by_user_employee_id` BIGINT COMMENT 'System user ID of the person or service account that last modified this order record. Audit trail for change tracking.',
    `model_id` BIGINT COMMENT 'Foreign key linking to instrument.instrument_model. Business justification: Capital equipment orders for sequencing instruments require instrument model reference for pricing validation, configuration management, regulatory compliance verification, and service contract setup.',
    `project_id` BIGINT COMMENT 'Foreign key linking to research.project. Business justification: Academic and pharma customers frequently purchase sequencing services or instruments for specific R&D projects. Linking orders to projects enables grant-funded revenue recognition, project-based cost ',
    `sold_to_party_account_id` BIGINT COMMENT 'Foreign key reference to the primary contracting party. Represents the legal entity entering into the sales agreement.',
    `actual_delivery_date` DATE COMMENT 'Date when the order was physically delivered to the customer site and accepted. Used for SLA performance measurement and revenue recognition triggers.',
    `cancellation_reason` STRING COMMENT 'Reason code or description for order cancellation. Null for non-cancelled orders. Used for root cause analysis and process improvement.',
    `confirmed_ship_date` DATE COMMENT 'Date when the order was confirmed to ship from the fulfillment center or manufacturing facility. Null until shipment is confirmed.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this order record was first created in the system. Audit trail for record creation.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts on this order (e.g., USD, EUR, GBP, JPY).. Valid values are `^[A-Z]{3}$`',
    `distribution_channel` STRING COMMENT 'SAP distribution channel code representing the route-to-market for this order (e.g., direct, wholesale, online). Used for pricing and logistics determination.',
    `division` STRING COMMENT 'SAP division code representing the product line or business segment (e.g., sequencing systems, array products, clinical genomics). Used for P&L reporting.',
    `erp_sales_document_number` STRING COMMENT 'SAP S/4HANA SD module sales document number. System-of-record identifier linking this order to the ERP order-to-cash process.. Valid values are `^[0-9]{10}$`',
    `export_control_flag` BOOLEAN COMMENT 'Indicates whether this order contains items subject to export control regulations (ITAR, EAR, dual-use technology). True requires additional compliance review and documentation.',
    `gxp_relevant_flag` BOOLEAN COMMENT 'Indicates whether this order is for a customer operating under GxP regulations (GMP, GLP, GCP). True triggers additional quality documentation, certificates of analysis, and audit trail requirements.',
    `incoterms` STRING COMMENT 'Standard trade terms defining the responsibilities of buyers and sellers for delivery, insurance, and risk transfer. Based on ICC Incoterms 2020. [ENUM-REF-CANDIDATE: EXW|FCA|CPT|CIP|DAP|DPU|DDP|FAS|FOB|CFR|CIF — 11 candidates stripped; promote to reference product]',
    `incoterms_location` STRING COMMENT 'Named place or port specified in the Incoterms clause where risk and cost transfer occurs (e.g., San Diego Port, customer facility address).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this order record was last updated. Audit trail for record changes.',
    `order_date` DATE COMMENT 'Date when the customer order was officially placed and accepted into the system. Represents the business event timestamp for order creation.',
    `order_number` STRING COMMENT 'Externally-visible unique business identifier for the sales order. Used in customer communications, invoices, and shipment tracking.. Valid values are `^[A-Z0-9]{8,20}$`',
    `order_source_channel` STRING COMMENT 'Sales channel through which the order was received. Direct sales for company sales team, distributor for channel partners, OEM for original equipment manufacturer partnerships, e-commerce for online store, field application for scientific support-driven sales.. Valid values are `direct_sales|distributor|oem_partner|e_commerce|field_application|government_contract`',
    `order_status` STRING COMMENT 'Current lifecycle status of the sales order. Tracks progression from initial creation through fulfillment and delivery. On-hold indicates temporary suspension due to credit check, regulatory review, or customer request. [ENUM-REF-CANDIDATE: draft|open|in_fulfillment|shipped|delivered|cancelled|on_hold — 7 candidates stripped; promote to reference product]',
    `order_type` STRING COMMENT 'Classification of the order based on the primary product category being purchased: instrument (sequencing systems, arrays), reagent (library prep kits, flow cells), consumable (tips, plates), sequencing service (WGS, WES, targeted panels), software license (bioinformatics tools), or support contract (maintenance, training).. Valid values are `instrument|reagent|consumable|sequencing_service|software_license|support_contract`',
    `payment_terms` STRING COMMENT 'Agreed payment conditions specifying when payment is due. Net terms indicate days from invoice date. Prepaid requires payment before shipment. [ENUM-REF-CANDIDATE: net_30|net_60|net_90|due_on_receipt|prepaid|credit_card|letter_of_credit — 7 candidates stripped; promote to reference product]',
    `product_classification` STRING COMMENT 'Regulatory classification of the ordered products. RUO (Research Use Only) for non-clinical research, IVD (In Vitro Diagnostic) for FDA-cleared clinical use, LDT (Laboratory Developed Test) for CLIA-certified lab use, CE-IVD for European clinical diagnostic use.. Valid values are `RUO|IVD|LDT|CE_IVD`',
    `purchase_order_number` STRING COMMENT 'Customer-provided purchase order number. Required for many institutional and government customers for invoice matching and payment processing.',
    `requested_delivery_date` DATE COMMENT 'Customer-requested date for order delivery. Used for logistics planning and SLA commitment calculation.',
    `sales_office` STRING COMMENT 'Geographic sales office or region responsible for this order. Used for territory management and sales performance tracking.',
    `sales_organization` STRING COMMENT 'SAP sales organization code representing the legal entity or business unit responsible for this sale. Used for revenue recognition and reporting segmentation.',
    `shipping_carrier` STRING COMMENT 'Name of the logistics carrier or freight forwarder handling shipment (e.g., FedEx, UPS, DHL, specialized biotech logistics provider).',
    `shipping_method` STRING COMMENT 'Logistics method for order delivery. Specialized cold chain required for temperature-sensitive reagents and biological materials. Customer pickup for local instrument installations.. Valid values are `ground|air|ocean|courier|customer_pickup|specialized_cold_chain`',
    `sla_tier` STRING COMMENT 'Service level tier determining turnaround time commitments and fulfillment priority. Critical tier for time-sensitive clinical or research projects.. Valid values are `standard|priority|expedited|critical`',
    `special_handling_instructions` STRING COMMENT 'Free-text field for special delivery, packaging, or handling requirements (e.g., temperature control, hazmat labeling, installation coordination, security clearance requirements).',
    `tat_commitment_date` DATE COMMENT 'Date by which the order must be delivered to meet the SLA commitment. Calculated from order date plus SLA tier turnaround time. Used for performance tracking.',
    `total_net_value` DECIMAL(18,2) COMMENT 'Total order value before taxes, fees, and adjustments. Sum of all line item net values in the order currency.',
    `total_order_value` DECIMAL(18,2) COMMENT 'Total order value including all taxes, fees, shipping charges, and adjustments. Final amount to be invoiced to the customer.',
    `total_tax_amount` DECIMAL(18,2) COMMENT 'Total tax amount applied to the order, including sales tax, VAT, GST, or other applicable taxes based on ship-to jurisdiction.',
    `tracking_number` STRING COMMENT 'Carrier-provided tracking number for shipment monitoring. Null until order ships. Used for customer self-service tracking and delivery confirmation.',
    CONSTRAINT pk_header PRIMARY KEY(`header_id`)
) COMMENT 'Core commercial order record representing a confirmed customer purchase of instruments, reagent kits, consumables, sequencing services, or software licenses. Integrates with ERP order-to-cash processing and CRM opportunity-to-order handoff. Captures order number, order type (instrument, reagent, service, software), order date, requested delivery date, confirmed ship date, order status (open, in-fulfillment, shipped, delivered, cancelled), ERP sales document number, CRM opportunity ID, customer account ID, ship-to and bill-to party references, incoterms, payment terms, currency, total net value, total tax amount, total order value, SLA tier, TAT commitment date, order source channel (direct, distributor, OEM, e-commerce), RUO/IVD classification, export control flag, and GxP-relevant order flag.';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`order`.`line` (
    `line_id` BIGINT COMMENT 'Unique identifier for the order line item. Primary key for the order line entity.',
    `approval_id` BIGINT COMMENT 'Foreign key linking to regulatory.regulatory_approval. Business justification: Line-level regulatory tracking required because mixed orders contain products under different approvals (RUO, CE-IVD, FDA-cleared sequencing kits). Business process: line-item compliance verification,',
    `blanket_order_id` BIGINT COMMENT 'Foreign key linking to order.blanket_order. Business justification: Order lines can be releases against blanket orders (framework agreements for recurring purchases). In genomics, customers often establish blanket orders for recurring reagent kit purchases with commit',
    `catalog_id` BIGINT COMMENT 'Foreign key linking to reagent.reagent_catalog. Business justification: Order lines in genomics biotech sell reagent kits, sequencing consumables, and arrays. FK enables regulatory traceability, accurate catalog pricing, product lifecycle validation (discontinued items), ',
    `complaint_id` BIGINT COMMENT 'Foreign key linking to quality.complaint. Business justification: Specific line items (reagent kits, sequencing services, instruments with lot/serial numbers) are subjects of quality complaints. Complaint systems must link to exact SKU/lot/batch from order line for ',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Line-level cost center allocation enables granular project charging for sequencing services, reagent kits, and instrument consumables. Critical for R&D project accounting and grant cost tracking in ge',
    `genomic_region_id` BIGINT COMMENT 'Foreign key linking to reference.genomic_region. Business justification: Targeted sequencing order lines (exome, gene panels, custom capture) must specify the exact genomic region set being ordered to define contractual scope, enable accurate pricing, guide laboratory exec',
    `header_id` BIGINT COMMENT 'Reference to the parent sales order header. Links this line item to its containing order document.',
    `test_catalog_id` BIGINT COMMENT 'Foreign key linking to clinical.test_catalog. Business justification: Order lines for clinical testing services reference the specific test from the catalog. Required for order fulfillment, specimen routing, TAT tracking, and billing. Core business process linking comme',
    `library_id` BIGINT COMMENT 'Foreign key linking to sequencing.library. Business justification: Sequencing service orders specify which prepared library is being sequenced. Critical for order fulfillment, sample tracking, and linking commercial orders to lab operations. Enables "which library wa',
    `lot_id` BIGINT COMMENT 'Foreign key linking to reagent.lot. Business justification: GxP regulations require lot-level traceability from customer shipments to manufacturing batch. FK enables CoA provision, recall management, expiry tracking, and regulatory audit trails. Replaces denor',
    `material_id` BIGINT COMMENT 'Foreign key linking to supply.material. Business justification: Order lines reference supply master data for reagent kits, sequencing consumables, and instruments. Enables inventory allocation, COA attachment, regulatory status validation, and storage condition en',
    `model_id` BIGINT COMMENT 'Foreign key linking to instrument.instrument_model. Business justification: Reagent kit and consumable line items must validate compatibility with customers instrument model. Sequencing service orders require instrument model for read length, flow cell type, and chemistry co',
    `nonconformance_id` BIGINT COMMENT 'Foreign key linking to quality.nonconformance. Business justification: Specific order line items (lots/batches) may be subject to nonconformances discovered post-shipment (field failures, customer QC rejections). Field quality issues traced back to specific order lines f',
    `production_batch_id` BIGINT COMMENT 'Foreign key linking to manufacturing.production_batch. Business justification: Regulatory compliance (21 CFR Part 11, ISO 13485) mandates batch traceability for reagents, flow cells, and consumables. Order lines must link to production batches for CoA delivery, lot genealogy, an',
    `project_id` BIGINT COMMENT 'Foreign key linking to research.project. Business justification: Mixed orders where some line items are project-funded (grant-purchased reagents) and others are not require line-level project attribution. Supports project cost allocation, grant accounting, and audi',
    `sequencing_protocol_id` BIGINT COMMENT 'Foreign key linking to sequencing.sequencing_protocol. Business justification: Service orders specify sequencing protocol requirements (read length, coverage depth, application type) that drive pricing, TAT commitments, and fulfillment specifications. Essential for translating c',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: Order lines must reference specific orderable SKUs for inventory allocation, fulfillment execution, pricing validation, and lot traceability. Critical for order-to-cash process and ERP integration. Re',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to supply.supplier. Business justification: Drop-ship and third-party fulfillment scenarios where order line is fulfilled directly by supplier (not from internal inventory). Enables supplier performance tracking, direct-ship lead time monitorin',
    `work_order_id` BIGINT COMMENT 'Foreign key linking to manufacturing.work_order. Business justification: Make-to-order genomics products (custom reagent kits, sequencing libraries, instrument builds) require direct order line to work order linkage for production scheduling, TAT tracking, and customer del',
    `actual_ship_date` DATE COMMENT 'Actual date when the line item was shipped from the warehouse or manufacturing facility. Null if not yet shipped.',
    `batch_number` STRING COMMENT 'Production batch number for the manufactured product. Used for quality control and Certificate of Analysis (COA) linkage.',
    `cancellation_reason` STRING COMMENT 'Reason code or description if the line item was cancelled. Null for non-cancelled lines.',
    `confirmed_delivery_date` DATE COMMENT 'Delivery date confirmed by Available-to-Promise (ATP) check and production planning. Represents the committed delivery date to the customer.',
    `confirmed_quantity` DECIMAL(18,2) COMMENT 'Quantity confirmed for delivery based on Available-to-Promise (ATP) check and inventory availability.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this order line record was first created in the system. Audit trail for order entry.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts on this line item. [ENUM-REF-CANDIDATE: USD|EUR|GBP|JPY|CNY|AUD|CAD|CHF| — 8 candidates stripped; promote to reference product]',
    `delivered_quantity` DECIMAL(18,2) COMMENT 'Cumulative quantity that has been shipped and delivered to the customer across all shipments for this line.',
    `delivery_priority` STRING COMMENT 'Priority level for fulfillment and shipping of this line item. Influences warehouse picking sequence and carrier service selection.. Valid values are `standard|expedited|rush|critical|`',
    `discount_amount` DECIMAL(18,2) COMMENT 'Total discount amount applied to this line item including volume discounts, promotional discounts, and customer-specific pricing agreements.',
    `discount_percentage` DECIMAL(18,2) COMMENT 'Discount percentage applied to the list price for this line item. Calculated as (line_discount_amount / (list_unit_price * ordered_quantity)) * 100.',
    `expiration_date` DATE COMMENT 'Expiration or shelf-life end date for time-sensitive products such as reagents and consumables. Critical for quality and regulatory compliance.',
    `hazmat_classification` STRING COMMENT 'Hazardous material classification code if the product contains dangerous goods requiring special shipping compliance. References UN number and shipping class.',
    `item_category` STRING COMMENT 'SAP SD item category code that controls line item processing behavior. TAN=Standard Item, ZSEQ=Sequencing Service, ZKIT=Reagent Kit, ZINS=Instrument, ZSVC=Service, ZCON=Consumable.. Valid values are `TAN|ZSEQ|ZKIT|ZINS|ZSVC|ZCON`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this order line record was last updated. Tracks the most recent change to any field on the line.',
    `line_number` STRING COMMENT 'Sequential line item number within the sales order. Determines the ordering and display sequence of line items.',
    `line_status` STRING COMMENT 'Current fulfillment status of the order line item. Tracks the line through its lifecycle from order entry to delivery completion. [ENUM-REF-CANDIDATE: open|confirmed|in_production|ready_to_ship|partially_shipped|fully_shipped|delivered|cancelled|on_hold — 9 candidates stripped; promote to reference product]',
    `list_unit_price` DECIMAL(18,2) COMMENT 'Standard catalog list price per unit before any discounts or adjustments. Expressed in order currency.',
    `net_unit_price` DECIMAL(18,2) COMMENT 'Net price per unit after applying all applicable discounts and before taxes. Expressed in order currency.',
    `net_value` DECIMAL(18,2) COMMENT 'Total net value for this line item calculated as net_unit_price * ordered_quantity, before taxes. Expressed in order currency.',
    `open_quantity` DECIMAL(18,2) COMMENT 'Remaining quantity not yet shipped or fulfilled. Calculated as ordered_quantity minus delivered_quantity.',
    `ordered_quantity` DECIMAL(18,2) COMMENT 'Quantity of the product ordered by the customer as specified in the original sales order.',
    `plant_code` STRING COMMENT 'SAP plant code identifying the manufacturing facility or distribution center fulfilling this line item.',
    `regulatory_designation` STRING COMMENT 'Regulatory classification of the product. RUO=Research Use Only, IVD=In Vitro Diagnostic, CE-IVD=European Conformité Européenne IVD, LDT=Laboratory Developed Test.. Valid values are `RUO|IVD|CE_IVD|LDT|`',
    `requested_delivery_date` DATE COMMENT 'Customer-requested delivery date for this specific line item. May differ from the order header requested date.',
    `sequencing_service_type` STRING COMMENT 'Type of Next-Generation Sequencing (NGS) service when product_type is sequencing_service. WGS=Whole Genome Sequencing, WES=Whole Exome Sequencing. Empty for non-sequencing products.. Valid values are `WGS|WES|targeted_panel|RNA_seq|single_cell|metagenomics|`',
    `serial_number` STRING COMMENT 'Unique serial number for serialized products such as instruments and equipment. Enables individual unit tracking and warranty management.',
    `shipping_point` STRING COMMENT 'Organizational unit responsible for shipping activities for this line item. Determines shipping logistics and carrier selection.',
    `special_handling_instructions` STRING COMMENT 'Free-text instructions for special handling requirements such as temperature control, hazardous materials, or custom packaging.',
    `storage_location` STRING COMMENT 'Storage location within the plant where the product inventory is allocated for this line item.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Total tax amount calculated for this line item based on the tax code and line net value. Expressed in order currency.',
    `tax_code` STRING COMMENT 'Tax jurisdiction and rate code applied to this line item. Determines applicable sales tax, VAT, or GST calculation.',
    `temperature_requirement` STRING COMMENT 'Required storage and shipping temperature condition for the product. Critical for reagent and biological sample integrity.. Valid values are `ambient|refrigerated|frozen|ultra_cold|dry_ice|`',
    `total_value` DECIMAL(18,2) COMMENT 'Total value for this line item including taxes. Calculated as line_net_value + tax_amount. Expressed in order currency.',
    `turnaround_time_days` STRING COMMENT 'Committed Turnaround Time (TAT) in days from order confirmation to delivery for this line item. Critical SLA metric for sequencing services.',
    `unit_of_measure` STRING COMMENT 'Unit of measure for quantities. EA=Each, KIT=Kit, RXN=Reaction, GB=Gigabase, LANE=Flow Cell Lane, RUN=Sequencing Run, HR=Hour. [ENUM-REF-CANDIDATE: EA|KIT|RXN|GB|LANE|RUN|HR| — 7 candidates stripped; promote to reference product]',
    CONSTRAINT pk_line PRIMARY KEY(`line_id`)
) COMMENT 'Individual line item within a sales order representing a specific SKU, product catalog entry, or sequencing service. Captures line item number, SAP item category, product SKU, product description, ordered quantity, unit of measure, confirmed quantity, open quantity, net unit price, line discount amount, line net value, tax code, tax amount, requested delivery date per line, confirmed delivery date, line status (open, partially-shipped, fully-shipped, cancelled), lot number reference, batch number, RUO/IVD designation, reagent kit configuration, instrument model reference, and sequencing service type (WGS, WES, targeted panel).';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`order`.`quotation` (
    `quotation_id` BIGINT COMMENT 'Unique system-generated identifier for the quotation record. Primary key.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Quotations reference requesting cost center for budget availability validation before order conversion. Prevents over-commitment of departmental budgets for high-value sequencing projects or instrumen',
    `opportunity_id` BIGINT COMMENT 'Reference to the upstream Salesforce CRM opportunity that triggered this quotation. Links quotation to the sales pipeline stage.',
    `account_id` BIGINT COMMENT 'Reference to the customer account receiving this quotation. Links to master customer data for billing and delivery.',
    `contact_id` BIGINT COMMENT 'Reference to the specific customer contact person who requested or received the quotation.',
    `header_id` BIGINT COMMENT 'Reference to the sales order created from this quotation when converted. Null if quotation not yet converted.',
    `model_id` BIGINT COMMENT 'Foreign key linking to instrument.instrument_model. Business justification: Quotations for sequencing services and reagent subscriptions require instrument model specification for accurate pricing tiers, throughput capacity planning, and technical feasibility assessment. Driv',
    `employee_id` BIGINT COMMENT 'Reference to the manager or approver who authorized this quotation. Null if approval not required or still pending.',
    `quotation_employee_id` BIGINT COMMENT 'Reference to the sales representative or account manager who prepared and owns this quotation.',
    `quotation_prepared_by_user_employee_id` BIGINT COMMENT 'Reference to the system user who created and prepared the quotation document. May differ from sales rep if prepared by sales operations.',
    `project_id` BIGINT COMMENT 'Foreign key linking to research.project. Business justification: Research customers request quotes for project-specific sequencing services, reagent kits, or instruments during grant proposal preparation. Linking quotations to projects enables budget planning, prop',
    `approval_required_flag` BOOLEAN COMMENT 'Boolean indicator whether this quotation requires management approval before submission to customer due to special pricing, terms, or high value.',
    `approval_status` STRING COMMENT 'Current approval workflow status. Pending: awaiting manager review; Approved: authorized for submission; Rejected: requires revision; Not Required: within standard authority.. Valid values are `pending|approved|rejected|not_required`',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when quotation was approved by authorized manager. Null if not yet approved or approval not required.',
    `competitor_name` STRING COMMENT 'Name of competitor who won the business if quotation was lost to competition. Used for competitive intelligence and market analysis.',
    `converted_to_order_flag` BOOLEAN COMMENT 'Boolean indicator whether this quotation has been converted to a sales order. True: quotation accepted and order created; False: quotation still pending or rejected.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this quotation record was first created in the system. Audit trail for record creation.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this quotation (e.g., USD, EUR, GBP, JPY).. Valid values are `^[A-Z]{3}$`',
    `customer_notes` STRING COMMENT 'Special instructions or terms communicated to the customer on the quotation document. Printed on customer-facing quotation PDF.',
    `delivery_location` STRING COMMENT 'Named delivery location or Incoterms location for the quoted goods (e.g., customer facility address, port name).',
    `discount_amount` DECIMAL(18,2) COMMENT 'Total discount applied to the quotation. Sum of all volume discounts, promotional discounts, and negotiated price reductions.',
    `discount_tier` STRING COMMENT 'Discount tier applied to this quotation. Standard: list price; Volume: quantity-based discount; Strategic: key account pricing; Promotional: campaign offer; Custom: special approval pricing.. Valid values are `standard|volume|strategic|promotional|custom`',
    `distribution_channel_code` STRING COMMENT 'SAP SD distribution channel through which products are sold. Two-character code (e.g., direct sales, distributor, online).. Valid values are `^[A-Z0-9]{2}$`',
    `division_code` STRING COMMENT 'SAP SD division representing the product line or business unit. Two-character code (e.g., sequencing instruments, reagents, services).. Valid values are `^[A-Z0-9]{2}$`',
    `erp_quotation_document_number` STRING COMMENT 'SAP S/4HANA SD module quotation document number. Ten-digit numeric identifier from the source ERP system.. Valid values are `^[0-9]{10}$`',
    `estimated_delivery_lead_time_days` STRING COMMENT 'Estimated number of calendar days from order placement to delivery at customer site. Used for customer planning and SLA commitment.',
    `incoterms_code` STRING COMMENT 'Three-letter Incoterms 2020 code defining delivery terms and risk transfer point (e.g., EXW, FOB, CIF, DDP).. Valid values are `^[A-Z]{3}$`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this quotation record was last updated. Audit trail for record changes.',
    `net_quoted_value` DECIMAL(18,2) COMMENT 'Final net quotation value after applying discounts and adding taxes. Total amount customer will pay if quotation is accepted.',
    `notes` STRING COMMENT 'Internal notes and comments about the quotation for sales team reference. Not visible to customer.',
    `payment_terms_code` STRING COMMENT 'SAP SD payment terms code defining due date calculation and cash discount conditions (e.g., Net 30, Net 60, 2/10 Net 30).. Valid values are `^[A-Z0-9]{4}$`',
    `pricing_conditions_applied` STRING COMMENT 'Comma-separated list of SAP SD pricing condition types applied to this quotation (e.g., PR00 base price, K004 volume discount, MWST tax).',
    `product_category` STRING COMMENT 'Primary product category being quoted. Instrument: sequencing or array platforms; Reagent: chemistry kits; Consumable: flow cells, cartridges; Service: sequencing-as-a-service; Software: bioinformatics licenses; Bundle: multi-product package.. Valid values are `instrument|reagent|consumable|service|software|bundle`',
    `quotation_date` DATE COMMENT 'Date the quotation was created and issued to the customer. Business event timestamp for quotation generation.',
    `quotation_number` STRING COMMENT 'Business-facing unique quotation document number used for customer communication and reference. Format: QT-YYYYNNNN.. Valid values are `^QT-[0-9]{8}$`',
    `quotation_status` STRING COMMENT 'Current lifecycle status of the quotation. Draft: being prepared; Submitted: sent to customer; Accepted: customer approved; Rejected: customer declined; Expired: validity period lapsed; Withdrawn: seller cancelled.. Valid values are `draft|submitted|accepted|rejected|expired|withdrawn`',
    `quotation_type` STRING COMMENT 'Classification of quotation by business purpose. Standard: catalog products; Custom: configured solutions; Renewal: subscription extension; Upgrade: existing customer expansion; Trial: evaluation offer.. Valid values are `standard|custom|renewal|upgrade|trial`',
    `regulatory_classification` STRING COMMENT 'Regulatory use designation of quoted products. RUO: Research Use Only; IVD: In Vitro Diagnostic (FDA-cleared); LDT: Laboratory Developed Test; CE-IVD: European IVD certified.. Valid values are `RUO|IVD|LDT|CE-IVD`',
    `rejection_reason_code` STRING COMMENT 'Two-character code indicating why quotation was rejected by customer or withdrawn by seller. Null if not rejected. Used for sales analytics and win/loss analysis.. Valid values are `^[A-Z0-9]{2}$`',
    `rejection_reason_description` STRING COMMENT 'Free-text explanation of quotation rejection or withdrawal. Captures customer feedback for continuous improvement.',
    `sales_organization_code` STRING COMMENT 'SAP SD sales organization responsible for this quotation. Four-character alphanumeric code representing the selling entity.. Valid values are `^[A-Z0-9]{4}$`',
    `special_pricing_justification` STRING COMMENT 'Business justification for non-standard pricing or discounts exceeding standard approval thresholds. Required for audit and compliance when custom pricing is applied.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Total tax amount calculated for the quotation based on customer location and tax jurisdiction. Includes VAT, GST, or sales tax as applicable.',
    `total_quoted_value` DECIMAL(18,2) COMMENT 'Total monetary value of the quotation including all line items, before discounts and taxes. Gross quotation amount.',
    `valid_from_date` DATE COMMENT 'Start date of the quotation validity period. Pricing and terms are binding from this date.',
    `valid_to_date` DATE COMMENT 'End date of the quotation validity period. Quotation expires after this date unless extended or converted to order.',
    CONSTRAINT pk_quotation PRIMARY KEY(`quotation_id`)
) COMMENT 'Pre-order commercial quotation generated for a customer opportunity, representing a formal price offer for instruments, reagent kits, consumables, sequencing services, or software. Sourced from ERP quotation processing with upstream linkage to CRM opportunity management. Captures quotation number, ERP quotation document number, CRM opportunity ID, quotation date, valid-from date, valid-to date, quotation status (draft, submitted, accepted, rejected, expired), customer account ID, total quoted value, currency, discount tier, pricing conditions applied, special pricing justification, RUO/IVD classification, and conversion-to-order flag.';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`order`.`quotation_line` (
    `quotation_line_id` BIGINT COMMENT 'Unique identifier for the quotation line item. Primary key for this entity.',
    `catalog_id` BIGINT COMMENT 'Foreign key linking to reagent.reagent_catalog. Business justification: Quotations for genomics products include reagent kits, sequencing consumables, and arrays. FK enables accurate catalog pricing, regulatory designation validation, product lifecycle checks (discontinue',
    `genomic_region_id` BIGINT COMMENT 'Foreign key linking to reference.genomic_region. Business justification: Quotations for targeted sequencing services must reference specific genomic region sets (panel versions) to calculate accurate pricing based on target size, estimate turnaround time based on coverage ',
    `test_catalog_id` BIGINT COMMENT 'Foreign key linking to clinical.test_catalog. Business justification: Sales teams quote specific clinical diagnostic tests from the catalog. Quotation lines must reference catalog tests for accurate pricing, turnaround time, and regulatory designation. Enables commercia',
    `manufacturing_bom_id` BIGINT COMMENT 'Foreign key linking to manufacturing.manufacturing_bom. Business justification: Custom sequencing panel quotes, library prep configurations, and instrument upgrade pricing require BOM cost rollups for accurate quotation. Sales teams validate manufacturing feasibility and calculat',
    `material_id` BIGINT COMMENT 'Foreign key linking to supply.material. Business justification: Quotation lines reference supply master data for accurate pricing, lead times, regulatory designations, and storage requirements. Ensures quoted configurations match available materials and enables au',
    `model_id` BIGINT COMMENT 'Foreign key linking to instrument.instrument_model. Business justification: Individual quote lines for reagents, flow cells, and sequencing services must reference instrument model for compatibility validation, read length configuration, and chemistry specification. Prevents ',
    `quotation_id` BIGINT COMMENT 'Reference to the parent quotation header. Links this line item to the overall commercial quotation document.',
    `sequencing_protocol_id` BIGINT COMMENT 'Foreign key linking to sequencing.sequencing_protocol. Business justification: Sales quotations for sequencing services must specify protocol requirements to calculate accurate pricing, lead times, and resource requirements. Enables sales team to quote "WGS 30x coverage using pr',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: Quotation lines reference specific SKUs for real-time pricing, availability checks, lead time calculation, and order conversion. Essential for quote-to-order workflow and sales operations. Replaces de',
    `created_by_user` STRING COMMENT 'User identifier of the sales representative or system user who created this quotation line item. Provides accountability and audit trail for quotation authorship.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this quotation line item record was first created in the system. Represents the initial capture of this line item in the quotation document.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary values on this quotation line. Specifies the currency in which prices are quoted (e.g., USD, EUR, GBP, JPY).. Valid values are `^[A-Z]{3}$`',
    `delivery_lead_time_days` STRING COMMENT 'Estimated number of calendar days from order acceptance to product delivery or service completion. Represents the Turnaround Time (TAT) commitment for this line item.',
    `discount_percentage` DECIMAL(18,2) COMMENT 'Percentage discount applied to the list price to arrive at the quoted unit price. Represents volume discounts, promotional pricing, or customer-specific negotiated discounts.',
    `distribution_channel` STRING COMMENT 'Channel through which the product or service will be delivered to the customer. Distinguishes between direct sales, distributor partnerships, Original Equipment Manufacturer (OEM) arrangements, or e-commerce platforms.. Valid values are `direct|distributor|oem|ecommerce`',
    `item_category` STRING COMMENT 'SAP SD item category code that controls processing logic for this line item. Determines whether the line is a standard item, text item, service item, or special processing type.',
    `line_net_value` DECIMAL(18,2) COMMENT 'Total net value for this quotation line calculated as quoted_unit_price multiplied by quoted_quantity. Represents the subtotal for this line item before taxes and shipping.',
    `line_number` STRING COMMENT 'Sequential line item number within the quotation. Determines the ordering and display sequence of line items in the quotation document.',
    `line_status` STRING COMMENT 'Current lifecycle status of this quotation line item. Tracks progression from draft through approval, customer acceptance, conversion to sales order, or expiration. [ENUM-REF-CANDIDATE: draft|submitted|approved|rejected|accepted|converted|expired — 7 candidates stripped; promote to reference product]',
    `list_price` DECIMAL(18,2) COMMENT 'Standard catalog list price per unit before any discounts or adjustments. Represents the published price from the official price list for the product or service.',
    `material_group` STRING COMMENT 'SAP material group classification for the quoted product. Groups similar products for procurement, pricing, and reporting purposes within the enterprise resource planning system.',
    `modified_by_user` STRING COMMENT 'User identifier of the person who last modified this quotation line item. Tracks who made the most recent changes to pricing, configuration, or status.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this quotation line item record was last modified. Tracks the most recent update to pricing, quantity, configuration, or status.',
    `plant_code` STRING COMMENT 'SAP plant or facility code from which the product will be shipped or the service will be delivered. Identifies the manufacturing site, warehouse, or service center responsible for fulfillment.',
    `pricing_condition_type` STRING COMMENT 'SAP SD pricing condition type code that determines how the quoted price was calculated. Identifies the specific pricing rule, discount scheme, or surcharge applied to this line item.',
    `quoted_quantity` DECIMAL(18,2) COMMENT 'Quantity of the product or service being quoted. Represents the number of units, kits, instruments, or service hours proposed to the customer.',
    `quoted_unit_price` DECIMAL(18,2) COMMENT 'Actual unit price quoted to the customer after applying discounts, volume pricing, or negotiated rates. This is the effective price per unit that will be charged if the quotation is accepted.',
    `regulatory_designation` STRING COMMENT 'Regulatory classification of the product or service. Research Use Only (RUO) for research applications, In Vitro Diagnostic (IVD) for clinical diagnostic use, Laboratory Developed Test (LDT) for lab-specific tests, or Conformité Européenne In Vitro Diagnostic (CE-IVD) for European market approval.. Valid values are `RUO|IVD|LDT|CE_IVD`',
    `rejection_reason` STRING COMMENT 'Reason code and description if this quotation line was rejected by the customer or internal approval process. Captures feedback for sales analysis and process improvement.',
    `sales_organization` STRING COMMENT 'SAP sales organization code responsible for this quotation line. Identifies the legal entity and geographic sales unit managing the customer relationship and quotation.',
    `sequencing_coverage_depth` STRING COMMENT 'Target coverage depth specification for sequencing services expressed as fold coverage (e.g., 30X, 100X). Indicates how many times each base position will be sequenced on average. Applicable when product_category is sequencing_service.',
    `special_instructions` STRING COMMENT 'Free-text field for line-specific special handling instructions, custom configuration notes, or customer-requested modifications. Communicates unique requirements to fulfillment and operations teams.',
    `tax_classification_code` STRING COMMENT 'Tax classification code determining applicable tax rates and rules for this line item. Used for Value Added Tax (VAT), Goods and Services Tax (GST), or sales tax calculation based on product type and jurisdiction.',
    `unit_of_measure` STRING COMMENT 'Unit of measure for the quoted quantity. Specifies whether the quantity is measured in individual units, kits, boxes, liters, sequencing runs, flow cell lanes, samples processed, service hours, or software licenses. [ENUM-REF-CANDIDATE: each|kit|box|liter|run|lane|sample|hour|license — 9 candidates stripped; promote to reference product]',
    `validity_end_date` DATE COMMENT 'Date until which this quotation line item pricing and terms remain valid. After this date, pricing may need to be re-quoted. Defines the end of the quotation validity period.',
    `validity_start_date` DATE COMMENT 'Date from which this quotation line item pricing and terms become valid. Defines the beginning of the quotation validity period.',
    CONSTRAINT pk_quotation_line PRIMARY KEY(`quotation_line_id`)
) COMMENT 'Individual line item within a commercial quotation specifying a product SKU, service offering, or instrument configuration with associated pricing. Captures quotation line number, product SKU, product description, quoted quantity, unit of measure, list price, quoted unit price, discount percentage, line net value, pricing condition type, reagent kit configuration details, instrument model, sequencing service specification (read length, coverage depth, flow cell type), and line-level RUO/IVD designation.';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`order`.`delivery` (
    `delivery_id` BIGINT COMMENT 'Unique identifier for the outbound delivery document. Primary key.',
    `account_id` BIGINT COMMENT 'Reference to the customer location or site where the delivery will be physically shipped.',
    `approval_id` BIGINT COMMENT 'Foreign key linking to regulatory.regulatory_approval. Business justification: Shipment documentation for genomics products (commercial invoice, certificate of conformity, declaration of conformity) must reference regulatory approval for customs clearance, import permits, and te',
    `complaint_id` BIGINT COMMENT 'Foreign key linking to quality.complaint. Business justification: Delivery issues (temperature excursions, damaged shipments, cold chain failures, late delivery) trigger customer complaints. Complaint investigations reference delivery records (tracking, temperature ',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Cold chain logistics and specialized freight costs for temperature-sensitive reagents/samples allocated to specific cost centers. Enables accurate project costing and logistics expense tracking for ge',
    `header_id` BIGINT COMMENT 'Reference to the originating sales order that this delivery fulfills.',
    `warehouse_location_id` BIGINT COMMENT 'Reference to the warehouse or distribution center from which the delivery is being fulfilled.',
    `actual_delivery_date` DATE COMMENT 'Actual date when the shipment was delivered and received by the customer. Used for SLA compliance measurement and TAT reporting.',
    `carrier_code` BIGINT COMMENT 'Reference to the logistics carrier or shipping company responsible for transporting the delivery.',
    `carrier_name` STRING COMMENT 'Name of the logistics carrier or shipping company (e.g., FedEx, UPS, DHL, specialized cold-chain provider).',
    `carrier_scac_code` STRING COMMENT 'Standard Carrier Alpha Code - a unique 2-4 letter code used to identify transportation companies in North America.. Valid values are `^[A-Z]{2,4}$`',
    `cold_chain_required_flag` BOOLEAN COMMENT 'Indicates whether this delivery requires temperature-controlled cold-chain logistics to maintain reagent and consumable integrity.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the delivery document was first created in the ERP system. Used for audit trail and process analytics.',
    `dangerous_goods_flag` BOOLEAN COMMENT 'Indicates whether the delivery contains dangerous goods or hazardous materials requiring special handling and documentation per IATA/DOT regulations.',
    `delivery_date` DATE COMMENT 'Planned or actual date when the delivery is scheduled to reach the customer.',
    `delivery_status` STRING COMMENT 'Current lifecycle status of the delivery document (created, picked, packed, goods issued, in transit, delivered, cancelled). [ENUM-REF-CANDIDATE: created|picked|packed|goods_issued|in_transit|delivered|cancelled — 7 candidates stripped; promote to reference product]',
    `delivery_type` STRING COMMENT 'Classification of the delivery based on fulfillment method and handling requirements (standard, rush, cold-chain, hazardous materials, direct ship, drop ship).. Valid values are `standard|rush|cold_chain|hazmat|direct_ship|drop_ship`',
    `document_number` STRING COMMENT 'The externally-known business identifier for the delivery document, typically a 10-digit SAP delivery number.. Valid values are `^[0-9]{10}$`',
    `estimated_delivery_date` DATE COMMENT 'Carrier-provided estimated date when the shipment will be delivered to the customer. Used for customer communication and SLA monitoring.',
    `export_declaration_number` STRING COMMENT 'Customs export declaration number for international shipments, required for regulatory compliance and border clearance.',
    `goods_issue_date` DATE COMMENT 'Date when goods were physically issued from the warehouse and inventory was decremented. Critical for revenue recognition and inventory accounting.',
    `goods_issue_status` STRING COMMENT 'Status of the goods issue posting (not issued, partially issued, fully issued, reversed).. Valid values are `not_issued|partially_issued|fully_issued|reversed`',
    `goods_issue_timestamp` TIMESTAMP COMMENT 'Precise timestamp when goods issue was posted in the ERP system. Used for audit trail and SLA tracking.',
    `incoterms` STRING COMMENT 'Incoterms code defining the responsibilities, costs, and risks between buyer and seller for international shipments (e.g., EXW, FCA, DDP). [ENUM-REF-CANDIDATE: EXW|FCA|CPT|CIP|DAP|DPU|DDP|FAS|FOB|CFR|CIF — 11 candidates stripped; promote to reference product]',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the delivery document was last updated. Used for change tracking and data synchronization.',
    `notes` STRING COMMENT 'Free-text field for special delivery instructions, handling notes, or customer-specific requirements (e.g., loading dock hours, contact person, access codes).',
    `number_of_packages` STRING COMMENT 'Total count of individual packages or handling units in the delivery.',
    `packaging_type` STRING COMMENT 'Type of packaging used for the delivery (standard box, insulated box, dry ice shipper, gel pack shipper, cryogenic shipper, pallet).. Valid values are `standard_box|insulated_box|dry_ice_shipper|gel_pack_shipper|cryogenic_shipper|pallet`',
    `proof_of_delivery_url` STRING COMMENT 'URL link to the electronic proof of delivery document or signature capture from the carrier system.',
    `sds_reference_number` STRING COMMENT 'Reference number for the Safety Data Sheet document providing hazard information and safe handling instructions for chemical reagents and consumables.',
    `ship_to_address_line1` STRING COMMENT 'First line of the shipping destination address (street address, building number).',
    `ship_to_address_line2` STRING COMMENT 'Second line of the shipping destination address (suite, floor, department).',
    `ship_to_city` STRING COMMENT 'City name of the shipping destination.',
    `ship_to_country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code of the shipping destination (e.g., USA, GBR, DEU).. Valid values are `^[A-Z]{3}$`',
    `ship_to_postal_code` STRING COMMENT 'Postal or ZIP code of the shipping destination.',
    `ship_to_state_province` STRING COMMENT 'State or province code of the shipping destination.',
    `shipment_method` STRING COMMENT 'Transportation mode used for the delivery (ground, air, ocean, cold-chain ground, cold-chain air, courier).. Valid values are `ground|air|ocean|cold_chain_ground|cold_chain_air|courier`',
    `shipping_point` STRING COMMENT 'SAP shipping point code representing the organizational unit responsible for shipping activities. Typically a 4-character alphanumeric code.. Valid values are `^[A-Z0-9]{4}$`',
    `temperature_range_max_c` DECIMAL(18,2) COMMENT 'Maximum allowable temperature in Celsius for cold-chain shipments to ensure product stability and quality.',
    `temperature_range_min_c` DECIMAL(18,2) COMMENT 'Minimum allowable temperature in Celsius for cold-chain shipments to ensure product stability and quality.',
    `total_gross_weight_kg` DECIMAL(18,2) COMMENT 'Total gross weight of the delivery including packaging materials, measured in kilograms. Used for freight cost calculation and carrier capacity planning.',
    `total_net_weight_kg` DECIMAL(18,2) COMMENT 'Total net weight of the delivery excluding packaging materials, measured in kilograms. Represents the actual product weight.',
    `tracking_number` STRING COMMENT 'Carrier-provided tracking number for real-time shipment visibility and customer self-service tracking.',
    `un_number` STRING COMMENT 'Four-digit UN number identifying hazardous substances for international transport (e.g., UN1845 for dry ice). Required when dangerous_goods_flag is true.. Valid values are `^UN[0-9]{4}$`',
    CONSTRAINT pk_delivery PRIMARY KEY(`delivery_id`)
) COMMENT 'Outbound delivery document representing the physical fulfillment instruction for one or more order lines — covering instruments, reagent kits, consumables, and flow cells. Sourced from ERP outbound delivery processing. Captures delivery document number, delivery type, delivery date, goods issue date, goods issue status, warehouse number, shipping point, carrier name, carrier SCAC code, tracking number, shipment method (ground, air, cold-chain), cold-chain requirement flag, temperature range requirement, packaging type, total gross weight, total net weight, number of packages, incoterms, export declaration number, dangerous goods flag, and SDS reference.';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`order`.`delivery_line` (
    `delivery_line_id` BIGINT COMMENT 'Unique identifier for the delivery line item within the outbound delivery document. Primary key for this entity.',
    `batch_id` BIGINT COMMENT 'Foreign key linking to supply.batch. Business justification: Critical for GMP compliance and 21 CFR Part 11 traceability. Each delivered reagent/kit must trace to a qualified batch with QC release status, COA number, expiry date, and cold-chain compliance flag.',
    `catalog_item_id` BIGINT COMMENT 'Reference to the master product being shipped on this delivery line. Links to the product catalog for instruments, reagents, consumables, or sequencing kits.',
    `coa_id` BIGINT COMMENT 'Foreign key linking to reagent.coa. Business justification: Certificates of Analysis must accompany reagent shipments in genomics biotech. FK enables automated CoA document retrieval for customer portals, regulatory audit trails, and quality documentation requ',
    `delivery_id` BIGINT COMMENT 'Reference to the parent outbound delivery document header. Links this line item to its containing shipment.',
    `header_id` BIGINT COMMENT 'Reference to the originating sales order that triggered this delivery line. Enables traceability from shipment back to customer order.',
    `lot_id` BIGINT COMMENT 'Foreign key linking to reagent.lot. Business justification: Delivery documentation must capture exact lot shipped for cold chain validation, customer acceptance, and regulatory compliance. FK provides manufacturing date, expiry, QC status, and CoA reference re',
    `material_id` BIGINT COMMENT 'Foreign key linking to supply.material. Business justification: Delivery lines ship specific materials from supply master. Link enables batch traceability, expiry date validation, hazmat classification enforcement, and COA reference number attachment for GMP-compl',
    `production_batch_id` BIGINT COMMENT 'Foreign key linking to manufacturing.production_batch. Business justification: Delivery documentation for genomics products requires batch/lot traceability for regulatory compliance, CoA attachment, and field complaint investigation. Delivery lines must reference production batc',
    `line_id` BIGINT COMMENT 'Reference to the specific sales order line item being fulfilled by this delivery line. Establishes one-to-one or many-to-one fulfillment relationship.',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: Delivery lines must reference SKUs for lot/batch traceability, Certificate of Analysis generation, regulatory compliance documentation, and inventory depletion. Critical for GMP/GDP compliance and shi',
    `cold_chain_handling_instruction` STRING COMMENT 'Temperature control requirements for shipping and storage of this product. Critical for reagent stability and assay performance. Specifies required temperature range during transit.. Valid values are `ambient|refrigerated_2_8c|frozen_minus_20c|frozen_minus_80c|dry_ice|liquid_nitrogen`',
    `country_of_origin` STRING COMMENT 'Three-letter ISO country code indicating where this product was manufactured. Required for customs documentation and trade compliance.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this delivery line record was first created in the system. Marks the beginning of the delivery line lifecycle.',
    `currency_code` STRING COMMENT 'Three-letter ISO currency code for the line value amount. Typically matches the sales order currency.. Valid values are `^[A-Z]{3}$`',
    `delivery_line_status` STRING COMMENT 'Overall lifecycle status of this delivery line. Tracks progression from order release through goods issue and shipment. [ENUM-REF-CANDIDATE: open|in_picking|picked|packed|goods_issued|cancelled|on_hold — 7 candidates stripped; promote to reference product]',
    `delivery_quantity` DECIMAL(18,2) COMMENT 'The quantity of product being shipped on this delivery line. Represents the actual amount picked, packed, and dispatched to the customer.',
    `expiry_date` DATE COMMENT 'The expiration date for reagents, consumables, and sequencing kits. Critical for quality assurance and regulatory compliance. Products must be used before this date to ensure performance specifications.',
    `goods_issue_date` DATE COMMENT 'The date on which goods issue was posted for this delivery line. Marks the official transfer of ownership and inventory reduction in the ERP system.',
    `goods_issue_quantity` DECIMAL(18,2) COMMENT 'The quantity for which goods issue has been posted in the ERP system. Represents the inventory reduction and financial posting amount. May differ from delivery quantity in case of partial shipments.',
    `gross_weight_kg` DECIMAL(18,2) COMMENT 'Gross weight of the product on this delivery line in kilograms, including all packaging materials. Used for carrier billing and freight planning.',
    `harmonized_tariff_code` STRING COMMENT 'International harmonized system code for customs classification. Determines duty rates, import restrictions, and trade statistics reporting.. Valid values are `^[0-9]{6,10}$`',
    `hazmat_classification` STRING COMMENT 'Hazardous material classification for shipping compliance. Determines packaging, labeling, and carrier requirements. Common for reagents containing flammable solvents, corrosive buffers, or biological materials. [ENUM-REF-CANDIDATE: non_hazardous|flammable_liquid|corrosive|oxidizer|toxic|biological_substance|dry_ice|lithium_battery — 8 candidates stripped; promote to reference product]',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to this delivery line record. Tracks changes to quantities, status, or other attributes throughout the fulfillment process.',
    `line_number` STRING COMMENT 'Sequential line item number within the delivery document. Determines the ordering and position of this line in the shipment manifest.',
    `line_value_amount` DECIMAL(18,2) COMMENT 'Total monetary value of this delivery line based on the delivered quantity and unit price. Used for shipment insurance valuation and customs declaration.',
    `manufacturing_date` DATE COMMENT 'The date on which this product lot or batch was manufactured. Used for shelf-life calculation, quality tracking, and regulatory traceability.',
    `net_weight_kg` DECIMAL(18,2) COMMENT 'Net weight of the product on this delivery line in kilograms, excluding packaging. Used for shipping cost calculation and customs documentation.',
    `pack_status` STRING COMMENT 'Current status of the packing process for this delivery line. Indicates whether the item has been placed in shipping containers with appropriate cold-chain or hazmat packaging.. Valid values are `not_started|in_progress|packed|quality_hold|cancelled`',
    `pick_status` STRING COMMENT 'Current status of the warehouse picking process for this delivery line. Tracks progression from pick list generation through physical item retrieval.. Valid values are `not_started|in_progress|picked|short_picked|cancelled`',
    `product_regulatory_status` STRING COMMENT 'Regulatory classification of the product being shipped. RUO (Research Use Only) for research products, IVD (In Vitro Diagnostic) for clinical products, CE-IVD for European market, FDA-cleared/approved for US clinical use.. Valid values are `RUO|IVD|CE_IVD|FDA_cleared|FDA_approved|LDT`',
    `rejection_reason_code` STRING COMMENT 'Code indicating why this delivery line was rejected, cancelled, or placed on hold. Examples include insufficient inventory, quality hold, customer request, or regulatory block.. Valid values are `^[A-Z0-9]{2,10}$`',
    `serial_number` STRING COMMENT 'Unique serial number for serialized products such as sequencing instruments, flow cell scanners, and high-value equipment. Enables unit-level tracking, warranty management, and service history.. Valid values are `^[A-Z0-9-]{8,40}$`',
    `special_handling_instructions` STRING COMMENT 'Free-text field capturing any special handling requirements for this delivery line. May include fragile handling, orientation requirements, light sensitivity, or customer-specific instructions.',
    `storage_location_code` STRING COMMENT 'The warehouse storage location code from which this product was picked. Identifies the specific bin, shelf, or cold storage zone within the distribution center.. Valid values are `^[A-Z0-9]{4,10}$`',
    `un_number` STRING COMMENT 'Four-digit UN identification number for hazardous materials. Required for international shipping compliance and carrier acceptance. Examples: UN1170 (ethanol), UN3373 (biological substance).. Valid values are `^UN[0-9]{4}$`',
    `unit_of_measure` STRING COMMENT 'The unit of measure for the delivery quantity. Common values include EA (each) for instruments, KIT for reagent kits, VIAL for liquid reagents, PLATE for array plates. [ENUM-REF-CANDIDATE: EA|KIT|BOX|VIAL|PLATE|SET|UNIT|L|ML|G|KG — 11 candidates stripped; promote to reference product]',
    `volume_cubic_meters` DECIMAL(18,2) COMMENT 'Total volume occupied by this delivery line item in cubic meters. Used for warehouse space planning and freight optimization.',
    CONSTRAINT pk_delivery_line PRIMARY KEY(`delivery_line_id`)
) COMMENT 'Individual line item within an outbound delivery document specifying the exact product, lot, batch, and quantity being shipped. Captures delivery line number, product SKU, product description, delivery quantity, unit of measure, lot number (LOT), batch number, serial number (for instruments), storage location, pick status, pack status, goods issue quantity, COA reference number, expiry date for reagents/consumables, cold-chain handling instruction, and hazardous material classification.';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`order`.`shipment` (
    `shipment_id` BIGINT COMMENT 'Unique identifier for the shipment record. Primary key.',
    `delivery_id` BIGINT COMMENT 'Reference to the delivery document that this shipment executes. Multiple deliveries may be consolidated into one shipment.',
    `deviation_id` BIGINT COMMENT 'Foreign key linking to quality.quality_deviation. Business justification: Temperature excursions or shipping violations during cold chain transport are quality deviations requiring investigation. Real-time monitoring systems flag deviations, QA investigates impact on produc',
    `header_id` BIGINT COMMENT 'Reference to the parent sales order that this shipment fulfills. Links to the order management system.',
    `actual_delivery_date` DATE COMMENT 'Date the shipment was physically received and signed for by the customer or designated recipient. Null until delivery is confirmed.',
    `carrier_name` STRING COMMENT 'Name of the logistics carrier responsible for transporting the shipment (e.g., FedEx, UPS, DHL, specialized cold-chain provider).',
    `carrier_sla_breach_flag` BOOLEAN COMMENT 'Indicates whether the carrier failed to meet the committed delivery Service Level Agreement (SLA). True if actual delivery date exceeds estimated delivery date by the SLA tolerance threshold.',
    `carrier_tracking_number` STRING COMMENT 'Unique tracking identifier assigned by the carrier for real-time shipment visibility and proof of delivery.',
    `cold_chain_required_flag` BOOLEAN COMMENT 'Indicates whether this shipment contains temperature-sensitive reagents, consumables, or biological samples requiring continuous cold-chain monitoring. True if cold-chain logistics are mandatory.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the shipment record was first created in the system. Used for audit trail and data lineage.',
    `customer_reference_number` STRING COMMENT 'Customer-provided purchase order number, project code, or internal reference for shipment tracking and invoice reconciliation.',
    `destination_address_line1` STRING COMMENT 'Primary street address line of the customer delivery location. Organizational contact data classified as confidential.',
    `destination_address_line2` STRING COMMENT 'Secondary address line for suite, building, or department information at the delivery location. Organizational contact data classified as confidential.',
    `destination_city` STRING COMMENT 'City name of the customer delivery location. Organizational contact data classified as confidential.',
    `destination_country_code` STRING COMMENT 'Three-letter ISO country code of the customer delivery location (e.g., USA, GBR, DEU, CHN).. Valid values are `^[A-Z]{3}$`',
    `destination_postal_code` STRING COMMENT 'Postal or ZIP code of the customer delivery location. Organizational contact data classified as confidential.',
    `destination_state_province` STRING COMMENT 'State, province, or region of the customer delivery location. Organizational contact data classified as confidential.',
    `estimated_delivery_date` DATE COMMENT 'Carrier-provided or system-calculated expected delivery date based on service level and transit time.',
    `export_declaration_number` STRING COMMENT 'Customs export declaration or Electronic Export Information (EEI) filing number for international shipments. Required for cross-border regulatory compliance.',
    `freight_cost_amount` DECIMAL(18,2) COMMENT 'Total freight and logistics cost charged by the carrier for this shipment, in the companys reporting currency. Used for Cost of Goods Sold (COGS) calculation and profitability analysis.',
    `freight_cost_currency_code` STRING COMMENT 'Three-letter ISO currency code for the freight cost amount (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `hazmat_class` STRING COMMENT 'United Nations (UN) hazard classification code for hazardous materials in the shipment (e.g., Class 6.2 for infectious substances, Class 9 for miscellaneous). Null if hazmat_flag is false.',
    `hazmat_flag` BOOLEAN COMMENT 'Indicates whether the shipment contains hazardous materials requiring special handling, labeling, and regulatory documentation per Department of Transportation (DOT) or International Air Transport Association (IATA) regulations. True if hazmat present.',
    `incoterm_code` STRING COMMENT 'Three-letter Incoterms code defining the division of costs, risks, and responsibilities between seller and buyer for international shipments (e.g., DDP = Delivered Duty Paid, FOB = Free On Board). [ENUM-REF-CANDIDATE: EXW|FCA|CPT|CIP|DAP|DPU|DDP|FAS|FOB|CFR|CIF — 11 candidates stripped; promote to reference product]',
    `insurance_value_amount` DECIMAL(18,2) COMMENT 'Declared value of the shipment contents for insurance purposes. Used to determine coverage limits and premium calculation.',
    `insurance_value_currency_code` STRING COMMENT 'Three-letter ISO currency code for the insurance value amount (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the shipment record was last modified. Used for change tracking and data synchronization.',
    `origin_facility_code` STRING COMMENT 'Code identifying the warehouse, distribution center, or manufacturing plant from which the shipment originated. Format: XXX-XXXX.. Valid values are `^[A-Z]{3}-[A-Z0-9]{4}$`',
    `package_count` STRING COMMENT 'Number of individual packages, boxes, or containers included in this shipment. Used for receiving verification and inventory reconciliation.',
    `proof_of_delivery_reference` STRING COMMENT 'Reference identifier or URI to the signed proof of delivery document (e.g., signature image, electronic confirmation). Used for dispute resolution and audit trail.',
    `ship_date` DATE COMMENT 'Date the shipment departed from the origin facility. Used for Turnaround Time (TAT) calculation and Service Level Agreement (SLA) tracking.',
    `shipment_method` STRING COMMENT 'Shipping service level selected for this shipment. Determines transit time and cost. Values: ground, air, express, overnight, international, cold_chain (temperature-controlled).. Valid values are `ground|air|express|overnight|international|cold_chain`',
    `shipment_number` STRING COMMENT 'Business-facing unique shipment identifier used for tracking and customer communication. Format: SHP-xxxxxxxxxx.. Valid values are `^SHP-[0-9]{10}$`',
    `shipment_status` STRING COMMENT 'Current lifecycle status of the shipment. Values: booked (carrier confirmed), in_transit (en route), out_for_delivery (final mile), delivered (received by customer), exception (delay or issue), cancelled (shipment voided).. Valid values are `booked|in_transit|out_for_delivery|delivered|exception|cancelled`',
    `special_handling_instructions` STRING COMMENT 'Free-text field capturing any special handling requirements for the shipment (e.g., Fragile - Handle with Care, This Side Up, Keep Frozen, Deliver to Loading Dock Only).',
    `tat_compliance_status` STRING COMMENT 'Indicates whether the shipment met the customer-committed Turnaround Time (TAT) from order placement to delivery. Values: compliant (delivered within TAT), at_risk (approaching deadline), breached (missed TAT), not_applicable (no TAT commitment).. Valid values are `compliant|at_risk|breached|not_applicable`',
    `temperature_excursion_flag` BOOLEAN COMMENT 'Indicates whether the shipment experienced a temperature excursion outside the acceptable range during transit. True if excursion detected. Triggers quality review and potential product rejection.',
    `temperature_log_reference` STRING COMMENT 'Reference identifier or URI to the detailed temperature monitoring log file (e.g., data logger serial number, cloud storage path). Used for compliance audit and quality investigation.',
    `temperature_range_max_celsius` DECIMAL(18,2) COMMENT 'Maximum allowable temperature in degrees Celsius for cold-chain shipments. Null for non-temperature-controlled shipments.',
    `temperature_range_min_celsius` DECIMAL(18,2) COMMENT 'Minimum allowable temperature in degrees Celsius for cold-chain shipments. Null for non-temperature-controlled shipments.',
    `total_volume_cubic_meters` DECIMAL(18,2) COMMENT 'Total volumetric size of the shipment in cubic meters. Used for dimensional weight pricing and warehouse space planning.',
    `total_weight_kg` DECIMAL(18,2) COMMENT 'Total gross weight of the shipment in kilograms, including packaging materials. Used for freight cost calculation and carrier capacity planning.',
    `un_number` STRING COMMENT 'Four-digit United Nations identification number for hazardous materials (e.g., UN3373 for biological substances). Null if hazmat_flag is false. Format: UNxxxx.. Valid values are `^UN[0-9]{4}$`',
    CONSTRAINT pk_shipment PRIMARY KEY(`shipment_id`)
) COMMENT 'Physical shipment record tracking the movement of one or more deliveries from Genomics Biotech warehouse to the customer site. Captures shipment number, carrier name, carrier tracking number, shipment status (booked, in-transit, out-for-delivery, delivered, exception), ship date, estimated delivery date, actual delivery date, origin facility, destination address, shipment method, cold-chain monitoring flag, temperature excursion flag, temperature log reference, proof-of-delivery reference, carrier SLA breach flag, and TAT compliance status.';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`order`.`return_authorization` (
    `return_authorization_id` BIGINT COMMENT 'Primary key for return_authorization',
    `approval_id` BIGINT COMMENT 'Foreign key linking to regulatory.regulatory_approval. Business justification: Returns of regulated genomics products (sequencing kits, arrays, instruments) trigger post-market surveillance obligations, adverse event assessment per ISO 13485, and field safety action evaluation. ',
    `batch_id` BIGINT COMMENT 'Foreign key linking to supply.batch. Business justification: GMP deviation investigations require batch-level traceability for returned goods. Links return to batch QC status, COA, manufacturing date, and supplier batch number for root cause analysis and suppli',
    `complaint_id` BIGINT COMMENT 'Foreign key linking to quality.complaint. Business justification: Returns are often initiated by quality complaints. RMA systems link to complaint records for disposition decisions (credit, replacement, investigation), CAPA initiation, and customer satisfaction trac',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Return processing costs, restocking fees, and quality investigation expenses charged to quality assurance or customer service cost centers. Supports GxP-compliant cost tracking for product complaints ',
    `account_id` BIGINT COMMENT 'Reference to the customer account requesting the return.',
    `deviation_id` BIGINT COMMENT 'Foreign key linking to quality.quality_deviation. Business justification: Product returns may trigger quality deviations when defects are confirmed during QC inspection. QA reviews returned goods, documents deviations (GxP classification, severity), and initiates investigat',
    `lot_id` BIGINT COMMENT 'Foreign key linking to reagent.lot. Business justification: Product returns require lot-level traceability for quality investigations, stability studies, and CAPA. FK enables root cause analysis linking returned material to manufacturing batch, QC results, sto',
    `material_id` BIGINT COMMENT 'Foreign key linking to supply.material. Business justification: Returns reference specific materials for disposition decisions (restock, scrap, quarantine), quality investigations, and CAPA initiation. Enables material-level return rate analysis and supplier quali',
    `nonconformance_id` BIGINT COMMENT 'Foreign key linking to quality.nonconformance. Business justification: Returned products failing inspection generate nonconformance records (NCRs). Warehouse QC inspection creates NCRs for supplier notification, disposition decisions (scrap, rework, use-as-is), and inter',
    `employee_id` BIGINT COMMENT 'Reference to the quality control inspector who performed the return inspection.',
    `header_id` BIGINT COMMENT 'Reference to the original sales order from which this return originated.',
    `production_batch_id` BIGINT COMMENT 'Foreign key linking to manufacturing.production_batch. Business justification: Product return investigations in regulated genomics require root cause analysis tied to manufacturing batch records. Quality teams analyze returns by batch to identify process deviations, environmenta',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: RMA records reference specific SKUs for credit calculation, quality investigation, CAPA initiation, and regulatory deviation reporting. Essential for post-market surveillance and complaint handling in',
    `test_order_id` BIGINT COMMENT 'Foreign key linking to clinical.test_order. Business justification: When clinical test kits, reagents, or sample collection supplies are returned, linking to the originating test order enables root cause analysis, quality event tracking, and CAPA. Critical for GxP com',
    `warehouse_location_id` BIGINT COMMENT 'Reference to the warehouse or facility where the returned goods were received.',
    `capa_number` STRING COMMENT 'Reference to the CAPA investigation record if corrective action was initiated.. Valid values are `^CAPA-[A-Z0-9]{8,12}$`',
    `capa_required_flag` BOOLEAN COMMENT 'Boolean indicator whether this return requires a formal CAPA investigation and corrective action plan.',
    `carrier_name` STRING COMMENT 'Name of the shipping carrier used for the return shipment.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this return authorization record was first created in the system.',
    `credit_memo_number` STRING COMMENT 'Reference to the financial credit memo document issued to the customer upon return approval.. Valid values are `^CM-[A-Z0-9]{8,12}$`',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the return value amount.. Valid values are `^[A-Z]{3}$`',
    `disposition_code` STRING COMMENT 'Final disposition decision for the returned goods based on inspection results (restock, quarantine, destroy, rework, scrap, return-to-vendor).. Valid values are `restock|quarantine|destroy|rework|scrap|return-to-vendor`',
    `expiration_date` DATE COMMENT 'Expiration date of the returned product, particularly relevant for reagents and consumables with limited shelf life.',
    `gmp_deviation_flag` BOOLEAN COMMENT 'Boolean indicator whether this return triggered a GMP deviation investigation due to quality or compliance concerns.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this return authorization record was last updated.',
    `qc_inspection_date` DATE COMMENT 'Date when the quality control inspection of the returned goods was completed.',
    `qc_inspection_notes` STRING COMMENT 'Detailed notes and observations recorded by the QC inspector during the return inspection.',
    `qc_inspection_result` STRING COMMENT 'Quality control inspection outcome upon receipt of the returned goods.. Valid values are `pass|fail|pending|not-applicable`',
    `restocking_fee_amount` DECIMAL(18,2) COMMENT 'Restocking fee charged to the customer for processing the return, if applicable per return policy.',
    `return_authorized_date` DATE COMMENT 'Date when the return authorization was approved and RMA number was issued.',
    `return_credited_date` DATE COMMENT 'Date when the credit memo was issued and the customer account was credited.',
    `return_quantity` DECIMAL(18,2) COMMENT 'Quantity of units being returned by the customer.',
    `return_reason_code` STRING COMMENT 'Standardized code indicating the business reason for the return request.. Valid values are `defective|wrong-item|expired|over-shipment|customer-cancellation|damaged-in-transit`',
    `return_reason_description` STRING COMMENT 'Detailed free-text explanation of the return reason provided by the customer or customer service representative.',
    `return_received_date` DATE COMMENT 'Date when the returned goods were physically received at the warehouse or facility.',
    `return_requested_date` DATE COMMENT 'Date when the customer initially requested the return authorization.',
    `return_shipping_cost` DECIMAL(18,2) COMMENT 'Cost of shipping the returned goods, which may be borne by the customer or the company depending on return reason.',
    `return_status` STRING COMMENT 'Current lifecycle status of the return authorization workflow. [ENUM-REF-CANDIDATE: requested|authorized|in-transit|received|inspected|credited|rejected|cancelled — 8 candidates stripped; promote to reference product]',
    `return_value_amount` DECIMAL(18,2) COMMENT 'Total monetary value of the returned goods in the transaction currency.',
    `rma_number` STRING COMMENT 'Externally-known return authorization number issued to the customer for tracking and processing the return.. Valid values are `^RMA-[A-Z0-9]{8,12}$`',
    `root_cause_category` STRING COMMENT 'High-level categorization of the root cause identified during return investigation.. Valid values are `manufacturing-defect|shipping-damage|storage-issue|customer-error|system-error|supplier-defect`',
    `serial_number` STRING COMMENT 'Unique serial number of the returned instrument or equipment unit, if applicable.',
    `temperature_excursion_flag` BOOLEAN COMMENT 'Boolean indicator whether the returned product experienced temperature excursion during storage or transit, affecting product integrity.',
    `tracking_number` STRING COMMENT 'Shipment tracking number provided by the carrier for the return shipment.',
    `unit_of_measure` STRING COMMENT 'Unit of measure for the return quantity (each, kit, box, vial, plate, cartridge). [ENUM-REF-CANDIDATE: EA|KIT|BOX|VIAL|PLATE|CARTRIDGE|UNIT — 7 candidates stripped; promote to reference product]',
    CONSTRAINT pk_return_authorization PRIMARY KEY(`return_authorization_id`)
) COMMENT 'Customer return authorization and processing record for instruments, reagent kits, consumables, or flow cells that are defective, expired, or incorrectly shipped. Sourced from ERP returns processing. Captures return order number, original sales order reference, return reason code (defective, wrong-item, expired, over-shipment, customer-cancellation), return authorization number (RMA), return status (requested, authorized, in-transit, received, inspected, credited), customer account ID, return quantity, return value, credit memo reference, QC inspection result upon receipt, disposition code (restock, quarantine, destroy), and GMP deviation flag.';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`order`.`status_event` (
    `status_event_id` BIGINT COMMENT 'Unique identifier for each order status transition event. Primary key for the order status event log.',
    `account_id` BIGINT COMMENT 'Identifier of the customer who placed the order. Denormalized from the order record to enable direct customer-level TAT and SLA reporting from the event log.',
    `employee_id` BIGINT COMMENT 'Identifier of the user or service account that triggered the status change. Null for fully automated system transitions.',
    `header_id` BIGINT COMMENT 'Identifier of the sales order that experienced this status transition. Links this event to the parent order entity.',
    `warehouse_location_id` BIGINT COMMENT 'Identifier of the warehouse or fulfillment center processing this order at the time of the status transition. Enables location-specific TAT analysis.',
    `actual_delivery_date` DATE COMMENT 'The actual date the order was delivered to the customer. Populated only when the status transitions to delivered or completed.',
    `carrier_code` STRING COMMENT 'Code identifying the shipping carrier (e.g., FedEx, UPS, DHL) when the order is shipped. Null for pre-shipment transitions.',
    `comments` STRING COMMENT 'Free-text comments or notes entered by the user or system at the time of the status transition. Provides additional context for audit and troubleshooting.',
    `data_source` STRING COMMENT 'Name of the upstream data source or integration pipeline that delivered this event record (e.g., SAP_SD_CDC, Salesforce_API, Manual_Entry).',
    `distribution_channel` STRING COMMENT 'SAP distribution channel through which the order was placed (e.g., direct_sales, distributor, e-commerce). Supports channel-specific SLA tracking.',
    `event_sequence_number` STRING COMMENT 'Sequential number indicating the order of this event within the lifecycle of the parent order (1 for first transition, 2 for second, etc.). Enables chronological reconstruction of order history.',
    `event_timestamp` TIMESTAMP COMMENT 'Precise date and time when the order status transition occurred in the source system. Represents the real-world business event time, distinct from audit timestamps.',
    `expected_delivery_date` DATE COMMENT 'The expected delivery date communicated to the customer at the time of this status transition. Updated as the order progresses through fulfillment.',
    `ingestion_timestamp` TIMESTAMP COMMENT 'Timestamp when this event record was ingested into the Databricks lakehouse. Distinct from event_timestamp, which represents the business event time.',
    `is_reversal_flag` BOOLEAN COMMENT 'Indicates whether this status transition represents a reversal or rollback of a previous status (e.g., moving from shipped back to in_fulfillment due to a return). True for backward transitions.',
    `new_status` STRING COMMENT 'The order status after this transition event. Captures the to-state in the order lifecycle state machine. [ENUM-REF-CANDIDATE: draft|submitted|confirmed|in_fulfillment|shipped|delivered|completed|cancelled|on_hold — 9 candidates stripped; promote to reference product]',
    `notification_channel` STRING COMMENT 'The communication channel used to notify the customer of this status change (e.g., email, SMS, customer portal). Null if no notification was sent.. Valid values are `email|sms|portal|none`',
    `notification_sent_flag` BOOLEAN COMMENT 'Indicates whether an automated customer notification (email, SMS) was sent for this status transition. Supports customer communication audit.',
    `order_priority` STRING COMMENT 'Priority level of the order at the time of this status transition. Affects SLA targets and fulfillment sequencing.. Valid values are `standard|expedited|urgent|rush|critical`',
    `order_type` STRING COMMENT 'Type of sales order experiencing this status transition (e.g., instrument_sale, reagent_order, sequencing_service, consumable_order, software_license). Enables segmented TAT analysis by product category.',
    `previous_status` STRING COMMENT 'The order status immediately before this transition event. Captures the from-state in the order lifecycle state machine. [ENUM-REF-CANDIDATE: draft|submitted|confirmed|in_fulfillment|shipped|delivered|completed|cancelled|on_hold — 9 candidates stripped; promote to reference product]',
    `reversal_reason` STRING COMMENT 'Explanation for why the order status was reversed or rolled back. Null for forward-progressing transitions.',
    `sales_organization` STRING COMMENT 'SAP sales organization responsible for this order at the time of the status transition. Enables regional TAT performance analysis.',
    `shipment_tracking_number` STRING COMMENT 'Carrier tracking number assigned when the order status transitions to shipped. Null for pre-shipment status transitions.',
    `sla_breach_flag` BOOLEAN COMMENT 'Indicates whether this status transition occurred after the committed SLA deadline, representing a breach of customer service commitments. True if TAT exceeded target.',
    `sla_breach_severity` STRING COMMENT 'Classification of the severity of the SLA breach based on how much the TAT exceeded the target (e.g., minor for <4 hours late, major for >24 hours late).. Valid values are `none|minor|moderate|major|critical`',
    `sla_milestone_flag` BOOLEAN COMMENT 'Indicates whether this status transition represents a contractual SLA milestone (e.g., order-confirmed, shipped-on-time, delivered-on-time). True if this event is an SLA checkpoint.',
    `sla_milestone_name` STRING COMMENT 'Name of the SLA milestone associated with this status transition (e.g., Order Confirmation, Shipment Dispatch, Delivery Completion). Null if not an SLA milestone.',
    `source_system_transaction_reference` STRING COMMENT 'Unique transaction or event identifier from the source system (SAP SD document number, Salesforce event ID) that triggered this status change. Enables traceability back to the originating system.',
    `status_change_reason_code` STRING COMMENT 'Standardized code indicating the business reason for the status transition (e.g., customer_request, inventory_available, quality_hold, shipment_dispatched).',
    `status_change_reason_description` STRING COMMENT 'Free-text explanation or additional context describing why the order status changed. Provides human-readable detail beyond the reason code.',
    `tat_elapsed_hours` DECIMAL(18,2) COMMENT 'Total elapsed time in hours from order creation to this status transition. Enables TAT tracking and performance analysis against committed delivery timelines.',
    `tat_target_hours` DECIMAL(18,2) COMMENT 'The target TAT in hours for reaching this status milestone, as defined by customer SLA or internal operational standards. Null if no target is defined for this transition.',
    `triggered_by_system` STRING COMMENT 'The source system or application that initiated this status transition (e.g., SAP SD for fulfillment updates, Salesforce CRM for order entry, manual override by user).. Valid values are `SAP_SD|Salesforce_CRM|ServiceNow|Manual|Automated_Workflow|External_API`',
    `triggered_by_user_name` STRING COMMENT 'Full name of the user who triggered the status change. Supports audit trail and accountability for manual interventions.',
    CONSTRAINT pk_status_event PRIMARY KEY(`status_event_id`)
) COMMENT 'Immutable event log capturing every status transition in the lifecycle of a sales order — from order creation through fulfillment, shipment, delivery, and closure. Enables SLA-driven TAT tracking and order lifecycle audit. Captures event timestamp, order ID, previous status, new status, status change reason, triggered-by system (SAP SD, Salesforce, manual), triggered-by user ID, SLA milestone flag (e.g., order-confirmed, shipped-on-time, delivered-on-time), TAT elapsed hours at transition, and SLA breach indicator.';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`order`.`fulfillment_instruction` (
    `fulfillment_instruction_id` BIGINT COMMENT 'Unique identifier for the fulfillment instruction record. Primary key for the fulfillment instruction entity.',
    `asset_id` BIGINT COMMENT 'Foreign key linking to instrument.instrument_asset. Business justification: Installation fulfillment instructions must reference the specific serialized instrument asset being deployed for installation qualification execution, site preparation validation, and asset tracking. ',
    `assigned_team_org_unit_id` BIGINT COMMENT 'Reference to the field service team, logistics crew, or installation squad assigned to execute this instruction. Used for install, service_dispatch, and field-based fulfillment types.',
    `employee_id` BIGINT COMMENT 'Reference to the field service engineer assigned to perform installation or service dispatch. Used for resource scheduling and performance tracking.',
    `header_id` BIGINT COMMENT 'Reference to the confirmed sales order that this fulfillment instruction executes. Links to the parent order in SAP SD.',
    `internal_order_id` BIGINT COMMENT 'Foreign key linking to finance.internal_order. Business justification: Installation and qualification services for sequencing instruments execute against internal orders (capex projects). Links service fulfillment activities to project cost tracking and asset capitalizat',
    `org_unit_id` BIGINT COMMENT 'Reference to the warehouse, distribution center, or service depot responsible for executing this instruction. Null if assigned to field service team rather than facility.',
    `sequencing_run_id` BIGINT COMMENT 'Foreign key linking to sequencing.sequencing_run. Business justification: Fulfillment instructions for sequencing service orders must specify which sequencing run executes the order. Critical for operations tracking, linking commercial orders to lab execution, TAT monitorin',
    `warehouse_location_id` BIGINT COMMENT 'Foreign key linking to supply.warehouse_location. Business justification: Picking instructions specify exact bin locations for temperature-controlled reagents, hazmat materials, and serialized instruments. Enables FEFO enforcement, cold-chain zone validation, and GMP-compli',
    `actual_completion_timestamp` TIMESTAMP COMMENT 'Timestamp when fulfillment was successfully completed (shipment dispatched, installation signed off, or license activated). Used for TAT compliance reporting and customer notification.',
    `actual_execution_start_timestamp` TIMESTAMP COMMENT 'Timestamp when fulfillment execution actually began (warehouse pick started, field engineer arrived on site, or activation process initiated). Used for TAT performance measurement.',
    `completion_confirmation_signature` STRING COMMENT 'Digital signature or confirmation code from customer or field engineer acknowledging successful fulfillment completion. Used for proof of delivery, installation acceptance, or service completion.',
    `contact_email` STRING COMMENT 'Email address for shipment notifications, installation appointment confirmations, and service dispatch updates. Used for automated customer communication.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `contact_name` STRING COMMENT 'Name of the individual at the delivery location authorized to receive shipment or coordinate installation. Used for carrier delivery confirmation and field service appointment scheduling.',
    `contact_phone` STRING COMMENT 'Phone number for delivery coordination, installation scheduling, or service dispatch communication. Used by carriers and field service engineers.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this fulfillment instruction record was created in the system. Typically occurs immediately after sales order confirmation. Used for audit trail and TAT calculation baseline.',
    `customs_declaration_number` STRING COMMENT 'Customs authority reference number for international shipments. Required for cross-border fulfillment to comply with import/export regulations and tariff classification.. Valid values are `^[A-Z0-9]{10,20}$`',
    `execution_status` STRING COMMENT 'Current state of the fulfillment instruction in its execution lifecycle. Pending = awaiting assignment; Assigned = allocated to facility or team; In_Progress = actively being executed; Completed = successfully fulfilled; Cancelled = instruction voided; On_Hold = temporarily suspended; Failed = execution unsuccessful. [ENUM-REF-CANDIDATE: pending|assigned|in_progress|completed|cancelled|on_hold|failed — 7 candidates stripped; promote to reference product]',
    `export_control_classification` STRING COMMENT 'U.S. Commerce Department Export Control Classification Number for dual-use technology and controlled items. Required for sequencing instruments and bioinformatics software with encryption. Ensures compliance with Export Administration Regulations (EAR).. Valid values are `^[A-Z0-9]{4,10}$`',
    `failure_notes` STRING COMMENT 'Free-text explanation providing additional context for fulfillment failure or cancellation. Captured by warehouse staff, field engineer, or logistics coordinator.',
    `failure_reason_code` STRING COMMENT 'Standardized code explaining why fulfillment execution failed or was cancelled. None = no failure. Used for root cause analysis and process improvement. [ENUM-REF-CANDIDATE: address_invalid|recipient_unavailable|customs_hold|damaged_in_transit|installation_site_not_ready|technical_issue|cancelled_by_customer|none — 8 candidates stripped; promote to reference product]',
    `installation_appointment_timestamp` TIMESTAMP COMMENT 'Scheduled date and time for instrument installation or field service visit. Applicable for install and service_dispatch instruction types. Coordinated with customer and field service engineer availability.',
    `instruction_number` STRING COMMENT 'Business-readable unique identifier for the fulfillment instruction, formatted as FI- followed by 10 digits. Used for tracking and communication with warehouse, logistics, and field service teams.. Valid values are `^FI-[0-9]{10}$`',
    `instruction_type` STRING COMMENT 'Category of fulfillment action required. Ship = standard pick-pack-ship; Install = instrument installation with field service engineer; Service_Dispatch = field service task; Activate = software license or cloud service activation; Sample_Kit_Dispatch = sequencing service sample collection kit; Cold_Chain_Ship = temperature-controlled logistics for reagents/enzymes.. Valid values are `ship|install|service_dispatch|activate|sample_kit_dispatch|cold_chain_ship`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to this fulfillment instruction record. Tracks status changes, assignment updates, and completion events. Used for audit trail and change tracking.',
    `license_activation_key` STRING COMMENT 'Unique activation key for software license or cloud service entitlement. Applicable for activate instruction type. Generated by license management system and delivered to customer via secure channel.. Valid values are `^[A-Z0-9]{16,32}$`',
    `packing_list_number` STRING COMMENT 'Reference to the warehouse packing list document detailing items included in shipment. Used for shipment verification and customs documentation.. Valid values are `^PL-[0-9]{10}$`',
    `priority_level` STRING COMMENT 'Business priority assigned to this fulfillment instruction. Critical = immediate action required (e.g., clinical diagnostic emergency); High = expedited processing; Normal = standard processing; Low = non-urgent.. Valid values are `critical|high|normal|low`',
    `scheduled_execution_date` DATE COMMENT 'Planned date for fulfillment execution (ship date, installation date, or service dispatch date). Used for capacity planning and customer communication.',
    `ship_to_address_line1` STRING COMMENT 'Primary street address line for delivery destination. Copied from sales order ship-to party at instruction creation. May differ from customer billing address.',
    `ship_to_address_line2` STRING COMMENT 'Secondary address line for delivery destination (suite, building, department). Optional field for additional address detail.',
    `ship_to_city` STRING COMMENT 'City name for delivery destination. Used for logistics routing and customs documentation.',
    `ship_to_country_code` STRING COMMENT 'Three-letter ISO country code for delivery destination (e.g., USA, GBR, DEU). Used for customs, export control, and regulatory compliance (FDA, EMA, IVDR jurisdictional rules).. Valid values are `^[A-Z]{3}$`',
    `ship_to_postal_code` STRING COMMENT 'Postal or ZIP code for delivery destination. Used for carrier routing and delivery time estimation.',
    `ship_to_state_province` STRING COMMENT 'State, province, or region for delivery destination. Used for tax calculation and regulatory compliance (e.g., state-specific IVD regulations).',
    `shipping_carrier_code` STRING COMMENT 'Standard carrier identifier for logistics provider (e.g., FEDEX, UPS, DHL, WORLDCOURIER). Applicable for ship and cold_chain_ship instruction types. Null for non-shipping fulfillment.. Valid values are `^[A-Z0-9]{2,10}$`',
    `shipping_service_level` STRING COMMENT 'Carrier service tier selected for shipment. Overnight = next-day delivery; Two_Day = 2-business-day; Ground = standard surface; International_Express = expedited cross-border; International_Standard = economy cross-border; White_Glove = premium instrument delivery with setup.. Valid values are `overnight|two_day|ground|international_express|international_standard|white_glove`',
    `special_handling_code` STRING COMMENT 'Logistics and handling requirements for this fulfillment. Dry_Ice = dry ice packaging for frozen reagents; Controlled_Rate_Freezer = CRF shipping for enzyme stability; Ambient = room temperature; Refrigerated = 2-8°C cold chain; Hazmat = hazardous materials compliance; Fragile = delicate instruments; High_Value = security escort; Biohazard = biosafety protocols; None = standard handling. [ENUM-REF-CANDIDATE: dry_ice|controlled_rate_freezer|ambient|refrigerated|hazmat|fragile|high_value|biohazard|none — 9 candidates stripped; promote to reference product]',
    `tat_deadline_timestamp` TIMESTAMP COMMENT 'Service Level Agreement (SLA) deadline by which this fulfillment instruction must be completed. Derived from order TAT commitment and used for SLA compliance monitoring.',
    `temperature_monitoring_required_flag` BOOLEAN COMMENT 'Indicates whether cold-chain temperature monitoring is required during transit. True for reagents, enzymes, and temperature-sensitive consumables requiring Good Distribution Practice (GDP) compliance. Triggers data logger inclusion in shipment.',
    `tracking_number` STRING COMMENT 'Carrier-provided tracking identifier for shipment visibility. Populated after shipment dispatch. Used for customer self-service tracking and delivery confirmation.. Valid values are `^[A-Z0-9]{10,35}$`',
    CONSTRAINT pk_fulfillment_instruction PRIMARY KEY(`fulfillment_instruction_id`)
) COMMENT 'Operational directive translating a confirmed sales order into specific warehouse, logistics, or field service execution tasks. Covers standard pick-pack-ship, cold-chain logistics coordination (dry ice, controlled-rate shipping for enzymes/reagents), instrument installation scheduling with field service engineers, sequencing service sample-kit dispatch, and software license activation. Captures instruction type (ship, install, service-dispatch, activate), execution status, assigned facility or field team, priority level, special handling codes, scheduled execution date, TAT deadline, and completion confirmation. Serves as the orchestration layer between commercial order management and physical/digital fulfillment.';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`order`.`customer_acceptance` (
    `customer_acceptance_id` BIGINT COMMENT 'Unique identifier for the customer acceptance record. Primary key for this entity.',
    `account_id` BIGINT COMMENT 'Reference to the customer who is providing acceptance confirmation. The party receiving and accepting the goods or services.',
    `asset_id` BIGINT COMMENT 'Foreign key linking to instrument.instrument_asset. Business justification: Customer acceptance of installed sequencing instruments triggers revenue recognition, warranty activation, and service contract initiation. Links acceptance testing (IQ/OQ/PQ completion) to specific s',
    `batch_id` BIGINT COMMENT 'Foreign key linking to supply.batch. Business justification: Revenue recognition for reagent kits and consumables tied to specific batch acceptance. Links acceptance to batch COA, QC release status, and expiry date for regulatory submission documentation and cu',
    `capa_id` BIGINT COMMENT 'Reference to the CAPA record initiated from this acceptance event. Links to quality management system for tracking corrective actions. Null if no CAPA was initiated.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Acceptance record creation attribution supports quality system compliance, CLIA/CAP audit requirements, and revenue recognition process validation. New FK replaces denormalized created_by text field w',
    `experiment_id` BIGINT COMMENT 'Foreign key linking to research.experiment. Business justification: Customer acceptance of sequencing data deliverables is tied to specific experiments in customer research workflows. Provides research context beyond sequencing_run_id, enabling experiment-level qualit',
    `fair_assessment_id` BIGINT COMMENT 'Foreign key linking to data.fair_assessment. Business justification: NIH-funded genomics projects require FAIR-compliant data delivery. Customer acceptance for research-grade sequencing data includes FAIR assessment verification (persistent identifiers, metadata comple',
    `genome_assembly_id` BIGINT COMMENT 'Foreign key linking to reference.genome_assembly. Business justification: Clinical sequencing data acceptance requires documenting the reference genome build used for alignment and variant calling to meet CAP/CLIA reproducibility requirements and enable customer validation ',
    `header_id` BIGINT COMMENT 'Reference to the sales order for which acceptance is being recorded. Links to the originating commercial transaction in SAP SD.',
    `production_batch_id` BIGINT COMMENT 'Foreign key linking to manufacturing.production_batch. Business justification: Instrument installation qualification and sequencing service acceptance criteria include batch-specific performance data. Customer acceptance records must link to production batches for revenue recogn',
    `revenue_recognition_id` BIGINT COMMENT 'Foreign key linking to finance.revenue_recognition. Business justification: Direct link from customer acceptance event to revenue recognition record enables ASC 606 compliance. Acceptance of sequencing data delivery or instrument installation qualification satisfies performan',
    `sequencing_run_id` BIGINT COMMENT 'Reference to the sequencing run for which data delivery acceptance is being recorded. Applicable only for sequencing service acceptance types. Links to NGS data generation event.',
    `shipment_id` BIGINT COMMENT 'Reference to the shipment delivery associated with this acceptance event. Tracks physical delivery of goods.',
    `variant_database_version_id` BIGINT COMMENT 'Foreign key linking to reference.variant_database_version. Business justification: Clinical variant interpretation service acceptance requires documenting the specific variant database versions (ClinVar, gnomAD, COSMIC releases) used for annotation to meet regulatory traceability re',
    `acceptance_date` DATE COMMENT 'Calendar date on which the customer formally accepted the delivered goods or completed services. Key milestone for revenue recognition under ASC 606 and contract fulfillment.',
    `acceptance_document_url` STRING COMMENT 'Storage location or reference path to the signed acceptance document or certificate. Points to document management system (Veeva Vault) for audit and compliance retrieval.',
    `acceptance_method` STRING COMMENT 'Mechanism through which the customer provided acceptance confirmation. Distinguishes between electronic signature, paper-based signature, email confirmation, customer portal acknowledgment, or automated system integration.. Valid values are `electronic_signature|paper_signature|email_confirmation|portal_acknowledgment|automated_system`',
    `acceptance_notes` STRING COMMENT 'Free-text field for additional comments, observations, or special conditions related to the acceptance event. Captures context not covered by structured fields.',
    `acceptance_number` STRING COMMENT 'Business-facing unique identifier for the acceptance record. Human-readable reference number used in customer communications and audit trails.. Valid values are `^ACC-[0-9]{8}$`',
    `acceptance_status` STRING COMMENT 'Current lifecycle state of the acceptance record. Tracks progression from pending customer review through final accepted or rejected state. Critical for revenue recognition trigger and order closure workflow.. Valid values are `pending|accepted|rejected|conditionally_accepted|disputed|cancelled`',
    `acceptance_timestamp` TIMESTAMP COMMENT 'Precise date and time when the customer acceptance was recorded in the system. Provides audit trail for compliance and SLA tracking.',
    `acceptance_type` STRING COMMENT 'Category of acceptance event. Distinguishes between physical goods receipt confirmation, instrument installation qualification sign-off (IQ/OQ/PQ), sequencing data delivery acceptance, software implementation go-live acknowledgment, or service completion confirmation.. Valid values are `goods_receipt|installation_sign_off|sequencing_data_delivery|software_go_live|service_completion`',
    `actual_acceptance_days` STRING COMMENT 'Actual number of days elapsed from delivery to customer acceptance. Calculated as the difference between delivery date and acceptance date. Used for SLA compliance reporting.',
    `capa_initiated` BOOLEAN COMMENT 'Boolean indicator of whether a Corrective and Preventive Action was initiated as a result of this acceptance event. True when rejection or conditional acceptance triggers quality investigation.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this acceptance record was first created in the system. Audit trail field for compliance and data lineage.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the revenue amount. Indicates the currency in which the transaction value is denominated.. Valid values are `^[A-Z]{3}$`',
    `data_delivery_format` STRING COMMENT 'File format in which sequencing or bioinformatics data was delivered to the customer. Applicable for sequencing data delivery acceptance types. Tracks compliance with customer specifications.. Valid values are `FASTQ|BAM|VCF|CRAM|HDF5|other`',
    `data_quality_metric_passed` BOOLEAN COMMENT 'Boolean indicator of whether delivered sequencing data met agreed-upon quality thresholds (Phred score, coverage depth, read length). True indicates data passed QC specifications. Applicable for sequencing data delivery acceptance.',
    `installation_qualification_status` STRING COMMENT 'Status of instrument qualification protocol execution for IVD and GxP installations. Tracks completion of Installation Qualification, Operational Qualification, and Performance Qualification phases. Applicable only for instrument acceptance types. [ENUM-REF-CANDIDATE: not_applicable|iq_passed|oq_passed|pq_passed|iq_failed|oq_failed|pq_failed|in_progress — 8 candidates stripped; promote to reference product]',
    `modified_by` STRING COMMENT 'User identifier or name of the system user who last modified this acceptance record. Provides audit trail for record changes.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this acceptance record was last modified in the system. Audit trail field for compliance and change tracking.',
    `qualification_completion_date` DATE COMMENT 'Date on which all required qualification protocols (IQ/OQ/PQ) were successfully completed for instrument installations. Null for non-instrument acceptance types.',
    `regulatory_submission_date` DATE COMMENT 'Date on which acceptance documentation was submitted to regulatory authorities. Null if no regulatory submission is required or submission has not yet occurred.',
    `regulatory_submission_required` BOOLEAN COMMENT 'Boolean indicator of whether this acceptance event requires submission to regulatory authorities (FDA, EMA) as part of post-market surveillance or clinical trial reporting. True for IVD and clinical genomics acceptances.',
    `rejection_reason_code` STRING COMMENT 'Standardized code indicating the primary reason for customer rejection or conditional acceptance. Used for root cause analysis and quality improvement. Null when acceptance status is accepted. [ENUM-REF-CANDIDATE: damaged_goods|incomplete_delivery|specification_mismatch|failed_qualification|data_quality_issue|late_delivery|other — 7 candidates stripped; promote to reference product]',
    `rejection_reason_description` STRING COMMENT 'Free-text detailed explanation of the rejection or conditional acceptance. Captures customer-provided specifics for quality investigation and corrective action. Null when acceptance status is accepted.',
    `revenue_amount` DECIMAL(18,2) COMMENT 'Monetary value of revenue recognized upon this acceptance event. Represents the portion of the sales order value that becomes recognizable revenue based on customer acceptance.',
    `revenue_recognition_date` DATE COMMENT 'Date on which revenue was recognized in the financial system based on this acceptance event. Aligns with ASC 606 performance obligation satisfaction. Null if revenue recognition has not yet occurred.',
    `revenue_recognition_triggered` BOOLEAN COMMENT 'Boolean indicator of whether this acceptance event triggered revenue recognition in the financial system. True when acceptance satisfies ASC 606 performance obligation criteria and revenue can be recognized.',
    `signatory_email` STRING COMMENT 'Email address of the signatory for acceptance confirmation and audit trail purposes. Used for electronic signature verification and communication.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `signatory_name` STRING COMMENT 'Full name of the individual who signed off on the acceptance on behalf of the customer. Required for IVD and GxP compliance documentation.',
    `signatory_title` STRING COMMENT 'Job title or role of the individual who provided acceptance sign-off. Validates authority to accept on behalf of the customer organization.',
    `sla_compliance_flag` BOOLEAN COMMENT 'Boolean indicator of whether the acceptance was received within the SLA target timeframe. True indicates on-time acceptance per contractual commitment.',
    `sla_target_acceptance_days` STRING COMMENT 'Number of days from delivery within which customer acceptance is expected per contractual SLA. Used to track on-time acceptance performance and customer responsiveness.',
    CONSTRAINT pk_customer_acceptance PRIMARY KEY(`customer_acceptance_id`)
) COMMENT 'Formal record of customer sign-off confirming receipt and acceptance of delivered goods or completed services — critical for revenue recognition milestones and IVD/GxP compliance. Covers goods-receipt confirmation, instrument installation sign-off (post-IQ/OQ/PQ), sequencing data delivery acceptance, and software go-live acknowledgment. Captures acceptance type, status, signatory, rejection reasons, and revenue recognition trigger.';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`order`.`credit_memo` (
    `credit_memo_id` BIGINT COMMENT 'Unique identifier for the credit memo record. Primary key.',
    `complaint_id` BIGINT COMMENT 'Foreign key linking to quality.complaint. Business justification: Credits issued for quality-related complaints (defective products, failed sequencing runs, service failures). Finance links credit memos to complaint records for revenue impact tracking, customer sati',
    `account_id` BIGINT COMMENT 'Reference to the customer account receiving the credit. Used for accounts receivable reconciliation and customer balance updates.',
    `employee_id` BIGINT COMMENT 'Reference to the employee or manager who approved the credit memo. Used for audit trail and accountability in credit authorization process.',
    `header_id` BIGINT COMMENT 'Reference to the original sales order against which this credit memo was issued. Links to the order that generated the original revenue.',
    `journal_entry_id` BIGINT COMMENT 'Foreign key linking to finance.journal_entry. Business justification: Credit memos generate GL journal entries for revenue reversal and AR adjustment. Direct link supports SOX audit trail, reconciliation between order management and financial accounting systems, and mon',
    `return_authorization_id` BIGINT COMMENT 'Reference to the return order that triggered this credit memo, if applicable. Null for non-return credit scenarios such as pricing corrections or goodwill credits.',
    `test_order_id` BIGINT COMMENT 'Foreign key linking to clinical.test_order. Business justification: When clinical test services are credited due to cancellation, quality issues, or billing errors, linking credit memos to originating test orders enables financial reconciliation, revenue adjustment tr',
    `accounting_document_reference` STRING COMMENT 'Reference to the general ledger accounting document created for this credit memo. Links credit memo to financial postings in the ERP system.. Valid values are `^[A-Z0-9]{10,20}$`',
    `approval_date` DATE COMMENT 'Date when the credit memo was approved by the authorized approver. Used for tracking approval cycle time and compliance with credit policies.',
    `approval_status` STRING COMMENT 'Current approval status of the credit memo in the workflow. Determines whether the credit has been authorized for issuance and posting to customer account.. Valid values are `pending|approved|rejected|cancelled`',
    `billing_document_number` STRING COMMENT 'The ERP system billing document number associated with this credit memo. Used for financial reconciliation and audit trail in SAP FI/CO modules.. Valid values are `^[A-Z0-9]{10,15}$`',
    `company_code` STRING COMMENT 'SAP company code representing the legal entity issuing the credit memo. Used for legal entity reporting and statutory compliance.. Valid values are `^[A-Z0-9]{4,10}$`',
    `cost_center` STRING COMMENT 'Cost center to which the credit memo impact is allocated for internal cost accounting and profitability analysis.. Valid values are `^[A-Z0-9]{6,12}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the credit memo record was first created in the system. Used for audit trail and process cycle time analysis.',
    `credit_amount` DECIMAL(18,2) COMMENT 'The gross credit amount issued to the customer before tax adjustments. Represents the base value of goods or services being credited.',
    `credit_memo_number` STRING COMMENT 'Externally-known business identifier for the credit memo, typically generated by the ERP billing system. Used for customer communication and accounting reconciliation.. Valid values are `^CM-[0-9]{8,12}$`',
    `credit_memo_type` STRING COMMENT 'Classification of the credit memo based on the business reason for issuance. Determines accounting treatment and approval workflow.. Valid values are `return-credit|price-correction|goodwill|service-failure|billing-error|volume-rebate`',
    `credit_reason_code` STRING COMMENT 'Standardized code indicating the specific reason for credit issuance. Used for root cause analysis, quality tracking, and process improvement. Examples: defective product, shipping damage, pricing error, SLA breach, customer satisfaction.. Valid values are `^[A-Z0-9]{2,10}$`',
    `credit_reason_description` STRING COMMENT 'Detailed free-text explanation of the reason for issuing the credit memo. Provides context for audits, customer service, and dispute resolution.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the credit memo transaction. Determines the currency in which the credit is issued and recorded.. Valid values are `^[A-Z]{3}$`',
    `customer_reference_number` STRING COMMENT 'Customer-provided reference number or purchase order number associated with the original transaction. Used for customer reconciliation and dispute resolution.',
    `distribution_channel` STRING COMMENT 'SAP distribution channel through which the original sale and subsequent credit occurred. Examples: direct sales, distributor, e-commerce.. Valid values are `^[A-Z0-9]{2,10}$`',
    `division` STRING COMMENT 'SAP division code representing the product line or business unit. Examples: sequencing instruments, reagents and consumables, bioinformatics software.. Valid values are `^[A-Z0-9]{2,10}$`',
    `fiscal_period` STRING COMMENT 'Fiscal period (month) within the fiscal year when the credit memo was posted. Used for monthly financial reporting and period reconciliation.',
    `fiscal_year` STRING COMMENT 'Fiscal year in which the credit memo was posted. Used for financial reporting, period closing, and year-over-year analysis.',
    `issue_date` DATE COMMENT 'Date when the credit memo was officially issued to the customer. Represents the business event date for revenue reversal and accounts receivable adjustment.',
    `last_modified_by` BIGINT COMMENT 'Reference to the user who last modified the credit memo record. Used for audit trail and change tracking.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the credit memo record was last modified. Used for audit trail and data currency tracking.',
    `notes` STRING COMMENT 'Additional free-text notes or comments regarding the credit memo. Captures special circumstances, customer agreements, or internal coordination details.',
    `payment_method` STRING COMMENT 'Method by which the credit will be returned to the customer. Determines cash flow impact and accounts receivable treatment.. Valid values are `account-credit|refund-check|refund-wire|refund-credit-card|offset-invoice`',
    `posting_date` DATE COMMENT 'Date when the credit memo was posted to the general ledger and customer account. May differ from issue_date due to batch processing or period-end adjustments.',
    `profit_center` STRING COMMENT 'Profit center for internal management reporting and segment profitability analysis. Tracks credit impact by business segment.. Valid values are `^[A-Z0-9]{6,12}$`',
    `refund_date` DATE COMMENT 'Date when the refund payment was processed and sent to the customer. Null if payment method is account credit or offset.',
    `refund_status` STRING COMMENT 'Status of the refund payment process if the credit memo requires a cash refund. Not applicable for account credits or invoice offsets.. Valid values are `not-applicable|pending|processed|completed|failed`',
    `revenue_reversal_flag` BOOLEAN COMMENT 'Indicates whether this credit memo triggers a revenue reversal in the financial system. True for credits against recognized revenue (e.g., sequencing service orders with milestone-based recognition), false for credits that do not impact revenue (e.g., advance payment adjustments).',
    `sales_organization` STRING COMMENT 'SAP sales organization code responsible for this credit memo. Used for organizational reporting and revenue allocation.. Valid values are `^[A-Z0-9]{4,10}$`',
    `tax_amount` DECIMAL(18,2) COMMENT 'The total tax amount credited back to the customer. Includes sales tax, VAT, or other applicable taxes reversed as part of the credit memo.',
    `total_credit_amount` DECIMAL(18,2) COMMENT 'The total credit amount including tax. Represents the full value credited to the customer account (credit_amount + tax_amount).',
    `created_by` BIGINT COMMENT 'Reference to the user or system that created the credit memo record. Used for audit trail and accountability.',
    CONSTRAINT pk_credit_memo PRIMARY KEY(`credit_memo_id`)
) COMMENT 'Credit memo record issued to customers following approved returns, billing corrections, pricing disputes, or service failures — linked to the originating sales order and return order. Sourced from ERP billing/credit processing. Captures credit memo number, ERP billing document number, linked return order ID, linked original sales order ID, credit memo type (return-credit, price-correction, goodwill, service-failure), credit amount, currency, tax amount, credit reason code, approval status, approver ID, issue date, customer account ID, and accounting document reference. Triggers revenue reversal for milestone-based recognition on sequencing service orders.';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`order`.`trade_compliance_check` (
    `trade_compliance_check_id` BIGINT COMMENT 'Unique identifier for the trade compliance check record. Primary key for the trade compliance check entity.',
    `approval_id` BIGINT COMMENT 'Foreign key linking to regulatory.regulatory_approval. Business justification: Export control screening for genomics products must verify regulatory classification—ECCN determination depends on IVD vs RUO designation and intended use (gene sequencing for clinical vs research). B',
    `controlled_document_id` BIGINT COMMENT 'Foreign key linking to quality.controlled_document. Business justification: Export compliance requires QMS documentation (ISO 13485 certificates, GMP compliance letters, CE marks, FDA registrations). Trade compliance officers reference controlled documents for regulatory subm',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Export compliance screening costs (denied party checks, ECCN classification, license applications) allocated to trade compliance cost center. Enables tracking of regulatory compliance overhead for int',
    `dpia_id` BIGINT COMMENT 'Foreign key linking to data.dpia. Business justification: Export of sequencing instruments/software to non-US entities requires DPIA when equipment will process human genomic data under GDPR Article 35. Trade compliance screening references DPIA to assess cr',
    `header_id` BIGINT COMMENT 'Reference to the sales order being screened for export control and trade compliance. Links to the sales order that triggered this compliance check.',
    `employee_id` BIGINT COMMENT 'Reference to the trade compliance officer who performed manual review or approval of this check. Populated when compliance_officer_review_flag is True.',
    `approval_timestamp` TIMESTAMP COMMENT 'Timestamp when the compliance check was approved and the sales order was cleared for shipment. Represents the completion of the compliance workflow.',
    `check_number` STRING COMMENT 'Human-readable business identifier for the compliance check record. Format: TCC-YYYYMMDD followed by sequence number.. Valid values are `^TCC-[0-9]{8}$`',
    `check_validity_end_date` DATE COMMENT 'Date until which this compliance check remains valid. After this date, a new compliance check must be performed before shipment can proceed. Typically 30-90 days from screening date depending on risk profile.',
    `check_validity_start_date` DATE COMMENT 'Date from which this compliance check is valid. Compliance checks have limited validity periods and must be refreshed if the order is delayed or circumstances change.',
    `compliance_officer_review_flag` BOOLEAN COMMENT 'Indicates whether this compliance check requires or has received manual review by a trade compliance officer. True if manual review is required or completed; False if automated screening is sufficient.',
    `compliance_status` STRING COMMENT 'Current status of the trade compliance check. Cleared indicates approval for export; blocked indicates denial; pending-review requires manual review; conditional-approval requires additional documentation; escalated requires senior compliance officer review; expired indicates check validity has lapsed.. Valid values are `cleared|pending-review|blocked|conditional-approval|escalated|expired`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this trade compliance check record was first created in the system. Used for audit trail and compliance record retention.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the shipment value amount (e.g., USD, EUR, GBP). Used for financial reporting and customs valuation.. Valid values are `^[A-Z]{3}$`',
    `customer_country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code for the customer destination. Used to determine export control jurisdiction and licensing requirements.. Valid values are `^[A-Z]{3}$`',
    `denied_party_list_name` STRING COMMENT 'Name of the specific denied party list where a match was found (e.g., BIS Denied Persons List, BIS Entity List, OFAC SDN List). Populated only when denied_party_screening_result is fail or manual-review-required.',
    `denied_party_screening_result` STRING COMMENT 'Result of screening the customer and end-user against U.S. government denied parties lists including the Denied Persons List, Entity List, Unverified List, and Specially Designated Nationals. Pass indicates no match; fail indicates a match requiring transaction block; manual-review-required indicates potential match requiring compliance officer investigation.. Valid values are `pass|fail|manual-review-required`',
    `dual_use_flag` BOOLEAN COMMENT 'Indicates whether the product being exported is classified as dual-use technology (items that have both commercial and military or proliferation applications). True for dual-use items requiring enhanced export control scrutiny.',
    `eccn` STRING COMMENT 'Export Control Classification Number assigned to the product being exported. Alphanumeric code (e.g., 3A001.b) that identifies items subject to U.S. Department of Commerce export controls under the Commerce Control List.. Valid values are `^[0-9][A-Z][0-9]{3}(.[a-z])?$`',
    `end_use_declaration` STRING COMMENT 'Customer-provided statement describing the intended use of the genomic instruments, reagents, or data products. Required for dual-use technology assessment and export control classification.',
    `harmonized_tariff_code` STRING COMMENT 'Harmonized System tariff classification code for customs and duty assessment. Six to ten digit code used for international trade documentation and customs clearance.. Valid values are `^[0-9]{6,10}$`',
    `itar_controlled_flag` BOOLEAN COMMENT 'Indicates whether the product is subject to ITAR controls administered by the U.S. Department of State Directorate of Defense Trade Controls. True if ITAR-controlled; False if subject only to EAR or no export controls.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this trade compliance check record was last updated. Tracks changes to compliance status, review notes, or other fields for audit purposes.',
    `license_exception_code` STRING COMMENT 'Three-letter code identifying the applicable license exception (e.g., ENC for encryption, TSU for technology and software unrestricted, RPL for servicing and replacement parts). Populated when no full export license is required but an exception applies.. Valid values are `^[A-Z]{3}$`',
    `license_number` STRING COMMENT 'Government-issued export license number authorizing the shipment. Populated when license_requirement_flag is True and a valid license has been obtained from the Bureau of Industry and Security or other regulatory authority.. Valid values are `^[A-Z0-9]{10,20}$`',
    `license_requirement_flag` BOOLEAN COMMENT 'Indicates whether an export license is required for this transaction based on the product ECCN, destination country, and end-use. True if license required; False if license exception or no license required applies.',
    `product_category` STRING COMMENT 'High-level category of the product being exported. Used to determine applicable export control regulations and compliance workflows specific to genomics and biotechnology products.. Valid values are `instrument|reagent|consumable|sequencing-service|software|genomic-data`',
    `product_sku` STRING COMMENT 'Stock Keeping Unit identifier for the specific product being exported. Links to the product master data for detailed specifications and export control classification.',
    `regulatory_hold_reference` STRING COMMENT 'Reference number or identifier for any regulatory hold, investigation, or enforcement action related to this compliance check. Populated when the transaction is subject to ongoing regulatory scrutiny or voluntary self-disclosure.',
    `review_date` DATE COMMENT 'Date when the compliance officer completed manual review of the trade compliance check. Populated when compliance_officer_review_flag is True.',
    `review_notes` STRING COMMENT 'Free-text notes entered by the compliance officer documenting the rationale for the compliance decision, additional due diligence performed, or conditions attached to approval. Used for audit trail and regulatory defense.',
    `risk_category` STRING COMMENT 'Categorical risk classification derived from the risk score. Low risk transactions may proceed with automated approval; high and critical risk require compliance officer review and enhanced documentation.. Valid values are `low|medium|high|critical`',
    `risk_score` DECIMAL(18,2) COMMENT 'Numerical risk score (0.00 to 100.00) assigned by the screening system based on destination country, product sensitivity, customer profile, and end-use. Higher scores indicate elevated export control risk requiring enhanced due diligence.',
    `routed_export_transaction_flag` BOOLEAN COMMENT 'Indicates whether this is a routed export transaction where a foreign principal party in interest (FPPI) authorizes a U.S. agent to facilitate export. True for routed exports requiring special documentation and compliance procedures.',
    `screening_date` DATE COMMENT 'Date when the trade compliance screening was performed. Represents the business event date for the compliance check execution.',
    `screening_system_name` STRING COMMENT 'Name and version of the automated trade compliance screening system used to perform the check (e.g., SAP Global Trade Services, Descartes Visual Compliance, Amber Road). Used for audit trail and system validation.',
    `screening_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the automated screening system executed the compliance check. Used for audit trail and time-sensitive compliance validation.',
    `shipment_value_amount` DECIMAL(18,2) COMMENT 'Total commercial value of the goods being exported in the transaction currency. Used for export documentation, customs declaration, and license threshold determination.',
    `ultimate_consignee_country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code for the ultimate consignee location. May differ from customer_country_code if goods are transshipped or re-exported.. Valid values are `^[A-Z]{3}$`',
    `ultimate_consignee_name` STRING COMMENT 'Name of the ultimate end-user or consignee who will receive and use the exported goods. May differ from the bill-to customer. Required for denied party screening and end-use verification.',
    CONSTRAINT pk_trade_compliance_check PRIMARY KEY(`trade_compliance_check_id`)
) COMMENT 'Export control and trade compliance screening record for sales orders involving instruments, reagents, or genomic data products subject to EAR (Export Administration Regulations), ITAR, or dual-use restrictions. Captures compliance check ID, linked sales order ID, customer country, end-use declaration, export control classification number (ECCN), license requirement flag, license number (if applicable), denied party screening result (pass/fail), screening date, screening system used, compliance officer review flag, compliance status (cleared, pending-review, blocked), and regulatory hold reference.';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`order`.`customer_po` (
    `customer_po_id` BIGINT COMMENT 'Unique identifier for the customer purchase order record. Primary key.',
    `account_id` BIGINT COMMENT 'Reference to the customer account that issued this purchase order.',
    `employee_id` BIGINT COMMENT 'Reference to the internal user who approved the customer purchase order for fulfillment. Used for audit trail and accountability.',
    `finance_budget_id` BIGINT COMMENT 'Foreign key linking to finance.finance_budget. Business justification: Customer purchase orders (especially from academic/government research institutions) reference grant or budget line items. Links customer funding source to internal budget tracking for sponsored resea',
    `header_id` BIGINT COMMENT 'Reference to the internal sales order that this customer PO authorizes. Links customer procurement document to SAP SD sales order.',
    `approval_status` STRING COMMENT 'Internal approval status of the customer purchase order within Genomics Biotech order management workflow. Indicates whether the PO has been validated and approved for fulfillment.. Valid values are `pending|approved|rejected|under_review`',
    `approved_timestamp` TIMESTAMP COMMENT 'The date and time when the customer purchase order was approved for fulfillment by Genomics Biotech. Used for SLA tracking and audit trail.',
    `billing_address_line1` STRING COMMENT 'First line of the billing address specified on the customer purchase order. Used for invoice generation and accounts receivable processing.',
    `billing_address_line2` STRING COMMENT 'Second line of the billing address specified on the customer purchase order. Optional additional address detail.',
    `billing_city` STRING COMMENT 'City component of the billing address specified on the customer purchase order.',
    `billing_country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code for the billing address specified on the customer purchase order. Used for tax jurisdiction determination and regulatory compliance.. Valid values are `^[A-Z]{3}$`',
    `billing_postal_code` STRING COMMENT 'Postal code or ZIP code component of the billing address specified on the customer purchase order.',
    `billing_state_province` STRING COMMENT 'State or province component of the billing address specified on the customer purchase order.',
    `cancellation_reason` STRING COMMENT 'Free-text explanation of why the customer purchase order was cancelled. Populated only when PO status is cancelled. Used for root cause analysis and customer relationship management.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this customer purchase order record was first created in the system. Used for audit trail and data lineage.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the purchase order monetary values. Defines the currency in which PO value, consumed value, and remaining balance are denominated.. Valid values are `^[A-Z]{3}$`',
    `customer_contact_email` STRING COMMENT 'Email address of the customer contact person listed on the purchase order for order-related communication.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `customer_contact_name` STRING COMMENT 'Name of the customer contact person listed on the purchase order for order-related inquiries and coordination.',
    `customer_contact_phone` STRING COMMENT 'Phone number of the customer contact person listed on the purchase order for order-related communication.',
    `customer_erp_po_reference` STRING COMMENT 'The internal purchase order reference or document ID from the customers ERP system. Enables reconciliation between customer procurement records and Genomics Biotech sales records.',
    `customer_erp_system` STRING COMMENT 'The name or identifier of the customers ERP system from which the purchase order originated. Used for system integration and procurement process traceability.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this customer purchase order record was last updated. Used for audit trail and change tracking.',
    `payment_terms` STRING COMMENT 'The payment terms specified on the customer purchase order, such as Net 30, Net 60, or other negotiated payment conditions. Governs invoice payment due dates.',
    `po_consumed_value` DECIMAL(18,2) COMMENT 'The cumulative monetary value that has been consumed against this purchase order through fulfilled sales orders and invoices. Used to calculate remaining PO balance.',
    `po_issue_date` DATE COMMENT 'The date on which the customer formally issued the purchase order. This is the principal business event timestamp for the PO and serves as the contractual reference date.',
    `po_number` STRING COMMENT 'The customer-issued purchase order number as it appears on the formal procurement document. This is the externally-known identifier used for contractual reference and invoice matching.',
    `po_received_date` DATE COMMENT 'The date on which Genomics Biotech received and registered the customer purchase order in SAP SD. Used for order processing SLA tracking and TAT measurement.',
    `po_remaining_balance` DECIMAL(18,2) COMMENT 'The remaining available monetary value on the purchase order calculated as PO total value minus PO consumed value. Indicates how much additional value can be fulfilled against this PO.',
    `po_status` STRING COMMENT 'Current lifecycle status of the customer purchase order. Open indicates available for fulfillment, partially-consumed indicates partial delivery against PO value, fully-consumed indicates PO value exhausted, cancelled indicates customer revocation, expired indicates validity period ended, on-hold indicates temporary suspension.. Valid values are `open|partially_consumed|fully_consumed|cancelled|expired|on_hold`',
    `po_total_value` DECIMAL(18,2) COMMENT 'The total authorized monetary value of the purchase order as stated by the customer. Represents the maximum amount that can be invoiced against this PO.',
    `po_type` STRING COMMENT 'Classification of the purchase order type indicating the procurement structure. Standard for one-time orders, blanket for recurring releases, framework for multi-year agreements, government for public sector contracts, contract for negotiated terms, spot for ad-hoc purchases.. Valid values are `standard|blanket|framework|government|contract|spot`',
    `po_validity_end_date` DATE COMMENT 'The expiration date after which the purchase order is no longer valid for order fulfillment. Nullable for open-ended POs. Defines the end of the PO authorization period.',
    `po_validity_start_date` DATE COMMENT 'The effective start date from which the purchase order is valid and can be used for order fulfillment. Defines the beginning of the PO authorization period.',
    `requisitioner_name` STRING COMMENT 'Name of the individual at the customer organization who initiated or requested the purchase order. Used for order verification and approval workflows.',
    `ship_to_address_line1` STRING COMMENT 'First line of the shipping destination address specified on the customer purchase order. Used for order fulfillment and logistics planning.',
    `ship_to_address_line2` STRING COMMENT 'Second line of the shipping destination address specified on the customer purchase order. Optional additional address detail.',
    `ship_to_city` STRING COMMENT 'City component of the shipping destination address specified on the customer purchase order.',
    `ship_to_country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code for the shipping destination address specified on the customer purchase order. Used for export compliance and logistics routing.. Valid values are `^[A-Z]{3}$`',
    `ship_to_postal_code` STRING COMMENT 'Postal code or ZIP code component of the shipping destination address specified on the customer purchase order.',
    `ship_to_state_province` STRING COMMENT 'State or province component of the shipping destination address specified on the customer purchase order.',
    `shipping_terms` STRING COMMENT 'The shipping and delivery terms specified on the customer purchase order, such as FOB, CIF, DDP, or other Incoterms. Defines responsibility for shipping costs and risk transfer.',
    `special_terms_notes` STRING COMMENT 'Free-text field capturing any special terms, conditions, or instructions noted on the customer purchase order that require attention during order fulfillment. May include delivery instructions, quality requirements, or contractual clauses.',
    CONSTRAINT pk_customer_po PRIMARY KEY(`customer_po_id`)
) COMMENT 'Customer purchase order record capturing the formal procurement document issued by the customer authorizing Genomics Biotech to fulfill a sales order. Serves as the contractual reference linking customer procurement systems to SAP SD. Captures customer PO number, customer account ID, PO issue date, PO value, currency, PO type (standard, blanket, framework, government), linked sales order ID, PO validity start date, PO validity end date, remaining PO balance, PO status (open, partially-consumed, fully-consumed, cancelled), customer ERP system reference, and special terms noted on PO.';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`order`.`blanket_order` (
    `blanket_order_id` BIGINT COMMENT 'Unique identifier for the blanket order framework agreement.',
    `catalog_id` BIGINT COMMENT 'Foreign key linking to reagent.reagent_catalog. Business justification: Blanket agreements in genomics biotech cover recurring reagent purchases (quarterly sequencing kit orders). FK enables contract compliance verification, pricing tier validation, inventory planning for',
    `contract_id` BIGINT COMMENT 'Foreign key linking to commercial.commercial_contract. Business justification: In genomics biotech, master commercial contracts (MSAs, supply agreements) govern multiple blanket scheduling agreements for different product lines. Tracking which contract governs each blanket order',
    `account_id` BIGINT COMMENT 'Reference to the customer account that holds this blanket order agreement.',
    `finance_budget_id` BIGINT COMMENT 'Foreign key linking to finance.finance_budget. Business justification: Long-term supply agreements for reagents, consumables, or sequencing services tie to multi-period budget commitments. Enables budget consumption tracking and prevents over-commitment of annual procure',
    `test_catalog_id` BIGINT COMMENT 'Foreign key linking to clinical.test_catalog. Business justification: High-volume customers (reference labs, health systems) establish blanket orders for recurring clinical test services at contracted rates. Links contract-based test ordering to catalog for pricing, rel',
    `address_id` BIGINT COMMENT 'Default shipping destination location for releases under this blanket order.',
    `employee_id` BIGINT COMMENT 'Sales representative responsible for managing this blanket order relationship.',
    `opportunity_id` BIGINT COMMENT 'Salesforce CRM opportunity identifier from which this blanket order was converted, enabling traceability from opportunity to contract.',
    `sequencing_protocol_id` BIGINT COMMENT 'Foreign key linking to sequencing.sequencing_protocol. Business justification: Volume agreements for recurring sequencing services specify standard protocol for consistent pricing and service delivery. Enables "Customer ABC blanket order: 100 WGS runs/year at protocol P123" for ',
    `sku_id` BIGINT COMMENT 'FK to product.sku',
    `tertiary_blanket_contract_owner_employee_id` BIGINT COMMENT 'Internal employee responsible for contract administration and compliance for this blanket order.',
    `agreement_end_date` DATE COMMENT 'Expiration date when this blanket order agreement terminates and no further releases are permitted.',
    `agreement_start_date` DATE COMMENT 'Effective start date when this blanket order agreement becomes active and releases can begin.',
    `agreement_type` STRING COMMENT 'Type of blanket order agreement structure governing release and consumption patterns.. Valid values are `volume_commitment|value_commitment|call_off|consignment`',
    `approved_timestamp` TIMESTAMP COMMENT 'Timestamp when this blanket order was approved and activated for use.',
    `auto_renewal_flag` BOOLEAN COMMENT 'Indicates whether this blanket order automatically renews at the end of its term.',
    `blanket_order_number` STRING COMMENT 'Business-facing unique identifier for the blanket order, used in customer communications and invoicing.',
    `blanket_order_status` STRING COMMENT 'Current lifecycle status of the blanket order agreement. [ENUM-REF-CANDIDATE: draft|active|partially_consumed|fully_consumed|expired|cancelled|suspended — 7 candidates stripped; promote to reference product]',
    `consumed_quantity` DECIMAL(18,2) COMMENT 'Cumulative quantity that has been released and consumed against this blanket order to date.',
    `consumed_value` DECIMAL(18,2) COMMENT 'Cumulative monetary value that has been invoiced and consumed against this blanket order to date.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this blanket order record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary values in this blanket order.. Valid values are `^[A-Z]{3}$`',
    `discount_percentage` DECIMAL(18,2) COMMENT 'Negotiated discount percentage applied to list price for this blanket order.',
    `erp_scheduling_agreement_number` STRING COMMENT 'SAP S/4HANA SD scheduling agreement or contract number that governs this blanket order in the system of record.',
    `incoterms` STRING COMMENT 'Incoterms code defining shipping responsibilities and risk transfer for deliveries under this blanket order.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this blanket order record was most recently updated.',
    `lead_time_days` STRING COMMENT 'Standard lead time in days from release request to delivery for orders under this blanket agreement.',
    `maximum_release_quantity` DECIMAL(18,2) COMMENT 'Maximum quantity permitted in a single call-off release against this blanket order.',
    `minimum_release_quantity` DECIMAL(18,2) COMMENT 'Minimum quantity that must be requested in each individual call-off release against this blanket order.',
    `payment_terms` STRING COMMENT 'Negotiated payment terms for invoices under this blanket order (e.g., Net 30, Net 60, 2/10 Net 30).',
    `pricing_tier` STRING COMMENT 'Volume-based pricing tier or discount level locked for this blanket order agreement.',
    `product_category` STRING COMMENT 'High-level classification of the product type covered by this blanket order.. Valid values are `reagent_kit|consumable|sequencing_service|instrument|software_license|support_service`',
    `product_sku` STRING COMMENT 'Stock Keeping Unit identifier for the reagent kit, consumable, or sequencing service covered by this blanket order.',
    `regulatory_use_designation` STRING COMMENT 'Regulatory classification of products under this blanket order: Research Use Only (RUO), In Vitro Diagnostic (IVD), Laboratory Developed Test (LDT), or Good Manufacturing Practice (GMP).. Valid values are `RUO|IVD|LDT|GMP`',
    `release_frequency` STRING COMMENT 'Agreed-upon frequency pattern for call-off releases against this blanket order.. Valid values are `weekly|biweekly|monthly|quarterly|on_demand`',
    `remaining_quantity` DECIMAL(18,2) COMMENT 'Quantity remaining available for future call-off releases under this blanket order.',
    `remaining_value` DECIMAL(18,2) COMMENT 'Monetary value remaining available for future releases under this blanket order.',
    `renewal_notice_days` STRING COMMENT 'Number of days prior to expiration that renewal notification must be provided.',
    `special_terms_conditions` STRING COMMENT 'Additional negotiated terms, conditions, or clauses specific to this blanket order agreement.',
    `termination_notice_days` STRING COMMENT 'Number of days advance notice required for early termination of this blanket order.',
    `total_committed_quantity` DECIMAL(18,2) COMMENT 'Total quantity of product or service units committed under this blanket order agreement over its full term.',
    `total_committed_value` DECIMAL(18,2) COMMENT 'Total monetary value committed under this blanket order agreement over its full term.',
    `unit_of_measure` STRING COMMENT 'Unit of measure for the committed quantity (e.g., EA for each, KIT for kit, RUN for sequencing run, GB for gigabase).',
    `unit_price` DECIMAL(18,2) COMMENT 'Pre-negotiated unit price locked for this blanket order, applicable to all releases during the agreement term.',
    CONSTRAINT pk_blanket_order PRIMARY KEY(`blanket_order_id`)
) COMMENT 'Long-term framework agreement with a customer for recurring purchases of reagent kits, consumables, or sequencing services over a defined period — enabling call-off releases against pre-negotiated volume and price commitments. Common for large genome centers and biopharma accounts with predictable consumption patterns. Captures blanket order number, ERP scheduling agreement or contract number, customer account ID, product SKU or service type, total committed quantity, total committed value, currency, agreement start date, agreement end date, release frequency, minimum release quantity, consumed quantity to date, remaining quantity, pricing tier locked, and blanket order status (active, partially-consumed, fully-consumed, expired, cancelled).';

-- ========= FOREIGN KEYS =========
ALTER TABLE `genomics_biotech_ecm`.`order`.`line` ADD CONSTRAINT `fk_order_line_blanket_order_id` FOREIGN KEY (`blanket_order_id`) REFERENCES `genomics_biotech_ecm`.`order`.`blanket_order`(`blanket_order_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`line` ADD CONSTRAINT `fk_order_line_header_id` FOREIGN KEY (`header_id`) REFERENCES `genomics_biotech_ecm`.`order`.`header`(`header_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`quotation` ADD CONSTRAINT `fk_order_quotation_header_id` FOREIGN KEY (`header_id`) REFERENCES `genomics_biotech_ecm`.`order`.`header`(`header_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`quotation_line` ADD CONSTRAINT `fk_order_quotation_line_quotation_id` FOREIGN KEY (`quotation_id`) REFERENCES `genomics_biotech_ecm`.`order`.`quotation`(`quotation_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`delivery` ADD CONSTRAINT `fk_order_delivery_header_id` FOREIGN KEY (`header_id`) REFERENCES `genomics_biotech_ecm`.`order`.`header`(`header_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`delivery_line` ADD CONSTRAINT `fk_order_delivery_line_delivery_id` FOREIGN KEY (`delivery_id`) REFERENCES `genomics_biotech_ecm`.`order`.`delivery`(`delivery_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`delivery_line` ADD CONSTRAINT `fk_order_delivery_line_header_id` FOREIGN KEY (`header_id`) REFERENCES `genomics_biotech_ecm`.`order`.`header`(`header_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`delivery_line` ADD CONSTRAINT `fk_order_delivery_line_line_id` FOREIGN KEY (`line_id`) REFERENCES `genomics_biotech_ecm`.`order`.`line`(`line_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`shipment` ADD CONSTRAINT `fk_order_shipment_delivery_id` FOREIGN KEY (`delivery_id`) REFERENCES `genomics_biotech_ecm`.`order`.`delivery`(`delivery_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`shipment` ADD CONSTRAINT `fk_order_shipment_header_id` FOREIGN KEY (`header_id`) REFERENCES `genomics_biotech_ecm`.`order`.`header`(`header_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`return_authorization` ADD CONSTRAINT `fk_order_return_authorization_header_id` FOREIGN KEY (`header_id`) REFERENCES `genomics_biotech_ecm`.`order`.`header`(`header_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`status_event` ADD CONSTRAINT `fk_order_status_event_header_id` FOREIGN KEY (`header_id`) REFERENCES `genomics_biotech_ecm`.`order`.`header`(`header_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`fulfillment_instruction` ADD CONSTRAINT `fk_order_fulfillment_instruction_header_id` FOREIGN KEY (`header_id`) REFERENCES `genomics_biotech_ecm`.`order`.`header`(`header_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`customer_acceptance` ADD CONSTRAINT `fk_order_customer_acceptance_header_id` FOREIGN KEY (`header_id`) REFERENCES `genomics_biotech_ecm`.`order`.`header`(`header_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`customer_acceptance` ADD CONSTRAINT `fk_order_customer_acceptance_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `genomics_biotech_ecm`.`order`.`shipment`(`shipment_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`credit_memo` ADD CONSTRAINT `fk_order_credit_memo_header_id` FOREIGN KEY (`header_id`) REFERENCES `genomics_biotech_ecm`.`order`.`header`(`header_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`credit_memo` ADD CONSTRAINT `fk_order_credit_memo_return_authorization_id` FOREIGN KEY (`return_authorization_id`) REFERENCES `genomics_biotech_ecm`.`order`.`return_authorization`(`return_authorization_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`trade_compliance_check` ADD CONSTRAINT `fk_order_trade_compliance_check_header_id` FOREIGN KEY (`header_id`) REFERENCES `genomics_biotech_ecm`.`order`.`header`(`header_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`customer_po` ADD CONSTRAINT `fk_order_customer_po_header_id` FOREIGN KEY (`header_id`) REFERENCES `genomics_biotech_ecm`.`order`.`header`(`header_id`);

-- ========= TAGS =========
ALTER SCHEMA `genomics_biotech_ecm`.`order` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `genomics_biotech_ecm`.`order` SET TAGS ('dbx_domain' = 'order');
ALTER TABLE `genomics_biotech_ecm`.`order`.`header` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `genomics_biotech_ecm`.`order`.`header` SET TAGS ('dbx_subdomain' = 'order_capture');
ALTER TABLE `genomics_biotech_ecm`.`order`.`header` ALTER COLUMN `header_id` SET TAGS ('dbx_business_glossary_term' = 'Header Identifier');
ALTER TABLE `genomics_biotech_ecm`.`order`.`header` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Ship-To Party ID');
ALTER TABLE `genomics_biotech_ecm`.`order`.`header` ALTER COLUMN `approval_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`header` ALTER COLUMN `bill_to_party_account_id` SET TAGS ('dbx_business_glossary_term' = 'Bill-To Party ID');
ALTER TABLE `genomics_biotech_ecm`.`order`.`header` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`header` ALTER COLUMN `created_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `genomics_biotech_ecm`.`order`.`header` ALTER COLUMN `created_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`order`.`header` ALTER COLUMN `created_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`order`.`header` ALTER COLUMN `opportunity_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Relationship Management (CRM) Opportunity ID');
ALTER TABLE `genomics_biotech_ecm`.`order`.`header` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account ID');
ALTER TABLE `genomics_biotech_ecm`.`order`.`header` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Representative ID');
ALTER TABLE `genomics_biotech_ecm`.`order`.`header` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`order`.`header` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`order`.`header` ALTER COLUMN `last_modified_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User ID');
ALTER TABLE `genomics_biotech_ecm`.`order`.`header` ALTER COLUMN `last_modified_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`order`.`header` ALTER COLUMN `last_modified_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`order`.`header` ALTER COLUMN `model_id` SET TAGS ('dbx_business_glossary_term' = 'Instrument Model Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`header` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Rd Project Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`header` ALTER COLUMN `sold_to_party_account_id` SET TAGS ('dbx_business_glossary_term' = 'Sold-To Party ID');
ALTER TABLE `genomics_biotech_ecm`.`order`.`header` ALTER COLUMN `actual_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Delivery Date');
ALTER TABLE `genomics_biotech_ecm`.`order`.`header` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `genomics_biotech_ecm`.`order`.`header` ALTER COLUMN `confirmed_ship_date` SET TAGS ('dbx_business_glossary_term' = 'Confirmed Ship Date');
ALTER TABLE `genomics_biotech_ecm`.`order`.`header` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`order`.`header` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `genomics_biotech_ecm`.`order`.`header` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `genomics_biotech_ecm`.`order`.`header` ALTER COLUMN `distribution_channel` SET TAGS ('dbx_business_glossary_term' = 'Distribution Channel');
ALTER TABLE `genomics_biotech_ecm`.`order`.`header` ALTER COLUMN `division` SET TAGS ('dbx_business_glossary_term' = 'Division');
ALTER TABLE `genomics_biotech_ecm`.`order`.`header` ALTER COLUMN `erp_sales_document_number` SET TAGS ('dbx_business_glossary_term' = 'Enterprise Resource Planning (ERP) Sales Document Number');
ALTER TABLE `genomics_biotech_ecm`.`order`.`header` ALTER COLUMN `erp_sales_document_number` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `genomics_biotech_ecm`.`order`.`header` ALTER COLUMN `export_control_flag` SET TAGS ('dbx_business_glossary_term' = 'Export Control Flag');
ALTER TABLE `genomics_biotech_ecm`.`order`.`header` ALTER COLUMN `gxp_relevant_flag` SET TAGS ('dbx_business_glossary_term' = 'Good Practice (GxP) Relevant Flag');
ALTER TABLE `genomics_biotech_ecm`.`order`.`header` ALTER COLUMN `incoterms` SET TAGS ('dbx_business_glossary_term' = 'International Commercial Terms (Incoterms)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`header` ALTER COLUMN `incoterms_location` SET TAGS ('dbx_business_glossary_term' = 'Incoterms Location');
ALTER TABLE `genomics_biotech_ecm`.`order`.`header` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`order`.`header` ALTER COLUMN `order_date` SET TAGS ('dbx_business_glossary_term' = 'Order Date');
ALTER TABLE `genomics_biotech_ecm`.`order`.`header` ALTER COLUMN `order_number` SET TAGS ('dbx_business_glossary_term' = 'Order Number');
ALTER TABLE `genomics_biotech_ecm`.`order`.`header` ALTER COLUMN `order_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `genomics_biotech_ecm`.`order`.`header` ALTER COLUMN `order_source_channel` SET TAGS ('dbx_business_glossary_term' = 'Order Source Channel');
ALTER TABLE `genomics_biotech_ecm`.`order`.`header` ALTER COLUMN `order_source_channel` SET TAGS ('dbx_value_regex' = 'direct_sales|distributor|oem_partner|e_commerce|field_application|government_contract');
ALTER TABLE `genomics_biotech_ecm`.`order`.`header` ALTER COLUMN `order_status` SET TAGS ('dbx_business_glossary_term' = 'Order Status');
ALTER TABLE `genomics_biotech_ecm`.`order`.`header` ALTER COLUMN `order_type` SET TAGS ('dbx_business_glossary_term' = 'Order Type');
ALTER TABLE `genomics_biotech_ecm`.`order`.`header` ALTER COLUMN `order_type` SET TAGS ('dbx_value_regex' = 'instrument|reagent|consumable|sequencing_service|software_license|support_contract');
ALTER TABLE `genomics_biotech_ecm`.`order`.`header` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `genomics_biotech_ecm`.`order`.`header` ALTER COLUMN `product_classification` SET TAGS ('dbx_business_glossary_term' = 'Product Classification');
ALTER TABLE `genomics_biotech_ecm`.`order`.`header` ALTER COLUMN `product_classification` SET TAGS ('dbx_value_regex' = 'RUO|IVD|LDT|CE_IVD');
ALTER TABLE `genomics_biotech_ecm`.`order`.`header` ALTER COLUMN `purchase_order_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Number');
ALTER TABLE `genomics_biotech_ecm`.`order`.`header` ALTER COLUMN `requested_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Requested Delivery Date');
ALTER TABLE `genomics_biotech_ecm`.`order`.`header` ALTER COLUMN `sales_office` SET TAGS ('dbx_business_glossary_term' = 'Sales Office');
ALTER TABLE `genomics_biotech_ecm`.`order`.`header` ALTER COLUMN `sales_organization` SET TAGS ('dbx_business_glossary_term' = 'Sales Organization');
ALTER TABLE `genomics_biotech_ecm`.`order`.`header` ALTER COLUMN `shipping_carrier` SET TAGS ('dbx_business_glossary_term' = 'Shipping Carrier');
ALTER TABLE `genomics_biotech_ecm`.`order`.`header` ALTER COLUMN `shipping_method` SET TAGS ('dbx_business_glossary_term' = 'Shipping Method');
ALTER TABLE `genomics_biotech_ecm`.`order`.`header` ALTER COLUMN `shipping_method` SET TAGS ('dbx_value_regex' = 'ground|air|ocean|courier|customer_pickup|specialized_cold_chain');
ALTER TABLE `genomics_biotech_ecm`.`order`.`header` ALTER COLUMN `sla_tier` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Tier');
ALTER TABLE `genomics_biotech_ecm`.`order`.`header` ALTER COLUMN `sla_tier` SET TAGS ('dbx_value_regex' = 'standard|priority|expedited|critical');
ALTER TABLE `genomics_biotech_ecm`.`order`.`header` ALTER COLUMN `special_handling_instructions` SET TAGS ('dbx_business_glossary_term' = 'Special Handling Instructions');
ALTER TABLE `genomics_biotech_ecm`.`order`.`header` ALTER COLUMN `tat_commitment_date` SET TAGS ('dbx_business_glossary_term' = 'Turnaround Time (TAT) Commitment Date');
ALTER TABLE `genomics_biotech_ecm`.`order`.`header` ALTER COLUMN `total_net_value` SET TAGS ('dbx_business_glossary_term' = 'Total Net Value');
ALTER TABLE `genomics_biotech_ecm`.`order`.`header` ALTER COLUMN `total_order_value` SET TAGS ('dbx_business_glossary_term' = 'Total Order Value');
ALTER TABLE `genomics_biotech_ecm`.`order`.`header` ALTER COLUMN `total_tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Tax Amount');
ALTER TABLE `genomics_biotech_ecm`.`order`.`header` ALTER COLUMN `tracking_number` SET TAGS ('dbx_business_glossary_term' = 'Tracking Number');
ALTER TABLE `genomics_biotech_ecm`.`order`.`line` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `genomics_biotech_ecm`.`order`.`line` SET TAGS ('dbx_subdomain' = 'order_capture');
ALTER TABLE `genomics_biotech_ecm`.`order`.`line` ALTER COLUMN `line_id` SET TAGS ('dbx_business_glossary_term' = 'Order Line Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`line` ALTER COLUMN `approval_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`line` ALTER COLUMN `blanket_order_id` SET TAGS ('dbx_business_glossary_term' = 'Blanket Order Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`line` ALTER COLUMN `catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Reagent Catalog Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`line` ALTER COLUMN `complaint_id` SET TAGS ('dbx_business_glossary_term' = 'Complaint Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`line` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`line` ALTER COLUMN `genomic_region_id` SET TAGS ('dbx_business_glossary_term' = 'Genomic Region Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`line` ALTER COLUMN `header_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Order Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`line` ALTER COLUMN `test_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Ivd Test Catalog Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`line` ALTER COLUMN `library_id` SET TAGS ('dbx_business_glossary_term' = 'Library Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`line` ALTER COLUMN `lot_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`line` ALTER COLUMN `material_id` SET TAGS ('dbx_business_glossary_term' = 'Material Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`line` ALTER COLUMN `model_id` SET TAGS ('dbx_business_glossary_term' = 'Instrument Model Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`line` ALTER COLUMN `nonconformance_id` SET TAGS ('dbx_business_glossary_term' = 'Nonconformance Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`line` ALTER COLUMN `production_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Production Batch Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`line` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Rd Project Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`line` ALTER COLUMN `sequencing_protocol_id` SET TAGS ('dbx_business_glossary_term' = 'Sequencing Protocol Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`line` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`line` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`line` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`line` ALTER COLUMN `actual_ship_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Ship Date');
ALTER TABLE `genomics_biotech_ecm`.`order`.`line` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Number');
ALTER TABLE `genomics_biotech_ecm`.`order`.`line` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `genomics_biotech_ecm`.`order`.`line` ALTER COLUMN `confirmed_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Confirmed Delivery Date');
ALTER TABLE `genomics_biotech_ecm`.`order`.`line` ALTER COLUMN `confirmed_quantity` SET TAGS ('dbx_business_glossary_term' = 'Confirmed Quantity');
ALTER TABLE `genomics_biotech_ecm`.`order`.`line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`order`.`line` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `genomics_biotech_ecm`.`order`.`line` ALTER COLUMN `delivered_quantity` SET TAGS ('dbx_business_glossary_term' = 'Delivered Quantity');
ALTER TABLE `genomics_biotech_ecm`.`order`.`line` ALTER COLUMN `delivery_priority` SET TAGS ('dbx_business_glossary_term' = 'Delivery Priority');
ALTER TABLE `genomics_biotech_ecm`.`order`.`line` ALTER COLUMN `delivery_priority` SET TAGS ('dbx_value_regex' = 'standard|expedited|rush|critical|');
ALTER TABLE `genomics_biotech_ecm`.`order`.`line` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Line Item Discount Amount');
ALTER TABLE `genomics_biotech_ecm`.`order`.`line` ALTER COLUMN `discount_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`order`.`line` ALTER COLUMN `discount_percentage` SET TAGS ('dbx_business_glossary_term' = 'Line Item Discount Percentage');
ALTER TABLE `genomics_biotech_ecm`.`order`.`line` ALTER COLUMN `discount_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`order`.`line` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Product Expiration Date');
ALTER TABLE `genomics_biotech_ecm`.`order`.`line` ALTER COLUMN `hazmat_classification` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Material (HAZMAT) Classification');
ALTER TABLE `genomics_biotech_ecm`.`order`.`line` ALTER COLUMN `item_category` SET TAGS ('dbx_business_glossary_term' = 'SAP Item Category');
ALTER TABLE `genomics_biotech_ecm`.`order`.`line` ALTER COLUMN `item_category` SET TAGS ('dbx_value_regex' = 'TAN|ZSEQ|ZKIT|ZINS|ZSVC|ZCON');
ALTER TABLE `genomics_biotech_ecm`.`order`.`line` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`order`.`line` ALTER COLUMN `line_number` SET TAGS ('dbx_business_glossary_term' = 'Line Item Number');
ALTER TABLE `genomics_biotech_ecm`.`order`.`line` ALTER COLUMN `line_status` SET TAGS ('dbx_business_glossary_term' = 'Line Item Status');
ALTER TABLE `genomics_biotech_ecm`.`order`.`line` ALTER COLUMN `list_unit_price` SET TAGS ('dbx_business_glossary_term' = 'List Unit Price');
ALTER TABLE `genomics_biotech_ecm`.`order`.`line` ALTER COLUMN `list_unit_price` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`order`.`line` ALTER COLUMN `net_unit_price` SET TAGS ('dbx_business_glossary_term' = 'Net Unit Price');
ALTER TABLE `genomics_biotech_ecm`.`order`.`line` ALTER COLUMN `net_unit_price` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`order`.`line` ALTER COLUMN `net_value` SET TAGS ('dbx_business_glossary_term' = 'Line Item Net Value');
ALTER TABLE `genomics_biotech_ecm`.`order`.`line` ALTER COLUMN `net_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`order`.`line` ALTER COLUMN `open_quantity` SET TAGS ('dbx_business_glossary_term' = 'Open Quantity');
ALTER TABLE `genomics_biotech_ecm`.`order`.`line` ALTER COLUMN `ordered_quantity` SET TAGS ('dbx_business_glossary_term' = 'Ordered Quantity');
ALTER TABLE `genomics_biotech_ecm`.`order`.`line` ALTER COLUMN `plant_code` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Plant Code');
ALTER TABLE `genomics_biotech_ecm`.`order`.`line` ALTER COLUMN `regulatory_designation` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Use Designation');
ALTER TABLE `genomics_biotech_ecm`.`order`.`line` ALTER COLUMN `regulatory_designation` SET TAGS ('dbx_value_regex' = 'RUO|IVD|CE_IVD|LDT|');
ALTER TABLE `genomics_biotech_ecm`.`order`.`line` ALTER COLUMN `requested_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Requested Delivery Date');
ALTER TABLE `genomics_biotech_ecm`.`order`.`line` ALTER COLUMN `sequencing_service_type` SET TAGS ('dbx_business_glossary_term' = 'Sequencing Service Type');
ALTER TABLE `genomics_biotech_ecm`.`order`.`line` ALTER COLUMN `sequencing_service_type` SET TAGS ('dbx_value_regex' = 'WGS|WES|targeted_panel|RNA_seq|single_cell|metagenomics|');
ALTER TABLE `genomics_biotech_ecm`.`order`.`line` ALTER COLUMN `serial_number` SET TAGS ('dbx_business_glossary_term' = 'Serial Number');
ALTER TABLE `genomics_biotech_ecm`.`order`.`line` ALTER COLUMN `shipping_point` SET TAGS ('dbx_business_glossary_term' = 'Shipping Point');
ALTER TABLE `genomics_biotech_ecm`.`order`.`line` ALTER COLUMN `special_handling_instructions` SET TAGS ('dbx_business_glossary_term' = 'Special Handling Instructions');
ALTER TABLE `genomics_biotech_ecm`.`order`.`line` ALTER COLUMN `storage_location` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Code');
ALTER TABLE `genomics_biotech_ecm`.`order`.`line` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `genomics_biotech_ecm`.`order`.`line` ALTER COLUMN `tax_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Code');
ALTER TABLE `genomics_biotech_ecm`.`order`.`line` ALTER COLUMN `temperature_requirement` SET TAGS ('dbx_business_glossary_term' = 'Temperature Storage Requirement');
ALTER TABLE `genomics_biotech_ecm`.`order`.`line` ALTER COLUMN `temperature_requirement` SET TAGS ('dbx_value_regex' = 'ambient|refrigerated|frozen|ultra_cold|dry_ice|');
ALTER TABLE `genomics_biotech_ecm`.`order`.`line` ALTER COLUMN `total_value` SET TAGS ('dbx_business_glossary_term' = 'Line Item Total Value');
ALTER TABLE `genomics_biotech_ecm`.`order`.`line` ALTER COLUMN `total_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`order`.`line` ALTER COLUMN `turnaround_time_days` SET TAGS ('dbx_business_glossary_term' = 'Turnaround Time (TAT) in Days');
ALTER TABLE `genomics_biotech_ecm`.`order`.`line` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`quotation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `genomics_biotech_ecm`.`order`.`quotation` SET TAGS ('dbx_subdomain' = 'order_capture');
ALTER TABLE `genomics_biotech_ecm`.`order`.`quotation` ALTER COLUMN `quotation_id` SET TAGS ('dbx_business_glossary_term' = 'Quotation Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`quotation` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`quotation` ALTER COLUMN `opportunity_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Relationship Management (CRM) Opportunity Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`quotation` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`quotation` ALTER COLUMN `contact_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Contact Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`quotation` ALTER COLUMN `header_id` SET TAGS ('dbx_business_glossary_term' = 'Converted Order Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`quotation` ALTER COLUMN `model_id` SET TAGS ('dbx_business_glossary_term' = 'Instrument Model Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`quotation` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By User Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`quotation` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`order`.`quotation` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`order`.`quotation` ALTER COLUMN `quotation_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Representative Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`quotation` ALTER COLUMN `quotation_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`order`.`quotation` ALTER COLUMN `quotation_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`order`.`quotation` ALTER COLUMN `quotation_prepared_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Quotation Prepared By User Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`quotation` ALTER COLUMN `quotation_prepared_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`order`.`quotation` ALTER COLUMN `quotation_prepared_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`order`.`quotation` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Rd Project Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`quotation` ALTER COLUMN `approval_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Approval Required Flag');
ALTER TABLE `genomics_biotech_ecm`.`order`.`quotation` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `genomics_biotech_ecm`.`order`.`quotation` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|not_required');
ALTER TABLE `genomics_biotech_ecm`.`order`.`quotation` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`order`.`quotation` ALTER COLUMN `competitor_name` SET TAGS ('dbx_business_glossary_term' = 'Competitor Name');
ALTER TABLE `genomics_biotech_ecm`.`order`.`quotation` ALTER COLUMN `competitor_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`order`.`quotation` ALTER COLUMN `converted_to_order_flag` SET TAGS ('dbx_business_glossary_term' = 'Converted to Order Flag');
ALTER TABLE `genomics_biotech_ecm`.`order`.`quotation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`order`.`quotation` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `genomics_biotech_ecm`.`order`.`quotation` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `genomics_biotech_ecm`.`order`.`quotation` ALTER COLUMN `customer_notes` SET TAGS ('dbx_business_glossary_term' = 'Customer Notes');
ALTER TABLE `genomics_biotech_ecm`.`order`.`quotation` ALTER COLUMN `delivery_location` SET TAGS ('dbx_business_glossary_term' = 'Delivery Location');
ALTER TABLE `genomics_biotech_ecm`.`order`.`quotation` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount');
ALTER TABLE `genomics_biotech_ecm`.`order`.`quotation` ALTER COLUMN `discount_tier` SET TAGS ('dbx_business_glossary_term' = 'Discount Tier');
ALTER TABLE `genomics_biotech_ecm`.`order`.`quotation` ALTER COLUMN `discount_tier` SET TAGS ('dbx_value_regex' = 'standard|volume|strategic|promotional|custom');
ALTER TABLE `genomics_biotech_ecm`.`order`.`quotation` ALTER COLUMN `distribution_channel_code` SET TAGS ('dbx_business_glossary_term' = 'Distribution Channel Code');
ALTER TABLE `genomics_biotech_ecm`.`order`.`quotation` ALTER COLUMN `distribution_channel_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2}$');
ALTER TABLE `genomics_biotech_ecm`.`order`.`quotation` ALTER COLUMN `division_code` SET TAGS ('dbx_business_glossary_term' = 'Division Code');
ALTER TABLE `genomics_biotech_ecm`.`order`.`quotation` ALTER COLUMN `division_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2}$');
ALTER TABLE `genomics_biotech_ecm`.`order`.`quotation` ALTER COLUMN `erp_quotation_document_number` SET TAGS ('dbx_business_glossary_term' = 'Enterprise Resource Planning (ERP) Quotation Document Number');
ALTER TABLE `genomics_biotech_ecm`.`order`.`quotation` ALTER COLUMN `erp_quotation_document_number` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `genomics_biotech_ecm`.`order`.`quotation` ALTER COLUMN `estimated_delivery_lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Estimated Delivery Lead Time (Days)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`quotation` ALTER COLUMN `incoterms_code` SET TAGS ('dbx_business_glossary_term' = 'International Commercial Terms (Incoterms) Code');
ALTER TABLE `genomics_biotech_ecm`.`order`.`quotation` ALTER COLUMN `incoterms_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `genomics_biotech_ecm`.`order`.`quotation` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`order`.`quotation` ALTER COLUMN `net_quoted_value` SET TAGS ('dbx_business_glossary_term' = 'Net Quoted Value');
ALTER TABLE `genomics_biotech_ecm`.`order`.`quotation` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Quotation Notes');
ALTER TABLE `genomics_biotech_ecm`.`order`.`quotation` ALTER COLUMN `payment_terms_code` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms Code');
ALTER TABLE `genomics_biotech_ecm`.`order`.`quotation` ALTER COLUMN `payment_terms_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `genomics_biotech_ecm`.`order`.`quotation` ALTER COLUMN `pricing_conditions_applied` SET TAGS ('dbx_business_glossary_term' = 'Pricing Conditions Applied');
ALTER TABLE `genomics_biotech_ecm`.`order`.`quotation` ALTER COLUMN `product_category` SET TAGS ('dbx_business_glossary_term' = 'Product Category');
ALTER TABLE `genomics_biotech_ecm`.`order`.`quotation` ALTER COLUMN `product_category` SET TAGS ('dbx_value_regex' = 'instrument|reagent|consumable|service|software|bundle');
ALTER TABLE `genomics_biotech_ecm`.`order`.`quotation` ALTER COLUMN `quotation_date` SET TAGS ('dbx_business_glossary_term' = 'Quotation Date');
ALTER TABLE `genomics_biotech_ecm`.`order`.`quotation` ALTER COLUMN `quotation_number` SET TAGS ('dbx_business_glossary_term' = 'Quotation Number');
ALTER TABLE `genomics_biotech_ecm`.`order`.`quotation` ALTER COLUMN `quotation_number` SET TAGS ('dbx_value_regex' = '^QT-[0-9]{8}$');
ALTER TABLE `genomics_biotech_ecm`.`order`.`quotation` ALTER COLUMN `quotation_status` SET TAGS ('dbx_business_glossary_term' = 'Quotation Status');
ALTER TABLE `genomics_biotech_ecm`.`order`.`quotation` ALTER COLUMN `quotation_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|accepted|rejected|expired|withdrawn');
ALTER TABLE `genomics_biotech_ecm`.`order`.`quotation` ALTER COLUMN `quotation_type` SET TAGS ('dbx_business_glossary_term' = 'Quotation Type');
ALTER TABLE `genomics_biotech_ecm`.`order`.`quotation` ALTER COLUMN `quotation_type` SET TAGS ('dbx_value_regex' = 'standard|custom|renewal|upgrade|trial');
ALTER TABLE `genomics_biotech_ecm`.`order`.`quotation` ALTER COLUMN `regulatory_classification` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Classification');
ALTER TABLE `genomics_biotech_ecm`.`order`.`quotation` ALTER COLUMN `regulatory_classification` SET TAGS ('dbx_value_regex' = 'RUO|IVD|LDT|CE-IVD');
ALTER TABLE `genomics_biotech_ecm`.`order`.`quotation` ALTER COLUMN `rejection_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason Code');
ALTER TABLE `genomics_biotech_ecm`.`order`.`quotation` ALTER COLUMN `rejection_reason_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2}$');
ALTER TABLE `genomics_biotech_ecm`.`order`.`quotation` ALTER COLUMN `rejection_reason_description` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason Description');
ALTER TABLE `genomics_biotech_ecm`.`order`.`quotation` ALTER COLUMN `sales_organization_code` SET TAGS ('dbx_business_glossary_term' = 'Sales Organization Code');
ALTER TABLE `genomics_biotech_ecm`.`order`.`quotation` ALTER COLUMN `sales_organization_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `genomics_biotech_ecm`.`order`.`quotation` ALTER COLUMN `special_pricing_justification` SET TAGS ('dbx_business_glossary_term' = 'Special Pricing Justification');
ALTER TABLE `genomics_biotech_ecm`.`order`.`quotation` ALTER COLUMN `special_pricing_justification` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`order`.`quotation` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `genomics_biotech_ecm`.`order`.`quotation` ALTER COLUMN `total_quoted_value` SET TAGS ('dbx_business_glossary_term' = 'Total Quoted Value');
ALTER TABLE `genomics_biotech_ecm`.`order`.`quotation` ALTER COLUMN `valid_from_date` SET TAGS ('dbx_business_glossary_term' = 'Valid From Date');
ALTER TABLE `genomics_biotech_ecm`.`order`.`quotation` ALTER COLUMN `valid_to_date` SET TAGS ('dbx_business_glossary_term' = 'Valid To Date');
ALTER TABLE `genomics_biotech_ecm`.`order`.`quotation_line` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `genomics_biotech_ecm`.`order`.`quotation_line` SET TAGS ('dbx_subdomain' = 'order_capture');
ALTER TABLE `genomics_biotech_ecm`.`order`.`quotation_line` ALTER COLUMN `quotation_line_id` SET TAGS ('dbx_business_glossary_term' = 'Quotation Line Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`quotation_line` ALTER COLUMN `catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Reagent Catalog Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`quotation_line` ALTER COLUMN `genomic_region_id` SET TAGS ('dbx_business_glossary_term' = 'Genomic Region Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`quotation_line` ALTER COLUMN `test_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Ivd Test Catalog Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`quotation_line` ALTER COLUMN `manufacturing_bom_id` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Bom Header Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`quotation_line` ALTER COLUMN `material_id` SET TAGS ('dbx_business_glossary_term' = 'Material Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`quotation_line` ALTER COLUMN `model_id` SET TAGS ('dbx_business_glossary_term' = 'Instrument Model Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`quotation_line` ALTER COLUMN `quotation_id` SET TAGS ('dbx_business_glossary_term' = 'Quotation Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`quotation_line` ALTER COLUMN `sequencing_protocol_id` SET TAGS ('dbx_business_glossary_term' = 'Sequencing Protocol Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`quotation_line` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`quotation_line` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `genomics_biotech_ecm`.`order`.`quotation_line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`order`.`quotation_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `genomics_biotech_ecm`.`order`.`quotation_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `genomics_biotech_ecm`.`order`.`quotation_line` ALTER COLUMN `delivery_lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Delivery Lead Time in Days');
ALTER TABLE `genomics_biotech_ecm`.`order`.`quotation_line` ALTER COLUMN `discount_percentage` SET TAGS ('dbx_business_glossary_term' = 'Discount Percentage');
ALTER TABLE `genomics_biotech_ecm`.`order`.`quotation_line` ALTER COLUMN `distribution_channel` SET TAGS ('dbx_business_glossary_term' = 'Distribution Channel');
ALTER TABLE `genomics_biotech_ecm`.`order`.`quotation_line` ALTER COLUMN `distribution_channel` SET TAGS ('dbx_value_regex' = 'direct|distributor|oem|ecommerce');
ALTER TABLE `genomics_biotech_ecm`.`order`.`quotation_line` ALTER COLUMN `item_category` SET TAGS ('dbx_business_glossary_term' = 'Item Category');
ALTER TABLE `genomics_biotech_ecm`.`order`.`quotation_line` ALTER COLUMN `line_net_value` SET TAGS ('dbx_business_glossary_term' = 'Line Net Value');
ALTER TABLE `genomics_biotech_ecm`.`order`.`quotation_line` ALTER COLUMN `line_number` SET TAGS ('dbx_business_glossary_term' = 'Quotation Line Number');
ALTER TABLE `genomics_biotech_ecm`.`order`.`quotation_line` ALTER COLUMN `line_status` SET TAGS ('dbx_business_glossary_term' = 'Quotation Line Status');
ALTER TABLE `genomics_biotech_ecm`.`order`.`quotation_line` ALTER COLUMN `list_price` SET TAGS ('dbx_business_glossary_term' = 'List Price');
ALTER TABLE `genomics_biotech_ecm`.`order`.`quotation_line` ALTER COLUMN `material_group` SET TAGS ('dbx_business_glossary_term' = 'Material Group');
ALTER TABLE `genomics_biotech_ecm`.`order`.`quotation_line` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `genomics_biotech_ecm`.`order`.`quotation_line` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`order`.`quotation_line` ALTER COLUMN `plant_code` SET TAGS ('dbx_business_glossary_term' = 'Plant Code');
ALTER TABLE `genomics_biotech_ecm`.`order`.`quotation_line` ALTER COLUMN `pricing_condition_type` SET TAGS ('dbx_business_glossary_term' = 'Pricing Condition Type');
ALTER TABLE `genomics_biotech_ecm`.`order`.`quotation_line` ALTER COLUMN `quoted_quantity` SET TAGS ('dbx_business_glossary_term' = 'Quoted Quantity');
ALTER TABLE `genomics_biotech_ecm`.`order`.`quotation_line` ALTER COLUMN `quoted_unit_price` SET TAGS ('dbx_business_glossary_term' = 'Quoted Unit Price');
ALTER TABLE `genomics_biotech_ecm`.`order`.`quotation_line` ALTER COLUMN `regulatory_designation` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Designation');
ALTER TABLE `genomics_biotech_ecm`.`order`.`quotation_line` ALTER COLUMN `regulatory_designation` SET TAGS ('dbx_value_regex' = 'RUO|IVD|LDT|CE_IVD');
ALTER TABLE `genomics_biotech_ecm`.`order`.`quotation_line` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `genomics_biotech_ecm`.`order`.`quotation_line` ALTER COLUMN `sales_organization` SET TAGS ('dbx_business_glossary_term' = 'Sales Organization');
ALTER TABLE `genomics_biotech_ecm`.`order`.`quotation_line` ALTER COLUMN `sequencing_coverage_depth` SET TAGS ('dbx_business_glossary_term' = 'Sequencing Coverage Depth');
ALTER TABLE `genomics_biotech_ecm`.`order`.`quotation_line` ALTER COLUMN `special_instructions` SET TAGS ('dbx_business_glossary_term' = 'Special Instructions');
ALTER TABLE `genomics_biotech_ecm`.`order`.`quotation_line` ALTER COLUMN `tax_classification_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Classification Code');
ALTER TABLE `genomics_biotech_ecm`.`order`.`quotation_line` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`quotation_line` ALTER COLUMN `validity_end_date` SET TAGS ('dbx_business_glossary_term' = 'Quotation Line Validity End Date');
ALTER TABLE `genomics_biotech_ecm`.`order`.`quotation_line` ALTER COLUMN `validity_start_date` SET TAGS ('dbx_business_glossary_term' = 'Quotation Line Validity Start Date');
ALTER TABLE `genomics_biotech_ecm`.`order`.`delivery` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `genomics_biotech_ecm`.`order`.`delivery` SET TAGS ('dbx_subdomain' = 'logistics_compliance');
ALTER TABLE `genomics_biotech_ecm`.`order`.`delivery` ALTER COLUMN `delivery_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`delivery` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Ship-To Customer Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`delivery` ALTER COLUMN `approval_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`delivery` ALTER COLUMN `complaint_id` SET TAGS ('dbx_business_glossary_term' = 'Complaint Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`delivery` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`delivery` ALTER COLUMN `header_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Order Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`delivery` ALTER COLUMN `warehouse_location_id` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`delivery` ALTER COLUMN `actual_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Delivery Date');
ALTER TABLE `genomics_biotech_ecm`.`order`.`delivery` ALTER COLUMN `carrier_code` SET TAGS ('dbx_business_glossary_term' = 'Carrier Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`delivery` ALTER COLUMN `carrier_name` SET TAGS ('dbx_business_glossary_term' = 'Carrier Name');
ALTER TABLE `genomics_biotech_ecm`.`order`.`delivery` ALTER COLUMN `carrier_scac_code` SET TAGS ('dbx_business_glossary_term' = 'Standard Carrier Alpha Code (SCAC)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`delivery` ALTER COLUMN `carrier_scac_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,4}$');
ALTER TABLE `genomics_biotech_ecm`.`order`.`delivery` ALTER COLUMN `cold_chain_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Cold Chain Required Flag');
ALTER TABLE `genomics_biotech_ecm`.`order`.`delivery` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`order`.`delivery` ALTER COLUMN `dangerous_goods_flag` SET TAGS ('dbx_business_glossary_term' = 'Dangerous Goods Flag');
ALTER TABLE `genomics_biotech_ecm`.`order`.`delivery` ALTER COLUMN `delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Delivery Date');
ALTER TABLE `genomics_biotech_ecm`.`order`.`delivery` ALTER COLUMN `delivery_status` SET TAGS ('dbx_business_glossary_term' = 'Delivery Status');
ALTER TABLE `genomics_biotech_ecm`.`order`.`delivery` ALTER COLUMN `delivery_type` SET TAGS ('dbx_business_glossary_term' = 'Delivery Type');
ALTER TABLE `genomics_biotech_ecm`.`order`.`delivery` ALTER COLUMN `delivery_type` SET TAGS ('dbx_value_regex' = 'standard|rush|cold_chain|hazmat|direct_ship|drop_ship');
ALTER TABLE `genomics_biotech_ecm`.`order`.`delivery` ALTER COLUMN `document_number` SET TAGS ('dbx_business_glossary_term' = 'Delivery Document Number');
ALTER TABLE `genomics_biotech_ecm`.`order`.`delivery` ALTER COLUMN `document_number` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `genomics_biotech_ecm`.`order`.`delivery` ALTER COLUMN `estimated_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Estimated Delivery Date');
ALTER TABLE `genomics_biotech_ecm`.`order`.`delivery` ALTER COLUMN `export_declaration_number` SET TAGS ('dbx_business_glossary_term' = 'Export Declaration Number');
ALTER TABLE `genomics_biotech_ecm`.`order`.`delivery` ALTER COLUMN `goods_issue_date` SET TAGS ('dbx_business_glossary_term' = 'Goods Issue Date');
ALTER TABLE `genomics_biotech_ecm`.`order`.`delivery` ALTER COLUMN `goods_issue_status` SET TAGS ('dbx_business_glossary_term' = 'Goods Issue Status');
ALTER TABLE `genomics_biotech_ecm`.`order`.`delivery` ALTER COLUMN `goods_issue_status` SET TAGS ('dbx_value_regex' = 'not_issued|partially_issued|fully_issued|reversed');
ALTER TABLE `genomics_biotech_ecm`.`order`.`delivery` ALTER COLUMN `goods_issue_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Goods Issue Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`order`.`delivery` ALTER COLUMN `incoterms` SET TAGS ('dbx_business_glossary_term' = 'International Commercial Terms (Incoterms)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`delivery` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`order`.`delivery` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Delivery Notes');
ALTER TABLE `genomics_biotech_ecm`.`order`.`delivery` ALTER COLUMN `number_of_packages` SET TAGS ('dbx_business_glossary_term' = 'Number of Packages');
ALTER TABLE `genomics_biotech_ecm`.`order`.`delivery` ALTER COLUMN `packaging_type` SET TAGS ('dbx_business_glossary_term' = 'Packaging Type');
ALTER TABLE `genomics_biotech_ecm`.`order`.`delivery` ALTER COLUMN `packaging_type` SET TAGS ('dbx_value_regex' = 'standard_box|insulated_box|dry_ice_shipper|gel_pack_shipper|cryogenic_shipper|pallet');
ALTER TABLE `genomics_biotech_ecm`.`order`.`delivery` ALTER COLUMN `proof_of_delivery_url` SET TAGS ('dbx_business_glossary_term' = 'Proof of Delivery (POD) URL');
ALTER TABLE `genomics_biotech_ecm`.`order`.`delivery` ALTER COLUMN `sds_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Safety Data Sheet (SDS) Reference Number');
ALTER TABLE `genomics_biotech_ecm`.`order`.`delivery` ALTER COLUMN `ship_to_address_line1` SET TAGS ('dbx_business_glossary_term' = 'Ship-To Address Line 1');
ALTER TABLE `genomics_biotech_ecm`.`order`.`delivery` ALTER COLUMN `ship_to_address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`order`.`delivery` ALTER COLUMN `ship_to_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`order`.`delivery` ALTER COLUMN `ship_to_address_line2` SET TAGS ('dbx_business_glossary_term' = 'Ship-To Address Line 2');
ALTER TABLE `genomics_biotech_ecm`.`order`.`delivery` ALTER COLUMN `ship_to_address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`order`.`delivery` ALTER COLUMN `ship_to_address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`order`.`delivery` ALTER COLUMN `ship_to_city` SET TAGS ('dbx_business_glossary_term' = 'Ship-To City');
ALTER TABLE `genomics_biotech_ecm`.`order`.`delivery` ALTER COLUMN `ship_to_city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`order`.`delivery` ALTER COLUMN `ship_to_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`order`.`delivery` ALTER COLUMN `ship_to_country_code` SET TAGS ('dbx_business_glossary_term' = 'Ship-To Country Code');
ALTER TABLE `genomics_biotech_ecm`.`order`.`delivery` ALTER COLUMN `ship_to_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `genomics_biotech_ecm`.`order`.`delivery` ALTER COLUMN `ship_to_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Ship-To Postal Code');
ALTER TABLE `genomics_biotech_ecm`.`order`.`delivery` ALTER COLUMN `ship_to_postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`order`.`delivery` ALTER COLUMN `ship_to_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`order`.`delivery` ALTER COLUMN `ship_to_state_province` SET TAGS ('dbx_business_glossary_term' = 'Ship-To State or Province');
ALTER TABLE `genomics_biotech_ecm`.`order`.`delivery` ALTER COLUMN `ship_to_state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`order`.`delivery` ALTER COLUMN `ship_to_state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`order`.`delivery` ALTER COLUMN `shipment_method` SET TAGS ('dbx_business_glossary_term' = 'Shipment Method');
ALTER TABLE `genomics_biotech_ecm`.`order`.`delivery` ALTER COLUMN `shipment_method` SET TAGS ('dbx_value_regex' = 'ground|air|ocean|cold_chain_ground|cold_chain_air|courier');
ALTER TABLE `genomics_biotech_ecm`.`order`.`delivery` ALTER COLUMN `shipping_point` SET TAGS ('dbx_business_glossary_term' = 'Shipping Point');
ALTER TABLE `genomics_biotech_ecm`.`order`.`delivery` ALTER COLUMN `shipping_point` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `genomics_biotech_ecm`.`order`.`delivery` ALTER COLUMN `temperature_range_max_c` SET TAGS ('dbx_business_glossary_term' = 'Maximum Temperature Requirement (Celsius)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`delivery` ALTER COLUMN `temperature_range_min_c` SET TAGS ('dbx_business_glossary_term' = 'Minimum Temperature Requirement (Celsius)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`delivery` ALTER COLUMN `total_gross_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Total Gross Weight (Kilograms)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`delivery` ALTER COLUMN `total_net_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Total Net Weight (Kilograms)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`delivery` ALTER COLUMN `tracking_number` SET TAGS ('dbx_business_glossary_term' = 'Shipment Tracking Number');
ALTER TABLE `genomics_biotech_ecm`.`order`.`delivery` ALTER COLUMN `un_number` SET TAGS ('dbx_business_glossary_term' = 'United Nations (UN) Number');
ALTER TABLE `genomics_biotech_ecm`.`order`.`delivery` ALTER COLUMN `un_number` SET TAGS ('dbx_value_regex' = '^UN[0-9]{4}$');
ALTER TABLE `genomics_biotech_ecm`.`order`.`delivery_line` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `genomics_biotech_ecm`.`order`.`delivery_line` SET TAGS ('dbx_subdomain' = 'logistics_compliance');
ALTER TABLE `genomics_biotech_ecm`.`order`.`delivery_line` ALTER COLUMN `delivery_line_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Line Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`delivery_line` ALTER COLUMN `batch_id` SET TAGS ('dbx_business_glossary_term' = 'Batch Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`delivery_line` ALTER COLUMN `catalog_item_id` SET TAGS ('dbx_business_glossary_term' = 'Product Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`delivery_line` ALTER COLUMN `coa_id` SET TAGS ('dbx_business_glossary_term' = 'Coa Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`delivery_line` ALTER COLUMN `delivery_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Document Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`delivery_line` ALTER COLUMN `header_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Order Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`delivery_line` ALTER COLUMN `lot_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`delivery_line` ALTER COLUMN `material_id` SET TAGS ('dbx_business_glossary_term' = 'Material Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`delivery_line` ALTER COLUMN `production_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Production Batch Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`delivery_line` ALTER COLUMN `line_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Order Line Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`delivery_line` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`delivery_line` ALTER COLUMN `cold_chain_handling_instruction` SET TAGS ('dbx_business_glossary_term' = 'Cold Chain Handling Instruction');
ALTER TABLE `genomics_biotech_ecm`.`order`.`delivery_line` ALTER COLUMN `cold_chain_handling_instruction` SET TAGS ('dbx_value_regex' = 'ambient|refrigerated_2_8c|frozen_minus_20c|frozen_minus_80c|dry_ice|liquid_nitrogen');
ALTER TABLE `genomics_biotech_ecm`.`order`.`delivery_line` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_business_glossary_term' = 'Country of Origin');
ALTER TABLE `genomics_biotech_ecm`.`order`.`delivery_line` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `genomics_biotech_ecm`.`order`.`delivery_line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`order`.`delivery_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `genomics_biotech_ecm`.`order`.`delivery_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `genomics_biotech_ecm`.`order`.`delivery_line` ALTER COLUMN `delivery_line_status` SET TAGS ('dbx_business_glossary_term' = 'Delivery Line Status');
ALTER TABLE `genomics_biotech_ecm`.`order`.`delivery_line` ALTER COLUMN `delivery_quantity` SET TAGS ('dbx_business_glossary_term' = 'Delivery Quantity');
ALTER TABLE `genomics_biotech_ecm`.`order`.`delivery_line` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `genomics_biotech_ecm`.`order`.`delivery_line` ALTER COLUMN `goods_issue_date` SET TAGS ('dbx_business_glossary_term' = 'Goods Issue Date');
ALTER TABLE `genomics_biotech_ecm`.`order`.`delivery_line` ALTER COLUMN `goods_issue_quantity` SET TAGS ('dbx_business_glossary_term' = 'Goods Issue Quantity');
ALTER TABLE `genomics_biotech_ecm`.`order`.`delivery_line` ALTER COLUMN `gross_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Gross Weight in Kilograms (KG)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`delivery_line` ALTER COLUMN `harmonized_tariff_code` SET TAGS ('dbx_business_glossary_term' = 'Harmonized Tariff Code (HS Code)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`delivery_line` ALTER COLUMN `harmonized_tariff_code` SET TAGS ('dbx_value_regex' = '^[0-9]{6,10}$');
ALTER TABLE `genomics_biotech_ecm`.`order`.`delivery_line` ALTER COLUMN `hazmat_classification` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Material (HAZMAT) Classification');
ALTER TABLE `genomics_biotech_ecm`.`order`.`delivery_line` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`order`.`delivery_line` ALTER COLUMN `line_number` SET TAGS ('dbx_business_glossary_term' = 'Delivery Line Number');
ALTER TABLE `genomics_biotech_ecm`.`order`.`delivery_line` ALTER COLUMN `line_value_amount` SET TAGS ('dbx_business_glossary_term' = 'Line Value Amount');
ALTER TABLE `genomics_biotech_ecm`.`order`.`delivery_line` ALTER COLUMN `line_value_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`order`.`delivery_line` ALTER COLUMN `manufacturing_date` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Date');
ALTER TABLE `genomics_biotech_ecm`.`order`.`delivery_line` ALTER COLUMN `net_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Net Weight in Kilograms (KG)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`delivery_line` ALTER COLUMN `pack_status` SET TAGS ('dbx_business_glossary_term' = 'Pack Status');
ALTER TABLE `genomics_biotech_ecm`.`order`.`delivery_line` ALTER COLUMN `pack_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|packed|quality_hold|cancelled');
ALTER TABLE `genomics_biotech_ecm`.`order`.`delivery_line` ALTER COLUMN `pick_status` SET TAGS ('dbx_business_glossary_term' = 'Pick Status');
ALTER TABLE `genomics_biotech_ecm`.`order`.`delivery_line` ALTER COLUMN `pick_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|picked|short_picked|cancelled');
ALTER TABLE `genomics_biotech_ecm`.`order`.`delivery_line` ALTER COLUMN `product_regulatory_status` SET TAGS ('dbx_business_glossary_term' = 'Product Regulatory Status');
ALTER TABLE `genomics_biotech_ecm`.`order`.`delivery_line` ALTER COLUMN `product_regulatory_status` SET TAGS ('dbx_value_regex' = 'RUO|IVD|CE_IVD|FDA_cleared|FDA_approved|LDT');
ALTER TABLE `genomics_biotech_ecm`.`order`.`delivery_line` ALTER COLUMN `rejection_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason Code');
ALTER TABLE `genomics_biotech_ecm`.`order`.`delivery_line` ALTER COLUMN `rejection_reason_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `genomics_biotech_ecm`.`order`.`delivery_line` ALTER COLUMN `serial_number` SET TAGS ('dbx_business_glossary_term' = 'Serial Number');
ALTER TABLE `genomics_biotech_ecm`.`order`.`delivery_line` ALTER COLUMN `serial_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{8,40}$');
ALTER TABLE `genomics_biotech_ecm`.`order`.`delivery_line` ALTER COLUMN `special_handling_instructions` SET TAGS ('dbx_business_glossary_term' = 'Special Handling Instructions');
ALTER TABLE `genomics_biotech_ecm`.`order`.`delivery_line` ALTER COLUMN `storage_location_code` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Code');
ALTER TABLE `genomics_biotech_ecm`.`order`.`delivery_line` ALTER COLUMN `storage_location_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `genomics_biotech_ecm`.`order`.`delivery_line` ALTER COLUMN `un_number` SET TAGS ('dbx_business_glossary_term' = 'United Nations (UN) Number');
ALTER TABLE `genomics_biotech_ecm`.`order`.`delivery_line` ALTER COLUMN `un_number` SET TAGS ('dbx_value_regex' = '^UN[0-9]{4}$');
ALTER TABLE `genomics_biotech_ecm`.`order`.`delivery_line` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`delivery_line` ALTER COLUMN `volume_cubic_meters` SET TAGS ('dbx_business_glossary_term' = 'Volume in Cubic Meters');
ALTER TABLE `genomics_biotech_ecm`.`order`.`shipment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `genomics_biotech_ecm`.`order`.`shipment` SET TAGS ('dbx_subdomain' = 'logistics_compliance');
ALTER TABLE `genomics_biotech_ecm`.`order`.`shipment` ALTER COLUMN `shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`shipment` ALTER COLUMN `delivery_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`shipment` ALTER COLUMN `deviation_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Deviation Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`shipment` ALTER COLUMN `header_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Order Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`shipment` ALTER COLUMN `actual_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Delivery Date');
ALTER TABLE `genomics_biotech_ecm`.`order`.`shipment` ALTER COLUMN `carrier_name` SET TAGS ('dbx_business_glossary_term' = 'Carrier Name');
ALTER TABLE `genomics_biotech_ecm`.`order`.`shipment` ALTER COLUMN `carrier_sla_breach_flag` SET TAGS ('dbx_business_glossary_term' = 'Carrier Service Level Agreement (SLA) Breach Flag');
ALTER TABLE `genomics_biotech_ecm`.`order`.`shipment` ALTER COLUMN `carrier_tracking_number` SET TAGS ('dbx_business_glossary_term' = 'Carrier Tracking Number');
ALTER TABLE `genomics_biotech_ecm`.`order`.`shipment` ALTER COLUMN `cold_chain_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Cold Chain Required Flag');
ALTER TABLE `genomics_biotech_ecm`.`order`.`shipment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`order`.`shipment` ALTER COLUMN `customer_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Customer Reference Number');
ALTER TABLE `genomics_biotech_ecm`.`order`.`shipment` ALTER COLUMN `destination_address_line1` SET TAGS ('dbx_business_glossary_term' = 'Destination Address Line 1');
ALTER TABLE `genomics_biotech_ecm`.`order`.`shipment` ALTER COLUMN `destination_address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`order`.`shipment` ALTER COLUMN `destination_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`order`.`shipment` ALTER COLUMN `destination_address_line2` SET TAGS ('dbx_business_glossary_term' = 'Destination Address Line 2');
ALTER TABLE `genomics_biotech_ecm`.`order`.`shipment` ALTER COLUMN `destination_address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`order`.`shipment` ALTER COLUMN `destination_address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`order`.`shipment` ALTER COLUMN `destination_city` SET TAGS ('dbx_business_glossary_term' = 'Destination City');
ALTER TABLE `genomics_biotech_ecm`.`order`.`shipment` ALTER COLUMN `destination_city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`order`.`shipment` ALTER COLUMN `destination_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`order`.`shipment` ALTER COLUMN `destination_country_code` SET TAGS ('dbx_business_glossary_term' = 'Destination Country Code');
ALTER TABLE `genomics_biotech_ecm`.`order`.`shipment` ALTER COLUMN `destination_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `genomics_biotech_ecm`.`order`.`shipment` ALTER COLUMN `destination_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Destination Postal Code');
ALTER TABLE `genomics_biotech_ecm`.`order`.`shipment` ALTER COLUMN `destination_postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`order`.`shipment` ALTER COLUMN `destination_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`order`.`shipment` ALTER COLUMN `destination_state_province` SET TAGS ('dbx_business_glossary_term' = 'Destination State or Province');
ALTER TABLE `genomics_biotech_ecm`.`order`.`shipment` ALTER COLUMN `destination_state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`order`.`shipment` ALTER COLUMN `destination_state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`order`.`shipment` ALTER COLUMN `estimated_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Estimated Delivery Date');
ALTER TABLE `genomics_biotech_ecm`.`order`.`shipment` ALTER COLUMN `export_declaration_number` SET TAGS ('dbx_business_glossary_term' = 'Export Declaration Number');
ALTER TABLE `genomics_biotech_ecm`.`order`.`shipment` ALTER COLUMN `freight_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Freight Cost Amount');
ALTER TABLE `genomics_biotech_ecm`.`order`.`shipment` ALTER COLUMN `freight_cost_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`order`.`shipment` ALTER COLUMN `freight_cost_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Freight Cost Currency Code');
ALTER TABLE `genomics_biotech_ecm`.`order`.`shipment` ALTER COLUMN `freight_cost_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `genomics_biotech_ecm`.`order`.`shipment` ALTER COLUMN `hazmat_class` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Materials (HAZMAT) Class');
ALTER TABLE `genomics_biotech_ecm`.`order`.`shipment` ALTER COLUMN `hazmat_flag` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Materials (HAZMAT) Flag');
ALTER TABLE `genomics_biotech_ecm`.`order`.`shipment` ALTER COLUMN `incoterm_code` SET TAGS ('dbx_business_glossary_term' = 'International Commercial Terms (Incoterms) Code');
ALTER TABLE `genomics_biotech_ecm`.`order`.`shipment` ALTER COLUMN `insurance_value_amount` SET TAGS ('dbx_business_glossary_term' = 'Insurance Value Amount');
ALTER TABLE `genomics_biotech_ecm`.`order`.`shipment` ALTER COLUMN `insurance_value_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`order`.`shipment` ALTER COLUMN `insurance_value_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Insurance Value Currency Code');
ALTER TABLE `genomics_biotech_ecm`.`order`.`shipment` ALTER COLUMN `insurance_value_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `genomics_biotech_ecm`.`order`.`shipment` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`order`.`shipment` ALTER COLUMN `origin_facility_code` SET TAGS ('dbx_business_glossary_term' = 'Origin Facility Code');
ALTER TABLE `genomics_biotech_ecm`.`order`.`shipment` ALTER COLUMN `origin_facility_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}-[A-Z0-9]{4}$');
ALTER TABLE `genomics_biotech_ecm`.`order`.`shipment` ALTER COLUMN `package_count` SET TAGS ('dbx_business_glossary_term' = 'Package Count');
ALTER TABLE `genomics_biotech_ecm`.`order`.`shipment` ALTER COLUMN `proof_of_delivery_reference` SET TAGS ('dbx_business_glossary_term' = 'Proof of Delivery (POD) Reference');
ALTER TABLE `genomics_biotech_ecm`.`order`.`shipment` ALTER COLUMN `ship_date` SET TAGS ('dbx_business_glossary_term' = 'Ship Date');
ALTER TABLE `genomics_biotech_ecm`.`order`.`shipment` ALTER COLUMN `shipment_method` SET TAGS ('dbx_business_glossary_term' = 'Shipment Method');
ALTER TABLE `genomics_biotech_ecm`.`order`.`shipment` ALTER COLUMN `shipment_method` SET TAGS ('dbx_value_regex' = 'ground|air|express|overnight|international|cold_chain');
ALTER TABLE `genomics_biotech_ecm`.`order`.`shipment` ALTER COLUMN `shipment_number` SET TAGS ('dbx_business_glossary_term' = 'Shipment Number');
ALTER TABLE `genomics_biotech_ecm`.`order`.`shipment` ALTER COLUMN `shipment_number` SET TAGS ('dbx_value_regex' = '^SHP-[0-9]{10}$');
ALTER TABLE `genomics_biotech_ecm`.`order`.`shipment` ALTER COLUMN `shipment_status` SET TAGS ('dbx_business_glossary_term' = 'Shipment Status');
ALTER TABLE `genomics_biotech_ecm`.`order`.`shipment` ALTER COLUMN `shipment_status` SET TAGS ('dbx_value_regex' = 'booked|in_transit|out_for_delivery|delivered|exception|cancelled');
ALTER TABLE `genomics_biotech_ecm`.`order`.`shipment` ALTER COLUMN `special_handling_instructions` SET TAGS ('dbx_business_glossary_term' = 'Special Handling Instructions');
ALTER TABLE `genomics_biotech_ecm`.`order`.`shipment` ALTER COLUMN `tat_compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Turnaround Time (TAT) Compliance Status');
ALTER TABLE `genomics_biotech_ecm`.`order`.`shipment` ALTER COLUMN `tat_compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|at_risk|breached|not_applicable');
ALTER TABLE `genomics_biotech_ecm`.`order`.`shipment` ALTER COLUMN `temperature_excursion_flag` SET TAGS ('dbx_business_glossary_term' = 'Temperature Excursion Flag');
ALTER TABLE `genomics_biotech_ecm`.`order`.`shipment` ALTER COLUMN `temperature_log_reference` SET TAGS ('dbx_business_glossary_term' = 'Temperature Log Reference');
ALTER TABLE `genomics_biotech_ecm`.`order`.`shipment` ALTER COLUMN `temperature_range_max_celsius` SET TAGS ('dbx_business_glossary_term' = 'Temperature Range Maximum (Celsius)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`shipment` ALTER COLUMN `temperature_range_min_celsius` SET TAGS ('dbx_business_glossary_term' = 'Temperature Range Minimum (Celsius)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`shipment` ALTER COLUMN `total_volume_cubic_meters` SET TAGS ('dbx_business_glossary_term' = 'Total Volume (Cubic Meters)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`shipment` ALTER COLUMN `total_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Total Weight (Kilograms)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`shipment` ALTER COLUMN `un_number` SET TAGS ('dbx_business_glossary_term' = 'United Nations (UN) Number');
ALTER TABLE `genomics_biotech_ecm`.`order`.`shipment` ALTER COLUMN `un_number` SET TAGS ('dbx_value_regex' = '^UN[0-9]{4}$');
ALTER TABLE `genomics_biotech_ecm`.`order`.`return_authorization` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `genomics_biotech_ecm`.`order`.`return_authorization` SET TAGS ('dbx_subdomain' = 'return_processing');
ALTER TABLE `genomics_biotech_ecm`.`order`.`return_authorization` ALTER COLUMN `return_authorization_id` SET TAGS ('dbx_business_glossary_term' = 'Return Authorization Identifier');
ALTER TABLE `genomics_biotech_ecm`.`order`.`return_authorization` ALTER COLUMN `approval_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`return_authorization` ALTER COLUMN `batch_id` SET TAGS ('dbx_business_glossary_term' = 'Batch Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`return_authorization` ALTER COLUMN `complaint_id` SET TAGS ('dbx_business_glossary_term' = 'Complaint Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`return_authorization` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`return_authorization` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account ID');
ALTER TABLE `genomics_biotech_ecm`.`order`.`return_authorization` ALTER COLUMN `deviation_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Deviation Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`return_authorization` ALTER COLUMN `lot_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`return_authorization` ALTER COLUMN `material_id` SET TAGS ('dbx_business_glossary_term' = 'Material Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`return_authorization` ALTER COLUMN `nonconformance_id` SET TAGS ('dbx_business_glossary_term' = 'Nonconformance Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`return_authorization` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Control (QC) Inspector ID');
ALTER TABLE `genomics_biotech_ecm`.`order`.`return_authorization` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`order`.`return_authorization` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`order`.`return_authorization` ALTER COLUMN `header_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Order ID');
ALTER TABLE `genomics_biotech_ecm`.`order`.`return_authorization` ALTER COLUMN `production_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Production Batch Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`return_authorization` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`return_authorization` ALTER COLUMN `test_order_id` SET TAGS ('dbx_business_glossary_term' = 'Test Order Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`return_authorization` ALTER COLUMN `warehouse_location_id` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Location ID');
ALTER TABLE `genomics_biotech_ecm`.`order`.`return_authorization` ALTER COLUMN `capa_number` SET TAGS ('dbx_business_glossary_term' = 'Corrective and Preventive Action (CAPA) Number');
ALTER TABLE `genomics_biotech_ecm`.`order`.`return_authorization` ALTER COLUMN `capa_number` SET TAGS ('dbx_value_regex' = '^CAPA-[A-Z0-9]{8,12}$');
ALTER TABLE `genomics_biotech_ecm`.`order`.`return_authorization` ALTER COLUMN `capa_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Corrective and Preventive Action (CAPA) Required Flag');
ALTER TABLE `genomics_biotech_ecm`.`order`.`return_authorization` ALTER COLUMN `carrier_name` SET TAGS ('dbx_business_glossary_term' = 'Carrier Name');
ALTER TABLE `genomics_biotech_ecm`.`order`.`return_authorization` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`order`.`return_authorization` ALTER COLUMN `credit_memo_number` SET TAGS ('dbx_business_glossary_term' = 'Credit Memo Number');
ALTER TABLE `genomics_biotech_ecm`.`order`.`return_authorization` ALTER COLUMN `credit_memo_number` SET TAGS ('dbx_value_regex' = '^CM-[A-Z0-9]{8,12}$');
ALTER TABLE `genomics_biotech_ecm`.`order`.`return_authorization` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `genomics_biotech_ecm`.`order`.`return_authorization` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `genomics_biotech_ecm`.`order`.`return_authorization` ALTER COLUMN `disposition_code` SET TAGS ('dbx_business_glossary_term' = 'Disposition Code');
ALTER TABLE `genomics_biotech_ecm`.`order`.`return_authorization` ALTER COLUMN `disposition_code` SET TAGS ('dbx_value_regex' = 'restock|quarantine|destroy|rework|scrap|return-to-vendor');
ALTER TABLE `genomics_biotech_ecm`.`order`.`return_authorization` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `genomics_biotech_ecm`.`order`.`return_authorization` ALTER COLUMN `gmp_deviation_flag` SET TAGS ('dbx_business_glossary_term' = 'Good Manufacturing Practice (GMP) Deviation Flag');
ALTER TABLE `genomics_biotech_ecm`.`order`.`return_authorization` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`order`.`return_authorization` ALTER COLUMN `qc_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Quality Control (QC) Inspection Date');
ALTER TABLE `genomics_biotech_ecm`.`order`.`return_authorization` ALTER COLUMN `qc_inspection_notes` SET TAGS ('dbx_business_glossary_term' = 'Quality Control (QC) Inspection Notes');
ALTER TABLE `genomics_biotech_ecm`.`order`.`return_authorization` ALTER COLUMN `qc_inspection_result` SET TAGS ('dbx_business_glossary_term' = 'Quality Control (QC) Inspection Result');
ALTER TABLE `genomics_biotech_ecm`.`order`.`return_authorization` ALTER COLUMN `qc_inspection_result` SET TAGS ('dbx_value_regex' = 'pass|fail|pending|not-applicable');
ALTER TABLE `genomics_biotech_ecm`.`order`.`return_authorization` ALTER COLUMN `restocking_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Restocking Fee Amount');
ALTER TABLE `genomics_biotech_ecm`.`order`.`return_authorization` ALTER COLUMN `return_authorized_date` SET TAGS ('dbx_business_glossary_term' = 'Return Authorized Date');
ALTER TABLE `genomics_biotech_ecm`.`order`.`return_authorization` ALTER COLUMN `return_credited_date` SET TAGS ('dbx_business_glossary_term' = 'Return Credited Date');
ALTER TABLE `genomics_biotech_ecm`.`order`.`return_authorization` ALTER COLUMN `return_quantity` SET TAGS ('dbx_business_glossary_term' = 'Return Quantity');
ALTER TABLE `genomics_biotech_ecm`.`order`.`return_authorization` ALTER COLUMN `return_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Return Reason Code');
ALTER TABLE `genomics_biotech_ecm`.`order`.`return_authorization` ALTER COLUMN `return_reason_code` SET TAGS ('dbx_value_regex' = 'defective|wrong-item|expired|over-shipment|customer-cancellation|damaged-in-transit');
ALTER TABLE `genomics_biotech_ecm`.`order`.`return_authorization` ALTER COLUMN `return_reason_description` SET TAGS ('dbx_business_glossary_term' = 'Return Reason Description');
ALTER TABLE `genomics_biotech_ecm`.`order`.`return_authorization` ALTER COLUMN `return_received_date` SET TAGS ('dbx_business_glossary_term' = 'Return Received Date');
ALTER TABLE `genomics_biotech_ecm`.`order`.`return_authorization` ALTER COLUMN `return_requested_date` SET TAGS ('dbx_business_glossary_term' = 'Return Requested Date');
ALTER TABLE `genomics_biotech_ecm`.`order`.`return_authorization` ALTER COLUMN `return_shipping_cost` SET TAGS ('dbx_business_glossary_term' = 'Return Shipping Cost');
ALTER TABLE `genomics_biotech_ecm`.`order`.`return_authorization` ALTER COLUMN `return_status` SET TAGS ('dbx_business_glossary_term' = 'Return Status');
ALTER TABLE `genomics_biotech_ecm`.`order`.`return_authorization` ALTER COLUMN `return_value_amount` SET TAGS ('dbx_business_glossary_term' = 'Return Value Amount');
ALTER TABLE `genomics_biotech_ecm`.`order`.`return_authorization` ALTER COLUMN `rma_number` SET TAGS ('dbx_business_glossary_term' = 'Return Merchandise Authorization (RMA) Number');
ALTER TABLE `genomics_biotech_ecm`.`order`.`return_authorization` ALTER COLUMN `rma_number` SET TAGS ('dbx_value_regex' = '^RMA-[A-Z0-9]{8,12}$');
ALTER TABLE `genomics_biotech_ecm`.`order`.`return_authorization` ALTER COLUMN `root_cause_category` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Category');
ALTER TABLE `genomics_biotech_ecm`.`order`.`return_authorization` ALTER COLUMN `root_cause_category` SET TAGS ('dbx_value_regex' = 'manufacturing-defect|shipping-damage|storage-issue|customer-error|system-error|supplier-defect');
ALTER TABLE `genomics_biotech_ecm`.`order`.`return_authorization` ALTER COLUMN `serial_number` SET TAGS ('dbx_business_glossary_term' = 'Serial Number');
ALTER TABLE `genomics_biotech_ecm`.`order`.`return_authorization` ALTER COLUMN `temperature_excursion_flag` SET TAGS ('dbx_business_glossary_term' = 'Temperature Excursion Flag');
ALTER TABLE `genomics_biotech_ecm`.`order`.`return_authorization` ALTER COLUMN `tracking_number` SET TAGS ('dbx_business_glossary_term' = 'Tracking Number');
ALTER TABLE `genomics_biotech_ecm`.`order`.`return_authorization` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `genomics_biotech_ecm`.`order`.`status_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `genomics_biotech_ecm`.`order`.`status_event` SET TAGS ('dbx_subdomain' = 'logistics_compliance');
ALTER TABLE `genomics_biotech_ecm`.`order`.`status_event` ALTER COLUMN `status_event_id` SET TAGS ('dbx_business_glossary_term' = 'Order Status Event ID');
ALTER TABLE `genomics_biotech_ecm`.`order`.`status_event` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `genomics_biotech_ecm`.`order`.`status_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Triggered By User ID');
ALTER TABLE `genomics_biotech_ecm`.`order`.`status_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`order`.`status_event` ALTER COLUMN `header_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Order ID');
ALTER TABLE `genomics_biotech_ecm`.`order`.`status_event` ALTER COLUMN `warehouse_location_id` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Location ID');
ALTER TABLE `genomics_biotech_ecm`.`order`.`status_event` ALTER COLUMN `actual_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Delivery Date');
ALTER TABLE `genomics_biotech_ecm`.`order`.`status_event` ALTER COLUMN `carrier_code` SET TAGS ('dbx_business_glossary_term' = 'Carrier Code');
ALTER TABLE `genomics_biotech_ecm`.`order`.`status_event` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `genomics_biotech_ecm`.`order`.`status_event` ALTER COLUMN `data_source` SET TAGS ('dbx_business_glossary_term' = 'Data Source');
ALTER TABLE `genomics_biotech_ecm`.`order`.`status_event` ALTER COLUMN `distribution_channel` SET TAGS ('dbx_business_glossary_term' = 'Distribution Channel');
ALTER TABLE `genomics_biotech_ecm`.`order`.`status_event` ALTER COLUMN `event_sequence_number` SET TAGS ('dbx_business_glossary_term' = 'Event Sequence Number');
ALTER TABLE `genomics_biotech_ecm`.`order`.`status_event` ALTER COLUMN `event_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Event Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`order`.`status_event` ALTER COLUMN `expected_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Expected Delivery Date');
ALTER TABLE `genomics_biotech_ecm`.`order`.`status_event` ALTER COLUMN `ingestion_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Ingestion Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`order`.`status_event` ALTER COLUMN `is_reversal_flag` SET TAGS ('dbx_business_glossary_term' = 'Is Reversal Flag');
ALTER TABLE `genomics_biotech_ecm`.`order`.`status_event` ALTER COLUMN `new_status` SET TAGS ('dbx_business_glossary_term' = 'New Order Status');
ALTER TABLE `genomics_biotech_ecm`.`order`.`status_event` ALTER COLUMN `notification_channel` SET TAGS ('dbx_business_glossary_term' = 'Notification Channel');
ALTER TABLE `genomics_biotech_ecm`.`order`.`status_event` ALTER COLUMN `notification_channel` SET TAGS ('dbx_value_regex' = 'email|sms|portal|none');
ALTER TABLE `genomics_biotech_ecm`.`order`.`status_event` ALTER COLUMN `notification_sent_flag` SET TAGS ('dbx_business_glossary_term' = 'Notification Sent Flag');
ALTER TABLE `genomics_biotech_ecm`.`order`.`status_event` ALTER COLUMN `order_priority` SET TAGS ('dbx_business_glossary_term' = 'Order Priority');
ALTER TABLE `genomics_biotech_ecm`.`order`.`status_event` ALTER COLUMN `order_priority` SET TAGS ('dbx_value_regex' = 'standard|expedited|urgent|rush|critical');
ALTER TABLE `genomics_biotech_ecm`.`order`.`status_event` ALTER COLUMN `order_type` SET TAGS ('dbx_business_glossary_term' = 'Order Type');
ALTER TABLE `genomics_biotech_ecm`.`order`.`status_event` ALTER COLUMN `previous_status` SET TAGS ('dbx_business_glossary_term' = 'Previous Order Status');
ALTER TABLE `genomics_biotech_ecm`.`order`.`status_event` ALTER COLUMN `reversal_reason` SET TAGS ('dbx_business_glossary_term' = 'Reversal Reason');
ALTER TABLE `genomics_biotech_ecm`.`order`.`status_event` ALTER COLUMN `sales_organization` SET TAGS ('dbx_business_glossary_term' = 'Sales Organization');
ALTER TABLE `genomics_biotech_ecm`.`order`.`status_event` ALTER COLUMN `shipment_tracking_number` SET TAGS ('dbx_business_glossary_term' = 'Shipment Tracking Number');
ALTER TABLE `genomics_biotech_ecm`.`order`.`status_event` ALTER COLUMN `sla_breach_flag` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Breach Flag');
ALTER TABLE `genomics_biotech_ecm`.`order`.`status_event` ALTER COLUMN `sla_breach_severity` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Breach Severity');
ALTER TABLE `genomics_biotech_ecm`.`order`.`status_event` ALTER COLUMN `sla_breach_severity` SET TAGS ('dbx_value_regex' = 'none|minor|moderate|major|critical');
ALTER TABLE `genomics_biotech_ecm`.`order`.`status_event` ALTER COLUMN `sla_milestone_flag` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Milestone Flag');
ALTER TABLE `genomics_biotech_ecm`.`order`.`status_event` ALTER COLUMN `sla_milestone_name` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Milestone Name');
ALTER TABLE `genomics_biotech_ecm`.`order`.`status_event` ALTER COLUMN `source_system_transaction_reference` SET TAGS ('dbx_business_glossary_term' = 'Source System Transaction ID');
ALTER TABLE `genomics_biotech_ecm`.`order`.`status_event` ALTER COLUMN `status_change_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Status Change Reason Code');
ALTER TABLE `genomics_biotech_ecm`.`order`.`status_event` ALTER COLUMN `status_change_reason_description` SET TAGS ('dbx_business_glossary_term' = 'Status Change Reason Description');
ALTER TABLE `genomics_biotech_ecm`.`order`.`status_event` ALTER COLUMN `tat_elapsed_hours` SET TAGS ('dbx_business_glossary_term' = 'Turnaround Time (TAT) Elapsed Hours');
ALTER TABLE `genomics_biotech_ecm`.`order`.`status_event` ALTER COLUMN `tat_target_hours` SET TAGS ('dbx_business_glossary_term' = 'Turnaround Time (TAT) Target Hours');
ALTER TABLE `genomics_biotech_ecm`.`order`.`status_event` ALTER COLUMN `triggered_by_system` SET TAGS ('dbx_business_glossary_term' = 'Triggered By System');
ALTER TABLE `genomics_biotech_ecm`.`order`.`status_event` ALTER COLUMN `triggered_by_system` SET TAGS ('dbx_value_regex' = 'SAP_SD|Salesforce_CRM|ServiceNow|Manual|Automated_Workflow|External_API');
ALTER TABLE `genomics_biotech_ecm`.`order`.`status_event` ALTER COLUMN `triggered_by_user_name` SET TAGS ('dbx_business_glossary_term' = 'Triggered By User Name');
ALTER TABLE `genomics_biotech_ecm`.`order`.`status_event` ALTER COLUMN `triggered_by_user_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`order`.`fulfillment_instruction` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `genomics_biotech_ecm`.`order`.`fulfillment_instruction` SET TAGS ('dbx_subdomain' = 'logistics_compliance');
ALTER TABLE `genomics_biotech_ecm`.`order`.`fulfillment_instruction` ALTER COLUMN `fulfillment_instruction_id` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Instruction Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`fulfillment_instruction` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Instrument Asset Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`fulfillment_instruction` ALTER COLUMN `assigned_team_org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Team Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`fulfillment_instruction` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Field Service Engineer Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`fulfillment_instruction` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`order`.`fulfillment_instruction` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`order`.`fulfillment_instruction` ALTER COLUMN `header_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Order Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`fulfillment_instruction` ALTER COLUMN `internal_order_id` SET TAGS ('dbx_business_glossary_term' = 'Internal Order Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`fulfillment_instruction` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Facility Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`fulfillment_instruction` ALTER COLUMN `sequencing_run_id` SET TAGS ('dbx_business_glossary_term' = 'Sequencing Run Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`fulfillment_instruction` ALTER COLUMN `warehouse_location_id` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Location Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`fulfillment_instruction` ALTER COLUMN `actual_completion_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Completion Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`order`.`fulfillment_instruction` ALTER COLUMN `actual_execution_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Execution Start Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`order`.`fulfillment_instruction` ALTER COLUMN `completion_confirmation_signature` SET TAGS ('dbx_business_glossary_term' = 'Completion Confirmation Signature');
ALTER TABLE `genomics_biotech_ecm`.`order`.`fulfillment_instruction` ALTER COLUMN `contact_email` SET TAGS ('dbx_business_glossary_term' = 'Delivery Contact Email Address');
ALTER TABLE `genomics_biotech_ecm`.`order`.`fulfillment_instruction` ALTER COLUMN `contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `genomics_biotech_ecm`.`order`.`fulfillment_instruction` ALTER COLUMN `contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`order`.`fulfillment_instruction` ALTER COLUMN `contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`order`.`fulfillment_instruction` ALTER COLUMN `contact_name` SET TAGS ('dbx_business_glossary_term' = 'Delivery Contact Name');
ALTER TABLE `genomics_biotech_ecm`.`order`.`fulfillment_instruction` ALTER COLUMN `contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`order`.`fulfillment_instruction` ALTER COLUMN `contact_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`order`.`fulfillment_instruction` ALTER COLUMN `contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Delivery Contact Phone Number');
ALTER TABLE `genomics_biotech_ecm`.`order`.`fulfillment_instruction` ALTER COLUMN `contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`order`.`fulfillment_instruction` ALTER COLUMN `contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`order`.`fulfillment_instruction` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`order`.`fulfillment_instruction` ALTER COLUMN `customs_declaration_number` SET TAGS ('dbx_business_glossary_term' = 'Customs Declaration Number');
ALTER TABLE `genomics_biotech_ecm`.`order`.`fulfillment_instruction` ALTER COLUMN `customs_declaration_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{10,20}$');
ALTER TABLE `genomics_biotech_ecm`.`order`.`fulfillment_instruction` ALTER COLUMN `execution_status` SET TAGS ('dbx_business_glossary_term' = 'Execution Status');
ALTER TABLE `genomics_biotech_ecm`.`order`.`fulfillment_instruction` ALTER COLUMN `export_control_classification` SET TAGS ('dbx_business_glossary_term' = 'Export Control Classification Number (ECCN)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`fulfillment_instruction` ALTER COLUMN `export_control_classification` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `genomics_biotech_ecm`.`order`.`fulfillment_instruction` ALTER COLUMN `failure_notes` SET TAGS ('dbx_business_glossary_term' = 'Failure Notes');
ALTER TABLE `genomics_biotech_ecm`.`order`.`fulfillment_instruction` ALTER COLUMN `failure_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Failure Reason Code');
ALTER TABLE `genomics_biotech_ecm`.`order`.`fulfillment_instruction` ALTER COLUMN `installation_appointment_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Installation Appointment Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`order`.`fulfillment_instruction` ALTER COLUMN `instruction_number` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Instruction Number');
ALTER TABLE `genomics_biotech_ecm`.`order`.`fulfillment_instruction` ALTER COLUMN `instruction_number` SET TAGS ('dbx_value_regex' = '^FI-[0-9]{10}$');
ALTER TABLE `genomics_biotech_ecm`.`order`.`fulfillment_instruction` ALTER COLUMN `instruction_type` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Instruction Type');
ALTER TABLE `genomics_biotech_ecm`.`order`.`fulfillment_instruction` ALTER COLUMN `instruction_type` SET TAGS ('dbx_value_regex' = 'ship|install|service_dispatch|activate|sample_kit_dispatch|cold_chain_ship');
ALTER TABLE `genomics_biotech_ecm`.`order`.`fulfillment_instruction` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`order`.`fulfillment_instruction` ALTER COLUMN `license_activation_key` SET TAGS ('dbx_business_glossary_term' = 'Software License Activation Key');
ALTER TABLE `genomics_biotech_ecm`.`order`.`fulfillment_instruction` ALTER COLUMN `license_activation_key` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{16,32}$');
ALTER TABLE `genomics_biotech_ecm`.`order`.`fulfillment_instruction` ALTER COLUMN `license_activation_key` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`order`.`fulfillment_instruction` ALTER COLUMN `packing_list_number` SET TAGS ('dbx_business_glossary_term' = 'Packing List Number');
ALTER TABLE `genomics_biotech_ecm`.`order`.`fulfillment_instruction` ALTER COLUMN `packing_list_number` SET TAGS ('dbx_value_regex' = '^PL-[0-9]{10}$');
ALTER TABLE `genomics_biotech_ecm`.`order`.`fulfillment_instruction` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `genomics_biotech_ecm`.`order`.`fulfillment_instruction` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'critical|high|normal|low');
ALTER TABLE `genomics_biotech_ecm`.`order`.`fulfillment_instruction` ALTER COLUMN `scheduled_execution_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Execution Date');
ALTER TABLE `genomics_biotech_ecm`.`order`.`fulfillment_instruction` ALTER COLUMN `ship_to_address_line1` SET TAGS ('dbx_business_glossary_term' = 'Ship-To Address Line 1');
ALTER TABLE `genomics_biotech_ecm`.`order`.`fulfillment_instruction` ALTER COLUMN `ship_to_address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`order`.`fulfillment_instruction` ALTER COLUMN `ship_to_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`order`.`fulfillment_instruction` ALTER COLUMN `ship_to_address_line2` SET TAGS ('dbx_business_glossary_term' = 'Ship-To Address Line 2');
ALTER TABLE `genomics_biotech_ecm`.`order`.`fulfillment_instruction` ALTER COLUMN `ship_to_address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`order`.`fulfillment_instruction` ALTER COLUMN `ship_to_address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`order`.`fulfillment_instruction` ALTER COLUMN `ship_to_city` SET TAGS ('dbx_business_glossary_term' = 'Ship-To City');
ALTER TABLE `genomics_biotech_ecm`.`order`.`fulfillment_instruction` ALTER COLUMN `ship_to_city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`order`.`fulfillment_instruction` ALTER COLUMN `ship_to_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`order`.`fulfillment_instruction` ALTER COLUMN `ship_to_country_code` SET TAGS ('dbx_business_glossary_term' = 'Ship-To Country Code');
ALTER TABLE `genomics_biotech_ecm`.`order`.`fulfillment_instruction` ALTER COLUMN `ship_to_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `genomics_biotech_ecm`.`order`.`fulfillment_instruction` ALTER COLUMN `ship_to_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Ship-To Postal Code');
ALTER TABLE `genomics_biotech_ecm`.`order`.`fulfillment_instruction` ALTER COLUMN `ship_to_postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`order`.`fulfillment_instruction` ALTER COLUMN `ship_to_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`order`.`fulfillment_instruction` ALTER COLUMN `ship_to_state_province` SET TAGS ('dbx_business_glossary_term' = 'Ship-To State or Province');
ALTER TABLE `genomics_biotech_ecm`.`order`.`fulfillment_instruction` ALTER COLUMN `ship_to_state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`order`.`fulfillment_instruction` ALTER COLUMN `ship_to_state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`order`.`fulfillment_instruction` ALTER COLUMN `shipping_carrier_code` SET TAGS ('dbx_business_glossary_term' = 'Shipping Carrier Code');
ALTER TABLE `genomics_biotech_ecm`.`order`.`fulfillment_instruction` ALTER COLUMN `shipping_carrier_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `genomics_biotech_ecm`.`order`.`fulfillment_instruction` ALTER COLUMN `shipping_service_level` SET TAGS ('dbx_business_glossary_term' = 'Shipping Service Level');
ALTER TABLE `genomics_biotech_ecm`.`order`.`fulfillment_instruction` ALTER COLUMN `shipping_service_level` SET TAGS ('dbx_value_regex' = 'overnight|two_day|ground|international_express|international_standard|white_glove');
ALTER TABLE `genomics_biotech_ecm`.`order`.`fulfillment_instruction` ALTER COLUMN `special_handling_code` SET TAGS ('dbx_business_glossary_term' = 'Special Handling Code');
ALTER TABLE `genomics_biotech_ecm`.`order`.`fulfillment_instruction` ALTER COLUMN `tat_deadline_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Turnaround Time (TAT) Deadline Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`order`.`fulfillment_instruction` ALTER COLUMN `temperature_monitoring_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Temperature Monitoring Required Flag');
ALTER TABLE `genomics_biotech_ecm`.`order`.`fulfillment_instruction` ALTER COLUMN `tracking_number` SET TAGS ('dbx_business_glossary_term' = 'Shipment Tracking Number');
ALTER TABLE `genomics_biotech_ecm`.`order`.`fulfillment_instruction` ALTER COLUMN `tracking_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{10,35}$');
ALTER TABLE `genomics_biotech_ecm`.`order`.`customer_acceptance` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `genomics_biotech_ecm`.`order`.`customer_acceptance` SET TAGS ('dbx_subdomain' = 'logistics_compliance');
ALTER TABLE `genomics_biotech_ecm`.`order`.`customer_acceptance` ALTER COLUMN `customer_acceptance_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Acceptance Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`customer_acceptance` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`customer_acceptance` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Instrument Asset Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`customer_acceptance` ALTER COLUMN `batch_id` SET TAGS ('dbx_business_glossary_term' = 'Batch Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`customer_acceptance` ALTER COLUMN `capa_id` SET TAGS ('dbx_business_glossary_term' = 'Corrective and Preventive Action (CAPA) Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`customer_acceptance` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By Employee Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`customer_acceptance` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`order`.`customer_acceptance` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`order`.`customer_acceptance` ALTER COLUMN `experiment_id` SET TAGS ('dbx_business_glossary_term' = 'Experiment Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`customer_acceptance` ALTER COLUMN `fair_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Fair Assessment Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`customer_acceptance` ALTER COLUMN `genome_assembly_id` SET TAGS ('dbx_business_glossary_term' = 'Genome Assembly Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`customer_acceptance` ALTER COLUMN `header_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Order Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`customer_acceptance` ALTER COLUMN `production_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Production Batch Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`customer_acceptance` ALTER COLUMN `revenue_recognition_id` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`customer_acceptance` ALTER COLUMN `sequencing_run_id` SET TAGS ('dbx_business_glossary_term' = 'Sequencing Run Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`customer_acceptance` ALTER COLUMN `shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`customer_acceptance` ALTER COLUMN `variant_database_version_id` SET TAGS ('dbx_business_glossary_term' = 'Variant Database Version Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`customer_acceptance` ALTER COLUMN `acceptance_date` SET TAGS ('dbx_business_glossary_term' = 'Acceptance Date');
ALTER TABLE `genomics_biotech_ecm`.`order`.`customer_acceptance` ALTER COLUMN `acceptance_document_url` SET TAGS ('dbx_business_glossary_term' = 'Acceptance Document Uniform Resource Locator (URL)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`customer_acceptance` ALTER COLUMN `acceptance_document_url` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`order`.`customer_acceptance` ALTER COLUMN `acceptance_method` SET TAGS ('dbx_business_glossary_term' = 'Acceptance Method');
ALTER TABLE `genomics_biotech_ecm`.`order`.`customer_acceptance` ALTER COLUMN `acceptance_method` SET TAGS ('dbx_value_regex' = 'electronic_signature|paper_signature|email_confirmation|portal_acknowledgment|automated_system');
ALTER TABLE `genomics_biotech_ecm`.`order`.`customer_acceptance` ALTER COLUMN `acceptance_notes` SET TAGS ('dbx_business_glossary_term' = 'Acceptance Notes');
ALTER TABLE `genomics_biotech_ecm`.`order`.`customer_acceptance` ALTER COLUMN `acceptance_number` SET TAGS ('dbx_business_glossary_term' = 'Acceptance Number');
ALTER TABLE `genomics_biotech_ecm`.`order`.`customer_acceptance` ALTER COLUMN `acceptance_number` SET TAGS ('dbx_value_regex' = '^ACC-[0-9]{8}$');
ALTER TABLE `genomics_biotech_ecm`.`order`.`customer_acceptance` ALTER COLUMN `acceptance_status` SET TAGS ('dbx_business_glossary_term' = 'Acceptance Status');
ALTER TABLE `genomics_biotech_ecm`.`order`.`customer_acceptance` ALTER COLUMN `acceptance_status` SET TAGS ('dbx_value_regex' = 'pending|accepted|rejected|conditionally_accepted|disputed|cancelled');
ALTER TABLE `genomics_biotech_ecm`.`order`.`customer_acceptance` ALTER COLUMN `acceptance_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Acceptance Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`order`.`customer_acceptance` ALTER COLUMN `acceptance_type` SET TAGS ('dbx_business_glossary_term' = 'Acceptance Type');
ALTER TABLE `genomics_biotech_ecm`.`order`.`customer_acceptance` ALTER COLUMN `acceptance_type` SET TAGS ('dbx_value_regex' = 'goods_receipt|installation_sign_off|sequencing_data_delivery|software_go_live|service_completion');
ALTER TABLE `genomics_biotech_ecm`.`order`.`customer_acceptance` ALTER COLUMN `actual_acceptance_days` SET TAGS ('dbx_business_glossary_term' = 'Actual Acceptance Days');
ALTER TABLE `genomics_biotech_ecm`.`order`.`customer_acceptance` ALTER COLUMN `capa_initiated` SET TAGS ('dbx_business_glossary_term' = 'Corrective and Preventive Action (CAPA) Initiated Flag');
ALTER TABLE `genomics_biotech_ecm`.`order`.`customer_acceptance` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`order`.`customer_acceptance` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `genomics_biotech_ecm`.`order`.`customer_acceptance` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `genomics_biotech_ecm`.`order`.`customer_acceptance` ALTER COLUMN `data_delivery_format` SET TAGS ('dbx_business_glossary_term' = 'Data Delivery Format');
ALTER TABLE `genomics_biotech_ecm`.`order`.`customer_acceptance` ALTER COLUMN `data_delivery_format` SET TAGS ('dbx_value_regex' = 'FASTQ|BAM|VCF|CRAM|HDF5|other');
ALTER TABLE `genomics_biotech_ecm`.`order`.`customer_acceptance` ALTER COLUMN `data_quality_metric_passed` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Metric Passed Flag');
ALTER TABLE `genomics_biotech_ecm`.`order`.`customer_acceptance` ALTER COLUMN `installation_qualification_status` SET TAGS ('dbx_business_glossary_term' = 'Installation Qualification (IQ) / Operational Qualification (OQ) / Performance Qualification (PQ) Status');
ALTER TABLE `genomics_biotech_ecm`.`order`.`customer_acceptance` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `genomics_biotech_ecm`.`order`.`customer_acceptance` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`order`.`customer_acceptance` ALTER COLUMN `qualification_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Qualification Completion Date');
ALTER TABLE `genomics_biotech_ecm`.`order`.`customer_acceptance` ALTER COLUMN `regulatory_submission_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Submission Date');
ALTER TABLE `genomics_biotech_ecm`.`order`.`customer_acceptance` ALTER COLUMN `regulatory_submission_required` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Submission Required Flag');
ALTER TABLE `genomics_biotech_ecm`.`order`.`customer_acceptance` ALTER COLUMN `rejection_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason Code');
ALTER TABLE `genomics_biotech_ecm`.`order`.`customer_acceptance` ALTER COLUMN `rejection_reason_description` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason Description');
ALTER TABLE `genomics_biotech_ecm`.`order`.`customer_acceptance` ALTER COLUMN `revenue_amount` SET TAGS ('dbx_business_glossary_term' = 'Revenue Amount');
ALTER TABLE `genomics_biotech_ecm`.`order`.`customer_acceptance` ALTER COLUMN `revenue_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`order`.`customer_acceptance` ALTER COLUMN `revenue_recognition_date` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition Date');
ALTER TABLE `genomics_biotech_ecm`.`order`.`customer_acceptance` ALTER COLUMN `revenue_recognition_triggered` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition Triggered Flag');
ALTER TABLE `genomics_biotech_ecm`.`order`.`customer_acceptance` ALTER COLUMN `signatory_email` SET TAGS ('dbx_business_glossary_term' = 'Signatory Email Address');
ALTER TABLE `genomics_biotech_ecm`.`order`.`customer_acceptance` ALTER COLUMN `signatory_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `genomics_biotech_ecm`.`order`.`customer_acceptance` ALTER COLUMN `signatory_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`order`.`customer_acceptance` ALTER COLUMN `signatory_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`order`.`customer_acceptance` ALTER COLUMN `signatory_name` SET TAGS ('dbx_business_glossary_term' = 'Signatory Name');
ALTER TABLE `genomics_biotech_ecm`.`order`.`customer_acceptance` ALTER COLUMN `signatory_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`order`.`customer_acceptance` ALTER COLUMN `signatory_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`order`.`customer_acceptance` ALTER COLUMN `signatory_title` SET TAGS ('dbx_business_glossary_term' = 'Signatory Title');
ALTER TABLE `genomics_biotech_ecm`.`order`.`customer_acceptance` ALTER COLUMN `sla_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Compliance Flag');
ALTER TABLE `genomics_biotech_ecm`.`order`.`customer_acceptance` ALTER COLUMN `sla_target_acceptance_days` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Target Acceptance Days');
ALTER TABLE `genomics_biotech_ecm`.`order`.`credit_memo` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `genomics_biotech_ecm`.`order`.`credit_memo` SET TAGS ('dbx_subdomain' = 'return_processing');
ALTER TABLE `genomics_biotech_ecm`.`order`.`credit_memo` ALTER COLUMN `credit_memo_id` SET TAGS ('dbx_business_glossary_term' = 'Credit Memo ID');
ALTER TABLE `genomics_biotech_ecm`.`order`.`credit_memo` ALTER COLUMN `complaint_id` SET TAGS ('dbx_business_glossary_term' = 'Complaint Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`credit_memo` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account ID');
ALTER TABLE `genomics_biotech_ecm`.`order`.`credit_memo` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approver ID');
ALTER TABLE `genomics_biotech_ecm`.`order`.`credit_memo` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`order`.`credit_memo` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`order`.`credit_memo` ALTER COLUMN `header_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Order ID');
ALTER TABLE `genomics_biotech_ecm`.`order`.`credit_memo` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`credit_memo` ALTER COLUMN `return_authorization_id` SET TAGS ('dbx_business_glossary_term' = 'Return Order ID');
ALTER TABLE `genomics_biotech_ecm`.`order`.`credit_memo` ALTER COLUMN `test_order_id` SET TAGS ('dbx_business_glossary_term' = 'Test Order Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`credit_memo` ALTER COLUMN `accounting_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Accounting Document Reference');
ALTER TABLE `genomics_biotech_ecm`.`order`.`credit_memo` ALTER COLUMN `accounting_document_reference` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{10,20}$');
ALTER TABLE `genomics_biotech_ecm`.`order`.`credit_memo` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `genomics_biotech_ecm`.`order`.`credit_memo` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `genomics_biotech_ecm`.`order`.`credit_memo` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|cancelled');
ALTER TABLE `genomics_biotech_ecm`.`order`.`credit_memo` ALTER COLUMN `billing_document_number` SET TAGS ('dbx_business_glossary_term' = 'Enterprise Resource Planning (ERP) Billing Document Number');
ALTER TABLE `genomics_biotech_ecm`.`order`.`credit_memo` ALTER COLUMN `billing_document_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{10,15}$');
ALTER TABLE `genomics_biotech_ecm`.`order`.`credit_memo` ALTER COLUMN `company_code` SET TAGS ('dbx_business_glossary_term' = 'Company Code');
ALTER TABLE `genomics_biotech_ecm`.`order`.`credit_memo` ALTER COLUMN `company_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `genomics_biotech_ecm`.`order`.`credit_memo` ALTER COLUMN `cost_center` SET TAGS ('dbx_business_glossary_term' = 'Cost Center');
ALTER TABLE `genomics_biotech_ecm`.`order`.`credit_memo` ALTER COLUMN `cost_center` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,12}$');
ALTER TABLE `genomics_biotech_ecm`.`order`.`credit_memo` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`order`.`credit_memo` ALTER COLUMN `credit_amount` SET TAGS ('dbx_business_glossary_term' = 'Credit Amount');
ALTER TABLE `genomics_biotech_ecm`.`order`.`credit_memo` ALTER COLUMN `credit_memo_number` SET TAGS ('dbx_business_glossary_term' = 'Credit Memo Number');
ALTER TABLE `genomics_biotech_ecm`.`order`.`credit_memo` ALTER COLUMN `credit_memo_number` SET TAGS ('dbx_value_regex' = '^CM-[0-9]{8,12}$');
ALTER TABLE `genomics_biotech_ecm`.`order`.`credit_memo` ALTER COLUMN `credit_memo_type` SET TAGS ('dbx_business_glossary_term' = 'Credit Memo Type');
ALTER TABLE `genomics_biotech_ecm`.`order`.`credit_memo` ALTER COLUMN `credit_memo_type` SET TAGS ('dbx_value_regex' = 'return-credit|price-correction|goodwill|service-failure|billing-error|volume-rebate');
ALTER TABLE `genomics_biotech_ecm`.`order`.`credit_memo` ALTER COLUMN `credit_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Credit Reason Code');
ALTER TABLE `genomics_biotech_ecm`.`order`.`credit_memo` ALTER COLUMN `credit_reason_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `genomics_biotech_ecm`.`order`.`credit_memo` ALTER COLUMN `credit_reason_description` SET TAGS ('dbx_business_glossary_term' = 'Credit Reason Description');
ALTER TABLE `genomics_biotech_ecm`.`order`.`credit_memo` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `genomics_biotech_ecm`.`order`.`credit_memo` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `genomics_biotech_ecm`.`order`.`credit_memo` ALTER COLUMN `customer_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Customer Reference Number');
ALTER TABLE `genomics_biotech_ecm`.`order`.`credit_memo` ALTER COLUMN `distribution_channel` SET TAGS ('dbx_business_glossary_term' = 'Distribution Channel');
ALTER TABLE `genomics_biotech_ecm`.`order`.`credit_memo` ALTER COLUMN `distribution_channel` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `genomics_biotech_ecm`.`order`.`credit_memo` ALTER COLUMN `division` SET TAGS ('dbx_business_glossary_term' = 'Division');
ALTER TABLE `genomics_biotech_ecm`.`order`.`credit_memo` ALTER COLUMN `division` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `genomics_biotech_ecm`.`order`.`credit_memo` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `genomics_biotech_ecm`.`order`.`credit_memo` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `genomics_biotech_ecm`.`order`.`credit_memo` ALTER COLUMN `issue_date` SET TAGS ('dbx_business_glossary_term' = 'Issue Date');
ALTER TABLE `genomics_biotech_ecm`.`order`.`credit_memo` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By');
ALTER TABLE `genomics_biotech_ecm`.`order`.`credit_memo` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`order`.`credit_memo` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `genomics_biotech_ecm`.`order`.`credit_memo` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `genomics_biotech_ecm`.`order`.`credit_memo` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'account-credit|refund-check|refund-wire|refund-credit-card|offset-invoice');
ALTER TABLE `genomics_biotech_ecm`.`order`.`credit_memo` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Date');
ALTER TABLE `genomics_biotech_ecm`.`order`.`credit_memo` ALTER COLUMN `profit_center` SET TAGS ('dbx_business_glossary_term' = 'Profit Center');
ALTER TABLE `genomics_biotech_ecm`.`order`.`credit_memo` ALTER COLUMN `profit_center` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,12}$');
ALTER TABLE `genomics_biotech_ecm`.`order`.`credit_memo` ALTER COLUMN `refund_date` SET TAGS ('dbx_business_glossary_term' = 'Refund Date');
ALTER TABLE `genomics_biotech_ecm`.`order`.`credit_memo` ALTER COLUMN `refund_status` SET TAGS ('dbx_business_glossary_term' = 'Refund Status');
ALTER TABLE `genomics_biotech_ecm`.`order`.`credit_memo` ALTER COLUMN `refund_status` SET TAGS ('dbx_value_regex' = 'not-applicable|pending|processed|completed|failed');
ALTER TABLE `genomics_biotech_ecm`.`order`.`credit_memo` ALTER COLUMN `revenue_reversal_flag` SET TAGS ('dbx_business_glossary_term' = 'Revenue Reversal Flag');
ALTER TABLE `genomics_biotech_ecm`.`order`.`credit_memo` ALTER COLUMN `sales_organization` SET TAGS ('dbx_business_glossary_term' = 'Sales Organization');
ALTER TABLE `genomics_biotech_ecm`.`order`.`credit_memo` ALTER COLUMN `sales_organization` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `genomics_biotech_ecm`.`order`.`credit_memo` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `genomics_biotech_ecm`.`order`.`credit_memo` ALTER COLUMN `total_credit_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Credit Amount');
ALTER TABLE `genomics_biotech_ecm`.`order`.`credit_memo` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `genomics_biotech_ecm`.`order`.`trade_compliance_check` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `genomics_biotech_ecm`.`order`.`trade_compliance_check` SET TAGS ('dbx_subdomain' = 'logistics_compliance');
ALTER TABLE `genomics_biotech_ecm`.`order`.`trade_compliance_check` ALTER COLUMN `trade_compliance_check_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Compliance Check Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`trade_compliance_check` ALTER COLUMN `approval_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`trade_compliance_check` ALTER COLUMN `controlled_document_id` SET TAGS ('dbx_business_glossary_term' = 'Controlled Document Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`trade_compliance_check` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`trade_compliance_check` ALTER COLUMN `dpia_id` SET TAGS ('dbx_business_glossary_term' = 'Dpia Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`trade_compliance_check` ALTER COLUMN `header_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Order Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`trade_compliance_check` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Officer Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`trade_compliance_check` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`order`.`trade_compliance_check` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`order`.`trade_compliance_check` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`order`.`trade_compliance_check` ALTER COLUMN `check_number` SET TAGS ('dbx_business_glossary_term' = 'Trade Compliance Check Number');
ALTER TABLE `genomics_biotech_ecm`.`order`.`trade_compliance_check` ALTER COLUMN `check_number` SET TAGS ('dbx_value_regex' = '^TCC-[0-9]{8}$');
ALTER TABLE `genomics_biotech_ecm`.`order`.`trade_compliance_check` ALTER COLUMN `check_validity_end_date` SET TAGS ('dbx_business_glossary_term' = 'Check Validity End Date');
ALTER TABLE `genomics_biotech_ecm`.`order`.`trade_compliance_check` ALTER COLUMN `check_validity_start_date` SET TAGS ('dbx_business_glossary_term' = 'Check Validity Start Date');
ALTER TABLE `genomics_biotech_ecm`.`order`.`trade_compliance_check` ALTER COLUMN `compliance_officer_review_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Officer Review Flag');
ALTER TABLE `genomics_biotech_ecm`.`order`.`trade_compliance_check` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `genomics_biotech_ecm`.`order`.`trade_compliance_check` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'cleared|pending-review|blocked|conditional-approval|escalated|expired');
ALTER TABLE `genomics_biotech_ecm`.`order`.`trade_compliance_check` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`order`.`trade_compliance_check` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `genomics_biotech_ecm`.`order`.`trade_compliance_check` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `genomics_biotech_ecm`.`order`.`trade_compliance_check` ALTER COLUMN `customer_country_code` SET TAGS ('dbx_business_glossary_term' = 'Customer Country Code');
ALTER TABLE `genomics_biotech_ecm`.`order`.`trade_compliance_check` ALTER COLUMN `customer_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `genomics_biotech_ecm`.`order`.`trade_compliance_check` ALTER COLUMN `denied_party_list_name` SET TAGS ('dbx_business_glossary_term' = 'Denied Party List Name');
ALTER TABLE `genomics_biotech_ecm`.`order`.`trade_compliance_check` ALTER COLUMN `denied_party_screening_result` SET TAGS ('dbx_business_glossary_term' = 'Denied Party Screening Result');
ALTER TABLE `genomics_biotech_ecm`.`order`.`trade_compliance_check` ALTER COLUMN `denied_party_screening_result` SET TAGS ('dbx_value_regex' = 'pass|fail|manual-review-required');
ALTER TABLE `genomics_biotech_ecm`.`order`.`trade_compliance_check` ALTER COLUMN `dual_use_flag` SET TAGS ('dbx_business_glossary_term' = 'Dual Use Flag');
ALTER TABLE `genomics_biotech_ecm`.`order`.`trade_compliance_check` ALTER COLUMN `eccn` SET TAGS ('dbx_business_glossary_term' = 'Export Control Classification Number (ECCN)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`trade_compliance_check` ALTER COLUMN `eccn` SET TAGS ('dbx_value_regex' = '^[0-9][A-Z][0-9]{3}(.[a-z])?$');
ALTER TABLE `genomics_biotech_ecm`.`order`.`trade_compliance_check` ALTER COLUMN `end_use_declaration` SET TAGS ('dbx_business_glossary_term' = 'End Use Declaration');
ALTER TABLE `genomics_biotech_ecm`.`order`.`trade_compliance_check` ALTER COLUMN `end_use_declaration` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`order`.`trade_compliance_check` ALTER COLUMN `harmonized_tariff_code` SET TAGS ('dbx_business_glossary_term' = 'Harmonized Tariff Schedule (HTS) Code');
ALTER TABLE `genomics_biotech_ecm`.`order`.`trade_compliance_check` ALTER COLUMN `harmonized_tariff_code` SET TAGS ('dbx_value_regex' = '^[0-9]{6,10}$');
ALTER TABLE `genomics_biotech_ecm`.`order`.`trade_compliance_check` ALTER COLUMN `itar_controlled_flag` SET TAGS ('dbx_business_glossary_term' = 'International Traffic in Arms Regulations (ITAR) Controlled Flag');
ALTER TABLE `genomics_biotech_ecm`.`order`.`trade_compliance_check` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`order`.`trade_compliance_check` ALTER COLUMN `license_exception_code` SET TAGS ('dbx_business_glossary_term' = 'License Exception Code');
ALTER TABLE `genomics_biotech_ecm`.`order`.`trade_compliance_check` ALTER COLUMN `license_exception_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `genomics_biotech_ecm`.`order`.`trade_compliance_check` ALTER COLUMN `license_number` SET TAGS ('dbx_business_glossary_term' = 'Export License Number');
ALTER TABLE `genomics_biotech_ecm`.`order`.`trade_compliance_check` ALTER COLUMN `license_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{10,20}$');
ALTER TABLE `genomics_biotech_ecm`.`order`.`trade_compliance_check` ALTER COLUMN `license_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`order`.`trade_compliance_check` ALTER COLUMN `license_requirement_flag` SET TAGS ('dbx_business_glossary_term' = 'License Requirement Flag');
ALTER TABLE `genomics_biotech_ecm`.`order`.`trade_compliance_check` ALTER COLUMN `product_category` SET TAGS ('dbx_business_glossary_term' = 'Product Category');
ALTER TABLE `genomics_biotech_ecm`.`order`.`trade_compliance_check` ALTER COLUMN `product_category` SET TAGS ('dbx_value_regex' = 'instrument|reagent|consumable|sequencing-service|software|genomic-data');
ALTER TABLE `genomics_biotech_ecm`.`order`.`trade_compliance_check` ALTER COLUMN `product_sku` SET TAGS ('dbx_business_glossary_term' = 'Product Stock Keeping Unit (SKU)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`trade_compliance_check` ALTER COLUMN `regulatory_hold_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Hold Reference');
ALTER TABLE `genomics_biotech_ecm`.`order`.`trade_compliance_check` ALTER COLUMN `regulatory_hold_reference` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`order`.`trade_compliance_check` ALTER COLUMN `review_date` SET TAGS ('dbx_business_glossary_term' = 'Compliance Review Date');
ALTER TABLE `genomics_biotech_ecm`.`order`.`trade_compliance_check` ALTER COLUMN `review_notes` SET TAGS ('dbx_business_glossary_term' = 'Compliance Review Notes');
ALTER TABLE `genomics_biotech_ecm`.`order`.`trade_compliance_check` ALTER COLUMN `review_notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`order`.`trade_compliance_check` ALTER COLUMN `risk_category` SET TAGS ('dbx_business_glossary_term' = 'Compliance Risk Category');
ALTER TABLE `genomics_biotech_ecm`.`order`.`trade_compliance_check` ALTER COLUMN `risk_category` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `genomics_biotech_ecm`.`order`.`trade_compliance_check` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Compliance Risk Score');
ALTER TABLE `genomics_biotech_ecm`.`order`.`trade_compliance_check` ALTER COLUMN `routed_export_transaction_flag` SET TAGS ('dbx_business_glossary_term' = 'Routed Export Transaction Flag');
ALTER TABLE `genomics_biotech_ecm`.`order`.`trade_compliance_check` ALTER COLUMN `screening_date` SET TAGS ('dbx_business_glossary_term' = 'Screening Date');
ALTER TABLE `genomics_biotech_ecm`.`order`.`trade_compliance_check` ALTER COLUMN `screening_system_name` SET TAGS ('dbx_business_glossary_term' = 'Screening System Name');
ALTER TABLE `genomics_biotech_ecm`.`order`.`trade_compliance_check` ALTER COLUMN `screening_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Screening Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`order`.`trade_compliance_check` ALTER COLUMN `shipment_value_amount` SET TAGS ('dbx_business_glossary_term' = 'Shipment Value Amount');
ALTER TABLE `genomics_biotech_ecm`.`order`.`trade_compliance_check` ALTER COLUMN `ultimate_consignee_country_code` SET TAGS ('dbx_business_glossary_term' = 'Ultimate Consignee Country Code');
ALTER TABLE `genomics_biotech_ecm`.`order`.`trade_compliance_check` ALTER COLUMN `ultimate_consignee_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `genomics_biotech_ecm`.`order`.`trade_compliance_check` ALTER COLUMN `ultimate_consignee_name` SET TAGS ('dbx_business_glossary_term' = 'Ultimate Consignee Name');
ALTER TABLE `genomics_biotech_ecm`.`order`.`trade_compliance_check` ALTER COLUMN `ultimate_consignee_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`order`.`customer_po` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `genomics_biotech_ecm`.`order`.`customer_po` SET TAGS ('dbx_subdomain' = 'order_capture');
ALTER TABLE `genomics_biotech_ecm`.`order`.`customer_po` ALTER COLUMN `customer_po_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Purchase Order (PO) ID');
ALTER TABLE `genomics_biotech_ecm`.`order`.`customer_po` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account ID');
ALTER TABLE `genomics_biotech_ecm`.`order`.`customer_po` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By User ID');
ALTER TABLE `genomics_biotech_ecm`.`order`.`customer_po` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`order`.`customer_po` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`order`.`customer_po` ALTER COLUMN `finance_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Finance Budget Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`customer_po` ALTER COLUMN `header_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Order (SO) ID');
ALTER TABLE `genomics_biotech_ecm`.`order`.`customer_po` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `genomics_biotech_ecm`.`order`.`customer_po` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|under_review');
ALTER TABLE `genomics_biotech_ecm`.`order`.`customer_po` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`order`.`customer_po` ALTER COLUMN `billing_address_line1` SET TAGS ('dbx_business_glossary_term' = 'Billing Address Line 1');
ALTER TABLE `genomics_biotech_ecm`.`order`.`customer_po` ALTER COLUMN `billing_address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`order`.`customer_po` ALTER COLUMN `billing_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`order`.`customer_po` ALTER COLUMN `billing_address_line2` SET TAGS ('dbx_business_glossary_term' = 'Billing Address Line 2');
ALTER TABLE `genomics_biotech_ecm`.`order`.`customer_po` ALTER COLUMN `billing_address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`order`.`customer_po` ALTER COLUMN `billing_address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`order`.`customer_po` ALTER COLUMN `billing_city` SET TAGS ('dbx_business_glossary_term' = 'Billing City');
ALTER TABLE `genomics_biotech_ecm`.`order`.`customer_po` ALTER COLUMN `billing_city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`order`.`customer_po` ALTER COLUMN `billing_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`order`.`customer_po` ALTER COLUMN `billing_country_code` SET TAGS ('dbx_business_glossary_term' = 'Billing Country Code');
ALTER TABLE `genomics_biotech_ecm`.`order`.`customer_po` ALTER COLUMN `billing_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `genomics_biotech_ecm`.`order`.`customer_po` ALTER COLUMN `billing_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Billing Postal Code');
ALTER TABLE `genomics_biotech_ecm`.`order`.`customer_po` ALTER COLUMN `billing_postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`order`.`customer_po` ALTER COLUMN `billing_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`order`.`customer_po` ALTER COLUMN `billing_state_province` SET TAGS ('dbx_business_glossary_term' = 'Billing State or Province');
ALTER TABLE `genomics_biotech_ecm`.`order`.`customer_po` ALTER COLUMN `billing_state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`order`.`customer_po` ALTER COLUMN `billing_state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`order`.`customer_po` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `genomics_biotech_ecm`.`order`.`customer_po` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`order`.`customer_po` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `genomics_biotech_ecm`.`order`.`customer_po` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `genomics_biotech_ecm`.`order`.`customer_po` ALTER COLUMN `customer_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Customer Contact Email');
ALTER TABLE `genomics_biotech_ecm`.`order`.`customer_po` ALTER COLUMN `customer_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `genomics_biotech_ecm`.`order`.`customer_po` ALTER COLUMN `customer_contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`order`.`customer_po` ALTER COLUMN `customer_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`order`.`customer_po` ALTER COLUMN `customer_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Customer Contact Name');
ALTER TABLE `genomics_biotech_ecm`.`order`.`customer_po` ALTER COLUMN `customer_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`order`.`customer_po` ALTER COLUMN `customer_contact_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`order`.`customer_po` ALTER COLUMN `customer_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Customer Contact Phone');
ALTER TABLE `genomics_biotech_ecm`.`order`.`customer_po` ALTER COLUMN `customer_contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`order`.`customer_po` ALTER COLUMN `customer_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`order`.`customer_po` ALTER COLUMN `customer_erp_po_reference` SET TAGS ('dbx_business_glossary_term' = 'Customer Enterprise Resource Planning (ERP) Purchase Order (PO) Reference');
ALTER TABLE `genomics_biotech_ecm`.`order`.`customer_po` ALTER COLUMN `customer_erp_system` SET TAGS ('dbx_business_glossary_term' = 'Customer Enterprise Resource Planning (ERP) System');
ALTER TABLE `genomics_biotech_ecm`.`order`.`customer_po` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`order`.`customer_po` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `genomics_biotech_ecm`.`order`.`customer_po` ALTER COLUMN `po_consumed_value` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Consumed Value');
ALTER TABLE `genomics_biotech_ecm`.`order`.`customer_po` ALTER COLUMN `po_issue_date` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Issue Date');
ALTER TABLE `genomics_biotech_ecm`.`order`.`customer_po` ALTER COLUMN `po_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Number');
ALTER TABLE `genomics_biotech_ecm`.`order`.`customer_po` ALTER COLUMN `po_received_date` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Received Date');
ALTER TABLE `genomics_biotech_ecm`.`order`.`customer_po` ALTER COLUMN `po_remaining_balance` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Remaining Balance');
ALTER TABLE `genomics_biotech_ecm`.`order`.`customer_po` ALTER COLUMN `po_status` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Status');
ALTER TABLE `genomics_biotech_ecm`.`order`.`customer_po` ALTER COLUMN `po_status` SET TAGS ('dbx_value_regex' = 'open|partially_consumed|fully_consumed|cancelled|expired|on_hold');
ALTER TABLE `genomics_biotech_ecm`.`order`.`customer_po` ALTER COLUMN `po_total_value` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Total Value');
ALTER TABLE `genomics_biotech_ecm`.`order`.`customer_po` ALTER COLUMN `po_type` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Type');
ALTER TABLE `genomics_biotech_ecm`.`order`.`customer_po` ALTER COLUMN `po_type` SET TAGS ('dbx_value_regex' = 'standard|blanket|framework|government|contract|spot');
ALTER TABLE `genomics_biotech_ecm`.`order`.`customer_po` ALTER COLUMN `po_validity_end_date` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Validity End Date');
ALTER TABLE `genomics_biotech_ecm`.`order`.`customer_po` ALTER COLUMN `po_validity_start_date` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Validity Start Date');
ALTER TABLE `genomics_biotech_ecm`.`order`.`customer_po` ALTER COLUMN `requisitioner_name` SET TAGS ('dbx_business_glossary_term' = 'Requisitioner Name');
ALTER TABLE `genomics_biotech_ecm`.`order`.`customer_po` ALTER COLUMN `requisitioner_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`order`.`customer_po` ALTER COLUMN `requisitioner_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`order`.`customer_po` ALTER COLUMN `ship_to_address_line1` SET TAGS ('dbx_business_glossary_term' = 'Ship-To Address Line 1');
ALTER TABLE `genomics_biotech_ecm`.`order`.`customer_po` ALTER COLUMN `ship_to_address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`order`.`customer_po` ALTER COLUMN `ship_to_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`order`.`customer_po` ALTER COLUMN `ship_to_address_line2` SET TAGS ('dbx_business_glossary_term' = 'Ship-To Address Line 2');
ALTER TABLE `genomics_biotech_ecm`.`order`.`customer_po` ALTER COLUMN `ship_to_address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`order`.`customer_po` ALTER COLUMN `ship_to_address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`order`.`customer_po` ALTER COLUMN `ship_to_city` SET TAGS ('dbx_business_glossary_term' = 'Ship-To City');
ALTER TABLE `genomics_biotech_ecm`.`order`.`customer_po` ALTER COLUMN `ship_to_city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`order`.`customer_po` ALTER COLUMN `ship_to_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`order`.`customer_po` ALTER COLUMN `ship_to_country_code` SET TAGS ('dbx_business_glossary_term' = 'Ship-To Country Code');
ALTER TABLE `genomics_biotech_ecm`.`order`.`customer_po` ALTER COLUMN `ship_to_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `genomics_biotech_ecm`.`order`.`customer_po` ALTER COLUMN `ship_to_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Ship-To Postal Code');
ALTER TABLE `genomics_biotech_ecm`.`order`.`customer_po` ALTER COLUMN `ship_to_postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`order`.`customer_po` ALTER COLUMN `ship_to_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`order`.`customer_po` ALTER COLUMN `ship_to_state_province` SET TAGS ('dbx_business_glossary_term' = 'Ship-To State or Province');
ALTER TABLE `genomics_biotech_ecm`.`order`.`customer_po` ALTER COLUMN `ship_to_state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`order`.`customer_po` ALTER COLUMN `ship_to_state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`order`.`customer_po` ALTER COLUMN `shipping_terms` SET TAGS ('dbx_business_glossary_term' = 'Shipping Terms');
ALTER TABLE `genomics_biotech_ecm`.`order`.`customer_po` ALTER COLUMN `special_terms_notes` SET TAGS ('dbx_business_glossary_term' = 'Special Terms Notes');
ALTER TABLE `genomics_biotech_ecm`.`order`.`blanket_order` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `genomics_biotech_ecm`.`order`.`blanket_order` SET TAGS ('dbx_subdomain' = 'order_capture');
ALTER TABLE `genomics_biotech_ecm`.`order`.`blanket_order` ALTER COLUMN `blanket_order_id` SET TAGS ('dbx_business_glossary_term' = 'Blanket Order ID');
ALTER TABLE `genomics_biotech_ecm`.`order`.`blanket_order` ALTER COLUMN `catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Reagent Catalog Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`blanket_order` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Commercial Contract Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`blanket_order` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account ID');
ALTER TABLE `genomics_biotech_ecm`.`order`.`blanket_order` ALTER COLUMN `finance_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Finance Budget Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`blanket_order` ALTER COLUMN `test_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Ivd Test Catalog Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`blanket_order` ALTER COLUMN `address_id` SET TAGS ('dbx_business_glossary_term' = 'Ship-To Location ID');
ALTER TABLE `genomics_biotech_ecm`.`order`.`blanket_order` ALTER COLUMN `address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`order`.`blanket_order` ALTER COLUMN `address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`order`.`blanket_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Representative ID');
ALTER TABLE `genomics_biotech_ecm`.`order`.`blanket_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`order`.`blanket_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`order`.`blanket_order` ALTER COLUMN `opportunity_id` SET TAGS ('dbx_business_glossary_term' = 'Salesforce Opportunity ID');
ALTER TABLE `genomics_biotech_ecm`.`order`.`blanket_order` ALTER COLUMN `sequencing_protocol_id` SET TAGS ('dbx_business_glossary_term' = 'Sequencing Protocol Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`blanket_order` ALTER COLUMN `sku_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`order`.`blanket_order` ALTER COLUMN `tertiary_blanket_contract_owner_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Owner ID');
ALTER TABLE `genomics_biotech_ecm`.`order`.`blanket_order` ALTER COLUMN `tertiary_blanket_contract_owner_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`order`.`blanket_order` ALTER COLUMN `tertiary_blanket_contract_owner_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`order`.`blanket_order` ALTER COLUMN `agreement_end_date` SET TAGS ('dbx_business_glossary_term' = 'Agreement End Date');
ALTER TABLE `genomics_biotech_ecm`.`order`.`blanket_order` ALTER COLUMN `agreement_start_date` SET TAGS ('dbx_business_glossary_term' = 'Agreement Start Date');
ALTER TABLE `genomics_biotech_ecm`.`order`.`blanket_order` ALTER COLUMN `agreement_type` SET TAGS ('dbx_business_glossary_term' = 'Agreement Type');
ALTER TABLE `genomics_biotech_ecm`.`order`.`blanket_order` ALTER COLUMN `agreement_type` SET TAGS ('dbx_value_regex' = 'volume_commitment|value_commitment|call_off|consignment');
ALTER TABLE `genomics_biotech_ecm`.`order`.`blanket_order` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`order`.`blanket_order` ALTER COLUMN `auto_renewal_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto-Renewal Flag');
ALTER TABLE `genomics_biotech_ecm`.`order`.`blanket_order` ALTER COLUMN `blanket_order_number` SET TAGS ('dbx_business_glossary_term' = 'Blanket Order Number');
ALTER TABLE `genomics_biotech_ecm`.`order`.`blanket_order` ALTER COLUMN `blanket_order_status` SET TAGS ('dbx_business_glossary_term' = 'Blanket Order Status');
ALTER TABLE `genomics_biotech_ecm`.`order`.`blanket_order` ALTER COLUMN `consumed_quantity` SET TAGS ('dbx_business_glossary_term' = 'Consumed Quantity');
ALTER TABLE `genomics_biotech_ecm`.`order`.`blanket_order` ALTER COLUMN `consumed_value` SET TAGS ('dbx_business_glossary_term' = 'Consumed Value');
ALTER TABLE `genomics_biotech_ecm`.`order`.`blanket_order` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`order`.`blanket_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `genomics_biotech_ecm`.`order`.`blanket_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `genomics_biotech_ecm`.`order`.`blanket_order` ALTER COLUMN `discount_percentage` SET TAGS ('dbx_business_glossary_term' = 'Discount Percentage');
ALTER TABLE `genomics_biotech_ecm`.`order`.`blanket_order` ALTER COLUMN `discount_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`order`.`blanket_order` ALTER COLUMN `erp_scheduling_agreement_number` SET TAGS ('dbx_business_glossary_term' = 'Enterprise Resource Planning (ERP) Scheduling Agreement Number');
ALTER TABLE `genomics_biotech_ecm`.`order`.`blanket_order` ALTER COLUMN `incoterms` SET TAGS ('dbx_business_glossary_term' = 'International Commercial Terms (Incoterms)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`blanket_order` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`order`.`blanket_order` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time Days');
ALTER TABLE `genomics_biotech_ecm`.`order`.`blanket_order` ALTER COLUMN `maximum_release_quantity` SET TAGS ('dbx_business_glossary_term' = 'Maximum Release Quantity');
ALTER TABLE `genomics_biotech_ecm`.`order`.`blanket_order` ALTER COLUMN `minimum_release_quantity` SET TAGS ('dbx_business_glossary_term' = 'Minimum Release Quantity');
ALTER TABLE `genomics_biotech_ecm`.`order`.`blanket_order` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `genomics_biotech_ecm`.`order`.`blanket_order` ALTER COLUMN `pricing_tier` SET TAGS ('dbx_business_glossary_term' = 'Pricing Tier');
ALTER TABLE `genomics_biotech_ecm`.`order`.`blanket_order` ALTER COLUMN `pricing_tier` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`order`.`blanket_order` ALTER COLUMN `product_category` SET TAGS ('dbx_business_glossary_term' = 'Product Category');
ALTER TABLE `genomics_biotech_ecm`.`order`.`blanket_order` ALTER COLUMN `product_category` SET TAGS ('dbx_value_regex' = 'reagent_kit|consumable|sequencing_service|instrument|software_license|support_service');
ALTER TABLE `genomics_biotech_ecm`.`order`.`blanket_order` ALTER COLUMN `product_sku` SET TAGS ('dbx_business_glossary_term' = 'Product Stock Keeping Unit (SKU)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`blanket_order` ALTER COLUMN `regulatory_use_designation` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Use Designation');
ALTER TABLE `genomics_biotech_ecm`.`order`.`blanket_order` ALTER COLUMN `regulatory_use_designation` SET TAGS ('dbx_value_regex' = 'RUO|IVD|LDT|GMP');
ALTER TABLE `genomics_biotech_ecm`.`order`.`blanket_order` ALTER COLUMN `release_frequency` SET TAGS ('dbx_business_glossary_term' = 'Release Frequency');
ALTER TABLE `genomics_biotech_ecm`.`order`.`blanket_order` ALTER COLUMN `release_frequency` SET TAGS ('dbx_value_regex' = 'weekly|biweekly|monthly|quarterly|on_demand');
ALTER TABLE `genomics_biotech_ecm`.`order`.`blanket_order` ALTER COLUMN `remaining_quantity` SET TAGS ('dbx_business_glossary_term' = 'Remaining Quantity');
ALTER TABLE `genomics_biotech_ecm`.`order`.`blanket_order` ALTER COLUMN `remaining_value` SET TAGS ('dbx_business_glossary_term' = 'Remaining Value');
ALTER TABLE `genomics_biotech_ecm`.`order`.`blanket_order` ALTER COLUMN `renewal_notice_days` SET TAGS ('dbx_business_glossary_term' = 'Renewal Notice Days');
ALTER TABLE `genomics_biotech_ecm`.`order`.`blanket_order` ALTER COLUMN `special_terms_conditions` SET TAGS ('dbx_business_glossary_term' = 'Special Terms and Conditions');
ALTER TABLE `genomics_biotech_ecm`.`order`.`blanket_order` ALTER COLUMN `termination_notice_days` SET TAGS ('dbx_business_glossary_term' = 'Termination Notice Days');
ALTER TABLE `genomics_biotech_ecm`.`order`.`blanket_order` ALTER COLUMN `total_committed_quantity` SET TAGS ('dbx_business_glossary_term' = 'Total Committed Quantity');
ALTER TABLE `genomics_biotech_ecm`.`order`.`blanket_order` ALTER COLUMN `total_committed_value` SET TAGS ('dbx_business_glossary_term' = 'Total Committed Value');
ALTER TABLE `genomics_biotech_ecm`.`order`.`blanket_order` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `genomics_biotech_ecm`.`order`.`blanket_order` ALTER COLUMN `unit_price` SET TAGS ('dbx_business_glossary_term' = 'Unit Price');
ALTER TABLE `genomics_biotech_ecm`.`order`.`blanket_order` ALTER COLUMN `unit_price` SET TAGS ('dbx_confidential' = 'true');
