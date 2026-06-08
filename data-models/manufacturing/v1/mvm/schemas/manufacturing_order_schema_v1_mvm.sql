-- Schema for Domain: order | Business: Manufacturing | Version: v1_mvm
-- Generated on: 2026-05-06 09:42:35

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `manufacturing_ecm`.`order` COMMENT 'Order management and fulfillment domain governing the end-to-end order lifecycle from customer purchase orders through production scheduling, shipment, and delivery confirmation. Manages order headers, line items, delivery schedules, RMAs, fulfillment SLAs, and customer order lifecycle via SAP SD.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `manufacturing_ecm`.`order`.`header` (
    `header_id` BIGINT COMMENT 'System-generated unique identifier for the sales order header.',
    `account_id` BIGINT COMMENT 'Unique identifier of the customer who placed the order.',
    `account_site_id` BIGINT COMMENT 'Foreign key linking to customer.account_site. Business justification: Industrial equipment orders need an installation site for field service planning; site details are in customer.account_site.',
    `blanket_order_id` BIGINT COMMENT 'Foreign key linking to order.blanket_order. Business justification: An order_header may be created as a release against a blanket order (scheduling agreement). Adding blanket_order_id to order_header establishes the parent blanket agreement context for the order, enab',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: Multi-entity statutory reporting: in industrial manufacturing groups, each sales order belongs to a legal entity (company code) for intercompany billing, VAT reporting, and segment P&L. Standard in SA',
    `contract_id` BIGINT COMMENT 'Foreign key linking to sales.sales_contract. Business justification: Contract compliance: orders are executed under a sales contract; linking ensures legal and pricing terms are enforced per order.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Overall order budgeting: assigning a sales order to a cost center supports order‑level expense allocation and budgeting reports.',
    `customer_contact_id` BIGINT COMMENT 'Foreign key linking to customer.contact. Business justification: Order processing uses a sold‑to contact for invoicing and communication; this contact is stored in customer.contact.',
    `opportunity_id` BIGINT COMMENT 'Foreign key linking to sales.opportunity. Business justification: Revenue attribution: linking orders to the originating sales opportunity enables pipeline‑to‑revenue reporting and commission calculations.',
    `order_intake_id` BIGINT COMMENT 'Foreign key linking to sales.order_intake. Business justification: Order Management traceability: each order must reference the intake record that created it for audit and fulfillment reporting.',
    `price_book_id` BIGINT COMMENT 'Foreign key linking to sales.price_book. Business justification: In industrial manufacturing, every order is priced against a specific price book (regional, customer-segment, or contract-specific). Pricing audit, discount compliance, and revenue recognition reports',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Revenue attribution: linking the order to a profit center enables consolidated profit‑and‑loss reporting per sales order.',
    `project_id` BIGINT COMMENT 'Foreign key linking to engineering.engineering_project. Business justification: Engineer-to-order (ETO) manufacturing requires linking customer orders to engineering projects for delivery milestone tracking, cost-to-complete reporting, and project accounting. Industrial manufactu',
    `quote_id` BIGINT COMMENT 'Foreign key linking to sales.quote. Business justification: Order-to-quote traceability is a core industrial manufacturing process: the accepted quote drives order pricing, configuration, and terms. Finance and operations teams run quote-conversion and order-a',
    `rep_id` BIGINT COMMENT 'Foreign key linking to sales.rep. Business justification: Commission & accountability: each order is credited to the responsible sales rep, supporting commission payout and performance metrics.',
    `territory_id` BIGINT COMMENT 'Foreign key linking to sales.territory. Business justification: Territory reporting: orders must be assigned to a sales territory for quota tracking, regional performance dashboards, and incentive calculations.',
    `address_id` BIGINT COMMENT 'Foreign key linking to customer.address. Business justification: Shipping logistics require a reference to the customers shipping address; address data resides in customer.address.',
    `sla_agreement_id` BIGINT COMMENT 'Foreign key linking to customer.sla_agreement. Business justification: Orders in industrial manufacturing are governed by specific SLA agreements defining on-time delivery targets and penalty clauses. Order fulfillment teams must reference the governing SLA for priority ',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to supplier.supplier. Business justification: Single‑source orders may designate a preferred supplier at the header level; used in order approval and compliance reporting.',
    `billing_block` BOOLEAN COMMENT 'Flag indicating whether billing of the order is blocked.',
    `credit_status` STRING COMMENT 'Credit check result for the customer at order time.. Valid values are `unblocked|blocked|on_hold`',
    `currency_rate` DECIMAL(18,2) COMMENT 'Exchange rate from order currency to company code currency at pricing time.',
    `customer_account_group` STRING COMMENT 'SAP account group categorizing the customer.',
    `customer_purchase_order_date` DATE COMMENT 'Date on the customers purchase order.',
    `delivery_block` BOOLEAN COMMENT 'Flag indicating whether delivery of the order is blocked.',
    `distribution_channel` STRING COMMENT 'Channel through which the order is distributed (e.g., wholesale, retail).',
    `division` STRING COMMENT 'Business division handling the order.',
    `freight_terms` STRING COMMENT 'Terms governing freight cost responsibility (e.g., prepaid, collect).',
    `gross_weight_kg` DECIMAL(18,2) COMMENT 'Total gross weight of the order including packaging, measured in kilograms.',
    `incoterms` STRING COMMENT 'International commercial terms defining delivery responsibilities. [ENUM-REF-CANDIDATE: EXW|FCA|FOB|CFR|CIF|DAP|DDP — promote to reference product]',
    `internal_comments` STRING COMMENT 'Internal notes visible only to company personnel.',
    `net_weight_kg` DECIMAL(18,2) COMMENT 'Total net weight of all items in the order, measured in kilograms.',
    `order_currency` STRING COMMENT 'Three‑letter ISO 4217 currency code for the order amounts.',
    `order_number` STRING COMMENT 'External business identifier for the order as used in customer communications.',
    `order_placed_timestamp` TIMESTAMP COMMENT 'Timestamp when the customer placed the order.',
    `order_priority` STRING COMMENT 'Priority level assigned to the order for processing.. Valid values are `low|medium|high|urgent`',
    `order_reason` STRING COMMENT 'Free‑text description of why the order was created (e.g., new project, replacement).',
    `order_status` STRING COMMENT 'Current lifecycle state of the order. [ENUM-REF-CANDIDATE: created|released|partially_delivered|completed|cancelled|closed|on_hold — promote to reference product]',
    `order_text` STRING COMMENT 'Long free‑text field for additional order instructions or remarks.',
    `order_type` STRING COMMENT 'Classification of the order based on fulfillment rules.. Valid values are `standard|rush|blanket|consignment`',
    `payment_terms` STRING COMMENT 'Contractual terms defining when payment is due (e.g., NET30).',
    `price_group` STRING COMMENT 'Group determining price level for the customer.',
    `pricing_date` DATE COMMENT 'Date on which the pricing conditions were determined.',
    `purchase_order_number` STRING COMMENT 'Reference number supplied by the customer for their internal tracking.',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when the order record was first captured in the system.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the order record.',
    `requested_delivery_date` DATE COMMENT 'Date requested by the customer for order delivery.',
    `route` STRING COMMENT 'Planned transportation route for delivering the order.',
    `sales_document_type` STRING COMMENT 'SAP SD document type code (e.g., OR for standard order).',
    `sales_group` STRING COMMENT 'Group of sales representatives responsible for the order.',
    `sales_office` STRING COMMENT 'Geographic sales office handling the order.',
    `sales_organization` STRING COMMENT 'Code of the sales organization responsible for the order.',
    `shipping_condition` STRING COMMENT 'Condition governing the shipping method for the order.. Valid values are `standard|express|pickup`',
    `shipping_point` STRING COMMENT 'Logistics location from which the order will be shipped.',
    `tax_code` STRING COMMENT 'Tax code applied to the order for tax calculation.',
    `total_gross_amount` DECIMAL(18,2) COMMENT 'Sum of line item amounts before taxes, discounts, and surcharges.',
    `total_net_amount` DECIMAL(18,2) COMMENT 'Final amount payable after taxes, discounts, and surcharges.',
    `total_tax_amount` DECIMAL(18,2) COMMENT 'Total tax calculated for the order.',
    `transportation_group` STRING COMMENT 'Classification of transportation mode and carrier.',
    `volume_m3` DECIMAL(18,2) COMMENT 'Total volume of the order in cubic meters.',
    CONSTRAINT pk_header PRIMARY KEY(`header_id`)
) COMMENT 'Core master record for customer purchase orders representing the full order commitment in the order-to-cash lifecycle. Captures customer reference, order type (standard, rush, blanket, consignment), requested delivery date, incoterms, payment terms, pricing date, total net value, currency, sales organization, distribution channel, division, and overall order status. Serves as the SSOT for all customer order commitments in the industrial manufacturing order lifecycle, driving downstream delivery, billing, and revenue recognition.';

CREATE OR REPLACE TABLE `manufacturing_ecm`.`order`.`order_line` (
    `order_line_id` BIGINT COMMENT 'Unique surrogate key for each order line record.',
    `account_site_id` BIGINT COMMENT 'Foreign key linking to customer.account_site. Business justification: Order lines in industrial manufacturing can be destined for different customer sites within a multi-plant account (split shipments). Site-level line assignment supports site-specific delivery scheduli',
    `bom_id` BIGINT COMMENT 'Foreign key linking to engineering.bom. Business justification: Enables Production Planning to pull the exact BOM version for the ordered product, essential for material requirement planning (MRP) reports.',
    `component_id` BIGINT COMMENT 'Foreign key linking to engineering.component. Business justification: Required for Order‑to‑Manufacturing handoff report linking each sold line to the engineered component for traceability and production scheduling.',
    `configuration_id` BIGINT COMMENT 'Foreign key linking to product.configuration. Business justification: Configure-to-order is a core process in industrial manufacturing (automation systems, drives, switchgear). Each order line references the specific product configuration selected, which drives BOM expl',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Cost accounting: each sales order line must be charged to a cost center for internal cost reporting and profitability analysis.',
    `engineering_revision_id` BIGINT COMMENT 'Foreign key linking to engineering.engineering_revision. Business justification: Order lines in industrial manufacturing must capture the engineering revision valid at order placement to ensure the correct revision is manufactured and shipped. Drives production execution accuracy,',
    `header_id` BIGINT COMMENT 'Identifier of the parent sales order (transaction header) to which this line belongs.',
    `lot_batch_id` BIGINT COMMENT 'Foreign key linking to inventory.lot_batch. Business justification: Regulated products require batch traceability from order line to lot batch for quality, recall, and compliance management.',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to inventory.material_master. Business justification: Order fulfillment requires linking each order line to the material master for inventory reservation, costing, and MRP planning; this is standard in manufacturing ERP systems.',
    `price_book_entry_id` BIGINT COMMENT 'Foreign key linking to sales.price_book_entry. Business justification: Order line pricing in industrial manufacturing must be traceable to the specific price book entry used (list price, discount floor, UOM). Margin analysis, pricing compliance audits, and revenue recogn',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Profitability tracking: linking order line revenue to a profit center enables margin reporting per product line.',
    `quote_line_id` BIGINT COMMENT 'Foreign key linking to sales.quote_line. Business justification: Audit trail: order line must reference the originating quote line to validate pricing, configuration, and warranty obligations.',
    `serialized_unit_id` BIGINT COMMENT 'Foreign key linking to inventory.serialized_unit. Business justification: Serialized items need direct linkage between order line and specific serialized unit to support warranty, service, and traceability.',
    `sku_master_id` BIGINT COMMENT 'Foreign key linking to product.sku_master. Business justification: Required for Order Fulfillment & Costing report linking each order line to the master product record for pricing, compliance, and warranty tracking.',
    `spare_part_id` BIGINT COMMENT 'Foreign key linking to asset.spare_part. Business justification: Needed for Spare Part Sales process to tie sold line items to the spare‑part master for warranty and inventory tracking.',
    `stock_location_id` BIGINT COMMENT 'Foreign key linking to inventory.stock_location. Business justification: Picking process assigns a specific storage location to each order line to locate inventory in the warehouse; the link enables pick list generation and inventory accuracy.',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to supplier.supplier. Business justification: Procurement assigns a supplier to each order line for purchasing; needed for supplier performance, cost analysis, and PO generation.',
    `actual_delivery_date` DATE COMMENT 'Date the goods were actually received by the customer.',
    `backorder_indicator` BOOLEAN COMMENT 'True if the line is on backorder, otherwise false.',
    `batch_number` STRING COMMENT 'Batch identifier for traceability of the material.',
    `blanket_release_number` STRING COMMENT 'Identifier of the blanket order release that generated this line.',
    `confirmed_quantity` DECIMAL(18,2) COMMENT 'Quantity confirmed by the system after availability check.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the order line record was created in the source system.',
    `currency` STRING COMMENT 'Three‑letter ISO 4217 currency code for the monetary values on this line.',
    `delivery_date` DATE COMMENT 'Actual date the line was delivered to the customer.',
    `delivery_status` STRING COMMENT 'Current status of the lines delivery.. Valid values are `pending|shipped|delivered|cancelled|backordered`',
    `discount_amount` DECIMAL(18,2) COMMENT 'Monetary discount applied to this line.',
    `distribution_channel` STRING COMMENT 'Channel through which the product is sold (e.g., online, direct).',
    `division` STRING COMMENT 'Business division responsible for the product.',
    `gross_price` DECIMAL(18,2) COMMENT 'Total price after taxes and before discounts.',
    `gross_weight` DECIMAL(18,2) COMMENT 'Total weight of the line item including packaging (kilograms).',
    `inspection_status` STRING COMMENT 'Current status of the quality inspection process.. Valid values are `not_started|in_progress|completed`',
    `lead_time_days` STRING COMMENT 'Planned lead time in days from order to delivery.',
    `line_number` STRING COMMENT 'Sequential number of the line within the order, used for ordering and reference.',
    `net_price` DECIMAL(18,2) COMMENT 'Net price per unit before taxes and discounts.',
    `net_weight` DECIMAL(18,2) COMMENT 'Weight of the product itself without packaging (kilograms).',
    `plant` STRING COMMENT 'SAP plant code where the product is stocked or produced for this order line.',
    `pricing_condition` STRING COMMENT 'Pricing condition type governing the price calculation.. Valid values are `standard|discount|rebate|surcharge`',
    `product_description` STRING COMMENT 'Human‑readable description of the product or service on the line.',
    `promised_date` DATE COMMENT 'Date promised to the customer for delivery.',
    `quality_score` DECIMAL(18,2) COMMENT 'Numeric score representing quality assessment (0‑100).',
    `quality_status` STRING COMMENT 'Result of quality inspection for the line item.. Valid values are `passed|failed|pending`',
    `rejection_reason` STRING COMMENT 'Reason provided when the line is rejected or cancelled.',
    `requested_quantity` DECIMAL(18,2) COMMENT 'Quantity originally requested by the customer.',
    `rma_reference` STRING COMMENT 'Reference to an RMA record if the line is a return.',
    `sales_org` STRING COMMENT 'Organizational unit responsible for the sale.',
    `sales_price` DECIMAL(18,2) COMMENT 'Price per unit used for revenue recognition.',
    `sales_quantity` DECIMAL(18,2) COMMENT 'Quantity used for sales reporting, may differ from requested/confirmed units.',
    `schedule_line_date` DATE COMMENT 'Planned date for delivery or production of this line item.',
    `serial_number` STRING COMMENT 'Serial number for serialized items.',
    `storage_location` STRING COMMENT 'Warehouse or bin location from which the material will be shipped.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Tax amount applicable to this line item.',
    `unit_of_measure` STRING COMMENT 'Measurement unit for the quantity (e.g., each, kilogram).. Valid values are `EA|KG|L|M|PCS|TON`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the order line record.',
    `volume` DECIMAL(18,2) COMMENT 'Physical volume of the line item (cubic meters).',
    `volume_uom` STRING COMMENT 'Unit of measure for volume.. Valid values are `M3|L|FT3`',
    `weight_uom` STRING COMMENT 'Unit of measure for weight fields.. Valid values are `KG|LB|TON`',
    CONSTRAINT pk_order_line PRIMARY KEY(`order_line_id`)
) COMMENT 'Individual line item within a customer sales order representing a discrete product, automation system, or service being ordered. Captures material number, ordered and confirmed quantities, unit of measure, schedule line dates, net price, pricing conditions, plant assignment, storage location, delivery status, rejection reason, and blanket order release reference. Serves as the demand signal for MRP and production scheduling. May reference a parent blanket order for scheduling agreement releases.';

