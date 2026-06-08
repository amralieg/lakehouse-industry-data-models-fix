-- Schema for Domain: inventory | Business: Food Beverage | Version: v1_mvm
-- Generated on: 2026-05-05 23:22:30

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `food_beverage_ecm`.`inventory` COMMENT 'Single source of truth for all finished goods, WIP, and raw material stock positions across plants, DCs, and 3PL locations. Manages lot traceability, FEFO/FIFO lot management, shelf life monitoring, stock aging, inventory valuation, and cycle count reconciliation aligned with SAP WM/EWM.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `food_beverage_ecm`.`inventory`.`stock_position` (
    `stock_position_id` BIGINT COMMENT 'Unique identifier for the stock position record. Primary key for the stock position entity.',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: Stock positions must be valued within legal entity boundaries for financial consolidation, statutory reporting, and intercompany elimination. Every inventory balance sheet line requires company code a',
    `lot_id` BIGINT COMMENT 'Reference to the production or procurement lot/batch number for traceability and FEFO/FIFO management.',
    `po_line_id` BIGINT COMMENT 'Foreign key linking to procurement.po_line. Business justification: REQUIRED: Stock aging and cost allocation reports must trace each inventory lot back to its originating purchase order line for financial and quality audits.',
    `product_registration_id` BIGINT COMMENT 'Foreign key linking to regulatory.product_registration. Business justification: Regulatory compliance reports require each stock position to be linked to its product registration for traceability and recall eligibility.',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Stock positions are managed by profit center for P&L accountability, brand/category margin analysis, and segment reporting. Food and beverage companies track inventory by profit center to allocate hol',
    `shelf_life_spec_id` BIGINT COMMENT 'Foreign key linking to product.shelf_life_spec. Business justification: FEFO enforcement and remaining-shelf-life calculations in F&B require linking each stock position to the governing shelf_life_spec. This drives DC receiving standards, rotation rules, retailer complia',
    `sku_id` BIGINT COMMENT 'Reference to the material master record (finished goods, WIP, or raw material SKU) for which stock is held.',
    `storage_location_id` BIGINT COMMENT 'Reference to the physical storage location (plant, DC, 3PL warehouse, or specific bin/zone) where the stock is held.',
    `abc_classification` STRING COMMENT 'Inventory classification based on value and velocity. A items are high-value/high-velocity requiring frequent monitoring; B items are moderate; C items are low-value/low-velocity; X items are obsolete or non-moving.. Valid values are `A|B|C|X`',
    `allergen_segregation_flag` BOOLEAN COMMENT 'Indicates whether the stock contains major allergens and requires physical segregation to prevent cross-contamination.',
    `best_before_date` DATE COMMENT 'Date until which the product maintains optimal quality characteristics. May differ from expiration date for shelf-stable products.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this stock position record was first created in the system.',
    `expiry_status` STRING COMMENT 'Classification of the stock based on remaining shelf life. Valid indicates sufficient shelf life; near-expiry indicates approaching expiration threshold; expired indicates past SLED; no-expiry indicates shelf-stable products without expiration date.. Valid values are `valid|near_expiry|expired|no_expiry`',
    `gtin` STRING COMMENT 'GS1 global trade item number (UPC, EAN, or GTIN-14) for the material at this packaging level. Used for EDI and retail integration.. Valid values are `^d{8,14}$`',
    `hazmat_flag` BOOLEAN COMMENT 'Indicates whether the material is classified as hazardous and requires special handling, storage, and transportation procedures.',
    `last_movement_date` DATE COMMENT 'Date of the most recent goods movement transaction affecting this stock position (receipt, issue, transfer, or adjustment).',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to this stock position record. Updated by every goods movement posting or inventory adjustment.',
    `lot_traceability_code` STRING COMMENT 'External lot or batch code used for supply chain traceability and recall management. May differ from internal lot ID.',
    `organic_certified_flag` BOOLEAN COMMENT 'Indicates whether the stock is certified organic and must be segregated from non-organic inventory to maintain certification integrity.',
    `production_date` DATE COMMENT 'Date when the lot was manufactured or packaged. Used for traceability and shelf life calculation.',
    `quantity_available` DECIMAL(18,2) COMMENT 'Unrestricted quantity available for consumption, sale, or production use. Excludes reserved, blocked, and quality-inspection stock.',
    `quantity_blocked` DECIMAL(18,2) COMMENT 'Quantity restricted from use due to quality issues, regulatory holds, or pending disposition (rework, scrap, return to vendor).',
    `quantity_in_transit` DECIMAL(18,2) COMMENT 'Quantity currently in movement between locations (plant-to-DC, DC-to-DC, or inbound from supplier) but not yet received at destination.',
    `quantity_on_hand` DECIMAL(18,2) COMMENT 'Total physical quantity of the material/lot currently present at the storage location, regardless of availability status.',
    `quantity_quality_inspection` DECIMAL(18,2) COMMENT 'Quantity under quality inspection hold pending QA release. Cannot be used until inspection results are approved.',
    `quantity_reserved` DECIMAL(18,2) COMMENT 'Quantity allocated to specific sales orders, production orders, or transfer orders but not yet physically moved.',
    `quarantine_flag` BOOLEAN COMMENT 'Indicates whether the stock is under quarantine hold pending quality inspection, regulatory clearance, or investigation.',
    `recall_flag` BOOLEAN COMMENT 'Indicates whether the stock is subject to an active product recall and must be segregated and disposed per recall procedures.',
    `receipt_date` DATE COMMENT 'Date when the stock was received into the storage location. Used for FIFO aging analysis and inventory turnover metrics.',
    `remaining_shelf_life_days` STRING COMMENT 'Number of days remaining until shelf life expiration date. Used for FEFO prioritization and aged inventory alerts.',
    `safety_stock_flag` BOOLEAN COMMENT 'Indicates whether this stock position is designated as safety stock buffer to protect against demand variability and supply disruptions.',
    `shelf_life_expiration_date` DATE COMMENT 'Date after which the product should not be sold or consumed. Critical for FEFO lot management and food safety compliance.',
    `special_stock_indicator` STRING COMMENT 'Classification for non-standard stock ownership or purpose. Consignment is vendor-owned stock at customer location; customer-owned is stock held on behalf of customer; project is allocated to specific project; sample is for testing; promotional is for marketing programs. [ENUM-REF-CANDIDATE: consignment|customer_owned|vendor_owned|project|sample|promotional|standard — 7 candidates stripped; promote to reference product]',
    `stock_age_days` STRING COMMENT 'Number of days since the stock was received at the storage location. Used for slow-moving and obsolete inventory analysis.',
    `stock_category` STRING COMMENT 'Classification of stock status indicating availability and restrictions. On-hand is total physical stock; available is unrestricted and not reserved; reserved is allocated to orders; in-transit is goods in movement; quality-inspection is under QA hold; blocked is restricted due to quality or regulatory issues.. Valid values are `on_hand|available|reserved|in_transit|quality_inspection|blocked`',
    `temperature_zone` STRING COMMENT 'Required storage temperature condition for the stock. Ambient is room temperature; refrigerated is 0-8°C; frozen is below 0°C; controlled is specific temperature range per product specification.. Valid values are `ambient|refrigerated|frozen|controlled`',
    `unit_cost` DECIMAL(18,2) COMMENT 'Cost per unit of measure for this stock position. Used to calculate total valuation amount and COGS.',
    `unit_of_measure` STRING COMMENT 'Standard unit of measure for the stock quantity (e.g., EA for each, CS for case, KG for kilogram, LB for pound, LT for liter).. Valid values are `^[A-Z]{2,3}$`',
    `valuation_amount` DECIMAL(18,2) COMMENT 'Total monetary value of the stock position calculated using the applicable valuation method (standard cost, moving average, FIFO). Used for inventory accounting and financial reporting.',
    `valuation_currency` STRING COMMENT 'Three-letter ISO currency code for the valuation amount (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `vendor_lot_number` STRING COMMENT 'Supplier-provided lot or batch number for raw materials and co-packed products. Used for upstream traceability.',
    CONSTRAINT pk_stock_position PRIMARY KEY(`stock_position_id`)
) COMMENT 'Core master record representing the current stock balance for each material/SKU and lot at each storage location. Tracks stock categories (on-hand, available, reserved, in-transit, quality-inspection, blocked) and shelf life attributes (remaining days, SLED, BBD, expiry status). Serves as the single source of truth for real-time inventory balances across finished goods, WIP, and raw materials. Updated by every goods movement posting.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`inventory`.`storage_location` (
    `storage_location_id` BIGINT COMMENT 'Unique identifier for the storage location. Primary key.',
    `center_id` BIGINT COMMENT 'Reference to the distribution center if this storage location is part of a DC network node.',
    `establishment_registration_id` BIGINT COMMENT 'Foreign key linking to regulatory.establishment_registration. Business justification: Facility inspection and audit processes map every storage location to the registered establishment for inspection scheduling and compliance tracking.',
    `plant_id` BIGINT COMMENT 'Reference to the manufacturing plant or facility that owns or operates this storage location.',
    `supplier_id` BIGINT COMMENT 'Reference to the 3PL provider if this storage location is operated by an external logistics partner.',
    `supplier_site_id` BIGINT COMMENT 'Foreign key linking to procurement.supplier_site. Business justification: REQUIRED: Supplier‑managed warehouse locations need to be linked to the specific supplier site for inbound receipt traceability and regulatory compliance.',
    `address_line1` STRING COMMENT 'Primary street address of the storage location. Business-confidential organizational contact data.',
    `address_line2` STRING COMMENT 'Secondary address information (suite, building, floor). Business-confidential organizational contact data.',
    `allergen_segregation_class` STRING COMMENT 'Allergen segregation classification for the storage location. Ensures physical separation of allergen-containing products to prevent cross-contamination. [ENUM-REF-CANDIDATE: none|peanut|tree_nut|dairy|gluten|soy|shellfish|mixed — 8 candidates stripped; promote to reference product]',
    `capacity_pallet_positions` STRING COMMENT 'Number of standard pallet positions available in this storage location. Key metric for warehouse slotting and inventory planning.',
    `capacity_volume_m3` DECIMAL(18,2) COMMENT 'Total storage capacity of the location measured in cubic meters. Used for space utilization analytics and capacity planning.',
    `capacity_weight_kg` DECIMAL(18,2) COMMENT 'Maximum weight capacity of the storage location in kilograms. Critical for structural safety and load planning.',
    `city` STRING COMMENT 'City where the storage location is physically situated. Business-confidential organizational contact data.',
    `country_code` STRING COMMENT 'Three-letter ISO country code where the storage location is located (e.g., USA, CAN, MEX).. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this storage location record was first created in the system. Used for audit trail and data lineage.',
    `effective_end_date` DATE COMMENT 'Date when this storage location was decommissioned or ceased operations. Null if currently active.',
    `effective_start_date` DATE COMMENT 'Date when this storage location became operational and available for inventory placement.',
    `erp_storage_location` STRING COMMENT 'Storage location code as defined in the ERP system (e.g., SAP S/4HANA storage location). Used for financial valuation and inventory accounting.',
    `fefo_enforcement_flag` BOOLEAN COMMENT 'Indicates whether FEFO lot rotation based on expiration dates is enforced at this storage location. Critical for perishable goods management.',
    `fifo_enforcement_flag` BOOLEAN COMMENT 'Indicates whether FIFO lot rotation is enforced at this storage location. True if FIFO rules are active.',
    `gmp_compliant_flag` BOOLEAN COMMENT 'Indicates whether the storage location meets GMP standards for food safety and quality. True if GMP compliant.',
    `halal_certified_flag` BOOLEAN COMMENT 'Indicates whether the storage location is certified for halal product storage. Required for halal certification maintenance.',
    `hazmat_certified_flag` BOOLEAN COMMENT 'Indicates whether the storage location is certified to store hazardous materials. True if HAZMAT certification is active.',
    `kosher_certified_flag` BOOLEAN COMMENT 'Indicates whether the storage location is certified for kosher product storage. Required for kosher certification maintenance.',
    `last_inspection_date` DATE COMMENT 'Date of the most recent quality or safety inspection of the storage location. Used for compliance tracking and audit readiness.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this storage location record was last updated. Supports change tracking and audit compliance.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the storage location. Used for logistics routing and geospatial analytics.',
    `location_code` STRING COMMENT 'Business identifier for the storage location used in warehouse management systems and operational documents. Typically follows plant-site-aisle-bin hierarchy (e.g., PLT01-DC01-A12-B05).. Valid values are `^[A-Z0-9]{4,12}$`',
    `location_name` STRING COMMENT 'Human-readable name or description of the storage location (e.g., Chicago DC Frozen Zone A, Plant 3 Raw Material Staging).',
    `location_type` STRING COMMENT 'Classification of the storage location by its primary operational purpose within the supply chain network. [ENUM-REF-CANDIDATE: plant|distribution_center|3pl_warehouse|cold_storage|staging_area|quarantine_zone|finished_goods|raw_material — 8 candidates stripped; promote to reference product]',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the storage location. Used for logistics routing and geospatial analytics.',
    `next_inspection_due_date` DATE COMMENT 'Scheduled date for the next required inspection of the storage location. Supports proactive compliance management.',
    `notes` STRING COMMENT 'Free-text field for additional operational notes, special handling instructions, or location-specific comments.',
    `operational_status` STRING COMMENT 'Current operational status of the storage location. Determines whether the location can accept new inventory.. Valid values are `active|inactive|maintenance|quarantine|decommissioned|planned`',
    `organic_certified_flag` BOOLEAN COMMENT 'Indicates whether the storage location is certified for organic product storage. Required for USDA Organic compliance.',
    `postal_code` STRING COMMENT 'Postal or ZIP code for the storage location. Business-confidential organizational contact data.',
    `state_province` STRING COMMENT 'State or province of the storage location. Business-confidential organizational contact data.',
    `temperature_max` DECIMAL(18,2) COMMENT 'Maximum allowable temperature in Celsius for this storage location. Exceeding this threshold triggers quality alerts.',
    `temperature_min` DECIMAL(18,2) COMMENT 'Minimum allowable temperature in Celsius for this storage location. Used for cold chain monitoring and compliance.',
    `temperature_zone` STRING COMMENT 'Temperature control classification for the storage location. Critical for food safety compliance and FEFO/FIFO enforcement.. Valid values are `ambient|chilled|frozen|controlled`',
    `wms_location_code` STRING COMMENT 'External location identifier used by the warehouse management system. Enables integration with WMS for real-time inventory tracking.',
    CONSTRAINT pk_storage_location PRIMARY KEY(`storage_location_id`)
) COMMENT 'Master reference for all physical and logical storage locations in the inventory network — plants, distribution centers, 3PL warehouses, cold storage facilities, staging areas, quarantine zones, and allergen-segregated zones. Captures location type, temperature zone (ambient, chilled, frozen), capacity, WMS location code, allergen segregation classification, and operational status. Enables location-level stock visibility and FEFO/FIFO enforcement.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`inventory`.`goods_movement` (
    `goods_movement_id` BIGINT COMMENT 'Unique identifier for the goods movement transaction. Primary key for this entity. Serves as the immutable reference for all inventory state changes across the enterprise.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: COST ACCOUNTING: Material movements must be allocated to a cost center for internal cost of goods sold reporting; finance cost_center is the natural target.',
    `fulfillment_order_id` BIGINT COMMENT 'Foreign key linking to distribution.fulfillment_order. Business justification: Goods issue movements in F&B warehouses are directly triggered by fulfillment order pick/ship events. This link supports OTIF reporting, inventory depletion tracing, and warehouse execution audits. No',
    `lot_trace_id` BIGINT COMMENT 'Foreign key linking to inventory.lot_trace. Business justification: Every goods movement in a lot-controlled food and beverage environment is associated with a specific lot/batch. goods_movement has batch_number as a denormalized STRING. Adding lot_trace_id FK to lot_',
    `order_id` BIGINT COMMENT 'Foreign key linking to sales.order. Business justification: Goods movement records shipments that satisfy a sales order; the FK ties the movement to the originating order for shipping and financial reporting.',
    `production_order_id` BIGINT COMMENT 'Foreign key linking to manufacturing.production_order. Business justification: Goods receipt posting (movement type 101) links a goods movement to the production order that triggered it. Production controllers reconcile confirmed quantities against production orders via goods mo',
    `promotion_event_id` BIGINT COMMENT 'Foreign key linking to trade.promotion_event. Business justification: Movement of promotional goods must be tied to the promotion event for traceability and cost allocation.',
    `shipment_id` BIGINT COMMENT 'Foreign key linking to distribution.shipment. Business justification: Goods movements (GR/GI) in F&B ERP are triggered by inbound/outbound shipments. Linking goods_movement to shipment enables physical-to-financial reconciliation, OTIF root-cause analysis, and FSMA trac',
    `sku_id` BIGINT COMMENT 'The unique product identifier for the material being moved. References the master product catalog. Also known as material number in SAP.',
    `storage_location_id` BIGINT COMMENT 'Foreign key linking to inventory.storage_location. Business justification: goods_movement records inventory state changes between locations. The source_storage_location field is a denormalized STRING. Adding source_storage_location_id FK to storage_location normalizes the so',
    `stock_position_id` BIGINT COMMENT 'Foreign key linking to inventory.stock_position. Business justification: Goods movement records affect a specific stock position (location + SKU + lot). Adding stock_position_id creates a clear parent‑child link and removes the need for separate location/SKU columns if des',
    `stock_transfer_order_id` BIGINT COMMENT 'Foreign key linking to inventory.stock_transfer_order. Business justification: In SAP WM/EWM-aligned inventory operations, goods movements are posted against stock transfer orders. Linking goods_movement to stock_transfer_order enables full operational traceability from planned ',
    `amount_lc` DECIMAL(18,2) COMMENT 'The financial value of the movement in the local currency of the plant. Calculated as quantity × standard cost or moving average price. Positive for receipts, negative for issues. Used for COGS posting and inventory valuation.',
    `approval_status` STRING COMMENT 'Workflow approval status for movements requiring authorization (e.g., write-offs above threshold, manual adjustments). Pending indicates awaiting approval, approved indicates cleared for posting, rejected indicates denied.. Valid values are `pending|approved|rejected`',
    `approval_timestamp` TIMESTAMP COMMENT 'The timestamp when the movement was approved. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX. Nullable if approval is not required or still pending.',
    `cost_center` STRING COMMENT 'The cost center to which the movement is charged (for issues to cost centers) or credited (for receipts from cost centers). Used for internal cost allocation.',
    `currency_code` STRING COMMENT 'The ISO 4217 three-letter currency code for the amount_lc field. Typically the local currency of the plants company code. [ENUM-REF-CANDIDATE: USD|EUR|GBP|JPY|CNY|INR|BRL|MXN|CAD|AUD — 10 candidates stripped; promote to reference product]',
    `customer_code` STRING COMMENT 'Customer identifier for goods issue movements to external customers or for customer returns. Nullable for internal movements.',
    `destination_plant_code` STRING COMMENT 'For transfer movements, the plant to which the material is being moved. Nullable for non-transfer movements.',
    `destination_storage_location` STRING COMMENT 'For transfer movements, the storage location to which the material is being moved. Nullable for non-transfer movements.',
    `document_date` DATE COMMENT 'The date on the originating business document (e.g., delivery note date, production order completion date, cycle count date). May differ from posting_date. Format: yyyy-MM-dd.',
    `entry_timestamp` TIMESTAMP COMMENT 'The system timestamp when the goods movement was posted in the ERP system. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX. Distinct from posting_date which is the financial effective date.',
    `gl_account` STRING COMMENT 'The GL account to which the financial impact is posted. Determined by movement type and account determination configuration. Examples: inventory asset account, COGS account, scrap expense account.',
    `material_description` STRING COMMENT 'Short text description of the material for human readability and reporting. Denormalized from product master for query performance.',
    `material_document_item` STRING COMMENT 'Line item number within the material document. Allows multiple movements to be grouped under a single document header.',
    `material_document_number` STRING COMMENT 'The SAP MM material document number generated upon posting. Unique identifier for the goods movement in the source ERP system. Ten-digit numeric string.. Valid values are `^[0-9]{10}$`',
    `material_document_year` STRING COMMENT 'The fiscal year in which the material document was created. Part of the compound key in SAP MM (material_document_number + material_document_year).',
    `movement_indicator` STRING COMMENT 'High-level classification of the movement direction and purpose. Receipt increases stock, issue decreases stock, transfer moves between locations, adjustment corrects quantity or value, reversal cancels a prior posting, reclassification changes stock type without location change.. Valid values are `receipt|issue|transfer|adjustment|reversal|reclassification`',
    `movement_type` STRING COMMENT 'SAP MM movement type code defining the nature of the inventory transaction. Examples: 101 (GR for PO), 201 (GI for cost center), 261 (GI for production order), 301 (plant-to-plant transfer), 311 (storage location transfer), 551 (scrapping without PO), 561 (initial entry of stock balance), 701 (GR from blocked stock), 702 (GI to blocked stock). Determines debit/credit logic and account determination. [ENUM-REF-CANDIDATE: 101|102|201|202|261|262|301|302|311|312|321|322|343|344|411|412|551|552|561|562|701|702|711|712 — 24 candidates stripped; promote to reference product]',
    `notes` STRING COMMENT 'Free-text field for additional comments or explanations about the movement. Used for manual adjustments, special circumstances, or audit documentation.',
    `plant_code` STRING COMMENT 'The manufacturing plant or distribution center where the movement occurred. Maps to the organizational unit in SAP.',
    `posting_date` DATE COMMENT 'The financial effective date of the goods movement. Determines the fiscal period for COGS recognition and inventory valuation. Must fall within an open fiscal period. Format: yyyy-MM-dd.',
    `profit_center` STRING COMMENT 'The profit center responsible for the movement. Used for segment reporting and profitability analysis.',
    `quantity` DECIMAL(18,2) COMMENT 'The quantity of material moved in the base unit of measure. Positive for receipts, negative for issues. Three decimal places to accommodate fractional units (e.g., 123.456 kg).',
    `reason_code` STRING COMMENT 'Business reason for the movement. Examples: production consumption, customer return, quality rejection, cycle count adjustment, obsolescence, damage, theft, donation, sample. Used for root cause analysis and variance reporting.',
    `reference_document_item` STRING COMMENT 'Line item number within the reference document. Nullable for document types without line items.',
    `reference_document_number` STRING COMMENT 'The unique identifier of the originating business document (e.g., PO number, production order number, sales order number, cycle count ID). Nullable for manual postings.',
    `reference_document_type` STRING COMMENT 'The type of originating business document that triggered this movement. Enables drill-back to source transaction. [ENUM-REF-CANDIDATE: purchase_order|production_order|sales_order|transfer_order|cycle_count|physical_inventory|quality_inspection|manual_adjustment — 8 candidates stripped; promote to reference product]',
    `reversal_indicator` BOOLEAN COMMENT 'Flag indicating whether this movement is a reversal of a prior posting. True if this is a cancellation transaction, false otherwise.',
    `reversed_document_number` STRING COMMENT 'The material document number of the original posting that this movement reverses. Nullable if reversal_indicator is false.',
    `reversed_document_year` STRING COMMENT 'The fiscal year of the original posting that this movement reverses. Nullable if reversal_indicator is false.',
    `source_plant_code` STRING COMMENT 'For transfer movements, the plant from which the material is being moved. Nullable for non-transfer movements.',
    `stock_type` STRING COMMENT 'The inventory status category of the material. Unrestricted is available for use, quality_inspection is awaiting QA clearance, blocked is not usable, restricted has limited use, returns is customer-returned stock.. Valid values are `unrestricted|quality_inspection|blocked|restricted|returns`',
    `storage_location` STRING COMMENT 'The storage location within the plant where the material is physically located. Sub-division of plant for inventory management.',
    `unit_of_measure` STRING COMMENT 'The unit in which the quantity is expressed. Examples: EA (each), CS (case), KG (kilogram), LB (pound), L (liter), GAL (gallon), OZ (ounce), G (gram), ML (milliliter), TON (ton), PAL (pallet). [ENUM-REF-CANDIDATE: EA|CS|KG|LB|L|GAL|OZ|G|ML|TON|PAL — 11 candidates stripped; promote to reference product]',
    `valuation_type` STRING COMMENT 'Split valuation category for materials with multiple valuation classes (e.g., domestic vs imported, organic vs conventional). Nullable if not split-valuated.',
    `vendor_code` STRING COMMENT 'Supplier identifier for goods receipt movements from external vendors. Nullable for internal movements.',
    CONSTRAINT pk_goods_movement PRIMARY KEY(`goods_movement_id`)
) COMMENT 'Transactional record of every inventory state change — goods receipts, goods issues, stock transfers, returns postings, scrap disposals, write-offs, write-ups, reclassifications, cycle count adjustments, reconciliation corrections, and all other inventory adjustments. Each posting captures movement type, quantity, UoM, source/destination locations, lot reference, posting date, reference document, reason code, adjustment reason (for variance and correction postings), financial impact (debit/credit to inventory and COGS accounts), approver where required, and originating event reference (cycle count, quality inspection, production order, or manual correction). Serves as the single, authoritative audit trail for ALL inventory quantity and value changes — no other entity in this domain records stock state mutations. Foundation for inventory reconciliation, COGS postings, adjustment approval workflows, and regulatory traceability. Aligned with SAP MM movement types (101, 201, 301, 311, 551, 561, 701/702).';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`inventory`.`stock_transfer_order` (
    `stock_transfer_order_id` BIGINT COMMENT 'Unique identifier for the stock transfer order. Primary key for this entity.',
    `carrier_id` BIGINT COMMENT 'Identifier of the transportation carrier responsible for moving the stock between locations.',
    `cost_center_id` BIGINT COMMENT 'Cost center to which transfer costs are allocated. Used for internal cost accounting and supply chain cost analysis.',
    `storage_location_id` BIGINT COMMENT 'Identifier of the receiving location to which stock is being transferred. May reference plant, distribution center, or third-party logistics (3PL) facility.',
    `lot_trace_id` BIGINT COMMENT 'Foreign key linking to inventory.lot_trace. Business justification: Stock transfer orders in food and beverage are lot-controlled to maintain FEFO compliance during inter-location transfers. stock_transfer_order has lot_number as a denormalized STRING. Adding lot_trac',
    `order_id` BIGINT COMMENT 'Foreign key linking to sales.order. Business justification: Transfer orders are often generated to replenish stock for a specific sales order; linking provides traceability from order demand to internal transfer.',
    `primary_stock_storage_location_id` BIGINT COMMENT 'Identifier of the originating location from which stock is being transferred. May reference plant, distribution center, or third-party logistics (3PL) facility.',
    `shelf_life_spec_id` BIGINT COMMENT 'Foreign key linking to product.shelf_life_spec. Business justification: Cold-chain and shelf-life compliance during inter-facility transfers in F&B requires referencing the shelf_life_spec to enforce minimum remaining shelf life at destination, temperature excursion toler',
    `sku_id` BIGINT COMMENT 'Identifier of the material, finished good, work-in-progress (WIP), or raw material being transferred. Links to product master data.',
    `actual_receipt_date` DATE COMMENT 'Actual date when stock was received at the destination location. Captured at goods receipt posting.',
    `actual_shipment_date` DATE COMMENT 'Actual date when stock was shipped from the source location. Captured at goods issue posting.',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when this transfer order was approved for execution. Marks transition from planned to released status.',
    `cancelled_reason` STRING COMMENT 'Free-text explanation for why this transfer order was cancelled. Used for root cause analysis and process improvement.',
    `confirmed_quantity` DECIMAL(18,2) COMMENT 'Actual quantity confirmed for transfer after picking and verification. May differ from requested quantity due to availability or quality issues.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this transfer order record was first created in the system. Used for audit trail and lifecycle tracking.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this transfer order.. Valid values are `^[A-Z]{3}$`',
    `expiration_date` DATE COMMENT 'Product expiration or best-by date for the lot being transferred. Used for shelf life monitoring and FEFO lot selection.',
    `maximum_temperature_c` DECIMAL(18,2) COMMENT 'Maximum acceptable temperature in Celsius for this transfer. Used for cold chain monitoring and compliance verification.',
    `minimum_temperature_c` DECIMAL(18,2) COMMENT 'Minimum acceptable temperature in Celsius for this transfer. Used for cold chain monitoring and compliance verification.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this transfer order record was last modified. Used for audit trail and change tracking.',
    `notes` STRING COMMENT 'Additional free-text notes or instructions related to this transfer order. May include special handling instructions, quality concerns, or coordination details.',
    `planned_transfer_date` DATE COMMENT 'Target date for initiating the stock transfer. Used for planning warehouse resources, transportation capacity, and inventory positioning.',
    `priority` STRING COMMENT 'Priority level for processing and execution of the transfer order. Determines sequencing in warehouse operations and transportation planning.. Valid values are `urgent|high|normal|low`',
    `received_quantity` DECIMAL(18,2) COMMENT 'Actual quantity received at destination location. May differ from confirmed quantity due to damage, loss, or discrepancies during transit.',
    `requested_quantity` DECIMAL(18,2) COMMENT 'Planned quantity to be transferred as specified in the transfer order. Represents the target amount for the transfer.',
    `shelf_life_remaining_days` STRING COMMENT 'Number of days of shelf life remaining at the time of transfer initiation. Critical for FEFO (First Expired First Out) inventory management.',
    `shipment_number` STRING COMMENT 'Reference number for the physical shipment associated with this transfer order. Links to transportation management and carrier tracking.. Valid values are `^[A-Z0-9]{8,20}$`',
    `special_handling_code` STRING COMMENT 'Special handling requirements for this transfer. Determines warehouse handling procedures, packaging requirements, and transportation mode.. Valid values are `fragile|hazmat|refrigerated|frozen|high_value|allergen_control`',
    `stock_type` STRING COMMENT 'Classification of stock status at source location. Determines whether stock is available for transfer and use.. Valid values are `unrestricted|quality_inspection|blocked|restricted`',
    `temperature_compliance_flag` BOOLEAN COMMENT 'Indicates whether temperature requirements were maintained throughout the transfer. False value triggers quality review and potential product hold.',
    `temperature_controlled_flag` BOOLEAN COMMENT 'Indicates whether this transfer requires temperature-controlled transportation and handling. Critical for perishable food and beverage products.',
    `transfer_cost_amount` DECIMAL(18,2) COMMENT 'Total cost associated with this stock transfer including transportation, handling, and administrative costs. Used for supply chain cost analysis.',
    `transfer_order_number` STRING COMMENT 'Externally-known business identifier for the stock transfer order. Used for tracking and reference across systems and documents.. Valid values are `^[A-Z0-9]{8,20}$`',
    `transfer_reason_code` STRING COMMENT 'Business reason or trigger for the stock transfer. Used for analytics, cost allocation, and supply chain optimization.. Valid values are `replenishment|rebalancing|quality_hold|recall|production_demand|customer_order`',
    `transfer_status` STRING COMMENT 'Current lifecycle status of the stock transfer order. Tracks progression from planning through execution to completion or cancellation.. Valid values are `planned|released|in_transit|received|cancelled|partially_received`',
    `transfer_type` STRING COMMENT 'Classification of the transfer based on source and destination location types. Determines routing, handling requirements, and approval workflows.. Valid values are `plant_to_plant|dc_to_dc|plant_to_dc|dc_to_plant|3pl_replenishment|internal_transfer`',
    `unit_of_measure` STRING COMMENT 'Unit of measure for all quantity fields. Standard units include each (EA), case (CS), pallet (PL), kilogram (KG), pound (LB), gallon (GAL), liter (LTR). [ENUM-REF-CANDIDATE: EA|CS|PL|KG|LB|GAL|LTR — 7 candidates stripped; promote to reference product]',
    CONSTRAINT pk_stock_transfer_order PRIMARY KEY(`stock_transfer_order_id`)
) COMMENT 'Transactional record for planned and executed inter-location stock transfers — plant-to-plant, DC-to-DC, plant-to-DC, and 3PL replenishment transfers. Captures transfer order number, source and destination locations, material/SKU, lot/batch, requested quantity, confirmed quantity, transfer reason, priority, planned transfer date, actual shipment and receipt dates, temperature compliance flag, and transfer status (planned, released, in-transit, received, cancelled). Distinct from goods_movement: this entity represents the planning/execution document (the order), while goods_movement records the actual stock postings (issue at source, receipt at destination). Aligned with SAP WM Transfer Order (LT0A) and EWM Warehouse Task.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`inventory`.`cycle_count` (
    `cycle_count_id` BIGINT COMMENT 'Unique identifier for the cycle count event. Primary key for the cycle count record.',
    `center_id` BIGINT COMMENT 'Distribution center where the cycle count is performed. Null if count is at plant or 3PL location.',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: Cycle count results drive inventory adjustments that post to company code general ledgers. Financial close processes require reconciliation of cycle count variances by legal entity for accurate period',
    `plant_id` BIGINT COMMENT 'Manufacturing plant or production facility where the cycle count is performed.',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: Cycle count plans in F&B are scoped to specific SKUs for ABC-classification-driven count frequency, allergen-bearing item prioritization, and variance reporting. A domain expert expects cycle_count to',
    `storage_location_id` BIGINT COMMENT 'Foreign key linking to inventory.storage_location. Business justification: A cycle count event is performed at a specific storage location. cycle_count currently stores storage_location_code as a denormalized STRING. Adding storage_location_id FK to storage_location normaliz',
    `accuracy_percentage` DECIMAL(18,2) COMMENT 'Calculated inventory accuracy percentage for this cycle count, representing the ratio of items counted correctly to total items counted.',
    `actual_count_date` DATE COMMENT 'Actual date when the physical count was performed. May differ from scheduled date due to operational constraints.',
    `audit_completion_date` DATE COMMENT 'Date when audit review of the cycle count was completed and findings documented. Null if no audit required or not yet completed.',
    `audit_required_flag` BOOLEAN COMMENT 'Indicates whether this cycle count is subject to internal or external audit review due to materiality or compliance requirements. True if audit required, False otherwise.',
    `comments` STRING COMMENT 'Free-text comments or notes related to the cycle count event, including special instructions, issues encountered, or operational observations.',
    `count_completion_timestamp` TIMESTAMP COMMENT 'Timestamp when the cycle count activity was completed and all items were counted.',
    `count_duration_minutes` STRING COMMENT 'Total duration in minutes from count start to count completion. Used for labor efficiency analysis.',
    `count_method` STRING COMMENT 'Method used to perform the physical count: manual (paper-based), barcode scan (handheld scanner), RFID (radio frequency identification), automated system (WMS-driven), blind count (no system quantity shown), or guided count (system quantity visible).. Valid values are `manual|barcode_scan|rfid|automated_system|blind_count|guided_count`',
    `count_plan_reference` STRING COMMENT 'Reference to the master cycle count plan or schedule that triggered this count event. Used for planned cycle counts.',
    `count_start_timestamp` TIMESTAMP COMMENT 'Timestamp when the cycle count activity was initiated. Used to track count duration and labor efficiency.',
    `count_type` STRING COMMENT 'Type of inventory count being performed: full physical inventory (complete stock take), cycle count (scheduled rotation), spot check (ad-hoc verification), wall-to-wall (complete facility count), ABC cycle (frequency based on value), or perpetual inventory (continuous counting).. Valid values are `full_physical_inventory|cycle_count|spot_check|wall_to_wall|abc_cycle|perpetual_inventory`',
    `counter_assigned` STRING COMMENT 'Name or employee ID of the warehouse worker or team assigned to perform the physical count.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the cycle count record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for variance value amounts.. Valid values are `^[A-Z]{3}$`',
    `cycle_count_status` STRING COMMENT 'Current lifecycle status of the cycle count: planned (scheduled but not started), in-progress (counting underway), completed (count finished, awaiting reconciliation), reconciled (variances resolved and posted), cancelled (count aborted), or on-hold (temporarily suspended).. Valid values are `planned|in_progress|completed|reconciled|cancelled|on_hold`',
    `freeze_end_timestamp` TIMESTAMP COMMENT 'Timestamp when inventory freeze was lifted and normal operations resumed. Null if no freeze applied.',
    `freeze_start_timestamp` TIMESTAMP COMMENT 'Timestamp when inventory movements were frozen for the count. Null if no freeze applied.',
    `inventory_freeze_flag` BOOLEAN COMMENT 'Indicates whether inventory movements were frozen during the count to ensure accuracy. True if frozen, False otherwise.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the cycle count record was last updated or modified.',
    `lot_traceability_required_flag` BOOLEAN COMMENT 'Indicates whether lot-level traceability is required for items in this cycle count due to FSMA or food safety regulations. True if lot tracking required, False otherwise.',
    `physical_inventory_document_number` STRING COMMENT 'SAP physical inventory document number generated for this cycle count event. Maps to SAP MI01/MI04 document.. Valid values are `^[A-Z0-9]{10,20}$`',
    `priority` STRING COMMENT 'Priority level assigned to the cycle count based on item criticality, value, or operational urgency: critical (immediate attention), high (expedited), medium (standard), or low (routine).. Valid values are `critical|high|medium|low`',
    `reconciliation_date` DATE COMMENT 'Date when inventory variances were reconciled and adjustments posted to the general ledger and inventory records.',
    `reconciliation_notes` STRING COMMENT 'Free-text notes documenting the reconciliation process, root cause analysis of variances, and corrective actions taken.',
    `recount_completion_date` DATE COMMENT 'Date when the recount was completed, if a recount was required. Null if no recount performed.',
    `recount_required_flag` BOOLEAN COMMENT 'Indicates whether a recount is required due to variances exceeding threshold or data quality concerns. True if recount needed, False otherwise.',
    `scheduled_date` DATE COMMENT 'Planned date for the cycle count to be performed. Set during count planning phase.',
    `source_system` STRING COMMENT 'Name of the source system that originated this cycle count record (e.g., SAP S/4HANA WM, Oracle WMS, Blue Yonder WMS).',
    `supervisor_assigned` STRING COMMENT 'Name or employee ID of the supervisor responsible for overseeing and validating the cycle count.',
    `total_items_counted` STRING COMMENT 'Total number of distinct SKUs or line items included in this cycle count event.',
    `total_variance_items` STRING COMMENT 'Number of items where physical count differed from book inventory, exceeding the variance threshold.',
    `total_variance_value` DECIMAL(18,2) COMMENT 'Total financial value of inventory variances identified during the cycle count, calculated using standard cost or moving average price.',
    `variance_threshold_percentage` DECIMAL(18,2) COMMENT 'Acceptable variance threshold as a percentage of book quantity before a recount or investigation is triggered.',
    `variance_threshold_quantity` DECIMAL(18,2) COMMENT 'Acceptable variance threshold in quantity units before a recount or investigation is triggered. Set based on item value and criticality.',
    CONSTRAINT pk_cycle_count PRIMARY KEY(`cycle_count_id`)
) COMMENT 'Master record for scheduled and ad-hoc physical inventory cycle count events at a storage location. Captures count plan reference, count type (full physical inventory, cycle count, spot check), scheduled date, actual count date, counter assigned, count status (planned, in-progress, completed, reconciled), and variance threshold. Aligned with SAP MI01/MI04 Physical Inventory Document. Supports continuous inventory accuracy programs and audit compliance.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`inventory`.`adjustment` (
    `adjustment_id` BIGINT COMMENT 'System-generated unique identifier for the inventory adjustment record.',
    `storage_location_id` BIGINT COMMENT 'Destination location identifier for inventory reclassification adjustments.',
    `sku_id` BIGINT COMMENT 'Destination material (SKU) identifier for reclassification adjustments.',
    `adjustment_sku_id` BIGINT COMMENT 'Identifier of the material (SKU) being adjusted.',
    `adjustment_storage_location_id` BIGINT COMMENT 'Warehouse, distribution center, or 3PL location where the adjustment took place.',
    `cost_center_id` BIGINT COMMENT 'Cost center associated with the financial impact of the adjustment.',
    `cycle_count_id` BIGINT COMMENT 'Foreign key linking to inventory.cycle_count. Business justification: Inventory adjustments are frequently triggered by cycle count variances — a core business process in food and beverage inventory management. Linking adjustment to cycle_count enables direct traceabili',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: ACCOUNTING ENTRY: Adjustments (e.g., write‑offs, reclass) require a GL account for journal posting; finance.gl_account provides the required account.',
    `goods_movement_id` BIGINT COMMENT 'Foreign key linking to inventory.goods_movement. Business justification: An inventory adjustment results in a goods movement posting in the WMS/ERP system. Linking adjustment to goods_movement enables reconciliation between the business-level adjustment record and the syst',
    `lot_trace_id` BIGINT COMMENT 'Foreign key linking to inventory.lot_trace. Business justification: Inventory adjustments in food and beverage are frequently lot-specific — quality write-offs, expiry disposals, and reclassifications target specific lots. Adding lot_trace_id FK to lot_trace normalize',
    `product_registration_id` BIGINT COMMENT 'Foreign key linking to regulatory.product_registration. Business justification: Inventory adjustments affect quantities of registered products; regulators require linkage for accurate reporting of stock changes.',
    `production_order_id` BIGINT COMMENT 'Foreign key linking to manufacturing.production_order. Business justification: Inventory adjustments are created to post yield variances, scrap, and rework quantities from production order confirmations. Finance and production controllers reconcile adjustment postings against pr',
    `promotion_event_id` BIGINT COMMENT 'Foreign key linking to trade.promotion_event. Business justification: Promotional events often trigger inventory adjustments; linking provides traceability for promo‑driven inventory changes.',
    `stock_position_id` BIGINT COMMENT 'Foreign key linking to inventory.stock_position. Business justification: Inventory adjustments modify quantities of a particular stock position; linking directly removes redundant location/SKU data.',
    `accounting_document_number` STRING COMMENT 'Identifier of the financial document generated by the adjustment.',
    `adjusted_quantity` DECIMAL(18,2) COMMENT 'Quantity change resulting from the adjustment (positive for increase, negative for decrease).',
    `adjusted_value_amount` DECIMAL(18,2) COMMENT 'Monetary value of the quantity adjustment before accounting postings.',
    `adjustment_number` STRING COMMENT 'Business identifier assigned to the adjustment (e.g., posting number).',
    `adjustment_status` STRING COMMENT 'Current lifecycle status of the adjustment record.. Valid values are `draft|posted|approved|rejected`',
    `adjustment_timestamp` TIMESTAMP COMMENT 'Date and time when the adjustment event occurred in the business process.',
    `adjustment_type` STRING COMMENT 'Category of the inventory adjustment indicating the nature of the change.. Valid values are `write_off|write_up|scrap|quality_block|reclass`',
    `approved_timestamp` TIMESTAMP COMMENT 'Timestamp when the adjustment was approved.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the adjustment record was first created in the system.',
    `credit_account` STRING COMMENT 'General ledger account credited by the adjustment.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 currency code for monetary amounts.. Valid values are `^[A-Z]{3}$`',
    `debit_account` STRING COMMENT 'General ledger account debited by the adjustment.',
    `external_reference_code` STRING COMMENT 'Identifier linking to an external system record (e.g., EDI message).',
    `financial_impact_amount` DECIMAL(18,2) COMMENT 'Net monetary impact of the adjustment after accounting entries.',
    `inventory_valuation_method` STRING COMMENT 'Valuation method applied to the inventory at the time of adjustment.. Valid values are `standard|moving_average|fifo|fefo`',
    `is_manual_adjustment` BOOLEAN COMMENT 'True if the adjustment was entered manually rather than generated by an automated process.',
    `is_quality_hold` BOOLEAN COMMENT 'True if the inventory is placed on quality hold as part of the adjustment.',
    `notes` STRING COMMENT 'Additional comments or remarks about the adjustment.',
    `posting_date` DATE COMMENT 'Accounting posting date for the adjustment.',
    `quality_hold_reason` STRING COMMENT 'Reason why the inventory was placed on quality hold.',
    `reason_category` STRING COMMENT 'High‑level category grouping of adjustment reasons.. Valid values are `damage|theft|shrinkage|error|regulatory`',
    `reason_code` STRING COMMENT 'Standardized code representing why the adjustment was made.',
    `reason_description` STRING COMMENT 'Free‑text description providing additional context for the adjustment reason.',
    `source_document_number` STRING COMMENT 'Reference number of the originating event (e.g., cycle count document).',
    `source_document_type` STRING COMMENT 'Type of the originating document that triggered the adjustment.. Valid values are `cycle_count|quality_inspection|manual_correction`',
    `source_system` STRING COMMENT 'Source ERP or system that originated the adjustment (e.g., SAP WM).',
    `tax_implication_flag` BOOLEAN COMMENT 'Indicates whether the adjustment has tax consequences.',
    `unit_of_measure` STRING COMMENT 'Measurement unit for the adjusted quantity.. Valid values are `EA|KG|L|ML|BOX`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the adjustment record.',
    CONSTRAINT pk_adjustment PRIMARY KEY(`adjustment_id`)
) COMMENT 'Transactional record of inventory quantity and value adjustments resulting from cycle counts, quality holds, write-offs, scrap, and reconciliation corrections. Captures adjustment type (write-off, write-up, scrap, quality block, reclass), adjusted quantity, adjustment reason, financial impact (debit/credit to COGS or inventory account), approver, and reference to originating event (cycle count, quality inspection, or manual correction). Aligned with SAP MM inventory adjustment postings.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`inventory`.`valuation` (
    `valuation_id` BIGINT COMMENT 'System-generated unique identifier for each inventory valuation record.',
    `batch_record_id` BIGINT COMMENT 'Foreign key linking to manufacturing.batch_record. Business justification: Batch-level inventory valuation requires linking valuation records to the manufacturing batch record for standard vs. actual cost variance analysis — a core food manufacturing finance process. valuati',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: Inventory valuations are legal-entity-specific for statutory reporting under local GAAP, transfer pricing compliance, and intercompany profit elimination. Each company code maintains separate valuatio',
    `fiscal_period_id` BIGINT COMMENT 'Foreign key linking to finance.fiscal_period. Business justification: Standard cost valuations are released and frozen by fiscal period for cost accounting close, variance analysis, and period-over-period cost trend reporting. Food manufacturers require period-specific ',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: FINANCIAL REPORTING: Inventory valuation adjustments are posted to a GL account; linking to finance.gl_account enables accurate balance‑sheet entries.',
    `cost_id` BIGINT COMMENT 'Foreign key linking to ingredient.cost. Business justification: Inventory valuation must reference the standard or moving average ingredient cost record to calculate price variance amounts. Finance teams use this link in period-end inventory revaluation, purchase ',
    `plant_id` BIGINT COMMENT 'Identifier of the manufacturing plant or distribution center where the inventory is located.',
    `product_registration_id` BIGINT COMMENT 'Foreign key linking to regulatory.product_registration. Business justification: Valuation statements submitted to regulators must identify the product registration associated with each valuation record.',
    `product_standard_cost_id` BIGINT COMMENT 'Foreign key linking to product.product_standard_cost. Business justification: Inventory valuation in F&B is reconciled against standard cost records to compute price variance and COGS. Linking valuation to product_standard_cost enables standard-vs-actual cost variance reporting',
    `sku_id` BIGINT COMMENT 'Unique identifier of the material (SKU) being valued.',
    `stock_position_id` BIGINT COMMENT 'Foreign key linking to inventory.stock_position. Business justification: Financial valuation records should be linkable to specific stock positions for lot-level inventory valuation reconciliation — a core requirement in SAP WM/EWM-aligned food and beverage operations. val',
    `adjustment_amount` DECIMAL(18,2) COMMENT 'Monetary adjustments applied during valuation (e.g., price variance, revaluation).',
    `class_code` STRING COMMENT 'Code that groups materials for accounting purposes (e.g., raw material, finished goods).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the valuation record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for the monetary amounts.. Valid values are `^[A-Z]{3}$`',
    `expiration_date` DATE COMMENT 'Date on which the material expires, if applicable.',
    `gross_valuation_amount` DECIMAL(18,2) COMMENT 'Total value before any adjustments (quantity_on_hand * unit_cost).',
    `lot_number` STRING COMMENT 'Identifier for the production lot associated with the inventory.',
    `material_description` STRING COMMENT 'Human‑readable description of the material.',
    `material_number` STRING COMMENT 'Stock Keeping Unit (SKU) or Global Trade Item Number (GTIN) of the material.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the valuation record.',
    `net_valuation_amount` DECIMAL(18,2) COMMENT 'Final valuation amount after adjustments (gross - adjustments).',
    `notes` STRING COMMENT 'Free‑form comments or remarks related to the valuation.',
    `price_variance_amount` DECIMAL(18,2) COMMENT 'Difference between standard cost and actual cost for the material.',
    `quantity_on_hand` DECIMAL(18,2) COMMENT 'Current physical quantity of the material in stock at the valuation date.',
    `revaluation_amount` DECIMAL(18,2) COMMENT 'Amount added or subtracted to align inventory value with current market or cost changes.',
    `shelf_life_remaining_days` STRING COMMENT 'Number of days remaining before the material reaches its shelf life limit.',
    `source_system` STRING COMMENT 'Originating ERP or warehouse management system that supplied the valuation data.. Valid values are `SAP WM|Oracle ERP|JDE`',
    `unit_cost` DECIMAL(18,2) COMMENT 'Cost per unit of material as determined by the selected valuation method.',
    `unit_of_measure` STRING COMMENT 'Measurement unit for the material quantity (kilograms, liters, each, case).. Valid values are `KG|L|EA|CASE`',
    `valuation_method` STRING COMMENT 'Costing method used for the valuation (Standard Cost, Moving Average, FIFO, LIFO).. Valid values are `standard|moving_average|fifo|lifo`',
    `valuation_number` STRING COMMENT 'External reference number assigned to the valuation transaction for audit and traceability.',
    `valuation_status` STRING COMMENT 'Current processing state of the valuation record.. Valid values are `pending|posted|reversed|cancelled`',
    `valuation_timestamp` TIMESTAMP COMMENT 'Date and time when the inventory valuation was performed.',
    CONSTRAINT pk_valuation PRIMARY KEY(`valuation_id`)
) COMMENT 'Financial valuation record for inventory by material, plant, and valuation class. Captures valuation method (standard cost, moving average, FIFO), unit cost, total inventory value, price variance, and revaluation amounts. Supports COGS calculation, balance sheet inventory reporting, month-end close, and cost variance analysis.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`inventory`.`lot_trace` (
    `lot_trace_id` BIGINT COMMENT 'Unique identifier for each lot traceability record.',
    `approved_supplier_id` BIGINT COMMENT 'Foreign key linking to ingredient.approved_supplier. Business justification: Inventory lot trace records must identify the approved supplier for each lot to support supplier traceability in recall scenarios, FSMA one-up reporting, and supplier performance tracking. F&B compani',
    `bill_of_materials_id` BIGINT COMMENT 'Foreign key linking to product.bill_of_materials. Business justification: FSMA 204 traceability and recall investigations in F&B require linking a production lot to the exact BOM revision used to manufacture it. This enables one-up/one-down traceability, root-cause analysis',
    `food_safety_plan_id` BIGINT COMMENT 'Foreign key linking to regulatory.food_safety_plan. Business justification: FSMA mandates linking production lots to the controlling food safety plan for verification activities. Each lot must be traceable to the preventive controls and CCPs under which it was produced, enabl',
    `formulation_id` BIGINT COMMENT 'Foreign key linking to product.formulation. Business justification: In F&B, each production lot is manufactured against a specific formulation version. Linking lot_trace to formulation enables quality investigations, recall scope determination by formulation version, ',
    `lot_id` BIGINT COMMENT 'Foreign key linking to ingredient.lot. Business justification: FSMA one-up/one-down traceability requires direct linkage from inventory lot trace records to the originating ingredient lot. This supports FDA FSMA 204 CTE reporting and recall execution without mult',
    `inspection_lot_id` BIGINT COMMENT 'Foreign key linking to quality.inspection_lot. Business justification: Traceability reports attach inspection outcomes to each lot; the link enables downstream quality status calculations.',
    `product_registration_id` BIGINT COMMENT 'Foreign key linking to regulatory.product_registration. Business justification: Lot traceability reports must reference the product registration to ensure labeling, safety, and regulatory compliance of each lot.',
    `production_order_id` BIGINT COMMENT 'Foreign key linking to manufacturing.production_order. Business justification: FSMA one-up-one-down traceability requires linking each inventory lot trace record to the production order that created it. Recall investigations and regulatory audits navigate from lot_trace to produ',
    `recall_event_id` BIGINT COMMENT 'Foreign key linking to regulatory.recall_event. Business justification: FSMA requires direct traceability from production lots to recall events for one-up-one-down tracking. When recalls occur, specific lots must be identified, traced, and dispositioned. This link enables',
    `shipment_id` BIGINT COMMENT 'Foreign key linking to distribution.shipment. Business justification: FSMA Section 204 one-up-one-down traceability mandates linking lot records to the shipment that transported them. F&B domain experts universally expect this link for recall readiness and regulatory re',
    `sku_id` BIGINT COMMENT 'SKU or GTIN of the product contained in the lot.',
    `stock_position_id` BIGINT COMMENT 'Foreign key linking to inventory.stock_position. Business justification: Lot traceability is tied to a specific stock position; the FK consolidates location and lot information.',
    `storage_location_id` BIGINT COMMENT 'Identifier of the storage location (warehouse, DC, or 3PL site) holding the lot.',
    `compliance_status` STRING COMMENT 'Indicates whether the lot meets all applicable FDA/USDA/GFSI requirements.. Valid values are `compliant|non_compliant|pending`',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 code of the currency for lot cost.. Valid values are `USD|EUR|GBP|JPY|CAD|AUD`',
    `downstream_lot_refs` STRING COMMENT 'Identifiers of finished‑goods or shipment lots derived from this lot.',
    `expiration_date` DATE COMMENT 'Date after which the lot is considered expired for sale or consumption.',
    `fsma_one_up_one_down_flag` BOOLEAN COMMENT 'True when the lot must satisfy FSMA one‑up/one‑down traceability.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the latest modification to the lot traceability record.',
    `lot_cost_amount` DECIMAL(18,2) COMMENT 'Monetary cost attributed to the lot (e.g., material cost).',
    `lot_creation_timestamp` TIMESTAMP COMMENT 'Date‑time when the lot traceability record was first created.',
    `lot_owner` STRING COMMENT 'Name of the party that owns or supplied the lot.',
    `lot_status` STRING COMMENT 'Lifecycle status of the lot within inventory.. Valid values are `in_stock|allocated|shipped|consumed|quarantined|recalled`',
    `lot_type` STRING COMMENT 'Category indicating whether the lot is raw material, intermediate, finished good, or packaging.. Valid values are `raw_material|intermediate|finished_goods|packaging`',
    `max_temperature_c` DECIMAL(18,2) COMMENT 'Upper bound of the temperature range for the lot.',
    `min_temperature_c` DECIMAL(18,2) COMMENT 'Lower bound of the temperature range for the lot.',
    `plant_code` STRING COMMENT 'Code identifying the manufacturing plant where the lot was produced.',
    `product_name` STRING COMMENT 'Descriptive name of the product associated with the lot.',
    `production_date` DATE COMMENT 'Date the lot was created in the manufacturing process.',
    `quality_status` STRING COMMENT 'Result of the most recent quality check performed on the lot.. Valid values are `passed|failed|pending|rework`',
    `quantity` BIGINT COMMENT 'Total count or weight of units contained in the lot.',
    `recall_flag` BOOLEAN COMMENT 'True if the lot has been placed under a product recall.',
    `receipt_date` DATE COMMENT 'Date the lot entered inventory from inbound receipt.',
    `shelf_life_days` STRING COMMENT 'Number of days the lot remains usable from production date.',
    `source_system` STRING COMMENT 'Originating system of the lot data (e.g., SAP WM, Aveva MES).',
    `temperature_controlled_flag` BOOLEAN COMMENT 'True when the lot must be stored within a defined temperature range.',
    `traceability_status` STRING COMMENT 'Indicates the one‑up/one‑down traceability configuration for the lot.. Valid values are `one_up_one_down|one_up_many_down|many_up_one_down|none`',
    `transformation_event_code` BIGINT COMMENT 'Identifier of the manufacturing or co‑packing event that transformed upstream lots into this lot.',
    `unit_of_measure` STRING COMMENT 'Measurement unit for the lot quantity (e.g., kilograms, liters).. Valid values are `kg|lb|unit|liter|gallon`',
    `upstream_lot_refs` STRING COMMENT 'Identifiers of ingredient or packaging lots that were combined to create this lot.',
    CONSTRAINT pk_lot_trace PRIMARY KEY(`lot_trace_id`)
) COMMENT 'Traceability record linking each lot/batch through its complete supply chain journey — from raw material receipt (supplier lot), through production (manufacturing batch), to finished goods lot and outbound shipment. Captures upstream lot references (ingredient lots, packaging lots), downstream lot references (finished goods lots, customer shipment lots), transformation events (production order, co-packing run), and traceability status. Supports FSMA one-up/one-down traceability requirements and recall execution.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`inventory`.`quarantine_hold` (
    `quarantine_hold_id` BIGINT COMMENT 'System-generated unique identifier for each quarantine hold record.',
    `allergen_id` BIGINT COMMENT 'Foreign key linking to ingredient.allergen. Business justification: Allergen cross-contact events and undeclared allergen findings directly trigger quarantine holds. Linking quarantine_hold to the specific allergen record supports allergen incident management, regulat',
    `batch_record_id` BIGINT COMMENT 'Foreign key linking to manufacturing.batch_record. Business justification: When a manufactured batch fails QA, a quarantine hold is placed referencing the specific batch record. Disposition decisions (rework, destroy, release) require direct access to the batch record. Food ',
    `center_id` BIGINT COMMENT 'Identifier of the distribution center (DC) where the inventory is stored.',
    `cold_chain_event_id` BIGINT COMMENT 'Foreign key linking to distribution.cold_chain_event. Business justification: Cold chain excursion events are a primary automated trigger for quarantine holds on temperature-sensitive F&B products. Linking these enables automated hold creation workflows, HACCP corrective action',
    `company_code_id` BIGINT COMMENT 'Foreign key linking to finance.company_code. Business justification: Quarantine holds create contingent liabilities and inventory reserves that must be tracked by legal entity for financial statement preparation, provision calculations, and Sarbanes-Oxley controls in m',
    `food_safety_plan_id` BIGINT COMMENT 'Foreign key linking to regulatory.food_safety_plan. Business justification: Quarantine holds triggered by CCP deviations or preventive control failures must link to the food safety plan for corrective action tracking and root cause analysis. This enables FSMA-required documen',
    `lot_trace_id` BIGINT COMMENT 'Foreign key linking to inventory.lot_trace. Business justification: Quarantine holds in food and beverage are frequently lot-specific — a specific batch/lot is placed on hold pending quality inspection or regulatory review. Linking quarantine_hold to lot_trace enables',
    `plant_id` BIGINT COMMENT 'Identifier of the manufacturing plant owning the inventory.',
    `raw_material_id` BIGINT COMMENT 'Internal identifier of the material (SKU/GTIN) that is on hold.',
    `recall_event_id` BIGINT COMMENT 'Foreign key linking to regulatory.recall_event. Business justification: Quarantine holds are often triggered by recall events; linking enables the recall management process to track affected inventory.',
    `shelf_life_spec_id` BIGINT COMMENT 'Foreign key linking to product.shelf_life_spec. Business justification: Quarantine hold disposition timelines in F&B are governed by shelf_life_spec — specifically quality_hold_threshold_days and total_shelf_life_days determine how long held product can remain before mand',
    `shipment_id` BIGINT COMMENT 'Foreign key linking to distribution.shipment. Business justification: Quarantine holds in F&B are frequently triggered by inbound shipment quality failures (temperature excursions, damaged goods, supplier non-conformance). Linking quarantine_hold to the triggering shipm',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: Quarantine holds in F&B are placed on finished-goods SKUs for quality failures, allergen cross-contact, or regulatory recall triggers. The existing material_id covers raw materials; a sku_id FK is req',
    `stock_position_id` BIGINT COMMENT 'Foreign key linking to inventory.stock_position. Business justification: Quarantine hold is applied to a specific stock position; linking provides the exact inventory record under hold.',
    `storage_location_id` BIGINT COMMENT 'Foreign key linking to inventory.storage_location. Business justification: A quarantine hold is placed on inventory at a specific storage location. quarantine_hold currently stores storage_location_code as a denormalized STRING. Adding storage_location_id FK to storage_locat',
    `supplier_id` BIGINT COMMENT 'Identifier of the supplier associated with the material, used when the hold originates from supplier deviation.',
    `test_result_id` BIGINT COMMENT 'Foreign key linking to ingredient.test_result. Business justification: Quality-triggered quarantine holds must reference the specific test result that initiated the hold for CAPA traceability, regulatory inspection readiness, and hold disposition decisions. QA managers r',
    `allergen_flag` BOOLEAN COMMENT 'Indicates whether the hold is due to allergen cross‑contact risk.',
    `comments` STRING COMMENT 'Additional free‑form notes from quality personnel.',
    `compliance_status` STRING COMMENT 'Overall compliance state of the held inventory.. Valid values are `compliant|non_compliant|pending`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the quarantine hold record was created in the system.',
    `disposition_decision` STRING COMMENT 'Final decision taken after review of the hold.. Valid values are `release|rework|destroy|return_to_supplier`',
    `expected_review_timestamp` TIMESTAMP COMMENT 'Planned date and time for the hold to be reviewed or resolved.',
    `expiration_date` DATE COMMENT 'Expiration date of the lot/batch that is on hold.',
    `hold_initiation_timestamp` TIMESTAMP COMMENT 'Date and time when the quarantine hold was placed on inventory.',
    `hold_number` STRING COMMENT 'External reference number used by quality teams to track the hold.',
    `hold_reason` STRING COMMENT 'Free‑text description providing detailed justification for the hold.',
    `hold_release_timestamp` TIMESTAMP COMMENT 'Date and time when the hold was officially released (nullable if not yet released).',
    `hold_source_system` STRING COMMENT 'Name of the source system that originated the hold record (e.g., SAP QM).',
    `hold_status` STRING COMMENT 'Current lifecycle state of the hold.. Valid values are `active|released|reworked|destroyed|returned`',
    `hold_type` STRING COMMENT 'Category of the hold indicating the underlying reason such as quality inspection, regulatory, allergen cross‑contact, recall, or supplier deviation.. Valid values are `quality_inspection|regulatory|allergen|recall|supplier_deviation`',
    `is_critical_item` BOOLEAN COMMENT 'True if the held inventory is classified as a critical item for production or supply.',
    `material_number` STRING COMMENT 'Business code of the material (e.g., SKU, GTIN).',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the quarantine hold record.',
    `quantity_held` DECIMAL(18,2) COMMENT 'Amount of inventory (in the unit defined by unit_of_measure) placed under quarantine.',
    `recall_flag` BOOLEAN COMMENT 'True when the hold is associated with a product recall.',
    `regulatory_lot_status` STRING COMMENT 'Regulatory classification of the lot (e.g., approved, restricted, under review).. Valid values are `approved|restricted|under_review`',
    `regulatory_reference` STRING COMMENT 'Reference to the regulatory notice or compliance document (e.g., FDA recall notice).',
    `shelf_life_remaining_days` STRING COMMENT 'Number of days remaining before the product reaches its shelf life limit.',
    `unit_of_measure` STRING COMMENT 'Measurement unit for quantity_held (e.g., kg, L, units).',
    CONSTRAINT pk_quarantine_hold PRIMARY KEY(`quarantine_hold_id`)
) COMMENT 'Operational record for inventory placed under quality hold or quarantine status — pending quality inspection, regulatory hold, allergen cross-contact risk, or recall investigation. Captures hold type (quality inspection, regulatory, allergen, recall, supplier deviation), hold reason, quantity held, lot/batch reference, storage location, hold initiation date, expected review date, hold release date, disposition decision (release, rework, destroy, return to supplier), and authorizing quality manager. Aligned with SAP QM usage decision. Drives stock blocking in stock_position and triggers quality domain workflows.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`inventory`.`reservation` (
    `reservation_id` BIGINT COMMENT 'Primary key for reservation',
    `center_id` BIGINT COMMENT 'Identifier of the DC where the reserved inventory is held, if applicable.',
    `cost_center_id` BIGINT COMMENT 'Financial cost center associated with the reservation for internal accounting.',
    `fulfillment_order_id` BIGINT COMMENT 'Foreign key linking to distribution.fulfillment_order. Business justification: Inventory reservations in F&B warehouses are created when fulfillment orders are released to the WMS. Linking reservation to fulfillment_order enables ATP (available-to-promise) validation, pick confi',
    `lot_trace_id` BIGINT COMMENT 'Foreign key linking to inventory.lot_trace. Business justification: In FEFO-managed food and beverage inventory, reservations are often lot-specific — stock is earmarked for a specific lot to ensure first-expiry-first-out compliance. Linking reservation to lot_trace e',
    `order_id` BIGINT COMMENT 'Foreign key linking to sales.order. Business justification: Order fulfillment creates inventory reservations; the reservation record must reference the sales order to track allocated stock for each order.',
    `production_order_id` BIGINT COMMENT 'Foreign key linking to manufacturing.production_order. Business justification: Material reservations are created against production orders to earmark raw materials and packaging. MRP and production planners use this link to confirm material availability per order. Standard ERP m',
    `profit_center_id` BIGINT COMMENT 'Foreign key linking to finance.profit_center. Business justification: Reservations for sales orders require profit center attribution for revenue recognition planning, margin forecasting, and available-to-promise calculations by business segment. Critical for food and b',
    `raw_material_id` BIGINT COMMENT 'Unique identifier of the material (SKU) for which inventory is being reserved.',
    `sku_id` BIGINT COMMENT 'Foreign key linking to product.sku. Business justification: Finished-goods inventory reservations in F&B are made against specific SKUs for customer orders and promotional events. The existing material_id covers raw material reservations; a sku_id FK is requir',
    `stock_position_id` BIGINT COMMENT 'Foreign key linking to inventory.stock_position. Business justification: Reservation reserves quantity from a specific stock position. Linking to stock_position eliminates duplicate location/SKU/lot data.',
    `storage_location_id` BIGINT COMMENT 'Identifier of the warehouse, storage bin, or 3PL site where the reserved stock resides.',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when the reservation received formal approval.',
    `cancelled_reason` STRING COMMENT 'Reason provided for cancelling the reservation.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the reservation record was first captured in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 code representing the currency of the reserved value.',
    `expiration_date` DATE COMMENT 'Calendar date on which the reserved inventory becomes unsellable or non‑usable.',
    `freeze_end_timestamp` TIMESTAMP COMMENT 'Timestamp when the inventory freeze ended.',
    `freeze_start_timestamp` TIMESTAMP COMMENT 'Timestamp when the inventory freeze began.',
    `fulfillment_status` STRING COMMENT 'Indicates the progress of fulfilling the reservation against the reserved quantity.. Valid values are `pending|partial|complete|released`',
    `is_frozen` BOOLEAN COMMENT 'Indicates whether the reserved inventory is currently frozen for audit or regulatory purposes.',
    `is_quality_hold` BOOLEAN COMMENT 'Flag indicating the reserved stock is on quality hold pending inspection or test results.',
    `is_temperature_controlled` BOOLEAN COMMENT 'Indicates whether the reserved stock requires temperature‑controlled handling.',
    `max_temperature_c` DECIMAL(18,2) COMMENT 'Maximum allowable temperature for the reserved product, in degrees Celsius.',
    `min_temperature_c` DECIMAL(18,2) COMMENT 'Minimum allowable temperature for the reserved product, in degrees Celsius.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the reservation record.',
    `notes` STRING COMMENT 'Optional free‑text comments or instructions related to the reservation.',
    `plant_code` STRING COMMENT 'Code of the manufacturing plant associated with the inventory reservation.',
    `priority` STRING COMMENT 'Business priority assigned to the reservation to influence allocation order.. Valid values are `high|medium|low`',
    `quality_hold_reason` STRING COMMENT 'Explanation for why the reservation is placed on quality hold.',
    `requesting_party_code` BIGINT COMMENT 'Identifier of the internal or external party that initiated the reservation (e.g., production planner, sales representative, customer).',
    `requirement_date` DATE COMMENT 'Date by which the reserved inventory must be available for the downstream process.',
    `reservation_number` STRING COMMENT 'External business identifier assigned to the reservation, used in operational communications and reporting.',
    `reservation_source` STRING COMMENT 'Origin of the reservation request indicating whether it was generated by a system process, entered manually, or received via an API.. Valid values are `system|manual|api`',
    `reservation_status` STRING COMMENT 'Current lifecycle state of the reservation indicating whether it is still being planned, has been allocated, completed, or terminated.. Valid values are `draft|open|allocated|fulfilled|cancelled|expired`',
    `reservation_timestamp` TIMESTAMP COMMENT 'The exact date and time when the reservation was created or became effective in the business process.',
    `reservation_type` STRING COMMENT 'Classifies the purpose of the reservation such as production order, sales order, promotional allocation, maintenance, or stock transfer.. Valid values are `production|sales|promotion|maintenance|transfer`',
    `reserved_quantity` DECIMAL(18,2) COMMENT 'Quantity of the material that is earmarked for the reservation, expressed in the unit of measure.',
    `reserved_value_amount` DECIMAL(18,2) COMMENT 'Monetary value of the reserved quantity based on current cost or price.',
    `shelf_life_remaining_days` STRING COMMENT 'Number of days remaining before the reserved product expires, calculated from production/receipt date.',
    `source_system` STRING COMMENT 'Name of the upstream system that originated the reservation record (e.g., SAP WM, Oracle SCM).',
    `unit_of_measure` STRING COMMENT 'Standard unit in which the reserved quantity is measured (e.g., KG, L, PCS).',
    CONSTRAINT pk_reservation PRIMARY KEY(`reservation_id`)
) COMMENT 'Transactional record for inventory reservations that earmark specific stock quantities for planned consumption — production orders, sales orders, promotional allocations, or maintenance requirements. Captures reservation type, reserved quantity, requirement date, priority, and fulfillment status. Prevents double-allocation of constrained inventory and supports ATP (available-to-promise) calculations.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`inventory`.`cycle_count_item` (
    `cycle_count_item_id` BIGINT COMMENT 'Unique identifier for the cycle count line item. Primary key for this association.',
    `cycle_count_id` BIGINT COMMENT 'Foreign key linking to the cycle count event that this line item belongs to.',
    `stock_position_id` BIGINT COMMENT 'Foreign key linking to the specific stock position (SKU/lot/location combination) being counted.',
    `adjustment_document_number` STRING COMMENT 'Reference to the goods movement document number generated when the variance adjustment was posted (SAP MIGO document).',
    `adjustment_posted_flag` BOOLEAN COMMENT 'Indicates whether the inventory adjustment for this line item variance has been posted to the general ledger.',
    `count_status` STRING COMMENT 'Current status of this specific line item within the cycle count: not_started, in_progress, counted, recounted, variance_approved, posted, cancelled.',
    `count_timestamp` TIMESTAMP COMMENT 'Timestamp when this specific stock position was physically counted by the warehouse worker.',
    `counted_quantity` DECIMAL(18,2) COMMENT 'The actual physical quantity counted by the warehouse worker during the cycle count event. May differ from system quantity.',
    `counter_employee_code` STRING COMMENT 'Employee ID of the warehouse worker who performed the physical count for this line item. May differ from the cycle count header if multiple counters are assigned.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this cycle count line item record was created in the system.',
    `cycle_count_date` DATE COMMENT 'Date of the most recent physical cycle count verification for this stock position. Used to track count frequency and accuracy. [Moved from stock_position: This attribute in stock_position represents the date of the most recent cycle count for this stock position. This is derivable from the cycle_count_item association (MAX(count_timestamp) where stock_position_id = X). It should not be denormalized on stock_position in a normalized model, as it creates update anomalies when new counts occur.]',
    `cycle_count_variance` DECIMAL(18,2) COMMENT 'Difference between system quantity and physical count quantity from the most recent cycle count. Positive indicates overage; negative indicates shortage. [Moved from stock_position: This attribute in stock_position represents the variance from the most recent cycle count. This is derivable from the cycle_count_item association (variance_quantity from the most recent count). It should not be denormalized on stock_position, as it creates update anomalies and loses historical variance tracking.]',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this cycle count line item record was last modified.',
    `line_item_notes` STRING COMMENT 'Free-text notes specific to this line item count, such as observed damage, location discrepancies, or count challenges.',
    `recount_flag` BOOLEAN COMMENT 'Indicates whether this specific line item required a recount due to variance exceeding threshold or count discrepancy.',
    `recount_timestamp` TIMESTAMP COMMENT 'Timestamp when this line item was recounted, if recount was required. Null if no recount performed.',
    `system_quantity` DECIMAL(18,2) COMMENT 'The quantity recorded in the system at the time the cycle count was initiated. Represents the book inventory before physical verification.',
    `unit_of_measure` STRING COMMENT 'Unit of measure for the quantities (EA, CS, LB, KG, etc.). Captured at count time to ensure consistency.',
    `variance_quantity` DECIMAL(18,2) COMMENT 'The difference between counted quantity and system quantity (counted minus system). Positive indicates overage, negative indicates shortage.',
    `variance_reason_code` STRING COMMENT 'Reason code for the variance identified during root cause analysis: shrinkage, damage, system_error, receiving_error, picking_error, etc.',
    CONSTRAINT pk_cycle_count_item PRIMARY KEY(`cycle_count_item_id`)
) COMMENT 'This association product represents the physical inventory count line item linking a cycle count event to a specific stock position. It captures the system quantity, counted quantity, variance, and count status for each SKU/lot counted during the cycle count event. Each record represents one stock position being counted as part of one cycle count, with attributes that exist only in the context of this specific count activity. Aligned with SAP MI01 Physical Inventory Document Item.. Existence Justification: In warehouse inventory operations, a cycle count event physically verifies multiple stock positions (SKU/lot/location combinations), and each stock position is counted across multiple cycle count events over time for continuous accuracy verification. The cycle count line item is a well-established operational business entity in SAP WM/EWM (Physical Inventory Document Item) that warehouse workers actively create during count execution, supervisors review for variance approval, and auditors query for compliance verification.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `food_beverage_ecm`.`inventory`.`stock_position` ADD CONSTRAINT `fk_inventory_stock_position_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `food_beverage_ecm`.`inventory`.`storage_location`(`storage_location_id`);
ALTER TABLE `food_beverage_ecm`.`inventory`.`goods_movement` ADD CONSTRAINT `fk_inventory_goods_movement_lot_trace_id` FOREIGN KEY (`lot_trace_id`) REFERENCES `food_beverage_ecm`.`inventory`.`lot_trace`(`lot_trace_id`);
ALTER TABLE `food_beverage_ecm`.`inventory`.`goods_movement` ADD CONSTRAINT `fk_inventory_goods_movement_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `food_beverage_ecm`.`inventory`.`storage_location`(`storage_location_id`);
ALTER TABLE `food_beverage_ecm`.`inventory`.`goods_movement` ADD CONSTRAINT `fk_inventory_goods_movement_stock_position_id` FOREIGN KEY (`stock_position_id`) REFERENCES `food_beverage_ecm`.`inventory`.`stock_position`(`stock_position_id`);
ALTER TABLE `food_beverage_ecm`.`inventory`.`goods_movement` ADD CONSTRAINT `fk_inventory_goods_movement_stock_transfer_order_id` FOREIGN KEY (`stock_transfer_order_id`) REFERENCES `food_beverage_ecm`.`inventory`.`stock_transfer_order`(`stock_transfer_order_id`);
ALTER TABLE `food_beverage_ecm`.`inventory`.`stock_transfer_order` ADD CONSTRAINT `fk_inventory_stock_transfer_order_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `food_beverage_ecm`.`inventory`.`storage_location`(`storage_location_id`);
ALTER TABLE `food_beverage_ecm`.`inventory`.`stock_transfer_order` ADD CONSTRAINT `fk_inventory_stock_transfer_order_lot_trace_id` FOREIGN KEY (`lot_trace_id`) REFERENCES `food_beverage_ecm`.`inventory`.`lot_trace`(`lot_trace_id`);
ALTER TABLE `food_beverage_ecm`.`inventory`.`stock_transfer_order` ADD CONSTRAINT `fk_inventory_stock_transfer_order_primary_stock_storage_location_id` FOREIGN KEY (`primary_stock_storage_location_id`) REFERENCES `food_beverage_ecm`.`inventory`.`storage_location`(`storage_location_id`);
ALTER TABLE `food_beverage_ecm`.`inventory`.`cycle_count` ADD CONSTRAINT `fk_inventory_cycle_count_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `food_beverage_ecm`.`inventory`.`storage_location`(`storage_location_id`);
ALTER TABLE `food_beverage_ecm`.`inventory`.`adjustment` ADD CONSTRAINT `fk_inventory_adjustment_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `food_beverage_ecm`.`inventory`.`storage_location`(`storage_location_id`);
ALTER TABLE `food_beverage_ecm`.`inventory`.`adjustment` ADD CONSTRAINT `fk_inventory_adjustment_adjustment_storage_location_id` FOREIGN KEY (`adjustment_storage_location_id`) REFERENCES `food_beverage_ecm`.`inventory`.`storage_location`(`storage_location_id`);
ALTER TABLE `food_beverage_ecm`.`inventory`.`adjustment` ADD CONSTRAINT `fk_inventory_adjustment_cycle_count_id` FOREIGN KEY (`cycle_count_id`) REFERENCES `food_beverage_ecm`.`inventory`.`cycle_count`(`cycle_count_id`);
ALTER TABLE `food_beverage_ecm`.`inventory`.`adjustment` ADD CONSTRAINT `fk_inventory_adjustment_goods_movement_id` FOREIGN KEY (`goods_movement_id`) REFERENCES `food_beverage_ecm`.`inventory`.`goods_movement`(`goods_movement_id`);
ALTER TABLE `food_beverage_ecm`.`inventory`.`adjustment` ADD CONSTRAINT `fk_inventory_adjustment_lot_trace_id` FOREIGN KEY (`lot_trace_id`) REFERENCES `food_beverage_ecm`.`inventory`.`lot_trace`(`lot_trace_id`);
ALTER TABLE `food_beverage_ecm`.`inventory`.`adjustment` ADD CONSTRAINT `fk_inventory_adjustment_stock_position_id` FOREIGN KEY (`stock_position_id`) REFERENCES `food_beverage_ecm`.`inventory`.`stock_position`(`stock_position_id`);
ALTER TABLE `food_beverage_ecm`.`inventory`.`valuation` ADD CONSTRAINT `fk_inventory_valuation_stock_position_id` FOREIGN KEY (`stock_position_id`) REFERENCES `food_beverage_ecm`.`inventory`.`stock_position`(`stock_position_id`);
ALTER TABLE `food_beverage_ecm`.`inventory`.`lot_trace` ADD CONSTRAINT `fk_inventory_lot_trace_stock_position_id` FOREIGN KEY (`stock_position_id`) REFERENCES `food_beverage_ecm`.`inventory`.`stock_position`(`stock_position_id`);
ALTER TABLE `food_beverage_ecm`.`inventory`.`lot_trace` ADD CONSTRAINT `fk_inventory_lot_trace_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `food_beverage_ecm`.`inventory`.`storage_location`(`storage_location_id`);
ALTER TABLE `food_beverage_ecm`.`inventory`.`quarantine_hold` ADD CONSTRAINT `fk_inventory_quarantine_hold_lot_trace_id` FOREIGN KEY (`lot_trace_id`) REFERENCES `food_beverage_ecm`.`inventory`.`lot_trace`(`lot_trace_id`);
ALTER TABLE `food_beverage_ecm`.`inventory`.`quarantine_hold` ADD CONSTRAINT `fk_inventory_quarantine_hold_stock_position_id` FOREIGN KEY (`stock_position_id`) REFERENCES `food_beverage_ecm`.`inventory`.`stock_position`(`stock_position_id`);
ALTER TABLE `food_beverage_ecm`.`inventory`.`quarantine_hold` ADD CONSTRAINT `fk_inventory_quarantine_hold_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `food_beverage_ecm`.`inventory`.`storage_location`(`storage_location_id`);
ALTER TABLE `food_beverage_ecm`.`inventory`.`reservation` ADD CONSTRAINT `fk_inventory_reservation_lot_trace_id` FOREIGN KEY (`lot_trace_id`) REFERENCES `food_beverage_ecm`.`inventory`.`lot_trace`(`lot_trace_id`);
ALTER TABLE `food_beverage_ecm`.`inventory`.`reservation` ADD CONSTRAINT `fk_inventory_reservation_stock_position_id` FOREIGN KEY (`stock_position_id`) REFERENCES `food_beverage_ecm`.`inventory`.`stock_position`(`stock_position_id`);
ALTER TABLE `food_beverage_ecm`.`inventory`.`reservation` ADD CONSTRAINT `fk_inventory_reservation_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `food_beverage_ecm`.`inventory`.`storage_location`(`storage_location_id`);
ALTER TABLE `food_beverage_ecm`.`inventory`.`cycle_count_item` ADD CONSTRAINT `fk_inventory_cycle_count_item_cycle_count_id` FOREIGN KEY (`cycle_count_id`) REFERENCES `food_beverage_ecm`.`inventory`.`cycle_count`(`cycle_count_id`);
ALTER TABLE `food_beverage_ecm`.`inventory`.`cycle_count_item` ADD CONSTRAINT `fk_inventory_cycle_count_item_stock_position_id` FOREIGN KEY (`stock_position_id`) REFERENCES `food_beverage_ecm`.`inventory`.`stock_position`(`stock_position_id`);

-- ========= TAGS =========
ALTER SCHEMA `food_beverage_ecm`.`inventory` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `food_beverage_ecm`.`inventory` SET TAGS ('dbx_domain' = 'inventory');
ALTER TABLE `food_beverage_ecm`.`inventory`.`stock_position` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `food_beverage_ecm`.`inventory`.`stock_position` SET TAGS ('dbx_subdomain' = 'stock_management');
ALTER TABLE `food_beverage_ecm`.`inventory`.`stock_position` ALTER COLUMN `stock_position_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Position ID');
ALTER TABLE `food_beverage_ecm`.`inventory`.`stock_position` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`inventory`.`stock_position` ALTER COLUMN `lot_id` SET TAGS ('dbx_business_glossary_term' = 'Lot ID');
ALTER TABLE `food_beverage_ecm`.`inventory`.`stock_position` ALTER COLUMN `po_line_id` SET TAGS ('dbx_business_glossary_term' = 'Po Line Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`inventory`.`stock_position` ALTER COLUMN `product_registration_id` SET TAGS ('dbx_business_glossary_term' = 'Product Registration Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`inventory`.`stock_position` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`inventory`.`stock_position` ALTER COLUMN `shelf_life_spec_id` SET TAGS ('dbx_business_glossary_term' = 'Shelf Life Spec Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`inventory`.`stock_position` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Material ID');
ALTER TABLE `food_beverage_ecm`.`inventory`.`stock_position` ALTER COLUMN `storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'Storage Location ID');
ALTER TABLE `food_beverage_ecm`.`inventory`.`stock_position` ALTER COLUMN `abc_classification` SET TAGS ('dbx_business_glossary_term' = 'ABC Classification');
ALTER TABLE `food_beverage_ecm`.`inventory`.`stock_position` ALTER COLUMN `abc_classification` SET TAGS ('dbx_value_regex' = 'A|B|C|X');
ALTER TABLE `food_beverage_ecm`.`inventory`.`stock_position` ALTER COLUMN `allergen_segregation_flag` SET TAGS ('dbx_business_glossary_term' = 'Allergen Segregation Flag');
ALTER TABLE `food_beverage_ecm`.`inventory`.`stock_position` ALTER COLUMN `best_before_date` SET TAGS ('dbx_business_glossary_term' = 'Best Before Date (BBD)');
ALTER TABLE `food_beverage_ecm`.`inventory`.`stock_position` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `food_beverage_ecm`.`inventory`.`stock_position` ALTER COLUMN `expiry_status` SET TAGS ('dbx_business_glossary_term' = 'Expiry Status');
ALTER TABLE `food_beverage_ecm`.`inventory`.`stock_position` ALTER COLUMN `expiry_status` SET TAGS ('dbx_value_regex' = 'valid|near_expiry|expired|no_expiry');
ALTER TABLE `food_beverage_ecm`.`inventory`.`stock_position` ALTER COLUMN `gtin` SET TAGS ('dbx_business_glossary_term' = 'Global Trade Item Number (GTIN)');
ALTER TABLE `food_beverage_ecm`.`inventory`.`stock_position` ALTER COLUMN `gtin` SET TAGS ('dbx_value_regex' = '^d{8,14}$');
ALTER TABLE `food_beverage_ecm`.`inventory`.`stock_position` ALTER COLUMN `hazmat_flag` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Material (HAZMAT) Flag');
ALTER TABLE `food_beverage_ecm`.`inventory`.`stock_position` ALTER COLUMN `last_movement_date` SET TAGS ('dbx_business_glossary_term' = 'Last Movement Date');
ALTER TABLE `food_beverage_ecm`.`inventory`.`stock_position` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `food_beverage_ecm`.`inventory`.`stock_position` ALTER COLUMN `lot_traceability_code` SET TAGS ('dbx_business_glossary_term' = 'Lot Traceability Code');
ALTER TABLE `food_beverage_ecm`.`inventory`.`stock_position` ALTER COLUMN `organic_certified_flag` SET TAGS ('dbx_business_glossary_term' = 'Organic Certified Flag');
ALTER TABLE `food_beverage_ecm`.`inventory`.`stock_position` ALTER COLUMN `production_date` SET TAGS ('dbx_business_glossary_term' = 'Production Date');
ALTER TABLE `food_beverage_ecm`.`inventory`.`stock_position` ALTER COLUMN `quantity_available` SET TAGS ('dbx_business_glossary_term' = 'Quantity Available');
ALTER TABLE `food_beverage_ecm`.`inventory`.`stock_position` ALTER COLUMN `quantity_blocked` SET TAGS ('dbx_business_glossary_term' = 'Quantity Blocked');
ALTER TABLE `food_beverage_ecm`.`inventory`.`stock_position` ALTER COLUMN `quantity_in_transit` SET TAGS ('dbx_business_glossary_term' = 'Quantity In Transit');
ALTER TABLE `food_beverage_ecm`.`inventory`.`stock_position` ALTER COLUMN `quantity_on_hand` SET TAGS ('dbx_business_glossary_term' = 'Quantity On Hand');
ALTER TABLE `food_beverage_ecm`.`inventory`.`stock_position` ALTER COLUMN `quantity_quality_inspection` SET TAGS ('dbx_business_glossary_term' = 'Quantity Quality Inspection');
ALTER TABLE `food_beverage_ecm`.`inventory`.`stock_position` ALTER COLUMN `quantity_reserved` SET TAGS ('dbx_business_glossary_term' = 'Quantity Reserved');
ALTER TABLE `food_beverage_ecm`.`inventory`.`stock_position` ALTER COLUMN `quarantine_flag` SET TAGS ('dbx_business_glossary_term' = 'Quarantine Flag');
ALTER TABLE `food_beverage_ecm`.`inventory`.`stock_position` ALTER COLUMN `recall_flag` SET TAGS ('dbx_business_glossary_term' = 'Recall Flag');
ALTER TABLE `food_beverage_ecm`.`inventory`.`stock_position` ALTER COLUMN `receipt_date` SET TAGS ('dbx_business_glossary_term' = 'Receipt Date');
ALTER TABLE `food_beverage_ecm`.`inventory`.`stock_position` ALTER COLUMN `remaining_shelf_life_days` SET TAGS ('dbx_business_glossary_term' = 'Remaining Shelf Life Days');
ALTER TABLE `food_beverage_ecm`.`inventory`.`stock_position` ALTER COLUMN `safety_stock_flag` SET TAGS ('dbx_business_glossary_term' = 'Safety Stock Flag');
ALTER TABLE `food_beverage_ecm`.`inventory`.`stock_position` ALTER COLUMN `shelf_life_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Shelf Life Expiration Date (SLED)');
ALTER TABLE `food_beverage_ecm`.`inventory`.`stock_position` ALTER COLUMN `special_stock_indicator` SET TAGS ('dbx_business_glossary_term' = 'Special Stock Indicator');
ALTER TABLE `food_beverage_ecm`.`inventory`.`stock_position` ALTER COLUMN `stock_age_days` SET TAGS ('dbx_business_glossary_term' = 'Stock Age Days');
ALTER TABLE `food_beverage_ecm`.`inventory`.`stock_position` ALTER COLUMN `stock_category` SET TAGS ('dbx_business_glossary_term' = 'Stock Category');
ALTER TABLE `food_beverage_ecm`.`inventory`.`stock_position` ALTER COLUMN `stock_category` SET TAGS ('dbx_value_regex' = 'on_hand|available|reserved|in_transit|quality_inspection|blocked');
ALTER TABLE `food_beverage_ecm`.`inventory`.`stock_position` ALTER COLUMN `temperature_zone` SET TAGS ('dbx_business_glossary_term' = 'Temperature Zone');
ALTER TABLE `food_beverage_ecm`.`inventory`.`stock_position` ALTER COLUMN `temperature_zone` SET TAGS ('dbx_value_regex' = 'ambient|refrigerated|frozen|controlled');
ALTER TABLE `food_beverage_ecm`.`inventory`.`stock_position` ALTER COLUMN `unit_cost` SET TAGS ('dbx_business_glossary_term' = 'Unit Cost');
ALTER TABLE `food_beverage_ecm`.`inventory`.`stock_position` ALTER COLUMN `unit_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`inventory`.`stock_position` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `food_beverage_ecm`.`inventory`.`stock_position` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,3}$');
ALTER TABLE `food_beverage_ecm`.`inventory`.`stock_position` ALTER COLUMN `valuation_amount` SET TAGS ('dbx_business_glossary_term' = 'Valuation Amount');
ALTER TABLE `food_beverage_ecm`.`inventory`.`stock_position` ALTER COLUMN `valuation_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`inventory`.`stock_position` ALTER COLUMN `valuation_currency` SET TAGS ('dbx_business_glossary_term' = 'Valuation Currency');
ALTER TABLE `food_beverage_ecm`.`inventory`.`stock_position` ALTER COLUMN `valuation_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `food_beverage_ecm`.`inventory`.`stock_position` ALTER COLUMN `vendor_lot_number` SET TAGS ('dbx_business_glossary_term' = 'Vendor Lot Number');
ALTER TABLE `food_beverage_ecm`.`inventory`.`storage_location` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `food_beverage_ecm`.`inventory`.`storage_location` SET TAGS ('dbx_subdomain' = 'stock_management');
ALTER TABLE `food_beverage_ecm`.`inventory`.`storage_location` ALTER COLUMN `storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'Storage Location ID');
ALTER TABLE `food_beverage_ecm`.`inventory`.`storage_location` ALTER COLUMN `center_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Center (DC) ID');
ALTER TABLE `food_beverage_ecm`.`inventory`.`storage_location` ALTER COLUMN `establishment_registration_id` SET TAGS ('dbx_business_glossary_term' = 'Establishment Registration Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`inventory`.`storage_location` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant ID');
ALTER TABLE `food_beverage_ecm`.`inventory`.`storage_location` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Third-Party Logistics (3PL) Provider ID');
ALTER TABLE `food_beverage_ecm`.`inventory`.`storage_location` ALTER COLUMN `supplier_site_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Site Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`inventory`.`storage_location` ALTER COLUMN `address_line1` SET TAGS ('dbx_business_glossary_term' = 'Address Line 1');
ALTER TABLE `food_beverage_ecm`.`inventory`.`storage_location` ALTER COLUMN `address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`inventory`.`storage_location` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `food_beverage_ecm`.`inventory`.`storage_location` ALTER COLUMN `address_line2` SET TAGS ('dbx_business_glossary_term' = 'Address Line 2');
ALTER TABLE `food_beverage_ecm`.`inventory`.`storage_location` ALTER COLUMN `address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`inventory`.`storage_location` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `food_beverage_ecm`.`inventory`.`storage_location` ALTER COLUMN `allergen_segregation_class` SET TAGS ('dbx_business_glossary_term' = 'Allergen Segregation Classification');
ALTER TABLE `food_beverage_ecm`.`inventory`.`storage_location` ALTER COLUMN `capacity_pallet_positions` SET TAGS ('dbx_business_glossary_term' = 'Pallet Position Capacity');
ALTER TABLE `food_beverage_ecm`.`inventory`.`storage_location` ALTER COLUMN `capacity_volume_m3` SET TAGS ('dbx_business_glossary_term' = 'Storage Capacity Volume (Cubic Meters)');
ALTER TABLE `food_beverage_ecm`.`inventory`.`storage_location` ALTER COLUMN `capacity_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Storage Capacity Weight (Kilograms)');
ALTER TABLE `food_beverage_ecm`.`inventory`.`storage_location` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `food_beverage_ecm`.`inventory`.`storage_location` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`inventory`.`storage_location` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `food_beverage_ecm`.`inventory`.`storage_location` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `food_beverage_ecm`.`inventory`.`storage_location` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `food_beverage_ecm`.`inventory`.`storage_location` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `food_beverage_ecm`.`inventory`.`storage_location` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `food_beverage_ecm`.`inventory`.`storage_location` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `food_beverage_ecm`.`inventory`.`storage_location` ALTER COLUMN `erp_storage_location` SET TAGS ('dbx_business_glossary_term' = 'Enterprise Resource Planning (ERP) Storage Location Code');
ALTER TABLE `food_beverage_ecm`.`inventory`.`storage_location` ALTER COLUMN `fefo_enforcement_flag` SET TAGS ('dbx_business_glossary_term' = 'First Expired First Out (FEFO) Enforcement Flag');
ALTER TABLE `food_beverage_ecm`.`inventory`.`storage_location` ALTER COLUMN `fifo_enforcement_flag` SET TAGS ('dbx_business_glossary_term' = 'First In First Out (FIFO) Enforcement Flag');
ALTER TABLE `food_beverage_ecm`.`inventory`.`storage_location` ALTER COLUMN `gmp_compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'Good Manufacturing Practice (GMP) Compliant Flag');
ALTER TABLE `food_beverage_ecm`.`inventory`.`storage_location` ALTER COLUMN `halal_certified_flag` SET TAGS ('dbx_business_glossary_term' = 'Halal Certified Flag');
ALTER TABLE `food_beverage_ecm`.`inventory`.`storage_location` ALTER COLUMN `hazmat_certified_flag` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Material (HAZMAT) Certified Flag');
ALTER TABLE `food_beverage_ecm`.`inventory`.`storage_location` ALTER COLUMN `kosher_certified_flag` SET TAGS ('dbx_business_glossary_term' = 'Kosher Certified Flag');
ALTER TABLE `food_beverage_ecm`.`inventory`.`storage_location` ALTER COLUMN `last_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Last Inspection Date');
ALTER TABLE `food_beverage_ecm`.`inventory`.`storage_location` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `food_beverage_ecm`.`inventory`.`storage_location` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude');
ALTER TABLE `food_beverage_ecm`.`inventory`.`storage_location` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `food_beverage_ecm`.`inventory`.`storage_location` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `food_beverage_ecm`.`inventory`.`storage_location` ALTER COLUMN `location_code` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Code');
ALTER TABLE `food_beverage_ecm`.`inventory`.`storage_location` ALTER COLUMN `location_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,12}$');
ALTER TABLE `food_beverage_ecm`.`inventory`.`storage_location` ALTER COLUMN `location_name` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Name');
ALTER TABLE `food_beverage_ecm`.`inventory`.`storage_location` ALTER COLUMN `location_type` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Type');
ALTER TABLE `food_beverage_ecm`.`inventory`.`storage_location` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude');
ALTER TABLE `food_beverage_ecm`.`inventory`.`storage_location` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `food_beverage_ecm`.`inventory`.`storage_location` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `food_beverage_ecm`.`inventory`.`storage_location` ALTER COLUMN `next_inspection_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Inspection Due Date');
ALTER TABLE `food_beverage_ecm`.`inventory`.`storage_location` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Notes');
ALTER TABLE `food_beverage_ecm`.`inventory`.`storage_location` ALTER COLUMN `operational_status` SET TAGS ('dbx_business_glossary_term' = 'Operational Status');
ALTER TABLE `food_beverage_ecm`.`inventory`.`storage_location` ALTER COLUMN `operational_status` SET TAGS ('dbx_value_regex' = 'active|inactive|maintenance|quarantine|decommissioned|planned');
ALTER TABLE `food_beverage_ecm`.`inventory`.`storage_location` ALTER COLUMN `organic_certified_flag` SET TAGS ('dbx_business_glossary_term' = 'Organic Certified Flag');
ALTER TABLE `food_beverage_ecm`.`inventory`.`storage_location` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `food_beverage_ecm`.`inventory`.`storage_location` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`inventory`.`storage_location` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `food_beverage_ecm`.`inventory`.`storage_location` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'State or Province');
ALTER TABLE `food_beverage_ecm`.`inventory`.`storage_location` ALTER COLUMN `state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`inventory`.`storage_location` ALTER COLUMN `state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `food_beverage_ecm`.`inventory`.`storage_location` ALTER COLUMN `temperature_max` SET TAGS ('dbx_business_glossary_term' = 'Maximum Temperature (Celsius)');
ALTER TABLE `food_beverage_ecm`.`inventory`.`storage_location` ALTER COLUMN `temperature_min` SET TAGS ('dbx_business_glossary_term' = 'Minimum Temperature (Celsius)');
ALTER TABLE `food_beverage_ecm`.`inventory`.`storage_location` ALTER COLUMN `temperature_zone` SET TAGS ('dbx_business_glossary_term' = 'Temperature Zone Classification');
ALTER TABLE `food_beverage_ecm`.`inventory`.`storage_location` ALTER COLUMN `temperature_zone` SET TAGS ('dbx_value_regex' = 'ambient|chilled|frozen|controlled');
ALTER TABLE `food_beverage_ecm`.`inventory`.`storage_location` ALTER COLUMN `wms_location_code` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Management System (WMS) Location Code');
ALTER TABLE `food_beverage_ecm`.`inventory`.`goods_movement` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `food_beverage_ecm`.`inventory`.`goods_movement` SET TAGS ('dbx_subdomain' = 'transaction_processing');
ALTER TABLE `food_beverage_ecm`.`inventory`.`goods_movement` ALTER COLUMN `goods_movement_id` SET TAGS ('dbx_business_glossary_term' = 'Goods Movement ID');
ALTER TABLE `food_beverage_ecm`.`inventory`.`goods_movement` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`inventory`.`goods_movement` ALTER COLUMN `fulfillment_order_id` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Order Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`inventory`.`goods_movement` ALTER COLUMN `lot_trace_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Trace Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`inventory`.`goods_movement` ALTER COLUMN `order_id` SET TAGS ('dbx_business_glossary_term' = 'Order Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`inventory`.`goods_movement` ALTER COLUMN `production_order_id` SET TAGS ('dbx_business_glossary_term' = 'Production Order Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`inventory`.`goods_movement` ALTER COLUMN `promotion_event_id` SET TAGS ('dbx_business_glossary_term' = 'Promotion Event Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`inventory`.`goods_movement` ALTER COLUMN `shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`inventory`.`goods_movement` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU)');
ALTER TABLE `food_beverage_ecm`.`inventory`.`goods_movement` ALTER COLUMN `storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'Source Storage Location Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`inventory`.`goods_movement` ALTER COLUMN `stock_position_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Position Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`inventory`.`goods_movement` ALTER COLUMN `stock_transfer_order_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Transfer Order Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`inventory`.`goods_movement` ALTER COLUMN `amount_lc` SET TAGS ('dbx_business_glossary_term' = 'Amount in Local Currency (LC)');
ALTER TABLE `food_beverage_ecm`.`inventory`.`goods_movement` ALTER COLUMN `amount_lc` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`inventory`.`goods_movement` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `food_beverage_ecm`.`inventory`.`goods_movement` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected');
ALTER TABLE `food_beverage_ecm`.`inventory`.`goods_movement` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `food_beverage_ecm`.`inventory`.`goods_movement` ALTER COLUMN `cost_center` SET TAGS ('dbx_business_glossary_term' = 'Cost Center');
ALTER TABLE `food_beverage_ecm`.`inventory`.`goods_movement` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `food_beverage_ecm`.`inventory`.`goods_movement` ALTER COLUMN `customer_code` SET TAGS ('dbx_business_glossary_term' = 'Customer Code');
ALTER TABLE `food_beverage_ecm`.`inventory`.`goods_movement` ALTER COLUMN `destination_plant_code` SET TAGS ('dbx_business_glossary_term' = 'Destination Plant Code');
ALTER TABLE `food_beverage_ecm`.`inventory`.`goods_movement` ALTER COLUMN `destination_storage_location` SET TAGS ('dbx_business_glossary_term' = 'Destination Storage Location');
ALTER TABLE `food_beverage_ecm`.`inventory`.`goods_movement` ALTER COLUMN `document_date` SET TAGS ('dbx_business_glossary_term' = 'Document Date');
ALTER TABLE `food_beverage_ecm`.`inventory`.`goods_movement` ALTER COLUMN `entry_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Entry Timestamp');
ALTER TABLE `food_beverage_ecm`.`inventory`.`goods_movement` ALTER COLUMN `gl_account` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account');
ALTER TABLE `food_beverage_ecm`.`inventory`.`goods_movement` ALTER COLUMN `material_description` SET TAGS ('dbx_business_glossary_term' = 'Material Description');
ALTER TABLE `food_beverage_ecm`.`inventory`.`goods_movement` ALTER COLUMN `material_document_item` SET TAGS ('dbx_business_glossary_term' = 'Material Document Item');
ALTER TABLE `food_beverage_ecm`.`inventory`.`goods_movement` ALTER COLUMN `material_document_number` SET TAGS ('dbx_business_glossary_term' = 'Material Document Number');
ALTER TABLE `food_beverage_ecm`.`inventory`.`goods_movement` ALTER COLUMN `material_document_number` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `food_beverage_ecm`.`inventory`.`goods_movement` ALTER COLUMN `material_document_year` SET TAGS ('dbx_business_glossary_term' = 'Material Document Year');
ALTER TABLE `food_beverage_ecm`.`inventory`.`goods_movement` ALTER COLUMN `movement_indicator` SET TAGS ('dbx_business_glossary_term' = 'Movement Indicator');
ALTER TABLE `food_beverage_ecm`.`inventory`.`goods_movement` ALTER COLUMN `movement_indicator` SET TAGS ('dbx_value_regex' = 'receipt|issue|transfer|adjustment|reversal|reclassification');
ALTER TABLE `food_beverage_ecm`.`inventory`.`goods_movement` ALTER COLUMN `movement_type` SET TAGS ('dbx_business_glossary_term' = 'Movement Type');
ALTER TABLE `food_beverage_ecm`.`inventory`.`goods_movement` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `food_beverage_ecm`.`inventory`.`goods_movement` ALTER COLUMN `plant_code` SET TAGS ('dbx_business_glossary_term' = 'Plant Code');
ALTER TABLE `food_beverage_ecm`.`inventory`.`goods_movement` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Date');
ALTER TABLE `food_beverage_ecm`.`inventory`.`goods_movement` ALTER COLUMN `profit_center` SET TAGS ('dbx_business_glossary_term' = 'Profit Center');
ALTER TABLE `food_beverage_ecm`.`inventory`.`goods_movement` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `food_beverage_ecm`.`inventory`.`goods_movement` ALTER COLUMN `reason_code` SET TAGS ('dbx_business_glossary_term' = 'Reason Code');
ALTER TABLE `food_beverage_ecm`.`inventory`.`goods_movement` ALTER COLUMN `reference_document_item` SET TAGS ('dbx_business_glossary_term' = 'Reference Document Item');
ALTER TABLE `food_beverage_ecm`.`inventory`.`goods_movement` ALTER COLUMN `reference_document_number` SET TAGS ('dbx_business_glossary_term' = 'Reference Document Number');
ALTER TABLE `food_beverage_ecm`.`inventory`.`goods_movement` ALTER COLUMN `reference_document_type` SET TAGS ('dbx_business_glossary_term' = 'Reference Document Type');
ALTER TABLE `food_beverage_ecm`.`inventory`.`goods_movement` ALTER COLUMN `reversal_indicator` SET TAGS ('dbx_business_glossary_term' = 'Reversal Indicator');
ALTER TABLE `food_beverage_ecm`.`inventory`.`goods_movement` ALTER COLUMN `reversed_document_number` SET TAGS ('dbx_business_glossary_term' = 'Reversed Document Number');
ALTER TABLE `food_beverage_ecm`.`inventory`.`goods_movement` ALTER COLUMN `reversed_document_year` SET TAGS ('dbx_business_glossary_term' = 'Reversed Document Year');
ALTER TABLE `food_beverage_ecm`.`inventory`.`goods_movement` ALTER COLUMN `source_plant_code` SET TAGS ('dbx_business_glossary_term' = 'Source Plant Code');
ALTER TABLE `food_beverage_ecm`.`inventory`.`goods_movement` ALTER COLUMN `stock_type` SET TAGS ('dbx_business_glossary_term' = 'Stock Type');
ALTER TABLE `food_beverage_ecm`.`inventory`.`goods_movement` ALTER COLUMN `stock_type` SET TAGS ('dbx_value_regex' = 'unrestricted|quality_inspection|blocked|restricted|returns');
ALTER TABLE `food_beverage_ecm`.`inventory`.`goods_movement` ALTER COLUMN `storage_location` SET TAGS ('dbx_business_glossary_term' = 'Storage Location');
ALTER TABLE `food_beverage_ecm`.`inventory`.`goods_movement` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UoM)');
ALTER TABLE `food_beverage_ecm`.`inventory`.`goods_movement` ALTER COLUMN `valuation_type` SET TAGS ('dbx_business_glossary_term' = 'Valuation Type');
ALTER TABLE `food_beverage_ecm`.`inventory`.`goods_movement` ALTER COLUMN `vendor_code` SET TAGS ('dbx_business_glossary_term' = 'Vendor Code');
ALTER TABLE `food_beverage_ecm`.`inventory`.`stock_transfer_order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `food_beverage_ecm`.`inventory`.`stock_transfer_order` SET TAGS ('dbx_subdomain' = 'transaction_processing');
ALTER TABLE `food_beverage_ecm`.`inventory`.`stock_transfer_order` ALTER COLUMN `stock_transfer_order_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Transfer Order ID');
ALTER TABLE `food_beverage_ecm`.`inventory`.`stock_transfer_order` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier ID');
ALTER TABLE `food_beverage_ecm`.`inventory`.`stock_transfer_order` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center ID');
ALTER TABLE `food_beverage_ecm`.`inventory`.`stock_transfer_order` ALTER COLUMN `storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'Destination Location ID');
ALTER TABLE `food_beverage_ecm`.`inventory`.`stock_transfer_order` ALTER COLUMN `lot_trace_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Trace Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`inventory`.`stock_transfer_order` ALTER COLUMN `order_id` SET TAGS ('dbx_business_glossary_term' = 'Order Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`inventory`.`stock_transfer_order` ALTER COLUMN `primary_stock_storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'Source Location ID');
ALTER TABLE `food_beverage_ecm`.`inventory`.`stock_transfer_order` ALTER COLUMN `shelf_life_spec_id` SET TAGS ('dbx_business_glossary_term' = 'Shelf Life Spec Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`inventory`.`stock_transfer_order` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Material ID');
ALTER TABLE `food_beverage_ecm`.`inventory`.`stock_transfer_order` ALTER COLUMN `actual_receipt_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Receipt Date');
ALTER TABLE `food_beverage_ecm`.`inventory`.`stock_transfer_order` ALTER COLUMN `actual_shipment_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Shipment Date');
ALTER TABLE `food_beverage_ecm`.`inventory`.`stock_transfer_order` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `food_beverage_ecm`.`inventory`.`stock_transfer_order` ALTER COLUMN `cancelled_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancelled Reason');
ALTER TABLE `food_beverage_ecm`.`inventory`.`stock_transfer_order` ALTER COLUMN `confirmed_quantity` SET TAGS ('dbx_business_glossary_term' = 'Confirmed Quantity');
ALTER TABLE `food_beverage_ecm`.`inventory`.`stock_transfer_order` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `food_beverage_ecm`.`inventory`.`stock_transfer_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `food_beverage_ecm`.`inventory`.`stock_transfer_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `food_beverage_ecm`.`inventory`.`stock_transfer_order` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `food_beverage_ecm`.`inventory`.`stock_transfer_order` ALTER COLUMN `maximum_temperature_c` SET TAGS ('dbx_business_glossary_term' = 'Maximum Temperature Celsius');
ALTER TABLE `food_beverage_ecm`.`inventory`.`stock_transfer_order` ALTER COLUMN `minimum_temperature_c` SET TAGS ('dbx_business_glossary_term' = 'Minimum Temperature Celsius');
ALTER TABLE `food_beverage_ecm`.`inventory`.`stock_transfer_order` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `food_beverage_ecm`.`inventory`.`stock_transfer_order` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Transfer Order Notes');
ALTER TABLE `food_beverage_ecm`.`inventory`.`stock_transfer_order` ALTER COLUMN `planned_transfer_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Transfer Date');
ALTER TABLE `food_beverage_ecm`.`inventory`.`stock_transfer_order` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Transfer Priority');
ALTER TABLE `food_beverage_ecm`.`inventory`.`stock_transfer_order` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'urgent|high|normal|low');
ALTER TABLE `food_beverage_ecm`.`inventory`.`stock_transfer_order` ALTER COLUMN `received_quantity` SET TAGS ('dbx_business_glossary_term' = 'Received Quantity');
ALTER TABLE `food_beverage_ecm`.`inventory`.`stock_transfer_order` ALTER COLUMN `requested_quantity` SET TAGS ('dbx_business_glossary_term' = 'Requested Quantity');
ALTER TABLE `food_beverage_ecm`.`inventory`.`stock_transfer_order` ALTER COLUMN `shelf_life_remaining_days` SET TAGS ('dbx_business_glossary_term' = 'Shelf Life Remaining Days');
ALTER TABLE `food_beverage_ecm`.`inventory`.`stock_transfer_order` ALTER COLUMN `shipment_number` SET TAGS ('dbx_business_glossary_term' = 'Shipment Number');
ALTER TABLE `food_beverage_ecm`.`inventory`.`stock_transfer_order` ALTER COLUMN `shipment_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `food_beverage_ecm`.`inventory`.`stock_transfer_order` ALTER COLUMN `special_handling_code` SET TAGS ('dbx_business_glossary_term' = 'Special Handling Code');
ALTER TABLE `food_beverage_ecm`.`inventory`.`stock_transfer_order` ALTER COLUMN `special_handling_code` SET TAGS ('dbx_value_regex' = 'fragile|hazmat|refrigerated|frozen|high_value|allergen_control');
ALTER TABLE `food_beverage_ecm`.`inventory`.`stock_transfer_order` ALTER COLUMN `stock_type` SET TAGS ('dbx_business_glossary_term' = 'Stock Type');
ALTER TABLE `food_beverage_ecm`.`inventory`.`stock_transfer_order` ALTER COLUMN `stock_type` SET TAGS ('dbx_value_regex' = 'unrestricted|quality_inspection|blocked|restricted');
ALTER TABLE `food_beverage_ecm`.`inventory`.`stock_transfer_order` ALTER COLUMN `temperature_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Temperature Compliance Flag');
ALTER TABLE `food_beverage_ecm`.`inventory`.`stock_transfer_order` ALTER COLUMN `temperature_controlled_flag` SET TAGS ('dbx_business_glossary_term' = 'Temperature Controlled Flag');
ALTER TABLE `food_beverage_ecm`.`inventory`.`stock_transfer_order` ALTER COLUMN `transfer_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Transfer Cost Amount');
ALTER TABLE `food_beverage_ecm`.`inventory`.`stock_transfer_order` ALTER COLUMN `transfer_order_number` SET TAGS ('dbx_business_glossary_term' = 'Transfer Order Number');
ALTER TABLE `food_beverage_ecm`.`inventory`.`stock_transfer_order` ALTER COLUMN `transfer_order_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `food_beverage_ecm`.`inventory`.`stock_transfer_order` ALTER COLUMN `transfer_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Transfer Reason Code');
ALTER TABLE `food_beverage_ecm`.`inventory`.`stock_transfer_order` ALTER COLUMN `transfer_reason_code` SET TAGS ('dbx_value_regex' = 'replenishment|rebalancing|quality_hold|recall|production_demand|customer_order');
ALTER TABLE `food_beverage_ecm`.`inventory`.`stock_transfer_order` ALTER COLUMN `transfer_status` SET TAGS ('dbx_business_glossary_term' = 'Transfer Status');
ALTER TABLE `food_beverage_ecm`.`inventory`.`stock_transfer_order` ALTER COLUMN `transfer_status` SET TAGS ('dbx_value_regex' = 'planned|released|in_transit|received|cancelled|partially_received');
ALTER TABLE `food_beverage_ecm`.`inventory`.`stock_transfer_order` ALTER COLUMN `transfer_type` SET TAGS ('dbx_business_glossary_term' = 'Transfer Type');
ALTER TABLE `food_beverage_ecm`.`inventory`.`stock_transfer_order` ALTER COLUMN `transfer_type` SET TAGS ('dbx_value_regex' = 'plant_to_plant|dc_to_dc|plant_to_dc|dc_to_plant|3pl_replenishment|internal_transfer');
ALTER TABLE `food_beverage_ecm`.`inventory`.`stock_transfer_order` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `food_beverage_ecm`.`inventory`.`cycle_count` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `food_beverage_ecm`.`inventory`.`cycle_count` SET TAGS ('dbx_subdomain' = 'quality_assurance');
ALTER TABLE `food_beverage_ecm`.`inventory`.`cycle_count` ALTER COLUMN `cycle_count_id` SET TAGS ('dbx_business_glossary_term' = 'Cycle Count ID');
ALTER TABLE `food_beverage_ecm`.`inventory`.`cycle_count` ALTER COLUMN `center_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Center (DC) ID');
ALTER TABLE `food_beverage_ecm`.`inventory`.`cycle_count` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`inventory`.`cycle_count` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant ID');
ALTER TABLE `food_beverage_ecm`.`inventory`.`cycle_count` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`inventory`.`cycle_count` ALTER COLUMN `storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`inventory`.`cycle_count` ALTER COLUMN `accuracy_percentage` SET TAGS ('dbx_business_glossary_term' = 'Inventory Accuracy Percentage');
ALTER TABLE `food_beverage_ecm`.`inventory`.`cycle_count` ALTER COLUMN `actual_count_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Count Date');
ALTER TABLE `food_beverage_ecm`.`inventory`.`cycle_count` ALTER COLUMN `audit_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Audit Completion Date');
ALTER TABLE `food_beverage_ecm`.`inventory`.`cycle_count` ALTER COLUMN `audit_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Audit Required Flag');
ALTER TABLE `food_beverage_ecm`.`inventory`.`cycle_count` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Cycle Count Comments');
ALTER TABLE `food_beverage_ecm`.`inventory`.`cycle_count` ALTER COLUMN `count_completion_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Count Completion Timestamp');
ALTER TABLE `food_beverage_ecm`.`inventory`.`cycle_count` ALTER COLUMN `count_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Count Duration Minutes');
ALTER TABLE `food_beverage_ecm`.`inventory`.`cycle_count` ALTER COLUMN `count_method` SET TAGS ('dbx_business_glossary_term' = 'Count Method');
ALTER TABLE `food_beverage_ecm`.`inventory`.`cycle_count` ALTER COLUMN `count_method` SET TAGS ('dbx_value_regex' = 'manual|barcode_scan|rfid|automated_system|blind_count|guided_count');
ALTER TABLE `food_beverage_ecm`.`inventory`.`cycle_count` ALTER COLUMN `count_plan_reference` SET TAGS ('dbx_business_glossary_term' = 'Count Plan Reference');
ALTER TABLE `food_beverage_ecm`.`inventory`.`cycle_count` ALTER COLUMN `count_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Count Start Timestamp');
ALTER TABLE `food_beverage_ecm`.`inventory`.`cycle_count` ALTER COLUMN `count_type` SET TAGS ('dbx_business_glossary_term' = 'Count Type');
ALTER TABLE `food_beverage_ecm`.`inventory`.`cycle_count` ALTER COLUMN `count_type` SET TAGS ('dbx_value_regex' = 'full_physical_inventory|cycle_count|spot_check|wall_to_wall|abc_cycle|perpetual_inventory');
ALTER TABLE `food_beverage_ecm`.`inventory`.`cycle_count` ALTER COLUMN `counter_assigned` SET TAGS ('dbx_business_glossary_term' = 'Counter Assigned');
ALTER TABLE `food_beverage_ecm`.`inventory`.`cycle_count` ALTER COLUMN `counter_assigned` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`inventory`.`cycle_count` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `food_beverage_ecm`.`inventory`.`cycle_count` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `food_beverage_ecm`.`inventory`.`cycle_count` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `food_beverage_ecm`.`inventory`.`cycle_count` ALTER COLUMN `cycle_count_status` SET TAGS ('dbx_business_glossary_term' = 'Cycle Count Status');
ALTER TABLE `food_beverage_ecm`.`inventory`.`cycle_count` ALTER COLUMN `cycle_count_status` SET TAGS ('dbx_value_regex' = 'planned|in_progress|completed|reconciled|cancelled|on_hold');
ALTER TABLE `food_beverage_ecm`.`inventory`.`cycle_count` ALTER COLUMN `freeze_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Freeze End Timestamp');
ALTER TABLE `food_beverage_ecm`.`inventory`.`cycle_count` ALTER COLUMN `freeze_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Freeze Start Timestamp');
ALTER TABLE `food_beverage_ecm`.`inventory`.`cycle_count` ALTER COLUMN `inventory_freeze_flag` SET TAGS ('dbx_business_glossary_term' = 'Inventory Freeze Flag');
ALTER TABLE `food_beverage_ecm`.`inventory`.`cycle_count` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `food_beverage_ecm`.`inventory`.`cycle_count` ALTER COLUMN `lot_traceability_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Lot Traceability Required Flag');
ALTER TABLE `food_beverage_ecm`.`inventory`.`cycle_count` ALTER COLUMN `physical_inventory_document_number` SET TAGS ('dbx_business_glossary_term' = 'Physical Inventory Document Number');
ALTER TABLE `food_beverage_ecm`.`inventory`.`cycle_count` ALTER COLUMN `physical_inventory_document_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{10,20}$');
ALTER TABLE `food_beverage_ecm`.`inventory`.`cycle_count` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Count Priority');
ALTER TABLE `food_beverage_ecm`.`inventory`.`cycle_count` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `food_beverage_ecm`.`inventory`.`cycle_count` ALTER COLUMN `reconciliation_date` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Date');
ALTER TABLE `food_beverage_ecm`.`inventory`.`cycle_count` ALTER COLUMN `reconciliation_notes` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Notes');
ALTER TABLE `food_beverage_ecm`.`inventory`.`cycle_count` ALTER COLUMN `recount_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Recount Completion Date');
ALTER TABLE `food_beverage_ecm`.`inventory`.`cycle_count` ALTER COLUMN `recount_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Recount Required Flag');
ALTER TABLE `food_beverage_ecm`.`inventory`.`cycle_count` ALTER COLUMN `scheduled_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Count Date');
ALTER TABLE `food_beverage_ecm`.`inventory`.`cycle_count` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `food_beverage_ecm`.`inventory`.`cycle_count` ALTER COLUMN `supervisor_assigned` SET TAGS ('dbx_business_glossary_term' = 'Supervisor Assigned');
ALTER TABLE `food_beverage_ecm`.`inventory`.`cycle_count` ALTER COLUMN `supervisor_assigned` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`inventory`.`cycle_count` ALTER COLUMN `total_items_counted` SET TAGS ('dbx_business_glossary_term' = 'Total Items Counted');
ALTER TABLE `food_beverage_ecm`.`inventory`.`cycle_count` ALTER COLUMN `total_variance_items` SET TAGS ('dbx_business_glossary_term' = 'Total Variance Items');
ALTER TABLE `food_beverage_ecm`.`inventory`.`cycle_count` ALTER COLUMN `total_variance_value` SET TAGS ('dbx_business_glossary_term' = 'Total Variance Value');
ALTER TABLE `food_beverage_ecm`.`inventory`.`cycle_count` ALTER COLUMN `total_variance_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`inventory`.`cycle_count` ALTER COLUMN `variance_threshold_percentage` SET TAGS ('dbx_business_glossary_term' = 'Variance Threshold Percentage');
ALTER TABLE `food_beverage_ecm`.`inventory`.`cycle_count` ALTER COLUMN `variance_threshold_quantity` SET TAGS ('dbx_business_glossary_term' = 'Variance Threshold Quantity');
ALTER TABLE `food_beverage_ecm`.`inventory`.`adjustment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `food_beverage_ecm`.`inventory`.`adjustment` SET TAGS ('dbx_subdomain' = 'transaction_processing');
ALTER TABLE `food_beverage_ecm`.`inventory`.`adjustment` ALTER COLUMN `adjustment_id` SET TAGS ('dbx_business_glossary_term' = 'Inventory Adjustment ID');
ALTER TABLE `food_beverage_ecm`.`inventory`.`adjustment` ALTER COLUMN `storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'Reclassification Target Location ID');
ALTER TABLE `food_beverage_ecm`.`inventory`.`adjustment` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Reclassification Target Material ID');
ALTER TABLE `food_beverage_ecm`.`inventory`.`adjustment` ALTER COLUMN `adjustment_sku_id` SET TAGS ('dbx_business_glossary_term' = 'Material ID');
ALTER TABLE `food_beverage_ecm`.`inventory`.`adjustment` ALTER COLUMN `adjustment_storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'Location ID');
ALTER TABLE `food_beverage_ecm`.`inventory`.`adjustment` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center ID');
ALTER TABLE `food_beverage_ecm`.`inventory`.`adjustment` ALTER COLUMN `cycle_count_id` SET TAGS ('dbx_business_glossary_term' = 'Cycle Count Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`inventory`.`adjustment` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`inventory`.`adjustment` ALTER COLUMN `goods_movement_id` SET TAGS ('dbx_business_glossary_term' = 'Goods Movement Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`inventory`.`adjustment` ALTER COLUMN `lot_trace_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Trace Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`inventory`.`adjustment` ALTER COLUMN `product_registration_id` SET TAGS ('dbx_business_glossary_term' = 'Product Registration Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`inventory`.`adjustment` ALTER COLUMN `production_order_id` SET TAGS ('dbx_business_glossary_term' = 'Production Order Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`inventory`.`adjustment` ALTER COLUMN `promotion_event_id` SET TAGS ('dbx_business_glossary_term' = 'Promotion Event Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`inventory`.`adjustment` ALTER COLUMN `stock_position_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Position Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`inventory`.`adjustment` ALTER COLUMN `accounting_document_number` SET TAGS ('dbx_business_glossary_term' = 'Accounting Document Number');
ALTER TABLE `food_beverage_ecm`.`inventory`.`adjustment` ALTER COLUMN `adjusted_quantity` SET TAGS ('dbx_business_glossary_term' = 'Adjusted Quantity');
ALTER TABLE `food_beverage_ecm`.`inventory`.`adjustment` ALTER COLUMN `adjusted_value_amount` SET TAGS ('dbx_business_glossary_term' = 'Adjusted Value Amount');
ALTER TABLE `food_beverage_ecm`.`inventory`.`adjustment` ALTER COLUMN `adjustment_number` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Number');
ALTER TABLE `food_beverage_ecm`.`inventory`.`adjustment` ALTER COLUMN `adjustment_status` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Status');
ALTER TABLE `food_beverage_ecm`.`inventory`.`adjustment` ALTER COLUMN `adjustment_status` SET TAGS ('dbx_value_regex' = 'draft|posted|approved|rejected');
ALTER TABLE `food_beverage_ecm`.`inventory`.`adjustment` ALTER COLUMN `adjustment_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Event Timestamp');
ALTER TABLE `food_beverage_ecm`.`inventory`.`adjustment` ALTER COLUMN `adjustment_type` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Type');
ALTER TABLE `food_beverage_ecm`.`inventory`.`adjustment` ALTER COLUMN `adjustment_type` SET TAGS ('dbx_value_regex' = 'write_off|write_up|scrap|quality_block|reclass');
ALTER TABLE `food_beverage_ecm`.`inventory`.`adjustment` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Approval Timestamp');
ALTER TABLE `food_beverage_ecm`.`inventory`.`adjustment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `food_beverage_ecm`.`inventory`.`adjustment` ALTER COLUMN `credit_account` SET TAGS ('dbx_business_glossary_term' = 'Credit Account');
ALTER TABLE `food_beverage_ecm`.`inventory`.`adjustment` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `food_beverage_ecm`.`inventory`.`adjustment` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `food_beverage_ecm`.`inventory`.`adjustment` ALTER COLUMN `debit_account` SET TAGS ('dbx_business_glossary_term' = 'Debit Account');
ALTER TABLE `food_beverage_ecm`.`inventory`.`adjustment` ALTER COLUMN `external_reference_code` SET TAGS ('dbx_business_glossary_term' = 'External Reference ID');
ALTER TABLE `food_beverage_ecm`.`inventory`.`adjustment` ALTER COLUMN `financial_impact_amount` SET TAGS ('dbx_business_glossary_term' = 'Financial Impact Amount');
ALTER TABLE `food_beverage_ecm`.`inventory`.`adjustment` ALTER COLUMN `inventory_valuation_method` SET TAGS ('dbx_business_glossary_term' = 'Inventory Valuation Method');
ALTER TABLE `food_beverage_ecm`.`inventory`.`adjustment` ALTER COLUMN `inventory_valuation_method` SET TAGS ('dbx_value_regex' = 'standard|moving_average|fifo|fefo');
ALTER TABLE `food_beverage_ecm`.`inventory`.`adjustment` ALTER COLUMN `is_manual_adjustment` SET TAGS ('dbx_business_glossary_term' = 'Manual Adjustment Indicator');
ALTER TABLE `food_beverage_ecm`.`inventory`.`adjustment` ALTER COLUMN `is_quality_hold` SET TAGS ('dbx_business_glossary_term' = 'Quality Hold Indicator');
ALTER TABLE `food_beverage_ecm`.`inventory`.`adjustment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Notes');
ALTER TABLE `food_beverage_ecm`.`inventory`.`adjustment` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Date');
ALTER TABLE `food_beverage_ecm`.`inventory`.`adjustment` ALTER COLUMN `quality_hold_reason` SET TAGS ('dbx_business_glossary_term' = 'Quality Hold Reason');
ALTER TABLE `food_beverage_ecm`.`inventory`.`adjustment` ALTER COLUMN `reason_category` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Reason Category');
ALTER TABLE `food_beverage_ecm`.`inventory`.`adjustment` ALTER COLUMN `reason_category` SET TAGS ('dbx_value_regex' = 'damage|theft|shrinkage|error|regulatory');
ALTER TABLE `food_beverage_ecm`.`inventory`.`adjustment` ALTER COLUMN `reason_code` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Reason Code');
ALTER TABLE `food_beverage_ecm`.`inventory`.`adjustment` ALTER COLUMN `reason_description` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Reason Description');
ALTER TABLE `food_beverage_ecm`.`inventory`.`adjustment` ALTER COLUMN `source_document_number` SET TAGS ('dbx_business_glossary_term' = 'Source Document Number');
ALTER TABLE `food_beverage_ecm`.`inventory`.`adjustment` ALTER COLUMN `source_document_type` SET TAGS ('dbx_business_glossary_term' = 'Source Document Type');
ALTER TABLE `food_beverage_ecm`.`inventory`.`adjustment` ALTER COLUMN `source_document_type` SET TAGS ('dbx_value_regex' = 'cycle_count|quality_inspection|manual_correction');
ALTER TABLE `food_beverage_ecm`.`inventory`.`adjustment` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Source System');
ALTER TABLE `food_beverage_ecm`.`inventory`.`adjustment` ALTER COLUMN `tax_implication_flag` SET TAGS ('dbx_business_glossary_term' = 'Tax Implication Flag');
ALTER TABLE `food_beverage_ecm`.`inventory`.`adjustment` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `food_beverage_ecm`.`inventory`.`adjustment` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'EA|KG|L|ML|BOX');
ALTER TABLE `food_beverage_ecm`.`inventory`.`adjustment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `food_beverage_ecm`.`inventory`.`valuation` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `food_beverage_ecm`.`inventory`.`valuation` SET TAGS ('dbx_subdomain' = 'stock_management');
ALTER TABLE `food_beverage_ecm`.`inventory`.`valuation` ALTER COLUMN `valuation_id` SET TAGS ('dbx_business_glossary_term' = 'Inventory Valuation ID');
ALTER TABLE `food_beverage_ecm`.`inventory`.`valuation` ALTER COLUMN `batch_record_id` SET TAGS ('dbx_business_glossary_term' = 'Batch Record Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`inventory`.`valuation` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`inventory`.`valuation` ALTER COLUMN `fiscal_period_id` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`inventory`.`valuation` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`inventory`.`valuation` ALTER COLUMN `cost_id` SET TAGS ('dbx_business_glossary_term' = 'Ingredient Cost Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`inventory`.`valuation` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant ID');
ALTER TABLE `food_beverage_ecm`.`inventory`.`valuation` ALTER COLUMN `product_registration_id` SET TAGS ('dbx_business_glossary_term' = 'Product Registration Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`inventory`.`valuation` ALTER COLUMN `product_standard_cost_id` SET TAGS ('dbx_business_glossary_term' = 'Product Standard Cost Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`inventory`.`valuation` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Material ID');
ALTER TABLE `food_beverage_ecm`.`inventory`.`valuation` ALTER COLUMN `stock_position_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Position Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`inventory`.`valuation` ALTER COLUMN `adjustment_amount` SET TAGS ('dbx_business_glossary_term' = 'Valuation Adjustment Amount');
ALTER TABLE `food_beverage_ecm`.`inventory`.`valuation` ALTER COLUMN `class_code` SET TAGS ('dbx_business_glossary_term' = 'Valuation Class Code');
ALTER TABLE `food_beverage_ecm`.`inventory`.`valuation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `food_beverage_ecm`.`inventory`.`valuation` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `food_beverage_ecm`.`inventory`.`valuation` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `food_beverage_ecm`.`inventory`.`valuation` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `food_beverage_ecm`.`inventory`.`valuation` ALTER COLUMN `gross_valuation_amount` SET TAGS ('dbx_business_glossary_term' = 'Gross Valuation Amount');
ALTER TABLE `food_beverage_ecm`.`inventory`.`valuation` ALTER COLUMN `lot_number` SET TAGS ('dbx_business_glossary_term' = 'Lot Number');
ALTER TABLE `food_beverage_ecm`.`inventory`.`valuation` ALTER COLUMN `material_description` SET TAGS ('dbx_business_glossary_term' = 'Material Description');
ALTER TABLE `food_beverage_ecm`.`inventory`.`valuation` ALTER COLUMN `material_number` SET TAGS ('dbx_business_glossary_term' = 'Material Number (SKU)');
ALTER TABLE `food_beverage_ecm`.`inventory`.`valuation` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modification Timestamp');
ALTER TABLE `food_beverage_ecm`.`inventory`.`valuation` ALTER COLUMN `net_valuation_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Valuation Amount');
ALTER TABLE `food_beverage_ecm`.`inventory`.`valuation` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `food_beverage_ecm`.`inventory`.`valuation` ALTER COLUMN `price_variance_amount` SET TAGS ('dbx_business_glossary_term' = 'Price Variance Amount');
ALTER TABLE `food_beverage_ecm`.`inventory`.`valuation` ALTER COLUMN `quantity_on_hand` SET TAGS ('dbx_business_glossary_term' = 'Quantity On Hand');
ALTER TABLE `food_beverage_ecm`.`inventory`.`valuation` ALTER COLUMN `revaluation_amount` SET TAGS ('dbx_business_glossary_term' = 'Revaluation Amount');
ALTER TABLE `food_beverage_ecm`.`inventory`.`valuation` ALTER COLUMN `shelf_life_remaining_days` SET TAGS ('dbx_business_glossary_term' = 'Shelf Life Remaining (Days)');
ALTER TABLE `food_beverage_ecm`.`inventory`.`valuation` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `food_beverage_ecm`.`inventory`.`valuation` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'SAP WM|Oracle ERP|JDE');
ALTER TABLE `food_beverage_ecm`.`inventory`.`valuation` ALTER COLUMN `unit_cost` SET TAGS ('dbx_business_glossary_term' = 'Unit Cost');
ALTER TABLE `food_beverage_ecm`.`inventory`.`valuation` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `food_beverage_ecm`.`inventory`.`valuation` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'KG|L|EA|CASE');
ALTER TABLE `food_beverage_ecm`.`inventory`.`valuation` ALTER COLUMN `valuation_method` SET TAGS ('dbx_business_glossary_term' = 'Valuation Method');
ALTER TABLE `food_beverage_ecm`.`inventory`.`valuation` ALTER COLUMN `valuation_method` SET TAGS ('dbx_value_regex' = 'standard|moving_average|fifo|lifo');
ALTER TABLE `food_beverage_ecm`.`inventory`.`valuation` ALTER COLUMN `valuation_number` SET TAGS ('dbx_business_glossary_term' = 'Valuation Number');
ALTER TABLE `food_beverage_ecm`.`inventory`.`valuation` ALTER COLUMN `valuation_status` SET TAGS ('dbx_business_glossary_term' = 'Valuation Status');
ALTER TABLE `food_beverage_ecm`.`inventory`.`valuation` ALTER COLUMN `valuation_status` SET TAGS ('dbx_value_regex' = 'pending|posted|reversed|cancelled');
ALTER TABLE `food_beverage_ecm`.`inventory`.`valuation` ALTER COLUMN `valuation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Valuation Timestamp');
ALTER TABLE `food_beverage_ecm`.`inventory`.`lot_trace` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `food_beverage_ecm`.`inventory`.`lot_trace` SET TAGS ('dbx_subdomain' = 'quality_assurance');
ALTER TABLE `food_beverage_ecm`.`inventory`.`lot_trace` ALTER COLUMN `lot_trace_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Traceability ID');
ALTER TABLE `food_beverage_ecm`.`inventory`.`lot_trace` ALTER COLUMN `approved_supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Approved Supplier Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`inventory`.`lot_trace` ALTER COLUMN `bill_of_materials_id` SET TAGS ('dbx_business_glossary_term' = 'Bill Of Materials Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`inventory`.`lot_trace` ALTER COLUMN `food_safety_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Food Safety Plan Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`inventory`.`lot_trace` ALTER COLUMN `formulation_id` SET TAGS ('dbx_business_glossary_term' = 'Formulation Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`inventory`.`lot_trace` ALTER COLUMN `lot_id` SET TAGS ('dbx_business_glossary_term' = 'Ingredient Lot Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`inventory`.`lot_trace` ALTER COLUMN `inspection_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Lot Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`inventory`.`lot_trace` ALTER COLUMN `product_registration_id` SET TAGS ('dbx_business_glossary_term' = 'Product Registration Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`inventory`.`lot_trace` ALTER COLUMN `production_order_id` SET TAGS ('dbx_business_glossary_term' = 'Production Order Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`inventory`.`lot_trace` ALTER COLUMN `recall_event_id` SET TAGS ('dbx_business_glossary_term' = 'Recall Event Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`inventory`.`lot_trace` ALTER COLUMN `shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`inventory`.`lot_trace` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Product SKU (Stock Keeping Unit)');
ALTER TABLE `food_beverage_ecm`.`inventory`.`lot_trace` ALTER COLUMN `stock_position_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Position Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`inventory`.`lot_trace` ALTER COLUMN `storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'Location ID');
ALTER TABLE `food_beverage_ecm`.`inventory`.`lot_trace` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `food_beverage_ecm`.`inventory`.`lot_trace` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending');
ALTER TABLE `food_beverage_ecm`.`inventory`.`lot_trace` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `food_beverage_ecm`.`inventory`.`lot_trace` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|EUR|GBP|JPY|CAD|AUD');
ALTER TABLE `food_beverage_ecm`.`inventory`.`lot_trace` ALTER COLUMN `downstream_lot_refs` SET TAGS ('dbx_business_glossary_term' = 'Downstream Lot References');
ALTER TABLE `food_beverage_ecm`.`inventory`.`lot_trace` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `food_beverage_ecm`.`inventory`.`lot_trace` ALTER COLUMN `fsma_one_up_one_down_flag` SET TAGS ('dbx_business_glossary_term' = 'FSMA One‑Up/One‑Down Flag');
ALTER TABLE `food_beverage_ecm`.`inventory`.`lot_trace` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `food_beverage_ecm`.`inventory`.`lot_trace` ALTER COLUMN `lot_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Lot Cost Amount');
ALTER TABLE `food_beverage_ecm`.`inventory`.`lot_trace` ALTER COLUMN `lot_creation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Lot Creation Timestamp');
ALTER TABLE `food_beverage_ecm`.`inventory`.`lot_trace` ALTER COLUMN `lot_owner` SET TAGS ('dbx_business_glossary_term' = 'Lot Owner');
ALTER TABLE `food_beverage_ecm`.`inventory`.`lot_trace` ALTER COLUMN `lot_status` SET TAGS ('dbx_business_glossary_term' = 'Lot Status');
ALTER TABLE `food_beverage_ecm`.`inventory`.`lot_trace` ALTER COLUMN `lot_status` SET TAGS ('dbx_value_regex' = 'in_stock|allocated|shipped|consumed|quarantined|recalled');
ALTER TABLE `food_beverage_ecm`.`inventory`.`lot_trace` ALTER COLUMN `lot_type` SET TAGS ('dbx_business_glossary_term' = 'Lot Type');
ALTER TABLE `food_beverage_ecm`.`inventory`.`lot_trace` ALTER COLUMN `lot_type` SET TAGS ('dbx_value_regex' = 'raw_material|intermediate|finished_goods|packaging');
ALTER TABLE `food_beverage_ecm`.`inventory`.`lot_trace` ALTER COLUMN `max_temperature_c` SET TAGS ('dbx_business_glossary_term' = 'Maximum Temperature (°C)');
ALTER TABLE `food_beverage_ecm`.`inventory`.`lot_trace` ALTER COLUMN `min_temperature_c` SET TAGS ('dbx_business_glossary_term' = 'Minimum Temperature (°C)');
ALTER TABLE `food_beverage_ecm`.`inventory`.`lot_trace` ALTER COLUMN `plant_code` SET TAGS ('dbx_business_glossary_term' = 'Plant Code');
ALTER TABLE `food_beverage_ecm`.`inventory`.`lot_trace` ALTER COLUMN `product_name` SET TAGS ('dbx_business_glossary_term' = 'Product Name');
ALTER TABLE `food_beverage_ecm`.`inventory`.`lot_trace` ALTER COLUMN `production_date` SET TAGS ('dbx_business_glossary_term' = 'Production Date');
ALTER TABLE `food_beverage_ecm`.`inventory`.`lot_trace` ALTER COLUMN `quality_status` SET TAGS ('dbx_business_glossary_term' = 'Quality Status');
ALTER TABLE `food_beverage_ecm`.`inventory`.`lot_trace` ALTER COLUMN `quality_status` SET TAGS ('dbx_value_regex' = 'passed|failed|pending|rework');
ALTER TABLE `food_beverage_ecm`.`inventory`.`lot_trace` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Lot Quantity');
ALTER TABLE `food_beverage_ecm`.`inventory`.`lot_trace` ALTER COLUMN `recall_flag` SET TAGS ('dbx_business_glossary_term' = 'Recall Flag');
ALTER TABLE `food_beverage_ecm`.`inventory`.`lot_trace` ALTER COLUMN `receipt_date` SET TAGS ('dbx_business_glossary_term' = 'Receipt Date');
ALTER TABLE `food_beverage_ecm`.`inventory`.`lot_trace` ALTER COLUMN `shelf_life_days` SET TAGS ('dbx_business_glossary_term' = 'Shelf Life (Days)');
ALTER TABLE `food_beverage_ecm`.`inventory`.`lot_trace` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `food_beverage_ecm`.`inventory`.`lot_trace` ALTER COLUMN `temperature_controlled_flag` SET TAGS ('dbx_business_glossary_term' = 'Temperature Controlled Flag');
ALTER TABLE `food_beverage_ecm`.`inventory`.`lot_trace` ALTER COLUMN `traceability_status` SET TAGS ('dbx_business_glossary_term' = 'Traceability Status');
ALTER TABLE `food_beverage_ecm`.`inventory`.`lot_trace` ALTER COLUMN `traceability_status` SET TAGS ('dbx_value_regex' = 'one_up_one_down|one_up_many_down|many_up_one_down|none');
ALTER TABLE `food_beverage_ecm`.`inventory`.`lot_trace` ALTER COLUMN `transformation_event_code` SET TAGS ('dbx_business_glossary_term' = 'Transformation Event ID');
ALTER TABLE `food_beverage_ecm`.`inventory`.`lot_trace` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `food_beverage_ecm`.`inventory`.`lot_trace` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'kg|lb|unit|liter|gallon');
ALTER TABLE `food_beverage_ecm`.`inventory`.`lot_trace` ALTER COLUMN `upstream_lot_refs` SET TAGS ('dbx_business_glossary_term' = 'Upstream Lot References');
ALTER TABLE `food_beverage_ecm`.`inventory`.`quarantine_hold` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `food_beverage_ecm`.`inventory`.`quarantine_hold` SET TAGS ('dbx_subdomain' = 'quality_assurance');
ALTER TABLE `food_beverage_ecm`.`inventory`.`quarantine_hold` ALTER COLUMN `quarantine_hold_id` SET TAGS ('dbx_business_glossary_term' = 'Quarantine Hold Identifier');
ALTER TABLE `food_beverage_ecm`.`inventory`.`quarantine_hold` ALTER COLUMN `allergen_id` SET TAGS ('dbx_business_glossary_term' = 'Allergen Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`inventory`.`quarantine_hold` ALTER COLUMN `batch_record_id` SET TAGS ('dbx_business_glossary_term' = 'Batch Record Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`inventory`.`quarantine_hold` ALTER COLUMN `center_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Center Identifier');
ALTER TABLE `food_beverage_ecm`.`inventory`.`quarantine_hold` ALTER COLUMN `cold_chain_event_id` SET TAGS ('dbx_business_glossary_term' = 'Cold Chain Event Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`inventory`.`quarantine_hold` ALTER COLUMN `company_code_id` SET TAGS ('dbx_business_glossary_term' = 'Company Code Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`inventory`.`quarantine_hold` ALTER COLUMN `food_safety_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Food Safety Plan Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`inventory`.`quarantine_hold` ALTER COLUMN `lot_trace_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Trace Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`inventory`.`quarantine_hold` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant Identifier');
ALTER TABLE `food_beverage_ecm`.`inventory`.`quarantine_hold` ALTER COLUMN `raw_material_id` SET TAGS ('dbx_business_glossary_term' = 'Material Identifier');
ALTER TABLE `food_beverage_ecm`.`inventory`.`quarantine_hold` ALTER COLUMN `recall_event_id` SET TAGS ('dbx_business_glossary_term' = 'Recall Event Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`inventory`.`quarantine_hold` ALTER COLUMN `shelf_life_spec_id` SET TAGS ('dbx_business_glossary_term' = 'Shelf Life Spec Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`inventory`.`quarantine_hold` ALTER COLUMN `shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`inventory`.`quarantine_hold` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`inventory`.`quarantine_hold` ALTER COLUMN `stock_position_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Position Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`inventory`.`quarantine_hold` ALTER COLUMN `storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`inventory`.`quarantine_hold` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Identifier');
ALTER TABLE `food_beverage_ecm`.`inventory`.`quarantine_hold` ALTER COLUMN `test_result_id` SET TAGS ('dbx_business_glossary_term' = 'Test Result Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`inventory`.`quarantine_hold` ALTER COLUMN `allergen_flag` SET TAGS ('dbx_business_glossary_term' = 'Allergen Flag');
ALTER TABLE `food_beverage_ecm`.`inventory`.`quarantine_hold` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `food_beverage_ecm`.`inventory`.`quarantine_hold` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `food_beverage_ecm`.`inventory`.`quarantine_hold` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending');
ALTER TABLE `food_beverage_ecm`.`inventory`.`quarantine_hold` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `food_beverage_ecm`.`inventory`.`quarantine_hold` ALTER COLUMN `disposition_decision` SET TAGS ('dbx_business_glossary_term' = 'Disposition Decision');
ALTER TABLE `food_beverage_ecm`.`inventory`.`quarantine_hold` ALTER COLUMN `disposition_decision` SET TAGS ('dbx_value_regex' = 'release|rework|destroy|return_to_supplier');
ALTER TABLE `food_beverage_ecm`.`inventory`.`quarantine_hold` ALTER COLUMN `expected_review_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Expected Review Timestamp');
ALTER TABLE `food_beverage_ecm`.`inventory`.`quarantine_hold` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Lot Expiration Date');
ALTER TABLE `food_beverage_ecm`.`inventory`.`quarantine_hold` ALTER COLUMN `hold_initiation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Hold Initiation Timestamp');
ALTER TABLE `food_beverage_ecm`.`inventory`.`quarantine_hold` ALTER COLUMN `hold_number` SET TAGS ('dbx_business_glossary_term' = 'Quarantine Hold Number');
ALTER TABLE `food_beverage_ecm`.`inventory`.`quarantine_hold` ALTER COLUMN `hold_reason` SET TAGS ('dbx_business_glossary_term' = 'Quarantine Hold Reason');
ALTER TABLE `food_beverage_ecm`.`inventory`.`quarantine_hold` ALTER COLUMN `hold_release_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Hold Release Timestamp');
ALTER TABLE `food_beverage_ecm`.`inventory`.`quarantine_hold` ALTER COLUMN `hold_source_system` SET TAGS ('dbx_business_glossary_term' = 'Hold Source System');
ALTER TABLE `food_beverage_ecm`.`inventory`.`quarantine_hold` ALTER COLUMN `hold_status` SET TAGS ('dbx_business_glossary_term' = 'Quarantine Hold Status');
ALTER TABLE `food_beverage_ecm`.`inventory`.`quarantine_hold` ALTER COLUMN `hold_status` SET TAGS ('dbx_value_regex' = 'active|released|reworked|destroyed|returned');
ALTER TABLE `food_beverage_ecm`.`inventory`.`quarantine_hold` ALTER COLUMN `hold_type` SET TAGS ('dbx_business_glossary_term' = 'Quarantine Hold Type');
ALTER TABLE `food_beverage_ecm`.`inventory`.`quarantine_hold` ALTER COLUMN `hold_type` SET TAGS ('dbx_value_regex' = 'quality_inspection|regulatory|allergen|recall|supplier_deviation');
ALTER TABLE `food_beverage_ecm`.`inventory`.`quarantine_hold` ALTER COLUMN `is_critical_item` SET TAGS ('dbx_business_glossary_term' = 'Critical Item Flag');
ALTER TABLE `food_beverage_ecm`.`inventory`.`quarantine_hold` ALTER COLUMN `material_number` SET TAGS ('dbx_business_glossary_term' = 'Material Number');
ALTER TABLE `food_beverage_ecm`.`inventory`.`quarantine_hold` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modification Timestamp');
ALTER TABLE `food_beverage_ecm`.`inventory`.`quarantine_hold` ALTER COLUMN `quantity_held` SET TAGS ('dbx_business_glossary_term' = 'Quantity Held');
ALTER TABLE `food_beverage_ecm`.`inventory`.`quarantine_hold` ALTER COLUMN `recall_flag` SET TAGS ('dbx_business_glossary_term' = 'Recall Flag');
ALTER TABLE `food_beverage_ecm`.`inventory`.`quarantine_hold` ALTER COLUMN `regulatory_lot_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Lot Status');
ALTER TABLE `food_beverage_ecm`.`inventory`.`quarantine_hold` ALTER COLUMN `regulatory_lot_status` SET TAGS ('dbx_value_regex' = 'approved|restricted|under_review');
ALTER TABLE `food_beverage_ecm`.`inventory`.`quarantine_hold` ALTER COLUMN `regulatory_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reference');
ALTER TABLE `food_beverage_ecm`.`inventory`.`quarantine_hold` ALTER COLUMN `shelf_life_remaining_days` SET TAGS ('dbx_business_glossary_term' = 'Shelf Life Remaining (Days)');
ALTER TABLE `food_beverage_ecm`.`inventory`.`quarantine_hold` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `food_beverage_ecm`.`inventory`.`reservation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `food_beverage_ecm`.`inventory`.`reservation` SET TAGS ('dbx_subdomain' = 'transaction_processing');
ALTER TABLE `food_beverage_ecm`.`inventory`.`reservation` ALTER COLUMN `reservation_id` SET TAGS ('dbx_business_glossary_term' = 'Reservation Identifier');
ALTER TABLE `food_beverage_ecm`.`inventory`.`reservation` ALTER COLUMN `center_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Center Identifier (DISTRIBUTION_CENTER_ID)');
ALTER TABLE `food_beverage_ecm`.`inventory`.`reservation` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Identifier (COST_CENTER_ID)');
ALTER TABLE `food_beverage_ecm`.`inventory`.`reservation` ALTER COLUMN `fulfillment_order_id` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Order Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`inventory`.`reservation` ALTER COLUMN `lot_trace_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Trace Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`inventory`.`reservation` ALTER COLUMN `order_id` SET TAGS ('dbx_business_glossary_term' = 'Order Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`inventory`.`reservation` ALTER COLUMN `production_order_id` SET TAGS ('dbx_business_glossary_term' = 'Production Order Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`inventory`.`reservation` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`inventory`.`reservation` ALTER COLUMN `raw_material_id` SET TAGS ('dbx_business_glossary_term' = 'Material Identifier (MATERIAL_ID)');
ALTER TABLE `food_beverage_ecm`.`inventory`.`reservation` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Sku Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`inventory`.`reservation` ALTER COLUMN `stock_position_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Position Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`inventory`.`reservation` ALTER COLUMN `storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'Location Identifier (LOCATION_ID)');
ALTER TABLE `food_beverage_ecm`.`inventory`.`reservation` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp (APPROVED_TIMESTAMP)');
ALTER TABLE `food_beverage_ecm`.`inventory`.`reservation` ALTER COLUMN `cancelled_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason (CANCELLED_REASON)');
ALTER TABLE `food_beverage_ecm`.`inventory`.`reservation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (CREATED_TIMESTAMP)');
ALTER TABLE `food_beverage_ecm`.`inventory`.`reservation` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (CURRENCY_CODE)');
ALTER TABLE `food_beverage_ecm`.`inventory`.`reservation` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date (EXPIRATION_DATE)');
ALTER TABLE `food_beverage_ecm`.`inventory`.`reservation` ALTER COLUMN `freeze_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Freeze End Timestamp (FREEZE_END_TIMESTAMP)');
ALTER TABLE `food_beverage_ecm`.`inventory`.`reservation` ALTER COLUMN `freeze_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Freeze Start Timestamp (FREEZE_START_TIMESTAMP)');
ALTER TABLE `food_beverage_ecm`.`inventory`.`reservation` ALTER COLUMN `fulfillment_status` SET TAGS ('dbx_business_glossary_term' = 'Fulfillment Status (FULFILLMENT_STATUS)');
ALTER TABLE `food_beverage_ecm`.`inventory`.`reservation` ALTER COLUMN `fulfillment_status` SET TAGS ('dbx_value_regex' = 'pending|partial|complete|released');
ALTER TABLE `food_beverage_ecm`.`inventory`.`reservation` ALTER COLUMN `is_frozen` SET TAGS ('dbx_business_glossary_term' = 'Inventory Freeze Flag (IS_FROZEN)');
ALTER TABLE `food_beverage_ecm`.`inventory`.`reservation` ALTER COLUMN `is_quality_hold` SET TAGS ('dbx_business_glossary_term' = 'Quality Hold Flag (IS_QUALITY_HOLD)');
ALTER TABLE `food_beverage_ecm`.`inventory`.`reservation` ALTER COLUMN `is_temperature_controlled` SET TAGS ('dbx_business_glossary_term' = 'Temperature Controlled Flag (IS_TEMPERATURE_CONTROLLED)');
ALTER TABLE `food_beverage_ecm`.`inventory`.`reservation` ALTER COLUMN `max_temperature_c` SET TAGS ('dbx_business_glossary_term' = 'Maximum Temperature (°C) (MAX_TEMPERATURE_C)');
ALTER TABLE `food_beverage_ecm`.`inventory`.`reservation` ALTER COLUMN `min_temperature_c` SET TAGS ('dbx_business_glossary_term' = 'Minimum Temperature (°C) (MIN_TEMPERATURE_C)');
ALTER TABLE `food_beverage_ecm`.`inventory`.`reservation` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modification Timestamp (MODIFIED_TIMESTAMP)');
ALTER TABLE `food_beverage_ecm`.`inventory`.`reservation` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Reservation Notes (NOTES)');
ALTER TABLE `food_beverage_ecm`.`inventory`.`reservation` ALTER COLUMN `plant_code` SET TAGS ('dbx_business_glossary_term' = 'Plant Code (PLANT_CODE)');
ALTER TABLE `food_beverage_ecm`.`inventory`.`reservation` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Reservation Priority (PRIORITY)');
ALTER TABLE `food_beverage_ecm`.`inventory`.`reservation` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `food_beverage_ecm`.`inventory`.`reservation` ALTER COLUMN `quality_hold_reason` SET TAGS ('dbx_business_glossary_term' = 'Quality Hold Reason (QUALITY_HOLD_REASON)');
ALTER TABLE `food_beverage_ecm`.`inventory`.`reservation` ALTER COLUMN `requesting_party_code` SET TAGS ('dbx_business_glossary_term' = 'Requesting Party Identifier (REQUESTING_PARTY_ID)');
ALTER TABLE `food_beverage_ecm`.`inventory`.`reservation` ALTER COLUMN `requirement_date` SET TAGS ('dbx_business_glossary_term' = 'Requirement Date (REQUIREMENT_DATE)');
ALTER TABLE `food_beverage_ecm`.`inventory`.`reservation` ALTER COLUMN `reservation_number` SET TAGS ('dbx_business_glossary_term' = 'Reservation Number (RESERVATION_NUMBER)');
ALTER TABLE `food_beverage_ecm`.`inventory`.`reservation` ALTER COLUMN `reservation_source` SET TAGS ('dbx_business_glossary_term' = 'Reservation Source (RESERVATION_SOURCE)');
ALTER TABLE `food_beverage_ecm`.`inventory`.`reservation` ALTER COLUMN `reservation_source` SET TAGS ('dbx_value_regex' = 'system|manual|api');
ALTER TABLE `food_beverage_ecm`.`inventory`.`reservation` ALTER COLUMN `reservation_status` SET TAGS ('dbx_business_glossary_term' = 'Reservation Status (STATUS)');
ALTER TABLE `food_beverage_ecm`.`inventory`.`reservation` ALTER COLUMN `reservation_status` SET TAGS ('dbx_value_regex' = 'draft|open|allocated|fulfilled|cancelled|expired');
ALTER TABLE `food_beverage_ecm`.`inventory`.`reservation` ALTER COLUMN `reservation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Reservation Event Timestamp (RESERVATION_TIMESTAMP)');
ALTER TABLE `food_beverage_ecm`.`inventory`.`reservation` ALTER COLUMN `reservation_type` SET TAGS ('dbx_business_glossary_term' = 'Reservation Type (RESERVATION_TYPE)');
ALTER TABLE `food_beverage_ecm`.`inventory`.`reservation` ALTER COLUMN `reservation_type` SET TAGS ('dbx_value_regex' = 'production|sales|promotion|maintenance|transfer');
ALTER TABLE `food_beverage_ecm`.`inventory`.`reservation` ALTER COLUMN `reserved_quantity` SET TAGS ('dbx_business_glossary_term' = 'Reserved Quantity (RESERVED_QUANTITY)');
ALTER TABLE `food_beverage_ecm`.`inventory`.`reservation` ALTER COLUMN `reserved_value_amount` SET TAGS ('dbx_business_glossary_term' = 'Reserved Value Amount (RESERVED_VALUE_AMOUNT)');
ALTER TABLE `food_beverage_ecm`.`inventory`.`reservation` ALTER COLUMN `shelf_life_remaining_days` SET TAGS ('dbx_business_glossary_term' = 'Shelf Life Remaining (SHELF_LIFE_REMAINING_DAYS)');
ALTER TABLE `food_beverage_ecm`.`inventory`.`reservation` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System (SOURCE_SYSTEM)');
ALTER TABLE `food_beverage_ecm`.`inventory`.`reservation` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `food_beverage_ecm`.`inventory`.`cycle_count_item` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `food_beverage_ecm`.`inventory`.`cycle_count_item` SET TAGS ('dbx_subdomain' = 'quality_assurance');
ALTER TABLE `food_beverage_ecm`.`inventory`.`cycle_count_item` SET TAGS ('dbx_association_edges' = 'inventory.cycle_count,inventory.stock_position');
ALTER TABLE `food_beverage_ecm`.`inventory`.`cycle_count_item` ALTER COLUMN `cycle_count_item_id` SET TAGS ('dbx_business_glossary_term' = 'Cycle Count Item ID');
ALTER TABLE `food_beverage_ecm`.`inventory`.`cycle_count_item` ALTER COLUMN `cycle_count_id` SET TAGS ('dbx_business_glossary_term' = 'Cycle Count Item - Cycle Count Id');
ALTER TABLE `food_beverage_ecm`.`inventory`.`cycle_count_item` ALTER COLUMN `stock_position_id` SET TAGS ('dbx_business_glossary_term' = 'Cycle Count Item - Stock Position Id');
ALTER TABLE `food_beverage_ecm`.`inventory`.`cycle_count_item` ALTER COLUMN `adjustment_document_number` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Document Number');
ALTER TABLE `food_beverage_ecm`.`inventory`.`cycle_count_item` ALTER COLUMN `adjustment_posted_flag` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Posted Flag');
ALTER TABLE `food_beverage_ecm`.`inventory`.`cycle_count_item` ALTER COLUMN `count_status` SET TAGS ('dbx_business_glossary_term' = 'Count Status');
ALTER TABLE `food_beverage_ecm`.`inventory`.`cycle_count_item` ALTER COLUMN `count_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Count Timestamp');
ALTER TABLE `food_beverage_ecm`.`inventory`.`cycle_count_item` ALTER COLUMN `counted_quantity` SET TAGS ('dbx_business_glossary_term' = 'Counted Quantity');
ALTER TABLE `food_beverage_ecm`.`inventory`.`cycle_count_item` ALTER COLUMN `counter_employee_code` SET TAGS ('dbx_business_glossary_term' = 'Counter Employee ID');
ALTER TABLE `food_beverage_ecm`.`inventory`.`cycle_count_item` ALTER COLUMN `counter_employee_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`inventory`.`cycle_count_item` ALTER COLUMN `counter_employee_code` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `food_beverage_ecm`.`inventory`.`cycle_count_item` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `food_beverage_ecm`.`inventory`.`cycle_count_item` ALTER COLUMN `cycle_count_date` SET TAGS ('dbx_business_glossary_term' = 'Cycle Count Date');
ALTER TABLE `food_beverage_ecm`.`inventory`.`cycle_count_item` ALTER COLUMN `cycle_count_variance` SET TAGS ('dbx_business_glossary_term' = 'Cycle Count Variance');
ALTER TABLE `food_beverage_ecm`.`inventory`.`cycle_count_item` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `food_beverage_ecm`.`inventory`.`cycle_count_item` ALTER COLUMN `line_item_notes` SET TAGS ('dbx_business_glossary_term' = 'Line Item Notes');
ALTER TABLE `food_beverage_ecm`.`inventory`.`cycle_count_item` ALTER COLUMN `recount_flag` SET TAGS ('dbx_business_glossary_term' = 'Recount Flag');
ALTER TABLE `food_beverage_ecm`.`inventory`.`cycle_count_item` ALTER COLUMN `recount_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Recount Timestamp');
ALTER TABLE `food_beverage_ecm`.`inventory`.`cycle_count_item` ALTER COLUMN `system_quantity` SET TAGS ('dbx_business_glossary_term' = 'System Quantity');
ALTER TABLE `food_beverage_ecm`.`inventory`.`cycle_count_item` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `food_beverage_ecm`.`inventory`.`cycle_count_item` ALTER COLUMN `variance_quantity` SET TAGS ('dbx_business_glossary_term' = 'Variance Quantity');
ALTER TABLE `food_beverage_ecm`.`inventory`.`cycle_count_item` ALTER COLUMN `variance_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Variance Reason Code');
