-- Schema for Domain: inventory | Business: Food Beverage | Version: v1_ecm
-- Generated on: 2026-05-05 21:26:23

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `food_beverage_ecm`.`inventory` COMMENT 'Single source of truth for all finished goods, WIP, and raw material stock positions across plants, DCs, and 3PL locations. Manages lot traceability, FEFO/FIFO lot management, shelf life monitoring, stock aging, inventory valuation, and cycle count reconciliation aligned with SAP WM/EWM.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `food_beverage_ecm`.`inventory`.`stock_position` (
    `stock_position_id` BIGINT COMMENT 'Unique identifier for the stock position record. Primary key for the stock position entity.',
    `lot_id` BIGINT COMMENT 'Reference to the production or procurement lot/batch number for traceability and FEFO/FIFO management.',
    `packaging_profile_id` BIGINT COMMENT 'Foreign key linking to sustainability.packaging_profile. Business justification: Packaging Sustainability reports require linking inventory items to their packaging profile to calculate recyclability and carbon impact per SKU.',
    `po_line_id` BIGINT COMMENT 'Foreign key linking to procurement.po_line. Business justification: REQUIRED: Stock aging and cost allocation reports must trace each inventory lot back to its originating purchase order line for financial and quality audits.',
    `price_list_line_id` BIGINT COMMENT 'Foreign key linking to pricing.price_list_line. Business justification: Inventory valuation report uses the price list line applied at receipt to calculate valuation per SKU, a standard accounting process.',
    `product_registration_id` BIGINT COMMENT 'Foreign key linking to regulatory.product_registration. Business justification: Regulatory compliance reports require each stock position to be linked to its product registration for traceability and recall eligibility.',
    `rd_project_id` BIGINT COMMENT 'Foreign key linking to research.rd_project. Business justification: R&D material reservation: stock positions are allocated to specific R&D projects to track raw material usage for experiments.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Required for Stock Audit Responsibility Report; assigns a custodian employee to each stock position for accountability.',
    `sku_id` BIGINT COMMENT 'Reference to the material master record (finished goods, WIP, or raw material SKU) for which stock is held.',
    `storage_location_id` BIGINT COMMENT 'Reference to the physical storage location (plant, DC, 3PL warehouse, or specific bin/zone) where the stock is held.',
    `abc_classification` STRING COMMENT 'Inventory classification based on value and velocity. A items are high-value/high-velocity requiring frequent monitoring; B items are moderate; C items are low-value/low-velocity; X items are obsolete or non-moving.. Valid values are `A|B|C|X`',
    `allergen_segregation_flag` BOOLEAN COMMENT 'Indicates whether the stock contains major allergens and requires physical segregation to prevent cross-contamination.',
    `best_before_date` DATE COMMENT 'Date until which the product maintains optimal quality characteristics. May differ from expiration date for shelf-stable products.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this stock position record was first created in the system.',
    `cycle_count_date` DATE COMMENT 'Date of the most recent physical cycle count verification for this stock position. Used to track count frequency and accuracy.',
    `cycle_count_variance` DECIMAL(18,2) COMMENT 'Difference between system quantity and physical count quantity from the most recent cycle count. Positive indicates overage; negative indicates shortage.',
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
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Needed for Location Management & Safety Inspection process; links each storage location to its overseeing manager employee.',
    `plant_id` BIGINT COMMENT 'Reference to the manufacturing plant or facility that owns or operates this storage location.',
    `price_zone_id` BIGINT COMMENT 'Foreign key linking to pricing.price_zone. Business justification: Location‑based pricing zones determine which price list applies to inventory stored at each location, used in regional pricing compliance.',
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
    `employee_id` BIGINT COMMENT 'The user ID of the person who approved the movement. Nullable if approval is not required or still pending.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: COST ACCOUNTING: Material movements must be allocated to a cost center for internal cost of goods sold reporting; finance cost_center is the natural target.',
    `order_id` BIGINT COMMENT 'Foreign key linking to sales.order. Business justification: Goods movement records shipments that satisfy a sales order; the FK ties the movement to the originating order for shipping and financial reporting.',
    `price_list_line_id` BIGINT COMMENT 'Foreign key linking to pricing.price_list_line. Business justification: Goods movement posting requires the price list line for material valuation and cost of goods sold, required by finance reporting.',
    `primary_goods_employee_id` BIGINT COMMENT 'The system user ID of the person who posted the goods movement. Used for audit trail and accountability.',
    `promotion_event_id` BIGINT COMMENT 'Foreign key linking to trade.promotion_event. Business justification: Movement of promotional goods must be tied to the promotion event for traceability and cost allocation.',
    `sku_id` BIGINT COMMENT 'The unique product identifier for the material being moved. References the master product catalog. Also known as material number in SAP.',
    `stock_position_id` BIGINT COMMENT 'Foreign key linking to inventory.stock_position. Business justification: Goods movement records affect a specific stock position (location + SKU + lot). Adding stock_position_id creates a clear parent‑child link and removes the need for separate location/SKU columns if des',
    `amount_lc` DECIMAL(18,2) COMMENT 'The financial value of the movement in the local currency of the plant. Calculated as quantity × standard cost or moving average price. Positive for receipts, negative for issues. Used for COGS posting and inventory valuation.',
    `approval_status` STRING COMMENT 'Workflow approval status for movements requiring authorization (e.g., write-offs above threshold, manual adjustments). Pending indicates awaiting approval, approved indicates cleared for posting, rejected indicates denied.. Valid values are `pending|approved|rejected`',
    `approval_timestamp` TIMESTAMP COMMENT 'The timestamp when the movement was approved. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX. Nullable if approval is not required or still pending.',
    `batch_number` STRING COMMENT 'The lot or batch identifier for the material being moved. Critical for traceability, FEFO/FIFO lot management, shelf life monitoring, and recall execution. Nullable for non-batch-managed materials.',
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
    `source_storage_location` STRING COMMENT 'For transfer movements, the storage location from which the material is being moved. Nullable for non-transfer movements.',
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
    `order_id` BIGINT COMMENT 'Foreign key linking to sales.order. Business justification: Transfer orders are often generated to replenish stock for a specific sales order; linking provides traceability from order demand to internal transfer.',
    `employee_id` BIGINT COMMENT 'User identifier of the person or system that created this transfer order. Used for audit trail and accountability.',
    `primary_stock_storage_location_id` BIGINT COMMENT 'Identifier of the originating location from which stock is being transferred. May reference plant, distribution center, or third-party logistics (3PL) facility.',
    `rd_project_id` BIGINT COMMENT 'Foreign key linking to research.rd_project. Business justification: Transfer orders moving materials to R&D labs are tied to a project; this FK supports the Material Transfer to R&D operational workflow.',
    `sku_id` BIGINT COMMENT 'Identifier of the material, finished good, work-in-progress (WIP), or raw material being transferred. Links to product master data.',
    `tertiary_stock_approved_by_user_employee_id` BIGINT COMMENT 'User identifier of the person who approved this transfer order for execution. Required for high-value or cross-region transfers.',
    `transfer_price_id` BIGINT COMMENT 'Foreign key linking to pricing.transfer_price. Business justification: Inter‑plant transfer orders are priced using a transfer price record for cost allocation and profitability analysis.',
    `actual_receipt_date` DATE COMMENT 'Actual date when stock was received at the destination location. Captured at goods receipt posting.',
    `actual_shipment_date` DATE COMMENT 'Actual date when stock was shipped from the source location. Captured at goods issue posting.',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when this transfer order was approved for execution. Marks transition from planned to released status.',
    `cancelled_reason` STRING COMMENT 'Free-text explanation for why this transfer order was cancelled. Used for root cause analysis and process improvement.',
    `confirmed_quantity` DECIMAL(18,2) COMMENT 'Actual quantity confirmed for transfer after picking and verification. May differ from requested quantity due to availability or quality issues.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this transfer order record was first created in the system. Used for audit trail and lifecycle tracking.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this transfer order.. Valid values are `^[A-Z]{3}$`',
    `expiration_date` DATE COMMENT 'Product expiration or best-by date for the lot being transferred. Used for shelf life monitoring and FEFO lot selection.',
    `lot_number` STRING COMMENT 'Manufacturing lot or batch number for traceability. Critical for FEFO/FIFO lot management, recall management, and food safety compliance.. Valid values are `^[A-Z0-9]{6,20}$`',
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
    `sku` STRING COMMENT 'Stock Keeping Unit code identifying the specific product variant being transferred. Used for inventory tracking and warehouse operations.. Valid values are `^[A-Z0-9-]{6,20}$`',
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
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Cycle Count Counter Assignment report requires identifying the employee performing the count; creates clear accountability.',
    `plant_id` BIGINT COMMENT 'Manufacturing plant or production facility where the cycle count is performed.',
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
    `storage_location_code` STRING COMMENT 'Specific storage location code within the plant or DC where inventory is counted. Aligns with SAP WM storage location.. Valid values are `^[A-Z0-9]{4,10}$`',
    `supervisor_assigned` STRING COMMENT 'Name or employee ID of the supervisor responsible for overseeing and validating the cycle count.',
    `total_items_counted` STRING COMMENT 'Total number of distinct SKUs or line items included in this cycle count event.',
    `total_variance_items` STRING COMMENT 'Number of items where physical count differed from book inventory, exceeding the variance threshold.',
    `total_variance_value` DECIMAL(18,2) COMMENT 'Total financial value of inventory variances identified during the cycle count, calculated using standard cost or moving average price.',
    `variance_threshold_percentage` DECIMAL(18,2) COMMENT 'Acceptable variance threshold as a percentage of book quantity before a recount or investigation is triggered.',
    `variance_threshold_quantity` DECIMAL(18,2) COMMENT 'Acceptable variance threshold in quantity units before a recount or investigation is triggered. Set based on item value and criticality.',
    CONSTRAINT pk_cycle_count PRIMARY KEY(`cycle_count_id`)
) COMMENT 'Master record for scheduled and ad-hoc physical inventory cycle count events at a storage location. Captures count plan reference, count type (full physical inventory, cycle count, spot check), scheduled date, actual count date, counter assigned, count status (planned, in-progress, completed, reconciled), and variance threshold. Aligned with SAP MI01/MI04 Physical Inventory Document. Supports continuous inventory accuracy programs and audit compliance.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`inventory`.`cycle_count_line` (
    `cycle_count_line_id` BIGINT COMMENT 'Unique identifier for the line record within a cycle count event.',
    `cycle_count_id` BIGINT COMMENT 'Identifier of the parent cycle count header to which this line belongs.',
    `employee_id` BIGINT COMMENT 'Identifier of the employee or user who performed the count.',
    `adjustment_reason` STRING COMMENT 'Free‑text explanation for the adjustment made.',
    `adjustment_type` STRING COMMENT 'Type of inventory adjustment applied to resolve the variance.. Valid values are `increase|decrease|none`',
    `compliance_status` STRING COMMENT 'Indicates whether the lot complies with quality and regulatory standards.. Valid values are `compliant|non_compliant|pending`',
    `count_timestamp` TIMESTAMP COMMENT 'Date and time when the physical count was performed.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the line record was created in the system.',
    `cycle_count_status` STRING COMMENT 'Current processing status of the cycle count line.. Valid values are `open|closed|pending|reconciled`',
    `expiration_date` DATE COMMENT 'Date when the lot expires or reaches the end of its shelf life.',
    `final_quantity` DECIMAL(18,2) COMMENT 'Quantity after adjustments and reconciliation.',
    `inventory_valuation_method` STRING COMMENT 'Method used to value inventory for this line (e.g., FIFO, FEFO).. Valid values are `FIFO|FEFO|LIFO|Average`',
    `is_critical_item` BOOLEAN COMMENT 'True if the item is high‑value, regulated, or otherwise critical to business operations.',
    `line_number` STRING COMMENT 'Sequential number of the line within the cycle count document.',
    `lot_number` STRING COMMENT 'Lot or batch identifier for traceability (FEFO/FIFO management).',
    `material_description` STRING COMMENT 'Human‑readable description of the material or SKU.',
    `material_number` STRING COMMENT 'Business identifier of the stocked material or SKU being counted.',
    `notes` STRING COMMENT 'Optional free‑text comments or observations captured by the counter.',
    `plant_code` STRING COMMENT 'Identifier of the manufacturing plant or production site.',
    `quantity_book` DECIMAL(18,2) COMMENT 'Quantity recorded in the system (booked) for the material/lot.',
    `quantity_counted` DECIMAL(18,2) COMMENT 'Quantity physically counted during the cycle count.',
    `quantity_variance` DECIMAL(18,2) COMMENT 'Difference between counted quantity and book quantity (counted – book).',
    `recount_flag` BOOLEAN COMMENT 'Indicates whether a recount is required for this line (true = recount needed).',
    `regulatory_lot_status` STRING COMMENT 'Regulatory state of the lot (e.g., released for sale, quarantined).. Valid values are `released|quarantined|pending|recalled`',
    `storage_bin` STRING COMMENT 'Code of the storage bin or location where the material is stored.',
    `unit_cost` DECIMAL(18,2) COMMENT 'Standard cost per unit of the material for valuation purposes.',
    `unit_of_measure` STRING COMMENT 'Measurement unit for the quantity (e.g., each, kilogram).. Valid values are `EA|KG|L|ML|BOX`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the line record.',
    `variance_percentage` DECIMAL(18,2) COMMENT 'Percentage variance calculated as (quantity_variance / quantity_book) * 100.',
    `variance_reason_code` STRING COMMENT 'Standard code indicating why a variance occurred.. Valid values are `damage|shrink|misplacement|theft|adjustment|other`',
    `warehouse_code` STRING COMMENT 'Identifier of the distribution center, DC, or 3PL location.',
    CONSTRAINT pk_cycle_count_line PRIMARY KEY(`cycle_count_line_id`)
) COMMENT 'Line-level detail for each SKU/lot counted within a cycle count event. Captures the material/SKU, storage bin, lot number, system book quantity, physically counted quantity, variance quantity, variance percentage, variance reason code, recount flag, and final reconciled quantity. Supports root-cause analysis of inventory discrepancies and drives adjustment postings. Aligned with SAP MI04/MI07 Physical Inventory Count and Difference.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`inventory`.`adjustment` (
    `adjustment_id` BIGINT COMMENT 'System-generated unique identifier for the inventory adjustment record.',
    `employee_id` BIGINT COMMENT 'Identifier of the user who created the adjustment record.',
    `adjustment_employee_id` BIGINT COMMENT 'Identifier of the user who approved the adjustment.',
    `storage_location_id` BIGINT COMMENT 'Destination location identifier for inventory reclassification adjustments.',
    `sku_id` BIGINT COMMENT 'Destination material (SKU) identifier for reclassification adjustments.',
    `adjustment_sku_id` BIGINT COMMENT 'Identifier of the material (SKU) being adjusted.',
    `adjustment_storage_location_id` BIGINT COMMENT 'Warehouse, distribution center, or 3PL location where the adjustment took place.',
    `cost_center_id` BIGINT COMMENT 'Cost center associated with the financial impact of the adjustment.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: ACCOUNTING ENTRY: Adjustments (e.g., write‑offs, reclass) require a GL account for journal posting; finance.gl_account provides the required account.',
    `price_list_id` BIGINT COMMENT 'Foreign key linking to pricing.price_list. Business justification: Adjustment entries reference the price list used for re‑valuation of adjusted inventory, required for audit trails and financial statements.',
    `product_registration_id` BIGINT COMMENT 'Foreign key linking to regulatory.product_registration. Business justification: Inventory adjustments affect quantities of registered products; regulators require linkage for accurate reporting of stock changes.',
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
    `expiration_date` DATE COMMENT 'Calendar date when the adjusted inventory item expires.',
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
    `shelf_life_remaining_days` STRING COMMENT 'Number of days remaining before the product expires at the time of adjustment.',
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
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: FINANCIAL REPORTING: Inventory valuation adjustments are posted to a GL account; linking to finance.gl_account enables accurate balance‑sheet entries.',
    `plant_id` BIGINT COMMENT 'Identifier of the manufacturing plant or distribution center where the inventory is located.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Valuation Preparation Report mandates the employee who performed the valuation for compliance and audit purposes.',
    `product_registration_id` BIGINT COMMENT 'Foreign key linking to regulatory.product_registration. Business justification: Valuation statements submitted to regulators must identify the product registration associated with each valuation record.',
    `sku_id` BIGINT COMMENT 'Unique identifier of the material (SKU) being valued.',
    `adjustment_amount` DECIMAL(18,2) COMMENT 'Monetary adjustments applied during valuation (e.g., price variance, revaluation).',
    `batch_number` STRING COMMENT 'Batch identifier used for traceability of the material.',
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
    `employee_id` BIGINT COMMENT 'System user that initially created the lot traceability record.',
    `inspection_lot_id` BIGINT COMMENT 'Foreign key linking to quality.inspection_lot. Business justification: Traceability reports attach inspection outcomes to each lot; the link enables downstream quality status calculations.',
    `product_registration_id` BIGINT COMMENT 'Foreign key linking to regulatory.product_registration. Business justification: Lot traceability reports must reference the product registration to ensure labeling, safety, and regulatory compliance of each lot.',
    `rd_project_id` BIGINT COMMENT 'Foreign key linking to research.rd_project. Business justification: Lot traceability records which R&D project used a specific lot, required for compliance and audit of experimental batches.',
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
    `center_id` BIGINT COMMENT 'Identifier of the distribution center (DC) where the inventory is stored.',
    `raw_material_id` BIGINT COMMENT 'Internal identifier of the material (SKU/GTIN) that is on hold.',
    `plant_id` BIGINT COMMENT 'Identifier of the manufacturing plant owning the inventory.',
    `employee_id` BIGINT COMMENT 'Identifier of the quality manager who authorized or reviewed the hold.',
    `recall_event_id` BIGINT COMMENT 'Foreign key linking to regulatory.recall_event. Business justification: Quarantine holds are often triggered by recall events; linking enables the recall management process to track affected inventory.',
    `stock_position_id` BIGINT COMMENT 'Foreign key linking to inventory.stock_position. Business justification: Quarantine hold is applied to a specific stock position; linking provides the exact inventory record under hold.',
    `supplier_id` BIGINT COMMENT 'Identifier of the supplier associated with the material, used when the hold originates from supplier deviation.',
    `tertiary_quarantine_modified_by_user_employee_id` BIGINT COMMENT 'Identifier of the user who last modified the hold record.',
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
    `storage_location_code` STRING COMMENT 'Code of the warehouse or storage bin where the held inventory resides.',
    `unit_of_measure` STRING COMMENT 'Measurement unit for quantity_held (e.g., kg, L, units).',
    CONSTRAINT pk_quarantine_hold PRIMARY KEY(`quarantine_hold_id`)
) COMMENT 'Operational record for inventory placed under quality hold or quarantine status — pending quality inspection, regulatory hold, allergen cross-contact risk, or recall investigation. Captures hold type (quality inspection, regulatory, allergen, recall, supplier deviation), hold reason, quantity held, lot/batch reference, storage location, hold initiation date, expected review date, hold release date, disposition decision (release, rework, destroy, return to supplier), and authorizing quality manager. Aligned with SAP QM usage decision. Drives stock blocking in stock_position and triggers quality domain workflows.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`inventory`.`wip_stock` (
    `wip_stock_id` BIGINT COMMENT 'System-generated unique identifier for each WIP stock record.',
    `cost_center_id` BIGINT COMMENT 'Cost center responsible for the WIP cost allocation.',
    `employee_id` BIGINT COMMENT 'User identifier of the person who created the WIP record.',
    `plant_id` BIGINT COMMENT 'Identifier of the manufacturing plant where the WIP is located.',
    `product_registration_id` BIGINT COMMENT 'Foreign key linking to regulatory.product_registration. Business justification: Work‑in‑process tracking must reference product registration to ensure safety, labeling, and regulatory compliance during production.',
    `production_line_work_center_id` BIGINT COMMENT 'Identifier of the specific production line within the work center.',
    `production_shift_id` BIGINT COMMENT 'Identifier of the work shift during which the WIP was recorded.',
    `work_center_id` BIGINT COMMENT 'Identifier of the work center or production line handling the WIP.',
    `actual_completion_timestamp` TIMESTAMP COMMENT 'Timestamp when the WIP was actually completed.',
    `batch_number` STRING COMMENT 'Batch number associated with the WIP material.',
    `compliance_status` STRING COMMENT 'Regulatory compliance status of the WIP (e.g., FDA, GFSI).. Valid values are `compliant|non_compliant|pending`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the WIP record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for the valuation amount.. Valid values are `[A-Z]{3}`',
    `estimated_completion_timestamp` TIMESTAMP COMMENT 'Planned timestamp when the WIP is expected to be completed.',
    `expiration_date` DATE COMMENT 'Calendar date when the WIP material must be used or discarded.',
    `is_fefo` BOOLEAN COMMENT 'True if the WIP is managed using First‑Expired‑First‑Out (FEFO) logic.',
    `is_fifo` BOOLEAN COMMENT 'True if the WIP is managed using First‑In‑First‑Out (FIFO) logic.',
    `is_lot_traceable` BOOLEAN COMMENT 'Indicates whether the WIP lot is subject to traceability requirements (true/false).',
    `is_quality_checked` BOOLEAN COMMENT 'Indicates whether the WIP has passed quality inspection (true/false).',
    `lot_number` STRING COMMENT 'Lot identifier for traceability of the WIP batch.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the WIP record.',
    `notes` STRING COMMENT 'Free‑form comments or observations about the WIP record.',
    `production_order_number` STRING COMMENT 'External production order number associated with the WIP inventory.',
    `quality_status` STRING COMMENT 'Result of the most recent quality inspection for the WIP.. Valid values are `passed|failed|pending`',
    `quantity` DECIMAL(18,2) COMMENT 'Amount of material in the WIP stage, expressed in the unit of measure.',
    `shelf_life_remaining_days` STRING COMMENT 'Number of days remaining before the WIP expires based on shelf‑life policy.',
    `source_system` STRING COMMENT 'Originating system that supplied the WIP data.. Valid values are `SAP_PP|MES|ERP`',
    `stage_name` STRING COMMENT 'Descriptive name of the WIP stage (e.g., raw mix, in‑process).. Valid values are `raw_mix|in_process|semi_finished|awaiting_packaging`',
    `unit_of_measure` STRING COMMENT 'Measurement unit for the quantity (e.g., kilograms, pounds, units).. Valid values are `kg|lb|units`',
    `wip_stock_status` STRING COMMENT 'Current lifecycle status of the WIP record.. Valid values are `active|completed|on_hold|cancelled`',
    `wip_type` STRING COMMENT 'Classification of the WIP inventory type.. Valid values are `raw_mix|in_process|semi_finished|awaiting_packaging`',
    `wip_valuation_amount` DECIMAL(18,2) COMMENT 'Monetary value of the WIP inventory at the time of capture.',
    CONSTRAINT pk_wip_stock PRIMARY KEY(`wip_stock_id`)
) COMMENT 'Master record tracking work-in-process (WIP) inventory at each production line and work center within a plant. Captures WIP stage (raw mix, in-process, semi-finished, awaiting packaging), quantity at each stage, associated production order, work center, shift, estimated completion time, and WIP valuation. Aligned with SAP PP production order WIP and Aveva/Wonderware MES batch management. Provides real-time visibility into in-process inventory for production scheduling and material flow.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`inventory`.`consignment_stock` (
    `consignment_stock_id` BIGINT COMMENT 'Unique identifier for the consignment stock record.',
    `account_id` BIGINT COMMENT 'Identifier of the retailer, foodservice operator, or distributor holding the consignment stock.',
    `raw_material_id` BIGINT COMMENT 'Identifier of the material or SKU being consigned.',
    `employee_id` BIGINT COMMENT 'Identifier of the user who created the record.',
    `product_registration_id` BIGINT COMMENT 'Foreign key linking to regulatory.product_registration. Business justification: Consignment agreements require each consigned item to be tied to its registered product for compliance and settlement reporting.',
    `stock_position_id` BIGINT COMMENT 'Foreign key linking to inventory.stock_position. Business justification: Consignment stock represents inventory held at a customer location; it maps to a stock position for the same material/lot.',
    `storage_location_id` BIGINT COMMENT 'Identifier of the physical location where consignment stock is held.',
    `consignment_agreement_number` STRING COMMENT 'External reference number for the consignment agreement.',
    `consignment_quantity` DECIMAL(18,2) COMMENT 'Current quantity of the material held on consignment at the partner location.',
    `consignment_stock_status` STRING COMMENT 'Current lifecycle status of the consignment stock record.. Valid values are `active|inactive|suspended|closed|pending`',
    `consignment_type` STRING COMMENT 'Type of consignment arrangement, e.g., Vendor Managed Inventory, Direct Store Delivery, or Standard.. Valid values are `VMI|DSD|Standard`',
    `consumption_to_date` DECIMAL(18,2) COMMENT 'Cumulative quantity of the consigned material that has been consumed or sold to date.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the consignment stock record was created.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for valuation amounts.',
    `effective_from` DATE COMMENT 'Date when the consignment agreement becomes effective.',
    `effective_until` DATE COMMENT 'Date when the consignment agreement ends; null if open-ended.',
    `expiration_date` DATE COMMENT 'Date on which the consigned product expires.',
    `fefo_flag` BOOLEAN COMMENT 'Indicates whether First‑Expired‑First‑Out logic is applied.',
    `fifo_flag` BOOLEAN COMMENT 'Indicates whether First‑In‑First‑Out logic is applied.',
    `last_consumption_date` DATE COMMENT 'Date when the most recent consumption of consigned stock occurred.',
    `last_replenishment_date` DATE COMMENT 'Date of the most recent replenishment transaction.',
    `location_type` STRING COMMENT 'Category of the location holding the consignment stock.. Valid values are `store|warehouse|distribution_center|3pl`',
    `material_description` STRING COMMENT 'Text description of the consigned material.',
    `max_temperature_c` DECIMAL(18,2) COMMENT 'Maximum allowable storage temperature in degrees Celsius.',
    `min_temperature_c` DECIMAL(18,2) COMMENT 'Minimum allowable storage temperature in degrees Celsius.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the record.',
    `next_replenishment_date` DATE COMMENT 'Planned date for the next replenishment based on trigger logic.',
    `notes` STRING COMMENT 'Free‑form notes or comments about the consignment stock.',
    `partner_name` STRING COMMENT 'Human‑readable name of the consignment partner.',
    `partner_type` STRING COMMENT 'Classification of the partner entity.. Valid values are `retailer|foodservice|distributor|wholesale`',
    `replenishment_quantity` DECIMAL(18,2) COMMENT 'Standard quantity to replenish when the trigger is met.',
    `replenishment_trigger_quantity` DECIMAL(18,2) COMMENT 'Quantity threshold that triggers a replenishment order.',
    `settlement_cycle` STRING COMMENT 'Frequency of financial settlement for the consignment stock.. Valid values are `monthly|quarterly|per_transaction`',
    `settlement_terms` STRING COMMENT 'Free‑text description of settlement terms and conditions.',
    `shelf_life_remaining_days` STRING COMMENT 'Number of days remaining before the product reaches end of shelf life.',
    `stock_valuation_amount` DECIMAL(18,2) COMMENT 'Monetary valuation of the consignment stock on hand.',
    `temperature_controlled_flag` BOOLEAN COMMENT 'True if the consignment stock requires temperature control.',
    `unit_of_measure` STRING COMMENT 'Measurement unit for the consignment quantity.. Valid values are `EA|KG|L|ML|CASE|PACK`',
    CONSTRAINT pk_consignment_stock PRIMARY KEY(`consignment_stock_id`)
) COMMENT 'Master record for inventory held at customer or retailer locations on a consignment basis — ownership remains with Food Beverage until consumed or sold. Captures consignment partner (retailer, foodservice operator, distributor), consignment location, material/SKU, consignment quantity, consumption-to-date, replenishment trigger quantity, consignment agreement reference, and settlement cycle. Supports DSD (Direct Store Delivery) consignment programs and vendor-managed inventory (VMI) arrangements.';