CREATE OR REPLACE TABLE `manufacturing_ecm`.`order`.`schedule_line` (
    `schedule_line_id` BIGINT COMMENT 'System-generated unique identifier for the schedule line record.',
    `account_site_id` BIGINT COMMENT 'Foreign key linking to customer.account_site. Business justification: Schedule lines represent confirmed delivery commitments to a specific customer production site. Site attributes (operating hours, dock availability, 24x7 flag) directly govern delivery window scheduli',
    `header_id` BIGINT COMMENT 'Identifier of the parent sales order header to which this schedule line belongs.',
    `lot_batch_id` BIGINT COMMENT 'Foreign key linking to inventory.lot_batch. Business justification: In batch-managed manufacturing, schedule lines are confirmed against specific lot/batches for ATP at batch level, FIFO allocation, and shelf-life-controlled delivery scheduling. lot_number and batch_n',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to inventory.material_master. Business justification: MRP availability checks and delivery scheduling in manufacturing require schedule lines to reference the material master for lead time, safety stock parameters, and procurement type determination. Dom',
    `order_line_id` BIGINT COMMENT 'Reference to the original schedule line when this line is a split part.',
    `sku_master_id` BIGINT COMMENT 'Identifier of the product or material being scheduled for delivery.',
    `stock_location_id` BIGINT COMMENT 'Foreign key linking to inventory.stock_location. Business justification: Production scheduling allocates order schedule lines to exact stock locations for material staging; linking supports real-time allocation and capacity planning.',
    `backorder_indicator` BOOLEAN COMMENT 'True if the schedule line is backordered due to insufficient stock.',
    `confirmed_delivery_date` DATE COMMENT 'Date confirmed by the system for delivery after scheduling.',
    `confirmed_quantity` DECIMAL(18,2) COMMENT 'Quantity confirmed by the system after ATP check and production planning.',
    `confirmed_quantity_uom` STRING COMMENT 'Unit of measure for the confirmed quantity.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the schedule line record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 currency code for the line amount.',
    `goods_issue_date` DATE COMMENT 'Date on which the goods were posted to inventory for shipment.',
    `handling_unit` STRING COMMENT 'Identifier of the handling unit (e.g., pallet, container) used for the shipment.',
    `incoterms` STRING COMMENT 'International commercial terms governing delivery responsibilities.. Valid values are `EXW|FCA|FOB|CFR|CIF|DDP`',
    `line_net_amount` DECIMAL(18,2) COMMENT 'Net monetary value of the confirmed quantity before taxes.',
    `mrp_confirmed_availability_date` DATE COMMENT 'Date when material availability was confirmed by MRP.',
    `plant` STRING COMMENT 'Manufacturing plant responsible for producing the scheduled quantity.',
    `priority_code` STRING COMMENT 'Priority of the schedule line for production and delivery planning.. Valid values are `high|medium|low`',
    `requested_delivery_date` DATE COMMENT 'Date the customer originally requested for delivery.',
    `requested_quantity` DECIMAL(18,2) COMMENT 'Quantity originally requested by the customer for this schedule line.',
    `requested_quantity_uom` STRING COMMENT 'Unit of measure for the requested quantity (e.g., PCS, KG, M3).',
    `route` STRING COMMENT 'Planned transportation route for the delivery.',
    `schedule_line_number` STRING COMMENT 'Sequential number of the schedule line within the order line item.',
    `schedule_line_status` STRING COMMENT 'Current processing status of the schedule line.. Valid values are `confirmed|released|blocked|canceled|pending`',
    `serial_number` STRING COMMENT 'Serial number for serialized items in the schedule line.',
    `shipping_point` STRING COMMENT 'Logistics location from which the goods will be shipped.',
    `split_indicator` BOOLEAN COMMENT 'True if the original order line has been split into multiple schedule lines.',
    `storage_location` STRING COMMENT 'Warehouse location where the goods will be staged before shipment.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the schedule line record.',
    CONSTRAINT pk_schedule_line PRIMARY KEY(`schedule_line_id`)
) COMMENT 'Delivery schedule line within a sales order line item defining confirmed delivery quantities and dates for industrial manufacturing fulfillment. Captures schedule line number, confirmed quantity, delivery date, goods issue date, route, shipping point, and MRP-confirmed availability date. Critical for Available-to-Promise (ATP) checks and production scheduling alignment in the order fulfillment process.';

CREATE OR REPLACE TABLE `manufacturing_ecm`.`order`.`delivery` (
    `delivery_id` BIGINT COMMENT 'Primary key for delivery',
    `account_site_id` BIGINT COMMENT 'Foreign key linking to customer.account_site. Business justification: Delivery execution tracks the specific plant/site where goods are delivered; site info lives in customer.account_site.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Logistics expense accounting: delivery freight and handling costs are charged to a cost center for logistics cost analysis.',
    `customer_contact_id` BIGINT COMMENT 'Foreign key linking to customer.customer_contact. Business justification: Delivery notifications, proof-of-delivery confirmations, and exception alerts in industrial manufacturing are directed to a specific site contact. Role-prefix delivery_ distinguishes from the order-',
    `account_id` BIGINT COMMENT 'Identifier of the customer who placed the original sales order.',
    `delivery_ship_to_party_customer_account_id` BIGINT COMMENT 'Identifier of the party to which the goods are shipped.',
    `header_id` BIGINT COMMENT 'Foreign key linking to order.order_header. Business justification: Link delivery to its originating order header; enables traceability and removes redundant order number fields.',
    `address_id` BIGINT COMMENT 'Foreign key linking to customer.address. Business justification: Delivery ship-to address must reference the validated customer address master for logistics compliance, hazmat certification checks, and address validation reporting. Removes denormalized address fiel',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to supplier.supplier. Business justification: Inbound delivery records the supplying vendor; required for logistics tracking, on‑time delivery KPI, and supplier scorecards.',
    `warehouse_id` BIGINT COMMENT 'Foreign key linking to inventory.warehouse. Business justification: Outbound deliveries in manufacturing originate from a specific warehouse for dock assignment, capacity planning, carrier coordination, and customs documentation. Domain experts expect delivery records',
    `actual_delivery_date` DATE COMMENT 'Date the delivery was actually received by the customer.',
    `actual_goods_issue_timestamp` TIMESTAMP COMMENT 'Timestamp when goods were actually issued from the warehouse.',
    `carrier_code` STRING COMMENT 'Code of the logistics carrier responsible for transportation.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the delivery record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for monetary amounts.. Valid values are `^[A-Z]{3}$`',
    `delivery_number` STRING COMMENT 'External delivery document number assigned by SAP for tracking and communication.',
    `delivery_state` STRING COMMENT 'State or province component of the delivery destination address.',
    `delivery_status` STRING COMMENT 'Current lifecycle status of the delivery.. Valid values are `planned|released|picked|shipped|delivered|cancelled`',
    `delivery_type` STRING COMMENT 'Classification of the delivery, e.g., stock shipment, return, consignment.',
    `freight_cost_amount` DECIMAL(18,2) COMMENT 'Base freight charge before taxes and surcharges.',
    `freight_tax_amount` DECIMAL(18,2) COMMENT 'Tax component applied to the freight cost.',
    `freight_total_amount` DECIMAL(18,2) COMMENT 'Total freight charge including taxes and surcharges.',
    `handling_instructions` STRING COMMENT 'Special handling notes for the carrier (e.g., fragile, keep upright).',
    `hazardous_material_flag` BOOLEAN COMMENT 'Indicates whether the delivery contains hazardous or regulated materials.',
    `is_backorder` BOOLEAN COMMENT 'True when the delivery contains items that were previously on backorder.',
    `is_partial_delivery` BOOLEAN COMMENT 'Indicates whether the delivery fulfills only part of the sales order quantity.',
    `number_of_items` STRING COMMENT 'Count of individual line items included in the delivery.',
    `planned_delivery_date` DATE COMMENT 'Date the delivery is scheduled to arrive at the customer location.',
    `planned_goods_issue_date` DATE COMMENT 'Planned date on which goods are to be issued from inventory.',
    `priority` STRING COMMENT 'Priority level assigned to the delivery for scheduling purposes.. Valid values are `low|medium|high`',
    `shipping_condition` STRING COMMENT 'Incoterm defining responsibility and cost allocation between seller and buyer.. Valid values are `EXW|FOB|CIF|DDP`',
    `shipping_point` STRING COMMENT 'Plant or warehouse location code where the delivery originates.',
    `special_equipment_required` BOOLEAN COMMENT 'Indicates if special equipment (e.g., liftgate) is needed for delivery.',
    `temperature_control_required` BOOLEAN COMMENT 'True when the shipment must be kept within a temperature range.',
    `total_gross_weight_kg` DECIMAL(18,2) COMMENT 'Combined gross weight of all items in the delivery, expressed in kilograms.',
    `total_volume_m3` DECIMAL(18,2) COMMENT 'Combined volume of the delivery items, expressed in cubic meters.',
    `tracking_number` STRING COMMENT 'Unique identifier provided by the carrier to track the shipment.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the delivery record.',
    `window_end` TIMESTAMP COMMENT 'End timestamp of the agreed delivery time window.',
    `window_start` TIMESTAMP COMMENT 'Start timestamp of the agreed delivery time window.',
    CONSTRAINT pk_delivery PRIMARY KEY(`delivery_id`)
) COMMENT 'Outbound delivery document created from a sales order authorizing the physical shipment of finished goods or automation systems from a plant or warehouse. Captures delivery number, delivery type, shipping point, planned goods issue date, actual goods issue date, total weight, volume, carrier, tracking number, and delivery status. Links order fulfillment to warehouse execution and logistics operations.';

CREATE OR REPLACE TABLE `manufacturing_ecm`.`order`.`delivery_item` (
    `delivery_item_id` BIGINT COMMENT 'System-generated unique identifier for the delivery line item.',
    `component_id` BIGINT COMMENT 'Foreign key linking to engineering.component. Business justification: Provides shipment traceability to the specific engineered component, required for compliance and after‑sales service analysis.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Item‑level shipping cost allocation: each delivery item’s handling cost is assigned to a cost center for detailed expense tracking.',
    `delivery_id` BIGINT COMMENT 'Identifier of the parent outbound delivery document to which this line belongs.',
    `engineering_revision_id` BIGINT COMMENT 'Foreign key linking to engineering.engineering_revision. Business justification: Delivery items must record the engineering revision actually shipped for field traceability, warranty determination, and regulatory compliance (product liability, CE/UL certification). In industrial m',
    `equipment_register_id` BIGINT COMMENT 'Foreign key linking to asset.equipment_register. Business justification: Asset commissioning workflow: delivery of serialized capital equipment (automation systems, smart infrastructure components) triggers asset register creation. Linking delivery_item to equipment_regist',
    `lot_batch_id` BIGINT COMMENT 'Foreign key linking to inventory.lot_batch. Business justification: Delivery item picking in industrial manufacturing is batch-controlled for FIFO compliance, quality traceability, and recall management. Domain experts expect delivery_item to reference the exact lot_b',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to inventory.material_master. Business justification: Delivery item goods movement posting requires the material master for inventory valuation, account determination, and material traceability in manufacturing ERP. Domain experts expect this FK. materia',
    `order_line_id` BIGINT COMMENT 'Foreign key linking to order.order_line. Business justification: Associate each delivery item with the order line it fulfills, providing clear lineage.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Segment revenue reporting: delivery items in industrial manufacturing are assigned to profit centers for product-line P&L and segment reporting. Controllers require profit center on delivery items for',
    `schedule_line_id` BIGINT COMMENT 'Foreign key linking to order.schedule_line. Business justification: In SAP SD, a delivery item (LIPS) is created from a specific schedule line (VBEP), not just from the order line. delivery_item already has line_id → order.line, but the more precise traceability requi',
    `serialized_unit_id` BIGINT COMMENT 'Foreign key linking to inventory.serialized_unit. Business justification: For serialized industrial equipment (automation systems, drives), delivery items must reference the specific serialized unit for asset tracking, warranty registration, and regulatory compliance. seria',
    `sku_master_id` BIGINT COMMENT 'Foreign key linking to product.sku_master. Business justification: Enables Delivery Traceability and Warranty Claim process by tying each delivered item to its master product record.',
    `stock_location_id` BIGINT COMMENT 'Foreign key linking to inventory.stock_location. Business justification: Delivery execution tracks the source stock location of shipped items for traceability and logistics reporting.',
    `actual_goods_issue_timestamp` TIMESTAMP COMMENT 'Timestamp when the goods issue for this line was posted.',
    `carrier_code` STRING COMMENT 'Identifier of the carrier responsible for transportation.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the delivery line record was first created in the system.',
    `delivery_date` DATE COMMENT 'Planned date for the delivery of this line item.',
    `goods_movement_status` STRING COMMENT 'Status of the goods issue transaction for this line.. Valid values are `not_issued|issued|reversed`',
    `handling_unit_number` STRING COMMENT 'Identifier of the handling unit (pallet, crate) containing the material.',
    `inspection_result` STRING COMMENT 'Result of the quality inspection (e.g., pass, fail, rework).',
    `inventory_management_indicator` STRING COMMENT 'Flag indicating whether the line is subject to inventory management.. Valid values are `X|`',
    `item_category` STRING COMMENT 'Category defining the business purpose of the line (e.g., standard sale, return, consignment).. Valid values are `standard|return|consignment`',
    `movement_reason` STRING COMMENT 'Reason code for the goods movement, if applicable.',
    `movement_type` STRING COMMENT 'SAP movement type code that defines the kind of goods movement.',
    `pallet_number` STRING COMMENT 'Identifier of the pallet on which the line item is loaded.',
    `picking_status` STRING COMMENT 'Current status of the picking process for this line.. Valid values are `not_picked|partially_picked|picked|blocked`',
    `plant` STRING COMMENT 'Plant where the material is stocked for this delivery.',
    `promised_delivery_date` DATE COMMENT 'Customer‑promised delivery date agreed in the sales order.',
    `quality_inspection_status` STRING COMMENT 'Status of quality inspection for the delivered material.. Valid values are `not_required|required|passed|failed`',
    `quantity_delivered` DECIMAL(18,2) COMMENT 'Actual quantity of material that has been delivered (goods issue).',
    `quantity_ordered` DECIMAL(18,2) COMMENT 'Quantity of material ordered for this delivery line.',
    `quantity_picked` DECIMAL(18,2) COMMENT 'Quantity of material that has been physically picked from inventory.',
    `route` STRING COMMENT 'Defined transportation route for the delivery.',
    `serial_number_end` STRING COMMENT 'Ending serial number of the range allocated to this line.',
    `serial_number_start` STRING COMMENT 'Starting serial number of the range allocated to this line, when serial‑managed.',
    `shipping_condition` STRING COMMENT 'Condition under which the goods are shipped (e.g., standard, express).',
    `shipping_point` STRING COMMENT 'Logistics point from which the goods are shipped.',
    `special_stock_indicator` STRING COMMENT 'Indicator for special stock types such as project stock, vendor consignment, etc.. Valid values are `E|K|L|M|N`',
    `storage_location` STRING COMMENT 'Warehouse storage location from which the material is picked.',
    `unit_of_measure` STRING COMMENT 'Measurement unit in which quantities are expressed.. Valid values are `EA|KG|L|M|PC|SET`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the delivery line record.',
    `volume_m3` DECIMAL(18,2) COMMENT 'Physical volume of the line item in cubic meters.',
    `weight_kg` DECIMAL(18,2) COMMENT 'Gross weight of the line item in kilograms.',
    CONSTRAINT pk_delivery_item PRIMARY KEY(`delivery_item_id`)
) COMMENT 'Individual line item within an outbound delivery document specifying the material, quantity, batch, storage location, and picking status for each product being shipped. Captures delivery item number, material number, delivery quantity, picked quantity, batch number, serial number range, storage location, and goods movement status. Supports warehouse picking, packing, and goods issue execution.';

