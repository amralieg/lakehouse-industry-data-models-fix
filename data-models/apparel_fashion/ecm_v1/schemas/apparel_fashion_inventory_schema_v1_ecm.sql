-- Schema for Domain: inventory | Business: Apparel Fashion | Version: v1_ecm
-- Generated on: 2026-05-05 15:54:35

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `apparel_fashion_ecm`.`inventory` COMMENT 'Tracks real-time stock levels, ATS, ATP, WOS, and inventory movements across warehouses, DCs, retail stores, and 3PL facilities. Manages cycle counts, stock adjustments, RFID tracking, VMI programs, and NOS strategies. Ensures optimal inventory positioning for omnichannel fulfillment via Manhattan Associates WMS and SAP S/4HANA MM.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`inventory`.`stock_position` (
    `stock_position_id` BIGINT COMMENT 'Unique identifier for the stock position record. Primary key for the stock position entity.',
    `digital_storefront_id` BIGINT COMMENT 'Foreign key linking to ecommerce.digital_storefront. Business justification: Stock positions are allocated to specific digital storefronts for online selling. Business process: real-time ATP calculation per storefront, regional inventory pooling, and channel-specific stock vis',
    `inventory_pool_id` BIGINT COMMENT 'Foreign key linking to inventory.inventory_pool. Business justification: Stock positions should be assigned to inventory pools for allocation management and omnichannel fulfillment. Inventory pools represent logical groupings of stock (e.g., retail pool, wholesale pool, ec',
    `otb_budget_id` BIGINT COMMENT 'Foreign key linking to merchandising.otb_budget. Business justification: Stock positions are planned and monitored against OTB budgets by merchandise category/season. Essential for OTB compliance monitoring, variance reporting, and inventory financial planning in apparel m',
    `retail_store_id` BIGINT COMMENT 'Foreign key linking to store.retail_store. Business justification: Store-level stock positions are fundamental to retail inventory management - tracks on-hand, ATS, ATP quantities by store for BOPIS fulfillment, ship-from-store allocation, store replenishment plannin',
    `season_id` BIGINT COMMENT 'Foreign key linking to merchandising.season. Business justification: Inventory is inherently seasonal in apparel fashion. Stock positions must track seasonal merchandise for seasonal inventory planning, end-of-season clearance decisions, and sell-through analysis by se',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: Stock valuation, aging analysis, and markdown planning require product lifecycle_stage, cost_of_goods_sold, category, and sustainability attributes from product master. Current string sku field insu',
    `sustainable_material_id` BIGINT COMMENT 'Foreign key linking to sustainability.sustainable_material. Business justification: Stock positions must track material sustainability attributes (organic, recycled content, certifications) for ESG reporting, customer transparency labels, and sustainable inventory KPIs. Standard prac',
    `warehouse_location_id` BIGINT COMMENT 'Identifier for the physical location where inventory is held. References warehouse, distribution center (DC), retail store, or third-party logistics (3PL) facility.',
    `aging_bucket` STRING COMMENT 'Classification of inventory based on time in stock and seasonal relevance. Current season represents fresh merchandise, prior season is last season carryover, aged is multi-season old inventory, and clearance is marked for liquidation. Drives markdown strategies and inventory valuation.. Valid values are `current_season|prior_season|aged|clearance`',
    `allocation_group` STRING COMMENT 'Classification code used to group inventory for allocation planning. Allocation groups define how inventory is distributed across channels and locations based on demand forecasts, store grades, and strategic priorities.. Valid values are `^[A-Z0-9_]{2,20}$`',
    `atp_quantity` DECIMAL(18,2) COMMENT 'Quantity available for future customer commitments, including current ATS plus expected inbound receipts minus planned outbound allocations. Used for forward order promising and pre-order management.',
    `ats_quantity` DECIMAL(18,2) COMMENT 'Quantity available for new customer orders. Calculated as on-hand quantity minus reserved quantity minus damaged/held quantity. This is the inventory pool visible to e-commerce and point-of-sale systems for order promising.',
    `country_of_origin` STRING COMMENT 'Three-letter ISO country code indicating where the product was manufactured. Required for customs compliance, trade agreement qualification, and consumer labeling per FTC textile labeling requirements.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this stock position record was first created in the data warehouse. Used for data lineage tracking and audit compliance.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the unit cost. Supports multi-currency inventory valuation for global operations.. Valid values are `^[A-Z]{3}$`',
    `cycle_count_variance` DECIMAL(18,2) COMMENT 'Difference between system on-hand quantity and physical count quantity from the last cycle count. Positive values indicate physical surplus, negative values indicate shortage. Used to measure inventory accuracy and identify shrinkage.',
    `damaged_quantity` DECIMAL(18,2) COMMENT 'Quantity of inventory identified as damaged, defective, or unsellable. This inventory is physically present but excluded from available-to-sell calculations pending disposition decisions (repair, return to vendor, or disposal).',
    `expiration_date` DATE COMMENT 'Date after which the inventory should not be sold or used. Applicable to items with shelf life such as cosmetics, fragrances, or performance fabrics with time-sensitive treatments. Null for non-perishable apparel.',
    `held_quantity` DECIMAL(18,2) COMMENT 'Quantity placed on administrative hold for quality inspection, regulatory compliance review, or investigation. Inventory is physically present but temporarily unavailable for sale or allocation.',
    `hs_code` STRING COMMENT 'International tariff classification code for the product. Used for customs clearance, duty calculation, and trade compliance. Essential for cross-border inventory movements and landed cost calculation.. Valid values are `^[0-9]{6,10}$`',
    `in_transit_quantity` DECIMAL(18,2) COMMENT 'Quantity currently being transported to this location from suppliers, manufacturing facilities, or other distribution points. Includes goods in-transit via ocean freight, air freight, and ground transportation.',
    `last_adjustment_date` DATE COMMENT 'Date of the most recent inventory adjustment transaction at this location. Adjustments include cycle count corrections, damage write-offs, and system corrections. Used for audit trail and inventory accuracy monitoring.',
    `last_cycle_count_date` DATE COMMENT 'Date of the most recent physical cycle count performed for this SKU at this location. Supports inventory accuracy monitoring and audit compliance.',
    `last_receipt_date` DATE COMMENT 'Date of the most recent inventory receipt at this location. Used to track inventory freshness and identify slow-moving stock.',
    `last_sale_date` DATE COMMENT 'Date of the most recent sale or allocation of this SKU from this location. Used to identify dormant inventory and trigger markdown or transfer decisions.',
    `lot_number` STRING COMMENT 'Manufacturing lot or batch identifier for traceability. Enables tracking of inventory by production run for quality control, recall management, and compliance with textile safety standards.. Valid values are `^[A-Z0-9-]{6,20}$`',
    `nos_flag` BOOLEAN COMMENT 'Indicates whether this SKU is designated as a never-out-of-stock item requiring continuous availability. NOS items receive priority replenishment and higher safety stock levels to prevent stockouts.',
    `on_hand_quantity` DECIMAL(18,2) COMMENT 'Total physical inventory quantity currently present at the location. Represents the actual count of units physically available in the facility, verified through cycle counts and RFID tracking.',
    `ownership_type` STRING COMMENT 'Indicates the legal ownership of the inventory. Owned is company-owned stock, consignment is supplier-owned until sold, vendor-owned is VMI stock, and customer-owned is inventory held on behalf of wholesale customers.. Valid values are `owned|consignment|vendor_owned|customer_owned`',
    `reorder_point` DECIMAL(18,2) COMMENT 'Inventory level that triggers automatic replenishment. When on-hand quantity falls below the reorder point, a purchase order or transfer order is generated. Calculated as lead time demand plus safety stock.',
    `replenishment_method` STRING COMMENT 'Strategy used to replenish inventory at this location. Automatic uses system-driven reorder points, manual requires planner intervention, VMI is supplier-managed, cross-dock bypasses storage, and drop-ship ships directly from supplier to customer.. Valid values are `automatic|manual|vmi|cross_dock|drop_ship`',
    `reserved_quantity` DECIMAL(18,2) COMMENT 'Quantity of inventory allocated to specific orders or commitments but not yet shipped. Includes customer orders, store allocations, and wholesale commitments that are pending fulfillment.',
    `rfid_enabled_flag` BOOLEAN COMMENT 'Indicates whether this SKU at this location is tracked using RFID technology. RFID enables real-time inventory visibility, automated cycle counting, and improved inventory accuracy.',
    `safety_stock_quantity` DECIMAL(18,2) COMMENT 'Minimum inventory buffer maintained to protect against demand variability and supply chain disruptions. Safety stock levels are calculated based on demand volatility, lead time variability, and desired service level.',
    `snapshot_date` DATE COMMENT 'Business date for which this stock position record represents the inventory state. Enables point-in-time inventory analysis and historical trend reporting. Updated daily through batch processing.',
    `stock_status` STRING COMMENT 'Current operational status of the inventory at this location. Available indicates sellable stock, reserved is allocated to orders, quarantine is under quality review, damaged is unsellable, in-transit is being received, and blocked is administratively restricted.. Valid values are `available|reserved|quarantine|damaged|in_transit|blocked`',
    `unit_cost` DECIMAL(18,2) COMMENT 'Cost per unit of inventory at this location. Represents the landed cost including product cost, freight, duties, and other acquisition costs. Used for inventory valuation and COGS calculation.',
    `updated_timestamp` TIMESTAMP COMMENT 'System timestamp when this stock position record was last modified. Tracks the most recent change to any attribute in the record for change data capture and audit purposes.',
    `valuation_class` STRING COMMENT 'Financial accounting classification for inventory valuation. Determines the general ledger accounts used for inventory asset and cost of goods sold postings. Supports multi-GAAP reporting requirements.. Valid values are `^[A-Z0-9]{4,10}$`',
    `vmi_flag` BOOLEAN COMMENT 'Indicates whether this inventory is managed under a vendor-managed inventory program where the supplier monitors stock levels and triggers replenishment. VMI programs shift inventory management responsibility to suppliers.',
    `wos` DECIMAL(18,2) COMMENT 'Number of weeks the current on-hand inventory will last based on forecasted demand. Calculated as on-hand quantity divided by average weekly sales rate. Key metric for inventory health and replenishment planning.',
    CONSTRAINT pk_stock_position PRIMARY KEY(`stock_position_id`)
) COMMENT 'Core master record of current stock levels for each SKU across all locations (warehouses, DCs, retail stores, 3PL facilities). Tracks on-hand quantity, reserved quantity, ATS (Available to Sell), ATP (Available to Promise), in-transit quantity, damaged/held quantity, WOS (Weeks of Supply), and aging bucket (current season, prior season, aged). Serves as the real-time inventory position SSOT feeding omnichannel fulfillment, allocation engines, markdown triggers, and financial reporting.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`inventory`.`stock_movement` (
    `stock_movement_id` BIGINT COMMENT 'Unique identifier for the stock movement transaction. Primary key for the stock movement record.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: High-value transfers, write-offs, and exception movements require managerial approval for financial control and shrink prevention. Standard SOX control for inventory adjustments exceeding thresholds. ',
    `asn_id` BIGINT COMMENT 'Foreign key linking to inventory.asn. Business justification: Stock movements triggered by ASN receipts should link to the originating ASN. The reference_document_type and reference_document_number fields suggest generic document linking, but a structured FK to ',
    `bill_of_lading_id` BIGINT COMMENT 'Foreign key linking to logistics.bill_of_lading. Business justification: Import/export movements documented on BOLs. Linking enables shipment traceability, customs documentation validation, freight claim management, and audit trail—standard apparel logistics documentation.',
    `customs_entry_id` BIGINT COMMENT 'Foreign key linking to logistics.customs_entry. Business justification: Import receipts tied to customs entries. Linking enables duty allocation to inventory, landed cost accuracy, trade compliance audit trail, and duty drawback claims—fundamental for apparel import opera',
    `warehouse_location_id` BIGINT COMMENT 'Identifier of the location to which inventory is being moved. Null for goods issues to customers or write-offs. Links to warehouse, store, or distribution center master.',
    `digital_order_id` BIGINT COMMENT 'Foreign key linking to ecommerce.digital_order. Business justification: Stock movements (picks, shipments) are triggered by digital orders. Business process: ecommerce order fulfillment tracking, digital channel inventory velocity analysis, and pick-to-ship cycle time mea',
    `digital_return_id` BIGINT COMMENT 'Foreign key linking to ecommerce.digital_return. Business justification: Return receipts are stock movements triggered by digital returns. Business process: ecommerce return processing, return-to-stock cycle time tracking, and returned inventory disposition in apparel fash',
    `freight_invoice_id` BIGINT COMMENT 'Foreign key linking to logistics.freight_invoice. Business justification: Inbound/outbound movements incur freight costs. Linking enables landed cost calculation, freight accrual accuracy, logistics cost allocation to inventory, and freight variance analysis—fundamental app',
    `goods_receipt_id` BIGINT COMMENT 'Foreign key linking to inventory.goods_receipt. Business justification: Stock movements resulting from goods receipt postings should link directly to the goods_receipt record. This enables traceability from inventory movement back to the physical receipt event, supporting',
    `inspection_id` BIGINT COMMENT 'Foreign key linking to quality.inspection. Business justification: Stock movements are triggered by inspection dispositions: quarantine after failed inspection, release to available after pass, RTV after rejection. Links movement audit trail to quality decision ratio',
    `inventory_cycle_count_id` BIGINT COMMENT 'Foreign key linking to inventory.inventory_cycle_count. Business justification: Stock adjustment movements resulting from cycle count variances should reference the cycle count event that identified the discrepancy. This provides audit trail from count → variance → adjustment mov',
    `lot_batch_id` BIGINT COMMENT 'Foreign key linking to inventory.lot_batch. Business justification: stock_movement tracks lot/batch traceability via batch_number string, but should link to the lot_batch master record for full traceability (dye lot, production date, quality status). Adding lot_batch_',
    `order_purchase_order_line_id` BIGINT COMMENT 'Foreign key linking to order.purchase_order_line. Business justification: Inbound stock movements (receipts, putaways) require PO line linkage for 3-way match validation (PO/ASN/GR), landed cost allocation, supplier performance measurement, and accounts payable reconciliati',
    `otb_budget_id` BIGINT COMMENT 'Foreign key linking to merchandising.otb_budget. Business justification: Receipts and transfers consume OTB budget. Stock movements (especially receipts) must be tracked against OTB budgets for budget consumption tracking and variance analysis in merchandising operations.',
    `primary_stock_warehouse_location_id` BIGINT COMMENT 'Identifier of the location from which inventory is being moved. Null for goods receipts from external suppliers. Links to warehouse, store, or distribution center master.',
    `lot_id` BIGINT COMMENT 'Foreign key linking to production.lot. Business justification: Finished goods receipts from production must link to production lot for batch traceability, quality tracking, and recall management. Critical for apparel compliance (country of origin, labor certifica',
    `profile_id` BIGINT COMMENT 'Identifier of the customer associated with this movement. Populated for goods issues to fulfill customer orders and customer returns. Links to customer master.',
    `quarantine_hold_id` BIGINT COMMENT 'Foreign key linking to inventory.quarantine_hold. Business justification: Stock movements into or out of quarantine status should reference the quarantine_hold record that triggered the movement. This links the physical status change to the quality/compliance hold decision.',
    `replenishment_order_id` BIGINT COMMENT 'Foreign key linking to inventory.replenishment_order. Business justification: Stock movements triggered by replenishment orders should reference the originating replenishment order. This allows tracing which movements fulfilled which replenishment requests. New FK attribute nee',
    `reservation_id` BIGINT COMMENT 'Foreign key linking to inventory.reservation. Business justification: When reserved inventory is allocated or released, the stock movement should reference the reservation record. This links the physical movement to the logical reservation that triggered it, enabling re',
    `retail_store_id` BIGINT COMMENT 'Foreign key linking to store.retail_store. Business justification: Store-level inventory movements (receipts, transfers, adjustments, sales deductions) must be attributed to specific retail stores for store P&L reporting, shrinkage analysis, and operational audit tra',
    `return_shipment_id` BIGINT COMMENT 'Foreign key linking to logistics.return_shipment. Business justification: Returns create inbound stock movements. Linking enables return disposition tracking, restocking cost calculation, return reason analysis, and reverse logistics performance—critical for apparel returns',
    `rfid_tag_id` BIGINT COMMENT 'The unique RFID tag identifier associated with the item or carton being moved. Enables real-time inventory visibility and automated tracking.',
    `rma_id` BIGINT COMMENT 'Foreign key linking to order.rma. Business justification: Return-triggered stock movements (restocking, scrap, vendor return) must link to RMA for warranty claim validation, defect root cause analysis, inventory valuation adjustments, and customer refund pro',
    `routing_guide_id` BIGINT COMMENT 'Foreign key linking to logistics.routing_guide. Business justification: Movements follow routing rules. Linking enables routing compliance analysis, freight cost variance (actual vs. guide), carrier performance by lane, and routing optimization—standard apparel logistics ',
    `sales_order_id` BIGINT COMMENT 'Foreign key linking to order.sales_order. Business justification: Outbound stock movements (picks, shipments) must trace to originating sales order for fulfillment reconciliation, inventory variance analysis, and customer service issue resolution. Essential for orde',
    `season_id` BIGINT COMMENT 'Foreign key linking to merchandising.season. Business justification: Movements of seasonal merchandise must be tracked by season for seasonal receipt tracking, sell-through analysis, and end-of-season inventory reconciliation. Critical for apparel merchandising plannin',
    `shipment_id` BIGINT COMMENT 'Foreign key linking to logistics.logistics_shipment. Business justification: Inbound receipts and outbound shipments create stock movements. Linking enables landed cost calculation, duty allocation to inventory, OTIF variance analysis, and freight cost allocation—critical for ',
    `sourcing_purchase_order_id` BIGINT COMMENT 'Foreign key linking to sourcing.sourcing_purchase_order. Business justification: Inbound stock movements (goods receipts) for materials/fabrics are posted against sourcing POs. Essential for inventory reconciliation, landed cost allocation, and vendor performance tracking in appar',
    `style_id` BIGINT COMMENT 'Internal system identifier linking to the product master record. Foreign key reference to the product dimension.',
    `sustainable_material_id` BIGINT COMMENT 'Foreign key linking to sustainability.sustainable_material. Business justification: Movement transactions require material sustainability data for traceability reporting, carbon footprint calculation per movement event, and circular program eligibility verification. Critical for scop',
    `third_party_logistics_id` BIGINT COMMENT 'Foreign key linking to logistics.third_party_logistics. Business justification: 3PL-operated facilities generate movements. Linking enables 3PL billing validation, performance measurement, cost allocation, and SLA compliance tracking—standard for apparel brands using 3PL warehous',
    `transfer_order_id` BIGINT COMMENT 'Foreign key linking to inventory.transfer_order. Business justification: Stock movements executed as part of transfer orders should link to the originating transfer_order. This connects the transactional movement record to the operational transfer request, enabling trackin',
    `vendor_id` BIGINT COMMENT 'Identifier of the supplier or vendor associated with this movement. Populated for goods receipts from purchase orders and returns to vendor (RTV). Links to supplier master.',
    `work_order_id` BIGINT COMMENT 'Foreign key linking to production.work_order. Business justification: Production-triggered inventory movements (finished goods receipts, component issues, production returns) must reference originating work order for cost accounting, variance analysis, and production-to',
    `approval_status` STRING COMMENT 'Indicates whether the movement required managerial approval and the current approval state. Critical for adjustments, write-offs, and high-value movements.. Valid values are `approved|pending_approval|rejected|not_required`',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when the movement was approved. Part of the audit trail for compliance and internal controls.',
    `approved_by` STRING COMMENT 'User ID or name of the person who approved the movement transaction. Required for audit trail on adjustments and write-offs.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this stock movement record was first created in the database. Part of the audit trail for data lineage and compliance.',
    `currency_code` STRING COMMENT 'Three-letter ISO currency code for the cost amounts (e.g., USD, EUR, GBP). Enables multi-currency inventory valuation for global operations.. Valid values are `^[A-Z]{3}$`',
    `destination_location_code` STRING COMMENT 'Business code for the destination location (e.g., warehouse code, store number, DC identifier). Human-readable identifier for reporting.. Valid values are `^[A-Z0-9]{3,10}$`',
    `destination_location_type` STRING COMMENT 'Classification of the destination location to enable location-type-specific analytics and reporting.. Valid values are `warehouse|distribution_center|retail_store|3pl_facility|customer|scrap`',
    `document_date` DATE COMMENT 'The date on the source document that triggered the movement (e.g., PO date, transfer order date, physical count date). May differ from posting date due to processing delays.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'System timestamp when this stock movement record was last updated. Tracks changes for audit and data quality monitoring.',
    `movement_category` STRING COMMENT 'High-level classification of the movement transaction type for reporting and analytics. Groups detailed movement types into business-meaningful categories.. Valid values are `goods_receipt|goods_issue|transfer|adjustment|return|write_off`',
    `movement_document_number` STRING COMMENT 'The externally-known business document number for this inventory movement (e.g., goods receipt number, transfer order number, adjustment document number). Used for audit trail and cross-system reconciliation.. Valid values are `^[A-Z0-9]{8,20}$`',
    `movement_quantity` DECIMAL(18,2) COMMENT 'The quantity of inventory moved in this transaction. Positive for receipts and negative for issues. Expressed in the base unit of measure.',
    `movement_status` STRING COMMENT 'Current lifecycle status of the stock movement transaction. Indicates whether the movement has been finalized in inventory records or is still in process.. Valid values are `posted|pending|cancelled|reversed`',
    `movement_timestamp` TIMESTAMP COMMENT 'Precise date and time when the physical inventory movement occurred or was recorded in the warehouse management system. Used for real-time inventory tracking and RFID event correlation.',
    `movement_type_code` STRING COMMENT 'Three-digit code classifying the nature of the inventory movement (e.g., 101=Goods Receipt from PO, 311=Transfer Posting, 551=Scrapping, 601=Goods Issue for Delivery). Aligns with SAP movement type taxonomy.. Valid values are `^[0-9]{3}$`',
    `notes` STRING COMMENT 'Free-text field for additional comments, special instructions, or contextual information about the movement. Used by warehouse staff and inventory analysts.',
    `posting_date` DATE COMMENT 'The business date on which the inventory movement was posted to the ledger and inventory balances were updated. This is the official date of record for inventory valuation and financial reporting.',
    `reason_code` STRING COMMENT 'Code indicating the business reason for the movement, especially for adjustments, returns, and write-offs (e.g., damaged, obsolete, cycle count correction, customer return, quality hold release).. Valid values are `^[A-Z0-9]{2,6}$`',
    `reason_description` STRING COMMENT 'Free-text description providing additional context for the movement reason. Used when reason code alone is insufficient to explain the transaction.',
    `reference_document_line_number` STRING COMMENT 'The line item number within the reference document that this movement relates to. Enables line-level traceability.',
    `reference_document_number` STRING COMMENT 'The business document number of the source transaction (e.g., PO number, sales order number, STO number, RTV number, ASN number). Used for audit trail and reconciliation.. Valid values are `^[A-Z0-9]{6,20}$`',
    `reference_document_type` STRING COMMENT 'The type of source document that triggered or authorized this inventory movement. Enables traceability back to originating business transaction. [ENUM-REF-CANDIDATE: purchase_order|sales_order|transfer_order|return_authorization|adjustment_request|delivery_note|asn — 7 candidates stripped; promote to reference product]',
    `reversal_indicator` BOOLEAN COMMENT 'Flag indicating whether this movement is a reversal of a previous transaction. True if this is a correcting entry that negates a prior movement.',
    `reversed_document_number` STRING COMMENT 'The movement document number of the original transaction being reversed. Populated only when reversal_indicator is true. Enables audit trail of corrections.. Valid values are `^[A-Z0-9]{8,20}$`',
    `serial_number` STRING COMMENT 'Unique serial number for serialized inventory items (e.g., high-value accessories, luxury goods). Enables item-level tracking and authentication.. Valid values are `^[A-Z0-9]{8,30}$`',
    `sku` STRING COMMENT 'The unique product identifier for the item being moved. Represents the specific product variant at the most granular level (style-color-size).. Valid values are `^[A-Z0-9-]{6,20}$`',
    `source_location_code` STRING COMMENT 'Business code for the source location (e.g., warehouse code, store number, DC identifier). Human-readable identifier for reporting.. Valid values are `^[A-Z0-9]{3,10}$`',
    `source_location_type` STRING COMMENT 'Classification of the source location to enable location-type-specific analytics and reporting.. Valid values are `warehouse|distribution_center|retail_store|3pl_facility|supplier|transit`',
    `stock_type` STRING COMMENT 'Classification of inventory status indicating availability and ownership. Unrestricted stock is available for sale; other types have restrictions or special handling requirements.. Valid values are `unrestricted|quality_inspection|blocked|returns|consignment|vendor_managed`',
    `total_cost` DECIMAL(18,2) COMMENT 'The total cost of the movement (movement_quantity × unit_cost). Posted to inventory accounts and used for financial reporting and COGS calculation.',
    `unit_cost` DECIMAL(18,2) COMMENT 'The cost per unit of the inventory item at the time of movement. Used for inventory valuation and Cost of Goods Sold (COGS) calculation. Expressed in the companys functional currency.',
    `unit_of_measure` STRING COMMENT 'The unit in which the movement quantity is expressed (EA=Each, CS=Case, PK=Pack, DZ=Dozen, PR=Pair, ST=Set). Aligns with product packaging hierarchy.. Valid values are `EA|CS|PK|DZ|PR|ST`',
    `upc` STRING COMMENT 'The barcode identifier for the product. Used for scanning and point-of-sale transactions. May be GTIN-12, GTIN-13, or GTIN-14 format.. Valid values are `^[0-9]{12,14}$`',
    `valuation_type` STRING COMMENT 'The inventory valuation method applied to this movement for financial accounting purposes. Determines how cost is calculated and posted to the general ledger.. Valid values are `standard|moving_average|fifo|lifo`',
    CONSTRAINT pk_stock_movement PRIMARY KEY(`stock_movement_id`)
) COMMENT 'Transactional record of every inventory movement event including goods receipts, goods issues, inter-location transfers, stock adjustments, returns, write-offs, and corrections. Captures movement type, quantity, unit of measure, source and destination locations, reference document (PO, STO, RTV, delivery note, ASN), posting date, movement reason code, and adjustment approval reference. Serves as the single audit trail for all inventory quantity changes across all channels and locations.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`inventory`.`warehouse_location` (
    `warehouse_location_id` BIGINT COMMENT 'Unique identifier for the warehouse location record. Primary key for the warehouse location entity.',
    `distribution_center_id` BIGINT COMMENT 'Reference to the parent facility (distribution center, warehouse, retail store, 3PL site, bonded warehouse, or cross-dock) where this location resides.',
    `energy_consumption_id` BIGINT COMMENT 'Foreign key linking to sustainability.energy_consumption. Business justification: Warehouse locations roll up to facilities for scope 1/2 emissions reporting. Location-level energy tracking enables zone-specific efficiency programs, renewable energy allocation, and granular carbon ',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Warehouse facilities require designated facility managers responsible for operations, safety compliance, labor scheduling, and performance. Essential for operational accountability, incident reporting',
    `third_party_logistics_id` BIGINT COMMENT 'Foreign key linking to logistics.third_party_logistics. Business justification: 3PL-operated warehouse locations. Linking enables 3PL space utilization analysis, billing validation (storage charges), capacity planning, and location master data management—standard for apparel bran',
    `waste_record_id` BIGINT COMMENT 'Foreign key linking to sustainability.waste_record. Business justification: Waste generation tracked by warehouse location for zero-waste-to-landfill (ZWTL) programs, circular economy initiatives, and facility-level diversion rate reporting. Location-level data enables target',
    `water_usage_id` BIGINT COMMENT 'Foreign key linking to sustainability.water_usage. Business justification: Facility water consumption tracking requires location-level granularity for operational efficiency, water stewardship programs, and ESG disclosure. Warehouse locations aggregate to facility-level wate',
    `zone_id` BIGINT COMMENT 'Foreign key linking to inventory.zone. Business justification: Warehouse locations currently have zone_code (STRING) but should FK to the zone master table for referential integrity. The zone_code string should be removed and replaced with zone_id FK, allowing pr',
    `aisle_code` STRING COMMENT 'Identifier for the physical aisle where the location resides. Used for travel optimization and picker routing.. Valid values are `^[A-Z0-9]{1,10}$`',
    `bin_code` STRING COMMENT 'Identifier for the individual bin or position within the shelf. Represents the most granular storage unit.. Valid values are `^[A-Z0-9]{1,10}$`',
    `bonded_warehouse_flag` BOOLEAN COMMENT 'Indicates whether this location is within a customs bonded area where imported goods can be stored without paying duties until they are released for domestic consumption.',
    `capacity_cubic_meters` DECIMAL(18,2) COMMENT 'Maximum cubic volume (in cubic meters) that can be stored in this location. Used for dimensional slotting and space utilization analysis.',
    `capacity_units` DECIMAL(18,2) COMMENT 'Maximum number of inventory units (eaches, cases, pallets) that can be stored in this location. Used for slotting optimization and capacity planning.',
    `capacity_weight_kg` DECIMAL(18,2) COMMENT 'Maximum weight capacity (in kilograms) for this location. Used to ensure safe storage and compliance with structural load limits.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this warehouse location record was first created in the system. Used for audit trail and data lineage.',
    `cycle_count_frequency_days` STRING COMMENT 'Number of days between scheduled cycle counts for this location. High-value or high-velocity locations typically have shorter frequencies.',
    `effective_end_date` DATE COMMENT 'Date when this warehouse location was deactivated or retired from operations. Null for currently active locations.',
    `effective_start_date` DATE COMMENT 'Date when this warehouse location became active and available for inventory operations. Supports historical tracking of location lifecycle.',
    `hazmat_approved_flag` BOOLEAN COMMENT 'Indicates whether this location is certified and approved for storing hazardous materials (e.g., certain dyes, chemicals, aerosols) in compliance with safety regulations.',
    `last_cycle_count_date` DATE COMMENT 'Date when the most recent cycle count was performed for this location. Used to schedule next cycle count and track inventory accuracy.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this warehouse location record was most recently updated. Used for change tracking and audit compliance.',
    `location_code` STRING COMMENT 'Unique business identifier for the warehouse location within the facility. Used for directed putaway, picking, and cycle count operations. Typically follows facility-specific naming conventions (e.g., A-01-02-03 for Aisle-Rack-Shelf-Bin).. Valid values are `^[A-Z0-9]{2,20}$`',
    `location_name` STRING COMMENT 'Human-readable name or description of the warehouse location for operational reference and reporting.',
    `location_status` STRING COMMENT 'Current operational status of the warehouse location. Determines whether the location is available for putaway, picking, or other warehouse operations.. Valid values are `active|inactive|blocked|maintenance|reserved|quarantine`',
    `location_type` STRING COMMENT 'Classification of the warehouse location by its operational purpose. Determines handling rules, slotting strategies, and fulfillment routing logic. [ENUM-REF-CANDIDATE: bin|shelf|rack|aisle|zone|staging|dock|receiving|shipping|quarantine|returns|bulk|reserve|forward_pick|cross_dock|bonded|stockroom — 17 candidates stripped; promote to reference product]',
    `mixed_lot_allowed_flag` BOOLEAN COMMENT 'Indicates whether inventory from different lots or batches of the same SKU can be stored together in this location. Important for lot traceability and FIFO compliance.',
    `mixed_sku_allowed_flag` BOOLEAN COMMENT 'Indicates whether multiple different SKUs can be stored in this location simultaneously. Forward pick locations typically allow mixed SKUs while reserve locations may be single-SKU.',
    `notes` STRING COMMENT 'Free-form text field for operational notes, special handling instructions, or location-specific comments. Used by warehouse staff for operational context.',
    `pick_sequence` STRING COMMENT 'Numeric sequence used to optimize picker travel paths during order fulfillment. Lower numbers are visited first in the pick route.',
    `putaway_priority` STRING COMMENT 'Priority ranking for directed putaway operations. Higher priority locations are filled first during receiving and replenishment.',
    `rack_code` STRING COMMENT 'Identifier for the rack or bay within the aisle. Part of the hierarchical location structure.. Valid values are `^[A-Z0-9]{1,10}$`',
    `replenishment_trigger_level` DECIMAL(18,2) COMMENT 'Inventory quantity threshold that triggers automatic replenishment from reserve to forward pick locations. Supports Never Out of Stock (NOS) strategies.',
    `rfid_enabled_flag` BOOLEAN COMMENT 'Indicates whether this location is equipped with RFID readers for automated inventory tracking and real-time visibility.',
    `shelf_code` STRING COMMENT 'Identifier for the shelf or level within the rack. Part of the hierarchical location structure.. Valid values are `^[A-Z0-9]{1,10}$`',
    `temperature_zone` STRING COMMENT 'Temperature control classification for the location. Critical for storing temperature-sensitive apparel materials, adhesives, or specialty items.. Valid values are `ambient|refrigerated|frozen|climate_controlled`',
    `vendor_managed_inventory_flag` BOOLEAN COMMENT 'Indicates whether this location is designated for Vendor Managed Inventory programs where suppliers own and manage inventory until point of sale or consumption.',
    `x_coordinate` DECIMAL(18,2) COMMENT 'Horizontal coordinate (X-axis) of the location within the facility floor plan. Used for travel distance calculations and warehouse mapping.',
    `y_coordinate` DECIMAL(18,2) COMMENT 'Vertical coordinate (Y-axis) of the location within the facility floor plan. Used for travel distance calculations and warehouse mapping.',
    `z_coordinate` DECIMAL(18,2) COMMENT 'Height coordinate (Z-axis) of the location representing vertical position or level. Used for multi-level warehouse operations and automated storage systems.',
    CONSTRAINT pk_warehouse_location PRIMARY KEY(`warehouse_location_id`)
) COMMENT 'Hierarchical master record of all inventory storage locations from facility level down to individual bin positions. Encompasses facilities (owned DCs, 3PL sites, retail stockrooms, bonded warehouses, cross-docks), zones, aisles, racks, shelves, and bins. Captures location type, capacity (units and cubic), temperature zone, RFID capability, customs bonded status, zone assignment, and operational status. Supports directed putaway, slotting optimization, and omnichannel fulfillment routing.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`inventory`.`sku_location` (
    `sku_location_id` BIGINT COMMENT 'Unique identifier for the SKU-location association record. Primary key for the sku_location entity.',
    `digital_storefront_id` BIGINT COMMENT 'Foreign key linking to ecommerce.digital_storefront. Business justification: SKU-location assignments designate which warehouse locations fulfill which digital storefronts (e.g., US DC serves US site). Business process: fulfillment routing, ship-from logic, and regional invent',
    `distribution_center_id` BIGINT COMMENT 'Reference to the warehouse, distribution center, retail store, or 3PL (Third-Party Logistics) facility where the SKU is located.',
    `otb_budget_id` BIGINT COMMENT 'Foreign key linking to merchandising.otb_budget. Business justification: Location-level inventory planning is tied to OTB budgets by category. Essential for store-level OTB allocation, inventory financial planning, and ensuring location inventory aligns with merchandise bu',
    `packaging_sustainability_id` BIGINT COMMENT 'Foreign key linking to sustainability.packaging_sustainability. Business justification: Location-specific packaging requirements vary by market (EU recyclability mandates vs. US standards). SKU-location assignments must link to applicable packaging sustainability profiles for compliance ',
    `retail_store_id` BIGINT COMMENT 'Foreign key linking to store.retail_store. Business justification: Store-level SKU slotting and location assignments (sales floor zones, stockroom bins) require linking to specific retail stores for planogram compliance audits, visual merchandising execution, and sto',
    `season_id` BIGINT COMMENT 'Foreign key linking to merchandising.season. Business justification: SKU-location assignments are seasonal in apparel retail; floor sets change by season. Critical for seasonal floor set planning, seasonal assortment execution, and seasonal inventory allocation.',
    `sku_id` BIGINT COMMENT 'Reference to the specific SKU assigned to this location. Links to the product master data.',
    `vendor_id` BIGINT COMMENT 'Reference to the vendor responsible for managing inventory replenishment under the VMI program for this SKU-location.',
    `warehouse_location_id` BIGINT COMMENT 'Foreign key linking to inventory.warehouse_location. Business justification: sku_location associates SKUs with storage locations but currently uses facility_id and location_code strings. Adding warehouse_location_id FK provides a structured link to the hierarchical warehouse_l',
    `zone_id` BIGINT COMMENT 'Foreign key linking to inventory.zone. Business justification: SKU location assignments currently have zone_code (STRING) but should FK to the zone master table for referential integrity. The zone_code string should be removed and replaced with zone_id FK, enabli',
    `allocated_quantity` DECIMAL(18,2) COMMENT 'Quantity of inventory at this location that has been allocated to specific customer orders but not yet picked or shipped.',
    `assignment_effective_date` DATE COMMENT 'Date when the SKU-location assignment became or will become effective. Used for planning seasonal slotting changes and location transitions.',
    `assignment_expiration_date` DATE COMMENT 'Date when the SKU-location assignment expires or is scheduled to be deactivated. Null for permanent assignments.',
    `assignment_status` STRING COMMENT 'Current status of the SKU-location assignment indicating whether the assignment is active and operational or in another state.. Valid values are `active|inactive|pending|blocked|temporary`',
    `atp_quantity` DECIMAL(18,2) COMMENT 'Available to Promise quantity at this location. Includes current ATS plus expected receipts minus committed orders, used for order promising logic.',
    `ats_quantity` DECIMAL(18,2) COMMENT 'Available to Sell quantity at this location. Represents inventory available for customer orders after deducting allocated, reserved, and quality hold quantities.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the SKU-location assignment record was first created in the system.',
    `current_stock_quantity` DECIMAL(18,2) COMMENT 'Current on-hand inventory quantity of the SKU at this specific location. Real-time stock level updated by warehouse transactions.',
    `cycle_count_frequency_days` STRING COMMENT 'Frequency in days for conducting cycle counts of this SKU at this location. High-value or high-velocity items typically have shorter cycle count intervals.',
    `damaged_quantity` DECIMAL(18,2) COMMENT 'Quantity of inventory at this location that has been identified as damaged and is pending disposition (return to vendor, disposal, or salvage).',
    `in_transit_quantity` DECIMAL(18,2) COMMENT 'Quantity of inventory in transit to this location from suppliers, other warehouses, or distribution centers. Expected to arrive and increase available stock.',
    `last_cycle_count_date` DATE COMMENT 'Date when the most recent cycle count was performed for this SKU at this location.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the SKU-location assignment record was most recently modified.',
    `location_capacity_units` DECIMAL(18,2) COMMENT 'Maximum capacity of the storage location expressed in inventory units (e.g., number of units, cases, or pallets that can be stored).',
    `location_capacity_volume_cubic_meters` DECIMAL(18,2) COMMENT 'Maximum volumetric capacity of the storage location expressed in cubic meters. Used for space utilization and slotting optimization.',
    `location_capacity_weight_kg` DECIMAL(18,2) COMMENT 'Maximum weight capacity of the storage location expressed in kilograms. Ensures safe loading and compliance with facility structural limits.',
    `location_type` STRING COMMENT 'Classification of the storage location type indicating its operational purpose within the warehouse or facility.. Valid values are `primary_pick|reserve|overflow|bulk|cross_dock|quarantine`',
    `max_stock_quantity` DECIMAL(18,2) COMMENT 'Maximum inventory quantity that should be stored at this location. Defines the upper limit for replenishment to prevent overstocking.',
    `min_stock_quantity` DECIMAL(18,2) COMMENT 'Minimum inventory quantity that should be maintained at this location to trigger replenishment. Part of min-max inventory control strategy.',
    `next_cycle_count_date` DATE COMMENT 'Scheduled date for the next cycle count of this SKU at this location based on the cycle count frequency.',
    `nos_classification_tier` STRING COMMENT 'Classification tier indicating the priority level for NOS (Never Out of Stock) strategy. Tier 1 represents highest priority items that must always be in stock.. Valid values are `tier_1|tier_2|tier_3|non_nos`',
    `nos_policy_code` STRING COMMENT 'Code identifying the specific NOS policy applied to this SKU-location combination, defining replenishment rules, safety stock levels, and escalation procedures.. Valid values are `^[A-Z0-9]{1,10}$`',
    `overflow_location_code` STRING COMMENT 'Code identifying the overflow or secondary storage location for this SKU when primary location capacity is exceeded.. Valid values are `^[A-Z0-9]{1,20}$`',
    `pick_sequence_number` STRING COMMENT 'Sequence number defining the order in which this location should be picked during wave picking or batch picking operations to optimize picker travel path.',
    `primary_pick_location_flag` BOOLEAN COMMENT 'Indicates whether this location is designated as the primary pick location for the SKU. True if this is the first location pickers should retrieve inventory from.',
    `quarantine_quantity` DECIMAL(18,2) COMMENT 'Quantity of inventory at this location that is held in quarantine pending quality inspection, compliance verification, or issue resolution.',
    `reorder_point_quantity` DECIMAL(18,2) COMMENT 'Inventory level at which replenishment should be triggered for this SKU at this location. When ATS (Available to Sell) falls below this threshold, a replenishment order is generated.',
    `replenishment_lead_time_days` STRING COMMENT 'Number of days required to replenish inventory at this location from the time a replenishment order is triggered until goods are received and available.',
    `replenishment_method` STRING COMMENT 'Method used to trigger and calculate replenishment for this SKU at this location (e.g., min-max, reorder point, periodic review, demand-driven, VMI).. Valid values are `min_max|reorder_point|periodic|demand_driven|vmi`',
    `reserved_quantity` DECIMAL(18,2) COMMENT 'Quantity of inventory at this location that has been reserved for specific purposes (e.g., promotional events, wholesale orders, store transfers) and is not available for general sale.',
    `rfid_enabled_flag` BOOLEAN COMMENT 'Indicates whether RFID (Radio Frequency Identification) tracking is enabled for this SKU at this location for real-time inventory visibility and automated cycle counting.',
    `safety_stock_quantity` DECIMAL(18,2) COMMENT 'Buffer inventory quantity maintained at this location to protect against demand variability and supply chain disruptions. Part of NOS (Never Out of Stock) strategy.',
    `slotting_priority_rank` STRING COMMENT 'Numerical rank indicating the priority of this SKU for optimal warehouse slotting. Lower numbers indicate higher priority for placement in prime pick locations.',
    `vmi_indicator` BOOLEAN COMMENT 'Indicates whether this SKU-location is managed under a VMI (Vendor Managed Inventory) program where the supplier is responsible for monitoring and replenishing inventory levels.',
    `wos_current` DECIMAL(18,2) COMMENT 'Current WOS (Weeks of Supply) calculated as current stock quantity divided by average weekly demand. Indicates how many weeks the current inventory will last.',
    `wos_target` DECIMAL(18,2) COMMENT 'Target WOS (Weeks of Supply) for this SKU at this location. Represents the desired number of weeks of inventory to maintain based on forecasted demand.',
    CONSTRAINT pk_sku_location PRIMARY KEY(`sku_location_id`)
) COMMENT 'Association entity linking SKUs to their assigned storage locations within a facility, capturing slotting rules, primary pick location, overflow location, min/max replenishment levels, reorder point, safety stock quantity, NOS (Never Out of Stock) classification tier and policy attributes, and VMI (Vendor Managed Inventory) indicator. Drives replenishment triggers, NOS compliance monitoring, and omnichannel fulfillment positioning.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`inventory`.`inventory_cycle_count` (
    `inventory_cycle_count_id` BIGINT COMMENT 'Unique identifier for the inventory cycle count event. Primary key for the cycle count record.',
    `lot_batch_id` BIGINT COMMENT 'Foreign key linking to inventory.lot_batch. Business justification: Cycle counts often need to track lot/batch-specific inventory (especially for dye-lot consistency in apparel). inventory_cycle_count has lot_number string but no FK to lot_batch master. Adding lot_bat',
    `employee_id` BIGINT COMMENT 'Reference to the warehouse associate or employee assigned to perform the physical count.',
    `retail_store_id` BIGINT COMMENT 'Foreign key linking to store.retail_store. Business justification: Store cycle counts must be attributed to specific retail stores for inventory accuracy KPIs, shrinkage reconciliation, and store operational performance tracking - critical for retail loss prevention ',
    `season_id` BIGINT COMMENT 'Foreign key linking to merchandising.season. Business justification: Cycle counts are often scheduled by season for seasonal merchandise, especially pre-season and end-of-season. Essential for seasonal inventory accuracy audits and seasonal inventory reconciliation.',
    `sku_id` BIGINT COMMENT 'Reference to the specific SKU being counted in this cycle count line. Links to product master for item details.',
    `warehouse_location_id` BIGINT COMMENT 'Reference to the warehouse, distribution center, retail store, or 3PL facility where the cycle count is being performed.',
    `zone_id` BIGINT COMMENT 'Reference to the specific zone, aisle, or storage area within the location being counted. Enables zone-level cycle counting strategies.',
    `abc_classification` STRING COMMENT 'ABC analysis classification of the SKU determining cycle count frequency: A (high value, frequent counts), B (medium value, moderate counts), C (low value, infrequent counts).. Valid values are `A|B|C`',
    `adjustment_amount` DECIMAL(18,2) COMMENT 'Financial value of the inventory adjustment calculated as variance quantity multiplied by unit cost. Impacts COGS and inventory valuation.',
    `adjustment_document_number` STRING COMMENT 'Reference number of the inventory adjustment document posted to SAP or ERP system as a result of the approved variance.. Valid values are `^ADJ-[0-9]{10}$`',
    `adjustment_posted_flag` BOOLEAN COMMENT 'Indicator that the variance has been posted to inventory records and financial ledgers. True when adjustment posted, False when pending.',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when the cycle count was approved by the supervisor and cleared for adjustment posting.',
    `approved_quantity` DECIMAL(18,2) COMMENT 'Final quantity approved by supervisor or system after count validation and any required recounts. This quantity is posted to inventory records.',
    `count_end_timestamp` TIMESTAMP COMMENT 'Actual date and time when the physical counting activity was completed and submitted for review.',
    `count_method` STRING COMMENT 'Technology or process used to perform the physical count: manual (visual count and paper), handheld_scanner (barcode scanning device), rfid_reader (RFID tag reading), automated_system (automated storage and retrieval system count).. Valid values are `manual|handheld_scanner|rfid_reader|automated_system`',
    `count_notes` STRING COMMENT 'Free-text comments or observations recorded by the counter during the cycle count, documenting issues, discrepancies, or special conditions.',
    `count_number` STRING COMMENT 'Business identifier for the cycle count event, typically formatted as CC-YYYYMMDD-NNNNNN for external reference and tracking.. Valid values are `^CC-[0-9]{8}-[A-Z0-9]{6}$`',
    `count_reason` STRING COMMENT 'Business reason triggering the cycle count: scheduled (routine calendar-based), variance_triggered (system detected discrepancy), stock_adjustment (manual correction needed), audit (compliance or quality check), neveroutofstock (NOS item verification), receiving_discrepancy (inbound variance), returns_verification (RTV or customer return validation). [ENUM-REF-CANDIDATE: scheduled|variance_triggered|stock_adjustment|audit|neveroutofstock|receiving_discrepancy|returns_verification — 7 candidates stripped; promote to reference product]',
    `count_start_timestamp` TIMESTAMP COMMENT 'Actual date and time when the physical counting activity began, captured from WMS or handheld device.',
    `count_status` STRING COMMENT 'Current lifecycle status of the cycle count: planned (scheduled but not started), assigned (counter designated), in_progress (counting underway), completed (count finished pending review), approved (variance accepted and posted), rejected (count invalidated), recount_required (variance exceeds threshold). [ENUM-REF-CANDIDATE: planned|assigned|in_progress|completed|approved|rejected|recount_required — 7 candidates stripped; promote to reference product]',
    `count_type` STRING COMMENT 'Classification of the cycle count methodology: full (complete location inventory), partial (sample-based), abc_class (frequency based on item value), rfid_assisted (RFID technology enabled), blind (no system quantity shown), targeted (specific SKU focus).. Valid values are `full|partial|abc_class|rfid_assisted|blind|targeted`',
    `counted_quantity` DECIMAL(18,2) COMMENT 'Actual physical quantity counted by the assigned counter during the cycle count event.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the cycle count record was first created in the system, typically during count planning or scheduling.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the adjustment amount (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `expected_quantity` DECIMAL(18,2) COMMENT 'System-recorded quantity on hand for the SKU at the location prior to the physical count, sourced from perpetual inventory records.',
    `inventory_status` STRING COMMENT 'Quality and availability status of the counted inventory: available (ATS), reserved (allocated to orders), quarantine (quality hold), damaged (not sellable), expired (past shelf life), return_to_vendor (RTV candidate).. Valid values are `available|reserved|quarantine|damaged|expired|return_to_vendor`',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when the cycle count record was last updated, tracking changes through the count lifecycle.',
    `recount_flag` BOOLEAN COMMENT 'Indicator that the variance exceeds tolerance and a recount is required before posting adjustment. True when recount needed, False otherwise.',
    `recount_number` STRING COMMENT 'Sequential number indicating how many times this item has been recounted. Zero for initial count, increments with each recount attempt.',
    `scheduled_date` DATE COMMENT 'Planned date for the cycle count event to be executed, based on ABC classification frequency or calendar-driven schedule.',
    `serial_number` STRING COMMENT 'Unique serial number for serialized inventory items, enabling unit-level tracking for high-value or regulated products.. Valid values are `^SN-[A-Z0-9]{10,15}$`',
    `unit_of_measure` STRING COMMENT 'Unit in which quantities are expressed: EA (each), CS (case), PK (pack), DZ (dozen), PR (pair), ST (set). Must align with SKU base UOM.. Valid values are `EA|CS|PK|DZ|PR|ST`',
    `variance_percentage` DECIMAL(18,2) COMMENT 'Variance quantity expressed as a percentage of expected quantity, used to determine if recount threshold is exceeded.',
    `variance_quantity` DECIMAL(18,2) COMMENT 'Calculated difference between expected quantity and counted quantity (counted minus expected). Positive indicates overage, negative indicates shortage.',
    `variance_threshold_percentage` DECIMAL(18,2) COMMENT 'Configured tolerance percentage for acceptable variance. Variances exceeding this threshold trigger recount or management approval requirements.',
    CONSTRAINT pk_inventory_cycle_count PRIMARY KEY(`inventory_cycle_count_id`)
) COMMENT 'Operational record of scheduled and ad-hoc physical inventory cycle count events at a location or zone level, including line-level SKU count details. Header captures count plan date, count type (full, partial, ABC-class, RFID-assisted), assigned counter, count status, and variance threshold. Line-level detail records expected quantity, counted quantity, variance, recount flag, and final approved quantity. Drives stock adjustment postings when variance exceeds tolerance.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`inventory`.`transfer_order` (
    `transfer_order_id` BIGINT COMMENT 'Unique identifier for the transfer order. Primary key for the transfer order entity.',
    `carbon_emission_id` BIGINT COMMENT 'Foreign key linking to sustainability.carbon_emission. Business justification: Inter-facility transfers generate scope 3 category 4 emissions (upstream transportation). Transfer orders must link to emission records for carbon accounting, SBTi reporting, and logistics optimizatio',
    `carrier_id` BIGINT COMMENT 'Identifier of the logistics carrier or third-party logistics provider responsible for transporting the inventory.',
    `warehouse_location_id` BIGINT COMMENT 'Identifier of the receiving location to which inventory is being transferred (warehouse, distribution center, retail store, or third-party logistics facility).',
    `freight_invoice_id` BIGINT COMMENT 'Foreign key linking to logistics.freight_invoice. Business justification: Inter-facility transfers generate freight invoices. Linking enables transfer cost allocation, budget variance analysis, carrier rate validation, and network cost optimization—standard apparel distribu',
    `otb_budget_id` BIGINT COMMENT 'Foreign key linking to merchandising.otb_budget. Business justification: Inter-location transfers may be planned against OTB budgets, especially for allocation transfers. Essential for allocation transfer planning and ensuring transfers align with merchandise financial pla',
    `employee_id` BIGINT COMMENT 'Identifier of the user or system process that initiated the transfer order.',
    `primary_transfer_warehouse_location_id` BIGINT COMMENT 'Identifier of the originating location from which inventory is being transferred (warehouse, distribution center, retail store, or third-party logistics facility).',
    `inspection_id` BIGINT COMMENT 'Foreign key linking to quality.inspection. Business justification: Inter-facility transfers may require quality verification inspections before shipment to ensure only conforming inventory moves between locations. Enforces quality gates in multi-echelon distribution ',
    `routing_guide_id` BIGINT COMMENT 'Foreign key linking to logistics.routing_guide. Business justification: Transfers follow routing guides. Linking enables routing compliance measurement, freight budget accuracy, network optimization validation, and carrier selection audit—standard apparel distribution ope',
    `season_id` BIGINT COMMENT 'Foreign key linking to merchandising.season. Business justification: Transfers of seasonal merchandise must be tracked by season for seasonal allocation transfers, seasonal inventory balancing, and end-of-season clearance logistics.',
    `shipment_id` BIGINT COMMENT 'Foreign key linking to logistics.logistics_shipment. Business justification: Inter-facility transfers generate outbound shipments. Linking enables freight cost allocation to transfers, transit tracking, replenishment lead time analysis, and network optimization—core apparel di',
    `sku_id` BIGINT COMMENT 'Identifier of the specific product SKU being transferred. Links to the product master for detailed item information.',
    `retail_store_id` BIGINT COMMENT 'Foreign key linking to store.retail_store. Business justification: Inter-store transfers originate from source retail stores for stock balancing, allocation optimization, and ship-from-store fulfillment - requires tracking source store for inventory deduction, transf',
    `tertiary_transfer_cancelled_by_user_employee_id` BIGINT COMMENT 'Identifier of the user who cancelled the transfer order, if applicable.',
    `third_party_logistics_id` BIGINT COMMENT 'Foreign key linking to logistics.third_party_logistics. Business justification: 3PL-managed transfers. Linking enables 3PL fulfillment performance measurement, cost allocation, SLA compliance tracking, and service level validation—standard for apparel brands using 3PL distributio',
    `actual_delivery_date` DATE COMMENT 'The actual date the inventory was received at the destination location.',
    `actual_freight_cost` DECIMAL(18,2) COMMENT 'The actual transportation cost incurred for the transfer order in the base currency.',
    `actual_ship_date` DATE COMMENT 'The actual date the inventory was shipped from the source location.',
    `approved_timestamp` TIMESTAMP COMMENT 'The date and time when the transfer order was approved for execution.',
    `cancellation_reason` STRING COMMENT 'Explanation for why the transfer order was cancelled, if applicable.',
    `cancelled_timestamp` TIMESTAMP COMMENT 'The date and time when the transfer order was cancelled, if applicable.',
    `completed_timestamp` TIMESTAMP COMMENT 'The date and time when the transfer order was fully received and closed in the system.',
    `confirmed_quantity` DECIMAL(18,2) COMMENT 'The actual quantity of units confirmed available and allocated for transfer at the source location.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when the transfer order record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this transfer order.. Valid values are `^[A-Z]{3}$`',
    `estimated_freight_cost` DECIMAL(18,2) COMMENT 'The estimated transportation cost for the transfer order in the base currency.',
    `freight_terms` STRING COMMENT 'Terms defining who bears the cost and risk of transportation: prepaid, collect, third party, Free on Board (FOB) origin, or FOB destination.. Valid values are `prepaid|collect|third_party|fob_origin|fob_destination`',
    `hazmat_indicator` BOOLEAN COMMENT 'Indicates whether the transferred inventory contains hazardous materials requiring special handling and compliance documentation.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when the transfer order record was most recently updated.',
    `notes` STRING COMMENT 'Free-text field for additional instructions, special handling requirements, or contextual information about the transfer.',
    `otif_status` STRING COMMENT 'Performance indicator showing whether the transfer was delivered on time and in full quantity as requested.. Valid values are `on_time_in_full|late|short|late_and_short|pending`',
    `priority_level` STRING COMMENT 'Business priority assigned to the transfer order determining processing sequence and resource allocation.. Valid values are `low|normal|high|urgent|critical`',
    `reason_code` STRING COMMENT 'Business reason code explaining the purpose or trigger for the transfer order (e.g., low stock alert, seasonal demand, product recall, store opening).',
    `received_quantity` DECIMAL(18,2) COMMENT 'The actual quantity of units received and accepted at the destination location.',
    `requested_delivery_date` DATE COMMENT 'The date by which the inventory is requested to arrive at the destination location.',
    `requested_quantity` DECIMAL(18,2) COMMENT 'The quantity of units originally requested to be transferred from source to destination location.',
    `requested_ship_date` DATE COMMENT 'The date by which the inventory is requested to be shipped from the source location.',
    `rfid_tracked` BOOLEAN COMMENT 'Indicates whether the transferred inventory is tracked using RFID technology for real-time visibility.',
    `shipment_method` STRING COMMENT 'The transportation mode used for the transfer: ground, air, ocean, rail, intermodal, or courier service.. Valid values are `ground|air|ocean|rail|intermodal|courier`',
    `shipped_quantity` DECIMAL(18,2) COMMENT 'The actual quantity of units physically shipped from the source location.',
    `source_document_number` STRING COMMENT 'Reference number of the upstream business document that triggered this transfer order (e.g., allocation plan ID, replenishment rule ID).',
    `source_document_type` STRING COMMENT 'The type of upstream business document or process that triggered the creation of this transfer order.. Valid values are `manual|allocation_plan|replenishment_rule|purchase_order|sales_order|recall_notice`',
    `temperature_controlled` BOOLEAN COMMENT 'Indicates whether the transfer requires temperature-controlled transportation and storage conditions.',
    `tracking_number` STRING COMMENT 'Carrier-provided tracking reference number for monitoring shipment status and location during transit.',
    `transfer_order_number` STRING COMMENT 'Business-facing unique reference number for the transfer order, used for tracking and communication across systems and stakeholders.. Valid values are `^TO-[0-9]{8,12}$`',
    `transfer_status` STRING COMMENT 'Current lifecycle status of the transfer order indicating its progression through the fulfillment workflow. [ENUM-REF-CANDIDATE: draft|approved|in_transit|received|cancelled|partially_received|on_hold — 7 candidates stripped; promote to reference product]',
    `transfer_type` STRING COMMENT 'Classification of the transfer order purpose: replenishment (store restocking), rebalancing (inventory optimization), recall (product withdrawal), return (reverse logistics), consolidation (inventory centralization), or emergency (urgent fulfillment).. Valid values are `replenishment|rebalancing|recall|return|consolidation|emergency`',
    `unit_of_measure` STRING COMMENT 'The unit of measure for the transferred quantity: EA (each), CS (case), PK (pack), BX (box), PL (pallet), DZ (dozen).. Valid values are `EA|CS|PK|BX|PL|DZ`',
    CONSTRAINT pk_transfer_order PRIMARY KEY(`transfer_order_id`)
) COMMENT 'Operational record of internal stock transfer requests and executions between locations (warehouse-to-store, DC-to-DC, store-to-store, 3PL-to-DC). Captures transfer reference, source location, destination location, requested quantity, confirmed quantity, transfer type (replenishment, rebalancing, recall), priority, and OTIF status.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`inventory`.`rfid_tag` (
    `rfid_tag_id` BIGINT COMMENT 'Unique identifier for the RFID tag record. Primary key for item-level tracking.',
    `lot_batch_id` BIGINT COMMENT 'Batch or lot identifier for the group of RFID tags encoded together. Used for quality control and batch-level issue tracking.',
    `pos_transaction_id` BIGINT COMMENT 'Transaction identifier from the POS system when the item was sold. Links RFID data to sales transaction for reconciliation and customer analytics.',
    `product_safety_test_id` BIGINT COMMENT 'Foreign key linking to compliance.product_safety_test. Business justification: RFID tags enable item-level traceability to safety test results for recall management and consumer transparency (QR code scanning for test certificates). Required for CPSC Fast Track recall programs a',
    `return_transaction_id` BIGINT COMMENT 'Transaction identifier for the return event. Links to return transaction record for return reason and disposition analysis.',
    `work_order_id` BIGINT COMMENT 'Foreign key linking to production.work_order. Business justification: RFID tags encoded at production encode work order reference for end-to-end supply chain traceability, authentication, and anti-counterfeiting. Standard practice in premium apparel for serialized item ',
    `attachment_location` STRING COMMENT 'Facility where the tag was attached to the product. Typically a CMT (Cut Make Trim) factory, OEM facility, or distribution center.',
    `attachment_timestamp` TIMESTAMP COMMENT 'Date and time when the RFID tag was physically attached to the garment, footwear, or accessory. Marks the start of item-level tracking.',
    `authentication_timestamp` TIMESTAMP COMMENT 'Date and time when the RFID tag was authenticated. Used for supply chain security and brand protection.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this RFID tag record was first created in the system. Audit trail for data governance.',
    `decommission_reason` STRING COMMENT 'Reason why the RFID tag was decommissioned. Used for shrinkage analysis, loss prevention, and tag quality management. [ENUM-REF-CANDIDATE: sold|damaged|lost|stolen|expired|tag_failure|product_disposal — 7 candidates stripped; promote to reference product]',
    `decommission_timestamp` TIMESTAMP COMMENT 'Date and time when the RFID tag was decommissioned and removed from active tracking. Occurs after final sale, disposal, or tag failure.',
    `encoding_location` STRING COMMENT 'Facility or location where the RFID tag was encoded. May be a manufacturing plant, distribution center, or third-party logistics provider.',
    `encoding_timestamp` TIMESTAMP COMMENT 'Date and time when the RFID tag was encoded with EPC data. Typically occurs at the manufacturing facility or distribution center.',
    `epc` STRING COMMENT 'Globally unique Electronic Product Code encoded on the RFID tag, typically in SGTIN-96 or SGTIN-198 format. Enables item-level identification across the supply chain.. Valid values are `^urn:epc:id:sgtin:[0-9]{1,13}.[0-9]{1,7}.[0-9]{1,12}$`',
    `first_read_location` STRING COMMENT 'Location where the tag was first read in the system. Typically a receiving dock at a distribution center or warehouse.',
    `first_read_timestamp` TIMESTAMP COMMENT 'Date and time of the first successful read of this RFID tag in the system. Marks entry into active inventory tracking.',
    `is_authenticated` BOOLEAN COMMENT 'Indicates whether the RFID tag has been authenticated as genuine. Critical for luxury goods and anti-counterfeiting programs.',
    `is_reusable` BOOLEAN COMMENT 'Indicates whether the RFID tag is designed for reuse across multiple products or is single-use. Reusable tags are common for returnable assets and rental programs.',
    `last_read_context` STRING COMMENT 'Business context or event type of the last RFID read. Indicates the operational process during which the tag was scanned. [ENUM-REF-CANDIDATE: receiving|cycle_count|inventory_audit|pos_sale|fitting_room|exit_gate|shipment|return — 8 candidates stripped; promote to reference product]',
    `last_read_device_code` STRING COMMENT 'Identifier of the RFID reader device that performed the last successful read. Links to reader device master for troubleshooting and analytics.',
    `last_read_location` STRING COMMENT 'Physical location where the tag was last read. May be a warehouse zone, store department, fitting room, or point-of-sale terminal.',
    `last_read_signal_strength` DECIMAL(18,2) COMMENT 'Signal strength in decibels-milliwatts (dBm) of the last successful read. Used for read quality assessment and reader placement optimization.',
    `last_read_timestamp` TIMESTAMP COMMENT 'Most recent date and time when the RFID tag was successfully read by an RFID reader. Used for real-time inventory visibility and movement tracking.',
    `lock_status` STRING COMMENT 'Write-protection status of the RFID tag memory. Locked tags cannot be rewritten, permalocked tags are permanently locked. Used for security and data integrity.. Valid values are `unlocked|locked|permalocked`',
    `return_location` STRING COMMENT 'Store or facility where the item was returned. May differ from original sale location for omnichannel returns.',
    `return_timestamp` TIMESTAMP COMMENT 'Date and time when the item was returned by the customer. Enables return rate analysis and reverse logistics tracking.',
    `sale_location` STRING COMMENT 'Store or channel where the item was sold. Links to retail store master or e-commerce fulfillment center.',
    `sale_timestamp` TIMESTAMP COMMENT 'Date and time when the item with this RFID tag was sold at point of sale. Marks transition from inventory to sold status.',
    `serial_number` STRING COMMENT 'Unique serial number for the individual item. Enables item-level traceability and authentication, particularly for luxury and high-value products.',
    `sku` STRING COMMENT 'The product SKU that this RFID tag is attached to. Links the tag to the specific style-color-size combination in the product master.',
    `tag_encoding_standard` STRING COMMENT 'EPC encoding scheme used on the tag. SGTIN (Serialized Global Trade Item Number) is most common for apparel SKUs, SSCC for logistics units, GRAI for returnable assets, GIAI for fixed assets.. Valid values are `SGTIN-96|SGTIN-198|SSCC-96|GRAI-96|GIAI-96`',
    `tag_lifecycle_status` STRING COMMENT 'Current state of the RFID tag in its operational lifecycle. Tracks progression from encoding through sale or decommissioning. [ENUM-REF-CANDIDATE: encoded|attached|in_transit|received|in_store|sold|returned|decommissioned — 8 candidates stripped; promote to reference product]',
    `tag_manufacturer` STRING COMMENT 'Name of the company that manufactured the RFID tag. Used for quality tracking and vendor performance analysis.',
    `tag_memory_size` STRING COMMENT 'Memory capacity of the RFID tag in bits. Determines how much data can be encoded on the tag beyond the basic EPC.',
    `tag_model` STRING COMMENT 'Specific model or part number of the RFID tag. Different models may have varying read ranges, durability, and form factors.',
    `tag_type` STRING COMMENT 'Radio frequency type of the RFID tag. UHF (Ultra High Frequency) for long-range warehouse and store reads, HF (High Frequency) or NFC (Near Field Communication) for close-proximity interactions, LF (Low Frequency) for specialized applications.. Valid values are `UHF|HF|NFC|LF`',
    `total_read_count` STRING COMMENT 'Cumulative number of times this RFID tag has been successfully read since encoding. Used for tag performance analysis and lifecycle management.',
    `upc` STRING COMMENT '12-digit UPC barcode associated with the SKU. Used for point-of-sale scanning and cross-reference with legacy barcode systems.. Valid values are `^[0-9]{12}$`',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time when this RFID tag record was last updated. Tracks data freshness and change frequency.',
    CONSTRAINT pk_rfid_tag PRIMARY KEY(`rfid_tag_id`)
) COMMENT 'Master record of individual RFID tags assigned to garments, footwear, or accessories for item-level inventory visibility, including read event history. Captures EPC (Electronic Product Code), tag type (UHF, HF), encoding status, associated SKU and UPC, tag lifecycle state (encoded, attached, in-store, sold, returned, decommissioned), last read timestamp, last read location, and read event log (reader device, signal strength, read context). Enables real-time inventory accuracy, loss prevention, shrinkage detection, and fitting room analytics.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`inventory`.`replenishment_order` (
    `replenishment_order_id` BIGINT COMMENT 'Unique identifier for the replenishment order record.',
    `allocation_plan_id` BIGINT COMMENT 'Identifier of the merchandise allocation plan that generated this replenishment order, if the order is part of a planned allocation strategy.',
    `carbon_emission_id` BIGINT COMMENT 'Foreign key linking to sustainability.carbon_emission. Business justification: Replenishment logistics create transportation emissions tracked under scope 3 category 4. Orders must link to emission events for carbon footprint reporting, CDP disclosure, and supply chain decarboni',
    `carrier_id` BIGINT COMMENT 'Identifier of the logistics carrier or 3PL (Third-Party Logistics) provider responsible for transporting the replenishment shipment.',
    `warehouse_location_id` BIGINT COMMENT 'Identifier of the retail store, distribution center, or warehouse that will receive the replenished inventory.',
    `retail_store_id` BIGINT COMMENT 'Foreign key linking to store.retail_store. Business justification: Store replenishment orders from DC to retail stores must track destination store for fulfillment planning, store WOS management, replenishment lead time tracking, and store-level inventory flow optimi',
    `digital_storefront_id` BIGINT COMMENT 'Foreign key linking to ecommerce.digital_storefront. Business justification: Replenishment orders are often triggered by demand from specific digital channels. Tracking the requesting storefront enables channel-specific inventory planning and demand attribution. Business proce',
    `merchandise_hierarchy_id` BIGINT COMMENT 'Foreign key linking to merchandising.merchandise_hierarchy. Business justification: Replenishment planning is organized by merchandise hierarchy (department/class/subclass). Essential for category-level replenishment planning, replenishment strategy by category, and merchandise hiera',
    `nos_policy_id` BIGINT COMMENT 'Foreign key linking to inventory.nos_policy. Business justification: Replenishment orders triggered by Never Out of Stock policies should reference the NOS policy that generated them. This allows tracking NOS policy effectiveness and prioritizing NOS-driven replenishme',
    `otb_budget_id` BIGINT COMMENT 'Foreign key linking to merchandising.otb_budget. Business justification: Replenishment orders consume OTB budget. Essential for OTB budget tracking for replenishments, ensuring replenishment spending aligns with merchandise financial plans and budget compliance.',
    `employee_id` BIGINT COMMENT 'Identifier of the inventory planner or merchandise planner responsible for reviewing and approving this replenishment order.',
    `primary_replenishment_warehouse_location_id` BIGINT COMMENT 'Identifier of the warehouse, distribution center, or 3PL facility from which inventory will be shipped to fulfill this replenishment order.',
    `routing_guide_id` BIGINT COMMENT 'Foreign key linking to logistics.routing_guide. Business justification: Replenishment follows routing rules. Linking enables allocation plan freight assumptions validation, routing compliance, cost-to-serve accuracy, and replenishment cost optimization—critical for appare',
    `season_id` BIGINT COMMENT 'Identifier of the merchandise season or collection to which the replenished SKU belongs, used for seasonal inventory planning.',
    `shipment_id` BIGINT COMMENT 'Foreign key linking to logistics.logistics_shipment. Business justification: Replenishment fulfillment creates shipments. Linking enables landed cost per unit for allocation plans, supply chain velocity metrics, and allocation plan performance measurement—critical for apparel ',
    `sku_id` BIGINT COMMENT 'Identifier of the SKU (Stock Keeping Unit) being replenished, representing a unique product variant by style, color, size, and other attributes.',
    `standard_id` BIGINT COMMENT 'Foreign key linking to quality.quality_standard. Business justification: Replenishment orders specify quality standards that must be met for inventory to be eligible for allocation and sale. Ensures only compliant inventory enters replenishment workflows, supporting brand ',
    `style_id` BIGINT COMMENT 'Identifier of the parent product or style to which the SKU belongs, used for aggregated reporting and planning.',
    `third_party_logistics_id` BIGINT COMMENT 'Foreign key linking to logistics.third_party_logistics. Business justification: 3PL-managed replenishment. Linking enables 3PL service level tracking, cost allocation, performance benchmarking, and SLA compliance measurement—standard for apparel brands using 3PL fulfillment.',
    `vmi_program_id` BIGINT COMMENT 'Foreign key linking to inventory.vmi_program. Business justification: Replenishment orders generated automatically by VMI programs should reference the VMI program that triggered them. This enables tracking of VMI program performance and distinguishes vendor-managed rep',
    `actual_delivery_date` DATE COMMENT 'The actual date when the replenishment order was received and confirmed at the destination location.',
    `actual_ship_date` DATE COMMENT 'The actual date when the replenishment order was shipped from the source location.',
    `approved_quantity` DECIMAL(18,2) COMMENT 'The quantity of units approved for shipment after review by inventory planner or system validation, may differ from requested quantity due to availability or budget constraints.',
    `approved_timestamp` TIMESTAMP COMMENT 'The date and time when the replenishment order was approved for execution.',
    `ats_quantity_at_request` DECIMAL(18,2) COMMENT 'The ATS (Available to Sell) inventory quantity at the destination location when the replenishment order was created, representing on-hand minus allocated/reserved inventory.',
    `cancelled_reason` STRING COMMENT 'Free-text explanation of why the replenishment order was cancelled, if applicable (e.g., inventory no longer needed, source location stockout, budget constraints).',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when the replenishment order record was first created in the system.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for freight cost and other monetary values (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `expected_ship_date` DATE COMMENT 'The planned date when the source location will ship the replenishment order, calculated based on lead time and requested delivery date.',
    `freight_cost` DECIMAL(18,2) COMMENT 'The transportation cost incurred for shipping this replenishment order, used for landed cost calculation and logistics analytics.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when the replenishment order record was last updated, used for audit trail and change tracking.',
    `lead_time_days` STRING COMMENT 'The expected number of days from order release to delivery at the destination location, based on historical performance and carrier SLA.',
    `max_stock_level` DECIMAL(18,2) COMMENT 'The target maximum inventory level at the destination location, used in min/max replenishment logic to determine order quantity.',
    `notes` STRING COMMENT 'Free-text notes or comments added by planners or system users regarding special handling, exceptions, or business context for this replenishment order.',
    `on_hand_quantity_at_request` DECIMAL(18,2) COMMENT 'The physical inventory quantity available at the destination location at the time the replenishment order was created, used to calculate replenishment need.',
    `order_number` STRING COMMENT 'Business-facing unique order number for the replenishment request, typically system-generated with REP prefix.. Valid values are `^REP-[0-9]{8,12}$`',
    `priority_level` STRING COMMENT 'Business priority assigned to the replenishment order: critical (NOS breach or stockout risk), high (below safety stock), normal (routine replenishment), low (opportunistic or consolidation).. Valid values are `critical|high|normal|low`',
    `received_quantity` DECIMAL(18,2) COMMENT 'The actual quantity of units received and confirmed at the destination location, may differ from shipped quantity due to transit loss or damage.',
    `reorder_point` DECIMAL(18,2) COMMENT 'The inventory level threshold at the destination location that triggered this replenishment order, calculated based on lead time demand and safety stock.',
    `replenishment_order_status` STRING COMMENT 'Current lifecycle status of the replenishment order: proposed (system-generated, awaiting review), approved (planner-approved), released (sent to WMS for execution), in_transit (shipment en route), received (goods received at destination), fulfilled (order complete), cancelled (order voided), rejected (approval denied). [ENUM-REF-CANDIDATE: proposed|approved|released|in_transit|received|fulfilled|cancelled|rejected — 8 candidates stripped; promote to reference product]',
    `replenishment_trigger` STRING COMMENT 'The business rule or condition that triggered this replenishment order: below reorder point, NOS (Never Out of Stock) breach, OTB (Open-to-Buy) driven, demand forecast, safety stock breach, or allocation plan execution.. Valid values are `below_reorder_point|nos_breach|otb_driven|demand_forecast|safety_stock_breach|allocation_plan`',
    `replenishment_type` STRING COMMENT 'Classification of how the replenishment order was initiated: automatic (system-triggered by min/max rules or MRP), manual (planner-initiated), VMI (Vendor Managed Inventory), emergency (expedited NOS breach), seasonal (collection-driven), or promotional (event-driven).. Valid values are `automatic|manual|vmi|emergency|seasonal|promotional`',
    `requested_delivery_date` DATE COMMENT 'The target date by which the destination location requires the replenished inventory to arrive, based on demand forecast or min/max rules.',
    `requested_quantity` DECIMAL(18,2) COMMENT 'The quantity of units requested by the replenishment algorithm or planner to bring inventory to target levels.',
    `safety_stock_level` DECIMAL(18,2) COMMENT 'The minimum inventory buffer maintained at the destination location to protect against demand variability and supply disruptions.',
    `service_level` STRING COMMENT 'The delivery speed commitment for the replenishment shipment: standard (5-7 days), expedited (2-3 days), next_day, two_day, economy (7-10 days).. Valid values are `standard|expedited|next_day|two_day|economy`',
    `shipment_method` STRING COMMENT 'The transportation mode used for the replenishment shipment: ground (truck), air (air freight), ocean (container ship), rail (train), intermodal (multi-mode), courier (express delivery).. Valid values are `ground|air|ocean|rail|intermodal|courier`',
    `shipped_quantity` DECIMAL(18,2) COMMENT 'The actual quantity of units shipped from the source location, may differ from approved quantity due to picking variances or stock adjustments.',
    `tracking_number` STRING COMMENT 'The carrier-provided tracking number for monitoring the shipment in transit.. Valid values are `^[A-Z0-9]{10,30}$`',
    `unit_of_measure` STRING COMMENT 'The unit in which quantities are expressed: EA (each/piece), CS (case), PK (pack), BX (box), PL (pallet).. Valid values are `EA|CS|PK|BX|PL`',
    CONSTRAINT pk_replenishment_order PRIMARY KEY(`replenishment_order_id`)
) COMMENT 'Operational record of store or DC replenishment requests generated by min/max rules, MRP, or demand-driven algorithms. Captures replenishment type (automatic, manual, VMI), source location, destination location, SKU, requested quantity, approved quantity, replenishment trigger (below reorder point, NOS breach, OTB-driven), status (proposed, approved, released, fulfilled), and expected delivery date.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`inventory`.`vmi_program` (
    `vmi_program_id` BIGINT COMMENT 'Unique identifier for the VMI program agreement. Primary key.',
    `merchandise_hierarchy_id` BIGINT COMMENT 'Foreign key linking to merchandising.merchandise_hierarchy. Business justification: VMI programs are defined by merchandise category (department/class). Essential for category-level VMI management, vendor collaboration by category, and merchandise hierarchy-based vendor performance t',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: VMI programs require dedicated program managers to coordinate vendor relationships, monitor SLA compliance, resolve discrepancies, and conduct performance reviews. Essential for accountability in vend',
    `season_id` BIGINT COMMENT 'Foreign key linking to merchandising.season. Business justification: VMI programs are often seasonal or have seasonal parameters in apparel. Essential for seasonal VMI planning, seasonal vendor collaboration, and aligning VMI with seasonal merchandise strategies.',
    `standard_id` BIGINT COMMENT 'Foreign key linking to quality.quality_standard. Business justification: VMI agreements specify quality standards vendors must meet for inventory they manage on behalf of the retailer. Defines inspection protocols, AQL levels, and compliance requirements in vendor contract',
    `supplier_factory_id` BIGINT COMMENT 'Foreign key linking to supplier.supplier_factory. Business justification: VMI programs often operate at specific factory level for capacity planning, direct shipments, and factory-specific inventory management agreements. Enables factory-level VMI performance monitoring and',
    `third_party_logistics_id` BIGINT COMMENT 'Foreign key linking to logistics.third_party_logistics. Business justification: VMI programs may use 3PL services. Linking enables VMI fulfillment cost analysis, 3PL performance in VMI context, service model optimization, and cost allocation—relevant for apparel VMI programs.',
    `vendor_id` BIGINT COMMENT 'Reference to the supplier responsible for managing inventory replenishment under this VMI agreement.',
    `warehouse_location_id` BIGINT COMMENT 'Foreign key linking to inventory.warehouse_location. Business justification: VMI programs operate at specific facilities/DCs with location-specific rules, vendor access control, and performance tracking. Link enables facility-level VMI configuration, vendor-managed stock posit',
    `wholesale_account_id` BIGINT COMMENT 'Foreign key linking to customer.wholesale_account. Business justification: VMI (Vendor-Managed Inventory) programs in apparel-fashion are contractual agreements with specific wholesale accounts (department stores, specialty retailers) where the vendor manages stock levels at',
    `auto_renewal_enabled` BOOLEAN COMMENT 'Indicates whether the VMI program agreement automatically renews at the end of its term unless terminated by either party.',
    `contract_document_reference` STRING COMMENT 'Reference identifier or file path to the legal contract document governing this VMI program agreement.',
    `cost_sharing_model` STRING COMMENT 'Model defining how inventory carrying costs, obsolescence risk, and markdowns are shared between supplier and retailer.. Valid values are `supplier_bears_all|shared_carrying_cost|retailer_bears_all|tiered`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this VMI program record was first created in the system.',
    `data_sharing_frequency` STRING COMMENT 'Frequency at which inventory position, sales, and forecast data are shared with the supplier through EDI or other integration methods.. Valid values are `real_time|hourly|daily|weekly`',
    `edi_integration_method` STRING COMMENT 'Method used for electronic exchange of inventory data with supplier. EDI 846 (Inventory Inquiry/Advice), EDI 852 (Product Activity Data), EDI 867 (Product Transfer and Resale Report), API (Application Programming Interface), portal (web-based), or manual file exchange.. Valid values are `edi_846|edi_852|edi_867|api|portal|manual`',
    `effective_end_date` DATE COMMENT 'Date when the VMI program agreement expires or is scheduled to terminate. Null for open-ended agreements.',
    `effective_start_date` DATE COMMENT 'Date when the VMI program agreement becomes active and supplier replenishment responsibility begins.',
    `facility_coverage` STRING COMMENT 'List of warehouse, distribution center, or retail store locations covered by this VMI program. May reference facility codes or location identifiers.',
    `financial_settlement_terms` STRING COMMENT 'Description of payment terms, pricing agreements, and financial settlement conditions between retailer and supplier for VMI inventory.',
    `forecast_sharing_enabled` BOOLEAN COMMENT 'Indicates whether demand forecasts are shared with the supplier to enable proactive replenishment planning.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this VMI program record was last updated.',
    `last_performance_review_date` DATE COMMENT 'Date of the most recent formal performance review conducted for this VMI program.',
    `markdown_responsibility` STRING COMMENT 'Party responsible for absorbing markdown costs when VMI inventory must be sold at reduced prices.. Valid values are `supplier|retailer|shared|negotiated_per_event`',
    `next_performance_review_date` DATE COMMENT 'Scheduled date for the next formal performance review of this VMI program.',
    `notes` STRING COMMENT 'Free-text field for additional notes, special conditions, or operational details about the VMI program.',
    `ownership_transfer_point` STRING COMMENT 'Point in the supply chain where inventory ownership transfers from supplier to retailer. Critical for consignment vs owned inventory models. FOB (Free on Board) terms define shipping responsibility.. Valid values are `at_receipt|at_sale|at_shipment|fob_origin|fob_destination`',
    `payment_terms_days` STRING COMMENT 'Number of days allowed for payment after invoice date or ownership transfer, depending on program terms.',
    `performance_review_frequency` STRING COMMENT 'Scheduled frequency for formal review of supplier performance against VMI program SLAs and KPIs.. Valid values are `monthly|quarterly|semi_annually|annually`',
    `primary_contact_email` STRING COMMENT 'Email address of the primary supplier contact for VMI program communications and issue resolution.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `primary_contact_name` STRING COMMENT 'Name of the primary supplier contact responsible for managing this VMI program.',
    `primary_contact_phone` STRING COMMENT 'Phone number of the primary supplier contact for urgent VMI program matters.',
    `program_code` STRING COMMENT 'Business identifier code for the VMI program, used in operational systems and supplier communications.. Valid values are `^VMI-[A-Z0-9]{6,12}$`',
    `program_name` STRING COMMENT 'Descriptive name of the VMI program for business reference and reporting.',
    `program_status` STRING COMMENT 'Current lifecycle status of the VMI program agreement.. Valid values are `draft|active|suspended|terminated|under_review`',
    `program_type` STRING COMMENT 'Classification of the VMI program model. Consignment means supplier owns inventory until sale; owned inventory means retailer owns upon receipt; hybrid combines both; NOS (Never Out of Stock) program focuses on continuous replenishment of basics; seasonal basics covers seasonal core items.. Valid values are `consignment|owned_inventory|hybrid|nos_program|seasonal_basics`',
    `replenishment_frequency` STRING COMMENT 'Scheduled frequency at which the supplier reviews inventory levels and initiates replenishment orders.. Valid values are `daily|weekly|biweekly|monthly|on_demand`',
    `replenishment_lead_time_days` STRING COMMENT 'Standard number of days from replenishment order placement to inventory receipt at destination facility.',
    `return_to_vendor_allowed` BOOLEAN COMMENT 'Indicates whether the retailer can return unsold or slow-moving VMI inventory back to the supplier.',
    `rfid_tracking_enabled` BOOLEAN COMMENT 'Indicates whether RFID technology is used for real-time inventory visibility and tracking within this VMI program.',
    `rtv_terms` STRING COMMENT 'Conditions and restrictions governing returns of VMI inventory to the supplier, including timeframes, restocking fees, and eligible reasons.',
    `scope_category` STRING COMMENT 'Product category or merchandise hierarchy level covered by this VMI program (e.g., Basic Tees, Denim Bottoms, Trims and Notions).',
    `scope_sku_list` STRING COMMENT 'Comma-separated list of specific SKUs included in the VMI program scope. Used when program covers specific items rather than entire categories.',
    `sla_fill_rate_target_pct` DECIMAL(18,2) COMMENT 'Target fill rate percentage that the supplier must achieve, representing the percentage of demand that must be fulfilled from available inventory.',
    `sla_lead_time_target_days` STRING COMMENT 'Maximum lead time in days that the supplier commits to for replenishment orders under this VMI program.',
    `sla_otif_target_pct` DECIMAL(18,2) COMMENT 'Target OTIF percentage that the supplier must achieve, representing orders delivered on time and complete.',
    `target_max_stock_level` DECIMAL(18,2) COMMENT 'Maximum inventory level (in units) that should not be exceeded to avoid overstock and carrying cost issues.',
    `target_min_stock_level` DECIMAL(18,2) COMMENT 'Minimum inventory level (in units) that the supplier must maintain to avoid stockouts. Triggers replenishment when inventory falls below this threshold.',
    `target_wos` DECIMAL(18,2) COMMENT 'Target inventory coverage expressed in weeks of supply based on forecasted demand. Used to calculate optimal stock levels.',
    `termination_notice_days` STRING COMMENT 'Number of days advance notice required by either party to terminate the VMI program agreement.',
    CONSTRAINT pk_vmi_program PRIMARY KEY(`vmi_program_id`)
) COMMENT 'Master record of Vendor Managed Inventory (VMI) agreements with suppliers for designated SKUs or categories. Captures agreement terms, supplier replenishment responsibility scope, target min/max stock levels, replenishment frequency, EDI integration method, performance SLAs (fill rate, lead time, OTIF), program status, and financial terms (consignment vs owned). Common in basics/NOS programs with key fabric and trim suppliers.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`inventory`.`nos_policy` (
    `nos_policy_id` BIGINT COMMENT 'Unique identifier for the Never Out of Stock policy record. Primary key.',
    `category_id` BIGINT COMMENT 'Reference to the product category covered by this NOS policy when policy applies at category level rather than individual SKU.',
    `employee_id` BIGINT COMMENT 'Reference to the employee or role responsible for maintaining and reviewing this NOS policy.',
    `otb_budget_id` BIGINT COMMENT 'Foreign key linking to merchandising.otb_budget. Business justification: NOS (Never Out of Stock) inventory is planned within OTB budgets. Essential for NOS budget allocation, ensuring NOS spending aligns with merchandise financial plans and OTB compliance.',
    `retail_store_id` BIGINT COMMENT 'Reference to the specific retail store where this NOS policy is enforced. Null indicates policy applies across all stores.',
    `season_id` BIGINT COMMENT 'Reference to the merchandise season during which this NOS policy is applicable, enabling seasonal NOS strategies.',
    `sku_id` BIGINT COMMENT 'Reference to the specific SKU designated under this NOS policy. Links to product master.',
    `standard_id` BIGINT COMMENT 'Foreign key linking to quality.quality_standard. Business justification: Never-out-of-stock policies reference quality standards to ensure only conforming inventory qualifies for priority replenishment and allocation. Prevents quality issues from compromising NOS service l',
    `vendor_id` BIGINT COMMENT 'Reference to the preferred supplier for replenishment under this NOS policy, enabling Vendor Managed Inventory (VMI) programs.',
    `warehouse_location_id` BIGINT COMMENT 'Reference to the specific warehouse or distribution center where this NOS policy is enforced. Null indicates policy applies across all facilities.',
    `allocation_priority_rank` STRING COMMENT 'Numeric ranking used to prioritize inventory allocation when multiple demands compete for limited stock. Lower numbers indicate higher priority.',
    `auto_replenishment_enabled` BOOLEAN COMMENT 'Indicates whether automated replenishment orders are generated when inventory falls below threshold without manual intervention.',
    `cost_per_unit` DECIMAL(18,2) COMMENT 'Standard unit cost used for inventory valuation and replenishment cost calculations under this NOS policy.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this NOS policy record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for cost and financial calculations associated with this NOS policy.. Valid values are `^[A-Z]{3}$`',
    `effective_end_date` DATE COMMENT 'Date when this NOS policy expires or is scheduled to be deactivated. Null indicates open-ended policy.',
    `effective_start_date` DATE COMMENT 'Date when this NOS policy becomes active and begins driving replenishment and allocation decisions.',
    `eligible_channel_dtc` BOOLEAN COMMENT 'Indicates whether this NOS policy applies to Direct-to-Consumer e-commerce channel.',
    `eligible_channel_marketplace` BOOLEAN COMMENT 'Indicates whether this NOS policy applies to third-party marketplace channel.',
    `eligible_channel_retail` BOOLEAN COMMENT 'Indicates whether this NOS policy applies to physical retail store channel.',
    `eligible_channel_wholesale` BOOLEAN COMMENT 'Indicates whether this NOS policy applies to wholesale distribution channel.',
    `geographic_scope` STRING COMMENT 'Defines the geographic coverage of this NOS policy, indicating whether it applies globally or to specific regions, countries, or locations.. Valid values are `global|regional|country|store_group|single_location`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this NOS policy record was last updated or modified.',
    `last_review_date` DATE COMMENT 'Date when this NOS policy was last reviewed and validated by the policy owner.',
    `lead_time_days` STRING COMMENT 'Expected number of days from replenishment order placement to inventory receipt, used to calculate reorder points.',
    `max_order_quantity` DECIMAL(18,2) COMMENT 'Maximum quantity that can be ordered in a single replenishment transaction under this NOS policy.',
    `minimum_floor_stock_quantity` DECIMAL(18,2) COMMENT 'The absolute minimum inventory quantity that must be maintained at all times to prevent stockouts. Triggers immediate replenishment when breached.',
    `moq` DECIMAL(18,2) COMMENT 'Minimum order quantity required by supplier for replenishment orders under this NOS policy.',
    `next_review_date` DATE COMMENT 'Date when this NOS policy is scheduled for next review and validation.',
    `nos_tier` STRING COMMENT 'Classification tier indicating priority level of the NOS policy. Platinum represents highest priority items requiring maximum availability.. Valid values are `platinum|gold|silver|bronze`',
    `order_multiple` DECIMAL(18,2) COMMENT 'Quantity increment in which replenishment orders must be placed (e.g., case packs, pallet quantities).',
    `policy_code` STRING COMMENT 'Business identifier for the NOS policy, used for external reference and reporting.. Valid values are `^NOS-[A-Z0-9]{6,12}$`',
    `policy_description` STRING COMMENT 'Detailed description of the NOS policy purpose, scope, and business rationale.',
    `policy_name` STRING COMMENT 'Descriptive name of the NOS policy for business user identification.',
    `policy_notes` STRING COMMENT 'Free-form text field for additional notes, special instructions, or business context related to this NOS policy.',
    `policy_status` STRING COMMENT 'Current lifecycle status of the NOS policy indicating whether it is actively enforced in replenishment and allocation systems.. Valid values are `active|inactive|suspended|pending_review|expired`',
    `priority_replenishment_flag` BOOLEAN COMMENT 'Indicates whether this NOS policy triggers priority replenishment processing, bypassing standard allocation queues.',
    `review_frequency_days` STRING COMMENT 'Number of days between scheduled reviews of this NOS policy to assess continued relevance and parameter accuracy.',
    `rfid_tracking_required` BOOLEAN COMMENT 'Indicates whether items under this NOS policy require RFID tracking for real-time inventory visibility and accuracy.',
    `safety_stock_multiplier` DECIMAL(18,2) COMMENT 'Multiplier applied to base safety stock calculation to determine buffer inventory levels for NOS items. Higher values provide greater protection against demand variability.',
    `target_wos` DECIMAL(18,2) COMMENT 'Target inventory coverage expressed in weeks of supply. Represents the desired inventory level to maintain continuous availability.',
    `vmi_program_flag` BOOLEAN COMMENT 'Indicates whether this NOS policy is part of a Vendor Managed Inventory program where the supplier monitors and replenishes stock.',
    CONSTRAINT pk_nos_policy PRIMARY KEY(`nos_policy_id`)
) COMMENT 'Reference master defining Never Out of Stock (NOS) policies for designated SKUs or product categories. Captures NOS classification tier, minimum floor stock quantity, safety stock multiplier, priority replenishment flag, eligible channels (DTC, wholesale, retail), review frequency, and policy owner. Drives automated replenishment triggers and allocation priority rules.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`inventory`.`reservation` (
    `reservation_id` BIGINT COMMENT 'Unique identifier for the inventory reservation record. Primary key for the inventory reservation entity.',
    `allocation_id` BIGINT COMMENT 'Reference to the allocation record if this reservation has been converted to a physical allocation. Null while reservation is still pending or active.',
    `cart_id` BIGINT COMMENT 'Foreign key linking to ecommerce.cart. Business justification: When customers add high-demand apparel items to cart, inventory is soft-reserved to prevent overselling. Business process: cart-to-inventory reservation, ATS calculation, and abandoned cart inventory ',
    `checkout_session_id` BIGINT COMMENT 'Foreign key linking to ecommerce.checkout_session. Business justification: Hard reservations are created during checkout to hold inventory while payment is processed. Business process: checkout inventory hold, payment-to-fulfillment handoff, and reservation expiry management',
    `digital_order_id` BIGINT COMMENT 'Foreign key linking to ecommerce.digital_order. Business justification: Final reservations are converted to committed allocations when digital order is placed. Business process: order-to-fulfillment inventory commitment, reservation-to-shipment tracking, and inventory acc',
    `profile_id` BIGINT COMMENT 'Reference to the customer or wholesale account for whom inventory is reserved. Null for non-customer reservations such as photo shoots or events.',
    `retail_store_id` BIGINT COMMENT 'Foreign key linking to store.retail_store. Business justification: BOPIS and ship-from-store inventory reservations must link to fulfilling retail store for omnichannel allocation, store fulfillment capacity planning, and store-level ATP calculation - critical for un',
    `sales_order_id` BIGINT COMMENT 'Reference to the sales order, purchase order, or wholesale order that triggered this reservation. Null for non-order reservations such as event holds or sample pulls.',
    `sales_order_line_id` BIGINT COMMENT 'Foreign key linking to order.sales_order_line. Business justification: Reservations must link to specific order line (not just header) for line-level ATP confirmation, multi-line order partial fulfillment, SKU-level allocation accuracy, and line-item cancellation handlin',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: ATP allocation rules require product.sku attributes: lifecycle_stage (prioritize core vs. seasonal), ats_flag, nos_flag, and product_category for channel-specific reservation priority logic. String sk',
    `warehouse_location_id` BIGINT COMMENT 'Identifier of the warehouse, distribution center, retail store, or Third-Party Logistics (3PL) facility where the inventory is reserved.',
    `cancellation_reason` STRING COMMENT 'Standardized reason code for reservation cancellation: CUSTOMER_CANCEL (customer-initiated), CART_ABANDON (ecommerce cart timeout), INVENTORY_UNAVAILABLE (stock discrepancy), ORDER_MODIFY (order change), SYSTEM_ERROR (technical issue), BUSINESS_RULE (policy-driven cancellation).. Valid values are `CUSTOMER_CANCEL|CART_ABANDON|INVENTORY_UNAVAILABLE|ORDER_MODIFY|SYSTEM_ERROR|BUSINESS_RULE`',
    `cancelled_timestamp` TIMESTAMP COMMENT 'Date and time when the reservation was cancelled and inventory released. Null if reservation was not cancelled.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this reservation record was first inserted into the data platform. Supports data lineage and audit requirements.',
    `expiry_timestamp` TIMESTAMP COMMENT 'Date and time when the reservation will automatically expire and release inventory back to Available to Sell (ATS) pool if not fulfilled or extended.',
    `extended_count` STRING COMMENT 'Number of times the reservation expiry has been extended beyond the original expiry timestamp. Used to track reservation aging and potential inventory lock issues.',
    `fulfilled_timestamp` TIMESTAMP COMMENT 'Date and time when the reservation was converted to a physical allocation and inventory was committed for shipment or pickup. Null if not yet fulfilled.',
    `fulfillment_channel` STRING COMMENT 'Sales and fulfillment channel for which inventory is reserved: ecommerce (online direct-to-consumer), retail_store (brick-and-mortar), wholesale (B2B partner), marketplace (third-party platform), bopis (buy online pick up in store), ship_from_store (store fulfillment for online orders).. Valid values are `ecommerce|retail_store|wholesale|marketplace|bopis|ship_from_store`',
    `hard_reservation_flag` BOOLEAN COMMENT 'Indicates whether this is a hard reservation (true - guaranteed allocation, cannot be overridden) or soft reservation (false - tentative hold, can be reallocated based on priority).',
    `last_extended_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent reservation expiry extension. Null if reservation has never been extended.',
    `last_updated_by` STRING COMMENT 'User identifier or system account that last modified the reservation record. Supports change tracking and audit trail.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'System timestamp when this reservation record was last modified in the data platform. Supports change tracking and data freshness monitoring.',
    `notes` STRING COMMENT 'Free-text field for additional context, special instructions, or business justification for the reservation.',
    `priority` STRING COMMENT 'Numeric priority rank determining allocation sequence when multiple reservations compete for limited inventory. Lower numbers indicate higher priority.',
    `reason_code` STRING COMMENT 'Standardized code indicating the business reason for the reservation: CUSTOMER_ORDER (committed customer purchase), CART_HOLD (ecommerce shopping cart), WHOLESALE_COMMIT (B2B partner commitment), EVENT_RESERVE (marketing or promotional event), PHOTO_SHOOT (content creation), SAMPLE_REQUEST (product sampling).. Valid values are `CUSTOMER_ORDER|CART_HOLD|WHOLESALE_COMMIT|EVENT_RESERVE|PHOTO_SHOOT|SAMPLE_REQUEST`',
    `released_timestamp` TIMESTAMP COMMENT 'Date and time when the reservation was released and inventory returned to the Available to Sell (ATS) pool. Null if reservation is still active.',
    `reservation_number` STRING COMMENT 'Business-facing unique reservation number used for tracking and reference across systems and channels.. Valid values are `^RES-[0-9]{10}$`',
    `reservation_status` STRING COMMENT 'Current lifecycle state of the reservation: active (currently holding inventory), expired (reservation period elapsed), released (inventory returned to available pool), fulfilled (reservation converted to allocation), cancelled (reservation voided), pending (awaiting confirmation).. Valid values are `active|expired|released|fulfilled|cancelled|pending`',
    `reservation_timestamp` TIMESTAMP COMMENT 'Date and time when the inventory reservation was created in the system. Represents the business event time when stock was earmarked.',
    `reservation_type` STRING COMMENT 'Classification of the reservation purpose: sales order (committed to customer order), ecommerce cart (held in online shopping cart), wholesale commitment (allocated to wholesale partner), event_hold (reserved for marketing or promotional event), photo_shoot_hold (reserved for photography or content creation), sample_pull (reserved for product sampling or showroom).. Valid values are `sales_order|ecommerce_cart|wholesale_commitment|event_hold|photo_shoot_hold|sample_pull`',
    `reserved_quantity` DECIMAL(18,2) COMMENT 'Number of units earmarked under this reservation. Reduces Available to Sell (ATS) but not Available to Promise (ATP) until allocation occurs.',
    `sku` STRING COMMENT 'Unique product identifier at the style-color-size level representing the specific item variant being reserved.. Valid values are `^[A-Z0-9]{8,15}$`',
    `source_system` STRING COMMENT 'Originating system that created the reservation: SAP_SD (SAP Sales & Distribution), SFCC (Salesforce Commerce Cloud), OMS (Order Management System), WMS (Warehouse Management System), POS (Point of Sale), WHOLESALE_PORTAL (B2B ordering portal).. Valid values are `SAP_SD|SFCC|OMS|WMS|POS|WHOLESALE_PORTAL`',
    `source_transaction_reference` STRING COMMENT 'Unique transaction identifier from the source system that initiated this reservation, enabling end-to-end traceability.',
    `unit_of_measure` STRING COMMENT 'Unit in which the reserved quantity is expressed: EA (each/piece), PR (pair for footwear), DZ (dozen), CS (case), PK (pack).. Valid values are `EA|PR|DZ|CS|PK`',
    `created_by` STRING COMMENT 'User identifier or system account that created the reservation record. Supports audit trail and accountability.',
    CONSTRAINT pk_reservation PRIMARY KEY(`reservation_id`)
) COMMENT 'Transactional record of inventory reservations that earmark stock for specific orders, channels, or events before physical allocation. Captures reservation type (sales order, e-commerce cart, wholesale commitment, event hold, photo shoot hold, sample pull, trunk show), reserved quantity, reservation expiry timestamp, priority rank, fulfillment channel, and soft vs hard reservation indicator. Feeds ATS and ATP calculations across omnichannel fulfillment.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`inventory`.`stock_valuation` (
    `stock_valuation_id` BIGINT COMMENT 'Unique identifier for the stock valuation record.',
    `incident_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_incident. Business justification: Compliance incidents (product recalls, safety violations, regulatory penalties) directly impact inventory valuation through write-downs, obsolescence reserves, and net realizable value adjustments. Re',
    `merchandise_hierarchy_id` BIGINT COMMENT 'Foreign key linking to merchandising.merchandise_hierarchy. Business justification: Valuation reporting is organized by merchandise hierarchy (department/class/subclass). Essential for category-level inventory valuation reporting, financial analysis by category, and merchandise hiera',
    `non_conformance_id` BIGINT COMMENT 'Foreign key linking to quality.non_conformance. Business justification: Non-conformances drive inventory write-downs, markdown reserves, and aged inventory provisions. Links quality issues to financial impact for accurate inventory valuation, COGS allocation, and financia',
    `otb_budget_id` BIGINT COMMENT 'Foreign key linking to merchandising.otb_budget. Business justification: Inventory valuation is monitored against OTB budgets for financial planning. Essential for inventory financial planning, OTB variance analysis, and ensuring inventory value aligns with merchandise bud',
    `retail_store_id` BIGINT COMMENT 'Foreign key linking to store.retail_store. Business justification: Store-level inventory valuation is required for store P&L reporting, shrinkage reserve calculation, markdown impact analysis, and financial statement preparation by retail location - fundamental to re',
    `season_id` BIGINT COMMENT 'Identifier for the fashion season or collection to which this inventory belongs (e.g., Spring/Summer 2024, Fall/Winter 2024). Critical for seasonal lifecycle valuation.',
    `sku_id` BIGINT COMMENT 'Identifier for the SKU being valued. Links to the product master.',
    `sourcing_purchase_order_id` BIGINT COMMENT 'Foreign key linking to sourcing.sourcing_purchase_order. Business justification: Landed cost valuation for materials requires sourcing PO reference to allocate freight, duty, and agent commissions. Critical for accurate COGS calculation and margin analysis in apparel costing.',
    `valuation_area_id` BIGINT COMMENT 'Identifier for the valuation area (plant, warehouse, distribution center, or store) where inventory is valued. Links to location master.',
    `aged_inventory_provision` DECIMAL(18,2) COMMENT 'Provision amount for obsolete, slow-moving, or aged inventory that may not be sold at full value. Reflects inventory obsolescence risk.',
    `cogs_allocation_amount` DECIMAL(18,2) COMMENT 'Portion of inventory value allocated to COGS for goods sold during the period. Used for profit and loss calculation.',
    `cost_center_code` STRING COMMENT 'Cost center responsible for managing this inventory (e.g., warehouse operations, retail store). Used for management accounting.. Valid values are `^[A-Z0-9]{4,10}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this valuation record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this valuation record (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `current_unit_cost` DECIMAL(18,2) COMMENT 'The effective unit cost currently applied for valuation, based on the valuation method in use (standard cost or moving average price).',
    `fiscal_period` STRING COMMENT 'Fiscal period (month) within the fiscal year (1-12) to which this valuation record belongs.',
    `fiscal_year` STRING COMMENT 'Fiscal year to which this valuation record belongs (e.g., 2024).',
    `gl_account_number` STRING COMMENT 'General Ledger account number to which this inventory valuation is posted for balance sheet reporting.. Valid values are `^[0-9]{4,10}$`',
    `inventory_turnover_days` STRING COMMENT 'Average number of days inventory remains in stock before being sold. Calculated as (average inventory value / COGS) × 365. Key metric for inventory efficiency.',
    `inventory_write_down_amount` DECIMAL(18,2) COMMENT 'Total amount written down from book value to net realizable value when NRV is lower than cost. Impacts Cost of Goods Sold (COGS) and profitability.',
    `last_cost_update_date` DATE COMMENT 'Date when the unit cost (standard cost or moving average price) was last updated or recalculated.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this valuation record was last updated or adjusted.',
    `last_physical_count_date` DATE COMMENT 'Date of the most recent physical inventory count or cycle count for this SKU at this valuation area. Used to assess valuation accuracy.',
    `lifecycle_stage` STRING COMMENT 'Current stage in the product lifecycle: pre-season (not yet selling), in-season (active selling), end-of-season (markdown phase), clearance (deep discount), obsolete (no longer saleable).. Valid values are `pre_season|in_season|end_of_season|clearance|obsolete`',
    `markdown_reserve_amount` DECIMAL(18,2) COMMENT 'Reserve amount set aside to account for anticipated future markdowns on seasonal or slow-moving inventory. Reduces net realizable value.',
    `markdown_reserve_percentage` DECIMAL(18,2) COMMENT 'Percentage of total stock value reserved for anticipated markdowns, typically based on historical markdown rates and seasonal lifecycle stage.',
    `moving_average_price` DECIMAL(18,2) COMMENT 'Weighted average unit cost recalculated with each goods receipt when moving average valuation method is used.',
    `net_realizable_value` DECIMAL(18,2) COMMENT 'Estimated selling price in the ordinary course of business less estimated costs of completion and sale. Inventory must be valued at lower of cost or NRV.',
    `price_variance_amount` DECIMAL(18,2) COMMENT 'Difference between standard cost and actual purchase price for goods received. Tracked separately in standard costing environments.',
    `profit_center_code` STRING COMMENT 'Profit center to which this inventory valuation is attributed for profitability analysis (e.g., product line, brand, region).. Valid values are `^[A-Z0-9]{4,10}$`',
    `seasonal_write_down_percentage` DECIMAL(18,2) COMMENT 'Percentage write-down applied to inventory value for end-of-season or aged seasonal merchandise to reflect lower net realizable value.',
    `standard_cost` DECIMAL(18,2) COMMENT 'Predetermined unit cost used for valuation when standard costing method is applied. Includes material, labor, and overhead components.',
    `total_stock_quantity` DECIMAL(18,2) COMMENT 'Total quantity of inventory on hand at the valuation area for this SKU at the valuation date.',
    `total_stock_value` DECIMAL(18,2) COMMENT 'Total book value of inventory calculated as total stock quantity multiplied by current unit cost. Represents balance sheet inventory value.',
    `valuation_adjustment_reason` STRING COMMENT 'Free-text explanation for any manual adjustment made to the valuation (e.g., physical count variance, damage, theft, pricing error).',
    `valuation_class` STRING COMMENT 'Classification code used for grouping materials for accounting purposes (e.g., finished goods, raw materials, trading goods). Maps to General Ledger (GL) accounts.. Valid values are `^[A-Z0-9]{4,10}$`',
    `valuation_date` DATE COMMENT 'The date on which this valuation snapshot was taken. Typically end-of-month (EOM) or end-of-season for financial reporting.',
    `valuation_status` STRING COMMENT 'Current status of the valuation record: active (current), frozen (locked for period close), adjusted (manual adjustment applied), written_off (inventory disposed), under_review (pending audit).. Valid values are `active|frozen|adjusted|written_off|under_review`',
    `valuation_type` STRING COMMENT 'Method used to value inventory: standard cost (predetermined cost), moving average (weighted average of purchases), FIFO (First In First Out), LIFO (Last In First Out), or retail method (cost-to-retail ratio).. Valid values are `standard_cost|moving_average|fifo|lifo|retail_method`',
    `weeks_of_supply` DECIMAL(18,2) COMMENT 'Number of weeks the current inventory level will last based on forecasted or historical sales rate. Critical for replenishment planning.',
    CONSTRAINT pk_stock_valuation PRIMARY KEY(`stock_valuation_id`)
) COMMENT 'Master record of inventory valuation parameters and current book value for each SKU at each valuation area. Captures valuation method (standard cost, moving average, FIFO), standard cost, moving average price, total stock value, last valuation date, currency, valuation class, markdown reserve, seasonal write-down percentage, and aged inventory provision. Supports COGS calculation, balance sheet inventory reporting, end-of-season markdown accounting, and inventory obsolescence provisioning critical for fashions seasonal lifecycle.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`inventory`.`quarantine_hold` (
    `quarantine_hold_id` BIGINT COMMENT 'Unique identifier for the quarantine hold record. Primary key.',
    `digital_return_id` BIGINT COMMENT 'Foreign key linking to ecommerce.digital_return. Business justification: Returned apparel items from ecommerce often go into quarantine for quality inspection before restocking. Business process: return quality control, disposition decision (restock/markdown/RTV), and cust',
    `incident_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_incident. Business justification: Quarantine holds triggered by compliance violations (failed safety tests, restricted substance detection, labeling errors) must link to formal compliance incidents for regulatory reporting, investigat',
    `lot_batch_id` BIGINT COMMENT 'Foreign key linking to inventory.lot_batch. Business justification: Quarantine holds are often applied to entire production lots/batches (e.g., dye-lot quality issues). quarantine_hold has lot_number string but no FK to lot_batch master. Adding lot_batch_id FK enables',
    `non_conformance_id` BIGINT COMMENT 'Foreign key linking to quality.non_conformance. Business justification: Quarantine holds are initiated by non-conformance reports documenting root cause, severity, and corrective action requirements. Complements existing inspection FK by linking to formal NCR for disposit',
    `product_safety_test_id` BIGINT COMMENT 'Foreign key linking to compliance.product_safety_test. Business justification: Quality teams quarantine inventory based on failed safety test results. Direct link to the specific test that triggered the hold is essential for disposition decisions, retest planning, and vendor acc',
    `quality_hold_id` BIGINT COMMENT 'Foreign key linking to quality.quality_hold. Business justification: Cross-references inventory quarantine records with quality hold records for synchronized disposition management. Quality holds may exist independently in QMS; this link ensures WMS and QMS remain alig',
    `inspection_id` BIGINT COMMENT 'Reference to the quality inspection record that identified the issue leading to quarantine hold.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Quarantine disposition decisions (release, rework, scrap) require quality manager approval for compliance and financial control. Critical for defect tracking, vendor chargebacks, and regulatory compli',
    `retail_store_id` BIGINT COMMENT 'Foreign key linking to store.retail_store. Business justification: Quality holds at store level (damaged goods, customer returns awaiting disposition, quality defects) must track which retail store holds the inventory for disposition workflow, RTV processing, and sto',
    `rfid_tag_id` BIGINT COMMENT 'RFID tag identifier associated with the quarantined inventory for tracking purposes.',
    `shipment_id` BIGINT COMMENT 'Foreign key linking to logistics.logistics_shipment. Business justification: Quality holds may originate from shipment inspection. Linking enables supplier quality trending by shipment, customs hold analysis, landed quality metrics, and root cause investigation—standard appare',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: Quality disposition decisions require product.sku material_composition, safety_certification, sustainability_certification, and care_instructions to determine regulatory compliance, rework feasibility',
    `sourcing_purchase_order_id` BIGINT COMMENT 'Foreign key linking to sourcing.sourcing_purchase_order. Business justification: Quality holds on inbound materials require linkage to sourcing PO for vendor chargeback, RTV processing, and supplier quality rating. Essential for apparel quality management and vendor performance tr',
    `stock_position_id` BIGINT COMMENT 'Reference to the inventory record that is under quarantine or quality hold.',
    `vendor_id` BIGINT COMMENT 'Reference to the supplier who provided the inventory under quarantine hold.',
    `warehouse_location_id` BIGINT COMMENT 'Reference to the warehouse, distribution center, retail store, or 3PL facility where the quarantined inventory is physically located.',
    `work_order_id` BIGINT COMMENT 'Foreign key linking to production.work_order. Business justification: Quality holds on production output must link to originating work order for factory accountability, root cause analysis, claim processing, and corrective action tracking. Essential for apparel quality ',
    `actual_release_date` DATE COMMENT 'The actual date when the quarantine hold was resolved and disposition decision was executed.',
    `actual_release_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the quarantine hold was resolved, including time of day.',
    `compliance_flag` BOOLEAN COMMENT 'Boolean indicator whether the quarantine hold is related to regulatory compliance or safety standards violation.',
    `corrective_action_reference` STRING COMMENT 'Reference number or identifier of the corrective action plan associated with this quarantine hold.',
    `corrective_action_required` BOOLEAN COMMENT 'Boolean indicator whether corrective action is required to prevent recurrence of the issue.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the quarantine hold record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the estimated financial impact.. Valid values are `USD|EUR|GBP|JPY|CNY|CAD`',
    `customer_impact_flag` BOOLEAN COMMENT 'Boolean indicator whether the quarantine hold affects customer orders or shipments.',
    `disposition_approved_by` STRING COMMENT 'Name or identifier of the person who approved the final disposition decision.',
    `disposition_decision` STRING COMMENT 'Final decision on how to handle the quarantined inventory (return to stock, RTV=Return to Vendor, destroy, rework, donate, transfer to another location).. Valid values are `return_to_stock|rtv|destroy|rework|donate|transfer`',
    `disposition_notes` STRING COMMENT 'Additional notes or comments regarding the disposition decision and execution.',
    `estimated_financial_impact` DECIMAL(18,2) COMMENT 'Estimated financial impact or cost associated with the quarantine hold, including potential loss of inventory value.',
    `expected_release_date` DATE COMMENT 'Anticipated date when the quarantine hold will be resolved and inventory may be released or disposed.',
    `hold_approved_by` STRING COMMENT 'Name or identifier of the quality manager or authorized person who approved the quarantine hold.',
    `hold_initiated_by` STRING COMMENT 'Name or identifier of the person, system, or department that initiated the quarantine hold.',
    `hold_quantity` DECIMAL(18,2) COMMENT 'The quantity of inventory units placed under quarantine hold.',
    `hold_quantity_uom` STRING COMMENT 'Unit of measure for the hold quantity (EA=Each, CS=Case, PL=Pallet, CTN=Carton, PR=Pair).. Valid values are `EA|CS|PL|CTN|PR`',
    `hold_reason_code` STRING COMMENT 'Categorical code indicating the primary reason for placing inventory under quarantine hold.. Valid values are `quality_failure|regulatory_hold|customs_inspection|product_recall|damage|supplier_defect`',
    `hold_reason_description` STRING COMMENT 'Detailed narrative explanation of why the inventory was placed under quarantine or quality hold.',
    `hold_start_date` DATE COMMENT 'The date when the quarantine hold was initiated and inventory was blocked from sale or shipment.',
    `hold_start_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the quarantine hold was initiated, including time of day.',
    `hold_status` STRING COMMENT 'Current lifecycle status of the quarantine hold record.. Valid values are `active|pending_review|released|disposed`',
    `initiating_event_reference` STRING COMMENT 'Reference number or identifier of the event that triggered the quarantine hold (e.g., quality inspection ID, recall notice number, complaint ticket number).',
    `initiating_event_type` STRING COMMENT 'Type of event that triggered the quarantine hold (quality inspection failure, supplier defect notification, CPSC recall, customer complaint, internal audit finding, customs flag).. Valid values are `quality_inspection|supplier_defect|cpsc_recall|customer_complaint|internal_audit|customs_flag`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the quarantine hold record was last updated or modified.',
    `notes` STRING COMMENT 'General notes or comments field for additional information about the quarantine hold.',
    `po_number` STRING COMMENT 'Purchase order number associated with the quarantined inventory.',
    `priority_level` STRING COMMENT 'Priority level assigned to the quarantine hold for resolution urgency (critical, high, medium, low).. Valid values are `critical|high|medium|low`',
    `recall_flag` BOOLEAN COMMENT 'Boolean indicator whether the quarantine hold is part of a product recall event.',
    `regulatory_authority` STRING COMMENT 'Name of the regulatory body involved in the hold (e.g., CPSC, FTC, Customs) if the hold is regulatory in nature.',
    `regulatory_reference_number` STRING COMMENT 'Official reference number or case number from the regulatory authority related to the hold.',
    `root_cause_analysis_completed` BOOLEAN COMMENT 'Boolean indicator whether root cause analysis has been completed for the issue that triggered the quarantine hold.',
    `serial_number` STRING COMMENT 'Unique serial number of the quarantined inventory item, if applicable.',
    `sku` STRING COMMENT 'The SKU code of the product under quarantine hold.',
    CONSTRAINT pk_quarantine_hold PRIMARY KEY(`quarantine_hold_id`)
) COMMENT 'Operational record of inventory placed under quarantine or quality hold status, preventing it from being sold or shipped. Captures hold reason (quality failure, regulatory hold, customs inspection, recall, damage), hold quantity, hold location, initiating event reference (quality inspection, supplier defect, CPSC recall), hold start date, expected release date, and disposition decision (return to stock, RTV, destroy).';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`inventory`.`asn` (
    `asn_id` BIGINT COMMENT 'Unique identifier for the advance shipment notice record.',
    `warehouse_location_id` BIGINT COMMENT 'Identifier of the destination location (distribution center, warehouse, retail store, or 3PL) where goods will be received.',
    `asn_warehouse_location_id` BIGINT COMMENT 'Identifier of the origin location (supplier facility, factory, warehouse, or 3PL) from which goods are shipped.',
    `bill_of_lading_id` BIGINT COMMENT 'Foreign key linking to logistics.bill_of_lading. Business justification: Inbound shipments documented on BOLs. Linking enables receiving document validation, freight claim filing, carrier liability determination, and shipment traceability—fundamental apparel receiving oper',
    `carbon_emission_id` BIGINT COMMENT 'Foreign key linking to sustainability.carbon_emission. Business justification: Inbound shipments (ASNs) are primary scope 3 emission sources. ASN-to-emission linkage enables carbon accounting per shipment, carrier performance benchmarking, and modal shift analysis for decarboniz',
    `customs_entry_id` BIGINT COMMENT 'Foreign key linking to logistics.customs_entry. Business justification: Imported ASNs tied to customs filings. Linking enables pre-clearance planning, ISF compliance validation, customs hold impact analysis, and entry-level traceability—critical for apparel trade complian',
    `order_purchase_order_id` BIGINT COMMENT 'Reference to the purchase order that this ASN fulfills.',
    `packing_list_id` BIGINT COMMENT 'Foreign key linking to logistics.packing_list. Business justification: ASN contains packing list details. Linking enables receiving validation (expected vs. actual), carton-level traceability, receiving productivity measurement (scan vs. manual), and vendor compliance sc',
    `inspection_id` BIGINT COMMENT 'Foreign key linking to quality.inspection. Business justification: ASNs reference pre-shipment inspections conducted at supplier/factory before goods ship. Enables receiving teams to verify inspection completion, expedite receipt processing, and flag discrepancies be',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: ASN receiving operations require supervisor assignment for dock door coordination, labor allocation, and exception handling. Critical for receiving performance metrics, labor productivity tracking, an',
    `distribution_center_id` BIGINT COMMENT 'Foreign key linking to logistics.distribution_center. Business justification: ASN destination is the receiving DC. Role-prefixed to distinguish from origin. Enables dock appointment scheduling, labor planning, inbound volume forecasting, and DC capacity management—critical for ',
    `retail_store_id` BIGINT COMMENT 'Foreign key linking to store.retail_store. Business justification: Store-bound advance ship notices must identify destination retail store for receiving appointment scheduling, dock door assignment, labor planning, and inbound logistics coordination at store receivin',
    `shipment_id` BIGINT COMMENT 'Foreign key linking to logistics.logistics_shipment. Business justification: ASN is advance notice of inbound shipment. Linking enables receiving variance analysis (expected vs. actual), dock scheduling optimization, carrier performance tracking, and OTIF measurement—standard ',
    `sourcing_purchase_order_id` BIGINT COMMENT 'Foreign key linking to sourcing.sourcing_purchase_order. Business justification: ASNs for inbound materials/fabrics from suppliers reference the originating sourcing PO. Required for receiving planning, dock scheduling, and 3-way match validation in apparel material procurement.',
    `supplier_factory_id` BIGINT COMMENT 'Foreign key linking to supplier.supplier_factory. Business justification: ASNs originate from specific factories for shipment tracking, dock scheduling, factory performance monitoring, and logistics planning. Role-prefixed as origin_factory_id to distinguish from ship_from_',
    `third_party_logistics_id` BIGINT COMMENT 'Foreign key linking to logistics.third_party_logistics. Business justification: 3PL-managed inbound shipments. Linking enables 3PL receiving performance measurement, SLA compliance tracking, cost allocation, and service level validation—standard for apparel brands using 3PL recei',
    `trade_compliance_record_id` BIGINT COMMENT 'Foreign key linking to compliance.trade_compliance_record. Business justification: Every inbound international shipment requires trade compliance validation (HS code classification, duty rates, country of origin determination) for customs clearance. ASN links to trade compliance rec',
    `vendor_id` BIGINT COMMENT 'Identifier of the supplier, factory, or 3PL sending the shipment.',
    `work_order_id` BIGINT COMMENT 'Foreign key linking to production.work_order. Business justification: Advanced ship notices for finished goods from factories reference originating work order for pre-receipt validation, dock scheduling, and customs documentation. Enables matching ASN to production orde',
    `acknowledged_timestamp` TIMESTAMP COMMENT 'Date and time when the ASN was acknowledged by the receiving system or warehouse management system.',
    `actual_arrival_date` DATE COMMENT 'Actual date when the shipment physically arrived at the destination location.',
    `appointment_date` TIMESTAMP COMMENT 'Scheduled date and time for the shipment to be received at the destination facility.',
    `asn_number` STRING COMMENT 'Externally-known unique business identifier for the advance shipment notice, typically provided by supplier or 3PL.. Valid values are `^[A-Z0-9]{8,20}$`',
    `asn_status` STRING COMMENT 'Current lifecycle status of the ASN in the receiving workflow. [ENUM-REF-CANDIDATE: draft|transmitted|acknowledged|in_transit|arrived|receiving|received|cancelled — 8 candidates stripped; promote to reference product]',
    `asn_type` STRING COMMENT 'Classification of the ASN based on shipment purpose and origin.. Valid values are `standard|drop_ship|transfer|return|sample`',
    `carrier_name` STRING COMMENT 'Name of the shipping carrier or logistics provider transporting the goods.',
    `carrier_service_level` STRING COMMENT 'Service level or shipping method used by the carrier (e.g., ground, express, air freight, ocean freight).',
    `commercial_invoice_number` STRING COMMENT 'Commercial invoice number associated with this shipment for customs and payment reconciliation.',
    `container_number` STRING COMMENT 'Shipping container identification number for ocean or intermodal freight.',
    `country_of_origin` STRING COMMENT 'Three-letter ISO country code representing the country where the goods were manufactured or produced.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this ASN record was first created in the system.',
    `customs_value_amount` DECIMAL(18,2) COMMENT 'Declared customs value of the shipment for duty and tax calculation purposes.',
    `customs_value_currency_code` STRING COMMENT 'Three-letter ISO currency code for the customs value amount.. Valid values are `^[A-Z]{3}$`',
    `dock_door_assignment` STRING COMMENT 'Assigned dock door or bay number at the receiving facility for unloading this shipment.',
    `expected_arrival_date` DATE COMMENT 'Anticipated date when the shipment will arrive at the destination location for receiving.',
    `hs_code` STRING COMMENT 'Harmonized System code for customs classification and duty calculation of the goods.. Valid values are `^[0-9]{6,10}$`',
    `incoterm` STRING COMMENT 'International commercial term defining the responsibilities and costs between buyer and seller for this shipment. [ENUM-REF-CANDIDATE: EXW|FCA|CPT|CIP|DAP|DPU|DDP|FAS|FOB|CFR|CIF — 11 candidates stripped; promote to reference product]',
    `is_hazmat` BOOLEAN COMMENT 'Flag indicating whether the shipment contains hazardous materials requiring special handling and compliance.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this ASN record was last updated or modified.',
    `priority_level` STRING COMMENT 'Priority classification for receiving and processing this ASN shipment.. Valid values are `standard|high|urgent|critical`',
    `receiving_completed_timestamp` TIMESTAMP COMMENT 'Date and time when physical receiving of the shipment was completed and goods were put away.',
    `receiving_started_timestamp` TIMESTAMP COMMENT 'Date and time when physical receiving of the shipment began at the destination facility.',
    `rfid_enabled_flag` BOOLEAN COMMENT 'Flag indicating whether the shipment contains RFID-tagged items for automated receiving and tracking.',
    `seal_number` STRING COMMENT 'Security seal number applied to the container or trailer for tamper detection.',
    `shipment_date` DATE COMMENT 'Date when the goods were shipped from the origin location.',
    `special_handling_instructions` STRING COMMENT 'Free-text instructions for special handling requirements such as fragile, temperature-controlled, or hazardous materials.',
    `supplier_reference_number` STRING COMMENT 'Suppliers internal reference or packing list number for this shipment.',
    `temperature_controlled_flag` BOOLEAN COMMENT 'Flag indicating whether the shipment requires temperature-controlled handling and storage.',
    `total_carton_count` STRING COMMENT 'Total number of cartons or packages included in this ASN shipment.',
    `total_pallet_count` STRING COMMENT 'Total number of pallets included in this ASN shipment.',
    `total_unit_quantity` STRING COMMENT 'Total number of individual units (SKUs) across all line items in this ASN.',
    `total_volume_cbm` DECIMAL(18,2) COMMENT 'Total volume of the shipment in cubic meters.',
    `total_weight_kg` DECIMAL(18,2) COMMENT 'Total gross weight of the shipment in kilograms.',
    `tracking_number` STRING COMMENT 'Carrier-provided tracking or waybill number for shipment visibility and tracing.',
    `transmitted_timestamp` TIMESTAMP COMMENT 'Date and time when the ASN was electronically transmitted to the receiving system via EDI or API.',
    CONSTRAINT pk_asn PRIMARY KEY(`asn_id`)
) COMMENT 'Record of Advance Shipment Notices received from suppliers, factories, or 3PLs prior to physical goods arrival, including line-level SKU detail. Captures ASN number, supplier reference, expected arrival date, ship-from/ship-to locations, carrier, tracking number, carton count, total units, line-level SKU/UPC/quantity breakdown, lot numbers, country of origin, and HS codes. Enables pre-receiving planning, dock scheduling, carton-level receiving reconciliation, and landed cost allocation upon receipt.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`inventory`.`lot_batch` (
    `lot_batch_id` BIGINT COMMENT 'Unique identifier for the production lot or batch record. Primary key for inventory traceability and recall management.',
    `bill_of_lading_id` BIGINT COMMENT 'Foreign key linking to logistics.bill_of_lading. Business justification: Lot traceability through shipping documents. Linking enables recall scope determination (which BOLs contained affected lots), quality issue investigation, supplier accountability, and regulatory compl',
    `chemical_compliance_id` BIGINT COMMENT 'Foreign key linking to sustainability.chemical_compliance. Business justification: Batch-level chemical testing (ZDHC MRSL, REACH) is mandatory in apparel. Lot batches must link to test results for regulatory compliance, customer safety, and rapid recall execution when non-complianc',
    `compliance_certification_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_certification. Business justification: Production lots require certifications (OEKO-TEX Standard 100, GOTS, Fair Trade, bluesign) to be sellable in certain markets and retail channels. Certification tracking at lot level enables market-spe',
    `inspection_id` BIGINT COMMENT 'Foreign key linking to quality.inspection. Business justification: Lot/batch quality inspections are mandatory at goods receipt and production completion per AQL protocols. Links lot traceability to inspection outcomes for compliance, disposition decisions, and suppl',
    `material_certification_id` BIGINT COMMENT 'Foreign key linking to sustainability.material_certification. Business justification: Production batches must link to material certifications (GOTS, OEKO-TEX, BCI) for compliance verification, customer claims substantiation, and recall traceability. Standard practice in certified organ',
    `order_purchase_order_id` BIGINT COMMENT 'Foreign key linking to order.purchase_order. Business justification: Lot/batch traceability to originating PO enables supplier quality tracking, product recall management, cost reconciliation for batch-costed inventory, and regulatory compliance (textile traceability).',
    `product_safety_test_id` BIGINT COMMENT 'Foreign key linking to compliance.product_safety_test. Business justification: Production batches undergo mandatory safety testing (flammability CPSC 16 CFR 1610, lead content CPSIA, phthalates) before release to market. Direct link enables batch release decisions and recall tra',
    `retail_store_id` BIGINT COMMENT 'Foreign key linking to store.retail_store. Business justification: Store-level lot/batch tracking for apparel (dye lots, production runs, fabric batches) enables quality traceability, recall management, and colorway consistency verification at retail locations - crit',
    `shipment_id` BIGINT COMMENT 'Foreign key linking to logistics.logistics_shipment. Business justification: Lot/batch traceability through supply chain. Linking enables recall management (which shipments contained affected lots), quality issue root cause analysis, and supplier performance by lot—critical fo',
    `sku_id` BIGINT COMMENT 'Foreign key reference to the product master record. Links the lot to the specific Stock Keeping Unit (SKU) or product that was manufactured in this batch.',
    `sourcing_purchase_order_id` BIGINT COMMENT 'Foreign key linking to sourcing.sourcing_purchase_order. Business justification: Material lot/batch traceability to sourcing PO is mandatory for quality audits, compliance (OEKO-TEX, GOTS), and vendor accountability. Critical for fabric/trim defect root cause analysis and supplier',
    `supplier_factory_id` BIGINT COMMENT 'Foreign key linking to supplier.supplier_factory. Business justification: Lot/batch traceability requires factory-level origin tracking for quality control, compliance audits, recall management, and regulatory reporting. Critical for apparel industry supply chain transparen',
    `vendor_id` BIGINT COMMENT 'Foreign key reference to the supplier or vendor master record. Identifies the Original Equipment Manufacturer (OEM), Original Design Manufacturer (ODM), or material supplier for this lot.',
    `warehouse_location_id` BIGINT COMMENT 'Foreign key linking to inventory.warehouse_location. Business justification: lot_batch records where production lots are stored via storage_location_code string but has no FK to warehouse_location. Adding warehouse_location_id FK provides structured link to the location hierar',
    `batch_type` STRING COMMENT 'Classification of the batch purpose: production (regular manufacturing), sample (pre-production samples), prototype (design validation), rework (quality correction), return (customer returns).. Valid values are `production|sample|prototype|rework|return`',
    `certification_expiry_date` DATE COMMENT 'Date when the certification for this lot expires. Null if certification does not expire or is perpetual.',
    `certification_number` STRING COMMENT 'Unique certificate or license number issued by the certifying body (e.g., OEKO-TEX certificate number, GOTS transaction certificate). Used for audit verification and customer transparency claims.. Valid values are `^[A-Z0-9-]{6,30}$`',
    `certification_type` STRING COMMENT 'Type of industry certification held by this lot. [ENUM-REF-CANDIDATE: OEKO-TEX Standard 100|GOTS|BCI Cotton|Fair Trade|Bluesign|Cradle to Cradle|ISO 14001|WRAP|FLA|Organic Content Standard|Recycled Claim Standard — promote to reference product]',
    `colorway_consistency_grade` STRING COMMENT 'Quality grade for color consistency within the lot: A (excellent match), B (acceptable variation), C (minor deviation), D (noticeable deviation), F (failed, not usable). Used for quality control and customer claims resolution.. Valid values are `A|B|C|D|F`',
    `cost_per_unit` DECIMAL(18,2) COMMENT 'Landed Duty Paid (LDP) cost per unit for this lot, including Free on Board (FOB) cost, freight, duties, and tariffs. Used for Cost of Goods Sold (COGS) calculation and margin analysis.',
    `country_of_origin` STRING COMMENT 'Three-letter ISO country code where the lot was manufactured. Required for customs compliance, Harmonized System (HS) Code classification, and Generalized System of Preferences (GSP) eligibility.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this lot batch record was first created in the system. Used for audit trail and data lineage tracking.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for cost_per_unit (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `defect_rate_percentage` DECIMAL(18,2) COMMENT 'Percentage of defective units identified during quality inspection. Used for supplier scorecarding and Acceptable Quality Level (AQL) compliance tracking.',
    `dye_lot_code` STRING COMMENT 'Unique identifier for the dye batch used in fabric coloring. Critical for color consistency matching in apparel production. Ensures garments from same order use same dye lot to avoid shade variation.. Valid values are `^[A-Z0-9]{4,15}$`',
    `expiry_date` DATE COMMENT 'Date when the lot reaches end of usable life. Applicable for materials with shelf-life constraints (adhesives, elastics, certain finishes). Null for non-perishable items.',
    `factory_code` STRING COMMENT 'Identifier of the manufacturing facility or Original Equipment Manufacturer (OEM) / Original Design Manufacturer (ODM) that produced this lot. Used for supplier performance tracking and recall traceability.. Valid values are `^[A-Z0-9]{3,10}$`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this lot batch record was last updated. Used for audit trail and change tracking.',
    `lot_batch_status` STRING COMMENT 'Current lifecycle state of the lot: active (available for use), quarantined (quality hold), consumed (fully allocated), expired (past shelf life), recalled (CPSC recall), disposed (destroyed).. Valid values are `active|quarantined|consumed|expired|recalled|disposed`',
    `lot_number` STRING COMMENT 'Business identifier for the production lot. Externally-known unique code used for traceability across supply chain partners, factories, and regulatory reporting.. Valid values are `^[A-Z0-9]{6,20}$`',
    `material_composition` STRING COMMENT 'Fiber content and composition percentages for the lot (e.g., 60% Cotton, 40% Polyester). Required for Federal Trade Commission (FTC) textile labeling compliance and customer product information.',
    `mill_origin_code` STRING COMMENT 'Identifier of the textile mill or raw material supplier that produced the fabric or material in this lot. Critical for material traceability and certification verification.. Valid values are `^[A-Z0-9]{3,10}$`',
    `notes` STRING COMMENT 'Free-text field for additional comments, special handling instructions, or quality observations related to this lot. Used for operational communication and customer claims documentation.',
    `production_date` DATE COMMENT 'Date when the lot was manufactured or produced. Critical for shelf-life calculation, warranty tracking, and regulatory compliance.',
    `quantity_available` DECIMAL(18,2) COMMENT 'Current available quantity remaining in the lot after consumption and allocation. Used for Available to Sell (ATS) and Available to Promise (ATP) calculations.',
    `quantity_produced` DECIMAL(18,2) COMMENT 'Total quantity manufactured in this lot. Unit of measure varies by product category (units for garments, yards/meters for fabric, kilograms for raw materials).',
    `quarantine_date` DATE COMMENT 'Date when the lot was placed into quarantine status. Null if lot has never been quarantined.',
    `quarantine_reason` STRING COMMENT 'Business reason for placing the lot in quarantine status (e.g., Failed color fastness test, Pending certification verification, Customer complaint investigation). Null if lot has never been quarantined.',
    `recall_date` DATE COMMENT 'Date when the recall was initiated for this lot. Null if lot has never been recalled.',
    `recall_flag` BOOLEAN COMMENT 'Indicates whether this lot is subject to a Consumer Product Safety Commission (CPSC) recall or voluntary recall. True if recalled, False otherwise.',
    `recall_number` STRING COMMENT 'Official recall identification number issued by Consumer Product Safety Commission (CPSC) or internal recall tracking number. Null if lot has never been recalled.. Valid values are `^[A-Z0-9-]{6,20}$`',
    `release_date` DATE COMMENT 'Date when the lot was released from quarantine and made available for use. Null if lot has never been quarantined or is currently quarantined.',
    `rfid_tag_applied` BOOLEAN COMMENT 'Indicates whether Radio Frequency Identification (RFID) tags have been applied to units in this lot for automated tracking and inventory accuracy. True if RFID-enabled, False otherwise.',
    `unit_of_measure` STRING COMMENT 'Unit of measure for quantity fields: EA (each/units), YD (yards), M (meters), KG (kilograms), LB (pounds), SQM (square meters), SQY (square yards). [ENUM-REF-CANDIDATE: EA|YD|M|KG|LB|SQM|SQY — 7 candidates stripped; promote to reference product]',
    `vendor_managed_inventory_flag` BOOLEAN COMMENT 'Indicates whether this lot is part of a Vendor Managed Inventory (VMI) program where the supplier manages replenishment. True if VMI, False otherwise.',
    CONSTRAINT pk_lot_batch PRIMARY KEY(`lot_batch_id`)
) COMMENT 'Master record of production lots or batches for inventory traceability, critical for dye-lot consistency in apparel, certified material tracking (OEKO-TEX, GOTS, BCI cotton), and regulatory recall compliance. Captures lot number, batch origin (factory, mill), production date, expiry date, certification references, dye lot code, colorway consistency grade, and lot status (active, quarantined, consumed, expired). Supports CPSC recall traceability and customer claims resolution.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`inventory`.`goods_receipt` (
    `goods_receipt_id` BIGINT COMMENT 'Unique identifier for the goods receipt transaction. Primary key for this entity.',
    `asn_id` BIGINT COMMENT 'Reference to the advanced shipping notice that preceded this goods receipt, if applicable.',
    `bill_of_lading_id` BIGINT COMMENT 'Foreign key linking to logistics.bill_of_lading. Business justification: Physical receipt tied to BOL. Linking enables receiving discrepancy resolution, freight claim support documentation, document audit trail, and carrier accountability—standard apparel receiving operati',
    `carbon_emission_id` BIGINT COMMENT 'Foreign key linking to sustainability.carbon_emission. Business justification: Goods receipt events trigger carbon footprint allocation for inbound logistics. Link enables scope 3 category 4 emissions tracking, product-level carbon labeling, and supplier sustainability scorecard',
    `customs_entry_id` BIGINT COMMENT 'Foreign key linking to logistics.customs_entry. Business justification: Physical receipt of imported goods tied to customs clearance. Enables 4-way match (PO/ASN/GR/Customs), duty accrual posting, compliance reporting, and customs audit support—standard apparel import acc',
    `distribution_center_id` BIGINT COMMENT 'Identifier of the warehouse, distribution center, or store location where goods were received.',
    `freight_invoice_id` BIGINT COMMENT 'Foreign key linking to logistics.freight_invoice. Business justification: Receipt events tied to freight invoices. Linking enables landed cost posting to inventory, freight variance analysis, payment approval workflow, and freight accrual reconciliation—fundamental apparel ',
    `inspection_id` BIGINT COMMENT 'Foreign key linking to quality.inspection. Business justification: Incoming goods receipts trigger quality inspections per receiving protocols. Inspection results determine acceptance, quarantine, or RTV disposition. Essential for WMS integration, supplier performanc',
    `lot_batch_id` BIGINT COMMENT 'Foreign key linking to inventory.lot_batch. Business justification: goods_receipt captures lot/batch information for received goods (critical for dye-lot traceability in apparel) but currently has only lot_number string. Adding lot_batch_id FK to lot_batch master enab',
    `order_purchase_order_id` BIGINT COMMENT 'Reference to the purchase order against which goods are being received.',
    `packing_list_id` BIGINT COMMENT 'Foreign key linking to logistics.packing_list. Business justification: Physical receipt validated against packing list. Linking enables receiving accuracy measurement, discrepancy root cause analysis, vendor compliance scoring, and receiving audit trail—fundamental appar',
    `employee_id` BIGINT COMMENT 'Identifier of the warehouse employee who physically received and processed the goods.',
    `quality_hold_id` BIGINT COMMENT 'Foreign key linking to quality.quality_hold. Business justification: Quality holds can block goods receipt posting to available inventory, requiring WMS to reference quality hold status before stock becomes allocatable. Enforces quality gates at receiving and prevents ',
    `retail_store_id` BIGINT COMMENT 'Foreign key linking to store.retail_store. Business justification: Store goods receipts (from DC or direct vendor shipments) must be attributed to receiving retail store for inventory accuracy, receiving productivity tracking, ASN-to-receipt matching, and store opera',
    `return_shipment_id` BIGINT COMMENT 'Foreign key linking to logistics.return_shipment. Business justification: Return receipts. Linking enables return processing time measurement, restocking accuracy validation, refund trigger workflow, and reverse logistics performance—standard apparel returns operations.',
    `shipment_id` BIGINT COMMENT 'Foreign key linking to logistics.logistics_shipment. Business justification: Physical receipt event tied to inbound shipment. Required for 3-way match (PO/ASN/GR), freight accrual posting, customs reconciliation, and landed cost accuracy—fundamental apparel import operations.',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: Receiving quality validation requires product master material_composition, sustainability_certification, care_instructions, and safety_certification to verify compliance. Cost variance analysis needs ',
    `sourcing_purchase_order_id` BIGINT COMMENT 'Foreign key linking to sourcing.sourcing_purchase_order. Business justification: Goods receipts for materials/fabrics must reference the sourcing PO for 3-way match (PO-ASN-GR), cost verification, and quality traceability. Core apparel procurement process linking inbound materials',
    `third_party_logistics_id` BIGINT COMMENT 'Foreign key linking to logistics.third_party_logistics. Business justification: 3PL receiving operations. Linking enables 3PL productivity measurement, billing validation, service level tracking, and performance benchmarking—standard for apparel brands using 3PL warehousing.',
    `trade_compliance_record_id` BIGINT COMMENT 'Foreign key linking to compliance.trade_compliance_record. Business justification: Goods receipts finalize customs entry and duty payment for imported goods. Direct link to trade compliance record provides audit trail for duty calculations, preferential trade agreement claims, and c',
    `vendor_id` BIGINT COMMENT 'Identifier of the vendor or supplier from whom the goods were received.',
    `work_order_id` BIGINT COMMENT 'Foreign key linking to production.work_order. Business justification: Finished goods receipts from factories must reference originating work order for production order closure, cost settlement, quantity reconciliation, and variance reporting. Core ERP integration point ',
    `correction_goods_receipt_id` BIGINT COMMENT 'Self-referencing FK on goods_receipt (correction_goods_receipt_id)',
    `accepted_quantity` DECIMAL(18,2) COMMENT 'The quantity of goods that passed quality inspection and were accepted into available inventory.',
    `carrier_name` STRING COMMENT 'The name of the shipping carrier or logistics provider that delivered the goods.',
    `carton_count` STRING COMMENT 'The total number of cartons or boxes received in this goods receipt transaction.',
    `container_number` STRING COMMENT 'The ISO standard container number for ocean freight shipments, if applicable.. Valid values are `^[A-Z]{4}[0-9]{7}$`',
    `country_of_origin` STRING COMMENT 'The country where the goods were manufactured or produced, using ISO 3166-1 alpha-3 country code.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this goods receipt record was first created in the system.',
    `currency_code` STRING COMMENT 'The three-letter ISO currency code for the cost values recorded in this goods receipt.. Valid values are `^[A-Z]{3}$`',
    `discrepancy_reason_code` STRING COMMENT 'Standardized code indicating the type of discrepancy found during goods receipt, if any.. Valid values are `overage|shortage|damage|wrong_item|quality_issue|none`',
    `document_date` DATE COMMENT 'The date printed on the goods receipt document, which may differ from the posting date.',
    `hazmat_indicator` BOOLEAN COMMENT 'Indicates whether the received goods are classified as hazardous materials requiring special handling.',
    `hs_code` STRING COMMENT 'The international customs classification code for the received goods, used for trade compliance and duty calculation.. Valid values are `^[0-9]{6,10}$`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this goods receipt record was last updated or modified.',
    `ordered_quantity` DECIMAL(18,2) COMMENT 'The quantity of goods that was originally ordered on the purchase order.',
    `pallet_count` STRING COMMENT 'The total number of pallets received in this goods receipt transaction.',
    `po_line_number` STRING COMMENT 'Line item number on the purchase order corresponding to this goods receipt.',
    `posting_date` DATE COMMENT 'The date on which the goods receipt was posted to inventory and financial ledgers. This is the official accounting date.',
    `product_description` STRING COMMENT 'Human-readable description of the product being received, including style, color, and size details.',
    `receipt_number` STRING COMMENT 'Externally-known business identifier for the goods receipt document. Used for tracking and reference across systems.. Valid values are `^GR[0-9]{10}$`',
    `receipt_status` STRING COMMENT 'Current lifecycle status of the goods receipt transaction in the warehouse management workflow.. Valid values are `pending|in_progress|completed|cancelled|reversed`',
    `receipt_timestamp` TIMESTAMP COMMENT 'The precise date and time when the physical receipt of goods occurred at the receiving location.',
    `receipt_type` STRING COMMENT 'Classification of the goods receipt transaction based on business purpose and origin.. Valid values are `standard|return_to_vendor|transfer|consignment|sample|direct_delivery`',
    `received_quantity` DECIMAL(18,2) COMMENT 'The actual quantity of goods physically received and accepted at the facility.',
    `receiving_location_code` STRING COMMENT 'Specific dock door, staging area, or receiving bay code where goods were physically received.. Valid values are `^[A-Z0-9]{2,10}$`',
    `receiving_notes` STRING COMMENT 'Free-text notes recorded by the receiving personnel regarding condition, discrepancies, or special observations.',
    `rejected_quantity` DECIMAL(18,2) COMMENT 'The quantity of goods that failed quality inspection and were rejected or placed on hold.',
    `reversal_indicator` BOOLEAN COMMENT 'Indicates whether this goods receipt has been reversed or cancelled after initial posting.',
    `reversed_document_number` STRING COMMENT 'The goods receipt document number that reversed this transaction, if applicable.. Valid values are `^GR[0-9]{10}$`',
    `rfid_enabled_flag` BOOLEAN COMMENT 'Indicates whether the received goods are tracked using RFID technology for enhanced visibility.',
    `seal_number` STRING COMMENT 'The security seal number applied to the container or trailer to ensure tamper-proof delivery.. Valid values are `^[A-Z0-9]{6,20}$`',
    `serial_number` STRING COMMENT 'Unique serial number for individually tracked items, if applicable.. Valid values are `^[A-Z0-9-]{6,30}$`',
    `sku` STRING COMMENT 'The unique product identifier for the item being received. Core business identifier for inventory tracking.. Valid values are `^[A-Z0-9-]{6,20}$`',
    `stock_type` STRING COMMENT 'Classification of the inventory stock status after receipt, determining availability for use or sale.. Valid values are `unrestricted|quality_inspection|blocked|returns|consignment`',
    `temperature_controlled_flag` BOOLEAN COMMENT 'Indicates whether the received goods require temperature-controlled storage and handling.',
    `total_cost` DECIMAL(18,2) COMMENT 'The total cost of the goods receipt, calculated as received quantity multiplied by unit cost.',
    `total_volume_cbm` DECIMAL(18,2) COMMENT 'The total volume of the received goods in cubic meters, used for warehouse space planning.',
    `total_weight_kg` DECIMAL(18,2) COMMENT 'The total gross weight of the received goods in kilograms, including packaging.',
    `tracking_number` STRING COMMENT 'The shipment tracking number provided by the carrier for tracing the delivery.. Valid values are `^[A-Z0-9]{10,30}$`',
    `unit_cost` DECIMAL(18,2) COMMENT 'The cost per unit of the received goods as recorded in the purchase order or invoice.',
    `unit_of_measure` STRING COMMENT 'The unit in which the received quantity is measured (e.g., each, case, pallet, carton). [ENUM-REF-CANDIDATE: EA|CS|PL|CTN|KG|LB|YD|MT — 8 candidates stripped; promote to reference product]',
    `upc` STRING COMMENT 'The standard barcode identifier for the product, used for scanning and point-of-sale transactions.. Valid values are `^[0-9]{12,14}$`',
    `valuation_type` STRING COMMENT 'The inventory valuation method applied to the received goods for financial accounting purposes.. Valid values are `standard|moving_average|fifo|lifo`',
    CONSTRAINT pk_goods_receipt PRIMARY KEY(`goods_receipt_id`)
) COMMENT 'Records the physical receipt of goods at a warehouse, DC, or port of entry against a purchase order including receipt date, received quantities, and quality status';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`inventory`.`storefront_fulfillment_network` (
    `storefront_fulfillment_network_id` BIGINT COMMENT 'Unique identifier for this storefront-warehouse fulfillment network configuration record. Primary key.',
    `digital_storefront_id` BIGINT COMMENT 'Foreign key linking to the digital storefront that can be served by this warehouse location',
    `warehouse_location_id` BIGINT COMMENT 'Foreign key linking to the warehouse location that can fulfill orders for this storefront',
    `allocation_priority` STRING COMMENT 'Numeric priority ranking for this warehouse when fulfilling orders from this storefront. Lower numbers indicate higher priority. Used by order routing logic to determine which warehouse should fulfill an order when multiple warehouses can serve the storefront.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this fulfillment network configuration record was created in the system.',
    `effective_date` DATE COMMENT 'Date when this fulfillment network configuration became active and operational. Used for temporal tracking of network changes and historical analysis of fulfillment strategy evolution.',
    `expiration_date` DATE COMMENT 'Date when this fulfillment network configuration was or will be deactivated. Null if still active. Used to manage network reconfigurations, warehouse closures, or storefront market exits.',
    `fulfillment_sla_hours` STRING COMMENT 'Service level agreement in hours for order fulfillment from this warehouse to customers of this storefront. Represents the committed time from order placement to shipment departure. Used for delivery promise calculations and warehouse performance measurement.',
    `is_primary_fulfillment_location` BOOLEAN COMMENT 'Indicates whether this warehouse is the primary/default fulfillment location for this storefront. Typically one primary location per storefront with others serving as backup or overflow capacity.',
    `shipping_cost_tier` STRING COMMENT 'Classification of shipping cost economics for this warehouse-storefront pair. Reflects distance, carrier rates, and zone-based pricing. Used to optimize fulfillment routing based on shipping cost considerations.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this fulfillment network configuration record was last modified.',
    CONSTRAINT pk_storefront_fulfillment_network PRIMARY KEY(`storefront_fulfillment_network_id`)
) COMMENT 'This association product represents the fulfillment network configuration between warehouse locations and digital storefronts. It captures the operational routing rules that determine which warehouses can fulfill orders for which storefronts, including allocation priority, service level agreements, and shipping cost tiers. Each record links one warehouse location to one digital storefront with attributes that govern order routing, inventory allocation, and fulfillment strategy in multi-region omnichannel operations.. Existence Justification: In multi-region apparel ecommerce operations, digital storefronts are served by multiple warehouse locations to optimize shipping costs, delivery speed, and inventory availability (e.g., US site ships from East Coast, West Coast, and Midwest DCs based on customer location and stock levels). Conversely, a single warehouse location serves multiple storefronts (e.g., EU distribution center fulfills orders for UK, Germany, France, and Spain storefronts). The business actively manages this fulfillment network configuration with specific allocation priorities, SLAs, and cost tiers for each storefront-warehouse pair.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`inventory`.`inventory_pool` (
    `inventory_pool_id` BIGINT COMMENT 'Primary key for inventory_pool',
    `warehouse_location_id` BIGINT COMMENT 'Reference to the physical location or facility where this inventory pool is located.',
    `organization_id` BIGINT COMMENT 'Reference to the business organization or entity that owns or manages this inventory pool.',
    `parent_inventory_pool_id` BIGINT COMMENT 'Self-referencing FK on inventory_pool (parent_inventory_pool_id)',
    `allocation_strategy` STRING COMMENT 'The inventory allocation method used for fulfillment from this pool (First In First Out, Last In First Out, First Expired First Out, etc.).',
    `atp_calculation_method` STRING COMMENT 'The method used to calculate Available to Promise inventory for this pool considering future supply and demand.',
    `ats_calculation_method` STRING COMMENT 'The method used to calculate Available to Sell inventory for this pool (real-time, batch processing, scheduled updates).',
    `capacity_unit_of_measure` STRING COMMENT 'The unit of measure for the capacity metric (units, pallets, cubic meters, square feet).',
    `capacity_units` DECIMAL(18,2) COMMENT 'Maximum storage capacity of the inventory pool measured in standard units.',
    `cost_center_code` STRING COMMENT 'Financial cost center code associated with this inventory pool for accounting and reporting purposes.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this inventory pool record was first created in the system.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for financial transactions and valuations associated with this inventory pool.',
    `cycle_count_frequency` STRING COMMENT 'The frequency at which cycle counts are performed for inventory accuracy verification in this pool.',
    `effective_end_date` DATE COMMENT 'The date when this inventory pool ceased or will cease operations. Null for active pools with no planned end date.',
    `effective_start_date` DATE COMMENT 'The date when this inventory pool became or will become operational and available for inventory allocation.',
    `external_pool_code` STRING COMMENT 'External system identifier for this inventory pool in source WMS or ERP systems.',
    `fulfillment_priority` STRING COMMENT 'Numeric priority ranking for order fulfillment allocation (lower number = higher priority).',
    `lead_time_days` STRING COMMENT 'Standard replenishment lead time in days from order to receipt for this inventory pool.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this inventory pool record was last modified or updated.',
    `notes` STRING COMMENT 'Free-text notes and comments about the inventory pool for operational reference and documentation.',
    `omnichannel_enabled_flag` BOOLEAN COMMENT 'Indicates whether this inventory pool is available for omnichannel fulfillment (ship-from-store, buy-online-pickup-in-store, etc.).',
    `pool_category` STRING COMMENT 'Business category indicating ownership and management model of the inventory pool.',
    `pool_code` STRING COMMENT 'Unique business identifier code for the inventory pool used across systems and business communications.',
    `pool_name` STRING COMMENT 'Human-readable name of the inventory pool for business identification and reporting purposes.',
    `pool_type` STRING COMMENT 'Classification of the inventory pool based on facility type and operational model.',
    `replenishment_method` STRING COMMENT 'The method used to replenish inventory in this pool (automatic, manual, Vendor Managed Inventory, Just-In-Time, scheduled).',
    `rfid_enabled_flag` BOOLEAN COMMENT 'Indicates whether RFID tracking technology is enabled for inventory in this pool.',
    `safety_stock_days` STRING COMMENT 'Number of days of safety stock maintained in this pool to buffer against demand variability and supply disruptions.',
    `inventory_pool_status` STRING COMMENT 'Current operational status of the inventory pool in its lifecycle.',
    `time_zone` STRING COMMENT 'IANA time zone identifier for the inventory pool location used for timestamp conversions and operational scheduling.',
    `utilization_threshold_pct` DECIMAL(18,2) COMMENT 'Target utilization percentage threshold that triggers replenishment or rebalancing actions.',
    `wms_system_code` STRING COMMENT 'The warehouse management system that manages this inventory pool (Manhattan Associates, SAP EWM, Blue Yonder, etc.).',
    `wos_target_weeks` DECIMAL(18,2) COMMENT 'Target weeks of supply to maintain in this inventory pool based on demand forecasts.',
    CONSTRAINT pk_inventory_pool PRIMARY KEY(`inventory_pool_id`)
) COMMENT 'Master reference table for inventory_pool. Referenced by inventory_pool_id.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`inventory`.`zone` (
    `zone_id` BIGINT COMMENT 'Primary key for zone',
    `distribution_center_id` BIGINT COMMENT 'Identifier of the warehouse or distribution center to which this zone belongs.',
    `facility_id` BIGINT COMMENT 'Identifier of the parent facility (DC, 3PL, retail store) containing this zone.',
    `employee_id` BIGINT COMMENT 'Identifier of the employee responsible for managing operations within this zone.',
    `parent_zone_id` BIGINT COMMENT 'Self-referencing FK on zone (parent_zone_id)',
    `active_from_date` DATE COMMENT 'Date when the zone became operational and available for inventory operations.',
    `active_to_date` DATE COMMENT 'Date when the zone was deactivated or is scheduled for deactivation. Null for currently active zones.',
    `aisle_range_end` STRING COMMENT 'Ending aisle identifier for the zones physical location range within the warehouse.',
    `aisle_range_start` STRING COMMENT 'Starting aisle identifier for the zones physical location range within the warehouse.',
    `available_capacity_units` DECIMAL(18,2) COMMENT 'Current available capacity in the zone, representing unused storage space.',
    `capacity_unit_of_measure` STRING COMMENT 'Unit of measure for the zone capacity (e.g., pallets, bins, cubic meters).',
    `capacity_units` DECIMAL(18,2) COMMENT 'Maximum storage capacity of the zone measured in units (pallets, bins, cubic meters, or square meters depending on zone type).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the zone record was first created in the system.',
    `cycle_count_frequency_days` STRING COMMENT 'Frequency in days for conducting cycle counts within this zone to ensure inventory accuracy.',
    `zone_description` STRING COMMENT 'Detailed description of the zone including its purpose, special characteristics, and operational notes.',
    `floor_level` STRING COMMENT 'Physical floor or level number within the facility where the zone is located.',
    `hazmat_certified_flag` BOOLEAN COMMENT 'Indicates whether the zone is certified and equipped to handle hazardous materials according to regulatory requirements.',
    `last_cycle_count_date` DATE COMMENT 'Date when the most recent cycle count was performed in this zone.',
    `next_cycle_count_date` DATE COMMENT 'Scheduled date for the next cycle count in this zone.',
    `notes` STRING COMMENT 'Additional operational notes, special instructions, or comments related to the zone.',
    `picking_method` STRING COMMENT 'Method used for order picking operations within the zone (e.g., manual, voice-directed, pick-to-light, automated).',
    `replenishment_priority` STRING COMMENT 'Priority ranking for inventory replenishment operations, with lower numbers indicating higher priority.',
    `rfid_enabled_flag` BOOLEAN COMMENT 'Indicates whether the zone is equipped with RFID tracking technology for real-time inventory visibility.',
    `security_level` STRING COMMENT 'Security classification of the zone indicating access control requirements and monitoring level.',
    `storage_type` STRING COMMENT 'Physical storage method or infrastructure used within the zone.',
    `temperature_controlled_flag` BOOLEAN COMMENT 'Indicates whether the zone requires temperature control (refrigerated or frozen storage).',
    `temperature_max_celsius` DECIMAL(18,2) COMMENT 'Maximum allowable temperature for the zone in degrees Celsius, applicable for temperature-controlled zones.',
    `temperature_min_celsius` DECIMAL(18,2) COMMENT 'Minimum allowable temperature for the zone in degrees Celsius, applicable for temperature-controlled zones.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the zone record was last modified in the system.',
    `utilization_percentage` DECIMAL(18,2) COMMENT 'Current utilization rate of the zone expressed as a percentage of total capacity.',
    `zone_category` STRING COMMENT 'Storage environment or handling category for the zone, indicating special requirements or conditions.',
    `zone_code` STRING COMMENT 'Business identifier code for the zone, used for operational reference and labeling (e.g., A1, RCV-01, PKG-ZONE).',
    `zone_name` STRING COMMENT 'Human-readable name of the zone (e.g., Receiving Zone, Picking Area A, Packing Station 1).',
    `zone_status` STRING COMMENT 'Current operational status of the zone indicating availability for inventory operations.',
    `zone_type` STRING COMMENT 'Functional classification of the zone indicating its primary operational purpose within the warehouse or distribution center.',
    CONSTRAINT pk_zone PRIMARY KEY(`zone_id`)
) COMMENT 'Master reference table for zone. Referenced by zone_id.';

