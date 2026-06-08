-- Schema for Domain: fulfillment | Business: Retail | Version: v1_mvm
-- Generated on: 2026-05-04 13:27:41

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `retail_ecm`.`fulfillment` COMMENT 'Manages order picking, packing, ship-from-store, BOPIS/ROPIS processing, dark store fulfillment, last-mile delivery execution, carrier selection, route optimization, and fulfillment KPI tracking. Owns the operational execution layer between order capture and customer delivery, including transportation planning and last-mile logistics.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `retail_ecm`.`fulfillment`.`fulfillment_order` (
    `fulfillment_order_id` BIGINT COMMENT 'Unique identifier for the fulfillment order. Primary key for this entity.',
    `account_id` BIGINT COMMENT 'Foreign key linking to customer.account. Business justification: B2B fulfillment management: retail B2B accounts have credit limits, tax exemptions, and priority SLAs that must be enforced at fulfillment time. Linking fulfillment_order to customer.account enables a',
    `carrier_id` BIGINT COMMENT 'Reference to the third-party logistics provider or carrier assigned to deliver this fulfillment order.',
    `carrier_service_id` BIGINT COMMENT 'Foreign key linking to fulfillment.carrier_service. Business justification: fulfillment_order has carrier_id FK and denormalized carrier_service_level column, but no FK to carrier_service. Business reality: a fulfillment order is assigned a specific carrier service for shipme',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Fulfillment operations incur labor, packaging, and shipping costs that must be allocated to cost centers for operational expense tracking, budget variance analysis, and P&L reporting by fulfillment ch',
    `fulfillment_node_id` BIGINT COMMENT 'Identifier of the inventory node (store, dark store, distribution center, or warehouse) assigned to fulfill this order.',
    `header_id` BIGINT COMMENT 'Reference to the originating customer order that spawned this fulfillment work order. Links back to the order domain.',
    `location_id` BIGINT COMMENT 'Reference to the retail store location when fulfillment method is ship-from-store, BOPIS, or ROPIS.',
    `loyalty_membership_id` BIGINT COMMENT 'Foreign key linking to loyalty.loyalty_membership. Business justification: Tier-based fulfillment prioritization: VIP/Gold loyalty members receive same-day or priority fulfillment. fulfillment_order.priority_level and fulfillment_method are set based on the members tier at ',
    `outbound_order_id` BIGINT COMMENT 'Foreign key linking to supplychain.outbound_order. Business justification: Store replenishment orders fulfilled from DC create both outbound_order (DC perspective) and fulfillment_order (execution). Links DC dispatch to fulfillment execution for ship-to-store scenarios, enab',
    `price_list_id` BIGINT COMMENT 'Foreign key linking to pricing.price_list. Business justification: Channel-specific and loyalty-tier price lists govern which prices apply to a fulfillment order. Order validation, shipping cost calculation, and promotional eligibility checks all reference the active',
    `price_zone_id` BIGINT COMMENT 'Foreign key linking to pricing.price_zone. Business justification: Fulfillment orders execute in specific price zones for zone-based pricing, shipping cost allocation, and regional pricing compliance. Retail operations track which price zone applies to each fulfillme',
    `profile_id` BIGINT COMMENT 'Reference to the customer who placed the originating order. Required for customer communication and service.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Orders generate revenue attributed to specific profit centers (store, online channel, region) for segment reporting, profitability analysis, and management reporting required for retail financial stat',
    `address_id` BIGINT COMMENT 'Reference to the customer address where this fulfillment order will be delivered. Not applicable for BOPIS/ROPIS orders.',
    `sla_id` BIGINT COMMENT 'Foreign key linking to fulfillment.sla. Business justification: fulfillment_order currently stores sla_target_hours as a scalar, which denormalizes SLA rule data. Adding sla_id FK to the sla master record normalizes this relationship, enabling the fulfillment orde',
    `actual_fulfillment_hours` DECIMAL(18,2) COMMENT 'The actual elapsed time in hours from fulfillment order creation to completion. Used for performance measurement against SLA.',
    `cancellation_reason` STRING COMMENT 'Free-text explanation of why this fulfillment order was cancelled, if applicable. Used for root cause analysis.',
    `completed_timestamp` TIMESTAMP COMMENT 'Timestamp when the fulfillment order reached final completion state (delivered or picked up by customer).',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this fulfillment order.. Valid values are `^[A-Z]{3}$`',
    `fulfillment_assigned_timestamp` TIMESTAMP COMMENT 'Timestamp when the fulfillment order was assigned to a specific fulfillment node and became actionable.',
    `fulfillment_created_timestamp` TIMESTAMP COMMENT 'Timestamp when this fulfillment order record was created in the system. Marks the start of fulfillment processing.',
    `fulfillment_method` STRING COMMENT 'The operational fulfillment strategy used to complete this order. BOPIS = Buy Online Pick Up In Store, ROPIS = Reserve Online Pick Up In Store.. Valid values are `ship_from_store|dark_store|distribution_center|bopis|ropis|drop_ship`',
    `fulfillment_order_number` STRING COMMENT 'Human-readable business identifier for the fulfillment order, used for tracking and communication across systems and with partners.. Valid values are `^FO[0-9]{10}$`',
    `fulfillment_status` STRING COMMENT 'Current lifecycle state of the fulfillment order in the pick-pack-ship workflow. [ENUM-REF-CANDIDATE: created|assigned|picking|picked|packing|packed|shipped|ready_for_pickup|completed|cancelled — 10 candidates stripped; promote to reference product]',
    `gift_message` STRING COMMENT 'Customer-provided gift message to be included with the shipment, if this is a gift order.',
    `is_gift` BOOLEAN COMMENT 'Indicates whether this fulfillment order is a gift, requiring special packaging and excluding pricing information from packing slip.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to this fulfillment order record. Used for change tracking and audit trails.',
    `order_date` TIMESTAMP COMMENT 'Timestamp when the customer placed the originating order. Used for SLA calculation and aging analysis.',
    `package_count` STRING COMMENT 'Number of physical packages or parcels created for this fulfillment order. Orders may be split across multiple packages.',
    `packing_completed_timestamp` TIMESTAMP COMMENT 'Timestamp when the fulfillment order was packed and ready for shipment or pickup.',
    `packing_slip_url` STRING COMMENT 'URL to the packing slip document that accompanies the shipment, listing order contents.',
    `picking_completed_timestamp` TIMESTAMP COMMENT 'Timestamp when all items in the fulfillment order were successfully picked from inventory.',
    `picking_started_timestamp` TIMESTAMP COMMENT 'Timestamp when the picking process began for this fulfillment order.',
    `pickup_location_code` STRING COMMENT 'Designated area or counter code within the store where BOPIS/ROPIS orders are staged for customer pickup.. Valid values are `^[A-Z0-9]{3,10}$`',
    `priority_level` STRING COMMENT 'Processing priority assigned to this fulfillment order based on customer tier, service level, or business rules.. Valid values are `standard|expedited|rush|vip`',
    `promised_delivery_date` DATE COMMENT 'The date communicated to the customer as the expected delivery or pickup availability date. Used for SLA tracking.',
    `shipped_timestamp` TIMESTAMP COMMENT 'Timestamp when the fulfillment order was handed off to the carrier for delivery.',
    `shipping_cost_amount` DECIMAL(18,2) COMMENT 'Actual cost incurred for carrier services to ship this fulfillment order. Used for profitability analysis and cost allocation.',
    `shipping_label_url` STRING COMMENT 'URL to the generated shipping label document for this fulfillment order, used by warehouse staff for package labeling.',
    `special_handling_instructions` STRING COMMENT 'Additional instructions for fulfillment staff regarding fragile items, gift wrapping, temperature control, or other special requirements.',
    `total_item_quantity` STRING COMMENT 'Total number of individual units across all line items in this fulfillment order. Used for capacity planning and picker productivity.',
    `total_line_count` STRING COMMENT 'Number of distinct SKU line items in this fulfillment order. Impacts picking complexity and time.',
    `total_volume_cubic_meters` DECIMAL(18,2) COMMENT 'Total volumetric size of the fulfillment order in cubic meters, used for transportation planning and dimensional weight pricing.',
    `total_weight_kg` DECIMAL(18,2) COMMENT 'Total weight of the fulfillment order in kilograms, used for carrier selection, shipping cost calculation, and capacity planning.',
    `tracking_number` STRING COMMENT 'The carrier-provided tracking identifier used by customers and operations to monitor shipment progress.. Valid values are `^[A-Z0-9]{10,40}$`',
    CONSTRAINT pk_fulfillment_order PRIMARY KEY(`fulfillment_order_id`)
) COMMENT 'Core operational record representing a fulfillment work order created from a customer order. Tracks the end-to-end execution of picking, packing, and shipping activities for a single order or order subset. Captures fulfillment method (ship-from-store, dark store, DC, BOPIS, ROPIS, drop-ship), assigned fulfillment node, SLA commitment, promised delivery date, current fulfillment status, and carrier assignment. This is the primary entity in the fulfillment domain and the operational counterpart to the order domains order record.';

CREATE OR REPLACE TABLE `retail_ecm`.`fulfillment`.`fulfillment_line` (
    `fulfillment_line_id` BIGINT COMMENT 'Unique identifier for the fulfillment line item. Primary key for this entity.',
    `cost_price_id` BIGINT COMMENT 'Foreign key linking to pricing.cost_price. Business justification: COGS recognition at the fulfillment line level requires the authoritative cost_price record. Landed-cost-based gross margin reporting per shipped line, and cost variance analysis for substituted SKUs,',
    `fulfillment_node_id` BIGINT COMMENT 'Identifier of the specific fulfillment location (DC number, store number, vendor ID, etc.). Links to the physical location that executed fulfillment.',
    `fulfillment_order_id` BIGINT COMMENT 'Reference to the parent fulfillment order header. Links this line to the overall fulfillment order.',
    `lot_id` BIGINT COMMENT 'Foreign key linking to inventory.lot. Business justification: Lot traceability in fulfillment: for perishables, pharmaceuticals, and recalled goods, fulfillment lines must reference the specific inventory lot picked. Replacing the denormalized lot_number with a ',
    `order_line_id` BIGINT COMMENT 'Reference to the original sales order line that this fulfillment line is satisfying. Links fulfillment execution back to customer order.',
    `po_line_id` BIGINT COMMENT 'Foreign key linking to supplychain.po_line. Business justification: Drop-ship and vendor-direct fulfillment: in retail drop-ship operations, each fulfillment line is sourced from a specific PO line; this link enables vendor fill-rate tracking, cost reconciliation, and',
    `shipment_id` BIGINT COMMENT 'Foreign key linking to fulfillment.shipment. Business justification: A fulfillment line is shipped via a specific shipment. This FK enables end-to-end traceability from the order line through fulfillment to the physical shipment, supporting ship_timestamp reconciliatio',
    `shipment_package_id` BIGINT COMMENT 'Foreign key linking to fulfillment.shipment_package. Business justification: A fulfillment line is packed into a specific shipment package (carton). This granular FK enables package-level traceability for each SKU, supports contents_summary validation, enables package weight/d',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: Fulfillment lines must reference the product SKU being fulfilled. The product_name column becomes redundant as it can be joined from product.sku. This links fulfillment execution to the product catalo',
    `sku_price_id` BIGINT COMMENT 'Foreign key linking to pricing.sku_price. Business justification: Each fulfillment line ships a SKU at a specific price point. Linking to sku_price enables line-level margin reporting, price audit trails for returns/refunds, and substitution price-variance analysis.',
    `vendor_item_id` BIGINT COMMENT 'Foreign key linking to supplier.vendor_item. Business justification: Fulfillment costing and allocation decisions require vendor item master data for cost, pack configuration, and vendor-specific attributes. Real-world WMS systems query vendor_item during order fulfill',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this fulfillment line record was first created in the system. Audit trail for record creation.',
    `exception_code` STRING COMMENT 'Code identifying any exception or issue encountered during fulfillment of this line (stockout, damage, mispick, etc.). Null if no exception occurred.',
    `exception_description` STRING COMMENT 'Detailed description of the fulfillment exception or issue. Provides context for exception resolution and process improvement.',
    `expiry_date` DATE COMMENT 'Expiration date of the picked inventory. Critical for perishable goods, food safety, and FEFO (First Expired First Out) fulfillment strategies.',
    `extended_cost` DECIMAL(18,2) COMMENT 'Total cost for this line (unit cost × quantity shipped). Represents total COGS for the fulfilled quantity.',
    `fulfillment_source_type` STRING COMMENT 'Type of fulfillment location from which this line was fulfilled (distribution center, store, dark store, vendor direct, third-party logistics). Enables omnichannel fulfillment analysis.. Valid values are `dc|store|dark_store|vendor|3pl`',
    `gtin` STRING COMMENT 'Global Trade Item Number for the product. International standard product identifier used across supply chain and fulfillment systems.. Valid values are `^[0-9]{14}$`',
    `line_number` STRING COMMENT 'Sequential line number within the fulfillment order. Used for ordering and referencing specific line items.',
    `line_status` STRING COMMENT 'Current fulfillment status of this line item. Tracks progression through the fulfillment workflow from allocation to shipment. [ENUM-REF-CANDIDATE: pending|allocated|picked|packed|shipped|cancelled|exception — 7 candidates stripped; promote to reference product]',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this fulfillment line record was last updated. Audit trail for record changes.',
    `original_sku` STRING COMMENT 'The originally ordered SKU if this line is a substitution. Null if no substitution occurred. Enables tracking of substitution patterns and customer acceptance.',
    `pack_timestamp` TIMESTAMP COMMENT 'Date and time when this line was packed into a shipping container. Used for throughput analysis and bottleneck identification.',
    `pick_location` STRING COMMENT 'The warehouse location (aisle, bin, shelf) from which this item was picked. Used for inventory tracking and pick path optimization.',
    `pick_timestamp` TIMESTAMP COMMENT 'Date and time when this line was physically picked from inventory. Critical for cycle time analysis and SLA tracking.',
    `quantity_allocated` DECIMAL(18,2) COMMENT 'The quantity of inventory allocated or reserved for this fulfillment line. Represents inventory commitment before physical picking.',
    `quantity_cancelled` DECIMAL(18,2) COMMENT 'The quantity cancelled and not fulfilled for this line. Represents unfulfilled demand due to stockouts, customer cancellation, or other exceptions.',
    `quantity_ordered` DECIMAL(18,2) COMMENT 'The quantity of this item originally requested in the order. Represents the customer demand that fulfillment is attempting to satisfy.',
    `quantity_packed` DECIMAL(18,2) COMMENT 'The quantity successfully packed into shipping containers for this line. Represents items ready for shipment.',
    `quantity_picked` DECIMAL(18,2) COMMENT 'The actual quantity physically picked from inventory for this line. May differ from ordered quantity due to stockouts or picking errors.',
    `quantity_shipped` DECIMAL(18,2) COMMENT 'The quantity actually shipped to the customer for this line. Final fulfilled quantity that left the facility.',
    `serial_number` STRING COMMENT 'Unique serial number of the individual item picked, if serialized inventory. Enables item-level tracking for high-value or regulated products.',
    `ship_timestamp` TIMESTAMP COMMENT 'Date and time when this line was shipped from the facility. Marks completion of fulfillment execution and start of delivery.',
    `substitution_flag` BOOLEAN COMMENT 'Indicates whether this line represents a product substitution (true) or the originally ordered item (false). Used to track when alternative products are fulfilled.',
    `substitution_reason_code` STRING COMMENT 'Reason code explaining why a substitution was made. Used for root cause analysis and inventory planning.. Valid values are `out_of_stock|discontinued|damaged|customer_request|upgrade|downgrade`',
    `unit_cost` DECIMAL(18,2) COMMENT 'Cost of Goods Sold (COGS) per unit for this item. Used for inventory valuation and profitability analysis.',
    `unit_of_measure` STRING COMMENT 'The unit of measure for all quantities on this line (each, case, pallet, etc.). Defines how quantities are counted and tracked.. Valid values are `each|case|pallet|box|pack|unit`',
    `upc` STRING COMMENT 'Universal Product Code barcode identifier. Standard 12-digit product identifier used for scanning and product identification.. Valid values are `^[0-9]{12}$`',
    `weight` DECIMAL(18,2) COMMENT 'Total weight of the picked quantity for this line. Used for shipping cost calculation and carrier selection.',
    `weight_unit` STRING COMMENT 'Unit of measure for the weight field (pounds, kilograms, etc.). Standardizes weight reporting across fulfillment operations.. Valid values are `lb|kg|oz|g`',
    CONSTRAINT pk_fulfillment_line PRIMARY KEY(`fulfillment_line_id`)
) COMMENT 'Line-level detail of a fulfillment order, representing each SKU/UPC being fulfilled. Captures quantity requested, quantity picked, quantity packed, quantity shipped, unit of measure, pick location, substitution flag, and line-level fulfillment status. Enables granular tracking of partial fulfillments, substitutions, and out-of-stock exceptions at the item level.';

CREATE OR REPLACE TABLE `retail_ecm`.`fulfillment`.`shipment` (
    `shipment_id` BIGINT COMMENT 'Primary key for shipment',
    `carrier_id` BIGINT COMMENT 'Foreign key linking to fulfillment.carrier. Business justification: shipment has denormalized carrier_code and carrier_name columns but no FK to carrier master. Adding carrier_id FK allows joining to carrier for full carrier details (contact info, capabilities, contra',
    `carrier_rate_id` BIGINT COMMENT 'Foreign key linking to fulfillment.carrier_rate. Business justification: A shipment is executed at a specific contracted carrier rate. Linking shipment to carrier_rate enables freight cost reconciliation (actual shipping_cost_amount vs contracted base_rate_amount), rate au',
    `carrier_service_id` BIGINT COMMENT 'Foreign key linking to fulfillment.carrier_service. Business justification: shipment has denormalized service_level column but no FK to carrier_service (in addition to the carrier_id FK proposed above). Business reality: a shipment is dispatched using a specific carrier servi',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Shipping costs (carrier charges, packaging materials, labor) are operational expenses allocated to cost centers for budget tracking, variance analysis, and fulfillment cost-per-order KPI reporting use',
    `fulfillment_node_id` BIGINT COMMENT 'Reference to the fulfillment node (distribution center, store, dark store, or micro-fulfillment center) from which the shipment originated.',
    `fulfillment_order_id` BIGINT COMMENT 'Foreign key linking to fulfillment.fulfillment_order. Business justification: shipment is the physical dispatch output of a fulfillment_order (the operational work order). Currently shipment only links to order_header, missing the operational lineage. Adding fulfillment_order_i',
    `header_id` BIGINT COMMENT 'Reference to the parent order that this shipment fulfills. Links shipment to the originating customer order.',
    `outbound_shipment_id` BIGINT COMMENT 'Foreign key linking to supplychain.outbound_shipment. Business justification: Same physical shipment tracked in both domains. Fulfillment.shipment is customer-facing view; outbound_shipment is DC logistics view. Essential for unified shipment visibility, freight reconciliation,',
    `price_zone_id` BIGINT COMMENT 'Foreign key linking to pricing.price_zone. Business justification: Shipment-level carrier billing reconciliation and zone-based shipping cost reporting require the price zone. The shipment is the physical execution record used for carrier invoice matching; zone-level',
    `profile_id` BIGINT COMMENT 'Reference to the customer receiving the shipment. Primary party reference for the transaction.',
    `location_id` BIGINT COMMENT 'Foreign key linking to store.location. Business justification: Ship-from-store operations require attributing each outbound shipment to its originating store location for store-level shipment volume reporting, carrier pickup scheduling, and store P&L cost allocat',
    `address_id` BIGINT COMMENT 'Foreign key linking to customer.address. Business justification: Shipment delivery address normalization: retail operations require a proper FK to customer.address for address validation, carrier label generation, and returns processing. The current denormalized sh',
    `sla_id` BIGINT COMMENT 'Foreign key linking to fulfillment.sla. Business justification: A shipment operates under a specific SLA governing delivery commitments (promised_hours_to_deliver, carrier_cutoff_time, geographic_scope). Linking shipment to sla enables SLA compliance tracking at t',
    `wave_id` BIGINT COMMENT 'Foreign key linking to supplychain.wave. Business justification: DC wave-to-shipment reconciliation: retail DCs release waves that produce shipments; linking shipment to wave enables wave throughput reporting, carrier load planning, and SLA breach root-cause analys',
    `actual_delivery_date` DATE COMMENT 'Actual date when the shipment was successfully delivered to the recipient. Used for on-time delivery performance measurement.',
    `carrier_charge_amount` DECIMAL(18,2) COMMENT 'Actual cost charged by the carrier for transporting this shipment. Used for freight cost accounting and margin analysis.',
    `carrier_charge_currency_code` STRING COMMENT 'Three-letter ISO currency code for the carrier charge amount (e.g., USD, CAD, EUR).. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the shipment record was first created in the system. Audit field for record lifecycle tracking.',
    `declared_value_amount` DECIMAL(18,2) COMMENT 'Declared monetary value of the shipment contents for insurance and customs purposes. Used to determine carrier liability limits.',
    `declared_value_currency_code` STRING COMMENT 'Three-letter ISO currency code for the declared value amount (e.g., USD, CAD, EUR).. Valid values are `^[A-Z]{3}$`',
    `delivery_instructions` STRING COMMENT 'Special instructions provided by the customer for delivery handling (e.g., leave at door, ring bell, gate code). Passed to carrier for execution.',
    `delivery_signature_required_flag` BOOLEAN COMMENT 'Indicates whether a recipient signature is required upon delivery for proof of receipt. True if signature required, false otherwise.',
    `estimated_delivery_date` DATE COMMENT 'Carrier-provided or system-calculated expected delivery date communicated to the customer. Used for Service Level Agreement (SLA) tracking.',
    `fulfillment_type` STRING COMMENT 'Classification of the fulfillment method used for this shipment. Distinguishes between standard shipping, Buy Online Pick Up In Store (BOPIS), Reserve Online Pick Up In Store (ROPIS), ship-from-store, drop-ship, and curbside pickup.. Valid values are `standard|bopis|ropis|ship_from_store|drop_ship|curbside`',
    `hazmat_flag` BOOLEAN COMMENT 'Indicates whether the shipment contains hazardous materials requiring special handling and documentation. True if hazmat, false otherwise.',
    `height_cm` DECIMAL(18,2) COMMENT 'Shortest dimension of the shipment in centimeters. Used for carrier rating and dimensional weight calculations.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the shipment record was most recently modified. Audit field for change tracking and data freshness monitoring.',
    `length_cm` DECIMAL(18,2) COMMENT 'Longest dimension of the shipment in centimeters. Used for carrier rating and dimensional weight calculations.',
    `package_count` STRING COMMENT 'Total number of physical packages or parcels included in this shipment. Supports multi-package shipment tracking.',
    `ship_date` DATE COMMENT 'Date when the shipment was physically dispatched from the fulfillment node. Key business event timestamp for fulfillment cycle time measurement.',
    `ship_from_location_type` STRING COMMENT 'Classification of the originating fulfillment location type. Supports omnichannel fulfillment analytics including ship-from-store (SFS) and dark store operations.. Valid values are `distribution_center|store|dark_store|micro_fulfillment_center|vendor`',
    `ship_to_contact_name` STRING COMMENT 'Name of the recipient or contact person at the delivery destination. Used for delivery confirmation and communication.',
    `ship_to_email_address` STRING COMMENT 'Email address for shipment tracking notifications and delivery updates sent to the recipient.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `ship_to_phone_number` STRING COMMENT 'Contact phone number for the shipment recipient. Used by carriers for delivery coordination and customer notifications.',
    `shipment_number` STRING COMMENT 'Externally visible unique shipment identifier used for customer tracking and carrier communication. Business identifier for the shipment.. Valid values are `^SHP[0-9]{10}$`',
    `shipment_status` STRING COMMENT 'Current lifecycle status of the shipment in the fulfillment workflow. Tracks progression from creation through final delivery or return. [ENUM-REF-CANDIDATE: created|picked|packed|manifested|in_transit|out_for_delivery|delivered|failed_delivery|returned|cancelled — 10 candidates stripped; promote to reference product]',
    `shipping_cost_amount` DECIMAL(18,2) COMMENT 'Total cost charged to the customer for shipping this shipment. Includes base shipping rate and any surcharges.',
    `shipping_cost_currency_code` STRING COMMENT 'Three-letter ISO currency code for the shipping cost amount (e.g., USD, CAD, EUR).. Valid values are `^[A-Z]{3}$`',
    `signature_name` STRING COMMENT 'Name of the person who signed for the shipment upon delivery. Captured for proof of delivery and dispute resolution.',
    `total_volume_cubic_meters` DECIMAL(18,2) COMMENT 'Total volumetric measurement of the shipment in cubic meters. Used for dimensional weight pricing and transportation planning.',
    `total_weight_kg` DECIMAL(18,2) COMMENT 'Total weight of the shipment in kilograms, including all packages and packaging materials. Used for carrier billing and capacity planning.',
    `tracking_number` STRING COMMENT 'Carrier-assigned unique tracking identifier used for shipment visibility and proof of delivery. Enables customer and internal tracking through carrier systems.',
    `width_cm` DECIMAL(18,2) COMMENT 'Middle dimension of the shipment in centimeters. Used for carrier rating and dimensional weight calculations.',
    CONSTRAINT pk_shipment PRIMARY KEY(`shipment_id`)
) COMMENT 'Master record for a physical shipment dispatched to a customer or transfer destination. Captures carrier, tracking number, ship date, estimated delivery date, actual delivery date, shipment weight, dimensions, number of packages, ship-from node, ship-to address, service level (ground, 2-day, overnight), and shipment status. Serves as the SSOT for all outbound shipment tracking across channels including e-commerce, BOPIS, and store-to-door.';