CREATE OR REPLACE TABLE `manufacturing_ecm`.`order`.`rma` (
    `rma_id` BIGINT COMMENT 'Unique system-generated identifier for the RMA record.',
    `account_id` BIGINT COMMENT 'Unique identifier of the customer who initiated the return.',
    `account_site_id` BIGINT COMMENT 'Foreign key linking to customer.account_site. Business justification: RMAs in industrial manufacturing originate from a specific customer production site. Linking to account_site enables site-level return rate analytics, reverse logistics routing, and site safety classi',
    `contract_id` BIGINT COMMENT 'Foreign key linking to sales.sales_contract. Business justification: RMA processing in industrial manufacturing requires validation against the originating sales contracts warranty terms, liability cap, and SLA clauses. Warranty claim authorization and credit memo iss',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Return processing expense: RMA costs (inspection, restocking) are charged to a cost center for warranty expense reporting.',
    `customer_contact_id` BIGINT COMMENT 'Foreign key linking to customer.customer_contact. Business justification: RMA initiation and approval workflows in industrial manufacturing require tracking the specific customer contact (quality engineer or procurement manager) who raised the return. Enables RMA communicat',
    `equipment_register_id` BIGINT COMMENT 'Foreign key linking to asset.equipment_register. Business justification: Warranty and equipment return process: when a customer returns capital equipment (automation systems, electrification components), the RMA must reference the specific asset register entry to track dis',
    `header_id` BIGINT COMMENT 'Identifier of the original sales order linked to this RMA.',
    `lot_batch_id` BIGINT COMMENT 'Foreign key linking to inventory.lot_batch. Business justification: RMA processing in manufacturing requires identifying the original lot/batch of returned goods for quality disposition decisions, batch recall management, and restock vs. scrap determination. Domain ex',
    `material_master_id` BIGINT COMMENT 'Identifier of the product to be sent as a replacement, if applicable.',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to supplier.purchase_order. Business justification: Supplier return/debit memo process: when a customer RMA involves defective supplier-sourced goods, the manufacturer must reference the originating purchase order to raise a supplier return authorizati',
    `address_id` BIGINT COMMENT 'Foreign key linking to customer.address. Business justification: RMA logistics in industrial manufacturing require the validated physical address from which goods are returned for carrier scheduling, hazmat compliance, and customs documentation. Role-prefix return',
    `stock_location_id` BIGINT COMMENT 'Foreign key linking to inventory.stock_location. Business justification: Returned goods in manufacturing must be directed to a specific stock location (quarantine bin, returns area, inspection zone) for putaway execution and quality inspection workflows. return_plant is a ',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to supplier.supplier. Business justification: RMA returns are sent back to the original supplier; essential for warranty claim processing and supplier return metrics.',
    `actual_return_date` DATE COMMENT 'Date the returned items were actually received.',
    `approval_status` STRING COMMENT 'Current approval state of the RMA.. Valid values are `pending|approved|rejected`',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when the RMA was approved.',
    `authorized_quantity` STRING COMMENT 'Quantity of items the system authorizes for return based on the original order.',
    `carrier_name` STRING COMMENT 'Name of the logistics carrier handling the return shipment.',
    `credit_amount` DECIMAL(18,2) COMMENT 'Total credit to be applied to the customers account.',
    `credit_memo_indicator` BOOLEAN COMMENT 'Flag indicating whether a credit memo will be issued for this RMA.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for monetary values.. Valid values are `^[A-Z]{3}$`',
    `expected_return_date` DATE COMMENT 'Planned date by which the returned items should arrive at the plant.',
    `handling_fee` DECIMAL(18,2) COMMENT 'Fee charged for processing the return.',
    `inspection_required` BOOLEAN COMMENT 'Indicates if the returned items must undergo quality inspection.',
    `is_damaged` BOOLEAN COMMENT 'True if the returned item was received with damage.',
    `is_repairable` BOOLEAN COMMENT 'True if the returned item can be repaired rather than replaced.',
    `is_warranty_claim` BOOLEAN COMMENT 'True if the return is processed under a warranty agreement.',
    `is_wrong_item` BOOLEAN COMMENT 'True if the returned item does not match the original order.',
    `net_amount` DECIMAL(18,2) COMMENT 'Net monetary amount after tax and fees.',
    `notes` STRING COMMENT 'Free‑form notes entered by service or sales staff.',
    `order_rma_status` STRING COMMENT 'Current lifecycle state of the RMA.. Valid values are `open|approved|rejected|closed|cancelled`',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when the RMA record was first created in the system.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent update to the RMA record.',
    `refund_amount` DECIMAL(18,2) COMMENT 'Monetary amount to be refunded to the customer before taxes and fees.',
    `rejection_reason` STRING COMMENT 'Explanation provided when an RMA is rejected.',
    `replacement_quantity` STRING COMMENT 'Quantity of replacement units to be shipped.',
    `request_timestamp` TIMESTAMP COMMENT 'Date and time when the RMA was initially requested by the customer or service team.',
    `return_reason_code` STRING COMMENT 'Standardized code representing why the product is being returned.. Valid values are `defect|damage|wrong_item|warranty|other`',
    `return_reason_description` STRING COMMENT 'Free-text description providing details about the return reason.',
    `returned_quantity` STRING COMMENT 'Actual number of units received back from the customer.',
    `rma_number` STRING COMMENT 'Business-visible RMA number assigned by the order management system.',
    `rma_type` STRING COMMENT 'Classification of the RMA (e.g., warranty, non‑warranty, repair, replacement).. Valid values are `warranty|non_warranty|repair|replace`',
    `shipping_method` STRING COMMENT 'Method used to ship the returned product back to the plant.. Valid values are `ground|air|sea|pickup`',
    `tax_amount` DECIMAL(18,2) COMMENT 'Tax component associated with the refund or credit.',
    `tracking_number` STRING COMMENT 'Tracking identifier provided by the carrier for the return shipment.',
    CONSTRAINT pk_rma PRIMARY KEY(`rma_id`)
) COMMENT 'Return Material Authorization record managing the end-to-end return process for defective, damaged, or incorrectly shipped industrial products and automation systems. Captures RMA number, originating sales order reference, return reason code (quality defect, shipping damage, wrong item, warranty claim), authorized return quantity, return plant, credit memo indicator, inspection requirement flag, and RMA status. Integrates with returns processing workflows and quality non-conformance reporting.';

CREATE OR REPLACE TABLE `manufacturing_ecm`.`order`.`rma_line` (
    `rma_line_id` BIGINT COMMENT 'System-generated unique identifier for the RMA line item.',
    `component_id` BIGINT COMMENT 'Foreign key linking to engineering.component. Business justification: Links returned items to the original engineered component for warranty claim evaluation and root‑cause analysis.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Line‑level return cost allocation: each returned item’s cost is tracked against a cost center for detailed RMA cost analysis.',
    `delivery_id` BIGINT COMMENT 'Identifier of the delivery that originally supplied the returned material.',
    `engineering_revision_id` BIGINT COMMENT 'Foreign key linking to engineering.engineering_revision. Business justification: RMA lines must reference the engineering revision of the returned item to support failure analysis by revision, warranty eligibility determination, and ECO/ECN triggering. Industrial manufacturing qua',
    `equipment_register_id` BIGINT COMMENT 'Foreign key linking to asset.equipment_register. Business justification: Serialized asset return tracking: each RMA line item for serialized industrial equipment must reference the specific equipment_register entry to support warranty claim processing, asset disposition de',
    `header_id` BIGINT COMMENT 'Sales order identifier for the replacement item shipped to the customer.',
    `lot_batch_id` BIGINT COMMENT 'Foreign key linking to inventory.lot_batch. Business justification: RMA lines in manufacturing track returned batch-controlled materials; linking to lot_batch enables quality inspection at batch level, restock or scrap disposition, and batch traceability for regulator',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to inventory.material_master. Business justification: RMA line processing requires the material master for valuation of returned goods, restocking decisions, and disposition routing in manufacturing. material_description is a denormalized representation;',
    `order_line_id` BIGINT COMMENT 'Foreign key linking to order.line. Business justification: An rma_line represents the return of a specific order line item. rma_line already has order_header_id and order_rma_id, but lacks a direct FK to the originating order line (order.line.line_id). This F',
    `po_line_item_id` BIGINT COMMENT 'Foreign key linking to supplier.po_line_item. Business justification: Granular supplier return traceability: each RMA line must trace to the specific PO line item to determine supplier liability, trigger debit memos, and support warranty/quality claims. Industrial manuf',
    `production_work_order_id` BIGINT COMMENT 'Identifier of the work order created for reworking the returned item.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: P&L impact of returns: RMA line credit amounts must be allocated to the originating profit center for accurate segment P&L reporting in industrial manufacturing. Warranty and return costs are tracked ',
    `stock_location_id` BIGINT COMMENT 'Foreign key linking to inventory.stock_location. Business justification: RMA line putaway execution requires a direct reference to the target stock_location for restocking returned goods. restock_location, restock_bin, and restock_warehouse are denormalized representations',
    `rma_id` BIGINT COMMENT 'Identifier of the parent RMA document to which this line belongs.',
    `serialized_unit_id` BIGINT COMMENT 'Foreign key linking to inventory.serialized_unit. Business justification: For serialized industrial equipment returns, the RMA line must reference the specific serialized unit to update asset status (returned, under repair, scrapped) and validate warranty claims. serial_num',
    `sku_master_id` BIGINT COMMENT 'Foreign key linking to product.sku_master. Business justification: RMA processing in industrial manufacturing requires the specific SKU to drive disposition (repair/scrap/restock), credit memo calculation, and replacement fulfillment. A domain expert expects rma_line',
    `condition_code` STRING COMMENT 'Code indicating the physical condition of the returned item (e.g., new, damaged, used).',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the RMA line record was created in the system.',
    `credit_amount` DECIMAL(18,2) COMMENT 'Monetary credit to be issued to the customer for this line.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for the credit amount (e.g., USD, EUR).',
    `disposition_action` STRING COMMENT 'Business decision for the returned item: scrap, rework, restock, or replace.. Valid values are `scrap|rework|restock|replace`',
    `disposition_reason` STRING COMMENT 'Narrative explanation for the chosen disposition action.',
    `inspection_required_flag` BOOLEAN COMMENT 'Indicates whether the returned item must undergo quality inspection.',
    `inspection_status` STRING COMMENT 'Current status of the quality inspection for the returned item.. Valid values are `pending|passed|failed`',
    `line_number` STRING COMMENT 'Sequential number of the line within the RMA document.',
    `notes` STRING COMMENT 'Free‑form text field for additional comments or special handling instructions.',
    `original_delivery_date` DATE COMMENT 'Date on which the original delivery was posted.',
    `received_date` DATE COMMENT 'Date the returned material was received at the warehouse.',
    `replace_flag` BOOLEAN COMMENT 'True if the returned item will be replaced with a new unit.',
    `replacement_part_number` STRING COMMENT 'Material number of the replacement part, if a replace action is selected.',
    `restock_quantity` DECIMAL(18,2) COMMENT 'Quantity of the item to be returned to inventory after disposition.',
    `restock_status` STRING COMMENT 'Current processing status of the restocking operation.. Valid values are `pending|completed|error`',
    `return_date` DATE COMMENT 'Date the customer initiated the return request.',
    `return_reason_code` STRING COMMENT 'Standardized code describing why the material is being returned.',
    `return_reason_description` STRING COMMENT 'Detailed description of the return reason.',
    `returned_quantity` DECIMAL(18,2) COMMENT 'Quantity of the material being returned on this line.',
    `rework_flag` BOOLEAN COMMENT 'True if the item requires rework before it can be restocked.',
    `scrap_flag` BOOLEAN COMMENT 'True if the returned item is to be scrapped.',
    `scrap_reason` STRING COMMENT 'Explanation for why the item is being scrapped.',
    `unit_of_measure` STRING COMMENT 'Unit of measure for the returned quantity (e.g., EA, KG, L).',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent update to the RMA line record.',
    `warranty_claim_flag` BOOLEAN COMMENT 'True if the return is covered under a warranty claim.',
    `warranty_claim_number` STRING COMMENT 'Identifier of the warranty claim associated with this return.',
    CONSTRAINT pk_rma_line PRIMARY KEY(`rma_line_id`)
) COMMENT 'Individual line item within an RMA document specifying the material, quantity, and disposition instructions for each returned product. Captures RMA line number, material number, returned quantity, original delivery reference, serial numbers, batch number, condition code, disposition action (scrap, rework, restock, replace), and credit value. Supports quality inspection routing and inventory reintegration decisions.';

CREATE OR REPLACE TABLE `manufacturing_ecm`.`order`.`goods_issue` (
    `goods_issue_id` BIGINT COMMENT 'Primary key for goods_issue',
    `account_id` BIGINT COMMENT 'Identifier of the customer receiving the goods.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Manufacturing cost allocation: goods_issue stores cost_center as plain text (denormalized). A proper FK to finance.cost_center enables overhead allocation, cost center variance reporting, and invent',
    `delivery_id` BIGINT COMMENT 'Foreign key linking to order.delivery. Business justification: A goods issue posting is always triggered by an outbound delivery document in SAP SD. goods_issue.delivery_doc_number is a denormalized STRING reference to the delivery document number; normalizing th',
    `header_id` BIGINT COMMENT 'Foreign key linking to order.order_header. Business justification: Link goods issue to the order header for end‑to‑end tracking, removing redundant sales order number.',
    `journal_entry_id` BIGINT COMMENT 'Foreign key linking to finance.journal_entry. Business justification: Inventory valuation and COGS recognition: every goods issue in manufacturing triggers a journal entry (debit COGS, credit inventory). Auditors and controllers require direct traceability from goods mo',
    `lot_batch_id` BIGINT COMMENT 'Foreign key linking to inventory.lot_batch. Business justification: Goods issues in batch-managed manufacturing must reference the specific lot_batch for FIFO-controlled inventory depletion, batch traceability reporting, and quality recall processes. batch_number is a',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to inventory.material_master. Business justification: Goods issue posting in manufacturing ERP requires the material master for inventory deduction, valuation class determination, and GL account assignment. Domain experts universally expect this FK. mate',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: COGS-by-segment reporting: goods_issue currently stores profit_center as a plain text attribute (denormalized). A proper FK to finance.profit_center enables manufacturing controllers to report COGS ',
    `serialized_unit_id` BIGINT COMMENT 'Foreign key linking to inventory.serialized_unit. Business justification: For serialized industrial assets, goods issue must reference the specific serialized unit to update stock status from available to shipped and enable asset lifecycle tracking. serial_number is a d',
    `sku_master_id` BIGINT COMMENT 'Foreign key linking to product.sku_master. Business justification: Goods issue postings in industrial manufacturing must be traceable to the specific SKU for COGS posting, inventory valuation, and regulatory traceability. material_number is a denormalized text repres',
    `stock_location_id` BIGINT COMMENT 'Foreign key linking to inventory.stock_location. Business justification: Goods issue transaction records the originating stock location, essential for inventory decrement, audit trails, and compliance reporting.',
    `actual_delivery_date` DATE COMMENT 'Date when the goods were actually delivered to the customer.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this record was first created in the lakehouse.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 currency code for the monetary values.. Valid values are `USD|EUR|JPY|CNY|GBP|CHF`',
    `delivery_date` DATE COMMENT 'Planned date for delivery to the customer.',
    `expected_delivery_date` DATE COMMENT 'System‑calculated expected delivery date based on lead times.',
    `external_reference` STRING COMMENT 'Reference to external system such as carrier tracking number.',
    `goods_issue_status` STRING COMMENT 'Current lifecycle status of the goods issue.. Valid values are `posted|reversed|pending|cancelled`',
    `handling_unit` STRING COMMENT 'Identifier of the handling unit (e.g., pallet) used for the issue.',
    `incoterms` STRING COMMENT 'International commercial terms governing delivery responsibilities.. Valid values are `EXW|FCA|CPT|CIP|DAP|DDP`',
    `inventory_account` STRING COMMENT 'General ledger account for inventory posting.',
    `is_automated` BOOLEAN COMMENT 'Indicates whether the goods issue was generated automatically by a system.',
    `issue_number` STRING COMMENT 'External document number assigned to the goods issue.',
    `movement_type` STRING COMMENT 'SAP movement type code indicating the nature of the goods issue.. Valid values are `101|102|201|202`',
    `net_amount` DECIMAL(18,2) COMMENT 'Net monetary amount after tax.',
    `plant` STRING COMMENT 'Plant where the goods issue originated.',
    `posting_reason` STRING COMMENT 'Reason for the goods issue posting.. Valid values are `normal|return|scrap|transfer`',
    `posting_timestamp` TIMESTAMP COMMENT 'Timestamp when the goods issue was posted in the source system.',
    `purchase_order_number` STRING COMMENT 'Purchase order associated with the material movement, if applicable.',
    `quality_status` STRING COMMENT 'Quality inspection result for the issued material.. Valid values are `accepted|rejected|pending`',
    `quantity` DECIMAL(18,2) COMMENT 'Quantity of material issued.',
    `remarks` STRING COMMENT 'Additional free‑text notes about the goods issue.',
    `reversal_indicator` BOOLEAN COMMENT 'Flag indicating whether this record is a reversal of a previous goods issue.',
    `route` STRING COMMENT 'Planned transportation route for the shipment.',
    `shipping_point` STRING COMMENT 'Logistics shipping point from which the goods are dispatched.',
    `source_system` STRING COMMENT 'Originating source system that created the goods issue record.. Valid values are `SAP|MES|ERP`',
    `storage_location` STRING COMMENT 'Storage location from which the goods were issued.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Tax amount applicable to the goods issue, if any.',
    `total_value_cost` DECIMAL(18,2) COMMENT 'Total monetary value of the issued goods at standard cost.',
    `uom` STRING COMMENT 'Unit of measure for the issued quantity.. Valid values are `EA|KG|L|M|PCS|SET`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to this record.',
    `valuation_area` STRING COMMENT 'Organizational area for inventory valuation.',
    `valuation_type` STRING COMMENT 'Method used for inventory valuation of the issued material.. Valid values are `standard|moving|periodic`',
    CONSTRAINT pk_goods_issue PRIMARY KEY(`goods_issue_id`)
) COMMENT 'Goods issue posting event recording the physical departure of finished goods, automation systems, or components from a plant or warehouse against an outbound delivery document. Captures goods issue document number, posting date, movement type (standard issue, reversal), plant, storage location, material document number, total value at cost, and goods issue status. Triggers inventory reduction, revenue recognition eligibility, COGS posting, and billing due list creation. Represents the legal transfer of custody from manufacturer to carrier.';