CREATE OR REPLACE TABLE `apparel_fashion_ecm`.`inventory`.`valuation_area` (
    `valuation_area_id` BIGINT COMMENT 'Primary key for valuation_area',
    `parent_valuation_area_id` BIGINT COMMENT 'Self-referencing FK on valuation_area (parent_valuation_area_id)',
    `company_code` STRING COMMENT 'The company code to which this valuation area is assigned for financial accounting and reporting purposes.',
    `cost_center_code` STRING COMMENT 'The cost center code responsible for managing inventory costs within this valuation area.',
    `country_code` STRING COMMENT 'Three-letter ISO 3166 country code where the valuation area is located.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this valuation area record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code in which inventory is valued within this valuation area (e.g., USD, EUR, GBP).',
    `cycle_count_frequency` STRING COMMENT 'The frequency at which cycle counts are performed within this valuation area to ensure inventory accuracy.',
    `valuation_area_description` STRING COMMENT 'Detailed description of the valuation areas purpose, scope, and business context.',
    `distribution_channel` STRING COMMENT 'The primary distribution channel served by this valuation area (retail stores, wholesale partners, e-commerce, outlet stores, franchise, or direct-to-consumer).',
    `effective_end_date` DATE COMMENT 'The date on which this valuation area ceased to be active, if applicable. Null for currently active valuation areas.',
    `effective_start_date` DATE COMMENT 'The date from which this valuation area became active and operational for inventory transactions.',
    `general_ledger_account` STRING COMMENT 'The general ledger account number to which inventory value in this valuation area is posted for financial reporting.',
    `geographic_region` STRING COMMENT 'The geographic region or market served by this valuation area (e.g., North America, EMEA, APAC, LATAM).',
    `inventory_account_determination_group` STRING COMMENT 'The account determination group used to automatically assign GL accounts for inventory transactions within this valuation area.',
    `last_modified_by` STRING COMMENT 'The user ID or name of the person who last modified this valuation area record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this valuation area record was last updated or modified.',
    `last_physical_inventory_date` DATE COMMENT 'The date of the most recent physical inventory count conducted within this valuation area.',
    `valuation_area_name` STRING COMMENT 'Human-readable name of the valuation area (e.g., North America Distribution Center, EMEA Retail Operations).',
    `never_out_of_stock_flag` BOOLEAN COMMENT 'Indicates whether this valuation area follows a never-out-of-stock strategy for critical SKUs to ensure continuous availability.',
    `next_scheduled_inventory_date` DATE COMMENT 'The date scheduled for the next physical inventory count or cycle count within this valuation area.',
    `notes` STRING COMMENT 'Free-form text field for additional notes, comments, or special instructions related to this valuation area.',
    `plant_code` STRING COMMENT 'The plant or facility code associated with this valuation area for manufacturing and logistics operations.',
    `price_control_method` STRING COMMENT 'The method used to control and update inventory prices within this valuation area (standard price, moving average price, or manual).',
    `profit_center_code` STRING COMMENT 'The profit center code to which inventory in this valuation area is assigned for internal profitability analysis.',
    `rfid_enabled_flag` BOOLEAN COMMENT 'Indicates whether RFID tracking technology is enabled for inventory management within this valuation area.',
    `valuation_area_status` STRING COMMENT 'Current lifecycle status of the valuation area indicating whether it is operational and available for inventory transactions.',
    `storage_location_code` STRING COMMENT 'The storage location code within the plant where inventory is physically stored and valued.',
    `third_party_logistics_provider` STRING COMMENT 'Name of the third-party logistics provider managing inventory within this valuation area, if applicable.',
    `valuation_area_code` STRING COMMENT 'Business identifier code for the valuation area used in operational systems and reporting.',
    `valuation_category` STRING COMMENT 'Additional classification for grouping valuation areas by business segment, product category, or operational model.',
    `valuation_class` STRING COMMENT 'The inventory valuation method applied within this valuation area (standard cost, moving average, FIFO, LIFO, weighted average, or retail method).',
    `valuation_control_indicator` STRING COMMENT 'Indicates whether inventory valuation is controlled centrally at company code level, decentralized at plant level, or hybrid.',
    `valuation_date` DATE COMMENT 'The date on which the current inventory valuation parameters became effective for this valuation area.',
    `valuation_type` STRING COMMENT 'Classification of the valuation area indicating the organizational level at which inventory is valued (plant-level, company-code-level, storage-location-level, distribution center, warehouse, or retail store).',
    `vendor_managed_inventory_flag` BOOLEAN COMMENT 'Indicates whether this valuation area participates in vendor-managed inventory programs where suppliers manage stock levels.',
    `warehouse_management_system` STRING COMMENT 'The warehouse management system used to manage inventory operations within this valuation area (e.g., Manhattan Associates, SAP EWM).',
    `created_by` STRING COMMENT 'The user ID or name of the person who created this valuation area record.',
    CONSTRAINT pk_valuation_area PRIMARY KEY(`valuation_area_id`)
) COMMENT 'Master reference table for valuation_area. Referenced by valuation_area_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_position` ADD CONSTRAINT `fk_inventory_stock_position_inventory_pool_id` FOREIGN KEY (`inventory_pool_id`) REFERENCES `apparel_fashion_ecm`.`inventory`.`inventory_pool`(`inventory_pool_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_position` ADD CONSTRAINT `fk_inventory_stock_position_warehouse_location_id` FOREIGN KEY (`warehouse_location_id`) REFERENCES `apparel_fashion_ecm`.`inventory`.`warehouse_location`(`warehouse_location_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_movement` ADD CONSTRAINT `fk_inventory_stock_movement_asn_id` FOREIGN KEY (`asn_id`) REFERENCES `apparel_fashion_ecm`.`inventory`.`asn`(`asn_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_movement` ADD CONSTRAINT `fk_inventory_stock_movement_warehouse_location_id` FOREIGN KEY (`warehouse_location_id`) REFERENCES `apparel_fashion_ecm`.`inventory`.`warehouse_location`(`warehouse_location_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_movement` ADD CONSTRAINT `fk_inventory_stock_movement_goods_receipt_id` FOREIGN KEY (`goods_receipt_id`) REFERENCES `apparel_fashion_ecm`.`inventory`.`goods_receipt`(`goods_receipt_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_movement` ADD CONSTRAINT `fk_inventory_stock_movement_inventory_cycle_count_id` FOREIGN KEY (`inventory_cycle_count_id`) REFERENCES `apparel_fashion_ecm`.`inventory`.`inventory_cycle_count`(`inventory_cycle_count_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_movement` ADD CONSTRAINT `fk_inventory_stock_movement_lot_batch_id` FOREIGN KEY (`lot_batch_id`) REFERENCES `apparel_fashion_ecm`.`inventory`.`lot_batch`(`lot_batch_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_movement` ADD CONSTRAINT `fk_inventory_stock_movement_primary_stock_warehouse_location_id` FOREIGN KEY (`primary_stock_warehouse_location_id`) REFERENCES `apparel_fashion_ecm`.`inventory`.`warehouse_location`(`warehouse_location_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_movement` ADD CONSTRAINT `fk_inventory_stock_movement_quarantine_hold_id` FOREIGN KEY (`quarantine_hold_id`) REFERENCES `apparel_fashion_ecm`.`inventory`.`quarantine_hold`(`quarantine_hold_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_movement` ADD CONSTRAINT `fk_inventory_stock_movement_replenishment_order_id` FOREIGN KEY (`replenishment_order_id`) REFERENCES `apparel_fashion_ecm`.`inventory`.`replenishment_order`(`replenishment_order_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_movement` ADD CONSTRAINT `fk_inventory_stock_movement_reservation_id` FOREIGN KEY (`reservation_id`) REFERENCES `apparel_fashion_ecm`.`inventory`.`reservation`(`reservation_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_movement` ADD CONSTRAINT `fk_inventory_stock_movement_rfid_tag_id` FOREIGN KEY (`rfid_tag_id`) REFERENCES `apparel_fashion_ecm`.`inventory`.`rfid_tag`(`rfid_tag_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_movement` ADD CONSTRAINT `fk_inventory_stock_movement_transfer_order_id` FOREIGN KEY (`transfer_order_id`) REFERENCES `apparel_fashion_ecm`.`inventory`.`transfer_order`(`transfer_order_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`warehouse_location` ADD CONSTRAINT `fk_inventory_warehouse_location_zone_id` FOREIGN KEY (`zone_id`) REFERENCES `apparel_fashion_ecm`.`inventory`.`zone`(`zone_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`sku_location` ADD CONSTRAINT `fk_inventory_sku_location_warehouse_location_id` FOREIGN KEY (`warehouse_location_id`) REFERENCES `apparel_fashion_ecm`.`inventory`.`warehouse_location`(`warehouse_location_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`sku_location` ADD CONSTRAINT `fk_inventory_sku_location_zone_id` FOREIGN KEY (`zone_id`) REFERENCES `apparel_fashion_ecm`.`inventory`.`zone`(`zone_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`inventory_cycle_count` ADD CONSTRAINT `fk_inventory_inventory_cycle_count_lot_batch_id` FOREIGN KEY (`lot_batch_id`) REFERENCES `apparel_fashion_ecm`.`inventory`.`lot_batch`(`lot_batch_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`inventory_cycle_count` ADD CONSTRAINT `fk_inventory_inventory_cycle_count_warehouse_location_id` FOREIGN KEY (`warehouse_location_id`) REFERENCES `apparel_fashion_ecm`.`inventory`.`warehouse_location`(`warehouse_location_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`inventory_cycle_count` ADD CONSTRAINT `fk_inventory_inventory_cycle_count_zone_id` FOREIGN KEY (`zone_id`) REFERENCES `apparel_fashion_ecm`.`inventory`.`zone`(`zone_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`transfer_order` ADD CONSTRAINT `fk_inventory_transfer_order_warehouse_location_id` FOREIGN KEY (`warehouse_location_id`) REFERENCES `apparel_fashion_ecm`.`inventory`.`warehouse_location`(`warehouse_location_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`transfer_order` ADD CONSTRAINT `fk_inventory_transfer_order_primary_transfer_warehouse_location_id` FOREIGN KEY (`primary_transfer_warehouse_location_id`) REFERENCES `apparel_fashion_ecm`.`inventory`.`warehouse_location`(`warehouse_location_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`rfid_tag` ADD CONSTRAINT `fk_inventory_rfid_tag_lot_batch_id` FOREIGN KEY (`lot_batch_id`) REFERENCES `apparel_fashion_ecm`.`inventory`.`lot_batch`(`lot_batch_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`replenishment_order` ADD CONSTRAINT `fk_inventory_replenishment_order_warehouse_location_id` FOREIGN KEY (`warehouse_location_id`) REFERENCES `apparel_fashion_ecm`.`inventory`.`warehouse_location`(`warehouse_location_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`replenishment_order` ADD CONSTRAINT `fk_inventory_replenishment_order_nos_policy_id` FOREIGN KEY (`nos_policy_id`) REFERENCES `apparel_fashion_ecm`.`inventory`.`nos_policy`(`nos_policy_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`replenishment_order` ADD CONSTRAINT `fk_inventory_replenishment_order_primary_replenishment_warehouse_location_id` FOREIGN KEY (`primary_replenishment_warehouse_location_id`) REFERENCES `apparel_fashion_ecm`.`inventory`.`warehouse_location`(`warehouse_location_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`replenishment_order` ADD CONSTRAINT `fk_inventory_replenishment_order_vmi_program_id` FOREIGN KEY (`vmi_program_id`) REFERENCES `apparel_fashion_ecm`.`inventory`.`vmi_program`(`vmi_program_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`vmi_program` ADD CONSTRAINT `fk_inventory_vmi_program_warehouse_location_id` FOREIGN KEY (`warehouse_location_id`) REFERENCES `apparel_fashion_ecm`.`inventory`.`warehouse_location`(`warehouse_location_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`nos_policy` ADD CONSTRAINT `fk_inventory_nos_policy_warehouse_location_id` FOREIGN KEY (`warehouse_location_id`) REFERENCES `apparel_fashion_ecm`.`inventory`.`warehouse_location`(`warehouse_location_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`reservation` ADD CONSTRAINT `fk_inventory_reservation_warehouse_location_id` FOREIGN KEY (`warehouse_location_id`) REFERENCES `apparel_fashion_ecm`.`inventory`.`warehouse_location`(`warehouse_location_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_valuation` ADD CONSTRAINT `fk_inventory_stock_valuation_valuation_area_id` FOREIGN KEY (`valuation_area_id`) REFERENCES `apparel_fashion_ecm`.`inventory`.`valuation_area`(`valuation_area_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`quarantine_hold` ADD CONSTRAINT `fk_inventory_quarantine_hold_lot_batch_id` FOREIGN KEY (`lot_batch_id`) REFERENCES `apparel_fashion_ecm`.`inventory`.`lot_batch`(`lot_batch_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`quarantine_hold` ADD CONSTRAINT `fk_inventory_quarantine_hold_rfid_tag_id` FOREIGN KEY (`rfid_tag_id`) REFERENCES `apparel_fashion_ecm`.`inventory`.`rfid_tag`(`rfid_tag_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`quarantine_hold` ADD CONSTRAINT `fk_inventory_quarantine_hold_stock_position_id` FOREIGN KEY (`stock_position_id`) REFERENCES `apparel_fashion_ecm`.`inventory`.`stock_position`(`stock_position_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`quarantine_hold` ADD CONSTRAINT `fk_inventory_quarantine_hold_warehouse_location_id` FOREIGN KEY (`warehouse_location_id`) REFERENCES `apparel_fashion_ecm`.`inventory`.`warehouse_location`(`warehouse_location_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`asn` ADD CONSTRAINT `fk_inventory_asn_warehouse_location_id` FOREIGN KEY (`warehouse_location_id`) REFERENCES `apparel_fashion_ecm`.`inventory`.`warehouse_location`(`warehouse_location_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`asn` ADD CONSTRAINT `fk_inventory_asn_asn_warehouse_location_id` FOREIGN KEY (`asn_warehouse_location_id`) REFERENCES `apparel_fashion_ecm`.`inventory`.`warehouse_location`(`warehouse_location_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`lot_batch` ADD CONSTRAINT `fk_inventory_lot_batch_warehouse_location_id` FOREIGN KEY (`warehouse_location_id`) REFERENCES `apparel_fashion_ecm`.`inventory`.`warehouse_location`(`warehouse_location_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`goods_receipt` ADD CONSTRAINT `fk_inventory_goods_receipt_asn_id` FOREIGN KEY (`asn_id`) REFERENCES `apparel_fashion_ecm`.`inventory`.`asn`(`asn_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`goods_receipt` ADD CONSTRAINT `fk_inventory_goods_receipt_lot_batch_id` FOREIGN KEY (`lot_batch_id`) REFERENCES `apparel_fashion_ecm`.`inventory`.`lot_batch`(`lot_batch_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`goods_receipt` ADD CONSTRAINT `fk_inventory_goods_receipt_correction_goods_receipt_id` FOREIGN KEY (`correction_goods_receipt_id`) REFERENCES `apparel_fashion_ecm`.`inventory`.`goods_receipt`(`goods_receipt_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`storefront_fulfillment_network` ADD CONSTRAINT `fk_inventory_storefront_fulfillment_network_warehouse_location_id` FOREIGN KEY (`warehouse_location_id`) REFERENCES `apparel_fashion_ecm`.`inventory`.`warehouse_location`(`warehouse_location_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`inventory_pool` ADD CONSTRAINT `fk_inventory_inventory_pool_warehouse_location_id` FOREIGN KEY (`warehouse_location_id`) REFERENCES `apparel_fashion_ecm`.`inventory`.`warehouse_location`(`warehouse_location_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`inventory_pool` ADD CONSTRAINT `fk_inventory_inventory_pool_parent_inventory_pool_id` FOREIGN KEY (`parent_inventory_pool_id`) REFERENCES `apparel_fashion_ecm`.`inventory`.`inventory_pool`(`inventory_pool_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`zone` ADD CONSTRAINT `fk_inventory_zone_parent_zone_id` FOREIGN KEY (`parent_zone_id`) REFERENCES `apparel_fashion_ecm`.`inventory`.`zone`(`zone_id`);
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`valuation_area` ADD CONSTRAINT `fk_inventory_valuation_area_parent_valuation_area_id` FOREIGN KEY (`parent_valuation_area_id`) REFERENCES `apparel_fashion_ecm`.`inventory`.`valuation_area`(`valuation_area_id`);

