-- Schema for Domain: order | Business: Genomics Biotech | Version: v1_mvm
-- Generated on: 2026-05-06 15:33:27

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `genomics_biotech_ecm`.`order` COMMENT 'Manages the complete commercial order lifecycle — quotes, sales orders, fulfillment instructions, shipment tracking, returns, and customer acceptance — for instruments, reagents, consumables, sequencing services, and software. Integrates SAP SD for order-to-cash processing and Salesforce CRM for opportunity-to-order handoff. SSOT for order status, SLA-driven TAT commitments, and delivery records.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`order`.`header` (
    `header_id` BIGINT COMMENT 'Primary key for header',
    `approval_id` BIGINT COMMENT 'Foreign key linking to regulatory.regulatory_approval. Business justification: Orders for IVD/regulated genomics products must reference the regulatory approval under which theyre sold for market authorization compliance, export documentation, labeling requirements, and revenue',
    `collaboration_agreement_id` BIGINT COMMENT 'Foreign key linking to research.collaboration_agreement. Business justification: Orders placed under collaboration agreements must reference the agreement for IP ownership tracking, special payment terms enforcement, data sharing compliance, and publication rights management. This',
    `account_id` BIGINT COMMENT 'Foreign key reference to the party (location, facility, or contact) where the order should be physically delivered. May differ from bill-to party for multi-site organizations.',
    `header_bill_to_party_account_id` BIGINT COMMENT 'Foreign key reference to the party responsible for payment. Invoices are sent to this party. May differ from ship-to party for centralized billing.',
    `header_customer_account_id` BIGINT COMMENT 'Foreign key reference to the customer account that placed this order. Links to the customer master data entity.',
    `header_sold_to_party_account_id` BIGINT COMMENT 'Foreign key reference to the primary contracting party. Represents the legal entity entering into the sales agreement.',
    `model_id` BIGINT COMMENT 'Foreign key linking to instrument.instrument_model. Business justification: Capital equipment orders for sequencing instruments require instrument model reference for pricing validation, configuration management, regulatory compliance verification, and service contract setup.',
    `project_id` BIGINT COMMENT 'Foreign key linking to research.project. Business justification: Academic and pharma customers frequently purchase sequencing services or instruments for specific R&D projects. Linking orders to projects enables grant-funded revenue recognition, project-based cost ',
    `service_agreement_id` BIGINT COMMENT 'Foreign key linking to customer.service_agreement. Business justification: Service order SLA and contract utilization tracking: in genomics biotech, instrument service orders (preventive maintenance, field service) are placed under a service agreement governing SLA, pricing,',
    `service_offering_id` BIGINT COMMENT 'Foreign key linking to product.service_offering. Business justification: Service Order Management: In genomics biotech, sales order headers for sequencing services, installation, or training must reference the service offering catalog entry. Enables service revenue reporti',
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
    `accreditation_id` BIGINT COMMENT 'Foreign key linking to customer.accreditation. Business justification: IVD and regulated product sales compliance: genomics biotech order lines for IVD kits and clinical sequencing reagents must be validated against the customer laboratorys accreditation (CAP, CLIA, ISO',
    `approval_id` BIGINT COMMENT 'Foreign key linking to regulatory.regulatory_approval. Business justification: Line-level regulatory tracking required because mixed orders contain products under different approvals (RUO, CE-IVD, FDA-cleared sequencing kits). Business process: line-item compliance verification,',
    `assay_development_id` BIGINT COMMENT 'Foreign key linking to research.assay_development. Business justification: In genomics biotech, customers order custom assay development services; the order line must reference the assay_development record for milestone-based billing, regulatory compliance tracking, and R&D ',
    `batch_id` BIGINT COMMENT 'Foreign key linking to supply.batch. Business justification: GMP lot traceability: each reagent/consumable sales order line in genomics biotech must reference the specific supply batch for CoA attachment, expiry validation, and regulatory lot-level traceability',
    `catalog_id` BIGINT COMMENT 'Foreign key linking to reagent.reagent_catalog. Business justification: Order lines in genomics biotech sell reagent kits, sequencing consumables, and arrays. FK enables regulatory traceability, accurate catalog pricing, product lifecycle validation (discontinued items), ',
    `change_control_id` BIGINT COMMENT 'Foreign key linking to quality.change_control. Business justification: Order lines for products under active change control (formulation changes, manufacturing process changes) in genomics/biotech must reference the change control record. This enables quality teams to id',
    `controlled_document_id` BIGINT COMMENT 'Foreign key linking to quality.controlled_document. Business justification: Order lines for regulated genomics products (IVD kits, GMP reagents) must reference the controlled product specification or IFU version in effect at order time. This supports ISO 13485 design history ',
    `crispr_construct_id` BIGINT COMMENT 'Foreign key linking to research.crispr_construct. Business justification: Customers order custom CRISPR constructs in genomics biotech; the order line must reference the crispr_construct record for manufacturing specifications, QC release criteria, export control classifica',
    `grant_id` BIGINT COMMENT 'Foreign key linking to research.grant. Business justification: Grant-funded orders in genomics biotech require line-level grant attribution for NIH/NSF cost allocation reporting, indirect cost calculation, and grant compliance audits. Line-level attribution is re',
    `header_id` BIGINT COMMENT 'Reference to the parent sales order header. Links this line item to its containing order document.',
    `test_catalog_id` BIGINT COMMENT 'Foreign key linking to clinical.test_catalog. Business justification: Order lines for clinical testing services reference the specific test from the catalog. Required for order fulfillment, specimen routing, TAT tracking, and billing. Core business process linking comme',
    `labeling_id` BIGINT COMMENT 'Foreign key linking to regulatory.labeling. Business justification: IVD and reagent order lines must reference the regulatory-approved labeling version to ensure the correct labeling is fulfilled. EU IVDR/FDA 21 CFR requires labeling version traceability per order lin',
    `library_id` BIGINT COMMENT 'Foreign key linking to sequencing.library. Business justification: Sequencing service orders specify which prepared library is being sequenced. Critical for order fulfillment, sample tracking, and linking commercial orders to lab operations. Enables "which library wa',
    `lot_id` BIGINT COMMENT 'Foreign key linking to reagent.lot. Business justification: GxP regulations require lot-level traceability from customer shipments to manufacturing batch. FK enables CoA provision, recall management, expiry tracking, and regulatory audit trails. Replaces denor',
    `material_id` BIGINT COMMENT 'Foreign key linking to supply.material. Business justification: Order lines reference supply master data for reagent kits, sequencing consumables, and instruments. Enables inventory allocation, COA attachment, regulatory status validation, and storage condition en',
    `model_id` BIGINT COMMENT 'Foreign key linking to instrument.instrument_model. Business justification: Reagent kit and consumable line items must validate compatibility with customers instrument model. Sequencing service orders require instrument model for read length, flow cell type, and chemistry co',
    `molecular_design_id` BIGINT COMMENT 'Foreign key linking to research.molecular_design. Business justification: Order lines for custom molecular tools (probes, primers, guide RNAs) must reference the molecular_design record for synthesis specifications, IP status verification, and export control compliance. Thi',
    `nonconformance_id` BIGINT COMMENT 'Foreign key linking to quality.nonconformance. Business justification: Specific order line items (lots/batches) may be subject to nonconformances discovered post-shipment (field failures, customer QC rejections). Field quality issues traced back to specific order lines f',
    `pipeline_version_id` BIGINT COMMENT 'Foreign key linking to bioinformatics.pipeline_version. Business justification: For regulated genomics services (IVD, LDT, GxP), the exact pipeline version used for analysis must be contractually specified in the order line. This link enables regulatory traceability, change-contr',
    `plant_id` BIGINT COMMENT 'Foreign key linking to supply.plant. Business justification: Fulfillment plant assignment: each sales order line in genomics biotech is fulfilled from a specific manufacturing or distribution plant. plant_code is currently denormalized plain text; a proper FK e',
    `pricing_id` BIGINT COMMENT 'Foreign key linking to product.pricing. Business justification: Pricing Audit and Contract Compliance: Order lines must reference the specific product.pricing record applied at order time. Supports revenue recognition, contract price verification, and pricing audi',
    `production_batch_id` BIGINT COMMENT 'Foreign key linking to manufacturing.production_batch. Business justification: Regulatory compliance (21 CFR Part 11, ISO 13485) mandates batch traceability for reagents, flow cells, and consumables. Order lines must link to production batches for CoA delivery, lot genealogy, an',
    `qc_specification_id` BIGINT COMMENT 'Foreign key linking to reagent.qc_specification. Business justification: GMP reagent supply agreements often include customer-specific QC specifications per order line. Linking order.line to reagent.qc_specification drives which CoA content and acceptance criteria apply to',
    `project_id` BIGINT COMMENT 'Foreign key linking to research.project. Business justification: Mixed orders where some line items are project-funded (grant-purchased reagents) and others are not require line-level project attribution. Supports project cost allocation, grant accounting, and audi',
    `sequencing_protocol_id` BIGINT COMMENT 'Foreign key linking to sequencing.sequencing_protocol. Business justification: Service orders specify sequencing protocol requirements (read length, coverage depth, application type) that drive pricing, TAT commitments, and fulfillment specifications. Essential for translating c',
    `service_offering_id` BIGINT COMMENT 'Foreign key linking to product.service_offering. Business justification: Service Order Line Management: Order lines for sequencing services, field installation, or training must reference the service offering being delivered. Supports service delivery scheduling, SLA compl',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: Order lines must reference specific orderable SKUs for inventory allocation, fulfillment execution, pricing validation, and lot traceability. Critical for order-to-cash process and ERP integration. Re',
    `software_release_id` BIGINT COMMENT 'Foreign key linking to product.software_release. Business justification: Software License Order Fulfillment: In genomics biotech, order lines for analysis software or pipeline licenses reference the specific software release being sold. Enables version-specific license pro',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to supply.supplier. Business justification: Drop-ship and third-party fulfillment scenarios where order line is fulfilled directly by supplier (not from internal inventory). Enables supplier performance tracking, direct-ship lead time monitorin',
    `test_order_id` BIGINT COMMENT 'Foreign key linking to clinical.test_order. Business justification: Order lines for genomics test services reference the specific patient test order instance for billing reconciliation and revenue recognition. Distinct from existing line→test_catalog FK (test type); t',
    `work_order_id` BIGINT COMMENT 'Foreign key linking to manufacturing.work_order. Business justification: Make-to-order genomics products (custom reagent kits, sequencing libraries, instrument builds) require direct order line to work order linkage for production scheduling, TAT tracking, and customer del',
    `actual_ship_date` DATE COMMENT 'Actual date when the line item was shipped from the warehouse or manufacturing facility. Null if not yet shipped.',
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
    `approval_id` BIGINT COMMENT 'Foreign key linking to regulatory.approval. Business justification: Pre-sales regulatory compliance check: sales teams must verify the products regulatory approval (510(k), CE-IVD) is valid for the customers jurisdiction before issuing a quotation. Genomics biotech ',
    `collaboration_agreement_id` BIGINT COMMENT 'Foreign key linking to research.collaboration_agreement. Business justification: Quotations for collaborative research services must reference the collaboration agreement to apply negotiated pricing, IP terms, and data sharing obligations. A genomics biotech commercial team would ',
    `controlled_document_id` BIGINT COMMENT 'Foreign key linking to quality.controlled_document. Business justification: In regulated genomics sales, quotations must reference the controlled product specification or IFU version in effect at quote time to ensure regulatory compliance. This supports 21 CFR Part 11 and ISO',
    `account_id` BIGINT COMMENT 'Reference to the customer account receiving this quotation. Links to master customer data for billing and delivery.',
    `contact_id` BIGINT COMMENT 'Reference to the specific customer contact person who requested or received the quotation.',
    `header_id` BIGINT COMMENT 'Reference to the sales order created from this quotation when converted. Null if quotation not yet converted.',
    `model_id` BIGINT COMMENT 'Foreign key linking to instrument.instrument_model. Business justification: Quotations for sequencing services and reagent subscriptions require instrument model specification for accurate pricing tiers, throughput capacity planning, and technical feasibility assessment. Driv',
    `performing_laboratory_id` BIGINT COMMENT 'Foreign key linking to clinical.performing_laboratory. Business justification: Genomics test service quotations are priced per performing laboratory since CLIA complexity, accreditation scope, and reference lab fees vary by lab. Sales teams generate lab-specific quotes; this FK ',
    `project_id` BIGINT COMMENT 'Foreign key linking to research.project. Business justification: Research customers request quotes for project-specific sequencing services, reagent kits, or instruments during grant proposal preparation. Linking quotations to projects enables budget planning, prop',
    `service_offering_id` BIGINT COMMENT 'Foreign key linking to product.service_offering. Business justification: Service Quotation Management: Quotations for genomics services (sequencing runs, installation, training) must reference the service offering being quoted. Enables accurate service pricing, delivery le',
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
    `approval_id` BIGINT COMMENT 'Foreign key linking to regulatory.approval. Business justification: Multi-jurisdiction quotations in genomics biotech span products with different per-line regulatory approvals (e.g., CE-IVD vs. 510(k)). Line-level approval linkage supports jurisdiction-specific prici',
    `assay_version_id` BIGINT COMMENT 'Foreign key linking to clinical.assay_version. Business justification: Quotation lines for genomics testing services must reference the specific assay version to ensure accurate pricing, regulatory designation, and coverage depth specifications. Assay version drives sequ',
    `catalog_id` BIGINT COMMENT 'Foreign key linking to reagent.reagent_catalog. Business justification: Quotations for genomics products include reagent kits, sequencing consumables, and arrays. FK enables accurate catalog pricing, regulatory designation validation, product lifecycle checks (discontinue',
    `crispr_construct_id` BIGINT COMMENT 'Foreign key linking to research.crispr_construct. Business justification: Quoting custom CRISPR constructs requires referencing the specific construct design record for accurate synthesis cost estimation, export control classification, and regulatory designation. A genomics',
    `test_catalog_id` BIGINT COMMENT 'Foreign key linking to clinical.test_catalog. Business justification: Sales teams quote specific clinical diagnostic tests from the catalog. Quotation lines must reference catalog tests for accurate pricing, turnaround time, and regulatory designation. Enables commercia',
    `manufacturing_bom_id` BIGINT COMMENT 'Foreign key linking to manufacturing.manufacturing_bom. Business justification: Custom sequencing panel quotes, library prep configurations, and instrument upgrade pricing require BOM cost rollups for accurate quotation. Sales teams validate manufacturing feasibility and calculat',
    `material_id` BIGINT COMMENT 'Foreign key linking to supply.material. Business justification: Quotation lines reference supply master data for accurate pricing, lead times, regulatory designations, and storage requirements. Ensures quoted configurations match available materials and enables au',
    `model_id` BIGINT COMMENT 'Foreign key linking to instrument.instrument_model. Business justification: Individual quote lines for reagents, flow cells, and sequencing services must reference instrument model for compatibility validation, read length configuration, and chemistry specification. Prevents ',
    `molecular_design_id` BIGINT COMMENT 'Foreign key linking to research.molecular_design. Business justification: Quoting custom molecular tools requires referencing the molecular_design record for synthesis cost estimation, IP clearance status, and regulatory classification. A genomics biotech commercial team wo',
    `line_id` BIGINT COMMENT 'Foreign key linking to order.line. Business justification: When a quotation is converted to a sales order, each quotation_line maps to a corresponding order line. Adding order_line_id on quotation_line -> order.line.line_id enables full quote-to-cash traceabi',
    `pipeline_id` BIGINT COMMENT 'Foreign key linking to bioinformatics.pipeline. Business justification: When quoting genomics analysis services, a specific pipeline (e.g., somatic variant calling, RNA-seq) is the product being priced. Linking quotation_line to pipeline enables accurate service pricing, ',
    `plant_id` BIGINT COMMENT 'Foreign key linking to supply.plant. Business justification: Quotation availability and lead time: genomics biotech quotation lines reference the supplying plant to determine stock availability, lead times, and cold-chain capability before committing to a custo',
    `pricing_id` BIGINT COMMENT 'Foreign key linking to product.pricing. Business justification: Quotation Pricing Audit: Quotation lines must reference the product.pricing record applied during quoting. Supports special pricing justification workflows, pricing approval processes, and win/loss an',
    `production_routing_id` BIGINT COMMENT 'Foreign key linking to manufacturing.production_routing. Business justification: Custom genomics product quoting: production routing defines standard lead times and labor/machine costs used to populate delivery_lead_time_days and quoted_unit_price on quotation lines for custom seq',
    `quotation_id` BIGINT COMMENT 'Reference to the parent quotation header. Links this line item to the overall commercial quotation document.',
    `sequencing_protocol_id` BIGINT COMMENT 'Foreign key linking to sequencing.sequencing_protocol. Business justification: Sales quotations for sequencing services must specify protocol requirements to calculate accurate pricing, lead times, and resource requirements. Enables sales team to quote "WGS 30x coverage using pr',
    `service_offering_id` BIGINT COMMENT 'Foreign key linking to product.service_offering. Business justification: Service Quotation Line Management: Quotation lines for genomics services reference the specific service offering being quoted. Enables service-level pricing accuracy, prerequisite service validation, ',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: Quotation lines reference specific SKUs for real-time pricing, availability checks, lead time calculation, and order conversion. Essential for quote-to-order workflow and sales operations. Replaces de',
    `software_release_id` BIGINT COMMENT 'Foreign key linking to product.software_release. Business justification: Software Version-Specific Quotation: In genomics biotech, software license quotation lines reference the specific release version being quoted. Supports version-specific pricing, license term accuracy',
    `validation_study_id` BIGINT COMMENT 'Foreign key linking to quality.validation_study. Business justification: Quotation lines for IVD assays or validated sequencing services in genomics must reference the validation study substantiating performance claims. Sales teams and regulatory affairs use this link to e',
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
    `deviation_id` BIGINT COMMENT 'Foreign key linking to quality.deviation. Business justification: Delivery-level temperature excursions and cold-chain failures are primary deviation triggers in genomics/biotech (reagents, sequencing kits). The delivery product has temperature_excursion_flag but no',
    `finished_goods_release_id` BIGINT COMMENT 'Foreign key linking to manufacturing.finished_goods_release. Business justification: GMP distribution authorization: delivery of IVD reagents and clinical genomics products is only permitted after finished goods release approval. Direct FK enforces this regulatory control, enables aut',
    `fulfillment_instruction_id` BIGINT COMMENT 'Foreign key linking to order.fulfillment_instruction. Business justification: A fulfillment_instruction is the operational directive that triggers the creation of a delivery document. Linking delivery.fulfillment_instruction_id -> order.fulfillment_instruction.fulfillment_instr',
    `header_id` BIGINT COMMENT 'Reference to the originating sales order that this delivery fulfills.',
    `nonconformance_id` BIGINT COMMENT 'Foreign key linking to quality.nonconformance. Business justification: Damaged goods, wrong product delivered, or quantity discrepancies at delivery generate nonconformance records in GMP genomics operations. Quality teams need to link the delivery document to the NCR fo',
    `plant_id` BIGINT COMMENT 'Foreign key linking to supply.plant. Business justification: Delivery origin plant: outbound deliveries in genomics biotech originate from a specific plant/distribution center. shipping_point is a denormalized plant reference; a proper FK enables plant-level de',
    `address_id` BIGINT COMMENT 'Foreign key linking to customer.address. Business justification: Cold-chain and hazmat delivery compliance: genomics biotech deliveries of reagents and instruments must be validated against the canonical customer site address (biosafety level, cold-chain eligibilit',
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
    `shipment_method` STRING COMMENT 'Transportation mode used for the delivery (ground, air, ocean, cold-chain ground, cold-chain air, courier).. Valid values are `ground|air|ocean|cold_chain_ground|cold_chain_air|courier`',
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
    `batch_record_id` BIGINT COMMENT 'Foreign key linking to manufacturing.batch_record. Business justification: GMP goods issue control: delivery of IVD reagents and clinical genomics products requires confirming the batch record is approved before shipment. Direct FK enables automated release verification at g',
    `catalog_item_id` BIGINT COMMENT 'Reference to the master product being shipped on this delivery line. Links to the product catalog for instruments, reagents, consumables, or sequencing kits.',
    `coa_id` BIGINT COMMENT 'Foreign key linking to reagent.coa. Business justification: Certificates of Analysis must accompany reagent shipments in genomics biotech. FK enables automated CoA document retrieval for customer portals, regulatory audit trails, and quality documentation requ',
    `delivery_id` BIGINT COMMENT 'Reference to the parent outbound delivery document header. Links this line item to its containing shipment.',
    `device_identifier_id` BIGINT COMMENT 'Foreign key linking to regulatory.device_identifier. Business justification: FDA UDI rule and EU MDR/IVDR require UDI-DI traceability on delivery documentation for IVD devices and instruments. Genomics biotech delivery lines for regulated devices must reference the device_iden',
    `header_id` BIGINT COMMENT 'Reference to the originating sales order that triggered this delivery line. Enables traceability from shipment back to customer order.',
    `inventory_transaction_id` BIGINT COMMENT 'Foreign key linking to reagent.inventory_transaction. Business justification: GMP lot traceability requires linking each delivery line to the inventory transaction that posted the goods issue. Enables audit trail from customer shipment back to exact stock movement — mandatory f',
    `labeling_id` BIGINT COMMENT 'Foreign key linking to regulatory.labeling. Business justification: Post-market surveillance and recall management require knowing which labeling version was physically delivered to each customer. EU MDR/IVDR and FDA require labeling version traceability at the delive',
    `lot_id` BIGINT COMMENT 'Foreign key linking to reagent.lot. Business justification: Delivery documentation must capture exact lot shipped for cold chain validation, customer acceptance, and regulatory compliance. FK provides manufacturing date, expiry, QC status, and CoA reference re',
    `material_id` BIGINT COMMENT 'Foreign key linking to supply.material. Business justification: Delivery lines ship specific materials from supply master. Link enables batch traceability, expiry date validation, hazmat classification enforcement, and COA reference number attachment for GMP-compl',
    `nonconformance_id` BIGINT COMMENT 'Foreign key linking to quality.nonconformance. Business justification: Individual delivery line items (specific reagent lots, sequencing kits) can fail incoming inspection and generate lot-specific NCRs. GMP incoming goods inspection in genomics/biotech requires traceabi',
    `production_batch_id` BIGINT COMMENT 'Foreign key linking to manufacturing.production_batch. Business justification: Delivery documentation for genomics products requires batch/lot traceability for regulatory compliance, CoA attachment, and field complaint investigation. Delivery lines must reference production batc',
    `qc_result_id` BIGINT COMMENT 'Foreign key linking to quality.qc_result. Business justification: Incoming goods QC inspection of delivered reagent lots and materials is a mandatory GMP/GxP process in genomics/biotech. Linking each delivery line to its incoming QC result enables release-for-use de',
    `line_id` BIGINT COMMENT 'Reference to the specific sales order line item being fulfilled by this delivery line. Establishes one-to-one or many-to-one fulfillment relationship.',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: Delivery lines must reference SKUs for lot/batch traceability, Certificate of Analysis generation, regulatory compliance documentation, and inventory depletion. Critical for GMP/GDP compliance and shi',
    `storage_location_id` BIGINT COMMENT 'Foreign key linking to reagent.storage_location. Business justification: GMP traceability requires recording which qualified storage location a reagent lot was picked from for each delivery. The existing plain-text storage_location_code is a denormalization of reagent.stor',
    `test_order_id` BIGINT COMMENT 'Foreign key linking to clinical.test_order. Business justification: Delivery lines for specimen collection kits must reference the test order they serve for chain-of-custody documentation and billing traceability. Genomics labs require direct delivery-line-to-test-ord',
    `warehouse_location_id` BIGINT COMMENT 'Foreign key linking to supply.warehouse_location. Business justification: Pick-location traceability: each delivery line in genomics biotech is picked from a specific warehouse bin/location for FEFO/FIFO compliance and GMP traceability. storage_location_code is currently de',
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
    `un_number` STRING COMMENT 'Four-digit UN identification number for hazardous materials. Required for international shipping compliance and carrier acceptance. Examples: UN1170 (ethanol), UN3373 (biological substance).. Valid values are `^UN[0-9]{4}$`',
    `unit_of_measure` STRING COMMENT 'The unit of measure for the delivery quantity. Common values include EA (each) for instruments, KIT for reagent kits, VIAL for liquid reagents, PLATE for array plates. [ENUM-REF-CANDIDATE: EA|KIT|BOX|VIAL|PLATE|SET|UNIT|L|ML|G|KG — 11 candidates stripped; promote to reference product]',
    `volume_cubic_meters` DECIMAL(18,2) COMMENT 'Total volume occupied by this delivery line item in cubic meters. Used for warehouse space planning and freight optimization.',
    CONSTRAINT pk_delivery_line PRIMARY KEY(`delivery_line_id`)
) COMMENT 'Individual line item within an outbound delivery document specifying the exact product, lot, batch, and quantity being shipped. Captures delivery line number, product SKU, product description, delivery quantity, unit of measure, lot number (LOT), batch number, serial number (for instruments), storage location, pick status, pack status, goods issue quantity, COA reference number, expiry date for reagents/consumables, cold-chain handling instruction, and hazardous material classification.';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`order`.`shipment` (
    `shipment_id` BIGINT COMMENT 'Unique identifier for the shipment record. Primary key.',
    `approval_id` BIGINT COMMENT 'Foreign key linking to regulatory.approval. Business justification: Export compliance for genomics instruments and IVD reagents requires each shipment to reference the regulatory approval authorizing sale/export in the destination country. Supports export declaration ',
    `delivery_id` BIGINT COMMENT 'Reference to the delivery document that this shipment executes. Multiple deliveries may be consolidated into one shipment.',
    `address_id` BIGINT COMMENT 'Foreign key linking to customer.address. Business justification: Temperature-sensitive shipment routing compliance: genomics biotech shipments of sequencing reagents and kits require cold-chain validation against the customer site address record (cold_chain_eligibl',
    `deviation_id` BIGINT COMMENT 'Foreign key linking to quality.quality_deviation. Business justification: Temperature excursions or shipping violations during cold chain transport are quality deviations requiring investigation. Real-time monitoring systems flag deviations, QA investigates impact on produc',
    `fulfillment_instruction_id` BIGINT COMMENT 'Foreign key linking to order.fulfillment_instruction. Business justification: A shipment is the physical execution of a fulfillment instruction. Linking shipment.fulfillment_instruction_id -> order.fulfillment_instruction.fulfillment_instruction_id enables end-to-end operationa',
    `header_id` BIGINT COMMENT 'Reference to the parent sales order that this shipment fulfills. Links to the order management system.',
    `nonconformance_id` BIGINT COMMENT 'Foreign key linking to quality.nonconformance. Business justification: Shipment-level nonconformances (carrier damage, confirmed temperature excursion, packaging failure) are distinct from deviations and generate NCRs in regulated genomics logistics. Shipment already has',
    `plant_id` BIGINT COMMENT 'Foreign key linking to supply.plant. Business justification: Shipment origin plant: genomics biotech shipments originate from a specific plant for export control classification, carrier SLA management, and regulatory compliance. origin_facility_code is a denorm',
    `test_order_id` BIGINT COMMENT 'Foreign key linking to clinical.test_order. Business justification: Specimen collection kit shipments are tracked per clinical test order for TAT compliance reporting. Genomics labs must demonstrate kit-to-result turnaround; direct shipment→test_order linkage enables ',
    `actual_delivery_date` DATE COMMENT 'Date the shipment was physically received and signed for by the customer or designated recipient. Null until delivery is confirmed.',
    `carrier_name` STRING COMMENT 'Name of the logistics carrier responsible for transporting the shipment (e.g., FedEx, UPS, DHL, specialized cold-chain provider).',
    `carrier_sla_breach_flag` BOOLEAN COMMENT 'Indicates whether the carrier failed to meet the committed delivery Service Level Agreement (SLA). True if actual delivery date exceeds estimated delivery date by the SLA tolerance threshold.',
    `carrier_tracking_number` STRING COMMENT 'Unique tracking identifier assigned by the carrier for real-time shipment visibility and proof of delivery.',
    `cold_chain_required_flag` BOOLEAN COMMENT 'Indicates whether this shipment contains temperature-sensitive reagents, consumables, or biological samples requiring continuous cold-chain monitoring. True if cold-chain logistics are mandatory.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the shipment record was first created in the system. Used for audit trail and data lineage.',
    `customer_reference_number` STRING COMMENT 'Customer-provided purchase order number, project code, or internal reference for shipment tracking and invoice reconciliation.',
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
    `asset_id` BIGINT COMMENT 'Foreign key linking to instrument.asset. Business justification: When a customer returns a genomics instrument (e.g., defective sequencer), the RMA must reference the specific serialized asset for warranty validation, asset disposition, and field service coordinati',
    `batch_id` BIGINT COMMENT 'Foreign key linking to supply.batch. Business justification: GMP deviation investigations require batch-level traceability for returned goods. Links return to batch QC status, COA, manufacturing date, and supplier batch number for root cause analysis and suppli',
    `batch_record_id` BIGINT COMMENT 'Foreign key linking to manufacturing.batch_record. Business justification: GMP root cause investigation: when a regulated genomics product (IVD reagent, sequencing kit) is returned with gmp_deviation_flag or quality failure, QA must review the electronic batch record directl',
    `capa_id` BIGINT COMMENT 'Foreign key linking to quality.capa. Business justification: Return authorizations for systemic product failures (e.g., failed sequencing reagent lots, instrument defects) trigger CAPAs in genomics/biotech quality systems. return_authorization.capa_number is a ',
    `complaint_id` BIGINT COMMENT 'Foreign key linking to quality.complaint. Business justification: Returns are often initiated by quality complaints. RMA systems link to complaint records for disposition decisions (credit, replacement, investigation), CAPA initiation, and customer satisfaction trac',
    `account_id` BIGINT COMMENT 'Reference to the customer account requesting the return.',
    `deviation_id` BIGINT COMMENT 'Foreign key linking to quality.quality_deviation. Business justification: Product returns may trigger quality deviations when defects are confirmed during QC inspection. QA reviews returned goods, documents deviations (GxP classification, severity), and initiates investigat',
    `field_safety_action_id` BIGINT COMMENT 'Foreign key linking to regulatory.field_safety_action. Business justification: Recall and FSCA management: return authorizations in genomics biotech are frequently initiated by field safety corrective actions (FSCAs) for IVD kits or sequencing instruments. Direct FK enables reca',
    `installed_instrument_id` BIGINT COMMENT 'Foreign key linking to customer.installed_instrument. Business justification: Instrument return and decommission process: in genomics biotech, RMAs for sequencers and array scanners are initiated against a specific installed instrument at a customer site. Linking return_authori',
    `inventory_transaction_id` BIGINT COMMENT 'Foreign key linking to reagent.inventory_transaction. Business justification: Returned reagent lots generate a receiving inventory transaction (into quarantine or stock). Linking return_authorization to that transaction supports GMP disposition tracking, financial reconciliatio',
    `lot_id` BIGINT COMMENT 'Foreign key linking to reagent.lot. Business justification: Product returns require lot-level traceability for quality investigations, stability studies, and CAPA. FK enables root cause analysis linking returned material to manufacturing batch, QC results, sto',
    `material_id` BIGINT COMMENT 'Foreign key linking to supply.material. Business justification: Returns reference specific materials for disposition decisions (restock, scrap, quarantine), quality investigations, and CAPA initiation. Enables material-level return rate analysis and supplier quali',
    `nonconformance_id` BIGINT COMMENT 'Foreign key linking to quality.nonconformance. Business justification: Returned products failing inspection generate nonconformance records (NCRs). Warehouse QC inspection creates NCRs for supplier notification, disposition decisions (scrap, rework, use-as-is), and inter',
    `coa_id` BIGINT COMMENT 'Foreign key linking to reagent.coa. Business justification: QC re-inspection of returned reagents requires comparing current condition against the original release CoA. Linking return_authorization to reagent.coa via original_coa_id supports GMP deviation inve',
    `performing_laboratory_id` BIGINT COMMENT 'Foreign key linking to clinical.performing_laboratory. Business justification: Return authorizations for defective reagents or kits must reference the performing laboratory initiating the return for QC disposition, CAPA tracking, and credit processing. Lab-specific return histor',
    `header_id` BIGINT COMMENT 'Reference to the original sales order from which this return originated.',
    `production_batch_id` BIGINT COMMENT 'Foreign key linking to manufacturing.production_batch. Business justification: Product return investigations in regulated genomics require root cause analysis tied to manufacturing batch records. Quality teams analyze returns by batch to identify process deviations, environmenta',
    `delivery_line_id` BIGINT COMMENT 'Foreign key linking to order.delivery_line. Business justification: A return authorization references the specific delivery line that was physically shipped to the customer. Linking return_authorization.return_delivery_line_id -> order.delivery_line.delivery_line_id e',
    `line_id` BIGINT COMMENT 'Foreign key linking to order.line. Business justification: A return authorization is typically initiated for a specific order line item (specific SKU, lot, serial number, quantity). While return_authorization has primary_return_header_id -> order.header, link',
    `storage_location_id` BIGINT COMMENT 'Foreign key linking to reagent.storage_location. Business justification: Returned reagents must be directed to a designated GMP-qualified quarantine or return storage location. Linking return_authorization to storage_location enables warehouse staff to route returned lots ',
    `sequencing_run_id` BIGINT COMMENT 'Foreign key linking to sequencing.sequencing_run. Business justification: When customers return reagents/kits due to a failed sequencing run, the RMA must reference the specific run that failed. Genomics service teams require this link for root-cause analysis, credit author',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: RMA records reference specific SKUs for credit calculation, quality investigation, CAPA initiation, and regulatory deviation reporting. Essential for post-market surveillance and complaint handling in',
    `specification_id` BIGINT COMMENT 'Foreign key linking to product.specification. Business justification: Return QC Inspection Against Specification: In genomics biotech, returned reagents and consumables are inspected against product specifications (storage temperature limits, shelf life, Q30 thresholds)',
    `test_order_id` BIGINT COMMENT 'Foreign key linking to clinical.test_order. Business justification: When clinical test kits, reagents, or sample collection supplies are returned, linking to the originating test order enables root cause analysis, quality event tracking, and CAPA. Critical for GxP com',
    `warehouse_location_id` BIGINT COMMENT 'Reference to the warehouse or facility where the returned goods were received.',
    `capa_required_flag` BOOLEAN COMMENT 'Boolean indicator whether this return requires a formal CAPA investigation and corrective action plan.',
    `carrier_name` STRING COMMENT 'Name of the shipping carrier used for the return shipment.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this return authorization record was first created in the system.',
    `credit_memo_number` STRING COMMENT 'Reference to the financial credit memo document issued to the customer upon return approval.. Valid values are `^CM-[A-Z0-9]{8,12}$`',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the return value amount.. Valid values are `^[A-Z]{3}$`',
    `disposition_code` STRING COMMENT 'Final disposition decision for the returned goods based on inspection results (restock, quarantine, destroy, rework, scrap, return-to-vendor).. Valid values are `restock|quarantine|destroy|rework|scrap|return-to-vendor`',
    `expiration_date` DATE COMMENT 'Expiration date of the returned product, particularly relevant for reagents and consumables with limited shelf life.',
    `gmp_deviation_flag` BOOLEAN COMMENT 'Boolean indicator whether this return triggered a GMP deviation investigation due to quality or compliance concerns.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this return authorization record was last updated.',
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
    `delivery_id` BIGINT COMMENT 'Foreign key linking to order.delivery. Business justification: The status_event table is an immutable event log capturing every status transition in the order lifecycle. Deliveries have their own status lifecycle (created, goods issued, in transit, delivered) tha',
    `deviation_id` BIGINT COMMENT 'Foreign key linking to quality.deviation. Business justification: Order status events flagging SLA breaches, temperature excursions, or GxP process failures in genomics operations directly trigger quality deviations. status_event has sla_breach_flag and temperature-',
    `fulfillment_instruction_id` BIGINT COMMENT 'Foreign key linking to order.fulfillment_instruction. Business justification: Fulfillment instructions have a lifecycle with distinct execution states (created, scheduled, in-progress, completed, failed) that generate status events. Adding fulfillment_instruction_id on status_e',
    `header_id` BIGINT COMMENT 'Identifier of the sales order that experienced this status transition. Links this event to the parent order entity.',
    `return_authorization_id` BIGINT COMMENT 'Foreign key linking to order.return_authorization. Business justification: Return authorizations have a multi-step status lifecycle (requested, authorized, received, QC inspection, disposition, credited) that generates status events. Adding return_authorization_id on status_',
    `sequencing_run_id` BIGINT COMMENT 'Foreign key linking to sequencing.sequencing_run. Business justification: Order status transitions for sequencing-as-a-service (e.g., run completed → order fulfilled) are triggered by sequencing run completion. Operations teams need direct run-to-status-event traceability f',
    `shipment_id` BIGINT COMMENT 'Foreign key linking to order.shipment. Business justification: Shipments have a rich status lifecycle (dispatched, in transit, customs hold, delivered, exception) that generates status events. Adding shipment_id on status_event -> order.shipment.shipment_id allow',
    `test_order_id` BIGINT COMMENT 'Foreign key linking to clinical.test_order. Business justification: Order status events (kit shipped, specimen received, result reported) are tracked per clinical test order for TAT compliance dashboards and patient care coordination. CLIA labs require direct status-e',
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
    `approval_id` BIGINT COMMENT 'Foreign key linking to regulatory.approval. Business justification: Fulfillment of regulated genomics products (instrument installation, IVD kit delivery) must execute under the conditions of the governing regulatory approval. GxP-compliant fulfillment execution requi',
    `asset_id` BIGINT COMMENT 'Foreign key linking to instrument.instrument_asset. Business justification: Installation fulfillment instructions must reference the specific serialized instrument asset being deployed for installation qualification execution, site preparation validation, and asset tracking. ',
    `controlled_document_id` BIGINT COMMENT 'Foreign key linking to quality.controlled_document. Business justification: Fulfillment instructions for GxP-regulated activities (instrument installation, special handling of biohazardous genomics materials) must reference the governing controlled SOP or work instruction. IS',
    `flow_cell_id` BIGINT COMMENT 'Foreign key linking to sequencing.flow_cell. Business justification: Sequencing service fulfillment consumes a specific flow cell. Linking fulfillment_instruction to flow_cell enables consumable traceability from customer order to lab asset, supporting lot-level recall',
    `header_id` BIGINT COMMENT 'Reference to the confirmed sales order that this fulfillment instruction executes. Links to the parent order in SAP SD.',
    `installation_qualification_id` BIGINT COMMENT 'Foreign key linking to instrument.installation_qualification. Business justification: For regulated genomics/IVD instrument installations, the fulfillment instruction must reference the IQ record confirming GxP-compliant installation was completed. This links commercial order fulfillme',
    `library_prep_run_id` BIGINT COMMENT 'Foreign key linking to sequencing.library_prep_run. Business justification: Fulfillment of a sequencing service order requires executing a library prep run as a distinct billable step. Lab operations teams need this link to track which library prep run was performed to fulfil',
    `lot_id` BIGINT COMMENT 'Foreign key linking to reagent.lot. Business justification: Fulfillment instructions in GMP reagent distribution frequently specify a particular lot (customer-reserved, expiry-constrained, or GMP-released lot). Linking fulfillment_instruction to reagent.lot en',
    `line_id` BIGINT COMMENT 'Foreign key linking to order.line. Business justification: A fulfillment instruction is typically generated per order line (e.g., ship a specific SKU/quantity from a specific warehouse). While fulfillment_instruction already has header_id -> order.header, lin',
    `performing_laboratory_id` BIGINT COMMENT 'Foreign key linking to clinical.performing_laboratory. Business justification: Fulfillment instructions for reagent and kit deliveries to CLIA-certified labs require direct reference to the performing laboratory for compliance documentation, cold-chain handling requirements, and',
    `storage_location_id` BIGINT COMMENT 'Foreign key linking to reagent.storage_location. Business justification: Fulfillment instructions for cold-chain reagents must specify the exact GMP-qualified storage location from which goods are picked. Linking to reagent.storage_location enables pick-list generation tie',
    `plant_id` BIGINT COMMENT 'Foreign key linking to supply.plant. Business justification: Fulfillment plant assignment: in genomics biotech, fulfillment instructions (instrument installation, reagent kit assembly, service dispatch) are executed at or dispatched from a specific plant. FK en',
    `sequencing_run_id` BIGINT COMMENT 'Foreign key linking to sequencing.sequencing_run. Business justification: Fulfillment instructions for sequencing service orders must specify which sequencing run executes the order. Critical for operations tracking, linking commercial orders to lab execution, TAT monitorin',
    `service_offering_id` BIGINT COMMENT 'Foreign key linking to product.service_offering. Business justification: Service Delivery Management: Fulfillment instructions for service orders (installation, sequencing runs, training) must reference the service offering to drive correct execution procedures, required c',
    `address_id` BIGINT COMMENT 'Foreign key linking to customer.address. Business justification: Instrument installation and reagent fulfillment routing: fulfillment instructions for instrument installations must reference the validated lab site (loading dock availability, biosafety level, receiv',
    `software_release_id` BIGINT COMMENT 'Foreign key linking to product.software_release. Business justification: Software License Activation: Fulfillment instructions for software orders reference the specific software release to activate. The fulfillment_instruction already has license_activation_key — linking ',
    `test_order_id` BIGINT COMMENT 'Foreign key linking to clinical.test_order. Business justification: Specimen collection kit fulfillment instructions are generated per clinical test order. Lab operations teams track fulfillment status directly against test orders for TAT compliance and patient care c',
    `warehouse_location_id` BIGINT COMMENT 'Foreign key linking to supply.warehouse_location. Business justification: Picking instructions specify exact bin locations for temperature-controlled reagents, hazmat materials, and serialized instruments. Enables FEFO enforcement, cold-chain zone validation, and GMP-compli',
    `work_order_id` BIGINT COMMENT 'Foreign key linking to manufacturing.work_order. Business justification: Make-to-order genomics workflows: custom reagent kits, bespoke sequencing services, and instrument installation fulfillment instructions are executed against specific manufacturing work orders. Direct',
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
    `shipping_carrier_code` STRING COMMENT 'Standard carrier identifier for logistics provider (e.g., FEDEX, UPS, DHL, WORLDCOURIER). Applicable for ship and cold_chain_ship instruction types. Null for non-shipping fulfillment.. Valid values are `^[A-Z0-9]{2,10}$`',
    `shipping_service_level` STRING COMMENT 'Carrier service tier selected for shipment. Overnight = next-day delivery; Two_Day = 2-business-day; Ground = standard surface; International_Express = expedited cross-border; International_Standard = economy cross-border; White_Glove = premium instrument delivery with setup.. Valid values are `overnight|two_day|ground|international_express|international_standard|white_glove`',
    `special_handling_code` STRING COMMENT 'Logistics and handling requirements for this fulfillment. Dry_Ice = dry ice packaging for frozen reagents; Controlled_Rate_Freezer = CRF shipping for enzyme stability; Ambient = room temperature; Refrigerated = 2-8°C cold chain; Hazmat = hazardous materials compliance; Fragile = delicate instruments; High_Value = security escort; Biohazard = biosafety protocols; None = standard handling. [ENUM-REF-CANDIDATE: dry_ice|controlled_rate_freezer|ambient|refrigerated|hazmat|fragile|high_value|biohazard|none — 9 candidates stripped; promote to reference product]',
    `tat_deadline_timestamp` TIMESTAMP COMMENT 'Service Level Agreement (SLA) deadline by which this fulfillment instruction must be completed. Derived from order TAT commitment and used for SLA compliance monitoring.',
    `temperature_monitoring_required_flag` BOOLEAN COMMENT 'Indicates whether cold-chain temperature monitoring is required during transit. True for reagents, enzymes, and temperature-sensitive consumables requiring Good Distribution Practice (GDP) compliance. Triggers data logger inclusion in shipment.',
    `tracking_number` STRING COMMENT 'Carrier-provided tracking identifier for shipment visibility. Populated after shipment dispatch. Used for customer self-service tracking and delivery confirmation.. Valid values are `^[A-Z0-9]{10,35}$`',
    CONSTRAINT pk_fulfillment_instruction PRIMARY KEY(`fulfillment_instruction_id`)
) COMMENT 'Operational directive translating a confirmed sales order into specific warehouse, logistics, or field service execution tasks. Covers standard pick-pack-ship, cold-chain logistics coordination (dry ice, controlled-rate shipping for enzymes/reagents), instrument installation scheduling with field service engineers, sequencing service sample-kit dispatch, and software license activation. Captures instruction type (ship, install, service-dispatch, activate), execution status, assigned facility or field team, priority level, special handling codes, scheduled execution date, TAT deadline, and completion confirmation. Serves as the orchestration layer between commercial order management and physical/digital fulfillment.';

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`order`.`credit_memo` (
    `credit_memo_id` BIGINT COMMENT 'Unique identifier for the credit memo record. Primary key.',
    `complaint_id` BIGINT COMMENT 'Foreign key linking to quality.complaint. Business justification: Credits issued for quality-related complaints (defective products, failed sequencing runs, service failures). Finance links credit memos to complaint records for revenue impact tracking, customer sati',
    `account_id` BIGINT COMMENT 'Reference to the customer account receiving the credit. Used for accounts receivable reconciliation and customer balance updates.',
    `deviation_id` BIGINT COMMENT 'Foreign key linking to quality.deviation. Business justification: Credit memos issued due to delivery deviations (temperature excursions, cold-chain failures affecting genomics reagents) must reference the deviation record. Finance and quality teams use this link fo',
    `field_safety_action_id` BIGINT COMMENT 'Foreign key linking to regulatory.field_safety_action. Business justification: Field safety actions (recalls, FSCAs) in genomics biotech trigger customer compensation via credit memos. Regulatory reporting on FSCA financial impact requires tracing credit memos to the initiating ',
    `header_id` BIGINT COMMENT 'Reference to the original sales order against which this credit memo was issued. Links to the order that generated the original revenue.',
    `nonconformance_id` BIGINT COMMENT 'Foreign key linking to quality.nonconformance. Business justification: Credit memos issued for product nonconformances (failed reagent lots, out-of-spec sequencing kits) must reference the NCR for financial reconciliation and quality cost tracking. Genomics/biotech quali',
    `pricing_id` BIGINT COMMENT 'Foreign key linking to product.pricing. Business justification: Revenue Reversal and Financial Audit: Credit memos must reference the original product.pricing record for accurate revenue reversal, tax recalculation, and financial audit compliance. In genomics biot',
    `return_authorization_id` BIGINT COMMENT 'Reference to the return order that triggered this credit memo, if applicable. Null for non-return credit scenarios such as pricing corrections or goodwill credits.',
    `sequencing_run_id` BIGINT COMMENT 'Foreign key linking to sequencing.sequencing_run. Business justification: Credit memos issued for failed sequencing service runs must reference the specific run triggering the credit. Finance and service teams in genomics labs require direct run-to-credit traceability for b',
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

CREATE OR REPLACE TABLE `genomics_biotech_ecm`.`order`.`customer_po` (
    `customer_po_id` BIGINT COMMENT 'Unique identifier for the customer purchase order record. Primary key.',
    `account_id` BIGINT COMMENT 'Reference to the customer account that issued this purchase order.',
    `header_id` BIGINT COMMENT 'Reference to the internal sales order that this customer PO authorizes. Links customer procurement document to SAP SD sales order.',
    `quotation_id` BIGINT COMMENT 'Foreign key linking to order.quotation. Business justification: A customer purchase order is typically issued in response to a formal quotation. Linking customer_po.quotation_id -> order.quotation.quotation_id enables quote-to-PO traceability — verifying that the ',
    `project_id` BIGINT COMMENT 'Foreign key linking to research.project. Business justification: In genomics biotech, customer POs are issued against specific R&D projects for budget authorization before order creation. Project managers track PO commitments against project budgets for spend forec',
    `address_id` BIGINT COMMENT 'Foreign key linking to customer.address. Business justification: PO ship-to site validation: in genomics biotech, customer POs specify a delivery site that must be a validated lab address (cold-chain eligibility, biosafety level, hazmat authorization). Direct FK to',
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
    `shipping_terms` STRING COMMENT 'The shipping and delivery terms specified on the customer purchase order, such as FOB, CIF, DDP, or other Incoterms. Defines responsibility for shipping costs and risk transfer.',
    `special_terms_notes` STRING COMMENT 'Free-text field capturing any special terms, conditions, or instructions noted on the customer purchase order that require attention during order fulfillment. May include delivery instructions, quality requirements, or contractual clauses.',
    CONSTRAINT pk_customer_po PRIMARY KEY(`customer_po_id`)
) COMMENT 'Customer purchase order record capturing the formal procurement document issued by the customer authorizing Genomics Biotech to fulfill a sales order. Serves as the contractual reference linking customer procurement systems to SAP SD. Captures customer PO number, customer account ID, PO issue date, PO value, currency, PO type (standard, blanket, framework, government), linked sales order ID, PO validity start date, PO validity end date, remaining PO balance, PO status (open, partially-consumed, fully-consumed, cancelled), customer ERP system reference, and special terms noted on PO.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `genomics_biotech_ecm`.`order`.`line` ADD CONSTRAINT `fk_order_line_header_id` FOREIGN KEY (`header_id`) REFERENCES `genomics_biotech_ecm`.`order`.`header`(`header_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`quotation` ADD CONSTRAINT `fk_order_quotation_header_id` FOREIGN KEY (`header_id`) REFERENCES `genomics_biotech_ecm`.`order`.`header`(`header_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`quotation_line` ADD CONSTRAINT `fk_order_quotation_line_line_id` FOREIGN KEY (`line_id`) REFERENCES `genomics_biotech_ecm`.`order`.`line`(`line_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`quotation_line` ADD CONSTRAINT `fk_order_quotation_line_quotation_id` FOREIGN KEY (`quotation_id`) REFERENCES `genomics_biotech_ecm`.`order`.`quotation`(`quotation_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`delivery` ADD CONSTRAINT `fk_order_delivery_fulfillment_instruction_id` FOREIGN KEY (`fulfillment_instruction_id`) REFERENCES `genomics_biotech_ecm`.`order`.`fulfillment_instruction`(`fulfillment_instruction_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`delivery` ADD CONSTRAINT `fk_order_delivery_header_id` FOREIGN KEY (`header_id`) REFERENCES `genomics_biotech_ecm`.`order`.`header`(`header_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`delivery_line` ADD CONSTRAINT `fk_order_delivery_line_delivery_id` FOREIGN KEY (`delivery_id`) REFERENCES `genomics_biotech_ecm`.`order`.`delivery`(`delivery_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`delivery_line` ADD CONSTRAINT `fk_order_delivery_line_header_id` FOREIGN KEY (`header_id`) REFERENCES `genomics_biotech_ecm`.`order`.`header`(`header_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`delivery_line` ADD CONSTRAINT `fk_order_delivery_line_line_id` FOREIGN KEY (`line_id`) REFERENCES `genomics_biotech_ecm`.`order`.`line`(`line_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`shipment` ADD CONSTRAINT `fk_order_shipment_delivery_id` FOREIGN KEY (`delivery_id`) REFERENCES `genomics_biotech_ecm`.`order`.`delivery`(`delivery_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`shipment` ADD CONSTRAINT `fk_order_shipment_fulfillment_instruction_id` FOREIGN KEY (`fulfillment_instruction_id`) REFERENCES `genomics_biotech_ecm`.`order`.`fulfillment_instruction`(`fulfillment_instruction_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`shipment` ADD CONSTRAINT `fk_order_shipment_header_id` FOREIGN KEY (`header_id`) REFERENCES `genomics_biotech_ecm`.`order`.`header`(`header_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`return_authorization` ADD CONSTRAINT `fk_order_return_authorization_header_id` FOREIGN KEY (`header_id`) REFERENCES `genomics_biotech_ecm`.`order`.`header`(`header_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`return_authorization` ADD CONSTRAINT `fk_order_return_authorization_delivery_line_id` FOREIGN KEY (`delivery_line_id`) REFERENCES `genomics_biotech_ecm`.`order`.`delivery_line`(`delivery_line_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`return_authorization` ADD CONSTRAINT `fk_order_return_authorization_line_id` FOREIGN KEY (`line_id`) REFERENCES `genomics_biotech_ecm`.`order`.`line`(`line_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`status_event` ADD CONSTRAINT `fk_order_status_event_delivery_id` FOREIGN KEY (`delivery_id`) REFERENCES `genomics_biotech_ecm`.`order`.`delivery`(`delivery_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`status_event` ADD CONSTRAINT `fk_order_status_event_fulfillment_instruction_id` FOREIGN KEY (`fulfillment_instruction_id`) REFERENCES `genomics_biotech_ecm`.`order`.`fulfillment_instruction`(`fulfillment_instruction_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`status_event` ADD CONSTRAINT `fk_order_status_event_header_id` FOREIGN KEY (`header_id`) REFERENCES `genomics_biotech_ecm`.`order`.`header`(`header_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`status_event` ADD CONSTRAINT `fk_order_status_event_return_authorization_id` FOREIGN KEY (`return_authorization_id`) REFERENCES `genomics_biotech_ecm`.`order`.`return_authorization`(`return_authorization_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`status_event` ADD CONSTRAINT `fk_order_status_event_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `genomics_biotech_ecm`.`order`.`shipment`(`shipment_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`fulfillment_instruction` ADD CONSTRAINT `fk_order_fulfillment_instruction_header_id` FOREIGN KEY (`header_id`) REFERENCES `genomics_biotech_ecm`.`order`.`header`(`header_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`fulfillment_instruction` ADD CONSTRAINT `fk_order_fulfillment_instruction_line_id` FOREIGN KEY (`line_id`) REFERENCES `genomics_biotech_ecm`.`order`.`line`(`line_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`credit_memo` ADD CONSTRAINT `fk_order_credit_memo_header_id` FOREIGN KEY (`header_id`) REFERENCES `genomics_biotech_ecm`.`order`.`header`(`header_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`credit_memo` ADD CONSTRAINT `fk_order_credit_memo_return_authorization_id` FOREIGN KEY (`return_authorization_id`) REFERENCES `genomics_biotech_ecm`.`order`.`return_authorization`(`return_authorization_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`customer_po` ADD CONSTRAINT `fk_order_customer_po_header_id` FOREIGN KEY (`header_id`) REFERENCES `genomics_biotech_ecm`.`order`.`header`(`header_id`);
ALTER TABLE `genomics_biotech_ecm`.`order`.`customer_po` ADD CONSTRAINT `fk_order_customer_po_quotation_id` FOREIGN KEY (`quotation_id`) REFERENCES `genomics_biotech_ecm`.`order`.`quotation`(`quotation_id`);

-- ========= TAGS =========
ALTER SCHEMA `genomics_biotech_ecm`.`order` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `genomics_biotech_ecm`.`order` SET TAGS ('dbx_domain' = 'order');
ALTER TABLE `genomics_biotech_ecm`.`order`.`header` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `genomics_biotech_ecm`.`order`.`header` SET TAGS ('dbx_subdomain' = 'sales_quotation');
ALTER TABLE `genomics_biotech_ecm`.`order`.`header` ALTER COLUMN `header_id` SET TAGS ('dbx_business_glossary_term' = 'Header Identifier');
ALTER TABLE `genomics_biotech_ecm`.`order`.`header` ALTER COLUMN `approval_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`header` ALTER COLUMN `collaboration_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Collaboration Agreement Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`header` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Ship-To Party ID');
ALTER TABLE `genomics_biotech_ecm`.`order`.`header` ALTER COLUMN `header_bill_to_party_account_id` SET TAGS ('dbx_business_glossary_term' = 'Bill-To Party ID');
ALTER TABLE `genomics_biotech_ecm`.`order`.`header` ALTER COLUMN `header_customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account ID');
ALTER TABLE `genomics_biotech_ecm`.`order`.`header` ALTER COLUMN `header_sold_to_party_account_id` SET TAGS ('dbx_business_glossary_term' = 'Sold-To Party ID');
ALTER TABLE `genomics_biotech_ecm`.`order`.`header` ALTER COLUMN `model_id` SET TAGS ('dbx_business_glossary_term' = 'Instrument Model Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`header` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Rd Project Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`header` ALTER COLUMN `service_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Service Agreement Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`header` ALTER COLUMN `service_offering_id` SET TAGS ('dbx_business_glossary_term' = 'Service Offering Id (Foreign Key)');
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
ALTER TABLE `genomics_biotech_ecm`.`order`.`line` SET TAGS ('dbx_subdomain' = 'sales_quotation');
ALTER TABLE `genomics_biotech_ecm`.`order`.`line` ALTER COLUMN `line_id` SET TAGS ('dbx_business_glossary_term' = 'Order Line Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`line` ALTER COLUMN `accreditation_id` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`line` ALTER COLUMN `approval_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`line` ALTER COLUMN `assay_development_id` SET TAGS ('dbx_business_glossary_term' = 'Assay Development Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`line` ALTER COLUMN `batch_id` SET TAGS ('dbx_business_glossary_term' = 'Batch Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`line` ALTER COLUMN `catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Reagent Catalog Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`line` ALTER COLUMN `change_control_id` SET TAGS ('dbx_business_glossary_term' = 'Change Control Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`line` ALTER COLUMN `controlled_document_id` SET TAGS ('dbx_business_glossary_term' = 'Controlled Document Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`line` ALTER COLUMN `crispr_construct_id` SET TAGS ('dbx_business_glossary_term' = 'Crispr Construct Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`line` ALTER COLUMN `grant_id` SET TAGS ('dbx_business_glossary_term' = 'Grant Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`line` ALTER COLUMN `header_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Order Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`line` ALTER COLUMN `test_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Ivd Test Catalog Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`line` ALTER COLUMN `labeling_id` SET TAGS ('dbx_business_glossary_term' = 'Labeling Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`line` ALTER COLUMN `library_id` SET TAGS ('dbx_business_glossary_term' = 'Library Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`line` ALTER COLUMN `lot_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`line` ALTER COLUMN `material_id` SET TAGS ('dbx_business_glossary_term' = 'Material Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`line` ALTER COLUMN `model_id` SET TAGS ('dbx_business_glossary_term' = 'Instrument Model Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`line` ALTER COLUMN `molecular_design_id` SET TAGS ('dbx_business_glossary_term' = 'Molecular Design Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`line` ALTER COLUMN `nonconformance_id` SET TAGS ('dbx_business_glossary_term' = 'Nonconformance Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`line` ALTER COLUMN `pipeline_version_id` SET TAGS ('dbx_business_glossary_term' = 'Pipeline Version Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`line` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`line` ALTER COLUMN `pricing_id` SET TAGS ('dbx_business_glossary_term' = 'Pricing Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`line` ALTER COLUMN `production_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Production Batch Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`line` ALTER COLUMN `qc_specification_id` SET TAGS ('dbx_business_glossary_term' = 'Qc Specification Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`line` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Rd Project Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`line` ALTER COLUMN `sequencing_protocol_id` SET TAGS ('dbx_business_glossary_term' = 'Sequencing Protocol Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`line` ALTER COLUMN `service_offering_id` SET TAGS ('dbx_business_glossary_term' = 'Service Offering Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`line` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`line` ALTER COLUMN `software_release_id` SET TAGS ('dbx_business_glossary_term' = 'Software Release Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`line` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`line` ALTER COLUMN `test_order_id` SET TAGS ('dbx_business_glossary_term' = 'Test Order Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`line` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`line` ALTER COLUMN `actual_ship_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Ship Date');
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
ALTER TABLE `genomics_biotech_ecm`.`order`.`quotation` SET TAGS ('dbx_subdomain' = 'sales_quotation');
ALTER TABLE `genomics_biotech_ecm`.`order`.`quotation` ALTER COLUMN `quotation_id` SET TAGS ('dbx_business_glossary_term' = 'Quotation Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`quotation` ALTER COLUMN `approval_id` SET TAGS ('dbx_business_glossary_term' = 'Approval Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`quotation` ALTER COLUMN `collaboration_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Collaboration Agreement Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`quotation` ALTER COLUMN `controlled_document_id` SET TAGS ('dbx_business_glossary_term' = 'Controlled Document Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`quotation` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`quotation` ALTER COLUMN `contact_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Contact Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`quotation` ALTER COLUMN `header_id` SET TAGS ('dbx_business_glossary_term' = 'Converted Order Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`quotation` ALTER COLUMN `model_id` SET TAGS ('dbx_business_glossary_term' = 'Instrument Model Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`quotation` ALTER COLUMN `performing_laboratory_id` SET TAGS ('dbx_business_glossary_term' = 'Performing Laboratory Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`quotation` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Rd Project Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`quotation` ALTER COLUMN `service_offering_id` SET TAGS ('dbx_business_glossary_term' = 'Service Offering Id (Foreign Key)');
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
ALTER TABLE `genomics_biotech_ecm`.`order`.`quotation_line` SET TAGS ('dbx_subdomain' = 'sales_quotation');
ALTER TABLE `genomics_biotech_ecm`.`order`.`quotation_line` ALTER COLUMN `quotation_line_id` SET TAGS ('dbx_business_glossary_term' = 'Quotation Line Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`quotation_line` ALTER COLUMN `approval_id` SET TAGS ('dbx_business_glossary_term' = 'Approval Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`quotation_line` ALTER COLUMN `assay_version_id` SET TAGS ('dbx_business_glossary_term' = 'Assay Version Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`quotation_line` ALTER COLUMN `catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Reagent Catalog Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`quotation_line` ALTER COLUMN `crispr_construct_id` SET TAGS ('dbx_business_glossary_term' = 'Crispr Construct Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`quotation_line` ALTER COLUMN `test_catalog_id` SET TAGS ('dbx_business_glossary_term' = 'Ivd Test Catalog Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`quotation_line` ALTER COLUMN `manufacturing_bom_id` SET TAGS ('dbx_business_glossary_term' = 'Manufacturing Bom Header Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`quotation_line` ALTER COLUMN `material_id` SET TAGS ('dbx_business_glossary_term' = 'Material Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`quotation_line` ALTER COLUMN `model_id` SET TAGS ('dbx_business_glossary_term' = 'Instrument Model Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`quotation_line` ALTER COLUMN `molecular_design_id` SET TAGS ('dbx_business_glossary_term' = 'Molecular Design Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`quotation_line` ALTER COLUMN `line_id` SET TAGS ('dbx_business_glossary_term' = 'Order Line Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`quotation_line` ALTER COLUMN `pipeline_id` SET TAGS ('dbx_business_glossary_term' = 'Pipeline Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`quotation_line` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`quotation_line` ALTER COLUMN `pricing_id` SET TAGS ('dbx_business_glossary_term' = 'Pricing Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`quotation_line` ALTER COLUMN `production_routing_id` SET TAGS ('dbx_business_glossary_term' = 'Production Routing Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`quotation_line` ALTER COLUMN `quotation_id` SET TAGS ('dbx_business_glossary_term' = 'Quotation Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`quotation_line` ALTER COLUMN `sequencing_protocol_id` SET TAGS ('dbx_business_glossary_term' = 'Sequencing Protocol Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`quotation_line` ALTER COLUMN `service_offering_id` SET TAGS ('dbx_business_glossary_term' = 'Service Offering Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`quotation_line` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`quotation_line` ALTER COLUMN `software_release_id` SET TAGS ('dbx_business_glossary_term' = 'Software Release Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`quotation_line` ALTER COLUMN `validation_study_id` SET TAGS ('dbx_business_glossary_term' = 'Validation Study Id (Foreign Key)');
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
ALTER TABLE `genomics_biotech_ecm`.`order`.`delivery` SET TAGS ('dbx_subdomain' = 'fulfillment_shipping');
ALTER TABLE `genomics_biotech_ecm`.`order`.`delivery` ALTER COLUMN `delivery_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`delivery` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Ship-To Customer Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`delivery` ALTER COLUMN `approval_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`delivery` ALTER COLUMN `complaint_id` SET TAGS ('dbx_business_glossary_term' = 'Complaint Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`delivery` ALTER COLUMN `deviation_id` SET TAGS ('dbx_business_glossary_term' = 'Deviation Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`delivery` ALTER COLUMN `finished_goods_release_id` SET TAGS ('dbx_business_glossary_term' = 'Finished Goods Release Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`delivery` ALTER COLUMN `fulfillment_instruction_id` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Instruction Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`delivery` ALTER COLUMN `header_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Order Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`delivery` ALTER COLUMN `nonconformance_id` SET TAGS ('dbx_business_glossary_term' = 'Nonconformance Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`delivery` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`delivery` ALTER COLUMN `address_id` SET TAGS ('dbx_business_glossary_term' = 'Ship To Address Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`delivery` ALTER COLUMN `address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`order`.`delivery` ALTER COLUMN `address_id` SET TAGS ('dbx_pii_address' = 'true');
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
ALTER TABLE `genomics_biotech_ecm`.`order`.`delivery` ALTER COLUMN `shipment_method` SET TAGS ('dbx_business_glossary_term' = 'Shipment Method');
ALTER TABLE `genomics_biotech_ecm`.`order`.`delivery` ALTER COLUMN `shipment_method` SET TAGS ('dbx_value_regex' = 'ground|air|ocean|cold_chain_ground|cold_chain_air|courier');
ALTER TABLE `genomics_biotech_ecm`.`order`.`delivery` ALTER COLUMN `temperature_range_max_c` SET TAGS ('dbx_business_glossary_term' = 'Maximum Temperature Requirement (Celsius)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`delivery` ALTER COLUMN `temperature_range_min_c` SET TAGS ('dbx_business_glossary_term' = 'Minimum Temperature Requirement (Celsius)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`delivery` ALTER COLUMN `total_gross_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Total Gross Weight (Kilograms)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`delivery` ALTER COLUMN `total_net_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Total Net Weight (Kilograms)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`delivery` ALTER COLUMN `tracking_number` SET TAGS ('dbx_business_glossary_term' = 'Shipment Tracking Number');
ALTER TABLE `genomics_biotech_ecm`.`order`.`delivery` ALTER COLUMN `un_number` SET TAGS ('dbx_business_glossary_term' = 'United Nations (UN) Number');
ALTER TABLE `genomics_biotech_ecm`.`order`.`delivery` ALTER COLUMN `un_number` SET TAGS ('dbx_value_regex' = '^UN[0-9]{4}$');
ALTER TABLE `genomics_biotech_ecm`.`order`.`delivery_line` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `genomics_biotech_ecm`.`order`.`delivery_line` SET TAGS ('dbx_subdomain' = 'fulfillment_shipping');
ALTER TABLE `genomics_biotech_ecm`.`order`.`delivery_line` ALTER COLUMN `delivery_line_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Line Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`delivery_line` ALTER COLUMN `batch_id` SET TAGS ('dbx_business_glossary_term' = 'Batch Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`delivery_line` ALTER COLUMN `batch_record_id` SET TAGS ('dbx_business_glossary_term' = 'Batch Record Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`delivery_line` ALTER COLUMN `catalog_item_id` SET TAGS ('dbx_business_glossary_term' = 'Product Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`delivery_line` ALTER COLUMN `coa_id` SET TAGS ('dbx_business_glossary_term' = 'Coa Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`delivery_line` ALTER COLUMN `delivery_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Document Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`delivery_line` ALTER COLUMN `device_identifier_id` SET TAGS ('dbx_business_glossary_term' = 'Device Identifier Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`delivery_line` ALTER COLUMN `header_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Order Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`delivery_line` ALTER COLUMN `inventory_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Inventory Transaction Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`delivery_line` ALTER COLUMN `labeling_id` SET TAGS ('dbx_business_glossary_term' = 'Labeling Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`delivery_line` ALTER COLUMN `lot_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`delivery_line` ALTER COLUMN `material_id` SET TAGS ('dbx_business_glossary_term' = 'Material Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`delivery_line` ALTER COLUMN `nonconformance_id` SET TAGS ('dbx_business_glossary_term' = 'Nonconformance Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`delivery_line` ALTER COLUMN `production_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Production Batch Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`delivery_line` ALTER COLUMN `qc_result_id` SET TAGS ('dbx_business_glossary_term' = 'Qc Result Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`delivery_line` ALTER COLUMN `line_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Order Line Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`delivery_line` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`delivery_line` ALTER COLUMN `storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'Source Storage Location Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`delivery_line` ALTER COLUMN `test_order_id` SET TAGS ('dbx_business_glossary_term' = 'Test Order Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`delivery_line` ALTER COLUMN `warehouse_location_id` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Location Id (Foreign Key)');
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
ALTER TABLE `genomics_biotech_ecm`.`order`.`delivery_line` ALTER COLUMN `un_number` SET TAGS ('dbx_business_glossary_term' = 'United Nations (UN) Number');
ALTER TABLE `genomics_biotech_ecm`.`order`.`delivery_line` ALTER COLUMN `un_number` SET TAGS ('dbx_value_regex' = '^UN[0-9]{4}$');
ALTER TABLE `genomics_biotech_ecm`.`order`.`delivery_line` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`delivery_line` ALTER COLUMN `volume_cubic_meters` SET TAGS ('dbx_business_glossary_term' = 'Volume in Cubic Meters');
ALTER TABLE `genomics_biotech_ecm`.`order`.`shipment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `genomics_biotech_ecm`.`order`.`shipment` SET TAGS ('dbx_subdomain' = 'fulfillment_shipping');
ALTER TABLE `genomics_biotech_ecm`.`order`.`shipment` ALTER COLUMN `shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`shipment` ALTER COLUMN `approval_id` SET TAGS ('dbx_business_glossary_term' = 'Approval Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`shipment` ALTER COLUMN `delivery_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`shipment` ALTER COLUMN `address_id` SET TAGS ('dbx_business_glossary_term' = 'Destination Address Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`shipment` ALTER COLUMN `address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`order`.`shipment` ALTER COLUMN `address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`order`.`shipment` ALTER COLUMN `deviation_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Deviation Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`shipment` ALTER COLUMN `fulfillment_instruction_id` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Instruction Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`shipment` ALTER COLUMN `header_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Order Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`shipment` ALTER COLUMN `nonconformance_id` SET TAGS ('dbx_business_glossary_term' = 'Nonconformance Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`shipment` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`shipment` ALTER COLUMN `test_order_id` SET TAGS ('dbx_business_glossary_term' = 'Test Order Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`shipment` ALTER COLUMN `actual_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Delivery Date');
ALTER TABLE `genomics_biotech_ecm`.`order`.`shipment` ALTER COLUMN `carrier_name` SET TAGS ('dbx_business_glossary_term' = 'Carrier Name');
ALTER TABLE `genomics_biotech_ecm`.`order`.`shipment` ALTER COLUMN `carrier_sla_breach_flag` SET TAGS ('dbx_business_glossary_term' = 'Carrier Service Level Agreement (SLA) Breach Flag');
ALTER TABLE `genomics_biotech_ecm`.`order`.`shipment` ALTER COLUMN `carrier_tracking_number` SET TAGS ('dbx_business_glossary_term' = 'Carrier Tracking Number');
ALTER TABLE `genomics_biotech_ecm`.`order`.`shipment` ALTER COLUMN `cold_chain_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Cold Chain Required Flag');
ALTER TABLE `genomics_biotech_ecm`.`order`.`shipment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`order`.`shipment` ALTER COLUMN `customer_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Customer Reference Number');
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
ALTER TABLE `genomics_biotech_ecm`.`order`.`return_authorization` SET TAGS ('dbx_subdomain' = 'fulfillment_shipping');
ALTER TABLE `genomics_biotech_ecm`.`order`.`return_authorization` ALTER COLUMN `return_authorization_id` SET TAGS ('dbx_business_glossary_term' = 'Return Authorization Identifier');
ALTER TABLE `genomics_biotech_ecm`.`order`.`return_authorization` ALTER COLUMN `approval_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`return_authorization` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`return_authorization` ALTER COLUMN `batch_id` SET TAGS ('dbx_business_glossary_term' = 'Batch Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`return_authorization` ALTER COLUMN `batch_record_id` SET TAGS ('dbx_business_glossary_term' = 'Batch Record Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`return_authorization` ALTER COLUMN `capa_id` SET TAGS ('dbx_business_glossary_term' = 'Capa Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`return_authorization` ALTER COLUMN `complaint_id` SET TAGS ('dbx_business_glossary_term' = 'Complaint Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`return_authorization` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account ID');
ALTER TABLE `genomics_biotech_ecm`.`order`.`return_authorization` ALTER COLUMN `deviation_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Deviation Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`return_authorization` ALTER COLUMN `field_safety_action_id` SET TAGS ('dbx_business_glossary_term' = 'Field Safety Action Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`return_authorization` ALTER COLUMN `installed_instrument_id` SET TAGS ('dbx_business_glossary_term' = 'Installed Instrument Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`return_authorization` ALTER COLUMN `inventory_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Inventory Transaction Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`return_authorization` ALTER COLUMN `lot_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`return_authorization` ALTER COLUMN `material_id` SET TAGS ('dbx_business_glossary_term' = 'Material Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`return_authorization` ALTER COLUMN `nonconformance_id` SET TAGS ('dbx_business_glossary_term' = 'Nonconformance Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`return_authorization` ALTER COLUMN `coa_id` SET TAGS ('dbx_business_glossary_term' = 'Original Coa Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`return_authorization` ALTER COLUMN `performing_laboratory_id` SET TAGS ('dbx_business_glossary_term' = 'Performing Laboratory Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`return_authorization` ALTER COLUMN `header_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Order ID');
ALTER TABLE `genomics_biotech_ecm`.`order`.`return_authorization` ALTER COLUMN `production_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Production Batch Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`return_authorization` ALTER COLUMN `delivery_line_id` SET TAGS ('dbx_business_glossary_term' = 'Return Delivery Line Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`return_authorization` ALTER COLUMN `line_id` SET TAGS ('dbx_business_glossary_term' = 'Return Order Line Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`return_authorization` ALTER COLUMN `storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'Return Storage Location Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`return_authorization` ALTER COLUMN `sequencing_run_id` SET TAGS ('dbx_business_glossary_term' = 'Sequencing Run Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`return_authorization` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`return_authorization` ALTER COLUMN `specification_id` SET TAGS ('dbx_business_glossary_term' = 'Specification Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`return_authorization` ALTER COLUMN `test_order_id` SET TAGS ('dbx_business_glossary_term' = 'Test Order Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`return_authorization` ALTER COLUMN `warehouse_location_id` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Location ID');
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
ALTER TABLE `genomics_biotech_ecm`.`order`.`status_event` SET TAGS ('dbx_subdomain' = 'fulfillment_shipping');
ALTER TABLE `genomics_biotech_ecm`.`order`.`status_event` ALTER COLUMN `status_event_id` SET TAGS ('dbx_business_glossary_term' = 'Order Status Event ID');
ALTER TABLE `genomics_biotech_ecm`.`order`.`status_event` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `genomics_biotech_ecm`.`order`.`status_event` ALTER COLUMN `delivery_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`status_event` ALTER COLUMN `deviation_id` SET TAGS ('dbx_business_glossary_term' = 'Deviation Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`status_event` ALTER COLUMN `fulfillment_instruction_id` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Instruction Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`status_event` ALTER COLUMN `header_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Order ID');
ALTER TABLE `genomics_biotech_ecm`.`order`.`status_event` ALTER COLUMN `return_authorization_id` SET TAGS ('dbx_business_glossary_term' = 'Return Authorization Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`status_event` ALTER COLUMN `sequencing_run_id` SET TAGS ('dbx_business_glossary_term' = 'Sequencing Run Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`status_event` ALTER COLUMN `shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`status_event` ALTER COLUMN `test_order_id` SET TAGS ('dbx_business_glossary_term' = 'Test Order Id (Foreign Key)');
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
ALTER TABLE `genomics_biotech_ecm`.`order`.`fulfillment_instruction` SET TAGS ('dbx_subdomain' = 'fulfillment_shipping');
ALTER TABLE `genomics_biotech_ecm`.`order`.`fulfillment_instruction` ALTER COLUMN `fulfillment_instruction_id` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Instruction Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`fulfillment_instruction` ALTER COLUMN `approval_id` SET TAGS ('dbx_business_glossary_term' = 'Approval Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`fulfillment_instruction` ALTER COLUMN `asset_id` SET TAGS ('dbx_business_glossary_term' = 'Instrument Asset Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`fulfillment_instruction` ALTER COLUMN `controlled_document_id` SET TAGS ('dbx_business_glossary_term' = 'Controlled Document Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`fulfillment_instruction` ALTER COLUMN `flow_cell_id` SET TAGS ('dbx_business_glossary_term' = 'Flow Cell Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`fulfillment_instruction` ALTER COLUMN `header_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Order Identifier (ID)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`fulfillment_instruction` ALTER COLUMN `installation_qualification_id` SET TAGS ('dbx_business_glossary_term' = 'Installation Qualification Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`fulfillment_instruction` ALTER COLUMN `library_prep_run_id` SET TAGS ('dbx_business_glossary_term' = 'Library Prep Run Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`fulfillment_instruction` ALTER COLUMN `lot_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`fulfillment_instruction` ALTER COLUMN `line_id` SET TAGS ('dbx_business_glossary_term' = 'Order Line Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`fulfillment_instruction` ALTER COLUMN `performing_laboratory_id` SET TAGS ('dbx_business_glossary_term' = 'Performing Laboratory Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`fulfillment_instruction` ALTER COLUMN `storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'Pick Storage Location Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`fulfillment_instruction` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`fulfillment_instruction` ALTER COLUMN `sequencing_run_id` SET TAGS ('dbx_business_glossary_term' = 'Sequencing Run Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`fulfillment_instruction` ALTER COLUMN `service_offering_id` SET TAGS ('dbx_business_glossary_term' = 'Service Offering Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`fulfillment_instruction` ALTER COLUMN `address_id` SET TAGS ('dbx_business_glossary_term' = 'Ship To Address Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`fulfillment_instruction` ALTER COLUMN `address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`order`.`fulfillment_instruction` ALTER COLUMN `address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`order`.`fulfillment_instruction` ALTER COLUMN `software_release_id` SET TAGS ('dbx_business_glossary_term' = 'Software Release Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`fulfillment_instruction` ALTER COLUMN `test_order_id` SET TAGS ('dbx_business_glossary_term' = 'Test Order Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`fulfillment_instruction` ALTER COLUMN `warehouse_location_id` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Location Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`fulfillment_instruction` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order Id (Foreign Key)');
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
ALTER TABLE `genomics_biotech_ecm`.`order`.`fulfillment_instruction` ALTER COLUMN `shipping_carrier_code` SET TAGS ('dbx_business_glossary_term' = 'Shipping Carrier Code');
ALTER TABLE `genomics_biotech_ecm`.`order`.`fulfillment_instruction` ALTER COLUMN `shipping_carrier_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `genomics_biotech_ecm`.`order`.`fulfillment_instruction` ALTER COLUMN `shipping_service_level` SET TAGS ('dbx_business_glossary_term' = 'Shipping Service Level');
ALTER TABLE `genomics_biotech_ecm`.`order`.`fulfillment_instruction` ALTER COLUMN `shipping_service_level` SET TAGS ('dbx_value_regex' = 'overnight|two_day|ground|international_express|international_standard|white_glove');
ALTER TABLE `genomics_biotech_ecm`.`order`.`fulfillment_instruction` ALTER COLUMN `special_handling_code` SET TAGS ('dbx_business_glossary_term' = 'Special Handling Code');
ALTER TABLE `genomics_biotech_ecm`.`order`.`fulfillment_instruction` ALTER COLUMN `tat_deadline_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Turnaround Time (TAT) Deadline Timestamp');
ALTER TABLE `genomics_biotech_ecm`.`order`.`fulfillment_instruction` ALTER COLUMN `temperature_monitoring_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Temperature Monitoring Required Flag');
ALTER TABLE `genomics_biotech_ecm`.`order`.`fulfillment_instruction` ALTER COLUMN `tracking_number` SET TAGS ('dbx_business_glossary_term' = 'Shipment Tracking Number');
ALTER TABLE `genomics_biotech_ecm`.`order`.`fulfillment_instruction` ALTER COLUMN `tracking_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{10,35}$');
ALTER TABLE `genomics_biotech_ecm`.`order`.`credit_memo` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `genomics_biotech_ecm`.`order`.`credit_memo` SET TAGS ('dbx_subdomain' = 'sales_quotation');
ALTER TABLE `genomics_biotech_ecm`.`order`.`credit_memo` ALTER COLUMN `credit_memo_id` SET TAGS ('dbx_business_glossary_term' = 'Credit Memo ID');
ALTER TABLE `genomics_biotech_ecm`.`order`.`credit_memo` ALTER COLUMN `complaint_id` SET TAGS ('dbx_business_glossary_term' = 'Complaint Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`credit_memo` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account ID');
ALTER TABLE `genomics_biotech_ecm`.`order`.`credit_memo` ALTER COLUMN `deviation_id` SET TAGS ('dbx_business_glossary_term' = 'Deviation Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`credit_memo` ALTER COLUMN `field_safety_action_id` SET TAGS ('dbx_business_glossary_term' = 'Field Safety Action Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`credit_memo` ALTER COLUMN `header_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Order ID');
ALTER TABLE `genomics_biotech_ecm`.`order`.`credit_memo` ALTER COLUMN `nonconformance_id` SET TAGS ('dbx_business_glossary_term' = 'Nonconformance Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`credit_memo` ALTER COLUMN `pricing_id` SET TAGS ('dbx_business_glossary_term' = 'Pricing Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`credit_memo` ALTER COLUMN `return_authorization_id` SET TAGS ('dbx_business_glossary_term' = 'Return Order ID');
ALTER TABLE `genomics_biotech_ecm`.`order`.`credit_memo` ALTER COLUMN `sequencing_run_id` SET TAGS ('dbx_business_glossary_term' = 'Sequencing Run Id (Foreign Key)');
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
ALTER TABLE `genomics_biotech_ecm`.`order`.`customer_po` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `genomics_biotech_ecm`.`order`.`customer_po` SET TAGS ('dbx_subdomain' = 'sales_quotation');
ALTER TABLE `genomics_biotech_ecm`.`order`.`customer_po` ALTER COLUMN `customer_po_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Purchase Order (PO) ID');
ALTER TABLE `genomics_biotech_ecm`.`order`.`customer_po` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account ID');
ALTER TABLE `genomics_biotech_ecm`.`order`.`customer_po` ALTER COLUMN `header_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Order (SO) ID');
ALTER TABLE `genomics_biotech_ecm`.`order`.`customer_po` ALTER COLUMN `quotation_id` SET TAGS ('dbx_business_glossary_term' = 'Quotation Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`customer_po` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Rd Project Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`customer_po` ALTER COLUMN `address_id` SET TAGS ('dbx_business_glossary_term' = 'Ship To Address Id (Foreign Key)');
ALTER TABLE `genomics_biotech_ecm`.`order`.`customer_po` ALTER COLUMN `address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `genomics_biotech_ecm`.`order`.`customer_po` ALTER COLUMN `address_id` SET TAGS ('dbx_pii_address' = 'true');
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
ALTER TABLE `genomics_biotech_ecm`.`order`.`customer_po` ALTER COLUMN `shipping_terms` SET TAGS ('dbx_business_glossary_term' = 'Shipping Terms');
ALTER TABLE `genomics_biotech_ecm`.`order`.`customer_po` ALTER COLUMN `special_terms_notes` SET TAGS ('dbx_business_glossary_term' = 'Special Terms Notes');