CREATE OR REPLACE TABLE `manufacturing_ecm`.`order`.`blanket_order` (
    `blanket_order_id` BIGINT COMMENT 'System-generated unique identifier for the blanket order.',
    `account_id` BIGINT COMMENT 'Internal identifier of the customer that owns the blanket agreement.',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: Multi-entity blanket order management: blanket orders in industrial manufacturing groups are issued by a specific legal entity for intercompany procurement, statutory spend reporting, and tax complian',
    `contract_id` BIGINT COMMENT 'Foreign key linking to sales.sales_contract. Business justification: Blanket orders in industrial manufacturing are always backed by a master sales contract (frame agreement) that defines pricing, delivery schedules, and liability terms. Contract compliance tracking, r',
    `customer_contact_id` BIGINT COMMENT 'Foreign key linking to customer.customer_contact. Business justification: Blanket orders in industrial manufacturing have a designated customer procurement or supply chain contact who authorizes releases and manages the agreement. This contact is essential for release appro',
    `address_id` BIGINT COMMENT 'Foreign key linking to customer.address. Business justification: Blanket orders in industrial manufacturing specify a default ship-to address for all scheduled releases. Linking to the customer address master enables release scheduling, logistics planning, and dock',
    `supplier_id` BIGINT COMMENT 'Foreign key linking to supplier.supplier. Business justification: A blanket purchase agreement is negotiated with a specific supplier; needed for contract management and spend analysis.',
    `agreement_description` STRING COMMENT 'Free‑text description providing context or special notes about the blanket order.',
    `approval_timestamp` TIMESTAMP COMMENT 'Timestamp when the blanket order received formal approval.',
    `approved_by` STRING COMMENT 'User identifier of the person who approved the blanket order.',
    `blanket_order_status` STRING COMMENT 'Current lifecycle state of the blanket order.. Valid values are `active|inactive|suspended|closed|draft`',
    `contract_status_reason` STRING COMMENT 'Free‑text explanation for the current status of the agreement.',
    `contract_type` STRING COMMENT 'Category of the agreement defining its purpose and governing rules.. Valid values are `scheduling|framework|blanket|service`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the blanket order record was first created in the system.',
    `cumulative_released_quantity` DECIMAL(18,2) COMMENT 'Total quantity that has been released to the customer to date.',
    `cumulative_released_value` DECIMAL(18,2) COMMENT 'Monetary value of all released quantities to date.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 code of the currency used for the agreement.. Valid values are `^[A-Z]{3}$`',
    `distribution_channel` STRING COMMENT 'Channel through which the products will be delivered (e.g., wholesale, direct).',
    `effective_from` DATE COMMENT 'Date on which the blanket agreement becomes binding.',
    `effective_until` DATE COMMENT 'Date on which the blanket agreement expires or is terminated (null for open‑ended).',
    `is_jit_enabled` BOOLEAN COMMENT 'Indicates whether the agreement supports JIT delivery scheduling.',
    `last_release_date` DATE COMMENT 'Date of the most recent call‑off release.',
    `minimum_order_quantity` DECIMAL(18,2) COMMENT 'Smallest quantity the customer may release in a single call‑off.',
    `minimum_order_uom` STRING COMMENT 'Unit of measure for the minimum order quantity.. Valid values are `EA|KG|L|M|M2|M3`',
    `next_release_due_date` DATE COMMENT 'Planned date for the next scheduled release based on the release frequency.',
    `plant` STRING COMMENT 'Manufacturing plant responsible for fulfilling releases under the agreement.',
    `pricing_conditions` STRING COMMENT 'Textual description of pricing terms, discounts, and rebates applicable to the agreement.',
    `quantity_uom` STRING COMMENT 'Unit of measure for the committed quantity (e.g., each, kilogram).. Valid values are `EA|KG|L|M|M2|M3`',
    `region` STRING COMMENT 'Geographic region (e.g., NA, EU) applicable to the agreement.',
    `release_frequency` STRING COMMENT 'Scheduled interval at which the customer may release call‑offs against the blanket order.. Valid values are `monthly|quarterly|weekly|on_demand`',
    `sales_organization` STRING COMMENT 'Organizational unit responsible for the sales side of the agreement.',
    `total_committed_quantity` DECIMAL(18,2) COMMENT 'Aggregate quantity of product(s) the customer has committed to purchase over the agreement period.',
    `total_committed_value` DECIMAL(18,2) COMMENT 'Monetary value of the total committed quantity at the agreed pricing.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the blanket order record.',
    CONSTRAINT pk_blanket_order PRIMARY KEY(`blanket_order_id`)
) COMMENT 'Long-term supply agreement or scheduling agreement from an industrial customer committing to purchase a defined quantity of products over a specified period at agreed pricing. Captures blanket order number, customer account, validity start and end dates, total committed quantity, total committed value, release frequency, minimum order quantity (MOQ), pricing conditions, and cumulative released quantity to date. Contains individual release call-offs as line-level records with release number, release date, quantity, requested delivery date, cumulative released quantity, and release status. Supports demand planning, JIT delivery scheduling, and production scheduling for high-volume OEM customers.';

CREATE OR REPLACE TABLE `manufacturing_ecm`.`order`.`blanket_order_release` (
    `blanket_order_release_id` BIGINT COMMENT 'System-generated unique identifier for the blanket order release record.',
    `account_site_id` BIGINT COMMENT 'Foreign key linking to customer.account_site. Business justification: Blanket order releases in industrial manufacturing are triggered for specific customer factory sites (JIT replenishment). Linking to account_site enables site-level release scheduling, capacity planni',
    `blanket_order_id` BIGINT COMMENT 'Identifier of the parent blanket order (scheduling agreement) to which this release belongs.',
    `header_id` BIGINT COMMENT 'Foreign key linking to order.order_header. Business justification: A blanket_order_release (call-off against a scheduling agreement) generates a sales order (order_header) in SAP SD. The release is the trigger event; the order_header is the resulting fulfillment docu',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to supplier.purchase_order. Business justification: Each blanket order release triggers a purchase order to the supplier. Procurement and supply chain teams track release-to-PO fulfillment for JIT scheduling, cumulative quantity reconciliation, and bla',
    `sku_master_id` BIGINT COMMENT 'Identifier of the product/material being released for delivery.',
    `blanket_order_release_status` STRING COMMENT 'Current lifecycle status of the release.',
    `release_date` DATE COMMENT 'Date on which the blanket order release was created or issued.',
    `release_number` STRING COMMENT 'Sequential number of the release within the blanket order, used for ordering and tracking.',
    CONSTRAINT pk_blanket_order_release PRIMARY KEY(`blanket_order_release_id`)
) COMMENT 'Individual release call-off against a blanket order or scheduling agreement, specifying the quantity and delivery date for a specific shipment within the long-term supply commitment. Captures release number, blanket order reference, release date, release quantity, requested delivery date, cumulative released quantity, and release status. Enables JIT delivery scheduling and production demand triggering for OEM and high-volume industrial customers.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `manufacturing_ecm`.`order`.`header` ADD CONSTRAINT `fk_order_header_blanket_order_id` FOREIGN KEY (`blanket_order_id`) REFERENCES `manufacturing_ecm`.`order`.`blanket_order`(`blanket_order_id`);
ALTER TABLE `manufacturing_ecm`.`order`.`order_line` ADD CONSTRAINT `fk_order_order_line_header_id` FOREIGN KEY (`header_id`) REFERENCES `manufacturing_ecm`.`order`.`header`(`header_id`);
ALTER TABLE `manufacturing_ecm`.`order`.`schedule_line` ADD CONSTRAINT `fk_order_schedule_line_header_id` FOREIGN KEY (`header_id`) REFERENCES `manufacturing_ecm`.`order`.`header`(`header_id`);
ALTER TABLE `manufacturing_ecm`.`order`.`schedule_line` ADD CONSTRAINT `fk_order_schedule_line_order_line_id` FOREIGN KEY (`order_line_id`) REFERENCES `manufacturing_ecm`.`order`.`order_line`(`order_line_id`);
ALTER TABLE `manufacturing_ecm`.`order`.`delivery` ADD CONSTRAINT `fk_order_delivery_header_id` FOREIGN KEY (`header_id`) REFERENCES `manufacturing_ecm`.`order`.`header`(`header_id`);
ALTER TABLE `manufacturing_ecm`.`order`.`delivery_item` ADD CONSTRAINT `fk_order_delivery_item_delivery_id` FOREIGN KEY (`delivery_id`) REFERENCES `manufacturing_ecm`.`order`.`delivery`(`delivery_id`);
ALTER TABLE `manufacturing_ecm`.`order`.`delivery_item` ADD CONSTRAINT `fk_order_delivery_item_order_line_id` FOREIGN KEY (`order_line_id`) REFERENCES `manufacturing_ecm`.`order`.`order_line`(`order_line_id`);
ALTER TABLE `manufacturing_ecm`.`order`.`delivery_item` ADD CONSTRAINT `fk_order_delivery_item_schedule_line_id` FOREIGN KEY (`schedule_line_id`) REFERENCES `manufacturing_ecm`.`order`.`schedule_line`(`schedule_line_id`);
ALTER TABLE `manufacturing_ecm`.`order`.`rma` ADD CONSTRAINT `fk_order_rma_header_id` FOREIGN KEY (`header_id`) REFERENCES `manufacturing_ecm`.`order`.`header`(`header_id`);
ALTER TABLE `manufacturing_ecm`.`order`.`rma_line` ADD CONSTRAINT `fk_order_rma_line_delivery_id` FOREIGN KEY (`delivery_id`) REFERENCES `manufacturing_ecm`.`order`.`delivery`(`delivery_id`);
ALTER TABLE `manufacturing_ecm`.`order`.`rma_line` ADD CONSTRAINT `fk_order_rma_line_header_id` FOREIGN KEY (`header_id`) REFERENCES `manufacturing_ecm`.`order`.`header`(`header_id`);
ALTER TABLE `manufacturing_ecm`.`order`.`rma_line` ADD CONSTRAINT `fk_order_rma_line_order_line_id` FOREIGN KEY (`order_line_id`) REFERENCES `manufacturing_ecm`.`order`.`order_line`(`order_line_id`);
ALTER TABLE `manufacturing_ecm`.`order`.`rma_line` ADD CONSTRAINT `fk_order_rma_line_rma_id` FOREIGN KEY (`rma_id`) REFERENCES `manufacturing_ecm`.`order`.`rma`(`rma_id`);
ALTER TABLE `manufacturing_ecm`.`order`.`goods_issue` ADD CONSTRAINT `fk_order_goods_issue_delivery_id` FOREIGN KEY (`delivery_id`) REFERENCES `manufacturing_ecm`.`order`.`delivery`(`delivery_id`);
ALTER TABLE `manufacturing_ecm`.`order`.`goods_issue` ADD CONSTRAINT `fk_order_goods_issue_header_id` FOREIGN KEY (`header_id`) REFERENCES `manufacturing_ecm`.`order`.`header`(`header_id`);
ALTER TABLE `manufacturing_ecm`.`order`.`blanket_order_release` ADD CONSTRAINT `fk_order_blanket_order_release_blanket_order_id` FOREIGN KEY (`blanket_order_id`) REFERENCES `manufacturing_ecm`.`order`.`blanket_order`(`blanket_order_id`);
ALTER TABLE `manufacturing_ecm`.`order`.`blanket_order_release` ADD CONSTRAINT `fk_order_blanket_order_release_header_id` FOREIGN KEY (`header_id`) REFERENCES `manufacturing_ecm`.`order`.`header`(`header_id`);