CREATE OR REPLACE TABLE `retail_ecm`.`fulfillment`.`shipment_package` (
    `shipment_package_id` BIGINT COMMENT 'Unique identifier for the shipment package. Primary key.',
    `carrier_id` BIGINT COMMENT 'Reference to the carrier (third-party logistics provider) responsible for transporting this package.',
    `carrier_service_id` BIGINT COMMENT 'Foreign key linking to fulfillment.carrier_service. Business justification: shipment_package has carrier_id FK and denormalized carrier_service_level column, but no FK to carrier_service. Business reality: each package is shipped using a specific carrier service offering. Add',
    `fulfillment_node_id` BIGINT COMMENT 'Reference to the fulfillment location (distribution center, store, dark store, or micro-fulfillment center) where this package was prepared.',
    `header_id` BIGINT COMMENT 'Reference to the customer order being fulfilled by this package.',
    `outbound_shipment_id` BIGINT COMMENT 'Foreign key linking to supplychain.outbound_shipment. Business justification: Packages in customer shipments may originate from DC outbound operations (cross-dock, ship-from-store with DC consolidation). Links package-level fulfillment tracking to upstream DC dispatch for multi',
    `shipment_id` BIGINT COMMENT 'Reference to the parent shipment that contains this package. A single shipment may contain multiple packages.',
    `actual_delivery_timestamp` TIMESTAMP COMMENT 'Date and time when the package was actually delivered to the customer, confirming successful fulfillment.',
    `billable_weight_kg` DECIMAL(18,2) COMMENT 'The greater of actual weight or dimensional weight, used as the basis for carrier shipping charges.',
    `contents_summary` STRING COMMENT 'High-level description of package contents, often used for customs declarations or customer communication (e.g., Apparel and Electronics).',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this package record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this record.. Valid values are `^[A-Z]{3}$`',
    `delivery_confirmation_method` STRING COMMENT 'Method used to confirm successful delivery of the package (e.g., signature, photo proof, GPS coordinates, contactless delivery). [ENUM-REF-CANDIDATE: signature|photo|gps|contactless|left_at_door|handed_to_resident|locker — 7 candidates stripped; promote to reference product]',
    `delivery_notes` STRING COMMENT 'Free-text notes from the carrier or driver regarding delivery (e.g., Left at front door, Delivered to neighbor).',
    `dimensional_weight_kg` DECIMAL(18,2) COMMENT 'Calculated dimensional weight based on package volume, used by carriers for rating when dimensional weight exceeds actual weight.',
    `estimated_delivery_date` DATE COMMENT 'Carrier-provided estimated date when the package will be delivered to the customer.',
    `height_cm` DECIMAL(18,2) COMMENT 'Height dimension of the package in centimeters, used for carrier rating and capacity planning.',
    `insurance_value_amount` DECIMAL(18,2) COMMENT 'Declared value of the package contents for insurance purposes.',
    `is_hazmat` BOOLEAN COMMENT 'Indicates whether the package contains hazardous materials requiring special handling and labeling per regulatory requirements.',
    `is_insured` BOOLEAN COMMENT 'Indicates whether the package has been insured for loss or damage during transit.',
    `is_label_printed` BOOLEAN COMMENT 'Indicates whether the shipping label has been printed for this package.',
    `is_manifested` BOOLEAN COMMENT 'Indicates whether the package has been included in a carrier manifest and is ready for pickup.',
    `is_sealed` BOOLEAN COMMENT 'Indicates whether the package has been sealed and is ready for shipment.',
    `is_signature_required` BOOLEAN COMMENT 'Indicates whether a signature is required upon delivery for this package.',
    `item_count` STRING COMMENT 'Total number of individual items (SKUs) contained in this package.',
    `labeled_timestamp` TIMESTAMP COMMENT 'Date and time when the shipping label was printed and affixed to the package.',
    `length_cm` DECIMAL(18,2) COMMENT 'Length dimension of the package in centimeters, used for carrier rating and capacity planning.',
    `manifested_timestamp` TIMESTAMP COMMENT 'Date and time when the package was included in the carrier manifest, indicating readiness for carrier pickup.',
    `package_number` STRING COMMENT 'Human-readable business identifier for the package, often printed on the label. May follow internal numbering conventions.',
    `package_sequence` STRING COMMENT 'Sequential position of this package within the parent shipment (e.g., package 1 of 3).',
    `package_status` STRING COMMENT 'Current lifecycle status of the package in the fulfillment and delivery process. [ENUM-REF-CANDIDATE: created|packed|sealed|labeled|manifested|picked_up|in_transit|out_for_delivery|delivered|exception|returned — 11 candidates stripped; promote to reference product]',
    `package_type` STRING COMMENT 'Type of packaging container used for this package.. Valid values are `box|poly_bag|envelope|pallet|crate|tube`',
    `packed_timestamp` TIMESTAMP COMMENT 'Date and time when the package was packed and sealed, marking readiness for shipment.',
    `picked_up_timestamp` TIMESTAMP COMMENT 'Date and time when the carrier physically picked up the package from the fulfillment location.',
    `shipping_cost_amount` DECIMAL(18,2) COMMENT 'Actual shipping cost charged by the carrier for this package.',
    `shipping_method` STRING COMMENT 'Fulfillment method used for this package (e.g., Ship-from-Store (SFS), Distribution Center (DC) fulfillment, Buy Online Pick Up In Store (BOPIS), Reserve Online Pick Up In Store (ROPIS), drop ship). [ENUM-REF-CANDIDATE: ship_from_store|dc_fulfillment|drop_ship|bopis|ropis|curbside|locker — 7 candidates stripped; promote to reference product]',
    `total_packages_in_shipment` STRING COMMENT 'Total number of packages in the parent shipment, providing context for the package sequence.',
    `tracking_number` STRING COMMENT 'Carrier-assigned tracking barcode or number used for end-to-end package visibility and customer tracking.',
    `unit_count` STRING COMMENT 'Total quantity of units across all items in the package (sum of quantities for all SKUs).',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time when this package record was last modified.',
    `weight_kg` DECIMAL(18,2) COMMENT 'Actual weight of the package in kilograms, including contents and packaging materials. Used for carrier rating and shipping cost calculation.',
    `width_cm` DECIMAL(18,2) COMMENT 'Width dimension of the package in centimeters, used for carrier rating and capacity planning.',
    CONSTRAINT pk_shipment_package PRIMARY KEY(`shipment_package_id`)
) COMMENT 'Represents an individual physical package or carton within a shipment. Tracks package dimensions, weight, package type (box, poly bag, envelope), seal status, label printed flag, tracking barcode, contents summary, and package-level delivery confirmation. A single shipment may contain multiple packages, each with its own tracking and delivery status.';

CREATE OR REPLACE TABLE `retail_ecm`.`fulfillment`.`pick_task` (
    `pick_task_id` BIGINT COMMENT 'Primary key for pick_task',
    `carrier_id` BIGINT COMMENT 'Foreign key linking to fulfillment.carrier. Business justification: pick_task has denormalized carrier_code and service_level columns but no FKs to carrier or carrier_service. Business reality: pick tasks are prioritized and routed based on carrier and service level (',
    `carrier_service_id` BIGINT COMMENT 'Foreign key linking to fulfillment.carrier_service. Business justification: Following from pick_task carrier_id FK above, pick_task also needs carrier_service_id FK to normalize service_level. Business reality: pick task prioritization and routing depend on service level (ove',
    `department_id` BIGINT COMMENT 'Foreign key linking to store.department. Business justification: In-store fulfillment pick tasks are executed within specific store departments. Linking pick_task to store.department enables department-level pick productivity reporting, labor budget allocation, and',
    `fulfillment_line_id` BIGINT COMMENT 'Foreign key linking to fulfillment.fulfillment_line. Business justification: A pick task is assigned to pick a specific fulfillment line item (SKU/UPC). Linking pick_task to fulfillment_line enables traceability from the operational task back to the line-level fulfillment reco',
    `fulfillment_node_id` BIGINT COMMENT 'Reference to the fulfillment center, store, or dark store where the task is executed. Supports omnichannel fulfillment including ship-from-store and BOPIS.',
    `fulfillment_order_id` BIGINT COMMENT 'Foreign key linking to fulfillment.fulfillment_order. Business justification: A pick task is created to execute the picking work for a specific fulfillment order. While pick_task already has header_id → order.header, a direct FK to fulfillment_order is the authoritative operati',
    `header_id` BIGINT COMMENT 'Reference to the parent order that generated this pick task. Links the task to the customer order being fulfilled.',
    `outbound_order_id` BIGINT COMMENT 'Foreign key linking to supplychain.outbound_order. Business justification: DC pick tasks fulfill outbound orders (store replenishment). Direct link enables task-to-order traceability for DC operations, supports labor planning tied to outbound order volume, and facilitates pi',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: Warehouse picking operations require resolving the exact SKU record to access dimensions, hazmat flags, age restrictions, and weight for pick validation. The existing plain-text `sku` column is a deno',
    `stock_position_id` BIGINT COMMENT 'Foreign key linking to inventory.stock_position. Business justification: Pick-to-inventory reconciliation: warehouse management systems direct pickers to specific stock positions (bin/shelf locations). Linking pick_task to stock_position enables real-time inventory reserva',
    `wave_id` BIGINT COMMENT 'Reference to the wave batch that this task belongs to. Wave-based picking groups tasks for efficient fulfillment execution.',
    `aisle` STRING COMMENT 'Aisle location within the warehouse where the item is stored. Part of the physical location hierarchy for item retrieval.. Valid values are `^[A-Z0-9]{1,10}$`',
    `assigned_timestamp` TIMESTAMP COMMENT 'Date and time when the task was assigned to the warehouse associate. Marks the start of the task lifecycle.',
    `bay` STRING COMMENT 'Bay location within the aisle where the item is stored. Provides granular location detail for picking accuracy.. Valid values are `^[A-Z0-9]{1,10}$`',
    `completion_timestamp` TIMESTAMP COMMENT 'Date and time when the task was completed by the associate. Used for throughput analysis and SLA tracking.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the pick task record was created in the system. Audit field for data lineage and task generation tracking.',
    `customer_approval_status` STRING COMMENT 'Customer approval status for the substitution. Tracks whether customer accepted the replacement item for BOPIS and delivery orders.. Valid values are `approved|rejected|pending|not_required`',
    `exception_code` STRING COMMENT 'Code identifying the type of exception encountered during task execution. Used for root cause analysis and process improvement.. Valid values are `^[A-Z0-9]{2,10}$`',
    `exception_reason` STRING COMMENT 'Detailed description of the exception or issue encountered during task execution. Provides context for exception resolution.',
    `fulfillment_channel` STRING COMMENT 'Channel through which the order is being fulfilled. Supports omnichannel fulfillment strategy including store-based and centralized fulfillment.. Valid values are `ship_from_store|dark_store|distribution_center|bopis|ropis|curbside`',
    `label_applied` BOOLEAN COMMENT 'Indicates whether the shipping label was successfully applied to the package. Critical checkpoint for shipment readiness.',
    `original_sku` STRING COMMENT 'Original SKU requested before substitution. Captured when substitution_occurred is true for order accuracy tracking.. Valid values are `^[A-Z0-9-]{6,20}$`',
    `package_type` STRING COMMENT 'Type of packaging used for the shipment. Determines shipping method, carrier selection, and dimensional weight calculation.. Valid values are `box|envelope|poly_bag|tube|pallet|tote`',
    `packing_slip_printed` BOOLEAN COMMENT 'Indicates whether the packing slip was printed and included in the package. Required for customer order verification.',
    `packing_station_code` STRING COMMENT 'Identifier for the packing station where the item is packed. Used for pack tasks and station utilization tracking.. Valid values are `^[A-Z0-9]{1,15}$`',
    `pick_task_status` STRING COMMENT 'Current lifecycle state of the pick task. Tracks progression from assignment through completion or exception handling. [ENUM-REF-CANDIDATE: pending|assigned|in_progress|completed|exception|cancelled|on_hold — 7 candidates stripped; promote to reference product]',
    `priority_level` STRING COMMENT 'Numeric priority ranking for task execution sequence. Lower numbers indicate higher priority. Used for queue management and SLA adherence.',
    `quality_check_outcome` STRING COMMENT 'Result of the quality check performed on the picked items. Ensures accuracy and condition standards before shipment.. Valid values are `passed|failed|not_required|pending`',
    `quantity_picked` DECIMAL(18,2) COMMENT 'Actual quantity of the item picked by the associate. May differ from requested quantity due to inventory discrepancies or short picks.',
    `quantity_requested` DECIMAL(18,2) COMMENT 'Original quantity of the item requested for picking. Represents the target quantity from the order or wave plan.',
    `shelf` STRING COMMENT 'Shelf level within the bay where the item is stored. Completes the physical location coordinates for item retrieval.. Valid values are `^[A-Z0-9]{1,10}$`',
    `start_timestamp` TIMESTAMP COMMENT 'Date and time when the associate began executing the task. Used to calculate task duration and associate productivity.',
    `substituted_sku` STRING COMMENT 'Replacement SKU provided when original item was unavailable. Used for substitution analysis and customer communication.. Valid values are `^[A-Z0-9-]{6,20}$`',
    `substitution_occurred` BOOLEAN COMMENT 'Indicates whether a product substitution was made during picking. Common in grocery and BOPIS fulfillment when original item is unavailable.',
    `task_duration_seconds` STRING COMMENT 'Total time in seconds from task start to completion. Used for associate productivity analysis and labor standards calibration.',
    `task_method` STRING COMMENT 'Picking methodology used for task execution. Defines how items are grouped and picked for optimal efficiency.. Valid values are `single_order|batch|zone|wave|cluster`',
    `task_number` STRING COMMENT 'Human-readable business identifier for the pick task. Used by warehouse associates to reference and track tasks.. Valid values are `^[A-Z0-9]{8,20}$`',
    `task_type` STRING COMMENT 'Classification of the fulfillment task activity. Determines the workflow and execution requirements for the task.. Valid values are `pick|pack|quality_check|value_added_service|replenishment|cycle_count`',
    `unit_of_measure` STRING COMMENT 'Unit of measure for the quantity being picked. Defines whether picking is by individual units, cases, or other packaging levels.. Valid values are `each|case|pallet|box|pack`',
    `upc` STRING COMMENT 'Universal Product Code barcode for the item. Used for scanning and verification during pick execution.. Valid values are `^[0-9]{12}$`',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time when the pick task record was last modified. Audit field for change tracking and data quality monitoring.',
    `void_fill_used` BOOLEAN COMMENT 'Indicates whether void fill material was used in the package. Tracks packaging material usage for cost and sustainability reporting.',
    `work_zone` STRING COMMENT 'Designated zone within the fulfillment location where the task is performed. Used for zone-based picking and associate assignment.. Valid values are `^[A-Z0-9]{1,10}$`',
    CONSTRAINT pk_pick_task PRIMARY KEY(`pick_task_id`)
) COMMENT 'Unified operational task record for all fulfillment execution activities including picking, packing, quality checks, and value-added services. Captures task type (pick, pack, QC, VAS), assigned associate, work zone, location (aisle, bay, shelf, packing station), SKU/items, quantity requested vs actual, task method (single, batch, zone, wave), priority, status (assigned, in-progress, completed, exception), start time, completion time, quality check outcome, packing details (station ID, package type, void fill, label applied, packing slip printed), and substitution outcome (original SKU, substituted SKU, customer approval status). Supports wave-based task generation from WMS systems including Manhattan Associates and Blue Yonder. Enables associate productivity tracking, task queue management, and fulfillment throughput analytics across the entire pick-pack-QC workflow.';

CREATE OR REPLACE TABLE `retail_ecm`.`fulfillment`.`pack_task` (
    `pack_task_id` BIGINT COMMENT 'Unique identifier for the packing task record. Primary key for the pack task entity.',
    `carrier_id` BIGINT COMMENT 'Foreign key linking to fulfillment.carrier. Business justification: pack_task has denormalized carrier_code and service_level columns but no FKs to carrier or carrier_service. Business reality: a pack task prepares a package for a specific carrier. Adding carrier_id F',
    `carrier_service_id` BIGINT COMMENT 'Foreign key linking to fulfillment.carrier_service. Business justification: Following from pack_task carrier_id FK above, pack_task also needs carrier_service_id FK to normalize service_level. Business reality: packing requirements vary by service level (overnight requires sp',
    `fulfillment_line_id` BIGINT COMMENT 'Foreign key linking to fulfillment.fulfillment_line. Business justification: A pack task packs specific fulfillment line items. Linking pack_task to fulfillment_line enables quantity reconciliation (items_packed_count vs quantity_ordered), exception tracking at the line level,',
    `fulfillment_node_id` BIGINT COMMENT 'Reference to the fulfillment location (distribution center, dark store, or ship-from-store location) where packing occurred.',
    `fulfillment_order_id` BIGINT COMMENT 'Foreign key linking to fulfillment.fulfillment_order. Business justification: A pack task is the packing station workflow for a specific fulfillment order. While pack_task has header_id → order.header, a direct FK to fulfillment_order is the authoritative in-domain parent. This',
    `header_id` BIGINT COMMENT 'Reference to the customer order being fulfilled by this pack task. Enables traceability from packing back to the original order.',
    `outbound_order_id` BIGINT COMMENT 'Foreign key linking to supplychain.outbound_order. Business justification: DC pack tasks package outbound orders for store replenishment. Links packing execution to supply chain order, supports packing productivity analysis by order type, and enables outbound order status up',
    `pick_task_id` BIGINT COMMENT 'Reference to the upstream pick task that provided the items for this packing operation. Links the packing workflow to the picking workflow.',
    `shipment_id` BIGINT COMMENT 'Reference to the shipment record that this packed package will be included in for carrier handoff and delivery.',
    `shipment_package_id` BIGINT COMMENT 'Foreign key linking to fulfillment.shipment_package. Business justification: A pack task produces or fills a specific shipment_package. Linking pack_task to shipment_package closes the operational loop between the packing workflow and the physical package record, enabling pack',
    `wave_id` BIGINT COMMENT 'Foreign key linking to supplychain.wave. Business justification: Wave-level packing throughput reporting: pack tasks are released as part of a wave in DC operations; linking pack_task to wave enables wave completion tracking, labor productivity by wave, and packing',
    `assigned_timestamp` TIMESTAMP COMMENT 'Timestamp when the pack task was assigned to the packer. Used to measure queue time and task aging.',
    `completed_timestamp` TIMESTAMP COMMENT 'Timestamp when the pack task reached completed status and the package was ready for carrier handoff. Used for SLA tracking and throughput measurement.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the pack task record was first created in the system. Used for audit trail and data lineage.',
    `exception_code` STRING COMMENT 'Code identifying the type of exception encountered during packing. Used for root cause analysis and process improvement. [ENUM-REF-CANDIDATE: short_pick|damaged_item|wrong_item|missing_label|scale_mismatch|oversized|none — 7 candidates stripped; promote to reference product]',
    `exception_notes` STRING COMMENT 'Free-text notes describing the exception or special handling required. Provides context for exception resolution and audit trail.',
    `fulfillment_type` STRING COMMENT 'Type of fulfillment method for this pack task. Determines packing requirements, labeling, and handoff process. BOPIS (Buy Online Pick Up In Store), ROPIS (Reserve Online Pick Up In Store), SFS (Ship From Store).. Valid values are `standard_ship|bopis|ropis|sfs|dark_store|same_day`',
    `gift_message_included_flag` BOOLEAN COMMENT 'Indicates whether a personalized gift message was printed and included in the package per customer request.',
    `gift_wrap_flag` BOOLEAN COMMENT 'Indicates whether gift wrapping service was requested and applied to this package. Impacts packing time and material cost.',
    `hazmat_flag` BOOLEAN COMMENT 'Indicates whether the package contains hazardous materials requiring special handling, labeling, and carrier compliance documentation.',
    `insurance_value_amount` DECIMAL(18,2) COMMENT 'Declared value of the package contents for insurance purposes. Used to determine insurance premium and claim limits.',
    `items_packed_count` STRING COMMENT 'Total number of individual items (SKUs) packed into the package for this task. Used for productivity measurement and quality verification.',
    `pack_duration_seconds` STRING COMMENT 'Total time in seconds spent on the packing operation from start to completion. Key metric for labor standards and productivity analysis.',
    `pack_end_timestamp` TIMESTAMP COMMENT 'Timestamp when the packing operation was completed and the package was sealed. Used to calculate pack cycle time and throughput.',
    `pack_start_timestamp` TIMESTAMP COMMENT 'Timestamp when the packer began the packing operation. Used to calculate pack cycle time and labor productivity.',
    `package_height_cm` DECIMAL(18,2) COMMENT 'Height dimension of the package in centimeters. Used for dimensional weight calculation and carrier compliance.',
    `package_length_cm` DECIMAL(18,2) COMMENT 'Length dimension of the package in centimeters. Used for dimensional weight calculation and carrier compliance.',
    `package_size` STRING COMMENT 'Standardized size designation of the package selected. Used for dimensional weight calculation and carrier rate determination. [ENUM-REF-CANDIDATE: XS|S|M|L|XL|XXL|custom — 7 candidates stripped; promote to reference product]',
    `package_type` STRING COMMENT 'Type of packaging material selected by the packer for this task. Influences shipping cost, protection level, and carrier handling.. Valid values are `box|poly_mailer|padded_envelope|tube|pallet|tote`',
    `package_weight_kg` DECIMAL(18,2) COMMENT 'Actual weight of the sealed package in kilograms, measured at the packing station. Used for carrier rate calculation and compliance verification.',
    `package_width_cm` DECIMAL(18,2) COMMENT 'Width dimension of the package in centimeters. Used for dimensional weight calculation and carrier compliance.',
    `packing_slip_printed_flag` BOOLEAN COMMENT 'Indicates whether the packing slip document was successfully printed and included in the package. Required for customer order verification.',
    `packing_station_code` STRING COMMENT 'Identifier of the physical packing station where the task was performed. Used for workload balancing and station performance analysis.. Valid values are `^PS-[A-Z0-9]{3,10}$`',
    `quality_check_performed_by` BIGINT COMMENT 'Identifier of the associate who performed the quality inspection. Used for accountability and training needs identification.',
    `quality_check_status` STRING COMMENT 'Result of the quality inspection performed on the packed package. Failed status triggers rework or escalation.. Valid values are `passed|failed|pending|not_required|exception`',
    `shipping_label_applied_flag` BOOLEAN COMMENT 'Indicates whether the carrier shipping label was successfully printed and affixed to the package. Required for carrier acceptance.',
    `signature_required_flag` BOOLEAN COMMENT 'Indicates whether the shipment requires recipient signature upon delivery. Impacts carrier service selection and cost.',
    `task_number` STRING COMMENT 'Human-readable business identifier for the pack task. Used for operational tracking, troubleshooting, and communication between warehouse staff.. Valid values are `^PKT-[0-9]{8,12}$`',
    `task_priority` STRING COMMENT 'Priority level assigned to the pack task based on order SLA, shipping cutoff time, or customer tier. Determines task sequencing at the packing station.. Valid values are `urgent|high|normal|low`',
    `task_status` STRING COMMENT 'Current lifecycle state of the packing task. Tracks progression from assignment through completion or exception handling.. Valid values are `assigned|in_progress|completed|quality_hold|exception|cancelled`',
    `tracking_number` STRING COMMENT 'Unique tracking identifier assigned by the carrier for shipment visibility. Provided to customer for delivery status monitoring.. Valid values are `^[A-Z0-9]{10,35}$`',
    `units_packed_count` STRING COMMENT 'Total quantity of units packed across all items. Differs from items_packed_count when multiple units of the same SKU are included.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the pack task record was last modified. Used for audit trail and change tracking.',
    `void_fill_type` STRING COMMENT 'Type of void fill material used to protect items and prevent shifting during transit. Impacts packaging cost and sustainability metrics.. Valid values are `air_pillows|bubble_wrap|paper|foam_peanuts|none`',
    CONSTRAINT pk_pack_task PRIMARY KEY(`pack_task_id`)
) COMMENT 'Operational task record for the packing station workflow. Captures packer assignment, packing station ID, items packed, package type selected, void fill used, packing slip printed flag, label applied flag, pack start time, pack end time, and quality check status. Tracks the transition from picked items to sealed, labeled packages ready for carrier handoff.';