-- ========= TAGS =========
ALTER SCHEMA `apparel_fashion_ecm`.`inventory` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `apparel_fashion_ecm`.`inventory` SET TAGS ('dbx_domain' = 'inventory');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_position` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_position` SET TAGS ('dbx_subdomain' = 'stock_management');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_position` ALTER COLUMN `stock_position_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Position ID');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_position` ALTER COLUMN `digital_storefront_id` SET TAGS ('dbx_business_glossary_term' = 'Digital Storefront Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_position` ALTER COLUMN `inventory_pool_id` SET TAGS ('dbx_business_glossary_term' = 'Inventory Pool Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_position` ALTER COLUMN `otb_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Otb Budget Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_position` ALTER COLUMN `retail_store_id` SET TAGS ('dbx_business_glossary_term' = 'Retail Store Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_position` ALTER COLUMN `season_id` SET TAGS ('dbx_business_glossary_term' = 'Season Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_position` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_position` ALTER COLUMN `sustainable_material_id` SET TAGS ('dbx_business_glossary_term' = 'Sustainable Material Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_position` ALTER COLUMN `warehouse_location_id` SET TAGS ('dbx_business_glossary_term' = 'Location ID');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_position` ALTER COLUMN `aging_bucket` SET TAGS ('dbx_business_glossary_term' = 'Aging Bucket');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_position` ALTER COLUMN `aging_bucket` SET TAGS ('dbx_value_regex' = 'current_season|prior_season|aged|clearance');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_position` ALTER COLUMN `allocation_group` SET TAGS ('dbx_business_glossary_term' = 'Allocation Group');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_position` ALTER COLUMN `allocation_group` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{2,20}$');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_position` ALTER COLUMN `atp_quantity` SET TAGS ('dbx_business_glossary_term' = 'Available to Promise (ATP) Quantity');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_position` ALTER COLUMN `ats_quantity` SET TAGS ('dbx_business_glossary_term' = 'Available to Sell (ATS) Quantity');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_position` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_business_glossary_term' = 'Country of Origin');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_position` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_position` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_position` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_position` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_position` ALTER COLUMN `cycle_count_variance` SET TAGS ('dbx_business_glossary_term' = 'Cycle Count Variance');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_position` ALTER COLUMN `damaged_quantity` SET TAGS ('dbx_business_glossary_term' = 'Damaged Quantity');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_position` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_position` ALTER COLUMN `held_quantity` SET TAGS ('dbx_business_glossary_term' = 'Held Quantity');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_position` ALTER COLUMN `hs_code` SET TAGS ('dbx_business_glossary_term' = 'Harmonized System (HS) Code');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_position` ALTER COLUMN `hs_code` SET TAGS ('dbx_value_regex' = '^[0-9]{6,10}$');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_position` ALTER COLUMN `in_transit_quantity` SET TAGS ('dbx_business_glossary_term' = 'In Transit Quantity');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_position` ALTER COLUMN `last_adjustment_date` SET TAGS ('dbx_business_glossary_term' = 'Last Adjustment Date');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_position` ALTER COLUMN `last_cycle_count_date` SET TAGS ('dbx_business_glossary_term' = 'Last Cycle Count Date');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_position` ALTER COLUMN `last_receipt_date` SET TAGS ('dbx_business_glossary_term' = 'Last Receipt Date');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_position` ALTER COLUMN `last_sale_date` SET TAGS ('dbx_business_glossary_term' = 'Last Sale Date');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_position` ALTER COLUMN `lot_number` SET TAGS ('dbx_business_glossary_term' = 'Lot Number');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_position` ALTER COLUMN `lot_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{6,20}$');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_position` ALTER COLUMN `nos_flag` SET TAGS ('dbx_business_glossary_term' = 'Never Out of Stock (NOS) Flag');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_position` ALTER COLUMN `on_hand_quantity` SET TAGS ('dbx_business_glossary_term' = 'On Hand Quantity');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_position` ALTER COLUMN `ownership_type` SET TAGS ('dbx_business_glossary_term' = 'Ownership Type');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_position` ALTER COLUMN `ownership_type` SET TAGS ('dbx_value_regex' = 'owned|consignment|vendor_owned|customer_owned');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_position` ALTER COLUMN `reorder_point` SET TAGS ('dbx_business_glossary_term' = 'Reorder Point');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_position` ALTER COLUMN `replenishment_method` SET TAGS ('dbx_business_glossary_term' = 'Replenishment Method');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_position` ALTER COLUMN `replenishment_method` SET TAGS ('dbx_value_regex' = 'automatic|manual|vmi|cross_dock|drop_ship');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_position` ALTER COLUMN `reserved_quantity` SET TAGS ('dbx_business_glossary_term' = 'Reserved Quantity');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_position` ALTER COLUMN `rfid_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Radio Frequency Identification (RFID) Enabled Flag');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_position` ALTER COLUMN `safety_stock_quantity` SET TAGS ('dbx_business_glossary_term' = 'Safety Stock Quantity');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_position` ALTER COLUMN `snapshot_date` SET TAGS ('dbx_business_glossary_term' = 'Snapshot Date');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_position` ALTER COLUMN `stock_status` SET TAGS ('dbx_business_glossary_term' = 'Stock Status');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_position` ALTER COLUMN `stock_status` SET TAGS ('dbx_value_regex' = 'available|reserved|quarantine|damaged|in_transit|blocked');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_position` ALTER COLUMN `unit_cost` SET TAGS ('dbx_business_glossary_term' = 'Unit Cost');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_position` ALTER COLUMN `unit_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_position` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_position` ALTER COLUMN `valuation_class` SET TAGS ('dbx_business_glossary_term' = 'Valuation Class');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_position` ALTER COLUMN `valuation_class` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_position` ALTER COLUMN `vmi_flag` SET TAGS ('dbx_business_glossary_term' = 'Vendor Managed Inventory (VMI) Flag');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_position` ALTER COLUMN `wos` SET TAGS ('dbx_business_glossary_term' = 'Weeks of Supply (WOS)');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_movement` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_movement` SET TAGS ('dbx_subdomain' = 'stock_management');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_movement` ALTER COLUMN `stock_movement_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Movement ID');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_movement` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Employee Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_movement` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_movement` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_movement` ALTER COLUMN `asn_id` SET TAGS ('dbx_business_glossary_term' = 'Asn Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_movement` ALTER COLUMN `bill_of_lading_id` SET TAGS ('dbx_business_glossary_term' = 'Bill Of Lading Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_movement` ALTER COLUMN `customs_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Customs Entry Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_movement` ALTER COLUMN `warehouse_location_id` SET TAGS ('dbx_business_glossary_term' = 'Destination Location ID');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_movement` ALTER COLUMN `digital_order_id` SET TAGS ('dbx_business_glossary_term' = 'Digital Order Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_movement` ALTER COLUMN `digital_return_id` SET TAGS ('dbx_business_glossary_term' = 'Digital Return Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_movement` ALTER COLUMN `freight_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Freight Invoice Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_movement` ALTER COLUMN `goods_receipt_id` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_movement` ALTER COLUMN `inspection_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_movement` ALTER COLUMN `inventory_cycle_count_id` SET TAGS ('dbx_business_glossary_term' = 'Inventory Cycle Count Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_movement` ALTER COLUMN `lot_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Batch Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_movement` ALTER COLUMN `order_purchase_order_line_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Line Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_movement` ALTER COLUMN `otb_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Otb Budget Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_movement` ALTER COLUMN `primary_stock_warehouse_location_id` SET TAGS ('dbx_business_glossary_term' = 'Source Location ID');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_movement` ALTER COLUMN `lot_id` SET TAGS ('dbx_business_glossary_term' = 'Production Lot Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_movement` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_movement` ALTER COLUMN `quarantine_hold_id` SET TAGS ('dbx_business_glossary_term' = 'Quarantine Hold Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_movement` ALTER COLUMN `replenishment_order_id` SET TAGS ('dbx_business_glossary_term' = 'Replenishment Order Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_movement` ALTER COLUMN `reservation_id` SET TAGS ('dbx_business_glossary_term' = 'Reservation Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_movement` ALTER COLUMN `retail_store_id` SET TAGS ('dbx_business_glossary_term' = 'Retail Store Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_movement` ALTER COLUMN `return_shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Return Shipment Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_movement` ALTER COLUMN `rfid_tag_id` SET TAGS ('dbx_business_glossary_term' = 'Radio Frequency Identification (RFID) Tag ID');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_movement` ALTER COLUMN `rma_id` SET TAGS ('dbx_business_glossary_term' = 'Rma Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_movement` ALTER COLUMN `routing_guide_id` SET TAGS ('dbx_business_glossary_term' = 'Routing Guide Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_movement` ALTER COLUMN `sales_order_id` SET TAGS ('dbx_business_glossary_term' = 'Sales Order Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_movement` ALTER COLUMN `season_id` SET TAGS ('dbx_business_glossary_term' = 'Season Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_movement` ALTER COLUMN `shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Logistics Shipment Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_movement` ALTER COLUMN `sourcing_purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Sourcing Purchase Order Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_movement` ALTER COLUMN `style_id` SET TAGS ('dbx_business_glossary_term' = 'Product ID');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_movement` ALTER COLUMN `sustainable_material_id` SET TAGS ('dbx_business_glossary_term' = 'Sustainable Material Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_movement` ALTER COLUMN `third_party_logistics_id` SET TAGS ('dbx_business_glossary_term' = '3Pl Partner Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_movement` ALTER COLUMN `transfer_order_id` SET TAGS ('dbx_business_glossary_term' = 'Transfer Order Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_movement` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_movement` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_movement` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_movement` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'approved|pending_approval|rejected|not_required');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_movement` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_movement` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_movement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_movement` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_movement` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_movement` ALTER COLUMN `destination_location_code` SET TAGS ('dbx_business_glossary_term' = 'Destination Location Code');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_movement` ALTER COLUMN `destination_location_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,10}$');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_movement` ALTER COLUMN `destination_location_type` SET TAGS ('dbx_business_glossary_term' = 'Destination Location Type');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_movement` ALTER COLUMN `destination_location_type` SET TAGS ('dbx_value_regex' = 'warehouse|distribution_center|retail_store|3pl_facility|customer|scrap');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_movement` ALTER COLUMN `document_date` SET TAGS ('dbx_business_glossary_term' = 'Document Date');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_movement` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_movement` ALTER COLUMN `movement_category` SET TAGS ('dbx_business_glossary_term' = 'Movement Category');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_movement` ALTER COLUMN `movement_category` SET TAGS ('dbx_value_regex' = 'goods_receipt|goods_issue|transfer|adjustment|return|write_off');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_movement` ALTER COLUMN `movement_document_number` SET TAGS ('dbx_business_glossary_term' = 'Movement Document Number');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_movement` ALTER COLUMN `movement_document_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_movement` ALTER COLUMN `movement_quantity` SET TAGS ('dbx_business_glossary_term' = 'Movement Quantity');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_movement` ALTER COLUMN `movement_status` SET TAGS ('dbx_business_glossary_term' = 'Movement Status');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_movement` ALTER COLUMN `movement_status` SET TAGS ('dbx_value_regex' = 'posted|pending|cancelled|reversed');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_movement` ALTER COLUMN `movement_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Movement Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_movement` ALTER COLUMN `movement_type_code` SET TAGS ('dbx_business_glossary_term' = 'Movement Type Code');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_movement` ALTER COLUMN `movement_type_code` SET TAGS ('dbx_value_regex' = '^[0-9]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_movement` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Movement Notes');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_movement` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Date');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_movement` ALTER COLUMN `reason_code` SET TAGS ('dbx_business_glossary_term' = 'Reason Code');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_movement` ALTER COLUMN `reason_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,6}$');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_movement` ALTER COLUMN `reason_description` SET TAGS ('dbx_business_glossary_term' = 'Reason Description');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_movement` ALTER COLUMN `reference_document_line_number` SET TAGS ('dbx_business_glossary_term' = 'Reference Document Line Number');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_movement` ALTER COLUMN `reference_document_number` SET TAGS ('dbx_business_glossary_term' = 'Reference Document Number');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_movement` ALTER COLUMN `reference_document_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_movement` ALTER COLUMN `reference_document_type` SET TAGS ('dbx_business_glossary_term' = 'Reference Document Type');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_movement` ALTER COLUMN `reversal_indicator` SET TAGS ('dbx_business_glossary_term' = 'Reversal Indicator');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_movement` ALTER COLUMN `reversed_document_number` SET TAGS ('dbx_business_glossary_term' = 'Reversed Document Number');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_movement` ALTER COLUMN `reversed_document_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_movement` ALTER COLUMN `serial_number` SET TAGS ('dbx_business_glossary_term' = 'Serial Number');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_movement` ALTER COLUMN `serial_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,30}$');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_movement` ALTER COLUMN `sku` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU)');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_movement` ALTER COLUMN `sku` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{6,20}$');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_movement` ALTER COLUMN `source_location_code` SET TAGS ('dbx_business_glossary_term' = 'Source Location Code');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_movement` ALTER COLUMN `source_location_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,10}$');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_movement` ALTER COLUMN `source_location_type` SET TAGS ('dbx_business_glossary_term' = 'Source Location Type');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_movement` ALTER COLUMN `source_location_type` SET TAGS ('dbx_value_regex' = 'warehouse|distribution_center|retail_store|3pl_facility|supplier|transit');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_movement` ALTER COLUMN `stock_type` SET TAGS ('dbx_business_glossary_term' = 'Stock Type');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_movement` ALTER COLUMN `stock_type` SET TAGS ('dbx_value_regex' = 'unrestricted|quality_inspection|blocked|returns|consignment|vendor_managed');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_movement` ALTER COLUMN `total_cost` SET TAGS ('dbx_business_glossary_term' = 'Total Cost');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_movement` ALTER COLUMN `total_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_movement` ALTER COLUMN `unit_cost` SET TAGS ('dbx_business_glossary_term' = 'Unit Cost');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_movement` ALTER COLUMN `unit_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_movement` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_movement` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'EA|CS|PK|DZ|PR|ST');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_movement` ALTER COLUMN `upc` SET TAGS ('dbx_business_glossary_term' = 'Universal Product Code (UPC)');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_movement` ALTER COLUMN `upc` SET TAGS ('dbx_value_regex' = '^[0-9]{12,14}$');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_movement` ALTER COLUMN `valuation_type` SET TAGS ('dbx_business_glossary_term' = 'Valuation Type');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_movement` ALTER COLUMN `valuation_type` SET TAGS ('dbx_value_regex' = 'standard|moving_average|fifo|lifo');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`warehouse_location` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`warehouse_location` SET TAGS ('dbx_subdomain' = 'warehouse_operations');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`warehouse_location` ALTER COLUMN `warehouse_location_id` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Location Identifier (ID)');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`warehouse_location` ALTER COLUMN `distribution_center_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Identifier (ID)');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`warehouse_location` ALTER COLUMN `energy_consumption_id` SET TAGS ('dbx_business_glossary_term' = 'Energy Consumption Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`warehouse_location` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Manager Employee Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`warehouse_location` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`warehouse_location` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`warehouse_location` ALTER COLUMN `third_party_logistics_id` SET TAGS ('dbx_business_glossary_term' = '3Pl Partner Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`warehouse_location` ALTER COLUMN `waste_record_id` SET TAGS ('dbx_business_glossary_term' = 'Waste Record Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`warehouse_location` ALTER COLUMN `water_usage_id` SET TAGS ('dbx_business_glossary_term' = 'Water Usage Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`warehouse_location` ALTER COLUMN `zone_id` SET TAGS ('dbx_business_glossary_term' = 'Zone Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`warehouse_location` ALTER COLUMN `aisle_code` SET TAGS ('dbx_business_glossary_term' = 'Aisle Code');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`warehouse_location` ALTER COLUMN `aisle_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,10}$');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`warehouse_location` ALTER COLUMN `bin_code` SET TAGS ('dbx_business_glossary_term' = 'Bin Code');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`warehouse_location` ALTER COLUMN `bin_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,10}$');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`warehouse_location` ALTER COLUMN `bonded_warehouse_flag` SET TAGS ('dbx_business_glossary_term' = 'Bonded Warehouse Flag');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`warehouse_location` ALTER COLUMN `capacity_cubic_meters` SET TAGS ('dbx_business_glossary_term' = 'Capacity Cubic Meters');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`warehouse_location` ALTER COLUMN `capacity_units` SET TAGS ('dbx_business_glossary_term' = 'Capacity Units');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`warehouse_location` ALTER COLUMN `capacity_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Capacity Weight Kilograms (KG)');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`warehouse_location` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`warehouse_location` ALTER COLUMN `cycle_count_frequency_days` SET TAGS ('dbx_business_glossary_term' = 'Cycle Count Frequency Days');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`warehouse_location` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`warehouse_location` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`warehouse_location` ALTER COLUMN `hazmat_approved_flag` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Materials (HAZMAT) Approved Flag');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`warehouse_location` ALTER COLUMN `last_cycle_count_date` SET TAGS ('dbx_business_glossary_term' = 'Last Cycle Count Date');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`warehouse_location` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`warehouse_location` ALTER COLUMN `location_code` SET TAGS ('dbx_business_glossary_term' = 'Location Code');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`warehouse_location` ALTER COLUMN `location_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,20}$');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`warehouse_location` ALTER COLUMN `location_name` SET TAGS ('dbx_business_glossary_term' = 'Location Name');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`warehouse_location` ALTER COLUMN `location_status` SET TAGS ('dbx_business_glossary_term' = 'Location Status');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`warehouse_location` ALTER COLUMN `location_status` SET TAGS ('dbx_value_regex' = 'active|inactive|blocked|maintenance|reserved|quarantine');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`warehouse_location` ALTER COLUMN `location_type` SET TAGS ('dbx_business_glossary_term' = 'Location Type');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`warehouse_location` ALTER COLUMN `mixed_lot_allowed_flag` SET TAGS ('dbx_business_glossary_term' = 'Mixed Lot Allowed Flag');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`warehouse_location` ALTER COLUMN `mixed_sku_allowed_flag` SET TAGS ('dbx_business_glossary_term' = 'Mixed Stock Keeping Unit (SKU) Allowed Flag');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`warehouse_location` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`warehouse_location` ALTER COLUMN `pick_sequence` SET TAGS ('dbx_business_glossary_term' = 'Pick Sequence');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`warehouse_location` ALTER COLUMN `putaway_priority` SET TAGS ('dbx_business_glossary_term' = 'Putaway Priority');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`warehouse_location` ALTER COLUMN `rack_code` SET TAGS ('dbx_business_glossary_term' = 'Rack Code');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`warehouse_location` ALTER COLUMN `rack_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,10}$');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`warehouse_location` ALTER COLUMN `replenishment_trigger_level` SET TAGS ('dbx_business_glossary_term' = 'Replenishment Trigger Level');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`warehouse_location` ALTER COLUMN `rfid_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Radio Frequency Identification (RFID) Enabled Flag');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`warehouse_location` ALTER COLUMN `shelf_code` SET TAGS ('dbx_business_glossary_term' = 'Shelf Code');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`warehouse_location` ALTER COLUMN `shelf_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,10}$');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`warehouse_location` ALTER COLUMN `temperature_zone` SET TAGS ('dbx_business_glossary_term' = 'Temperature Zone');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`warehouse_location` ALTER COLUMN `temperature_zone` SET TAGS ('dbx_value_regex' = 'ambient|refrigerated|frozen|climate_controlled');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`warehouse_location` ALTER COLUMN `vendor_managed_inventory_flag` SET TAGS ('dbx_business_glossary_term' = 'Vendor Managed Inventory (VMI) Flag');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`warehouse_location` ALTER COLUMN `x_coordinate` SET TAGS ('dbx_business_glossary_term' = 'X Coordinate');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`warehouse_location` ALTER COLUMN `y_coordinate` SET TAGS ('dbx_business_glossary_term' = 'Y Coordinate');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`warehouse_location` ALTER COLUMN `z_coordinate` SET TAGS ('dbx_business_glossary_term' = 'Z Coordinate');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`sku_location` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`sku_location` SET TAGS ('dbx_subdomain' = 'warehouse_operations');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`sku_location` ALTER COLUMN `sku_location_id` SET TAGS ('dbx_business_glossary_term' = 'SKU (Stock Keeping Unit) Location ID');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`sku_location` ALTER COLUMN `digital_storefront_id` SET TAGS ('dbx_business_glossary_term' = 'Digital Storefront Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`sku_location` ALTER COLUMN `distribution_center_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`sku_location` ALTER COLUMN `otb_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Otb Budget Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`sku_location` ALTER COLUMN `packaging_sustainability_id` SET TAGS ('dbx_business_glossary_term' = 'Packaging Sustainability Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`sku_location` ALTER COLUMN `retail_store_id` SET TAGS ('dbx_business_glossary_term' = 'Retail Store Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`sku_location` ALTER COLUMN `season_id` SET TAGS ('dbx_business_glossary_term' = 'Season Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`sku_location` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'SKU (Stock Keeping Unit) ID');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`sku_location` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'VMI (Vendor Managed Inventory) Vendor ID');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`sku_location` ALTER COLUMN `warehouse_location_id` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Location Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`sku_location` ALTER COLUMN `zone_id` SET TAGS ('dbx_business_glossary_term' = 'Zone Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`sku_location` ALTER COLUMN `allocated_quantity` SET TAGS ('dbx_business_glossary_term' = 'Allocated Quantity');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`sku_location` ALTER COLUMN `assignment_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment Effective Date');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`sku_location` ALTER COLUMN `assignment_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment Expiration Date');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`sku_location` ALTER COLUMN `assignment_status` SET TAGS ('dbx_business_glossary_term' = 'Assignment Status');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`sku_location` ALTER COLUMN `assignment_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|blocked|temporary');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`sku_location` ALTER COLUMN `atp_quantity` SET TAGS ('dbx_business_glossary_term' = 'ATP (Available to Promise) Quantity');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`sku_location` ALTER COLUMN `ats_quantity` SET TAGS ('dbx_business_glossary_term' = 'ATS (Available to Sell) Quantity');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`sku_location` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`sku_location` ALTER COLUMN `current_stock_quantity` SET TAGS ('dbx_business_glossary_term' = 'Current Stock Quantity');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`sku_location` ALTER COLUMN `cycle_count_frequency_days` SET TAGS ('dbx_business_glossary_term' = 'Cycle Count Frequency Days');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`sku_location` ALTER COLUMN `damaged_quantity` SET TAGS ('dbx_business_glossary_term' = 'Damaged Quantity');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`sku_location` ALTER COLUMN `in_transit_quantity` SET TAGS ('dbx_business_glossary_term' = 'In Transit Quantity');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`sku_location` ALTER COLUMN `last_cycle_count_date` SET TAGS ('dbx_business_glossary_term' = 'Last Cycle Count Date');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`sku_location` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`sku_location` ALTER COLUMN `location_capacity_units` SET TAGS ('dbx_business_glossary_term' = 'Location Capacity Units');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`sku_location` ALTER COLUMN `location_capacity_volume_cubic_meters` SET TAGS ('dbx_business_glossary_term' = 'Location Capacity Volume Cubic Meters');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`sku_location` ALTER COLUMN `location_capacity_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Location Capacity Weight Kilograms');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`sku_location` ALTER COLUMN `location_type` SET TAGS ('dbx_business_glossary_term' = 'Location Type');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`sku_location` ALTER COLUMN `location_type` SET TAGS ('dbx_value_regex' = 'primary_pick|reserve|overflow|bulk|cross_dock|quarantine');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`sku_location` ALTER COLUMN `max_stock_quantity` SET TAGS ('dbx_business_glossary_term' = 'Maximum Stock Quantity');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`sku_location` ALTER COLUMN `min_stock_quantity` SET TAGS ('dbx_business_glossary_term' = 'Minimum Stock Quantity');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`sku_location` ALTER COLUMN `next_cycle_count_date` SET TAGS ('dbx_business_glossary_term' = 'Next Cycle Count Date');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`sku_location` ALTER COLUMN `nos_classification_tier` SET TAGS ('dbx_business_glossary_term' = 'NOS (Never Out of Stock) Classification Tier');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`sku_location` ALTER COLUMN `nos_classification_tier` SET TAGS ('dbx_value_regex' = 'tier_1|tier_2|tier_3|non_nos');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`sku_location` ALTER COLUMN `nos_policy_code` SET TAGS ('dbx_business_glossary_term' = 'NOS (Never Out of Stock) Policy Code');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`sku_location` ALTER COLUMN `nos_policy_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,10}$');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`sku_location` ALTER COLUMN `overflow_location_code` SET TAGS ('dbx_business_glossary_term' = 'Overflow Location Code');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`sku_location` ALTER COLUMN `overflow_location_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,20}$');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`sku_location` ALTER COLUMN `pick_sequence_number` SET TAGS ('dbx_business_glossary_term' = 'Pick Sequence Number');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`sku_location` ALTER COLUMN `primary_pick_location_flag` SET TAGS ('dbx_business_glossary_term' = 'Primary Pick Location Flag');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`sku_location` ALTER COLUMN `quarantine_quantity` SET TAGS ('dbx_business_glossary_term' = 'Quarantine Quantity');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`sku_location` ALTER COLUMN `reorder_point_quantity` SET TAGS ('dbx_business_glossary_term' = 'Reorder Point Quantity');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`sku_location` ALTER COLUMN `replenishment_lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Replenishment Lead Time Days');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`sku_location` ALTER COLUMN `replenishment_method` SET TAGS ('dbx_business_glossary_term' = 'Replenishment Method');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`sku_location` ALTER COLUMN `replenishment_method` SET TAGS ('dbx_value_regex' = 'min_max|reorder_point|periodic|demand_driven|vmi');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`sku_location` ALTER COLUMN `reserved_quantity` SET TAGS ('dbx_business_glossary_term' = 'Reserved Quantity');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`sku_location` ALTER COLUMN `rfid_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'RFID (Radio Frequency Identification) Enabled Flag');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`sku_location` ALTER COLUMN `safety_stock_quantity` SET TAGS ('dbx_business_glossary_term' = 'Safety Stock Quantity');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`sku_location` ALTER COLUMN `slotting_priority_rank` SET TAGS ('dbx_business_glossary_term' = 'Slotting Priority Rank');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`sku_location` ALTER COLUMN `vmi_indicator` SET TAGS ('dbx_business_glossary_term' = 'VMI (Vendor Managed Inventory) Indicator');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`sku_location` ALTER COLUMN `wos_current` SET TAGS ('dbx_business_glossary_term' = 'WOS (Weeks of Supply) Current');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`sku_location` ALTER COLUMN `wos_target` SET TAGS ('dbx_business_glossary_term' = 'WOS (Weeks of Supply) Target');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`inventory_cycle_count` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`inventory_cycle_count` SET TAGS ('dbx_subdomain' = 'warehouse_operations');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`inventory_cycle_count` ALTER COLUMN `inventory_cycle_count_id` SET TAGS ('dbx_business_glossary_term' = 'Inventory Cycle Count ID');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`inventory_cycle_count` ALTER COLUMN `lot_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Batch Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`inventory_cycle_count` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Counter ID');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`inventory_cycle_count` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`inventory_cycle_count` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`inventory_cycle_count` ALTER COLUMN `retail_store_id` SET TAGS ('dbx_business_glossary_term' = 'Retail Store Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`inventory_cycle_count` ALTER COLUMN `season_id` SET TAGS ('dbx_business_glossary_term' = 'Season Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`inventory_cycle_count` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) ID');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`inventory_cycle_count` ALTER COLUMN `warehouse_location_id` SET TAGS ('dbx_business_glossary_term' = 'Location ID');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`inventory_cycle_count` ALTER COLUMN `zone_id` SET TAGS ('dbx_business_glossary_term' = 'Zone ID');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`inventory_cycle_count` ALTER COLUMN `abc_classification` SET TAGS ('dbx_business_glossary_term' = 'ABC Classification');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`inventory_cycle_count` ALTER COLUMN `abc_classification` SET TAGS ('dbx_value_regex' = 'A|B|C');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`inventory_cycle_count` ALTER COLUMN `adjustment_amount` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Amount');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`inventory_cycle_count` ALTER COLUMN `adjustment_document_number` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Document Number');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`inventory_cycle_count` ALTER COLUMN `adjustment_document_number` SET TAGS ('dbx_value_regex' = '^ADJ-[0-9]{10}$');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`inventory_cycle_count` ALTER COLUMN `adjustment_posted_flag` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Posted Flag');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`inventory_cycle_count` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`inventory_cycle_count` ALTER COLUMN `approved_quantity` SET TAGS ('dbx_business_glossary_term' = 'Approved Quantity');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`inventory_cycle_count` ALTER COLUMN `count_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Count End Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`inventory_cycle_count` ALTER COLUMN `count_method` SET TAGS ('dbx_business_glossary_term' = 'Count Method');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`inventory_cycle_count` ALTER COLUMN `count_method` SET TAGS ('dbx_value_regex' = 'manual|handheld_scanner|rfid_reader|automated_system');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`inventory_cycle_count` ALTER COLUMN `count_notes` SET TAGS ('dbx_business_glossary_term' = 'Count Notes');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`inventory_cycle_count` ALTER COLUMN `count_number` SET TAGS ('dbx_business_glossary_term' = 'Cycle Count Number');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`inventory_cycle_count` ALTER COLUMN `count_number` SET TAGS ('dbx_value_regex' = '^CC-[0-9]{8}-[A-Z0-9]{6}$');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`inventory_cycle_count` ALTER COLUMN `count_reason` SET TAGS ('dbx_business_glossary_term' = 'Cycle Count Reason');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`inventory_cycle_count` ALTER COLUMN `count_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Count Start Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`inventory_cycle_count` ALTER COLUMN `count_status` SET TAGS ('dbx_business_glossary_term' = 'Cycle Count Status');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`inventory_cycle_count` ALTER COLUMN `count_type` SET TAGS ('dbx_business_glossary_term' = 'Cycle Count Type');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`inventory_cycle_count` ALTER COLUMN `count_type` SET TAGS ('dbx_value_regex' = 'full|partial|abc_class|rfid_assisted|blind|targeted');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`inventory_cycle_count` ALTER COLUMN `counted_quantity` SET TAGS ('dbx_business_glossary_term' = 'Counted Quantity');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`inventory_cycle_count` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`inventory_cycle_count` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`inventory_cycle_count` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`inventory_cycle_count` ALTER COLUMN `expected_quantity` SET TAGS ('dbx_business_glossary_term' = 'Expected Quantity');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`inventory_cycle_count` ALTER COLUMN `inventory_status` SET TAGS ('dbx_business_glossary_term' = 'Inventory Status');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`inventory_cycle_count` ALTER COLUMN `inventory_status` SET TAGS ('dbx_value_regex' = 'available|reserved|quarantine|damaged|expired|return_to_vendor');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`inventory_cycle_count` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`inventory_cycle_count` ALTER COLUMN `recount_flag` SET TAGS ('dbx_business_glossary_term' = 'Recount Required Flag');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`inventory_cycle_count` ALTER COLUMN `recount_number` SET TAGS ('dbx_business_glossary_term' = 'Recount Attempt Number');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`inventory_cycle_count` ALTER COLUMN `scheduled_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Count Date');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`inventory_cycle_count` ALTER COLUMN `serial_number` SET TAGS ('dbx_business_glossary_term' = 'Serial Number');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`inventory_cycle_count` ALTER COLUMN `serial_number` SET TAGS ('dbx_value_regex' = '^SN-[A-Z0-9]{10,15}$');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`inventory_cycle_count` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`inventory_cycle_count` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'EA|CS|PK|DZ|PR|ST');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`inventory_cycle_count` ALTER COLUMN `variance_percentage` SET TAGS ('dbx_business_glossary_term' = 'Variance Percentage');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`inventory_cycle_count` ALTER COLUMN `variance_quantity` SET TAGS ('dbx_business_glossary_term' = 'Variance Quantity');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`inventory_cycle_count` ALTER COLUMN `variance_threshold_percentage` SET TAGS ('dbx_business_glossary_term' = 'Variance Threshold Percentage');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`transfer_order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`transfer_order` SET TAGS ('dbx_subdomain' = 'fulfillment_logistics');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`transfer_order` ALTER COLUMN `transfer_order_id` SET TAGS ('dbx_business_glossary_term' = 'Transfer Order ID');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`transfer_order` ALTER COLUMN `carbon_emission_id` SET TAGS ('dbx_business_glossary_term' = 'Carbon Emission Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`transfer_order` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier ID');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`transfer_order` ALTER COLUMN `warehouse_location_id` SET TAGS ('dbx_business_glossary_term' = 'Destination Location ID');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`transfer_order` ALTER COLUMN `freight_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Freight Invoice Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`transfer_order` ALTER COLUMN `otb_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Otb Budget Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`transfer_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`transfer_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`transfer_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`transfer_order` ALTER COLUMN `primary_transfer_warehouse_location_id` SET TAGS ('dbx_business_glossary_term' = 'Source Location ID');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`transfer_order` ALTER COLUMN `inspection_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Inspection Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`transfer_order` ALTER COLUMN `routing_guide_id` SET TAGS ('dbx_business_glossary_term' = 'Routing Guide Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`transfer_order` ALTER COLUMN `season_id` SET TAGS ('dbx_business_glossary_term' = 'Season Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`transfer_order` ALTER COLUMN `shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Logistics Shipment Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`transfer_order` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) ID');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`transfer_order` ALTER COLUMN `retail_store_id` SET TAGS ('dbx_business_glossary_term' = 'Source Retail Store Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`transfer_order` ALTER COLUMN `tertiary_transfer_cancelled_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Cancelled By User ID');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`transfer_order` ALTER COLUMN `tertiary_transfer_cancelled_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`transfer_order` ALTER COLUMN `tertiary_transfer_cancelled_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`transfer_order` ALTER COLUMN `third_party_logistics_id` SET TAGS ('dbx_business_glossary_term' = '3Pl Partner Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`transfer_order` ALTER COLUMN `actual_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Delivery Date');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`transfer_order` ALTER COLUMN `actual_freight_cost` SET TAGS ('dbx_business_glossary_term' = 'Actual Freight Cost');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`transfer_order` ALTER COLUMN `actual_ship_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Ship Date');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`transfer_order` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`transfer_order` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`transfer_order` ALTER COLUMN `cancelled_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Cancelled Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`transfer_order` ALTER COLUMN `completed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Completed Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`transfer_order` ALTER COLUMN `confirmed_quantity` SET TAGS ('dbx_business_glossary_term' = 'Confirmed Quantity');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`transfer_order` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`transfer_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`transfer_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`transfer_order` ALTER COLUMN `estimated_freight_cost` SET TAGS ('dbx_business_glossary_term' = 'Estimated Freight Cost');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`transfer_order` ALTER COLUMN `freight_terms` SET TAGS ('dbx_business_glossary_term' = 'Freight Terms');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`transfer_order` ALTER COLUMN `freight_terms` SET TAGS ('dbx_value_regex' = 'prepaid|collect|third_party|fob_origin|fob_destination');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`transfer_order` ALTER COLUMN `hazmat_indicator` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Material (HAZMAT) Indicator');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`transfer_order` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`transfer_order` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Transfer Order Notes');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`transfer_order` ALTER COLUMN `otif_status` SET TAGS ('dbx_business_glossary_term' = 'On Time In Full (OTIF) Status');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`transfer_order` ALTER COLUMN `otif_status` SET TAGS ('dbx_value_regex' = 'on_time_in_full|late|short|late_and_short|pending');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`transfer_order` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`transfer_order` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'low|normal|high|urgent|critical');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`transfer_order` ALTER COLUMN `reason_code` SET TAGS ('dbx_business_glossary_term' = 'Reason Code');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`transfer_order` ALTER COLUMN `received_quantity` SET TAGS ('dbx_business_glossary_term' = 'Received Quantity');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`transfer_order` ALTER COLUMN `requested_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Requested Delivery Date');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`transfer_order` ALTER COLUMN `requested_quantity` SET TAGS ('dbx_business_glossary_term' = 'Requested Quantity');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`transfer_order` ALTER COLUMN `requested_ship_date` SET TAGS ('dbx_business_glossary_term' = 'Requested Ship Date');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`transfer_order` ALTER COLUMN `rfid_tracked` SET TAGS ('dbx_business_glossary_term' = 'Radio Frequency Identification (RFID) Tracked');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`transfer_order` ALTER COLUMN `shipment_method` SET TAGS ('dbx_business_glossary_term' = 'Shipment Method');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`transfer_order` ALTER COLUMN `shipment_method` SET TAGS ('dbx_value_regex' = 'ground|air|ocean|rail|intermodal|courier');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`transfer_order` ALTER COLUMN `shipped_quantity` SET TAGS ('dbx_business_glossary_term' = 'Shipped Quantity');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`transfer_order` ALTER COLUMN `source_document_number` SET TAGS ('dbx_business_glossary_term' = 'Source Document Number');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`transfer_order` ALTER COLUMN `source_document_type` SET TAGS ('dbx_business_glossary_term' = 'Source Document Type');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`transfer_order` ALTER COLUMN `source_document_type` SET TAGS ('dbx_value_regex' = 'manual|allocation_plan|replenishment_rule|purchase_order|sales_order|recall_notice');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`transfer_order` ALTER COLUMN `temperature_controlled` SET TAGS ('dbx_business_glossary_term' = 'Temperature Controlled');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`transfer_order` ALTER COLUMN `tracking_number` SET TAGS ('dbx_business_glossary_term' = 'Tracking Number');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`transfer_order` ALTER COLUMN `transfer_order_number` SET TAGS ('dbx_business_glossary_term' = 'Transfer Order Number');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`transfer_order` ALTER COLUMN `transfer_order_number` SET TAGS ('dbx_value_regex' = '^TO-[0-9]{8,12}$');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`transfer_order` ALTER COLUMN `transfer_status` SET TAGS ('dbx_business_glossary_term' = 'Transfer Status');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`transfer_order` ALTER COLUMN `transfer_type` SET TAGS ('dbx_business_glossary_term' = 'Transfer Type');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`transfer_order` ALTER COLUMN `transfer_type` SET TAGS ('dbx_value_regex' = 'replenishment|rebalancing|recall|return|consolidation|emergency');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`transfer_order` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`transfer_order` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'EA|CS|PK|BX|PL|DZ');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`rfid_tag` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`rfid_tag` SET TAGS ('dbx_subdomain' = 'quality_traceability');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`rfid_tag` ALTER COLUMN `rfid_tag_id` SET TAGS ('dbx_business_glossary_term' = 'Radio Frequency Identification (RFID) Tag ID');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`rfid_tag` ALTER COLUMN `lot_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Tag Batch ID');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`rfid_tag` ALTER COLUMN `pos_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Point of Sale (POS) Transaction ID');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`rfid_tag` ALTER COLUMN `product_safety_test_id` SET TAGS ('dbx_business_glossary_term' = 'Product Safety Test Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`rfid_tag` ALTER COLUMN `return_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Return Transaction ID');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`rfid_tag` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`rfid_tag` ALTER COLUMN `attachment_location` SET TAGS ('dbx_business_glossary_term' = 'Attachment Location');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`rfid_tag` ALTER COLUMN `attachment_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Tag Attachment Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`rfid_tag` ALTER COLUMN `authentication_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Authentication Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`rfid_tag` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`rfid_tag` ALTER COLUMN `decommission_reason` SET TAGS ('dbx_business_glossary_term' = 'Decommission Reason');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`rfid_tag` ALTER COLUMN `decommission_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Decommission Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`rfid_tag` ALTER COLUMN `encoding_location` SET TAGS ('dbx_business_glossary_term' = 'Encoding Location');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`rfid_tag` ALTER COLUMN `encoding_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Tag Encoding Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`rfid_tag` ALTER COLUMN `epc` SET TAGS ('dbx_business_glossary_term' = 'Electronic Product Code (EPC)');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`rfid_tag` ALTER COLUMN `epc` SET TAGS ('dbx_value_regex' = '^urn:epc:id:sgtin:[0-9]{1,13}.[0-9]{1,7}.[0-9]{1,12}$');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`rfid_tag` ALTER COLUMN `first_read_location` SET TAGS ('dbx_business_glossary_term' = 'First Read Location');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`rfid_tag` ALTER COLUMN `first_read_timestamp` SET TAGS ('dbx_business_glossary_term' = 'First Read Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`rfid_tag` ALTER COLUMN `is_authenticated` SET TAGS ('dbx_business_glossary_term' = 'Is Authenticated Tag');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`rfid_tag` ALTER COLUMN `is_reusable` SET TAGS ('dbx_business_glossary_term' = 'Is Reusable Tag');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`rfid_tag` ALTER COLUMN `last_read_context` SET TAGS ('dbx_business_glossary_term' = 'Last Read Context');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`rfid_tag` ALTER COLUMN `last_read_device_code` SET TAGS ('dbx_business_glossary_term' = 'Last Read Device ID');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`rfid_tag` ALTER COLUMN `last_read_device_code` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`rfid_tag` ALTER COLUMN `last_read_device_code` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`rfid_tag` ALTER COLUMN `last_read_location` SET TAGS ('dbx_business_glossary_term' = 'Last Read Location');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`rfid_tag` ALTER COLUMN `last_read_signal_strength` SET TAGS ('dbx_business_glossary_term' = 'Last Read Signal Strength (dBm)');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`rfid_tag` ALTER COLUMN `last_read_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Read Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`rfid_tag` ALTER COLUMN `lock_status` SET TAGS ('dbx_business_glossary_term' = 'Tag Lock Status');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`rfid_tag` ALTER COLUMN `lock_status` SET TAGS ('dbx_value_regex' = 'unlocked|locked|permalocked');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`rfid_tag` ALTER COLUMN `return_location` SET TAGS ('dbx_business_glossary_term' = 'Return Location');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`rfid_tag` ALTER COLUMN `return_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Return Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`rfid_tag` ALTER COLUMN `sale_location` SET TAGS ('dbx_business_glossary_term' = 'Sale Location');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`rfid_tag` ALTER COLUMN `sale_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Sale Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`rfid_tag` ALTER COLUMN `serial_number` SET TAGS ('dbx_business_glossary_term' = 'Item Serial Number');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`rfid_tag` ALTER COLUMN `sku` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU)');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`rfid_tag` ALTER COLUMN `tag_encoding_standard` SET TAGS ('dbx_business_glossary_term' = 'Tag Encoding Standard');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`rfid_tag` ALTER COLUMN `tag_encoding_standard` SET TAGS ('dbx_value_regex' = 'SGTIN-96|SGTIN-198|SSCC-96|GRAI-96|GIAI-96');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`rfid_tag` ALTER COLUMN `tag_lifecycle_status` SET TAGS ('dbx_business_glossary_term' = 'Tag Lifecycle Status');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`rfid_tag` ALTER COLUMN `tag_manufacturer` SET TAGS ('dbx_business_glossary_term' = 'Tag Manufacturer');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`rfid_tag` ALTER COLUMN `tag_memory_size` SET TAGS ('dbx_business_glossary_term' = 'Tag Memory Size (bits)');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`rfid_tag` ALTER COLUMN `tag_model` SET TAGS ('dbx_business_glossary_term' = 'Tag Model');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`rfid_tag` ALTER COLUMN `tag_type` SET TAGS ('dbx_business_glossary_term' = 'RFID Tag Type');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`rfid_tag` ALTER COLUMN `tag_type` SET TAGS ('dbx_value_regex' = 'UHF|HF|NFC|LF');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`rfid_tag` ALTER COLUMN `total_read_count` SET TAGS ('dbx_business_glossary_term' = 'Total Read Count');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`rfid_tag` ALTER COLUMN `upc` SET TAGS ('dbx_business_glossary_term' = 'Universal Product Code (UPC)');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`rfid_tag` ALTER COLUMN `upc` SET TAGS ('dbx_value_regex' = '^[0-9]{12}$');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`rfid_tag` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`replenishment_order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`replenishment_order` SET TAGS ('dbx_subdomain' = 'fulfillment_logistics');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`replenishment_order` ALTER COLUMN `replenishment_order_id` SET TAGS ('dbx_business_glossary_term' = 'Replenishment Order ID');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`replenishment_order` ALTER COLUMN `allocation_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Allocation Plan ID');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`replenishment_order` ALTER COLUMN `carbon_emission_id` SET TAGS ('dbx_business_glossary_term' = 'Carbon Emission Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`replenishment_order` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier ID');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`replenishment_order` ALTER COLUMN `warehouse_location_id` SET TAGS ('dbx_business_glossary_term' = 'Destination Location ID');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`replenishment_order` ALTER COLUMN `retail_store_id` SET TAGS ('dbx_business_glossary_term' = 'Destination Retail Store Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`replenishment_order` ALTER COLUMN `digital_storefront_id` SET TAGS ('dbx_business_glossary_term' = 'Digital Storefront Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`replenishment_order` ALTER COLUMN `merchandise_hierarchy_id` SET TAGS ('dbx_business_glossary_term' = 'Merchandise Hierarchy Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`replenishment_order` ALTER COLUMN `nos_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Nos Policy Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`replenishment_order` ALTER COLUMN `otb_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Otb Budget Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`replenishment_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Planner ID');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`replenishment_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`replenishment_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`replenishment_order` ALTER COLUMN `primary_replenishment_warehouse_location_id` SET TAGS ('dbx_business_glossary_term' = 'Source Location ID');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`replenishment_order` ALTER COLUMN `routing_guide_id` SET TAGS ('dbx_business_glossary_term' = 'Routing Guide Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`replenishment_order` ALTER COLUMN `season_id` SET TAGS ('dbx_business_glossary_term' = 'Season ID');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`replenishment_order` ALTER COLUMN `shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Logistics Shipment Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`replenishment_order` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) ID');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`replenishment_order` ALTER COLUMN `standard_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Standard Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`replenishment_order` ALTER COLUMN `style_id` SET TAGS ('dbx_business_glossary_term' = 'Product ID');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`replenishment_order` ALTER COLUMN `third_party_logistics_id` SET TAGS ('dbx_business_glossary_term' = '3Pl Partner Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`replenishment_order` ALTER COLUMN `vmi_program_id` SET TAGS ('dbx_business_glossary_term' = 'Vmi Program Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`replenishment_order` ALTER COLUMN `actual_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Delivery Date');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`replenishment_order` ALTER COLUMN `actual_ship_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Ship Date');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`replenishment_order` ALTER COLUMN `approved_quantity` SET TAGS ('dbx_business_glossary_term' = 'Approved Quantity');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`replenishment_order` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`replenishment_order` ALTER COLUMN `ats_quantity_at_request` SET TAGS ('dbx_business_glossary_term' = 'Available to Sell (ATS) Quantity at Request');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`replenishment_order` ALTER COLUMN `cancelled_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`replenishment_order` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`replenishment_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`replenishment_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`replenishment_order` ALTER COLUMN `expected_ship_date` SET TAGS ('dbx_business_glossary_term' = 'Expected Ship Date');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`replenishment_order` ALTER COLUMN `freight_cost` SET TAGS ('dbx_business_glossary_term' = 'Freight Cost');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`replenishment_order` ALTER COLUMN `freight_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`replenishment_order` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`replenishment_order` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time Days');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`replenishment_order` ALTER COLUMN `max_stock_level` SET TAGS ('dbx_business_glossary_term' = 'Maximum Stock Level');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`replenishment_order` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Replenishment Order Notes');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`replenishment_order` ALTER COLUMN `on_hand_quantity_at_request` SET TAGS ('dbx_business_glossary_term' = 'On Hand Quantity at Request');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`replenishment_order` ALTER COLUMN `order_number` SET TAGS ('dbx_business_glossary_term' = 'Replenishment Order Number');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`replenishment_order` ALTER COLUMN `order_number` SET TAGS ('dbx_value_regex' = '^REP-[0-9]{8,12}$');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`replenishment_order` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`replenishment_order` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'critical|high|normal|low');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`replenishment_order` ALTER COLUMN `received_quantity` SET TAGS ('dbx_business_glossary_term' = 'Received Quantity');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`replenishment_order` ALTER COLUMN `reorder_point` SET TAGS ('dbx_business_glossary_term' = 'Reorder Point');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`replenishment_order` ALTER COLUMN `replenishment_order_status` SET TAGS ('dbx_business_glossary_term' = 'Replenishment Order Status');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`replenishment_order` ALTER COLUMN `replenishment_trigger` SET TAGS ('dbx_business_glossary_term' = 'Replenishment Trigger');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`replenishment_order` ALTER COLUMN `replenishment_trigger` SET TAGS ('dbx_value_regex' = 'below_reorder_point|nos_breach|otb_driven|demand_forecast|safety_stock_breach|allocation_plan');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`replenishment_order` ALTER COLUMN `replenishment_type` SET TAGS ('dbx_business_glossary_term' = 'Replenishment Type');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`replenishment_order` ALTER COLUMN `replenishment_type` SET TAGS ('dbx_value_regex' = 'automatic|manual|vmi|emergency|seasonal|promotional');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`replenishment_order` ALTER COLUMN `requested_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Requested Delivery Date');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`replenishment_order` ALTER COLUMN `requested_quantity` SET TAGS ('dbx_business_glossary_term' = 'Requested Quantity');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`replenishment_order` ALTER COLUMN `safety_stock_level` SET TAGS ('dbx_business_glossary_term' = 'Safety Stock Level');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`replenishment_order` ALTER COLUMN `service_level` SET TAGS ('dbx_business_glossary_term' = 'Service Level');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`replenishment_order` ALTER COLUMN `service_level` SET TAGS ('dbx_value_regex' = 'standard|expedited|next_day|two_day|economy');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`replenishment_order` ALTER COLUMN `shipment_method` SET TAGS ('dbx_business_glossary_term' = 'Shipment Method');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`replenishment_order` ALTER COLUMN `shipment_method` SET TAGS ('dbx_value_regex' = 'ground|air|ocean|rail|intermodal|courier');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`replenishment_order` ALTER COLUMN `shipped_quantity` SET TAGS ('dbx_business_glossary_term' = 'Shipped Quantity');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`replenishment_order` ALTER COLUMN `tracking_number` SET TAGS ('dbx_business_glossary_term' = 'Shipment Tracking Number');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`replenishment_order` ALTER COLUMN `tracking_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{10,30}$');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`replenishment_order` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`replenishment_order` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'EA|CS|PK|BX|PL');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`vmi_program` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`vmi_program` SET TAGS ('dbx_subdomain' = 'quality_traceability');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`vmi_program` ALTER COLUMN `vmi_program_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Managed Inventory (VMI) Program Identifier');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`vmi_program` ALTER COLUMN `merchandise_hierarchy_id` SET TAGS ('dbx_business_glossary_term' = 'Merchandise Hierarchy Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`vmi_program` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Program Manager Employee Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`vmi_program` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`vmi_program` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`vmi_program` ALTER COLUMN `season_id` SET TAGS ('dbx_business_glossary_term' = 'Season Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`vmi_program` ALTER COLUMN `standard_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Standard Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`vmi_program` ALTER COLUMN `supplier_factory_id` SET TAGS ('dbx_business_glossary_term' = 'Factory Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`vmi_program` ALTER COLUMN `third_party_logistics_id` SET TAGS ('dbx_business_glossary_term' = '3Pl Partner Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`vmi_program` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Identifier');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`vmi_program` ALTER COLUMN `warehouse_location_id` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Location Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`vmi_program` ALTER COLUMN `wholesale_account_id` SET TAGS ('dbx_business_glossary_term' = 'Wholesale Account Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`vmi_program` ALTER COLUMN `auto_renewal_enabled` SET TAGS ('dbx_business_glossary_term' = 'Auto Renewal Enabled Flag');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`vmi_program` ALTER COLUMN `contract_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Contract Document Reference');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`vmi_program` ALTER COLUMN `contract_document_reference` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`vmi_program` ALTER COLUMN `cost_sharing_model` SET TAGS ('dbx_business_glossary_term' = 'Cost Sharing Model');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`vmi_program` ALTER COLUMN `cost_sharing_model` SET TAGS ('dbx_value_regex' = 'supplier_bears_all|shared_carrying_cost|retailer_bears_all|tiered');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`vmi_program` ALTER COLUMN `cost_sharing_model` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`vmi_program` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`vmi_program` ALTER COLUMN `data_sharing_frequency` SET TAGS ('dbx_business_glossary_term' = 'Data Sharing Frequency');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`vmi_program` ALTER COLUMN `data_sharing_frequency` SET TAGS ('dbx_value_regex' = 'real_time|hourly|daily|weekly');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`vmi_program` ALTER COLUMN `edi_integration_method` SET TAGS ('dbx_business_glossary_term' = 'Electronic Data Interchange (EDI) Integration Method');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`vmi_program` ALTER COLUMN `edi_integration_method` SET TAGS ('dbx_value_regex' = 'edi_846|edi_852|edi_867|api|portal|manual');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`vmi_program` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`vmi_program` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`vmi_program` ALTER COLUMN `facility_coverage` SET TAGS ('dbx_business_glossary_term' = 'Facility Coverage');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`vmi_program` ALTER COLUMN `financial_settlement_terms` SET TAGS ('dbx_business_glossary_term' = 'Financial Settlement Terms');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`vmi_program` ALTER COLUMN `financial_settlement_terms` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`vmi_program` ALTER COLUMN `forecast_sharing_enabled` SET TAGS ('dbx_business_glossary_term' = 'Forecast Sharing Enabled Flag');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`vmi_program` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`vmi_program` ALTER COLUMN `last_performance_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Performance Review Date');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`vmi_program` ALTER COLUMN `markdown_responsibility` SET TAGS ('dbx_business_glossary_term' = 'Markdown (MD) Responsibility');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`vmi_program` ALTER COLUMN `markdown_responsibility` SET TAGS ('dbx_value_regex' = 'supplier|retailer|shared|negotiated_per_event');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`vmi_program` ALTER COLUMN `markdown_responsibility` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`vmi_program` ALTER COLUMN `next_performance_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Performance Review Date');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`vmi_program` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Program Notes');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`vmi_program` ALTER COLUMN `ownership_transfer_point` SET TAGS ('dbx_business_glossary_term' = 'Ownership Transfer Point');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`vmi_program` ALTER COLUMN `ownership_transfer_point` SET TAGS ('dbx_value_regex' = 'at_receipt|at_sale|at_shipment|fob_origin|fob_destination');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`vmi_program` ALTER COLUMN `payment_terms_days` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms Days');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`vmi_program` ALTER COLUMN `payment_terms_days` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`vmi_program` ALTER COLUMN `performance_review_frequency` SET TAGS ('dbx_business_glossary_term' = 'Performance Review Frequency');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`vmi_program` ALTER COLUMN `performance_review_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|semi_annually|annually');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`vmi_program` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Email Address');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`vmi_program` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`vmi_program` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`vmi_program` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`vmi_program` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Name');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`vmi_program` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`vmi_program` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`vmi_program` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Phone Number');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`vmi_program` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`vmi_program` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`vmi_program` ALTER COLUMN `program_code` SET TAGS ('dbx_business_glossary_term' = 'Vendor Managed Inventory (VMI) Program Code');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`vmi_program` ALTER COLUMN `program_code` SET TAGS ('dbx_value_regex' = '^VMI-[A-Z0-9]{6,12}$');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`vmi_program` ALTER COLUMN `program_name` SET TAGS ('dbx_business_glossary_term' = 'Vendor Managed Inventory (VMI) Program Name');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`vmi_program` ALTER COLUMN `program_status` SET TAGS ('dbx_business_glossary_term' = 'Vendor Managed Inventory (VMI) Program Status');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`vmi_program` ALTER COLUMN `program_status` SET TAGS ('dbx_value_regex' = 'draft|active|suspended|terminated|under_review');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`vmi_program` ALTER COLUMN `program_type` SET TAGS ('dbx_business_glossary_term' = 'Vendor Managed Inventory (VMI) Program Type');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`vmi_program` ALTER COLUMN `program_type` SET TAGS ('dbx_value_regex' = 'consignment|owned_inventory|hybrid|nos_program|seasonal_basics');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`vmi_program` ALTER COLUMN `replenishment_frequency` SET TAGS ('dbx_business_glossary_term' = 'Replenishment Frequency');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`vmi_program` ALTER COLUMN `replenishment_frequency` SET TAGS ('dbx_value_regex' = 'daily|weekly|biweekly|monthly|on_demand');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`vmi_program` ALTER COLUMN `replenishment_lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Replenishment Lead Time Days');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`vmi_program` ALTER COLUMN `return_to_vendor_allowed` SET TAGS ('dbx_business_glossary_term' = 'Return to Vendor (RTV) Allowed Flag');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`vmi_program` ALTER COLUMN `rfid_tracking_enabled` SET TAGS ('dbx_business_glossary_term' = 'Radio Frequency Identification (RFID) Tracking Enabled Flag');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`vmi_program` ALTER COLUMN `rtv_terms` SET TAGS ('dbx_business_glossary_term' = 'Return to Vendor (RTV) Terms');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`vmi_program` ALTER COLUMN `scope_category` SET TAGS ('dbx_business_glossary_term' = 'Scope Category');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`vmi_program` ALTER COLUMN `scope_sku_list` SET TAGS ('dbx_business_glossary_term' = 'Scope Stock Keeping Unit (SKU) List');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`vmi_program` ALTER COLUMN `sla_fill_rate_target_pct` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Fill Rate Target Percentage');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`vmi_program` ALTER COLUMN `sla_lead_time_target_days` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Lead Time Target Days');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`vmi_program` ALTER COLUMN `sla_otif_target_pct` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) On Time In Full (OTIF) Target Percentage');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`vmi_program` ALTER COLUMN `target_max_stock_level` SET TAGS ('dbx_business_glossary_term' = 'Target Maximum Stock Level');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`vmi_program` ALTER COLUMN `target_min_stock_level` SET TAGS ('dbx_business_glossary_term' = 'Target Minimum Stock Level');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`vmi_program` ALTER COLUMN `target_wos` SET TAGS ('dbx_business_glossary_term' = 'Target Weeks of Supply (WOS)');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`vmi_program` ALTER COLUMN `termination_notice_days` SET TAGS ('dbx_business_glossary_term' = 'Termination Notice Days');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`nos_policy` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`nos_policy` SET TAGS ('dbx_subdomain' = 'quality_traceability');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`nos_policy` ALTER COLUMN `nos_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Never Out of Stock (NOS) Policy ID');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`nos_policy` ALTER COLUMN `category_id` SET TAGS ('dbx_business_glossary_term' = 'Product Category ID');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`nos_policy` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Owner ID');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`nos_policy` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`nos_policy` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`nos_policy` ALTER COLUMN `otb_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Otb Budget Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`nos_policy` ALTER COLUMN `retail_store_id` SET TAGS ('dbx_business_glossary_term' = 'Store ID');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`nos_policy` ALTER COLUMN `season_id` SET TAGS ('dbx_business_glossary_term' = 'Season ID');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`nos_policy` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) ID');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`nos_policy` ALTER COLUMN `standard_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Standard Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`nos_policy` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`nos_policy` ALTER COLUMN `warehouse_location_id` SET TAGS ('dbx_business_glossary_term' = 'Warehouse ID');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`nos_policy` ALTER COLUMN `allocation_priority_rank` SET TAGS ('dbx_business_glossary_term' = 'Allocation Priority Rank');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`nos_policy` ALTER COLUMN `auto_replenishment_enabled` SET TAGS ('dbx_business_glossary_term' = 'Automatic Replenishment Enabled Flag');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`nos_policy` ALTER COLUMN `cost_per_unit` SET TAGS ('dbx_business_glossary_term' = 'Cost Per Unit');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`nos_policy` ALTER COLUMN `cost_per_unit` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`nos_policy` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`nos_policy` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`nos_policy` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`nos_policy` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`nos_policy` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`nos_policy` ALTER COLUMN `eligible_channel_dtc` SET TAGS ('dbx_business_glossary_term' = 'Eligible Channel Direct-to-Consumer (DTC) Flag');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`nos_policy` ALTER COLUMN `eligible_channel_marketplace` SET TAGS ('dbx_business_glossary_term' = 'Eligible Channel Marketplace Flag');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`nos_policy` ALTER COLUMN `eligible_channel_retail` SET TAGS ('dbx_business_glossary_term' = 'Eligible Channel Retail Store Flag');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`nos_policy` ALTER COLUMN `eligible_channel_wholesale` SET TAGS ('dbx_business_glossary_term' = 'Eligible Channel Wholesale Flag');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`nos_policy` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_business_glossary_term' = 'Geographic Scope');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`nos_policy` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_value_regex' = 'global|regional|country|store_group|single_location');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`nos_policy` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`nos_policy` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`nos_policy` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time Days');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`nos_policy` ALTER COLUMN `max_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Maximum Order Quantity');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`nos_policy` ALTER COLUMN `minimum_floor_stock_quantity` SET TAGS ('dbx_business_glossary_term' = 'Minimum Floor Stock Quantity');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`nos_policy` ALTER COLUMN `moq` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity (MOQ)');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`nos_policy` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Scheduled Review Date');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`nos_policy` ALTER COLUMN `nos_tier` SET TAGS ('dbx_business_glossary_term' = 'Never Out of Stock (NOS) Classification Tier');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`nos_policy` ALTER COLUMN `nos_tier` SET TAGS ('dbx_value_regex' = 'platinum|gold|silver|bronze');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`nos_policy` ALTER COLUMN `order_multiple` SET TAGS ('dbx_business_glossary_term' = 'Order Multiple');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`nos_policy` ALTER COLUMN `policy_code` SET TAGS ('dbx_business_glossary_term' = 'Never Out of Stock (NOS) Policy Code');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`nos_policy` ALTER COLUMN `policy_code` SET TAGS ('dbx_value_regex' = '^NOS-[A-Z0-9]{6,12}$');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`nos_policy` ALTER COLUMN `policy_description` SET TAGS ('dbx_business_glossary_term' = 'Never Out of Stock (NOS) Policy Description');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`nos_policy` ALTER COLUMN `policy_name` SET TAGS ('dbx_business_glossary_term' = 'Never Out of Stock (NOS) Policy Name');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`nos_policy` ALTER COLUMN `policy_notes` SET TAGS ('dbx_business_glossary_term' = 'Policy Notes');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`nos_policy` ALTER COLUMN `policy_status` SET TAGS ('dbx_business_glossary_term' = 'Never Out of Stock (NOS) Policy Status');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`nos_policy` ALTER COLUMN `policy_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|pending_review|expired');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`nos_policy` ALTER COLUMN `priority_replenishment_flag` SET TAGS ('dbx_business_glossary_term' = 'Priority Replenishment Flag');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`nos_policy` ALTER COLUMN `review_frequency_days` SET TAGS ('dbx_business_glossary_term' = 'Review Frequency Days');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`nos_policy` ALTER COLUMN `rfid_tracking_required` SET TAGS ('dbx_business_glossary_term' = 'Radio Frequency Identification (RFID) Tracking Required Flag');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`nos_policy` ALTER COLUMN `safety_stock_multiplier` SET TAGS ('dbx_business_glossary_term' = 'Safety Stock Multiplier');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`nos_policy` ALTER COLUMN `target_wos` SET TAGS ('dbx_business_glossary_term' = 'Target Weeks of Supply (WOS)');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`nos_policy` ALTER COLUMN `vmi_program_flag` SET TAGS ('dbx_business_glossary_term' = 'Vendor Managed Inventory (VMI) Program Flag');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`reservation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`reservation` SET TAGS ('dbx_subdomain' = 'stock_management');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`reservation` ALTER COLUMN `reservation_id` SET TAGS ('dbx_business_glossary_term' = 'Inventory Reservation Identifier (ID)');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`reservation` ALTER COLUMN `allocation_id` SET TAGS ('dbx_business_glossary_term' = 'Allocation Identifier (ID)');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`reservation` ALTER COLUMN `cart_id` SET TAGS ('dbx_business_glossary_term' = 'Cart Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`reservation` ALTER COLUMN `checkout_session_id` SET TAGS ('dbx_business_glossary_term' = 'Checkout Session Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`reservation` ALTER COLUMN `digital_order_id` SET TAGS ('dbx_business_glossary_term' = 'Digital Order Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`reservation` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Identifier (ID)');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`reservation` ALTER COLUMN `retail_store_id` SET TAGS ('dbx_business_glossary_term' = 'Retail Store Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`reservation` ALTER COLUMN `sales_order_id` SET TAGS ('dbx_business_glossary_term' = 'Order Identifier (ID)');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`reservation` ALTER COLUMN `sales_order_line_id` SET TAGS ('dbx_business_glossary_term' = 'Order Line Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`reservation` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`reservation` ALTER COLUMN `warehouse_location_id` SET TAGS ('dbx_business_glossary_term' = 'Location Identifier (ID)');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`reservation` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`reservation` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_value_regex' = 'CUSTOMER_CANCEL|CART_ABANDON|INVENTORY_UNAVAILABLE|ORDER_MODIFY|SYSTEM_ERROR|BUSINESS_RULE');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`reservation` ALTER COLUMN `cancelled_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Cancelled Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`reservation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`reservation` ALTER COLUMN `expiry_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Reservation Expiry Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`reservation` ALTER COLUMN `extended_count` SET TAGS ('dbx_business_glossary_term' = 'Extension Count');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`reservation` ALTER COLUMN `fulfilled_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Fulfilled Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`reservation` ALTER COLUMN `fulfillment_channel` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Channel');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`reservation` ALTER COLUMN `fulfillment_channel` SET TAGS ('dbx_value_regex' = 'ecommerce|retail_store|wholesale|marketplace|bopis|ship_from_store');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`reservation` ALTER COLUMN `hard_reservation_flag` SET TAGS ('dbx_business_glossary_term' = 'Hard Reservation Flag');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`reservation` ALTER COLUMN `last_extended_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Extended Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`reservation` ALTER COLUMN `last_updated_by` SET TAGS ('dbx_business_glossary_term' = 'Last Updated By User');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`reservation` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`reservation` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Reservation Notes');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`reservation` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Reservation Priority Rank');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`reservation` ALTER COLUMN `reason_code` SET TAGS ('dbx_business_glossary_term' = 'Reservation Reason Code');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`reservation` ALTER COLUMN `reason_code` SET TAGS ('dbx_value_regex' = 'CUSTOMER_ORDER|CART_HOLD|WHOLESALE_COMMIT|EVENT_RESERVE|PHOTO_SHOOT|SAMPLE_REQUEST');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`reservation` ALTER COLUMN `released_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Released Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`reservation` ALTER COLUMN `reservation_number` SET TAGS ('dbx_business_glossary_term' = 'Reservation Number');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`reservation` ALTER COLUMN `reservation_number` SET TAGS ('dbx_value_regex' = '^RES-[0-9]{10}$');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`reservation` ALTER COLUMN `reservation_status` SET TAGS ('dbx_business_glossary_term' = 'Reservation Status');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`reservation` ALTER COLUMN `reservation_status` SET TAGS ('dbx_value_regex' = 'active|expired|released|fulfilled|cancelled|pending');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`reservation` ALTER COLUMN `reservation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Reservation Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`reservation` ALTER COLUMN `reservation_type` SET TAGS ('dbx_business_glossary_term' = 'Reservation Type');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`reservation` ALTER COLUMN `reservation_type` SET TAGS ('dbx_value_regex' = 'sales_order|ecommerce_cart|wholesale_commitment|event_hold|photo_shoot_hold|sample_pull');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`reservation` ALTER COLUMN `reserved_quantity` SET TAGS ('dbx_business_glossary_term' = 'Reserved Quantity');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`reservation` ALTER COLUMN `sku` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU)');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`reservation` ALTER COLUMN `sku` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,15}$');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`reservation` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`reservation` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'SAP_SD|SFCC|OMS|WMS|POS|WHOLESALE_PORTAL');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`reservation` ALTER COLUMN `source_transaction_reference` SET TAGS ('dbx_business_glossary_term' = 'Source Transaction Identifier (ID)');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`reservation` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`reservation` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'EA|PR|DZ|CS|PK');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`reservation` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_valuation` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_valuation` SET TAGS ('dbx_subdomain' = 'stock_management');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_valuation` ALTER COLUMN `stock_valuation_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Valuation ID');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_valuation` ALTER COLUMN `incident_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Incident Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_valuation` ALTER COLUMN `merchandise_hierarchy_id` SET TAGS ('dbx_business_glossary_term' = 'Merchandise Hierarchy Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_valuation` ALTER COLUMN `non_conformance_id` SET TAGS ('dbx_business_glossary_term' = 'Non Conformance Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_valuation` ALTER COLUMN `otb_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Otb Budget Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_valuation` ALTER COLUMN `retail_store_id` SET TAGS ('dbx_business_glossary_term' = 'Retail Store Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_valuation` ALTER COLUMN `season_id` SET TAGS ('dbx_business_glossary_term' = 'Season ID');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_valuation` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU) ID');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_valuation` ALTER COLUMN `sourcing_purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Sourcing Purchase Order Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_valuation` ALTER COLUMN `valuation_area_id` SET TAGS ('dbx_business_glossary_term' = 'Valuation Area ID');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_valuation` ALTER COLUMN `aged_inventory_provision` SET TAGS ('dbx_business_glossary_term' = 'Aged Inventory Provision');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_valuation` ALTER COLUMN `aged_inventory_provision` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_valuation` ALTER COLUMN `cogs_allocation_amount` SET TAGS ('dbx_business_glossary_term' = 'Cost of Goods Sold (COGS) Allocation Amount');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_valuation` ALTER COLUMN `cogs_allocation_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_valuation` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_valuation` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_valuation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_valuation` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_valuation` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_valuation` ALTER COLUMN `current_unit_cost` SET TAGS ('dbx_business_glossary_term' = 'Current Unit Cost');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_valuation` ALTER COLUMN `current_unit_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_valuation` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_valuation` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_valuation` ALTER COLUMN `gl_account_number` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Number');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_valuation` ALTER COLUMN `gl_account_number` SET TAGS ('dbx_value_regex' = '^[0-9]{4,10}$');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_valuation` ALTER COLUMN `gl_account_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_valuation` ALTER COLUMN `gl_account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_valuation` ALTER COLUMN `inventory_turnover_days` SET TAGS ('dbx_business_glossary_term' = 'Inventory Turnover Days');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_valuation` ALTER COLUMN `inventory_write_down_amount` SET TAGS ('dbx_business_glossary_term' = 'Inventory Write-Down Amount');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_valuation` ALTER COLUMN `inventory_write_down_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_valuation` ALTER COLUMN `last_cost_update_date` SET TAGS ('dbx_business_glossary_term' = 'Last Cost Update Date');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_valuation` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_valuation` ALTER COLUMN `last_physical_count_date` SET TAGS ('dbx_business_glossary_term' = 'Last Physical Count Date');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_valuation` ALTER COLUMN `lifecycle_stage` SET TAGS ('dbx_business_glossary_term' = 'Lifecycle Stage');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_valuation` ALTER COLUMN `lifecycle_stage` SET TAGS ('dbx_value_regex' = 'pre_season|in_season|end_of_season|clearance|obsolete');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_valuation` ALTER COLUMN `markdown_reserve_amount` SET TAGS ('dbx_business_glossary_term' = 'Markdown (MD) Reserve Amount');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_valuation` ALTER COLUMN `markdown_reserve_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_valuation` ALTER COLUMN `markdown_reserve_percentage` SET TAGS ('dbx_business_glossary_term' = 'Markdown (MD) Reserve Percentage');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_valuation` ALTER COLUMN `moving_average_price` SET TAGS ('dbx_business_glossary_term' = 'Moving Average Price (MAP)');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_valuation` ALTER COLUMN `moving_average_price` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_valuation` ALTER COLUMN `net_realizable_value` SET TAGS ('dbx_business_glossary_term' = 'Net Realizable Value (NRV)');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_valuation` ALTER COLUMN `net_realizable_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_valuation` ALTER COLUMN `price_variance_amount` SET TAGS ('dbx_business_glossary_term' = 'Price Variance Amount');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_valuation` ALTER COLUMN `price_variance_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_valuation` ALTER COLUMN `profit_center_code` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Code');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_valuation` ALTER COLUMN `profit_center_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_valuation` ALTER COLUMN `seasonal_write_down_percentage` SET TAGS ('dbx_business_glossary_term' = 'Seasonal Write-Down Percentage');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_valuation` ALTER COLUMN `standard_cost` SET TAGS ('dbx_business_glossary_term' = 'Standard Cost');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_valuation` ALTER COLUMN `standard_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_valuation` ALTER COLUMN `total_stock_quantity` SET TAGS ('dbx_business_glossary_term' = 'Total Stock Quantity');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_valuation` ALTER COLUMN `total_stock_value` SET TAGS ('dbx_business_glossary_term' = 'Total Stock Value');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_valuation` ALTER COLUMN `total_stock_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_valuation` ALTER COLUMN `valuation_adjustment_reason` SET TAGS ('dbx_business_glossary_term' = 'Valuation Adjustment Reason');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_valuation` ALTER COLUMN `valuation_class` SET TAGS ('dbx_business_glossary_term' = 'Valuation Class');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_valuation` ALTER COLUMN `valuation_class` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_valuation` ALTER COLUMN `valuation_date` SET TAGS ('dbx_business_glossary_term' = 'Valuation Date');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_valuation` ALTER COLUMN `valuation_status` SET TAGS ('dbx_business_glossary_term' = 'Valuation Status');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_valuation` ALTER COLUMN `valuation_status` SET TAGS ('dbx_value_regex' = 'active|frozen|adjusted|written_off|under_review');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_valuation` ALTER COLUMN `valuation_type` SET TAGS ('dbx_business_glossary_term' = 'Valuation Type');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_valuation` ALTER COLUMN `valuation_type` SET TAGS ('dbx_value_regex' = 'standard_cost|moving_average|fifo|lifo|retail_method');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`stock_valuation` ALTER COLUMN `weeks_of_supply` SET TAGS ('dbx_business_glossary_term' = 'Weeks of Supply (WOS)');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`quarantine_hold` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`quarantine_hold` SET TAGS ('dbx_subdomain' = 'quality_traceability');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`quarantine_hold` ALTER COLUMN `quarantine_hold_id` SET TAGS ('dbx_business_glossary_term' = 'Quarantine Hold ID');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`quarantine_hold` ALTER COLUMN `digital_return_id` SET TAGS ('dbx_business_glossary_term' = 'Digital Return Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`quarantine_hold` ALTER COLUMN `incident_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Incident Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`quarantine_hold` ALTER COLUMN `lot_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Batch Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`quarantine_hold` ALTER COLUMN `non_conformance_id` SET TAGS ('dbx_business_glossary_term' = 'Non Conformance Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`quarantine_hold` ALTER COLUMN `product_safety_test_id` SET TAGS ('dbx_business_glossary_term' = 'Product Safety Test Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`quarantine_hold` ALTER COLUMN `quality_hold_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Hold Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`quarantine_hold` ALTER COLUMN `inspection_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Inspection ID');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`quarantine_hold` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Manager Employee Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`quarantine_hold` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`quarantine_hold` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`quarantine_hold` ALTER COLUMN `retail_store_id` SET TAGS ('dbx_business_glossary_term' = 'Retail Store Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`quarantine_hold` ALTER COLUMN `rfid_tag_id` SET TAGS ('dbx_business_glossary_term' = 'Radio Frequency Identification (RFID) Tag ID');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`quarantine_hold` ALTER COLUMN `shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Logistics Shipment Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`quarantine_hold` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`quarantine_hold` ALTER COLUMN `sourcing_purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Sourcing Purchase Order Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`quarantine_hold` ALTER COLUMN `stock_position_id` SET TAGS ('dbx_business_glossary_term' = 'Inventory ID');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`quarantine_hold` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`quarantine_hold` ALTER COLUMN `warehouse_location_id` SET TAGS ('dbx_business_glossary_term' = 'Location ID');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`quarantine_hold` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`quarantine_hold` ALTER COLUMN `actual_release_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Release Date');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`quarantine_hold` ALTER COLUMN `actual_release_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Release Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`quarantine_hold` ALTER COLUMN `compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Flag');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`quarantine_hold` ALTER COLUMN `corrective_action_reference` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Reference');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`quarantine_hold` ALTER COLUMN `corrective_action_required` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Required');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`quarantine_hold` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`quarantine_hold` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`quarantine_hold` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|EUR|GBP|JPY|CNY|CAD');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`quarantine_hold` ALTER COLUMN `customer_impact_flag` SET TAGS ('dbx_business_glossary_term' = 'Customer Impact Flag');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`quarantine_hold` ALTER COLUMN `disposition_approved_by` SET TAGS ('dbx_business_glossary_term' = 'Disposition Approved By');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`quarantine_hold` ALTER COLUMN `disposition_decision` SET TAGS ('dbx_business_glossary_term' = 'Disposition Decision');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`quarantine_hold` ALTER COLUMN `disposition_decision` SET TAGS ('dbx_value_regex' = 'return_to_stock|rtv|destroy|rework|donate|transfer');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`quarantine_hold` ALTER COLUMN `disposition_notes` SET TAGS ('dbx_business_glossary_term' = 'Disposition Notes');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`quarantine_hold` ALTER COLUMN `estimated_financial_impact` SET TAGS ('dbx_business_glossary_term' = 'Estimated Financial Impact');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`quarantine_hold` ALTER COLUMN `estimated_financial_impact` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`quarantine_hold` ALTER COLUMN `expected_release_date` SET TAGS ('dbx_business_glossary_term' = 'Expected Release Date');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`quarantine_hold` ALTER COLUMN `hold_approved_by` SET TAGS ('dbx_business_glossary_term' = 'Hold Approved By');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`quarantine_hold` ALTER COLUMN `hold_initiated_by` SET TAGS ('dbx_business_glossary_term' = 'Hold Initiated By');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`quarantine_hold` ALTER COLUMN `hold_quantity` SET TAGS ('dbx_business_glossary_term' = 'Hold Quantity');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`quarantine_hold` ALTER COLUMN `hold_quantity_uom` SET TAGS ('dbx_business_glossary_term' = 'Hold Quantity Unit of Measure (UOM)');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`quarantine_hold` ALTER COLUMN `hold_quantity_uom` SET TAGS ('dbx_value_regex' = 'EA|CS|PL|CTN|PR');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`quarantine_hold` ALTER COLUMN `hold_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Hold Reason Code');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`quarantine_hold` ALTER COLUMN `hold_reason_code` SET TAGS ('dbx_value_regex' = 'quality_failure|regulatory_hold|customs_inspection|product_recall|damage|supplier_defect');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`quarantine_hold` ALTER COLUMN `hold_reason_description` SET TAGS ('dbx_business_glossary_term' = 'Hold Reason Description');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`quarantine_hold` ALTER COLUMN `hold_start_date` SET TAGS ('dbx_business_glossary_term' = 'Hold Start Date');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`quarantine_hold` ALTER COLUMN `hold_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Hold Start Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`quarantine_hold` ALTER COLUMN `hold_status` SET TAGS ('dbx_business_glossary_term' = 'Hold Status');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`quarantine_hold` ALTER COLUMN `hold_status` SET TAGS ('dbx_value_regex' = 'active|pending_review|released|disposed');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`quarantine_hold` ALTER COLUMN `initiating_event_reference` SET TAGS ('dbx_business_glossary_term' = 'Initiating Event Reference');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`quarantine_hold` ALTER COLUMN `initiating_event_type` SET TAGS ('dbx_business_glossary_term' = 'Initiating Event Type');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`quarantine_hold` ALTER COLUMN `initiating_event_type` SET TAGS ('dbx_value_regex' = 'quality_inspection|supplier_defect|cpsc_recall|customer_complaint|internal_audit|customs_flag');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`quarantine_hold` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`quarantine_hold` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`quarantine_hold` ALTER COLUMN `po_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Number');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`quarantine_hold` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`quarantine_hold` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`quarantine_hold` ALTER COLUMN `recall_flag` SET TAGS ('dbx_business_glossary_term' = 'Recall Flag');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`quarantine_hold` ALTER COLUMN `regulatory_authority` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Authority');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`quarantine_hold` ALTER COLUMN `regulatory_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reference Number');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`quarantine_hold` ALTER COLUMN `root_cause_analysis_completed` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Analysis Completed');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`quarantine_hold` ALTER COLUMN `serial_number` SET TAGS ('dbx_business_glossary_term' = 'Serial Number');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`quarantine_hold` ALTER COLUMN `sku` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU)');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`asn` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`asn` SET TAGS ('dbx_subdomain' = 'fulfillment_logistics');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`asn` ALTER COLUMN `asn_id` SET TAGS ('dbx_business_glossary_term' = 'Advance Shipment Notice (ASN) ID');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`asn` ALTER COLUMN `warehouse_location_id` SET TAGS ('dbx_business_glossary_term' = 'Ship To Location ID');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`asn` ALTER COLUMN `asn_warehouse_location_id` SET TAGS ('dbx_business_glossary_term' = 'Ship From Location ID');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`asn` ALTER COLUMN `bill_of_lading_id` SET TAGS ('dbx_business_glossary_term' = 'Bill Of Lading Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`asn` ALTER COLUMN `carbon_emission_id` SET TAGS ('dbx_business_glossary_term' = 'Carbon Emission Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`asn` ALTER COLUMN `customs_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Customs Entry Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`asn` ALTER COLUMN `order_purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) ID');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`asn` ALTER COLUMN `packing_list_id` SET TAGS ('dbx_business_glossary_term' = 'Packing List Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`asn` ALTER COLUMN `inspection_id` SET TAGS ('dbx_business_glossary_term' = 'Pre Shipment Inspection Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`asn` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Receiving Supervisor Employee Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`asn` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`asn` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`asn` ALTER COLUMN `distribution_center_id` SET TAGS ('dbx_business_glossary_term' = 'Ship To Distribution Center Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`asn` ALTER COLUMN `retail_store_id` SET TAGS ('dbx_business_glossary_term' = 'Ship To Retail Store Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`asn` ALTER COLUMN `shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Logistics Shipment Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`asn` ALTER COLUMN `sourcing_purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Sourcing Purchase Order Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`asn` ALTER COLUMN `supplier_factory_id` SET TAGS ('dbx_business_glossary_term' = 'Origin Factory Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`asn` ALTER COLUMN `third_party_logistics_id` SET TAGS ('dbx_business_glossary_term' = '3Pl Partner Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`asn` ALTER COLUMN `trade_compliance_record_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Compliance Record Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`asn` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`asn` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`asn` ALTER COLUMN `acknowledged_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Acknowledged Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`asn` ALTER COLUMN `actual_arrival_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Arrival Date');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`asn` ALTER COLUMN `appointment_date` SET TAGS ('dbx_business_glossary_term' = 'Appointment Date');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`asn` ALTER COLUMN `asn_number` SET TAGS ('dbx_business_glossary_term' = 'Advance Shipment Notice (ASN) Number');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`asn` ALTER COLUMN `asn_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`asn` ALTER COLUMN `asn_status` SET TAGS ('dbx_business_glossary_term' = 'Advance Shipment Notice (ASN) Status');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`asn` ALTER COLUMN `asn_type` SET TAGS ('dbx_business_glossary_term' = 'Advance Shipment Notice (ASN) Type');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`asn` ALTER COLUMN `asn_type` SET TAGS ('dbx_value_regex' = 'standard|drop_ship|transfer|return|sample');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`asn` ALTER COLUMN `carrier_name` SET TAGS ('dbx_business_glossary_term' = 'Carrier Name');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`asn` ALTER COLUMN `carrier_service_level` SET TAGS ('dbx_business_glossary_term' = 'Carrier Service Level');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`asn` ALTER COLUMN `commercial_invoice_number` SET TAGS ('dbx_business_glossary_term' = 'Commercial Invoice Number');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`asn` ALTER COLUMN `container_number` SET TAGS ('dbx_business_glossary_term' = 'Container Number');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`asn` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_business_glossary_term' = 'Country of Origin');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`asn` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`asn` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`asn` ALTER COLUMN `customs_value_amount` SET TAGS ('dbx_business_glossary_term' = 'Customs Value Amount');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`asn` ALTER COLUMN `customs_value_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`asn` ALTER COLUMN `customs_value_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Customs Value Currency Code');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`asn` ALTER COLUMN `customs_value_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`asn` ALTER COLUMN `dock_door_assignment` SET TAGS ('dbx_business_glossary_term' = 'Dock Door Assignment');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`asn` ALTER COLUMN `expected_arrival_date` SET TAGS ('dbx_business_glossary_term' = 'Expected Arrival Date');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`asn` ALTER COLUMN `hs_code` SET TAGS ('dbx_business_glossary_term' = 'Harmonized System (HS) Code');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`asn` ALTER COLUMN `hs_code` SET TAGS ('dbx_value_regex' = '^[0-9]{6,10}$');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`asn` ALTER COLUMN `incoterm` SET TAGS ('dbx_business_glossary_term' = 'Incoterm');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`asn` ALTER COLUMN `is_hazmat` SET TAGS ('dbx_business_glossary_term' = 'Is Hazardous Material (HAZMAT)');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`asn` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`asn` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`asn` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'standard|high|urgent|critical');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`asn` ALTER COLUMN `receiving_completed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Receiving Completed Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`asn` ALTER COLUMN `receiving_started_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Receiving Started Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`asn` ALTER COLUMN `rfid_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Radio Frequency Identification (RFID) Enabled Flag');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`asn` ALTER COLUMN `seal_number` SET TAGS ('dbx_business_glossary_term' = 'Seal Number');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`asn` ALTER COLUMN `shipment_date` SET TAGS ('dbx_business_glossary_term' = 'Shipment Date');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`asn` ALTER COLUMN `special_handling_instructions` SET TAGS ('dbx_business_glossary_term' = 'Special Handling Instructions');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`asn` ALTER COLUMN `supplier_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Supplier Reference Number');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`asn` ALTER COLUMN `temperature_controlled_flag` SET TAGS ('dbx_business_glossary_term' = 'Temperature Controlled Flag');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`asn` ALTER COLUMN `total_carton_count` SET TAGS ('dbx_business_glossary_term' = 'Total Carton Count');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`asn` ALTER COLUMN `total_pallet_count` SET TAGS ('dbx_business_glossary_term' = 'Total Pallet Count');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`asn` ALTER COLUMN `total_unit_quantity` SET TAGS ('dbx_business_glossary_term' = 'Total Unit Quantity');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`asn` ALTER COLUMN `total_volume_cbm` SET TAGS ('dbx_business_glossary_term' = 'Total Volume (Cubic Meters)');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`asn` ALTER COLUMN `total_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Total Weight (Kilograms)');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`asn` ALTER COLUMN `tracking_number` SET TAGS ('dbx_business_glossary_term' = 'Tracking Number');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`asn` ALTER COLUMN `transmitted_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Transmitted Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`lot_batch` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`lot_batch` SET TAGS ('dbx_subdomain' = 'quality_traceability');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`lot_batch` ALTER COLUMN `lot_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Batch Identifier (ID)');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`lot_batch` ALTER COLUMN `bill_of_lading_id` SET TAGS ('dbx_business_glossary_term' = 'Bill Of Lading Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`lot_batch` ALTER COLUMN `chemical_compliance_id` SET TAGS ('dbx_business_glossary_term' = 'Chemical Compliance Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`lot_batch` ALTER COLUMN `compliance_certification_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Certification Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`lot_batch` ALTER COLUMN `inspection_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`lot_batch` ALTER COLUMN `material_certification_id` SET TAGS ('dbx_business_glossary_term' = 'Material Certification Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`lot_batch` ALTER COLUMN `order_purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`lot_batch` ALTER COLUMN `product_safety_test_id` SET TAGS ('dbx_business_glossary_term' = 'Product Safety Test Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`lot_batch` ALTER COLUMN `retail_store_id` SET TAGS ('dbx_business_glossary_term' = 'Retail Store Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`lot_batch` ALTER COLUMN `shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Logistics Shipment Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`lot_batch` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Product Identifier (ID)');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`lot_batch` ALTER COLUMN `sourcing_purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Sourcing Purchase Order Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`lot_batch` ALTER COLUMN `supplier_factory_id` SET TAGS ('dbx_business_glossary_term' = 'Factory Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`lot_batch` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Identifier (ID)');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`lot_batch` ALTER COLUMN `warehouse_location_id` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Location Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`lot_batch` ALTER COLUMN `batch_type` SET TAGS ('dbx_business_glossary_term' = 'Batch Type');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`lot_batch` ALTER COLUMN `batch_type` SET TAGS ('dbx_value_regex' = 'production|sample|prototype|rework|return');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`lot_batch` ALTER COLUMN `certification_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Certification Expiry Date');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`lot_batch` ALTER COLUMN `certification_number` SET TAGS ('dbx_business_glossary_term' = 'Certification Number');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`lot_batch` ALTER COLUMN `certification_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{6,30}$');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`lot_batch` ALTER COLUMN `certification_type` SET TAGS ('dbx_business_glossary_term' = 'Certification Type');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`lot_batch` ALTER COLUMN `colorway_consistency_grade` SET TAGS ('dbx_business_glossary_term' = 'Colorway Consistency Grade');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`lot_batch` ALTER COLUMN `colorway_consistency_grade` SET TAGS ('dbx_value_regex' = 'A|B|C|D|F');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`lot_batch` ALTER COLUMN `cost_per_unit` SET TAGS ('dbx_business_glossary_term' = 'Cost Per Unit');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`lot_batch` ALTER COLUMN `cost_per_unit` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`lot_batch` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_business_glossary_term' = 'Country of Origin');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`lot_batch` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`lot_batch` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`lot_batch` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`lot_batch` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`lot_batch` ALTER COLUMN `defect_rate_percentage` SET TAGS ('dbx_business_glossary_term' = 'Defect Rate Percentage');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`lot_batch` ALTER COLUMN `dye_lot_code` SET TAGS ('dbx_business_glossary_term' = 'Dye Lot Code');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`lot_batch` ALTER COLUMN `dye_lot_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,15}$');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`lot_batch` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`lot_batch` ALTER COLUMN `factory_code` SET TAGS ('dbx_business_glossary_term' = 'Factory Code');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`lot_batch` ALTER COLUMN `factory_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,10}$');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`lot_batch` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`lot_batch` ALTER COLUMN `lot_batch_status` SET TAGS ('dbx_business_glossary_term' = 'Lot Batch Status');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`lot_batch` ALTER COLUMN `lot_batch_status` SET TAGS ('dbx_value_regex' = 'active|quarantined|consumed|expired|recalled|disposed');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`lot_batch` ALTER COLUMN `lot_number` SET TAGS ('dbx_business_glossary_term' = 'Lot Number');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`lot_batch` ALTER COLUMN `lot_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`lot_batch` ALTER COLUMN `material_composition` SET TAGS ('dbx_business_glossary_term' = 'Material Composition');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`lot_batch` ALTER COLUMN `mill_origin_code` SET TAGS ('dbx_business_glossary_term' = 'Mill Origin Code');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`lot_batch` ALTER COLUMN `mill_origin_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,10}$');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`lot_batch` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Lot Batch Notes');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`lot_batch` ALTER COLUMN `production_date` SET TAGS ('dbx_business_glossary_term' = 'Production Date');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`lot_batch` ALTER COLUMN `quantity_available` SET TAGS ('dbx_business_glossary_term' = 'Quantity Available');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`lot_batch` ALTER COLUMN `quantity_produced` SET TAGS ('dbx_business_glossary_term' = 'Quantity Produced');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`lot_batch` ALTER COLUMN `quarantine_date` SET TAGS ('dbx_business_glossary_term' = 'Quarantine Date');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`lot_batch` ALTER COLUMN `quarantine_reason` SET TAGS ('dbx_business_glossary_term' = 'Quarantine Reason');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`lot_batch` ALTER COLUMN `recall_date` SET TAGS ('dbx_business_glossary_term' = 'Recall Date');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`lot_batch` ALTER COLUMN `recall_flag` SET TAGS ('dbx_business_glossary_term' = 'Recall Flag');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`lot_batch` ALTER COLUMN `recall_number` SET TAGS ('dbx_business_glossary_term' = 'Recall Number');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`lot_batch` ALTER COLUMN `recall_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{6,20}$');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`lot_batch` ALTER COLUMN `release_date` SET TAGS ('dbx_business_glossary_term' = 'Release Date');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`lot_batch` ALTER COLUMN `rfid_tag_applied` SET TAGS ('dbx_business_glossary_term' = 'Radio Frequency Identification (RFID) Tag Applied');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`lot_batch` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`lot_batch` ALTER COLUMN `vendor_managed_inventory_flag` SET TAGS ('dbx_business_glossary_term' = 'Vendor Managed Inventory (VMI) Flag');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`goods_receipt` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`goods_receipt` SET TAGS ('dbx_subdomain' = 'fulfillment_logistics');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`goods_receipt` ALTER COLUMN `goods_receipt_id` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt ID');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`goods_receipt` ALTER COLUMN `asn_id` SET TAGS ('dbx_business_glossary_term' = 'Advanced Shipping Notice (ASN) ID');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`goods_receipt` ALTER COLUMN `bill_of_lading_id` SET TAGS ('dbx_business_glossary_term' = 'Bill Of Lading Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`goods_receipt` ALTER COLUMN `carbon_emission_id` SET TAGS ('dbx_business_glossary_term' = 'Carbon Emission Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`goods_receipt` ALTER COLUMN `customs_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Customs Entry Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`goods_receipt` ALTER COLUMN `distribution_center_id` SET TAGS ('dbx_business_glossary_term' = 'Receiving Facility ID');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`goods_receipt` ALTER COLUMN `freight_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Freight Invoice Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`goods_receipt` ALTER COLUMN `inspection_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`goods_receipt` ALTER COLUMN `lot_batch_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Batch Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`goods_receipt` ALTER COLUMN `order_purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) ID');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`goods_receipt` ALTER COLUMN `packing_list_id` SET TAGS ('dbx_business_glossary_term' = 'Packing List Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`goods_receipt` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Received By User ID');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`goods_receipt` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`goods_receipt` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`goods_receipt` ALTER COLUMN `quality_hold_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Hold Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`goods_receipt` ALTER COLUMN `retail_store_id` SET TAGS ('dbx_business_glossary_term' = 'Retail Store Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`goods_receipt` ALTER COLUMN `return_shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Return Shipment Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`goods_receipt` ALTER COLUMN `shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Logistics Shipment Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`goods_receipt` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`goods_receipt` ALTER COLUMN `sourcing_purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Sourcing Purchase Order Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`goods_receipt` ALTER COLUMN `third_party_logistics_id` SET TAGS ('dbx_business_glossary_term' = '3Pl Partner Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`goods_receipt` ALTER COLUMN `trade_compliance_record_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Compliance Record Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`goods_receipt` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`goods_receipt` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order Id (Foreign Key)');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`goods_receipt` ALTER COLUMN `correction_goods_receipt_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`goods_receipt` ALTER COLUMN `accepted_quantity` SET TAGS ('dbx_business_glossary_term' = 'Accepted Quantity');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`goods_receipt` ALTER COLUMN `carrier_name` SET TAGS ('dbx_business_glossary_term' = 'Carrier Name');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`goods_receipt` ALTER COLUMN `carton_count` SET TAGS ('dbx_business_glossary_term' = 'Carton Count');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`goods_receipt` ALTER COLUMN `container_number` SET TAGS ('dbx_business_glossary_term' = 'Container Number');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`goods_receipt` ALTER COLUMN `container_number` SET TAGS ('dbx_value_regex' = '^[A-Z]{4}[0-9]{7}$');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`goods_receipt` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_business_glossary_term' = 'Country of Origin');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`goods_receipt` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`goods_receipt` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`goods_receipt` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`goods_receipt` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`goods_receipt` ALTER COLUMN `discrepancy_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Discrepancy Reason Code');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`goods_receipt` ALTER COLUMN `discrepancy_reason_code` SET TAGS ('dbx_value_regex' = 'overage|shortage|damage|wrong_item|quality_issue|none');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`goods_receipt` ALTER COLUMN `document_date` SET TAGS ('dbx_business_glossary_term' = 'Document Date');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`goods_receipt` ALTER COLUMN `hazmat_indicator` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Material (HAZMAT) Indicator');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`goods_receipt` ALTER COLUMN `hs_code` SET TAGS ('dbx_business_glossary_term' = 'Harmonized System (HS) Code');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`goods_receipt` ALTER COLUMN `hs_code` SET TAGS ('dbx_value_regex' = '^[0-9]{6,10}$');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`goods_receipt` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`goods_receipt` ALTER COLUMN `ordered_quantity` SET TAGS ('dbx_business_glossary_term' = 'Ordered Quantity');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`goods_receipt` ALTER COLUMN `pallet_count` SET TAGS ('dbx_business_glossary_term' = 'Pallet Count');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`goods_receipt` ALTER COLUMN `po_line_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Line Number');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`goods_receipt` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Date');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`goods_receipt` ALTER COLUMN `product_description` SET TAGS ('dbx_business_glossary_term' = 'Product Description');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`goods_receipt` ALTER COLUMN `receipt_number` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt Number');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`goods_receipt` ALTER COLUMN `receipt_number` SET TAGS ('dbx_value_regex' = '^GR[0-9]{10}$');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`goods_receipt` ALTER COLUMN `receipt_status` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt Status');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`goods_receipt` ALTER COLUMN `receipt_status` SET TAGS ('dbx_value_regex' = 'pending|in_progress|completed|cancelled|reversed');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`goods_receipt` ALTER COLUMN `receipt_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`goods_receipt` ALTER COLUMN `receipt_type` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt Type');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`goods_receipt` ALTER COLUMN `receipt_type` SET TAGS ('dbx_value_regex' = 'standard|return_to_vendor|transfer|consignment|sample|direct_delivery');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`goods_receipt` ALTER COLUMN `received_quantity` SET TAGS ('dbx_business_glossary_term' = 'Received Quantity');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`goods_receipt` ALTER COLUMN `receiving_location_code` SET TAGS ('dbx_business_glossary_term' = 'Receiving Location Code');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`goods_receipt` ALTER COLUMN `receiving_location_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`goods_receipt` ALTER COLUMN `receiving_notes` SET TAGS ('dbx_business_glossary_term' = 'Receiving Notes');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`goods_receipt` ALTER COLUMN `rejected_quantity` SET TAGS ('dbx_business_glossary_term' = 'Rejected Quantity');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`goods_receipt` ALTER COLUMN `reversal_indicator` SET TAGS ('dbx_business_glossary_term' = 'Reversal Indicator');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`goods_receipt` ALTER COLUMN `reversed_document_number` SET TAGS ('dbx_business_glossary_term' = 'Reversed Document Number');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`goods_receipt` ALTER COLUMN `reversed_document_number` SET TAGS ('dbx_value_regex' = '^GR[0-9]{10}$');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`goods_receipt` ALTER COLUMN `rfid_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Radio Frequency Identification (RFID) Enabled Flag');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`goods_receipt` ALTER COLUMN `seal_number` SET TAGS ('dbx_business_glossary_term' = 'Seal Number');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`goods_receipt` ALTER COLUMN `seal_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`goods_receipt` ALTER COLUMN `serial_number` SET TAGS ('dbx_business_glossary_term' = 'Serial Number');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`goods_receipt` ALTER COLUMN `serial_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{6,30}$');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`goods_receipt` ALTER COLUMN `sku` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU)');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`goods_receipt` ALTER COLUMN `sku` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{6,20}$');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`goods_receipt` ALTER COLUMN `stock_type` SET TAGS ('dbx_business_glossary_term' = 'Stock Type');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`goods_receipt` ALTER COLUMN `stock_type` SET TAGS ('dbx_value_regex' = 'unrestricted|quality_inspection|blocked|returns|consignment');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`goods_receipt` ALTER COLUMN `temperature_controlled_flag` SET TAGS ('dbx_business_glossary_term' = 'Temperature Controlled Flag');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`goods_receipt` ALTER COLUMN `total_cost` SET TAGS ('dbx_business_glossary_term' = 'Total Cost');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`goods_receipt` ALTER COLUMN `total_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`goods_receipt` ALTER COLUMN `total_volume_cbm` SET TAGS ('dbx_business_glossary_term' = 'Total Volume in Cubic Meters (CBM)');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`goods_receipt` ALTER COLUMN `total_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Total Weight in Kilograms (KG)');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`goods_receipt` ALTER COLUMN `tracking_number` SET TAGS ('dbx_business_glossary_term' = 'Tracking Number');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`goods_receipt` ALTER COLUMN `tracking_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{10,30}$');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`goods_receipt` ALTER COLUMN `unit_cost` SET TAGS ('dbx_business_glossary_term' = 'Unit Cost');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`goods_receipt` ALTER COLUMN `unit_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`goods_receipt` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`goods_receipt` ALTER COLUMN `upc` SET TAGS ('dbx_business_glossary_term' = 'Universal Product Code (UPC)');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`goods_receipt` ALTER COLUMN `upc` SET TAGS ('dbx_value_regex' = '^[0-9]{12,14}$');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`goods_receipt` ALTER COLUMN `valuation_type` SET TAGS ('dbx_business_glossary_term' = 'Valuation Type');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`goods_receipt` ALTER COLUMN `valuation_type` SET TAGS ('dbx_value_regex' = 'standard|moving_average|fifo|lifo');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`storefront_fulfillment_network` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`storefront_fulfillment_network` SET TAGS ('dbx_subdomain' = 'fulfillment_logistics');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`storefront_fulfillment_network` SET TAGS ('dbx_association_edges' = 'inventory.warehouse_location,ecommerce.digital_storefront');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`storefront_fulfillment_network` ALTER COLUMN `storefront_fulfillment_network_id` SET TAGS ('dbx_business_glossary_term' = 'Storefront Fulfillment Network ID');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`storefront_fulfillment_network` ALTER COLUMN `digital_storefront_id` SET TAGS ('dbx_business_glossary_term' = 'Storefront Fulfillment Network - Digital Storefront Id');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`storefront_fulfillment_network` ALTER COLUMN `warehouse_location_id` SET TAGS ('dbx_business_glossary_term' = 'Storefront Fulfillment Network - Warehouse Location Id');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`storefront_fulfillment_network` ALTER COLUMN `allocation_priority` SET TAGS ('dbx_business_glossary_term' = 'Allocation Priority');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`storefront_fulfillment_network` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`storefront_fulfillment_network` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`storefront_fulfillment_network` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`storefront_fulfillment_network` ALTER COLUMN `fulfillment_sla_hours` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment SLA Hours');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`storefront_fulfillment_network` ALTER COLUMN `is_primary_fulfillment_location` SET TAGS ('dbx_business_glossary_term' = 'Is Primary Fulfillment Location');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`storefront_fulfillment_network` ALTER COLUMN `shipping_cost_tier` SET TAGS ('dbx_business_glossary_term' = 'Shipping Cost Tier');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`storefront_fulfillment_network` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`inventory_pool` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`inventory_pool` SET TAGS ('dbx_subdomain' = 'stock_management');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`inventory_pool` ALTER COLUMN `inventory_pool_id` SET TAGS ('dbx_business_glossary_term' = 'Inventory Pool Identifier');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`inventory_pool` ALTER COLUMN `parent_inventory_pool_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`zone` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`zone` SET TAGS ('dbx_subdomain' = 'warehouse_operations');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`zone` ALTER COLUMN `zone_id` SET TAGS ('dbx_business_glossary_term' = 'Zone Identifier');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`zone` ALTER COLUMN `parent_zone_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`valuation_area` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`valuation_area` SET TAGS ('dbx_subdomain' = 'warehouse_operations');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`valuation_area` ALTER COLUMN `valuation_area_id` SET TAGS ('dbx_business_glossary_term' = 'Valuation Area Identifier');
ALTER TABLE `apparel_fashion_ecm`.`inventory`.`valuation_area` ALTER COLUMN `parent_valuation_area_id` SET TAGS ('dbx_self_ref_fk' = 'true');