CREATE OR REPLACE TABLE `food_beverage_ecm`.`inventory`.`reservation` (
    `reservation_id` BIGINT COMMENT 'Primary key for reservation',
    `center_id` BIGINT COMMENT 'Identifier of the DC where the reserved inventory is held, if applicable.',
    `cost_center_id` BIGINT COMMENT 'Financial cost center associated with the reservation for internal accounting.',
    `raw_material_id` BIGINT COMMENT 'Unique identifier of the material (SKU) for which inventory is being reserved.',
    `order_id` BIGINT COMMENT 'Foreign key linking to sales.order. Business justification: Order fulfillment creates inventory reservations; the reservation record must reference the sales order to track allocated stock for each order.',
    `price_list_line_id` BIGINT COMMENT 'Foreign key linking to pricing.price_list_line. Business justification: Reservation pricing calculates reserved value using the applicable price list line, essential for revenue forecasting and inventory commitment reporting.',
    `rd_project_id` BIGINT COMMENT 'Foreign key linking to research.rd_project. Business justification: Reservation system supports R&D projects reserving inventory; linking reservation to rd_project enables project‑level material planning reports.',
    `employee_id` BIGINT COMMENT 'Identifier of the user who initially created the reservation record.',
    `reservation_employee_id` BIGINT COMMENT 'Identifier of the user who approved the reservation, if an approval step is required.',
    `reservation_modified_by_user_employee_id` BIGINT COMMENT 'Identifier of the user who performed the most recent update to the reservation.',
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

CREATE OR REPLACE TABLE `food_beverage_ecm`.`inventory`.`shelf_life_monitor` (
    `shelf_life_monitor_id` BIGINT COMMENT 'System‑generated unique identifier for each shelf‑life monitoring record.',
    `employee_id` BIGINT COMMENT 'Identifier of the user or process that created the record.',
    `product_registration_id` BIGINT COMMENT 'Foreign key linking to regulatory.product_registration. Business justification: Shelf‑life monitoring dashboards need product registration data to validate compliance with expiration and labeling regulations.',
    `stock_position_id` BIGINT COMMENT 'Foreign key linking to inventory.stock_position. Business justification: Shelf‑life monitoring is performed per stock position; the FK provides the context and allows removal of duplicated location and product identifiers.',
    `storage_location_id` BIGINT COMMENT 'Unique identifier of the storage location where the lot resides.',
    `original_shelf_life_monitor_id` BIGINT COMMENT 'Self-referencing FK on shelf_life_monitor (original_shelf_life_monitor_id)',
    `alert_flag` BOOLEAN COMMENT 'Indicates whether an expiry or FEFO rotation alert has been generated for the lot.',
    `alert_generated_timestamp` TIMESTAMP COMMENT 'Date‑time when the expiry/rotation alert was created.',
    `alert_threshold_days` STRING COMMENT 'Number of days before expiry at which an alert is triggered.',
    `compliance_status` STRING COMMENT 'Indicates whether the lot meets regulatory and internal compliance requirements.. Valid values are `compliant|non_compliant|pending`',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the monitoring record was first created.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for monetary values.. Valid values are `USD|EUR|GBP|CAD|JPY|AUD`',
    `event_type` STRING COMMENT 'Category of the monitoring event (e.g., shelf‑life update, expiry alert).. Valid values are `shelf_life_update|expiry_alert|stock_movement`',
    `expiration_date` DATE COMMENT 'Date after which the product is no longer fit for sale or consumption.',
    `expiry_status` STRING COMMENT 'Current status of the lot based on remaining shelf life.. Valid values are `valid|expiring_soon|expired|unknown`',
    `gtin` STRING COMMENT 'Global identifier for the product used in trade and traceability.',
    `last_movement_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent inventory transaction affecting the lot.',
    `location_code` STRING COMMENT 'Alphanumeric code used in WMS for the storage location.',
    `max_temperature_c` DECIMAL(18,2) COMMENT 'Upper temperature bound for the storage condition of the lot.',
    `min_temperature_c` DECIMAL(18,2) COMMENT 'Lower temperature bound for the storage condition of the lot.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent update to the record.',
    `notes` STRING COMMENT 'Free‑form comments or observations related to the lot.',
    `observation_timestamp` TIMESTAMP COMMENT 'Date‑time when the shelf‑life observation was captured.',
    `product_name` STRING COMMENT 'Descriptive name of the product associated with the lot.',
    `production_date` DATE COMMENT 'Date the lot was produced or manufactured.',
    `quality_status` STRING COMMENT 'Result of quality inspections for the lot.. Valid values are `passed|failed|pending|hold`',
    `quantity_on_hand` DECIMAL(18,2) COMMENT 'Current total quantity of the lot available in the location.',
    `recall_flag` BOOLEAN COMMENT 'True if the lot has been subject to a product recall.',
    `receipt_date` DATE COMMENT 'Date the lot was received into inventory.',
    `remaining_shelf_life_days` STRING COMMENT 'Calculated days remaining before the lot reaches its expiration date.',
    `shelf_life_days` STRING COMMENT 'Total number of days the product is expected to remain usable from production.',
    `source_system` STRING COMMENT 'Originating system that generated the record (e.g., SAP WM, MES).',
    `temperature_controlled_flag` BOOLEAN COMMENT 'True if the lot is stored in a temperature‑controlled environment.',
    `unit_cost` DECIMAL(18,2) COMMENT 'Standard cost per unit of the lot in the functional currency.',
    `unit_of_measure` STRING COMMENT 'Measurement unit for the quantity (e.g., kilograms, pieces).. Valid values are `kg|lb|pcs|ltr|gal`',
    `valuation_amount` DECIMAL(18,2) COMMENT 'Monetary value of the lot based on the chosen inventory valuation method.',
    CONSTRAINT pk_shelf_life_monitor PRIMARY KEY(`shelf_life_monitor_id`)
) COMMENT 'Operational monitoring record tracking remaining shelf life for perishable inventory lots at each storage location, triggering FEFO rotation alerts and markdown/disposal actions when approaching expiry thresholds.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `food_beverage_ecm`.`inventory`.`stock_position` ADD CONSTRAINT `fk_inventory_stock_position_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `food_beverage_ecm`.`inventory`.`storage_location`(`storage_location_id`);
ALTER TABLE `food_beverage_ecm`.`inventory`.`goods_movement` ADD CONSTRAINT `fk_inventory_goods_movement_stock_position_id` FOREIGN KEY (`stock_position_id`) REFERENCES `food_beverage_ecm`.`inventory`.`stock_position`(`stock_position_id`);
ALTER TABLE `food_beverage_ecm`.`inventory`.`stock_transfer_order` ADD CONSTRAINT `fk_inventory_stock_transfer_order_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `food_beverage_ecm`.`inventory`.`storage_location`(`storage_location_id`);
ALTER TABLE `food_beverage_ecm`.`inventory`.`stock_transfer_order` ADD CONSTRAINT `fk_inventory_stock_transfer_order_primary_stock_storage_location_id` FOREIGN KEY (`primary_stock_storage_location_id`) REFERENCES `food_beverage_ecm`.`inventory`.`storage_location`(`storage_location_id`);
ALTER TABLE `food_beverage_ecm`.`inventory`.`cycle_count_line` ADD CONSTRAINT `fk_inventory_cycle_count_line_cycle_count_id` FOREIGN KEY (`cycle_count_id`) REFERENCES `food_beverage_ecm`.`inventory`.`cycle_count`(`cycle_count_id`);
ALTER TABLE `food_beverage_ecm`.`inventory`.`adjustment` ADD CONSTRAINT `fk_inventory_adjustment_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `food_beverage_ecm`.`inventory`.`storage_location`(`storage_location_id`);
ALTER TABLE `food_beverage_ecm`.`inventory`.`adjustment` ADD CONSTRAINT `fk_inventory_adjustment_adjustment_storage_location_id` FOREIGN KEY (`adjustment_storage_location_id`) REFERENCES `food_beverage_ecm`.`inventory`.`storage_location`(`storage_location_id`);
ALTER TABLE `food_beverage_ecm`.`inventory`.`adjustment` ADD CONSTRAINT `fk_inventory_adjustment_stock_position_id` FOREIGN KEY (`stock_position_id`) REFERENCES `food_beverage_ecm`.`inventory`.`stock_position`(`stock_position_id`);
ALTER TABLE `food_beverage_ecm`.`inventory`.`lot_trace` ADD CONSTRAINT `fk_inventory_lot_trace_stock_position_id` FOREIGN KEY (`stock_position_id`) REFERENCES `food_beverage_ecm`.`inventory`.`stock_position`(`stock_position_id`);
ALTER TABLE `food_beverage_ecm`.`inventory`.`lot_trace` ADD CONSTRAINT `fk_inventory_lot_trace_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `food_beverage_ecm`.`inventory`.`storage_location`(`storage_location_id`);
ALTER TABLE `food_beverage_ecm`.`inventory`.`quarantine_hold` ADD CONSTRAINT `fk_inventory_quarantine_hold_stock_position_id` FOREIGN KEY (`stock_position_id`) REFERENCES `food_beverage_ecm`.`inventory`.`stock_position`(`stock_position_id`);
ALTER TABLE `food_beverage_ecm`.`inventory`.`consignment_stock` ADD CONSTRAINT `fk_inventory_consignment_stock_stock_position_id` FOREIGN KEY (`stock_position_id`) REFERENCES `food_beverage_ecm`.`inventory`.`stock_position`(`stock_position_id`);
ALTER TABLE `food_beverage_ecm`.`inventory`.`consignment_stock` ADD CONSTRAINT `fk_inventory_consignment_stock_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `food_beverage_ecm`.`inventory`.`storage_location`(`storage_location_id`);
ALTER TABLE `food_beverage_ecm`.`inventory`.`reservation` ADD CONSTRAINT `fk_inventory_reservation_stock_position_id` FOREIGN KEY (`stock_position_id`) REFERENCES `food_beverage_ecm`.`inventory`.`stock_position`(`stock_position_id`);
ALTER TABLE `food_beverage_ecm`.`inventory`.`reservation` ADD CONSTRAINT `fk_inventory_reservation_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `food_beverage_ecm`.`inventory`.`storage_location`(`storage_location_id`);
ALTER TABLE `food_beverage_ecm`.`inventory`.`shelf_life_monitor` ADD CONSTRAINT `fk_inventory_shelf_life_monitor_stock_position_id` FOREIGN KEY (`stock_position_id`) REFERENCES `food_beverage_ecm`.`inventory`.`stock_position`(`stock_position_id`);
ALTER TABLE `food_beverage_ecm`.`inventory`.`shelf_life_monitor` ADD CONSTRAINT `fk_inventory_shelf_life_monitor_storage_location_id` FOREIGN KEY (`storage_location_id`) REFERENCES `food_beverage_ecm`.`inventory`.`storage_location`(`storage_location_id`);
ALTER TABLE `food_beverage_ecm`.`inventory`.`shelf_life_monitor` ADD CONSTRAINT `fk_inventory_shelf_life_monitor_original_shelf_life_monitor_id` FOREIGN KEY (`original_shelf_life_monitor_id`) REFERENCES `food_beverage_ecm`.`inventory`.`shelf_life_monitor`(`shelf_life_monitor_id`);

-- ========= TAGS =========
ALTER SCHEMA `food_beverage_ecm`.`inventory` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `food_beverage_ecm`.`inventory` SET TAGS ('dbx_domain' = 'inventory');
ALTER TABLE `food_beverage_ecm`.`inventory`.`stock_position` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `food_beverage_ecm`.`inventory`.`stock_position` SET TAGS ('dbx_subdomain' = 'stock_management');
ALTER TABLE `food_beverage_ecm`.`inventory`.`stock_position` ALTER COLUMN `stock_position_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Position ID');
ALTER TABLE `food_beverage_ecm`.`inventory`.`stock_position` ALTER COLUMN `lot_id` SET TAGS ('dbx_business_glossary_term' = 'Lot ID');
ALTER TABLE `food_beverage_ecm`.`inventory`.`stock_position` ALTER COLUMN `packaging_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Packaging Profile Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`inventory`.`stock_position` ALTER COLUMN `po_line_id` SET TAGS ('dbx_business_glossary_term' = 'Po Line Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`inventory`.`stock_position` ALTER COLUMN `price_list_line_id` SET TAGS ('dbx_business_glossary_term' = 'Price List Line Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`inventory`.`stock_position` ALTER COLUMN `product_registration_id` SET TAGS ('dbx_business_glossary_term' = 'Product Registration Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`inventory`.`stock_position` ALTER COLUMN `rd_project_id` SET TAGS ('dbx_business_glossary_term' = 'Rd Project Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`inventory`.`stock_position` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Employee Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`inventory`.`stock_position` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`inventory`.`stock_position` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `food_beverage_ecm`.`inventory`.`stock_position` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Material ID');
ALTER TABLE `food_beverage_ecm`.`inventory`.`stock_position` ALTER COLUMN `storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'Storage Location ID');
ALTER TABLE `food_beverage_ecm`.`inventory`.`stock_position` ALTER COLUMN `abc_classification` SET TAGS ('dbx_business_glossary_term' = 'ABC Classification');
ALTER TABLE `food_beverage_ecm`.`inventory`.`stock_position` ALTER COLUMN `abc_classification` SET TAGS ('dbx_value_regex' = 'A|B|C|X');
ALTER TABLE `food_beverage_ecm`.`inventory`.`stock_position` ALTER COLUMN `allergen_segregation_flag` SET TAGS ('dbx_business_glossary_term' = 'Allergen Segregation Flag');
ALTER TABLE `food_beverage_ecm`.`inventory`.`stock_position` ALTER COLUMN `best_before_date` SET TAGS ('dbx_business_glossary_term' = 'Best Before Date (BBD)');
ALTER TABLE `food_beverage_ecm`.`inventory`.`stock_position` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `food_beverage_ecm`.`inventory`.`stock_position` ALTER COLUMN `cycle_count_date` SET TAGS ('dbx_business_glossary_term' = 'Cycle Count Date');
ALTER TABLE `food_beverage_ecm`.`inventory`.`stock_position` ALTER COLUMN `cycle_count_variance` SET TAGS ('dbx_business_glossary_term' = 'Cycle Count Variance');
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
ALTER TABLE `food_beverage_ecm`.`inventory`.`storage_location` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Manager Employee Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`inventory`.`storage_location` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`inventory`.`storage_location` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `food_beverage_ecm`.`inventory`.`storage_location` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant ID');
ALTER TABLE `food_beverage_ecm`.`inventory`.`storage_location` ALTER COLUMN `price_zone_id` SET TAGS ('dbx_business_glossary_term' = 'Price Zone Id (Foreign Key)');
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
ALTER TABLE `food_beverage_ecm`.`inventory`.`goods_movement` SET TAGS ('dbx_subdomain' = 'movement_processing');
ALTER TABLE `food_beverage_ecm`.`inventory`.`goods_movement` ALTER COLUMN `goods_movement_id` SET TAGS ('dbx_business_glossary_term' = 'Goods Movement ID');
ALTER TABLE `food_beverage_ecm`.`inventory`.`goods_movement` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approver ID');
ALTER TABLE `food_beverage_ecm`.`inventory`.`goods_movement` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`inventory`.`goods_movement` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`inventory`.`goods_movement` ALTER COLUMN `order_id` SET TAGS ('dbx_business_glossary_term' = 'Order Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`inventory`.`goods_movement` ALTER COLUMN `price_list_line_id` SET TAGS ('dbx_business_glossary_term' = 'Price List Line Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`inventory`.`goods_movement` ALTER COLUMN `primary_goods_employee_id` SET TAGS ('dbx_business_glossary_term' = 'User ID');
ALTER TABLE `food_beverage_ecm`.`inventory`.`goods_movement` ALTER COLUMN `primary_goods_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`inventory`.`goods_movement` ALTER COLUMN `promotion_event_id` SET TAGS ('dbx_business_glossary_term' = 'Promotion Event Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`inventory`.`goods_movement` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU)');
ALTER TABLE `food_beverage_ecm`.`inventory`.`goods_movement` ALTER COLUMN `stock_position_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Position Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`inventory`.`goods_movement` ALTER COLUMN `amount_lc` SET TAGS ('dbx_business_glossary_term' = 'Amount in Local Currency (LC)');
ALTER TABLE `food_beverage_ecm`.`inventory`.`goods_movement` ALTER COLUMN `amount_lc` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`inventory`.`goods_movement` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `food_beverage_ecm`.`inventory`.`goods_movement` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected');
ALTER TABLE `food_beverage_ecm`.`inventory`.`goods_movement` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `food_beverage_ecm`.`inventory`.`goods_movement` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Number');
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
ALTER TABLE `food_beverage_ecm`.`inventory`.`goods_movement` ALTER COLUMN `source_storage_location` SET TAGS ('dbx_business_glossary_term' = 'Source Storage Location');
ALTER TABLE `food_beverage_ecm`.`inventory`.`goods_movement` ALTER COLUMN `stock_type` SET TAGS ('dbx_business_glossary_term' = 'Stock Type');
ALTER TABLE `food_beverage_ecm`.`inventory`.`goods_movement` ALTER COLUMN `stock_type` SET TAGS ('dbx_value_regex' = 'unrestricted|quality_inspection|blocked|restricted|returns');
ALTER TABLE `food_beverage_ecm`.`inventory`.`goods_movement` ALTER COLUMN `storage_location` SET TAGS ('dbx_business_glossary_term' = 'Storage Location');
ALTER TABLE `food_beverage_ecm`.`inventory`.`goods_movement` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UoM)');
ALTER TABLE `food_beverage_ecm`.`inventory`.`goods_movement` ALTER COLUMN `valuation_type` SET TAGS ('dbx_business_glossary_term' = 'Valuation Type');
ALTER TABLE `food_beverage_ecm`.`inventory`.`goods_movement` ALTER COLUMN `vendor_code` SET TAGS ('dbx_business_glossary_term' = 'Vendor Code');
ALTER TABLE `food_beverage_ecm`.`inventory`.`stock_transfer_order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `food_beverage_ecm`.`inventory`.`stock_transfer_order` SET TAGS ('dbx_subdomain' = 'movement_processing');
ALTER TABLE `food_beverage_ecm`.`inventory`.`stock_transfer_order` ALTER COLUMN `stock_transfer_order_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Transfer Order ID');
ALTER TABLE `food_beverage_ecm`.`inventory`.`stock_transfer_order` ALTER COLUMN `carrier_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier ID');
ALTER TABLE `food_beverage_ecm`.`inventory`.`stock_transfer_order` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center ID');
ALTER TABLE `food_beverage_ecm`.`inventory`.`stock_transfer_order` ALTER COLUMN `storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'Destination Location ID');
ALTER TABLE `food_beverage_ecm`.`inventory`.`stock_transfer_order` ALTER COLUMN `order_id` SET TAGS ('dbx_business_glossary_term' = 'Order Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`inventory`.`stock_transfer_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `food_beverage_ecm`.`inventory`.`stock_transfer_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`inventory`.`stock_transfer_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `food_beverage_ecm`.`inventory`.`stock_transfer_order` ALTER COLUMN `primary_stock_storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'Source Location ID');
ALTER TABLE `food_beverage_ecm`.`inventory`.`stock_transfer_order` ALTER COLUMN `rd_project_id` SET TAGS ('dbx_business_glossary_term' = 'Rd Project Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`inventory`.`stock_transfer_order` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Material ID');
ALTER TABLE `food_beverage_ecm`.`inventory`.`stock_transfer_order` ALTER COLUMN `tertiary_stock_approved_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By User ID');
ALTER TABLE `food_beverage_ecm`.`inventory`.`stock_transfer_order` ALTER COLUMN `tertiary_stock_approved_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`inventory`.`stock_transfer_order` ALTER COLUMN `tertiary_stock_approved_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `food_beverage_ecm`.`inventory`.`stock_transfer_order` ALTER COLUMN `transfer_price_id` SET TAGS ('dbx_business_glossary_term' = 'Transfer Price Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`inventory`.`stock_transfer_order` ALTER COLUMN `actual_receipt_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Receipt Date');
ALTER TABLE `food_beverage_ecm`.`inventory`.`stock_transfer_order` ALTER COLUMN `actual_shipment_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Shipment Date');
ALTER TABLE `food_beverage_ecm`.`inventory`.`stock_transfer_order` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `food_beverage_ecm`.`inventory`.`stock_transfer_order` ALTER COLUMN `cancelled_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancelled Reason');
ALTER TABLE `food_beverage_ecm`.`inventory`.`stock_transfer_order` ALTER COLUMN `confirmed_quantity` SET TAGS ('dbx_business_glossary_term' = 'Confirmed Quantity');
ALTER TABLE `food_beverage_ecm`.`inventory`.`stock_transfer_order` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `food_beverage_ecm`.`inventory`.`stock_transfer_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `food_beverage_ecm`.`inventory`.`stock_transfer_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `food_beverage_ecm`.`inventory`.`stock_transfer_order` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `food_beverage_ecm`.`inventory`.`stock_transfer_order` ALTER COLUMN `lot_number` SET TAGS ('dbx_business_glossary_term' = 'Lot Number');
ALTER TABLE `food_beverage_ecm`.`inventory`.`stock_transfer_order` ALTER COLUMN `lot_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
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
ALTER TABLE `food_beverage_ecm`.`inventory`.`stock_transfer_order` ALTER COLUMN `sku` SET TAGS ('dbx_business_glossary_term' = 'Stock Keeping Unit (SKU)');
ALTER TABLE `food_beverage_ecm`.`inventory`.`stock_transfer_order` ALTER COLUMN `sku` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{6,20}$');
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
ALTER TABLE `food_beverage_ecm`.`inventory`.`cycle_count` SET TAGS ('dbx_subdomain' = 'inventory_counting');
ALTER TABLE `food_beverage_ecm`.`inventory`.`cycle_count` ALTER COLUMN `cycle_count_id` SET TAGS ('dbx_business_glossary_term' = 'Cycle Count ID');
ALTER TABLE `food_beverage_ecm`.`inventory`.`cycle_count` ALTER COLUMN `center_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Center (DC) ID');
ALTER TABLE `food_beverage_ecm`.`inventory`.`cycle_count` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Counter Assigned Employee Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`inventory`.`cycle_count` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`inventory`.`cycle_count` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `food_beverage_ecm`.`inventory`.`cycle_count` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant ID');
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
ALTER TABLE `food_beverage_ecm`.`inventory`.`cycle_count` ALTER COLUMN `storage_location_code` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Code');
ALTER TABLE `food_beverage_ecm`.`inventory`.`cycle_count` ALTER COLUMN `storage_location_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `food_beverage_ecm`.`inventory`.`cycle_count` ALTER COLUMN `supervisor_assigned` SET TAGS ('dbx_business_glossary_term' = 'Supervisor Assigned');
ALTER TABLE `food_beverage_ecm`.`inventory`.`cycle_count` ALTER COLUMN `supervisor_assigned` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`inventory`.`cycle_count` ALTER COLUMN `total_items_counted` SET TAGS ('dbx_business_glossary_term' = 'Total Items Counted');
ALTER TABLE `food_beverage_ecm`.`inventory`.`cycle_count` ALTER COLUMN `total_variance_items` SET TAGS ('dbx_business_glossary_term' = 'Total Variance Items');
ALTER TABLE `food_beverage_ecm`.`inventory`.`cycle_count` ALTER COLUMN `total_variance_value` SET TAGS ('dbx_business_glossary_term' = 'Total Variance Value');
ALTER TABLE `food_beverage_ecm`.`inventory`.`cycle_count` ALTER COLUMN `total_variance_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`inventory`.`cycle_count` ALTER COLUMN `variance_threshold_percentage` SET TAGS ('dbx_business_glossary_term' = 'Variance Threshold Percentage');
ALTER TABLE `food_beverage_ecm`.`inventory`.`cycle_count` ALTER COLUMN `variance_threshold_quantity` SET TAGS ('dbx_business_glossary_term' = 'Variance Threshold Quantity');
ALTER TABLE `food_beverage_ecm`.`inventory`.`cycle_count_line` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `food_beverage_ecm`.`inventory`.`cycle_count_line` SET TAGS ('dbx_subdomain' = 'inventory_counting');
ALTER TABLE `food_beverage_ecm`.`inventory`.`cycle_count_line` ALTER COLUMN `cycle_count_line_id` SET TAGS ('dbx_business_glossary_term' = 'Cycle Count Line ID');
ALTER TABLE `food_beverage_ecm`.`inventory`.`cycle_count_line` ALTER COLUMN `cycle_count_id` SET TAGS ('dbx_business_glossary_term' = 'Cycle Count Header ID');
ALTER TABLE `food_beverage_ecm`.`inventory`.`cycle_count_line` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Counted By User ID');
ALTER TABLE `food_beverage_ecm`.`inventory`.`cycle_count_line` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`inventory`.`cycle_count_line` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `food_beverage_ecm`.`inventory`.`cycle_count_line` ALTER COLUMN `adjustment_reason` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Reason Description');
ALTER TABLE `food_beverage_ecm`.`inventory`.`cycle_count_line` ALTER COLUMN `adjustment_type` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Type');
ALTER TABLE `food_beverage_ecm`.`inventory`.`cycle_count_line` ALTER COLUMN `adjustment_type` SET TAGS ('dbx_value_regex' = 'increase|decrease|none');
ALTER TABLE `food_beverage_ecm`.`inventory`.`cycle_count_line` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `food_beverage_ecm`.`inventory`.`cycle_count_line` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending');
ALTER TABLE `food_beverage_ecm`.`inventory`.`cycle_count_line` ALTER COLUMN `count_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Count Timestamp');
ALTER TABLE `food_beverage_ecm`.`inventory`.`cycle_count_line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `food_beverage_ecm`.`inventory`.`cycle_count_line` ALTER COLUMN `cycle_count_status` SET TAGS ('dbx_business_glossary_term' = 'Cycle Count Status');
ALTER TABLE `food_beverage_ecm`.`inventory`.`cycle_count_line` ALTER COLUMN `cycle_count_status` SET TAGS ('dbx_value_regex' = 'open|closed|pending|reconciled');
ALTER TABLE `food_beverage_ecm`.`inventory`.`cycle_count_line` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date (Shelf Life End Date)');
ALTER TABLE `food_beverage_ecm`.`inventory`.`cycle_count_line` ALTER COLUMN `final_quantity` SET TAGS ('dbx_business_glossary_term' = 'Final Reconciled Quantity');
ALTER TABLE `food_beverage_ecm`.`inventory`.`cycle_count_line` ALTER COLUMN `inventory_valuation_method` SET TAGS ('dbx_business_glossary_term' = 'Inventory Valuation Method');
ALTER TABLE `food_beverage_ecm`.`inventory`.`cycle_count_line` ALTER COLUMN `inventory_valuation_method` SET TAGS ('dbx_value_regex' = 'FIFO|FEFO|LIFO|Average');
ALTER TABLE `food_beverage_ecm`.`inventory`.`cycle_count_line` ALTER COLUMN `is_critical_item` SET TAGS ('dbx_business_glossary_term' = 'Critical Item Flag');
ALTER TABLE `food_beverage_ecm`.`inventory`.`cycle_count_line` ALTER COLUMN `line_number` SET TAGS ('dbx_business_glossary_term' = 'Line Sequence Number');
ALTER TABLE `food_beverage_ecm`.`inventory`.`cycle_count_line` ALTER COLUMN `lot_number` SET TAGS ('dbx_business_glossary_term' = 'Lot Number (Batch Identifier)');
ALTER TABLE `food_beverage_ecm`.`inventory`.`cycle_count_line` ALTER COLUMN `material_description` SET TAGS ('dbx_business_glossary_term' = 'Material Description');
ALTER TABLE `food_beverage_ecm`.`inventory`.`cycle_count_line` ALTER COLUMN `material_number` SET TAGS ('dbx_business_glossary_term' = 'Material Number (SKU)');
ALTER TABLE `food_beverage_ecm`.`inventory`.`cycle_count_line` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes (Free Text Comments)');
ALTER TABLE `food_beverage_ecm`.`inventory`.`cycle_count_line` ALTER COLUMN `plant_code` SET TAGS ('dbx_business_glossary_term' = 'Plant Code');
ALTER TABLE `food_beverage_ecm`.`inventory`.`cycle_count_line` ALTER COLUMN `quantity_book` SET TAGS ('dbx_business_glossary_term' = 'Book Quantity (System Recorded Quantity)');
ALTER TABLE `food_beverage_ecm`.`inventory`.`cycle_count_line` ALTER COLUMN `quantity_counted` SET TAGS ('dbx_business_glossary_term' = 'Counted Quantity (Physical Count Quantity)');
ALTER TABLE `food_beverage_ecm`.`inventory`.`cycle_count_line` ALTER COLUMN `quantity_variance` SET TAGS ('dbx_business_glossary_term' = 'Quantity Variance (Counted Minus Book)');
ALTER TABLE `food_beverage_ecm`.`inventory`.`cycle_count_line` ALTER COLUMN `recount_flag` SET TAGS ('dbx_business_glossary_term' = 'Recount Flag');
ALTER TABLE `food_beverage_ecm`.`inventory`.`cycle_count_line` ALTER COLUMN `regulatory_lot_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Lot Status');
ALTER TABLE `food_beverage_ecm`.`inventory`.`cycle_count_line` ALTER COLUMN `regulatory_lot_status` SET TAGS ('dbx_value_regex' = 'released|quarantined|pending|recalled');
ALTER TABLE `food_beverage_ecm`.`inventory`.`cycle_count_line` ALTER COLUMN `storage_bin` SET TAGS ('dbx_business_glossary_term' = 'Storage Bin Code');
ALTER TABLE `food_beverage_ecm`.`inventory`.`cycle_count_line` ALTER COLUMN `unit_cost` SET TAGS ('dbx_business_glossary_term' = 'Unit Cost (Cost per Unit)');
ALTER TABLE `food_beverage_ecm`.`inventory`.`cycle_count_line` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `food_beverage_ecm`.`inventory`.`cycle_count_line` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'EA|KG|L|ML|BOX');
ALTER TABLE `food_beverage_ecm`.`inventory`.`cycle_count_line` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `food_beverage_ecm`.`inventory`.`cycle_count_line` ALTER COLUMN `variance_percentage` SET TAGS ('dbx_business_glossary_term' = 'Variance Percentage');
ALTER TABLE `food_beverage_ecm`.`inventory`.`cycle_count_line` ALTER COLUMN `variance_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Variance Reason Code');
ALTER TABLE `food_beverage_ecm`.`inventory`.`cycle_count_line` ALTER COLUMN `variance_reason_code` SET TAGS ('dbx_value_regex' = 'damage|shrink|misplacement|theft|adjustment|other');
ALTER TABLE `food_beverage_ecm`.`inventory`.`cycle_count_line` ALTER COLUMN `warehouse_code` SET TAGS ('dbx_business_glossary_term' = 'Warehouse (Distribution Center) Code');
ALTER TABLE `food_beverage_ecm`.`inventory`.`adjustment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `food_beverage_ecm`.`inventory`.`adjustment` SET TAGS ('dbx_subdomain' = 'movement_processing');
ALTER TABLE `food_beverage_ecm`.`inventory`.`adjustment` ALTER COLUMN `adjustment_id` SET TAGS ('dbx_business_glossary_term' = 'Inventory Adjustment ID');
ALTER TABLE `food_beverage_ecm`.`inventory`.`adjustment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `food_beverage_ecm`.`inventory`.`adjustment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`inventory`.`adjustment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `food_beverage_ecm`.`inventory`.`adjustment` ALTER COLUMN `adjustment_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approver ID');
ALTER TABLE `food_beverage_ecm`.`inventory`.`adjustment` ALTER COLUMN `adjustment_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`inventory`.`adjustment` ALTER COLUMN `adjustment_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `food_beverage_ecm`.`inventory`.`adjustment` ALTER COLUMN `storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'Reclassification Target Location ID');
ALTER TABLE `food_beverage_ecm`.`inventory`.`adjustment` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Reclassification Target Material ID');
ALTER TABLE `food_beverage_ecm`.`inventory`.`adjustment` ALTER COLUMN `adjustment_sku_id` SET TAGS ('dbx_business_glossary_term' = 'Material ID');
ALTER TABLE `food_beverage_ecm`.`inventory`.`adjustment` ALTER COLUMN `adjustment_storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'Location ID');
ALTER TABLE `food_beverage_ecm`.`inventory`.`adjustment` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center ID');
ALTER TABLE `food_beverage_ecm`.`inventory`.`adjustment` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`inventory`.`adjustment` ALTER COLUMN `price_list_id` SET TAGS ('dbx_business_glossary_term' = 'Price List Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`inventory`.`adjustment` ALTER COLUMN `product_registration_id` SET TAGS ('dbx_business_glossary_term' = 'Product Registration Id (Foreign Key)');
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
ALTER TABLE `food_beverage_ecm`.`inventory`.`adjustment` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
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
ALTER TABLE `food_beverage_ecm`.`inventory`.`adjustment` ALTER COLUMN `shelf_life_remaining_days` SET TAGS ('dbx_business_glossary_term' = 'Shelf Life Remaining (Days)');
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
ALTER TABLE `food_beverage_ecm`.`inventory`.`valuation` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`inventory`.`valuation` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant ID');
ALTER TABLE `food_beverage_ecm`.`inventory`.`valuation` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Prepared By Employee Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`inventory`.`valuation` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`inventory`.`valuation` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `food_beverage_ecm`.`inventory`.`valuation` ALTER COLUMN `product_registration_id` SET TAGS ('dbx_business_glossary_term' = 'Product Registration Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`inventory`.`valuation` ALTER COLUMN `sku_id` SET TAGS ('dbx_business_glossary_term' = 'Material ID');
ALTER TABLE `food_beverage_ecm`.`inventory`.`valuation` ALTER COLUMN `adjustment_amount` SET TAGS ('dbx_business_glossary_term' = 'Valuation Adjustment Amount');
ALTER TABLE `food_beverage_ecm`.`inventory`.`valuation` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Number');
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
ALTER TABLE `food_beverage_ecm`.`inventory`.`lot_trace` SET TAGS ('dbx_subdomain' = 'movement_processing');
ALTER TABLE `food_beverage_ecm`.`inventory`.`lot_trace` ALTER COLUMN `lot_trace_id` SET TAGS ('dbx_business_glossary_term' = 'Lot Traceability ID');
ALTER TABLE `food_beverage_ecm`.`inventory`.`lot_trace` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `food_beverage_ecm`.`inventory`.`lot_trace` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`inventory`.`lot_trace` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `food_beverage_ecm`.`inventory`.`lot_trace` ALTER COLUMN `inspection_lot_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Lot Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`inventory`.`lot_trace` ALTER COLUMN `product_registration_id` SET TAGS ('dbx_business_glossary_term' = 'Product Registration Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`inventory`.`lot_trace` ALTER COLUMN `rd_project_id` SET TAGS ('dbx_business_glossary_term' = 'Rd Project Id (Foreign Key)');
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
ALTER TABLE `food_beverage_ecm`.`inventory`.`quarantine_hold` SET TAGS ('dbx_subdomain' = 'movement_processing');
ALTER TABLE `food_beverage_ecm`.`inventory`.`quarantine_hold` ALTER COLUMN `quarantine_hold_id` SET TAGS ('dbx_business_glossary_term' = 'Quarantine Hold Identifier');
ALTER TABLE `food_beverage_ecm`.`inventory`.`quarantine_hold` ALTER COLUMN `center_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Center Identifier');
ALTER TABLE `food_beverage_ecm`.`inventory`.`quarantine_hold` ALTER COLUMN `raw_material_id` SET TAGS ('dbx_business_glossary_term' = 'Material Identifier');
ALTER TABLE `food_beverage_ecm`.`inventory`.`quarantine_hold` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant Identifier');
ALTER TABLE `food_beverage_ecm`.`inventory`.`quarantine_hold` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Quality Manager Identifier');
ALTER TABLE `food_beverage_ecm`.`inventory`.`quarantine_hold` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`inventory`.`quarantine_hold` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `food_beverage_ecm`.`inventory`.`quarantine_hold` ALTER COLUMN `recall_event_id` SET TAGS ('dbx_business_glossary_term' = 'Recall Event Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`inventory`.`quarantine_hold` ALTER COLUMN `stock_position_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Position Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`inventory`.`quarantine_hold` ALTER COLUMN `supplier_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Identifier');
ALTER TABLE `food_beverage_ecm`.`inventory`.`quarantine_hold` ALTER COLUMN `tertiary_quarantine_modified_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Modified By User Identifier');
ALTER TABLE `food_beverage_ecm`.`inventory`.`quarantine_hold` ALTER COLUMN `tertiary_quarantine_modified_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`inventory`.`quarantine_hold` ALTER COLUMN `tertiary_quarantine_modified_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
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
ALTER TABLE `food_beverage_ecm`.`inventory`.`quarantine_hold` ALTER COLUMN `storage_location_code` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Code');
ALTER TABLE `food_beverage_ecm`.`inventory`.`quarantine_hold` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `food_beverage_ecm`.`inventory`.`wip_stock` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `food_beverage_ecm`.`inventory`.`wip_stock` SET TAGS ('dbx_subdomain' = 'inventory_counting');
ALTER TABLE `food_beverage_ecm`.`inventory`.`wip_stock` ALTER COLUMN `wip_stock_id` SET TAGS ('dbx_business_glossary_term' = 'Work-In-Process Stock Identifier (WIP_STOCK_ID)');
ALTER TABLE `food_beverage_ecm`.`inventory`.`wip_stock` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Identifier (COST_CENTER_ID)');
ALTER TABLE `food_beverage_ecm`.`inventory`.`wip_stock` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User Identifier (CREATED_BY_USER_ID)');
ALTER TABLE `food_beverage_ecm`.`inventory`.`wip_stock` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`inventory`.`wip_stock` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `food_beverage_ecm`.`inventory`.`wip_stock` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant Identifier (PLANT_ID)');
ALTER TABLE `food_beverage_ecm`.`inventory`.`wip_stock` ALTER COLUMN `product_registration_id` SET TAGS ('dbx_business_glossary_term' = 'Product Registration Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`inventory`.`wip_stock` ALTER COLUMN `production_line_work_center_id` SET TAGS ('dbx_business_glossary_term' = 'Production Line Identifier (PROD_LINE_ID)');
ALTER TABLE `food_beverage_ecm`.`inventory`.`wip_stock` ALTER COLUMN `production_shift_id` SET TAGS ('dbx_business_glossary_term' = 'Shift Identifier (SHIFT_ID)');
ALTER TABLE `food_beverage_ecm`.`inventory`.`wip_stock` ALTER COLUMN `work_center_id` SET TAGS ('dbx_business_glossary_term' = 'Work Center Identifier (WORK_CENTER_ID)');
ALTER TABLE `food_beverage_ecm`.`inventory`.`wip_stock` ALTER COLUMN `actual_completion_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Completion Timestamp (ACT_COMP_TS)');
ALTER TABLE `food_beverage_ecm`.`inventory`.`wip_stock` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Number (BATCH_NO)');
ALTER TABLE `food_beverage_ecm`.`inventory`.`wip_stock` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status (COMPLIANCE_STATUS)');
ALTER TABLE `food_beverage_ecm`.`inventory`.`wip_stock` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending');
ALTER TABLE `food_beverage_ecm`.`inventory`.`wip_stock` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (CREATED_TS)');
ALTER TABLE `food_beverage_ecm`.`inventory`.`wip_stock` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (CURR_CODE)');
ALTER TABLE `food_beverage_ecm`.`inventory`.`wip_stock` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '[A-Z]{3}');
ALTER TABLE `food_beverage_ecm`.`inventory`.`wip_stock` ALTER COLUMN `estimated_completion_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Estimated Completion Timestamp (EST_COMP_TS)');
ALTER TABLE `food_beverage_ecm`.`inventory`.`wip_stock` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date (EXPIRATION_DATE)');
ALTER TABLE `food_beverage_ecm`.`inventory`.`wip_stock` ALTER COLUMN `is_fefo` SET TAGS ('dbx_business_glossary_term' = 'FEFO Management Flag (FEFO_FLAG)');
ALTER TABLE `food_beverage_ecm`.`inventory`.`wip_stock` ALTER COLUMN `is_fifo` SET TAGS ('dbx_business_glossary_term' = 'FIFO Management Flag (FIFO_FLAG)');
ALTER TABLE `food_beverage_ecm`.`inventory`.`wip_stock` ALTER COLUMN `is_lot_traceable` SET TAGS ('dbx_business_glossary_term' = 'Lot Traceability Flag (LOT_TRACEABLE_FLAG)');
ALTER TABLE `food_beverage_ecm`.`inventory`.`wip_stock` ALTER COLUMN `is_quality_checked` SET TAGS ('dbx_business_glossary_term' = 'Quality Check Flag (QUALITY_CHECK_FLAG)');
ALTER TABLE `food_beverage_ecm`.`inventory`.`wip_stock` ALTER COLUMN `lot_number` SET TAGS ('dbx_business_glossary_term' = 'Lot Number (LOT_NO)');
ALTER TABLE `food_beverage_ecm`.`inventory`.`wip_stock` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modification Timestamp (MODIFIED_TS)');
ALTER TABLE `food_beverage_ecm`.`inventory`.`wip_stock` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Additional Notes (NOTES)');
ALTER TABLE `food_beverage_ecm`.`inventory`.`wip_stock` ALTER COLUMN `production_order_number` SET TAGS ('dbx_business_glossary_term' = 'Production Order Number (PO_NUMBER)');
ALTER TABLE `food_beverage_ecm`.`inventory`.`wip_stock` ALTER COLUMN `quality_status` SET TAGS ('dbx_business_glossary_term' = 'Quality Status (QUALITY_STATUS)');
ALTER TABLE `food_beverage_ecm`.`inventory`.`wip_stock` ALTER COLUMN `quality_status` SET TAGS ('dbx_value_regex' = 'passed|failed|pending');
ALTER TABLE `food_beverage_ecm`.`inventory`.`wip_stock` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'WIP Quantity (WIP_QTY)');
ALTER TABLE `food_beverage_ecm`.`inventory`.`wip_stock` ALTER COLUMN `shelf_life_remaining_days` SET TAGS ('dbx_business_glossary_term' = 'Shelf Life Remaining Days (SL_REMAIN_DAYS)');
ALTER TABLE `food_beverage_ecm`.`inventory`.`wip_stock` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System (SOURCE_SYSTEM)');
ALTER TABLE `food_beverage_ecm`.`inventory`.`wip_stock` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'SAP_PP|MES|ERP');
ALTER TABLE `food_beverage_ecm`.`inventory`.`wip_stock` ALTER COLUMN `stage_name` SET TAGS ('dbx_business_glossary_term' = 'WIP Stage Name (WIP_STAGE)');
ALTER TABLE `food_beverage_ecm`.`inventory`.`wip_stock` ALTER COLUMN `stage_name` SET TAGS ('dbx_value_regex' = 'raw_mix|in_process|semi_finished|awaiting_packaging');
ALTER TABLE `food_beverage_ecm`.`inventory`.`wip_stock` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `food_beverage_ecm`.`inventory`.`wip_stock` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'kg|lb|units');
ALTER TABLE `food_beverage_ecm`.`inventory`.`wip_stock` ALTER COLUMN `wip_stock_status` SET TAGS ('dbx_business_glossary_term' = 'WIP Status (WIP_STATUS)');
ALTER TABLE `food_beverage_ecm`.`inventory`.`wip_stock` ALTER COLUMN `wip_stock_status` SET TAGS ('dbx_value_regex' = 'active|completed|on_hold|cancelled');
ALTER TABLE `food_beverage_ecm`.`inventory`.`wip_stock` ALTER COLUMN `wip_type` SET TAGS ('dbx_business_glossary_term' = 'Work-In-Process Type (WIP_TYPE)');
ALTER TABLE `food_beverage_ecm`.`inventory`.`wip_stock` ALTER COLUMN `wip_type` SET TAGS ('dbx_value_regex' = 'raw_mix|in_process|semi_finished|awaiting_packaging');
ALTER TABLE `food_beverage_ecm`.`inventory`.`wip_stock` ALTER COLUMN `wip_valuation_amount` SET TAGS ('dbx_business_glossary_term' = 'WIP Valuation Amount (WIP_VAL_AMT)');
ALTER TABLE `food_beverage_ecm`.`inventory`.`consignment_stock` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `food_beverage_ecm`.`inventory`.`consignment_stock` SET TAGS ('dbx_subdomain' = 'stock_management');
ALTER TABLE `food_beverage_ecm`.`inventory`.`consignment_stock` ALTER COLUMN `consignment_stock_id` SET TAGS ('dbx_business_glossary_term' = 'Consignment Stock ID');
ALTER TABLE `food_beverage_ecm`.`inventory`.`consignment_stock` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Consignment Partner ID (PARTNER_ID)');
ALTER TABLE `food_beverage_ecm`.`inventory`.`consignment_stock` ALTER COLUMN `raw_material_id` SET TAGS ('dbx_business_glossary_term' = 'Material ID (MATERIAL_ID)');
ALTER TABLE `food_beverage_ecm`.`inventory`.`consignment_stock` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `food_beverage_ecm`.`inventory`.`consignment_stock` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`inventory`.`consignment_stock` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `food_beverage_ecm`.`inventory`.`consignment_stock` ALTER COLUMN `product_registration_id` SET TAGS ('dbx_business_glossary_term' = 'Product Registration Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`inventory`.`consignment_stock` ALTER COLUMN `stock_position_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Position Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`inventory`.`consignment_stock` ALTER COLUMN `storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'Consignment Location ID (LOCATION_ID)');
ALTER TABLE `food_beverage_ecm`.`inventory`.`consignment_stock` ALTER COLUMN `consignment_agreement_number` SET TAGS ('dbx_business_glossary_term' = 'Consignment Agreement Number (AGMT_NO)');
ALTER TABLE `food_beverage_ecm`.`inventory`.`consignment_stock` ALTER COLUMN `consignment_quantity` SET TAGS ('dbx_business_glossary_term' = 'Consignment Quantity on Hand (QTY_ON_HAND)');
ALTER TABLE `food_beverage_ecm`.`inventory`.`consignment_stock` ALTER COLUMN `consignment_stock_status` SET TAGS ('dbx_business_glossary_term' = 'Consignment Status (STATUS)');
ALTER TABLE `food_beverage_ecm`.`inventory`.`consignment_stock` ALTER COLUMN `consignment_stock_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|closed|pending');
ALTER TABLE `food_beverage_ecm`.`inventory`.`consignment_stock` ALTER COLUMN `consignment_type` SET TAGS ('dbx_business_glossary_term' = 'Consignment Type (VMI/DSD/Standard)');
ALTER TABLE `food_beverage_ecm`.`inventory`.`consignment_stock` ALTER COLUMN `consignment_type` SET TAGS ('dbx_value_regex' = 'VMI|DSD|Standard');
ALTER TABLE `food_beverage_ecm`.`inventory`.`consignment_stock` ALTER COLUMN `consumption_to_date` SET TAGS ('dbx_business_glossary_term' = 'Quantity Consumed To Date (CONSUMED_QTY)');
ALTER TABLE `food_beverage_ecm`.`inventory`.`consignment_stock` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `food_beverage_ecm`.`inventory`.`consignment_stock` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `food_beverage_ecm`.`inventory`.`consignment_stock` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date (EFFECTIVE_FROM)');
ALTER TABLE `food_beverage_ecm`.`inventory`.`consignment_stock` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date (EFFECTIVE_UNTIL)');
ALTER TABLE `food_beverage_ecm`.`inventory`.`consignment_stock` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date (EXPIRY_DATE)');
ALTER TABLE `food_beverage_ecm`.`inventory`.`consignment_stock` ALTER COLUMN `fefo_flag` SET TAGS ('dbx_business_glossary_term' = 'FEFO Management Flag (FEFO_FLAG)');
ALTER TABLE `food_beverage_ecm`.`inventory`.`consignment_stock` ALTER COLUMN `fifo_flag` SET TAGS ('dbx_business_glossary_term' = 'FIFO Management Flag (FIFO_FLAG)');
ALTER TABLE `food_beverage_ecm`.`inventory`.`consignment_stock` ALTER COLUMN `last_consumption_date` SET TAGS ('dbx_business_glossary_term' = 'Last Consumption Date');
ALTER TABLE `food_beverage_ecm`.`inventory`.`consignment_stock` ALTER COLUMN `last_replenishment_date` SET TAGS ('dbx_business_glossary_term' = 'Last Replenishment Date');
ALTER TABLE `food_beverage_ecm`.`inventory`.`consignment_stock` ALTER COLUMN `location_type` SET TAGS ('dbx_business_glossary_term' = 'Consignment Location Type (STORE/WAREHOUSE/DC/3PL)');
ALTER TABLE `food_beverage_ecm`.`inventory`.`consignment_stock` ALTER COLUMN `location_type` SET TAGS ('dbx_value_regex' = 'store|warehouse|distribution_center|3pl');
ALTER TABLE `food_beverage_ecm`.`inventory`.`consignment_stock` ALTER COLUMN `material_description` SET TAGS ('dbx_business_glossary_term' = 'Material Description');
ALTER TABLE `food_beverage_ecm`.`inventory`.`consignment_stock` ALTER COLUMN `max_temperature_c` SET TAGS ('dbx_business_glossary_term' = 'Maximum Temperature (°C) (MAX_TEMP_C)');
ALTER TABLE `food_beverage_ecm`.`inventory`.`consignment_stock` ALTER COLUMN `min_temperature_c` SET TAGS ('dbx_business_glossary_term' = 'Minimum Temperature (°C) (MIN_TEMP_C)');
ALTER TABLE `food_beverage_ecm`.`inventory`.`consignment_stock` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modification Timestamp');
ALTER TABLE `food_beverage_ecm`.`inventory`.`consignment_stock` ALTER COLUMN `next_replenishment_date` SET TAGS ('dbx_business_glossary_term' = 'Next Replenishment Date');
ALTER TABLE `food_beverage_ecm`.`inventory`.`consignment_stock` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Additional Notes');
ALTER TABLE `food_beverage_ecm`.`inventory`.`consignment_stock` ALTER COLUMN `partner_name` SET TAGS ('dbx_business_glossary_term' = 'Consignment Partner Name');
ALTER TABLE `food_beverage_ecm`.`inventory`.`consignment_stock` ALTER COLUMN `partner_type` SET TAGS ('dbx_business_glossary_term' = 'Consignment Partner Type (RET/FOODSERVICE/DIST/WHL)');
ALTER TABLE `food_beverage_ecm`.`inventory`.`consignment_stock` ALTER COLUMN `partner_type` SET TAGS ('dbx_value_regex' = 'retailer|foodservice|distributor|wholesale');
ALTER TABLE `food_beverage_ecm`.`inventory`.`consignment_stock` ALTER COLUMN `replenishment_quantity` SET TAGS ('dbx_business_glossary_term' = 'Replenishment Quantity (REPLENISH_QTY)');
ALTER TABLE `food_beverage_ecm`.`inventory`.`consignment_stock` ALTER COLUMN `replenishment_trigger_quantity` SET TAGS ('dbx_business_glossary_term' = 'Replenishment Trigger Quantity (REPLENISH_TRIGGER_QTY)');
ALTER TABLE `food_beverage_ecm`.`inventory`.`consignment_stock` ALTER COLUMN `settlement_cycle` SET TAGS ('dbx_business_glossary_term' = 'Settlement Cycle (SETTLEMENT_CYCLE)');
ALTER TABLE `food_beverage_ecm`.`inventory`.`consignment_stock` ALTER COLUMN `settlement_cycle` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|per_transaction');
ALTER TABLE `food_beverage_ecm`.`inventory`.`consignment_stock` ALTER COLUMN `settlement_terms` SET TAGS ('dbx_business_glossary_term' = 'Settlement Terms Description');
ALTER TABLE `food_beverage_ecm`.`inventory`.`consignment_stock` ALTER COLUMN `shelf_life_remaining_days` SET TAGS ('dbx_business_glossary_term' = 'Shelf Life Remaining Days (SHELF_LIFE_DAYS)');
ALTER TABLE `food_beverage_ecm`.`inventory`.`consignment_stock` ALTER COLUMN `stock_valuation_amount` SET TAGS ('dbx_business_glossary_term' = 'Stock Valuation Amount (VAL_AMT)');
ALTER TABLE `food_beverage_ecm`.`inventory`.`consignment_stock` ALTER COLUMN `temperature_controlled_flag` SET TAGS ('dbx_business_glossary_term' = 'Temperature Controlled Flag (TEMP_CTRL_FLAG)');
ALTER TABLE `food_beverage_ecm`.`inventory`.`consignment_stock` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `food_beverage_ecm`.`inventory`.`consignment_stock` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'EA|KG|L|ML|CASE|PACK');
ALTER TABLE `food_beverage_ecm`.`inventory`.`reservation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `food_beverage_ecm`.`inventory`.`reservation` SET TAGS ('dbx_subdomain' = 'stock_management');
ALTER TABLE `food_beverage_ecm`.`inventory`.`reservation` ALTER COLUMN `reservation_id` SET TAGS ('dbx_business_glossary_term' = 'Reservation Identifier');
ALTER TABLE `food_beverage_ecm`.`inventory`.`reservation` ALTER COLUMN `center_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Center Identifier (DISTRIBUTION_CENTER_ID)');
ALTER TABLE `food_beverage_ecm`.`inventory`.`reservation` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Identifier (COST_CENTER_ID)');
ALTER TABLE `food_beverage_ecm`.`inventory`.`reservation` ALTER COLUMN `raw_material_id` SET TAGS ('dbx_business_glossary_term' = 'Material Identifier (MATERIAL_ID)');
ALTER TABLE `food_beverage_ecm`.`inventory`.`reservation` ALTER COLUMN `order_id` SET TAGS ('dbx_business_glossary_term' = 'Order Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`inventory`.`reservation` ALTER COLUMN `price_list_line_id` SET TAGS ('dbx_business_glossary_term' = 'Price List Line Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`inventory`.`reservation` ALTER COLUMN `rd_project_id` SET TAGS ('dbx_business_glossary_term' = 'Rd Project Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`inventory`.`reservation` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User Identifier (CREATED_BY_USER_ID)');
ALTER TABLE `food_beverage_ecm`.`inventory`.`reservation` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`inventory`.`reservation` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `food_beverage_ecm`.`inventory`.`reservation` ALTER COLUMN `reservation_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By User Identifier (APPROVED_BY_USER_ID)');
ALTER TABLE `food_beverage_ecm`.`inventory`.`reservation` ALTER COLUMN `reservation_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`inventory`.`reservation` ALTER COLUMN `reservation_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `food_beverage_ecm`.`inventory`.`reservation` ALTER COLUMN `reservation_modified_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Modified By User Identifier (MODIFIED_BY_USER_ID)');
ALTER TABLE `food_beverage_ecm`.`inventory`.`reservation` ALTER COLUMN `reservation_modified_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`inventory`.`reservation` ALTER COLUMN `reservation_modified_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
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
ALTER TABLE `food_beverage_ecm`.`inventory`.`shelf_life_monitor` SET TAGS ('dbx_data_type' = 'Master');
ALTER TABLE `food_beverage_ecm`.`inventory`.`shelf_life_monitor` SET TAGS ('dbx_subdomain' = 'stock_management');
ALTER TABLE `food_beverage_ecm`.`inventory`.`shelf_life_monitor` ALTER COLUMN `shelf_life_monitor_id` SET TAGS ('dbx_business_glossary_term' = 'Shelf Life Monitor ID');
ALTER TABLE `food_beverage_ecm`.`inventory`.`shelf_life_monitor` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `food_beverage_ecm`.`inventory`.`shelf_life_monitor` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `food_beverage_ecm`.`inventory`.`shelf_life_monitor` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `food_beverage_ecm`.`inventory`.`shelf_life_monitor` ALTER COLUMN `product_registration_id` SET TAGS ('dbx_business_glossary_term' = 'Product Registration Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`inventory`.`shelf_life_monitor` ALTER COLUMN `stock_position_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Position Id (Foreign Key)');
ALTER TABLE `food_beverage_ecm`.`inventory`.`shelf_life_monitor` ALTER COLUMN `storage_location_id` SET TAGS ('dbx_business_glossary_term' = 'Location ID');
ALTER TABLE `food_beverage_ecm`.`inventory`.`shelf_life_monitor` ALTER COLUMN `original_shelf_life_monitor_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `food_beverage_ecm`.`inventory`.`shelf_life_monitor` ALTER COLUMN `alert_flag` SET TAGS ('dbx_business_glossary_term' = 'Alert Flag');
ALTER TABLE `food_beverage_ecm`.`inventory`.`shelf_life_monitor` ALTER COLUMN `alert_generated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Alert Generated Timestamp');
ALTER TABLE `food_beverage_ecm`.`inventory`.`shelf_life_monitor` ALTER COLUMN `alert_threshold_days` SET TAGS ('dbx_business_glossary_term' = 'Alert Threshold (Days)');
ALTER TABLE `food_beverage_ecm`.`inventory`.`shelf_life_monitor` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `food_beverage_ecm`.`inventory`.`shelf_life_monitor` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending');
ALTER TABLE `food_beverage_ecm`.`inventory`.`shelf_life_monitor` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `food_beverage_ecm`.`inventory`.`shelf_life_monitor` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `food_beverage_ecm`.`inventory`.`shelf_life_monitor` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|EUR|GBP|CAD|JPY|AUD');
ALTER TABLE `food_beverage_ecm`.`inventory`.`shelf_life_monitor` ALTER COLUMN `event_type` SET TAGS ('dbx_business_glossary_term' = 'Event Type');
ALTER TABLE `food_beverage_ecm`.`inventory`.`shelf_life_monitor` ALTER COLUMN `event_type` SET TAGS ('dbx_value_regex' = 'shelf_life_update|expiry_alert|stock_movement');
ALTER TABLE `food_beverage_ecm`.`inventory`.`shelf_life_monitor` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `food_beverage_ecm`.`inventory`.`shelf_life_monitor` ALTER COLUMN `expiry_status` SET TAGS ('dbx_business_glossary_term' = 'Expiry Status');
ALTER TABLE `food_beverage_ecm`.`inventory`.`shelf_life_monitor` ALTER COLUMN `expiry_status` SET TAGS ('dbx_value_regex' = 'valid|expiring_soon|expired|unknown');
ALTER TABLE `food_beverage_ecm`.`inventory`.`shelf_life_monitor` ALTER COLUMN `gtin` SET TAGS ('dbx_business_glossary_term' = 'Global Trade Item Number (GTIN)');
ALTER TABLE `food_beverage_ecm`.`inventory`.`shelf_life_monitor` ALTER COLUMN `last_movement_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Movement Timestamp');
ALTER TABLE `food_beverage_ecm`.`inventory`.`shelf_life_monitor` ALTER COLUMN `location_code` SET TAGS ('dbx_business_glossary_term' = 'Location Code');
ALTER TABLE `food_beverage_ecm`.`inventory`.`shelf_life_monitor` ALTER COLUMN `max_temperature_c` SET TAGS ('dbx_business_glossary_term' = 'Maximum Temperature (°C)');
ALTER TABLE `food_beverage_ecm`.`inventory`.`shelf_life_monitor` ALTER COLUMN `min_temperature_c` SET TAGS ('dbx_business_glossary_term' = 'Minimum Temperature (°C)');
ALTER TABLE `food_beverage_ecm`.`inventory`.`shelf_life_monitor` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `food_beverage_ecm`.`inventory`.`shelf_life_monitor` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `food_beverage_ecm`.`inventory`.`shelf_life_monitor` ALTER COLUMN `observation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Observation Timestamp');
ALTER TABLE `food_beverage_ecm`.`inventory`.`shelf_life_monitor` ALTER COLUMN `product_name` SET TAGS ('dbx_business_glossary_term' = 'Product Name');
ALTER TABLE `food_beverage_ecm`.`inventory`.`shelf_life_monitor` ALTER COLUMN `production_date` SET TAGS ('dbx_business_glossary_term' = 'Production Date');
ALTER TABLE `food_beverage_ecm`.`inventory`.`shelf_life_monitor` ALTER COLUMN `quality_status` SET TAGS ('dbx_business_glossary_term' = 'Quality Status');
ALTER TABLE `food_beverage_ecm`.`inventory`.`shelf_life_monitor` ALTER COLUMN `quality_status` SET TAGS ('dbx_value_regex' = 'passed|failed|pending|hold');
ALTER TABLE `food_beverage_ecm`.`inventory`.`shelf_life_monitor` ALTER COLUMN `quantity_on_hand` SET TAGS ('dbx_business_glossary_term' = 'Quantity On Hand');
ALTER TABLE `food_beverage_ecm`.`inventory`.`shelf_life_monitor` ALTER COLUMN `recall_flag` SET TAGS ('dbx_business_glossary_term' = 'Recall Flag');
ALTER TABLE `food_beverage_ecm`.`inventory`.`shelf_life_monitor` ALTER COLUMN `receipt_date` SET TAGS ('dbx_business_glossary_term' = 'Receipt Date');
ALTER TABLE `food_beverage_ecm`.`inventory`.`shelf_life_monitor` ALTER COLUMN `remaining_shelf_life_days` SET TAGS ('dbx_business_glossary_term' = 'Remaining Shelf Life (Days)');
ALTER TABLE `food_beverage_ecm`.`inventory`.`shelf_life_monitor` ALTER COLUMN `shelf_life_days` SET TAGS ('dbx_business_glossary_term' = 'Shelf Life (Days)');
ALTER TABLE `food_beverage_ecm`.`inventory`.`shelf_life_monitor` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `food_beverage_ecm`.`inventory`.`shelf_life_monitor` ALTER COLUMN `temperature_controlled_flag` SET TAGS ('dbx_business_glossary_term' = 'Temperature Controlled Flag');
ALTER TABLE `food_beverage_ecm`.`inventory`.`shelf_life_monitor` ALTER COLUMN `unit_cost` SET TAGS ('dbx_business_glossary_term' = 'Unit Cost');
ALTER TABLE `food_beverage_ecm`.`inventory`.`shelf_life_monitor` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `food_beverage_ecm`.`inventory`.`shelf_life_monitor` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'kg|lb|pcs|ltr|gal');
ALTER TABLE `food_beverage_ecm`.`inventory`.`shelf_life_monitor` ALTER COLUMN `valuation_amount` SET TAGS ('dbx_business_glossary_term' = 'Valuation Amount');