-- ========= TAGS =========
ALTER SCHEMA `manufacturing_ecm`.`order` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `manufacturing_ecm`.`order` SET TAGS ('dbx_domain' = 'order');
ALTER TABLE `manufacturing_ecm`.`order`.`header` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `manufacturing_ecm`.`order`.`header` SET TAGS ('dbx_subdomain' = 'order_management');
ALTER TABLE `manufacturing_ecm`.`order`.`header` ALTER COLUMN `header_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Order ID');
ALTER TABLE `manufacturing_ecm`.`order`.`header` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `manufacturing_ecm`.`order`.`header` ALTER COLUMN `account_site_id` SET TAGS ('dbx_business_glossary_term' = 'Installation Site Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`order`.`header` ALTER COLUMN `blanket_order_id` SET TAGS ('dbx_business_glossary_term' = 'Blanket Order Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`order`.`header` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`order`.`header` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Contract Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`order`.`header` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`order`.`header` ALTER COLUMN `customer_contact_id` SET TAGS ('dbx_business_glossary_term' = 'Contact Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`order`.`header` ALTER COLUMN `opportunity_id` SET TAGS ('dbx_business_glossary_term' = 'Opportunity Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`order`.`header` ALTER COLUMN `order_intake_id` SET TAGS ('dbx_business_glossary_term' = 'Order Intake Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`order`.`header` ALTER COLUMN `price_book_id` SET TAGS ('dbx_business_glossary_term' = 'Price Book Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`order`.`header` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`order`.`header` ALTER COLUMN `project_id` SET TAGS ('dbx_business_glossary_term' = 'Engineering Project Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`order`.`header` ALTER COLUMN `quote_id` SET TAGS ('dbx_business_glossary_term' = 'Quote Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`order`.`header` ALTER COLUMN `rep_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Rep Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`order`.`header` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Territory Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`order`.`header` ALTER COLUMN `address_id` SET TAGS ('dbx_business_glossary_term' = 'Shipping Address Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`order`.`header` ALTER COLUMN `address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `manufacturing_ecm`.`order`.`header` ALTER COLUMN `address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `manufacturing_ecm`.`order`.`header` ALTER COLUMN `sla_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Sla Agreement Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`order`.`header` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`order`.`header` ALTER COLUMN `billing_block` SET TAGS ('dbx_business_glossary_term' = 'Billing Block');
ALTER TABLE `manufacturing_ecm`.`order`.`header` ALTER COLUMN `credit_status` SET TAGS ('dbx_business_glossary_term' = 'Credit Status');
ALTER TABLE `manufacturing_ecm`.`order`.`header` ALTER COLUMN `credit_status` SET TAGS ('dbx_value_regex' = 'unblocked|blocked|on_hold');
ALTER TABLE `manufacturing_ecm`.`order`.`header` ALTER COLUMN `currency_rate` SET TAGS ('dbx_business_glossary_term' = 'Currency Exchange Rate');
ALTER TABLE `manufacturing_ecm`.`order`.`header` ALTER COLUMN `customer_account_group` SET TAGS ('dbx_business_glossary_term' = 'Customer Account Group');
ALTER TABLE `manufacturing_ecm`.`order`.`header` ALTER COLUMN `customer_purchase_order_date` SET TAGS ('dbx_business_glossary_term' = 'Customer Purchase Order Date');
ALTER TABLE `manufacturing_ecm`.`order`.`header` ALTER COLUMN `delivery_block` SET TAGS ('dbx_business_glossary_term' = 'Delivery Block');
ALTER TABLE `manufacturing_ecm`.`order`.`header` ALTER COLUMN `distribution_channel` SET TAGS ('dbx_business_glossary_term' = 'Distribution Channel');
ALTER TABLE `manufacturing_ecm`.`order`.`header` ALTER COLUMN `division` SET TAGS ('dbx_business_glossary_term' = 'Division');
ALTER TABLE `manufacturing_ecm`.`order`.`header` ALTER COLUMN `freight_terms` SET TAGS ('dbx_business_glossary_term' = 'Freight Terms');
ALTER TABLE `manufacturing_ecm`.`order`.`header` ALTER COLUMN `gross_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Gross Weight (kg)');
ALTER TABLE `manufacturing_ecm`.`order`.`header` ALTER COLUMN `incoterms` SET TAGS ('dbx_business_glossary_term' = 'Incoterms');
ALTER TABLE `manufacturing_ecm`.`order`.`header` ALTER COLUMN `internal_comments` SET TAGS ('dbx_business_glossary_term' = 'Internal Comments');
ALTER TABLE `manufacturing_ecm`.`order`.`header` ALTER COLUMN `net_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Net Weight (kg)');
ALTER TABLE `manufacturing_ecm`.`order`.`header` ALTER COLUMN `order_currency` SET TAGS ('dbx_business_glossary_term' = 'Order Currency');
ALTER TABLE `manufacturing_ecm`.`order`.`header` ALTER COLUMN `order_number` SET TAGS ('dbx_business_glossary_term' = 'Order Number');
ALTER TABLE `manufacturing_ecm`.`order`.`header` ALTER COLUMN `order_placed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Order Placed Timestamp');
ALTER TABLE `manufacturing_ecm`.`order`.`header` ALTER COLUMN `order_priority` SET TAGS ('dbx_business_glossary_term' = 'Order Priority');
ALTER TABLE `manufacturing_ecm`.`order`.`header` ALTER COLUMN `order_priority` SET TAGS ('dbx_value_regex' = 'low|medium|high|urgent');
ALTER TABLE `manufacturing_ecm`.`order`.`header` ALTER COLUMN `order_reason` SET TAGS ('dbx_business_glossary_term' = 'Order Reason');
ALTER TABLE `manufacturing_ecm`.`order`.`header` ALTER COLUMN `order_status` SET TAGS ('dbx_business_glossary_term' = 'Order Status');
ALTER TABLE `manufacturing_ecm`.`order`.`header` ALTER COLUMN `order_text` SET TAGS ('dbx_business_glossary_term' = 'Order Text');
ALTER TABLE `manufacturing_ecm`.`order`.`header` ALTER COLUMN `order_type` SET TAGS ('dbx_business_glossary_term' = 'Order Type');
ALTER TABLE `manufacturing_ecm`.`order`.`header` ALTER COLUMN `order_type` SET TAGS ('dbx_value_regex' = 'standard|rush|blanket|consignment');
ALTER TABLE `manufacturing_ecm`.`order`.`header` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `manufacturing_ecm`.`order`.`header` ALTER COLUMN `price_group` SET TAGS ('dbx_business_glossary_term' = 'Price Group');
ALTER TABLE `manufacturing_ecm`.`order`.`header` ALTER COLUMN `pricing_date` SET TAGS ('dbx_business_glossary_term' = 'Pricing Date');
ALTER TABLE `manufacturing_ecm`.`order`.`header` ALTER COLUMN `purchase_order_number` SET TAGS ('dbx_business_glossary_term' = 'Customer Purchase Order Number');
ALTER TABLE `manufacturing_ecm`.`order`.`header` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Created');
ALTER TABLE `manufacturing_ecm`.`order`.`header` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Updated');
ALTER TABLE `manufacturing_ecm`.`order`.`header` ALTER COLUMN `requested_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Requested Delivery Date');
ALTER TABLE `manufacturing_ecm`.`order`.`header` ALTER COLUMN `route` SET TAGS ('dbx_business_glossary_term' = 'Transportation Route');
ALTER TABLE `manufacturing_ecm`.`order`.`header` ALTER COLUMN `sales_document_type` SET TAGS ('dbx_business_glossary_term' = 'Sales Document Type');
ALTER TABLE `manufacturing_ecm`.`order`.`header` ALTER COLUMN `sales_group` SET TAGS ('dbx_business_glossary_term' = 'Sales Group');
ALTER TABLE `manufacturing_ecm`.`order`.`header` ALTER COLUMN `sales_office` SET TAGS ('dbx_business_glossary_term' = 'Sales Office');
ALTER TABLE `manufacturing_ecm`.`order`.`header` ALTER COLUMN `sales_organization` SET TAGS ('dbx_business_glossary_term' = 'Sales Organization');
ALTER TABLE `manufacturing_ecm`.`order`.`header` ALTER COLUMN `shipping_condition` SET TAGS ('dbx_business_glossary_term' = 'Shipping Condition');
ALTER TABLE `manufacturing_ecm`.`order`.`header` ALTER COLUMN `shipping_condition` SET TAGS ('dbx_value_regex' = 'standard|express|pickup');
ALTER TABLE `manufacturing_ecm`.`order`.`header` ALTER COLUMN `shipping_point` SET TAGS ('dbx_business_glossary_term' = 'Shipping Point');
ALTER TABLE `manufacturing_ecm`.`order`.`header` ALTER COLUMN `tax_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Code');
ALTER TABLE `manufacturing_ecm`.`order`.`header` ALTER COLUMN `total_gross_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Gross Amount');
ALTER TABLE `manufacturing_ecm`.`order`.`header` ALTER COLUMN `total_net_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Net Amount');
ALTER TABLE `manufacturing_ecm`.`order`.`header` ALTER COLUMN `total_tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Tax Amount');
ALTER TABLE `manufacturing_ecm`.`order`.`header` ALTER COLUMN `transportation_group` SET TAGS ('dbx_business_glossary_term' = 'Transportation Group');
ALTER TABLE `manufacturing_ecm`.`order`.`header` ALTER COLUMN `volume_m3` SET TAGS ('dbx_business_glossary_term' = 'Volume (m³)');
ALTER TABLE `manufacturing_ecm`.`order`.`order_line` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `manufacturing_ecm`.`order`.`order_line` SET TAGS ('dbx_subdomain' = 'order_management');
ALTER TABLE `manufacturing_ecm`.`order`.`order_line` ALTER COLUMN `order_line_id` SET TAGS ('dbx_business_glossary_term' = 'Order Line Identifier');
ALTER TABLE `manufacturing_ecm`.`order`.`order_line` ALTER COLUMN `account_site_id` SET TAGS ('dbx_business_glossary_term' = 'Account Site Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`order`.`order_line` ALTER COLUMN `bom_id` SET TAGS ('dbx_business_glossary_term' = 'Bom Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`order`.`order_line` ALTER COLUMN `component_id` SET TAGS ('dbx_business_glossary_term' = 'Component Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`order`.`order_line` ALTER COLUMN `configuration_id` SET TAGS ('dbx_business_glossary_term' = 'Configuration Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`order`.`order_line` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`order`.`order_line` ALTER COLUMN `engineering_revision_id` SET TAGS ('dbx_business_glossary_term' = 'Engineering Revision Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`order`.`order_line` ALTER COLUMN `header_id` SET TAGS ('dbx_business_glossary_term' = 'Order Identifier');
ALTER TABLE `manufacturing_ecm`.`order`.`order_line` ALTER COLUMN `lot_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Batch Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`order`.`order_line` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`order`.`order_line` ALTER COLUMN `price_book_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Price Book Entry Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`order`.`order_line` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`order`.`order_line` ALTER COLUMN `quote_line_id` SET TAGS ('dbx_business_glossary_term' = 'Quote Line Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`order`.`order_line` ALTER COLUMN `serialized_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Serialized Unit Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`order`.`order_line` ALTER COLUMN `sku_master_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Master Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`order`.`order_line` ALTER COLUMN `spare_part_id` SET TAGS ('dbx_business_glossary_term' = 'Spare Part Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`order`.`order_line` ALTER COLUMN `stock_location_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Location Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`order`.`order_line` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`order`.`order_line` ALTER COLUMN `actual_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Delivery Date');
ALTER TABLE `manufacturing_ecm`.`order`.`order_line` ALTER COLUMN `backorder_indicator` SET TAGS ('dbx_business_glossary_term' = 'Backorder Indicator');
ALTER TABLE `manufacturing_ecm`.`order`.`order_line` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Number');
ALTER TABLE `manufacturing_ecm`.`order`.`order_line` ALTER COLUMN `blanket_release_number` SET TAGS ('dbx_business_glossary_term' = 'Blanket Release Number');
ALTER TABLE `manufacturing_ecm`.`order`.`order_line` ALTER COLUMN `confirmed_quantity` SET TAGS ('dbx_business_glossary_term' = 'Confirmed Quantity');
ALTER TABLE `manufacturing_ecm`.`order`.`order_line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `manufacturing_ecm`.`order`.`order_line` ALTER COLUMN `currency` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `manufacturing_ecm`.`order`.`order_line` ALTER COLUMN `delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Delivery Date');
ALTER TABLE `manufacturing_ecm`.`order`.`order_line` ALTER COLUMN `delivery_status` SET TAGS ('dbx_business_glossary_term' = 'Delivery Status');
ALTER TABLE `manufacturing_ecm`.`order`.`order_line` ALTER COLUMN `delivery_status` SET TAGS ('dbx_value_regex' = 'pending|shipped|delivered|cancelled|backordered');
ALTER TABLE `manufacturing_ecm`.`order`.`order_line` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount');
ALTER TABLE `manufacturing_ecm`.`order`.`order_line` ALTER COLUMN `distribution_channel` SET TAGS ('dbx_business_glossary_term' = 'Distribution Channel');
ALTER TABLE `manufacturing_ecm`.`order`.`order_line` ALTER COLUMN `division` SET TAGS ('dbx_business_glossary_term' = 'Division');
ALTER TABLE `manufacturing_ecm`.`order`.`order_line` ALTER COLUMN `gross_price` SET TAGS ('dbx_business_glossary_term' = 'Gross Price');
ALTER TABLE `manufacturing_ecm`.`order`.`order_line` ALTER COLUMN `gross_weight` SET TAGS ('dbx_business_glossary_term' = 'Gross Weight');
ALTER TABLE `manufacturing_ecm`.`order`.`order_line` ALTER COLUMN `inspection_status` SET TAGS ('dbx_business_glossary_term' = 'Inspection Status');
ALTER TABLE `manufacturing_ecm`.`order`.`order_line` ALTER COLUMN `inspection_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|completed');
ALTER TABLE `manufacturing_ecm`.`order`.`order_line` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time (Days)');
ALTER TABLE `manufacturing_ecm`.`order`.`order_line` ALTER COLUMN `line_number` SET TAGS ('dbx_business_glossary_term' = 'Line Sequence Number');
ALTER TABLE `manufacturing_ecm`.`order`.`order_line` ALTER COLUMN `net_price` SET TAGS ('dbx_business_glossary_term' = 'Net Price');
ALTER TABLE `manufacturing_ecm`.`order`.`order_line` ALTER COLUMN `net_weight` SET TAGS ('dbx_business_glossary_term' = 'Net Weight');
ALTER TABLE `manufacturing_ecm`.`order`.`order_line` ALTER COLUMN `plant` SET TAGS ('dbx_business_glossary_term' = 'Plant Code');
ALTER TABLE `manufacturing_ecm`.`order`.`order_line` ALTER COLUMN `pricing_condition` SET TAGS ('dbx_business_glossary_term' = 'Pricing Condition');
ALTER TABLE `manufacturing_ecm`.`order`.`order_line` ALTER COLUMN `pricing_condition` SET TAGS ('dbx_value_regex' = 'standard|discount|rebate|surcharge');
ALTER TABLE `manufacturing_ecm`.`order`.`order_line` ALTER COLUMN `product_description` SET TAGS ('dbx_business_glossary_term' = 'Product Description');
ALTER TABLE `manufacturing_ecm`.`order`.`order_line` ALTER COLUMN `promised_date` SET TAGS ('dbx_business_glossary_term' = 'Promised Delivery Date');
ALTER TABLE `manufacturing_ecm`.`order`.`order_line` ALTER COLUMN `quality_score` SET TAGS ('dbx_business_glossary_term' = 'Quality Score');
ALTER TABLE `manufacturing_ecm`.`order`.`order_line` ALTER COLUMN `quality_status` SET TAGS ('dbx_business_glossary_term' = 'Quality Status');
ALTER TABLE `manufacturing_ecm`.`order`.`order_line` ALTER COLUMN `quality_status` SET TAGS ('dbx_value_regex' = 'passed|failed|pending');
ALTER TABLE `manufacturing_ecm`.`order`.`order_line` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `manufacturing_ecm`.`order`.`order_line` ALTER COLUMN `requested_quantity` SET TAGS ('dbx_business_glossary_term' = 'Requested Quantity');
ALTER TABLE `manufacturing_ecm`.`order`.`order_line` ALTER COLUMN `rma_reference` SET TAGS ('dbx_business_glossary_term' = 'Return Material Authorization Reference');
ALTER TABLE `manufacturing_ecm`.`order`.`order_line` ALTER COLUMN `sales_org` SET TAGS ('dbx_business_glossary_term' = 'Sales Organization');
ALTER TABLE `manufacturing_ecm`.`order`.`order_line` ALTER COLUMN `sales_price` SET TAGS ('dbx_business_glossary_term' = 'Sales Price');
ALTER TABLE `manufacturing_ecm`.`order`.`order_line` ALTER COLUMN `sales_quantity` SET TAGS ('dbx_business_glossary_term' = 'Sales Quantity');
ALTER TABLE `manufacturing_ecm`.`order`.`order_line` ALTER COLUMN `schedule_line_date` SET TAGS ('dbx_business_glossary_term' = 'Schedule Line Date');
ALTER TABLE `manufacturing_ecm`.`order`.`order_line` ALTER COLUMN `serial_number` SET TAGS ('dbx_business_glossary_term' = 'Serial Number');
ALTER TABLE `manufacturing_ecm`.`order`.`order_line` ALTER COLUMN `storage_location` SET TAGS ('dbx_business_glossary_term' = 'Storage Location');
ALTER TABLE `manufacturing_ecm`.`order`.`order_line` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `manufacturing_ecm`.`order`.`order_line` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `manufacturing_ecm`.`order`.`order_line` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'EA|KG|L|M|PCS|TON');
ALTER TABLE `manufacturing_ecm`.`order`.`order_line` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `manufacturing_ecm`.`order`.`order_line` ALTER COLUMN `volume` SET TAGS ('dbx_business_glossary_term' = 'Volume');
ALTER TABLE `manufacturing_ecm`.`order`.`order_line` ALTER COLUMN `volume_uom` SET TAGS ('dbx_business_glossary_term' = 'Volume Unit of Measure');
ALTER TABLE `manufacturing_ecm`.`order`.`order_line` ALTER COLUMN `volume_uom` SET TAGS ('dbx_value_regex' = 'M3|L|FT3');
ALTER TABLE `manufacturing_ecm`.`order`.`order_line` ALTER COLUMN `weight_uom` SET TAGS ('dbx_business_glossary_term' = 'Weight Unit of Measure');
ALTER TABLE `manufacturing_ecm`.`order`.`order_line` ALTER COLUMN `weight_uom` SET TAGS ('dbx_value_regex' = 'KG|LB|TON');
ALTER TABLE `manufacturing_ecm`.`order`.`schedule_line` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `manufacturing_ecm`.`order`.`schedule_line` SET TAGS ('dbx_subdomain' = 'order_management');
ALTER TABLE `manufacturing_ecm`.`order`.`schedule_line` ALTER COLUMN `schedule_line_id` SET TAGS ('dbx_business_glossary_term' = 'Order Schedule Line ID');
ALTER TABLE `manufacturing_ecm`.`order`.`schedule_line` ALTER COLUMN `account_site_id` SET TAGS ('dbx_business_glossary_term' = 'Account Site Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`order`.`schedule_line` ALTER COLUMN `header_id` SET TAGS ('dbx_business_glossary_term' = 'Order ID');
ALTER TABLE `manufacturing_ecm`.`order`.`schedule_line` ALTER COLUMN `lot_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Batch Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`order`.`schedule_line` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`order`.`schedule_line` ALTER COLUMN `order_line_id` SET TAGS ('dbx_business_glossary_term' = 'Split Parent Line ID');
ALTER TABLE `manufacturing_ecm`.`order`.`schedule_line` ALTER COLUMN `sku_master_id` SET TAGS ('dbx_business_glossary_term' = 'Product ID');
ALTER TABLE `manufacturing_ecm`.`order`.`schedule_line` ALTER COLUMN `stock_location_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Location Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`order`.`schedule_line` ALTER COLUMN `backorder_indicator` SET TAGS ('dbx_business_glossary_term' = 'Backorder Indicator');
ALTER TABLE `manufacturing_ecm`.`order`.`schedule_line` ALTER COLUMN `confirmed_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Confirmed Delivery Date');
ALTER TABLE `manufacturing_ecm`.`order`.`schedule_line` ALTER COLUMN `confirmed_quantity` SET TAGS ('dbx_business_glossary_term' = 'Confirmed Quantity');
ALTER TABLE `manufacturing_ecm`.`order`.`schedule_line` ALTER COLUMN `confirmed_quantity_uom` SET TAGS ('dbx_business_glossary_term' = 'Confirmed Quantity Unit of Measure');
ALTER TABLE `manufacturing_ecm`.`order`.`schedule_line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `manufacturing_ecm`.`order`.`schedule_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `manufacturing_ecm`.`order`.`schedule_line` ALTER COLUMN `goods_issue_date` SET TAGS ('dbx_business_glossary_term' = 'Goods Issue Date');
ALTER TABLE `manufacturing_ecm`.`order`.`schedule_line` ALTER COLUMN `handling_unit` SET TAGS ('dbx_business_glossary_term' = 'Handling Unit');
ALTER TABLE `manufacturing_ecm`.`order`.`schedule_line` ALTER COLUMN `incoterms` SET TAGS ('dbx_business_glossary_term' = 'Incoterms');
ALTER TABLE `manufacturing_ecm`.`order`.`schedule_line` ALTER COLUMN `incoterms` SET TAGS ('dbx_value_regex' = 'EXW|FCA|FOB|CFR|CIF|DDP');
ALTER TABLE `manufacturing_ecm`.`order`.`schedule_line` ALTER COLUMN `line_net_amount` SET TAGS ('dbx_business_glossary_term' = 'Line Net Amount');
ALTER TABLE `manufacturing_ecm`.`order`.`schedule_line` ALTER COLUMN `mrp_confirmed_availability_date` SET TAGS ('dbx_business_glossary_term' = 'MRP Confirmed Availability Date');
ALTER TABLE `manufacturing_ecm`.`order`.`schedule_line` ALTER COLUMN `plant` SET TAGS ('dbx_business_glossary_term' = 'Plant Code');
ALTER TABLE `manufacturing_ecm`.`order`.`schedule_line` ALTER COLUMN `priority_code` SET TAGS ('dbx_business_glossary_term' = 'Priority Code');
ALTER TABLE `manufacturing_ecm`.`order`.`schedule_line` ALTER COLUMN `priority_code` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `manufacturing_ecm`.`order`.`schedule_line` ALTER COLUMN `requested_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Requested Delivery Date');
ALTER TABLE `manufacturing_ecm`.`order`.`schedule_line` ALTER COLUMN `requested_quantity` SET TAGS ('dbx_business_glossary_term' = 'Requested Quantity');
ALTER TABLE `manufacturing_ecm`.`order`.`schedule_line` ALTER COLUMN `requested_quantity_uom` SET TAGS ('dbx_business_glossary_term' = 'Requested Quantity Unit of Measure');
ALTER TABLE `manufacturing_ecm`.`order`.`schedule_line` ALTER COLUMN `route` SET TAGS ('dbx_business_glossary_term' = 'Transportation Route');
ALTER TABLE `manufacturing_ecm`.`order`.`schedule_line` ALTER COLUMN `schedule_line_number` SET TAGS ('dbx_business_glossary_term' = 'Schedule Line Number');
ALTER TABLE `manufacturing_ecm`.`order`.`schedule_line` ALTER COLUMN `schedule_line_status` SET TAGS ('dbx_business_glossary_term' = 'Schedule Line Status');
ALTER TABLE `manufacturing_ecm`.`order`.`schedule_line` ALTER COLUMN `schedule_line_status` SET TAGS ('dbx_value_regex' = 'confirmed|released|blocked|canceled|pending');
ALTER TABLE `manufacturing_ecm`.`order`.`schedule_line` ALTER COLUMN `serial_number` SET TAGS ('dbx_business_glossary_term' = 'Serial Number');
ALTER TABLE `manufacturing_ecm`.`order`.`schedule_line` ALTER COLUMN `shipping_point` SET TAGS ('dbx_business_glossary_term' = 'Shipping Point');
ALTER TABLE `manufacturing_ecm`.`order`.`schedule_line` ALTER COLUMN `split_indicator` SET TAGS ('dbx_business_glossary_term' = 'Split Indicator');
ALTER TABLE `manufacturing_ecm`.`order`.`schedule_line` ALTER COLUMN `storage_location` SET TAGS ('dbx_business_glossary_term' = 'Storage Location');
ALTER TABLE `manufacturing_ecm`.`order`.`schedule_line` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `manufacturing_ecm`.`order`.`delivery` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `manufacturing_ecm`.`order`.`delivery` SET TAGS ('dbx_subdomain' = 'fulfillment_returns');
ALTER TABLE `manufacturing_ecm`.`order`.`delivery` ALTER COLUMN `delivery_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Identifier');
ALTER TABLE `manufacturing_ecm`.`order`.`delivery` ALTER COLUMN `account_site_id` SET TAGS ('dbx_business_glossary_term' = 'Account Site Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`order`.`delivery` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`order`.`delivery` ALTER COLUMN `customer_contact_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Contact Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`order`.`delivery` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID (CID)');
ALTER TABLE `manufacturing_ecm`.`order`.`delivery` ALTER COLUMN `delivery_ship_to_party_customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Ship‑To Party ID (STPID)');
ALTER TABLE `manufacturing_ecm`.`order`.`delivery` ALTER COLUMN `header_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Order Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`order`.`delivery` ALTER COLUMN `address_id` SET TAGS ('dbx_business_glossary_term' = 'Ship To Address Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`order`.`delivery` ALTER COLUMN `address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `manufacturing_ecm`.`order`.`delivery` ALTER COLUMN `address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `manufacturing_ecm`.`order`.`delivery` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`order`.`delivery` ALTER COLUMN `warehouse_id` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`order`.`delivery` ALTER COLUMN `actual_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Delivery Date (ADD)');
ALTER TABLE `manufacturing_ecm`.`order`.`delivery` ALTER COLUMN `actual_goods_issue_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Goods Issue Timestamp (AGIT)');
ALTER TABLE `manufacturing_ecm`.`order`.`delivery` ALTER COLUMN `carrier_code` SET TAGS ('dbx_business_glossary_term' = 'Carrier Code (CC)');
ALTER TABLE `manufacturing_ecm`.`order`.`delivery` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (RCT)');
ALTER TABLE `manufacturing_ecm`.`order`.`delivery` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `manufacturing_ecm`.`order`.`delivery` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `manufacturing_ecm`.`order`.`delivery` ALTER COLUMN `delivery_number` SET TAGS ('dbx_business_glossary_term' = 'Delivery Number (DN)');
ALTER TABLE `manufacturing_ecm`.`order`.`delivery` ALTER COLUMN `delivery_state` SET TAGS ('dbx_business_glossary_term' = 'Delivery State/Province (DS)');
ALTER TABLE `manufacturing_ecm`.`order`.`delivery` ALTER COLUMN `delivery_state` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `manufacturing_ecm`.`order`.`delivery` ALTER COLUMN `delivery_state` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `manufacturing_ecm`.`order`.`delivery` ALTER COLUMN `delivery_status` SET TAGS ('dbx_business_glossary_term' = 'Delivery Status (DS)');
ALTER TABLE `manufacturing_ecm`.`order`.`delivery` ALTER COLUMN `delivery_status` SET TAGS ('dbx_value_regex' = 'planned|released|picked|shipped|delivered|cancelled');
ALTER TABLE `manufacturing_ecm`.`order`.`delivery` ALTER COLUMN `delivery_type` SET TAGS ('dbx_business_glossary_term' = 'Delivery Type (DT)');
ALTER TABLE `manufacturing_ecm`.`order`.`delivery` ALTER COLUMN `freight_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Freight Cost Amount (FCA)');
ALTER TABLE `manufacturing_ecm`.`order`.`delivery` ALTER COLUMN `freight_tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Freight Tax Amount (FTA)');
ALTER TABLE `manufacturing_ecm`.`order`.`delivery` ALTER COLUMN `freight_total_amount` SET TAGS ('dbx_business_glossary_term' = 'Freight Total Amount (FTA)');
ALTER TABLE `manufacturing_ecm`.`order`.`delivery` ALTER COLUMN `handling_instructions` SET TAGS ('dbx_business_glossary_term' = 'Handling Instructions (HI)');
ALTER TABLE `manufacturing_ecm`.`order`.`delivery` ALTER COLUMN `hazardous_material_flag` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Material Flag (HMF)');
ALTER TABLE `manufacturing_ecm`.`order`.`delivery` ALTER COLUMN `is_backorder` SET TAGS ('dbx_business_glossary_term' = 'Backorder Flag (BOF)');
ALTER TABLE `manufacturing_ecm`.`order`.`delivery` ALTER COLUMN `is_partial_delivery` SET TAGS ('dbx_business_glossary_term' = 'Partial Delivery Flag (PDF)');
ALTER TABLE `manufacturing_ecm`.`order`.`delivery` ALTER COLUMN `number_of_items` SET TAGS ('dbx_business_glossary_term' = 'Number of Items (NI)');
ALTER TABLE `manufacturing_ecm`.`order`.`delivery` ALTER COLUMN `planned_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Delivery Date (PDD)');
ALTER TABLE `manufacturing_ecm`.`order`.`delivery` ALTER COLUMN `planned_goods_issue_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Goods Issue Date (PGID)');
ALTER TABLE `manufacturing_ecm`.`order`.`delivery` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Delivery Priority (DP)');
ALTER TABLE `manufacturing_ecm`.`order`.`delivery` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'low|medium|high');
ALTER TABLE `manufacturing_ecm`.`order`.`delivery` ALTER COLUMN `shipping_condition` SET TAGS ('dbx_business_glossary_term' = 'Shipping Condition (SC)');
ALTER TABLE `manufacturing_ecm`.`order`.`delivery` ALTER COLUMN `shipping_condition` SET TAGS ('dbx_value_regex' = 'EXW|FOB|CIF|DDP');
ALTER TABLE `manufacturing_ecm`.`order`.`delivery` ALTER COLUMN `shipping_point` SET TAGS ('dbx_business_glossary_term' = 'Shipping Point (SP)');
ALTER TABLE `manufacturing_ecm`.`order`.`delivery` ALTER COLUMN `special_equipment_required` SET TAGS ('dbx_business_glossary_term' = 'Special Equipment Required Flag (SERF)');
ALTER TABLE `manufacturing_ecm`.`order`.`delivery` ALTER COLUMN `temperature_control_required` SET TAGS ('dbx_business_glossary_term' = 'Temperature Control Required Flag (TCRF)');
ALTER TABLE `manufacturing_ecm`.`order`.`delivery` ALTER COLUMN `total_gross_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Total Gross Weight (KG)');
ALTER TABLE `manufacturing_ecm`.`order`.`delivery` ALTER COLUMN `total_volume_m3` SET TAGS ('dbx_business_glossary_term' = 'Total Volume (M3)');
ALTER TABLE `manufacturing_ecm`.`order`.`delivery` ALTER COLUMN `tracking_number` SET TAGS ('dbx_business_glossary_term' = 'Tracking Number (TN)');
ALTER TABLE `manufacturing_ecm`.`order`.`delivery` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (RUT)');
ALTER TABLE `manufacturing_ecm`.`order`.`delivery` ALTER COLUMN `window_end` SET TAGS ('dbx_business_glossary_term' = 'Delivery Window End (DWE)');
ALTER TABLE `manufacturing_ecm`.`order`.`delivery` ALTER COLUMN `window_start` SET TAGS ('dbx_business_glossary_term' = 'Delivery Window Start (DWS)');
ALTER TABLE `manufacturing_ecm`.`order`.`delivery_item` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `manufacturing_ecm`.`order`.`delivery_item` SET TAGS ('dbx_subdomain' = 'fulfillment_returns');
ALTER TABLE `manufacturing_ecm`.`order`.`delivery_item` ALTER COLUMN `delivery_item_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Item Identifier (DIID)');
ALTER TABLE `manufacturing_ecm`.`order`.`delivery_item` ALTER COLUMN `component_id` SET TAGS ('dbx_business_glossary_term' = 'Component Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`order`.`delivery_item` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`order`.`delivery_item` ALTER COLUMN `delivery_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Document Identifier (DDID)');
ALTER TABLE `manufacturing_ecm`.`order`.`delivery_item` ALTER COLUMN `engineering_revision_id` SET TAGS ('dbx_business_glossary_term' = 'Engineering Revision Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`order`.`delivery_item` ALTER COLUMN `equipment_register_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Register Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`order`.`delivery_item` ALTER COLUMN `lot_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Batch Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`order`.`delivery_item` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`order`.`delivery_item` ALTER COLUMN `order_line_id` SET TAGS ('dbx_business_glossary_term' = 'Order Line Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`order`.`delivery_item` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`order`.`delivery_item` ALTER COLUMN `schedule_line_id` SET TAGS ('dbx_business_glossary_term' = 'Schedule Line Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`order`.`delivery_item` ALTER COLUMN `serialized_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Serialized Unit Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`order`.`delivery_item` ALTER COLUMN `sku_master_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Master Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`order`.`delivery_item` ALTER COLUMN `stock_location_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Location Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`order`.`delivery_item` ALTER COLUMN `actual_goods_issue_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Goods Issue Timestamp (ACT_GI_TS)');
ALTER TABLE `manufacturing_ecm`.`order`.`delivery_item` ALTER COLUMN `carrier_code` SET TAGS ('dbx_business_glossary_term' = 'Carrier Code (CARR)');
ALTER TABLE `manufacturing_ecm`.`order`.`delivery_item` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (CRE_TSTMP)');
ALTER TABLE `manufacturing_ecm`.`order`.`delivery_item` ALTER COLUMN `delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Delivery Date (PLND_DEL)');
ALTER TABLE `manufacturing_ecm`.`order`.`delivery_item` ALTER COLUMN `goods_movement_status` SET TAGS ('dbx_business_glossary_term' = 'Goods Movement Status (GM_STATUS)');
ALTER TABLE `manufacturing_ecm`.`order`.`delivery_item` ALTER COLUMN `goods_movement_status` SET TAGS ('dbx_value_regex' = 'not_issued|issued|reversed');
ALTER TABLE `manufacturing_ecm`.`order`.`delivery_item` ALTER COLUMN `handling_unit_number` SET TAGS ('dbx_business_glossary_term' = 'Handling Unit Number (HU)');
ALTER TABLE `manufacturing_ecm`.`order`.`delivery_item` ALTER COLUMN `inspection_result` SET TAGS ('dbx_business_glossary_term' = 'Inspection Result (QI_RESULT)');
ALTER TABLE `manufacturing_ecm`.`order`.`delivery_item` ALTER COLUMN `inventory_management_indicator` SET TAGS ('dbx_business_glossary_term' = 'Inventory Management Indicator (IM_IND)');
ALTER TABLE `manufacturing_ecm`.`order`.`delivery_item` ALTER COLUMN `inventory_management_indicator` SET TAGS ('dbx_value_regex' = 'X|');
ALTER TABLE `manufacturing_ecm`.`order`.`delivery_item` ALTER COLUMN `item_category` SET TAGS ('dbx_business_glossary_term' = 'Item Category (ITM_CAT)');
ALTER TABLE `manufacturing_ecm`.`order`.`delivery_item` ALTER COLUMN `item_category` SET TAGS ('dbx_value_regex' = 'standard|return|consignment');
ALTER TABLE `manufacturing_ecm`.`order`.`delivery_item` ALTER COLUMN `movement_reason` SET TAGS ('dbx_business_glossary_term' = 'Movement Reason (GRUND)');
ALTER TABLE `manufacturing_ecm`.`order`.`delivery_item` ALTER COLUMN `movement_type` SET TAGS ('dbx_business_glossary_term' = 'Movement Type (BWTAR)');
ALTER TABLE `manufacturing_ecm`.`order`.`delivery_item` ALTER COLUMN `pallet_number` SET TAGS ('dbx_business_glossary_term' = 'Pallet Number (PAL_NUM)');
ALTER TABLE `manufacturing_ecm`.`order`.`delivery_item` ALTER COLUMN `picking_status` SET TAGS ('dbx_business_glossary_term' = 'Picking Status (PKG_STATUS)');
ALTER TABLE `manufacturing_ecm`.`order`.`delivery_item` ALTER COLUMN `picking_status` SET TAGS ('dbx_value_regex' = 'not_picked|partially_picked|picked|blocked');
ALTER TABLE `manufacturing_ecm`.`order`.`delivery_item` ALTER COLUMN `plant` SET TAGS ('dbx_business_glossary_term' = 'Plant Code (WERKS)');
ALTER TABLE `manufacturing_ecm`.`order`.`delivery_item` ALTER COLUMN `promised_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Promised Delivery Date (PROM_DEL)');
ALTER TABLE `manufacturing_ecm`.`order`.`delivery_item` ALTER COLUMN `quality_inspection_status` SET TAGS ('dbx_business_glossary_term' = 'Quality Inspection Status (QI_STATUS)');
ALTER TABLE `manufacturing_ecm`.`order`.`delivery_item` ALTER COLUMN `quality_inspection_status` SET TAGS ('dbx_value_regex' = 'not_required|required|passed|failed');
ALTER TABLE `manufacturing_ecm`.`order`.`delivery_item` ALTER COLUMN `quantity_delivered` SET TAGS ('dbx_business_glossary_term' = 'Delivered Quantity (DLV_QTY)');
ALTER TABLE `manufacturing_ecm`.`order`.`delivery_item` ALTER COLUMN `quantity_ordered` SET TAGS ('dbx_business_glossary_term' = 'Ordered Quantity (ORD_QTY)');
ALTER TABLE `manufacturing_ecm`.`order`.`delivery_item` ALTER COLUMN `quantity_picked` SET TAGS ('dbx_business_glossary_term' = 'Picked Quantity (PCK_QTY)');
ALTER TABLE `manufacturing_ecm`.`order`.`delivery_item` ALTER COLUMN `route` SET TAGS ('dbx_business_glossary_term' = 'Transportation Route (ROUTE)');
ALTER TABLE `manufacturing_ecm`.`order`.`delivery_item` ALTER COLUMN `serial_number_end` SET TAGS ('dbx_business_glossary_term' = 'Serial Number End (SERIAL_TO)');
ALTER TABLE `manufacturing_ecm`.`order`.`delivery_item` ALTER COLUMN `serial_number_start` SET TAGS ('dbx_business_glossary_term' = 'Serial Number Start (SERIAL_FROM)');
ALTER TABLE `manufacturing_ecm`.`order`.`delivery_item` ALTER COLUMN `shipping_condition` SET TAGS ('dbx_business_glossary_term' = 'Shipping Condition (SHIP_COND)');
ALTER TABLE `manufacturing_ecm`.`order`.`delivery_item` ALTER COLUMN `shipping_point` SET TAGS ('dbx_business_glossary_term' = 'Shipping Point (VSTEL)');
ALTER TABLE `manufacturing_ecm`.`order`.`delivery_item` ALTER COLUMN `special_stock_indicator` SET TAGS ('dbx_business_glossary_term' = 'Special Stock Indicator (SOBK)');
ALTER TABLE `manufacturing_ecm`.`order`.`delivery_item` ALTER COLUMN `special_stock_indicator` SET TAGS ('dbx_value_regex' = 'E|K|L|M|N');
ALTER TABLE `manufacturing_ecm`.`order`.`delivery_item` ALTER COLUMN `storage_location` SET TAGS ('dbx_business_glossary_term' = 'Storage Location (LGORT)');
ALTER TABLE `manufacturing_ecm`.`order`.`delivery_item` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `manufacturing_ecm`.`order`.`delivery_item` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'EA|KG|L|M|PC|SET');
ALTER TABLE `manufacturing_ecm`.`order`.`delivery_item` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (UPD_TSTMP)');
ALTER TABLE `manufacturing_ecm`.`order`.`delivery_item` ALTER COLUMN `volume_m3` SET TAGS ('dbx_business_glossary_term' = 'Volume (M3)');
ALTER TABLE `manufacturing_ecm`.`order`.`delivery_item` ALTER COLUMN `weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Weight (KG)');
ALTER TABLE `manufacturing_ecm`.`order`.`rma` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `manufacturing_ecm`.`order`.`rma` SET TAGS ('dbx_subdomain' = 'fulfillment_returns');
ALTER TABLE `manufacturing_ecm`.`order`.`rma` ALTER COLUMN `rma_id` SET TAGS ('dbx_business_glossary_term' = 'Return Material Authorization (RMA) Identifier');
ALTER TABLE `manufacturing_ecm`.`order`.`rma` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Identifier');
ALTER TABLE `manufacturing_ecm`.`order`.`rma` ALTER COLUMN `account_site_id` SET TAGS ('dbx_business_glossary_term' = 'Account Site Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`order`.`rma` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Contract Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`order`.`rma` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`order`.`rma` ALTER COLUMN `customer_contact_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Contact Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`order`.`rma` ALTER COLUMN `equipment_register_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Register Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`order`.`rma` ALTER COLUMN `header_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Order Identifier');
ALTER TABLE `manufacturing_ecm`.`order`.`rma` ALTER COLUMN `lot_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Batch Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`order`.`rma` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Replacement Product Identifier');
ALTER TABLE `manufacturing_ecm`.`order`.`rma` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`order`.`rma` ALTER COLUMN `address_id` SET TAGS ('dbx_business_glossary_term' = 'Return From Address Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`order`.`rma` ALTER COLUMN `address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `manufacturing_ecm`.`order`.`rma` ALTER COLUMN `address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `manufacturing_ecm`.`order`.`rma` ALTER COLUMN `stock_location_id` SET TAGS ('dbx_business_glossary_term' = 'Return Stock Location Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`order`.`rma` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`order`.`rma` ALTER COLUMN `actual_return_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Return Date');
ALTER TABLE `manufacturing_ecm`.`order`.`rma` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `manufacturing_ecm`.`order`.`rma` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected');
ALTER TABLE `manufacturing_ecm`.`order`.`rma` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `manufacturing_ecm`.`order`.`rma` ALTER COLUMN `authorized_quantity` SET TAGS ('dbx_business_glossary_term' = 'Authorized Return Quantity');
ALTER TABLE `manufacturing_ecm`.`order`.`rma` ALTER COLUMN `carrier_name` SET TAGS ('dbx_business_glossary_term' = 'Carrier Name');
ALTER TABLE `manufacturing_ecm`.`order`.`rma` ALTER COLUMN `credit_amount` SET TAGS ('dbx_business_glossary_term' = 'Credit Amount');
ALTER TABLE `manufacturing_ecm`.`order`.`rma` ALTER COLUMN `credit_memo_indicator` SET TAGS ('dbx_business_glossary_term' = 'Credit Memo Indicator');
ALTER TABLE `manufacturing_ecm`.`order`.`rma` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `manufacturing_ecm`.`order`.`rma` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `manufacturing_ecm`.`order`.`rma` ALTER COLUMN `expected_return_date` SET TAGS ('dbx_business_glossary_term' = 'Expected Return Date');
ALTER TABLE `manufacturing_ecm`.`order`.`rma` ALTER COLUMN `handling_fee` SET TAGS ('dbx_business_glossary_term' = 'Handling Fee Amount');
ALTER TABLE `manufacturing_ecm`.`order`.`rma` ALTER COLUMN `inspection_required` SET TAGS ('dbx_business_glossary_term' = 'Inspection Required Flag');
ALTER TABLE `manufacturing_ecm`.`order`.`rma` ALTER COLUMN `is_damaged` SET TAGS ('dbx_business_glossary_term' = 'Damaged Item Indicator');
ALTER TABLE `manufacturing_ecm`.`order`.`rma` ALTER COLUMN `is_repairable` SET TAGS ('dbx_business_glossary_term' = 'Repairable Indicator');
ALTER TABLE `manufacturing_ecm`.`order`.`rma` ALTER COLUMN `is_warranty_claim` SET TAGS ('dbx_business_glossary_term' = 'Warranty Claim Indicator');
ALTER TABLE `manufacturing_ecm`.`order`.`rma` ALTER COLUMN `is_wrong_item` SET TAGS ('dbx_business_glossary_term' = 'Wrong Item Indicator');
ALTER TABLE `manufacturing_ecm`.`order`.`rma` ALTER COLUMN `net_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Amount');
ALTER TABLE `manufacturing_ecm`.`order`.`rma` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'RMA Notes');
ALTER TABLE `manufacturing_ecm`.`order`.`rma` ALTER COLUMN `order_rma_status` SET TAGS ('dbx_business_glossary_term' = 'RMA Lifecycle Status');
ALTER TABLE `manufacturing_ecm`.`order`.`rma` ALTER COLUMN `order_rma_status` SET TAGS ('dbx_value_regex' = 'open|approved|rejected|closed|cancelled');
ALTER TABLE `manufacturing_ecm`.`order`.`rma` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `manufacturing_ecm`.`order`.`rma` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `manufacturing_ecm`.`order`.`rma` ALTER COLUMN `refund_amount` SET TAGS ('dbx_business_glossary_term' = 'Refund Amount');
ALTER TABLE `manufacturing_ecm`.`order`.`rma` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason Description');
ALTER TABLE `manufacturing_ecm`.`order`.`rma` ALTER COLUMN `replacement_quantity` SET TAGS ('dbx_business_glossary_term' = 'Replacement Quantity');
ALTER TABLE `manufacturing_ecm`.`order`.`rma` ALTER COLUMN `request_timestamp` SET TAGS ('dbx_business_glossary_term' = 'RMA Request Timestamp');
ALTER TABLE `manufacturing_ecm`.`order`.`rma` ALTER COLUMN `return_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Return Reason Code');
ALTER TABLE `manufacturing_ecm`.`order`.`rma` ALTER COLUMN `return_reason_code` SET TAGS ('dbx_value_regex' = 'defect|damage|wrong_item|warranty|other');
ALTER TABLE `manufacturing_ecm`.`order`.`rma` ALTER COLUMN `return_reason_description` SET TAGS ('dbx_business_glossary_term' = 'Return Reason Description');
ALTER TABLE `manufacturing_ecm`.`order`.`rma` ALTER COLUMN `returned_quantity` SET TAGS ('dbx_business_glossary_term' = 'Returned Quantity');
ALTER TABLE `manufacturing_ecm`.`order`.`rma` ALTER COLUMN `rma_number` SET TAGS ('dbx_business_glossary_term' = 'Return Material Authorization (RMA) Number');
ALTER TABLE `manufacturing_ecm`.`order`.`rma` ALTER COLUMN `rma_type` SET TAGS ('dbx_business_glossary_term' = 'RMA Type');
ALTER TABLE `manufacturing_ecm`.`order`.`rma` ALTER COLUMN `rma_type` SET TAGS ('dbx_value_regex' = 'warranty|non_warranty|repair|replace');
ALTER TABLE `manufacturing_ecm`.`order`.`rma` ALTER COLUMN `shipping_method` SET TAGS ('dbx_business_glossary_term' = 'Shipping Method');
ALTER TABLE `manufacturing_ecm`.`order`.`rma` ALTER COLUMN `shipping_method` SET TAGS ('dbx_value_regex' = 'ground|air|sea|pickup');
ALTER TABLE `manufacturing_ecm`.`order`.`rma` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `manufacturing_ecm`.`order`.`rma` ALTER COLUMN `tracking_number` SET TAGS ('dbx_business_glossary_term' = 'Shipment Tracking Number');
ALTER TABLE `manufacturing_ecm`.`order`.`rma_line` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `manufacturing_ecm`.`order`.`rma_line` SET TAGS ('dbx_subdomain' = 'fulfillment_returns');
ALTER TABLE `manufacturing_ecm`.`order`.`rma_line` ALTER COLUMN `rma_line_id` SET TAGS ('dbx_business_glossary_term' = 'Return Material Authorization (RMA) Line ID');
ALTER TABLE `manufacturing_ecm`.`order`.`rma_line` ALTER COLUMN `component_id` SET TAGS ('dbx_business_glossary_term' = 'Component Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`order`.`rma_line` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`order`.`rma_line` ALTER COLUMN `delivery_id` SET TAGS ('dbx_business_glossary_term' = 'Original Delivery ID');
ALTER TABLE `manufacturing_ecm`.`order`.`rma_line` ALTER COLUMN `engineering_revision_id` SET TAGS ('dbx_business_glossary_term' = 'Engineering Revision Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`order`.`rma_line` ALTER COLUMN `equipment_register_id` SET TAGS ('dbx_business_glossary_term' = 'Equipment Register Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`order`.`rma_line` ALTER COLUMN `header_id` SET TAGS ('dbx_business_glossary_term' = 'Replacement Order ID');
ALTER TABLE `manufacturing_ecm`.`order`.`rma_line` ALTER COLUMN `lot_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Batch Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`order`.`rma_line` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`order`.`rma_line` ALTER COLUMN `order_line_id` SET TAGS ('dbx_business_glossary_term' = 'Line Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`order`.`rma_line` ALTER COLUMN `po_line_item_id` SET TAGS ('dbx_business_glossary_term' = 'Po Line Item Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`order`.`rma_line` ALTER COLUMN `production_work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Rework Order ID');
ALTER TABLE `manufacturing_ecm`.`order`.`rma_line` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`order`.`rma_line` ALTER COLUMN `stock_location_id` SET TAGS ('dbx_business_glossary_term' = 'Restock Stock Location Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`order`.`rma_line` ALTER COLUMN `rma_id` SET TAGS ('dbx_business_glossary_term' = 'Return Material Authorization (RMA) ID');
ALTER TABLE `manufacturing_ecm`.`order`.`rma_line` ALTER COLUMN `serialized_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Serialized Unit Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`order`.`rma_line` ALTER COLUMN `sku_master_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Master Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`order`.`rma_line` ALTER COLUMN `condition_code` SET TAGS ('dbx_business_glossary_term' = 'Condition Code');
ALTER TABLE `manufacturing_ecm`.`order`.`rma_line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `manufacturing_ecm`.`order`.`rma_line` ALTER COLUMN `credit_amount` SET TAGS ('dbx_business_glossary_term' = 'Credit Amount');
ALTER TABLE `manufacturing_ecm`.`order`.`rma_line` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `manufacturing_ecm`.`order`.`rma_line` ALTER COLUMN `disposition_action` SET TAGS ('dbx_business_glossary_term' = 'Disposition Action');
ALTER TABLE `manufacturing_ecm`.`order`.`rma_line` ALTER COLUMN `disposition_action` SET TAGS ('dbx_value_regex' = 'scrap|rework|restock|replace');
ALTER TABLE `manufacturing_ecm`.`order`.`rma_line` ALTER COLUMN `disposition_reason` SET TAGS ('dbx_business_glossary_term' = 'Disposition Reason');
ALTER TABLE `manufacturing_ecm`.`order`.`rma_line` ALTER COLUMN `inspection_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Inspection Required Flag');
ALTER TABLE `manufacturing_ecm`.`order`.`rma_line` ALTER COLUMN `inspection_status` SET TAGS ('dbx_business_glossary_term' = 'Inspection Status');
ALTER TABLE `manufacturing_ecm`.`order`.`rma_line` ALTER COLUMN `inspection_status` SET TAGS ('dbx_value_regex' = 'pending|passed|failed');
ALTER TABLE `manufacturing_ecm`.`order`.`rma_line` ALTER COLUMN `line_number` SET TAGS ('dbx_business_glossary_term' = 'RMA Line Sequence Number');
ALTER TABLE `manufacturing_ecm`.`order`.`rma_line` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'RMA Line Notes');
ALTER TABLE `manufacturing_ecm`.`order`.`rma_line` ALTER COLUMN `original_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Original Delivery Date');
ALTER TABLE `manufacturing_ecm`.`order`.`rma_line` ALTER COLUMN `received_date` SET TAGS ('dbx_business_glossary_term' = 'Received Date');
ALTER TABLE `manufacturing_ecm`.`order`.`rma_line` ALTER COLUMN `replace_flag` SET TAGS ('dbx_business_glossary_term' = 'Replace Flag');
ALTER TABLE `manufacturing_ecm`.`order`.`rma_line` ALTER COLUMN `replacement_part_number` SET TAGS ('dbx_business_glossary_term' = 'Replacement Part Number');
ALTER TABLE `manufacturing_ecm`.`order`.`rma_line` ALTER COLUMN `restock_quantity` SET TAGS ('dbx_business_glossary_term' = 'Restock Quantity');
ALTER TABLE `manufacturing_ecm`.`order`.`rma_line` ALTER COLUMN `restock_status` SET TAGS ('dbx_business_glossary_term' = 'Restock Status');
ALTER TABLE `manufacturing_ecm`.`order`.`rma_line` ALTER COLUMN `restock_status` SET TAGS ('dbx_value_regex' = 'pending|completed|error');
ALTER TABLE `manufacturing_ecm`.`order`.`rma_line` ALTER COLUMN `return_date` SET TAGS ('dbx_business_glossary_term' = 'Return Date');
ALTER TABLE `manufacturing_ecm`.`order`.`rma_line` ALTER COLUMN `return_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Return Reason Code');
ALTER TABLE `manufacturing_ecm`.`order`.`rma_line` ALTER COLUMN `return_reason_description` SET TAGS ('dbx_business_glossary_term' = 'Return Reason Description');
ALTER TABLE `manufacturing_ecm`.`order`.`rma_line` ALTER COLUMN `returned_quantity` SET TAGS ('dbx_business_glossary_term' = 'Returned Quantity');
ALTER TABLE `manufacturing_ecm`.`order`.`rma_line` ALTER COLUMN `rework_flag` SET TAGS ('dbx_business_glossary_term' = 'Rework Flag');
ALTER TABLE `manufacturing_ecm`.`order`.`rma_line` ALTER COLUMN `scrap_flag` SET TAGS ('dbx_business_glossary_term' = 'Scrap Flag');
ALTER TABLE `manufacturing_ecm`.`order`.`rma_line` ALTER COLUMN `scrap_reason` SET TAGS ('dbx_business_glossary_term' = 'Scrap Reason');
ALTER TABLE `manufacturing_ecm`.`order`.`rma_line` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `manufacturing_ecm`.`order`.`rma_line` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `manufacturing_ecm`.`order`.`rma_line` ALTER COLUMN `warranty_claim_flag` SET TAGS ('dbx_business_glossary_term' = 'Warranty Claim Flag');
ALTER TABLE `manufacturing_ecm`.`order`.`rma_line` ALTER COLUMN `warranty_claim_number` SET TAGS ('dbx_business_glossary_term' = 'Warranty Claim Number');
ALTER TABLE `manufacturing_ecm`.`order`.`goods_issue` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `manufacturing_ecm`.`order`.`goods_issue` SET TAGS ('dbx_subdomain' = 'fulfillment_returns');
ALTER TABLE `manufacturing_ecm`.`order`.`goods_issue` ALTER COLUMN `goods_issue_id` SET TAGS ('dbx_business_glossary_term' = 'Goods Issue Identifier');
ALTER TABLE `manufacturing_ecm`.`order`.`goods_issue` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Identifier (CUSTOMER_ID)');
ALTER TABLE `manufacturing_ecm`.`order`.`goods_issue` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`order`.`goods_issue` ALTER COLUMN `delivery_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`order`.`goods_issue` ALTER COLUMN `header_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Order Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`order`.`goods_issue` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`order`.`goods_issue` ALTER COLUMN `lot_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Batch Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`order`.`goods_issue` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`order`.`goods_issue` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`order`.`goods_issue` ALTER COLUMN `serialized_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Serialized Unit Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`order`.`goods_issue` ALTER COLUMN `sku_master_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Master Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`order`.`goods_issue` ALTER COLUMN `stock_location_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Location Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`order`.`goods_issue` ALTER COLUMN `actual_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Delivery Date (ACTUAL_DELIVERY_DATE)');
ALTER TABLE `manufacturing_ecm`.`order`.`goods_issue` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (REC_CREATE_TS)');
ALTER TABLE `manufacturing_ecm`.`order`.`goods_issue` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (CURRENCY)');
ALTER TABLE `manufacturing_ecm`.`order`.`goods_issue` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|EUR|JPY|CNY|GBP|CHF');
ALTER TABLE `manufacturing_ecm`.`order`.`goods_issue` ALTER COLUMN `delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Delivery Date (DELIVERY_DATE)');
ALTER TABLE `manufacturing_ecm`.`order`.`goods_issue` ALTER COLUMN `expected_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Expected Delivery Date (EXPECTED_DELIVERY_DATE)');
ALTER TABLE `manufacturing_ecm`.`order`.`goods_issue` ALTER COLUMN `external_reference` SET TAGS ('dbx_business_glossary_term' = 'External Reference (e.g., Carrier Tracking Number) (EXT_REF)');
ALTER TABLE `manufacturing_ecm`.`order`.`goods_issue` ALTER COLUMN `goods_issue_status` SET TAGS ('dbx_business_glossary_term' = 'Goods Issue Status (GI_STATUS)');
ALTER TABLE `manufacturing_ecm`.`order`.`goods_issue` ALTER COLUMN `goods_issue_status` SET TAGS ('dbx_value_regex' = 'posted|reversed|pending|cancelled');
ALTER TABLE `manufacturing_ecm`.`order`.`goods_issue` ALTER COLUMN `handling_unit` SET TAGS ('dbx_business_glossary_term' = 'Handling Unit Identifier (HU_ID)');
ALTER TABLE `manufacturing_ecm`.`order`.`goods_issue` ALTER COLUMN `incoterms` SET TAGS ('dbx_business_glossary_term' = 'Incoterms (INCOTERMS)');
ALTER TABLE `manufacturing_ecm`.`order`.`goods_issue` ALTER COLUMN `incoterms` SET TAGS ('dbx_value_regex' = 'EXW|FCA|CPT|CIP|DAP|DDP');
ALTER TABLE `manufacturing_ecm`.`order`.`goods_issue` ALTER COLUMN `inventory_account` SET TAGS ('dbx_business_glossary_term' = 'Inventory Account (INV_ACCT)');
ALTER TABLE `manufacturing_ecm`.`order`.`goods_issue` ALTER COLUMN `is_automated` SET TAGS ('dbx_business_glossary_term' = 'Automated Issue Indicator (IS_AUTOMATED)');
ALTER TABLE `manufacturing_ecm`.`order`.`goods_issue` ALTER COLUMN `issue_number` SET TAGS ('dbx_business_glossary_term' = 'Goods Issue Document Number (GI_DOC_NO)');
ALTER TABLE `manufacturing_ecm`.`order`.`goods_issue` ALTER COLUMN `movement_type` SET TAGS ('dbx_business_glossary_term' = 'Movement Type (MOV_TYPE)');
ALTER TABLE `manufacturing_ecm`.`order`.`goods_issue` ALTER COLUMN `movement_type` SET TAGS ('dbx_value_regex' = '101|102|201|202');
ALTER TABLE `manufacturing_ecm`.`order`.`goods_issue` ALTER COLUMN `net_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Amount After Tax (NET_AMT)');
ALTER TABLE `manufacturing_ecm`.`order`.`goods_issue` ALTER COLUMN `plant` SET TAGS ('dbx_business_glossary_term' = 'Plant Code (PLANT_CD)');
ALTER TABLE `manufacturing_ecm`.`order`.`goods_issue` ALTER COLUMN `posting_reason` SET TAGS ('dbx_business_glossary_term' = 'Posting Reason (POST_REASON)');
ALTER TABLE `manufacturing_ecm`.`order`.`goods_issue` ALTER COLUMN `posting_reason` SET TAGS ('dbx_value_regex' = 'normal|return|scrap|transfer');
ALTER TABLE `manufacturing_ecm`.`order`.`goods_issue` ALTER COLUMN `posting_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Goods Issue Posting Timestamp (GI_POST_TS)');
ALTER TABLE `manufacturing_ecm`.`order`.`goods_issue` ALTER COLUMN `purchase_order_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Number (PO_NO)');
ALTER TABLE `manufacturing_ecm`.`order`.`goods_issue` ALTER COLUMN `quality_status` SET TAGS ('dbx_business_glossary_term' = 'Quality Status of Issued Goods (QUALITY_STATUS)');
ALTER TABLE `manufacturing_ecm`.`order`.`goods_issue` ALTER COLUMN `quality_status` SET TAGS ('dbx_value_regex' = 'accepted|rejected|pending');
ALTER TABLE `manufacturing_ecm`.`order`.`goods_issue` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Issued Quantity (ISSUED_QTY)');
ALTER TABLE `manufacturing_ecm`.`order`.`goods_issue` ALTER COLUMN `remarks` SET TAGS ('dbx_business_glossary_term' = 'Remarks / Free Text (REMARKS)');
ALTER TABLE `manufacturing_ecm`.`order`.`goods_issue` ALTER COLUMN `reversal_indicator` SET TAGS ('dbx_business_glossary_term' = 'Reversal Indicator (IS_REVERSAL)');
ALTER TABLE `manufacturing_ecm`.`order`.`goods_issue` ALTER COLUMN `route` SET TAGS ('dbx_business_glossary_term' = 'Transportation Route (ROUTE)');
ALTER TABLE `manufacturing_ecm`.`order`.`goods_issue` ALTER COLUMN `shipping_point` SET TAGS ('dbx_business_glossary_term' = 'Shipping Point Code (SHIP_POINT)');
ALTER TABLE `manufacturing_ecm`.`order`.`goods_issue` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System of Record (SOURCE_SYS)');
ALTER TABLE `manufacturing_ecm`.`order`.`goods_issue` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'SAP|MES|ERP');
ALTER TABLE `manufacturing_ecm`.`order`.`goods_issue` ALTER COLUMN `storage_location` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Code (STGE_LOC_CD)');
ALTER TABLE `manufacturing_ecm`.`order`.`goods_issue` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount (TAX_AMT)');
ALTER TABLE `manufacturing_ecm`.`order`.`goods_issue` ALTER COLUMN `total_value_cost` SET TAGS ('dbx_business_glossary_term' = 'Total Value at Cost (TOTAL_COST_VAL)');
ALTER TABLE `manufacturing_ecm`.`order`.`goods_issue` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `manufacturing_ecm`.`order`.`goods_issue` ALTER COLUMN `uom` SET TAGS ('dbx_value_regex' = 'EA|KG|L|M|PCS|SET');
ALTER TABLE `manufacturing_ecm`.`order`.`goods_issue` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp (REC_UPDATE_TS)');
ALTER TABLE `manufacturing_ecm`.`order`.`goods_issue` ALTER COLUMN `valuation_area` SET TAGS ('dbx_business_glossary_term' = 'Valuation Area (VAL_AREA)');
ALTER TABLE `manufacturing_ecm`.`order`.`goods_issue` ALTER COLUMN `valuation_type` SET TAGS ('dbx_business_glossary_term' = 'Valuation Type (VAL_TYPE)');
ALTER TABLE `manufacturing_ecm`.`order`.`goods_issue` ALTER COLUMN `valuation_type` SET TAGS ('dbx_value_regex' = 'standard|moving|periodic');
ALTER TABLE `manufacturing_ecm`.`order`.`blanket_order` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `manufacturing_ecm`.`order`.`blanket_order` SET TAGS ('dbx_subdomain' = 'order_management');
ALTER TABLE `manufacturing_ecm`.`order`.`blanket_order` ALTER COLUMN `blanket_order_id` SET TAGS ('dbx_business_glossary_term' = 'Blanket Order Identifier');
ALTER TABLE `manufacturing_ecm`.`order`.`blanket_order` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Identifier');
ALTER TABLE `manufacturing_ecm`.`order`.`blanket_order` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`order`.`blanket_order` ALTER COLUMN `contract_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Contract Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`order`.`blanket_order` ALTER COLUMN `customer_contact_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Contact Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`order`.`blanket_order` ALTER COLUMN `address_id` SET TAGS ('dbx_business_glossary_term' = 'Ship To Address Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`order`.`blanket_order` ALTER COLUMN `address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `manufacturing_ecm`.`order`.`blanket_order` ALTER COLUMN `address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `manufacturing_ecm`.`order`.`blanket_order` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`order`.`blanket_order` ALTER COLUMN `agreement_description` SET TAGS ('dbx_business_glossary_term' = 'Agreement Description');
ALTER TABLE `manufacturing_ecm`.`order`.`blanket_order` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `manufacturing_ecm`.`order`.`blanket_order` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `manufacturing_ecm`.`order`.`blanket_order` ALTER COLUMN `blanket_order_status` SET TAGS ('dbx_business_glossary_term' = 'Agreement Status');
ALTER TABLE `manufacturing_ecm`.`order`.`blanket_order` ALTER COLUMN `blanket_order_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|closed|draft');
ALTER TABLE `manufacturing_ecm`.`order`.`blanket_order` ALTER COLUMN `contract_status_reason` SET TAGS ('dbx_business_glossary_term' = 'Contract Status Reason');
ALTER TABLE `manufacturing_ecm`.`order`.`blanket_order` ALTER COLUMN `contract_type` SET TAGS ('dbx_business_glossary_term' = 'Contract Type');
ALTER TABLE `manufacturing_ecm`.`order`.`blanket_order` ALTER COLUMN `contract_type` SET TAGS ('dbx_value_regex' = 'scheduling|framework|blanket|service');
ALTER TABLE `manufacturing_ecm`.`order`.`blanket_order` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `manufacturing_ecm`.`order`.`blanket_order` ALTER COLUMN `cumulative_released_quantity` SET TAGS ('dbx_business_glossary_term' = 'Cumulative Released Quantity');
ALTER TABLE `manufacturing_ecm`.`order`.`blanket_order` ALTER COLUMN `cumulative_released_value` SET TAGS ('dbx_business_glossary_term' = 'Cumulative Released Value');
ALTER TABLE `manufacturing_ecm`.`order`.`blanket_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `manufacturing_ecm`.`order`.`blanket_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `manufacturing_ecm`.`order`.`blanket_order` ALTER COLUMN `distribution_channel` SET TAGS ('dbx_business_glossary_term' = 'Distribution Channel');
ALTER TABLE `manufacturing_ecm`.`order`.`blanket_order` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `manufacturing_ecm`.`order`.`blanket_order` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `manufacturing_ecm`.`order`.`blanket_order` ALTER COLUMN `is_jit_enabled` SET TAGS ('dbx_business_glossary_term' = 'Just‑In‑Time Enabled Flag');
ALTER TABLE `manufacturing_ecm`.`order`.`blanket_order` ALTER COLUMN `last_release_date` SET TAGS ('dbx_business_glossary_term' = 'Last Release Date');
ALTER TABLE `manufacturing_ecm`.`order`.`blanket_order` ALTER COLUMN `minimum_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity (MOQ)');
ALTER TABLE `manufacturing_ecm`.`order`.`blanket_order` ALTER COLUMN `minimum_order_uom` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Unit of Measure');
ALTER TABLE `manufacturing_ecm`.`order`.`blanket_order` ALTER COLUMN `minimum_order_uom` SET TAGS ('dbx_value_regex' = 'EA|KG|L|M|M2|M3');
ALTER TABLE `manufacturing_ecm`.`order`.`blanket_order` ALTER COLUMN `next_release_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Release Due Date');
ALTER TABLE `manufacturing_ecm`.`order`.`blanket_order` ALTER COLUMN `plant` SET TAGS ('dbx_business_glossary_term' = 'Plant Code');
ALTER TABLE `manufacturing_ecm`.`order`.`blanket_order` ALTER COLUMN `pricing_conditions` SET TAGS ('dbx_business_glossary_term' = 'Pricing Conditions');
ALTER TABLE `manufacturing_ecm`.`order`.`blanket_order` ALTER COLUMN `quantity_uom` SET TAGS ('dbx_business_glossary_term' = 'Quantity Unit of Measure');
ALTER TABLE `manufacturing_ecm`.`order`.`blanket_order` ALTER COLUMN `quantity_uom` SET TAGS ('dbx_value_regex' = 'EA|KG|L|M|M2|M3');
ALTER TABLE `manufacturing_ecm`.`order`.`blanket_order` ALTER COLUMN `region` SET TAGS ('dbx_business_glossary_term' = 'Geographic Region');
ALTER TABLE `manufacturing_ecm`.`order`.`blanket_order` ALTER COLUMN `release_frequency` SET TAGS ('dbx_business_glossary_term' = 'Release Frequency');
ALTER TABLE `manufacturing_ecm`.`order`.`blanket_order` ALTER COLUMN `release_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|weekly|on_demand');
ALTER TABLE `manufacturing_ecm`.`order`.`blanket_order` ALTER COLUMN `sales_organization` SET TAGS ('dbx_business_glossary_term' = 'Sales Organization Code');
ALTER TABLE `manufacturing_ecm`.`order`.`blanket_order` ALTER COLUMN `total_committed_quantity` SET TAGS ('dbx_business_glossary_term' = 'Total Committed Quantity');
ALTER TABLE `manufacturing_ecm`.`order`.`blanket_order` ALTER COLUMN `total_committed_value` SET TAGS ('dbx_business_glossary_term' = 'Total Committed Value');
ALTER TABLE `manufacturing_ecm`.`order`.`blanket_order` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `manufacturing_ecm`.`order`.`blanket_order_release` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `manufacturing_ecm`.`order`.`blanket_order_release` SET TAGS ('dbx_subdomain' = 'order_management');
ALTER TABLE `manufacturing_ecm`.`order`.`blanket_order_release` ALTER COLUMN `blanket_order_release_id` SET TAGS ('dbx_business_glossary_term' = 'Blanket Order Release ID');
ALTER TABLE `manufacturing_ecm`.`order`.`blanket_order_release` ALTER COLUMN `account_site_id` SET TAGS ('dbx_business_glossary_term' = 'Account Site Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`order`.`blanket_order_release` ALTER COLUMN `blanket_order_id` SET TAGS ('dbx_business_glossary_term' = 'Blanket Order ID');
ALTER TABLE `manufacturing_ecm`.`order`.`blanket_order_release` ALTER COLUMN `header_id` SET TAGS ('dbx_business_glossary_term' = 'Order Header Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`order`.`blanket_order_release` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
ALTER TABLE `manufacturing_ecm`.`order`.`blanket_order_release` ALTER COLUMN `sku_master_id` SET TAGS ('dbx_business_glossary_term' = 'Product ID');
ALTER TABLE `manufacturing_ecm`.`order`.`blanket_order_release` ALTER COLUMN `blanket_order_release_status` SET TAGS ('dbx_business_glossary_term' = 'Release Status');
ALTER TABLE `manufacturing_ecm`.`order`.`blanket_order_release` ALTER COLUMN `blanket_order_release_status` SET TAGS ('dbx_active' = 'true');
ALTER TABLE `manufacturing_ecm`.`order`.`blanket_order_release` ALTER COLUMN `blanket_order_release_status` SET TAGS ('dbx_planned' = 'true');
ALTER TABLE `manufacturing_ecm`.`order`.`blanket_order_release` ALTER COLUMN `blanket_order_release_status` SET TAGS ('dbx_released' = 'true');
ALTER TABLE `manufacturing_ecm`.`order`.`blanket_order_release` ALTER COLUMN `blanket_order_release_status` SET TAGS ('dbx_cancelled' = 'true');
ALTER TABLE `manufacturing_ecm`.`order`.`blanket_order_release` ALTER COLUMN `blanket_order_release_status` SET TAGS ('dbx_completed' = 'true');
ALTER TABLE `manufacturing_ecm`.`order`.`blanket_order_release` ALTER COLUMN `release_date` SET TAGS ('dbx_business_glossary_term' = 'Release Date');
ALTER TABLE `manufacturing_ecm`.`order`.`blanket_order_release` ALTER COLUMN `release_number` SET TAGS ('dbx_business_glossary_term' = 'Release Number');