CREATE OR REPLACE TABLE `retail_ecm`.`fulfillment`.`carrier` (
    `carrier_id` BIGINT COMMENT 'Primary key for carrier',
    `api_integration_flag` BOOLEAN COMMENT 'Indicates whether the carrier provides API integration capabilities for real-time rate shopping, booking, and tracking.',
    `base_rate_per_lb` DECIMAL(18,2) COMMENT 'Negotiated base shipping rate per pound for standard service level, before surcharges and adjustments.',
    `bopis_ready_flag` BOOLEAN COMMENT 'Indicates whether the carrier supports BOPIS fulfillment logistics including store-to-customer handoff coordination.',
    `carrier_code` STRING COMMENT 'Internal short code or abbreviation used to identify the carrier in operational systems.. Valid values are `^[A-Z0-9]{2,10}$`',
    `carrier_name` STRING COMMENT 'The legal business name of the carrier or third-party logistics (3PL) provider.',
    `carrier_status` STRING COMMENT 'Current operational status of the carrier relationship indicating whether the carrier is available for shipment assignment.. Valid values are `active|inactive|suspended|pending_approval`',
    `carrier_type` STRING COMMENT 'Classification of the carrier based on service model: parcel (small package), LTL (Less Than Truckload), FTL (Full Truckload), last-mile delivery, same-day delivery, or third-party logistics (3PL) provider.. Valid values are `parcel|ltl|ftl|last_mile|same_day|3pl`',
    `contact_email` STRING COMMENT 'Email address of the primary carrier contact for operational communication and escalations.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `contact_name` STRING COMMENT 'Name of the primary account representative or contact person at the carrier for operational coordination and issue resolution.',
    `contact_phone` STRING COMMENT 'Phone number of the primary carrier contact for urgent operational issues and coordination.',
    `contract_end_date` DATE COMMENT 'Date when the carrier service contract expires or is scheduled for renewal.',
    `contract_start_date` DATE COMMENT 'Date when the carrier service contract or agreement became effective.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the carrier master record was first created in the system.',
    `cutoff_time_local` STRING COMMENT 'Daily cutoff time in local warehouse time zone (HH:MM format) by which shipments must be tendered to the carrier to qualify for same-day pickup and service level commitment.. Valid values are `^([01]?[0-9]|2[0-3]):[0-5][0-9]$`',
    `dimensional_weight_factor` DECIMAL(18,2) COMMENT 'Divisor used to calculate dimensional weight from package dimensions (length x width x height / factor). Common values are 139 for domestic and 166 for international.',
    `edi_capable_flag` BOOLEAN COMMENT 'Indicates whether the carrier supports Electronic Data Interchange (EDI) for automated shipment booking, tracking, and invoicing.',
    `extended_area_surcharge` DECIMAL(18,2) COMMENT 'Additional fee charged for deliveries to remote or extended service areas beyond standard coverage zones.',
    `fuel_surcharge_percentage` DECIMAL(18,2) COMMENT 'Current fuel surcharge percentage applied to base shipping rates, typically adjusted monthly based on fuel price indices.',
    `geographic_coverage` STRING COMMENT 'Description of the geographic regions and countries where the carrier provides service coverage. May include restrictions or limitations.',
    `hazmat_certified_flag` BOOLEAN COMMENT 'Indicates whether the carrier is certified and authorized to transport hazardous materials under Department of Transportation (DOT) regulations.',
    `insurance_coverage_flag` BOOLEAN COMMENT 'Indicates whether the carrier offers shipment insurance or declared value coverage for high-value packages.',
    `max_height_inches` DECIMAL(18,2) COMMENT 'Maximum package height dimension in inches that the carrier will accept for shipment.',
    `max_length_inches` DECIMAL(18,2) COMMENT 'Maximum package length dimension in inches that the carrier will accept for shipment.',
    `max_weight_lbs` DECIMAL(18,2) COMMENT 'Maximum package weight in pounds that the carrier will accept for shipment under standard service terms.',
    `max_width_inches` DECIMAL(18,2) COMMENT 'Maximum package width dimension in inches that the carrier will accept for shipment.',
    `negotiated_discount_percentage` DECIMAL(18,2) COMMENT 'Volume-based discount percentage negotiated off published carrier rates based on annual shipping commitment.',
    `rate_effective_date` DATE COMMENT 'Date when the current rate card and pricing terms became effective.',
    `rate_expiry_date` DATE COMMENT 'Date when the current rate card expires and requires renegotiation or renewal.',
    `residential_delivery_surcharge` DECIMAL(18,2) COMMENT 'Additional flat fee charged for deliveries to residential addresses versus commercial addresses.',
    `scac_code` STRING COMMENT 'Standard Carrier Alpha Code assigned by the National Motor Freight Traffic Association for freight carriers in North America.. Valid values are `^[A-Z]{2,4}$`',
    `service_level_ground` BOOLEAN COMMENT 'Indicates whether the carrier offers standard ground shipping service.',
    `service_level_overnight` BOOLEAN COMMENT 'Indicates whether the carrier offers overnight express shipping service.',
    `service_level_same_day` BOOLEAN COMMENT 'Indicates whether the carrier offers same-day delivery service for local or regional shipments.',
    `service_level_two_day` BOOLEAN COMMENT 'Indicates whether the carrier offers two-day expedited shipping service.',
    `signature_required_flag` BOOLEAN COMMENT 'Indicates whether the carrier requires recipient signature upon delivery as a standard service feature.',
    `tracking_capability_flag` BOOLEAN COMMENT 'Indicates whether the carrier provides real-time shipment tracking and visibility capabilities.',
    `transit_days_zone_1` STRING COMMENT 'Standard number of business days for ground shipment delivery to Zone 1 (typically local or adjacent regions).',
    `transit_days_zone_2` STRING COMMENT 'Standard number of business days for ground shipment delivery to Zone 2 (typically regional).',
    `transit_days_zone_3` STRING COMMENT 'Standard number of business days for ground shipment delivery to Zone 3 (typically extended regional).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the carrier master record was last modified or updated.',
    CONSTRAINT pk_carrier PRIMARY KEY(`carrier_id`)
) COMMENT 'Master record for carrier and 3PL partners used for outbound shipment execution, encompassing carrier identity, service catalog, and contracted rate cards. Captures carrier name, carrier code, carrier type (parcel, LTL, FTL, last-mile, same-day), SCAC code, EDI/API integration capabilities. Service catalog includes service levels (ground, 2-day, overnight, same-day, BOPIS-ready), transit days by zone, cutoff times, max weight/dimensions, surcharge types, tracking capability, signature required flag, and geographic restrictions. Rate card includes base rates by zone/weight/service, dimensional weight factor, fuel surcharges, residential delivery surcharges, extended area surcharges, negotiated discount percentages, rate effective and expiry dates, and weight breaks. Serves as the single source of truth for all carrier master data, service definitions, and freight cost references within the fulfillment domain. Used in carrier selection logic during fulfillment order routing and freight cost estimation.';

CREATE OR REPLACE TABLE `retail_ecm`.`fulfillment`.`carrier_service` (
    `carrier_service_id` BIGINT COMMENT 'Unique identifier for the carrier service offering. Primary key.',
    `carrier_id` BIGINT COMMENT 'Reference to the carrier (logistics provider) offering this service. Links to the carrier master entity.',
    `base_rate` DECIMAL(18,2) COMMENT 'Base shipping rate for this carrier service in the default currency. Used as starting point for total shipping cost calculation before surcharges and discounts.',
    `bopis_eligible_flag` BOOLEAN COMMENT 'Indicates whether this carrier service is eligible for BOPIS (Buy Online Pick Up In Store) fulfillment scenarios. Used in omnichannel order routing.',
    `carbon_neutral_flag` BOOLEAN COMMENT 'Indicates whether this carrier service is certified as carbon-neutral or participates in carbon offset programs. Used in sustainability reporting and eco-conscious customer service selection.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this carrier service record was first created in the system. Used for audit trail and data lineage tracking.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the base rate (e.g., USD, EUR, GBP). Used in multi-currency pricing and cost normalization.. Valid values are `^[A-Z]{3}$`',
    `cutoff_time` TIMESTAMP COMMENT 'Daily cutoff time (HH:MM format, 24-hour) by which orders must be placed to qualify for same-day shipment with this service. Critical for order routing and fulfillment scheduling.',
    `cutoff_timezone` STRING COMMENT 'Timezone identifier for the cutoff time (e.g., EST, PST, CST, UTC). Ensures accurate cutoff enforcement across distributed fulfillment centers.. Valid values are `^[A-Z]{3,5}$`',
    `effective_end_date` DATE COMMENT 'Date after which this carrier service configuration is no longer active. Null indicates indefinite availability. Used in temporal service availability logic.',
    `effective_start_date` DATE COMMENT 'Date from which this carrier service configuration becomes active and available for order routing. Used in temporal service availability logic.',
    `geographic_restriction_type` STRING COMMENT 'Type of geographic restriction applied to this carrier service (e.g., domestic only, specific regions, postal code whitelist/blacklist). Used in carrier eligibility filtering.. Valid values are `none|domestic_only|regional|postal_code_list|country_list`',
    `hazmat_eligible_flag` BOOLEAN COMMENT 'Indicates whether this carrier service is certified to transport hazardous materials. Used in carrier selection for restricted product categories.',
    `holiday_delivery_flag` BOOLEAN COMMENT 'Indicates whether this carrier service supports delivery on recognized holidays. Used in delivery date estimation and peak season planning.',
    `insurance_included_flag` BOOLEAN COMMENT 'Indicates whether shipment insurance is automatically included with this carrier service. Affects cost calculations and risk management decisions.',
    `insurance_max_value` DECIMAL(18,2) COMMENT 'Maximum insured value (in base currency) covered by this carrier service. Orders exceeding this value may require additional insurance or alternative services.',
    `international_eligible_flag` BOOLEAN COMMENT 'Indicates whether this carrier service supports international cross-border shipments. Used in carrier selection for international orders.',
    `max_girth_cm` DECIMAL(18,2) COMMENT 'Maximum package girth (length + 2×width + 2×height) in centimeters. Some carriers enforce combined dimensional limits beyond individual dimension constraints.',
    `max_height_cm` DECIMAL(18,2) COMMENT 'Maximum package height dimension in centimeters accepted by this carrier service. Used in dimensional eligibility checks during carrier selection.',
    `max_length_cm` DECIMAL(18,2) COMMENT 'Maximum package length dimension in centimeters accepted by this carrier service. Used in dimensional eligibility checks during carrier selection.',
    `max_weight_kg` DECIMAL(18,2) COMMENT 'Maximum shipment weight in kilograms that this carrier service can handle. Used in carrier selection logic to filter eligible services based on order weight.',
    `max_width_cm` DECIMAL(18,2) COMMENT 'Maximum package width dimension in centimeters accepted by this carrier service. Used in dimensional eligibility checks during carrier selection.',
    `perishable_eligible_flag` BOOLEAN COMMENT 'Indicates whether this carrier service supports temperature-controlled or time-sensitive perishable goods (e.g., groceries, fresh food). Used in carrier selection for perishable SKUs.',
    `restricted_countries` STRING COMMENT 'Comma-separated list of ISO 3166-1 alpha-3 country codes where this carrier service is NOT available. Used in international order routing and carrier selection.',
    `restricted_postal_codes` STRING COMMENT 'Comma-separated list of postal codes or postal code prefixes where this carrier service is NOT available. Used in carrier eligibility filtering during order routing.',
    `saturday_delivery_flag` BOOLEAN COMMENT 'Indicates whether this carrier service supports Saturday delivery. Used in delivery date estimation and customer service selection.',
    `service_code` STRING COMMENT 'Unique alphanumeric code identifying the carrier service offering (e.g., GROUND, 2DAY, OVERNIGHT, SAMEDAY). Used in carrier selection logic and order routing.. Valid values are `^[A-Z0-9_-]{2,20}$`',
    `service_name` STRING COMMENT 'Human-readable name of the carrier service offering (e.g., Ground Shipping, Two-Day Express, Overnight Priority, Same-Day Delivery).',
    `service_status` STRING COMMENT 'Current operational status of the carrier service. Determines availability for order routing and fulfillment selection.. Valid values are `active|inactive|suspended|seasonal|deprecated`',
    `service_type` STRING COMMENT 'Classification of the carrier service by delivery speed and priority level. Used for service tier segmentation and customer selection.. Valid values are `ground|express|overnight|same_day|next_day|standard`',
    `ship_from_store_eligible_flag` BOOLEAN COMMENT 'Indicates whether this carrier service is eligible for SFS (Ship From Store) fulfillment scenarios. Used in omnichannel order routing and inventory optimization.',
    `signature_required_flag` BOOLEAN COMMENT 'Indicates whether this carrier service mandates recipient signature upon delivery. Impacts service selection for high-value or restricted items.',
    `sla_delivery_guarantee_flag` BOOLEAN COMMENT 'Indicates whether this carrier service includes a contractual SLA (Service Level Agreement) delivery guarantee with refund or credit for late deliveries. Used in service selection and customer promise management.',
    `sunday_delivery_flag` BOOLEAN COMMENT 'Indicates whether this carrier service supports Sunday delivery. Used in delivery date estimation and customer service selection.',
    `surcharge_types` STRING COMMENT 'Comma-separated list of surcharge types applicable to this carrier service (e.g., fuel_surcharge, residential_delivery, remote_area, oversized, peak_season). Used in total shipping cost calculation.',
    `tracking_capability_flag` BOOLEAN COMMENT 'Indicates whether this carrier service provides real-time shipment tracking capability. Used to determine customer visibility options and service selection.',
    `transit_days_max` STRING COMMENT 'Maximum number of business days required for delivery from shipment date. Used in delivery date estimation and SLA (Service Level Agreement) calculations.',
    `transit_days_min` STRING COMMENT 'Minimum number of business days required for delivery from shipment date. Used in delivery date estimation and SLA (Service Level Agreement) calculations.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this carrier service record was last modified. Used for audit trail, change tracking, and data synchronization.',
    CONSTRAINT pk_carrier_service PRIMARY KEY(`carrier_service_id`)
) COMMENT 'Defines specific service offerings provided by a carrier, such as ground, 2-day, overnight, same-day, or BOPIS-ready services. Captures service code, service name, transit days, cutoff time, max weight, max dimensions, surcharge types, tracking capability, signature required flag, and geographic restrictions. Used in carrier selection logic during fulfillment order routing.';

CREATE OR REPLACE TABLE `retail_ecm`.`fulfillment`.`fulfillment_node` (
    `fulfillment_node_id` BIGINT COMMENT 'Unique identifier for the node data product.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Each fulfillment node (DC, store fulfillment center, dark store) operates as a cost center for expense allocation, budget management, headcount planning, and operational cost reporting required for re',
    `cost_zone_id` BIGINT COMMENT 'Foreign key linking to pricing.cost_zone. Business justification: Each fulfillment node operates within a cost zone determining freight factors, duty factors, and overhead factors for landed cost calculations. Node-level profitability reporting and cost allocation i',
    `dc_facility_id` BIGINT COMMENT 'Foreign key linking to supplychain.dc_facility. Business justification: Fulfillment nodes include DCs. When node is a DC, linking to dc_facility provides full facility details (dock doors, capacity, WMS, zones). Essential for DC-based fulfillment operations, capacity plan',
    `location_id` BIGINT COMMENT 'Foreign key linking to store.location. Business justification: Retail omnichannel operations require linking fulfillment nodes to store locations for ship-from-store capacity planning, store P&L attribution of fulfillment costs, and SLA assignment by store format',
    `price_zone_id` BIGINT COMMENT 'Foreign key linking to pricing.price_zone. Business justification: A fulfillment node (store, DC, dark store) operates within a price zone that governs ship-from-store pricing, BOPIS pricing, and zone-based promotional eligibility. Retail pricing operations require k',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Fulfillment nodes operating as ship-from-store or BOPIS locations generate attributed revenue and operate as profit centers for segment reporting, channel profitability analysis, and omnichannel finan',
    `activation_date` DATE COMMENT 'Date when the fulfillment node became operational and available for order fulfillment.',
    `address_line_1` STRING COMMENT 'Primary street address of the fulfillment node (street number, street name). Organizational contact data classified as confidential per business policy.',
    `address_line_2` STRING COMMENT 'Secondary address information (suite, building, floor). Organizational contact data classified as confidential per business policy.',
    `automation_level` STRING COMMENT 'Degree of automation in fulfillment operations: manual (human-only picking/packing), semi_automated (conveyor systems, pick-to-light), fully_automated (robotic picking, automated storage and retrieval systems).. Valid values are `manual|semi_automated|fully_automated`',
    `bopis_enabled` BOOLEAN COMMENT 'Indicates whether this node supports Buy Online Pick Up In Store (BOPIS) fulfillment capability. True if customers can place online orders for in-store pickup at this location.',
    `city` STRING COMMENT 'City where the fulfillment node is located. Organizational contact data classified as confidential per business policy.',
    `country_code` STRING COMMENT 'Three-letter ISO country code where the fulfillment node is located (e.g., USA, CAN, MEX).. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this fulfillment node record was first created in the system.',
    `curbside_pickup_enabled` BOOLEAN COMMENT 'Indicates whether this node supports curbside pickup fulfillment. True if customers can pick up orders without entering the building.',
    `deactivation_date` DATE COMMENT 'Date when the fulfillment node was decommissioned or permanently closed. Null for active nodes.',
    `delivery_zone_coverage_radius_miles` DECIMAL(18,2) COMMENT 'Maximum delivery radius in miles from this fulfillment node for last-mile delivery services. Used for order routing and delivery zone assignment.',
    `dock_door_count` STRING COMMENT 'Number of loading dock doors available at this fulfillment node for inbound receiving and outbound shipping. Key constraint for DC and cross-dock operations.',
    `email_address` STRING COMMENT 'Primary email contact for the fulfillment node operations team. Organizational contact data classified as confidential per business policy.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `hazmat_certified` BOOLEAN COMMENT 'Indicates whether this node is certified to handle and store hazardous materials per OSHA and DOT regulations. True if hazmat fulfillment is permitted.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this fulfillment node record was last updated in the system.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the fulfillment node, used for distance calculations, delivery zone mapping, and route optimization.',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the fulfillment node, used for distance calculations, delivery zone mapping, and route optimization.',
    `manager_name` STRING COMMENT 'Name of the fulfillment operations manager responsible for this node. Business reference, not direct PII.',
    `next_day_delivery_enabled` BOOLEAN COMMENT 'Indicates whether this node supports next-day delivery fulfillment. True if orders can be delivered to customers on the day following order placement.',
    `node_code` STRING COMMENT 'Business identifier code for the fulfillment node, used across operational systems for node identification and routing logic. Typically alphanumeric, uppercase.. Valid values are `^[A-Z0-9]{4,12}$`',
    `node_name` STRING COMMENT 'Human-readable name of the fulfillment node (e.g., Downtown Distribution Center, Store #1234 - Main Street, MFC Phoenix West).',
    `node_status` STRING COMMENT 'Current operational lifecycle status of the fulfillment node. Active nodes are available for order routing; inactive/temporarily_closed nodes are excluded from fulfillment logic.. Valid values are `active|inactive|planned|under_construction|temporarily_closed|decommissioned`',
    `node_type` STRING COMMENT 'Classification of the fulfillment node by its primary operational purpose: distribution_center (DC - regional warehouse), store (retail location with fulfillment capability), dark_store (fulfillment-only location, no customer traffic), micro_fulfillment_center (MFC - automated urban fulfillment hub), cross_dock (direct transfer facility), returns_center (reverse logistics hub).. Valid values are `distribution_center|store|dark_store|micro_fulfillment_center|cross_dock|returns_center`',
    `operating_hours_weekday` STRING COMMENT 'Standard operating hours for weekdays (Monday-Friday) in format HH:MM-HH:MM (e.g., 08:00-20:00). Used for order cutoff time calculations and fulfillment scheduling.',
    `operating_hours_weekend` STRING COMMENT 'Standard operating hours for weekends (Saturday-Sunday) in format HH:MM-HH:MM (e.g., 09:00-18:00). Used for order cutoff time calculations and fulfillment scheduling.',
    `pack_station_count` STRING COMMENT 'Number of packing stations available at this fulfillment node. Determines packing throughput capacity for ship-from-store and DC operations.',
    `phone_number` STRING COMMENT 'Primary contact phone number for the fulfillment node. Organizational contact data classified as confidential per business policy.',
    `pick_capacity_orders_per_hour` STRING COMMENT 'Maximum number of orders that can be picked per hour at this fulfillment node under normal operating conditions. Used for capacity planning and order routing decisions.',
    `postal_code` STRING COMMENT 'Postal or ZIP code for the fulfillment node address. Organizational contact data classified as confidential per business policy.',
    `primary_carrier_code` STRING COMMENT 'Code identifying the primary shipping carrier assigned to this fulfillment node (e.g., UPS, FedEx, USPS, regional 3PL). Used for default carrier selection in order routing.',
    `refrigerated_storage_enabled` BOOLEAN COMMENT 'Indicates whether this node has refrigerated storage capability for perishable goods (dairy, produce, frozen foods). True if cold chain fulfillment is supported.',
    `ropis_enabled` BOOLEAN COMMENT 'Indicates whether this node supports Reserve Online Pick Up In Store (ROPIS) fulfillment capability. True if customers can reserve items online for later in-store pickup and payment.',
    `same_day_delivery_enabled` BOOLEAN COMMENT 'Indicates whether this node supports same-day delivery fulfillment. True if orders can be delivered to customers on the same day they are placed.',
    `ship_from_store_enabled` BOOLEAN COMMENT 'Indicates whether this node supports Ship From Store (SFS) fulfillment capability. True if this location can pick, pack, and ship online orders directly to customers.',
    `state_province` STRING COMMENT 'Two-letter state or province code (e.g., CA, TX, ON). Organizational contact data classified as confidential per business policy.. Valid values are `^[A-Z]{2}$`',
    `storage_capacity_square_feet` STRING COMMENT 'Total storage capacity of the fulfillment node measured in square feet. Used for inventory capacity planning and space utilization analysis.',
    `storage_zone_count` STRING COMMENT 'Number of distinct storage zones within the fulfillment node (e.g., ambient, refrigerated, frozen, hazmat). Used for inventory placement and pick path optimization.',
    `time_zone` STRING COMMENT 'IANA time zone identifier for the fulfillment node (e.g., America/New_York, America/Los_Angeles), used for scheduling and cutoff time calculations.',
    `wms_system_code` STRING COMMENT 'Identifier of the WMS system instance managing this fulfillment node. Links to the operational WMS platform (e.g., Manhattan Associates instance ID).',
    CONSTRAINT pk_fulfillment_node PRIMARY KEY(`fulfillment_node_id`)
) COMMENT 'Master record for all physical locations capable of fulfilling customer orders, including stores acting as ship-from-store nodes, dark stores, micro-fulfillment centers (MFCs), and distribution centers (DCs). Captures node type, address, fulfillment capabilities (BOPIS, ROPIS, SFS, dark store, MFC), active carrier assignments, operating hours, pick capacity (orders/hour), pack station count, dock door count, storage zones, node activation status, and geographic delivery zone coverage. Distinct from the store domains store master — this entity focuses exclusively on fulfillment operational capabilities and capacity constraints. Note: PK naming (fulfillment_fulfillment_node_id) contains a double-prefix defect that should be corrected to fulfillment_node_id.';

CREATE OR REPLACE TABLE `retail_ecm`.`fulfillment`.`exception` (
    `exception_id` BIGINT COMMENT 'Primary key for exception',
    `carrier_id` BIGINT COMMENT 'Reference to the carrier involved in the exception. Relevant for carrier pickup missed or delivery attempt failure exceptions.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Fulfillment exceptions (damaged goods, mis-picks, customer returns, carrier claims) create operational costs and shrink that must be allocated to cost centers for variance tracking, exception cost ana',
    `department_id` BIGINT COMMENT 'Foreign key linking to store.department. Business justification: Fulfillment exceptions (out-of-stock picks, damaged goods, substitutions) in retail store fulfillment occur within specific store departments. Linking exception to store.department enables department-',
    `fulfillment_line_id` BIGINT COMMENT 'Reference to the specific fulfillment order line item affected by this exception. Nullable if exception applies to entire order.',
    `fulfillment_node_id` BIGINT COMMENT 'Reference to the fulfillment location (distribution center, store, dark store, micro-fulfillment center) where the exception occurred.',
    `fulfillment_order_id` BIGINT COMMENT 'Reference to the fulfillment order in which this exception occurred.',
    `journal_entry_id` BIGINT COMMENT 'Foreign key linking to finance.journal_entry. Business justification: Exception financial impact posting: fulfillment exceptions with financial_impact_amount (short-ships, damaged goods, SLA breach penalties) generate journal entries for write-offs or adjustments. Retai',
    `loyalty_membership_id` BIGINT COMMENT 'Foreign key linking to loyalty.membership. Business justification: Fulfillment exception resolution in retail is prioritized by loyalty tier - VIP members receive immediate escalation, expedited replacement, and premium communication. Real-time exception routing syst',
    `pack_task_id` BIGINT COMMENT 'Foreign key linking to fulfillment.pack_task. Business justification: Packing exceptions (wrong item packed, damaged packaging, weight discrepancy, hazmat violation) occur at the pack station. Linking exception to pack_task enables attribution of packing-stage exception',
    `pick_task_id` BIGINT COMMENT 'Foreign key linking to fulfillment.pick_task. Business justification: Picking exceptions (out-of-stock, substitution required, damaged item, wrong location) are a primary exception type in fulfillment operations. Linking exception to pick_task enables root cause analysi',
    `profile_id` BIGINT COMMENT 'Foreign key linking to customer.profile. Business justification: Proactive customer exception notification: retail operations must notify affected customers of fulfillment exceptions (delays, lost packages, damage) directly. exception.customer_notified_flag and cus',
    `rma_id` BIGINT COMMENT 'Foreign key linking to returns.rma. Business justification: Fulfillment exceptions (damaged goods, short shipment, mis-pick) directly trigger or are associated with an RMA. Linking exception to rma enables root cause analysis connecting fulfillment failures to',
    `service_case_id` BIGINT COMMENT 'Foreign key linking to customer.service_case. Business justification: Fulfillment exceptions (damaged goods, delivery failures, inventory shortages) often trigger customer service cases. Linking exception to service_case enables tracking which exceptions resulted in cus',
    `shipment_id` BIGINT COMMENT 'Foreign key linking to fulfillment.shipment. Business justification: Operational exceptions frequently occur at the shipment level — carrier delays, lost packages, delivery failures, and tracking discrepancies. exception already links to fulfillment_order and fulfillme',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: Fulfillment exception root-cause analysis and product quality reporting require linking exceptions to the specific SKU record. Enables reports on which SKUs generate most exceptions (wrong-pick, damag',
    `sla_id` BIGINT COMMENT 'Foreign key linking to fulfillment.sla. Business justification: An exception references the SLA that governs its resolution timeline. exception currently stores sla_target_resolution_minutes as a scalar, denormalizing SLA rule data. Adding sla_id FK normalizes thi',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to supplier.vendor. Business justification: Vendor-caused fulfillment exceptions (mislabeled items, wrong product shipped, quality defects) must be attributed to the responsible vendor for chargeback processing and vendor scorecard updates. Ret',
    `warehouse_task_id` BIGINT COMMENT 'Foreign key linking to supplychain.warehouse_task. Business justification: Warehouse task exception management: fulfillment exceptions (pick errors, putaway failures, mislabeled items) are raised against specific warehouse tasks; this link enables root-cause analysis, task-l',
    `corrective_action_plan` STRING COMMENT 'Description of preventive measures or process changes implemented to avoid recurrence of similar exceptions.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this exception record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for financial impact amount.. Valid values are `^[A-Z]{3}$`',
    `customer_notification_timestamp` TIMESTAMP COMMENT 'Date and time when customer notification was sent regarding the exception.',
    `customer_notified_flag` BOOLEAN COMMENT 'Indicates whether the customer was notified about the exception and its impact on their order.',
    `detected_at_stage` STRING COMMENT 'Fulfillment process stage where the exception was identified. [ENUM-REF-CANDIDATE: picking|packing|quality_check|staging|loading|carrier_handoff|in_transit|delivery — 8 candidates stripped; promote to reference product]',
    `escalation_level` STRING COMMENT 'Number indicating how many times the exception has been escalated through management hierarchy. Zero indicates no escalation.',
    `exception_code` STRING COMMENT 'System-specific code representing the detailed exception reason. Maps to internal exception taxonomy and resolution workflows.',
    `exception_description` STRING COMMENT 'Detailed narrative description of the exception circumstances, root cause, and impact. Captured by fulfillment associate or system.',
    `exception_number` STRING COMMENT 'Human-readable business identifier for the exception, used for tracking and communication across fulfillment teams.',
    `exception_status` STRING COMMENT 'Current lifecycle state of the exception in the resolution workflow.. Valid values are `open|in_progress|resolved|escalated|cancelled`',
    `exception_timestamp` TIMESTAMP COMMENT 'Date and time when the exception was first detected or logged in the fulfillment system.',
    `exception_type` STRING COMMENT 'Category of fulfillment exception encountered. Classifies the nature of the operational disruption. [ENUM-REF-CANDIDATE: out_of_stock_at_pick|damaged_item|mispick|carrier_pickup_missed|address_validation_failure|delivery_attempt_failure|item_not_found|quantity_shortage|quality_issue|packaging_failure|label_printing_error|system_error — 12 candidates stripped; promote to reference product]',
    `financial_impact_amount` DECIMAL(18,2) COMMENT 'Estimated or actual financial cost of the exception in local currency, including refunds, credits, expedited shipping, or inventory write-offs.',
    `notes` STRING COMMENT 'Additional free-form notes or comments from fulfillment associates, supervisors, or customer service regarding the exception handling.',
    `owner_type` STRING COMMENT 'Role or system component responsible for the exception occurrence or resolution. [ENUM-REF-CANDIDATE: picker|packer|quality_inspector|carrier|system|supervisor|customer_service — 7 candidates stripped; promote to reference product]',
    `priority` STRING COMMENT 'Business priority assigned to the exception resolution based on customer impact, order value, and SLA criticality.. Valid values are `critical|high|medium|low`',
    `quantity_affected` DECIMAL(18,2) COMMENT 'Number of units impacted by the exception. Relevant for quantity shortages, damaged items, or mispicks.',
    `resolution_action` STRING COMMENT 'Corrective action taken or planned to resolve the exception. [ENUM-REF-CANDIDATE: substitute_item|cancel_line|reroute_order|reschedule_delivery|issue_refund|contact_customer|escalate_to_supervisor|reprocess — 8 candidates stripped; promote to reference product]',
    `resolution_duration_minutes` STRING COMMENT 'Time elapsed in minutes from exception detection to resolution. Used for SLA tracking and performance analysis.',
    `resolution_timestamp` TIMESTAMP COMMENT 'Date and time when the exception was resolved or closed. Nullable if exception is still open.',
    `root_cause_category` STRING COMMENT 'High-level classification of the underlying cause of the exception. Used for trend analysis and process improvement. [ENUM-REF-CANDIDATE: inventory_accuracy|process_error|system_failure|carrier_issue|product_quality|human_error|external_factor — 7 candidates stripped; promote to reference product]',
    `sla_breach_flag` BOOLEAN COMMENT 'Indicates whether this exception caused a breach of fulfillment service level agreement commitments.',
    `tracking_number` STRING COMMENT 'Shipment tracking number associated with the exception. Applicable for in-transit or delivery exceptions.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time when this exception record was last modified.',
    CONSTRAINT pk_exception PRIMARY KEY(`exception_id`)
) COMMENT 'Records operational exceptions encountered during the fulfillment lifecycle, including out-of-stock at pick, damaged item, mispick, carrier pickup missed, address validation failure, and delivery attempt failure. Captures exception type, exception code, affected fulfillment order and line, exception timestamp, resolution action taken, resolution timestamp, and exception owner (picker, packer, carrier, system). Drives exception management workflows and SLA breach tracking.';

CREATE OR REPLACE TABLE `retail_ecm`.`fulfillment`.`sla` (
    `sla_id` BIGINT COMMENT 'Primary key for sla',
    `carrier_id` BIGINT COMMENT 'Identifier of the shipping carrier this SLA applies to (e.g., FedEx, UPS, USPS, regional courier). Null if SLA is carrier-agnostic.',
    `carrier_service_id` BIGINT COMMENT 'Foreign key linking to fulfillment.carrier_service. Business justification: sla defines SLA rules for specific carrier services (e.g., FedEx 2-Day must deliver within 48 hours). Currently has carrier_id FK and denormalized carrier_service_level column, but no FK to carrier_',
    `fulfillment_node_id` BIGINT COMMENT 'Identifier of the specific fulfillment node (store, DC, dark store, MFC) this SLA rule applies to. Null if SLA applies globally across all nodes of the specified node_type.',
    `category_id` BIGINT COMMENT 'Identifier of the product category this SLA applies to (e.g., perishables may have stricter SLAs). Null if SLA applies to all product categories.',
    `season_id` BIGINT COMMENT 'Foreign key linking to merchandising.season. Business justification: Retail SLAs are routinely configured differently by merchandising season — holiday, back-to-school, and clearance seasons carry distinct promised delivery windows and breach thresholds. Linking SLA re',
    `tier_id` BIGINT COMMENT 'Foreign key linking to loyalty.tier. Business justification: SLA definitions in retail are explicitly scoped per loyalty tier (e.g., Gold members get 2-hour delivery SLA, standard members get next-day). The existing denormalized `loyalty_tier` plain-text column',
    `applies_to_holidays` BOOLEAN COMMENT 'Indicates whether this SLA rule applies to orders placed on recognized holidays. If false, holiday orders may follow different SLA rules.',
    `applies_to_weekdays` BOOLEAN COMMENT 'Indicates whether this SLA rule applies to orders placed on weekdays (Monday-Friday).',
    `applies_to_weekends` BOOLEAN COMMENT 'Indicates whether this SLA rule applies to orders placed on weekends (Saturday-Sunday).',
    `breach_threshold_hours` DECIMAL(18,2) COMMENT 'Number of hours before the SLA deadline at which an alert or escalation should be triggered if the order is not yet fulfilled. Used for proactive SLA risk management.',
    `breach_threshold_percentage` DECIMAL(18,2) COMMENT 'Percentage of the total SLA time window at which an alert should be triggered (e.g., 80% means alert when 80% of allowed time has elapsed). Alternative to breach_threshold_hours.',
    `carrier_cutoff_time` TIMESTAMP COMMENT 'Daily cutoff time (HH:MM in 24-hour format, local node time) by which orders must be ready for carrier pickup to meet the SLA. Null if not applicable.',
    `compliance_notes` STRING COMMENT 'Free-text notes documenting any regulatory, contractual, or business policy requirements that govern this SLA rule (e.g., Required by premium membership terms, State law mandates 24-hour BOPIS readiness).',
    `country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code this SLA applies to (e.g., USA, CAN, MEX). Null if SLA is not country-specific.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this SLA rule record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for order value thresholds (e.g., USD, CAD, EUR). Null if order value thresholds are not defined.. Valid values are `^[A-Z]{3}$`',
    `effective_end_date` DATE COMMENT 'Date after which this SLA rule is no longer effective. Null indicates the rule is open-ended and remains active until explicitly deactivated.',
    `effective_start_date` DATE COMMENT 'Date from which this SLA rule becomes effective and should be applied to orders.',
    `escalation_rule` STRING COMMENT 'Business rule or workflow identifier defining what actions to take when SLA breach risk is detected (e.g., NOTIFY_STORE_MANAGER, REROUTE_TO_ALTERNATE_NODE, UPGRADE_CARRIER_SERVICE).',
    `excluded_dates` STRING COMMENT 'Comma-separated list of specific dates (YYYY-MM-DD format) on which this SLA rule does not apply (e.g., peak season blackout dates, facility closures).',
    `fulfillment_method` STRING COMMENT 'The fulfillment execution method this SLA applies to: BOPIS (Buy Online Pick Up In Store), ROPIS (Reserve Online Pick Up In Store), ship-to-home, ship-from-store, dark store fulfillment, curbside pickup, locker pickup, or direct ship. [ENUM-REF-CANDIDATE: BOPIS|ROPIS|SHIP_TO_HOME|SHIP_FROM_STORE|DARK_STORE|CURBSIDE_PICKUP|LOCKER_PICKUP|DIRECT_SHIP — 8 candidates stripped; promote to reference product]',
    `geographic_scope` STRING COMMENT 'Geographic applicability of this SLA rule: GLOBAL (all locations), NATIONAL (country-wide), REGIONAL (multi-state/province), LOCAL (specific metro area or node).. Valid values are `GLOBAL|NATIONAL|REGIONAL|LOCAL`',
    `is_active` BOOLEAN COMMENT 'Indicates whether this SLA rule is currently active and should be applied to new orders. False means the rule is disabled or deprecated.',
    `node_type` STRING COMMENT 'Type of fulfillment node this SLA applies to: store, distribution center (DC), dark store (fulfillment-only location), micro-fulfillment center (MFC), vendor, or third-party logistics (3PL).. Valid values are `STORE|DC|DARK_STORE|MFC|VENDOR|3PL`',
    `order_channel` STRING COMMENT 'The sales channel through which the order was placed: web, mobile app, in-store, call center, marketplace, or social commerce.. Valid values are `WEB|MOBILE_APP|IN_STORE|CALL_CENTER|MARKETPLACE|SOCIAL_COMMERCE`',
    `order_cutoff_time` TIMESTAMP COMMENT 'Daily cutoff time (HH:MM in 24-hour format, local node time) by which orders must be placed to qualify for this SLA (e.g., same-day delivery cutoff at 14:00). Null if no order cutoff applies.',
    `order_value_max` DECIMAL(18,2) COMMENT 'Maximum order total amount (in currency_code) for which this SLA applies. Null if no maximum order value threshold exists.',
    `order_value_min` DECIMAL(18,2) COMMENT 'Minimum order total amount (in currency_code) required for this SLA to apply. Null if no minimum order value threshold exists.',
    `postal_code_pattern` STRING COMMENT 'Regex pattern or prefix defining the postal/ZIP codes this SLA applies to (e.g., ^90[0-9]{3}$ for Los Angeles area). Null if SLA is not postal-code-specific.',
    `priority_level` STRING COMMENT 'Business priority assigned to this SLA rule: CRITICAL (premium/express), HIGH (next-day), MEDIUM (standard), LOW (economy). Used for resource allocation and conflict resolution.. Valid values are `CRITICAL|HIGH|MEDIUM|LOW`',
    `promised_hours_to_deliver` DECIMAL(18,2) COMMENT 'Total number of hours from order placement to final delivery to the customer. Used for end-to-end delivery SLAs (same-day, next-day, standard ground).',
    `promised_hours_to_ready` DECIMAL(18,2) COMMENT 'Number of hours from order placement to when the order must be ready for customer pickup (for BOPIS/ROPIS) or ready for carrier pickup (for ship-from-store). Null if not applicable to this SLA type.',
    `promised_hours_to_ship` DECIMAL(18,2) COMMENT 'Number of hours from order placement to when the shipment must be handed off to the carrier. Applies to ship-to-home and ship-from-store fulfillment methods.',
    `region_code` STRING COMMENT 'Internal region or state/province code this SLA applies to (e.g., US-CA, US-TX, NORTHEAST). Null if SLA is not region-specific.',
    `sla_code` STRING COMMENT 'Business-readable unique code identifying this SLA rule (e.g., BOPIS_2HR, SAMEDAY_SHIP, NEXTDAY_DEL).. Valid values are `^[A-Z0-9_-]{3,20}$`',
    `sla_name` STRING COMMENT 'Human-readable descriptive name of the SLA rule (e.g., Buy Online Pick Up In Store - 2 Hour Ready, Same-Day Shipping Cutoff).',
    `sla_type` STRING COMMENT 'Category of SLA commitment: BOPIS readiness, ROPIS readiness, same-day ship cutoff, next-day delivery, standard ground, express delivery, or ship-from-store. [ENUM-REF-CANDIDATE: BOPIS_READINESS|ROPIS_READINESS|SAME_DAY_SHIP|NEXT_DAY_DELIVERY|STANDARD_GROUND|EXPRESS_DELIVERY|SHIP_FROM_STORE — 7 candidates stripped; promote to reference product]',
    `updated_by` STRING COMMENT 'User ID or system identifier of the person or process that last updated this SLA rule record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this SLA rule record was last modified.',
    CONSTRAINT pk_sla PRIMARY KEY(`sla_id`)
) COMMENT 'Defines SLA (Service Level Agreement) rules and thresholds governing fulfillment performance commitments. Captures SLA type (BOPIS readiness, same-day ship cutoff, next-day delivery, standard ground), fulfillment method, order channel, node type, promised hours-to-ready, promised hours-to-ship, carrier cutoff time, breach threshold, and escalation rules. Used to evaluate fulfillment order compliance and trigger alerts when SLA risk is detected.';

CREATE OR REPLACE TABLE `retail_ecm`.`fulfillment`.`carrier_rate` (
    `carrier_rate_id` BIGINT COMMENT 'Unique identifier for the carrier rate record. Primary key.',
    `carrier_id` BIGINT COMMENT 'Reference to the carrier (shipping company) offering this rate. Links to the carrier master entity.',
    `carrier_service_id` BIGINT COMMENT 'Foreign key linking to fulfillment.carrier_service. Business justification: carrier_rate has carrier_id FK and denormalized service_level/service_code columns, but no FK to carrier_service. Business reality: a rate is pricing for a specific carrier_service offering. Adding ca',
    `base_rate_amount` DECIMAL(18,2) COMMENT 'Base shipping rate amount before surcharges and discounts. This is the starting point for freight cost calculation.',
    `contract_number` STRING COMMENT 'Reference number of the carrier contract or agreement under which this rate is offered. Business-confidential identifier.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this carrier rate record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this rate record (e.g., USD, CAD, EUR).. Valid values are `^[A-Z]{3}$`',
    `destination_country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code for the shipment destination (e.g., USA, CAN, MEX).. Valid values are `^[A-Z]{3}$`',
    `destination_postal_code` STRING COMMENT 'Postal code of the shipment destination (customer delivery address).',
    `dimensional_weight_factor` DECIMAL(18,2) COMMENT 'Divisor used to calculate dimensional weight from package dimensions (length × width × height ÷ factor). Common values are 5000 (cm³/kg) or 139 (in³/lb).',
    `effective_date` DATE COMMENT 'Date when this carrier rate becomes active and can be used for freight cost estimation and carrier selection.',
    `expiry_date` DATE COMMENT 'Date when this carrier rate expires and is no longer valid. Null indicates an open-ended rate with no expiration.',
    `extended_area_surcharge` DECIMAL(18,2) COMMENT 'Additional fee for delivery to remote or extended service areas beyond standard carrier coverage zones.',
    `fuel_surcharge_rate` DECIMAL(18,2) COMMENT 'Fuel surcharge rate expressed as a decimal percentage (e.g., 0.1250 for 12.50%). Applied to base rate to account for fuel cost fluctuations.',
    `is_hazmat_eligible` BOOLEAN COMMENT 'Flag indicating whether this carrier service level can handle hazardous materials shipments under applicable regulations.',
    `is_international` BOOLEAN COMMENT 'Flag indicating whether this rate applies to international shipments (cross-border) or domestic shipments within a single country.',
    `minimum_charge_amount` DECIMAL(18,2) COMMENT 'Minimum shipping charge that will be applied regardless of calculated rate. Ensures carrier covers base handling costs.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this carrier rate record was last modified or updated.',
    `negotiated_discount_percentage` DECIMAL(18,2) COMMENT 'Discount percentage off published rates negotiated with the carrier, expressed as a decimal (e.g., 0.1500 for 15% discount). Business-confidential contract term.',
    `notes` STRING COMMENT 'Free-text notes or comments about this carrier rate, including special terms, restrictions, or usage guidance.',
    `origin_country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code for the shipment origin (e.g., USA, CAN, MEX).. Valid values are `^[A-Z]{3}$`',
    `origin_postal_code` STRING COMMENT 'Postal code of the shipment origin location (fulfillment center, store, or warehouse).',
    `oversized_package_surcharge` DECIMAL(18,2) COMMENT 'Additional fee for packages exceeding standard size limits (length + girth thresholds vary by carrier).',
    `rate_per_kg` DECIMAL(18,2) COMMENT 'Incremental rate charged per kilogram above the weight break minimum. Used for weight-based pricing calculations.',
    `rate_source` STRING COMMENT 'Source system or method by which this rate was obtained: carrier API (real-time), manual entry, contract upload, rate shopping engine, or third-party logistics provider.. Valid values are `carrier_api|manual_entry|contract_upload|rate_shop|third_party`',
    `rate_status` STRING COMMENT 'Current lifecycle status of the carrier rate: active (in use), inactive (not in use), pending (awaiting activation), expired (past expiry date), suspended (temporarily disabled).. Valid values are `active|inactive|pending|expired|suspended`',
    `rate_type` STRING COMMENT 'Classification of the rate: base (standard published rate), negotiated (custom contract rate), published (carrier list price), spot (one-time rate), or contract (long-term agreement rate).. Valid values are `base|negotiated|published|spot|contract`',
    `rate_version` STRING COMMENT 'Version number of this rate record. Incremented when rate terms are updated, enabling rate history tracking and audit trails.',
    `rate_zone` STRING COMMENT 'Geographic zone or region for which this rate applies. Carriers use zone-based pricing to calculate shipping costs based on origin and destination distance.',
    `residential_delivery_surcharge` DECIMAL(18,2) COMMENT 'Additional flat fee charged for delivery to residential addresses (as opposed to commercial addresses).',
    `saturday_delivery_surcharge` DECIMAL(18,2) COMMENT 'Additional fee for Saturday delivery service, which is outside standard weekday delivery schedules.',
    `service_level` STRING COMMENT 'Type of shipping service offered by the carrier (e.g., ground, express, overnight, two-day, economy, priority, standard). [ENUM-REF-CANDIDATE: ground|express|overnight|two_day|economy|priority|standard — 7 candidates stripped; promote to reference product]',
    `signature_required_surcharge` DECIMAL(18,2) COMMENT 'Additional fee charged when signature confirmation is required upon delivery.',
    `transit_days` STRING COMMENT 'Expected number of business days for shipment transit from origin to destination using this service level.',
    `weight_break_max_kg` DECIMAL(18,2) COMMENT 'Maximum weight in kilograms for this rate tier. Null indicates no upper limit for the highest tier.',
    `weight_break_min_kg` DECIMAL(18,2) COMMENT 'Minimum weight in kilograms for this rate tier. Carriers use weight breaks to define tiered pricing (e.g., 0-5kg, 5-10kg, 10-20kg).',
    CONSTRAINT pk_carrier_rate PRIMARY KEY(`carrier_rate_id`)
) COMMENT 'Contracted and published rate records for carrier services, capturing base rate, dimensional weight factor, fuel surcharge rate, residential delivery surcharge, extended area surcharge, rate effective date, rate expiry date, rate zone, weight break, and negotiated discount percentage. Used in carrier selection and freight cost estimation during fulfillment order routing. Distinct from pricing domain — this is carrier freight cost, not retail product pricing.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `retail_ecm`.`fulfillment`.`fulfillment_order` ADD CONSTRAINT `fk_fulfillment_fulfillment_order_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `retail_ecm`.`fulfillment`.`carrier`(`carrier_id`);
ALTER TABLE `retail_ecm`.`fulfillment`.`fulfillment_order` ADD CONSTRAINT `fk_fulfillment_fulfillment_order_carrier_service_id` FOREIGN KEY (`carrier_service_id`) REFERENCES `retail_ecm`.`fulfillment`.`carrier_service`(`carrier_service_id`);
ALTER TABLE `retail_ecm`.`fulfillment`.`fulfillment_order` ADD CONSTRAINT `fk_fulfillment_fulfillment_order_fulfillment_node_id` FOREIGN KEY (`fulfillment_node_id`) REFERENCES `retail_ecm`.`fulfillment`.`fulfillment_node`(`fulfillment_node_id`);
ALTER TABLE `retail_ecm`.`fulfillment`.`fulfillment_order` ADD CONSTRAINT `fk_fulfillment_fulfillment_order_sla_id` FOREIGN KEY (`sla_id`) REFERENCES `retail_ecm`.`fulfillment`.`sla`(`sla_id`);
ALTER TABLE `retail_ecm`.`fulfillment`.`fulfillment_line` ADD CONSTRAINT `fk_fulfillment_fulfillment_line_fulfillment_node_id` FOREIGN KEY (`fulfillment_node_id`) REFERENCES `retail_ecm`.`fulfillment`.`fulfillment_node`(`fulfillment_node_id`);
ALTER TABLE `retail_ecm`.`fulfillment`.`fulfillment_line` ADD CONSTRAINT `fk_fulfillment_fulfillment_line_fulfillment_order_id` FOREIGN KEY (`fulfillment_order_id`) REFERENCES `retail_ecm`.`fulfillment`.`fulfillment_order`(`fulfillment_order_id`);
ALTER TABLE `retail_ecm`.`fulfillment`.`fulfillment_line` ADD CONSTRAINT `fk_fulfillment_fulfillment_line_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `retail_ecm`.`fulfillment`.`shipment`(`shipment_id`);
ALTER TABLE `retail_ecm`.`fulfillment`.`fulfillment_line` ADD CONSTRAINT `fk_fulfillment_fulfillment_line_shipment_package_id` FOREIGN KEY (`shipment_package_id`) REFERENCES `retail_ecm`.`fulfillment`.`shipment_package`(`shipment_package_id`);
ALTER TABLE `retail_ecm`.`fulfillment`.`shipment` ADD CONSTRAINT `fk_fulfillment_shipment_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `retail_ecm`.`fulfillment`.`carrier`(`carrier_id`);
ALTER TABLE `retail_ecm`.`fulfillment`.`shipment` ADD CONSTRAINT `fk_fulfillment_shipment_carrier_rate_id` FOREIGN KEY (`carrier_rate_id`) REFERENCES `retail_ecm`.`fulfillment`.`carrier_rate`(`carrier_rate_id`);
ALTER TABLE `retail_ecm`.`fulfillment`.`shipment` ADD CONSTRAINT `fk_fulfillment_shipment_carrier_service_id` FOREIGN KEY (`carrier_service_id`) REFERENCES `retail_ecm`.`fulfillment`.`carrier_service`(`carrier_service_id`);
ALTER TABLE `retail_ecm`.`fulfillment`.`shipment` ADD CONSTRAINT `fk_fulfillment_shipment_fulfillment_node_id` FOREIGN KEY (`fulfillment_node_id`) REFERENCES `retail_ecm`.`fulfillment`.`fulfillment_node`(`fulfillment_node_id`);
ALTER TABLE `retail_ecm`.`fulfillment`.`shipment` ADD CONSTRAINT `fk_fulfillment_shipment_fulfillment_order_id` FOREIGN KEY (`fulfillment_order_id`) REFERENCES `retail_ecm`.`fulfillment`.`fulfillment_order`(`fulfillment_order_id`);
ALTER TABLE `retail_ecm`.`fulfillment`.`shipment` ADD CONSTRAINT `fk_fulfillment_shipment_sla_id` FOREIGN KEY (`sla_id`) REFERENCES `retail_ecm`.`fulfillment`.`sla`(`sla_id`);
ALTER TABLE `retail_ecm`.`fulfillment`.`shipment_package` ADD CONSTRAINT `fk_fulfillment_shipment_package_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `retail_ecm`.`fulfillment`.`carrier`(`carrier_id`);
ALTER TABLE `retail_ecm`.`fulfillment`.`shipment_package` ADD CONSTRAINT `fk_fulfillment_shipment_package_carrier_service_id` FOREIGN KEY (`carrier_service_id`) REFERENCES `retail_ecm`.`fulfillment`.`carrier_service`(`carrier_service_id`);
ALTER TABLE `retail_ecm`.`fulfillment`.`shipment_package` ADD CONSTRAINT `fk_fulfillment_shipment_package_fulfillment_node_id` FOREIGN KEY (`fulfillment_node_id`) REFERENCES `retail_ecm`.`fulfillment`.`fulfillment_node`(`fulfillment_node_id`);
ALTER TABLE `retail_ecm`.`fulfillment`.`shipment_package` ADD CONSTRAINT `fk_fulfillment_shipment_package_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `retail_ecm`.`fulfillment`.`shipment`(`shipment_id`);
ALTER TABLE `retail_ecm`.`fulfillment`.`pick_task` ADD CONSTRAINT `fk_fulfillment_pick_task_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `retail_ecm`.`fulfillment`.`carrier`(`carrier_id`);
ALTER TABLE `retail_ecm`.`fulfillment`.`pick_task` ADD CONSTRAINT `fk_fulfillment_pick_task_carrier_service_id` FOREIGN KEY (`carrier_service_id`) REFERENCES `retail_ecm`.`fulfillment`.`carrier_service`(`carrier_service_id`);
ALTER TABLE `retail_ecm`.`fulfillment`.`pick_task` ADD CONSTRAINT `fk_fulfillment_pick_task_fulfillment_line_id` FOREIGN KEY (`fulfillment_line_id`) REFERENCES `retail_ecm`.`fulfillment`.`fulfillment_line`(`fulfillment_line_id`);
ALTER TABLE `retail_ecm`.`fulfillment`.`pick_task` ADD CONSTRAINT `fk_fulfillment_pick_task_fulfillment_node_id` FOREIGN KEY (`fulfillment_node_id`) REFERENCES `retail_ecm`.`fulfillment`.`fulfillment_node`(`fulfillment_node_id`);
ALTER TABLE `retail_ecm`.`fulfillment`.`pick_task` ADD CONSTRAINT `fk_fulfillment_pick_task_fulfillment_order_id` FOREIGN KEY (`fulfillment_order_id`) REFERENCES `retail_ecm`.`fulfillment`.`fulfillment_order`(`fulfillment_order_id`);
ALTER TABLE `retail_ecm`.`fulfillment`.`pack_task` ADD CONSTRAINT `fk_fulfillment_pack_task_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `retail_ecm`.`fulfillment`.`carrier`(`carrier_id`);
ALTER TABLE `retail_ecm`.`fulfillment`.`pack_task` ADD CONSTRAINT `fk_fulfillment_pack_task_carrier_service_id` FOREIGN KEY (`carrier_service_id`) REFERENCES `retail_ecm`.`fulfillment`.`carrier_service`(`carrier_service_id`);
ALTER TABLE `retail_ecm`.`fulfillment`.`pack_task` ADD CONSTRAINT `fk_fulfillment_pack_task_fulfillment_line_id` FOREIGN KEY (`fulfillment_line_id`) REFERENCES `retail_ecm`.`fulfillment`.`fulfillment_line`(`fulfillment_line_id`);
ALTER TABLE `retail_ecm`.`fulfillment`.`pack_task` ADD CONSTRAINT `fk_fulfillment_pack_task_fulfillment_node_id` FOREIGN KEY (`fulfillment_node_id`) REFERENCES `retail_ecm`.`fulfillment`.`fulfillment_node`(`fulfillment_node_id`);
ALTER TABLE `retail_ecm`.`fulfillment`.`pack_task` ADD CONSTRAINT `fk_fulfillment_pack_task_fulfillment_order_id` FOREIGN KEY (`fulfillment_order_id`) REFERENCES `retail_ecm`.`fulfillment`.`fulfillment_order`(`fulfillment_order_id`);
ALTER TABLE `retail_ecm`.`fulfillment`.`pack_task` ADD CONSTRAINT `fk_fulfillment_pack_task_pick_task_id` FOREIGN KEY (`pick_task_id`) REFERENCES `retail_ecm`.`fulfillment`.`pick_task`(`pick_task_id`);
ALTER TABLE `retail_ecm`.`fulfillment`.`pack_task` ADD CONSTRAINT `fk_fulfillment_pack_task_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `retail_ecm`.`fulfillment`.`shipment`(`shipment_id`);
ALTER TABLE `retail_ecm`.`fulfillment`.`pack_task` ADD CONSTRAINT `fk_fulfillment_pack_task_shipment_package_id` FOREIGN KEY (`shipment_package_id`) REFERENCES `retail_ecm`.`fulfillment`.`shipment_package`(`shipment_package_id`);
ALTER TABLE `retail_ecm`.`fulfillment`.`carrier_service` ADD CONSTRAINT `fk_fulfillment_carrier_service_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `retail_ecm`.`fulfillment`.`carrier`(`carrier_id`);
ALTER TABLE `retail_ecm`.`fulfillment`.`exception` ADD CONSTRAINT `fk_fulfillment_exception_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `retail_ecm`.`fulfillment`.`carrier`(`carrier_id`);
ALTER TABLE `retail_ecm`.`fulfillment`.`exception` ADD CONSTRAINT `fk_fulfillment_exception_fulfillment_line_id` FOREIGN KEY (`fulfillment_line_id`) REFERENCES `retail_ecm`.`fulfillment`.`fulfillment_line`(`fulfillment_line_id`);
ALTER TABLE `retail_ecm`.`fulfillment`.`exception` ADD CONSTRAINT `fk_fulfillment_exception_fulfillment_node_id` FOREIGN KEY (`fulfillment_node_id`) REFERENCES `retail_ecm`.`fulfillment`.`fulfillment_node`(`fulfillment_node_id`);
ALTER TABLE `retail_ecm`.`fulfillment`.`exception` ADD CONSTRAINT `fk_fulfillment_exception_fulfillment_order_id` FOREIGN KEY (`fulfillment_order_id`) REFERENCES `retail_ecm`.`fulfillment`.`fulfillment_order`(`fulfillment_order_id`);
ALTER TABLE `retail_ecm`.`fulfillment`.`exception` ADD CONSTRAINT `fk_fulfillment_exception_pack_task_id` FOREIGN KEY (`pack_task_id`) REFERENCES `retail_ecm`.`fulfillment`.`pack_task`(`pack_task_id`);
ALTER TABLE `retail_ecm`.`fulfillment`.`exception` ADD CONSTRAINT `fk_fulfillment_exception_pick_task_id` FOREIGN KEY (`pick_task_id`) REFERENCES `retail_ecm`.`fulfillment`.`pick_task`(`pick_task_id`);
ALTER TABLE `retail_ecm`.`fulfillment`.`exception` ADD CONSTRAINT `fk_fulfillment_exception_shipment_id` FOREIGN KEY (`shipment_id`) REFERENCES `retail_ecm`.`fulfillment`.`shipment`(`shipment_id`);
ALTER TABLE `retail_ecm`.`fulfillment`.`exception` ADD CONSTRAINT `fk_fulfillment_exception_sla_id` FOREIGN KEY (`sla_id`) REFERENCES `retail_ecm`.`fulfillment`.`sla`(`sla_id`);
ALTER TABLE `retail_ecm`.`fulfillment`.`sla` ADD CONSTRAINT `fk_fulfillment_sla_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `retail_ecm`.`fulfillment`.`carrier`(`carrier_id`);
ALTER TABLE `retail_ecm`.`fulfillment`.`sla` ADD CONSTRAINT `fk_fulfillment_sla_carrier_service_id` FOREIGN KEY (`carrier_service_id`) REFERENCES `retail_ecm`.`fulfillment`.`carrier_service`(`carrier_service_id`);
ALTER TABLE `retail_ecm`.`fulfillment`.`sla` ADD CONSTRAINT `fk_fulfillment_sla_fulfillment_node_id` FOREIGN KEY (`fulfillment_node_id`) REFERENCES `retail_ecm`.`fulfillment`.`fulfillment_node`(`fulfillment_node_id`);
ALTER TABLE `retail_ecm`.`fulfillment`.`carrier_rate` ADD CONSTRAINT `fk_fulfillment_carrier_rate_carrier_id` FOREIGN KEY (`carrier_id`) REFERENCES `retail_ecm`.`fulfillment`.`carrier`(`carrier_id`);
ALTER TABLE `retail_ecm`.`fulfillment`.`carrier_rate` ADD CONSTRAINT `fk_fulfillment_carrier_rate_carrier_service_id` FOREIGN KEY (`carrier_service_id`) REFERENCES `retail_ecm`.`fulfillment`.`carrier_service`(`carrier_service_id`);

-- ========= TAGS =========
ALTER SCHEMA `retail_ecm`.`fulfillment` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `retail_ecm`.`fulfillment` SET TAGS ('dbx_domain' = 'fulfillment');
ALTER TABLE `retail_ecm`.`fulfillment`.`fulfillment_order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `retail_ecm`.`fulfillment`.`fulfillment_order` SET TAGS ('dbx_subdomain' = 'order_execution');
ALTER TABLE `retail_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `fulfillment_order_id` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Order ID');
ALTER TABLE `retail_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier ID');
ALTER TABLE `retail_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `carrier_service_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Service Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `fulfillment_node_id` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Node ID');
ALTER TABLE `retail_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `header_id` SET TAGS ('dbx_business_glossary_term' = 'Order ID');
ALTER TABLE `retail_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Store ID');
ALTER TABLE `retail_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `loyalty_membership_id` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Membership Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `outbound_order_id` SET TAGS ('dbx_business_glossary_term' = 'Outbound Order Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `price_list_id` SET TAGS ('dbx_business_glossary_term' = 'Price List Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `price_zone_id` SET TAGS ('dbx_business_glossary_term' = 'Price Zone Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `retail_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `address_id` SET TAGS ('dbx_business_glossary_term' = 'Shipping Address ID');
ALTER TABLE `retail_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `retail_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `retail_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `sla_id` SET TAGS ('dbx_business_glossary_term' = 'Sla Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `actual_fulfillment_hours` SET TAGS ('dbx_business_glossary_term' = 'Actual Fulfillment Hours');
ALTER TABLE `retail_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `retail_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `completed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Completed Timestamp');
ALTER TABLE `retail_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `retail_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `retail_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `fulfillment_assigned_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Assigned Timestamp');
ALTER TABLE `retail_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `fulfillment_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Created Timestamp');
ALTER TABLE `retail_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `fulfillment_method` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Method');
ALTER TABLE `retail_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `fulfillment_method` SET TAGS ('dbx_value_regex' = 'ship_from_store|dark_store|distribution_center|bopis|ropis|drop_ship');
ALTER TABLE `retail_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `fulfillment_order_number` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Order Number');
ALTER TABLE `retail_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `fulfillment_order_number` SET TAGS ('dbx_value_regex' = '^FO[0-9]{10}$');
ALTER TABLE `retail_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `fulfillment_status` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Status');
ALTER TABLE `retail_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `gift_message` SET TAGS ('dbx_business_glossary_term' = 'Gift Message');
ALTER TABLE `retail_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `is_gift` SET TAGS ('dbx_business_glossary_term' = 'Is Gift Flag');
ALTER TABLE `retail_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `retail_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `order_date` SET TAGS ('dbx_business_glossary_term' = 'Order Date');
ALTER TABLE `retail_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `package_count` SET TAGS ('dbx_business_glossary_term' = 'Package Count');
ALTER TABLE `retail_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `packing_completed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Packing Completed Timestamp');
ALTER TABLE `retail_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `packing_slip_url` SET TAGS ('dbx_business_glossary_term' = 'Packing Slip URL');
ALTER TABLE `retail_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `picking_completed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Picking Completed Timestamp');
ALTER TABLE `retail_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `picking_started_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Picking Started Timestamp');
ALTER TABLE `retail_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `pickup_location_code` SET TAGS ('dbx_business_glossary_term' = 'Pickup Location Code');
ALTER TABLE `retail_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `pickup_location_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,10}$');
ALTER TABLE `retail_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `retail_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'standard|expedited|rush|vip');
ALTER TABLE `retail_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `promised_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Promised Delivery Date');
ALTER TABLE `retail_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `shipped_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Shipped Timestamp');
ALTER TABLE `retail_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `shipping_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Shipping Cost Amount');
ALTER TABLE `retail_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `shipping_label_url` SET TAGS ('dbx_business_glossary_term' = 'Shipping Label URL');
ALTER TABLE `retail_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `special_handling_instructions` SET TAGS ('dbx_business_glossary_term' = 'Special Handling Instructions');
ALTER TABLE `retail_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `total_item_quantity` SET TAGS ('dbx_business_glossary_term' = 'Total Item Quantity');
ALTER TABLE `retail_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `total_line_count` SET TAGS ('dbx_business_glossary_term' = 'Total Line Count');
ALTER TABLE `retail_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `total_volume_cubic_meters` SET TAGS ('dbx_business_glossary_term' = 'Total Volume Cubic Meters');
ALTER TABLE `retail_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `total_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Total Weight Kilograms (KG)');
ALTER TABLE `retail_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `tracking_number` SET TAGS ('dbx_business_glossary_term' = 'Tracking Number');
ALTER TABLE `retail_ecm`.`fulfillment`.`fulfillment_order` ALTER COLUMN `tracking_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{10,40}$');
ALTER TABLE `retail_ecm`.`fulfillment`.`fulfillment_line` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `retail_ecm`.`fulfillment`.`fulfillment_line` SET TAGS ('dbx_subdomain' = 'order_execution');
ALTER TABLE `retail_ecm`.`fulfillment`.`fulfillment_line` ALTER COLUMN `fulfillment_line_id` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Line ID');
ALTER TABLE `retail_ecm`.`fulfillment`.`fulfillment_line` ALTER COLUMN `cost_price_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Price Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`fulfillment`.`fulfillment_line` ALTER COLUMN `fulfillment_node_id` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Source ID');
ALTER TABLE `retail_ecm`.`fulfillment`.`fulfillment_line` ALTER COLUMN `fulfillment_order_id` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Order ID');
ALTER TABLE `retail_ecm`.`fulfillment`.`fulfillment_line` ALTER COLUMN `lot_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`fulfillment`.`fulfillment_line` ALTER COLUMN `order_line_id` SET TAGS ('dbx_business_glossary_term' = 'Order Line ID');
ALTER TABLE `retail_ecm`.`fulfillment`.`fulfillment_line` ALTER COLUMN `po_line_id` SET TAGS ('dbx_business_glossary_term' = 'Po Line Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`fulfillment`.`fulfillment_line` ALTER COLUMN `shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`fulfillment`.`fulfillment_line` ALTER COLUMN `shipment_package_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment Package Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`fulfillment`.`fulfillment_line` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`fulfillment`.`fulfillment_line` ALTER COLUMN `sku_price_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Price Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`fulfillment`.`fulfillment_line` ALTER COLUMN `vendor_item_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Item Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`fulfillment`.`fulfillment_line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `retail_ecm`.`fulfillment`.`fulfillment_line` ALTER COLUMN `exception_code` SET TAGS ('dbx_business_glossary_term' = 'Exception Code');
ALTER TABLE `retail_ecm`.`fulfillment`.`fulfillment_line` ALTER COLUMN `exception_description` SET TAGS ('dbx_business_glossary_term' = 'Exception Description');
ALTER TABLE `retail_ecm`.`fulfillment`.`fulfillment_line` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `retail_ecm`.`fulfillment`.`fulfillment_line` ALTER COLUMN `extended_cost` SET TAGS ('dbx_business_glossary_term' = 'Extended Cost');
ALTER TABLE `retail_ecm`.`fulfillment`.`fulfillment_line` ALTER COLUMN `extended_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `retail_ecm`.`fulfillment`.`fulfillment_line` ALTER COLUMN `fulfillment_source_type` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Source Type');
ALTER TABLE `retail_ecm`.`fulfillment`.`fulfillment_line` ALTER COLUMN `fulfillment_source_type` SET TAGS ('dbx_value_regex' = 'dc|store|dark_store|vendor|3pl');
ALTER TABLE `retail_ecm`.`fulfillment`.`fulfillment_line` ALTER COLUMN `gtin` SET TAGS ('dbx_business_glossary_term' = 'Global Trade Item Number (GTIN)');
ALTER TABLE `retail_ecm`.`fulfillment`.`fulfillment_line` ALTER COLUMN `gtin` SET TAGS ('dbx_value_regex' = '^[0-9]{14}$');
ALTER TABLE `retail_ecm`.`fulfillment`.`fulfillment_line` ALTER COLUMN `line_number` SET TAGS ('dbx_business_glossary_term' = 'Line Number');
ALTER TABLE `retail_ecm`.`fulfillment`.`fulfillment_line` ALTER COLUMN `line_status` SET TAGS ('dbx_business_glossary_term' = 'Line Status');
ALTER TABLE `retail_ecm`.`fulfillment`.`fulfillment_line` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `retail_ecm`.`fulfillment`.`fulfillment_line` ALTER COLUMN `original_sku` SET TAGS ('dbx_business_glossary_term' = 'Original Stock Keeping Unit (SKU)');
ALTER TABLE `retail_ecm`.`fulfillment`.`fulfillment_line` ALTER COLUMN `pack_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Pack Timestamp');
ALTER TABLE `retail_ecm`.`fulfillment`.`fulfillment_line` ALTER COLUMN `pick_location` SET TAGS ('dbx_business_glossary_term' = 'Pick Location');
ALTER TABLE `retail_ecm`.`fulfillment`.`fulfillment_line` ALTER COLUMN `pick_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Pick Timestamp');
ALTER TABLE `retail_ecm`.`fulfillment`.`fulfillment_line` ALTER COLUMN `quantity_allocated` SET TAGS ('dbx_business_glossary_term' = 'Quantity Allocated');
ALTER TABLE `retail_ecm`.`fulfillment`.`fulfillment_line` ALTER COLUMN `quantity_cancelled` SET TAGS ('dbx_business_glossary_term' = 'Quantity Cancelled');
ALTER TABLE `retail_ecm`.`fulfillment`.`fulfillment_line` ALTER COLUMN `quantity_ordered` SET TAGS ('dbx_business_glossary_term' = 'Quantity Ordered');
ALTER TABLE `retail_ecm`.`fulfillment`.`fulfillment_line` ALTER COLUMN `quantity_packed` SET TAGS ('dbx_business_glossary_term' = 'Quantity Packed');
ALTER TABLE `retail_ecm`.`fulfillment`.`fulfillment_line` ALTER COLUMN `quantity_picked` SET TAGS ('dbx_business_glossary_term' = 'Quantity Picked');
ALTER TABLE `retail_ecm`.`fulfillment`.`fulfillment_line` ALTER COLUMN `quantity_shipped` SET TAGS ('dbx_business_glossary_term' = 'Quantity Shipped');
ALTER TABLE `retail_ecm`.`fulfillment`.`fulfillment_line` ALTER COLUMN `serial_number` SET TAGS ('dbx_business_glossary_term' = 'Serial Number');
ALTER TABLE `retail_ecm`.`fulfillment`.`fulfillment_line` ALTER COLUMN `ship_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Ship Timestamp');
ALTER TABLE `retail_ecm`.`fulfillment`.`fulfillment_line` ALTER COLUMN `substitution_flag` SET TAGS ('dbx_business_glossary_term' = 'Substitution Flag');
ALTER TABLE `retail_ecm`.`fulfillment`.`fulfillment_line` ALTER COLUMN `substitution_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Substitution Reason Code');
ALTER TABLE `retail_ecm`.`fulfillment`.`fulfillment_line` ALTER COLUMN `substitution_reason_code` SET TAGS ('dbx_value_regex' = 'out_of_stock|discontinued|damaged|customer_request|upgrade|downgrade');
ALTER TABLE `retail_ecm`.`fulfillment`.`fulfillment_line` ALTER COLUMN `unit_cost` SET TAGS ('dbx_business_glossary_term' = 'Unit Cost');
ALTER TABLE `retail_ecm`.`fulfillment`.`fulfillment_line` ALTER COLUMN `unit_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `retail_ecm`.`fulfillment`.`fulfillment_line` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `retail_ecm`.`fulfillment`.`fulfillment_line` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'each|case|pallet|box|pack|unit');
ALTER TABLE `retail_ecm`.`fulfillment`.`fulfillment_line` ALTER COLUMN `upc` SET TAGS ('dbx_business_glossary_term' = 'Universal Product Code (UPC)');
ALTER TABLE `retail_ecm`.`fulfillment`.`fulfillment_line` ALTER COLUMN `upc` SET TAGS ('dbx_value_regex' = '^[0-9]{12}$');
ALTER TABLE `retail_ecm`.`fulfillment`.`fulfillment_line` ALTER COLUMN `weight` SET TAGS ('dbx_business_glossary_term' = 'Weight');
ALTER TABLE `retail_ecm`.`fulfillment`.`fulfillment_line` ALTER COLUMN `weight_unit` SET TAGS ('dbx_business_glossary_term' = 'Weight Unit');
ALTER TABLE `retail_ecm`.`fulfillment`.`fulfillment_line` ALTER COLUMN `weight_unit` SET TAGS ('dbx_value_regex' = 'lb|kg|oz|g');
ALTER TABLE `retail_ecm`.`fulfillment`.`shipment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `retail_ecm`.`fulfillment`.`shipment` SET TAGS ('dbx_subdomain' = 'carrier_shipping');
ALTER TABLE `retail_ecm`.`fulfillment`.`shipment` ALTER COLUMN `shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment Identifier');
ALTER TABLE `retail_ecm`.`fulfillment`.`shipment` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`fulfillment`.`shipment` ALTER COLUMN `carrier_rate_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Rate Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`fulfillment`.`shipment` ALTER COLUMN `carrier_service_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Service Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`fulfillment`.`shipment` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`fulfillment`.`shipment` ALTER COLUMN `fulfillment_node_id` SET TAGS ('dbx_business_glossary_term' = 'Ship-From Node ID');
ALTER TABLE `retail_ecm`.`fulfillment`.`shipment` ALTER COLUMN `fulfillment_order_id` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Order Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`fulfillment`.`shipment` ALTER COLUMN `header_id` SET TAGS ('dbx_business_glossary_term' = 'Order ID');
ALTER TABLE `retail_ecm`.`fulfillment`.`shipment` ALTER COLUMN `outbound_shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Shipment Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`fulfillment`.`shipment` ALTER COLUMN `price_zone_id` SET TAGS ('dbx_business_glossary_term' = 'Price Zone Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`fulfillment`.`shipment` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Ship-To Customer ID');
ALTER TABLE `retail_ecm`.`fulfillment`.`shipment` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Ship From Location Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`fulfillment`.`shipment` ALTER COLUMN `address_id` SET TAGS ('dbx_business_glossary_term' = 'Shipping Address Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`fulfillment`.`shipment` ALTER COLUMN `address_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `retail_ecm`.`fulfillment`.`shipment` ALTER COLUMN `address_id` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `retail_ecm`.`fulfillment`.`shipment` ALTER COLUMN `sla_id` SET TAGS ('dbx_business_glossary_term' = 'Sla Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`fulfillment`.`shipment` ALTER COLUMN `wave_id` SET TAGS ('dbx_business_glossary_term' = 'Wave Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`fulfillment`.`shipment` ALTER COLUMN `actual_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Delivery Date');
ALTER TABLE `retail_ecm`.`fulfillment`.`shipment` ALTER COLUMN `carrier_charge_amount` SET TAGS ('dbx_business_glossary_term' = 'Carrier Charge Amount');
ALTER TABLE `retail_ecm`.`fulfillment`.`shipment` ALTER COLUMN `carrier_charge_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `retail_ecm`.`fulfillment`.`shipment` ALTER COLUMN `carrier_charge_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Carrier Charge Currency Code');
ALTER TABLE `retail_ecm`.`fulfillment`.`shipment` ALTER COLUMN `carrier_charge_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `retail_ecm`.`fulfillment`.`shipment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `retail_ecm`.`fulfillment`.`shipment` ALTER COLUMN `declared_value_amount` SET TAGS ('dbx_business_glossary_term' = 'Declared Value Amount');
ALTER TABLE `retail_ecm`.`fulfillment`.`shipment` ALTER COLUMN `declared_value_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `retail_ecm`.`fulfillment`.`shipment` ALTER COLUMN `declared_value_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Declared Value Currency Code');
ALTER TABLE `retail_ecm`.`fulfillment`.`shipment` ALTER COLUMN `declared_value_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `retail_ecm`.`fulfillment`.`shipment` ALTER COLUMN `delivery_instructions` SET TAGS ('dbx_business_glossary_term' = 'Delivery Instructions');
ALTER TABLE `retail_ecm`.`fulfillment`.`shipment` ALTER COLUMN `delivery_signature_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Delivery Signature Required Flag');
ALTER TABLE `retail_ecm`.`fulfillment`.`shipment` ALTER COLUMN `estimated_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Estimated Delivery Date');
ALTER TABLE `retail_ecm`.`fulfillment`.`shipment` ALTER COLUMN `fulfillment_type` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Type');
ALTER TABLE `retail_ecm`.`fulfillment`.`shipment` ALTER COLUMN `fulfillment_type` SET TAGS ('dbx_value_regex' = 'standard|bopis|ropis|ship_from_store|drop_ship|curbside');
ALTER TABLE `retail_ecm`.`fulfillment`.`shipment` ALTER COLUMN `hazmat_flag` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Materials (HAZMAT) Flag');
ALTER TABLE `retail_ecm`.`fulfillment`.`shipment` ALTER COLUMN `height_cm` SET TAGS ('dbx_business_glossary_term' = 'Height in Centimeters (CM)');
ALTER TABLE `retail_ecm`.`fulfillment`.`shipment` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `retail_ecm`.`fulfillment`.`shipment` ALTER COLUMN `length_cm` SET TAGS ('dbx_business_glossary_term' = 'Length in Centimeters (CM)');
ALTER TABLE `retail_ecm`.`fulfillment`.`shipment` ALTER COLUMN `package_count` SET TAGS ('dbx_business_glossary_term' = 'Package Count');
ALTER TABLE `retail_ecm`.`fulfillment`.`shipment` ALTER COLUMN `ship_date` SET TAGS ('dbx_business_glossary_term' = 'Ship Date');
ALTER TABLE `retail_ecm`.`fulfillment`.`shipment` ALTER COLUMN `ship_from_location_type` SET TAGS ('dbx_business_glossary_term' = 'Ship-From Location Type');
ALTER TABLE `retail_ecm`.`fulfillment`.`shipment` ALTER COLUMN `ship_from_location_type` SET TAGS ('dbx_value_regex' = 'distribution_center|store|dark_store|micro_fulfillment_center|vendor');
ALTER TABLE `retail_ecm`.`fulfillment`.`shipment` ALTER COLUMN `ship_to_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Ship-To Contact Name');
ALTER TABLE `retail_ecm`.`fulfillment`.`shipment` ALTER COLUMN `ship_to_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `retail_ecm`.`fulfillment`.`shipment` ALTER COLUMN `ship_to_contact_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `retail_ecm`.`fulfillment`.`shipment` ALTER COLUMN `ship_to_email_address` SET TAGS ('dbx_business_glossary_term' = 'Ship-To Email Address');
ALTER TABLE `retail_ecm`.`fulfillment`.`shipment` ALTER COLUMN `ship_to_email_address` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `retail_ecm`.`fulfillment`.`shipment` ALTER COLUMN `ship_to_email_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `retail_ecm`.`fulfillment`.`shipment` ALTER COLUMN `ship_to_email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `retail_ecm`.`fulfillment`.`shipment` ALTER COLUMN `ship_to_phone_number` SET TAGS ('dbx_business_glossary_term' = 'Ship-To Phone Number');
ALTER TABLE `retail_ecm`.`fulfillment`.`shipment` ALTER COLUMN `ship_to_phone_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `retail_ecm`.`fulfillment`.`shipment` ALTER COLUMN `ship_to_phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `retail_ecm`.`fulfillment`.`shipment` ALTER COLUMN `shipment_number` SET TAGS ('dbx_business_glossary_term' = 'Shipment Number');
ALTER TABLE `retail_ecm`.`fulfillment`.`shipment` ALTER COLUMN `shipment_number` SET TAGS ('dbx_value_regex' = '^SHP[0-9]{10}$');
ALTER TABLE `retail_ecm`.`fulfillment`.`shipment` ALTER COLUMN `shipment_status` SET TAGS ('dbx_business_glossary_term' = 'Shipment Status');
ALTER TABLE `retail_ecm`.`fulfillment`.`shipment` ALTER COLUMN `shipping_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Shipping Cost Amount');
ALTER TABLE `retail_ecm`.`fulfillment`.`shipment` ALTER COLUMN `shipping_cost_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `retail_ecm`.`fulfillment`.`shipment` ALTER COLUMN `shipping_cost_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Shipping Cost Currency Code');
ALTER TABLE `retail_ecm`.`fulfillment`.`shipment` ALTER COLUMN `shipping_cost_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `retail_ecm`.`fulfillment`.`shipment` ALTER COLUMN `signature_name` SET TAGS ('dbx_business_glossary_term' = 'Signature Name');
ALTER TABLE `retail_ecm`.`fulfillment`.`shipment` ALTER COLUMN `signature_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `retail_ecm`.`fulfillment`.`shipment` ALTER COLUMN `signature_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `retail_ecm`.`fulfillment`.`shipment` ALTER COLUMN `total_volume_cubic_meters` SET TAGS ('dbx_business_glossary_term' = 'Total Volume in Cubic Meters');
ALTER TABLE `retail_ecm`.`fulfillment`.`shipment` ALTER COLUMN `total_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Total Weight in Kilograms (KG)');
ALTER TABLE `retail_ecm`.`fulfillment`.`shipment` ALTER COLUMN `tracking_number` SET TAGS ('dbx_business_glossary_term' = 'Tracking Number');
ALTER TABLE `retail_ecm`.`fulfillment`.`shipment` ALTER COLUMN `width_cm` SET TAGS ('dbx_business_glossary_term' = 'Width in Centimeters (CM)');
ALTER TABLE `retail_ecm`.`fulfillment`.`shipment_package` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `retail_ecm`.`fulfillment`.`shipment_package` SET TAGS ('dbx_subdomain' = 'carrier_shipping');
ALTER TABLE `retail_ecm`.`fulfillment`.`shipment_package` ALTER COLUMN `shipment_package_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment Package ID');
ALTER TABLE `retail_ecm`.`fulfillment`.`shipment_package` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier ID');
ALTER TABLE `retail_ecm`.`fulfillment`.`shipment_package` ALTER COLUMN `carrier_service_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Service Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`fulfillment`.`shipment_package` ALTER COLUMN `fulfillment_node_id` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Node ID');
ALTER TABLE `retail_ecm`.`fulfillment`.`shipment_package` ALTER COLUMN `header_id` SET TAGS ('dbx_business_glossary_term' = 'Order ID');
ALTER TABLE `retail_ecm`.`fulfillment`.`shipment_package` ALTER COLUMN `outbound_shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Shipment Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`fulfillment`.`shipment_package` ALTER COLUMN `shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment ID');
ALTER TABLE `retail_ecm`.`fulfillment`.`shipment_package` ALTER COLUMN `actual_delivery_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Delivery Timestamp');
ALTER TABLE `retail_ecm`.`fulfillment`.`shipment_package` ALTER COLUMN `billable_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Billable Weight (Kilograms)');
ALTER TABLE `retail_ecm`.`fulfillment`.`shipment_package` ALTER COLUMN `contents_summary` SET TAGS ('dbx_business_glossary_term' = 'Package Contents Summary');
ALTER TABLE `retail_ecm`.`fulfillment`.`shipment_package` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `retail_ecm`.`fulfillment`.`shipment_package` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `retail_ecm`.`fulfillment`.`shipment_package` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `retail_ecm`.`fulfillment`.`shipment_package` ALTER COLUMN `delivery_confirmation_method` SET TAGS ('dbx_business_glossary_term' = 'Delivery Confirmation Method');
ALTER TABLE `retail_ecm`.`fulfillment`.`shipment_package` ALTER COLUMN `delivery_notes` SET TAGS ('dbx_business_glossary_term' = 'Delivery Notes');
ALTER TABLE `retail_ecm`.`fulfillment`.`shipment_package` ALTER COLUMN `dimensional_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Dimensional Weight (Kilograms)');
ALTER TABLE `retail_ecm`.`fulfillment`.`shipment_package` ALTER COLUMN `estimated_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Estimated Delivery Date');
ALTER TABLE `retail_ecm`.`fulfillment`.`shipment_package` ALTER COLUMN `height_cm` SET TAGS ('dbx_business_glossary_term' = 'Package Height (Centimeters)');
ALTER TABLE `retail_ecm`.`fulfillment`.`shipment_package` ALTER COLUMN `insurance_value_amount` SET TAGS ('dbx_business_glossary_term' = 'Insurance Value Amount');
ALTER TABLE `retail_ecm`.`fulfillment`.`shipment_package` ALTER COLUMN `is_hazmat` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Materials (HAZMAT) Flag');
ALTER TABLE `retail_ecm`.`fulfillment`.`shipment_package` ALTER COLUMN `is_insured` SET TAGS ('dbx_business_glossary_term' = 'Insured Package Flag');
ALTER TABLE `retail_ecm`.`fulfillment`.`shipment_package` ALTER COLUMN `is_label_printed` SET TAGS ('dbx_business_glossary_term' = 'Label Printed Flag');
ALTER TABLE `retail_ecm`.`fulfillment`.`shipment_package` ALTER COLUMN `is_manifested` SET TAGS ('dbx_business_glossary_term' = 'Manifested Flag');
ALTER TABLE `retail_ecm`.`fulfillment`.`shipment_package` ALTER COLUMN `is_sealed` SET TAGS ('dbx_business_glossary_term' = 'Package Sealed Flag');
ALTER TABLE `retail_ecm`.`fulfillment`.`shipment_package` ALTER COLUMN `is_signature_required` SET TAGS ('dbx_business_glossary_term' = 'Signature Required Flag');
ALTER TABLE `retail_ecm`.`fulfillment`.`shipment_package` ALTER COLUMN `item_count` SET TAGS ('dbx_business_glossary_term' = 'Item Count');
ALTER TABLE `retail_ecm`.`fulfillment`.`shipment_package` ALTER COLUMN `labeled_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Labeled Timestamp');
ALTER TABLE `retail_ecm`.`fulfillment`.`shipment_package` ALTER COLUMN `length_cm` SET TAGS ('dbx_business_glossary_term' = 'Package Length (Centimeters)');
ALTER TABLE `retail_ecm`.`fulfillment`.`shipment_package` ALTER COLUMN `manifested_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Manifested Timestamp');
ALTER TABLE `retail_ecm`.`fulfillment`.`shipment_package` ALTER COLUMN `package_number` SET TAGS ('dbx_business_glossary_term' = 'Package Number');
ALTER TABLE `retail_ecm`.`fulfillment`.`shipment_package` ALTER COLUMN `package_sequence` SET TAGS ('dbx_business_glossary_term' = 'Package Sequence Number');
ALTER TABLE `retail_ecm`.`fulfillment`.`shipment_package` ALTER COLUMN `package_status` SET TAGS ('dbx_business_glossary_term' = 'Package Status');
ALTER TABLE `retail_ecm`.`fulfillment`.`shipment_package` ALTER COLUMN `package_type` SET TAGS ('dbx_business_glossary_term' = 'Package Type');
ALTER TABLE `retail_ecm`.`fulfillment`.`shipment_package` ALTER COLUMN `package_type` SET TAGS ('dbx_value_regex' = 'box|poly_bag|envelope|pallet|crate|tube');
ALTER TABLE `retail_ecm`.`fulfillment`.`shipment_package` ALTER COLUMN `packed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Packed Timestamp');
ALTER TABLE `retail_ecm`.`fulfillment`.`shipment_package` ALTER COLUMN `picked_up_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Picked Up Timestamp');
ALTER TABLE `retail_ecm`.`fulfillment`.`shipment_package` ALTER COLUMN `shipping_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Shipping Cost Amount');
ALTER TABLE `retail_ecm`.`fulfillment`.`shipment_package` ALTER COLUMN `shipping_method` SET TAGS ('dbx_business_glossary_term' = 'Shipping Method');
ALTER TABLE `retail_ecm`.`fulfillment`.`shipment_package` ALTER COLUMN `total_packages_in_shipment` SET TAGS ('dbx_business_glossary_term' = 'Total Packages in Shipment');
ALTER TABLE `retail_ecm`.`fulfillment`.`shipment_package` ALTER COLUMN `tracking_number` SET TAGS ('dbx_business_glossary_term' = 'Tracking Number');
ALTER TABLE `retail_ecm`.`fulfillment`.`shipment_package` ALTER COLUMN `unit_count` SET TAGS ('dbx_business_glossary_term' = 'Unit Count');
ALTER TABLE `retail_ecm`.`fulfillment`.`shipment_package` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `retail_ecm`.`fulfillment`.`shipment_package` ALTER COLUMN `weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Package Weight (Kilograms)');
ALTER TABLE `retail_ecm`.`fulfillment`.`shipment_package` ALTER COLUMN `width_cm` SET TAGS ('dbx_business_glossary_term' = 'Package Width (Centimeters)');
ALTER TABLE `retail_ecm`.`fulfillment`.`pick_task` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `retail_ecm`.`fulfillment`.`pick_task` SET TAGS ('dbx_subdomain' = 'order_execution');
ALTER TABLE `retail_ecm`.`fulfillment`.`pick_task` ALTER COLUMN `pick_task_id` SET TAGS ('dbx_business_glossary_term' = 'Pick Task Identifier');
ALTER TABLE `retail_ecm`.`fulfillment`.`pick_task` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`fulfillment`.`pick_task` ALTER COLUMN `carrier_service_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Service Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`fulfillment`.`pick_task` ALTER COLUMN `department_id` SET TAGS ('dbx_business_glossary_term' = 'Department Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`fulfillment`.`pick_task` ALTER COLUMN `fulfillment_line_id` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Line Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`fulfillment`.`pick_task` ALTER COLUMN `fulfillment_node_id` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Location ID');
ALTER TABLE `retail_ecm`.`fulfillment`.`pick_task` ALTER COLUMN `fulfillment_order_id` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Order Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`fulfillment`.`pick_task` ALTER COLUMN `header_id` SET TAGS ('dbx_business_glossary_term' = 'Order ID');
ALTER TABLE `retail_ecm`.`fulfillment`.`pick_task` ALTER COLUMN `outbound_order_id` SET TAGS ('dbx_business_glossary_term' = 'Outbound Order Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`fulfillment`.`pick_task` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`fulfillment`.`pick_task` ALTER COLUMN `stock_position_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Position Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`fulfillment`.`pick_task` ALTER COLUMN `wave_id` SET TAGS ('dbx_business_glossary_term' = 'Wave ID');
ALTER TABLE `retail_ecm`.`fulfillment`.`pick_task` ALTER COLUMN `aisle` SET TAGS ('dbx_business_glossary_term' = 'Aisle');
ALTER TABLE `retail_ecm`.`fulfillment`.`pick_task` ALTER COLUMN `aisle` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,10}$');
ALTER TABLE `retail_ecm`.`fulfillment`.`pick_task` ALTER COLUMN `assigned_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Assigned Timestamp');
ALTER TABLE `retail_ecm`.`fulfillment`.`pick_task` ALTER COLUMN `bay` SET TAGS ('dbx_business_glossary_term' = 'Bay');
ALTER TABLE `retail_ecm`.`fulfillment`.`pick_task` ALTER COLUMN `bay` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,10}$');
ALTER TABLE `retail_ecm`.`fulfillment`.`pick_task` ALTER COLUMN `completion_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Completion Timestamp');
ALTER TABLE `retail_ecm`.`fulfillment`.`pick_task` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `retail_ecm`.`fulfillment`.`pick_task` ALTER COLUMN `customer_approval_status` SET TAGS ('dbx_business_glossary_term' = 'Customer Approval Status');
ALTER TABLE `retail_ecm`.`fulfillment`.`pick_task` ALTER COLUMN `customer_approval_status` SET TAGS ('dbx_value_regex' = 'approved|rejected|pending|not_required');
ALTER TABLE `retail_ecm`.`fulfillment`.`pick_task` ALTER COLUMN `exception_code` SET TAGS ('dbx_business_glossary_term' = 'Exception Code');
ALTER TABLE `retail_ecm`.`fulfillment`.`pick_task` ALTER COLUMN `exception_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `retail_ecm`.`fulfillment`.`pick_task` ALTER COLUMN `exception_reason` SET TAGS ('dbx_business_glossary_term' = 'Exception Reason');
ALTER TABLE `retail_ecm`.`fulfillment`.`pick_task` ALTER COLUMN `fulfillment_channel` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Channel');
ALTER TABLE `retail_ecm`.`fulfillment`.`pick_task` ALTER COLUMN `fulfillment_channel` SET TAGS ('dbx_value_regex' = 'ship_from_store|dark_store|distribution_center|bopis|ropis|curbside');
ALTER TABLE `retail_ecm`.`fulfillment`.`pick_task` ALTER COLUMN `label_applied` SET TAGS ('dbx_business_glossary_term' = 'Label Applied');
ALTER TABLE `retail_ecm`.`fulfillment`.`pick_task` ALTER COLUMN `original_sku` SET TAGS ('dbx_business_glossary_term' = 'Original Stock Keeping Unit (SKU)');
ALTER TABLE `retail_ecm`.`fulfillment`.`pick_task` ALTER COLUMN `original_sku` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{6,20}$');
ALTER TABLE `retail_ecm`.`fulfillment`.`pick_task` ALTER COLUMN `package_type` SET TAGS ('dbx_business_glossary_term' = 'Package Type');
ALTER TABLE `retail_ecm`.`fulfillment`.`pick_task` ALTER COLUMN `package_type` SET TAGS ('dbx_value_regex' = 'box|envelope|poly_bag|tube|pallet|tote');
ALTER TABLE `retail_ecm`.`fulfillment`.`pick_task` ALTER COLUMN `packing_slip_printed` SET TAGS ('dbx_business_glossary_term' = 'Packing Slip Printed');
ALTER TABLE `retail_ecm`.`fulfillment`.`pick_task` ALTER COLUMN `packing_station_code` SET TAGS ('dbx_business_glossary_term' = 'Packing Station ID');
ALTER TABLE `retail_ecm`.`fulfillment`.`pick_task` ALTER COLUMN `packing_station_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,15}$');
ALTER TABLE `retail_ecm`.`fulfillment`.`pick_task` ALTER COLUMN `pick_task_status` SET TAGS ('dbx_business_glossary_term' = 'Task Status');
ALTER TABLE `retail_ecm`.`fulfillment`.`pick_task` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `retail_ecm`.`fulfillment`.`pick_task` ALTER COLUMN `quality_check_outcome` SET TAGS ('dbx_business_glossary_term' = 'Quality Check (QC) Outcome');
ALTER TABLE `retail_ecm`.`fulfillment`.`pick_task` ALTER COLUMN `quality_check_outcome` SET TAGS ('dbx_value_regex' = 'passed|failed|not_required|pending');
ALTER TABLE `retail_ecm`.`fulfillment`.`pick_task` ALTER COLUMN `quantity_picked` SET TAGS ('dbx_business_glossary_term' = 'Quantity Picked');
ALTER TABLE `retail_ecm`.`fulfillment`.`pick_task` ALTER COLUMN `quantity_requested` SET TAGS ('dbx_business_glossary_term' = 'Quantity Requested');
ALTER TABLE `retail_ecm`.`fulfillment`.`pick_task` ALTER COLUMN `shelf` SET TAGS ('dbx_business_glossary_term' = 'Shelf');
ALTER TABLE `retail_ecm`.`fulfillment`.`pick_task` ALTER COLUMN `shelf` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,10}$');
ALTER TABLE `retail_ecm`.`fulfillment`.`pick_task` ALTER COLUMN `start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Start Timestamp');
ALTER TABLE `retail_ecm`.`fulfillment`.`pick_task` ALTER COLUMN `substituted_sku` SET TAGS ('dbx_business_glossary_term' = 'Substituted Stock Keeping Unit (SKU)');
ALTER TABLE `retail_ecm`.`fulfillment`.`pick_task` ALTER COLUMN `substituted_sku` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{6,20}$');
ALTER TABLE `retail_ecm`.`fulfillment`.`pick_task` ALTER COLUMN `substitution_occurred` SET TAGS ('dbx_business_glossary_term' = 'Substitution Occurred');
ALTER TABLE `retail_ecm`.`fulfillment`.`pick_task` ALTER COLUMN `task_duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Task Duration Seconds');
ALTER TABLE `retail_ecm`.`fulfillment`.`pick_task` ALTER COLUMN `task_method` SET TAGS ('dbx_business_glossary_term' = 'Task Method');
ALTER TABLE `retail_ecm`.`fulfillment`.`pick_task` ALTER COLUMN `task_method` SET TAGS ('dbx_value_regex' = 'single_order|batch|zone|wave|cluster');
ALTER TABLE `retail_ecm`.`fulfillment`.`pick_task` ALTER COLUMN `task_number` SET TAGS ('dbx_business_glossary_term' = 'Task Number');
ALTER TABLE `retail_ecm`.`fulfillment`.`pick_task` ALTER COLUMN `task_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `retail_ecm`.`fulfillment`.`pick_task` ALTER COLUMN `task_type` SET TAGS ('dbx_business_glossary_term' = 'Task Type');
ALTER TABLE `retail_ecm`.`fulfillment`.`pick_task` ALTER COLUMN `task_type` SET TAGS ('dbx_value_regex' = 'pick|pack|quality_check|value_added_service|replenishment|cycle_count');
ALTER TABLE `retail_ecm`.`fulfillment`.`pick_task` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `retail_ecm`.`fulfillment`.`pick_task` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'each|case|pallet|box|pack');
ALTER TABLE `retail_ecm`.`fulfillment`.`pick_task` ALTER COLUMN `upc` SET TAGS ('dbx_business_glossary_term' = 'Universal Product Code (UPC)');
ALTER TABLE `retail_ecm`.`fulfillment`.`pick_task` ALTER COLUMN `upc` SET TAGS ('dbx_value_regex' = '^[0-9]{12}$');
ALTER TABLE `retail_ecm`.`fulfillment`.`pick_task` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `retail_ecm`.`fulfillment`.`pick_task` ALTER COLUMN `void_fill_used` SET TAGS ('dbx_business_glossary_term' = 'Void Fill Used');
ALTER TABLE `retail_ecm`.`fulfillment`.`pick_task` ALTER COLUMN `work_zone` SET TAGS ('dbx_business_glossary_term' = 'Work Zone');
ALTER TABLE `retail_ecm`.`fulfillment`.`pick_task` ALTER COLUMN `work_zone` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,10}$');
ALTER TABLE `retail_ecm`.`fulfillment`.`pack_task` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `retail_ecm`.`fulfillment`.`pack_task` SET TAGS ('dbx_subdomain' = 'order_execution');
ALTER TABLE `retail_ecm`.`fulfillment`.`pack_task` ALTER COLUMN `pack_task_id` SET TAGS ('dbx_business_glossary_term' = 'Pack Task ID');
ALTER TABLE `retail_ecm`.`fulfillment`.`pack_task` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`fulfillment`.`pack_task` ALTER COLUMN `carrier_service_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Service Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`fulfillment`.`pack_task` ALTER COLUMN `fulfillment_line_id` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Line Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`fulfillment`.`pack_task` ALTER COLUMN `fulfillment_node_id` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Node ID');
ALTER TABLE `retail_ecm`.`fulfillment`.`pack_task` ALTER COLUMN `fulfillment_order_id` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Order Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`fulfillment`.`pack_task` ALTER COLUMN `header_id` SET TAGS ('dbx_business_glossary_term' = 'Order ID');
ALTER TABLE `retail_ecm`.`fulfillment`.`pack_task` ALTER COLUMN `outbound_order_id` SET TAGS ('dbx_business_glossary_term' = 'Outbound Order Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`fulfillment`.`pack_task` ALTER COLUMN `pick_task_id` SET TAGS ('dbx_business_glossary_term' = 'Pick Task ID');
ALTER TABLE `retail_ecm`.`fulfillment`.`pack_task` ALTER COLUMN `shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment ID');
ALTER TABLE `retail_ecm`.`fulfillment`.`pack_task` ALTER COLUMN `shipment_package_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment Package Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`fulfillment`.`pack_task` ALTER COLUMN `wave_id` SET TAGS ('dbx_business_glossary_term' = 'Wave Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`fulfillment`.`pack_task` ALTER COLUMN `assigned_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Task Assigned Timestamp');
ALTER TABLE `retail_ecm`.`fulfillment`.`pack_task` ALTER COLUMN `completed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Task Completed Timestamp');
ALTER TABLE `retail_ecm`.`fulfillment`.`pack_task` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `retail_ecm`.`fulfillment`.`pack_task` ALTER COLUMN `exception_code` SET TAGS ('dbx_business_glossary_term' = 'Pack Exception Code');
ALTER TABLE `retail_ecm`.`fulfillment`.`pack_task` ALTER COLUMN `exception_notes` SET TAGS ('dbx_business_glossary_term' = 'Pack Exception Notes');
ALTER TABLE `retail_ecm`.`fulfillment`.`pack_task` ALTER COLUMN `fulfillment_type` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Type');
ALTER TABLE `retail_ecm`.`fulfillment`.`pack_task` ALTER COLUMN `fulfillment_type` SET TAGS ('dbx_value_regex' = 'standard_ship|bopis|ropis|sfs|dark_store|same_day');
ALTER TABLE `retail_ecm`.`fulfillment`.`pack_task` ALTER COLUMN `gift_message_included_flag` SET TAGS ('dbx_business_glossary_term' = 'Gift Message Included Flag');
ALTER TABLE `retail_ecm`.`fulfillment`.`pack_task` ALTER COLUMN `gift_wrap_flag` SET TAGS ('dbx_business_glossary_term' = 'Gift Wrap Flag');
ALTER TABLE `retail_ecm`.`fulfillment`.`pack_task` ALTER COLUMN `hazmat_flag` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Materials (HAZMAT) Flag');
ALTER TABLE `retail_ecm`.`fulfillment`.`pack_task` ALTER COLUMN `insurance_value_amount` SET TAGS ('dbx_business_glossary_term' = 'Insurance Value Amount');
ALTER TABLE `retail_ecm`.`fulfillment`.`pack_task` ALTER COLUMN `items_packed_count` SET TAGS ('dbx_business_glossary_term' = 'Items Packed Count');
ALTER TABLE `retail_ecm`.`fulfillment`.`pack_task` ALTER COLUMN `pack_duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Pack Duration (Seconds)');
ALTER TABLE `retail_ecm`.`fulfillment`.`pack_task` ALTER COLUMN `pack_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Pack End Timestamp');
ALTER TABLE `retail_ecm`.`fulfillment`.`pack_task` ALTER COLUMN `pack_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Pack Start Timestamp');
ALTER TABLE `retail_ecm`.`fulfillment`.`pack_task` ALTER COLUMN `package_height_cm` SET TAGS ('dbx_business_glossary_term' = 'Package Height (Centimeters)');
ALTER TABLE `retail_ecm`.`fulfillment`.`pack_task` ALTER COLUMN `package_length_cm` SET TAGS ('dbx_business_glossary_term' = 'Package Length (Centimeters)');
ALTER TABLE `retail_ecm`.`fulfillment`.`pack_task` ALTER COLUMN `package_size` SET TAGS ('dbx_business_glossary_term' = 'Package Size');
ALTER TABLE `retail_ecm`.`fulfillment`.`pack_task` ALTER COLUMN `package_type` SET TAGS ('dbx_business_glossary_term' = 'Package Type');
ALTER TABLE `retail_ecm`.`fulfillment`.`pack_task` ALTER COLUMN `package_type` SET TAGS ('dbx_value_regex' = 'box|poly_mailer|padded_envelope|tube|pallet|tote');
ALTER TABLE `retail_ecm`.`fulfillment`.`pack_task` ALTER COLUMN `package_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Package Weight (Kilograms)');
ALTER TABLE `retail_ecm`.`fulfillment`.`pack_task` ALTER COLUMN `package_width_cm` SET TAGS ('dbx_business_glossary_term' = 'Package Width (Centimeters)');
ALTER TABLE `retail_ecm`.`fulfillment`.`pack_task` ALTER COLUMN `packing_slip_printed_flag` SET TAGS ('dbx_business_glossary_term' = 'Packing Slip Printed Flag');
ALTER TABLE `retail_ecm`.`fulfillment`.`pack_task` ALTER COLUMN `packing_station_code` SET TAGS ('dbx_business_glossary_term' = 'Packing Station ID');
ALTER TABLE `retail_ecm`.`fulfillment`.`pack_task` ALTER COLUMN `packing_station_code` SET TAGS ('dbx_value_regex' = '^PS-[A-Z0-9]{3,10}$');
ALTER TABLE `retail_ecm`.`fulfillment`.`pack_task` ALTER COLUMN `quality_check_performed_by` SET TAGS ('dbx_business_glossary_term' = 'Quality Check Performed By');
ALTER TABLE `retail_ecm`.`fulfillment`.`pack_task` ALTER COLUMN `quality_check_status` SET TAGS ('dbx_business_glossary_term' = 'Quality Check Status');
ALTER TABLE `retail_ecm`.`fulfillment`.`pack_task` ALTER COLUMN `quality_check_status` SET TAGS ('dbx_value_regex' = 'passed|failed|pending|not_required|exception');
ALTER TABLE `retail_ecm`.`fulfillment`.`pack_task` ALTER COLUMN `shipping_label_applied_flag` SET TAGS ('dbx_business_glossary_term' = 'Shipping Label Applied Flag');
ALTER TABLE `retail_ecm`.`fulfillment`.`pack_task` ALTER COLUMN `signature_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Signature Required Flag');
ALTER TABLE `retail_ecm`.`fulfillment`.`pack_task` ALTER COLUMN `task_number` SET TAGS ('dbx_business_glossary_term' = 'Pack Task Number');
ALTER TABLE `retail_ecm`.`fulfillment`.`pack_task` ALTER COLUMN `task_number` SET TAGS ('dbx_value_regex' = '^PKT-[0-9]{8,12}$');
ALTER TABLE `retail_ecm`.`fulfillment`.`pack_task` ALTER COLUMN `task_priority` SET TAGS ('dbx_business_glossary_term' = 'Pack Task Priority');
ALTER TABLE `retail_ecm`.`fulfillment`.`pack_task` ALTER COLUMN `task_priority` SET TAGS ('dbx_value_regex' = 'urgent|high|normal|low');
ALTER TABLE `retail_ecm`.`fulfillment`.`pack_task` ALTER COLUMN `task_status` SET TAGS ('dbx_business_glossary_term' = 'Pack Task Status');
ALTER TABLE `retail_ecm`.`fulfillment`.`pack_task` ALTER COLUMN `task_status` SET TAGS ('dbx_value_regex' = 'assigned|in_progress|completed|quality_hold|exception|cancelled');
ALTER TABLE `retail_ecm`.`fulfillment`.`pack_task` ALTER COLUMN `tracking_number` SET TAGS ('dbx_business_glossary_term' = 'Carrier Tracking Number');
ALTER TABLE `retail_ecm`.`fulfillment`.`pack_task` ALTER COLUMN `tracking_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{10,35}$');
ALTER TABLE `retail_ecm`.`fulfillment`.`pack_task` ALTER COLUMN `units_packed_count` SET TAGS ('dbx_business_glossary_term' = 'Units Packed Count');
ALTER TABLE `retail_ecm`.`fulfillment`.`pack_task` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `retail_ecm`.`fulfillment`.`pack_task` ALTER COLUMN `void_fill_type` SET TAGS ('dbx_business_glossary_term' = 'Void Fill Type');
ALTER TABLE `retail_ecm`.`fulfillment`.`pack_task` ALTER COLUMN `void_fill_type` SET TAGS ('dbx_value_regex' = 'air_pillows|bubble_wrap|paper|foam_peanuts|none');
ALTER TABLE `retail_ecm`.`fulfillment`.`carrier` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `retail_ecm`.`fulfillment`.`carrier` SET TAGS ('dbx_subdomain' = 'carrier_shipping');
ALTER TABLE `retail_ecm`.`fulfillment`.`carrier` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Identifier');
ALTER TABLE `retail_ecm`.`fulfillment`.`carrier` ALTER COLUMN `api_integration_flag` SET TAGS ('dbx_business_glossary_term' = 'Application Programming Interface (API) Integration Flag');
ALTER TABLE `retail_ecm`.`fulfillment`.`carrier` ALTER COLUMN `base_rate_per_lb` SET TAGS ('dbx_business_glossary_term' = 'Base Rate Per Pound');
ALTER TABLE `retail_ecm`.`fulfillment`.`carrier` ALTER COLUMN `base_rate_per_lb` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `retail_ecm`.`fulfillment`.`carrier` ALTER COLUMN `bopis_ready_flag` SET TAGS ('dbx_business_glossary_term' = 'Buy Online Pick Up In Store (BOPIS) Ready Flag');
ALTER TABLE `retail_ecm`.`fulfillment`.`carrier` ALTER COLUMN `carrier_code` SET TAGS ('dbx_business_glossary_term' = 'Carrier Code');
ALTER TABLE `retail_ecm`.`fulfillment`.`carrier` ALTER COLUMN `carrier_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `retail_ecm`.`fulfillment`.`carrier` ALTER COLUMN `carrier_name` SET TAGS ('dbx_business_glossary_term' = 'Carrier Legal Name');
ALTER TABLE `retail_ecm`.`fulfillment`.`carrier` ALTER COLUMN `carrier_status` SET TAGS ('dbx_business_glossary_term' = 'Carrier Status');
ALTER TABLE `retail_ecm`.`fulfillment`.`carrier` ALTER COLUMN `carrier_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|pending_approval');
ALTER TABLE `retail_ecm`.`fulfillment`.`carrier` ALTER COLUMN `carrier_type` SET TAGS ('dbx_business_glossary_term' = 'Carrier Type');
ALTER TABLE `retail_ecm`.`fulfillment`.`carrier` ALTER COLUMN `carrier_type` SET TAGS ('dbx_value_regex' = 'parcel|ltl|ftl|last_mile|same_day|3pl');
ALTER TABLE `retail_ecm`.`fulfillment`.`carrier` ALTER COLUMN `contact_email` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Email Address');
ALTER TABLE `retail_ecm`.`fulfillment`.`carrier` ALTER COLUMN `contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `retail_ecm`.`fulfillment`.`carrier` ALTER COLUMN `contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `retail_ecm`.`fulfillment`.`carrier` ALTER COLUMN `contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `retail_ecm`.`fulfillment`.`carrier` ALTER COLUMN `contact_name` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Name');
ALTER TABLE `retail_ecm`.`fulfillment`.`carrier` ALTER COLUMN `contact_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `retail_ecm`.`fulfillment`.`carrier` ALTER COLUMN `contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Phone Number');
ALTER TABLE `retail_ecm`.`fulfillment`.`carrier` ALTER COLUMN `contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `retail_ecm`.`fulfillment`.`carrier` ALTER COLUMN `contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `retail_ecm`.`fulfillment`.`carrier` ALTER COLUMN `contract_end_date` SET TAGS ('dbx_business_glossary_term' = 'Contract End Date');
ALTER TABLE `retail_ecm`.`fulfillment`.`carrier` ALTER COLUMN `contract_start_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Start Date');
ALTER TABLE `retail_ecm`.`fulfillment`.`carrier` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `retail_ecm`.`fulfillment`.`carrier` ALTER COLUMN `cutoff_time_local` SET TAGS ('dbx_business_glossary_term' = 'Cutoff Time Local');
ALTER TABLE `retail_ecm`.`fulfillment`.`carrier` ALTER COLUMN `cutoff_time_local` SET TAGS ('dbx_value_regex' = '^([01]?[0-9]|2[0-3]):[0-5][0-9]$');
ALTER TABLE `retail_ecm`.`fulfillment`.`carrier` ALTER COLUMN `dimensional_weight_factor` SET TAGS ('dbx_business_glossary_term' = 'Dimensional Weight Factor');
ALTER TABLE `retail_ecm`.`fulfillment`.`carrier` ALTER COLUMN `edi_capable_flag` SET TAGS ('dbx_business_glossary_term' = 'Electronic Data Interchange (EDI) Capable Flag');
ALTER TABLE `retail_ecm`.`fulfillment`.`carrier` ALTER COLUMN `extended_area_surcharge` SET TAGS ('dbx_business_glossary_term' = 'Extended Area Surcharge');
ALTER TABLE `retail_ecm`.`fulfillment`.`carrier` ALTER COLUMN `extended_area_surcharge` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `retail_ecm`.`fulfillment`.`carrier` ALTER COLUMN `fuel_surcharge_percentage` SET TAGS ('dbx_business_glossary_term' = 'Fuel Surcharge Percentage');
ALTER TABLE `retail_ecm`.`fulfillment`.`carrier` ALTER COLUMN `fuel_surcharge_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `retail_ecm`.`fulfillment`.`carrier` ALTER COLUMN `geographic_coverage` SET TAGS ('dbx_business_glossary_term' = 'Geographic Coverage');
ALTER TABLE `retail_ecm`.`fulfillment`.`carrier` ALTER COLUMN `hazmat_certified_flag` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Materials (HAZMAT) Certified Flag');
ALTER TABLE `retail_ecm`.`fulfillment`.`carrier` ALTER COLUMN `insurance_coverage_flag` SET TAGS ('dbx_business_glossary_term' = 'Insurance Coverage Available Flag');
ALTER TABLE `retail_ecm`.`fulfillment`.`carrier` ALTER COLUMN `max_height_inches` SET TAGS ('dbx_business_glossary_term' = 'Maximum Height in Inches');
ALTER TABLE `retail_ecm`.`fulfillment`.`carrier` ALTER COLUMN `max_length_inches` SET TAGS ('dbx_business_glossary_term' = 'Maximum Length in Inches');
ALTER TABLE `retail_ecm`.`fulfillment`.`carrier` ALTER COLUMN `max_weight_lbs` SET TAGS ('dbx_business_glossary_term' = 'Maximum Weight in Pounds (lbs)');
ALTER TABLE `retail_ecm`.`fulfillment`.`carrier` ALTER COLUMN `max_width_inches` SET TAGS ('dbx_business_glossary_term' = 'Maximum Width in Inches');
ALTER TABLE `retail_ecm`.`fulfillment`.`carrier` ALTER COLUMN `negotiated_discount_percentage` SET TAGS ('dbx_business_glossary_term' = 'Negotiated Discount Percentage');
ALTER TABLE `retail_ecm`.`fulfillment`.`carrier` ALTER COLUMN `negotiated_discount_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `retail_ecm`.`fulfillment`.`carrier` ALTER COLUMN `rate_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Rate Effective Date');
ALTER TABLE `retail_ecm`.`fulfillment`.`carrier` ALTER COLUMN `rate_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Rate Expiry Date');
ALTER TABLE `retail_ecm`.`fulfillment`.`carrier` ALTER COLUMN `residential_delivery_surcharge` SET TAGS ('dbx_business_glossary_term' = 'Residential Delivery Surcharge');
ALTER TABLE `retail_ecm`.`fulfillment`.`carrier` ALTER COLUMN `residential_delivery_surcharge` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `retail_ecm`.`fulfillment`.`carrier` ALTER COLUMN `scac_code` SET TAGS ('dbx_business_glossary_term' = 'Standard Carrier Alpha Code (SCAC)');
ALTER TABLE `retail_ecm`.`fulfillment`.`carrier` ALTER COLUMN `scac_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,4}$');
ALTER TABLE `retail_ecm`.`fulfillment`.`carrier` ALTER COLUMN `service_level_ground` SET TAGS ('dbx_business_glossary_term' = 'Ground Service Level Available');
ALTER TABLE `retail_ecm`.`fulfillment`.`carrier` ALTER COLUMN `service_level_overnight` SET TAGS ('dbx_business_glossary_term' = 'Overnight Service Level Available');
ALTER TABLE `retail_ecm`.`fulfillment`.`carrier` ALTER COLUMN `service_level_same_day` SET TAGS ('dbx_business_glossary_term' = 'Same-Day Service Level Available');
ALTER TABLE `retail_ecm`.`fulfillment`.`carrier` ALTER COLUMN `service_level_two_day` SET TAGS ('dbx_business_glossary_term' = 'Two-Day Service Level Available');
ALTER TABLE `retail_ecm`.`fulfillment`.`carrier` ALTER COLUMN `signature_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Signature Required Flag');
ALTER TABLE `retail_ecm`.`fulfillment`.`carrier` ALTER COLUMN `tracking_capability_flag` SET TAGS ('dbx_business_glossary_term' = 'Tracking Capability Flag');
ALTER TABLE `retail_ecm`.`fulfillment`.`carrier` ALTER COLUMN `transit_days_zone_1` SET TAGS ('dbx_business_glossary_term' = 'Transit Days for Zone 1');
ALTER TABLE `retail_ecm`.`fulfillment`.`carrier` ALTER COLUMN `transit_days_zone_2` SET TAGS ('dbx_business_glossary_term' = 'Transit Days for Zone 2');
ALTER TABLE `retail_ecm`.`fulfillment`.`carrier` ALTER COLUMN `transit_days_zone_3` SET TAGS ('dbx_business_glossary_term' = 'Transit Days for Zone 3');
ALTER TABLE `retail_ecm`.`fulfillment`.`carrier` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `retail_ecm`.`fulfillment`.`carrier_service` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `retail_ecm`.`fulfillment`.`carrier_service` SET TAGS ('dbx_subdomain' = 'carrier_shipping');
ALTER TABLE `retail_ecm`.`fulfillment`.`carrier_service` ALTER COLUMN `carrier_service_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Service ID');
ALTER TABLE `retail_ecm`.`fulfillment`.`carrier_service` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier ID');
ALTER TABLE `retail_ecm`.`fulfillment`.`carrier_service` ALTER COLUMN `base_rate` SET TAGS ('dbx_business_glossary_term' = 'Base Rate');
ALTER TABLE `retail_ecm`.`fulfillment`.`carrier_service` ALTER COLUMN `base_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `retail_ecm`.`fulfillment`.`carrier_service` ALTER COLUMN `bopis_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Buy Online Pick Up In Store (BOPIS) Eligible Flag');
ALTER TABLE `retail_ecm`.`fulfillment`.`carrier_service` ALTER COLUMN `carbon_neutral_flag` SET TAGS ('dbx_business_glossary_term' = 'Carbon Neutral Flag');
ALTER TABLE `retail_ecm`.`fulfillment`.`carrier_service` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `retail_ecm`.`fulfillment`.`carrier_service` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `retail_ecm`.`fulfillment`.`carrier_service` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `retail_ecm`.`fulfillment`.`carrier_service` ALTER COLUMN `cutoff_time` SET TAGS ('dbx_business_glossary_term' = 'Cutoff Time');
ALTER TABLE `retail_ecm`.`fulfillment`.`carrier_service` ALTER COLUMN `cutoff_timezone` SET TAGS ('dbx_business_glossary_term' = 'Cutoff Timezone');
ALTER TABLE `retail_ecm`.`fulfillment`.`carrier_service` ALTER COLUMN `cutoff_timezone` SET TAGS ('dbx_value_regex' = '^[A-Z]{3,5}$');
ALTER TABLE `retail_ecm`.`fulfillment`.`carrier_service` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `retail_ecm`.`fulfillment`.`carrier_service` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `retail_ecm`.`fulfillment`.`carrier_service` ALTER COLUMN `geographic_restriction_type` SET TAGS ('dbx_business_glossary_term' = 'Geographic Restriction Type');
ALTER TABLE `retail_ecm`.`fulfillment`.`carrier_service` ALTER COLUMN `geographic_restriction_type` SET TAGS ('dbx_value_regex' = 'none|domestic_only|regional|postal_code_list|country_list');
ALTER TABLE `retail_ecm`.`fulfillment`.`carrier_service` ALTER COLUMN `hazmat_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Materials (HAZMAT) Eligible Flag');
ALTER TABLE `retail_ecm`.`fulfillment`.`carrier_service` ALTER COLUMN `holiday_delivery_flag` SET TAGS ('dbx_business_glossary_term' = 'Holiday Delivery Flag');
ALTER TABLE `retail_ecm`.`fulfillment`.`carrier_service` ALTER COLUMN `insurance_included_flag` SET TAGS ('dbx_business_glossary_term' = 'Insurance Included Flag');
ALTER TABLE `retail_ecm`.`fulfillment`.`carrier_service` ALTER COLUMN `insurance_max_value` SET TAGS ('dbx_business_glossary_term' = 'Insurance Maximum Value');
ALTER TABLE `retail_ecm`.`fulfillment`.`carrier_service` ALTER COLUMN `international_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'International Shipping Eligible Flag');
ALTER TABLE `retail_ecm`.`fulfillment`.`carrier_service` ALTER COLUMN `max_girth_cm` SET TAGS ('dbx_business_glossary_term' = 'Maximum Girth (Centimeters)');
ALTER TABLE `retail_ecm`.`fulfillment`.`carrier_service` ALTER COLUMN `max_height_cm` SET TAGS ('dbx_business_glossary_term' = 'Maximum Height (Centimeters)');
ALTER TABLE `retail_ecm`.`fulfillment`.`carrier_service` ALTER COLUMN `max_length_cm` SET TAGS ('dbx_business_glossary_term' = 'Maximum Length (Centimeters)');
ALTER TABLE `retail_ecm`.`fulfillment`.`carrier_service` ALTER COLUMN `max_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Maximum Weight (Kilograms)');
ALTER TABLE `retail_ecm`.`fulfillment`.`carrier_service` ALTER COLUMN `max_width_cm` SET TAGS ('dbx_business_glossary_term' = 'Maximum Width (Centimeters)');
ALTER TABLE `retail_ecm`.`fulfillment`.`carrier_service` ALTER COLUMN `perishable_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Perishable Goods Eligible Flag');
ALTER TABLE `retail_ecm`.`fulfillment`.`carrier_service` ALTER COLUMN `restricted_countries` SET TAGS ('dbx_business_glossary_term' = 'Restricted Countries');
ALTER TABLE `retail_ecm`.`fulfillment`.`carrier_service` ALTER COLUMN `restricted_postal_codes` SET TAGS ('dbx_business_glossary_term' = 'Restricted Postal Codes');
ALTER TABLE `retail_ecm`.`fulfillment`.`carrier_service` ALTER COLUMN `saturday_delivery_flag` SET TAGS ('dbx_business_glossary_term' = 'Saturday Delivery Flag');
ALTER TABLE `retail_ecm`.`fulfillment`.`carrier_service` ALTER COLUMN `service_code` SET TAGS ('dbx_business_glossary_term' = 'Service Code');
ALTER TABLE `retail_ecm`.`fulfillment`.`carrier_service` ALTER COLUMN `service_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{2,20}$');
ALTER TABLE `retail_ecm`.`fulfillment`.`carrier_service` ALTER COLUMN `service_name` SET TAGS ('dbx_business_glossary_term' = 'Service Name');
ALTER TABLE `retail_ecm`.`fulfillment`.`carrier_service` ALTER COLUMN `service_status` SET TAGS ('dbx_business_glossary_term' = 'Service Status');
ALTER TABLE `retail_ecm`.`fulfillment`.`carrier_service` ALTER COLUMN `service_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|seasonal|deprecated');
ALTER TABLE `retail_ecm`.`fulfillment`.`carrier_service` ALTER COLUMN `service_type` SET TAGS ('dbx_business_glossary_term' = 'Service Type');
ALTER TABLE `retail_ecm`.`fulfillment`.`carrier_service` ALTER COLUMN `service_type` SET TAGS ('dbx_value_regex' = 'ground|express|overnight|same_day|next_day|standard');
ALTER TABLE `retail_ecm`.`fulfillment`.`carrier_service` ALTER COLUMN `ship_from_store_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Ship From Store (SFS) Eligible Flag');
ALTER TABLE `retail_ecm`.`fulfillment`.`carrier_service` ALTER COLUMN `signature_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Signature Required Flag');
ALTER TABLE `retail_ecm`.`fulfillment`.`carrier_service` ALTER COLUMN `sla_delivery_guarantee_flag` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Delivery Guarantee Flag');
ALTER TABLE `retail_ecm`.`fulfillment`.`carrier_service` ALTER COLUMN `sunday_delivery_flag` SET TAGS ('dbx_business_glossary_term' = 'Sunday Delivery Flag');
ALTER TABLE `retail_ecm`.`fulfillment`.`carrier_service` ALTER COLUMN `surcharge_types` SET TAGS ('dbx_business_glossary_term' = 'Surcharge Types');
ALTER TABLE `retail_ecm`.`fulfillment`.`carrier_service` ALTER COLUMN `tracking_capability_flag` SET TAGS ('dbx_business_glossary_term' = 'Tracking Capability Flag');
ALTER TABLE `retail_ecm`.`fulfillment`.`carrier_service` ALTER COLUMN `transit_days_max` SET TAGS ('dbx_business_glossary_term' = 'Maximum Transit Days');
ALTER TABLE `retail_ecm`.`fulfillment`.`carrier_service` ALTER COLUMN `transit_days_min` SET TAGS ('dbx_business_glossary_term' = 'Minimum Transit Days');
ALTER TABLE `retail_ecm`.`fulfillment`.`carrier_service` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `retail_ecm`.`fulfillment`.`fulfillment_node` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `retail_ecm`.`fulfillment`.`fulfillment_node` SET TAGS ('dbx_subdomain' = 'carrier_shipping');
ALTER TABLE `retail_ecm`.`fulfillment`.`fulfillment_node` ALTER COLUMN `fulfillment_node_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Key for node');
ALTER TABLE `retail_ecm`.`fulfillment`.`fulfillment_node` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`fulfillment`.`fulfillment_node` ALTER COLUMN `cost_zone_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Zone Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`fulfillment`.`fulfillment_node` ALTER COLUMN `dc_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Dc Facility Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`fulfillment`.`fulfillment_node` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Location Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`fulfillment`.`fulfillment_node` ALTER COLUMN `price_zone_id` SET TAGS ('dbx_business_glossary_term' = 'Price Zone Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`fulfillment`.`fulfillment_node` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`fulfillment`.`fulfillment_node` ALTER COLUMN `activation_date` SET TAGS ('dbx_business_glossary_term' = 'Activation Date');
ALTER TABLE `retail_ecm`.`fulfillment`.`fulfillment_node` ALTER COLUMN `address_line_1` SET TAGS ('dbx_business_glossary_term' = 'Address Line 1');
ALTER TABLE `retail_ecm`.`fulfillment`.`fulfillment_node` ALTER COLUMN `address_line_1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `retail_ecm`.`fulfillment`.`fulfillment_node` ALTER COLUMN `address_line_1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `retail_ecm`.`fulfillment`.`fulfillment_node` ALTER COLUMN `address_line_2` SET TAGS ('dbx_business_glossary_term' = 'Address Line 2');
ALTER TABLE `retail_ecm`.`fulfillment`.`fulfillment_node` ALTER COLUMN `address_line_2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `retail_ecm`.`fulfillment`.`fulfillment_node` ALTER COLUMN `address_line_2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `retail_ecm`.`fulfillment`.`fulfillment_node` ALTER COLUMN `automation_level` SET TAGS ('dbx_business_glossary_term' = 'Automation Level');
ALTER TABLE `retail_ecm`.`fulfillment`.`fulfillment_node` ALTER COLUMN `automation_level` SET TAGS ('dbx_value_regex' = 'manual|semi_automated|fully_automated');
ALTER TABLE `retail_ecm`.`fulfillment`.`fulfillment_node` ALTER COLUMN `bopis_enabled` SET TAGS ('dbx_business_glossary_term' = 'Buy Online Pick Up In Store (BOPIS) Enabled');
ALTER TABLE `retail_ecm`.`fulfillment`.`fulfillment_node` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `retail_ecm`.`fulfillment`.`fulfillment_node` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `retail_ecm`.`fulfillment`.`fulfillment_node` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `retail_ecm`.`fulfillment`.`fulfillment_node` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `retail_ecm`.`fulfillment`.`fulfillment_node` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `retail_ecm`.`fulfillment`.`fulfillment_node` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `retail_ecm`.`fulfillment`.`fulfillment_node` ALTER COLUMN `curbside_pickup_enabled` SET TAGS ('dbx_business_glossary_term' = 'Curbside Pickup Enabled');
ALTER TABLE `retail_ecm`.`fulfillment`.`fulfillment_node` ALTER COLUMN `deactivation_date` SET TAGS ('dbx_business_glossary_term' = 'Deactivation Date');
ALTER TABLE `retail_ecm`.`fulfillment`.`fulfillment_node` ALTER COLUMN `delivery_zone_coverage_radius_miles` SET TAGS ('dbx_business_glossary_term' = 'Delivery Zone Coverage Radius Miles');
ALTER TABLE `retail_ecm`.`fulfillment`.`fulfillment_node` ALTER COLUMN `dock_door_count` SET TAGS ('dbx_business_glossary_term' = 'Dock Door Count');
ALTER TABLE `retail_ecm`.`fulfillment`.`fulfillment_node` ALTER COLUMN `email_address` SET TAGS ('dbx_business_glossary_term' = 'Email Address');
ALTER TABLE `retail_ecm`.`fulfillment`.`fulfillment_node` ALTER COLUMN `email_address` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `retail_ecm`.`fulfillment`.`fulfillment_node` ALTER COLUMN `email_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `retail_ecm`.`fulfillment`.`fulfillment_node` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `retail_ecm`.`fulfillment`.`fulfillment_node` ALTER COLUMN `hazmat_certified` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Materials (HAZMAT) Certified');
ALTER TABLE `retail_ecm`.`fulfillment`.`fulfillment_node` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `retail_ecm`.`fulfillment`.`fulfillment_node` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude');
ALTER TABLE `retail_ecm`.`fulfillment`.`fulfillment_node` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `retail_ecm`.`fulfillment`.`fulfillment_node` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `retail_ecm`.`fulfillment`.`fulfillment_node` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude');
ALTER TABLE `retail_ecm`.`fulfillment`.`fulfillment_node` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `retail_ecm`.`fulfillment`.`fulfillment_node` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `retail_ecm`.`fulfillment`.`fulfillment_node` ALTER COLUMN `manager_name` SET TAGS ('dbx_business_glossary_term' = 'Manager Name');
ALTER TABLE `retail_ecm`.`fulfillment`.`fulfillment_node` ALTER COLUMN `next_day_delivery_enabled` SET TAGS ('dbx_business_glossary_term' = 'Next Day Delivery Enabled');
ALTER TABLE `retail_ecm`.`fulfillment`.`fulfillment_node` ALTER COLUMN `node_code` SET TAGS ('dbx_business_glossary_term' = 'Node Code');
ALTER TABLE `retail_ecm`.`fulfillment`.`fulfillment_node` ALTER COLUMN `node_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,12}$');
ALTER TABLE `retail_ecm`.`fulfillment`.`fulfillment_node` ALTER COLUMN `node_name` SET TAGS ('dbx_business_glossary_term' = 'Node Name');
ALTER TABLE `retail_ecm`.`fulfillment`.`fulfillment_node` ALTER COLUMN `node_status` SET TAGS ('dbx_business_glossary_term' = 'Node Status');
ALTER TABLE `retail_ecm`.`fulfillment`.`fulfillment_node` ALTER COLUMN `node_status` SET TAGS ('dbx_value_regex' = 'active|inactive|planned|under_construction|temporarily_closed|decommissioned');
ALTER TABLE `retail_ecm`.`fulfillment`.`fulfillment_node` ALTER COLUMN `node_type` SET TAGS ('dbx_business_glossary_term' = 'Node Type');
ALTER TABLE `retail_ecm`.`fulfillment`.`fulfillment_node` ALTER COLUMN `node_type` SET TAGS ('dbx_value_regex' = 'distribution_center|store|dark_store|micro_fulfillment_center|cross_dock|returns_center');
ALTER TABLE `retail_ecm`.`fulfillment`.`fulfillment_node` ALTER COLUMN `operating_hours_weekday` SET TAGS ('dbx_business_glossary_term' = 'Operating Hours Weekday');
ALTER TABLE `retail_ecm`.`fulfillment`.`fulfillment_node` ALTER COLUMN `operating_hours_weekend` SET TAGS ('dbx_business_glossary_term' = 'Operating Hours Weekend');
ALTER TABLE `retail_ecm`.`fulfillment`.`fulfillment_node` ALTER COLUMN `pack_station_count` SET TAGS ('dbx_business_glossary_term' = 'Pack Station Count');
ALTER TABLE `retail_ecm`.`fulfillment`.`fulfillment_node` ALTER COLUMN `phone_number` SET TAGS ('dbx_business_glossary_term' = 'Phone Number');
ALTER TABLE `retail_ecm`.`fulfillment`.`fulfillment_node` ALTER COLUMN `phone_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `retail_ecm`.`fulfillment`.`fulfillment_node` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `retail_ecm`.`fulfillment`.`fulfillment_node` ALTER COLUMN `pick_capacity_orders_per_hour` SET TAGS ('dbx_business_glossary_term' = 'Pick Capacity Orders Per Hour');
ALTER TABLE `retail_ecm`.`fulfillment`.`fulfillment_node` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `retail_ecm`.`fulfillment`.`fulfillment_node` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `retail_ecm`.`fulfillment`.`fulfillment_node` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `retail_ecm`.`fulfillment`.`fulfillment_node` ALTER COLUMN `primary_carrier_code` SET TAGS ('dbx_business_glossary_term' = 'Primary Carrier Code');
ALTER TABLE `retail_ecm`.`fulfillment`.`fulfillment_node` ALTER COLUMN `refrigerated_storage_enabled` SET TAGS ('dbx_business_glossary_term' = 'Refrigerated Storage Enabled');
ALTER TABLE `retail_ecm`.`fulfillment`.`fulfillment_node` ALTER COLUMN `ropis_enabled` SET TAGS ('dbx_business_glossary_term' = 'Reserve Online Pick Up In Store (ROPIS) Enabled');
ALTER TABLE `retail_ecm`.`fulfillment`.`fulfillment_node` ALTER COLUMN `same_day_delivery_enabled` SET TAGS ('dbx_business_glossary_term' = 'Same Day Delivery Enabled');
ALTER TABLE `retail_ecm`.`fulfillment`.`fulfillment_node` ALTER COLUMN `ship_from_store_enabled` SET TAGS ('dbx_business_glossary_term' = 'Ship From Store (SFS) Enabled');
ALTER TABLE `retail_ecm`.`fulfillment`.`fulfillment_node` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'State or Province');
ALTER TABLE `retail_ecm`.`fulfillment`.`fulfillment_node` ALTER COLUMN `state_province` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `retail_ecm`.`fulfillment`.`fulfillment_node` ALTER COLUMN `state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `retail_ecm`.`fulfillment`.`fulfillment_node` ALTER COLUMN `state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `retail_ecm`.`fulfillment`.`fulfillment_node` ALTER COLUMN `storage_capacity_square_feet` SET TAGS ('dbx_business_glossary_term' = 'Storage Capacity Square Feet');
ALTER TABLE `retail_ecm`.`fulfillment`.`fulfillment_node` ALTER COLUMN `storage_zone_count` SET TAGS ('dbx_business_glossary_term' = 'Storage Zone Count');
ALTER TABLE `retail_ecm`.`fulfillment`.`fulfillment_node` ALTER COLUMN `time_zone` SET TAGS ('dbx_business_glossary_term' = 'Time Zone');
ALTER TABLE `retail_ecm`.`fulfillment`.`fulfillment_node` ALTER COLUMN `wms_system_code` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Management System (WMS) System ID');
ALTER TABLE `retail_ecm`.`fulfillment`.`exception` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `retail_ecm`.`fulfillment`.`exception` SET TAGS ('dbx_subdomain' = 'order_execution');
ALTER TABLE `retail_ecm`.`fulfillment`.`exception` ALTER COLUMN `exception_id` SET TAGS ('dbx_business_glossary_term' = 'Exception Identifier');
ALTER TABLE `retail_ecm`.`fulfillment`.`exception` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier ID');
ALTER TABLE `retail_ecm`.`fulfillment`.`exception` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`fulfillment`.`exception` ALTER COLUMN `department_id` SET TAGS ('dbx_business_glossary_term' = 'Department Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`fulfillment`.`exception` ALTER COLUMN `fulfillment_line_id` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Order Line ID');
ALTER TABLE `retail_ecm`.`fulfillment`.`exception` ALTER COLUMN `fulfillment_node_id` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Node ID');
ALTER TABLE `retail_ecm`.`fulfillment`.`exception` ALTER COLUMN `fulfillment_order_id` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Order ID');
ALTER TABLE `retail_ecm`.`fulfillment`.`exception` ALTER COLUMN `journal_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Journal Entry Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`fulfillment`.`exception` ALTER COLUMN `loyalty_membership_id` SET TAGS ('dbx_business_glossary_term' = 'Membership Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`fulfillment`.`exception` ALTER COLUMN `pack_task_id` SET TAGS ('dbx_business_glossary_term' = 'Pack Task Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`fulfillment`.`exception` ALTER COLUMN `pick_task_id` SET TAGS ('dbx_business_glossary_term' = 'Pick Task Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`fulfillment`.`exception` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Profile Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`fulfillment`.`exception` ALTER COLUMN `rma_id` SET TAGS ('dbx_business_glossary_term' = 'Rma Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`fulfillment`.`exception` ALTER COLUMN `service_case_id` SET TAGS ('dbx_business_glossary_term' = 'Service Case Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`fulfillment`.`exception` ALTER COLUMN `shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`fulfillment`.`exception` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`fulfillment`.`exception` ALTER COLUMN `sla_id` SET TAGS ('dbx_business_glossary_term' = 'Sla Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`fulfillment`.`exception` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`fulfillment`.`exception` ALTER COLUMN `warehouse_task_id` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Task Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`fulfillment`.`exception` ALTER COLUMN `corrective_action_plan` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Plan');
ALTER TABLE `retail_ecm`.`fulfillment`.`exception` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `retail_ecm`.`fulfillment`.`exception` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `retail_ecm`.`fulfillment`.`exception` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `retail_ecm`.`fulfillment`.`exception` ALTER COLUMN `customer_notification_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Customer Notification Timestamp');
ALTER TABLE `retail_ecm`.`fulfillment`.`exception` ALTER COLUMN `customer_notified_flag` SET TAGS ('dbx_business_glossary_term' = 'Customer Notified Flag');
ALTER TABLE `retail_ecm`.`fulfillment`.`exception` ALTER COLUMN `detected_at_stage` SET TAGS ('dbx_business_glossary_term' = 'Detected At Stage');
ALTER TABLE `retail_ecm`.`fulfillment`.`exception` ALTER COLUMN `escalation_level` SET TAGS ('dbx_business_glossary_term' = 'Escalation Level');
ALTER TABLE `retail_ecm`.`fulfillment`.`exception` ALTER COLUMN `exception_code` SET TAGS ('dbx_business_glossary_term' = 'Exception Code');
ALTER TABLE `retail_ecm`.`fulfillment`.`exception` ALTER COLUMN `exception_description` SET TAGS ('dbx_business_glossary_term' = 'Exception Description');
ALTER TABLE `retail_ecm`.`fulfillment`.`exception` ALTER COLUMN `exception_number` SET TAGS ('dbx_business_glossary_term' = 'Exception Number');
ALTER TABLE `retail_ecm`.`fulfillment`.`exception` ALTER COLUMN `exception_status` SET TAGS ('dbx_business_glossary_term' = 'Exception Status');
ALTER TABLE `retail_ecm`.`fulfillment`.`exception` ALTER COLUMN `exception_status` SET TAGS ('dbx_value_regex' = 'open|in_progress|resolved|escalated|cancelled');
ALTER TABLE `retail_ecm`.`fulfillment`.`exception` ALTER COLUMN `exception_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Exception Timestamp');
ALTER TABLE `retail_ecm`.`fulfillment`.`exception` ALTER COLUMN `exception_type` SET TAGS ('dbx_business_glossary_term' = 'Exception Type');
ALTER TABLE `retail_ecm`.`fulfillment`.`exception` ALTER COLUMN `financial_impact_amount` SET TAGS ('dbx_business_glossary_term' = 'Financial Impact Amount');
ALTER TABLE `retail_ecm`.`fulfillment`.`exception` ALTER COLUMN `financial_impact_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `retail_ecm`.`fulfillment`.`exception` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `retail_ecm`.`fulfillment`.`exception` ALTER COLUMN `owner_type` SET TAGS ('dbx_business_glossary_term' = 'Exception Owner Type');
ALTER TABLE `retail_ecm`.`fulfillment`.`exception` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Priority');
ALTER TABLE `retail_ecm`.`fulfillment`.`exception` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `retail_ecm`.`fulfillment`.`exception` ALTER COLUMN `quantity_affected` SET TAGS ('dbx_business_glossary_term' = 'Quantity Affected');
ALTER TABLE `retail_ecm`.`fulfillment`.`exception` ALTER COLUMN `resolution_action` SET TAGS ('dbx_business_glossary_term' = 'Resolution Action');
ALTER TABLE `retail_ecm`.`fulfillment`.`exception` ALTER COLUMN `resolution_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Resolution Duration Minutes');
ALTER TABLE `retail_ecm`.`fulfillment`.`exception` ALTER COLUMN `resolution_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Resolution Timestamp');
ALTER TABLE `retail_ecm`.`fulfillment`.`exception` ALTER COLUMN `root_cause_category` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Category');
ALTER TABLE `retail_ecm`.`fulfillment`.`exception` ALTER COLUMN `sla_breach_flag` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Breach Flag');
ALTER TABLE `retail_ecm`.`fulfillment`.`exception` ALTER COLUMN `tracking_number` SET TAGS ('dbx_business_glossary_term' = 'Tracking Number');
ALTER TABLE `retail_ecm`.`fulfillment`.`exception` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `retail_ecm`.`fulfillment`.`sla` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `retail_ecm`.`fulfillment`.`sla` SET TAGS ('dbx_subdomain' = 'order_execution');
ALTER TABLE `retail_ecm`.`fulfillment`.`sla` ALTER COLUMN `sla_id` SET TAGS ('dbx_business_glossary_term' = 'Sla Identifier');
ALTER TABLE `retail_ecm`.`fulfillment`.`sla` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier ID');
ALTER TABLE `retail_ecm`.`fulfillment`.`sla` ALTER COLUMN `carrier_service_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Service Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`fulfillment`.`sla` ALTER COLUMN `fulfillment_node_id` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Node ID');
ALTER TABLE `retail_ecm`.`fulfillment`.`sla` ALTER COLUMN `category_id` SET TAGS ('dbx_business_glossary_term' = 'Product Category ID');
ALTER TABLE `retail_ecm`.`fulfillment`.`sla` ALTER COLUMN `season_id` SET TAGS ('dbx_business_glossary_term' = 'Season Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`fulfillment`.`sla` ALTER COLUMN `tier_id` SET TAGS ('dbx_business_glossary_term' = 'Tier Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`fulfillment`.`sla` ALTER COLUMN `applies_to_holidays` SET TAGS ('dbx_business_glossary_term' = 'Applies to Holidays Flag');
ALTER TABLE `retail_ecm`.`fulfillment`.`sla` ALTER COLUMN `applies_to_weekdays` SET TAGS ('dbx_business_glossary_term' = 'Applies to Weekdays Flag');
ALTER TABLE `retail_ecm`.`fulfillment`.`sla` ALTER COLUMN `applies_to_weekends` SET TAGS ('dbx_business_glossary_term' = 'Applies to Weekends Flag');
ALTER TABLE `retail_ecm`.`fulfillment`.`sla` ALTER COLUMN `breach_threshold_hours` SET TAGS ('dbx_business_glossary_term' = 'Breach Threshold Hours');
ALTER TABLE `retail_ecm`.`fulfillment`.`sla` ALTER COLUMN `breach_threshold_percentage` SET TAGS ('dbx_business_glossary_term' = 'Breach Threshold Percentage');
ALTER TABLE `retail_ecm`.`fulfillment`.`sla` ALTER COLUMN `carrier_cutoff_time` SET TAGS ('dbx_business_glossary_term' = 'Carrier Cutoff Time');
ALTER TABLE `retail_ecm`.`fulfillment`.`sla` ALTER COLUMN `compliance_notes` SET TAGS ('dbx_business_glossary_term' = 'Compliance Notes');
ALTER TABLE `retail_ecm`.`fulfillment`.`sla` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `retail_ecm`.`fulfillment`.`sla` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `retail_ecm`.`fulfillment`.`sla` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `retail_ecm`.`fulfillment`.`sla` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `retail_ecm`.`fulfillment`.`sla` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `retail_ecm`.`fulfillment`.`sla` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `retail_ecm`.`fulfillment`.`sla` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `retail_ecm`.`fulfillment`.`sla` ALTER COLUMN `escalation_rule` SET TAGS ('dbx_business_glossary_term' = 'Escalation Rule');
ALTER TABLE `retail_ecm`.`fulfillment`.`sla` ALTER COLUMN `excluded_dates` SET TAGS ('dbx_business_glossary_term' = 'Excluded Dates');
ALTER TABLE `retail_ecm`.`fulfillment`.`sla` ALTER COLUMN `fulfillment_method` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Method');
ALTER TABLE `retail_ecm`.`fulfillment`.`sla` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_business_glossary_term' = 'Geographic Scope');
ALTER TABLE `retail_ecm`.`fulfillment`.`sla` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_value_regex' = 'GLOBAL|NATIONAL|REGIONAL|LOCAL');
ALTER TABLE `retail_ecm`.`fulfillment`.`sla` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active Flag');
ALTER TABLE `retail_ecm`.`fulfillment`.`sla` ALTER COLUMN `node_type` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Node Type');
ALTER TABLE `retail_ecm`.`fulfillment`.`sla` ALTER COLUMN `node_type` SET TAGS ('dbx_value_regex' = 'STORE|DC|DARK_STORE|MFC|VENDOR|3PL');
ALTER TABLE `retail_ecm`.`fulfillment`.`sla` ALTER COLUMN `order_channel` SET TAGS ('dbx_business_glossary_term' = 'Order Channel');
ALTER TABLE `retail_ecm`.`fulfillment`.`sla` ALTER COLUMN `order_channel` SET TAGS ('dbx_value_regex' = 'WEB|MOBILE_APP|IN_STORE|CALL_CENTER|MARKETPLACE|SOCIAL_COMMERCE');
ALTER TABLE `retail_ecm`.`fulfillment`.`sla` ALTER COLUMN `order_cutoff_time` SET TAGS ('dbx_business_glossary_term' = 'Order Cutoff Time');
ALTER TABLE `retail_ecm`.`fulfillment`.`sla` ALTER COLUMN `order_value_max` SET TAGS ('dbx_business_glossary_term' = 'Maximum Order Value');
ALTER TABLE `retail_ecm`.`fulfillment`.`sla` ALTER COLUMN `order_value_min` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Value');
ALTER TABLE `retail_ecm`.`fulfillment`.`sla` ALTER COLUMN `postal_code_pattern` SET TAGS ('dbx_business_glossary_term' = 'Postal Code Pattern');
ALTER TABLE `retail_ecm`.`fulfillment`.`sla` ALTER COLUMN `postal_code_pattern` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `retail_ecm`.`fulfillment`.`sla` ALTER COLUMN `postal_code_pattern` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `retail_ecm`.`fulfillment`.`sla` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `retail_ecm`.`fulfillment`.`sla` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'CRITICAL|HIGH|MEDIUM|LOW');
ALTER TABLE `retail_ecm`.`fulfillment`.`sla` ALTER COLUMN `promised_hours_to_deliver` SET TAGS ('dbx_business_glossary_term' = 'Promised Hours to Deliver');
ALTER TABLE `retail_ecm`.`fulfillment`.`sla` ALTER COLUMN `promised_hours_to_ready` SET TAGS ('dbx_business_glossary_term' = 'Promised Hours to Ready');
ALTER TABLE `retail_ecm`.`fulfillment`.`sla` ALTER COLUMN `promised_hours_to_ship` SET TAGS ('dbx_business_glossary_term' = 'Promised Hours to Ship');
ALTER TABLE `retail_ecm`.`fulfillment`.`sla` ALTER COLUMN `region_code` SET TAGS ('dbx_business_glossary_term' = 'Region Code');
ALTER TABLE `retail_ecm`.`fulfillment`.`sla` ALTER COLUMN `sla_code` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Code');
ALTER TABLE `retail_ecm`.`fulfillment`.`sla` ALTER COLUMN `sla_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{3,20}$');
ALTER TABLE `retail_ecm`.`fulfillment`.`sla` ALTER COLUMN `sla_name` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Name');
ALTER TABLE `retail_ecm`.`fulfillment`.`sla` ALTER COLUMN `sla_type` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Type');
ALTER TABLE `retail_ecm`.`fulfillment`.`sla` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Updated By User');
ALTER TABLE `retail_ecm`.`fulfillment`.`sla` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `retail_ecm`.`fulfillment`.`carrier_rate` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `retail_ecm`.`fulfillment`.`carrier_rate` SET TAGS ('dbx_subdomain' = 'carrier_shipping');
ALTER TABLE `retail_ecm`.`fulfillment`.`carrier_rate` ALTER COLUMN `carrier_rate_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Rate ID');
ALTER TABLE `retail_ecm`.`fulfillment`.`carrier_rate` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier ID');
ALTER TABLE `retail_ecm`.`fulfillment`.`carrier_rate` ALTER COLUMN `carrier_service_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier Service Id (Foreign Key)');
ALTER TABLE `retail_ecm`.`fulfillment`.`carrier_rate` ALTER COLUMN `base_rate_amount` SET TAGS ('dbx_business_glossary_term' = 'Base Rate Amount');
ALTER TABLE `retail_ecm`.`fulfillment`.`carrier_rate` ALTER COLUMN `contract_number` SET TAGS ('dbx_business_glossary_term' = 'Contract Number');
ALTER TABLE `retail_ecm`.`fulfillment`.`carrier_rate` ALTER COLUMN `contract_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `retail_ecm`.`fulfillment`.`carrier_rate` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `retail_ecm`.`fulfillment`.`carrier_rate` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `retail_ecm`.`fulfillment`.`carrier_rate` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `retail_ecm`.`fulfillment`.`carrier_rate` ALTER COLUMN `destination_country_code` SET TAGS ('dbx_business_glossary_term' = 'Destination Country Code');
ALTER TABLE `retail_ecm`.`fulfillment`.`carrier_rate` ALTER COLUMN `destination_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `retail_ecm`.`fulfillment`.`carrier_rate` ALTER COLUMN `destination_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Destination Postal Code');
ALTER TABLE `retail_ecm`.`fulfillment`.`carrier_rate` ALTER COLUMN `destination_postal_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `retail_ecm`.`fulfillment`.`carrier_rate` ALTER COLUMN `destination_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `retail_ecm`.`fulfillment`.`carrier_rate` ALTER COLUMN `dimensional_weight_factor` SET TAGS ('dbx_business_glossary_term' = 'Dimensional Weight Factor');
ALTER TABLE `retail_ecm`.`fulfillment`.`carrier_rate` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `retail_ecm`.`fulfillment`.`carrier_rate` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `retail_ecm`.`fulfillment`.`carrier_rate` ALTER COLUMN `extended_area_surcharge` SET TAGS ('dbx_business_glossary_term' = 'Extended Area Surcharge');
ALTER TABLE `retail_ecm`.`fulfillment`.`carrier_rate` ALTER COLUMN `fuel_surcharge_rate` SET TAGS ('dbx_business_glossary_term' = 'Fuel Surcharge Rate');
ALTER TABLE `retail_ecm`.`fulfillment`.`carrier_rate` ALTER COLUMN `is_hazmat_eligible` SET TAGS ('dbx_business_glossary_term' = 'Is Hazardous Materials (HAZMAT) Eligible');
ALTER TABLE `retail_ecm`.`fulfillment`.`carrier_rate` ALTER COLUMN `is_international` SET TAGS ('dbx_business_glossary_term' = 'Is International');
ALTER TABLE `retail_ecm`.`fulfillment`.`carrier_rate` ALTER COLUMN `minimum_charge_amount` SET TAGS ('dbx_business_glossary_term' = 'Minimum Charge Amount');
ALTER TABLE `retail_ecm`.`fulfillment`.`carrier_rate` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `retail_ecm`.`fulfillment`.`carrier_rate` ALTER COLUMN `negotiated_discount_percentage` SET TAGS ('dbx_business_glossary_term' = 'Negotiated Discount Percentage');
ALTER TABLE `retail_ecm`.`fulfillment`.`carrier_rate` ALTER COLUMN `negotiated_discount_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `retail_ecm`.`fulfillment`.`carrier_rate` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `retail_ecm`.`fulfillment`.`carrier_rate` ALTER COLUMN `origin_country_code` SET TAGS ('dbx_business_glossary_term' = 'Origin Country Code');
ALTER TABLE `retail_ecm`.`fulfillment`.`carrier_rate` ALTER COLUMN `origin_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `retail_ecm`.`fulfillment`.`carrier_rate` ALTER COLUMN `origin_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Origin Postal Code');
ALTER TABLE `retail_ecm`.`fulfillment`.`carrier_rate` ALTER COLUMN `origin_postal_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `retail_ecm`.`fulfillment`.`carrier_rate` ALTER COLUMN `origin_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `retail_ecm`.`fulfillment`.`carrier_rate` ALTER COLUMN `oversized_package_surcharge` SET TAGS ('dbx_business_glossary_term' = 'Oversized Package Surcharge');
ALTER TABLE `retail_ecm`.`fulfillment`.`carrier_rate` ALTER COLUMN `rate_per_kg` SET TAGS ('dbx_business_glossary_term' = 'Rate Per Kilogram');
ALTER TABLE `retail_ecm`.`fulfillment`.`carrier_rate` ALTER COLUMN `rate_source` SET TAGS ('dbx_business_glossary_term' = 'Rate Source');
ALTER TABLE `retail_ecm`.`fulfillment`.`carrier_rate` ALTER COLUMN `rate_source` SET TAGS ('dbx_value_regex' = 'carrier_api|manual_entry|contract_upload|rate_shop|third_party');
ALTER TABLE `retail_ecm`.`fulfillment`.`carrier_rate` ALTER COLUMN `rate_status` SET TAGS ('dbx_business_glossary_term' = 'Rate Status');
ALTER TABLE `retail_ecm`.`fulfillment`.`carrier_rate` ALTER COLUMN `rate_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|expired|suspended');
ALTER TABLE `retail_ecm`.`fulfillment`.`carrier_rate` ALTER COLUMN `rate_type` SET TAGS ('dbx_business_glossary_term' = 'Rate Type');
ALTER TABLE `retail_ecm`.`fulfillment`.`carrier_rate` ALTER COLUMN `rate_type` SET TAGS ('dbx_value_regex' = 'base|negotiated|published|spot|contract');
ALTER TABLE `retail_ecm`.`fulfillment`.`carrier_rate` ALTER COLUMN `rate_version` SET TAGS ('dbx_business_glossary_term' = 'Rate Version');
ALTER TABLE `retail_ecm`.`fulfillment`.`carrier_rate` ALTER COLUMN `rate_zone` SET TAGS ('dbx_business_glossary_term' = 'Rate Zone');
ALTER TABLE `retail_ecm`.`fulfillment`.`carrier_rate` ALTER COLUMN `residential_delivery_surcharge` SET TAGS ('dbx_business_glossary_term' = 'Residential Delivery Surcharge');
ALTER TABLE `retail_ecm`.`fulfillment`.`carrier_rate` ALTER COLUMN `saturday_delivery_surcharge` SET TAGS ('dbx_business_glossary_term' = 'Saturday Delivery Surcharge');
ALTER TABLE `retail_ecm`.`fulfillment`.`carrier_rate` ALTER COLUMN `service_level` SET TAGS ('dbx_business_glossary_term' = 'Service Level');
ALTER TABLE `retail_ecm`.`fulfillment`.`carrier_rate` ALTER COLUMN `signature_required_surcharge` SET TAGS ('dbx_business_glossary_term' = 'Signature Required Surcharge');
ALTER TABLE `retail_ecm`.`fulfillment`.`carrier_rate` ALTER COLUMN `transit_days` SET TAGS ('dbx_business_glossary_term' = 'Transit Days');
ALTER TABLE `retail_ecm`.`fulfillment`.`carrier_rate` ALTER COLUMN `weight_break_max_kg` SET TAGS ('dbx_business_glossary_term' = 'Weight Break Maximum (kg)');
ALTER TABLE `retail_ecm`.`fulfillment`.`carrier_rate` ALTER COLUMN `weight_break_min_kg` SET TAGS ('dbx_business_glossary_term' = 'Weight Break Minimum (kg)');
